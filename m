Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB98CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 10:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF6382A9E;
	Mon, 27 Oct 2025 11:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="A02Cx7lQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEAEC80107; Mon, 27 Oct 2025 11:17:48 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2BB80107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Izlbptbei6koVQZfNTziuAYAkmWZmIwnHvKKiKxwjrUTzVsV4DBPAkQIf6yS7kWsmE7Mgxx8RzvrNpRpE5DThfTzy3GtwoEbVeVHoX17cKYCQB5VjoVTrSykxixJiJO24Ynb2tkEbAJpASJlK1BqLDufDl6fBqu/hjmZxCgvJ+wJLSOnLs1hvlJN5HsDN8jWRwY3ytH3RML9lhN5wuSjKpaeYPVJ5lt/53j9TTDvKQjX4VmfOEQLyCpk6zuCr9iqGwGw3HHqJuGchB6ffE5wvFLvVI4dAWIkPweqao1awLouZhRf1C/FFLvPXNc68JmJZvfBmDpCN0uIPGRdOA0Png==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FRx8mQrMA5kLRr1YJnYzWvBIW3T9w1cSgkhlscTedw=;
 b=XyB1vtpviS7M8FoVAxfGBh4pvGy3cUctliCDfQZ0DtURJZrbovQwcdryGaapp1UKqM5q8o22hX0yiaiLwEyaaNt3hFaF+95GGzbyd+kPFZQOj8zgDhcSsoDO8ljjsSkS9wbjV9AStjHONSf00XXc0cgR/YxzmhjsZeq7S8MDgJhJVGPoBFvIe2bPXNQBerxRZ2rbSpxnQnOddGRmBqPybcM6ewvPIPmGw1FoiwgNw2cJ6/ylS1GYpkdfXq7Jf3GG8eAdEvLYJDRa3vva73rS8HggV62warWIkEpcQGu04IVQtOSrCl0TqrHDlAh4I2JMnpVw8vpus1HYVXW1KmN4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FRx8mQrMA5kLRr1YJnYzWvBIW3T9w1cSgkhlscTedw=;
 b=A02Cx7lQ37Lnnn/EvVuMTA4whEM0aXF1gUZvF+PIAcLx2+bjUmEXoHk+GAPRMmwpKHRjLYHd7p2XqUgBvK9T2G6EtlN+2lN76WPe2TB/HiE10yLbfFCWzh/XSwzR6UIsLG8otbVGz47Tmu5dUsbdHTcIAyBuFfRo3c4AGqyTeHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Mon, 27 Oct
 2025 10:17:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 10:17:44 +0000
Message-ID: <a999e50d-9ae8-4e50-bab0-d806fd2bc200@cherry.de>
Date: Mon, 27 Oct 2025 11:17:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] tools: update-subtree.sh improve user experience
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251015083842.46057-1-e@freeshell.de>
 <14b0f59c-adec-4ccd-9854-09bbf335bdc8@cherry.de>
 <faf31d40-656c-4eee-b564-80586860cd75@freeshell.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <faf31d40-656c-4eee-b564-80586860cd75@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: 385752b6-ef84-41a3-f71e-08de154211f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cno4bDAway9zb25FemVpUXpsaHpDdW9aSFNmemlhM2Z2ejdyOXllM21HUTJJ?=
 =?utf-8?B?UkQ5M1M4WXhNQnl0RGs3c21CcUZuYXRxSk52NitNeDhibFdQVElMVmJwMkUx?=
 =?utf-8?B?ZmJJVDg0RUZzWW5FS1g2Q0RhR1o4bVRrb2UxRzRUTkZKcUh2VW1iL0xPemE1?=
 =?utf-8?B?OGdsUFJ1dDFLWlVrR29GcUxiNmRPcE5TTktEdk1FazFid0Rwa09WdUVEWHJz?=
 =?utf-8?B?MVNwMjFiSHI0R1JLVDNTTU0rNVhiaWZvSlcreXdVLzJ4QnYwWnZLa0t1cFZB?=
 =?utf-8?B?VGNkWUt5bzlVZGI3aU9Fa1R4RTUrT2ZtRFJKcVNqZkwydEVNeUovK1QzNS9Q?=
 =?utf-8?B?OTU1MDl4Q1pGbkFoOU5JVE9oYUo5M1hOTjhNOThnNWNQS0kxVzA4WVpnUGJr?=
 =?utf-8?B?b1hRVzBSb0dvM0RtaCs2V3VCM2RnQW0yYmVzejRHdkR0TkpEN1dXQ2c0TjB5?=
 =?utf-8?B?ZXRnYzVkZTFZTGxZZVRNVW9SeXlxVHVSczZVdXZ6dkJJNDlueGNNSkthVDM4?=
 =?utf-8?B?c1h0ZW1PTTRDdU80MGNyZnRNeFNQWms2UjBhaG1QZEpVL3lObWpRMXI4UmVN?=
 =?utf-8?B?WDN4aHY3R2VNZHJOR25nNkRkMGMxUU5oUXU5ZXEvS2xUekRUbDZpWVlUeVFN?=
 =?utf-8?B?NVdoU1FSbktyenF5YzlZVkE4MUFPV0wwVkp2b3BEaXRLN0pGNk9MY09iU2kx?=
 =?utf-8?B?djNDZXlTY0o3bXVwRG91ZUxzNUhOV3Q3Nm1zd0s1VzZEYmRHc1kweHpyY1Fv?=
 =?utf-8?B?RGJMQWFvV2MyVjlLYjd3ajR6WGE1d25ya01HNHZnblEyS3J2bzAzQWYwWTVr?=
 =?utf-8?B?cmJrNWxVNHl0djNFaC9HRVUvWkZkaU1UM084KzlMaTh5Y3M1dkpvYUU5T1lu?=
 =?utf-8?B?aVE5R3BEcFp5djB4b1JCZmxBcHZWbjFpVEo2bTlEaSsxU1l0UDJCakNzMHVw?=
 =?utf-8?B?djR3Rzd6RjB0RWZ5MlVUeG9NQUNBRDJVSkxwYlNsZEc4VzFVcUtrZ3hhdXcy?=
 =?utf-8?B?UkxTWXhVTWU0UVRzcGtsTXVLRHRER1k0SE5SVlJHR1hydUUzMXdweGh5cFVx?=
 =?utf-8?B?emlibmJJREY2T2tabEM2ZitWRWNEblNoVFhHRzNCS0NvK25XSzdXSjZMRHVy?=
 =?utf-8?B?c0t4bVNtK0Z5c0lKdGQwREtaRjB4VEpKQWpybEIxNHF5WEU0VXNLVXkxa0kx?=
 =?utf-8?B?SjdNSEs2WnFRYlQ2WFpxTjJaU2pZRnhob2d1bDBmTWNiWXNrNUhtZGdqdENm?=
 =?utf-8?B?T0hEMlk4emhQaCt1UmpKUldnK1F4TXZXckN1UVA2TUdMMzc3U21ybWUvRjNo?=
 =?utf-8?B?RmlUTHdVbVdBYk43dGwxSzlmWkVqRkJTQS81TFk5dEgxMWlSVW92cU9FaXM3?=
 =?utf-8?B?OHNvaFZSUjA4ZU5GdkZMT0dkSmlCcm4vNnFCOFF1Mmw5Y0l2MEcwRElxT05m?=
 =?utf-8?B?L0JxMWgxbTcvclB1aGVjUU9hbHd4ejhSUXJJbU5LTXMwWmNwNFVrZFFVV2t5?=
 =?utf-8?B?MVdnVVhRQktEOE5IRW9qRmxKbkFkS0Y3WC9jNmcyV3BTNDJJUjZvWmlvZkow?=
 =?utf-8?B?UC8vZHJQRGJ5NUhEMk85MjEzdGk0YitudXdPdzZGcmdGU1VpZDBXRmE4MG10?=
 =?utf-8?B?cGlyNWhsVUdkdlJndVVZbWhFS2NQY2piZG15VGFqWktqR3lhb0I0WjVjdzVi?=
 =?utf-8?B?K284ekxwZFJLcmpTSFNoVEhIdEhTd3I1TUhjQnlJdGRZTVFiUXpFMkNSUU1L?=
 =?utf-8?B?eDYwaHIrRXpNQWJZbkhlWUhMRCtHSWhNMUJ4ZUQwelcyZ2NUaUVWcHl2Y21J?=
 =?utf-8?B?b0hUa0YzWll5eFNTd2FVRi94VlM3T29qYlEzS2VENndDYTJOZ3M4cTd2V2tQ?=
 =?utf-8?B?SlBvSG9RODZGR1d3emw5YlIxQVBpdmdrcS9GN08ways3VXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdOQUtCNFlaWHJXZkFnQlkwVU9WUVR6Um4wdXR1TkIrakhhNyt6U1N0MTMy?=
 =?utf-8?B?NVJWbkQ1TWJyeXFIS1lONlFVVVBHcU1LYUxzKzNMRE9XZXRLSmM1ZGdOTitT?=
 =?utf-8?B?QVdEV1orVkFKTHRYTW55aGdiMnYxVkwzSjVjMFVBMEczSW9sdzUxSWFlNE54?=
 =?utf-8?B?U2UyelNtdERTMGpOblFSZHR1cHorQXlpeG5ISlJVc2hiSjIyVmJ0SWJoTlMy?=
 =?utf-8?B?ZkgwVHdlUTdleDVIeGxOVnFEc3ZDSXhzeWJ5c1NwT2ptUXU3eUNyZS9ITGph?=
 =?utf-8?B?R1JtWVlUNWphTm0xeThQZzRwRGxUeGdpY2txUE1RV0FWcFJKQ2RzRGlnUUw5?=
 =?utf-8?B?bzRuRklxNis4S1R4d2pVbXdTYk1oeXJvZEsxYjdjNWhqUGpEaEVvL2RtdHB5?=
 =?utf-8?B?L2RwNjZkV0I3TnBSMWpUclhvMWJwTlMvaERrdGhlTExZSThkZmpzbUV2SFNh?=
 =?utf-8?B?SkZHR09nb2EvUWkzZ0pNVVhRTU9IZE55Mml0NUxubk5TeStGQXRGanJ2SXZE?=
 =?utf-8?B?OFl3QkZ1cHU3L3lxUHZ4WlpQamY4VGk1VzJCTHFUQnFWMjZPL1ZkSTh3Zzdu?=
 =?utf-8?B?T09CU3U0RS8vUy9lR3ZraGE4L08va2dsbDlJMm4vdTZqQjJzOTV6UkQrRXlM?=
 =?utf-8?B?OGRmRE9IQldNYTZSWXdtWHRuM056anQrUURtSEpMSUdoeWM5Z3BUTG56TDVh?=
 =?utf-8?B?TUw3ZVlyTHF3QWo0d0t6aHJKMDdLN01FUzQrZzk2RWE2TGpZRmdCd0NITHB0?=
 =?utf-8?B?SUNOb3d4aHAzUFE5VVFkeXY3NGRNOXpGUXBaK2I4WWZBdjR3SWJydk4ybjU5?=
 =?utf-8?B?V01WeU1SZ2tvcXRVY3NocU9GeXU2ZjlyeU1PTjk2YUoxbGJQLzR6d2RvZXEw?=
 =?utf-8?B?SWVmTVFqaDgvOEovVjdlSm9hR25XYmx0M2diUTkzVGVpSzZueFRzanIybklP?=
 =?utf-8?B?K3d0VVI2YW5iUC8vNXo5Qnprd24yNTVOY3drT3RwZWlFVWZoWlVJc1J3ZFd3?=
 =?utf-8?B?UXZ5MVJFYURyTTNBWkFueHFhRFV2dW5OMHhUU3lnRkhNaGwzQlRZK0ZzaGtK?=
 =?utf-8?B?SExpSGpUaGdzdit3alRkRHVEVGVkWk1CVnB0NERhMGdPamtUYlVNMTlpNmYv?=
 =?utf-8?B?MGU3L3VlM1pwS2IrMUI1WmxiSVU4d0Nsb0k1RzBKV2ZrVjJzVkN4MGJHUlRM?=
 =?utf-8?B?Skl4QWhlVGh2UlJwLzYvMGY3T21MdldtdnI5TitEc2hvVE1uVlJsRGpIYS82?=
 =?utf-8?B?d2NHaGpxbzNpd2dxV2NTRjcvcVQyTFlvS2o5MWNnMURtU3ZaTWV2ejZ5cjZK?=
 =?utf-8?B?MFFacFMvTmFpS2pPRlpYdmw2UzFubXhIUGwvenB3eDY0UGozQ2J5aUJIODBJ?=
 =?utf-8?B?c21WeVU2VVBTTFZESVNVZTdNM283bXhFMytNU2tYOU9rdzFRSnRUVTZPZzRF?=
 =?utf-8?B?Y2wzbHZPaHIxWkRjcjI2d3o4N3RUVGhjZm4zTXFDcHRUVlRqUHVrcHBQZkZ2?=
 =?utf-8?B?UXZGTnRFMjhlSTNLVHM1NWRpT2h1OXlvZHpqRXNKOTJMaDVNNXMyeFUwUUdm?=
 =?utf-8?B?OFI3ejI2WUZZYzQrYXp3NHk2SlhSWDJhaVYzdUxSM1NhUklqUWROMGNnZ3pI?=
 =?utf-8?B?cjcrTGQ5b0IyZnJWL3B4THNxL2Y3ODhkS2hRNDViY0o2RE1JUW1wMXVsL1l4?=
 =?utf-8?B?bERrayt0QWU3Z1BJUlN1Mlllc2R0NktzVzZhNWRkQ1lOR1FzZzBtRUZacGls?=
 =?utf-8?B?RyswZEFmKzc0N2o5VlJSU0RrSU5xeWlWayt5Vk5kUWp2Z0FwdHg0TGpXa0Fu?=
 =?utf-8?B?ZDQzVFF4ZnY0NUNFQXkxNHgwT3Y4L0k0ZWhEcDZBN1NBNTRYb0JrQjc0TWJk?=
 =?utf-8?B?U0FnT3VLVVk0OFlUUFFaL01YdFFaeU1MMThhV0JHcTh4WVRCTUtacGNmRkRt?=
 =?utf-8?B?L083dm9RN09yV2J0NWdtYytQNlcvazc0c2ZLSlhtVHBhTVUyYS9JLzdqc202?=
 =?utf-8?B?Um1lWDlhRFMvclpjdFhWL05YcUlWdDdHSUtoeDYxbGdZWE5iVTJLck41cFVs?=
 =?utf-8?B?dXZwNnNiSGMrNTh1czZnUUJQazdmQUNIUnY5MkVIelhGTnZ0dm10cC9vdWZ3?=
 =?utf-8?B?azlGRjU5REowa3RMWVl0b0RKNzlJb2ttNlB3UGVjRDhBWkFZeHN2SkVGdEdr?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 385752b6-ef84-41a3-f71e-08de154211f4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 10:17:44.8199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoJzRDePnI+GtqWNXV/aF+NDQXFo+vDJZirvCLhPK+jyuIVsvtYI5rafm01/yIjwPiQRljIyQDAI5PqHMy2FNtCDNZzsYxgpBAEHuKxJzLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422
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

Hi E,

On 10/27/25 7:56 AM, E Shattow wrote:
> Hi Quentin, thanks for the review.
> 
> On 10/20/25 09:01, Quentin Schulz wrote:
>> Hi E,
>>
>> On 10/15/25 10:38 AM, E Shattow wrote:
>>> Makeover of the script:
>>> - Usage now explains at each step what is expected from the user.
>>> - Default branch name is no longer hard-coded and is queried when
>>> omitted.
>>> - Additional operations 'update' and 'log' close the logic gap between
>>>     expecting the user to provide a commit id and where from this
>>> commit id
>>>     should be obtained.
>>> - Use 'set -x' context to show git invocation where appropriate
>>> - Sort options for usage output
>>> - 'pick' operation detects merge commit id and displays suggested commits
>>>
>>> Additionally the LwIP remote is now using the Savannah mirror system:
>>>
>>> https://lists.gnu.org/archive/html/savannah-users/2025-05/msg00002.html
>>>
>>
>> Please try to split changes into multiple commits. There's a lot of
>> unnecessary noise and it makes difficult to review your patch otherwise.
> 
> Yes this is incomprehensible as a diff. It should be reviewed as a
> replacement for the existing script (I do not know if that is possible
> with git format-patch, ?) I'll try to spoon feed it in a series of more
> easily reviewable patches to get where I want to.
> 

Create two patches, one which deletes the current file and the second 
which adds your new changes. Then in the cover letter say that they 
should be squashed before being applied.

Note that this is very unusual, I believe projects typically would 
rather see small incremental changes than starting from scratch.

>>
>> Here I can identify:
>>
>> - Cleaning up the comments at the top
>> - Removing set -e (why?)
> 
> set -e fails the script immediately which prevents giving the user some
> facts about an error
> 

It fails the script only if you don't do proper error handling. Which we 
should be doing.

If error handling is missing and set -e is set, the script will stop 
where it fails.
If error handling is missing and set -e is not set, the script will 
happily continue and fail in some random places later on.

I prefer the first one. Personal preference though (and likely of the 
author(s) of the original script).

>> - Moving print_usage somewhere else
>> - Changing the output of print_usage
>> - Reordering cases in the switch..case for the subtree-name
>> - Changing URL of GNU mirror (which very much looks like a typo as it
>> doesn't seem to be what the link pasted above says the new URLs should
>> look like, albeit working somehow)
> 
> I got this information from the person working on it for FSF. I will
> review to see if it is better documented somewhere, but this is their
> suggestion both the load balance URL to use and the public announcement
> reference.
> 

https://lists.gnu.org/archive/html/savannah-users/2025-05/msg00002.html 
says

     https://gitweb.git.savannah.gnu.org/gitweb/
     https://cgit.git.savannah.gnu.org/cgit/

not

https://https.git.savannah.gnu.org/git/lwip.git

I needed to go to the cgit page of the project to find the clone 
instructions where
https://https.git.savannah.gnu.org/git/lwip.git is mentioned, c.f. 
https://cgit.git.savannah.gnu.org/cgit/lwip.git/

or also on gitweb:
https://gitweb.git.savannah.gnu.org/gitweb/?p=lwip.git&view=view+git+repository

Please mention this instead of simply linking to the mailing list 
archive which doesn't mention that at all.

>> - Adding new features (each its own commit please)
>>
>> You also do not explain what your pain points were when using this
>> script. This would be useful information now for reviewing and for later
>> if/when this gets merged so we know what kind of confusion happened in
>> the past so that potential future reworks don't reintroduce the same
>> problems.
> 
> I was never able to get this to work by the description in build
> documentation. I have a choice to do a lengthy explanation in
> documentation to improve that or just make the command more
> user-friendly - I will try making it better before giving up and
> increasing the word count of the documentation.
> 

You should justify your patch. Why is it better than the current 
implementation? How is that "improving the user experience"? It improves 
yours, but maybe it's worse for everybody else now? What was confusing?

I'm not asking to write documentation, I'm asking for the reasons you 
wrote this patch so we know better than reintroducing these issues later 
on or for other scripts. With this patch here, the project cannot learn 
what it did wrong and cannot improve.

>>
>> If I remember correctly, the biggest issue was that a pull dts was
>> attempted instead of multiple cherry-picks? I believe nobody except Tom
>> (for DTS) and whoever are the maintainers of lwip/mbedtls for the
>> respective projects should be running the pull option. The diff is too
> 
> Yes, this is not clear from documentation presently. The tool should not

Agreed.

> punish the user for misuse or ignorance about commit ids before getting
> to the moment where they can begin to learn about such things.
> 

 From that, I assume you mean that you would like the tool to catch 
whether the attempted cherry-pick is a merge commit and error in that case?

Cheers,
Quentin
