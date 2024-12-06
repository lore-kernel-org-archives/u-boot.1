Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91940E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E768963C;
	Fri,  6 Dec 2024 18:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iLT792D1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC9589622; Fri,  6 Dec 2024 18:31:01 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2291489620
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso2014048a91.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733506257; x=1734111057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=09AL/nhQljpT5PpLlh+vPEPvtTHRLiKj7ughjVtCGIc=;
 b=iLT792D1U+IFXXx/GSCvkw8uGUPEDo8I83+lUT6cRFpxbBq8b0BXWIM6ha1dLwvn8X
 v51WfyLxNCk0nawloohO3OwVf+Gq6yK5Mu9Kl3+fT3h5u53EJb5+nXO2T1QVSW8XWaIb
 m/Jw7eoEHnO1YBVM/72ahQRToAxYgzf/BLZVZvxxKsQCo3kua+n3gWoDIknCKufOjSbt
 BW9BevJ5QFTbhYJnWVoODKa/HeoqcR58456hOCLZNuJjAVcLo6AqXSg50QOztawm9uaW
 r/mc0p+Qoj/JM+9w+NWAWZk9iCCHIz5gkpB/afxn6fO9WY8LD1xxLPoMVAlCZTRSbm8M
 55cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733506257; x=1734111057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09AL/nhQljpT5PpLlh+vPEPvtTHRLiKj7ughjVtCGIc=;
 b=N0Juy/ETtheVfMHeGf9Ha/OImc1njpu1I/JnN/7WHKVcSGxbsQFrreBo96yQYhgWqO
 aaiU41iIw0JtGi8tPVu+kCtaHthVuPaEMghEPQ8kBUIwmWTNmNCA8++JS5NB20j73sW+
 maj7T3aOD93OQX3HutpIpQE+8uQj/0e5yAA3+6X5QbuQ60lgRcDniKRJzYHADGAHAN0m
 XsK7v1+DvfN9L7URDlc7KtmSAs5Fpn0divZNn2ONUvQrijO6PKUWAQAkmxxjaC/sW5qL
 f3/6POLZbyRpmrOc/YStsslNVzI5EWteu2T8MfeEb664ysZ8qajyj8K17r0zERSWSwcs
 UbSQ==
X-Gm-Message-State: AOJu0YzlAim6cbFokqDXb9zi2lXrDl6ps51uiQ3AWJeihYGUUzC9NOmh
 abwQomuAzOedUlb94+YQAMB1QmzS83y/961UXamnbXcGRoF8PMSxb2QTZnPNVhA=
X-Gm-Gg: ASbGncs8Y106pcrdMfGa2eVvZrmkXjwxV1rIfXKoBYupV3p3Nre2SOOKhQhv4t+Mvhv
 p5C3TU4bI2gIa+4QvY2D83xa0//jjBjjJdwJAzKPIXsAU5Rp1jKBLBMv52k8fOkVru6e3KtTNvu
 IuqQoJ3X3RdPJX0AXR2xXcMb0LuRinZvBTpZNbs0W9+PToPPhLR1wYpTzmcL+uNLkRFdjCIZtj3
 yiKheL9S8y6Zo3eOvU5sn69P/QY2cgc6DZB9V9FlC0shEdhuRDo8ub1SxiX2w==
X-Google-Smtp-Source: AGHT+IGltS4CgqGs3AInSnp8fDmazJU/7ch+DTXyMuqk5ME4aa+ihGelcN7mvcxyLXYUFB459n2OsA==
X-Received: by 2002:a17:90b:1f90:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2ef6ab0cf87mr4589895a91.28.1733506257598; 
 Fri, 06 Dec 2024 09:30:57 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef31715ba8sm4810162a91.13.2024.12.06.09.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:30:57 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 0/2] efi_loader: efi_setup: Add efi_start_obj_list() and use
 it to set PXE IP address
Date: Fri,  6 Dec 2024 14:30:31 -0300
Message-ID: <20241206173033.2403998-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The command bootefi calls efi_init_obj_list to do the efi set up
before launching an .efi payload, but efi_init_obj_list is called
only once. There are some initializations which depend on the
environment and should be done each time a payload gets launched and
not only once and can now be done in efi_start_obj_list(). A motivation
for this change is the following order of events:

1. Launch an EFI application (e.g. bootefi hello)
2. Change the ip address
3. Launch another application which uses the pxe protocol

As the EFI pxe protocol was initialized when the handles
for efi net were created in 1., the ip was hardcoded there.

In this example, another possibility would be to make a callback for ip
address changes to go all the way up to efi_net.

Adriano Cordova (2):
  efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
  efi_loader: efi_net: Add efi_net_start() to efi_net.c

 include/efi_loader.h       |  1 +
 lib/efi_loader/efi_net.c   | 31 ++++++++++++++++++++++++-------
 lib/efi_loader/efi_setup.c | 24 +++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.43.0

