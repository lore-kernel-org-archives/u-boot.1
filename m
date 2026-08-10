Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA51C5AC82
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 12:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44AB2405F5;
	Mon, 10 Aug 2026 12:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lyx8abhbeyyC; Mon, 10 Aug 2026 12:24:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73246405BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786364683;
	bh=HXuMGaVXPMVUV5XHRtJNVdcD6LsDnA+c77It2FH07e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=twDdjf9fAGJCfUKayEbwGW2rHnToHhPWYF8rpq+DSj7HXpJ1wrC9GNTZ3fxVC3nw9
	 CgyXNfAvzWR3bqubQHdrWYZYn4/UKfgtIF/g+qRcJvQ8j4IIAKewIuRlaz3pZ1eQiF
	 g527pXsKZW7lHRqKkwGzhR9pGXqfG7lDWuTDvdXt/XuXzvMkWeZ6RIwclpffhB8rF1
	 9rvTsrXDn7MiSysWJPW62Q4lSHh7Fc6UGnS3WH0pIGuzyASrB2rLXLwG/acEGZd8rp
	 GsbgpnqM0bKr9QmtDSGgxhQWliLJA99cI4T8dgwXTgtwREVklIJ7EpTgk+5XRmXWw0
	 4WnXaoB87Updw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73246405BA;
	Mon, 10 Aug 2026 12:24:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ECB6296
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33C3D405FF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o8nvvD8UqKmc for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 12:24:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CED85405DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CED85405DC
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CED85405DC
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:24:39 +0000 (UTC)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AAUAFg2907041; Mon, 10 Aug 2026 08:24:37 -0400
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fycs1g9e9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 08:24:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg8wv6NL4JhBDfUeDTelkjZxo74bQt3n8XrsrX0euRLN44lxjasY0tQTJBu/8S6YGZ2sFBH2z/qaEgHwmYC5Dusqx5DUSwUJ8XAzy16SArP/49ts09gYbknVFnDdnE17H4FOcfTzwgcNQoTxB2dBx6tAq1aqyz7SgkWMdTZXJZvjiU7ClQxIYa0jYkv3fy8W1waQXiQoDx2DUGPzrzW+tOKWDnuCYQd/m7CqAFEie8TAqzdmb6D+u16b/SOsJyYytPqwXCnPmLz18YUpqlhre/YrSnxtM79Dn/j21J9eubOlvyb29BwA7X5URqNhIeKC5JXkHAB/DzHSztGMhw/1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXuMGaVXPMVUV5XHRtJNVdcD6LsDnA+c77It2FH07e8=;
 b=jMSzBDilRfKvWDoWqm16C/nRo3UgHNxN/6pN5P30+SsDoIKYiFk3ukKEG9LPlDvqOKTNX0pw36RC9TH+mP6RuDrhostp7YbQlIWF6whXFN4BiHt+Kp2o+45B4x3GUC0hPMwBx5PbuhJY10uUiuYbHMIczh9Ct+7/hTUpDz528VovAxo79M6kkswc8u5ei6w7YIVP9Et426/LYfKQnHOQOG7uNCrMENaKIR4e8JilF9UtEqUk+fMBIEMGdzQqWZklkucRSAaShNyxvRYy6Rq7q/P2SXk6q1bl2oQG7s1PpDLhYi5UWefhIcYpxVQErydq8hfc1TuWUEgxGba0Ia4Dzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by SJ0PR03MB5407.namprd03.prod.outlook.com
 (2603:10b6:a03:28f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:24:34 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:24:34 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: malysagreg@gmail.com
Cc: Caleb.Ethridge@analog.com, linux@analog.com, philip@philipmolloy.com,
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/2] sc59x: Disable CONFIG_EFI_LOADER
Date: Mon, 10 Aug 2026 08:24:28 -0400
Message-ID: <20260810122428.5036-1-Caleb.Ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABdDSeWumWibqCiPf0FnbOZbQZ=95XM8vW4TyTcZ2DS1s5e+ag@mail.gmail.com>
References: <CABdDSeWumWibqCiPf0FnbOZbQZ=95XM8vW4TyTcZ2DS1s5e+ag@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0381.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::26) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|SJ0PR03MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb56191-652c-4990-3f0e-08def6da55fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZXzPiayGf1ho27v09CBksCexrRJfxPoKS+x07b8D2APJvw7wxXqJCkI0TmrLjNwTW+Mu0vhjWIhTIG7CHKu6iNzlTfNLKeu+lGf15o4yBtENfmm8w1E10YT19CUYleWvC1LAScKS4WzGI5UMHUynsnkqs/G7pWXoin7U7PSLjDmBLNAJJOE345XYWChfpAKV6vLZC2dC8tBDiQOZzs10Zvtmwfmf52QsruIJAmQFdBm29w+4JI45k2wXuN5wEIXtTD4t4QzvT/pYP6gEK6ou5AHlUrpwNeiuUoEmDMHaqqJiosWXS3SkUMPKVqWBEsKph7ar6sFiN8pYhQHi2IEbsQo8YdXARbQj7FUXnWMQwLvy+Y+asFV/mJH+ijxTdfiATWOnlNjdRHKZ5uLjxm9McsVWFwecTH2tUii1uTY+ldA/jhH6u+32vRz3faSqLszAULneW4wh91wCUFeXOHNjY45ajlvRB/x1c3xc3z43WeMmYmcAUHIfMxFz0gzdZmyhZgEf+oeN6IAcAjsvTxxno5ejYN7KLZWA0jUM5BWZdUcMitcxqp808gld7RCmE6fMmNtpn58I8Thjo6ecaQNnTT8PKQOOvC7lXLzHA+yZyHwTbWTtH7Zvfm8MYtCS5S/NB8Le3N7DSp7siPuzbRb/nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+9oJLtFKzSEABIXnobuhx8hJgB8fU6ZCWs97/tmii6LWF5CfFzy4FMHavTA?=
 =?us-ascii?Q?GiQtuTy1NVQOFXomxvxPDHaNUgDJk+1U6oo+1gJt4y07VXqOuHAkGkeDt3Ju?=
 =?us-ascii?Q?nzp8ww/BrxyMJlOWAwLtWudkSxYPhHpbgETeSoAvJfATZ0238y8zfPC7VMng?=
 =?us-ascii?Q?/TMe1AkHGv0+9Pb3qDOq5PT2CWpKThB9Q0c//EAR55pCZdEjdbVfKMXVrKCk?=
 =?us-ascii?Q?VIdBmg5SxLAfIif+vR6nFqPYAg7VBYoRVAIqyzqVIgJbUL1bjNrsBC2nORcB?=
 =?us-ascii?Q?y1tyZw+DKX/rPd0qIagMjcSdpow98eVVlctuAtY7cwyBqjEqkhpGkC1ke22B?=
 =?us-ascii?Q?Ho0Op18DQHnIbUESr9KwXz0y8e3JEBiA28h87r5tX0W3lms+BrzDhw9PrdPp?=
 =?us-ascii?Q?RWorf9O0VIQ3jkwY+CYoYl2Spllw5eBkuQBrpqvMjLYve24VWG2Le3zXKErO?=
 =?us-ascii?Q?W7YiavWkJGSbkG9dYFO8JAS62To4WPledNCF1XLU/JIteH9HwwU0DfEamCWG?=
 =?us-ascii?Q?l3WI9zdJqMmZJhHJzHweZNALwQF1fAVHg5dKdC1FVfNinukH3XZxjVLEF34P?=
 =?us-ascii?Q?wS+bPqUwYkti7Bzhpb5W1fOl9yEszSmSDKAjRBoLvLwYYMW3EyJ8S2kOgKSc?=
 =?us-ascii?Q?QS6CaQvNGuFuye1Z01DjtuQe+S75PyZSImFTSGxmXiAKZrQBpt3MDLRag76I?=
 =?us-ascii?Q?7mDwy6nXIRDUjbn8V0zjPpQjSXbSqKiVrtCp5eBaqgFrHqvTbFEQNRKptkyG?=
 =?us-ascii?Q?NBbdW+ljfd6TrMayuCITbW/Z3HnV96ctxSR7i4IlpgJFQpTDBa5sGgQEihLh?=
 =?us-ascii?Q?zuYVBSqwlMRpVRjHjwanii4n4LQaMnerOAjrti9lzmc+xnPWTKUDoq+wneSF?=
 =?us-ascii?Q?5N/PLfVHGeYXxYdD6cXV1kJ8LxI/UCpQ7VloHYGvNgqmokoVx3WLaxx6HfVp?=
 =?us-ascii?Q?/uXLpsSQIoFODvtEDE0mFXbMOae5ebB/7X2v6XitaCtq9AcKmeN0E23VSDih?=
 =?us-ascii?Q?yp+mxJwEkN//IAwQ4CsuLPkG5WmeNAnYscY/CwfgkRHkll5Q12bPDNcxpmv7?=
 =?us-ascii?Q?KOlCOW8yScz5igDmo+pbC/pFr2qQ4p53nLYN558/G7MZBHkyjatZCuGTHric?=
 =?us-ascii?Q?Dh89L1dnz2n2OnWmQMGGRsFYDWbHn3f9EOEx93R+8QawuQSpPaf6wj/hpBoN?=
 =?us-ascii?Q?5LOpHRNoKelkVC95UP1itq1dtZQfphK/+1WYLfgtP+x1KzW5TcEzQ/7V0OCR?=
 =?us-ascii?Q?+JQKqkpXjubFTo0LtZYgunIuF9bfeOVmaggApvlqrvuG1I6veCNMX8cvu8Hq?=
 =?us-ascii?Q?iuAuLbuujD1KrIbrVvq9iaOTqDxaHBvFzHYbXLYii5jeeBGH65uuOCvvN8FW?=
 =?us-ascii?Q?QCCxaQFVHA2Ue8mcqfMXoPP/fbRTtTQynzgEs3jOYgqjb1HW13JOKFy/cIZO?=
 =?us-ascii?Q?fqq8HJRtG20AZZ6qrPNH3t/Jc0HgA/wBg6Rt+0tQifDXwfacBa2YBEqjxE4S?=
 =?us-ascii?Q?GVq+Outvh/HYKl+/SmMWCkYzs4ccmOiUHywigEX8T5j4cmPAiQaqTs8PtFxp?=
 =?us-ascii?Q?R3h9+YeXb3kPW8HqnEQjlCMBvT9qKDukWmZkZDsgRqOQimdrdWcxLcXbw0MH?=
 =?us-ascii?Q?obTHoI5NcmU8xCz2fOzFyYepsFeXcl6cXEpTWORQsnOGw0XztNxaHMSebjhm?=
 =?us-ascii?Q?bTKXqIcuZmlOROYRv0YWnTtfEKl608oTthdXfAjEA4OIRHahAULDmkPDtvSm?=
 =?us-ascii?Q?RbaElWb2GH5j2hv2INSFaD/AyeKGzIY=3D?=
X-Exchange-RoutingPolicyChecked: sPtjpxxIAp89bb4PEghL/JLze78+ZOsqyEwhD8on2zwi34TsObtBMPKyvL8XE61eKB14bCcAll6AS8clfU6yupgEtPSIqPLTSbjpIFvJJhyeLTfn66mzEyFzbv00hFy2GZnXXWu3kQdhwszXnDTmbqjDxKq5Q2j4E//lekSH6wdG7HrI9uOQ/8w+KskrUwN8L+WLUqPY4Q3Gfp1OLv/Qxez9T6lacdI/ne9YCQuriTUf0eHeXd/AtCGBOFLET+lI4AKBamYhKfsber8ohXQ1FY6JNN5LRUIjdf4IhyVKCrmOJ89LFAjZSOlVKRmeV5TuoRQrA9EpRseQJRMrhzM13g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb56191-652c-4990-3f0e-08def6da55fd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:24:34.0279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCAf9mCZ/M/NuNOM3GbrX69MKfV1rdtZAzbgOkqaXk1VwPA2vW0wKB0p9YfdxPj9NPlTDnXywyEniqXYRG3tEJsIbM4J2u62HU9vTEAZ0gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5407
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNiBTYWx0ZWRfX0A9OYpaN30WD
 ISIUcMMM0A+WfRKPlwqdw8c5Al6cURHVnSAOIOoOtqane9EmoIuf7ddMwHIRluQiYja7+ioF+sG
 vP/ahMJm8HIc2/uvmwRTMj4kDOnwExkIRlVuyL/JSGXmJbfitxbLKfB1sG7z3wIx2DlIypuV3R0
 8iddDPH3weUK3YzEEMq87bmYSKoSwIGmi04Fmdy0e4V3dMcO/J5WJW8pSM2BEPDd2z8xh1YCCFo
 K51OOcZTBz0tRoMcP6I3/CgOg1HC0RzmBOuBzp/Dq0XBkKiybocKiiO7Ly/TPCbzn7HiseFhFnP
 OL7opV76VAJNQsquq6HqJO8FgFjx8de4vPdDYUCkgzoCBaPKTAzvPuv1T8gr7d8TXiT0x5rlHGs
 +sBJ5K/mTelJsJiRvLv2yQTdsWWiQcbt9gCBo6s8UtSVHb4mmk/anrsxjTnYnFXFAS6OZj1Wg+L
 jybtXwNTLEVoiKwkaRQ==
X-Authority-Analysis: v=2.4 cv=AKMHQk/1 c=1 sm=1 tr=0 ts=6a79c305 cx=c_pps
 a=R4qMYQySjg0trGpnu7oNJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22 a=qhU4LW69RKebtnlfpGgA:9
X-Proofpoint-ORIG-GUID: qhLEBEy8jS9elinSUq8Lx0KCJjO-uP8D
X-Proofpoint-GUID: qhLEBEy8jS9elinSUq8Lx0KCJjO-uP8D
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNiBTYWx0ZWRfXyvp0g+CUZW5I
 Nlsnz11LSTt2MPnl9CqR79FkROakS3BfP1sMuauPXnCGht5W+V+ECexhVgNKGKTsNoiUqE5p3E/
 lEW6YgCWdNuGDD6FmmiqCm4BoVJm3BySb3qHQDNkkfanxd91xglI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100106
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=HXuMG
 aVXPMVUV5XHRtJNVdcD6LsDnA+c77It2FH07e8=; b=whSuxsiYMB9wExvrU6QfS
 LrxRhG9JzFrhmUPMLjq44BwxsCmffSjQieVYkPgyKfxhzHl+Is/RCqYKoePE9gtL
 En6MruSY7rv828bg0KYjdGT+vdsCDSl+oahtZFLWq0g0Z+5jkQ/jVeY5GuUQ50rl
 fT7x546eJrWcZl/cbyICXfxiAZfZeucSuV8PwbxMBOLc52Lg+LMJZjm/uuZZFWSr
 felHdxcD6tPzwSxZQ5qZv8hERXaq8ShwY5nc/H2KgZv6uvjqB1I44ZpzxV20ROgJ
 OarS0a4gUTF2KPg2mbYxybxHPJqtHKiJFgWgx3OIJ0kfNjMh3Carq/tZKV8mLDi0
 A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=whSuxsiY
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hey Greg,

It looks like the old patch series was based against master instead of main.
I have rebased everything on the top of main and resubmitted.

Thanks,

Caleb
