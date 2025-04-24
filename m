Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33085C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C7E81E14;
	Thu, 24 Apr 2025 14:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIGtqjlu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7C7809D4; Thu, 24 Apr 2025 11:15:18 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9AB2815D1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22438c356c8so7915995ad.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745486113; x=1746090913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pdc+ZhZlXfMgLUZcubhq9S+FqaAPTTOByel5RMl+/WQ=;
 b=PIGtqjlukEyw9+JzJ2v5D4c3LUb30fr+ntQjXTty3w2JRijGTwWFvVHupxDuSc6lKO
 dKNImrvjUxcvD07LyHqe/tEjvYGVrr7W0widNtehaJ/pfgw8mR6/t6Wci6G5VWqVeEWt
 lRiy7PvQvJd131wudFrZZCMehOwtZPZ8c2XvtzYOpmlrQd/wAQY5RIjDeCiQ6T1+sOzk
 6bCqOJ4SeZVXcApeNjdG4774mEQY5kog2V/FsR6tAs2FSt87x7Ri8WRNE+6wkL9Abygl
 rFXbK77b9mUiF1GIBWA172V8CJpLzelqpR6T+/eT30DBCX47sbTNOd5Bhr+N7uhjdU1p
 gg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486113; x=1746090913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pdc+ZhZlXfMgLUZcubhq9S+FqaAPTTOByel5RMl+/WQ=;
 b=tv9LaWDxxvanXSpbvKw3o2qczt1y9Sel/tpvH8WjpULVXyieL6yR7a5UfWaHqZAsgw
 6l8svoxWBWVCR4f09aiRnJoinXIbkLTKcgGb+EU0JMvR+D0PXUodEPrOd5/rO+iR9ZMK
 M04+wtCthpswmoVAj6YOzCPVUr/ZhXVzP4Irf3YJboJMnrmUNVoR0Z8lBBTsJhiu98UV
 F2UXpv0GNnkb7xzXPJMmFGgrBqhGJ73DQ0Bas/xKRtSK8RNnGzjSbfaMjF1DQTDGUU/V
 pi6UkZH6JsTz0vwbmEtb5OclDGOhV3HOuNgTUeqy9uJt+IHIO93u1DwdtZNSonoIzrUr
 wqcg==
X-Gm-Message-State: AOJu0YzFerWrGwmAruw70qaV7L3ClyvUFctU4CkXNAu+pMMZBW5AllOt
 phzb6iXPbowDwPivG007GTCxWDlsovfcF4qkya96IMTLTEabQ1nW5AZ/qNZc
X-Gm-Gg: ASbGncukq8u3EkRlMIa5oUCRevLrUARmxtwIqqBqSBvAVGiXRBQhmd34bjObJNXfEXS
 +BuTGjYlJulRLimySTPoCEyktjIsbEeSlyjaqV75sbUnuzIqLDU1F6MNN+Z3H4ESyx+vQDGjokU
 Mb/CC9kGq4SakpQqejPoyTrzRup+7eox/CgGDiSmime/3ejUt8SopWHIvjxz2kZKdCGd4FhFMX1
 OPj2MO0KEgsMpMR/Si6n0rsKztlnK3PhwN6dRTtzosFoEA0Z6b+GZkB5jISUJr1ETQtGlObG4u3
 CMBsFy1hxnB6W4CN1Q/6ZesUx+ffwI+GTr56AxR5cTLRk+3dwZ8h+yBmCm4M3J+yqnLFNjHu6M2
 VqU0Yq+raKmN79waqlRtEBw==
X-Google-Smtp-Source: AGHT+IFKjUEAYTV6kgcwwlfWIl110BKd4zVpbyJ36CyuCTD01Z3D+Pb4U0/MWDvAfIKoRTZpVN5wOg==
X-Received: by 2002:a17:903:1b6f:b0:227:e6b2:d989 with SMTP id
 d9443c01a7336-22db3dd7cb9mr34352245ad.44.1745486113131; 
 Thu, 24 Apr 2025 02:15:13 -0700 (PDT)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f42a8sm776331a12.3.2025.04.24.02.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:15:12 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, tobias@waldekranz.com, trini@konsulko.com,
 quentin.schulz@cherry.de, k.kurematsu@nskint.co.jp
Subject: [PATCH] doc: fix typo
Date: Thu, 24 Apr 2025 17:14:16 +0800
Message-Id: <20250424091416.87720-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Apr 2025 14:40:20 +0200
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

Fix typo from "to" to "do"

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 doc/usage/blkmap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/blkmap.rst b/doc/usage/blkmap.rst
index 75f736c259f..4e9091e8ffa 100644
--- a/doc/usage/blkmap.rst
+++ b/doc/usage/blkmap.rst
@@ -39,7 +39,7 @@ network. Getting the image to the target is easy enough:
 
    dhcp ${ramdisk_addr_r} rootfs.ext4
 
-But now we are faced with a predicament: how to we extract the kernel
+But now we are faced with a predicament: how do we extract the kernel
 image? Block maps to the rescue!
 
 We start by creating a new device:
-- 
2.34.1

