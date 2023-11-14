Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89621C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 02:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524E5863C9;
	Tue, 14 Nov 2023 03:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cro02O9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14AE871FC; Tue, 14 Nov 2023 03:14:56 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C5D8716C
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 03:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc703d2633so5563705ad.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 18:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699928092; x=1700532892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9EWYzhzvRnohj45QdHocxpuPdq+TXjcOYtY+RMWKqw=;
 b=Cro02O9hJgHPGcxPvRRbXBWghYQPZ4/rAGqK0BHWgKYmEeWGTUbGMFdc8tUK5EYIAk
 xEG7m/8fIXyL/pZvE2fD27PqCFc2JV4KvEnS1JfatcGnUPLk+TwnXztQj+mj0sN/Xxl5
 lgeqqNxd/Gd/ieI1LBzFa5C8VVRmhBRsYwedda5QS2bEgo4CS1aamFkJ5acC+OeIBtc5
 7YEi0TI1sVQqRcNLI0djMvPnwPPTAIdq4do+6NftVN1vWyVFZiZbIaZmBM71PUXhx4b3
 EtSCMv2CqiFPd3F+5YfK5NAnbLxjdYecebWn1xHsr0p0HaYR4RVA6zmkMxi3k54upSCY
 /1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699928092; x=1700532892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9EWYzhzvRnohj45QdHocxpuPdq+TXjcOYtY+RMWKqw=;
 b=vHCLnz5t+qN3JVRbf5egEpNLXIvj8K6oFWtt7z6AhgR3qz8Qf4NRthynCUoANt30cY
 am5DEAFtrtBrvJpN5rWHBETyfwdeCgTxI5MnNfB7RArw1pDc6AoJWYObUgXYLJEOfOug
 2B+XpAru4Zd7lbz9E6mXi4zmSgA6ODUMNjc6dT9aEcYwQnvoDnJIjJrareYzXY5vwCVs
 4z5zC9mCX23sHcmpwhrUbLcJSfwN9GTS0iKByR73X0vg5WLNR2ve/z1YGaGCNi16fm+E
 fPHXMK/29uGVfdhkK7+ErRbhaQdmSbquGginr+Qb0FLT3R2LvD85oHtu6bxDOkTnz28V
 WmOA==
X-Gm-Message-State: AOJu0Yx7nUAMKPlmi7kiMTbbXpb2+KdZVJkD5AZ9JwVzOglFZvqSG63r
 mVsZcWaFjPTKN6bTsG13gaDPkw==
X-Google-Smtp-Source: AGHT+IEieIMrfVwSQpDYh0aZNUlAcpsfNaAZ8QO4f/SG5YGAuVWoMe83lTZHHegTQLmkJS2F6ovfkA==
X-Received: by 2002:a17:903:234a:b0:1c9:e121:ccc1 with SMTP id
 c10-20020a170903234a00b001c9e121ccc1mr1099286plh.5.1699928092192; 
 Mon, 13 Nov 2023 18:14:52 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:66f2:cd5c:3d82:6e6f])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a170902c94400b001c61afa7009sm4680475pla.114.2023.11.13.18.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 18:14:51 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 4/5] doc: cmd: add documentation for scmi
Date: Tue, 14 Nov 2023 11:14:27 +0900
Message-Id: <20231114021428.531887-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114021428.531887-1-takahiro.akashi@linaro.org>
References: <20231114021428.531887-1-takahiro.akashi@linaro.org>
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
index d8e23fcacffb..1a626c03c237 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -94,6 +94,7 @@ Shell commands
    cmd/rng
    cmd/saves
    cmd/sbi
+   cmd/scmi
    cmd/scp03
    cmd/seama
    cmd/setexpr
-- 
2.34.1

