Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145D1C79FAF
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D9C83EDF;
	Mon,  5 Jan 2026 19:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aTXGqcE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA8D83E60; Mon,  5 Jan 2026 17:53:04 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FECD83DEE
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so856205ad.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767631981; x=1768236781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvOnPrZQCv5Ybc05xFg0BXrQ4UtvqJbf4/UraKs7VG0=;
 b=aTXGqcE3W03ifFxJTFqgyluwbqdnVVQrzQ/PYHWqKYGZQxqQYG84gHEVpCDYNJaa88
 Z0AkdP/Iv6xzohdu/E0rcaSGxuV3dr/CtWgCWWzp+ebWUGsyP5hfOROduXaGO1RZFU+2
 Ebcpp7rN776TtqvuMy0PllEhIgiKT1H/f5f99FKMhenKtpGfTB5QPiO9Iij+QtndwVER
 aevgq0v5j4NKE4mN96VF3HswEVjFNQxhmWd47CB5dMgFwqWHuHCK1OsVEeEBOa+vkgdp
 vjJgZFaQpRuiCJ70901doiHsRyB5pud6sImP3s9lFe5+SO/BxtCAKde+0iYl5MYSENPW
 hfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631981; x=1768236781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YvOnPrZQCv5Ybc05xFg0BXrQ4UtvqJbf4/UraKs7VG0=;
 b=TEzADJKBH8FSMowYx71/IZsaqCIMjO0xsd3gE677EdHWebj9DIlqOCid2QoA3/CIc2
 X54Dg0AWvDBILGjHDp63k98dDI3Mb8+pg4MxiDmsjVdgaj0mCBW7OOiy5CbOv6Vl6crj
 hxcsGKfM3zd04qHJ8Mwb4eCIVy3wj/HlKbze8WfdYQglLdMzvF0sb4ZNCUIPMnhGMy3z
 4dNSL1oVFBTEwnhBpfZlxHHgv5qLsoM4Ejcn24AcJVimzytWVMPm3GNYOJIwmeR8awtH
 7/307lII69aUB5dzWTmesMjgAleMlirXVaPToVD2CAJHfrqWd+7raMlr9UjGZHb+rTlC
 vh0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNw0/Nc4Ex0h/LQNNM/TCbLaUcfWyZm/j5L1Mo7mgH/4IITniPtbJpRUVkBbe0BadIlCE1nHo=@lists.denx.de
X-Gm-Message-State: AOJu0YyiPM8vgvrx2MJIxIHWnoLhjMNf9qW4146J1blmloO/xae9gCCH
 EA4Q8QWpjA2cyFP98ouERlCHehfzFrC2/xpiS5zKREWpmxk+CWkbpX1D
X-Gm-Gg: AY/fxX6isbT/LFRqMCLf2+ECYstVgmd4H2R6hMMVMUZ1g9vRnqfpd6FdFZrBpI7a/7v
 cjlQqAm4/KiMEA+UEZ4zJez+cy2yICcsj+E35pBGcmmEsfaSTQlFKVmV+0PLajULGXoE0kyqBcm
 YzISoI4fSAaSBfrAdOBFTnceRkYt8dtpqgogDVUTrkRN2D5tB5Yt0ezOgtZXtMGJOVHjWMVyxC7
 ugYFB4MAblyEkHZfTn74qE/W63L0HAiV0FlB3srDznb7TB2s65+jp6D2ucqwRCMaCpeFZdbgc9x
 V0UCBJINXSx8b0eIE/yQVbO2T5X049BIZ4NyPRhSSCLtGbl5vaQL2XMqqHzCwNnxEjXBQybci31
 VZQAX+390yf7cwFFtGSxjEkDZ695ruKQcVtuI3GTAkTgaOijR5GVV4nfZEZqENZaoW09/Skbn8Y
 cj6/y3rVaJVkpf7f3vGsk2rzMFQqaW/as3XSA7SafzyEWxKDvWWb4DtgwHOvt1GQ2buOXCtLXQH
 4aqZe1kkwpYIdA1bJqiGw==
X-Google-Smtp-Source: AGHT+IHCfLdBQlgZZVvQts80RFc3QJa/0ZcNfmff/Qb8c84Pvwvhmp6M3BOzMr2qRHOHhoYIGGG1gA==
X-Received: by 2002:a17:903:2f8f:b0:2a0:abba:a2f4 with SMTP id
 d9443c01a7336-2a3e2c9213cmr3425425ad.2.1767631980705; 
 Mon, 05 Jan 2026 08:53:00 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e2ba8748sm2707435ad.101.2026.01.05.08.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:53:00 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 6/7] CI: Add test jobs for QEMU m68k virt machine
Date: Mon,  5 Jan 2026 16:52:20 +0000
Message-ID: <20260105165221.1816070-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260105165221.1816070-1-visitorckw@gmail.com>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:16 +0100
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

Enable CI testing for the newly introduced QEMU m68k 'virt' board on
both GitLab CI and Azure Pipelines. This ensures the new M68040
architecture support is built and booted correctly in the emulated
environment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v5:
- Rebase on u-boot/next branch.

 .azure-pipelines.yml | 3 +++
 .gitlab-ci.yml       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 81a36da7114..e9fee478117 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -520,6 +520,9 @@ stages:
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep and not efi"
           OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
+        qemu_m68k_virt:
+          TEST_PY_BD: "qemu-m68k"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_malta:
           TEST_PY_BD: "malta"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 28a32f9f4d3..ff805fae054 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -417,6 +417,12 @@ qemu_m68k test.py:
     OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
   <<: *buildman_and_testpy_dfn
 
+qemu_m68k_virt test.py:
+  variables:
+    TEST_PY_BD: "qemu-m68k"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_malta test.py:
   variables:
     TEST_PY_BD: "malta"
-- 
2.52.0.358.g0dd7633a29-goog

