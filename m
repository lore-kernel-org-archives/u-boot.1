Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E969C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8730680FF7;
	Sun, 16 Feb 2025 21:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F/6iXAi2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83EB80FF7; Sun, 16 Feb 2025 21:45:51 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E807A80FD8
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d2223fe5a4so4535985ab.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738747; x=1740343547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSVXRzeJSQMezxfYPHQpvdIMAySRo0wxWKUzX6LvTps=;
 b=F/6iXAi2siIP39zdwUDXQmgqg+zSdXlT93quOl5DirNWY2y1/9xx+ADZMkpKeSUKUr
 O9LVoywbKMCP88OlQzWxwaS1Yq6G47/zgiC4NylogqrFTv1P9it/9aWYwdygy9ISHO3T
 Y26mukXUhIjOIds7eOh+HXvm4gni85tOAI3AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738747; x=1740343547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSVXRzeJSQMezxfYPHQpvdIMAySRo0wxWKUzX6LvTps=;
 b=WvuQvRGR2ge5qpIj0muYscuj8WPH2lAmlZjSAHnhJ/ePQAXgGyPDfSogtH13LvpiGc
 52hXsAHmsOtt/kEArTH/sLN5BVCjza68NcKs7ZpBAqLDjnjLEYitABM7uCXaoeZHtezL
 mxklNrRcLAH4PnAG5VTpQUGRl/BpAWzgASXWJl0p/UBGGS9WlFMVT899G/VdPbZ3JYEv
 cRhb2hzgcOIfsOLPAY2ol4vrCWoClaiygRX8JJhTouAmLohPp4awh1magafJCOlxyCu4
 3T2rDteKNLGSOovEE3ld9Rc4u/xbCFSIN3WUBRsQTHuKJ2jGDat8VdemfCpqyn5wshs/
 6QkA==
X-Gm-Message-State: AOJu0YyZXL0+4EKPD1EcgZWgnklvP2AGZVJuwEKvQua0NYMK/romYm9x
 OnLdtpZPxHIJftNvnYGfdEiwIgEjQFKo4st9eYT+r3cLqpkd4T2d+J+OCfQJ3Ean6olhT8oa11E
 =
X-Gm-Gg: ASbGncsHAzwthabjwcdmVSVI+S/BLWmy0c/EMgiCFTUgxaK7I4iSdJGNUKoDcy1SDzR
 nEXlzYbmkZfuqYPF+yekCEUmQutVuE9eFNr0jT4e9q85A8sM5b3hZH2GHYhpdTIgh0mJt/tuZMX
 FDqA3MCYO6MT2Us7zG/FrRc3ebIHMrHLQR379TE7IoYOMLMkR5HBaogHdvNIFJK9WHZ//31TIJc
 dj2zsrfeIPdkeG59HB0qcidiBRQI3KDO2eE53NZylVgAgal126gtPSJtjkhLLfgKA/MQ4q/RJ7u
 OxUPmnbFaj8hqJxxS1iDCX4KyKyzBxutxM90ngzVXK0/anxKWKQH
X-Google-Smtp-Source: AGHT+IF8BluPrJbYbXF5sVKo5Cg2PS0otDOX2ZJgm6YLGsOK+wWBUbcV86Uw2E03V91KWter02ZJew==
X-Received: by 2002:a05:6e02:2161:b0:3d1:15c9:c15f with SMTP id
 e9e14a558f8ab-3d18cd2671bmr99481195ab.11.1739738746715; 
 Sun, 16 Feb 2025 12:45:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/28] x86: emulation: Set an MTRR for the RAM
Date: Sun, 16 Feb 2025 13:44:08 -0700
Message-ID: <20250216204421.3560012-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

QEMU likes to have an MTRR set up, just like real machines. Add an MTRR
which covers the total RAM size.

This does nothing on machines without MTRRs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to set an MTRR for the RAM in QEMU

 arch/x86/cpu/qemu/dram.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/cpu/qemu/dram.c b/arch/x86/cpu/qemu/dram.c
index 62a301c0fd3..efacc7b3457 100644
--- a/arch/x86/cpu/qemu/dram.c
+++ b/arch/x86/cpu/qemu/dram.c
@@ -4,7 +4,9 @@
  */
 
 #include <init.h>
+#include <spl.h>
 #include <asm/global_data.h>
+#include <asm/mtrr.h>
 #include <asm/post.h>
 #include <asm/arch/qemu.h>
 #include <linux/sizes.h>
@@ -40,10 +42,23 @@ u64 qemu_get_high_memory_size(void)
 
 int dram_init(void)
 {
+	int ret;
+
 	gd->ram_size = qemu_get_low_memory_size();
 	gd->ram_size += qemu_get_high_memory_size();
 	post_code(POST_DRAM);
 
+	if (xpl_phase() == PHASE_BOARD_F) {
+		ret = mtrr_add_request(MTRR_TYPE_WRBACK, 0, gd->ram_size);
+		if (ret != -ENOSYS) {
+			if (ret)
+				return log_msg_ret("mta", ret);
+			ret = mtrr_commit(false);
+			if (ret)
+				return log_msg_ret("mtc", ret);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0

