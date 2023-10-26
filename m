Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A6AC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E3187BB5;
	Thu, 26 Oct 2023 20:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GNCoRiS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6BE487B6C; Thu, 26 Oct 2023 20:32:00 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA0628763F
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7789cc5c8ccso99208585a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345115; x=1698949915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eXLlsoYApHoieHKD3N+QSEaG6l/MZ3Vt+BjQAeba0wk=;
 b=GNCoRiS3CVbXyB1J1oe7xWUcxAeyoRT7q1gqQ1onpR9UVBTlEQAdJZWyeJABJwr/IB
 /tduUn99q/tmp0XRgvtYNoi6tFJOHj4Q4FS7TXtYLYUYbc9ua9JsMWDu6PkMzxt+ZTtY
 WL4wcDD+UKYITbc5g1WJnHJ29t0PLMcH52UYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345115; x=1698949915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXLlsoYApHoieHKD3N+QSEaG6l/MZ3Vt+BjQAeba0wk=;
 b=CqAfwbflkqjv7e42OBtXx20o7hrj2b9qOrG5FmXU+Fpw/3V/nwS1HHu9wSy/B6Zkz6
 QsE4jOKxRCPMKmRyGyN1RE56SIH6urakrDJJ039xoJURDALtX0MwNYeMfbe88Fb/ymtq
 Nar66eRqkuGN7FyaoPA6OFgxbZyShEZCbtDnSJppfYHpkjvj7Hr3IGNFyLGzXz1biOsM
 txW2uJWHqQyaXBTUU1lUyoV0cqLJIMSDVlzABaq0k+aPzKwRn/ilBxqYFN3ufuU+tcx7
 4uA9OAVrncVsu/rtCwaGfXEGl93I97W2qLkJTG8UYW4Re1ZkRGFs9nawfptRRSLYX4rJ
 0JQA==
X-Gm-Message-State: AOJu0YwjcFE6quUdH9A0HwyEdEnMEnydLz2Em/LRyaAU9feyKjPgn9XO
 G7itx0Us+eJcFqBOcmTdYUnE9mFQKxz0A5yBSisbkQ==
X-Google-Smtp-Source: AGHT+IEOHVhR0jX0BkASK2o9UhprB19BczUTWYdNZW9H6H5/hHu/aZBLew+mfKfu1suGmLe8Nds52g==
X-Received: by 2002:a05:620a:178c:b0:76c:ea67:38e4 with SMTP id
 ay12-20020a05620a178c00b0076cea6738e4mr945141qkb.12.1698345115342; 
 Thu, 26 Oct 2023 11:31:55 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 19/30] bootmeth_script: Depend on CMDLINE
Date: Thu, 26 Oct 2023 14:31:27 -0400
Message-Id: <20231026183138.636948-19-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

As this particular bootmeth requires the command line and assorted
commands to function, make sure we have CMDLINE enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7c92e0974c5f..40a04f43ee3d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -543,7 +543,7 @@ config BOOTMETH_VBE
 
 config BOOTMETH_DISTRO
 	bool  # Options needed to boot any distro
-	select BOOTMETH_SCRIPT  # E.g. Armbian uses scripts
+	select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
 	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
 	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
 	select BOOTMETH_EFILOADER if CMD_BOOTEFI # E.g. Ubuntu uses this
@@ -671,6 +671,7 @@ config BOOTMETH_SANDBOX
 config BOOTMETH_SCRIPT
 	bool "Bootdev support for U-Boot scripts"
 	default y if BOOTSTD_FULL
+	depends on CMDLINE
 	select HUSH_PARSER
 	help
 	  Enables support for booting a distro via a U-Boot script. This makes
-- 
2.34.1

