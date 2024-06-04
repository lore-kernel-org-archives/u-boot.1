Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7A3C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED3F884EE;
	Tue,  4 Jun 2024 16:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="yqW0xsGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A32D884EF; Tue,  4 Jun 2024 16:27:52 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B01883F5
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 16:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUzPu8xY1zyu6tZggL9hmekRJC8KWiVfg6tw/C9M97yc5JURweuNPbCrPd3CnRXKp76ZK8iF8CvrXR3DbBdzUMi1N+yMr2ePYu9SsJ+j82Z1M5Ta6ADQzS3evTeVioa290msclXPhos6Dr1AkJlRALJEoCrKmVe3soObQppumsS5dj2VA0C5vrmGgK54s+rAWX3p3730/WaBqvj6Z/XrwRp9lpSb3hGFHR3zmh83yTN9u3+au6j8oftDPSeA9QYNRS3nclHRfhr7zuantszj+GGSpQ6EdyQ+MQasNN430eh9GiW/MaewCETeaIjXB0E/bEUL3AMhuDQAQRhEkmwvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56m9BVeZw2+4B9D8qk42sVoWjKA7ZsnbWPzLCOlPyxQ=;
 b=UYw6U5mDw7HRzdd/py2Rtr72zhRthIVVSL57BUt9gzxvHqiDBMHz0wLy6PqXdovWnC5XBceJWHu0vQmxkas7FYdxjTStmxMxnB/lbMgd0h/L5Snlc3ReyChMxKUUZdfOXjFtWb/nZ3eTamesyrWH1THdLrXBNBI1kAIv3I1OmmYViitBsdF8NkvpsOxLXFnkaKd+ptMC/re85GiHcPrVIv+0fiMq9oJ5Ugnh2BM4HY/g7aJN0jeO81ER6E0aUkwXR6dCh1JJioNij8+8mD37kO820o5mDcq76qIBMqqwMfqiEpwWhrYR5L+5AjAEzOzsD2UREEu6DcuvesGG9BbnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56m9BVeZw2+4B9D8qk42sVoWjKA7ZsnbWPzLCOlPyxQ=;
 b=yqW0xsGTknSh8yDPzH1VhtA5huZ7S4LZnXnW7ws7YWlK+Th0iwqvxaITtGkpf9vHuPEGJwh69/03GrGppvkCxnXr6d+6SewQiKZEro4gAu0vqXrhWhXQ6HpjICCL+kb7yEUHhhCHFILKHCvbo/PBHJIZXqaldY1vSFR72qmeymY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5827.eurprd08.prod.outlook.com (2603:10a6:20b:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:27:49 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:27:48 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Alexander Gendin <agendin@matrox.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tanmay Shah <tanmay.shah@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v3 0/7] Add eFuse access for ZynqMP
Date: Tue,  4 Jun 2024 16:27:34 +0200
Message-Id: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3ade88-dd57-4d28-00b2-08dc84a28275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmJIZThtRVpieXpJNmR1WkpNMUVWaXAyeUJadjJkVlZRTExSaDFWQUplRE1r?=
 =?utf-8?B?SFpTWTBIZ0VoVUp0Y1N3cXZjQnh5OHh4TFUyZE1mNTdXTWIvSEZETFRZWHZ3?=
 =?utf-8?B?UmdUdnkwRXVRRll6WlhWdkR6cEZLWExmZDRqdi9NU0dkak9UMkIwbTBkd2ww?=
 =?utf-8?B?QkcrM0svck0zZkhyYnF2bmNCc3hJaVpEVjFmQmM1YlF3Y3hRR1hYMzI5SFRL?=
 =?utf-8?B?TUF1RDZ6T05SYnM1NkY3YlFnaEZxUkhpWFpIRDRDRm0yU2NmMy9uMGt1MU5F?=
 =?utf-8?B?TVpIcFhIYW85eWxoRFRyOWpPKzhUaW9KeWJjVGZWUWdqbTEzRW9uRS9Ma21Z?=
 =?utf-8?B?ejRNYjlzSlNHZjNBMjQvdjBWclFjKzFOalZpMW16UVVsU2tGaTQxWmw4Zzlp?=
 =?utf-8?B?d0VPQU9VTXBjeFlKdjNFTXdCWjhPN25qZTdIV3VocWNIWktEcDhVd3ZpdWkw?=
 =?utf-8?B?dnVqWWhxQ1RRWEp4WWhnZm5vekFNK21GTDd2QVYzdFZGU1RabTFtcDBYazgy?=
 =?utf-8?B?MTdrNGNKOUZiMldONEo2VUw4U2JRSGJMd2tKdFdLRzRLeTRMbndVNDg5b255?=
 =?utf-8?B?aUVhVmd5UllHS0dGaWFPciswbGs2Vit0SGQ0VzU4dU8rUkFtdFlRaCtQcCt2?=
 =?utf-8?B?Y3l4Mis5dkZST0dOTHFRam00RHFQNUNEWlRvKzl4c0g2czBvSWZET2hOWlRa?=
 =?utf-8?B?UFIzRk44aktvYlVJNkNPdmNVRTJwWFJkY2tIQUFvZVFPb3FwVGhTNC9lb2ho?=
 =?utf-8?B?ekNnbHRiWE1QdDRzQlFVTGxlS1BlUGkxTlZYLzdxb0E5ZHJLOFI1N25TRkhm?=
 =?utf-8?B?dUNYUDg0NEpqWmJtTjR1dC8xVTREMmY2OS9KTW9HUmhKa0JPL3FxMHVpMHBY?=
 =?utf-8?B?emFQa3dlU3h1c0NReTNXeTJOaUhnUXBUZEJpMHVaWlhJQkR3NHpRTjMrNERm?=
 =?utf-8?B?SFgzK3BvM0lUaDFuWjJadWlIYU5zTTFwdmlDdUp4VWtEbTlsTlNkWlJXMFBL?=
 =?utf-8?B?cUVOaTE3UkdWWWZHRlBCcExsNnprMmp1dFNkdVEwYmg5TnBWOW5LWTNMTVRC?=
 =?utf-8?B?Zmd2NldVZTVOQ05HQ3l5TE04UTEydHg3Y1RNTnQrQUNDd3NXeUJickFVZ2Iv?=
 =?utf-8?B?OCtQZzBzRHlyOElMWWJiY1F4clRveHFYN2k5algrMStYallJNXR2Y0J0SklR?=
 =?utf-8?B?VUFKUXAvYVlXaHlRNzQwRHA5REUzVUxVbVg2WkJzQSsxaEtwMWJHZWQrOEpl?=
 =?utf-8?B?WnR3Z1FUNXJuS0x6Nkg4MkYrZTNScmE3TDU3QnhseFltZmpGbW94U2xTVGZ1?=
 =?utf-8?B?SkdnUHN3TVB1ZTROM1pQTjdxTFM2L1pQWnc2NXVmZXMwU2xlM2VodkczcUxz?=
 =?utf-8?B?WmxJSzFDK29EOXpzcGlKWFN4UjV5S0E4Zmh4MktxZ0xWclYvQnpHQkZUd29y?=
 =?utf-8?B?SFg4OXVDWUFURUpHNzM2Z3Z0SmZsRnhXOGVtVTIrWnlQM3M2YzFJV0NIUFla?=
 =?utf-8?B?bnpPSlQ4K3hoUERLN2s5WW1VVkhUU2VqcTkxNDcvbWZIaUorZGE0U2ptcGhy?=
 =?utf-8?B?Y0FIenFrQVBYTm5CTDJNUkxqVzRBeFUyZldqN1YrT1g5K2ErdDlsWHNkRnJr?=
 =?utf-8?B?RnRtUjRYRGpjbjM1OHBZc3lLQmowSjVYaEJnNytKQlBBOW9LcS93QVVDcDcy?=
 =?utf-8?B?bWh0M2NSZWZIVEpnK0QvT3RTY2JhY3psL0hKK1M5ZUkreUYrRW5IR0M5ZVdU?=
 =?utf-8?B?aStGUXZlYmdpWEZ5UWFKZFFjOUpNcE94cHVocGNYeXUrcW96SStIK2xaMFBY?=
 =?utf-8?Q?rLplyH4bNdMZs+7psOdC6zRUiU+KOjVStrQTM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWhKZnJwNVVvUlc3SlVNS3hrM1NLdG1mdFpBR2kvNnBLMGNxbUdLSDkwejhW?=
 =?utf-8?B?d1BjSnVzZFNkaE10bVpOdUlydk9rMS8rclh4dnpFdGRYS2J0T21vcStSUTBO?=
 =?utf-8?B?QVcyOUZ5UjNLNlhqYnZmSzV0MlgyWWpMbzVBb1FHZVYyWWViMzdCTXJpaUFQ?=
 =?utf-8?B?djFNNThTbjRsV1BhZzBzQmlRbGdKVjM2QUN6SGUzRmdBbVM4V2c1UWRxbXc2?=
 =?utf-8?B?c29qMGJVZ05JV0puSjNzNEtzUUM3OThDSGlERVJaRXFSN094VGJNNDB2RnRy?=
 =?utf-8?B?d3piWkpBdElKN3FzaWVtVEJjVGZUOHRtbjJIa2tRaDZLWXorK2x5RklIVDll?=
 =?utf-8?B?WjR4RHlLRGNLSW43T0FMTTd3aVhYT3JqTFEzOE1rMXlkUklzMGQ2NmZNY2Zw?=
 =?utf-8?B?Nk5BbXRSQnJ2MnBvUFV2YXliS2FjY0NqbFRvL3dzQy9tVWg0VHBLc1JRUDgv?=
 =?utf-8?B?bjUwelV2RDhqcDVjZzBpakJvOXVBQkkvMk0xcmZRaDdOc0prZXdUekFuNjJp?=
 =?utf-8?B?MUxJRWphSHkyeW9oRzhUZVMrdWFFdHlnVXVtL0RBVTVNeFdnazNDT3BUK1Fj?=
 =?utf-8?B?d3Jzd0ZmRFlYNmN4ZXhkU0lxbEpEa3Z5UmVseEVXRG12c21zaWhFV2hMTDMw?=
 =?utf-8?B?SzRTMjM2V2cwSmVsc01xWDBNNldJZnpHSjZIeVV5QzZaVk9xblBMRHV2bGp4?=
 =?utf-8?B?RUkyUjhZTmhaSXdaYWpocXVQTGN1ZkgrY3FsU3dkdnBQSHhySUNscUtKOGRO?=
 =?utf-8?B?MCtaamtZOGpkR3EvTk5zSmFrR21yNmRyMUVuQVZTVWtHdXlWc1hhR1lDWUp2?=
 =?utf-8?B?YjBWeG1KVG9hLzZZb0FxSnJxaWdmajBENmJyalRYZUcreHlld2Y1YlZNa09t?=
 =?utf-8?B?MThlbzNKMURHVWVxcnhTOWlMVlp2NVUwSFRwMXdhdmovYm9PME01ZEdCbjVT?=
 =?utf-8?B?dWFaK3JXTTRBcy91b2VnbW9FV0orVmRFaU9sWG92SWUrbUZjaHdyYzRTY2pB?=
 =?utf-8?B?cTBXZWxHaFBuVitOL29kdFFwbWpjdi9ENU00OXJRNFNtWFF0RU9ML21hWkFQ?=
 =?utf-8?B?bXVNN09zeTlmV2sydlNla3NabGFodGlkMGR3RnhCV2VUOXJuVWFhMlpXUG9t?=
 =?utf-8?B?THIrU3pKSUNWbXI1WUE3Z2NYWisya21aOHFOWEkwSXdKYzMvR3JiNnMvcEpV?=
 =?utf-8?B?S0hHd3lQLzNqMFQ5cnQ1RVRITkM1RkJCMDMzQVJHd2x6U2gzVm5wdkRxM0Rj?=
 =?utf-8?B?OExSMHRsdDBWd3BqbzB3ZWI4SzF3ZlpnY0IwdkJzODQzdktKZGdzTGVYNHFx?=
 =?utf-8?B?Qlk3dk9idHVFMk1yc2RNUU5MYWNJVElHT2R6T3hONFg4dEtFN3NqNGxzWk9p?=
 =?utf-8?B?UnprMkp2d0pmWEJwTExqaTF2QWF1Vmx1VEZkcjY3ODBjbXVJbXVzYlowc2hi?=
 =?utf-8?B?a2NyaGFDbGdqWXJPQURTbEpPVU9KckZ3QUtmTCt0eGpWeDFWcXcwOFRCN1Ny?=
 =?utf-8?B?OUNkNDhpQzJ5ejVIYXcwTXZYdWUwY2d2aWhHVU02VUxaa1NSazNHRnZrcWw5?=
 =?utf-8?B?Y2hDa2dhdnAwei9kcE9hcVh6Ty9kQ3pjUDQ5d1Y0WGtTN2g5Rmw4SStHSU45?=
 =?utf-8?B?K2RLcFMvZ2t6dHo3NFg0VGs3MDZIZEFoSDdXcHNiaEtCVTJEY0ZVeVUrSi8z?=
 =?utf-8?B?OFFnU1VIMys4Mi9uZGZ4c3lCeFAyQS9CRUZDK3EzVUovRHFvanZaOWFxYml0?=
 =?utf-8?B?MDBzalZvLzJ4YWtjVldRVk1HTExXWiswaTRHcHBoZm5DV3E5MEM4VmVaRlpx?=
 =?utf-8?B?R09iak5aL2dwWGVvOFBiSTcwMzM2SDFFdW45MG00dExsMCtjUEQwenI4b0U5?=
 =?utf-8?B?TVY2UGVKanlmL0R0V0JJb09ZL0dFdzZLcWhnUms5T2o5alJBYmpyN3hmemx1?=
 =?utf-8?B?Qk00TndwMStiNzZWMzE4NFlaVEZQSFIzcDgwazNwcUFQWndYajlldEZoeEVo?=
 =?utf-8?B?ZmVlemc4U0ozRk5QL29EU1BzSndDakxpeEN6NFphc2huTlRrNFdmZXVSZUd4?=
 =?utf-8?B?SDVnRUQvSHJNTG54MURtZG5VcmZuRm5qTXlqVFN3NnR2N0tYa2xUcUpYODQx?=
 =?utf-8?B?NzR1V0gzeUxrVHp2MG1CTmlhaTdBZEZsVXN3TEFrVUJUWktlazN6dThTZzhr?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3ade88-dd57-4d28-00b2-08dc84a28275
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:27:48.9041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0IsATdHfZlaoc6HRhl+73HYzNNRJcw1jl3bNQ3qkRKXeSblKBTQvRZMtlIYbPIWHk2+SCUpRpA167BHSnbAPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5827
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series adds a driver to read and write ZynqMP eFuses [1]. The
driver can be accessed by the 'fuse read' and 'fuse write' commands

Example:

=> fuse read 0 0xc 3
Reading bank 0:

Word 0x0000000c: 3cb16685 013af244 40000000

Note: Accessing eFuses requires eFuse access to be enabled in the
underlying PMU firmware.

Use cases are:
 - Reading/writing user specific eFuses to enable device specific
   implementations
 - Revoking SPK IDs
 - Reading SoC version/DNA

[1] https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/eFUSE


Changes in v3:
- Align ZynqMP eFuse driver with Linux kernel
- Adapt versal, versal-net and zynqmp to use common chip-id function
- Enable CMD_FUSE and ZYNQMP_EFUSE for zynqmp_virt and zynqmp_kria defconfig
- Use 'dev_err' instead 'log_msg_ret' if possible

Changes in v2:
- Drop vendor specific fuse cmd, use existing fuse cmd
- Minor code refactoring (reverse x-mas tree)

Lukas Funke (7):
  configs: zynqmp_kria: Enable CMD_FUSE and ZYNQMP_EFUSE
  configs: zynqmp_virt: Enable CMD_FUSE and ZYNQMP_EFUSE
  soc: xilinx: versal: Use zynqmp_pm_get_chipid() to get chip revision
  soc: xilinx: versal-net: Use zynqmp_pm_get_chipid() to get chip
    revision
  soc: xilinx: zynqmp: Use zynqmp_pm_get_chipid() to get chip revision
  firmware: zynqmp: Add support to access efuses
  drivers: misc: Add driver to access ZynqMP efuses

 configs/xilinx_zynqmp_kria_defconfig |   2 +
 configs/xilinx_zynqmp_virt_defconfig |   2 +
 drivers/firmware/firmware-zynqmp.c   |  31 +++
 drivers/misc/Kconfig                 |   8 +
 drivers/misc/Makefile                |   1 +
 drivers/misc/zynqmp_efuse.c          | 360 +++++++++++++++++++++++++++
 drivers/soc/soc_xilinx_versal.c      |  13 +-
 drivers/soc/soc_xilinx_versal_net.c  |  13 +-
 drivers/soc/soc_xilinx_zynqmp.c      |  21 +-
 include/zynqmp_firmware.h            |   2 +
 10 files changed, 427 insertions(+), 26 deletions(-)
 create mode 100644 drivers/misc/zynqmp_efuse.c

-- 
2.30.2

