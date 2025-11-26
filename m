Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F38D10F4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2694483734;
	Wed, 26 Nov 2025 14:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aYTPwdL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333D3838CE; Wed, 26 Nov 2025 14:41:35 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA56836D1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 14:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so44764745e9.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 05:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764164492; x=1764769292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XeoE5Hcelt9yNTXpo3niFqNl8aDl6Gflea0LpHUoADU=;
 b=aYTPwdL12HO9KkxjnEaApoCV9ma5vhuYwVJPF+HwFd1Cnzexw2XDUJm6U6B10K6CCY
 iQNKcwI0aw1OlxyMI595m1EkHMJ4ZWN7kGszPurx5ThdZtOrIqp8EV+4eIP8UGuPUtu4
 uvbao7Cytgb9xNRljb3m7pXINYTFHbljBEUWUzfWHrOtvcLpnnJC/RaoDB4A1Li5WpeT
 Sum5FnWsHUpiFI3B6rU8sgiiqT1TrsQh1VpsSiGjfDvsKDMftsEdYCBtwx894LXFjXVi
 uEotf89psW3luWPPI6dZcS7yKMPbHlvklAssdHyhsppvmwdgfhuZwfQW8G4706dqcqVE
 2rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764164492; x=1764769292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeoE5Hcelt9yNTXpo3niFqNl8aDl6Gflea0LpHUoADU=;
 b=dNlKIj5iyJ7zFzR3U734jJ1Z16M8dqlI4Ajqt8YNcx86Y3VajsN6ur+pDxMIjDN9ZO
 2wqr5XE0kVjCeWlumcvvFXHiDa3VXe3DwLdP+Lh5gMmWMmt6X+XZss9dF8RfCz1mmeBg
 yOrGXTQ2/feuHOBHMcj08yet5JvyA+hS+/KjviQDB85tZVNBduUcs8AAeinBtx1PfEEv
 0r7jGSfJKNDXaRQbT860jcY5/GrK43wTJy/B8b11MEg68+lV6Kg0hK88AvOJygT24uI8
 IY+LxRHsyEDH7F1eLmgziMOZsfuL40rU9zqrgqvgbQB2XFxGqtc+P2MBe4g2rCsqW07M
 YprA==
X-Gm-Message-State: AOJu0YwYrHeiSXTbU3iIlM10/FcBqTGWPrCun9dY0p5nkG0Mrdc08lfN
 4pv+d/5J4ALcy13dtUft+YhGMfFQCVIPEBmH5EWsKWFxYQjCoB8Me9AlzNde7g==
X-Gm-Gg: ASbGnctoIGj+M301rRMsDAvmXWR6aPYel9lA4mGeuPBpzGWQSxMu/j9AWHaHJ9JXeRM
 OnKgBHgXeD8xj3QolPTfBpe0MgBH7qtQDgDskgxEy/+v2myrGPDL9QnhPuEarZ8QPlhe/ZYjWIb
 L7Ibi+oL/STWftizBaa8rKspmHAVRdraKib7zVRRrjpYEWLPjG26H6e2OtpMYaEdNRlB0XiqsmZ
 NL7aYJdrkC1BXXFZbj6d/fIzJK+c0IgdbLOezJeSheWpot3AZEyCV4NyK3cn+vh6av5AS3nJ37i
 yAj0tNqMKuMc64fl2FrgFEMIrgR9btjClBMK0aJLWJVqviSt5kFFy06SWi/y2bB3JUc8S1kMZMb
 gCmFQg8BMvK7euHsJXOz/VfRAvX04sIazerX53DK/3qKI8vkvBes0oz1YG33oRlwYwZ3QBBjGdd
 v2rPclPp24OrrHbNPWWsvmNRl53J+xO8unKe5DmpV+fm77NYM5T3Pct6DWhjcmLxoKSANS3D6S0
 Q47DBSCp5XkDRl0
X-Google-Smtp-Source: AGHT+IFvrvfFUApZsKI5kycEds+YOEjlFpCnhgaGJ8QrzK44ya9G3647PQA1w0AstOflrveD2Im5GA==
X-Received: by 2002:a05:600c:4515:b0:477:63b4:ef7a with SMTP id
 5b1f17b1804b1-477c01b20e8mr145083685e9.20.1764164492119; 
 Wed, 26 Nov 2025 05:41:32 -0800 (PST)
Received: from toolbox.int.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9022sm40785872f8f.36.2025.11.26.05.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:41:31 -0800 (PST)
From: max.oss.09@gmail.com
To: u-boot@lists.denx.de
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Alice Guo <alice.guo@nxp.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] configs: toradex-smarc-imx95: set spl_stack
Date: Wed, 26 Nov 2025 14:41:04 +0100
Message-ID: <20251126134107.2969608-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
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

From: Max Krummenacher <max.krummenacher@toradex.com>

The SPL_STACK config option now depends on having SPL_HAVE_INIT_STACK
defined. This made savedefconfig dropping SPL_STACK when sending the
initial configuration.
Note that SPL/U-Boot are able to boot linux from mass storage with
SPL_STACK not set but other use cases might run out of stack or
overlap with other RAM use.

Compare with:
commit d6a53f523afe ("spl: Add an SPL_HAVE_INIT_STACK option")
commit 25fefa05d732 ("configs: Resync with savedefconfig")

Fixes: ff0540fcfe49 ("board: toradex: add Toradex SMARC iMX95")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 configs/toradex-smarc-imx95_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index c5cea6e4e5f5..5ab420ae519e 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
 CONFIG_SPL_TEXT_BASE=0x20480000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x204d6000
@@ -49,6 +50,7 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
 CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
-- 
2.42.0

