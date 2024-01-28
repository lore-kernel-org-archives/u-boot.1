Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8BBC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 15:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653E78803A;
	Sun, 28 Jan 2024 16:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="S13p+a1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D61087EE4; Sun, 28 Jan 2024 16:55:58 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E32587F3A
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 16:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TNGHX4MVfz9sjJ;
 Sun, 28 Jan 2024 16:55:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706457352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZyWbPd8JvpyN9b61KlCkhVFDCMcAALpJwezEuX6oEc=;
 b=S13p+a1H769Q0gLD/BbpBUn3nsl36YynYrILPVZZFmtGNsUpo/U0rY7FG6VtC2pG43bGVY
 Azu1l6WDPXxzNINcKBdSWbL5zI3mIttSWeC68MHjZi31jnb10I09Xh7Kt/0QCypATLDEdZ
 F6aOSrx6QgCgSSmGAegtpgFDy+xLwn8h2/SJkp8hp723qy35Z0GJPfBq3VjBy11obtigtD
 3j46tdjHzDFOou8omgl1memSBHXuf6fVID8DaDNN4iW2k4v5KWhimGh3Qwj5Wx2fImjHSy
 J8zFRcTdmVwI5gZem2kQczY06ybE10Yh/FgEqPCMfXlcrSgMQdv4MQn5P1xnqA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 07/11] mtd: spi: renesas: Add R8A779H0 V4M support
Date: Sun, 28 Jan 2024 16:52:05 +0100
Message-ID: <20240128155458.56712-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 860af8f57dbd1dbf26e
X-MBO-RS-META: d3pgm5kynzsn3gykuoq9nwh4pktibzhk
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

From: Hai Pham <hai.pham.ud@renesas.com>

Support RPC SPI on R8A779H0 V4M SoC.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
V2: - Move the patch after PRR ID patch to satisfy macro dependency
    - Add RB from Paul
---
 drivers/spi/renesas_rpc_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 51c37d72eb6..3eb14061c81 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -215,7 +215,8 @@ static u32 rpc_spi_get_strobe_delay(void)
 	if (cpu_type == RMOBILE_CPU_TYPE_R8A7796 && rmobile_get_cpu_rev_integer() == 1)
 		return RPC_PHYCNT_STRTIM(6);
 	else if (cpu_type == RMOBILE_CPU_TYPE_R8A779F0 ||
-		 cpu_type == RMOBILE_CPU_TYPE_R8A779G0)
+		 cpu_type == RMOBILE_CPU_TYPE_R8A779G0 ||
+		 cpu_type == RMOBILE_CPU_TYPE_R8A779H0)
 		return RPC_PHYCNT_STRTIM2(15);
 	else
 #endif
-- 
2.43.0

