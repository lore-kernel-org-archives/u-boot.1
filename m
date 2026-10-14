Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D4ECC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30BDD80E4F;
	Wed, 14 Oct 2026 14:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jQo4cP1aWezj; Wed, 14 Oct 2026 14:34:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51EB280E47
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791988445;
	b=HaApmyHaz/Fdit7uVB4bp6pPag5tnda2Sb2osk0EJdUJHIQvctvAOAnL2OvOf0jgzNEo
	 yJTpeLPiMI4Zl7N/NpfY8enws0XStozkSKASYXkbtkqnVEDfbmR3PnO0uAXokp51/o6FJ
	 j5J6+mwzPKAVp3E3XdFaj5FJ23JPYMUqeSSjzC8hS8dvuwZZywq6QzXHwZqjyoZY04l/V
	 X05E6KR7fBLPDUBz7dtqv4yrLSZOMIpe2TXVilO6eis7X6gpmZldECKGxrBdukk0znEJ+
	 6455yQjukrSZTCzi/gmyAF7Ow6MEFVBcKn+6YUnvm4iANL+oZsUoiepKFXIjA/Q7VFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791988445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L4rBwAYUa71GIhZj22mu7k3ek2nI4ne5//c1R+8Q9VY=;
	b=dSQSQOwlDWKzliuYk/Z1Js/VPH/y992okQVfQ7FuM3KBUNqlJeeT0TruoHf+wJ9oHWMk
	 AVl2LA/PlAJWTShcNDboCeef4a7ifxUQivd9QCKy4vggZBOlPUQjyxgDXbRLcn5V2jSVL
	 AsuBAa0LL06hRa2Ler57sr9gOUz5wvK1JeSXKpF0lxkR2oIF48AQE3Tzwu0CBahGMMO8S
	 MQScmDb+1fEPFrfo6RQnTpdpmJo+n0nOEkY5R7md6I4JGktzWCjRskXOGxE9lBdUVE6QP
	 ghv3n21dyyjjeOl7keClvFt/XCS38N50ug9uiKwHopqOaFB9bx9vfSXW9d3DPLg+KSA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791988445;
	bh=L4rBwAYUa71GIhZj22mu7k3ek2nI4ne5//c1R+8Q9VY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I4JmO1spb9bGXcgaxo16BeY6I9EHz/1EA4aqw4ft956JEYkliEgrlFJKfMhjK2tDI
	 KfMfraF3laM9pb1nb0opebgTj4+fIvt66bYhTyig5pXfYw/c52aKa1qk48WAj6EP8R
	 +JKjHW5QUBCaJRrdVu46USmMSbSg379ZDbtP4Om1qZpKT6qw3Y7IgNXVXXDhdU6BBW
	 fIB9ZpCtmQmuLoPCba6j3dFc7BWKEDalzZFQ7opSXkXXSTwZrXUsjBaqCPJVAI0IM2
	 vBOIiWEiFJF4bqpki8MizP5pnVeAibS18U1ZV60Z8QTNFR2TRfpNfg7QNzqdcT1Py5
	 HE9CZqtgy2ESg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51EB280E47;
	Wed, 14 Oct 2026 14:34:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C12E52E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A777D6083A
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4FToBj9_qXmv for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:34:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 45CF8605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791988442;
 b=GLlE4FwqGZO9HgZuLndu/5Qb18AZ074o/F7YV+bxJG/vK4+rfzYl/jzs3dN6LoyIUn6F
 CTM23TyLGfQkmb2IpL+CiD/t45kgAU7zC64u0hLQoviR8N5BtAD7Kexz7ItbMxXYcHEhE
 BZOUlRI9IxJStQsH79DFV3EAUxCYHkP7Bk+gwPgxsH7TIcGv12zBmEpi7E//R9qsnnnYF
 aAVphIrNX9pVhMtg57+pYWp22mr7W1lrP+5HislOWkm3H6jdELp0ixf77y5lZkevdA7AS
 xG8E25zmoVxY+qVDL/NGqTk3u5gMEVPDfwsO3wgHv/lOZfilX363M+lPAo7G/uoGtaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791988442;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=L4rBwAYUa71GIhZj22mu7k3ek2nI4ne5//c1R+8Q9VY=;
 b=BjemLnylLBJ3dYBfipYt8FjC11cXzL47rZnxlB6bPr5NCp9HU22o/kz6tSoJfHVH9qTb
 kkJlAnbCOgZB0ny6OmeZGlMm6ikamF60Yklu4WUcoZnKuhjDi5df24zLpKx7gbZYUBSU0
 4n3PJt5eHmz2icxJcN31KRzwXe8ExB20BfvNK4B23dyQ1deTxRGhpFVoMXwT+xYczPwDL
 yUsMBiQ6h5ccpqqR0EUGr4ATphPf2sdiCGZrZiv/awNyDMYJ6txu/snc7nOkXScenWB60
 nELkB+7PDBhifmtMawm5aoZ/DinE43Ls6G0TWsRxPSs3eVboP9Va4L/p4LdnjjBA5wg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=phytec.de;
 dkim=pass header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=luV3U3ZG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=luV3U3ZG
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45CF8605D6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCOYcK6xVQAACacXwRj00jW7xjEug56Kmiw0GKxPR9uPap2+s/+qCvVhv2gawsZjhplMqyNC4dudcModjXa57QYZeoHkpnx6sGIDjaOTvbLaxG0lU1ptrvSu4INOr2zvPCD8MWfqjLKaGHF6NK0lC2hgfd8CaflPgecPamYnQRPi4wXUGBQ6BjtRwZ8pSP9EiJ3BpssVhoShL/xW/sO7x/7Uj0yWcXdGQYX34CBsZXWNGdf8/toqC/WuGLlt7az3CxtwBV2pFNREahwJJ6FQHU/kljxzubdqmlJtUKBrMc5hQzoWsQt0cGnEy19QgBcECKI5202i3tPRy3cBa/cxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4rBwAYUa71GIhZj22mu7k3ek2nI4ne5//c1R+8Q9VY=;
 b=JLSunYqPuoF+AsIw0KB/9ur20PQiwXD40O1xhF+QwxpSCI0l6QYWH/cs8ZsTKSMSu8K/oZRwTMaD98C9qYi/tq6yOE7sew5pX0ZS0zA36PMOYs/3QejhwVAj30WvwGAtAhQghzN3pYv8HSHaUO/yJQcqrQ9p1y3dDfBDG23IaO7J/pkAh+ehbvvAIi7s9yFt/5qXAux8yw42Nge2GvceDvss/4sHt3nDew5hbSfIpsXzgx+hjLzHFxaLi6nCS0lHgLQwBapbqDGykLT67Ofq6OLTV4qgY5w93oh7gU3Z84HQ31GXHn7zMqBrScN21aQZ90uWS0sdfUFFN3v1YCVy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4rBwAYUa71GIhZj22mu7k3ek2nI4ne5//c1R+8Q9VY=;
 b=luV3U3ZGtgqhu0ukW81NJSFlDB4vXp1/IjMCCAyc72DEafyCN6o2GOlxISY0ef5nqxSavTSmNSaGgeAgN0rOS2IpHauA30KzHp3xw2SRgzrba9flZakGsVBV0NY+eTT/nio764GskfiA78CKpJv/ep7CTul/INTl9kxChVs0hT+Hhy+NJGI+85M+xqBDzmt0CflCm7tOJNADrszFYT4dZFpXq37mcnW57IE5biAWlyHrzAF2C9NXwa18j5aYzQxCmEtJVD704LFApPRhal5N7S2GLr3vDwnhh6UXbhBbeDjFXwgEFMINlVv4CdWj7WLqUD8xQ/V+ScCr3kjrMjaccw==
Received: from DU2PR04CA0324.eurprd04.prod.outlook.com (2603:10a6:10:2b5::29)
 by PA3P195MB2810.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:4ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 14:33:54 +0000
Received: from MA3PEPF00000407.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5:cafe::2c) by DU2PR04CA0324.outlook.office365.com
 (2603:10a6:10:2b5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 14:33:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 MA3PEPF00000407.mail.protection.outlook.com (10.167.241.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 14:33:54 +0000
Received: from ubuntuvm.tail7493ff.ts.net (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 14 Oct
 2026 16:33:46 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@0leil.net>, <quentin.schulz@cherry.de>
CC: <kever.yang@rock-chips.com>, <anshuld@ti.com>,
 <aristo.chen@canonical.com>, <alchark@flipper.net>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 1/3] fdt_support: Add /chosen/bootsource fixup
Date: Wed, 14 Oct 2026 17:33:26 +0300
Message-ID: <20261014143328.3135006-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014143328.3135006-1-w.egorov@phytec.de>
References: <20261014143328.3135006-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000407:EE_|PA3P195MB2810:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eabd174-75be-4eeb-41f9-08df2a002c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|7416014|1800799024|22082099003|18002099003|10067099003|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: ccceNtzIbEuq8TeEmg0T/wW3lJ4AlB3Bsv7ttyXe3yOeIeNOZ4ibs1WbVEc8oPxu1186yWCA/EZOxvhQ0c4RwnxplxEDsvrVVlIVB2H+QlgZLfV0RDlkuADv5YNkOPww5UOiqVAAQUPRbfnx3idrIASV+I+T7peYuNIPxzMWb9mgRnVceoFceSaORMCyVpWsj4MakTD3cV1buFPKPuK23Cz3u3RCZxUvw6cOEvefs/B77y/r233gDsTZKeJBemZqc6gmglKmXlht4xLtCSWlmd7I/sPF0WYbbTfPGYEBWWoPmd9ldhaCy/3eC3ZesVCBArwuJ+E65aYPSw0Zjpeuiw5/rJM8kw+vDXCSg+DHbdvxbIRL6Q9pbaLBdzKTWMw9QQeqtz2mgHEVqiUQL3YwQNFMgNloVakSSqT3CN7i7JRCKHCBo/MC0OeHDhw1GVuFfoYYtZxNEfFolHw6iseV5dRuR3u/sDBwi/m8W72jtv2W2r8fNlU/1k1LitsX+1nDxUCywJv3+6QtRBMOLCJUIVEOo5oBVVC+B3CXTciV7049jImUtDDZbBqvkpcpWZn4AR4gHrQxIPeryoCgKS1RUI9olU3tg+qiO6bm4Xn70UlnOhZbHtMoB87V1GGSpbyl5BUU53wrLY9+jFOO+YhqCxV1IIonHLLfER/GsC+Ft8TJKhygPCP2wM/ZA4RGYZ1DzHb0mKJ79phzRkHll4hEkw==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P0gIMhXynhbr58q4xeWLd1qULT8PSjovUNi4qm6BGXe/jrZu3DAYbTeEJqyLyQdIT0DMgCrNH2TwM1V2zZFLM8NtOQCi/+jhbGq9VWj9gBEfNrJAi4np3znBGQQvsRQIK8VPGOmzBB5jHjJ6VS+XrhjJzScvL+S/tyUVElEyKusnXMwm60ya6ufaCjkpaVAX3kDZBLa+8aYlfc92Ps4kKNNZNDlsCActi1Y2ZfqLcorU7bwb+ceay+2OUGLeUJJcaz/TtxbWKlenOoloCMPn1tuoB46mV/3M1Ew1pTd97MlhtiwzmODMBK9MCYk/xVOECgYZIcujzvMmABmvqZ6pYT5BXF1JX+HbAJ/jlHDTpqndrk4zyGBGCijO1x1qSoztGq21T+7GdX2F6l8skJbZ+xr62ma5JVfjkIuUn/HjDxhvtaY0v/qhmtSFyVK31zFo
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:33:54.0024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eabd174-75be-4eeb-41f9-08df2a002c42
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P195MB2810
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

Set /chosen/bootsource to the node of the device the BootROM booted
from. Platforms provide the path via bootsource_get_ofpath(). By
default we pass on what a previous boot stage has set in the control
device tree. The property is only set if the device tree has a node
at that path.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 boot/fdt_support.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/fdt_support.h | 26 ++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 2941df55996..0d04d6f7e9a 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -334,6 +334,46 @@ __weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
 	return env_get("bootargs");
 }
 
+/*
+ * By default pass on what a previous boot stage recorded in the control
+ * device tree of this stage.
+ */
+__weak const char *bootsource_get_ofpath(void)
+{
+	if (CONFIG_IS_ENABLED(OF_REAL))
+		return ofnode_read_chosen_string("bootsource");
+
+	return NULL;
+}
+
+int fdt_fixup_bootsource(void *fdt)
+{
+	const char *path;
+	int chosen, err;
+
+	path = bootsource_get_ofpath();
+	if (!path)
+		return 0;
+
+	/* Only record a path this tree has a node at, so it can be resolved */
+	if (fdt_path_offset(fdt, path) < 0) {
+		debug("%s: no node %s, not setting bootsource\n",
+		      __func__, path);
+		return 0;
+	}
+
+	chosen = fdt_find_or_add_subnode(fdt, 0, "chosen");
+	if (chosen < 0)
+		return chosen;
+
+	err = fdt_setprop_string(fdt, chosen, "bootsource", path);
+	if (err < 0)
+		printf("WARNING: could not set bootsource %s.\n",
+		       fdt_strerror(err));
+
+	return err;
+}
+
 int fdt_chosen(void *fdt)
 {
 	struct abuf buf = {};
@@ -353,6 +393,8 @@ int fdt_chosen(void *fdt)
 	if (nodeoffset < 0)
 		return nodeoffset;
 
+	fdt_fixup_bootsource(fdt);
+
 	/* if DM_RNG enabled automatically inject kaslr-seed node unless:
 	 * CONFIG_MEASURED_BOOT enabled: as dt modifications break measured boot
 	 * CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT enabled: as that implementation does not use dm yet
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 47b8b63d13d..72642dc401e 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -55,6 +55,32 @@ int fdt_root(void *fdt);
  */
 int fdt_chosen(void *fdt);
 
+/**
+ * bootsource_get_ofpath() - get the path of the node of the boot medium the
+ *                           BootROM loaded the first boot stage from
+ *
+ * Platforms implement this so that /chosen/bootsource can be recorded in the
+ * device tree handed to the next boot stage and to the OS. The default
+ * implementation passes on what a previous stage recorded in the control
+ * device tree of the current stage.
+ *
+ * Return: full node path of the boot medium, or NULL if unknown
+ */
+const char *bootsource_get_ofpath(void);
+
+/**
+ * fdt_fixup_bootsource() - record the BootROM boot medium in /chosen
+ *
+ * @fdt: FDT address in memory
+ *
+ * Sets /chosen/bootsource to the path returned by bootsource_get_ofpath(),
+ * if that path is known and @fdt has a node at it. The /chosen node is
+ * created if necessary.
+ *
+ * Return: 0 if ok or nothing to do, or -FDT_ERR_... on error
+ */
+int fdt_fixup_bootsource(void *fdt);
+
 /**
  * fdt_initrd() - add initrd information to the FDT before booting the OS
  *
-- 
2.48.1

