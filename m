Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ADDC4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 22:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBB2E608C7;
	Wed, 22 Jul 2026 22:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdnOYKkZWxQw; Wed, 22 Jul 2026 22:54:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B65E608B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784760898;
	bh=fy+tT9DIdphE3te9lfwC/tEdQ5KrVx2oCdLfFfhdm/4=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=R7xqX1xnCQjnBhhb/EVB7RmliXqFAkE9/Ktio4Re5V0/jw1KWgMPqMHY/RDfEh/ZP
	 rLvplLIgR6whJyhMDsOOm8zWYhEt2SvSAmjc4yUkaY1qyVosHJLgMWnPqyXTyVXrr8
	 7CnmpPC9KdJXCRs7m2zb0z0r82AYsT/u4m03pcyC17B3ufmMZzZWfScUy2MjFWzh5+
	 2xzYGOxs42MCpCDeIAxKHZHU+IPUGYrSW5uhCFMSmVFevDcy2DoveSAe3CAj/C6Sc0
	 c7+JLJRg9tEACZieVtDhMvfeNsFsDAUBE8hgW4NO90Iyqz/2xwhrbzFLkiTy7bVmcl
	 pl3KXnrAXVjog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B65E608B7;
	Wed, 22 Jul 2026 22:54:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CCC32347
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE4DE80F72
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:54:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ud0ERZRgtXRm for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 22:54:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ABF8F80F68
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABF8F80F68
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABF8F80F68
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:54:55 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h58hr6Dzwz8tvP;
 Thu, 23 Jul 2026 00:54:52 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] power: domain: renesas-r8a78000: Add SDK SCP 4.36 map
Date: Thu, 23 Jul 2026 00:54:26 +0200
Message-ID: <20260722225447.88050-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 88jguthnzigthu9hnxwxbseiwi4spmjt
X-MBO-RS-ID: 6c6fe7780114a1c0a82
X-Rspamd-Queue-Id: 4h58hr6Dzwz8tvP
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784760892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fy+tT9DIdphE3te9lfwC/tEdQ5KrVx2oCdLfFfhdm/4=;
 b=hpwY6h8obOchKeizmx1TCVFBbvp+XBU22LDHZBWtn7wEUOhf1GNZc+rDC9jyHCaNJEY74z
 HGdWRUWKSi3rD7pzoVwXtFp1bhRjjyTh7KXXVnuvPrwPVj1o4yv6NrcS5YD9sDSChVny6B
 CUu9Okk6DKObadjOlIxYYLg/82VpmDBhciQbv3XtKDkh0+lo8mXV8S7sZr5z0Z/z1uTc/m
 5au2qL51ti/TLgWqXuTAVqUWfh12DJm1doUxWvlsgXGKnVuSh3+c5y5OKVl46w5tyxPf5r
 n8dA2oVRCyj62I9LaCkBPj6Dx/XHJiR5eykiYdR9Kr3ntZjF3tt/T87Hr9Vm9w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784760890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fy+tT9DIdphE3te9lfwC/tEdQ5KrVx2oCdLfFfhdm/4=;
 b=vb2ZjKNFtAnnNXwowXacTM9F1P1h0VV1q/ACHb57HkXX+Njh5s7r4GcEeTR2JocsO0uwWg
 sOroYyuhxbJpV00hEKXytk7wr4mcZ5RfQY1zIRZspXfnRjguDJN9gAgYjEI202Gf/ObAxa
 ejNacuom5p00SbRPg26RWDdAIFqWoLzREs6oJOcKuagArmX8eYfW8hOHbB17zX5LSPhVAR
 NOU4g/y1Yi/DO08B9wI8jMncTOqyoz2r4gJVKiqo3Sa0p9LnDjlpJaPLcqcFhbNaAT5myw
 Y8LXTLOVwY7hzZ6qg83KjAruUJD6co8+cKg8ZjElCRO+2y6W02W/0vy4uVt4MQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=hpwY6h8o; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vb2ZjKNF
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vb2ZjKNF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.36.
Add SDK SCP 4.36 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/power/domain/renesas-r8a78000-power-domain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/domain/renesas-r8a78000-power-domain.c b/drivers/power/domain/renesas-r8a78000-power-domain.c
index 57b3b56b2d9..62b56fd8ae0 100644
--- a/drivers/power/domain/renesas-r8a78000-power-domain.c
+++ b/drivers/power/domain/renesas-r8a78000-power-domain.c
@@ -166,6 +166,7 @@ struct rst_map_in {
 #define GEN5_SCMI_SDK_4_30		0x010c0000
 #define GEN5_SCMI_SDK_4_31		0x010d0000
 #define GEN5_SCMI_SDK_4_32		0x010e0000
+#define GEN5_SCMI_SDK_4_36		0x01100000
 
 static const struct rst_map_in gen5_rst_map_dt_sdk_4_28[] = {
 	{ SCP_RESET_DOMAIN_ID_UFS0, 202 },
@@ -220,7 +221,8 @@ static int gen5_reset_of_xlate(struct reset_ctl *reset_ctl,
 		map = gen5_rst_map_dt_sdk_4_28;
 		map_size = ARRAY_SIZE(gen5_rst_map_dt_sdk_4_28);
 	} else if (priv->basever == GEN5_SCMI_SDK_4_31 ||
-		   priv->basever == GEN5_SCMI_SDK_4_32) {
+		   priv->basever == GEN5_SCMI_SDK_4_32 ||
+		   priv->basever == GEN5_SCMI_SDK_4_36) {
 		map = gen5_rst_map_dt_sdk_4_31;
 		map_size = ARRAY_SIZE(gen5_rst_map_dt_sdk_4_31);
 	} else {
-- 
2.53.0

