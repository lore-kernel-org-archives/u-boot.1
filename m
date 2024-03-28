Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E852C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E4F87EDD;
	Thu, 28 Mar 2024 13:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ccaesXYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DAC488146; Thu, 28 Mar 2024 13:18:56 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7E587EAF
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29df844539bso260224a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711628333; x=1712233133; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GX5famJQ+azUGPNugNhPeUfYlVFpsDWpWXhuP+iHzWY=;
 b=ccaesXYx+GfEw4jXAZzUhLhAQ50AZ9bVhVXChNndPK9pvMEfVq8XhKGlH5LLV4SXLo
 I1jL0j0vuatt8Kv+PJTrGuyyEA6jIj5NHVjl89agp8kLIV3pI/DprvEQLOBm8HmKLgIw
 wxFXF6IZ+JNb0bEnRC+VhQ5TPk4j+W7aKqrZDFBkw3B/k9QvtICBzdVOrzS0ioYisM+h
 rbFB2Tfct8gfw1aAL270V181phAf2jUF0PPVBVSvd6py2K+EMpJl3Z4Hlps5yMlS2f1k
 gd/cyAMVbr13Ijf49Sjn4f+HiyvKD60jiGS4MgvvQg0+d+KchSw5YNKnGrRrG5y9J0kt
 d1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711628333; x=1712233133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GX5famJQ+azUGPNugNhPeUfYlVFpsDWpWXhuP+iHzWY=;
 b=PuuZOJlXOoW2/AmH1qNemtPr4KLA/p3+2rC5YlQux2ACPoV1kMVHWZzfrjs33ZWikd
 vvF3pkchnHejtTaZ4GpfsJh6s60vefdIMGKhYlwwAWnIVGzkZ4LpItDRggAQTUatRxDk
 zXo/YLu3JvhEW5xmCUzgqULFye8RU/1hSwv/YcBE30uh1H9FQIqb5e1/NiNdjykhturY
 A+eEB90cn/9q70Y4wtfRUaxkT3+1a92R+y5+vA60lI2ui5TMlCTk8BfEKNavForcYh0b
 ZuNHqCOkWYUdzsUYPe0gVuNyhRTZh3sh+MGEe2VLZfer4jxQfmSkZSpYlebAL6yf18xz
 Utiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIIpQXEjdPvMS+F1VfjM8BYR4fqN+HoYxpBR5Ri6LSKjLn4f8NSu04cM3LNz9l2Gx/wafR4aYxj6OA7YTHvXJH6pj3jg==
X-Gm-Message-State: AOJu0YwUA7ge+LQ5ENbJZrqcrGP+ws7QBll6m8CKI4a8+2xohiQPYVt5
 ZpnfLXJCYoJIzQGLCIoeNHWHViRrKkc5B1GVNx4FAuz3KyM3vK1t7tAL3E5YVNEBkIx7zq5aoqF
 QwiDZSn9dKfStcCX+nzlA7n2CNz0=
X-Google-Smtp-Source: AGHT+IH1aMV4re4HRz0LeMnx/0iGN3XmRKEkPfCzqN9pGZMy4/UL4ylDGlYsb+WbBJFY77b7T2ie+Gjxja69J+8JLlg=
X-Received: by 2002:a17:90b:b0f:b0:2a2:e98:83c with SMTP id
 bf15-20020a17090b0b0f00b002a20e98083cmr32215pjb.3.1711628332780; Thu, 28 Mar
 2024 05:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240328102049.10108d5b@wsk>
In-Reply-To: <20240328102049.10108d5b@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Mar 2024 09:18:40 -0300
Message-ID: <CAOMZO5CKc_CGgzu3Xhba-FKN1svJt9V2if6yv3_sP7cjA-rPHg@mail.gmail.com>
Subject: Re: Thoughts about U-boot binary size increase
To: Lukasz Majewski <lukma@denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Stefano Babic <sbabic@denx.de>
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

Hi Lukasz,

On Thu, Mar 28, 2024 at 6:20=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> Dear Community,
>
> I'd like to share with you some thoughts about growth of u-boot's
> binary size for SPL and u-boot proper.
>
> Board: XEA
> SoC  : imx287 (still in active production)
> Problem: SPL size constrained to ~55 KiB (This cannot be exceeded).
>          Board design constraints u-boot proper size to less than ~448
>          KiB
>
>
> When XEA was added (2019.07):
>         - u-boot.sb (SPL): 37 KiB
>         - u-boot.img     : 401 KiB
>
> Now (2024.04):
>         - u-boot.sb (SPL): 40 KiB
>         - u-boot.img     : 427 KiB
>
> (With a _lot_ of effort put to reduce the size)
>
> Hence, the question - would it be possible to take more concern about
> the binary size growth?
>
> Maybe CI could catch patches, which enable by default some features and
> the size is unintentionally increased?
>
> I'm open for any feedback and thoughts on "stopping" the binary size
> increase.

In addition to adding CONFIG_BOARD_SIZE_LIMIT and CONFIG_SPL_SIZE_LIMIT che=
cks,
could you try the change below?

diff --git a/arch/arm/mach-imx/mxs/Kconfig b/arch/arm/mach-imx/mxs/Kconfig
index d2e4205c5ce5..ee8c23d0e04f 100644
--- a/arch/arm/mach-imx/mxs/Kconfig
+++ b/arch/arm/mach-imx/mxs/Kconfig
@@ -32,6 +32,7 @@ if ARCH_MX28

 config MX28
        bool
+       select LTO
        default y

I did a quick imx28_xea_defconfig build test here:

U-Boot mainline
---------------

$ ls -al u-boot.img
-rw-rw-r-- 1 fabio fabio 444128 mar 28 09:11 u-boot.img

$ ls -al spl/u-boot-spl.bin
-rwxrwxr-x 1 fabio fabio 39800 mar 28 09:12 spl/u-boot-spl.bin


U-Boot mainline + LTO
---------------------

$ ls -al u-boot.img
-rw-rw-r-- 1 fabio fabio 424144 mar 28 09:14 u-boot.img

$ ls -al spl/u-boot-spl.bin
-rw-rw-r-- 1 fabio fabio 37664 mar 28 09:14 spl/u-boot-spl.bin
