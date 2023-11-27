Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ADFC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16918756E;
	Mon, 27 Nov 2023 14:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p/jCd8ws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3927087264; Mon, 27 Nov 2023 14:00:21 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7228754D
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507adc3381cso5645559e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090013; x=1701694813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R96wmt+0ynJzffDqptgzqh4jU0VSY12cfqSJiBi8Mw4=;
 b=p/jCd8wsny5LwvvCxQ9xiWwhFo0d2HlMMAwZ6fb1sxR2chCaPXm3f0GVJPjFL7VkVz
 0kdJQxFDtG9Pu8XEGaGJK1J7o70xb1Put8JbQcQxyfB8xoCF2HHwcc6ZtSY81Gz1dlLi
 0NT3Yu9YPoBveiREi2UTbgNI+i5HppnDJEkwgtM78rvXeNO3QNnS1PPtNcOX771Q65F8
 I2VOgli5Ek8HVjW+VZgzupLhjIwP8LkaRSshKBGP45KLiWk8QemHn2ICNAGTIvLX1+NN
 vmm6S4JYIcffLipJpnt8Ri1JE3VYCAtRv4huuOwT47UYyi5ar/cZELQsoMKxXk8Vvqfv
 TqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090013; x=1701694813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R96wmt+0ynJzffDqptgzqh4jU0VSY12cfqSJiBi8Mw4=;
 b=F+TNvQhdXIZLOosOmNx8POuLlarB1jWO6XeE4RuIyOqSX+pE2pEMgyZSTfU2ZffL3W
 fjtNWnhrbNZRpDcaMaNL0/imXl+J+zaaSfJN5XQNqGt9JvRaSFy/RYIcbzWDhl0onEJu
 iQqs7oNIXNqHg1dpYgNT0cPszvrL3aTBhH9uEEkPftls3/vru8uLUKwsyyzi1Cdav0Lm
 6HBgnnijKItJnBgOnxeC6uSNBIVaSomu0AlNCtPw3TCZX54in1Tj3ROIz0zDgBBIqY3G
 J1+JwAsgb1xUvYeQ+31vkG8i0JQSsroACGBOObChJh0/Pp4J1ZWUzwjvb4nbe1UZyfDX
 RVLg==
X-Gm-Message-State: AOJu0Yyx3+Tym1velL1/X2ymFcI/Tb7o6UePifV6nRujQQ/0H0xMckRw
 eJtwxLz5uevTmlZKo51sxXUssB9Q7iUrAoTLN2Ldaw==
X-Google-Smtp-Source: AGHT+IFFimxQx3L+mZgceYG1Ks+xPG151TwAvBoGgloY9AiEiZ5OjU1qviHdsSQbYA/4zEbAPiZxvw==
X-Received: by 2002:a05:6512:3117:b0:50a:73a8:ae4f with SMTP id
 n23-20020a056512311700b0050a73a8ae4fmr6544281lfb.29.1701090013377; 
 Mon, 27 Nov 2023 05:00:13 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:13 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATHv11 02/43] net/lwip: add doc/develop/net_lwip.rst
Date: Mon, 27 Nov 2023 18:56:45 +0600
Message-Id: <20231127125726.3735-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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
Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 doc/develop/index.rst    |  1 +
 doc/develop/net_lwip.rst | 75 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 doc/develop/net_lwip.rst

diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index f82e148b10..14951712e4 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -50,6 +50,7 @@ Implementation
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

