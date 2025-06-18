Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE32DC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 06:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A15DA82B0F;
	Wed, 18 Jun 2025 08:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QNivQNY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B61282B18; Wed, 18 Jun 2025 08:23:13 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D2D82977
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcIa+AwrzTKq3OQxig1i9cvH4ApZkZqiWpfYbXO7R593IcDqWNKjQy+NolCkfMBZa35T5ZqwQLZUj3BMTVFmgOeCd1+91OMMHyp9FtVHZnU/AdBEEYzMombqwtSAnnVW7WfeTF8pQI1S05qmVsKtKE6u6vUB+XCRK2WhzlkpVQet+fIN5TGmlWFUrC4EjZha5/6ZI4QtgdpKpLwBWfp5EYPd1pQOL9gyuGUdKEX6rz81wvWdx0/eKDGeuvktyHiJkzgzwUDxQrn54OxcDP/WJp5GcWlKsK1HBRkYA8DsT2+8bpg8tfL1M0K+iX0dtN8eST8q1MmiXJp2RMCZyPWe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqgur+5YBLremOlnvjhGCyO/xzlY2c7oFauyZapxyAU=;
 b=Xy3yyVu8vbwwFnmM9gi7GRQm+OImc4ExHwWLbzvXXvGhMTf/tpHDxII+4HCjUeRw+EBvbh6+VbLrRByFTwMKpC+5OWUvPhm29Dj9J3X69JaiTXagWXial8J2cnAgtS5gubiUX6VhBov8kdecGOdphzR2ZuuW+im8M3GwsucaqYyL9vrwxRo/tUjeDVrcVwwW5h79LSk3uE2gja0Qz/NFbKRSUdzgRSnYzVAG0+wqlPJGSQ1gDtBs6oZmvDLDctNQyvA4pT3UyP8v7Sib4bAeDzggzbvYJCuYcvmybg1MsFOGLpGerqPrm6VK6D65hoAR6OSV/occq2RticeQKvK+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqgur+5YBLremOlnvjhGCyO/xzlY2c7oFauyZapxyAU=;
 b=QNivQNY2G7nUNPWQuAqQGUni+UcKkBW50LY6BHGzmIpxnt26KzU0zUZhlAenULHvAEodA282dFgsyHEpNMo56qm7gWia6sCNh/aRt5apHjdLmBfRLGUF7ZSzOCvpfoDwqAk0fAsdLiiTRexvkwV9Nxk9CQaLDuHllYs/f/ENVbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 06:23:05 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 06:23:05 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>,  Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
In-Reply-To: <20250522165656.GB2179216@bill-the-cat> (Tom Rini's message of
 "Thu, 22 May 2025 10:56:56 -0600")
References: <20250507121246.518691-1-ravi@prevas.dk>
 <20250522165656.GB2179216@bill-the-cat>
Date: Wed, 18 Jun 2025 08:23:02 +0200
Message-ID: <87ecvhzhyx.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3743:EE_
X-MS-Office365-Filtering-Correlation-Id: 22fccb74-94e3-452f-d398-08ddae3095a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x/RJADBatWyCOTEXT1x5ct496S2/bunIXiiY6Y5jCrfFKTyhCas8TrpvxPnr?=
 =?us-ascii?Q?HiW4LX3B5IBmY0oOFm8Mk+UmbD7W2EuqwaieDZaf4ONFA+u3rwoHWx/POGfw?=
 =?us-ascii?Q?NnVnxfr/laDZf2pVSfyjE6AhPORjNOMuSrBEtzfEUsxq+0I8UkETP3WzM+6t?=
 =?us-ascii?Q?RfNFSOAxmBxPqC+0S9+h9yb80sYF+jxvuRtjCaTjXka4z/ftslUgN0MihkvL?=
 =?us-ascii?Q?L8PDy0V34Fdf9VSD998FqKq8REqd+7gMb8zWNw6tEdmanysH4zf8NamGCeW4?=
 =?us-ascii?Q?p/st983wF38ilw9KzPJouBvcIMtSgw5hkKnR2LdkeTcwy4VohhP9z9ZWtbjz?=
 =?us-ascii?Q?j8hfnm81t3yEsS3G/epRtwOxeDgJgwQVKaxnN+8oQoVWWl3QNoZrvFzOfzQy?=
 =?us-ascii?Q?Z6v8lbicSoOx+rF2qlLbWRx3EIBr45nktKgxATCMOeFB6SOt+Y6/I8MBCSr6?=
 =?us-ascii?Q?zAcH1zVc8IOHdHISJVj7sMC40orLUNcjSeRksCBuHh+4PAZy8wNYn6ruZH3J?=
 =?us-ascii?Q?VdwWN6e6KgzzYh2CzQMz5gp9DpHypNkkgEX9c7yZz1vA5Q1AHuSIwd0AZjjM?=
 =?us-ascii?Q?vkjZ09I3h+UJZNSHli7JqlmO/iMn5V14Ph+a7+QuRwPmUWYptF2IhpjFXeRW?=
 =?us-ascii?Q?7eFBUjhtV30eJJfn5Du8clzNzUCDel/7BDQEtGBU6Z+mh004tApWdNCN754l?=
 =?us-ascii?Q?xNdVTEdzXJdPMwXOWIH/SdHZX/U0gGh+N7/SXf4aa49J5Gxcjfxbd1HiXLrM?=
 =?us-ascii?Q?fFUqKpDlutB/aX/9JILq/hzXfQNxLcTqFCTso/uUCVq1W4iUaso+XZIy08na?=
 =?us-ascii?Q?4aGIDNrxHvgMn+tgoVZqqPcij3TbTxd9RP+IsHqF3GMBl+jWD7qidCsmMUjs?=
 =?us-ascii?Q?T0LKUD6C1rjCM7afg/sSrhKsu0Jje4ku1pKjnEEjLTQcAcDmrdMH2oMr0A8b?=
 =?us-ascii?Q?mBw+GDbySwt5TwoSi5aBwtcDGAH3emaQtaOsmHSoCu429LkA25rJc8rDjZxA?=
 =?us-ascii?Q?m4QTkU50OnRxLF64P+B03c2rFcri2RGwccS+9I6OCbfq1yqIgTlvhMa+C2JA?=
 =?us-ascii?Q?fQF8bsYPOvDslUTkkXeKi7qbs0ZHMFvDRqAESQ56C7jSzfEFgBvXKOx6B+UM?=
 =?us-ascii?Q?O6hQomS8tGLt2m/OjqgtTsRfVjY09f9frVwSpY/W99V9r9oE5qc3LOAxzsPX?=
 =?us-ascii?Q?TE/Unfk54pWnZ+/QCcVmXV6NFLyCm6ENjpaKByhE7vtsnm5zabLte+Pp8fGz?=
 =?us-ascii?Q?yVhHgw5cpFIIfHz//8j6VP64nlmURRyJ9b4OvORexKxMenWw+op95u8ef3Fp?=
 =?us-ascii?Q?ggcz40rlWz+YYTxsqqBi3i99/qoIuiV+btuUH6PHdH47hj3D0YveSYQeTL4o?=
 =?us-ascii?Q?kLdE0vLc3OjWCZ8ErbMdRwNncObmKLoJ83hZWHgFH5TIknGNk+xHDQpyACCa?=
 =?us-ascii?Q?tfolgH69Ozc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2rvSxeGrZfHQm0W4VrTgRxE6QmzlT80w1QusNniOjuxMc42BaqPSLW2Ltlj?=
 =?us-ascii?Q?BULaWq2gMccEHgyGqyK0W/cOtJN7rePz12eO03Hc89nQVSQRVOdM2HT7R3O2?=
 =?us-ascii?Q?3VFvmtK09B4bS4m/+2QVHdib8zhcxfrzOb5TNTKnEhZD3vM/MU/WRnl0zzDm?=
 =?us-ascii?Q?9/f1ih/ZQIHH6lBl8baJgma0oZ9vMlycRJ1Ub+xbNuFJ1e40EXAjG6BdwUd0?=
 =?us-ascii?Q?Nj0+fnm4vrEW3+jyTsx3pByGYnhcI4uxgkcIP9FaPyly8ejCJ3kHQxBpsgXy?=
 =?us-ascii?Q?UB79D00NpKs+BEJTXR/EjpZQUsTaBR1cNZlBmQb6ww6mMHawGx0cmeSxmM9x?=
 =?us-ascii?Q?sEaQr7p8MdSbB1J2rsybL0IiWkH2KM1lXQq0SZXXsqB8kEGOxsbQq2nitWqP?=
 =?us-ascii?Q?kfiB7eoS5SyLlPScDUZe5UFCE0V1BVS9hTwHe53MdKrZWyGZ5TxBaXEzt2CT?=
 =?us-ascii?Q?Zq4gT01EHR1e3QjlRHZg3ns0U1WwZGwUFBaZpvXD+K1ESNGyci0BSKNmjqEd?=
 =?us-ascii?Q?8MvXxgp2kqqVVl0mItYtXndmFtzkCnb4MQPqxD5DeIDbNkhTNwPvwtiLWfqZ?=
 =?us-ascii?Q?Gt2EmjFXPEuDMVWQCZwGWmY1qkcX1qpfNgsILXLJLYOrC5kTirRdahhLAChc?=
 =?us-ascii?Q?b0pUGhBmCcxOKHNxuF03EYw49zFZ4lTtYUGD5FDMMRmKVwX7FwW+0z7Ij2eO?=
 =?us-ascii?Q?D1/CfcMyCJy71VUYeE++Wi2v3jlbUG+GtrLueorsUuI1yaIErpvlFIgnCs/X?=
 =?us-ascii?Q?iLqfRIZC/4SIC5r+f6pKk8mLpAqgmy9PrI/G2Fjuel1inLHjUltxDkkefFq7?=
 =?us-ascii?Q?ohr7CKNVaXCvblT/wbIZePNsolUdNEGpXzi1d7H08ySv9ucMNVzxSQLLpk/K?=
 =?us-ascii?Q?c+B5beMdMfEC/j8qXJ/YZmRbIzOBf2NKRNGuDvrEKcIIZAv/KjWfqmqXmch+?=
 =?us-ascii?Q?rgP3U7xV+YV+bAN74iTzrT8SiIDD11NDt7sksteVXfw8vC0Jwk6qb47bWObh?=
 =?us-ascii?Q?3H9PDK0HH82/vREl7R8dgbRVJTsxokYtiZ0ppSyfLmiOTimPwoFxAy24E4Uc?=
 =?us-ascii?Q?QZtfFutrTaCZniS+TfgI1a79oJkgYVX+iGRCcX0jh6td7pk2GbpSHvMZtlEa?=
 =?us-ascii?Q?DOJFIe/d+nMom9m5/fqtFFGBh6Ziyu8r4npWGazcV3OYeguR7QuMG41zl+Oj?=
 =?us-ascii?Q?huEuwNfshmfnwqat3KcSAplrMuRNIeTdcDQJYOCeLeID3/z6zZ6KKzROjL+4?=
 =?us-ascii?Q?JZD38nACkB3t2q3eEo317hIisMfSBit/6/f1MeXbdmncYNEBFNMHTalSqzyD?=
 =?us-ascii?Q?5MHl04/x9yfg+FB7xx/Zol5fmaEwklHRR9MiyAbUAwLHrgfZRMQqPBTH2XUx?=
 =?us-ascii?Q?IWLDooO+SCujeetwQobs8fBqk07pRQlbS+NsY3t2vl6hpDIRLutjUCBC6rR5?=
 =?us-ascii?Q?6QkiDGMJKZDBv5egFnEhwJU3G/G/l4dE6H9UFLbXyGWcaxYGMWT25ADX2Hya?=
 =?us-ascii?Q?Ddoh8/A1tujdJKoz9uOSxnNnmKYSvg1SnMeqnB0yfoeW0GOeMQ7f1tG20MrK?=
 =?us-ascii?Q?vdkePB9R6Axz0LM+EPPQu591vHGejLUXpKzsfeEXOgiitvoZ1P9V1JxAd3Ed?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fccb74-94e3-452f-d398-08ddae3095a5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 06:23:05.3320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crGKsHFyMB+0iEmPBjOyw3Dmo13R8TpsQJ0iL0A6mUE2W6uEWEsMdmbkzfvSEw9zXaUe49C8zO/5jIvBNO44jajgyOJ11sDL5g6VmLIWS74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3743
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

On Thu, May 22 2025, Tom Rini <trini@konsulko.com> wrote:

> On Wed, May 07, 2025 at 02:12:42PM +0200, Rasmus Villemoes wrote:
>
>> While looking through list.h, I saw that the regular list_* helpers
>> (and one of the hlist_* ones) still contain the prefetch() that was
>> removed in linux 14 years ago. It doesn't do anything, but makes the
>> macros harder to read, so get rid of it, and the fallback, no-op
>> definition that they relied on. That requires removing a few uses
>> outside list.h as well.
>> 
>
> Unfortunately this leads to build problems on lots of platforms:
> https://source.denx.de/u-boot/u-boot/-/jobs/1141951

Hi Tom

Now that the 'remove volatile from gd' series is in -next, could you see
how these cleanups would fare on top of that?

Thanks,
Rasmus
