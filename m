Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FFEC021A4
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 07:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF02806FE;
	Fri, 14 Feb 2025 08:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="iqQyA+pa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCEF80756; Fri, 14 Feb 2025 08:18:07 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E6B80077
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 08:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy4T6Wk3c6XvUvfTScm08ATi/3yjDoKdkugumTkhCcXS4abRkUx/bzdsOd/YX1V9uRdQ/rYLT+SSm6wtarpWm7uJQclmIiwFlfT5eJ1hBzJS5RdWfAOCB0c59LpHeTJPCKwleP7olj5JnI9oP0YTFtAumf62tls41Md17NnoB48TaGGmp6bzmvR/neEPXQqc17rj45rzteXwufTy3xYObvuUfOpBNk0syDTCmWModKXToP/aNvUov2XeiaLQo7V4q0+5xsHN+PvFb40thXGqkHXfXB60JvG8z9ZoYpeQCRQxHnZbOUH1AYE4EvwsC7X43DT/y05wMUFNXSPNqDAhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA1jmUGzlpGZSyPTUvcxGpjW82SFisQkf8ZWUVgPlDg=;
 b=EZQPYGT+fq5HR8uSiipNlPrhkK5RWsP94yCOV/8ngHQVucS1gPcIyi4P/OGpIvmfIP7JoMyj+w3sgfkm4o6oWR+zqnGy2vFQ/EiI+SzajeFDfULz/YLidVm7LYVNtxEvl1FuuOwuTWGmTJwTay4DDFhEOTKfbeENcXfkkP4dEtRHHisyEDft4UVhld3p5qO/wEUb6MWdpOlTDTkykybGkmUqRkBuRetqC2Bkb9Gwej/iXED0Nm93+jewmr8sZcBlf6OMtO9UVdVx1Se7mHAVgElXFsO/Oz7oJNBdUOOoPI55Ek381Cxw4OqhjTjrl04zE1sE1zlPY6rJ+h2iYIeZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA1jmUGzlpGZSyPTUvcxGpjW82SFisQkf8ZWUVgPlDg=;
 b=iqQyA+paFTMQ40DrJj12PirKGm6BvbBepHoiuJG8qeF9xyYbCZFcq8vKnv2zCAgi1IV4M4uAgDnDK7kn8l+bXVugiUq3FQmabM5iqGT2kwImbx+2ADnLkRF5c+pe3A0zy+zsVRHLtqqYPXNcp8I+dBC4/fuM/H5GuNE1xFJi+1AFzdlZDsMK9apYYylz8b3JA1hsWS03VUGyLBKlo7cK2C/W8jxDRPi+WhcjQfuCF6Q0iUz8jkIrWSK0IC1RJeomeKIRqM8x0hv79UDYU6Lwqrzp1cy47sVl2d20s68ZsNrZXWUmDwLDpRZXzyn1fjULTlWmQI29LemG+p+TCcYHEg==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by DB8P195MB0486.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 07:18:03 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%5]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 07:18:03 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
Thread-Topic: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
Thread-Index: AQHbcjjJSp861GWIK0W4zSUZ00TyrLNAlNqAgARUtoCAAHFrgIABIb0A
Date: Fri, 14 Feb 2025 07:18:03 +0000
Message-ID: <9a0969442915d922caedeb9fa9dd7c56dc3fa1ed.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-1-a4534bc67cbb@phytec.de>
 <CAFLszThHLn4+W0J0sdz=o84wObuYf20YhKV8XbxAGmAsct-8Vg@mail.gmail.com>
 <454617aa2ec54390e0fd40ff4693ba3b559cefc4.camel@phytec.de>
 <CAFLszTgQRzJh-fDn=qqh3_p5boeraOqwCOK0ivAABZWt0w1eiA@mail.gmail.com>
In-Reply-To: <CAFLszTgQRzJh-fDn=qqh3_p5boeraOqwCOK0ivAABZWt0w1eiA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|DB8P195MB0486:EE_
x-ms-office365-filtering-correlation-id: 148b685a-8418-49ca-50c8-08dd4cc7b86a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THl1TU5ydEE2R3pzeERDVUpMUDR4N2MxcTZ6dWFOdmtXV0hSaDlveDhMZGl5?=
 =?utf-8?B?UnlBWU5GYVNjK0NJdS8vRmZqRkN3SUZXa0hXRngxMzNUb2ZOWGN4amtMWU1W?=
 =?utf-8?B?bWZ5UWxzRlFjK1hzY3IyODRLQW9sU2c5bmNYeXNScU9jdlUxVmxYZ2VBSkxC?=
 =?utf-8?B?VGNMZWlQMVYreko3QWFVaWpGdDVKY3d0YlljcFJ0YzRSSFhSVjlROFhreCtw?=
 =?utf-8?B?K1B6dUd4R2VOYitnQnUvaUFjeEJqZUxVSlZzNmNaLys2bU5UbDdrazRSZGNq?=
 =?utf-8?B?N2VnalJxNVplbGJQdGMzTThvblIwWGhDRVJqZWlLeFc4R1Raelcxc1BTR29H?=
 =?utf-8?B?eEIvY2JSMkVYWm9xWm92S2tQa3E2d2Z1dnJWRUNhVnRBZkdVbm1rem5ZSW1J?=
 =?utf-8?B?Z2FISHUzVHZ5VllyU0VYWmlTN29ZWElZWk1LaFNCRDZnVlRZcS9sbit3WVdR?=
 =?utf-8?B?N0tDaVAzREVzL0REOFJ3M1Y1b0xYckFjSUdqQW04djhhUDNubi80dDhLT0ZJ?=
 =?utf-8?B?alU1U1J0NlcwYmFraHQvVzMzNVYwWEdrVk52ZWRDcFIraHVJSkxyUTRsa1dB?=
 =?utf-8?B?MUh4YVU5K1N6NFo2WDRDOUNzNy9Yck03TUs4Vmx0N0lraHdzZWFiSHYwMVlD?=
 =?utf-8?B?RzJ5V3pCUjBla21wU0JXU3NlUHpQYWpXR3p2OGtBWnJGTjF4Q004ejhLTUNo?=
 =?utf-8?B?RmtzY29ha1lBZXMxdmpPQnZzRUdCdzU1cWlUdUptOWp2aE5UMlk5aStTZlZn?=
 =?utf-8?B?d0pXUmowcVdueTU2UlgvNllOWVFNb2FrNVkrZms2b0VjV0xFeVE5K3U3ZlUr?=
 =?utf-8?B?ZnFSWHJJNWRvUEJrVFE1dGkzZEwxZEhFazJ6NDV6d0NhLzNBLzJqbSs5eFRF?=
 =?utf-8?B?K0FGaHQ2NXpiUGl2WUpHNVJubEwwM0tJOXp1dHZQRkdKNDlSdjVXR01nelNK?=
 =?utf-8?B?M0YzcXFmYit4WWJRR0dLS3JwVmI5QkZ0aWRBMXVEV3oxM0phSGJ4ei9NczY4?=
 =?utf-8?B?UTYzaGtLV25mUHFtU2RtTUpFb2Z2OHVBbzBRSTNGd3BpOFBoOCtCUER2Snlv?=
 =?utf-8?B?cDd4MVV1T3UwNE5YYzJRNitMN1M4SVR5MEdTMzQ2dGM5UnUzUERhVHZNWWlr?=
 =?utf-8?B?SGJEc2xDWGl6MWt0OVd1RVpnTlJueTkxL05nKzEvRjZ6c1Z4QnpudHZvendN?=
 =?utf-8?B?UUZMKzF2cWtCakZYQmZBcUFsL29PeDRiK3ZJNGZJUjRjT2J4SllDSVQrNGJn?=
 =?utf-8?B?TFYzV2FLMEQ2a3pydXlnUHdkTjVLTzdHaU1weWpxMXlCUlZVWEgxdUpHRjJL?=
 =?utf-8?B?Mm9OM2FSTitmYmNEdTFtODhpUFlVdFY4UmhqVUwwOGJ3WmU4K0tjbDVGTUhR?=
 =?utf-8?B?cmdTNmhmQ1VIZkY4UXFFQ3g2ZmJYTFZBbllWRlQ0K01hRTJBSGlleXNXMkJM?=
 =?utf-8?B?UmxHSHVmSkhVN3o0T0E2TXpNWlczQ1BiQ3pFbEtXdkFMZkN0dHVaOEt3ZHJU?=
 =?utf-8?B?VndjS2ZKK2k4RGRMTmpQSERLUXVuSTd2cVVtYkVRdkVYZHhrZ2M4eGw4OWNT?=
 =?utf-8?B?dGE1bEkyZ3Y4SkF1Z0tNUGFUWlJwL2ZiVjhEU3hBSDludHNrYUFoQXZmbGg0?=
 =?utf-8?B?dDRzVVZHd2tPSVMzbytielh4SlhzQzVPRFZPVVVRNGxkazRxN0pnQVBLZFVS?=
 =?utf-8?B?YTN6M1RDYWdqNzVOczluWU9sa2Uzb0o0Q2ZwVjFJeXJYY2crTUIrTjhpSjlv?=
 =?utf-8?B?OUNZUjYrb2VIZHhCVHZGUGpnajdyNHZra1FjNEFQVmxNZSszYURoZFJ4N1hS?=
 =?utf-8?B?ckliNUVuRG1VOUZtdnVacGkzelNTWGZDekdIbmdvQTZRWW1nY3BuL2NQTkhV?=
 =?utf-8?B?RGYvSzhDanFBbEVuVml6S2U1WjgrdklXSkRmc0NsNzRPMUwxeHhBb1kxUnhS?=
 =?utf-8?Q?aMam3ed1S7ePxe45ox7iHY1OJlFqnS+W?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEIyc1dIUFJxcnZGSkk0dDBzb3BJbGlRR2RNMHNkUkhHUHoraThncDFLdjl4?=
 =?utf-8?B?T1VxV2RJZExkSkpiSGlkTTFVOXVLU0llczB6bjh6U0QrR0VzZi96L2VnckJU?=
 =?utf-8?B?d2w0WDVQT2lQWmNVSlROL24ya1FOUkluTFNRbmhhL3FlWFBpQlg1TEFQb1oz?=
 =?utf-8?B?Q2lIWDNxWkFjbXNET1FIUDJXK0s1dXNTSW1rU2VVd2MwTnJ2R2VWT1R0alV4?=
 =?utf-8?B?MkxaR3pwK2Iyb3BIL3VUbXhzSnkrN2hpSTNqYy9OMGtBTm5ibGRDYzFWV3pV?=
 =?utf-8?B?SjhtK0VQbHRqL1VlU0llOHQvZi9JeDZYZVFJMk1sZnlhU253WnB5Z2tyK3Ro?=
 =?utf-8?B?ZXZNSFFhUWpCNlZacFRocGUraHBpOVVsS1JMaDUwb2diZ1dNUjMrTmRnck5I?=
 =?utf-8?B?MDM5S3JqdHFOQ0RHdFlNTUhuNWkwNlk1UDhkUTQyY1BqaElBOHdoSnp5N2lm?=
 =?utf-8?B?UXFvZkdkQ0dzVzZiUTlVV0F0M0tRSWFHN1g1MWJlZnB2Z2k0UU5TRFd6MTk1?=
 =?utf-8?B?Vm5YYTFidS9jRTBuazhEK3pvSWtXOWliMndLN0duY2VEa3RQRWNkSUFCbEZG?=
 =?utf-8?B?Wms0SDJ6RjI4NE9ucDV5U2VmRHdGQmJaNlNIdjJ0dTdJek85c2NVcjhGU29E?=
 =?utf-8?B?Z0hlYzZXTk00WXIrb3NWSTZnWFd4TEYySXk4RWxGYmR0dWtHaTJuZU9Ka1Iw?=
 =?utf-8?B?djBVc3RRbm9Vc21zcHdRM2FvdklqZFVITjhPV1pwVlBJc2dBaGNSUUxIWHlD?=
 =?utf-8?B?MC8rUmdJRUFLSmhwL2dVQW5WZDB6MU5Ka20yZytEZWRTYXJSaFQrdVNDb1Mv?=
 =?utf-8?B?T0VGSkZkaysrdDZYUm4zNkhyaFhVNXVRdXo2WGgwWHpEdkk5Y3RJTmRGU1ht?=
 =?utf-8?B?SW9zZG9xbGVjUFk3VjZMUzZjL3FHOTNhSFZySlhoMGpQWnNMckN5aENaK0t5?=
 =?utf-8?B?UHd4amRwQWNyNHB6RmxoWUxNb2p3L2xnMXowa0xVUHowaUx5bjFyNmIycS9q?=
 =?utf-8?B?NnBGSy9kdC9ncVFVSUdDeWthNWtyL2Y1ODdGT3BQdHUwVzFVRFNvRW8yNGJm?=
 =?utf-8?B?Y0YzVCszMEI2WnJFTXhBRDUzaWZvQVZaWjU4ZUpza0R3a2ViTnBnQU14TjVN?=
 =?utf-8?B?U2l1cGJZK2w4OVI4elBaRXp1RGVVTThxdzNBWmpndFJqWUtsR0hDWCt3azgr?=
 =?utf-8?B?TlF4VGxFdjB3Q3pVTjl6UFFIVEQ2aVVMYXNYdEdzSkVBTk5PQVQyYTAwMkxs?=
 =?utf-8?B?TkZUbGNycUNTeVFJVTFCTkhXeVVSNWd2SjFIRDl4djRqdmF2WXkzQmE2WHpt?=
 =?utf-8?B?V2h0cWdjTlExdEFlOWF2QVlESFcyWTBKZTZaU3p6N2l3SWpLdlVjVWtmcGxX?=
 =?utf-8?B?TWx5dnRuU0QzcnEyc3hxNDlURjRVY2hKbXg1V0duVjl1VlI5aVpMWjNZMm5C?=
 =?utf-8?B?cG9BZlNWTVBJNjRhL055dVNtUDFjVE9Hd1VveU9sdmJMOUhwR2tIcUx3ejFx?=
 =?utf-8?B?a0xJUjllaEJqM21aS2ZiQnpHMkZLUGJvTmIwMk1vb3o4NDZUbDBPQ3VoS25Q?=
 =?utf-8?B?YjFSRW13M0kybXQwQmN0NUd1RHlVZUZLTG1iRVFDZmZISytpMk5Sb0RiUUpT?=
 =?utf-8?B?YTFGdjNSNUZCODMxTXlCWDhhVE1CU0NxYWJDNTBqY1JENGVyTlloelBPeWZi?=
 =?utf-8?B?RFFQRGxaK3lWZ1FHaUcxYWNuUTBVRy9lUGlOanFQTmJseWVOWW50RldNK2J0?=
 =?utf-8?B?MmpTSlpGYlBZa0FmcDVoZTJqb0M5WjkvL1RrbSt2RkcybjRNZmhMZENLTFVH?=
 =?utf-8?B?S0FZZ3cvOUtZbmNUeEFRZTlMTWEyTVQ1MExOZlM0TnhoVEJ0Qno5b1FLdmFC?=
 =?utf-8?B?YmhTZDRKNmNZMkJSWTJvQkdwcTY3ZkpXWVI1RE41NlA3UXhEVXVZMWNJSUlx?=
 =?utf-8?B?THF6YkZXbSszdUtSazZ3c3NpbVRuOGFvZG9pYVpiNzJic1dMdDJCV2ZzNmRE?=
 =?utf-8?B?bklvK2w5SkN0czYrTGxtVkhnYlZnT0t0MS93Q3pRVTMrclUvZnNBRmRQRDB1?=
 =?utf-8?B?UHZLMzNQeGJqQVpxakZKdzlMK2tlMTFFbGZId3UwR25MZEFBZ0xYTC8zYTNI?=
 =?utf-8?Q?zrLFeI+9mprCSUzW9/L+gxggQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32AFD898648B5441B400C1A29BFC6717@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 148b685a-8418-49ca-50c8-08dd4cc7b86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 07:18:03.2447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gnHFNaYuTwLEJJCAhzeLL9wnGo/7dyRaapN5+C4Kip+D7L040X/DFdsqJIk/C/vUy3xuxGzsrI0sHsNY/poBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0486
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

SGkgU2ltb24sDQoNCk9uIFRodSwgMjAyNS0wMi0xMyBhdCAwNzowMSAtMDcwMCwgU2ltb24gR2xh
c3Mgd3JvdGU6DQo+IEhpIFlhbm5pYywNCj4gDQo+IE9uIFRodSwgMTMgRmViIDIwMjUgYXQgMDA6
MTUsIFlhbm5pYyBNb29nIDxZLk1vb2dAcGh5dGVjLmRlPiB3cm90ZToNCj4gPiANCj4gPiBIaSBT
aW1vbiwNCj4gPiANCj4gPiBPbiBNb24sIDIwMjUtMDItMTAgYXQgMDY6MDYgLTA3MDAsIFNpbW9u
IEdsYXNzIHdyb3RlOg0KPiA+ID4gSGkgWWFubmljLA0KPiA+ID4gDQo+ID4gPiBPbiBXZWQsIDI5
IEphbiAyMDI1IGF0IDAzOjMwLCBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4gd3JvdGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgdG9wIGxldmVsIE1ha2VmaWxlIGNhbGxzIGJpbm1hbiB3
aXRoIGZha2UtZXh0LWJsb2JzLg0KPiA+ID4gPiBUaGUgdGVzdCBzZXR1cCBzaG91bGQgcmVmbGVj
dCB0aGlzIHRvIHNwb3QgcG90ZW50aWFsIGJ1Z3MgYmVmb3JlDQo+ID4gPiA+IHJlYWNoaW5nIHVz
ZXJzLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWWFubmljIE1vb2cgPHkubW9v
Z0BwaHl0ZWMuZGU+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoHRvb2xzL2Jpbm1hbi9mdGVzdC5w
eSB8IDIgKy0NCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9iaW5tYW4vZnRl
c3QucHkgYi90b29scy9iaW5tYW4vZnRlc3QucHkNCj4gPiA+ID4gaW5kZXggYTU1M2NhOWU1NjQu
LjFmMTk0ZjllY2FlIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS90b29scy9iaW5tYW4vZnRlc3QucHkN
Cj4gPiA+ID4gKysrIGIvdG9vbHMvYmlubWFuL2Z0ZXN0LnB5DQo+ID4gPiA+IEBAIC0zNzIsNyAr
MzcyLDcgQEAgY2xhc3MgVGVzdEZ1bmN0aW9uYWwodW5pdHRlc3QuVGVzdENhc2UpOg0KPiA+ID4g
PiDCoMKgwqDCoCBkZWYgX0RvVGVzdEZpbGUoc2VsZiwgZm5hbWUsIGRlYnVnPUZhbHNlLCBtYXA9
RmFsc2UsIHVwZGF0ZV9kdGI9RmFsc2UsDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZW50cnlfYXJncz1Ob25lLCBpbWFnZXM9Tm9uZSwgdXNlX3JlYWxf
ZHRiPUZhbHNlLA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHVzZV9leHBhbmRlZD1GYWxzZSwgdmVyYm9zaXR5PU5vbmUsIGFsbG93X21pc3Npbmc9RmFs
c2UsDQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxv
d19mYWtlX2Jsb2JzPUZhbHNlLCBleHRyYV9pbmRpcnM9Tm9uZSwgdGhyZWFkcz1Ob25lLA0KPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWxsb3dfZmFrZV9i
bG9icz1UcnVlLCBleHRyYV9pbmRpcnM9Tm9uZSwgdGhyZWFkcz1Ob25lLA0KPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRlc3Rfc2VjdGlvbl90aW1lb3V0
PUZhbHNlLCB1cGRhdGVfZmR0X2luX2VsZj1Ob25lLA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvcmNlX21pc3NpbmdfYmludG9vbHM9JycsIGlnbm9y
ZV9taXNzaW5nPUZhbHNlLCBvdXRwdXRfZGlyPU5vbmUpOg0KPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgICIiIlJ1biBiaW5tYW4gd2l0aCBhIGdpdmVuIHRlc3QgZmlsZQ0KPiA+ID4gPiANCj4gPiA+
ID4gLS0NCj4gPiA+ID4gMi40My4wDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJIHdvdWxkIGxp
a2UgdGhpcyBkZWZhdWx0IHRvIHN0YXkgdGhlIHNhbWUgKEZhbHNlKSBiZWNhdXNlIHRoYXQgaXMg
dGhlDQo+ID4gPiBub3JtYWwgY2FzZSBmb3IgQmlubWFuLiBXZSBzaG91bGQgZXhwYW5kIHRoZSB0
ZXN0LWNvdmVyYWdlIGFzIG5lZWRlZC4NCj4gPiANCj4gPiBDYW4geW91IGhlbHAgbWUgdW5kZXJz
dGFuZCB3aHkgd2UgZmFrZSBibG9icyBpbiB0aGUgY2FsbCB0byBiaW5tYW4gd2hlbiBidWlsZGlu
ZyBVLUJvb3Q/DQo+ID4gWW91IHNheSB0aGF0IG5vdCBmYWtpbmcgaXMgdGhlIG5vcm1hbCBjYXNl
IHNvIHdoeSBhcmUgd2UgZG9pbmcgc29tZXRoaW5nIGFibm9ybWFsIGluIHRoZSB0b3AtDQo+ID4g
bGV2ZWwNCj4gPiBNYWtlZmlsZT8NCj4gDQo+IEkgbWVhbiB0aGF0IG5vdCBmYWtpbmcgaXMgdGhl
IG5vcm1hbCBjYXNlIGZvciBCaW5tYW4ncyBjb2RlIGJhc2UuIFllcywNCj4gVS1Cb290IHJlcXVl
c3RzIGZha2luZy4NCj4gDQo+ID4gDQo+ID4gSSB0aGluayB0aGF0IHRoaXMgaW5jb25zaXN0ZW5j
eSBpcyBhIHBvdGVudGlhbCBmb3IgYnVncyBnb2luZyB1bm5vdGljZWQgc28gd2hhdGV2ZXIgd2Ug
ZGVjaWRlIHRvDQo+ID4gZG8NCj4gPiBJIHdvdWxkIHZlcnkgbXVjaCBsaWtlIHRvIGJlIGNvbnNp
c3RlbnQgd2l0aCB0ZXN0aW5nIGFuZCAibm9ybWFsIiBidWlsZHMuDQo+IA0KPiBCaW5tYW4gaXMg
dGVzdGVkIGJ5IGl0cyBvd24gdGVzdHMgd2hpY2ggaGFuZGxlIGJvdGggY2FzZXMsIHNvIHdlIGRv
bid0DQo+IGhhdmUgYSB0ZXN0IGdhcCB0aGVyZS4NCg0KU29ycnksIEkgYW0gc3RpbGwgc3R1bXBl
ZCBoZXJlLiBJIGZlZWwgbGlrZSBteSBxdWVzdGlvbiBhcyB0byB3aHkgVS1Cb290IHJlcXVlc3Rz
IGZha2luZyBoYXMgbm90DQpiZWVuIGFuc3dlcmVkIGFib3ZlLiBDYW4geW91IHBsZWFzZSBleHBs
YWluIHRoYXQgYWdhaW4/DQoNCkFuZCBJIGFtIGxlZnQgYSBiaXQgY29uZnVzZWQgc2luY2UgSSB0
aG91Z2h0IHRoZXNlIFJGQyBwYXRjaGVzIHNob3cgdGhhdCB0aGVyZSBpbmRlZWQgd2FzIGEgdGVz
dCBnYXANCihpbiBhIHNpbmdsZSB0ZXN0IGNhc2UgdGVzdEZpdEZpcm13YXJlTG9hZGFibGVzIG9u
bHksIGJ1dCBzdGlsbCkgZHVlIHRvIG5vdCBmYWtpbmcgZXh0ZXJuYWwgYmxvYnMuDQpJcyBpdCBu
b3QgcG9zc2libGUgdGhhdCB0aGVyZSBhcmUgb3RoZXIgcG90ZW50aWFsIHByb2JsZW1zIGluIHJl
Z2FyZHMgdG8gZmFraW5nIGJsb2JzIHRoYXQgd2UgaGF2ZQ0Kbm90IGRpc2NvdmVyZWQsIHlldD8N
Cg0KWWFubmljDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IFNpbW9uDQo+IA0KPiA+IA0KPiA+IFlhbm5p
Yw0KPiA+IA0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gU2ltb24NCj4gPiANCg0K
