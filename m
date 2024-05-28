Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172E6C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A45884FC;
	Tue, 28 May 2024 16:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NoS53RKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A223B88507; Tue, 28 May 2024 16:12:06 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF37087D70
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-79305314956so64506385a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905521; x=1717510321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qw3TLJbcSAsyJPIevwW8NWsuLme8RxOkU0dw+aOO6BU=;
 b=NoS53RKqpBB00fsQcBffUeQ63nrbGXH8gaDgcaskX9YqTUMrt9LTOjZlR52DrVqZLV
 ic7pRyBLlvFmTnbWFSNWWuUaZfq6gkmi3gSfHNfgFpcjx6/YXltaZiXyCujMko+Oo8ll
 vQQoMjWNXqJsMHHVsvkvVYmo0B4P7S5Tu7d/1Oqe11n44AlUsRfJLUaqCoFMdxDMui1s
 KbexR+bIZs3BcF3LYP9MaG1pFML6nDkKoVckaGV+tjPqhjNx/S4zMiVCzxQiutC8sJA6
 RaUaqzmlf0ViHdTfb0Opqyv/NgQZ1FcaZQ574DLfTeFkZqAhs9la9MNphNLC72ckjkp7
 yCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905521; x=1717510321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qw3TLJbcSAsyJPIevwW8NWsuLme8RxOkU0dw+aOO6BU=;
 b=PklVr4HNI4lBn5aW8WuH7QflQ7UbGBiObzIkiWELgTX+ckS7lnnCP6+DDNvJwR5BlK
 QYMMmAJusi5rgoIvPBAHqEyGkxlbtSxCSI1Nx5jUDRLD0YAy04gpsX25Jet1YiQSHDYH
 UtX9R+gVp7fERV6ZvgsCktr3LCdS9b8713bPQ5ll8A7163IbsLxBpPJrLf1Ho8FUU3pF
 Auhcyf4kQBQbC+7F1UUa9yE65uzTFTP0PJDkPcutY+jIeeMv9TrCbk645zGYDy+kTWY7
 UqegJdMLb7+NKlCUJFjF1mIOLJ1u/xAlN/kPBKsWKzsCZ8rbKG7ZihnWLXVtuwQluKdm
 lMSA==
X-Gm-Message-State: AOJu0YyEPvpvIGlre01NMFRSokqhlUFylOkXZFFgBzI0IoD96WCFIeyn
 YML0E/kg72fEjKIdEL2/A7lOsivp5ig3h62Cmwrk+VIdAKQT8wC5bqU1FLyQmtWtfI6vcsx2pz9
 je6s=
X-Google-Smtp-Source: AGHT+IEZDKkzBRnbsUB4p2Q8f63d+W/9xXnBPVNyWGWiuDEZbtvb+VgDamwoWTkksdJojkw18qQBMg==
X-Received: by 2002:a05:620a:2f8:b0:78d:6e0a:3d67 with SMTP id
 af79cd13be357-794ab09dcffmr1288061185a.44.1716905521170; 
 Tue, 28 May 2024 07:12:01 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:12:00 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 05/25] md5: Remove md5 non-watchdog API
Date: Tue, 28 May 2024 07:09:16 -0700
Message-Id: <20240528140955.1960172-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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
it by enabling CONFIG_HW_WATCHDOG or CONFIG_WATCHDOG.
Set 0x10000 as default chunk size for MD5.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Initial patch.

 board/friendlyarm/nanopi2/board.c |  3 ++-
 board/intel/edison/edison.c       |  3 ++-
 board/xilinx/zynq/bootimg.c       |  2 +-
 include/u-boot/md5.h              |  7 +------
 lib/md5.c                         | 15 ---------------
 5 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index 393c5a447d6..f203499f544 100644
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
index 11e7f74e47c..1583d11c74d 100644
--- a/board/intel/edison/edison.c
+++ b/board/intel/edison/edison.c
@@ -33,7 +33,8 @@ static void assign_serial(void)
 	if (!mmc)
 		return;
 
-	md5((unsigned char *)mmc->cid, sizeof(mmc->cid), ssn);
+	md5_wd((unsigned char *)mmc->cid, sizeof(mmc->cid), ssn,
+	       MD5_DEF_CHUNK_SZ);
 
 	snprintf(usb0addr, sizeof(usb0addr), "02:00:86:%02x:%02x:%02x",
 		 ssn[13], ssn[14], ssn[15]);
diff --git a/board/xilinx/zynq/bootimg.c b/board/xilinx/zynq/bootimg.c
index 2f55078dd76..4b2245c0618 100644
--- a/board/xilinx/zynq/bootimg.c
+++ b/board/xilinx/zynq/bootimg.c
@@ -136,7 +136,7 @@ int zynq_validate_partition(u32 start_addr, u32 len, u32 chksum_off)
 
 	memcpy(&checksum[0], (u32 *)chksum_off, MD5_CHECKSUM_SIZE);
 
-	md5_wd((u8 *)start_addr, len, &calchecksum[0], 0x10000);
+	md5_wd((u8 *)start_addr, len, &calchecksum[0], MD5_DEF_CHUNK_SZ);
 
 	if (!memcmp(checksum, calchecksum, MD5_CHECKSUM_SIZE))
 		return 0;
diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
index 3cfd33a8e56..3cb87328175 100644
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
index 34343cf8e23..2d8977b2e85 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -262,21 +262,6 @@ MD5Transform(__u32 buf[4], __u32 const in[16])
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
-
 /*
  * Calculate and store in 'output' the MD5 digest of 'len' bytes at 'input'.
  * 'output' must have enough space to hold 16 bytes. If 'chunk' Trigger the
-- 
2.25.1

