Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1C6CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC88C83ABF;
	Mon, 10 Nov 2025 21:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HjmIUfmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A4583ACA; Mon, 10 Nov 2025 21:46:43 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B2A83AB8
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zT10L8oF56+RhBodXBufSVQs9B8o7vXHTgRVqYkii6jKOCZ/fASeA/cY600He6hwSoQdDJEtfpY1ItM06fD0zCNkSqrN4xsswLOI/Vtk3pjjLUuTTV8s+Oy2nzeDxqlzeIHgLlf0AWEqQLmQyTj0UHl2ip/YEMWz51JNoZ+JgE/3UCGvMMdHdaRs+uPCyuT7G2fsx1hscND/jK5HcIdIHJBbnzlSiwHo8fTkH5j76Q/o9T5P15CwuhTKSvagy6vPfylcnVw7PFZ1RlXJZYSbQTu7iffux2vdN0W+gVT15ZKFO5bRB+dDvRYHdj0a0fOEyLdwTnR/ym6/qDvUiaVE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/WhfxqsakB6QsErCeTtR+sS6Px59jmxYzZLHObXMIQ=;
 b=B/3CHFmtMO3YN7m+LAqL20dOMyesr21h6l32v2lFGcGE+MLQI/r4+O0TzvreETT3Fn3zdePY2v6HzBW7yfGAaqOpy8RIeg3qMTJaXl4Y53LMvK4Tbh1WxWlSLxr6KHNlUBroFxCM53lqAGbetvSbZM2UGNDP+tVDuI2RnDFCG4hSWtEB6dx/W3i7HEnegxwvfXyMJwCrK9NukToRU7vJMrhp5qRMYASrDEvTnEGGnKlUytgXO1C3ZDkMzOrr+7c8FP450xuCJmYB8Qlb20c6L56VTEiLeSMw3+N/17ldhv/O12M/5G4HR7PtV1SmFa/7ibM7imOc4ZsIZKZ6iWr5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/WhfxqsakB6QsErCeTtR+sS6Px59jmxYzZLHObXMIQ=;
 b=HjmIUfmVJdXhQnqSUpFUjUb1X754/RINL0et+lfaIpCaaKeR6r7+m0+qa97EBPA11I0q98RKS4uBk+ddJDd2VMjb8yrTw5jqMtr/KVf4ue4oEi/MDNxk6v1dQOZAj4PE/Br7G8lfsdsyNtZQVcDr1KcWhIPkmvmF4KoJxEUSDIFSaVzmhy3KYYsgzPDvn052opevfWWOEr1UViDbaNbnvskwWbR+d6te7suf+J/IvgxOtF0Nq1i71YxDmvV2WQOnhCYpQp8RRIFWZmJRCyW5dv2KU/oc3yPT+c0ZzI7lt44lId6Gwf3uR4MBuBjuJRhTHs7lD9GDLndZnGnitsaTdg==
Received: from DB9P195MB1212.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:294::16)
 by BESP195MB2928.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:46:40 +0000
Received: from DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
 ([fe80::2d26:fa56:5972:5247]) by DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
 ([fe80::2d26:fa56:5972:5247%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 20:46:39 +0000
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jaehoon Chung <jh80.chung@samsung.com>
Subject: AW: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Thread-Topic: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Thread-Index: AQHcSncZNZsJS+1bXEyYkUZGyGb30bTiNqIAgAo2ozE=
Date: Mon, 10 Nov 2025 20:46:39 +0000
Message-ID: <DB9P195MB1212DC55E27674A4194719C497CEA@DB9P195MB1212.EURP195.PROD.OUTLOOK.COM>
References: <20251031145951.535376-1-c.stoidner@phytec.de>
 <PAXPR04MB84594BDB0690A1C0285F90A588C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84594BDB0690A1C0285F90A588C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1212:EE_|BESP195MB2928:EE_
x-ms-office365-filtering-correlation-id: bade8981-5572-4e2b-9a30-08de209a3fb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?Windows-1252?Q?+9BT1a2SBMdNTBWOL2xHxHcd/qn6eguZiM1jHPM9SzV/OI35Go88UEHp?=
 =?Windows-1252?Q?Xj6kSFnYPDUTDIYKE9CrkFLi7j4ZcA4gYL3ZvXCBhHR8p66djf0n7lrB?=
 =?Windows-1252?Q?smuNXVRf6Zl31jSX5tM4qPIsFY4XRevhApcmJoRG6pyIeTW/+rgwzzWt?=
 =?Windows-1252?Q?/QXHRp8PK7Aueg4U3WVmjwWOuoniyJFww9mjuJbGVbY2ZGnYkuwy+Z/b?=
 =?Windows-1252?Q?PaRWHmCM+ZhL5cgPzc88vC9DtigYCcUnt0l6JGWLjnwKmNTdwiPJQ/G8?=
 =?Windows-1252?Q?pqvh39L7ImpPw49rrwLS1WXrO72vz84CLjQx7tR8+aK1mI2qlHSkByrK?=
 =?Windows-1252?Q?e5iJI/Cv3VRdUK/sAYWeL1d4JeSuumkhQkhdZTVavvKXqpSNF2Fxnl4a?=
 =?Windows-1252?Q?hLl+OxWdbCzqeWGbQtgSP5ZZtV6FbitRoA5sb0ymXAuiW6DeCjGZ+iG/?=
 =?Windows-1252?Q?f8/tmx3fOEdazQOrQj/ZjGnOxgUzy5N3KzbFMQmN5ZNves6V7LhrQiHE?=
 =?Windows-1252?Q?FL5gQC7bvEfug2ife/RTgwpIY6lCLJ2fMZRc50q4AWfh/SC7o7AfKd8a?=
 =?Windows-1252?Q?9bwKLK1GViQOmIaidI/y5BgNZd8ZJITGYY3desRfnnGeF0EdeicWANPA?=
 =?Windows-1252?Q?PrPHKjX6L99QqnpJsGpDNUwSca+zvgqXnWz6+eDgQvL0VAYuLrHt92xT?=
 =?Windows-1252?Q?pyxA7d1D6INJW0XPUjMD8qkRIdAn/Mr9Ydvs3hkLIdcvJ6ORXvZyUfld?=
 =?Windows-1252?Q?JoFg6mL/i/EGMtBJ9bqLJ8Is/CoO++dzBVxrPi0DYtpFt2yuahg43ftu?=
 =?Windows-1252?Q?pJ1GaN5EIux+cln+YIT/edE/svdLDaYRxlIip2um1ABJ59edgfKHAhwD?=
 =?Windows-1252?Q?LqCX1x7krELQd77l/eaYkh6KjteNQtcd+oV0d/XZ/9AmgVP0k/6ZyrRH?=
 =?Windows-1252?Q?9IYml2ozf56ohZh766o2B2zQ3DVj6kNGSrvHhj6Asbnnt9orMIsPhow5?=
 =?Windows-1252?Q?fxBxkH2VrdnYXQeMPEHsfxIxGYxOlXiZozRLAhCy4encDzOeYj7aZ+1L?=
 =?Windows-1252?Q?C7cvApgZkQeOQDYfJXCqSMQ/9KxUrjukXUKEYwPXJz2J6TTbm6Ubw+q7?=
 =?Windows-1252?Q?+FFH/3h3JglLTjYuD8TOGL2ENnDCxyZ7OkqE3uqA33jpJNoCvNxQee8+?=
 =?Windows-1252?Q?PcNwj43JS2dRVjsi5YtB6P53t3mPy4easug038qkqja9sEE8WDyqxzj6?=
 =?Windows-1252?Q?kF2erxGfsT4f7E0fwprSsL5XDHc3VdqNKhkPCwGLbUkH8ra9bjkJ4gmz?=
 =?Windows-1252?Q?IbCXOfVfjIrUUbUmuU2a2+NvaX3g5i7FleugCNyiEGrjA/M0szAg8BBd?=
 =?Windows-1252?Q?eM8loxmIQccGBth+me08pfGotwfNOefUL53NlDQc3E4UulDZrcv42Xjk?=
 =?Windows-1252?Q?Yh1YnoiH5qBJ4Y3+SYjzQWLArrtzuZ/7CNjCFiG8Wya1LTgG+MNyFTUR?=
 =?Windows-1252?Q?1VJrzceUCRu6/bMqTgg5ZuuYuAoHWxW2FTIDo89eiaSeSP3vlW9o3RDG?=
 =?Windows-1252?Q?RxhOKe8LVD+dKJguc9S4Mo1BkTk7xgw/48lB1zl0g9cDyDRTafV5BYvK?=
 =?Windows-1252?Q?Y0FW22fzjAVXoCNUfOogJf0F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1212.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Zs/zKUaByt8Aqhg55ugJt6d5Fu+gj0h/9GkLL+sK5jLtGDCm+x3Tzige?=
 =?Windows-1252?Q?j4/Y+k3IKwOTxgLYNOr3NMrwdcxtglMcyDVejC3bedYp9Dzi+AzixqPw?=
 =?Windows-1252?Q?gg1N96+I7aMm7VEoLkszJPby5EyqfznJpXp1Uf0M1vXOscIotELLSPjP?=
 =?Windows-1252?Q?VL1jIamzukqN3to09E+NOXKDYGddQ6HRrh2uzWPgoNr+rn2P3ZTviZlI?=
 =?Windows-1252?Q?C6y6zqUdsysOgg5id81dNHMqNLO7+5+5IdSviyy+EBpxCcpoX/eLD8bJ?=
 =?Windows-1252?Q?22+RvtyfvN+sojy2ctBvzXHM98vEiAD3QO8zCeOeHTJIMpC8keQikAT5?=
 =?Windows-1252?Q?SZUF54s750FLfrtuU3Anv/Vp31cvM7CD79ZatULkYLveN6PttGL+P6bM?=
 =?Windows-1252?Q?6/xIkFqeDPZezv967INS3elvw3wNh2Gkt2sIgNvoVx6MIr+bUUlc0M6j?=
 =?Windows-1252?Q?7ALrn1NfiQCNNG6z9amc8Sy0+pRgS0royarbQDvPe5f5yvklnP2y9x9k?=
 =?Windows-1252?Q?F1uNUkKrIxW6+BhmeLi+nu2O/8u8YJNhN+9A7XdpM0iWktQGO0/rMejj?=
 =?Windows-1252?Q?Ke1VXl76lPxBdqKPz7HJoEbgtFX8voUQLzrkbc3DAAmP7gooyeqWvD9V?=
 =?Windows-1252?Q?9T25vRF5HGle0zUCDjEtcfg6t+A9DG8ANlZy37bf3WemPNtrZkFuV7HY?=
 =?Windows-1252?Q?ymhqUfaY0o/AhEFyRnncxm4uILKkoSH0qBvBKzv61tPN8zp8vYpeHH9Z?=
 =?Windows-1252?Q?xdBBht4taRToS0LS/cK/XLomcMhTz/0gniymobbFxN74Uhd62/Haq7D0?=
 =?Windows-1252?Q?cugnEXT+pAw4Rv8oBNFVK0ke/dRluKdLRjPw6oQkwpaPrdpMI6D4ETmv?=
 =?Windows-1252?Q?hsw+8Sdyclik05+u8uiU553fVObmfTxW2BX4T5CBipYnP3tyAzYM0H6n?=
 =?Windows-1252?Q?/qBhaoEieaLj+KR0+iqEfI4DKSeQvCTLhxTp/bJWjBEQs6Bh5Mlhovma?=
 =?Windows-1252?Q?+t/Gl6foRYJ/Xvwv5FVsorh43UlijWfIwOAz/1uFPFcCkOsF7U6PebZt?=
 =?Windows-1252?Q?1zghQNXOLj/VWtJy1qriDwV/u9Mgly62oTqtlKcIuyeMasIT+sKKa8OK?=
 =?Windows-1252?Q?nWfmB5/u3jsqxWRr7IHfp+NSCqBnYCHXF0CdufEKXR0EUUgPZ4zNQCYH?=
 =?Windows-1252?Q?ULf0r7kZU6ySIK/xYMv8BHtHGXD2JRAuuYvbxaUR18a28y8HyJnDgfyD?=
 =?Windows-1252?Q?Ol8NjfFBSROJsMrt0CHTwlbR4t5UR9kUrOi8YQ0U+BZ6P2UlxFjf/eFq?=
 =?Windows-1252?Q?9fTmrxKgtk9Jth+3KlMgbUcnncePTl7Yl8/B1bhXG2tRLQGmZiHWEJy1?=
 =?Windows-1252?Q?PpROickdqfoJpdfNkpTdsHWpb2gk6jrBkvy1HLEDBlycVm3h7C6Aqjq9?=
 =?Windows-1252?Q?r9tVWMEyxMc6WRxqM40L/D72TG0AHgE5+vq86kQoINgNupoltLVL11Hg?=
 =?Windows-1252?Q?RCc6bhoPHgk5R9xnfBiWg6pFQotWtZdgQ+qqZq098kMj5q31Lt/tRU0v?=
 =?Windows-1252?Q?L+zF/8QnQq87Ykrqwu/qkhuF0QMEXEHWRu0S1hqR5zUXlSX/M9/pyNBG?=
 =?Windows-1252?Q?JObmyvXnBl2dh9sXCa+psxqPLzmW+ylY7XPYQV/iowcPksQnC5NwRG5r?=
 =?Windows-1252?Q?+9CILYdZ20o=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bade8981-5572-4e2b-9a30-08de209a3fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 20:46:39.8504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcVMNFYwJ/owlZAzGUYtaNk8pJm4CDiwk0Jymsx/rZw4nGdJl2UdKSt8927iXoBRbI9X96TjZLBQXdSK/N3zFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP195MB2928
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

Hi Peng, thanks for your feedback.=0A=
=0A=
> Hi Christoph=0A=
> =0A=
> Thanks for your patch.=0A=
> =0A=
> > Subject: [PATCH] mmc: Fix missing 1 ms delay after mmc power up=0A=
...=0A=
> > +     udelay(2000);=0A=
> =0A=
> Per spec,=0A=
> From Figure 6-4: Power-up Diagram of Card=0A=
> the 1ms is voltageSupply ramp up time, so I am thinking the fix=0A=
> should be in your regulator side, saying startup-delay-us property=0A=
> in your regulator node.=0A=
=0A=
True, this could also be handled via the regulator=92s DTS properties, and=
=0A=
some boards already do that. However, from my point of view, that=92s not=
=0A=
the right place for this particular delay.=0A=
=0A=
The SD specification distinguishes between two different delays=0A=
(see Figure 6-5 =93Power-Up Diagram (Host)=94 in SD Spec 6.00, =A76.4.1):=
=0A=
=0A=
   1) "Power ramp up"=0A=
   2) "Stable voltage delay"=0A=
=0A=
The first one (power ramp up) is regulator-specific and should indeed be=0A=
covered by the regulator=92s startup-delay-us property in the device tree.=
=0A=
But this patch is about the second one - the "stable voltage delay".=0A=
=0A=
That delay is completely independent of any regulator/voltage-supply or=0A=
board characteristics; it is a constant 1ms delay by the SD interface itsel=
f=0A=
to ensure correct card initialization timing. =0A=
Decoupling it from the regulators would make board-code developers=0A=
live easier, and can make U-Boot=92s MMC initialization more robust across=
=0A=
all boards.=0A=
=0A=
What do you think about that?=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
> Thanks,=0A=
> Peng.=0A=
> =0A=
> > +     return ret;=0A=
...=
