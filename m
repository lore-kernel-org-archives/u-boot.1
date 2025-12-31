Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1CEEE642F
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 13:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A8E8405E;
	Wed, 31 Dec 2025 14:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="epeudS1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B25338401F; Wed, 31 Dec 2025 10:51:18 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0070483DA9
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 10:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSJgwzqZQp3UrqH0BEgyR7rXYaTC15m1N/l/45lOXvxmonbBjIUwvmHPbW8ZEfe6lQrSdW2dtdDK5f8ZsuF8XAAqr3tz0E65p2o8d4NnvkiSmXh/xS+IfEPZHlQ9M14onz244ZjP8wQwz432retYtigK5CDJZ9Q+XwZnuQqa1FcvFxT80go+mrfR+sYw0gdd6mmlkgOOoLSQYS+CMguyH9OZ6mBV9EMQQg6n3YJ2yl3teXVShevQkGCLLDy5cKs9bHs9oXlI1c9q+FMtzIk9+uOnmB8Jds0H4jZ1kMRBJR6UJmjHqhLvIEAarmG9d0DIppL4+fHqSbP29LwyxX10lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKk5DOGTAedCXCjDwARrtFsWUJqI0IhoEuVrBWrnWNw=;
 b=fTacIyMd0JxwUHnUGC0I5A0+qBAZjyW1ZGgyxe5rI4Tc6KrYZW3bv04WFCuGMig1hMZGzw3rUP5WqzbSyF1Na1L6NENXxSmbon/f5XzxP0UVNkluhJUQHio0JrrAARYzMeje6xnSHycma7kaiSalqhWPMrDjXnEkjsNef1PepzAu5x7lQqtZSvqGpN2cxrdbEP4V4OZTnQqXVO/1zv3g8wMnlmOed2dGbP1ZouvRRqrlWHE+IU/G4jp6NA6E9bbgJJs0fimjE6nsyfbR0VPYC53xreNfndEehU/vItSyElejLgtPcTZxX1UemvaBdsI7G1akDK2JdgywCLaFCg1mzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKk5DOGTAedCXCjDwARrtFsWUJqI0IhoEuVrBWrnWNw=;
 b=epeudS1O99vF91uzsem61pWSPwbacjoHzMv8xTkG7TquuUBWM9NMxXkF5xJu0XZalIAw4VFFu+N4pIZzduV3TVrZExMteYfaiUxJ56kEeSyxxE+GtK6BnUvfh795r4Uel1S6ZEWGTux/F21Dd/aY2kMyS5xT9++gIDQ/TYiLFin7Js8HgEHg+dz8e/JGBjL8G8r5o6WpmDOKF0+y5PjrjbTIP5XCyKEi3SPKYrDOkjmv87CECuY2n68eUzYaLP7Yr9HfX+31YBBu2db0GJPHxNTLUm4nL83sCEW50ZybskuM+xIft8/bXamdRrSBnrG9+MZdtkmoEsiszoupqOdXtA==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 09:51:13 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 09:51:13 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "bhimeswararao.matsa@gmail.com" <bhimeswararao.matsa@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "kauschluss@disroot.org"
 <kauschluss@disroot.org>, "andrew.goodbody@linaro.org"
 <andrew.goodbody@linaro.org>, "tanmay.kathpalia@altera.com"
 <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, Bough Chen
 <haibo.chen@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: [PATCH] mmc: Add power stabilization delay in
 mmc_power_on()
Thread-Topic: [EXT] Re: [PATCH] mmc: Add power stabilization delay in
 mmc_power_on()
Thread-Index: AQHceXhaPrhqQxrt/EutbaKPhp8Tb7U6L98AgADW5NA=
Date: Wed, 31 Dec 2025 09:51:13 +0000
Message-ID: <DU2PR04MB85677D23C8B9723BD6E525C6EDBDA@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20251230103950.1543515-1-ziniu.wang_1@nxp.com>
 <ce85424e-b18f-4dc7-b62b-a8220e9ed7a1@mailbox.org>
In-Reply-To: <ce85424e-b18f-4dc7-b62b-a8220e9ed7a1@mailbox.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|AM9PR04MB8114:EE_
x-ms-office365-filtering-correlation-id: 4c740a56-c2c7-4b98-f4ad-08de48522271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?OWlTQk04SlkyaTFTZFpOd0I3MzM2VjJzRktvY3hZb2N4S0VDUEhmbU0remxt?=
 =?utf-8?B?bXEzdjdvMGVqSFVJOFlLU1U2SDQrMVhKbnpSa01NWHFybnIySitDVXl5NmN2?=
 =?utf-8?B?TmFNK0VrRnFlRjU4ZEhSdG9qZzludi9veHRhcGo1RVArdHVLQ3Bod2xHR2VW?=
 =?utf-8?B?cWdMU2EyaHZkTzNucmhoSys3YVd1MFBOUE9HTVZxSEJwMnNRRXlyL2dqaWw5?=
 =?utf-8?B?SitPbWlIbHJkVEFvSmI2dnZ2WmwyUGJkYXV6OUVnNUZwR1cwcjhJeG9sbU9O?=
 =?utf-8?B?NDNoVE9uc3RnSW1jM256Y3NZclM3NWs0ZFNpc3RwcnBNTGh3WWpnSGRDbDRr?=
 =?utf-8?B?MlpVdHh0alZPbzlXR2Z1NGtwYXRkQTJTblFqQ2FTSGIva08vYWJJMWsvUkI1?=
 =?utf-8?B?ZkR5NENPUWFpbEh6enh5VWo5ZzRIbGNMclB0b0tFYVVkUk1Ob25LWkNZanBm?=
 =?utf-8?B?TUU4M211KzF6WDJjbHAwdG9FYXlpdTY5dmlCUmt3R0oxajFLYklUUjVHWjlD?=
 =?utf-8?B?cmVrbDl6d3RjUGY1TCtYOFY3K3dnNTEzSjB4U2pHM1o0NGtoQ0laRTJMMTFU?=
 =?utf-8?B?di9WL2hnOFF2RTJlMjR1MFUwcnpvRXdXWktQQU5VakxXdUhWZGtVMTNLMDBS?=
 =?utf-8?B?RlgyY0h0SWRBeXBQU2RFSHZGZ0x1VEpSSzVXL0xnczVDeWd2eWt3VFI4Z0tl?=
 =?utf-8?B?U1ZWaWpLVHJua05TOGFDM2pMaWhBdHppTTBkNEZvN3d0cFlzN1hKQ0lLay9Q?=
 =?utf-8?B?WUJmeGhVSzA4QkpaWmFxT2l1RkhyQVVYTmJ0QUxGdnNHVWpmTkVDVXIyQXZk?=
 =?utf-8?B?VUZINTB1eXdxQ3ppaVBiOHRNdGV2b21xd3YzV0VGcWZ4dWNOQnpQaWhUVFNG?=
 =?utf-8?B?YmJJWkZSU0NBb1dPaHB2R055cDdJbENZT2N1RGN5OE1VM2dFNnQxbXdISlBL?=
 =?utf-8?B?cEJ5OS9Fa0YxWUhhdGoxWlkxbjlvVU9SQ1RRTm13LyswM1dEdXQvbXR4eUNM?=
 =?utf-8?B?U21lRnU3QjRNMnJWVVBEMWNGdzBNZmVwbDhiR0ViZ2k0WFQwbDY5S3k2YlZM?=
 =?utf-8?B?VUtxbjVUbUZqaFFKU3JNeTBCYzVCSUNrbS8zRVY1QWdmMVVpOXFYbUpHdGNH?=
 =?utf-8?B?TzRpcFh5RWh1MGljWFRRaDFxcFExYlprR2MxQWxqcjRUNXpXclBZVnNML0lL?=
 =?utf-8?B?UVZLcEJ2RnRwSWFoVExsTk50cEtjVkdSbzRpMEFRQWNiNEFlMG15a2JFejBM?=
 =?utf-8?B?Ly9LWm9WbXNxZTZDRWtZRDI0ZU95Y1VlQ2NDalh2NFpxc3NUQXhtdHZrNEhP?=
 =?utf-8?B?ZVFWVkIvVHB0UkJKamJGckFVUWJOUlE3bnNkUldBYnlhc2szUW8xaStrN0xL?=
 =?utf-8?B?ektIL0ZDc2VZOW5DT00yY3c4cmtjcUxURXpEOXZqWWJtNWJTcE41YkdQRFlP?=
 =?utf-8?B?V082MEpieklOTzUwQUxBN3pyTk9qR1ZNRitRdGIyRjRXNFlHYkFZTGw2SU1O?=
 =?utf-8?B?YmhrTW5GcUgvMGk2VFV1RXFXejNCT1hUN0dCcTJSeFRhSS9BTUpVSU5nM1lv?=
 =?utf-8?B?allSYk5lOTlhWmFLQUxXSWR5bk50MEYrbFp0Sk1GNkdlc3lhUnp5eGJVSUZO?=
 =?utf-8?B?N3hjdldlNG5JYjFyZ1pHZ1VaM29hL0ZkcnB3b0hxS2VOdDk5Z05HSHcvVnJH?=
 =?utf-8?B?N3lCZTFjTVJlTTBsUmYzOWtXTlNnUVBUWFRLYlIrMitVMzdPMnJTWXF5aFZJ?=
 =?utf-8?B?cDkzeCsybWVuaWVweDkvc01lRGx0MXpKR0kwN1p6SzdINEU3OTlsSFJVejVL?=
 =?utf-8?B?R3l4M3FYQUVTdDMxVEx5UnJ4M3dFbVNkV1FWTUxKT1NEa0RnV3dtdjNWdWVo?=
 =?utf-8?B?ZGZsMkdab2V0WlBJZmZVYVRueUZXeWtJVlRxTlVianEvWjNOUmhVWENuQ0FG?=
 =?utf-8?B?RE5Qb2ZBbExZWkRURC91R0xNak0zRG9kK3dVY2NkVFBzV2tRTzZvdkpjdEtJ?=
 =?utf-8?B?cFE3dE1nU2dBL3hIaDIyb3F5eHYzWE9WZjJZVDhHbC93N0V4enRJU1B4RWhq?=
 =?utf-8?Q?hRxeYa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZHcXJhWngwYWg3cG50S0tEWlc2WmdBcUlESnpYakl2d0FlZnQzYjc5dUJo?=
 =?utf-8?B?bXlrQUJsdDZJSklHVVNaTThSbWR0Q3d4OUVpMzR4emxVT2VNNzhnQm5oNU5q?=
 =?utf-8?B?RXc0S0JRUUNsY3lDSmZiQzFsRjdyTGRsQVYvdEZtLzIyeEtHQnJJelhCSjJ0?=
 =?utf-8?B?U0t5WGpSeDE3RHRPdHAvNHR0Vmp1bjJqV0UwSzRDbGNWcFI1WXJRYkR1VVZC?=
 =?utf-8?B?ZUQvcXlVR2t5SVhkQmtVczg5Y1ZtNDNlY2NjOGdhcWlBc1EzTTFzYU05L0l0?=
 =?utf-8?B?ajBSdzBOMFpqQW0rYXhKVWl6a3hmNEM4U2loTnNxdXp4NGFwMnY5RlF1a1VH?=
 =?utf-8?B?elhUWDd0Y2U3VHIwZ09hU0JxVmlzWDNVR3RMSGR0a1owVm5zbXpGbHcxbEJQ?=
 =?utf-8?B?MmZBWEhUUm11eURxV1ZTU3lDZlh1Z2hEc2txYWZJTWp1K281N29HbGpZT3hv?=
 =?utf-8?B?OG04TjFVb2FNODNCUlhNd1ZmYlhkTm5SVmM5bDAybkxjRHkwdGozTjI2ME10?=
 =?utf-8?B?Nng0QzQxeEtzc1RxSXNTbnNQWVoxdElOUmJKbXQ0RXkwamY2TG8wMUdjalky?=
 =?utf-8?B?b3g0VzFuOTlVU24vWlRxU2x5Q3NpaGZNZ3QwUXFzQ3dZajc3M3BWdnpXelB1?=
 =?utf-8?B?eDRvaXpBbkZYZHpia1NZVHBYWWlhUk9ZOXpmd3FtSFdKNEtGcDR1S3REeXNK?=
 =?utf-8?B?YVlYNDdPRGZoV2s0cXNCQ0FPZ3htUjREWmFnVzlkVGV3dkNDb0lCOUk0MHRq?=
 =?utf-8?B?Uyt6NmNKMWZILzh5MFY0czRuSTQ2bkh3NDNWUmtXelV6aG1wNTNBWHZGVWdL?=
 =?utf-8?B?U1FGMnNIOGdEeC9LTC9WMUdYb2JWZnYvL3JRQW5BUlh3R2xRTUJDLzFOeEtJ?=
 =?utf-8?B?Y29CQ25jcTZLZXRwV0M0WWYzcVVqcFA0VVVsd2dNSUxUdDZzYTFuTzRROWti?=
 =?utf-8?B?ODcrbVJpV3c5U0toNmNJTXhnckRsN2lzTEh6d2x1b3prbFIvQ3laUSs2WXZh?=
 =?utf-8?B?OFVrSk9NK25vaHV1ZmtFSkxNeDdmN3JVTXJZV09ETWJmb1V2YnA2UFFKRTBG?=
 =?utf-8?B?TnkxeUNUYTBnbkw0NUsrdFk4bHRaZmJMSFJMZUpsVDF6SDBXNndqR25xYzJL?=
 =?utf-8?B?eFRNR1lTNzQ2eDFFMjdkVTM3MU5hVEZxSmhEWGxLMWkyTVhvSGdYb1JvVEMz?=
 =?utf-8?B?WG1zcGJEenhCejF3ZWdqbGFsSG05N01TbTJ4YVdNUGhkOTU3eWZUanp4VGxo?=
 =?utf-8?B?T1hJRGg0YmNHR0JaRFpPSko4V1FqNk16cTJHSUQ3dXprNVo5ZW11cEdBTHNP?=
 =?utf-8?B?MC9LaDBwVWRKV0lsc3g3elVCNXhZd1FBT0JveWl6ZEhQaGFrMGlZQVBRUFU0?=
 =?utf-8?B?Q2owYWlGVVZUckIxY2x2c1c5eWVRRmFqQU5UZi82Q045cTljTy9NZXQrbkJl?=
 =?utf-8?B?RmRSaE1SaHdHVDA5djA1NUlJRTM4ZUI1NjJaVEdzd0dQalM1bkdUM2E5K3Rk?=
 =?utf-8?B?MGpwM2p1eUd2cEZBTVdKQXhUS1M2WWZzMTZpZExZZTNkOXJEbFFwNStUT2Qy?=
 =?utf-8?B?RWVURThQNFRldVA5NmxQTmt1Y3dMU01LQXJXQ0FVS3ZnK1ZsKytIekxpY2JI?=
 =?utf-8?B?OFJMNnFpRjlISmRlcFlZam1UaTRRMS9ETzBhWlZ1MGFGR3kwTTM5eTZ3TXNu?=
 =?utf-8?B?TFd4NFFMUWxwWXlaUkxNSFYvR2xURDRLOHMzZ0t5OHMzN25qWW9FUkdtVngw?=
 =?utf-8?B?UHNHKzhZYWo2QkpHRFN2Y3hlWHV1WXF4elBsWENqWE5DN0pkNXo2ZTlyZ2dO?=
 =?utf-8?B?MEREVEhURTc3Z1JncXZ6QUtza2p2T2RlVElEYlJWdzdzMHJOejFCcTV5MVV5?=
 =?utf-8?B?QUltVVg5SURwQnhMNTY2WU42c2xhQnVQaXB3N2RzQlArTTVpM3FDSFVINDhQ?=
 =?utf-8?B?dlVSMDA2SlhOTXUvU2w5NlJhMU9EcURNcFo3NmhGeE10dFp0aWhGN3JqLzBD?=
 =?utf-8?B?Nk01dTNEWWg3WEEzM1Rpc1QvaUo0WWhVU0lXeFRVWTErNG84Y3ZtU1BWU2xs?=
 =?utf-8?B?NGlnS2ZjNkFDU043cWhVNEFYSjZoaDlYbWVSOS9RbVQ0RHZGOGZnYStxbm9E?=
 =?utf-8?B?dWw0MXhLbzdtWTNVQ2pNWjJoWXVkZEdmdXNxWkFNMFBaYTUxb0FCTHArbktR?=
 =?utf-8?B?ZHdTVndNRDdBbFBweWk2ODQxVU1yNG5DL25Bb3FtNkt0cGlIYzFzeTR6MktP?=
 =?utf-8?B?ZUJpSzhVZGNsNjBmWEcxdTB3V1NxQjRPNTU1ZHJaUHpISmhUcTcxc2xCLzVB?=
 =?utf-8?Q?dlByUSFliBTCpul/bp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c740a56-c2c7-4b98-f4ad-08de48522271
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 09:51:13.5031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4ZWT8xikO1GgpDTwZZSDZ9/AWem0/77ATRCAJzoUmMfwnGEjYRSsagvtN8RbdP5OSzcZdTDSoeFgJ4i0swBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8114
X-Mailman-Approved-At: Wed, 31 Dec 2025 14:17:47 +0100
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAzMCwgMjAy
NSA5OjM3IFBNDQo+IFRvOiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPjsgUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiBqaDgwLmNodW5nQHNhbXN1bmcuY29tOyB0cmluaUBr
b25zdWxrby5jb20NCj4gQ2M6IG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc7IGJoaW1l
c3dhcmFyYW8ubWF0c2FAZ21haWwuY29tOw0KPiB4eXByb24uZ2xwa0BnbXguZGU7IGthdXNjaGx1
c3NAZGlzcm9vdC5vcmc7IGFuZHJldy5nb29kYm9keUBsaW5hcm8ub3JnOw0KPiB0YW5tYXkua2F0
aHBhbGlhQGFsdGVyYS5jb207IFllIExpIDx5ZS5saUBueHAuY29tPjsgQm91Z2ggQ2hlbg0KPiA8
aGFpYm8uY2hlbkBueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gU3ViamVjdDogW0VY
VF0gUmU6IFtQQVRDSF0gbW1jOiBBZGQgcG93ZXIgc3RhYmlsaXphdGlvbiBkZWxheSBpbg0KPiBt
bWNfcG93ZXJfb24oKQ0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4g
UGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNo
bWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9y
dCB0aGlzDQo+IGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiAxMi8zMC8yNSAxMTozOSBBTSwg
emluaXUud2FuZ18xQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogTHVrZSBXYW5nIDx6aW5pdS53
YW5nXzFAbnhwLmNvbT4NCj4gPg0KPiA+IEFmdGVyIGVuYWJsaW5nIHZtbWMgc3VwcGx5LCBhZGQg
MTBtcyBkZWxheSB0byBhbGxvdyB2b2x0YWdlIHRvDQo+ID4gc3RhYmlsaXplIGJlZm9yZSBTRCBp
bml0aWFsaXphdGlvbiBzdGFydHMuIFdpdGhvdXQgdGhpcyBkZWxheSwNCj4gPiBzb21lIFNEIGNh
cmRzIGZhaWwgdG8gaW5pdGlhbGl6ZSBiZWNhdXNlIHRoZSBpbml0aWFsIGNsb2NrIGN5Y2xlcw0K
PiA+IGFyZSBzZW50IHdoaWxlIHBvd2VyIGlzIHN0aWxsIHJhbXBpbmcgdXAuDQo+IERldGFpbHMg
cGxlYXNlLiBXaGljaCBleGFjdCBjYXJkcyA/IFdpdGggd2hpY2ggY29udHJvbGxlci9Tb0MgPyBE
b2VzDQo+IHRoaXMgcHJvYmxlbSBoYXBwZW4gb24gYW5vdGhlciBTb0MvY29udHJvbGxlciA/DQoN
Ck1NQyBpbml0aWFsaXphdGlvbiBmYWlsZWQgb24gSU1YN1VMUC1FVksgd2l0aCB0aGUgU2FuRGlz
ayBVbHRyYQ0KNjRHQiBjYXJkIChDSUQ6IDAzNTM0NDUzNDQzNjM0NDc4NTU2OWE1YWI1MDE4NDAw
KS4gSG93ZXZlciwNClNhbkRpc2sgVWx0cmEgMzJHQiBhbmQgMTZHQiBjYXJkcyBkaWQgbm90IGVu
Y291bnRlciB0aGlzIGlzc3VlDQooYm90aCBoYXZlIENJRDogMDM1MzQ0NTM0MzMxMzY0NzgwYzg2
NzI2ZTEwMTI3MDApLg0KDQpUaGUgcm9vdCBjYXVzZSBvZiB0aGlzIGlzc3VlIGlzIHRoYXQgdGhp
cyBTRCBjYXJkIHJlcXVpcmVzIGF0DQpsZWFzdCA3NCBjbG9jayBjeWNsZXMgYWZ0ZXIgcG93ZXIt
dXAsIG90aGVyd2lzZSBDTUQ4IHdpbGwgbm90DQpyZWNlaXZlIGEgcmVzcG9uc2UuIEZvciBvdGhl
ciBTRCBjYXJkcyB0aGF0IGluaXRpYWxpemUgbm9ybWFsbHksDQp0aGUgaW5pdGlhbCBjbG9jayBj
eWNsZXMgYXJlIG5vdCBtYW5kYXRvcnkgLSB0aGV5IGNhbiBzdGlsbA0KaW5pdGlhbGl6ZSBzdWNj
ZXNzZnVsbHkgZXZlbiB3aXRob3V0IHRoZW0uDQoNCk9uIHRoZSBJTVg3VUxQLUVWSywgdGhlIFNE
IHBvd2VyLXVwIHRpbWUgdGFrZXMgYXBwcm94aW1hdGVseSAybXMNCnRvIHJlYWNoIFZERCBNSU4g
dm9sdGFnZS4gSG93ZXZlciwgdGhlIGN1cnJlbnQgY29kZSBkb2VzIG5vdCB3YWl0DQpmb3IgdGhl
IHZvbHRhZ2UgdG8gc3RhYmlsaXplIGJlZm9yZSBzZW5kaW5nIHRoZSBpbml0aWFsIGNsb2NrDQpj
eWNsZXMuIFRoaXMgcmVzdWx0cyBpbiB0aGUgVkREIHZvbHRhZ2UgYmVpbmcgb25seSBhcm91bmQg
MVYgd2hlbg0KdGhlIGluaXRpYWwgY2xvY2sgY3ljbGVzIGFyZSBzZW50LCBjYXVzaW5nIHRoZSBT
RCBjYXJkIHRvDQpjb21wbGV0ZWx5IG1pc3MgdGhlc2UgaW5pdGlhbCBjbG9jayBjeWNsZXMuDQoN
CldlIGNvdWxkIGFkZCByZWd1bGF0b3ItcmFtcC1kZWxheSBvciBzdGFydHVwLWRlbGF5LXVzIHZh
bHVlcyBpbg0KdGhlIGR0cyB2bW1jIHJlZ3VsYXRvciwgYnV0IEkgaGF2ZSBjaGVja2VkIHNvbWUg
ZHRzIGZpbGVzIGFuZA0KZm91bmQgdGhhdCBtYW55IG9mIHRoZW0gZG8gbm90IGNvbmZpZ3VyZSB0
aGVzZSB0d28gdmFsdWVzIC0gbm90DQpqdXN0IGZvciB0aGUgSU1YIHNlcmllcywgYnV0IGFjcm9z
cyBkaWZmZXJlbnQgcGxhdGZvcm1zLiBJZiB3ZQ0Kd2VyZSB0byBhZGQgdGhlbSBpbiBkdHMsIGl0
IHdvdWxkIHJlcXVpcmUgbW9kaWZ5aW5nIGEgdmVyeSBsYXJnZQ0KbnVtYmVyIG9mIGR0cyBmaWxl
cy4NCg0KQWx0ZXJuYXRpdmVseSwgd2UgY291bGQgZm9sbG93IHRoZSBhcHByb2FjaCBpbiB0aGUg
TGludXgga2VybmVsJ3MNCm1tY19wb3dlcl91cCgpIGZ1bmN0aW9uIGFuZCB3YWl0IDEwbXMgYWZ0
ZXIgcG93ZXIgb24uDQoNClRoaXMgY2FyZCBkb2VzIG5vdCBlbmNvdW50ZXIgaXNzdWVzIG9uIHRo
ZSBJTVg4TU0gcGxhdGZvcm0gYmVjYXVzZQ0KdGhlIElNWDhNTSdzIFNEIHBvd2VyIG9ubHkgbmVl
ZHMgYWJvdXQgMC41bXMgdG8gc3RhYmlsaXplLiBTZW5kaW5nDQoxbXMgb2YgaW5pdGlhbCBjbG9j
ayBjeWNsZXMgZW5zdXJlcyB0aGF0IHRoZSBTRCBjYXJkIGNhbiBzdGlsbA0KcmVjZWl2ZSBhdCBs
ZWFzdCA3NCBjbG9jayBjeWNsZXMgYWZ0ZXIgdGhlIHZvbHRhZ2UgaGFzIHN0YWJpbGl6ZWQuDQpF
dmVuIHRob3VnaCBubyBpc3N1ZSB3YXMgZW5jb3VudGVyZWQsIHNlbmRpbmcgaW5pdGlhbCBjbG9j
a3MgZHVyaW5nDQp0aGUgcG93ZXIgcmFtcC11cCBwaGFzZSBzdGlsbCBkb2VzIG5vdCBjb21wbHkg
d2l0aCB0aGUgZGVzY3JpcHRpb24NCmluIFNlY3Rpb24gNi40LjEgb2YgdGhlIFNEIFBoeXNpY2Fs
IExheWVyIFNwZWNpZmljYXRpb24gVmVyc2lvbg0KMy4wMC4NCg0KQWRkaXRpb25hbGx5LCBJIGJl
bGlldmUgdGhlIDEwMDB1cyBkZWxheSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZQ0KbW1jX2dvX2lk
bGUoKSBmdW5jdGlvbiBleGlzdHMgZm9yIGEgc2ltaWxhciByZWFzb24uIFdpdGhvdXQgdGhpcw0K
MTAwMHVzIGRlbGF5LCBDTUQwIHdvdWxkIGJlIHNlbnQgZXZlbiBiZWZvcmUgdGhlIHZvbHRhZ2Ug
cmVhY2hlcw0KVkREX01JTi4NCg0KVGhpcyBzaG91bGQgYmUgYSBjb21tb24gaXNzdWUsIG5vdCBs
aW1pdGVkIHRvIHRoZSBJTVggcGxhdGZvcm0uDQpXZSBjYW4gZWl0aGVyIGFkZCBhIGRlbGF5IGlu
IHRoZSBjb2RlIG9yIGFkZCByZWd1bGF0b3ItcmFtcC1kZWxheS8NCnN0YXJ0dXAtZGVsYXktdXMg
aW4gbnVtZXJvdXMgZHRzIGZpbGVzLg0KDQpSZWdhcmRzLA0KTHVrZQ0KDQo+IA0KPiBXaXRob3V0
IHVzZWZ1bCBkZXRhaWxzLCB0aGlzIGlzIGEgTkFLLg0K
