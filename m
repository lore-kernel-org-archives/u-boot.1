Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19262C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 08:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F26F82977;
	Fri,  6 Jun 2025 10:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="tasrKWS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D58E81FEE; Fri,  6 Jun 2025 10:07:42 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DC7803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 10:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTn06ryndIjZU/sidxz99OqPXFALXJAIiwujDJBrAyAqNrPzgy0SFsNZY9dkVZ0BZjUAigOhO57griK8MyjW0JZCNUsvlhuHfTCBO9620LQSgUY2U+Bm3WRAvXNefgVlamZ8jHKv1ENor7ZOLN+UVCYcJW7KTzvnannjtJyz5Lfl6c4B0W2bFECjT9NsC1TEdpPtfl4Ng/InXZgSeW7Nnb/MM0nECIQD/r5VR9qEpEdLV+XCHJyhTMc6k5725+WJ/RtoFWXlNq9u9giV8BTYZBoStYin0Uu61fqBZED4RhXZOshRvG2wIH+xAiwVlztA2/Rp+w653V5dwqcOp+wt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRK2otHoZOUGiyazX2srW3wSNaVgRweCQ86e2XLOixc=;
 b=kGGkLeKLqVmfI3RPA/gk0ggltmsbvWtv+xdf/KBSiVDcAcw2VnYhpPUbHdJ2vSnBGOVxPj0ESXy8zFY54y1uF/M04YK5uHMX8I4in6AfMbPqgBddxC3ey9x80Vjjn6JSljnIqZBgXnkXgz2y2IbIC2UKn2U+eIdvCTCCQM0UlDByyP0nBT7753KApZlu1ta0GouMfp7Ho1MsZqniK3yYnQ+poE7VlH6ikSvn7C354ExsbV2uas0ZrVlSFJUMTxzHoO33C8yLJ9CZbLATPVjgE07aM6TKBaREYQXLEL0u/yiWVncEOdlYApY06SKJuIO11aUswk1vOJNBPbwnn1610Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRK2otHoZOUGiyazX2srW3wSNaVgRweCQ86e2XLOixc=;
 b=tasrKWS8y8YbRs5VFPmfkOo2H1VKDQ5Vu/zTu7Nt+yoaKTp3XcEKy7MlvvJZL4S2ubc9sr8/GyoN5R0ZDGzVFjRiIF5iqT0MUhbf9jcExUDyijBsCG5Bxrh1jR89AxIdrm1T+ikkivWHAGG1TbUItnfjrFEvFEhiqgdclmkxbZhAucNAq+5RBKOpOCzr0xfm2e71OrFZZbXEvRLeJMU37nCZnY6me5YWutXJrkVXBLLiET4CBzIVR0JU71f5p9wazOou37iNFQcDWuV2ovk20gR3aHu5508D7Sojtn5z5jvx0JkKi6+ArNuG4VTk7JPflwTG2Lc+8p8YWZOJTQPQcw==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by SN7PR11MB7066.namprd11.prod.outlook.com
 (2603:10b6:806:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 08:07:34 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::a7eb:da5d:125c:3345]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::a7eb:da5d:125c:3345%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 08:07:34 +0000
From: <Manikandan.M@microchip.com>
To: <eugen.hristev@linaro.org>, <lukma@denx.de>, <seanga2@gmail.com>,
 <sjg@chromium.org>, <Oliver.Gaskell@analog.com>, <malysagreg@gmail.com>,
 <nathan.morrison@timesys.com>, <mkorpershoek@kernel.org>,
 <robert.marko@sartura.hr>, <jerome.forissier@linaro.org>,
 <sebastian.reichel@collabora.com>, <duje.mihanovic@skole.hr>,
 <sumit.garg@kernel.org>, <patrice.chotard@foss.st.com>,
 <Nicolas.Ferre@microchip.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 4/9] clk: at91: clk-main: drop parent_name check when
 registering main_rc oscillator
Thread-Topic: [PATCH v6 4/9] clk: at91: clk-main: drop parent_name check when
 registering main_rc oscillator
Thread-Index: AQHb1EVlXv2zBj5FhUyvhv5GWbBMjLP0H4+AgAFyq4CAABjigIAAIHIA
Date: Fri, 6 Jun 2025 08:07:34 +0000
Message-ID: <6dfff6ad-4cd4-4ebe-b15b-4f417e16beb6@microchip.com>
References: <20250603050556.80851-1-manikandan.m@microchip.com>
 <20250603050556.80851-5-manikandan.m@microchip.com>
 <8d7091fb-b07b-4b4c-ba73-fefe574b8fd9@linaro.org>
 <b01bea7a-8c91-46a8-b09a-084b8330d7db@microchip.com>
 <7e70dffd-78d3-4339-b644-495294b72fff@linaro.org>
In-Reply-To: <7e70dffd-78d3-4339-b644-495294b72fff@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|SN7PR11MB7066:EE_
x-ms-office365-filtering-correlation-id: 34537042-f51a-4e33-901b-08dda4d131a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TUhYWUNFektWU2c5S1ZhYS9UNlFnb1cxUU83anhkRnNZcHlsSFFmVTNsdmJX?=
 =?utf-8?B?MUd4RmUrMEtjeTBRT0pSR1MyQitOeWhyQ00rZnZjODZHUHZHQXQybHhMVzla?=
 =?utf-8?B?WCtORy9pdDdwcFBHY0M2NSt1ai9GYVl6Y01PRVc3bWRwQWE5c3YyNTNueC9u?=
 =?utf-8?B?Y0ZNS3ZnQlR5MzIrbmhIL0gxY01aUElDYUNjTHkxME5LRHZZRjFpUjZCdVRT?=
 =?utf-8?B?MmVNYmg2ZGJVd0RSVFgwMjRBWmNjQk5UaE1qdy9NVjkvQVdOM0prVlppZ0xW?=
 =?utf-8?B?WHhuU243VERzUUxGN1BNLzk1SllvQ29xL3luK2ZEVnBhMGZ4ejVMcnpUTDdo?=
 =?utf-8?B?VUxTOTNkeWdFMXpZNHlxMWxwRW93Mmx0TUkwaGlwN053amlscno1Qkplbldz?=
 =?utf-8?B?clhwL1FhVUNIMElHQTgxaUREK090dVhlL1g5SFFpbUc4Z3BoMXpLdW9qUEFB?=
 =?utf-8?B?b0NBTEpvV3BpdndVbXhxaWlTaEJ4Wlg3MHExa3k0djVybG9RSGJaMytDbVVa?=
 =?utf-8?B?ZUxiT3JBc1lwZGZOK1Nmc2Z4a1FIMjkzYlpCWUhpV3dsandhMnE1S1Y2VTgr?=
 =?utf-8?B?TmdwODZINkMwZS9aVUxrZVE3LzV0cmdCRnh2R2dvMUhZVUxVUWdtMmhGY1E0?=
 =?utf-8?B?Y0JiV0F0Vkx1ZitLekxoREU2U1BndS92Nk5XbnhMSWdjOWtFVkdWK3pyUkp5?=
 =?utf-8?B?QldJZkNBTkErS0tGNTFEQzRqMFY3TEVYdGpkbURSamdheldEczJ1blVrTDJM?=
 =?utf-8?B?VDFmdHZVT3dzRnM1S1BjU1RMNWlHY2gwWlFxL0hvTC81OWRKSUgvdWdRa00z?=
 =?utf-8?B?V204UnUvWHBSejBaaWEvdWU2WGZCZkZTY1hsYXFaWDNNOG5EN1g3MHVsczNO?=
 =?utf-8?B?RVBuK3NVS2YyOTlQK1VPcHp1bm5MRE9YdDNBSlE1ODh4SWJmTW54L0hWM2lq?=
 =?utf-8?B?U1dVVjBIUDFnWi9neGY2R3pBVVZ6SC80dEprUHpXRnpRenZLZFZ4d0J1b01C?=
 =?utf-8?B?TTZkSm5DSGtpeWtvT1lkQnFXKzdkV0lUSUtiRGJpbmNrRzMvbFYrc2pqb0ZD?=
 =?utf-8?B?dTVpUFUvUDExYitlNEI5U0NUS0Y1UnlhZHNMQTBUMFdzQ21xRUtObk5kdnhW?=
 =?utf-8?B?akpUbHJVZGs1MHhsSlRXc2oxYXNpQWRSZGJuUjJocUlVNUR3V0FlMzhGMjZx?=
 =?utf-8?B?NFVXMXdmMzR0N09sTkorRllMd2V5YjEyVWpHTi93NW52dGI4WDFTaEdHL1pC?=
 =?utf-8?B?R2Y0cGpZNHdwcU1JZWN0SzBPU1pla2hKNVVRRlV4NmlzVEJBc2FhRENMOVIr?=
 =?utf-8?B?VHpmZTNWS1dMZlVCUGIxZmV0U2ZJbXNOSitwT3dQNTlBdDlqanJRVU11QWJK?=
 =?utf-8?B?SWU5MEhjdEE5RzZ4MHBMamtzTDlIc0w2dERMRHJOcWk4bTdObnNHbmo5b0RB?=
 =?utf-8?B?eWNxUlpnTDRmd1hELzFldCtVU3RpRFovU0pHUDF6clZhMEdrblF4cllOdjQ5?=
 =?utf-8?B?TFIrcmFKVzYzVExSVWN4enVYN2o0bVVnS0hDWW5lNjNuUWVBeUkrdE8xK1U4?=
 =?utf-8?B?aEM2YnBIc1U4c2pOdDZNQTIrU01OeGg5VFNjSVdrdVRoSVQrMUg5dURwVWNW?=
 =?utf-8?B?RW0yUGNxa2VQSDIzRmdxN1lnU3Y0NzJFZzJQUW9KWWpGak5SMTlMZ2gvUmZV?=
 =?utf-8?B?dWlhZW94b05KZ1FuZ3ZmWFk0S2xUdDdhVnlJM3QyMlN5Unc1bjdiK0NTTnBM?=
 =?utf-8?B?UERMNTl2Y0taK0NRdmFuanBENElySFFabkY2VDhRbThDcU1Bcyt6VWx5NGJD?=
 =?utf-8?B?NndxTDQzNXk2MnZyVm9ySUxWVmJOOThhVjdLZTdPT1ZjRytGOGhzdVo1YlVU?=
 =?utf-8?B?VU0ybUVxVkFIYzNMQ1A3b01GS1oyM3RwalI0NU1relA2Nm9oNUJFK1IvVnBa?=
 =?utf-8?B?VkZ6ZlFBcmNNR3VJakg5SGc3OG1rd3FmSUVKKzc5bFR3alBZUEUydFhCMllK?=
 =?utf-8?Q?KjQ7I07S42+8f2v+sJRTWSk9sZssoA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF9623118BD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RngyYTM5bUV2YUVubkdmQmhqV05zcTZRdkw2VDgveUQwT0srTThOL1Vic2J4?=
 =?utf-8?B?VFVRWm5xK0dTd2NlMFF6WDI1ZjcvRHVyM0VCbmVXRzMzL3B2SjJUbVRqYW5p?=
 =?utf-8?B?eUFOOHFpOEZyTTlZSWUzRlhVeWQyUGtzZ25nek1WTzl0LzZoN3VzcnNudEk5?=
 =?utf-8?B?VkU0VWxJTUNjcnpFMitpSzRxTCtwM0hjdFJzMHFhL0c1OGlZcXpCWVFNUWQr?=
 =?utf-8?B?QVVmT3FIY3I4U0hRM1J2bzFuNlZGVmRpNUVJTWhZbm10UXlXUlhNOVNIRlYy?=
 =?utf-8?B?Y2FPWXdOL3N5aEdOeXYxdVdKL3F4Y25uMG5xZXhKVjRrc3Fvbk9pbmhqRHF6?=
 =?utf-8?B?VFBsbUhEVGRsNzRHZkxRT3kzS2dBN2E0SXlkVDg4RnNPVUxIVnJabFJKLzdB?=
 =?utf-8?B?eklQbDNQalV1TitsYnVGOUE2RUNLMXdIUkloSm96UE0rYnc0R0hKaWZBQWFO?=
 =?utf-8?B?TkNqTU91cTJpTjc3ZmtnU1owdjZkTi81b3JjVjk0Y0poNHJPamFzK3lyZlJy?=
 =?utf-8?B?emlIZHBzWEI1TGFMeEY4NlhjcnBnMy91QVk5RkNJbkplWWt3ZWF5NjUyTmE3?=
 =?utf-8?B?SHZqVGNnSWp1UnoyY3E4ZEs1aHRpdERPNUI3WlVtNmxXTDFjV0QrSVJheFRY?=
 =?utf-8?B?d2ozL1pNWi8rUEI5SmlnRGR6RHFpTEVnQXVUNFNIKytSK3FkRTFSVTMwUFNT?=
 =?utf-8?B?RGdlYzNnYkJhdERybTV6OG1nejgxb2hpNkVDc3FzT0w5bEx5MTh5L2xqZys1?=
 =?utf-8?B?OTljMVIxdTFQU0VMNUM4SGZvNE4rK082NSs3N2lpTHE3K3ZzcGNuLyt1b3hs?=
 =?utf-8?B?d3JQV2ZPdk5pcHliY2tmbW9DQXZ0YkpHT0c2R005ei9PNVVORDVvUmJIeXhQ?=
 =?utf-8?B?Vmt6RlZCMGh3Qm9SWEV3S2g5UkJaODkweU44TFlPa0grVUtLZFdSV3dNVDhF?=
 =?utf-8?B?Rm9KbTFZMk5aeTE3UDU1SVhjY3dPQ3VTbGRWTTJQMStUb1VCeHdRSFoyUTd0?=
 =?utf-8?B?WlFjUng1WmVWbnZ3cHZUWU1TaWtYU3ZCN3FPWFpaSTRKaHJyaEpDcEJnMnMx?=
 =?utf-8?B?aTBNd3BMUEpHT1dDenJCdlNZdWdFYWlrR0V4SFJpMVN5VDdScUoyR1FtOW15?=
 =?utf-8?B?dkM2WU04SzhJTytwc1d1UlZUdjlTeks0OU54Zys1VlBHN0tldDgxNVlBdlNS?=
 =?utf-8?B?RllEVTU1amwzVnVCQ0VFT0EzNnV4VERZN05rZjlHaU9PVXlXcm41NUlMOFJ5?=
 =?utf-8?B?T1I1eW5XM0lIU1o5dUt5eGR3T2krNnNNeGdvS0IwZUUwcXdVNWtvaTlMem5Q?=
 =?utf-8?B?NVphR21QeVFRKzJZaUk1ejdwdG01WXBxWkZWNURzZS9CRE55Mm92alBvQ29G?=
 =?utf-8?B?OHJjQjdGbU5xbWRXRHlMbXBqOEI1aWxudTRzek1SUWhQUWtBbExuK1FEN0VN?=
 =?utf-8?B?a0hzc0ZxTkNTWmRXTEVPdlBacm41NEUrb01sd24yNkpxQ0JFUEt0YklGZFNh?=
 =?utf-8?B?R1VYMHVsRVNjWCs2WXpnd0k0UlV6eDk2b2hUSytpMlVGR0RveGxndlJidisw?=
 =?utf-8?B?aGRhQTNlYmJiazAwSEV0KytydEU5bE1QMzBSaVJnby9vWDVkWGJTT1hGNXVs?=
 =?utf-8?B?dU92WmxNZDVLS1IxeG80YWc4S1R6UUFrWVh2a0xvYnNBcERDbExZZkprRmp4?=
 =?utf-8?B?Mk15YitaVkhnbjVFcFQ0dUsrRDRhMWtnZGpMUVo0Vm1XeDJWNTBxR2lkdkdT?=
 =?utf-8?B?VHdFMk9MMTRKeWVDWS9KaDQwMGxOdFlMeVNVZWhRck5Wblk2Q3E4ZEh0ZHR5?=
 =?utf-8?B?K2k3N3FaY1N2bS9QSzZwUVdZcFJSY1NuVjBQSGJYc3BGNEQ3YkR6MXdwY2lj?=
 =?utf-8?B?ZWVuMDZCZjJFSzRLdGJ4b204Y1Y3Ykt2Q1VCaUIvZnhGMDFYaXp0enlOa2tQ?=
 =?utf-8?B?Tm9MbDhaY3hhVk9RL1JFL1JIV1hMN0FpV1BRQkRyRDI2VWhUTGYyQzk0bDJp?=
 =?utf-8?B?S1lCUkFWWkF4TS9qRE5pUlpXY1AraExFT1labVJ5TmlaenVDVFZScDdRakhH?=
 =?utf-8?B?WmtFZ3RLWEVYSUc0MHBVUy9xd3VpTEdpeWIxblU3UkNqL2RRRDhFVEx1NWF0?=
 =?utf-8?Q?QFLXOxTZ2bMgyFuqpEqOMDLYw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DA6CB3571324246947B526B66F6132F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34537042-f51a-4e33-901b-08dda4d131a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 08:07:34.4242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtxzTX9hzGSfWX7Noekr44W+VFOZIEqqY14CidbxEs0rtXojdF1r99wSJRuouME7NEdQPvwPDXZqXHOtVC+A4k1C8bmZ83JoARPhWpIn5gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
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

T24gMDYvMDYvMjUgMTE6NDEgYW0sIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gNi82LzI1IDA3OjQyLCBNYW5pa2FuZGFu
Lk1AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpIEV1Z2VuLA0KPj4NCj4+IE9uIDA1LzA2LzI1
IDEyOjA1IHBtLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gNi8zLzI1IDA4OjA1LCBNYW5pa2FuZGFuIE11cmFs
aWRoYXJhbiB3cm90ZToNCj4+Pj4gVGhlIGNsa19yZWdpc3RlciBmdW5jdGlvbiBsb2dzIGFuIGVy
cm9yIGlmIHBhcmVudF9uYW1lIGlzIG1pc3NpbmcgZnJvbSB0aGUNCj4+Pj4gRGV2aWNlIFRyZWUu
T24gdGhlIFNBTTlYNywgdGhlIG1haW5fcmMgbm9kZSBpcyBvbWl0dGVkIHRvIHN0YXkgYWxpZ25l
ZCB3aXRoDQo+Pj4+IHRoZSBMaW51eCBEZXZpY2UgVHJlZS5SZW1vdmUgdGhlIHBhcmVudF9uYW1l
IGNoZWNrIGluIGF0OTFfY2xrX21haW5fcmMoKQ0KPj4+PiB0byBhbGxvdyBpdCB0byBwYXNzIE5V
TEwgd2hlbiB0aGUgcGFyZW50IGlzIG5vdCBzcGVjaWZpZWQuDQo+Pj4NCj4+PiBIZWxsbyBNYW5p
a2FuZGFuLA0KPj4+DQo+Pj4gQ2FuIHlvdSBleHBsYWluIGEgYml0PyBwYXJlbnRfbmFtZSBpcyBh
IGZpZWxkIGluc2lkZSBhIHN0cnVjdCwgbm90IGluDQo+Pj4gRFQsIHNvIHdoZXJlIGlzIHRoaXMg
cGFyZW50X25hbWUgdGFrZW4gZnJvbSA/DQo+Pj4gSWYgdGhlIG1haW5fcmMgaXMgbm93IGdvbmUs
IHdoaWNoIGNsb2NrIGZhaWxzIHdpdGhvdXQgdGhpcyBwYXRjaCA/DQo+Pj4NCj4+DQo+PiB1Y2xh
c3NfZ2V0X2RldmljZV9ieV9uYW1lKCkgZmFpbHMgaWYgdGhlIG1haW5fcmMgbm9kZSBpcyBvbWl0
dGVkIGZyb20NCj4+IHRoZSBEZXZpY2UgVHJlZSwgcmVzdWx0aW5nIGluIGFuIGVycm9yIG1lc3Nh
Z2UgYmVpbmcgcHJpbnRlZCB0byB0aGUNCj4+IGNvbnNvbGUgZnJvbSBjbGtfcmVnaXN0ZXIoKS4g
VGhpcyBwYXRjaCBzdXBwcmVzc2VzIHRoYXQgbWVzc2FnZS4NCj4gDQo+IFdoaWNoIGRldmljZSBp
cyBsb29rZWQgdXAgPw0KPiBGb3Igd2hpY2ggY2xvY2sgPw0KbWFpbl9yYyBub2RlIGlzIGxvb2tl
ZCB1cCB3aGljaCBpcyByZW1vdmVkIGZyb20gdGhlIERULg0KVG8gcmVnaXN0ZXIgdGhlIG1haW5f
cmNfb3NjIGNsb2NrIHRoZSBtYWluX3JjIGlzIHRyZWF0ZWQgYXMgYSBwYXJlbnQgDQpoZXJlIGlu
IGRyaXZlcnMvY2xrL2F0OTEvc2FtOXg3LmMgdXNpbmcgYXQ5MV9jbGtfbWFpbl9yYygpDQo+IA0K
Pj4NCj4+PiBFdWdlbg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FuZGFuIE11cmFs
aWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBk
cml2ZXJzL2Nsay9hdDkxL2Nsay1tYWluLmMgfCAyICstDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvYXQ5MS9jbGstbWFpbi5jIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGstbWFpbi5j
DQo+Pj4+IGluZGV4IDA5ZGFhZTk3Njc2Li5hNTE4NmY4ODVmMCAxMDA2NDQNCj4+Pj4gLS0tIGEv
ZHJpdmVycy9jbGsvYXQ5MS9jbGstbWFpbi5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEv
Y2xrLW1haW4uYw0KPj4+PiBAQCAtMTEwLDcgKzExMCw3IEBAIHN0cnVjdCBjbGsgKmF0OTFfY2xr
X21haW5fcmModm9pZCBfX2lvbWVtICpyZWcsIGNvbnN0IGNoYXIgKm5hbWUsDQo+Pj4+ICAgICAg
ICAgc3RydWN0IGNsayAqY2xrOw0KPj4+PiAgICAgICAgIGludCByZXQ7DQo+Pj4+DQo+Pj4+IC0g
ICAgIGlmICghcmVnIHx8ICFuYW1lIHx8ICFwYXJlbnRfbmFtZSkNCj4+Pj4gKyAgICAgaWYgKCFy
ZWcgfHwgIW5hbWUpDQo+Pj4+ICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFM
KTsNCj4+Pj4NCj4+Pj4gICAgICAgICBtYWluX3JjID0ga3phbGxvYyhzaXplb2YoKm1haW5fcmMp
LCBHRlBfS0VSTkVMKTsNCj4+Pg0KPj4NCj4gDQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0K
TWFuaWthbmRhbiBNLg0KDQo=
