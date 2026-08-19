Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7FDC5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 07:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 105F780E8D;
	Wed, 19 Aug 2026 07:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzgyI0PIgpPZ; Wed, 19 Aug 2026 07:08:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787123305;
	bh=pCYEVE0mN/3RFzULpQjoEiiLWREjfNRl8BVc46eS9co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=htvojOQktvkE2z60LHFldYk6nI1UMd4gx8mumepGs2TrfGjKTv+nblEiq54R51qUS
	 f0F4zRi9QhCnp4qgMRml/94kobLa/Oq9MVubYyiTjFGPzyXOKjE0wFfqv5TfoedMVF
	 oCLGAJfz0LrpioaiDD3Bfj2tr3EU02ZHjlBYdoiFBF5R+gFC/Sp5FORG6WQpd1Rsr1
	 ndIfhQNLjKPlPk/EJo0cXQLlpWD2AfwO1l5IHywALVwOmKJQa/WDz5r8uRoNIUchRz
	 xE/pp0QKB28+CqJ6J0dU+t1I9Mtike1yNZwXobaKxPETt+LQ/fwELRAQUvSHY+r2tj
	 mmrM9L3Q05aZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 747E780E8E;
	Wed, 19 Aug 2026 07:08:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2B4829B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A49EB40042
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rXGp3KZqjNjw for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 07:08:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=TcyyIgyT
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81AC740026
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:19 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1787123297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCYEVE0mN/3RFzULpQjoEiiLWREjfNRl8BVc46eS9co=;
 b=TcyyIgyTdUzQRJ/Y+jbliMdJRUdXSzyKMf34kWeDrW+eSza7M83HaAUl48FH9hoeBY5A5r
 Fsa/GgrG6LrIpxTNIbimwQfRZzFm67C0d6TUFDwCqWpC4Xr4PTGdryMXblh6ZT8fdfMrE2
 UNkZhsnQng8cdjXuCS8d1MxiWPl5P9L2qC1/Ts/o0P3TdghGOrgk1BPNpmISqb8hKDOA/+
 nbcr1R+70qpYlmeoaMtqZCNfzBI48tSte6RztTP//pKbfITR6E0BpVQzz1zutYDO2a8Uri
 lnJdDZ0im/DTxFgdWMr3ME9mdM1w3v69lsus+VoLbI5UnjKe+RjU0kUP9PuG4g==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com
Subject: [PATCH v2 4/4] imx: kontron-sl-mx8mm: Stop printing error message on
 first DDR init
Date: Wed, 19 Aug 2026 09:07:55 +0200
Message-ID: <20260819070758.51350-4-frieder@fris.de>
In-Reply-To: <20260819070758.51350-1-frieder@fris.de>
References: <20260819070758.51350-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The first try might fail and we are retrying for smaller DDR sizes
after that. Don't print an error message to not confuse the users
of 1GB and 2GB variants.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/kontron/sl-mx8mm/spl.c b/board/kontron/sl-mx8mm/spl.c
index a5cdd2ab6d1..ebb883f861a 100644
--- a/board/kontron/sl-mx8mm/spl.c
+++ b/board/kontron/sl-mx8mm/spl.c
@@ -77,7 +77,7 @@ static void spl_dram_init(void)
 	 * Try the default DDR settings in lpddr4_timing.c to
 	 * comply with the Micron 4GB DDR.
 	 */
-	if (!ddr_init(&dram_timing) && check_ram_available(SZ_4G)) {
+	if (!ddr_init_silent_fail(&dram_timing) && check_ram_available(SZ_4G)) {
 		size = 4;
 	} else {
 		/*
-- 
2.55.0

