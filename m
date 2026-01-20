Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEBDD2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF9483A8D;
	Tue, 20 Jan 2026 16:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bm1mB9DS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6ED083A8F; Tue, 20 Jan 2026 16:02:56 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70BF83A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIKVkahVSiCNGzoW2gIF+mJ66bR5RP+e2o0PgTKP4gt8PSXhNgMTnicf5hnbMwz+aiDvOTEKO7lRcy5TrrxxUwR+0JO5iRm9t8dGCpMYdsWhEGtrx6M4/7JI0P/bbPZAKL6zowu7BugBeRZ6gnF3d8n1ieuX8AlZPxemnKmz8TdeWX5Nvjxz6/LAjd2U0dla06MWQH/BJ04fX1aJstCg17xPqlrCERWtVssLuSGDzpS55+GvffIY7PWz0u1NAuf+GjVKzzWhsQtDDhRQK+68FeUv1+Dz3jv5PJ3dhRInbxORnpFMPaC8SHMnO8FCY436oYR+9l63Xa96szxiHfQLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pllztOmUq7dfogT+Zlz5Iep5tj9jeSbQniZiCX4VXCU=;
 b=v3yPyA/KVxhp1+n7bW9hhWEm6dBaXLWG3EGw+ynn/9ChWVOGlpbjcv1/XEpT1flLTB1+oLh9m4J0tKE86auZzibo1oWBCdOarNbZU9n9MecvFxDDTSZgnRInGbtnJkZnnzPtcvV+XaeUUEPjyNqSipt2JnfZkpoLjHwsGum5DqV+9Ley+lZs9y22QrisydAF7t/A3yijUcwcvV1ZfsRoMYnMqNxiZdjm7nMEITsWVYJflUVbCiz7gVzvVBJVhvU1dMf/z/wSXbB64GwZzMAPDyZzEvykmoqfYLPq5tsPcCTw5RR9dhWkFPX0r8Xmmc3dICuQviyZpBn9o0weIitQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pllztOmUq7dfogT+Zlz5Iep5tj9jeSbQniZiCX4VXCU=;
 b=bm1mB9DSeHFYwBP18ABj1jxkR0rc9rU157evnCqQWRsQI44+BCbjxguK9WYqZObt2yLPaBrNXk4FZ1ivBnTduhq/TZ9U88Vy63aEomg/cxYTI0dWdGb9CxFa9BDehD5WRy943OerEgcO4WmB9jDpvtL+oS1CIUiR4oizYscGeNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB11596.eurprd04.prod.outlook.com (2603:10a6:150:2c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 15:02:51 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:02:51 +0000
Message-ID: <9adf71a1-97bc-4cec-8c66-1c096e0b7bd9@cherry.de>
Date: Tue, 20 Jan 2026 16:02:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] binman: DTS: Add dump-signature option for capsules
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, simon.glass@canonical.com
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-6-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120081206.251544-6-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB11596:EE_
X-MS-Office365-Filtering-Correlation-Id: cc30b3fa-2d49-4eb1-6a48-08de5834fb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXdueDcreGJlNFlTb3RwWGVndWN5VDBoSjJGbk9FZnpZSU5TN1NVYllVZ0Vs?=
 =?utf-8?B?by90aDBpUVlzOWUzU3NqUDdrQWxycjA2MGRaa210ZW40S0ttSSt4T3ZaM3N1?=
 =?utf-8?B?Q25LcmZIMlA0djlta2hhb2VZTVg4MnNkZy9pdUFMam5kNklEVVlPQkJTQXFD?=
 =?utf-8?B?M0VvS0tnb0xHMFpRRnUrMnoxMXNrckpmbWl3Q0YyL25JckhWSXBWWnA1SUxT?=
 =?utf-8?B?dVFDWnEvT1AyZ0I2bDY5bk5qNlRwdVh5Q1lLcHNaaTVsaW9JZVRpWW5tb0Nj?=
 =?utf-8?B?WllSTVNXakx1SnZESU5EQi9WclNJOUtKalZ2KytsZWRuS29nbkRPNkE0WFM0?=
 =?utf-8?B?YkdWaUhiSVk4RVIrRDIxZE1wYmNuQk5wWXNmYkQ5TzdCYkxnY0dFTnBkT0I2?=
 =?utf-8?B?TmViRldaRFlFK1hCdkNscUF3NGlXYkRtaTh3c3Q1Sm9IbG1UZW5CRVNCRGFL?=
 =?utf-8?B?d2hUcEttVGliZHBiK3VJN3VzSXFRTGpESnFZcTZQMzAzcEp1SkRzZHBXWkxa?=
 =?utf-8?B?MDJraExUd1NKVHowK0gxOTkySjlscEZhdGZOZVNrejdUOXVLSjNGNXJpVHJo?=
 =?utf-8?B?NWptQUF2dUphMWU5TlBQK2I3MTZ1TWl4Unp3czJqSDd0OEFaSTFiQnZaTjJx?=
 =?utf-8?B?RjBIblFkT1NXbVEwcnlaVUhDZDF0L3NLTHc0NXpBS1puQi9PNXQrUmVEbzhR?=
 =?utf-8?B?NGVRQkdIRVlabGpxbk12YjNDZnpIMkUzTkovL1hySXZiSzJ2dGZ3Q29tRFM0?=
 =?utf-8?B?MnVaL084RUdZV0hzM0NzdnExODdZWmVYaHN2MjhEcGFsM3lVUzVndWJJT3hk?=
 =?utf-8?B?MC9hT0V3T3czZnREaUR3Y2NBak9LV2h4TTVhcWluMWtiSGtoZUlSZEhYWHMr?=
 =?utf-8?B?bXFSd0k0Vk1Qa0l4c1F0RmM2aFI3ZnVjMGdGQURzTDJQRGNQYTk5bHJDYTd3?=
 =?utf-8?B?QTlIV0djMDR0dXFIYTBMdzJ0S3BUUmFnRHA5SzdydGVoMFNHMncvNjlraURp?=
 =?utf-8?B?U0E0dWJjNXdFbjgzSmE3SEUybVZJclJ5bC8yL1p1UktyQnc4emRTREFtNEhu?=
 =?utf-8?B?bWtFY251UkhjQTRQNnRRL3A2WkVPR2FyVFJxMWRMbm1MMkFJV251MWU4Y2Zh?=
 =?utf-8?B?WnVwRkUxN0xPdCtsUkhDcXJsLzhEUHk4MGRhVURTajJWdXJCb3RVQ1ROdWpY?=
 =?utf-8?B?SGZWY0dsK0hyaGI0MXhqZllBWEwwZEZNYkJ1TVhLY3d2c2NnclRFclJvaWpw?=
 =?utf-8?B?ZjRPaTVhTUdBcEJyMFV2ZjBPbDdaTUVGZVEzOXpGYlRaL3I3b3ZtZE52WE83?=
 =?utf-8?B?VWJSdCtVWUdDQ0RINkdURlFHT1RULzFFRTF5SFFBM1lvUEpvc0ZoUzluT2hB?=
 =?utf-8?B?NzNmTm4xMkdkZ3REYWNVbnRhTUMxeDBRZEliUnRNTjViWUd1UzhFMS9RSmIr?=
 =?utf-8?B?N2ljV2FLSk9wc1lualVMSElLcXBjWjZEUFdQSWtuSmtEOXpwZG1NeU1kYTJ1?=
 =?utf-8?B?NjF3VVViTXlRVmROaVRsMDEwc0d5OTdIWFJIWTYyWVBSSzd1V09rb2x4S0Rj?=
 =?utf-8?B?dDhqRHhLL2FuMUxpSFpwWHFsbERxYy8zNkRXVnpSbSt3K0tacmp4UnlVMUI0?=
 =?utf-8?B?Ym1sNVJvQjhleUFqK042RDVMVHBpeTNRb0N6Q0tRaWhIUDFaMEhjaWhjQ2RN?=
 =?utf-8?B?bytYVXozTmxkd2tWcVFnZXQ2Zlkvc0JQRFF3NjNIV01Sd3dib1NwQ0tQV3Nq?=
 =?utf-8?B?TnI2QlVZSkZnUG84N2xCdmp2VllyMGZwdTJGdlQ0VjQ1SE5rcHhnM1VuVzMz?=
 =?utf-8?B?bTdVV21CVXVJTHN2WnFWdGpyUVA4clZKYkZwZmIrRzYwK0hKazFCQW9Hb1NR?=
 =?utf-8?B?aFpFdVJFSjUwNHhObW5DT0VidHVYT1YrbE1SQVA2TnFMWFI2cTlpbFRSTkk2?=
 =?utf-8?B?aDFKaythcVJGMzBLK2VpbytKWGtJRkFTYlo1Z0lCd2t5dW1ZVmVGRk9HOUFJ?=
 =?utf-8?B?S0pGblk1dmhwOGZlaEMyMXJNWW0yUHRKb3ZHVEZaMTQwNmYybFd3eXNFQkwv?=
 =?utf-8?B?aDNldTNBUUNDV2x2UWx0VVZoWGc4QmorSTk4R1VOakVNSjRiWEd1ZzdMZVVu?=
 =?utf-8?Q?h2Lg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVYVURVM2NyQVlzSGJab1Q0MW1CT3djVnhUMzZ3RVpzU2IvQWR2R3oyanpS?=
 =?utf-8?B?UGg2eUhBRDh1a2I4TUxVVlNYcjNsZGNsV2FaL0crdHFCOTlreE1JcUFhZkxa?=
 =?utf-8?B?RGNNdThkcE90L3NkNXY2VVVnN0FkMWxmdUpBbGRJdk1aQ2h2U3FxY0VSeEVr?=
 =?utf-8?B?ZXFVSzNRQVk1SllqZHNkOEFIWW0vY0dNNlB2Zlk5Z1J0V3A2bVFqdTRJYkdQ?=
 =?utf-8?B?K2IwNzRGWFk1ZXlkWlBPU0ZPUWcrVU9JajRiVXBxQjdMK1BOS2VkSjY0RW9r?=
 =?utf-8?B?NU5hQms3NmlkOGFCOGJQNU5DYXk5U09QNUpuajhaMFMrbFA0cHQ5dHltS2U4?=
 =?utf-8?B?K1NBdlJLSXBOOTRNRzFLaGNHSlpmaEN3d0JDK04yWDBhakJIeklNcVh0VE9U?=
 =?utf-8?B?L3FmWk9Tb0pwT0xKQWptOE9aMHQ4aHhOUzdtbXRRS21PWTVpWTVKQlozaHJG?=
 =?utf-8?B?aTJYMkhXeG1mOEhxbk94NWQ3TFE4bUdPeDFwSXVhSko0T0NQNysrWlBpQTY3?=
 =?utf-8?B?TUlLQW16cE1ZUHdhNG9FU1Fsd1MrenJ5cWhKMkVkS3NLckU2ekZFSEg1QUFj?=
 =?utf-8?B?SVNmZk5ueTNCSnFBTHZPdmhkWXpSUjlDbTUrakxpc29EckQ4S0ZSaEtaTkZj?=
 =?utf-8?B?VE92ZzZ6cFBESE01bGRXcHY2cHZaYTdHMjFPdko2UitpeGdMN0dEZnVvS3dF?=
 =?utf-8?B?ZkVLUHBybm5oTkJ6bGlXWDdYMkNhd1VyaTRrVXlxMWQvMGlvc2p4UXZlVTBu?=
 =?utf-8?B?SGI4TTllRDVIelNFRUFvc2tDSHpJUHlrNXZlWHdZVlcveGY5U2RENHJ2U2Ra?=
 =?utf-8?B?OHR6OUM2Q3pnS0Z1TGNqYzNTTVVQTjY5R1pEai9lR05kVXpud2lpVXFSQkZ2?=
 =?utf-8?B?N21Hdk0vNTN2V2hzcGlRL091amUySzF2U2xEZGFpL2ViZ0RVclRkeXU0cFhE?=
 =?utf-8?B?a2tUc3Z6UGZDMnM0UGVLL3c2SW13bjFBUWxFWEl4Y1VDa09nY3NzajhtNmI1?=
 =?utf-8?B?Um1SbGkwOEVVYnNyaXRzWmQ2aDhWcHVLcXdIQjVjQ0pwOU1DZlhMOWtoRHF6?=
 =?utf-8?B?bWpHRUtIcHpEK2xvVjBKQTJrUm1jbU84ZFpJckNnaWx2NDkzWnQ4VElJdHNL?=
 =?utf-8?B?NnA0V1gwaXA0Z0dxbnRlTFl2enF3ZG5KWE1oWnl5QmtySzRtOUJwaU45VkxQ?=
 =?utf-8?B?NE9oWWpXYVZqZ2J6Y21BcjhpVWJRYmV0aXdPL0h1VEhjSVJ4c1VURlVCWGlh?=
 =?utf-8?B?Ky95K2pkaHJ6cGdTS2NPSWhsbzZVVUhGeXBTQVp6S1lsSjlZNEdwSEEyaDMz?=
 =?utf-8?B?NkMyazd0Y283N1lxYVBkT0V6c25ZSHRtT0o5T0hmZW1oMGJZNUc5QUZ1SVF6?=
 =?utf-8?B?VkJGMCsxYXNZaXQ2L1BnNGlJdGtpcTBseDVqNHhJcnVveDZ5cWN6UWxDd0JD?=
 =?utf-8?B?aXFlUHdIVjNKSEpMdVFrRUEyMjVrbzBlQVRPRnBNejR1QXFFNVRPUGEvNzhF?=
 =?utf-8?B?WVozNkYrWTR1N0R4N2Jza2hkZzZYOVlQZExiQWx2RnNla2dVYjk0Y0tvMFg3?=
 =?utf-8?B?b3JGS0lTcDNvODRMS0pUN3JHSm9XaThJUUNNV2VWNWtLQ2YrbExhZEh2ZkJh?=
 =?utf-8?B?MS9ZYmtNcytyd21uNkRKZUlNOURGZkxvQmEvUWRnWHN2TjFlTWkrbUN5Q09F?=
 =?utf-8?B?c2Q0cStMNnA5bC9TVWpTYXZscXAybU9iL1dEempiWlVoMzRzcW9Wd0RlaS9v?=
 =?utf-8?B?SDVIekN6Uy8yK0hGZHpYOFJPdk1SdnVpTG1iWTRyUFB6SHhOZFEyZ3h3dTJD?=
 =?utf-8?B?UE9uNjRSejBzZlByOWtSS2h5anVEYjV2YXN4ZllzZm5NbHZiNVEyaCt2Z25J?=
 =?utf-8?B?dmNMakZKSjhFQjRZU2M5SXZaSnpkWXJJUEtza29Wb1cyblJzajBSOEJ5SUdn?=
 =?utf-8?B?bG1DWHdhWGc1ZDhMK1liSjFwTnRPNk4rQUhMVXhrYWVtajdTdE9mdXlyNVBT?=
 =?utf-8?B?SDBsUlU2OU9ac3M4YUVPVjdlSEc4YWJ5MFZWbE5jRHpRVlh0OC9odWRyRHVJ?=
 =?utf-8?B?Z01DTWQxdkl6a1FQZ2pBMUZBQVVlR1NneUhUQ2NBTmUveFpGd0JPWk9IanAx?=
 =?utf-8?B?Rkt6Zi9JZ2k3dERVNTRvQkRtMEo0ZlN6N0JyTGJCQldHdXl1aHBHbytHVnhv?=
 =?utf-8?B?eXFIbTV1K2xiU0EwWG9VVXZKQkxBZmlwQVdnWCtheCtEVnZrU1F1N2FraGlQ?=
 =?utf-8?B?eHlLOWc4VlU0VVhTeUNJOFdWUHFXY0NncjdpRzNzQW9TMVdVajVycEd2cXoy?=
 =?utf-8?B?Vnh6Q0EvT1NGWWZXUnMvQ296QTNNd1lLWmIzZzdBN0FoMU1kalVGTFVBTHA0?=
 =?utf-8?Q?fsi22rQr2zRg36Owwuv7JVB4AugZiPIm+4TeG?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cc30b3fa-2d49-4eb1-6a48-08de5834fb60
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:02:51.3143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1cgG1rj0oLIb+ggB8FqcSIH1AuE1uQDdZpKL4sLJ0Rze/zNgjBmuzC3IKd+ppBQGA5DTb4DDG1blBrkTL2HjQFotzBMDevu3fFbdyillZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11596
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

Hi Wojciech,

On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> Mkeficapsule can dump signature for signed capsules. It can
> be used in test to validate signature i.e. with openssl.
> Add an entry for device tree node.
> 
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>   tools/binman/entries.rst          | 2 ++
>   tools/binman/etype/efi_capsule.py | 5 ++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index a81fcbd3891f..1dace2087a2a 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -552,6 +552,8 @@ Properties / Entry arguments:
>       - public-key-cert: Path to PEM formatted .crt public key certificate
>         file. Mandatory property for generating signed capsules.
>       - oem-flags - OEM flags to be passed through capsule header.
> +    - dump-signature: Instruct mkeficapsule to write signature data to

S/Instruct/Optional boolean (default: false). Instruct

> +      a separete file. It might be used to verify capsule authentication.
>   

s/separete/separate/

Can we predict where the file will be located and how it'll be named?

>   Since this is a subclass of Entry_section, all properties of the parent
>   class also apply here. Except for the properties stated as mandatory, the
> diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> index 3b30c12ea514..01d56723b98c 100644
> --- a/tools/binman/etype/efi_capsule.py
> +++ b/tools/binman/etype/efi_capsule.py
> @@ -101,6 +101,7 @@ class Entry_efi_capsule(Entry_section):

Please update the docstring so it's in sync with tools/binman/entries.rst.

Cheers,
Quentin
