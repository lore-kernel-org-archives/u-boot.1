Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4FDCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 06:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208E5802C1;
	Tue, 19 Aug 2025 08:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="U00SMXd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D96880422; Tue, 19 Aug 2025 08:25:30 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE6288006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vw0uZk4pJyY4Ydi9g7IYU4aRqe2V0Xcxm4plYP6A6/PCEYeLIHlxIgGfLnRCMDjJU9fZeNSmFmSu24aTz2aEAd1YVpXmPjXCuQg/+1pmT3ATREwmZlFc8F1GQb+bmeYFUGu3aRblFLrgruCMHicj73UK9cF5NZThBsnz0hbcIcJL2bJEM6IMJCRnJVIdvpQuWhD4oe/TubDpl/OodAstZCZtOAf58bqb2iFIqDbysIKun+VffaHWvjTYuncp/BrcRcD34/lT5UelEbyGVEwtNJTXTZXU38yvgB2o1k0yuz6TBMhDwib7hsLv/P4UXNcj0D366KJbSbOm6dwLmEexQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li+aNKJwUK5J/D98m3yo2IJ5Vo/5IUMv2rZ0RgMroPM=;
 b=LpfLI1BAYfe45fg3zYn8GwTtaByHRnH4U18VHYK0sDmdj/WQxnDb3jFjgAHpd/P+MhR3mpAmVnFjOVqmUKsS1YGHA8y1WM0vKGtGOsYTvMcLWpujBjXqS4ye10m5j02Cix4q3RTo4BH5ahn/d/O5f+wcozKy6LzUrNgwtiRYrxp3TcWF9bcgcvucjdi/CZOiT6+cGbcip41QLsnbKa1lOZTP16fSbg44cQ38tQtDsErA5PO5Y9Rd0jHKcDclKR0N4MhovC91iOta2XYYkmoPMeNOCgdCxerQz5aibCYaTUQZ1S+AMitJZE86LVVUeOHsv/xWbOiQnoayWPrPkBTMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li+aNKJwUK5J/D98m3yo2IJ5Vo/5IUMv2rZ0RgMroPM=;
 b=U00SMXd/fypnZAjCE9fl3MHBzjBdHXJSPas9zXsMtiEHOrtWHeurLw2v58FtlR/i7CMEk6lpbs2yCfqL1lfR9J6g6bOZgrSLe/QB3igxxheorOaL1ADdcLpFfE/Juw2EyY/l8A5me01bjl063oVPHQD2YdrwX9qrPdGO3hXx6Bd5Y/WPVAkLexvwXSatdpm8ojXrzXrbvFVRUh52gXbSUb91IBJdQfn49n7/BW4SQElc825TuvpJF+RO5axbwBCdEBBim0Bt1MQJxXsp+AlPh9gbamuuHMAdx4p92PFhjamoYcfywrD6nF9S6M1VxAjjyFssDYquq42fXmy1OJhmrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB5P195MB2377.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 06:25:25 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 06:25:25 +0000
Message-ID: <b63a3acd-5d8d-4e54-9f53-873cfd26872c@phytec.de>
Date: Tue, 19 Aug 2025 09:25:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: phytec: phycore-imx93: Fix EEPROM bus mismatch in
 SPL
To: Primoz Fiser <primoz.fiser@norik.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20250819053941.908834-1-primoz.fiser@norik.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250819053941.908834-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0060.eurprd02.prod.outlook.com
 (2603:10a6:802:14::31) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB5P195MB2377:EE_
X-MS-Office365-Filtering-Correlation-Id: 2837b471-4590-4b9e-f4da-08dddee92f04
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0pKRzlIcW8ra2pwazJXL0JTY3RJT2doQVRSWXdodFVVNXhVQmVUWHZINWVD?=
 =?utf-8?B?NXJrN0tYZmNGaEtDc3JtUHlnOHF1ZjNYZHNoRkhIeGNTU1Myc1IxS3gxUEdK?=
 =?utf-8?B?QloxbzZ5SXdiQWxNV2hPakRjeXZBTVp1VVFENWgzZjFXYXJlQTZ2RUJESHIw?=
 =?utf-8?B?QUgxdjZYZVZxQ1hURHl2V0ptZE9GNnN3bnBmWkpUbUc4L0pTUHF2V2xKaEVs?=
 =?utf-8?B?dGIzWi8xbkhTb1VMMG1odk9ZdG5hcVpnOVdDcFRKMmpWTVJQRUI1eWFia1dQ?=
 =?utf-8?B?bWhKcG9LbkxGSnJNaTAwZ1NGZ0tPOTZSTzdqMXU0WjRSMTk4bkprdEpTSDYy?=
 =?utf-8?B?MWhzalpSbmY3RytiMHFTSk1rREREOGRqcHd5QXN2WHRVWWZUNm9iT0pEWmZT?=
 =?utf-8?B?aCtXWnZTYmpUK3JYQmFXUHpyUEdyS1RMVllXNXZ0eWIzYm4yT3lIZUQvZ2V4?=
 =?utf-8?B?Y25jdlJqUFRMVUtnbGNMRXhHQ3NXempOaW1aeGhpRGhueUQvV3gxNXRFN1pR?=
 =?utf-8?B?cGM4OEpudDE5V3crYzcydVZGRnJmVzRqVjg3UlhCS2c4bVMrQVBnTzhYeUVI?=
 =?utf-8?B?cFBtWTJwMy96VGZQYW5yejVLTlFwWmNvYzllN3R2a2Y4cHljbE44ai9lOWxN?=
 =?utf-8?B?M0Q1RHRxVkRmT3JoK0svajk0ZXBUYUZQbVdrdi8wNXFDZTJDZWJYNjZSN3Fh?=
 =?utf-8?B?VDhmbWtHZXpRemo5UWVZNjhkdDAya3VpUnllSGptZVVuNXkxYTZjOThiNlJp?=
 =?utf-8?B?NGpEbkxlVk4rYjJ0MXY3bSswLzg2Vy8rY2VjNWk5V00ybEdhMkNCZjBFWXdL?=
 =?utf-8?B?dlNJcGNKZjFXYnMvVE1PNVlWQnU3ditmdTQ5eXpWRll2anFjcE01OEc2ejZl?=
 =?utf-8?B?YnBRczVoekJhRklTWC9NeEU5emZ1ckRWbVYrM1BBbDExcmNEeCtLNjZ6cGRM?=
 =?utf-8?B?RXI1enZHK2JGQnJQU1o1SFVvMlBES3ZvbVZZcFhHQmNxUlZkanREblkybENi?=
 =?utf-8?B?SlMwdzN5T2Fta2tZSUNCQjN0a0JJNXkrZmZsOGswQnlNa0hYTW5aSTlyK3gz?=
 =?utf-8?B?KytYaTJQRDVNc2NFNnJzV29QTjI4T1ZmUldjeSt2czZvblZIWFY2UXdMc2h5?=
 =?utf-8?B?NG4zT3hMSTVHWHBDNUkvR0JaQ3VrYkptNkloRDZzT0w5MWZpdFAvcnlEY3RS?=
 =?utf-8?B?Nm1oU3lSUFhSQUZRTnRIblllVEtkRDUyRWI2ODE4YzdwejhQcUlJYjMwVUtq?=
 =?utf-8?B?N0oxdndWWU5ORHNOMkhjZlU2VDgzN1NQall5MkdyOWcxSVVxaVBYaE1PbzRl?=
 =?utf-8?B?WFZwcmRzVU05SGcrVDhxUTdwRGhGZytxQTAwYWRIdzArdWNKQWpzRUFIU2gw?=
 =?utf-8?B?ZEZaSEdjaVFhdXN4R1hOUURWL3V2TUoxRVg2eXY4QkF2dE1HSDdxTkwwNnVj?=
 =?utf-8?B?dEFwZk5MdWs0NDRKV1phVFBtdVBBN01qTzYvUE12bUVFd3FJNGsyelA0d0Va?=
 =?utf-8?B?c3hybXhSVk81a0EweE5lSW94QlZlbk80MHVnODJ0cGQwSG5rdXNteUpxOUhr?=
 =?utf-8?B?eTQ3bzJLNG1YU0lRdnhUeWU5Mi9GRFhDSzBsR0FHSkpxd05SanNXdzVqVHVQ?=
 =?utf-8?B?azB5b0dCSklpVVhzVmx6SmJjbG5kYUZSajl2ZG1kbFNYSW9TQTZvcElaZllI?=
 =?utf-8?B?OUplSnQ1U2Mrcm90OEhRRzRqckJObURoTnRiL2w0RlVrT01xM2d4Rit6VVNR?=
 =?utf-8?B?Q0dCNGV0a293dGkvQkcvTjFzYlR6NFBnSkhZSmtDcEJCYWY3UzVPa2NoSEpZ?=
 =?utf-8?B?bmxwanBHckVnVnFPZEJNcVBDQnI0bmd1a0dDdFZUeTNwNWxRYzZZMGR0ZHhL?=
 =?utf-8?B?ZW9GZkM0dERqNlNiZDVCUGpLNjNBL1lsQzBPeWZlOEN3bGJBdHpZUGFWQ2ts?=
 =?utf-8?Q?U9z2xdUjtcg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01BUnpoYlJGOHUxemw3YUp2TlB3K2h0b1MvWmZZMkoyYTRjQWJ0bVBIZEt2?=
 =?utf-8?B?NWZnSlE4L3dPMHhPMTdERm5RS1loTEh6Rk41cFFtQXdnNng4emRNKzNvdGts?=
 =?utf-8?B?WFRuY2tCdnF1VVZTODlJZzVSY2dHWDJMRldVV0ZIZmNyTUM3RUljSFBaeDBs?=
 =?utf-8?B?WHEvSFhOZyt2WkxnSkRqM3QzMzhBZ1pUZVppd2xiKzFINTdXMS9YMHlFMDBX?=
 =?utf-8?B?N3N3c05wRlNQa1hVVmRheEdnZmduM3d2S1ZHYUNEQUhpNVRqcks0ZVRIUW1P?=
 =?utf-8?B?ekpsZDF0ZFRIQWl3amlQbHI1UisvZXl5MXg1dU5keWtmendpZmJxeTM1RXBr?=
 =?utf-8?B?dG5iMlJFR284dVFMS3ZGTDhlYnJyVnQwZmFyRTE3QncwYlh6UkhlTjl1czcw?=
 =?utf-8?B?TlV0ak5Ea2FQbk5KMzhTLzBycEkrTWZZZlRpb2ttWi9IeUhsYnhFeFRNM3Qv?=
 =?utf-8?B?ODh2cVpJR3R5eGhZTXA2TmUwVXp2VS9TaHFWTWtwRHFUemo5enNKWUFvT2Zo?=
 =?utf-8?B?N2JyRzhwLzlaNWp2TU9Xc0xCdGI2cE5HbGhCS0w1cTNqdG1SNWNvblNCczJt?=
 =?utf-8?B?K2ZKRTNwRUFMd0ExbUw5LzJKN0ROUTVoOTUyTjlqWk9McWN2K0VpcFhIeWl1?=
 =?utf-8?B?TnFwZFZ2ZHBRd1RDTEZIdGNpMnhTbEFJMDFQcUxOVTZFam55Vnl2d1llKyti?=
 =?utf-8?B?dnhaV3krekRGekZZVEdzaDRuUC9pK2VyQnF6STZFQVBQZFliTDI0aTBRbC9O?=
 =?utf-8?B?MUtEQkczZ3JSQTNMcHZtQnRSejBsOEVhaEZoWmxCbndva2g4NHg2Y1M1R1dC?=
 =?utf-8?B?NmhWNlIzejNwSkNDN1NBVWc2K1I1Zllva0YxcHYzeEVvZHZnRkdiYW1NNmhn?=
 =?utf-8?B?VVFpZVJDYk1yUHNSaVZiUVlIeGJCT1JzQWVLM0JjR09iY1JRZFIrQmlpYVBO?=
 =?utf-8?B?RW15Q3Iyb1lQNVVaZXpCVzlDaXBXdFRhbnE5eEFjaGFXRHVKdFB5cnZDR1Qw?=
 =?utf-8?B?eHFkeTJ5SlpLcDlrcyt1VFJjN2RuOHd1TmJ1ZHJicDJ0enV0dkVOd2R5dHZJ?=
 =?utf-8?B?eXRjWjZxWkpPUldlNU9OMHM3Qy9OOUtkOWZJTmxVMGREcU0vUmJIcU9Sd3BN?=
 =?utf-8?B?U1RINTNnaWFJK0x3SkF2NmpZVzYwV2phN3pGeWk2TkJLMjVvSUc0eGtQcWlK?=
 =?utf-8?B?M2FxN0dpNzRpUkpCekE4dGQ2WHV2dEFVNzFDM0F6ZkxVYUhybGZSUEFNQmp0?=
 =?utf-8?B?ejhtcFJ5OGNJbXBiZ3hadU8xYXgzd2hvU1FNVm01ZFI0bGtSTDMyRzZDWkc4?=
 =?utf-8?B?bkRocHlJeDBCOUVPZGZkTVlsTmJRMHpDRUwxMlFzT09FTk1DaE1yQmppZU8x?=
 =?utf-8?B?TVUwRlpMTllPUzNSeWhPS2xyUTFHMGwwM0hJM3NOaDNIUmkwYTE4SDZIT3hB?=
 =?utf-8?B?ZzEvME04WGM0cEpXMG9RVUVsdDBHYXNiM3diWmVtSXhpV1RaRHVFZUpXdW83?=
 =?utf-8?B?Wi9PTDZmRGNwa0FDelNsUmx0S2NjK1Q1TnVTbzhGSmIwOTZwa3ZrTnJuNlNU?=
 =?utf-8?B?MFE1ZDU0SEwrSW5ibmpTd3UyRDJrWWlsKzlwa3FFS2thRTJudUNIeTREMVZw?=
 =?utf-8?B?STZpZVVSNThOZ0VEbFowMG8zVzJQMURZeHAzeitQU2N1NVZ2eE1BQUtvN20x?=
 =?utf-8?B?c1hTUFAwblhWeC9hR3JaYzRicTcrZW4wdjdkV1ZCcXZzS0ZsemtZNGFIbVV6?=
 =?utf-8?B?SnRjOUJBRSt4NGNLVlliVXZPa0VrMmhCMVY2aWlkamRXaC9vcUFWb2FlMkpV?=
 =?utf-8?B?VlNIaVZRS2ZVZHZsZmNDdG1OY2VXYnJTU1ltMmV5WERLMzlzUjdaKzFhYVAz?=
 =?utf-8?B?T1hScGRSU2hlSEcwNjc5elFrcnUwbmp6Z1BQZnhhOWhsYzM2eDg2bkNmTjEr?=
 =?utf-8?B?N01WWUt0bjZSSjlRQjY1ellJM3Jodmc4d0xlUXpqVEJZMzFrRnJlYWlBL3l4?=
 =?utf-8?B?dUxqd0dLVEhvVGR4YmJKZXhhOEZjcThSR1lVaWdXdWFhRXJpaDBOanBkNDdW?=
 =?utf-8?B?QlQ3WmtuZDUxclpXaU15ZWRjR2NKbTZKbUh6YS90ZTNFTnJ5dms2Rmx2L1NB?=
 =?utf-8?Q?g0pAQlY8LQ7g//oOBnNbDfHt+?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2837b471-4590-4b9e-f4da-08dddee92f04
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 06:25:25.5290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3mAi0qXlF8VqCqh403oxEDXBkybcoz+LTWrBY/jQlHj2MGH4VIg4b2daWMD5w+7HxC3T2ws2sP9Q1gNTq5z8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P195MB2377
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

Hi Primoz,

we just introduced CONFIG_PHYTEC_EEPROM_BUS [1]. Can you check if it is 
relevant for this board?

[1] https://lists.denx.de/pipermail/u-boot/2025-August/596708.html

Regards,
Wadim


On 8/19/25 8:39 AM, Primoz Fiser wrote:
> Fix PHYTEC EEPROM bus mismatch between SPL and U-Boot proper by enabling
> CONFIG_SPL_DM_SEQ_ALIAS=y on phyCORE-i.MX93 boards. This way, both the
> SPL and U-Boot proper will respect the device-tree aliases for I2C devs
> and use the same I2C bus number for phytec_eeprom_data_setup() function
> calls. This makes code less confusing and more robust.
> 
> Fixes an issue apparent since commit 79f3e77133bd ("Subtree merge tag
> 'v6.16-dts' of dts repo [1] into dts/upstream") where SPL would spew the
> following error:
> 
>    phytec_eeprom_read: i2c EEPROM not found: -110.
>    phytec_eeprom_data_setup: EEPROM data init failed
> 
> While later in U-Boot proper, EEPROM would be successfully read out.
> This happens because Linux device-tree for phyBOARD-Segin-i.MX93 since
> aforementioned commit enables I2C bus 2 (lpi2c2 is used for audio codec
> and RTC) which breaks SPL I2C bus number ordering and I2C EEPROM bus is
> shifted by +1. Now, lets prevent this from happening again by utilizing
> device-tree aliases also in the SPL.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>   board/phytec/phycore_imx93/spl.c | 3 +--
>   configs/imx93-phycore_defconfig  | 1 +
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
> index 7b5d38d438f2..beaa536c6007 100644
> --- a/board/phytec/phycore_imx93/spl.c
> +++ b/board/phytec/phycore_imx93/spl.c
> @@ -52,8 +52,7 @@ void spl_dram_init(void)
>   	int ret;
>   	enum phytec_imx93_ddr_eeprom_code ddr_opt = PHYTEC_IMX93_DDR_INVALID;
>   
> -	/* NOTE: In SPL lpi2c3 is mapped to bus 0 */
> -	ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);
> +	ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
>   	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
>   		goto out;
>   
> diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
> index 6210be646723..af149128ed41 100644
> --- a/configs/imx93-phycore_defconfig
> +++ b/configs/imx93-phycore_defconfig
> @@ -92,6 +92,7 @@ CONFIG_USE_ETHPRIME=y
>   CONFIG_ETHPRIME="eth1"
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_CLK_IMX93=y
>   CONFIG_CLK_IMX93=y
>   CONFIG_DFU_MMC=y

