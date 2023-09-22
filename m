Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6387CE6FE48
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 15:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC874864AA;
	Fri, 22 Sep 2023 17:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NOVATECHWEB.onmicrosoft.com header.i=@NOVATECHWEB.onmicrosoft.com header.b="sZZTval4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E61C864AA; Fri, 22 Sep 2023 16:18:49 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A423A8646A
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 16:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mpbod0l+9dc6iLJaRRGJ9MIMNPevoqLNoa8gM8BgUHWk9IBeiqDjSVTdoSS28RP9mbazBBRGz3hmvDT0+QIlPUpmLTkpNsF/zuGpUjw/E2ci40P46xMLydzognUDiEZTHiIRJDcwg4U/7Tdufwq4aTj94P8WWvnmuijWix5LKs+tB3UYQpAVNVuIImyDvScjmGe+CfVOk7uL6LLPtiDWTF0xmLixyZ1nDLKOskwBA0+OnJdE5veaMedPVot0HaeNhGUS6TOLovS2IQUoAn7m0UzgVNEiDhH7dIfvbhBpF22oUk1wD9Bl6JiXGRQcAcL90UDVR6Ehx8n2ug7VP+pHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zMTQgnxh0bdf/6FSpjBKSgUq3HAYBTZ1MhbJmnilks=;
 b=CNGuhH0QFw8npPQEdZN34wZusfoFoD/E8SsBZQ8iy2NgnV0P6az9AAyRdrpwHFYJoZrs5decJZqn7n9ffjzTpH7HutStR/Nyf872uYnK0YAlfEa9CmXl7VG7hC8ny85P5F5RhGsFWeJ98dh5BhVImCwmEpamFnV4idr+dQYDgXZoQ3+INJ8x+hBJ0m8xcdnWaDeWYRBV5DnprvK/E95T0DZqyAJTjZAuKsynKB2AqMXEFvNXxUfA6e1+1cAfS/68k3HsVVAOD7lW6kkhG0sCXNpSEsvZtkooj8s2n4tL99d8MNfRgTEnLSKw29HZIWotVAMMeAGTVYNFGKN0zwwT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=novatechautomation.com; dmarc=pass action=none
 header.from=novatechautomation.com; dkim=pass
 header.d=novatechautomation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NOVATECHWEB.onmicrosoft.com; s=selector2-NOVATECHWEB-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zMTQgnxh0bdf/6FSpjBKSgUq3HAYBTZ1MhbJmnilks=;
 b=sZZTval4kBMV4Oz0AzlWsnu8K98TPtZ1xePNpRRH40u+lE/j5bVpElTZd1lwnUoUxxQfnhJxPaaT1JamlK1v8pWu8nmafom2jwYJdigTg45qgFvLnc6WmqrU1YrLoadVOxsve9kDHKMUky4dtB3EnC5K0m5LyJeYHoVgvbgG5GQ=
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com (2603:10b6:a03:4fa::13)
 by CH0PR07MB8841.namprd07.prod.outlook.com (2603:10b6:610:102::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12; Fri, 22 Sep
 2023 14:18:41 +0000
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::528e:58b9:a915:935f]) by SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::528e:58b9:a915:935f%4]) with mapi id 15.20.6838.009; Fri, 22 Sep 2023
 14:18:40 +0000
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [NEW FEATURE] RFC: Add Intel GMBUS support
Thread-Topic: [NEW FEATURE] RFC: Add Intel GMBUS support
Thread-Index: AQHZ7Ncr2JlRRf7OJ0GRzrqYM3U1tLAmCpGAgADQd4Y=
Date: Fri, 22 Sep 2023 14:18:40 +0000
Message-ID: <SJ2PR07MB9711EF5C4CC30A8E449E3EDB81FFA@SJ2PR07MB9711.namprd07.prod.outlook.com>
References: <SJ2PR07MB971186693F591659C4758AC381F8A@SJ2PR07MB9711.namprd07.prod.outlook.com>
 <CAEUhbmXhNJ4D9wZv6TV1cqB_hyQv9R9Ynad5Dp4YwHG-7Lda=Q@mail.gmail.com>
In-Reply-To: <CAEUhbmXhNJ4D9wZv6TV1cqB_hyQv9R9Ynad5Dp4YwHG-7Lda=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=novatechautomation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR07MB9711:EE_|CH0PR07MB8841:EE_
x-ms-office365-filtering-correlation-id: aeffe1eb-b96b-40e4-5fe4-08dbbb76d1d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAfiErW9sHCAxcokDJTOh+MO+KNrLJPYlPNbTg5H54MQ7WzjUsIhO3eqaMr5lLl0lHYlmRfqbSfx39FgQ39FpuvIo+yfdwW/8gRYxUOaJ9T3dCIvi0qAoIj+14xPQZswm/KNF0ibyXTAqoq5Zh5z0dwW544FuLz97I5WvwHv04m96ovFYggltUi0QOz9nyOSwbllsFmgYw2q6BF8JlP+7Uy6jYrpMsaTUX1PoJRnnfsANXhwM0FuieGu6H6vX+9IiZ/M+MDf1+Tv0NZyq5TC+9OvVkuuFD8PZmwCARUgwsGtHvP+8HxADlRFm9Ar7vftP+vWWvaFuwJDaKDEyYrgguM+1tAY/Gbp6qzEGtMqD6/R1AOsrQvsHt/4/1qIEiGIfPzX6TiXulvLhS7UKBaDDJ5qPtxeTNSOzf40bj1BBebZFQ9BBLS8e06F8CyDWWcsliNjKIR40Ubz6hOh4JNe/YbJMKaYS0iu6asqXYXhpHkGuX7Ya/BXNEV5om5HhS80JkUAVd0q0KiJ9A0b9Wvzp0WZ7TMejL0OMH26SRIfPmGSzwNVbQ54FVAa7vF3XyWY3B7Xh8yLFSXUkqagJ28mdRcVjP7SJpuqx/vtl45tgSCAp5b84ybYudEyEHCk/sZsGRcfKH6ND8IUldenG7MnMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR07MB9711.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(346002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(83380400001)(38070700005)(38100700002)(122000001)(71200400001)(966005)(478600001)(26005)(53546011)(5930299018)(55016003)(9686003)(7696005)(6506007)(86362001)(33656002)(2906002)(40140700001)(44832011)(8676002)(52536014)(8936002)(4326008)(5660300002)(76116006)(91956017)(110136005)(66446008)(66476007)(64756008)(66556008)(41300700001)(66946007)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3dCcndhclpyVWZRNXoxZnAxV1RXOVQ4YXhVM0E1VGFacEtiekdYWmduTVlx?=
 =?utf-8?B?dkYwTUJpMHBWTGNGZWNvRzN3R2xXc1p4bzAxbFkyR2N3dU8yNExpNFFhSjIz?=
 =?utf-8?B?WXVEZStYeWh0WUFSNmwxbjZDM29zVUEvYTRvaHZQVVowL1JNS0E0TThmUGJZ?=
 =?utf-8?B?eW5tS0dnazJvLzNBRG51aFI0VElYTi95aEZOS3pVMU1aYllYVU9wOWFnTXJL?=
 =?utf-8?B?TVptNmRpZlFMN2NUU0hBc0xUZUhpNVhrcERQdHJicnhZdXVFRFBRcjJURlNN?=
 =?utf-8?B?aFpTeDJvS25PYVoyOWp5dTZjQ3NaS3FORFgxU3FEZDBtQ0FnTGhSeHg1aHly?=
 =?utf-8?B?bXdnUVRFOXIwRkNreHljZGxSK1ZFdk5FL0g3cVZ0S2lVRGJlWEE1NWNzVXJ2?=
 =?utf-8?B?REgraWRTN0szcDBkYnc4dGtyRDdIODFwbkVua0VjakNNMkt5bE84NXMyTDgw?=
 =?utf-8?B?NmNISVd5N3NJakpIdzlteEY0RnlpUEFucUZhaGN6VlJObitmUERWU1JLd29J?=
 =?utf-8?B?UFhnOGVsMlh5dzZFU3cxS3BLdGRwWnhndVpFaVoxbmEyVDZHdmVVUkMxTjdk?=
 =?utf-8?B?ejBYNGVVZFBzT1l4STFMR1lBN3pFV2t2TjN4Vk5QZFJUWkRsdnRXOGgvTEZM?=
 =?utf-8?B?d2h3a3lueWZWYkdud2RlQjF4T2VVamhwN3BiQ0NkRlcwemhvYkw3VEJYN2Jh?=
 =?utf-8?B?T0kxcHpnVnhQT1dEZlJ6akU4ZCt4UGVEdzd4RGhQM2c5YnVhajJZQ3l4UzN1?=
 =?utf-8?B?T1MvcmYrUTNmNW1uRGEzU3grYVNMZ2c2bUZBUDF1WEdsdW9Wa0h6RFFwRVAz?=
 =?utf-8?B?THpVd0FOMHVqRENyWnZveTR1NjRUUFNDWFp1dk0zMmVXMzBmTDFXeVhGV3Z3?=
 =?utf-8?B?QitiK3JXWkpsYXJiN3JmeHNlOHRDdUt3RXRkVEw2OFhuL3dUWDRaaU5pMk5T?=
 =?utf-8?B?MEVhOCszR2UvYlNkcmVyaDJyb2Q0cld5WUwxZ2Nzc3F4VTdXaUdISWpSK2hM?=
 =?utf-8?B?R0FBVndWSHMxYzliRStmdzdYRk52SlEzbUx0WWhqdGJSVzlLVUEwejFCb09H?=
 =?utf-8?B?TlNacHFZUmhjN0dLY2VTSXFPUlMweU5SZitKQzExNlB5M2ppSnJyclloNkIr?=
 =?utf-8?B?TlA0NlpJTWovbFlUQ3dQQ1ZrZ2hnOC8xak42SlNyVTFaaHBoamRVZ3NxbzVq?=
 =?utf-8?B?Skd2UDV2RGtmVk1Gb2V2Z2ZreTFNRHJYOTIrVS8zMTVZNVJSZi8zaC9lVmdz?=
 =?utf-8?B?azduV1hjdFhIL3hlcUhvWldGUmZ1eHBGNHh4djFzVUl2eHB2K2NLemNpL2dw?=
 =?utf-8?B?TTlmQzlSZFVqRk5McUJoc2JHY2ZrRytRWWFQcGdRQXVQcjZrMS94TGppNDZJ?=
 =?utf-8?B?MXV6eGgrMUZsL21LdjBHckVPQmV0eEtwem0wZDZUN1pRVjNWUnhzWUZJNUVV?=
 =?utf-8?B?dk1wK3l0VkcyNm00ZTdISFlYdm1nZDNLSjlmbW1lY1BtcjdGRWVZcFVLU2sy?=
 =?utf-8?B?WjV1dnhJME53K2pWazhMRkFyVmJYVFpmUENpb0s5a25WRktiaWJraUpwSjNE?=
 =?utf-8?B?Q0RISzVZdzZ4VGFTbHBKZURSanhLWUpHK1dqQUx4dmdnT0J5VnRXeXhLTXBT?=
 =?utf-8?B?M1dNQWdaK0lxakZsOHNlMmN1YzYvTU9Zb2JlVFJKUEFBQUlZaXE5cUsybDgx?=
 =?utf-8?B?Nzg4dno3enltdGQzMGpIWkkvMXVyZEV4c2NWZDVBb0szVVNCTzljWVdmeHpT?=
 =?utf-8?B?eThXemhORVNBOGpiY3UzTHdtUldBUCt6ZkUvMFpieGRXT05wODJhN3B3c2Fk?=
 =?utf-8?B?cVdZTGZZODhuejEzS0Urc2FiTkN3UElxbUo2Nk90NzNvS3c3alZjZG5pYytF?=
 =?utf-8?B?OUNTbEprWEFZRHpvQTU1SFZ2SS9iSm51S1V5aHdLejcvU3FsWmFPbytmcU5p?=
 =?utf-8?B?SGxDYWlZMExqQ1dueGlmKzlWeWRsZUxXU3c1YVRldlUwVEYrZmVCSFJONWE1?=
 =?utf-8?B?bFRSNG1QZzV1OWxyYis0a0xuLzBaMjR5RXhuQ1BVN2lyaG9jQTdwb2Z3bElv?=
 =?utf-8?B?bXlrUjVrQnFaaWVZL1hyMEFTeVRpMmlNOXo5NkdUcE54UTEwUUNDZDVaeCtl?=
 =?utf-8?B?Q2UrRWlEUXVpM2pzYitIdW1LcWNCdWorZU1aRVI2Mm9iZFllUjI1ZTREWEww?=
 =?utf-8?Q?5fDs/ik6g/+foH+VCgqc2g0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: novatechautomation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR07MB9711.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeffe1eb-b96b-40e4-5fe4-08dbbb76d1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 14:18:40.3653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb0f6598-d3e5-4ff3-a8b8-fe893d304059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajMRjb7x+K+3QhkWGy5kuedQDHT3vfPHfFFPiWqw9x5wR3GX3bwQPiAGsHqvrYMLEPEDQjw+6XurHR2FymjAc5Rqs655q8GJg9hw85jdSo2XjEluOYChOhUFtjS8W01B35627j3h0DbeuLyp6sR5OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8841
X-Mailman-Approved-At: Fri, 22 Sep 2023 17:14:32 +0200
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

SGVsbG8sDQoNClRoYXQgaXMgY29ycmVjdC4gVGhlIG5ldyBsYXRlciByZXZpc2lvbiBCYXl0cmFp
bCBjaGlwcyBkbyBub3QgcmVsaWFibHkgaW5pdGlhbGl6ZSB2aWRlbyB1cG9uIGJvb3QuIEkgaGF2
ZSB0YWtlbiBhIHNpZ25pZmljYW50IGFtb3VudCBvZiB0aW1lIHRvIGFuYWx5emUgdGhlIGlzc3Vl
LiBUaGUgU09DcyBwcm9kdWNlZCBhZnRlciAyMDE5IHNob3cgdGhpcyBpc3N1ZSwgYWx0aG91Z2gg
SSBkb250IGhhdmUgdGhlIHNwZWNpZmljIFNLVSBvciBzdGVwcGluZyBkZXRhaWxzIGFzIG91ciBw
cm9kdWN0aW9uIHRlYW0gaGFzIG5vdCBiZWVuIGxvZ2dpbmcgdGhhdCBkYXRhLiBXZSBoYXZlIHNl
dmVyYWwgaHVuZHJlZCBvZiB0aGVzZSBTT0NzIGluIGludmVudG9yeSBhbmQgYXJlIHNlZWluZyBh
IDIwJSBmYWlsdXJlIHJhdGUgcmVzdWx0aW5nIGluIHRoZXNlIGJvYXJkcyBiZWluZyBtYXJrZWQg
YmFkLiBUaGUgdmVuZG9yIChBZHZhbnRlY2gpIHVzZXMgYW4gQU1JIEJJT1Mgb24gdGhlIFNPTSB3
aGljaCB3ZSByZXBsYWNlIHdpdGggVS1Cb290LiBUaGUgQU1JIEJJT1MgaXMgYWJsZSB0byByZWxp
YWJseSBpbml0aWFsaXplIHRoZSB2aWRlbyBvbiB0aGUgU09DcyBpbiBxdWVzdGlvbi4gSSBoYXZl
IGNhcHR1cmVkIHRoZSBjb21tdW5pY2F0aW9uIG9uIHRoZSBHTUJVUyBmb3IgYm90aCB0aGUgVS1C
b290IGluaXRpYWxpemF0aW9uIGFuZCB0aGUgQU1JIGluaXRpYWxpemF0aW9uLiBCb3RoIGNhbiBi
ZSBjbGVhcmx5IHNlZW4gcnVubmluZyB0aGUgSW50ZWwgVkJJT1MsIGJ1dCB0aGUgdmVuZG9ycyBC
SU9TIHRoZW4gYWRkaXRpb25hbGx5IGdhdGhlcnMgZGF0YSBhcHByb3ggMTAwbXMgbGF0ZXIgZnJv
bSB0aGUgR01CVVMgdG8gYmUgdXNlZCB0byBwcm9wZXJseSBpbml0aWFsaXplIHRoZSBHUFUuIFRo
aXMgY2FuIGJlIHNlZW4gb24gdGhlIGdvb2dsZSBkcml2ZSBsaW5rIGJlbG93IGluIHRoZSBmaWxl
ICJMb2dpYy1DYXB0dXJlLnBuZyIuIEkgaGF2ZSBhbHNvIGRvbmUgYSByZWdpc3RlciBkdW1wIGNv
bXBhcmlzb24gYmV0d2VlbiBhIGtub3duIGdvb2QgU09DIGFuZCBhIGtub3duIGJhZCBTT0MuIFRo
ZSByZWdpc3RlciAiUElQRUFGUkFNRUNPVU5UIiwgb2Zmc2V0IDB4NzAwNDAgY2FuIGJlIHNlZW4g
dGhhdCB0aGUgbW9uaXRvciBkb2VzIG5vdCByZXBvcnQgYmFjayBzdWZmaWNpZW50IFZTWU5DIG9u
IHRoZSBuZXdlciBzaWxpY29uLiBUaGlzIGNhbiBiZSBzZWVuIG9uIHRoZSBnb29nbGUgZHJpdmUg
bGluayBiZWxvdyBpbiB0aGUgZmlsZSAiUmVnaXN0ZXItQ29tcGFyaXNvbi5wbmciLiBJIGhhdmUg
YWxzbyBpbmNsdWRlZCB0aGUgZnVsbCByZWdpc3RlciBkdW1wcyBpbiB0aGUgdGV4dCBmaWxlcy4g
SWYgeW91IHdvdWxkIGxpa2UgSSBjYW4gYWRkIHRoZSBhY3R1YWwgTG9naWMgY2FwdHVyZSBmaWxl
cyBmb3IgZnVydGhlciBpbnNwZWN0aW9uLiBUaGUgSW50ZWwgZG9jICJpbnRlbC1vcy1nZngtcHJt
LXZvbDEwLWRpc3BsYXkucGRmIiBkb2VzIG5vdCBzaG93IGNvbmZpZGVudGlhbCBvciBOREEgc28g
SSBiZWxpZXZlIHRoaXMgaXMgYSBwdWJsaWMgZG9jdW1lbnQgdGhhdCB3ZSBjYW4gdXNlIHRvIGlt
cGxlbWVudCB0aGUgbmVlZGVkIGZlYXR1cmVzLg0KDQpHb29nbGUgRHJpdmUgd2l0aCByZWZlcmVu
Y2VkIGRhdGE6DQpodHRwczovL2RyaXZlLmdvb2dsZS5jb20vZHJpdmUvZm9sZGVycy8xT3BYVDdG
YWtzMnNmSUtCSXYtSm1oRVllTHpGWXd2bUY/dXNwPXNoYXJpbmcNCg0KDQoNCkVyaWMgU2NoaWtz
Y2huZWl0DQpTZW5pb3IgRW1iZWRkZWQgTGludXggRW5naW5lZXIgSUlJICDigIsNCg0KTm92YVRl
Y2gsIExMQw0KMTM1NTUgVy4gMTA3dGggU3RyZWV0IHwgTGVuZXhhLCBMUyA2NjIxNeKAiw0KTzog
OTEzLjQ1MS4xODgw4oCLDQogIOKAiw0Kbm92YXRlY2hhdXRvbWF0aW9uLmNvbSB8wqBOb3ZhVGVj
aExpbmtlZEluDQpSZWNlaXB0IG9mIHRoaXMgZW1haWwgaW1wbGllcyBjb21wbGlhbmNlIHdpdGgg
b3VyIHRlcm1zIGFuZCBjb25kaXRpb25zLu+7vw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQpGcm9tOiBCaW4gTWVuZyA8Ym1lbmcuY25AZ21haWwuY29tPg0KU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA4OjE0IFBNDQpUbzogRXJpYyBTY2hpa3Nj
aG5laXQ7IFNpbW9uIEdsYXNzDQpDYzogdS1ib290QGxpc3RzLmRlbnguZGUNClN1YmplY3Q6IFJl
OiBbTkVXIEZFQVRVUkVdIFJGQzogQWRkIEludGVsIEdNQlVTIHN1cHBvcnQNCg0KK1NpbW9uDQoN
CkhpIEVyaWMsDQoNCk9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDY6MTDigK9BTSBFcmljIFNjaGlr
c2NobmVpdA0KPGVyaWMuc2NoaWtzY2huZWl0QG5vdmF0ZWNoYXV0b21hdGlvbi5jb20+IHdyb3Rl
Og0KPg0KPiBJIGhhdmUgYmVndW4gd29ya2luZyBvbiBhZGRpbmcgc3VwcG9ydCBmb3IgdGhlIElu
dGVsIEdyYXBoaWNzIE1hbmFnZW1lbnQgYnVzIHRvIFUtQm9vdC4gQ3VycmVudGx5IHRoZSB4ODYg
YnJpbmcgdXAgcHJvY2VzcyAoYXMgZXhwbG9yZWQgb24gdGhlIEJheXRyYWlsIHNlcmllcyBvZiBB
dG9tIFNPQ3MpIHJlbHlzIG9uIHRoZSBJbnRlbCBWaWRlbyBCSU9TIHRvIGRvIGFsbCBzZXR1cCBh
bmQgY29uZmlndXJhdGlvbiBvZiB0aGUgR1BVLiBUaGlzIG1ldGhvZCBvZiBhZGRpbmcgdmlkZW8g
c3VwcG9ydCB3b3JrcyBvbiBlYXJsaWVyIHZlcnNpb25zIG9mIHRoZSBzaWxpY29uLiBXaXRoIGxh
dGVyIHZlcnNpb25zIEkgaGF2ZSBmb3VuZCB0aGF0IHRoZSBPRU0gQklPUyBuZWVkcyB0byBjYXB0
dXJlIHRoZSBtb25pdG9yIGRhdGEgb3ZlciB0aGUgR01CVVMgaW4gb3JkZXIgdG8gaW5pdGlhbGl6
ZSB0aGUgR1BVIHByb3Blcmx5LiBJIGhhdmUgbG9naWMgYW5hbHl6ZXIgY2FwdHVyZXMgYXZhaWxh
YmxlIGZvciBhbnlvbmUgd2hvIGlzIGN1cmlvdXMuIE15IHB1cnBvc2UgZm9yIHRoaXMgcGF0Y2gg
aXMgYSBza2VsZXRvbiBwbGFjZWhvbGRlciB0aGF0IEkgd2lsbCBiZSB3b3JraW5nIGZyb20sIGFu
ZCBJIGFtIGFza2luZyBmb3IgY29tbXVuaXR5IGNvbGxhYm9yYXRpb24gd2l0aCB0aGlzLiBJIGhh
dmUgaGFyZHdhcmUgYXZhaWxhYmxlIGZvciB0ZXN0aW5nIGFzIG5lZWRlZCwgYW5kIHNvbWUgZGV0
YWlscyBjYW4gYmUgcHJvdmlkZWQgdXBvbiByZXF1ZXN0Lg0KDQpXb3VsZCB5b3Ugc2hhcmUgdGhl
IGRvY3VtZW50YXRpb24gdGhhdCBkZXNjcmliZXMgdGhlIEludGVsIEdNIGJ1cywgaWYNCnB1Ymxp
Y2x5IGF2YWlsYWJsZT8NCg0KQmFzZWQgb24gdGhlIGluZm8geW91IHByb3ZpZGVkLCBkaWQgeW91
IG1lYW4gd2l0aCBsYXRlciBuZXcgcmV2aXNpb24NCkJheVRyYWlsIGNoaXBzLCB0aGUgdmlkZW8g
YmlvcyBpbml0aWFsaXphdGlvbiBpcyBub3QgZW5vdWdoIGluIFUtQm9vdD8NCkFGQUlVLCB0aGUg
VS1Cb290IEJheVRyYWlsIHN1cHBvcnQgcmVsaWVzIG9uIEludGVsIEZTUCB0byBkbyBhbnkNCmNo
aXBzZXQtc3BlY2lmaWMgd29yaywgaW5jbHVkaW5nIHRoZSB2aWRlbyBiaW9zIHNldHVwLg0KDQpS
ZWdhcmRzLA0KQmluDQo=
