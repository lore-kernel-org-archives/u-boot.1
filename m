Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50175C52D6D
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7924988BD0;
	Fri,  2 Aug 2024 15:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n5C2NCTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 009EE88967; Fri,  2 Aug 2024 15:14:56 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E5F88B9B
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso53774145e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604493; x=1723209293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUWzBSAVHKF4s82MKtxUxULIejvzGZ21bN5UOMQIL6U=;
 b=n5C2NCTw1X8GcFwjQ6NSHBllUi17W+B3KfEwADasoUbEvxlICh3ofAlj4d9jWbji08
 2inS9UvmzKG67qugiaZTUzf4e6+dpowGrw1qF6yYI8Fl0YzatcgLk0jUkyFzGrl61mPO
 FV2ANqjJlBE5+ofcNjWEHp8oXgxBtLBvCu+DBw+0+dC5imDdxGBOBP0IFk/lXCq0tODu
 Og/8TGNil3x9G8s4utjwEJO3kiB9I7sRKTNKH0OGQ2bK3MmkqHEtM2G8ScTbCT2AnWOg
 +xCFwmhWSPNP3G4zTKnu1ZAqrCxSAV0F26UABWrIgSr+zyQoYTuaXIAUW/b5sHJvzqne
 DKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604493; x=1723209293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUWzBSAVHKF4s82MKtxUxULIejvzGZ21bN5UOMQIL6U=;
 b=CpOdSAZBd5C+Z8so9Dkxpfphl2ZZUfWfea3I4xvbTluWNVZ0mPFSBpwh0dMf+qGOJa
 AX+/Fw1x7MWWMkExMyaLLmI9mFfxTnqQCyuXqBrGyOp4rbGXxqZQzLXXcXNmG1e+yTK9
 u0J8875G5jT3+bosOEniNb7sURp3X73A0j/CJwIj+7qUd/KYMEehvWEo66fRniPaEf15
 luiiu2/vVQycmhpAcAqZOr5pYvZvvqgIJ8VVEozbhzCYZqC9yaTYl9QTrGuZxuR2dXBa
 UGHIHK5RoZ7gMRVoiRIMl57zXuAvkry7ny8dkF3PGlkhTB/DHk/RH5TAE3y2fC6Mamiq
 4ogQ==
X-Gm-Message-State: AOJu0Yyjv2uPv2O7SFpup9tWu7/zTYKhpXz8rSOS4uY8yyk/OPuK1cKd
 dLflYORYpEXXUR4TMo1ACGEHf3eSZW78mTQg1c3B1YVny29ky4ATz7VA1h6yZLn5YpaTGFH7nIY
 DjV+6F/8U
X-Google-Smtp-Source: AGHT+IHDZCB5wfEL3IB5qGEFrJfkRzAbJ5hljT59Y9xw3y38Y1NmacFQ12O+LMUGtYiFKRbpowufnw==
X-Received: by 2002:adf:e411:0:b0:367:8f29:f7ae with SMTP id
 ffacd0b85a97d-36bbc170f8bmr2409492f8f.49.1722604492852; 
 Fri, 02 Aug 2024 06:14:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:14:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 07/20] net-lwip: build lwIP
Date: Fri,  2 Aug 2024 15:13:54 +0200
Message-Id: <2f2cbe1bad0e3e93a8b97ce0fa1588e4f3449f76.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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

Build the lwIP library when NET_LWIP is enabled. The following files
are adaptation layers written specially for U-Boot:

 lib/lwip/u-boot/arch/cc.h
 lib/lwip/u-boot/arch/sys_arch.h (empty)
 lib/lwip/u-boot/limits.h (empty)
 lib/lwip/u-boot/lwipopts.h

They were initially contributed by Maxim in a previous RFC patch series.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
Cc: Maxim Uvarov <muvarov@gmail.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/Makefile                    |   2 +
 lib/lwip/Makefile               |  55 +++++++++++
 lib/lwip/u-boot/arch/cc.h       |  43 +++++++++
 lib/lwip/u-boot/arch/sys_arch.h |   0
 lib/lwip/u-boot/limits.h        |   0
 lib/lwip/u-boot/lwipopts.h      | 157 ++++++++++++++++++++++++++++++++
 6 files changed, 257 insertions(+)
 create mode 100644 lib/lwip/Makefile
 create mode 100644 lib/lwip/u-boot/arch/cc.h
 create mode 100644 lib/lwip/u-boot/arch/sys_arch.h
 create mode 100644 lib/lwip/u-boot/limits.h
 create mode 100644 lib/lwip/u-boot/lwipopts.h

diff --git a/lib/Makefile b/lib/Makefile
index e389ad014f8..7378d907258 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -96,6 +96,8 @@ obj-$(CONFIG_LIBAVB) += libavb/
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += libfdt/
 obj-$(CONFIG_$(SPL_TPL_)OF_REAL) += fdtdec_common.o fdtdec.o
 
+obj-$(CONFIG_NET_LWIP) += lwip/
+
 ifdef CONFIG_SPL_BUILD
 obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
 obj-$(CONFIG_$(SPL_TPL_)HASH) += crc16-ccitt.o
diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
new file mode 100644
index 00000000000..dfcd700ca47
--- /dev/null
+++ b/lib/lwip/Makefile
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Linaro Ltd.
+
+obj-y += \
+	lwip/src/api/api_lib.o \
+	lwip/src/api/api_msg.o \
+	lwip/src/api/err.o \
+	lwip/src/api/if_api.o \
+	lwip/src/api/netbuf.o \
+	lwip/src/api/netdb.o \
+	lwip/src/api/netifapi.o \
+	lwip/src/api/sockets.o \
+	lwip/src/api/tcpip.o \
+	lwip/src/apps/http/http_client.o \
+	lwip/src/apps/tftp/tftp.o \
+	lwip/src/core/altcp_alloc.o \
+	lwip/src/core/altcp.o \
+	lwip/src/core/altcp_tcp.o \
+	lwip/src/core/def.o \
+	lwip/src/core/dns.o \
+	lwip/src/core/inet_chksum.o \
+	lwip/src/core/init.o \
+	lwip/src/core/ip.o \
+	lwip/src/core/ipv4/acd.o \
+	lwip/src/core/ipv4/autoip.o \
+	lwip/src/core/ipv4/dhcp.o \
+	lwip/src/core/ipv4/etharp.o \
+	lwip/src/core/ipv4/icmp.o \
+	lwip/src/core/ipv4/igmp.o \
+	lwip/src/core/ipv4/ip4_addr.o \
+	lwip/src/core/ipv4/ip4.o \
+	lwip/src/core/ipv4/ip4_frag.o \
+	lwip/src/core/ipv6/dhcp6.o \
+	lwip/src/core/ipv6/ethip6.o \
+	lwip/src/core/ipv6/icmp6.o \
+	lwip/src/core/ipv6/inet6.o \
+	lwip/src/core/ipv6/ip6_addr.o \
+	lwip/src/core/ipv6/ip6.o \
+	lwip/src/core/ipv6/ip6_frag.o \
+	lwip/src/core/ipv6/mld6.o \
+	lwip/src/core/ipv6/nd6.o \
+	lwip/src/core/mem.o \
+	lwip/src/core/memp.o \
+	lwip/src/core/netif.o \
+	lwip/src/core/pbuf.o \
+	lwip/src/core/raw.o \
+	lwip/src/core/stats.o \
+	lwip/src/core/sys.o \
+	lwip/src/core/tcp.o \
+	lwip/src/core/tcp_in.o \
+	lwip/src/core/tcp_out.o \
+	lwip/src/core/timeouts.o \
+	lwip/src/core/udp.o \
+	lwip/src/netif/ethernet.o
diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
new file mode 100644
index 00000000000..c0d57236d7f
--- /dev/null
+++ b/lib/lwip/u-boot/arch/cc.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Linaro Ltd. <maxim.uvarov@linaro.org> */
+
+#ifndef LWIP_ARCH_CC_H
+#define LWIP_ARCH_CC_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <vsprintf.h>
+#include <rand.h>
+
+#define LWIP_ERRNO_INCLUDE <errno.h>
+
+#define LWIP_ERRNO_STDINCLUDE	1
+#define LWIP_NO_UNISTD_H 1
+#define LWIP_TIMEVAL_PRIVATE 1
+
+#ifdef CONFIG_LIB_RAND
+#define LWIP_RAND() ((u32_t)rand())
+#endif
+
+/* different handling for unit test, normally not needed */
+#ifdef LWIP_NOASSERT_ON_ERROR
+#define LWIP_ERROR(message, expression, handler) do { if (!(expression)) { \
+						handler; }} while (0)
+#endif
+
+#define LWIP_DONT_PROVIDE_BYTEORDER_FUNCTIONS
+
+#define LWIP_PLATFORM_ASSERT(x) do {printf("Assertion \"%s\" failed at line %d in %s\n", \
+				    x, __LINE__, __FILE__); } while (0)
+
+#define atoi(str) (int)dectoul(str, NULL)
+#define lwip_strnstr(a, b, c)  strstr(a, b)
+
+#define LWIP_ERR_T int
+#define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))
+
+#if defined(CONFIG_SYS_BIG_ENDIAN)
+#define BYTE_ORDER BIG_ENDIAN
+#endif
+
+#endif /* LWIP_ARCH_CC_H */
diff --git a/lib/lwip/u-boot/arch/sys_arch.h b/lib/lwip/u-boot/arch/sys_arch.h
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/lib/lwip/u-boot/limits.h b/lib/lwip/u-boot/limits.h
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
new file mode 100644
index 00000000000..54616c983d9
--- /dev/null
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* Copyright (C) 2023 Linaro Ltd. <maxim.uvarov@linaro.org> */
+
+#ifndef LWIP_UBOOT_LWIPOPTS_H
+#define LWIP_UBOOT_LWIPOPTS_H
+
+#if defined(CONFIG_LWIP_DEBUG)
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
+#endif
+
+#define LWIP_TESTMODE                   0
+
+#if !defined(CONFIG_LWIP_ASSERT)
+#define LWIP_NOASSERT 1
+#define LWIP_ASSERT(message, assertion)
+#endif
+
+#include "lwip/debug.h"
+
+#define SYS_LIGHTWEIGHT_PROT            0
+#define NO_SYS                          1
+
+#define LWIP_IPV4			1
+#define LWIP_IPV6			0
+
+#define MEM_ALIGNMENT                   1
+
+#define MEMP_NUM_TCP_SEG                16
+#define PBUF_POOL_SIZE                  8
+
+#define LWIP_ARP                        1
+#define ARP_TABLE_SIZE                  4
+#define ARP_QUEUEING                    1
+
+#define IP_FORWARD                      0
+#define IP_OPTIONS_ALLOWED              1
+#define IP_REASSEMBLY                   0
+#define IP_FRAG                         0
+#define IP_REASS_MAXAGE                 3
+#define IP_REASS_MAX_PBUFS              4
+#define IP_FRAG_USES_STATIC_BUF         0
+
+#define IP_DEFAULT_TTL                  255
+
+#define LWIP_ICMP                       0
+
+#if defined(CONFIG_PROT_RAW_LWIP)
+#define LWIP_RAW                        1
+#else
+#define LWIP_RAW			0
+#endif
+
+#if defined(CONFIG_PROT_DHCP_LWIP)
+#define LWIP_DHCP                       1
+#define LWIP_DHCP_BOOTP_FILE		1
+#else
+#define LWIP_DHCP			0
+#endif
+
+#define LWIP_DHCP_DOES_ACD_CHECK	0
+
+#define LWIP_AUTOIP                     0
+
+#define LWIP_SNMP                       0
+
+#define LWIP_IGMP                       0
+
+#if defined(CONFIG_PROT_DNS_LWIP)
+#define LWIP_DNS                        1
+#define DNS_TABLE_SIZE                  1
+#else
+#define LWIP_DNS                        0
+#endif
+
+#if defined(CONFIG_PROT_UDP_LWIP)
+#define LWIP_UDP                        1
+#else
+#define LWIP_UDP                        0
+#endif
+
+#if defined(CONFIG_PROT_TCP_LWIP)
+#define LWIP_TCP                        1
+#define TCP_MSS                         1460
+#define TCP_WND                         3000000
+#define LWIP_WND_SCALE                  1
+#define TCP_RCV_SCALE                   0x7
+#define TCP_SND_BUF                     (2 * TCP_MSS)
+#ifdef CONFIG_PROT_TCP_SACK_LWIP
+#define LWIP_TCP_SACK_OUT               1
+#endif
+#else
+#define LWIP_TCP                        0
+#endif
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
+#define LWIP_NETIF_LOOPBACK		0
+
+/* use malloc instead of pool */
+#define MEMP_MEM_MALLOC                 1
+#define MEMP_MEM_INIT			1
+#define MEM_LIBC_MALLOC			1
+
+#endif /* LWIP_UBOOT_LWIPOPTS_H */
-- 
2.40.1

