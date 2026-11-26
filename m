Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9642606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rCkbVlc4;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=amuZYQty
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 982D560A4B;
	Thu, 26 Nov 2026 12:24:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AUBstAyg2_RR; Thu, 26 Nov 2026 12:24:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A54EC608F5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695879;
	b=EWRmn571KUdpD/uzx7gu1befFec+UihtF5wOe2KXBMUAiMLBaJIiax6g3Pak6rQRi5H1
	 UJ/Q3aytDionefkGol7WThid6OwZZhssfMOrCIKkYLa23rOg9T1hYzvrNvb2FnT6CDIFM
	 b1Rql71CAkFv0kIKnSh26mfqc7Z0SBBInKFZRWQ7EYxC1ZcqUQmGFWqaUCHilPu0wi71+
	 34qgdPpbY0fP1aowQaKbBw0ZaTpoUtTXM8jAl8p5pmGZRdwNfkhRqK7pDZII/EZFXpHIL
	 EN99QySVZKMDsSgoxdsTZJSUvgZRNerZHX+8AU2xKrTzglRDxa1gw3OPX1p/rOAeJXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lHikqOdfYXNBUk5rlgxH+op7ZBEuTv90bEbEmR/2M0Y=;
	b=RO/xeIuGwwcLM1Hdey6hnZ3gPfmK4YLUVqS2a6RPJysZSKH2cJ4Ka97ww/dc/SPUqxKv
	 hUV3245qqyKAbrUnq8tK3aEeB3XNlXvIu7kv0oNLcPsa4APmqQ8InIa1ZB8EC/fEOchGz
	 nleaBhYMQo1IxpYhV5g+iDLeVYaADBdau+3BguUNfP63hr70vnWSMAyT1fkLBuIWOixDL
	 i3tTSp4xX6Nh1OyLLB8Qgv5K+GcGgmz11X0je4H6ALOtUXUQBsdzr7J2VBU3llmUpPmwJ
	 KglRGL8fRDoi7QKlgnEPe6tOU0cmMQ1sTkYwTI+UYOC9H3xAuSwGqA71NV2S9RWPzeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695879;
	bh=lHikqOdfYXNBUk5rlgxH+op7ZBEuTv90bEbEmR/2M0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rCkbVlc40c8pXM+AEL1cvga9yix9Z5EaTcM3dc12u4XarFegSNvb+IhaYk1nWEjfM
	 wSw8oSOyfPNY1eZtk4WNzT5vuFkDOPOHvqcYfW80R0ne1Ldt8GnLI8a3yaDmc9kKvv
	 YwMB4C3nu3dk1FQ45PRgj3rjPomrc6bqDg2crOfDfCXaq05yzfRmWhuyShF2AXv85V
	 2b9j3jD31LH2oN0mKh9raMdmXhnomaESUzo/2wKXZPGp44fqHjQKvLhD17O40HLa+D
	 Ttb2TBXbdumZyoTc2Qs3zlwH7JWQojwa7UMdgeoe66Tb+8M1mUomi/7EKAhFizRTQY
	 KsBVMWttas8cQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A54EC608F5;
	Thu, 26 Nov 2026 12:24:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EE96371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F5608111E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8CsgGWq-WWrz for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:24:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71D3D8110F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=amuZYQty
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71D3D8110F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lHikqOdfYXNBUk5rlgxH+op7ZBEuTv90bEbEmR/2M0Y=; b=amuZYQtykWrmuAxCx/pUZ4/hQS
 Ebxy1vqAnHmuotaFfwMgtyC5vQMxnGO3nINWtsa04OYoYSacBgpNcuRWyvP5Mf3V+9nO1ARFQkXzI
 wBrRwIFF9VLUDr5Pu8wMr/WYnF9++M2Ks4UOvCMpZ2jJR+9bjn2lm9xnpN9BioAoZBcb49VKq8gPI
 pyG3DrTSsFm+2polScESp0loJMW4QQiEmhNnwgMcWMZXkg0IK/rJXqbKxDRRDByDv7ri+AzB6tH/p
 YCpFQl6jbB0rAw+FgabEytbqm4EDa2Odd114PBGxAzjF23ACCikCSp53H0XmYSVNHs2f9jmFfv8I+
 nH1aGqHQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWf-000IBT-1Y; Thu, 26 Nov 2026 13:24:33 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWe-0003gJ-1G; Thu, 26 Nov 2026 13:24:33 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 3/7] power: domain: imx8m: update outdated Kconfig help text
Date: Thu, 26 Nov 2026 13:23:55 +0100
Message-ID: <23fe2cd1fbbddd0f91aa8956256df749673c190a.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
References: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The help text incorrectly stated that the driver manipulates power
domains via the ATF, which hasn't been the case for a long time.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 13a661ce04f..46c127ef05c 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -45,8 +45,7 @@ config IMX8M_POWER_DOMAIN
 	depends on POWER_DOMAIN && ARCH_IMX8M
 	select CLK
 	help
-	  Enable support for manipulating NXP i.MX8M on-SoC power domains via
-	  requests to the ATF.
+	  Enable support for manipulating NXP i.MX8M on-SoC power domains.
 
 config IMX8MP_HSIOMIX_BLKCTRL
 	bool "Enable i.MX8MP HSIOMIX domain driver"
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

