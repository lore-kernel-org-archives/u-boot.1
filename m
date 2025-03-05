Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4310C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EAC80F56;
	Wed,  5 Mar 2025 14:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xu8i4h3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8856980FB9; Wed,  5 Mar 2025 14:36:40 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE1EB8083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6Vp83eRl55+JdM2dM76+Qw/ZKEN4jzsLobj8QKgdqlJD+k/QECFL4qhCFrzG2/J8OJWcRtfQEUxfxcrQK9S7NQx/6ulE5bIDayWN19ZSFPaNoG0MOJQpCbiQ6pmDTKvT2j6Tc0yixL6KjgZUBHsi2BEQjtyZGsCJS8zzZ4CWmI6Hvg+Ydgtm1ztUZd8XnwvsNI4rEHr57FtXYrIEXO4ecWiUiktTL8LkTK0wEZrL6FFYx8RxEjXeEtrT9NnkSZVk4vkSkqVTd8p4uopLMuzaPiAWMB1lMW8rdvMFXOn8pk5C+m60vbLIa8WKxr+hc+8KOU72kmmt+i/9CjWzr7ZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVqlnOJJ+118NkTYDd+ciImp0TOX+PyO0gqg1Wt/FLw=;
 b=OxTvTJbmogdZHjONn9t5ucDwtFtJYLJzfgOZlkjEJi4JmxV7AfFxn47H+cn5F7doYqZjkfcJ0gGKzzKyz46tDXtj24V3Oki5TUUph7s1cPdJwzMWsswOZ2A4lw6kPqKO3ApghH9ZKngR0ujYve+B5OtEw10W0uUEqV1YrlpOROFZFMXboWqoCYjNFDGSVOQwmIWwVFt+zZ7yUnEsOFPxIyFWtdGoJ0zrja6mS6QkLh5e9a2j9cjXYTatK+HmUW0v/1j8hGSbpoICS5L+X8mrZ2937cgJXnlJM/E7zsh3BcEDvJ9pvZo4hK39JsYHt08nyDq47oqiSao29iL1wrL4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVqlnOJJ+118NkTYDd+ciImp0TOX+PyO0gqg1Wt/FLw=;
 b=Xu8i4h3KCRNy72ftACidonjHDv0GOFQ/bIsx82fUaDLMw4VIgp9Q73B3E4CiCEWNkUlGXICkRFFlBOD1bRMZ9cZouXjQ9YwF0CpXRMJXpqUtXN9r2k9EJ0Ubc5gHC59EjYzGc67zUAGeOZMuidnlOmwidW49tKu5FfqR1oYEEPHtDjx663qn88ABXXtvOBz4R+1EC7Wl232I6PWqAIOl3X+NJ/APQsB3GTXiyx4y89FJZ920cK80T5cnmczlD/ZKubW79HC2TAxKaT3ByfISpdVX0kvXV0E11TKvmT/UVzlE3DBvVWAhLioa5U9lvJ3fHELJ0X0dYU6Ec+lQcx0iCA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7314.eurprd04.prod.outlook.com (2603:10a6:20b:1df::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 13:36:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:36:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjQgMDQv?=
 =?utf-8?B?MjBdIGZpcm13YXJlOiBzY21pOiBhZGQgcGluIGNvbnRyb2wgcHJvdG9jb2wg?=
 =?utf-8?Q?support_to_SCMI_agent?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BBVENIIHY0IDA0LzIwXSBmaXJt?=
 =?utf-8?B?d2FyZTogc2NtaTogYWRkIHBpbiBjb250cm9sIHByb3RvY29sIHN1cHBvcnQg?=
 =?utf-8?Q?to_SCMI_agent?=
Thread-Index: AQHbZ1F+XbneYzJjuUCxxW5MfO0jxbNQy1yAgAA15YCAAQ5sgIADuNAAgAdZAACABABdAIAA1qkAgAKpf2A=
Date: Wed, 5 Mar 2025 13:36:35 +0000
Message-ID: <PAXPR04MB96443A9429499C5FF777EDEDE2CB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
 <20250224022831.GA9876@nxa18884-linux>
 <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
 <PAXPR04MB9644FE1F92AFF132649A7EA5E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <3b232bda-000e-4f6b-8661-eeb72fc78b67@denx.de>
In-Reply-To: <3b232bda-000e-4f6b-8661-eeb72fc78b67@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM8PR04MB7314:EE_
x-ms-office365-filtering-correlation-id: 86d00fa6-9d4e-459d-ab62-08dd5beabfbc
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SXd4d25zZUJNZ1RBc3JZaG9UQkd4UjR6ejNTdDRyZCttZE5XOVA0ZkhSS3R0?=
 =?utf-8?B?d3RqNjFXK25XRDY1clpHQ1puMkphM0gvL2NQZjNVUlo0M3hRODVrdmdCRm02?=
 =?utf-8?B?c0xvOTY0L0tBQjBpSHF1VmJyWnZkQXJHeXMzUDhxYkdlZ0tuYlZIK2szYVh1?=
 =?utf-8?B?cHE1MUtGWmFKZ3dLMXhTQ0dRaHJFZXhuaitsdHFQL2tQRy9VaTN2M2pYcTFF?=
 =?utf-8?B?eE8rVmNqSlpjY2FHYUFLc0ptT0VrQVRsYytUUThrQjN0SFFFalRFSVZrZmFw?=
 =?utf-8?B?cXhTOEIxTEdkK2J0eWtSTysxRzlyNFRUSVNjZUV3R2xwME9Ed0RTZ2tCUytt?=
 =?utf-8?B?YlJNSzMxVWpReUJVSHQzYWhkaG1NSnY3cE5IOTlpSjJNWDZuV29US2doK3B3?=
 =?utf-8?B?TzhmUEtsYjRWY3JGc1VWek5VeUk0VkNXNUE4TDlOTXZoTDN1Qk1UU3Z4amlF?=
 =?utf-8?B?aWwvVDhnam4wWlM0Uk01YXhmZXN0N0lTUU1YWllBMmNNM3ZPbzZRbFFLQ25T?=
 =?utf-8?B?S2lwZVp1YlJ6K2ZQSmlFdisrc1htd2t2VzYxaklSanVhY0JRK3BVU3RMNFNT?=
 =?utf-8?B?Z1ZnSVNKMTQyWDhVRjdmMlp2dDdITTlMeEZVQXN5LzdJQzd0Y3JLd05NQkoz?=
 =?utf-8?B?azB4UURRVDZDdk9vTENSYzdtMnNUZE5wYllRQWljWkU3RVd4Tk9BazE3NmFX?=
 =?utf-8?B?b2s5QjBZdFo3WE1IMDFUZ3Y2QzNFdnZDZ1VMZ0lOZXpiamNVMlN6KzJXMXVx?=
 =?utf-8?B?dkpaVmN1bERJelJhd0hvZDhlRXRRc0cxKy9pc3NCbHh1RklNTFdGank4U1Yr?=
 =?utf-8?B?Z21BLzQxRzdjUHh0Nmh4dkhuWWRNeWRST0w3b3NJTHJLejZBVk9TM01kcnpp?=
 =?utf-8?B?UDQ0Wmw1WGN3UXl5NStYM2Q1L3N1YTBEc0FDSHdxT1FPbXh2S1V4eFM0Y3JI?=
 =?utf-8?B?Yk5hV0dmT2ZHSjRFQzl6RFlGN3E2cGNlbXYwRXpYOEs4TjlMcjRkTHFvdjBD?=
 =?utf-8?B?VkhMa29vMUgrUmVIc0o2clZ1aXFzMXBCODNpZXRGa2R4M2VURWZ5VFRXSjVO?=
 =?utf-8?B?Wk03TXFHVnAyenlOTkFGZXRFTExUV3UvZWdMM3Foa1NqelNqVU41QURLd3B4?=
 =?utf-8?B?RTVLOGVqaGplT2dQSEVqNlMvVC9ob0ZCVXN2emlrNzNLa3BHYlI1WXJHOGJE?=
 =?utf-8?B?bDZVU1IrWm9KdnlJTDJnUi8xZENDSzRMNGVrYUU1YzFUa0xqQnlJYllCWURl?=
 =?utf-8?B?RCt1U29nZHkyaUNOT014eXVVZzZzQzJIYlZuZ3hiWG9OdGVXa25velUwNERM?=
 =?utf-8?B?NjV6MU4wY04xb3pWaUZNeVZHVHQ2QUpYby82aHNlN0VYVEwvSzRmSzF0OTZ4?=
 =?utf-8?B?WEhLYXVnZC9kbENyWm9Xd3dyUnNTSUtSWTgrc2Vpc1JNejZnMXJQRW1ZN0d4?=
 =?utf-8?B?UDRkdGlKM1dLZkNaanlPZ3V2Z1V5VDlHaHErZXdXdjlwVVQrd1VOTmNlN1dQ?=
 =?utf-8?B?T1hSTWs3Wk0ydXNtVFlIQkVnQWJmd0ZaSExLTFErSFptNXVIU3kybE44SHBL?=
 =?utf-8?B?a1QrbW5pMno3aWYvbXV6bTJkNC9HSkhudVNHNVg3L0FCcFRuZGdZYmNaR0ha?=
 =?utf-8?B?WXhDdTFkUFAyZjhYajRRSW1xdTc4WXB0TC9JRHVYWXJjeVo0eVpvUHdNQStP?=
 =?utf-8?B?K2FnbS9HdVZEejhwbG5lL1NsSVdlQjZrQkFTejJ4Ylp6ZlJFNUcyUTNZb2da?=
 =?utf-8?B?b3BOTFZ0ZU43a1BsOGNjcjBOL3BpNkh0c3Z5QUpCZHA0MlpnQ1RZVUM5ZVVG?=
 =?utf-8?B?QVJsVnBSdnAvR0VvYmtkb3N4RU0vZ0d2L0RETEwxTjZ4VHhaZGhDYVUyenM3?=
 =?utf-8?B?bVVlYkdLWDl1SzY3VlF5RlBaWDkrSGhHdjNmNGwzT2JQeWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1lKY3VpTjUzM3ltVVlQZXF5NUdVYXJyQnhKaHVuQTVmaUUySjd2ZlhzWXhF?=
 =?utf-8?B?U0hBT1NiQXhZRGRzODdqMmRhMS9mNDhYM0QycU5hNjlyTEdNek8zT1U2ZmYy?=
 =?utf-8?B?T3o4Vkg2ZVhNaUF5QnpmMXY3Vkh6eFVveFBram9oK09ZbnBQODdXbmM1alJO?=
 =?utf-8?B?ZVp3L1ZPVm9CSGVXdVBNNmFZMGtWdW9ra2RDZEJSdzNiYlgzdlc3ak44SG1t?=
 =?utf-8?B?NXhzbTN2dUlHUlVnRzF4SzJ4T2FwMlJJVUloS09nR3gxVUIvMkFObDdWbmk3?=
 =?utf-8?B?YjBIN3QrdUpBbGZobFA2Q2N6ZzR0VGtyYUhCanhsdGhNRm9Td3Z1aW1lK3lB?=
 =?utf-8?B?MFZNSEFHa1BhSFgxc2QxZ3hnZFpZQnVLNGZrdUUzTWx1Wkp4RStZNllRKzRG?=
 =?utf-8?B?WEdRdVhWalZJTUh6QWJkK09vNmFEYWpKSmFzZ3JrNW5PWWJESFVrTzZyd1Ro?=
 =?utf-8?B?L3g2RDVCM2h5cEVPSTBZQ050M1BBYStZNWhMNHlqSlBCK2pPcktlV1EydmlH?=
 =?utf-8?B?Tmlnblp2OFMxeHpmZnNyaUhYdGp5QU5RSXNPbXBFcUN0bXlFWDZyTTQwTTE1?=
 =?utf-8?B?NUtEbGJ0MFRFdlc0K3lQY2xxeldyemx2blk4TTNSRTU0cDQ3TkRLMjVwL1RX?=
 =?utf-8?B?ZHRZNnk2bEVVYXdNTU84Zk1ndW1yUGZndjFYdGY1M1FzZkFMNFdKSjU5UDZP?=
 =?utf-8?B?QWNnNlNGRVpDZnZtdG9BbFRCVHlJSU1tenhtK1g3NXpiWVkvSjROc09WT29i?=
 =?utf-8?B?NktiNUpmbnR4WGNja3lyRmwyWWJRZytKQ1ZaRzFzeFBpa2VLaG5QNExGa3NK?=
 =?utf-8?B?SFdROU82UkJuQVRuaE8xRC8vakdxYXMwdVUwSjVJZ2hzVWx0ZDk5aXJEZWZV?=
 =?utf-8?B?dVZoRXJEdW10S2VCM1FXUEpmTnEwbzYxVGx2UFRoWjY0K0FDTnduYU5Rd0NP?=
 =?utf-8?B?WWs4SnpZSDZvRTdJZXNnWjBJcXdGNU1KckwxUmxEVktEdWVhdG9wYzJKekZk?=
 =?utf-8?B?cmY2Nzl0M1JoYXRRMGNwajNBd1RjUU9MSkEvTklla1o4WU5aYlpIUi83eFVk?=
 =?utf-8?B?ZU5GVVdodVptSk1FU2paVzRpUDdDR1VHU2xod3duNE9OZWRNWHh0bnJscEVQ?=
 =?utf-8?B?UUY0K2NwUUpWbnoybzRvVnEvTXJHblFIakVuSnlPcnNLb1BRYzgxNTRFSU5D?=
 =?utf-8?B?Rm9KMXJpR01mVU9MRlNGVytlUVk5Ulk2SE5DZE1JT0ZCVEtPVHZXZGtNVmtq?=
 =?utf-8?B?cGNiNFlPRVNLck53WktMVm5VUEtrOFNRcFUvQUNmTHpUMjJxNHIxbjFoSXZw?=
 =?utf-8?B?WlhJQ2ZyeXN5TjBhVTRiOVVmYnlES3dXaTZRMEQrWUEvY1RHK3BCYVo5QnR1?=
 =?utf-8?B?cGMyZzlXV21ONlNGV2s4YmR2WFYvTXp2YTVEUnQxSjM3WHFFb1N0dDNzTm1E?=
 =?utf-8?B?dStLd0Q0a21GQmhjQjNiYTBxSXluNTBBNmE0U2dxdG42ZUkvbEJkNExwMGhj?=
 =?utf-8?B?eFJ6WlF4eWdBaGVHZVJqSFd3TkZaUDB5TnBTRHRQMXNyajBZVzRhOWJha0Ju?=
 =?utf-8?B?N0F1ZWtDVVJoYjFHSFVxVmsvYjdoYmVEbEY3b01XVTN3ajY3SE5DeXRnUkxS?=
 =?utf-8?B?TDZRTDhGc0F1Wkl1S0xQRXlvR1YwNkozekJYOGdMUHRYd0plaXVjYTlUV240?=
 =?utf-8?B?aVZHWml5YmZhVit5NnRSYzZLc0REb0x6NkFHcThqbXZNbDhyYWpNUXowdnlF?=
 =?utf-8?B?Nk9SK0dDditEYmFLd2FMSEVoc0Q3OTg5TnBaSHlXcHg5RTU5U2kzLzAxWk9r?=
 =?utf-8?B?aHA5cG05N3JGUnMzaGVZODc1ME9ORFhpL1l6NTM2VE9QVWsvVDJiT2NFV0du?=
 =?utf-8?B?SGZmOVlVUEoybDdneWJXUTdkRlFPZVF6NFpHZG1kZ0FJRERlaXdvYUs4U3Vp?=
 =?utf-8?B?bm5mVWJ3blZrdjNwSGNPVGl1VDFXVE8xR3plVTdDU0hQVkg2UnRtaGJHMGph?=
 =?utf-8?B?WXhJMGRLUGxFM0pRZjN3VzZlbC83bklDdlBWc1dxeUNBS0VjRTZoUDlPNmtp?=
 =?utf-8?B?eXJIbFlaYXN3RmR5d1VIQ21LSnIxbWpqcVlBODQ0QTEvZG9mNSt5T0tkRi9S?=
 =?utf-8?Q?eN0udKJ3zLYGt2WDH+oNelzvd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d00fa6-9d4e-459d-ab62-08dd5beabfbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 13:36:35.3342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KepFLOBWOTlihiJFjfXDBo/ot3yZi98wyEZZqLjmSwg7s4bTJlQK+j/9pQ6JQoFtQ0GADpDTZGT5Tbrz2EKrVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7314
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIg05pelIDQ6NTMNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFBlbmcgRmFuIChP
U1MpDQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4g5oqE6YCBOiBUb20gUmluaSA8dHJpbmlA
a29uc3Vsa28uY29tPjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+OyBGYWJpbw0KPiBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAu
Y29tPjsgTHVrYXN6DQo+IE1hamV3c2tpIDxsdWttYUBkZW54LmRlPjsgU2VhbiBBbmRlcnNvbiA8
c2VhbmdhMkBnbWFpbC5jb20+OyBTaW1vbg0KPiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IEFs
cGVyIE5lYmkgWWFzYWsgPGFscGVybmViaXlhc2FrQGdtYWlsLmNvbT47DQo+IHUtYm9vdEBsaXN0
cy5kZW54LmRlOyB0aGFydmV5QGdhdGV3b3Jrcy5jb207IEFsaWNlIEd1bw0KPiA8YWxpY2UuZ3Vv
QG54cC5jb20+DQo+IOS4u+mimDogUmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2
NCAwNC8yMF0gZmlybXdhcmU6IHNjbWk6IGFkZCBwaW4NCj4gY29udHJvbCBwcm90b2NvbCBzdXBw
b3J0IHRvIFNDTUkgYWdlbnQNCj4gDQo+IE9uIDMvMy8yNSA5OjA0IEFNLCBBbGljZSBHdW8gKE9T
Uykgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4+IEluIExpbnV4IEtlcm5lbCwgdGhlcmUg
YXJlIHR3byBkcml2ZXJzLCBwaW5jdHJsLXNjbWkuYyBhbmQgcGluY3RybC1pbXgtc2NtaS5jLg0K
PiA+Pj4gQm90aCBmb2xsb3dzIEFSTSBTQ01JIDMuMiwgYnV0IHBpbmN0cmwtaW14LXNjbWkgaGFz
IHNvbWUgc3BlY2lhbA0KPiA+Pj4gc2V0dGluZ3MgdG8gYWxpZ24gd2l0aCBpLm14IGlvbXV4YyBh
cnJheSBiYXNlZCBzZXR0aW5ncywgbXV4LGlucHV0LHBhZCBhbmQNCj4gZXRjLg0KPiA+Pj4NCj4g
Pj4+IEluIGdlcm5lcmFsLCBpbXggcGFydCBjb3VsZCBiZSBtZXJnZWQgd2l0aCBwaW5jdHJsLXNj
bWkuYyBidXQgdGhhdA0KPiA+Pj4gd2lsbCBtYWtlIGNvZGUgbm90IGNsZWFuLg0KPiA+PiBJbiB0
aGF0IGNhc2UsIHdoeSBkb2VzIFUtQm9vdCBub3QgaGF2ZSBwaW5jdHJsLWlteC1zY21pLmMgdG8g
Y29udGFpbg0KPiA+PiB0aGUgaU1YIGN1c3RvbWl6YXRpb24gdG9vID8gSWYgdGhpcyBwcm90b2Nv
bCBpcyBJTVggc3BlY2lmaWMsIGl0DQo+ID4+IHNob3VsZG4ndCBiZSBpZmRlZmZlZCBpbiBjb21t
b24gY29kZS4NCj4gPg0KPiA+IElzIGl0IGFjY2VwdGFibGUgdG8gcmVuYW1lICIgZHJpdmVycy9w
aW5jdHJsL254cC9waW5jdHJsLXNjbWkuYyIgdG8NCj4gImRyaXZlcnMvcGluY3RybC9ueHAvIHBp
bmN0cmwtaW14LXNjbWkuYyI/IFNDTUlfUFJPVE9DT0xfSURfUElOQ1RSTCA9IDB4MTkNCj4gaXMg
bm90IGkuTVggc3BlY2lmaWMuDQo+IA0KPiBMb29rIGF0IHRoaXMgY29tbWl0LCB3aGljaCBhbGxv
d3MgZHJpdmVycyBwbGFjZWQgaW4gc29tZSBkcml2ZXIuYyBmaWxlIGluc2VydA0KPiB0aGVpciBk
cml2ZXIgZW50cnkgaW50byBhIGxpbmtlciBsaXN0LCBhbmQgdGhlbiBzb21lIGNvbW1vbiBjb2Rl
IGNhbiBpdGVyYXRlDQo+IG92ZXIgdGhpcyBsaW5rZXIgbGlzdCBhbmQgbWF0Y2ggZHJpdmVycyBh
Z2FpbnN0IHNvbWUgcHJvcGVydGllcy4NCj4gDQo+IEluIHRoaXMgY2FzZSwgaXQgaXMgYSBQSFkg
ZHJpdmVyIHdoaWNoIGRvZXMgbGlzdCBzdXBwb3J0ZWQgUEhZIElEcyBpbiBlYWNoDQo+IFVfQk9P
VF9QSFlfRFJJVkVSLCBhbmQgdGhlIGNvbW1vbiBjb2RlIGNoZWNrcyB3aGV0aGVyIHRoZSBQSFkg
SURzDQo+IG1hdGNoIHdoZW4gYSBuZXcgUEhZIGdldHMgcmVnaXN0ZXJlZDoNCj4gDQo+IDc5NDBh
OTNlYjk3NyAoIm5ldDogcGh5OiBJdGVyYXRlIG92ZXIgYm90aCByZWdpc3RlcmVkIFBIWXMgYW5k
IHN0cnVjdA0KPiBwaHlfZHJpdmVyIGxpbmtlciBsaXN0IikNCj4gDQo+IFRoaXMgaXMgdGhlIGRy
aXZlciBzaWRlIGNvbnZlcnNpb24gZXhhbXBsZToNCj4gDQo+IDIwYmQ4ZTRmY2JiNSAoIm5ldDog
cGh5OiBnZW4xMGc6IENvbnZlcnQgdG8gVV9CT09UX1BIWV9EUklWRVIoKSIpDQo+IA0KPiBXaGF0
IHlvdSBjb3VsZCBkbyBpcyB0aGUgc2FtZToNCj4gDQo+IC0gQmFzaWNhbGx5IGR1cGxpY2F0ZSB0
aGUgbWVjaGFuaXNtIGluIDc5NDBhOTNlYjk3NyAoIm5ldDogcGh5OiBJdGVyYXRlIG92ZXINCj4g
Ym90aCByZWdpc3RlcmVkIFBIWXMgYW5kIHN0cnVjdCBwaHlfZHJpdmVyIGxpbmtlciBsaXN0Iiks
IGNhbGwgaXQgZS5nLg0KPiBVX0JPT1RfU0NNSV9EUklWRVIoKQ0KPiAtIFN3aXRjaCBTQ01JIGRy
aXZlcnMgdG8gdXNlIFVfQk9PVF9TQ01JX0RSSVZFUiAsIGhhdmUgZWFjaCBvbmUgbGlzdCBhDQo+
IHByb3RvY29sIElEIChpbnN0ZWFkIG9mIHRoZSBQSFkgSURzKSwgYW5kIHRoZW4gdXNlIHRoZSBz
Y21pX2FnZW50LXVjbGFzcy5jIHRvDQo+IGl0ZXJhdGUgb3ZlciBhbGwgdGhlIGxpbmtlciBsaXN0
cw0KPiANCj4gQWJvdXQgdGhlIE1YOTUgc3BlY2lmaWNzIGFuZCBoYW5kbGluZyB0aG9zZSwgaXQg
aXMgcG9zc2libGUgdG8gaGF2ZSB0d28gZHJpdmVycw0KPiB3aGljaCBzdXBwb3J0IHRoZSBzYW1l
IGhhcmR3YXJlIGNvbXBpbGVkIGludG8gVS1Cb290IGFuZCBoYXZlIHRoZW0gZGVjaWRlDQo+IGF0
IGJpbmQgdGltZSB3aGljaCBkcml2ZXIgc2hvdWxkIGJpbmQgYW5kIHdoaWNoIG5vdCwgbG9vayBh
dA0KPiBkcml2ZXJzL210ZC9yZW5lc2FzX3JwY19oZi5jIHJwY19oZl9wcm9iZSgpIGFuZCBkcml2
ZXJzL3NwaS9yZW5lc2FzX3JwY19zcGkuYw0KPiBycGNfc3BpX2JpbmQoKSBmb3IgZXhhbXBsZSBv
ZiBkb2luZyB0aGlzLg0KPiANCj4gSSBob3BlIHRoaXMgaGVscHMgdW50YW5nbGUgdGhlIFNDTUkg
aW1wbGVtZW50YXRpb24uDQoNClRoYW5rIHlvdSBmb3IgcHJvdmlkaW5nIHRoZSBleGFtcGxlLiBQ
bGVhc2UgcmV2aWV3IG15IHBhdGNoIHNldC4NCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcv
cHJvamVjdC91Ym9vdC9wYXRjaC8yMDI1MDMwNS1pbXg5NS12MS0yLTI4NmQxNWFjYmI4YUBvc3Mu
bnhwLmNvbS8NCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9wYXRj
aC8yMDI1MDMwNS1pbXg5NS12MS0zLTI4NmQxNWFjYmI4YUBvc3MubnhwLmNvbS8NCg==
