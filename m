Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1F6CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 21:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 724168329F;
	Mon, 29 Sep 2025 23:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k60+QpGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446A08319C; Mon, 29 Sep 2025 23:50:47 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B668319C
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 23:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-76c144b06fdso51134987b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759182643; x=1759787443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CUBIO1zPUPoZHmaY/LZtCzPzDRPPdJVAbkDSpfyK7pU=;
 b=k60+QpGZ6am2c9uE2W1z6UuPrMgdHPAejaPGl6nyn6PmbBhYle8KWJTU6hdIzPym4M
 dK6Hb1C7HAbWNUVshwjDN66I9la0gWEl6wgImSm/MVmFqH58Y94ATBDt5fC7RGe4Jwiq
 FGTq1rrL48x+NRLO5KkwCf8XQyy+8cYANqL3p0xdhzAuBCU9RL27zZP49wSgK+lPXmnT
 Z5xmGNDZ3gyEo2QP5cgu4RbUWQmJF58USpgoRwQSmuCL7sBqZRDjDbg4I1HNEICmR79Y
 NWckxeFC+bLRcZF2u28qnz3T5kzrNVK4oj9PM3SeP3dHTb0S7aqYU3nwIvugxnjT49ur
 TnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759182643; x=1759787443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CUBIO1zPUPoZHmaY/LZtCzPzDRPPdJVAbkDSpfyK7pU=;
 b=D2ujbik+2a6RIIo2tV+QF9NK9z6sTO0jly2JYqyGbJhPxCFiZ89PwcPDx88RgBTq2w
 1e6yolokgvFjbHDhjUuVW6mO/HQCsTk/x96J70GimVLLkhSv4HJ73rrGMPm7xqdpdAYO
 8zdRBOdV+RkIVCSkuC1My7BniEmMV5/i7FOcL4Lf1QEVC3/iHzomPrcvURm6sDUIX+3i
 h+iJ3CwfWWQR7MbBtnXkTWotogb4tVXmwqcd3B8nXGuIRxnfFmweHf4zA+gu7cMun3wp
 13C+9CLAogdnK05qU58Czgf8KY9muuDc+nlMulIx96EmYQ3xFB2NLYcaHefAkdniB9gd
 REVA==
X-Gm-Message-State: AOJu0YzEAyDqmTF7LgOL8oGJjPKgDyrn7UZXSNO6vzryG+RA4M478lrq
 WpYO/MRoflsKzcQuVF7m+7rgvKj/LqIdKwgDWDzD5/fuXYXPG/te3bXziiDZ8g==
X-Gm-Gg: ASbGnctRpeap0poSPrDcBEXrUYpojKIypSfuxmTA3Xb+ikGyjrKXzVJB45Wist9IE4f
 fd7bLeycqCOuxsPqFCP7DnCUwnjLM18bdlIXsbAizEkRJaSntajzgX91cRGEBv18ds7HpNwAvs5
 JrW97BWSz6geclmSvfFEwUt3kKcmhFo836tUSo/D3zIH9HKrXm/4VeeYzSJ5qIaEkqcWy5FQhla
 1bkeqFT0QuVgGmyLGc4J4ruNs69rTDOZz9qUYIYbqSyqiUOz2487NmYcdtfHAblkQSlMbqVKnFu
 NxVCRdEeoucgdKuIM6BEwLRPwZl4R9LoZyPpO2G/Wopc8ldWSc/3cfrTMp3mM3n4ly6CdRURHnG
 LMQcXgaRxTGpz01OUKQ7I5I7MKu3OYypTL6z8nxM2SMAlNzO4hwPctimq/ocNy24zjWbm0R6rR4
 fqYSoh6lyPEg==
X-Google-Smtp-Source: AGHT+IGEvmtoIdRjf/NoKw3x/Le5dvyY73nMyMmPDW0OQcwwcePkgkmNNHYTcFce+LG3ui96QChppQ==
X-Received: by 2002:a05:690c:15:b0:77e:a0c0:3ad9 with SMTP id
 00721157ae682-77ea0c0521dmr4778577b3.34.1759182643481; 
 Mon, 29 Sep 2025 14:50:43 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6361e8c25dasm3698366d50.4.2025.09.29.14.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 14:50:42 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH] pci: mvebu: Unable to assign mbus windows for 2nd pcie
 controller
Date: Mon, 29 Sep 2025 14:49:12 -0700
Message-ID: <20250929215006.6654-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Correct the memory and IO mbus windows size increments in mvebu_pcie_bind.

Currently, pcie1 controller resource_size(&mem) and resource_size(&io)
checks result in a failure. This is because mem.end and io.end must be
incremented at the end of pcie0 windows assignment.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 drivers/pci/pci_mvebu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
index 77815513b76..3985bd59607 100644
--- a/drivers/pci/pci_mvebu.c
+++ b/drivers/pci/pci_mvebu.c
@@ -763,6 +763,7 @@ static int mvebu_pcie_bind(struct udevice *parent)
 			pcie->mem.start = mem.start;
 			pcie->mem.end = mem.start + SZ_128M - 1;
 			mem.start += SZ_128M;
+			mem.end = mem.start + SZ_128M - 1;
 		} else {
 			printf("%s: unable to assign mbus window for mem\n", pcie->name);
 			pcie->mem.start = 0;
@@ -773,6 +774,7 @@ static int mvebu_pcie_bind(struct udevice *parent)
 			pcie->io.start = io.start;
 			pcie->io.end = io.start + SZ_64K - 1;
 			io.start += SZ_64K;
+			io.end = io.start + SZ_64K - 1;
 		} else {
 			printf("%s: unable to assign mbus window for io\n", pcie->name);
 			pcie->io.start = 0;
-- 
2.47.3

base-commit: ce4cfd7c08136433a9ee9307e90c636102151f01
branch: master
