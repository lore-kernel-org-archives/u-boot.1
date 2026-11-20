Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C5606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BnE0yDEc;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=AG3NaXy5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 397AB40A71;
	Fri, 20 Nov 2026 08:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cOlevQieuRv0; Fri, 20 Nov 2026 08:00:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8BA9840DD4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795161646;
	b=hazDlU8WDHfJhb3pJNrj5SBJG/BDXcF7t1tzLmf6C794bYU8DR2cA0E37Yc2D6MJUAUz
	 i2Gga/0NIGnTRW+eI/bFg4yY6qNQS+p11cffPr6a5zfBUH2vlorIaIjgrUR+mC/DdMgZG
	 4l3XDZOlydmvcejQs4Zy37Pt3oUwa+6HsEPiUxfYuit6ZpUSrnt6ac2p2CTA5ZnAt0Zxd
	 o4ZZL4Xb2RcnSaBfVI5H7iIjePcQR9TZ6PGuF5dBq/iE3IZfCmog3A7nO5P6MKB9LeLOL
	 oh+mcErNyVGmLy/S0hZFNz3+2wLZukyo7GYO1LhMFptU60dUJwDjIri/9jR99Ehnd9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795161646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zuk8M9FraLEApkToOjzPNBJ5OxRAQ0WYrGy3epvlzwY=;
	b=QPduAFADIywa4+5UJfc0FRNeLZNEhFbJEGa8MSx8oileWg5evFFQcEw5j3KD27Du1pSD
	 j8reCKWiKLxJocZSsvZbHM/f5HtfWM0MY+bIbmCYHRzEjULHyb7It+rE+BfU4gw9Srfoe
	 1lOiHe59W7ABP89ca5nL0zpl2B8oNdX09ooqDOUa+314WgQ3wXMFCNTnMGMiyT3MowBjT
	 JZqsyo3ma0AyB53MKFBoMkw6zeRyWDVk6Vx7Xmd79QKsuIVm5kJcFroC+mrC4rv4VbdUX
	 EwWK6miH1QQcUhjs5RPx4BBeRXgpqM+LlIuauYXiNEzjA1lOdVZwfOMwr0/Ad68BZKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795161646;
	bh=zuk8M9FraLEApkToOjzPNBJ5OxRAQ0WYrGy3epvlzwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BnE0yDEc3nqDxy7Hk55eZW40l98ypEW2MPZB//sEcueahdTFvRvY3wMA+SIaF+563
	 9wU03xmZILN6a9BwFqM5vJiKQUXhRI/H2x7xyA0pHjtDoBtNZQMmBzC5m+GYtPkmjR
	 b+cADiJIma0PdFhF9GcU032/cmtbA5KTlzX6nLVEGIxxGwQK0q5mqze2SsGvaQxYNq
	 SZOL8G8eCoqaLvZbTSpTDJjvABeahQp8LlpADaL63QzsFARI99BrDW8oDlnhQdUAo6
	 6KQz4dDN7+wKf6fnwwBAshHg2njx3OX5Gia0wBkYc6mKBwcQSWdqBVOu0j5Va97sFD
	 Lpll2Rlgh0NLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BA9840DD4;
	Fri, 20 Nov 2026 08:00:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DCF579D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FA5E8156A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tvtjucobNt8W for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 08:00:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32CBB81542
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=AG3NaXy5
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32CBB81542
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zuk8M9FraLEApkToOjzPNBJ5OxRAQ0WYrGy3epvlzwY=; b=AG3NaXy5kMOsTkyWsTMmxziJ2h
 UrUUAT1eHScQ09vBNiTQ5Gk2Ks+2qSHYanzRZjgGcUW6Rj4QawC6rs1SKp/uCIXIdpi6prfioQA7W
 fsItFsxGN89Gu6QeeNV9AXkqIpTDMCBLmVXHEatNfVUIJPaBX93ZgN7E7gMvdTqCLsvKRSUjZuYIr
 WA7ky6uLPO/2wRzfdlpvlXc005plyugZjgoxB+RlrsyBTSGq53XyidlmzMZ6TtlbFe3J32KldMhei
 9U81Twk1uAniJsEEDfin/+/ByuRyVpxqoKPDzJT+MiIcJX/EAH+4drWkC+jSAXRPGDjlPJkgg3rh3
 OFLa1ssg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xUJXn-000I7l-1E; Fri, 20 Nov 2026 09:00:27 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xUJXn-0002gq-1b; Fri, 20 Nov 2026 09:00:26 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sean Anderson <seanga2@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org, u-boot@ew.tq-group.com,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 2/2] spl_imx_romapi: fix typo in output of
 spl_romapi_load_image_seekable
Date: Fri, 20 Nov 2026 09:00:13 +0100
Message-ID: <20261120080017.2762904-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120080017.2762904-1-Max.Merchel@ew.tq-group.com>
References: <20261120080017.2762904-1-Max.Merchel@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28189/Fri Nov 20 07:29:13 2026)
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Use 'info' instead of 'infor'.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/mach-imx/spl_imx_romapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index 51713b064e3..d66c249801a 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -120,7 +120,7 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 	return 0;
 
 err:
-	puts("ROMAPI: Failure query boot infor pagesize/offset\n");
+	puts("ROMAPI: Failure query boot info pagesize/offset\n");
 	return -1;
 }
 
-- 
2.53.0

