Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC266F88092
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490E683EEF;
	Thu, 16 Apr 2026 09:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkvZqjHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26084840AB; Thu, 16 Apr 2026 09:12:24 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A7483C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcA5l+U7XQ/0uQj6Za0VD7bqgWCiYzegFDxAaRKW0lsorDN5MmHfhzXOBiOn8ONWTva3zeF5+5jAoj+0cdHp1ZH4xT8BWP/rjLSOyxMllpzD3b197zA9cbuklMkGKkdUHu0TbIO6D2OrWcYFNiI4DD2cTwk4X8qTB6znuTSMnFlkRq064xfjrEdCPgz/MLNwh083SlgtdCz2RgJVBFMk9GkIKhjitZWRZZq0N08JQ80DSJJj5CE+zVKnJ/LRa5UYdR9syEgsK6bNhQGaenBy/ffyHeq/qWaFMl69YTBytP1fNgMFJK08oBGrvKhnH6sKiDUKyKs6jmcm6bTJxD06FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFRmo0OE9GODhm25sdGZ0x9csPgKKF9ndAcGJq8HdqI=;
 b=O9/+dvrVuE7xFpj3jmXe9OxVkM1vDnrNPfKy4uvmiC5IhjGO6FuQezm8ZlyQPuvHWdtPTDHan46OA/XVq+1Uk+sZTAKFxqtfOlZqMGaTw7LTfce6UL2IjGA6YnN7E9l/ew2sxm2OeN7CG3tVJihLEKFTHEwSTZziWyb7Y32qwUSS3dr3XlINGW1XnHztGZ358/e6en+gaEV39QAlpllFqBl/2THXO6frAKCElhUqtZdFT1r3EqOJ2WF9gP6vzOsHhQPJvqs3Sojdt8/QmijAIyD0hizIDJq81caOqiPtJRp9JuP7EyfeDcrIloRjtCzU7cNsnOrj5p0OuBRFGUXIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFRmo0OE9GODhm25sdGZ0x9csPgKKF9ndAcGJq8HdqI=;
 b=bkvZqjHOLxBGDNtgccsLLgAAtWSDGql8RIdk4FInwLspvsqyt3Wyz3s2TrmcArZcRchtdPXA+b9zLVQiaW6KARGcpSozhzkQPkBllW9iD01m6qVo4Cp7fYtzqudq0CwgMvGBvrMfmKDDAvun4mCVwnKehZ55HL1e/MCASv8c0R0=
Received: from MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 07:12:15 +0000
Received: from MW6PR12MB7088.namprd12.prod.outlook.com
 ([fe80::e56b:9894:876a:c049]) by MW6PR12MB7088.namprd12.prod.outlook.com
 ([fe80::e56b:9894:876a:c049%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 07:12:15 +0000
From: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Simek, Michal" <michal.simek@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Begari, Padmarao"
 <Padmarao.Begari@amd.com>, Jerome Forissier <jerome.forissier@arm.com>, Tom
 Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Lucien.Jheng
 <lucienzx159@gmail.com>, Yao Zi <me@ziyao.cc>, SkyLake.Huang
 <skylake.huang@mediatek.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ramon Fried <rfried.dev@gmail.com>
Subject: RE: [PATCH v2] net: phy: fix duplicate eth_phy binding
Thread-Topic: [PATCH v2] net: phy: fix duplicate eth_phy binding
Thread-Index: AQHcxzYXHVoTXn1cvkyIT3u+WwUWu7XVW+4AgAv1eZA=
Date: Thu, 16 Apr 2026 07:12:15 +0000
Message-ID: <MW6PR12MB708846C3A34019C7D34DC435FB232@MW6PR12MB7088.namprd12.prod.outlook.com>
References: <20260408085844.2942463-1-pranav.vinaytilak@amd.com>
 <ffade924-420d-48e6-a49c-b2cb2673c94e@mailbox.org>
In-Reply-To: <ffade924-420d-48e6-a49c-b2cb2673c94e@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-16T07:09:05.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7088:EE_|SA1PR12MB8985:EE_
x-ms-office365-filtering-correlation-id: 9ed9d0cc-1963-4743-bed1-08de9b877d12
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: tkHNjZwj9YhpF+N6DNoPmHIUp7NBTOh6iGyiad4FVfIBCvey7OBirAZUwskS3OzrD4IX/9by1RiUBfqe3c/JtbIYmcVuhSMDNiE/LE3xk8rtAa8aoayQ0fxjrJ0VXRw+9tezI8O/lWUTSprAp/713MO0bhVtqlv6R/OoUGN7/2dgpaIRg8jXo+xd7LT3Ii1YI5gpK/8JhNujioxaL5o1fIOsMNszQb4JsgBQYiU+JXgEJ+nag/ihYvUF9KZ5zGC/fZujXN2OwnYMpqZkWtKF7hZm8uGE7eNfuqeQxt2RzeXLsYLpXDpU2iA+g0XMp3vzNu1RuT/IULJrFUYptr8Rszf9qX9eGv2TpEfaYnPnSWYn13qlYWR4FXrCMLuU2/d8BH47ikw2C76bP8BHponIb4NY890OUSJe33cg3V1F3qoAHKm2MlAfLrVmLY4F3tHihi3Bl6jiYcF5irYfcKro9RpCrpeud4FYKZ9d/RTqV1nCsrKMHgipgfJKGh/PJ8HSEIdPvvOFtzmrckAEZ/JIXH0bX3bbkUu8xytD1YMIvlan3jrGZHOBBtWE8YnUPhH+qVSHCEg/EJ2jerboTEukgaUVhxX0XkE4TPjLIidrq46FJBlm89FgI2XKsjFk1IwOfvKcS8RWyZjTh/npcG5yvGko5oabAOiTXItXO05Sq5qWM9Sg67IQP7beRjIChl4Q5LMKVYF3+bPJ0LgdvH1J1iHJpLQGgz4MRLH3k095cETNjgvuZBFmZqHJR3jnuNV5HTK+O7qh5/htcnjxoNOGI49nUBfdDxicyq8UcCAcgXI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7088.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzhIejMxT2NqdFB0amNjNlRvSjZ0NlBNMVMwOFg4N0VGWElxTEpjYis5TEV0?=
 =?utf-8?B?TzdzUkk3WVZaYThPYjBtVzF5c1dpNnNNajlHSFg5cGFBdGtWckU5S2pyMmpX?=
 =?utf-8?B?c3NPYkY0c2o4Slg3ZGJCNjBiK2xRaHF5aktsSnpHQkEyU3lVcXNlcy8yK0Rk?=
 =?utf-8?B?a3FTTDFnWUhabXUrVlJHM2JERmRCZWg0TDdvbGhEa2dzaUI5a01xOFF1akNm?=
 =?utf-8?B?REJwOUplS1RyVll5Vi9aYm1sYUNIbis4cFdCcHVmRTI1bmU0ZDdYRWdESmpE?=
 =?utf-8?B?ckJ5Z0tmRFlxY2Z2OFdaTGNLY0ZTdzFHaWZPcHJ4S0JLS3Erc0FlbEZvdHUy?=
 =?utf-8?B?dFVtaWVNRGI5bUtxYnJxNGlCQVZFUXVXSzJxTG1LS2x0L1JES1ZzQjNPSVcz?=
 =?utf-8?B?K3N1NUtIL0MzZXJabnU0SkY1UFFJTlZGeUJWNFJ2VTdPVWMyWEpTQWdIN1A1?=
 =?utf-8?B?RWY4dTFmRzZhS2ZySmszVDlLc1hsTEQrTjRmZXgxYjlnRi9wN3FOcTFzaGFG?=
 =?utf-8?B?UmlTRzk0b3AyeTE3QzIwYlJ5a2k4YnZiWGQ4WGN1WTRObHRiT2VHVldCVUJG?=
 =?utf-8?B?NnJaQkdpdEJlK3dqV2lHSE4wRGZhdXNVSkx5end0UGRpVld1QmwyZVcxc0hh?=
 =?utf-8?B?L2VWZWJubWpsVXZHVGxOdWRjb1hUa3FzZWVnZkR4Mmh1cnBwMVlETGQrL0p3?=
 =?utf-8?B?a1JrYXhNOTF2Z2pxelNkai9ENXg2d2srQS9kQWdRUGZxK2hHdzVNcGRxdjE4?=
 =?utf-8?B?cEJHeCsrTjI3cnRsSzVld2dBaUkwT0ZzaTV1TzJsMHZ5cHpPU1YyRENKVlZC?=
 =?utf-8?B?ZFJXTWtQcnM5YTFXYnBCYkkycDNWZExQcnQwOHRsRWk2VlJDdEtkL1dweW1V?=
 =?utf-8?B?Q05Hb202NXFKQ25RMGhhOE4wb0RSRjNhc3RFczR1SktuTEhKSGVHdE9YSmtI?=
 =?utf-8?B?R2p1QjY4VG9TbWpzS1R0Uk92WUZPcGVUN1hKUlhPTVFwQVpTQm1VYys4c1pQ?=
 =?utf-8?B?REIvTFFrU05SQW9kdWpYOUdPTGpNOVRJRjhocWhkNmd1U04reXVvV09lQ2x1?=
 =?utf-8?B?Tks4OEJQV0pGRGE5U29HeVN4MjlCL3Q2azRueUVPc21BRnRXbFFCYTErTERs?=
 =?utf-8?B?TFYzanM0NGNWS0JPSEpQaU5Vc015QzJyc3NJaGNpWlYxZFhBM2RlazRkRURn?=
 =?utf-8?B?YkZOVEc1Q1hNTVJrN2pWREZFanU4SmlnWlpPci9hcGFsRTlIUC9VZ2lNWFEv?=
 =?utf-8?B?WEJEVC9qVHkvSFZGdW1ueGxaZDV1REJZRllMTkREWTlnZ0lpTDE2b2J5UTVm?=
 =?utf-8?B?UktuWXRQcXBnWStQWXBhTUhVN3d3aWkyVzhiVGErRis1MlVkK29LUk52QnBh?=
 =?utf-8?B?ZHAzUUhhcFI2RTNDeC9IQW5NSmhmQnZuMVN3cFVDb2MyWEQvdGlWZGxmRDJX?=
 =?utf-8?B?SnhGOXpFbDA5UW5hcy9SMWdoWE5uRnN1U1pHUTdGOUlsZmQ5Mzd2REtnZmFE?=
 =?utf-8?B?VlN0UWtadmlDMnB5N29SNGtyOW1mRnhHSjVVczhYUlZNbTJBL2dSbTN5MTZC?=
 =?utf-8?B?RktaOFpFYjBOREo1QjZLY2Q4dkJHQ3hZYyt6clRlb0FVTUtZT2k0RWVyY3Q5?=
 =?utf-8?B?YkJWajZOQlpxbjRXaW9ib3hZZjZoSUM0NkIySy9yMUtERHViU0V6S3ljSmpl?=
 =?utf-8?B?SFRSZU91YTQ5UnRsRElUVC9UQXM0ZkR0ZERHblpWWUFLeTVkeElicGw2TG96?=
 =?utf-8?B?ZDM4QmVCdHZOdGt5eE1xQ0ZDR1ZxbXN0aFVLUjNqK0doL0h4Zkllaklpa09x?=
 =?utf-8?B?NjZlQkF6cVN6bExObVBLL3FjaFNONytEZ0o3Tk1tVmU0cmpaNFRIR1JLaEZG?=
 =?utf-8?B?WktZRDRJZjVldWNYNTJIdHhlcnRDUFdDMWdQRmRxNEppSFZEWUZrS2ZndGRP?=
 =?utf-8?B?emRoQlZhWmhBaFd1L3JkSnBld1pSWko1bVhubUFMVTRGUzdFblZzWTFTOEVZ?=
 =?utf-8?B?RWtQcmw2bFlLWDRMaGhhTGY1Z2xMUW82Ni9Ga1RaQm1pVytkR05oV0RLMHBr?=
 =?utf-8?B?K3pyWmdHSEtMRzdFVllBa1J0OGhGS0VJR2Y5V0ZEcGpVazhQNFJsR0tOcEU2?=
 =?utf-8?B?VGxwZFY5YjBEaFBYVFRtRTV3MW8wYnJSbm5sSzZpazNOdUE5aGxpMUtMVFJl?=
 =?utf-8?B?SVZka3B1RlR0clluVkhEMXBNZ2xCTEFPSUlaWk02bmNFbVY5NkRNL2xxQ0pG?=
 =?utf-8?B?bldKVzYydnRsZUVzaWF0MmpHdCtVZnpMUVlybE52dG1sV1VDdG5BZVFQdnBq?=
 =?utf-8?Q?N9uIeP1LA2ksqyZW0O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed9d0cc-1963-4743-bed1-08de9b877d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 07:12:15.4079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xpq0KKWepxTdHiJ/bK0pRXdiKT5QLJSpPNpwgBF8DI7LRmrZN+5xiYFktDJkGMeb7ZkIpdQL6PDRnz1TDdVIVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985
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
Cg0KSGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFy
ZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFw
cmlsIDgsIDIwMjYgMTA6MDIgUE0NCj4gVG86IFZpbmF5IFRpbGFrLCBQcmFuYXYgPFByYW5hdi5W
aW5heVRpbGFrQGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4gU2ltZWssIE1pY2hh
bCA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IENjOiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1k
LmNvbT47IEJlZ2FyaSwgUGFkbWFyYW8NCj4gPFBhZG1hcmFvLkJlZ2FyaUBhbWQuY29tPjsgSmVy
b21lIEZvcmlzc2llcg0KPiA8amVyb21lLmZvcmlzc2llckBhcm0uY29tPjsgVG9tIFJpbmkgPHRy
aW5pQGtvbnN1bGtvLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgTHVjaWVu
LkpoZW5nIDxsdWNpZW56eDE1OUBnbWFpbC5jb20+OyBZYW8gWmkNCj4gPG1lQHppeWFvLmNjPjsg
U2t5TGFrZS5IdWFuZyA8c2t5bGFrZS5odWFuZ0BtZWRpYXRlay5jb20+OyBTaWRkaGFydGgNCj4g
VmFkYXBhbGxpIDxzLXZhZGFwYWxsaUB0aS5jb20+OyBNYXJlayBWYXN1dA0KPiA8bWFyZWsudmFz
dXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IFJhbW9uIEZyaWVkIDxyZnJpZWQuZGV2QGdtYWlsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbmV0OiBwaHk6IGZpeCBkdXBsaWNhdGUgZXRo
X3BoeSBiaW5kaW5nDQo+DQo+IE9uIDQvOC8yNiAxMDo1OCBBTSwgUHJhbmF2IFRpbGFrIHdyb3Rl
Og0KPiA+IFdoZW4gYm90aCBDT05GSUdfUEhZX0VUSEVSTkVUX0lEIGFuZCBDT05GSUdfRE1fRVRI
X1BIWSBhcmUNCj4gZW5hYmxlZCwNCj4gPiBldGhfcGh5X2JpbmRzX25vZGVzKCkgY2FsbGVkIGZy
b20gZXRoX3Bvc3RfYmluZCgpIGFscmVhZHkgYmluZHMgdGhlDQo+ID4gZXRoZXJuZXQgUEhZIG5v
ZGUgdG8gZXRoX3BoeV9nZW5lcmljX2Rydi4gSG93ZXZlciwNCj4gPiBwaHlfY29ubmVjdF9waHlf
aWQoKSBjYWxsZWQgdmlhIHp5bnFfcGh5X2luaXQoKSAtPiBwaHlfY29ubmVjdCgpDQo+ID4gY2Fu
bm90IGF0dGFjaCB0byB0aGUgYWxyZWFkeSBib3VuZCBQSFkgZGV2aWNlIGFuZCBjcmVhdGVzIGEg
c2Vjb25kDQo+ID4gaW5zdGFuY2UsIHJlc3VsdGluZyBpbiBkdXBsaWNhdGUgZW50cmllcyBpbiB0
aGUgZG0gdHJlZToNCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGd1YXJkaW5nIHRoZSBwaHlfY29ubmVj
dF9waHlfaWQoKSBjYWxsIGluIHBoeV9jb25uZWN0KCkNCj4gPiB3aXRoIHVjbGFzc19nZXRfZGV2
aWNlX2J5X3BoYW5kbGUoKSB0byBza2lwIHJlLWJpbmRpbmcgaWYgdGhlIFBIWSBub2RlDQo+ID4g
aXMgYWxyZWFkeSByZWdpc3RlcmVkIGluIFVDTEFTU19FVEhfUEhZLg0KPiA+DQo+ID4gRml4ZXM6
IDY4YTRkMTUwNjEwOSAoIm5ldDogcGh5OiBCaW5kIEVUSF9QSFkgdWNsYXNzIGRyaXZlciB0byBl
YWNoIG5ldw0KPiA+IFBIWSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUHJhbmF2IFRpbGFrIDxwcmFu
YXYudmluYXl0aWxha0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4g
LSBNb3ZlIGR1cGxpY2F0ZSBiaW5kaW5nIGNoZWNrIHRvIGNhbGxlciBwaHlfY29ubmVjdCgpDQo+
ID4gLSBVcGRhdGUgY29tbWl0IGRlc2NyaXB0aW9uDQo+ID4NCj4gPiAgIGRyaXZlcnMvbmV0L3Bo
eS9waHkuYyB8IDkgKysrKysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Bo
eS9waHkuYyBiL2RyaXZlcnMvbmV0L3BoeS9waHkuYyBpbmRleA0KPiA+IGQ3ZTBjNGZlMDJkLi5j
ZmNhODMyOGYxYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9waHkvcGh5LmMNCj4gPiAr
KysgYi9kcml2ZXJzL25ldC9waHkvcGh5LmMNCj4gPiBAQCAtOTM4LDggKzkzOCwxMyBAQCBzdHJ1
Y3QgcGh5X2RldmljZSAqcGh5X2Nvbm5lY3Qoc3RydWN0IG1paV9kZXYNCj4gKmJ1cywgaW50IGFk
ZHIsDQo+ID4gICAjZW5kaWYNCj4gPg0KPiA+ICAgI2lmZGVmIENPTkZJR19QSFlfRVRIRVJORVRf
SUQNCj4gPiAtICAgaWYgKCFwaHlkZXYpDQo+ID4gLSAgICAgICAgICAgcGh5ZGV2ID0gcGh5X2Nv
bm5lY3RfcGh5X2lkKGJ1cywgZGV2LCBhZGRyKTsNCj4gPiArICAgaWYgKCFwaHlkZXYpIHsNCj4g
PiArICAgICAgICAgICBzdHJ1Y3QgdWRldmljZSAqcGh5X2RldjsNCj4gPiArDQo+ID4gKyAgICAg
ICAgICAgaWYgKHVjbGFzc19nZXRfZGV2aWNlX2J5X3BoYW5kbGUoVUNMQVNTX0VUSF9QSFksIGRl
diwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAicGh5
LWhhbmRsZSIsICZwaHlfZGV2KSkNCj4gPiArICAgICAgICAgICAgICAgICAgIHBoeWRldiA9IHBo
eV9jb25uZWN0X3BoeV9pZChidXMsIGRldiwgYWRkcik7DQo+IFNob3VsZG4ndCB0aGlzIGJpbmRp
bmcgY2hlY2sgYmUgY2xvc2VyIHRvIHRoZSBiZWdpbm5pbmcgb2YgcGh5X2Nvbm5lY3QoKSA/DQo+
IEJhc2ljYWxseSBjaGVjayB3aGV0aGVyIHRoZSBQSFkgZHJpdmVyIGlzIGFscmVhZHkgYm91bmQg
YXQgdGhlIGJlZ2lubmluZywgYW5kDQo+IGlmIHNvLCB5b3UgYXJlIGRvbmUuIEkgZG9uJ3QgdGhp
bmsgdGhhdCB0ZXN0IGlzIHNwZWNpZmljIHRvDQo+IENPTkZJR19QSFlfRVRIRVJORVRfSUQsIGlz
IGl0ID8NCg0KVGhlIGNoZWNrIGlzIHBsYWNlZCBpbnNpZGUgcGh5X2Nvbm5lY3RfcGh5X2lkKCkg
YmVjYXVzZSB0aGF0IGlzIHRoZSBvbmx5IGNvZGUgcGF0aCB0aGF0IGNhbGxzIGRldmljZV9iaW5k
X2RyaXZlcl90b19ub2RlKCkgb24gdGhlIFBIWSBub2RlLCB3aGljaCBjcmVhdGVzIHRoZSBkdXBs
aWNhdGUuIFRoZSBvdGhlciBwYXRocyAocGh5X2Nvbm5lY3RfZml4ZWQsIE5DU0ksIHBoeV9jb25u
ZWN0X2dtaWkycmdtaWkpIGRvIG5vdCBiaW5kIHRoZSBQSFkgbm9kZSBhbmQgYXJlIG5vdCBhZmZl
Y3RlZC4NCg0KVGhhbmtzICYgUmVnYXJkcywNClByYW5hdiBUaWxhaw0K
