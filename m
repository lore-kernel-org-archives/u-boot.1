Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99DAE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD52680079;
	Fri,  3 Jan 2025 04:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZTc+QEb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF3F80196; Fri,  3 Jan 2025 03:59:59 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B883080017
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 03:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/CQBXh0LdK/VSIi6HvHUTHOxd2pu9sDy8WGgZp6OpCmmcPzSB7stvUIrBneHgJj3GdlB24JYIJSfKnCCbA9QFnH/LZ+5lJMJFRfIOJIqBDUdjZFAl1xJl4FqOB+yXUSwW02AFGuAUkioroTmXG+J8vo/cd2cSbLO+4EwYVBh9ZR7SYN96NTL92P28KWHEDFE4TUvT9CAuzkxFCv6aCBydDdmcu7FKGRasvv7vk38EFTk1BmOzqbfMgacz25VKCtORrUxSQ/aHzFu3lbq4lNsJr+1vREakEAzVGExKGdAMW9ZSH9fkIWxZLbPMdU6ohxNfA9OxYoKWw+5r7HlFErYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/v0au1KOSiaA8sfyfDCILmyk9hmQNoyvRXi8L2mtGo=;
 b=k6VYIieMK+LnwQtUUHSYhyJQefnYatB7/SbOwvq2RQInrcMRQzxLwsy7HZSA4S2JB9LxiNhINw6H1APRiomf3sdPDolYCppEwvhECBl3pvA1Rm8NDZ1BupgLMnG1kIoELyvr6AMv6/UUjLO+5FTHYFMtfsg7QMoaomggAREu2aP9gVU+pqtqyVHhGeR1slPxIsdkeJMYLvwjh3PktNZN553eTRznXDmAKC12h6Da0qEhhMmYjkLGI/aS7hrxHoPLr7c6ELkfx9dgLEL1s0u4YGO5nnjMXqssan40BvJNTKLxxZzgn0aUOYoebgrvawpiu7ECUa2uNxX4byOz/2sAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/v0au1KOSiaA8sfyfDCILmyk9hmQNoyvRXi8L2mtGo=;
 b=ZTc+QEb7atO3xs/GdcD8+rm/PuMeQxyExtiZ2flkue8DM+5N9k8XYVIjP+LZ7Hcaod2oacrEf4a/ms6dnGaCWGt4wDV0un81KMtroz9PtoUkqdTWBQRvQ39i8sIodrW4FPmkFyr79fh+1iOY0LlhLrOLxRI6QUg4jxX1BcEs4o1+IXNe9uedoK9cnhA4GuGZy7mCpSnR1Aek3t5UWeWtYiKHqwbfRxKcy3gnfBDK9F/P5SBJKaqzWWukJWzoaknnHi5ehadaW/gKLq4eJbIRmfZ2xOVKGQhHMGjmLZJ8kePqqWk3TO+/gh6pZpAogAXpUnV2Zpz/oqH5F7niccvHig==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 02:59:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 02:59:50 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "marex@denx.de"
 <marex@denx.de>, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Peng
 Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYyIDE2LzE3XSBpbXg5NV9ldms6?=
 =?utf-8?Q?_add_i.MX95_19x19_EVK_board_basic_support?=
Thread-Topic: [EXT] Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
Thread-Index: AQHbUoq3EiCr5MsbS0ytjsh9g3+ir7MEMqEAgAA9NDA=
Date: Fri, 3 Jan 2025 02:59:50 +0000
Message-ID: <PAXPR04MB96444F97FF961FF6F3A7FE72E2152@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
 <CAJ+vNU3p8T5VDoRcxuxvM_dzLK0dRzixUsb1nQp-WoN89VMhkg@mail.gmail.com>
In-Reply-To: <CAJ+vNU3p8T5VDoRcxuxvM_dzLK0dRzixUsb1nQp-WoN89VMhkg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU2PR04MB8839:EE_
x-ms-office365-filtering-correlation-id: 308cace8-2a6f-4383-1686-08dd2ba2b079
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?R2hQOWlYV0x2d3dGd2p5a0dScUZwT1pDUWEwSzJwcDQ5dmp2bHVteFRPaHhM?=
 =?utf-8?B?UDlEZ0YrRWdZZU51MEtpa01yM2hxMzRCbTNoQjlxbitJMVBXWG42eDRYYVdY?=
 =?utf-8?B?Tk5tWTZrVXF1bW9OdlJIRWhCL2lxbmNFZW5DK2lJWEhDTndkaGozanAwQnhT?=
 =?utf-8?B?dk5hMHp2RGU5Zld4Q09SZDBNc2Y1dWY4d29EU3o0czIxU08vR3pMSWZRZzlr?=
 =?utf-8?B?OW5XS1RKeENzUXBOdDd0UXQ5K1VrNFpkcUR4bFR6TEdTSVBZUTBNbmlWSktV?=
 =?utf-8?B?ZXlrdDRVVUdxKzRlSGJCVDRuaWZ4ckcrekUyUmlnUlZGc2lNcmlDS09aSEV3?=
 =?utf-8?B?WUNTbjZhQ0dGeldWRnAwNS9vZnpVLys2WjBydWprSTZ2YS9oYzVJdEhnVysy?=
 =?utf-8?B?MDVJVXZ1ZGNDVElWTGtKNWZxV2V6TGE3bCtLajdIditIUzh5WE5TSXR5VjQ4?=
 =?utf-8?B?MWVqSCtXOEsvaXFKTVNmQXRqNG41bG55ck8wMlhyeFJYdXZUT3k0TDk0S3Bk?=
 =?utf-8?B?Nmd2WHowSGRJUllrY1ZXeEQ1ald4S1pBclZPZTVzVXJLbTJzbFZUK0w4bDlX?=
 =?utf-8?B?RUE4QXhJZWVIanV4RW81Q3d5RGxLaXI5Nmxsa3M2bVUzczYyY0t6QStHdjRV?=
 =?utf-8?B?dU9BRHduYnhpTlFPZHZ2bzB3cTBqcnRBd1ZBRm9IZ3oxVWRicm9mamE5RXo1?=
 =?utf-8?B?ek1HVk9wVU9pSDY0cGlnbkZ3bWcxaDhVTUZXNEZLK0I1M0RPeVFRM1p2M2Fy?=
 =?utf-8?B?TXhkbmdDUkhnUS90LzQ3MEJqaGpKN0daK3Q5WFJMVEI1MDQ0czd0K0QzY2xm?=
 =?utf-8?B?ck5FZ2VsNXgzVDhKTCtuRHpuWGh2MjlmYmNrZUwxc1lMTUxMbEkwMmovNFBa?=
 =?utf-8?B?T3dxWG1IRytNMm5GSFoxQVFuc3JDd29qOUVrTlptNXRWclFJSFNtU2JXdUMy?=
 =?utf-8?B?S293QXRYZVZQMlhXYTBBVHpPeW4xbzNJMWRJQmRqTGVOaCtCbEYzc2Yvdzgv?=
 =?utf-8?B?MXM1VDRMOGJwcWF4dmRna01ZUTZoSlRRQ0o3QlZpU1p6ZW54WXdyS2xMQXRn?=
 =?utf-8?B?dE5yVGlBK1hERVp2ZExUWGthQnZsN2EyZXZVUHBLenhxblo3Y1RIWFF5S01G?=
 =?utf-8?B?WHdMUUpsLzRmRGE1L2VETVBndGY1VFkxU2IzRVArM2wyNTFuS0dtWUVJcUkz?=
 =?utf-8?B?L2xnTWo1SGN1bzlzQ1BBUWhXblNQdjc1b1NmeHJoWkpac05JY2lqYWFqNEEz?=
 =?utf-8?B?d1Z0UWFvYXBoT0tHYXViS0FKeEpkTmNQeDRPY3IzeFhWcW5abjhRVUFiYW1j?=
 =?utf-8?B?dE1Tck9VSkNYdzBkei9TMlRUZ1V4UHJvSmhPa0hqQUlnazhTSVVOenI1MVNH?=
 =?utf-8?B?VlExai9hVDJQSjVadDN5VE4raDdPQzMrUmF5NWtWcTA0R1l3Q1V0MWVaU1pv?=
 =?utf-8?B?Wng4RWo2d3REUXhET29ERGF1K0NXYTQzdlVZNXN1NU9tTE5NNUdEbFlMZk9p?=
 =?utf-8?B?MjRoWXRsUks5bWt0YkFpenUydVdYOFZyTkczQWgzRDN1TVJ0R2l1M0Z2YURV?=
 =?utf-8?B?VkZrRWVVdCszWVprN0hyTjhtR1dsbjVPVlg3aU1RZXpYb2JHYStLemhwNkpE?=
 =?utf-8?B?WXg2ZUovU3BoUldGdk9MM1kxMHduVjZEdFhLemM1K1IrbkZadkpMd1p3Y2R3?=
 =?utf-8?B?WlZGcUtqTUV4RGF6Njg4K1RRZUNDK2UzQjE4VnJJQkd3b1gwb0lqWDZzK291?=
 =?utf-8?B?ZXMzQ3UzZXNDd09xMHBnbllpaUtkZ21TUy94SWlwRVZNaGlFU0lMdHAxTVov?=
 =?utf-8?B?NFFkbWFlQTdiS2FiZ1krcDlwa3cxOExjMTVpTUlrekRmc2ljM3dzVEIzTHgv?=
 =?utf-8?B?aS9rTE9NVWUwdGxUdnQrL2ptWVNEaEZFUjFlUUI1bHp5ZHdFdDVJcHBvbzM1?=
 =?utf-8?Q?gdflmIf2DFmBgSPCgWFUkdMUZ7bpErZM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MktucUk4NlNhV0Mzc1BvcU9obUFXSGd3dEV6NlJHK2g1MytTc0pjS0lQYnpp?=
 =?utf-8?B?aTlYKzRmSUx4ZjU4WnYwMG1UalRON2p2Tys4MHdDU2V5NTJxYU4veHYyRElG?=
 =?utf-8?B?UVV6dmwxSmRyeE94d2hZWkRoZjk4MEwrU1ZibFFRNE1jaTdPSlhKY0FHSVE2?=
 =?utf-8?B?Nk43UmdqOTZ0OXYxWjJMVk9FRCtvdWk2QU1LS3o1eUpxTkRkeFI4a2s5Z054?=
 =?utf-8?B?Q1pmdWNiNGRieXlQaTd2WVA0bFFvQ3J5M29RRURiK1VpNkxteHIvVXlqbExF?=
 =?utf-8?B?Mjd1VzYvUGw1eXhzenA1cTNqbXJ6elREK0U3Z0Z2YlNubTR0RDNpL2JBemJm?=
 =?utf-8?B?TWpRS3MxUzNPYkpkN2EvcUVTbnMrTUVrOFNRVEN0dm9Tc00xbjVVTE5JMEFG?=
 =?utf-8?B?bjVybDNWNkM4RTdzVnBrMlgvUXl1dzJVajFUNGdUQ2pyUTIxRm1NNjE2NDJz?=
 =?utf-8?B?QVg5SEVsRTF4UGpyM0NxajBCU1g4Zi8xTWFkUlZuYzhuVUJQakNyYkg5QjJ5?=
 =?utf-8?B?RmRTNDRhSVRSTFduVS9tb0FPT3VUS3c0cWs1S1NNeTFuczJ1dWJEUHhzYlFv?=
 =?utf-8?B?bmNFcjNLUDhJYWpQUHlaTzY5ZXVUN3R5RUtDL2pPa3dEMzI1ajFYWVdvdlVD?=
 =?utf-8?B?ZlhFWk0wWGxSZ1JFRDh5TjhPR1FBUWxPUGQ4V0RUc2hjY3RtNll6M2tYQkhR?=
 =?utf-8?B?U0l3VTlmajNvekk3dWRQRFFMTGRKd0RKaGs5WmVsMVVMd0ZkNjhIUlRKaW5m?=
 =?utf-8?B?VWxvb054bnc5WGQwTjBGMUtiUGltc2JmQXpBaFd0U00vL2N1bEhIcGV4WG5s?=
 =?utf-8?B?dEJlUElXTkdDY2hBbzVVK05ocGxnMXF5L0FsU3d1WjFEYTliY0ZIbnF1UVF2?=
 =?utf-8?B?T2t5bGFXWnJBalMrb0plMnVZRSswNE5jUTlYYXRuS09pak13cFFjMlU5dkla?=
 =?utf-8?B?MjlseEQ0Z2RzRjM2VzVrNUJBR1ZENnlqUzdrVXJiWHptTUtRTWRnSFpRZmw0?=
 =?utf-8?B?elBJMWxvTjNsQU5QYWtTS3JLajloZXZ5OTh2aDNqdDhELzMrcmR0N0xOQ1c5?=
 =?utf-8?B?VHVRYlI1c2R4OXd5KzJZak5qT2dKUEdzblpsc2xBeVhQK29LNUc1NWtaMTNF?=
 =?utf-8?B?WHVpRlNFYUNMNkFjNnI2RHE5Ky9Ma0JzMm9SWkU2R2w4cDhoc2drMGxqVWl5?=
 =?utf-8?B?WUZFSnRoLzdHcEVVbVBGdTRPK0dtZkNRWExJTTNSbFhnVSsveHJHWGFnYWcw?=
 =?utf-8?B?WkxmbTJ6VEM1OS9IR2ZQa2kzOGVZUTZBWFk1eGt5MHJUSDRpYW1DbUxFWFZL?=
 =?utf-8?B?QVh2MVZpVERZY0xUdG9iVUZBWlNnZ2p4Q1pOTkNta2JsUU5vUXZaSk9IN2Mw?=
 =?utf-8?B?YjFLdzhlNTNXOSs3ZFVmZ2lJN2l1NzA3eEpIWWZrUi9pNzZuYmJTbGFpVmFI?=
 =?utf-8?B?U3VuVFpNQUNnbnZ6T0ZiUmVMWGppbEZhbnY5UnkzRzYrMFEwQkpJUTNDNDl2?=
 =?utf-8?B?RndxUUo1bmtjMWlKRUZ4NkhnNkRiOW1QSmUxays2NWlVUkR3NmRzMzloR3Rw?=
 =?utf-8?B?RFZNYi9LSkdCMGRWdzlmOU1NYnRuM1U4MWpxM3JrMmxWT3pNK0xhM3pnWWc1?=
 =?utf-8?B?dTcvRktCVXBBR2ZTZDlTNzE3VjdrMkFsdmc4SVdiVXZIZFpSRHVEN0NGeThH?=
 =?utf-8?B?NHZ2SFZCeTQxUGNFSVprZVBlaFpDNzZNcnQzQzZXRXVhSVF1UW5GRzdFc29y?=
 =?utf-8?B?YS9LMkl1YjRmZlpJRXh6YUk0VkZYRThKTFoxaUxFaVRXcVVKcS95K005R0tY?=
 =?utf-8?B?bXlFMnVmc1FmbVpmSTVSUGN1SmRJdGpPTDJQdzdEM2pWWkk5UmdNN0NtMzRL?=
 =?utf-8?B?Z3UxZmdBeHA2bEtQeE01bVczSWU2TGMyOVhaS3ViM0I5N1YzOHl3bTFhY1Mw?=
 =?utf-8?B?aVp6WERrdE0wcTA5ZG0vZGE2ZU53Witoc25MUTJpOFM1Vzg3aUxJMjFJTERI?=
 =?utf-8?B?aVJmK2JWY21iczlsaVNFVC93UGRES1YyUEdVdktjSEZTZk9NMit5MG5BRTdR?=
 =?utf-8?B?UnBCVkxQclhwT1pzOGE4eWpsSUZjTFBKKy9OL3d1TDBUTmZsM0RoS29sbUVq?=
 =?utf-8?Q?mbdLtO6VkXPSHaVimdJPmfuZr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308cace8-2a6f-4383-1686-08dd2ba2b079
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 02:59:50.1376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9U1YArcSp0MOfkd6KmqaGVcvEbYKFKHb7q00Vnr+ukmdpRZp1gyoCk7xfFhvHPA/cfMg1DGIG5ziyeZ2Cp/BXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVGltIEhhcnZleSA8dGhhcnZl
eUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQx5pyIM+aXpSA3OjEzDQo+
IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IOaK
hOmAgTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IFN0ZWZhbm8gQmFiaWMgPHNiYWJp
Y0BkZW54LmRlPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJv
b3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47IEx1a2Fzeg0KPiBNYWpld3NraSA8bHVrbWFAZGVu
eC5kZT47IFNlYW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPjsgU2ltb24NCj4gR2xhc3Mg
PHNqZ0BjaHJvbWl1bS5vcmc+OyBBbHBlciBOZWJpIFlhc2FrIDxhbHBlcm5lYml5YXNha0BnbWFp
bC5jb20+Ow0KPiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgbWFyZXhAZGVueC5kZTsgQWxpY2UgR3Vv
IDxhbGljZS5ndW9AbnhwLmNvbT47IFllIExpDQo+IDx5ZS5saUBueHAuY29tPjsgUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+IOS4u+mimDogW0VYVF0gUmU6IFtQQVRDSCB2MiAxNi8xN10g
aW14OTVfZXZrOiBhZGQgaS5NWDk1IDE5eDE5IEVWSyBib2FyZA0KPiBiYXNpYyBzdXBwb3J0DQo+
IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJl
IHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBk
b3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwn
IGJ1dHRvbg0KPiANCj4gDQo+IE9uIFRodSwgRGVjIDE5LCAyMDI0IGF0IDY6NTfigK9QTSBBbGlj
ZSBHdW8gPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBZZSBM
aSA8eWUubGlAbnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBpLk1YOTUgMTl4MTkg
RVZLIGJvYXJkIGJhc2ljIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZZSBMaSA8
eWUubGlAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0Bu
eHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4g
PiAtLS0NCj4gPiAgYXJjaC9hcm0vZHRzL2lteDk1LTE5eDE5LWV2ay11LWJvb3QuZHRzaSAgICAg
IHwgMjI0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGFyY2gvYXJtL21hY2gt
aW14L2lteDkvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAgNiArDQo+ID4gIGFyY2gvYXJtL21h
Y2gtaW14L2lteDkvc2NtaS9jb250YWluZXIuY2ZnICAgICB8ICAxMCArKw0KPiA+ICBhcmNoL2Fy
bS9tYWNoLWlteC9pbXg5L3NjbWkvaW14aW1hZ2UuY2ZnICAgICAgfCAgMTUgKysNCj4gPiAgYXJj
aC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL3NvYy5jICAgICAgICAgICAgIHwgICAxICsNCj4gPiAg
Ym9hcmQvZnJlZXNjYWxlL2lteDk1X2V2ay9LY29uZmlnICAgICAgICAgICAgIHwgIDEyICsrDQo+
ID4gIGJvYXJkL2ZyZWVzY2FsZS9pbXg5NV9ldmsvTUFJTlRBSU5FUlMgICAgICAgICB8ICAgNiAr
DQo+ID4gIGJvYXJkL2ZyZWVzY2FsZS9pbXg5NV9ldmsvTWFrZWZpbGUgICAgICAgICAgICB8ICAx
MSArKw0KPiA+ICBib2FyZC9mcmVlc2NhbGUvaW14OTVfZXZrL2lteDk1XzE5eDE5X2V2ay5lbnYg
fCAgOTUgKysrKysrKysrKysNCj4gPiAgYm9hcmQvZnJlZXNjYWxlL2lteDk1X2V2ay9pbXg5NV9l
dmsuYyAgICAgICAgIHwgIDU0ICsrKysrKysNCj4gPiAgYm9hcmQvZnJlZXNjYWxlL2lteDk1X2V2
ay9zcGwuYyAgICAgICAgICAgICAgIHwgMTE3ICsrKysrKysrKysrKysrDQo+ID4gIGNvbmZpZ3Mv
aW14OTVfMTl4MTlfZXZrX2RlZmNvbmZpZyAgICAgICAgICAgICB8IDE3OA0KPiArKysrKysrKysr
KysrKysrKysrKw0KPiA+ICBkb2MvYm9hcmQvbnhwL2lteDk1X2V2ay5yc3QgICAgICAgICAgICAg
ICAgICAgfCAxMDkgKysrKysrKysrKysrKw0KPiA+ICBkb2MvYm9hcmQvbnhwL2luZGV4LnJzdCAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBpbmNsdWRlL2NvbmZpZ3MvaW14OTVf
ZXZrLmggICAgICAgICAgICAgICAgICAgfCAgMzYgKysrKysNCj4gPiAgMTUgZmlsZXMgY2hhbmdl
ZCwgODc1IGluc2VydGlvbnMoKykNCj4gPg0KPiANCj4gSGkgQWxpY2UsDQo+IA0KPiBJIGZvdW5k
IHNvbWUgaXNzdWVzIHdpdGggaW14OTVfMTl4MTlfZXZrLmVudiAoc2VlIGJlbG93KQ0KPiANCj4g
PHNuaXA+DQo+ID4gZGlmZiAtLWdpdCBhL2JvYXJkL2ZyZWVzY2FsZS9pbXg5NV9ldmsvaW14OTVf
MTl4MTlfZXZrLmVudg0KPiA+IGIvYm9hcmQvZnJlZXNjYWxlL2lteDk1X2V2ay9pbXg5NV8xOXgx
OV9ldmsuZW52DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleA0KPiA+DQo+IDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLjI3ZTA5ZDNkNzBhMDY4ZWZi
OTdkNg0KPiA5YjI3MDg5DQo+ID4gZDFmMjEzZjM5ZWU5DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL2JvYXJkL2ZyZWVzY2FsZS9pbXg5NV9ldmsvaW14OTVfMTl4MTlfZXZrLmVudg0KPiA+
IEBAIC0wLDAgKzEsOTUgQEANCj4gPiArc2VjX2Jvb3Q9bm8NCj4gPiAraW5pdHJkX2FkZHI9MHg5
MzgwMDAwMA0KPiA+ICtlbW1jX2Rldj0wDQo+ID4gK3NkX2Rldj0xDQo+ID4gK3ByZXBhcmVfbWNv
cmU9c2V0ZW52IG1jb3JlX2NsayBjbGstaW14OTUubWNvcmVfYm9vdGVkDQo+IA0KPiBJIHNlZSB3
aGVyZSBtY29yZV9jbGsgaXMgdXNlZCBidXQgbm90aGluZyB1c2VzIHByZXBhcmVfbWNvcmUuIEFs
c28gdGhlcmUgaXMNCj4gbm8gdXBzdHJlYW0gTGludXggY2xrLWlteDk1IGRyaXZlciB5ZXQgc28g
dGhpcyByZWFsbHkgZG9lc24ndCBkbyBhbnl0aGluZw0KPiB1c2VmdWwuIEhhcyBhIGNsay1pbXg5
NSBkcml2ZXIgYmVlbiBzdWJtaXR0ZWQ/DQoNCkhpIFRpbSwNCg0KaS5NWDk1IHVzZSBjbGstc2Nt
aS5jIGRyaXZlciwgc28gbm8gY2xrLWlteDk1LiBBbmQgdGhlcmUgaXMgbm8gcHJlcGFyZV9tY29y
ZSwgdGhpcyBlbnYgbmVlZHMgdG8gYmUgZHJvcHBlZC4NCg0KVGhhbmtzIGZvciBwb2ludGluZyBv
dXQgbXkgZXJyb3JzLiBJIHdpbGwgY29ycmVjdCB0aGVtLg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGlj
ZSBHdW8NCg==
