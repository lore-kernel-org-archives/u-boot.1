Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F245C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 10:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED7E7608D2;
	Thu, 23 Jul 2026 10:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPnQHr5fG8QC; Thu, 23 Jul 2026 10:49:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18284608CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784803750;
	bh=M/D0jt9149a6b/nZCgfIYxXvALk4u6SRMvwypqY9ruc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYVW0dlkw8gTE2h5rUBq/m4DVcM9v1j8rb3LykeaQfOEBet6ta3H8713rHTJl9Q5J
	 ZImihdzCqpHNjOPrOGsRxQLbPVeZmcSBLpMVOPtF2cg3alFFYgPgILe1wQdrplZpi4
	 AQBzbeEyoGyvBvrSrmaarELlylIwkWsoY8vnOz/QxhWGCJ7+/iMBT8mLW3AerRRQiZ
	 zova/BHsi2Kh4nbxIg0LniAjQ1o2DK4HThIDAqIXP0QLztiko/9mf4ufrhsaed+LdC
	 9nbuWwN1r9D4rRUCoeumrYk056PJYWz2vEPJpenA/csM6FhQ5tr6njYjHGO6MkkM1X
	 Kq016KksODJ+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18284608CC;
	Thu, 23 Jul 2026 10:49:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E47D1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84089408ED
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u7WmgD2IkQgP for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:49:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C84D6408D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C84D6408D0
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C84D6408D0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lR4B4lweoSrmIMd2RZd5BXMoDOVopoxlQaogqPvbckNqYZ+9DOPW4aVBPKpj+fOAEbzwKgoseqJLM3XNOFd4s++v5Rnnp35czWAeVdVrQA4qdmvJsWBo4Rm9uZNTvYFJoCmRxk6duPl/MiKvbwqV2QkV7KYKPkbMK2wZ/PxO/yf+txPCPlMcReGhg4hedl8jTaaSD/k5+999UCw/YQ3Z6wQASB1o4ge0TSAJ3CPVxG3ZqbiBlfFZZeehwC7W7kim3lCwWawOG0RdBCMSdrgXDLLylzOpe3u7rYt21NcRz4bUA/F7VheicMxG33qamtATlJpURdOd1VW8HqQT63T83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/D0jt9149a6b/nZCgfIYxXvALk4u6SRMvwypqY9ruc=;
 b=mhvVH+zTjbS3BfRlwWkt3LB3TLGxhQRRAWPocYfJEVTLbojfCicBS4KoeKKuPuEstm9vT70xCRXl25rvZCrSUmPG4fsEMy3b/CxXH3r5d9pfqSssiOZno1Bi4L962VlvhARmvJ8VFBANpHpliHuLYwWw4wIg5BLacWU2w+dlxW1bAJ+fE/4hMzFZ0k590V2AOxtrox5nntbFeEhmCeTdhF7jD0fhE5EK8N6rqiKlr/pSSRdnVHwZSfn6SCK4BE2JcW9eNs40h4yCAXXP7/xcTRTe4Xuye7No5OwzQBaYDKgvAkPSG5E6KFoLmabDmxeA49hLdsnoa/TfqrDXQSSJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA4PR04MB7920.eurprd04.prod.outlook.com (2603:10a6:102:c4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:49:03 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 10:49:03 +0000
Message-ID: <7d8f7915-f912-4a6f-ad1a-39b151a5d04d@cherry.de>
Date: Thu, 23 Jul 2026 12:49:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
 <20260722194638.1285159-3-festevam@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260722194638.1285159-3-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0024.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA4PR04MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: eb105a6a-51c5-48b8-650e-08dee8a802a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 47c22fKUguzSIP3j1L5tXoZM0tJgsq7P9qvaINqpRLLBOF99SdoiosHU2tQtV5YDGVZ9xbv9fBKi12BvvIE4LE6x6XTQmmSTrWRvKuwBNqrLlQCTbxF8jlru+2v/oW7872QbRwTHJ4TMrismUjpBDHeRC6jlMU50CuCdnh5UKX1QeHfeikxdRgQiohT2M7m+GnmQWwkmEpIQbZhIorNgx7N6UwBzpt3mW99q67GzW2Cq1kn9w1jK6opOs25F6mrjpDseY34+5zUHcuV+7kUUS0jf5nqV2tbKZrbPGLHenutTcluP9ALdvuTC9bOX6LMWAtcpnabooaWU8kkx+NzMIKF+Baanewm5liUHbxHH3uHp79E73DWuTSa4ilmh71I0jctELNa7z/JsgCbJl0cBFsMTNNz9qUDVF2+5JYVOJ6px6+J65LaS3HfgwgjWeEsUp0pnPkgp24GucakI6ec218qh4O1RgGSlok6d7yFvvLtWhfD2kBWahJK/Xk2agR0bWau9odLJiLhTPw6htliSu+bf5hEDolnlyrecMFgz+R681z8fcqLa90yMkj8zYmYbjBIm5k5HYHnIdT4bl+qTAU39MfpbV5d38z+BcMfHf0Hm9Ivc4QRCrZtQut6sexwSmeJUnDabMjWTqQYzUZO5mv5ZoDAC5scAUEQyJYsEUnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBna0Q1YmcwTEQwS2FiTFRrMjFHNnVyTkZPazRNd3VrSlRyYVNiRjIxTkda?=
 =?utf-8?B?WkJETXFINzJ1RXdBSFBoVUcya2NaYUs0SGxHZ3hHVS9vV2xvUTY4NTJ6eElh?=
 =?utf-8?B?OFZWUmtTWFZaS3JodHZncTFTTW5FbFZZUEFRQWNVbXlVWEU2NWRmQXhoYm84?=
 =?utf-8?B?SlhPTUxCSDRFMFlKYzdYZnEyVnhOTUhWYk5va05wNDRxRWw2YTMveERHd0ZN?=
 =?utf-8?B?MnFpRk9uUm5PTVdmRnZnUUtEOElaNkpmL3pyYkxDdXYrOTlYRElJYXhCdzM3?=
 =?utf-8?B?dFdJd0p5VllzMnRjcytGMTdTWWYzSjdlZUlYVjB1bUt4Nm1LSTlJTDgreVZC?=
 =?utf-8?B?S3p5QkZJZUlkcStINGhtQkhwdmdmV1QvOVFQeHg0QmZld2V4T0Flc3lKSUxr?=
 =?utf-8?B?eU42TG96bkozSmNhQVo4N0VSREtEcGpLYnVmZytsZ1BGcUxLZVFOS3A4UlFV?=
 =?utf-8?B?YVZ0UVFQY1NQeHRualB5OXM0dkUzKzh0eSs1RmF3Q0ZISzl3Y2hUTWpZaHhC?=
 =?utf-8?B?MmpJOE1DZG84UVFxMG15Q0JqWWlxSndYa2dETUJBTXllOUhDK0wrdjlYamZv?=
 =?utf-8?B?ejFHZ0VBYjdaY1RSTjEzR1dpZm9aRWV5bVk5Y3JCZjdGMy9DYVhweDJlZGNN?=
 =?utf-8?B?VWcvWTVKKy93VVlsbWpJVWNyMzRuVEdNZVZOMmhjUE54Nlk0UFgrL2hQN3hq?=
 =?utf-8?B?N29SR2hrVFE2ajB6SzhlcGFwUkgxQTBySmpITC94UzEwRjdGTVp6RTdCQWNt?=
 =?utf-8?B?Z0l3cDB1Zjg2YldXNUw4UmJ3ZUZUTmx4d3kxQzh0NVJjcUt2Ui9PRW9VeS8y?=
 =?utf-8?B?dmdDVVhsNllQRGNyNTMyemkrUnl3MVRoVDlnRDUxMlhlUDAwQ0M4NUFkSFVh?=
 =?utf-8?B?c1grRUJSbTQ1MnZ5TlpBaytzRkpyRUY0MU5iT2Y4Z0JPdEpoMXhuK3pBT0xt?=
 =?utf-8?B?RHpvb0tHQS8rSjc1SzNwdkZwN0JaR1BJYm8vM25QeFFRLyt4STdQNFZHYUg1?=
 =?utf-8?B?SFFBWndVMXhrallENzRCdk5oYU9aV1Bwc2c4ZU0zVThyN3NYNWwzTWJCejVv?=
 =?utf-8?B?dTNDMmVncUFXQjkxZGlKWHJNYi80YWZMVExGaWxIRWNvMGY0bVBIY1g5enVQ?=
 =?utf-8?B?bUFYRkhUT25EZXJDN21pM1d0THE5ZWY1U01iM3VLTWRJMHlqQ3JiYWlNSUpw?=
 =?utf-8?B?aFBGYjkvVUQ2WUFIdnk1MmZNbi9na25PZHZKaEs5TWtGSmJ4d0V1bHRHOU9Y?=
 =?utf-8?B?VGxRb2ZoQXRaM0t0c2k1NDBEUStTOEdockFFYjR1K2lIREtITXZ5SjBmWVR5?=
 =?utf-8?B?WTkyVC9udnJUbHFyd0h6YlhPVThieGl6SERpSGREZlUzdmp6M1lHQlFGYU02?=
 =?utf-8?B?Mzg3cHJvWjZRSytEb21HZVFwRWgrMVdLOU91YnlkbTJaN0tTSk1OU3JHekI4?=
 =?utf-8?B?S0FqZXI5RllxNmFZNlc1WGxxeFJLRS9CV01iY0ZZdHI2YlBVc09McUJ1dkh3?=
 =?utf-8?B?WnQ2QjlSOGZxWkV2Ulh1Y2F5QXdQUGZhYTlNWnVPR1hSOFFBQnNsaTc1OFYv?=
 =?utf-8?B?UVdDdzFLdVIvblR5STlTVnVNVU8rNHViTFBKcHVlM0NzVmwreHJjeHRmeDNu?=
 =?utf-8?B?MHZ6QVREUkk0NjRMRjJ0SS9wT0IyVjFLWXlOc0dHUTIzQzBHZWVMZWh3dTM0?=
 =?utf-8?B?K2xSODN5b0dYZFhUaHRXanZPenNJN2w0OUJrWmNTa0xSbHZQdi9EdDRVRFBs?=
 =?utf-8?B?djJCTlNhMVlVY3N0c2p3M1grWS9iY0V2ZmpjUGFIZHFRRFVBN09qSTRVbUdP?=
 =?utf-8?B?eXQxVTMzbGZQcVBtcnZKbVROL1M1WlU0eGNGUlY2TGo3ZXpKVXl5RlhoSnFi?=
 =?utf-8?B?UnQ5cm9ZM05lU2lJYXp0SlozNlI2d1EwcjdkbFZLbDM2a1R1Zk1GZEloV3Ex?=
 =?utf-8?B?T0pSVkE3UXl0RVJIVWtXcUVVa3JIUzJGSFcrNGxEaVFkOXZOUXhnVy9nRStv?=
 =?utf-8?B?cEp2T1FBRkN5OGZ3MkllYlBmZ0RxTzZGenZ4aHNxT1Y5ZDRUZkpncTBhSjhE?=
 =?utf-8?B?aHBROVRpRmxyVGFDWk00aXFJc1EzVlUxMW5HV1pyRzFnTmpubzFwcXVmdGVB?=
 =?utf-8?B?NmRqNWxsMGU3UkE5TWQvQUExa2NGQm0rTTl0NVZnK0RVR2E2bWFIZW5NQThM?=
 =?utf-8?B?clhyQlBWN3dIckpWY2Q0TGlmOXhiOWhGZURBOXV3Q05XUnlaODZLMFJyS1dn?=
 =?utf-8?B?SHBYNGtwS2U1OTlFQ2RkTTVnS3d4NE0vYVZkOG9GWitVSk9GWXZFUUZKM05m?=
 =?utf-8?B?WURQaklZSEoxTlZFTy9OQlBheHdwZjJLRWQzUDM3YzVGQm95SGFTQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb105a6a-51c5-48b8-650e-08dee8a802a7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:49:03.0764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI8QgLk3sHXL43dBzv8xt5/y+PjEU2EzaVu5EWu8ihhoAe24sHrdgjyC12SDVAHDkJ3L8JMAq9M9X5raTLmc54bxQvMJbcYFwS59BuHvQow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7920
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/D0jt9149a6b/nZCgfIYxXvALk4u6SRMvwypqY9ruc=;
 b=GRiqCHZnLcBm0PV4+/1Mo9J7mdEXwKikxDmqFWN7YqzvLOhuzjP0nG7m4u2tEbXU0/VNBTwa/1vPoP3LFLJsd3oWoTcPssCaJROYeEv2n2Oc856OnYsv33rH9FsvJNvwYi91gmeJwEOQlRGnCo6AFcTbHR7534JN15qub/11DYc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=GRiqCHZn
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

Hi Fabio,

On 7/22/26 9:46 PM, Fabio Estevam via U-Boot wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The ROC-RK3399-PC has an MP8859 regulator on I2C7 at address 0x66,
> while the ROC-RK3399-PC-PLUS does not. Probe for the regulator in SPL
> and use the result to select the matching devicetree from the U-Boot
> FIT. Fall back to the original board if the I2C bus cannot be probed.
> 
> Build both devicetrees from the existing roc-pc-rk3399_defconfig and
> enable the XMC SPI NOR driver used by the Plus variant. Set fdtfile
> from the selected U-Boot devicetree so the matching Linux devicetree
> is used as well.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
