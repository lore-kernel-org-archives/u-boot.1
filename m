Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771A3D5B154
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE66E89126;
	Mon, 28 Oct 2024 22:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="JkfUjjFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CF888D06; Mon, 28 Oct 2024 16:27:29 +0100 (CET)
Received: from BEUP281CU002.outbound.protection.outlook.com
 (mail-germanynorthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20b::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C5B89098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=erik.schumacher@iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl15mN6TyUfP0xVdUwiCf7Q/smjbB44u/GWMh5x3BxTOoGLCPSJy01nUYdz4WvWZLfXWiL2WbbEHOB4PcuaxtFRLzeOufTWGVIyaTuXRTm/za+ZZKHpI1ahdDu4RK0x7B7Ddk/Xpj0jZUV8M+rxr1ndDrTjSq8ZrGjbsCyPRk8GKiq0vfWg0P9GLH5meFg78cGnATGnamx9LGQhlW6xHMBja7y2ZWt1ztdDhWl8SudQMFaZKUCa/DSbk8LtD+BBaVFzfJi7BH7skhVziJVNRYuZqJD7+nznGgxvavCyzfiL+fqSOj9KAFUw/KmKY7ODbBOi8xeVcQFGeLPlmpTgEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA3hZsononhLoRtcCeXQeCnyyR4Mwrf+/ALC5E1BqDM=;
 b=fClziKxsF/sERlkaLXgAxYDeXrVv1ILjIz29rK+AykKoPmL1UIDp/Xk5s7q/Taw74rz9q2s2kiX1I8Mz9CRTNTGbMxNg5tNm3LNbE3HHO2TpxTynk9dEoprgh20PNH55iOGQXO0c4nn+UpskulzYRjzx/c8qA248WfHEmPJg7enDIMwUdTEoYAZeLXDlAKts64+Iq5e1JSH/JUeczrc9+2kIhkA81QNI2LJwhGJb+Fn92qd0+TkP63ak3YVeDY8790X4YwqICbNcMwHRfCZwPmZ206V+QRBd5e82Px7KdqDXkMLa+1+thXta4RJW9/G3m2JGFY9xNKJSm89zL+4ObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA3hZsononhLoRtcCeXQeCnyyR4Mwrf+/ALC5E1BqDM=;
 b=JkfUjjFCAYUFcgViuUxbtICiRfhbzrBk2VODXiGwC1pEYcAkbwZOEg5PIjnuDRgMrhcXdbVEmDm8ypmlPWZc8uHR3xCNpjy9Xe73A5rVLrzwnJ7NwSIzFs2l3u67pyeCWCa+f4buOJ4CSO4Pxcr64FHg7LIHdquOl+eiEq12/85gydq66xIASQ2ii+ExaxeyMyQDdDoyTPRx3rEibDgcknu8bWBkEM+GtzUE5cAWXjAEwd6V8k7YvhqhFuoKT1/v+4NS+V8KzoLYTad7m48AGvR3ztJ+2a2HAT1xhZ2lY+P3Nc1QMHevqBkWwJm6gnPqbk0jelGABeEM3m236PU0vQ==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 FRYP281MB3001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Mon, 28 Oct 2024 15:27:25 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 15:27:25 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "pro@denx.de" <pro@denx.de>, "marex@denx.de" <marex@denx.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, Erik Schumacher <erik.schumacher@iris-sensing.com>
Subject: [PATCH 0/3] Fix eqos rmii reset on i.MX93
Thread-Topic: [PATCH 0/3] Fix eqos rmii reset on i.MX93
Thread-Index: AQHbKU3jHdEyGQDnBEuB31vSsaA40w==
Date: Mon, 28 Oct 2024 15:27:25 +0000
Message-ID: <0b4ebdf6a0219a871eb031fccd9aa6d8c9cb2348.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|FRYP281MB3001:EE_
x-ms-office365-filtering-correlation-id: bca8e61e-ff5f-45e3-e4b6-08dcf7650674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OUw1bVJaM0xjMStuMGlQVHJsVVdDbko3WHVJSkhUVnRmVCtyeExhd1hhTEhS?=
 =?utf-8?B?YXdkclhtcERBQUx0SjcrMHoxSW9pSU5xQU40clhnOTFJd2dDa0N2VlpDSmVP?=
 =?utf-8?B?dzFpQXJ4NDRFRDZoVWhObUROeTlkdzZJam4zSlBnbEtqUnYxZ0NuNFlsOXRH?=
 =?utf-8?B?dXArZkttK1RjdnhRZklqam9rcmhmYmhaUHMzeXZRbXl3NXM2QnRFK29ZZ0NF?=
 =?utf-8?B?OG5LSG1NVk5janBsbkdDSWU5SHR3cDh1TWxtaVBPMTlibXZETGl3d3pQbitZ?=
 =?utf-8?B?TzFsVisxTEVMbTFhSVQxUXBmdExEcDBxVGdKTmptaVptWVV3blpiaGU0RVc1?=
 =?utf-8?B?VG5RTmtuT0wxVXcvNFl1UVl6WmVHekQxN2E5OHpkbHlkeloralBnUHVkWldi?=
 =?utf-8?B?bGV0eXNiSnZBNGhuTXJhNlV2TmwrQ3ZLTVJuMDZpSDNNcktqWW1rZFFmV0tl?=
 =?utf-8?B?R3J4V054VnE4THd2WUN3UGZjakRvNldHZ0QvblU2MGs2L2M5WmF5WGVaNDVZ?=
 =?utf-8?B?TzRVMU05ZXlSTm9ROFZDTGRJYkU2WFlyNjczRWV2SmJvbHhJRElnMm9kV0JZ?=
 =?utf-8?B?bUV5UEk4WTdkV25aWUs0UkUzbHAwZ080bm0zR2x1M0Y2VUxqZ1ZUYncvT0ZU?=
 =?utf-8?B?dk1ubGt4aWVjMEpIUy9xa1J6czloZ0tzdkhJUDh2Ui9tZVdEYmJPRHZlb3hq?=
 =?utf-8?B?enNlaHhCdlc4eFd1cm04bXpHbEZESzYzMForZXNITm5CM3FjZzRPaWE5bzVF?=
 =?utf-8?B?QjRmOUs3ZjM3N2c5T0x0MzZaRWRnZm1KRHUyQ1pMaVNzQzZ1MlUzTVBSVDF0?=
 =?utf-8?B?MTJLalQ1WnBIZWQxZXVORFc0SlZRNzlkckZXMFl2SWsyYXRPUUIxNlFsQU1i?=
 =?utf-8?B?a2UxRkRNbm9YaUNhd3VIbStBUjNkUFZQUkk5ZkNyUncvemRacmEwUFlxSmE0?=
 =?utf-8?B?Z3dhd01TVEpqc0NxTGV0TzNORldmcWxOcENxbjFZNUh1UHVlckkzWkZ5VVZD?=
 =?utf-8?B?K1dsWTRMZTFIVTFhSUlzQlAzNGdYeGo0UHJtaHpoYXpoMXA0SGpTbDNWSENr?=
 =?utf-8?B?NG9CaGxlZytYZGF4UU9zSGdEMVE0cnJMU0NsMzZCS1ZwSTdRck1oVjYyZkxt?=
 =?utf-8?B?TmdJR3A0NWNYV2ZkMGk3MjFoUnVtNktkZHFJSkIyc2xlLytxdEpaTEZqNXhD?=
 =?utf-8?B?NWhwOU93MFMxY3FibVNrVFk1c1FMVjgrOEdzejdGYWtZdUpIUlpTUC9JL2dB?=
 =?utf-8?B?SXBxWFlqNEdUNFNWQXBIZm12VU55S0ZNUnB3RHNwN2hJQ0dsc2hrTVN4VEZX?=
 =?utf-8?B?L1M4dDZUWWRnSzhscVBiT2lUTVlGZDNIeWw5eVBvTHJNZktka1F2VktrOTFO?=
 =?utf-8?B?ekdmR2JiU0Rkb1haUEw0RUtDNUdkTnBTVVZDNlA4MlNidzIydnVtUkRjNXQ0?=
 =?utf-8?B?UWNvRS93MWdIa0pLRzNJZFkvZmNjcDRNWHg4aDFQc0U3ZXZrVGJVbDNsNGFH?=
 =?utf-8?B?UDdXN0tscDFLUklsV0xpV3hUYWJJZWl4M1JpbTB6enRRVEZ6SVFLMlZpUjNJ?=
 =?utf-8?B?TnZuWUh5RHI5a09JTHlKSHV6Nm51WCt0QjJiTnZyWXFwOGdNL2NvQlJtaWlI?=
 =?utf-8?B?TW5BUTAzYkR0MzBiQXlObHZTQXBIWGY1NUxaODlnVDdxMnBtc3kxbm81QXBR?=
 =?utf-8?B?V0pRYVUySWpMdW9Kanh3SVhHK2kvSEtRMDhuTVpCL2piZEF6NFFSMzNidUN2?=
 =?utf-8?B?eVVtbWdWVzA0dEpNRkZVWGx5TFUrUFBzaEJsZUJXMUZKZGpLRVVGTVVRbUFM?=
 =?utf-8?Q?tEQ05xbU6cytTRZAQPo4v7tnNgDxmdIZVHga4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STR0UEQ0S3BJeW5uakpjbzNKSTA5UFdyOFJnTENBYjlpVnZuamJGZmZ4VFFs?=
 =?utf-8?B?Q00rTTJRdm10cWQ0MUlRalFhc2ZsZkpLNzVxOVM3SXJ0M3QvV3VFT0plMGpY?=
 =?utf-8?B?dDF5V2xkU3oxOWhSNk81YjVJNGZQSHVaTGNDbEJqd3EzaDdQWmRVcS9hY0k1?=
 =?utf-8?B?UTR5d2tJT1YvT0ZYdk5ETEEzV01mcHErYmJSQ0lkYzhIKzZkUWpMUmdwSTQx?=
 =?utf-8?B?RERmay80Y01IcWxuS2hkWUNENlkyR3NYeFlYTE1kNUZ4MkMwOW5jTFFqYTVB?=
 =?utf-8?B?SlJBK0ZJT1dQWVllYWRlbk8rWXdDVWlwa0RieTRFaEltSzZVTGtKWTVidjdI?=
 =?utf-8?B?RktCRkNVQ1BrWWJMbE5jTHlIVktqdzFsTSt6dHRZaXU5NUZNY21NeFVIMG9R?=
 =?utf-8?B?L1B1UVNXQ2NGUmhPSVl1WnRMRERLRFhWekV0UlF1MUMyMWxtUkpiNTFPNk0x?=
 =?utf-8?B?b0crQzdsdmR5cXNuRzZwTkVhTTVMcEU5aS93K0tST3Jxc2F4ekxRaWw0WU9u?=
 =?utf-8?B?S1JQNUdxVFE2Z3VWR2xFd3ROZkQ3NHNVOWM4c3kvMUpQK24yNkJvOXAyVjZs?=
 =?utf-8?B?Y1orcjNMRUFtWVRzRTBtM3BUN1J3YUs2SVpycFZHM2U4R0RCSmViWXJ6UWdP?=
 =?utf-8?B?ZC8yd1MxVXgxUTdVZWVSZHlydmN0NGlyaXlkdHNNVHVHdkYvNGROWlQzK1Zk?=
 =?utf-8?B?R3RwQzY2cytLL2IrWlZ2NnZJb1ZHaFBsNEwwaDZhTVdLTlphNzVGdHA1YTBm?=
 =?utf-8?B?WlowSzIzWmRpVUdvS2JWcThOSDN2RXpEUC9ud0V6ZWpSOVRvQ3A3cnNkejdS?=
 =?utf-8?B?SVZXZHlnUXpyWkpTSEthMC9HUHFTYkNWOW1NZDI0U3g2b3FWU2g0V3V2T3NP?=
 =?utf-8?B?amQyb0gyUXptaFNuL2hkdGV4NlloVXVwZDhrZXNEYWowQkJEQTNadGZ5U0Iv?=
 =?utf-8?B?eFlvazljY3U5NGM1eFhTMnRTdm85YnMxbzJxZHdFaGV5dXQvKzNlazNya094?=
 =?utf-8?B?TDRiSEhIa1lWaXU3eXdUM0FyNm5lUC9QVnNPZ3RqVkRyUUxQZFJxZW1jOVNP?=
 =?utf-8?B?cmt4TlNvQ3dscVgwYVBSRm85QXpLWHlwMHBkUDRhVy9GUWpxMkpJZktxOXZ0?=
 =?utf-8?B?Um5nUko2TFU1UjdFa2t6Z3Q2MGhnZjN5eWdmSlZhaGMzc1BpTWNnOERZbHE2?=
 =?utf-8?B?UWpyZWhOKzh1UmVIaUZmNkNGdll1K3NrV2U2cHFLdm13ZnhRRkhoYzVRZWk0?=
 =?utf-8?B?THlFcmQxNlBTeDNxUDJhb1J3aDU1ajlCRjhIS0lwMHphV3FJVXFML0FtR2JR?=
 =?utf-8?B?UHc2L1pUcjBrd1Z4aDU3Y2lOZFJGTTIxU1ZjNTYxb2diN045SVNuUmh3QzlB?=
 =?utf-8?B?ZWlGTWNVcmNDNkxRMmZqckpMUjZxUW44dDNpa3VRTDVIRGdacXlteTF1WWVp?=
 =?utf-8?B?VGlmMmpGUk1QbndZSk8xSUFSSndGM3g5czlTVlM4dnhTVm10d1I0K0gxVXNi?=
 =?utf-8?B?WldxbXZCTHNUWmt5Z2pPWDJadCtTUGw3ajFuMWt5VkltdWQ1ZzVXai9EWVlU?=
 =?utf-8?B?K0RFdGRtaGU4cmZWU1lsS09xb2pGRFpTcmpBUTFSSlJ2NWtUOUxYQkNaMlJS?=
 =?utf-8?B?b1c5c2pXdDVib0hNVTc2dTlNZkw5UklWVFZOdHhnL0FYaXZCeHY1cWN5Z1JV?=
 =?utf-8?B?UEN4MDY5N1BONG1naUpzSytOcWdwbnpqUUJqVGs5VDVJRk9NZGNQZE82ekxj?=
 =?utf-8?B?djk1amFFQm5sOXg1Q2ZLOW5zMURaK0l3eFNrTnc0cGtnQVEwQWdjYkZvVkhU?=
 =?utf-8?B?OXVWU3Fpdnh4ZlUvR2M1MnFaZE9ZcmFZeWxtL0tEeDlWWVFEWVJrZlNOQUVG?=
 =?utf-8?B?RkMxUHZWeVMvNmdLazBVdUp0dDJ0L1MweFY5bXE3YU5Ld2VWSm51dG5NazhU?=
 =?utf-8?B?aW9Qb1pZN1BDRzMvcnZSQjBiK0NEaHF2RmtGWVdjT1I1VEppWGxFYkZ5ellV?=
 =?utf-8?B?Vi9ETnl4alRBTmd2M2VHVmlyTjZTaUF0L1g2NDFMemR5ekp3cWt0ajR0SjZD?=
 =?utf-8?B?N3VXc3RPSU5nN1BCYm5vR3NSWVNXcVJuZ0drakExbGwwMjNjYllXaVRyZU1x?=
 =?utf-8?B?YWh5aDNVTTdGU0RIUjRaNWtGaUxRL1Q1Ujc3QmNLQ2xzQlN5a3dCM2VJQkJs?=
 =?utf-8?B?VUNvTGtIN0hPaTFiMmdpUDRxc05yNVlpRjBTeVdDcmFHUFBGeUhXbk5UaTBM?=
 =?utf-8?Q?zRUP3K/1LfYf1ibLuqPxpcXSWbE1hHW5+1jLJMnGbQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <002FAAF66946FC4C8516B203D8DBDA85@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bca8e61e-ff5f-45e3-e4b6-08dcf7650674
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:27:25.1833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYeA8XLajHU2tby7uQyFVQQzmtgKInX6hLRtDjO5faJmDCMkp6iq77mT0+BF/ButRhe3R9JH1fFy7ClNYCzI7UZY2BCPaVV4UCgQvVYbbkElpBdjl1+ihSgYL7tZWei8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3001
X-Mailman-Approved-At: Mon, 28 Oct 2024 22:32:48 +0100
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

VGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyB0aGUgd29ya2Fyb3VuZCBmb3IgYW4gZXJyYXRh
IG9mIHRoZSBpLk1YOTMNCndoaWNoIGZhaWxzIHRvIGZpbmlzaCB0aGUgZXFvcyByZXNldCBwcm9j
ZWR1cmUgaW4gUk1JSSBtb2RlLg0KDQpUcnlpbmcgdG8gdXNlIFJNSUkgb24gaS5NWDkzIHdpdGhv
dXQgdGhlc2UgcGF0Y2hlcyByZXN1bHRzIGluIGFuIGVycm9yOg0KDQp1LWJvb3Q9PiBkaGNwDQpF
UU9TX0RNQV9NT0RFX1NXUiBzdHVja0ZBSUxFRDogLTExMHUtYm9vdD0+DQoNClRoZSBmaXJzdCBw
YXRjaCBhZGRzIGdlbmVyYWwgc3VwcG9ydCBmb3IgcGxhdGZvcm0gc3BlY2lmaWMgcmVzZXQgbG9n
aWMuDQpUaGUgc2Vjb25kIHBhdGNoIGltcGxlbWVudHMgdGhlIHdvcmthcm91bmQgZm9yIHRoZSBp
Lk1YOTMuDQpBbmQgdGhlIHRoaXJkIHBhdGNoIHJlbW92ZXMgb2Jzb2xldGUgaW5jbHVkZXMgaW4g
ZHdjX2V0aF9xb3MuYw0KDQpFcmlrIFNjaHVtYWNoZXIgKDMpOg0KICBuZXQ6IGR3Y19ldGhfcW9z
OiBBZGQgc3VwcG9ydCBmb3IgcGxhdGZvcm0gc3BlY2lmaWMgcmVzZXQNCiAgbmV0OiBkd2NfZXRo
X3Fvc19pbXg6IEFkZCBwbGF0Zm9ybSBzcGVjaWZpYyByZXNldCBmb3IgaS5NWDkzDQogIG5ldDog
ZHdjX2V0aF9xb3M6IFJlbW92ZSBvYnNvbGV0ZSBpbXg4IGluY2x1ZGVzDQoNCiBkcml2ZXJzL25l
dC9kd2NfZXRoX3Fvcy5jICAgICB8ICA3ICsrKy0tLS0NCiBkcml2ZXJzL25ldC9kd2NfZXRoX3Fv
cy5oICAgICB8ICAxICsNCiBkcml2ZXJzL25ldC9kd2NfZXRoX3Fvc19pbXguYyB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQoNCi0tIA0KMi40Ny4wDQo=
