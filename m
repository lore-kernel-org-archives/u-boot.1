Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4420ECF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A398689012;
	Wed,  9 Oct 2024 03:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OSFw9w4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0797489025; Wed,  9 Oct 2024 03:51:11 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B96189012
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cb2f272f8bso55020016d6.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438666; x=1729043466; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MJYv1BqnsJzjA5MLBvxk8sQoiXEXfZ1sPs6K/2t+Hbs=;
 b=OSFw9w4y94q/710QgZPMnehk1UnwAtxAP3aqNJ/7ZPc5jQ+egqBUFd2wwLf5cEFfmV
 ZeRPrOwHQxuPfjxVYOC34C+JCxQpJsKzymGBXwC/KRto1tDylaFoUgACEI283JgfB2wf
 ED/fKVxzskizh+kXBKdtsKK51TdL5CTftNEHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438666; x=1729043466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJYv1BqnsJzjA5MLBvxk8sQoiXEXfZ1sPs6K/2t+Hbs=;
 b=e3yQcJKI3Uu7a0EyBURUemX20PVCrRZt5SMU9XtQ0QqSKa05WkaAQDjAVPtvWFXtNd
 3KtCEiTB+WfcnW9XZ5UyRdjSZJT2SKxIBZzw2ez4Jz46M4Pd9B+kI/06KsHCRn3s71Ah
 HGoyhI2JJmjz3Ju6yQ8L350nhhnR9n0Rz3L7bJAnJDVd6vZmOdVyzADpbYh06M+oDXST
 PPTU9RakQq35o7psPMInfHPr83maQXFUPf0TgsXFILn/kEnOwMKJ1zbhUr+Fw4c2uBZT
 62sImci2juE+R/6n4deadq3r9MR9xLY8sWEC9A2DJSwl9wV7BBBrRpnpj2HwRTpJArpx
 PGqg==
X-Gm-Message-State: AOJu0YzlH62e2inb3OstYLv3Gzc7a4aJVUAE+5zQzYQuXRtsMOOslj5f
 rzgEyXyq1rRY40SAgjcY63AJchKMmcnJIH7so4j8umVYzILsU3/Lc2t4pZb9L7xi838OJdNdjhc
 JuTy/hGdNN1JoA/+nluf4CckRG0LwKOc4eJVe
X-Google-Smtp-Source: AGHT+IH2BTNXZM6zpO6FT5GPWlvKyJtEfgM9rT4Zr1xvcUB/TSmiYWX8EItVi5vNinM9chz8EeIaRiWhm6cp0gciHKM=
X-Received: by 2002:a05:6214:4697:b0:6cb:84a3:e4bd with SMTP id
 6a1803df08f44-6cbc92af7ecmr21091506d6.6.1728438666194; Tue, 08 Oct 2024
 18:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240916082446.32082-1-al.kochet@gmail.com>
 <20240916082446.32082-4-al.kochet@gmail.com>
In-Reply-To: <20240916082446.32082-4-al.kochet@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:50:55 -0600
Message-ID: <CAFLszTiwHSjS_U895=5o4Utino+ofDxd_-U4z8yaT6hNpJLJxw@mail.gmail.com>
Subject: Re: [PATCH 3/3] binman: implement signing FIT images during image
 build
To: al.kochet@gmail.com
Cc: u-boot@lists.denx.de
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

On Mon, 16 Sept 2024 at 02:25, <al.kochet@gmail.com> wrote:
>
> From: Alexander Kochetkov <al.kochet@gmail.com>
>
> The patch implement new property 'fit,sign' that can be declared
> at the top-level 'fit' node. If that option is declared, fit tryies
> to detect private keys directory among binman include directories.
> That directory than passed to mkimage using '-k' flag and that enable
> signing of FIT.
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  tools/binman/btool/mkimage.py           |  5 +-
>  tools/binman/entries.rst                |  7 ++
>  tools/binman/etype/fit.py               | 51 +++++++++++++
>  tools/binman/ftest.py                   | 95 ++++++++++++++++++++++++
>  tools/binman/test/326_fit_signature.dts | 98 +++++++++++++++++++++++++
>  tools/binman/test/326_rsa2048.key       | 28 +++++++
>  tools/binman/test/327_fit_signature.dts | 98 +++++++++++++++++++++++++
>  tools/binman/test/328_fit_signature.dts | 61 +++++++++++++++
>  8 files changed, 442 insertions(+), 1 deletion(-)
>  create mode 100644 tools/binman/test/326_fit_signature.dts
>  create mode 100644 tools/binman/test/326_rsa2048.key
>  create mode 100644 tools/binman/test/327_fit_signature.dts
>  create mode 100644 tools/binman/test/328_fit_signature.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Nice
