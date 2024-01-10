Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088A4C47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 18:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381FA87AD4;
	Wed, 10 Jan 2024 19:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gQSyyPWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B62FF876EA; Wed, 10 Jan 2024 19:46:15 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F32876F3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-680496bc3aaso25344796d6.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704912372; x=1705517172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5bS8ylPX0KfMccVYUFcXIcDUfegPQDBMPpCY2vJEfFE=;
 b=gQSyyPWb0AN7WgEqlwajT8bELBRvDZVUq0gM424Wu5lkfSJOSjLAccpR+PNiPCFwJV
 CQDavYFDHRxaXzPRwMYEpu1W/ZfTqqEyNf4m+0pfrUkZrkR/V9HwSp6iU7ETMWHyIQ4v
 Qj5BRaVGN29+N5Wepz12JAhgZVs1K/LoynToo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704912372; x=1705517172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bS8ylPX0KfMccVYUFcXIcDUfegPQDBMPpCY2vJEfFE=;
 b=Zx/TNNx/YRE0Gm4zAeFnHjhumDXitfE7jpEjwyRc/v0qwJddy7Oa3WPE436yaqXh3c
 eeKrF2QjttAMAUWx02nMgyfG98b2LVqulN2mY71exd74kWGVeKWkCy7j39PQ6Pbz6jNm
 dGSH4AP5+34wJ4fLxIZ322rFCIevDEO3ZdU67Xw/s8Y9E3+K+wdF55uKKHf9ZT/L4OSR
 OvAWUSLHnrTz/M53oP64KN/UPIGklI/j9r9fF/XSFgKdUKPfgFPwOFnBxkwiCXvX7RAI
 QmZT4RYT8Bl7566lqeHDluqrQRn3pKw+w2PxDI2t/QruCAh0N/zlBbX7xucSmwXmFVI8
 K9vg==
X-Gm-Message-State: AOJu0YyIWaLaJy+ArJshXDKOtSArO9goMdDhxzNHPSX8iRTvQfJFUm9W
 qRcIMMmTdIwb0v3y5d9k3vhxhQx7dAYAoY92QNAcucaBWwY=
X-Google-Smtp-Source: AGHT+IFf8zp+2Lhb5iBCdHCm6CliTce5lF1KCRkH2ynHHajSSIYA0jDUmQse+CJZqRuIwniYFCgONQ==
X-Received: by 2002:ad4:5f07:0:b0:67f:1bec:5ed4 with SMTP id
 fo7-20020ad45f07000000b0067f1bec5ed4mr1786445qvb.53.1704912372213; 
 Wed, 10 Jan 2024 10:46:12 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 v12-20020a0cc60c000000b0067aab230ed9sm1887979qvi.21.2024.01.10.10.46.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 10:46:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/5] cmd/mtdparts: Make this select MTD_PARTITIONS
Date: Wed, 10 Jan 2024 13:46:07 -0500
Message-Id: <20240110184610.3909763-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110184610.3909763-1-trini@konsulko.com>
References: <20240110184610.3909763-1-trini@konsulko.com>
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

Rather than rely on someone selecting or implying this hidden symbol
that the command requires, select it explicitly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/microchip/mpfs_icicle/Kconfig | 1 -
 cmd/Kconfig                         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/microchip/mpfs_icicle/Kconfig b/board/microchip/mpfs_icicle/Kconfig
index 7cd5a597bbad..ce510e22e81a 100644
--- a/board/microchip/mpfs_icicle/Kconfig
+++ b/board/microchip/mpfs_icicle/Kconfig
@@ -55,7 +55,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply MICROCHIP_COREQSPI
 	imply MTD_SPI_NAND
 	imply CMD_MTD
-	imply MTD_PARTITIONS
 	imply CMD_MTDPARTS
 
 endif
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 26aeeeed03b6..d837b0990484 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2697,6 +2697,7 @@ config JFFS2_PART_SIZE
 config CMD_MTDPARTS
 	bool "MTD partition support"
 	depends on MTD
+	select MTD_PARTITIONS
 	help
 	  MTD partitioning tool support.
 	  It is strongly encouraged to avoid using this command
-- 
2.34.1

