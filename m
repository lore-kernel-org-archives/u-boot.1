Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AC9C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 18:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1420288D96;
	Tue, 20 Aug 2024 20:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fFaShjyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC08F88D8B; Tue, 20 Aug 2024 17:47:04 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B104188A46
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 17:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Y.Varakala@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1724168818; x=1726760818;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=25hPZ2kC5RZWd6WfgUBI2Og4rTHW9RqZvWvN+Ul//vw=;
 b=fFaShjyinBmy/yRb//o5bcodWchz0kRgxyzCWfo0b2yO+Tp9sqzDfMU1SuA0cmqG
 tlQO859Y3ZFqdbTFRLCmI4ZTb9wxCeWruFKrhhL14qWSv/NREFBDjHfGpwF6NE1S
 csfW7AH/Pu5IhpbYneN5LaDnX+78rlV5oVFgbhof2Os=;
X-AuditID: ac14000a-03251700000021bc-71-66c4ba72b279
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id FD.20.08636.27AB4C66;
 Tue, 20 Aug 2024 17:46:58 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Aug
 2024 17:46:57 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <t.remmet@phytec.de>, <trini@konsulko.com>, <sbabic@denx.de>,
 <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH 0/2] Add and enable mcore support
Date: Tue, 20 Aug 2024 17:46:28 +0200
Message-ID: <20240820154630.78976-1-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWyRpKBV7do15E0g8vbeCweXvW3aD/lYzF1
 0mZ2i7d7O9ktut+pO7B6zJt1gsVj56y77B6vDqxi9zh7ZwejR393C2sAaxSXTUpqTmZZapG+
 XQJXxvK7M5kKrjFX/Jz9kamB8StTFyMnh4SAicTt/uvMXYxcHEICS5gkzvZ1MEE4TxklGg91
 MYNUsQnoS6xYt4gVxBYRiJDouHCEHcRmFvCT+HxjLhuILSxgKHHryD+wehYBVYmnLcvA4rwC
 lhI7++ewQ2yTl9h/8CwzRFxQ4uTMJywQc+QlmrfOZoawJSQOvngBZgsJKEq8f9gB1zvt3Gtm
 CDtUovPPfZYJjAKzkIyahWTULCSjFjAyr2IUys1Mzk4tyszWK8ioLElN1ktJ3cQICmQRBq4d
 jH1zPA4xMnEwHmKU4GBWEuHtfnkwTYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS
 1OzU1ILUIpgsEwenVAOj/jq2WxVTm47XCLHM5N3QZ73vX/unOy8nKrXWJ+1f4T71wWSrh1/O
 /kr30sr5Zs99mq/xN3PNy438IX9Ox3yR7l22emZEkM4SD3UOlR7L0/nXf4koH9Q8W3JPdpme
 2Ar2/6ujPvYff3Pr5rXP3Cz9p3ja8pN9P559vN1fdF287wGepy+jqveuVGIpzkg01GIuKk4E
 AEEOQ85SAgAA
X-Mailman-Approved-At: Tue, 20 Aug 2024 20:45:13 +0200
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

Added m7 core support in uboot for imx8mp by adding
the boot variable prepare_mcore and enabled bootaux in
defconfig.

Regards,
yashwanth.

Yashwanth Varakala (2):
  board: phytec: phycore_imx8mp: Add mcore support
  configs: phycore-imx8mp_defconfig: Enabled bootaux command

 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 5 +++--
 configs/phycore-imx8mp_defconfig               | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.34.1

