Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D3BC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E37A878D7;
	Tue, 26 Dec 2023 10:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="flObo6lQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2944B8788C; Tue, 26 Dec 2023 10:48:43 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80638794B
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28659348677so2740724a91.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584119; x=1704188919; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nr0enw27brloxz78oAiemhcUl+VjVu6N0A8ORp4s++4=;
 b=flObo6lQpBWmi4VLyroRg/9Mw14/R9UNoFwNh735s3AbZERMPutUM18FlZRihL15R6
 8Q8T14p7cYOR8OroO2G0kPeBKEPKZmGumAK8lCJrVruoFbh1MzJOLVxQShmuts+lFJbN
 4KL4LFh0NWrfk51zMq7pItTYqiAimxEV+jCBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584119; x=1704188919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nr0enw27brloxz78oAiemhcUl+VjVu6N0A8ORp4s++4=;
 b=p37O6jgUd5TyuQ5u5Kf/za8S4Xxm/oz2qi+hST+S2fyuBu/Bz2njPMz5b30Ru3cnUl
 pTEbMiZbvlBeT+plyX5k57m0l2f/sv7x+ZKHUkPHTXYM9MjtGqI89cZdemSpuJweLV60
 3jRyA7WSr9jK6YIrZ4dj9nO9e9ZD/PC/d9HSvhk4UIbtvk2R6g+TQTD0HUPINjvwbbHA
 8M3K+0gEkUZcZr05KZJyqy2pMePGIVfAsDlgXmXX5B886pB9XZBHUNEYjmje1z7awtjB
 ODHPTL0lnlQRIBF2NaV+kp8+lQPi7a6d78XtkIOEwq+uSPvXQgoK94UTuI4Vp5p9QXo9
 jSPA==
X-Gm-Message-State: AOJu0YwlbxtPDqOaicyAdmJcoFuRwnMWj/rjzOmUnyhyptWhmd4gEjEF
 t4O1Xah/Oa+897EOudS0yVL7O/P3ELQyG1Vd5HJTQDzwIpdp
X-Google-Smtp-Source: AGHT+IF3fY853YDbB/bcORY++ya42TZvl69gKKB9AYjpuMcN+CiAmYcwufmzL8B6rMzCp+TtF2ttgNjYXoyLuA3tzFQ=
X-Received: by 2002:a17:90a:928e:b0:28b:e9c1:b81d with SMTP id
 n14-20020a17090a928e00b0028be9c1b81dmr8931383pjo.26.1703584119027; Tue, 26
 Dec 2023 01:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20231221072611.11479-1-ada@thorsis.com>
 <20231221072611.11479-3-ada@thorsis.com>
In-Reply-To: <20231221072611.11479-3-ada@thorsis.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:48 +0000
Message-ID: <CAFLszTjb0YQmUpZrm3y+vZ+Xcno=M_N8juyYvOJLV0qj0mkbpw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tools: fix build without LIBCRYPTO support
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Terry Lv <terry.lv@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 21, 2023 at 7:26=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wr=
ote:
>
> From: Paul-Erwan Rio <paulerwan.rio@gmail.com>
>
> Commit cb9faa6f98ae ("tools: Use a single target-independent config to
> enable OpenSSL") introduced a target-independent configuration to build
> crypto features in host tools.
>
> But since commit 2c21256b27d7 ("hash: Use Kconfig to enable hashing in
> host tools and SPL") the build without OpenSSL is broken, due to FIT
> signature/encryption features. Add missing conditional compilation
> tokens to fix this.
>
> Signed-off-by: Paul-Erwan Rio <paulerwan.rio@gmail.com>
> Tested-by: Alexander Dahl <ada@thorsis.com>
> Cc: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> Notes:
>     Added another guard around the header includes and slightly reworded =
the
>     commit message.  Otherwise it's the same patch as before, so I kept t=
he
>     author as is and only added my Tested-by:
>     I removed the Reviewed-by: from Simon from this patch, because of the
>     changes mentioned and because the patch was based on an U-Boot three =
or
>     four releases ago.
>
>     v1 -> v2:
>     * collected tags
>
>  include/image.h    | 2 +-
>  tools/Kconfig      | 1 +
>  tools/fit_image.c  | 2 +-
>  tools/image-host.c | 4 ++++
>  tools/mkimage.c    | 5 +++--
>  5 files changed, 10 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
