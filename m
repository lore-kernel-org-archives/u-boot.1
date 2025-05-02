Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A42CC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156DF82D39;
	Fri,  2 May 2025 17:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=aicorn.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7243A82C30; Fri,  2 May 2025 17:00:27 +0200 (CEST)
Received: from FR6P281CU001.outbound.protection.outlook.com
 (mail-germanywestcentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB13828A2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 17:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=aicorn.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Moritz.Krautwald@aicorn.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnmZduPvPhCQshCMGZm7tWuvCMKga2XIlfLnr02j6mESOu33JD0lwfw+o3++/vYwS7jRTZlVBczoRJV77LdMLLWdrLZ8hRF504P337pUYf3B43uoWSJM8e3wWMMdmVD8EJ5plyjRRtJOO5JCqEVUH9onyfvFGBz2N0J+sF4NQZJ+aP/DyZz3HMdzSgy066bhYZAW0B1NInfiSCkcwCL4z2KugM4unDkmExHjAuizW1tlgmWFuVjmXgKeA/PReCbjQNkVXJtLslrDX++XWtvSf09krZqiCe8AhyOgmfTeWDdFpJD1sxAw+px2LIKqe+Yq51CPk0sPrm1zTNA0zIYD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VZSQ+9eksfteurqTnTV9DurtigPYITjxsvlpDhmgKk=;
 b=BczvFgtVbIZuA4D9cZ9Z854iqQ5WKWqnUgtNg+0cu9MoG/cikD65eZ39NGeNEeFtKi2/V6bzxCYafBbGm0nkUch4GXKlLR7ncrTVpVSyCEVQd6fXV/iw3gY62BP6hXoImIzLJM2zWgdcWXCR7LNuGm8/R74vnv6NpR6OnrHdhEO9EDjOhqC/3AUsgzTEIdV8OVDoSUxbBWirkDZSW7MYDW1CS86i100Osa6a6fXWoMxJAsMF/bg5Iqy80s+XM5Nxd0Z3WczuC4UrewpIsEL15ZlGicJCosZV1+rc1b3HUcicQT8LSIdtyxelceP+qN709gd0tSBE5ORd7a6KAdxFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aicorn.de; dmarc=pass action=none header.from=aicorn.de;
 dkim=pass header.d=aicorn.de; arc=none
Received: from BE1PPF10E049C92.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::60f)
 by FR2P281MB1430.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:89::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 15:00:22 +0000
Received: from BE1PPF10E049C92.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3d02:9402:3ab:9408]) by BE1PPF10E049C92.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3d02:9402:3ab:9408%4]) with mapi id 15.20.8699.024; Fri, 2 May 2025
 15:00:22 +0000
From: "Moritz  Krautwald" <Moritz.Krautwald@aicorn.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: raspberrypi cm4 usb not working
Thread-Topic: raspberrypi cm4 usb not working
Thread-Index: AQHbu3LtRgAD/4KFkke7LalU+nzrLA==
Date: Fri, 2 May 2025 15:00:22 +0000
Message-ID: <0ae3e9bd-cbc7-4a33-8a1c-926dca3aef3f@aicorn.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aicorn.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1PPF10E049C92:EE_|FR2P281MB1430:EE_
x-ms-office365-filtering-correlation-id: e594ebd8-11b1-4773-48ec-08dd898a0fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b013MEVzcVZLcHdvRTIxZi82NDQ2dHNFRUx4MnpSeHkzTUp2Q2dEU3Z1THoz?=
 =?utf-8?B?UjZNdHVLZElIdXR2bnZLOUZmaGlCT0xBY0VmUExETmR2NmJCSTdZRFdpZkpG?=
 =?utf-8?B?QVVleDZ1K25YN3VyNmpjS3h2VHUyenQ4WllqUTFla0o3RjFiTmdhc3puWkEx?=
 =?utf-8?B?RHZVN2EwTHBLbDdnYVNCczJuYWNUbHRYcmJwR04xYTVjWlRjSmNZTGhQMm9o?=
 =?utf-8?B?aTI4RmxiL1hkbGxVNGxBbkRqWmdnVHBmSEVNVFVTa2NxVVNySEFJTFpsamZj?=
 =?utf-8?B?STFOY2U1eVVHN2pRUFU2UE1lWGdPWXhYZjM4eFpER2JxMU8xYnVKUzR2U2Er?=
 =?utf-8?B?RjY0VHNtVGJGN3E5Yi9zNkdUK1VScG9XcFpRYklNZE0xY2ZhdW9SaFpQNVhD?=
 =?utf-8?B?QlpmbjVtZGJHU1V4bDMyUDR4dnk5UjFLK1ZLb21McjlqTVdDWmlJeUtQMnBN?=
 =?utf-8?B?ZktpKzBoU2VNUjk3bFV4a1VESWFwdGE4R2E1cVNwVThOMGtNZWdidXBwVWNY?=
 =?utf-8?B?VHREZEY5ekZDS296QUs4MWYyekR6dTc5S05WZjFOcExTMlIva2FLQkt3a1Ey?=
 =?utf-8?B?SEtOdW9CREgvcFB2WUx5R1VnbDlCNkRwRnI4YjFVQk44TXZsbnFQMjRPRGtp?=
 =?utf-8?B?RWRJRGRxMVArWmRMRTlacVdveWowakhLa0pOM0I0TENjaGlmNUN4Mk5DS1RQ?=
 =?utf-8?B?OVRYdkhnazhpYUpzLzh5V2NPMWhYeWU2Ynk1Nm9IUjhsNWJvZkhJZGsrbEUw?=
 =?utf-8?B?d01FTUsxLzJkdk9xclVPTnJuRjBoWTZXVnZNMXRuSmFVS1NpNyt6dmxSN0px?=
 =?utf-8?B?Q1d6RGVBZnFoblBCSUhOc1FrMkMyTEMvSmtKR01tYmR4Y2tUaWFLQlZLNnNW?=
 =?utf-8?B?TWpUeGo0eklZME5RZlpLeVUrNVZldnFQUSsxRkRsWHBwVi9KL25FYTUzME8x?=
 =?utf-8?B?M0RqbHAraEhDY0lxa0k5cmZ6bis5N3JxQk0vRW10ZXZBSUtNN0UyUkdqZzVH?=
 =?utf-8?B?cE1ERy9HWWVqS0dkQ2VLYXZXTytFVmxyVHRjdTBQV0ZLR3pkQmdYZVFXRjNE?=
 =?utf-8?B?OWlJTnl2T1lFWFB3RnhoZ0QzaEx2TXhXVFBBUEtMY3pEY09aYTdWVVRLL2Jh?=
 =?utf-8?B?S2tzUGRSeEVJak9hcmZudm5VdGVBSGdoc0V2Nm9UTGlQVktCYjlmVTk0WUN6?=
 =?utf-8?B?dnFpVDhQRk9LQTZpbWE3WXNlL3NhOXRzdGVDMkhqQklUbnZjVENYWG1ZN2pU?=
 =?utf-8?B?VWJMbDZ2RTJxYVpFbyt4VkNqeEEwaUlreEJEWGx6dU8zaUQweEhzNUhhcUVm?=
 =?utf-8?B?M2NPT05NWUdrN0ZCaitHdWgrcEo5eE1UK1EzdnpyRFkvYmxvYTJwRDJ0a0VR?=
 =?utf-8?B?bWtvQUprUUdnbjQ4SExqNjlYd09qTllyZGhjUTRoQzBEdm1tRmRLTGpvZ040?=
 =?utf-8?B?elR2bGpyWXRsdFpxTnJQUmFnRjJGWnFnUEVLQ3QvRUVPT2ZHR1kwNkpWSk9p?=
 =?utf-8?B?SmxQYzdqNHF1SEdBNFpEMEQrcEJPQW90anFvTUM4blZBUGtDU2RlMlc0T0Iy?=
 =?utf-8?B?TVpPaSt3VTJJWmhoVTJLcEdVZ3B5ejFXUWhhZi83cHJ0K3ZjRFYwQ3ppYkZQ?=
 =?utf-8?B?bm1tb0dBb21nYlppTGZnTzJISHdaaHlCbmpWcjFUL0kxeWpsN294NWQwSDFj?=
 =?utf-8?B?Z2xDYVladnppLzltT2xmQTdFRCs5Y3ZBVDBMUDdMWFh5UlZ1MVNKOXN3dUNR?=
 =?utf-8?B?djN6aFplN3Z5dUZCSktzSTA0YjF6bmU2MGdqMnpKL25vcktVQ01kalJSdFR2?=
 =?utf-8?B?U3BFV0lLODVrekQvbGFYZEVkdmF2cEthTXh2MUhTNXFUWEo4TkFQVTlVRGFp?=
 =?utf-8?B?c2I0OEErMFRFVmdPV2dJK2FSeWVqNlhBbU4xT1M5N1Q1bmlieFJrb21TMEhn?=
 =?utf-8?Q?pT3CtpvGji8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1PPF10E049C92.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cml5VFo1SzBVTkhSSFhjRlZTeFJDOTd1NUgyb05XcXkrM0FOVm9NREVLVWVD?=
 =?utf-8?B?WjRCUlErbGEyQW00d1ZzVHVnVVpIZ284cU9RZ2c5bFhhL20rMnA0Q1dyL3do?=
 =?utf-8?B?U3d5cFZ2MFJmRG1OQlB6THNHbHNKTS91cURqOTAydHQyZVRwL1NBZmxOQXUr?=
 =?utf-8?B?ZzRLclo2bUsvU1lvOWVoM1pvaFFGSHVVVXR0d2pUNVd6UEFtOXZyMGkwZks0?=
 =?utf-8?B?R3p1bWZ2cmRLTXRGVjhMcyt5TTZBeit2SW1KOGY3R0RLRkxqajFNWUEvMzR5?=
 =?utf-8?B?UE5NbXM0SXNrZTBLK2J4ZWdJdmxnclBWdzJoQmQyNnVsVEVLeS9LTjV4VnV1?=
 =?utf-8?B?WFlwY0xSdk5mdXI4S1VYL3c4Q3FFQkRlUmYrUGxkck54dENoK1VYcHFCeHNW?=
 =?utf-8?B?ZERCZGdTT2FtaklLZWtPZFhxcXRXQkdueXBkVzNoeXc5bE94ajg3M29zc1pB?=
 =?utf-8?B?ZmlBMUkrd0ZjNGZDM2Vyem16S1diWXpkTVR2NlZZM1JYSW9vd3VzMDF2MGxG?=
 =?utf-8?B?NzFXRU52TUVlaTh5NFo3anVqcXlsSHZPcmdQd0N0UHlQK2dIZHN5OW1aVXF4?=
 =?utf-8?B?QWtsRUxIdkNGdHZBa0VDTTNjR3pPaGpMUlVzdG4yNlVSM1hiZ2xHRkVWa0lN?=
 =?utf-8?B?K3BUajZmc3FBVkR1MUxHazJxK3RRRTFYZzNwVytHb0xFWURzZ2FXbWV1WS80?=
 =?utf-8?B?dFU2OXRnRVNCOFcyQ2Y2QW1neVh3TFFRTlJqTys0QWdrc21IN3ZCR0R5Q3g1?=
 =?utf-8?B?SUc2bzAzMGhxaVZqaHNIOWt1eE1wNHc5eHZWL0toZjAvU3QwaVVVVFZnRUF4?=
 =?utf-8?B?MUx5cGtKTWluckFzNjRxQ1FBY20rQTJSMHFkaDhKbXZxbmZqblJDQWlibGF6?=
 =?utf-8?B?T1J4VWw1elg0cktkSXdWOFFla0Nkem51L0NjY3I4YWhUNFVKcFVXZFFmZVgx?=
 =?utf-8?B?alhlV2xmcFRIbTB6VUswajNDRytzZEY0UDBXQTlSTmZKbVRsNUlIY3ZlZGh4?=
 =?utf-8?B?cW54Y0doWFpObnZGdXdFN2c2bzVNdlNlOFpVNVVIY2dLeWV5Q3pNR2xsNGpu?=
 =?utf-8?B?US80M2FmVWRMYjlrSVJWSURvVHk5Q0lZT1pQa243N0d3QVRmejBqSWo1VUUv?=
 =?utf-8?B?Zk5aY0IwZkJuK0JWdjV5V3hnelZxeW51QXlDdVVCcFZyN05PbmlacHRmejZm?=
 =?utf-8?B?WURQRTlENkRDVXJMOTczKzFWemxhT0lXdnZpSzN1SGwydDViRUtWeTd1Zjkx?=
 =?utf-8?B?TkFWSjhoQlpjd2g2bWNMenk4OEcrS1huVkliMVJoQ09kK2xNRkhwc3pkRTln?=
 =?utf-8?B?Z3RvRWpaaGRycEs3eUFEbmhiQjNQTFFZQ2NHa3VVTzlWM3JXOHhpMk4xZ2k4?=
 =?utf-8?B?aWlKVEhWeG1DUHNtdTNoNjZOeXBSeWFvM1VhclQvMjZIQ2RkYzZjdlZVby9C?=
 =?utf-8?B?UnJkUXFHeVFMUDREeG93cEx6OHBudWFOeXdZNGVUZU81anBZMVhpWlpnWnJi?=
 =?utf-8?B?eGdEdFQ1WHp1ZVRUUDluc2pVbVhPSzgyRFU2d3l3c054TkR3a0piMHZkeTNs?=
 =?utf-8?B?Wm1KLzdDNkdzVzFYaU1qUUN2S01xVWRXTE5BVS9JbGVQSlY3N0wyeVRUM3Zy?=
 =?utf-8?B?eCt5ZFUrVmZ6VzZiOVNwWlpadllnMkI0UHJrV0VRQ00vTEdPQnZsUmpoWXhi?=
 =?utf-8?B?U1J0NjFVenl6bDBiV2RTTUpOUVhFNkpvVGlUd0tBL01zZktTazk1SXZwdVZv?=
 =?utf-8?B?UWNVMG10dWVkRjNlNHZzU012ZWZCaXpqZWxHMTJTaktzdlpZdnhZbVhNSnFa?=
 =?utf-8?B?bzF2Q0dHOFV4K3hDcFF3cm4yVEZIRlg3bVZjTjN2L2wvak8rR2tXRk0yVTRp?=
 =?utf-8?B?K2xnWmZDZU0xeC81UDdCVW93MFFpQUpHekV3MFhYbkQyQllKa0dsczNTV0tq?=
 =?utf-8?B?TWlqSVUzUTlxTm5uUmlTR2hnQy91NDRiRzZFb2RvMHJmREhYTDRQT3hwZVZK?=
 =?utf-8?B?ZEJuN2JOdEtuMWQ2VncyNFo5dDFBaFVXVmFnOTFSQ2gxMzIxQU8wYVp3UlM2?=
 =?utf-8?B?OWxidlBobXpmak1MdFU2SVhPblFKaE5xZlFtUkxFZmpOVUEvb09GVEtRNFQ5?=
 =?utf-8?Q?8Tlvm9S/t82hCDh9XE60BLVi/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A80CA9342F3344BBCC3E07347875CFE@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aicorn.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1PPF10E049C92.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e594ebd8-11b1-4773-48ec-08dd898a0fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 15:00:22.0669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fded19fe-d179-458a-8c7c-bcc85f52a259
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtExo83x1pHw3QKZUh09vUz+qstI3XP0X5sVf3H0fqhEBFc6pSbqTdbEnAUQC740rZTHsnNwDmc2p/yjt/+oP9rWMc/gkxZ+u1KQFO3hDHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1430
X-Mailman-Approved-At: Fri, 02 May 2025 17:01:15 +0200
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

SSBhbSBidWlsZGluZyBhIGN1c3RvbSB5b2N0byBpbWFnZSBmb3IgdGhlIHJhc3BiZXJyeSBwaSBj
b21wdXRlIG1vZHVsZSANCjQuIEkgYW0gdXNpbmcgbWV0YS1yYXNwYmVycnkgc2NhcnRoZ2FwIGJy
YW5jaCB1c2luZyB0aGUgcmFzcGJlcnJ5cGk0IA0KbWFjaGluZSAoMzItYml0IHZlcnNpb24pLiAo
VS1Cb290IDIwMjQuMDEpDQpJbiB0aGUgL2Jvb3QvY29uZmlnLnR4dCBJIGFkZGVkOg0KIyBFbmFi
bGUgVVNCIHBlcmlwaGVyYWwgbW9kZQ0KZHRvdmVybGF5PWR3YzIsZHJfbW9kZT1wZXJpcGhlcmFs
DQp3aGljaCBzaG91bGQgYmUgdGhlIHJpZ2h0IG1vZGUgaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3Rs
eS4NCg0KT24gc3RhcnR1cCB0aGUgZm9sbG93aW5nIGlzIGxvZ2dlZDoNCg0KUENJZSBCUkNNOiBs
aW5rIHVwLCA1LjAgR2JwcyB4MSAoU1NDKQ0KUENJOiBGYWlsZWQgYXV0b2NvbmZpZyBiYXIgMTAN
CnN0YXJ0aW5nIFVTQi4uLg0KQnVzIHhoY2lfcGNpOiBkbV9wY2lfYnVzX3RvX3BoeXM6IGludmFs
aWQgcGh5c2ljYWwgYWRkcmVzcw0KeGhjaS1wY2kgaW5pdCBjYW5ub3QgbWFwIFBDSSBtZW0gYmFy
DQpwcm9iZSBmYWlsZWQsIGVycm9yIC01DQpObyB3b3JraW5nIGNvbnRyb2xsZXJzIGZvdW5kDQoN
CkkgaGF2ZSBubyBpZGVhIG9uIHdoYXQgY291bGQgYmUgdGhlIHByb2JsZW0gYW5kIGhvdyB0byBm
aXggdGhpcy4gDQpVbHRpbWF0ZWx5IEkgd2FudCB0byB1c2UgdGhlIFUtQm9vdCB1bXMgZmVhdHVy
ZSB0byBleHBvc2UgYSBibG9jayBkZXZpY2UgDQp2aWEgdGhlIHVzYiBwb3J0IHRvIGFub3RoZXIg
Y29tcHV0ZXIuIEkgaGF2ZSBzZWFyY2hlZCB0aGUgbWFpbGluZyBsaXN0IA0KYW5kIG90aGVyIHJl
c291cmNlcyBvbmxpbmUgYnV0IG9ubHkgZm91bmQgdGhlIGZvbGxvd2luZyB1bmFuc3dlcmVkIA0K
c3RhY2tvdmVyZmxvdyBwb3N0OiANCmh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vcXVlc3Rpb25z
Lzc4ODQzNTk5L3VzYi1ub3Qtd29ya2luZy1pbi11LWJvb3Qtb24tcmFzcGJlcnJ5LXBpLTRiLXdp
dGgtY3VzdG9tLXlvY3RvLWltYWdlDQoNCkFueSBoZWxwIHdvdWxkIGJlIHJlYWxseSBhcHByZWNp
YXRlZCwNCg0KU2luY2VyZWx5DQpNb3JpdHogS3JhdXR3YWxkDQotLSANCmh0dHBzOi8vd3d3LmFp
Y29ybi5kZQ0KDQrDlnN0bGljaGUgUmhlaW5icsO8Y2tlbnN0ci4gNTAgfCBCSyAxNDgsIDc2MTg3
IEthcmxzcnVoZSAoUG9zdGFuc2NocmlmdCkNCg0KYWljb3JuIEdtYkg6IEdlc2Now6RmdHNmw7xo
cmVyOiBEci4tSW5nLiBUaGlsbyBPbGl2ZXIgUmljaHRlciwgU2FtdWVsIA0KV2VueiwgQ2hyaXN0
aWFuIEdydW5kOyBTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IFNpZW1lbnNhbGxlZSA3NSwgNzYxODcg
DQpLYXJsc3J1aGUsIERldXRzY2hsYW5kOyBSZWdpc3RlcmdlcmljaHQ6IE1hbm5oZWltLCBIUkIg
NzQzMTINCg0K
