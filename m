Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03035C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 10:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2498899E;
	Fri, 14 Jun 2024 12:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="DziHWt5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F02889A1; Fri, 14 Jun 2024 12:24:16 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363368899E
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 12:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHZOEFs+k59S1G/GSiz9/CkT+rUpEkLRYceBuAXrp54N9XgqsFaMQWyOsIAASBYCSpfzocJ5x9tTI4DJ8w5EAOYfm3TblIB/Ed7zk0FEcNL0QsWRifUbfkqst6jHsZGIo5ZoNej0ZRmb3ObfMpaKZ7+oNqxLCXg2khvawIjZz53iwNJesI2SYJmeZiKiUHR3T4RFLkO5aJ9l5bzfBDHCNm95B7UrBpOEH/XmkWRsx7TQPfmRi50cP2QJE3cvH7j6a5a662RqAZzjhOfcrix4/Otvqo7TUZTi4B5PskTt+4Erm+UfIbBcCpIYQWM4GXdP3/PUQN2Yi4DpHL4ah3zARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TlP+SzLc7l5QXe6RsLUauGIwqaiSiouRkYcOCtkr8o=;
 b=f7oozxhsn4ni0E+SYQV0KLndwMYkfz3FTV78WONjRfEcyqFRfaPa4V61+KlHJkGRGcKxL9mdtQL7ZggfFSsi3Kiow0uIe9p4zKVb89bw0YzjxpV7XB2Ooit5QbTI1JoZ31X5064PVTs5ucQLUbpm6fX+f4X48IIjzOBI8HGxS3Lkh1AMDtKxdzApsr1jnRfAjEsAbNNer+tW8sGcU9MMCYpzXH2VnDJWzgtBcncFS2uFFUjyFHMIAza2xB1P7KGsI3ysHMD0gEa0/wiqaWUlQ88GYNcNRSEZc49AC0n8Ini/DRafMaI4XzT3obVGWapgmV7zK/+wzU3bEPkjazi2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TlP+SzLc7l5QXe6RsLUauGIwqaiSiouRkYcOCtkr8o=;
 b=DziHWt5xXQGJo1peEcnJzuyScv5JsdZ4iVEZX12HxWZw5k0+zeVJYt6PgmqloUWenZWzuAbOSsQC/l214n55ZHXhzybs7sdNtyq0FZ8ntGbNvx9fOvQsCcN15n3FsO6uZ6g+UEr7C33webq5oNdR7Cu+apZHnJXfsNUCSyOlbfrG6hJj6UpXZSPYHTjcwRt5R5O0uFJnP3VPNtJ44bCSQOfBTsY3lK/OHxAayJ95HJ/ZvAgPBvKsW0tx63U629PyRN7NT9dSMA+YhmwJyU33SVWD0+5DvT6wXbm3iYS0yYUmwLGPaWl1to0QOABPvCKk6P2pM69dK7aWLtnlbtNUPg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB7994.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 10:24:12 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 10:24:12 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>, "nm@ti.com"
 <nm@ti.com>, "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 00/11] usb: gadget: Introduce handle_interrupts ops to
 USB_GADGET_GENERIC uclass
Thread-Topic: [PATCH 00/11] usb: gadget: Introduce handle_interrupts ops to
 USB_GADGET_GENERIC uclass
Thread-Index: AQHavfVMAE7daKtGR0Srg3fb9j4eN7HHDhOA
Date: Fri, 14 Jun 2024 10:24:11 +0000
Message-ID: <a496bca01525cad39174aa6dfe6e1d80abc7ebea.camel@siemens.com>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB7994:EE_
x-ms-office365-filtering-correlation-id: 5ac79357-3894-420f-19e6-08dc8c5c2252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?WG1BQldjYzBjZWsvbzNlZmFGRk55Lzd0akc4NjB0T0RxdFEwM0JnVjZCeWdj?=
 =?utf-8?B?K2VrMmJwbC9DV1RNZ0JhYm9hbUNYYno1Y0UyUjE1MXpsZC84WjYzU3VHYU4x?=
 =?utf-8?B?ZEk3SHdueXlnUm5nanJqVTlxZ0xYK3BkSUxwQis1blE4dm9xeTJjL3hlV3Bn?=
 =?utf-8?B?aGhteUx3UmVNYjRPQVgvS2xNSCtyNWlZYnk1czN3RlpkdXhrdnd6Q0NPR05M?=
 =?utf-8?B?L1g4OE9kckZYTXo3TFo1Z0IzMjhhTFB0UFdyVU9xVU5UY3Z1d3dCM1laa0lS?=
 =?utf-8?B?bmtocjhxOTFYYzMvS3Q2aGdsdXlFc3ozaDZmcE9JV1Vvc2Z4ZC83dERGTm1T?=
 =?utf-8?B?UjltRnZrM2NxcEVQbXJjOVkrdzBaM0RtV1J2cHp2VTNxY0pSUDR0V2RkWFVU?=
 =?utf-8?B?QTQ1N2JadEs3S0lqV0k0N3BORDVvL3ZLTm9aMER0V1VkRjRYbUV3V21CdzBE?=
 =?utf-8?B?aE5lZWNsWlFmSzA2K1pES3NIU1BzV1hLblA1NHphZ0NGSG5Cb0dBQkFQWVJK?=
 =?utf-8?B?SDRSWk9oL2lwd1Fva2c2TldUNUxjenVMbE5ybjk0ZlRsbWlyR25Xd2J4SHVQ?=
 =?utf-8?B?K0lNb0JYMW54RXQyNmJFYktPT3JqU0puUStZMndTSzFlMXBFQ0QvUmM0Y1hD?=
 =?utf-8?B?T29ucStGbXphcEdYT3gvRHBJQjJFS1V3MXhaUkRzVktVVzhKSXk3S1dXbitu?=
 =?utf-8?B?NWRwcjBlOG9wKzlTakRwb2p2NmRNNTdPUEJEKzROVGpkb3ZWRGNnUG1XOEl6?=
 =?utf-8?B?djdKVkI0NlhvOXFrRWIwKzd1UmpYSVZiQXJvQXU4eEl1WlJ1SkpiT3ozSnE5?=
 =?utf-8?B?UXljYm1jMktteE55VFczUlZ4UWhXZit0USsrYWU3cjZZWEZGN1gxc0tTbDJu?=
 =?utf-8?B?b1VQM2Zmb1kxZFNiUlZGUGNuMEF5bmwvRE5wY2t1MzRnVlppazJSb0o3N1U3?=
 =?utf-8?B?SlE5Wnd4S285SHhmTThjUU0zekVQK0NWOG1lQ3FHYW9MOHZMVnRZbWU5MWpm?=
 =?utf-8?B?dEoxK3dFcHBMbjZsYzZieU45VDFIcE1XK21FcmZXOVpVejBTSHd5bFpXQ0Y3?=
 =?utf-8?B?a2xiNFlOOHFaUExWZmNhUmwya1ZyZk5FRWxrN1l6SzFVc2dXcDREeml1TGpY?=
 =?utf-8?B?RUpDUVQxWUVxcSt2RGZRNlF2MzNOWElTamprNGhrYWYxM0h1Q3NLTGxBRk5C?=
 =?utf-8?B?N21MUjYxS1JiY0V2RkltUnVoWFBDbXVRcG8rYlAwNzdxUUV6Umhnb05Ha1RP?=
 =?utf-8?B?T21EU3pYS3NITWhCWkxPMFUrWm9ENFNGN1RBNFhRNmhrMGZ6OEdqajhEejdm?=
 =?utf-8?B?MncrUjBQUEIySkJWaVBYS3o5RVRUZGJwQXN1d0FoTG9GLzBHdFN2ekwrVHpO?=
 =?utf-8?B?SjY5Qkw1ZnJoTlFUb1REZll6SlZIc3RoWmhTcmx2dGpsZUNHWkRUTUZHdUlD?=
 =?utf-8?B?STNkUTc5WTJNdXpsQjJIWlNGSWFxdm1mblVjWVFRU3RQZjBLNmQrWU9NQytW?=
 =?utf-8?B?TzhlRHBiTHhvTUhMdWN2MWhFNUxmYWE5Ui9kZ3Y5OUhOVExtdDRkODV0bEtx?=
 =?utf-8?B?K01sUE5TMFAvL3U5R2ZQejRvdUVwL1MrUVZPOXBpMGEwaHRzOUhoS0VHMDFq?=
 =?utf-8?B?M2RUYlhkSWVaS2FiNFlkemNPRnhtUkxGUFNsVGxQbHBneXAwZEZvT2w3MzZk?=
 =?utf-8?B?WG9lTjlZYldlbFFlM0tiK2ZxSXZ1VWsrUk15RlV5dUwvckRtK1hQMXhLUFgz?=
 =?utf-8?Q?+vlw5Z7AVCBpzukJpkl+NC+0ZohuI4ujoBqx1W0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFpWNlJOME15dERSSEMzYWlNZGhLZ1RFSWFMWW5BaGlSVUFWNDJ3cDFYMGJ3?=
 =?utf-8?B?Q1ZsQ2s5K09yNFFEK09BSFRVcGJIMXBZeGdlRjdPcG9qM3dmYm5KOG0wcldR?=
 =?utf-8?B?M0crWTlvVnpzdmd6M1l5aUNOejUxSTVRMjRuNnRFSTRzcjVSd0tjRU03N29s?=
 =?utf-8?B?QTFJa2JzcHp6NmZtOGU2ZDE3dEVsSmV3WCt0ZlptYzZOMFFoWlFlcnNCejdV?=
 =?utf-8?B?VmwyTzg5VDhSQzB2NHVZeGw1WXZsZDg1U25Rc0tyZW14RmkxdFJ0NlQwdHBu?=
 =?utf-8?B?aVlpSVRHczZielZ3Zm5jeEQzMiszcDBzbGJHQTc4ZEJzL1ZvNS84Mlp0QkFE?=
 =?utf-8?B?NTFrTmxhVExNN2drRWUwTFlyZjlCMWxzUldUSWNQRmxHaTI2SHZZUjdONkNL?=
 =?utf-8?B?M3d1T1lkcGJXV2xWWTJBaU5GL3Bnb3pYZGxtdzBEL3hZNm0zSjdnWHF2bFh5?=
 =?utf-8?B?OGZjZkkwejA5dmNqY2tFVyt5SGFxd2R4Q2xySUt3WDU2N0RSL3N6c1NBSk9W?=
 =?utf-8?B?c3VETjByVmJhdERDSGgwcUZob082VmxMcG5CamlHOUVWN2VTWVY1T3hqSjZM?=
 =?utf-8?B?c05QbzZOTi9vTWtzRCt2dzdkSVJnQ2ZBQk9aOHNDY3VPa1FOWnh4R1JBYllm?=
 =?utf-8?B?VElVZXNvZjlNTmRFbzgybUg5djQwTFhDTTdyVkM3aXplclpVNTlJa3NjM1Bk?=
 =?utf-8?B?RVdwc1E3aURDbFpidDFQbnhyaGU2WDFzeWFMKzFYZFVsTk5RTTZpT3BCL2Zm?=
 =?utf-8?B?d1JpdlVsY1lCaHRMUWsrY2FYWGVSbzg0a2NuM0M1a3Brc0VPNi9DMXc2OXRu?=
 =?utf-8?B?RTQ2UmR6TUdHQTdpaFJXQ25Ddms4cndqNm5pU0d6SzNmRk1NK2xRcHdqTU5H?=
 =?utf-8?B?UVhQbkh5N2h4QkwxSzBuQzVlK2FWY3pTdlhJTmxuRDg4ekV0dXpMSnRxcWhp?=
 =?utf-8?B?MitqVmUyZFZESUxyTm91TU5GV2FhTlF0VmVYOUsvWXI2WUpuR1Q1eDMzY0JB?=
 =?utf-8?B?dUlFVGk5OVdTT1hyaHVTV1lJQXBuTDNwYVNuaFNOVUdrRkJRcHlML25WUlho?=
 =?utf-8?B?TXA1Z0JiS3lER1BwQjRWMDhnSVM5c0xxUGdadXhzeTFsdlJkQ0RpUVNndnpx?=
 =?utf-8?B?Wnp0VXFaL0xQMXJ3bjJieENscys1QkFHN0EyL1EzZjBYS0ExTWxUb2hacWZp?=
 =?utf-8?B?UE5laUlrNjN1cXczWTdhUEgzQy9UQjgzL0E4R0Y0aUlmQ1cwUmlqdnpQTmFu?=
 =?utf-8?B?MHRERWtHUzVYMktCODFZSzQyUnlaN1B5T21EQWlVT0ttT2NrejBaYmJ0c3lj?=
 =?utf-8?B?S3FFdTZKY0tTR1hnRlNhc0wyNFlwZ2loTmlDWFRFTWx1Ui9SR3ZFWUZyRUdm?=
 =?utf-8?B?ODhqR01IaHlDQ2F1bEhqUENyV25BMFkrbWFVdzkxa0FtQ1U4YmtQRHRyRE1m?=
 =?utf-8?B?bFlUc0thM1UrcVNHb1gvVUJjYnpFYWdlR05IM0MxUUJRSXV3WHRNRlg1L3FS?=
 =?utf-8?B?aWFmbnZpaHFtMW1CaEFhT0dDRG04aE5JeDIvZTFiVHB0WGlSMUhvbDcySXlM?=
 =?utf-8?B?RC9jWjd4Wm83cytTR0UxV1d6WWNUT0JCYnhBckxYbVN2M1ZUamdXR0Q2bzJJ?=
 =?utf-8?B?cE5INU1URE5iMTAvcXFOWVJScmdIZVNQQjFrOG1BeXZnazFYcXZuTkhFa1RU?=
 =?utf-8?B?MkxEeVA2LzFmdFpyODhOclNFUXc0eGlZVWREQW12WnFmcC9ESGUvY01nTUpm?=
 =?utf-8?B?aEFPMHpocS9sN093QWNsOHFvdGo3TUhvRks1dlNWNmFSVm5ZcEkyQ0hQUVA0?=
 =?utf-8?B?Q1VOcnpOdXJsWko0WEp1SmR6UGVISkUzNkhlOU1aVUdyWW5mdWlsN2xWSlpP?=
 =?utf-8?B?MGRJdUZUUzJJZDZLeFBZcS9SZi82YS9HTW1Iem16alVlQ2Nia08zMHlBRTdz?=
 =?utf-8?B?UC9OZGM4K1NKT0lNTjlpSUc0eGhlUGFMcHRpcFd3U3ZaUElvMitxRkdFMWhV?=
 =?utf-8?B?K09GdEUreUJsWHc5ckk5TnJ0WW5tS2ZaQVJTUmJ4TG55MmJGeUJkR1lYVzdy?=
 =?utf-8?B?NkZEQWxnWWtWa0hZOVVSSitmZWZIbmtTZUI1WEhSTjJUNC84c2ZoNUpWVlRq?=
 =?utf-8?B?dFBhMStzbk9IVVlqVEpYQi96UTRERDNoQkVFNDdib3BUek5VQndPQnRmbndS?=
 =?utf-8?Q?cX55PhwQ4zhkO4j8bJBRgfU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A76A9411BABAFD4A9598AE69AB0F8116@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac79357-3894-420f-19e6-08dc8c5c2252
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 10:24:12.0032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RawoP5GKtg5NgefiVTEpoGYvl4HCX3SnVGTvjAJpEmEZlSjsJdHG5WPwbEZQp93sTqK9/Dw7/hIDf3Kpon2plPYMh+iN54J2CkxZ5Pql3lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7994
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

SGkgTWFyZWshDQoNCk9uIEZyaSwgMjAyNC0wNi0xNCBhdCAwMjo1MSArMDIwMCwgTWFyZWsgVmFz
dXQgd3JvdGU6DQo+IEludHJvZHVjZSAub3BzIGZvciBVU0JfR0FER0VUX0dFTkVSSUMgdWNsYXNz
LiBUaGUgZmlyc3QgbmV3IG9wcyBpcw0KPiAuaGFuZGxlX2ludGVycnVwdHMgd2hpY2ggbXVzdCBi
ZSBpbXBsZW1lbnRlZCBieSBETSBjYXBhYmxlIFVTQiBnYWRnZXQNCj4gY29udHJvbGxlciBkcml2
ZXJzIGFuZCBtdXN0IGltcGxlbWVudCBpbnRlcnJ1cHQgaGFuZGxpbmcgc2ltaWxhciB0bw0KPiBk
bV91c2JfZ2FkZ2V0X2hhbmRsZV9pbnRlcnJ1cHRzKCkuIEZvciBETSBVU0IgZ2FkZ2V0IGRyaXZl
cnMgdGhpcyBpcw0KPiBhIHJlcGxhY2VtZW50IGZvciBkbV91c2JfZ2FkZ2V0X2hhbmRsZV9pbnRl
cnJ1cHRzKCkuIENvbnZlcnQgdGhlIERNDQo+IFVTQiBnYWRnZXQgZHJpdmVycyB0byB0aGlzIG5l
dyBvcHMgaW5zdGVhZC4NCj4gDQo+IERFUEVORFM6IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcHJvamVjdC91Ym9vdC9saXN0Lz9zZXJpZXM9NDEwMTUwDQoNCkkndmUgYXBwbGllZCBib3Ro
IHRoZSBkZXBlbmRlbmN5IGFuZCB0aGlzIHNlcmllcyBhbmQgdGVzdGVkIG9uIEFNNjJ4LA0Kd2hp
Y2ggSSBiZWxpZXZlIHdvdWxkIGNvdmVyIHBhdGNoZXMgMSw0LDExICgzMi1iaXQgU1BMLA0KNjQt
Yml0IFNQTCArIFUtQm9vdCBwcm9wZXIsIGJvb3RlZCBvdmVyIFVTQiBERlUpOg0KDQo+IE1hcmVr
IFZhc3V0ICgxMSk6DQo+IMKgIHVzYjogZ2FkZ2V0OiBJbnRyb2R1Y2UgaGFuZGxlX2ludGVycnVw
dHMgb3BzIHRvIFVTQl9HQURHRVRfR0VORVJJQw0KPiDCoMKgwqAgdWNsYXNzDQo+IMKgIHVzYjog
Z2FkZ2V0OiBkd2MzOiBDb252ZXJ0IGludGVycnVwdCBoYW5kbGluZyB0bw0KPiDCoMKgwqAgdXNi
X2dhZGdldF9nZW5lcmljX29wcw0KPiDCoCB1c2I6IGdhZGdldDogTWFyayBkbV91c2JfZ2FkZ2V0
X2hhbmRsZV9pbnRlcnJ1cHRzIGFzIG5vbi13ZWFrIGZvcg0KPiDCoMKgwqAgRE1fVVNCX0dBREdF
VA0KDQpGb3IgdGhlc2UsDQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVy
LnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVu
cyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
