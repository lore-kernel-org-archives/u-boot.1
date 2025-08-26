Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71842CA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 08:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA6482FC7;
	Tue, 26 Aug 2025 10:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CPkUXqZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 565E183071; Tue, 26 Aug 2025 10:09:00 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17190828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 10:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/mPBG+RLZOBQmqZrf8XrdLV/Y+zk/SxN1PZgOn3NNdeJa4/kfD9MyQ/Hr2SwQoexvM2djQRF0hHRB3owIsPQSeeN4Rwq5aypuVbEtygekh5SfSnTdNR76988npznFTtajwUTdZhAHTs+2ZsfeVEsZomCs4VvG74/B5tXvwneYwvNXbv2GKLZX7wzj8T+++2tZg5PSsCswn8skf1e/Wu94Spksj6qUKFzivF4D8ZLvKmZm7t6BTYaqhd/aJMdgo9KoOWhbMgBcvNKKXqKMt7yRprbkAF/9+jyxREgtbGdOG6pO1qpo57PsS4JRolXoQj89I7Iks1CEziziSiUBeKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TCYW9BIQxCyGfIHzNIn2h1FJ8Mb0MjXdYwb9AF4n10=;
 b=gPT9GOf87p/iH87cNhPtOu9ELs627bdG2SG+NAeYYqfNjaK+XqtD+PB+HdC7wKA4mbg/HAdPtHsbWZzdHkD+adQnb7ljjbaligaTEq6anzNOMst4n/glka97ctYjY8R4N99L9tMhioy/3YbFkU7MpQ1O48l/YFlifUl+6y/FU6f8iAyC0mWi5cnalyMN2cRbt0YngjeeYTe/IKHJVQfsH6g5RpvheAZiccDyNv1Qm6TEWw8k8A0ryWW6P1wxt4fpTp/ginTIHdvKbfzJNrB/0gxBxAf9Hd5J8s5ZrmkBalZAjp15qDrq7CcuqjDkZAm+dH2aVgGzHpzTHxK6TsdxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TCYW9BIQxCyGfIHzNIn2h1FJ8Mb0MjXdYwb9AF4n10=;
 b=CPkUXqZ4BmscRTWfHyIycqHui+xxFu8esYtYNlX9f2B3+8tyt6cpBNX2pgaRzeM4+XMccyNngaPPulAV5s29exfKmP9W85o+4VE7mCZAwFyY7q7tsrMNJvIuTPSr/e76O1JZ3aOwHVZ8xdVHpTO85CqL1ROMGJ8rz/S7TFwhyrzHzQ0NkeE0NnM9WPQNuqfhn5KL2F61rJ9pOjZctlY19DM3qNn9HUfDqE7XDW8aIcJkoEhCsY0X6+YsmVW8AQ/5egNAUJMOOQXSIGOcvGLytP3oi89sJhAn3BHMF3fUOvx/Ei1GyoIGaAntUWrEp1Yu3VXQMr2ZzPTN0BGqzs17gg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB5232.namprd03.prod.outlook.com (2603:10b6:208:1e5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Tue, 26 Aug
 2025 08:08:55 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 08:08:54 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Michal Simek <michal.simek@amd.com>, "Ng,
 Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
 exceed 512MB
Thread-Topic: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
 exceed 512MB
Thread-Index: AQHcEaSTwiJDwYP8OkCqo7/tKLpHMLRzJYMggACQVwCAAOdIUA==
Date: Tue, 26 Aug 2025 08:08:54 +0000
Message-ID: <LV8PR03MB81377895D8D77ADF59F98864A739A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
 <20250820073201.8649-4-nareshkumar.ravulapalli@altera.com>
 <LV8PR03MB81370A93399D0C1E3D814F13A73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
 <e1e44ddb-4569-4d8f-a1e1-67e14c359ccf@altera.com>
In-Reply-To: <e1e44ddb-4569-4d8f-a1e1-67e14c359ccf@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|MN2PR03MB5232:EE_
x-ms-office365-filtering-correlation-id: 66dc488b-dba3-4079-e447-08dde477cd01
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?K1pYd0VuS1ZwUFBwRTBjNlZvekJBYjl3VlRjRlJHL1p4ZURkZHRSLythWEJ1?=
 =?utf-8?B?elM2OHN4ZEg1UnM4WmtoRmcvWHhkSStDU1BZYkZOdm5RRHgyZXNJS1BYR2lw?=
 =?utf-8?B?MGNRUjcxR1BiaWFZYk5EdWEzV0t1b0lkb0hOdlpuUG9YeXkyRUtwOGZpSGgw?=
 =?utf-8?B?WENuZEtUVmxzejQ3V0N5amMzS093Q0VKaDIvOWoyTDdMY2NEK25mbVo3WVpv?=
 =?utf-8?B?WUFUaExTOUR3MmVyeXRhR3lKR3RndTVNbWF0eW5WblpISTYrWEZtSUxWKzFT?=
 =?utf-8?B?cWR6QmIvNGFDdEhheXAwQTdkZDZlVVVkVnNSMWFKMXpZbElNU0tyZ2h1dWhl?=
 =?utf-8?B?QU9RWHp3Ri9ZblJHcjQrYndVR2JVYm5zSnJMMmE0OThHR0RwY2dGQXhHU0VB?=
 =?utf-8?B?TS9Mc1o3Q25FMTQ5RXRBd2dDbVMyMDNsdVhkM0E3eUtTVmxqTlFXWlVaMU1B?=
 =?utf-8?B?Q1RkcjNkd1JHZlBiNjBkU1BiN0tCTkt2T3BTMjBKejBVMldwdjdTWTREVjVC?=
 =?utf-8?B?RU11ZmpBbTIzVUZrRlNzamNIN0taQnlvekN0NVF3Y0hNOGpJTWorUWlCY0tv?=
 =?utf-8?B?TTRZNzk0UEZPbTM3L0xUSW9PMW1ZekFxbmR1eFVrSzFUcnZHQ2U5bDdmUjJE?=
 =?utf-8?B?MHhGU2xrelM5TlpqM0JtMXNKSldCL0NiUWVScmVlZ3htYXVVaGtraUN2U1o4?=
 =?utf-8?B?anZta0JQQ0lkUmlxUUREQ1Y1blhTTkVYL0IrczhWajd5UTNzdEdSbjUwRmdW?=
 =?utf-8?B?dDNwNzZJTTNaVWkzOFdSTnhNSHV5SEhqK3NTSXdwSWhWZW9reXN0RWltdTZB?=
 =?utf-8?B?ZHBNQjR3RlRYT3dmYUxQL2VpNGhONUdXNFN1UUdVeDdJdmRhZVVYUEdSYmlh?=
 =?utf-8?B?ejJwa3J6RkcwOWVzS3ZDUGxUaFBtNEJNVzVmQ2lZbmordC8yNzRMY05VOUpx?=
 =?utf-8?B?T2tnSURMdzFiRkNKMVBScFMxa0hhakZrakRXZGJOUUpHR1NQQUhvSExzZ3V3?=
 =?utf-8?B?ejVhSDZUS1c4cU0zVytzWTFKK3RoWlhmbWFlRFQzaFFLTWpTNi9pVDdhMnNm?=
 =?utf-8?B?ODRseUJ4ckVJSXVoK3JHR2hqZXJ4Y2hCeis4ODRPSG45bDFiUitKdGtiREpP?=
 =?utf-8?B?UUdmS1R4bHJrNW1nQ3NwM3VGTzlmLzdUeVRYMTkvcnhQWVRaN3pwZk80blQ1?=
 =?utf-8?B?bXlVWDREU3ZTK3ZRL0RBQlM4QVBvNXFVSzZkbVNjc09PelAvUDN2QUxFK1Vo?=
 =?utf-8?B?d0tvVmYvcHhPN0RRT04waGRLNjdtU3oxcmJmODVUMng4dTdvbXFjemRTbXVq?=
 =?utf-8?B?WWNXTTZKeVRGOU9HbDVRK0dhVXBRTGdTN3VyMnoxV0FDcVVjcnBTTHVwTFo4?=
 =?utf-8?B?ZHkxdTNvdVRqV09XYldIbzVoSE1UOTJUMGR1clVQYmhRcFRGcWZkbFF3VEN0?=
 =?utf-8?B?ZlArdW1JUmg2OUNHaUdrNDlQNGVJVkF6THhSNXg4N1BNdWMyWHZTSUVCdE45?=
 =?utf-8?B?RnRNY3NIZnZ5ay9UY3Z4RDl0MDVTblRFaHlYOHdrdENTQWNzejZlOVh1VHc2?=
 =?utf-8?B?MndoOHlLSEtvTS9wWUNSczF1RXFXV1JzOUhsMWxFWEQvb05ZSHU3MkxtSFRC?=
 =?utf-8?B?ZGNsb1c2Tm4wTFZyWStCUWgrRCtabVZqZGd3bnMyVU1RSHJvdGp0cWhVMzJH?=
 =?utf-8?B?RmRHRk8wMjZJcFdJMGcvODd6MGhYbG5uVngrUnlzQTZTWEJORlRqM2FJLzZp?=
 =?utf-8?B?MldTOE45WS9BSFZWMFRCSFVxWHMvR05vZzNUVXRLS2N2YmZsQ3JSbTZ5SUJp?=
 =?utf-8?B?MUpUSWtldFk3ODZXVEZHR2VoanFxM3NBODFDNkdld2lqWFBQZVRJUTgwYkJW?=
 =?utf-8?B?WDVYS3NyQ1dra2FQUzVoMkl2Skk5QjNvU2gvenAwcWdib3dQR0N0QXRqSThu?=
 =?utf-8?B?dFh5eGdYNnNldnVCbmhMblRJQlBCZUx4bVpwYWY4emVpNmhrWVBtRjQrblBI?=
 =?utf-8?B?aXh0WHZodCtRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGF3Y1JsL21ueFJnc01WbSthaEx0Rnc5a1RlSmdBSWVQeUJUbi9QQS9NRmJm?=
 =?utf-8?B?T3h3RUo5a2QrYzRDaEx5T0IvbFlPN0NSSUxOUnRiVjlkMUxvenNvT1dKc1Zr?=
 =?utf-8?B?eXR4QUlGM2JYQ0c0emdZWUxqK0tUNkdtNFZKNC9yMHZ5SVYwaTFhZGJ5V1VO?=
 =?utf-8?B?eElEZmZIeWszMEdRU1RxcUdUbGJxSlFyWnpOUEN4SzFqNkNuMjVJWmJEUEFH?=
 =?utf-8?B?SUZGVnd1dUxqOE01L3MyQXBuK0RuOEhiNHFSdXYycDlaMWVJZ2t6TXdnTVcv?=
 =?utf-8?B?Z3ZKYWVReUd6am5lYi9DRGQ1Qnhkb2FJNFFETEFjZXRjdDBLdUZPbDJlSjdW?=
 =?utf-8?B?YXJvQS9SeGlaKzJGTXVSQm9xcWJ5Z1lCZ0kwSXN6MFNRVnA4OW5TcVhFRGZX?=
 =?utf-8?B?RXlyY0FubWV1Z1o5TE9aMnoxN0lJMEVRcVZaN3hWV2tlckhkc0E0Y0JTTFkv?=
 =?utf-8?B?a09KM2V1SUFGbFY2S3BaUW0wVjBOdElZOHo4cVlReVVlL0FLVFN6TEg3L1oy?=
 =?utf-8?B?RFcreHdSQS9jUGp4MExpMjNXYStiR1hWOXNDOWRkcU4xbDFYanpZM08zQ3Iz?=
 =?utf-8?B?Rk5VK3U0RVhEdWRHSk90RkJRclpEWmp0SWRxVk5qMSs3MXB1NEhXVHl6d1c4?=
 =?utf-8?B?dE5WZXNhOWNsSkRFdGxDL0d1MHBZcmF2czRPNUpUVHFEbFc4Z0syMXI4VE1a?=
 =?utf-8?B?VXpMUHg0bjFYaTBZeGF5WG4zeFdpOFJPL0hob0VvTWw0SERyTjdVZGpja0I1?=
 =?utf-8?B?dEd2NWxERHFDQ05vN3N3dzZQYlVHL1RrOGYyM01MUm9uZW9yeWhyckNubTJR?=
 =?utf-8?B?alFvMHV6TFZYU0tUTVhYRG9nZS81MldGaHZ6eG9QQzN1NldQT1M0YkdpRTNL?=
 =?utf-8?B?SnEwUnJtUVJZT0xYd0x1cTY4M3FLRDhFL0tmVGVQcmk5THFpT2w2WnhwaXM4?=
 =?utf-8?B?SzdYTDh6TStYbzVjdVY5eHZIVWY5ckdHT2FnNkpDVmhQK1RidHY1MDk4RTVY?=
 =?utf-8?B?MmRKemROZ1NRM3ZJQW5VcVY4VjlRSEdFdW5YSDFoWFBBUzAyY3NTZkd1N2hJ?=
 =?utf-8?B?bDlQem94Y3F0Y1ZONVNzNzE2ZnkvZHdXck5MWjZOa0dPYlJic2ZIb2ovNzZq?=
 =?utf-8?B?UlFOZXlHa0xVYTZTWHNQd1hRQUNMamNleDlCaHVkQUFaMkdHMWc2Y3psdlVY?=
 =?utf-8?B?WFJ4Rk5RRllRYk5nVGZXY2xDbnB0Ynl2TndhNWx4UFJQTzNoMU1tUkx2OHcx?=
 =?utf-8?B?bElleE4rWHg3UTJCWmxrSGFpMUdwYk5XcHFuSTd1OE1UcGwyaHBTN3pKcVl0?=
 =?utf-8?B?SHgrUUpydkFaK293WHRFV2pSajc3RXNrZUo1V3pPME96L2hqWU5sQzRteWNJ?=
 =?utf-8?B?Wi9IU1VDQ1UxL1loNmV3M1I4YmNYaThjMExGSFZXNVg2SDhPUjY5RUM2Z1Y5?=
 =?utf-8?B?eVFxZzA3U3JNSzQ3TElMK3piRkNCOGdmZFRoTndGMnIva241YWwrYjRSNDgr?=
 =?utf-8?B?VjNDdldzbTRHdHJFWXBRSFNyZkMxeTAvME96dVJScW5jeDNTc2R5anZYOGY2?=
 =?utf-8?B?RmNqL3dycTVzZkdvRDkyWmVlanFWcm5lTEtOY2ZoYlUwa2ltNFNWNDRrUUVu?=
 =?utf-8?B?enNlTU9kY2IvSS9CM2xKeml6Z1FkQ3E4Sy9IN1RFejYwcWp3RGR5dmwrWitP?=
 =?utf-8?B?YVFzVXhzVDVid01XTkIzWjRXZ2hFUDFFMitCM3o2YjU1VEltWFYwUTZ4SzNO?=
 =?utf-8?B?YXJhc0d0dVlhenU2Z0JxTWMwVncrQnZDRXpvdXRVUmd6L3N0TWZqcXNxOCtZ?=
 =?utf-8?B?ZnpCY2FWUjQyUzZJRnpBTytqNWh3Wml0N21VQXova2VSM1YrWWh4czRpcDBa?=
 =?utf-8?B?b2ZHYU04QW9UWU9nSGFzaHZOcGF2SzBKaXBtTkdlV04zZHR0SzJXOEJUNHFz?=
 =?utf-8?B?QzZZTkhkb2k1S1QyYlNGTy9NNld6VURzazVYMlJpa0NIakp2RUFoazB0Zzdk?=
 =?utf-8?B?eDl6RjlwS1FBOEt4TXpnWTY1Mk5BMVMrN2kzUkNHRjJjbFc3bGR4RjJ5SFhh?=
 =?utf-8?B?Ri81NmhVcmlveHlDKzN0NGZ3OXZKR3E4WDc3UHdHUGhycmpVcStUN0ppaVZV?=
 =?utf-8?Q?u0Q9KIdCNrngNQC+DEYmmhacS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dc488b-dba3-4079-e447-08dde477cd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 08:08:54.7849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ORSLbWDuiDqxtBVcke/04/7KESRM0v06VCjyUs6gzsglGz+009+7SZGrlUxGUldunO3m2xMDoACPagA4uNZqzHwM7JjfDFGQVcqcMu2itAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5232
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmF2dWxhcGFsbGksIE5h
cmVzaCBLdW1hciA8bmFyZXNoLmt1bWFyLnJhdnVsYXBhbGxpQGFsdGVyYS5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIEF1Z3VzdCAyNiwgMjAyNSAyOjE4IEFNDQo+IFRvOiBDaGVlLCBUaWVuIEZvbmcg
PHRpZW4uZm9uZy5jaGVlQGFsdGVyYS5jb20+OyBSYXZ1bGFwYWxsaSwgTmFyZXNoDQo+IEt1bWFy
IDxuYXJlc2gua3VtYXIucmF2dWxhcGFsbGlAYWx0ZXJhLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54
LmRlDQo+IENjOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXRAbWFpbGJveC5vcmc+OyBTaW1vbiBH
b2xkc2NobWlkdA0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IE1pY2hhbCBT
aW1law0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBOZywgQm9vbiBLaGFpIDxib29uLmtoYWku
bmdAYWx0ZXJhLmNvbT47DQo+IFl1c2xhaW1pLCBBbGlmIFpha3VhbiA8YWxpZi56YWt1YW4ueXVz
bGFpbWlAYWx0ZXJhLmNvbT47IFRvbSBSaW5pDQo+IDx0cmluaUBrb25zdWxrby5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy8zXSBkcml2ZXJzOiBmcGdhOiBDaGVjayBiaXRzdHJlYW0g
YWRkcmVzcyBkb2Vzbid0DQo+IGV4Y2VlZCA1MTJNQg0KPiANCj4gSGkgVGllbiBGb25nDQo+IA0K
PiBPbiAyNS1BdWctMjUgMzoxMiBQTSwgQ2hlZSwgVGllbiBGb25nIHdyb3RlOg0KPiA+IEhpIE5h
cmVzaCwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBS
YXZ1bGFwYWxsaSwgTmFyZXNoIEt1bWFyIDxuYXJlc2gua3VtYXIucmF2dWxhcGFsbGlAYWx0ZXJh
LmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjAsIDIwMjUgMzozMiBQTQ0KPiA+
PiBUbzogdS1ib290QGxpc3RzLmRlbnguZGUNCj4gPj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJlay52
YXN1dEBtYWlsYm94Lm9yZz47IFNpbW9uIEdvbGRzY2htaWR0DQo+ID4+IDxzaW1vbi5rLnIuZ29s
ZHNjaG1pZHRAZ21haWwuY29tPjsgTWljaGFsIFNpbWVrDQo+ID4+IDxtaWNoYWwuc2ltZWtAYW1k
LmNvbT47IENoZWUsIFRpZW4gRm9uZw0KPiA8dGllbi5mb25nLmNoZWVAYWx0ZXJhLmNvbT47DQo+
ID4+IE5nLCBCb29uIEtoYWkgPGJvb24ua2hhaS5uZ0BhbHRlcmEuY29tPjsgWXVzbGFpbWksIEFs
aWYgWmFrdWFuDQo+ID4+IDxhbGlmLnpha3Vhbi55dXNsYWltaUBhbHRlcmEuY29tPjsgVG9tIFJp
bmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47DQo+ID4+IFJhdnVsYXBhbGxpLCBOYXJlc2ggS3VtYXIg
PG5hcmVzaC5rdW1hci5yYXZ1bGFwYWxsaUBhbHRlcmEuY29tPg0KPiA+PiBTdWJqZWN0OiBbUEFU
Q0ggdjIgMy8zXSBkcml2ZXJzOiBmcGdhOiBDaGVjayBiaXRzdHJlYW0gYWRkcmVzcw0KPiA+PiBk
b2Vzbid0IGV4Y2VlZCA1MTJNQg0KPiA+Pg0KPiA+PiBTZWN1cmUgRGV2aWNlIE1hbmFnZXIoU0RN
KSBoYXMgb25seSA1MTJNQiB3aW5kb3cgYWRkcmVzcyBzcGFjZSB0bw0KPiBIUFMNCj4gPj4gb3Zl
ciBQU0kgQkUgbGluay4gVGhlIGRlZmF1bHQgYWNjZXNzIHJhbmdlIGlzIDB4MCB0byAweDFGRkZG
RkZGLg0KPiA+PiBUbyBhbGxvdyBTRE0gYWNjZXNzaW5nIHRoZSBhZGRyZXNzIHNwYWNlIG1vcmUg
dGhhbiA1MTJNQiwgU01NVSBoYXMNCj4gdG8NCj4gPj4gYmUgc2V0dXAgZm9yIGFkZHJlc3MgdHJh
bnNsYXRpb24uDQo+ID4+DQo+ID4+IEEgY29uZGl0aW9uYWwgY2hlY2sgaXMgYWRkZWQgdG8gbm90
IGFsbG93IHRoZSBmcGdhIHJlY29uZmlndXJhdGlvbg0KPiA+PiBmb3IgYW55IGJpdHN0cmVhbSBk
YXRhIHdoZXJlIGFkZHJlc3MgZXhjZWVkcyA1MTJNQiwgdW5sZXNzIFBTSSBCRQ0KPiA+PiBsaW5r
IGFkZHJlc3MgdHJhbnNsYXRpb24gaXMgc2V0dXAgaW4gU01NVS4NCj4gPj4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogTmFyZXNoIEt1bWFyIFJhdnVsYXBhbGxpDQo+ID4+IDxuYXJlc2hrdW1hci5yYXZ1
bGFwYWxsaUBhbHRlcmEuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBhcmNoL2FybS9tYWNoLXNvY2Zw
Z2EvaW5jbHVkZS9tYWNoL3NtbXVfczEwLmggfCAgNiArKysrKysNCj4gPj4gICBkcml2ZXJzL2Zw
Z2EvaW50ZWxfc2RtX21iLmMgICAgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQo+
ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9tYWNoLXNvY2ZwZ2EvaW5jbHVkZS9tYWNoL3NtbXVfczEwLmgNCj4g
Pj4gYi9hcmNoL2FybS9tYWNoLXNvY2ZwZ2EvaW5jbHVkZS9tYWNoL3NtbXVfczEwLmgNCj4gPj4g
aW5kZXggMjA5Y2FhODZlMzguLmQ2MTE2NjRlMjI3IDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL2Fy
bS9tYWNoLXNvY2ZwZ2EvaW5jbHVkZS9tYWNoL3NtbXVfczEwLmgNCj4gPj4gKysrIGIvYXJjaC9h
cm0vbWFjaC1zb2NmcGdhL2luY2x1ZGUvbWFjaC9zbW11X3MxMC5oDQo+ID4+IEBAIC0zMCw2ICsz
MCwxMiBAQA0KPiA+Pg0KPiA+PiAgICNkZWZpbmUgU01NVV9TSURfU0RNMkhQU19QU0lfQkUJCTAN
Cj4gPj4NCj4gPj4gKyNkZWZpbmUgU0RNMkhQU19QU0lfQkVfQUREUl9CQVNFCTANCj4gPj4gKy8q
IFBTSSBCRSA1MTJNQiBhZGRyZXNzIHdpbmRvdyAqLw0KPiA+PiArI2RlZmluZSBTRE0ySFBTX1BT
SV9CRV9XSU5ET1dfU1oJMHgyMDAwMDAwMA0KPiA+PiArI2RlZmluZSBTRE0ySFBTX1BTSV9CRV9B
RERSX0VORAkJXA0KPiA+PiArCShTRE0ySFBTX1BTSV9CRV9BRERSX0JBU0UgKyBTRE0ySFBTX1BT
SV9CRV9XSU5ET1dfU1ogLQ0KPiA+PiAxKQ0KPiA+PiArDQo+ID4+ICAgdm9pZCBzb2NmcGdhX2lu
aXRfc21tdSh2b2lkKTsNCj4gPj4gICBpbnQgaXNfc21tdV9ieXBhc3Modm9pZCk7DQo+ID4+ICAg
aW50IGlzX3NtbXVfc3RyZWFtX2lkX2VuYWJsZWQodTMyIHN0cmVhbV9pZCk7IGRpZmYgLS1naXQN
Cj4gPj4gYS9kcml2ZXJzL2ZwZ2EvaW50ZWxfc2RtX21iLmMgYi9kcml2ZXJzL2ZwZ2EvaW50ZWxf
c2RtX21iLmMgaW5kZXgNCj4gPj4gNWY0YWFlNDdkNmQuLjFiYmI3MTcwMTViIDEwMDY0NA0KPiA+
PiAtLS0gYS9kcml2ZXJzL2ZwZ2EvaW50ZWxfc2RtX21iLmMNCj4gPj4gKysrIGIvZHJpdmVycy9m
cGdhL2ludGVsX3NkbV9tYi5jDQo+ID4+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4+ICAgI2luY2x1
ZGUgPHdhdGNoZG9nLmg+DQo+ID4+ICAgI2luY2x1ZGUgPGFzbS9hcmNoL21haWxib3hfczEwLmg+
DQo+ID4+ICAgI2luY2x1ZGUgPGFzbS9hcmNoL3NtY19hcGkuaD4NCj4gPj4gKyNpbmNsdWRlIDxh
c20vYXJjaC9zbW11X3MxMC5oPg0KPiA+PiAgICNpbmNsdWRlIDxhc20vY2FjaGUuaD4NCj4gPj4g
ICAjaW5jbHVkZSA8Y3B1X2Z1bmMuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4N
Cj4gPj4gQEAgLTEwMzEsNiArMTAzMiwxOCBAQCBpbnQgaW50ZWxfc2RtX21iX2xvYWQoQWx0ZXJh
X2Rlc2MgKmRlc2MsDQo+IGNvbnN0DQo+ID4+IHZvaWQgKnJiZl9kYXRhLCBzaXplX3QgcmJmX3Np
emUpDQo+ID4+DQo+ID4+ICAgCWZsdXNoX2RjYWNoZV9yYW5nZSgodW5zaWduZWQgbG9uZylyYmZf
ZGF0YSwgKHVuc2lnbmVkDQo+ID4+IGxvbmcpKHJiZl9kYXRhICsgcmJmX3NpemUpKTsNCj4gPj4N
Cj4gPj4gKwkvKg0KPiA+PiArCSAqIERvbid0IHN0YXJ0IHRoZSBGUEdBIHJlY29uZmlndXJhdGlv
biBpZiBiaXRzdHJlYW0gbG9jYXRpb24NCj4gPj4gK2V4Y2VlZA0KPiA+PiB0aGUNCj4gPj4gKwkg
KiBQU0kgQkUgNTEyTUIgYWRkcmVzcyB3aW5kb3cgYW5kIFNNTVUgaXMgbm90IHNldHVwIGZvciBQ
U0kgQkUNCj4gPj4gYWRkcmVzcw0KPiA+PiArCSAqIHRyYW5zbGF0aW9uLg0KPiA+PiArCSAqLw0K
PiA+PiArCWlmICgoKHU2NClyYmZfZGF0YSArIHJiZl9zaXplKSA+PSBTRE0ySFBTX1BTSV9CRV9B
RERSX0VORCAmJg0KPiA+PiArCSAgICAhaXNfc21tdV9zdHJlYW1faWRfZW5hYmxlZChTTU1VX1NJ
RF9TRE0ySFBTX1BTSV9CRSkpIHsNCj4gPj4gKwkJcHJpbnRmKCJGYWlsZWQ6IEJpdHN0cmVhbSBs
b2NhdGlvbiBtdXN0IG5vdCBleGNlZWQgMHglMDh4XG4iLA0KPiA+PiArCQkgICAgICAgU0RNMkhQ
U19QU0lfQkVfQUREUl9FTkQpOw0KPiA+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPj4gKwl9DQo+
ID4NCj4gPiBUaGlzIGZ1bmN0aW9uIGlzIGNvbW1vbiBmb3IgYWxsIFNvQzY0IGRldmljZXMsIGJ1
dCBhYm92ZSBsaW1pdGF0aW9uIGlzDQo+ID4gbm90IGFwcGxpY2FibGUgdG8gQWdpbGV4NQ0KPiAN
Cj4gaW50ZWxfc2RtX21iX2xvYWQoKSBpcyBkZWZpbmVkIHR3aWNlIHdpdGhpbiBhICNpZmRlZiBj
b25kaXRpb24uIDUxMiBNQg0KPiBsaW1pdGF0aW9uIGlzIG9ubHkgYWRkcmVzc2VkIGluIHRoZSBz
ZWNvbmQgZnVuY3Rpb24gZGVmaW5pdGlvbi4gQ291bGQgeW91DQo+IHBsZWFzZSBjb25maXJtIGlm
IHRoaXMgaXMgbm90IHRoZSBpbnRlbmRlZCBpbXBsZW1lbnRhdGlvbj8NCj4gDQoNCk9rLCB0aGFu
a3MgZm9yIGNsYXJpZmljYXRpb24sIHRoZSBmdW5jdGlvbiBoZXJlIGlzIGp1c3QgZm9yIGxlZ2Fj
eSBkZXZpY2VzIGluIGxlZ2FjeSBib290IGZsb3csIHRoZW4gdGhpcyB3b3VsZG4ndCBiZSBjYWxs
ZWQgaW4gQWdpbGV4IDUNCg0KWy4uLl0NCg0KQmVzdCByZWdhcmRzLA0KVGllbiBGb25nDQo=
