Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73570C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 00:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD6BE87F4F;
	Thu, 28 Mar 2024 01:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="tB4mgg3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2017687F1C; Thu, 28 Mar 2024 01:40:10 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E618987F65
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 01:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMwdK2RuBGh32AaCufd+ioSq8Pp81zGRQgVWIomnioyXQmbljhrGb7QAaQaq/IWZemKG32+rh0q2ay/nNZJUjseDKn2liv1yZn5qk10EjgpE4qdTAvwqcxLsqvO5OaDbRNYRQwT29EzAUx8sC07gsPGkk8m06pEWtqS0/MHefdUBLHo2kfcikhSGA9DB/jemvGqL/csNU0NN/uO2FN6p/NJyB4NbZp0Ol374i0IqvTjfoNwSZjdwRrNIKhHSblHgNSR8mjFfRkrAh6oHzi4J5g6f/9NqJ78QmYmfDsgEU8+hhZRRUXi6w0vslZrWGJgh4NzXM5W7TTgG1OP54J33GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd5WyXK9DbFY8LMQU+wfL+3CC3t/AeCun4aFvvHtogA=;
 b=FpU1J8qNRq0r1Mzja5qyC84/KlsFt0CN/7HVMBGy/qdO7n7GWREBO1AaPv97x0cF9M4YG7O49yg6yMwen89HV6tFBReH0NYk0maMHmg+wHEizGR1FheJA5U3KEknua3lYWyfEXfrCEg0YPyAQDNylzjm20yt3Gi/xc8dm/ctRWzuWvTIMqOGOd+8r6oFeKSnSNQUvZ8lUzYMsWgejwiqgrG4UCUAFpUrXykqitPu8ATuJ9eFANeWGB4f6R9Jw3cEsy49bwb2WofhFK08xNRhfgMMtFUFMGEG/uT4LAYWraiYq7s84LnUGlF8uiu11yzmtQwlU7PSM/oyGsd2wdLRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd5WyXK9DbFY8LMQU+wfL+3CC3t/AeCun4aFvvHtogA=;
 b=tB4mgg3I7b+15e4F0wV/+10GFS1P44JoCT2xut1cOiPt49i2jTvf0Z45cZV1KM7HOv0BKezX1KEldsCVPp6MqoeYZcsPcRjvmc8p2OJQuiVFT6vZFdtNk7as38NFg0J5CI21DVd5xQUDpRp6h/R2VOIM5u/PN/5sZuhyfOqGV0A=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7935.eurprd04.prod.outlook.com (2603:10a6:102:b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 00:40:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 00:40:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Sumit
 Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Thread-Topic: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Thread-Index: AQHagKH8rJtU4c2iJkO96kz/KNcu/LFMSGMAgAAGgrA=
Date: Thu, 28 Mar 2024 00:40:03 +0000
Message-ID: <DU0PR04MB94172BAF7D3AEB561F2E7842883B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
 <20240328-imx93-of-v3-6-4e7f341ed7ea@nxp.com>
 <CAOMZO5CXyBTm7JnfYB60hx3oipY76RSY0U-GPaoVJO=Agwr4Vw@mail.gmail.com>
In-Reply-To: <CAOMZO5CXyBTm7JnfYB60hx3oipY76RSY0U-GPaoVJO=Agwr4Vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7935:EE_
x-ms-office365-filtering-correlation-id: 276f5dc5-a6f7-4474-588a-08dc4ebf9bc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XrieTABGONQX8NWWIBpd9IuyDLFvQTgy45lLxroL664eG2xQ+cpHJ6YxXMVSuUiKXpT9xHzenq2sA8D7MsyivLzHa7hGYBoZnI5S4bL2vGtx1WI5xhyIJYIkWexh6WHqOUN4JZHBdYKoCI04Qlct8b/Gm27uTv849MI7tHiOiKGcOYLcbxwyqE9rUc1jICY9zju6Ys6aVjnqOK1n9T2n6Ffat6z7AM+2bz2+8xoVzxhfWaCnmaGbi7YP5iZku6CIU7t86WLaN8F+81HsJd2oV0vNFpK3s+QZkvA+oFLMhyaWu75PpV/Z0TPv67vHcQj9+gmODIqrOTHIqGHMp+G/6RSMybSCgOSKhHbZ1XK4whB13E6w3R4mK1CvZa4dTYGxsrDcYRWBNwN+Jf8X/7o0wAP2zpyIbff7EXAPNlqIrcW5jAtwqMj/GfxMpDZce81asroo1BoJrqmbY5AK2vFcLco7ARetvIEjtoCFY5caE6k7M0dL1CYTlexUEmeUg7XA7KGKK5kXUPADuvRp/UMHTWEShmr+1GQintIBI9cVCJqbahrVkQm/AU1EJXoWxJtBh/Txrj625aXDGJHywPH7UpghdWQPuAMRAsB3IPvrMK7M+rE0PacAK+YTPhmOQIyMAUaHAMMrhGf/yFByBO0oqxvPP7Vimqr91aLjv7l3QBiix5B9MERwTAykNwtnI8upsvklBCjls1e6ThtzOQogNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDdoNUxUdzZHbGNUT0Q5UGVJRWlSSHRvYVZJcjRIOTVGMjdNMVI3MmR1SGor?=
 =?utf-8?B?ZlFsdGtaZTdwZHlpOExjditNckh2MnJnZnNNQm1ma3B5R2h4bElrR0xQUzVS?=
 =?utf-8?B?UmtHRFh6VTVBVnpaMDdvb2V4NkxjRWVBa25seUg1L01NQjZxNVpQYWUyemJq?=
 =?utf-8?B?MEJRYUpDTS9ZYmpscmFzMFUyY09tTzFJdnFOVmsvdFd1UjFPb2JTbmlMK3BL?=
 =?utf-8?B?U0VIcGVRTUJQVS9YL2NWanRicERtdjVtZDdxTkNKOFdSSmwrRTdndHFjUWpm?=
 =?utf-8?B?TysrZkVMQjRQU2VMaS9ENGhDS0diNUdpQlBjanJCMGFaa0lNMVI5YlZqcHFp?=
 =?utf-8?B?RjBrOElNa1lteWh3S2loZzFNMVdvMHZsOWhLZWxoWXh5aFIra3grTGNGcjNi?=
 =?utf-8?B?NFRITDdMc0dxbHVLZWVxYUN4V3NwRHlFMzQxVTA3dVlvSFpNVUg4M3pXUTVM?=
 =?utf-8?B?VGpQL3pxYk9JdDZUd0prelJQWitrd2RqR0Y3bDhTak9pR3RhZFN0a1NCcVZq?=
 =?utf-8?B?dnBJMkVuTkRrMTVyWEVPQThhSkFSakFpMk9PdjlHbFhodU8xNW1oOXhob3pN?=
 =?utf-8?B?YzU4QjdzdGU1eE50M2hLZVZ0cldIeXppcm03WEN2SGprZ21JWnJYRVlwTHpH?=
 =?utf-8?B?QUNYc2ZCVjNoK3FFTWlDMVNORXRaUXNjSGU0RlFyM3JuV0lxTFhHZ0xORUV5?=
 =?utf-8?B?cGU2TG9tS2x2c0I3UXAxemcyTjF5bjA1VUxEVXROZlFERFljdGpjbWdYVTFF?=
 =?utf-8?B?MGdMZGhqMkdjdXFMMlpKZG1SYm1ua3plNFIxSGRKWC93N0FkekN5dDJpRExv?=
 =?utf-8?B?QWJkTDAzeVMvTDh1NnRJZ1ZZSVp1Zmxkd0Y3ZmQxYTBDT3k3TDlXMzlwU2s2?=
 =?utf-8?B?L21qL2R6VDkyRUFJcHlVVkE3STIrNS90dG5kNEtUbW8rRWVXS0dybGJxakJY?=
 =?utf-8?B?N0VFR3ozdEFCS2ZZYTNmbkt4NjI4c2JlbUVxN0FXTWw0clpaT1NYb3VEVk1H?=
 =?utf-8?B?cmFDYXJrMTlvcTdXaGNOb1JCd0d3Zmo1SFBna1R1U0FZYzlES3dySEFDYWVU?=
 =?utf-8?B?Y2Y4Uk4vZS81YjI5MzV5aytFaXExS1BERFgrZFNBMHU2akNBUmFpcGFYQThP?=
 =?utf-8?B?OHM3M2x4S05oWWxLNWdYWHdJWjVJTFVPMm42Q0ZnUFN3YnhrWFNKa2tlVUgr?=
 =?utf-8?B?T3pNNGsvZHlMbGdBYmpKQVNNdkJZREduRmdYc0RYdUk4R3dsekFnb0s2ZllV?=
 =?utf-8?B?MG1tTTY3RHN6QVhScHIvcFFncjNxM0c3dEF2blYxUERXakVRcVJXN201c2px?=
 =?utf-8?B?K3BFQ25qN2duYUtxVHhMdENzeGFjYXZKREpaQUdYOVA3Q2svQitHMmFFQ0l2?=
 =?utf-8?B?SWF3VURRbHJQUkticndIRU5XdGxIRHE1S2VBNXk0NDZtcGlBNkRPaEQrKzlZ?=
 =?utf-8?B?d0prM3FTRnRwNzVDaFpob2VVTE9RUG53VndidWNKSDhWc1dvMENoYU9NWlQv?=
 =?utf-8?B?a0c3YU9ydFNpZ3d2Rkk2Q1JMQXRRVnFtRjc3Z2J1VCtVdnRGQ2hHcHp1WWkw?=
 =?utf-8?B?UU0wdGhLa3BqTkZQMW9YOUF3VzVkeEJhVDlyWEdOcVVCd0tVZjJTVUtVYXRY?=
 =?utf-8?B?d2xDU3N2cnZJQzVRVEdGR3ZLaDMyTVBJZWs5Zy8vZ3FjRkVTbHBiZWZPNE5o?=
 =?utf-8?B?VGh6SXpjWG1oNHdOb04vdk53VkpPdGRTWUtuV3cxRFJrb2RWbktPdjlVVVgr?=
 =?utf-8?B?ZU5SWEZzVmJQN1Bxd014K050N2VDREJLbzNqZGI4ME5BVGlqQkJ4QkdBc0pD?=
 =?utf-8?B?VGlhRUZuVGpGeVVjSnFsam4ycmVTckZOM0p4UUNFYldlYkVFUmdWbmxUMlh6?=
 =?utf-8?B?MjI1QTNDQ3JzWm4vc2Fwc1d5dHQ4SkNHL3ZPeHlUbHV6WThXY2lWYWt0ZmpM?=
 =?utf-8?B?OXljYW1wZmluOTBuUFMzZXBMeUNDZUNsbjBNa3FBNWNSa3NycEVyVXovRkhu?=
 =?utf-8?B?dWdObmUwS1ZacEljbzQ2cno3MFBMTmFSU2U2dGN3MWJYK25JLzBvdHZLWG1E?=
 =?utf-8?B?UnZmNFlURnl4RUEvZkVkTWxNV1VaTVRPczNSTkwvdi9La1dWK1hmcWlrOWkw?=
 =?utf-8?Q?i640=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276f5dc5-a6f7-4474-588a-08dc4ebf9bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 00:40:03.8662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOxBD8K3MoZbeAX+BK1H4UfFFktB8xxnpIQk4Dq+E8vVn7clmDhp7nMMYeO1OJYk4/e94mdMwj242fLaxFHilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7935
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDYvNl0gaW14OiBpbXg5My0xMXgxMS1ldms6IGNvbnZl
cnQgdG8NCj4gT0ZfVVBTVFJFQU0NCj4gDQo+IE9uIFdlZCwgTWFyIDI3LCAyMDI0IGF0IDg6NTPi
gK9QTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiAN
Cj4gPiArJmxwaTJjMiB7DQo+ID4gKyAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiAr
ICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAgY2xvY2stZnJlcXVlbmN5ID0g
PDQwMDAwMD47DQo+ID4gKyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic2xlZXAi
Ow0KPiA+ICsgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2xwaTJjMj47DQo+ID4gKyAgICAg
ICBwaW5jdHJsLTEgPSA8JnBpbmN0cmxfbHBpMmMyPjsNCj4gPiArICAgICAgIHN0YXR1cyA9ICJv
a2F5IjsNCj4gPiArDQo+ID4gKyAgICAgICBwbWljQDI1IHsNCj4gLi4uLg0KPiA+ICsgICAgICAg
YWRwNTU4NWdwaW86IGdwaW9AMzQgew0KPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImFkcDU1ODUiOw0KPiA+ICsgICAgICAgICAgICAgICByZWcgPSA8MHgzND47DQo+ID4gKyAgICAg
ICAgICAgICAgIGdwaW8tY29udHJvbGxlcjsNCj4gPiArICAgICAgICAgICAgICAgI2dwaW8tY2Vs
bHMgPSA8Mj47DQo+IA0KPiBQbGVhc2UgYWRkIGEgY29tbWVudCBzYXlpbmcgdGhlc2Ugbm9kZXMg
YXJlIGFscmVhZHkgYXZhaWxhYmxlIGluIDYuOS1yYzEuDQo+IA0KPiA+IC0tLSBhL2FyY2gvYXJt
L21hY2gtaW14L2lteDkvS2NvbmZpZw0KPiA+ICsrKyBiL2FyY2gvYXJtL21hY2gtaW14L2lteDkv
S2NvbmZpZw0KPiA+IEBAIC0zMSw2ICszMSw3IEBAIGNob2ljZQ0KPiA+ICBjb25maWcgVEFSR0VU
X0lNWDkzXzExWDExX0VWSw0KPiA+ICAgICAgICAgYm9vbCAiaW14OTNfMTF4MTFfZXZrIg0KPiA+
ICAgICAgICAgc2VsZWN0IElNWDkzDQo+ID4gKyAgICAgICBpbXBseSBPRl9VUFNUUkVBTQ0KPiAN
Cj4gU3VtaXQgYW5kIEkgYXNrZWQgeW91IHRvIGFkZCBPRl9VUFNUUkVBTSB0byBhbGwgaW14OTMg
Ym9hcmRzLCBub3QganVzdCB0aGlzDQo+IG9uZS4NCg0KSSBjb3VsZCBoZWxwIGNvbnZlcnQgYWxs
IGlteDkzIGJvYXJkcywgYnV0IEkgY291bGQgb25seSB0ZXN0IG54cA0KaW14OTMgYm9hcmRzLCBu
b3QgYWJsZSB0byB0ZXN0IG90aGVycy4NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+IFBsZWFzZSBk
b24ndCBpZ25vcmUgcmV2aWV3IGNvbW1lbnRzLg0K
