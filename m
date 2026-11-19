Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF6606A326
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a0h5W/8Q;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=IbQqDnwz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 183B981403;
	Thu, 19 Nov 2026 15:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qw9wrnhQcCzb; Thu, 19 Nov 2026 15:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 555C7813FF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103669;
	b=f/CgRfuBoZk2jlDROgsieF3nobV3LWbcTsSjt/RZ1CbQSol1ZvULC/Xy+/IQBRQ6+emS
	 rfxrQhCgGgHrRRRFUzuqo4qWb7QZcMJ6NpGPYwbzdVfx/5v2CAOn+Sj5JUd8/1Dsk0W7X
	 463cHScZqNmphNZ6fH38iPb4pXQXvuTXN5cmkpu3x82cnJ9K9w7V3V4z68zwD+MLTZNJn
	 CQKNFrTeItFopHIPcqhVpZJEWbs//1Bg4KTedP3omURDV2InPAC/OCJJOa28lYwXgYkLO
	 BgIec+yhgMXQkGQ/v0F6DGaC3wpxKA3m8FMNpkfo34DWPuc4SyLkqIl5h8gu1awyhFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qukMxP6aHWaK402MEmxg0rfKZ9IPrO1h1aQDHOur1rc=;
	b=kIpai5rbeO08ABqiWITgYv4/FO2KozFWhS7Edq61/nui2U52e/8s7HHZfjWLykeEzJgU
	 o/eU4MC9bHJNkoIqm6wxjTaA9IhqvCdfE7hvOHmtGoDQFLe7Y1b0IrjjWbjZPzwI+zPXR
	 f+ON4vo07bpBW2NEKwHsG2TLzywCh2PsPk41wjV5vaAalXly49dXU+KJyZMqDLUtEpSLM
	 tifhkbtlAxmxogGvSw4+1+b1sIhU5HBKCopGydSLIe4CkdznCVd3fxSJOR+MCZC/qvhas
	 smhbkTzv9aOsgHPz8WDBWTrqB4DFe5BE8vzKcDQmBSIqqSD41cQuMiz6+cLweny9baw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103669;
	bh=qukMxP6aHWaK402MEmxg0rfKZ9IPrO1h1aQDHOur1rc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0h5W/8QPJFc4VmwpEbHkYPxiPi32hk6R68EO3u8Gz382i1M4qUELdEsb5ffNMZxp
	 kDbiYEWSkVZKvQ5USvZlWBemc/F/sLOZepPhBXxM75Yf9jPQjXrh5JNkpMCW4GjuPI
	 5EgClcq5OVgaVp7QDbLOMAG/9JbvkNlJxfB1+uATb7mP9lwa66ubfMCbtmWipFWskQ
	 IV8n4R9xnfxSuOCp/sIINvi+6fYvDqWYTCmkUmwEBCkHtXKS6QXV7ZItRRLFP269D8
	 Ql6EoQnNiL3gLc//it9s+C0lPbJEvt73rC/tSBcm+pP6N8EXXcoUJhbsJugYbJFtP5
	 nvj6WazNv9JRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 555C7813FF;
	Thu, 19 Nov 2026 15:54:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B75A61C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A90F640544
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id szZE_eiUIbNd for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A23AF4052F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=t.schmelzer@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=IbQqDnwz
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A23AF4052F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qukMxP6aHWaK402MEmxg0rfKZ9IPrO1h1aQDHOur1rc=;
 b=IbQqDnwzb00lztVZtwXDQ/S+1FuIaPP6OYPtv/wGMQyUKDojY7W+6wfcv+j7GP7b7BYF7Qp/isr5Lav+I9CwM3MzZWIy5TCYGCQw4zoYsSWJ7i6y5abmoKBSSdOcnBC4wNwxDmXwVXGt6GGtcb2ZneoUmS6YlG96hcZTcI9NsM8qhqCTzjqw1cc4rYoDMGMoRzoCAfmlmaJqFwO0rRA1LMLqz8/3kN8aDif4WYhJZV5O4AbDTOK4JeBJsYoyvCpkmZiraCOrH5iBYAYh4uX40+cCtVF/dJrAMqdq6UUh5tmF77BFGcK4GZKNIq8qudRCSeNRHv0sRliIlUtvXmmfyQ==
Received: from PAYP264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::23)
 by AS4P195MB1742.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:519::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 14:12:33 +0000
Received: from MI3PEPF0000855A.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::21) by PAYP264CA0036.outlook.office365.com
 (2603:10a6:102:11f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 14:12:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 MI3PEPF0000855A.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:12:32 +0000
Received: from [127.0.1.1] (172.25.32.137) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 19 Nov
 2026 15:12:31 +0100
From: Thorsten Schmelzer <t.schmelzer@phytec.de>
Date: Thu, 19 Nov 2026 15:12:13 +0100
Subject: [PATCH 1/4] arm: dts: imx8mm-phyboard-polis-rdk-u-boot: Add usb
 entries for SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-1-dd6db9e5edfd@phytec.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <upstream@lists.phytec.de>,
 <u-boot@lists.u-boot-project.org>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Peng Fan <peng.fan@nxp.com>, Yannic Moog
 <y.moog@phytec.de>, Benedikt Spranger <b.spranger@linutronix.de>, INgo Rah
 <ingo.rah@linutronix.de>, Thorsten Schmelzer <t.schmelzer@phytec.de>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855A:EE_|AS4P195MB1742:EE_
X-MS-Office365-Filtering-Correlation-Id: ed87e45d-d141-458a-cb8f-08df4647277c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|82310400026|23010399003|36860700016|7416014|376014|1800799024|22082099003|18002099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: bYMBnHUkWArNm79CERCmWcACl8Njvs+ee5kRP3aTFtbwWTLHbD5TURI4vTQ81YVMFZPVpOmgvV7QNY0ZNlB1LlUreBA2w46WIprhlEmfHFYtf0UZlUf2la7P0aO6bisWL32rUKSnUZnz9UcPWLuomyVJEoFJYCWhvKKWzG+5x4T/nPGjLuUOwer4lhsVK1PLC4cvf1ktjq6rHzqbXlwI0wwVtWGT1RZtSrD8Q4M3UZ7hmbyPRXiSuOpuSOyEwu8TZJdDE+w9wyY5n4aco2hPeD0yfu0wrpOeAbbf4n3H7YNMkF3pTqeNeyOts7YjpZHcXTbsZeY/MKU41WPPu65yx6+2p1z2IbsIKFDs/I3jNqynESKfTNzyp/g8MOxIGWQCyLalnSn1tKDYnaeQunYUPaQxghSPPi3VmPlT17qOCAk6fyHRoxwJy7QuPaQXyCwvv3MfiSeAkFh2vjeeuk1K0z9PHM5KO2/MzYAtMYuScAkQmScHSKkqW9HRbWUBybyVOgMupZ+DqFHNqKdbyC734arhMBkekrnzz7hiio/UIavxHSIzJqRCDsioquhYiuUns0PV+QAwMRXPBljZCOpPJyEAYVfeYe1XVJXkf0MKvAhk5HOfglcdtRkjeNwsoFa0kA+aaZPmstPcgOp9h3o9MWQivdw7zYhYMLt+dqIXdDmElfPBpqzzm8WsX2uGijpcYo0UXaoXEtbfRgG5VTmEOg==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5nw8bLGBFH88q892HTz8F7jidNVmXA0kHqL9YGcXxbgsd3vJ9jZcw74Yz8P7xcFbzcegM4zVxGG7W7OVmpWVo/3cwkPCpF2W0k/C45z2VEB+kdO7nCdYay1Z8Jw9gkLDGtNczWeToWA2jmSyU4I9NJuRKVBIvdYfxyVP6Qs3plfPStqpWsBjRLIOxTtB0Y604iahuCWMh131tKnVTrVOgFCKqfkM94ZdhRdkY0MO8hPwikV5K5Y9cGtAaHfFTITedA4HPwyH+zNBhHujrsEoHZFnuCzJNqDWYWlrEiCpZo9U1H+X3HNhDdJMKKa0STaRqVgzNSffjqs6xRvWX5Nr1OjOEapVcvIxv/yjy5NOt6JeUG2zohMFJ8KIcznVKoC8uxUUgfh9hWgW04jGXpN8azD3iPQli3+hR2Fbv+OhnyKAzTTHyscHO4e87oMGDlL+
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:12:32.8496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed87e45d-d141-458a-cb8f-08df4647277c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1742
X-Mailman-Approved-At: Thu, 19 Nov 2026 15:54:27 +0000
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In order to support the USB serial download mode, SPL needs an activated
usb controller to chainload u-boot proper. Add the necessary entries.

Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
---
 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
index 143ce6a6d77c..1d2b456b623c 100644
--- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
@@ -82,6 +82,14 @@
 	bootph-pre-ram;
 };
 
+&usbotg1 {
+	bootph-pre-ram;
+};
+
+&usbphynop1 {
+	bootph-pre-ram;
+};
+
 &usdhc2 {
 	bootph-pre-ram;
 };

-- 
2.53.0

