Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D20CC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACB2806FB;
	Fri, 17 Jan 2025 02:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S5z4stlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166A88073D; Fri, 17 Jan 2025 02:57:45 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE88980717
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htNNcI3L3f5Pprk9y61Nih7iuf+zrcAhtBJ3iNRdJKdrUBXdhEZRAmcpaf94CMk7PjwsiQXKLNEHfw+ZKnVjU1SlTcMm+rVlrOsiTP2YA837SrJ38uta5n7viJkwJnaCQITvmnrurmIaarhKUkkr6sKoYA9hu1LF/5W5hy+N5X6j642JvpF0xPR1xvCtwFNaX0q4wyFuYO5B0wZyCR/2HDdaDhg0RwEQFGSXDxv8QUcnHFlZxh6A/lnxTpzVbTaOTgMnymctLXEdk8onMcbKLh+SuSk+xNj8yALhqGEdEO1AapZXWO5sMye4gVtUtTl6eWXQrHeX/IkWorulbRIv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kn62XnXeysOt0xWitJ57j/1bV884kbpzGELRaQTdHo=;
 b=QAU5Ae/X3U3Q8lubKXdYEDSBg8d22fjLL+4h1xpKtmrEYrTkzf3BIeQzrfMzvQkUUCa88MvHAv1zY+LU1iz4Qataxwext6waDdd9Yes7w83ECb6vSuJderaIDAJiSXGD4aCbZ84r2lrCxSUZb0W0P74kWBFBfnghQ5IcjM8a2JvENO6jFl6i77WA5yBHJszNj7dnTp7pkaqt+RcbB2whuunqRqpCkPxljOzyCba8eanUAjxH+gYsx+NVTzgZ60An/jQYK8UhiUkBsgHyso3FnVvIuUpZ2WISJsjnUMOsPLdVvOWt9+nIwqIcRR6/KtOtwImEj8rxE52tz+c1zt1cqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kn62XnXeysOt0xWitJ57j/1bV884kbpzGELRaQTdHo=;
 b=S5z4stlWW7aSMznKMWoyxO2eHR6zfwxgBFKi1gqeAPcX0CX8zFC8k2IS9rp9Uho5O1En/C2j5eLC6KG7sBG/waa1Pp5MlahKvZCtlShpLOJpma7fL9YRySt7O5CKclxfeclpSUX2td0N4siJFV+noEEuxHDoPSEjystA9Vz4W8syZjl0UykLoVWAHf9R42MUZrDwquBjmW7kQpOgyzqYuGPos8HujqyGjTf48PdPkgBicBz+S5yJfu1dSIKswUz2yrKwdtGfa9SKptoItLaYVJ2wzfYE7pxg1fMiD8bGzvwDmBjMVV7oJb7xY9WeChbT+Kaejz13ppTBwQAb5r8H8Q==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 01:57:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 01:57:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "marex@denx.de" <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHY0IDIwLzIwXSBpbXg5NV9ldms6?=
 =?utf-8?Q?_add_i.MX95_19x19_EVK_board_basic_support?=
Thread-Topic: [EXT] Re: [PATCH v4 20/20] imx95_evk: add i.MX95 19x19 EVK board
 basic support
Thread-Index: AQHbZ1Gk3MhViiE1w0qW3OHXLl2Jf7MaAr9rgAA0biA=
Date: Fri, 17 Jan 2025 01:57:35 +0000
Message-ID: <PAXPR04MB9644E3472995F6C977C9BCDBE21B2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
 <CAJ+vNU0_GWaVtwiWw3Mt1J6jc57XgDWOehdzrPhfTAg+gJq4oA@mail.gmail.com>
 <CAJ+vNU2QytTfGuHcnY8QfoLBvxCxcMP4fKqvPYaM8w_rX-czkA@mail.gmail.com>
 <CAJ+vNU1tUEvcFQdcEsdmuTiNe=J3=C1pqum=qvmKnstNz7Ci6g@mail.gmail.com>
In-Reply-To: <CAJ+vNU1tUEvcFQdcEsdmuTiNe=J3=C1pqum=qvmKnstNz7Ci6g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8211:EE_
x-ms-office365-filtering-correlation-id: 2c8655a4-d284-40eb-a6a0-08dd369a4ff2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SElrOWNIZmM0amZwcDBGanFnNDV0RlhXRUhJSTJoZVUrVFVpaTBRYUw2ZGIv?=
 =?utf-8?B?TldKTklpUTR6d2FCVU5BTjRsQk1uOTU0am1tTDRoZkpsRm9IRVh2ZE1MZm1z?=
 =?utf-8?B?VGNFOCtTcFBWRVE4aldPRllGTGozRCt5cEVIZ2M5ZFlUQ082MERLbjJXQnRa?=
 =?utf-8?B?TjJJWElLK2RQR05nVUVVM1lqVjJsRUNnV0VSemNlNXVFQ3NwMmlIYUVrUDFx?=
 =?utf-8?B?bWxmakVNYUlVRUpmeTVza3I4RUs3cHZxc0haZ1F3VkYvTUNpclVPcDYxclMy?=
 =?utf-8?B?RzJkSHZlWk5jdGlVZU91K3VHOU9QcjM0TGNjckcveStQeUlpYm5IditMRVp4?=
 =?utf-8?B?SHB0cThyeW5OMnZNSUJqbENpbVlPOUl3NFJBTWtoWFNqdXE0YkRaU2tUaWgw?=
 =?utf-8?B?dlBJM1VtWXNzNytTN0UwZ2RYbHhMN1RicWU5cnpNUDBZTWdBY1RmZXpLRkdD?=
 =?utf-8?B?UUYwR05qS1FrRmdxYmVUN2NPSzQwTktuR2pVTENPNU9qU2hXNDdqL2VjRXBX?=
 =?utf-8?B?Sy9RWDl5RFdyZGNPbW4vcDh3Qkd3RXZROE90bFVKaldFc3Q3QVlHb0JFVHhX?=
 =?utf-8?B?dzJQVXY3RDhWNVBkRXBGc202d2ttYldjYkRHUnUvMmN1cHNvV20xSVJieGZ1?=
 =?utf-8?B?SSttTGJCQUt5ZXdSQ2hFZUhSTDcyMmpWSEh3MTY2Si9nSGVNTFg0WHNpQnY4?=
 =?utf-8?B?RkpDcjNOaHdFYU5FcXJGS0hqY3pqYTN5WEZvVy9XTzJPalFHK044d25kbm9s?=
 =?utf-8?B?RUs2Nk0vUjN1cDZidGNjTEdITmVhQmNzTUZoMDJPSS83ckxmY2QwL3NKamlq?=
 =?utf-8?B?WnUxRGdObWhZZW1pKzV0NjlNNkV6SVJYWkRHZUZsQXZDNDhSaVpFVFl1SVBI?=
 =?utf-8?B?cTkwNE00YUw3R1JmS0VRWGZ2R1loeDJzNjJ5cFFudXVxY3FieTh2TWxsbnk3?=
 =?utf-8?B?NGp5MjRTVFN1SHN3eXdNRVprNjJsN0g0VjhiSDdXOE1IQStyYlduN3JyY0gw?=
 =?utf-8?B?S09uSDR3Qy9yZmtTOW9KdGw0Nm1PbjRWVW5ySnUyNkdrdy9mdGVCVEVVdmJa?=
 =?utf-8?B?aC8wNUliVWZLUjkrbVhYRHBtVWgyTWViU0Z4dy8xNjJuRlZKbHZMdHZxejdZ?=
 =?utf-8?B?ZlNib3BaVmR2K3JYMGdIMldiVVZSYjdKK2lESVpoaENBbk1HZEhqczByRG1q?=
 =?utf-8?B?ay95V3p6UUR4Vmc5ODRjUW05YkhpTWZsaTlIRzJHKzVtMVhubFQySWNOMGcr?=
 =?utf-8?B?a3dvV0p5aEozMk1lTkRuaHJwRmFYL3BQbUgvbGhmQXMwZTJIZXVZSHhjSlE5?=
 =?utf-8?B?cVpHRjIvS3B0a3U3UVBSODFkUzdwQ2JSQVR4UEpmVUN3Q0tWTE9LVS90OTRj?=
 =?utf-8?B?aEdTMG5uVFVSeko4LzZJdDhmSHdrMGk3ckhnMzd2am1HZXFETmM4QVlBMWt5?=
 =?utf-8?B?SktlUE1OdWNHMkcyOUtUSjVCeks1NmNPdFFCaGtVRVViNWt4TzdPUDBCVEtV?=
 =?utf-8?B?TEFZVzJRd0ZaRXhKeFVYay9WTHp5VERBeVFzYzA2YTh4UU00dmNSLzRrZVBk?=
 =?utf-8?B?cURYVDV4d1h3WGcrS3lZbzE3Z3AyQU9uNG8rTzViSkUvVFAyN3RqYk9ZbitY?=
 =?utf-8?B?SG15S09LbU05S1B4UVc2THp2RlBxRDZJaFRrREtFS2F5UGs2R3YyMVVJc0Qr?=
 =?utf-8?B?ZWhYdGxTL1YxcU9LTkxUOW1TeFd4eTUwUHRkb09VaG1uWXVxZU9qK0pzaFZF?=
 =?utf-8?B?OWNnNy9ycDQ3VTRja010SG9lMVdwTm5SYjVTMzF4OXRQemxUU2t3TzdBanBy?=
 =?utf-8?B?d2dORll3Q2hKck5TWlZoSmYwaDVaNGV3aUJUSFNVRkxWNXZuMHd3VlJUZ2to?=
 =?utf-8?B?OC9vZkowemdHbGRvYllnV3RyV0NSRi9Ec3FZVXRUQWE3SmFFQlc0dk5xL1c4?=
 =?utf-8?Q?fb4yRiiOzryhk2plXGFHvWCODqYCqgIJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXA3VFE2YlNZUmw1OEdVTEI2Z0pTN1dscWNHTzlsRm1ORDRCY08zd01kVUc1?=
 =?utf-8?B?ODJXNlJLQ2Q1cmVyTlVVUitnaXh6eGltTDl5Mk94eHpjRk1iREYrL0lJaDBH?=
 =?utf-8?B?MVdKQjk1VDBkUitkdG4zTVJQYXJiaUFmYmlvSm55ZFN5S2wrTWYwRUZxY2Y4?=
 =?utf-8?B?TFh3TzVLSzJWeDZjM2VCRnQyQ01wcG5EajB3MjJ3QjdSNjJkTE1zQlFDNnRm?=
 =?utf-8?B?Wmt5bnhyeC9aSlliUkNpTTZURHBsaGNNYXp4WUdWblNSdUoyNEZOaTBTbklm?=
 =?utf-8?B?WnBrSk1PY1ZLZ2xxazB0T3daK1pIemhYdjFiLzJ1Mm5McTBkSFR5eXN1cHpD?=
 =?utf-8?B?R2R5VU1ObXhZYUd6ZGNpMXdRb0h3dGI4QTRwY251WVF2dXhCMHJTNzM5Q0Nk?=
 =?utf-8?B?WE9NSEh0N1QrcU5tdVN2TkpxNHByNVEwVDIrb0crUzg5Q3JObHRtMHZ0b2lL?=
 =?utf-8?B?c0MwMlZXdXR4ZVZSSE4yTVg5UkpwVHZKY29peVc2M0cyVHFpVlBOVVc2ZEVQ?=
 =?utf-8?B?bjdDNFJmWlI4b2FLUnBQdGFYNFkwRTdIRjlISGhWdmlBVTZ1OHVWTGtPNHdk?=
 =?utf-8?B?czUrbHpoTW5UWHBYSlM1bkRMMWFBSEtMay83S3VIQXlEUFRibHlOSXhEWlEr?=
 =?utf-8?B?ajlIWUZvUllKdHQ5UTh0dFd0b2o4dHhMVkszZ2c5dkdhSGp1WGoxZDVSS3kr?=
 =?utf-8?B?K2dyK2ZrRXFVMkQwZkpwM051RlVQQmRQalROWlNmai9uay90cTZ1b25wVEdE?=
 =?utf-8?B?RWNaZzZwb3BhanZQZHRZL213N3dRQk9RMGIyUUtpS21iazAycWlOOGlXNllR?=
 =?utf-8?B?WUM1Z0hwZVhBSUZHc1NvZGF2dlAvM0RZYzFKUzZyb3l2djk5N3M5V2ZXWVZn?=
 =?utf-8?B?Nm13dkZFdWRCajVqRHZGUVBYdXVlNFB4K3d1Y0crRnd3K0xvQzQrVnJzWEd2?=
 =?utf-8?B?MVArV2ZHWXFVYzRFVk0yUHB0RnE0dHd3TzhzV0VTOXJjbktLVFRDTlcxYktn?=
 =?utf-8?B?NktDV0c1MnA1bUF5NjlhbTU1cDlSUUF1UFltUWN0VGNiR0Q0WmRiVkswdTFO?=
 =?utf-8?B?Mk9RTEVweTJKaW44MDdlL2lGYzQ2b0FQdmxzcUJLMkpycURwTzE1WU5JOUtH?=
 =?utf-8?B?Q1Y0SmM1a0x2d0U4L1p3UzU0cFFzYkFKVHFLYzRBRkNqcURRYVAyWUh3YkV0?=
 =?utf-8?B?Q0VvbDQ5MzlvMXI4NzdDdUU3dE1oSDhrZzBjKzJCT05zS3VNa00wM2Q4STdq?=
 =?utf-8?B?YmdnY0ZYQkpIc3lpNnRya1BCS3QzKzh4M1RrSnFQZmZ2cnpjQWpmQVVYYys0?=
 =?utf-8?B?NTZaeGsxOHRYSXF3S3kxMld5VEFiMmNCYlVlVVBDM0xiOGVpSk9JVVJBMTR5?=
 =?utf-8?B?am1Hd0pwYTJXS0VVNWl0WEtqQ2RRR1Q2Y2JuRlAzUmh4NW5BQUh3RGNWcWh1?=
 =?utf-8?B?dUc3T2tvc1RUME1ZR3NxeUdhZWhydzUrVzBwaFlyc01vb2orMVJ2LzhMV1lL?=
 =?utf-8?B?OXVhZ2JTUUpESkFWaWUySExPbW00UnoyUmVJRTkxSjZZY3ZYVXZzK3Fpbzlt?=
 =?utf-8?B?REE1N0gzUzBBWlRTQW04NVdxYldrNTZnc25PQkwzWjBBVjB4YWVtWVVKbW9T?=
 =?utf-8?B?Rk5mQklHQUh6Wnh3U2pLcXRtUFYvaFJZTGVjQTk0cTN3RklCam9nYWM4SnZo?=
 =?utf-8?B?aFJ3VERyeWJkWnROODN5eHV5Qk91ckRkNHFmcC90T0lnNGh0c2tOZWo4VXZu?=
 =?utf-8?B?eXliQ2szNjlQYTdYN0xOeU9CZjJoOERrZkg4UFh2Sm1JZDl3UkRna1JQTEov?=
 =?utf-8?B?dWFmdExKWE4wSVBxdkY2UEJqTGtZdGpFUFBaVGpFQi9qMkF6ZU1YRVJqL3Vy?=
 =?utf-8?B?aVROM1ZrNTBaMGFaSDlzSGxIK21lVmVyN04yY1ZqNHl6RVJvRS9yL2xESC84?=
 =?utf-8?B?RkRyKy8xdW1jTjN1aFR1N0ZySisxOWw4M2F5TW5OZ1FOVVN3MGRESEpQSmxT?=
 =?utf-8?B?VElCSVp3S3VhT012Z1UycVBkQ296ckNEOTVIWks3dWZmMmVaQ3M3TEpza0Rn?=
 =?utf-8?B?cjVhOVNWVmR3SGRIQlVwNFFEWVNQakNUM2xjcHR0cDZVMWsxa256TzhlN2tO?=
 =?utf-8?Q?ymt8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8655a4-d284-40eb-a6a0-08dd369a4ff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 01:57:35.0513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qg1X94wSY6hafY32XLxklQgh7cXX467ikS7rHtc+vqKl58wRTbCuP2xpSKxk2hplLYPVcyaoVx4VUSSUt+bRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8211
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
eUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQx5pyIMTfml6UgNjo0OA0K
PiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiDm
ioTpgIE6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFi
aWNAZGVueC5kZT47IEZhYmlvDQo+IEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVi
b290LWlteCA8dWJvb3QtaW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRl
bnguZGU+OyBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNz
IDxzamdAY2hyb21pdW0ub3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21h
aWwuY29tPjsNCj4gbWFyZXhAZGVueC5kZTsgdS1ib290QGxpc3RzLmRlbnguZGU7IEFsaWNlIEd1
byA8YWxpY2UuZ3VvQG54cC5jb20+OyBZZSBMaQ0KPiA8eWUubGlAbnhwLmNvbT47IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiDkuLvpopg6IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMjAvMjBd
IGlteDk1X2V2azogYWRkIGkuTVg5NSAxOXgxOSBFVksgYm9hcmQgYmFzaWMNCj4gc3VwcG9ydA0K
PiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2Fy
ZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4g
ZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzDQo+IGVtYWls
JyBidXR0b24NCj4gDQo+IA0KPiBPbiBUaHUsIEphbiAxNiwgMjAyNSBhdCAxMTo0MuKAr0FNIFRp
bSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBU
aHUsIEphbiAxNiwgMjAyNSBhdCAxMTozOOKAr0FNIFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdv
cmtzLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gV2VkLCBKYW4gMTUsIDIwMjUgYXQg
NTozMOKAr0FNIEFsaWNlIEd1byA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4g
PiA+ID4NCj4gPiA+ID4gRnJvbTogWWUgTGkgPHllLmxpQG54cC5jb20+DQo+ID4gPiA+DQo+ID4g
PiA+IFRoaXMgcGF0Y2ggYWRkcyBpLk1YOTUgMTl4MTkgRVZLIGJvYXJkIGJhc2ljIHN1cHBvcnQu
DQo+ID4gPiA+DQo+ID4gPiA+IE1lc3NhZ2luZyB1bml0IGZvciBFZGdlTG9jayBTZWN1cmUgRW5j
bGF2ZSwgbWVzc2FnaW5nIHVuaXQgZm9yDQo+ID4gPiA+IFN5c3RlbSBNYW5hZ2VyLCB1U0RIQyBm
b3IgU0QgQ2FyZCwgZ3BpbywgbHB1YXJ0IGFyZSBzdXBwb3J0ZWQgbm93Lg0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQt
Ynk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+IDxzbmlw
Li4uPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvZnJlZXNjYWxlL2lteDk1X2V2ay9pbXg5
NV9ldmsuYw0KPiA+ID4gPiBiL2JvYXJkL2ZyZWVzY2FsZS9pbXg5NV9ldmsvaW14OTVfZXZrLmMN
Cj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5kZXgNCj4gPiA+ID4NCj4g
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMC4uMWVkMTVjYTQ3YjE1NzA2
N2E3Mzc2YjANCj4gYg0KPiA+ID4gPiAzMjEwMWRjN2Y5ODk5ZjRmDQo+ID4gPiA+IC0tLSAvZGV2
L251bGwNCj4gPiA+ID4gKysrIGIvYm9hcmQvZnJlZXNjYWxlL2lteDk1X2V2ay9pbXg5NV9ldmsu
Yw0KPiA+ID4gPiBAQCAtMCwwICsxLDU0IEBADQo+ID4gPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMCsNCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBDb3B5cmlnaHQgMjAy
NSBOWFANCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArDQo+ID4gPiA+ICsjaW5jbHVkZSA8ZW52Lmg+
DQo+ID4gPiA+ICsjaW5jbHVkZSA8aW5pdC5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGFzbS9nbG9i
YWxfZGF0YS5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGFzbS9hcmNoLWlteDkvY2NtX3JlZ3MuaD4g
I2luY2x1ZGUgPGFzbS9hcmNoL2Nsb2NrLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8ZmR0X3N1cHBv
cnQuaD4gI2luY2x1ZGUgPGFzbS9pby5oPiAjaW5jbHVkZQ0KPiA+ID4gPiArPGxpbnV4L2JpdGZp
ZWxkLmg+ICNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4gI2luY2x1ZGUNCj4gPiA+ID4gKzxsaW51
eC9kZWxheS5oPiAjaW5jbHVkZSA8bWlpcGh5Lmg+ICNpbmNsdWRlIDxuZXRkZXYuaD4gI2luY2x1
ZGUNCj4gPiA+ID4gKzxhc20vZ3Bpby5oPiAjaW5jbHVkZSA8YXNtL21hY2gtaW14L3N5c19wcm90
by5oPiAjaW5jbHVkZQ0KPiA+ID4gPiArPHNjbWlfYWdlbnQuaD4gI2luY2x1ZGUgPHNjbWlfcHJv
dG9jb2xzLmg+ICNpbmNsdWRlDQo+ID4gPiA+ICsiLi4vLi4vLi4vZHRzL3Vwc3RyZWFtL3NyYy9h
cm02NC9mcmVlc2NhbGUvaW14OTUtY2xvY2suaCINCj4gPiA+ID4gKyNpbmNsdWRlICIuLi8uLi8u
Li9kdHMvdXBzdHJlYW0vc3JjL2FybTY0L2ZyZWVzY2FsZS9pbXg5NS1wb3dlci5oIg0KPiA+ID4N
Cj4gPiA+IEhpIEFsaWNlLA0KPiA+ID4NCj4gPiA+IE1vc3Qgb2YgdGhlIGFib3ZlIGFyZSBub3Qg
bmVlZGVkIChhbmQgc2hvdWxkIGJlIGFscGhhYmV0aXplZCBhbnl3YXkpDQo+ID4gPg0KPiA+ID4g
VGhlIG9ubHkgb25lcyBuZWVkZWQgYXJlOg0KPiA+ID4gI2luY2x1ZGUgPGFzbS9hcmNoL2Nsb2Nr
Lmg+DQo+ID4gPiAjaW5jbHVkZSA8YXNtL2dwaW8uaD4NCj4gPiA+ICNpbmNsdWRlIDxhc20vbWFj
aC1pbXgvc3lzX3Byb3RvLmg+DQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICtERUNMQVJFX0dM
T0JBTF9EQVRBX1BUUjsNCj4gPiA+DQo+ID4gPiBub3QgbmVlZGVkIGFzIHlvdSBkb24ndCB1c2Ug
Z2QNCj4gPiA+DQo+ID4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gPg0KPiA+ID4gVGltDQo+ID4NCj4g
PiBIaSBBbGljLA0KPiA+DQo+ID4gT25lIG1vcmUgdGhpbmcgdG8gZG8gZm9yIG5leHQgc2VyaWVz
LiBSZWZyZXNoIHlvdXINCj4gPiBpbXg5NV8xOXgxOV9ldmtfZGVmY29uZmlnIGFzIGl0cyB2ZXJ5
IG91dCBvZiBzeW5jOg0KPiA+DQo+ID4gbWFrZSBpbXg5NV8xOXgxOV9ldmtfZGVmY29uZmlnDQo+
ID4gbWFrZSBzYXZlZGVmY29uZmlnDQo+ID4gY3AgZGVmY29uZmlnIGNvbmZpZ3MvaW14OTVfMTl4
MTlfZXZrX2RlZmNvbmZpZw0KPiA+DQo+IA0KPiBIaSBBbGljZSwNCj4gDQo+IEknbSBhbHNvIHNl
ZWluZyB0aGUgZm9sbG93aW5nIGZpbGVzIGxlZnQgYXJvdW5kIGFmdGVyIGEgYnVpbGQgdGhhdCBh
cmUgYWxzbyBub3QNCj4gcmVtb3ZlZCBhZnRlciBhIGNsZWFuL2Rpc3RjbGVhbjoNCj4gICAgICAg
ICBta2ltYWdlLW91dC5pbXgtYm9vdC5zcGwNCj4gICAgICAgICBta2ltYWdlLW91dC5pbXgtYm9v
dC51LWJvb3QNCj4gICAgICAgICBta2ltYWdlLmlteC1ib290LnNwbA0KPiAgICAgICAgIG1raW1h
Z2UuaW14LWJvb3QudS1ib290DQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IA0KPiBUaW0NCg0KV2ls
bCBpbXByb3ZlIHRoZXNlIGluIHY1Lg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg0KDQo=
