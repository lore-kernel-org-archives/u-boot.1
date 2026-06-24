Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F1FCDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F20849CB;
	Wed, 24 Jun 2026 09:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IaWbnMTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEE5184A0A; Wed, 24 Jun 2026 09:48:13 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B325D8460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/xQMGbzpebbSfIhMikRArkr3FXcWdK0yeld5SYojEPPWLJ+PvakJBVVnA4UNu2zmcjM9FWsWdCZ7/ruG2ClF5efZy6ilfx+E5BqHro4lV2T+gVMQGFiBG++9+3h6Vrz61JzSC8ebt/Vnh02LLQ/q6zi/KEhrstpmdJxU5jFmNxmDMXAIScCaB+o+MH2MEqJ3p3oFqtRlzCfOiq6opd8bgz9ykWXaIKwe9OhTs82UZtPI8XytCc3KEJOMTdtrF/WPvjimd0s98ylllcp35OfV2hGtabq85RpPMzTL6ltf9/WNkBLP0TuxJkzz5jyBsB8BQg0NSRpVaPGuiaBRBjwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghAwwh4XJS9/o6gRr8nYbaq283YMvUrXqeQ6lMDg3Fk=;
 b=x6ywVf24BiFIqAQzzY0kBYOm+DHNUZTLuZIgbANDCyJO3TeEu9H0YOJEAW2Vh06rrvKExm6xZzQg0NtYJPO0VxFKL290ZOxuut1a3isk6vAk1KPUog5NTLSL8Rpyc525HbiRhZTHCQN8yKmhpokC6jlQry/FMesFZjIrd3OoSy7jJ/WYR9XiJcnmVm1KaA2rCttRqIHa6ExBa6W0y7e3myMMkCPhCg/Ns/JFf/83xwr2CIAMq9ViQCKrhTZEtrFwko1D++ra3v/1uo0qmS89+a2rMDEsiuLEXbhrbSnyzaWuT8dlEO+4RoYwD6FU0Ar7Y+IaZsK+pEOElwupKkVZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghAwwh4XJS9/o6gRr8nYbaq283YMvUrXqeQ6lMDg3Fk=;
 b=IaWbnMTDOCcQDNls9zdltpFlg/e5AI+U56Ix8vh4DwBwbPcw0TRSHug0XX241y7SMKLmXwQ3Hzrb28NUXeOeEWZ7aJJFmrkAcdwCBeeKFtMjSDGjP/KxWfSUDACGT94bo04SckrP/oTqsZv8mtcQ3c/YzgpgtXwnasNMV41qToM8pNVuNLTRo9i7lvpOGgfka7AClNLeITGsNbk9s8BZYmAUefHbgOycT700ROSugTPueX0P2W0GV0SMeG+UThNLJXPUeALXOD/SxEQjp4KcL9AY0fFdCqyX35QM8i6yjTdDCWhwH3f2vdaWoNCp4i4CDWh2A/ZCGA7N6Pohkzp+9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 07:48:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 24 Jun 2026
 07:48:09 +0000
Date: Wed, 24 Jun 2026 15:51:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Gaurav Jain <gaurav.jain@nxp.com>,
 Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] crypto: fsl: Hide CAAM_64BIT symbol behind FSL_CAAM
Message-ID: <ajuMgV9jQ2qxiot1@shlinux89>
References: <20260621024038.404454-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621024038.404454-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: d32889aa-697f-4ea2-7bd4-08ded1c4ef80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|19092799006|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: c8GtsonjJlD+uAYy8kANYqeEXgXrp6SN6G/k6I3/dy9GBCO/cx+vEYn4wEy6e4igwgxV8oNV3yfgkHZwfkq2tQ+7p2VPverslrtJnRlUaPODq7RU9ffLpaHW9DuAQernxyDBygfAsczWAMM1s8gP0PEABw+ZssOlQlPlRJdGEGCmdPVVyAOOA586CLoWQsLFcKBntyOxVLRYhCbYFNgsbqbJSG9PpxBECazx9yVtiC54K+PdbJPN0HVNsprx5GpwPSaVRYnICY3RfYOZ9E5x7jZZDJBg6+H5WkqxUj2Qzzm/BsOq8i/ysFymrE72oFPd8lUmL75zl0UkgTZRiLG20YJn+iMKb5RW8WIagr0JHEpEdMQkpZLG/wzJYycheaoZoKlvV23OastjW6DQM4CT/1Utmux5thqD/2rh8UNE3QiV5mYrgmfOpK/G5RTgLF1nAamsHdOVtXk+Ud8BijvoJD1KSA0Oj78vP3pYHxf8iD7uiVpYQiLQdJhCOiTtb3lUzEEK8+Z4fQB7L8AujukZ/m8RtO/++8AJ7f1BjM/on4ORI14ozsubPtOidR0l4WlIh9MOCxT795MB1xYnXuztsNc2COE8hzGDvJXpvqOze+4wXbG54TkFM+jWjOdWFlzOaycd+eNT/STFtn/jcuyG0qPnCHzliWhhbgbWyrtgCow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Osb4Il8XIWsxypKYGgGW3gjP5O9hueLh7Eja94Yxi+Wz8LNwFmzvJW5dMW4b?=
 =?us-ascii?Q?mz1c3GaITP+PTK6k5BX7+H8RifCIKz8vXqf9NVvF0Y8OJFr5842IjMdPjR4q?=
 =?us-ascii?Q?4EFUmMPNx44/Fnt669Ohdox48Q9QgsjrecUNs2ngcc319knZ26+875HgNdNu?=
 =?us-ascii?Q?jbeSF43gPI1+5tFbrdGKqRvB0E/p63FksoN6KN4rA+ehcoHQa/aVppesHbXU?=
 =?us-ascii?Q?XjbIzEoEz7E4VgWo31x7ZJdRuJ+dRc+p6vslXlepFU76jqyM/tJoHfGAYYdD?=
 =?us-ascii?Q?frpBaN37Tv0i41jVGSgto9nQmixRZVXVSlyU6uVTH6RoI10S+ldJyzohMgJQ?=
 =?us-ascii?Q?naNYgpovRSfDCjE5pVQ20M0TohCudulceASMNPwLo1EJATb5hjdRNWn578cV?=
 =?us-ascii?Q?ORbpauL5XHMVNki/H1hOzQwX34yjG2zcJlVowAKurD4YccA9pX7RuoSZUp2H?=
 =?us-ascii?Q?bqDRnGuRyivO2wcbI3VMGrXqz8lAum7u1KFY5b2kJjAyPBJYPlEeXbq4qZ7/?=
 =?us-ascii?Q?e+1PW4MHFFCmKNUtArXxsC9a8ii09n5uwXscivrgKKPA02lv8BIEzVY5VJEZ?=
 =?us-ascii?Q?X2t9Gfw6kkbgoWxe+YOM9XfTBiCVMyG9iPZS5WuMUSIERp1iswhXzew9DR8Z?=
 =?us-ascii?Q?P7eM0LvPypRtb8rGlVOneayzhN4JWF5SptlqtcUhcWSRAsEQSpiqCLxnKzum?=
 =?us-ascii?Q?LEmZEfkZRPxzoPn+EfguSXRAxKvIjqjr15o15HupJdslA4LpmzhKzZm090b1?=
 =?us-ascii?Q?Tyx2/bGrQxpJUzr71NRhJEnbCAby4yupGnmNiEugKFORwMaBLyO0jaF3Ngpd?=
 =?us-ascii?Q?6beOSZ5SiydZufY9q4BKVC3xxlj0H35clFCbeasXnqLZUnWymPE6CLmslSb+?=
 =?us-ascii?Q?XpFbRDtWtm5EDw5eLheHwJSaJWj8jHHXX15tdzeuUa1LOPgecp6SoD5QDMEH?=
 =?us-ascii?Q?SR2lR3C4ZGUyeDoD4Mef0qQpTHzvZR5NMa4KNxs8vQ7VPjdgzpER2j/x7xI0?=
 =?us-ascii?Q?WnXHfDdkPmkf2BvlFfRDF+c/8Af4n0dcZxywBF6zixKEs3imv2J3Ihp7H/Ri?=
 =?us-ascii?Q?1CzWVbILmgRhDtc6+wn7tb3fh4LPnQ1SeaZHJxsgy2aZm6Q6KF72G74wKiP5?=
 =?us-ascii?Q?e5USbx70jNBIzzDJ5D1hsQqKMOFUhNPTnBZpQUd4zSuXIeZjBiIdDzwomwB+?=
 =?us-ascii?Q?OMKz6+FQG/EFw+/gJww0cCu507LbdJ9ykvhtFZjnxteolDM3/q/AlyRVbdy1?=
 =?us-ascii?Q?Aij9wC8QLduJ/3+3tsWGdG2HqTrWdQWymLqDhQGAoxdr7z9SugvXLryfwaW4?=
 =?us-ascii?Q?8ALbE71hcBNUf4GitBpM28ljmOyS75z2Se0QFHueVhTj5MY/FOTU1uZb5Svb?=
 =?us-ascii?Q?baydJHXqamEKs7rQr8MRIuo+so01m5o9IL5oYRyng5w3f+BDD7v6mGbeP3Li?=
 =?us-ascii?Q?NY+fkxU5QvMeE2KlygWhpIFFZwKh5J0/l1ezXQcKjr+l8qu8+ayp6SgSi+Z6?=
 =?us-ascii?Q?facXLMShBpsY++phVu24zd2iqRQR2mItV3cb8Uk2h0VJyLA8D9IjffD6b4uk?=
 =?us-ascii?Q?8dwshSAMRufhdMPTydjGtfDSZSAt8+pjLYlNZh07nwFSX0ef0NLv4uKu515H?=
 =?us-ascii?Q?fqd1jAcKYlOosPdB8ZUGXLevraznVvq7j7SHfWGxyFjppFXHUcz8jZUMmBtt?=
 =?us-ascii?Q?ONpEtUqu0FFYGzEWu4n6odpZTtV8rl6Pugj20Q6ZBBPVrNz+rXF9flPol7gX?=
 =?us-ascii?Q?/nvgBe+JUe+HTUmHsWOJ5b7xnIETEaaWy9UMCozrMDvO30gpK/In?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32889aa-697f-4ea2-7bd4-08ded1c4ef80
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:48:09.6858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m74W0xcLgSrUeM+FZWx/dU8jlgpcDzDgdaIMhFGuKjDaBmiAtEZZeA9TO/fQpRfO1sfAW+FlJUDrX7iQ67HxJ9vgyFGMsIbsw+fMG0f3FH7LXF60G9gphC9rMMAm2Xj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275
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

On Sun, Jun 21, 2026 at 04:40:23AM +0200, Marek Vasut wrote:
>Make CAAM_64BIT selectable only in case FSL_CAAM is selected,
>otherwise CAAM_64BIT shows up in configs of unrelated platforms.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
