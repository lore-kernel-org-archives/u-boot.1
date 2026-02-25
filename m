Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D86F55434
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF2F83EF9;
	Wed, 25 Feb 2026 01:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZuRhgiWz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DEF983D17; Wed, 25 Feb 2026 01:14:42 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2907D83EEF
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9EArIOWPR54hTjktKGRFLB2gk1xGBfKlrzQlJTNT8pylKqLyonc80LZBnSQ9gxwAlXdqHStA9e2fJ8mfJ7/nMvF4g5lPB5nDeZpMLJ2ZJDTinQHF6XC2FLB3OSgVW8LODeys3sS5PWSIn7uM/kPJ/a1H+5CGq8nYpCK/Mq+Otw8VIHY/QFtVFgzVl6u5NOvrI8mhqDBQZcEPAD/HRH0ceKmAIfZzxRoPyovp4LJZFn/XV8sfhdOBwwvsVOTyedWPK313Lirs7gVEPKkmV13L/29iQX1cigutCb8bLLtbfoMb6VDm/faHdMNYWeVo8u/+Rescl7kBAwRAj4OnGf6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuHvWY7QaLS6qH3kMr21kfcYPzqGM1aEdVfVbjK/vUk=;
 b=kKkRQFFfOcBazTfQ/raNv1Z0eoKTC0w+Met7dGcV9L/sh9UeRvDUhrsxdebAcS20hSUoZCA3GFgezNUfcow/7JELudehWwWsYhnfCnrlkZRpRGWMHqxE3nL9id+3XPdWeIN/2IjEOftB14CEyvZJRIN//xmsErUcjhwOGnA5ZsNWgtNIyiqtx0qIZcCiDRaNIg708ah+HRe4DU2LjuoB9mZqcXioAxcne+1RcYqJKzKk4F/mbRgj1L8PPWzxwWOFPg5kiN0bfNfVhNVRMAaCtr0vagUgg4V6UqpZgVHGUmNFpWIv1oMVbKJAArTJZblObJNMiHTkZqI9ZiotO/Njng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuHvWY7QaLS6qH3kMr21kfcYPzqGM1aEdVfVbjK/vUk=;
 b=ZuRhgiWzA0FxlBm2CakP5EMsmJs7+HRLclriANR3VIO5BcBhc3AtO1rW5xVLEGFold6acrKGRgUnKFyc+rJfdtit479hvyZ0N7D3RcIc9c/X2AbWsvsyRPDQm4t0mK8RwzUWfLbx/Pm03AL62nXo+T3Y6HnujORyEvbkyMENaxvaZoo2Z5ft4lN7ywvP08aX0VosHYarqJHnVuZDx1K+S2AIgw6KlSq8RpC3+VHm1FCO9LrYphC4v7BEti4m9XmW5E9LOtUCfGmcSJAcvBWCvanKrFAf28LLdR/m9kTPiE/uX0sgnWCE70kErTc5Jia2xYxwuvUEOe3Rni1hBBI4VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:35 +0800
Subject: [PATCH 09/10] pinctrl: nxp: imx91: Support print pin muxing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-9-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: e53b2913-3bf5-4184-2013-08de7402dd41
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUVDZ3dwS1ZCdE16c1hIY0cwYVRGVTRZWFE0RkxTRHk4SkxvM0t4WW83VXVS?=
 =?utf-8?B?K3RRT1VlQUwxd2MzYVlpWUtHWklzRmhCWHhVZVhSbG1lbi9LWmdidUNQTklI?=
 =?utf-8?B?UE5lNHI5R3lGV0w2VlFtUlo1cXQrUStiYVZWK216NmkxRWhaTklFM3NlWU4y?=
 =?utf-8?B?VTUwUHRJbWpzREJtcEJ2aHFTVm5mZ0pFK0p2VkZFc2RFWGRiZ1VXOHpsMHZq?=
 =?utf-8?B?YkpBTVRZMmM3eE9ycmJoTCtURXhwdExtOGVsQStlZ1ppeGoyM0Y4bHlYd0lE?=
 =?utf-8?B?OFdweUptaFc4dVp2S3pSdGE3bkVFRFk1Z29KR0U1RVBiRE1oV3RjOHhIOTAy?=
 =?utf-8?B?dWpHVDlCM1laYUNhQWtPUXQvbVlQTHp4b2k1L28rcjg3WTBMNzVKbnYzMmhK?=
 =?utf-8?B?eXhWb2tpTTA1eVBQWVl0NjZoUmJ1K0VaQ1FBOVNiaGVLM2pId1dxVXNDVDJj?=
 =?utf-8?B?Y1lsWlltckR3SHdxVWNEUnZzNFR6RjBGWWlGOFNFZEhqV3cyUWtka0JVT1Jh?=
 =?utf-8?B?RU9Va1N1WWFEU1pyaUk4VDRrdEo4SDh4TDBVS2RRcXlUSkNEcDFSd2xMRWlC?=
 =?utf-8?B?akZEajU2OHVFTllxdlMyZVBDcVlIZXpTd0x2U2orOVVmcHgrTk8vdjk1VVlX?=
 =?utf-8?B?K2sxR2IxR3B4NVp4V2NFRnlJOTlZK2pBSkIyL1ZKUkpYQ25LQUpadyt2eEpX?=
 =?utf-8?B?bGVscS95ZjlYRmtYaEFZTXZqR2xwNzlSY3YxNWZsT0M3K0d6S0xGL0tYRU5u?=
 =?utf-8?B?bUluM0NNNklIbmppYlgxbGdJcDJSbHRsU2RwSjNaWnV4d1hoZDFNV2xqTy9o?=
 =?utf-8?B?THJZMnpJcHE3MFlvOXZWcVBydnh5TnVWYjZSRHlpREJ1WkVwc1NOd3VzREVu?=
 =?utf-8?B?aXZUbjlhUGZyRlVQMVVGbUR1eGg3TlVrbFVRRkY5cHBtT0dMcjZvakVxcGY4?=
 =?utf-8?B?cnNzN1NWN0hKT0pFR0J6djFDWnFiSWFQaitreFRWa2RJVTZybDNMR3hTNDk1?=
 =?utf-8?B?L0oyOWxNT3JLVitSMlBMS2RCOVRsU1BZSExPWnFHS3VKRjJjWnFyZVowSTdX?=
 =?utf-8?B?enZJYmFBa2tGTmRSODlLNkxueXdEQlVQZW1IQ2NYQjlQRGJWMGx5b3NyZkVP?=
 =?utf-8?B?ZDdIZWU5aktld1Y1c0tWZ1RRd3R1VDQ5Z3hTb2Z5Vm9qbHh6S2hXZzdiNUth?=
 =?utf-8?B?QXVwWnM0ZDNyQVBUd0FNc00ra04rRktwV0p2VjczaDNWME5VakdjeDdwckk0?=
 =?utf-8?B?WHNjQllCWHZMRGd5cFNQdUpEM21yZStMWUNpcU1QTERsQ3hFNmF3SlljaEZ4?=
 =?utf-8?B?cFVPWVlHSDBZdmxTYlFKcVJ6dTd1YkFIYmthYjQ5eExSbEh4RGtEZ1BzaTNG?=
 =?utf-8?B?UGpsSmkydlBSRnRmRnk0SzFhQjJPbkFMUFp5aTFCYi9pWUpXWmF1SkE4UzBh?=
 =?utf-8?B?aU5rTjZ2RlRRT2QvZVFoQmtpR05LbjJ3THd2VXpVZ0pDcyszbmNBWk1DRTgx?=
 =?utf-8?B?bDIrclpxT1FodG01cUZ6U1Vaa0t0dDd1NzM4OUZWNG5lQkU2VGw4UkJwUnRu?=
 =?utf-8?B?MitxRFZSbFBvK3k2ZGlsQXBYdXNSaUhXR0djVUU4YnpiRDhvR3N0Umk2MkQ3?=
 =?utf-8?B?VU9WS2lNZzBWWkMxT3o1QTFiSGYwNHh6TkovdWVTWWtRODFSWUR3ZnZ2SUZn?=
 =?utf-8?B?Y0NFUlFYUVhXcDRxS01MNmROU2NneWVJUGdRS0c4ZXVJOHNYaTc5aUNtczVt?=
 =?utf-8?B?eFIrZFI5MXAzeXVVNmw1MWNGdGVBMExrVmRyZXJURUc3bUYrcXRQVE9TaXhj?=
 =?utf-8?B?akcxMitUb3Voa1VoUmQ2K3FDUHhyRnY3ZGVkY05IRGg4R1BHSVp5QjI1UzFJ?=
 =?utf-8?B?YVJkR2RDTU1PbHlFdXdNNjAzSTRHbDFobWVCSWlObVgwekUxTEllTk1vb0Nq?=
 =?utf-8?B?cWRyQWRWL2l2THAwUkp0ZmQ3Znltd0htaFN5U3VNdkxQbENxUGMyb0ZBeTZI?=
 =?utf-8?B?MzZqVGNlNkZTaElpeCtvdlg4b0pHZ2dNcjh5YWV1TXE1MWx2QnJqeXNMSWdl?=
 =?utf-8?B?VlZBVHg5N3E0Ui9PdDd3WDFVWWhqMklwN0RPZGxmTXFLTTZPelhCM09rNGIy?=
 =?utf-8?B?bXA2WCtUMm8zc0VLcTZQdi9kbGZnc3YvTDZmRnFhRi8wYXhJOXNxblFTTTRv?=
 =?utf-8?Q?U5RXPpU9Ot02rok1euCbfks=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXJXelpQSGxjWGl2NkZweSt5QmpMZTEya0FTS1NpVWxYMzZybnZIbU1ndmVQ?=
 =?utf-8?B?UnV1ZW4zT2Rac21sNnJWNFB3NFNGSzgxc2M0eXd1QTNSWHhtNHBxb0d6c1Np?=
 =?utf-8?B?TUI2dHhCWjA1VFNzdjBESmhITjFLajkyR2txNmdNZmdDWTVsbXFnUFpFNkVQ?=
 =?utf-8?B?dTB2bldxUVg1amw2amVzQmlRa0pHeVdrRGN5RzU1aU1PQ0lEUDlZMFFMQzAy?=
 =?utf-8?B?MllMRW1LdFVXejVUT1NidEpNMWErY01JTW02TzhTT21XRjQ5ejMwZ2hDdEZs?=
 =?utf-8?B?ZXgra0o4QWF3eFNjalV3c2xWNXp2NTNhWUVTM0FveEZFc0R2NkpUSS9TZnVF?=
 =?utf-8?B?WlBIaVcyVUFFRS9iTCthamJ5enJFRm4vU2J4Tk9OUWNkbzh0bWRsSTVEUmFN?=
 =?utf-8?B?YTFkWGJtVW4yOWZiUWtsTENLU1U4Z3NhWlZScFBqa1o2d0Y5ZVN3UExwNGZK?=
 =?utf-8?B?eWJEL00vK2NjNk1sdTlzK0VWeTBlZmIyUkNJeW9JQ0VlV2dzWThIbkhYMFM4?=
 =?utf-8?B?Tnk2c3VhY1V5QWVCT3IzSjZVekNlWUtpZmd2TExIS1IrVWNlUUIyV2VWcW9Q?=
 =?utf-8?B?c0g0UDczbEtlRDg4Viswc0pTVFRUK1RPMGFlbWEzRUtMRmZRKzQ1czhUcDRF?=
 =?utf-8?B?SU9DTnFocnMvbzJRQUlhOFFhZjcvd01BR1diUXdRTU5vZWdiR1BUTzgvZUtV?=
 =?utf-8?B?Z3RPU0xZZVhxWkgvc0VkVjRxa3ZSWHlMa3l1YlpJSnNoZkNQVUtKUjFsYTI3?=
 =?utf-8?B?WS9VQXdkRWxIOEViQ2xJNWc3b2trYSs4TkZQRUsrUlYvN0JWQ29Zak1zWW4y?=
 =?utf-8?B?UGNsbjE4MnU1Sm02cEN0Y2VXekpqdFhVa0RocUJNaGp1WXBqL0NDakVjNXVO?=
 =?utf-8?B?NGhXY0ZIa29sRllxQjZYZFRJS3lQaUhmb2VhNVFkQ09Zcm5SSWt3bjJRbHRX?=
 =?utf-8?B?T2tKR29tbFJONkVERXNuOVBDOWR3NjU4eW1KN05nS01YQzh6bXRnUEpyRjFT?=
 =?utf-8?B?ZG9xcEFQZThtMFRCYy91YzMwWDNoTTIyQXkwWnFPb3VrazRTZGpwM0cvMzIv?=
 =?utf-8?B?T243SEt2UVBmalZrVUwzL1RNMExJTkdJT21kMkNIcmVtUmJSZGgySnJrOUZy?=
 =?utf-8?B?K3k3b05jQzh2UGV0WmdWWHhNS0JjODFUSEdtRm1GWG1YZGsydGR5SmFlRk9J?=
 =?utf-8?B?eHhZaUNESm9pNDVxSXhSQk9oTS81YTdYYTF6OXJSWjhtUFFSSEVMSTdRbTEv?=
 =?utf-8?B?aDUvNmRRTk9FaVJibGk0YUJZcUVza1h5SnRPUERJZWdjcmJRL1RYaS9iQVRa?=
 =?utf-8?B?elBHUmJTaVBNOTlycUljTklBcklqb2lva0dqV3lVWUorOE9YUzhUL0p0UThX?=
 =?utf-8?B?ZzNSUjJLV3YrMHppMFYvaGlSdW9WYkxBUmxwZzd6NHV6b2FkSVJqekh0TzhE?=
 =?utf-8?B?ZVhqSkhuNEJNaDkvSnp0dDE4VE1iUjlWKytmNktQSURPQ0hweGtiMXl3N3hm?=
 =?utf-8?B?RW5WbjRnUU9wcjlsZjh2YytoUEIvQk1tNTN5MkV1MGJDL21scHlyZTZvLzlu?=
 =?utf-8?B?cDJaUlc2NWVxZStEUWxFZHU5OEhEbUI2V3Q1Q2VyVU5oNkJEclNyVVp6amVW?=
 =?utf-8?B?S2dyZzN5ZWdlOUxmMGpTK2p2Q1Q0WW9oN0h4dnZQckRDRTVaNjZsQVh6RjRD?=
 =?utf-8?B?VTg0cTd3V1ZrNGx6YjVTczVPY2tUcXJIcC9yVGg2eUllSXYra0VjZEdVY0x4?=
 =?utf-8?B?NzJ5eVMrSlQyMXZPK2xqUUNxcXJHUWRmY3d2d0pOMEcxUDdiVnpETzFEQjV0?=
 =?utf-8?B?Qzc4SVNqVHFGOU0xTkhQMmU1d2ZjYzU1SUxhaDJFajVTTkc5R2NZaVpZMC9V?=
 =?utf-8?B?ZWp6RU5QcjR6OHF6V3RiaDU1ZVd5MUhxditvbVQvVndBOGdsdVdTZkYrbkdu?=
 =?utf-8?B?VXZtWVAyMGhZR0NZdktLY1I4Yy8xekJ0QlM4UTJCQVVRc25QYlcrUEROTTcx?=
 =?utf-8?B?WGxBYjZvUit0dTFicEpkc2lwQmpEN0Z5NjhqUU9DNTF6T2h2TWR1djcrN3lF?=
 =?utf-8?B?aXJaOWxQVVVLYWJIVUp3NUlnQ0xhWDM2M1BXQWlDWDR1Unp2eFNuM0xONTIy?=
 =?utf-8?B?WExUUW9RZFV1Q2Jpd3AybFRnbkdoNTFFRzNiYjBoZk05SUxXbCtqKzRpUW0w?=
 =?utf-8?B?MU45VWYrUnJxVDNvM0RyQzJRUkI5bjl0Mk5LUFRuaGNvVy9sVGhlY3ViY1Aw?=
 =?utf-8?B?NjA2eXA2YnprWExkYjBIOHZVQ083SDRVVzg2SFhQb0hZNFZEMzJmUk1HclhV?=
 =?utf-8?B?T3dFbmYwN0Z0R3pqK3FsK21vcE5xTFozcjh3aVR6ZGxac3c5RGVtQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53b2913-3bf5-4184-2013-08de7402dd41
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:38.5039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8If3nq8h8CUVHDjKtf8jRwJr+CDrg0lYozu3tpdhkqV9GYxUMW5ARAo0OC/e/zPZlx6l/rse4YDDvTrP5uDr8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

Add support for printing pin names and current mux configuration on i.MX91
when CMD_PINMUX is enabled by adding full pin descriptor table for i.MX91
pads.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx9.c  |   2 +
 drivers/pinctrl/nxp/pinctrl-imx91.c | 228 ++++++++++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx9.c b/drivers/pinctrl/nxp/pinctrl-imx9.c
index 7e570c6b249..1b7e43901af 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx9.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx9.c
@@ -26,6 +26,8 @@ static const struct udevice_id imx9_pinctrl_match[] = {
 
 #if IS_ENABLED(CONFIG_IMX93)
 #include "pinctrl-imx93.c"
+#elif IS_ENABLED(CONFIG_IMX91)
+#include "pinctrl-imx91.c"
 #endif
 
 static int imx9_get_pins_count(struct udevice *dev)
diff --git a/drivers/pinctrl/nxp/pinctrl-imx91.c b/drivers/pinctrl/nxp/pinctrl-imx91.c
new file mode 100644
index 00000000000..1dc63cda2fd
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx91.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "pinctrl-imx.h"
+
+enum imx91_pads {
+	DAP_TDI = 0,
+	DAP_TMS_SWDIO = 1,
+	DAP_TCLK_SWCLK = 2,
+	DAP_TDO_TRACESWO = 3,
+	GPIO_IO00 = 4,
+	GPIO_IO01 = 5,
+	GPIO_IO02 = 6,
+	GPIO_IO03 = 7,
+	GPIO_IO04 = 8,
+	GPIO_IO05 = 9,
+	GPIO_IO06 = 10,
+	GPIO_IO07 = 11,
+	GPIO_IO08 = 12,
+	GPIO_IO09 = 13,
+	GPIO_IO10 = 14,
+	GPIO_IO11 = 15,
+	GPIO_IO12 = 16,
+	GPIO_IO13 = 17,
+	GPIO_IO14 = 18,
+	GPIO_IO15 = 19,
+	GPIO_IO16 = 20,
+	GPIO_IO17 = 21,
+	GPIO_IO18 = 22,
+	GPIO_IO19 = 23,
+	GPIO_IO20 = 24,
+	GPIO_IO21 = 25,
+	GPIO_IO22 = 26,
+	GPIO_IO23 = 27,
+	GPIO_IO24 = 28,
+	GPIO_IO25 = 29,
+	GPIO_IO26 = 30,
+	GPIO_IO27 = 31,
+	GPIO_IO28 = 32,
+	GPIO_IO29 = 33,
+	CCM_CLKO1 = 34,
+	CCM_CLKO2 = 35,
+	CCM_CLKO3 = 36,
+	CCM_CLKO4 = 37,
+	ENET1_MDC = 38,
+	ENET1_MDIO = 39,
+	ENET1_TD3 = 40,
+	ENET1_TD2 = 41,
+	ENET1_TD1 = 42,
+	ENET1_TD0 = 43,
+	ENET1_TX_CTL = 44,
+	ENET1_TXC = 45,
+	ENET1_RX_CTL = 46,
+	ENET1_RXC = 47,
+	ENET1_RD0 = 48,
+	ENET1_RD1 = 49,
+	ENET1_RD2 = 50,
+	ENET1_RD3 = 51,
+	ENET2_MDC = 52,
+	ENET2_MDIO = 53,
+	ENET2_TD3 = 54,
+	ENET2_TD2 = 55,
+	ENET2_TD1 = 56,
+	ENET2_TD0 = 57,
+	ENET2_TX_CTL = 58,
+	ENET2_TXC = 59,
+	ENET2_RX_CTL = 60,
+	ENET2_RXC = 61,
+	ENET2_RD0 = 62,
+	ENET2_RD1 = 63,
+	ENET2_RD2 = 64,
+	ENET2_RD3 = 65,
+	SD1_CLK = 66,
+	SD1_CMD = 67,
+	SD1_DATA0 = 68,
+	SD1_DATA1 = 69,
+	SD1_DATA2 = 70,
+	SD1_DATA3 = 71,
+	SD1_DATA4 = 72,
+	SD1_DATA5 = 73,
+	SD1_DATA6 = 74,
+	SD1_DATA7 = 75,
+	SD1_STROBE = 76,
+	SD2_VSELECT = 77,
+	SD3_CLK = 78,
+	SD3_CMD = 79,
+	SD3_DATA0 = 80,
+	SD3_DATA1 = 81,
+	SD3_DATA2 = 82,
+	SD3_DATA3 = 83,
+	SD2_CD_B = 84,
+	SD2_CLK = 85,
+	SD2_CMD = 86,
+	SD2_DATA0 = 87,
+	SD2_DATA1 = 88,
+	SD2_DATA2 = 89,
+	SD2_DATA3 = 90,
+	SD2_RESET_B = 91,
+	I2C1_SCL = 92,
+	I2C1_SDA = 93,
+	I2C2_SCL = 94,
+	I2C2_SDA = 95,
+	UART1_RXD = 96,
+	UART1_TXD = 97,
+	UART2_RXD = 98,
+	UART2_TXD = 99,
+	PDM_CLK = 100,
+	PDM_BIT_STREAM0 = 101,
+	PDM_BIT_STREAM1 = 102,
+	SAI1_TXFS = 103,
+	SAI1_TXC = 104,
+	SAI1_TXD0 = 105,
+	SAI1_RXD0 = 106,
+	WDOG_ANY = 107,
+};
+
+static const struct imx_pinctrl_pin_desc imx9_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(DAP_TDI),
+	IMX_PINCTRL_PIN(DAP_TMS_SWDIO),
+	IMX_PINCTRL_PIN(DAP_TCLK_SWCLK),
+	IMX_PINCTRL_PIN(DAP_TDO_TRACESWO),
+	IMX_PINCTRL_PIN(GPIO_IO00),
+	IMX_PINCTRL_PIN(GPIO_IO01),
+	IMX_PINCTRL_PIN(GPIO_IO02),
+	IMX_PINCTRL_PIN(GPIO_IO03),
+	IMX_PINCTRL_PIN(GPIO_IO04),
+	IMX_PINCTRL_PIN(GPIO_IO05),
+	IMX_PINCTRL_PIN(GPIO_IO06),
+	IMX_PINCTRL_PIN(GPIO_IO07),
+	IMX_PINCTRL_PIN(GPIO_IO08),
+	IMX_PINCTRL_PIN(GPIO_IO09),
+	IMX_PINCTRL_PIN(GPIO_IO10),
+	IMX_PINCTRL_PIN(GPIO_IO11),
+	IMX_PINCTRL_PIN(GPIO_IO12),
+	IMX_PINCTRL_PIN(GPIO_IO13),
+	IMX_PINCTRL_PIN(GPIO_IO14),
+	IMX_PINCTRL_PIN(GPIO_IO15),
+	IMX_PINCTRL_PIN(GPIO_IO16),
+	IMX_PINCTRL_PIN(GPIO_IO17),
+	IMX_PINCTRL_PIN(GPIO_IO18),
+	IMX_PINCTRL_PIN(GPIO_IO19),
+	IMX_PINCTRL_PIN(GPIO_IO20),
+	IMX_PINCTRL_PIN(GPIO_IO21),
+	IMX_PINCTRL_PIN(GPIO_IO22),
+	IMX_PINCTRL_PIN(GPIO_IO23),
+	IMX_PINCTRL_PIN(GPIO_IO24),
+	IMX_PINCTRL_PIN(GPIO_IO25),
+	IMX_PINCTRL_PIN(GPIO_IO26),
+	IMX_PINCTRL_PIN(GPIO_IO27),
+	IMX_PINCTRL_PIN(GPIO_IO28),
+	IMX_PINCTRL_PIN(GPIO_IO29),
+	IMX_PINCTRL_PIN(CCM_CLKO1),
+	IMX_PINCTRL_PIN(CCM_CLKO2),
+	IMX_PINCTRL_PIN(CCM_CLKO3),
+	IMX_PINCTRL_PIN(CCM_CLKO4),
+	IMX_PINCTRL_PIN(ENET1_MDC),
+	IMX_PINCTRL_PIN(ENET1_MDIO),
+	IMX_PINCTRL_PIN(ENET1_TD3),
+	IMX_PINCTRL_PIN(ENET1_TD2),
+	IMX_PINCTRL_PIN(ENET1_TD1),
+	IMX_PINCTRL_PIN(ENET1_TD0),
+	IMX_PINCTRL_PIN(ENET1_TX_CTL),
+	IMX_PINCTRL_PIN(ENET1_TXC),
+	IMX_PINCTRL_PIN(ENET1_RX_CTL),
+	IMX_PINCTRL_PIN(ENET1_RXC),
+	IMX_PINCTRL_PIN(ENET1_RD0),
+	IMX_PINCTRL_PIN(ENET1_RD1),
+	IMX_PINCTRL_PIN(ENET1_RD2),
+	IMX_PINCTRL_PIN(ENET1_RD3),
+	IMX_PINCTRL_PIN(ENET2_MDC),
+	IMX_PINCTRL_PIN(ENET2_MDIO),
+	IMX_PINCTRL_PIN(ENET2_TD3),
+	IMX_PINCTRL_PIN(ENET2_TD2),
+	IMX_PINCTRL_PIN(ENET2_TD1),
+	IMX_PINCTRL_PIN(ENET2_TD0),
+	IMX_PINCTRL_PIN(ENET2_TX_CTL),
+	IMX_PINCTRL_PIN(ENET2_TXC),
+	IMX_PINCTRL_PIN(ENET2_RX_CTL),
+	IMX_PINCTRL_PIN(ENET2_RXC),
+	IMX_PINCTRL_PIN(ENET2_RD0),
+	IMX_PINCTRL_PIN(ENET2_RD1),
+	IMX_PINCTRL_PIN(ENET2_RD2),
+	IMX_PINCTRL_PIN(ENET2_RD3),
+	IMX_PINCTRL_PIN(SD1_CLK),
+	IMX_PINCTRL_PIN(SD1_CMD),
+	IMX_PINCTRL_PIN(SD1_DATA0),
+	IMX_PINCTRL_PIN(SD1_DATA1),
+	IMX_PINCTRL_PIN(SD1_DATA2),
+	IMX_PINCTRL_PIN(SD1_DATA3),
+	IMX_PINCTRL_PIN(SD1_DATA4),
+	IMX_PINCTRL_PIN(SD1_DATA5),
+	IMX_PINCTRL_PIN(SD1_DATA6),
+	IMX_PINCTRL_PIN(SD1_DATA7),
+	IMX_PINCTRL_PIN(SD1_STROBE),
+	IMX_PINCTRL_PIN(SD2_VSELECT),
+	IMX_PINCTRL_PIN(SD3_CLK),
+	IMX_PINCTRL_PIN(SD3_CMD),
+	IMX_PINCTRL_PIN(SD3_DATA0),
+	IMX_PINCTRL_PIN(SD3_DATA1),
+	IMX_PINCTRL_PIN(SD3_DATA2),
+	IMX_PINCTRL_PIN(SD3_DATA3),
+	IMX_PINCTRL_PIN(SD2_CD_B),
+	IMX_PINCTRL_PIN(SD2_CLK),
+	IMX_PINCTRL_PIN(SD2_CMD),
+	IMX_PINCTRL_PIN(SD2_DATA0),
+	IMX_PINCTRL_PIN(SD2_DATA1),
+	IMX_PINCTRL_PIN(SD2_DATA2),
+	IMX_PINCTRL_PIN(SD2_DATA3),
+	IMX_PINCTRL_PIN(SD2_RESET_B),
+	IMX_PINCTRL_PIN(I2C1_SCL),
+	IMX_PINCTRL_PIN(I2C1_SDA),
+	IMX_PINCTRL_PIN(I2C2_SCL),
+	IMX_PINCTRL_PIN(I2C2_SDA),
+	IMX_PINCTRL_PIN(UART1_RXD),
+	IMX_PINCTRL_PIN(UART1_TXD),
+	IMX_PINCTRL_PIN(UART2_RXD),
+	IMX_PINCTRL_PIN(UART2_TXD),
+	IMX_PINCTRL_PIN(PDM_CLK),
+	IMX_PINCTRL_PIN(PDM_BIT_STREAM0),
+	IMX_PINCTRL_PIN(PDM_BIT_STREAM1),
+	IMX_PINCTRL_PIN(SAI1_TXFS),
+	IMX_PINCTRL_PIN(SAI1_TXC),
+	IMX_PINCTRL_PIN(SAI1_TXD0),
+	IMX_PINCTRL_PIN(SAI1_RXD0),
+	IMX_PINCTRL_PIN(WDOG_ANY),
+};

-- 
2.51.0

