Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA4EFC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C6488D28;
	Sat, 14 Sep 2024 03:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v9DplfQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96BEC88706; Fri, 13 Sep 2024 18:06:19 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D50C887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5dfad5a9c21so1205485eaf.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243576; x=1726848376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJW4oX8tuirIbD7w/zr3j2fItO90eLWrR+IUek2iiUQ=;
 b=v9DplfQSwm4Rhmfv6sAGNcKYw4pJ9NvLPAxiLEaPXevPmH2+xApE6pPlrex/0fMuh9
 dS1lglLbzdZXP4bj+1PiOq16yfnMGHOdHO3vU5X43nc2vMmMWAI7eOVwp87Y4lYia6Sv
 3hnI5yBLhYLTpFW/NdYxQ4uKSVOMOz5eX/jnWFcnkcfXlon1U8/ig0BhpQBOdRPH7rHV
 +puansEV0CNL5E4xoOWgklZbxn7uD/OMPl1Jx6oFniUP9OcA6zC8eQga8KwhrzjJgwaL
 fztqoxMJYzFMg8ohy39Qt6fTwLu9rqw+BJ+mKJLs48qsi7VL8o4UryD8xe7oXii2rTOr
 LFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243576; x=1726848376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJW4oX8tuirIbD7w/zr3j2fItO90eLWrR+IUek2iiUQ=;
 b=fbsNMvdJ7Yp86UQo3n/axHgaRXvJB3c4GN3DEl+Gai3Z4yAx+uqmsvV/oSMOKFgwZp
 53iTzaspyzDvgGJ9obnu4xrYfDWFfZln//p2X0DW1ziaaH3Q7i61uMqR2qjYox9yyXAJ
 4YmdVbwxYJpAbiWhNfpmSjRaX0pcjVPxi9TLFIZ5GPE82Ay260h2iXQHWnzkGxf05O5d
 jpRwAq0gLsJKl0O0vgJ+LOm/GPb2bx1T0GtTv8Cm5PhLOkmt5qvdVouQVqiD1EhqNrTs
 rvPH61VkS/werQJVWy3nVkFYzIx1mIATULlXnLMeU6tbdOWPiKZggjzeHXynXgM+xaJa
 CCyw==
X-Gm-Message-State: AOJu0YzOdck3te50WwNBUG9BRTOlKI5YVUEnKfXx8PGjWiXgKBLX2m80
 HUTIA82BmBlS4+ZDq9kAiZgHMwEz7L9T4ncMyGKsoEbZxp0BEXGpcMEiMHPdgnMdLutfNz0t19j
 y
X-Google-Smtp-Source: AGHT+IE9pKGs1gUy2wc7wvBFyihVSHSTi3ZyEJK37irUafUSbp0GG+uhZFk9nMnfLiQHir5HcL+WVA==
X-Received: by 2002:a05:6358:7e8c:b0:1ac:625f:9d4d with SMTP id
 e5c5f4694b2df-1bb23de04bcmr470900255d.23.1726243575831; 
 Fri, 13 Sep 2024 09:06:15 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:06:15 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <seanga2@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Marek Vasut <marex@denx.de>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 04/27] md5: Remove md5 non-watchdog API
Date: Fri, 13 Sep 2024 09:03:21 -0700
Message-Id: <20240913160408.2199558-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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
Changes in v7
- None.

 board/friendlyarm/nanopi2/board.c |  3 ++-
 board/intel/edison/edison.c       |  3 ++-
 board/xilinx/zynq/bootimg.c       |  2 +-
 include/u-boot/md5.h              |  7 +------
 lib/md5.c                         | 14 --------------
 5 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index b32dfc6b570..4dff32e10d6 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -264,7 +264,8 @@ static void make_ether_addr(u8 *addr)
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

