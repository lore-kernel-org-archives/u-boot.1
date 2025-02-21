Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1436C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 09:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9038056B;
	Fri, 21 Feb 2025 10:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QYINK6mO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A217807C4; Fri, 21 Feb 2025 10:40:03 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ADE48007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8Unh+AL+o1qd1sSLJd2ziPhLh2mUxzu1aRFDZ1RWWPT2wYyvE6x/2NRmlhLTvehTETt52i0G+FqMAfsADZewc0RnlPM3mD8brcZR7DX2fUHo/2VVjzIORTCYHpRFUkbA0HO7ZdBZwypca44x9McH+9BGJXPwxSjTqVmM4sHFOvgqJptDHtkuXnWJJlA9lQmnoijRf2DqKOJbfZY4EZpwt0RS7UYpGuO0nAJJ4fb4tkoPHMj/8ELwb1NWWGWhjbTSDTQ8s4Q46YqcbYImaGSu1z0kDlXMI2bKmVgwZgxHF12ldlgIJ+Sc/hT2USjg2FUEYt1JYLXK7bFt3rEAAyGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DT8jRHfixRTCHzK/xpJ83ZanzJ7e/9WY+ytUvdzrAs=;
 b=P+68Wb+7rSwMAjsyXfST9y5fCcRPuYChcBnNqp839EGAsx0mqkklb7kYbfKapfgD71g3efL8EsPwznyvMZHidbSVtfViEURmjD4IhnlzURLig59ytX8tTdidY50AwbsEZ5ZPz4W6chiTkb/rhCAjf1BbE21fXvcNHYO1EV/c38tUI5L4UqQska0CLMbdP+fg+G3yI9RM0yOjmIPimvqdcSmwA7jpO1ZTvjv7aJABXxKSk40XKbhoYcGiAJZ9HXUAwNBzpOuvWocFf9HPhs1y24xcFZv4T7KkcGS2leHuuRc0lKNG+9WGUUsr/yYAJbdIpU1WXUvH5WooaCMgg7laJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DT8jRHfixRTCHzK/xpJ83ZanzJ7e/9WY+ytUvdzrAs=;
 b=QYINK6mO1wzSYoqT1YIYPScmxluQc8pI4FWQ5mpZzceS+nqlTsDr9boKh+iZEDYzuPJFDnTWV2WC4b55zaMBaHMH6bkD0ngICtEgVyg5n4ry/Ng9qOyVfz3o74VklkY8PA0arbH6aEQVwBvNAYriO9JOiI6QmsuNoDkKwmWORKialVIUm3y14PJ54hWVdCmH240VJAPPQR83Kyetxr1DbkIQvUkeA1MRWOqsE4kVZa6jkT54GDZQqw2Zsvxk7lQ1QwRumd5keedWy7dH03apiVffFSPscy/cVzWChvBVUXy5YaQQx2fpJh3sHbb3NS/OtjJjqWW4nUXeHkrn0ap/EA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8486.eurprd04.prod.outlook.com (2603:10a6:20b:419::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 21 Feb
 2025 09:39:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 09:39:57 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHY0IDA1LzIwXSBzY21pX3Byb3Rv?=
 =?utf-8?B?Y29sczogYWRkIFNDTUkgbWlzYyBwcm90b2NvbCBwcm90b2NvbF9pZCBhbmQg?=
 =?utf-8?Q?message=5Fid_for_getting_the_ROM_passover_data?=
Thread-Topic: [EXT] Re: [PATCH v4 05/20] scmi_protocols: add SCMI misc
 protocol protocol_id and message_id for getting the ROM passover data
Thread-Index: AQHbZ1GANjU8jkMa0Uqu+72l6gsaa7MmASYAgCu5NGA=
Date: Fri, 21 Feb 2025 09:39:57 +0000
Message-ID: <PAXPR04MB96445DE3BBBC8E0F16DEB41BE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-5-93b28a514dea@oss.nxp.com>
 <24cdad35-a255-4941-b6ed-0e7240857fec@denx.de>
In-Reply-To: <24cdad35-a255-4941-b6ed-0e7240857fec@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8486:EE_
x-ms-office365-filtering-correlation-id: 17acdcd6-47c1-46df-2b34-08dd525bb461
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?eVRvSGpyYWxxeUlQZFV2bE9YbUVGMmRjRGlKSGJ5T245Z2pFZVhuSmQ3MGNG?=
 =?utf-8?B?YzRTNHhCenF6b2hxdnZXbnduTERYL1VqV1oyOG82RWtDN1JKaW1rUGxnSFBB?=
 =?utf-8?B?QW9uNFQ3NkVoWmxZUjNiMGJhYmFTczRrVndtbUdVWUd1SEhwZGp5bmtkbHdU?=
 =?utf-8?B?NGVuRW45WVFmU2UxaEJFOTc0RG51aFpnM0ZaSjlMeDZpRlB6OEFDa1V6YTJy?=
 =?utf-8?B?SjJXcDZKV3ZmVGFmcUJpRldjWHAwenZXQjBwRkdjK1JjRExlandrNjlKdHIx?=
 =?utf-8?B?R0cxVTQ4bThUdUZnU2h5bmwzelRWanZzMnN3VEdoVFk3VzhpYVFWbVVQMXFo?=
 =?utf-8?B?d1UrVmtQQ1h1eFN1NklXZTV0TVJMbms1YlBjeG1lVlZkcWd1N2FOdUNUYk1v?=
 =?utf-8?B?Q2JGMHYwRDBBZjhXTGF2T2tDZm5qR3pVUDFPRjVuTmFoQ21RL3YxWGw2ak1O?=
 =?utf-8?B?ZWw3c1VaK0ZnRTBKYjU4N2djVEMxR2FxOVlGTWVpc0YweGVQRFdtYlVqYTFz?=
 =?utf-8?B?bWh6Z2c2bVV3aG9TVzV2VGhocmlXTWtBRTR5YURKUHNUNkp4MjhEYmRzb1hk?=
 =?utf-8?B?RHh5dFZJWHFnZ1piRjZMSTdlb1gxblcrMEdyOVh3OUV6ajE0UFpqNllhdjM3?=
 =?utf-8?B?ZS9hbmkyaHRqNzV3MEE1MUxlZWhvSzg4NnpsVkxnbmhZd21TM2gzTGs1Q05v?=
 =?utf-8?B?YXdqakFWMGF0NG4wRHFkdU5LSlFPSEErV3ZKTWVYNTVuMGhkaWhpa2JRZ2dv?=
 =?utf-8?B?NjJ1bkx4QzJUTHJQdXk5Rnh6OVR2Tk92aC90TVhmMkRNekMwYjNJZFRKMWhQ?=
 =?utf-8?B?UHYrSmxCQWo5SklwUm94Z250T0JvZGh3WWR5bkwvZlJGMUxQeDJ6d09BZHkw?=
 =?utf-8?B?aHpOeEtvSEU2RGxsNy9lWFpxWjFEemdIYVcrRHhDa2VqMjJ2eHNrVHhWdzdD?=
 =?utf-8?B?TTgwR0VLOTdYL2d0TStZR2V6bnB6bFFMWFB5RjlLRE82MW4zdHBzQStyTGwz?=
 =?utf-8?B?WHNtTGcxRE5HM2t4UitIUk5YUmM2NmpIM0U3MjZVQXhVNkFjSFp0d3FGcTl1?=
 =?utf-8?B?dHZDTm13REJHRDBqdmVaVjBENE1jQ2dEa0R5OXF1anl6N0puTzBHcnZhamtJ?=
 =?utf-8?B?MGVzcTVPcFlSV2E1V0xwRDdGdmlQYU4wNkRnRG14Q3NESklaOW4yOWJJZm9D?=
 =?utf-8?B?dW5aNUtQTmlSWVZab1kwZll5dHcyUXZnRmh6OHEzUmhHdmNGbWwrU3FzUEVm?=
 =?utf-8?B?dVVHSkZKS1htRGhaMmlwRXkrc1dKUUp1TERMd3FYNXZHNWtwdnFOREhaMXFo?=
 =?utf-8?B?VUV6NFFaZWFGd0VXZzRBZmFXamNRWEc2bHZIS2ZMb1Q5d2VUZVEwSFovS1U1?=
 =?utf-8?B?QTlVWFVVVlVNOGtLSndMbnVUekRrZXBZQU9sb2gzVDR4YzVFNWVBVUVnc1k5?=
 =?utf-8?B?NVNpMktLUWdDVXYyNm41UDN3Z2M0NDJQK2t5OXRkVlpLUXpycmdxeVJCMjBa?=
 =?utf-8?B?VVhHdzRDWDJFMHlKNGo0VDVIU2ZzS0JzS3BzU2ZKQkRKcGVrVW00VGtzckZY?=
 =?utf-8?B?U284bDdlTG4zNVdMTmpzV01nNC9vUHpQaTl2Q3FGVEMyTTY3WnFmUnhscjd5?=
 =?utf-8?B?UjE1UGZhbERZdzBCWHQ0Zzl6RDRoVVlqQks3NUtNYkJ0T2I2VThqaVRYckJH?=
 =?utf-8?B?bjN2UVpXUmZQQnU2ZVB1ZEZnQW1rYW1EcnQrWkxPRW92ZDlvWGRNZUNTam5l?=
 =?utf-8?B?S0RrdHUyRjEyQzhuMldocEpXcTJoS0xJazBNUm04ck1BeTVoQ3FQUDltOGFK?=
 =?utf-8?B?WEp1MjdHenVxZ3pFeEhpUFB5eE9ZRmFWTWVWM25uSXFuT2UySDdBemRDTllR?=
 =?utf-8?B?NkxESkpOQ0Z1V1NvV0ZhbXJuS3JaaEJUUTRHU2ZpQVpTWlRXMjl0c2I1TUhM?=
 =?utf-8?B?NXRQeHljOFFYTEtVMWJQTENaSFZYU2Z5Y2tqL08rcldzT1hYai9qL01GeUFp?=
 =?utf-8?B?MDhadlNGQmtnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWx1SXZWWmpwK1JWTzhnMzdRMmxLQ3FVTWR5dXJKRjFjR0QvTVlJbHA1TWh4?=
 =?utf-8?B?SDZmT1B5NjBjTWhPTnhSMTMyMGdoR1JHQkQxcS82Mis0d2p0dGcvcC9yeFBt?=
 =?utf-8?B?N1BQREYwRWY5cHVnNEhBc3BrNjEyZFlVS1FBU3R6MDBrc2dyWWJLUkNvSW5K?=
 =?utf-8?B?SzN0QXlHTHZCSTFFblpYSFdPV2dxOEZZVkdiY3ZZU3VIb1lGakZiaUNoakpn?=
 =?utf-8?B?dWNtSmRsVHR0MHdmUUVXTjlYRVJCSnc1dTBuZk84L3A2YzBHODM4ZzJjS1U4?=
 =?utf-8?B?aGtqbGx2TFdER2xaTUdsRUxwYlc2U3lGbUhVdU9YQmNYdk1LNGxYRW41U3R3?=
 =?utf-8?B?VkFQYitDeHVRTXpwZExIWktNd2dmcjV6Lzhjck5pSzIydEN2ZTVmLzFEUHd5?=
 =?utf-8?B?SUhDY2ROTXdzVUhRSDhlTmRPN0t6aWY4aFE5SkRsRUtvS1RhN1oxaTJvQlNr?=
 =?utf-8?B?WTR3YUdVb1F4YitIY0pmcjBDTldJTWN6TjZKay92MzBZRXB3QVZjZXhLbndZ?=
 =?utf-8?B?YUtWWTFubjY4Z0xHV3E4cmt2TDAreFUydDd6RmloQmRtZmUxREdqR1BOUlYv?=
 =?utf-8?B?OHBYaGhSNXFMSUhCUFFTbGVHdlA0b1V3QTUrRXAvcnN5ZmxMRFNmL2IwNlpK?=
 =?utf-8?B?b2VFRkpXRk44MGJ6QXpnRmRxa1BZR01ScnpraUFObVFhRy9VZFdZK2NPYXpT?=
 =?utf-8?B?bDJobHVEaXRTdHNMaVRYRm80YW1iYkY3QTBJTjA0NlpGcitoTFQzYzExWCtv?=
 =?utf-8?B?emFyTFZNL3haakw2bEZjV0NMZU01dUFicHV5Q0o1YWVCem44eDVLeHRRUDNy?=
 =?utf-8?B?bjRuUmpPVXFGbHBMbkN4dVU0azBna3doazBYcmZ1aElhOFJkWTc3bW1JaUxC?=
 =?utf-8?B?UU1LM29RWXZZUFZXeHRJZ1F6SDhPVlBwb09ZK0YzUy9YQS9UVUZYbmpJalgr?=
 =?utf-8?B?enRua2d3TTJxQWhiNk8xSHpLSjZVY1poSzRSMXFRS3FNMWNnY21OL0tJOXQ5?=
 =?utf-8?B?ZUdoYnozNkxQemlRai9qSzR0QytQV0tmMXc5KzNWT3JtcVdCVkxkOUpwdWN4?=
 =?utf-8?B?U29TK2pWQUEzNjl6QzVMQ2F0dE5halQyUCs3Mm5KdHUzMkh5N2ZlVjRtd1FT?=
 =?utf-8?B?OWxTSzR4Z1h2aUdTbXA4ZlFGL0oxZUZQQVRobm9oeFRGWWc1YVozdDRTd3gr?=
 =?utf-8?B?SElCcGRUSTRsZFU2c2xaNklEbFVtSy84aGhNMmRESHAwcXlxL1ZhNWVEK1Fy?=
 =?utf-8?B?Y0RvYVlMaHRhTllwR0xzMzZDVnNScWt5WEVuSVpKSVdHTitvUTVzZUpzSmJ5?=
 =?utf-8?B?cHJyYldiTDN2bFFOTFhnbFZvREpIVjlzWHQ0RllzNDJ5L01QZUttbUJZOHB3?=
 =?utf-8?B?NjJmdCsraTNmYkp2eUhIc1ZoOWF1K0NQam5ZUGI5eVpULzBpSUd6RmMwR2R0?=
 =?utf-8?B?SGtpNlJCUEkwSjh2eHQ1L01peE5wbm9pMjFEMno0eUtDUnNXMlpmc1Q1VmlP?=
 =?utf-8?B?OGh5RnlhTUkrVGh0NnpReWtkanVRNXE5TnlyVGkzejNKS05LRWdXckhWQm1v?=
 =?utf-8?B?NkorSEZZUFFYNVp4VnAzemNaNjlnLzBEZDFnMmpFa0pzKzhLc2dzWXRrRmRQ?=
 =?utf-8?B?eVM2MmhBS3V5cUlKbzhOM05uSG44WkNlS011TlFlYS9CMGxNTngxdmo2MnpD?=
 =?utf-8?B?Mmx2QzRQWXZRVi9Ca1RkdUxNRlZ1dUZ5K1Z0QjNmdFpnajJGcnRBclpPZDF5?=
 =?utf-8?B?aHlEcFh6WVhXWGxIdXNzdGRxN25mUUl1NDAzUUhlK1FWZEMzSVdERVdoOVk1?=
 =?utf-8?B?bDNLZzNjNXUrQ2hySWJuQy9obE5xVnVMeGlMclRCT1JJSmhYSTg4OC92YlE4?=
 =?utf-8?B?SFRPRkhIWEVCRzFRbzkzNFM5dmZ4TEZnYTkrQzdhTitYaXJwVFM5Z3hIZENz?=
 =?utf-8?B?bmRUaEhXVEFFb1UyUTdObk5JclNQYkYzelZjODFwRGlXRjlJeFMyNXVwamhF?=
 =?utf-8?B?eFRQeTdCNjV1cTBXRkdmQjVjUER1cVRreEZNdU5TMmNTZGE1OU5rSndRRHMy?=
 =?utf-8?B?RmpDOENOaUtSL04xQ21obDRNaEpTUTQ1cEFrNDBLbkJVZXpMTk9lWFp5V284?=
 =?utf-8?Q?yRn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17acdcd6-47c1-46df-2b34-08dd525bb461
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 09:39:57.8026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9jIQhrq5a4FiQrh3/IbiEdVlLKSnjwitWeTY8sfafS4VIMZ9ArqyRbYUNRVjM+DTskVS8bC8IY0kaeCObm3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8486
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDHmnIgyNOaXpSAyMTo1Nw0KPiDmlLbk
u7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgVG9tIFJpbmkN
Cj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54LmRlPjsg
RmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJvb3QtaW14IDx1Ym9v
dC1pbXhAbnhwLmNvbT47IEx1a2Fzeg0KPiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT47IFNlYW4g
QW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPjsgU2ltb24NCj4gR2xhc3MgPHNqZ0BjaHJvbWl1
bS5vcmc+OyBBbHBlciBOZWJpIFlhc2FrIDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+DQo+IOaK
hOmAgTogdS1ib290QGxpc3RzLmRlbnguZGU7IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2Ug
R3VvDQo+IDxhbGljZS5ndW9AbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsg
WWUgTGkgPHllLmxpQG54cC5jb20+DQo+IOS4u+mimDogW0VYVF0gUmU6IFtQQVRDSCB2NCAwNS8y
MF0gc2NtaV9wcm90b2NvbHM6IGFkZCBTQ01JIG1pc2MgcHJvdG9jb2wNCj4gcHJvdG9jb2xfaWQg
YW5kIG1lc3NhZ2VfaWQgZm9yIGdldHRpbmcgdGhlIFJPTSBwYXNzb3ZlciBkYXRhDQo+IA0KPiBD
YXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4g
Y2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwg
cmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMNCj4gZW1haWwnIGJ1dHRv
bg0KPiANCj4gDQo+IE9uIDEvMTUvMjUgMjoyOCBQTSwgQWxpY2UgR3VvIHdyb3RlOg0KPiA+IEZy
b206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gU0NNSSBtaXNjIHByb3Rv
Y29sIGlzIGludGVuZGVkIGZvciBtaXNjZWxsYW5lb3VzIGZ1bmN0aW9ucyB3aGljaCBhcmUNCj4g
PiBkZXZpY2Ugc3BlY2lmaWMgYW5kIGFyZSB1c3VhbGx5IGRlZmluZWQgdG8gYWNjZXNzIGJpdCBm
aWVsZHMuIFRoaXMNCj4gPiBwYXRjaCBhZGRzIFNDTUkgbWlzYyBwcm90b2NvbCBwcm90b2NvbF9p
ZCBhbmQgbWVzc2FnZV9pZCBmb3IgZ2V0dGluZw0KPiA+IHRoZSBST00gcGFzc292ZXIgZGF0YS4N
Cj4gSXMgdGhpcyBpTVggc3BlY2lmaWMgb3IgaXMgdGhpcyBnZW5lcmljIHByb3RvY29sID8NCj4g
DQo+IElmIGdlbmVyaWMgLCB0aGVuIHRoZSBzeW1ib2wgU0NNSV9QUk9UT0NPTF9JRF9JTVhfTUlT
QyBzaG91bGQgbm90IGNvbnRhaW4NCj4gX0lNWCBzdWJzdHJpbmcgLg0KDQpTQ01JX1BST1RPQ09M
X0lEX0lNWF9NSVNDIGlzIElNWCBzcGVjaWZpYyBwcm90b2NvbC4NCg==
