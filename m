Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364ACC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 11:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA571874BD;
	Wed,  8 Nov 2023 12:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cz0ha4rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6D587253; Wed,  8 Nov 2023 12:08:23 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 319AE87716
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 12:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6c4884521f6so142067b3a.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 03:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441699; x=1700046499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=Cz0ha4rvoK9GGalglGTf0RF6032/xR01RPpjoiPr5uZpou8jGlE2juC7CASNpD4wEC
 xLvghyOa05eiWTtkbTB0/71KDZTFj/tIfDvj9C9r8nRzU/mW6EIAQi/E/nzeY1DQJPSs
 yGCFTBwujS82zSPHxXPJX4Aoc+FJKaiYPSNwiBE3IxREvEJUYilYyNQGPZkZJfsUbryM
 06tnWSbQTfwtUMJ5FWxV+AInVaJTGPbs5oulpRO+6coGMfuNCjvFKmTp9iHORTRh/Lhw
 zx9JSD4nWe7uL4ZtCs08bjeAGfr//lEZ6aBvY6qytUZ73ve5u8pOPmKzMmuxCaEHU4ir
 6l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441699; x=1700046499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=rCk+ikj5SqyzFMHlsjqEcLZew+C1THh01S9Z2qtZDSysC5eJVEtFgXcq66Pe4gXBEP
 V8ErqeqDf7XBiDvAWmG8i3iRv4q9Z+zQIEe8QPu+4X4LU2bYmA+8sTR1KXaYSiT0jijH
 fvOBhm+QvvizeEWVTn1ol3PFwVunDH01hqKxMziOLMyAk/PMH0+n/1iJZnB16iE3Q8Y8
 voFZpLenskWSy4IkL4lIp5Ef0gOfD1zNorKfUTepBInzASMO1Vl88PXSHZvkRcPKb8X9
 91ISLk8yisKNAB2N8Ry4VP6lJqnxZLZC6hgJYLw8aLE2E9FXhtoFr0dhb/CJj1RktvBm
 LRpA==
X-Gm-Message-State: AOJu0YyE+4N7tR1n17svms2NSsSaPNrlGpTz4rodGZL1+ptywOO8octw
 RHZjSurpAoq8sNeHr2/wsP4zCK0t96oMwiwYXLs=
X-Google-Smtp-Source: AGHT+IEeIS2Cpy/uupoF+AEP1tX8esv8x7Ybt4dJrgfEqKA0+5RqDRRd1gSOR1+TShOGUZdh+CkV8w==
X-Received: by 2002:a05:6a20:9188:b0:17b:3438:cf92 with SMTP id
 v8-20020a056a20918800b0017b3438cf92mr1687558pzd.5.1699441699260; 
 Wed, 08 Nov 2023 03:08:19 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 s12-20020a170902988c00b001cc55bcd0c3sm1497914plp.47.2023.11.08.03.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 03:08:18 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v11 9/9] doc: uefi: add HTTP Boot support
Date: Wed,  8 Nov 2023 20:06:36 +0900
Message-Id: <20231108110637.3691441-10-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
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

This adds the description about HTTP Boot.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index fb16ac743a..ca9a573669 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -642,6 +642,36 @@ UEFI variables. Booting according to these variables is possible via::
 As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
 command 'efidebug' can be used to set the variables.
 
+UEFI HTTP Boot
+~~~~~~~~~~~~~~
+
+HTTP Boot provides the capability for system deployment and configuration
+over the network. HTTP Boot can be activated by specifying::
+
+    CONFIG_CMD_DNS
+    CONFIG_CMD_WGET
+    CONFIG_BLKMAP
+
+Set up the load option specifying the target URI::
+
+    efidebug boot add -u 1 netinst http://foo/bar
+
+When this load option is selected as boot selection, resolve the
+host ip address by dns, then download the file with wget.
+If the downloaded file extension is .iso or .img file, efibootmgr tries to
+mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
+If the downloaded file is PE-COFF image, load the downloaded file and
+start it.
+
+The current implementation tries to resolve the IP address as a host name.
+If the uri is like "http://192.168.1.1/foobar",
+the dns process tries to resolve the host "192.168.1.1" and it will
+end up with "host not found".
+
+We need to preset the "httpserverip" environment variable to proceed the wget::
+
+    setenv httpserverip 192.168.1.1
+
 Executing the built in hello world application
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

