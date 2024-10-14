Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFFBCF258E
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 00:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FCA88FD9;
	Mon, 14 Oct 2024 02:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Koc06FR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A29289100; Mon, 14 Oct 2024 02:39:18 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F217389069
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 02:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvHdq8tiuRVG1oDQYR1Jr7vUpZM0bNFr7NUvS5P5alb9O0Rh8+LrW+6tHB0gFN8KO25ohJHoyUO0OlJ/DzS/v9ypjSYjkiAbmORmPabkd0WGIWJ/ej6D33u1Jit7MJ1n8guutYP/bAxb6OZv3WdLt9D+hp0GPMSxKwaShQVLzgwYtz5IRm7StFhu1NJPiKAEy7pdL5xaw04HF6TsaI9vsSZTqz/x1bDpMIq/+b38/zaqwl/SiRJiWh6lIuvIljTYdlK/WeFhoOkF68D1f44BiiCIdpywEUxy129bAnILUzJ69+jByMatTk3xPoXzCDUYFnlhJRWVdK8h7sHovEoCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ5o5qlZzGcqqFA1+2r/K/YyVoa3ICkd1dZHm5fT+LI=;
 b=r1V7VZCCRt1im8P5bkfEIBLN1Jbl8pAdZku+PozI58kZ2TIPUMi/YUxOGYyIS/kPj3SalRkspIYLp6dFm6Lc+/ik8lamTvEWTcZkx7FC2eVPc2YVhGT1hi882+BxvqNrOLfL4BSvO7BM4+xGNVrSk/RW7TP7jWhiKXo3uWqMexdT8KQqCZzz3/z710DsOdPuvmBK8WzlYo5pLyonR+8di0uaoJOo0QnzyeOFsc/TA8VAQ5h/S0AfwrglmA4d4nyOhPq1z/sUMbUtcK3J70242vAMNgJHkEFEJBbBaSBwwoDQoDs39KZvUvgyJhl/eH/GcXR+EHLogVJTSnG0eqRg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ5o5qlZzGcqqFA1+2r/K/YyVoa3ICkd1dZHm5fT+LI=;
 b=Koc06FR/jKZ0S7fyxMJ8S+YcP9TXEPjCeIwhu1NRYS91PFB0g6x1jaRmmPvTxm8uuPQlPBV6pmxC2BMo8SWlJdeLH3p6fvz8s9WtRKWg6c5tWO9dy5OdJ0FmQaZO4SWV3p7FFLZyapESdraa1J1urfoam6NSTxUJcNWNuX3UNsnQE+VtIPdTvHc1SGAgVNX1lACDq09D5cQsL3YNSkjg2sPiIZ4+Hq+pKhQSevzphDoIeIRwI9s+pVKNRpHa85K2weTvl/6CA/+blZ0MGAkQxkuM2R1xJ6d3k8bjsuDVWYgz1OY3d0EOJq2HpQi5LOMRVaIdgLe1WW8h2lxqj07aHg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8486.eurprd04.prod.outlook.com (2603:10a6:20b:419::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 14 Oct
 2024 00:39:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 00:39:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "egyszeregy@freemail.hu" <egyszeregy@freemail.hu>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "sbabic@denx.de" <sbabic@denx.de>, "festevam@gmail.com"
 <festevam@gmail.com>
Subject: RE: [PATCH] imx9: Improve boot device auto-selection
Thread-Topic: [PATCH] imx9: Improve boot device auto-selection
Thread-Index: AQHbHZdg9PRX9ypEMkGYCrSJBu+Zw7KFYtig
Date: Mon, 14 Oct 2024 00:39:14 +0000
Message-ID: <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
In-Reply-To: <20241013174120.1872-1-egyszeregy@freemail.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8486:EE_
x-ms-office365-filtering-correlation-id: 5e713ad8-eb36-4958-2367-08dcebe8a107
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mmh4ZFEzWEVrRTJ1UUhnYUtBcUtpc3VBQkJpWWtoQ0NCUUVBek8yRVFHOG9L?=
 =?utf-8?B?T09penNyOWt0aG5DVldLTDhaV0FhTHRYR0VieCtWVng5d2UzblBEbTB6bk5D?=
 =?utf-8?B?cGVKaVQ1RzJyRDZjejVpWXZpcC9VMzRYYVJHdWFKcEMraWxxcm5LY1JZNUNu?=
 =?utf-8?B?RU1PTVQ3K0FOZTZJZmU5dk1YR0NzdGM1ZTBxU0loK2xKc2FwR21XK3Q5cGxX?=
 =?utf-8?B?QWwxUitPL0VtSVdORkl0NjYyWXc2d2k2a05kdXBPRkRzbHlERUFPYjBOMmtG?=
 =?utf-8?B?SjQ4K2VPQ0pOc1hORDBXd0U1Sk94SFdsK2tkNWpCMFVleTF4bFliZ2lVeGJL?=
 =?utf-8?B?OWlSR0YyVTY3d1JEcHc2TEtvMFA1OFhDUW5PS3JEMmEwbzVHL1JjcHF2amFq?=
 =?utf-8?B?MFRYQytUT3lLZXRreGV5VXQ2RE41Yzc0azFmM0tCc1NocjdPQndueWtOQkFG?=
 =?utf-8?B?dElUNFRITk9vR1FaRFZLRkpkL3NhUjc2SzhJLzZvVE1hYkJEZmF4S0tNTGkz?=
 =?utf-8?B?R0VNNzQ4Zkl3U2R2QjU1QnN4L1hINkw1UGNzU3FFRng5NWpWaThLMjVtMmxU?=
 =?utf-8?B?ajdvRHBlWEJuR3o5SC9LdmJPYnlpTm55a1VNemhFbS9BOFhmdnRlMUtCcWl4?=
 =?utf-8?B?MWdZZGhtTmNjTE5GM3ljaHJTR2RzMk41VDNlbk5BL1k5aXNMbVczWTkrcHRG?=
 =?utf-8?B?ckhrQzc5Wk9rRStYOVJOR00vL0l3QkhkTEtwQ0ZzalAzVFo4aVFOQmQzVVBp?=
 =?utf-8?B?QngwNWx6YkZ1UTkzd2FmNURtaERtbXpKVy9UbldKQmlmYjBCcC90c0JSZEYx?=
 =?utf-8?B?SVdmMnNvOW14UFk0dXZ6QnpZV2VNK044cDVTN0hvTE1PenhiUXg3d0RLeG95?=
 =?utf-8?B?YkJBQlAreTZ1d3JjN09wRjM2ZitFeHFvYnZ3bGFsS24yQ0MwQzlKTGhSeTRT?=
 =?utf-8?B?YVg5Kzl3ekJEYlNFUktWc2lEMDRiQ2lzblFzREhNNEZCTnVoalZTUUhjanh6?=
 =?utf-8?B?cjB0Z203WnFIUDN2eFF0QUhTcWMrWUJOYUZwRGM0SFlnOUFPakVVekxXdmk2?=
 =?utf-8?B?aGxGNGJsSkVmdy9haVE4eTRQZnBaUmZ0Mk5wY1dRLzUzUTBUaEZZWkVLZGY2?=
 =?utf-8?B?b0tBNWRRdkIrdUJrdmlMUU0zZ1FsbmhqS0lveGN6MC9NS25kOGFuMEV0c2JC?=
 =?utf-8?B?VlM4aFozVlFBVE02Rk8vNUtwV080SThtRFRuL3ViU2VXTFFWc1Y1Tnh6N1JF?=
 =?utf-8?B?WmpLQWw2RGVxMnZURFdRb25rdnZRRWVUV1FOMk96ak05czRvUndlblY2NHdV?=
 =?utf-8?B?L1BmeTRtMS94RVR0TTBhcmhmNHl2ZDZXekpGTTRTcXo0M0xWWHpkUWtVL21G?=
 =?utf-8?B?cUVMangvUlRrNzIrN2N5dGdNUUsrRFdwVUhlTnhpaXM3S3QxbENHa20yNmk3?=
 =?utf-8?B?SkJnKy9VR3d5MUtlTm5RRHVEOVNTckQ5NG5ueXlaOU90LzBJZ01zbmtHQitm?=
 =?utf-8?B?SzNpSFpWdkFma0hMR1d2Wit5dVYrcU1Od1VuSFdDWFBpb3d0MmQ1S0pZNDl3?=
 =?utf-8?B?S2xTYzB1ZGtON0pUeVI3ZGp6czREa2lCRDViWVNuT0FFRTBxVUw3bUpPRXQ3?=
 =?utf-8?B?dE5oT0hnRDdMWGdCYjFONjdTZitLTHZQc1hFU3VvQjBaTk9IcGs1amswaXln?=
 =?utf-8?B?NkY3Z2pJckVzaEQvelkvTitXUzFBS2REVDM2dGJHL2hBSTFUdkFQTzFGSSsr?=
 =?utf-8?B?ckthdFpZMHZrMjdEZTJZWE5pTEw1Rklyd2s5bnM5TUREVWd5SUpDY1NpZ0xS?=
 =?utf-8?B?RnFPKzZqdzR3K09JTFQ3QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0M4akI1UFhYN082Nm1JTWZ5cjRyRytjZ1BCTzdtUklIdm40bWhWZDZqRVBa?=
 =?utf-8?B?cXY1RWV3cW5DRHB6b1hpUTAyL0twODhENWE4cXh4VmRuZ0hzZC9kcUdLaEFn?=
 =?utf-8?B?Sm5jajlMYlhVQlBaSVlCYkFPSEE0aDNjbmpJZDlkNFNlcVUwVTFHT1N5djVP?=
 =?utf-8?B?OEE2S2NzNXpLTTAvbThZbU9BZXc5Y0EzZ0lsRGZVcGpxeFh1N0FqTG1zUmlH?=
 =?utf-8?B?TGJtcCtDZzJvRUhGVUY0VUhyalUxb3RkdmptSW9NNW11YW15VG1hLzZOUkVq?=
 =?utf-8?B?aHdZVHIvalB0SjVUZE5qVVZONjBDT1ByNTE3QjBnSFkxVTNscC9UWWRkY1FO?=
 =?utf-8?B?UFBDM0hEVG9IVFMvNFFDVk9iZFg2dUduUzVSSEtveUE1SEVkV1JrRCtQV0Jq?=
 =?utf-8?B?TytPTE1YbTJTNUdWL2ZNckMwTTdhNGpaMjd3ZURnUm5TclJmKzBnK2xRaHQ2?=
 =?utf-8?B?TE81ekgwb3NLTFl5TGpFQmhHSUdWSUNKa0hSaHFLUlhMYUxuc010aFdKVk5l?=
 =?utf-8?B?S1FrZjlPZ2FiZ1VJcEdWRjlVL2h6SXArdlhta2d0bHo4Sm9UQ0ZrbU53SWdu?=
 =?utf-8?B?WjE2NHh5eGxGblpZMUxUc012MW5IcTZzczNFTW1xc2lSVk5zTHAzUzk1dmVn?=
 =?utf-8?B?VTFNWkdQUC9xeUdsYXAwZnB5czVYRjhQbE1CZ09Mb3V2Zytjd29aOVgzVU52?=
 =?utf-8?B?SVdWTWZQZjQvb05TYk5tcGplRlQrMWNBaVNsanRDNGNvRHBJLzhMRE5mUGlQ?=
 =?utf-8?B?MWM2MldOcVczeGx6QVRJL29Mems4VVFVV1kwak90blptdUlhNXh6Qkd2K0ln?=
 =?utf-8?B?QzYvSjVKYzFFckt6aGVDdGNpNHRDVXk5QkRIUWVBTk5XUEs1L1JaQWhCOXEy?=
 =?utf-8?B?LzFRZjR3NWg4Rld2YWszSVZ3Z0J0U3RvWlBKZGdIQlBXUklvYllpSVczMkU1?=
 =?utf-8?B?ajFBNWNYUlZveTRSZUZEV2hWdmhwdnYyOWU0aWp0QlZBZTVGMmFqQ1BHZ0J2?=
 =?utf-8?B?SE5NNDNUb1FYR3hlRWJTL0hWbndMVGpRMDM3RDVFYlR0RlRlNldjcEpma2tm?=
 =?utf-8?B?dng5OVRyOGYzZTBEZ09nLzFKRDRlU29pazhjODl0Ti9KODZkZFFwUUpNWUxT?=
 =?utf-8?B?aTlWTE40M29aN1JOZW40V0Vsb0w4aWQzL2NqWTI1TTF5Sjl0WUZiWGVsZEFK?=
 =?utf-8?B?a24waVd3UVVpeGp2OFJFc3c5UXIyL3JIY2NBRHphamUzOTZSUHFDaG9RVFVq?=
 =?utf-8?B?QkdWWEErZ3dRUmsxNFFUbTlaenp6M2R0RVJMZTFCdXVTS1FUdDBISGRTNmJN?=
 =?utf-8?B?a0JrdHYrK3R6NzY0YTFEMEk4VWZQNHljcE5ndWpocUVTdENsME5GR2pnbTRk?=
 =?utf-8?B?QlJYOFhtdUdzUE5QN04wQXc1LzN3Q0d3YUxvVzM1Ti9wVjZ5TitvdHBpMWor?=
 =?utf-8?B?WWZEM0hObytmMGlTSHNqRDRkdEQ3anpXajYzRUczTHB1WU9vbnFmRmI5ay9o?=
 =?utf-8?B?R0wydVY3QWNpUXNjMUdRa3lkb2tYMmNHNy8xTWxkWnlNa2oyUlA3VTBjb0lx?=
 =?utf-8?B?NFFMa0krTENuc1hVelNFVkRxMGIxTUZ4alBYQUZEQTFnOGFyc0NsMWhiMjMy?=
 =?utf-8?B?anJPSW1tK3I0OFNyYll5cDl3Qm9zR1lIUnJYUzJZMHo4RE13Q3FtOXdwMTBD?=
 =?utf-8?B?OW94UE1jVnhXNi9aOWdIckNvcGNSbXI4VUNnVndXUDF0dlJIRU80bFVoTkVP?=
 =?utf-8?B?VHI1RnhxZ0VOMkt5eXBhNlprVDVkZm1PN1NtYTYrYkx4VERZbnViejJ2NUs3?=
 =?utf-8?B?ZGFhdnErSkZ3bVd2Z1RRNkNab1owMmVpTC9kT1hINy8rb2p4ZUlveW9tdUsz?=
 =?utf-8?B?Um5ibzdNdFh5QzNvSlBPZ3lwa3cxaGFTVS9taGF2Y1Z0L2d3RzlYVGFhbjFa?=
 =?utf-8?B?R3RQNXJjajU2dlNJWEsyZ0VsUFhMcG84UmY2NlU1QUFXZ1ViVnVzU2NiZGt1?=
 =?utf-8?B?QnFueTZkb1lMb2laQ2srVnRDQ3grTmpKUlByVGQzYnlMZFVUOGlaYTNlZEt5?=
 =?utf-8?B?V2RuYjMxL2UwM2VYaFVFQVdaUFN0ZlhlV0Z2czk0RFRnNGtRS29wWmoyMVBx?=
 =?utf-8?Q?cnec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e713ad8-eb36-4958-2367-08dcebe8a107
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 00:39:14.5945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psT/zadL1bhUYDCI4IOjorr0cBtv1QWztKbUZz9F50IchLEXndXwfINYdqoGg9ayb5yyYKA4Ecjfd37nM/8F/g==
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

PiBTdWJqZWN0OiBbUEFUQ0hdIGlteDk6IEltcHJvdmUgYm9vdCBkZXZpY2UgYXV0by1zZWxlY3Rp
b24NCj4gDQo+IEZyb206IEJlbmphbWluIFN6xZFrZSA8ZWd5c3plcmVneUBmcmVlbWFpbC5odT4N
Cj4gDQo+IEltcHJvdmUgIm1tY2F1dG9kZXRlY3Q9eWVzIiBib290IGRldmljZSBhdXRvLXNlbGVj
dGlvbiB0byBhYmxlIHRvDQo+IHVzZSBpdCBpZiBDT05GSUdfRU5WX0lTX05PV0hFUkUgaXMgZW5h
YmxlZCBmb3IgaS5NWDkgU29DIGFuZA0KPiBpLk1YOTMgRVZLIGJvYXJkLg0KDQpXb3VsZCB5b3Ug
cGxlYXNlIGdpdmUgbW9yZSBiYWNrZ3JvdW5kIG9uIHRoaXMsIEkgbm90IGdvdA0KdGhlIHBvaW50
IG9uIHdoeSBkb2luZyB0aGlzPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBCZW5qYW1pbiBTesWRa2UgPGVneXN6ZXJlZ3lAZnJlZW1haWwuaHU+DQo+IC0tLQ0KPiAg
YXJjaC9hcm0vbWFjaC1pbXgvaW14OS9zb2MuYyAgICAgICAgICB8IDYgKysrKystDQo+ICBib2Fy
ZC9mcmVlc2NhbGUvaW14OTNfZXZrL2lteDkzX2V2ay5jIHwgMiArLQ0KPiAgaW5jbHVkZS9jb25m
aWdzL2lteDkzX2V2ay5oICAgICAgICAgICB8IDYgKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC1pbXgvaW14OS9zb2MuYyBiL2FyY2gvYXJtL21hY2gtDQo+IGlteC9pbXg5L3Nv
Yy5jIGluZGV4IDdjMjhmYTM5ZTEuLjc5ZGRiYzcyNDEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L21hY2gtaW14L2lteDkvc29jLmMNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9zb2Mu
Yw0KPiBAQCAtNDIsMTIgKzQyLDE2IEBAIERFQ0xBUkVfR0xPQkFMX0RBVEFfUFRSOw0KPiANCj4g
IHN0cnVjdCByb21fYXBpICpnX3JvbV9hcGkgPSAoc3RydWN0IHJvbV9hcGkgKikweDE5ODA7DQo+
IA0KPiAtI2lmZGVmIENPTkZJR19FTlZfSVNfSU5fTU1DDQo+ICsjaWYgQ09ORklHX0lTX0VOQUJM
RUQoRU5WX0lTX0lOX01NQykgfHwNCj4gK0NPTkZJR19JU19FTkFCTEVEKEVOVl9JU19OT1dIRVJF
KQ0KPiAgX193ZWFrIGludCBib2FyZF9tbWNfZ2V0X2Vudl9kZXYoaW50IGRldm5vKSAgew0KPiAg
CXJldHVybiBkZXZubzsNCj4gIH0NCj4gDQo+ICsjaWZuZGVmIENPTkZJR19TWVNfTU1DX0VOVl9E
RVYNCj4gKyNkZWZpbmUgQ09ORklHX1NZU19NTUNfRU5WX0RFViAwDQo+ICsjZW5kaWYNCj4gKw0K
PiAgaW50IG1tY19nZXRfZW52X2Rldih2b2lkKQ0KPiAgew0KPiAgCWludCByZXQ7DQo+IGRpZmYg
LS1naXQgYS9ib2FyZC9mcmVlc2NhbGUvaW14OTNfZXZrL2lteDkzX2V2ay5jDQo+IGIvYm9hcmQv
ZnJlZXNjYWxlL2lteDkzX2V2ay9pbXg5M19ldmsuYw0KPiBpbmRleCAzNDE4MzFhN2QzLi5jOTE3
MWRmMzMwIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9mcmVlc2NhbGUvaW14OTNfZXZrL2lteDkzX2V2
ay5jDQo+ICsrKyBiL2JvYXJkL2ZyZWVzY2FsZS9pbXg5M19ldmsvaW14OTNfZXZrLmMNCj4gQEAg
LTU4LDcgKzU4LDcgQEAgaW50IGJvYXJkX2luaXQodm9pZCkNCj4gDQo+ICBpbnQgYm9hcmRfbGF0
ZV9pbml0KHZvaWQpDQo+ICB7DQo+IC0jaWZkZWYgQ09ORklHX0VOVl9JU19JTl9NTUMNCj4gKyNp
ZiBDT05GSUdfSVNfRU5BQkxFRChFTlZfSVNfSU5fTU1DKSB8fA0KPiArQ09ORklHX0lTX0VOQUJM
RUQoRU5WX0lTX05PV0hFUkUpDQo+ICAJYm9hcmRfbGF0ZV9tbWNfZW52X2luaXQoKTsNCj4gICNl
bmRpZg0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmlncy9pbXg5M19ldmsuaCBiL2lu
Y2x1ZGUvY29uZmlncy9pbXg5M19ldmsuaA0KPiBpbmRleCA1M2ZiOGM5YjFiLi4yYTk1OTVhMjYx
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2NvbmZpZ3MvaW14OTNfZXZrLmgNCj4gKysrIGIvaW5j
bHVkZS9jb25maWdzL2lteDkzX2V2ay5oDQo+IEBAIC0yNyw2ICsyNywxMiBAQA0KPiAgI2RlZmlu
ZSBCT09URU5WDQo+ICAjZW5kaWYNCj4gDQo+ICsjaWYgQ09ORklHX0lTX0VOQUJMRUQoRU5WX0lT
X05PV0hFUkUpDQo+ICsjaWZuZGVmIENPTkZJR19TWVNfTU1DX0VOVl9ERVYNCj4gKyNkZWZpbmUg
Q09ORklHX1NZU19NTUNfRU5WX0RFViAwDQo+ICsjZW5kaWYNCj4gKyNlbmRpZg0KPiArDQo+ICAv
KiBJbml0aWFsIGVudmlyb25tZW50IHZhcmlhYmxlcyAqLw0KPiAgI2RlZmluZSBDRkdfRVhUUkFf
RU5WX1NFVFRJTkdTCQlcDQo+ICAJQk9PVEVOViBcDQo+IC0tDQo+IDIuNDcuMC53aW5kb3dzLjEN
Cg0K
