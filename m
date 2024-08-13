Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91186C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 13:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F1E889AE;
	Tue, 13 Aug 2024 15:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="j14t4Oz4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F13889B4; Tue, 13 Aug 2024 15:09:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3721288360
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 15:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0YDThX0Hluj6EDvgjyQqwUYw5YVCAOmwAd3R9CFP9HxJ1nH8InUd4+LiCVkMJf4wmZIK6U+GVnQmy4m3dj2DjR/dyWpHNu+ipkwkG6zf6eq9L7YCZWq1RuXBWK6Q30OJBiF1Yj2H62V8IDSIWIykBuN2/WdnTUWu/mOiSOXUS9DI9HWvi8CTbPH3gu+hw1Hj1uE2ouct2yQOqz+S5HhNEmM0rCdsPzkZAtMAFq2ECyFI8RD19hwesyI4jaHs1hhb2JWU9PGoI/zOLiUjet7VT0YEVGoyKdGOR7xHo0c/jkFzM7ZgqR4kqa4MSIm5ietinvBH0DnNTnoTAlEBT/pEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO/EqIB6OyaqbIS39E4wrybmdxCpAhWZeG0D8B6Y0Ao=;
 b=CQ8XDHsxGGwEWzguE2zT0qBaXb03YDaeRMqF6Z+Sqr3XyiRENNB1VFtpZhG4i6LVhfyHHFXEVRxSStmKtrjfyZsfb3DM4oDgkL6Xwca20WxcYedHrPae/AR1zEDDL8Z6TyX0U9gJJg6Pptgt3Rcauor0tRYMxfoj/dbtI3NL5ajIRJ+ynHmBIJyw/RPrO8jEgMKaVcYzqwBZH/M2fkXeoaNDwbuXzysw5ZPK3WnMHJoKpJWetMDQdrmOsgsCEt1z0ToCqWbuh4NYAX9R8stWbrYJENXtu8ZTRush2fzDbcjJca4hiPB+Au6dDj1TeuUo5NgAhTFEcvykcACkcDRtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO/EqIB6OyaqbIS39E4wrybmdxCpAhWZeG0D8B6Y0Ao=;
 b=j14t4Oz4F+ybPC9wGkL6U94Bzkn/jLnrH9AYHnH7ynYyzC/vDMAgipNjU1xBupQcee42RE6sK3nIfmm4kqf3QOGpJMLrCKAaRVdYIczF7xLASM+DaQABoATwVeb99vXxHAoczZHcNw7LNZ0fR6XKiXSRUAJSyhijH1BVCqsj5ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10141.eurprd04.prod.outlook.com (2603:10a6:102:467::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 13:09:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 13:09:39 +0000
Message-ID: <f90b07be-c4a6-450a-aeda-02df396ec991@cherry.de>
Date: Tue, 13 Aug 2024 15:09:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-7-sjg@chromium.org>
 <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
 <CAFLszTj-szBqxPVi8CiWb2jDnKdcx128C8Xk7XUL0a2QoccWbA@mail.gmail.com>
 <c7483e63-f51d-4b8c-9340-acf75e1f04b8@cherry.de>
 <CAFLszTjjKkJdTE90AYJN1S05xsf3Bso_fDiQN-4UcQuJNR4aYA@mail.gmail.com>
 <6ac92261-8515-4884-8cf6-357e8356bb4b@cherry.de>
 <CAFLszTgZFFv0iZs8GebLhjWtRzrh2=tGZi7KMDsBv=2bYNCq4A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgZFFv0iZs8GebLhjWtRzrh2=tGZi7KMDsBv=2bYNCq4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10141:EE_
X-MS-Office365-Filtering-Correlation-Id: a75d408b-853b-4269-24a3-08dcbb99307b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUtGNVRCclhDbVViUDIzL3h6K2N0WUZaMUNYL2d0amV2Y0NRZUlTK1ozWmI1?=
 =?utf-8?B?SStxeFY2SVpIUHgrOURHZ1FNWWp0SitiR1l1dUExZFo3TkxFbG14MFpWWEtn?=
 =?utf-8?B?NW5VNDMzVHk5cnYxcHhlcS9wdldVZzhJcmtQL0xETDgveWNucVFsNmFQOTRD?=
 =?utf-8?B?NEswVzZpbzRXZk53VVRUZEVkcDhjcy9ZaXVhaEVtd001ZFE4WEVtVDhyNCtz?=
 =?utf-8?B?RUtYM0tTRFZpbFp5Y28wa2V0MVNvei91ZCsxcjVmTHpGZWtaMDNKSkhtMjJw?=
 =?utf-8?B?SThBWjB4LzNzcGY3K0R0RVltL0pYRVo3MnJhODdORWRQMEVPTHdsaWhmdW9R?=
 =?utf-8?B?UkRDcm5kWTMreHBjVmdhUWNVSTBpLy84S0NhMlJQeE9VbXNyYVV5MHNXSmlx?=
 =?utf-8?B?bjJnR0dtcDdtWlJDVkVMZnVJUjRqbURrM0lzdGtETlVwbzdkaVFTdDg2VVdO?=
 =?utf-8?B?UnFuQUVrdzJmcmVWVTFlOG43a2hFaTJlY0Z0aWI2NGI5cEM2OWYxR1ZKc1ZX?=
 =?utf-8?B?OWVkd1psbm1BdHNHd2VDMmpBWXhvNjF2MWc2aVhmZ1FrR0FpZERUVlJUOEFk?=
 =?utf-8?B?elFla0luQ0g3Nm1hVFVkOC9lY0VKNUxHeE1VNFVabkFUSkVlQjgrY1RhcWg3?=
 =?utf-8?B?dDZBU2thTklBTjkxSi9hK2dHdGFBcjdqcGlxMzc5UUhzWXFpQWc5V2E3Mklv?=
 =?utf-8?B?c1JGTVg4dFNCTWJPYnlKeDdlakYxMjZ3ZjBTM1krR3BZNjh0dWZYUmU5VUxU?=
 =?utf-8?B?a3U3S3U4UTZjbDU4NFppcTdEaWlzblRwcHhQeE1CQVhtVFpqWU13VVFkQS9x?=
 =?utf-8?B?VXFiemJ5UVk2Y2J2Y2xGV1BxY1FqVmZXQWk3VXprZitzcExwakhURDBXT2d2?=
 =?utf-8?B?L0pRUjdNUERyaWlGcFBkVlFYMmVlSlQrMXVTdFpkYXkvNnNVSFpWSklJQzRF?=
 =?utf-8?B?SHhjMCtrZStmNHp0SVNPcDFPRHFVMk9ORXljbGlNQldWNDZNOE5mKzNMdjE5?=
 =?utf-8?B?RnN6aGRkM2dURmhDL0hrSmlvd0cxdFlCT3VOblQrTWd0cEppSVRVSUVLYXZR?=
 =?utf-8?B?QXUvRzBjdWlqZWVrQ3I0Y1ZVM1J6bU5qOStWZUhWRTZFZFJjbG9hL1FDdFYy?=
 =?utf-8?B?bnNpZEZpck40cG5HdWNrUnlZeUwxcWpaWko3UytjRDIybXdYQVpRMjBJSXVp?=
 =?utf-8?B?WFFQaGFUcElOc09PRDVKNG9OMzBjWExjNGNmYnJHNFRtTFpRRGd1dEZoNE5z?=
 =?utf-8?B?ZHN5Z0o3RFlDMzFmVEYyZDY5MEdMN1FOWjRha3F2NjZzenlHakxPMGRhSFBK?=
 =?utf-8?B?SFk5emdWWjl4WEwvayt4eEY2UmdJVkVPNnZEUVg1SjBKK1Nub2RQMGdGN0Q0?=
 =?utf-8?B?cksvUXA2amt2UUxDM1ljQmZ2SHFhOXdqOWxrWDNsK09rVzFGd2pjTUNhWDhC?=
 =?utf-8?B?emdwSEFSSnBHNXJLMjdrMlhOenFlTkV1SkRhMy9xc3IwVkdDczhwNlVqQnJN?=
 =?utf-8?B?MGJUc1BuWGVUQlRNS3JtZlF0eGI5Q2o1OUZXOFJZQi9uSFhRMjF3dVZSMTVE?=
 =?utf-8?B?alE4MitpYkkvZU81bkJQOU50WWtLdWhUMGRHdklENWpFbmhQaVhSRm1hNGpi?=
 =?utf-8?B?TVhCSlZBSjR6Q2F6UHJyR3BqL2lYRW54cWZGMmNtNWRObm9PT2wrd0cxUytI?=
 =?utf-8?B?eWdReVFPcFM2NndiMU1WNGdlQWdZalljYmFWdE5nTm1GeTcxOXBGSkIyZlhz?=
 =?utf-8?Q?60oL+NRWal4pSRCTAs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldOWkw4RFZ3WUhoZVRjVElqWEVGbHA2R2dwQ3FGNkxhSFp5akZzZlJzQjdZ?=
 =?utf-8?B?VUE3VzY1aXE1QVA3TjZGYlBCSk1QUjRXSkEzQmxqclhaOXg2TVdPeHlhMjJz?=
 =?utf-8?B?WllrRnpIelFKeHJLTk9xTFNIZkIvVVRMNEdkZW5Lai9lY25MdFJKTXJXaDN0?=
 =?utf-8?B?TUJlVXVRTlBnSDdpQ01kYkUxSzQyT3dZRUVyaWY4Q290cHMybllPUkFPdy9x?=
 =?utf-8?B?aXJYOCtybjA3TFdvOTZoQk9YQlcrcHpGODlVU1JaMUVaN1l3YllWUno2WGJn?=
 =?utf-8?B?M3ZOVUJWdHlBcXMxclVlVWcwcDV2b3ArZndBVkNLSmZIQ3JMVzhseFYyNnZt?=
 =?utf-8?B?c2Jvb2xwYkVYZERWZitVeXg4dFRNOUp5bWJKYVBLUDdUZ0tjVDdDR294d2Np?=
 =?utf-8?B?WVZGakJHTGltUlZGZWlqWVNDV0tnNVFmRHo3T3FtWU16cGUzSGNxUHJxelFY?=
 =?utf-8?B?bFB4bXhIdTRGejMrNTdiV0ozbFN0a0daMHp3djh3TFZuN0Z5eHFpaGx0SStU?=
 =?utf-8?B?cFFKTy85RDk3MVZLempoSGpCcXhCdVlyUi81QXNpRUx5TENpRUM3YzhtZjc3?=
 =?utf-8?B?L2hCK1plY1dXMm5pMzdsRG9LM3NRRFdNUEs2T25HczhCeFkxN21JMk5NTWNm?=
 =?utf-8?B?TmRBRzZOdk5udkJCZllLWTZOcnVlU1d3Zld2cWxWVytnQ2pGVkNXMTZ5T2xh?=
 =?utf-8?B?bWoxVnNlTE1pTnJFblhUNEtyQSszNHZ3eGc5eldZbEtLdEJEYkhuS2l1V05s?=
 =?utf-8?B?UmorTnNaNUIvOStWL3dCTXQ3dHVDekhqZWtyejdQbjJQUG5nSkorWXVvbFI1?=
 =?utf-8?B?Mm1ueHUvakp2ZnVHcU9KVkNBOTgvd2F4aHZMamdPNXBmdzRjOXlINTN6Q3Ny?=
 =?utf-8?B?eHcvY2VBcGlKVG1CZm05L25qU25idzFEaDgvQjNiNU1SZGY4NXlsa1J4TlhY?=
 =?utf-8?B?STdQSFV5SWlySk5xVkhsT1R5L3BGQ2N2bWZhdW81R0JTWUJHaE5QZWlXMXFT?=
 =?utf-8?B?MGZiUTM5dkExZnFYSTFaWVpSUDY5V2pObGlRdUtPQUVwWVh0L29CWWgxSVFz?=
 =?utf-8?B?a1Y0WEMzVDhOTThmZmNNc20yeW14c2Jxb3dJT3Y5bC9qZHppYUFLeXN5d1NG?=
 =?utf-8?B?bHRrcG5LT3ZmS20vcjVRbzBVN3NBRHRsZ3BtSzBsc05zUkdHeUZFTSsrYUFC?=
 =?utf-8?B?T0xxZkpPeG1oc0g3ZnEvNEpXUW9RZG9PTjcvcHFZcG5rRyt3bkVwUGV2ODh1?=
 =?utf-8?B?YnladjNXcmNSNGhIZkdOd0xTY3pNa2JWc0swYlN5TWpzRnJ6MC8vZk5ma3V2?=
 =?utf-8?B?RE5zQ1c5aGpJbEFJWVRUbEpIUnd3aEJHZ0djZ1IzNURWUEppaUtPYkxnVkQ2?=
 =?utf-8?B?WGtoYnRtTjJoV0JKMFhrQmVURFcxRmNqcEVrRHZraGJhVlVaelZRN0l3Q3pR?=
 =?utf-8?B?b09ab1JLU0lpeXlYNkhlOXU0TU8zc0ZDOE1aK3JNTmsxYmFRRTJhR1RzRnFs?=
 =?utf-8?B?a01pbGVQN0tNVjBFSXY0Z0gxVVAydWhLWGJmUmlkZ3dVZ2VWSVpFMkNnOVc4?=
 =?utf-8?B?RXpwWTVIUGlWY29ONXpMOGRLTHJ5T25yb0VxQUpOejBDRk9QdmtwY2l0dUJ2?=
 =?utf-8?B?NnJYc1E2WWdJNGRCZTRCb0w5UWgyOTVrZFBaOEU4bmlWRUNwT1Yvb2VYSldD?=
 =?utf-8?B?aWY3OWFjV1RxQkpzOEptUi9xUklvaXJFdG5FVFdiWGFuZDlITjkxTXJUekpZ?=
 =?utf-8?B?MVZtSTVjMU0yK0RzTnFJWFhXZ0J0WXI2UzRQUS9ObEZwNWF1M2lNdVVWNUZt?=
 =?utf-8?B?M2RwOGl6bEdMNDRrWnMzV2w5WFZYNzFXaC9JTnBPdnhtRFZYeVR4emhEVVJQ?=
 =?utf-8?B?cGpTOHc0ZXJ2MVBsTkZHTU9vU1JIZkxhL0xpNElocTI4QWZYcFZGa2Nhb3dR?=
 =?utf-8?B?THM4WHdDc0ZONXZHK3ZOWW80Y2p5akpGMTNzQUh3MVorK3RPRDdjUWhjeS83?=
 =?utf-8?B?a0F1aVNEMzFMcFhVaXQyUTcwUnFTMDFEKzNMSVFPNGVvYnpESDVPSGZOMGdo?=
 =?utf-8?B?N0hsbFVneEIycmd3SWNEVWpkWURIS0RrNEpuVEF6cnNIVmxDa2NZaTRteHZr?=
 =?utf-8?B?S0RjODJiM20wSTY2NldBMkNyL1ZieUM3ZmM4Mjc2NHhrT3lEVStDYkNrcGta?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a75d408b-853b-4269-24a3-08dcbb99307b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 13:09:39.8718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx8OqyfAR7Sqx0ps6gnXcjpFzN9pgLjEBk6ruXfHj4JbB6pwAqyfraODMSlLiW1WYPyAZ+hLHXEVte8GoVHfBk3sXGuyJr4+i5bWy5ClfOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10141
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

Hi Simon,

On 8/13/24 3:02 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Tue, 13 Aug 2024 at 06:29, Quentin Schulz <quentin.schulz@cherry.de>
> wrote:
>>
>> Hi Simon,
>>
>> On 8/13/24 2:16 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Mon, 12 Aug 2024 at 02:58, Quentin Schulz <quentin.schulz@cherry.de>
> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 8/11/24 4:50 PM, Simon Glass wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> On Tue, 6 Aug 2024 at 08:10, Quentin Schulz <quentin.schulz@cherry.de>
> wrote:
>>>>>>
>>>>>> Hi Simon,
>>>>>>
>>>>>> On 7/21/24 5:25 PM, Simon Glass wrote:
>>>>>>> Use the log subsystem instead of dev, to avoid including function
> names
>>>>>>> in the code.
>>>>>>>
>>>>>>> The CONFIG_LOGF_FUNC option can be used to enable the function name.
>>>>>>>
>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
>>>>>>> ---
>>>>>>>
>>>>>>> (no changes since v1)
>>>>>>>
>>>>>>>      drivers/mmc/mmc.c | 49
> ++++++++++++++++++++++++-----------------------
>>>>>>>      1 file changed, 25 insertions(+), 24 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>>>>>> index b18dc331f78..b0105afe5d6 100644
>>>>>>> --- a/drivers/mmc/mmc.c
>>>>>>> +++ b/drivers/mmc/mmc.c
>>>>>>> @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int
> timeout_ms)
>>>>>>>
>>>>>>>                  if (status & MMC_STATUS_MASK) {
>>>>>>>      #if !defined(CONFIG_SPL_BUILD) ||
> defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
>>>>>>> -                     pr_err("Status Error: 0x%08x\n", status);
>>>>>>> +                     log_err("Status Error: %08x\n", status);
>>>>>>
>>>>>> Please don't remove the 0x prefix (will not comment on other patches
> in
>>>>>> this series if it happens again, please check :) ).
>>>>>
>>>>> OK...hex is the default though.
>>>>>
>>>>
>>>> Can you please clarify what you meant by "it's the default though"?
>>>
>>> U-Boot uses hex by default, so anything printed out or entered is
>>> normally in hex. There are a few exceptions, not all of them correct.
>>
>> Gotcha. This actually has been painful to me and I've made the mistake a
>> few times already, e.g. writing 256 blocks instead of 100 (100 aka 0x100
>> instead of base10 100). Are you aware whether this is made explicit in
>> the docs somewhere? So I could refer to it if I ever need to explain
> stuff?
> 
> I believe it was in the old Denx manual. I found it in a Digi one [2]:
> 
> Numbers used by U-Boot are always considered to be in hexadecimal format.
>> For example, U-Boot
>> understands number 30100000 as 0x30100000.
> 
> 
> Perhaps we should add something like that to doc/usage?
> 

Should have grepped in doc/ myself before asking others to do so for me :)

https://docs.u-boot.org/en/latest/usage/cmdline.html#representing-numbers 
documents this.

I would guess this is "good enough"? If not, not sure how to make this 
better? Hopefully, the commands that do not interpret as hex any string 
missing the 0x prefix have their help text specify this!

Cheers,
Quentin
