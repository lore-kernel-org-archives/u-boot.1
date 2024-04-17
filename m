Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBADC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683738842A;
	Wed, 17 Apr 2024 11:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="gOYDYavs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D5F8844A; Wed, 17 Apr 2024 11:55:06 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC13882D1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKmo4WxU0X6uq8alko/6ai8Dtufc+g4tMvQ8Pp5L2vuESNsFGuFoHkXDlFhUsN4MYmdFAnDtbjG5otMlLEXU+5lNL6pY6RXRJRYf/+HP/I4bxwaZ0k0vq7Txbsk85W7FNg9g1yS3quT76QKcrgrSOT8ambjKbsAg+W4pSMIruSU9yqWrYB0OOrzI0h94Pf0X9Sj30z8HGhGizdb1QcHhg3slLNiiAFg1kuJ+S0OPAPFkxpJO5+idwrKW0C8VCWl5h2wzLoRKboak53Lq8n3DL6PPLFNd3lJiFBRXsuztyy1HQq92Ph+dLtGqBoDgYMllNw5o8YzD40Ebg3CvPb0ZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXqk6eqS9Hp8dDZ3pNeCKXm+kXbATXOzI4UrkkRf8xE=;
 b=j5vG43SqqoIH+lxbrRnnUdSLq78K0Ey7h8AqWsqzbxI9y23mbH4TmDZZ3rRt7IzJw7D98S6HCDLL8H1lKur5i1qa9LIKjiZQxVd0/CBe0Ixt5mW0kdmv69ooZU1NcQwTkA8v/+R6CUtSKqH5qI0XBrLxFIweVSAQG/sg+ZEquDgL3yQ2+Y3776LD1scwXPIE3fllhv7/VDDA6SAVKtoizO54Sotr9buChuEqwuE80aemMkCAhr+3/uhKfD3hD2rijbMWgih7uieedMemXKQo0fMyUmQer0F/uMQfVqBu6n4SFRfgHOssk/xUs57K4N5h+UgZ7apLeR2FRO7RpI5bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXqk6eqS9Hp8dDZ3pNeCKXm+kXbATXOzI4UrkkRf8xE=;
 b=gOYDYavso0Cd389JDYvx4VM70lRi5xr4thznbuTeoYmpGzQJ8yH7uF0qxOVYLBN2kFnU4Lc+s2++gwJDUDhqC/1TrQO01eJ/mKgpKLgS5oAaof7dB2ALWRI/FdpXzG2gg7H94uYTjbPkd+3mZV6ftUUF+QmC0I9Orkjujt0ZyAPRSKDEYAqGsKo5sKTO0SXaaEIerBLlyZFEzv8zdCrzFkVaaK0r9agaMjXcN7Lm+7KJrNayUvHlwAYqTn7GwoPcTwaGQErsodeAP1TmzIgWUyyTPZLrPoZyd7s034V008FEoYE4Vv8MDK8n2ufBIrqhDeSBEornXv4RjX2NhSR64A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AS8PR04MB8086.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:55:01 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:55:01 +0000
Message-ID: <1f99fdde-1d2f-4efa-8a59-8f011d99643e@theobroma-systems.com>
Date: Wed, 17 Apr 2024 11:54:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: px30-board-tpl: Use CONFIG_TPL_BANNER_PRINT
 flag
To: lukasz.czechowski@thaumatec.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20240417093542.275150-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240417093542.275150-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AS8PR04MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb6a047-66e0-4106-5dd3-08dc5ec472e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajU4RFdYamo0MjUzbjBROElBSHVZWXNtQ2VWYjhxRTNIT0FPdEY2YUhuV2lN?=
 =?utf-8?B?TkdHZ29TdDBZUms5U1BNaURaWmF3d3Bxb2hqdGFGdVN6MVBnSVhKS3Y0bXhP?=
 =?utf-8?B?V0RwWHNvK0UzTFVnZFpaMmhycGhqendOclFCdEc1QmRlb0dHUVFaWUo4Sldh?=
 =?utf-8?B?VnNaS2lxL2h0TFE3QzNqeVNkUys0ZFR1TXBVczJSakZXamJQUGFDdThoZEJG?=
 =?utf-8?B?SUVmVW1KL01vazgvakIxcnNUeUQ0NFltaDY3TDk3UStyZ0pmOUJuZDI2MkpN?=
 =?utf-8?B?UWtKUG5CU1A5THJBanZFOHZrbURydzd3djd0OGtyL0V5R3JMaWs1SVV3RUtj?=
 =?utf-8?B?MHJMQXM3NEJNWU5hYnJqMVh4aEVzb1pKV0RYbERkaExyQy95Rm5Yc0sraitD?=
 =?utf-8?B?N1BYb1o3N1R1eGNrQzcvM24vY2lHWm1KekxMOWR5WXNGL1lqejZuakxXbTd4?=
 =?utf-8?B?OFFrNWw2Q2RKZFZOTm82RnJIcy9Dc0tYN00vMHpRVDI4RWtNY2d3TGk1K2FR?=
 =?utf-8?B?b1JvN2o0SHY4SXdSTEJtUjV3Rjc2UEw1c0JQcVA0WWd0M0tWUWRnd1hxa1hB?=
 =?utf-8?B?c0NwWlcxMnVQeHdGMWswdXl4OTJzRjlZb2NuSDQ5aEVrZ2ViUmxKblpkQ1Fo?=
 =?utf-8?B?U2ptOWtSaWxSUDgrUWJUSFAxcmc0ekVZMWNnZ3NHVWJmRjlrakFtcWVUcDJv?=
 =?utf-8?B?ZWpOd25zd0lHd3ZmSFU5aEtqOCtTSEt2M01iUlJoQ1FIZDczako2Z2dpZDRo?=
 =?utf-8?B?eTJxM09VSGk2eFY0VzNYSnJoLys4OUxWc2gweVhKN2kzeThUT1o5TlNORVpZ?=
 =?utf-8?B?S2puMTYyZHNIc2ZzYWVjMXZ6Nzh3Wjh2eldFbXJFWEw0dFMzOE85SFluMUR0?=
 =?utf-8?B?bEdJb1ZiUWIwcXBYRjlNS0tjeWNnYTVPSUxxUlJqbHdGRmFsQ1duNGdrYXBm?=
 =?utf-8?B?TlAvNWcrOVZRclh0R3RyQWFUSzY2SDdLdTFub3NhL2drMVhwN2s3ZE9SQXF4?=
 =?utf-8?B?eHgrQ2x3bEJwOW9hRE5tZk4vZ20zWVlVK0kvUWJFMnBUcnFoSlpNUkhSTDZB?=
 =?utf-8?B?VndwREF2a3hROC9ESDlpYlRzQmQxUnozY1lYUmZFMzhWRTF2UjFyS3FQK2hs?=
 =?utf-8?B?UUNPbEV3UmZYTlA3cmhibFJEUjhlVStKeEx6M2JmVU43aEpsQ05hSXR4R0pG?=
 =?utf-8?B?RU5uYlhxQ01JN3hoMERJTWNTbmJmdlR2U0lIR1orQTNGYS9xeWcwcDNRUkxH?=
 =?utf-8?B?VXNzNWdZUWIwMitzbTJ0ZVFiOFNVU1owdVBhd01zcnpxUmhmdnZmeW14WS9L?=
 =?utf-8?B?VzZ1K3VmZEdiT3d3cWtSdmRsS2Jncm1WQXIvOHhha2p3MEdhV1EySDNiZEds?=
 =?utf-8?B?RHloem1HWTFjUjQ3SVhCYWlnM1U0WTBtVXg2amdkdm9pbUVOb1lmQnpuSGps?=
 =?utf-8?B?R2taVUhyNXpwRkcrZklLb1gxMjUyUFJVdFZaSWNyM0diT3JrMnhERUZRU2JT?=
 =?utf-8?B?aHErRU9jclJrZkxjMWRsUndadHg0OTlvOUZkOGoyMzBmTFZDdVJKcUU0b3ZN?=
 =?utf-8?B?OFVBYUYzY29UOGQ5RWxBWjVMS1FrZTRnS2w0YlhmNzBzcHh4dFpqc09ZN0J5?=
 =?utf-8?B?d01NRHhXRVdqbnRhaExac1BpSmNKV0grM0YzaGtRNnM2a2U3ZWsyTVdEbzJl?=
 =?utf-8?B?OEkyWlN5Y0w4MjIvM2JaZnlrQXZmYTVEZjFlWFByRVFZNlFhS3NtNVNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG1hNVovd0RHSnNRV0RjREVEWG5TQjFGa1ROL2RBSVFtQ2Y4WHUxRjhtT2tJ?=
 =?utf-8?B?UDcybDh4UXlRa25Venp4VXZvdFZXVkxHOVBFSThnSlhTVVZxMTJkcDZOUmx4?=
 =?utf-8?B?MXN2TUFINEduN0gxTEo1WS9kS0ZnZ1ZrWjI5UldMRGVkeDFxdlZTQWV1ejF2?=
 =?utf-8?B?SWc1Wi8zOVE2MTRXVzllOWYybEF1NjNvSlhEZXhrSUJUMzROZ1o2d29WMThS?=
 =?utf-8?B?RmVCK2o1aFAyZVRRVDhuMHlqYmRCNGxHWGpYeVRNejBZb2h0b2s2cldVWER5?=
 =?utf-8?B?SlhsOTRBOXlRRmFYV0dXaGkyaE9Zc0dMcTFtTGsxMC9xaU1BQXcxZW13MFZp?=
 =?utf-8?B?MGRWaUhFNFpJMzVuMG9WSXdnS0RDckdlWUZkR2FrTXFyVGR6Q29zZ0pYSjN1?=
 =?utf-8?B?L1laZDZxMXBPbWNCMjhQR3V5QTh1aEQ2ak55dDJ6ZmowNW15M2tZdi9DZVQv?=
 =?utf-8?B?N2psUERIMjV4UjczMzZFS3BJdUVsWUpCMTJKc2dhZVc3aFVUWmN1QTF3SC9x?=
 =?utf-8?B?QjhtMEtNSHRVQWpGTDg2eHk2R0dTRExTOG9uR2g2NVBLaWVNUDg4ZVVUZWxR?=
 =?utf-8?B?RG1ITUt5LzN2TmxPTU1ZYm0zK0lhbVFScCtPK29DcHBsZXhoTkVRU1hkczNo?=
 =?utf-8?B?eWJPYXM1U3dGZEhnUFpzMFhMaHRnQzg4MlpxR3ZZSnZRaFV1THEzYjZvMjIr?=
 =?utf-8?B?Q2ZKcUd3MVN5cmlYUTlFU1FPeUNCcDBwRjV6dlZUdWtkT1JUdk96YVpDOWNV?=
 =?utf-8?B?cFVXREJTZU53bDRPYVBhdFE4RStZams0RS9kajQraHBVcFdxc2ZUb05xODR1?=
 =?utf-8?B?UEZERTBMblVMU21IQi9pM25zRk5aYXV4cGhMVWV3R2pzbWNiZTFhQUJsckd2?=
 =?utf-8?B?ZlMzVnFxbUkrb21qYWtITXQxZnpHSFhLOCsrbjBwOTdLM1h6VmNESjZ0d1pu?=
 =?utf-8?B?Lzk3Y3VGdUVrL2VLOWRNYlkyOG43VDViOE1XRU5pTWEvTVhOd2dRb2VlNzdB?=
 =?utf-8?B?VlZUR0RtSm9yTjNHeFZ5eDN4emtsbTRydk1tUWVzMWJ0NkhON0NSRm00NGhL?=
 =?utf-8?B?ZjgxL1ZqZ3JVdzVFZ1Q5b2FvcXJ4bzRTRkg5TVRibTJ4a1ZjYlh2M2pWTUdn?=
 =?utf-8?B?N3Y1VUg4b1BxSjN1S29pcFhoM1hFYVZJRzVjTjFZVS9RRWIyWXBIcDAxUk5y?=
 =?utf-8?B?ei9xZENzY0M5Q3d0eU1OcEkzd3B3ZEFxbWdCMEY0QWQ0T3QyN1h3YytVenNj?=
 =?utf-8?B?Q2MyLzFvdGNBemZtMWxzbzRkdlFsUE03V3E4MkpwSDNZY0QwcFRUc2tYZ2ZZ?=
 =?utf-8?B?NXh3Q2VJcjBYN3FSZnc3M3UxdnFaYkxHaHRmWVI2cGtDR1pTYlhTT09TMGJx?=
 =?utf-8?B?TUxKU2hCdVM0RTJsZWV4WmkvMzlZWmNCQWE5a3M5cXh3UDNGakdYTHRSTno5?=
 =?utf-8?B?M1FCZEUyb0tWREpGRkdkcGVTRS9wZU5UR3hJOE8wV1NhOUVEeEl5REI3Nk1k?=
 =?utf-8?B?emtHMDViR2gzWjByL3pBRitIaDIxQnN5QUNyV1JDWlNJV0trMncwWmU1SmNK?=
 =?utf-8?B?RUNQUGNPVXpxUWdPK1U4ckxHNk1Kc2lnWEFIdEJhYkxWR3ZpdmxLR2M3b3JK?=
 =?utf-8?B?OVMwZ2lnV0oyWmthYU1vVjd5VHVKWGxOQlU0ZTZHYmRsbEJ1V1IwYWpmcWRT?=
 =?utf-8?B?V0xPZExZaTNaWnpudWFBZ0RRWmNiMlV6MS9keGhpMHJnbllPQ2lVZm9tcU1k?=
 =?utf-8?B?ZHFyYkVhNHdBdTEwdW13cUwvZXBxK1d0amdpVkNaZ1BKQTBxeXhycmNPY0RE?=
 =?utf-8?B?VTJwSEUvNTVNRnhTdEpsN2Rzc29WZEIybjd5UGlpcVpua296UllhQVR6citr?=
 =?utf-8?B?U1p0Sm5hdGk0NzJLNEhVWFF6UTYyTTR6WEdPYit1dWhqK25GZFRpeGI2aVp4?=
 =?utf-8?B?L1I2Um12ZVVzdWhFL2xNK2Y1Rm1uUjdDb1ZMVWRHV1dPeEhWRzZOU1h0aGFC?=
 =?utf-8?B?bVNuSkJrcUpXaEhVNVRob2tBZjBGTGpqM0FQUkE5Z3VmaERYWGJLS1pjajBr?=
 =?utf-8?B?VzREeHpJSFg2SkdZUGZ6K2IwUjQ4cGRnaVV3UkV1K2d4Um1PckgyRFFSbWgv?=
 =?utf-8?B?SkZVbHNHUElEb0lzK3dLSW1qdVFLSTdEdmhqcGVEU2l6WHBTOU5Vcmtxa2dv?=
 =?utf-8?B?VFpsdDU5R3VBd2Q2REd4a1dGQTE3aDZLZHZxVlgzcVRiUVNQNVl0azdodlBl?=
 =?utf-8?B?SHNnYXE1Vmx6SUpyTHh3dTI0QjZBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb6a047-66e0-4106-5dd3-08dc5ec472e7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:55:01.5788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opxesF5G3xh8p0KCuCNJ2y56kuaawluDR01xeBXudbkv+yIajMewBVC/Z13qyrQroAdllHX3U/txIJyHO0U2mH2dIBMkX8SiOnfK4doFo6ViLCRKSDC7HlYe1W9KG6f1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8086
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

Hi Lukasz,

I would have renamed the commit title to be something like

rockchip: px30-board-tpl: sync ifdef guards with full TPL

because CONFIG_TPL_BANNER_PRINT isn't really a flag but a Kconfig symbol 
and the effect of this patch is to not print the banner when the symbol 
is not selected.

Another option could have been (only for the v1, since you do more now):

rockchip: px30-board-tpl: print banner only if CONFIG_TPL_BANNER_PRINT

On 4/17/24 11:35, lukasz.czechowski@thaumatec.com wrote:
> From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> 
> Display TPL init information message only when TPL_BANNER_PRINT
> configuration entry is set. This allows to disable information
> message in case logs on UART are unwanted.
> Update parent ifdef condition to check also CONFIG_TPL_SERIAL
> to match logic of the non-PX30 TPL implementation.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> 

Small nitpick, the Cc would make it to the git history, which isn't 
really necessary. I believe you could have those below the --- and 
git-send-email still find them.

Additionally, git send-email allows you to provide --cc and --to manually.

> ---
> Changes for v2:
> - Updated parent ifdef condition
> ---
>   arch/arm/mach-rockchip/px30-board-tpl.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
> index 637a5e1b18..db368a7b8c 100644
> --- a/arch/arm/mach-rockchip/px30-board-tpl.c
> +++ b/arch/arm/mach-rockchip/px30-board-tpl.c
> @@ -36,7 +36,7 @@ void board_init_f(ulong dummy)
>   {
>   	int ret;
>   
> -#ifdef CONFIG_DEBUG_UART
> +#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)

Quite interestingly, CONFIG_TPL_SERIAL cannot be disabled on PX30, maybe 
we should change arch/arm/mach-rockchip/Kconfig to use an `imply` 
instead of `select`.

Anyway, no change required on my side. Only, if there's a v3 (for the Cc 
and commit title, the Kconfig change would be a separate patch anyway).

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
