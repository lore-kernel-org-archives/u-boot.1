Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CF3C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF52885A9;
	Sun, 23 Jun 2024 19:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BycI1dTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F9F88549; Sun, 23 Jun 2024 19:55:24 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66AA88576
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7ec2d71059dso142114939f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165320; x=1719770120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/NjtgmhdGNN51ppyRZf80LJV+wFQVnrrC1NW5Sw19c=;
 b=BycI1dTjT7tsofjdoWYpimCAbaWLYcW/P3itGKes5zq2Ww/Qf6Qdb0dDrKgDynxGZa
 1Hz4etrgtU+CYIFbnTEEKJ2dEVb7NCP1gWSVnXzogs5mSNBnyTrJ0syjHoTgBYIa/jAO
 y1KmrQRNFxT1rQy8aPgo67WXLN7lp8aVzKB8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165320; x=1719770120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/NjtgmhdGNN51ppyRZf80LJV+wFQVnrrC1NW5Sw19c=;
 b=sVvawc9TFCYi/6hvT8AALoY5sw0V2sNAbc4dOjCLNNBiq+dEEn1nfF494UVOTheq4T
 L7/Ws8b6EwZPptBsFXcEU+GoUyoLLx/yU9kp/L0G7pdF40HZWm75t12VcYw4u5FdPMJO
 W6SHyYVF2n6TTyNQOf84zM3yqVzff0rb7h7Z5HD+ZkISWmcsoQmpe10tsGhD931tI9vx
 SpkicWjfEYgXmeTAsfQQSy+vgguvp68XG3uoM3+fAQghw93aquAzY3kepGiae5aDj/7l
 O5wpKmFW/h+G+RBzHSG2Ye3Y0HPhOSq6+gFTVk4seCi2HRxm7oqmSnzRPtkHlJ32ei6A
 beQg==
X-Gm-Message-State: AOJu0YyjKK7GDIeh/Rk6dMf4EzEOLupQEW8SqRtnk3CJ8n1ouQVgkRFn
 qfgSF9xWoIzZmYMq/HJqMbM7Eh04rHs8seHGh7S1y4Os2kxDsqQ+UQ7rqYEEcRXkGbTZl36wVCU
 a0w==
X-Google-Smtp-Source: AGHT+IHnKDWPICEjIw0aJRLiDBOCvELMABqjRnmUOAIJoAxWR2hCPoDYDBOfoMNXzUXdRFwXdJKnJg==
X-Received: by 2002:a05:6602:6013:b0:7eb:db06:e067 with SMTP id
 ca18e2360f4ac-7f3a7532d73mr241284139f.9.1719165320461; 
 Sun, 23 Jun 2024 10:55:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 02/14] binman: Regenerate nxp docs
Date: Sun, 23 Jun 2024 11:55:03 -0600
Message-Id: <20240623175515.1466908-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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

Regenerate the entries.rst file to include this recent addition.

Note that more docs are needed here, to actually describe the entry
type.

Note also that the entry type needs Binman tests added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/entries.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index dc42a9cb97d..1b9b868e33f 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1521,6 +1521,28 @@ byte.
 
 
 
+.. _etype_nxp_imx8mcst:
+
+Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
+-----------------------------------------------------------------------
+
+Properties / Entry arguments:
+    - nxp,loader-address - loader address (SPL text base)
+
+
+
+.. _etype_nxp_imx8mimage:
+
+Entry: nxp-imx8mimage: NXP i.MX8M imx8mimage .cfg file generator and mkimage invoker
+------------------------------------------------------------------------------------
+
+Properties / Entry arguments:
+    - nxp,boot-from - device to boot from (e.g. 'sd')
+    - nxp,loader-address - loader address (SPL text base)
+    - nxp,rom-version - BootROM version ('2' for i.MX8M Nano and Plus)
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
-- 
2.34.1

