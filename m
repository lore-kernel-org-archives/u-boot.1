Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877D0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 22:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AE18770B;
	Thu,  9 Nov 2023 23:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="DXzW5HGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D8E87703; Thu,  9 Nov 2023 23:34:46 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C821B87169
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 23:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a0907896so1750294e87.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 14:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1699569282; x=1700174082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy7M6KrS5Z6gcbhPC8dHLYZ+CbxKDZ4Yonsge9KsA+U=;
 b=DXzW5HGlVQNignytCq9PSHohYIPz2S8S5Gg3EOq47lQ1K8+jL0Eqnq8EG+kcG7ddlT
 n1UCDKZYg3IgI8/Q91Fv55395yz+46eFcoVa6p4Tscl2wurNMpaUuQYE/lQqwelHm92k
 DEKqsGHXhNS7fPjgUGDZGS+FWDerRZBBry951aMZ16UTmI36073quqPTigMh8kOmhQQ/
 +Lpv7GOYD1hphSNzGUcPx879Rb65nKFa+ovSsK/kI4A1b/CAObKUo18wi5I7eEvGFAC9
 5LgE7DSqqQMrvDBkrI/9goenTBojpccjfxY2R4fL02iDbMY+jOUJrVO5fA4BL10FIK+T
 LRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699569282; x=1700174082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xy7M6KrS5Z6gcbhPC8dHLYZ+CbxKDZ4Yonsge9KsA+U=;
 b=SMbu9XngUdhYIXBSgFoW/QJ3r2YIBlF+sIu3hNmuqg26bhb6cKnSdVLFEilCVZTSZK
 CUSamKvLp8q1P3qyAfEUTPFGwzGi/ei3JOnAiK6R9dopJzclZ76LeXm81NK151oPK56a
 k3LrqShuR5WQr0rLyg55HeDOKpmZoWMvVk8OryZP6FYBUN+H0DMcPZhxQ30LkCqxYA53
 1zZBJ3ykdi2DUBV6nEFb6kmgUy+VNmdMbzVk5OWWCT0pfsEqiGmANnKKcxuYqGmgk1mF
 TAWlOVMBwKghu8TNPfxlzsckmBIwGmEhQ0LsrmWOLhsItlwjgZTIj58h0Act1WiLc5Z/
 /JWQ==
X-Gm-Message-State: AOJu0Yzpmu32D6woWwjeff2fyMQeSCT7b9H6Oat0wIGaePGDmlwKsPY3
 no0uBPCBxuuQUoYQ/4SF65jUlVBc+kxBb1o5oh1dd5c/
X-Google-Smtp-Source: AGHT+IFABCIld3anKpAWGKVCfuh83TYJ2wmF4WxJ3EoMK9JoJhpbpm5HqE4GRtw2WG8y/cUSma4aAw==
X-Received: by 2002:ac2:5f6d:0:b0:509:440f:73e with SMTP id
 c13-20020ac25f6d000000b00509440f073emr2285301lfc.39.1699569282387; 
 Thu, 09 Nov 2023 14:34:42 -0800 (PST)
Received: from igor-thinkpad.. ([37.30.10.18])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a0565123d8f00b0050944953095sm1182322lfv.43.2023.11.09.14.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 14:34:40 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v1 2/2] poplar: provide more space for kernel image
Date: Thu,  9 Nov 2023 23:34:35 +0100
Message-Id: <20231109223435.706053-2-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109223435.706053-1-igor.opaniuk@foundries.io>
References: <20231109223435.706053-1-igor.opaniuk@foundries.io>
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

Adjust mem layout, providing more space for linux kernel image.

This fixes the problem:
ERROR: FDT image overlaps OS image (OS=0x30000000..0x32580000)

Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
---

 include/configs/poplar.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/configs/poplar.h b/include/configs/poplar.h
index 6e8adf9187..629b335f5d 100644
--- a/include/configs/poplar.h
+++ b/include/configs/poplar.h
@@ -37,11 +37,11 @@
 			"env_mmc_blknum=0xf80\0"			\
 			"env_mmc_nblks=0x80\0"				\
 			"kernel_addr_r=0x30000000\0"			\
-			"pxefile_addr_r=0x32000000\0"			\
-			"scriptaddr=0x32000000\0"			\
-			"fdt_addr_r=0x32200000\0"			\
+			"pxefile_addr_r=0x33000000\0"			\
+			"scriptaddr=0x33000000\0"			\
+			"fdt_addr_r=0x33200000\0"			\
 			"fdtfile=hisilicon/hi3798cv200-poplar.dtb\0"	\
-			"ramdisk_addr_r=0x32400000\0"			\
+			"ramdisk_addr_r=0x33400000\0"			\
 			BOOTENV
 
 #endif /* _POPLAR_H_ */
-- 
2.34.1

