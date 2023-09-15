Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A894EE6454
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 10:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1798868C1;
	Fri, 15 Sep 2023 12:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vuov4tC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3F9868C1; Fri, 15 Sep 2023 12:18:13 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B852865AB
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c43b4b02c1so2119485ad.3
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694773089; x=1695377889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sP7LVMmuM4MkWBCRUtJbDwtwgSyY4fsCDLvm6USUOR0=;
 b=Vuov4tC72j42iSOfZ2r/0pJWRkVjzOpw3bqsljoAl6FFBkHrqsnxtpOGhZWZMZQb3+
 JBPp9iu1xS9C3vhn9CB7RjkISXLMgSBzJC3wZ0yVXLm7qQsjd+Izrzv4AeWIqVdPxLIJ
 J/NZbHz1Vef8LholdHcQQ0jnp152IIPQF7tREXNjUSDI1T/1j56TjuLllJT68uMff4kU
 c04OaZeKZLL/Llsfc8fSnqrF6iyTN8QxUVJ+WvgrSgialoQ4c3GunZmxi+G6OnyHcxxw
 +ij30cOo/agAKuFv3lCm3i48S+tx7tjY/tvJE+H8dYSrIut9P/PXhlAfWugacPf1m4LF
 okSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694773089; x=1695377889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sP7LVMmuM4MkWBCRUtJbDwtwgSyY4fsCDLvm6USUOR0=;
 b=E+e9A47dYPOKC8s4e4bcJs0BG86y0qMeVcmyRy0Th858bxqYIBZfredfPs5T23CBA7
 u7Pguzqpg1CttFnOIAlyiFHv9pwCGmwK+qP0fWPCjlIBf80LgzvqukssVw/QsHTetx+J
 /SOlzXCA/XETnBhLukg369GbKfK78Ct4uQBRzS+th6Sp9ULrg4ZLYw61WChkASpQMi2X
 r3FNW0DlrM4JtNgQlzvWjhkGMwmcAoEC/xoNEwCn7TbcmB7XUCpGxstl7G0bwYYW4O8i
 WxGAZozQXrZCsbG3gI42yaziqybU5slSgf0krXJewXbTwt3lnZWbRJaIeV18UzsHhXmC
 NH2w==
X-Gm-Message-State: AOJu0YzBejpL18YlK6GuJn4tAON/ts+9bs4fnXVJwXI78ZPEixchOxnj
 3fxUbASwnMMglMy1E/tlHY99m7928+lIWC8sMsU=
X-Google-Smtp-Source: AGHT+IEYj/TMM7Wqv2o/k7Q8rKL8XVtH/kk+AEJu9nOmV2sIPhZnsYxIbazR/NXU9I4Flp24QJ7RGw==
X-Received: by 2002:a17:902:7590:b0:1bc:844:5831 with SMTP id
 j16-20020a170902759000b001bc08445831mr1140542pll.57.1694773089594; 
 Fri, 15 Sep 2023 03:18:09 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 j17-20020a170902da9100b001b8af7f632asm3125550plx.176.2023.09.15.03.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 03:18:08 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 7/7] doc: uefi: add HTTP Boot support
Date: Fri, 15 Sep 2023 19:16:40 +0900
Message-Id: <20230915101640.1166332-8-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
References: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
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
---
 doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index a7a41f2fac..65eea89265 100644
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
+There is a limitation that current implementation tries to resolve
+the IP address as a host name. If the uri is like "http://192.168.1.1/foobar",
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

