Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D939FC61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0565080C63;
	Tue,  1 Sep 2026 09:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eziu_zkBC87c; Tue,  1 Sep 2026 09:13:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788253995;
	bh=5eIZs9wRWWeYmiWi3GiQxXyCCJZESbIkkJUNR72fWCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AVLbq+Cv+YWfSZPLmMn1dgmpgiSKrmSlRV8Ad/H2Itxnz3xR4eGb5IRSPH042SKd1
	 c45BNlWlkN89Kp8JWi9h8+DaeWdJ/xb2l5T/bi3H5sU5/tGYznhtc9XLkmmTw9Bioz
	 n7J4EqfPiQkOrcw+R1/jblPdy9nY1RRXFQh1rPkZAB5YB/4VeDUkDJxix8hNRhAUJI
	 TTngBUpU81tu51jkYlHKy71HTFDsg3ex3uTsac6I1eDVRWUIV1MT5zsfisClDU4iNw
	 M4tZVmbftxdLJ6t+2MAIzJH1P776wLAsN98mwfP7cxICJNFKyZ63NrmnctG7K20YTs
	 srz4LX1vurGWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2469280C55;
	Tue,  1 Sep 2026 09:13:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 17B0AE45
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE12C406C6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KlVh4D23Fm5D for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=LrNoEZ5x
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67F7B406CC
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E078741778;
 Tue,  1 Sep 2026 09:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342651F000E9;
 Tue,  1 Sep 2026 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253990;
 bh=5eIZs9wRWWeYmiWi3GiQxXyCCJZESbIkkJUNR72fWCM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LrNoEZ5x66szmH7DGWecqdP/EeBdh7H8a4kX68xDL/+KkTCKOCNvg4sMUhDCSKfUp
 q7ISZbVz4ABuZXlaI5hoiTFTyBaz4TTHXIwyz8PYwFDntfU5HT6Rtjqet/wWhluu7a
 uAX+JPrcysL2KtKcgtSb7WuDLn6QoQqLhC4ay/FOh3JRTxg3EAxqCPEhOu1SlQItKE
 oFMXHwPnygIigQAcbqJZ3YqhiXrz0gUmUBPN1tT7ioCxsGxeo3zWdxZPRmWTJD12SV
 Lx/e7HFGoTTw7MgQ9xzNZLvxff3WrTnJa5znQ+VfNHeDXMMHtk70vqq8pFGxLb/QNm
 2KWROwj/jmZuA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:01 +0200
Subject: [PATCH v7 03/13] mmc: arm_pl180: Gate idle card clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-3-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

The MMC core uses mmc->clk_disable to request that the card clock is
stopped, but the PL180 driver leaves SDI_CLKCR_CLKEN unchanged. This can
leave inactive hosts driving their card clocks.

Honor clk_disable when programming the clock control register.

Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index af21b814641e..28eb367f2e0a 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -294,6 +294,10 @@ static int  host_set_ios(struct mmc *dev)
 	u32 sdi_clkcr;
 
 	sdi_clkcr = readl(&host->base->clock);
+	if (dev->clk_disable)
+		sdi_clkcr &= ~SDI_CLKCR_CLKEN;
+	else
+		sdi_clkcr |= SDI_CLKCR_CLKEN;
 
 	/* Ramp up the clock rate */
 	if (dev->clock) {

-- 
2.55.0

