Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE681C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E243F82063;
	Thu,  3 Apr 2025 14:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Y9rS+eQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D8C81FC0; Thu,  3 Apr 2025 09:39:22 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A49681F6B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 09:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54DEA4436E;
 Thu,  3 Apr 2025 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743665959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2gFL2X6tUhuxG4xER+FHDo2R+8J2mfbVZhTaowjxRI=;
 b=Y9rS+eQpsaV0gVpFlw8uiqeyWguWEwbSM2hqQQC5Z/hATG6Pl79mGEOuiye3QxfD42WbYe
 wa1/ptBC+4fpzhgDQLbW6BggZ+1C0p6qhwC2bJGNyR/IFOIrZM9fHt2wy/3bbguM18bbbC
 ihM/tUOWXNDpXsoL80aQnFxnh3eXM6TGdlFyAtFhIz4IR3rKOvzJyy/4NSliGPvMoxr12o
 C+brcmMRjW3UWl+B3QTjy0AooljHBuuvj/9QEqU7GuJsnP4wUB5hCKhIcho9Ii+fJMOIPv
 obv3+9uKGG18Cx4zMG+jIkGGGhIrNU7RM21LzieSFM42b5dDmUgcIuljqvDWvQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 03 Apr 2025 09:39:01 +0200
Subject: [PATCH v6 01/12] core: ofnode_graph: Fix a comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-ge-mainline-display-support-v6-1-478b5e3dd872@bootlin.com>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
In-Reply-To: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledvrddukeegrdduuddtrdduleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleelpdhhvghloheplgduledvrdduieekrddurddutdeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehsvggrnhhgrgdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopegrghhushhtseguvghng
 idruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtoheptghlrghmohhrleehsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 03 Apr 2025 14:36:19 +0200
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

Naming between the parameter list, the prototype and the main comment do
not match. Fix the comment which seems the be the one that is incorrect.

Fixes: 9057077cf4e1 ("core: ofnode: add of_graph parsing helpers")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/core/ofnode_graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/ofnode_graph.c b/drivers/core/ofnode_graph.c
index 90c92af3258ce73209e19c0d0ee6a8f35ef4e26a..175ac7687710f23245345346a8694ebdaf161c7a 100644
--- a/drivers/core/ofnode_graph.c
+++ b/drivers/core/ofnode_graph.c
@@ -98,7 +98,7 @@ ofnode ofnode_graph_get_port_by_id(ofnode parent, u32 id)
  * @id: id for the endpoint
  *
  * Return: ofnode in given endpoint or ofnode_null() if not found.
- * reg and port_reg are ignored when they are -1.
+ * reg_id and id are ignored when they are -1.
  */
 ofnode ofnode_graph_get_endpoint_by_regs(ofnode parent, int reg_id, int id)
 {

-- 
2.48.1

