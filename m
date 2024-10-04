Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B28FCF8842
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 14:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24D788B0B;
	Fri,  4 Oct 2024 16:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LNXBrGYT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E12C87F19; Fri,  4 Oct 2024 16:57:38 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1702088B0B
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 16:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsUfRTvGgL//PgpyDc6n+u95DbfDZbMMG0f6Bva9OI7D/KmPgILL7GOcVpELUD1THr62pv21s/D1WmwWA2jcGIdPf9mk5aASh1fxKfBjO6KF4nT3v2J3+B5I6U8DUgvU0IE1TmELExV53f0KizByKwwQgM2KOdkskDWUA4HVGEL/yvdChhrGhx4xzNKqo7JCQRc1fejeJ13yrFkUgI1qPCJ3rNfZIzEKp8rVbo5Z2bslhkz8+vz4GAHX0YJZms2SuYibfmPJ5ZhIsb1qMm7DUNXgBVJpL2Iprpk7PW07cq+W24w7KXWO94FnRl9vtRlvPh9tROyirklPZ9bqgB+0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+xH/VeoeT0CNrMSrJsJY9VF8fOOjgbs04KMdjuyqYQ=;
 b=oc5d45aHilK6ajJql1uU0gyz6U7dUyrtC+J2v1uitngE/Bkb7VGg9qaqPvnWxHit2KvjxVGGxGOnMYSVjZUHuCdYROfX5S2gGABvNR22vRaE3mkQVT33wGD6E3hTOQf7y8JIQGEMCaWkkPD1bc1KbtP7vV9ZoTRHbxlBytk2YBpxL+MhyZ2tNzYnpC4Ql9e/PuY0Bt1mMZ+K1anDYTefyOz/C7YIK1V9DwJYlMLfEe6kfMJ5AkZMnvDyJKGyCIcMKq+4hB83EYZ18gggrtspZ1VoJXyYK+4va+aoN4xsgNmiuoVS0ySuyzY+naQ3/183uV05qrv0wYiYW5cI3vk7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+xH/VeoeT0CNrMSrJsJY9VF8fOOjgbs04KMdjuyqYQ=;
 b=LNXBrGYTgUMDAKce3OQHf6r/95jVN7hRNvY76s1cNJJFUtRq4j8O30gHT3Md4lp2M8ngrYsEWvs1nxjCoOoBiEEF8hfYkozSnRjzuv1J9j3VK5R8PWkuxwc+8CwDeY6cxt66EI4Eb/FvoKsXNNFmzOoCq8R5UoT2aszm9ZxEdYQ=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 14:57:31 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:57:31 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Topic: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Index: AQHbE8Cw1wwSjzBcqEOkNkd+RtrWkrJxyouAgAKoQHCAAH+OAIAALk6wgAAknwCAAKXiUIAAjJWAgAAKrLCAAB8jgIAAEJ8A
Date: Fri, 4 Oct 2024 14:57:31 +0000
Message-ID: <SA1PR12MB8697DB9C1D374C9D86B4A72D98722@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
 <6056a273-2699-4e94-93e8-ddc96084bbba@denx.de>
 <SA1PR12MB8697873F2C2EF86E6E9DAF9B98712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <2e0928c8-e03a-44ae-aa36-3d664ed5bc6a@denx.de>
 <SA1PR12MB8697682FEEE48B015EE82E0398712@SA1PR12MB8697.namprd12.prod.outlook.com>
 <c40f47cb-7245-43b7-9b01-6b8d1cdff04c@denx.de>
 <SA1PR12MB869735B41B6F7A86520E2D3D98722@SA1PR12MB8697.namprd12.prod.outlook.com>
 <02fe6fab-7e8c-4408-950f-e6df2a258b16@denx.de>
 <SA1PR12MB86972BBB9F22E0C98AA541A198722@SA1PR12MB8697.namprd12.prod.outlook.com>
 <d542e169-cc19-4349-bfbe-4d3937da63a8@denx.de>
In-Reply-To: <d542e169-cc19-4349-bfbe-4d3937da63a8@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|IA0PR12MB7676:EE_
x-ms-office365-filtering-correlation-id: 14c16cb1-03cc-4dbd-f993-08dce484df41
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OGY5KzBDejVmYSt4dnVkR0VKL1RxM1ZxeTRqUURGbUZOK2JtYS9lajFtU3FG?=
 =?utf-8?B?TjdkM3RKZWJZWE1Yc2phLzRjMUYzSUNaTWxnTmhnQ0E5dDJMNmU0aURSNml1?=
 =?utf-8?B?Vm9WOWdyT3E5NnhVUjVnWjZCemU0VkdQUko5aGt3cGFmRERpbyt5ZVc3cFdW?=
 =?utf-8?B?dlNSTWFiVEpZSHBUaWM4eFJ3aEdoRHc5alNMck9qM2dGZkZJY1dyaFpTc3NG?=
 =?utf-8?B?UHJXK1pITVF2dy9vb3NBb2F2VHk3NEdld01CZmduczBaSWRnSW5nWndMVldq?=
 =?utf-8?B?cTIwWFlMd2d6Q0syS2s4RGd4V1hLVDBOajZLVW1qaDJmUVZlSlJmbVJRNDFW?=
 =?utf-8?B?YUpjL0NndUZ4b2J6WGZUYktmcW82QjJvRENRTk9PbkxTQjVuZHNmVjdrMDRv?=
 =?utf-8?B?VGFVMjc2emxqa0JZQTQzcHRObXc3c29idndmcGxibWFvaGNXa05FR1pjTjhl?=
 =?utf-8?B?VmNjdWdzRGIyU0FyZU5oZENjRUlSR0xGNjJrTHhNYWQzaDV2Ky94Zi9hVGVS?=
 =?utf-8?B?Zkx4a09wc25sd0VNMVIxU0h6Z1FxUi8vaUVGUmYzMXZTME52Y2YvanR2VWVC?=
 =?utf-8?B?SzJjOGZhcmhZWUlYUlIxaWlwMThlQ1hOVW9wUCtzQzhuYXJXaHJVQVlUSit2?=
 =?utf-8?B?Wlk3U0Vka0JQUEhzSlVFRjI2VFdrR0trNnIreHhKWHAwSzZENTlaOCtYNWlJ?=
 =?utf-8?B?ZHVKV0ppL1BNeHJjQnl3ZmhyajBoWW53TWtZNGlUeWE1Q09lcjBCUmVwK0Q1?=
 =?utf-8?B?V3FaZHZTdkJaVEpUZTFQNGFrcWZwT0RQN3JUaHFiUk9ocDQ1cXI1Z2ovRWVn?=
 =?utf-8?B?cEdSNEt3dFlWNVJzUEN0SlBKL0tPMzB3dEFWU2ExYmwyZEhqZmxKaXRrOVJ3?=
 =?utf-8?B?UFA2b0plcE55Z1dHRWY5MDhGRE8xb0xGSjdkbndRUUxJR01nMisybTMxTGNF?=
 =?utf-8?B?L1VMNkd4cVc4UmNQV3Q3cS9uemN1dGpQQjkxamJaODIrckJydS85T21TMWlK?=
 =?utf-8?B?eEFKcmRCYmhWVTMwRDI0R2gvU2tXTDRkcGpUeHZjemcxWm5tUVN4QXkzMTNo?=
 =?utf-8?B?QnBWRFNJZHRSRk9YdXlVYWgza0JCeTkxeXZ5aVVJQzZ5RDduQTE0RmdHUWU4?=
 =?utf-8?B?K2xUOElLMklYbWtrQldJK0Z2Tng0SlRtdGhhTU1KdTlzRkk5ZC9KTDE4ZHpV?=
 =?utf-8?B?eW9iaGdpaWtmR09Kc0NBVjVzenk3VmRqR2hZcjdnNFRqcG5nYndVNDBFcTVO?=
 =?utf-8?B?NFJ0bXo0RVJvRk8wRWdKekxReFl5M0dUMlpMbXN5N2NDV093c2JtaUFsRG4z?=
 =?utf-8?B?bXRLeWtaNVpSSjJqcmp0ZnY3Q2MxSG5samZ2QmQ4N1pSRjU4VHdBSGJTTzdE?=
 =?utf-8?B?NlhBT2lubjRKU1ZHTVhLTEROSThBa3Z4ZFZPTjNxekpqN0NQQ3V2QjFOSWp2?=
 =?utf-8?B?S3F6WmRPRE5yNGt0WFFIOWhqbjJ3WmdLZnV6TnZjYWc4M1VXL1pLdDZrS2NU?=
 =?utf-8?B?UDBTaWpBQ3lRdHFvYlRORzBRZnNDbVlpZFdVTjJhWFlKMThDV0tvZ2g1QUcx?=
 =?utf-8?B?bDNYY3o0UHlCa0RZd25LU2JSNVVxMUJpN0oxNlRFNDBtMWJnMnlzWmJHTzRa?=
 =?utf-8?B?bDhENmE1eFM2VUNhUUQzMGY3a3lDTzRROFg5Q3o2ZEVPa3JEYTFYOHExd2Vl?=
 =?utf-8?B?VnRhNEtBakdHZnVjdnNWM0I5NzFYcFNUVnFrUklMMXROK3NJd3k0ckk4M3R4?=
 =?utf-8?B?aXNZeUVNZkwrWVNCT280ZnhNTGUzeWRtUzJKUjhzOVZ3akgvSlh6T1laMHBM?=
 =?utf-8?B?TGxaKzJVOEU0KzE3MXlxUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVU2aW1GMGdJRWNYSER1Tk1ucGdYaE14VXBvaDFOaU9weVFEQ1ltc2p3dzlH?=
 =?utf-8?B?MVdmVkc2NjJ4LzZrellHVWhMQzBGSnF3YUhFT3V0L0FTRjJKSmZDOTVQNHRz?=
 =?utf-8?B?bjJGdGxFZmhJZ2taMDlEZ1ZpR3U5NW4rRTRFZGZ1VEVEU3VLMWlVbkgxZFEy?=
 =?utf-8?B?MGYwOUtmUE1GSHRKNnR4eE5OV29IZGNyVDJrMUFEUm94dWx2NkFPZml5MERF?=
 =?utf-8?B?ZjcveFM2Ykt0aHg3eGdXREo2QmhldkZmUzlXR2tYNEkybDRnK2JYRXlMZ3J3?=
 =?utf-8?B?anM0MWVGMlR2MGYrWFgvUEdNc0ZvTE5yeXFNR0VPVnNpRjV6SlVGbDZWYlFZ?=
 =?utf-8?B?YnEvR0tuYTVoTURHOE5ZeXd6OHg3OW9PZDA2VndQUloycXpjYVl6VkJSeDZh?=
 =?utf-8?B?MGdzdEs0aWNGbHRjZWYwSllkVTFoaTJCWU9DYStFb0NDc0FvMDZQVGJJRzhE?=
 =?utf-8?B?Q0R3OS9FNUpjbUpCaDMwbEtkMyt1ZW9PQm1YVHd6bnhWc1RHOGdDQml2OTFw?=
 =?utf-8?B?dSt3Sko0R3BwalZZSnhNQ1Z6WkNTeTNjbkd4SUVKbnhuTFB6WS9VcVlVWWdS?=
 =?utf-8?B?OFFyWkM3Vk00T1VXRVAvc1VtV0RuU1NVWU5qTExIRi9iamIrZ29zb1lmK01w?=
 =?utf-8?B?aVNnM1g0NEk3MVVSZ2NkY1ZPanNrTjc4ZHBEaWtLVytXdHZzdEFxSmVaWFJR?=
 =?utf-8?B?SUxQOU9pQmdhSWY1N052c3I2Z2JkQUJZZ2p6ZTlwaXhLVTFVRGs4ZWJsbVl1?=
 =?utf-8?B?OXV6T0pYcGt5dUdwQ0I0RGNSaHNvNFJRcU11WFdCNHpOZkR3YmVNMFFsbVh2?=
 =?utf-8?B?cWcrU1BiVTlGRkgvQXFydXhYYlBWZzNYOG9iblpGLzMxM1BwRDNvU24vVDdj?=
 =?utf-8?B?dnRVemxMWmJjcGxGaUZha1VUQkMwdHRqaGdUNkM1VENhVEw3Szl6ZEIxK1lO?=
 =?utf-8?B?VnpWY0g0U3RlK0owVFJ2aXllQWdjbXU3ZU5SbTBtVGlqSCtkalMwTTFJc0dY?=
 =?utf-8?B?YWNiMFBDMCtUY3lCcjBVd1NaUnF5SlJoRE9qQXVRZE4rOHVEd1Q3djRzelRH?=
 =?utf-8?B?RHhXa21nU0hMUE8wQWZlc2tFZmp4OWRqUVByU0hFdUNZbTJ1S2RoWFVuOEYw?=
 =?utf-8?B?cVdkY0VMWlppd2p0ci94QkNtOGZpMFQ0cjJaL1dUZUZOaGlOQ01GVjJRUXhX?=
 =?utf-8?B?TWx6NE05UjNORjZQeER6eERUUEh4OHpUY3RNeDUydFVHQmRnYVpLbXFaS0Vh?=
 =?utf-8?B?bEM2ZUY4TGY1azF4cFFJWXM2M290MGZRdEdWWC84UkJwU0Y4OW1VSGlYb1p6?=
 =?utf-8?B?R1d4RElMcXFCbVdrSExTSllzaHdUenFLblNqb0w1QnhpTVJMdUVueSs2T0cv?=
 =?utf-8?B?dXRsdnR1OGgyL0dncTZ1YVpGZDExL1RUd0REWDdLSGxjOWxRV1RrdVFXRUJu?=
 =?utf-8?B?YU1SYTJGQ09rM0JXRXM1S01kQThYMTJVUjQ1dDhCZi9nVWNPSmtJOUlENGwz?=
 =?utf-8?B?NzhlTllBUEQ5S0cyOE9IZnhxQ3lxbzRiMUFMSU04S1JjdjNhNWpwWVNwZFdP?=
 =?utf-8?B?QkFtSkZXR1pBTWQ0QlJXYVFWUlVIL3NjcWJoSlMxU01yWXFNU0FEVkpRODI0?=
 =?utf-8?B?UFJETmNJOWZMZ2grYkFDVTBIWFRkejNxTUswZ1VQYnJSdWNkd1hLd1lPRXdH?=
 =?utf-8?B?UFlvZVA2NElhZlZlUFR5bGtRc1dibUxkSzVPQ2hmQTF5RmRpYVFiMjZnc3d1?=
 =?utf-8?B?NmtEdWVKWkNGU2xHcWhLa1lYWFpSdUo1Q2dXTGV2ZWlsSmlpSjFIeGpDLzJE?=
 =?utf-8?B?L1ArMlFuMCs0aUhmeCt1eDl0akpZYkZmM1htQi95ejRNaWlVNjkvVVpuZTgx?=
 =?utf-8?B?ME14RGZqbnlEN2RpbXI2VU96RU1yQkhudXRDUEtIT0kvQjlPRDhudGdiQ3Jx?=
 =?utf-8?B?aS9ocko0Q3JNZVlKUEkxYmVabkRDSU5ZTmJXaXpLUWkxdTRpZ2FsS1lyT2RT?=
 =?utf-8?B?dEU3SGFHUHQ5WitwTW1SdE5sMmpnMFdrVFZGdENIUmtmUkowMmVES2crSHJj?=
 =?utf-8?B?bmtmODVuQnJxemZSVll4bndGWXNtSFU0ZWc0VDdRQ0V0bFgrWjhaZTErQ2xD?=
 =?utf-8?Q?P1VI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c16cb1-03cc-4dbd-f993-08dce484df41
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 14:57:31.2164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NM4gd6uuF2EFONOaFOQ+S7lESUzQDI88+LbQcPDN3IUo09TcL2onue1SThyvAehixIdMoQhZPDjxUStIH19HMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA0LCAyMDI0IDc6MjIgUE0N
Cj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsg
dS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0Bh
bWQuY29tPjsgZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gKEFNRC1YaWxpbngp
IDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzddIHVzYjogb25ib2Fy
ZC1odWI6IEFkZCByZXNldC1ncGlvIHN1cHBvcnQNCj4gDQo+IE9uIDEwLzQvMjQgMjowMyBQTSwg
QWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4N
Cj4gPj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDQsIDIwMjQgNDo1MiBQTQ0KPiA+PiBUbzogQWJi
YXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+Ow0KPiA+PiB1LWJv
b3RAbGlzdHMuZGVueC5kZQ0KPiA+PiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFt
ZC5jb20+Ow0KPiA+PiBmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb207IGdpdA0KPiA+PiAoQU1E
LVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvN10g
dXNiOiBvbmJvYXJkLWh1YjogQWRkIHJlc2V0LWdwaW8gc3VwcG9ydA0KPiA+Pg0KPiA+PiBPbiAx
MC80LzI0IDU6MDIgQU0sIEFiYmFyYXB1LCBWZW5rYXRlc2ggd3JvdGU6DQo+ID4+PiBIaSBNYXJl
aywNCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9t
OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPj4+PiBTZW50OiBUaHVyc2RheSwgT2N0
b2JlciAzLCAyMDI0IDEwOjM1IFBNDQo+ID4+Pj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZl
bmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsNCj4gPj4+PiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0K
PiA+Pj4+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+Pj4g
ZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tOyBnaXQNCj4gPj4+PiAoQU1ELVhpbGlueCkgPGdp
dEBhbWQuY29tPg0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS83XSB1c2I6IG9uYm9h
cmQtaHViOiBBZGQgcmVzZXQtZ3Bpbw0KPiA+Pj4+IHN1cHBvcnQNCj4gPj4+Pg0KPiA+Pj4+IE9u
IDEwLzMvMjQgNDo1NCBQTSwgQWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gPj4+Pj4gSGkg
TWFyZWssDQo+ID4+Pj4+DQo+ID4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
Pj4+Pj4gRnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+ID4+Pj4+PiBTZW50OiBU
aHVyc2RheSwgT2N0b2JlciAzLCAyMDI0IDU6MzggUE0NCj4gPj4+Pj4+IFRvOiBBYmJhcmFwdSwg
VmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT47DQo+ID4+Pj4+PiB1LWJvb3RA
bGlzdHMuZGVueC5kZQ0KPiA+Pj4+Pj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0Bh
bWQuY29tPjsNCj4gPj4+Pj4+IGZhYnJpY2UuZ2FzbmllckBmb3NzLnN0LmNvbTsgZ2l0DQo+ID4+
Pj4+PiAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiA+Pj4+Pj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxLzddIHVzYjogb25ib2FyZC1odWI6IEFkZCByZXNldC1ncGlvDQo+ID4+Pj4+PiBz
dXBwb3J0DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gMTAvMy8yNCA2OjQwIEFNLCBBYmJhcmFwdSwg
VmVua2F0ZXNoIHdyb3RlOg0KPiA+Pj4+Pj4+IEhpIE1hcmVrLA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IEhpLA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+Pj4+IEBAIC0zMCw3ICs0MCwyNCBAQCBzdGF0aWMgaW50
IHVzYl9vbmJvYXJkX2h1Yl9wcm9iZShzdHJ1Y3QNCj4gPj4+Pj4+Pj4+IHVkZXZpY2UNCj4gPj4+
PiAqZGV2KQ0KPiA+Pj4+Pj4+Pj4gICAgICAgCWlmIChyZXQpDQo+ID4+Pj4+Pj4+PiAgICAgICAJ
CWRldl9lcnIoZGV2LCAiY2FuJ3QgZW5hYmxlIHZkZC1zdXBwbHk6ICVkXG4iLCByZXQpOw0KPiA+
Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+IC0JcmV0dXJuIHJldDsNCj4gPj4+Pj4+Pj4+ICsJaHViLT5y
ZXNldF9ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAicmVzZXQiLA0KPiA+Pj4+
Pj4+Pj4gKwkJCQkJCSAgR1BJT0RfSVNfT1VUIHwNCj4gPj4+Pj4+Pj4gR1BJT0RfQUNUSVZFX0xP
Vyk7DQo+ID4+Pj4+Pj4+PiArCS8qIHByb3BlcnR5IGlzIG9wdGlvbmFsLCBkb24ndCByZXR1cm4g
ZXJyb3IhICovDQo+ID4+Pj4+Pj4+PiArCWlmIChodWItPnJlc2V0X2dwaW8pIHsNCj4gPj4+Pj4+
Pj4NCj4gPj4+Pj4+Pj4gaWYgKCFodWItPnJlc2V0X2dwaW8pDQo+ID4+Pj4+Pj4+ICAgICAgICBy
ZXR1cm4gMDsNCj4gPj4+Pj4+PiA8VmVua2F0ZXNoPiBBcyByZXNldF9ncGlvIGlzIG9wdGlvbmFs
IHByb3BlcnR5LCAgYnkgcmV0dXJuaW5nIDANCj4gPj4+Pj4+PiB0aGUgaTJjIHNlcXVlbmNlDQo+
ID4+Pj4+PiB3b250IGJlIGV4ZWN1dGVkLg0KPiA+Pj4+Pj4gVGhlIGNvZGUgaW4gaWYgKGh1Yi0+
cmVzZXRfZ3BpbykgeyAuLi4gfSBvbmx5IHRvZ2dsZXMgdGhlIEdQSU8gcmVzZXQgPw0KPiA+Pj4+
PiA8VmVua2F0ZXNoPiBZZXMuLi5pZihodWItPnJlc2V0X2dwaW8pIG9ubHkgdG9nZ2xlcyB0aGUg
R1BJTyByZXNldC4NCj4gPj4+PiBTbyB5b3UgY2FuIHJldHVybiAwIGlmIHJlc2V0X2dwaW8gaXMg
TlVMTCBhbmQgZXhpdCBlYXJseSAuIFdoYXQncyB0aGUgcHJvYmxlbSA/DQo+ID4+PiA8VmVua2F0
ZXNoPiBpZiByZXNldF9ncGlvIGlzIE5VTEwgYnkgcmV0dXJuaW5nIDAgd2UgbWlzcyB0aGUgYmVs
b3cNCj4gPj4+IGNvZGUgd2hpY2gNCj4gPj4gZG9lcyBpMmMgaW5pdGlhbGl6YXRpb24gc2VxdWVu
Y2UuDQo+ID4+PiBOZWVkIHRvIHRvZ2dsZSB0aGUgZ3BpbyBhbmQgdGhlbiBkb2VzIHRoZSBpMmMg
c2VxdWVuY2UgaWYgdGhlDQo+ID4+PiByZXNldF9ncGlvIGlzDQo+ID4+IHByZXNlbnQsIGVsc2Ug
d2UgZG8gdGhlIGkyYyBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZS4NCj4gPj4NCj4gPj4gUGxlYXNl
IHNob3cgbWUgdGhlIGkyYyBzZXF1ZW5jZSB0aGF0IGlzIG1pc3NlZCBpbiB0aGlzIHBhdGNoIGh1
bms6DQo+ID4+DQo+ID4+ICsJaWYgKGh1Yi0+cmVzZXRfZ3Bpbykgew0KPiA+PiArCQlyZXQgPSBk
bV9ncGlvX3NldF92YWx1ZShodWItPnJlc2V0X2dwaW8sIDEpOw0KPiA+PiArCQlpZiAocmV0KQ0K
PiA+PiArCQkJcmV0dXJuIHJldDsNCj4gPj4gKw0KPiA+PiArCQl1ZGVsYXkoZGF0YS0+cmVzZXRf
dXMpOw0KPiA+PiArDQo+ID4+ICsJCXJldCA9IGRtX2dwaW9fc2V0X3ZhbHVlKGh1Yi0+cmVzZXRf
Z3BpbywgMCk7DQo+ID4+ICsJCWlmIChyZXQpDQo+ID4+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+PiAr
DQo+ID4+ICsJCXVkZWxheShkYXRhLT5wb3dlcl9vbl9kZWxheV91cyk7DQo+ID4+ICsJfQ0KPiA+
PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4NCj4gPiBUaGUgaTJjIHNlcXVlbmNlIGNoYW5nZSBp
cyBwYXJ0IG9mICAgW1BBVENIIHY0IDQvN10gdXNiOiBvbmJvYXJkLWh1YjogQWRkIGkyYw0KPiBp
bml0aWFsaXphdGlvbiBmb3IgdXNiNTc0NCBodWIgb2YgdGhlIHNlcmllcw0KPiA+DQo+ID4gKwlp
ZiAoZGF0YS0+aW5pdCkgew0KPiA+ICsJCXJldCA9IGRhdGEtPmluaXQoZGV2KTsNCj4gPiArCQlp
ZiAocmV0KSB7DQo+ID4gKwkJCWRldl9lcnIoZGV2LCAib25ib2FyZCBpMmMgaW5pdCBmYWlsZWQ6
ICVkXG4iLCByZXQpOw0KPiA+ICsJCQlnb3RvIGVycjsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICtlcnI6DQo+ID4gKwlkbV9ncGlvX3NldF92YWx1ZSho
dWItPnJlc2V0X2dwaW8sIDApOw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiAgIH0NCj4gVGhpcyBk
b2VzIG5vdCBzZWVtIHRvIGJlIHBhcnQgb2YgdGhlIGlmIChodWItPnJlc2V0X2dwaW8pIHsgLi4u
IH0gY29kZSBibG9jayA/DQpZZXMuLi50aGlzIGlzIG5vdCBwYXJ0IG9mIHRoZSBpZiAoaHViLT5y
ZXNldF9ncGlvKSB7Li4ufSBjb2RlIGJsb2NrLiANCkFzIEkgZXhwbGFpbmVkIGFib3ZlIGlmIHJl
c2V0X2dwaW8gaXMgTlVMTCBieSByZXR1cm5pbmcgMCB3ZSBtaXNzIHRoZSBjb2RlIHdoaWNoDQog
ZG9lcyBpMmMgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2Ugd2hpY2ggaXMgcGFydCBvZiBbUEFUQ0gg
djQgNC83XSB1c2I6IG9uYm9hcmQtaHViOiBBZGQgaTJjDQogaW5pdGlhbGl6YXRpb24gZm9yIHVz
YjU3NDQgaHViIG9mIHRoZSBzZXJpZXMuDQoNClRoZSBzZXF1ZW5jZSBpcyAiVG9nZ2xlIHRoZSBn
cGlvIGFuZCB0aGVuIGRvIHRoZSBpMmMgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UgaWYgdGhlDQpy
ZXNldF9ncGlvIGlzIHByZXNlbnQsIGVsc2Ugd2UgZG8gb25seSB0aGUgaTJjIGluaXRpYWxpemF0
aW9uIHNlcXVlbmNlIi4NCg0KVGhhbmtzDQpWZW5rYXRlc2gNCg==
