Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEDFC28B30
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DA2817D8;
	Tue, 11 Mar 2025 14:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aCS/ZP/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0A78003E; Tue, 11 Mar 2025 14:35:39 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C50811C1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2bcf9d9b60aso1394735fac.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741700134; x=1742304934; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fd9RKxIDCgWjHPwIM56sTdKSrqkdoZXKH+qowvuThMA=;
 b=aCS/ZP/thdLApNbj3YpPeX1Fmif5PGcSBkxoTU0VPIYRdJBu1wDQSlTaLyii7TORRJ
 Rn3rYcxdzk3ODVSyQRwUfGrpiwOF+klR9FD2rkLTEGCY5I63nAOW24I3ENMNuKyVFcwJ
 4pENkMRUcd19a9Xo1f+igPsxcsKr8+n0kO9z5nAgw9s9KAt+nWVKlFNoKi5MpriF0wmk
 iLBXhIu2dPjuicKI6Z4Ns6I3oitAEPtg6NFujNPpLW/NHnSZmIxYRR2Fqm4N7kBMnzxD
 cHyQDAn8KAZH7tbs5bRhe2YqDnn0d6NZtLHZOQRb0DNqYWBAF2TLL1RiD+mb917CH8Bj
 j70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700134; x=1742304934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fd9RKxIDCgWjHPwIM56sTdKSrqkdoZXKH+qowvuThMA=;
 b=FZ0vggpS7s2UYXvdru3o4O/QRymH9pVs9eUU3G0uOVj1KEpk0fuxaZ9EXItQsXBbyt
 Ham7SdEFGlZpxga+n6mTaZOakQpLvIe1mkraSqN2E/0mvyn5QLElsO5wsvEeUORE/l+F
 YVBAfngyVSAWCg2trxpNxAp7e8bV2YVTrwXWTpfU7PZzdCNJ5ejGYK0KGd4Ct37wUsOg
 9VjWzcyoPXfXp9xD6yquIsZCOtNBGp0cv5QjV4Ka+AJEIX5O/6wxo6Vk1NEGZKMBVN7w
 WJ+oQZ+XkdMRzY5ofnRlzTwr54acHCvgeeip4y3WTS0iyMp4jStejVf5egTey/1kgETB
 IA+A==
X-Gm-Message-State: AOJu0YzcNrw1SBVuQNLySVsbY3WVTR4UA0tE9ViBww+pD/S3Wny7DZxQ
 TVGAC81/5Mty1DBaBrljcPUt9hJM7uPKbj81pobiWt9w/ZMVys01sQ1rMQqm2UOCTQ/WgVwXJ1s
 C
X-Gm-Gg: ASbGncuTsrq9xZkLUTz32nHApWrkyb7YsiBBg8kXR3xj2vZCj38GCx3ITiH0rFBABpd
 EMwKJzI1jo0IOW1VlxgmpObQFcqyZzTxcXl/RCNKSSGnj7bjGNZjfNUDxzxy+GtMx3zVUdvf4eN
 +xAyp2Um6NMrsxdtXP6VL88b8vGYKii+YkUoFYZwc+mD0TXvUtaVHSWVbfg5GBZp+9k0Lt+YLuu
 ioct7Xf7DPkkxcavoKeN0w/dicBAIA816xvDQ2jM6zEolpqp026awiFl0RYMju8QWf3gnXEeBDf
 VfNOnQvbT9gUc6HCEvUfzzRJ6n7AwFfdd49eoWG/yyQxjfnuELwGwKRACuHrfHmWyQ==
X-Google-Smtp-Source: AGHT+IG8w/vjpE3eL4lDY5g5dstDvdST7jmXASCnoRR7vgWQDfGo4+OaTeg+pXPXMMONPpBlMzwEHQ==
X-Received: by 2002:a05:6871:a58f:b0:2b7:d3f1:dc72 with SMTP id
 586e51a60fabf-2c2e8905689mr2306517fac.29.1741700134573; 
 Tue, 11 Mar 2025 06:35:34 -0700 (PDT)
Received: from localhost.localdomain ([103.97.166.196])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-2c24883035bsm2578036fac.5.2025.03.11.06.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:35:34 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v1 1/3] riscv: image: Add new image type for RV64
Date: Tue, 11 Mar 2025 13:35:03 +0000
Message-ID: <20250311133506.124914-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311133506.124914-1-mchitale@ventanamicro.com>
References: <20250311133506.124914-1-mchitale@ventanamicro.com>
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

Similar to ARM and X86, introduce a new image type which allows u-boot
to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 boot/image.c    | 3 ++-
 include/image.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/image.c b/boot/image.c
index abac254e026..03d5e59b634 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_ARC,		"arc",		"ARC",		},
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
-	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
+	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
+	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index 8a9f779d3ff..12b31166e86 100644
--- a/include/image.h
+++ b/include/image.h
@@ -139,6 +139,7 @@ enum {
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
 	IH_ARCH_RISCV,			/* RISC-V */
+	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
 
 	IH_ARCH_COUNT,
 };
-- 
2.43.0

