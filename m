Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3D7CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C1CA836AC;
	Wed, 13 May 2026 12:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XnDbVRPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A4183E36; Wed, 13 May 2026 12:51:12 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC57D8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug/Lesiz4e+2LH4elJ89MW8LfwOHu1E3dmD7pnVGn4gLdllgggxZ00r/+uytWoa2CggYJo6tjiWsnAVN4f/vjRwAtY7FWODcocNUC3DIg7r82X0hlCOFJTkUkqJku8anDSklSACxQuhuSQb3KY8tyzUrv2vpxWlyuNn4JbrNTSGK7Nsxk1rs5idzAQhorB0BV867g3u7WdhdBclH8UOQVjF1UIZO8yoT9yTtLYQSQ/YvWRzTgCJJLhA7ddrVGNzgoP8/mB/OjVtGofXhMzUi/+NnkBh0E80UROU5aoQeI0fbpJGrlRoc6rLUkfILmM8xJS1DKnVal+d2KyXa5kqSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LINpy/imkCgHyqX39PFCuawLFb0RTRm/XqKqXWB8m7g=;
 b=UYY3pQj38poJzdOtfksImiVzTaozHAYYeYmQY0Q2uqTcoL0catOxhBNDY8EbyPy0OkUpW3QmdE8mnV6GqT3tp+tLXFaBsJDeSr3ED8SZQSYLXO187iRykbCyqcBVjf3xBlktaD/H1wzqn2GPWf+cIpvNmw/7ewDcZzt5uQmmgYiw+MNFV4ziaBCJ8YNe/w0moznvjbzGSJd8rtyF3TPIfVfawAPs+0ZjhqAQlNfY4zfc6vs15icq+d/TQfs6GL7GwWBX7wHHhHJLmGxvOo4eCkRtKHKRAGYHFskon7TjAHh2GGBQ453uCeda2prWDfOlQqYsgW9OmnI/vaKIJyzw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LINpy/imkCgHyqX39PFCuawLFb0RTRm/XqKqXWB8m7g=;
 b=XnDbVRPWE6rH3MvTcz/Qm65+oAAQCjyDKn26odiGIQv9tA/0s8k5ozUBrW9ZJ0sECcobdabJAlmwMM+KTUneMY9Ye5M690FQomgPGNh78JRmvkxeXpNdYNkz6WhdTtdkWlGSbGK90skdrMrjmGrGrrAOFN9lHducMp7DArNHma5tOWbYFiZeVRs87tBw/sVxNr4UP1p0oqRlXPp0P3k31f36rhfwWJNS2JY3TtJGnugMFTACoTpRaafxPLe6scIJdbFIkZv2z00j3W0EcOnFhvVqSF6CejSnPZdyG5K1x0AckupIiUJRXhBUGeWe4IyHFj9aYTTr1WiwFXFx3XS2eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA6PR04MB11830.eurprd04.prod.outlook.com (2603:10a6:102:521::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:51:08 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:51:08 +0000
Date: Wed, 13 May 2026 18:53:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] power: regulator: pfuze100: Fix unchecked pmic_reg_read, 
 return value
Message-ID: <agRYRih3KD7kzqQy@shlinux89>
References: <BESP194MB28053780A7CD5E47FA0FDA72DA3D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BESP194MB28053780A7CD5E47FA0FDA72DA3D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MA5P287CA0071.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA6PR04MB11830:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1f6a23-dbe2-4320-8ef1-08deb0dd8a1d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|19092799006|376014|18002099003|22082099003|11063799003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: HyCwHrg6jQCJm1YzNoidaC/IunzNGmjGQJT/aRzx4Te15tWDgpJadHHM3USMhAPxxYpjdFWot32vBJ92+R6vbj8k1nyHvZp4WK1DoxAHzEA2Kp+CtvwEeEl2zOe6LenrPjdKBUig3mM+FVpNNsYn9n0CvxIWtyWzPaRR4D8lcleezULyydv4a8rqv61Xt3eL2YQcMR8mAb2MiFKmU8D+wofjXwJRYk/GtvSj565eJkLdtslZAGPwMxXIbwkJ8wfNE8azN9rtDN5zjPPeb3Rj99IE4lDyTKvgjvKs3X1hunf1t75ORNEKtpxn5OVnnppu/PqpLYeurIpgLvoGnJ7M9P8bNQUk2hjglWb66ONv+JdlGe4SHiVy5a8MwT2HBH8bfvt52tPMBiqdj2lLnVwbtBJ/PnJEoRTGhNdeA8+YrDt4evPKZ9OkzShg/wHvOZo49W6601acpXxOpR2hugIw7/3AU8Bic8TiEeBVunjHHSRyAenOzojR0rCnd6WQz2PjzMQQSY2htiDNyQ94ekVoLejooLmCBre/iR1eYh0jkWY02ln76WpBkX6SBPRAWH3qTdI4idIZM+rS6CykG16OYKbrd1zLubyt6aSZUwy2s7icAvFHUvhbLP42AmDrjh3jeC9xB8F0/Ba9doYQKYBaT8Qxc0cIFkoWfkdNzv/53kaajGamCSEoA7CxM72chh2b2TSiMnsSvF1NyDDR6tnu4C+rTWCxdEiCklFetCOSyEqFanvoJY/d1N/H32efN2sS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(18002099003)(22082099003)(11063799003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QbfHEszryJWj5YdG09YdNSKHzUUUGRdxMvzvAOvImnawwvl9qPjmTHyx3Ggb?=
 =?us-ascii?Q?tyugbAQ2YxkQtY2MErHzpelJ8It6ZSu+fv3JXkQtlRNcyxaFCw0+9NFspBUM?=
 =?us-ascii?Q?LzOJ7lsHwRvc5dzb8+ANAqRcDk4mfBP2wQh/bx9S5DTl4NqiJsgV4Ol2Q7nR?=
 =?us-ascii?Q?mEA/75LGgnqQLzGdf4lXQOEPVkeDeplIprs9p6pFvCM02wfrZggeZUZGdpw+?=
 =?us-ascii?Q?9Ipk2ySfm598w/QSwpgVgGmUHy91Lta6FTfk9dbRm4VybmqByXAlZRUHO/9Y?=
 =?us-ascii?Q?HtVrwpv0bwxnH2fNEID5MINeUyPsHlpOVGdQawvKrF6TGokCyCTUS3USyjfB?=
 =?us-ascii?Q?EqYsXSm83sHEIC0IubcsZnZL2X18mJNozw0ljYEhNENXWv/z2bRdhzoxm+O/?=
 =?us-ascii?Q?SyUbNpHEydU3n1kjX8rBw3dBiD7YNMMMjmr6x4kwMyqQEKy/3Uts6CGCH0bh?=
 =?us-ascii?Q?yL7nNapO68PxrnrtJaTLkpIdNkScy6zDPXCIyIfp3w0qleMGicVJbSEu461T?=
 =?us-ascii?Q?1NRif668oQQ0s7CsHzln7cMuQV6qdUkzJr/lwy80JW9fOxel6dBNez3xgTKT?=
 =?us-ascii?Q?MzEbjlinIKcFkMtGyRWDoj7kCILmNSPpwaWVhDyvp9jSk/wkTwt8PU83Zhtv?=
 =?us-ascii?Q?hK205mmkTzm96YFzZW9rovUHCdSv2KyO3xip8thZ0q6umHZ64644CIJ8iO4v?=
 =?us-ascii?Q?Eu2SB3geOSuRbUcWsGE7PYD87Q1SHjleDY+2Nz9qZ5kh0HyoHUrDl/i0Ojt+?=
 =?us-ascii?Q?JtsTxU9N3Ji/nNIBC6gkM1fLjs4ixDuUeZ6xVnh9uvUruUd9JgvThfcYOQhr?=
 =?us-ascii?Q?C2LsPI4iT0k8a2eBFdsO4LzOr6a31CIIhPonlOWDsqW7D0giD1ks59nBF7Ki?=
 =?us-ascii?Q?kCRl5Eniuufh7P2PbtIQwKLluohUDdcBPtprcoA91ILUPYHsF6lYlE9J/KCd?=
 =?us-ascii?Q?gS14QRmqn/1UH4sFrtzP09JjSf48CCb+n4Ffh3h5bueLhxq9PAcbE2SSioIq?=
 =?us-ascii?Q?ZxBlGxhkCcUY4Y3niWhVPcqS/gW5qyto1VPgLXUIAztXaGdzfcCMCpLJSjyz?=
 =?us-ascii?Q?9tvfMKzYCa2FL37Go1z3ljwZwK9/7LGmeK7owN+xaz9uw4V1wFt7v24higGj?=
 =?us-ascii?Q?9MWoHu0hyXEIiziXNHX/cqyZMUGIzTrFkLfoFHt1sqJ5QLYiw6wC6r/bLVPB?=
 =?us-ascii?Q?zMFG6uj9lJztpXyHRhJeRiaoQkugRVBjVTmITFIx5JVXOiXzjm09FzaKwu+i?=
 =?us-ascii?Q?3m9bn3MlFB7/sVE/sE0BBNXzfn3+p5u4VM05GnE3sd7gcmSZxBE1jG83fxy3?=
 =?us-ascii?Q?monLbs9GDT12hyq6Mj4qHmIg93Xytpgmtc+yCj4lkkhaKLfZ00x1c+qLKPUC?=
 =?us-ascii?Q?2DTKdfsVEzCKBnUN4QoBvO23UTsgehxsVbHRaYPzsbVk3sC/u8Dtx4wPeSex?=
 =?us-ascii?Q?B3lwa/qR6x6z3uBH5kmY/SVaPvc0/Pwctpt19bK6wRFpqA2v6yNUygO2G6lb?=
 =?us-ascii?Q?d8Ql0NFIhVQruxNdpsYJl92n+NBzN20kYrgRhHsJUgoyxdP/Y8JvwV+VENU8?=
 =?us-ascii?Q?8asT+VziwE0Di0u7IXW7Fi1QIjPDbFaJG2qjxWdQoOUxPPldx2nuh2RxQa/z?=
 =?us-ascii?Q?1NxHKB8wCRQl5Db8S6eGVRL8T+Xzjid9DrTNL9yNnUrO1GFcMlCi7gQfGhkp?=
 =?us-ascii?Q?thD9K6lQ61ESGyy6OKxZ4ep/EU7BjNvYtSiLgThb7wka2kKqm5t1f9LDsgPl?=
 =?us-ascii?Q?jBOipN3Ieg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1f6a23-dbe2-4320-8ef1-08deb0dd8a1d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:51:08.6459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dccfek7tzHmLlOu9oLfTq5OnEFPscJPYFmt6wNR+KvhwgqLhXr13HqzyIkVaY0WGpMuW7dk2JXzgrdv5psFslg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11830
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

On Fri, May 08, 2026 at 10:11:35PM +0200, Francois Berder wrote:
>pmic_reg_read returns a negative value if an error occurs. This
>commit adds a missing check after calling pmic_reg_read.
>
>Signed-off-by: Francois Berder <fberder@outlook.fr>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
