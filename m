Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1872CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FFC848FD;
	Wed,  6 May 2026 14:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gSZB1h5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D9284897; Wed,  6 May 2026 12:31:10 +0200 (CEST)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1B684882
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 12:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-12713e56abdso611083c88.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 03:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778063466; x=1778668266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQe9yZtz9BZYre9YF3dbg+DL1vxu/OYHc4jH9RAQ0rA=;
 b=gSZB1h5e3q7H0QVprvIi4zESYqzmmPZr+tUSL+j3PFm9XtilY2bSWqY4IMOMj7mEVi
 fggBu1St4vjCZ+MqtScI7xGQfMS6Gd6Afo3+nu/7H9BtBg/z/YWJiLBcq9/+5z5Co3x8
 g2XY8ZHgAV3Yp1SG5hp0C1zA/nV2awU4SGh0CIh8tf3U+nodPXhGf2ZVdNDx2T406Lii
 l9U6haYmBJdKvRMsS7wvk+Cw57m1JC71WHgkCvCTqSwbNPukWPlr42GPVMHFboQDq3O0
 Un1j7WLkOD+7tjGFIF5boz97CWQAg2fL4Ml/f669o+rUKuAZ91DFSY6SMPqAxUga2dE3
 i+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778063466; x=1778668266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LQe9yZtz9BZYre9YF3dbg+DL1vxu/OYHc4jH9RAQ0rA=;
 b=GlG3DMubyyquBU3tHbAb/TwI9cCBjIawnat2a8BAqlS0vePvf34KofQ/gxhj3o15zQ
 Xj9mn/zS3WowNkvVam4TP/gglOTd7eJlEIfP01LP8sXPl85gYEbzB19XMltP0CyujfAu
 PsZG6xlLYKHE5otBMDiIsrZIIplKW4WyHTNF7f3wX/QNtr+YC9xxVXHxXDDSs/3dL+QF
 dRDEFkyIakt/gm6beOVU4mcIIQvdq/dqDRV8KbBuTgbAMWFljvlbfo3GLYr8AMPsBAZ1
 +NN5ZPVIdBAw98picHKc2+U52WfWXDgri5ttCmbNO5cWbsnSWD4cxCkJee3WfrRym46n
 U30A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lXXmMozvJZn22gEltdtIWWnIXrHUWansBEf1RAOY9ilWodH70SbKtbu+/ON1Lkxn2/AkrlHg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywmr8SUOYdZyHrxHMqngZ7kLxldCL3n+ksFo6ep+xokOK0HRzor
 5ZHH4vu2od9z8a/v3rfswIcEbKmqlpne03WUrHW3vlgUl7wAVeOFmgnd
X-Gm-Gg: AeBDiesZ784NaG/xeMUtY2YyUZWhqgCx+KjzTcpflv68XmgsHqRgkJfdwHyg1L54xbR
 Waxh+1Xd9wODRFD3x6Sa9bD8X+vfxgVAGSWxNGbFd76bXIwedsl/be52nV2S+IB56hSk2+QKIg+
 ke1tCTc/PHmjHh4QpgxsDFBlNvaht/hyassSwbmPLvG/n9P7Ifi0F0MUDdQrwMvV1xvBZGww6EP
 oCY0IJH169uHe2EaJwtbhxfi2DS8yp1r5l4MCtHiMgNy5rYXRXahUNFqsDVuJMnwOlWltnzfhxf
 LP73MEev93OEc5zC15ftE/NLWTFnXhzAghP3ptNwXehjy18TgR2r/e6uMPOR0LQ5/jCE8P2jWZx
 fJeR4vuoLSK2JLr2spztWsBrI2HthJY9FPPj+VmIPCGhvUr9U1oYuqegwdGMRy4Srf+kYGUb0di
 YCUOlMAYLZ5qKEfs0naTw=
X-Received: by 2002:a05:7022:239e:b0:12d:b401:8de4 with SMTP id
 a92af1059eb24-130a98f8fe7mr3391273c88.8.1778063465195; 
 Wed, 06 May 2026 03:31:05 -0700 (PDT)
Received: from Sun ([107.172.49.54]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56f88f4a4sm2509969eec.17.2026.05.06.03.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 03:31:04 -0700 (PDT)
From: Ssunk <ssunkkan@gmail.com>
To: anshuld@ti.com
Cc: ssunkkan@gmail.com, takahiro.kuwano@infineon.com, u-boot@lists.denx.de,
 vigneshr@ti.com, Jacky_guo@xmcwh.com
Subject: [PATCH v2] mtd: spi-nor: Update XM25QH512C to XM25QH512D
Date: Wed,  6 May 2026 18:30:53 +0800
Message-ID: <20260506103053.537-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <DI5GHDQSZVJL.2WY7OPMAER9IA@ti.com>
References: <DI5GHDQSZVJL.2WY7OPMAER9IA@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 May 2026 14:46:02 +0200
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

The XM25QH512C has been officially replaced by the XM25QH512D according
to the XMC Product Change Notification (PCN). Both parts share the same
JEDEC ID (0x204020) and have identical parameters.

Update the flash name string to reflect the current active part in
production.

Reference PCN document for the replacement:
https://drive.google.com/file/d/1e-FfQFAD9qqlOO3iWe6PXY7EeGyN1e-l/view?usp=sharing

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
Changes in v2:
- Added Signed-off-by tag.
- Added PCN document link in the commit message as proof of the part replacement to address reviewer's concern.
- Updated commit message to explicitly mention the PCN.
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..3b8e309e0f2 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -672,7 +672,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QH512D", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
-- 
2.53.0.windows.2

