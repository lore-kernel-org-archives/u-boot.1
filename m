Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1A3CAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 970378350A;
	Tue, 23 Sep 2025 04:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ACHLtTJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C4EB835B2; Tue, 23 Sep 2025 04:15:35 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B27283211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW6QL6swPtFsxrWNcjVsB9s+ltqVsFprteltNmyiUNTCgNqvLx1AkGjKBk8ZeuWu3W6xSRVgREsY76iTWXz89dUtT6JbWg8qq5E8zbVJZgNwvQoC3Liv7ydl4/m4LEPURhHL32ansv0+VPGiqtlpcyRunj1HiZ94BVHP/OX9ia3NQaWjrFzXibI3CtM6Y5zxlPfEgKPQxvgXKVV9gzsT5EmBNr0ibpJDA9BMyYe97/v8ppdQzcXZLgjrdI5kIpKIse4rmb5sMwBz/W9eRtOE4z3oLLmUiU9yawCwFNqUw2edJSezAe/UyOpL9kEnNYOmBcFBDiVmNf9DWsgHF3YiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH+mhBULqq3lf2emwiZKKqke8LcI0qAFz3gg9Ys1dA4=;
 b=lZ7y0F4eg5ClkD8xF3WdkYFPk/cYufy13tjPQAlmdkutP7lUhfsv4JaAe5i3n9cZlM0joQLndSihpivXuQsyWoyG7QKwXw+g/74twilpBTpm5wvVL5OqJlYlZg/m4QH9n1F/z16KUsoE5GPInODiWDDcVcq00owr8anIhX69ultujxJ+h/1xCiDNKdY/uNnf8F9i8GnLpslHDuFIK3CyIE1ZycCAqztd7WuIA52BezDx8pVhA6CLr+p3xnvTBcJflh127OvhhlnxFcxsKwgk1gF331qsCjZQzMWeiPcKiDp8TZcNikn0Gz+1GVeO2goolU7dcZ7oecUvse1J12l66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH+mhBULqq3lf2emwiZKKqke8LcI0qAFz3gg9Ys1dA4=;
 b=ACHLtTJA+YSeb6d2NJnEgFbRH6rF6pr8Q//PmXZg3h+6f1TK/mYh0uv/fQYCC4e+ZErBoAH5y/ZDh7PvA613nV8KsetFpQvZWG8awEYRY8gtJz0P08njD0F8c7wWhpkANB9LDzxsqc3BfGWNcdgHgaRwtno6qcCszBLaXPNlHpejMJtXyIyhEweB23R7g2Vyrmb88psw7RZYVCJ1htvasqqpf9PVCl8e5Lnah8RVsKiPhP305852b9xdO0Br7JxR/OIgF+aIUwYuLMHSbcrqpDcrBM1+cjE734kz3wHO3+1NZWq/PEDYddZUm14nvTaebjQwl9b1V7vhC/V45vvawg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:31 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:14:58 +0800
Subject: [PATCH v3 06/12] imx: container: Add i.MX94 support to
 get_imageset_end()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-6-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 777ac715-3f82-47d7-8007-08ddfa47121b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnZUS0E0bjZFWUZEM2NvZkZ6MzExZzc5V0tqT1JIblo0ZWJNY1dDVWtmRTZi?=
 =?utf-8?B?aDBWR2tKU3hvOWd3L2xmb281SlM4czBOanNuT0pWRytMNytaNHhacEtwSTRJ?=
 =?utf-8?B?Q09EUXNFSFNZc0x2elEvNW96OG10TXZQL3NnQVhHVys1cFBmNWVLVk9FcGlj?=
 =?utf-8?B?TjYvS05ONC9hYVNLdTZ1SzRtRFBzV1VIS2NlNzErUDV4aEdWNjdsczY4aFpH?=
 =?utf-8?B?cVN0eFZmTnI4SmhHdG1XNDVOU0NrNnZadm00TndhT1NzdnkwR3M2Tk9xRmpp?=
 =?utf-8?B?dm1lQi9LNG1HTzhZdXlYNGRYUklMeFlDK1lpZFphZnJyRUpNNElkRXZzREtW?=
 =?utf-8?B?WllWK1RMVmdpVXplWTlJWUMwZng5YUJ6RVhJUzJpWWgzdkZEZnZGMjJPWUx1?=
 =?utf-8?B?ejFsQkVVRU5yNVJ4SDV2MmNHSTRpc1ZJQWE0NU5tc1RpL1lsWFFESmlrYzJK?=
 =?utf-8?B?Qm03anlQRGZTQWhIV1pCMXN4eS93Q3N5ZEZ0enNXRDJtc085bzFSZHZjZlpS?=
 =?utf-8?B?L05TU3BMUWtFTmxjYWpNZjc3UmFOYmxKZDNsQXlzdzg5OEJWNS95OTlTU2JM?=
 =?utf-8?B?SFozSkVtb3VRNXNGbHk3WW5wUmtlZ2l5dXU4aUZ1T0pjdTNPaldmTGRwbFB4?=
 =?utf-8?B?UHUwcFZUWTQwQUVnYzhXdWpQK1lOQ1owbHlUM05xbEg1cHFmRlVZMStDTmFV?=
 =?utf-8?B?ZnJGd0l2RTNxdFkvS282MmIwZUFJa2w5aGdxT0F5OG5VRisybHVKUmVnQUlr?=
 =?utf-8?B?Tml2YW9LUW9oTlpscyt2Y0tCd2VjYmtKOWFPMXVxY1hzdS9BQ1ZyUisvMDFh?=
 =?utf-8?B?VGVKR3p0V3FZT2dwL29JTHJCQ0hxNkhYMGlSWkpNQkp5MFVVUkFDcVpzT2xa?=
 =?utf-8?B?R1RYc1owZDkycWRxc0t6ODBwRzJnbFQ1Y2FhL29CdDc3Y25jNHdXVWZQc2tI?=
 =?utf-8?B?a3EyZnJ6Nm9MTzFuWUNQNFY0bS9KUDhmS2xQQVNjbXJra0dVR0FlRU8rYVJr?=
 =?utf-8?B?YitsOFE2RjFUd0dJaXNJeCtNTVZXSFpSVVJVdFp1eW9xUW01aUlmR3RGQUhn?=
 =?utf-8?B?eUFxa1FqYWlSUzBtckZuNENSQWtSeno2ODhZVlJXSURGVEtvc0dKYTYvWUh1?=
 =?utf-8?B?STZaSXU0dUhtZVFMc0NjQVNobk1uYUxrSEVrbW1jVWczUmtEd1hIQzZSK2FU?=
 =?utf-8?B?dTcrS2ZVLzhLaGI5RmVlVjNhcGh1RGVaM056UE1ZblRxV3Q3NEhZWGRJUTZX?=
 =?utf-8?B?SmJTUmhzTGN6Y2dPMFdmSFROTEZKbWtBVTR5TTlJWkFWbHAvVm5CU1habHZU?=
 =?utf-8?B?eDg0RStFU3BENG1VT0hyV3F3VUZZNWRIKy9pOGNHQU9rNU1Bc2FwaUsrL2hz?=
 =?utf-8?B?MU82WlRGUEZPczdQTXhJYlVrZkZSQzM1S2xkdlh4azJtb1VNcXV5blJvRlAy?=
 =?utf-8?B?dDJQRHd4SFRPWEd4MllDVGorSWVIRVdWOEF3R09LVUdLTWtDRkZVd0t2TE54?=
 =?utf-8?B?dnh0NllnSExaS3JXaHgzd0J2eTNCVW50YjFnb3VGQzVnM0d5S1VYeG03Nkd6?=
 =?utf-8?B?dXdhZ1g1SWVaT3VPVUxKS2F2WTdENG1IT0dXR3A5V0E5K3NaV0JsUzd0WlU5?=
 =?utf-8?B?TkZOQ0M0TGw2UURMbEl0UmN5ZFVQd0MzcVZlMTJ3NmZCS0lLYlVRMndmcTV4?=
 =?utf-8?B?eDRvMVhWUWVWVWtuZHJZR0NBWGFpMnh0K092U1RNSkVVdlRBb1FPOVhKZ0kx?=
 =?utf-8?B?VlVsSGdMWElCTE9zN2lmZDhDUHQ2THlFSGFPTlpXc2ZTS1BXaldqT3grNFM1?=
 =?utf-8?B?dGx3eUpQUXl6c3FVTVlJVVlTc0o4NFByd0MzWVNrTlVCN1poU25lYkNJamRv?=
 =?utf-8?B?TGt6bUNKYmUzditIcG8wYUJibkQ2RW9YT0VaU3NJQ0dha2d1SFhmdXVqRlBw?=
 =?utf-8?B?QXBqbU9EZ2MzdWtXa3gwOXc5YXhlQkNzMG1oY1grUkIrOFM1VExhMXNzNE1V?=
 =?utf-8?B?UzNWWVJKUElRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JKOVdsaG5ScWMzeTdwRURPZkhUSjdqOWR6Nk1PU1ZmckQwUzJsVGw0WGR0?=
 =?utf-8?B?RVJYVng3WTQxcVl6WkVyWFFocVJLTDIra3Jia0pmMFcrZUltT0N3dVlQS0lU?=
 =?utf-8?B?eWhaQTJnVXlHYjNsVXB5RGUzNEdqVzJ3Z1pCYkVkczRYa2I5RS9FOVZQaFhE?=
 =?utf-8?B?TXBHNS9BS0picGFpVFpqd05xalBMeGVhUzA0aEZaa01sbHFiWDRhVG9VdTAv?=
 =?utf-8?B?OHhjTUF2dFZPY2FRL3krRDAzNEsxaUduR05wRUlzdllSaTdSV3FieVlmc214?=
 =?utf-8?B?WmFTb0Q3ODMvN0dKR2o5ZTZxYnhVaGgzU1hYTjRkU1BQdlhxOWZ4ejZ1Y21u?=
 =?utf-8?B?RldCL1B6QUxTSzBpSTZpVmppUWl0QWZjSFBMYTdJNndmNDNiMnh5NEIwby9Z?=
 =?utf-8?B?N3d6ZDZLeVRCSnYrK2hZL1I2OFBuZ2U2czByOCtaRjRjUk9TLzR0NW1hT1Js?=
 =?utf-8?B?d3ltMlVrdTZnWTc4cnhEbVVHVytqYi80cTNWOUM1R0lwekYzNm8vUllTd0dH?=
 =?utf-8?B?N3FvMHdEc0NFbmk0TTVjS01oSDdCS2VLK01YM3RNdURXaktkK1VGY3Rwdm1Y?=
 =?utf-8?B?bTRydFJzbWJ3VEQ0Z3M2MEZtZmlvTUZnSmJNV0o4TXZKOWxhSHpyWVVnS0hK?=
 =?utf-8?B?MTdmSGlxMmcycCsrNVA1RWNTMzZuaXZSZ2p5TG94bG9IbCtXL3VMdVhMR21S?=
 =?utf-8?B?bVhLRFphNWJmSnpJaTU2UFkvUDVJeVpyQngxMU5WdlJ4VVkzckdXTURTaEdU?=
 =?utf-8?B?SnYvc2RPK1lQRGw5aUVoYkhzbmFPSnE0eVkycmhZMW0vQi83elRPUlZpd01n?=
 =?utf-8?B?NVdqS2o0MGJGdStaMGI5RUp4cXMyTEFFSHlUT2dZWjlNZHhZa1E2MGErOURP?=
 =?utf-8?B?NFg5R2N6TjlKbWtwSzhrQm5uRitxMHMzaVpyYjVLeXY2YytRZjg4UDZiaHZu?=
 =?utf-8?B?TU1sN0xWMXJIMDFDREhIUlhxSFROamRUSjJXOEUzc1o1UTVZT0JlY0NUa3FC?=
 =?utf-8?B?cSt2QmdSemtlWHozcFg0VnpkOUJLVnE5c2Rna0ZXaTNsMDNaUElGVEhFWE02?=
 =?utf-8?B?NHRhWkxORXIyVVl0allkcDlobElRS0hRMzFCRjUxOGE2S3YzTWhjdEJQSHc1?=
 =?utf-8?B?TTJyRFBoZTZzcmNrbUtLa2xFa1l1UUdyQ05md1pyMVNZUU1LcnR2K1A1RExN?=
 =?utf-8?B?bWh2TEZnVUpRRitsSnRoYTlqbWUvVWdVSkFsZ29Nb2tMV2tyVXJ1c0hJRld6?=
 =?utf-8?B?QmlGaEpYb0pUMkRvVGJBL2VZWC90NXpkSnRYT1drVGVWMzRzdDJMWkgyaUZv?=
 =?utf-8?B?cDJhMEdDWFF1ZzZlRXFLMXJxNmVtc0FRZlRwVTI0REE1YzNaSkxvb0F2YzBL?=
 =?utf-8?B?ZWk1Zjh1WkRXWVBqSXh4dFBLcGxWTWYyR1VrNUFSSWlCTk90YkY2aXE4Y3VV?=
 =?utf-8?B?Q2p4SFNsT0pzalBKaThsK3pIU2M3TDI3b0RDM0ZrWW9qUFFtVHhQUW9FVVdG?=
 =?utf-8?B?RjM0RUVXdS9UTUhIRUpVUi9VWjZCME5RYzVtUVFxbDF0b2hUbFNHT1RiOThP?=
 =?utf-8?B?Nk9KdDlnWFBWNEhJTTVldnNKQWQ5K3BiZUtpUDhqTnVFbk9ET0FENHl0RGcv?=
 =?utf-8?B?aTAzZ2g4cWtlY3VIVHNZQXZoTEJmZlNrMVlKaTBoZWJiWlZSeTBLejBGQzJC?=
 =?utf-8?B?dnRtbEFMMVlvN2ZScE5QUk03Z0Q1aTRleTh1ZThRWHZBNVlFTW0xRXZDS2JF?=
 =?utf-8?B?YXk4TUIzTmRrcVcwNlNsSUxFaUlhUE84bkwvVFF4UXl4emgrOCtNNEpwTzU3?=
 =?utf-8?B?anhhUSt4M3ZVRkJmUmpMa0UzdUVaTkhNTkh6MG1TS2ZLTzdMR3g0eStoUlh4?=
 =?utf-8?B?cGEvQTBycFQ5bU9tMS9YZFZrK3I4cTlsb1puTDNQOGV0V3NNVDVTdjhLQlBG?=
 =?utf-8?B?RTdWZkFiZndSVVhndmIwLzVHM0hxY3ZqZ3dPVHlHL3RqcU5wSDVLU0RxQy9a?=
 =?utf-8?B?MkFFN0YvR0k3TXYrdUIxZnFZcEZCRUVRdnFDTVBRWEhBQ2hFTmhtbUhqMXJn?=
 =?utf-8?B?NWxpNHVOWkdWU1dSSzNXTmpVR3BrL1BEVVg5V0VhK3ZjbG4vcDd2dkNJOUN2?=
 =?utf-8?Q?656mcDkH12MNQ7aMall0bQqet?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777ac715-3f82-47d7-8007-08ddfa47121b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:31.1462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJqR8fDOxFiUI4yqz5GMJ0dDIO2M53G82NJkdqnwHE6UZ3XLQjg8gKi3aMN4C64s/jcWdfBJfIhK71Z2t/s3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
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

Extend get_imageset_end() to handle i.MX94 family.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 3a9e6dcf225..78f2488cf6d 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -297,7 +297,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	if (is_imx95()) {
+	if (is_imx95() || is_imx94()) {
 		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 
 		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
@@ -321,7 +321,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
 	if (value_container[2] < 0) {
 		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
-		if (is_imx95())
+		if (is_imx95() || is_imx94())
 			return value_container[1] + offset[1]; /* return seco + v2x container total size */
 		else
 			return value_container[0] + offset[0]; /* return seco container total size */

-- 
2.43.0

