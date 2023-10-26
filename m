Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9451C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FD987BB3;
	Thu, 26 Oct 2023 20:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KwpPKTxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE808763F; Thu, 26 Oct 2023 20:32:00 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD4187B51
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-778927f2dd3so86434285a.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345116; x=1698949916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WiEHq7p8aMvtiykxv8utIa5Q8Rliz9M4cSuuKPx2Mrs=;
 b=KwpPKTxjUE8PXnojcM0ETyoM7ALMyEwk+/RWEnWDpQe+6230xASIu/JHOSrMdnIzuZ
 0CAZvqNwO/afpZyxarcfVS0IN12w0BpAxFVWWPtPE9PxKfm54DE39cNv0s2IfXWlTxIA
 8lQLPGFMRF+zEnduP5XUTO23gSCEwJRX6T7jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345116; x=1698949916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiEHq7p8aMvtiykxv8utIa5Q8Rliz9M4cSuuKPx2Mrs=;
 b=R0XVQeUEcGnWufEONv9j7qy2bTouF688fGiuJ0GbcE5Vxr9Puk1FIwSyLWV64YnOSE
 JX2us91A3DpkBk+ZicDryb3Cz5QZy1EQyC72T7minbn7VVdojoKgsq2qqAwsPsC1gbd/
 xug6rcFyMnYGNUJumIof3LaN90LYj7gmtEhISolt0aNpoYP3f84bSJgXOZv1o5Li6KqL
 pnXobTcMGNZ1SYM6310TJzam9fmBotOvOewiBdq8mlOu1yMuAq0cAAOqVcMOk1IxYnnE
 cUBOuzoYaGPX4HE58ZoHFvC2joOpz3/G/hmhY9OIjjumkDdcqccn3tmDmqTPN84s2bak
 yzag==
X-Gm-Message-State: AOJu0YzyI4bG3JcU0S4nbgMvsq1WW6Vg4vHDeBRQ5lUNgoHyeF9WANrt
 n37opw+Rpz8IUarnBjNkNZNSLykAfy27sox4RxKidQ==
X-Google-Smtp-Source: AGHT+IHV/lHr0DvAcqYvLYMGMLvtxNQSX7p3VtLNKuy8sZdW4nWXbf6P0rjHgbTSzvxCmcntBPuB3w==
X-Received: by 2002:a05:620a:1998:b0:778:9886:71cc with SMTP id
 bm24-20020a05620a199800b00778988671ccmr152890qkb.19.1698345116137; 
 Thu, 26 Oct 2023 11:31:56 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 20/30] boot: Make preboot and bootcmd require CMDLINE
Date: Thu, 26 Oct 2023 14:31:28 -0400
Message-Id: <20231026183138.636948-20-trini@konsulko.com>
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

In order for a predefined "preboot" or "bootcmd" to be executed by the
running system we must have a command line.  Add CMDLINE as a
dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 40a04f43ee3d..fabf6fec2195 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1558,6 +1558,7 @@ config BOOTARGS_SUBST
 
 config USE_BOOTCOMMAND
 	bool "Enable a default value for bootcmd"
+	depends on CMDLINE
 	help
 	  Provide a default value for the bootcmd entry in the environment.  If
 	  autoboot is enabled this is what will be run automatically.  Enable
@@ -1577,6 +1578,7 @@ config BOOTCOMMAND
 
 config USE_PREBOOT
 	bool "Enable preboot"
+	depends on CMDLINE
 	help
 	  When this option is enabled, the existence of the environment
 	  variable "preboot" will be checked immediately before starting the
-- 
2.34.1

