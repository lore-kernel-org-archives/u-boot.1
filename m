Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685F7CFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0807988FA5;
	Fri,  4 Oct 2024 06:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HwQA7fGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 534A988C6D; Thu,  3 Oct 2024 23:53:37 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2781088D1F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4581d2b0fbaso10243061cf.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992413; x=1728597213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnlItj8iQ/ioEQoXlxQqnOHbCjB5p0lZcRpLGyMwTiQ=;
 b=HwQA7fGZatGMfzwKwn5QFor+JINWomKrO8HrttAnROueslrjiak3ZZTy4QLO3Pyb6w
 HK7TOSVDXCYu51YlsoxVEFh/TYjOM9GSfMR8YnaTeIvJgjPYvVnvadHEjVARCjqw0jmR
 PAUbK/FVcRF9CCicrhr+7/XmOZpvVcRJZY79kbW6jszB8b9CrvKyUB/c1QiSSg8QdLaw
 tNDdAzXRR83RkPc2IDkjJpwgYUAEKpG2b6uYG+cxtFxpk0Oq1kiSAuXH9EpplBdkt5rc
 dvUQPPQG67rNeDFeRxCOJO8J0DHdVCRHWhYaJaI+mFQOmJ7apymvr58scKZWTlZCVxEt
 /jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992413; x=1728597213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnlItj8iQ/ioEQoXlxQqnOHbCjB5p0lZcRpLGyMwTiQ=;
 b=p4CMtjRwyruVjhglPEep7lJCpnlpOkpvKnwXoQOjD1ZDlsuuESMDc5QhH3DpCQl8UH
 ro+gVUhJww9ckpjWZ94uiP6K/lNhon9uhMCswF75empd+AZIgeXJf2k/Ckxo8MCUlAsN
 fIgX0ejcp/nlRLFwWGQWuqaqVKIYuMjglSdI3HNZNIR53ksk4II+0r/wpRfac7hxkGxM
 mIVdHGyfHulOkZamUFQ8HS7otK4zxJyXdwGvjkpiz2GS8m63/XqmQM8yoR6j6sZ5VYHr
 Wf/b/QKNQcBCCEwpiFO7T86JOIjZ2A4Zi1aNTYJNroGknDwNBf/cSOItmAAZhFmaAHTl
 F2Dg==
X-Gm-Message-State: AOJu0YyAKM/gPsK0Jew6P9iSCKSdwM0thc2y4qHcGScR1IvchWrpsVYW
 PXaclsBhboEaqCO32lHtMtrY4dM1KsawyjAJijqFyYfnBzHqR6OV9mb+6FpSY/CYbmqf843NTDp
 q
X-Google-Smtp-Source: AGHT+IHyWZxYGqeAWPN0aU4YZENu8vdMnDQ05QuiSYAtdvvVhcFj9GPtj/mmZHIbRxOVwR0riGY7zg==
X-Received: by 2002:a05:622a:5b8e:b0:458:2144:6977 with SMTP id
 d75a77b69052e-45d9bafb62bmr8464241cf.50.1727992413555; 
 Thu, 03 Oct 2024 14:53:33 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:53:32 -0700 (PDT)
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
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jonas Karlman <jonas@kwiboo.se>, Linus Walleij <linus.walleij@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 04/27] md5: Remove md5 non-watchdog API
Date: Thu,  3 Oct 2024 14:50:17 -0700
Message-Id: <20241003215112.3103601-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v8
- None

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

