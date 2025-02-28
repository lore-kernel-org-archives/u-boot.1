Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40528C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8F581111;
	Fri, 28 Feb 2025 11:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C0S11bF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BA481110; Fri, 28 Feb 2025 11:54:46 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF00881113
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDm0FrB9Ded+PYr/ziW+zTc8U+YeX1pK8X1Vprj/OK66HMyLrs7+nLJGYvN1WgEQzD0dEO/fhyL17SBhtd14yDCIUngSBaKb0cUMqnsrqOLM1SPBGdrkQv/LvI0N9gE0PQW3AGo09jSZyjEXqKr31mlnW667rT+Dm7KWSCcWDguLmNs3Xr8tnTq0cu6M9YU7BJxPSe8U4Tj/4MubDJVyPJ9jOT+V4oHqDOV5XQSePBIv2Zh6THobMwJhSvGpkg24jxM/UETUalsvm2iWXjMjmhWFNGojWQ3mqGJXq0BEPk7H8K5QAV6IeMhpfVcfXqGUiE2APi77m5cl4435QMYICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st5UqRw/sYIGNah7xN/2mgvbpMyLU+2JuzMumT3EVAs=;
 b=tLJBLeVya9UhyxN28XuK8yLYdpCZDHVQG4faYZgK78PayNc+9MZLyER7A5ZRzQQa+rAD9ej+qJZlM24J8i7oMaoFSfZ9QKrvHKz9OUXMrPAe27mfgHLVBIcUgBg7qjSCEjHG/ArWoFdJC8qD2aQTme9HrLgPXj3apwwByDUjDFEjIHbNuW95NA+DCG3meG9c9KFX4S7R+xKlgmauLcJvqxkoUkcDFV7KuY4FfpBcdWkgNxl+yv7UTiQQBxpG0L66R140iyQ6gGtR8Jt0HBsVuX2x4rmNywTIr5wB52rLlOtkY165KPze1ZyJZE9H98wqyOVbkYTbPD2Th6GT83ucMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st5UqRw/sYIGNah7xN/2mgvbpMyLU+2JuzMumT3EVAs=;
 b=C0S11bF34U90c3Y4lREilqOms/uXDOTRErHFSydySIF468aSmhRag3DZf8V1xRgdBJ3G7uCAi2naf5PNfH2j4jj/sWIXfbEpSv+KpAD5+MPn1yjfzYhL23TP0TStoqNDSKHqV8qw1GPmxooSis5yWTRk88fVOz4Ro4Tdwt/HhtoNZLsUQ1AvEGzLN1TUkm1s4s6k+HaMJkcSnEVPMgywTMIekqMQz2vFiuxt8YksgokzqYydTqxi+UJleaTDfJBfd3VqfTspsrOHvdZfWyzbD39H6aho8FRPDD4UOZiaP2uuvvYuiEaqw8Wx2s0Dgzt/oJkGwsi8gtFpdpoAWwFRsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:54:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:54:40 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:53:53 +0800
Subject: [PATCH v6 02/20] firmware: scmi: smt: Interrupt communication enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-2-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: f6463bb7-dbcf-4622-94b0-08dd57e64d47
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZERXQTdYZ1p2dG04WlQxbm1JSUR3cktFbDVPempsVVpCbWFobVpsTkIxRkZz?=
 =?utf-8?B?K1RHWE96Tmh0MzFoczB0b3NFejhXUGJSWjJSQ25vTGZFcGRveGxyUVdMMFpX?=
 =?utf-8?B?YXIxdWI5SWg4WTBxQnNXcGRmVU55d3NVM05pU2NkVzFFb0gzUURUd1JFbXhx?=
 =?utf-8?B?M0VPV3JmR0ltU1hURTJGZGZqekJ2K2RHN2c0bU0wdXVweHJpRGRscjVUMlpr?=
 =?utf-8?B?emE5aFVnZXQrZ3A1THhObFNKbEFaQ0UzWjVzNU1KbU1tVVZUN1JoNHpZd1E0?=
 =?utf-8?B?MGFKQUlrdTVHS0F4ZjRodjFaSkpzd2QyenBGcDg1WUJLYTRGanNIZjBGQUxk?=
 =?utf-8?B?K2ZET3JlU3duNjBldnd1RlFkMEVRUmx5L3JhSjUyTmZ2NndkT05KV1NGc3pO?=
 =?utf-8?B?SzczVjNoVkZtOHRwVjZpb0FwRzJ0cEtGSWEwa1RwSHFrWFc5eXhXVlgxNldT?=
 =?utf-8?B?Tk9Db0ZpWUF0Z01VclNKa1k0azV6T1Q3cGJ2MTRHREhGYit0K0RJUkhZR2VG?=
 =?utf-8?B?NHNibm41Z0tWTm1NUXM5dlFxN0I5WFU5ZEpGWDlQa2E1VVlMUlVyYlYvUHBO?=
 =?utf-8?B?S0N5aWxla0duUDNjVFRYSDBTNCtQKzMzMFZuLzJjYnJYa0piTk1qYkt6Rkpv?=
 =?utf-8?B?SExjNXBHNEozeUZOSkJaK1lvc1ZiVU9BQ05FUVN4N0FJdnhWWFRHME00czF6?=
 =?utf-8?B?KytLcUxsbVRxNnBUUnBhWUNOOE5IZnNzam91QmtDc0MrSW9VRktWQ0pnWGo5?=
 =?utf-8?B?MEE3OTlTUHU0QXh4UDZCRU9XemZjU3UyU1o5azgxSlIzVHFLNVIvSHRiUEI0?=
 =?utf-8?B?YmlZTUlHR0VXNmNnbGFPaGEveUpzVmtPa3RYZy9QM201ZjFpWXNtMlJpMHR6?=
 =?utf-8?B?Rk9tV1paU3hXZHhzdUEyRHZPYXhHeXFzS3F5bit5NCtFTU5KV0JHRkM5M29r?=
 =?utf-8?B?cmptNWF5UXFQTXhTaFNKbXY2MGZUQ2lrT2NTMm5wb0NMcHZZenlpc3hXQ1g5?=
 =?utf-8?B?MVhGa2I2UWtUb2ZNWWUzckxTZ2owTXJZQnBBaUNJeERsN1Z5YnMvb0p1NkZ0?=
 =?utf-8?B?c05SWXQrcjJXTCs3TzdNNWEwSlpaSWNKa0tmVkVySnJqb004MjMrWGpFdm4w?=
 =?utf-8?B?R0wrODZ4cUJzT05ZdjE4eW01OVRKTS8vbUhmWVMwdVR4aFkwaWVCKzFhcFkv?=
 =?utf-8?B?TnBlWWd3STFsckMveThtQjNkZS9tUEZaWjI4amhsN0kzblcrempxQmd2L0wz?=
 =?utf-8?B?K2JSb0MwRWw4eDV3TFFDZDkvY3k5REIySDhOdS9ZamZrMkQ1MnVqSkl3MWZQ?=
 =?utf-8?B?eE9ISjh6V3hRYUI0YkhCN2N1ZmhuVU9nV0FhV0JoeTBkU1dIRWptOHpCMnBL?=
 =?utf-8?B?eHd3Vnl1ZlA2ZGg1M0VIbUhadWtPRFBsa0dsanBDWW5TbmIvYmdyVjhsSE9G?=
 =?utf-8?B?VkJwbjJSKzRpTDNIR1huazBQN0lRSkl0T0tyOGpDbEw4OVQ0VUFyTEtRc250?=
 =?utf-8?B?bFV3V0syWjJwTnpqMDVuWVhXWUFUSkR2WUY5NXVRbnY5VkE1YStMK29yWUhV?=
 =?utf-8?B?Q1ZMSlR3R3VTZXBOelRXaWxuekR2RVBWdVBaN0V4QlFlWkZ3MDJ5S2RicHc3?=
 =?utf-8?B?bVI0d1oycDZ5VkppWWRwenl3RWpFNGYvdEZEL1V1REpIVXJna1ZtMTc1UThi?=
 =?utf-8?B?QXBYNFdWNkZTSXRjQlNHY1hObzBQZ2p5UzFCdmh1eW1SemFoK2MwWVNqcTFr?=
 =?utf-8?B?NjVBOEo1Q3QyMkFqTUpxb3pWM0oxOWdyc1ZLdmRYUjd0Rk5VK2NUUG0xdTFt?=
 =?utf-8?B?Um1XR1NCT2R0Z3FpakhFRDVLcXdvRDh3NzNMYVVESS80cDlnbXc5d25hUjYw?=
 =?utf-8?B?TEkxMTJWMFk0R2V1WVVhYW15dlFEZzRBNmdNRDBkVUlkNktWU1R1RjFUbVQv?=
 =?utf-8?B?eVZnVlc1UkZreVRuZ2RHNDg3OVFFVUVNTFhveG1OMDNDdkVENFhMbkY2T1Vk?=
 =?utf-8?B?eE9OL3ljbStBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJCQi9ER2NBOWZ4eTY2RkVXU2swdXNnWlRIdzhDRlc4cFlpdjY1RlMxdlNs?=
 =?utf-8?B?cEU0Z3dwTVpuYW4vVk0zMWovMzVlRlp3Q01GejBBYVozT016YzhLVk5Td2M2?=
 =?utf-8?B?RW1lSkRTTS9yYm81RGVXWlJseURudnZidkVTWkVSYy9Ba0lYendka2x6VEI0?=
 =?utf-8?B?dmxFTzBkVUJhbkFycDg4M1F4QkhreTdvZzB0Q1dnMy9yVGhPaXZ5RzZNbzYr?=
 =?utf-8?B?RTRUNUdnVUxqeDZRRTNUamc1Z2pXTmZ5YnV5bjVCdXF4YlNtZ243UDliUlBr?=
 =?utf-8?B?RFdNUGF1a0ZKNHZiSGtiSEwzTFNJdnl1d3FLRnFic0JGSFZQeG1TYTU3Tmty?=
 =?utf-8?B?Vm9KQTZmK2o2Kyt6ek5mdE1TOVpFYXVCVEptYXFoL1dxSFVrUUNRcFlFV3R0?=
 =?utf-8?B?Y1JvYk5NcnpxMytPR1BmMllDWEdGSjFlV3REb1lwdFVnNVg5ck01eXhMUzF2?=
 =?utf-8?B?b1VSZzdscjhLS0ljTVN4dG12SjlxV0Q0OWtLOXBKZ3JiUlhVWnF2czFwUWJ2?=
 =?utf-8?B?Y3VoR2JSTGpMd0U3SWpqZVBCSUYyVFhJU2lQakZvL1pPU1JENGV1QTNhbGor?=
 =?utf-8?B?TXFWaERrKzVHTjlLZW9odklsQk1pZ1B2TEZCU0N0QVFZZ3V6SkozK2FKR3lZ?=
 =?utf-8?B?SC9VdUZvTzVsRXc1R2JyR2M1QU9pbllyRmhPdFlZc2tOR1N6ZVFNZ0psMTdI?=
 =?utf-8?B?RVlNNWN0UU1TK1pLQ2ZvRHB6dnpwd1hSdjFsVG5ZbGZnc1ZhNWNRb3hNOFdH?=
 =?utf-8?B?MVhhcmNlWHYvcFMvNElBWEtOVEltamR3VFhTcEZ2SzBYWnJjYVFFWlZJZ0pa?=
 =?utf-8?B?clRkWUNiaWQ1Zi83YW9RTGoxVFRabWNtNllvNCtpRFBTa1FjU21VYS9MZ3ZZ?=
 =?utf-8?B?ZWNNQjRxRDJkTUlOa29aNktVWWJYLytiK2FXQ3dKSFlnZDFvNHJ1WE1Ob01K?=
 =?utf-8?B?SUN2bEx2YmFjcHB0SlM5aWlCQlJQS0dqTDlQVjBXVC93STVwWkhvczFiU2Uw?=
 =?utf-8?B?VEQwU01IUEVCWDJ3R0VmK2NCQ25yOG1pMmRVKzJnUXFxT0lPMytGa05SZ1FS?=
 =?utf-8?B?RTB1QVM4Wkl5MmpwemRhcnRRWXMySldmTVNydGJ1bzRuWHZGaCt4b1JjSXdi?=
 =?utf-8?B?K1pQMTVYdEpjWGp1L09qV29PYWMxY3hZQ2pvSnhOYVFoSWZuS2dJZzVmNmJN?=
 =?utf-8?B?WDFoTTVIMWFaSkhLQXJBTnRmRGQwVVF3SGtjbC93dWdocmNBZTJ3WkJtcUxB?=
 =?utf-8?B?Zlh0a1hMQ1UwcjFsU1ZDTHVKT3lKTk80azFrWlBCSEhSSklTUTYyTTZ5Y0Vp?=
 =?utf-8?B?U1lnVjJ5TGhOQldYV3dCVjV2TndURjVFaW1xNVJ5d2N3UXdpOGlFaWdaa1du?=
 =?utf-8?B?WDVLK2xDZ2tPYTQ1YmhhVzF1NGQ0SmhnV2c2RXp2dTl0dE9RWEh6L0NjOThF?=
 =?utf-8?B?ajR0RjFxZGwyY3drTnhwMVpRRUloUWFxZ3QrRlcxaTdCYXlram43TmY3MVlG?=
 =?utf-8?B?aGliSy94aWJOUytsa3QrZGJoY2hHYTBrOFpUWW03L2haaGtNRFRwUCtEK0dw?=
 =?utf-8?B?K3ppUkliUHU4MlkrOUQzVGwzanZwUVJJbjJ3bFlrUU4xN2tyUWJ0WFpjNU4x?=
 =?utf-8?B?S1kvOUp5dUFnV20rRTdPSSthRGc0NUNCRkdHdXg2ZWwwcGtVYVVTbE5CTlN5?=
 =?utf-8?B?bjBHc2dKcFlMYmd4eHhCZVh5VTBlUStaUUgvNXpvTUsrT202ME1hNXg5Zjhs?=
 =?utf-8?B?RysydEpCZVhrY3V1R0Vxd2lhTUNXaytPWG51UmZZNGVjQzFTdXphVXRoV3V4?=
 =?utf-8?B?SzRxbGF5VVN4eEZnUUhXb21vWTBjSGY3aFJqV3FFTXZvWldBUjB3blJ6SEFk?=
 =?utf-8?B?a0NIR1FvblZMdElneXpxcDBUOEE0dy91ZytidktOUTF6T2pneWJCU0lnZncz?=
 =?utf-8?B?U1JrRDBUeWFab1d2QklWaTlTR1k4WmR3ZjVsYWQ2R1A0cSsrVHZNODN1UlJY?=
 =?utf-8?B?MmJEaTdJODNRZDlsNHN4bnR0bjIxbk1vWHdhcWlVR3FpbkZPTnk5NnZhM0VY?=
 =?utf-8?B?UnB3bUV1L3ZtMGl2UVBtQ0pZa0ZrTzVjM0VGdmpoRUtMZ0lzZ3V1bStjd0VX?=
 =?utf-8?Q?ICUd9shmGW8uqRnqz3VRRwlox?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6463bb7-dbcf-4622-94b0-08dd57e64d47
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:54:40.8420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsCxGQub/nQhy1tUHutUeMdc2A3n9AjgTbDdTc5uMuXugh1SRJ1waxeTtCHdmxWvr8v2zvoX15MiJSxLDbf54w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
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

From: Viorel Suman <viorel.suman@nxp.com>

i.MX95 System Manager uses interrupt driven communication which requires
the caller to set Bit[0] of channel flags to 1. When transmission
completes and the previous general purpose interrupt has been processed
by the other core, i.MX95 System Manager will set General Purpose
Interrupt Control Register (GCR). U-Boot polls General-purpose Status
(GSR) to check if the operation is finished.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/Kconfig |  6 ++++++
 drivers/firmware/scmi/smt.c   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index 8cf85f0d7a..eb62b88615 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -41,3 +41,9 @@ config SCMI_AGENT_OPTEE
 	help
 	  Enable the SCMI communication channel based on OP-TEE transport
 	  for compatible "linaro,scmi-optee".
+
+config SCMI_TRANSPORT_SMT_INTR
+	bool
+	depends on SCMI_FIRMWARE
+	help
+	  Enable interrupt communication of shared memory based transport.
diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f45002..a0489f9718 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -20,6 +20,16 @@
 
 #include "smt.h"
 
+static void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 /**
  * Get shared memory configuration defined by the referred DT phandle
  * Return with a errno compliant value.
@@ -48,6 +58,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),

-- 
2.43.0

