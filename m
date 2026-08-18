Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7F4C5DF67
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 020CB607E3;
	Tue, 18 Aug 2026 07:38:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lozq3lj0-UQL; Tue, 18 Aug 2026 07:38:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 113D260611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787038726;
	bh=35CAQEr+giSCIvZI7Pe8qolqQ5gmu01W47C3jWyOmjA=;
	h=Date:From:Subject:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dbMHo4hWeYVr/78ytU9kSqlUloFoa7L2Abh8hgvw7PD7tfcblDEtwIz8XuYT7SOao
	 cvOqoI9D6ChpCPbB1wPGmGPnDi+uRsGBoSQNuGu5v4vp1y3eAetmqkhBbGKFlTVy3I
	 MM+9kiw0P894TWYrpAYMjVr9luPBzAJMOEv0S5yruptYSBYN40mLTkmYq4a0mw3KRm
	 Noeo4qLLO66azYZyBEpvF/Nmo3BPBn/KkHXvjSmSNYzjCKDsjYoer542UtjgmuJYGM
	 fk+BFfdzk9Yyy++JfNZXoDfSUneqD2z1ONzzlZusRX8UVWDemicNs9uD35O531qbXV
	 S9yJk9woqg5/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 113D260611;
	Tue, 18 Aug 2026 07:38:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 324BE333
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ECFE60611
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8EA1Byy5EUO6 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:38:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=mike.looijmans@topic.nl; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 386E9605F1
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 386E9605F1
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=VvMjjdy2
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 386E9605F1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqjyTacUAkXakFWYLRBKUzLw9yeuS179HZmZStMdD1bJtQEN02FdfEM62LcTwmgB02ONJqkL5KDC5Tjah/OHZ3RtkO7nDhjgKVqXbJlfVJ1uLgrQgYAjLOUOd99QmBvHfT60eQE4YEUbxvDG2XVXh9KmV4Vuju8KSVRS7ZLX89shymFVMGIQMKNiv3X4BYzBhdZAfykMoBD8jQkrG5t1r2UF9V6SW8yQCCZHTgaVQLiSdMps78lzWlJ5/vTlBNTcastn5vTeFY/vG0dscnwcw/v0D1o0TN8qNBP5ruSJN0/xF4+YPKXtQROmKedMXpgPLNt/I0t+rDlwihtQ353yUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35CAQEr+giSCIvZI7Pe8qolqQ5gmu01W47C3jWyOmjA=;
 b=yn5IWrr+sgJrkVstNGhf+Nf5OCnzUEZmUGDOl8NNrd5D/3Rqiepyt/apOknE6E3b5yl2qbZvgl8T8r7Mp/x5Gh1AfboIgB/NgE2Q5onqgUuxdWb2fxtGFJv0taWd1ImlsuxDb+hNCkahmv+LWb0PB8A//T2V48rfSRFpty7zwQ5rxlJYJ5CT4o/jLQRTuZgWI6Ay0eRXOJ71PKd+nzRkiM/GoMcyLxZVcoe0mfhGXs1NzXGzb03VtdR+B+KSqZsm4I2+8n/3dWcCkDijHqcKeIweUZZ65m76Tk7Z3V2LhOPgqq3HDUwXfgVj4bWjdfH4/GsIyM+AxtKG7UGamqbX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=topic.nl; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=topic.nl; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35CAQEr+giSCIvZI7Pe8qolqQ5gmu01W47C3jWyOmjA=;
 b=VvMjjdy22vAD5sxDz2N+MnqwJB0ZITnkLSdSX8QqM13a0aE/5EtEDqoPAnqr6b5QVWlkRuPwkecjlLoGlPNaLGBqwFgSUITztmxb6uX8NG14B8QDLdcnuZXZqsKpEqMdECAHCdYq42Ac8ewfzfoP2ISe3n67cEuXMI44lP7F1fn1JLOR0HtWih5IIr+thoYXbz/5amp11V/BXFknQ1jwrFvON8bjQ0pzP09IE8HWZSm/GJjzJDcUE4JTvTXK65XPRGLBgY0KNATToI041OU3mmOTM3oOHQDB4rjgENwMdDn99EITgun8wteZHzNsp2MH4wTEd4lJaUYTDmvGVojTZw==
Received: from DUZPR01CA0199.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::28) by GV1PR04MB9184.eurprd04.prod.outlook.com
 (2603:10a6:150:28::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 07:38:35 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::7e) by DUZPR01CA0199.outlook.office365.com
 (2603:10a6:10:4b6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 07:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 07:38:34 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.65) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 18 Aug 2026 07:38:33 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by GV4PR04MB11893.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 07:38:27 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0315.012; Tue, 18 Aug 2026
 07:38:26 +0000
Content-Type: multipart/mixed; boundary="------------i02cwb1S0TaoAyDI3ZMOU2XD"
Message-ID: <34f26c7d-2fcc-4a89-8a5c-469ba80c9778@topic.nl>
Date: Tue, 18 Aug 2026 09:38:25 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Trying to get MTD_BLOCK to actually work
To: u-boot@lists.u-boot-project.org
CC: Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Guodong Xu <guodong@riscstar.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <d4ccdf2a-5825-42a1-8c07-1d4cb0460d73@topic.nl>
 <63d45ff2-aab8-47e1-bb00-73e8d6f1e44a@gmx.de>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <63d45ff2-aab8-47e1-bb00-73e8d6f1e44a@gmx.de>
X-ClientProxiedBy: AS4PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::11) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR04MB12030:EE_|GV4PR04MB11893:EE_|DU2PEPF00028D11:EE_|GV1PR04MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ede6fe-0301-4630-2769-08defcfbb567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|52116014|6049299003|366016|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003|4053099003|38350700014;
X-Microsoft-Antispam-Message-Info-Original: kEjQhTnDJdaQDpa9IGMx6ujUpCWp92ckUX6+RZ6FL8to90Ocg8tbeo7abWYwjyjFFKtGtkg5g3AEi1kiPoG4ECqypTqtDRGDvrPrxXNTOGvyr6Rwcw4mcCjMDLjLknUQozHiLvrc9gr7BEGlVmZuJlu8KIK4Uhdp0UZ8AvEu+VpOzABRkSJpMCToUJwtdR0c5569ca+DZcgXEf8qf4ePpdKl5EQC126lY9Z2DhRyyGBo10eBlf6eL6e/kWIS8QSnKfW0NnjdvJSifhYiBIIGx7rLMKjoKsB1JbOC2xyrznHSGIPKcOzPHsG07VMsOLWAKDt4NOxZGiiBFMhUP5e2FZWDC9mMy2gGntDndu0ex05fobdDS3aYrZQCoddV1Y/bO2BlboPkARGBkhXsJKaHLVbGnqM5UtveSNVtFHV0cwQXDlF4gSvlfWAkUS/VkT+bK037MMXfcg2StFhqLEA0n5ZsRvRTcAYlvoRibn8N3lleGdKJ3rfr8K9cXKguiqp7ny6iLIi9fzbpRqdSWONRRsbRka2Et0hA6RJGRNMrZtUFNJWQRSbMLfjQrSBEohLRzpCNYOu2bwqQ6jKYANvKb+VrFGo4rfeDWANBDNuma+GQDjoO3GNAH7Dig4a8TNCRBU75JEpndi1Yu+kdAfkD7lpORufJLv26qbwwOxhMniY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR04MB12030.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(52116014)(6049299003)(366016)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(4053099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: g6IcM0MxtVB0EgW0ilRlEsviTVvsS/dDiy3YU2hM0Rj9wBrqkKcwDARx0+u9y29uzlOEVd4LTGpQ2DrSsEsKWD9F6KQwRh9bCRSJYtaE65mzYJ3xv+zhGV2uWlL4y55Pmok8kwMvD+/xjAgTCKTpAQu4fsXsz/i5llO7WI5F+55iV0cqXm36S4vZH8EtNH27SKKgLUNCfZM7mT5lnPZGnl79aHH5B+z+YTHuqI9hbkZv801gQgGJcV9jmUeLQPUDsUhpw6NbEThpbzC6RErF4TwpUd2KzPdOitdtMnN16PBXYyKIqvikk8EzjpC7pUJyLYRPxmRCEg3MQcojNSaXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11893
X-CodeTwo-MessageID: 9566da00-7d14-465d-ac8b-e1178d7ef3ec.20260818073833@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5337880c-549f-4317-ece0-08defcfbb0d5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|1800799024|35042699022|376014|6049299003|23010399003|36860700016|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003|4053099003|13003099007;
X-Microsoft-Antispam-Message-Info: +iFpNPbuN/hLGjYX8/IjzvR56TvRP9xdsgJb1w8U8V7YTTAhZw68DScns909M1fqieAhPout1IaSirvkd0MNpQKfivfo1Gt1z+E07jStMl3fb/5H78PZy41LUiiqmg7AFyeIhVrs+yodusgEfdbaygU5cHetVRpM9f8N3PDeQ+vYvPlzpD5cmLmCwc3M8pgpXLfGUr7buG6BTKL97QIAaK3BjzrT45qdTOWjelAA0YgndcjBxpheqQX4pMtdFrEZsLc6ALBD3Awev/oAPsxeIzaCoZUtM01noQhnriDfphGW26gqza01aaFzflUc8aTkJYPskf0cMABJyhC8C6A/XxqKQpZisV16QciJHkJRR477yttRFXGHaVxTqb8f2OOKfkb9ZMR3mAsuU/r58XSFHvnIPEFkEG2zsInyXH0xcC3nSxyilacnLa64mBkDJfL+TEuk21cmDf47H/ulajp15YfYqx1UPM4MYk2kAl9ilYlID/5JvRiSRW64svsM8v8OdAfDzYOneeVM0xArcBBOxi3ZanIUOG5yRgbeaEH9GGYwIoYX3WRL/WTjWM+YGkLZdXxl0iGHYnd1oMGZ9XDX7poUD7QmlzAbr9ODsm9l0dKrfqPgzJ0xxdeJg7jnfw80UvkvjZwLJNVS2kRCNvMS2g==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(376014)(6049299003)(23010399003)(36860700016)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(4053099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2bwnphPcVDLbbC4SNtmnMPQVdKDF9PSM+qXvChkve7uBH0Rmtak0Ek0iQkIrWSIWLr4N2sBmhDBBYww7woU+3oDXAXeQ3AQwoaCQIoEBbhqkHlqHEkxCix0tUIrmqm2HiNMgwZL11M7wfOKNraOEoZDAkUxi61Ho/xvqeYfWPtF0UDarCs2t7prJRBmWP/bQu0Az/SyA50tpM5okmNTSEor9ME5dp40CE/BVUSXj4DeyivxBvC16KFs7HKecZvYaY9BjytOiLojdKFALQQ3tIT6I5VRLrOWwoEOS1VBJYkIoeavpsRHN+eqqTJyIZKtjTykt9vqsLQczS+GfrGMIu6G8iil4hEe99oDFzaT+XeDnlon/RytEgp26TsbLMD24hkK+HdFLBXwPoH9ZdVgrpYR7gPK2gUYfTySojDdKm/H+HxQMrf3n9DpsA7r777QI
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:38:34.2350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ede6fe-0301-4630-2769-08defcfbb567
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9184
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

--------------i02cwb1S0TaoAyDI3ZMOU2XD
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable


On 17-08-2026 17:55, Heinrich Schuchardt wrote:
> On 8/17/26 17:00, Mike Looijmans wrote:
>> What I'm trying to accomplish is to be able to read the kernel=20
>> directly from a squashfs partition in SPI NOR flash.
>>
>> This should have been simple, as SPI-NOR is an MTD device, and=20
>> MTD_BLOCK translates that to a block device, and squashfs needs a=20
>> block device.
>>
>> The issue is that MTD_BLOCK adds some hooks, in particular=20
>> "mtd_bind()" but the only point where that ever gets called is from=20
>> drivers/mtd/nand/ spi/core.c
>>
>> So even though one activates CONFIG_MTD_BLOCK, no mtd device or=20
>> partition ever gets registered as a block device (unless you happen=20
>> to have a spi-nand controller, which, contrary to spi-nor, would be=20
>> unsuitable for a squashfs filesystem...)
>>
>> I tried doing the obvious, that is, copy and adapt the spi-nand code=20
>> into the spi-nor driver, see attached patch, but that doesn't have=20
>> any effect whatsoever.
>>
>> I tried similar things a few months ago, and also had a discussion=20
>> here on the list, but that sort of faded out without any further=20
>> results...
>
>
> spi_flash_std_bind() is called before spi_flash_std_probe(). Setting=20
> plat->mtd in spi_flash_std_probe() will have no effect in the bind=20
> method.

Tried putting something together in an updated patch. Seems to have some=20
effect now. Some block device registers now, but there's no working link=20
to the partitioning:



zynq-uboot> lsblk
Block Driver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Devices
-----------------------------
mmc_blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: mmc 0
mtd_blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: mtd 0
ubi_blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: mtd 1
usb_storage_blk=C2=A0 =C2=A0 =C2=A0: <none>
zynq-uboot> dm tree
 =C2=A0Class=C2=A0 =C2=A0 =C2=A0Seq=C2=A0 =C2=A0 Probed=C2=A0 Driver=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Name
-----------------------------------------------------------
 =C2=A0root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 [ + ]=C2=A0 =C2=A0roo=
t_driver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0root_driver
 =C2=A0simple_bus=C2=A0 =C2=A0 0=C2=A0 [ + ]=C2=A0 =C2=A0simple_bus=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |-- axi
 =C2=A0gpio=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 [=C2=A0 =C2=A0]=C2=A0=
 =C2=A0gpio_zynq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0|-- gpio@e000a000
 =C2=A0i2c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [=C2=A0 =C2=A0]=
=C2=A0 =C2=A0i2c_cdns=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0|-- i2c@e0004000
 =C2=A0i2c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 [=C2=A0 =C2=A0]=
=C2=A0 =C2=A0i2c_cdns=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0|-- i2c@e0005000
 =C2=A0gpio=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1=C2=A0 [=C2=A0 =C2=A0]=C2=A0=
 =C2=A0pca953x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0|=C2=A0 =C2=A0`-- gpio@41
 =C2=A0serial=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 [ + ]=C2=A0 =C2=A0serial_z=
ynq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0|-- serial@e00000=
00
 =C2=A0spi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [=C2=A0 =C2=A0]=
=C2=A0 =C2=A0zynq_qspi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0|-- spi@e000d000
 =C2=A0spi_flash=C2=A0 =C2=A0 =C2=A00=C2=A0 [=C2=A0 =C2=A0]=C2=A0 =C2=A0jed=
ec_spi_nor=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0|=C2=A0 =C2=A0`--=
 flash@0
 =C2=A0blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [=C2=A0 =C2=A0]=
=C2=A0 =C2=A0mtd_blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0|-- flash@0.blk
 =C2=A0blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 [=C2=A0 =C2=A0]=
=C2=A0 =C2=A0ubi_blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0`-- flash@0.blk
 =C2=A0mmc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [ + ]=C2=A0 =C2=
=A0arasan_sdhci=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0|-- mmc@e01=
00000
 =C2=A0blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02=C2=A0 [=C2=A0 =C2=A0]=
=C2=A0 =C2=A0mmc_blk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A0|=C2=A0 =C2=A0|--=20
mmc@e0100000.blk
 =C2=A0bootdev=C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [=C2=A0 =C2=A0]=C2=A0 =C2=
=A0mmc_bootdev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0|=C2=
=A0 =C2=A0`--=20
mmc@e0100000.bootdev
 =C2=A0simple_bus=C2=A0 =C2=A0 1=C2=A0 [ + ]=C2=A0 =C2=A0simple_bus=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0|-- slcr@f8000000
 =C2=A0clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [ + ]=C2=A0 =C2=
=A0zynq_clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0|=
=C2=A0 =C2=A0`-- clkc@100
 =C2=A0timer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [=C2=A0 =C2=A0]=C2=A0=
 =C2=A0arm_twd_timer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0|-- tim=
er@f8f00600
 =C2=A0usb=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [=C2=A0 =C2=A0]=
=C2=A0 =C2=A0ehci_zynq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0`-- usb@e0002000
 =C2=A0bootstd=C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 [=C2=A0 =C2=A0]=C2=A0 =C2=
=A0bootstd_drv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`-- bootstd
 =C2=A0bootmeth=C2=A0 =C2=A0 =C2=A0 0=C2=A0 [=C2=A0 =C2=A0]=C2=A0 =C2=A0boo=
tmeth_extlinux=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`-- extlinux
zynq-uboot> ls mtd 0
** Bad device specification mtd 0 **
Couldn't find partition mtd 0


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



--------------i02cwb1S0TaoAyDI3ZMOU2XD
Content-Type: text/x-patch; charset="UTF-8";
	name="0001-spi-sf_probe.c-Register-stuff-at-ubi-mtd-in-bind.patch"
Content-Disposition: attachment;
	filename="0001-spi-sf_probe.c-Register-stuff-at-ubi-mtd-in-bind.patch"
Content-Transfer-Encoding: base64

RnJvbSAyZTgyMmJjZTFmZmViYTJiMDAwOWU4ODYzMTkzODNlM2ViOTEwYTFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWtlIExvb2lqbWFucyA8bWlrZS5sb29pam1hbnNAdG9waWMu
bmw+CkRhdGU6IFR1ZSwgMjUgTWFyIDIwMjUgMTY6MDM6MDMgKzAxMDAKU3ViamVjdDogW1BBVENI
XSBzcGkvc2ZfcHJvYmUuYzogUmVnaXN0ZXIgc3R1ZmYgYXQgdWJpL210ZCBpbiBiaW5kCgpEb2Vz
bid0IHdvcmssIHNlZSBtYWlsIGxpc3QKQ3JlYXRlcyBibG9jayBkZXZpY2VzLCBidXQgdGhleSBk
b24ndCB3b3JrCkhhdmUgdG8gc2V0IENPTkZJR19TWVNfTUFMTE9DX0ZfTEVOPTB4OTAwIHRvIHBy
ZXZlbnQgYWxsb2NhdGlvbiBlcnJvcgotLS0KIGRyaXZlcnMvbXRkL3NwaS9zZl9wcm9iZS5jICB8
IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9saW51eC9tdGQvc3BpLW5v
ci5oIHwgIDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9zcGkvc2ZfcHJvYmUuYyBiL2RyaXZlcnMvbXRkL3NwaS9zZl9wcm9i
ZS5jCmluZGV4IDcxMDBiNjRiZjIyLi42YTZmYzBhOTE4NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9t
dGQvc3BpL3NmX3Byb2JlLmMKKysrIGIvZHJpdmVycy9tdGQvc3BpL3NmX3Byb2JlLmMKQEAgLTcs
MTQgKzcsMTcgQEAKICAqIENvcHlyaWdodCAoQykgMjAxMyBKYWdhbm5hZGhhIFN1dHJhZGhhcnVk
dSBUZWtpLCBYaWxpbnggSW5jLgogICovCiAKKyNpbmNsdWRlIDxibGsuaD4KICNpbmNsdWRlIDxk
bS5oPgogI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8bGludXgvbXRkL210ZC5oPgogI2lu
Y2x1ZGUgPGxpbnV4L210ZC9zcGktbm9yLmg+CiAjaW5jbHVkZSA8bG9nLmg+CiAjaW5jbHVkZSA8
bWFsbG9jLmg+CiAjaW5jbHVkZSA8c3BpLmg+CiAjaW5jbHVkZSA8c3BpX2ZsYXNoLmg+CiAjaW5j
bHVkZSA8c3BpLW1lbS5oPgorI2luY2x1ZGUgPHViaV91Ym9vdC5oPgogCiAjaW5jbHVkZSAic2Zf
aW50ZXJuYWwuaCIKIApAQCAtMjE5LDYgKzIyMiwyOSBAQCBpbnQgc3BpX2ZsYXNoX3N0ZF9wcm9i
ZShzdHJ1Y3QgdWRldmljZSAqZGV2KQogCXJldHVybiBzcGlfZmxhc2hfcHJvYmVfc2xhdmUoZmxh
c2gpOwogfQogCitpbnQgc3BpX2ZsYXNoX3N0ZF9iaW5kKHN0cnVjdCB1ZGV2aWNlICpkZXYpCit7
CisjaWZuZGVmIENPTkZJR19YUExfQlVJTEQKKwlzdHJ1Y3Qgc3BpX2ZsYXNoICpmbGFzaCA9IGRl
dl9nZXRfdWNsYXNzX3ByaXYoZGV2KTsKKwlpbnQgcmV0OworCisJaWYgKGJsa19lbmFibGVkKCkp
IHsKKwkJaWYgKENPTkZJR19JU19FTkFCTEVEKE1URF9CTE9DSykpIHsKKwkJCS8vIFdvcmthcm91
bmQgZm9yIG10ZF9iaWQgcmVxdWlyaW5nIGEgIioqIiBpbnN0ZWFkIG9mIGEgIioiCisJCQlmbGFz
aC0+bXRkX3AgPSAmZmxhc2gtPm10ZDsKKwkJCXJldCA9IG10ZF9iaW5kKGRldiwgJmZsYXNoLT5t
dGRfcCk7CisJCQlpZiAocmV0KQorCQkJCXJldHVybiByZXQ7CisJCX0KKworCQlpZiAoQ09ORklH
X0lTX0VOQUJMRUQoVUJJX0JMT0NLKSkKKwkJCXJldHVybiB1YmlfYmluZChkZXYpOworCX0KKyNl
bmRpZgorCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgc3BpX2ZsYXNoX3N0ZF9yZW1vdmUo
c3RydWN0IHVkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3Qgc3BpX2ZsYXNoICpmbGFzaCA9IGRldl9n
ZXRfdWNsYXNzX3ByaXYoZGV2KTsKQEAgLTI1Niw2ICsyODIsNyBAQCBVX0JPT1RfRFJJVkVSKGpl
ZGVjX3NwaV9ub3IpID0gewogCS5pZAkJPSBVQ0xBU1NfU1BJX0ZMQVNILAogCS5vZl9tYXRjaAk9
IHNwaV9mbGFzaF9zdGRfaWRzLAogCS5wcm9iZQkJPSBzcGlfZmxhc2hfc3RkX3Byb2JlLAorCS5i
aW5kCQk9IHNwaV9mbGFzaF9zdGRfYmluZCwKIAkucmVtb3ZlCQk9IHNwaV9mbGFzaF9zdGRfcmVt
b3ZlLAogCS5wcml2X2F1dG8JPSBzaXplb2Yoc3RydWN0IHNwaV9ub3IpLAogCS5vcHMJCT0gJnNw
aV9mbGFzaF9zdGRfb3BzLApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5o
IGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oCmluZGV4IDRlZWY0YWIwNDg4Li4wOGIzMTg3
MjViZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oCisrKyBiL2luY2x1
ZGUvbGludXgvbXRkL3NwaS1ub3IuaApAQCAtNTU2LDYgKzU1Niw5IEBAIHN0cnVjdCBzcGlfZmxh
c2ggewogICovCiBzdHJ1Y3Qgc3BpX25vciB7CiAJc3RydWN0IG10ZF9pbmZvCQltdGQ7CisjaWZu
ZGVmIENPTkZJR19YUExfQlVJTEQKKwlzdHJ1Y3QgbXRkX2luZm8JCSptdGRfcDsKKyNlbmRpZgog
CXN0cnVjdCB1ZGV2aWNlCQkqZGV2OwogCXN0cnVjdCBzcGlfc2xhdmUJKnNwaTsKIAljb25zdCBz
dHJ1Y3QgZmxhc2hfaW5mbwkqaW5mbzsKLS0gCjIuNDMuMAoK

--------------i02cwb1S0TaoAyDI3ZMOU2XD--
