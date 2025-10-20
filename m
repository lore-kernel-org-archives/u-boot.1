Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411E2CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 09:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851C282C84;
	Mon, 20 Oct 2025 11:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QNLdMDnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58FA982E34; Mon, 20 Oct 2025 11:06:05 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD9D807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 11:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=st4f2k3twOt6IzEeKX6LVmjosYRJ5FzNCi4fdkEMh1D9Blz+efgOgTvSNNlhU+GphymiFdOGODFMci42oPj/ONnu9qxLVlF5aeuoSSTgEpYmCqZv6sJZnU4iYca7fsjhI8cqtuh9F4woTfU99wfYxt60XSKeTgyhJs1Ej+o+TgZubhNhIKD2JS7eGV9Ghq19c5e8X7CUz3oB+hkwPK5/E87nY4GiL86WALRYiTci/AOfs8EK9q/kwOisUxOXtt64RkGqDAtG9lR0juw9aZGihf8coKIHDw+fVDHjIYVCDndurImq8WFZj+FB1/CiQ7kkLxGnmNhbuWbYcIJ8l1LbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIUNk4y9qZmvtEWiSeEcZSgMRd4Si5+VaiOv7R4tfmM=;
 b=VRQo0NVdiFNTXVeqYjNNvPyNyqjn+O0xgveooNXJOfGR1KI56SUxIxnO3dADGNwM9zhuNdzAAcr08n5oLGqajJBPLbcAANrqNbFGC/wJmFeJEOHCDon/gjHMs+Y2i9wevtqaVOJVbuxJzjZqqpTv5vICRxI8jayuG4AuyOUq0Z2FzoF1CN5NE6/xzZPVAGl4t8pFcVrscRw31qZcufyB3A3fPqqXY1QTEO6LKCu9xJh2AfSJOg1JwsLjfV8eCUlbu5sN6KL+c+f1V7tx8FB+haPjotlL1uUCPGMBLTMiMylMTMtESkwp/F1U9003LOa0L/xLdZ6E8ZfM5fNQpNDHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIUNk4y9qZmvtEWiSeEcZSgMRd4Si5+VaiOv7R4tfmM=;
 b=QNLdMDnPjnrXNo+sAkLzigKEPOFhVsknR+DzGwX5w2tUQ0HErYSYS2ChuRMPAbNqmQRnhLrjt6l9uRpvApf8OsF8+9YhV9PKRkDAam4tlfftsmaozfr3cmuKBwdXfFmvrxhhek5TFQ6q4H6INHVQ0GoCzNbBoAln0LlncluIHkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS5PR04MB11369.eurprd04.prod.outlook.com (2603:10a6:20b:6ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Mon, 20 Oct
 2025 09:06:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 09:05:59 +0000
Message-ID: <b543e8fb-53c8-43bf-a880-1f15134aa15d@cherry.de>
Date: Mon, 20 Oct 2025 11:05:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3568: Disable USB3OTG U3 ports early
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251019150945.823167-1-jonas@kwiboo.se>
 <20251019150945.823167-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251019150945.823167-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS5PR04MB11369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3623db-2d76-4fb0-00e0-08de0fb7e29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmdJT295R1gyc1k1bzk3VUFoRy9CVGVCZnRIcVFHVHVVUmFadXBLdklJSEtk?=
 =?utf-8?B?VXVIbTRlNU5VY0cvWHp3bE1LaHJhYkE4WmdGTmJwMlptN2dBcGQ4cUVFVWsz?=
 =?utf-8?B?Qy90MzR0cVphb21kNzVxS3A3SE9BNDlqZCtOL3hlU3hpQ044Zm5tM3NkcWFU?=
 =?utf-8?B?ZTRZSHlhMkhBcmdMdnZxT0xjSkVKS3BsRjZqdDY2WGlzL05ZNjQxRFE2RFM2?=
 =?utf-8?B?VU0xZXprNk13TUFsQXAvdkRqQTMzcUM1cGJyUDFMM09BeDNFRVJmbUwza1Qv?=
 =?utf-8?B?cGtJRE5kbE9qdG14aisvQmRRaG9LVDB5VTlVbEtQUDRpMWJXMjFCYVA0dytZ?=
 =?utf-8?B?QWExNkhkU2E1c1h4OS80eTJiWE9MUFBWK0cwZkZFUFprTmNEak9TR2FZTmp5?=
 =?utf-8?B?d1hoYm05bEdIeExFdk9HQ3Z5bVpnZmpFN0QzRGN1cmtUdVJQUTFKWC9kTFJl?=
 =?utf-8?B?VEZncDl5SC9sMVBIUGJ0Nit5MFRvc2hSK3ZycEhZN1BRN3VXa2tETndkZXZm?=
 =?utf-8?B?aWpWOGovc1QrdGJwd3drWFJPbW1aYVFKS1R6SDk1ejR6WlNGcm1vZDNkRTk0?=
 =?utf-8?B?cVFIY1FJUHl1OFlvTTludi9IVUE5SUtSNVFZaC9LTnBxdTJqNE8wcXpwbzJt?=
 =?utf-8?B?VkEvSERaKzZzRnZVdDVNVGg4RHRuN2dqd0xwb3dDZU5QSGtsbnBxMmgrVjRC?=
 =?utf-8?B?OEJPNFBxN1hXMk1MRW1Delh0ZmxyaVI5bXNTckIyclBDN01UNURLSWExMWNR?=
 =?utf-8?B?RFgzdWNQc2tKQmpnUlVNMUZsWWJJWHpLWHN0U1dUakdjOWF0MTdiUHRMVWpX?=
 =?utf-8?B?VGJJQTErNlBxUHJUWDcyUEdOaFU5WS90dHlPWllJVlRWaEx4YjZHdnBCZkRm?=
 =?utf-8?B?QTluR2llbW8vdlNiRStDT2NQczFFNFE1SVQwbTFYUGpteTduS2xOTlRNWUxX?=
 =?utf-8?B?dE5HcGZDemE3UmVZRW1xSmRaWER3bGVNZThkYU1QMExJNml6SnJ6Wks2dlJq?=
 =?utf-8?B?SGdaak1BTm0xRXY5bWp2dXMzSlpYQ3k4M1VwdlBhTlBOdHVVa1EvTmZZMEpr?=
 =?utf-8?B?REQvMjNUZFY2TEdBa1V1UHZBcEdaam1Ka1dBNWV3cW9RamJGaE1Za2s0Z0hQ?=
 =?utf-8?B?M25EOFJkU05Hb2gvRkdvUEhXMWVnazJvZk9xT2N0Nys5UzBSUkNBM3FZTGps?=
 =?utf-8?B?bFlCRTNHNmhrdGZOdE5nZlk5OUpJZjRPSUtmSTlRc2tWbklDMzlvK1IvQ1k4?=
 =?utf-8?B?K2ZnS3NxZE0ydmFZbHdHdEQ5eFBaVDdaYmJmUHlycFBaYXp1UzNXVjlHZnpF?=
 =?utf-8?B?MUMxNk9pclE0SXRNcE1wdFVKZGJQRkZFbFZMTTZueURZaks2NzdnVElqam9M?=
 =?utf-8?B?OEJOUkdxQm9ydEQ3WVAwZVdZUVAzMnpRVzR5cEZQVTh2dmV4WlMvVzV5bkY1?=
 =?utf-8?B?c2NOb3pDbUIvbjFYWDFtT1FpTUNHOWxtTndKenlKREJ5d0laZFhiYTlMRWNz?=
 =?utf-8?B?VjB1eTJad1BTU2IzYWFNRktXZWxGRjI0TXFtczl3V3h2ZXRmMEExOE14VE9Y?=
 =?utf-8?B?MEk1VDVMTlNmN0JLUVhqeTk3VjBEdmtibDNidzB0S2hmZzlDQmN0dVFVVjR6?=
 =?utf-8?B?T3BiZHZ6ZEhjbEg4cmRqa3AxTzJlcFI5WFVCc0hKTVVvS2JUMDB3QTRpckRx?=
 =?utf-8?B?MWlFN2hacXYrVjdUWDE2bWV1RitKeDZpT1IrVmZFR1hWM0hKQnp0cFRSU1RJ?=
 =?utf-8?B?cThGZzZYOVYrdjJ4bEJWcnVtSTZKVEw0d3F6RmdWU0Y1WWRxYm4zVU13Snc4?=
 =?utf-8?B?cEJFQ1J3OGs4eTVCVi83dGhzT0R5emxGeW0zMkpxWmxLQ05PbU9MSWxacFp1?=
 =?utf-8?B?TTNRQ0pZbzBQOTk0b2NwZk1oNVFFaFdiUXcweTYwOXFOUUxBQ3ZUWVJrUHpD?=
 =?utf-8?Q?8/sfMzJcimcuHPoffJQRB2wLD0DKCaYY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5nZjI4MW94L3NzZjNaa3JjU2EyZHB0N3QxWFVXTDF3L25uOUZ0QTQzUU5q?=
 =?utf-8?B?Y2xNNGtzNkZSOExLaEdHUzM2UkVvLzBWdkVVQzRsOHBFNkpKRnExUUZnQWZQ?=
 =?utf-8?B?U0t1VzBWZTNmR05HdnVlRWJ6UUFhSHl6M3cwazNaOE12ZnhEemFZZVJhV2Nn?=
 =?utf-8?B?R1h4aC9Pc29Oa09yZzBSYkVwMkFFQlNzMmFWUkxpVmxJclk5NEpQcFZHenhl?=
 =?utf-8?B?QlMyajdURE5TRE43VzBMR2pBcm5yWHFibGkvTVlCNHdHdnBPWktXbmI1cDNN?=
 =?utf-8?B?NllVRE1PenFuM2pCMGZ5MGxuck9SYUtXMGZIamtlSUk4bjRELzVmaTNmWm0y?=
 =?utf-8?B?aE1YOFIyaG0xSm1vNHF4WEFqaFBjK1lPcGZLa2lib3Y0dXVlL005RDlnT1Rq?=
 =?utf-8?B?NzN5Y0hnR0tPaS8vQkExVkpucnNJYmcrdGtwNlBIemZiN3piYmtNUHF6RVhi?=
 =?utf-8?B?ckNwWWZBelhKUTJDb1JTR01HS0ZOdXkxV3dKUFpPWElRdjBNeFJ6NGx5bnd5?=
 =?utf-8?B?L3pVdEZUSmNPa3Bpb242aVFjTEEwVWJIV1UzZUVRVDZ4cENqYU1TL2tqbS9T?=
 =?utf-8?B?TnhyTGJNL20ybXp6ZTNmWkx2VlpnUnd5amNsWkFMMXdjcDVrVE1GVWZobzZS?=
 =?utf-8?B?Q25GYjZWdk9HaitFaEc4ZTJ6aWJQZ1orN3h3eTVCRnJBakJLU1kyVURNdDIw?=
 =?utf-8?B?Q1ExWG1yZTZVODFaMSsvb2xJaktPanByRlFuSklQV0ZiQndvU29DRkFUd2Ny?=
 =?utf-8?B?K0RrYlJBcGVEWDZES1JUaFVpaEp6U2c4eDlUeCt6TjdDbUNjamtzSGJlUE5D?=
 =?utf-8?B?azloNEx2Q1ViNlMwNE5HZlhCVzRGdmYrU1MrUUxua0U4b09zTFV1cnJ6Z3l2?=
 =?utf-8?B?bHE2MU8vWEhFTDBkR1drWmo3Vjh6V1REV0NFMTRsOGlDTGVacHBpenZvTnFy?=
 =?utf-8?B?RUJ2Nk9wYU1QYVFxNzc3VnVDZ1NkL21DRVpFYllLcTJBaksvdnRUeEROem0w?=
 =?utf-8?B?NDJ5bDVFdFF6RXVvV0dsNHhJMXFudGt6RGo0S05lT3c5ckJMM0JHK2NLbUUy?=
 =?utf-8?B?R3lOT1FsNEU2LzNqSzF1VmlDYlBJb1hGbjdQTXlLdEhSZ3FTTlY1UnJ6eVFR?=
 =?utf-8?B?N3JDTFBaUXYreGZRWVFRbUhNRStiVnNZYytlS0lMb3FvQ1UwNllwZDRhUC82?=
 =?utf-8?B?YnZWRFcwVFVQempIV2hoUjd1VW95blpEWVNRUk9EeGg3QUdsQXI1ZStySzl2?=
 =?utf-8?B?R1d2UzRoa2JzNlB3NXVaeG5nL2liajZZRHZwK3VQa2JkdHl6N0hEcEloWEVn?=
 =?utf-8?B?NldFVytMZGQxclM2cFZFQzFBT0xRQm9vOFdqSkJ2Q2FHcDZQV0gyb3R0T2hH?=
 =?utf-8?B?emZNaEJmYjlyaFhKSTNXQ3ZSY28wOTEzeVRjTzFRR1FrZ21VaTRCZDZkR0xS?=
 =?utf-8?B?QTZ4UWkzdks1LzFzQllCSUhrZ2dpNXhkU3ZCUkJlSXF5R0dNcXZ6bWFDWnhD?=
 =?utf-8?B?dFBCckliTHVqcW9tQWNDSHZrR0pxRjZydFhYQjd2YlFIWjhpWDhuTDM5cExu?=
 =?utf-8?B?T3FCZlZod21ObXY5TWQ0SXp4R3JxRUlyaGFDdWJCRzhxcTYwVm10aVRQV1Jl?=
 =?utf-8?B?SFdqUTRkcHlPWG1XYnBkOGxoQzBOUHJHMnFMQTZVdkpMRDRZbS8xL3NqZmhG?=
 =?utf-8?B?T25uU1BnSzkzM2QwMTBZYVVmUnlJRDRWeVIzYitEdC9KNkNqYzV6UWJqQlkr?=
 =?utf-8?B?ZHNqWlc3cE1uVmlHZ24xbU82MFdkSVdzK3RnTEhsUlVwSmlKWGlHZXQ5ZVdP?=
 =?utf-8?B?RVM2QkpTUytlMmZTdWRqcU1VWUR5NTN2eGpMZS9CNHZrQWhFVTlVN3RqRk5S?=
 =?utf-8?B?ZkFyN2JZblYwemR6dEVOWVJ5WkVFekZuMVBYT3FpTlhvZTR5MzlGNUtKOTEy?=
 =?utf-8?B?dFFWTmdXcThQNlhna0wvYVZyVHlGdVhPMWl0OTQ2N1k1eU10K2RIRE9ET1Ez?=
 =?utf-8?B?U0phWVFRMkpxNWlEcVpNcGN5MWJXTCtwRXZ6dGpFajFncGkrQ1Ztd05JQ21o?=
 =?utf-8?B?RGJzYnNmbFJiK1FScmxsaHpjT3lKa0ZPWWJNd1VGYlhXdVpYd0lLZjJNSWpQ?=
 =?utf-8?B?RlhXQjU0NkRmQ0Fxc2V6V1FmMlJrOEF2VnN6V2NuRk9SVzV4czBUYzB0Zitm?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3623db-2d76-4fb0-00e0-08de0fb7e29f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 09:05:59.0757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghhMM9HBauw198DBjvwm+mVQrKUtHYF8mA7JsqPbmJENBuXo4y4O4nFnJG25qHSUlmw18v7UgbTn3nqCuhiJjZrye4z2Q/OEAN2Q/8nQPMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11369
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

Hi Jonas,

On 10/19/25 5:09 PM, Jonas Karlman wrote:
> The RK3568 SoC comes with USB OTG support using a DWC3 controller with
> a USB2 PHY and a USB3 PHY (COMBPHY).
> 
> Some board designs may not use the COMBPHY for USB3 purpose. For these
> board to use USB OTG the input clock source must change to use UTMI clk
> instead of PIPE clk.
> 
> Change to always disable the USB3OTG U3 ports early and leave it to the
> COMBPHY driver to re-enable the U3 port when a usb3-phy is described in
> the board device tree.
> 
> Please note that this may break use of USB 3.0 on RK3568 on Linux kernel
> prior to version 6.6.112, 6.12.53, 6.17.3 and 6.18-rc1.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> It may be too soon to apply this patch, we should possible give more
> time for OS to adopt to these changes.
> 
> The first patch in this series should however be safe to apply.

What's the cost of *NOT* applying this? I imagine if the PHY isn't used 
in the kernel it can be turned off by runtime PM? So would that be only 
about reducing power consumption while in U-Boot?

It may not be worth it to possibly break devices if we're simply talking 
about power efficiency for a boot stage that shouldn't last long anyway.

We cannot know what the user will be booting as kernel so there 
technically is not a safe date when this could be merged.

Cheers,
Quentin
