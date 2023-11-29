Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73AEC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 12:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF4687645;
	Wed, 29 Nov 2023 13:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="B1r1mAV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A3D86BD6; Wed, 29 Nov 2023 08:52:47 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FDCD86B9A
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlXIIDs7sFl1DmyV4qXRb6AqhVqY2oPDfoBOqC+oMqyOQt6CH1rMF4bq2TgFNyFlmXKZJ0K1hA6N9KUrx2Muv3ClQcy0mmc8iIOemWw98TShm4OrJswOR3cInTgFypRwLUEGzipOdMbqQ/DWXt0r9ZDatqmFpQB1N2ePEv+PAYVcTQ0zmEImBdxcV3t6xIt7gjm45ij37Vs67xwNdfjIGudavzlXvjADmS4XhOm7IiwtR7k3d56mpAqNIr6vLBk0ChTeIGdJLvzD6NB2TwTN/eU4k+Q1QWDui1VtKjqBRwoxsySL893U5Y9xgyNYaIyn4b/LNb4z/CHT9dZ4y1Z9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoVTyx8n4Y++Emb7PxIDCicBX93x9Lc/tu8NU4G8eko=;
 b=i2w1Zz9b230GlLFvrn4y9TxTVixHicpyUmbYU27JmNMPIUegtMix6CIpSQ5nLbnojPjNmoh8E19tn683TGsiyH+0JCLASZf0s3K/LNHuYL6YHcF1mFiz72U/I+D6ef/4KcjW8vZl3gafM4TkwiUx45YmfadGkbBVyyvEoWftGD+YjdvDegNdrwdv+WCj9xhTILR75EtKp005M2EqolB68nciMGZYNilXU2Kaa7SguUwSSLT838mAsfGnR5qsl906M7ASg0a1h395ImghhsZq1MNT9Hz/tvUKZI8JMBX4tyoaz76MBHYxXccVJiB2zUJ13nmAfmW2zmeDNTS2vtx50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoVTyx8n4Y++Emb7PxIDCicBX93x9Lc/tu8NU4G8eko=;
 b=B1r1mAV5C8V6HwLBv/Xbi8jw0BKGDUsaxAtinVbx4c3j8nPDzeiT5KwuMBW5kBwE527heOBUs5WvvGxqLmKvyU2WN+TBgaWpxa2aogUgZz35S0ItEvPuDAMihVNDCAH3TLlHWDAJpr1ycdRYVctUYbbcKHv8tpYJrUlZxh34+QncqsVrAm2Rxh9uwbrVkmYaa5qtOR7B8C/aKVENtyXmkpAnrRQZZN/ng/eBftgBZPFaXdM/N+x2TJa0J6CgzXqlRB6FjLzDwVLAcqEMKcjiEuq1fJ1DsLzH5cWpJjnHPeraMiS5+LNs+0hNPSC4LgvplTLRN3ZE5t66toKjaTN65g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 07:52:42 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 07:52:42 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Leto, Enrico"
 <enrico.leto@siemens.com>
Subject: Re: [PATCH 6/6] siemens: factoryset: use correct config for soc
 specific implementation
Thread-Topic: [PATCH 6/6] siemens: factoryset: use correct config for soc
 specific implementation
Thread-Index: AQHaIpgjlX7lewCbsUi4aSHaRz0Wt7CQ7NyA
Date: Wed, 29 Nov 2023 07:52:42 +0000
Message-ID: <76c85ece71bed9abf977a2e9f668812785fc9464.camel@siemens.com>
References: <20231121142134.2147652-1-enrico.leto@siemens.com>
 <20231121142134.2147652-7-enrico.leto@siemens.com>
In-Reply-To: <20231121142134.2147652-7-enrico.leto@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7506:EE_
x-ms-office365-filtering-correlation-id: ecd08d03-9cc2-4693-0b31-08dbf0b02a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nPAjvUXvSKlHKd8ovMl/RkGzhj5thXV+MzZKcGbu7qBX2rpJzc8rJgycHwa08wA8P6tR8YzC+D1sM3T+JRLmsNyqhWhagHt8W4Zs9kKgFFYFxmv/dBbcHfnG3IwMDmzmvqiUvG5lghVlFp5LtB2Zb/j5LQ/oMMsloA38xqTTrghG/rBInf9UBEBpYJAX95spM2TbdmOlbKqJya26RQtbdsZfAOAtJooQd8+nnI/CBiPrdzWBJKIwKuuUGzNDEKCPImQO4pEogjpuBwu7ahM/GPR0FHGMgLoFX7KTDykWcuk+ZuQlrKfWPJpL5iAgRKGkV73hL6Nvmvi9JQiD2YO3schh6I57q28VMNSKhR418HRwh0U/EDyGCkieLFW3UwGKmR1bkF5FZ8mt0WABzlEqxEtrtCaJTCAdroUfUC2y4dxsDtvYBmIz3aZF4khZ0AnP4e4m4pOMQvRK2lc0nY71gY05qZXaTyBYfTU6LtN7i6TV4z1BYP2DDP2xZtOmQvLJIK6iHcpjk87peU2hoAlwPtEXiuzhzrwuKMYX5vYe08fLL18fXsm1acrIxk1YHyNvx7ifxQzp9fyJoPdoXgn3/MQErcQXTHiE65yQi+tK9vpqgETOAzqMctTptOo499g3lEUx0knIY/AuvdQKnQvcAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(8676002)(8936002)(71200400001)(6512007)(6506007)(6486002)(64756008)(316002)(66946007)(110136005)(6636002)(66556008)(91956017)(478600001)(76116006)(122000001)(15974865002)(38100700002)(41300700001)(36756003)(38070700009)(4001150100001)(86362001)(26005)(66476007)(2616005)(83380400001)(66446008)(2906002)(5660300002)(82960400001)(18886075002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGhJYTJzVUlpUnZ6RFJ2OGQyUGFMbEs5NkJTcy9neFNEZHh3cmh3blIrbnV4?=
 =?utf-8?B?N0FsVHFFZDVHYUUzMzZUR1hkbldXR1Q4d2FZRUthZ2cyTjVNbHFzYzZVVUVi?=
 =?utf-8?B?UGZBZ09NdEFSMmJURUpTbUU3ZmFqNTNIQm9wc3orL2ZaRGRHaFdJdXVQVGVs?=
 =?utf-8?B?NW9qb3ZLdHdLYmlEdTl0cUlpR3hNZnVUZmJGQjZlVVB1OVBZUUdwTkwzUjMy?=
 =?utf-8?B?NTZmbjVHeWxuM1hOSURGb3MyRHZWS1BWaW03bGljZEFMamFYNURPZFJIR3Bn?=
 =?utf-8?B?Wk5KMEwvUHN2N2dmQlR1TmFZMHBBS2EzUWJveWZyYitveW9Td0tlSElYNTNR?=
 =?utf-8?B?cHViNEFydllmT1FmQVRSaVNJUzB3RDJwS0pLSk4rTUswdmFHZm9wajl5QjBo?=
 =?utf-8?B?YVh6MkZjNmpoVzZ5YktVNG9leXRuRG12ako0VnVWaWxMMUUyNmlqWkNNVzBB?=
 =?utf-8?B?RFNjbWhrbHdzUkFpV2Q3ZzJ0bmVXMS9ac3VpQnBzMHF6K1VoYWp1aWlOczMv?=
 =?utf-8?B?VGI4bkZRanJZcVpmL0p4NEI1ZzY1b3JQenF1ZGduS2gvSWN0ZlhLM2tYRFNV?=
 =?utf-8?B?NGNFSWdvSlNYOUYxbDB4b1FqY1JvQmY1QVl3QXYvQUJQYzEvaHdmeTFSKzNJ?=
 =?utf-8?B?WnBsN3BMUUhZNXJRME96NTM2N01rQUY3akdVVFBMNW5aM2NxSzNRZmlpUndx?=
 =?utf-8?B?bGFNUGFOd0xHTFFUSUJzZXZYVFI4UWxoL3g4VjNzMHBhNUtnWUdFVG81NGRk?=
 =?utf-8?B?amx0SUoya0phVEFQcTVKanB5VGNvcTcwWEhwMmJZUjNLaGlidVRGcTFXMlRh?=
 =?utf-8?B?RVRzVHNkUDVhZlhNd05zbjFwSkpESGZXWHFFU2t5UmxYVFB6N2pWdUJPMlNM?=
 =?utf-8?B?aXVyMmRDYzdmTjZCa0hwZTNCaVQ0NlVhdEpZTExJMlYxaEJyZW02TWR0SW9z?=
 =?utf-8?B?czBVNE0ydkpZeGVvZm8xOU9oaisyai9ielJqdnhyQnl5SjBnVDlPMUpxZHNI?=
 =?utf-8?B?bVBnU0JndGRVMU9aRnVjNWVXeW5la3FtTkdndERvSE1xV1dIUEV0dVN3YkdW?=
 =?utf-8?B?NkhZeGxqNU9pOTdBOHJXRzRteFc2d0pod1JYNFBCWDJoeXlNaFVRVEVmR3VJ?=
 =?utf-8?B?b1VaUmI2WVJsWFA0MkFZOVEzdXpYQm9YQXkvcWxQTjNWWi80L2dYV1N4QlQx?=
 =?utf-8?B?dUFVVURscURKZUNuckROM3k3MWgrRllQY1lYVTM4KzIweURncys3K3hxWTIw?=
 =?utf-8?B?QnRmREdCMjliY3Y4aGx0NmgrVkpVV0UveUV4VGl0cENkbStYdnRPRXF1WndK?=
 =?utf-8?B?TzZMRm9tM1Z0RlhIUEt2ZDIvRXdTZGw5QVppc3NsN0JsamRvb2dBMVdORFFj?=
 =?utf-8?B?YU5kU3FpaVV3UXRCejRWVVp1dkJrUkw5SXZETHlYZjIrWWxOejNXMEtwN0pm?=
 =?utf-8?B?VkJUL3lwcjBXNnBzUktVYmgxbFR6R0lNWnZ2YWdmd2VlQ2tmdTFnT2xodFFj?=
 =?utf-8?B?UWMxUzJ6YUdMZUdyMXZqMjJ1UnFzMFpWN1RuREZsYVlkdEtYZjEvY29NSCti?=
 =?utf-8?B?QmVKSlBoVWp5N296K2lrVnV0SlcyUUxnT3cvbk1IcVJmUkpUSVhMVmJKampB?=
 =?utf-8?B?LzQ0UE9ZbFRGR0pyWXUrd3BoNit4YjJlZVpUZWdZZW5CbG5QTis4RnRqWi9y?=
 =?utf-8?B?UE1Kemt2SU5nQkRPT2Vqc0NVc0tZaDNxb0diNWljR3ErWWlZOVl6RHNOUU1K?=
 =?utf-8?B?dUNnM0JWOEpvaEp1SDFRRDBVcXR6d0haOE5yMUVucW95anhwdTlxWXdObTRa?=
 =?utf-8?B?OEdCd0F1bzFES3huaWJiQVhNUWlBSkRyOVpQVWxveGRoZjZqSkdYbUs3YzZC?=
 =?utf-8?B?ZTZJS1BFV0h0TVVqV3RYakhGeDVaV0kxK2I1YjhjdEFRZTRlYzVaVXdYejEw?=
 =?utf-8?B?Z25ZT3EwcWdQckROdmNZNHlYcGRqUlg3SlUrQ0o5eGF1elVXUDBhTXVkOWs5?=
 =?utf-8?B?Qlp6RzJNVG1wbEUyeG9ocU5tSFkwbGN3cWtHUlpKQU91cmR2bDcyNWpGeFpx?=
 =?utf-8?B?R0NLY1g5UW5MUTVMSU1EcnZNZ3V0cW80REtkdThLbjRPT1pFdWpuYWpMRDZP?=
 =?utf-8?B?N0U2bGZKMmZhWkFnUm9sREpCQTJOQi9aeW1SbnRSVzJFeDgyVzZrdTdhbFFG?=
 =?utf-8?Q?5N0IddCLyQFraJOqLtQprGU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CAE7A9F7145814FB6CBB425D98BAF36@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd08d03-9cc2-4693-0b31-08dbf0b02a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 07:52:42.1039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkJoBw8ozY4yYC0EoYOkP54Li61FsKv3p1AG5ks6r38JJNivWO/GLv4njoNGMEZmRiJwtBOvJW+3Hv+O1WKIQUJM5JzeLfkEboYqgPzk3cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7506
X-Mailman-Approved-At: Wed, 29 Nov 2023 13:51:19 +0100
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

SGkgRW5yaWNvLA0KDQpPbiBUdWUsIDIwMjMtMTEtMjEgYXQgMTU6MjEgKzAxMDAsIEVucmljbyBM
ZXRvIHdyb3RlOg0KPiBBZGRpbmcgdGhlIGNhcHJpY29ybiBib2FyZCBmYW1pbHkgc29tZSBwYXJ0
cyBkaXZlcmdlIGZyb20gZHJhY28gZmFtaWx5Lg0KPiBUaGUgc3dpdGNoZXMgdXNlZCB3ZXJlIG5v
dCBwZXJ0aW5lbnQgYW5kIG5lZWQgdG8gYmUgZW5oYW5jZWQgZm9yIGVhY2ggbmV3DQo+IGJvYXJk
IG9mIHRoZSBjYXByaWNvcm4gZmFtaWx5LiBSZXBsYWNlIHRoZW0gdGhyb3VnaCB0aGUgU09DIG5h
bWUgJ0FNMzNYWCcNCj4gYW5kICdJTVg4Jy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVucmljbyBM
ZXRvIDxlbnJpY28ubGV0b0BzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgYm9hcmQvc2llbWVucy9j
b21tb24vZmFjdG9yeXNldC5jIHwgNiArKystLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3NpZW1l
bnMvY29tbW9uL2ZhY3RvcnlzZXQuYyBiL2JvYXJkL3NpZW1lbnMvY29tbW9uL2ZhY3RvcnlzZXQu
Yw0KPiBpbmRleCA5YWRjNDJjZTBiNy4uNDkzODM0ZDg4MDYgMTAwNjQ0DQo+IC0tLSBhL2JvYXJk
L3NpZW1lbnMvY29tbW9uL2ZhY3RvcnlzZXQuYw0KPiArKysgYi9ib2FyZC9zaWVtZW5zL2NvbW1v
bi9mYWN0b3J5c2V0LmMNCj4gQEAgLTExLDcgKzExLDcgQEANCj4gwqAjaW5jbHVkZSA8Z19kbmwu
aD4NCj4gwqAjaW5jbHVkZSA8bmV0Lmg+DQo+IMKgI2luY2x1ZGUgPGFzbS9pby5oPg0KPiAtI2lm
ICFDT05GSUdfSVNfRU5BQkxFRChUQVJHRVRfR0lFREkpICYmICFDT05GSUdfSVNfRU5BQkxFRChU
QVJHRVRfREVORUIpDQo+ICsjaWYgQ09ORklHX0lTX0VOQUJMRUQoQU0zM1hYKQ0KPiDCoCNpbmNs
dWRlIDxhc20vYXJjaC9jcHUuaD4NCj4gwqAjZW5kaWYNCj4gwqAjaW5jbHVkZSAiYm9hcmQuaCIN
Cj4gQEAgLTE5Nyw3ICsxOTcsNyBAQCBpbnQgZmFjdG9yeXNldF9yZWFkX2VlcHJvbShpbnQgaTJj
X2FkZHIpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3AxICs9IDM7DQo+IMKg
wqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IC0jaWYgQ09ORklHX0lTX0VOQUJMRUQoVEFSR0VUX0dJ
RURJKSB8fCBDT05GSUdfSVNfRU5BQkxFRChUQVJHRVRfREVORUIpDQo+ICsjaWYgQ09ORklHX0lT
X0VOQUJMRUQoQ09ORklHX0lNWDgpDQoNCmRpZCB5b3UgbWVhbiBDT05GSUdfSVNfRU5BQkxFRChJ
TVg4KSBoZXJlPw0KDQo+IMKgwqDCoMKgwqDCoMKgwqAvKiBnZXQgbWFjIGFkZHJlc3MgZm9yIFdM
QU4gKi8NCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IGdldF9mYWN0b3J5X3JlY29yZF92YWwoY3As
IHNpemUsICh1Y2hhciAqKSJXTEFOMSIsICh1Y2hhciAqKSJtYWMiLA0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYnVmLCBNQVhfU1RSSU5HX0xFTkdUSCk7DQo+IEBAIC0zMDUsNyArMzA1LDcgQEAgc3RhdGlj
IGludCBmYWN0b3J5c2V0X21hY19lbnZfc2V0KHZvaWQpDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKg
wqBldGhfZW52X3NldF9lbmV0YWRkcigiZXRoYWRkciIsIG1hY19hZGRyKTsNCj4gwqANCj4gLSNp
ZiBDT05GSUdfSVNfRU5BQkxFRChUQVJHRVRfR0lFREkpIHx8IENPTkZJR19JU19FTkFCTEVEKFRB
UkdFVF9ERU5FQikNCj4gKyNpZiBDT05GSUdfSVNfRU5BQkxFRChDT05GSUdfSU1YOCkNCg0KZGl0
dG8NCg0KPiDCoMKgwqDCoMKgwqDCoMKgZXRoX2Vudl9zZXRfZW5ldGFkZHIoImV0aDFhZGRyIiwg
bWFjX2FkZHIpOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgLyogd2xhbiBtYWMgKi8NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
