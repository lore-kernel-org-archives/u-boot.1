Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC22EC98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9512640BFA;
	Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACHt5tTc-aym; Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D28FF40CD4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253426;
	b=StjooS6E7Ee5mLWWTmAq7l1ly904KlfXc5NZHBrJcZbFzwjNsiNjS5yORIWUS315G6yt
	 lO3KrtUNWukXCTb5kSxPsXlgas2WryTBvblONs8kYhN+5LS+in8rvaX5tisvIam9JANzY
	 btofnppu7iGfi8AOIo7uafrxYtt0k/V+aJ5se8anfQhw0yWK+UNOff9/E1K7XMrs5/Lsj
	 SSQADgsawHynhVQy1i0dIYlDoQPyOiKQOx1C7Uec3+P+Q34Ln201zBYKki6U1CRHZiT42
	 3xwlHVDpOM3wcJjLUfMtlYocTMcBKzk9C4iIGOgegqmanV+hILwRe8gXqk4ystXoSFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B5Wj2IwJuUq1Id7FDZBzFMFG+oDIRcZl3+He1WITjDU=;
	b=GkNq/OoQHxi0a5UXs5hkg4TcxMvddn88Un3c9YwtLQiZolBJE5eAyad7lVosToe5zHoG
	 3GVciVCvz1dWzB4e9PK2YAtUffI3Tt8/3UIH2NGHMTjH7fRUgfnFdHlNyHX2c47An4aYt
	 VyjfeRmeCD6VXIT1xsnPQqyR4/A7a+flPmCA9JE/8hD/Nlu9AoX/BcRKmuI27REpNc/aS
	 UcG2c/Cm79MXqOcBVicWkfIg6kFNUJ9k65XRxHluaQIRqwc57Fnvgfs7em3m0APGVlOpB
	 fRFJCm2P1LKsNsVmFPB1wXg451GQP2eYfg0mrclpfYqQIl8E2y/V3ctTk9ypqYKNweg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ok511ZEN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253425;
	bh=B5Wj2IwJuUq1Id7FDZBzFMFG+oDIRcZl3+He1WITjDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0RdcbDO1RcLiYSkXmg3lR/alMCtrGho742ma5s2aTPOqDgcUeMzCrzMQHPDMz2Lva
	 HiJo8M9LD7+xT6MR6xT6dLJI92FtwGcsakTwDo9/k44Ze5ahnMazASYSJElBg8yUUN
	 AtRai5U4T6XaHe/BKGvdKqf2r4B9Oje9SFROK/0v6HP/83S9grFQDHdEsRSv7FlFoV
	 vMdAJZv00+mYUA8V3dzElxFB5EzYXOk4ZP7Uki0JElhE2nEFlMvqXGqQnOVfOmm573
	 dvfozjmJ8KVeZNDzgosTw7dZxi5cmoPfkekLO5f/5n/2KUQq0f0fEcYnMt1lirfa+P
	 z2T+PkxpO2Tcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D28FF40CD4;
	Thu, 24 Sep 2026 12:37:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AD164392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EEDC40CD4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1c7CIthGhOJQ for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DB2EA40BFA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253424;
 b=Y3Hf+IlQTUYfLb+/lZ7uNutOTq/iaNLb5wLT0rC+NQ6ESGHPCa4m4cN9Fjx/tiei+EY9
 729qh0VsJXPkCv3wKytAD6hr4K/Ec3hI9of0LoDiuSRKJGd4IVmY3Kslz4C7crub60UJ9
 RVbqHTl4vSsB1jWVt2flqzsJ3ssW6AR3cYBvQfib7aaw8ppTnehAxs5yi9vOkuifhFmuB
 fvUzs84eyK1pIWNm9dMnSkz8/c9/dh6sCymjhWkIvdvpFU7DA3UvYuiLA3WS7rZX8c+x2
 3j1T2BYpSkmjqFLzZGPWw2fglsXKzlEhEPV77N7A9006DMlJV0/B8ADnOlvTQRIaBJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253424;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=B5Wj2IwJuUq1Id7FDZBzFMFG+oDIRcZl3+He1WITjDU=;
 b=ID/rPSzYKCe9vpf/AFApMMLzrDr4qtJI9PEJpYe5jiIQl1XdP5ElunfO5+IjCXulkWDG
 UOGuo6dQY8Wbi7mzBdn8fnW2m/LWJhsgxFqdzfOVCQXtpBuUuC7Xtoor+ybUxEywCjqWE
 Qiir00EfRJ2QOvVBmdij+TGFSznKkF/AxxfgLBKsos7h17vvDamrPd1U03o8Pp4Qf/Fun
 08+0OVqqJmN37YmQE+HdU/hpkIQOoER9WMIBtWOOw5zIU9eyoAjuN5dZeIfmVI4RjTG4A
 RvQuWJ058z+xNJjf1LY6MtQN7V4kY6oIeShb+ur52ZVoyKLMMSQgdh69wbiwk46H/qg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Ok511ZEN; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Ok511ZEN
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB2EA40BFA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 992614E41059;
 Thu, 24 Sep 2026 12:37:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6BDD960341;
 Thu, 24 Sep 2026 12:37:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C1BF103292C3; 
 Thu, 24 Sep 2026 14:36:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253420; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=B5Wj2IwJuUq1Id7FDZBzFMFG+oDIRcZl3+He1WITjDU=;
 b=Ok511ZENfRNDfpTpYIHV/RXurzjaJOPCghXtQ8SDv3fv1CcwO1ktVzoMBwIjIw6a8r5L3m
 fQ3v+oV1fMy3d3USBR97EA8njpDjxy4qCFjcduv7hBksZzyxWNAEAQaNgxQHSdSK1LNkYn
 ZrAQG/4BDZv/Y3YTdKYo1AQphsMM7S/IqVM5mrtaRER7Xhpjdf8Wc+OXYkMjHjI/suuKMU
 f+HdztqoG6cEls6MLKa73eLSc0VlArMVXsa5DxLE7iroeyWlkVfAPBj3gPk3ZFWXa92YMJ
 l0vGxulMBhUS2NAvfzDKbXAwItyZn/0t0C44ILFKe5MlUU0NxrhbBU5hshq5Dw==
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
Subject: [PATCH v6 14/22] ram: k3-ddrss: support j784s4/j721s2 DDR resume
Date: Thu, 24 Sep 2026 14:35:25 +0200
Message-ID: <20260924123533.2599438-15-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
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
-- 
2.55.0

