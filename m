Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150C606A32C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h9/TjLUN;
	dkim=pass (1024-bit key, unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=ODj/5E+Z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80D128116A;
	Wed, 18 Nov 2026 18:17:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdUxuulLj5Ga; Wed, 18 Nov 2026 18:17:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C10AF81148
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795025877;
	b=bFfJrlZOXC6pd+LJyBnYTnVSdi/eomYRz/bpvUrXzk/y4uLAbk+Sy/8UBZuQl7bhWT8F
	 XgihMcQM1+oWush4ads31qQ3nqdXYnA5yVhC/3S7gV6+TTM9lt4M8jGBw0ulPU4e4H8I/
	 sqBz1UFuEmdGi17kKNjED+YNN6N51MF0TIewH+McEfzgfs+wLJ+iR6CEQ5fT52ybytqYN
	 e2nUneC4wEAI/3IH3dohxsQ0VJsRSl3v1z6NvgaJmG4lfRCG8f6k/sOBAmpNF79gQyc71
	 72eA47SeVM0gXa4uI5AHltXevWplam7yUPnJAIBFd2kJaEvKoDzFTD9FkB06r4V+8Rg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795025877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S7bP+x0nv6+vcWoxqgDYDM1B9grtEtcAkPYNunYPofI=;
	b=lQHz6V4PKIsavfbKm8ycsLXESjou2SoibJLeQNXsGttViiKXhb4/IyYs28/zpAt7k7g/
	 aOhdCzPHH95PX7GKupug1VkLNjhbt43B2EU0Zzseiv0FhXkpy+DXb05Lfi1bVqjAgNmmj
	 vhO96Tae2E0Zi999aknkpexJ+1JtZVIKDboTG5pHyl6y/xYl+Qv+Dqf5UUdW4PzsBWjvs
	 NG7SghHXzMSr9iplv/nRMUxfeiC5PwMKZoAtHczflwzD/W3i1ZjX0ulu7Qs/Afkh4Rh3y
	 WwA0MFPCjafv8Fvf85hYOzaJvDGdumeOhyFDyU3Gq46qgEUlsqKXHx374rXgHaIqX3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795025877;
	bh=S7bP+x0nv6+vcWoxqgDYDM1B9grtEtcAkPYNunYPofI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9/TjLUNGYPf0qY4oI+PPsxIyjxdS4tLiVRwLBWX1vjMYTs7HAOg+qudO1c2GP48I
	 OC4+MgYAEg0qPWDjSyTA4dkriAIhwsqY/KqCKm37YOxnOMYLeQ6dcRG1dPT/8oKN0b
	 KBCnqL44QAQaAWoO/cqLs/Sfzkd1mAVEajE/AGuv2AE2WtmiMD4jc7Yjus148wVUdU
	 EojYcvTn9MLtmga5gHQ7qpFAJ9g3rRuLtWlvnMqJU4EL+k2Lw82TKzA2BlKIH0iLr/
	 ouGiAr82wCwe596vNTRYEAHKlxItOkuoLYrhbwUM1DmgC6znUiEZabEZoFoGI7L95J
	 xm0j24xf+2azA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C10AF81148;
	Wed, 18 Nov 2026 18:17:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33F1049B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 18:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19BF2400A8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 18:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCEwsLxswN3h for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 18:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0A70E40095
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=194.104.111.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.111.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=ODj/5E+Z
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A70E40095
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1795025872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7bP+x0nv6+vcWoxqgDYDM1B9grtEtcAkPYNunYPofI=;
 b=ODj/5E+Z0tZ+ThhVmXGfETbsm+MvacFhLEmAXhP5EHqhEYc0LGwuSy7n7C9NDz16lcnJzO
 rmGi3jeMdaOEbXaC4CzdtarfFma3rYiYrLcflmi3S5cmFngYvvL73o2Udkj3OSXtCG7Obg
 YUXKe0Qb39jJ+nVrcDuFzOjFGer7BBw=
Received: from GVAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandwestazon11020103.outbound.protection.outlook.com
 [52.101.188.103]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-90-BcHUVSfFMZS9Iag8VSEk3Q-1; Wed, 18 Nov 2026 18:17:48 +0000
X-MC-Unique: BcHUVSfFMZS9Iag8VSEk3Q-1
X-Mimecast-MFC-AGG-ID: BcHUVSfFMZS9Iag8VSEk3Q_1795025868
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB1031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.16; Wed, 18 Nov 2026 18:17:46 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:17:46 +0000
Date: Wed, 18 Nov 2026 19:17:44 +0100
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: u-boot@lists.u-boot-project.org, festevam@gmail.com,
 sbabic@nabladev.com, uboot-imx@nxp.com, trini@konsulko.com,
 marex@nabladev.com, o.mandel@menlosystems.com
Subject: Re: [PATCH v2] board: toradex: verdin-imx8mm: adjust U-Boot proper
 offset for eMMC fastboot
Message-ID: <av3ryJ-k_Zltq6AO@francesco-nb>
References: <20261118174255.3388175-1-sergio.prado@e-labworks.com>
In-Reply-To: <20261118174255.3388175-1-sergio.prado@e-labworks.com>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB1031:EE_
X-MS-Office365-Filtering-Correlation-Id: db36aa5e-4c3e-492a-7d00-08df45a03ee5
X-LD-Processed: d9995866-0d9b-4251-8315-093f062abab4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|3023799007|261021121427099003|261022075727099003|261026121527099003|261102123227099003|10067099003|56012099006
X-Microsoft-Antispam-Message-Info: 6hv89J8jRe8RnMliEGk5nSmIpnRpgnh3GAhQ39QDB7Wmyl5P04r5N/KP2C6E/EMb3T4aXoW5hWA6DLzp9KWKRB9e9Axd3Mpzzw410s33xq11DyAkP7ED3KbbzTbuJzpIXNAw35o/DjL3qxyxFVKLYfpVpkaBQAYGCD8zZIQfD/ZGOWPLd4n2Fxl68NACfn5Ao7Zz+OerqTN+mcOvG3OL8p/hyrTGnx8YkAi0Cyt/xaa8rBLd2qKsLnqP/M+/YMAQqX046hZvQFX9CdR9iH7UMB0XnUreEcZpPeIByBKlji/uwm1Pm+DJx8rpxT6cFm4q/1MzLJ8E14vhYAwtKZxF3n7wsBOUeLN+Asg9yUalFp+3nNIXXBMRweSfTKTq0tphpGr3pEOSHzMZz9kpMkDhxFEw93cbQDRa4pC4wG1SBE9wLsgpvnu7V4zKVTzo+E+vBcHIIX/NtpbmZGSX8GL598JvAsbyVgwfGJUYPn69H3fNiB3qtUj0BKlDsNworOPnpdzDu9+7peNg+qC+S4bOuZTM8qf0NNbeGmsSfZ5RPf0JrheI+6gU+3GdYQIj2WA8el+0MeVckTOCCuuqzpHRYYy8qc2mDCQ8sWDBGVXoDeG1R2OcZf0phcy0dJ/VmEQhh7Q24hyd1LQkUGXSfd1idVOvUJjk5UjmCqf5kv/wt3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(261021121427099003)(261022075727099003)(261026121527099003)(261102123227099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WweW4YLRnj6w0kzCT6XI2LjSR+JvYMQAtu/auhT1j0M2A1majODmEvzoWmp2?=
 =?us-ascii?Q?6Ki4AaWg44ePTGT10o8RuwjeWKgxg+J+0KdlwiQE+QZ8ICAy9mTh0/Wct+vg?=
 =?us-ascii?Q?GrSY/M2hDmgKOjHnXZmae6+l/fCN2K9DNTwC8QNiZIZPHhLwRDEIc1YyM9/P?=
 =?us-ascii?Q?uoBd3Hb+/2+/zSGcDmgedqaFiOUlCUyRLGgWKIzpqPHXnzr3pJJRfO+uIrrI?=
 =?us-ascii?Q?DEv9ga1dG2CRKiz+FGPbXK+CyuD7bLJG9zmy8tBj62a02WPi6KIfhDkeojwX?=
 =?us-ascii?Q?ILzRZXWRJjf+udqaEHGYt9t25Hxb/PQbBT1wvDh2baQRj1rJ891gy6yWBCg5?=
 =?us-ascii?Q?LRG/MpVq5rrQESef7gIVrMTYcph2wkZwDR7PGfAZt8S1IzN+on8UP9pjdI6v?=
 =?us-ascii?Q?ne14uUIHxpb72Lltspi0TfvWyNZtqYWmHS09rbRp3ktPU1D5NDIfYO4mHkqI?=
 =?us-ascii?Q?GjtkA/2wAU8Eito/CFCccKvziTIz7nqk0qDvj04xkW44VbwkFZ3gJjjJJ7F1?=
 =?us-ascii?Q?H05nfnBD/+GaUeYdTSuuJNwrgm6z7WbV5Z+eeftjHb2AACaUTI7rF0bi8o8Y?=
 =?us-ascii?Q?VD5tm7OsAJrLQ/yoovvw2f0YAkx8E9bezjDhnyXWnnYpBcU/ARdssDp3iFoW?=
 =?us-ascii?Q?VGKaBialZE9uMVMYXUONGl5mMosIJGrQZi9KYgIq12sHnoxG6BwA9R7dn+ue?=
 =?us-ascii?Q?epk9+IBVmwVhMkmI8Cer9U7/k15HRrhlVQsrXf12XMJQICe7UA3mxSsA6A7C?=
 =?us-ascii?Q?tAiwRCbqq5DCzdB6C7mX0MCtcfi2rz5n5HKwbuESrwXtQ58yVcMfVE8ayeo7?=
 =?us-ascii?Q?Ob3Nwk2ZUBLO2+Ouk19OPvHIFUC6sBATrGtjpwJXlryHjzNEUByMyS9VZ2GR?=
 =?us-ascii?Q?d6eByZ/a8wL7pevYlxPNgIqEL74JkHayVddSFxoZ6m8hZIlBybyNdP5lln8z?=
 =?us-ascii?Q?70jWW+HQ9C5K2xYCBhWOZKfVg/lFJfwWkUW6lKtHc8Oo3eEnZO3Pa3v5TJSt?=
 =?us-ascii?Q?VoHs8miNWH+re5EuUtKzpqCieeXB14KSGRZSntNEyd2ZR3W2I7VZqUKiVvVb?=
 =?us-ascii?Q?cqC03m+A3U/21f43mAIgBdYkUatQs54b/o4dmCY6Cj/9gEzh2FxAxlSDJ5YE?=
 =?us-ascii?Q?/GspJmKt9b/Ip1qrJ3N/7gRyn7PHC6p6hVL4v8FfK3MwoKsqj9O0KvnbLGCz?=
 =?us-ascii?Q?SshGCMRXaak9meEvNIzhwFH/kduH8VD9UkiW/0HvJ1Tc9n84Z4TEJnaLH080?=
 =?us-ascii?Q?y2UnVFsuDzGQJ09KKu1nz3mU5JgLy8Tq0k8zvT6qqlurJGwDlBmSTBUFJat1?=
 =?us-ascii?Q?LrEq8rURoG2j6+z4q+yejwcPa7tiulp/ar1Ue+frr+9zjUKw8wlhks3ANRan?=
 =?us-ascii?Q?IQ6bujA9BoHTLr/AT1Db4sLWbi7X18t9jMWCh4eh80Vqu/XqU0tUWCd2gt//?=
 =?us-ascii?Q?3GWHQJhnBbHV/w+uLbyxt1rTrsGpJQMaE/Izbup5W5x48XC0BCdses7wSt6E?=
 =?us-ascii?Q?MlFDCJ+eXISoZFTcrMH1G35aNktniag3iDqeXdqKGheKUPXxNATVfPqwl+Nv?=
 =?us-ascii?Q?6zK+hS8m9CRNPihW0IQzS9v7gk8mNwfOJG23eltRFw9P6Au3/o4SPJJ34cZy?=
 =?us-ascii?Q?BdePTmmhyuwTBdrVqvIf4MJUT3lYZWYYx4MGu4itVpKsi8eIM9QOwwDNP7SD?=
 =?us-ascii?Q?FgIS1jtPUo86yVFgba9yv/bkvZwz3t5xh6Bcij+jCtkm1zibFwvn32ydAhBv?=
 =?us-ascii?Q?zh96yqgBL9JypIZB0FyYoXMSEqo1koE=3D?=
X-Exchange-RoutingPolicyChecked: BGCXx96L/Rad5lwBscKOkxE0TJ5T2a8SwV5WxdlbY9zoDDDNsp1u3Ffyzc5X6wtgk2b3TrQvYPQoVDzDmRJVKl3mF7GaR3ByDl8+172QhqbXoAfPWUO2RG/NP+7o2R1ufEXCJLGAzwfI1R/4hVQkWDG57vo7dhIE4rAH8vee8FviI6OTvj1vLhU1wsiJ+0e81d/6tdjg5LHjv7huOosV8HQKBKkDO4dAlSYPd/ItuJXMPN4EPwpzUKxoJfvpPMnRk4Q1eUT1Ez9Q0oX4oKNs2cKtU425mjFE6+BHDpngOitU8sZ9TsK3frbSc+BM3EFS+cE+fyHMNbnF0rIEMcxzJw==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db36aa5e-4c3e-492a-7d00-08df45a03ee5
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:17:46.3888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwBk3Fkfl7Q+RaUu9VWK3GjiJLKf4MTM56KdKs9le0FEGs9OUqQ0JSFdpc4EynkP7hoWohjUE84K0qLzQReQylzUOAlErrXQOgLQ4p/WQDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1031
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HkQIAantJh5r1ex8PLlqzou33VPGpnc_vaOEH1yDw7g_1795025868
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 02:42:55PM -0300, Sergio Prado wrote:
> The Verdin iMX8MM boots from the eMMC boot partitions with the eMMC
> fast boot fuse enabled, so the boot ROM loads flash.bin from offset
> 1 KiB instead of the usual 33 KiB. The SPL loads U-Boot proper from the

[...]

> Drop the FIT offset override and set
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR to 0x2c0 instead. With flash.bin
> at 1 KiB and the FIT at the default 0x57c00, U-Boot proper starts at
> 0x58000, which is sector 0x2c0, with or without HAB. Do the same for
> the MX8Menlo, which uses the same module and includes the Verdin U-Boot
> device tree.
>=20
> Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

