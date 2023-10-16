Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC21CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4FF86EED;
	Mon, 16 Oct 2023 08:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nmfrcKWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B7686BD7; Mon, 16 Oct 2023 08:47:29 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B375B86537
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 08:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c8a1541232so36127105ad.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697438838; x=1698043638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krCW1EDHArtGI48lreyiAHizzZlT4boUPNv3WI7tL2A=;
 b=nmfrcKWVb1ndswrdu0sPviqOx5KNQa7Vr4eH4DNnOWLschqoKYAPDDiCHONITzQLJ2
 +D3/bIOCGN+D1OdzBcfvvS4h3XxN7wrCGl33gaqJ38hOelVyzdgyT/n0Mp3wXIhRpDIl
 0FGtZATYBtlShKkK8D6spbXwsXtBFMRTiH3UsvPxeSCYLucbXJA1+ghawwCwiJKcjQ40
 FB12iJI3DovRGmN91sk+4ZNkmxzyzRmp//sHxT+zEaRNgCkrmhDLZ3bKqSkc1vDvxQD2
 257hgL1jDZ2tJSE0TLielvnL8aDu21qDsd+++y7tWvnHH4De/JiVe1YHgdCipv4SQ6Fm
 ECCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438838; x=1698043638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krCW1EDHArtGI48lreyiAHizzZlT4boUPNv3WI7tL2A=;
 b=OwMVhjKj/SRDHeNYuK79cClbD1VH+RmmX6x1tzvqfAyp1jWla2etaMULCKiOQr4+Gy
 xvQtkbu5kTneD5Qq4qnb1wkI9RLRQnTMsPpnEyme24AGruvNLkTenNNjfD4suKhlNdn2
 usVpxBeIsrGtxjKvF6IxaNUezUe3dtfjAjKBv96tSmGaAdL55etS/gZLD6Dno+G1oR3q
 5sPkWH1N/QamvaQ9VD31u1Pjdomfzl0I7PIyDnNb/dzF2/6XRcGrttROhrbJUB5Ewt1G
 25YijPDKBgddCRF/iuBhBtUSUH1KfuRGdH5NbE3BCB46JC6C3KatuJ3JRnFuAGyoBJ6J
 C+Vg==
X-Gm-Message-State: AOJu0YyuzgpUxdKyc3AFDqEmdh40yc0xiojKf5KUggdkn5YblkADMk7L
 mi+955JAIEaKXmycjtRMy6NNObBptLv3tozw0mM=
X-Google-Smtp-Source: AGHT+IFIEx7tyKFfWut+YCJofIzZMUU71JWKWr2fERLC5020ChUwcwqLKD/Ou0j7U0YmuZLA+/plBA==
X-Received: by 2002:a17:903:187:b0:1bc:2d43:c747 with SMTP id
 z7-20020a170903018700b001bc2d43c747mr43936985plg.38.1697438837821; 
 Sun, 15 Oct 2023 23:47:17 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001b06c106844sm7706342plc.151.2023.10.15.23.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:47:17 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v7 9/9] doc: uefi: add HTTP Boot support
Date: Mon, 16 Oct 2023 15:45:26 +0900
Message-Id: <20231016064526.2410856-10-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
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

