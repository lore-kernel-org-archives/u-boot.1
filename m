Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB1EC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 18:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D6087B8A;
	Tue, 23 Jan 2024 19:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BeQJJLUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326DE87DEB; Tue, 23 Jan 2024 19:53:57 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C13D875E9
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 19:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdjsnf0+Un+Cq7v8Es7zp0QLWNk2oAEoEDPbvEigk7vy1a1/RBYT5Fk1POGKJ6+divWx6oaUgcTTHbavLHZH5GwmHSNKI2hafr6k2UArLBUP8fBhuKFEJXOyu6cQmN/Wl7lY3vywY04M8QnDbTgnX8kwVvJsGNIEe8AlUGFpKXF+WCTOWFEDedBrcezvBYx/apIwOn0mbnJffTT2i+QfH9rTdkCRbOYljbklJcbFPwfNSL2qHBuMK8WyxigdO8/hJ5lSsGvCgfkZ+d2tO7tbn0MQT6Aj9ZmtWpSVO+tgdHjLBPFIX1F36u83la1IXW87DT6zSiGSnprDYACrD5ce+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRxXlOiy3X9ibIoq0wPv2YAwk0AIaWbE5V/uhqZtyRs=;
 b=OZ8ocPyEIOkpJ8ME1UW6LNl9OMCm1u3UH4aS3mIk7KrIvpBfALABDzam3KY6JkjJTlSb42wAUJKX2YP6K1D2kJ/Kib9pWD1JO75Hq1p8yyO1Tc6h1vhk+N0XAeuEIHG9ZCQkO4NlJzc7ApMRrSHaEbkLV5kQLKYvNQVKgcAgb09uVS1U0Bu/b+yhiX6/mTHDQUVaRCXykmiABn3s5U92IVuW79k/1sFZLR9AZ++ReMzNo2rI8Z3buVaKeNM0vwu4A5dwmRngPmKYyB+yreNDkiQMo6fF08Lvq3OhJO6SvNSqoVS8j6wbYgSCabvWtwIVtDcdXTRljxzXyaWRNOSgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRxXlOiy3X9ibIoq0wPv2YAwk0AIaWbE5V/uhqZtyRs=;
 b=BeQJJLUl20Oen77b5ZKJebZAYnOyID48CGIxpegAnjANSAK0iGT6CWHjhRRoOtrenGyZcx6brjtdLfeJfI53dhGC7BmW4mOhOau9kgKk9c87qFVznAeftgZbkw0aDZgfwFuFAPCeERcHmml1nBPr3jRE2zAjU1zGuPzc8+FXWas=
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 18:53:47 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::39dd:303b:6776:9ebd]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::39dd:303b:6776:9ebd%6]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 18:53:46 +0000
From: "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>, "Simek, Michal"
 <michal.simek@amd.com>, "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "git@xilinx.com" <git@xilinx.com>
Subject: RE: [PATCH] efi_loader : Suppress error print message
Thread-Topic: [PATCH] efi_loader : Suppress error print message
Thread-Index: AQHaTWcKTXUGe9FrbU+APrM9+g+VtbDnEsqAgAAYXYCAAHTwEA==
Date: Tue, 23 Jan 2024 18:53:46 +0000
Message-ID: <BL3PR12MB64505057156F40CDD884FB90D8742@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20240122191242.2989327-1-tejas.arvind.bhumkar@amd.com>
 <CAC_iWjKEMs_0WHyu7ttfvP30vG=sJnhY5XWY=5hGBTAW_5oxyg@mail.gmail.com>
 <d2b79924-87bc-42a2-9d06-6fcba06ed267@gmx.de>
In-Reply-To: <d2b79924-87bc-42a2-9d06-6fcba06ed267@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c5ce1afb-0b8f-4ebc-9c8c-d11f8b55d32e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-23T16:58:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|PH7PR12MB5709:EE_
x-ms-office365-filtering-correlation-id: 1b649dbd-7d68-4bf6-d06c-08dc1c44a0f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GzXhyQQPgwCSrnHFr7JpYKlGiJKDdi6JQ46rgut7WZtWYMlc8uJ1qAkPHT25Av75O2dEvw/oGXgwYOy3Fc5MXqlPvUl0dql156ohYvX2T1bitTR2QoIwHwQJZLZrIytuGa3RVVzS9bjn2eDYMOGiWN/4ZCf2wANSGx508gGUzA/4OX3jt5s7UpkvOjyqc2CzjGrePs7/w+LV2SkkQZlyKUPlPUIN6qKKwJ3tIbucrC4zUvgElVk8gLXm9cpj1qJMHtIdO4q7YABYGsc9lr8eCLkhKic+ndM/PwklQisnEepmAgCsNhUIB+Trd3rnHHKlA/3DqCgN3BCNbyLetaU0frixwOHH4CCnkDTjx8y+CjKC+wcP0ag0c7LLmnpr8iY0p1hUywNCf5RbhaGKKoQF3wGQjiKWA87V0dfq+ExwkVZVpzOlsakN7JVD46mUJeEimmXmAmb6ch1eWcQorYEXi759H1waDeYnukdhtmcIxK57whYKyUD8klPCQgM/B4kKfb3ADk3ok/SNS/IomSY2O7QY60xQOdLQI9OyfE0rEa+3YiBJgnGrz1Dl7pDFDt4EBVMqHciyRZ8CkRhuyqk2fGC3A3e8mf6qjJGS19NEzU4oXBBfgT3YiRNFAazGXlrTTqyh7a69G8037T3ukzDq2U+9WgG/6Q6UQu4YIy1WIhOsQ7mrBBpH4Jewf1pCNqDY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6450.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(76116006)(9686003)(6506007)(7696005)(26005)(83380400001)(33656002)(64756008)(41300700001)(8936002)(8676002)(4326008)(316002)(2906002)(86362001)(5660300002)(54906003)(66556008)(15650500001)(52536014)(66476007)(66946007)(53546011)(38070700009)(66446008)(110136005)(71200400001)(966005)(478600001)(55016003)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nmk5aTdlbzhsSThkOVljY2pYT1EveGtwT2k2S1p4TlZPYTlLZWpUZGRESmZn?=
 =?utf-8?B?TVhVZXU5UGF1TTlzK1cvNDJrVURhSWdCWERFUCszcTA5N0pQVEM2TEVHSG83?=
 =?utf-8?B?Q2R5Q09vNGd1SHYyZFQwS3hHNkZlbWJpc2ErbThXaTU2QUZLclU4d1NkL1Z3?=
 =?utf-8?B?b1FWa1NYOFVkbDRWMlhpVFUyay92YWxrQ3k0ZHdKVEhWUEFjV2ZZbVRLM21G?=
 =?utf-8?B?c3dkemR2U3FBNG9HcWJSaGRYYi8xcDZuemZLV3pTQ2xmNmNXcGFtMXhlbjNR?=
 =?utf-8?B?Mm93Sk1jaThGNnJOeHhOQklIa1ZSZ0hFRmhsdzcyRy8vTm5QZ0pSeVo4OFF4?=
 =?utf-8?B?MU1ONWFjNUFkVldiRG5DdVEvdmpSV0JBNnIzZVJZOXpHUzFIWWpqTm5FRlpo?=
 =?utf-8?B?WmsyTWExNGw3U3hJQmV2aWw2WDRpZ2pJT3VuSG94UHIxYkpVY2pBcjBVOXNj?=
 =?utf-8?B?MGNCSnFyZVBoOEpiZ3BCODNXSXBVQWtEcXZBbWZlSkVJQ2NYczVDVmYzTU1p?=
 =?utf-8?B?QWw4czdaTlBrNVA1eUxCa2QvL2xTM3duUGZOSk1wS1dHTGppUUlab01LbWZD?=
 =?utf-8?B?RkY3MWNJNjYvbUQ2ZklkM003L0Q3eEQ5RkNqVUdSaHhvdHFJQTNPVFovcW5W?=
 =?utf-8?B?V1I5bWJNS3VYMTFZTWgrQnFJaTVCTTN2ZE1sWWdXR01ranoxekkyUXR5QnlE?=
 =?utf-8?B?MUVBZWd0VUp1Rm5zR2loQlBnWU9ibWtOZUlON3JVb0t5MjNZZGRLMDJjNmZx?=
 =?utf-8?B?K2FlZDNCbnZaZy9qTDM2M0NWeTFCMWpIMmhYNklJdXRjQTVBOUhoSmdXdEM2?=
 =?utf-8?B?RDlETVV4TEU2Vk01eXk3dnhOM1JLMkY0TFNtMTdSUFAyNDYvaE45SSt4MEtk?=
 =?utf-8?B?WW1CcGQwL2FWZXRZVGhUdHI4azBiOHRscG9jZkRHdFJzYjlweEViRDhJKzQy?=
 =?utf-8?B?aFRMZ2FtV3ZNTlFNR1NjVExhYmUycmJ6c3Y0cXVXc1lHbzFhQllZenkzU1VQ?=
 =?utf-8?B?TWJOOFZGcmloV1RqZkdJTlVKcHMxTys1enZHSmFTUzBQZWVVY1FWYUF6TnJZ?=
 =?utf-8?B?NDFWTjZYeVQxSWpQWVZIQmEwWVdNOXl1dEhyNUg5b1BHaHlQSlArVVE5dHRO?=
 =?utf-8?B?aDNJczZlZ3dWOEIwTk9DODhCdEozVWFYUHZrQkJNOW9RVFZIYzFPS3Jsdml1?=
 =?utf-8?B?Nk9SV2NpL1d5c1RwZFdoMzFMWVBhUXlXaHNzL1BRVGVwMGxsekFPdXZzeUpS?=
 =?utf-8?B?VkpWeEdlSmxzaDhLZVlPWCtJdW1Kc3BVczZPVTNScUNqMjJZdXB6VmRFeEJn?=
 =?utf-8?B?dWxWR2NnbmxLd1QvZnBGeFlRcWp2U0tUUzlwMEErQjlDeHpSZEY5cFdISHlM?=
 =?utf-8?B?YThxOW1XeEpUR3NwUWVWc25ZdmpZMGZwbStkbU5QdG1lWTV2aGtaN2p5RW9o?=
 =?utf-8?B?VTI4bjdoY2dJNGFaeFZsSWwyRDlRejFsWWZLVENZVUEwMEQwaUxJOWRMM3A0?=
 =?utf-8?B?cWtqQXQ0NXAvYjZneEdkNCtFd3gvUi9hdGg3UUZLWktRTTU1a3Q1b0NQOTFo?=
 =?utf-8?B?NUFOTVZkSkg4Vm9RUGJOUHd0U0xRM3I3RXNyeTYwUFpWdEdZQ0VONnZyU0lR?=
 =?utf-8?B?b3QrUDNzRXhUOWF4VFJSR1ZFa3hKVU1YeGJPVFRkaHlnSkZrSjRsS1htdmtU?=
 =?utf-8?B?ZWNOSllNMytTSVJzU21DZzdFSEVsVWNnMnpKOFUybEJoelM0U2gvOUlsV2hn?=
 =?utf-8?B?dTNVMEt4cXNnRTUyK3N6TS80d1RXdzJiSXd2UVB4ai8wN0dVMDV5OWdKVm5G?=
 =?utf-8?B?SXlaQlJYQWxhTDZmdlRQdHhDblM2Zi9GaUFkV20xYUtRVmhxMGNtTGxCOVls?=
 =?utf-8?B?TXpxTG5mSWpibDlvOWt4YnVWS3JZcUhCeXFaUyt0L055d1ZodDJwcUliSlQ3?=
 =?utf-8?B?T0txdEdrek5BRC9aMFRjT0RMZFRIM3FEdFBKeUpKNmJoSmJJZ2RydG1Gai9i?=
 =?utf-8?B?bk90TGxOdThNbWxWYXdCa3BXT3k5STJzMWd0bDlrVm5RYTViQXJsRDc1Y2k5?=
 =?utf-8?B?RDlYUE9oVmM4Z3NJd3haSTh6SVBXTUt2bnFTaWxBOWpLVFNSZ1dSelA4S1M3?=
 =?utf-8?Q?KoAc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6450.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b649dbd-7d68-4bf6-d06c-08dc1c44a0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 18:53:46.2723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ra9NTRJk8NhRLrHW9xE0mulBaeAV6j46fft8eqpvqItg/U5ceG3G1a1XAd5L6uaOzPRGtJygFhdt/hof8tQ2ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIElsaWFzICYgSGVpbnJpY2gs
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbnJpY2ggU2NodWNo
YXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIzLCAy
MDI0IDM6MzAgUE0NCj4gVG86IElsaWFzIEFwYWxvZGltYXMgPGlsaWFzLmFwYWxvZGltYXNAbGlu
YXJvLm9yZz47IEJodW1rYXIsIFRlamFzIEFydmluZA0KPiA8dGVqYXMuYXJ2aW5kLmJodW1rYXJA
YW1kLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyB4eXByb24uZ2xwa0BnbXguZGU7
IHRyaW5pQGtvbnN1bGtvLmNvbTsNCj4gc2pnQGNocm9taXVtLm9yZzsgU2ltZWssIE1pY2hhbCA8
bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBYmJhcmFwdSwNCj4gVmVua2F0ZXNoIDx2ZW5rYXRlc2gu
YWJiYXJhcHVAYW1kLmNvbT47IGdpdEB4aWxpbnguY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGVmaV9sb2FkZXIgOiBTdXBwcmVzcyBlcnJvciBwcmludCBtZXNzYWdlDQo+DQo+IENhdXRpb246
IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJv
cGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywg
b3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMS8yMy8yNCAwOTozMywgSWxpYXMgQXBhbG9kaW1h
cyB3cm90ZToNCj4gPiBIaSBUZWphcywNCj4gPg0KPiA+IE9uIE1vbiwgMjIgSmFuIDIwMjQgYXQg
MjE6MTIsIFRlamFzIEJodW1rYXINCj4gPiA8dGVqYXMuYXJ2aW5kLmJodW1rYXJAYW1kLmNvbT4g
d3JvdGU6DQo+ID4+DQo+ID4+IEN1cnJlbnRseSwgb24gY2VydGFpbiBYaWxpbnggcGxhdGZvcm1z
LCBhbiBpc3N1ZSBoYXMgYmVlbiBpZGVudGlmaWVkLA0KPiA+PiBtYW5pZmVzdGluZyBhcyBmb2xs
b3dzOg0KPg0KPiBIZWxsbyBUZWphcywNCj4NCj4gdGhhbmsgeW91IGZvciBicmluZ2luZyBmb3J3
YXJkIHRoaXMgaXNzdWUuDQo+DQo+IFdoaWNoIGRlZmNvbmZpZyBhcmUgeW91IHJlbGF0aW5nIHRv
Pw0KDQpbVGVqYXNdOg0KQ2hlY2tpbmcgd2l0aCB4aWxpbnhfenlucW1wX3ZpcnRfZGVmY29uZmln
DQoNCj4NCj4gPj4NCj4gPj4gU3RhcnRpbmcga2VybmVsIC4uLg0KPiA+Pg0KPiA+PiBlZmlfZnJl
ZV9wb29sOiBpbGxlZ2FsIGZyZWUgMHgwMDAwMDAwMDc3ODMwMDQwDQo+ID4+IGVmaV9mcmVlX3Bv
b2w6IGlsbGVnYWwgZnJlZSAweDAwMDAwMDAwNzc4MmQwNDANCj4gPj4gZWZpX2ZyZWVfcG9vbDog
aWxsZWdhbCBmcmVlIDB4MDAwMDAwMDA3NzgyYzA0MA0KPiA+Pg0KPiA+PiBUaGUgaXNzdWUgYXJp
c2VzIHdoZW4gdGhlIHJhbWRpc2sgaW1hZ2UgaXMgcmVsb2NhdGVkLCBwbGFjaW5nIGl0DQo+ID4+
IHdpdGhpbiB0aGUgcHJldmlvdXNseSBhbGxvY2F0ZWQgRUZJIG1lbW9yeSByZWdpb24oIGFzIEVG
SSBpcw0KPiA+PiBlc3RhYmxpc2hlZCBxdWl0ZSBlYXJseSBpbiBVLUJvb3QpLg0KPg0KPiBXaGlj
aCB2ZXJzaW9uIG9mIFUtQm9vdCBhcmUgeW91IG9uPyBDb21taXQgMDZkNTE0ZDc3YzM3ICgibG1i
OiBjb25zaWRlciBFRkkNCj4gbWVtb3J5IG1hcCIpIHdhcyBtZWFudCB0byBhdm9pZCBzdWNoIGEg
c2l0dWF0aW9uLg0KDQpbVGVqYXNdIDoNCkknbSB2ZXJpZnlpbmcgYWdhaW5zdCB0aGUgbGF0ZXN0
IGNoYW5nZXMgaW4gdGhlIG1hc3RlciBicmFuY2guIFRoZSBpbnRyb2R1Y3Rpb24gb2YgY29tbWl0
IDA2ZDUxNGQ3N2MzNyAoImxtYjogY29uc2lkZXIgRUZJIG1lbW9yeSBtYXAiKSBoYXMgcmVzb2x2
ZWQgdGhlIG9jY3VycmVuY2Ugb2YgdGhlICJlZmlfZnJlZV9wb29sOiBpbGxlZ2FsIGZyZWUiIGVy
cm9yLiBidXQsIGl0IGxlYWRzIHRvIGEgbmV3IGVycm9yLCBhcyBkZXRhaWxlZCBpbiB0aGUgZm9s
bG93aW5nIHBhdGNoOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMTIxNTA3MDYu
Mjk2NzAwNy0xLXNqb2VyZEBjb2xsYWJvcmEuY29tLw0KDQo+DQo+ID4NCj4gPiBJIGRvbid0IG1p
bmQgc3VwcHJlc3NpbmcgdGhlIHByaW50IGZvciBzb21lIHRpbWUsIGJ1dCBvdXQgb2YNCj4gPiBj
dXJpb3NpdHksIGhvdyBpcyB0aGUgcmFtZGlzayByZWxvY2F0ZWQ/IExNQiBzaG91bGQgYmUgYXdh
cmUgb2YgdGhlDQo+ID4gRUZJIHJlZ2lvbnMgYnkgdGhlbiwgc28gSSBhc3N1bWUgdGhlIHJlbG9j
YXRpb24gY29kZSBkb2Vzbid0IGNoZWNrDQo+ID4gdGhvc2U/DQoNCg0KW1RlamFzXSA6ICBJIG9i
c2VydmUgdGhhdCB0aGUgcmVsb2NhdGlvbiBvZiB0aGUgUkFNIGRpc2sgaXMgdGFraW5nIHBsYWNl
IGluIHRoZSBsaW5lIGJlbG93Lg0KaHR0cHM6Ly9naXRodWIuY29tL3UtYm9vdC91LWJvb3QvYmxv
Yi9tYXN0ZXIvbGliL2xtYi5jI0w0ODAtTDQ5MQ0KWWVzLCB0aGUgcmVsb2NhdGVkIGNvZGUgc3Bl
Y2lmaWNhbGx5IGV4YW1pbmVzIHRoZSBMTUIgcmVnaW9uIGFuZCBkb2VzIG5vdCBjb25zaWRlciB0
aGUgRUZJIHJlZ2lvbi4NCg0KPg0KPiBUaGUgaW5kaWNhdGVkIHNpdHVhdGlvbiBpcyBzZXJpb3Vz
LiBJZiB0aGUgRUZJIHN1Yi1zeXN0ZW0gaXMgdXNpbmcgdGhlIHNhbWUgbWVtb3J5DQo+IGFyZWEg
YXMgdGhlIHJhbWRpc2ssIHRoaXMgbWF5IGxlYWQgdG8gY29ycnVwdGlvbiBvZiB0aGUgcmFtZGlz
ay4gU3VwcHJlc3NpbmcgdGhlDQo+IG1lc3NhZ2VzIGlzIGJ5IG5vIG1lYW5zIGFkZXF1YXRlIHRv
IHNvbHZlIHRoZSBwcm9ibGVtLg0KDQpbVGVqYXNdIDoNClRoZSBjaGFsbGVuZ2UgYXJpc2VzIHdo
ZW4gcmVsb2NhdGluZyB0aGUgcmFtZGlzayBpbWFnZSwgaW5zZXJ0aW5nIGl0IGludG8gdGhlIHBy
ZXZpb3VzbHkgYXNzaWduZWQgRUZJIG1lbW9yeSByZWdpb24sDQplc3RhYmxpc2hlZCBlYXJseSBp
biBVLUJvb3QuIENvbnNlcXVlbnRseSwgd2hlbiBhdHRlbXB0aW5nIHRvIHJlbGVhc2UgbWVtb3J5
IGluIHRoZSBFRkkgcmVnaW9uIGR1cmluZyB0aGUgaGFuZG92ZXINCnByb2Nlc3MgdG8gdGhlIGtl
cm5lbCBpbiB0aGUgZWZpX2ZyZWVfcG9vbCBmdW5jdGlvbiwgd2UgZmlyc3QgdmVyaWZ5IGlmIHRo
ZSBtZW1vcnkgd2FzIGFsbG9jYXRlZCBieSBlZmlfYWxsb2NhdGVfcG9vbCgpLg0KVGhlIGlzc3Vl
IG9yaWdpbmF0ZXMgZnJvbSBhIGNoZWNrc3VtIG1pc21hdGNoIGJlY2F1c2UsIGR1cmluZyB0aGUg
cmFtZGlzayByZWxvY2F0aW9uLCB3ZSBvdmVyd3JpdGUgbWVtb3J5IGFsbG9jYXRlZCBieSBFRkku
DQpUaGlzIGxlYWRzIHRvIHRoZSBhcHBlYXJhbmNlIG9mIHRoZSBlcnJvciBtZXNzYWdlOiBlZmlf
ZnJlZV9wb29sOiBpbGxlZ2FsIGZyZWUgMHgwMDAwMDAwMDc3ODMwMDQwLg0KQ3J1Y2lhbGx5LCB0
aGVyZSBpcyBubyBjb3JydXB0aW9uIG9mIHRoZSByYW1kaXNrIHNlZW4gc2luY2Ugd2UgZG8gbm90
IGFjdHVhbGx5IHJlbGVhc2luZyBtZW1vcnkgZHVlIHRvIHRoZSBjaGVja3N1bSBtaXNtYXRjaC4N
CkluIG91ciB0ZXN0aW5nLCB0aGlzIGlzc3VlIHdhcyBvYnNlcnZlZCBvbmx5IHdoZW4gdGhlIHJh
bWRpc2sgc2l6ZSBleGNlZWRlZCBhcHByb3hpbWF0ZWx5IDI0IE1CLg0KDQo+DQo+IEJlc3QgcmVn
YXJkcw0KPg0KPiBIZWlucmljaA0KPg0KPg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gL0lsaWFzDQo+
ID4NCj4gPj4gQ29uc2VxdWVudGx5LCB3aGVuDQo+ID4+IGF0dGVtcHRpbmcgdG8gcmVsZWFzZSBt
ZW1vcnkgaW4gdGhlIEVGSSBtZW1vcnkgcmVnaW9uIGR1cmluZyB0aGUNCj4gPj4gaGFuZG92ZXIg
cHJvY2VzcyB0byB0aGUga2VybmVsLHdlIGVuY291bnRlciBtZW1vcnkgdmlvbGF0aW9ucy4NCj4g
Pj4NCj4gPj4gSGlnaGxpZ2h0aW5nIHRoYXQgRUZJIHJlbWFpbnMgYWN0aXZlIHByaW1hcmlseSBk
dXJpbmcgdGhlIGJvb3Rpbmcgb2YNCj4gPj4gYW4gRUZJIGFwcGxpY2F0aW9uLCBhbmQgdGhlIGxt
YiBwZXJzaXN0cyB3aGlsZSBjb25maWd1cmluZyBpbWFnZXMgZm9yDQo+ID4+IHRoZSBib290IHBy
b2Nlc3MuIFNpbmNlIHdlIGFyZW4ndCB1dGlsaXppbmcgdGhlIEVGSSBtZW1vcnkgcmVnaW9uDQo+
ID4+IGR1cmluZyB0aGUgYm9vdCBwcm9jZXNzLCB0aGVyZSBpcyBubyBhZHZlcnNlIGltcGFjdCBl
dmVuIGluIHRoZSBldmVudA0KPiA+PiBvZiBhIHZpb2xhdGlvbi4NCj4gPj4NCj4gPj4gQ3VycmVu
dGx5LCB0aGVyZSBpcyBhbiBvbmdvaW5nIGRpc2N1c3Npb24gcmVnYXJkaW5nIHRoZSBoYW5kbGlu
Zw0KPiA+PiBzdHJhdGVnaWVzIG9mIHRocmVlIG1lbW9yeSBhbGxvY2F0b3JzOiBtYWxsb2MsIGxt
YiwgYW5kIEVGSS4gVGhpcw0KPiA+PiBkaXNjdXNzaW9uIGlzIGRvY3VtZW50ZWQgaW4gdGhlIGVt
YWlsIGNoYWluIHRpdGxlZCAiUHJvcG9zYWw6IFUtQm9vdA0KPiA+PiBtZW1vcnkgbWFuYWdlbWVu
dC4iDQo+ID4+DQo+ID4+IFRoZXJlZm9yZSwgaXQgaXMgYWR2aXNhYmxlIHRvIHN1cHByZXNzIHRo
ZSBwcmludCBtZXNzYWdlIGR1cmluZyB0aGUNCj4gPj4gYm9vdCBwcm9jZXNzIGZvciBub3cuDQo+
ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFRlamFzIEJodW1rYXIgPHRlamFzLmFydmluZC5iaHVt
a2FyQGFtZC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGxpYi9lZmlfbG9hZGVyL2VmaV9tZW1vcnku
YyB8IDIgKy0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2xpYi9lZmlfbG9hZGVyL2VmaV9tZW1vcnku
Yw0KPiA+PiBiL2xpYi9lZmlfbG9hZGVyL2VmaV9tZW1vcnkuYyBpbmRleCBlZGZhZDJkOTVhLi44
MjFmZTc2MTZlIDEwMDY0NA0KPiA+PiAtLS0gYS9saWIvZWZpX2xvYWRlci9lZmlfbWVtb3J5LmMN
Cj4gPj4gKysrIGIvbGliL2VmaV9sb2FkZXIvZWZpX21lbW9yeS5jDQo+ID4+IEBAIC03MTMsNyAr
NzEzLDcgQEAgZWZpX3N0YXR1c190IGVmaV9mcmVlX3Bvb2wodm9pZCAqYnVmZmVyKQ0KPiA+PiAg
ICAgICAgICAvKiBDaGVjayB0aGF0IHRoaXMgbWVtb3J5IHdhcyBhbGxvY2F0ZWQgYnkgZWZpX2Fs
bG9jYXRlX3Bvb2woKSAqLw0KPiA+PiAgICAgICAgICBpZiAoKCh1aW50cHRyX3QpYWxsb2MgJiBF
RklfUEFHRV9NQVNLKSB8fA0KPiA+PiAgICAgICAgICAgICAgYWxsb2MtPmNoZWNrc3VtICE9IGNo
ZWNrc3VtKGFsbG9jKSkgew0KPiA+PiAtICAgICAgICAgICAgICAgcHJpbnRmKCIlczogaWxsZWdh
bCBmcmVlIDB4JXBcbiIsIF9fZnVuY19fLCBidWZmZXIpOw0KPiA+PiArICAgICAgICAgICAgICAg
ZGVidWcoIiVzOiBpbGxlZ2FsIGZyZWUgMHglcFxuIiwgX19mdW5jX18sIGJ1ZmZlcik7DQo+ID4+
ICAgICAgICAgICAgICAgICAgcmV0dXJuIEVGSV9JTlZBTElEX1BBUkFNRVRFUjsNCj4gPj4gICAg
ICAgICAgfQ0KPiA+PiAgICAgICAgICAvKiBBdm9pZCBkb3VibGUgZnJlZSAqLw0KPiA+PiAtLQ0K
PiA+PiAyLjI3LjANCj4gPj4NCg0K
