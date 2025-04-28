Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379A8C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 08:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B55380FDA;
	Mon, 28 Apr 2025 10:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ft/nd0nq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C256E8212B; Mon, 28 Apr 2025 10:25:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::712])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC98280BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVqH8Px2K9MPHWPbY/FwnXUkbxmwPAYXCiHWLFL00tCFT4pfvGEW0T+un7u6nJleJopXaUj6GeAU++bUO0ee79YTGsXcuMn6pQtxt1vwvLv0edVHwtRxRB60vtwlxnddPAj9blzWADDN1/g485z5Dpao6/C6DhMmAwI+OTjjb/QF0CXDkO8D0VrkM2bJVtcRW1HwMDof1yOlU74vhK9bfLlAkOkMmXX/ygAZOdj21ADpO5I8efxAIxJQAUbX933BIXfrx6fUFxTvbUWgd/LUpgZIL462ipjgd1+R3hvmPBc6XRg3yQZnIeewYvoMpBOzFaoZAqNfBlUaKOwILNv7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PLlU8XDi2037/DUrsiSQwGAQOUWJPx225NQd+y9LMs=;
 b=R/3oifvFr8ydkIPM9EFE9YpRiebLWIVfH2Wr8Ji5NLnL2Tq1XjzpRXa0otITLw+zs58Wh2je4UfW51qg6AzVti7cs4AXqu4y7kV0R2bW7GbDRBXb3Hx/4B1z+BlHwar2lZ2VMfGgU83Igb5uq3rd8mRfly/iRNMoQR2fU9Dxn8bcQ5NcsTik/rfUjOPdGOYb6SZO6QDGEMDwm8G/XoXfl0dwsHgI2kW0tjG8q+4axPJGUhgyDXebe0Ms9RGpE/CxH9VjyvfjXUcwH3AT1C80P1XWw8NaJck/9Vp6mb/uf9gLvMvPcaRwOmTmg7BbEsV1ZvWk270/LkNgfDPYgtstWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PLlU8XDi2037/DUrsiSQwGAQOUWJPx225NQd+y9LMs=;
 b=Ft/nd0nqqmZzFIh8Imeps+pe/+olQBl6VXYsAUnj7r8yRHzdG359RRZfJ0t7n31YWm919vVDWUc9R/tfPXKajzs+aOaJ1tP6svXiOhBvWBR45eknING+FbVW4aeEAPW6OlZIDrGvXvm4KoOeVGt3pmGQNJjivlXkRCRalmm0aF6PkB/53QdbRuGN/3PAmF2oG65nYlBMvQMReuy82dr4YQ8SlX3M3lHHby4pBQFqxrX3tL8b8xXpevbuUWMnYe3HuZrB6ACZKa9syddutjFPpwLxmP+o+rKZT8mbCD49NPy5prODisgjBALy8Xvqa/i7OWB13ZM6+uWGp4PWMtkv9Q==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by DU0P195MB1626.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 08:25:37 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%5]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 08:25:37 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Thread-Topic: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Thread-Index: AQHbrTDjqnKKHXkiQkGjYkox+TRQ/bOy0q2AgABhLACAAAT1gIABS4AAgAAAjwCAAAcagIAAFVKAgAQykAA=
Date: Mon, 28 Apr 2025 08:25:37 +0000
Message-ID: <bae7beea84e9854b1f9cd6141eedbdd6d16f8026.camel@phytec.de>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
 <20250424184923.GM5495@bill-the-cat>
 <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
 <20250425143752.GU5495@bill-the-cat>
 <CAFLszTiYCObeLy+HPnpXSE3yQ20ZN-+hptoi_nYT4DXimjHFYA@mail.gmail.com>
 <20250425161935.GV5495@bill-the-cat>
In-Reply-To: <20250425161935.GV5495@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|DU0P195MB1626:EE_
x-ms-office365-filtering-correlation-id: 06ec7046-3933-41b7-2703-08dd862e40f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bWFLajA5SDBHd2htaVZtUXVxUDV2ckxqTU9ZOEliekpiaEFUcnVTTlM1eTNW?=
 =?utf-8?B?UWs5c3hUUUdTN3JYRVBEWWF3UEhiT1lXNmFGN2dUMWU2NWpaVVViQTV1dzZZ?=
 =?utf-8?B?MFo0Z1IwRXhOaGUzdXZQbldWVGNGZ1FFbEF3RG5WWCs3dEcwOVk3SHRCTlls?=
 =?utf-8?B?ZzdLYkdqRXdjWk1XTmRyYW94QzZnb3hZNmI1Qi9aNU5WU2JYNzVLSDhSaEJO?=
 =?utf-8?B?clpDY0IzNFFFYjc5YnM4dHIrSndLdXVnUTNmRXNab0s5Yk9oNkZXeGdJMHQv?=
 =?utf-8?B?QjBJYzNCVGZZY05QQnVmSXlHRmxTdmF6Z2hCanN0bkxnWG9KWEcvVkZ3OWN3?=
 =?utf-8?B?aysvTGpiTGRtK0czdUp5UDd4VXBSRk5EMmdzQ09mREtsYTdhNzNvU20zY3ND?=
 =?utf-8?B?dkw4anMxUS9iUk9BSitpSEZONnQrdHFtdnU2amxBZHZMdFMrdHdjQUQ4a1BK?=
 =?utf-8?B?UGRLUWNSakFXeGVrSGdrVldPcW9Nc0FaNlduY1Z2Ni9sNTRGVnd6dERHck9P?=
 =?utf-8?B?aFZ3KzFxTFd4Ulh6Y3hFcXRSb056ekhqVHQ5RnA0bmlDeFF2Ti83eTcyWFlq?=
 =?utf-8?B?enorTFdqQUZLWVRINVo4eUJpY1MyVXo3UVlvbktFdXBMQ3R3WXMxdFBqOHRV?=
 =?utf-8?B?SFVicVFueThTNHpMZmhiSVZHTlR6aHNJVFd2NzFkS1h3REtsakNydkk2dGF6?=
 =?utf-8?B?clBIL0UwMlArMVlMR3ZKWTFOWEtBQ3l1V0s0YmdCNzVzVjA0bDlnYVZrUklO?=
 =?utf-8?B?dUJ0dmc2Y2d4YXE3UnJITlVsZm54a0RDaTZTQUt1MlhEdFhVYzJrWFRNd2N1?=
 =?utf-8?B?ckdHMHdEN055YlVEVVhFaFFZTjdiWmxGSk1pUnFURTBVRndnakxGRXFFLzZR?=
 =?utf-8?B?UWFiVXBTVGtYZGJnZGdEMVZKK0thdEFJZlNEODEvSjAyK1V5NmMraUQxa0hh?=
 =?utf-8?B?M0VEQVJremU4TGFGWXRUT2pNZ3hvOUU5T2h6dDdxc0RWakxrdFJCMlNRemNX?=
 =?utf-8?B?N3ZOMU82dWs0SGRtdnZQK29PSU5SMFdLR2R6R2FmelRCWU45bFVMbkNTYWRa?=
 =?utf-8?B?VzZSM2YvcHU0NHJUdXlkKytyYXRpYTM5Z2JaRmxkd1dRcWdiZTlQZDl1eXpY?=
 =?utf-8?B?MFYzdlhKRVd0Y2IwRFJjRXl4RUg0eUhidHZzUHRId1JoSkZ3YnZrd0V0dnFn?=
 =?utf-8?B?dmE0MC9KcTkwVGlya0Q2emVBR0srSis5bExQbUorMDRyNHg2ZWxKb1Y2NFlm?=
 =?utf-8?B?OFp6a3N4UDZwS3ZqSlRwZmFaRGl3QldUdjhwVTUwRHFWZGVzNHpqMmNsYVpn?=
 =?utf-8?B?SDhLd2s3OXczSzRtUkkxMVBBdDBMdWs0SDZLMExYRkVKSjZQSG1iYmlCTnFJ?=
 =?utf-8?B?V0JvV21BWWlhVU5KOTN5b29EK2U0NThmNkJKaG5PeDhmS2FxdVJ5U1ltQXk2?=
 =?utf-8?B?VGR1bDB4NnNleDZWZEdVMDVhQ09INDhKWHVRU011bHFmTEo0cmFlUHpUMlNK?=
 =?utf-8?B?Ti8xT1crTm1lSU1RQUFraHZxR25EU2RnSk4zSm9iOWFuVzVsUC9aL3NDMDgw?=
 =?utf-8?B?a3ZtWElvOVRYRzhhV2ozSWxxNSt0aStBeDZhMVAyUUtWTXJHRDlJRDhHUmVH?=
 =?utf-8?B?bm1jZnF2anJEM1FvcFgzVTJFUGROcXc5OU1OWjVVenFVOHpUMzZuZWhuTDZD?=
 =?utf-8?B?eEtQVXN1S0RZdVJtV0lTOTFIU3F4Q0Q1WGVTNnR0bG4vN3hXYlNvbmRGZGpw?=
 =?utf-8?B?VGRQN01uWHpvaHVZcXpkUUhKcDJHR0dLQ2pOZFpkaEx4OXFqb1k1WVN4cFVs?=
 =?utf-8?B?ZTYwb1B6Z1BRWDZZb1dhT0NXTEZJWEtCVm04Z0hPRXc0Wjd3Nmhoa0taa2tp?=
 =?utf-8?B?QVBsMEZ4ekhsTjdueWhUZk9ickh3U0xwUFJNUGtSNENoVlF3U1FvazFJK000?=
 =?utf-8?Q?jDYo6rRT6+g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2xKWHJLUGdGWWw3a2NLY04vcTRSZHNWejM5QmJLcU83SFZYRGFLTHEwVlN2?=
 =?utf-8?B?VWlsaXM0RHZrK3ZIVVBYdVE2c1VPNU9EbmU2eG5UZnNTUjNoQ05EbWFkdldZ?=
 =?utf-8?B?UmpqKzBKaHlGN1JGdnRhUXpicktZd3hNbmdRYXNpVFlWdkcvd3U0em5YSkxo?=
 =?utf-8?B?Rkd2dmF2cFlsbm9HQ0U1a1pDU0p4RzdDQU5FL1hacmlRcTBrMlBzQjRBYnVH?=
 =?utf-8?B?UHhkdUd3TWsyOXc3TzI4YWpiYU0zSnoxbUY5VnVoTHp5ZUZweFR3UVVZUVlE?=
 =?utf-8?B?SHp4eGZkM2JYSzQyNGE1T1FnWUQvd1p4eTNtOTNXR3h5L0FQb3UxZGNtZDE1?=
 =?utf-8?B?OUZscHdmbjVhT2U2cHo3R1d6L3JvNk1kVTJEdWVOUVQ5eFVjbC8wV1RFZlFN?=
 =?utf-8?B?K2hqWFlpcnU3bWlXRE1WZW1oc1JLRUpaTWN4d2R1Y0JUdjB3WmNUY044VzU2?=
 =?utf-8?B?Y3dLYmkvR2FPWmFmSDJ4L0UvR25UMi9oNVFVSUNFSlhqWWtLdUc0NXVvalZ5?=
 =?utf-8?B?aVplRGRRMU1lS3hFSFR5NnlVTjhOSlNCeHNiK2tQaGxQN1lpOUxYR0thY1JV?=
 =?utf-8?B?UVl4YTk2UU4zL3ErK1RwdUFDQm5Jby9SOTlrSUZyZnBxS1RVN2U1TldBZWpm?=
 =?utf-8?B?QTB3cm9wVzlBRU45MlErdUlBVkErZHpUQk9FZmxYazZJaWFxNVBSNUc1RHdy?=
 =?utf-8?B?NExpc3BRMlhJZmdqS2Z1b1FXWG5JakRSMFdvQVA2VkNrejhiRnUzZEpveVh3?=
 =?utf-8?B?NE9rbEE2NUZ0UGdhbGhVTmxYbTRPdHZqUFBIVWNRNVkvckJ3VU9PTEpLYkJz?=
 =?utf-8?B?ZlM2YVB2WGw0QXVDS1JkYkZENzgvdmR0ZWtIS1J6Rkord1krQ21COTNFZXZB?=
 =?utf-8?B?Uy9JbzF6L3cxR28zZFdhTkxiQlFMTm1Qd01IbUNxa3k1SGpnOEhCYW1zL1FV?=
 =?utf-8?B?M2JVUDFKNFNCOXJpZzJVVmVYVWh0Qm5pdTF0TS9RSzR4eUdFTHpVaFBpUnFs?=
 =?utf-8?B?QytLeHdWNDlndlBQY3FJaXBxbDdGdDlXTzdmYWNsWHBMRzMwN3R3MlRwM2x2?=
 =?utf-8?B?RE5pRDR1R2FBUEIxU3V3WmJndFBaY1lRK1FaSm0xbGsralF3U1I0ZG1FOVhh?=
 =?utf-8?B?TkxJSDdoaDdhamFsVWFtZ0hxSE1HSHEzclVRRVlMWHoxWXU1Z2RyNWprdTlm?=
 =?utf-8?B?QWRZYTdrYkwrSm1MSnowTTRMQXhqN3NlZVl3enFRKzRncGhTRzY0d0xqbWU5?=
 =?utf-8?B?dk9nRVRrbGtqQmoreDVmaU9yK3JxNU0zK3N0SGs5ZEpwQWZGUThUczFQTmtC?=
 =?utf-8?B?VWFac3l4c0I2U3ZCUExhOGJHTisrRWtidXBHQVZzVXVhMVRTQ3F1ZkJhSFkr?=
 =?utf-8?B?V0NVQ3YyRUxRSS9ZS2EyTnkwWlQyVEtuSnpONzk5eGxURUk2U2E2aU9VTDlr?=
 =?utf-8?B?MEVmSHRBbVQ3WXNhbjNCRTdHblpJMmdyRlhNbUJmMFRhcDFzb0crRlMwc1dG?=
 =?utf-8?B?c2xTeTVIRFpLL0Irem9ZdU85U2wySGRnOFpiYnkvdnlaUGdsa0VOODlKYTQ2?=
 =?utf-8?B?RlBrbUdYTHlWMWlnOWFoMjVFN2taeEhpTnhnRmVyNmExUll0bXMrWC9oeit1?=
 =?utf-8?B?cnIwR3V1ZVVFd0R3S09sV0ZxQU01V3RUSG9iZG1ITEhOc3Y4T0NLZnd4eUxZ?=
 =?utf-8?B?U2orMmFZTjY2OEZzb0lkVk5helhNVHA4c3RCd0Q5VHpPK1VLRzFnRitMaC9U?=
 =?utf-8?B?RlNrUlpYd1JlTGFMK21MR1B0UmVGNnNlNlNyeno1SUxOWkFpdzRlVUxHaG9v?=
 =?utf-8?B?b2FMMlk3NVRaajhaRlRMNnMveFRIbWwzcjB6cmdrUTRQeWp1azRCRStoMTRh?=
 =?utf-8?B?U09FWlQ2Z0hRNmszRGNLU2h0SzZQckdQQ3Z6WGZLNHArOFM3dlk5Wjk2THVp?=
 =?utf-8?B?Y0lzcmNFa3VkcThmSTMxWU90U2c4djZmSTJ6VS82M2Y2Z2N2VzBtT0Z0YXd4?=
 =?utf-8?B?anh6d09DeGYvbHBqY1YwUEwzQ2o1QXhpeUhOVXdzV2RTbUJNdXJ0REFMSEQr?=
 =?utf-8?B?b0lmOUsrU0JVbVRoM2hwazZkYkhVNVRnV0l4aE5rd2pCa3JjaStjQnRQcGM3?=
 =?utf-8?Q?Tw4eT9eAL0Pn+UTvmp6DvTgcf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C94FD74CEB2F344B4D3DB241D18EB6D@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ec7046-3933-41b7-2703-08dd862e40f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 08:25:37.2440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ClEdKfLl7+429MWhNcUBMbcRD/JloegpYgwx1zd3wX1E0V98ATgzlSqWRM8E5186imy3JderAYeQBf2IN4Zug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1626
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

SGkgU2ltb24sCkhpIFRvbSwKCk9uIEZyaSwgMjAyNS0wNC0yNSBhdCAxMDoxOSAtMDYwMCwgVG9t
IFJpbmkgd3JvdGU6Cj4gT24gRnJpLCBBcHIgMjUsIDIwMjUgYXQgMDk6MDM6MTdBTSAtMDYwMCwg
U2ltb24gR2xhc3Mgd3JvdGU6Cj4gPiBIaSBUb20sCj4gPiAKPiA+IE9uIEZyaSwgMjUgQXByIDIw
MjUgYXQgMDg6MzcsIFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+IHdyb3RlOgo+ID4gPiAK
PiA+ID4gT24gRnJpLCBBcHIgMjUsIDIwMjUgYXQgMDg6MzU6NTJBTSAtMDYwMCwgU2ltb24gR2xh
c3Mgd3JvdGU6Cj4gPiA+ID4gSGkgVG9tLAo+ID4gPiA+IAo+ID4gPiA+IE9uIFRodSwgMjQgQXBy
IDIwMjUgYXQgMTI6NDksIFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+Cj4gPiA+ID4gd3Jv
dGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9uIFRodSwgQXByIDI0LCAyMDI1IGF0IDEyOjMxOjM4
UE0gLTA2MDAsIFNpbW9uIEdsYXNzIHdyb3RlOgo+ID4gPiA+ID4gPiBIaSBNYXJ0aW4sCj4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiBPbiBUaHUsIDI0IEFwciAyMDI1IGF0IDA2OjQzLCBNYXJ0aW4g
U2Nod2FuCj4gPiA+ID4gPiA+IDxNLlNjaHdhbkBwaHl0ZWMuZGU+IHdyb3RlOgo+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+IEhpIFNpbW9uLAo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+
IHRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc29ycnkgZm9yIG15IGRlbGF5ZWQgcmVwbHkuCj4g
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gT24gTW9uLCAyMDI1LTA0LTE0IGF0IDA1OjMyIC0w
NjAwLCBTaW1vbiBHbGFzcyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IEhpIE1hcnRpbiwKPiA+ID4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gT24gV2VkLCAyOSBKYW4gMjAyNSBhdCAwNzoyNSwg
TWFydGluIFNjaHdhbgo+ID4gPiA+ID4gPiA+ID4gPG0uc2Nod2FuQHBoeXRlYy5kZT4KPiA+ID4g
PiA+ID4gPiA+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gQWRk
IGEgYm9vdG1ldGggZHJpdmVyIHdoaWNoIHN1cHBvcnRzIGJvb3RpbmcgQS9CCj4gPiA+ID4gPiA+
ID4gPiA+IHN5c3RlbSB3aXRoIFJBVUMKPiA+ID4gPiA+ID4gPiA+ID4gYXMKPiA+ID4gPiA+ID4g
PiA+ID4gdGhlaXIgdXBkYXRlIGNsaWVudC4KPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBTY2h3YW4gPG0uc2Nod2FuQHBoeXRlYy5kZT4K
PiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gPiA+IMKgYm9vdC9LY29uZmlnwqDC
oMKgwqDCoMKgwqDCoCB8wqAgMTEgKysKPiA+ID4gPiA+ID4gPiA+ID4gwqBib290L01ha2VmaWxl
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gPiA+ID4gPiA+ID4gPiA+IMKgYm9vdC9ib290bWV0
aF9yYXVjLmMgfCA0MDgKPiA+ID4gPiA+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4gPiA+ID4gPiA+IMKgMyBmaWxlcyBj
aGFuZ2VkLCA0MjAgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
PiBUaGlzIGxvb2tzIGZpbmUgdG8gbWUuIEp1c3Qgc29tZSBuaXRzIGJlbG93Lgo+ID4gPiA+ID4g
PiA+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBbLi5dCj4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgcGFydGl0aW9ucyA9
IGVudl9nZXQoInJhdWNfcGFydGl0aW9ucyIpOwo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgIGlmICghcGFydGl0aW9ucykKPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIGxvZ19tc2dfcmV0KCJlbnYiLCAtRU5PRU5UKTsKPiA+ID4gPiA+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBwYXJ0aXRpb25zX2xpc3QgPSBzdHJfdG9fbGlzdChwYXJ0
aXRpb25zKTsKPiA+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgIHNsb3RzID0gZW52X2dldCgicmF1Y19zbG90cyIpOwo+ID4gPiA+ID4gPiA+ID4gPiArwqDC
oMKgwqDCoMKgIGlmICghc2xvdHMpCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBsb2dfbXNnX3JldCgiZW52IiwgLUVOT0VOVCk7Cj4gPiA+ID4g
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgc2xvdHNfbGlzdCA9IHN0cl90b19saXN0KHNsb3RzKTsK
PiA+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIGJvb3Rf
b3JkZXIgPSBlbnZfZ2V0KCJCT09UX09SREVSIik7Cj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gPiA+IEVudmlyb25tZW50IHZhcmlhYmxlcyBzaG91bGQgYmUgaW4gbG93ZXIgY2FzZS4KPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBVbmZvcnR1bmF0ZWx5LCB3ZSBhcmUgYm91bmQgdG8g
dGhlIG5hbWluZyBSQVVDIHVzZXMgZm9yCj4gPiA+ID4gPiA+ID4gdGhlc2UKPiA+ID4gPiA+ID4g
PiBlbnZpcm9ubWVudCB2YXJpYWJsZXMsIHdoaWNoIGlzIHVwcGVyIGNhc2UuIFNlZQo+ID4gPiA+
ID4gPiA+IGh0dHBzOi8vcmF1Yy5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvaW50ZWdyYXRpb24u
aHRtbCNzZXQtdXAtdS1ib290LWJvb3Qtc2NyaXB0LWZvci1yYXVjCj4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiBDYW4ndCB5b3UgY2hhbmdlIGl0LCBzaW5jZSB5b3UgYXJlIGludHJvZHVjaW5nIG5l
dyBzdXBwb3J0Cj4gPiA+ID4gPiA+IGhlcmU/Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBJZiBu
b3QsIHRoZW4geW91IGNvdWxkIHBlcmhhcHMgc2V0IHRoZSBlbnYgdmFyaWFibGVzIHRvCj4gPiA+
ID4gPiA+IGxvd2VyY2FzZSB3aGVuCj4gPiA+ID4gPiA+IHlvdSBmaW5kIHVwcGVyY2FzZSB2YXJp
YWJsZXM/IEkgc3VwcG9zZSB0aGF0IHdvdWxkIHJlcXVpcmUKPiA+ID4gPiA+ID4gdXBkYXRpbmcK
PiA+ID4gPiA+ID4gdGhlIGNsaWVudCB0byBkbyB0aGUgc2FtZSB0aGluZyB0b28/Cj4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiBJdCB3b3VsZCBiZSB2ZXJ5IGNvbmZ1c2luZyBmb3IgYSB1c2VyIHRv
IGhhdmUgdXBwZXItY2FzZQo+ID4gPiA+ID4gPiB2YXJpYWJsZXMgZm9yCj4gPiA+ID4gPiA+IHNv
bWUgdGhpbmdzLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBTaW1vbiwgdGhpcyBpcyBhbiB1bnJlYXNv
bmFibGUgcmVxdWVzdC4gVGhpcyBpcyBob3cgUkFVQyBoYXMKPiA+ID4gPiA+IGJlZW4KPiA+ID4g
PiA+IHdvcmtpbmcgYW5kIGRlcGxveWVkIGZvciB5ZWFycyBhbmQgeWVhcnMuIEl0IHdvdWxkIGJl
IGEKPiA+ID4gPiA+IG5pZ2h0bWFyZSB0cnlpbmcKPiA+ID4gPiA+IHRvIGhhbmRsZSBtaWdyYXRp
b24gb2YgZXhpc3RpbmcgZGVwbG95bWVudHMgZm9yIGFuIGFlc3RoZXRpYwo+ID4gPiA+ID4gY2hh
bmdlLgo+ID4gPiA+IAo+ID4gPiA+IFllcywgSSBmaWd1cmVkLiBQZXJoYXBzIGl0IGNvdWxkIHN1
cHBvcnQgbG93ZXIgY2FzZSBpbiBmdXR1cmU/Cj4gPiA+ID4gVGhpcyBpcwo+ID4gPiA+IHRoZSBm
aXJzdCBJIGhhdmUgc2VlbiBvbiBSQVVDIGluIFUtQm9vdCwgYWx0aG91Z2ggSSBkbyBzZWUgdGhp
cwo+ID4gPiA+IGZpbGUKPiA+ID4gPiB3aGljaCBoYXMgYm90aCBsb3dlciBhbmQgdXBwZXIgY2Fz
ZToKPiA+ID4gPiAKPiA+ID4gPiBpbmNsdWRlL2Vudi9waHl0ZWMvcmF1Yy5lbnYKPiA+ID4gCj4g
PiA+IEkgZG9uJ3QgdGhpbmsgdGhlcmUncyBhbnkgbmVlZCB0byBjb21wbGljYXRlIFJBVUMgc3Vw
cG9ydCBoZXJlCj4gPiA+IChub3IKPiA+ID4gaW4gdGhlIGZ1dHVyZSBNZW5kZXIgbm9yIHN3dXBk
YXRlIG5vciBhbnkgb3RoZXIgbG9uZyBzdGFuZGluZyBPVEEKPiA+ID4gbWVjaGFuaXNtIHRoYXQg
bWlnaHQgYmUgbW9yZSBlYXNpbHkgaW50ZWdyYXRlZCB2aWEgYm9vdHN0ZCB0aGFuCj4gPiA+IGVu
dmlyb25tZW50IHBhdGNoaW5nKS4KPiA+IAo+ID4gTGV0J3Mgc2VlIHdoYXQgdGhlIGF1dGhvciBz
YXlzLiBJIGFzc3VtZSB0aGF0IFUtQm9vdCBoYXMgaXRzIG93bgo+ID4gY29kZQo+ID4gaW4gUkFV
QyBzbyBpdCBtaWdodCBub3QgYmUgdG9vIGJhZC4KPiAKPiBJIG1lYW4sIHN1cmU/IEJ1dCAic2hv
dWxkIiBpcyBub3QgIm11c3QiIGFuZCBJIGhhdmUgemVybyBkZXNpcmUgdG8KPiBtYWtlIHN1cHBv
cnRpbmcgZXhpc3RpbmcgdXNlIGNhc2VzIGhhcmRlci4gVGhhdCB3aWxsIG1ha2UgbWlncmF0aW9u
Cj4gdG8KPiBib290c3RkIGxlc3MgYXR0cmFjdGl2ZSwgbm90IG1vcmUuIFdlIGRvbid0IHdhbnQg
cGVvcGxlIHRvIGRlY2lkZQo+IHRoYXQKPiBjYW4ndCB1cHN0cmVhbSBwbGF0Zm9ybSBYIG9yIGZl
YXR1cmUgWSBiZWNhdXNlIHRoZXkndmUgYWxyZWFkeQo+IGRldmVsb3BlZAo+IGFuZCBkZXBsb3ll
ZCBpdCB1c2luZyBjYXBpdGFscyBvciBjYW1lbCBjYXNlIGluIHRoZWlyIGVudmlyb25tZW50LgoK
SSBhbSBub3QgYSBjb3JlIFJBVUMgZGV2ZWxvcGVyLCBidXQgaXQgc2hvdWxkIGJlIHRoZW9yZXRp
Y2FsbHkgcG9zc2libGUKdG8gY2hhbmdlIGl0IHRvIGxvd2VyLWNhc2UgdmFyaWFibGUgbmFtZXMu
IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhpcwpjcmVhdGVzIGluY29tcGF0aWJpbGl0aWVzIHdpdGgg
YXQgbGVhc3Qgb2xkZXIgdmVyc2lvbnMgb2YgUkFVQywgd2hpY2gKb25seSB1c2UgdXBwZXItY2Fz
ZS4gQW5kIHRoYXQncyBzb21ldGhpbmcgSSBob25lc3RseSBkb24ndCB3YW50IHRvIGRlYWwKd2l0
aCwgYXMgaXQgbWFrZXMgdGhlIFUtQm9vdCBhbmQgUkFVQyBjb2RlYmFzZSBibG9hdGVkLiBBZnRl
ciBhbGwsCmNoYW5naW5nIHRoZSB2YXJpYWJsZSBuYW1pbmcgbm93IHdvdWxkbid0IGJlIHZlcnkg
KnJvYnVzdCogZm9yIHRoZQp1cGRhdGUgY2xpZW50LiBJdCBpcyBhIGtleSBmZWF0dXJlIG9mIHN1
Y2ggdXBkYXRlIGNsaWVudHMgdG8gdXBkYXRlCndpdGhvdXQgY29tcGxpY2F0ZWQgbWlncmF0aW9u
IHByZWNlZHVyZXMgYW5kIEkgZG9uJ3Qgd2FudCB0byBicmVhawp0aGF0LgoKU28geWVzLCBpdCB3
b3VsZCBiZSBuaWNlIHRvIGtlZXAgdGhlIG5hbWluZyBpbiBsaW5lIHdpdGggdGhlIGV4aXN0aW5n
ClUtQm9vdCBjb252ZW50aW9uLCBidXQgbm8sIEkgYWxzbyBzZWUgdG9vIG1hbnkgc2VyaW91cyBk
b3duc2lkZXMgdGhhdAp3b3VsZCBqdXN0aWZ5IHN1Y2ggYSBjaGFuZ2UuCgpLaW5kIFJlZ2FyZHMs
Ck1hcnRpbgo=
