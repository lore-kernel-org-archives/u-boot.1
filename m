Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199F4E64AB5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896AD89696;
	Tue,  3 Dec 2024 15:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q+9ES3im";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C290F8966C; Tue,  3 Dec 2024 15:38:07 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3AB89681
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hggP9TwvHQ4GO7xNNvfe8S+CdUTajjfi0yRl+CDuqOhSUXtIxKUif25NyGwAzq50RK9r5WfXVJ3V9wDwfigMmaDph1G+mmNOj79is/sUqEDGjhSbkMYbzrGfn6iIQ6b+u5vZJ5EeCtEMoYQLjdhaMgtkybJqZbglCgk6bAYEeP0Su7ra5uv+k27SeqksWkTtXlyP7z+7kiFSe5aCSTHgsKyh58W96Z3mjaKaHpuZXEy5iiy3p3XnPmrNcDXJpt4hvJDgwkvue393RqE9d5gMqnl7VAwy1nEVC4Nm1EOvr5sEF5FD9oHIXpLJqIWpoIp70c/3mgMXr3TsvF5ezXerFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePA870yM1oeXvlqkaIl7Bx/1fvCkAG9ChQ/MA8RMxLo=;
 b=pDyoYzmKPjn41NxMNGhbJvynQnfZImRdwCrRiaV2WP9bNw3dfHtaBcghYiZEIgZng2UF4Wkay8O6iT3+I20ubxfQRi+l87GQ0BlvS8RE7nhEmWzyFO6AC7jIXPZbZyHjON4K3bh9e7subeMgBaqRKTfNHAtR4j1859QPPB2xTY+uOXrdA7ntCJhOO5CRCTft9dCCQ0j3ENdbFxzqH4wjaepJIp6Z0ygRK0PVb33e9tG5PX5CO4QtbYI1KOqNYO1hB5tJkyKuRSnJ1sMATmkZG80lLZ3hDfn3Xliiq/gW5xmD17qmCbsxVWnQLbUoMKPmoKPQwL1yja+PVl+oThMpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePA870yM1oeXvlqkaIl7Bx/1fvCkAG9ChQ/MA8RMxLo=;
 b=q+9ES3imOm7v5/L7wsbSCtzwQ+PwFp197ycSyrAHNcuGU3l8u9k4FPN4MGD+hjlnM0gbVlqxk2xInvuK0Uq4Dzy0b5O86Sdph7j325FxThJK3Qu8b4aTLeu0qd9LP34Nbs10SwOTaBKjXqWwoaz3C0QguLAipCOpQh9w+WuBpfajgU50wZWriDKpIy7AJzreIIJ9uNPm7lTjwlFHHOIouQVdZqwm5WRj9kG1Qg3OT9t6UfisY5cEgQpnOcQ3cyq2f0uL25YUIKOdKnLbzGbY8uvzqDWWsJjJQEVjbRshZ8P6+jDUDBZBNGPOxIuY2pZJBhNe3BgTAEpPfxGGcg/rlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:38:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:38:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:50 +0800
Subject: [PATCH 07/11] clk: imx: clk-fracn-gppll: Add new PLL rate
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-7-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 844cec0e-aa95-4bf2-1326-08dd13a816f6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkwrRGFlaDc4bnB5QVhrajJtUjBNdFFVdUdMTmdSbTJkZVFUT3BLUnZzOExS?=
 =?utf-8?B?R2hTVktlZzlRRklXcFNEd25wSmtHakwwZG1LaFc4czZpbzlDRXI0U09NdkI3?=
 =?utf-8?B?VVpINWo1MDhOWmNseUdtSHZ6TzEvTUxjR3FhTFJndi9YTzNJcDB5cXJ2d3dz?=
 =?utf-8?B?cGVMSjNYSTZFTzRGUWJLdDdoQUE2MUNRcXFPWFVpa25LcHUvd3ZMcFRTaDVp?=
 =?utf-8?B?QThTdk16ckVEd2hRdkREaElzN1BXT3RzVkJweXo5NmV6bG54UGc2a2V5WW8y?=
 =?utf-8?B?enk3eTViQXRMK1VqdUJXcmluNlhsZlEwcWhtSGZocTJKTW0rVFhTaFQwSGZw?=
 =?utf-8?B?elRjMHpxYkQ2OXlqTGZIYjBCcysyclBzV2NTUWl2aE40S21HempHbE5CRWZx?=
 =?utf-8?B?MjZ4ZDlPNGZhdGhaV01PcFZWK2VnZmg2UmVvWWhhUVhoUXdUM09TWlZlZmJa?=
 =?utf-8?B?RXpPUGc5cE5HaVBwWjhYalA3SHpMZWJxQ0V0SVdOaDhaMFJEVzl2YmtBcmMw?=
 =?utf-8?B?MyttblNqbkp0ZGhXYUFKN3ZodFJkMzBxc2IvdkFMNzJZang5VzE0SG1JWUJy?=
 =?utf-8?B?Uk43cWRZK2gwTzdlcUlxcmg3YWwyenpaRHlBbkRkOWtOellidE00QTBlbDdo?=
 =?utf-8?B?WjlBNFVFVDQwUElGRkpHNVArdnVubEZpTGRVZ1hiM1gwaWtsWHozZFJNSSti?=
 =?utf-8?B?U090YkVDeHd6NW9YL1pWQzRVbWlWUy9aMDVHdkNDMlJwTWxRSUYwMkptdWlh?=
 =?utf-8?B?cHRKYkNqVCs3R2JvUDMxcGVVaWxaNTUrSmR6Z1UzOUN0QkhNa2pZWCsya204?=
 =?utf-8?B?SmtOTEhBK2RoMG9iLzZzL1VueUxHL3Jna3hrRmxDSmlTbC82L2dYeUhjQStL?=
 =?utf-8?B?QVA3d3RqWkdPZ1pZbFlDclJIMCt1a1lHSDBRN2t3N1JzSkJ0ZU1ybTlBNDN3?=
 =?utf-8?B?cDhTczkwSFpTZ1BOTG55UkpqTlM1eGZnZUxxSGtYTS81TkNLYkJTLzNRdWUz?=
 =?utf-8?B?bVFUN3Y4SmZqMHhBWjRuQmdYWERmWUtKK2ZjWENYWnoyN3VuaVNudXpnMGxk?=
 =?utf-8?B?ODZxRVdRUnZiR2dybHJyWXJzaGtpYXZGNFRrZDNTQ1Y4Qjh4VXBJTHpOU2tH?=
 =?utf-8?B?QjNmM1BBS014dmg4RnZycGNqRy83WjFPbHJYalNPeXJzSXdlWGVxeERVWFB1?=
 =?utf-8?B?WDdxQ2RXMDMxMmhLa0o0OVhLbU10ZGlxQ1NNRC9NbDNIL1psdU1lSVFYZUQw?=
 =?utf-8?B?QzM2cXFZZFJ6V1ZuTTRTdjFEaDVES0RFZkw4Wml1ZjhKZm9lNlI5WGVFOTVP?=
 =?utf-8?B?eTB6Q0R5RmQyb1FkcnY1V3VyMHE0blB6c2xrUmh6cmxIODVpS0gvNys0NERK?=
 =?utf-8?B?SzlkZ2RSdG1mamFyOFhscmo4SWdHK3ZhZUJmYlJvZ0NYdVZsQ0VNZDBDa1lk?=
 =?utf-8?B?d0Fkcm9QdEs3MERtd1hxWllXYyt2QXl1cjNpaXNRWnNQWGFqRzgzS3p2QTlP?=
 =?utf-8?B?b1RmbzBEbkpLTFFKanFNaUN4T3lUZElrVEhxeTAvTFFXSTlGRU9ZTUhRODNa?=
 =?utf-8?B?U1lkOXJnRmthMGwrdWl0bWVYTTl4Y1o3Sm1QaWdWeDhpNHhYbGxsSCtnMjFr?=
 =?utf-8?B?Yk1qVUdxWDE4QWE5ckhycUdaVFdMT0o4cnAwTWpJbC9FVGhHUG1pSU9sMnVW?=
 =?utf-8?B?bEsxaHRSOFFZSml2N3RsUFl5NVlDbUJBZTY3TnRpT2pXWk5GS3QwcHJxQ3BO?=
 =?utf-8?B?VW44cGppQ0xwMlQxVHZhaXJzRWEzUXVIMGxoWEpFblJ2U1FTcVRXTzN6TlFw?=
 =?utf-8?B?OVNlRVU5SjV0SUxsQmNFWHF3QlF6UnB4K3R2Mk5CdHgrdURVNWpldXlRZnYr?=
 =?utf-8?B?ZHRYRFozSWJiVzJSTjRRUS9KL0hwL2lWbEFwVzRlWERRU3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1NmMFJYdmN2L3k1OFM2cWR1TXJSajBiYjkwb3NScXh4elRnZjBpRVJGNUhT?=
 =?utf-8?B?WTVnUmJVbWFuTVlyckd0ZHM2azhFQXM1dXVXbkNOb2k0UW9xVTFmUG1KZkpL?=
 =?utf-8?B?SURXSVMxOEIvZ3JzejZSbkM1emJkdXhRb0F4cGhtbzlFbFh1NVQvYzhEaGh5?=
 =?utf-8?B?L0drRXpGdlBzSE9TSVoyeUVaaXFNU3pLdkpwck9nLzRxYzMrNVo0Q2w5SDlv?=
 =?utf-8?B?d0MwRVByZjlwTUxZL1EwdlBvODBiNGdST2dURVUyMzd1Sm96SVoxUGIrZ25n?=
 =?utf-8?B?d0JQOTlVeG5qcEhYZ3B4L3N5c2xqcmh4SUMxbzZoTTlxYmswdkw3MlI4bENL?=
 =?utf-8?B?K0lodnVGQ2sxUzR6QjFGdHU0aGtkT0NtSHhaamRVNXFIM0g5Ym4rcTZ4Wm1Y?=
 =?utf-8?B?NHlhVnQrb2JQb1NWRi9Nc1FsTVN1K2tEL2xrZUNtRk5XVWd6bkwxU0pHZ1R6?=
 =?utf-8?B?amZGcHBvbDR4QmsyTWQrUEpVR0FoUDJUbHBVMC9qZjFvRWxyMTZJNmVDSXlO?=
 =?utf-8?B?S3pqdnJxcis1b2VHTEFqRmgrbTBwY09obzFaOU5MaXFPU1Yyamw0SnRwMEdO?=
 =?utf-8?B?dlV4QUszVnQyckVONzRWbm1ObXRjeXNyWlArNURXU2FiOWJNalhFQUZOaitK?=
 =?utf-8?B?b3EzK1RuK1VoMFNaeTJ5YjJNbmd2c2p5aTVHM09NRXdkY0RxaWdZNW44amlV?=
 =?utf-8?B?Zk1TMkhIYnhGbmVPY3lKRXRTQU9WVmNCMXRhTmJVOHRRaUVGVGhUb0hKNk9C?=
 =?utf-8?B?UU1yNGtIOUdDL252aWVWRnlRTldCT1R2eDBsUXVWZzVzZzJidlc5ZVAzSTR1?=
 =?utf-8?B?Yk5xdVB6cGEva2pCOFZJYlVnQWczWjNZNmFQZTMwMytLU1VtTFFZazZIdzJ5?=
 =?utf-8?B?L0tSb2xReThRbXNyNGNyOThmTTdXUVdPMnBIS091TWpNTmtISDl3ZGNNMWhC?=
 =?utf-8?B?NTBqUWhYbXB3ZHBUb3h4ZUkxUkhxUVBaRHh1TXZIM0lEclFzWGJjc3ZKT1Bi?=
 =?utf-8?B?Vml0dzFLNExBcHRSQUtwYUlsVEV2T3BjazVVVEkyVmxNRjhkb0tzSFoxUFNX?=
 =?utf-8?B?SUxsVGpSL01sSkU2aVdyWlJPbzg3WjRMZlBSUVA1ZHB6MmhMdGZHWjhLb0Jm?=
 =?utf-8?B?Y2Z0YjlMclh0MFVrR09mSzlWVkNGTUFPRjBmdjZPdTJ3NldLVllETUVZNWtQ?=
 =?utf-8?B?RC9XcnZJMjNRVzlIL1Jhbit6NnluaDJvV3VRbzIzRDNCQStBRkgyMmJNaENQ?=
 =?utf-8?B?ZWxSWGNpUGxOeU5kWWdBMzcvNC9FTGZNdERBSCsvMTRpQkxESDJvdjdQUVZD?=
 =?utf-8?B?MFNVVm1LQk1ENHhCdnQvZWtvdXRyQ01GaFM3S2w1S25uTzBaQ1pwQ2FGTFhm?=
 =?utf-8?B?V2ZDNkVCb0xNSGY1cFVLYmZnc2FWVlpIT0xMVndMU05YSTFzUVVQcjZDanll?=
 =?utf-8?B?dXlwTFRJT2Jlci9UNmE5U3c1WmRKbXEvK3hxbTVmSFN3eS9HMWQ3UEkvRUNS?=
 =?utf-8?B?SmRlZ1VDK1BPcVZTZWdLOFNJdjJNT3NHczZkb3p1Q29UeERjOElPWUh6SmFt?=
 =?utf-8?B?bmQvSG03NlVMbmRDb09RcGhaNmNPZ2RQNnZvQXRPbnVGaTNJMHltbDUrQXQx?=
 =?utf-8?B?VEJ3NE0vb04xQVdSblBvOGxndDBUQUN6azdwUS9oSU54Y3pFdTF5OHlpMWtw?=
 =?utf-8?B?ZFlBQmg2ZkN2Q0FKaWpqSDBLTGhKTFlYQ29STjhBUVJkUWdZVGQ0RUpkd1F5?=
 =?utf-8?B?dFB4YVJUSXRBNlQ3L3lhZFo0bGdRYkxSc1RPVHFiRU51WXlhWHViZnB2d1JB?=
 =?utf-8?B?TGpRL3Q3N1Q0K1NHL1AwRzNTbUcrL2xoSUJXM3FMd1BOMkR2aXd1RW9xQWFY?=
 =?utf-8?B?bWkwdm9LK2VqSkVXQ2xLL0xNY1ArV28wRkQ3RWhvT3ZaZXhsUUNVT2UwN1Az?=
 =?utf-8?B?TjBPOE53aXhMaGloLzNuR2F4MWF1SDIrUkVqS2h6VEZLTXAvaFNKOVgyUVBV?=
 =?utf-8?B?dTBXUnZzWlI0cW9JcW1jU3E2MGx1bkJEUlovTXhqSkpKMXlJNGh5Y1VFajV5?=
 =?utf-8?B?TVhMNFJLVWcrR1dsdkhnendFc09ZRE96cGF6eXZNSVJEOXlLdUVJUGVqTEo3?=
 =?utf-8?Q?mOwXDcfDx1V11uoB+0kC6Anwk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844cec0e-aa95-4bf2-1326-08dd13a816f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:38:01.9556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ld4xD1nFvItbxBZ9SQfTnMkbEkcI9FcaQ5iOz+cOn04JaPI6M5EiiqnBoZiyApY9OS6bQ54zhAusdnlr+F4mrw==
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

From: Ye Li <ye.li@nxp.com>

Add new rates to integer and frac PLL to support iMX91

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 8f42a5cb1b72d62c951d8c7f5e4bb7052e6e553b..81e19d393cf20cf57380c56397d8d091b181af3d 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -86,6 +86,7 @@ struct clk_fracn_gppll {
  */
 static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
 	PLL_FRACN_GP(650000000U, 162, 50, 100, 0, 6),
+	PLL_FRACN_GP(600000000U, 200, 0, 1, 0, 8),
 	PLL_FRACN_GP(594000000U, 198, 0, 1, 0, 8),
 	PLL_FRACN_GP(560000000U, 140, 0, 1, 0, 6),
 	PLL_FRACN_GP(498000000U, 166, 0, 1, 0, 8),
@@ -93,7 +94,8 @@ static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
 	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
 	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
 	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10),
-	PLL_FRACN_GP(300000000U, 150, 0, 1, 0, 12)
+	PLL_FRACN_GP(300000000U, 150, 0, 1, 0, 12),
+	PLL_FRACN_GP(200000000U, 200, 0, 1, 0, 24)
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll = {
@@ -111,6 +113,7 @@ static const struct imx_fracn_gppll_rate_table int_tbl[] = {
 	PLL_FRACN_GP_INTEGER(1700000000U, 141, 1, 2),
 	PLL_FRACN_GP_INTEGER(1400000000U, 175, 1, 3),
 	PLL_FRACN_GP_INTEGER(900000000U, 150, 1, 4),
+	PLL_FRACN_GP_INTEGER(800000000U, 200, 1, 6),
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll_integer = {

-- 
2.35.3

