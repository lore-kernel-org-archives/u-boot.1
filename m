Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A93C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438148756C;
	Mon, 27 Nov 2023 14:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AMGr1BJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFC187515; Mon, 27 Nov 2023 14:00:32 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1944D8756C
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso5758130e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090029; x=1701694829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNzzTO9A4gGM/m8/mh0dG+0DOn4j7ZyXt/4zJSA/HSg=;
 b=AMGr1BJ/FVIBZgfRQK9yfKfiG5xCJKK0JRhNzNXUIMdm1CbhrQnmh8phgr9IMK4IYh
 R1qP7IpCyS/4UIa+yYZ+J5yRCx3OXjdfh0rwhoGNYQIEAHoeNh26RHFHuJ7QK8wT0iPb
 H6FKZY+xPaRELISaElWnwLBtq4JdB8F+zvOUeaQ1W9errA9wsZM9vBchOQd2QQizgRZQ
 t3iYmUBZazub/XW+Iobg9h61JH+Uh9zAGvlhl/LrpXBUHjA71c6yeXqBAUMIk3A0ZG2Q
 st55YmNqMwk5hNQ365pxvMfH37LkKJWh0uO7nmNLOFPjlCa5Y3kG04ktE9eHqdejxjKT
 WyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090029; x=1701694829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNzzTO9A4gGM/m8/mh0dG+0DOn4j7ZyXt/4zJSA/HSg=;
 b=v+Wry+DN+lvLYyIfElubzoVbjmZLKJ6WuiOdOI/MEzwwVJjHFnxUSxdb4gzQMGl8ar
 6G2+b2b+yIabZsEJ4V8kHLpiol124UcG0mxWcDljmFSGXAfKJw+YKMrkzV6Al4Z1aXhk
 7/VwyoyxypCl7Hk8FOn6lapUro1EWrGWF+laolPcHEmts6AGINRWY7RVhV1tjqBf2si2
 Uv4JFyA/XF1ZwOkenb5jMsY6ej24ybv/GDfL1h4WyrV1ga7QpkXY8O6S7/BOf4D2lIEp
 OW0DG3XZZ83Jlb/gPdQt0m8DsoqwsSZkoAYyYiDK6dSGPmMnlzt3QW0Onosz9p63DoOc
 OQtA==
X-Gm-Message-State: AOJu0Yz4Cmi5eMS84CJh0kJvJ2H9AK+pj8L4rGTEZMDJTV8ILRG96eVP
 O8PYlr++Yqms8sC5c0IpynHuAZdsjkU/jHZuFFPB2g==
X-Google-Smtp-Source: AGHT+IFgXQVcaZ66gZiE+dnaAJHo7WT1Thz7gCC5ZWNA/tMz3eNcM7zNNdTDmuTBsHQm0YoDOHX32A==
X-Received: by 2002:a05:6512:b03:b0:50a:a5c6:35ea with SMTP id
 w3-20020a0565120b0300b0050aa5c635eamr10068492lfu.50.1701090029208; 
 Mon, 27 Nov 2023 05:00:29 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:28 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 09/43] net/lwip: add lwIP configuration
Date: Mon, 27 Nov 2023 18:56:52 +0600
Message-Id: <20231127125726.3735-10-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

lwip configuration can be tuned with header file.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 net/lwip/lwipopts.h | 178 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 net/lwip/lwipopts.h

diff --git a/net/lwip/lwipopts.h b/net/lwip/lwipopts.h
new file mode 100644
index 0000000000..731da30baa
--- /dev/null
+++ b/net/lwip/lwipopts.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#ifndef LWIP_LWIPOPTS_H
+#define LWIP_LWIPOPTS_H
+
+#include "lwipopts.h"
+
+#if defined(CONFIG_LWIP_LIB_DEBUG)
+#define LWIP_DEBUG 1
+#define LWIP_DBG_MIN_LEVEL              LWIP_DBG_LEVEL_ALL
+#define LWIP_DBG_TYPES_ON               LWIP_DBG_ON
+#define ETHARP_DEBUG                    LWIP_DBG_ON
+#define NETIF_DEBUG                     LWIP_DBG_ON
+#define PBUF_DEBUG                      LWIP_DBG_OFF
+#define API_LIB_DEBUG                   LWIP_DBG_ON
+#define API_MSG_DEBUG                   LWIP_DBG_OFF
+#define SOCKETS_DEBUG                   LWIP_DBG_OFF
+#define ICMP_DEBUG                      LWIP_DBG_OFF
+#define IGMP_DEBUG                      LWIP_DBG_OFF
+#define INET_DEBUG                      LWIP_DBG_OFF
+#define IP_DEBUG                        LWIP_DBG_ON
+#define IP_REASS_DEBUG                  LWIP_DBG_OFF
+#define RAW_DEBUG                       LWIP_DBG_OFF
+#define MEM_DEBUG                       LWIP_DBG_OFF
+#define MEMP_DEBUG                      LWIP_DBG_OFF
+#define SYS_DEBUG                       LWIP_DBG_OFF
+#define TIMERS_DEBUG                    LWIP_DBG_ON
+#define TCP_DEBUG                       LWIP_DBG_OFF
+#define TCP_INPUT_DEBUG                 LWIP_DBG_OFF
+#define TCP_FR_DEBUG                    LWIP_DBG_OFF
+#define TCP_RTO_DEBUG                   LWIP_DBG_OFF
+#define TCP_CWND_DEBUG                  LWIP_DBG_OFF
+#define TCP_WND_DEBUG                   LWIP_DBG_OFF
+#define TCP_OUTPUT_DEBUG                LWIP_DBG_OFF
+#define TCP_RST_DEBUG                   LWIP_DBG_OFF
+#define TCP_QLEN_DEBUG                  LWIP_DBG_OFF
+#define UDP_DEBUG                       LWIP_DBG_OFF
+#define TCPIP_DEBUG                     LWIP_DBG_OFF
+#define SLIP_DEBUG                      LWIP_DBG_OFF
+#define DHCP_DEBUG                      LWIP_DBG_ON
+#define AUTOIP_DEBUG                    LWIP_DBG_ON
+#define DNS_DEBUG                       LWIP_DBG_ON
+#define IP6_DEBUG                       LWIP_DBG_OFF
+#define DHCP6_DEBUG                     LWIP_DBG_OFF
+#else
+#define LWIP_DBG_MIN_LEVEL              LWIP_DBG_LEVEL_ALL
+#define LWIP_DBG_TYPES_ON               LWIP_DBG_OFF
+#define ETHARP_DEBUG                    LWIP_DBG_OFF
+#define NETIF_DEBUG                     LWIP_DBG_OFF
+#define PBUF_DEBUG                      LWIP_DBG_OFF
+#define API_LIB_DEBUG                   LWIP_DBG_OFF
+#define API_MSG_DEBUG                   LWIP_DBG_OFF
+#define SOCKETS_DEBUG                   LWIP_DBG_OFF
+#define ICMP_DEBUG                      LWIP_DBG_OFF
+#define IGMP_DEBUG                      LWIP_DBG_OFF
+#define INET_DEBUG                      LWIP_DBG_OFF
+#define IP_DEBUG                        LWIP_DBG_OFF
+#define IP_REASS_DEBUG                  LWIP_DBG_OFF
+#define RAW_DEBUG                       LWIP_DBG_OFF
+#define MEM_DEBUG                       LWIP_DBG_OFF
+#define MEMP_DEBUG                      LWIP_DBG_OFF
+#define SYS_DEBUG                       LWIP_DBG_OFF
+#define TIMERS_DEBUG                    LWIP_DBG_OFF
+#define TCP_DEBUG                       LWIP_DBG_OFF
+#define TCP_INPUT_DEBUG                 LWIP_DBG_OFF
+#define TCP_FR_DEBUG                    LWIP_DBG_OFF
+#define TCP_RTO_DEBUG                   LWIP_DBG_OFF
+#define TCP_CWND_DEBUG                  LWIP_DBG_OFF
+#define TCP_WND_DEBUG                   LWIP_DBG_OFF
+#define TCP_OUTPUT_DEBUG                LWIP_DBG_OFF
+#define TCP_RST_DEBUG                   LWIP_DBG_OFF
+#define TCP_QLEN_DEBUG                  LWIP_DBG_OFF
+#define UDP_DEBUG                       LWIP_DBG_OFF
+#define TCPIP_DEBUG                     LWIP_DBG_OFF
+#define SLIP_DEBUG                      LWIP_DBG_OFF
+#define DHCP_DEBUG                      LWIP_DBG_OFF
+#define AUTOIP_DEBUG                    LWIP_DBG_OFF
+#define DNS_DEBUG                       LWIP_DBG_OFF
+#define IP6_DEBUG                       LWIP_DBG_OFF
+#define DHCP6_DEBUG                     LWIP_DBG_OFF
+#endif
+#define LWIP_TESTMODE                   0
+
+#if defined(CONFIG_LWIP_LIB_NOASSERT)
+#define LWIP_NOASSERT 1
+#define LWIP_ASSERT(message, assertion)
+#endif
+
+#include "lwip/debug.h"
+
+#define SYS_LIGHTWEIGHT_PROT            0
+#define NO_SYS                          1
+
+#define LWIP_IPV6			0
+
+#define MEM_ALIGNMENT                   1
+#define MEM_SIZE                        1600
+
+#define MEMP_NUM_PBUF                   4
+#define MEMP_NUM_RAW_PCB                2
+#define MEMP_NUM_UDP_PCB                4
+#define MEMP_NUM_TCP_PCB                2
+#define MEMP_NUM_TCP_PCB_LISTEN         2
+#define MEMP_NUM_TCP_SEG                16
+#define MEMP_NUM_REASSDATA              1
+#define MEMP_NUM_ARP_QUEUE              2
+#define MEMP_NUM_SYS_TIMEOUT            4
+#define MEMP_NUM_NETBUF                 2
+#define MEMP_NUM_NETCONN               32
+#define MEMP_NUM_TCPIP_MSG_API          8
+#define MEMP_NUM_TCPIP_MSG_INPKT        8
+#define PBUF_POOL_SIZE                  8
+
+#define LWIP_ARP                        1
+#define ARP_TABLE_SIZE			10
+#define ARP_QUEUEING			1
+
+#define IP_FORWARD                      0
+#define IP_OPTIONS_ALLOWED              1
+#define IP_REASSEMBLY                   1
+#define IP_FRAG                         1
+#define IP_REASS_MAXAGE                 3
+#define IP_REASS_MAX_PBUFS              4
+#define IP_FRAG_USES_STATIC_BUF         0
+
+#define IP_DEFAULT_TTL                  255
+
+#define LWIP_ICMP                       1
+
+#define LWIP_RAW                        1
+
+#define LWIP_DHCP                       1
+#define LWIP_DHCP_BOOTP_FILE		1
+#define LWIP_DHCP_DOES_ACD_CHECK	0
+
+#define LWIP_AUTOIP                     0
+
+#define LWIP_SNMP                       0
+
+#define LWIP_IGMP                       0
+
+#define LWIP_DNS                        1
+
+#define LWIP_UDP                        1
+
+#define LWIP_TCP                        1
+
+#define LWIP_LISTEN_BACKLOG             0
+
+#define PBUF_LINK_HLEN                  14
+#define PBUF_POOL_BUFSIZE               LWIP_MEM_ALIGN_SIZE(TCP_MSS + 40 + PBUF_LINK_HLEN)
+
+#define LWIP_HAVE_LOOPIF                0
+
+#define LWIP_NETCONN                    0
+#define LWIP_DISABLE_MEMP_SANITY_CHECKS 1
+
+#define LWIP_SOCKET                     0
+#define SO_REUSE                        0
+
+#define LWIP_STATS                      0
+
+#define PPP_SUPPORT                     0
+
+#define LWIP_TCPIP_CORE_LOCKING		0
+
+#define LWIP_NETIF_LOOPBACK		1
+
+/* use malloc instead of pool */
+#define MEMP_MEM_MALLOC                 1
+#define MEMP_MEM_INIT			1
+#define MEM_LIBC_MALLOC			1
+
+#endif /* LWIP_LWIPOPTS_H */
-- 
2.30.2

