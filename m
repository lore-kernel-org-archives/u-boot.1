Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB3CD3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 10:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB6B83106;
	Wed, 10 Dec 2025 11:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="gL4ehHry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FFB8367F; Wed, 10 Dec 2025 11:19:26 +0100 (CET)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD452830E4
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 11:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vyn7yZjoiqdKf+SLByxMOAYi3OCOJ6w+6XFxH8T9NrD24nBPoBs/E+BEa0oVk8whcfqzk4ZYNk1UBFw1ewVF94jJH9XQfpzLerqrCYc1IJzOMQ2Juf8cHoIwMk1lXXIV/AG8KIeHHMHJl0QKg2DNOYIiEcpNSv1ADoTd5jqtEsC7+3Obvo7US758vw9xrKy+b7i38X79KDl3ttQmQLN+N4CezkNJr3nslrqhyxKXJPVIxjUIy23BlutFASX+zuJpW770G6d+rWDfeJpMk8VtK8JlNfYvq1a8W9/Jtx6srsXKbAGry21dNWirbzPj0VjUYuvov+BUefBX6FTlTyxpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuAZcpJvBfCxLhQRXNKjR7y0/XZxE/8KH2p/ZU6Ryv4=;
 b=ILZCzJbe5axNYtejXPbFss5vE8liWGDj818LKJY7NIUtWIrjEjW5JlvNmF0pB2JJRdbLE8/kZJdGGJ3WXN5SdTAekxwwfagT7m3wTwiW1mT02sct96aM5mIFeIj09XIgEWUFvP6eBj0kzG8poa0hflxcXzFpQwVwUazM7cZTPWkF4tjmqGVwQ/Udu474rH1xKrzZIP4/EzQcF41iiIxAeELW7RTs+zsQ5plWBV4S0D0dxus6tEL9sgvfS6hp6wECOrkX6KbIIYkhv8QSHfjmAKpUvjyr2Q/2/CwVy+4+aPkrtCwrgJimK84iI6aP53O/dIQz70zsuynt/PTw5hi1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuAZcpJvBfCxLhQRXNKjR7y0/XZxE/8KH2p/ZU6Ryv4=;
 b=gL4ehHry21V+SmTuD9tOgp+WbTaRCT6EZ7GoHLGDUQxbPPlJoN8bqGySM5crudSh9sgEwRrE1ySa62ZDhD2ZQ4br2a5Qqp5rbN3Rr5xxITYn1WDkw/JRA2ahwbimR6w9iwEQt1b5NakjDoBTzd9m2qf1Ss+pNYROnlUI+dxRUU6clm6tCVPUwsFpXQdiFHpyD6lLhVSeg9wk4lJ84WfqJIweXc1py07HlsfvCrCWJWOgj0j+OONz6uuO0WcojGI3thW0WACWtzdFckHEA928cxM/3ApjKE8RYSwZ9xFXhVL6Ez4K3Ioc/ehpErKPkGBoD6TItinhPiPyh8S3KF5DEw==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by OSCPR01MB15682.jpnprd01.prod.outlook.com
 (2603:1096:604:3c7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 10:19:19 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 10:19:19 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [BUG] [v2026.01-rc4] hush: while/until loop unexpectedly skipped
Date: Wed, 10 Dec 2025 18:18:23 +0800
Message-ID: <OS7PR01MB138341D2719717E66B069F33FBCA0A@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20251210101824.22786-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|OSCPR01MB15682:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4192da-4318-401c-1512-08de37d59446
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|19110799012|41001999006|461199028|8060799015|23021999003|5072599009|52005399003|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1sx9W2CsBxdi6XbgtgusSEl4vBjrFt1TdoKj6dB+5MWs+3nh9+3o7S9e4kOJ?=
 =?us-ascii?Q?Oo2LLJK9RxWoewnD/29tA0GbInJTMTSxVryxyVDSTgfld6HYM5xeuBGhJe3j?=
 =?us-ascii?Q?qWuU6WBtAV9poRPIU1RVqs1XfJiGRFxIQMrh22kbI6bwt+9skt+Oo0rlmXzh?=
 =?us-ascii?Q?qSSwfK42ub7dhaR/UfiNRpbwgWG0eFEaDFlStWHn8YU/iSvJPq+bjb8k1Shj?=
 =?us-ascii?Q?0y/V4Nh4S0xFxfLwxV8HJlsF07aA4ay/wyr56odj8ZowKTGwaGr2SAwYV7hs?=
 =?us-ascii?Q?bD1xhPj32bSRAaXWwL8Y3tDElEfdr+0c3TdmwJNUJ5piKJc0AOOegr8cZrjw?=
 =?us-ascii?Q?J11LOG3U6C68HZRDLVGl+lDE4dB+Gc3HW354zyXJZEVh47htElYa9uoseqT2?=
 =?us-ascii?Q?4qEf7xKsItc7vpbBM0nARiK6W/RM2522Tid3wx3Q+/Idm+AUVYpiEcs4Vx3Q?=
 =?us-ascii?Q?I8HG7j0ZSq5nhiJDOAOapEwcEpUIrRcxYuaaWERJWzfvsjBnfVvdRUCBHxO2?=
 =?us-ascii?Q?Go6kGnH5cuBXjASJLWI0uNwGV9qcOMwLCoeQXLkQWE4GOslF0do2vU2hJyZD?=
 =?us-ascii?Q?gYHlgi8ryfmVtLKfKJTSFUtGDtbtxSEDd3h0zG4svg8JiY7t8ViTn4yasK+f?=
 =?us-ascii?Q?EG7/W+9be2xWZoKmJqROV5e+bZMj8iJYYmPojEIlH8P/ZEjN4gakhBNXbsR8?=
 =?us-ascii?Q?s0zVv7iRjP0Q1ovxEjRhL7kjaHQgS5ut5Es+rPC5yf4FA9gF2fz5S6YGIrfM?=
 =?us-ascii?Q?D82vqu7K+T/369MRdb5xozu3zv2+TD7wrt/ifkoyKaKPphp0EK+CZe/Kt0Wd?=
 =?us-ascii?Q?uX8QyzA74eMVFxKXBfnJs/OH65oGLC9u00tYKEbP5DRgczPFMBaQICsTiBjq?=
 =?us-ascii?Q?kDGk6YIAlfK5zmZpcI0dGZwAfANG1wv9ZNUE5KWG4Kcv5Q7ZPBCQZoIhe54/?=
 =?us-ascii?Q?qoMDGyBuvNx+fW273jDiDBul55KPhEq6Rxz7aO4AyAWDXTM6hr2MG/sgDzPE?=
 =?us-ascii?Q?axpGx/ArnzToRX5covBtP+82hYKgzc1SHdRbBrL4rQKceuR3PX9T6B4z2zCq?=
 =?us-ascii?Q?UNpdzYeeUEuWN4wjShV6tiWDXpMysbFglEeYQtInEgKPdEckUYAbAN5+3OxB?=
 =?us-ascii?Q?I+IFiNiKSWbIbmjKDYVXwx5CN+WlX3ahRma8D0KSFG8A0roRXgfZ5XuVtJG5?=
 =?us-ascii?Q?sGYennaU490WwPbKOxuOmnHG8U30KZkuc8oHVitxrL2GLuFCI8FF6o8134I?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aqq9yvJfyO9yzeVRc7QTThExarcGT+5v9hhKSkw5zLqh7DVX1sClZZLFG7zA?=
 =?us-ascii?Q?/bR05IZppNtI/QD1KOSs+Wj3ONQ+mvR9/7bc0zCqr09mSpozDuxCI8uD0rHi?=
 =?us-ascii?Q?UQh4DSzSFvy3nZJ/dcDnfB9nv+jEOIYP/hay3ZI5LbyEmuTVuqTGFG/uMkTv?=
 =?us-ascii?Q?xFgRwgFS/zX53zOK+UsrsTIneHKPyfY4mCFop1LHhgBBOpyDmzUGfAtaD384?=
 =?us-ascii?Q?AON9GWqFF+92QSsvEAxgRtcOixCva5ZViBbb+crNhsjLKHBklotQzolJ8Bw0?=
 =?us-ascii?Q?2qnelP3v97H/5HIDQvQzzhADGJTRo/2R+hOVs8QR9B0YLF5KQCBfw6HuUEnr?=
 =?us-ascii?Q?wonNuvvYncagzXFh1Q0ab7Xnf94CwA9L8XAP2eVaDPDp69EmSpFcLwNRmWOx?=
 =?us-ascii?Q?vIpwMNzGPNLZej6eNcPV1bI9VR0nP6b0jQbuos88Or8qM9LZYGCArh7M56sH?=
 =?us-ascii?Q?ZsvMPhZVZA9SvTYdBLpmCC6oNvl86wX4pGLr9xQsSZunMup0yv013fzwOOO4?=
 =?us-ascii?Q?HeiyOVkvgzhFUzPUDmYDXRasKEYZzOZUovTUq1TzBgaVLFhN46hLLF91Rihl?=
 =?us-ascii?Q?3YhCSl91cJ9Of5F6Ihth7MUPAVp4FI29y8lEJ1Bfh3qMA0lgmc/HA+zZ1Xw+?=
 =?us-ascii?Q?SrP4juTrXXMDUmcEcU6pG5hvKQ27XvnZpOw5MqOqJzPa2G04/+9fszy+f6AP?=
 =?us-ascii?Q?mjjSwBHv+56jOdYLOVDRv+qy9haXFBVy/GIaF9qvoyncnSu0mD/J19nALl87?=
 =?us-ascii?Q?C3rLt4hWDSm4HNufK57vGqsdcHlIKSfGssfEWqkotX8gFgGUzOiiCupgfcHY?=
 =?us-ascii?Q?RdjZSitNWZAuE23+IXy4OAoUb3KjwGhYJp9JokVFfwFDyTPB+Riz+a8TBVJr?=
 =?us-ascii?Q?cCIlKL0eyialSNXSEM5iw0Fz1Mf0E6Wwvdf53fIK1D0IEY/DXagpg0f3LAK9?=
 =?us-ascii?Q?w1W2xC53RnjOEO+6uprB3W3X0e6bTaoKQgQKLtdGSAyyVrJc89QXBr91q1/s?=
 =?us-ascii?Q?tqDb1ylOLHibU4pKS1ok74XSZy2S4TngH62jwgSKovqQ8oThslpR/uUPMDQx?=
 =?us-ascii?Q?KfqvTbOiqg1z9br7tHIZlExIJ0jBSVE6n/jzrpv6R/jsueBVtcNawn9YGhdd?=
 =?us-ascii?Q?olYdgmAtatMJDkLwy4fZ2FNvRuRGTS9UvJJwot4/j5DOyHhSVXfqUwc3+Ujn?=
 =?us-ascii?Q?NWeZkFLs4ENsqpTJZ+Eb3mvYBIQ0XmFN2zCPMG1Q6U7DQY5fhaxg9mSq5smy?=
 =?us-ascii?Q?IJDlpiu1zniIYLSmTiyK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4192da-4318-401c-1512-08de37d59446
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 10:19:19.5112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15682
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

When the command before the while/until loop is interrupted by
Ctrl-C, the loop will be skipped. See examples below:

=> echo start ; tftpboot test.bin ; echo interrupt ; while true ; do echo 1oop ; sleep 1 ; done ; echo end
start
Using eth@10100000 device
TFTP from server 192.168.1.254; our IP address is 192.168.1.1
Filename 'test.bin'.
Load address: 0x81800000
Loading: *
Abort		<-- Press Ctrl-C to exit here
interrupt
end

=> echo start ; until false ; do echo 1oop1 ; sleep 1 ; done ; echo interrupt ; until false ; do echo loop2 ; sleep 1 ; done ; echo end
start
1oop1
1oop1
1oop1		<-- Press Ctrl-C to exit here
interrupt
end

I guess we need to clear some flags after pressing Ctrl-C.

Regards,
Shiji Yang
