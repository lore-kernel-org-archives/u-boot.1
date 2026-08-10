Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339CDC5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D65FA406C0;
	Mon, 10 Aug 2026 22:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GFUToAZRpF75; Mon, 10 Aug 2026 22:36:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB3B7406D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786401377;
	bh=ddkf/IMkHpk4XbzhuDcIWSGGK0y7Qq56EAtOLu7FOFA=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nWRolysVA2MsMv+wrnePV1gUog7P9bQrSNGiwTm1/7dkDOMPcnYQSK5YYENdgD4k8
	 PM78KlOrMnY+RR1NTlXLF1He0A+ZCCJXTvKtzx5VKbD4JfKAdAD/tc6yELLPiRgB0y
	 g4Jip0MnRsiA31UWBxlnR7HOLGaTexOgVdnl43rUyS/jbzTDXv55u0TogLpZRAHjl6
	 hh6zad4k+s/tmyAd9hzV1VFBSK9oI6vrJUHEply5iBzXUtT/nK2eKjXH9eL4ByVuij
	 nCP9vEuqxA+2zMdqhguFpPeVUZRmCWpNzyEFYjnLYg1rkyXVyKFWyucyLNgtNSSBrS
	 r83QJAj1rkLjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB3B7406D0;
	Mon, 10 Aug 2026 22:36:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53CF2296
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45D11406D0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eUKaVT78gHa0 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:36:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8DD3E406C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DD3E406C0
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DD3E406C0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:14 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hJqNW4wzwzMlMF;
 Tue, 11 Aug 2026 00:36:11 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] remoteproc: renesas: rsip: Improve error print
Date: Tue, 11 Aug 2026 00:35:03 +0200
Message-ID: <20260810223604.1333043-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
References: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gs3xpiei1jfz1yrnuw6ua3yizs38sa3y
X-MBO-RS-ID: 1a0cb4899da8f20423c
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddkf/IMkHpk4XbzhuDcIWSGGK0y7Qq56EAtOLu7FOFA=;
 b=uqLejNyxvmut+jRHhEF8rBbExtnZWAwwW6QYMD+ynlR3Mv5Dmk3qbV93nrMlKBO1vzJHMQ
 GIO23LQD/M9q1DEG0zseBfOQgOkV0OLV6gDWbyFsE1DK4TQJp95tu7XsYqzLrvYtAwI9B+
 M4AD9jb1gnBaWO48B3lsKs7RkBqUCWhOXiqyD8XkPGKxLvq725YQxvzddzuEbFDAkv4Jlw
 UikfpR5w+F+EiHI/2S9yz8U4Oi+H0unBNpTUZAgucfGCp/KfB45Wukyovw3vQjOUEHCmi6
 Fznz7QnL+75Jozhe2bzhTe5zwYYx35ZpsAEqoDoupB7aQx5zCff13aLBEc9S6Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddkf/IMkHpk4XbzhuDcIWSGGK0y7Qq56EAtOLu7FOFA=;
 b=X8mIved54Y3sLIUTKApZ2mP30wEZTEUJdBNk7Gy0emgB+Bc6c2kc6WvPj7x3yncwfbV/0F
 S0YY5D6M5acVy/VP+9IZJdT/RblhxSDhEZuyeET9UgWeXOBaHyFoKhemGDbPZlejq3Vrru
 mUy861lht1ofa53AX/NqSmt5vuad5F/cxj1BHMUUr6kFC1QbRxKQ/JvNyKbEs+UQ4i28z5
 RUjHsAxlgpBDbPaiwBH+JogokAprCXX7vpXiOr3C6zjImm5G32k5CvQxPjkUcsfWIxuw/b
 vO5HnXw+5iO2m2PQzh/xChh6eBW+NJFDwnrpblqN6a4+4/WxcbJY+kZB/hSV+A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=uqLejNyx; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=X8mIved5
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

In case of SCMI protocol error, print SCMI domain number and error
code both as hexadecimal and decimal to make it easier to interpret
the error.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/renesas_rsip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/renesas_rsip.c b/drivers/remoteproc/renesas_rsip.c
index 68b775e5f82..cabcc2822bd 100644
--- a/drivers/remoteproc/renesas_rsip.c
+++ b/drivers/remoteproc/renesas_rsip.c
@@ -129,8 +129,10 @@ static void scp_cpu_core_start(const u32 core, const u32 ep)
 
 	/* Read back the result */
 	status = readl((uintptr_t)shmem->payload);
-	if (status)
-		printf("SCP POWER_STATE_SET failed, status=0x%x\n", status);
+	if (status) {
+		printf("SCP POWER_STATE_SET domain %d failed, status=0x%x (%d)\n",
+		       scmi_parameter.domain_id, status, status);
+	}
 }
 
 /**
-- 
2.53.0

