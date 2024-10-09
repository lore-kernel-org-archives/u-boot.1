Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958D2CED628
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DF789000;
	Wed,  9 Oct 2024 10:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Gz+CqG3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C98F88FE4; Wed,  9 Oct 2024 10:15:46 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D8389148
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3WcgbSCiu2HvshbSq1a0XYXw+SXG/NOCBKllJe2aqLwI5LL/yBiKNdroSHZvSAEwuHPnz2cwVEVHOn7GE9Br1lcQST3XcmpDVAn72327Dj5tEEn0Vp0/TX6R1MN/6sng0sM8pqYXvUkG37v4CZja5/yBGS7zcvc0JL9wKYVWSxqMF161swuhKQ0ZKMixCnefJjomJq8NdwO1juk7ZwZtingT8EHZTa8XbPp293Dq1sHcQ52YcHlOo4YIr5KRdqpfzOGxIOJYeHRXePCV07phcAN9v6qy06+oiunmBhWzhEKXECT4TQSVCMIagiX6QRLM1ZBDwHmze97xhcmkZbyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXUOI+yMxqmrETqowN1WpwzayRtPJQbwe5wu1PTTPr0=;
 b=p8ybVqCir1wel7iXYk+jSXrMJXpcSYD2ZpjYhP+qxy0QQU0Kxm7qKwohMrRZPRAhjzc6ey8e9cgDk8MdVfJc56Ah6A0nIPRDLGEN0IyEXooCR5zMzNi8hsUq4Otabq8lqFdoiQVM7deLfux3EgkNAyDDAOEUFXSFIQIT21cNqWk/dmSGK7gFq/1JeM6ZZf7imihePXXT8Mpy6QDIGRxVsFBJ/6CjjouIiRvMuACLkf8LzS74kTkiccS3zf/6uANnhy+A5g9X1udb5JG92AqcoMLtypFd3TgpfBJ4GDXlbmOMzqrpmhziTGA2zY/W0AyP5JoDXvFAZddq3F8an4PdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXUOI+yMxqmrETqowN1WpwzayRtPJQbwe5wu1PTTPr0=;
 b=Gz+CqG3M9Fd4S6S+yhMGLVVFQpT6D9VGw31r2CyrUQ/qZERwXD4UIj+xhOmS5lTNG7eSTlfk74bHwlNAe9B+i/xIM1rA2r44vto3gxaibUwbV/2ZaZzm3X08P/X8OkGcg2Hk/4jRXKB26UgLy9K7fiaAd9gQ6+7BeRuGTtwz+oZQi3h/TwXsdMaOExfzEV6UqgHYIyIoyXMn58kJoF/KVsNJm80adH/bnoUsTk83rVa+2qZVGC2vNNhd37EjfEVbRDpyas+RfrlZTBQO/bGJqsF66x8LV/wQYl10mRFBBWSrIs0wccYnMo0oKEwRX81k48/mGgQ/26tYgRVJGvsYLA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 08:15:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 08:15:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "judge.packham@gmail.com"
 <judge.packham@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, Ye Li <ye.li@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>
Subject: RE: [PATCH v1] arm: global_data: add scmi pointer
Thread-Topic: [PATCH v1] arm: global_data: add scmi pointer
Thread-Index: AQHbF9WVGGxvWv51PkuEG83h1EQ71bJ7hqeAgACigYCAAYRIgIAAaOKA
Date: Wed, 9 Oct 2024 08:15:41 +0000
Message-ID: <PAXPR04MB8459F5B6C4DF5992E8EBB2F0887F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241006095228.2800776-1-alice.guo@oss.nxp.com>
 <20241007170551.GB4737@bill-the-cat>
 <PAXPR04MB8459A692CF21AA616DCDA7BA887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAFLszTiAU2QR2nkuk+tX3XTCy1YU8V0V1tP2i8OHODs_HXx0BQ@mail.gmail.com>
In-Reply-To: <CAFLszTiAU2QR2nkuk+tX3XTCy1YU8V0V1tP2i8OHODs_HXx0BQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS4PR04MB9622:EE_
x-ms-office365-filtering-correlation-id: b836dfa9-60a1-4ba1-ef0e-08dce83a9100
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bkIyWHMrb25Rb0wrSTRWMHVxa1VZVXk3YTZEZ0FGcnoxaXg4L09pNm5Pc0FE?=
 =?utf-8?B?dXhYcGV4akd4N29wUTZvS0hqYlhHS0g5dWRKbFpzS25yVjNZc2YvUHkxblhB?=
 =?utf-8?B?N01WY082aE9xaHNab1pISkJmKzBEbmxVOHEwRHdTQjNUR3hmQnhFR08wZ1Zj?=
 =?utf-8?B?MW1wMWJtTjVNZ3hDY0NYU0wwNU1jY0RSQVZrbko3VUYrSzJvSWRzQXUrdlds?=
 =?utf-8?B?Q0R2NlB2VGZuY1NuNnY3T1Z6ckpIV0ZLZjA5SXZ3OFRNQ1A5OWNzQjEvRWFj?=
 =?utf-8?B?VGwxak4zTGZzMGR6WlM4M0V1bUxsRll2b3Iyb3hsejAwb0hxNEpwYjVaWVZh?=
 =?utf-8?B?bWp6eWt3UFJuR2Y4bHpQS3JmRDBrRXZaTDFUTS9sbStoZnZXUWpOSENFUTl3?=
 =?utf-8?B?c1pSWFh3aWl5QkZqMGhzNHVURWIyNGlUdUpXSGNrbXI5M0RHa1Z6UGIyanNp?=
 =?utf-8?B?cWc1amZ3bWZ1MDNHRGRMYjJ1cllJOSs0NWVvTlh4ZlZsTUh0TEppTWVYRmtS?=
 =?utf-8?B?dnBqb1h0dCtPME8vQVBPazJxU2RPaDE5RmM0Mkw2M05odWhwNHoycVRlT1J5?=
 =?utf-8?B?eUViNTNqS0RVT1ZKWm4rT0dJZFJoSGhUR1hIZEl1bktXUExmZWNTTjVOeHcr?=
 =?utf-8?B?NzErUkhXTHZseTNSc1laOE9ESHVjMnczZ3FZL3FJZHNXVm5KbkhQSTNPait6?=
 =?utf-8?B?SUVtcThrV2VybFl3WHlScHhqK2k0ZnhOR3pwQjljR0hvY3NjRG1FUkpBVHhz?=
 =?utf-8?B?MkxpR1AxSElWSmhNTEdwRnFZWlpITWtVaXNuR0JyVVV2M2t5Zmp6M1lWNzl3?=
 =?utf-8?B?R2E1TndPT2dqRS9pbGQzYTZWQUNoZ0xrbjdCTmYrT2lHSFFYQitNdzJBZGJ6?=
 =?utf-8?B?K24zRFZCS0tIZkRwT0p5UlRoMWU1V09TOU9wS0JSdnF2djF4clQxajk5V0FH?=
 =?utf-8?B?cWI4TFh6MHU0ZHdiQlNiZ0t2YjgzbkJ4dUpmdVZ1MDY4ZUNHVTFJL2paQ2NC?=
 =?utf-8?B?cEp1UlJJRmN3dXhmTXhJblFCS1JVdWhac2xHWi9sbVNVUXpjbWJQUnZPQitC?=
 =?utf-8?B?ZEp5WGFMR255YURBYjVFamxuMUFoOUtQUVRPSWpiU01xSnRTUFVkcUxrT2VJ?=
 =?utf-8?B?YnF6WklDbHNxcHYzTE5Rc2RBWU8wQjF5SnVDVnRZVHVOYXNOTlVFT1R2UWF2?=
 =?utf-8?B?Z1lNMFJIanlKNXhQOG9zaHV4SkNTOHMzU3htOE1tQUphRWgzamF5amliVnI2?=
 =?utf-8?B?YWZGSVVmLzVtM3F6MHJnc2pzVjI4L0xWdG45WnBnSDd3NngwR0ZlNnJ5dk9L?=
 =?utf-8?B?Wk15NmRzc2loYW85VUFjanJXSFYyNXcxRDlBWUZpV2pMQVE1OTNOeUkrWE1x?=
 =?utf-8?B?WEpxdFhUMUpFb2x4cWNPczMrcGRkL2JxZENBREcxclh6NDN3SU81MTgrbHJX?=
 =?utf-8?B?Vm1GdUZ5YlIwbUg5Q2Y1U3NSeGR1WTRxeVpmZVNWN2o0QTNGbTFDZlVhTS9q?=
 =?utf-8?B?NVNLbGdpMlY0RW42c2Q3RFIyZGhoUUo1RHFKS0RNUG55YTV4YnRZS1ljejJX?=
 =?utf-8?B?K3I0Z2IwU3lJbkFkV3dVdXRQc2c5TUM2TUN5SkZHWG1UN1B0elVZS0hvbVp2?=
 =?utf-8?B?V0JSOTZ3OW5BR3V0UjBxZ1h4aFJXeFBPT05rNTJmbHBkZUpjK3pHaHltZmVr?=
 =?utf-8?B?UkoraHhxcnhZa3Q5VGJHd3F3ZkxaY1JBQ0ZhUDAyamhYSXBnVTJnVVNvM05G?=
 =?utf-8?B?OUdkeGZKeENyZExoS1JaRHpFbC9UUWtlQ1pDWTVxSU1LVGo3aE9Ba0VtOGtM?=
 =?utf-8?B?a2t6emc2Uk9SZTV6WmJFQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTVpQWtGTThLeDZUT1Bsb2QyUWlOK29jcEpSWHlxK0lnQVh6ZVNzNXJzUXJB?=
 =?utf-8?B?cVdYbnpCOTNDOXJJMVF6Q2pOcFNYbVRPNDVmMWt1Z0J1Sy9xbDZOMUdoNVV4?=
 =?utf-8?B?NG56dXJLQjBPMUo0MWZnSThnOFROenk4NjRRRTFqVDNjWENtbmRuVDRyOE5K?=
 =?utf-8?B?RG4wQ3ZVbDh4ellEdnVBdDQ0blBXUEdlMHgwaFNxVDUrY0ZWQ252bDYwR2lY?=
 =?utf-8?B?ZlZENG84ZnBnQ2kxcnhuL1E3Z09iaVlLaUs2Tlh0Ykc3eHNzbXBvdldtY2lN?=
 =?utf-8?B?YnJXVkUvbjE1eGpkQzJtdldBdEM0VFhwcTF0dmg2cFcrY1FXdHhkaUNlV0k1?=
 =?utf-8?B?Vlk3SDFFOWlSVnZuemt2STJRUW12dnBXbUQ1QnNTWnUzWCtLVTQ2bFRiSG9m?=
 =?utf-8?B?ZWxkak5QUTFyTGhxNFVNMEJpVW50SWw4RThMOHp3RkZpTFIwbGU0VkdlSTF1?=
 =?utf-8?B?ZjhPbFRaVkFMTXluK0pYaWROeTlKVCs0djZaYmN5dmJPUmQvV0Nmc3V5RnBo?=
 =?utf-8?B?VWQxU1FITjZKYjczeUhhUlZxK081bmw4dWlmeXNEQUFBUXBKT0VIYXY3ZW5Y?=
 =?utf-8?B?VUNpSFVwYWhYSjhZeDJFVG54Y2hEQjdyaTYySWJMeUNtR1RvMnBnRjZTOU80?=
 =?utf-8?B?SHhrdEgxSTVRb1NKSUtXSCtpQjNsa05HSzFFV2w4R0trMUxCOWFpU3daenZ2?=
 =?utf-8?B?Vm9tSkJ5cHdieGg5MnZPTWplanR5VVVseWdNbnBLTG8xcDNiOFBZK2Q0L0JO?=
 =?utf-8?B?WVM1VUxHQlFVZEVmN3Q3cVBNWWE4d2hTbFBzdUU5a3dONXZmc21xTGZFc2xB?=
 =?utf-8?B?eVRDSE16d01hZFpCYUZnbUd2TlU3R2Q1ci9ZUllhb3Y0NU8vZmN5ekpiWDdy?=
 =?utf-8?B?Y0paVkN0eE1qOVIzMzN2Tm9oRDVIcHJGTFNCdEgxRWtEc2Fab08xVVlDemhD?=
 =?utf-8?B?d2k5WUljanBSMUcwU1FubXo2aVNaeCt0NHpmUVVsZmdRenZCamVBSUZSUG1l?=
 =?utf-8?B?dWVXVGY4a1RWZ0hqRno3SEY5RTQzbUpXSG1GempsR29XYmxEd25pRnJ0MGVF?=
 =?utf-8?B?Sjg1MFhRU05JaTFuaTFUNHJCelowWGxsOGVFVURaVzVCM2FyaHZlSWFhNno5?=
 =?utf-8?B?c0lvY3JwbEdzNmQ1R0J2WW5ROW9TTXJwTTJUcmtpamdCUTBHNXo2aUpTMXd5?=
 =?utf-8?B?aHhDTThQWXpodk04MksrN0d4bmdZYmdzUTVmUERyTDk2TlJSaWduMjlDbXhX?=
 =?utf-8?B?Tk5walVKKzJ5WmVYUTFRdzZ2WVpxVnFhRWlEUFV5TDZkQTdTVmFGcDlrck5l?=
 =?utf-8?B?YktSSEtzK1oyRURGLy9CbkVMTkFzWDB0a3ZubVBIeWMyd3ZicnVGWjdkelRx?=
 =?utf-8?B?TEkyRmUzS21QS1N5dmpLNlZtaWNIemIrYVZqeVU4a0gxSE9kMFFDTmE4MXBv?=
 =?utf-8?B?V29VY2tQMFZNemZ3L2g2eFBVaHhPNEtENkpaV2J1em9hVEhDbEY1MXVpM3g5?=
 =?utf-8?B?SkNiVGx1QWpvbEFwcHAwSCtFd0ZoOTkyaS9aVHBoQlNra05YMUkybzB6SS95?=
 =?utf-8?B?Ui94aVEyaWZISEJuei8yUWRoY3V3QjZRRWFsSTZpUXJjK2JZZ1VOSXo4RTR2?=
 =?utf-8?B?VUNIS25DbW5SNzQybGNVU1VqUUltQU5pZkJEZjFyY1d4U2lIZmNBcEhiMnJY?=
 =?utf-8?B?TmdteEcvd29ROS9iRzIvZW1FaTJneENXV0Y1VEozY2RQcTN6QkFORlk5VGdC?=
 =?utf-8?B?ZUdPV1kxSDc4MnQ2cWpIeTZaSi9aMUJPWlNJYTJzaStqZjJuNU1icVVCa2Vx?=
 =?utf-8?B?L3pYbFhFdmFKNCtsUEpTOEFrNzkrcWpMNjBLWDlIR0JIZW1tWUVMVVI4a21O?=
 =?utf-8?B?aEpXdU5zaDNiajVPMXorYXpNZWNGeHRBUnNQVXlicFZlYmZSZ0ZPQStocURz?=
 =?utf-8?B?Z200S2RETnhSWUtOYmsxWXg0ZnhWTTlaS2FHcG44djY0bHF2cTRxNU9BSWEz?=
 =?utf-8?B?ZTBkZGtlV3A0cUp1Y3pTbGFyaTZERXRZSnVqSlhueTdqVWEwMCtlcmc1QXk2?=
 =?utf-8?B?OTh6R08vRmZqQTg4cHlCMGFlS1NzVnJxdXVwU3Q4KzNXVE1QYkt3UlZwUnQ1?=
 =?utf-8?Q?EU2c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b836dfa9-60a1-4ba1-ef0e-08dce83a9100
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 08:15:41.7685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4N5hBm5yr2kqLNrTnucnPfRJHgXPPTpwVRRQ/dwMoHwP6Yu48mK8ZFjnVf5/fr5MfXmfnTcWyVEgExb2t4ZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622
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

SGkgU2ltb24sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gYXJtOiBnbG9iYWxfZGF0YTog
YWRkIHNjbWkgcG9pbnRlcg0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIE1vbiwgNyBPY3QgMjAy
NCBhdCAyMDo1OSwgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBhcm06IGdsb2JhbF9kYXRhOiBhZGQgc2NtaSBwb2lu
dGVyDQo+ID4gPg0KPiA+ID4gT24gU3VuLCBPY3QgMDYsIDIwMjQgYXQgMDU6NTI6MjhQTSArMDgw
MCwNCj4gYWxpY2UuZ3VvQG9zcy5ueHAuY29tDQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gRnJvbTog
UGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEFkZCBzY21pIGRl
dmljZSBhbmQgY2hhbm5lbCBwb2ludGVyIGZvciBpLk1YOS4NCj4gPiA+ID4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5
OiBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBhcmNoL2FybS9p
bmNsdWRlL2FzbS9nbG9iYWxfZGF0YS5oIHwgMyArKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2luY2x1ZGUvYXNtL2dsb2JhbF9kYXRhLmgNCj4gPiA+ID4gYi9hcmNoL2FybS9pbmNsdWRlL2Fz
bS9nbG9iYWxfZGF0YS5oDQo+ID4gPiA+IGluZGV4IDQ1NDAxZDVlM2MuLmQwNDM1OWYxNjcgMTAw
NjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2dsb2JhbF9kYXRhLmgNCj4g
PiA+ID4gKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vZ2xvYmFsX2RhdGEuaA0KPiA+ID4gPiBA
QCAtMTA4LDYgKzEwOCw5IEBAIHN0cnVjdCBhcmNoX2dsb2JhbF9kYXRhIHsgICNpZmRlZg0KPiA+
ID4gQ09ORklHX1NNQklPUw0KPiA+ID4gPiAgICAgdWxvbmcgc21iaW9zX3N0YXJ0OyAgICAgICAg
ICAgICAvKiBTdGFydCBhZGRyZXNzIG9mIFNNQklPUw0KPiA+ID4gdGFibGUgKi8NCj4gPiA+ID4g
ICNlbmRpZg0KPiA+ID4gPiArI2lmIGRlZmluZWQoQ09ORklHX1NDTUlfRklSTVdBUkUpICYmDQo+
IGRlZmluZWQoQ09ORklHX0lNWDkpDQo+ID4gPiA+ICsgICBzdHJ1Y3QgdWRldmljZSAqc2NtaV9k
ZXY7DQo+ID4gPiA+ICsjZW5kaWYNCj4gPiA+ID4gIH07DQo+ID4gPiA+DQo+ID4gPiA+ICAjaW5j
bHVkZSA8YXNtLWdlbmVyaWMvZ2xvYmFsX2RhdGEuaD4NCj4gPiA+DQo+ID4gPiBCdXQgd2h5IGlz
IHRoaXMgb25seSBuZWVkZWQgZm9yIGkuTVg5IGZhbWlsaWVzIGFuZCBub3Qgb3RoZXIgdXNlcnM/
DQo+ID4NCj4gPiBpLk1YOTUgaGFzIHNvbWUgY29kZSB0aGF0IGNvbW11bmljYXRlcyB3aXRoIFND
TUkgcGxhdGZvcm0sIGJ1dA0KPiBubyBzY21pDQo+ID4gZHJpdmVyIGZvciB0aG9zZSBjb2RlLCBz
YXlpbmcgcm9tIHBhc3MgaW5mby4gU28gd2UgbmVlZCBhIGdsb2JhbA0KPiA+IHNjbWlfZGV2Lg0K
PiANCj4gV291bGQgaXQgYmUgT0sgdG8gZmluZCB0aGUgZGV2aWNlIHVzaW5nDQo+IHVjbGFzc19m
aXJzdF9kZXZpY2UoVUNMQVNTX1NNQ0kpID8NCj4gDQo+IGkuZS4gY2FuIHdlIGRvIHdpdGhvdXQg
YSBwb2ludGVyIGluIGdsb2JhbF9kYXRhID8NCg0KSXQgc2hvdWxkIGJlIGRvYWJsZSB0byBkcm9w
IHRoZSBwb2ludGVyLiBXZSB3aWxsIGdpdmUgYSBsb29rIHRvDQp1c2UgdGhlIG90aGVyIGFwcHJv
YWNoLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBJZiB3ZSBkbyBuZWVkIGl0LCBJIHRoaW5r
IGl0IGlzIGJldHRlciB0byBoYXZlIHRoZSBjb25kaXRpb24ganVzdCBiZQ0KPiBTQ01JX0ZJUk1X
QVJFIChhbmQgbGl2ZSB3aXRoIHRoZSBleHRyYSA4IGJ5dGVzIGluIGdsb2JhbF9kYXRhKS4gV2UN
Cj4gcmVhbGx5IHNob3VsZCBub3QgaGF2ZSBTb0Mtc3BlY2lmaWMgb3B0aW9ucyBpbiBnbG9iYWxf
ZGF0YSwgb3IgZXZlbg0KPiBkcml2ZXJzIGZvciB0aGF0IG1hdHRlci4NCj4gDQo+IFJlZ2FyZHMs
DQo+IFNpbW9uDQo+IGUNCg==
