Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B60FC5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 18:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC71240515;
	Sun, 23 Aug 2026 18:32:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PT1_0_vorBAU; Sun, 23 Aug 2026 18:32:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787509938;
	bh=mIMor4XFzro2xEudX89/j8jCFIoSG5q7HUiRWJfF12E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gz+PRVlOKOBWXTREjnsNYvKJIky+yE7qVl3YM7o2sKSHlog0QG3LeAXb4MxXIEGFC
	 G1+pFKzXWsCoF+2TWB7DYtWP/09fmFMN8wT8aZRlcgvnq5nvGfLZ9sLPadKeRq4EMP
	 QK/Y1xjXunVxaU49RRQyjYYzrKR7hS8QmaDF7Veg3+/zxvO0257G/ZywvGXBny/y7m
	 PYAJnYuGtalHCUZyFfCphXV6W/zfiveg5MveixN7ZQvhqFo3tTJYZHQEguZU6hrPSX
	 RWbO18gVQu01PBwnNpaxN555Kgn+MgiGgjrnA+NOGHOaRYZSNbUo5WD2/MVt3eGC2h
	 xQtLwx7rF7qrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C05D404F5;
	Sun, 23 Aug 2026 18:32:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 06B97386
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0EF7404F5
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:32:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_CaudN2fREu for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 18:32:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=iFHhksns
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34F44404C1
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 18:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjBYxkOEBmdERxhGdX1H/T0XFDRJgCmJjh3UogGnkQSZ0GXAWxaqlZ8YRnPRF6kv2XP5Q5HHu0lAeSrB3f4gUB/oRirUTU9BLqbrdsFl0avKaUgOAtsoRu+PqtrNQvc6zbtee//YYXQl4S2Mumwl88Ln8xNCNDo8GBMlxV8HzV/5vmeg1zg1eSiS4Mn88mqeXQ9bXknBC6kKVFs/sbX9rPN97WUCnqHS29yJuDni7sYTgVOh4p6SQdHRNxUw1lJO1oIUzq2+0J8FMYb8LlGdQ64OK4o6B2uwf4T5io8fmA4/UpJg30KXj4r1Fy1oqlhBkIdXXPDUkIGrnaCsEA9A2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIMor4XFzro2xEudX89/j8jCFIoSG5q7HUiRWJfF12E=;
 b=ImK4eKsKCmcA7Sdc9uBNcGqpVbUgMynKQ5A8y9eeOSgQkd7kFWCdAUHc7fe2PZm3CJy/F/uxzMOPVLykEA/Zd7csdaHF51hpANJQVwKfdNHWOiALlq5BnaNGQb7xdbnHnS0UliCxisXaLrzQX7s2JbSCFPMboNag6MaBP2zgArZIhRSDFkyb4iamRVg7dVZaEHbQPJir/CvjBdMzvQhb76nn2YAZl+kYjk9oNw8l2Lxg7AVvJsvFaHaOQ0XnHNk0T4RHNIQv8/hI/OKNUWjAyMp4qD9wB7IqpLwEQOhYIKL501ZWUdmBlRKZz17oA4oJv/u/A+YpEgIv0t7jBgL1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIMor4XFzro2xEudX89/j8jCFIoSG5q7HUiRWJfF12E=;
 b=iFHhksnsu9X1CbOPmzAJdk9nnxZCDtnHY1NB/zrTtdATy1qnUvbKCkae64xvy8IUxQKF/VC908UkBaS1Cc1gXlDjV0X5etogqKEdcx/08GAT+/LJHwDzI7oy2YKoN3s2+ykHMSPHeKTVH9mdUNQqE6KHIoQsU8/VakCiRKp9euIvGpPOCoR2M3hUD1pzPvwSEN+73WGCQzIPTHpSnj8X/OtPcWQeIqeCWbNove1rtKfzqLJ1KDIMbINRu/omfl/I2cCUAlz9ZgN4pvc3t2+6YX1xeQIb45cXC2ac/yiXMHx2BCy+Sm17zKu3dmAzlDs22QFp2GJdb4xKfasLF0Urhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7557.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:dc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 18:32:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 18:32:05 +0000
Message-ID: <75fed8fd-cd21-49f0-b539-14389aaed66e@siemens.com>
Date: Sun, 23 Aug 2026 20:32:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tee: optee: Add support for enumerating services that
 only need RPMB
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
 <bfd9927ca141783a9f73f82a10eca75699222e1d.1787304541.git.jan.kiszka@siemens.com>
 <495e9da4-cbcd-40ad-87aa-b8a156dc9022@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <495e9da4-cbcd-40ad-87aa-b8a156dc9022@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bd4562-49e1-4fe9-b449-08df0144d4fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|4143699003|5023799004|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info: xQdc91Bm46Brv0XMmCl8QB2CfZTkFiDK+Khl/6FaEcAxGlc6flRrECXmmc7TGZPV/RS9d1gGyF/x2VQBHdtrR7MUrwzJKORcgDjro/u7ysH72sjxWboawDhKIj5nUxiSWBvxkACiHz+lw0Ywm4c6m4GmsxPB3jIbwLdtncVQaVi9bM4yvb5A31MNfGFHgQ+rCetYfaADBBToR6Kyeokkfg2mWFVsBIAsfh2tmpMGI5ahOwe0bpH7EJ3rGNTXW6s15wZ+MxN8Q28nq40EimSq9FRVQHqEnXNpK4zp5etyarNuditURjp2mcSdwSQ2ccd+lygiQPJgn4vyt1G5GD/fhULSjoP9YB5KyaCwOj0lJ4HomQFuy+zym3e46XWgHL2O9ovtMWq71qmykt3LhHSfbg8iiqATbMGLJkFcTLkz2PaiswdOXz3rqJ54STOPhruqtaYnBU2RCFvnJla5NgWOSa0MStjZcxb13fWc9pFCZdOU24B+bmg/2deEDkendArSCbdJmZm491WVYSJH1Vhq3lu/hNx9CsoF9hKKvuLJXvNr56foT53NvqeXKQA6G13PuLCi4ApNdyf7KXLY7qJQLFjOqpIq7mjUNwBbgz64mrVYfuGj/F9pXETXoKMMb/EUeMNNhe/kjudEs+gvCYs2i7Jjc5fNYEty6IPyR9989p4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxZUzJDeEwvVVo5NjNyODIza3lIdjVzeWV2YjZRTlpkS2tzOThzb2tYcmFm?=
 =?utf-8?B?OW9XWGd2cmNKRXpYekRpZHdGQUowOC9EYlp3cjB1VUZkb09Rem9DeVB5NEtH?=
 =?utf-8?B?NXBzVXBrSm5tcVlqL3RIV1ZtNHhHYjFJWTN2SjlBZkdPTjBEV1NObXlxSnBH?=
 =?utf-8?B?MzZoRFRPdlNxV3RtRGUrRkdUZzgwdEFHbFhpSmxqbUJqb2NRejUybUxEUTZa?=
 =?utf-8?B?cS80RUxPQTVpK2UwVnJOV3FmODNFd0piSkZ2MVBkQk1Fd2w2TDM0bmhhRUxx?=
 =?utf-8?B?Qkp0SDl2OTlHN1FJT0lqYm1jYVBOV0pwOHpDMWhvY1dKakxMdGVCc2hjK2Ri?=
 =?utf-8?B?bGdHYVNLcWxuYWYyWWExVm5admlieWZxWHkvdUUzTkJ6SVJPRWhCUXRJU0xi?=
 =?utf-8?B?YzFnNFF4RDBWWm5Wd3RkTW1lV1lRc1BiSmFDK1pycktVWC8rMDdzeXFwV0VT?=
 =?utf-8?B?aVFIaTJXQmxMYlQ1Ky91bm1RWlRpbGtXVHBmOERSMEw3U1hVYk1MVFJJdWFD?=
 =?utf-8?B?K1dIREJPY3dwY0MweWw3UEdTQ3o3RGF4UlVxUnJSZG9Kb0paWEE2RW40MGc3?=
 =?utf-8?B?dXpCNnkzSHN2MFUvTFdaQ2pYS09mdllWZXRlZUIzdVRhOGxkdjIzM0ZhSmRa?=
 =?utf-8?B?Q3VuRTl1KzBPY0FQd0JlbE5QSkdGRitxTGxnR0c3NmlwM1pFY2FKSzF1aHJt?=
 =?utf-8?B?TFlmM0d6NVZVbWhuMzFBTnJJanFMbTBGdVJQejZsTnFzR2xqL1JTODR6WkZu?=
 =?utf-8?B?MjdxNXFodXBUOXdsM2lhaGZWSnQrRkJxWHhaMWxGeDB0dnVkTDhJeTY0a0ts?=
 =?utf-8?B?ejVHWlM2NVVMTG1OOGJ4cFVuQWdTVThmL29LT2VkQUthUFE4RFdMVFFJY1o4?=
 =?utf-8?B?aWQzTk9vQzkweEdyNitOZ1VXNE5nbGtlM203UzJ6eWJxVjhKNzBuaWpjVllP?=
 =?utf-8?B?ZjlMMnBXNlNhK09EWldaaVFMaDdaWURQRHZYdVREUFk1bkRpQlFTZ1VQOWNx?=
 =?utf-8?B?ZUswbnV0MlZNQjVmcllhWFEvMU9jN0lEZ2daSERnWlhsN2FqVk1Pa0JOTEZt?=
 =?utf-8?B?UGt5Rm9CL3pOS2srRndGYlduejBqRW1YUXdoRVRUVCtLZVZVRGVhYVpMT0lp?=
 =?utf-8?B?MlE4NGI5Y0hLT2VuL0h4VENSaEU2WlliTXYrZTYwU3V6RlBRWUNZSm9TZjhr?=
 =?utf-8?B?bGcxZ1EwYllsYXA2VGV6MnpYaGsyVWY3NnpHZFhmS3BJcXlZelYvYUtzWVY2?=
 =?utf-8?B?OTNYeThJUU1ZWVBHdkxtdldZbXlXUi9oeGUxWWpBMEJuWFhEMUp2NFBXdXF4?=
 =?utf-8?B?eWZRM015WC9hMmtFS3hMSExDdm1QN054MHF2cnk0VzlzN2lxTjZXUHBUR3Zx?=
 =?utf-8?B?MGZGczJtdGNHSzBsVmxNR0Z5MlJ6S3dzbEdlYUZVbWdXRmdWaFZlMkVQUm9n?=
 =?utf-8?B?SzcwRW81L1JGdHY0YWpjUWUrRnJHQU9EU3FEZ2NCK1d6ajhFRXZvTVdLcGxK?=
 =?utf-8?B?U3p5V1BEUzFwdTBjSW4wdGlzbnROSkFIbzV6bFoxQnNRQ3A5eDYzNFZ2aUxM?=
 =?utf-8?B?T2M5YlBNbGNnOU5sMExUN0o2Njg0MElzblJFb29SN1B2Z1BLSkphSkxMSDlT?=
 =?utf-8?B?Umlid1BoU2F4QWF2V1BNYVJuTm1xbUtpQW5CQVNjcUtjMWp1cFBWcFJSNjdR?=
 =?utf-8?B?UVRvNS9pUFQwVHY2WnAwamV5cUhSTytnczkrR1AwY25vT1BjT2NSaUplVjhD?=
 =?utf-8?B?UmFVYWdOTjNTUUExamlHY2RxdTV1M2FnOVN4Y2pJb1U3RUMvTkVxQnZoRzVm?=
 =?utf-8?B?SGdkdGlqRVZocDVLaHFmU2IxNGpxMk1XKzFjZnpBK0hQSnZkSHFLbXhFQlNr?=
 =?utf-8?B?akRud3h2cUZKS2tBYjBzWUhKS3VPeTNkcjRNVEdwaTNkZlpGQ3RaV2J5NEIz?=
 =?utf-8?B?aVM5QzRjMUUrQ2ZJNm9vb3p1bjJneHdEMnhxK1JjSlZyK2Q4SEx5WlcrSnJ0?=
 =?utf-8?B?N0xtUCtXVnR2bVNYYlZTOGdwK3Rvek5rWktSYkN1Q0VnVWdSQ0hJWDMyc1Fw?=
 =?utf-8?B?WnY3ZjlSUjlQNWxFS25jQ2FuU0Y3ZmZoY2Y0NXpiNW5TeURZMmUxL2tkOGY5?=
 =?utf-8?B?Uk93WGE0VEhsSVFJQ0tvTGNkUmxGVTBxeWIwS09pMjJaczdNR002RXpDMmM1?=
 =?utf-8?B?VURoaTFmcjBYc3FFekU2YTI3STJsaGFsVFRFbHpEY1JXY2psbkFGenl4azBU?=
 =?utf-8?B?U0lqek4zMTNZMFJ3VTl6aG1jYlRaczgydkxnZmgyREI1cS9CWjl1WFBZNXFt?=
 =?utf-8?B?OWxNRzRlRDg0OHBRUmQ1Q2hZNDh2NEJDMkd2SzlVcDZkL0wrRVFsdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bd4562-49e1-4fe9-b449-08df0144d4fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 18:32:05.7724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LeUGAIfhKr8l614Sd/YYs8wvjesTE1/jqW2sVrjY4MN8p5SeWQKpS7mCqVXhpdb7KLG3MwPcx+t9F2IpBFb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7557
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

On 23.08.26 16:31, Kathpalia, Tanmay wrote:
> Hi Jan,
> 
> I am not an expert in TEE, but I went through this patch while reviewing
> the MMC side of the series and found a few issues.
> 
> On 21-08-2026 14:58, Jan Kiszka wrote:
>> From: Jan Kiszka<jan.kiszka@siemens.com>
>>
>> Up to OP-TEE 4.4.0, all services that needed a supplicant where returned
>> by PTA_CMD_GET_DEVICES_SUPP. Since then, services that only need a
>> supplicant for the purpose of accessing the RPMB are only enumerated by
>> the new, separate PTA_CMD_GET_DEVICES_RPMB. U-Boot so far lacks support
>> for that, thus no longer finds such services, e.g. fTPM.
>>
>> Perform the separate enumeration during probe but, as that may fail if
>> the MMC is not probed yet, also provide a callback to trigger a retry
>> when another MMC device becomes available.
>>
>> Signed-off-by: Jan Kiszka<jan.kiszka@siemens.com>
>> ---
>>   drivers/tee/optee/core.c          | 32 +++++++++++++++++++++++++++++++
>>   drivers/tee/optee/optee_private.h |  2 ++
>>   drivers/tee/optee/rpmb.c          | 11 +++++++++++
>>   include/tee/optee.h               |  2 ++
>>   4 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index 4d67c948ec1..5600d5a4c7d 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -41,6 +41,13 @@
>>    */
>>   #define PTA_CMD_GET_DEVICES_SUPP    0x1
>>   +/*
>> + * PTA_CMD_GET_DEVICES_RPMB - List services only depending on RPMB
>> support
>> + *
>> + * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
>> + */
>> +#define PTA_CMD_GET_DEVICES_RPMB    0x2
>> +
>>   typedef void (optee_invoke_fn)(unsigned long, unsigned long,
>> unsigned long,
>>                      unsigned long, unsigned long, unsigned long,
>>                      unsigned long, unsigned long,
>> @@ -210,6 +217,29 @@ static int bind_service_drivers(struct udevice *dev)
>>       return ret2;
>>   }
>>   +#ifdef CONFIG_SUPPORT_EMMC_RPMB
>> +void optee_bind_service_drivers_rpmb(struct udevice *dev)
> 
> This function is only compiled when SUPPORT_EMMC_RPMB is set, but
> optee_probe() calls it unconditionally after a successful
> bind_service_drivers(). optee_private.h stubs other functions for the
> !RPMB case, this new prototype has no such stub, so for
> SUPPORT_EMMC_RPMB=n should fail to link.
> 

Yeah, thanks for reminding - I forgot again that the linker won't
resolve that. Will also refactor this to move the rpmb part into the
rpmb module.

>> +{
>> +    struct tee_shm *service_list = NULL;
>> +    size_t service_count;
>> +    u32 tee_sess;
>> +    int ret;
>> +
>> +    ret = open_enum_session(dev, &tee_sess);
>> +    if (ret)
>> +        return;
>> +
>> +    ret = enum_services(dev, &service_list, &service_count, tee_sess,
>> +                PTA_CMD_GET_DEVICES_RPMB);
>> +    if (!ret && service_count)
>> +        ret = bind_service_list(dev, service_list, service_count);
> 
> A dev_dbg print would help here.
> 

Of what exactly?

Thanks for the feedback,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
