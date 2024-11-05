Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D147D2B92F
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 14:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 848F689070;
	Tue,  5 Nov 2024 15:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kImgv/96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F053A88360; Tue,  5 Nov 2024 14:27:50 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D46B884DB
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 14:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso48378045e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 05:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730813267; x=1731418067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IudwDgjqEna/HiNaNnWs2iP4bPZ+OSmK0B4EBhD8JrM=;
 b=kImgv/961EBiRYxCh1DlbZNAPxvrxd3/MW2AacJ2Nl3SeZqLVSOwjvt20O1MPsIelx
 b89cYys/jKaYi40ds4l8RXel+paG93bMM4nnNIZ35qgeujTTtu4Zk5VcOSIVGMEaeEjg
 GOfFpsiG2Ny/oh5CBztkx9ZNslmiOIp+y+gR8w12/lyErw1k1QZ+VNQEbGDNVrwlL9QJ
 H+Wwp9f3Jm7p72FItxLuMLA/MqVvkNVpFuqqWpLChoonjMBXI/6JL7Afo/cJuyMq2Er5
 6E6HknSdggs9CiSo0/bTC4WxfdBytpS0gbTLGoH10Cba+7ACyI1AlP3TEwBErssp8DP/
 RfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730813267; x=1731418067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IudwDgjqEna/HiNaNnWs2iP4bPZ+OSmK0B4EBhD8JrM=;
 b=WP7WCG/zsjcEWARDlYZ8zwk83Y/QunwnLgV8smmMJtf+77m+zqV6MoY5vmNsOOJIFy
 fTpAIi3wkM1g7MNxrG+yjJSS2Hm1MilpI20u1M1nw8F4GaBRAbfI6gK7VDHqeSoT3MZZ
 iApywmZ8tfQ8Ao15p5QLS1SCKc0mt0bkbqjDLmm0Vkl8/qkUTL7uM4FfmfEZ08gqi+X6
 3j2wtZw1vc+hrgykXlCG4c9hD66/RLhIMwrVJHEjtRGd+wFscKi9q92X/y5c9Ajn1k4u
 llZ+tPQv35k5b7Lji8YmN/nTGHc2EpBlkd937B8Lq9nhCKsR6E4nRgOURO3uKlteBkt+
 1C2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJXmKW9Ur3Bcjgp4KPf1yOu+NYeA93hnmLE/TwtpvPUUipHBlbSde9XxMXEBOfMbyuJmk2tk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywnb6UdTnoaHGoDxXcqdNADhh10XNVSI+trHIC7valHpV7Mt/6X
 tbScMAdC1RXoG8EVWlmYi5jJ2l1S1iqWeuszBcQcA/r43+SoSSLa
X-Google-Smtp-Source: AGHT+IHDPtPIuY3kCbwy4gAEkIRZC+drjEi87cMI0C/xdaz3S893dpS9PVghxNFH4gD4GJ4bu3Ghwg==
X-Received: by 2002:a05:600c:3b8d:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-43283255a89mr125115175e9.19.1730813266615; 
 Tue, 05 Nov 2024 05:27:46 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:61c2:fa6e:7930:6c92])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381c113e595sm16267906f8f.77.2024.11.05.05.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 05:27:46 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com, michal.simek@amd.com, hs@denx.de, pro@denx.de,
 sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch,
	u-boot@lists.denx.de
Subject: [PATCH v3 0/1]: bootcount: zynqmp: Add bootcount API
Date: Tue,  5 Nov 2024 14:27:43 +0100
Message-ID: <20241105132744.1572759-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 Nov 2024 15:17:31 +0100
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Changes in v3:

	1) Organize correctly headers
	2) Remove redundant "mio" and change "write" to "read"
	3) Add "depends on ARCH_ZYNQMP"

v2: https://lore.kernel.org/u-boot/20241105074917.546887-1-vassilisamir@gmail.com/
v1: https://lore.kernel.org/u-boot/20241029185814.7937-1-vassilisamir@gmail.com/

Vasileios Amoiridis (1):
  drivers: bootcount: Add ZynqMP specific bootcount support

 MAINTAINERS                                  |  1 +
 arch/arm/mach-zynqmp/include/mach/hardware.h |  2 +
 drivers/bootcount/Kconfig                    |  7 +++
 drivers/bootcount/Makefile                   |  1 +
 drivers/bootcount/bootcount_zynqmp.c         | 47 ++++++++++++++++++++
 5 files changed, 58 insertions(+)
 create mode 100644 drivers/bootcount/bootcount_zynqmp.c


base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
-- 
2.34.1

