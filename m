Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ADFE8FDC5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1108747E;
	Wed,  4 Oct 2023 04:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ci5i6qmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57C287496; Wed,  4 Oct 2023 04:12:25 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7409B87272
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59c268676a9so19787407b3.0
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385540; x=1696990340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WjuknvklAAMe2mZ4wLk/UTOMbr2YFjkBOH2Ppa7jgOs=;
 b=ci5i6qmQFMvWdSCOiMXQJBq5POJbZ9wBTVMuw6S0gjmjQSVOJ1kDSbuYp4oZRUUXQ3
 01EFDJXDZAyqPb/wtXt3shVIGejKLt9IT4tpVrI76Uidkh3zjFBS5D/yzfLv1/4OU7gQ
 +KO+gg1HhZ9mMJ8KkMLQhfooW60lXXEgl+CM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385540; x=1696990340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WjuknvklAAMe2mZ4wLk/UTOMbr2YFjkBOH2Ppa7jgOs=;
 b=eY/Zthm1E04KNgI6VaBV9MMwHZOt3fEXyLOM6lMKOksjxEe26MVpgIiKrP8vXwRy1j
 1t5InkWDUcOZJIIb5OBPMOWCBOm0TF+6x6zsqfgVOYgcNFPcOfULnAxXVz3LU7HxWPCo
 OaG77Su5ZuG0VeMWQaa7qEocP6DX1qhOuRGTjfR5kz7jE6BXpfMTfEA8wZhY5hQ9MAvb
 U5wwf9nRqHteXQQHVyPLlF+OMTeJYfyZVNM6hQT1gV/OVqqE9E6SZSelzCDNUc9+q78T
 2wwPm1G62YmTs5IrxN3qX/zWv0/gXwl8VsdovWE4WjSvv4TXR/qO1QFqqVEa/QbUzOX1
 Zt1A==
X-Gm-Message-State: AOJu0Yzmu/sRKB1VjRTZIKWu951QT2HsUjOILeL+0kR6L+evaoDhKP3G
 fBqBzWMa82+e+GOec8b4s2kMqkQEcx4dM74xdSpfp6TOJmay9IQG42U=
X-Google-Smtp-Source: AGHT+IFk3Xxm3kpKvw5THmUrVeyaXwUIfHp7YYpSFOS5V4WuXt7WUYbLNbXpUg96CFrxclfb+jDU+Xuoxt9cgZr/ZcM=
X-Received: by 2002:a81:80c7:0:b0:59b:eba:f94b with SMTP id
 q190-20020a8180c7000000b0059b0ebaf94bmr1354772ywf.40.1696385540452; Tue, 03
 Oct 2023 19:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231002080014.1861669-1-lars@bitbiz.be>
 <20231002080014.1861669-2-lars@bitbiz.be>
In-Reply-To: <20231002080014.1861669-2-lars@bitbiz.be>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:11:09 -0600
Message-ID: <CAPnjgZ1fFntmrZ_3Ziec6MQbP+qE1NW8Uhj73gi32WGzBbzrEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mkimage: allow internalization of data-position
To: lars@bitbiz.be
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Massimo Pegorer <massimo.pegorer@vimar.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 2 Oct 2023 at 02:01, Lars Feyaerts <lars@bitbiz.be> wrote:
>
> Make it possible for data that was externalized using a static external
> position (-p) to be internalized. Enables the ability to convert
> existing FIT images built with -p to be converted to a FIT image where the
> data is internal, to be converted to a FIT image where the data is
> external relative to the end of the FIT (-E) or change the initial
> static external position to a different static external position (-p).
>
> Removing the original external-data-related properties ensures that
> they're not present after conversion. Without this, they would still be
> present in the resulting FIT even if the FIT has been, for example,
> internalized.
>
> Signed-off-by: Lars Feyaerts <lars@bitbiz.be>
> ---
>
>  doc/mkimage.1     | 19 +++++++++++++++++++
>  tools/fit_image.c | 26 +++++++++++++++++++++-----
>  2 files changed, 40 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
