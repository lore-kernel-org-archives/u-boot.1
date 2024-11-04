Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DAFD111BC
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 08:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E2F78914D;
	Mon,  4 Nov 2024 09:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ex6Uqy8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0641A8914F; Mon,  4 Nov 2024 09:15:41 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CBB8914C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 09:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoNNjhJjY8wP89kQCVlIrjsBpBRwPSnQz/rdXZWYTF6HmgudLk0p1+Akc8NDubGXFfvNR0haiaNNnro6hmPxah75jFWBzE484b3fCzAbHKvFfo9b5MYOumxXyksjDdHOm77ZPNf7VRnES1fvaW3iMqx+nX0NOfrKdMzYYxmgVFfJ+Do9BYme36WcNWu0EVuGV0Z1v4aHs/TDE9J23vrJVPPY3boa691SXv5x3CVnauxksN1EotaTgNG/VOqw1y0MEAC+wbaw5IYnUtvD12wkLe1i8WpUKjCDz50Z81PaN4Gv0Qi8CLE43hf//jDfv+0BlRZhEN5bau1V0V7Wf4uqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gUcapH5rU7U6kK+mpTmHAm41DshZ6k2l7Zm1AOmKdY=;
 b=E08IISQy8Z6VWn74SAudINMMCnVtD57ZN3N7MzPUe8RTVIv3Hg1tUBIrw1xHelwSBRIb84paq1fkNtyMVZrPHCbrwAGBsfEfxbNKd2Uf3bKo+77SrDraiVsqhYLimKhr34l8q2XmT00kB3QDzGKEaBX4UFhYosio/JfTz9enBjnrt/JFNHixsIi0mVoQTXCFArwOh6XnKTMAuA2R2rxiOuJZJvmUFKoXjOViYjVoZTLtpvYmozoek2q03AtrczJbj4Wa8gJLqN47ZkJusGkjza1vibHXowrljOrRGmusu4BRbBRCbBO5iQs0SHr+N+FO7y+JWQQ0RQrBRI0M/xeXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gUcapH5rU7U6kK+mpTmHAm41DshZ6k2l7Zm1AOmKdY=;
 b=Ex6Uqy8vJuy5cz0BqETIG5JcWH5PGeXlARCCtKMjJ1bEDG8mmczmmNBl2JdpPNgD8k9E1E0strTmMWoWFhXbPmAioftAc472MkvqMd/qsqrhss7GRPcv9wzxhAJeME8rYDjVRCNEnsvX5X95CPA1svjtiOWMXJ9oC0b7ywr6ZTQ=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:15:34 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:15:34 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, "Erkiaga Elorza, Ibai"
 <ibai.erkiaga-elorza@amd.com>, Jagan Teki <jagan@amarulasolutions.com>,
 "Simek, Michal" <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: RE: [PATCH] mtd: spi-nor: Fix integer overflow in stacked memories
 support
Thread-Topic: [PATCH] mtd: spi-nor: Fix integer overflow in stacked memories
 support
Thread-Index: AQHbLYMVTpI5uBhnMkyBbXM52D5B1LKmyADw
Date: Mon, 4 Nov 2024 08:15:34 +0000
Message-ID: <SA1PR12MB8697960EEF14B0C80FA20FA598512@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241102235754.74661-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241102235754.74661-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|MN2PR12MB4239:EE_
x-ms-office365-filtering-correlation-id: 482d7287-ad78-4dc9-3249-08dcfca8db27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U1FUaHU2UU5Dbmdab0xhRERKT0tzc0Jka2dadTNodkF3emIzcTc1RWtSQ1RQ?=
 =?utf-8?B?ekVPZDlnRlNuM2VrSEU3cHMxU0hUYk1Wd0I3SzJjYWF5LzMwSzBKYzV5dkdn?=
 =?utf-8?B?dHAzZXlmK3kvK0lJek1mbjl0Q0N6a09iUWY3Z0hyNHdMMUpJb0NUdzFvbS9T?=
 =?utf-8?B?ZStYSVV2dDRJdWFFcWFnVU1QNDZYa3oyU3pRM3lDckhtcFpXZG4xdzZmV2RI?=
 =?utf-8?B?Vy9NWmFVVEpuWklCLzBUa0RZOXZ3Kzc0YlFSemZiTTlrcU8wYlZPT0JXTS9J?=
 =?utf-8?B?Sjlxc0xmY1ZWZGJyNEZ5dVFTMTlTZXlObzBnZDllcWtET2I1RkNFamVwQ1hG?=
 =?utf-8?B?SjdBa0cxalBQS3lacmdDdVFsblI5c29xK3ZPMkFQY1BSbHI1SGsvb1ZGMnF5?=
 =?utf-8?B?cHgxSFlTTEEvS0NlZ1lNcklTaTF2cG80c0FNV0lRdWw2eUZxNVdxSTVBdUxG?=
 =?utf-8?B?R1BlK3dnenJueTJWZmdWdFVOYTRENi9JZ1hwdTY5RFFad3FXTS9wZlpGQlAz?=
 =?utf-8?B?c1lwN2FQL1hWc09GVzEvWC9YTGk0MFR4YWliYWwrZnJMcERtdDZpNDNNUW04?=
 =?utf-8?B?bUQ0NjViYjJPM3ZvOFpwdlpCeFJWbmJPNTVKbGNnUEk4Q3FiQi9yM25NdElH?=
 =?utf-8?B?QVQ3QmY3V1dMLy8vM3NZTjVVY1RtZnFIbDhldGJWOWUwKy9rQ1d3M0lSYmJP?=
 =?utf-8?B?b0NFREt4czhnb1pFWnVMVk8zTnYxa3YwaW9EUm1pNkJQWDhvaGRQVmhjNG1m?=
 =?utf-8?B?aVJYcGhybUV5VUp1cno5TStLNStGSDJhWE5VMzI5VURJd0VJT04yMU41Z3hp?=
 =?utf-8?B?bGx4MjNJdFhYNWtPVTNnanN1N29PNnBtQ1NldW8wWlo1dFhodnV5dU9YdGlp?=
 =?utf-8?B?dDZvelpGZ3BoWC9rSWhzZ2xMS3ZVVnVEUCtGd1loY2hWNHlXNmE3QnRGS0lx?=
 =?utf-8?B?aWJKTDhIY2pGbTNtT0ZUNmRsQUJ6MTJUQ3AxdGVCcStEaktJQ0h6RFp2L1Qv?=
 =?utf-8?B?d2ppc1UvYTdFWEM0MnFNWDArZG8yeVZSd0ZUWGhRN3gvQUxrb1pPbTc0amlZ?=
 =?utf-8?B?S1owbFlzMUJrRGhQQ3B1WXhpSTlJcVVBRmE4WnhoN0hha3FYdzRYQmltcCsw?=
 =?utf-8?B?U2Zlay9QUzZjcmVxWCtiQnorR1lyZW9jZnkxaGYxakRILytZOVNaVW9VbXhy?=
 =?utf-8?B?aVl3eXRuTWxPZ3I3SmZyT0lBR2hLZGp3YStOUXdDUXZGNEtoQnRMQ3BYdWxP?=
 =?utf-8?B?OStxT3dINDhLaWtVaWNHb0trWkVuLzhGbTZDN25Ma3FaU0pyZTgySk5halRv?=
 =?utf-8?B?b2d4WVo5VGJRdVVObVZuTG5qTkIwTURzT01idzdkT3VZdkE4QjV6aG1SZ3lO?=
 =?utf-8?B?UzkvZStOVHR1czl1dGFBZjB5WXpKem9HVHhPL05PUksvK3hMOXN6bHRhWjUx?=
 =?utf-8?B?aEdRRHM5bmJ6bVhUNVVLbzllZU5vcHFqa1l3WHJ4dmxpc3FKQ1BOZWJuUm9s?=
 =?utf-8?B?TmVLT0Y1SXFTT1YzRHBDY3F5enNtdy9tSnJ1UFYzWmJ5dDloaDRudVhLOWZw?=
 =?utf-8?B?OTU2M0xnZ2JKWU1nc0paeUpkNDBpNVZtZXNrVnJRMlc3Y0tCTlkrZGUzM2pQ?=
 =?utf-8?B?V0dYemovQmZoVGEwNGVHK3E3WUFRbGRDaXJzUDlMUVM0RkRjK0FtZk11NSty?=
 =?utf-8?B?RkNuRnZpWkpWZmRlQjR3SFhnSlJwZzJFdUx1S242aGlMMS8rU0s0QTRzRnJW?=
 =?utf-8?B?VVJMZmZhN1JxMm5SS2ZhRytnMTlTWFVaQTRtd3B3ZUJOV3Bodm9EaXE4TG5V?=
 =?utf-8?Q?4jDRmAPofV/7n7F/w3khA7yua935GlSxrWtaY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXQrT3hLdllUTFdiNFAwWWJpWVR0dHNkNGNpQWlJNEQ0d3JLQUxFOXF6b1Fj?=
 =?utf-8?B?eHRBZ3BKTzN3eUZ6SVZwaHhFbWFGWmhVTmdyZXZNdWU1VnFJTE1Ea1p2TFFP?=
 =?utf-8?B?Y3k1UzdOSytpTXFOR1V1V2VMVVhwanRkSDZ4bnpwVE1HNnJuUzhyY0V1eVdv?=
 =?utf-8?B?V1V2YjRLV1phek5MdkZ3Yk1GWHpMQ1FLVkVCdG93a1hxWVlmM2t0NUpFeCs0?=
 =?utf-8?B?U3g5NDRETEU1bGJUalM1anlFWDErSnVEemFlcnFpMXhWTFVMbHVxTXh5eTBX?=
 =?utf-8?B?akszQ0JhWGxzT3J0WEJnVW1WT2xvcHFEbGJDK08zNURYUjhuNlhXbitOVERO?=
 =?utf-8?B?RDBaN1dEOVhYa2NlNUk3b3BhTDhHY1ZqUUxLU281cU9KR0FIWGlTdENLRWlh?=
 =?utf-8?B?QnVYcFowTkxKT0QvV0k2TFdURDY0RTBMdFk3d0dySWtBclhaMHUvTXJtRHdR?=
 =?utf-8?B?YmRMbEdNY0tBd0NBWjdEa216MDJBMlI3aU96VnhPZmZ5d0FiZWlpY2hqbE14?=
 =?utf-8?B?U1hDNThtZENiZVJrYnYya1VGenQyZ1N2aDdINTVNbmNVMEQrZlpSYzZ1RGp5?=
 =?utf-8?B?M214WEZNVkpmMk9qZUhiemg1TGNZZU4rMEVIZW1IZUhlTTQxd01sRTZSMExR?=
 =?utf-8?B?bzB2N3h1SDRzeG1kL1Bnem45MHozQ2ZZazBDUm1kUnBycm9nemRHVlUrQXhj?=
 =?utf-8?B?VUpBMThOdWpiZktDMGJmRzBzZHplL1l6MSt3U01jWU8zb1lmV0VvZnprbjRt?=
 =?utf-8?B?WENQbStLQ1ZpSnNITEd5ZzBXME5wdFp0dW9EV3d5TEp6UWFUdkFlRm40ODJ3?=
 =?utf-8?B?Y0RNcGwvMkZ3U1dwbkphSWRodFU4OFAzanR4SkZGN0pDM3BPZ2pNRjF4MDg2?=
 =?utf-8?B?Snl4Z282Y2hpcTlQbm1oYlZMUExZWDREKy8vaklhL2UvRzlDMVNoSys5a2Fy?=
 =?utf-8?B?Z1ZROTdvMXlRdFRpRWdRbTFsdXJLUTNPY2k5TDBZeUZxM01nRVBMeEZUaGFr?=
 =?utf-8?B?djVPZHVXU2pPKzhOZEdEVEVuUy91R1lVa0JpWi9uRE1vOWhDVmJTczhBTkll?=
 =?utf-8?B?U0Focmo1NUtmWHY3dk12QXVJc1IzL1lJM1paekkwS3VRZnVFWWZjdXMvR1NU?=
 =?utf-8?B?Z2FnSkdpNXptdzBibDVYZ2puYUptYWpXRHdyN3YyOEhWbXF2cWwwRnpmOHJZ?=
 =?utf-8?B?cUhWN29Nci9EQWVYMHdHZDJEMGtGN1NyMkMxMlluYzN3MUM4dS9QRG9xVkxG?=
 =?utf-8?B?RFZSU2FKN0Ewbko4R3p0U2g0aVA4c0hIZ1ZJU1ROcnBGODE0UmhwbnUyZDZz?=
 =?utf-8?B?TWs4dEw3ZDBQZzdUdzFpcXh6cjRPWWFUTitvdE41QnlrVk1tTEFGTk1jV3JD?=
 =?utf-8?B?cG1BYitzZmZYUUs4SU9oZHVMdlNhME1OUDR6VWdoK0dnMjdyWHV0MkZhOW43?=
 =?utf-8?B?cW1WTjBFUHNuV0hoSnIwOFlzM2FxTmxvOGd5UXJES0VQcXRPM3A2VXFWMHl1?=
 =?utf-8?B?TmREMWRaMUQ5ME5hbzVVV09zaGlsSmdHWXBtN0ZDb0tiNUEzSFNDT3QzLzZP?=
 =?utf-8?B?WE0ra3R0L05lNDh2MzJXaGFlTHpzc21jZ1QrRlpYa0FzTzFTQVZaS0J0VGRR?=
 =?utf-8?B?NStjVGx6empUeTJKUGoyeFlXejg3RC9Ed1NCR3hSdklyVVEwMGlFaSsxdEhm?=
 =?utf-8?B?eTdzTnU5M3F2ZkJtOTFXTmpEUXZPU1RTWWFSM3ZuSDF3RyszMURaT21ncHNn?=
 =?utf-8?B?Q21ZMkFmYmlYTVkrSmFld3FuOGZ4Wmc2d21pMERjc0FHVnd3M2FqQTdGSzFr?=
 =?utf-8?B?WVV4VG1RaVpzMS9WOXpnOVRZdWdaWUpNYk5UQURMNmJ3Smg0ZUkrRHVpRkE5?=
 =?utf-8?B?SlNkL0xpSU1pL0F0dENhczl6dmVLZS9aTVE2NmdQVDROVXRmSkNKYmcrM3Qy?=
 =?utf-8?B?TTZWY2hNYnRuOXNBQm9yT0pZR042NWl4a2pSZjRxWkhMU0hhSUNkdTZJMksx?=
 =?utf-8?B?TGk5L3ZzTFNqU204VDg1clpXOW82ZlZYSnp6azlSRzB5TmtIc3MzMWxySHlU?=
 =?utf-8?B?Wks0Qk9CK0dscUpReXM3cmRycFVyejA4SE9FYS82cGJCV0llOEJjcUlmcWRk?=
 =?utf-8?Q?NWuI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482d7287-ad78-4dc9-3249-08dcfca8db27
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 08:15:34.1078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llNj7u5808gaMkdMD2lDX68FzhL73HdBbk4lstS34SWcETdrvGyEp6trs3QbU/gO1krXE7V1UAvV//zXYkVEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgTm92ZW1i
ZXIgMywgMjAyNCA1OjI4IEFNDQo+IFRvOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogTWFy
ZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBIZWlucmljaCBTY2h1
Y2hhcmR0DQo+IDx4eXByb24uZ2xwa0BnbXguZGU+OyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGth
b2Qub3JnPjsgQXNob2sgUmVkZHkgU29tYQ0KPiA8YXNob2sucmVkZHkuc29tYUBhbWQuY29tPjsg
RXJraWFnYSBFbG9yemEsIEliYWkgPGliYWkuZXJraWFnYS0NCj4gZWxvcnphQGFtZC5jb20+OyBK
YWdhbiBUZWtpIDxqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4g
PG1pY2hhbC5zaW1la0BhbWQuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IEFi
YmFyYXB1LCBWZW5rYXRlc2gNCj4gPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsgV2lsbGlh
bSBaaGFuZyA8d2lsbGlhbS56aGFuZ0Bicm9hZGNvbS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0g
bXRkOiBzcGktbm9yOiBGaXggaW50ZWdlciBvdmVyZmxvdyBpbiBzdGFja2VkIG1lbW9yaWVzIHN1
cHBvcnQNCj4gDQo+IFRoZSA1ZDQwYjNkMzg0ZGMgKCJtdGQ6IHNwaS1ub3I6IEFkZCBwYXJhbGxl
bCBhbmQgc3RhY2tlZCBtZW1vcmllcyBzdXBwb3J0IikNCj4gYWRkcyBuZXcgU1BJIGJ1cyBmbGFn
cywgYnV0IGFsc28gaW50cm9kdWNlcyBhIGNvbXBsZXRlbHkgbmV3IHNldCBvZiBTUEkgYnVzIGZs
YWdzIGluDQo+IGFub3RoZXIgbG9jYXRpb24uIFRoZSBleGlzdGluZyBmbGFncyBmaWVsZCBpcyB0
eXBlIHU4LCB3aGlsZSB0aGUgbmV3IHNlcGFyYXRlIGZsYWdzIGFyZQ0KPiBCSVQoOCkgYW5kIGhp
Z2hlci4gVXNlIG9mIHRob3NlIG5ldyBmbGFncyB0cmlnZ2VycyBpbnRlZ2VyIG92ZXJmbG93Lg0K
PiANCj4gRHJvcCB0aGUgbmV3bHkgaW50cm9kdWNlZCBmbGFncyB3aGljaCB3ZXJlIG5ldmVyIHVz
ZWQgYW55d2hlcmUgaW4gdGhlIGNvZGUuIE1vdmUNCj4gdGhlIG9uZSByZW1haW5pbmcgZmxhZyB3
aGljaCB3YXMgdXNlZCBpbiB0aGUgY29ycmVjdCBwbGFjZSBhbmQgY2hhbmdlIGl0IGZyb20gQklU
KDgpDQo+IHRvIEJJVCg2KSBzbyBpdCBmaXRzIHRoZSB1OCBmbGFncy4NCj4gDQo+IEZpeGVzOiA1
ZDQwYjNkMzg0ZGMgKCJtdGQ6IHNwaS1ub3I6IEFkZCBwYXJhbGxlbCBhbmQgc3RhY2tlZCBtZW1v
cmllcyBzdXBwb3J0IikNCj4gQWRkcmVzc2VzLUNvdmVyaXR5LUlEOiA1MTA4MDQgRXh0cmEgaGln
aC1vcmRlciBiaXRzDQo+IFJlcG9ydGVkLWJ5OiBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXByb24u
Z2xwa0BnbXguZGU+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dCty
ZW5lc2FzQG1haWxib3gub3JnPg0KPiAtLS0NCj4gQ2M6ICJDw6lkcmljIExlIEdvYXRlciIgPGNs
Z0BrYW9kLm9yZz4NCj4gQ2M6IEFzaG9rIFJlZGR5IFNvbWEgPGFzaG9rLnJlZGR5LnNvbWFAYW1k
LmNvbT4NCj4gQ2M6IEhlaW5yaWNoIFNjaHVjaGFyZHQgPHh5cHJvbi5nbHBrQGdteC5kZT4NCj4g
Q2M6IEliYWkgRXJraWFnYSA8aWJhaS5lcmtpYWdhLWVsb3J6YUBhbWQuY29tPg0KPiBDYzogSmFn
YW4gVGVraSA8amFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+IENjOiBNaWNoYWwgU2ltZWsg
PG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBDYzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNv
bT4NCj4gQ2M6IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSA8dmVua2F0ZXNoLmFiYmFyYXB1QGFt
ZC5jb20+DQo+IENjOiBXaWxsaWFtIFpoYW5nIDx3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbT4N
Cj4gLS0tDQo+IE1heWJlIHdlIHNob3VsZCByZXZlcnQgdGhlIHdob2xlIHN0YWNrZWQgcGF0Y2hz
ZXQgdW50aWwgaXQgaXMgZml4ZWQgcHJvcGVybHkgPw0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3p5
bnFfcXNwaS5jICAgIHwgMiArLQ0KPiAgZHJpdmVycy9zcGkvenlucW1wX2dxc3BpLmMgfCA2ICsr
Ky0tLQ0KPiAgaW5jbHVkZS9zcGkuaCAgICAgICAgICAgICAgfCA4ICsrLS0tLS0tDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zcGkvenlucV9xc3BpLmMgYi9kcml2ZXJzL3NwaS96eW5xX3FzcGku
YyBpbmRleA0KPiA0YWFkMzI0OGQ5ZS4uZTQzZGJiNDBjNGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvc3BpL3p5bnFfcXNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3p5bnFfcXNwaS5jDQo+IEBA
IC04MTMsNyArODEzLDcgQEAgc3RhdGljIGludCB6eW5xX3FzcGlfZXhlY19vcChzdHJ1Y3Qgc3Bp
X3NsYXZlICpzbGF2ZSwNCj4gDQo+ICAJcHJpdi0+aXNfcGFyYWxsZWwgPSBmYWxzZTsNCj4gIAlw
cml2LT5pc19zdGFja2VkID0gZmFsc2U7DQo+IC0Jc2xhdmUtPmZsYWdzICY9IH5TUElfWEZFUl9N
QVNLOw0KPiArCXNsYXZlLT5mbGFncyAmPSB+U1BJX1hGRVJfTE9XRVI7DQo+ICAJc3BpX3JlbGVh
c2VfYnVzKHNsYXZlKTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NwaS96eW5xbXBfZ3FzcGkuYyBiL2RyaXZlcnMvc3BpL3p5bnFtcF9ncXNwaS5jIGluZGV4DQo+
IDFkMTliMjYwNmM1Li40MjUxYmYyOGNkMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvenlu
cW1wX2dxc3BpLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvenlucW1wX2dxc3BpLmMNCj4gQEAgLTg3
MCw4ICs4NzAsOCBAQCBzdGF0aWMgaW50IHp5bnFtcF9xc3BpX2V4ZWNfb3Aoc3RydWN0IHNwaV9z
bGF2ZSAqc2xhdmUsDQo+ICAJcHJpdi0+YnVzID0gMDsNCj4gDQo+ICAJaWYgKHByaXYtPmlzX3Bh
cmFsbGVsKSB7DQo+IC0JCWlmIChzbGF2ZS0+ZmxhZ3MgJiBTUElfWEZFUl9NQVNLKQ0KPiAtCQkJ
cHJpdi0+YnVzID0gKHNsYXZlLT5mbGFncyAmIFNQSV9YRkVSX01BU0spID4+IDg7DQo+ICsJCWlm
IChzbGF2ZS0+ZmxhZ3MgJiBTUElfWEZFUl9MT1dFUikNCj4gKwkJCXByaXYtPmJ1cyA9IDE7DQo+
ICAJCWlmICh6eW5xbXBfcXNwaV91cGRhdGVfc3RyaXBlKG9wKSkNCj4gIAkJCXByaXYtPnN0cmlw
ZSA9IDE7DQo+ICAJfQ0KPiBAQCAtODkwLDcgKzg5MCw3IEBAIHN0YXRpYyBpbnQgenlucW1wX3Fz
cGlfZXhlY19vcChzdHJ1Y3Qgc3BpX3NsYXZlICpzbGF2ZSwNCj4gIAl6eW5xbXBfcXNwaV9jaGlw
c2VsZWN0KHByaXYsIDApOw0KPiANCj4gIAlwcml2LT5pc19wYXJhbGxlbCA9IGZhbHNlOw0KPiAt
CXNsYXZlLT5mbGFncyAmPSB+U1BJX1hGRVJfTUFTSzsNCj4gKwlzbGF2ZS0+ZmxhZ3MgJj0gflNQ
SV9YRkVSX0xPV0VSOw0KPiANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9zcGkuaCBiL2luY2x1ZGUvc3BpLmggaW5kZXggM2E5MmQwMmYyMTUuLjY5NDQ3NzNi
NTk2IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3NwaS5oDQo+ICsrKyBiL2luY2x1ZGUvc3BpLmgN
Cj4gQEAgLTQxLDEyICs0MSw2IEBADQo+ICAjZGVmaW5lIFNQSV8zQllURV9NT0RFIDB4MA0KPiAg
I2RlZmluZSBTUElfNEJZVEVfTU9ERSAweDENCj4gDQo+IC0vKiBTUEkgdHJhbnNmZXIgZmxhZ3Mg
Ki8NCj4gLSNkZWZpbmUgU1BJX1hGRVJfU1RSSVBFCSgxIDw8IDYpDQo+IC0jZGVmaW5lIFNQSV9Y
RkVSX01BU0sJKDMgPDwgOCkNCj4gLSNkZWZpbmUgU1BJX1hGRVJfTE9XRVIJKDEgPDwgOCkNCj4g
LSNkZWZpbmUgU1BJX1hGRVJfVVBQRVIJKDIgPDwgOCkNCj4gLQ0KPiAgLyogTWF4IG5vLiBvZiBD
UyBzdXBwb3J0ZWQgcGVyIHNwaSBkZXZpY2UgKi8NCj4gICNkZWZpbmUgU1BJX0NTX0NOVF9NQVgJ
Mg0KPiANCj4gQEAgLTE2OSw2ICsxNjMsOCBAQCBzdHJ1Y3Qgc3BpX3NsYXZlIHsNCj4gICNkZWZp
bmUgU1BJX1hGRVJfT05DRQkJKFNQSV9YRkVSX0JFR0lOIHwgU1BJX1hGRVJfRU5EKQ0KPiAgI2Rl
ZmluZSBTUElfWEZFUl9VX1BBR0UJCUJJVCg0KQ0KPiAgI2RlZmluZSBTUElfWEZFUl9TVEFDS0VE
CUJJVCg1KQ0KPiArI2RlZmluZSBTUElfWEZFUl9MT1dFUgkJQklUKDYpDQo+ICsNCj4gIAkvKg0K
PiAgCSAqIEZsYWcgaW5kaWNhdGluZyB0aGF0IHRoZSBzcGktY29udHJvbGxlciBoYXMgbXVsdGkg
Y2hpcCBzZWxlY3QNCj4gIAkgKiBjYXBhYmlsaXR5IGFuZCBjYW4gYXNzZXJ0L2RlLWFzc2VydCBt
b3JlIHRoYW4gb25lIGNoaXAgc2VsZWN0DQo+IC0tDQo+IDIuNDUuMg0KDQoNClJldmlld2VkLWJ5
OiBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tDQoN
Cg0KVGhhbmtzDQpWZW5rYXRlc2gNCg==
