Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3401C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 04:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5671B877A5;
	Fri, 10 Nov 2023 05:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G/zHShEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B8E887783; Fri, 10 Nov 2023 05:28:07 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED1048779C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 05:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5b9a7357553so1340454a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 20:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699590461; x=1700195261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=G/zHShEFZgkGEY5i5m4OoSTt51cfmTFnHerz5VRmAJdrJrtdUSxGZ5cz+VfvIKzqrx
 v+4Y6VGGmQlifBQ7/rnciuI9aC+rqpWXk79v57fP0EDm0BHPaiekdoQ3z75bV4MtNltO
 0aH3/g5lyWHFfekzqmuh0qgXUdl93ZIOY/PwwRkkZNGOUcOK3cfCwDDgvFODlQh9cBru
 5rkoWb4TIPrWGVFBBNXm1rVhfuuJZh3ICbY8BAbZG6eRKXevCGMIuQTuKitFDldvV4nx
 bQqxkifTrqOqcvf+Hx+jzSmZPhJfNB3uuuqZQ8VCxSO2r9XMiaKZQEaz/UUT/RCKI8JP
 xk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699590461; x=1700195261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=m7765guAgVBqw5PfsqlOIbx/O0aOb/J8deQc6ol/jTyzvWRrCFZb7eu2fm/RacrrYV
 yZ7vrE3YE2BSOrZ5jABWhjK6rCnMNBzZwjGKKOFQCcSyXOa1JrHJwFADC5mFiUOpR36y
 6o+/fa6n5p1xhPiIRHVbLGkB/+hPeO5eHEk4nQRfIwQGHyg5NpZtIpUkmOj1BDR83+UK
 p1ArzwR2y/0LP0Y5Pc6HnEn/zjXXoynSo6zMaPv9UN38RlzG1BCkblM3KzqPsQg4Fecd
 AuRgVJynTPDVeG7eyWjgbtMCR68AFImgS8qr/rCOvygK/0+j57hKVq6V9FczhbLRVj3z
 Ia+g==
X-Gm-Message-State: AOJu0YyQ3k43BsVUWnwmTriOiZdasrUlVwURSl8kNBMejizMdFPTRPPE
 9Z3/rMm3Im7K36o1oa8Y/V92E8y9LTDpmNRneys=
X-Google-Smtp-Source: AGHT+IGVRMlOvtQdbMYZAWast4EbSAJwWqIkPxRHob639D77jWhE0+ZA6DHhs6/xBme1FLIvWabUiQ==
X-Received: by 2002:a17:90b:38cb:b0:280:e85a:9dde with SMTP id
 nn11-20020a17090b38cb00b00280e85a9ddemr4145136pjb.33.1699590461222; 
 Thu, 09 Nov 2023 20:27:41 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 v18-20020a17090ac91200b00273744e6eccsm605226pjt.12.2023.11.09.20.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 20:27:40 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v12 9/9] doc: uefi: add HTTP Boot support
Date: Fri, 10 Nov 2023 13:25:42 +0900
Message-Id: <20231110042542.3797301-10-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
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

