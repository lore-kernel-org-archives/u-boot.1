Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE9DC369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 18:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9758A820EB;
	Tue,  8 Apr 2025 20:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hdwsic9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755CD82102; Tue,  8 Apr 2025 16:48:10 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B5B80107
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aenbacka@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6e8ec399427so46826856d6.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744123687; x=1744728487; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oS2oD+Yu4kgW+pelZ/erLaHxhYHME6+B3JG5vEK9suo=;
 b=Hdwsic9Ym4fOOHnUEcB+S6NwF8n2IqfIlq+p3/9DnmGNkGnATcC9byot3HLFDUK66L
 U5LNBazjI6KfRO1EiiQWc9sAvvtm+ctHcdDgKhdGqUj04AFxtBqgEiHafJW1JOF0l0P6
 vsiVKSBPlA5KN0+8aKDVk7tPajWfHoWOW7732N71Jiv6huWONd/Jx+2JY/h7VjntJwlv
 7e4P5EwQKMorCfazv0x20QlIO/Hr0XVm0vatrbRU00swBOHz9Pa+4/fw6IYMTi78ED2V
 NlLnkzZXeF22kuUujmvxkJ9shrdvFiii19vKJ/a91ZEicRk1p3mdM0BPqWXDsv57ft29
 KzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744123687; x=1744728487;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oS2oD+Yu4kgW+pelZ/erLaHxhYHME6+B3JG5vEK9suo=;
 b=ONeiR5KRx2l1TfYxMk/sbnzPUJ9jaO/RyHNoQUKO/7l/s+uIsrRfRlMs0pN8z0nL2m
 X5HFk1q1K+Awh4EE3Vg674TPpnULheCcSanDJe+OxzQZapVHDTRr4eaDpqwrshY4FcFk
 Tr/bf4S7vzHtvqudCkmOeLe4EMJ52S/Jfy9WbPIu2/xwvoYm5SsigzlxZbM6RpuQ00LN
 7I3/xSuwGLuM5Dr/Lrlqjn4FnxRY9mNSxKTyBNs/Xh8hZPURi+YxjSDe9z3rDcK4Sx/p
 84nMjcrU7wxWfiVgp2H9xoh15WD7Z4YZsVvxM1XTf8ZIEdxp3Lfow4BPyavrv05SzRpk
 ZmEA==
X-Gm-Message-State: AOJu0Yzko7sjWJVeVOk6ItyXZ9C6yoqFvRQcJwueIH2egjkOpBh7Udeo
 cIQvBrk+xQsU6icwaBKOTFWxRoZsUxTDwF7oUniPGGeGgNRzHV/kzIywl2hXAERz6ceYiEvYQRL
 fZO/RUi21PrMEk3D5PjEXcSQAIvQwT5WQ6zg=
X-Gm-Gg: ASbGncuTzaR2w/MkimonlYXfPaXyFBZ7KBhs0FWOeP2w3Lzhn+QIYJDiDwe3OfhGLEZ
 1dHUn30gSHX1HBOiDddk0zSaD+sMRdNaLJWKwz8+L/4EGEu8ydrVrBODY8eYXJ2zxNS7o2Esu7w
 5Qz36C602L6Vt9GMV6x0eWqWAHOQ==
X-Google-Smtp-Source: AGHT+IESh+3TFeXKskdSJTXrEHPdRol8zq+/VUFoMbII+q/qVqJ4r49jDGZqPgg2LqJUSXLhu33IKRLE+9xecG/qmf8=
X-Received: by 2002:a05:6214:f27:b0:6ef:eb:a42 with SMTP id
 6a1803df08f44-6f0b74f697fmr222607786d6.28.1744123686836; Tue, 08 Apr 2025
 07:48:06 -0700 (PDT)
MIME-Version: 1.0
From: Andreas Enbacka <aenbacka@gmail.com>
Date: Tue, 8 Apr 2025 17:47:55 +0300
X-Gm-Features: ATxdqUG1JSdAwpdxKND2p48oHWb-xnGIb_TnGhCU0RgSZWDg9GUi5aKLJdxpwjA
Message-ID: <CAOeqweT0o1-bFHNaoDURGYKGvx4OvqsgRpXwdWArdeGmBrnJyg@mail.gmail.com>
Subject: Issue with booting FIT image using Yocto with raspberry pi cm4
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 08 Apr 2025 20:23:52 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello everyone,

I am working on building a custom image targeting the raspberry pi cm4
using Yocto / meta-raspberrypi (scarthgap release) and u-boot.

The kernel and rootfs booted without issues before switching to using fit
image. I build the yocto image with kernel type / class set to fitImage.
For building u-boot I have specified e.g., CONFIG_FIT=y and similar
parameters.

When booting the board, u-boot loads the fitImage (around 10MB in size) and
shows the kernel / device tree blob info (kernel is gzip compressed).
However, the process fails when u-boot executes "Uncompressing kernel..",
with Error: inflate() returned -3. This leads to a boot loop.

I tried manually executing
'load mmc 0:1 ${kernel_addr_r} fitImage; bootm
${kernel_addr_r}#conf-bcm-2711-rpi-4-b.dtb', but it results in same error.

The kernel_addr_r is set as 0x00080000.

Any information about this would be greatly appreciated.

Best regards,
Andreas Enbacka
