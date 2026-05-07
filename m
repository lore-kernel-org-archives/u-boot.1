Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4633CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 10:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A451584AC8;
	Thu,  7 May 2026 12:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="K/BsyrDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0831384A93; Thu,  7 May 2026 12:37:23 +0200 (CEST)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::bc0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C633B84AA2
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gB7ww3ppLzwMC;
 Thu,  7 May 2026 12:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778150240;
 bh=bHMezcfk/8hoAKeTxOnDmYEqlZXk48I8fLHIxmT6ONM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=K/BsyrDYm/P4PPIRm6N6DFnUgVjMfRQs7qZaa8G+pQAAwB7wHARXwJ+XJ800xiNME
 QwAGGrxvRHRyDzAduP8s5czETBdnHEpeBIbiXvQd8Kbv0KK07MtKw1mf4nTeF1KA2Z
 QBsCckjB0N/zC8VVXROS7JV/V6EUr6NfcyMobuKruGkBMJ39mXiFrSwO/4jv9Z8Yog
 xYgkFes+K7qM6sP+J0Feu7idj5OosbAeDzRFBQD6xE9p26+l30NmzI1bFrmS6haefP
 LVVYhMtvGfMTPLn0H550qxzXtUSB5Bfr9R3HIJd6Xy11El8Mf2d6GrK7Fr/HhJT3ZD
 12rgh+oxb27wA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gB7wv4Zn2zVrv; Thu,  7 May 2026 12:37:19 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 07 May 2026 12:37:11 +0200
Subject: [PATCH RFC next v2 4/5] net: guard SYS_RX_ETH_BUFFER with NET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-sys_rx_eth_buffer-no-net-v2-4-cd7ef934bf42@cherry.de>
References: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
In-Reply-To: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
To: u-boot@lists.denx.de
Cc: Tang Yuantian <andy.tang@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

SYS_RX_ETH_BUFFER represents the number of Ethernet receive packet
buffers. It therefore doesn't make sense it's reachable if NET isn't
enabled.

Direct users of SYS_RX_ETH_BUFFER are:
- drivers/net/rtl8169.c, only compiled if CONFIG_RTL8169=y, depends on
  CONFIG_NETDEVICES=y, depends on CONFIG_NET=y,
- drivers/net/fsl_enetc.h, via ENETC_BD_CNT, included in
    drivers/net/{fsl_enetc.c,fsl_enetc_mdio.c,mscc_eswitch/felix_switch.c}
  First two only compiled if CONFIG_FSL_ENETC=y, latter with
  CONFIG_MSCC_FELIX_SWITCH=y. Both symbols depends on
  CONFIG_NETDEVICES=y, depends on CONFIG_NET=y.
- include/net-common.h via PKTBUFSRX,

Indirect users via PKTBUFSRX:
- arch/sandbox/include/asm/eth.h
  - according to ./tools/qconfig.py -l -f CONFIG_SANDBOX CONFIG_NO_NET,
    all sandbox defconfigs have network enabled so ignore this for now,
- drivers/dma/ti/k3-udma.c
  - sets UDMA_RX_DESC_NUM to that if defined, else 4. PKTBUFSRX is
    CONFIG_SYS_RX_ETH_BUFFER which defaults to 4. According to
    ./tools/qconfig.py -l -f CONFIG_TI_K3_NAVSS_UDMA '~CONFIG_SYS_RX_ETH_BUFFER=4'
    no defconfig enabling this DMA driver sets CONFIG_SYS_RX_ETH_BUFFER
    to anything but the default of 4, so regardless of NET being built
    UDMA_RX_DESC_NUM will always be 4 with current defconfigs.
- drivers/net/{airoha_eth.c,bcm6348-eth.c,bcm6368-eth.c,cortina_ni.c,
	dc2114x.c,eepro100.c,essedma.c,ethoc.c,ftgmac100.c,ftmac100.c,
	hifemac.c,mcffec.c,mpc8xx_fec.c,pic32_eth.c,sandbox.c,sni_ave.c,
	sni_netsec.c,ti/am65-cpsw-nuss.c,ti/cpsw.c,ti/icssg_prueth.c,
	tsec.c} all depends on CONFIG_NETDEVICES=y, depends on
  CONFIG_NET=y,
- net/lwip/net-lwip.c, only compiled if CONFIG_NET_LWIP=y, depends on
  CONFIG_NET=y,
- net/{net.c,tcp.c}, only compiled if CONFIG_NET_LEGACY=y, depends on
  CONFIG_NET=y,
- net/net-common.c, only compiled if CONFIG_NET=y,
- test/cmd/wget.c, only compiled if CONFIG_NET_LEGACY=y, depends on
  CONFIG_NET=y,
- test/image/spl_load_net.c, only compiled if CONFIG_SPL_UT_LOAD_NET=y,
  depends on CONFIG_SPL_ETH=y, depends on CONFIG_SPL_NET=y, depends on
  CONFIG_NET_LEGACY=y, depends on CONFIG_NET=y,

Indirect users via net_rx_packets[PKTBUFSRX]. This array is only
externally defined in net/net-common.c which is only compiled if
CONFIG_NET=y.

Users of net_rx_packets are:
- drivers/net/{airoha_eth.c,bcm6348-eth.c,bcm6368-eth.c,cortina_ni.c,
	dc2114x.c,dm9000x.c,essedma.c,ethoc.c,fsl_enetc.c,ftgmac100.c,
	ftmac100.c,hifemac.c,ks8851_mll.c,macb.c,mcffec.c,mpc8xx_fec.c,
        mscc_eswitch/jr2_switch.c,mscc_eswitch/luton_switch.c,
        mscc_eswitch/ocelot_switch.c,mscc_eswitch/serval_switch.c,
        mscc_eswitch/servalt_switch.c,pic32_eth.c,sandbox-raw.c,
	sandbox.c,smc911x.c,sni_ave.c,sni_netsec.c,ti/am65-cpsw-nuss.c,
	ti/cpsw.c,ti/icssg_prueth.c,tsec.c,xilinx_axi_mrmac.c} all
	depends on CONFIG_NETDEVICES=y, depends on CONFIG_NET=y,
- drivers/usb/gadget/ether.c only built if CONFIG_$(PHASE_)USB_ETHER=y,
  depends on CONFIG_NET=y/CONFIG_SPL_NET=y,
- net/lwip/net-lwip.c only compiled if CONFIG_NET_LWIP=y, depends on
  CONFIG_NET=y,
- net/net.c, only compiled if CONFIG_NET_LEGACY=y, depends on
  CONFIG_NET=y,
- net/net-common.c, only compiled if CONFIG_NET=y,

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 include/net-common.h | 4 ++++
 net/Kconfig          | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 69b6316c1ec..0c260873c2c 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -20,7 +20,9 @@
  *	alignment in memory.
  *
  */
+#if CONFIG_IS_ENABLED(NET)
 #define PKTBUFSRX	CONFIG_SYS_RX_ETH_BUFFER
+#endif
 #define PKTALIGN	ARCH_DMA_MINALIGN
 
 /* IPv4 addresses are always 32 bits in size */
@@ -132,7 +134,9 @@ static inline void net_set_state(enum net_loop_state state)
 }
 
 extern int		net_restart_wrap;	/* Tried all network devices */
+#if CONFIG_IS_ENABLED(NET)
 extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
+#endif
 extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
 extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
 /* Indicates whether the pxe path prefix / config file was specified in dhcp option */
diff --git a/net/Kconfig b/net/Kconfig
index e712a0dd2ac..171a88f8ed2 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -279,8 +279,6 @@ config TFTP_BLOCKSIZE
 	  almost-MTU block sizes.
 	  You can also activate CONFIG_IP_DEFRAG to set a larger block.
 
-endif   # if NET
-
 config SYS_RX_ETH_BUFFER
         int "Number of receive packet buffers"
         default 4
@@ -289,3 +287,5 @@ config SYS_RX_ETH_BUFFER
           controllers it is recommended to set this value to 8 or even higher,
           since all buffers can be full shortly after enabling the interface on
           high Ethernet traffic.
+
+endif   # if NET

-- 
2.54.0

