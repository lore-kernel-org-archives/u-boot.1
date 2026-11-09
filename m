Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894F6082BE4
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FGW0mEfX;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UVOEozgk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E86740660;
	Mon,  9 Nov 2026 09:31:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WbPy6xPVvkV6; Mon,  9 Nov 2026 09:31:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61911405B6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794216699;
	b=i/7XZjyNIe+nHoSpVQ3D639hYcGNh4tfjo8bbfJnQNpmWYv10lcfgjRBxGtaKl7oPkH7
	 DddI/QwRoaa2nux4EqIu4v+2Pwzo65ONg2cUijjiS7IBTqWVAOTJ+57fnfgamaxYsfv3P
	 4JstvwpXAtqTCzV0HT7OOO83Yey0qcsYG4oQ6uHy+JB+/JkkB7UFmjXr65ohS3v/GVzgz
	 kT0wLc/6vMFBhnf091RoZLdnZ1WsOD2OMVRIbq4KRLXb6N7KKZO646VanTgowjRiJrzRy
	 K6dQzw+/mzRC9TIz5t/tOUmryspiuKX6ARs/eJaNBP8o6AJKVgVp9OXeSC105O6mGvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JxrBu7oEJU23biwpTLShUF3uqg5XmxosYAAViQCWuZA=;
	b=l22DhNSLLpTSvk+n7OJh4snHLNFae0fdZzScPb3BCIS6l8PObqfua3fmJ0xwUqKuPxm2
	 av2e13M3erkMhRjEw9Y3PAzEeMAT033tkQvqesAHQyv9kpIy2xWOCs3MXlrDTq9K+WfNl
	 fvzv1e/x//ZAGnLfTbvnf6M6Uw9rA/WFYOqQozEj7jrzZi3bm2zu/+9lLc92brabUNz3h
	 fRl2hbn+4GhxujYTJNo7nGU8VirwawD9cEnLNbRHv9JD84j4BcSvsQpk32CcNc1nyHZAC
	 OTN/ooHlwq4CRWo6GgJkKNPVz/EAK4I+CjPbE/kQsOSXsYSms5lqfWTYKfyIDRRM0jQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794216699;
	bh=JxrBu7oEJU23biwpTLShUF3uqg5XmxosYAAViQCWuZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGW0mEfXO/dg1fwDPPrwINSCajVBDXdedQQXNxhWK/K5Q6DpfihWlK7MvagHBy/xl
	 QB3gW2MiKDMn8e+ua6vOhHus5gv3f1YsVTeh+1sq7LvHGEu/WX1n7dyiFLlBhJjo+o
	 LEx1bTUKfuac7V5ZjsCX5v3QV4DD+UPgQquHnMg6mySnhdVPJCFwC1th55xpvUuPvt
	 x/PMRWiq+mgGupO8JVtxLY2fuFXAsGDULRXC2fw9oqa5ApmVwttY+XBpRYV3xQzMP9
	 lslGyXbzCuKgURRgnLvz7mps+o81i/9t9Sl+pkd3cp6nHADpjDkd5x/zkqBkZBS2ZS
	 hQZK/kmOQPVdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61911405B6;
	Mon,  9 Nov 2026 09:31:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 431829D1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2941E80E33
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L3i1PMIrT9ez for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 09:31:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECAD780A89
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UVOEozgk
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECAD780A89
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxrBu7oEJU23biwpTLShUF3uqg5XmxosYAAViQCWuZA=;
 b=UVOEozgkb33TfkdIZ6HwYK4d17AgWO+3XRkeSUbLHgBJnbewpB8sIAm+btZ2SzPxZRRjzkvqmF0VNjI9OXg168wk/GLZjw+KFDTDUcADJeI7x450+APiI1b7IKOSrgKiPO8RkGO4TxmGGmq7EHSgNN/1Lw8GNccCfbIbMm5A9AbagZDUvQhbSzt+1Lp7W+ekuLLVaxkKnVxPyGVIzgMVm+b6XJF1VZnkJLVCVfT6f2Hi7XyCDJ/bwLGUlioTxSoQvKcxX2nWryIKdju96yR0elTDxJhpZKsU4xVPBe0sYQpKJ0JGmVX2K0qtmzNpRRGUT984vU8Si+VjhV2Mk7CHSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8072.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:31:28 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:31:28 +0000
Date: Mon, 9 Nov 2026 17:27:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.u-boot-project.org, jerome.forissier@arm.com,
 sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 ye.li@nxp.com, peng.fan@nxp.com, trini@konsulko.com
Subject: Re: [PATCH] net: fec_mxc: fix double free of shared MDIO bus
Message-ID: <avGSHtr95FZ11U1E@nxa18884-linux-1.ap.freescale.net>
References: <54G.ZqHm.6kfJQ4BsLim.1gwlr2@seznam.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54G.ZqHm.6kfJQ4BsLim.1gwlr2@seznam.cz>
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ada712-6917-49ec-37dd-08df3e443b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|19092799006|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: arYpOMB3wJnNWtmZi1qjgCe2F9xOkgg+3oEIK8N0gmLPopHKPMcFEJrU+aKuq9ZDQHObtZEa4CtC/gF0dI89o40I6rwCLdtjD3JzimW8kBMsC/5Te5WujkAx30I20zF1nd+HWEK4w44W9bd+RkghBWzTJaag7xHgarNHhbdkn7/IOyluaYdRHPAKmPtFEaIT55rv+VnI2xK3L/odC3LwMZ2FGHUSYezDfWwaGKMwnEA1PhXdt2tdKuCwSmNuSGYiHGfI/A1XvpwKROh2wkaoG2Wa+U3speSOcDEIdwgWwLpklhfnAHkfKryEGtPFztiBwqz0hxin5fnKhcNC0stG4Abjpco2N4e+szEhYo0RHFPWi8ScfGuOHPvfVo/+SjsWrBvO2AwQqSgA7Mo6WPoz8OUiXr7edqov8nxnjh6s9sRlZG1obxYZLSS0X0rbLlgwjCqeCZLD988rR/3JTlNM6jJZBG8W8CwD34tv3ocmNEOzbZxMCzoHTh2vfbluc2Uuv6A0a5Tb0Dz/mTjB+LybXt80TYPsfiZBiotHAuu+K+wGVMgxrq4+5JWcxtEhWP87B4+kwNGvG4hzZ/ISqLd75qH+Bh7kbfwt24oPqyR940vceJVMt2LKp7yoFZ9gsy2cmiXhnJcBVYHABYHUKc6KkRWCqyQYi9UIBGeEyBf3NtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NAKcGzk0FYtIlHoB/pHj/Qb/B66qcCHUN40EGM/w0rVir+9k+/CLlfUUXti?=
 =?us-ascii?Q?PQiEu+gXra2sO2+tGNv12UqaTjKmdu+Nhg1va/BNouIGuIm/fUGO2Sx+37e4?=
 =?us-ascii?Q?yQYD6PgMGCYRdszm0L8OOLG25W35D+UCrFQl5bzEHwLSnzJ+dePMXwR96g/P?=
 =?us-ascii?Q?a08TgY56pkUnDBPNeFwEYXoNlJV2JL4qvsAgWlXKF+FTxeWgPknJ+eDtrpRQ?=
 =?us-ascii?Q?BMZAP1Sx1C8rV3EWe3q+2nQmlUnUoLx+tnoIE4BB2f+SneS7FozZxQ7mY6sP?=
 =?us-ascii?Q?qpkDWhP2VAsHhADd5Xbd9El4vBDiJ+wP+g/gpzJ29w+hZPYSC+hbhYbAZIRP?=
 =?us-ascii?Q?0/rYmAA512Jy8Cl5m7ugh/1toB0vxNLx0Q4BfamoA3MhnQ55+rehEYc8K2Fv?=
 =?us-ascii?Q?v61bGa2ls51AEuzGUQXjqn1m/TFubNmw6w6A/XDEPp00FRCbglgAsnEFbuDZ?=
 =?us-ascii?Q?9RVWp1W3KjIeAyccAn8Bx5sm7Mvwi0YBkOBxccML/bpoRiZLI7JSnIz1rLGX?=
 =?us-ascii?Q?7NGXYErXyMdI4kZpwvJAPcR960HDH/4kFwy3BiQ63+4B4vlyKXP+nmx+aWpC?=
 =?us-ascii?Q?gWU6CDFsAGQRnT5GUHTjz19+ly5VVOiIRyzm4zzO4yQYL29LFXUlExkmAulD?=
 =?us-ascii?Q?7wBV0Yhc3VlvCD/MARypOuoh8pqnI+m1szU9UU4nLEHYgSgNisbZhNUshs3+?=
 =?us-ascii?Q?TVg12O3ayvnxKVmF6QWy+OVgHGadMO2SCXKRd9HQ7JWFvfvKlllRgwGb6Hlj?=
 =?us-ascii?Q?5jhKksE3s+vmzSB1Zq+Spnrtg8MCgBTefYnsoukufrFMZAX2yHV8Lx8FzwAE?=
 =?us-ascii?Q?vkZrWfoMkgt6hjSXyVQxLAZu2MA0aqqfY3AB5cK3byOoEThVcKVgpbgMDzC6?=
 =?us-ascii?Q?JXzmR9e6fCGnshKCGCkBQfisd4XruqyNauVQifI5bOW/1DFTUl0k1n1zy95f?=
 =?us-ascii?Q?ThE6TUnGubWKCSv9OWr4FAsfmHDP99QpImlKX+PzJ6aU5+898zgYSOZADbTg?=
 =?us-ascii?Q?RhBjr63SFvrneHyvFY4Jua5B6gqiAmIgsNLTnxF1oRQ81QzDe5M3pb4HM6+l?=
 =?us-ascii?Q?cV8F4WojDAkTn7p2v35jxU6C0jJMeZ2zRdDxwDxpgfk8yu9rkV2c8xIaUjiu?=
 =?us-ascii?Q?7L4OcKT2X/H9Kp9ySUMjnbqrzDB24odaSdAuSx11wvpsaqNUmDSnv2t0Wlnl?=
 =?us-ascii?Q?EqLrr5YmWTCDa0SDOz4lu5uXU10lU3FEkIxWXxBqEIofTwLHdbzC+jPRhR65?=
 =?us-ascii?Q?UVItpV5IrEWGhmp1Z5OX9cQCHduq9KlgGpn2cPYe+JUi+558gX027SxmuTY8?=
 =?us-ascii?Q?kjy1fLv4LRpQD9SlHaFmSYVMkBFtfaYRNgTMmt+Z6mbVdUario2WZiLbUBuR?=
 =?us-ascii?Q?1MkWUhsE/2hVS+ljhqWlQ3X63Q2pEIeS1CeS4viUEF01ES4cXacqsvOWrPLa?=
 =?us-ascii?Q?26G2XlNmiBcYzqmCbwW0xhpUtWAVhn1+N9egNXDIz89PQpCA2UjEHwjmDiuB?=
 =?us-ascii?Q?qo4eWW2x4EUl91jUX0BLI4taEt0kXB0gldDZlWfUMR6nMdeG1Nsdnwvm03yv?=
 =?us-ascii?Q?dA8QAtkIDk4Rkr5Wokdwnzxk8y4WG0MbqD1QgvAxuMcCQQokKNw7zIlJKokC?=
 =?us-ascii?Q?K/bRMCH3UV8P22XWxPgUORnlerqaoieHbKfe7pR/BuCOAQinRDjSXYRD0gPW?=
 =?us-ascii?Q?bcSow+pVHXVy5KclYYBxVcu8b/TuFZq7Z6soxYpRgcFnhJ3wKUclcJkoy/Qg?=
 =?us-ascii?Q?+mzfR31r48GOvIszpLWYVE8OfMbendjv7O/opV/KY2I0jD7inpMp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ada712-6917-49ec-37dd-08df3e443b4f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:31:28.5564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSflY8eP5uaOyak2IQsrs4VOKurP3agO5JXV1gONqqf4UDLsN5TXxMPV4k4fun+5UtJRchynGugWwhBRIaptm9V1+vlSdidxdkUpAwSBIOPADyWPBAyevJaq5IkqD9On
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8072
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 10:39:14AM +0100, Tomas Paukrt wrote:

>When two FEC instances share one MDIO bus without DM_MDIO, the bus
>is allocated by the instance which owns the MDIO pins and the other
>instance gets it from the eth-phy uclass. However, both instances
>unregister and free the bus in fecmxc_remove(), which results in
>a double free when all devices are removed before booting the OS.

Hi Tomas,

Could you explain a bit more about non-DM_MDIO being used here?
I think DM MDIO should be adopted for a new board enablement.

Thanks
Peng

>
>Fix it by remembering whether the instance allocated the bus itself
>and free the bus only in that case.
>
>Fixes: 6a895d039ba7 ("net: Update eQos driver and FEC driver to use eth phy interfaces")
>Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
>---
> drivers/net/fec_mxc.c | 9 +++++++--
> drivers/net/fec_mxc.h | 1 +
> 2 files changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
>index 3d32bad0831..fdd304b67de 100644
>--- a/drivers/net/fec_mxc.c
>+++ b/drivers/net/fec_mxc.c
>@@ -1430,6 +1430,9 @@ static int fecmxc_probe(struct udevice *dev)
> 	if (ret)
> 		goto err_phy;
> 
>+	/* only the instance which allocated a shared bus may free it */
>+	priv->bus_owner = !dm_mii_bus;
>+
> 	return 0;
> 
> err_phy:
>@@ -1455,8 +1458,10 @@ static int fecmxc_remove(struct udevice *dev)
> 		device_unbind(priv->mdio_bus);
> 	}
> #else
>-	mdio_unregister(priv->bus);
>-	mdio_free(priv->bus);
>+	if (priv->bus_owner) {
>+		mdio_unregister(priv->bus);
>+		mdio_free(priv->bus);
>+	}
> #endif
> 
> #ifdef CONFIG_DM_REGULATOR
>diff --git a/drivers/net/fec_mxc.h b/drivers/net/fec_mxc.h
>index 8e95b539cd6..c4f63418f71 100644
>--- a/drivers/net/fec_mxc.h
>+++ b/drivers/net/fec_mxc.h
>@@ -248,6 +248,7 @@ struct fec_priv {
> 	uint8_t *tdb_ptr;
> 	int dev_id;
> 	struct mii_dev *bus;
>+	bool bus_owner;
> #ifdef CONFIG_PHYLIB
> 	struct phy_device *phydev;
> 	ofnode phy_of_node;
>-- 
>2.43.0
>

