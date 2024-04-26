Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC43C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB0F8914A;
	Fri, 26 Apr 2024 10:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="gpeeLhGO";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ilnlbrDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 235F88915B; Fri, 26 Apr 2024 10:03:08 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B59D88EF8
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1714118583; x=1745654583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/JV6d2ir3FmMS2C8p9V/8pX87bdwS5QoIkkHOu736IM=;
 b=gpeeLhGOWCBgu1mViy8fLnpOvStH3R9lhGYq7zxxyY/o/Fw6Vhklb3i7
 5gIAwZB8LJLZTSvZTvN4b+JSpEf6CHEKitG4Ka4GI+Fc32oYohuYFHkBw
 iF4lSKmorsMqD/XYBN1ba9qBNqHL1ugPzRGUme89mHBcHrYQWerttOJ3K
 6ul8t6b9iW597PVfN7zmfTFmth8f01vCz7NlkIg3N0RM1yaU4VAfpajSp
 APNinEaZKVXWNTsBMz6rSpqgwWWFR2IaICLKL13qFYuUOOwu/jXsuLDME
 RtQaWSUaIvTCKgBhEYfPMhtsgGL/EQmZJZklUfaeU4WdDbIE4v1HO6egr A==;
X-IronPort-AV: E=Sophos;i="6.07,231,1708383600"; d="scan'208";a="36629249"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 26 Apr 2024 10:03:03 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5A92916FC9C; Fri, 26 Apr 2024 10:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1714118579;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/JV6d2ir3FmMS2C8p9V/8pX87bdwS5QoIkkHOu736IM=;
 b=ilnlbrDnf3gjylseeTnVgkuEfOhcu4WCYLp4cbYuih8kDcoI5HDNE7B/GjWKK8yLHTRBem
 ftAuDOJhUH3oSHpKBRn1pPQZOueH25yB59srpRZLlFR+fdnguzHWdF08cLglp8xcER2BWv
 Q1n8OqIgmoUkKAm2yB7OZeOAgdvbytlfPuml1k/jIoswHhihdk9FeV8S6Xs71HweH1shwV
 p0wbyBZFHasdbUeJUt8Ryb6qkDGaYZ4aZs8QDnddLZpnsf+pGBIvWUGYQK3nW4eBDqS1CV
 Iipag6bqM/4xsszJDGSoyRuBxOSGU5slGXNrm39WR6zwhT5igLkT2+QvT4yzcQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, MD Danish Anwar <danishanwar@ti.com>,
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Suman Anna <s-anna@ti.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 5/5] dma: ti: k3-udma: invalidate prepared buffers before
 pushing to recv ring
Date: Fri, 26 Apr 2024 10:02:28 +0200
Message-ID: <d3f36df0833702190ce902033a4c14d5d844d9b6.1714117337.git.matthias.schiffer@ew.tq-group.com>
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

Buffers must not have an unclean cache before being used for DMA - a
pending write-back may corrupt the next dev-to-mem transfer otherwise.

This was consistently noticeable during long TFTP transfers, when an ARP
request is answered by U-Boot in the middle of the transfer:

As U-Boot's arp_receive() reuses the receive buffer to prepare its
reply packet, the beginning of one of the next incoming TFTP packets
is overwritten by the ARP reply. The corrupted packet is ignored, but
the TFTP transfer stalls for a few seconds until a timeout is detected
and a retransmit is triggered.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/dma/ti/k3-udma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 4e6f7f570c5..8f6d396653e 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2678,6 +2678,9 @@ int udma_prepare_rcv_buf(struct dma *dma, void *dst, size_t size)
 	cppi5_hdesc_set_pktlen(desc_rx, size);
 	cppi5_hdesc_attach_buf(desc_rx, dma_dst, size, dma_dst, size);
 
+	invalidate_dcache_range((unsigned long)dma_dst,
+				(unsigned long)(dma_dst + size));
+
 	flush_dcache_range((unsigned long)desc_rx,
 			   ALIGN((unsigned long)desc_rx + uc->config.hdesc_size,
 				 ARCH_DMA_MINALIGN));
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

