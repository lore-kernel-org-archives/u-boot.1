Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A38E7D272
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A9286D24;
	Tue, 26 Sep 2023 11:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xGHR/Jkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C289486D24; Tue, 26 Sep 2023 11:43:49 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4A886AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c123eed8b2so138887281fa.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721426; x=1696326226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlGOSpnuP038/3uWYsQ6F/fPIq0GHwMSq4PrefaoKZA=;
 b=xGHR/JkkORgxkxWACmHhnaz110u+XWpdU07Aowb6gncHkkIIKCrQYKZo9Lu8m3ITW3
 bYu/NtDIXlliX8um3DAZRjEbCST3CPpY+azUBOM+m2rmlI1DyXgsEBvAo9GcWXP6KjoN
 hzGEr7O2R0nCnVWAa0HwjikZ804LxxFTcDtggCAShIoIaHtmqk3oVl0Fd4WtS8o0OXy1
 IjSEKmPM9Y2RT8RLDk2xtK8MdY4LmQlpWn9DoUEMtSeWa9kgi5BlhQN38pzp+F7Emh8G
 c5BnCU7IBF+CXGYj0ouWp2RU6hirQsqtuXuou4Etd+WUhQ6zqOGmfKZPFj4Aj+/YWv5J
 pMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721426; x=1696326226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlGOSpnuP038/3uWYsQ6F/fPIq0GHwMSq4PrefaoKZA=;
 b=OFjNVPXSds6P5aSnjvOhNpAp0QeYPAwBChWvXkb+noJS3SfsoFUfSNJEQjtdOvxXX2
 eaWPm0HPrlrbOezdvCZUoooiKOEGwLv7U+xlNsj9x8jBQGWE5YMqKVBDsAyiA+Hrylcj
 EBM1pulWK5pTziOrA95Cmcd5Z0En2IkM7Uo9wujmVpDmB3Vl8zD2oAfgtJWJ6g8ozXyy
 7FzJv6xmkRwnBnue9kcNmPJ9/Vy2EKG1S9pwn1cm4BX4hoiCoRXvCH4AgRXAyp0zjXmi
 jwYvGQLV1jIx0fc5+j025YB4Hl9lUZ4cJbAnoB6q8wj62+/2U15t7NGpP5QzHBWAn0mv
 K4Pg==
X-Gm-Message-State: AOJu0YzDEsgNkpduQsBXotfWB7nilOrk+sYccrUh7O74bXKvJqV+raUC
 VCegiMFTw8BtDLYuyiOmIIYvL1bKbCV+H1SLiPPTZQ==
X-Google-Smtp-Source: AGHT+IH0399gJLctOsf4mA2aa7rOkGz+yUX0w8TRnGBaTqgRckGxuxvadikJS/cx8shkBD3LmqQ02A==
X-Received: by 2002:ac2:58cc:0:b0:500:7fc1:414b with SMTP id
 u12-20020ac258cc000000b005007fc1414bmr7480977lfo.25.1695721426641; 
 Tue, 26 Sep 2023 02:43:46 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:43:46 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCHv10 03/15] net/lwip: add doc/develop/net_lwip.rst
Date: Tue, 26 Sep 2023 15:41:12 +0600
Message-Id: <20230926094124.7024-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

