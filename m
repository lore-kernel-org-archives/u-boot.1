Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D25C3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71EE388CDA;
	Tue, 17 Sep 2024 04:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rnBFeNnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D539388EAF; Tue, 17 Sep 2024 04:31:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC99488C78
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtYQNQz95znuqSkFi0eJ+lsXhBBpttssLp0mVsxS3AJ693/9bWj5XiIVVRpxE5zUMP9YrQ0LvF7Jpc0anLHSZatHhrFA5jbPmHUNLyUNV3bdkhogiqWPiLMpU0dW5L1fBcwo6k0WyoI5uEbGv1aD+Sc6I3BHykWeErlx0/hvVlB9j/VKa/0h1YWDmDps/Vlg98IbnJ6dLfoF8gxbiP3N84MCh66iELlk06++N8eiHzsTicnUHEhPd4QalDOjEUZLcdm70AWzVeo6ucik/VZ26sr7wTqEtHxidjj6Jiggj9gj2KvNP+6QaYtr2xE1tFljZAcA3WC3OHaeeKus+dUbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS6zDzESkcQTxIJ/smTMCvAvChktkajxvMpxVJPXfvY=;
 b=LDWoaF/Pgq9ZMKa7rTxOAg9ydAlrh4uA0ueLPbkZK+NDRhg4HOvZ89Esx4BWe4azgtHV7vwp3uXVXtJIgN5TUaExW79Q3C8rr+Ke0vTvHkY5WvPLsKYgGUTKB5a/8Tf+bC4P7duaM09ESRI/17Kts95LJ/4TSyrfCRCvfiXbIkyu+AR2N8WsRkcGUFN0/HboBffCEmfVa6M64NhaLgZGp7HAmvntkAx7tteUd9fWmaB6C5REcnR4WomCENrmUcf66GePBBNwAg7Eg/2pgtODp5s2XDV159QAMaomFqRjz6DPiRHTC4VodAepgYljUI0ec9HfSjKvHy3ljSzVD+6FLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS6zDzESkcQTxIJ/smTMCvAvChktkajxvMpxVJPXfvY=;
 b=rnBFeNnmPwZmYc1IYEKZGGTtW7MgKXfhktFoG6AjjvDeKdbUfKLFzgZyD3jE/w0yI2kAkl8A0I868X0rsekUpgTSQxd6hrF3QoIaGmBLT+X+wzjgs2M181mDna3j7AGSXk9ea026aXkrRy4akxDF8ztIS08oi70DojeBazWqKTuX0iVxOC4/r9iZsLTWq8K20SgjTaly4kx2pug3lFi7KOG4cyuck+vnyGcVe+1RVs4MMg2NlESWKpWv/VSnr+3Q6WVA+hYvxo9QsPPjXp+39U3a0mTKx6tI6cFZt2CF6atDYrik58Vwmor82S/TmGqu2jVFpECB7d9z5p+xFfbFCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:31:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:07 +0800
Subject: [PATCH 15/21] imx: generalize fixup_thermal_trips
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-15-4fe8effc937e@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10451:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e6f18e-4136-4324-eede-08dcd6c0cb35
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmlzUUVQOXZNcnc3VlI4K1lHcTFCTGJMbW5JMkJMYzVxUi9BVGx4dlpOaXps?=
 =?utf-8?B?Z3lCdnQwV0tTRUxFbS9aSVhVWHlqUGFIenJNZDFKWHJzL2swOHFlQkZPVkNk?=
 =?utf-8?B?OGhISlRKc2tXWUIxalR2amxOUHd5cGFlQXNVTWliSFEzTjhvODFybzlONStk?=
 =?utf-8?B?cmFNSVJiZ2w2QkpxSkZhbldvYk1jME5mcWhGaS9oeEFEWHBrL3Z3MDB0WjhZ?=
 =?utf-8?B?M3NWeGMrbnNpTXFHdGhUUGh0VzBxNk5vblNrODBGeU02OHVSd2pybS9odWpQ?=
 =?utf-8?B?K1NhY2pvU3lRQmowVGNmaW4rN0NkMGt1OEJvdXFZMFhmNExqTEh0RElkckdm?=
 =?utf-8?B?TGJsZmc0NTl3bXkyZmJXbmhTeCtHM0tNYStKb0tpa3lHeGd5QytyLzB3WnNC?=
 =?utf-8?B?ZkR2d09zZWdRVllSMEtGUFJ6M3FTVVd5UXZ5MTFJUTZHTjEvcXBPTHAvQitu?=
 =?utf-8?B?TjdtQmhjd3NRUS9ndHg2VkRWZWFlQTVCRjgzZFFibGh1MnNRRGJDSDlEUUsy?=
 =?utf-8?B?M0dWaEVpOHp2MXU2UnJUUkpMV1BnY3Nta2Y2UWR2R3dhOUZIRkIrUFFiaFg5?=
 =?utf-8?B?Yit5Q2xxK1UrRWpWOEt6R3MwZktveFQ3c2hkMlFHUU9lRGNobFRZRkFPaVd1?=
 =?utf-8?B?bHJCakZTRS9qenBRTFhFVDEydUQ3MHRVTG5tUVZ3THBlbk5wcU1qT3JqV043?=
 =?utf-8?B?ZUd3L0YzRVhBZ29CNlV2WjVFM0pKR1FpaXpKeStTYzdkMHNPY28xenBxMHlL?=
 =?utf-8?B?ZUtTVHlGMTY4VlJRWDF5VXY1a3hoWDBuQU9pSzhqaklZMEt4V2Qyb29IWlhz?=
 =?utf-8?B?UWlCN1JqTzlxT3FhcnZGdmY3YUZWSWk3c3VSNmsxamk4N21yRnV1VG5ZdUNj?=
 =?utf-8?B?aXJjWFNGTTJCU0lkRFdBYlp2UFpOYmlTVjRuMGxkblM0WUV1VDVXZXJURGtv?=
 =?utf-8?B?cVJVZUlxL0xtY3dNai92N0ordEZZZlo0REVVcGNDWjhHYmpsYmwxQVc5Q2w3?=
 =?utf-8?B?THlLS0N0TEZMNWY5cEtZc1p3RmYxTC9zUUh3U0t6OHUvRXRSM1AyUVBzU2JG?=
 =?utf-8?B?Y3FZU0NTUHlOTGRndDFwekJmclZhM1JhOXFHNHFhR00rczFSaFp6cmxoZnNv?=
 =?utf-8?B?ODcwRGplY3hjNXZLd0FtTDJnTkFmUDNrUW5RcWNzK1JDWUo3SUFub2NWVnZG?=
 =?utf-8?B?RTBiVHY2NitUQkJKS21ncXhtTFdNYUc3MUZManNCU0oxeFU4RG0xSzB5WGZa?=
 =?utf-8?B?TEpSaTZ6VEZIMDhVaHpkYmZUb3loUWg0RTZRMU9kNTFRTjBZbXBLMUMwdWZD?=
 =?utf-8?B?Ulk0cTB0L0tueStmeWVxdG9saWdXM1FPSURhblNJR1RqbzNmSmFPRWdoTllZ?=
 =?utf-8?B?WUd2aG03VlhpcDhrWjh6Z1MxNDRQcTF0YW5sejl2Y2U2NEowbVBtWVR1ODhE?=
 =?utf-8?B?M0V2UFdPOG55V2cvQnpiTllGNmVMeW9uNzFiMFB6SktnY01wRDhhc2NORzVR?=
 =?utf-8?B?UFdWN0o1di9qUTlOcldORUIvT3NyNUFobi9rVWc0Q3liZHRYaldhWkJtQnR0?=
 =?utf-8?B?WkhLN0xqL1dvK210YzRkYkxIOUdsQ2ViMWZRWWdWZjdaWHhhNEU3clNHeFIy?=
 =?utf-8?B?bmFYZDd1cmZoWEY4VHZYM3dMRzhtQXBCeGd1OVpudFpTaUlVWWVqS0VJZVlY?=
 =?utf-8?B?TEdTejZ6emhlcmdPTnFESHJqSmdLVGlVV01wdHF0R2NtS3lxb2hmSk8yR05J?=
 =?utf-8?B?d0dZVE5Qa3cwV215NFdNaHptK0k4S2VtalFaTk1TY3I0eG9JT09Oc2J1ZmJ6?=
 =?utf-8?B?V2QrUFhSWmFqSm16bE9jM21ob2hLVkpHZm5Pc05KWXp5akFxbEh6dmZPUDYy?=
 =?utf-8?B?bnNDV0VZUnZWUUd4dXdxL24wLzlpemdCb25EZThDYklxRVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2VPcGF1Z1lLTTAwWHc3bnRNR3hrYXgvRmJRb25xRGZuVjZQSDhPL3hVQkZy?=
 =?utf-8?B?ZDRwL3pObnRPcXBBMDVUVnpNRGZMektuWUNjZG9ubWMxZzdsbWcrNm93cldy?=
 =?utf-8?B?dHNrUnY4TFNtNFNtcDJ2Zk1VQlRkcWp5R0U0K3hCS3R3d2hudmNRWG9rV3Fk?=
 =?utf-8?B?OEg4Z2xrRzlnY0VxQnlISFpDczhDSUlkZXgreWFVaUN3Q1Q5YVVMN01CN3o3?=
 =?utf-8?B?eDFHSS9weVBMejNLY0s1c2tUbHJYVUF3alB6SmdYSGxWcU5IaUVFNVRVa00x?=
 =?utf-8?B?MlZ5elV6S0x4OU5Sb3RLeUJGcnNwK2xTeVdCQkpnS0c5eStVMXdXNFBLMEI4?=
 =?utf-8?B?a1pWSkJuQ3hFeFIwMlZJNEFFR1djMkJMMTNpbG92Ym9mV1JzRVlVRCthcHJp?=
 =?utf-8?B?Y1JSdjA1RUZRbTk2WFNzdCs1akp2OUU0d1BKNkd1K2NQMFhHd1ViTlhrQm03?=
 =?utf-8?B?SjdNc2hPTk9BK3dFaDhPUG1uOXRyamlMTkZPN1lJWmx4c0NMQXMvRFM2dmpE?=
 =?utf-8?B?czYxSTNKRlRuQzB5ZlE5eFdTcDF2K1d1dVo5U0RiYjVKd1lSK1p1d0krcnFs?=
 =?utf-8?B?MmhSdDYxNUdrWDlubEVzRUpoOWJ6SkhLNWRsYlJtaVdLNVpnb2ZLSmdSSWM3?=
 =?utf-8?B?b05qVjJLbThKdzNkbjdXQkxHVXdia2xsYjNBVWRzOHFiZm8rSkxBTDgrdjRs?=
 =?utf-8?B?WXVpMzN5VEJZaXZqZUdlM2UvUVVubU1namJ3RHRTVFlReGxSMStpVk1sNlZY?=
 =?utf-8?B?aGV6K1ZrS2lsMzZHblhXUkpBZGtxbDdNdTdzaEE2U2lyQlhoTzRxSkYzNUE5?=
 =?utf-8?B?K2NaMUw3eE9rUFkwNG1hM0hRREJvakpqdlVSb3A3NFJadXFGSnVRdmRqeW9q?=
 =?utf-8?B?Y2lQZWttK1BhSUhMQzBsUkZUQXZLdFVHUDE0SnpwejZjUTA4QzlURTN3TTZN?=
 =?utf-8?B?dXhuSW9BeFJWZmg1WGtvS0x2SWJMc0UydEV4RldGb2dEYlRoOWNSdUNYQ0Qr?=
 =?utf-8?B?cTI1aS9oUEluN1NOTFh0SVpZREF1bDhhbXl4T3BUWEkvNldVaEJzdytIMXNR?=
 =?utf-8?B?UUtnMkdNdVozaEhib3VvSlVMWHpDWHBjUmZ6N0w4THFlYVQ4SVVzWmthcnBO?=
 =?utf-8?B?ajg2SzlXOW9jWGxGTEVkb1hOTGc2blZWRWhsaHVUL2ZiRDN6V3lWaEd2UlNL?=
 =?utf-8?B?RmxFT2Zmejg5b2VsUzVXcVB0YjI3REJlOFRqNXgxNjJQV2xXWUpSa1B0dzlQ?=
 =?utf-8?B?dDhteXQ4RUJZL2NzQ0x5N0lwWXNaaktRQk41K3EvRStySUllOEx4MDhTcWFq?=
 =?utf-8?B?QkR0dWhRWGszem9URVN4aXBVMVREMys4ODA2WkRCb0dJK2p6R0lyWitCeEZB?=
 =?utf-8?B?TFQ0Y1FxZmdSLy9COGIzaGZUMDc2N01HalhBeTNlUEdRbzVNUnAyT3JlN3ZP?=
 =?utf-8?B?bmxiZ0FiZHA2UUNSdkJTK2tobVpGNGF4Y1RyaVRxRnlzdnVkdzZMSktlM0xt?=
 =?utf-8?B?MjFCTkRobUNrem9EelNEa05rYmNKU3VKSy8zemgxSU02WHpMNVhzUFV0dmRj?=
 =?utf-8?B?VDM0NXg0eThGV0JEbFZ4bDNYeGxtUnJGaTgxUzZOUUdGa2xidVk2UmpxbllB?=
 =?utf-8?B?WlBrdFcvM3NtZ2lVQ0pwc0ZNZmVTTGtsQi9sekwzckcyWTM0b0pia1lBWTNH?=
 =?utf-8?B?ci9meTZBc3dmMS9KNVZlNkdlWjNZak1CbGRxNlROK1gxU0VMN1E3Mnc4NG9F?=
 =?utf-8?B?U1QzclcvZFRtUng0S0U3NnhyeDgvM3F5MkJBc1FRN0R2ZEd3ZlZ3Q1E1NGs2?=
 =?utf-8?B?c0M5ME54TFplMTFqRnVBWUlSRTcyYUdKRjc0UElLRjVDL0hDMTVQZHUzQkov?=
 =?utf-8?B?K0t1MnNmTENjY3l5bDJoUDZZSGZZNEhzNXp1ZWJySjcza0pQaHRlemc1WE5M?=
 =?utf-8?B?VGFxOEpnTi9STEx3UENZZ1NRSGF2bUhnamdLdk9maHBvaVlPSFpGN1JKVlc2?=
 =?utf-8?B?OWI2UUZ4MzhGMXlMY0F6Q1Z4L0ZVRjdVNG5hOU1oYVAwdzdHckJYUEM0SGY1?=
 =?utf-8?B?N0wvZTNRMzZ4c3p3bFc5aGFRa2F1OEluUG1RU1JmSDh4SmVSTWwwMTlYZ1lL?=
 =?utf-8?Q?0oWAyjyX6zPQ7soMyX/wBwrVl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6f18e-4136-4324-eede-08dcd6c0cb35
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:11.1975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3wJN06YV8JLtNn6UyPxuNPDH9FpJsxbyEhd2yNozOnDbKrLAaYodxpiV699M7VMh6rUSdkp2B1ChgcXyUq6/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451
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

i.MX8M and i.MX9 have duplicated fixup_thermal_trips, so move it
to arch/arm/mach-imx/fdt.c to avoid duplicated code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  1 +
 arch/arm/mach-imx/fdt.c                   | 42 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx8m/soc.c             | 42 -------------------------------
 arch/arm/mach-imx/imx9/soc.c              | 42 -------------------------------
 4 files changed, 43 insertions(+), 84 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index c146a223b71..31ace977d2b 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -280,4 +280,5 @@ enum boot_device get_boot_device(void);
 
 int disable_cpu_nodes(void *blob, const char * const *nodes_path,
 		      u32 num_disabled_cores, u32 max_cores);
+int fixup_thermal_trips(void *blob, const char *name);
 #endif
diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
index df6fbf51dba..ac782e3ee63 100644
--- a/arch/arm/mach-imx/fdt.c
+++ b/arch/arm/mach-imx/fdt.c
@@ -85,3 +85,45 @@ int disable_cpu_nodes(void *blob, const char * const *nodes_path, u32 num_disabl
 
 	return 0;
 }
+
+int fixup_thermal_trips(void *blob, const char *name)
+{
+	int minc, maxc;
+	int node, trip;
+
+	node = fdt_path_offset(blob, "/thermal-zones");
+	if (node < 0)
+		return node;
+
+	node = fdt_subnode_offset(blob, node, name);
+	if (node < 0)
+		return node;
+
+	node = fdt_subnode_offset(blob, node, "trips");
+	if (node < 0)
+		return node;
+
+	get_cpu_temp_grade(&minc, &maxc);
+
+	fdt_for_each_subnode(trip, blob, node) {
+		const char *type;
+		int temp, ret;
+
+		type = fdt_getprop(blob, trip, "type", NULL);
+		if (!type)
+			continue;
+
+		temp = 0;
+		if (!strcmp(type, "critical"))
+			temp = 1000 * (maxc - 5);
+		else if (!strcmp(type, "passive"))
+			temp = 1000 * (maxc - 10);
+		if (temp) {
+			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 68d5762c2ce..dd2d1796e3d 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1166,48 +1166,6 @@ static int cleanup_nodes_for_efi(void *blob)
 	return 0;
 }
 
-static int fixup_thermal_trips(void *blob, const char *name)
-{
-	int minc, maxc;
-	int node, trip;
-
-	node = fdt_path_offset(blob, "/thermal-zones");
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, name);
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, "trips");
-	if (node < 0)
-		return node;
-
-	get_cpu_temp_grade(&minc, &maxc);
-
-	fdt_for_each_subnode(trip, blob, node) {
-		const char *type;
-		int temp, ret;
-
-		type = fdt_getprop(blob, trip, "type", NULL);
-		if (!type)
-			continue;
-
-		temp = 0;
-		if (!strcmp(type, "critical"))
-			temp = 1000 * maxc;
-		else if (!strcmp(type, "passive"))
-			temp = 1000 * (maxc - 10);
-		if (temp) {
-			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
 #define OPTEE_SHM_SIZE 0x00400000
 static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 {
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index d00162c6fdf..9ec8ac2599f 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -530,48 +530,6 @@ int print_cpuinfo(void)
 	return 0;
 }
 
-static int fixup_thermal_trips(void *blob, const char *name)
-{
-	int minc, maxc;
-	int node, trip;
-
-	node = fdt_path_offset(blob, "/thermal-zones");
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, name);
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, "trips");
-	if (node < 0)
-		return node;
-
-	get_cpu_temp_grade(&minc, &maxc);
-
-	fdt_for_each_subnode(trip, blob, node) {
-		const char *type;
-		int temp, ret;
-
-		type = fdt_getprop(blob, trip, "type", NULL);
-		if (!type)
-			continue;
-
-		temp = 0;
-		if (!strcmp(type, "critical"))
-			temp = 1000 * (maxc - 5);
-		else if (!strcmp(type, "passive"))
-			temp = 1000 * (maxc - 10);
-		if (temp) {
-			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
 void build_info(void)
 {
 	u32 fw_version, sha1, res, status;

-- 
2.35.3

