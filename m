Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CDECDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7528907E;
	Thu, 19 Sep 2024 02:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="avJy6qbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E308909B; Thu, 19 Sep 2024 02:15:11 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B878905A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/LyRWIqx3qmPwoS8RC1lB8dt/Q9Ghczkh6jbSk8NsNTbx72DhfbXV2VekVhGV91ZY4ohSCAkMW7+r3IjBm8RQWshG+KEzmNqIFoX2ohnxWWyHalqXe0s1Yusxjnd7U3MoDWSX234btEobdR4lX61DHXOQ2gRtKLYau9PguyWDU5kbNFnfNUwKcYHQLYzDM97VrBF3KRqaVs1v1vXki/FwUdH3zGTcCDp6EujevOi9jPRMNkXwKMwr/ZRmgN7Ku4uawuN+51fm2bgJcd11PyRDgDrGzZ2fAidEUHHjRBVuMkVX1TW2iybiV+p04CXek3jzHEFd0+sKruG+gcTlKFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pirdr+D/Wtw1fONc9vSw7kt9bR+2umQwfJVbJZEwCio=;
 b=Y90U4MVkERmvUi0AAJVC8+WjvSSlJSciqwbXkP5zGGDYLl7L3gRykSG7puIxlgvdTdVttxy+xffgymQddCbMpYpHDC1PXAHlYtzMyQvqBbKkvO7Xauvgw+WISV5YknH3oPbqYPz+9/C9QLGvM2if9WDn39QO4dcUWfy8boSjoJ47h23fuVenEtWYn8ytHr+qYgSuzbBLloDbOg4AlFNKxn8ZK8AowMQaYkm82DqjE8/4UY1NBl3QAgO4MtAmiJIRPOmD9s8v6MY4Itx28ZHaD7raypxBaypqGnr57R1Q2BkqKN9Qi8NjSwkI35wF5pb2i7/+FIIWYeyazS1MALY+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pirdr+D/Wtw1fONc9vSw7kt9bR+2umQwfJVbJZEwCio=;
 b=avJy6qbreqTMb6O3GwWcUd7fPiiqwDAJ47K5mdYuBzR7lzfpxwvhA9ezKKM0zFA+QDJqDcjgJwmMeXpXOlQ75+YpXexXL0pNy45siKSTfc6jVpl9B9XQ9GdIfgql95gVFIRpZA/1kI6dn0LgjmXOX73wJcXkkV4wioVmifm+gf3E8dzc80fp/loGBPwZtE1G0UEwSMTzGSP3IkWJz8tnk5UZdEHQjnvAl0piGxuEWzELLTzA5ce+jO+dzTty99vyo78xLEo2oYc/oEZZUqcZM4OiJfcgnMwTjvQk0T4hpWIPbEX3uGbO/t/Dk5kScB1aTksuPv7M300Hxln0j5wWkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:08 +0800
Subject: [PATCH v2 09/21] imx9: clock: Update clock init function and sequence
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-9-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: d490b38f-7dd6-478f-754a-08dcd8401a90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW5VV0NXdVNoaEc1S0YySU5QUnpkOHo4RWJzY3MxSS9UNmNqd001MkFLTXB0?=
 =?utf-8?B?UlBwL09xbkdnalMzTUZpKzNkWi9yNTM1WFU3bjZaZWVlK1pqTzJ6dC9ERGxB?=
 =?utf-8?B?N0hqbXRTUTVNM1Q0cVpUcGRwcWdWemFQNzFJeldLWDBrRXlTbUc4bDNMSUxz?=
 =?utf-8?B?ekhjcmcwcE9oQ1ZaZ2E4QjZZYUhBQ2YxT1ZvUXpNZXQ5ZzZxTDZZMWNyb3Bs?=
 =?utf-8?B?NThZRmk1elZmcDgwTVo2TjVkbC9haHBLcXNLZjAzVmdYMXlhc0pwSUx0QU9s?=
 =?utf-8?B?SjRNczU3UjRDVnZib1lMNWY5SFZ3UmM0ajFHcVp1cUU3b1RlemE1ZXBHUDAy?=
 =?utf-8?B?bWtFeGU1clNDbkVHMWhvdFVMTmpxVVNhV25NeU5qMThWUzEvdHNmL010WFcx?=
 =?utf-8?B?dExFU1hSdXRBdlJHMlM5ZHVjaU1oOUZjVHNYRElQVXdXd2tLSFdVd094aW5D?=
 =?utf-8?B?RnNGanpoai9VNFR0Z214cCtvQVRIcWFGUTJyelF0ZTRZNGx0YTEwckhxUWJo?=
 =?utf-8?B?S3RVK2tmcXBpOE9MTEF0Vm83ZmJ3UmFBNExKd2h4Q3NmQ1d0S2dEb29LazJB?=
 =?utf-8?B?c21KdGRhSHZ6U25HSmlneFF0ekVqZ0M5dURVZWxnditGZUs4UDdnQnN2UGxC?=
 =?utf-8?B?N3ZwdmlyNFlKWmJhcGFZb2htcG1FeFMxbnE5K1FCeE9ydDlseDd0YlZCbDNY?=
 =?utf-8?B?S0FGOUJIVVlVSDFWYVdHMEZHUFhpRlhtSzZWY1BvTHZTR2F3b3oyT2Y3UUNs?=
 =?utf-8?B?cWNRcGk5THgxaklHWXE4eW5TYXRKc0tTbFB6YUJXSEY4eW1WQzhCSEZ2aGU0?=
 =?utf-8?B?dWQ3S0xHVFIrRlJZRTIrdzFuaVJWTWNDcXFadjRCM0lIeHA2V1RvRDNFKzhs?=
 =?utf-8?B?RTNmL2c0NkFtdlVnUVlDVGJNQnlKZ1VlZk5uYjRqQTB3YnRsTHBhazhmZHA5?=
 =?utf-8?B?V01ISU5vYXNST1k5b2RPdHBDQWFNdDVQRzc2d2h2ZURBcGdXTVBuRTdXWXht?=
 =?utf-8?B?ejJvU1hWTU9Wa3JBUThwaHNhT0RCSlgwcmNzaG5vWE9xTWJoenVabDROZWJM?=
 =?utf-8?B?YkluMlB2TTlEL2FjUDVQdGZyU3FwOGl5UDhLTTZOeERRaXdBaktOemZtN3N3?=
 =?utf-8?B?MmhMaE5xR2hXMjRCeFVZZ0VJMEFvazdLUDR1VWhJdStYN2hkTjMvZHFGUmR5?=
 =?utf-8?B?WCtuNkdyNUJHQkNjQUoxUG9pVTFTd2RmQkhIa1lZNjRSTDVLdWQrWW8zdFVj?=
 =?utf-8?B?U0VxVkJKamdsc1hoRFFHR2N5NHZoWnBsZHh1UC9NS1F1enpzd2hnSkhNUFIr?=
 =?utf-8?B?cU8vWDVISHBXbW9WaTJJQ0h0NXYrYmo0cW9FQkZSMW5uUk1wQTJZTkZhc0lx?=
 =?utf-8?B?Z2NmWkZnYjdqMUtwNDNNaXRxS2svQitmUU41OERmajJva09YTUpnVHZvMWkv?=
 =?utf-8?B?T3RKQnUyWXQ1YStEa0RjQVhxVmh0RSswbm80bHNEWWsvL3FmNzhEdVl5VWlz?=
 =?utf-8?B?M0QrNTR2bEVra3NCM0ZFQWdTaElzcEh5TDVKSU9jcEc1R2hrQzdlUlk3WXg1?=
 =?utf-8?B?L1BJSmRUWklkeUtwTTlrbGg3ZWRuTll4SmZKb2EvWFJoV2hobTJxWUM2VFFW?=
 =?utf-8?B?cnpOdUVKbWpSaXZmbEhOb3oxSVVKR2FMby9MeWE4TCtodnZDUVJuQ0Yvb29K?=
 =?utf-8?B?WWhIYS9iWjhzZklQNlljT2lvNEpzaVliVitKVjVkQTdnSjRCZWIydndZeGNJ?=
 =?utf-8?B?MUF6ejhVL29zMUV6bTBSRk1ydDdtYzBQWE50bzhjWEtWUkt5cGcyL3QxemxY?=
 =?utf-8?B?NXJXV1ErNDBGZTgyWW9xd0RQbHZQcE5BNzJRWFFtVEVaNVNGRGFQK1padTcy?=
 =?utf-8?B?ZktiTWd3T1hUbGQ0WkVjOTN0L0ZxZXJjUUZlN01yaW1XdEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1SRGJhSmZuT0g5R0l6clpyNGRUNlluY05yZit1VUl5RW1rdjl4aEJSb0VP?=
 =?utf-8?B?b3diUUloRmgrb0p5Vm1qbTFVSTVhQ0xVS2JmQTNxNDFvNEg5WGtjbWRwL2RU?=
 =?utf-8?B?UmdHVmNKMGk2ZzZHMVM4bUtBQnVLTTUvZ042Tmd4MHE3WlpCYnpUbENmQkI2?=
 =?utf-8?B?TGo3VWJIVFBPcWtWMGhNLy93ZHhuTWdlbFpLUzRqMVhnalNGNGs2SXBXMUpp?=
 =?utf-8?B?SWdVZkVLWStxUkVEaXJKVW1PYW9adWpwdm1CM2RDTXRBOVlLRE5qcVBRbVVW?=
 =?utf-8?B?dDluMnRzRkxtUXVVTW94VFNMV2JaRkFEMDJnWlJuU20xcUFBU2QxUTNHb3J3?=
 =?utf-8?B?N3cwUWNONkV5Q09LSkMvSFlpd3JsdnBlNi9KVjVSK0xtc0lkcHE3djcrQk8x?=
 =?utf-8?B?a3NtTlArSlc0WEhKMnRSaUNwKzBxSVJEYlJwK2luU2NBNGZFcWxhYXRTaHQw?=
 =?utf-8?B?Nkd4UzN4RVlkS0pDNjR5TlliVG5XZXRyTm1wdUZsVzYrOFo3ajJEVEdyTS9o?=
 =?utf-8?B?SkpRSUFEME9KQmRDZjlreTBIK3RoaG9mNXRrdmh4MEpLeDFpV1pFeHROdHcx?=
 =?utf-8?B?cDUrYUNEZC9ZNlNPOGw4VHp5QkV1T2E0RURSR044WnhzSC90YU9HajBjM3R1?=
 =?utf-8?B?TkRjTzFwZGR2aTRhUnljTGdqeWZWaWFRRHJXbnZpRjFDM0VpNU84Wmhtalky?=
 =?utf-8?B?MFg4cmY5aVlGeFNtaWs5blNvYXlTTEpCNzVTSWphRmQ4azVhcFUzWmM2aXdv?=
 =?utf-8?B?Nzk5N1NXcFhDWU9ZMFpTaUp5SmNPTVBFaFJoUFlzVkp1VXRqSjRIMHh6emJM?=
 =?utf-8?B?cHJwRjk4MVRoTWpQcU1pb28zOHZ2dDR4UHFaS3lzclUzbzFLNHlMdHVya2JU?=
 =?utf-8?B?Wk9ha1J1cXNMc2JtMTFhUVIvaVpyUnozU2E2SHZ2eWZ2MVlUQkx2MjZjZTJw?=
 =?utf-8?B?ZGgwSDRyRXhKREZzM1lUYjI4aW9YbUxvcTVMdzM2Nk5Kb3FLeGpwaUhXWEQx?=
 =?utf-8?B?Q2hpTkpCUXRObmI0NC9OMTJ4czdReHc5Y3hJbGxDbG5oZHhNN1dsczhUdVBT?=
 =?utf-8?B?U2VuZy9EWWwremRaT0dFR2U2SUVFYVAyS3RyNGM0WFBsdkhiRng4a05ldTNk?=
 =?utf-8?B?cGN4M3pmYUZ3VUR2dGM0WklMSEJIWWZJVTZPbTlyVHAyeVZBQUJxdGpsNmJF?=
 =?utf-8?B?MFB1NENRanZ2RjJiZi8wNWRvMUdKdjhHU3hFUmVUWkY5OFNCQWd0VjZrMFdr?=
 =?utf-8?B?ZC84SUU5bWFrWHdGM2VqQXN5R3ljYW4wL2MxWWFNeGhjZmlDR1duQ1QwQ3E3?=
 =?utf-8?B?TE90VTZodG5RQzErSXFnMFFZaUdLU3AyTWYyNENMZ3IzbS9aU0FuNkZTVDFG?=
 =?utf-8?B?aTc2b21PSGhjeGdDWFAzZnhKVGM3MmZEcUR6RnlZalhndHJJTUlDaytkUDBN?=
 =?utf-8?B?eXFJS1JtZ3p5dW53d2VBbGprVzljRUVlVVNQSTg4eEdOcVFrVlFTOFp3Y3JG?=
 =?utf-8?B?K0ljUWtNUmZqWjRKcnFYM09UNzEzVU5KdzVlZ0JQT0g2cXVSSDhKWncxMDJo?=
 =?utf-8?B?eEE0OXFVMzV6eUlPb3g5TWJxWk1tN1QvWStEYThhWTJMclpTNWxMZk9zV2lM?=
 =?utf-8?B?Z0dvbTJuTHNGSmtTcHp1ejdoemh6ejB6OXRBMXUrVlNZSEpJUU45YXNVQkMz?=
 =?utf-8?B?TFkvL3Q1RHFFS29XMXdDSm85ckJ5dUplVnoxdkpkek81OEVRTnpaSzdXN2Jy?=
 =?utf-8?B?WGdFQnU5Z21BSGlEV0s0MStiMTZQZTU1c3N2bTdMOFVMU2wxcEM3Z0t3ZjBj?=
 =?utf-8?B?dkkyL1lqcTQrNG93cEJQWjNqRllrM2RJMkdKZXIwT2dSTkJCTU91TzN6RFpS?=
 =?utf-8?B?NDRGNGN6SFRMT3ZUamVRZHBjSjgweTM1dkhBcjBGM1ZkK2VXZFo5MWtMa01H?=
 =?utf-8?B?cVZ3RnZpcU5DdHBuYldMd3l2VE9kYU81RDZ0bVYvUDJaelhjWFUxakJhL1FJ?=
 =?utf-8?B?WWtpQ1F0Znk5WFlORnpjQzZmdFd2SmRYaWVpNUs4VTcwR2M0M1ZISFAwTU9a?=
 =?utf-8?B?SmZ6RVgyWjRMcURDRXY3b0d4UnI4QnhuVEhPUFVvRnBFM3NjL21leXplaWdP?=
 =?utf-8?Q?DvM67iET8IZoUYH2ovNkYpG2d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d490b38f-7dd6-478f-754a-08dcd8401a90
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:01.5794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMVuoavpq+H8m/D0LjwLfnlr3ML1xQa/zFEFd9FdlZkVlfVXiTb501KnyUwhJn7NlgHjeyLAsM+XiXaO68FABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

Since we use SPEED GRADE fuse to set A55 frequency, remove the
set_arm_core_low_drive_clk function which has hard coded frequency.
And adjust clock_init called sequence and split it to early and late
functions.
Set the authen register in early function, because CCF driver checks
NS bit.
Set bus and core clock in late function, because the fuse read and
SoC type/rev depend on ELE.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/clock.h |  3 ++-
 arch/arm/mach-imx/imx9/clock.c         | 22 ++++++++++++++--------
 arch/arm/mach-imx/imx9/soc.c           |  2 +-
 board/freescale/imx93_evk/spl.c        |  4 +++-
 board/phytec/phycore_imx93/spl.c       |  2 +-
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 1ce6ac4c3a8..76f12118592 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -211,7 +211,8 @@ struct imx_clk_setting {
 	u32 div;
 };
 
-int clock_init(void);
+int clock_init_early(void);
+int clock_init_late(void);
 u32 get_clk_src_rate(enum ccm_clk_src source);
 u32 get_lpuart_clk(void);
 void init_uart_clk(u32 index);
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 1433e68874d..76d19f1cba3 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -782,17 +782,10 @@ void bus_clock_init(void)
 	}
 }
 
-int clock_init(void)
+int clock_init_early(void)
 {
 	int i;
 
-	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
-		bus_clock_init_low_drive();
-		set_arm_clk(MHZ(900));
-	} else {
-		bus_clock_init();
-	}
-
 	/* allow for non-secure access */
 	for (i = 0; i < OSCPLL_END; i++)
 		ccm_clk_src_tz_access(i, true, false, false);
@@ -809,6 +802,19 @@ int clock_init(void)
 	return 0;
 }
 
+/* Set bus and A55 core clock per voltage mode */
+int clock_init_late(void)
+{
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		bus_clock_init_low_drive();
+		set_arm_core_max_clk();
+	} else {
+		bus_clock_init();
+	}
+
+	return 0;
+}
+
 int set_clk_eqos(enum enet_freq type)
 {
 	u32 eqos_post_div;
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 331c73675ff..112773f98f6 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -741,7 +741,7 @@ int arch_cpu_init(void)
 		/* Disable wdog */
 		init_wdog();
 
-		clock_init();
+		clock_init_early();
 
 		trdc_early_init();
 
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index e4999baa95f..2ad7489ada7 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -123,9 +123,11 @@ void board_init_f(ulong dummy)
 		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 
+	clock_init_late();
+
 	power_init_board();
 
-	if (!IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+	if (!is_voltage_mode(VOLT_LOW_DRIVE))
 		set_arm_clk(get_cpu_speed_grade_hz());
 
 	/* Init power of mix */
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 5efa38a1442..17a8736c73f 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -130,7 +130,7 @@ void board_init_f(ulong dummy)
 		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 
-	clock_init();
+	clock_init_late();
 
 	power_init_board();
 

-- 
2.35.3

