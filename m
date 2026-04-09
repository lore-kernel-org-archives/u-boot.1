Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4489EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 11:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A15784142;
	Thu,  9 Apr 2026 13:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ItIdqToY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A7984118; Thu,  9 Apr 2026 13:40:05 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F578418A
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 13:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTvPqf4P0cLaRfd05BMdQkR/nIgDASclm3osaNZ5cfbVkI9Ox/anASc2VuBZ2KK0uPFIUOmEhdGrk8RlchjPuvO5YAPCNONxE8u+TRqGygFITSfWwEZx61kHLo8MKQLHlEL6d3F+HmxoqYjC1ma5wENv/kxREljUgJjp+8XHvg/ZQ4ayZxVJrDgLBflq1aOZYyMe/SriMuiG8h3+l3bFsmOdjFxPuWRE7+4TH3xRDeGKT0mJa9vqi3zo6r73Ofw1TXdoxhxHZ9dqWczPb95DeRNuGReGsXJzl36lfK9s2/EAlAR8pqMjEiC1SOg2MPuV0dreZH+Wb03PKR2G8luxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FJVH6ZkWz2tmKm20mOaE6YVSQe+vzgeVEXU2/oQNkM=;
 b=rhn49ZnZP7USJdLFN4lTek+kVLnVz/AkSo62WOvFYpRd4gO/S2njmM2D3LHVGDslGXpwCgeISBTKjbi0Yiji0ELVV2N3s43KnIZP2pcUyRXEsaqQZvq3JJiN/6ezcigh29VY1CuSF5HAMz+sbaUB+lxGzoAgcv3H/Lbcn0nYNVNtg4Q+MQ5Oy77mfhhMk94ggfVFhQtHCOGJs1DrQtvq2cyHG9mKa1DmI5KbuR0kFMbyeq1ZHRaMuDopwnePWvzSg2ubxw7+MoqSGM6LgWCWMJujNjlATvAVEcwrw2uwwPdWCGRd2jwENwzQXWvhQ5x6dDkHmwUJpn50igTxfDa2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FJVH6ZkWz2tmKm20mOaE6YVSQe+vzgeVEXU2/oQNkM=;
 b=ItIdqToYxsBif/M6WWT08Gl/LAO15zXCuB1XQ9NoToX0XWiHt3mAchGiRQgnfmRa9ikehrx3LEE3fhZwQaSvxBwQJU2sOjjzP7HmQa1kn9tK+D4dyu91ofcGE0SksLjQNnh5DCh7C6sJH59z5V5nQpf02E5Qkfs3LdYOyXuwlLZZeKI7dy98+3l99NYx/aJgUY91KDgKZ7A35r6+bkBMg+BgSofSXwe/I49pkytAuoZqSEv9+rrWNddFqYJ6y4fFCi3E58oXQAYNuSPdCCjsUzkbHWLtDliYc7IQXHbGoaIDMsw23peKi7jEwXUInRZ98U1TxqudZfHWOjTwnxrLoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 11:39:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 11:39:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, anshuld@ti.com,
 vigneshr@ti.com
Subject: Re: [PATCH v2] clk: scmi: Fix protocol version fetch for non-CCF
 platforms
Date: Thu,  9 Apr 2026 20:55:47 +0800
Message-ID: <177573926834.4193161.5957350404063165760.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323-ccf-v2-1-0f3441631702@ti.com>
References: <20260323-ccf-v2-1-0f3441631702@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c72d16-7b5c-4a6e-fe6b-08de962cba8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 9RAottNyu1zv8gSBDpHdwOwvL7/oagYeyHuPGhxeQgKv/ZtpcaP99wOHh+02iEGSUSuVWIViOQmoEkzNGRQrEkbwjBYODSUR4EwR/MYqIZN+iP3WeiMW9CUJGxsys5c2OMzEZg8zSVv9CmpCi2B5dHbIPcafoCvhDFnnq0FZCAhb5zLTsnNrElwNgFju2ZZcBYaRRyLCicmWdfSA8BOQx5WYF6AlFV/TxaEgogFU8Mb+/iBRI90FoJAxWNNxQRUUujCDQatHKNaOC9lv6UHogo7bKboVbY5s5CwzsEc3UJJ99G7GbZjNOIM5CQrCnkWIs4Zg9KVv4B0yim/kdh+MdlLIjIcApB87RNyHFSKCRUtdsDR8hVFsp1rJOv3dsQ72C1n6HdLIXIlsmtihxCAaWE8fBZMRpfYkNING2oZd+Tp5agCZCRB42hGFkx3NdIh1Lj0U4hB8j05Fw4qpzD+AYZWQLMKP+VWY5asIr0kImm42RacN+blRtpOFq+gXxAzbiFiwDtKaRO6FhJ2cys40Nv172DAbFxtJmzv/4jHnquS/l4Q6xtgVYhRFShla81YvpPYWhKi9sYJRwrKqrmCkb/DiOXPEDXxVnw1gT2R4sNulljJrUN+FbeMPcgVja6S+t/YTZdEWW0ONjSAt7nzbDfPmE09iQE2lV7Gsqp6wEEIwuijb3iH8Fxelkds8qfPfLZLYsKRmB1YboAtZAstUKz0xDyTnYYzvKTuXGGZRbgwO2sO2OWnBi8mnbFMzCrNroigodU2R/Zi13AbNaXPC3wlj7FDwHpNAi9K3R3vbXJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1Q3QVRnODFIYUZCR0EvakJKYWxYQWZ6R3VvTk56a2tSNmI4KzVobzJDaVhq?=
 =?utf-8?B?TzZKb3lUaVl5aTU1ZTgxbGovNURtL1hiUTg3NXFNQWo2c3FNdkhMS1EzRmha?=
 =?utf-8?B?RDdJT3FveVMyYnk0YVFYT2gvUHd0c1pqWGcrYzJORjdpdlZ5NXV2MldpRlVH?=
 =?utf-8?B?WUV0dEhTdW1WNXh4QTlweG0yL2ZLUXhEN2NGRDZmZDRCZ1FDVlVXbjY2S1pa?=
 =?utf-8?B?RXBodFY5RFpuOGs0WFZScjVrV3UxMERVZFhZWDBzQlVmeWRVcStUYUVIQmxh?=
 =?utf-8?B?R3paNXBMTkNIY1lvVytrRGc0OWFUbDJBSzcxRWMxWXZzYnVHN1RkbCt2TGN3?=
 =?utf-8?B?Nk00VmxmMEYxSklhc1NmQjF2c2FzNkordmlEdFZBTnh5ZUJQamRhSEVvRDFE?=
 =?utf-8?B?bnZzU1ZzajlCS1RzSzg0K2xEcUVCYUdlNzY2ZjNLVXhlUDZBOXNpUXl4RDND?=
 =?utf-8?B?VDN0N0VsNE5xempYak1nMEhvaGZWd2laeWRybWpYZ1hWakM5Z0VLa2pVU0dO?=
 =?utf-8?B?ZVVEWnlwRDg1aFYyVHdqRFZycmkxM0k3N3N2N25uZEp0a1Vka2dKa1Fud0NW?=
 =?utf-8?B?T0U2Mkh0NWJINnVpOHVxdnhnVnF0NGtwZmhMa09LTHR2c3prSEJPMFVCMm9k?=
 =?utf-8?B?SFRNVjcyek1LT2padG1sUUtyVmhKOTRuaVhYQ0h1REt5Y1QxTEd4cEV1L2R6?=
 =?utf-8?B?NDJWSUZMaFhrRnpCdzJ2dkxiZ0VLNDdFeEQ2SWVCVlhmL2xmd2pRelV4dnR4?=
 =?utf-8?B?djVOUXN3M21PV0JONFF4WnlHWURzQ0VKNnlERUc4aEpyZG45Tm9PakRlYU5Q?=
 =?utf-8?B?WDJVMUxuc2tVTzY0Wjh2TkxpVlNINTRCYWduRi9iWHNhU2ZPUDVYVGtNVlM5?=
 =?utf-8?B?cURmT2xCNStvRnh3akh0eGF5RDdoVk5PTkVZU0hkai9LeTZuT3ZNSGk0RElU?=
 =?utf-8?B?VzRuTlNCdGk3TkhBRDduSFlxbU1EdWg0aUxGYXRRdnRaY0NFc0p5cXI4cGtM?=
 =?utf-8?B?eUl0SHhBNzJPcGVxdG1XRWVOcnRVZlpWdngzN0UxNVVlYk96K1VXT1VUTGll?=
 =?utf-8?B?N3QxK0g1QlFwYVY0Q1MwRCtIRytQVEZYaThpcjR6U25DQmRpblg2NGZsMUM4?=
 =?utf-8?B?ZWkrSGNEMms1cDBHTFJLS3BlZGM4elBUSGdQM0xna3dMcWFlOEt5R2I0V2lD?=
 =?utf-8?B?SkVZVHRGYnN6M21FcHVMeGh6eHFwL2hBWGpNamZuK1hlT2pob25WWHBvbElD?=
 =?utf-8?B?SVlNUGwwc1VmYUUxUWVxS2tPOWg1MnhHWFEvSGs4Y2xJa1FSOGZVdFBBeXZp?=
 =?utf-8?B?SmVNNmZCTHFVSjU4TWpuYXFVZ3h1SWxPTTk3bG04K0d4RS8wMW1jeVVjYW1U?=
 =?utf-8?B?RFJUb2QxWnFaYlU0R1RjMDZrWDlpcHVqOXh6NE1LN0U5eHpkbkk1ZmtxU1d4?=
 =?utf-8?B?OHpqQlQvbzFGdzNlZFJZKzc2SW9rbmQxTXZvQzYyM0xURlhadWZwY29TOXdH?=
 =?utf-8?B?QmxMc0h3WFJhVmxtZWwvenJMSWU0ajBIc01FYThzLzFTemZ1RHVZNlpUVHRX?=
 =?utf-8?B?V0RJWHJmTnphODNaVjZSR2doZWRxMTc5emJRNlFBTWFyK0N0Ly84WnpJU2Ju?=
 =?utf-8?B?aHNLWG1XVEF1dTNKL3lGQTR3Y3ZjUXpnUk9UQXVKZ1hYRHE1eHMrRU4zc3NY?=
 =?utf-8?B?SUdISm5LUmpaTkpGTmpFSWZ1UUY2WDF0MHdXek42WkhrQ1dRcUhNUmlaWGZ1?=
 =?utf-8?B?dUMyWE1WNHFTZHNsSUVSdG13STJBYjJJVG1VcFRLYnZJZVdQalUzOElqbmhh?=
 =?utf-8?B?YmQvUEg0ZkFPV2NkWnlOdGFyNWtySUJPcGQvQjU5eDlZd2ljd1p1U09EV0Uv?=
 =?utf-8?B?U1puSWtFL0F6Sld0d2tRM0hCYllLdkJlT1EzbURIa2FzKzY1T2NEbUtuNDFl?=
 =?utf-8?B?cjVaNkVPWW1XVHQ4ZjFJU0xPUkVQNmpDamNkTmJ2czdFZGEwNlJiTHptajZK?=
 =?utf-8?B?cGU5ZUhibEN2RHZ1ZkdOcmpULzFtaThaQUV3YjN6UllCZGpKRHVXb2o5aDlL?=
 =?utf-8?B?aDFUK0lzT3NwSE5zRE14TXZTK3FaaUxNa013azVqZW5RT1NtS3ZuMWZwaVhJ?=
 =?utf-8?B?ZE16TlhULy91Z1NKYmdVWFJKR0tYVG5TRWk5Z05TTmdNMWVaVzV0ZTZQMHlC?=
 =?utf-8?B?Z2NhQU5ielNSMkNvNzZHTHRKdG4vRW5OMmVvdDRMeGZ3akRwN3g5MFJQdDAx?=
 =?utf-8?B?VHE0WWE3QUs0ejVmcVJVK054VUZkK0syOU9BU2pvSXlFSll0TUEwYnB3NnhG?=
 =?utf-8?B?L3NlMWZzeS9vZTVTZkZLYlloa1Q2TGZOYzRERTBDZFd4bFFkbk83dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c72d16-7b5c-4a6e-fe6b-08de962cba8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:39:58.8858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YT9YXlOkC0T/FPkG0kqMZ2vnkOfd5BwrHJwYi0Bc3Ji6oq0zqp65pqNX/3IGJEUbHCq4HJ/L8IkAmm2jBKP5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144
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

From: Peng Fan <peng.fan@nxp.com>


On Mon, 23 Mar 2026 16:59:27 +0530, Kamlesh Gurudasani wrote:
> The SCMI clock protocol version was only being fetched when CLK_CCF
> was enabled. On non-CCF platforms, the probe function returned early
> without fetching the version, leaving priv->version as 0.
> 
> This caused issues because code paths like scmi_clk_gate() and
> scmi_clk_get_permissions() depend on priv->version to determine
> which protocol message format to use, even in non-CCF mode.
> 
> [...]

Applied to fsl-qoriq-for-2026.07-rc1, thanks!

[1/1] clk: scmi: Fix protocol version fetch for non-CCF platforms
      commit: d113b295232dd6d819140169d7178d10d155c7e5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
