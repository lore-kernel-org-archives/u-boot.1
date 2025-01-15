Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23F7C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 11:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5822800C2;
	Wed, 15 Jan 2025 12:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="X0oCqqTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F29F80214; Wed, 15 Jan 2025 12:51:16 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FEA480040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZSoewtHE/tbh5kVPybDt4dU14MswR6Fk3CMxy0gkVONcA+nrnehnf3dH7k0S3IvrbUJgLVCficPDb43iyGtvnjqZFsKScY1WWtmloK7wD9b0OahBoxwzGr8Jy546lTM1+3ohdGHjVfp57v7+9ZB0Lv+ggDhxkcWjN2j9lJnkDpPoaUZKXMYnWmQdXpoaYupwJEXqBx0OVk9qR7cmHId3V5LDnjoBPTwL6WKzuYmtm/fbY4n7262m/P27Fp/d3GqoUGc6mADvLRPLWIz3btKMVrqLOdHmqCEIt6iHnNno3rW6f34zgyGOYJpkB6rAwumwHTM4B276Srp0f6kGzD8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJNZZPkO8iSEaK5HFmQ6DuehLiTlIX25bcNCIX+XHGs=;
 b=LaCP4BWLwMmmnCmP1nVbvHnIqcaqH/HoIa69VKRmELw+P1tNWS5AE1d+36nsZsUfj3PGjAEoRub6Wsfkn3VEIT3OUZyhBuIGGB76StUPszHafcnjqNG46kUV3qpgHdpFV2Gp9IHAn+qgUr5r/sTYDg2qECrb6mB4gHGAWW240DzNqY3jpVXNjdeKw6scdnk1H4P6LwnyF0riiXJ0RaupBZpPhw/FduQLyxH+bHVWx9ocJvQp556cwOoMhjQ+9h3LWlSHg2wMil8AMfRkq2II0nTgXypc6B6uWH1pIBDG2fIqUOYWRmVzI0ym79dDqEZtLZEh1doqgsS1+DbB62dEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJNZZPkO8iSEaK5HFmQ6DuehLiTlIX25bcNCIX+XHGs=;
 b=X0oCqqTY89zQesSYOtM9weKwOwdBQjwx+NnltDcbnbm+seg6tfMprz0t/9OKbY/8DdkfixmVnWusogVp04YASjuOz6CzBT8YudyyPLC/84OAOC4E2ALzN00/VxtsiHISM8J6AB4nI7RYlb+TvdBj0MVd8zlHkg5vxHKg9wQ6uSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8090.eurprd04.prod.outlook.com (2603:10a6:10:240::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 11:51:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 11:51:11 +0000
Message-ID: <920265f4-4fdd-4c8c-a01c-bac9b9aafd9e@cherry.de>
Date: Wed, 15 Jan 2025 12:51:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
 <TY3PR01MB113468B93D55B10C9D38ABFAE861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <4dddca99-dcc2-411e-af9a-b27115e60efa@mailbox.org>
 <TY3PR01MB1134659D36AECF2B84B772B05861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <TY3PR01MB1134659D36AECF2B84B772B05861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd7999c-c715-4bd6-6512-08dd355ae5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rjc5Um5uRDh4S3BRUUh2aXUxOXJmK3FFMVBKTVpQVWNJNHBZOEN4ZCt3bDVL?=
 =?utf-8?B?b0ZyK1lMQXlNWGt2aDB6VVpYL2ROTXNPZmZibDJyc2tYZUhVZWxySXpFa0pP?=
 =?utf-8?B?RVVMTjVoSUU2NFlvc1BqM2pNOGpXcXkyQTYxWk04ZkVWZlJyb0JDVkRlZ1U3?=
 =?utf-8?B?U3J5YmNSTVhoU1ZUcVl4Q3hUaEZkQzI4WkRWWUxNZkZldHhKTy9tVTczNlNO?=
 =?utf-8?B?T2RkY2J2emdkT21raGprT0hsYXNjUUFid0xET1NpZ2xSTlovb0puNmxIczY0?=
 =?utf-8?B?WmVyMkdYQmFtZ2NXd3NBMFZoSW9XNjhQMExpQmQ4bityOWplenk5UU0wRVRS?=
 =?utf-8?B?bVdlZHRIMHhoRG1rbWpNWktiR2NxSk04QmhzM0NENDkwNnJvS1pna0VzdFAz?=
 =?utf-8?B?dmlsdkxSU1JuclBvaEdWN3lhYjcyZ3g1Rjl4enZHODBnMjFkUFFUaWNZVGxh?=
 =?utf-8?B?YnVxTUNnT0tUN3JWNGIvcmNLd0pTN0pFQzgzaTRudUQ0WFVoYm1hQ01lV0FE?=
 =?utf-8?B?Q0FHU3kyckJpSHFoYXJMVXArWGx5L0xiUHk0TGpXSDBxZGV6OWxUankxT2ln?=
 =?utf-8?B?dEJpcmxTNjV6czVzQUVJcC96Mm5IRFlETWp2L2hTdlpHWVdmM0RSSXV6Y3dn?=
 =?utf-8?B?MGV6NU5NcDc0cmpDdGJrVDlxc0xpUU1WcGlNK1liRktSWGR4Um00d2NSWmJn?=
 =?utf-8?B?c2VlTFZTYXMvWTY4SjZXZVh1STR1c0pYK1pQb0JtSm5HcTk4cXJSM1QxZFZi?=
 =?utf-8?B?ekM0YmxOYlBnNzREcnVWYWEvOGpnR3YwMkZVSFlPYlZ6U1cxc05vVzJXRGhQ?=
 =?utf-8?B?a1E5R0hBaWlHM1E1YVFNM0pMRkI4OTJsa0hPZlF5MG12UU9FUElweGZIektX?=
 =?utf-8?B?UWNJYXFxVmtCM1Z4MGVQUTgzQ1JlOWpldTNuTjdyWmtRVUt2YytBemRpdFV4?=
 =?utf-8?B?VlU1SHBUNEV0VjYxaWRoeTRYU0RUK2RoOTNBNmY1c05DNS9nUG9SbVpFTC9O?=
 =?utf-8?B?NnllQWVyUFV3bDBPbVI3M0NrQUF3RHZqL0Y4WGtubWE4T1ZLU05pVHZPQllr?=
 =?utf-8?B?SHZUTmp2cytaa2picnErZUxlenlSZ2lLYURxL1FFQjVkWEJydVdKZndWbVh6?=
 =?utf-8?B?VjhodDJSYUsyU2JrbHhxaFpUaVJyVzgvUHQvMGQ1MHdZRXRyTkpiY29Ua0No?=
 =?utf-8?B?UXUxQi9VeVo1V3BMK2NFQWJLV3ZiYi8rNGhOUHV2NWhmNTZ4ZXVIOXRZMVM2?=
 =?utf-8?B?aFhMbDk2L05JMVFHRkNtZWVDdUFQNCsvTExFRmVzbHljaHlsdmFIS1ZBdlZm?=
 =?utf-8?B?SmRTK0JMZ21JTGcxRm03dlU3cVl0Y1FIaTFPanlpWHZtNEt6cVpRWkp1QXcw?=
 =?utf-8?B?OU9HdjlYSXdQa3AwMG54cFlramxuUzBZMGVjcThQYzFIOERvMjNGSUl4OC9L?=
 =?utf-8?B?TVBIdkVHQW1CWHNiR0VDOU9TSjBlZzEwVTdQYUFTclA4SXlHcFNJOXpxVGN0?=
 =?utf-8?B?TG9HaUVidk9iTGNZNmZGbUdLa2ZnSWV5SDZrWnRLODBIMmJwNWdweWNGdlEx?=
 =?utf-8?B?QktvNFVBQzFTS3VZb3BqRlJqc2NkVlhKKzZTdXkwL0RsNlAxcmsrKzUwL3pJ?=
 =?utf-8?B?YkEwK2ZWTFRmU0Z5VEluaTBiWVdNNlQwK1cySDR3NmtMb0hxZkNhVEFIRXRO?=
 =?utf-8?B?bm4xdjVVeFVhZXNiWkM4UHNjaHFqS2VRR01PdElnMjlJTlZtRllxN2RxTksz?=
 =?utf-8?B?S1VERlhrTHQ1c25JZDNCTktnOFBSV0NvM2RlSGF1d0RLTGpwekxCYTNVbDIx?=
 =?utf-8?B?cmVFRDhCM3RwYmFmNVRwUGdMcDl5b0NYTTJ5WXZyUnptNGRWT09CajVudzdB?=
 =?utf-8?Q?yvwVkbViQOpB4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlczdUZjWGNJdUVUTEZ0MmJXb2haam1OcU9Sd1RnVDEwVExwZjdTVTdOZGRL?=
 =?utf-8?B?Tytlc2ovZkxtbmlOSlZLTGZpSUY3T0xFWGxzR3Q5MkdNMS8zUEVvSmJ2dThK?=
 =?utf-8?B?NEhkNUg3czVGMDh4VFMvL3QrU3RqNWtpSjEyTmNWdnhxbzkrVmRJNkJRN2pr?=
 =?utf-8?B?akVEL1lCRW00disxODlKOGZiQ3NldXlHRCtId092L2Y3Lzh4azNUVThhbGg1?=
 =?utf-8?B?U3diQTA0cU9RbGhVZDhxWk5HQ2llNDV6RnVpNnJ3NDgwSjRUZ1pJZ28vaEsy?=
 =?utf-8?B?bWQ5Wk9kOG5TY29UbzVlTXN4ZVhYUnMrWXJxVjRSQWVhMmJidVAxSVU3OG9I?=
 =?utf-8?B?YkpTbUM1cVZ5emM4VUMxeFQ4dk1yN29Yd0x3dEdVWHd0aGRHL3JhWFpiQWth?=
 =?utf-8?B?N1EwNCtZcEE5R0FQcGVoazUvWVI4dEl4bFV0UHZLaXd2a0VQaVpmSktxNC9u?=
 =?utf-8?B?ZzR3RXFqVXRid09tTldNak9wSWRFdDJiWTB4UW9VcmpCVDA0b3N2RS8yVEtk?=
 =?utf-8?B?bEs5TUVvMFBDcTNqVUtMMDNtZDBWMXZucFZVSjRaTk9SOFlrTlA2dnJYVVlh?=
 =?utf-8?B?VlJsamgxZk9jMmlrd0dQUmc2NzhobjR5MEVXcUFmNVRXUVo5NlhQNlR0UytB?=
 =?utf-8?B?VS9tRHZIUjc0dHhjNG44VEhOU29uakN4dnE0L0xKZlorSGZJdU9Ua2NQNDlB?=
 =?utf-8?B?a1JzcCt1aUw1OHVhK0pzdHZsaEJkcGpwdUtLMWZiOG45QWFjbkZaQVdBODBZ?=
 =?utf-8?B?TlBwVDZ0SmxPQzBJUzlNdFFBbllyd3hxK2tIYlRLNXNDa2dNQ1VRR25YRVk1?=
 =?utf-8?B?UUFkSHZXTWNTSThrVVJzSWoyZHJsdXp2N1BKU09xZkF1am1JUTFtMXpTL090?=
 =?utf-8?B?QTdWb2k0ZzNZZnlTQmhSWWkwekNrVzl6R0xwbTN0bjhtZHYvUEJlUDFBSGdT?=
 =?utf-8?B?SFMxU1lieUpwYjNnK1JZRk1ybE5FWnFjSk5wK3dZQ09GYWZLaFYxYmVJU3cw?=
 =?utf-8?B?RDg2YXdaK3N4T3RYV1pKMitzYWVYYXJXVmFXVUE0NEpnWlNQRVlicWdwaWRy?=
 =?utf-8?B?YXdSNDBjVUFubVVYdjY1K0c0YmRGV0lsNXVwd3U4SFFsSVJYR1VnWFkxK3Nu?=
 =?utf-8?B?UGV1dWhwL00vMlhTdFAvdEtWQUplaTcyTURZQ29GSkk4d1JmNnVmYzhITllH?=
 =?utf-8?B?cVdZdk9TT1BQbFlYUnpUZHFDa2xMYUZTeUJwaFFpNTkzZXc2U0liUmdydjBh?=
 =?utf-8?B?RXU0U1B5V3RjNzJpQmd2VlNjN2JxTThOcjlDWkRqOWVjbGR5cWliYWJNcUhz?=
 =?utf-8?B?ZzRLNDJyNU1PYnBkMWx2aG84K0FlRDA5YmFtMmlXMWJUdGtONXk1OFRreFEx?=
 =?utf-8?B?Um93Q1J4SmZBYXMycVJUa3lwNDJ5RGZjbDlYT0ZPcUllT1FJOTJOV0dFYWRH?=
 =?utf-8?B?ODlITWZJc2Zxdis2TC9zRVBtM1NZSWxEM1lIOVB2d1NuemloaysvdjE4aGhh?=
 =?utf-8?B?SVNqSUhnK3VYMnc1Zk51VHd0Y2ZrbHNjWHFuOGFUZ0NjcGVWcFUrdFZJVDA5?=
 =?utf-8?B?azBrc0tGSE16dDVnNGJIWlZjLzk3MWZvdzF3RFNLSUVRMFB4U3lzcFpUZ0wz?=
 =?utf-8?B?dUtlZzNKWG9SSklCQW1NNGZWbUp4djdrclBTdDdPbmZjR2U2a1Q5cDhQME8x?=
 =?utf-8?B?SGFvY3pVV3k4cU1yU1IwYVZqRVdrQzJyb3EzdzFKcVJVRlJOeFZ1N2VVREVs?=
 =?utf-8?B?TUdEL0x4QUtnd3Awb2d2MmVtMjh4OWR1Um1JUDg5ZkFVSmlJL1IzdTAvWjR5?=
 =?utf-8?B?ZzFLZGNSN1JmWHROWW1UWk1kTXpBSXJmUzhRYmVSTGdmNnhIZlQrOTZ2bXlQ?=
 =?utf-8?B?alJuaVQ3ZkN5QTdkcHlnRWR0WFp0VDA3QkdrbXVTbzVYcWdSMDA2dlJEMW55?=
 =?utf-8?B?WHQyQzZaa2Z0OWpzc1RxdHQzcFR0bFdXc3BHRzNVVzlrM0plaUFvVDhpRVV6?=
 =?utf-8?B?MnhHNkR6K05XdHRIMG4xc0FuRTZuK1FaUXF2QVYzaEltY0wrSjlJL2FaZHNE?=
 =?utf-8?B?ZTJCdngyYmp0ZFlqZ25vZ1JhNGIwcURYdm5LVmpCTXFrdU5rWThCTzA1V1dm?=
 =?utf-8?B?cmlMaUUrWkFYaFhNMlBYbUR0VEJxTDJqYzk5RUh3TzBlenRZcHZwWnZKclFI?=
 =?utf-8?Q?KTT/wqeVurUfp05mG+mBjCk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd7999c-c715-4bd6-6512-08dd355ae5ff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:51:11.5488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfK4HES1Xr22/s6/j928DTlrouh7jYBiIz1+aYlYKm08o1foSZ6HbReeeGtAc9LuRV2+97JX6azGM5uBuZ3XPf5vtD5t4Yw97bt6GrE5iNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8090
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

Hi Marek, Biju,

On 1/13/25 2:31 PM, Biju Das wrote:
> Hi Marex,
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut@mailbox.org>
>> Sent: 13 January 2025 12:40
>> Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage loadables
>>
>> On 1/13/25 1:15 PM, Biju Das wrote:
>>> Hi Marex,
>>>
>>> Thanks for the patch
>>>
>>>> -----Original Message-----
>>>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Marek Vasut
>>>> Sent: 12 January 2025 22:37
>>>> Subject: [PATCH 2/3] image: Add support for starting TFA BL31 as
>>>> fitImage loadables
>>>>
>>>> Add support for starting TFA from U-Boot running in EL3 as part of
>>>> fitImage boot, so the user can start U-Boot in the highest privilege
>>>> level on the platform, bundle TFA, Linux, DT into a single fitImage and boot such a bundle as a
>> whole.
>>>>
>>>> There are two main benefits of this approach. First is the ability to
>>>> run U-Boot in EL3, where it has unrestricted access to the entire
>>>> system and can act as a useful debug tool, as it was always intendedSecure)
>>>> to be used. Second is the ability to easily and safely update of any component in the fitImage, be
>> it TFA, Linux or DT.
>>>
>>> In this case, who will do switching from secure world to normal world, u-boot?
>>> Do you have any link to the u-boot patch from secure to normal world
>>> switching with kernel entry point passed to BL31?
>>>
>>> Otherwise, kernel, also will be executing in secure world mode.
>> See 3/3 , U-Boot runs in EL3 , before starting kernel it jumps into TFA
>> BL31 , TFA BL31 does its setup and switches from EL3 to EL2 , TFA BL31 returns to U-Boot
>> armv8_switch_to_el2 which checks if this code is running in EL2 (it is) and does the last few steps
>> before starting kernel, and then finally jumps to the kernel .
> 
> Thanks for the explanation. I missed the details in 3/3.
> 
> BL2(Secure)->U-boot(Secure)->BL31(Secure)-->U-boot(Normal)->Linux Kernel(Normal)
> 

If the fit image is missing the TF-A loadable property for example (and 
maybe in other corner case scenario?) the kernel will start in EL3 
though and fail very early since it needs TF-A BL31 for a few things. 
However, part of the kernel code will actually run in EL3 and that could 
be enough to mess things up with a carefully crafted kernel image.

Is this actually possible or am I making stuff up? If it is possible, 
isn't that an issue?

Currently, this is already possible and has happened a few times already 
at my company with people forgetting to bundle TF-A in U-Boot and then 
the kernel would boot but stops early (no console output even IIRC). But 
the bootloader is not THAT often updated in the field compared to kernel 
(especially if coming from distros) which would now allow to store the 
TF-A, so this opens an even bigger can of worms? In a way, it allows to 
update TF-A likely more securely (which is VERY welcome on Rockchip for 
example, where we usually start new SoC bringups with a blob from 
Rockchip and then have upstream TF-A catch up a few years later. Having 
BL31 part of U-Boot is a huge pain because it is difficult for some 
devices to do safe updates of U-Boot) but may introduce some bigger 
security issues?

Finally, another question, what happens if we have a U-Boot with bundled 
TF-A BL31 AND it tries to boot a fitimage with a TF-A BL31 loadable? 
Should we only allow to load tf-a BL31 if running from EL3 (meaning if 
in EL2, TF-A is expected to be already running)?

Cheers,
Quentin
