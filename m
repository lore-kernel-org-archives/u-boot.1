Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01414C3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFC088CD9;
	Tue, 17 Sep 2024 04:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tydRdLWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622AB88D02; Tue, 17 Sep 2024 04:30:40 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D21088C78
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSHDziGy5MUhE1WZ7X+fixUtUHoqqGvJcutAKiY3TNFtRDBF0fFAc9Z2b7LhYT2QF69P1j6mJKRVbWwjAqEhcGscvXIhtw4vBTpgSq497seDSs5t9az1XKMrpP9B8GCOmrFxpXU2k91mcPBQBMowKa17mSb9Q2UqOtMG+3mseCeA+lpFqs/eeIWj6jbukgvUqaC8Zp705+wr1FItBhwR8fv93csRuBcRH84ENZiAA9rb4EUVacQya2MCbH0pD7sMpXM4bRoaisbhe89oi2hHB2vVtr0Pqme0lKKwSK5/I12m6gumKXzLN8PYeTxhZbQAnS29gWg6vqeLS11DVhqFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk0xNHQWlpXoYgEPtnvwccwF74IvfgshhIa/YiU4zDs=;
 b=ozrKROHMWhjItzFRrsbugCWGoXmTGskPb/96SgPE4Ks6KX6JuT5cZDefPBPcoJI/R4TrZ7cY8jVqbGaVFDPcEdeQ5N/xxTCz15zO0jt5F+ExdMq7ObT6H4Jop320c07vmcEoJtSWGaUjfDDkRKxc2D5o/DHARozqF66QY4uZaqbI/zMSSmhxa2zxin4ZbmihGiR6tAjEFPL0mPtCz0xw2r6czu7iLXq7bRHQBoepwIPcfTXyy2o53dYnGwdnpgLGPFR4eooGMzK7FGCJxn72KeHblNAVRZs6n6Be+ZH15mbgzAOPQZhjBuJglZqRaS5DAkfSbrp6mJ8E4Pgytv5miQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk0xNHQWlpXoYgEPtnvwccwF74IvfgshhIa/YiU4zDs=;
 b=tydRdLWH4aZHlNLc3zv0UhNB8PKUEOJ/la3/7A4f4MzrT3c0GQGkgVyrWarw+uVO0J3C045kaFFgO+qnLda13JKa/ClxMzQC7zoGjmuRsc4qC3bZ2Fj6ewa4G6aX71UP4BwWa2lSTeRlxBCAyce42MII/Liq0NJ6BouotZj94b8gthIYWnd4XAwcjKN2OyUpDOOaVRmc/oBeMKywGQ/h6KR/nD/sFpnh4EmA6dkyfzMzqu/tw5pKC7VD6tDQnCfNCOVtsKpN5frvvBAUvX0XbLDzkvmxLzG39sc3JNFi9/wyB1cRniaXfW3qWwC/CPpoVPc66g1GwC1NVDtgJqLImg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 17 Sep
 2024 02:30:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:33:53 +0800
Subject: [PATCH 01/21] imx9: soc: wait ssar when power on power domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-1-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e295cfe-cb04-4ca5-0859-08dcd6c0b656
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REFpbzJoY2ZVbldwWnM0VVFnOU5jeldSRzF2dlJOeE5VVlpJSFRPTDdTTUor?=
 =?utf-8?B?d1N1eFNOdGRKNXRCbk5ycCtQUkw3alF3RGlXV3pZZjhLZ29yZklaT2NGMFo5?=
 =?utf-8?B?d3g1Q1oyZHZiLy9MOTArMmVlSnQ5c1pyL1ZtM0NnSWw3aWd0MGdRcTFUT25q?=
 =?utf-8?B?V3hnRXVDZzVOazJRdjNwZElVZlg3TTV3cEFtQmdZODNHT0ZoMDJPcklCakx1?=
 =?utf-8?B?WW50ZktBbHArYkRZQm5GWTZlekdBQlZyNFVSVFJMWXI3Z1l4Y05rTU81L3lX?=
 =?utf-8?B?WUszUnlrdnQvRGFVT3U1b3RkYWpTWVNHbTNiaWpBU3BLeC9tcXN6MjZuWlJj?=
 =?utf-8?B?NjlCQkpvdWc1WFI3bXBIMENiSzNoa2xtdnIxRUNNYk85ODI4cERtRWx2NFRs?=
 =?utf-8?B?ZDdkSnpkdmp6dUVWcEw2Qk9ibXhzQm1pVHhJVnF3VDYvVURwdGdhVzltT1Yv?=
 =?utf-8?B?STNKb1hzUkgrNmRyS01ISndUZEZCTlgzMkNwU1VST2F1VzI2MkdhMTAycktF?=
 =?utf-8?B?MkNrZjU0anNua29mWHdNbng2Q1N2K2VQL0lkOUlWYlpCM2E1ajEyUlpZcjhT?=
 =?utf-8?B?S2xlTzBvZ3ZES3BNbEU1UTd6L0dLVEV4M0t2cXdiL1Blbi92Q1lvT21LR1lP?=
 =?utf-8?B?YmgxWkZaVTJmQ0E4anUyM29tb2NoQmRFV0ZWbWNDYyszTU9QUlNCL1h4cTVv?=
 =?utf-8?B?UkZ4WWVpaHJqaWZMVGRBeVFxMVdWSnU2VTNDKzhGalZrd1pIanVvQ2RkazVO?=
 =?utf-8?B?SkxnUGpCakpwVUpHcFN4cEYwQmFvSEJBWCtjTzlJUndIcGt0SG5FVkk1aCtW?=
 =?utf-8?B?aVYrSGZielFuQ0o2T0Q0ZmI2cWZLM0dtMjRGajlXaTFkZDltSEdhRjlhNU5K?=
 =?utf-8?B?K3h3amFLTUh3NGZmRUQ4bTdwTVF5bW4yT0JTUjdWenVaTS9ITDRsZXNXR25C?=
 =?utf-8?B?S3hBSHU2YXoyRGJyKzRIWkkrWXZqeDlmL1oyOTg5OVo1dkhLZEhjSzlnells?=
 =?utf-8?B?RURWTlEweTQ3SFlnOEd0djc0bnpGU0dLbGROZWxtTkRLbG9pc01RN1dweG5O?=
 =?utf-8?B?UHlxMlBwZitkWWQrbU4vRzBUdFFncGNwQ2IrMDFtU0dRQ0hMbFBMajQxUGJI?=
 =?utf-8?B?RmN3Uy9UNllMdG9DK3JEeHRKQ2kvRXArTU9KS25RUk1lOXhwejZWbjZpWlEv?=
 =?utf-8?B?V1hXTVpnYXcwTDhKTHB5bHBqV0gyZEJMcFZTanN6WnFlSHhZUHVsRGtMeVly?=
 =?utf-8?B?MUFqNlFDaE5qSXk5TjB4SzJvOTltV2NqSUVFOHRldHB1NUpuayt1dVIrUlUr?=
 =?utf-8?B?SFVDYmZlN3gzOWFOOUJ3dmRnMEE5RU51N1VwbWtsZThrcVB6Q21BcE83Q1B3?=
 =?utf-8?B?VnBVNTR2UnpzS0ZOTEZFYWIreFIzdHYyZDhnRUpRbUQ0VDNBaXNzVEtZR2NK?=
 =?utf-8?B?M293d293R0VCd1JYV05pbVVESlJyY0V6Q1pVWjg2U2lxbGxRY3FOZXRXUG85?=
 =?utf-8?B?K3VUVzRHbURPOHk4VDdpSk05L0x5dU9iaW9uSXgvWTBXcFhoWTFUR0p5anIr?=
 =?utf-8?B?L1JSZ0R3M2NHMHZVeVlONkY0OUl1WHNWWXMrMTc5MEFreU9KYjdpb3c4Ly9z?=
 =?utf-8?B?ZDlxM3lCY1p0Z08wanZnd2x6SSsxbU9MQkdTZFZoamVTb0xjazNDYVpqYVhX?=
 =?utf-8?B?ZFRwTVBwL1pqZkRMbDVHS0JtSXlmVVB4dldWdlEwSWROclFUV0k3bWpPOVBV?=
 =?utf-8?B?cFBVaTlvbVVVbit0MmVLNVVZVlQyTW5VL0FNZ3NISUhndytyeUxFdlMrTWlz?=
 =?utf-8?B?dFFVSnFDam5TeXhwZG1qUTVPdlRPdGlmbktITWVZRmloNjZiZU1xellQSlJy?=
 =?utf-8?B?YzFoU2dYMGx1NnZ4NTNZd3R1ODlpdkpNRGdoc0gweHFuSnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STBVMiticEZKcXgranlXQzVhOHRZYVkyUFN6bW4yVlJGWEhMVTJMbXFncEpW?=
 =?utf-8?B?YW1mOGdqT04weGpiVldOcEcrOFFHWXhNb0YzODFqWTl0c0labVkvWnpTNzRx?=
 =?utf-8?B?UFNpRHREcmtqS3lyU3p6R1NqcVdMR1JyeGpsc2IrOERUdXJMTzlteXE1ZGNu?=
 =?utf-8?B?eDlTaU9CRWlVSG8vUUxLL21CdzVKNVlnQkF2Kzhsd2tuSWxVTmFGbThyZW9H?=
 =?utf-8?B?L1FFVC9BbWtNSmVNWDlWa3kvRWhPcG5jeXozVTBMSjk3TzBwOWoxOER2Rk01?=
 =?utf-8?B?OUlYV0VWWnhzTTNBS1FNQmZZd3hiYjRFOVBsaEpuNGkxWCtQWmQ0cWR0eFpO?=
 =?utf-8?B?cVpBa0pORWpiL2V4TCsyOWN0Ui9PbFhFU25GUkN0MkRGZWJIc1loeEd1cFNo?=
 =?utf-8?B?MVNGY3g2SktnbFRUMUVEM1h6UGlpeHB3OVdubUs0MmdRNWFNalMzUi9pRXJX?=
 =?utf-8?B?UXUxZStCNlIwY0ZZWTVLQ1lUVDVOVENTSWR1bXNkUXl6a1hDbzJjTXlqYWVI?=
 =?utf-8?B?eGM2cm9DWEtTS2JJdnA2VSszOUthM1R6RThCcUtnSDVHeWpnbGpwTDcyL1hV?=
 =?utf-8?B?SURZbldTZGE3dFlXZGU0SDlISGhXdVBEei84S1FaaEhwdENvdWwvbGQxalkz?=
 =?utf-8?B?enFDZVpJT3JEMHJGejNlbU95M1VIaVNrRzBGL0ZkWjBHUU9KaFV6ZGpiUzVN?=
 =?utf-8?B?ZnFRbiszNG1sWFFXYnU1RmtleWN0WlE0QUlZK0N0Q2JhemVKUlVHUEM0d3Fl?=
 =?utf-8?B?RVVPOENmdDN5bGJTWk9XTmtabjZUbjQrTUYzVW12TGtVS0UvbFYvT3Q2VFBQ?=
 =?utf-8?B?bFZjeGVMbXFKaXpRQW9RaXlBWUFSWDZoMTIyOFEwQzBESkFxeit6SkRZekpX?=
 =?utf-8?B?MmJOS2NIYS9kVHpWcHk0WllMNlM4czdLYWdVRDFiN05oYVM4MmNSSjVmL0lM?=
 =?utf-8?B?Y1FLQ2kzTkx1ZmRjVEQ1NVdMWHJSaTRSekNZR2U1SHc2K0o0QkZ0MkZISitz?=
 =?utf-8?B?Q2xzTVY2UlIyRnRua3FjdnRCcGx3THc5SThWZFRERFoxeSttMjdidVd0ZmRo?=
 =?utf-8?B?RXJUVG1IeDlhc0J4Y0sybGo0b2pyRjc2OElvQU5pOURKc0p3V09nb3BTQnFF?=
 =?utf-8?B?VkJtQUs3WWY5aUx2anBmVTRrSk1TczBQMys5QXZ3UzRiT0wyWjFWYkgrUVZX?=
 =?utf-8?B?aXhFdGFoQkFuMTZTeTJBZlRnQVpWSmhrUjk3U0E3MXVnZDFPdGc4ZW5oL01K?=
 =?utf-8?B?dXZHOEJ3VEpZdS9KMnpCTytxNVhwc0QvZTVweXlDZWx4M2pRYWR1R3h1Wlhk?=
 =?utf-8?B?UFpJOGlTQW42cTZEK3NGekRjS1pQUW52VUxFWjJxcFRIdUlnUC9KU2F3QlFP?=
 =?utf-8?B?c2hyMzc3SVBsRFppSGttSFVuOEFDVFN2QVdhQVh5T1c0dzdqcU9tN2oyNUsx?=
 =?utf-8?B?KzZXaFBQd1crMllWa2ptMy9lN2k0Y0Z1RldhVVlKbW5BVDQ3Tm5tZzB6NzFu?=
 =?utf-8?B?SWpPcWZWQ0tmR1FQWnovZ1VGSThXTUtwNkxlc0NTSmczYUFMVE5Ud3pBSlg0?=
 =?utf-8?B?UnQ3MkZMRC90MWtEWkhwWmZqZTNRRWtxN1hXVTV0SG5XOW03c21UWG94YitO?=
 =?utf-8?B?empYVldkbHBJQkZEUVEyVVdFRUtJd3NVZitTM0xyZ29haU5kcVQ1NGs0dEVN?=
 =?utf-8?B?VG1rWGtkZlNOOGV0dDVjSC9hYTZPR09VMnZEK0VVczBxeXBORkU2ZGEwdDhp?=
 =?utf-8?B?akZNV3JYWGVJTVUyNVZHeDJGOTZFWThtUjVmbEhZQW4zMnN5cVZ0TUIvc2F4?=
 =?utf-8?B?d3V0a3RMTnZHMXhGUVZnYjRXZEVhZHFwQlRpT2lTdlFsM3c0S3ViYzRqeElG?=
 =?utf-8?B?UWRhYTlLVCtPUXE1R1krTFlkVFVVa1pyVDFMa0YyTmNMcXRpM1lobTBqcG5X?=
 =?utf-8?B?OU9teE50YTZvT2Y2L0lpMTJPbVRKTS95bGkxTnhnMkJXYjhvWG96WUVLZnd4?=
 =?utf-8?B?dG1Gc1hycGNDM1VjaHFVUFMxSStwZWNlZmdIdmpsUlJZWjhiU0VIR1pUQW9w?=
 =?utf-8?B?b1dEVmVueUNENnhiT25BRnZqSFA5Snh5SC9oU1pHYjhMaFJQM0NhVTlmdU9R?=
 =?utf-8?Q?DueN04A29UZh22UxzvPCWe5nh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e295cfe-cb04-4ca5-0859-08dcd6c0b656
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:36.8030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcMGDJmN/RGyh/lJMf4VyoZ7RSMoJh6M7h9tY7xz8RcA3929j7nEGhKMMOQdFckUPLTuUxEOF1SY6E18a/32LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
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

SSAR handshake done means power on finished, not ISO done. so correct
the waiting mask.

Fixes: 0256577a83b ("imx: imx9: Add MIX power init")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 1 +
 arch/arm/mach-imx/imx9/soc.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 76d241eab09..9953c33b73b 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -38,6 +38,7 @@
 #define SRC_MIX_SLICE_FUNC_STAT_PSW_STAT BIT(0)
 #define SRC_MIX_SLICE_FUNC_STAT_RST_STAT BIT(2)
 #define SRC_MIX_SLICE_FUNC_STAT_ISO_STAT BIT(4)
+#define SRC_MIX_SLICE_FUNC_STAT_SSAR_STAT BIT(8)
 #define SRC_MIX_SLICE_FUNC_STAT_MEM_STAT BIT(12)
 
 #define IMG_CONTAINER_BASE             (0x80000000UL)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 32208220b20..9b6ba5609d2 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -752,7 +752,7 @@ static int mix_power_init(enum mix_power_domain pd)
 	/* power on */
 	clrbits_le32(&mix_regs->slice_sw_ctrl, BIT(31));
 	val = readl(&mix_regs->func_stat);
-	while (val & SRC_MIX_SLICE_FUNC_STAT_ISO_STAT)
+	while (val & SRC_MIX_SLICE_FUNC_STAT_SSAR_STAT)
 		val = readl(&mix_regs->func_stat);
 
 	return 0;

-- 
2.35.3

