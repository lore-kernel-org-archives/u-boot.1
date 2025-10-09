Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAED0CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8226884497;
	Thu,  9 Oct 2025 14:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VO0kG9KY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3960844E4; Thu,  9 Oct 2025 12:22:51 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877AA844D8
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZPv67bSSp09r8lCerHUweaYgJPT4dit4HJeXw6Cw3RFZgzX8oWBDdPZDOesuVRp9UugxsJqMWJbf42po9FjKY2gzHL9JUhGmxHDslI/IvBo8FoyB0D+RDWfyLd1ZuU+asGFAEOqURSX/QfuXPUtdvu5hUP/6WGS16FsLKzfb/6OGETZ0kjUjLudNK517mLak9oR3RGFGWbavorYEtUOQgkQGj7EiXle6m7sgPve2HTfXm7VZrQdXEO07OTk2eLyishy0f9GXJw6f9ZVvRpD0hYQO4Nz7GjMeJ6uxUqGhZjLb/UbP2/wt3jYluPlGuwLgJehPPN72rinzeuK+gOusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLOSJXkP2uxwi6aVrydXZdUK6xcPVPxV3vSKv+hzBGw=;
 b=H8eOor08shzOkkekV2ey20wOj+ldA+QCB4tk8JaAZqkiscWu2j+Exdm0nCM9bC3GfbnUzbqSSqH0CWx8hfKLKE80LqmARGVyLvpK7HeStt0XafuhUnJwafkBBBcU7SLJHYwl99UgCGmDbC7REAAV7XH+3ezEC+siAw4j8CIXCWBC+ZC88cyQdF/C2TEVj/hlbtK+m4k/Rxi1IhGzGjdJO4yYW1MrDqXsM8f6dTBtPGgFeFsmiNQaMEgIrooTrpjR9o0xVOdp4Hk/a0zJVXNMv3xEhttApc9sWyin5k5AZFjyFQxvYdwrqS6YJRPzS683PzpJlag2pWvoVnc7XznvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLOSJXkP2uxwi6aVrydXZdUK6xcPVPxV3vSKv+hzBGw=;
 b=VO0kG9KYIjOVuuSW/RtLtGNvYr27dX6GT/VE/7KXgNlJ9EZYabOLVo/G2eSAI3gHtWg/ScHMGOQXdU6iY4raa1zD8PPv7d9BtVoebHYNSKOcCaz7M5QNUTD+8Hj6khPzWOyfeHfTxSjs9YPVsxrqt8Izq160eu+1zX/SOMwfBzq7pPv9Yyf+tEylMpVforCzT+WJeJxa+Piyw0dstdlskeuRaFa2aSHI9tXFpgpyLbxOTLVvQrC7YQD5eGN7j91hDFesAhyBim0v/FRT4aPW1hlgg7SPAVqgjjjESXOMerw0eqqG2hItG3l5816I+1Vr2hs9VhWD4qtrnr587DaG2Q==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB9797.eurprd04.prod.outlook.com (2603:10a6:20b:679::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 10:22:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 10:22:47 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Troy Kisky
 <troy.kisky@boundarydevices.com>, Adrian Alonso <adrian.alonso@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW0VYVF0gUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0?=
 =?gb2312?B?OiBBZGQgZGVsYXkgYWZ0ZXIgc29mdHdhcmUgd3JpdGVzIERDVEwgaW4gZHdj?=
 =?gb2312?B?M19nYWRnZXRfcnVuX3N0b3AoKQ==?=
Thread-Topic: [EXT] Re: [PATCH 5/6] usb: dwc3: gadget: Add delay after
 software writes DCTL in dwc3_gadget_run_stop()
Thread-Index: AQHcAHq7JAHAYgHUyUKTzLuOcoRaxLSqOkGAgA/R2WA=
Date: Thu, 9 Oct 2025 10:22:47 +0000
Message-ID: <PAXPR04MB964469D10FA2BDE90053D588E2EEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com> <87a52dk5mo.fsf@kernel.org>
In-Reply-To: <87a52dk5mo.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS5PR04MB9797:EE_
x-ms-office365-filtering-correlation-id: 9dc675bb-ac95-45bb-8c17-08de071dcb12
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|921020|7053199007|38070700021|13003099007;
x-microsoft-antispam-message-info: =?gb2312?B?TVdHYTk1dUZKUFNZT2t2bFQycGtCNWV0YmN6ZEplN1RRV3dubmJZWGpNc1Qz?=
 =?gb2312?B?QXMvSUNBOGZQL2E4SmxxejA0TVdEajlTN28vbXY4aXl0OWNjR1ZWL0kyZ0Jj?=
 =?gb2312?B?Q0JGejB4OTFxS2ZBUlRkbitZcnk4K3pVOTVXamtlcG1haWRJK2FkelM2Q0t3?=
 =?gb2312?B?Z0FoUXNOb0RnZGREUXBEZmRXVWxlbzFHRm5VN3lONklvT1YvNDVlOTVMVjBE?=
 =?gb2312?B?UnladUxrbFBkUjBYVER4NkRtcEl1bDRBVDB0ZFZ5VHFyNkIra0h0ZW9kNFRM?=
 =?gb2312?B?aTJpQzhIVWorSlpBQndFd2FBdGdVRHdkODI0ZFVXbUxRRmt5dlZKRDNocDF3?=
 =?gb2312?B?NnBiejg1VlVQd2kwdnVmdm45ekpnL0JaeXJHNXZVREdhOG1HY01GTTRoWGNC?=
 =?gb2312?B?TFlUZ241ODFrblRiMURIWWNNbXlIRmFjZTNiN1RTMFVQTVIwUFI1Um10Smk5?=
 =?gb2312?B?Vy9RM0xuV2NUNkdRa1VESzBMb2pMY0lpTHZNcnlmRFBxaWVrT1I3ZlU4b0s2?=
 =?gb2312?B?aTl5UEtRN1lIVjNZYTZXRW1DL0pCZzllN1pmbi8wLzE1eUJ1VkR6UXJuRDBr?=
 =?gb2312?B?ZHdwMlFJK3dUN09IMHRXc25DTm1ES1NGaGErVjdmTXhFS3FJQUZLbUNnNWJo?=
 =?gb2312?B?aURrem1EanZBQ05keHdQSUdvVER6bDJ5Snl3MHJMNHh6MS85TG5SMFJhTGZv?=
 =?gb2312?B?UTJZOVhBVy81MXo4NngxZlQxbFRUS3U5VHFkeGc3ZEJES1dab3VUMnJlUDRm?=
 =?gb2312?B?R2lPWXlyVGdpM2pES3lTVkhKbVlSMTNhbWNINzQ5SytTU01naVgycWxpY3Nz?=
 =?gb2312?B?U2ZGaVI1ZWF0YXg5WUhaanRabUszeC90ZmdWQUNkaXEvVlVBVmU3NVJtSUI1?=
 =?gb2312?B?OVBUWUordkVjMmVVU2hTNDh5MmwwTlhNc3ZCVFlVcFZlQ1grT25ZbnNPL1F5?=
 =?gb2312?B?Ny91MXBtMkZSN1RqUzY5UGZFTldDSER5RzlSa2kyR2psTFdkMFNwQ21Xb0JF?=
 =?gb2312?B?Mnh6dEVxR0FvOXBldXhVQ1NsZEdMSmhUZExMWGQ3S0hIMjg3TmVqSGlxa1Bj?=
 =?gb2312?B?UTE5RCtkd2dHbWpIM2ZtczUvV1lGWHpxb3dVNWRFMzVJZFpOeGdScFQ0THVW?=
 =?gb2312?B?U0VXTmxEdGNCUTVsZU9DYVdYaEF4ZHlZVnlQazFMOXZvZFpCMzZvRHdjRWZT?=
 =?gb2312?B?amNvQzhrcUZmNEpESXBEeVQ1cU1adjVsbys3eU1WQy91elJVSWJWNFpQek1Y?=
 =?gb2312?B?cU00S0x4bHhEcXpMb2tGVnpaYkp6clpNYjdEMzlvVS8zSjMvQ0VIL1RrbHZp?=
 =?gb2312?B?Sm11QmJsM29PZlJhcFFvUDFkRU5pOVpEZ3d6RDhSQ2FpU1djdDB0YnN1NFY0?=
 =?gb2312?B?bUtIOTJLcmhzWW1ObjFydXVRRHRsZVErcTI5akNGUGhpaVVJOFJXQTBlUFpN?=
 =?gb2312?B?MTFCeU9DbHBFbW04OCtBYldDNjJVM3Q2SnlVZTR6MEYreWpyd2hkV1BkZ0hq?=
 =?gb2312?B?S3NpU1FrSTMvS21leW04dGliRFc0L3NiQWpRakNVVEhvYXg5TmpETk4vb2xF?=
 =?gb2312?B?TzBPZmk4bWdYSXNYV0w5dlZuYXE0cU96RkVhUlpQemNTUWl4R3VQLzFhNlh3?=
 =?gb2312?B?Kys4TFJ6TlpHN3VlU3N5cGRGTlpaQ09rWUNpSjVadURvRmpSSDZuTStNNUI0?=
 =?gb2312?B?YVdLbEdnZDYyeFJlZkd0T2tGVndTc2J3YzFMb2pwUnlNQTI0cVhSbXZhY0pj?=
 =?gb2312?B?N0NmQzdCczlUWnpIY3ZLRGRVenU2V1hmRVFDWWJ3NkNDcTFxeXhuMyt1Z3Jh?=
 =?gb2312?B?V09pOE1uSEd0RnlLUGRQTGx3OWl4TDdWQjRJQmFlZXMrdno4VC9yQmh6MUlZ?=
 =?gb2312?B?WkNCakZ1NExzZjJhQkY1c3dYWjlxN2hDYVg2WG0xUjdxYWp4RWJtNlZXKzdz?=
 =?gb2312?B?VEp3dE9Id2xPRFNEendqS3dzZFZzbk9MLzVldnZiSXNIUjRoUDE3SGhNVDFV?=
 =?gb2312?B?bElMYTgyQXh3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(921020)(7053199007)(38070700021)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YkRWQlZIVTR3SG9iYUZWdWUyb1FNY3pqQWZhSkwwQjhZdFRRc0ZlQkVFV05S?=
 =?gb2312?B?VmFxRTdaSHBpZm1KNDhyZktNTEZ0RTF4V3A0U2pxYVJHZEVqZk5ZVFdFQjRX?=
 =?gb2312?B?ZTVNTWpCK0liYi9zWHArdEtPMEtTaFdEYU0raGdKVW1QaStqK1FSVXZnZ21E?=
 =?gb2312?B?eThVMkYzM3JuTVRMQ3Qvcno4VjhhbXRJa01TbzA3RlQ0MXl3VFJiWkZkbXor?=
 =?gb2312?B?NUpNSUhpWVNvdlNZNXBINHRCdklmZUk5VkxXM3FyTm9nMjEvaTc2ckEyOXB0?=
 =?gb2312?B?YkZnNWs3NlZMeU9jbkphenhRbGlaTGxPSWdwUUFxMllxSzRqa3kyOGx3ZHhF?=
 =?gb2312?B?am5YTnppcDJid3p4ejlpWkxFOEdXNkVVa0tyYTFjM2QyMGM5QkRnVi81QytM?=
 =?gb2312?B?Wm52NDQ5ZU53VURCYThxZktwdGdiUk9kNVFsc3V6SW0xblQrWnZPbjVOWU5J?=
 =?gb2312?B?UWdRbkRSb1BXVjNBMDlzMGIyYkF3WU42ZGRHSnhKY3FhWDRnNHlFdTcvUkFu?=
 =?gb2312?B?L3RlRFFUVWYvM0Y4RlM4cDhJMXk0MkNiVkd3NjBYMFYyRnR5bURHcDB6WEFO?=
 =?gb2312?B?NHIzMjdVRUc3MnVOUVNOc2pML0ZKZnUxOGlnVENCdXdiZUxXYlVzaCtSYlNm?=
 =?gb2312?B?NEJYeHVjdmR3Yi92L3RkQkFQbnczTHRtbTRrZkZnMFZuK0dLSWc1QVBCQmto?=
 =?gb2312?B?TzRHc3l2ODBZcStlVWpnYlJsL0RQMTI3Z2RYaTRDKzk3MVNtZWkwOGplV1kr?=
 =?gb2312?B?REhEMXVuZTFxWXpDZHg3NGJmVlpsL2ZiWFhiVllYY3A4RmczUDFVMTZPOXll?=
 =?gb2312?B?cVd1NXEyd2dadUUrSnpadjZxTVhwbEV2QVRxUTdJZlpGZjRkMXgvTTI4T2kx?=
 =?gb2312?B?VVZMN3VpUGtZeUlCY2dUTVFhclVwYmN5d2hQUnFnejVKVUg2WVlUYzVyRXZ0?=
 =?gb2312?B?SThqK1pDdTFmQS9xTUk0czZxdE9ONVVaeHpIaGZ1YzZqbEI0N1ptV3l3aWJy?=
 =?gb2312?B?YWlHZkNHRHJnL1FKeFFrTGFmenlxWm9TTjFPNnlpWEQ4M2J3N1BROUFPM2kx?=
 =?gb2312?B?VWpBdCtucXNESFBkWUxxcFYwWGJsb3luR0p3WUFYUllrYk9ZQVV5VHQ4MDIy?=
 =?gb2312?B?d2c3VWZpRVdmSVB3eW02SlVqTEhwelVWSFBFdG1sTVp4eHBMYUk5OGRPRzFE?=
 =?gb2312?B?ODNTNGF1cHUyQXFYdDh3WVF1RjNSb0hXVitFaGFKZUlHUmFORnFETUxIT2VU?=
 =?gb2312?B?OXpZOGxoSmRiT1RhUmNXTFZoYWVtMEZMdGh2V0JvTHlXR2lueWJsVmU3K3hN?=
 =?gb2312?B?S24wVWxDY3JaTTY4eGhKeVlLWUFWdWN3alpZTzY4MTVQQnhkZHNNKzIyRE96?=
 =?gb2312?B?cjFEaTFmU2VhR2srM2tvcmt6MXdSWm9rRDR0dENDclVrQlhoblRhaW5NWk1x?=
 =?gb2312?B?Y2dpYnpuc2s1QXR1UTZxcFBmUEVaOWtUQ3JlVm1Sa1RReWdEV0FiZzFwSGxH?=
 =?gb2312?B?em04SUtDVWkyeFpNVTNkcWlYOXdoYVp4ZlZyWVFSOWpYa0ZrQzUvM2JOY3pr?=
 =?gb2312?B?dWZjZC9NU3grRXZVei8zSFRtWDI5UnVMaEJ1L2F0amRTMmtEU2JDUVdCcnFi?=
 =?gb2312?B?NHg5ZGlLZFhvSUE2OHU5YlMwQlBYdGgxWmJCc3FwMmpqNTMyVjFpam5UdHdI?=
 =?gb2312?B?TWRQTisxNTZHSlkvN1drNnY1bGU4NmdTUFltaEZTU3psZFBNcHhOM2c1eXR2?=
 =?gb2312?B?QWtXcGZweFppM1VZSzRlZ2U5NXI1T3I4NDI3cjR2Qnl0TkIyd2NIL01WYkc0?=
 =?gb2312?B?S2MxVEticWhLbUI0eW5lZXR5M0EvVVBOVmoxWHJSRWdYYk5DYXhRYkpVS1RV?=
 =?gb2312?B?T0dvUnh1VHhvcElWY0lRcnJwMklQSUlZZUE3R3dteDYybXFxRHM2QWtvd0V1?=
 =?gb2312?B?UWZSRUJTS2JSbGwvOHc2cENHZUdVYzNhR2U1V25NTVExQlZrcEJVOVJHcGY3?=
 =?gb2312?B?bWg2Q3BFOUxZbm51eFJmZ1A4MUgwSnFDNjRwc1FBK0VXZGVoZ1NWeGtWNk1O?=
 =?gb2312?B?cE1ZMDQrcWpCSkJBTlFjRHdaZmFoc1ZVTXo1ODVpV0k0cHJmVFMyR0VLVVZF?=
 =?gb2312?Q?Jpn0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc675bb-ac95-45bb-8c17-08de071dcb12
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:22:47.5362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAcudGNuJ+W6qn87I1Mod1/wd5LRs0u1WzyTUMjdVSbgk+wWnmCPJ8aRA6GKITWvuU71p22IkPq3V41oIw2wTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9797
X-Mailman-Approved-At: Thu, 09 Oct 2025 14:58:33 +0200
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXR0aWpzIEtvcnBlcnNob2VrIDxta29y
cGVyc2hvZWtAa2VybmVsLm9yZz4NCj4gt6LLzcqxvOQ6IDIwMjXE6jnUwjI5yNUgMTY6NDcNCj4g
ytW8/sjLOiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFN0ZWZhbm8g
QmFiaWMNCj4gPHNiYWJpY0BuYWJsYWRldi5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29tPjsgVG9tIFJpbmkg
PHRyaW5pQGtvbnN1bGtvLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgVHJv
eSBLaXNreSA8dHJveS5raXNreUBib3VuZGFyeWRldmljZXMuY29tPjsgQWRyaWFuDQo+IEFsb25z
byA8YWRyaWFuLmFsb25zb0BueHAuY29tPjsgTHVrYXN6IE1hamV3c2tpIDxsdWttYUBkZW54LmRl
PjsgTWF0dGlqcw0KPiBLb3JwZXJzaG9layA8bWtvcnBlcnNob2VrQGtlcm5lbC5vcmc+OyBNYXJl
ayBWYXN1dCA8bWFyZXhAZGVueC5kZT47DQo+IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2Ug
R3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gs63LzTogdS1ib290QGxpc3RzLmRlbnguZGUNCj4g
1vfM4jogW0VYVF0gUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0OiBBZGQgZGVsYXkg
YWZ0ZXIgc29mdHdhcmUgd3JpdGVzDQo+IERDVEwgaW4gZHdjM19nYWRnZXRfcnVuX3N0b3AoKQ0K
Pg0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbQ0KPiBta29ycGVyc2hvZWtAa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50IGF0DQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFz
ZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhp
cw0KPiBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+IEhpIEFsaWNlLA0KPg0KPiBUaGFuayB5b3UgZm9y
IHRoZSBwYXRjaC4NCj4NCj4gT24gU3VuLCBKdWwgMjAsIDIwMjUgYXQgMDY6MTMsICJBbGljZSBH
dW8gKE9TUykiIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPg0KPiA+IEZyb206
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4NCj4gPiBXaGVuIHVzaW5nIE5YUCBV
VVUgdG8gZG93bmxvYWQgZmxhc2guYmluIHRvIGkuTVg5NSAxOXgxOSBldmsgYm9hcmQsIGl0DQo+
ID4gd2lsbCBnZXQgc3R1Y2sgaW4gYSBsb29wIGF0IHNkcF9pbml0KCkgd2l0aG91dCB0aGlzIGNo
YW5nZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5j
b20+DQo+DQo+IEkgc2VlIHRoYXQgYSBzaW1pbGFyIGNoYW5nZSBleGlzdCBpbiB0aGUgTGludXgg
a2VybmVsOg0KPiBodHRwczovL2xvcmUua2Vybi8NCj4gZWwub3JnJTJGYWxsJTJGMjAyMjA5MDEx
OTM2MjUuODcyNy00LXF1aWNfd2NoZW5nJTQwcXVpY2luYy5jb20lMkYmZGENCj4gdGE9MDUlN0Mw
MiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NkZTc0YzUyNTBmMDI0ZmE0YzllYzA4ZGRmZjM0YzBh
DQo+IGQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTQ3
MzI0MjExNTg5Mw0KPiAzMyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tp
T25SeWRXVXNJbFlpT2lJd0xqQXUNCj4gTURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lU
V0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDDQo+ICU3QyZzZGF0YT04QW80dE9tY01T
S0h0b25paVZUd1A0MEp3ZzU0bHozNDJLUDBKSFVLd0E4JTNEJnJlc2Vydg0KPiBlZD0wDQo+DQo+
IFBsZWFzZSBtZW50aW9uIHRoaXMgY2hhbmdlIGluIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgdjIu
DQo+IFNlZSB0aGUgZm9sbG93aW5nIGV4YW1wbGU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuLw0KPiBl
bC5vcmclMkZhbGwlMkYyMDI1MDExMC1kd2MyLWRldi12NC03LTk4N2Y0ZmQ2ZjhiMiU0MHBpZ21v
cmFsLnRlY2glMkYmDQo+IGRhdGE9MDUlN0MwMiU3Q2FsaWNlLmd1byU0MG54cC5jb20lN0NkZTc0
YzUyNTBmMDI0ZmE0YzllYzA4ZGRmZjM0Yw0KPiAwYWQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4OTQ3MzI0MjExNjINCj4gNjQxNiU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQQ0KPiB1TURBd01D
SXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdD
JTcNCj4gQyU3QyZzZGF0YT1NdFhxU3VlTkFaNkdmaU94ZG50JTJCSDZJVVdhYkwzSkRlMDFtOElL
SnBNeTAlM0Qmcg0KPiBlc2VydmVkPTANCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiA+IGluZGV4IDJiMDExMTNkNTRjLi42YjJiMjVjN2FhNSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IEBAIC0xNDIzLDYgKzE0MjMsNyBAQCBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsDQo+IGludCBpc19vbiwgaW50
IHN1c3BlbmQpDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0RDVEwsIHJlZyk7DQo+ID4gKyAgICAgbWRlbGF5KDIpOw0KPg0KPiBDYW4geW91
IGVsYWJvcmF0ZSBvbiB3aHkgMW1zIGlzIG5vdCBlbm91Z2g/DQo+DQpIaSBNYXR0aWpzLA0KDQpU
aGlzIHBhdGNoIEkgc3VibWl0dGVkIHdhcyBpbmRlZWQgaW5zcGlyZWQgYnkgdGhlIGNoYW5nZSB5
b3UgbWVudGlvbmVkIGluIHRoZSBMaW51eCBrZXJuZWwuIFRoZSBtZGVsYXkoMikgdmFsdWUgd2Fz
IGRldGVybWluZWQgZW1waXJpY2FsbHkgZHVyaW5nIHRlc3Rpbmcgb24gb3VyIGRldmVsb3BtZW50
IGJvYXJkLg0KDQpIb3dldmVyLCBhZnRlciBhIGRlZXBlciB1bmRlcnN0YW5kaW5nIG9mIHRoZSBk
cml2ZXIsIEkgYmVsaWV2ZSB0aGUgcmVhbCByb290IGNhdXNlIGlzIHRoYXQgdGhlIFVTQjMgUEhZ
IHdhcyBub3QgcHJvcGVybHkgaW5pdGlhbGl6ZWQuIFdoZW4gRFdDMyBpcyBjb25maWd1cmVkIHRv
IERXQzNfRFNUU19TVVBFUlNQRUVEIGluIGR3YzNfZ2FkZ2V0X3N0YXJ0KCksIGVudW1lcmF0aW9u
IGZhaWxzIGJlY2F1c2UgdGhlIFBIWSBpcyBub3QgcmVhZHkgYW5kIGNhbm5vdCBjb21wbGV0ZSB0
aGUgZWxlY3RyaWNhbCBhbmQgcHJvdG9jb2wtbGV2ZWwgaGFuZHNoYWtlIHJlcXVpcmVkIGJ5IFVT
QiAzLjAuIFRoZSBkZWxheSBhY3RzIGFzIGEgd29ya2Fyb3VuZCB0byBjb21wZW5zYXRlIGZvciB0
aGUgbWlzc2luZyBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBvciB0aW1pbmcgaXNzdWVzLiBPbmNl
IHRoZSBQSFkgZHJpdmVyIChwaHktaW14OG1xLXVzYi5jKSBpcyBhZGRlZCBhbmQgcHJvcGVybHkg
aW5pdGlhbGl6ZXMgdGhlIFVTQjMgUEhZLCB0aGUgZGVsYXkgaXMgbm8gbG9uZ2VyIG5lZWRlZC4N
Cg0KVGhlIHVwZGF0ZWQgY2hhbmdlcyBhcmUgaW5jbHVkZWQgaW4gdGhlIHBhdGNoIHNldCB0aXRs
ZWQgIkVuYWJsZSBVU0IgYW5kIEVORVRDIG9uIGkuTVg5NDMgRVZLIiwgc3BlY2lmaWNhbGx5IGlu
IHBhdGNoIDYgYW5kIHBhdGNoIDcuDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIQ0KDQpCZXN0
IHJlZ2FyZHMsDQpBbGljZSBHdW8NCg==
