Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56056E7D0D2
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB2786A1D;
	Fri, 22 Sep 2023 09:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gzPIKPHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8537A86ADC; Fri, 22 Sep 2023 09:12:33 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB7286ACF
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-573e67cc6eeso1391922a12.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695366748; x=1695971548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sP7LVMmuM4MkWBCRUtJbDwtwgSyY4fsCDLvm6USUOR0=;
 b=gzPIKPHox/0Ap2GqWKcdQHPxe+W59gg1XB9RFtjY3Co7DKZfKmU9gKpJHt2z8MWUng
 mJhlhWUaacEeIh+sJEkDWO8xk54KkMP0LxW895spGNz+xLhOdWuRmNJyApqDlSqKNBjY
 k1uM+K3WPnHyREKO5Ht537dwWzj0PcDt6xVG3gYUzukIPdOVYvKNu8pgBVlrfi3GbS2b
 t0bRgQz4f7ypUzWqoOfej4VpOLYqSxkQDd/vy2eKuL6wn9x1BA3FU1zAJz1xJIlIfeXq
 0vUFQ0q78FdF53ekt4FFzJHxF9T/8xn0In1+f0MmUvC5gDsCro7JbGw8Gsq9gUPCVxr6
 f2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366748; x=1695971548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sP7LVMmuM4MkWBCRUtJbDwtwgSyY4fsCDLvm6USUOR0=;
 b=crfGE7Lxy1S6sK7sN/ossifTviYI9Q1vN+D4SX4Lq5KrXpba18+HIkCBMjTpq/TROR
 o+VPFfTQ7/1amdjIDqcpOTQNKZdFBybn9EtokgAfhEXeU6NhUjiahgGGVCRSUz3otkYL
 9DXFDsJPV3a2iLAqPoMse7uLKuhNhHkLyube693e7WVPZHv3kClnDkbFA7ExEfzCTV3U
 x5MApKTELuycFHLA+H6LjYRAirWBf8vA1BUnmKcVku8w2qmC6foQYu4o1A9DJsWt+HnG
 /Q/yOL9dpxZ6zyTdiG07SPAIbD5Hijn5a3YbR12aUw18U970x237fbQn2jawtjYOx6lA
 dc9w==
X-Gm-Message-State: AOJu0Yybs1jHNXP/Ax5nbQ/9wZyqF5wfsZTGCQuEhno75GWy3S4tpr2K
 +s+TjxBfTegecm72yiLQSOAL2+kXYrTiEZlvg2U=
X-Google-Smtp-Source: AGHT+IHL+Zo5aSlS7++fadF4sIGCQRnkjPpjGpYMosXD2zpqkdsxTROHAsYQaLBNhhL2j2xpcRSXzA==
X-Received: by 2002:a05:6a21:4994:b0:13a:43e8:3fa6 with SMTP id
 ax20-20020a056a21499400b0013a43e83fa6mr6994848pzc.23.1695366748226; 
 Fri, 22 Sep 2023 00:12:28 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 kb14-20020a170903338e00b001bb3beb2bc6sm2730384plb.65.2023.09.22.00.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:12:27 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v4 7/8] doc: uefi: add HTTP Boot support
Date: Fri, 22 Sep 2023 16:11:18 +0900
Message-Id: <20230922071119.1439482-8-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
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

