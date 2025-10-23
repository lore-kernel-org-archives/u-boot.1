Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0E4CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 09:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ADAA82E34;
	Thu, 23 Oct 2025 11:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="p4ziDOi/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFFB832BC; Thu, 23 Oct 2025 11:36:44 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C980807C0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 11:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBqcm8sBQz9+h1smH7qiizPC5Qtv9BRVzcI3h2g5hVdS6d341eJUUUcwC35tckEkULbQqnHSOQYX8HUNnfvzkFQ3k8mZi8aW0kFeeZaoaafN4ESiMKzhAVxx5peWS6t9TqIn/740aRwg7yzvYoNVyqOU45h58LjnrdRL/e5ESeOp3GTK1D5yFdwFvBCWsJLBZnrvWeTcPM47WDHtnFIFGCpzmRxyDE2r1FayKkKYptGLcTiS75BPqbEJabJdFNrBOyCwBdxN0Hw+oJWik5Yp9pOonniIhefq1TuIE4Uf+pCTj/zh76zW6AuqKIe5I8je1/QD13Khr27S7Oksu18NJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueE9KLZWO+gaZ8oTrc/zBrCnzbTC0UqmZlL8dKAyHks=;
 b=cQMXJEhmnadRqSt2qWcz1AvAgo4MuBOQuqYqti+NA07fN/zbk4R+u6g0gPTGm6whYJB0GfO9wah7aiWTAFZQn4d2gygHHtk9GmXYTsjlnMALYJEathsh8c1k5+wmjxtGwNA1XWaaC0rYnmE3BCTKIaf98SNceFfkh7NLWliXSmTXrDBxZIr9nF++othspEtkm9htLbDqmNqY9vV8LnxJGCW8W2ZZHsn7vfIpeIJ/cwifyZ75O9Zf5e5zi4/Rg5KGvs0x5om21XgAN3Nl22JwQzpz5PwbNXOq1O6tZxN9OUCEjyCW1Am0IQT/czHOjy1osZJcfKI4yQpsg4JahPu00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueE9KLZWO+gaZ8oTrc/zBrCnzbTC0UqmZlL8dKAyHks=;
 b=p4ziDOi/125UbI1rE61RXWgPannzCC7vrnwiQdoFV52+lg1Fo6dj31RaYsswo6dkLhXwJbnO/etKINBG2E/ieQim2NLsw8TjsSvH78DNcnHhM3uu+4MOKtCU5zWtVNTwkt1ghHU4ebmkQJqZP8M7Vrh1dAB4fjBRSYXOuBtL4ptKTHPkvVfgcNZ3ldwdqWtucnCX81ea3kM8z0OX0TBYZ0ugjYmPPPlkAapvYHITFZB5zHTXDCBWu7PQdmsuxwT4kYZ8BfMJbFpntWswpDa9ye1yde8+d1LPDaxN6Dh1L2y4oujiLzvws3AVx8IY3RRfA8hp9+/wmcGaXqJRxyFJsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB7050.namprd03.prod.outlook.com (2603:10b6:a03:4d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:36:39 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 09:36:39 +0000
Message-ID: <f467e4ae-5113-4cb6-bbf0-a1c8a0ba4d77@altera.com>
Date: Thu, 23 Oct 2025 15:06:31 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: kauschluss@disroot.org, peng.fan@oss.nxp.com
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 7/9] mmc: exynos_dw_mmc: add support for MMC HS200 and
 HS400 modes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0181.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::8) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 18306595-317a-45b7-0d37-08de1217aa37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWd6L3p5ZTNHb3g1eDRsK2xCU090b1YyLzJPVXphcTFSZlZOR3QvQmFvUlAw?=
 =?utf-8?B?S09pSWpXakRNMk9SODRyU0NqQ3Axd01SYk5YMjlaN1Q3UmU0NURvMWZzZllx?=
 =?utf-8?B?ZmJ6MHZZSUp1eU9QU0Q5YmJKTEtnbE9JcnJIR1JXc2plY1BJR0lJRU5JOFNY?=
 =?utf-8?B?MnJaeUhKSFZQUjdmdWg3aWxucnVmYURTc241bU1CQnhtampRZC9IeEJteWNn?=
 =?utf-8?B?REpuR043dGhsanI3ZENwUEdwOFB1RTVKODEvQkdNUU1HV1pnUm8zdzU2SU1D?=
 =?utf-8?B?dkVNdFVnZVRmNzN5QmVRNTRHbUcvd1J5YXUyVStKQTVteWJqT0RyTTdHUUNH?=
 =?utf-8?B?bGxaOGF1cCthN3EzeW9rOG80ZlhEMUhhZFZpeGdZS1dvcGZVT0xtMVdWNzNt?=
 =?utf-8?B?a3o4VXBub1lNSmpSRE1WWUpCMVAzSm43N1RYVUN2cy90eGI1M0tCUjlXdUg0?=
 =?utf-8?B?VUZybG42dGZYdEZKOFh4U3JjM2Y3bXlBckVZK2Q3TDdaWVBSOC83K1ZnM0Ra?=
 =?utf-8?B?dStBeFluN2RCeGhHZmpjS3JnREpsUFM4djdkaVA0QUZoSEk2bzBZeWk1a3Jq?=
 =?utf-8?B?RnBCVVM0Y29mRzZ2YURpT0tZajRBMDVNbFplWEY0MW5NaEg1TlU2QlB3SHZB?=
 =?utf-8?B?RHl5dnpJalRFeG9GT1JQSXorYnptNHBZVDRWUlNwUWxvbVhSTkorZVY3MjIw?=
 =?utf-8?B?MG9tR2dHTktVeC8xeDloQW52dlVYU2JUR1ZXLzZVcGRmaFVOa1FaR0c1S3hT?=
 =?utf-8?B?a05uTzFNQkYyZFg4L1ZGL3cyZGRSNk1QK25xOU1OZWc2QTFtMWsxUjRjbEZ3?=
 =?utf-8?B?ZE9WSWx4NVhvU3NYSG9uSFl5QmdiUTYrb2VYOEpsNEhCbldmNEJURzNFcWdD?=
 =?utf-8?B?bXoxaFVqNmJEaDFHREhyZzlKZDVsVXFibUR2MWRQWG15ck1GL3FVM2Z4eE9C?=
 =?utf-8?B?OWphTlNkMkVGclUzTHJGS1Zlby9Gc05GMkVhNVlrUkoyRUQ3S0M2UzV5MXc2?=
 =?utf-8?B?ZWsycm9zV1BFUHY4WHpxYk9kd3RwSU9xMWU3QklXbVNUdXU4T2pNTVRPdlFY?=
 =?utf-8?B?dGFMaCt1aDNhR3hLOXNuaklwL3crdDhVaFEyRjRnNHFFOEFWRSsreHRlVG92?=
 =?utf-8?B?NUNkZ2NLMlp1blU2dnBxYzhTTlpFMURHRjA1bCt0TklXVE82VW96dExNeDBM?=
 =?utf-8?B?alNWZXNDbkVvWHBTODJLdThDZ29DVmowS3pod1dBZzFJRUVoRmE0UnNWb0ZJ?=
 =?utf-8?B?bDdodUk2NVQ0MlNTMDB4U3pJN3pWRllFcXpNa2MzVmJhTFNXNnVPenI3ZlVv?=
 =?utf-8?B?emtIVmFkSXM4L211QS9HZ21odENXQXBZRkpGVldQRE1HOGhpYjdFTnA1UDJP?=
 =?utf-8?B?TWpyNThxY2x2OFpEQlo0ZDdORWVrNVp1SmhGQjR2YmprMlRza3JDWWk3SUQ1?=
 =?utf-8?B?eHNITFhUTjNHeFgrYlAxdXk5OTIxcTBCVFVsSno0VGk5eHYwazRJTXBmODZv?=
 =?utf-8?B?ZzJlb3RmMTNGSTVPVElNeVJhR0EwNlRLYVZRRDArSlFTcEE2TUN2Qm5pNXBS?=
 =?utf-8?B?SS9Vc0J3bnV2cGNxd29EMGZ4NlQvSnBkYTB4Yk83eEhkZHljVSs4N1cxOFdp?=
 =?utf-8?B?TmFmMjdJdlNtM1pmQkc1TTZRY3J5ZW9KcE9LTDBCUkkvbTVwMTFNdFZZdWQz?=
 =?utf-8?B?azI0S2thU3BoKzVvWmtZVk1LUWx3OTU0MmtHMnVKSVI1dklvdU02SU1DOFVu?=
 =?utf-8?B?c1RrYTRXNTdRWThOb281c0gxSHU4OG5QNlFCbjlFbmh3dVQzVUNxbDg5Wm41?=
 =?utf-8?B?NE5aRG85QjNuMXFYbmZoT20yUWk3MFVHU1VXZjFxTVBJN1cvcE12dUg2Szk5?=
 =?utf-8?B?U3JJaXdKaitTQWx1YkVRdkorK3RCRURQcTNZVWx4cDNvS2toU0VJdDA5dkxr?=
 =?utf-8?Q?6k6ENu89W4xUoqLKOR5OrcGWLDOXutno?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGppOXkwRWRqT3FIby8xZEI5NythV3hlcUIzcjEyRlVSNHpISnVqQXRkYlZ0?=
 =?utf-8?B?Qjh4aHpUeHorL0k4ckJha0xTdnZFditrWW1Tc0dYVWtldlBGQXNicWc5MXhC?=
 =?utf-8?B?Q2JDVTA5eTlQSUNlZ2JDNDRyTEV4SUl0SUxuUnFpZ0FFRjB4OXJ5L1d4dGRZ?=
 =?utf-8?B?bjU5aGxRcnFjTXhPWDhmL1RaaGh1anF0Q0NZbzJhNUVwbVBGQjR4ZFF2MnBj?=
 =?utf-8?B?OFhncldtSHZsZ081VFRMcnNFU2V4TW1JUkRLaExmTnh6SWRWczNFdVVSUW5x?=
 =?utf-8?B?Nk5nZTBhWEg1c3ozOXhLUHplWXVnZ1lFdHdGVkgvMUNyT2FNQk90WTE0ZWR0?=
 =?utf-8?B?SVR0KzZlaktnUVdSeXg4RlA3dTZobTgxWXpISVliYjdJQ1k1elEydUMzeHh5?=
 =?utf-8?B?eE5YVnN6aUFtUndZbnMzVWpFcHg0L3lvdDZ2SU0weG5TK0ZXWU5ISmVwbXgy?=
 =?utf-8?B?VjhNa08xNytoU3BLUHF4THpYRTY2bEZIcENQb0duUlNyR05VVWdqSnpFd0Y0?=
 =?utf-8?B?SWNTWlA5UXd1L2ZuT2FOQ3pyaHk4dlgzcEEvT2VmcmMyNmt4OHJuNUVxanNZ?=
 =?utf-8?B?akNtOEtueWxDY0g0bERZRTNYUmpaK3NsR2FhYk1pc1RFaFJCZ3VGM2VhYWs2?=
 =?utf-8?B?OFZ2aTFXQkJ0NE41dThLak4yNjdGWjAzamNkNDlocmVOWWR6OUNJSnJjUFlz?=
 =?utf-8?B?S1d6UTRZNWFBeHJXaENhYm1YSkJQSFpOcnVEVyszelFlOTN0SmtHeDVzS0V1?=
 =?utf-8?B?T0JCQnIxbDI2eGZDVFp4YXd1cjMxV2hMYkJsckh0ZWFlOWU0R2R5bGt6ZXhp?=
 =?utf-8?B?N3A2TzU1VWE0Y1ptMkJHTWdob1pWNXZzMngrOGMzd1hQTDUwcnlmaHBGVVZG?=
 =?utf-8?B?WVBKOC9QQjgvdE1nK2FmSFN0Nm1WU2QwTVZSMVNOT1p1MGtFYTZ6cTM5bk14?=
 =?utf-8?B?WVRrejI3M0FraEdNSmlDcit6eVZzSko0dkRiWmpPWWVZS0tuc0pUUDVHbWN6?=
 =?utf-8?B?UEd4QVZ5WWVTSG5TTEIyeUlZdVladisxN2JFbDI1Uk5UcS90WThvbDRPakVh?=
 =?utf-8?B?TVhPNEpIZUU5N01CbHdKVjFzZUpSUGNmaVhUTXZUL2UrMGYrcEt1Rjg5REY1?=
 =?utf-8?B?NkxpSkJycU9BOHlpVFVlMzFCYk1PeXhUdGtUY05mOWxFMUN4SWltdFdwN04r?=
 =?utf-8?B?ZTFUMlVKbHdldW53d1FtTVF0NFd3SjA0cHVzQWNWUGY1ckRrU3FjMEhMQlda?=
 =?utf-8?B?eWhsd3l3c2l5c3NXN3RQVEd0eHkvL2Iyek9kZ2dRWFFTbXN6TWdsNHQ0UzhE?=
 =?utf-8?B?dlZMTk5OSkVxY0xnWXdrYTJkRlFUcFRjN1BzRTBxQnZORHdvdFhjR3FoMnZ0?=
 =?utf-8?B?a1dydk94M2pZZHY3SGlpcEg3SFlZUndFVFRSTHhsbEtpQXBBZ1FOQnZUdTd3?=
 =?utf-8?B?ZU9GUk5DRC83SG5ERmFKdFNnd2JWRHpNZFBDTmw3WDBBNmVDR0FUS0pCL1ox?=
 =?utf-8?B?VVVEMzZLdFlIZVREVk9DYjJ2WFJDL2I1OC9xbGZadWNuSEFyek1tNlJDYmhC?=
 =?utf-8?B?VFVkS2Y0ZWE2MUVDOHl2Q1U1NkoyYzZ4bDkvdzVkc3lJK1laSC91cUllZUx5?=
 =?utf-8?B?ZnF4TEM3c3M2VGx6TFBka3BUbk9yVzR4SThDQmFEMmcxQzgrSWtWUVUycEtv?=
 =?utf-8?B?NWw0ckhmSXZZckZqa0JDSDFGTTN3dHhCbUFrOXkyQXk1NzliTmdHbGVxT3pn?=
 =?utf-8?B?MFpBb0R6VzQwakF2OXhUMGhOYThoeE41RHBBOE1pRDhISERKRHpUK2w1RFRE?=
 =?utf-8?B?Q1JPdDZ0OXdIaU1qV0V3WWlxWUYyTllKQWJKM2xlbUJyRXZaUUNpYkdoT0c1?=
 =?utf-8?B?cTMyTGpYOU9qSy93cjNWeU4vam90V09ydlRacnU3R1JQeEp0R2t4MkxhMnFR?=
 =?utf-8?B?UnJjVTN0bkZRWFV4bFVoS05VZnpSVWRwK1hPWGNuV1c4ZmtPVjgxZXZWVGNG?=
 =?utf-8?B?ek9HL09JNHJCQ2FSODROYkRtZEJIbFZydFpTTk9XLzZsUUF2a3hKK0Y0RkhL?=
 =?utf-8?B?ckpPalJnMXFwVnVTTHpWZEdJZjY5dXhkMkFLRTI0Z0hKWUNQY2FXYXp3dVZQ?=
 =?utf-8?B?Vi9aOHdMaXR3eitDZlZ4U0JmSG0rTitEZjBDQzh5OGZhSlVudlpyanZvb3p4?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18306595-317a-45b7-0d37-08de1217aa37
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:36:39.2096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGQseaRfdbChpK0y+zsjXZq+Vf6ihCDXLNE6cQT+Q8GS20w/BFS5ebFbvegQmjmtUQQyC7x4mw2YbFLJaFj3yjsvpycbjRCCMtGA9RINfxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7050
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
Reply-To: 20251017-mmc-dw-exynos7870-v1-7-a2c5139d9afe@disroot.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In-Reply-To: <20251017-mmc-dw-exynos7870-v1-7-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-7-a2c5139d9afe@disroot.org>


Hi Kaustabh,

The tuning functionality should be made conditional under:

     #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)

This ensures the code compiles cleanly on configurations where tuning
support is not enabled.

Best Regards,
Tanmay Kathpalia
