Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB95FC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 05:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414C1879F6;
	Wed, 25 Oct 2023 07:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TZvO1yES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA11E87A38; Wed, 25 Oct 2023 07:15:07 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC6B879F6
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27fe16e8e02so30505a91.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698210903; x=1698815703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+djceTQJzCP0hxdrJH/X9e8wVGWuFJVMsZPdaTaUu8=;
 b=TZvO1yESiW7W2eLtj56jH219yHsvsbogThHEqzmJOz2Z0nYb0v0yBz/et/Eo2favpn
 /58ygT4GBM8shSd/SHu6WyChBEbzwoGhdoh5SgnsA71R0RNAW+HpVUmzG2sjVh0DxkiR
 kx/ydfkVJniztwYvYL6fHYr06bFKIw3VOIIopBCcluTqLbuSfRKOT3u0cpS6O4kl2gdN
 SDpfIKN83SfhP22G8ek+KPZTqenWPMuJHr/mh63gYz4ioVKjuvsTP/qmOIQ5Hxje+jop
 nEeFhTmWZm+K88JGl8ugLqdWSsQc4CMXFHFklwtLnt6vcRB3rjiK0zw9xHHNoBvJZC/2
 cUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698210903; x=1698815703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+djceTQJzCP0hxdrJH/X9e8wVGWuFJVMsZPdaTaUu8=;
 b=o1wIYh+sAgwGCPopUw610M0urWZ3SBSbj+MhlST8pXPe+9T9bht1pP75yJz/8XMCYm
 eBmwQT+ELNrBZJvW8JpEcvxYkfqIMg802dCKhFcRxSmwFZVnkkfEK2NaiKL4OxcjgKxX
 CjOxcBoen1McUnQPpmi34kChRDCiSJEZ9MfXg75l5MxEs2Q1cxYTk+kJZ4GVQ9WaJqWS
 0+gcA8kxWqZKe3qvWRQcJxSSnvGkFiPcvBf7y8P6dj2LCNHt6CbCMnpPlXvFhryRoAbu
 fVMJyrzNWVsN0BI+2D+tG9QgBQJPbd3uUzgTQZIeIgYgAsFyF0tJ+0jC5pZeKktqUDny
 meLQ==
X-Gm-Message-State: AOJu0YxwHnCUi8FpIAxgN1q5YTRUGnKFHxVZDl22GmMKMWpjYAcWWpiz
 LjHxh9Ktt/TOHaXJddNgzMJSig==
X-Google-Smtp-Source: AGHT+IGazNWGG5eLIYSZ01n6BIyYDzIXGzaXvh74BBRpJJSXz3bmHCI2nEJ9WWxMtc5FZl5aUvW/pw==
X-Received: by 2002:a17:90b:224b:b0:27d:55b4:e72 with SMTP id
 hk11-20020a17090b224b00b0027d55b40e72mr16449462pjb.2.1698210903035; 
 Tue, 24 Oct 2023 22:15:03 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:65fc:df7c:6edb:619f])
 by smtp.gmail.com with ESMTPSA id
 fz3-20020a17090b024300b002609cadc56esm7715815pjb.11.2023.10.24.22.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 22:15:02 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 4/5] doc: cmd: add documentation for scmi
Date: Wed, 25 Oct 2023 14:14:26 +0900
Message-Id: <20231025051427.509602-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025051427.509602-1-takahiro.akashi@linaro.org>
References: <20231025051427.509602-1-takahiro.akashi@linaro.org>
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
v6
* add the manual to doc/usage/index.rst
v4
* s/tranport/transport/
v2
* add more descriptions about SCMI
---
 doc/usage/cmd/scmi.rst | 126 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst    |   1 +
 2 files changed, 127 insertions(+)
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
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 98b4719c4088..9a65b50aeed7 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -94,6 +94,7 @@ Shell commands
    cmd/saves
    cmd/sbi
    cmd/sf
+   cmd/scmi
    cmd/scp03
    cmd/seama
    cmd/setexpr
-- 
2.34.1

