Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A95C28B30
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 05:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287F981E13;
	Wed, 26 Mar 2025 06:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YiEv9Nw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F208186D; Wed, 26 Mar 2025 03:29:13 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D71800C1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 03:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXnjg41gqBlHuHSel8Qwvwl+at5k237nmBr75ENpMocMFfpIQDdJOCF4krzyZrX1rKQxwSdds6svFyUMuUILaseWE2wb3oZtS6u/SUM63RuKTSF5TUzgtn/kUDrd/4yd0e2JWmd23h7hcJ0haDqkfPbIm79C+8DF9EbaOPyRhgt4nNp6JgqpLZpUdkKxgc9LF/vEPakT6Bb9AuuxbrAfjV++IMn99UPuDXp+5FFyyHh9RsqohCV1tEVkeLnaSZVWe8M3xRkVtgNmQ+ZrhdHWV4vLFfH5QeqJ1KfrMMhKxEN2Rh4jwPbD5B7mFWJwl9cxyNFRGL24QFsN4gMWyKDTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6PDb+UKNTI+qFLdr0+HN3YGNIc3EGis/F1+uQ+dNsE=;
 b=K5t163s5vHRTp9hkCD8v9karFBjnM6AaOoslkhAii+dEmeqgkS2CdZv/76PJyQGL1gWINOoXtGeLFLxIht9//gOgXALaine35bauCqBGhYlAoOAOX0FGVy1wdgH6rofWknIoM9vNIUQ42Zwq+NxlQjBdxBy1Vtbm4aCBx80esST8aM/Afx/Z8xEUv1YOiCae4tBjgWMKLWSGw8xFLrplOxSqHJGqINsoTMvKSClv1OwVshwf9c2GqpXyHEp+4LMgCxZpo8cmen62koab1k6L8i8PZ229Bsa3b8tPNRv197QEHs/CjFUlCMxX2b1HKet0SV8c9t6nWltklT+4GHjEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6PDb+UKNTI+qFLdr0+HN3YGNIc3EGis/F1+uQ+dNsE=;
 b=YiEv9Nw8sYiT/ZwTYN3XSp/mH7Ma5Od8KfoBZRPyqvA4cmBTH0dSHtfIVpqr7baum5aoklbrl6fPpRHqM9Qqu+PZsqz63bZ9XMNLLz+XmaogrUBjQkN8Y/jvmhz9qGo4Yim4ma0BvRr3m+xniIQLmcBuoFZome6Oy2R2/S1r7kAz0QC6ea9E31o7XqW0zWtb6Oh2bPZZN7BLOyhNl0iuvUWDZOO/yVgoVvRsP7MFsC5ngY7MUElbq0pvKpIvKySKGFmGDYoIjlqXqNgBfeoh2Scew/RGs5CudMqmjetOOX+gtNr7lUL54E+LgKN0X+aG2f5f33gQebqYssTNyHyhXA==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by VI0PR04MB10210.eurprd04.prod.outlook.com (2603:10a6:800:245::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 02:29:09 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 02:29:09 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron
 eMMC BOOT/RPMB hardware partition resizing
Thread-Topic: [EXT] Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron
 eMMC BOOT/RPMB hardware partition resizing
Thread-Index: AQHbnV/gFBShsiYKmEGsQ+YpxPjl/LOD6G6AgADG34CAAAHAAIAAAJmw
Date: Wed, 26 Mar 2025 02:29:09 +0000
Message-ID: <DU2PR04MB85673973C0F9A3AAE8526E68EDA62@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250325082914.2240470-1-ziniu.wang_1@nxp.com>
 <5005e7ba-1b9a-4d49-9cd6-d48a8341e436@mailbox.org>
 <DU2PR04MB8567774A082F1734BB3703D2EDA62@DU2PR04MB8567.eurprd04.prod.outlook.com>
 <86f01206-563c-43f0-84c0-a23c03302485@mailbox.org>
In-Reply-To: <86f01206-563c-43f0-84c0-a23c03302485@mailbox.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|VI0PR04MB10210:EE_
x-ms-office365-filtering-correlation-id: b047d288-750f-4f74-c5ec-08dd6c0dfcfc
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b2xpRFNSTWJvTE5BNWNFK1hvWFhZcm9ka2U2cFpFTk9rb0NjRGl2d1dSVlZz?=
 =?utf-8?B?K2xqWnBJKzN3MHoxZFYwOHgyWWNCTWJOSU9xaW1zUGVLWTBBdVh4ekI2ME9k?=
 =?utf-8?B?RzI4Zk5SNEZERUFOTEFadnlFaHQ4ZjVHbjA5QWw2anBwRytORmlsUU83azNB?=
 =?utf-8?B?a2JFQlIvQW52c3d5blhQN09UemdpTmh6d21MOG9hSGRWQjd1UWI5SkZNMUZp?=
 =?utf-8?B?eVlhTnluNjVNWlVCNTQyOW9sb0ttd0lJVTkvQXg0TXQ3WjVCTzduWElYSCtX?=
 =?utf-8?B?cGpBV0ZVUEg1NGNBR1c0ejdaMTMrY0wzZDJ2OU14K3ZKRU9TMFVYbEF3cmV3?=
 =?utf-8?B?Mlk1R0cxdkhBSWQyRFpiQU5GT2xuRDBxVnJlLzEwSUF4TmJiT0RDQmNOeU4r?=
 =?utf-8?B?dUVnQlQ3WHNEWjZYUlM0VjBzQ1p2andPc1FHdFJsOFl5MDNtY1BCeWFJM2Jj?=
 =?utf-8?B?RjZKM0J6UWpWdVBoK1Byd1dRWlZOSURHKzZPOVZHMXVzOHZoL1c2MzJlWXhU?=
 =?utf-8?B?Q3ZYb3pJc3NRdVkyTldjM1RyRWJtbkRjZ1lhb0xackh3UmdYWENpZThIL0pm?=
 =?utf-8?B?Z0hTK3E5OEZRUzBuMzNMY1NxbE5Od0c2VGErUnBkNHpNU2NncDhjS1pYWDBZ?=
 =?utf-8?B?UURCdmxONlIvWVFscVAxV3NNWVhlaWpzR0xKelBBOXVpY2xyWjM2VEM2b2J5?=
 =?utf-8?B?K0Y0eFYzY0xJNCtqQ2hybE5icnZwUDNxNXk5aWNLMkpneitVZE83WDd3Q1VZ?=
 =?utf-8?B?NWZLYkl3TDhxYWdDdlh5Sy9ORWlJWXJ6VGtJL0dFa0NXd0kxeU14eS9mUzNa?=
 =?utf-8?B?ekprNWdCOEFSbFgxV2hxTlZNV1QrK1NyMnZYMEZBZ1IvaS9uWk93ZHhqSWtZ?=
 =?utf-8?B?NjI2VFpKZmpnalJEMm96Z3JxWUx1aFJGRFNKK0x6U0lwdXNRZStUaExwOVNi?=
 =?utf-8?B?QVl0YklOSHZocGkzekdEa0N4Ym15QmZwMDZpRXBYVmlFYlpKQzBmdzFVb3JP?=
 =?utf-8?B?ejlTenhoRjJKOVBuNW13blJuZzM3clRObVN4cG9BSGl4eW9FMEJ3aGZYT1hK?=
 =?utf-8?B?d0ZrUmpSRm5Cc3NMOTBRYXd4elNveHpSWkNNbktrTWFRZXE0SFF1RFk2L3lV?=
 =?utf-8?B?QWlYa2R5NnZITngvaHhIRU50YWhORHV3clU1LzRWTHFMbTFNSHJvRUJiOGht?=
 =?utf-8?B?bGRKYnJjN3dMdjFqSmNuQ2hYVlM5OVo4UG1xeVp2aHNIc1JPc1NVME9vNVdh?=
 =?utf-8?B?UUFQUktGZGFGVkZ4NWU4NGJ6VC9IR3VicGhBYjdsQTJTS3hiVVdNNWt4SUh1?=
 =?utf-8?B?MGlDWjRqZlM5YlBrcmVUNUxhR3BLM29BcWFnTXA5SnFOY090T3pEN2U3N1g5?=
 =?utf-8?B?cEM0NnptMTFIZ09qR2MzaGdpbjlZdno5a2pZc1JXL2Fzd0l3YjZUTmw3Wnhm?=
 =?utf-8?B?VDdDTDdmajI4WmJOeno1QW9UalFxOEU5eTlRYlY4Nm1MWjdia3BTMjUwN2Vp?=
 =?utf-8?B?TDgweHJLakphTDFtaTYwdTNuN1Q0Q1NXaE5UQWtjR1N6a25lQXNXSVp6Y2dD?=
 =?utf-8?B?dlFIaEhZeU5UT2JrQXJZM0FHU3lrRFV1RW5CcmkyNkdmRGI3TVh4YjhaMG80?=
 =?utf-8?B?czBENFBtSENRaWszT2tDUCtISHJ1NUZqbmF2T3RGYXlpQXlpMVoxNTBHUE10?=
 =?utf-8?B?ZUh3N3ZzYWJSbWlvRndMVzJqaSsyN0FDWWJDT3JDYk8zaEdISk91eWp0cDZy?=
 =?utf-8?B?QzBJVURTeDgwdys1d3hUNTEzc1VQSytJU014a2dmK3dwQUg3Q1Z5QmNSUHZt?=
 =?utf-8?B?Z3h1emFKeWlEMUxick5uUGsrbHRIMWNwVWF3WEdnQ3lRK1FvVnh5K2RsbzdK?=
 =?utf-8?B?OXdlanlWbGpsRnVxQVhPcnVtSVdDZFU0Z2ZjYjcwcVBmYkppbzAwdE1uZGc2?=
 =?utf-8?Q?ylHeydfjnDmwc0wCiUVW+US7wZ3lpsvl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkwrcU1qRk9VMWQrNkRmR1ljSnNQY3dCT0IvanY0d0FJTSt6SWF3RW80ekZz?=
 =?utf-8?B?a2hFSS96QVZ6V1llN2ZJTWRSa0d0ai9qbjlxRkRwcGhtRjd0UFArVFVoenIy?=
 =?utf-8?B?RmJQb2dkYzZyaVJ0M1Y5S0JVVHJwV0FtWHduT3dwNVh3THJHRG5WUkpNUWlQ?=
 =?utf-8?B?eW4vZjJMYStIU21kNTBHdWE0WFlBeGtQS0lZek9PZ0ZOeTZLcGRrZzRsT2FF?=
 =?utf-8?B?NHQxSlBBU0h3N3pTTlRJQ2dkYllpUW9XdVNtbnovNStrTVFZWU5jQUVjK0l5?=
 =?utf-8?B?dmRsR3lsK1BQMEZBbG83a2JXUkJTQVBoOWgrOWpxOEplUUtibnZLNlZSaFFt?=
 =?utf-8?B?S05RM0gwMWVlbFBlUTY1OGl1NnhhZjBKL0pHdXZiTFVDQXF2NlN6dFZkZ1U3?=
 =?utf-8?B?MFJvN1NDVm5BZ3BKRW1kZGpwMGFNVGFMTlBaWjJqd3QvMDdxRGNXVmJBYnNU?=
 =?utf-8?B?eHV6VE5nUVpmNE5mZ084dVZJeEY1a3Z1b1BkOGpNRDN3RWpncEVBOFhneDly?=
 =?utf-8?B?Rm5DVmE4eUJDNThyNVhBSmdWWTlUczQwNm5OUTBXMkhrNE9RYWQ1K1ZqcnFv?=
 =?utf-8?B?dDdpQWRSSnFjTHVSczZsNk1mRXpHOE1tVWc4Y3VaSGliK0pEUlA3WjhaQWxJ?=
 =?utf-8?B?cGxlRkVsUklMQVhrZitCSTNrbmFxM1VSR3dWTzd5d3lkNWhtUU5Xb3dpOFpw?=
 =?utf-8?B?M01QeFI5ell2MjZOcXAxTzczUGdkZkEySngyLzM0amVwTnBMUlZIUUNiSWkx?=
 =?utf-8?B?S21NVHA2bU1OZG5KQzN0TFc0eFh2ZTRCUVVMQTd6WkRxVjZ0ZGZSMjh4Tmto?=
 =?utf-8?B?bUtpTUF6amZRcWJTSTgrNm9ROG1ock1OblRNenlvcE9sd3BqWS9XUVQrZmVx?=
 =?utf-8?B?YkN0Y0VqeW1DTFlKTFlaVFJjUUtRRWNteUlWNHk2dlpIRmdUd1FkR1NWRWZE?=
 =?utf-8?B?aUgxTmFRRmdobjY0ZEZ0M0lndFlZOXhXN3dUYjNMQUZaVmsvdUVHeXphdGhh?=
 =?utf-8?B?QWJuSVBERVJTa0o3cm1zNHQ5MXhrNlhqQ3o3RDA3ZDdqT3dHOVlOZVllMkxK?=
 =?utf-8?B?TzFsSU10c1NNN2lJbDhqTFZoSGg1WFl1THk4eUo4cXB1MXpjOUtjdDRieG9G?=
 =?utf-8?B?ZFEwV2RIMDJzL2c3NmdFaHIzRmpXYk84TDZEWkF5d2pHWE5BV0hlVGpxYnVT?=
 =?utf-8?B?eldBQzUwWE1Tdml1WlVwMTYvMTd4WlBVVjJyMmhRM3JGdmxYdldoeVB5bFdD?=
 =?utf-8?B?dXRPZkhTVEdrMjhSQ2FBdi9ia1ZPMUloanJ3a1pKc052eHBDYTlIOURsT0Jm?=
 =?utf-8?B?L05Xa3BFcmJiTHdtL0djYXh3UGV6QXF5WW8vT3ZRalh6bWJOOFJHRFEzdnYv?=
 =?utf-8?B?cXNJSVJQb1laYVhtLzFhOEhIQVkvTytEUnNQZVQyY0QrbWpwM01LOUNXQnpy?=
 =?utf-8?B?eTZNUER2b3pWc3RGcngwZDBDNFdaTElrWkFObXA3bGpweWRNVnY5b3lwQUky?=
 =?utf-8?B?MmZWR21WMklRNGpGeFB1c1RQVGV4ZStkNkFhemdJcGs2VmZaVFphTVdrWjBz?=
 =?utf-8?B?V1dwZ0NiMTdzWEZXWlI0ZVpLZEpmNmlOelMyMjUxcTlxL2hkQVd5T0RITkM5?=
 =?utf-8?B?VHRxRUxYZ3VMeHcrN3hrYU9HZWFKajlmNnBEazhnNTNFOXBsOWRod1YzUE5O?=
 =?utf-8?B?U3gyc1JPdVo0Wlc1WWlWckpHQm12aDU0cXJFb0Z2UFZoNW9LL0JrTURjTlFG?=
 =?utf-8?B?b1ZLdHlnNmZDd3JIOFlTbnd2ajM3MGJIQUtSYjFaUFZXMGNleVJWRmFubFI4?=
 =?utf-8?B?emV1TFM3VWxRbzg3TXVJM0xGa1pGOG9Wdm9Jd1B5RU95WW9zRlgrREtkVk92?=
 =?utf-8?B?Q0RoZXpwb0N1RWRVTU9PcHh5R1pnc0FnMHJkZ0x0TGFSaDNpUll0RE1GNWUy?=
 =?utf-8?B?NVEycHVtVVV3WjNJZWlLU2JHMnBzUEMxNDhaa2ZPZGhrNk1uQTV0MWVaUFEz?=
 =?utf-8?B?ZThNTHg5OWxBaHBraG5zMm13ckN6U1F5SFYxd1RQdXlLOEpxYnk1ZC85ZVhn?=
 =?utf-8?B?cmpIblErWFBsb1Q1Smp2UFp0a0RYWHRKRjJZR2xmdzhWRVNNMUl1eVhMekFG?=
 =?utf-8?Q?uOZYNCdk/Au40LQh8cid4RLm7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b047d288-750f-4f74-c5ec-08dd6c0dfcfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 02:29:09.1122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aa4oUBLW//I8UrpiN+wHAizvSSSEzyxtpd8Dm5L+xMGDOsyAznigro4UYz/KrSubhM+/qzQZ5H7tF8ylPIIzKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10210
X-Mailman-Approved-At: Wed, 26 Mar 2025 06:01:30 +0100
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI2LCAyMDI1
IDEwOjIyIEFNDQo+IFRvOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPjsgUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiBqaDgwLmNodW5nQHNhbXN1bmcuY29tOyB0cmluaUBr
b25zdWxrby5jb20NCj4gQ2M6IHBicm9iaW5zb25AZ21haWwuY29tOyBtYXJlay52YXN1dCtyZW5l
c2FzQG1haWxib3gub3JnOw0KPiB0aGFydmV5QGdhdGV3b3Jrcy5jb207IGpvbmFzQGt3aWJvby5z
ZTsgc2pnQGNocm9taXVtLm9yZzsgdS0NCj4gYm9vdEBsaXN0cy5kZW54LmRlDQo+IFN1YmplY3Q6
IFJlOiBbRVhUXSBSZTogW1BBVENIIHYzXSBtbWM6IG1tY19ib290OiBTdXBwb3J0IFNhbmRpc2sg
YW5kDQo+IE1pY3JvbiBlTU1DIEJPT1QvUlBNQiBoYXJkd2FyZSBwYXJ0aXRpb24gcmVzaXppbmcN
Cj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNh
cmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGlu
IGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFp
bCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMy8yNi8yNSAzOjIwIEFNLCBMdWtlIFdhbmcgd3JvdGU6
DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBN
YXJlayBWYXN1dCA8bWFyZWsudmFzdXRAbWFpbGJveC5vcmc+DQo+ID4+IFNlbnQ6IFR1ZXNkYXks
IE1hcmNoIDI1LCAyMDI1IDEwOjI0IFBNDQo+ID4+IFRvOiBMdWtlIFdhbmcgPHppbml1Lndhbmdf
MUBueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiA+PiBqaDgwLmNodW5n
QHNhbXN1bmcuY29tOyB0cmluaUBrb25zdWxrby5jb20NCj4gPj4gQ2M6IHBicm9iaW5zb25AZ21h
aWwuY29tOyBtYXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnOw0KPiA+PiB0aGFydmV5QGdh
dGV3b3Jrcy5jb207IGpvbmFzQGt3aWJvby5zZTsgc2pnQGNocm9taXVtLm9yZzsgdS0NCj4gPj4g
Ym9vdEBsaXN0cy5kZW54LmRlDQo+ID4+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjNdIG1t
YzogbW1jX2Jvb3Q6IFN1cHBvcnQgU2FuZGlzayBhbmQNCj4gTWljcm9uDQo+ID4+IGVNTUMgQk9P
VC9SUE1CIGhhcmR3YXJlIHBhcnRpdGlvbiByZXNpemluZw0KPiA+Pg0KPiA+PiBDYXV0aW9uOiBU
aGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcg
bGlua3Mgb3INCj4gPj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0
IHRoZSBtZXNzYWdlIHVzaW5nIHRoZQ0KPiAnUmVwb3J0DQo+ID4+IHRoaXMgZW1haWwnIGJ1dHRv
bg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAzLzI1LzI1IDk6MjkgQU0sIHppbml1LndhbmdfMUBueHAu
Y29tIHdyb3RlOg0KPiA+Pj4gRnJvbTogTHVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT4N
Cj4gPj4+DQo+ID4+PiBDdXJyZW50IG1tYyBib290cGFydC1yZXNpemUgY29tbWFuZCBvbmx5IHN1
cHBvcnQgU2Ftc3VuZyBlTU1DDQo+ID4+IEJPT1QvUlBNQg0KPiA+Pj4gaGFyZHdhcmUgcGFydGl0
aW9uIHJlc2l6aW5nLiBBZGQgU2FuZGlzayBhbmQgTWljcm9uIGVNTUMgQk9PVC9SUE1CDQo+ID4+
IGhhcmR3YXJlDQo+ID4+PiBwYXJ0aXRpb24gcmVzaXppbmcgc3VwcG9ydC4gVGhlIGNvbW1hbmRz
IGFuZCBwYXJhbWV0ZXJzIGZvciByZXNpemluZw0KPiA+Pj4gcGFydGl0aW9ucyBhcmUgZGlmZmVy
ZW50IGZvciBlYWNoIG1hbnVmYWN0dXJlci4gU2VsZWN0IHRoZSBjb3JyZXNwb25kaW5nDQo+ID4+
PiBmdW5jdGlvbiBhY2NvcmRpbmcgdG8gQ0lELg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6
IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+ID4+IEkgdGhpbmsgeW91IG1pc3Nl
ZCBwaWNraW5nIHVwIFBlbmcncyBSQiBmcm9tIFYyID8NCj4gPg0KPiA+IFNvcnJ5LCBJIG1pc3Mg
UGVuZydzIFJCLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiBOZXh0IHRpbWUsIGl0IHdvdWxkIGJlIGJldHRlciB0byB3YWl0IGZvciBQZW5nIHRv
IGFkZCB0aGVpciBSQiBhZ2FpbiwNCj4gcmF0aGVyIHRoYW4gYWRkaW5nIGl0IHlvdXJzZWxmLg0K
DQpPaCwgSSB1bmRlcnN0YW5kLg0KDQpUaGFua3MgYWdhaW4sDQpMdWtlDQo=
