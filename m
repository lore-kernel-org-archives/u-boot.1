Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE95D5E39B
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 08:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44AD688A37;
	Sun, 10 Nov 2024 09:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WH70mPS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FFE388E1C; Sun, 10 Nov 2024 09:32:38 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5970B87E30
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 09:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso611857866b.1
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 00:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731227556; x=1731832356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTO0Kxk0iggDXXIa3ZiQy7xO/LXQRz1tP65CoYNYwig=;
 b=WH70mPS5Q6HNMdplE7heda/vpJ5wGz0oJ57/vJtS53224hbYw+udskzycc6ngxdL2O
 dQiOgRZ7V9Mxl7ZuZP/JuwZyM7iMVuWC26KW+LDdkzIiSqWLgwhwsvX3f5MSRc83z+Hh
 hV5IqgIjdKRa/xrroooalRRi8iSRKxM4FV+T9l/XZXw/har2wzsRTTXvI9FryRLeAlPo
 DI1kd6SROyXNkq4vYRXAshMj4sRWObyYf8/NrhQIbxNplWM+glYiqEVYwZC63/KFQUx8
 M0SjIdBbZJL98aCZek4d6ueWtOEu+Z/YVao/a7hZ31MB+wDSPiOwA/bSZMXzVZ79SleC
 pHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731227556; x=1731832356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTO0Kxk0iggDXXIa3ZiQy7xO/LXQRz1tP65CoYNYwig=;
 b=BV+WKExB4+sNf5taVSNu/gNBxIlrhmRMZRIcqltP2f605q86l0KCIzwcHn0fBMTLAI
 05O7RA6qWLsVXGWg7uIC7fDBSHc6PFiVbppvNI0QYyiAWxM7PbaJ7dyZRQVcFVZ8EJzQ
 yjmzGPQsNHuyYOjF7SoOuFeYL1mbOEN8Lr/XA3jU6prEoNaprs7yLgwAWFowevJdjsH9
 bSiL5FF6ajucpcaMFmtHdNR0Ntlbqg4ObOGOj4mw9bBbyuWPG6AxOe0B6tTywIWZcMJ/
 bcP6s8KOs2mm+G4Y1IEcjsaOnuPl6d2WAC3W7lNsnjxCIL91dLzFhIdJeH7J8XSOiBBQ
 IEow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIZmPeKekRtdaU1FH9dwthPqk+dVQcF5SsZHDWV2ZyBp6si990579qCakWE/GFcvrEdZ6rrWI=@lists.denx.de
X-Gm-Message-State: AOJu0YxwrwglvgeU5hmaffz0ivKptfrW/hZonUhw7/cYYyDh2L2X/x5P
 larmK1gK4If087jG4NoeY3bfkRyl/7vlgAcOkVLPJKWD2Vanh7Lwf95NC3GC/uc=
X-Google-Smtp-Source: AGHT+IEZyqAqPCiAxIlSZvBHZkpoTtGL3sCu/xIV/Ni//AJKu5RpjlzWlg4qtreXWf2DvZ+m6Wsk2g==
X-Received: by 2002:a17:906:7315:b0:a99:368d:dad3 with SMTP id
 a640c23a62f3a-a9eeff4477amr880369666b.30.1731227555621; 
 Sun, 10 Nov 2024 00:32:35 -0800 (PST)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17b3csm451909166b.19.2024.11.10.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 00:32:33 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org
Cc: Anton.Antonov@arm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3 6/6] doc: uefi: Describe UEFI HTTPs boot
Date: Sun, 10 Nov 2024 10:28:42 +0200
Message-ID: <20241110083017.367565-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
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
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 45 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0760ca91d4fc..48d6110b2ad1 100644
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
+with Mbed TLS we can also download from https://
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
2.43.0

