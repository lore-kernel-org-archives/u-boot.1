Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69E606A321
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V+FRjfuM;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=KwlKIuUy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 909D360E2F;
	Fri, 13 Nov 2026 02:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQGn8b_mfXO6; Fri, 13 Nov 2026 02:32:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3728D60E22
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537177;
	b=tKq4d6RkPYJsnTSFEAO57CEn2ZeLps1x1/rkWiWfRm/oo346+7qAuPlidPLJW703beA4
	 IpReJxt6foswXfZTTA73R49kBICsv+JvyAAUM2IV2ZlgnL37LcD+apfGrxPlHq2spsnPb
	 3ZJ6GiKNbLwD84R2UdwGsf0bF6f3m2zQEfG2FZ50Lq5PQL6JSi0kavh463aTag/ulLrkC
	 lrw0Pj684YRj+I4afNHpV4Qerghyo57FSGIiZNUwIBDS6dJ/CJZ602d0uYeQLl4xFPnit
	 +iwEdcZ4UR921BgO4MwSk5a26gkMjtXyHQstGgoXjvwRgi4QuinpA63GqgZU97wuyrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ygwKoEyoVjnhquCN3otCyziwDwMiZJIsvjE5Y1DD5H8=;
	b=OWAMXfZubtWKdvLhB5HOtGAXzEg2UwufnYCCq9qRg4nVm0KoVBXb+cS7NwY7WwKv1nAU
	 c9uC1gWF7ahDFurX8fpRxIxERAWWn5zwMbg7pfs4lgHUxxkS2SEP8lEQ/VSxNY4fZI31S
	 OBRYGFwuTafuwFm1ybhoKu9Gtdk0P/wr6aqZpSaTw+aTtd1VLd2npIZZ7R96wfrUR1XzX
	 otV2A9w7D64hTAzKn1Likph5UgPvq9ptjJ80RLPHo3FYMDToF7xGGjmwtmVef9+72a6Vk
	 lBlmnTdMqZao0fKXHI2xuqc3JD/V/67kL72Ld5OTiGZ0xTwblW0UX5GrVfslRe4D49g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537177;
	bh=ygwKoEyoVjnhquCN3otCyziwDwMiZJIsvjE5Y1DD5H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+FRjfuMmvP2UPa2we0Udr4PD2+sP2PGUwPSTy45p7Sm2NSKSr74kZYyeA67gxBDv
	 1SZf+x4r08rk0okqgqUltSa4hvaIG8mC8JhTeAL8KaE1bFub9Mz/m3+bIIFltAJ7B+
	 nqB9cnGzgCH7GYRA4f9XVtzrf83V0qNOfeQAxc1bx7Y12hC7PKbRq1xFX9NHZHKLbJ
	 2fJDNycylFdrVZ1sJeq/Lfzdl1rHbUX9ryjq/kznAsVmITdYgljyhwUdIOj9o++6b6
	 A9RcdxzgAfgd+awM/EvGRbrv7o5kC+tc7LAmX1j1Xu+GzoybPd54n4Mr5jT6TV94S/
	 GNPaWFFZf8dhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3728D60E22;
	Fri, 13 Nov 2026 02:32:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 121F02E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC4B881496
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-zkZAuXMApe for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:32:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 81FB38144C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256
 header.s=2025a header.b=KwlKIuUy
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81FB38144C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:32:54 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 1B7EC41243;
 Fri, 13 Nov 2026 13:32:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygwKoEyoVjnhquCN3otCyziwDwMiZJIsvjE5Y1DD5H8=;
 b=KwlKIuUyNyjYJDfpD7ZEcHPp2n7mptOt3TVPov4Y0WI4C+uMH8OF9pHLiHSOKwI1cfqmqz
 /gw/XIdzTK7aDPa/z7aBwowMrkAHeFEwIqUREcugfeASFSTopsnvthNu++RHnmPgv2H1LI
 2EHHTo4JLXQDUZPSGXQB5InB1Ry+Q8dPGJ6eriq9PvcD2O+bpsiUQHSTFO/oNChRXJZZgY
 PfJDBE4emo/p4gdRR+CojGN5ik6lekCi9UiMVtMbqntwXKSMPZjqOdOy2bHNKVu3RTALfm
 X+9bTiLhTOTD2YLhxKQPr5ERstqQSMD+HVUXmY4aL1qoNdxxiBYWhQnvSTaBLw==
X-GPT-Reason: legitimate; the email is a technical software patch
 submission that perfectly matches the personal mailbox of
 alastair@d-silva.org; the From domain (d-silva.org) is consistent
 with the recipient's domain and the sender's identity; the content
 describes a specific Linux kernel regulator fix (AXP318W ELDO
 voltage mask) with no signs of marketing, urgency, or phishing; no
 URLs were present to indicate malicious redirection.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 01/26] power: regulator: axp: Fix AXP318W ELDO voltage mask
Date: Fri, 13 Nov 2026 13:32:11 +1100
Message-ID: <20261113023236.569054-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On AXP318W, ELDO1-ELDO6 span 500 mV to 1500 mV in 25 mV steps (40 steps,
selectors 0x00..0x28), requiring a 6-bit selector mask (0x3f) rather
than the 5-bit mask (0x1f, max 0x1f -> 1275 mV) currently listed in
axp318_regulators[].

Fixes: 71f07932756f ("power: regulator: add AXP318W support")
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/power/regulator/axp_regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
index 16d3a8f7f90..e425f3bf8b2 100644
--- a/drivers/power/regulator/axp_regulator.c
+++ b/drivers/power/regulator/axp_regulator.c
@@ -227,12 +227,12 @@ static const struct axp_regulator_plat axp318_regulators[] = {
 	{  "dldo4", 0x22, BIT(3), 0x37, 0x1f,  500, 3400, 100, NA },
 	{  "dldo5", 0x22, BIT(4), 0x38, 0x1f,  500, 3400, 100, NA },
 	{  "dldo6", 0x22, BIT(5), 0x39, 0x1f,  500, 3400, 100, NA },
-	{  "eldo1", 0x22, BIT(6), 0x3a, 0x1f,  500, 1500,  25, NA },
-	{  "eldo2", 0x22, BIT(7), 0x3b, 0x1f,  500, 1500,  25, NA },
-	{  "eldo3", 0x23, BIT(0), 0x3c, 0x1f,  500, 1500,  25, NA },
-	{  "eldo4", 0x23, BIT(1), 0x3d, 0x1f,  500, 1500,  25, NA },
-	{  "eldo5", 0x23, BIT(2), 0x3e, 0x1f,  500, 1500,  25, NA },
-	{  "eldo6", 0x23, BIT(3), 0x3f, 0x1f,  500, 1500,  25, NA },
+	{  "eldo1", 0x22, BIT(6), 0x3a, 0x3f,  500, 1500,  25, NA },
+	{  "eldo2", 0x22, BIT(7), 0x3b, 0x3f,  500, 1500,  25, NA },
+	{  "eldo3", 0x23, BIT(0), 0x3c, 0x3f,  500, 1500,  25, NA },
+	{  "eldo4", 0x23, BIT(1), 0x3d, 0x3f,  500, 1500,  25, NA },
+	{  "eldo5", 0x23, BIT(2), 0x3e, 0x3f,  500, 1500,  25, NA },
+	{  "eldo6", 0x23, BIT(3), 0x3f, 0x3f,  500, 1500,  25, NA },
 	{ "swout1", 0x11, BIT(3),   NA,   NA,   NA,   NA,  NA, NA },
 	{ "swout2", 0x11, BIT(4),   NA,   NA,   NA,   NA,  NA, NA },
 	{ }
-- 
2.53.0

