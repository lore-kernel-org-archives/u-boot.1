Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015EACA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 483ED8354B;
	Tue, 12 Aug 2025 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bef5fq1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB42183542; Tue, 12 Aug 2025 14:43:58 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBA1832DA
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so35007915e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755002636; x=1755607436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+paRYOEvn+mBKTImcPblDWeAHOnqrcNV2MJ4Wz+O1o=;
 b=bef5fq1U5kU4C9VbzIsHMqEortHGfvZccvuVMYb4Y7rKjHT3nkgoE8UuveMtguADFE
 pH5M2/5ukDykiNMWfQGUaoSGzlMgSeuzeTb++L3e0T8EHmJLkw6hwwY+UIXkR41SCGiZ
 Tv3oYNOlh5XJ00rZJTty7xN4dY5dxbYKIMy9q2/Ygsl/ICADZsZETwZ4qZ7b5gRaDbzS
 QdfWx4XYRIVf013nutc2TZWrzgZ/iWTzXwlbPFk6Jl7d/PUNtFkm2PvCOjH2S+aLeLrH
 LFkvwrg02GmSTMTmfzHulnqRKWlDNsKv09FwnK3H8Co4ylRx7xPY5wRYxpGsZ3clh0h5
 /keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755002636; x=1755607436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+paRYOEvn+mBKTImcPblDWeAHOnqrcNV2MJ4Wz+O1o=;
 b=GqkhuL2vVhBj6KYJMHStD1DEJNZz7se/d12Ksi5I07F4tP1f9wQdvW8o+MFkyJCiez
 FcVA2dSKtyswqqQx3xnyK++XLf7cVTcC0JPJYfcStPpBfBgrcXJjmKGvxdnTUZLbxE8K
 wbXIwX7Ez8dIi3VtSf1C17juqhF3xCtlbE53Rws4sl2qsU87XBLQjuOzvLwVHIhpF/hr
 16F0NHiCcbQkIHUGeNN3K1sq339wfO148e5qiKJe5GFTBKzVBjxGTwV/tM8NecxK5EEC
 a1l8fv/o5IGbKJDmMTwxQS08PrcS3kwZ+wHiW/cnMr+BKspqo32pBKEKzo8/dfRosxdm
 5btA==
X-Gm-Message-State: AOJu0YzSFOWUx6KdjeaOmvI7zGBr6qWhmseHCNbeswtiLhY1DutLf54I
 +5gghJQL9nXfczxd4yd16EpRGezBWQ8afP7J3BLCICdY9//Q3cpAZllkvFiiQ7rosYH5RU9KiaZ
 6kdwsGbT8Dg==
X-Gm-Gg: ASbGncuzBSKIMFUhe0osANizHxSNnrndI5RG96ATliZNsl3gjRkjSnWagFejm0Jxx0v
 xzQGmsEEbhPrJG3W1FDSZTFEmyFlkx9W8Jrh8Me71VzbDUJR7olkekeDmkatiPDGGc2mu3buLhI
 1aBzNRisn+O1YZFj9MD50FNipFYDQ6NiCj4X7w6ef7YM9d2Jb7joDX4mmsVS1dwUUEbExYS2osR
 V9duovWGniABmmU6qLHyHWj3L3MHpC0RdJwGpCLvsmXb+HsSUveF5ONFXwQLsHVECzcQdRs/NtH
 vczrIw5glEXJoin1y/AjdskBJhc1QSyKO32N8AxwYhUrn5E2mVUmKoRzppy9B5q72T10LbsldO/
 sbSyfQy1SOPEytGyts2zL8We4sCpO4ZTIxrG3EbvB+g==
X-Google-Smtp-Source: AGHT+IEyoSWRLYESsuw5xx4UDIt3gqDAzJuknVEh9TkjSWm7ip5Pn7cb8TBLFKLXvCbahawljlnB/w==
X-Received: by 2002:a05:600c:1ca3:b0:459:443e:b180 with SMTP id
 5b1f17b1804b1-45a10ba7b18mr31422675e9.8.1755002635630; 
 Tue, 12 Aug 2025 05:43:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6b34:4d0b:774a:130d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585430csm297745475e9.11.2025.08.12.05.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 05:43:54 -0700 (PDT)
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
Subject: [PATCH v2 2/2] net: lwip: add Kconfig option to show ICMP unreachable
 errors
Date: Tue, 12 Aug 2025 14:43:19 +0200
Message-ID: <20250812124331.1464879-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812124331.1464879-1-jerome.forissier@linaro.org>
References: <20250812124331.1464879-1-jerome.forissier@linaro.org>
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

Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/73.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- Add link to upstream pull request

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

