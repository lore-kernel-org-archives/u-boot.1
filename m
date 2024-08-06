Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1791FC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE9288A38;
	Tue,  6 Aug 2024 16:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PF65zyYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C88FF88A85; Tue,  6 Aug 2024 16:47:10 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E181188813
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDGmX2EyX7jFFWzgTXapny8iLTBrSXcisXF110oObCtRcp7vHxn0/T0Jn2K7Kk0DJg/04gnZAnWKQ98NYdus5aqBiJhTRjwX2nDK+NlPkT4G9zXYyUZqgEEIdDJ37XDQ5AHoBCRZt5fqUhlkAPwQGqoerNJucw/yRjDJfeXA+9LVjX8Am5flxm1fyy4pdHCJtixj88xZQ8eHW3FIV+XxbQ4/5y3PqXb5dnLH9ZqQJMnLd5tx+PtuuWjgmcm3PrjT+SxpoxpvDYPZs97sVocrRkquO1tZrXBpxWaTXX/N3TGl9DkDWltdT7A1cjETK7nDfeDKtvxz2nIJutqWWHGF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8tP/b9+oHI209o1P1fpOhZdpXHGp3bHmUhzH6nUQDo=;
 b=J9L3+m4WwqYHO1V3cuMUiZ3cbwgI2rbPQ/hjCTPL1QE3GDSpORJKe6gHZvGzUOMCfry/4xU+PMuFFfRRjv12knW5mMcGoFpiD/iZd1BaBGBdYLDed5wgVKj17jzkRQmOj0lcuvkSB7Fb2BwdtjJi9oApMbw/FyHpvTo7QkyvyZ6SZaUqIflpNZ42Uvvy6OL8BDz99Cfa2daNFpry+xzCr6rJYw67QLpgQNPsnHAZrPQJ1mxBo8FFYRnNLw6xMxPLVidxSL2jSiuNQcPBXnAd1b/yyc772wsWOa3fgdBUP4uHtwJpLLiH97RiCQ/0YWi56+kdfxUbxRpddNPWPdiMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8tP/b9+oHI209o1P1fpOhZdpXHGp3bHmUhzH6nUQDo=;
 b=PF65zyYlLQh/09ziPyw+Z2udrQ7+eIFvbIWoMzrXGnfrPqIzz+qUHoveem9c9+firTNO/1QJ6eX5lNsJpIaEU/Qu0OnGAe9rqAo/0+L43kq5AMDxEAp6P0/YyYNQG208wp3UMjxCVlLAzSyrEgGy9rWKRmGzD8Q5ZVZPYT6/xng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8374.eurprd04.prod.outlook.com (2603:10a6:102:1bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 6 Aug
 2024 14:31:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:31:40 +0000
Message-ID: <ed51012a-1123-4938-96f7-fac520c78d6c@cherry.de>
Date: Tue, 6 Aug 2024 16:31:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] spl: mmc: Adjust args of spl_mmc_find_device()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-11-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-11-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fefa95-a8ec-45d1-b517-08dcb6247c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MG01SGllVjU4M2JDcEgrNWdDSHZUWjJGdWNDZkpSZFRMY2RVNHQ1cy96bk1I?=
 =?utf-8?B?azZHWnJVYVd6NFBMM2xCeEUvdVZMYzd0bGE5WkNhUnp4enFMZzY3SEY2Nnlu?=
 =?utf-8?B?M0d4KzVxUk9scWMyS3UwbFNRSzV2aUJqSGxqNEhPVDZHaFJUeS9RNTN3TktV?=
 =?utf-8?B?emhKcERPL1hYQmlqKzdNdDlLR2k4Tnd0YVd4anVJWHNIbTh4MTdDRDRHVXI1?=
 =?utf-8?B?eHNWMjMzd3ZNemh1MmYxZHFLZ1VsT09iWFRFM0h5MGhGY21NbjF5a3JMY3Vt?=
 =?utf-8?B?cnBqVnNCcTdNT0hJdDdhVHlQL0ptNkxTWHFJZWhVZWdERWRtNENVRXJhalJz?=
 =?utf-8?B?ZWZZQzVwKzZ1enV2bUFXRjBCTGFiVHhUN2R3V1o4SDEzWHhkbWgzcmpJKzBO?=
 =?utf-8?B?ZDJMRGF4c3ZORkdIWWFsMWFWMncxb2l0UlhOUlNzNGFlaDlZUTR1TmRvdjVR?=
 =?utf-8?B?L3ovb3Qva1NXUmhKLysyU04zamFsbFlLMVg0dC9rNWVlZi9LNFFuODdlS3VX?=
 =?utf-8?B?UGpaVkdMV2h4SlBZNVdRTUJONE00RGFCcll4ZEQ4c09YN0dWQlg1WEVkMmFL?=
 =?utf-8?B?aFNYWlYvRENMTlRycUZqbERSVTBNckY1NTNsYzZFVFJxd2ppZXRzSDRXWEll?=
 =?utf-8?B?RjE5Ym9jTmk1MDhyblRkYlFROVRZWkpGeTFDMFNVc3ZuR2p4Z1dTVDJDeHY0?=
 =?utf-8?B?dkFURzNzcFdSOVh6TDZtWkZDUUVjN1VjSzgxbHVkb25oeUtEYXZzZHdUQW1U?=
 =?utf-8?B?SHpCeng2RnVXOXNqSDhjKys4aXFUQ0ZiRTZuZXMwbmdlNXhGRmg4MXFTKy9R?=
 =?utf-8?B?ZGFVTEM3dkVIWHBhRFBWdXZscUZXWTdvKys1L1FRZ1pVZEFLNFBrMjBRSk1k?=
 =?utf-8?B?eXh4TUorU0pQb3hWbTl0Q1d1bnY3T0dsbmk4cWc3MTYvdlFseEZHcnBuSjZX?=
 =?utf-8?B?Z1RDNEViWGo1dXdxbVUrdU9XU3FIOTRFMFpZYkRFWFBjSGE3eTcxNHNsQzBn?=
 =?utf-8?B?WDZ3OFVKaWF2SlpKdmJ6cTVZUUZrSHhEdmxsV284d3ZQc1dnTUZxMDlSaHhR?=
 =?utf-8?B?b1RPS2k5Sm9talJzekEwMUR1UEE4akR4UEhscjNKc3ZHbW94WWhiWTgrNEl4?=
 =?utf-8?B?dDY3WjhjME5HWjdoMXVSUEhKdXJZWm9FMlVRUytUYkJFdm4yTEdMS0lHcExQ?=
 =?utf-8?B?YWt1UXJlWDNzR29UTXNRNVkyZzlOalZqL0s1bTdiUUoyNGlZcVgvNk9KY201?=
 =?utf-8?B?enJrNFpqWTVQTXNad3NrSFlTV2FFNmZGSkt2OFYzczlTR3hRTlNUdlg3dXZu?=
 =?utf-8?B?T0hHTDdFSFRFeWxqNTZBQm5CdzFvUmYxYXVJVG1PdzliVzNJQ1NCUFcvaHJs?=
 =?utf-8?B?UDcySERLOEtpMVhrcFV3NDlWdVozR3BFWXFrWjhHZ3hWMVRNd0pRKzNIMXov?=
 =?utf-8?B?WlBYRGZ4M0pLVC9tdlZycWlaNmtOWDhjK25yMHNRZjJHd1M3NGlHYzVKUUpT?=
 =?utf-8?B?RDI1cnprQkhremQrSlN4RUVsa2kybmdjbDRsemhGS0xjZjdMWktid21rb21L?=
 =?utf-8?B?eUxmeFBEWVF1Zm5kMVBpYUZYL0ltVlFsYnoyd1gvSlZmWWQ1cEpNL0d3dnRm?=
 =?utf-8?B?VkJuc0U1dGYrU1E0dytBOStTN09YNjExTmhQS1RvaUt6eDJwcmhNenArL3Bx?=
 =?utf-8?B?Zkk3UWZ4b0xEcElseFpEUElmRC9hcXh1SkpwS252VTBOQ2lWU0pZMkRDcTIz?=
 =?utf-8?B?TlBHaUJnUHFqVlpVUWhjMlZVVy9ORlcxMU1KK3M3V3c2WkNxbE42QmFlSEJF?=
 =?utf-8?B?YnU5STcwbFpaMDBod015QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNHMFl2MU5jNTJBVjFWRXdRdFcyTG96OFpLeE0vaE9lZHJCUXZPeCs2YW5M?=
 =?utf-8?B?TFoybTVuK2tXcFBFam4zbllScnR4MXNnWXpxYXlLd0txczFuM29sckxWbXJY?=
 =?utf-8?B?TDExZzZITlFOSXBOdEVhbWNDbWNhbzExRW9rbVI2ay9oZTlrWlBVNXpJS3Jt?=
 =?utf-8?B?d3FCZWN3QWl6WkNXT1g0M1llekRKdXVEWG55SnJDZm1uekZxTmdpK3pIdHZS?=
 =?utf-8?B?REZIVWhGNlBiMmRCbE1oNCtVY3gyQThXcnpQb3g4djVXMHRTS1RNNmNRRk5i?=
 =?utf-8?B?OXdyc2t4dm5iUFlXT1JQWDlRbUZNM3dHOW1UN1BCQjZQbGJmaGpSU1pKVlIv?=
 =?utf-8?B?MHcxVnlQWEpiRmhoUDBIVE1Xdk80VUtKWnRmSDVkMGZKcHh6cEpqNHJ2Ujlx?=
 =?utf-8?B?NzlFdVFSRUVMWWdFV3FUeHI5SDg2TUFIMnkxSy9ONXhFeUN2QmJFeEJBQlp5?=
 =?utf-8?B?UzN3N0RHeDR6d29DNXljQk5tSUF0NkViYkI2QWx5M2MwUjU2NE9VWFNzOURL?=
 =?utf-8?B?TTlpcEdlTGs1SHNOYWdxSkFmYlRYa1lNYU5NeC9MbnNXckNYaTljNFprdEhz?=
 =?utf-8?B?bitWaFFvUmxLa0pSa3JxS0FsM083aUYwNi96dWRHOFNKLzNxbFNuMjQzTmwv?=
 =?utf-8?B?YjB1TytScE9FZVhuTjY2VUdvUTBNaTVTUDRyTzMxQUw0Rk1mREJTR1hNQ1Uz?=
 =?utf-8?B?clpSR1EvTENUMVZvR0hsYUUrMVRFOVY5bGpkL01mOXcvcGVLZ2xFS1pPbVVv?=
 =?utf-8?B?Y0ZZeFF5TkN2V2dEV2hQdnVqVUFYWDlrc0s3WXVJbjZ0Q2Z0a0V5VjAzL01y?=
 =?utf-8?B?YlJaOGF3N1V5cm1yeFUvSnBSdFBkQ1dnL3FsVTA1WTZPS3R4Rmd4TldhUndo?=
 =?utf-8?B?SU1tWFFHV1NyaFlTNm81a3JGWlhGamI1TDk4TUNwUnRycEtzU3V4dm8raTFp?=
 =?utf-8?B?OGRIOHpxWGRLTWFsdW5ScGtHMlEzOGdObHNhSnZPcHRJcERhUElLcTFEMEpv?=
 =?utf-8?B?NzhJY0hPajdtTTZBMDNpY2QxdUxRNGl1UEtuQm5XRkdZQ211dHQ0WjloTXp2?=
 =?utf-8?B?MUJMSndETGVHSHNhWDYyZDNoaXFSSUxpbW5PRk9SM084OTVRa1krcUE5VUlu?=
 =?utf-8?B?UlpSekQvc21QNjcwL0hTQWd5UnpCOEZlOWdWUjF5UzJWTlNKQnRMbytZVFNR?=
 =?utf-8?B?T3Uyd29GYW56V0d3aWdjWnNmMFBiNFB4SUZXYis0R0NpVmpmVS9jSzJvRjNS?=
 =?utf-8?B?Ky9aMVd6R01jUHZzNGdTVzZ5N0tWVDFRRThzMlhveUlKb1BpdUpIUUFWSDh2?=
 =?utf-8?B?VUZDdzVwSzV6Qnp2RzR3eVcxcFYwNEQ3Z3VjWFZXRVFHQU81TGVrNHJlMTdI?=
 =?utf-8?B?YTl4emNBMktrak0zcGp5Rk1TYmtMQUxjMUM0OWN3ZUJSdHg1R1VDSUVWZjhj?=
 =?utf-8?B?UTYzZmNtZ0FOWldiQTBhNXFqZ0UzRmQ0a3hqN000RFUxMVVVc1dySHlJUEo2?=
 =?utf-8?B?TmNscEdkVEdLb0dFeThmTmdNSmhhdmNHTFg3amR5dFJHQmhpbGFmNW4yemV6?=
 =?utf-8?B?VzU3RVF0UzJ0S0JFZFFHVE1Tb1VnZW91NDJzY0wyb1h2c28rZHUzSytpQWkz?=
 =?utf-8?B?dzFlRjE3SkgyWEpUWjRaU0FnM2RPUmJIVGJuK1BkbytaejgrVWZkeUxLQUFX?=
 =?utf-8?B?bGw4Sjc3RVFocmhJQVVZYm9TcEpSWE5UMG80aU50WGw4VStZRVZQM29mYXhE?=
 =?utf-8?B?RFNRQ01oMVBRRTBLRWJnUFRPazRCTW52NnJucW90MXNtK3k2eUl4ZHprL3dM?=
 =?utf-8?B?ZDNLSGR1Y1BFKy8wWGM3enVNWmFieFZGTUhzUlptR0hETDMvZWpvRElmMlAv?=
 =?utf-8?B?UkJOM0UwbmtOTHBrR0MxTGtsUUFWdUl4Mm1mb3JGTXBPQ1FrU21qbW5DOUh6?=
 =?utf-8?B?YU1yMy9XL0J4YUJVMi80TVNidTQzQ1FtM3JjVlpvUkdLdk56bGZiUTdlRmdQ?=
 =?utf-8?B?MkFxZHo3TURaOVZ2cnlwRlR0RlZMdmw5ZkVrdm9pUFJxanRrQTZQTU9vb01t?=
 =?utf-8?B?UDNFSUlkV0JZekVjcWkvSENxQkxwTGlRelFoMHJDdzZBcFBBL0t6a2gvNWMr?=
 =?utf-8?B?dk8zelBCWGZ0cWQ2MVNCbHhTN2lsYWFWbUtJbGE0TTl5dkQ0MTJlZGk5cXpO?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fefa95-a8ec-45d1-b517-08dcb6247c4b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:31:40.1989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4R8mfioDnxHlUR/mDhyA14TUb8fgBtujfhCUQfbXi+Na2lPS2eOqjzdg8H0SPoaq8gZyS4vgXjpMoNpLx3uZu4TBcFhLVDYBl3780XLt/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8374
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

On 7/21/24 5:25 PM, Simon Glass wrote:
> At present spl_mmc_load() is the only caller of this function, passing
> it a boot_device, an index into the available MMC devices. Pass the
> device number instead, since it is known by the caller and simplifies
> the code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
