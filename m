Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B15CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 23:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F42865B9;
	Mon, 16 Oct 2023 01:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LVtIXWoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E40386BD3; Mon, 16 Oct 2023 01:51:38 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83ED886C26
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 01:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27d2b814912so1787024a91.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697413864; x=1698018664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krCW1EDHArtGI48lreyiAHizzZlT4boUPNv3WI7tL2A=;
 b=LVtIXWoP5j2AHS2Y4Pz5uCYQU8kZ/ZXSAw/FPv4R+qynGS11DEF3/YDqQfeXZ4cubv
 Gpe4gUDGp05kZQZO/++wDtTRfJhsQ8X5O2OO1oqQ4Ce/NUPEDZE1Xa9z61oBqNqGZS03
 T/SaYsjeWeH6RCDrua+KFXmU0V5GjmTka64tFf+A5hdUbD+Nf2Dqee0YvFqevjpjVQaY
 ZtGEHDk4SMZE6ro2/bkOJL/8QaeSqF/qojqM3pZWhoOeKYsNoDiWE1TJ5Ddmqjb+tb5Y
 4RuDL8RMS1i6YCD4Ei52fqbQoHDRfH82ajYhRi3xUBBi+OcySkc2fq2E/28IjftNiAu1
 2iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697413864; x=1698018664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krCW1EDHArtGI48lreyiAHizzZlT4boUPNv3WI7tL2A=;
 b=l/pT5bvnHCDHPv/uOsvrKypIqUMckEmKuiduocVdDyUkBkeyX0uGkAeQmLnjnN4vUZ
 tZTvkgq9h2pc2xUrCKm1zKIfoSq/+BczF+y/yKKMNRb6U4L6GsywIdnypiblVNxZfQy+
 h7SM2wJdBh46jMkc5sK7/06iEgMfdR4uk5KbyG01/LqxOdBNSp3L4h49s4KfPyTEsxVO
 EilYP4eJ75XMCZm62H34YRFlEEzX4w3VotScQ9XvJCfctTanGZXm26ljpvbikIdhyIL1
 jADoJ3N8vVJ1BW9xg/ylForbb0B+O8CIeLA6FfqeiEIeb2zyC09bez2iS4fVHnob384b
 1GPw==
X-Gm-Message-State: AOJu0YzNCzYIY9cYEfz/NmURk0d0Z0PBWg8i6UDJ7gMqwhiCDiJODVzs
 aPfz/ONhlv9hCzo4zS/iVZh+82rMNwGdTx9sCC4=
X-Google-Smtp-Source: AGHT+IHBBNCRwPVgKQSlORblVNXLNYaPLuEieFGg5J87EEwqRTAwmeNtDulVzHm4KJwVu+nZ9fo+mQ==
X-Received: by 2002:a17:90b:3642:b0:27d:dc9:c67d with SMTP id
 nh2-20020a17090b364200b0027d0dc9c67dmr10018813pjb.36.1697413863891; 
 Sun, 15 Oct 2023 16:51:03 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 bw4-20020a17090af60400b00277371fd346sm3431720pjb.30.2023.10.15.16.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 16:51:03 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v6 9/9] doc: uefi: add HTTP Boot support
Date: Mon, 16 Oct 2023 08:49:07 +0900
Message-Id: <20231015234907.2362717-10-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
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
index f8510d31d7..d7332c300d 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -625,6 +625,36 @@ UEFI variables. Booting according to these variables is possible via::
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

