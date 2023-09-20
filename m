Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4BFCE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7892186C52;
	Wed, 20 Sep 2023 05:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cQEjZ2xP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24BD86BF7; Wed, 20 Sep 2023 05:00:45 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89AFE86C52
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34ff3ea2b23so7725955ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178842; x=1695783642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnqfsVHxbvtxsyvywy4WW48EE01uChnQp1VMr1E5BMA=;
 b=cQEjZ2xPzl70j0WQqLkSOgw15ow3Gkw2NkPHfkugmV2d0nzK4Zu+T36cVWyzmcJlSV
 QivROxIrkZIVMy5OUOfzH+GCWu1thlJPS/qwuIxM1foyofaWVoZ0/qfqiCXAv9NOLAtz
 7locd42hEfLD9ujobCtSJhW4F0ugGgtaGo9Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178842; x=1695783642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnqfsVHxbvtxsyvywy4WW48EE01uChnQp1VMr1E5BMA=;
 b=p7Lgz7QDb96h6o9HTkysEeOPbBTHTy7r+C1L9Gq3BK3HAy4VYjo+4eE1agQjIATmt6
 qPKSlxeQeN7UB78VoSQhDiDCCSYGp74B15RyNCQHa0zxkrhCAZjvVluZ9RLl88kVub0g
 QxXaS5ONHBirSOvImOL5yR8wP3viuC5CpX+IQRpNHXuPVvB32vzobxul2rZ6aOgxg9cv
 lmJBD+88lqHd/O1zNqVeaKCUjSLPzJEGTOi01QdbBqVgECx25Vs1BevzGEAqP3WsW9dl
 sVatOHz5v8nX+JXEWh5cXUMhO0xcLQaUrmVt9YITgtJhE9mcW1S35MrsZsu/3hm1TIRT
 8DHA==
X-Gm-Message-State: AOJu0YzvUHlWEQ/A9gTgg1NlQXIIhnKSVNk3rBqRAKFbMtDB6E5S5ryQ
 fQTEzV73NbxcXH8QcpRiw0pxFvVpfQ+iFcNX52w=
X-Google-Smtp-Source: AGHT+IHxTPO2gIVeOMJkZ/rxK7nEozaV/RWy99ksFxhnwXKeC/Vi/z32PquZYl+4N4+Sg2EqL9k9mA==
X-Received: by 2002:a05:6e02:11a2:b0:34d:f0d4:c436 with SMTP id
 2-20020a056e0211a200b0034df0d4c436mr1447421ilj.3.1695178842188; 
 Tue, 19 Sep 2023 20:00:42 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 12/20] x86: smbios: Add a Kconfig indicating SMBIOS-table
 presence
Date: Tue, 19 Sep 2023 21:00:13 -0600
Message-ID: <20230920030027.1385833-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

When booted from coreboot, U-Boot does not build the SMBIOS tables, but
it should still pass them on to the OS. Add a new option which indicates
whether SMBIOS tables are present, however they were built.

Flip the ordering so that the dependency is listed first, which is less
confusing.

Adjust GENERATE_SMBIOS_TABLE to depend on this new symbol.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v3)

Changes in v3:
- Allow SMBIOS if EFI_LOADER is enabled
- Reword the help

Changes in v2:
- Add new patch

 lib/Kconfig | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 7edaeebfdaf5..6b5389f3a87d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -975,8 +975,8 @@ config BLOBLIST_TABLES
 
 config GENERATE_SMBIOS_TABLE
 	bool "Generate an SMBIOS (System Management BIOS) table"
+	depends on SMBIOS
 	default y
-	depends on X86 || EFI_LOADER
 	help
 	  The System Management BIOS (SMBIOS) specification addresses how
 	  motherboard and system vendors present management information about
@@ -1045,6 +1045,19 @@ config SPL_OID_REGISTRY
 	  unambiguous persistent name (https://en.wikipedia.org/wiki/Object_identifier).
 	  Enable fast lookup object identifier registry in the SPL.
 
+config SMBIOS
+	bool "SMBIOS support"
+	depends on X86 || EFI_LOADER
+	default y
+	help
+	  Indicates that this platform can support System Management BIOS
+	  (SMBIOS) tables. These provide various pieces of information about
+	  the board, such as the manufacturer and the model name.
+
+	  See GENERATE_SMBIOS_TABLE which controls whether U-Boot actually
+	  creates these tables, rather than them coming from a previous firmware
+	  stage.
+
 config SMBIOS_PARSER
 	bool "SMBIOS parser"
 	help
-- 
2.42.0.459.ge4e396fd5e-goog

