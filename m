Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C170C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72E58914C;
	Fri, 26 Apr 2024 10:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="K63LGroz";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="SMKD7VlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA34B89147; Fri, 26 Apr 2024 10:02:52 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BA88913F
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1714118570; x=1745654570;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AjAmGJKCg0T8apAgPi1cyTjHf/YFG4vjrG59JJL2fdQ=;
 b=K63LGrozLOrztraDTZv2/LAmNX5C31m7Ku8GbImlvNBRAUZLXWPdD13N
 TDNmQ+0mbTwznDK1MXatri7n37/Iup9cMPecqur38VmFQutcqpr3OjvDm
 aGEiDDuvayv7LzRvp4NKDNnsfX5OMX3SWc2v4eP3INpmOuUnqPrEsovVK
 4/8BWzqG/apXP45m9g2557dDRDU4FArVKtnBPdmJvCPS2RuZmfUWPJaZv
 8eevf1GduYx7I7i0M/h1TH1ZppKnkbDql5rGJ9TvgHg4Z6rbV+IdMVWr1
 HGkln+1UtIL6xk5jZFxJzm9F4Od5EQNYqt4UeSaHbp1OkB/bHm8LoOSl9 g==;
X-IronPort-AV: E=Sophos;i="6.07,231,1708383600"; d="scan'208";a="36629238"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 26 Apr 2024 10:02:49 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D998416EB7C; Fri, 26 Apr 2024 10:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1714118566;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=AjAmGJKCg0T8apAgPi1cyTjHf/YFG4vjrG59JJL2fdQ=;
 b=SMKD7VlCGNtEc8AnWZcF9YGvnjOH05Ui6W84kFhNYoCXtAmhY+sPPeGr+Gor8KlR6K45Yw
 TG9pG94kwizaBbeLYhC86Ljc83iZutRwdjni/A3HpSkF1bRvBApeTqodBGZMlpkxXwEGWa
 No4HQ0oBZz3qDdBYMM1iAorFdP3QQY7X2u+SjrG4WrdhikDBjoMMD6J/Qlif2K0suQvZtf
 KBEqx1GSGLhgV9xIE9YS9ymy+NPd9eBuNdiL4B/FuIEfMixHVM17gjYTVLB9n/RQ/QRRlG
 Ew/vg+7hz6JAu2XHAYbDNJEnrBY9HVhts6y3Ub/fjHZTAu0OwcFaCBSBlC9ryA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, MD Danish Anwar <danishanwar@ti.com>,
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Suman Anna <s-anna@ti.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/5] net: ti: am65-cpsw-nuss: avoid errors due to imbalanced
 start()/stop()
Date: Fri, 26 Apr 2024 10:02:25 +0200
Message-ID: <5aa919346ec1039c0f3a25f07bf04d6274810702.1714117337.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
References: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The eth-uclass state machine doesn't prevent imbalanced start()/stop()
calls - to the contrary, it even provides eth_init_state_only() and
eth_halt_state_only() functions that change the state without any calls
into the driver. This means that the driver must be robust against
duplicate start() and stop() calls as well as send/recv calls while the
interface is down.

We decide not to print error messages but just to return an error in the
latter case, as trying to send packets on a disabled interface commonly
happens when the netconsole is still active after the Ethernet has been
halted during bootm.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/net/ti/am65-cpsw-nuss.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index b151e25d6a4..4a57e945a3a 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -328,6 +328,9 @@ static int am65_cpsw_start(struct udevice *dev)
 	struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
 	int ret, i;
 
+	if (common->started)
+		return 0;
+
 	ret = power_domain_on(&common->pwrdmn);
 	if (ret) {
 		dev_err(dev, "power_domain_on() failed %d\n", ret);
@@ -488,6 +491,9 @@ static int am65_cpsw_send(struct udevice *dev, void *packet, int length)
 	struct ti_udma_drv_packet_data packet_data;
 	int ret;
 
+	if (!common->started)
+		return -ENETDOWN;
+
 	packet_data.pkt_type = AM65_CPSW_CPPI_PKT_TYPE;
 	packet_data.dest_tag = priv->port_id;
 	ret = dma_send(&common->dma_tx, packet, length, &packet_data);
@@ -504,6 +510,9 @@ static int am65_cpsw_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct am65_cpsw_priv *priv = dev_get_priv(dev);
 	struct am65_cpsw_common	*common = priv->cpsw_common;
 
+	if (!common->started)
+		return -ENETDOWN;
+
 	/* try to receive a new packet */
 	return dma_receive(&common->dma_rx, (void **)packetp, NULL);
 }
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

