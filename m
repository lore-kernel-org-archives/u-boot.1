Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D88DC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 06:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED3D8771C;
	Thu,  2 Nov 2023 07:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ClOmdnkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83735876AE; Thu,  2 Nov 2023 07:46:54 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BC186F26
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 07:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5aaebfac4b0so439178a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698907608; x=1699512408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=ClOmdnkO/q0kR7oTl+9SsxxWY+hvvy+vL9S4RI0vPXv7Y+wveSWkWiQ7U4DJQydvPD
 Q2pP/7SgkfRE1P+h/BwbmzVJbk7QKHRQaQ5lthUe4NICqJR9Z2bApRGTL0VjQN1oeTU1
 FeO43wbFs8ykePaDYLLb47GAwhX9glP3hHjSTBvw0VmjMgyynVi0gTJZTWCb9fLozn2+
 gXNJlGYvdUPka+ynjnWW2ZBEa/PPCF6i1K7Oy4JQNF8+w3F0fUHEVFtCa7s9b7j4c0qe
 yYUB7U+b/oprqumj2pGNVdAle8Cn+n48Jk49xDmyEDao+adcSe1LmrgPLep2a6pUXKp+
 MZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698907608; x=1699512408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=WFIk/sNv8IYoUJJcMFEAtsLxvdk2HUDfh0iW/p0+RvRIHqbdu5klCXCeZwVUld/c8Y
 C9R1TT7GrH7p3F4Ut8tWgGsKBSX/TPOv7zJVdXCNYlG/4sLSVuYadkzzFFZ+CCySXvKX
 hh6T45IsLsQmIHrCXAtSSONO/KDVutKTMKwyXKcvPw9IoIzh/ne2u1qi3fkr1L2Lf/NN
 C+bmF1NiSSwRgS9k2Zc1ogTdjZsTiyI6xj6u1QMBOQ2qg2tD+5QvGhvwVjXT9PnOGi1C
 gHwSv+dGoC2JC6Tosw+zvoYetaTgaag9+WsZjqur5UBL77c9gm0ne6AQH99kbco4/SOC
 Cf4g==
X-Gm-Message-State: AOJu0YyBaWN88ZFDF8veahBXBKS89Pj9nr4jwFlOUn4Oui2r+CjPoUjV
 QxKrwI4fUPBvxyRtMsZG2EEucZztoo30/QZhGfI=
X-Google-Smtp-Source: AGHT+IGUpppE61t0sP1AnHUFcupiXnbxLNdttCgHZypMnaaw2YPak+DtY0H4O5KNzCMud1IqlH7xxg==
X-Received: by 2002:a05:6a20:431c:b0:181:9b65:b4b5 with SMTP id
 h28-20020a056a20431c00b001819b65b4b5mr965182pzk.3.1698907608448; 
 Wed, 01 Nov 2023 23:46:48 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001bfd92ec592sm2328697plc.292.2023.11.01.23.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 23:46:47 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v9 9/9] doc: uefi: add HTTP Boot support
Date: Thu,  2 Nov 2023 15:44:59 +0900
Message-Id: <20231102064459.3466953-10-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
References: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
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

