Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFF3CCF9EE
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 11:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E2F82E34;
	Mon, 27 Oct 2025 12:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VgrNIApu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4B6836B4; Mon, 27 Oct 2025 12:56:50 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C5882A9E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7a26dab3a97so2736152b3a.0
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 04:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761566206; x=1762171006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t6OR1g6k0Xa3d6omZs/zxiMXTok2xA0K6EJw+91btaU=;
 b=VgrNIApuWS8l0B8lBC+fXy6j+pEi3RxyGcSu9f5NLAUe8SuRVr7bXv8Xeg3am0A4Ha
 sH7MvDKM1XYe+h3XKn2ICqBS9a/N+GxTtxiCpkX18joc37iI8vbce1BIG1mzwwNwhRsJ
 +MqZgfOj6YD+2u5KzZoz4GukQsFj7PoDBtU3RoiFzRIpssiD0bD19cvMH+iwQ2CD/Ptm
 YRvd9F50zDzivhoahOX1mDCkHKcNesV74EGiqMrYmgXlNwh54C4yXX7GycNpFdNZ/E/0
 mnM7Skr2sHhLBkdckS3vOIlvxnT586GFeGbeEqFsKQQ/MhOBUNt4+iAiF3KgzDcKCEV/
 PyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761566206; x=1762171006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6OR1g6k0Xa3d6omZs/zxiMXTok2xA0K6EJw+91btaU=;
 b=UfHr35ufyzcGulGtzr0xqWl877pK1+MLVeTQKQUF6xY50sv4iPO+hHWe+UUFjN+Tfn
 HvzzFjbzXxDeMW1Nx+pXh6QaNpTMh/fQpLWuib/nejtG0t6Y62zazROXkPMXEh+FIpP6
 FRklLSXw444UMtjB0+9zuy3z21Kc2IO4d0e+QEgNhyoolEgCKpWZCGayUwwSA1SQHFri
 c+UBkUGSGsjh9X1ixTyltNG3iQvcHheR4UQDsF4pyXbePSQWGdr73X5wZb/V0muUKn2R
 zy7Z5w/dKB9Lmg/Ttc3q2I5cQuLuBdGNyJ6zu0sRq91GZ2Nfbn0rLRr+rot1nj6XWcns
 wdyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+CYR3du9xoQyPS5/+s/+6urxjulgyVen1GlHF7zj5bET+GWVg9z05lgzYIloNhdA5khBf7Mw=@lists.denx.de
X-Gm-Message-State: AOJu0YxEdISXyi+1c90jkk5a2OzRd22ezfKgqEKjawIcmKxtrY9OD2+S
 8IMhgPjysbzi0AXCrjC8BugSzFkTX1nH6eBDo3aquP8Vls8qtiMl87HxyiRNaYDL
X-Gm-Gg: ASbGnctF7INhMur3shfI2/Zezn0uIDpZwyH14dRi6uAfijgAufYmj6WuJX8bEUfl6br
 f/qZ1LfjoX4xYuQ1PoDxeikSLFu7Fx7DSUpvLx+2eaCe1hgt6PUBCiDedoJOfFL6m5+3ecGbODb
 H7nmDiLe93NldtT2TIlzm/+djE5Pf9+eu4XVLMXITZgWF7L/ZlpDtNOQN58d74H0Z4sbaODaInD
 DJZWVhH0Rw7hLyyaLJbc9SQIen2S/ZZzAgKbaGXg1by77sVcq47bcsjfv/WWX4sd4zowIqzfZOy
 qHuWBVl9va8B/OSATsS3Mhum8TaDoE79eOkjs6mILV66z+NAPGhS7gbeyYMpwLRhieRQyJlZ5tm
 9z6a9l20bNFodhmGhK6teUTNuxHgQAY5MvMNMErBik7QL/k6n5/xrpwbU+WPc/DFfNNqR5CtWJn
 aGuMctw8yqoflboJIYSnBQKUqzel4W5WavWJo=
X-Google-Smtp-Source: AGHT+IGP6KJLipOuOep0Ifi0kCqQ28xaMDX/Ut6Edrfo/HINOp2Wu59V3ybj8fg7uvE007S0V85MjQ==
X-Received: by 2002:a05:6a00:22d4:b0:7a2:1bfe:ac75 with SMTP id
 d2e1a72fcca58-7a220b1995cmr42971742b3a.16.1761566206251; 
 Mon, 27 Oct 2025 04:56:46 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:eb22:2268:4f98:1acb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414069164sm8035286b3a.45.2025.10.27.04.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:56:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: uboot-imx@nxp.com
Cc: trini@konsulko.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, u-boot@lists.denx.de, u-boot@schwermer.no,
 Ye Li <ye.li@nxp.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and fix
 comments
Date: Mon, 27 Oct 2025 08:56:38 -0300
Message-Id: <20251027115638.1186252-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Ye Li <ye.li@nxp.com>

The change in commit c1af358cf51a ("imx: mx6ull: fix REFTOP_VBGADJ
setting") is not correct. According to latest i.MX6ULL fuse table,
the REFTOP_TRIM[2:0] fuse is defined as below. So the previous codes
are correct, only need to fix the comments.

Set the REFTOP_VBGADJ field in PMU_MISC0 register based on the
REFTOP_TRIM fuse:
'000" - set REFTOP_VBGADJ[2:0] to 3'b000
'001" - set REFTOP_VBGADJ[2:0] to 3'b001
'010" - set REFTOP_VBGADJ[2:0] to 3'b010
'011" - set REFTOP_VBGADJ[2:0] to 3'b011
'100" - set REFTOP_VBGADJ[2:0] to 3'b100
'101" - set REFTOP_VBGADJ[2:0] to 3'b101
'110" - set REFTOP_VBGADJ[2:0] to 3'b110
'111" - set REFTOP_VBGADJ[2:0] to 3'b111

Sven Schwermer reported:

"These are the symptoms: Very few of the thousands of devices that we
manufacture (< 1%) fail to decompress a large XZ archive once in Linux
userspace. We have not found any form of memory testing or other load
that reproduces this issue. Reverting the offending patch fixes this
behavior on the affected devices."

Revert the offending commit to fix the regression.

Reported-by: Sven Schwermer <u-boot@schwermer.no>
Signed-off-by: Ye Li <ye.li@nxp.com>
[fabio: Fixed checkpatch warning and added Sven's report]
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/mach-imx/mx6/soc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 50521490b354..02df86156d41 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -360,23 +360,21 @@ static void init_bandgap(void)
 	/*
 	 * On i.MX6ULL,we need to set VBGADJ bits according to the
 	 * REFTOP_TRIM[3:0] in fuse table
-	 *	000 - set REFTOP_VBGADJ[2:0] to 3b'110,
-	 *	110 - set REFTOP_VBGADJ[2:0] to 3b'000,
-	 *	001 - set REFTOP_VBGADJ[2:0] to 3b'001,
-	 *	010 - set REFTOP_VBGADJ[2:0] to 3b'010,
-	 *	011 - set REFTOP_VBGADJ[2:0] to 3b'011,
-	 *	100 - set REFTOP_VBGADJ[2:0] to 3b'100,
-	 *	101 - set REFTOP_VBGADJ[2:0] to 3b'101,
-	 *	111 - set REFTOP_VBGADJ[2:0] to 3b'111,
+	 *	000 - set REFTOP_VBGADJ[2:0] to 3'b000
+	 *	001 - set REFTOP_VBGADJ[2:0] to 3'b001
+	 *	010 - set REFTOP_VBGADJ[2:0] to 3'b010
+	 *	011 - set REFTOP_VBGADJ[2:0] to 3'b011
+	 *	100 - set REFTOP_VBGADJ[2:0] to 3'b100
+	 *	101 - set REFTOP_VBGADJ[2:0] to 3'b101
+	 *	110 - set REFTOP_VBGADJ[2:0] to 3'b110
+	 *	111 - set REFTOP_VBGADJ[2:0] to 3'b111
 	 */
 	if (is_mx6ull()) {
-		static const u32 map[] = {6, 1, 2, 3, 4, 5, 0, 7};
-
 		val = readl(&fuse->mem0);
 		val >>= OCOTP_MEM0_REFTOP_TRIM_SHIFT;
 		val &= 0x7;
 
-		writel(map[val] << BM_ANADIG_ANA_MISC0_REFTOP_VBGADJ_SHIFT,
+		writel(val << BM_ANADIG_ANA_MISC0_REFTOP_VBGADJ_SHIFT,
 		       &anatop->ana_misc0_set);
 	}
 }
-- 
2.34.1

