Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F04EE8004
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3684786A4C;
	Fri,  8 Sep 2023 15:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MOmthwww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D3686A45; Fri,  8 Sep 2023 15:55:36 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2477B86A34
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso35639801fa.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181332; x=1694786132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qa7rsDpd8DTjUr2xn0X7Ta38Y9zQGUvwzqZuvwV3Ssg=;
 b=MOmthwwwMjhRJ1ocDfaZcSpciULwsNcSPMYBlMTWh96Mc20skDdVT2Z38+nVbNnPjb
 gm4D3v8Dc1mdPply4u7EOX86TulGNqDQu986/101Xq41OqO4Z6t+HOx+SCXk/JDeH+Wf
 XTECTLIMy+EESsuviHgCrbQhId9i02CvE+an59vbzrzcaxAT+MtenGMWBG02B+YU7Yv6
 cm5scutgmVM9Xg0weLcUyBbhgo9x8n1bllqYyfPmmw2JRdVALXLw4YjpuJIZYGyX5Eoi
 fBefpKBvvZvNK5oNFv8ZDDaQcm/mCCBPD2l9peX4+tqTUkIsIcylZQc2UI9g0jleI+Tz
 yn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181332; x=1694786132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qa7rsDpd8DTjUr2xn0X7Ta38Y9zQGUvwzqZuvwV3Ssg=;
 b=Oz3WDyTPCWbVotSWMacJjuUoOBR5hhVG1oLrkxjTPCwdUWtMb5H53WQaCEdqb7nRgq
 C+ThaVCXkUtrCZFCzHox3oHT+La+MtmZ2+PY9jvNELcmSmH5YG+c8Tz4538obEPi+llo
 kBpJuyLrsfvRIczqe649vQwjPHjNc0O6ry87tIx7qbJCrNU3hxE7PeCyCOsRMikh4uVA
 +OOMTzLcLD/AQaRLj6eCKazybQ9jFJb4utuTi+yAgqwLZlkbaL4s4DNevO1iBtFfjebR
 I8alWZ6xj6BSYP8985wat01rUxr7LkTXuQxglzKlW5ov4c0k1glNVV6A1X/ke2WlqLAH
 GByw==
X-Gm-Message-State: AOJu0YxdQpLFZe+3yJRC+wHThQpWVYnEzGVKHx5S0YbvE/Ew4AWxS+Ou
 y/oYDRuhwwubHO3HoM0r/hirz5hTv2mWOjk7rB2mcA==
X-Google-Smtp-Source: AGHT+IHDtCE7bzz1BC6qvs2ZudRU4IG+2Fv5tsc13a60OiUI5ZqUEm5SuZYfcJI1Al0oKJjQl9yzNw==
X-Received: by 2002:a2e:9906:0:b0:2bc:f60c:445f with SMTP id
 v6-20020a2e9906000000b002bcf60c445fmr1874095lji.36.1694181332244; 
 Fri, 08 Sep 2023 06:55:32 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:55:32 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCHv8 01/15] net/lwip: add doc/develop/net_lwip.rst
Date: Fri,  8 Sep 2023 19:53:06 +0600
Message-Id: <20230908135320.7066-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add initial documentation of lwIP network IP stack integration
to the U-Boot (net_lwip.rst).

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/develop/index.rst    |  1 +
 doc/develop/net_lwip.rst | 75 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 doc/develop/net_lwip.rst

diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 5b230d0321..4764990f25 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -48,6 +48,7 @@ Implementation
    spl
    falcon
    uefi/index
+   net_lwip
    vbe
    version
 
diff --git a/doc/develop/net_lwip.rst b/doc/develop/net_lwip.rst
new file mode 100644
index 0000000000..a77ab60d0f
--- /dev/null
+++ b/doc/develop/net_lwip.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+lwIP IP stack integration for U-Boot
+====================================
+
+Intro
+-----
+
+lwIP is a library implementing network protocols, which is commonly used
+on embedded devices.
+
+https://savannah.nongnu.org/projects/lwip/
+lwIP  license:
+lwIP is licensed under a BSD-style license: http://lwip.wikia.com/wiki/License.
+
+Main features include:
+
+* Protocols: IP, IPv6, ICMP, ND, MLD, UDP, TCP, IGMP, ARP, PPPoS, PPPoE
+
+* DHCP client, DNS client (incl. mDNS hostname resolver),
+  AutoIP/APIPA (Zeroconf), SNMP agent (v1, v2c, v3, private MIB support
+  & MIB compiler)
+
+* APIs: specialized APIs for enhanced performance, optional Berkeley-alike
+  socket API
+
+* Extended features: IP forwarding over multiple network interfaces, TCP
+  congestion control, RTT estimation and fast recovery/fast retransmit
+
+* Addon applications: HTTP(S) server, SNTP client, SMTP(S) client, ping,
+  NetBIOS nameserver, mDNS responder, MQTT client, TFTP server
+
+U-Boot implementation details
+-----------------------------
+
+1. In general we can build lwIP as a library and link it against U-Boot or
+   compile it in the U-Boot tree in the same way as other U-Boot files. There
+   are few reasons why second variant was selected: lwIP is very customizable
+   with defines for features, memory size, types of allocation, some internal
+   types and platform specific code. It turned out easier to enable/disable
+   debug which is also done with defines, and is needed periodically.
+
+2. lwIP has 2 APIs - raw mode and sequential (as lwIP names it, or socket API
+   as we name it in Linux). For now only raw API is supported.
+
+In raw IP mode a callback function for RX path is registered and will be called
+when packet is passed to the IP stack and is ready for the application.
+
+One example is the unmodified working ping example from lwip sources which
+registered the callback:
+
+.. code-block:: c
+
+        ping_pcb = raw_new(IP_PROTO_ICMP);
+        raw_recv(ping_pcb, ping_recv, NULL); <- ping_recv is app callback.
+        raw_bind(ping_pcb, IP_ADDR_ANY)
+
+3.  Input and output
+
+RX packet path is injected to U-Boot eth_rx() polling loop and TX patch is in
+eth_send() accordingly. That way we can leave the driver code unmodified and
+consume packets once they are ready. So we do not touch any drivers code and
+just eat packets when they are ready.
+
+U-Boot lwIP Applications
+========================
+
+.. kernel-doc:: include/net/lwip.h
+   :internal:
+
+lwIP API to control polling loop
+================================
+
+.. kernel-doc:: include/net/ulwip.h
+   :internal:
-- 
2.30.2

