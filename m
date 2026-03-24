Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA76E9A77F
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 12:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFA480517;
	Tue, 24 Mar 2026 13:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Lpp9IA2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9424A807C0; Tue, 24 Mar 2026 13:47:26 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600B680087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 13:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytNfrtHXUGoBs2g9dGF7gYUC5PXKsG00IBw3pXFjeh4BfwhOpPY+8E7NfpM1/5Rd6Qx1Azto//ysrbbPHjgnjnu85XQN8uJEJqB6DiIikSAq0SlNLX7iaPSq/RBSywSUlDN8V2nwauGlUjDfiRMqE8OZj9Yhk9RzfF67Lqqzjts1BR6DOerIbq83n1NnsTqvxOlrPmCzhshS2hACD6yexq5swZJPNUmL83vHRWpy/bpqVMWrLBlCmMmRSslcJqouCjaES7YigasptSC+jkR+LigzEBOUlQyQagkvHUqx1XP07CpqjiSWmuSpDaxx3D+yZHKK/UAlQNPom0dfPhTttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyutlKr9casL7ZSX2vshNsNohMzVz5rC73hRwXAfM64=;
 b=eRxjL2aKoEBnxidNfEeGmbNt+74gbmjXFgwYhWzsZA+OOrSshUX7e3Vpzk6agBkKxOT1XOmt1lTpuAdg0SgbD6BRucyk0IwgTCB5BePQyzHMovhqJ6QI1bA4tPmDAzDVVAodsvlydPHxC2jLD/Y+QrsMMDvjJmbaKH+sMO8Xin9U5fv+7hizVHDww/uRXn26MFqQCshH4oqgGh3SlVZLYPzESXymIU5T2NuBxc55dhXlmdLh3OEu1R2cNSL2yB66zFG1sjQ4ilwhOhmn3rEr9LffkB67x12rfWusTHZp1uWD439G/65iD0bbYfqfnBndtvdQg5dx28AAdwROHKpobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyutlKr9casL7ZSX2vshNsNohMzVz5rC73hRwXAfM64=;
 b=Lpp9IA2FsHjEmFIHHvO+aMbCP8gLyGO7kjlOipXnCD4Nl8Gdj6/fiAHstd3TfDUYIMfwSLZcdocU09vTu/asUXoUg1mM1kpXZXnOwNjqv3XPpJXa/UyXhuW7znElv5XDFwWG8EjgTyb+T//3aVRMuVW/fZ/+9LV+L/EECPVVGsnT8zS/SL5JDo0RQkZWFr5wmn5JtsAxQ1tDr9JgM1cxubJsopnfYqekOs4pxLUOsIrlanc+IvEThfbRkSJ5pPTOK0wSez425Vqoqfes8EZKCUzretArVEH0up/d8MWzaTGeMmCAbD85Rvgq2WytnUTP8Do0LizVAeYl/xsYS8WH5Q==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PAXP195MB1584.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:281::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:47:22 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:47:21 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Tom Rini
 <trini@konsulko.com>
CC: Teresa Remmet <T.Remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leonard Anderweit
 <L.Anderweit@phytec.de>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Manoj Sai
 <abbaraju.manojsai@amarulasolutions.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Topic: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Index: AQHcu26x+JUwzb+5ckSskRa5eks9sLW9odcA
Date: Tue, 24 Mar 2026 12:47:21 +0000
Message-ID: <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
In-Reply-To: <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PAXP195MB1584:EE_
x-ms-office365-filtering-correlation-id: 40fc06d8-5efd-4ebb-374a-08de89a37d8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: eWEkdSY9lTCkJE4WdDw2fLethk0Kv0t6OyOf+oBn9viWu59IgH2NinZT4bYn6f8i52qZq/8p8m130LZ1PUv/Cm7V5m2oAKcVqHi/1Nr/QqYRrHorDLe5qKMTYqEAaoT0Rc9YSN4aAL1h01KUN5eYscYggn/rNVWSLk7NqXQgtbtJsuhe/K0+az79OMCofn0EKhKMkxhH9TZvQ1cUT2WE52h3TcjmoG/D3rCAG8s4J5EXXP8tB60phMQkHP/+V2nMNe73SrgeFgx60X8KFHuxw/av7dfocteJC7g33Tf80ZkCIGa70CGZsZkulzbqVEUAxB5ezqLTPG1ZbgLMI4MlZMLlmPWlq85LrJ3bCsHPLUHUFFzlllL0wPuqc1p0+KKTs797i+xcY89LtHYJm1X6xjrP85d1Q3QNxe6ly1qGFN1wKBeqlUmBDvBKZ/1o1zm5lKH/P9+w5Ta7EPpfOHe8GdJZAUd1AQfZCxp1wv0LI6569ueCOSnFjsgW0zdfovDtQkxvnOSSLO9zQ5/lHesK/rvKS/ip3Q7gNQ0MntHk2bzmRlm7o4VMz3P27Ht0b/27Epg2HRErGWz76E3yiNgbUxpYKeLrUaLYIIGAuaXKw9qe5VdvX+/lH1213X6ULDIVlHoZMgBTaRaVq5fz4VvQrF+fylW0ZCGM+Zwv7qq8B5rCMS704JlcNhH564B2bEBt3NqjTHvy6i3hr7P+iOYq9PQL6wYJkccdjJ6skmcuQZqEGxlbf9ueGSTT28BiZRATnvSlozLqEWolQFqsS02eBa7Mr2I09J9Xl8Eu+U/C3O8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzByQ2FLbGRaRlIxd3JEcHV3WjNqZHRZY3dlM0lwODhwREhtT0YrWStRdlRJ?=
 =?utf-8?B?ZHVhS3hxc3VxSDFjKzdUclVJZlE2TFlWdHBWcHJ0b3RBV21lb0w3eXJXMXFP?=
 =?utf-8?B?RHBaM3cwQlJIckZXSmNJSURiYTZCcUR1NUNpdFQwZ29WQVlFQjJicmpXUDIr?=
 =?utf-8?B?WW9vcjhaajBELzJPeDQwWTFUclR6Wi90WldyRGxoNHRWV1ZmNWZDZVJscnlF?=
 =?utf-8?B?Z3ZicE43Y2JtVHJGSzBvMGNNQURJT1hoKytzcEluVktQdVpNUjZvQjM3YmVB?=
 =?utf-8?B?dERXenNWVXVQdXBXbEhMOXFPYUdpbTduRkJvYjJlbDlJQ0VUMUExb2Y1L1l3?=
 =?utf-8?B?U0Z6eE9BLzhlR1hodEFBNmlMWGl0b0N0RiszL1F4ZllSNHJzdDVXMGx3enN1?=
 =?utf-8?B?Zk0xMlUvMWFhVDdTWjh5dlhySGFxVGdLMmtBeXJ5T05NUnF1LytDT1JnRzZ5?=
 =?utf-8?B?VEtjeEVYNk5OeitieExDYmNnTjVsQVhkY3U3b3paSEdseFJhdkx0Zi81Q1Jv?=
 =?utf-8?B?Mm5NVHM2cGh6aWZpeDhBRWFPM1pWQ3lKandDOE1iSWQxUWpvd3l4aXlEY3VT?=
 =?utf-8?B?SStMNEt5eWdlUDlWOHpGVHVoN0dhd25pU3BqTDdOUGYxaXB2TnhFQzYvMW0v?=
 =?utf-8?B?cW5KT1ZvYXVRaFd5K251Z3Bab2NhWHdJWkIvSkNaVWFkd0RrSDZvSzRVV3JE?=
 =?utf-8?B?MHRaUnp1NzBpanJzd2dlK3B0MW9QWEZKeGtjMmtQSFpabWQ0SGQyOXNNMGdm?=
 =?utf-8?B?Sy9aa0Z6QnNqYWpaem1RU1NSQmNxcy9QeUNFT2ppS2NaVHZTSG1PdWluMFVY?=
 =?utf-8?B?alVKYWMzbC9XYzRScFZwN2NnUDBxbHA4Q2RBenhGcXVhMEYyYks4eXI0TVZY?=
 =?utf-8?B?aDB1RWJrT09lcXAxSlpCVHFnV0pjc08wQnd1QW1MY3dUUWRVMUV0VlU1a1BU?=
 =?utf-8?B?VkZuQ0d0bTJvVGl1YUdDdS9rc2dHV3FpQS95UXFLaFRVZTc3bDk3MkNJV1NO?=
 =?utf-8?B?SURyNTJDUWk1dElJeHBnNlBYcTc1UkRVT3hYNHpNMzFsVnhSNVlrUzBCbGVI?=
 =?utf-8?B?RUJBQjBsR0ppbHlXK0d3SUs4ZjZiZTdRcWxJbmI0SEVCb0tsU3RqR3huZFls?=
 =?utf-8?B?U1hLeFZIYnBWVlpVWU13VGlrTFVCeVlrZXEwblF3ZkhiUThNZjltdG43bHNH?=
 =?utf-8?B?d3ZXTUJHSjFQaDlqWmhZbXh2UUpwRmZaN3dob0JBYituNWM1K0ZvSnJPL0xV?=
 =?utf-8?B?ejNQUWx3YnptVHM4SHZrSXora2Q5Vk9XRE4wbitZQndRQUV1NCs1M0dLTHF3?=
 =?utf-8?B?a09xN3UydHV5ci9iWWZKZHlKdTMzVHVrei9RSlEyZW9uSDBjR3ZiMk9TUzlr?=
 =?utf-8?B?TGtMZ2F3ZkwwY21KS2d1WEFVWG5EMkhQaGJIZ1ZNR09jTXlSSzBuTXVGaDFV?=
 =?utf-8?B?MHFlb0tqTE5GTGdSQTRyVXdBR1krSjRCdUFtenAyRmhYYjY5ZUMzNjVpSVQx?=
 =?utf-8?B?T28vL0lKRExER0dJRFFST3JxOElpS2hybkl5THNtQnJTa0ZMeGoxK3I0RWxI?=
 =?utf-8?B?RW9xSFF1Tmh0ejNkSm9hV3RsZE90dUsyL2txN0dsVXBROXZxREtabXltajBW?=
 =?utf-8?B?Vk03VnlYa2grcHZXdUlwWFMvK2tkZWRkWWpYNHI1Y2lUQnowaEpHRmcyLy82?=
 =?utf-8?B?QUtpeUcrYzU0UTByVkFzdnpydjN6eEx2bEhPWmdKOXQ4SGl3ckVhRURMOFhp?=
 =?utf-8?B?R1FWeFU3VFBxQlBBUURJZ2lxRXR6dzFZYU4reStTVUd6eHQ3aXBXL01MZjJR?=
 =?utf-8?B?Yk9Gci81UHkrczl2cXpVQnFwaUFyNEc5dnpmd3NNeThoS01STE5oM09qREs4?=
 =?utf-8?B?M2xhcUdqb3VJL3VzM2RrNC9qbmlYNEx3c2lDMlp5ODRaSVI3QklQRjVCc1dm?=
 =?utf-8?B?U1h6dm53clFwczNhSHdrR3ZEMmdxYjZic1RhMGpjbVlXalRkNVNpUmdUMDRP?=
 =?utf-8?B?MUVIeEx4bWhiUlFMU282eWNzUldIbEphNysyMW1ZVloyTHBnYnE2Y3lOYmlW?=
 =?utf-8?B?dVU3YXhQb0Rtb2N5SkpreVg5MmJrNkxQUFlxc1Q2aUx0OFdZclFlVjVldUlD?=
 =?utf-8?B?UVV6MzhYVHNkaE5KTEExQ21acnB5ZzBSWjU5Y2pSUUFGMDlLZkpGL2RNZk80?=
 =?utf-8?B?c3luUHhWdDhjaitoaGdLQmxlSS9GVzFlVFFDU1NVeE5YWHZuNDZSVEJTaEpF?=
 =?utf-8?B?K0pSQTlyM1NpVkpGbGxrT0RJdWVGK1lXWGN2VE5xRmNpL2prVTRmTWw3cnhm?=
 =?utf-8?Q?Kaj3TZctKL1HbklBW/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <120F57912A80F94AA1E2FDC98F80688D@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc06d8-5efd-4ebb-374a-08de89a37d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 12:47:21.1969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CY5WYntvD7iVr2kUdA6Y/SIoJMgLAd/HX5u7QC0U9zelEcRk/jcnvIqKLisiNKERuPdZYXlvf5QN2P/zLeSnyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1584
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

SGkgUGVuZywKCk9uIFR1ZSwgMjAyNi0wMy0yNCBhdCAxODozMCArMDgwMCwgUGVuZyBGYW4gKE9T
Uykgd3JvdGU6Cj4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Cj4gCj4gQ29udmVy
dCB0aGUgYm9hcmQgdG8gdXNlIERNX1BNSUMgaW5zdGVhZCBvZiB0aGUgbGVnYWN5IFNQTCBJMkMv
UE1JQwo+IGhhbmRsaW5nLgo+IAo+IENoYW5nZXMgaW5jbHVkZToKPiAtIEVuYWJsZSBETV9QTUlD
LCBETV9QTUlDX1BDQTk0NTAsIGFuZCBTUExfRE1fUE1JQ19QQ0E5NDUwIGluIGRlZmNvbmZpZy4K
PiAtIERyb3AgbGVnYWN5IFNQTCBJMkMgYW5kIFBNSUMgb3B0aW9ucy4KPiAtIFJlbW92ZSBtYW51
YWwgSTJDMSBwYWQgc2V0dXAgYW5kIGxlZ2FjeSBwb3dlcl9wY2E5NDUwX2luaXQoKSB1c2FnZS4K
PiAtIFVzZSBETS1iYXNlZCBwbWljX2dldCgpIHdpdGggdGhlIERUIG5vZGUgInBtaWNAMjUiLgo+
IC0gVXBkYXRlIFBNSUMgcmVnaXN0ZXIgcHJvZ3JhbW1pbmcgdG8gdXNlIHN0cnVjdCB1ZGV2aWNl
IEFQSS4KCnRoZXNlIGNoYW5nZXMgYnJlYWsgc29tZXRoaW5nLgoKR2V0dGluZwoKTG9hZGluZyBF
bnZpcm9ubWVudCBmcm9tIE1NQy4uLiBDYXJkIGRpZCBub3QgcmVzcG9uZCB0byB2b2x0YWdlIHNl
bGVjdCEgOiAtMTEwCioqKiBXYXJuaW5nIC0gTm8gYmxvY2sgZGV2aWNlLCB1c2luZyBkZWZhdWx0
IGVudmlyb25tZW50CgphbmQgU0QgY2FyZCBpcyBub3QgYWNjZXNzaWJsZSBhcyBhIHJlc3VsdC4g
SSBhbHNvIHdvcmtlZCBvbiB0aGlzIG1vZGVybml6YXRpb24gYW5kIGdvdCB0aGUgc2FtZQpyZXN1
bHQgYXMgd2l0aCB5b3VyIGNvbW1pdC4gSGF2ZSBub3QgaGFkIHRpbWUgdG8gaW52ZXN0aWdhdGUg
dGhlIGNhdXNlLCB5ZXQuCgpZYW5uaWMKCj4gCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+Cj4gLS0tCj4gwqAuLi4vYXJtL2R0cy9pbXg4bXAtcGh5Ym9hcmQtcG9s
bHV4LXJkay11LWJvb3QuZHRzaSB8IDE2ICsrKysrKystCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29y
ZV9pbXg4bXAvc3BsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNDMgKysr
KysrKy0tLS0tLS0tLS0tLS0tLQo+IMKgY29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWfC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKy0tLQo+IMKgMyBmaWxl
cyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vZHRzL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLXUtYm9vdC5kdHNp
IGIvYXJjaC9hcm0vZHRzL2lteDhtcC1waHlib2FyZC0KPiBwb2xsdXgtcmRrLXUtYm9vdC5kdHNp
Cj4gaW5kZXggNDgwNGEyMDRlOTIuLjg3MWU3ZmQ2NzRkIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJt
L2R0cy9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay11LWJvb3QuZHRzaQo+ICsrKyBiL2FyY2gv
YXJtL2R0cy9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay11LWJvb3QuZHRzaQo+IEBAIC0zNCw2
ICszNCwxOCBAQAo+IMKgCX07Cj4gwqB9Owo+IMKgCj4gKyZwaW5jdHJsX2kyYzEgewo+ICsJYm9v
dHBoLWFsbDsKPiArfTsKPiArCj4gKyZwaW5jdHJsX3BtaWMgewo+ICsJYm9vdHBoLWFsbDsKPiAr
fTsKPiArCj4gKyZ7L3NvY0AwL2J1c0AzMDgwMDAwMC9pMmNAMzBhMjAwMDAvcG1pY0AyNS9yZWd1
bGF0b3JzfSB7Cj4gKwlib290cGgtYWxsOwo+ICt9Owo+ICsKPiDCoCZyZWdfdXNkaGMyX3ZtbWMg
ewo+IMKgCWJvb3RwaC1wcmUtcmFtOwo+IMKgfTsKPiBAQCAtODMsMTEgKzk1LDExIEBACj4gwqB9
Owo+IMKgCj4gwqAmaTJjMSB7Cj4gLQlib290cGgtcHJlLXJhbTsKPiArCWJvb3RwaC1hbGw7Cj4g
wqB9Owo+IMKgCj4gwqAmcG1pYyB7Cj4gLQlib290cGgtcHJlLXJhbTsKPiArCWJvb3RwaC1hbGw7
Cj4gwqB9Owo+IMKgCj4gwqAmdXNiX2R3YzNfMCB7Cj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRl
Yy9waHljb3JlX2lteDhtcC9zcGwuYyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9zcGwu
Ywo+IGluZGV4IGZjN2FlZmQwMDczLi5mYzZmNTEwNDkyNSAxMDA2NDQKPiAtLS0gYS9ib2FyZC9w
aHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMKPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9p
bXg4bXAvc3BsLmMKPiBAQCAtMTE3LDQ1ICsxMTcsMzIgQEAgb3V0Ogo+IMKgCWRkcl9pbml0KCZk
cmFtX3RpbWluZyk7Cj4gwqB9Cj4gwqAKPiAtI2RlZmluZSBJMkNfUEFEX0NUUkwgKFBBRF9DVExf
RFNFNiB8IFBBRF9DVExfSFlTIHwgUEFEX0NUTF9QVUUgfCBQQURfQ1RMX1BFKQo+IC0jZGVmaW5l
IFBDIE1VWF9QQURfQ1RSTChJMkNfUEFEX0NUUkwpCj4gLXN0cnVjdCBpMmNfcGFkc19pbmZvIGky
Y19wYWRfaW5mbzEgPSB7Cj4gLQkuc2NsID0gewo+IC0JCS5pMmNfbW9kZSA9IE1YOE1QX1BBRF9J
MkMxX1NDTF9fSTJDMV9TQ0wgfCBQQywKPiAtCQkuZ3Bpb19tb2RlID0gTVg4TVBfUEFEX0kyQzFf
U0NMX19HUElPNV9JTzE0IHwgUEMsCj4gLQkJLmdwID0gSU1YX0dQSU9fTlIoNSwgMTQpLAo+IC0J
fSwKPiAtCS5zZGEgPSB7Cj4gLQkJLmkyY19tb2RlID0gTVg4TVBfUEFEX0kyQzFfU0RBX19JMkMx
X1NEQSB8IFBDLAo+IC0JCS5ncGlvX21vZGUgPSBNWDhNUF9QQURfSTJDMV9TREFfX0dQSU81X0lP
MTUgfCBQQywKPiAtCQkuZ3AgPSBJTVhfR1BJT19OUig1LCAxNSksCj4gLQl9LAo+IC19Owo+IC0K
PiDCoGludCBwb3dlcl9pbml0X2JvYXJkKHZvaWQpCj4gwqB7Cj4gLQlzdHJ1Y3QgcG1pYyAqcDsK
PiArCXN0cnVjdCB1ZGV2aWNlICpkZXY7Cj4gwqAJaW50IHJldDsKPiDCoAo+IC0JcmV0ID0gcG93
ZXJfcGNhOTQ1MF9pbml0KDAsIDB4MjUpOwo+IC0JaWYgKHJldCkKPiAtCQlwcmludGYoInBvd2Vy
IGluaXQgZmFpbGVkIik7Cj4gLQlwID0gcG1pY19nZXQoIlBDQTk0NTAiKTsKPiAtCXBtaWNfcHJv
YmUocCk7Cj4gKwlyZXQgPSBwbWljX2dldCgicG1pY0AyNSIsICZkZXYpOwo+ICsJaWYgKHJldCA9
PSAtRU5PREVWKSB7Cj4gKwkJcHV0cygiTm8gcG1pY0AyNVxuIik7Cj4gKwkJcmV0dXJuIDA7Cj4g
Kwl9Cj4gKwlpZiAocmV0IDwgMCkKPiArCQlyZXR1cm4gcmV0Owo+IMKgCj4gwqAJLyogQlVDS3hP
VVRfRFZTMC8xIGNvbnRyb2wgQlVDSzEyMyBvdXRwdXQgKi8KPiAtCXBtaWNfcmVnX3dyaXRlKHAs
IFBDQTk0NTBfQlVDSzEyM19EVlMsIDB4MjkpOwo+ICsJcG1pY19yZWdfd3JpdGUoZGV2LCBQQ0E5
NDUwX0JVQ0sxMjNfRFZTLCAweDI5KTsKPiDCoAo+IMKgCS8qIEluY3JlYXNlIFZERF9TT0MgYW5k
IFZERF9BUk0gdG8gT0Qgdm9sdGFnZSAwLjk1ViAqLwo+IC0JcG1pY19yZWdfd3JpdGUocCwgUENB
OTQ1MF9CVUNLMU9VVF9EVlMwLCAweDFDKTsKPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBDQTk0NTBf
QlVDSzJPVVRfRFZTMCwgMHgxQyk7Cj4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVD
SzFPVVRfRFZTMCwgMHgxQyk7Cj4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVDSzJP
VVRfRFZTMCwgMHgxQyk7Cj4gwqAKPiDCoAkvKiBTZXQgQlVDSzEgRFZTMSB0byBzdXNwZW5kIGNv
bnRyb2xsZWQgdGhyb3VnaCBQTUlDX1NUQllfUkVRICovCj4gLQlwbWljX3JlZ193cml0ZShwLCBQ
Q0E5NDUwX0JVQ0sxT1VUX0RWUzEsIDB4MTQpOwo+IC0JcG1pY19yZWdfd3JpdGUocCwgUENBOTQ1
MF9CVUNLMUNUUkwsIDB4NTkpOwo+ICsJcG1pY19yZWdfd3JpdGUoZGV2LCBQQ0E5NDUwX0JVQ0sx
T1VUX0RWUzEsIDB4MTQpOwo+ICsJcG1pY19yZWdfd3JpdGUoZGV2LCBQQ0E5NDUwX0JVQ0sxQ1RS
TCwgMHg1OSk7Cj4gwqAKPiDCoAkvKiBTZXQgV0RPR19CX0NGRyB0byBjb2xkIHJlc2V0ICovCj4g
LQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX1JFU0VUX0NUUkwsIDB4QTEpOwo+ICsJcG1pY19y
ZWdfd3JpdGUoZGV2LCBQQ0E5NDUwX1JFU0VUX0NUUkwsIDB4QTEpOwo+IMKgCj4gwqAJcmV0dXJu
IDA7Cj4gwqB9Cj4gQEAgLTE5Myw4ICsxODAsNiBAQCB2b2lkIGJvYXJkX2luaXRfZih1bG9uZyBk
dW1teSkKPiDCoAo+IMKgCWVuYWJsZV90emMzODAoKTsKPiDCoAo+IC0Jc2V0dXBfaTJjKDAsIENP
TkZJR19TWVNfSTJDX1NQRUVELCAweDdmLCAmaTJjX3BhZF9pbmZvMSk7Cj4gLQo+IMKgCXBvd2Vy
X2luaXRfYm9hcmQoKTsKPiDCoAo+IMKgCS8qIEREUiBpbml0aWFsaXphdGlvbiAqLwo+IGRpZmYg
LS1naXQgYS9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZyBiL2NvbmZpZ3MvcGh5Y29y
ZS1pbXg4bXBfZGVmY29uZmlnCj4gaW5kZXggMmZjZjdkYjllNWMuLjUxZDk3MzdhZmIzIDEwMDY0
NAo+IC0tLSBhL2NvbmZpZ3MvcGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnCj4gKysrIGIvY29uZmln
cy9waHljb3JlLWlteDhtcF9kZWZjb25maWcKPiBAQCAtMTAsNyArMTAsNiBAQCBDT05GSUdfU0Zf
REVGQVVMVF9TUEVFRD04MDAwMDAwMAo+IMKgQ09ORklHX0VOVl9TSVpFPTB4MTAwMDAKPiDCoENP
TkZJR19FTlZfT0ZGU0VUPTB4M0MwMDAwCj4gwqBDT05GSUdfRU5WX1NFQ1RfU0laRT0weDEwMDAw
Cj4gLUNPTkZJR19TWVNfSTJDX01YQ19JMkMxPXkKPiDCoENPTkZJR19ETV9HUElPPXkKPiDCoENP
TkZJR19ERUZBVUxUX0RFVklDRV9UUkVFPSJmcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1
eC1yZGsiCj4gwqBDT05GSUdfSU1YOE1fT1BURUVfTE9BRF9BRERSPTB4N2UwMDAwMDAKPiBAQCAt
MTEzLDggKzExMiw2IEBAIENPTkZJR19GQVNUQk9PVF9NTUNfVVNFUl9TVVBQT1JUPXkKPiDCoENP
TkZJR19GQVNUQk9PVF9NTUNfVVNFUl9OQU1FPSJtbWMyIgo+IMKgQ09ORklHX01YQ19HUElPPXkK
PiDCoENPTkZJR19ETV9JMkM9eQo+IC0jIENPTkZJR19TUExfRE1fSTJDIGlzIG5vdCBzZXQKPiAt
Q09ORklHX1NQTF9TWVNfSTJDX0xFR0FDWT15Cj4gwqBDT05GSUdfSTJDX0VFUFJPTT15Cj4gwqBD
T05GSUdfU1lTX0kyQ19FRVBST01fQUREUj0weDUxCj4gwqBDT05GSUdfU1VQUE9SVF9FTU1DX0JP
T1Q9eQo+IEBAIC0xNDQsMTUgKzE0MSwxNiBAQCBDT05GSUdfUEhZX0lNWDhNUV9VU0I9eQo+IMKg
Q09ORklHX1BJTkNUUkw9eQo+IMKgQ09ORklHX1NQTF9QSU5DVFJMPXkKPiDCoENPTkZJR19QSU5D
VFJMX0lNWDhNPXkKPiAtQ09ORklHX1NQTF9QT1dFUl9MRUdBQ1k9eQo+IMKgQ09ORklHX1BPV0VS
X0RPTUFJTj15Cj4gwqBDT05GSUdfSU1YOE1fUE9XRVJfRE9NQUlOPXkKPiDCoENPTkZJR19JTVg4
TVBfSFNJT01JWF9CTEtDVFJMPXkKPiAtQ09ORklHX1BPV0VSX1BDQTk0NTA9eQo+ICtDT05GSUdf
RE1fUE1JQz15Cj4gK0NPTkZJR19ETV9QTUlDX1BDQTk0NTA9eQo+ICtDT05GSUdfU1BMX0RNX1BN
SUNfUENBOTQ1MD15Cj4gwqBDT05GSUdfRE1fUkVHVUxBVE9SPXkKPiArQ09ORklHX0RNX1JFR1VM
QVRPUl9QQ0E5NDUwPXkKPiDCoENPTkZJR19ETV9SRUdVTEFUT1JfRklYRUQ9eQo+IMKgQ09ORklH
X0RNX1JFR1VMQVRPUl9HUElPPXkKPiAtQ09ORklHX1NQTF9QT1dFUl9JMkM9eQo+IMKgQ09ORklH
X0RNX1JORz15Cj4gwqBDT05GSUdfRE1fU0VSSUFMPXkKPiDCoENPTkZJR19NWENfVUFSVD15Cg==
