Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C0CC87FCC
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 13:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C3798300B;
	Sun, 27 Jul 2025 15:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pNaQY7K5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF0A183013; Sun, 27 Jul 2025 15:07:16 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFF480B9B
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 15:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeiHYL5ihjwxTC8XwsmGynhJak7N6tiAaPq2+HfSdcJrv+Pc4FYGAzHQDkv+Nk9hRhMOvpMIJpeTFaPJhQmhQxxQ7lkUORGq59vKkecxqh0wKtzb0KTFzkxlvBQ7ycDSCU2z5BCBOkehEmQeOSoshoR+KBJH5hpZHV3ghwE/Af8eZfXi6i6gUNj3sUTEqXYuBTNmrB6V6bw3PhGnIdkFGcQLMKk2OeOeq9xdxG0X9ZP7HVhxeIcAN61Yal8sWa4wZB+2qpV9BPJw2NrmyGxI3tdqKSRE2H6e4wJFBewdiMyDsW350ItXXRjRcSXz7FTD7DYlG6PsDq86GkUGxFRMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InSe3Ne59L3VvnwLYM4S2QcQcLd24Q066iQgFJKOJv4=;
 b=s7FFm9uRhCcQbqs7KqJxE0iBKS3/sDx8/gVa55OqxvdLc4kMwEFk2lxWBkW8w3dCWZuukbcBMgXNAYDJd1TMUnkrx9yk6gLku9ON4a968HjgFWyTUhE73cLyNNSYV5yg7iIX5BXnuga5xz78Q+cLnnQwENevP6ea2ECcCSqzHhl42tKBNA1+issweJxtfpRJ753MbbEzJEBQ7l9ZvX1kPf03MGKH4kXy32Po8iTW7e+5XuyXW6x9tHfLBMON3ohVVdncL+3jx33SUEbvYzfWV9TF3JfUQhjlNNSB5cUymPwZ2BCo/sMwdbZwKsZntbzXPaCpgznIz6buBrHLru7zgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InSe3Ne59L3VvnwLYM4S2QcQcLd24Q066iQgFJKOJv4=;
 b=pNaQY7K5krKXuxPf2WDalKNU7CqLoslreWenDIo+O9ItTbjaboMJSCXI4yJy4GE1lOEAFI6zuCdnV/Oj01RcyFyByRL3hUW3x1tWw3N1YEH1MysOyzq8z++EAp4O4V2atE2wurHvY+wAnPMpSt5xtx3t7uNLnv2D7b+ebi4W6N1QPEv+tpP25rgjj4zUFo503phpQ97XQStcrwestxa8Rx/dLmnuAWDlYYZYRrRvokpxxuA0NiDhfusOSpZPgnlA5yDBV2yazmHsvHE7vkAvQRHHb2boEB4dAQmIIdsMscEYf9h0s5CLEn0LGaIDcMo7W9Dpq26NVHZ1qIFoS0MYCg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7857.eurprd04.prod.outlook.com (2603:10a6:20b:24e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sun, 27 Jul
 2025 13:07:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 13:07:09 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, "lukma@denx.de"
 <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
 "patrick.delaunay@foss.st.com" <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, "valentin.caron@foss.st.com"
 <valentin.caron@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBjbGs6IHNjbWk6IEZpeCBjbG9jayBpZGVudGlm?=
 =?gb2312?B?aWVyIHBhc3NlZCB0byBzdHJ1Y3Qgc2NtaV9jbGtfcGFyZW50X3NldF9pbg==?=
Thread-Topic: [PATCH v2] clk: scmi: Fix clock identifier passed to struct
 scmi_clk_parent_set_in
Thread-Index: AQHb9VBPNJ+wNHDWJ0KhJ6kY6MkS+rRGBBLA
Date: Sun, 27 Jul 2025 13:07:08 +0000
Message-ID: <PAXPR04MB9644C9CB718DA315862C2797E25BA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250707202034.385890-1-alice.guo@oss.nxp.com>
In-Reply-To: <20250707202034.385890-1-alice.guo@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM8PR04MB7857:EE_
x-ms-office365-filtering-correlation-id: 1cfe038a-e64d-4e73-877a-08ddcd0e7e5b
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|1800799024|921020|7053199007|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?Vi9yeVdzdElTajYzZFptcTN6aC9LQTl0MUp5SHhHUFE3MGV4QjhzYkJVV2Fk?=
 =?gb2312?B?cndVZDFGWndiaHN6OTgvcU5MNGZPSkF5bmRhVVNzOE1zYVpLUVhmRldUTEVZ?=
 =?gb2312?B?L0NUcEhLRlJFdzczbXhMZ2t4dDhnaEdMZEYyUTRjcG1mK3pmUHgySC8yZmE2?=
 =?gb2312?B?d055djFNTVNlRWJoMUxTMmVYd2lodjlqNmQvVHpQQVo0OEc1cW1EV1FOSUxW?=
 =?gb2312?B?MndLanUvcnl3cmNmbnRwd2pBZzZYRWRlc2k2QTMrbEhLbzNxVXhENkJmeE9w?=
 =?gb2312?B?YmROamxMUW1hTHBMVHpSeU9KR3QzL0F3V3RtZmRYdzk5azJ4MmYvL1BLdTlP?=
 =?gb2312?B?bnVMYWg2dGhRUkFPUHNZenBVOFBEeFVGbjVVODYrSkVmVXFYNmxTb2hFMUhs?=
 =?gb2312?B?TUlaYm1UYmdTeFFIZWFCOVFuc3ZyWERCZ3J1OVpLT3d6Tm5uYllKaWlUa1dq?=
 =?gb2312?B?d29CVjlxejJXQ3FKbk8rZk12LzQ2a3FYSEVXeVUrb093SHEzN2taQkJFZFJ3?=
 =?gb2312?B?bFMwK0FRMWtnWllUemE0YmZCNThPcmlIbUxnZjRUOXora0habVBvZGt4U01l?=
 =?gb2312?B?ZDI5VktTR3VZS3dhQ1VGTUp6K3NVbHZGaWdMdkdRemx6TUxubDgwaXJkekJq?=
 =?gb2312?B?dTBHL1E5UldQSVFWTlVqc2tXdkx4TTVaczVzL1orcUtzTmp0MGVmdjdUSWJ1?=
 =?gb2312?B?Z2Jhd0htOTlodDhmOHk0SlBIdjZYMnRhaDJwWko5K3pnTUVsRzdtcGFDR0hu?=
 =?gb2312?B?ZFlQbURVSXpjRy9JVG1xSFBpWGdhcUI4MERRdkRqL3Vkd0pxcmRDM3FXbitP?=
 =?gb2312?B?MFVHeEV4ODQ0RjR6L0JTUVZ4NVJkWWxnV1owYkpKZ3RIV2szckp1T0J5MnBN?=
 =?gb2312?B?d3M3djVWT3VaRUpPeXAzaTlVV0pJMTlaOEVadmpiaEhjempmdzY1dFZIZThT?=
 =?gb2312?B?LzhqWGVYUVRUcVkrRWVKQm1Bd0dpWWJ6T3oxMk5Lei9NbUNPV05OOWJqU25Z?=
 =?gb2312?B?djBBbjRGNjU4eFFwMUROUU9wczNybGNzb0Vkbmhzc3diWnJLSnp4NTB5MHZS?=
 =?gb2312?B?YTcvSlNaaGVZRTdHTkg5SEJ6eXFrLzF4RnEyb29SekR5akpDOVB4TEpGNWxo?=
 =?gb2312?B?aFN6UjN1c3h1ZUJiNkptdVVLbzVmMXhCcnM3aFBOdm40VWhUdGNFNTFLTU1z?=
 =?gb2312?B?aCsxRGNzeDdNV1U1VzJoMDZsdGxzYlhkeW9OZm13cDZSRXVnVUVxMXdwVDlk?=
 =?gb2312?B?TkJIZ1dpZlZnZU9uOFgrOHN3dHkzbzhHRGVid2pxUHVXMjV5MEJhOXhDZkhj?=
 =?gb2312?B?NHpoYTdOTERWL21VZ1ZiNjJDUVlOR0k5YVc5aG9CbUE4VVJSa2RBZTU2d2Z6?=
 =?gb2312?B?dE1WUWRVUFdoYWVPS0JwZ0NIanlZcHdwTG9mY3BzMGhadXVxQU4zcklBUHQ0?=
 =?gb2312?B?ajFxZkQ3Szl4QTVZakZLWDB2KzhLUEMyQitHZ3FoTWt4WGdzMXlQS01pczg5?=
 =?gb2312?B?L0tEc0hBU3U4TVpKWVg2K2pqR1hsZGtCQXJkdFBtV0I2cUJXSVpFTHIvZE9W?=
 =?gb2312?B?MEZLd0dlNVBUb1pwamlvQ2VPRlJiazlHSy9nZzhIUXByaGU1ZHlaUXRSL1ZT?=
 =?gb2312?B?WEcrVWlwTUZRTUNjZHFwcGpEcnBkOWhEVU5DS1haR3l2a3lQU0ErQ3o5QkdL?=
 =?gb2312?B?MUw2cDkxZFRqWWY2dzNFS0grTlo3MFVLNnd3OEFabU5hdXZmL1FpeTJjV2E0?=
 =?gb2312?B?WWV1YzBhYTEzSVRGVklOcjkrVHJjWUdXbVdVRzJleWVJaHU0dTA2YWdNTW1D?=
 =?gb2312?B?YXlHT3kxMmpwVnRTVHMzRVN4QTRpVitqQzA0ZFBuTGsyMnNsNTVtSVhlTmt0?=
 =?gb2312?B?a3ljeVJicmVoYlBtU0tJbFN4V3RjM2Qra0RzTUtIbWFkRDlLYWhjT0cwZTJq?=
 =?gb2312?B?WTQ3aTNRTVRDUVVDSWswcnZwQkZSamc3OVFRY0ZIN1BORllWV0JVaXdLR0VH?=
 =?gb2312?Q?WQZQok2uis9tykrxZGNEsfyWO/kJuQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(921020)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MTRockh0dTFPaUFLaVFDQWp4bUU1aVUwa0UxcDdhdHdnZS9NWkUzK3JXMjFS?=
 =?gb2312?B?T2tVbGxrMFFwR3NHTzVPc3JrUUNnQUxSMlduY3V3c1ZOanZ3K1oya0JrRmcr?=
 =?gb2312?B?UE9JM0pDZWVrcGhtWlFDWUh1ak9yTllHaDFib2dlakJxQUpXNHVENzhNYklF?=
 =?gb2312?B?Z0hMRnBkTnJyTFIvbWFFcld1ekQ2dFRKTndGNDVwN3dXYUNJZ2tIUGdwb014?=
 =?gb2312?B?Y0JKODd4cWF3SWVKeHFkRzZUdVFRMjdDZTZjSXplZWxEYmFFS2JzRTVxdVhB?=
 =?gb2312?B?ZkhjOE1pTTFqWklmNTZSdXpFZ2JDdjBxdHhWZ2NSQjFFWTZBTHk5QkY0c1cr?=
 =?gb2312?B?YUtGd24vbGprRFhoWFJlakJmYTJZS3pteWtWTnE2Z2RXck9wak8wblV3WTBT?=
 =?gb2312?B?aHI5STJZSzhIenUzcEZOVzgxYm8rRWNxWWpxWXZyL2E3OFJ3OC83M05TbDJW?=
 =?gb2312?B?VkpGZmFhNnFScldqQ3FyRGl1amVJRkVGTVFhTGpRTVY0RTljTHJ0TG1VMCtZ?=
 =?gb2312?B?OGJSREpRYVcyQ1VDWDlUcGR5VkVCSG1LREgrcC8zdThLR0RybjJJTENUQUpG?=
 =?gb2312?B?VHBCSkVaS1RBWnhMRDZtSVZqcVZ5YTlCUTVPL0JFakhVWnd6Z0dJdzNrSzVa?=
 =?gb2312?B?QkpqeHRhcEVyVEVVeEo0dHhNS2tGRU94cUFrRmhQOUZZa2NrdjRJNHpNTytj?=
 =?gb2312?B?TFdKbkt1a2UwM3lMUU91cFZTa21wUU1xcmt1Z011aHBFSG1FOEtlQXBBUUFh?=
 =?gb2312?B?MWtVdUVqVzdwK3BKTzBxT01jOVpjR2VsWitjOFhCVVplZUNPSEkvWDdGVk1n?=
 =?gb2312?B?NERZU3hkc0sxNVIyOUpvd05IWlV0TjBzZzVoMGVHR1lBVHMrRGdXZkJQc0di?=
 =?gb2312?B?U1BRVGV5RWo1bEJYOWxMbzdVWWxUQkdHcVhaYlNjTlI2Y2wwdUxjYmVWY0Zz?=
 =?gb2312?B?SU15WDFjQTVsRk94akR3UWkrS3FHRDF1ZXZOd0FnTXY4dzlsMXErVzhwcVFm?=
 =?gb2312?B?dEJTNGlCOXJtM1JEb2QwbHJFRkJOK05nMlFkeXdtb1FnTkhnNzVFQkJsYWdo?=
 =?gb2312?B?MHlRNUJJdmpCZjJkVTJMNC9TbUQ4MU5BUEpVWHpEdS8rNHMwZDMwdUpDU3hm?=
 =?gb2312?B?V29PMDgzR2dTWGxCaW1EUEp4TXBrS3FoSWVZM3hhMm9QWGw3YnBaOG1VWmNB?=
 =?gb2312?B?OXFlZnA5YWthMXExOXFVbjJuMnU5UWg3TXlFOSt3RFVtTXNKZnlZaDdsZXJv?=
 =?gb2312?B?QnBielAzb0N4aFZUM09PODBFdTBINWNLZ01yQ1B6cm5KN2N5QVNLN2hBbTBZ?=
 =?gb2312?B?V1J3WktTSENvclpuaG9QT1hSWjZGSkRhd1JHcDI4MDZRQnpHOGNCOWk4SGVY?=
 =?gb2312?B?L0tPZzNEcUFDS05DQld4ZnZxUE5nRWs0cWh2R3U2NVhNZHBZTDk5Z0trTisr?=
 =?gb2312?B?NFNkdnBjNldtL1BSbkhFSUFMblU2M2J2M3RDUTRjUkxvOGpRWEJtUG42QzRX?=
 =?gb2312?B?RnhhM1d6aTBWR1Z0ZzBwdFhzNys1OUFDdEExclhlaEhPWWlKSHpSOUlUNUth?=
 =?gb2312?B?TlZuampvMUFlZmJxeitzakE0WXI5cTZyWlpGTDFaWktDNkIxbC9Sbk1tVE9F?=
 =?gb2312?B?MXF6Q3NZRklkN1BGT1ExYlhVdHpKTURLdnkvWWlBZVloKzlXUHoxWjR0ZCt1?=
 =?gb2312?B?RDhoTldVTEY3SXdzbEtmYjgvOXJzU3VJZ2RUWlRQZzhaQmtCNXN3cG1wcmZv?=
 =?gb2312?B?dlluUXAvdTJnMkFINVZ5bG5tS0krMzU2WTFZbWRzT3dmYzYwYmtjT2piRkNI?=
 =?gb2312?B?alBmWHlyRzNnZEtMRDkzcjViVVJKVkI5UVdrZzFXZ0hvbTBkaDBTYzJVS09u?=
 =?gb2312?B?d3lEOHlMTWd0MkxqckJXVHRGcE5EN1B3aE5tVXpQbHZvcU9MMjRpekFwNmoy?=
 =?gb2312?B?bWVjZEFBa0pTcEwvNVRaMWdqNWpxS00zRVdzb3ljZEdrSFlISVBUMVMwOHdu?=
 =?gb2312?B?THRQTEpEY0VTUHNJelVhMk44aE5HTVlRZUZ2MDM0cmYxeGJNU2w0Q2VSa1Iy?=
 =?gb2312?B?U0ozUzk3bklOTHVLR2JCWUdvY2ZXeXAvb0ZVeTVuN2FnRzBEaHQ0WlNDb21W?=
 =?gb2312?Q?quI4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfe038a-e64d-4e73-877a-08ddcd0e7e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2025 13:07:08.9092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4IVSIqaQWdSQndmGHtyi3L6OFjbwLFc46G9xXSFo1yre56M9a9+DspdwEnm446a8Zu24aN03iUjgApjcx+nXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7857
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

S2luZGx5IHBpbmcuDQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0KDQo+IC0tLS0t08q8/tSt
vP4tLS0tLQ0KPiC3orz+yMs6IFUtQm9vdCA8dS1ib290LWJvdW5jZXNAbGlzdHMuZGVueC5kZT4g
tPqx7SBBbGljZSBHdW8gKE9TUykNCj4gt6LLzcqxvOQ6IDIwMjXE6jfUwjjI1SA0OjIxDQo+IMrV
vP7IyzogbHVrbWFAZGVueC5kZTsgc2VhbmdhMkBnbWFpbC5jb207IHRyaW5pQGtvbnN1bGtvLmNv
bTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsN
Cj4gcGF0cmljZS5jaG90YXJkQGZvc3Muc3QuY29tOyBwYXRyaWNrLmRlbGF1bmF5QGZvc3Muc3Qu
Y29tOyBQZW5nIEZhbg0KPiA8cGVuZy5mYW5AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29t
PjsgdmFsZW50aW4uY2Fyb25AZm9zcy5zdC5jb20NCj4gs63LzTogdS1ib290QGxpc3RzLmRlbngu
ZGUNCj4g1vfM4jogW1BBVENIIHYyXSBjbGs6IHNjbWk6IEZpeCBjbG9jayBpZGVudGlmaWVyIHBh
c3NlZCB0byBzdHJ1Y3QNCj4gc2NtaV9jbGtfcGFyZW50X3NldF9pbg0KPiANCj4gRnJvbTogQWxp
Y2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gDQo+IENvbW1pdCBhYTdiZGMxYWY1MDUgKCJj
bGs6IHNjbWk6IG1hbmFnZSBwcm9wZXJseSB0aGUgY2xrIGlkZW50aWZpZXIgd2l0aA0KPiBDRkYi
KSBlbmFibGVzIENPTkZJR19DTEtfQVVUT19JRCwgc28gbmVlZCB0byB1c2UgY2xrX2dldF9pZCgp
IHRvIGdldCB0aGUgcmVhbA0KPiBTQ01JIENMSyBJRCwgb3RoZXJ3aXNlIHdyb25nIElEIGlzIHVz
ZWQgd2hlbiBzZXQgY2xrIHBhcmVudC4NCj4gDQo+IEZpeGVzOiBhYTdiZGMxYWY1MDUgKCJjbGs6
IHNjbWk6IG1hbmFnZSBwcm9wZXJseSB0aGUgY2xrIGlkZW50aWZpZXIgd2l0aA0KPiBDQ0YiKQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gDQo+IENoYW5n
ZXMgZm9yIHYyOg0KPiAgLSBpbXByb3ZlIGNvbW1pdCBsb2cNCj4gIC0gYWRkIFJldmlld2VkLWJ5
DQo+IA0KPiAgZHJpdmVycy9jbGsvY2xrX3NjbWkuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9jbGtfc2NtaS5jIGIvZHJpdmVycy9jbGsvY2xrX3NjbWkuYyBpbmRleA0KPiBj
ZmIzNzJlNjE5MC4uMGM5YTgxY2FiY2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsa19z
Y21pLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvY2xrX3NjbWkuYw0KPiBAQCAtMzM2LDggKzMzNiw4
IEBAIHN0YXRpYyBpbnQgc2NtaV9jbGtfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikgIHN0YXRp
Yw0KPiBpbnQgX19zY21pX2Nsa19zZXRfcGFyZW50KHN0cnVjdCBjbGsgKmNsaywgc3RydWN0IGNs
ayAqcGFyZW50KSAgew0KPiAgCXN0cnVjdCBzY21pX2Nsa19wYXJlbnRfc2V0X2luIGluID0gew0K
PiAtCQkuY2xvY2tfaWQgPSBjbGstPmlkLA0KPiAtCQkucGFyZW50X2NsayA9IHBhcmVudC0+aWQs
DQo+ICsJCS5jbG9ja19pZCA9IGNsa19nZXRfaWQoY2xrKSwNCj4gKwkJLnBhcmVudF9jbGsgPSBj
bGtfZ2V0X2lkKHBhcmVudCksDQo+ICAJfTsNCj4gIAlzdHJ1Y3Qgc2NtaV9jbGtfcGFyZW50X3Nl
dF9vdXQgb3V0Ow0KPiAgCXN0cnVjdCBzY21pX21zZyBtc2cgPSBTQ01JX01TR19JTihTQ01JX1BS
T1RPQ09MX0lEX0NMT0NLLA0KPiAtLQ0KPiAyLjQzLjANCg0K
