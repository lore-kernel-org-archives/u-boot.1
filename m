Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5F5D68B26
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E536289102;
	Thu, 14 Nov 2024 15:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TIwFpBHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA4D288C66; Thu, 14 Nov 2024 15:20:32 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87FD489198
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3821e0b2262so296194f8f.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731594030; x=1732198830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9wrAN9aP12uvude0Cj4Ioz5uzvGeQswDUabI0tc/ibg=;
 b=TIwFpBHVoaBg+0HFjWUhLodNMs5J7jy2VniN+TsnEkZ/BuBElHTFEoF7TIKI+zAdrY
 d6rmpH4mLzIqoGYWwAo0TJyUS4RRSEI9sF6PPXi7C3ute8DYmE5IXFp7B3ZysGnXLiWZ
 yaGyYOAgHKMSMGCRKKSe9xvklH28nQaaP8LT8FoKX1AcCvyr2KlR/s09wk+KpU3cd+hR
 JxGPHemjI9eiauTAJXZEdd1TX3physmIjOo/OoNcL5wCb68hhpN6hXNsIBSq9WvQiOrk
 XGYvTJ71ByuzEzN1iPST4bSqO588cGD2ZiDTOY1IdOv8qVQKzgBhYF0nKve2oefV2i16
 iHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594030; x=1732198830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9wrAN9aP12uvude0Cj4Ioz5uzvGeQswDUabI0tc/ibg=;
 b=ScC8Do+9wBOBNvmf02OLPItIhzlesarfoaABGnrj2nDqNiiorWs8c2vqdBPaevMQsk
 BAeKWRDSVhqlHGGDUKDkDV1CSz5vug1AjkX1FG/nlJCjVW4Kj95yfsmsW14m1v2bNILw
 TDqhuj8UtSEqVQ7cwjhaboBv1MRnKA6MXnE5W9TNWgqvErnLZaLeMVPcPGNUxBDXE7kQ
 +QdYEBUYb9K5+Zyf14OBqg7tcvIYXnOBwhhUXRpdcNBRF89BooxB/+d5Bc5rx5zBgkY+
 92QKFrsepjx3EUhFxem6lPXjsIZvr2b9HwqvwCDVbo3wEQ4OXGX1tBQ0BZRXJJCfuFny
 MKEA==
X-Gm-Message-State: AOJu0Yy37Ju79HpTxFOsF6Hv1xPQ3pLDOLsc8H/67wp37MyQsHaVQCrK
 fNxMe4Bfp0cIAyh9zmNrMH8KL0FDAAqV9qDtFX4r6h70By/grruabETfUfWA55NLFuZ2Zfy07Ye
 j3l0=
X-Google-Smtp-Source: AGHT+IHJByY+kEwOUJ9HcG+T3ptFpVGBOwDQPrafs/HQyVfr4xZertrhTVickQOkokfe1EFi7GJfeA==
X-Received: by 2002:a05:6000:270a:b0:382:1c00:d46e with SMTP id
 ffacd0b85a97d-3821c00d795mr988941f8f.37.1731594029582; 
 Thu, 14 Nov 2024 06:20:29 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3895:27b4:20b7:7653])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae2f602sm1581384f8f.90.2024.11.14.06.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:20:29 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH] doc: cmd: wget: document lwIP syntax
Date: Thu, 14 Nov 2024 15:20:04 +0100
Message-Id: <20241114142004.2051240-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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
- hostIPaddr can be an IP address or a DNS name
- path is mandatory

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 doc/usage/cmd/wget.rst | 71 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index b8ca35bb140..5be01a22e47 100644
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
+    IP address or DNS name of the HTTP server, defaults to the value of
+    environment variable *serverip*.
 
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

