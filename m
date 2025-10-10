Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30141CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 05:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3F483FC6;
	Fri, 10 Oct 2025 07:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aP5vJf+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACBD83FCF; Fri, 10 Oct 2025 07:31:35 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE7783FC1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-378aa12c13dso573595fac.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760074292; x=1760679092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wgz38+PC5GiEx/0rRInerBoL8TJ/ri9nIPpN+p5ZhKA=;
 b=aP5vJf+RZOflCEwkoouVMJB1rUYSovN37+cwWUn/iAEmxaYocH39z9AsqxxxVJy47D
 5z3lL2fm2ZwwMS9MNNvFl8uBI1lnmNbQ6BfCzqlqh+QuE4x8682T/XvUJ/Rn7BBSR21a
 5pVrZ+1tnV/nhpJrpGki8czNlAhqrQVkpHQjF+AKFo3UqhWz6QW+FCuRZhUnGW0D7XGT
 Y/Qc77ShNsq9Pcl/oCkUny3GzO2dwyewC9GQu1/nxwRXQ8EtfnCMs6FIiBBmtAcKMPBh
 ezzdWFRowPEkaHtVdD+2AcnOGsjvgj0U8MNQtZ+0zjwsBhklrtQZ2BP0NnwRKn1a3LiI
 sF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760074292; x=1760679092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wgz38+PC5GiEx/0rRInerBoL8TJ/ri9nIPpN+p5ZhKA=;
 b=r/5CCGkDgkO1/WKQiNFt1rRaPEfAusd5qRaYunNAX+07d1wXMY3FxQB5sJQk3HQxxl
 FboMpa77tGL6PS9m72fyZtrX2kGLg4qnJyqHAFC1ZtV0fZyZA+A0W8bswXMQ32oxbISQ
 yhG0G1CK4dQaUtDU8Msft0S52vHgJAD6IjXmvQVx0gyfTsU6tRYRUZAhBW6pa36TALo7
 fIG4TDGsBo9g5jWZ5iaEu2Dr9IuGrTivwix19uZhXhC74OcloE+ofLeydiGQK/wNcIQk
 4+94lwZF3A8RriFOqNt1jGREvxFRz0nDOYF7BMNL1S2jXyD961LccfCFnYpRHhxi+a/X
 +MLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSNBsT7Vd1YvNF/gnsbfzf/akW9RPC44WREm+g86uU+8pXIjXBaaHjHAa1KdaCkPoqg69sYW4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywo/eFuOCgqz8UdhLFqY26jbglP5sWXmB3NiAGoxDyGze33rsCJ
 ZM2FzvsK9ydKILql0QBeUjRHcVOeNAocVL5TeHDu2Jrv9/JDcoDGoM9A
X-Gm-Gg: ASbGnctwwErZgWBOfhSBAInEgLD+KhswT5wV/QOqMig2KbphpysJww0Aev33VoffV6A
 7rMsnv/MY1/ZJ2KHHR8l6FpbkDZOb2hDrei7xAS+lVOK1DDjJS+BmKLvjGW1fH7u0mbKp8QVvmc
 wu423D5/GRiia1tOuDKElDDKz9HCHgeq8rd2etGweVofBqZEVFuoKkWs3qdjdGQYVIyZHVCt335
 PyEYA8eyuYH6V1+2R77w9i8ZJlN2FrZ+fuGtouPnw6YJDtdPjJZD/ashxvbrx1KTdmr2Xsa2fZ5
 uk5TAHDtYgL3yf/pzjpURJ/Z88e9V/aPal6wp7rPdsaszMuZIhJV+WJoh/kesoEoeCWmvuOZlus
 xgcqxfyIeb3yP5lQHbGHPkIqfsLLpdnXm2/T+duotZGGZDql9qaKDphZgGy8jwfM3JK8I+NZzPz
 /aKreUM66dRKE9GzDfE/yNVxtNnu9z
X-Google-Smtp-Source: AGHT+IFiATEZpGqRH8tw/ce9TxZ5s16VdegyrTvcRIfAqrZLGmowjTpLvJew7hwVbNEV7HlIDaU0Jg==
X-Received: by 2002:a05:6870:3923:b0:395:9e1b:b0da with SMTP id
 586e51a60fabf-3c0f81fba9bmr4704507fac.49.1760074292012; 
 Thu, 09 Oct 2025 22:31:32 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8d651e739sm84514fac.10.2025.10.09.22.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 22:31:31 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] bootstd: Allow PXE boot to be disabled
Date: Thu,  9 Oct 2025 22:29:17 -0700
Message-ID: <20251010053056.32495-1-mibodhi@gmail.com>
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

Make it possible to disable CMD_PXE.
Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX config.
In extlinux_boot(), invoke pxe utils only when
CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.

This patch results in about 9K reduction in image size when
PXE boot is disabled.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 boot/Kconfig             |  3 +--
 boot/bootmeth_extlinux.c | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2993cd7f9ba..403ce4c3d46 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_PART if PARTITIONS
 	select CMD_DHCP if CMD_NET
 	select CMD_PING if CMD_NET
-	select CMD_PXE if CMD_NET
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
 	imply CMD_MII if NET
+	imply CMD_PXE if CMD_NET
 
 config BOOT_DEFAULTS
 	bool  # Common defaults for standard boot and distroboot
@@ -575,7 +575,6 @@ config BOOTMETH_CROS
 
 config BOOTMETH_EXTLINUX
 	bool "Bootdev support for extlinux boot"
-	select PXE_UTILS
 	default y
 	help
 	  Enables support for extlinux boot using bootdevs. This makes the
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 921d721a27b..ceac41a1370 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -188,14 +188,16 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 
 	plat = dev_get_plat(dev);
 
-	ret = pxe_setup_ctx(&ctx, &cmdtp, extlinux_getfile, &info, true,
-			    bflow->fname, false, plat->use_fallback);
-	if (ret)
-		return log_msg_ret("ctx", -EINVAL);
-
-	ret = pxe_process(&ctx, addr, false);
-	if (ret)
-		return log_msg_ret("bread", -EINVAL);
+	if (IS_ENABLED(CONFIG_BOOTMETH_EXTLINUX_PXE)) {
+		ret = pxe_setup_ctx(&ctx, &cmdtp, extlinux_getfile, &info, true,
+				    bflow->fname, false, plat->use_fallback);
+		if (ret)
+			return log_msg_ret("ctx", -EINVAL);
+
+		ret = pxe_process(&ctx, addr, false);
+		if (ret)
+			return log_msg_ret("bread", -EINVAL);
+	}
 
 	return 0;
 }
-- 
2.47.3

base-commit: 7e1456a5f62fae19012beda3750aab1e21284fbf
branch: master
