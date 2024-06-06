Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80283C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1AEC881A1;
	Thu,  6 Jun 2024 17:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O4vvZ6XD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242BC87AD2; Thu,  6 Jun 2024 17:51:21 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA2087F5C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2bfff08fc29so974342a91.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717689077; x=1718293877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2qbbs4MMbkxSyUXqFdaA4l0Hp/HBdXxW45yOTjrrEaI=;
 b=O4vvZ6XDuyh7WAwcdu5fkWxCUtUiEnyerBqyfQfJhDFqXuOS8dvZUS/9kUuM65+BsJ
 D7wrVXlOTQ9lZJiJPXihT7P7paoDZbbHGwfHKewAMDU1UZ5g+LqWMXiEa/qEE0Mm38pS
 80dw0kptgPPl4N4/MQ8BYlEfzr746C34oI4jSXpaZYNjKSR+ffj3pnvr8ih3xrAZoxeQ
 FRYuqF7aN7NOH3uON+cXBFHSf6D4O5ODfUhQO1pP4DYDGnifowhgeOyE4qJ+xztNp1TN
 g1CIFvSbwN359WjdizJCrvokQaeImMH9ToVb7KFusCilqxn6M1fPpMWw+rXg10OJvjXY
 MA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717689077; x=1718293877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2qbbs4MMbkxSyUXqFdaA4l0Hp/HBdXxW45yOTjrrEaI=;
 b=rvH/TV1TgACga0d2grbCx9i5knBqkJVWrMcneEP1AVee9e2+gbQ3O0N0aVyEEka5yB
 hu8h6i4oPyTM8TKMepotXOBS85s0oz1Su5kCvzNiEv/0X8g4zXfhf+0nQ7kFk12mBYyE
 KD5DAVilMbFcM9/EgwKqB6vqNo/2o3xFrnpI1fVW7gESznfGd08fZgHA0UJ6KsW5P810
 +RoZYlth7pVi0i71giZFFFc342TFE6WkyIEnO0mKndOgx/f18o8D+SWyDxAJDnEFcNm/
 Q8nhr6STgJN2QHqL4x/kHTAagzOkP1tcb0pgW3bIoAzzpepdnX6smpFYFgOT780WDE9O
 rZ5Q==
X-Gm-Message-State: AOJu0YwXbjF9L5xzHFtzsq4d350v71fyd/HkFdkB3RIvHEG8wDYy4AMQ
 FOn5WNhV5dJqygExOKGlrtcvVwBtyvgs9xr8LpUYdaHyoK4TmeBH3/vG+fzYC6DZWi2jD2kbEx3
 FiAllr0UMwVrguv/xsCNr1O6klEUwGSDDJvWvUQ==
X-Google-Smtp-Source: AGHT+IGSBFhReJSO5x7BSZ/Y+ENHSvcLvT2sl/BZaWIlmsWhEO4sqqGUk/z98T1HLVaZLdFzfTq591rBGgUgttUjOAk=
X-Received: by 2002:a17:90a:ac05:b0:2b3:28df:96b1 with SMTP id
 98e67ed59e1d1-2c27dafea7bmr5820341a91.7.1717689076764; Thu, 06 Jun 2024
 08:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <834de4823c6d6cde1416c21e31999efdabdac19c.1717680809.git.jerome.forissier@linaro.org>
In-Reply-To: <834de4823c6d6cde1416c21e31999efdabdac19c.1717680809.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Jun 2024 18:50:40 +0300
Message-ID: <CAC_iWj+avjZ206Kmjf0U076NLfB+FfzsEhZWo=CqyZH61uF+7w@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] net-lwip: build lwIP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 6 Jun 2024 at 16:36, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Build the lwIP library when NET_LWIP is enabled. The following files
> are adaptation layers written specially for U-Boot:
>
>  lib/lwip/u-boot/arch/cc.h
>  lib/lwip/u-boot/arch/sys_arch.h (empty)
>  lib/lwip/u-boot/limits.h (empty)
>  lib/lwip/u-boot/lwipopts.h
>
> They were initially contributed by Maxim in a previous RFC patch series.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
> Cc: Maxim Uvarov <muvarov@gmail.com>
> ---
>  lib/Makefile                    |   2 +
>  lib/lwip/Makefile               |  57 +++++++++
>  lib/lwip/u-boot/arch/cc.h       |  43 +++++++
>  lib/lwip/u-boot/arch/sys_arch.h |   0
>  lib/lwip/u-boot/limits.h        |   0
>  lib/lwip/u-boot/lwipopts.h      | 197 ++++++++++++++++++++++++++++++++
>  6 files changed, 299 insertions(+)
>  create mode 100644 lib/lwip/Makefile
>  create mode 100644 lib/lwip/u-boot/arch/cc.h
>  create mode 100644 lib/lwip/u-boot/arch/sys_arch.h
>  create mode 100644 lib/lwip/u-boot/limits.h
>  create mode 100644 lib/lwip/u-boot/lwipopts.h
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 2a76acf100d..c35786a0576 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -94,6 +94,8 @@ obj-$(CONFIG_LIBAVB) += libavb/
>  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += libfdt/
>  obj-$(CONFIG_$(SPL_TPL_)OF_REAL) += fdtdec_common.o fdtdec.o
>
> +obj-$(CONFIG_NET_LWIP) += lwip/
> +
>  ifdef CONFIG_SPL_BUILD
>  obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
>  obj-$(CONFIG_$(SPL_TPL_)HASH) += crc16-ccitt.o
> diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
> new file mode 100644
> index 00000000000..158e59b91fc
> --- /dev/null
> +++ b/lib/lwip/Makefile
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2024 Linaro Ltd.
> +
> +ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
> +
> +obj-y += \
> +       lwip/src/api/api_lib.o \
> +       lwip/src/api/api_msg.o \
> +       lwip/src/api/err.o \
> +       lwip/src/api/if_api.o \
> +       lwip/src/api/netbuf.o \
> +       lwip/src/api/netdb.o \
> +       lwip/src/api/netifapi.o \
> +       lwip/src/api/sockets.o \
> +       lwip/src/api/tcpip.o \
> +       lwip/src/apps/http/http_client.o \
> +       lwip/src/apps/tftp/tftp.o \
> +       lwip/src/core/altcp_alloc.o \
> +       lwip/src/core/altcp.o \
> +       lwip/src/core/altcp_tcp.o \
> +       lwip/src/core/def.o \
> +       lwip/src/core/dns.o \
> +       lwip/src/core/inet_chksum.o \
> +       lwip/src/core/init.o \
> +       lwip/src/core/ip.o \
> +       lwip/src/core/ipv4/acd.o \
> +       lwip/src/core/ipv4/autoip.o \
> +       lwip/src/core/ipv4/dhcp.o \
> +       lwip/src/core/ipv4/etharp.o \
> +       lwip/src/core/ipv4/icmp.o \
> +       lwip/src/core/ipv4/igmp.o \
> +       lwip/src/core/ipv4/ip4_addr.o \
> +       lwip/src/core/ipv4/ip4.o \
> +       lwip/src/core/ipv4/ip4_frag.o \
> +       lwip/src/core/ipv6/dhcp6.o \
> +       lwip/src/core/ipv6/ethip6.o \
> +       lwip/src/core/ipv6/icmp6.o \
> +       lwip/src/core/ipv6/inet6.o \
> +       lwip/src/core/ipv6/ip6_addr.o \
> +       lwip/src/core/ipv6/ip6.o \
> +       lwip/src/core/ipv6/ip6_frag.o \
> +       lwip/src/core/ipv6/mld6.o \
> +       lwip/src/core/ipv6/nd6.o \
> +       lwip/src/core/mem.o \
> +       lwip/src/core/memp.o \
> +       lwip/src/core/netif.o \
> +       lwip/src/core/pbuf.o \
> +       lwip/src/core/raw.o \
> +       lwip/src/core/stats.o \
> +       lwip/src/core/sys.o \
> +       lwip/src/core/tcp.o \
> +       lwip/src/core/tcp_in.o \
> +       lwip/src/core/tcp_out.o \
> +       lwip/src/core/timeouts.o \
> +       lwip/src/core/udp.o \
> +       lwip/src/netif/ethernet.o
> diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
> new file mode 100644
> index 00000000000..31c036dc0c5
> --- /dev/null
> +++ b/lib/lwip/u-boot/arch/cc.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2023 Linaro Ltd. <maxim.uvarov@linaro.org> */
> +
> +#ifndef LWIP_ARCH_CC_H
> +#define LWIP_ARCH_CC_H
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <vsprintf.h>
> +#include <rand.h>
> +
> +#define LWIP_ERRNO_INCLUDE <errno.h>
> +
> +#define LWIP_ERRNO_STDINCLUDE  1
> +#define LWIP_NO_UNISTD_H 1
> +#define LWIP_TIMEVAL_PRIVATE 1
> +
> +#ifdef CONFIG_LIB_RAND
> +#define LWIP_RAND() ((u32_t)rand())
> +#endif
> +
> +/* different handling for unit test, normally not needed */
> +#ifdef LWIP_NOASSERT_ON_ERROR
> +#define LWIP_ERROR(message, expression, handler) do { if (!(expression)) { \
> +                                               handler; }} while (0)
> +#endif
> +
> +#define LWIP_DONT_PROVIDE_BYTEORDER_FUNCTIONS
> +
> +#define LWIP_PLATFORM_ASSERT(x) do {printf("Assertion \"%s\" failed at line %d in %s\n", \
> +                                   x, __LINE__, __FILE__); } while (0)
> +
> +#define atoi(str) (int)dectoul(str, NULL)
> +#define lwip_strnstr(a, b)  strnstr(a, b)
> +
> +#define LWIP_ERR_T int
> +#define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))
> +
> +#if defined(CONFIG_SYS_BIG_ENDIAN)
> +#define BYTE_ORDER BIG_ENDIAN
> +#endif
> +
> +#endif /* LWIP_ARCH_CC_H */
> diff --git a/lib/lwip/u-boot/arch/sys_arch.h b/lib/lwip/u-boot/arch/sys_arch.h
> new file mode 100644
> index 00000000000..e69de29bb2d
> diff --git a/lib/lwip/u-boot/limits.h b/lib/lwip/u-boot/limits.h
> new file mode 100644
> index 00000000000..e69de29bb2d
> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
> new file mode 100644
> index 00000000000..aac0a6259fd
> --- /dev/null
> +++ b/lib/lwip/u-boot/lwipopts.h
> @@ -0,0 +1,197 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +/* Copyright (C) 2023 Linaro Ltd. <maxim.uvarov@linaro.org> */
> +
> +#ifndef LWIP_UBOOT_LWIPOPTS_H
> +#define LWIP_UBOOT_LWIPOPTS_H
> +
> +#if defined(CONFIG_LWIP_DEBUG)
> +#define LWIP_DEBUG 1
> +#define LWIP_DBG_MIN_LEVEL              LWIP_DBG_LEVEL_ALL
> +#define LWIP_DBG_TYPES_ON               LWIP_DBG_ON
> +#define ETHARP_DEBUG                    LWIP_DBG_ON
> +#define NETIF_DEBUG                     LWIP_DBG_ON
> +#define PBUF_DEBUG                      LWIP_DBG_OFF
> +#define API_LIB_DEBUG                   LWIP_DBG_ON
> +#define API_MSG_DEBUG                   LWIP_DBG_OFF
> +#define SOCKETS_DEBUG                   LWIP_DBG_OFF
> +#define ICMP_DEBUG                      LWIP_DBG_OFF
> +#define IGMP_DEBUG                      LWIP_DBG_OFF
> +#define INET_DEBUG                      LWIP_DBG_OFF
> +#define IP_DEBUG                        LWIP_DBG_ON
> +#define IP_REASS_DEBUG                  LWIP_DBG_OFF
> +#define RAW_DEBUG                       LWIP_DBG_OFF
> +#define MEM_DEBUG                       LWIP_DBG_OFF
> +#define MEMP_DEBUG                      LWIP_DBG_OFF
> +#define SYS_DEBUG                       LWIP_DBG_OFF
> +#define TIMERS_DEBUG                    LWIP_DBG_ON
> +#define TCP_DEBUG                       LWIP_DBG_OFF
> +#define TCP_INPUT_DEBUG                 LWIP_DBG_OFF
> +#define TCP_FR_DEBUG                    LWIP_DBG_OFF
> +#define TCP_RTO_DEBUG                   LWIP_DBG_OFF
> +#define TCP_CWND_DEBUG                  LWIP_DBG_OFF
> +#define TCP_WND_DEBUG                   LWIP_DBG_OFF
> +#define TCP_OUTPUT_DEBUG                LWIP_DBG_OFF
> +#define TCP_RST_DEBUG                   LWIP_DBG_OFF
> +#define TCP_QLEN_DEBUG                  LWIP_DBG_OFF
> +#define UDP_DEBUG                       LWIP_DBG_OFF
> +#define TCPIP_DEBUG                     LWIP_DBG_OFF
> +#define SLIP_DEBUG                      LWIP_DBG_OFF
> +#define DHCP_DEBUG                      LWIP_DBG_ON
> +#define AUTOIP_DEBUG                    LWIP_DBG_ON
> +#define DNS_DEBUG                       LWIP_DBG_ON
> +#define IP6_DEBUG                       LWIP_DBG_OFF
> +#define DHCP6_DEBUG                     LWIP_DBG_OFF
> +#else
> +#define LWIP_DBG_MIN_LEVEL              LWIP_DBG_LEVEL_ALL
> +#define LWIP_DBG_TYPES_ON               LWIP_DBG_OFF
> +#define ETHARP_DEBUG                    LWIP_DBG_OFF
> +#define NETIF_DEBUG                     LWIP_DBG_OFF
> +#define PBUF_DEBUG                      LWIP_DBG_OFF
> +#define API_LIB_DEBUG                   LWIP_DBG_OFF
> +#define API_MSG_DEBUG                   LWIP_DBG_OFF
> +#define SOCKETS_DEBUG                   LWIP_DBG_OFF
> +#define ICMP_DEBUG                      LWIP_DBG_OFF
> +#define IGMP_DEBUG                      LWIP_DBG_OFF
> +#define INET_DEBUG                      LWIP_DBG_OFF
> +#define IP_DEBUG                        LWIP_DBG_OFF
> +#define IP_REASS_DEBUG                  LWIP_DBG_OFF
> +#define RAW_DEBUG                       LWIP_DBG_OFF
> +#define MEM_DEBUG                       LWIP_DBG_OFF
> +#define MEMP_DEBUG                      LWIP_DBG_OFF
> +#define SYS_DEBUG                       LWIP_DBG_OFF
> +#define TIMERS_DEBUG                    LWIP_DBG_OFF
> +#define TCP_DEBUG                       LWIP_DBG_OFF
> +#define TCP_INPUT_DEBUG                 LWIP_DBG_OFF
> +#define TCP_FR_DEBUG                    LWIP_DBG_OFF
> +#define TCP_RTO_DEBUG                   LWIP_DBG_OFF
> +#define TCP_CWND_DEBUG                  LWIP_DBG_OFF
> +#define TCP_WND_DEBUG                   LWIP_DBG_OFF
> +#define TCP_OUTPUT_DEBUG                LWIP_DBG_OFF
> +#define TCP_RST_DEBUG                   LWIP_DBG_OFF
> +#define TCP_QLEN_DEBUG                  LWIP_DBG_OFF
> +#define UDP_DEBUG                       LWIP_DBG_OFF
> +#define TCPIP_DEBUG                     LWIP_DBG_OFF
> +#define SLIP_DEBUG                      LWIP_DBG_OFF
> +#define DHCP_DEBUG                      LWIP_DBG_OFF
> +#define AUTOIP_DEBUG                    LWIP_DBG_OFF
> +#define DNS_DEBUG                       LWIP_DBG_OFF
> +#define IP6_DEBUG                       LWIP_DBG_OFF
> +#define DHCP6_DEBUG                     LWIP_DBG_OFF
> +#endif
> +#define LWIP_TESTMODE                   0
> +
> +#if !defined(CONFIG_LWIP_ASSERT)
> +#define LWIP_NOASSERT 1
> +#define LWIP_ASSERT(message, assertion)
> +#endif
> +
> +#include "lwip/debug.h"
> +
> +#define SYS_LIGHTWEIGHT_PROT            0
> +#define NO_SYS                          1
> +
> +#define LWIP_IPV4                      1
> +#define LWIP_IPV6                      0
> +
> +#define MEM_ALIGNMENT                   1
> +#define MEM_SIZE                        1600
> +
> +#define MEMP_NUM_PBUF                   4
> +#define MEMP_NUM_RAW_PCB                2
> +#define MEMP_NUM_UDP_PCB                4
> +#define MEMP_NUM_TCP_PCB                2
> +#define MEMP_NUM_TCP_PCB_LISTEN         2
> +#define MEMP_NUM_TCP_SEG                16
> +#define MEMP_NUM_REASSDATA              1
> +#define MEMP_NUM_ARP_QUEUE              2
> +#define MEMP_NUM_SYS_TIMEOUT            4
> +#define MEMP_NUM_NETBUF                 2
> +#define MEMP_NUM_NETCONN               32
> +#define MEMP_NUM_TCPIP_MSG_API          8
> +#define MEMP_NUM_TCPIP_MSG_INPKT        8
> +#define PBUF_POOL_SIZE                  8
> +
> +#define LWIP_ARP                        1
> +#define ARP_TABLE_SIZE                  1
> +#define ARP_QUEUEING                    0
> +
> +#define IP_FORWARD                      0
> +#define IP_OPTIONS_ALLOWED              1
> +#define IP_REASSEMBLY                   0
> +#define IP_FRAG                         0
> +#define IP_REASS_MAXAGE                 3
> +#define IP_REASS_MAX_PBUFS              4
> +#define IP_FRAG_USES_STATIC_BUF         0
> +
> +#define IP_DEFAULT_TTL                  255
> +
> +#define LWIP_ICMP                       0
> +
> +#if defined(CONFIG_PROT_RAW_LWIP)
> +#define LWIP_RAW                        1
> +#else
> +#define LWIP_RAW                       0
> +#endif
> +
> +#if defined(CONFIG_PROT_DHCP_LWIP)
> +#define LWIP_DHCP                       1
> +#define LWIP_DHCP_BOOTP_FILE           1
> +#else
> +#define LWIP_DHCP                      0
> +#endif
> +
> +#define LWIP_DHCP_DOES_ACD_CHECK       0
> +
> +#define LWIP_AUTOIP                     0
> +
> +#define LWIP_SNMP                       0
> +
> +#define LWIP_IGMP                       0
> +
> +#if defined(CONFIG_PROT_DNS_LWIP)
> +#define LWIP_DNS                        1
> +#define DNS_TABLE_SIZE                  1
> +#else
> +#define LWIP_DNS                        0
> +#endif
> +
> +#if defined(CONFIG_PROT_UDP_LWIP)
> +#define LWIP_UDP                        1
> +#else
> +#define LWIP_UDP                        0
> +#endif
> +
> +#if defined(CONFIG_PROT_TCP_LWIP)
> +#define LWIP_TCP                        1
> +#else
> +#define LWIP_TCP                        0
> +#endif
> +
> +#define LWIP_LISTEN_BACKLOG             0
> +
> +#define PBUF_LINK_HLEN                  14
> +#define PBUF_POOL_BUFSIZE               LWIP_MEM_ALIGN_SIZE(TCP_MSS + 40 + PBUF_LINK_HLEN)
> +
> +#define LWIP_HAVE_LOOPIF                0
> +
> +#define LWIP_NETCONN                    0
> +#define LWIP_DISABLE_MEMP_SANITY_CHECKS 1
> +
> +#define LWIP_SOCKET                     0
> +#define SO_REUSE                        0
> +
> +#define LWIP_STATS                      0
> +
> +#define PPP_SUPPORT                     0
> +
> +#define LWIP_TCPIP_CORE_LOCKING                0
> +
> +#define LWIP_NETIF_LOOPBACK            0
> +
> +/* use malloc instead of pool */
> +#define MEMP_MEM_MALLOC                 1
> +#define MEMP_MEM_INIT                  1
> +#define MEM_LIBC_MALLOC                        1
> +
> +#endif /* LWIP_UBOOT_LWIPOPTS_H */
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
