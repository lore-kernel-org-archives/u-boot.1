Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E520C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C0186521;
	Wed, 23 Aug 2023 23:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MeEzcvaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA8E864F3; Wed, 23 Aug 2023 23:11:21 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF30864EA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34c5fec2a95so16199915ab.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825077; x=1693429877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0oJ8IJUQlBAihiKEgF7F1hOKTMS8z2rIDLCYkkmJkY=;
 b=MeEzcvaZmYQOjSJQnQT6yTZJvsmQzGQnObSozYVN7fuoYUz4Zaixki9ex9fqzgggmp
 m6FosS7sqhH7F1bzCRFqyciXQ4F/Ur7dqKj5xQ7E2FHAN/NVloteNViclu97A41+/H4t
 KjIZFdApz6tTitccn7I6iC6wlJjFGckyzozTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825077; x=1693429877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0oJ8IJUQlBAihiKEgF7F1hOKTMS8z2rIDLCYkkmJkY=;
 b=L8PU8lCO8EYjKGgzNzYxTPwBdfdVt0fS0Tis+n4qyUyiVfYMSpswMzl9yybuVNDFQm
 yjHoA6p0/+u796ywiwEfjpskTPJ5j/6AfYVd4hn2710+iFxlk4wwG9qlXlNyLn1fKUWc
 08NYul4D6E+Msub08ehnYzvV1FEDgycwlJM/TapbCJhZxp/vNNC8g7zxkbF9M+vDFKNJ
 q7RWDW2EHvz5hOFXFs3Z7KAhgFizegL5anqcNNJt4UB+vsiguz33iWxQJHYtYlXtPsAT
 qkZOjCS8NwAYC83dpm6zbMN55RXV22CBNA3zfHwlZlmsdUNz31XC2tEC4KWnkDsZltuI
 Bfcw==
X-Gm-Message-State: AOJu0YzHo+3BIkP2Wx9t6wwhTmrJzJ1Z3ivLdAbEYlxiSSyCP0GQsYXF
 lbv9Y0OZMwwlj02//54H7LhaKJFBLAbQ9XuSguQ=
X-Google-Smtp-Source: AGHT+IG7dXvuhgVXJI/Ti8wVS1aoAQaHMEjABAcxmmmI791mrMcuNf5sEvP6SErn714SAhb78FlFAA==
X-Received: by 2002:a92:ce04:0:b0:349:9665:38b with SMTP id
 b4-20020a92ce04000000b003499665038bmr3588779ilo.30.1692825077495; 
 Wed, 23 Aug 2023 14:11:17 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 12/20] x86: smbios: Add a Kconfig indicating SMBIOS-table
 presence
Date: Wed, 23 Aug 2023 15:10:29 -0600
Message-ID: <20230823211059.1235147-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index 1d63099b8e1..dac0e32649a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -984,8 +984,8 @@ config BLOBLIST_TABLES
 
 config GENERATE_SMBIOS_TABLE
 	bool "Generate an SMBIOS (System Management BIOS) table"
+	depends on SMBIOS
 	default y
-	depends on X86 || EFI_LOADER
 	help
 	  The System Management BIOS (SMBIOS) specification addresses how
 	  motherboard and system vendors present management information about
@@ -1054,6 +1054,19 @@ config SPL_OID_REGISTRY
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
2.42.0.rc1.204.g551eb34607-goog

