Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C45EB8FDE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17FA586A56;
	Fri,  8 Sep 2023 04:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NhFJKcTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C2086A63; Fri,  8 Sep 2023 04:52:45 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E2D86A2B
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c0a4333e03so3613065ad.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141560; x=1694746360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+nCrwralLYJWw3cK2cn/j0ATdvZUzxwirrlaBQWDDA=;
 b=NhFJKcTR513k0jpTVrCDZucwGSEO73AzKDNj29KI+GetNB8EtXxIaXirwn07M3+Zmg
 5+s4ZN1Ni7t0Ch/ATJmsinQgInlfREBx/Iz20Y2NgutNRunw+Z+VCQDpZoqTce7VHJN8
 uo1CsP3rQd1t38p/8HfbGPfwtrfCmWYVser3NzuduemA0+nrVkloFbHNbH+6/fHPoB96
 U8U3Z6updrk4hTc6HC/kb7sa3igGR/dDhANfqMMCuGGYC8OGnVmrbR261Sa1MUaPzvZt
 IBwujm9oLiT/GvAEBdpRgQjebB9DUPPPKyblw6rBH7COO5lSzZI1Tyq2MA9nPUYfWwlp
 IcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141560; x=1694746360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+nCrwralLYJWw3cK2cn/j0ATdvZUzxwirrlaBQWDDA=;
 b=hiJKtW3MxIhE75+ZE4+5ES5fQs4lp+/LCNttl0gUark0ZOwP+lpFeerriE7JZKJyMS
 TULIZe/HG21ZczNFTpbr6KqB037rXfvScOrd81DK6grYPgPWy++CFVIEi+PfZEOqpkUs
 GyYmhUAkft3l27kzkRKl97QAUh3wpIuazEIp7hW0cXP14ydUi61CVSRI5WI4tHYE/rjG
 OQFKy5WN9Ed8D0onibRnu+I9FHvNDkUIdm8RAYHMu7YIla+3cyRH/qKSFSkTV806xCPK
 EWwCDVM9gv5PMDA47BiGdHAWebTeANHiGdvgH+6a+ajsvEIHT/d2wpiomYCpa+K8h43m
 iRuQ==
X-Gm-Message-State: AOJu0Yy5BmGMB9OKr4Co9toWR4v7hP6gSRfpg34J1dBEbrM81xsEF03x
 olBY3NxSUO99/ADf2zkeuYF/cg==
X-Google-Smtp-Source: AGHT+IFiVfb7rdOjGGAjRy5Z+MRH4Ta8+42eisst+jEUcWDis2jl8F2/zMeys0QYNGKrUjFMP/Gktg==
X-Received: by 2002:a17:902:e751:b0:1c3:6f9e:6769 with SMTP id
 p17-20020a170902e75100b001c36f9e6769mr1413083plf.4.1694141560616; 
 Thu, 07 Sep 2023 19:52:40 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:40 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 12/13] doc: cmd: add documentation for scmi
Date: Fri,  8 Sep 2023 11:51:37 +0900
Message-Id: <20230908025138.44405-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908025138.44405-1-takahiro.akashi@linaro.org>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
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
v2
* add more descriptions about SCMI
---
 doc/usage/cmd/scmi.rst | 126 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 doc/usage/cmd/scmi.rst

diff --git a/doc/usage/cmd/scmi.rst b/doc/usage/cmd/scmi.rst
new file mode 100644
index 000000000000..aebcfe95101d
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
+a tranport layer.
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

