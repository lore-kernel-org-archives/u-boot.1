Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87200CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 18:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47ABE847C4;
	Fri, 29 May 2026 20:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="j3ihVRtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D570846E6; Fri, 29 May 2026 18:39:09 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6FD846CA
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 18:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6C1E7C62461
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 16:39:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC117601FA;
 Fri, 29 May 2026 16:39:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CED3710888CCE; 
 Fri, 29 May 2026 18:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780072745; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HYxNqbnw89RiCTHKNVFNgiFXyG6RZiUxy9WII7eYaOM=;
 b=j3ihVRtw1aeCPm5PeIu74RL+JqmO9N3BGt2eZK9BRr01hTpO+VrYYJJ0Nu4qvJJ0ZP46ZI
 eCc1QEypUWviKNo7i8Y4Jy4YtMfyZENBrG+2NMXkexAL3qJx1dbt8g25jESeO4w7lw4RC6
 veR7PW1BNE+WpvSg8Pee1jkzolluq2ecwFXW0oOs1qnS7k/5QF4MwWJH7sk7WUjph0+zO5
 CDZSCsjAytS4X+Jj8p2rAKFgkNpgzPQ7sgoNahfIc5N85mj8w/uXZgI3KwKa36Y3aUy11G
 mSI/lQcJQ+NWt1z1bNQ27w+VVKjr6i+ts+UvKct8d3O24KsXYROo+othzKiClQ==
From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Date: Fri, 29 May 2026 18:38:59 +0200
Subject: [PATCH 3/5] mtd: rawnand: zynq: Make sure an of node is attached
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-dave-upstream-nand-fixes-v1-3-e5bbddb10676@bootlin.com>
References: <20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com>
In-Reply-To: <20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>, 
 "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 29 May 2026 20:42:29 +0200
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

If no ofnode is attached by the controller driver, DT parsing does not
happen.

Signed-off-by: Miquel Raynal (DAVE) <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/zynq_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 2d07b29ecabd..54c255630724 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -1103,6 +1103,11 @@ static int zynq_nand_probe(struct udevice *dev)
 		return dm_scan_fdt_dev(dev);
 	}
 
+	if (!ofnode_get_child_count(of_nand))
+		nand_set_flash_node(nand_chip, of_nand);
+	else
+		nand_set_flash_node(nand_chip, ofnode_first_subnode(of_nand));
+
 	if (ofnode_read_resource(of_nand, 0, &res)) {
 		printf("Failed to get nand resource\n");
 		return -ENODEV;

-- 
2.53.0

