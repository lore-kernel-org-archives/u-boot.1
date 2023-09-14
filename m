Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6278DEEAA53
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0452A86AA2;
	Thu, 14 Sep 2023 18:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yz2s0py2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945E286A3C; Thu, 14 Sep 2023 18:20:43 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4762186672
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bf66a32f25so17920021fa.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708440; x=1695313240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlGOSpnuP038/3uWYsQ6F/fPIq0GHwMSq4PrefaoKZA=;
 b=yz2s0py2u8LPS/cBbe9AtJjfshM61oQDbP3BOJn2F0lbuA2U7mSqTGNz8o1dJPNabf
 Rr72xeE1nsN9spWqZi2kUZEQiJ+zW9PrwEEJra2lnGY8raQqnRFf0B5x0AJg2TMwUl5T
 KBCEFjAfc/YO9KRKnig68+QPxcp1QJu7P5g8Epf6sEsUst09UGA0FZh/hDLxWNcTsK2N
 nI5j+PE+oto/wSTPhv7Xo+MmPKuUj+4LJE9FgoZztxesyEqaonosX5Stlpdau5/nKh/t
 IvGwbwhLSy5+9iBG/DZg7pDtTXjjlfaOxAzd+92vcyYW79LdX2GICvqOLIA6cKjCDAfj
 hsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708440; x=1695313240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlGOSpnuP038/3uWYsQ6F/fPIq0GHwMSq4PrefaoKZA=;
 b=SI/YPwBCW7Aj69ZLnLGnbveJTn2NsCRimMjy/oZUzawGQr+LJbp4MAyNMl30mQDQUw
 wvOnHFEaxr2Y0jkCVdaxGn1YVVIjjh8y2to7acN0b6Sz9I6tCW/oDK3DLaV966Gu5B+r
 QT4YvAubNFMILrPHJxWpHKQE7eITwfLcvm+mHWHdNQx4CXemygCwy+LbXFrlMeDDrChC
 8UpWpATBk3nI6j/O9NuqEmNFidPrgXnFOWK03D1/6jVlUFrz5+5Q99dKA8TGuZAirdMp
 q4tpuFow+Rn6cwB/w0sHvL2uTcg85HO/0CA47RX70PHO7On9l76qUeAu1/5d8OwApa6x
 Ot4w==
X-Gm-Message-State: AOJu0YyPqelK8Jg74WY9yLNR1RQVriqMcIeVzc1mUoQVqIrni4Us/EDy
 plCLjTfcHFwZmBwnBDQzaBshqjJuKRoGr4zZrxVkkg==
X-Google-Smtp-Source: AGHT+IEXJEsBSTxuJq8dKcCXQ4BKMCcJcUxE1WumltI9L/5lADIVLn1IMyjPofdvVr0yN1iTEiFzmA==
X-Received: by 2002:a2e:9f06:0:b0:2bd:beb:4aca with SMTP id
 u6-20020a2e9f06000000b002bd0beb4acamr5170780ljk.13.1694708440428; 
 Thu, 14 Sep 2023 09:20:40 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:20:40 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCHv9 02/15] net/lwip: add doc/develop/net_lwip.rst
Date: Thu, 14 Sep 2023 22:18:15 +0600
Message-Id: <20230914161828.3662-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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

