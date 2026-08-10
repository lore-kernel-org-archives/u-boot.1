Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A3C5AE5D
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 12:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD0D3606F3;
	Mon, 10 Aug 2026 12:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yp6K5sDomdBO; Mon, 10 Aug 2026 12:22:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00367606E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786364524;
	bh=uFLUj5y2q8bZSaP99o8+P3sZjQQhgsvWARh9/b8RhLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nv7aShUeQk5rFbowX7OsAzEsryLI5Ijf/Vj8NHrBuqNouVOoStlHhTCY5PF+WN1O7
	 fdEeAgCFqsKhp5sM37jGugBbtZRQVPljtsjr9TivG/e97XR41w/fRLfeekKvpyEcmH
	 AdCDlO+x9C2nPdLNXHe/vJU2LrfQ4DhLFEr8GIyuhDUnSaCg/RqnATbrVcB7yKNXjP
	 dgc/wQMSvf100WwHz2naV10RhyTaQqpcBX2wUOQc4Z37tNtIRDiF+PmMGq8pEe2S4o
	 KJfemmfbEUNbJF7zUfZHT/bEWxqRuHKtkpIrgfrelX0lVqfIa6JwRb0jxiYsZGWns+
	 jQo4U5GXF4GUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00367606E8;
	Mon, 10 Aug 2026 12:22:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04339296
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEDCB606E5
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dw8GbXSoW0Z9 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 12:22:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BBFEC606E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBFEC606E8
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBFEC606E8
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:21:59 +0000 (UTC)
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A9TT6X3080646; Mon, 10 Aug 2026 08:21:57 -0400
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxn2jbba7-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 08:21:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LahdhPvk7W0vvocRDZY2udmzuR+WV42tLpzucViT56sHr67a5E/8XgxZ6aO/acZrpJ853qhjRNagbZ9/8zyBGvRgxtIWdCjSpRWuA4EiLtdJ94hGTgEsF1nL/SwniYFztF1LgfhJb+2T7gUufuZqKGKpKrpl5rck4PhU33CeAcgPKhA0TgMcdRXBbnvDQrWFjBQzJAMiIEWOKv4h2SbU2lzGklE+ngnRU+f1d1o54+mEM7xmN+qqQUvzYk46NOB+HybrSxefm21LIAw3KeU7yyaJ/4gGhiXG2vXc03Wk+R4WksLrf+nfDufyJJ9t008+xcDMorgj/iVxSsDw0fqqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFLUj5y2q8bZSaP99o8+P3sZjQQhgsvWARh9/b8RhLg=;
 b=SX/s8l2emPiY3cPq1GtKMaMGfJEDWzcQvFQCiugkb8vB2zK8Z3TaBEca2oQvX5EzCYi00o/ZTTqVxZX9OgRoxU76fptA7gsnEaZXuo0wvzp0koUn6WfSzateizHglXxCHc7EvqbGip2Kb9vvmBFLuTK9iaNuzScSUF0zeyYtIVUoeZXN/NCLvhTY+Mhi5PlKeW+hb4FzVphPG8qg9UCUgTZ840bR8FtPeqLwjIZR2/l8kYe5nQh3eSRr2YhHnj37BgFqf/FDGnRuo/z5hIurqRLAgA0PEYrVs+IAlysMkoqstvulq0Xmt4i+MX/L2NrLGaw4zjnZwn/oI1uDdDtQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by LV3PR03MB7521.namprd03.prod.outlook.com
 (2603:10b6:408:19f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:21:53 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:21:53 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND PATCH 1/2] configs: adi: sc598: disable CONFIG_EFI_LOADER
Date: Mon, 10 Aug 2026 08:21:37 -0400
Message-ID: <4b25f5108d57a7954a2286bb2c012f0e32e6e71e.1786363875.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786363875.git.caleb.ethridge@analog.com>
References: <cover.1786363875.git.caleb.ethridge@analog.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::8) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|LV3PR03MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 470c6820-1408-449b-58f3-08def6d9f66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: tFWUY2+yu54E97KcNyM2ziteGaGwfgs52qeBPvR+5tefsR4qYaesPdK0dNs+GcwE6T5c/83/Z1fPZuJRckwN19pTCiTUx9+lLT4Oi2EswSVUWOXiehmX4saSJSEKeThndlb+rYfh1WT96nMHQijT4DS8HBWPZbq8ArE/HwsGK9IDFJV9h3wLFm8WNgab+geu4YELYPqGTeykBx0dqWiaGbfB++VC9/FDaeJul9UpuodUtdlZlNSI02lLbNAYEMPjJJ3ZdbkYwM6mjaIkaBCs/QgKjlCzWlB2xAIRl/zgFf7DdHcfDmhoP6axDa1zLLZkd8yRSEZAwoRmLCa1EyOv4HuR8xK3QuoUI88y78MEXmNspRqaWsmJfjh0/lr/bBo3Cr8/TUSjjxScziqxxdY5Yoj9vURigZfxQhzteRywveNv2uAun+PSeA2tteRnXmsgSGUpNA2zUccLM1BJiYQO9ARKC8ShClM4pQyygynzVBDKaZKZSVOvXYENzYOqAlYfEAzClq5/JWgxF/sZWMSgkPZ/7tBY+5MAI+ejMjGH9zE7Bz+ZZzC62oQOZnTLHDVrAy7hRFIWunEXX7aZfqApY1WCX8pXSHOdWCjrCwdKGSrX92HI4B4wS9lFgbF8Pz1onizbgp8NuAFZsiOzS33c/PQRFawLqlc21Tc33z+NbQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FL5zfESCy7eYgKq8uHT6lmcQHNKf+qmDdddo5OO8uJO56IiHUrj9fJeEekIN?=
 =?us-ascii?Q?MXZcATEIpsqUqf/ljmq8mg75u7HAACws7sRNHfAMds6Oqqn28Byoc9cO4wGz?=
 =?us-ascii?Q?KuLtrNnmW/EyAJlhU1WMLFtnnTEHaxyGEm8nzC3mmfhIz8HQm1rFvTFtBbfQ?=
 =?us-ascii?Q?n5Efgy/sZXF7EmghsBWzVJYjcLvLLnH5Z16Y9mQwBXW3DlswLSleAmSQewGQ?=
 =?us-ascii?Q?kCEj8J2wPxxTOSGPsRGyFC9IcyZUPrqxPJN6CMjKAHV+DWg+EeCO2fH0JHHN?=
 =?us-ascii?Q?RcNKrYNcMgFmPZ3+WHctI67kMr4fzpqlWmNOq3RO1CDzguB2Rzp13U7Jq7iR?=
 =?us-ascii?Q?YCY/LjxsvJrsIxc5u4f4fDkDx6ePubfOsRLRxYwN6oTwDegTJEUse58lhFSq?=
 =?us-ascii?Q?b4AJeswYu/Purl/2uVwbUezwGPn+D3j9Lu7x0tqZ42pD7mqXczJoy8BUm6n+?=
 =?us-ascii?Q?WlEIXdoJ3NUhQyrDx2+kZ58POusnfxvXP64mnYtrg166T0B5s21FKVnG3XFs?=
 =?us-ascii?Q?PYleJ6Ccu7ifPfhLa+KiZ8VaOiScf4EM0pWqmad5LalJngwuaqWFyulQt/ab?=
 =?us-ascii?Q?B2VnrMC6rsKqAD+ut+adOHbV2hohN5aGwuseX7KENznDuUcpdR78J6e2Yl5g?=
 =?us-ascii?Q?unUvzDdQWBJif7qQ+OX6/EiRpGzqbb/urh2Va3daNppx7r1ko3vRCCA1SEiA?=
 =?us-ascii?Q?YCAILFXYj3w0b1m5y/L4MvbOUp8R7jIn+QmN9x06uYkiP3tCVtkzeH05Hquu?=
 =?us-ascii?Q?FClFKLLaOBhI7D+iZJp2UEo74Q2+lxfgYX3N79+7G+fSX8oN6akzsHukLiiZ?=
 =?us-ascii?Q?V2TKzBGJorqnAaaSUVsfXEN1wMMxxqRPaHgaW4dPKWknjAgtELznkS7vhPGT?=
 =?us-ascii?Q?2Ll+ruMr3rNhsJ/MWGSaagey07afuZBNu5WDeYSF+0/SeuBzHp+VnhElnBP9?=
 =?us-ascii?Q?WCbT6ApyOOfN2xnZYRzeWFSPvhHb88hCF67WW+m0vv305FMHHFN7xuaiiZUj?=
 =?us-ascii?Q?FAr14M7RlQTgh3TErfpqBEEt1SbQ2aBYKh09p611d70H+2S/w6ebbYIwO6fv?=
 =?us-ascii?Q?2eqLV6S5VffUmfXNJPxFqI6VOk/eKEnMtqLYc7XXI2u5kyj7dDCF0jjqnW8L?=
 =?us-ascii?Q?xlxo8N3K2tdy1sDoUTJGIoMmPvT34LTUyLDOxx3NxQayybooozvRFSNamRvu?=
 =?us-ascii?Q?ZJe2NXfdedSJ5wg4jSeFpVViI1iaJ64QSRzPtaBJ5/IUGYJHWdcnysK5owPF?=
 =?us-ascii?Q?Ta3YoDFKPSvVTqnfBEpigUiTCgKewgD1wOJhTVgbc+V4hszMO7dKW40fo0cr?=
 =?us-ascii?Q?kHoo109/RTfhFHiNOmVg17Tj4fpPa51HIV3WGazNV77j/OxANjMgOLuoqlNs?=
 =?us-ascii?Q?9gIPfAK+yC7wSSPDEYYH0ZjSTeCNfLf3haNLLo4rMxyVXbuPQYs9Ip+8O2RN?=
 =?us-ascii?Q?Q4BvK/YZRUNOzLp9zq2tPA6lbHkA1ZbgA5VmtzWTP+cZ6bQ10sSEGqfGVNZx?=
 =?us-ascii?Q?sxbxVDISSf2QlBJpQtWNGh6rqYUOD9H2ICvPxYFjDJr/zxkTFabwwPCoS6Yw?=
 =?us-ascii?Q?YKgAdODGFNnHp5Gmt86ZNAVb7Yg3TpLeaYydgJJx4WhoAlq449yCQJ4NI+XP?=
 =?us-ascii?Q?Ij8hsX+9M1xxJ/NLNGGw0TX/jvIZPdw9+H3gTWkikideNmWuMWMbi4c0RY1S?=
 =?us-ascii?Q?MkOjKMP+iNm8ChrrGHANzX0iIcffrFULEJywFjAoC0oOXbYy+2+bN1hBTSTz?=
 =?us-ascii?Q?Lk+Bcrl5ujqrpiNipH73c+H5fsPNFjI=3D?=
X-Exchange-RoutingPolicyChecked: UyhUzU06hGuKR0HGVVj5rG+ii4M1kR4skKoNLR2O85zwMDUXbjTKzTAM+Yauy2Nb892ityVZa69SkE0ZR9Bi6yN9cSYyz73tS+G/mDNSbSG2DfbLuIHOnRk8HGJ4yZ10oTNN0K2WG1k6M6WSv/mQtOCl/u+DfkTS7EVxyoxXHqUZocuFhF01KGowD1QTnR2+Q712JKHc+8gaf4RrQPZ3RLXlH/pcrj2G2F8kWbN9csfuh/WGKc/TUfohmovE/M5TQ80wHtJ5ELErnQKrhdUY4Y5eIRAXiMfp4ugAlVdB+2+GEbjezsPjKXaMINRc3Yc7WC6Q2iOo0dNDvMm2TyNTGg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470c6820-1408-449b-58f3-08def6d9f66e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:21:53.6512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhgiShZfI6q/PWJTyUlG6XPULTR7XDCeOBM4RbfZOmksueCbRgk+SF4gy13LWDBedElkWKQdcBu+Tm9crl+hcFI9Viy7fDNqQELll+LIahM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7521
X-Proofpoint-ORIG-GUID: rCuo5wpI7VOsQm3CyJbtnw1W99MUljJ2
X-Authority-Analysis: v=2.4 cv=SJ1ykuvH c=1 sm=1 tr=0 ts=6a79c265 cx=c_pps
 a=ojhc/3A0J58/V7uwnPnIuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=gAnH3GRIAAAA:8
 a=PHwNFRM_nU-O8OdgQzEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNSBTYWx0ZWRfX6Tq3goEaFS0s
 ocBXt3u4J/gUFztQagH3UMviYREUJpvnapQOlLehe0sJr6mo5zb7BhEZ4YBYm6D1tiqpunR4DgQ
 OP3jLn2D5UQxR0nbGszx6uSWbVgLMf24EyWjEuF5k/G6TPNm8MKbuI50mLsgb2wZGTAvcItlSgp
 EYq95zl/KY7ww/qXWzs1BJmOVB7YosM8hEuRj/+f6li+Fbee8kQfz79eK+ip6DHW4BHLZHFB0b7
 YdJqkfaBVgpIdIn+sYWIypQ2aXR87YAatUjmLeC210uBHKQ7K+7jCjAzrIg0MbloiszM5xnktH8
 ZmcMYUk2yJistTyeO2thahKL1jJIdpQysRZ65esLhe8mpY7l6IIQy0HXgyP71pwBv5NMzLG/YZE
 F/n5F1ri3YhE16YRISkl31CzZhvQ94Qu9Dken7zWELaQapVYGtv+k/g6X6QX9aewPYHBZGK+SLd
 uqEhkuj0mbcX+L2E/zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNSBTYWx0ZWRfX80314OVGsvTw
 PVRXSe1XGEPF/oumARzZ+MSreujYADhd9nOi4DVC34F6xBFcjGzTcY9EFF+FLIpknmmSEbBmmuk
 ZayPSJIPu9KahpFQZl6bYdoci2cBstzeQYiJgxWGuIM2BNTW1tRg
X-Proofpoint-GUID: rCuo5wpI7VOsQm3CyJbtnw1W99MUljJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100105
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=uFLUj
 5y2q8bZSaP99o8+P3sZjQQhgsvWARh9/b8RhLg=; b=iCcBNZNApAuRSB3AvT+6T
 kdk1CvXFXpmPa+W7zjy1bjdlw8nQ0sZbXoF011+W/cY1J3D4u2adO0sdND2KzZIA
 DiQb+Gxm5nF1VhgSgrHsurZjv4Q5N+ZXF2Fq+V/ss66Zp1/Xt9XoDrRUurpSnMop
 2gX/xu97vWKtwk0suv5ztx1CH3uRdbgzMY3RRuB3Hgkc0d4Uuo4wdgstO0KwRPrO
 ytCWi2VgyzCqf+u6pKIq9m7rLVGj0kvJKW+al+j8R4T/dTbj25NMixj2eNHZCrUF
 UIM6A6p56ZSMmPlHrCrKN8Hi2rckd+5vrG5izkdXYQNJbvXTgrGSsYMuabh5AfA1
 Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=iCcBNZNA
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The SC598 boards do not use UEFI support, so CONFIG_EFI_LOADER brings in
unused code. Disable CONFIG_EFI_LOADER for the sc598-som-ezkit and
sc598-som-ezlite defconfigs.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc598-som-ezkit-spl_defconfig  | 2 +-
 configs/sc598-som-ezlite-spl_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index e2fee0d0be8..e9a80d11069 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -30,6 +30,7 @@ CONFIG_CDU0_CLKO10=5
 CONFIG_CDU0_CLKO12=1
 CONFIG_CDU0_CLKO13=3
 CONFIG_CDU0_CLKO14=3
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
@@ -107,4 +108,3 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
-# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 9afe5c0789a..e2af0c66be8 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -30,6 +30,7 @@ CONFIG_CDU0_CLKO10=5
 CONFIG_CDU0_CLKO12=1
 CONFIG_CDU0_CLKO13=3
 CONFIG_CDU0_CLKO14=3
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
@@ -105,4 +106,3 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
-# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.0

