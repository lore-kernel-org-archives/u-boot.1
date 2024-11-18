Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CB2D43FF5
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 09:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4982F89124;
	Mon, 18 Nov 2024 10:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ALRdrwML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA2088D9E; Mon, 18 Nov 2024 10:19:20 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180B489152
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 10:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so34392465e9.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 01:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731921557; x=1732526357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G/qIB9z4IcieP7ZX0fMdD0rFOU4vxkokNRNNSHFtL8=;
 b=ALRdrwMLO1CD1U5Q8euw/KAQGFiHVsF4g0GNAo3wS7qt8t934T54as+F7mrq3UIGOx
 IVltnB82F9b9sw1to0pC4keCfAMwOhifC5b9wKdmtOEA5OKq9WpG6Y2CLXT2daWugihP
 g0/NlDFdfQ2DgVvkjkXThMJkmVV6hhvDrrTX3dC/v/lXBh0LOWwh3koQSeZF0G3GVGhA
 82l+k1jio5hSO5I2RxONKZL9lIdPzsaYZ0CRkbTXHF3gLXHU2muw7XX0YTmvgBEJTtR5
 /isyv2hVv3x5i6g9pDTNjlegT0uc5lHGiZnahjwMQXKN69jAyfJzw1bENtdEOcM5s/Uo
 IH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731921557; x=1732526357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1G/qIB9z4IcieP7ZX0fMdD0rFOU4vxkokNRNNSHFtL8=;
 b=BLEJQX5HAC31BLN/cC4mEM88FAYtqM+rHegv4GzAoqouLkQtDLF9XjB70PruUDCZS4
 zDHWTenIo19CSr0Qeh3Wm/hZJggNJDtLBWq4KKKbwjpzvuqIgNUN/6dHj62DA0+C/gwo
 gozq8o6c+UuRrM2GG8CdB1P4cuj6ae1tygDDgdOiiq4QA71QNLGPJ2EWIHTx4l35tdoO
 BWuLVn2tKDqLUCNwoCYUSTDbePWco3tqFXzNIDC6aHMWpnTEyJ2TBzgtb0+dYR2QoNTO
 dTq0iUZwo/fZYTmVeludZyRCENqfeTzpEwfxp/X3UL5L2zu8kq5j9wmSNLPF68xpN1TT
 ZCZA==
X-Gm-Message-State: AOJu0YzzBOB+SPm5sghRQbW1Jj8PnMpnkUIupZQ8OWfiiNw2L1dXiZF7
 Ak2JnPqRgxniolriEm2I0xcOOgoFcMybPZr6uwQD8CQ+n2hocRt09Y4Sw4QY7wrElKQAlT0VVHU
 RPJg=
X-Google-Smtp-Source: AGHT+IHvs9frJVP6iUCnGzLw26v9bNBn9j4Et2fcRO31oTjKNQYCrXmDJtg3opU8Ay7+I3XH5s+fsQ==
X-Received: by 2002:a05:600c:c0d:b0:431:46fe:4cc1 with SMTP id
 5b1f17b1804b1-432df74139bmr109117495e9.10.1731921557393; 
 Mon, 18 Nov 2024 01:19:17 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:ea85:3dd5:8dc7:57d0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38249b67709sm1451687f8f.76.2024.11.18.01.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 01:19:17 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2] doc: cmd: wget: document lwIP syntax
Date: Mon, 18 Nov 2024 10:18:01 +0100
Message-Id: <20241118091801.2221512-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241114142004.2051240-1-jerome.forissier@linaro.org>
References: <20241114142004.2051240-1-jerome.forissier@linaro.org>
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

The lwIP version of wget supports a different syntax with a URL,
in addition to the legacy syntax. Document that.

While we're at it, fix a couple of minor issues in the legacy
syntax:
- hostIPaddr can be a DNS name if CONFIG_CMD_DNS is enabled
- path is mandatory

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/usage/cmd/wget.rst | 71 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 11 deletions(-)

Changes in v2:
- Using a host name is possible only when CONFIG_CMD_DNS is enabled

diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index b8ca35bb140..f9522ce58c6 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -11,29 +11,51 @@ Synopsis
 
 ::
 
-    wget address [[hostIPaddr:]path]
+    wget [address] [host:]path
+    wget [address] url          # lwIP only
+
 
 Description
 -----------
 
-The wget command is used to download a file from an HTTP server.
+The wget command is used to download a file from an HTTP(S) server.
+In order to use HTTPS you will need to compile wget with lwIP support.
+
+Legacy syntax
+~~~~~~~~~~~~~
+
+The legacy syntax is supported with the legacy network stack as well as
+lwIP. It allows only HTTP.
 
-wget command will use HTTP over TCP to download files from an HTTP server.
 By default the destination port is 80 and the source port is pseudo-random.
-The environment variable *httpdstp* can be used to set the destination port.
+The environment variable *httpdstp* can be used to set the destination port
+(legacy nework stack only).
 
 address
     memory address for the data downloaded
 
-hostIPaddr
-    IP address of the HTTP server, defaults to the value of environment
-    variable *serverip*
+host
+    IP address (or host name if `CONFIG_CMD_DNS` is enabled) of the HTTP
+    server, defaults to the value of environment variable *serverip*.
 
 path
     path of the file to be downloaded.
 
-Example
--------
+
+New syntax (lwIP only)
+~~~~~~~~~~~~~~~~~~~~~~
+
+In addition to the syntax described above, wget accepts URLs if the network
+stack is lwIP.
+
+address
+    memory address for the data downloaded
+
+url
+    HTTP or HTTPS URL, that is: http[s]://<host>[:<port>]/<path>.
+
+Example with the legacy network stack
+-------------------------------------
 
 In the example the following steps are executed:
 
@@ -52,13 +74,40 @@ In the example the following steps are executed:
     HTTP/1.0 302 Found
     Packets received 4, Transfer Successful
 
+Example with lwIP
+-----------------
+
+In the example the following steps are executed:
+
+* setup client network address
+* download a file from the HTTPS server
+
+::
+
+   => dhcp
+   DHCP client bound to address 10.0.2.15 (3 ms)
+   => wget https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-9.4-aarch64-minimal.iso
+   ##########################################################################
+   ##########################################################################
+   ##########################################################################
+   [...]
+   1694892032 bytes transferred in 492181 ms (3.3 MiB/s)
+   Bytes transferred = 1694892032 (65060000 hex)
+
 Configuration
 -------------
 
 The command is only available if CONFIG_CMD_WGET=y.
+To enable lwIP support set CONFIG_NET_LWIP=y.
 
-TCP Selective Acknowledgments can be enabled via CONFIG_PROT_TCP_SACK=y.
-This will improve the download speed.
+TCP Selective Acknowledgments in the legacy network stack can be enabled via
+CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
+Acknowledgments are enabled by default with lwIP.
+
+**Note**: U-Boot currently has no way to verify certificates for HTTPS.
+A place to store the root CA certificates is needed, and then MBed TLS would
+need to walk the entire chain. Therefore, man-in-the middle attacks are
+possible and HTTPS should not be relied upon for payload authentication.
 
 Return value
 ------------
-- 
2.40.1

