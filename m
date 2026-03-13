Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B8C106FD7F
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 05:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 282D384167;
	Fri, 13 Mar 2026 06:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="P2/o+nlj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6023B84167; Fri, 13 Mar 2026 02:43:21 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD8CC84150
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 02:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/GmzkWnNcNCCWWg8ckbcWMBeY/D28b1BO2XO+EeTNxrhp1mUO1aosCyAAXXr9rUvwLfvkjhFHQ41HJPKc8GhsELbF5JijP/q+5nTrW6D0+MMykcps4pY8W5PopG1mSUEPuhX2snj9orrccfJxSa6scVJHzRXxN7JXyPgymOlwZpKB4B/bwQR4XQKcwBqkWl1EQ9GqzZDjxmI2yVK+9ZiDYAobpGabdU2qcBtRF4MzGVuvadx8IRYTMH4VhyP31ZejBsONGlVU83VGz4UeY41GoUGRVnKHL/4nHb7phKRr+SfhMqi2ep6vXkGve5XlzLpHQ/2VDg7HMLwCFypDAezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ggbiTLzpVATJJZPCR8Qqb8Nf6IFD0tVh5gGRdXxSZU=;
 b=Mm46uwuXDRyOgRMyUJZaJbts3yszwDZLx+c3XWqtXsl5+yazVMiIrnD+Mdlx7x3dC3+i3bQolt96KV5VQuvo78q7K78XOaiwy3TxqPp4bV07W++MAxbG6O7QcT80bNB87JWKzngQFflHWN18hBOrIfaaSycspUicbEeckdwhQRVSgAMOSWcFbIICxayrQzD1um3/13UIerhKLAAGMkae+6lv4xfLIQWrDfPjXGhiAxzHCcuON6F7hdhUkpvzKlU9/apr28CCSRWXL3X7Lo8qkVFIocSnlqB3LOrjVNbrK789UE0VMUqjFwnvKmybQC1G4/IBp+7ShVoThqLL4tzHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ggbiTLzpVATJJZPCR8Qqb8Nf6IFD0tVh5gGRdXxSZU=;
 b=P2/o+nljjNiw2J0Mw5PlYKhJ/M/AvAH5KKMRGGGGY3JlYA8c1IPMybI2zE/UGBMrg5s0hmQtrY8wtrpEWlCQ177hyzukg1f/r2Tbxl+PiyFoLbd4JDUwANQO3PmsuKZFsq+BJWds/yumiAHnso//IMHBzz1C8ySaDGAdmYOWIdK4yfwes9SccF7tdS39ZkEhLYemzlvOVXzmpj+VO7bdhVoR7COa59oCJsIZxGI8Py5Gy/UThS5vsTUXLh7maPz8UWo1lQ9um6DA2F9bfTd6qwB8SLaLa9E8oeX92gZzsXIcMtNiyEKvOJSb76WhGGSbbQ1NAWneWdv4+s9vC94W1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA6PR03MB7950.namprd03.prod.outlook.com (2603:10b6:806:432::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 01:43:04 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 01:43:12 +0000
Message-ID: <11fc4ad9-776f-4070-b05a-d5778e1e7b0e@altera.com>
Date: Fri, 13 Mar 2026 09:43:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Conor Dooley <conor@kernel.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, Tom Rini <trini@konsulko.com>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
 <20260303143721.GM1388590@bill-the-cat>
 <20260303-choosing-chivalry-6f892a14eaef@spud>
 <ca14a108-6308-4b48-981a-a0d20b716ded@altera.com>
 <20260303170554.GR1388590@bill-the-cat>
 <9c903855-51de-47df-9551-655aa52b8316@altera.com>
Content-Language: en-US
In-Reply-To: <9c903855-51de-47df-9551-655aa52b8316@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SA6PR03MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ffd9b1-14b0-4208-b717-08de80a1e2d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: IDA1FVqL/bKfM5gRyW34NPZ+EDbmdbtBvzC62cfIMFwgdX3zpZOmEYcXvGwe7qGrBYK/NbcV9z2wOrkzqFr3ouLlCxDByePerMez+ojNmW2lE7dbQ5EhCsB/8UXzPPcHcdcEUx8M06t4CkE8FUiNn8NG5oYNF31Z/XwcRzwSWKY4UyWnLk14VXhLBArX6fc71m18qMzSITAlMzOs5a51wwsPPJ9LwvCeqvp1KlDk8Jegk5aDVtiWOQsQr+YjLFy3OtBVcbRA8sqdk4QLyuMypWTNMJCBQtMLpQ/BLEcUC9zgOgsBwPro8G+WqXqQqKEFY/QmW+qRFeoMjrCdoBzj5+FXFqT/U7Qe9wNBq7yR/KQuZ757GBY3t+TT8KNCntl1sqg8pzhXh8qYkbGuGmQOlK2VEGfgZP+DQJcdKsXnOwSTcc2L90ohXWV/CC9b5BDJN7ydCM4/+Csz2xZGXnvsE0sDRcl1eMjSQV0lJvhT4PdWt3UtuR0NwFr8glVAnfkOHFSMmi7DWWi+EG6+WzFpKgB9QJ4RyNOtj3KUYuGlbzF9P7kHqD1gwNlOia8+mbAz8D/RCbXjyryoC9wCO9pkaeuRZ/mah+rDTpKWZhiY8gAM82AKD1iU3sQ9ctb1+OX4bo7e/eo/2AQn/0ktStqp+HDFPM3j00OR4/dUTg4u2Z33b2P5nsCwwqfIewSSviWT7uh5/PlFxINOmoSWHeLTL9THxNeze0LIa2//oqG9TFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3h0Vy81ZzJnT2tuVm1SUk9LTS94bHdWdXI3NlY4WlNPVnMvc3I0Z3B2di9L?=
 =?utf-8?B?TEtsakUyZVBlQklVcDBXNDQzVUJ4YmFSZkVHYmZSY05EN1ZoTjFYSkwvWXJp?=
 =?utf-8?B?ZThoenorUGxEZ2ZiRkl5VFFUdHBUOElLMlE0NHlyaTRnMkxaOEJQbmZrd1Vx?=
 =?utf-8?B?TDVQSTBuekFJWUtveXdqa0JzNm1nWDBZMHA0dlVleUJBc05KZUo4dFdnQzNR?=
 =?utf-8?B?TGRqS0hGYXIzN0ZzdkNRNjNQSlJRZ2xQRzVHakxxNnNic1BZc0Z6bVdPLzZJ?=
 =?utf-8?B?VXEzeWZ6UUJSalh5ZjdRMXNxMHlGaDgyRWdvK0tHSWdKbHBwOSszTmNFbVVJ?=
 =?utf-8?B?WE8xMmVuaVplRnc1Z2E1TzR2MzNVUTVDcjR6czVUcVhrQ1ZENnN1aktBMGRD?=
 =?utf-8?B?OWI2N0pVcEpzNWk1SGNLK2huQ0IxZ0grNE9ISUl4U0l1VVZLUWV1dDlFYnNP?=
 =?utf-8?B?Zy9rTjFITmZ4U0lNaXRRbEhwbGlEVlpPaWhuTUR2ZFZnVTl5eWJCa1oySjNZ?=
 =?utf-8?B?MTBKejUxVzNOdGdWVFZIYVpVMmQraXVrdTFmNDVkYkNTRHlGUVovcU83S1Q1?=
 =?utf-8?B?N2lENzQrUEpOTHNWWTRMd1p6Q092NmtXUFdaREJZcDNBL05IcDdkSDVFMEhO?=
 =?utf-8?B?ZFBLMnlDdnpTQXhMcEphbGpLdzFJdEhpNzJobW9Sb2hONEV0NGdEZENXSGtN?=
 =?utf-8?B?b1RRcUo3V3poK3BTSGtxN2Y1clFaeFR2aTgrWDFuNW9ldTdWTmpRbTFQNTV2?=
 =?utf-8?B?b2lpT1Q0Z0Z0UHBuK2wyVlNBalNvRXlONnpYUDF0a0Nqd3Y2cmQvb0lwQUxC?=
 =?utf-8?B?eVJFVHRVS25xcGpueUkzSXhvTlNQdXh1ZlhjMG0rUFJpWW5wa2VOdHlNa3l6?=
 =?utf-8?B?ak1RSGllR2UxT0l3dUVLV3MwemZLeTRyMzJQT3J6cXZPMVVlQzRXRTZzL282?=
 =?utf-8?B?N0tIbmZ3Slh4dW9JTGRhUDJGbFJweWYrS1E0RG1hUExWY2k1RHhUamZ6cVN5?=
 =?utf-8?B?WXlHaUs4TW11bExQOHduSnlQb1JaMU50K3NieEFTRFVCaTJ4L3RQMWlmL04z?=
 =?utf-8?B?TGswZnh6R3hoV0ZlZEp5MjducEF3d0xSR0ZLNVgwemlBekw1cDBrcWhVTnRy?=
 =?utf-8?B?cnkzQlZnOXJOc2JTTFhjTVU5bjJmQ0VLY2Y5RXJHdjJ0dVZGR3NITFZnRkVk?=
 =?utf-8?B?ZUxKZEdRaEJNZ01pd2ZTV3VuNEhJbTh3MHlLc0xDRE81aWQzWFB4ZmczbERi?=
 =?utf-8?B?aGdONld5cm5GaW1BeGZaWjdZN3IyWGhuVERJUkprWXlpMXF5eWtpSVY2WDRv?=
 =?utf-8?B?ZW9ZSkU3ay9rWW55clUvZVZrSFlKNWplN1JmL3dTT0pnaGFBOVdKaWRVT0pu?=
 =?utf-8?B?alZSZUs1TGdKamMvRDQ2NTZIb09FSjVmUXhsQURnekhyb3lrTXZtR0JFejhH?=
 =?utf-8?B?UUFXcnVzQjYvVW41TG9JZS8ra08rZ2tDbS9Jc0V5VHVoM09RcDduc0NIQzB1?=
 =?utf-8?B?WWJsNlR1RU9RanFjM0lQeGwyZS9SejUvOG9CczFmRGFVNHpUS2NMSVdkZXBQ?=
 =?utf-8?B?ZjJtd2tPcHNsTWd3djUyYVhaQklsS2xBWWVGYnVmb1UzaExOcFluamw1THFr?=
 =?utf-8?B?dUJUdXJveEFDWHVoMS9teTlVWC9nZXJtekFWUFdSSmd1WFRvWnRqVm1Iaklu?=
 =?utf-8?B?Sk1SVWhMelRYT1JnVnJGY0Q4N0VYWjZSR1M2amovbmFjaDVBd3JIQWdHYmZE?=
 =?utf-8?B?c2FOVDFXcVpXN2pLTEQ3a3kwVm9mVGJPNHVScUovRm53MVBzOHN2UEl6a1lj?=
 =?utf-8?B?M1YxRFhzWHcyb0FDdS9yeEJZQUNZVXR6Yklqa1N6bktNUjNQSUw0cjNDcTdL?=
 =?utf-8?B?dTkvMVR4WUZCTlIzU0N4TGEwMlMyZHltTHpIeWVMWlhGcnhPM1FjMjBDbm5j?=
 =?utf-8?B?ZmkrdzEzR2U1REZDVUFZWm9QaHMxSUZxakZsT1FBNzQ1clpuSkRVNVBJRFho?=
 =?utf-8?B?TzZLUzI4VHAzQ2pnUnJkLzdvcVJqOFVxUWJIR3RQcXNta3h0anR3OStUazZZ?=
 =?utf-8?B?VGs3RmpjcWdBd05mbXJXZ2xzVnpVcEJSeEsvVXpTWVp3UGFXMXpjQ0NHUWxI?=
 =?utf-8?B?Tmk0bDgvZWFkNEtNaDBIekthd0VTN2VHdWVWNFlDRDQ1bnBtSlFpWUVhOWZ2?=
 =?utf-8?B?VHpXMExtenYvM0RXRHM2ZVBoQWVZdUJ1WUFsQi9Ld2hLbXppUUxwNEZ4Lzk2?=
 =?utf-8?B?SkFpZTcxWld0em1ReGVZUUNEQk0reStaa0ZTbURTZzBJbmZGSHFLVlNFYXpz?=
 =?utf-8?B?NXo5Yk01c1ZXaWprR0RSYjN5anJVTEtOM3F3bkVPSkt2d2JBVTZUSkMvaUZN?=
 =?utf-8?Q?lGs4BGE/AvjTwB7A=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ffd9b1-14b0-4208-b717-08de80a1e2d3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 01:43:12.2861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaKSk9DTdp5ef3D447iQKnwJylvwZj1ErsCYWRxEEBAs1w66uIjfCuBKSMuxcYq76LBJRCXPpSEbCCueUGiEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7950
X-Mailman-Approved-At: Fri, 13 Mar 2026 06:37:44 +0100
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

> will implement something like that in U-Boot too as follow:
> 1) Add the bits_per_word in the spi_slave struct
> 2) at the dw_spi_xfer function to resolve for the slave->bits_per_word 
> value and store into the priv->bits_per_word, default to 8 otherwise
> 

Submitted the change at:
https://patchwork.ozlabs.org/project/uboot/patch/20260312044633.29242-1-boon.khai.ng@altera.com/

-- 
 >
