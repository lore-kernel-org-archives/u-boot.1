Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D93606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UDyCb4LJ;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=mUMlP4iC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 081EA81138;
	Mon, 16 Nov 2026 17:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WUe6HB1xkoXL; Mon, 16 Nov 2026 17:36:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0132781140
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850587;
	b=j0wdMNO52vTdscrMI/WBflkWnpJGPINUZnPQ66o736DzTslWUPK280I+7Us/2MFVKBe5
	 otCzffeh817N/5UMcwQK4wnZILtBSo4HgwyD97GL/Quymkj7Mz1m5cnd9ri0xkFbCApCQ
	 WPjSTLhFgtptxkGXnTHOnODEgeChgKnYTRLmTNmks5sMS731DAHbmXDNdpMbNbLz34F4G
	 wq73YfsetADYkSZgFzkRYGdJTRdg5O74i7GCU7STVFWXiuiSjwYH5j1TY0QkANP/bvfUy
	 eO8w+ckf48U690g0EiyN3XjSOYjAfHMMF/wkTasj6K2HfnFWFsIref14dqjVtxFVyPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850587;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6+33pmDUGoTMPcX2vy59HBOHL8KozvEVE8GxxGjDlSo=;
	b=LuEZOLM9OLrKHtJ497rITVaVZs08pgWIr186mc4/d17Mkq3lXsr4Ms7D6/eLGhQ4ThlZ
	 OKpnljQf/cThjEKX7jtTq0hhFAgP422mIPC3SCg+Yb1TiAqq4plNoO1ZPhOG2byscFe/z
	 +iDaMfPDNiBMkLQcbqIS3xRFYQApBT1d1D4qtxRJQyFpds3Ttvh3JYohLglEcXSgcXtrO
	 CjFr9AjEpnt3J6qhsDiyBAOnPRW8TIklUlI6pNQLXm5YnE2KENPvzA655vNl4EqzgFLgY
	 V7GeRi+fNNS8LaVF+K2/djUwzE5rfWR3Q/KRIwbgZf5EQy7BxpcfqiysL31afKpQsyw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850587;
	bh=6+33pmDUGoTMPcX2vy59HBOHL8KozvEVE8GxxGjDlSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UDyCb4LJ3H5hQAlOycxIDpcBIGFXve5egpWcaggk51ENIMipYNVIqdVrHMAOrHbCc
	 uR5vpAV5RDf586ioOb2frsLT82qUJrCWki6wX3HhQ+GINqOWuGEfrAhQoEACdKO35L
	 b2pGgWukyFpnY14NjJ3VJooRc6mQ02zwSGhVTNhS8ULI4lOJCMR55GDqmnHg6K4OXA
	 7kvlQeehxCDAnNPfh0glsN0WW0BpKKOfcmf1aoaow3opwnSQhpXn34WepTCnQr7D0w
	 xYFI1rNmW/notiU/iBpY7EHRrdng6Ns4xvVzyN5wSegKDP3SJVbefx6pHwAQpL8k/k
	 uBNYuH0jLIDVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0132781140;
	Mon, 16 Nov 2026 17:36:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FD30176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7270A402D0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ny6cHNQ0N2eG for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C8B6C402CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=mUMlP4iC
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8B6C402CD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:03 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw4w4W2FzKr65;
 Mon, 16 Nov 2026 18:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+33pmDUGoTMPcX2vy59HBOHL8KozvEVE8GxxGjDlSo=;
 b=mUMlP4iCgSNIYViRP25q4wtCbqrs1Fd0M5iTmsgFINAIo0bn4W81dijIAwDhen7cJALzDY
 sPSXmDPKh+EJXw74jmM8W1Ur2USjzlMUGgHitWUwJDUn/4Yv9ixC5h2EAaMePB6/OxpQqz
 YWzFu9FK83/o/+UkLphWx70/SuXpAkxZ5i54ARfk0Zdx4kIT+hvZZu7U2YzNLZXUYuwAT4
 fTInpZW8jVfTlls+ohMpaKk1m85JsiYi0b3j3knKKqo9BhMoaW2+j6itvYMNB3BUTRxlo+
 9BrIrGIVZyojtxApqT85xqn4DEjyBChJjpgRheaMCikU8bLM5V6YqfIR9FyJAg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/20] clk: tegra: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:54 +0100
Message-ID: <20261116173546.3487841-15-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mwwcfwrnwjrk8xcqf7buh736abd4ubzy
X-MBO-RS-ID: c7776f060c7db52fd4d
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/tegra/tegra-car-clk.c | 2 +-
 drivers/clk/tegra/tegra186-clk.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index 880dd4f6ece..8789cb02171 100644
--- a/drivers/clk/tegra/tegra-car-clk.c
+++ b/drivers/clk/tegra/tegra-car-clk.c
@@ -100,7 +100,7 @@ static int tegra_car_clk_disable(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops tegra_car_clk_ops = {
+static const struct clk_ops tegra_car_clk_ops = {
 	.request = tegra_car_clk_request,
 	.get_rate = tegra_car_clk_get_rate,
 	.set_rate = tegra_car_clk_set_rate,
diff --git a/drivers/clk/tegra/tegra186-clk.c b/drivers/clk/tegra/tegra186-clk.c
index ec52326c3b3..34b75ad3c18 100644
--- a/drivers/clk/tegra/tegra186-clk.c
+++ b/drivers/clk/tegra/tegra186-clk.c
@@ -81,7 +81,7 @@ static int tegra186_clk_disable(struct clk *clk)
 	return tegra186_clk_en_dis(clk, CMD_CLK_DISABLE);
 }
 
-static struct clk_ops tegra186_clk_ops = {
+static const struct clk_ops tegra186_clk_ops = {
 	.get_rate = tegra186_clk_get_rate,
 	.set_rate = tegra186_clk_set_rate,
 	.enable = tegra186_clk_enable,
-- 
2.53.0

