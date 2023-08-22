Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C4CEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645108649C;
	Tue, 22 Aug 2023 11:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hoxg/+eX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB2F8649B; Tue, 22 Aug 2023 11:38:28 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1191686485
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b95d5ee18dso66644481fa.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697104; x=1693301904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zF1z8x596ZFPGv6nhkRshR4N1Qx5hz0TD2Q54CzOIo=;
 b=hoxg/+eXEc+rTeZkDXZDCBECs4043EXJ10qxSGe7/iytjYZ0W2VAuSWEUxZ3r8t98R
 g1sAR9aWW2TlFeIC8iCcEJ5oXmh6l7Ck2x1X3GCqGdgIPCShGStkPCBclxhl2tAIDMmC
 anAHd2lnRMH0JAqE6w+rjJmr+aWod+usPzMmJgTQB89Fv2s3YP8SyT/qlmKhlrdU2FVL
 T25/fD4S/zkYIDUuV5516k0UvgpjN4podCgE57yVyAdBO1DgxnONoJQv3/d6ztk7SOHv
 NHsQcskfRd8gyc9B8ToQRhIOgjtRLWaoIZByG11yiWDaxAt/vz4PYC+gxMjM93+nau/L
 Z9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697104; x=1693301904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zF1z8x596ZFPGv6nhkRshR4N1Qx5hz0TD2Q54CzOIo=;
 b=NmdvSyXGNatCh7koqzAUUNZzCJmRMReTqne4e5+PRFg2uFAb2HcAcDjuz3Kabb7A2v
 Hie09XRRe0WGGf2/rK2MKDxNVrRZDL0rO8RE2to3luAf1/Z2RXrM8IJd/V18yA5Jk+y+
 00tWufJ4F4Nfaj/Qr3vClTDtZs/epf8JNMwFcGoDyI4lnil3iMaV33db+Hgd0IuH4a1n
 /FrY1c+CEaR33p5gvBud6bJGdW+JK78+EbcTN2REayNMdyipyXCtOIWvFYd3lf0P/kyc
 ZC6Smh4hDuo0tAZnjpkE74kx6K/oxO9UXUn7/G9mmLBM5Z8IyVtBuQKWitD5qOl2AKOt
 bdFg==
X-Gm-Message-State: AOJu0YzVziVz6pJuqBvyukeB9Kn41me4tEDN0qkd509mfqfg1uSePGOJ
 v8xv4bI33scZpKG+0KcZZK6QTSAWyyJoTyz3yPmYlA==
X-Google-Smtp-Source: AGHT+IHMi8eTyHaJk3bdqdqf+j3oHHib5/2d7YSBU6zHhHzjQAyXvsTUe0uWrZBe7yv9u7J3KRqMIw==
X-Received: by 2002:a2e:740d:0:b0:2b9:df49:b818 with SMTP id
 p13-20020a2e740d000000b002b9df49b818mr6237873ljc.53.1692697104036; 
 Tue, 22 Aug 2023 02:38:24 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:23 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCHv7 01/15] net/lwip: add doc/develop/net_lwip.rst
Date: Tue, 22 Aug 2023 15:36:00 +0600
Message-Id: <20230822093614.4717-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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
 doc/develop/net_lwip.rst | 76 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
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
index 0000000000..cd85de92a1
--- /dev/null
+++ b/doc/develop/net_lwip.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+LWIP IP stack intergation for U-Boot
+====================================
+
+Intro
+-----
+
+LWIP is a library implementing network protocols, which is commonly used
+on embedded devices.
+
+https://savannah.nongnu.org/projects/lwip/
+
+LwIP  license:
+LwIP is licensed under a BSD-style license: http://lwip.wikia.com/wiki/License.
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

