Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B18DCA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB6786E20;
	Tue, 12 Sep 2023 08:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wpZwVvsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5234F86E71; Tue, 12 Sep 2023 08:21:46 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AD186E4D
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-273e3d8b57aso751070a91.0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694499701; x=1695104501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXHBt+K1km+W4GFANm6SDROKpTpvRqogPRSMXl325s0=;
 b=wpZwVvsqBjHybR/ruiA/+nSNfZVQLeDSsDbJh7nhz2SdPVwMJ26MqrhM6TqGuzuzFq
 g80yP7W4RdE13G08C7kf1K528NehR41fzCOItAyjv64cDXl5TrdfjxtGF0uv4us5E2qY
 CnM2pZ5DFKO0VpQzR60GH8qFhKe1Ou3xcvF27s4iR6Xm/F2DBwcY7NIeVPsMEdi7yyp5
 qyxUT6uoXO6ELImHqOe44+ulTvvxbi8sMy/URsQt4YbiPwK2eVZGoIc2417tbhm6rWWv
 Pm4753p+skh1ay+3eRBROEesU/n8F5qOSWmK1UnZfGKgPzyBVJnBWu4akqRBIhbURDDO
 nVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694499701; x=1695104501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXHBt+K1km+W4GFANm6SDROKpTpvRqogPRSMXl325s0=;
 b=aSG6nFGiBrBafTTSLZeFnR/s+xw+KPLWDASlSCRa/aaT99A2PWhUAnQtfOyIrN88E9
 ezYk5fNoQymL0jQhPUNTPjZ8KCUhj4HteQd5MPHja6QyNj+rLtksYUjEAfI3gyXAfxmL
 6z4478ZQRYwzep6n+ZBqkIpfupkqRFRcNEwKw7r3wi4YI5+LnVCWUWPfvZlEnMYwAU1y
 0LcO9jbwVOaR7oT0Lchrfzl8H8hdAN/Q2b3OdxQO6BXO6zPdYqN6la3+4rd2MqDeNGQg
 cb0ZrLsopJZ5r0vMYQStL4AvihvI9CaGs0ge/ZmKt5zyJnKamoExZYjj2D0y2NW94NJx
 adew==
X-Gm-Message-State: AOJu0YyOt7i0YsNTUtQlo1219CT5YzHOMmCtTeLN7mRQgJyWCTIDzN6D
 ZodNBL08nutYECLa6E0hb0FRfg==
X-Google-Smtp-Source: AGHT+IEa7oeSw1CZpzgc0/C+688IpgKv0pLwYHnCURQ9Zjff4oKswPBL/rwz0Q7i45+9UDNPE4SnJw==
X-Received: by 2002:a17:90a:7025:b0:263:730b:f568 with SMTP id
 f34-20020a17090a702500b00263730bf568mr11145223pjk.3.1694499701204; 
 Mon, 11 Sep 2023 23:21:41 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bf3d:658b:e9f7:3af5])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001bc2831e1a8sm7503970plh.80.2023.09.11.23.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:21:40 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v4 12/13] doc: cmd: add documentation for scmi
Date: Tue, 12 Sep 2023 15:20:01 +0900
Message-Id: <20230912062002.57361-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912062002.57361-1-takahiro.akashi@linaro.org>
References: <20230912062002.57361-1-takahiro.akashi@linaro.org>
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

This is a help text for scmi command.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v4
* s/tranport/transport/
v2
* add more descriptions about SCMI
---
 doc/usage/cmd/scmi.rst | 126 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 doc/usage/cmd/scmi.rst

diff --git a/doc/usage/cmd/scmi.rst b/doc/usage/cmd/scmi.rst
new file mode 100644
index 000000000000..9ea7e0e41dad
--- /dev/null
+++ b/doc/usage/cmd/scmi.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+scmi command
+============
+
+Synopsis
+--------
+
+::
+
+    scmi info
+    scmi perm_dev <agent id> <device id> <flags>
+    scmi perm_proto <agent id> <device id> <protocol id> <flags>
+    scmi reset <agent id> <flags>
+
+Description
+-----------
+
+Arm System Control and Management Interface (SCMI hereafter) is a set of
+standardised interfaces to manage system resources, like clocks, power
+domains, pin controls, reset and so on, in a system-wide manner.
+
+An entity which provides those services is called a SCMI firmware (or
+SCMI server if you like) may be placed/implemented by EL3 software or
+by a dedicated system control processor (SCP) or else.
+
+A user of SCMI interfaces, including U-Boot, is called a SCMI agent and
+may issues commands, which are defined in each protocol for specific system
+resources, to SCMI server via a communication channel, called a transport.
+Those interfaces are independent from the server's implementation thanks to
+a transport layer.
+
+For more details, see the `SCMI specification`_.
+
+While most of system resources managed under SCMI protocols are implemented
+and handled as standard U-Boot devices, for example clk_scmi, scmi command
+provides additional management functionality against SCMI server.
+
+scmi info
+~~~~~~~~~
+    Show base information about SCMI server and supported protocols
+
+scmi perm_dev
+~~~~~~~~~~~~~
+    Allow or deny access permission to the device
+
+scmi perm_proto
+~~~~~~~~~~~~~~~
+    Allow or deny access to the protocol on the device
+
+scmi reset
+~~~~~~~~~~
+    Reset the already-configured permissions against the device
+
+Parameters are used as follows:
+
+<agent id>
+    SCMI Agent ID, hex value
+
+<device id>
+    SCMI Device ID, hex value
+
+    Please note that what a device means is not defined
+    in the specification.
+
+<protocol id>
+    SCMI Protocol ID, hex value
+
+    It must not be 0x10 (base protocol)
+
+<flags>
+    Flags to control the action, hex value
+
+    0 to deny, 1 to allow. The other values are reserved and allowed
+    values may depend on the implemented version of SCMI server in
+    the future. See SCMI specification for more details.
+
+Example
+-------
+
+Obtain basic information about SCMI server:
+
+::
+
+    => scmi info
+    SCMI device: scmi
+      protocol version: 0x20000
+      # of agents: 3
+          0: platform
+        > 1: OSPM
+          2: PSCI
+      # of protocols: 4
+          Power domain management
+          Performance domain management
+          Clock management
+          Sensor management
+      vendor: Linaro
+      sub vendor: PMWG
+      impl version: 0x20b0000
+
+Ask for access permission to device#0:
+
+::
+
+    => scmi perm_dev 1 0 1
+
+Reset configurations with all access permission settings retained:
+
+::
+
+    => scmi reset 1 0
+
+Configuration
+-------------
+
+The scmi command is only available if CONFIG_CMD_SCMI=y.
+Default n because this command is mainly for debug purpose.
+
+Return value
+------------
+
+The return value ($?) is set to 0 if the operation succeeded,
+1 if the operation failed or -1 if the operation failed due to
+a syntax error.
+
+.. _`SCMI specification`: https://developer.arm.com/documentation/den0056/e/?lang=en
-- 
2.34.1

