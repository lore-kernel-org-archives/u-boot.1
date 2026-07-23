Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231B9C531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 16:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C481340A54;
	Thu, 23 Jul 2026 16:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGRl_y9COtuU; Thu, 23 Jul 2026 16:43:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8DE940A84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784825024;
	bh=WOW9Bu8mxVJSuPnQm8bkTaI99UKylLliXcMISlgFzeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m+N45RXuiwYntzh6XBiVl5XNlWTEoZfMYI26RQXQNfTcXhNwL17biPBGWiZNUVsTF
	 bIv9gyG71P0BPLaFwg2BrOpy+KVpUGMz4nGy7YKMtx9jxp1mjyqJCD3uhodzA3JEvi
	 DRk3N06yviekw9UUAv6tG1aIuQiRd69lzpQzrtXFdwQtte7rLguUwjLHZ6GKMcqN69
	 +3kz8cuCKHfkJZA+LQCFO5nqX9BDY1qA1g+BYMPCQkUMDxokGTCynK8rZHL+s30B+c
	 jd3nKLbZ9DQ5uugksr1AweKnIs0MCxlufKavpJz2xQVsLJHC8OO+NcuHJGgAwawkRv
	 Yn+XBLwK6kE+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8DE940A84;
	Thu, 23 Jul 2026 16:43:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E7C5390
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F78E40A54
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e2QKYA8yFBhz for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 16:43:41 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 68C3340A84
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68C3340A84
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68C3340A84
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:43:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1452C80287; Thu, 23 Jul 2026 18:43:39 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB676800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:43:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qb/NS+DTeuWwS76IvAuKxR1CV1eVc//JjxKq6E2yYzyZ6iB8yoPN79nyqNzAzt1e/UZhlv9n6WazAoWVZ/L+wXiKpaXaqSsV4VItFGJ0Qj0WD8qs8oCxdYlDqIrXj7LjT8hVrbB/zfL9iyWrdMo355luXJMeav9nWVTpw/M4ANOtCM92I3qNStzaPkjgmV3NwCOgMCerKMSokBEwai58O6LqcsqiKzsDyl+CqGjFd3FQdbISgGe3uk01CYJ1K9FQaTR0lanJl1rQYcm5dlhzA7x/eV2fL9m+ZARYC4bwN/+HI+aRtFj3tHVaoz78SwcpfXorHhEIPiLG8fQK/Mox+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOW9Bu8mxVJSuPnQm8bkTaI99UKylLliXcMISlgFzeY=;
 b=aEIgpipGLGyAFVbOm4l4/DfMOzvSlCsso5xhPG12qr7Lc+CV47wSE159VnM5/GWJ33mtHr7BBa9Bu5vPsWwq9GLbTtVj3QBqLGkqwL+lCAAaL4FOb/d8+7mvlPd6f+JNwXe42dWfEbpwv3CP2Gf/CGc4W2rQJR6W7OndDEGX9Kzye6mrc+bmU42BlLQiC36Y+amCZSQRBma9fb7cuPRfLn6flrw/SucqaVwSTy3JlBPXHGL2RQ3B911K7goC4I1Wm3phgdBHBmiTbQJU9+W5F1NNfhevafowWnsBIbMxiRqH45YRS++vUBc5U3glT3YayTycq9GsktzVpSTRJFsW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DUYPR04MB12692.eurprd04.prod.outlook.com (2603:10a6:10:65d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 16:43:33 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 16:43:33 +0000
Message-ID: <90e62165-aee3-4e36-bd1e-3d5cbb991f11@cherry.de>
Date: Thu, 23 Jul 2026 18:43:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] reset: Print reset type on diagnostic console
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-4-dmukhin@ford.com>
 <4946b40f-21b1-4a48-a01e-6f81548aafda@cherry.de>
 <CAFLszThwW5Ff6JjCd+xX-fKR6phTD3ZoqtfvS6+hXRc-cH1Oeg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThwW5Ff6JjCd+xX-fKR6phTD3ZoqtfvS6+hXRc-cH1Oeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0052.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::12) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DUYPR04MB12692:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a710a4-7638-4a9a-95c5-08dee8d988ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: smmFfjNoT0Hs0ZGyruGAcFNeKGaofTKEsQwPlmlIiUg6G79KzaaGjcwg+mSxUIXDlZ/Y3RbeCicjF2B01lcgTI/GGZYqDF+ZrBv2zfJ3ct9hrFPFikY1kf1OwgR8WZQeYkzSsTnDGOTUkAHAJAq1/lR4E5uZOC5ZnT1eq7xGYGEWRFLHUOEIY5/bKTDncTa6v5OdY491ov8I3Z6glgspDbfLP8+Wn+zT364mCKkski/RFdGwfgCfwBoSiIn8HtX/TN0paM7kmPwljvYEEVzfbgqTeOFLeQQy+lZVCvAM987BK3AwKFFxyXVCgYT3KpZnVxnjtnjgiVVPAJMizoSUaHno/McT6zxpahxU3S1SAb+dS5wxcluRdloYNmU2nNbf0VH8uAaf5Y29DFQ3DBQZz4U2OwU1nbST1l/Bf5R7NULAWcbMhC++JWZ8HnYvRePtTe44iaKY0FXSYsNgK57kjBgwJvZJf5ysSjjro8KaxnO/CJTpKmoHEtuHtLDC1LBHQaDfcjLTJlASTj/G8TWtiAi6TUcQmUHob7ElgPQvCKtbYzqOPT3hx6LappqqiE2ER3/WumQ/IMRssL+fU6NR91/KS1aAHV/vcWO37/LphOx63KqkojlntOCAJsahgf38kvhoLOzMZQqXSX2w7ao+F34ZfBFfVAYOnO8Q7S7RcwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V201RE9TWm5MNnhGc3ZNNjhJWnJjZWxXM05qY0RVdElibXV1OVVQbk4vdktU?=
 =?utf-8?B?ZmIwOS9aMEZ5QURnSVdmRFB6b1M2MUMzSTlob1ZIeHdnQVhrVCtGN3dYWHlG?=
 =?utf-8?B?OG9EMy9WVU01TUs5ajdkYXhqcjVPdkd4bE5kdDVyUXlKblNOV1JPY3BKOFhv?=
 =?utf-8?B?eWhtQlEycTdYRmRGaUdUSUtVNThzYWdqSFUvVmduUXpvazdyVHF5ekFBTklG?=
 =?utf-8?B?VWNkbm13QWwrMjJlZGcvNERtSCtabTFkZVJzZWN4N3dxOE53czNBd2pDcHQ5?=
 =?utf-8?B?MVhaZUFDUTFkUjR1eW5GZ3RVaHJDbDV6ZTdFTjNBTjljU090S1hWUVZ0Z1Bj?=
 =?utf-8?B?NHNTZWI0L1Boc0xsUS9ldytsUkhsYWlxQlVrcW9CYkQ0czJKSE9qR3FXUGhT?=
 =?utf-8?B?Ymd6Qm5xeVBlYTFEaEQrdGRYSFNybG11cjlUVHVUQmxSVCsxVkRJRWEyZDl1?=
 =?utf-8?B?M1hsbWg5dm1QanBHRGpSTzE0U2ZzNjI0OHRZbEo0V0poTDFldmJFZFlsWHBl?=
 =?utf-8?B?OWx6UjAxN2hwUzZMWm1hNlhROFpwWlY5MTV5OWZPZzhKWExHS3RUQUJpbzdH?=
 =?utf-8?B?b041cVNhYmFPN0lyeFl6ZmJhV2pCZWJ1OTlPWG54Sm1qTGF0dEJhQXFHb0Na?=
 =?utf-8?B?NEJYbGtqM1pDVWFldlI0ejZpeWpLN3l2d0ZaZCtrMUVyMXo1Qks2c0MzYmJn?=
 =?utf-8?B?NFQ5UDVsRWIyMC9ISE9HNEFqWmxWYnRCRlZsUU5MdFpTTzRUOHpNb1pmODAv?=
 =?utf-8?B?dnVsQUV2aFA0aE94dk5jRmlpTVdtSUpjUGwzTEJHeXhwVjlCL3d1Z1dnMXht?=
 =?utf-8?B?TUFLWE5XUHZuNVNMZkR4YWdLb21SV0tqL1BCL1hPOFhqSVZGeGdGOXNVaFk2?=
 =?utf-8?B?d0tQemkyOHFyc005ZmI1SmxPWU9rK0c5TTd5cEdpY0hIL2RqaWRWQmI4bTFE?=
 =?utf-8?B?YVFBMFJXQ0EyWUtoaHRnSjFMNkgvTUYvSkNzTkw4RTRwOW1mZXlvQnI2alFC?=
 =?utf-8?B?SjZyVlBpZ3VtNTZ1cUFjdE5nSHZQZmJERGFHS3NpNzRIcTd3eEVvSnNZdDhi?=
 =?utf-8?B?anhHUG9XV0V5V3hXb092YWxOUnlRZHRaeWF2SzdHOHlldzFMay9DWFVtQzlX?=
 =?utf-8?B?M0NvMm5IcThFSEl4NWdvTDRKdlJkdXgzVG5VRVFJUHpYeVpnRkRSYmMxQm51?=
 =?utf-8?B?T3lmdHRranM5QkVmWmdmNnBUdWZMb29YMm9IWUloUnBTamg4dVBMOTlNaTRi?=
 =?utf-8?B?OXZPNnFkZDNNd1BvTDhmeSt1N1hWbHRQUzRXZG9ISzVDNlFzVXVxUG5pQjhN?=
 =?utf-8?B?ZU4vVmEzejIwTnRRb1gzZEp5OHlaWWV5a3V2TkJ2NHIxNWQ0U3dmNEdmVG5K?=
 =?utf-8?B?MTdaWVg5SVNscUN3RmNQbDYwdVYvNS9wcVljQ0trUGVOTHFGUnczdHlkSjRG?=
 =?utf-8?B?L0dqU3JGbkcxY1o1YW9HTXZtL0tDLzcvS0czZHpkeUF4T296RVJWRlJEakFY?=
 =?utf-8?B?SngrMlI5TDhWUWN5ODExYXgvTDZCVjhtN1VsbXdKY2wreVppK1dLTEVDVVpp?=
 =?utf-8?B?aTdiVTJLcjhMb1ppSGNWL3hIcytFUldDVWdDRDE2cThibmxIdTUrNzBJK0Uw?=
 =?utf-8?B?Uksvd2t3anFnNHNKOER6Z1Z3OGVQUUdyOWorcWhHN2pGeVgrK1pDeFFodWNK?=
 =?utf-8?B?RmJLSGJ2ZVNDRjVJRGc5UDJKMzN2bHo5dUlVc0tZVHFaZzBSekhXSDZJSm4y?=
 =?utf-8?B?YjE0YkhRZzVzWHJGOSs1SkVhL1JTSWlSb290NWVLejlNWTRhRHlSYXg1RFZy?=
 =?utf-8?B?SDZIN3AwclY1UG56LzdBeVVCM3BsU2R2THFXNTVwMi8ycVdBeldKdENOakhP?=
 =?utf-8?B?em9BdklxVXBXbHZDdG9yc1BtV0VSKzVVVWN0ZUdLc0NYdUlFUmFFTVN6ZWtk?=
 =?utf-8?B?WGR3Szdad0hvTTM4b2hac0R3RUZLdWFzcDliNlRWNmZQUUtNb0pJUDJUVk5B?=
 =?utf-8?B?RW81L2U0SkpEYWhqU1pCU3VYM3FPTTI0WFgyMFI0QnRwUnpkMDBMT0J3S3hU?=
 =?utf-8?B?dmxmV0I4UTZWbVd6L3B6bzFTZzlYVE9sNUtrUEZ4eEdqMDNpSWQxWlA1YVVy?=
 =?utf-8?B?ekhtRzdLSy9XOUdDVkhKaFEwUXVoeDdwbmtCcTB5VXV1UWxzRzQ0SFJEN3Ux?=
 =?utf-8?B?Z0U5Y2dneWsvNzRwbFlBTXpkcEQ3TjVYL0hRK1MvVjRmSVBZdEJ4dk1NR2ZW?=
 =?utf-8?B?VkM0ai9KOGlVR242V054WGZpS1hnMHpMWThINVlKZXZCMU80aGVBQXNGbHh6?=
 =?utf-8?B?QWo2aXI3dlZzZEFnWUhWYktyOVRmUlV0VzdVR3NXeXArbVRvRjNRQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a710a4-7638-4a9a-95c5-08dee8d988ef
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:43:33.7460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkNySa9nLkq4nxlOkAl9BjMMCSc7GlBKKA2AHpE39/sf89gqOE2nhHebLXI9vTxipD8sjCK6XIZLqdP98j5Ag7YUZmfW1UKclByGISXNnKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12692
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOW9Bu8mxVJSuPnQm8bkTaI99UKylLliXcMISlgFzeY=;
 b=G7LgFz1gC4LNnSj5Gpfp03mQDpsG7aXXZVk5+4PI7+GQgHf7EXURP6Eb+avj1tyTgS2hnnFMPo7gunQPovv/yPX2zOPD4ERvZ2H2IPrWH+WbddnPXCQXBDJkr4+zaAjQO5tw9PoG/Rfo5B9cV+EyWVJHfk1nPtnAMQn+7AO1fkk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=G7LgFz1g
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="G7LgFz1g"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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

Hi Simon,

On 6/27/26 10:30 AM, Simon Glass wrote:
> Hi Quentin,
> 
> On Fri, 26 Jun 2026 at 16:01, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Denis,
>>
>> On 6/3/26 9:07 AM, dmukhin@ford.com wrote:
>>> Add a diagnostic console trace indicating the reset type.
>>>
>>> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>>> ---
>>> Changes since v3:
>>> - moved get_reset_type_str() next to do_reset()
>>> ---
>>>    drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
>>> index 1ba698b37285..2b7717857ce6 100644
>>> --- a/drivers/sysreset/sysreset-uclass.c
>>> +++ b/drivers/sysreset/sysreset-uclass.c
>>> @@ -161,6 +161,22 @@ static enum sysreset_t sysreset_get_default_type(void)
>>>        return SYSRESET_COLD;
>>>    }
>>>
>>> +static const char *get_reset_type_str(enum sysreset_t reset_type)
>>> +{
>>> +     switch (reset_type) {
>>> +     case SYSRESET_WARM:
>>> +             return "warm";
>>> +     case SYSRESET_COLD:
>>> +             return "cold";
>>> +     case SYSRESET_POWER:
>>> +             return "power";
>>> +     case SYSRESET_POWER_OFF:
>>> +             return "power off";
>>> +     default:
>>> +             return "unknown";
>>> +     }
>>> +}
>>> +
>>>    int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>    {
>>>        enum sysreset_t reset_type = sysreset_get_default_type();
>>> @@ -181,7 +197,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>                }
>>>        }
>>>
>>> -     printf("resetting ...\n");
>>> +     printf("resetting (%s)...\n", get_reset_type_str(reset_type));
>>
>> NACK, this is potentially misleading as sysreset drivers can end up
>> performing something different (see sysreset_walk_arg() just below).
> 
> That's always been the case, but it was silent - do you suggest that

We only said we are resetting, not which kind.

> it prints a new reset message for each type? Bear in mind that when
> one succeeds it is unlikely that the serial console will be updated
> before the reset happens. In the majority of cases the requested reset
> succeeds.
> 

Indeed.

> I quite like showing which reset is being attempted.

I don't think it's worth the potential confusion. After all, we may very 
well NOT do the requested kind of reset. Wording will be important if we 
really want to do this. We need to be clear something else may be done 
in the end.

We could print before attempting each sysreset type which kind we're 
trying... I think it's actually a good idea, because it isn't 
necessarily clear that even if you request a warm reset, you may still 
get a cold reset (or even a power-off) if no driver supports doing a 
warm reset. At the same time, we don't have a delay between printing and 
attempting a reset, so indeed like you said it may never get printed.

So, first line in the while-loop in sysreset_walk would say "attempting 
sysreset <type>" and after the for-loop we check on ret != -EINPROGRESS 
and then print "no driver could do sysreset <type>, trying more 
aggressive reset" or something like that. Before return, we check on 
-EINPROGRESS and tell the user we failed to do any kind of reset. We 
probably should have some of those messages rather debug messages 
though, I fear it may be a bit verbose.

Cheers,
Quentin
