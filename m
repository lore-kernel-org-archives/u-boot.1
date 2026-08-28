Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDB6C61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 259D380F88;
	Fri, 28 Aug 2026 13:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L1rphrnX3kYg; Fri, 28 Aug 2026 13:58:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925519;
	bh=XzXhdHGYQvLyQYjuVZgn36+i5is5ofcOjAZ0zlm3eCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Aqlg0lCdT1tpYM6ugy1O+QtYp5FmE4g/GqalwvvG5zUgLm0PM6/pKlWlCpxXi2qPT
	 BPE0xz1ElU5Duz2KtodZZvpomOCqZmZHp8XJPXZ9vrUirv8HVuXn2Bw2f1+wIzeiIT
	 NKT3dM6+GMLvWaNNMebn+uN3y0Wc5mvliuzTwXjmGeki2SOQ97LavL6R1jyk5i8L9C
	 QZ9WjL0FnlCGnh/oyeY6XJVr2KqGc9uQbdrU98PIxkageu4EFyvy+biDGqpw1Wy7IG
	 DoV5L0Kvm2x14EakmQPO9DxDsMk9jUCuu7FKXJQpUkEYF9e0z1KYQLn7bt7HhJY8af
	 9fB4hg9oqJybQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C58880F4D;
	Fri, 28 Aug 2026 13:58:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54036334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 506B780F7C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VNnpNSDDu8MO for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=awNjHIet
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8D8B80F82
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1317A1A18A3;
 Fri, 28 Aug 2026 13:58:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DB2AE60537;
 Fri, 28 Aug 2026 13:58:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9B6C611C781DF; 
 Fri, 28 Aug 2026 15:58:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925511; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=XzXhdHGYQvLyQYjuVZgn36+i5is5ofcOjAZ0zlm3eCE=;
 b=awNjHIet3aRKTevDADENVOX76Ya3EvfEawT9mgO//feBvU8b3MjHpSMNgKCnp8LJtY5CrK
 eQQOuT9WJiZNdto7QoZK38a0jqub9MgD5xajIa+5VtTi+X3GGWtQ4WDkpv4oyx1W9z9yty
 TJeCYdSUe0Z0p9Hok5JjvhAigHS59MGkAmt+Sf1Slwxne5UdgxM2SmoahlaMze+ZfEfZ7v
 NnH2pQHQxVeCNg+3rt0J6PW9LOqj4tGyvWwCzp5vw0s0Y3uUHf2Kw9KXbd7JYfJ0aAhVCv
 Ag9MoUhjYf14NESmLfvJmK15AQh4YUcyAFaqRFDeJjujP/3v9hcJ7nUt0ZGlgw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 14/21] ram: k3-ddrss: support j784s4/j721e/j721s2 DDR resume
Date: Fri, 28 Aug 2026 15:57:23 +0200
Message-ID: <20260828135730.1565643-15-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

j78s4/j721e/j7200/J721s2 can't use the standard resume sequence.
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
index 3af360f191df..60f54a72adea 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -123,6 +123,7 @@ enum intrlv_size {
 
 struct k3_ddrss_data {
 	u32 flags;
+	bool lpm_init_only;
 	bool (*is_lpm_resume)(void);
 	void (*ddrss_deassert_retention)(void);
 };
@@ -1158,6 +1159,9 @@ static int k3_ddrss_probe(struct udevice *dev)
 	k3_lpddr4_init(ddrss);
 	k3_lpddr4_hardware_reg_init(ddrss);
 
+	if (is_lpm_resume && ddrss_data->lpm_init_only)
+		return k3_ddrss_init_freq(ddrss);
+
 	if (is_lpm_resume)
 		k3_ddrss_self_refresh_exit(ddrss->ddrss_ctl_cfg);
 
@@ -1289,6 +1293,8 @@ static struct ram_ops k3_ddrss_ops = {
 
 static const struct k3_ddrss_data k3_data = {
 	.flags = SINGLE_DDR_SUBSYSTEM,
+	.lpm_init_only = true,
+	.is_lpm_resume = j7xx_board_is_resuming,
 };
 
 static const struct k3_ddrss_data am62xx_data = {
@@ -1299,6 +1305,8 @@ static const struct k3_ddrss_data am62xx_data = {
 
 static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
+	.lpm_init_only = true,
+	.is_lpm_resume = j7xx_board_is_resuming,
 };
 
 static const struct k3_ddrss_data j722s_data = {
