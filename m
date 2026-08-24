Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE17C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E596B80C97;
	Mon, 24 Aug 2026 13:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5R02j7CfcRS; Mon, 24 Aug 2026 13:42:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787578966;
	bh=G4KSnHQTY6cBYFh5VaOI9vtidA48zPu0c1CFYq81KkE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mKRoC5sqPzGqcEw9rjz7FJxLlyy75H8kWD5hPvLTHVGVO2xfcs+ioqr3yMDaL4xz5
	 aqKocIL+KMb1Su/oM5SOgaRYpvELwE+fPQ7g1NdoHdwOzF+8JW7NLuqxlN1QpruFAA
	 xOqfUXENECSpst88fivXT746/V/JHhozxfQqLXJw9ubRg08jSlwzFniemLnfmluBuR
	 RBmrKvBMVoGHpuKKLViDSooxAnsw7hXjf5jVMoqs/duDFK8APm9DySAteW4exEa6ap
	 uJO39tXK29UXnMUnu/V+wenPmcwUMurJ4aBeMEXb4mH0qH4vl7CMaLMNNsRT+kqK4C
	 85PAOuDdopsEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A7B80BE2;
	Mon, 24 Aug 2026 13:42:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AADB92FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90E7160618
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUZkvxaPikGX for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:42:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=r3XjeK8X
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63F7A60614
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 144E4B00573;
 Mon, 24 Aug 2026 15:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1787578960;
 bh=ogLtXam8cit8TqDOPE8IOpUD6aYf28fbsNGGIfV7bzg=;
 h=From:To:Cc:Subject:Date:From;
 b=r3XjeK8XCAumXyFVe7lKDZBQHVjQZs3upwxgJeKlBI9m/Vsxb2xP35Y3r5U8QTYMU
 5GR9kU96AqIGuwdRKLiBMdtlppoutA7E/R4pkLQx8opKfwH9T3qq7PBv/bc3EIRzTZ
 2zwlYwhw5RiuE6W75qFvm85UwMVpHWyDHtNC/YXqqqDTbVtxMoQCrjW6NFc5hrmNZW
 K+YTHmIR68Hjbjkh2/y+8opuBRd8XiGHuTbWI2TM4E4Xergnxb0U7WcuVj4dUz4q/r
 v3fcfe7nkXZ3kQUfKGvLgKSZoRLr6+Z+/LeFLLh3CLhtAtLRZ0ZHTqShpYgHW/DSQB
 z8/vA2Rr3sZQw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1] spi: fsl_dspi: match the Layerscape DSPI compatibles
Date: Mon, 24 Aug 2026 15:42:28 +0200
Message-ID: <20260824134229.2709937-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The driver matched only fsl,vf610-dspi and fsl,ls1021a-v1.0-dspi. The
Linux device trees under dts/upstream describe the Layerscape
DSPI as "fsl,lx2160a-dspi", "fsl,ls2085a-dspi" instead, without vf610
fallback, so any board built against those trees leaves all three DSPI
controllers unbound.

On LX2160A, dspi0, dspi1 and dspi2 were having
 "no driver matches".

There is no code path changes, only the match table.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/spi/fsl_dspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index 412993ad377..ee86010afa5 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -657,6 +657,8 @@ static const struct dm_spi_ops fsl_dspi_ops = {
 static const struct udevice_id fsl_dspi_ids[] = {
 	{ .compatible = "fsl,vf610-dspi" },
 	{ .compatible = "fsl,ls1021a-v1.0-dspi" },
+	{ .compatible = "fsl,ls2085a-dspi" },
+	{ .compatible = "fsl,lx2160a-dspi" },
 	{ }
 };
 
---
base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
branch: for-upstream/spi-fsl-dspi-compatibles-v1

-- 
2.43.0

