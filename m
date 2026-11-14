Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6C606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wI7tzTnt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZnrQULF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8451540EF4;
	Sat, 14 Nov 2026 04:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xsPG0snbHM0z; Sat, 14 Nov 2026 04:05:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C997A40EDF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629119;
	b=pftLx1pGg4rxjbIQ3F30c5NlIhLNy24izCtCJlw49GtGBn2y0SI7F6qAXuJb34ZIYPzz
	 kriqqI64/dqvC8/NXVeE8eH5hFlSuJST6W2Bun/ImLM3CtGOQGkHhc1aMrAjnhnEsS76f
	 tXL9vPhenmlUqRr2Y7X+xZDRBHiqkspecQdOv/IZZaY23jEjy+RemKIswAcLT867KXjct
	 zo+9xlaqJBD+sCfklDd6QvhKPuHpnCH5KeYRkpiR5Ic1BHp/bVOeNm7kf82hH97UwQHyt
	 tVzMme1BmY86LBSsyBKUfyaDVZej2B2uGSTIuqP5rP6pJRBhqgs6sR5zsE7AnFegJ0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629119;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jarkWIyvqd3RPClba29h1GQm0GEIpN99i6qFnUxvU8o=;
	b=PL0trQixl0ugnpQHFRf1SPq1/RzEOevwkGtn/9TiPmC1P+BwiI/I+DnXzGf7xJ5HQJJk
	 cgUDPEFxe8uVelrgc+CeAX96Mp6yqTZFyiJ8s3mtylnwtdnMuRgpdT1EM4zRZQTCyw8AQ
	 UjGtX6j1aJZLMST8dOKa5xv5N+fzqak6YphLGPUSsYGmYG84y43+cmboUDYrHyg7dSKtg
	 2vtMmeb9WwXUeqnyp3Gm3pzdf1G2pFR1467L4mTK58Oo76yT3inr54ZjD7Brm1s7A++A6
	 i0etz81H4+vjrk5OjYirhMsZLi0oMOEBQVTw9FXosb/q5jcAMFW+LOxXP6tVAwZ3+0g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629118;
	bh=jarkWIyvqd3RPClba29h1GQm0GEIpN99i6qFnUxvU8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=wI7tzTntmeEce1CrTfMi21NXElZfl74Pha07KYVZYRLyJ57+XAyd/JZvUDqc4D44V
	 P1kufrshhHcxnNiScDCAkagzO1fAU8UdYAyV8kLyZLm7vEtJzMvAUZKV9i/gA4+A7D
	 96M0JAzuiehWUHS5TzG++op1qSNmR1DMPjaOFkw8ZCFWctAXeHZTiq3t3/5bMq71Zf
	 qiwDUrkIaeY033tTosa6Frluk+GeqX3/JWgLKS1LDK2e7lfJKxalR3cp0m4ezQ+nE+
	 mBarzO7k3dpKQdwXH/gIRuzaBv2FEoT66NC8b9gt1guJ1xK+xSsm0DXpMPJ+KMVUnH
	 2Q0xznzALk/Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C997A40EDF;
	Sat, 14 Nov 2026 04:05:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A4BA150
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 799E94025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1PsZsPhTS_Ue for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AA75340277
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=dZnrQULF
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA75340277
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2C4D46412;
 Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BAC491F000C7;
 Sat, 14 Nov 2026 02:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622937;
 bh=jarkWIyvqd3RPClba29h1GQm0GEIpN99i6qFnUxvU8o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=dZnrQULFFKyDkMUxtK1X+j9fpneZU4rV4PdCZlmyroZLBuqHe8I+4Q8WykxMEbBgn
 MzGEVtWh3kZPzgsl2EDPkMfiYjVFylZ3PHPLHfXwl7qQutmK/Gx+5mn2bvzfVQbbrq
 DsBpGdN49mNpOZE92tjsDfJTzO+UenO2cL6ScVrl1IAnH2UJRuIPZr1RpGi8eHfdkc
 F1Il29eR0J/9+tKtZX3GdQ+0h96f+Yu0kzgnhDZaEL95VQspuzNng5WYWwDifM5Y0E
 4QFtdqHlrYniiemPTLv0B9Ug2QjWlSaycdfwsl4tsI30GJs34zLOagJ1lldxws/AsV
 QmCCMUaf6OEbQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E93AF49C3B;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Sat, 14 Nov 2026 02:22:01 +0000
Subject: [PATCH 7/9] power: regulator: qcom-rpmh: add PM8350 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-sm8350-support-v1-7-414271f59474@fromdisposition.org>
References: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
In-Reply-To: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=2719;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=o11xhMMmB6mY8IarG7lDrkstn2uZB0UMxBV6J8TEYg4=;
 b=1YkwQ8/uoRfnnTHNvdHkrM15nqWeUrKT3BNZyzHpoGqFGSwRTan9pKnMo7LImvUpKJloBogil
 y6dlHDJ2Aa9AG6zFsK7IPNR7IKpBfacBsjDGpWgGqIJG/sW3SZs1cxB
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 04:05:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: me@fromdisposition.org
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

Import the PM8350 regulator list from Linux (tag v7.4-rc1). On SM8350
boards it supplies UFS and its PHY.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 5e899ebc20..28c0687f1c 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -964,6 +964,32 @@ static const struct rpmh_vreg_init_data pmm8654au_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8350_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps510, "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps510, "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
+	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
+	RPMH_VREG("smps10", "smp%s10", &pmic5_hfsmps510, "vdd-s10"),
+	RPMH_VREG("smps11", "smp%s11", &pmic5_hfsmps510, "vdd-s11"),
+	RPMH_VREG("smps12", "smp%s12", &pmic5_hfsmps510, "vdd-s12"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l4"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l7"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3-l5"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l1-l4"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l3-l5"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9-l10"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l2-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l8"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9-l10"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l6-l9-l10"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps515, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
@@ -1158,6 +1184,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
 		.compatible = "qcom,pm8150l-rpmh-regulators",
 		.data = (ulong)pm8150l_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8350-rpmh-regulators",
+		.data = (ulong)pm8350_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8350c-rpmh-regulators",
 		.data = (ulong)pm8350c_vreg_data,

-- 
2.53.0


