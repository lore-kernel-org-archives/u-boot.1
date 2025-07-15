Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC65C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10AB782F14;
	Tue, 15 Jul 2025 11:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="A/ulQQjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C53182F8F; Tue, 15 Jul 2025 11:34:05 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C8782F00
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyUsVNz6pRwppfVBsHqQkUtxr+Sn/YCEZ+lt4zKdfnQ19w79wba0zIjjyimN2tmEjlKwrQojlFRacoYV49jtLZF+3Ma7FopxrNRUbSlDwAxk+/rJS0ScRyKNsHwRQ+LeCp+unwd4sd2pEm1FZfH80VNOnU7aEr11eUeIzHwvSwp0np+YCEQ78Ts45vmC8sX+OQtG6RzQ+R4QPCGNKKl+6XWtxwPEYQtuFSPj7JliDdQ1YDRq6xAACb6Tkk/Q/YXuxH+0UmX0MI3p483VWVImFxTEuFLPnYTj80+8Ppku4Yi3j25/Som6Rc6b7n0mTq8TO+zfLAEe8R6dDm4p28XIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePZrCjdMMYMRYHKDN0Gh1dYqNYDrL4tEUUQ88Z2f9z0=;
 b=UjGDJNm94745jaW6TjoHf7SBB6R4X6lYshD59Z/uVEOvTnXdtGEQPUoqphnGhRKYnHDm/fqtI4eg7WTqYEx4sDk1hSQO7M144cr1x3TiG8zK1rHXnbSOmrM75hs0CIGCbSLUVfBKH/mjxUAm9XVcEzSYiphObvdX7i9w2ekif1tX5hYfi1OkLBKvO1NQp5/pfGMkyYhs7SnS+2rnqi5g43Im0g/pn+o7fArEZ0TsD+W8n4Drdm6jI1VvusM9NFX5sq/xqdi5yDdZmIsxwfUaSw8TpD/RtEFK9a5W3yk7n8cp9lx1B/pLsrB1l1UoMN5CH/2Kg+5CXRdF9iNfYdlKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePZrCjdMMYMRYHKDN0Gh1dYqNYDrL4tEUUQ88Z2f9z0=;
 b=A/ulQQjQKeZ38d9CprdatA22IlGWbn0Lqp4eoqiPW+086jhHqVfk1jnKcNYq69lj04Z1HINYOJKRPvhiJubuklL4aWmRu+Y037xoI9Cs58tp+UgHpOIFgVaKjs1LEs2sBWb86GYvzv1pJeepVMRYtOOWazYhfxeeM5wKRqWcz64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV2PR04MB11326.eurprd04.prod.outlook.com (2603:10a6:150:2a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:34:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:34:01 +0000
Message-ID: <4257f343-4353-4d8a-a633-24ca154bd4d1@cherry.de>
Date: Tue, 15 Jul 2025 11:34:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] rockchip: odroid-go2: Remove u-boot.dtsi props
 already defined
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250713233429.1376172-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:803:14::32) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV2PR04MB11326:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c9e9cf-dcbf-4db6-4a91-08ddc382bb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVVEWGpDMlQrN3hTbXk2SmJKZ25QOTRjUkQyWFVRZE1MbjBZOFFHZmpzd0lk?=
 =?utf-8?B?TEE2L1RkazlEUGdGaG1WZmYvQ2o3RXVOZGtTWnk4QVAyQVNBL28ySGprT3ZQ?=
 =?utf-8?B?bUJxR0l2QldJOVBNMVJXRkZyQ2lreEJiQ3E4MUltWjZKSE5YdkJjcnM5Zmhv?=
 =?utf-8?B?QzVPQStDeDlXQXJYWnhQdWdaSWorK2FyWWJPRVJ0L05FZGNIMWJIU0gyRTZN?=
 =?utf-8?B?bjhZTUpoM0ZnV2dIR0pCWEVQaTZSMjdtZHJKYjFwTkFXTjBHZTdMV3FnMDR3?=
 =?utf-8?B?M1ZuRkllZDhob0ZRNEFUZkdnRWRTSnduV1NtcUF2azJSb1QrM3g3bHM1RnZH?=
 =?utf-8?B?Y3ZYYnorMWNSUzIvK2tYZUlPd3VkRUV0SElIQlBhN0hDWnFDOXowekhDWml5?=
 =?utf-8?B?dnhIWkJxRWQ0cnRQbHkrd05Lc00zZHFaTzlsV3lVODd5YzlxWlY3citPZ3Ro?=
 =?utf-8?B?S0lxWGNMMWhGMnl6Qjc5Q2xjcU5KOEhTU245Vk1NZHFLU3I3N2xnV2ZiWkgw?=
 =?utf-8?B?K1kyUEFnNGtJUVp2aTV4QjUrZ3FVaDFBWXFFM1JvY09HU0JvVXB1TDlQbDRN?=
 =?utf-8?B?K3dIL0dMcVVrV2pZdlg4OVJzRW5SQXpzd2VCNWw2TkNOd0J1TGhOdUpwTEZs?=
 =?utf-8?B?SndVcldrMXlUUVQ4L2c0dGM3MDZqN1dZR2VXNExQR2xHb3VCL2gwSmZSd2x2?=
 =?utf-8?B?NXl5R2xJMlBtTlI1a3JicXFQNDhJVC85VXBaSlh0Z2Rxc1l3YmxGdVpma2Jq?=
 =?utf-8?B?Z2NCVVZwYStnNExmcUQ0NHRTV0xTUktHUzNSQ0VROGtxQXM1SVptSEtxZ29N?=
 =?utf-8?B?NUliZHdTdWFqUFp4MXdDeWhJejN4SG9MVktIbGEzeVpoUXZBVmJtV0htUEVW?=
 =?utf-8?B?cWRINjBSZEJ5R0pkTUR0NDA4bjNNZW5WZDNDWHNRY2lqSGVDM2ZMeTJoWDk5?=
 =?utf-8?B?YmpBdFMyd2cwMms1R1N3MC80V0dKbnFkYkVKMk9KNmdGYnpldDBETXRiT2hu?=
 =?utf-8?B?SENtNXI1RFVWUkRCVlZLUVUvWFEyKzBGL0FOWjE1M3c3NWV4Rm1mT1N0Ykhx?=
 =?utf-8?B?YU5pQnJZTjZQbGZqb1JrYWVaMTdNV1Z3OHBqUDQycnBhRVhKYVQ2LzU0c3Ez?=
 =?utf-8?B?UXpnT2ltRjB1ajRpVTRvZjZ5Y2daRnVnZWlEWTU5M0JtNFduVkpDaEhseFAx?=
 =?utf-8?B?c2k0cVFVekxpUXNVSUY3bnhuR1JJR2UxQXpEQjc5c01yY3BBbmV4aGQzaTZr?=
 =?utf-8?B?ZmduWStVcVVxdVNHUE93Vk5iVGFGSmJBVk9iVjNRS0JLK25JekdWWUp2elVp?=
 =?utf-8?B?NGV2UG1KZmlMM2Z2TlRWTkYwOTV6L0hkYkxWWnIrSmpvRjY3UXBlbU9wclN4?=
 =?utf-8?B?clpLeTBIU1hiWXZRV3RWZ2E3UytXUDE1WHZ2MlV5TmNnRXNKU0tRMjM5WXM5?=
 =?utf-8?B?dkl4V0FEaXhPY1BCOWgrc2ZJUUVxd0FzTFlDMFJ0RGdnNjdVU3k3LzRWTWhw?=
 =?utf-8?B?dnFZRVR5UnJoUmF0WHFocUpyOWVodWphQW9wSHkwQVV4ajZGellpYzlvVGwr?=
 =?utf-8?B?MXJ6Q1krUnB4ejFaamxsbGMzZTRzVi9jKzkyd2IvR0N1cTRTZjRPaDU4VGxW?=
 =?utf-8?B?emxyRW1kbHpyNUp2SERNeXo0U2UrUitPWUJPQUN3WlREVW1sSWpzQU05Mk5L?=
 =?utf-8?B?VWY4OVk0cExVNElUd3FxZTJ5cWZxVWZLRWxrTCtWc0xhbGdadlU3QnFYams1?=
 =?utf-8?B?WVJPZzFHS0Rrd2VPbWZWL1pOVFF1eWFmaS91eU84SEFmQkROelhqeE9oTG9t?=
 =?utf-8?B?QU1FeTFIYzVFUGVEVTJ1d3YyS1J1NWVEWURjVC9OK3ZvNDVtU0VwSWk1UDEx?=
 =?utf-8?B?VUs3eC9aSmQxV1VEUDVnRGNxb080cjV4Szh0RW96SEtUN1hKQ2dqZnR3SVoy?=
 =?utf-8?Q?WmBcczN6bCA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2x4V2pHcDNURHJOZWVtblZGbUYvUDFuR3dZbW1ZdXpKdndFQzZFZUkrZ24z?=
 =?utf-8?B?SzdIRk1rREJocUhDaSs2R1VPdWwvajRSVGFUeW91RStJakZyNDFGL0ljM0VZ?=
 =?utf-8?B?S1hiUEdRRzg1aUdzUUNyUUIzQVdRak0zeHZUV3pNL2NjZUpmUmkvOUM3WEpL?=
 =?utf-8?B?a1BWdWg0NW5GOEJUcFJYRW9zLzF4U2lyU0g3SGlGRUNyWHlUTTc2MmJ4S2tj?=
 =?utf-8?B?ZlpWL1VWUVNFNWdJdG9wQWRiZGRKdmI0Q2RWdnpSL29NQWJpWHNsS0FDSGZB?=
 =?utf-8?B?VWo1WTNrb2RjWFRxSjhlMTlUelY1MVAzQWF4cXF1WCtxVTBtdmltdjdwZERJ?=
 =?utf-8?B?L2puMnRHM3grSFh1NGtzQ00zZFpwd1JRTUpaVDJjTWdDTDI3UGVWQ0lrcW9H?=
 =?utf-8?B?YUMzaTJLT2UzQThyeGpnZTRlTTYwWXJwR0VibjVjVmkxZDNHeU92bFdZeVJD?=
 =?utf-8?B?dzJaeHZZREM0NTVueGhMSmd1SXBWVEZaUzg3c2R5VTUzYzZ5VUcrVHpLMmc0?=
 =?utf-8?B?VEc4dkd0NGZ1YnFXWENBNjh2WU1tN2xvQTlBalFOdGdiWC81VURmdHlqTlhR?=
 =?utf-8?B?Q05UL0NXUGQzeW9zZk5Qd0gwNFpibm9aem5CMHNKWFAvSXhUa0djMFJHcXBx?=
 =?utf-8?B?cTNMelk1bWYvckwwMTYwZGlYSWw5bHE2VytIR3JCYjBtdGdGZ1FMWW9VNTYv?=
 =?utf-8?B?S21aZjFZWjRydkpVU2gvNmZNQjZYbFByUjFaMGwvSFpLejlDZ1BnTkt4UkJm?=
 =?utf-8?B?MUhnYzJQN3NSeU9JR3k0bGxzbnFtVXZrSTJ4TVlVNEdOQmh6dG0vYXVqa1Np?=
 =?utf-8?B?ODZnS2V6Y0FaejFoM1lzaS9aSEZQYVVHWVVYSFd2S3pTdzJ0U3hVRTVseG40?=
 =?utf-8?B?bWV4NmZrUDExYkM3aDNPSHB1R0pCVEZFalhLaGtnRVpqUlE5UVp4czhqUHpn?=
 =?utf-8?B?RVdwQno4OTRUL2JkY0o1dVNXY0xIUUFuQTYwRGt0Wkl4dEZ2c0dueXlBWkZs?=
 =?utf-8?B?dDRsQndreU5tYVBZeUdlT0ZpRTgxa29jRU9nandpcDR6ZS9BWnVwUThhdytZ?=
 =?utf-8?B?U3pUS0IvR2t3cS8vSzZ1MFB2TSt3L1BzSlVFN3NPVlk1bXhmUGxIUC92NGN0?=
 =?utf-8?B?Z0hOVWErV1FMbU5FeDV0Um55TW01QnFUMEFZeDNqMWFRS3M0V2tyc1VHaGhG?=
 =?utf-8?B?MUtEOVlFWi9ZdmduOTdKV2s4aDN2QVU3cTBDZUNIdTMzN2tiUnFKYWNGRVJp?=
 =?utf-8?B?bW43Y3AyWkJGTzQ4SmdRVjNCSjBudnJEUGZpd01PK0dic3Y4bkFoSllqWFI2?=
 =?utf-8?B?aXY3V0k0eEJ2WGdwUnc4UHVLa3ljOVd0cWxvSytXYld1R01nN2VnTGw4b3hM?=
 =?utf-8?B?OG5JRS9sOUpYWlZUZSt2YWR1RElhTURpa3ZMVXcrUFd3RFl2MG5KYjNGczFX?=
 =?utf-8?B?MUJjY3lSeURCc0gyU3UxS0Zwb2RhakQ0RVhpc2FLUy9ObzlvSnZPU21lazlO?=
 =?utf-8?B?ZmRvMzRHbnArNTJFT1hpSC9CSjBmVm9QN08rVnZRNDRwYlBybDJZUDdKNmk4?=
 =?utf-8?B?c2NqZmwvOVJhb2tOQ2lGR3pjeElDbDFTOFk0OVNXSDRDcHdDVkw0VXVaUmZv?=
 =?utf-8?B?ck4ybGxMb25yQnJ4dU5xQzdUQkViUmR5Wm5hQ3UzMFFNY1ZmMTJHdloxL2hT?=
 =?utf-8?B?cDg0OEtKRkQ0K0cxVnJhTUxiQ0ZXR0EwK3dBOXV4T05Gd2E4WjVzWXR4azRQ?=
 =?utf-8?B?dWJhQVBjYm9reEhsLzQ2enRCaVlyUVZnNUhtemMxUS80U3lpY0pucndqNGZo?=
 =?utf-8?B?ejR5OVUrUk0wOWpJalltL2FVMzhRaktNT1NqZURzNkxaZlNINEhXM1MvTDdv?=
 =?utf-8?B?dzJOeGxSdWhDSzB6YUJqV056NVpGanlLd29rY3RnblVBMFNhTDA2N1djdlBW?=
 =?utf-8?B?aVo3SjRoUlBqV00vTUpBZEpWd21URHhhNkVaTlUvM0hkS3QrVzN4aHZxNHhC?=
 =?utf-8?B?Vmt5MVdEZy9sbVl2VVRnZmFLTCtBY0V3MlJiNFYzS1BZbXhnQWlGa0hsbHRt?=
 =?utf-8?B?REh5ZTVXVVd1RktEZTkwYnVVRU5ZVTllUWJIVXNDb2h2YVQ5Zi9FTFRzRTVY?=
 =?utf-8?B?dWZFN3JLZ29GM0ZUSVovRDlLVUw0eE5ZMjluM0FiU2pldy96N25nMDlPN1Zh?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c9e9cf-dcbf-4db6-4a91-08ddc382bb8f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:34:01.8047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MUprJX8RvTG1stVgf23Z6jnksqSXkIrUWh6cda2lPF5S0KM8Ld+VyOBWYBFWzuVT/WVdvnsgv7YNdnnxuRKXAtOfRCN5zrFdbLw24043kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11326
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

Hi Jonas

On 7/14/25 1:33 AM, Jonas Karlman wrote:
> DTs from dts/upstream already contain aliases for i2c, mmc and serial.
> 
> Remove the aliases and status=okay that are already defined in upstream
> board or SoC DT.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> This also remove a bad re-defined alias for spi0, SPI flash support will
> be added/fixed in a later patch in this series

This won't make it to the commit log in the git tree but is an important 
piece of information.

Please have a separate commit just for that or at the very least have it 
properly explained in the commit log as I checked the diff and did 
notice this was different.

Otherwise looks ok to me.

Cheers,
Quentin
