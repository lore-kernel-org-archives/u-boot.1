Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE74C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9495788C02;
	Fri, 16 Aug 2024 23:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m3TgSqhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 855D988C2F; Fri, 16 Aug 2024 23:46:27 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E7188C07
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bf6dedbfe1so13556166d6.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844784; x=1724449584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQy7b8paOWM4IXSTE5lHrWEjvKCTChFRAcH1tnuZZBY=;
 b=m3TgSqhp5/Jr0r006g5EMoQaZwrL3UNyegD2H95OtDoag7AoGWaippnzfwmd482nZI
 S4j0RSXLQ9Xmd+x1qfOLiL9ERsvogg8LQWhJwEOzS7Q4Kz4HGPfRRavW4yUuqYyW6ZXc
 FvKziyfepR4R+oUtA34idmtyOs/Lynv1w8Dx4BtpeQrQlT5O5w235JbJoJ6Ob5FKjPgA
 rvS0SEwIRmr1wjS8COY7Fdg55oWKF1ZIi0ueLZjvpT1v0/NQMb+24bBuulMVq3NBu5w/
 WM9t9ZXZqhhtWt+FONQxXJVjkejqbwRk4/HCSY5CrUQt8ccvnutSvDhKrMJ6PNfKxJkE
 lYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844784; x=1724449584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQy7b8paOWM4IXSTE5lHrWEjvKCTChFRAcH1tnuZZBY=;
 b=rOwDsPYarZR11TXNUlQTC1TbArzD7IrQtc6cpAdtfztUvYe8aNixtkQCeL0A/wcAOq
 z4WpsvFu6hb9ZnzEIt9GtLd3q8JoFHk0R/YaKJFjQSCK1JJca8JCQaq4b6xJspIFnpjN
 +2N7KNIiujQekjzlOPwo/olJibbaHRo5llSo3EOeDFuvvGyYpWCouichob9aB89tggaA
 i5exCEoBfbgVGQSxkT8zAXZuUa0tX+j0PyBGPn2hN4F7Mufd2vi6X23JW4Tffh3nWBa/
 LU7txm9ofbMxM3sn98oQFkqmORPLK6lX3JizfvX9+geha9nCRquLHChLv4H7lSsS/ezG
 9igA==
X-Gm-Message-State: AOJu0YzFpDkHWNB+5AwKJv2RFxKOCGT+cZbU9igJ8qQPr4fHNXCJX1xf
 0bp0NjLUVEwqwCqVj0KCD62AYkCdEFdzMPcVwktbL5ziaqZFyedO/YXlI+OWlP5Rli8EBwZUPyT
 ip20=
X-Google-Smtp-Source: AGHT+IGZ57w1hcZVBZQdRtXPYh+TH6HfItJs9YX0E3zH6AOZf9jDuK476LKFCGPrmSQtY/yq5Qfy7g==
X-Received: by 2002:a05:6214:3292:b0:6b2:da3d:999f with SMTP id
 6a1803df08f44-6bf7ce61f4dmr45299236d6.41.1723844783906; 
 Fri, 16 Aug 2024 14:46:23 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:46:23 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 04/28] md5: Remove md5 non-watchdog API
Date: Fri, 16 Aug 2024 14:43:53 -0700
Message-Id: <20240816214436.1877263-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
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

We don't need an API specially for non-watchdog since md5_wd supports
it by disabling CONFIG_HW_WATCHDOG and CONFIG_WATCHDOG.
Set 0x10000 as default chunk size for MD5.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
Changes in v3
- Initial patch.
Changes in v4
- Update commit message.
Changes in v5
- None.
Changes in v6
- None.

 board/friendlyarm/nanopi2/board.c |  3 ++-
 board/intel/edison/edison.c       |  3 ++-
 board/xilinx/zynq/bootimg.c       |  2 +-
 include/u-boot/md5.h              |  7 +------
 lib/md5.c                         | 14 --------------
 5 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index c8cbc5a15fa..2d764e8eef3 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -263,7 +263,8 @@ static void make_ether_addr(u8 *addr)
 	hash[6] = readl(PHY_BASEADDR_ECID + 0x08);
 	hash[7] = readl(PHY_BASEADDR_ECID + 0x0c);
 
-	md5((unsigned char *)&hash[4], 64, (unsigned char *)hash);
+	md5_wd((unsigned char *)&hash[4], 64, (unsigned char *)hash,
+	       MD5_DEF_CHUNK_SZ);
 
 	hash[0] ^= hash[2];
 	hash[1] ^= hash[3];
diff --git a/board/intel/edison/edison.c b/board/intel/edison/edison.c
index 911ffda2fc7..27fda3fc1d2 100644
--- a/board/intel/edison/edison.c
+++ b/board/intel/edison/edison.c
@@ -32,7 +32,8 @@ static void assign_serial(void)
 	if (!mmc)
 		return;
 
-	md5((unsigned char *)mmc->cid, sizeof(mmc->cid), ssn);
+	md5_wd((unsigned char *)mmc->cid, sizeof(mmc->cid), ssn,
+	       MD5_DEF_CHUNK_SZ);
 
 	snprintf(usb0addr, sizeof(usb0addr), "02:00:86:%02x:%02x:%02x",
 		 ssn[13], ssn[14], ssn[15]);
diff --git a/board/xilinx/zynq/bootimg.c b/board/xilinx/zynq/bootimg.c
index 79bec3a4cfb..9eb0735f55d 100644
--- a/board/xilinx/zynq/bootimg.c
+++ b/board/xilinx/zynq/bootimg.c
@@ -135,7 +135,7 @@ int zynq_validate_partition(u32 start_addr, u32 len, u32 chksum_off)
 
 	memcpy(&checksum[0], (u32 *)chksum_off, MD5_CHECKSUM_SIZE);
 
-	md5_wd((u8 *)start_addr, len, &calchecksum[0], 0x10000);
+	md5_wd((u8 *)start_addr, len, &calchecksum[0], MD5_DEF_CHUNK_SZ);
 
 	if (!memcmp(checksum, calchecksum, MD5_CHECKSUM_SIZE))
 		return 0;
diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
index 69898fcbe49..c98b1a58088 100644
--- a/include/u-boot/md5.h
+++ b/include/u-boot/md5.h
@@ -12,6 +12,7 @@
 #include "compiler.h"
 
 #define MD5_SUM_LEN	16
+#define MD5_DEF_CHUNK_SZ 0x10000
 
 #if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
 typedef mbedtls_md5_context MD5Context;
@@ -30,12 +31,6 @@ void MD5Init(MD5Context *ctx);
 void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len);
 void MD5Final(unsigned char digest[16], MD5Context *ctx);
 
-/*
- * Calculate and store in 'output' the MD5 digest of 'len' bytes at
- * 'input'. 'output' must have enough space to hold 16 bytes.
- */
-void md5 (unsigned char *input, int len, unsigned char output[16]);
-
 /*
  * Calculate and store in 'output' the MD5 digest of 'len' bytes at 'input'.
  * 'output' must have enough space to hold 16 bytes. If 'chunk' Trigger the
diff --git a/lib/md5.c b/lib/md5.c
index 584463d55ca..2d8977b2e85 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -262,20 +262,6 @@ MD5Transform(__u32 buf[4], __u32 const in[16])
 	buf[3] += d;
 }
 
-/*
- * Calculate and store in 'output' the MD5 digest of 'len' bytes at
- * 'input'. 'output' must have enough space to hold 16 bytes.
- */
-void
-md5 (unsigned char *input, int len, unsigned char output[16])
-{
-	MD5Context context;
-
-	MD5Init(&context);
-	MD5Update(&context, input, len);
-	MD5Final(output, &context);
-}
-
 /*
  * Calculate and store in 'output' the MD5 digest of 'len' bytes at 'input'.
  * 'output' must have enough space to hold 16 bytes. If 'chunk' Trigger the
-- 
2.25.1

