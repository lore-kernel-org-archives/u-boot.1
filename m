Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6245D30013
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 724F588717;
	Fri, 18 Oct 2024 16:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XdVhYigr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A932C88717; Fri, 18 Oct 2024 16:23:27 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77E480AE6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so22492955e9.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729261401; x=1729866201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hERox0U5aHKC+DnPbgH6twbphvL01gqEqfrBF6WwKsU=;
 b=XdVhYigrG5hysv05RnFFXVIAfvPzjkKtmgq6BFdgcmYEHoRjCjTwMPJqp+dZl9633I
 pyJEUdH+5OSLeNHXuGNZ1aIznjeWOLT0LDz59tG3GUsy3ln+1aE/gmqvMoTsKJ2+T8ZC
 v41vCP1G+6NI2UCeiQxGsh6BMQdypg/+Ym9QVoG6p7u22ubwH7uUq8ExohM3YtlBxzqO
 D0687399Js8hvakzEOhswTenays51LV2rBBI33wtP8tquEbZx4e3EgUggE4Jr/WHe73t
 5xiiTAMUzkJF4EjagaW8LCPbvBi+rox/dHE8UGCdWy6QwxY0AS6BTQ1KEgLm5ZpXBQuY
 evxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729261401; x=1729866201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hERox0U5aHKC+DnPbgH6twbphvL01gqEqfrBF6WwKsU=;
 b=UfJ9T7Bxybb5scip7ZNy8YzD8Ara3A8vu4sm+mu9h/6kr6Y7HSK1kaqFNjhoS5Pd43
 AaMSZA34n/ZgDRLss+t5wUJLB89g1zE6NHF5hKO5q2Y+DLFLh3xzb770L90Pn8nwXgDj
 nON3weMOwpTj1AclaKdsZLYmRK6L/kpMzamsy5WmeXlm1YMOM1QCNETkME+GZEfns1sX
 EISprCc7wL9gzURMW5Rm3kuB2SXoJCSTZBJoKqlzbU4nBk1ym7M9b64UEObjNOXdgFYA
 FnZCnI/W+OaOyR2iu7dFJo2s9fdnFgDQIE4m2o9BxqmAEW6/ZWmX9Eu/J6jKAO+v+6n9
 9oRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhAa6KiRsxUOdL4T8eZV7UTOb7xNfE2CU7kPQ+LddVOTaaD5wnWBUgFmshbGiMoaJdDby7sK8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6LxzeO4G4GYEzRN9jcsHZgDqqg8Vz12reTJyWEE/A+0T78+KY
 QkuFIUU0ZI+a5QimjuomJ62wBvmZx9AExrs5R3fI1qqkMNf6JnRojVgwlD5DQq0=
X-Google-Smtp-Source: AGHT+IEpcZGMmxg/6t/2NjUgz7RilmgGrmRAhxlnBJWuT74+WFt1NTPLv0EybcNZTf/YtIZnWsZFTQ==
X-Received: by 2002:a05:600c:3553:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-431616a0b1emr21460105e9.30.1729261401215; 
 Fri, 18 Oct 2024 07:23:21 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc70sm28781665e9.10.2024.10.18.07.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:23:20 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 6/6] doc: uefi: Describe UEFI HTTPs boot
Date: Fri, 18 Oct 2024 17:22:00 +0300
Message-ID: <20241018142235.715571-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
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

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 45 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0760ca91d4fc..198288a6889f 100644
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
+    CONFIG_MBEDTLS_LIB_TLS
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

