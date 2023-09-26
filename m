Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64F4E7D271
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D1686DE5;
	Tue, 26 Sep 2023 11:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HPw6FTkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB0486DE5; Tue, 26 Sep 2023 11:44:06 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB6986D65
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50444e756deso9635652e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721444; x=1696326244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNzzTO9A4gGM/m8/mh0dG+0DOn4j7ZyXt/4zJSA/HSg=;
 b=HPw6FTkPqT4lAYM/icHV8PkExL+QejNX+iUqLPM6BmfNfaPlpWYpKFwbwsvoE01xeK
 2W0QxWJO9IiZcT4+JHyl9Xxz6BgzJB7xEk3HJH4EJfzPWTnogXoNIWNvzYlyMxabaLv4
 gV53tQCjSK8rKdGIWC8zYiKSR+HeFs7kFKXQ6RjwGkacnRM+xOthuQDW3E4EeOUUmou+
 gK5QB2KYEPAfn2g25PX/EUFWiQg4mpczQQomTKwENMlwcUHrqCO8v9MIar904NwKWgwU
 G0pGQCFraPrmfGLEcpo0+kgnv4sUdrQB59UyGcMkyxx+dG2VlSLhy57m3fuluZ9JUiVZ
 uGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721444; x=1696326244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNzzTO9A4gGM/m8/mh0dG+0DOn4j7ZyXt/4zJSA/HSg=;
 b=crcfUoJfRbXsVzOcsy1mbeKf4KivvnM3TqFoWAUMXJPaTro4Bm3TR8+vt2fVE1I1AV
 pd1wV2EmvBgV+I4hdvN+yxteE/Ag+iEa+Fxs/Ia8Lj+VH5Tzfp65SYmmx3iYgDKxO/iw
 89xcCENhcWJtNNnh1aLRXz9nHNQwBuIgblsYq9PtoB0MC+2UQx+LTmQ6wwArdFIy3mhn
 v/+m3wEjFPNv+j+ORB0OC1AvJInAvkwUj6Mm8/CVxP4VJpuw5BM8jwhPgcy8cwGnQzTj
 IiyOB1iWqC05Ti+NuyaIBT69mRit9mAhT222H3uPpa0xq8GIWlIwztBNGoX2YA2sEVAU
 iyVA==
X-Gm-Message-State: AOJu0YxNPS4A5AoEPnDw0uAUvvEhQyh6QtymobTuRmYjTYWR8gASCIwl
 InQrBTXMb99eg+cr7KN48qXWysgfxgifYDxrOp337w==
X-Google-Smtp-Source: AGHT+IEub7INyMe9TG46fvGgUxLLo3ZZOrcMDrH6DsfrttSet3bhWaZrNBBfhLgG4FexMc72ZWTahg==
X-Received: by 2002:a05:6512:32cd:b0:502:9bb6:3aba with SMTP id
 f13-20020a05651232cd00b005029bb63abamr9476936lfg.14.1695721444015; 
 Tue, 26 Sep 2023 02:44:04 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:44:03 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 10/15] net/lwip: add lwIP configuration
Date: Tue, 26 Sep 2023 15:41:19 +0600
Message-Id: <20230926094124.7024-11-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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

