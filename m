Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F51C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 02:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA8F88041;
	Wed, 27 Mar 2024 03:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="N888E+al";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4C587F39; Wed, 27 Mar 2024 03:43:15 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0718.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13CE687E3F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 03:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l36oCAd1HVPxcjcOAGBABsglm5hB8buvbbYC6RfDuY90JZcNOrdr8tKx8qoE/hKDxDP5e/EZErM7cB7M40zC2MracdvnWrzZjDpg7QKlpVUn9I4yZxaGyV+7pJdSZvMsB5/xS5WJgUr7uPiQbGM4tecHeD7zSVueJgF1gm1Gngz+ir9WsdbEp3rYuMaDHu/dlQUIuvW3hFJnSfA/bLrewBvc//Exl/DMQESs4fU5wCNJuxcabdNDwsgnwi3mDynS39UNzffc7My+dqo76lV0jMWebR0nhGufLF6QZ7Zbt0Z9t+s/A3ZDQWOoEP4IrRUcVzhqG5kC7S2waM+xQuTepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op2JA5p9B3YKKKxdKxUFpULYaV7xRw3/IoUUMcZF+8I=;
 b=Y3t0UlqcEGlNnk9a4HTntc4l4Glx98Pl04AEhkFx2NXVhfPjnWbHBU+KbCCwxPD4HtbIohYCH9vpFvr060jFgEcUbWMSN9sOzrI1GxXWhtyUCkZr3Nqx8spSU1RGqIp+OGEdKYCVgajXwxFEW+X/zgNvGWLM1THnSwaZNZyruO7qsK6Nyl38MX4hzIeTim1Rn7/qrNkpASmreAs1QpbkucxV6ijh3sWvxImP+KZq/GAQNObWdJaVrgmDrXdBjpHk+fgU3r0u/DLxzbm8SY4SSErSv8zCRRnNsHodC5cW4Y5txUzw/ZJ9lYLSn6jK6FfKDl7el8LuL4/JegLwuOXpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op2JA5p9B3YKKKxdKxUFpULYaV7xRw3/IoUUMcZF+8I=;
 b=N888E+aleRjFiRie5fOyT7gx/BLEM19PDlLCviMtAnKWGliyptVbZMyOEavYMviNDcplY58Bui/a5zdhG6cGsgpVdmz9ztquVug+aLS5ZfLuHjSjJmbYlJqnXnYLZSQUa4x1uCdWp/6CHAR3YXgS7a9EZ53h/uyADUjZw0ZVA0I=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM0PR04MB7106.eurprd04.prod.outlook.com (2603:10a6:208:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 02:43:11 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 02:43:11 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, "sjg@chromium.org"
 <sjg@chromium.org>, "saproj@gmail.com" <saproj@gmail.com>,
 "judge.packham@gmail.com" <judge.packham@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: [PATCH v3 2/3] imx: imx93_evk: add rtc pcf2131
Thread-Topic: [EXT] Re: [PATCH v3 2/3] imx: imx93_evk: add rtc pcf2131
Thread-Index: AQHafy30InPN1r4Y8Ue2LEMvp26h+rFKl26AgABIkiA=
Date: Wed, 27 Mar 2024 02:43:11 +0000
Message-ID: <AS4PR04MB9386C7A3E94C9630964F19F8E1342@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240326033801.228419-1-joy.zou@nxp.com>
 <20240326033801.228419-3-joy.zou@nxp.com>
 <CAOMZO5AaEwu_VnmuXiT_pUiM9ftJZb3gpCSKwqVjdbKoUOb8Lw@mail.gmail.com>
In-Reply-To: <CAOMZO5AaEwu_VnmuXiT_pUiM9ftJZb3gpCSKwqVjdbKoUOb8Lw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AM0PR04MB7106:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqIA9Jkg18ycosk55bVi+fNKYrKMEEyWvGFzqiYIfZUf0Dx/S2zi924Ymh6NYCL+PebGIsYUGOeJFNwrqJeOZ83nTSegijdEEbBp2bdcTzvA2bw7smK1Ri1p8km91VqMzps2//KxGB3d1KV0xU1Jq5E8XEm2/y7eKAWwt27RS7FKApnBE8DZqD4FycctVPGMJgLEmcEtY47fBPnVZQVR9HWcPvc8xJaIsiRDjy30hZG26HkT2EclyGQE3hL1obr6Y6buAyrMr0geOG+PTKWk6a6jd6kiXvOqjXAHqNQ/6wvhasw86MwXq+D3mLj5/FB3PXkUIGpeY7BSxLmM4DjgWUDcyEpUXHyHgDP6IPwlnfQ1APIa0eGOEQ+DL/2OSJ06GXHwy5/JtRtGX0ue0aPcpMyJp20TEhKDShAW5takO4xCQyi0M9sdYBtgEzX7QzXcZm51P8JkzWmIMMKZ/GUMHyhgDeDRSAWrxZeK4MSn734pUL58oXwsD8LWqgegsM4+ZQ2qa7MLrBZGOZg0LSThIz9beft81dKpqMF/mhhcA9888RnBPwTno/HTwkf5zwieP2xG3uP/WWU2begjWNVR5wVRzvkuqsHDvrIDdCsifievSOr8Kv4xOPkmuJkkZseRzR0wAGi2ORDmZ07MWHq3SSNBRfQ8OzGiKcJ9ybO66K0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXdNWWNmUW5MYnRZdUhVZ2U0SFBweTJ2c3ZHVlRDdW92V245MmRKUWU1dDlq?=
 =?utf-8?B?Q1dBNmJNQkFRVWVRRnV2RVZmNUE3MnNSejdzQzFUcXE1MlNOVE1oNXo5L05p?=
 =?utf-8?B?V1dUWm9PWjNESVZyYmkxWnpmUkY2WjlSSzdTbTgrN0FRZkkvRmhYalVPOExH?=
 =?utf-8?B?SFZqejlsUGxBUHNzNWFqK1BhUmFyTTB2TThJV3hQMVJhQllwWENEV0hlZE4v?=
 =?utf-8?B?NWgvN0VUYk42am1hbE91dGlhOHhUY0w1NXpzZHFQUktmZU9QUmxZUmUzajYv?=
 =?utf-8?B?NlJIcjFTb0xqdkQ3RnA5OHJlQmJ4aURXZWMrUTc5TjJKbXpCdkNvQ3VsV29j?=
 =?utf-8?B?ZnY0L2pMTENBaWdVak0yNVhMZVpCK1NweEhJSldJWitMZnhHdDF2MnNTZHh5?=
 =?utf-8?B?RWVaU3JDY0RQMmlnQjcwdjIzOEkyRVZTQlJEcVlPcklyamEwWGF1eWkvQU1y?=
 =?utf-8?B?TmxjOHl2RVREVWlQYnF2S3U4Rzg0YXhwWEZhSkYyQXVSQ24rZFJtdi94dkQ0?=
 =?utf-8?B?eVRFMi9yWUJmWG9qNnN6VjE5dVUvc21HTXo0U1BWT2pxN0FmMU5CMkJac25u?=
 =?utf-8?B?SmgwTUFqRWdwanJIWFR2MFhsTUxjVnRTWVZva3I2am4wR1RyNmpMZW1uR085?=
 =?utf-8?B?STdrNWNPZU1BRXVlK2VodmFaSEdRejFVVzJCUjZVMUJoMGdvejEzVFJUVFpK?=
 =?utf-8?B?bFBJZ2ozaGN6eURaajJEV0hhb1ZjdUFKVEt6eVVRcmJVeTlRMFRPVDI4MlFs?=
 =?utf-8?B?TGRZUWp5ZWxJejVlU0RQTHNRS0RUbmZWVzVIMDdtYVhRSzVBYzVvQWM3WVBO?=
 =?utf-8?B?Y21INUt0eG1SN05IVG5wWHM1SDNWUVNLMTFLRnVjazNsMHVnSUphUWtxVU5x?=
 =?utf-8?B?cTFjd2VkWW45L3NpdWhUY2JzRWlLMW1sRWQ0YWNuZytlS1ZtZTBrWVJNVzFh?=
 =?utf-8?B?UTlkRWFoN3F5MjlaZFMwM00rNTlhWk5ZazA1cGxNNTVrMUVmenNyVDJoK05Z?=
 =?utf-8?B?clBHcFJIb0hkMHJTdEk5cCtNUUh5Wmw4SnFodGVLNGZkNzRQaVErSTNHY29V?=
 =?utf-8?B?ajlpQWFrMzFuVGlYYVluaDV4allJcWlNQ3o4aXRhZ2hyTzZHNFNQSzhvUEhQ?=
 =?utf-8?B?a3NOOGVEMkpDYllTU0ppejk4ck42Njd4bGQwOGlhaldFZy8xQ3hTRzAybUx5?=
 =?utf-8?B?eHU1NXp6Rmo5dFNIZ2dzZDdHamJTbEo2bUVqVzMxM2R1b1IydFdWVTkwaCtH?=
 =?utf-8?B?L3BnZTdkOFlXaUdidXN6TFVVNlNpejdWNTlmSjh6WmdOZDlPRlZBcnp5dFQ5?=
 =?utf-8?B?NWNlODlKZUd2THk1cml4ZlFsVnJkR2IwRnlkOVg1Yjl0aUZNanlrYWhjblh1?=
 =?utf-8?B?WHB5YTBLSjZtcDhUM3puclU4MmtwSXozODNrSEs1Y1Z1SW1yY2RuYUwzZE9i?=
 =?utf-8?B?aXhaTXR6U1c2ZHNkbjVUQU1RQ2d6bkw5SFFOamd4cERLS0NKcVZaNnZWYm9P?=
 =?utf-8?B?NnE2MGNuai84OUdGekU2WVdEZkJHMmoxb0NOUEZXbzlSWnY0NG1SMGF6eDdG?=
 =?utf-8?B?amlwcnFZNVR4UDNza0xRa2Q1ZnNpU2NibFhTMVJrTmlOVTdYcFBkUEdINGVz?=
 =?utf-8?B?am11UDVGWVp1dER2YmVHZS9HZ0ttOVArYWhIRXZ4cGpOcmtlYzBncGdJdjIx?=
 =?utf-8?B?TmFNZExBbnd0Qy82d1djYWQzT3RXVlBhK1hCbWREdWVXVEdzSEpmZjhGTjVD?=
 =?utf-8?B?SHkyT2Q1ajR0S3l4cEZzZnV5MHVrbGlsQXlNb1ZFdFBRanhGdlNOQjlDbjVs?=
 =?utf-8?B?eHZyeTNTcjFQR0JVY1hiRkNzMHk4OU9UKzZ2Sk5Xbzdqc1lkWWZuT0paSkM4?=
 =?utf-8?B?NUlPbUhBNjF1TEkzWXdTQ0F4VU9yWWxxS1ZKODBkUEhuSWZTVUpRcm02d0lj?=
 =?utf-8?B?b3RNUWVzZXI4SkJDYldFSUJwUFl5WS9lTVNBQVR0VVk2S2xodmdRaEJRdnRu?=
 =?utf-8?B?Um8vLyt0aGU5VnRsMmZJcmlxVG9GU2lvUXFIS3djcC9Ta2xSR1pMcEVKVmJx?=
 =?utf-8?B?REpISXAyVWZ1VmVWZWtOS1QxZnNIZUJUS1RERStlczFySHJZSkpGdkF6SnhM?=
 =?utf-8?Q?TmSQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf3c0c6-bb7d-4b95-95e7-08dc4e07a4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 02:43:11.7098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7RsrFoNoMyU61LOtYnJRI+/YoURTGbbQeSOPD6Y4xNdt6Kt6md3/WUhTa7iDnXN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7106
X-Mailman-Approved-At: Wed, 27 Mar 2024 03:59:16 +0100
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNOW5tDPmnIgyN+aXpSA2OjE0DQo+IFRvOiBK
b3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT47IFllIExpIDx5ZS5saUBueHAuY29tPjsgSmFja3kgQmFpDQo+IDxwaW5nLmJhaUBueHAuY29t
Pjsgc2JhYmljQGRlbnguZGU7IHNqZ0BjaHJvbWl1bS5vcmc7DQo+IHNhcHJvakBnbWFpbC5jb207
IGp1ZGdlLnBhY2toYW1AZ21haWwuY29tOyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAu
Y29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2
MyAyLzNdIGlteDogaW14OTNfZXZrOiBhZGQgcnRjIHBjZjIxMzENCj4gDQo+IENhdXRpb246IFRo
aXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBs
aW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhl
IG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiAN
Cj4gT24gVHVlLCBNYXIgMjYsIDIwMjQgYXQgMTI6MzDigK9BTSBKb3kgWm91IDxqb3kuem91QG54
cC5jb20+IHdyb3RlOg0KPiANCj4gPiArJmxwaTJjMyB7DQo+ID4gKyAgICAgICAjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCj4gPiArICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAg
Y2xvY2stZnJlcXVlbmN5ID0gPDQwMDAwMD47DQo+ID4gKyAgICAgICBwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiLCAic2xlZXAiOw0KPiA+ICsgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2xw
aTJjMz47DQo+ID4gKyAgICAgICBwaW5jdHJsLTEgPSA8JnBpbmN0cmxfbHBpMmMzPjsNCj4gPiAr
ICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiArDQo+ID4gKyAgICAgICBwY2YyMTMxOiBydGNA
NTMgew0KPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxwY2YyMTMxIjsNCj4g
PiArICAgICAgICAgICAgICAgcmVnID0gPDB4NTM+Ow0KPiA+ICsgICAgICAgICAgICAgICBpbnRl
cnJ1cHQtcGFyZW50ID0gPCZwY2FsNjUyND47DQo+ID4gKyAgICAgICAgICAgICAgIGludGVycnVw
dHMgPSA8MSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ICsgICAgICAgICAgICAgICBzdGF0dXMg
PSAib2theSI7DQo+IA0KPiBQbGVhc2Ugc3VibWl0IHRoZSBSVEMgc3VwcG9ydCB0byBMaW51eCBm
aXJzdCwgdGhlbiB5b3UgY2FuIHN5bmMgdGhlIGRldmljZXRyZWUNCj4gd2l0aCBMaW51eCBpbiBV
LUJvb3QuDQo+IA0KPiBJbiB0aGUgbWVhbnRpbWUsIHlvdSBjYW4gYWRkIHRoZSBSVEMgc3VwcG9y
dCB0byB0aGUgLXUtYm9vdC5kdHNpLg0KPiANCj4gUGxlYXNlIGNvbnNpZGVyIHVzaW5nIE9GX1VQ
U1RSRUFNIGF2YWlsYWJsZSBpbiB0aGUgVS1Cb290IG5leHQgYnJhbmNoLg0KDQpXaWxsIHN1Ym1p
dCB0aGUgUlRDIHN1cHBvcnQgcGF0Y2ggdG8gTGludXggZmlyc3RseS4NClRoYW5rcyBmb3IgeW91
ciBjb21tZW50cyENCkJSDQpKb3kgWm91DQo=
