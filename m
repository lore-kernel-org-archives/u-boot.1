Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8D606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pg1YKP4c;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FYHOJL6I
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 469F98129A;
	Wed, 18 Nov 2026 13:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PzguYuR-QZUl; Wed, 18 Nov 2026 13:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B49481275
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007946;
	b=NJeMNmsLqjSsThUlmbt+AQ5g2PuhTKZu8Gthx8ouSxTVg0A4nZZlepQSrw/WHLoEl3aF
	 aBdHyhnaTqp4qJhNlkvFhvPqPqMnNBqzhiJkt36deK7Zg1kffBo6bxouUpEyqRQ/vE8ii
	 aYUmEBdqHHXfEQRviD7IQ7BuSkpJ2P3vp4xHVyptoE0YxdDHLNvbLFnK9wCOZkqdAhznK
	 rPag5qnqLnyUq5iS3UA55lce47mhpFip5XaIawPy/uXQTZCopUTwULImHzGpoh29j4/1v
	 RxmiBgxZIUZuEYIalRu4w0aIOChytcQoKtNZ7n+cUG71XOf8jrHhkyoDDcx7zz9lsrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BFoxoTv8+/deAjt5pjGvyV4fHPOT0BtFV8cosO+YzYY=;
	b=EZO5w9KNLw9fPZ6GPHH21+Nb4vqs6qy3sar9WKt1Yy46+bNjrJB3+YEWpvaTf5ziOVDh
	 nkRDh+Qfnx0e6QWtDWI3/qazGvLYsWAmkP8bHFOnBzseI0WJZcG0q2SswAKbv5aLjkbUb
	 yNUMA7hAkLnL8+GvhgXdplnKwwBfd5LowxMCgrRx4ja147h/ecDP0HnrsoyZpMMqjVwEh
	 Evfx0S25QwRh4CXI2AycMh0ap4jB7AO7ki/8djRDHJXTNN4jvcm0al0ZE+x7gaCH8kk4m
	 a/UFeLYAQ+IU6+P7N+Vtlp2vdb9O0tAjtrhUGOZE96HwCJ7deYtQSQ9eyON+ygSPSFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007946;
	bh=BFoxoTv8+/deAjt5pjGvyV4fHPOT0BtFV8cosO+YzYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pg1YKP4cKDy845Ik8/v8wK5sYsTmsA449dGx/5XAWaymvJAGBd0Gtr09eFnNof1ZH
	 m9phvR0m6LFgyxZy75k+DqEsaSdQm3VN5+4QfTmFOpNM6POyJSc/NSL4vW2j8ZoIZp
	 0Hc9gN7O699JZISCfjEdJrKeiDvhFneAHsnK5/D4CTzqq/WzDSzY962Kzq/4M7HOUa
	 nsTCRCQCnUoSylV6uaR04OmaATzuYtP8pHV0wkmC8RTlXxou0Jes/bseDoLn/v9IBq
	 IPqUk5TbwCgd3fgYjiL1KMT7himUnNq10O5dlSNMW3JeIeLljsRM0z0FtLvXkzWGFM
	 exqviALqx786w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B49481275;
	Wed, 18 Nov 2026 13:19:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BE1A61
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6A6360A56
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hP21tPzxdiKQ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A54B60A51
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=FYHOJL6I
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A54B60A51
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2FB3D4E41627;
 Wed, 18 Nov 2026 13:19:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E2D4F5FE9B;
 Wed, 18 Nov 2026 13:19:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 783EA11BC1FB0; Wed, 18 Nov 2026 14:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007939; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=BFoxoTv8+/deAjt5pjGvyV4fHPOT0BtFV8cosO+YzYY=;
 b=FYHOJL6IF1S+Y67NI4r7TvLBFVGvxPosyuRCsGY1Uu3SRo+whsx7Ad2mZTOHxlT6ps8nrg
 7+Di15XSKGPOt9SKPMm+nfasjkvmP4ZrEFEccMbe5jsjS9e94mEevs0lk9vwb8NJeHZQaK
 W705RepbWVxSybxjBECm8oGrWyJatTONYtUG+Ddi+j7FjWnNHdKZpb4wIAcJcpmKdYR1w6
 1Uanvz3U0bNKFOoSh3js46gXm3cX1QYzti+OpvlNDd4n3rL3jngDjmJPLIkSqezlVfsLRN
 ySIoLU+1EJ0MmYeS8nfyZa9ss5gdwOiolLW6AdnizGWrKwZgxxCbWVoovX/5+Q==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 12/20] ram: k3-ddrss: support j784s4/j721s2 DDR resume
Date: Wed, 18 Nov 2026 14:17:59 +0100
Message-ID: <20261118131807.135859-13-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

j78s4/j7200/J721s2 can't use the standard resume sequence.
Typical DDR resume sequence is:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power

We have to separate each action in order to de-assert the DDR_RET pins
at the right time, because the DDR_RET pins are all tied together in
hardware.

At resume, only the initialization of the DDR is done by the driver, the
rest is handled in boart_init_f().
So, introduce lpm_init_only flag to only initialize the DDR when resume
is detected for those boards.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index e4616036f15b..6bbee0cd59ff 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -123,6 +123,7 @@ enum intrlv_size {
 
 struct k3_ddrss_data {
 	u32 flags;
+	bool lpm_init_only;
 	bool (*is_lpm_resume)(void);
 	void (*ddrss_deassert_retention)(void);
 	void (*ddrss_clear_retention_latch)(void);
@@ -1162,6 +1163,9 @@ static int k3_ddrss_probe(struct udevice *dev)
 	k3_lpddr4_init(ddrss);
 	k3_lpddr4_hardware_reg_init(ddrss);
 
+	if (is_lpm_resume && ddrss_data->lpm_init_only)
+		return k3_ddrss_init_freq(ddrss);
+
 	if (is_lpm_resume)
 		k3_ddrss_self_refresh_exit(ddrss->ddrss_ctl_cfg);
 
@@ -1293,6 +1297,8 @@ static struct ram_ops k3_ddrss_ops = {
 
 static const struct k3_ddrss_data k3_data = {
 	.flags = SINGLE_DDR_SUBSYSTEM,
+	.lpm_init_only = true,
+	.is_lpm_resume = j7xx_board_is_resuming,
 };
 
 static const struct k3_ddrss_data am62xx_data = {
@@ -1304,6 +1310,8 @@ static const struct k3_ddrss_data am62xx_data = {
 
 static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
+	.lpm_init_only = true,
+	.is_lpm_resume = j7xx_board_is_resuming,
 };
 
 static const struct k3_ddrss_data j722s_data = {
