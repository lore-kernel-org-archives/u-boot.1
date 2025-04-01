Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA6EC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 10:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB42582047;
	Tue,  1 Apr 2025 12:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VAY8Tu6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3872C8205B; Tue,  1 Apr 2025 12:57:51 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2C382040
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8n6zBEsHq9fRiwvRerEqiWYOtRWCIZAwWD4bL4ccri54/jMqrn0gU2WocpHPkmx40nTfjvh79XkdNMurq04SYEdtOkCM2XkJKwyYpc+8qHJQMSyLUvT/9ex9urzAhrXrbmsWNo8ry76DmkOeP4fNZH00eLDbzlDded22XdGH23VQ5J0n8oGhbimKw+8s4I2UNTyp0j8/+WyZyqlds05686JVYsr7Z2xlel4ZS3081RaK3SJZxQYAdfhA+wf7X409C3prYse9yctDUo356RdITje6Hi9b0HhSukTMIHvDfTrtQ/LjQmLyeFr253BPxkSRXfeKTZdf4SpyWSS+cJX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMvY+YHqX9HOwqvLqA3AV3s7GTmSvLf+IxTOaDMMhRo=;
 b=El2q25wmwVgNOPAjIa7NCQzn4e1dY393MwxwP5srrM10xQU58Phmrxv/iJG1ioSokZ3wCyarjY+Q7SPfSY9vkiphR8KIZ0dX6J/cNy7Em61qZRsUyS5xxjfJ5iuplRMup4sxesi1zFPt/lMgFBoySmcGGX0urwJg6FyFKyVB4Li7XzFJbvWIHKt+8pA2H8ZH5ShmyNPmCWCGRShwd58sNvEWcC/G3ozu1qrcn1ijD2WfawBL/6iRfKOmGahYnjjRKSyF1XR7iszI38bGBE4MSHQO8hytBQwdxBeBpXhjaTM65yu5vuNVezVFyyA5kf0Wl4F+IOw5vYhOzb2mu8/FhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMvY+YHqX9HOwqvLqA3AV3s7GTmSvLf+IxTOaDMMhRo=;
 b=VAY8Tu6ocqTWArClPhKxi7wZG+LmKsbOjfWVlDY5AMp129zFcjSFe5dx1Pxo/bU9MBX7QsBkOKFleExCqLwS32AoH/RIAM5nwa5flSyu/06DXOhf3udWkx/73f7P+3RxGA9HBnYxJSGqoVq5lCVS9FfbKZM4F8nnQy19R6GBfKn1VTsIm3S44hH+QK61lZ583K4+4A6QVu/EADFmzDb3MKhuXNhpMi/GqJ5IpO4v5ZW8hs5VZyMDA1tLAmLI5N7Iu4N/U+O2TPJV0iajCubGKZiUXFBK97qp2wsO5PMq6yrPDpL7E6bvnjDtRZT1roWYC1tAnMT1FsBu7s2Tmy61Aw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10110.eurprd04.prod.outlook.com (2603:10a6:150:1b2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 10:57:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 10:57:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon
 Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjggMDIvMTldIHBpbmN0cmw6IG54cDogYWRkIGEg?=
 =?utf-8?B?cGluIGNvbnRyb2xsZXIgZHJpdmVyIGJhc2VkIG9uIFNDTUkgcGluIGNvbnRy?=
 =?utf-8?Q?ol_protocol?=
Thread-Topic: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Thread-Index: AQHbmjEZPZpAH2ZEOUK/fGtZCzozwLN+Uy8AgAUx/ACAASH9AIAAB9UAgAATGYCAAD4KAIACAPkAgAeztNA=
Date: Tue, 1 Apr 2025 10:57:46 +0000
Message-ID: <PAXPR04MB96445CAACB6E8413A03CA386E2AC2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
 <20250325080614.GC27303@nxa18884-linux>
 <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
 <PAXPR04MB8459808C7CC6C16DB43B973388A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bc232085-3efb-43fb-b176-eaf43e52f1f8@denx.de>
 <PAXPR04MB8459F46041C7EFF7191F8EFD88A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bbb8ecca-789d-40cc-93a8-e7284e1af840@denx.de>
In-Reply-To: <bbb8ecca-789d-40cc-93a8-e7284e1af840@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB10110:EE_
x-ms-office365-filtering-correlation-id: 2de77947-fb10-4dc2-0888-08dd710c090b
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZjJMZ2djRHUzNXRudGlhZkx6dE85aEV0d3RvTy8xaUtoNndzZnBZTXd5SnE1?=
 =?utf-8?B?VHZNdlVhNVVsOHl5NWNpcHVkcXc3WFJGcXBsNnhnU3JvWjNQVnYzMjFqYUhK?=
 =?utf-8?B?ZHdUR21EYXpmU2tncURpOE9zSCswU3ZrRjNySlVzUHZ3b3VpRFdrOFVZd0V0?=
 =?utf-8?B?b3luNFJ1OFhDSWRHRmpZL2FQNWxkRzdTVVUzdTVMejZsNUJEeWYxUFBjVHpX?=
 =?utf-8?B?dXhBdXJUMUwvSDdqMjhVK3lVNmhaTmZEbWRmMWozV0ZyYUh5SmkxTGNIUWlI?=
 =?utf-8?B?bzBPMGRsYW5VRUVvKzJYaGJWSG95TFlIeTNiRWwvek1CWW5IYVA2T2FiOXUy?=
 =?utf-8?B?YU5PajcranhRWWRZQWoxREhwWDY5TXlwR05TVm5rMUI3SWNsU3pMdVQ5VEhp?=
 =?utf-8?B?ZGdnNW5ad1UzRlFhU1dWZ2Zha0pJWisxTndtMzJGTTExRms3RDlvU2Uxdkxu?=
 =?utf-8?B?eXZmT1RMelVHMTVVSXRuVXEyTy9mYzJjTmxmMXVxTW9XcTFua0IzRmI4eXNS?=
 =?utf-8?B?TytkNVVCMWxNaEZFYlhlYkRmeVlmODFmalBDUVArblh6eHhRRlUyenZzS2Zu?=
 =?utf-8?B?Z0ZMZzRlQVJ5TndoUXRTQURHdENrTEVDRVlMMDNjS0tBS0sxajBOQkJ1Tkdh?=
 =?utf-8?B?NHZibmF4Qk5OWE9xclZ0elU0Z0pXcC93THBPa0tXTzRTR3paYUF1K25Pbjdz?=
 =?utf-8?B?VEl6ZGNjN1ZQRUpmVE14eE9QU0w1dUNORWhVSDdKOUthL0hkLzZydWk0VFdv?=
 =?utf-8?B?UHBGcUl3WW9lcTY0dDNlM21RWEVmN0RpUkFCMG9va1gyQW9NTURuMDNxR2RZ?=
 =?utf-8?B?a2x1WlQrMkxEKzZBc0V4VThYdWdqQWdpQm14WGh1L2ExbXZBMi9BeVBGRVI1?=
 =?utf-8?B?MU1scVRYV2xFMGZLZ0VUUXoycng4R0VVNjZtbHZ1N3VHYVVma1VDMGRZMStE?=
 =?utf-8?B?L0VqY2VzUWo0eEsyb2lwYlJpNHhhUG9CSEFZbU1JNlJUNFlCc0k2NTI0K21J?=
 =?utf-8?B?d1hsRVBVRGpldGgrb0pCQko3SmwrdnJDRU1RcklROExpeFRHOXhhM3NrbmN2?=
 =?utf-8?B?UGpPYmtNU3ZEbmNlRldlZkxUWXZJZXFYWUZtaS9JNDZvZThWSmtzbmFhNm5p?=
 =?utf-8?B?aTFoYndDdllZYzZJbXJOUG43cHFQRmh2ckJxWlAvZHlQbkFmLzZVNWl1QVVr?=
 =?utf-8?B?dmI2dnNrZHFmWGpKVENQaHdJamVWd2pxK00yY0c4ZW1VK0RmZVdHMmlvOEh0?=
 =?utf-8?B?dWFzbStCeEVzS25CQUFKNjZkRkFRTmV1eURWLzFkVDQ3RzhQT3J3SVoyOFBi?=
 =?utf-8?B?cVhSY2hQUjk5Z0NhS2tVRkFXUDNBbWlQUkJVQjY3b0tQRU5aTm00d2RtRUk4?=
 =?utf-8?B?bllPTGhZTEZNajlrMEFXbVAyclJOT0FvWUh6L1IwWncxd3dYWmlESDM1WDRx?=
 =?utf-8?B?Z1ZDTzhKYzA5MGxkUktncTh0U0dpVWNLSlBQY0orNjBya2t0YTlJbkZJcVlj?=
 =?utf-8?B?Qno5Q3B6Z3B3Wm8rQ2RpZWRkeXJOZ1Fzc2toK3R3bGNzMFIwZ3d4U1RsUmVG?=
 =?utf-8?B?ckhHb0R4TW9LS2JCUjV6U2JwRTBMQUEvYXFZUWl1SER5bXBLZjhpT3I1MlFr?=
 =?utf-8?B?dDhJNVozV2lYQUhZWjBGYlBadlhhY3hNQmpoV2FaWmU2U2xyMGx3dDZqWmN1?=
 =?utf-8?B?MFNuZUxQQXZwdXVFYmovK2xjNThmRG10S1p2RXRTUkJlNE1rZXkxZnBwT2Zk?=
 =?utf-8?B?MlpGMW9jMW56NlMyNklnNExwdDhpb3pUb1VtV0tvZlJyN1c2NnNYWHdaS3RL?=
 =?utf-8?B?QlFYZi9oZGVESklJVFhoL2hkZjZDQ3ZYTzk4VG5GZHU2THI2STFFYzk0Q0p0?=
 =?utf-8?B?bk53OUFqSHRJeHdNa2hVWHE4L3VxeUhJTUFva1FVYS8rUDBJRjdlaEdocFVu?=
 =?utf-8?Q?V/lowPOL0+JPfcaFjxB8e2Ej59l8XwQ5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzVvdEVtRDA3bGNUOWtwbW9uSGRQa2F5THJjS0FCVjl4N0piV2xDVEVJV0Uw?=
 =?utf-8?B?eGg2NUVPdnVPZ1JtQzBLUDhOMjNERkZ0akt1WVBUdlYxWHJ2NWJ6eWMyc3pG?=
 =?utf-8?B?R0ZUQktPbUhhay9zYkxreUhacmQ2YmhBVkdDeVJKaFRJaERZdXVDSCtybnNx?=
 =?utf-8?B?SFlXV3A4ZFpxV05yRis2NzZZblYvY3J2ZHhUVzZjL2xvNEw1LzFFN3lGOXVv?=
 =?utf-8?B?KzNsSFg5STZEblp4ak51dG1xMzUwRkY1ODA3ckNVNDUyUDNSSTZXR2Zib3B0?=
 =?utf-8?B?cXNENFAzaG53aWNmQkVwNTloMVFTcnU5QXErRHVlQU5zdk5WMnU4U2kvR2ds?=
 =?utf-8?B?dW1TTEpNNzM4Tjk0bHROSk9PbUxnTi9IUEplZ085UUZUWk1RR2tDYVVWQ1NM?=
 =?utf-8?B?c2pWV1ZPNXFZdFNmRll1eGt0a1drU0txa1FYTVVqT0pjQ21zbDJZMW9zU0FE?=
 =?utf-8?B?cDdaYW9Bc0RWbnNBQmUvb3p0d005TVVPS2l6VDkzVjJEVFdCTG04bjVwdFNs?=
 =?utf-8?B?WUg0dFdVeGRQM2FpMmorWnFYblExSkx2Y3pyYjF0ZHhLQjdnSkdwZTYyNHpq?=
 =?utf-8?B?MjVjU0FnN2ZyOS9seUV1bXNwYVhYZmUvencreEFBa3kzV1dYU1ZtZGNhM05y?=
 =?utf-8?B?OUMvMmdxcmlLUmFVZ2oxKzlCQk5hS0d4YkI4cWlOWTBVVzl0QmV0Wnp5SWg4?=
 =?utf-8?B?L3duMmcwcFU5UTZlTWwzZzVNbEFoNTFYbVllaHJrdzNBRnVSN2c2RnhhSWlW?=
 =?utf-8?B?YkdUT09wL0ZEZ0lCZmtEejlwTVNNcWtGSzhFYmpPYkFzOTJHSlVMcVpXWDVV?=
 =?utf-8?B?YlAxTytTTVNjNUNXazdJUDFoT2JrVEdKK2x5bkk4Y1JZZW1hL3UrTW1lc0py?=
 =?utf-8?B?R1pjQXdDMHVEc0lTem1sbzVrNFZGQmNocVN5U0VXOVM3ZmlHVzFzQ2JwUXlm?=
 =?utf-8?B?UCtNS1d2SGNRYWFNRXVTVmtOdFJiU1VNbFdocEdtdnJseVk4SStzNlF2ekFo?=
 =?utf-8?B?K3FKS0tpV0ltbXNxZ0tkc0xhTllOeW1INTl3a2wyK0QyQXY2WURvUFdvdzF0?=
 =?utf-8?B?bTNGN2xvaVVtMUZVdkt6c3FhNnVLTnd4VlNMQThYb3NiVVlia3Z5Ym90Rjkx?=
 =?utf-8?B?d1JOc0dNZTdSb1k3bklQVGlrSEdxWTBYU3JjNkJBbXJBNHI1OGlKc2F1dFcx?=
 =?utf-8?B?akx3Q2tSeTBrVGo4dXJqUm9QWkFFQ0pOZmFkNWFMRllsd0J1bVNSRFN3NHBX?=
 =?utf-8?B?RkY0TGh3QmhhNEMxRXVHb050NkVDWVFJZXRhWGw0bVpsQnJZaFJEZVFuQ3ZD?=
 =?utf-8?B?ak95MW1idWswYlhpM0c3RmdIdFV4dEZYUlUxaTViRVhDRTNKbG56V3dNbTN4?=
 =?utf-8?B?RHNYV3BRR0o3Y2RnU1FyTXVaOG1PRjVzSHdOTXRsREZJdUhuT2poNXRnMkhx?=
 =?utf-8?B?M1IxaFZVWmVZbThJUFg2eElxbmhrb1lVTktSY2dmUUdweGpWU2RLSzRlZnpl?=
 =?utf-8?B?bm5FRkl5cFNuc3IybDYwNUdYT2hheTRjMGRHVlBpekozNVlTcjdCSExHQnRO?=
 =?utf-8?B?S1ZNWUZuQXhzbWVuYngwQVYxay9nbUdFYjJlMXVDOXhYTEdWLytuS0NoNGpp?=
 =?utf-8?B?RE0rZkdyVmt2VTZjRnBCVWZVMmk3d2MxMEhvMGhZeG1RbGxkc0M0OXIxbWF6?=
 =?utf-8?B?TUNJRXBZcExHS29rUndqNlVyZ2czUUh2WjU4amxkTE9BLzh5ZGhBS3FLQkpk?=
 =?utf-8?B?bWovUFkyZnFWZ1hHMXRhVElpNHRydWYxcFU4T2J3a2JNbWs5NmxYYTZGdEl1?=
 =?utf-8?B?R1l3TFpMLzNEVXJydFR3elV1Y2dKQlp0WFp6NTNHcmJHQ2Frc1oxTXllbm5N?=
 =?utf-8?B?L1JFd0pLQUR1WENYZjZabURaZ29LY0dja0dDekFLa1FPV1lKME1qNlJuZ3lY?=
 =?utf-8?B?THZUc0FRU3piekVZbS94RkRPN295aUtmL243N3ZUSFdTZVJBNkltR1VlZDFL?=
 =?utf-8?B?NnU4dmNHWVBhcnRsL0preFlLUFFFU0x5MlpPUkE1MVJUQWRMM3VrS25SNU9t?=
 =?utf-8?B?cVU0WHc0ZU1URWhBcVZzakRxOUxtZWdPRUl2T0x6ek9kWTBkYk9ibFVmQWRW?=
 =?utf-8?Q?Fg/ZUAMY45Xio14MLgXHldw8Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de77947-fb10-4dc2-0888-08dd710c090b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 10:57:46.1445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQk/GVvovQog3Xgm3DJzxUXo87b7gzVOW+WX25qMmJ1MA/jtWhqe42h8CQiZr6VlAb61eh6hfW6agV29ABuT2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10110
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgyN+aXpSAyMToxOQ0KPiDmlLbk
u7bkuro6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgUGVuZyBGYW4gKE9TUykNCj4gPHBl
bmcuZmFuQG9zcy5ueHAuY29tPg0KPiDmioTpgIE6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3Vv
QG9zcy5ueHAuY29tPjsgVG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IEx1a2FzeiBN
YWpld3NraSA8bHVrbWFAZGVueC5kZT47IFNlYW4gQW5kZXJzb24NCj4gPHNlYW5nYTJAZ21haWwu
Y29tPjsgU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBTdGVmYW5vIEJhYmljDQo+IDxz
YmFiaWNAZGVueC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVi
b290LWlteA0KPiA8dWJvb3QtaW14QG54cC5jb20+OyBBbHBlciBOZWJpIFlhc2FrIDxhbHBlcm5l
Yml5YXNha0BnbWFpbC5jb20+OyBBbGljZQ0KPiBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsgTG90
aGFyIFdhw59tYW5uIDxMV0BrYXJvLWVsZWN0cm9uaWNzLmRlPjsNCj4gdS1ib290QGxpc3RzLmRl
bnguZGU7IFJhbmphbmkgVmFpZHlhbmF0aGFuIDxyYW5qYW5pLnZhaWR5YW5hdGhhbkBueHAuY29t
PjsNCj4gWWUgTGkgPHllLmxpQG54cC5jb20+DQo+IOS4u+mimDogUmU6IFtQQVRDSCB2OCAwMi8x
OV0gcGluY3RybDogbnhwOiBhZGQgYSBwaW4gY29udHJvbGxlciBkcml2ZXIgYmFzZWQgb24NCj4g
U0NNSSBwaW4gY29udHJvbCBwcm90b2NvbA0KPiANCj4gT24gMy8yNi8yNSA3OjQyIEFNLCBQZW5n
IEZhbiB3cm90ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAwMi8xOV0gcGluY3RybDog
bnhwOiBhZGQgYSBwaW4gY29udHJvbGxlcg0KPiA+PiBkcml2ZXIgYmFzZWQgb24gU0NNSSBwaW4g
Y29udHJvbCBwcm90b2NvbA0KPiA+Pg0KPiA+PiBPbiAzLzI2LzI1IDI6NTIgQU0sIFBlbmcgRmFu
IHdyb3RlOg0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMDIvMTldIHBpbmN0cmw6IG54
cDogYWRkIGEgcGluIGNvbnRyb2xsZXINCj4gPj4+PiBkcml2ZXIgYmFzZWQgb24gU0NNSSBwaW4g
Y29udHJvbCBwcm90b2NvbA0KPiA+Pj4+DQo+ID4+Pj4gT24gMy8yNS8yNSA5OjA2IEFNLCBQZW5n
IEZhbiB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+IFsuLi5dDQo+ID4+Pj4NCj4gPj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9zY21pX3Byb3RvY29scy5oIGIvaW5jbHVkZS9zY21pX3Byb3RvY29s
cy5oDQo+ID4+Pj4+Pj4gaW5kZXggN2FiYjJhNmYzNmIuLjI3OWViYmFkNDQwIDEwMDY0NA0KPiA+
Pj4+Pj4+IC0tLSBhL2luY2x1ZGUvc2NtaV9wcm90b2NvbHMuaA0KPiA+Pj4+Pj4+ICsrKyBiL2lu
Y2x1ZGUvc2NtaV9wcm90b2NvbHMuaA0KPiA+Pj4+Pj4+IEBAIC0yNCw2ICsyNCw3IEBAIGVudW0g
c2NtaV9zdGRfcHJvdG9jb2wgew0KPiA+Pj4+Pj4+ICAgICAgCVNDTUlfUFJPVE9DT0xfSURfU0VO
U09SID0gMHgxNSwNCj4gPj4+Pj4+PiAgICAgIAlTQ01JX1BST1RPQ09MX0lEX1JFU0VUX0RPTUFJ
TiA9IDB4MTYsDQo+ID4+Pj4+Pj4gICAgICAJU0NNSV9QUk9UT0NPTF9JRF9WT0xUQUdFX0RPTUFJ
TiA9IDB4MTcsDQo+ID4+Pj4+Pj4gKwlTQ01JX1BST1RPQ09MX0lEX1BJTkNUUkwgPSAweDE5LA0K
PiA+Pj4+Pj4gSWYgdGhpcyBpcyB0aGUgSU1YIHNwZWNpZmljIHBpbmN0cmwgcHJvdG9jb2wsIHBs
ZWFzZSBtYWtlIHN1cmUgdG8NCj4gPj4+Pj4+IG5hbWUgaXQgYWNjb3JkaW5nbHkgLCBTQ01JX1BS
T1RPQ09MX0lEX1BJTkNUUkxfSU1YIG9yDQo+ID4+Pj4gc29tZXRoaW5nIC4NCj4gPj4+Pj4NCj4g
Pj4+Pj4gVGhpcyBJRCBpcyBnZW5lcmljIElELCBub3QgaS5NWCBzcGVjaWZpYy4NCj4gPj4+Pj4N
Cj4gPj4+Pj4gaS5NWCBTQ01JIHBpbmN0cmwgZm9sbG93cyBBUk0gU0NNSSBzcGVjLCBidXQgaS5N
WCBwaW5jdHJsIGJpbmRpbmdzDQo+ID4+Pj4gYXJlDQo+ID4+Pj4+IGRpZmZlcmVudCBjb21wYXJl
ZCB3aXRoIEFSTSBTQ01JIGdlbmVyaWMgcGluY29uZiBiaW5kaW5ncywgc28gd2UNCj4gPj4+PiBu
ZWVkDQo+ID4+Pj4+IGEgc2VwYXJhdGUgZHJpdmVyIGZvciBpLk1YLg0KPiA+Pj4+IEJ1dCB0aGVu
LCB3aHkgaXMgaXQgdXNpbmcgdGhlIHNhbWUgcHJvdG9jb2wgSUQgPw0KPiA+Pj4NCj4gPj4+IGku
TVggU3lzdGVtIE1hbmFnZXIgRlcgcGluY3RybCBmb2xsb3dzIEFSTSBTQ01JIHNwZWMsIHRoZSBJ
RA0KPiA+PiB2YWx1ZSBpcw0KPiA+Pj4gMHgxOS4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gSWYgeW91
IGxvb2sgYXQgbGludXgga2VybmVsIGRyaXZlcg0KPiA+Pj4NCj4gPj4+IGRyaXZlcnMvcGluY3Ry
bC9waW5jdHJsLXNjbWkuYw0KPiA+Pj4gZHJpdmVycy9waW5jdHJsL2ZyZWVzY2FsZS9waW5jdHJs
LXNjbWktaW14LmMNCj4gPj4NCj4gPj4gSXMgdGhlIHNlY29uZCBkcml2ZXIgdXBzdHJlYW0gYXQg
YWxsID8gSSBkb24ndCBzZWUgaXQgaW4gbGludXgtbmV4dCA/DQo+ID4NCj4gPiBUeXBvOiBkcml2
ZXJzL3BpbmN0cmwvZnJlZXNjYWxlL3BpbmN0cmwtaW14LXNjbWkuYw0KPiANCj4gQWgsIHRoYW5r
IHlvdSBmb3IgY2xhcmlmeWluZy4NCj4gDQo+ID4+PiBCb3RoIHVzZSBzYW1lIElEIDB4MTkuDQo+
ID4+Pg0KPiA+Pj4gSXQgaXMgZmluZSB0byB1c2UgYmVsb3csIGlmIGl0IGlzIGZpbmUgdG8geW91
Lg0KPiA+Pj4gU0NNSV9QUk9UT0NPTF9JRF9QSU5DVFJMX0lNWCA9IDB4MTkuDQo+ID4+IEhvdyBk
b2VzIHRoZSBrZXJuZWwgZGlzY2VybiB3aGljaCBkcml2ZXIgaXQgc2hvdWxkIHVzZSB0byBjb21t
dW5pY2F0ZQ0KPiA+PiB3aXRoIHRoZSBTQ01JIHByb3ZpZGVyIGlmIGJvdGggZHJpdmVycyBhcmUg
Y29tcGlsZWQgaW50byB0aGUga2VybmVsID8NCj4gPg0KPiA+IFRoZXJlIGlzIGEgY2hlY2sgaW4g
ZHJpdmVycyBwcm9iZS4gT25seSBvbmUgd2lsbCBzdWNjZWVkLg0KPiANCj4gSSBoYXZlIHRvIGFk
bWl0LCB0aGlzIGlzIGp1c3QgLi4uIHVoaGggOigNCj4gDQo+IEJ1dCBJIHRoaW5rIG5vdywgd2Ug
c2hvdWxkIGFsc28gaGF2ZSBhIGRyaXZlci1zaWRlIGNoZWNrIGFuZCB0d28gc2VwYXJhdGUNCj4g
ZHJpdmVycywgc2ltaWxhciB0byB0aGlzIHBhdGNoOg0KPiANCj4gW1BBVENIXSBwb3dlcjogcmVn
dWxhdG9yOiBzY21pOiBNb3ZlIHJlZ3VsYXRvciBzdWJub2RlIGhhY2sgdG8NCj4gc2NtaV9yZWd1
bGF0b3INCg0KSGkgTWFyZWssDQoNCldoZW4gd2lsbCB0aGlzIHBhdGNoICJbUEFUQ0hdIHBvd2Vy
OiByZWd1bGF0b3I6IHNjbWk6IE1vdmUgcmVndWxhdG9yIHN1Ym5vZGUgaGFjayB0byBzY21pX3Jl
Z3VsYXRvciIgYmUgYXBwbGllZCB0byB0aGUgdWJvb3QgbmV4dCBicmFuY2g/IEkgaGF2ZSBhbHJl
YWR5IG1hZGUgdGhlIG5leHQgdmVyc2lvbiBwYXRjaCBzZXQgYmFzZWQgb24gdGhpcyBwYXRjaC4N
Cg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gcmlnaHQgPw0K
