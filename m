Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F59C7115C
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 02:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BF181F66;
	Mon, 23 Jun 2025 04:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="oCmdEPWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A1981FEE; Mon, 23 Jun 2025 04:04:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBEA58006D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 04:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN2kyDNvkKJ3IQ4DDrJP2614cw44k3SyJa/pKWil4ShFWrYNeyvM0xmWRImeHEaiLQDNggkKJe+ywd/wDHm8AxE6XPiQm51786bq4/J3u6o9mAggoy7eu4NMNHuzLKS3ZWv+lrh5Zgqh+eWEYQ2sILqUI4Qxxdcyyric71F+aH84Cr5ZrZBCALk9AUVk4AdDiR1zSRsJo2NPqu+rX7Tzm7Lk/HGiP3D2DMrc87+S+Mtwh3NODU+5yYaYE4aL4WdZAl2HxUaAWDR5VlvqgOtssKDE4UXP3NzhN1L00AhYDV1FboN0vFv1KmZjiOKSD8d8dexHf/JusYMQFehlYC0g0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T6KUW3+mk2ZiY3q+hEtm6FGKJBSCQPDSzE+QLv7UQc=;
 b=QdJp4rcqdIYCZ+9pfrBxXtII7R+iQN3MtmZSLD1KG/M+FBjFg8hqrRaZQY5ETz9yQqzRPfestI3lSALpVm7qIlh4z+skVqacCjUQJ2fd3Z/6/CkvYRyqNNWCfemzVdDjqSe0pPLtQAyESka5uBYw34hsF9J7nmN93apLNcwxNjInmfJgWYRlMWvLwh4fUT3nZVyuXYHCUTZct7kJCotYzW2v+Mfbl4CRFRB0VkVZhP/LLM5O4LnISWIiUTSihz5NVvP0uDxygZ1r5baRcBgixVCRxU37HV3941Xv1UX+3c7T5mwq3pIG7RjD8EQEt5jPG0+E1Z+ToI4LjGTrPF/MNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T6KUW3+mk2ZiY3q+hEtm6FGKJBSCQPDSzE+QLv7UQc=;
 b=oCmdEPWpWQe6O6saRZz/WM8MBrXiwgEQ0oSCADzi+FbKipcYKfIQQ4HvZZzX7gulWZ2G5KWmHucTyPSe+/JtHGNuMw8dKPHy5lB2qhYtV/0Voip75kpZNpBAWG/nfx8lJKcR0YAIZwlowE9E3kRO0CmMAlhsuApkm4xZbjupRash6FcTDTLcoma340MyJv2ur7ygpthtSaZ1vp/ybM2ifXtqZNl5p6dOWBccIEnaWTaj/kkUGo8T7+P0+efV0aTOZgcy2GyRpjqjVfM3OZxWYpcqQLCQCAS8zPEYGAoVFxioN8swYzk7Xj73Nk/YslYd1nn85GoDuCuX5gAVUuRolg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9746.eurprd04.prod.outlook.com (2603:10a6:10:4b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 02:04:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 02:04:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>, Vladimir
 Olovyannikov <vladimir.olovyannikov@broadcom.com>, Akio Hirayama
 <hirayama.akio@socionext.com>, Masahiro Yamada
 <yamada.masahiro@socionext.com>
Subject: RE: [PATCH] Revert "drivers: mmc: rpmb: Use R1 response"
Thread-Topic: [PATCH] Revert "drivers: mmc: rpmb: Use R1 response"
Thread-Index: AQHb4hO5jWYt6mB1q0qS5yDZ11zaQLQQAhLw
Date: Mon, 23 Jun 2025 02:04:34 +0000
Message-ID: <PAXPR04MB8459042A0FABC417086FC7508879A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <5e3239ff-205f-44de-ba43-8b32eefdbe73@siemens.com>
In-Reply-To: <5e3239ff-205f-44de-ba43-8b32eefdbe73@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DUZPR04MB9746:EE_
x-ms-office365-filtering-correlation-id: 26dd3a4d-b5c6-4e60-97fa-08ddb1fa4caf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1FtdUVEcERJVURobnpDR2pFZmRQdFRHMnNxVS9Icms5T3ZQNVVqeDQwK0JP?=
 =?utf-8?B?UVBQTlJmUnVYbnZrNVAvMkRnTkw1eGpGdGpDYlRpcExpTFVqZmRsZXV5OUdY?=
 =?utf-8?B?b1NwbWEybFdXcWRNbmc4RWlMV0p4QVoyRjBGR3Z0UERlV3RrZ3RkV3hjVDRO?=
 =?utf-8?B?dnlIc0tCQ3ZGYTVBUWQ1MDJwOVpCLzNCWkxTQ0ZBZU9oWEFaZDNyT2lvNDdK?=
 =?utf-8?B?amVNVXZYZjEzeEUrcjhIRy90MkdqQ0RiWjgwNWhoNnJQVlFWc0dTNExSOFZP?=
 =?utf-8?B?NlNYTlVIYnIrUlNxcitjWHZhV2prK05uTWNnSmNxbDU4dGFWWnpIandxZmJ6?=
 =?utf-8?B?L0psVnNTQUJ2WnB2RFlSSHRhbE52TmhYb0VlRzl0ODZlbVcyT0orRXU0c1lW?=
 =?utf-8?B?clZwaXJKa24wTjBEQzJaYTVkVFdBTlA4NlZGQXMwYzZ6aXdLbEF0ZUpkQlN6?=
 =?utf-8?B?M24zZjZicU8wZE4vS1htdkVPbE1YYkVNUkhQNGN6OTZueWhnNWl6N2RkQ3hW?=
 =?utf-8?B?NGptVnJxRldydEFrUVAvcjFETkJNNStLY0pDY0FoV1ZBaW5KT2JCUFhBS3Zu?=
 =?utf-8?B?ZTMyYmVLQjE3NGM5ME1kZmo1NGJILzdwVFo4NnUzeTRFMlkvVW5OWWROOGt3?=
 =?utf-8?B?cEVNNWlwZGdOWkZnS1hDUVpVbVZReGxpUE0rdktmNFdSdVNsUnlmVWZJMUZ1?=
 =?utf-8?B?TjRORGM0V096VFBLdWlDdytCMmhCb3JIY2F0Tnk5QXFnaGxFbW9qdFoxOGVq?=
 =?utf-8?B?WlVMVjdFUFVSY3RlS0tPcG13Vmh3SlBtTW5lUnl1Q1htYnV2YWM5RjBPTjVy?=
 =?utf-8?B?NGJUdndqUFlnaEt2U1lvZng2MjB6OUd0MEx0Wmo5TURMVXlSa2NXNkxDNk5S?=
 =?utf-8?B?N2wzTkZzeWxzU0RFVDhJeHhlMUJGQVdCdUI2UWdhRW96bFJSNGY5Uy9TNi91?=
 =?utf-8?B?K05JZ0M5QkhoYzlFY3BzWDdhMGNIbSs5L3h2M3RFSktCaXhDUm5sL1FOVE9E?=
 =?utf-8?B?ejBTdzIwWElmajlQeU9ZMWVWNG9qZXJyS0xxNE8yaHZUVEJVRW9uVHk4MThk?=
 =?utf-8?B?ZmZaNmROTkRLNCtWQ2tuMjJoR05kTDEwZ2FTTHIvTllaT2IwaTZBVXNNMGVY?=
 =?utf-8?B?RmtGRFJnQU9TNlJsUmlvL3RZN1oxeUU5blgzdnNCVkliV3FHWW9RZ09UbDNu?=
 =?utf-8?B?UHlnSWo2ekZ3TGlnazNyR0UxWWpTanVJN01ITkJhcm5xVVJGR0xqT21Nbmk3?=
 =?utf-8?B?VE9TT2c4bjVLWnNPWVhmZGo2Z1VmSytnSmgxdVVNL1JHYzhZbnd1aVoyY1RI?=
 =?utf-8?B?RGhWYlFzMUNUaTBHYUNsVEFiY1JhM3phaUdZalRxYzVNK01EVkVHb2w3K2d1?=
 =?utf-8?B?dzZJcXRzbHpvL0RIbng1SDhNbWRUbDhISEZaTmg2Qk9Rc1Byd0RzSUg4c2tv?=
 =?utf-8?B?U1JRdVpaeEdPemUrQnYzWWtRZXQwZ2JtbUo3UEJpVHZwazZDWnNlbitMeEN0?=
 =?utf-8?B?NEZiZ0hDT2tlUm4yd1FwSWsyczNueFN2UUJGVjFkRFVlWG5VT0ozdFdVRjJL?=
 =?utf-8?B?SzVWaTl4R2ZLcm95anowZFYxNytiWWFUZGdscGEweFVlYnk3aTBuZWV1YW1D?=
 =?utf-8?B?OWd2bDFJKzZXUit3Tzhpd0tCdjVUbVkvWkI1YzhoVFcwUytNVE1BUSsvL3dm?=
 =?utf-8?B?ckh0N0lPbFQ3ZFhMYk1KWTNyRlNsOEZMeW1OK2Q1NFpKSEo3M0lmY0k3OWhl?=
 =?utf-8?B?Vi9qdG0wSVJ2dkdLUDUrRUtIZmF6MkdFcVFvS3RtMS91ZFM5Nk1iOFdab1R3?=
 =?utf-8?B?TTI2ZlMzSHpqSzVkNzZ1OEJERHd4ZFNuaWE0dWFyU2hSSXZuRG1wOVhpTnZG?=
 =?utf-8?B?MURrSm41L1k0eGIzLzBCV2Z3OW4xc3VEcXpEOWtRcjFEUmE0OC9rdjRRMk1Z?=
 =?utf-8?B?elFzcDRkSjJ1MGJVOU9NdG1GV2dnZ1phMFhmQ0QyWTFwRXRrMDdQMmVlNmgw?=
 =?utf-8?Q?GhJ++NXq3UwIAuC4nboi3STlPTsxSw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2UxWmZGVmVOZHI0bFFKUEdCSVhwU3ZXNG5nVXNaOUxseUp6QjdteVlXQzk5?=
 =?utf-8?B?dTdrRmNPR3gzODdpU3NlSER6dUI5Tmgva0I0Zjc2a3RuK294MHRGQ2FwZVFj?=
 =?utf-8?B?QzdlQVRrejZzNnRSYzNhYllxbXU0cDRqVE5uamZjaDhjQXlaTDMwUUZWVkZl?=
 =?utf-8?B?b1d0OVV5RUFFb3hJQTh4eG9rdUoyd3BoRGxybitCekhUWTR0bFFxVUNIU2xF?=
 =?utf-8?B?VkQyVVlwVUl1cld3SUFGZDh2R3hwSXBYRnc5enYvNWdmdEZiVU8reU95Y3RQ?=
 =?utf-8?B?ZFJaMFE4ZzR1OWZpR25yUm0zU1c5ZDd2LzZMd1N4WWd5MVByRXF1b3hBMkpY?=
 =?utf-8?B?NDkyOXlrdDhlVUEySUtYaUc4dm11eU5FOG52Wlc2OEJrQzVLMnVlRnlIRGto?=
 =?utf-8?B?MTBLK05WaFhSQUgwZUxZdTAyRGVUbzJMbi9JOUw0YlhNeVJYdDBRQWFQNmp3?=
 =?utf-8?B?V3p4QnkxYWJTdlY1S0YreFVSNjZITmZFOGlhcWQySkhZQzBBbHFLdzVoODdZ?=
 =?utf-8?B?Qy9SeW1PTWVrNTFNak1pejdIdXBxMnlCVjJJZm1KTkpOYnFVYkdoWGZTWnYr?=
 =?utf-8?B?aU5hRzYwU3JMdWJ2VUo0UW1mcGRYeUw5NVF1N1RKYVRSRWdmQ2ZFWWlJanZR?=
 =?utf-8?B?NGluUGc1V0ZZMVRuSlh5SERhY2JRdFpuQzloRTgwdHFpdGNaMzMwNjcvRGFP?=
 =?utf-8?B?N2Qwek9ZVlpXWlFxb2U2V0o3L3ZxaFR6VzFrWlQwZzFOTWlxbzE5TWI5V28r?=
 =?utf-8?B?V0lYei8xV1NqYzRLdUdTRG90TEdkSGZscTNYazIyZlBvcXZHTjNsSzU0bmpD?=
 =?utf-8?B?U0VyQ2NrWkhQMFZ0WldPK0FTSXVrY2NBajZ2MHY1blJxa2xaTGtNTFpKVlhv?=
 =?utf-8?B?WXFrR2hhSllCYSt4SjBOYzR5ZG1HTVl6QStUM2RJSTdybG4wL3FPZ0x6UGZ3?=
 =?utf-8?B?VjkrcXN6WUdGbWx6bmtBRlI3MkhPVG5JMFhYbnJuTnBlc0d0VlFESmI2NjBq?=
 =?utf-8?B?aVgwdENESWRTVkVCb21CQkhFMHhJcnJPNVBvejgySzRwamJ4SFdkdEU1N2VO?=
 =?utf-8?B?REwrazAyajg1cGhjVjc2Uzg5bC9JU2NBWHNDY1ZwcFBQTTNVQjF5L2dSQ1Rz?=
 =?utf-8?B?cGdNSElVMlhEQnBldWxyS29oUlNjWGoya1plUUE2dlUvQ01mbkhoWUt2dGtJ?=
 =?utf-8?B?NFVlN3c3clZhYitUSFRtTWhNMTZSREtmczk2dmJpcFBJcXp5MkNSRnNDQUFa?=
 =?utf-8?B?THp0YzZKSGpkTDE4VVRoQkIxSVBNc3B3VXlQWmxNdXd0MnJTL3FxaUNBbU9V?=
 =?utf-8?B?cnNnL0VUSHEyOHYxd0Z3dEJXNlB4K2FjREFvRzZhdm16T21DRjNnUnFjaisv?=
 =?utf-8?B?Mmd0cWp6bnQwSjExQWd5OTRGRVB1clpYSTBqMGxrbXBRWHRLdDRiOHNzb0F4?=
 =?utf-8?B?TUZJNGVoSWNsQkk5cHBibnNVN1I2WFAxcXIvMS9kNC9BdFZ6WGZGMUVGSkc1?=
 =?utf-8?B?QUhRdzBIS0gxSGhzdEt6d3JPRFRQb3Q5VnlWL3hHa2ZSL0YwUEdoVkJzREJY?=
 =?utf-8?B?RXlscWhSQmU1YklYSUc4V25Ta0c4STlXeHp2RVhJS0RweWJ4NG9WOCtuVHZk?=
 =?utf-8?B?akI3UzZBd3BXNitYWDdvQ2JFcnhuOEt2UHpSUlFkd25sK2V0ZEUzbHNWSWM2?=
 =?utf-8?B?MlgyMk05amhHVmZlVFVkb1JHdFlSeEt4Vm14bTJPOG5IbnJJOG1kVzBxRFRV?=
 =?utf-8?B?SXdqREFRWmtSWVlTbzRScGJ2V1FRSG91eVloYURJK1ZkMmpocFhsUjNGMkxT?=
 =?utf-8?B?ZDJ6bExvZ3F6cWczcW9BNUZabjhjRTBLTWtoMy9NMkk4RFJHL0hscXF6eVY2?=
 =?utf-8?B?b0dSSGtkVmxLY2kwTUNqenJTL0J5TVhYc1JnWC9JYjZrUVJ3eTFZUjhXT0da?=
 =?utf-8?B?QVdkSXFWR24rdU5TVW5MRDYvQkFDcGgvUVI4OGJTS0M3NUZaSDl1VTJDekxo?=
 =?utf-8?B?YjJaWVJZRDg3SmQzQ082eEhzVXdMbXBGcEhnM3Q2WVNKV29hZCswdGRpSVAx?=
 =?utf-8?B?QitCd0JYRFlMQTc4b0czU0Rvb2tMTUxDYnZMOEt4N3ZXeGQ3OHVNWUZkaEk5?=
 =?utf-8?Q?ddF0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dd3a4d-b5c6-4e60-97fa-08ddb1fa4caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 02:04:34.2444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMSVsCS3nuqcoKqggcLyQ7Z08HhpSQyt5Ffietwbf/GqXqOwzcvbAB7WcTt2zGDxT89c0cmL1BtGfflsAlnRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9746
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

PiBTdWJqZWN0OiBbUEFUQ0hdIFJldmVydCAiZHJpdmVyczogbW1jOiBycG1iOiBVc2UgUjEgcmVz
cG9uc2UiDQo+IA0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0K
PiANCj4gVGhpcyByZXZlcnRzIGNvbW1pdCBhZTkzZDgxMDZiZGI1OTI2ZWZlZjkyMjJkNTUzYWRi
Mjk1ZWJjZTk2Lg0KPiBJdCBpcyBubyBsb25nZXIgbmVlZGVkIHNpbmNlIDI0YjFlMGM3ZTJlMy4N
Cj4gDQo+IFNpbmNlIHRoZSBvYnNvbGV0ZSBpbmNsdWRlIHB1bGxlZCBpbiBieXRlb3JkZXIuaCB3
aGljaCBpcyBuZWVkZWQgYnkNCj4gbm93LCBpbmNsdWRlIHRoaXMgb25lIGRpcmVjdGx5Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
