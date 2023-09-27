Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A15EE810AD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A2C85C98;
	Wed, 27 Sep 2023 11:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nm8iReCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137868074B; Wed, 27 Sep 2023 11:37:59 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8A886DC5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-69101022969so9578216b3a.3
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695807475; x=1696412275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ft0XemQ2LZg3nTnvojmSzmjsDNWPuZyrC59jAwUrwXw=;
 b=nm8iReCxImEY9A/By87XGZlkkB1gtOwRqP338rFghuZtkwj4VTWCGV5R4HejPHZbEC
 kY7uXsGwCdfCwjLU9rUisOlt8B5YJmK3Ry0ACFxWQMX4VkM1sMOittpjliR4TuZQBtd+
 SV3ECq/jo1IxWBalAzBSD6DwrM5CwjbHydLi4x302IMwBhopJLmUx59R9RpfuWZJHaIg
 5iZdysFUvaNZoAuV3HjwW2odSSVcEtaxSmFYABgg398pdRsCvCAkhTzBcNRB1CJ5u6xa
 K7+8e1ljUsfy/SuqkJ8HW8P3Af7sDqhhCvsdo3nUQh1k4hLjXc7fY67n4NRCBa+Gl+Mn
 CrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695807475; x=1696412275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ft0XemQ2LZg3nTnvojmSzmjsDNWPuZyrC59jAwUrwXw=;
 b=aCuJ01GOzM9SkVfzv/s0s39gA16UgYmZk1I5wLDWb1pTGJ8Q/Zxd8qp0uLOMrjvpyi
 5TL5vjIGk150DzNUZ2eiQNpAkLIPB/2Ihw07r82IQKaJ0Em4J8FZKnv2I7utFIj7SvAW
 Ht8Qr4gj9LuFir9a7N7al9EsVZ0mJhcNn/SL0+lHNGG4FFhr4G6Nm0jSFLRpF/vqx6JI
 V0eGeGGXVD6w6yQSTL5yQ2u2Xw+IDd2vGLjT58qz1PPO5PAX8Sf5a0ciJTgqPcZH/Amr
 KYyiCOGC2S6v6uG9sqKd0adZH2mwqXrx3G0YI0LeKkBEwEAOgo1stPVBpkzwG+ynPOR2
 OlRQ==
X-Gm-Message-State: AOJu0YzPylBnVrG1SAxuPPPi0pLsXEu/UCw0Iz+dp6lkWXs6TQ1Qed4B
 xbnqUNccdKVPgB5AMrgAuaJ8vmVgfced4D9o0Lc=
X-Google-Smtp-Source: AGHT+IGuFCn3plvVRoQDsbjsqnVv1hVmAqmBLm7bBpV2B8afiI4w5B3D+MA+xBHVlCWN8jTx+t8y6g==
X-Received: by 2002:a05:6a20:938b:b0:153:8754:8a7e with SMTP id
 x11-20020a056a20938b00b0015387548a7emr1694072pzh.3.1695807474919; 
 Wed, 27 Sep 2023 02:37:54 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001bd41b70b60sm12682051plb.45.2023.09.27.02.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 02:37:54 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v5 6/7] doc: uefi: add HTTP Boot support
Date: Wed, 27 Sep 2023 18:36:30 +0900
Message-Id: <20230927093631.1595494-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
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
index a7a41f2fac..23b3da0f95 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -594,6 +594,36 @@ UEFI variables. Booting according to these variables is possible via::
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

