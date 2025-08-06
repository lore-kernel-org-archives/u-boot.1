Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7051DC87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 09:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F51183303;
	Wed,  6 Aug 2025 11:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QhnV3JgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B568398B; Wed,  6 Aug 2025 11:00:53 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBAB6832AD
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 11:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b78294a233so5368917f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754470816; x=1755075616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fr3XDpQZI1AlMkegohbdMzXV7NALhIiZ/stmCC0dtwo=;
 b=QhnV3JgPwKkzy7s0uQ5AsV8AdJKYEh6ha1etxC8eKCsVgachFyMjFJe8Ox4DTVg/fi
 j+Pk5f0RBEU99XZhtj/4fCFgv6M4a/hq29oM5EhbMRcPuo6wUCkKtPhtstjQ6KR8tCDN
 39XR6MnO72BuEXLVVxYbtW3HGZ+ZDR5D/sNM0Uaed+5Ue4wHH3Rph9nE9AsXeD5zHmZ0
 tDRNiJaglbGBEeBSZV9Z6VivTuRYUbvk8cWhErYD0rLr30LbzceBoxrNYmR56pbdN3G+
 U821axlAaWU07cOQ4BV3YbVY4JHiljaOiaAfiZsu7tgoYLk8ZnMwMFys6ybQpeZHUAbM
 8sIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754470816; x=1755075616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fr3XDpQZI1AlMkegohbdMzXV7NALhIiZ/stmCC0dtwo=;
 b=cLOeOtWKKdJcvUf9qYymqCD78Ar2x2G82vxAc0pPDqeSvRQpGvjJ+k/O+FgQXATnKy
 jk29gtYxhVpqfnIAZEkPZ/HfEeHVdn44dy+X+saPuPET+MwFKMjEF4bt8xnWmU/RxoBU
 mL+fGc4RdoK4LtnpoACtQ8iLfF2Kx3fjtzPGHZWWrBe26Mi7PLOMBoqG04b6g8KtA9wE
 oWFZd/Bjnz/u8UE4Ip704z1Ja3NQdipbIdE343FhvElngtwFrwKmm3xST+CHZwD2r9Cj
 yJAPrWDgwVSoqiQ4gkEVDmyee1bacSYmJZ6rleLYKY8nVNY8QaEAYqxr/00YqE+zU+Mo
 I1Ag==
X-Gm-Message-State: AOJu0YzSyldJKlzmv22u1vDfKmMr356q4epFtGGGxHQ9hDClSZ/N8CvQ
 e3yTurL6WQa2Sk5FK6b41mapC6TIv5Hq7dllIcf0g4KZDu5BPd0hD986LMeuCljkjmgOQADVcru
 fFTpYyPDDSw==
X-Gm-Gg: ASbGncsg/slm3f1t7wvhnTUM3MMdAZRzbFxCA1ODx47XYVOXZrb4fDtYGc3w5MUmfvr
 Hd+mFALDMc/Bt1Wk+41kJ1NsTryitcuAEAncz7sm7kxNwjSNqf92hG+O0MpUXkcoP+hpqZ8g62G
 Y6uBzFIDIKPlGVTozhMC8fjwE75T8arYYzkHIL/suOjL4eWYiAQafyVOFFCoMglRETbe7YN5hhe
 KHD7ASuBs/0yB+PcfL51re17GlXIsoqdYLfQpcMRbhUZlqdWcpRt7By3eY1hLQro3aVvaDhTJ8u
 ypg0pTUlNMZfYOhLbUcPT4JmHZToQ8rDrPyeHpnIArM3GEalIUEtY6RHZfdZf7+DjPioY2u0mDt
 r66ooUPT9Tiya7BsrCwETim5W2zfgq9HlUuJDiENc
X-Google-Smtp-Source: AGHT+IHxWbMi/1/hQyFynO6LdxZ9X8eLBO9whHNajtquSlMeLww7geeIARi5o6lzujejx+qLLb+e9A==
X-Received: by 2002:a05:6000:2211:b0:3a5:298a:3207 with SMTP id
 ffacd0b85a97d-3b8f41ae2d5mr1623850f8f.48.1754470815871; 
 Wed, 06 Aug 2025 02:00:15 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6be:a792:5d93:499f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0683045sm12686057f8f.41.2025.08.06.02.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 02:00:15 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] net: lwip: add Kconfig option to show ICMP unreachable
 errors
Date: Wed,  6 Aug 2025 10:58:14 +0200
Message-ID: <20250806085959.2130339-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806085959.2130339-1-jerome.forissier@linaro.org>
References: <20250806085959.2130339-1-jerome.forissier@linaro.org>
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

Add Kconfig symbol LWIP_ICMP_SHOW_UNREACH which, when enabled, prints a
message to the console upon reception of ICMP unreachable messages. For
example:

 $ make qemu_arm64_lwip_defconfig
 $ qemu-system-aarch64 -M virt -cpu max -nographic -bios u-boot.bin
 [...]
 => dhcp
 DHCP client bound to address 10.0.2.15 (0 ms)
 => tftp 192.168.0.100:69:Image
 Using virtio-net#32 device
 TFTP from server 192.168.0.100; our IP address is 10.0.2.15
 Filename 'Image'.
 Load address: 0x40200000
 Loading: ICMP destination unreachable (host unreachable) from 192.168.0.16
 Timeout!
 => tftp 192.168.0.16:69:Image
 Using virtio-net#32 device
 TFTP from server 192.168.0.16; our IP address is 10.0.2.15
 Filename 'Image'.
 Load address: 0x40200000
 Loading: ICMP destination unreachable (port unreachable) from 192.168.0.16
 Timeout!
 =>

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 lib/lwip/u-boot/arch/cc.h  |  7 +++++++
 lib/lwip/u-boot/lwipopts.h |  4 ++++
 net/lwip/Kconfig           | 13 +++++++++++++
 net/lwip/Makefile          |  1 +
 net/lwip/icmp_unreach.c    | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)
 create mode 100644 net/lwip/icmp_unreach.c

diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
index 04ab94d6b70..849c79c5a8d 100644
--- a/lib/lwip/u-boot/arch/cc.h
+++ b/lib/lwip/u-boot/arch/cc.h
@@ -56,4 +56,11 @@ static inline const char *sntp_format_time(time_t t)
 }
 
 #define sntp_format_time sntp_format_time
+
+#ifdef CONFIG_LWIP_ICMP_SHOW_UNREACH
+struct pbuf;
+void net_lwip_icmp_dest_unreach(int code, struct pbuf *p);
+
+#define ICMP_DEST_UNREACH_CB(_c, _p) net_lwip_icmp_dest_unreach(_c, _p)
+#endif
 #endif /* LWIP_ARCH_CC_H */
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 46af91f9410..80b93ea172d 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -80,7 +80,11 @@
 
 #define IP_DEFAULT_TTL                  255
 
+#if defined(CONFIG_PROT_ICMP_LWIP)
+#define LWIP_ICMP                       1
+#else
 #define LWIP_ICMP                       0
+#endif
 
 #if defined(CONFIG_PROT_RAW_LWIP)
 #define LWIP_RAW                        1
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
index d28a8a7df94..5789766fe62 100644
--- a/net/lwip/Kconfig
+++ b/net/lwip/Kconfig
@@ -4,6 +4,16 @@
 
 if NET_LWIP
 
+config LWIP_ICMP_SHOW_UNREACH
+	bool "Print ICMP Destination Unreachable messages"
+	default y
+	depends on CMD_TFTPBOOT || CMD_SNTP
+	select PROT_ICMP_LWIP
+	help
+	  Prints a message whenever an ICMP Destination Unreachable message is
+	  received while running a network command that sends requests via UDP.
+	  Enabling this can make troubleshooting easier.
+
 config LWIP_DEBUG
 	bool "Enable debug traces in the lwIP library"
 	help
@@ -31,6 +41,9 @@ config PROT_DNS_LWIP
 	bool
 	select PROT_UDP_LWIP
 
+config PROT_ICMP_LWIP
+	bool
+
 config PROT_RAW_LWIP
 	bool
 
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 97299d9b542..09c3b3511a4 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,6 +2,7 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_LWIP_ICMP_SHOW_UNREACH) += icmp_unreach.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 
diff --git a/net/lwip/icmp_unreach.c b/net/lwip/icmp_unreach.c
new file mode 100644
index 00000000000..9e8a05f5717
--- /dev/null
+++ b/net/lwip/icmp_unreach.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2025 Linaro Ltd. */
+
+#include <lwip/icmp.h>
+#include <lwip/ip4_addr.h>
+#include <lwip/pbuf.h>
+#include <lwip/prot/ip4.h>
+
+static const char *code_to_str(int code)
+{
+	switch (code) {
+	case ICMP_DUR_NET:
+		return "network unreachable";
+	case ICMP_DUR_HOST:
+		return "host unreachable";
+	case ICMP_DUR_PROTO:
+		return "protocol unreachable";
+	case ICMP_DUR_PORT:
+		return "port unreachable";
+	case ICMP_DUR_FRAG:
+		return "fragmentation needed and DF set";
+	case ICMP_DUR_SR:
+		return "source route failed";
+	default:
+		break;
+	}
+	return "unknown cause";
+}
+
+void net_lwip_icmp_dest_unreach(int code, struct pbuf *p)
+{
+	struct ip_hdr *iphdr = (struct ip_hdr *)p->payload;
+	ip4_addr_t src;
+
+	ip4_addr_copy(src, iphdr->src);
+	printf("ICMP destination unreachable (%s) from %s\n",
+	       code_to_str(code), ip4addr_ntoa(&src));
+}
-- 
2.43.0

