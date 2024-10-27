Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE63D13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3EDB89034;
	Sun, 27 Oct 2024 18:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JxECAJbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856B089034; Sun, 27 Oct 2024 18:17:34 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5F48839A
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e18293a5efso2432478a91.3
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049442; x=1730654242; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SsXjeWsvrYGy67xv2+u8CN37c+2fgjxdMLYbMNc/Kn0=;
 b=JxECAJbgqtN+4EX9n/6KtL7ylcgImf9ebV8iu5HtphQRSMflpsaIsb4Co+LnQoNGyU
 +aOC/+ujuC3FVnLQ/8UrDMslXdsazXZtApd6VOYhGL5ObI0r+x2IVcSvenN5zCZHBLZU
 XJK0yNKsRie5dS8+qh3XQvDo5qxbziDVVGY+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049442; x=1730654242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SsXjeWsvrYGy67xv2+u8CN37c+2fgjxdMLYbMNc/Kn0=;
 b=sart1LUr24L74O9dhvn//SzrFt3tLyhJH8czZxJEesmV9+B52uLwo+UpeDHEHVyaLr
 FH76AnXZqFWv4xWgn4kuzjeAaj6HFwziru7Z/JwVwkTalfVHFN8JJt3yxwke8swJQOua
 1rrg8dQIm/fsxyMOfuTH/mGIepbvRtEJqdIOIq2ZhlRV9RMMzE5HukZgAQaIfbG9H5fP
 5nHYYgGfjgVKxnJL0KW1GvPfRvB2WCVniqeAvqD1YUMWWkl5ctHcz9J48/IDZVfNZQN7
 IKx8GfN+NUcq7fF3dvpe710vgvHV5ho1KlP7LeFpjR1srNYtbBHyj/LxyrIg7BVn6HWK
 krXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRlfvhqD+3mfieR5yh23iRua00rScSPfWL9zLqm6Kv39EGUHJCWCYwCK9WPP1U4Gq1HYc/4oM=@lists.denx.de
X-Gm-Message-State: AOJu0YxBgX637K7TQz7rv97KIYkS3s6rSg5416PqfNxCKq/pgk2UJu/E
 teF/2mHAU5zqVOuJykMvCYjQk0ElgxIsngpvJ9JFRoLdHOHYWgEUaYKNedGMufClGf/o2PHeRDh
 y0eJKC/GniY5LD17ZpRi5fyaZA+N/VgfjUcHL5/ITwa2eWLlAAg==
X-Google-Smtp-Source: AGHT+IEwDwrx3DPI+y+P+UtF9eCVsQLOV+R4CYXx+gLRRgjPOVclwzEAfZJw7xynrPUT6dSVTY59WZz0ZK9pvM8FLiQ=
X-Received: by 2002:a17:90b:3b89:b0:2e0:a926:19b1 with SMTP id
 98e67ed59e1d1-2e8f11dce3amr7564035a91.38.1730049442560; Sun, 27 Oct 2024
 10:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:49 +0100
Message-ID: <CAFLszTi41hXC2i9+4V+9b-xSW22HDdUkhJRvm5SV6RVi7WoAOQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] fs: ext4: use fs_ls_generic
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Sat, 26 Oct 2024 at 08:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Now that opendir, readir, closedir are implemented for ext4 we can use
> fs_ls_generic() for implementing the ls command.
>
> Adjust the unit tests:
>
> * fs_ls_generic() produces more spaces between file size and name.
> * The ext4 specific message "** Can not find directory. **\n" is not
>   written anymore.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4_common.c               | 29 -----------------------------
>  fs/ext4/ext4fs.c                    | 23 -----------------------
>  fs/fs.c                             |  2 +-
>  test/py/tests/test_env.py           |  2 +-
>  test/py/tests/test_fs/test_basic.py |  5 +----
>  5 files changed, 3 insertions(+), 58 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
