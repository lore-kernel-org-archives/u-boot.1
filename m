Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED86E64AB5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40F2895C7;
	Tue,  3 Dec 2024 15:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o+8Pe5yV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D1688E41; Tue,  3 Dec 2024 15:37:53 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C84489328
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlKshwNJdI4l2zvADlOaBVmfdByhmmmU76LbCSx8bfA11jJHvFVKTpl8sUZC0EIo+0pOfmWo6P8vYM3TkmOEgmNfbW7J/RwBejda0JlcY2oKYKFW+UFZHRM3X2DZC5dEvRiKh06cdXQo63epriHoBMv+EfUORNenkpnkHPqzA1qzNfUn2BUrDhbqSNWG7dZrPWkW6gprIudMo8fOgZ4i+zllxWr69yssepytgaZg/JZy1QPgdBjgx7w4AjLivLg05oTzVBPcm5D71TU+g+OSSNFCveeTuIuBRiPmYdbupBwQrABm2X15WEQNDR8pGCOwWemvFVXYD37XI1YNYi14BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SsPczWEOLb38oLphooOpTwujQVNf5n/OAFNtol9ggQ=;
 b=NbotXTBo0sXZ4UpqyIFBXK+peJJPcSKPhWuRkPgzVr+5nf2tHk/3Fkn7WNfHvTIVC7J4FcXmuDztiK0bhn+5EzNajXqTHy2QOARkhISsr78UNZ1bZCJeoM9QNTuMDOV5YBGOGXT4j4MGoMLJoweZeP10Y5HIMB9eyIRgRslY0tlacnpQTmOTxSKlmvAmrGh69tNkbHwx69bKD5flyFKX+emJO8eDvmY95P3Dud29vOamyKfdhey3yjhXvPx2QWggHsxMQ8ma0ak/r6xAwiPQ5HN4sshoQAAm/5Ra29a4ZLM4ATQeFvRUF352no8MB47Ag1ajlvuuhEnEqi8AOR95UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SsPczWEOLb38oLphooOpTwujQVNf5n/OAFNtol9ggQ=;
 b=o+8Pe5yV1f+ZH86WDWcsSV4axiHW2Dqs+FEppOQS9wCKXIQklg2z+0SoF+5ALPPkDDZl0m8ulc2eCMLCtUkkowDNCB060Lu+VMlQq8v11H7UuyevCI+bLifMoqw10advGcAX/EYC/I4GWTcGfmvAfn4beEvFMIhGRQ+85xaYQ59Y2D4sFyodU6ARPq/VGf+Ac7qQEb9k0fe6dZTxZ7i6P0zWqiQjQalqURq9uHXEBAPZ/PY5+bt/WJSbFzWJlLbx4di20bWp2qZUQibTljxw6zK1PuHF1D1E7GJPzsa1iL1mbw6M9/D8UptUj8nHIVn7Rpv8DFTCEjCwGcYjctBXlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:37:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:37:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:45 +0800
Subject: [PATCH 02/11] imx9: trdc: correct DEBUG usage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-2-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af0c2d9-458c-432e-507d-08dd13a80f97
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjIzNGFVNWhhNHNUWWlBRGtZZlh0L1RlNmFJa1ZPTDRBNXFRcHo2NFQ0N0lH?=
 =?utf-8?B?S0NsT245VmJUOU11bXhBSVlwMHQrVWY5cUMxd2p3UlZ4U09BQW1LOFF1amd2?=
 =?utf-8?B?NEgzNGFMYk05NE0xRjFIbDQ5YXFDZjJpcXJIWjZpK1NHYms2NlFWRzlWUVFR?=
 =?utf-8?B?QkV3UmJnMVoxbWRhN0I0Z0lOL2lCekxNaHMwM05HTHRzdnlqMTJHV0kzYmJY?=
 =?utf-8?B?VHg4SEN5bE5QeHFoc3EyN1hYVk5ZZFBLVUlnSkowNFp3UlhZbzlKZUxVYTlS?=
 =?utf-8?B?UmdLMXkwNktBd3lyYVJMYWZDMHJXUDFyTEN4Q0FueU13VzNySkVXYmpwOHZZ?=
 =?utf-8?B?MkpocnVTVWRpN2Zqc1JFL3h1bzNvaldoQnlSRG5OVVlHRnNGQ1JOR1dDRG5a?=
 =?utf-8?B?T2ljcW9wcFpLRmEvckdZeVNGdmthaGZQdS9HUlVmRm9qNkdHdS95SmU4TmUv?=
 =?utf-8?B?S0VxZzFtNElpS09lRVpFMEZWK1VTY0R4SlFjV3lETzVJNkRSa0dSa2FCc01z?=
 =?utf-8?B?VUlqYU5IRldacmFRZGQ5VG01ZllBRVdEQ1gyamF0aXd6MXVaQ3FRSlJ2SjVS?=
 =?utf-8?B?RE5JQ1lHL3JLV0ltWGoxcWh0QWhHYi9tRlRCRWN0Ry9meTNvZ0JUQVBMMWVJ?=
 =?utf-8?B?Smp3WjZpeGVlRVRwV1cvckxUTFJuUUl4V0xTYnRNb2FIV3E3YlQySGNtTG5S?=
 =?utf-8?B?aFJlM01wZU5sV3pZdGRkUFYzRnlGTnNIU2NlMzUwcURNTXBva3pTa2dyaG5r?=
 =?utf-8?B?dUtzSGdWSkdhQmpMaEtrbWxRbGdnMVYvdS9wR1BRQzlzRTh6Mm0zWVVnQ3BZ?=
 =?utf-8?B?SHk2b2JORFlEOXdXM0lGY0JRcXM5WVd6bHNGU3YzYmZSTzFLVVdiYkpmZFRp?=
 =?utf-8?B?KzhjdllDNUwrbDY5c3F3SENNWmFtU0kvYm9lSFd3ZG9VM3czbmNjcTN4RXJ4?=
 =?utf-8?B?Nm55eis5Z1V4N2VDQVEvTkczUlR6OGJCMVhpWmJsRWh5a0czb3R1bnp1aE9Z?=
 =?utf-8?B?UVMrUDUxYjE5dENVcXhYenJpNUJlOUJsTkVjSnZyVHphd3NSMWNCSnBXTjRM?=
 =?utf-8?B?bFdpWjAwSDNNL1pEZlV0MjI0T1FuRXd4cWxhenpkK0hFcGxPNnMrQzlJc2VD?=
 =?utf-8?B?R2sxVGtLemZVRTlNYkhSQ0lobURya1FXaGFxTVFEc3lIbTBkWUlubzBDMzJx?=
 =?utf-8?B?ZVVVZ1d2Njh5RHE3SlFxdmlwQy9CcHFjczR5MHMxRk1QTC81ZHFudHc3SjBx?=
 =?utf-8?B?ZnhBNVZEbVArbmcxM1AwQXhlZ0lkYmJnR1luQ1FEMFFKeFRmQTFkakxjcnZJ?=
 =?utf-8?B?dS92eXp0QnBmanJjSVkydVRDeDdoVDVsUDJSNDBVNjYyNENjeEUxdjNJQkxY?=
 =?utf-8?B?bmwzWVZVd1AycFlIUnBDVk1KbjUzRlZyNStTbDhCSnM0eGw5TktneGtNbFFP?=
 =?utf-8?B?M0szMnJEV3RrZ2RBbHVhVE1WNlFDVy9Mc3JYM09wQlh0eTFXMXlRYWJZclU3?=
 =?utf-8?B?dTlWeGlOWnJNcUZ4MzhHUitrQVZ2cCtzeW51V3diN0lhYlpGajNxNjhXTDBH?=
 =?utf-8?B?aE9JTm1jMDQ4c2R4Q0pKK3VCNlhSMHhUU1J0NGtPRjNuWVgxaUlHY3VHWDdZ?=
 =?utf-8?B?a1piMUw2dHJSM2w2UmJueHJ3ZGg3VFlkc3FZbHIwYk84R2tGcUxFTGV6UUt5?=
 =?utf-8?B?dHNtSFJ6VERSM1o3M2hTWXFGdHIvTGxFZDZBZ0FEVlV5Y05TZDN6S0JldDla?=
 =?utf-8?B?cDNTV0Q3ODVMbmRQcW5tMnVIUXlXd25SaEJLNlRST0RwSHRoQlZlbCt4TUZY?=
 =?utf-8?B?V2lMdGVsR0RDSGdKQVEwRXFrWnFqcFA0TDlGNTRjcSs1Vnh3bFRHa0YyVFhY?=
 =?utf-8?B?T09XUi9nNTUyWEpvdFZTbnNiRzZjclg1MEJPWGQwWUQ4NlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpydFRNY2UvQTU0aWVoU1JDckRJZXQvVi82S1B0TkpOcER0QWFQU1pUckV0?=
 =?utf-8?B?bE1ueDlmSXZTY3ZlMGVEZXQyWFB2dTFaNWNRUFNyUWthQlUxY1RRVTBDMEJP?=
 =?utf-8?B?bFlGUHV4UURvakRCYTFuNGpWaHA1bWtYWTNGU1NSWmlLdUVqRnE4eW9ZTmJI?=
 =?utf-8?B?R3FNMGFoWG5SVFpWRjJRVzNwcy9uMkhnZTVINzdtQkxsdmdMYTdCVWlvdXFN?=
 =?utf-8?B?RERVZHJ6UlNyS3dxTTBSeWIrUmdKOEpRYUQ0K1RjLzhCN1k4QU9nc0NzaFZh?=
 =?utf-8?B?WUcyTE5MTEh3NHc3RVdPTW5JZTl3YSsyRWl2VlFURmxYOUo3QVZROEpHMS9N?=
 =?utf-8?B?TWdBbmwvMVVpaFdnU3VxZGVaOTA5THRjOG9RRlV1REJrSE8yenJ5YXJ5MFJp?=
 =?utf-8?B?MWROMXRQRmxIdTJZbEpQOHRaaWVCcXFJcDdaUklyenFSQ0RDdWYyMmhwWlRo?=
 =?utf-8?B?S0hqOW5PalJZaTNzLzJJVys4T2FYU0FVeEdkaUQ3Q0NnWDNLOEFFVXFUY3Vu?=
 =?utf-8?B?dzBjQ0RyV1ZxbzltTXJwL1A0b2tiNjdxNCtzbmloZWNCUUdsTXdVSlFjZVpI?=
 =?utf-8?B?dkY0eEtMQ1NBLzNLUXFWem40VUF6TGNtOXVvR1E4N3NOb0JFek9WTlRIbXFr?=
 =?utf-8?B?c0graS9hMzZyZDhlZ2lzVkpVam9uN2l3Rm9oVnVkMFJqL1lJdnVDbVZqUE9U?=
 =?utf-8?B?a1h0Z0RIVTNKdWNVTEsyTlpZdXZyM00wWmI2QjkwT0FvMkFvbTkxNHFVYlpZ?=
 =?utf-8?B?UzF6cXc2dkxjb0drNWZkVEpxK1A1dVlxYTJpbkdYblQ3alNkM3NSQWh2UkhI?=
 =?utf-8?B?MWFkeUUwd09uVCtIcktUOFhwVlZla3ZMWWFYcVRnQmJqY204YVY1QWRHUlFw?=
 =?utf-8?B?bHpJYWVsV0E2dytESWQyRGNzODlyT3JMVnh2YTRHekM5RG1vSzl2aU00cmE3?=
 =?utf-8?B?M2xYQkxBQ3VHUDBTM0xqR1JNOUpUY2dJQ0UreGdNeGIwZm90dXpmMVZqeWFu?=
 =?utf-8?B?bVp4dGJpTThWT0hBUjhSQ2d6emtoN3ZRalNJSFIxN2QwamJXNlVEaGRKTzRa?=
 =?utf-8?B?NlArRnUremhMN21odHVTTlNwL0g2dXdiU3M3OUF4ZWtCU2hLa2hWRVdlY1h6?=
 =?utf-8?B?VUJpRHpJRnY1VTlTZTJoTXp3dVZUbW5tSnl4TVdtcWc3RytJMHU3NVZjRkd5?=
 =?utf-8?B?blIxNjd6dXo4eXdlL3JEK2ZtUWZXdUNHVXZ4UHdTR3FVYVFEQVoxT3lXRW8x?=
 =?utf-8?B?aHJGNFZ2MUU4MjBNSjBvNEVjSlVTYzlIa3h3bks3Znl0ak9TRFZ6Rm9WRmw0?=
 =?utf-8?B?TDVKVkVLMmttTlRpZU4xOTNMNjRReStRWklxaUxETkdZYjQ1YmlxRXh2c0tP?=
 =?utf-8?B?Z1l2VTRIeWVJZnVFdjBOanVoSWtWM1cxNnoxNDJYckVHT09PdUZEakRidzFv?=
 =?utf-8?B?eHFmSkVhMnM1RThpRWx5cWVEZWFoSlZkK2tPQVd2bDdPYkw4RmJSNm5DSWVi?=
 =?utf-8?B?WThTQjlDcDY3eGR5S1AxNDdCVXNTSGdIZDQ1TXZaVEI2U1RVbHZnWkczTktD?=
 =?utf-8?B?SkVabDRXNkhvVGluRGFWb3Z5YUJJV0JRSUtIckVqVE4wS291cVBhVTZuWkJk?=
 =?utf-8?B?N3NZVkI0VEFwV3VTM21yRmVlZ09QUGV2YWZFSE5kd3VjbzhvVGRwL3RvU2s0?=
 =?utf-8?B?MDNWeUdpM2tFamNIa0VHaXM3MXNHdFdLT3JGaWRYT05heUJ5MDlUOTJsdys3?=
 =?utf-8?B?LzBiSCtRTUI1blM1c2c5ZW9FR0FPdSt4K2YrNFEyZlY1WVkycVh6L3pVdzJz?=
 =?utf-8?B?WVhsSTBVQklZNHZIbWdXWk9RcmVWb2RobUcreXdsWjBIWDJNTGR6SkxVREpu?=
 =?utf-8?B?V3MvTklzN091RDU0K2UrTXQ1aHdJcG9tZ1Q1ZnJBc0hwMC9OVlhKT1RGd0Fh?=
 =?utf-8?B?NVlJb0tJZ3ZRZ05IcnFodXluYVFvZ013UG0zVE4xRUxJYm0zcDNkRm5obUJE?=
 =?utf-8?B?MWdlMEhFRXEwMnBhb3lnUEdGUlNIeEQxZ25PY2VsUzJBdDdEb2NXTjZHQkYv?=
 =?utf-8?B?dk9nckFWK0MyUGlBQVR5TGlxaWVsVFhlMzJsNmxrU0hJQWRURkRERzNhUmQ0?=
 =?utf-8?Q?bX5ujO52DdN2gMfyKaDgYGKR7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af0c2d9-458c-432e-507d-08dd13a80f97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:37:49.4650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyeCUDKKebAkp7C3TyS5Hlp8hteCvj8QLNsAg9s0PsK0NcQoEDCs50l90FNw9JNyf1DwSTlAWS9PpNWFT7IL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

Replace '#if DEBUG' with '#ifdef DEBUG', otherwise '#define DEBUG 1'
should be used and conflict with '#define DEBUG' in include/log.h

Fixes: 5fda95fb944 ("imx: imx9: Add TRDC driver for TRDC init")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/trdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/trdc.c b/arch/arm/mach-imx/imx9/trdc.c
index ef0f8b52a4d11ac67369b64e62f67998118724ee..d7593ec2718777e0496853b7c2a75c05818d4d2c 100644
--- a/arch/arm/mach-imx/imx9/trdc.c
+++ b/arch/arm/mach-imx/imx9/trdc.c
@@ -484,7 +484,7 @@ void trdc_init(void)
 	}
 }
 
-#if DEBUG
+#ifdef DEBUG
 int trdc_mbc_control_dump(ulong trdc_reg, u32 mbc_x, u32 glbac_id)
 {
 	struct trdc_mbc *mbc_base = (struct trdc_mbc *)trdc_get_mbc_base(trdc_reg, mbc_x);

-- 
2.35.3

