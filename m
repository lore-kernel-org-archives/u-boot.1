Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF76C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 11:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6726687F2A;
	Mon,  6 May 2024 13:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MEGmI9jc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC9E881DE; Mon,  6 May 2024 13:07:41 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEBF87F2A
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 13:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmQ2+zfSE14Uj4uNwf1hPbhcSekB1rUo3fwRwIQCFeownh6n3j5PSWIh6ne52wDWBiz+ODY8Is4PA+0udmZ5yUm3eD6EbeYm73OR9FGHnhEAFxLdVtcJaooUClGkEyDgqYR6NP7jmmfHIfkD77JZOWSpKMomHLT1C9epzmpKE8jJKN7AGHK7Jks4mnAOKEpwbFTDpqyqIpDAVeMXN0f4zOgvgZvimlYuy/iSGsqRXajIgsNe1AvxEriVZxDvxJtx/nJakjUGLL0zZAfBJiG5EG2OBY6SwafloxNe10Iro3/8WfIV7bk5jzL8dchXbR2YBN6jep4CBmV2qKKhXdwlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GzSRXezB1tOJNNBJwMS3SzpJ9KnZh+qR3BEI3AGYz8=;
 b=Ghc8ZXtqCqzIXyx5qD5kjWH9NkPmzKz9Apds6D7LdG6/uLKY+kjp8/aLXa/Z+JqlXUiyDl2wIibpJ4W9G+3S8VF9EJ1+QuoupYlaoztdje5MZE6ktlfBgs6RNsHzBpwyMVSNPRtxARtD74a2vAiwsXQP5Oxc+5LvHvYkFpa7YjtLWWAxSICqZAmDtUcyL3OGxJ6lO7/tkHruY5n57Bpk4v5JeUXB10oWenDy7FRJPRQT6xS9t7OVbxMo44eClkyVlCPEG5PcWnaw+0wrZBZToGBxi/jfwq0/nsEwnWhzZIX/uTAyEA3b8pVukFi0zhW5P3wSSd7r26xaoGG5lXFAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GzSRXezB1tOJNNBJwMS3SzpJ9KnZh+qR3BEI3AGYz8=;
 b=MEGmI9jcBJ5KhLa1cN/SOWeW+dgNnMdxJ+9flAdKV2ztudF3rtAJ6x7P2epxPEedJVoJns9g/ngn6ibBEReTvP31MxtHF66rs7ykgQ3p7bxTRI1qVTJzmkYvYGZIOdx/1SJ/9Gxa9xRPIKyKZtgYWrqNuDH62Fr/d28RtYDxJvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 11:07:35 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 11:07:35 +0000
Message-ID: <b0152407-ee06-4c5b-ae5c-210a474ad598@cherry.de>
Date: Mon, 6 May 2024 13:07:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] clk: rockchip: rk3399: Improve support for
 SCLK_PCIEPHY_REF clock
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240501162308.875193-1-jonas@kwiboo.se>
 <20240501162308.875193-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240501162308.875193-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|DB9PR04MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: db4f0e81-98cc-42e6-1b02-08dc6dbcbbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjFiNC9TN2lyWWJwVjY2YkUxaGRERk5rYVhoZXRlM3o0dWh0UlJ2ZStFelBl?=
 =?utf-8?B?MTFXbEloZ0lUMDUwMjN5aFlQb0VDR2FKc1l5L2pTR1hGTE5JZTFPRFNYcGVn?=
 =?utf-8?B?WGxRSGFVcjJaUExmTncwZjBwM3BsSUlvZlhUdklycjdsWUo5am5uTWplVlpH?=
 =?utf-8?B?RDl0QUZCNlFSK005K0VvUkF3Tk8yR3gycG1iYWwzR3A2MGtKcDRKZjlCSFdv?=
 =?utf-8?B?Q3d6ZU1GSUd5QjF0SFdBYlBsQzZxTHlFek9mVXUvL1BRZXRRdUJBZXFzRlo4?=
 =?utf-8?B?ejVSSCtBMkVGZXJMWXdnbXRCZGJZQ1hHWlQzTVZjdVJuc2pZeDVIYThtVzgz?=
 =?utf-8?B?R2JhVlVDcUdOV3pwWCtXdjVueTNGYXd1R2YwMlpSYnRtSHJuUlloSTh3ZUo5?=
 =?utf-8?B?ZER2ZFQzbHJUY3F5YjExOUwxaWdiOHRvMCtGd1dReDhZTlBrclcvQmNIaTYr?=
 =?utf-8?B?eFB1UjZRV1BUYXEwTU5wWVlwY2Z2ajF3VU50RmNWVk40MnF1VldDbUV3SHQ0?=
 =?utf-8?B?MFd6UUsvdzNJRHJkT1JwbHhRVnM4MDJDMGpWSjlydDZRMU92K2M2NmN1YUhL?=
 =?utf-8?B?VFlHcVU4THRBWHNTYkNDV3ZZUlVOYVBiQzA0QzdINHc2cE55WEF2TkhrbHU1?=
 =?utf-8?B?T0lkZncycS9xUzRIUUg2enhxSW1iT2I4d1pOZXdLUEh3TnRYUXhCWGo2V3Z4?=
 =?utf-8?B?djBNbWlDYWNzYXZNb21EOEJiNThKaEF4S0w0MDAwNXNUcGQ4ejhTS1NzWE5s?=
 =?utf-8?B?N2JPaE4zN0VGSWhxY0dsUnd6WmpGcmxLRWtIT0dpbmtDeWdLQ0NoQitwTHFs?=
 =?utf-8?B?UVlSZGM5YmFLWUp4VU8zMCsyc2YwNkxVYTZYWCs4ZzlDRTUxaWswTlhnamh4?=
 =?utf-8?B?Ykc0SmR1eDhLSENsODlRb2pvRnN0cmF4N1hqWDEzaHkxRGw1Qm5wOHc4Tllx?=
 =?utf-8?B?QzlCVkw0MEZuaGVGYkR1YnJvc1dkTzZUaUViV01GQUM4bk9qT2t5WGlZQ09T?=
 =?utf-8?B?TXVZM0gveVp4VnErZXlLb0ErYkJOY1ZaRSs1RElJUEtmK1o3VExXVWhrYmRu?=
 =?utf-8?B?blRsOGh2MmVwY2Q3cVlrYUpLU0hSTXVyQVpkOXNBRUxuUzJJZ0Q3b2VJejNv?=
 =?utf-8?B?NWhSN2RQVjR5RkZCVFBGcXpJZTFQUjh4dlFkUXFmSCtQc01VWHM5eGlKY0xm?=
 =?utf-8?B?Y0pmM1Q4MHpsTGRFS3FVdExzODRDREhwSnlreEdjUWxTb0tpYkwyVnJHOFdk?=
 =?utf-8?B?amlWZTRWZ2dzSHQrR01UTHFkWDZJWk5WMVl5Ujk3OUZwellCenpsYllOM2NX?=
 =?utf-8?B?dklCUW03RUdDNUVFaFI4Y0hIQUtDRnAzRmxFRHN3REFTV2EzT0k4akhvRjVB?=
 =?utf-8?B?bTVtOVkvbmIvTjkyK0dLZ2s4bmpFaXh1S0gyUDRKRmtrM1AzWVdwSnZ5NDlS?=
 =?utf-8?B?a0dwNnZYQ244Uk1QSnJSSjRzMm9INGxxRTI3ODJRaHBEVzFtSGpLVnFaT3NC?=
 =?utf-8?B?Q3hocVhwc0RJTWtHMk9HeVRKVWNHWFZ6YUd3VU9QS1F3RHc0SzZ2SFVYZTdZ?=
 =?utf-8?B?VkJhOXFaU1VIc01jMHBGMi9WS0RUSnVpdFZGWlpxUEJVL3JHdlFveDh2VmpT?=
 =?utf-8?B?WWR2b29hWTNUSWVIUmo4akhxZ1lSUzFRY3dNZWkyZWJFdkhpbytIdGc4TWJr?=
 =?utf-8?B?Mk9MTncrNndpbzZhZTBTNHIrMlEzU3NUVS8wRjJ1RjRycjJQMExIYS9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDNLc2xhZ3Y2UTB2dC9XcW14dWJFRk8rTFRLN1RLbTdqK2VBZ3NqM3QzdW5D?=
 =?utf-8?B?VVpTcmtvZFlRTml1L3B1dHBCbit1dUxmZXM4b1k0VkZxcjliQzJxbUxLZG9G?=
 =?utf-8?B?ZE5LdGV5WlgrcEtxWGFlZHdHYWczM2xEWlNZVTk0WmJPMndlT3kvZi9RSHQ0?=
 =?utf-8?B?ZWxyRm9DTjZCeFA5Qjk4VEtrQm9LbmFiejljcnJoc1NKaWs5aGFFOUt2Tng1?=
 =?utf-8?B?N3RDVlViK3hZYVhnYkRPb0o1MHRCMFlGNkVwbUdVem5aUW1HcVFoSjZkWDdn?=
 =?utf-8?B?REFiVEY3UEphSm1wdmF3a2dGZ0ttLy9YTzZVU1BsSW1NemNaRUJOTk9tNGdO?=
 =?utf-8?B?aWJCOGlGTzZRVExiMFZHbEZPUXk1eDBCMldWMTJWMDh6bU9VcEM2eXg0eHQr?=
 =?utf-8?B?QU9CNUZkVDAxV3lKUXZUeWppQ1hiWHZrU0NzL3pJMzBkUzZ1L0p6OXBXa281?=
 =?utf-8?B?aW8zTFdSWm9nVy96NGR4c25rUzJkeWtQRmVtNUZwdHpRR0swRUd3bVowU2tJ?=
 =?utf-8?B?SHFCOE44ZGJkcCtVbHJXTUp4OEMzRUVYcWRtc3BuY2RkYzdRc0kySlRQQWN0?=
 =?utf-8?B?dG1BalA5OFFKbFk1NkFlSWVibWhDSUUxd1B0UCtITDBlMnRYZzMyNzdCSFpz?=
 =?utf-8?B?Z1BnMzJuVm5sMVB0b1AzRC9YMkVQaDNiNkhyZmNLZVB3bGJlNWVzcjg0YVVo?=
 =?utf-8?B?TjRCcno1eGhoSTBLS1hRQVB6SkVaR0VLRklxV2ZwNnZIOG9EVHJLVERXcGNZ?=
 =?utf-8?B?bmxhVFJnSkxlRFc2QlFJWXp1S3Q0Z0Y3d2lJbVc4ZEVuK09hazR3aERUeVlt?=
 =?utf-8?B?YjdlMStLRWxtczhGd09zUFpDRzQ1OFhpc01TL0xYdmZ5aVZneWpaekVOSXBS?=
 =?utf-8?B?MlZxRUZPYjVndnh2azlnV0E2MCswTURrL0RMYVFnNWJwOUNCcUhmamVvUXR6?=
 =?utf-8?B?STlwc3l2TTR5Z2JIdmJzUTJqWXJBc2dOaHZpN1crVmh6ZVBiMTZMLzVBc2ls?=
 =?utf-8?B?bVllaUQ2bEwya0JzVEVSWnRyeUxIdHhqUVlZK3VHdmNsSXZQcFFoaC8ra205?=
 =?utf-8?B?M3MxRHBWT0daTkVJMWxKa2V5WDVaSFNpSGJiNmVpOS9rVHRPSmhIVXZDTEw3?=
 =?utf-8?B?Q0h1T3ZUcjIzYVp3MExvQmtCQXRJQk1SR0FxTk81ZXhVWTlaL1IyekdqSXhK?=
 =?utf-8?B?aHNXdTd3ZEFnalg4OTFmV3M5TExwNUhhT0J2aEU0VytoMDVTeFloZFMxSmow?=
 =?utf-8?B?QTJqb1BPaG41K0xqOERoZGZOSUdKUFpKdmFKeXc0aU8xZXRlNHZEYVNUZU5u?=
 =?utf-8?B?K21Scy9xNTI1YytkY29OWm8vV3FCdFVSVEFTbVdCRGFXbUhremhpRldTOE0y?=
 =?utf-8?B?eU5NcmhTQWNHd1A2L1hGMkh3RnkyYy92RUhuTFR2MzdyMERXakJzelp4MG1Q?=
 =?utf-8?B?NC94Vk91SVN0Q0VZQm9ZQ2YxVEQ4UmdzcnVuWmNaV0RuTnM5b3NTMVgrU1VH?=
 =?utf-8?B?NUVWck1KZUZqRllWMjl1WGltU0IrTHdKK0tISWF5MEJmRkswTXJtMERDSzJX?=
 =?utf-8?B?U3JDdktmR2MxVTNZTlJPejFqQi9BdzJ1NUEybFVDWUZxSFVRSnBtekY0L0Yw?=
 =?utf-8?B?MzNKUlplYXVTbkw0Mi84RnlIL3RGdUZxaVlvcTBHcWkyclV5bGZnL3E4TEhR?=
 =?utf-8?B?NGFFRkVJaEtGOUpiS0EvbWFabVI2UzBlb0t1dFVEYlgrNmo0Q0I2M0o1Y0hE?=
 =?utf-8?B?UVVFaW9iTXhVRVJOZVVwN216Z2srdDM2dDZ0RGFFMUpELytNRkQ2NFR4NGpx?=
 =?utf-8?B?WU4yeStqYnNnOTZLRXBwTHZhT1hRWTBKczgweEdHMFJSSEd4OS8yWE5qOVNJ?=
 =?utf-8?B?NDZ5cno1SWpxcTR5ZHlIT1lVblRhMVF6bWdlM2FGZTBwcmZWUHFLTzdLNGpT?=
 =?utf-8?B?TkVFR0RtNVhDV3Nka2ZkZWhkZnlRd1NGdXp1dks5T29uc0JtN3UzUldVS0Jy?=
 =?utf-8?B?bldFaTlna2ExZGVkY0ptMUxHZXMvZE5KSFJielV5MENBVU9lUE4wcnI1Z3Uy?=
 =?utf-8?B?ZWlDNmJtWm9rSzZLRU1CbWYyUFdvNkl5MTBIZFdodEppWWViYzNOVzArVUNJ?=
 =?utf-8?B?NS9hM0srUXFjMXZ5QjAwU0VUNkkvVFU3R1ZlNTVwZi9QV3YxN0psYS9NMnhV?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db4f0e81-98cc-42e6-1b02-08dc6dbcbbce
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 11:07:35.4058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVhzj7Xe7jA0Bp6fWkQiDwLHaPBWCs+ScZoTj2VzliR3YifgQv/G9rEoBKypSqCGGZRcBFmnLi4QX9tG7u4h7NhPNcI59MHWnCUg/pbXhoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9401
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

Hi Jonas,

On 5/1/24 6:22 PM, Jonas Karlman wrote:
> rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
> SCLK_PCIEPHY_REF clock.
> 
> The existing enable/disable ops for SCLK_PCIEPHY_REF currently force
> use of 24 MHz parent and rate.
> 
> Add improved support for setting parent and rate of the pciephy refclk
> to driver to better support assign-clock props for pciephy refclk in DT.
> 
> This limited implementation only support setting 24 or 100 MHz rate,
> and expect npll and clk_pciephy_ref100m divider to use default values.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Implement partial instead of dummy support for SCLK_PCIEPHY_REF
> ---
>   drivers/clk/rockchip/clk_rk3399.c | 59 +++++++++++++++++++++++++++++--
>   1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index 5934771b4096..0b3223611a32 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -926,6 +926,26 @@ static ulong rk3399_saradc_set_clk(struct rockchip_cru *cru, uint hz)
>   	return rk3399_saradc_get_clk(cru);
>   }
>   
> +static ulong rk3399_pciephy_get_clk(struct rockchip_cru *cru)
> +{
> +	if (readl(&cru->clksel_con[18]) & BIT(10))
> +		return 100 * MHz;
> +	else
> +		return OSC_HZ;

Could avoid the else since all if blocks return, no other logic than the 
one matching the else can reach that part of the code.

Therefore:

"""
if (readl(&cru->clksel_con[18]) & BIT(10))
     return 100 * MHz;

return OSC_HZ;
"""

works just as well.

Could also be

"""
return (readl(&cru->clksel_con[18]) & BIT(10)) ? 100 * MHz : OSC_HZ;
"""

[...]
> +static int __maybe_unused rk3399_pciephy_set_parent(struct clk *clk,
> +						    struct clk *parent)
> +{
> +	struct rk3399_clk_priv *priv = dev_get_priv(clk->dev);
> +	const char *clock_output_name;
> +	int ret;
> +
> +	if (parent->dev == clk->dev && parent->id == SCLK_PCIEPHY_REF100M) {
> +		rk_setreg(&priv->cru->clksel_con[18], BIT(10));
> +		return 0;
> +	}
> +
> +	ret = dev_read_string_index(parent->dev, "clock-output-names",
> +				    parent->id, &clock_output_name);

Are you sure this works?

Considering that parent->id seems to store unique ids, like 167 for 
SCLK_PCIEPHY_REF100M, I doubt we should be using it for 
dev_read_string_index????

As per documentation:

"""
/**
  * dev_read_string_index() - obtain an indexed string from a string list
  *
  * @dev: device to examine
  * @propname: name of the property containing the string list
  * @index: index of the string to return
  * @outp: return location for the string
  *
  * Return:
  *   length of string, if found or -ve error value if not found
  */
int dev_read_string_index(const struct udevice *dev, const char *propname,
			  int index, const char **outp);
"""

So index here means the (index+1)'th string in the list of strings under 
the "propname" DT property, I doubt we have properties with 167+ strings 
in them?

I realize that rk3399_gmac_set_parent also uses this, so I'm a bit 
puzzled right now...

Don't you want to use

dev_read_stringlist_search(parent->dev, "clock-output-names", "xin24m")

instead?

The rest looks good to me.

Cheers,
Quentin
