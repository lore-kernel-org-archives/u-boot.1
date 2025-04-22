Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB94C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 17:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1BD81F4D;
	Tue, 22 Apr 2025 19:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GnP5MV8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3D3815D1; Tue, 22 Apr 2025 18:18:03 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30AF680FF7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 18:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=harini.katakam@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG+3v3rUAUAf3L+Ml73D7paSfJihU7sXbn0pzUWHQtqeXbxkyVl/qSauJ+FTcJ4W3aZ9xG+O0uu6fu67FGJ5I7JGfsAz3PMmdJyp+eZXKRppvcv0+tfXkReNhOaZyBRYxIkoRukqK3CZBTKaBc7xpSh2MbZevx8N3fuwjVSbJsOj1fUBLM0/0/7sSA39syDVx4kg3jcYJQMgJyOqrOow63jqAeDY2k4AskGD1Li8UJ9ZUPZSJzw/M8B/HbnTHWQ89FUIMy+cqyarYmeAPid0Ov+yB3XsXlroX7LTo3sshoUeZ85qd9r4T5Dmnj9jHxw1k3AJF2xCsZYRYeThftBrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq42FvX37+y2KAiAttAva6mtKpivnMdosutq7OAaFeA=;
 b=mJ6CUFWFjYNussW7VQqfMSbqtNIgIilm8BFkUcmRl3GxqPmp/MtymHV+jey0EBvtXPfHl+bZ7RCKwYLm4Vb/7CqviOVjBDS4qCK0OjVVIH+DIQAtuAiGBKHzJ6zenyyX5dRWROWLnmU/vKknoCuLLvi7KcdyJACdl56G/IsLt/8hs12GNR+RE4S7qkQd2xn0wA1fHtmA4TK+FVE3DRWBqw8gjOFg73hY5gfB59RhdqG4Jmm+JO/HvEsexS8WAVIuZXMd04AOYNEmIAOExUdC17wRD0m6eJNl4WwIezpK2MU8BRcFO6kgkFvH6X7oFr04+sn5zpC5kWxBQPoU5ttDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq42FvX37+y2KAiAttAva6mtKpivnMdosutq7OAaFeA=;
 b=GnP5MV8Zarj+AHdtQVK/KTpw5vTuLheDdpNGQekQ00DyBACh3zv5E4BmBb2uf0ECxYYQeS/RnY2ICo8dLqd6Bb7JtxBLskaHiey9nVGtQfbxMHqnKNl7CHZpv8MAQzWLCJx/g9CKM599DK0gvDxC3b3z4+8PEOjlP4x9RUlY2mg=
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Tue, 22 Apr
 2025 16:17:56 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%3]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 16:17:56 +0000
From: "Katakam, Harini" <harini.katakam@amd.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "Simek, Michal" <michal.simek@amd.com>, "Abbarapu, 
 Venkatesh" <venkatesh.abbarapu@amd.com>
Subject: RE: [PATCH] net: gem: ignore tx_clk if MII is used
Thread-Topic: [PATCH] net: gem: ignore tx_clk if MII is used
Thread-Index: AQHbs6Ia8v5LAhwFF0GMD5wF+Wsbvw==
Date: Tue, 22 Apr 2025 16:17:56 +0000
Message-ID: <SJ2PR12MB87391F3A43374B5C2844CFD09EBB2@SJ2PR12MB8739.namprd12.prod.outlook.com>
References: <20250415150400.136723-1-martin.kaistra@linutronix.de>
In-Reply-To: <20250415150400.136723-1-martin.kaistra@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6f2fcc57-cef0-43e0-a7f9-0863de5b3866;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-22T16:05:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8739:EE_|DS7PR12MB8346:EE_
x-ms-office365-filtering-correlation-id: 7cc215d1-4e5e-4acb-a3f9-08dd81b93e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RG9JL1dmN09hNUt6Z0ZOZTg0L3l0dGdINFRxV3Y2N05WTXEvWndTZ2JpYU1m?=
 =?utf-8?B?Z29SQjZQQ1hrN0xXQXVJZmM2TzhzcmNqdVNsMGo5azgxcHNPYVhRYUR3dEJN?=
 =?utf-8?B?aTRrSUtDdkxlRTVGd3ZIdFFyREdYdkIwZGhocVlVNkNlUUtBSmhoY08vOE0x?=
 =?utf-8?B?bFU5NjRZNjhNTi94c0FjcGJ2aEMrcUZVUnhBdnIxc0hTekJLMHpjdkJ5WUha?=
 =?utf-8?B?YmplVy9RNFR3QzI5MlFJcVptL0pUb3FxZkdKSHZRczBpWHpZNU5Rc0ZTQjlT?=
 =?utf-8?B?c1k2cWN5N0JKV0FxTytKTGM5SHRTdkFDMGozaTl4RDUrNVJJZjMzV2pndzkr?=
 =?utf-8?B?RHlDdUF6TklCcVJzZVBrL3N1VXhFNzFuSXAvM2JabzhJMmVYQkhLeEdhMWE3?=
 =?utf-8?B?ZnVWbjZIY3pNVWhCZm93eTVCZ1l0MWViaGQ3UHRYOHVDeTBjVjdrbDFLd0pi?=
 =?utf-8?B?MUFlWHl1dmxGMFgzUnErclJ6R3hJYUpLT3lwNHZHZENaWVdPK2VJb042N2Fz?=
 =?utf-8?B?OW0xTDJlZStjOWRoRWlnUk9MNVFPbC9SMGQ3VTFFTVJ3RFBYMEh2RFdqamc4?=
 =?utf-8?B?VFIxQkRmNnorcWZiM0JRQU8xeTJPNWJSOGlGV0dRTWVBMVFCOExwOUFwSXN3?=
 =?utf-8?B?anh1TThraWtaUWU0RjF2Qjl3eVhyRUFWOWZqWUJmQ1hwclJNOWxYMDV2MnJr?=
 =?utf-8?B?aloxSmZEaTV0amxUU25YdDRXWXJSenZBK0xDS2xaejVzUDVkTzQrTnY1UE1N?=
 =?utf-8?B?YURJdy9oQVZoRlZOdWJ2WkVTSk1xM0FWNjFZcjZEc0VMb0NWZkdFS1dmSEg1?=
 =?utf-8?B?RFhCaEgvS3Jzcm5abWxsSTdDTll3ZDlrOFdkbjRXWlJ6bkQyTEt3NjFGU1Ni?=
 =?utf-8?B?elhTM3BzckE4SzRvYXkvb3lzS1VBWTlQZHlaWUc4eC9HQTVxY1c0dWJySjdD?=
 =?utf-8?B?QXQwVVVGbGk5cWh1TS81TVNhSkV4bEF4V0szRGdQeWwwN3E1MDFla2tLNjRM?=
 =?utf-8?B?NnVGalJzWk51VUVXY1cvYTBKaU5oQmFsWjBkdGw5bU9xN1Zadkt1TzMvUVBK?=
 =?utf-8?B?bUJSL3ZSRU5Bem8yUVVtYzVuRFB3cmNjYzFobHN5VytRaVpMcE9iZHM3K1Vr?=
 =?utf-8?B?d3VlZ1RwNTlPQWVldFBYNThLU2pPWUJSK2p5NTE3ZXUrZ1hERDBtSTN6RjNZ?=
 =?utf-8?B?U250OC9mNzEySmN4cm05K0Qyd0dQSTVpMnJHZjFKQ2tJS2p1WWg1dmlYa2NT?=
 =?utf-8?B?cldYY05WZkI0RUNaUEFYVFdCaWtlSzJJYWhiUnJnbUlpWk5mTVBteFhYRXlQ?=
 =?utf-8?B?bUN6UWpqcHQ1TWl3QXg3eEdTVTdoQXUxTGpJNW1DYkZlQ0JkTDJDbC9DbXZK?=
 =?utf-8?B?QmwwMkFkS3VZR0d6cTVQbnk4YkMyaU1PVHdkTWgwVHVLUUFrT2hsREF5RHNB?=
 =?utf-8?B?a2lpc053R25kOFNMS0xuUHRTMy9zblVFbDBOaXdHaEFzbndQa1ZkSmFVVCt3?=
 =?utf-8?B?US9mRXZ2enVTaDFiTWc5RTJQWGtTbjhUdTc0dE0yYWN5YXk4NldoQ3BoalVp?=
 =?utf-8?B?Y25JcUdwdEhERGJGRWxkSUdTUlp2QjdyQXBOZ1NYRHR2bHJ6UGMvSWVDQjcr?=
 =?utf-8?B?VnhLM2s3enN2M21LeXNWVE1MM2pNeTN6YzZibkhtN093ZEpHS0g1bE1Id0g0?=
 =?utf-8?B?N1k4RUU2VGs2KzlpR2gxb054T3J4emxXekdiSXVjazJZTWZ4Q09pRm5OZGkw?=
 =?utf-8?B?VExXNWF2a0RraU5lZ2hOQ1N4TTV2UDJJenczQld2YnhSOGYyaFl2TSs4bDhk?=
 =?utf-8?B?dFJBZnBTVExPR0p5KzQrM1BEY2ZJYWZuQnZpN1BCUWhDWlFOU2lUc0F0eG5N?=
 =?utf-8?B?eXhuSW1XbnlYM2JEcmZ2NTZDTXRSRE9tODZWZnZ6ZzZzUFdLd3JHMjlHcXFa?=
 =?utf-8?B?bUhlZnJXR0JKK1VseFJoekVXWTJJNisrS0ZsdkR1SE1wODJ6OUc5VUUrTzJq?=
 =?utf-8?B?L2hWOEZPcDNnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlY2dEtJMHZBd3FxdVFxS1BGc0k2VWppeGlUOEluQWZTK3BvRUhid1FwSnZ2?=
 =?utf-8?B?RDMrTUdoSFF0SVRXeHdhVFpHWmpOdGtKSld0NnczeUpqUXZQWGdVdjNvbXFL?=
 =?utf-8?B?OTdZTVZYcU0wUDNXV0NBNzVHekdkNUlyZ0xGZDE1VG9tN1M2VVdBSjlQRjdI?=
 =?utf-8?B?V1hlOXY4ZzE5d3R6RUIxOWNXMS90Umx6MHA4Qkx6K1R2SmtmM0pGMkorWmtF?=
 =?utf-8?B?ZVd2THBvS3B6azEwVHI0c3lzVVBxbER1WnNCNHByRjRrNW5wdnBTbnY3U3Jh?=
 =?utf-8?B?WWZYVkEzb1JiQUUzMGZ2eTgreXBmdzYxbWJGRkdqaVp5R1RNZmJKVGtzOERY?=
 =?utf-8?B?U0UvZHlvVnNzUVp0eG9tM2MyRStVTE1NL0RzYmYrZW1wMm4raXFJU3VmSGpX?=
 =?utf-8?B?UnBZV3UxVzJvZHdZeHp3SU9UZzdjUHQxUFNOZjlIOW1KZG9MSG4rTk80bkpl?=
 =?utf-8?B?ZEN6ckZ3WGY1VUtFRXFGSFZEK2Y2VW9aTy9SOWZOa3ZZa2R3RzNTRmhJTlVh?=
 =?utf-8?B?MitIcUxlRE1tYWpSYng5QWs4NnFlK21zZENMMjUvK2hkOEpyc1VJZ2ZLZlpl?=
 =?utf-8?B?UDFqUVlwd1NBZXZuazVwWUhDL0lxNUdRSGN5UjU2R1FldnJvbk04bHcvc2Vw?=
 =?utf-8?B?VTRTOXJBaHY5RGo5K3pxV2ZlSUVSdjljL2d5R294OE5qS3BaUGk5ODFhU29D?=
 =?utf-8?B?MmRQK0VPKy9hU3FEUkZ4S2xiQk1qc0lIajBVZmUzd1ZjVUJRU0xpclJnNUp5?=
 =?utf-8?B?NmFUbHg0ZDNBR1F1eXVza1lmbG5xVGlkK1l6YUpXT1QzU2pDL2ZqUHlmQjdY?=
 =?utf-8?B?d2lSMGJFa1luaUZ5SVZvbWNrMWgrUStBUE10TVJpT1RoZ3lMNFZFRUNYWVBP?=
 =?utf-8?B?aTJ1U0RyeVBwNytxNzhXcitsY0xUVzNuRE9UMDBtUkdvRmlEZjV0cTlURHc0?=
 =?utf-8?B?RUQ3Y29sMnJYVHhVdWFJcjNRbGk3NFloeENlUGNTRmhPS2J1MmV0NG4rZzVQ?=
 =?utf-8?B?c25ub2NwRUZSQWhiT0cycVpkUEFOT3hKQ0pHbDVUN0daZ1Nwd0ZaNUh5T24z?=
 =?utf-8?B?UnZtSEVJT21aN09UaDVRclR3U2Z1N1lsY2pYZk5QZzkwdFJrQW5HMUVRZlU2?=
 =?utf-8?B?bDlRUENhQVpKRUxURmV4ZXVDWWJJY1E0a3FNUmRkWlZLK3dpYm5UcnZ2L3RP?=
 =?utf-8?B?Zk1Od3FMK3RaSXBEZ0JDdGl4T0V3N3FScUs0M1RjNXhKdWFQK0Q1bEE3Nyts?=
 =?utf-8?B?T3U5WXFoRVVGWWxsSTVpR1BDV1RSUFRVMDhjUTZPK3JBdVV3OFdiM0QxMnlG?=
 =?utf-8?B?NFZOWERKTW0wUlp3OHZabGl1TVVqZXZjd2szcjRvd2pTYlZvdXpLQ2ZxcEt4?=
 =?utf-8?B?OGZWWnp5dFM3eFpKUlpRWUN1S29TcjZrZnFSWVlDWHRnYWUrQVZBNCs2c2or?=
 =?utf-8?B?WWUvd0tQTkZLeGtSZlhkOHhacjcyakJXQWZ6UlQ1dFdTWTE1VlNQT3pZYmpw?=
 =?utf-8?B?TlNqTERDaHJmejNqcUZ4elpxZEpoR0ptMENqbXlROHBuUVFRVlI5YUlYOXR3?=
 =?utf-8?B?VVdQUE1rRnFlQStQS3dPdjFNMTcrNlVCb0dqUzJGWTFLelRtUTRWK2J5Tlky?=
 =?utf-8?B?L2YzV2dTNlMvQm05VWtzY2dFMmR4TEpIVndDZm9YUUZ0NlpYMFN1MktJR1hJ?=
 =?utf-8?B?YzVMRlFxanVMQnFadmJDNmtrR05jaXo5UjFJVnhreCt1bm1PcW42b2xtVmx2?=
 =?utf-8?B?SWNuRm5DbzhieTZIZDB0Q0djbVQyTFdHZ1RjYUlxSys0ODdPaW5UNno0dnZ2?=
 =?utf-8?B?U3FyQW10K0I5M0Zmbmp2V3VGZ1VPQndYTnliQW1Rem9nd3U4elcybTJKOU5h?=
 =?utf-8?B?ZlpqdFQrRjZBcTNId2xaNEY2YXZaaTY4UHYyZGNBV01iMnRzQmdJeit5UWFp?=
 =?utf-8?B?Z1RUbVdrVjdFZXNORGg1Z2VaZXAzSHhxQXo4MDIzSWtLa2VNTzhLaXl3amlt?=
 =?utf-8?B?UURYL0tyWnRoM0xNY2tYMG1FemJDN0dqWUdpZ082WTVJTERIZzIvU21ERkJW?=
 =?utf-8?B?ck4yUWtwelBWQmhRUU8xVzljV09BSld0UXk2VitHd2NubEQ5Wm01V3dxTXhS?=
 =?utf-8?Q?FEdc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc215d1-4e5e-4acb-a3f9-08dd81b93e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 16:17:56.6651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3r91W7BwIxHQfxLoRFlC2mMb6h9//I5DkkIIBY1dk4nO/KaHONNvsoW5XpPsz60Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
X-Mailman-Approved-At: Tue, 22 Apr 2025 19:29:01 +0200
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFydGluDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVS1C
b290IDx1LWJvb3QtYm91bmNlc0BsaXN0cy5kZW54LmRlPiBPbiBCZWhhbGYgT2YgTWFydGluIEth
aXN0cmENCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTUsIDIwMjUgODozNCBQTQ0KPiBUbzogdS1i
b290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IGpvZS5oZXJzaGJlcmdlckBuaS5jb207IHJmcmllZC5k
ZXZAZ21haWwuY29tOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIXSBuZXQ6IGdlbTogaWdub3JlIHR4X2NsayBpZiBNSUkgaXMgdXNlZA0K
Pg0KPiBJZiB0aGUgTUlJIGludGVyZmFjZSBpcyB1c2VkLCB0aGUgUEhZIGlzIHRoZSBjbG9jayBt
YXN0ZXIsIHRodXMgZG9uJ3Qgc2V0IHRoZSBjbG9jaw0KDQpDYW4geW91IHBsZWFzZSBkZXNjcmli
ZSB5b3VyIEhXIGNvbmZpZ3VyYXRpb24/DQpCYXNlZCBvbiB0aGUgc3BlYywNCjEuIEluIDEwLzEw
MCBHTUlJIG1vZGUsIHR4X2NsayB3aWxsIHJ1biBhdCBlaXRoZXIgMi41IE1IeiBvciAyNSBNSHog
YXMNCmRldGVybWluZWQgYnkgdGhlIGV4dGVybmFsIFBIWSBNSUkgY2xvY2sgaW5wdXQuDQoyLiBX
aGVuIHVzaW5nIGdpZ2FiaXQgbW9kZSwgdGhlIHRyYW5zbWl0IGNsb2NrIG11c3QgYmUgc291cmNl
ZCBmcm9tIGENCjEyNSBNSHogcmVmZXJlbmNlIGNsb2NrLg0KMy4gSW4gUk1JSSBtb2RlLCB0eF9j
bGsgc2hvdWxkIGJlIGNvbm5lY3RlZCB0byB0aGUgcm1paV90eF9jbGsgb3V0cHV0cy4NCkluIGJv
dGggY2FzZXMgMiBhbmQgMywgdGhlIE1BQyBpcyB0aGUgY2xvY2sgbWFzdGVyLg0KDQpJZiB5b3Ug
YXJlIHVzaW5nIGEgSFcgY29ubmVjdGlvbiBzdWNoIGFzIFp5bnE6DQpQUyBHRU0gLSBHTUlJIHRv
IFJHTUlJL1NHTUlJIHNoaW0gLSBFeHRlcm5hbCBQSFksDQp0aGVuIHRoZSBJIHVuZGVyc3RhbmQg
dGhhdCB5b3UnbGwgZ2V0IHN1Y2ggYW4gZXJyb3IgbWVzc2FnZSBhbmQgdGhhdCBzaG91bGQNCmJl
IHJlbW92ZWQuIEJ1dCBJJ20gbm90IHN1cmUgaWYgdGhpcyBhcHBsaWVzIHRvIE1JSSB0eXBlLg0K
DQpSZWdhcmRzLA0KSGFyaW5pDQoNCj4gcmF0ZS4gT24gWnlucS03MDAwLCB0aGlzIHdpbGwgcHJl
dmVudCB0aGUgZm9sbG93aW5nDQo+IGVycm9yOg0KPiAgIHp5bnFfZ2VtIGV0aGVybmV0QGUwMDBi
MDAwOiBmYWlsZWQgdG8gc2V0IHR4IGNsb2NrIHJhdGUgMjUwMDAwMDANCj4NCj4gU2lnbmVkLW9m
Zi1ieTogTWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IC0t
LQ0KPiAgZHJpdmVycy9uZXQvenlucV9nZW0uYyB8IDE0ICsrKysrKysrLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvenlucV9nZW0uYyBiL2RyaXZlcnMvbmV0L3p5bnFfZ2VtLmMgaW5k
ZXgNCj4gNDYxODA1YWU1M2YuLjcwM2UyMjQ3OWQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC96eW5xX2dlbS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3p5bnFfZ2VtLmMNCj4gQEAgLTU2Nywx
MiArNTY3LDE0IEBAIHN0YXRpYyBpbnQgenlucV9nZW1faW5pdChzdHJ1Y3QgdWRldmljZSAqZGV2
KQ0KPiAgICAgICB9DQo+ICAjZW5kaWYNCj4NCj4gLSAgICAgcmV0ID0gY2xrX2dldF9yYXRlKCZw
cml2LT50eF9jbGspOw0KPiAtICAgICBpZiAocmV0ICE9IGNsa19yYXRlKSB7DQo+IC0gICAgICAg
ICAgICAgcmV0ID0gY2xrX3NldF9yYXRlKCZwcml2LT50eF9jbGssIGNsa19yYXRlKTsNCj4gLSAg
ICAgICAgICAgICBpZiAoSVNfRVJSX1ZBTFVFKHJldCkpIHsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHNldCB0eCBjbG9jayByYXRlICVsZFxuIiwgY2xr
X3JhdGUpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICAgaWYg
KHByaXYtPmludGVyZmFjZSAhPSBQSFlfSU5URVJGQUNFX01PREVfTUlJKSB7DQo+ICsgICAgICAg
ICAgICAgcmV0ID0gY2xrX2dldF9yYXRlKCZwcml2LT50eF9jbGspOw0KPiArICAgICAgICAgICAg
IGlmIChyZXQgIT0gY2xrX3JhdGUpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IGNs
a19zZXRfcmF0ZSgmcHJpdi0+dHhfY2xrLCBjbGtfcmF0ZSk7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICBpZiAoSVNfRVJSX1ZBTFVFKHJldCkpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQgdG8gc2V0IHR4IGNsb2NrIHJhdGUgJWxkXG4iLA0K
PiBjbGtfcmF0ZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+ICsgICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICB9
DQo+DQo+IC0tDQo+IDIuMzkuNQ0KDQo=
