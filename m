Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDFCC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 04:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35AB835FE;
	Thu, 24 Jul 2025 06:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OWThZ3PA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C498360D; Thu, 24 Jul 2025 06:58:20 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5241835D8
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 06:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSn778nFzUA3RaWLBO/IM6u2rwKP6BUaz09QAuYnTFDp7QHMMvGPjxaDibuQ5mHyEV/h7Kzy4T3VMHrkDf0bOK4VCRj3BpItNnOIbNDTfF8eFNVRvLcY99mBMGWKsQbvU4JfnacUoN2gXfhyo+8dGU2qXmIVJaCTINeQ2EcuViSf+Zn41vKdGlGqnSU+VNilJupebjblFypHTUhuyxBK4hi1F3jAgNrqtmbU89CTdqouyYSUDhS4gSjv+wckZwvKEm88VeiLOiL+twqatoj7ghIF/tS3WeW+SvT21s5a7I0c7v3i/Yu/4reaF4zDcnKFS5v61PctDF5MPEt4h5CnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FnYwndA0fZRKKu/DHJj/kwgAO+0hErApA3thyuxwqA=;
 b=Mbw0B6GJYH3VucPPkAm3DVn4WoMK3PBLpUH9MgR+OdEHAyaRdTnvmXQ8pnsIWznjMO4N1WhcxQLmrbrjoz0Vi9PDvS1VD8MjyevRKomKSMMEqAaFKXYy+P48qTVpq59es3aFwkOSKFskjgyG4pKM/WSwNkKBF8sFTumh1cqo36vBuEweMSX/VUp5k7meg+IrYJj9qqInlv7pSDo2ypvtU9Vo0DTCWksT4FrMNk4HJRgY61LiiZkDcWCG1jCaE58MeTLBgvDrLaexwJ2EIFDKi/94zZxtBorIdy9CkTAkXcYK7IcP4kNj0Mv6cTn98gXbv16Gq5ohGHxOcycdAWZxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FnYwndA0fZRKKu/DHJj/kwgAO+0hErApA3thyuxwqA=;
 b=OWThZ3PAm7X8hng8VqeecQ6zCfuLn0lwtiTnNBD0pJqjsUBy+rajRBDA3C6ROUaW115B8tQGWHxBlceqpoeBwTs3fI10+kJR5/GELvO+/T9USvICsw8x8fgEwA/dVfJL/W60JMiD8at4qvl+ZG6iyt0VoXhHPJtEgBPhc+AcD7o=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 24 Jul
 2025 04:58:13 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 04:58:13 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Neha Malcom Francis <n-francis@ti.com>, Prasanth Babu Mantena
 <p-mantena@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "alpernebiyasak@gmail.com"
 <alpernebiyasak@gmail.com>, "Simek, Michal" <michal.simek@amd.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "vaishnav.a@ti.com"
 <vaishnav.a@ti.com>, "s-k6@ti.com" <s-k6@ti.com>
Subject: RE: [PATCH] Revert "spi: cadence_qspi: Fix odd byte write issue in
 STIG mode"
Thread-Topic: [PATCH] Revert "spi: cadence_qspi: Fix odd byte write issue in
 STIG mode"
Thread-Index: AQHb9h/teJWjSnsj8EaBmVbNgE4kHrQ0XbIAgAxkmrA=
Date: Thu, 24 Jul 2025 04:58:13 +0000
Message-ID: <SA1PR12MB8697EEDA1620B63BF670213D985EA@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20250716070407.2082524-1-p-mantena@ti.com>
 <c6d624d5-76c5-4a64-b4a4-db6e6428df30@ti.com>
In-Reply-To: <c6d624d5-76c5-4a64-b4a4-db6e6428df30@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T04:56:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH7PR12MB6935:EE_
x-ms-office365-filtering-correlation-id: 5f0c8127-5d73-4a43-a23e-08ddca6eb1cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZFVOZ0ZFU0Vua2hpOGpSeHp1QzNySHdYdE1UVStpSDFqUS85bjc0bTJ1ekxX?=
 =?utf-8?B?ZElySy81enlMajFacDh4YjFrcnd1Zld1dnlmV0NHWDVobyt3SmVMbzRybTM4?=
 =?utf-8?B?RlRJaXQ0UWwxSk9MbWN5NlB6MG55YkpIdlM2ZFZjZUlPRzh2YWNzM0pac3lB?=
 =?utf-8?B?WlpUR3d5QTlCMEdrK1lzeU1uSjJOQ2l2QWI5STkyRVpqNFRJcTN5M1dxVStY?=
 =?utf-8?B?V3BkZG9kNGRWbTVxdGlxTDZnY1M1YTF0ZEpOSDVMUlFFZTUwaWs0WjJQVmRw?=
 =?utf-8?B?Z1BwaGYrYXdFTmFEdithSjkvbS8yQU54Sk9mUDUxbm9TaVNuNitIMXByYjl3?=
 =?utf-8?B?YWFOM08rMXdWUUhiT1dXa1BRVEN6clF2WEozRThqRzNINm9nc1A5RTFjZjNj?=
 =?utf-8?B?M0crVEdtUjh1cE1UNXlYQkFNamoxVTBpOGFWNXp2dHZ3YlgreldkdXNOZ3ln?=
 =?utf-8?B?TjB4eElmMitGRlUrYkxla3IrSDN0YjVhb3VDQjA5UlB1QzVJK3VhMVp1V29R?=
 =?utf-8?B?T2wycDVFbEE0SW1TNTFFOHY5WWFrK2Z6WXI2V2JIbS9BSFNGTklKNjBhRUNN?=
 =?utf-8?B?UUNJM3RNRGFEc2ZLczVNdmRRbmFhclRrNXNOYnovQzlXT1hBSzlOdlJuaU8v?=
 =?utf-8?B?YlFmYzNNbEtoYUowOHJscDBBUUh4NWs2bE1ucGprNklCRkNwdzV4ZGVoNVNV?=
 =?utf-8?B?TUZzSWNuVGV6YVdvRDNjSHZkUXgyYjRFMnN3WjhGWHlUK201OEhDTXZoQitp?=
 =?utf-8?B?aVNxL01mS2czcjlnRkJrRVN6ZXV0cGF4VTZ1OEZMSHlZSGNPSXc4cjNVK1hR?=
 =?utf-8?B?MUViMUtsZFRyVk9tbGlzY1R2MElGRVFyUytHRVZzMFBSWDRUNWxHaVZZVkdN?=
 =?utf-8?B?Vk0wYVhoQ1gydHM2YnVsSWtoakxXZXp0bnRXa1pWRXh1RFZMWVJ2emVnRDJ5?=
 =?utf-8?B?c3BLZmxYRHB0cHNmckVhV05hQ2dDejFQdVBkcDBGWkZNYWxib3hrYmJiSU1h?=
 =?utf-8?B?UGJuNHB3a0t5YjFSYlRUNWtKa3F6ZkxCdngvWTVvVCtMN1U0RVozcWpzRVNZ?=
 =?utf-8?B?UTc4Vk5JL29zU1MrY1hKcTFjRnpsa3JRS0E4cUcrTE5LblR1d2tWN2Q5dzZp?=
 =?utf-8?B?d2RhVEpKNUtyV1ZBcjFiQkNjMjNwWUF5dDM4THZMclZmTDZRUjlXeHgwNHVi?=
 =?utf-8?B?UjA2MFZJSklCVyszaHlGcFRGZXVDSVhhcGFsMTB5eEh6cjI2WFJraElsQi9W?=
 =?utf-8?B?T2huZTRSeUlJTzNKSkRTbGFEemZ0QmRUUTVDNUo2ZGFKMHlnQjJoOGhLOVUr?=
 =?utf-8?B?b2ZIWEpHVERwTHJLOENkZzZ6bVJQKzh3ejAyZ2ZBaFU4VE1hbGNJYVlQQnNX?=
 =?utf-8?B?K2NSU3FscWJ5RkNCL3loODVBUWZSeWk4Q0VVNnVpZllxQ2RwQVc2VlJzOTRO?=
 =?utf-8?B?WFhRUUhKcFN6My9OWUZ2bXdPTkUyZmpTMWZyTUV6ZmUvNEJFZW55RjU5dHpn?=
 =?utf-8?B?b3htenVnOXAweFdpL0VCNGJNU0gzdWZvdXNLVW1uZTBhazU0SVNzK1RmU1li?=
 =?utf-8?B?MjFFcGVoeDhBNER5VGtqcE5TZG96RDY5OGRJMzQ5WWc3Y2dIWlBGT3hmdVM2?=
 =?utf-8?B?bERGYmFvK3ZnNmVKVyt2MGY1bFJRSEZUMzlpcWVwdDVXZjlrS2FXdFJROFVO?=
 =?utf-8?B?aDZNSlNvM0kwNHBQanhXcGdEOFl1SVRsdWk3YnZEcE9jNzkwQk9NQlBHMzJT?=
 =?utf-8?B?RFRaakhua01BKzdRY2RvQ0l1K0hDV00wazlxNEF6bW9FOFhFUlF6QTNVa1ZJ?=
 =?utf-8?B?SWpSVkxqSHJ5QWVVdzVwQkgxSGJSYTVBNElvNDZTUVU4UHZyZ0hPZjRYTVMv?=
 =?utf-8?B?QjBTY2NHRGtjbm84T2c5cVhSWHB5ckJnc2ZiT3BNRTJzY0hMc1h5bCs0U1R2?=
 =?utf-8?B?b3ltd1k3bXMvaTFJeDJFQ0FQdWNRSzlmajE3R0NrdWtOYmloWnY3N3hMZlpY?=
 =?utf-8?Q?dgK01rMXugw/F5OPs3x42kEVoxm52I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjZsM2UzUTByTjlyTWkvUnB5dmpLUG4wbFRPNmxhbmdkbi9zeFFlcXdoUGJC?=
 =?utf-8?B?UkhqRzVJeUR5R2RwWklrNXdwWHp3SjBmQ0x4TjdoNFVoOWk2RlpLaGlTN1RV?=
 =?utf-8?B?R2hqbXpvMmpORXRZb01xa3VRSlpBUXIzTC9ReGM0S24zS3pFL292d09HMWlx?=
 =?utf-8?B?V25qcXpxTVJ6T1E2elhlRVZIMStLNnoyNmVMMTFHLzBJYU1sM1VRYnN0SmZD?=
 =?utf-8?B?SEIrMCtNeEptS2tVZEFWeC9mT3VkbWVLUldEU3A4blRodVVlODQzYWhONmRk?=
 =?utf-8?B?WmM3QjJDNHNjc3JVL1MwSjRoRFA2RmhnSURVSnU2bFF6Nk9oem1DZkJWeG5j?=
 =?utf-8?B?RlJvcXNmQXB5dG5Vc2VIV0s4c0JoNUx2UmEzVmhZN0dNOHNEWEpQTkxyUFU1?=
 =?utf-8?B?WmZ4Wm8yaU1HUEhtbTEzaUV1bE5EOWVaaHhMOVBnd2s0THVSR0V2Rm5lSkRy?=
 =?utf-8?B?b3Fwc1E2azJGQjMzS1lRM0tNREw3c2hPT241bGkyd0xjQnE1K0pUUlFnSS9s?=
 =?utf-8?B?djUzcGl5NllXemIyZzdhTit5aUZ0eEdUMjJxb1F2dlBva2pvL052ck5vQWM2?=
 =?utf-8?B?eDVyTVE4c3FLRnRSZ0RqSUxxS0Y2VGZ4ZVgwbk9tTnRTRFp4ZE4zUXB4R0tJ?=
 =?utf-8?B?Z0NtN3RYcmk3MlFrbGZ4N0QwckRPVU1KWmRCWmJMam41UWdjbkFwc0s5VDVT?=
 =?utf-8?B?dGpnWDk4NDdPQllSVW5YZGdVN2o1UTlXZXoxdCt2RnpYazUwUFZuWGFsS3VZ?=
 =?utf-8?B?alR3eXY1TXFNNnM3SkN2MmduYVBZci9tanlzcnZSWU5KTFk0MXUxZGdCdTJo?=
 =?utf-8?B?ZEZGUzNiY3BJRWZLbnk3RWdZV3h2ZTFFTFgveGJISHpRVkdYQ2JWTyszM0pi?=
 =?utf-8?B?amthSDd0NVQwdjN3YmxLTVVnbWdhTHVMcXJrU2dra0c2M1dwSkMwT1J4YnVw?=
 =?utf-8?B?UEhOMlRva0hDVXNLOVR5SzRKR0dqQjFETS92U2lELzAzbUNDZWgvLzhsZTVT?=
 =?utf-8?B?NEJjdEwwTHUzeC9JV2IzMnFYcWZLOHd6UzFTZEdhQkpsUURURkVLQ0s4SHBn?=
 =?utf-8?B?bUN3SndjamZiNnY5MUN2SG45V2wydmUxSzZuTnpYdWs1c0l6dHVuOHYzS2V0?=
 =?utf-8?B?UXNGbVp6eGlkVGVFbElZR3pZM04zS1hWTnh1WHJzYVZwNE92TXJXWFY0YkRI?=
 =?utf-8?B?dXJkRmNlLzNXKzd2Qmw1czJybkZQSnE3M2wwRFk3ZG5xS2N0Q0xsVUJXaVl1?=
 =?utf-8?B?NEdGa1dTOENvVUUyZkRUeFFuMHpLRjVPeElic1MybHZvZ3F6aFZJUDZmaGlS?=
 =?utf-8?B?bC9jYkVxWFpWZWJabUVUN1NQYmN5b2N6Y09Zb2cyek55cjlnSnQ1UzV3emd3?=
 =?utf-8?B?UWZGSVI4a2RBUkg0aEJsZEdXbkNhUWtZSUZRUjRJTGRVMlpBREN0eXZvTEoy?=
 =?utf-8?B?VHVlQ1I4eWxFMVZjQ3p5bkw2eXdNS3loT0NOZ3JCVFQxS3NEQy85dldnZ3NX?=
 =?utf-8?B?TWFCTHVZYnhnUGt5WGhiaU5vdVcyaTI3RFd5S1lxRlk2SUJ5VVJsSlhXY0d4?=
 =?utf-8?B?ZExUN3Rmdkx1RGM3SkdncWlJUWloSi9mZjk2RFpDWUZyem1sT3dKbW1OMUNv?=
 =?utf-8?B?NGVNNzFUaXlYa0M5VWJRaWFCTi9uSVhCYWhHTjJsNk03N0xiNmJRNFEyMGRl?=
 =?utf-8?B?VzVhWTR1SXFWNTJhTzF2L3VtYWYvY3JHSXhsUTF4eUhpQmhsamtBdk5PTHZk?=
 =?utf-8?B?Q085RnVKeWRJbEZnaGNhR2tLN0VWNWJGbGlOMGsxQStqOW5jQlpYN3grMmpQ?=
 =?utf-8?B?dmtUY05jMTNCdXRkYTJ1bDFJWEdxdzJaVmhaZXdUMTRVc3U1NlovbnIxbFhu?=
 =?utf-8?B?QmNNeHBRTWYyNXhQdTNxWWxBVFQraGMrdTc0RTNMdzlZM0ZITm5ITWoya25z?=
 =?utf-8?B?clBkRFpjUUN6cEIwQ0Y4Y0pZTG5rTlYvUndIaWtJT2Y3WGhibngrU2twcUMv?=
 =?utf-8?B?eWo5SlNYT2hGcmxzeWplOENNTURmZE5LL2tVTG9uSWllZjJGNlNSaDZCdmds?=
 =?utf-8?B?Qll4eDFwOG5RUSt5a2tSM3JzRjNKMXdBYnM4aExKM3BFTE11OTlnKzAyeVRH?=
 =?utf-8?Q?im8s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0c8127-5d73-4a43-a23e-08ddca6eb1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 04:58:13.4336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCvBQQtlZU0Z4ZpYQ3gxdRJaD21j0+c6pNhW8fGxi9cGxCxTqUAUBbEpyir1GR8VlwYC+4CqVAPoVSSuPheAjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgUHJhc2FudGgsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TmVoYSBNYWxjb20gRnJhbmNpcyA8bi1mcmFuY2lzQHRpLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBKdWx5IDE2LCAyMDI1IDE6MTEgUE0NCj4gVG86IFByYXNhbnRoIEJhYnUgTWFudGVuYSA8cC1t
YW50ZW5hQHRpLmNvbT47IHRyaW5pQGtvbnN1bGtvLmNvbTsNCj4gc2pnQGNocm9taXVtLm9yZzsg
YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBBYmJhcmFwdSwgVmVua2F0ZXNo
IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT47DQo+IHZpZ25lc2hyQHRpLmNvbTsgdS1rdW1h
cjFAdGkuY29tOyB2YWlzaG5hdi5hQHRpLmNvbTsgcy1rNkB0aS5jb20NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gUmV2ZXJ0ICJzcGk6IGNhZGVuY2VfcXNwaTogRml4IG9kZCBieXRlIHdyaXRlIGlz
c3VlIGluIFNUSUcNCj4gbW9kZSINCj4NCj4gSGkgUHJhc2FudGgNCj4NCj4gT24gMTYvMDcvMjUg
MTI6MzQsIFByYXNhbnRoIEJhYnUgTWFudGVuYSB3cm90ZToNCj4gPiBUaGUgYnVmZmVyIHRoYXQg
aXMgYmVpbmcgdXNlZCB0byB3cml0ZSBpbnRvIHRoZSBmbGFzaCBuZWVkcyB0byBiZQ0KPiA+IGhh
bmRsZWQgcHJvcGVybHkgd2l0aCBwYWRkaW5nIG9mIDB4RkYuIFRoZSBwbGFjZSB0aGF0IHRoaXMg
aXMgZG9uZSBjYW4NCj4gPiBiZSBhdCBhIG1vcmUgZ2VuZXJpYyBwbGFjZSBsaWtlIHNwaS1ub3Ig
Y29yZS4NCj4gPg0KPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgY2Q5MTIzNTA3MDAzZTA3YjEzZTYx
ZDcyZTE0ZTQ5M2JiMzM4ZTgyNy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByYXNhbnRoIEJh
YnUgTWFudGVuYSA8cC1tYW50ZW5hQHRpLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zcGkv
Y2FkZW5jZV9xc3BpX2FwYi5jIHwgMyAtLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvY2FkZW5jZV9xc3BpX2Fw
Yi5jDQo+ID4gYi9kcml2ZXJzL3NwaS9jYWRlbmNlX3FzcGlfYXBiLmMgaW5kZXggNmY4OWQzYWRk
NWQuLjQ2OTZjMDlmNzU0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3BpL2NhZGVuY2VfcXNw
aV9hcGIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc3BpL2NhZGVuY2VfcXNwaV9hcGIuYw0KPiA+IEBA
IC01NTgsOSArNTU4LDYgQEAgaW50IGNhZGVuY2VfcXNwaV9hcGJfY29tbWFuZF93cml0ZShzdHJ1
Y3QNCj4gY2FkZW5jZV9zcGlfcHJpdiAqcHJpdiwNCj4gPiAgICAgdm9pZCAqcmVnX2Jhc2UgPSBw
cml2LT5yZWdiYXNlOw0KPiA+ICAgICB1OCBvcGNvZGU7DQo+ID4NCj4gPiAtICAgaWYgKHByaXYt
PmR0cikNCj4gPiAtICAgICAgICAgICB0eGxlbiArPSB0eGxlbiAmIDE7DQo+ID4gLQ0KPiA+ICAg
ICBpZiAocHJpdi0+ZHRyKQ0KPiA+ICAgICAgICAgICAgIG9wY29kZSA9IG9wLT5jbWQub3Bjb2Rl
ID4+IDg7DQo+ID4gICAgIGVsc2UNCj4NCj4gQWZ0ZXIgcmVhZGluZyBbMF0sIG1ha2VzIHNlbnNl
Lg0KPg0KPiBSZXZpZXdlZC1ieTogTmVoYSBNYWxjb20gRnJhbmNpcyA8bi1mcmFuY2lzQHRpLmNv
bT4NCj4NCj4gWzBdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3UtYm9vdC8xNzQ5NjNhMS1i
ZjZlLTRlNTQtOTk0Ni1iZjNjNDJhNzI5NjBAYW1kLmNvbS8NCg0KT2suLi5XaWxsIGNoZWNrIGFu
ZCBoYW5kbGUgdGhpcyBpbiBzcGktbm9yIGNvcmUgZnJhbWV3b3JrIGl0c2VsZi4NCg0KUmV2aWV3
ZWQtYnk6IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5j
b20+DQoNClRoYW5rcw0KVmVua2F0ZXNoDQo+DQo+IC0tDQo+IFRoYW5raW5nIFlvdQ0KPiBOZWhh
IE1hbGNvbSBGcmFuY2lzDQo=
