Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B1EC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 18:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22C4D80ECB;
	Fri, 28 Aug 2026 18:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Az5HD1mTZg7N; Fri, 28 Aug 2026 18:19:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787941155;
	bh=42NQgnJo6nTvHQi99pXq1zzXAE+0QPzsejfASOqjPqY=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f72Pj1ZfarDxV+1cGZm8rlWXowqavJxl20glw/bbrAV+JQV2yUiH+RngXtOIq9mrb
	 +fz3WsCR/bFS5TRvDM5h6Ne7zdPvu+bzrNdLw8VQnxvLPxR9YooYsHKeFNp8jjy/Gi
	 lCXtUPNJ8ByXiRlu7m8dr1tlJUQGsySYsHX/CCeU2fblR7jsigCaCLY0Htw5aGU2eN
	 X7KQkiDTe155csJyokkERQDpm/NcIluo5FQo/f7aDr/eFcLjAuUhlSXVa/d3UPLiRL
	 4wBv4d1euzLtJ1NWRPlpgvQw36uOvzxyRNeKzJ6qzNnCjnl1B14STomWGDw6CwpmCK
	 JBP9YRyEc5nrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59FC280ED0;
	Fri, 28 Aug 2026 18:19:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A51A01DE
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9708980ED0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rOTiKWalhkgf for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 18:19:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=pxwFHYJq
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D232480ECB
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovz8gjr+3a3NAsIMG7IyU1OtJaHipV/BfwzjwEOhGlJpM80Jszgn8f3CUN7TVD+Ls5tGEmVJwlNcMJZHdR5bRwEUvUP5FklBQCQi+feZpHcA8hlvldU7f2I9dTx57zfyqg8AdJNCYql0eMvsi5fmuz6i8u4nWvlZKQOW+uQLJPbHf1wbpzP/9KxWK3LFhyuGbALGISxCpQLQJOdUlwWn8hkTEpIKFH3Hqs4CAf+klI7t+z/NUVTHSH3YEmslkWZzC4FffYxDqs1UhZcs0Vzjofn0+W4GEE9QnQ9yh3t5KKneG+/Tn8DnuSf8mYfphlGlxEfw5UHwp5QLf9+hSqu4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42NQgnJo6nTvHQi99pXq1zzXAE+0QPzsejfASOqjPqY=;
 b=SSDR+Bz3vbJANvx+DYfr1iLVPAkIGVGR15YkVkGuCFcTYnVcSfq0eJkzimjs9CODdhy/1kNnd5NABOJY6wGljcMnQ2bFwMKkb3vKqkvln6Aoy4Xfb+RZTce9Q/1nLkzVlF7JDjxkUX5KVlTCCb3Kw4v82Or6EeRcEK8irsmry61l8Y+aGtnvzHPA5FeNCH12G+jSGKfXNC3mxQyEp0A7Aba51btuFcxHNC1BK9t0yQZrhJtztKVPbdyq8ja+laxMU9CQqq8sq2bMAjx+1blnoDgCH2W7ibUnOzPGOakmkmG8vsbS58W6ghyYC8VZvY+VsbgowmS5hQUUByWsfTIiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42NQgnJo6nTvHQi99pXq1zzXAE+0QPzsejfASOqjPqY=;
 b=pxwFHYJqH6gnnopB3E7bW4ndjTzbRHCgOGTEAMRU9yI0qNyOaRMeez6RQUmX4ETpvh/OslRu2aIBOTYAdg7waiK6fyPX0qqeIgWTm1R2QWOQisBbVsdpUcSayToJ68fg1DxdXYjX0lCsdTce0IBS47Qe40oAUXC84PtBlErOPO3PaW6lREgKzChnkhFS2eRPKSyWeHfkKnrSkHQJMfaFAq3sXyidddr30E0vvAtgQVZvVW2eyeJ2+X/Yx5ZFy5sNCWWr2/WaWdFFMMEJnjGrQIQoP0cCIZoX73m6U8C89o/XoTI5dR0M8SlSDs3Nu7MSbGziX4Gc1i5OjEpN++2Ysw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BN8PR03MB5057.namprd03.prod.outlook.com (2603:10b6:408:da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 28 Aug
 2026 18:19:08 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 18:19:07 +0000
Message-ID: <2e9fb2fa-c875-4bd8-8ef8-472459bfe1b1@altera.com>
Date: Fri, 28 Aug 2026 23:48:55 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v1 1/3] mmc: msm_sdhci: fix max-frequency read into
 wrong-sized variable
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 nathbappai@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
 <20260827073325.4113071-2-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260827073325.4113071-2-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0216.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BN8PR03MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b50632-c4ef-4ea1-b28a-08df0530d8a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|55112099003|18002099003|22082099003|11063799006|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: c3JzL7LYiA2/yxIxP0XY2w7+H13uw866Zu14qyIvqMMOpBwGlEJ/bQZTvTFP+nJx9aXmuBNdrkYLwwJszzwuwu5XkJjBzcjslrWXRubaU/L9hl2uMJC0NffK5ou/KFxCZ0cd1v6trYwFSVlBhWGS/KM0oIheRQuBHBno5UGiL3KnatL+J5S0UVYprEnBUSs7QTuYO7mRBP0+698rgLSHpa6RWUSzr4PMBcwXvuhguCzqkswuHmfAdp59LO/kCsGNijCDGh0qX4ECk/TPuj5CQtCLBVWP+TkcfERVmtqTyDiYAg63iGPdUbADbQQhJYIlTZZRP0UJ2rXRdeE5LrnI2XhpDbMbEZsJ9gda42N6+KSjWw8krja3OvbHVafo2g1u+gXe4TBY6qt7qfOHRtK/th97xIwRXlJgI3BE1yd9kwWWaJUe+Xw5lzgRzH1HW+uEWBnYUD6tFYU4PXtEvlxJOX8XurUQng15W6+ZE1YncX5ItEkiwPJlYIbPcwAlNfhq+jRrmx3rddbMcj/0tTk5gMPwxgllcztHqzMgmae27fTbccIkUqFiGx7BmMb444RfzVppaPJbK6YiuBeHpIyvnpMQ+yghHMLsdEmrvxqLjPN4lCk07frf5ljL1Z8NnDM2orJbGByzjcyo3k/PEuRrQI4kzGpLcsZ+C1JM7OSAwQQ9GW9T5vyD290LisJnnjOaUCLVcFj0BVVQ3cUnIWOhSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(55112099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTBPakE3V3hUUk50ZUNCZDlxN3VyMFQ5MHpRd2oyaHlJTWNrcFhsT1FOeldS?=
 =?utf-8?B?SytYVDRZSzFsMDhZUk1PRUdvK2RFL0lwZVJ3SW5OWTEybEFUZmJsN2NOMW5a?=
 =?utf-8?B?aSsxT3lRODhPSVIwZ0Rza0pObFA3NUFvYll6ZittWHFwSHgyZHZ2UVI3Y0Fz?=
 =?utf-8?B?eTFWeUl1TGRkQ25rSGdNVnJoWlFURjBlK0ZGV2s5a3VMRlZyWnJWRFRWY1Nq?=
 =?utf-8?B?Q2EvejZkZnZVU0J3emxQWjRqYytibkZKNXNLOUYrV1gvUnRvSEJOMEpocTdK?=
 =?utf-8?B?eWV3c2xNUFlieExnTHpRUVlqSU5IZDRHVUplTklDa3RkQ3lyMXZIV3lNaWNo?=
 =?utf-8?B?NlBVWUh6MWp4Rlc1VGV0NVhuUmFOc0dDb2Fhd0JwMlJ1dFBNOUswb01reHNy?=
 =?utf-8?B?UW11aVdEM01BcFNUZHM5QmpYRmlhWkxybGNFS2Zua1cvNDRSR1lXVGpOZFRx?=
 =?utf-8?B?cG1TRWJpZ3pTZHM3emtoVG5RNTBuWWhWY2J6VENaZm1kaFg5WFBrdmdoQTNS?=
 =?utf-8?B?TUF1T0psYkdYSEh1LzJSZlZPdW05WXFYWml6QUZHdjd4RkpOdW1iQjdvYXc3?=
 =?utf-8?B?RHNKaWEzSTYxWHFycHlBQXdpUVBxb0xjdjhkNjlzZWlLdDVsTHgyZ1N1ZHI2?=
 =?utf-8?B?WVNqM2QrMWNmYksxei9Cd25jamxWRW1XSy9rd3c5UURPTzZoSjA2ajdvUDRy?=
 =?utf-8?B?U0JKWnNpNVBPajhWZUJ4RmtvK0FsQTYvZ0pPdDFHV0RPOXdHdm1XSFZWWStZ?=
 =?utf-8?B?RnlJcUplb3RDYnF2UUVjd2d5VmxLKzF1eG5GY3R1dm1QRS9BK2JqZHhzNDFo?=
 =?utf-8?B?eEs1SDZJeERRVmpTR0lCM1VYRm9nUlhLUXZMLzVMYkhmQjdVVEUyUWxkZ2U5?=
 =?utf-8?B?LzdxYng3MzNMcWx3TURzOGFMUDVSMm02V2VFZCtpMldGRGZ4QW1JRmtXOXZs?=
 =?utf-8?B?cnNRRHQvTVhWbm1pZTMrd0pVZFhaME81RTRFUnB3TlcvWjBTTHlhMWVjNENr?=
 =?utf-8?B?ZGVPd0o4czlOTVp6Y2t0Q21zWlpUTWI4anAzV2F3dTJEemdzY2k3U2tDVGc5?=
 =?utf-8?B?MDM2SkU5Zm9QV2VMMVpORlRuT2pDVGpLMHhna1kreDFmblZQZWxCbDdGVWNo?=
 =?utf-8?B?YmZ4VFRQVTBBdWZKWmlLZXJJZDBCUFc0RldLL0J3MVpUS2ZSVmxDYjJ2Ti9s?=
 =?utf-8?B?RWhMU3N3NmpGMnFmUzBaK3JiUlVVSWtKbmR6SytRR0dqYkVrNi9kcDdOb0VZ?=
 =?utf-8?B?L1AwWDAxUUQxTytXWTh5RU9YWFlkRWVRdmVhSjc2a2hHNlAwcjRnOGh6Y1lX?=
 =?utf-8?B?Ym80T0R3Y2x1OFdxMk5vaE5SeDE0MlFabi9mZjRJMFFJVjVJSnl3eWRFcGRq?=
 =?utf-8?B?YWMzQTRwQ1pFeGlkc0p1eUZiNW9Ta1RKVHJKajJqdjBCSDNvTFdUZ2VlczJr?=
 =?utf-8?B?OVREOE12NnkxNTVhZ1JTak44Z2JxcTFQUktxWjhteDhrZHBqYWhHQXkyTGFM?=
 =?utf-8?B?dGw0M01XWTM4YkJhZGk2TlZDUzE0UkI2TmQxMDVKR1NFcVpnbkNVRi9vSE5p?=
 =?utf-8?B?SHFJc0VXb0UrSEdWYnc3Ny9MSDdFWVF4dnRkVmx1WGZHYjFjSHVHSTNmeWFh?=
 =?utf-8?B?WGJNZVBEMElaay9tNUU5K2kyM3VBSU5oS201SEsxSkNId3RVTmxCa0tLOWJL?=
 =?utf-8?B?am5taHJFbzBvbG1XL2tIS1NaTnIvOS9UcXF4WStuTUVOK0VQbUtOZUFmUGlr?=
 =?utf-8?B?czJEeXkxVlBaSG1TNFZLWWVPcExoUXZVbHFlVWI5VzgxT252Y0ovVWRaV2Jp?=
 =?utf-8?B?TE5Ua2l3V0RVeGlyN2E1dTF6MjY3N0RTcmIvc1VHWDlsdHpjdnNmblBMSW43?=
 =?utf-8?B?OXA4RlEvWkxDY1k3M2xyM3lEejE1VHpSaXdobjk3M1ZuU3JiSTBOblNsL1Bu?=
 =?utf-8?B?TGsxT3BSVnlPTHFQTFhJTGFXTitRcWpnaHRyVTFCN3p0NGs4amFtTjVaRUlB?=
 =?utf-8?B?Q2hINkR6Mm5qWjV5MVZJcmFBZUZlMGkvRFFPeHFHT3J1NGZGZjdmbitCZjJY?=
 =?utf-8?B?UmJ0Tkd1TzNBVUh5amVFRHh5am5ubDFDSlFDSnFEaS9oRnlSQXhTZnBZRE0x?=
 =?utf-8?B?U2c2SHFNWmYzNGRTMC9yQS9Lc0J4WldlbHJaVkFMSEdFTFhDZXN2Tit0MURG?=
 =?utf-8?B?U1hNVDNDSVc4ZU1vcjAxOW83YXh6RTVpSTJvVHovYS9zQVNzY1R6OWU1MlZP?=
 =?utf-8?B?VWplRmNKb09saUpnaDc3WUZzMGkvaDhwL256Nm1FYTlPUnBJbDFselRTR1lT?=
 =?utf-8?B?NloxTDBrVi9IUE1hQlZZYXhXQ09VdmlURDJVME9hd0wwbThwS2ZmS0pWWDBz?=
 =?utf-8?Q?+7GB5hMsDTU/Eyqo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b50632-c4ef-4ea1-b28a-08df0530d8a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 18:19:07.6029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CyRLcmhHDhKcO1u+OIa836sR1npedMrwO9uQW4Sqriu8pldjPjzlDNpBO+01TI3Y9jgQCDt1A8Gzg5s+cV7IjrjiE2xsx9VO5tWQ3fKGMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5057
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

Hi Aswin,

On 27-08-2026 13:03, Aswin Murugan wrote:
> msm_sdc_clk_init() reads the "max-frequency" DT property with
> dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)), writing
> only 4 bytes into clk_rate, an 8-byte ulong. The upper 4 bytes are
> left uninitialized whenever the property is present. Read into a
> u32 local instead, then assign it to clk_rate.
>
> Signed-off-by: Aswin Murugan<aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/mmc/msm_sdhci.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 7bdb02142a2..cbf565be426 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -65,12 +65,15 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   	struct msm_sdhc *prv = dev_get_priv(dev);
>   	const struct msm_sdhc_variant_info *var_info;
>   	ulong clk_rate;
> +	u32 max_frequency;
>   	int ret, i = 0, n_clks;
>   	const char *clk_name;
>   
>   	var_info = (void *)dev_get_driver_data(dev);
>   
> -	if (dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)))
> +	if (!dev_read_u32(node, "max-frequency", &max_frequency))
> +		clk_rate = max_frequency;
> +	else
>   		clk_rate = 201500000;
The clean implementation would be:
clk_rate = dev_read_u32_default(dev, "max-frequency", 201500000);


