Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760A606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AZZrTj/7;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=M84UzsY4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F6324092A;
	Thu, 26 Nov 2026 12:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 45ONDDrMqjfp; Thu, 26 Nov 2026 12:24:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3249D40938
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695883;
	b=qyheWaPo0GhoLVXz5k8NHhyrRbwBM5weMcVSJ8DEvP9thn4ZARoU/lv6mOAslR8xPcHw
	 neVJfmMJjnOJrkUJNefnekMsgaUfXNE2grrWQo9dytY//pP5lVcojiaei2Ej+MeRTQOZw
	 nAiAwV9jwih00tEv/lW75MU1wzZBE/b1dWe+CwhN5uVsrWFHZ+iy6yWWhuzH/0tW2Xi6R
	 BXZHu1mm1MoBm+GgoDG46euxpuvM1YVQ6pmsfyRnhTR4c8o5W+O/yQPPHKYgFPB+YEDRp
	 kVwI9CthapVQp4vY7EAS2e189D2MVI6FD9lt0NdrBgKCOCAtlJOlFevyHmtmWYNhqcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YwooDMQIoQBpwUB6i31XZWYVVaQ12vzwH6Cf4DCANO4=;
	b=aV3TxVqlNEappn9L1miTKNXDDIALUTQ89q0V6Ggfy32SEx4bjAvRiQdAY2uNlv5NaCZc
	 erSWtc9epQDsltEUqWyEupGfTRrKSAigoygNUpB7+K1cQCLoJKPOcNIdfTeC9OTXcjFQx
	 /w14DBtuvzfcR/vs0OfDTjwlQANXEyTbEFU0KksU9iwSzyAWiICCosujIFF5bcQm1w5bT
	 UQr+y9GDxOtbE7r6mRlJ1ALB/Wt3Nax/+KBPRBSIssasLfLsCE8T/R1QgrH/kQOL8h7VP
	 u/mMQxmGwvr+KcM8GllEg7mHcsB1xHH4E3UzX9CQgVU2V5Q+311zhJegJkm/0KdcIFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695883;
	bh=YwooDMQIoQBpwUB6i31XZWYVVaQ12vzwH6Cf4DCANO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AZZrTj/7V02GF2na8JYPOK3MvPyjnLs27HizN/vEw52BLLIjA98hhMSC3y0U3CDyo
	 3P1qWwys+Fp/tRm8vCxS756LrBOAHAgiJ4Elzq58Lp5skqQnPGfP9TbltaYOCcBqi5
	 g1wGHlAu39jkH81JVS78eonS5h5fXL3r1jDN9jUZXHxhMEfOvzn6K3L2wlj8jgaxLd
	 tgcA5UhbGTTJ4txe47Hd4vA+POx6M6171X+VimluG6h7SFW5OFxaJnktOuk7elXKHw
	 ve5cUKLvLFTCcfpdDfB+s+XnYM42+xxWQuY8SDXgqm9EAPJQphKl+7YdsRSB9JQ2zJ
	 WA+Aqih661uwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3249D40938;
	Thu, 26 Nov 2026 12:24:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C9CB12DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB1FF8110F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FBsbQ9IZ7cC for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D29CE8111A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=M84UzsY4
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D29CE8111A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YwooDMQIoQBpwUB6i31XZWYVVaQ12vzwH6Cf4DCANO4=; b=M84UzsY4YIAE+VZz9nmIg6lLr3
 9qKJDQY09LZnRcBoZMnO76rWl1skC6Mryl3Cw1/Bn2peO0He6gMnDnYgO43puyJTjuoKOzneVVzYV
 GVFB3/Ymm3Y7JoaxAIGxHy73/zaNp5yosKTdNjAEyvvb1Ahw6djBEgi8LGLyC0JZ4NjZUYK2LKnHQ
 GzkejRggKHotKlHG+vtsDfjAKgixPoKp7A4eKL1PQMqePsDf/htFGGAXWeBJg7gGo0+FWC9whsfrG
 jAINCVRPij9SXfQ9Bqh0IUwZYpLMUTMgxTvbq8TtbcopeEBs98TlKH9DAFfEfMp8bFLZKKIPako2/
 mZiH1DpQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWf-000IBn-2U; Thu, 26 Nov 2026 13:24:33 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWe-0003gJ-2A; Thu, 26 Nov 2026 13:24:33 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 4/7] power: domain: imx8m: do not unconditionally select
 CONFIG_CLK
Date: Thu, 26 Nov 2026 13:23:56 +0100
Message-ID: <6e13d5d33627302c12500ef712bf4a1c32947dee.1795694935.git.nora.schiffer@ew.tq-group.com>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No clock is needed on the i.MX7D, and currently no clk-imx7d driver
exists, so CONFIG_CLK can't be enabled.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/Kconfig              | 1 -
 drivers/power/domain/imx8m-power-domain.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 46c127ef05c..8809887b1c4 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -43,7 +43,6 @@ config IMX8_POWER_DOMAIN
 config IMX8M_POWER_DOMAIN
 	bool "Enable i.MX8M power domain driver"
 	depends on POWER_DOMAIN && ARCH_IMX8M
-	select CLK
 	help
 	  Enable support for manipulating NXP i.MX8M on-SoC power domains.
 
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index a3ef49aa67c..b5c3b2e2282 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -517,7 +517,7 @@ static int imx8m_power_domain_probe(struct udevice *dev)
 
 	/* Grab optional power domain clock. */
 	ret = clk_get_bulk(dev, &pdata->clk);
-	if (ret && ret != -ENOENT) {
+	if (ret && ret != -ENOENT && ret != -ENOSYS) {
 		dev_err(dev, "Failed to get domain clock (%d)\n", ret);
 		return ret;
 	}
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

