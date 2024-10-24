Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D000CE8E62
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC4588EE0;
	Thu, 24 Oct 2024 13:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AJLA79RU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAC688EE0; Thu, 24 Oct 2024 13:26:01 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B34388FB9
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a0cee600aso91466566b.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729769154; x=1730373954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0uM6ntOYMs0q92YYMNWqhN3ZZP/ZZqsv1+VRN9gK0Y=;
 b=AJLA79RUxSJfXEqVGSniAN20yj7n+H7NSMi+NbayUuMTEhD8aNaiw1kK1FbAicKdr2
 8fDvL0FESFLfd4BBWT0vAvToXXevNhu7MHGyfu2DnUb3OkEhN+1GtYLvT5KVtad8WpO0
 pMZlLpYZD/2Aqx6uo337/LGLdWFTOyiD13gh/fYGhgXTwq1sHY65hsFth4yrR0liJ/EJ
 CU0NPqHYazlwWgcijf1CkmG9zHiT2pAvar+/74vFy3ymMTHQr+V1AlUy2IyxoPsuQ+am
 iru0+I98LOOTc/3IQ09GxZa5Go5u1yX2cJeMrnSINgkAbYh2seYGMg40qJde2YaS0xPL
 23yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729769154; x=1730373954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0uM6ntOYMs0q92YYMNWqhN3ZZP/ZZqsv1+VRN9gK0Y=;
 b=bRl1Alyv+YGcyrNWUU9jt67Qbij7ACycpHIRTtg1RqSFm2eD7wCkxkJ4YNEMsDRS1k
 8X9L0Kv+ZWglnQuDiupEEzycHX8MLyMicoamaRPqYuhL6u+iSdt3v24WJ0OaB6GAPKk6
 hQ4c1IspMDPTuZipKNnTi7TlJRWY0OLIvpgHQ4FaK8gZ76v+Rz5n2df45M7HP4eOsu9r
 08AuYI8l76kJqgm4S+XRJNy5e7eTys6UB4d2mAe5KxnebQZ4+PzmzTpiEfrxekiTJ1qU
 QckuykSIwdyZV44YDYaf4BOdPIpDeSqrL6yMewenM7KRrDSl8WwvgbBx4vUaehO1hw8T
 MJiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs/YbeGCXJFeXxULsGDbl4rU7SV8fPDYiC9KAR8altVLpR2JJ/eih175FntHlbLAmrWnix+Ws=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ6H9MBzg/YAxyMqDpGDkTFyVMQVGqqtzEJIqFkgDqngll7Kqn
 Hzt26eVixvkCH4NEbDy1tsyJmgh5Hzo6MWctMqQp6zuNEHye6xTfT2fTTMbmPn0=
X-Google-Smtp-Source: AGHT+IESChttTdrziVMFUJD5VRlCyoIZgp0FkIOXHB2f1IQaapzs/ZJks4TpPaiEqr5PVuF3Pg3S3w==
X-Received: by 2002:a17:907:98d:b0:a9a:e91:68c5 with SMTP id
 a640c23a62f3a-a9abf8ba5c5mr472918066b.33.1729769154523; 
 Thu, 24 Oct 2024 04:25:54 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91572c0dsm611534466b.177.2024.10.24.04.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 04:25:52 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 6/6] doc: uefi: Describe UEFI HTTPs boot
Date: Thu, 24 Oct 2024 14:24:13 +0300
Message-ID: <20241024112449.1362319-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
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

We now can use a combination og lwIP & mbedTLS and download from
https://. Describe the config options needed to enable it as well
as some limitations

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 45 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0760ca91d4fc..e19dcaac8056 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -681,8 +681,8 @@ UEFI variables. Booting according to these variables is possible via::
 As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
 command 'efidebug' can be used to set the variables.
 
-UEFI HTTP Boot
-~~~~~~~~~~~~~~
+UEFI HTTP Boot using the legacy TCP stack
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 HTTP Boot provides the capability for system deployment and configuration
 over the network. HTTP Boot can be activated by specifying::
@@ -715,6 +715,47 @@ We need to preset the "httpserverip" environment variable to proceed the wget::
 
     setenv httpserverip 192.168.1.1
 
+UEFI HTTP(s) Boot using lwIP
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Similar to the above U-Boot can do EFI HTTP boot using lwIP. If we combine this
+with mbedTLS we can also download from https://
+
+HTTP(s) Boot can be activated by specifying::
+
+    CONFIG_EFI_HTTP_BOOT
+    CONFIG_NET_LWIP
+    CONFIG_WGET_HTTPS
+
+For QEMU targets there's a Kconfig that supports this by default::
+
+    make qemu_arm64_lwip_defconfig
+
+The commands and functionality are similar to the legacy stack, with the notable
+exception of not having to define an "httpserverip" if you are trying to resolve
+an IP. However, lwIP code doesn't yet support redirects::
+
+    => efidebug boot add -u 1 netinst https://cdimage.debian.org/cdimage/weekly-builds/arm64/iso-cd/debian-testing-arm64-netinst.iso
+    => dhcp
+    DHCP client bound to address 10.0.2.15 (3 ms)
+    => efidebug boot order 1
+    => bootefi bootmgr
+
+    HTTP server error 302
+    Loading Boot0001 'netinst' failed
+    EFI boot manager: Cannot load any image
+
+If the url you specified isn't a redirect::
+
+    => efidebug boot add -u 1 netinst https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-9.4-aarch64-minimal.iso
+    => dhcp
+    => bootefi bootmgr
+    #######################################
+
+If the downloaded file extension is .iso or .img file, efibootmgr tries to
+mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
+If the downloaded file is PE-COFF image, load the downloaded file and
+start it.
+
 Executing the built in hello world application
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.45.2

