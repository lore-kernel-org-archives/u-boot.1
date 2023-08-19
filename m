Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1F8EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDA58704C;
	Sat, 19 Aug 2023 23:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jjHY2ofd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C208700E; Sat, 19 Aug 2023 23:23:33 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C036786C20
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79210064604so50056639f.3
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480207; x=1693085007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXYjzViUsnUG/ZXUfwQGaAPljaNx51SDyFNMQN6zgRc=;
 b=jjHY2ofdMxwy732iGrRp0T/hhbTCmBKFfPaaDi+yUPq+fvVJUABdiFVhnnvrD+KPBK
 V8DagqZ+aqVfAlNypr4ojxXA3eCbgxuMfXHZQaTZhUbCA2zIE4O/QSAvp3MWozyxtDO1
 XandVYPA0Hsy+efDwlJ/pN8IXSDX7NdT9eTNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480207; x=1693085007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXYjzViUsnUG/ZXUfwQGaAPljaNx51SDyFNMQN6zgRc=;
 b=C2vvbN2SniDUsxSE6ccZ/nYZm84ZeE4slhP+mXbp9kINpnzVUJ7f4oF6nHMJj9Nje5
 DFk5dHUgZRYW/O0wpTH8bTp+j/Y2VviJ5Rs1kZf8fbRWtMX69Jwx1lkuP8JS9Flsm1x8
 jyEENAviTnD/orT2nX4GgT1jex4h3uNgRfs3AC4jyNwj2mTRTkO/znXTgye4RTqPOPVi
 h6ug9xpVpBMc3uZuSwhBDV01bdspoONmsU5pNJrayo/Z66Rc/y4mRwsdAVDF6dDb05V0
 ahGMjJiL7ETBaHRK9yVIlwNXf0+qqibOyWDY8p/CAxzX8knzSR0QxsKZx35oUTkwjGB3
 evZQ==
X-Gm-Message-State: AOJu0YxDSDbeD02PfnVL+D4tfHV6N4oDkDPeUeTWhgvZcKYMg3wV40l5
 jefgN+PCtyIxtKwSC8+31fkRpnQlRJPTIKx09ZU=
X-Google-Smtp-Source: AGHT+IHxxW20N2bF8GHMURu79SU/7ckh1UlOQmi7KQmaMUOSvWeaBBpWLLsQr7A5oYc7a/vGwAeq9Q==
X-Received: by 2002:a05:6602:2c87:b0:791:8856:a8e9 with SMTP id
 i7-20020a0566022c8700b007918856a8e9mr6086767iow.3.1692480207415; 
 Sat, 19 Aug 2023 14:23:27 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 12/19] x86: smbios: Add a Kconfig indicating SMBIOS-table
 presence
Date: Sat, 19 Aug 2023 15:22:50 -0600
Message-ID: <20230819212309.1094440-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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
---

Changes in v3:
- Allow SMBIOS if EFI_LOADER is enabled
- Reword the help

Changes in v2:
- Add new patch

 lib/Kconfig | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index a9dca5f52b5a..8901b3a87fc2 100644
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

