Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EE2EE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F51D8700A;
	Sat, 19 Aug 2023 16:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xlak9RUU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dy9vuk+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4741987010; Sat, 19 Aug 2023 16:39:27 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C05C986C9F
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 16:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RShG43f9jz9t9l;
 Sat, 19 Aug 2023 16:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692455964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=up3srRSNnMhRqPmAMx8CXnxUAPnA5Ho7iANfENd2Dhw=;
 b=xlak9RUU2u9EBh9rJzWMFrzQMQ6qgfzLtIEMFFr+3W6oSMUXwvr1EC61483EBKB797JB6r
 kiqg+5AZz32LDrc6Q92u7dj1WWAokWLpBlNoyGF28NUUI+3I/SycIOyhcpWUcG/33h9R+F
 H3xM4VMAdWnCEgY3AHEETC5VA0rp+z5txA/NJpGNF1gfzaiVWajxAVgZT/ci4gOWc99YYJ
 2eU+oICfq/8unZonkCndZMX5orntgdh0YZPbVuYnOSVBBDXdKz0UOIAjDh8WXZKKRiQxrb
 9wc+0fajZn9fAciIWVNb+FzJyzkWZQGOvM3zJ1l/Jv7/EqbeKX6eP4nrofjxxQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692455962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=up3srRSNnMhRqPmAMx8CXnxUAPnA5Ho7iANfENd2Dhw=;
 b=Dy9vuk+xS+m5Tiyot276UG2M2KSMOElG7XA3zHIISS93QgboWvr0fm+ff0zkixl75KYa9b
 ImUFWGN+ad4jQyNiK2bLXDxFO45Chy8MpKVDGKhXgUwo8mmytGv52sHGa2JH3E8eGAYSKE
 l66D+RnIr150DSbJjmQMcJJD8Jf6JmTdDWfxHew/zEo3CPgwTkCqWBOvqtPc6IZEF/bOfy
 cEobzfcmGDbSoMrujDf3wkUC91/gDxFA9emmsXuh2pLR1hs3IVjTq9OK+xsjKUyO0wCESE
 CoMsnERRpls5Jaq05DavLIkZywfOdkjlRFi7dmzGMm/OAU7XFABIDLI9qYX2tg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH] ARM: rmobile: Clean up rmobile_cpuinfo_idx()
Date: Sat, 19 Aug 2023 16:39:13 +0200
Message-Id: <20230819143913.54523-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1ddafa04fb07ad124cb
X-MBO-RS-META: aiwtuxjiguh3q48s1gmg1hecnac77dkq
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Clean the function up a bit further. Return immediatelly on match
and return ARRAY_SIZE() - 1 on failure. Add proper comment in that
case.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/mach-rmobile/cpu_info.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 7651e43bd0f..6804b1da2cd 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -83,14 +83,15 @@ static const struct {
 
 static int rmobile_cpuinfo_idx(void)
 {
-	int i = 0;
 	u32 cpu_type = rmobile_get_cpu_type();
+	int i;
 
-	for (; i < ARRAY_SIZE(rmobile_cpuinfo) - 1; i++)
+	for (i = 0; i < ARRAY_SIZE(rmobile_cpuinfo) - 1; i++)
 		if (rmobile_cpuinfo[i].cpu_type == cpu_type)
-			break;
+			return i;
 
-	return i;
+	/* Unknown "CPU" entry */
+	return ARRAY_SIZE(rmobile_cpuinfo) - 1;
 }
 
 static const u8 *get_cpu_name(int idx)
-- 
2.40.1

