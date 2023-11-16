Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E118DC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B4F874FF;
	Thu, 16 Nov 2023 17:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="haLBr+DJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2AF874FD; Thu, 16 Nov 2023 17:52:38 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD7C874D8
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50a93c5647cso1423221e87.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700153553; x=1700758353;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=b/zs7f/YNnoTTjTjV0fng3FYNcaW5Y3OZ+EnDYmL1Q0=;
 b=haLBr+DJyavHSo8a3eGmQgxoSorhjhLdxk6G2281g8qYXjF+jbw8ukMICjIBeALASK
 j4e4QnuAWwkBw1PY3HxaDvA2w8t3gU4mrk+BDl98+XFT4/OBQDlD2ZPoL6a/wsnXVH6f
 wSlE+oOAY9e8ophmr7u+Q5fXO0upUTm76bc5ORCBdKZqCakhaBEaQYh3lJmA5/lj/5M5
 FulJB0v4S2mK0YoizCs8dSP+n935TjyEPQchc2uTHGgfCyV8M6JWV9g0mxrDLlsg1vWd
 sBY5VPAGpyk9dRlLkMmESmlO0FjwkgMZihRgdzcUsI3W2PDUHjCp9c2Sox7Fa2tl3rCW
 hKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153553; x=1700758353;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b/zs7f/YNnoTTjTjV0fng3FYNcaW5Y3OZ+EnDYmL1Q0=;
 b=L2sa0InOkb7+didnzNOnpdgn1IapnMwCxN33lADNB0K6jpwQueO7lBihB4g3lZBHrM
 KKSthg4ZNkZEHspvBw8Oi/Kukqw1tIx+dtaLN6AKgsf5RAs6yLCxb89qRZ9ivNFym/YZ
 Qr4FLezm8duTQWGoaDixhXo317IiOHiBL+gg70dhSVsHzEu8flBuWOws1HtUDCI+KYyF
 ToL+hj6Yl/fFBqi0gy0VtHOi/RkAL6hMRrY/Qf6zqXUMpUyc9gUhd3pTtFRj8nGwOGqp
 henCLnrVZb6iBf0FRYoDlRGpD4qUaZhhWltnuC8WvDAbSD1UzXQm8dVhoeeYXF4izqol
 GRGg==
X-Gm-Message-State: AOJu0YwSzWP23GRA+lm2uTN2KNrZvvGlTtpvzbtLLIbJqykzBjOkOSKd
 XdDev0wlg1xFbhtrGuoDYmDk54avckrkHG2fEYrTyg==
X-Google-Smtp-Source: AGHT+IGyxKL1H5VTWVYISZF+XDUyzKXeQIlxICu95QSd3dVvgwbhYmoxuRrj0uwwHzvO8lNyCBq1jg==
X-Received: by 2002:ac2:5e24:0:b0:503:3707:66ed with SMTP id
 o4-20020ac25e24000000b00503370766edmr10504704lfg.34.1700153553652; 
 Thu, 16 Nov 2023 08:52:33 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 i9-20020aa7c709000000b00540e934bf8dsm7939388edq.43.2023.11.16.08.52.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 08:52:33 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso1562014a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:52:33 -0800 (PST)
X-Received: by 2002:a05:6402:1859:b0:53e:1f7d:10f2 with SMTP id
 v25-20020a056402185900b0053e1f7d10f2mr13755454edy.10.1700153552987; Thu, 16
 Nov 2023 08:52:32 -0800 (PST)
MIME-Version: 1.0
From: Shantur Rathore <i@shantur.com>
Date: Thu, 16 Nov 2023 16:52:22 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
Message-ID: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
Subject: bootstd: Support for distro specific EFI folders
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
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

Hi Simon,

Currently bootstd - bootmethod_efi only looks for the default
bootxx64.efi in /EFI/boot folder only.
Generally many distros end up putting their bootloaders in
EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.

In x86 worlds, the NVRAM is modified and new boot entries are added to
support these but in the U-boot world the NVRAM variables are
read-only.

What would be the best way to implement this?

I was thinking of having a "efi_prefixes" environment variable which
can be set to "ubuntu debian centos" etc and bootmethod_efi can try
all of them. Will bootmethod_efi be able to support multiple entries (
thinking of multiboot ) ?

Regards,
Shantur
