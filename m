Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E791FC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EBE36065D;
	Mon, 27 Jul 2026 08:21:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GI61U9Jv2Q50; Mon, 27 Jul 2026 08:21:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C363560672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785140517;
	bh=KMmONBExDzLbLdww3+iwEXJ8WqO260AENtCUd6EUac4=;
	h=Subject:From:To:CC:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=avHqgD02lZKGRX5WgB56N4sJ0qby2ygsLhlf5pciI9l4EP9FwtSoYTxQ0wtOlthv/
	 INBPrJh+99oQN5w+Sk/mTyzyaCQTp/m+tXfTTovaibJfSqLGryKQ6XJaDZJFgenynH
	 Bz0sX1StTO1oarFBiV4d0Nc2KmNQZdN21dUGPwRxZG0fY5fJnOrnZi0Tcvsg3tohcJ
	 bG3g29GSxLKzQEHdvxLz1vXlAhQQtBEIdsoHSQE+XuB77EFO35NB1irPDGqDC3j5qk
	 gy3z4Acp/AFiO0WZZQFvshN6foeRBq1SpEYTeleUjVpyAMaJFJ/twFdGe55rD+UtFt
	 17Nj1oGFy3/hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C363560672;
	Mon, 27 Jul 2026 08:21:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7477A490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 605C56065D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wVt-9yndtX3p for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:21:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2CEC760648
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CEC760648
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CEC760648
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:21:54 +0000 (UTC)
X-UUID: 1b15db8a899211f18dc8c9802ae25ab1-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:88f0e9d3-a1ec-45b3-a4f3-8d5cba747874, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:8a735a6, CLOUDID:9b71431b-aedd-4a4f-a01a-460867678921,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|836|865|888|898,TC:-5,Content:
 0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1b15db8a899211f18dc8c9802ae25ab1-20260727
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1891763500; Mon, 27 Jul 2026 16:06:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Jul 2026 16:06:42 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Jul 2026 16:06:41 +0800
Message-ID: <faff08bae1662e53c7752ed6a25b658d9c6c3efd.camel@mediatek.com>
Subject: Re: [PATCH] net: lwip: handle chained pbufs in transmit path
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.u-boot-project.org>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jeffrey Yu <jeyu@issi.com>, Christoph Reiter <christoph.reiter@evk.biz>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Shiji Yang
 <yangshiji66@outlook.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Date: Mon, 27 Jul 2026 16:06:40 +0800
In-Reply-To: <20260727080217.18208-1-weijie.gao@mediatek.com>
References: <20260727080217.18208-1-weijie.gao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=KMmONBExDzLbLdww3+iwEXJ8WqO260AENtCUd6EUac4=; 
 b=UXP6bFK6RWDbFJ0s9rGaQ0yWJOSdQoS7TWJKsfiHcF7juTfkNU0bIg+4aVAgA3zZVUvkfA5+iLB9VXqOuH0+MHTi8CTn1a2ofyci+F+a14sqMdF6ZXLXnkmeXMyPrlMzp2QJUaAZqfdTeZ8S6gwcrkoTHm/uUQy9TqgXZS7KBUs=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=UXP6bFK6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 2026-07-27 at 16:02 +0800, Weijie Gao wrote:
> LwIP may pass a packet to the netif linkoutput callback as a chain
> of pbufs. In this case, p->len only describes the length of the
> first pbuf, while p->tot_len describes the length of the whole
> packet.
> 
> The current transmit path only sends the first pbuf. This can
> truncate packets whose headers have already been generated for the
> full packet length, resulting in malformed frames on the wire.
> For example, the IP header may record a larger total length than the
> actual Ethernet frame length.
> 
> Assemble chained pbufs into one aligned contiguous buffer before
> passing the packet to the Ethernet driver.
> 
> Fixes: 98ad145db61a (net: lwip: add DHCP support and dhcp commmand)
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  net/lwip/net-lwip.c | 45 ++++++++++++++++++++++++++++++++-----------
> --
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 

Sorry, I sent this patch by mistake. Please ignore it.

