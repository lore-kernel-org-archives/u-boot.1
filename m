Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD90AC61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 06:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F416F60724;
	Wed, 26 Aug 2026 06:38:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gDA7LzFM4YXm; Wed, 26 Aug 2026 06:38:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787726296;
	bh=Ri/vieHHbUr8UWYpon3GXarqBar6Gbu3XFNLp+axIQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xdfCXdInJMUPVeWT14QZ8tgNpM15ADZ0i/5ihoWdI0wiDtjjtYQb0Ak4JB2mE+Ak/
	 FqayG8BBfZF2kziYK+/8rwOoGNs00vyVJKWv853PpXJ5xTGf5YpJuCQwMgR3TV0E7E
	 5++XkkMgTZ6Ff1x9rwNy1XeJT2HZCu+uXxVU5Iz+Nce5MUIkDcnR/N9VdWjgdbN80X
	 46OO4+UiGLVsvBwDQGZwW2Ilg9vM3DDh5zn+VEV76rSLlHr2hmql7L7Vegk3TMpKLL
	 jej0rnDHxHF7m1Dyqie2tE7QEKHuJPuCwKzudv+iWjRxvM98Qx8VfYZelgOE5I3QzJ
	 2lielAI1LPSaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BD2660604;
	Wed, 26 Aug 2026 06:38:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 876CB23E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73E1C80B99
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZfktYxaFVQ5Y for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 06:38:15 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=LpScfROU
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E187980B8C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWxy6sF3GZMcKP/tj+P11TAj1zTX1JBwiDjiTVpNlhQM3daJuCcgDYfnwXFVn7k/6act64Brvoxz+L1GjNB6T/WLKVWrHcpVqxXcqwGGTSLMlme3blbpJi/6GwJi+CceJ7id+Fx8701046aNDlTJsBCbwzQciVefNSX99U/sfubYCebNr1ew5O5kHDBG8Uc/0Mu0DPAuRRnFEcmeggZwo6a2yBmYzzjaygmuTUUfbgDFfgd+EiJbhJiVFbp7G5Kye0flfmI9zpaNDCYZE8wfgUoUrtWkUmzF2mP7c6BDBfRXtDOuuiCdZjN31kIkd8BRMnrJBjB2B6IaCnfOXJSfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri/vieHHbUr8UWYpon3GXarqBar6Gbu3XFNLp+axIQo=;
 b=utmxCtI9td+AjikPVOJmnA8is81/0bomZwZi5MbJIh6T0C+kheJjzuNOgMhNi7J9qbnGX+3o5R7dlTMlOeEBKk1HOuq0Oarm3s7dcun4tJUh2ZIB7x13HwlGSEgZ+SRNwpW+g7ySYbvn8btx/kVFn/WpkcxwXpA+dnvd+0u4NZZszy0M4V+Ki0bcsjLmr6ffqmFWV3PXsvUKm/H2TeGB6ogWVfIepELLRv0cP7JyxcRLik1CxemhEDzw/DNC2YEZwfSVWap3PqjfgpGiKq1i328vbqKtgciBGOdwbeodTR2r5wYabibhLa7IvG0o3msxUlgxra16cOUi73oShQFO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri/vieHHbUr8UWYpon3GXarqBar6Gbu3XFNLp+axIQo=;
 b=LpScfROUxlgkIACDVyg9+L2NFpDNOO08K2KamVD5erWNxgW2qvtMTkvI723FNxv9HJz1ZizXhWdncU6197H2+wc/71o3wV42vpEHD213TqM1vys7R7H1z8S6uYpOkzRK9eOJ4wHU8olSxtqQMMpz2VimVtYBZLC0mkLsGOU4HIj5K/3EeSknxVoWxLTChTfFTQi9atQqcr6Cwfg3IGqLdnNjNjCoth90kHyPbCI8EirkzzvemsqXDBF8HaBqsgjhUP/MpOd757nDYxMlXP6yEQpvfpiqu8RfegMYu155k1raAhG6Ppm8A9KtX01WB5nVpGYDMIizfEfzbJlyXVU0zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBAPR04MB7256.eurprd04.prod.outlook.com (2603:10a6:10:1a3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Wed, 26 Aug
 2026 06:38:08 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:38:08 +0000
Date: Wed, 26 Aug 2026 14:35:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v6 06/13] mmc: arm_pl180: Power down card supplies at OS
 handoff
Message-ID: <ao6JQHsJeDohNvcu@nxa18884-linux-1.ap.freescale.net>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-6-61446b6c289e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-ux500-external-sdcard-v6-6-61446b6c289e@kernel.org>
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBAPR04MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 5069253f-4c5b-40fb-b2a2-08df033c9743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|1800799024|23010399003|4143699003|56012099006|18002099003|11063799006|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: Vnstc4LE1lzEgqBg6P5gYW1XGgPvq9aKo3bZZBYCA8usdCTT/p0K3Km/XWS+y4I01JlwdGG9FiSabvmiqydAEDc6fBCsYsU/YuZh8fQt2l+UZ0V4VdN8E1z8l1/vHIFaDA/8EZ6m22VYLLIaZJTwb9ENN4BWlKZ4GxEp5Y5LzBvlBaUgaxjffXeGB/zMjL7nfg1kbhCkanJB0fwpZwlmn+bPeOdJ+1acY/GA3Cha3qeZeT5nH5qzrSrfyMtfapTk7aOXT2sFPVmzHgRpRsD8MyXDnlES82EVD1Q0XwCiafkaJ8uy793lAZ/pVqW/Va5z45nODEkl0/dQHgNbrrDWAZjnOFBmH/s94kHdmJ7dWGlnoNMUbb8AG/vQdWu4hVUnVYODBJnBbvf8/ffPqWX3qdaBoahmGXSvR2RHL1vFEW6wIgnAXdmRDmvzcxY3An7y4m3bQDFha6fHRIAQaKvMTwmTk2DdkAkRPfCkPM5jA4RbxFEdjeg65sDVjX871GPz7El5kJSyX5YaAaxs65W2HTjy3mC6SC52/tcbzEx91TTSz3W72SEnBb1kXJ1d7m1m42IVsu3kiLavdtSXqMx7h3UWbDLA8vrzUpeOCJ1ElKgyGsQMHabGFjTT1InwVF/C/zHU3Rs/9c6HWlDz4pni136o82OdDlWqaUbjVTA6YIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mylpLDEUNoS3/s5kN/jvosedoVC5MZfEDdymriltLkcDWNMd+BvLRu5KJU3O?=
 =?us-ascii?Q?5O32Dyefv2BFZGX6OGSnnTm/60MetU7I3zJ2cfCsi02/li/zKEIss0fimm03?=
 =?us-ascii?Q?mBzaz2GIWEBprXwHNkUl4DIieGgMumE0AQjVTztdycRNRCEhbr9wYYHxppbH?=
 =?us-ascii?Q?NZobN2D0q65o4qy6Hez8jSAc4e7t2iIUehPfUXCyeYY2EIKpmtVk0KDatpJU?=
 =?us-ascii?Q?eF+L6u0zbcuDSxbngP4Q9t6H+JCEUZ/73IC0T+oRvhUQ882i4ENOXZm+B4Vo?=
 =?us-ascii?Q?ArSUY3BJcasiXxo2jokygSPvkIS4gF7Ri+C39IYjQNn9a4qPlFsjwyOPeWwx?=
 =?us-ascii?Q?nLjt7ZF/i9sHWFDkfrKSvs85wyI5HGGg885EwVQNCOpcdrwfUey/jStLMI/n?=
 =?us-ascii?Q?VlafBbVw2MdYo4i2Uw6Hc18HFnlGI02Lylhz7dug+YZQTFK59Id1/bH5Eaco?=
 =?us-ascii?Q?F1JsZm2pYh7HoHkJVWy5+y3veIu1th5YlWu3zT8VSopfZX2SQ4nSOCkE6j16?=
 =?us-ascii?Q?mtcLGKn+pq5P9fT2S1Jc/XCtBLN7AX/cmorO2ZFTIv5uHCRfmZQys1kLIquy?=
 =?us-ascii?Q?fJoLNA6g7w8THZjbigIDpnYAikN34EsttOJr3FGbXQCeNk4GdqJnH06hsUwi?=
 =?us-ascii?Q?FzjBNKNINR1LQ5J3Apac/3bU0c+fMhgIrGXFYzlQc+nBt6SNRaSPAfRp7MVM?=
 =?us-ascii?Q?zZkwTXNEeKXxHqA07T50Qj97ASk8xNRm9idE38ZJNuhf+W78/HLpHjJxXQR+?=
 =?us-ascii?Q?GsSkQ0BRm6XTu9LZNs3MM8LMAJGZLBHYSvAwdgKaWmbk2a/4cJ9ua6voiHEC?=
 =?us-ascii?Q?aYR0BfAw0a1N3Nq8T7fSGkb6IwXlCq9giF7Km1OkPRFDlerKVuK75pPGIxSN?=
 =?us-ascii?Q?BJ3DRFVj4DnRs59KgfRBSi4Fk+cHedVam6DZ9ve4cRIQ8q9uAkSzUVXpAxuc?=
 =?us-ascii?Q?VzTS6tbUXSkqkqTamWfTuuj3SqLE7rL/hbYfKqApwtYVEjUYRG4PgIDv9qLg?=
 =?us-ascii?Q?3HXMM5LjQx2JXoUKtG5sE5DDpMTyQb6HR3VzVJJuobmaJtO9MgusOQaeCo4i?=
 =?us-ascii?Q?3y39N+gLghgYU6LwWak0/FJeQPbFwSyMlNL0pZre1GQGjWg0fWHCnJZbgjrs?=
 =?us-ascii?Q?o8GU4EXsMCMva9jwq+n/eSnGVrUhR4rVpBWiWP7j1pjIqD/iHWGE3D/bap8b?=
 =?us-ascii?Q?5BngBKuNeQSpUUCGdolSlPkDDimwLzc0TXi2kwXFcq9/6splu55wczcs8UAy?=
 =?us-ascii?Q?MtQp0sk87VGmnaT2NBLR5T70o5UvLTpHVXcfY2Vh9ua2TmXPZEDBBTDMCo0a?=
 =?us-ascii?Q?LsWnFHczKCO9Aj9XtpBUIe0Qhb6uwrHUQ5DIYeT9h4cTG6SLln+eLO1P1rb5?=
 =?us-ascii?Q?nFSPCEzCGZ3KZotZzxyjdgCw933jqnVCneFg8DOuuIPyj8J2PB7P1E8T7ohE?=
 =?us-ascii?Q?QnaAmttCED7oUZmCB1tMQ069gmm6S1DXp+tSvxgyI3iRBoS27Qahoc8JpKPo?=
 =?us-ascii?Q?xmF1OaGQF1hiZGdJpBOG0CvxKqmAZSXOOCXB0dF1AjEEBrz/FhhWVEQjC/kz?=
 =?us-ascii?Q?tBR6cSy3N3AggR6/QclsdWF2Pb4MT7FXN8YG5Lei2IY/Rjag4r18anAJ4/Jj?=
 =?us-ascii?Q?SBHyEjeOXd4zv0fcszN6A3Zv6BvGvSJtHie3MqAdLoO6g57/sPPj/YZL5BHP?=
 =?us-ascii?Q?9q92w4dhfQgMqIrUw5spSMElEgTdi1fjmCeQi2fT8pKe5oGyi1tTdNe7dQL7?=
 =?us-ascii?Q?ActvQ5C86uPtl8HZVsOvTClWaxKdNVbag9d+r2ijJXl8RepmKpho?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5069253f-4c5b-40fb-b2a2-08df033c9743
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 06:38:08.2249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb2JniVYUYiYfnwPWbNUiP2q9trZSqsHkg1tznq5uGdUhl7NtmTc6/jdYsItQJeS+1X/G2zkqijpZ4bs6VjhKO91uv8ADaWC9sNmuE2c/9Ux4u/432TaLRH3p14N76WO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7256
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Aug 25, 2026 at 09:04:06PM +0200, Linus Walleij wrote:
>PL180 card supplies remain enabled after probing and while U-Boot is
>running. They are no longer needed once control is handed to the operating
>system.
>
>Mark the driver for removal during OS preparation and disable its VMMC and
>VQMMC supplies from the remove callback.
>
>Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
