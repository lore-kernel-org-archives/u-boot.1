Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29817E6896A
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 09:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404D8891A9;
	Thu, 31 Oct 2024 10:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m1jCV9sH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678DF889EF; Thu, 31 Oct 2024 10:57:34 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A852891A9
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNq58GYHvlENxWcsuNHp514TRYrU6DSwYnIocTaLuAS8L4DgTpC75gO11UBYPsIm09IVQ98fOsMfLbiI/8zEn1w50NrAjs55bF1klF+WU8bUb/O2nePnRz4qwd09Qj0YoJAwWxE8vwRjPDBWZmQLAdOx7UuP5xwbJ/zrW+6Vo4V3HEm3pBr70dqk38MPDKcND0FSTL6ddz3RX6oxhoSGD1HYi59ajz17pZ+2t+LKq/OIWBV3JIV0MRH+pruzZXHgnZfi61je6HwfavXPck/UVEVJitK9JIZpRVquw9qA5Ctc0DjqJQts/RMWoCoIzC0Nz5pZ4Gd4nmt4YG3DZQONxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7GVpelRX0DWE1+QkUcU4TlnCsJovxvGPI98QcnFStg=;
 b=qTAA4uM2h7MmluBPpp3TO8vFvv4UexMyUVNvO/ZZSUTNy7mKWsbxLNe3r0CKa/ugNp6KodNFOCDRFhPLfjbs5NiZmmnH/oIpeD1bp3KaM2feLABT+eXrTB+A1NCbrhvmQ2taN9r9ROypSgof261FKVUPgIVMC2cMcL19lzcZm+/GKTG/5E6m4T0g9FxtuBLofsCu0C2anIBPCTDyMBNHx6k3U2Dsb4wn1OI+nOyJG/38f30MebnNn7+fq+IW8gGd8TL2QmJNFz5UtkrvjGents0gFVmliQsAnZdxUeJKaIJKMuHoO09FFCimqYnu3mTYpuhqIlpjHSrkEEjt38WxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7GVpelRX0DWE1+QkUcU4TlnCsJovxvGPI98QcnFStg=;
 b=m1jCV9sHF20elSEvwDjcUmXGljl6s19CUmfzKi0UwIYuv3AYoUyl93hUyB7xRiNDJUQg6ZvwfsZ+FkHX+QZEOlyy/OpqSm9GMOEQXbAy1AwbHu54cM4l7WJZZCc8agfvkYhESKP32E15djM37MX+lIqxnrmEa/s9dLRByDkPH9S0mH7PgAc3oma9OR2QtwnMnli7IyYzaZEz/SUvoaZT1EzinkeEJWo4Bd2//FgEc1C4LCwy06OID8wnlnHcojTZi0mf9750la6xm3FqggNENSd0S4hnV5ntcfBU2XNPldG7SnQ272bcbTR5U2mJ69TZlRpoOhDZPCSyklbycEzh0A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 09:57:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 09:57:27 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, Marek
 Vasut <marex@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>, Alice
 Guo <alice.guo@nxp.com>
Subject: =?gb2312?B?u9i4tDogW0VYVF0gUmU6IFtQQVRDSCAwOC8xN10gc2NtaV9wcm90b2NvbHM6?=
 =?gb2312?B?IHVwZGF0ZSBzdHJ1Y3Qgc2NtaV9iYXNlX2Rpc2NvdmVyX2xpc3RfcHJvdG9j?=
 =?gb2312?Q?ols=5Fout?=
Thread-Topic: [EXT] Re: [PATCH 08/17] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Thread-Index: AQHbH5u80QD252pzuUCBq7JhEuKnELKJrT8AgBcJD3A=
Date: Thu, 31 Oct 2024 09:57:27 +0000
Message-ID: <PAXPR04MB9644CB49C0E764D7F4869C8CE2552@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-8-f640c8f3bc1b@oss.nxp.com>
 <20241016180716.GD4959@bill-the-cat>
In-Reply-To: <20241016180716.GD4959@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10872:EE_
x-ms-office365-filtering-correlation-id: e21d4f0b-499a-429b-88bd-08dcf9926d79
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?WjRUZ0NPODg4MjgyVHllMlljbG0wMXlqK2dyWEFaeTJFWXlXT3VZeGxuZUJ4?=
 =?gb2312?B?R2syNzRWR3NVMnBQZ3lpR2ZkRk5OZVdabUk1VENpMzZtK3d3dlgzVzlYZEtZ?=
 =?gb2312?B?cnY3M3YvRVVpUW9IRU9zM1BOamNXZkxMekRabjNwOE1QR0dLNlF3ME02cUxk?=
 =?gb2312?B?RHdESzNTdytjOUVDSm9jL0laY0pYWlNOYlZzSGZTUERnYW81WFdDQ1libnh6?=
 =?gb2312?B?N0lxNzNNTzhML3YraWIyQVNLdTJJMzFGVmVGTkl0ODRuNUMvWDNyRVNoZXBQ?=
 =?gb2312?B?VDl6cUtwVDNTRTBMRTd1MXlrWENUY2RoV3p5Mm9NY2hnRzg0NlVvRVBKc1hD?=
 =?gb2312?B?d2pDaFVFaW8xYVErVDVoWWo0aFVoNDJMU1ZObll0d0pURVg0dnVxRXprQysx?=
 =?gb2312?B?ai9zZXkxL0hXc3lMdlpUamdYOUVoSDhJYS90Yks1bStWUVk5SCtETHRIRDhr?=
 =?gb2312?B?Q2pQWFFBaExrM1RveTZDNEE0ZFJ6RitoZUQ5VTgwUWVmalJyN0hIM0YrOFRo?=
 =?gb2312?B?L093Qm0vZXkzb1ZjZzNMMDdtbUc5YWxDdVdnM1MzYm90aVd3eEdaUDdBaTJp?=
 =?gb2312?B?UVM0UmVoMFV6TUJrT3hVVm1ycmpEUTlXNGRIYXpTMC9NV0xWVWNJbXNrK1Q2?=
 =?gb2312?B?Mm5FZEJWMHJWT1hOaHpsVVNKTENHQ2RhalB1REl1bGtEZ2EvakYzcDNNRDNZ?=
 =?gb2312?B?bTZ2OUlhOWNSWlRzV1ZUQ0ZwR0dUQnZub0I3a3hlVi9hUHpYQ3EzQmVMWDJ2?=
 =?gb2312?B?emxjckUrU0RtQkQxUWlXdkcyL2p5N2JDZVRva0llZ29OTTZGV0VRMWZzNkFE?=
 =?gb2312?B?YWltOXZQS2NLdnpWNWlFMWV1NzJMSDh2SWxxc09DVFdLSkxyL1p3UUxEbjJz?=
 =?gb2312?B?b1JhM3BzNW90ZmQ1TFNQMWlyVkl5OFVlUHhFZ3V6R3Yrbk43WlBWVHVRSVoz?=
 =?gb2312?B?QjNQMW9ORHFMclVVSjFrWEhtVTJRUWZwY1ZiellrQitiNGJsQnhnUDBRaGZj?=
 =?gb2312?B?VEJyeUtwT0Q3UUkyUjZFTEhZOXFXanNmbXI4ODZ2SkRUZWVPa29MQkZYQlpn?=
 =?gb2312?B?ZW1vNitUVCsxNFBlODRYYlNLbHdKbzZqTTJERjUxa080cU5sMktMNzRvTk1u?=
 =?gb2312?B?UVA5cGNpUjVFU0xZZHN4YkJVWWt1bDZoWU5tanFmdWkvditnbTh0UWYzK1hB?=
 =?gb2312?B?ZUV6Y3JVVEh6RTM1YTdtV1gyUEVvM3FXVVc5VTdxVi84VHlLdTZxMFZ3QndO?=
 =?gb2312?B?cy8zdDJEMXducFBHd0V5UXJ3djcyR1NHWmYxcHRkcjVQYWxvUHF6WnhvUDRU?=
 =?gb2312?B?LzhDNk1xSFhRS1c1MEFTRmQyVGdiTUVTNEo2eS84c1VVSmh3QndZRUZZRkxq?=
 =?gb2312?B?NDkxU3RZRE5xajBDcFkxbTUxLzluZGxhUUdMSllNMFd2aDBrdkNGS25wVk5m?=
 =?gb2312?B?dzFkRTNSUk1yNEJDaUdNam1oZDlNcDRtSldjSjRaRGtIOFpmZzJGTjRTTU9Z?=
 =?gb2312?B?SEJGTkVIenVHZ21LdHBScHVnNXQwVHB0ayt0Z2sxMW9aSk81My9NK2orczR5?=
 =?gb2312?B?N1YrMHZqdnd5YUFxcFk4YlpJZ3JaT3FzcmN5RWtvN2JVY2Q5SmpmR2tPM2Z1?=
 =?gb2312?B?dFFuRzZ4WU5Rc1JMeDYxWnc1eksyTW1BZ1VEQXVXTWNEMGdLM3E4bFdTZlFl?=
 =?gb2312?B?dVZvc0FmSUE0NG9ydWMvTUJMeFJvTVJMREd4UVFOUjBLN3B3ck1OQzJTWGV2?=
 =?gb2312?B?QzVBZ1FSMHE5ZlB2WFcxSTR2RHlLSU1DUlJMOHUySlZUQys3am9neGpJVmdk?=
 =?gb2312?Q?mCF3slXpR2fPTT4/RIe7lERtdX8gs0+eDGgL8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QWN1eWdOOStjTmptenZ6NjRRV1NYdU14MHFmTlhtT1lrdHczNjlHckNGRmZL?=
 =?gb2312?B?N1FURDBGSStvM1ZFcU9HcXBjd243bUNJNFFBU0EybEtXaTlRZ3V2ejYvNEw4?=
 =?gb2312?B?R1JIeVptZmsvTUN1YUcvbnBpOFg0TWRTbWxULzZEbDJjUjBaNFNZVGlhQzJq?=
 =?gb2312?B?RnpnZkRmajB0cjBJZkRjalFNN25DUkVHMFhHcndzUEJXZVA0b0lvZGRVVjBV?=
 =?gb2312?B?RW0vSFpnU21FbDZjS1MwdGhrc2NYWmJOaXAyS0oyZjBUM2w1Q1NYbHBIZmpH?=
 =?gb2312?B?aW5JSklUZk5PbGhJVlc2Uk1zcStrZGRGcWY5MXpFeTRuWVRMWENKdjBIS1U3?=
 =?gb2312?B?WFY2bGhBZFBSdCtaM09RQkFIdWh5ZFFTOXpERGJKWmRXcU5oRUJvZGZyZ3oz?=
 =?gb2312?B?UC9XcEhTc1RDL1dRLzFUc2diSUcyNEVpT1ZSWUt4QUJ5TCsvZHpqVFdFTDZF?=
 =?gb2312?B?WWtsdkczaHl3NzR4REtUalczVk03NDFyeU9YemF1YTJ5OUpBSDg5UHRadkk5?=
 =?gb2312?B?OGlIcWE5YldRV3FvbDJaVkV4Z3pRWUZiQWE4WkdiZWVJSW5TT0NSc3prb1Ni?=
 =?gb2312?B?MkZoOE5qdEZYU0U3NU1CWnVHT1g2NnpqMjhFaW8wN3VzaVBicUNBMndKTjJy?=
 =?gb2312?B?Ym1WdEx3a0htT1UwbXJhdUhNODZ3YitjSlVsL0hsVmM5VEk3T04vL1RQNExE?=
 =?gb2312?B?SzJuQW1yTUNwS2lPT0cvMExPVXRRdW5EdVlRanpid1BnSDlNMm5OU0plUTZ3?=
 =?gb2312?B?OUlaNG12Ly9zU1dCNDR3M3VtOFFRSVNLSDJFU05HQ3BLVzBlWmQ3RXpmZDIx?=
 =?gb2312?B?TnFTV0prbnhqWURrVHQwMWhRR3Rnc29FZEhxckJxNWcyaGNhcFkzalhLZ0d2?=
 =?gb2312?B?dVRCd05EWVhXTVFGQnZaT0NCb0kwSjdiS05WMWZORjE1eGFxUWNJZDYreUli?=
 =?gb2312?B?aVF0M1RzclV3QVBTc2IwOWNCRklDeGRyblduWC9pdU5VakcyeEpNMkRubUxF?=
 =?gb2312?B?ZlllNkVKZElLMVlFSS9UYkhLSW1hLzBwTDhmd0lYQXpPUFJPc1JUN2lQZVlx?=
 =?gb2312?B?TG5Ed3RkYkpZcWNpWWJWVHRkZ0p5ZUNnaE1jejM3N0JKTGx4eFk2NTF5c0NP?=
 =?gb2312?B?Zm00cVl0ZHAzWmhFaUM4VzkvWDVqRHluRTMwcW9zWjdTMkxmV1RsbjgwYnJX?=
 =?gb2312?B?SjZ4Z0dOVzRyR2xQTjI1K29laEJUL3QvRHBTV3JRdUxFZVFHVnNqOWZaUkF4?=
 =?gb2312?B?cEtnM1huMGV2aVpVY2MvdU9DYjBXVWp0ck8yZS9XOWVaOVdjVlM4K2xMcFF1?=
 =?gb2312?B?aERzRWx0S1pvUklXZy83MnZJaUo0d1Fma1JKRUd2anFkOGVSOXJNT1Nad3Bz?=
 =?gb2312?B?WmU0NHFuSThveUk5TnJUV293dW9abXdIRGhWQVA1eXNvMWoxdmwyS2xwNzho?=
 =?gb2312?B?Rlh4WGI0K2xIT3lBV2d5Nkt6dzNhNXVMVmtQSkt4bXRFM3R4dEZ2bzdZUEpI?=
 =?gb2312?B?aHIyTi9RZEJRWkFIM0IxTE5tUm5Ba3VORmQzM2ZVNlRYUjd1ciswWWpVeCsx?=
 =?gb2312?B?eWpsaElFbXgrKzdFbitFY0RDYnpVMFRnMGdvTkMwaU5Gekl2cVZGTCsyUVk1?=
 =?gb2312?B?Y3R6R3ZqOTFONVh6SUUzenJLKzh3aElsNDBzYUVseGREQ2lEUlgvejh3T2pW?=
 =?gb2312?B?amdXSXlrdWdYcU9OcE16WGZxZDZFZVFlR2ZkVmp0MHpqSDZ2Tkp2ZHFrekxn?=
 =?gb2312?B?Mlcydmo5bWw2cmhNU1BRQThzOFNqZnkyQmhySnl5QWtaTTBtVTdCY2h2bmxs?=
 =?gb2312?B?cnJjZ0NFa1JRQW5lNXFrQ0dTdjgxR256NXhqZFBCYzNzRXl0MTVDUW5RTUdv?=
 =?gb2312?B?QWhqbXVDam4reHJmdVlHM3pBTWZza1ptdFhIMGQ3TGYvZU5JZWVGRFROdkVj?=
 =?gb2312?B?YitDVWxNMGxhMlluT282UTUxcWhZZDhiNjZIOHd1UmJ5OXBuQjJDT3ByL09X?=
 =?gb2312?B?QktIY0hZK3g0UFIzRXpnN2owMkVpRUZCRUw3M1NwNGF5RzNCS0oxRFhDVzFs?=
 =?gb2312?B?VUNnVnorSThrcytscWFuQUgzbHJRQTZocTJ1ZTJXWEJLVVVnQmZmczFmRHU5?=
 =?gb2312?Q?wdMlc0hsuOvEo2lHXj9qecJzu?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21d4f0b-499a-429b-88bd-08dcf9926d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 09:57:27.6368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwiuRjhDxAlPGbEwrl1D2ONNoCuW0rYI/bMVm81tlwwHMKA0PDuZz2T9IqlxdvAt5laOKDDltFCeaBhOAe/d7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872
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

SGkgVG9tLA0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IFRvbSBSaW5pIDx0cmlu
aUBrb25zdWxrby5jb20+DQo+ILeiy83KsbzkOiAyMDI0xOoxMNTCMTfI1SAyOjA3DQo+IMrVvP7I
yzogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+ILOty806IEx1a2Fz
eiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT47IFNlYW4gQW5kZXJzb24NCj4gPHNlYW5nYTJAZ21h
aWwuY29tPjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+OyBGYWJpbyBFc3RldmFtDQo+
IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IGRsLXVi
b290LWlteA0KPiA8dWJvb3QtaW14QG54cC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsgWWUg
TGkgPHllLmxpQG54cC5jb20+OyBBbGljZQ0KPiBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDW
98ziOiBbRVhUXSBSZTogW1BBVENIIDA4LzE3XSBzY21pX3Byb3RvY29sczogdXBkYXRlIHN0cnVj
dA0KPiBzY21pX2Jhc2VfZGlzY292ZXJfbGlzdF9wcm90b2NvbHNfb3V0DQo+IA0KPiBPbiBXZWQs
IE9jdCAxNiwgMjAyNCBhdCAwMzoxODowMVBNICswODAwLCBBbGljZSBHdW8gd3JvdGU6DQo+ID4g
RnJvbTogWWUgTGkgPHllLmxpQG54cC5jb20+DQo+ID4NCj4gPiBAcHJvdG9jb2xzIGlzIGFuIGFy
cmF5IG9mIHByb3RvY29sIGlkZW50aWZpZXJzIHRoYXQgYXJlIGltcGxlbWVudGVkLA0KPiA+IGV4
Y2x1ZGluZyB0aGUgQmFzZSBwcm90b2NvbC4gVGhlIG51bWJlciBvZiBlbGVtZW50cyBvZiBAcHJv
dG9jb2xzIGlzDQo+ID4gc3BlY2lmaWVkIGJ5IGNhbGxlZS1zaWRlLiBDdXJyZW50bHksIHNldCBp
dCB0byA0IGlzIGVub3VnaCBmb3IgaS5NWDk1Lg0KPiANCj4gVGhpcyBuZWVkcyB0byBiZSBpbiB0
aGUgZmlsZSB0b28gZm9yIGRvY3VtZW50YXRpb24gZ2VuZXJhdGlvbiB0byBwaWNrIHVwLCB0aGFu
a3MuDQoNCk1heSBJIGFzayB3aGljaCBmaWxlIHlvdSBtZW50aW9uPw0KDQpCZXN0IFJlZ2FyZHMs
DQpBbGljZSBHdW8NCg0KPiAtLQ0KPiBUb20NCg==
