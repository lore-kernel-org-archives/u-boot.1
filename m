Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8892ACDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F096086E5B;
	Thu, 12 Oct 2023 04:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DNVrOQNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BC286EDE; Thu, 12 Oct 2023 04:01:02 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350FD86EAA
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-773ac11de71so28034385a.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075816; x=1697680616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k++kXJDnsS42yMVXN9BxH9tuE8PxYf4XWR5puBPWCyw=;
 b=DNVrOQNOgae62m4MsD19U+ujJrOTx/K3OwwEgAYilPjn5zX9xnYgkGOVyTpbXx/0Yj
 xu542iBkcP5E7ou0astLHtyuoFK89WQGo5DEkaDrj3KpIGo3dVJTQzjbNZ2+szSVWlzw
 YFdzgzHiQCGrpyb7S8p0fipp5Szedw9nqbAdN3uR1jRYARum1MQmK5UCMf47xd26xNYY
 K4gmQhWRkvyPS2scF9d2awi2WbqzkxWC1FNInjQAb2eTbA+QfbM/GzM6ZXAK5B39pkVl
 BcUnvqSb413HHTA+O/DITzQxLWGepY+S6GwFaiB7pzX42uhM00Umi+3v75hfF/k3CCqS
 6P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075816; x=1697680616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k++kXJDnsS42yMVXN9BxH9tuE8PxYf4XWR5puBPWCyw=;
 b=bwriCsDp/w5fzjg43W34C8vRqjSGM++KSTHJQWYe9DSD75o+Mg8GIZih80k6TA46EQ
 zu/ugBGhCXCnqQxbJap1nalzDKzj4bYxpdseFtbn0zAIok9HQnsPEZZKkIw8BMeogh3I
 TYfv4PeSdjYvic9WjWg7pFR8+frsK12g7ZdfVCpAt+BdkK1PxbQCI3w1n1dtBaDQY8gz
 l2MDBZpg++NGXhMZkWh8YNKMbjR5QsY3VzNVIbFoQWZ/N8jBClQCErKT5THUL5gzfLLD
 GoEQS3aR5GMiPSL5TUAUAFyeraGN1c/wuWUiChJWdSSPKDvWKt9HQAON8WLbQSVF1+Rd
 UzZw==
X-Gm-Message-State: AOJu0YyZTqDxR02ZlSK32WUF56Nsz1zPDEBBwKIPVfGqvDGuEmVmwWCw
 II1JYkPq8zxax0Iw17LSn26PFVUkLI0JDQ==
X-Google-Smtp-Source: AGHT+IEHRZLMq5bRS0xJd56AExH71BYcaxGAt4hfwns3NcgMjSkRlbnq0ZHxw3Q8csR4dFGgEvcmZA==
X-Received: by 2002:a05:620a:1377:b0:76f:93e:4b30 with SMTP id
 d23-20020a05620a137700b0076f093e4b30mr22262509qkl.67.1697075816435; 
 Wed, 11 Oct 2023 18:56:56 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 b27-20020a05620a127b00b0077568327b54sm5627891qkl.123.2023.10.11.18.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:56 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 24/26] test: spl: Add a test for the NET load method
Date: Wed, 11 Oct 2023 21:56:24 -0400
Message-Id: <20231012015626.3487451-25-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

Add a test for loading U-Boot over TFTP. As with other sandbox net
routines, we need to initialize our packets manually since things like
net_set_ether and net_set_udp_header always use "our" addresses. We use
BOOTP instead of DHCP, since DHCP has a tag/length-based format which is
harder to parse. Our TFTP implementation doesn't define as many constants
as I'd like, so I create some here. Note that the TFTP block size is
one-based, but offsets are zero-based.

In order to avoid address errors, we need to set up/define some additional
address information settings. dram_init_banksize would be a good candidate
for settig up bi_dram, but it gets called too late in board_init_r.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/sandbox/cpu/spl.c           |   3 +
 arch/sandbox/include/asm/spl.h   |   1 +
 configs/sandbox_noinst_defconfig |   6 +-
 test/image/Kconfig               |   9 ++
 test/image/Makefile              |   1 +
 test/image/spl_load_net.c        | 252 +++++++++++++++++++++++++++++++
 6 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 test/image/spl_load_net.c

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 09e3d10d6a5..8153df18d68 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -126,6 +126,9 @@ void spl_board_init(void)
 {
 	struct sandbox_state *state = state_get_current();
 
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = get_effective_memsize();
+
 	if (state->run_unittests) {
 		struct unit_test *tests = UNIT_TEST_ALL_START();
 		const int count = UNIT_TEST_ALL_COUNT();
diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
index 2f8b5fcfcfe..ab9475567e0 100644
--- a/arch/sandbox/include/asm/spl.h
+++ b/arch/sandbox/include/asm/spl.h
@@ -12,6 +12,7 @@ enum {
 	BOOT_DEVICE_MMC2_2,
 	BOOT_DEVICE_BOARD,
 	BOOT_DEVICE_VBE,
+	BOOT_DEVICE_CPGMAC,
 };
 
 /**
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 4f16d9860d2..57cbadedb7d 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -12,7 +12,7 @@ CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL=y
 CONFIG_SPL_FS_FAT=y
-CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_SANDBOX_SPL=y
 CONFIG_DEBUG_UART=y
@@ -44,9 +44,11 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x0
 CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_NET=y
 CONFIG_SPL_RTC=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
@@ -109,6 +111,8 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="uImage"
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
diff --git a/test/image/Kconfig b/test/image/Kconfig
index e6be1b829f3..99c50787816 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -23,6 +23,15 @@ config SPL_UT_LOAD_FS
 	help
 	  Test filesystems and the various load methods which use them.
 
+config SPL_UT_LOAD_NET
+	bool "Test loading over TFTP"
+	depends on SANDBOX && SPL_OF_REAL
+	depends on SPL_ETH
+	depends on USE_BOOTFILE
+	default y
+	help
+	  Test loading images over TFTP using the NET image load method.
+
 config SPL_UT_LOAD_OS
 	bool "Test loading from the host OS"
 	depends on SANDBOX && SPL_LOAD_FIT
diff --git a/test/image/Makefile b/test/image/Makefile
index 9427e69bd3b..ddbc39bf959 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -4,4 +4,5 @@
 
 obj-$(CONFIG_SPL_UT_LOAD) += spl_load.o
 obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
+obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
 obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
diff --git a/test/image/spl_load_net.c b/test/image/spl_load_net.c
new file mode 100644
index 00000000000..f570cef163f
--- /dev/null
+++ b/test/image/spl_load_net.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <asm/eth.h>
+#include <test/ut.h>
+#include "../../net/bootp.h"
+
+/*
+ * sandbox_eth_bootp_req_to_reply()
+ *
+ * Check if a BOOTP request was sent. If so, inject a reply
+ *
+ * returns 0 if injected, -EAGAIN if not
+ */
+static int sandbox_eth_bootp_req_to_reply(struct udevice *dev, void *packet,
+					  unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ethernet_hdr *eth = packet;
+	struct ip_udp_hdr *ip;
+	struct bootp_hdr *bp;
+	struct ethernet_hdr *eth_recv;
+	struct ip_udp_hdr *ipr;
+	struct bootp_hdr *bpr;
+
+	if (ntohs(eth->et_protlen) != PROT_IP)
+		return -EAGAIN;
+
+	ip = packet + ETHER_HDR_SIZE;
+	if (ip->ip_p != IPPROTO_UDP)
+		return -EAGAIN;
+
+	if (ntohs(ip->udp_dst) != PORT_BOOTPS)
+		return -EAGAIN;
+
+	bp = (void *)ip + IP_UDP_HDR_SIZE;
+	if (bp->bp_op != OP_BOOTREQUEST)
+		return -EAGAIN;
+
+	/* Don't allow the buffer to overrun */
+	if (priv->recv_packets >= PKTBUFSRX)
+		return 0;
+
+	/* reply to the request */
+	eth_recv = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memcpy(eth_recv, packet, len);
+	ipr = (void *)eth_recv + ETHER_HDR_SIZE;
+	bpr = (void *)ipr + IP_UDP_HDR_SIZE;
+	memcpy(eth_recv->et_dest, eth->et_src, ARP_HLEN);
+	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	ipr->ip_sum = 0;
+	ipr->ip_off = 0;
+	net_write_ip(&ipr->ip_dst, net_ip);
+	net_write_ip(&ipr->ip_src, priv->fake_host_ipaddr);
+	ipr->ip_sum = compute_ip_checksum(ipr, IP_HDR_SIZE);
+	ipr->udp_src = ip->udp_dst;
+	ipr->udp_dst = ip->udp_src;
+
+	bpr->bp_op = OP_BOOTREPLY;
+	net_write_ip(&bpr->bp_yiaddr, net_ip);
+	net_write_ip(&bpr->bp_siaddr, priv->fake_host_ipaddr);
+	copy_filename(bpr->bp_file, CONFIG_BOOTFILE, sizeof(CONFIG_BOOTFILE));
+	memset(&bpr->bp_vend, 0, sizeof(bpr->bp_vend));
+
+	priv->recv_packet_length[priv->recv_packets] = len;
+	++priv->recv_packets;
+
+	return 0;
+}
+
+struct spl_test_net_priv {
+	struct unit_test_state *uts;
+	void *img;
+	size_t img_size;
+	u16 port;
+};
+
+/* Well known TFTP port # */
+#define TFTP_PORT	69
+/* Transaction ID, chosen at random */
+#define	TFTP_TID	21313
+
+/*
+ *	TFTP operations.
+ */
+#define TFTP_RRQ	1
+#define TFTP_DATA	3
+#define TFTP_ACK	4
+
+/* default TFTP block size */
+#define TFTP_BLOCK_SIZE		512
+
+struct tftp_hdr {
+	u16 opcode;
+	u16 block;
+};
+
+#define TFTP_HDR_SIZE sizeof(struct tftp_hdr)
+
+/*
+ * sandbox_eth_tftp_req_to_reply()
+ *
+ * Check if a TFTP request was sent. If so, inject a reply. We don't support
+ * options, and we don't check for rollover, so we are limited files of less
+ * than 32M.
+ *
+ * returns 0 if injected, -EAGAIN if not
+ */
+static int sandbox_eth_tftp_req_to_reply(struct udevice *dev, void *packet,
+					 unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct spl_test_net_priv *test_priv = priv->priv;
+	struct ethernet_hdr *eth = packet;
+	struct ip_udp_hdr *ip;
+	struct tftp_hdr *tftp;
+	struct ethernet_hdr *eth_recv;
+	struct ip_udp_hdr *ipr;
+	struct tftp_hdr *tftpr;
+	size_t size;
+	u16 block;
+
+	if (ntohs(eth->et_protlen) != PROT_IP)
+		return -EAGAIN;
+
+	ip = packet + ETHER_HDR_SIZE;
+	if (ip->ip_p != IPPROTO_UDP)
+		return -EAGAIN;
+
+	if (ntohs(ip->udp_dst) == TFTP_PORT) {
+		tftp = (void *)ip + IP_UDP_HDR_SIZE;
+		if (htons(tftp->opcode) != TFTP_RRQ)
+			return -EAGAIN;
+
+		block = 0;
+	} else if (ntohs(ip->udp_dst) == TFTP_TID) {
+		tftp = (void *)ip + IP_UDP_HDR_SIZE;
+		if (htons(tftp->opcode) != TFTP_ACK)
+			return -EAGAIN;
+
+		block = htons(tftp->block);
+	} else {
+		return -EAGAIN;
+	}
+
+	if (block * TFTP_BLOCK_SIZE > test_priv->img_size)
+		return 0;
+
+	size = min(test_priv->img_size - block * TFTP_BLOCK_SIZE,
+		   (size_t)TFTP_BLOCK_SIZE);
+
+	/* Don't allow the buffer to overrun */
+	if (priv->recv_packets >= PKTBUFSRX)
+		return 0;
+
+	/* reply to the request */
+	eth_recv = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memcpy(eth_recv->et_dest, eth->et_src, ARP_HLEN);
+	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth_recv->et_protlen = htons(PROT_IP);
+
+	ipr = (void *)eth_recv + ETHER_HDR_SIZE;
+	ipr->ip_hl_v = 0x45;
+	ipr->ip_len = htons(IP_UDP_HDR_SIZE + TFTP_HDR_SIZE + size);
+	ipr->ip_off = htons(IP_FLAGS_DFRAG);
+	ipr->ip_ttl = 255;
+	ipr->ip_p = IPPROTO_UDP;
+	ipr->ip_sum = 0;
+	net_copy_ip(&ipr->ip_dst, &ip->ip_src);
+	net_copy_ip(&ipr->ip_src, &ip->ip_dst);
+	ipr->ip_sum = compute_ip_checksum(ipr, IP_HDR_SIZE);
+
+	ipr->udp_src = htons(TFTP_TID);
+	ipr->udp_dst = ip->udp_src;
+	ipr->udp_len = htons(UDP_HDR_SIZE + TFTP_HDR_SIZE + size);
+	ipr->udp_xsum = 0;
+
+	tftpr = (void *)ipr + IP_UDP_HDR_SIZE;
+	tftpr->opcode = htons(TFTP_DATA);
+	tftpr->block = htons(block + 1);
+	memcpy((void *)tftpr + TFTP_HDR_SIZE,
+	       test_priv->img + block * TFTP_BLOCK_SIZE, size);
+
+	priv->recv_packet_length[priv->recv_packets] =
+		ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + TFTP_HDR_SIZE + size;
+	++priv->recv_packets;
+
+	return 0;
+}
+
+static int spl_net_handler(struct udevice *dev, void *packet,
+			   unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	int old_packets = priv->recv_packets;
+
+	priv->fake_host_ipaddr = string_to_ip("1.1.2.4");
+	net_ip = string_to_ip("1.1.2.2");
+
+	sandbox_eth_arp_req_to_reply(dev, packet, len);
+	sandbox_eth_bootp_req_to_reply(dev, packet, len);
+	sandbox_eth_tftp_req_to_reply(dev, packet, len);
+
+	if (old_packets == priv->recv_packets)
+		return 0;
+
+	return 0;
+}
+
+static int spl_test_net_write_image(struct unit_test_state *uts, void *img,
+				    size_t img_size)
+{
+	struct spl_test_net_priv *test_priv = malloc(sizeof(*test_priv));
+
+	ut_assertnonnull(test_priv);
+	test_priv->uts = uts;
+	test_priv->img = img;
+	test_priv->img_size = img_size;
+
+	sandbox_eth_set_tx_handler(0, spl_net_handler);
+	sandbox_eth_set_priv(0, test_priv);
+	return 0;
+}
+
+static int spl_test_net(struct unit_test_state *uts, const char *test_name,
+			enum spl_test_image type)
+{
+	struct eth_sandbox_priv *priv;
+	struct udevice *dev;
+	int ret;
+
+	net_server_ip = string_to_ip("1.1.2.4");
+	ret = do_spl_test_load(uts, test_name, type,
+			       SPL_LOAD_IMAGE_GET(0, BOOT_DEVICE_CPGMAC,
+						  spl_net_load_image_cpgmac),
+			       spl_test_net_write_image);
+
+	sandbox_eth_set_tx_handler(0, NULL);
+	ut_assertok(uclass_get_device(UCLASS_ETH, 0, &dev));
+	priv = dev_get_priv(dev);
+	free(priv->priv);
+	return ret;
+}
+SPL_IMG_TEST(spl_test_net, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_net, FIT_INTERNAL, DM_FLAGS);
+SPL_IMG_TEST(spl_test_net, FIT_EXTERNAL, DM_FLAGS);
-- 
2.37.1

