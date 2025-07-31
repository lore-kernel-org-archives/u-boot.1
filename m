Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39252C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB45883623;
	Thu, 31 Jul 2025 11:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LDA2bFzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4750836C1; Thu, 31 Jul 2025 11:32:07 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70847835D8
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNhcihiEKFaSZCHRcfp/DN9ssqfQ0tn74iSq+YVIiBFaUxfJz2i+5tNLUJraFRQ+ae2kWmLmQ+AZKhKSbGMT4DdcYE3x51sAPsyAMFbOX3jVgtvAZ1MsLL2dcpeKcsSVaCmV9OxT7kOmxDw4zEfyhwEjRckJPVHpEaEzQMXKd5ZWlNEZg7dc2IhzlSjBadnKMb58yxc3FI3vmx81FSHAtdn53bSbnT0SB14BrG9CsXkP8mLoa9yWDfSeeg6RP7CRpxy0lrpXpzWGYGPR2ryqeYYzftLuMb7jnQYl4olgHCd6ROxWk+N4ZOmPX2vS4QXVrtV1Psp29g0wISQa6h3OmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl06Q+BAQqC3CISmtxX3vdalBIeNiMETYPbU1bCX0S0=;
 b=vyRMWwPUdETp9ArI29ALvqUWs8tjQfHCZRIOxbqgYGLIXDe5XP3Vi58EJ7EbzbnnLVyV7Kn+zRjR5xyneors93BBhXtsLlKqspRToyXj6c93Phpi/wDIY9mTyaz8t5NCElYL8q8okSZlwyeNpJFO/+pTH5kUGK6bXyte9g65qPgJtem3vKgVvW5heIg9P5wY4nBogWBi+JCyud1j/R3W3aLJL30UUWruG9W1gH6wXS4U8/1+nYbfAH8eB1Xbbng/RW6+/ZbiMFEsK8WTcUQTqqxfQMvfqZyiT7ghKAgekIiTMZcA4vNcj9/wbj8F/viBr24E2rlQxq8QWIOK//Dsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl06Q+BAQqC3CISmtxX3vdalBIeNiMETYPbU1bCX0S0=;
 b=LDA2bFzN8ObLW9vn0zTr4cX7UfKEJuDf9H06Jqd5MRImXdGS8dO91TC76pHH/DnUG78PGZmPGrLfNABQkpd+bQcx6765lhG9vecLIao+KLeb3ptXTA5ggCQcxvdxbWUdnIwkkLMVMQ3S4UQpJXALxC/DOVTeBjwkj3w4tZXo+/xK/tIlTuHWuF95b9Jvq5N70ivrjS6V/ivEwpjm4yJnjNcQht6Wk1IXyOBQzQCeRC2hU2/FyH96U+zIkYDI2G/yvv6JjRpYyHpe9Pwe+uDHBsVYpyUAOtSyqWDBfBL/vW2urRyDBkxLKJw4ikKrGw05Wr8fJC4WVdhrKaUA57xmbg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 09:32:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 09:32:02 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC80XSBpbXg6IGFkZCBpLk1YOTUgYjAgc3Vw?=
 =?utf-8?Q?port?=
Thread-Topic: [PATCH v2 0/4] imx: add i.MX95 b0 support
Thread-Index: AQHb9VNopRnJWXkO/EGKWMdbKsFiUbRH6K6AgACLm4CAAOV9AIACqUKg
Date: Thu, 31 Jul 2025 09:32:02 +0000
Message-ID: <PAXPR04MB9644E7123DD43D118AF21CA9E227A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU1asw79GMnsTxNevg+xRo-1SQ9j_f+4e-TEy4TPZ+Qt+Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU1asw79GMnsTxNevg+xRo-1SQ9j_f+4e-TEy4TPZ+Qt+Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8113:EE_
x-ms-office365-filtering-correlation-id: 49f7ef7b-9c74-4f09-6440-08ddd0151b03
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MTRaUkVaWThodkRWZ3lnWEd1aHQxR1lNQU14RC9SaU1VTC9ELzZYMUNJZ3pY?=
 =?utf-8?B?LzNOaFF0RTVVTGQ5VDJPOW9HcnZJY3hVRWM0TUlhZm0rTThrOHliYkFkQ1BS?=
 =?utf-8?B?eXp1MXFLV1Y2RjBHb1lUT01NTWs3S0RFTVpBZEx6SVhmT2xRdGFTTGROZXRI?=
 =?utf-8?B?bzZOSksrUDJvb0FVeC9MR2RxZFIzUXJZL0RLa00wWTZrU0FFYXVtd3ROclBP?=
 =?utf-8?B?K05UenV3V3dKZ1JMZjNEa01pVDlPcUJoSzQ5YjBSZUhBRUw2Q1U0YWxPbkg2?=
 =?utf-8?B?VWVVMkNLR3kzQVRibUJ0bkcrR1Y4ckJsc2lqaWxqK0psazEvQUd2RzgvcWZm?=
 =?utf-8?B?QW9pK0xtL2ZMOEVpeGw2N0RZaWcwa3VSSnQ0dlluWVZGVFRGMzV3Zm5KcUU4?=
 =?utf-8?B?b1FwMnZHMHF5VTM1dDJaNzFHUjl1dk41ck1WcHdlb09ML0dOWSsxam9xQThB?=
 =?utf-8?B?cWlNWU90Y1VNY01ZMHVOUE90Q3FrTnRKazNSTmFVWDlqclB3THdNaHIvcHgz?=
 =?utf-8?B?eWxkSnY1cmdtSkFCcUpEZ3VtcnR6WFJpQU1CSW0xOFNna2VJOUVDOGhQUkd6?=
 =?utf-8?B?WldXQVBPWFQ3WW5QS2pnR2o4YklaclN5MlZyMEJEN0xPMjNtNTZ5bFJ0aWZO?=
 =?utf-8?B?Z0lCWWNvQmFHU3pBY2pMYXh6NnBReHZzRFdzdFdxaTQ1eUhnV3FqeTBjeGFl?=
 =?utf-8?B?VWhZV1k3eWtUeWtyc0dkbjJIbzdUc1NaTjRHb0YwOTZCUXU0WFlESHBhQUlv?=
 =?utf-8?B?MDFMOVp0UW1TNytJYUFVQnVBWCt0YUNIekJ0T0ZYRDZQdkJURlYrSUZILzdQ?=
 =?utf-8?B?aldCNTlDQ1cvSjV4N0ZFSUdoZVU4TEQ5T3VKdnl6RVkvQUxNZ1R6bTFpYVkz?=
 =?utf-8?B?ZWhnUnNteUxwdC9oZHVmWlEzQjFjOHhiSENJOUVITW9PU2JFWmdnb0JOQ3Qx?=
 =?utf-8?B?cmhLWGxlS3hGZXZ0aTVOTnM2NzFrWXQ4ay94bE9BcjZYa1FJNlpkNkRoVG16?=
 =?utf-8?B?WVQzZUEwWGpvVG5Wa2Q3NE5BSzhtLzZQYmlVYmZ0L0J5YWFJelZMMm9ydUpO?=
 =?utf-8?B?ekIrU1BOOXYwNGdSTFBodzdKb1NrYWNObTFxYXF4M1N0YzJxZ0JSSVFYRzRk?=
 =?utf-8?B?MVNrRlpYK1hIMWI2YkJLVGpBK0orS28wMGlRTWhIUXFrcWhFcEkweFVIcGJH?=
 =?utf-8?B?R1pTOFNyOXJrUUd3dDZlZVl1enRxMjFEa0RFeTQ5K3pUY1JLbXN1bkVoRStk?=
 =?utf-8?B?WXI3RG9MYk5nOVV0S3JpWHh5U0pUU2g5ejhjSUt5SGlLQ2lwZUlCYzlYVnZC?=
 =?utf-8?B?dHV4aXpJc0JRMytMSUJ2aTFiZmxNTURaVkV5OEVzWWcyUkVtNVFKUVMvNUNM?=
 =?utf-8?B?dWIwVjdlajBjNXFlVDllR0hTZWZ3SHFOQ25PM1FNbll5NkdQVzhWUGcxc285?=
 =?utf-8?B?TXFZRHNvRU1ZamVpYVh2MTg2WHBSMkZTd0xlVjZ4RVo0anFNMkl1eUFyaVpS?=
 =?utf-8?B?V3AvM2lRSFQyOE5YMkFlVVBnemNUWk1vNFg0Rmt4RXJOUGF1S2V2aFJHcENR?=
 =?utf-8?B?dnJhYms1eVM0OERjOHBvMEpueEtGdTl5N3EvRGhCRWNmaW54SVVFdldGTHNx?=
 =?utf-8?B?aExDQ2xpQ0NBR0JPQTRUcWlCbmEwZUdsQXdjUW14S1FvVVJ5Mm16M2tDV3pl?=
 =?utf-8?B?cml0UElSd1hQRlNld1gwWHlZa1BITlBLMC9CNk1ObktYa203Rkd4OGZRa3ZG?=
 =?utf-8?B?WXlROWxCZHBxMlN2djZXUGRFNzY0SXE4OUxGdXlTYkhnTmo2OWxHdUJqcDZm?=
 =?utf-8?B?cm0yUkdDaEtCYTJWUFZiWWNxL2xCdkRHVTdwTFhEZHFRekRtYlNWL3ViM0ZJ?=
 =?utf-8?B?NUR1OE5NLzc3ZG8rajdWbFVmTFdOUWRManpFQ1IxelNlWXFCSFpTQXJnTWVM?=
 =?utf-8?B?QTNaWXdUdDhZOERoUnZWeWJhMFlLT3hObEJmSEQ4TEs2R0VtaENwdDBvblBP?=
 =?utf-8?Q?0a1WMpD3dN9w30G2LY4wqnDbP0gAaw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm55VFZTcE1KdUdVa3BKN0lIaDQ4NVh4TFpoN1NkMEpyVDZBdzJHQ294TEJx?=
 =?utf-8?B?SFV5Q0YvWDlMd1ozTU5haTZ2eEZRWnpGampsODZ2TTBjS014WHlVRzBZLzhw?=
 =?utf-8?B?dlM3N0I2N2FQaEsrWnZFZTIyeitOSzFQZUZjenpIbm0wVHRncDAvdVR3anUr?=
 =?utf-8?B?T2xFbkI4T3dwWmlWaDZnRXFHanNZUjRFaVVEYVJ1eElJVEczMGpvSmYxR1BS?=
 =?utf-8?B?Z0g1T2RkMVUwVmkvbXM5QlVwMGhZc0VYbG9jcGdpbWxycTZEam5sUUh3dERn?=
 =?utf-8?B?VnJEU3RWdnk1Y1QwYVpwVTJWSnpoNCtWS0gxOVZCY2sxMENBbFgzVUtDREM3?=
 =?utf-8?B?QW1GZEtiUlMrK011V3hhcGcxczFWY05RNXVRcnBBekthVjBROU0zSEJreXFH?=
 =?utf-8?B?YkdhWDJoUlkvZ3AwLyt2RkJuck9zcXRnbXRGOEQ0YTNwaXNGYWVOTE9hVDJo?=
 =?utf-8?B?bEF6ZzFHdG52bVBFNkdPWU9UK1NCOUNtRmFENy9MUVlDNU9naXlCS2gxaDlL?=
 =?utf-8?B?M200czVsRFVHZW5zRy9hYjJzaWVEOFYzRHMwSDRuaTcxd0kyck1JN2lzK2FV?=
 =?utf-8?B?RE9zbDJ3WGxSdHVuMzd4aVI5d2p6UlR0Vjk5R3kwYTdRVTFPd0lwczhSbUk3?=
 =?utf-8?B?MXpBNnN5S05zZmszSGlIV0VmZmtNV0dJYWNHZ3FKYmVVOGdFTzhYMVNzV20y?=
 =?utf-8?B?K0cxU3c4ZC9ZSlBwY3h6SkFTRERCdjlzNi8zMk12Z3o5QUh4dFNOQk1jb2xl?=
 =?utf-8?B?UkxLdmlmakIrTVlyZWtPMlMzNWVBZ3ZpcEFZUHpjRUxHMHcxU2Q5ejVjZmZm?=
 =?utf-8?B?ZytNWlljckVLVTZVN2RxVXdVb1RDMWwrK0VodlMwbXpDQ1A0R2dQeHZpdzJM?=
 =?utf-8?B?aURwVldGTzRSdTNPNzVUbTdrcXlaSEU2a0piLzZPcDd5RVNScEUzOUd4L2VG?=
 =?utf-8?B?aG1RWEdFTHFQSGxGb0hrcjFrOEVWTUE3TFV2QWEwdUovT0docnRwSXVZVnhC?=
 =?utf-8?B?cEVlYVNjTjlYR1MvQ05TK00yQ21aSUxEdWxHREh2a2xCU0RjekpuSTRwRzZB?=
 =?utf-8?B?bk5IRVFxSGpjR2lnc25QK25VV0IybHAvY1NUMFVlYS9lWGtCNFA4ZEYvOFRE?=
 =?utf-8?B?U05qZnFmMVh0N2hRakUzVjNXVC9UaE0yc1JZTDNWbHBUOUIvb1cyejF2MUJS?=
 =?utf-8?B?MFBCY3lML3FjRVhLcXprRmdIa05jZHIzZXpJcUV3Zjkwcjc2QUlCRUNDOFpI?=
 =?utf-8?B?OUVVTFFvQ2JGZzRaSGx4d3dRajU1elRmSzZFaythYjhwNDUxU01CdHJLNnJn?=
 =?utf-8?B?MEVxdUZRbmhlb3BLbGhLdFFEemNzWFl5R3YzbzI5L2RUUjlDQnYwQ2ZSWWxv?=
 =?utf-8?B?d0VpT2xPK0YwRllvejFyRmQ3YkcyeWN5akw1YUFaRE51eHgzY2hFNFlGbnk2?=
 =?utf-8?B?WkVlT29VMEpYT3R3TE02bUhJUDhuOEVwMjRhSlBFNjNTQ09SbmQ3dUw3RU9G?=
 =?utf-8?B?K3FBcVNRYUY1enVxOEk5WkwxTEUwQTNQcExNV1dwcENIZW1KTGhrOVF3a3Qx?=
 =?utf-8?B?V1hHRVVYTmwzM0R2NEFmRGJnMVIzUnBjTVhWaTVaQjBDME1PSHVwYkVJTjNI?=
 =?utf-8?B?NlVKWEhDdWp1MFFNeGZCMXdVQ2xRTHRUNVc1dnJUZWRlUFpkRHozT0MwdFBv?=
 =?utf-8?B?cStLWHcrWjNxU1A3bDlSSkNwM2N0RzllZXB3aTRXTHdsQ1BCb0xHUHhyMk1s?=
 =?utf-8?B?WkhVUEE0NmdLVmIyMjlyTUVPVlVnQ3ZDWDZkVnFGRlBYcW9tMzFqd3pxblJq?=
 =?utf-8?B?UDdBSE5GUlRQYk52NzY2R0tDSDduUHEvWlF4ME84cHc5TFNmTmUvRUQ3ZHZI?=
 =?utf-8?B?OFpMd3c5TC8zVjBWTkw4LzhjM0xpQ0szNHA1MkNvNU5jQWRIaDB6YkVlS1ky?=
 =?utf-8?B?QkdNY2dJc05NQnd0ZjR6Sm9NSitKYUNpbUVhVms0cnM3ZU9EQUt2V2c3U1p5?=
 =?utf-8?B?WVcvemxGeW9LL2hINU9ldHk1azNrQnJQZEF1MWtncW9RTVhpcjRzSzZCZHp5?=
 =?utf-8?B?WFNZZVpFMjJxWG8xYW1OZnc2dEQyWXlmWUVhUW15WjRTdXY0ZkFzdDdZRnNu?=
 =?utf-8?Q?kNSA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f7ef7b-9c74-4f09-6440-08ddd0151b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 09:32:02.2361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4a3YFqMJ5V4WiLbs8XRcy/pKJTBRvAAg9jd2TwQyuetgYOY12poxv1nX5HJwcSBQVGUg5qYIKwMqg0sGOslOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113
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
eUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ35pyIMzDml6UgMDowMw0K
PiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgUGVu
ZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+OyBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4g5oqE
6YCBOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAbmFibGFkZXYuY29tPjsgRmFiaW8gRXN0ZXZhbQ0K
PiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47
IFRvbSBSaW5pDQo+IDx0cmluaUBrb25zdWxrby5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsg
QWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47DQo+IEphY2t5IEJhaSA8cGluZy5iYWlAbnhw
LmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHYyIDAvNF0gaW14OiBhZGQgaS5NWDk1IGIwIHN1
cHBvcnQNCj4gDQo+IE9uIE1vbiwgSnVsIDI4LCAyMDI1IGF0IDc6MjHigK9QTSBBbGljZSBHdW8g
KE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBIaSBUaW0s
DQo+ID4NCj4gDQo+IEhpIEFsaWNlLA0KPiANCj4gUGxlYXNlIHN0b3AgdG9wLXBvc3RpbmcgaW4g
cmVwbGllcyAtIEl0IGZvcmNlcyB1c2VycyB0byByZWFkIHRoZSBtYWlsIGluIGENCj4gYmFja3dh
cmRzIG9yZGVyIHRvIHByb3Blcmx5IHVuZGVyc3RhbmQsIGNvbnRlbnQgZ2V0cyBsb3N0IGFuZCBv
dXQgb2Ygb3JkZXIgYW5kDQo+IHRocmVhZHMgZ2V0IGJyb2tlbi4NCj4gDQo+ID4gQTAgaGFzIGJl
ZW4gZHJvcHBlZC4NCj4gDQo+IFRoaXMgaXMgdW5hY2NlcHRhYmxlLiBIYWQgSSBrbm93biB0aGlz
IHNlcmllcyB3YXMgZG9pbmcgdGhpcyBJIHdvdWxkIGhhdmUgTkFLJ2QNCj4gaXQuIFRoZXJlIHdh
cyBubyBtZW50aW9uIGluIHRoZSBjb21taXQgbG9nIHRoYXQgdGhpcyB3b3VsZCBkcm9wIHN1cHBv
cnQgZm9yIEEwLg0KPiBUaGVyZSBhcmUgbWFueSB2ZW5kb3JzIGxpa2UgbXlzZWxmIHdobyBoYXZl
IEEwIHNpbGljb24gZXZrJ3MgdGhhdCB3aWxsIGxpa2VseQ0KPiBuZXZlciBnZXQgdXBncmFkZWQg
YW5kIHNob3VsZCBub3QgYmVjb21lIGJyaWNrcy4NCj4gDQo+IFdlIG5lZWQgdG8gYXQgbGVhc3Qg
a25vdyBob3cgdG8gZ2V0IGJhY2sgdG8gd29ya2luZyBib290IGZpcm13YXJlIGZvciBBMC4gSQ0K
PiB3b3VsZCBiZSBmaW5lIGlmIHRoZXJlIHdhcyBqdXN0IGEgS2NvbmZpZyB0byBzZWxlY3QgQTAu
DQo+IA0KPiA+DQo+ID4gUGxlYXNlIHVzZSBteDk1YTAtYWhhYi1jb250YWluZXIuaW1nIGFuZCB0
aGUgb2xkZXIgaW14LW9laSwgYW5kIHRoZW4geW91DQo+IGNhbiBjaGVjayBpZiB0aGlzIGNoYW5n
ZSBuZWVkcyB0byBiZSBhZGRlZC4NCj4gDQo+IFllcywgSSB0cmllZCBteDk1YTAtYWhhYi1jb250
YWluZXIuaW1nIGJ1dCBJIHRoaW5rIHlvdSBuZWVkIHRvIGJlIG1vcmUgc3BlY2lmaWMNCj4gd2l0
aCB0aGUgJ29sZGVyIGlteC1vZWknIC0gdGhlcmUgYXJlIG9idmlvdXNseSBwYXRjaGVzIGluIHRo
ZSBPRUkncyB0aGF0IGFsc28gZHJvcA0KPiBzdXBwb3J0IGZvciBBMC4gUmVnYXJkbGVzcywgSSd2
ZSBnb25lIGJhY2sgdG8gdGhlIE9FSSB0aGF0IEkgd2FzIHVzaW5nIHByZXZpb3VzbHkNCj4gKGxm
LTYuNi41Mi0yLjIuMCkgYW5kIEknbSBzdGlsbCBub3QgYm9vdGluZyBhbmQgcmV2ZXJ0aW5nIGNv
bW1pdCA5OTM2NzI0YWE5Yg0KPiAoImlteDk1X2V2azogQWRkIGkuTVg5NSBCMA0KPiBzdXBwb3J0
IikgZGlkbid0IGdldCBtZSBib290aW5nIGVpdGhlci4gSSdtIHN0aWxsIHRyeWluZyB0byBmaWd1
cmUgaXQgb3V0Lg0KDQpnaXQgY2xvbmUgLWIgbWFzdGVyIGh0dHBzOi8vZ2l0aHViLmNvbS9ueHAt
aW14L2lteC1vZWkuZ2l0DQpjZCBpbXgtb2VpDQptYWtlIGJvYXJkPW14OTVscDUgb2VpPWRkciBE
RUJVRz0xIHI9QTAgRERSX0NPTkZJRz1YSU1YOTVMUEQ1RVZLMTlfNjQwMG1icHNfdHJhaW5fdGlt
aW5nX2ExDQptYWtlIGJvYXJkPW14OTVscDUgb2VpPXRjbSBERUJVRz0xIHI9QTAgRERSX0NPTkZJ
Rz1YSU1YOTVMUEQ1RVZLMTlfNjQwMG1icHNfdHJhaW5fdGltaW5nX2ExDQoNCj4gQmVzdCBSZWdh
cmRzLA0KPiANCj4gVGltDQo+IA0KPiA+IHN0YXRpYyBpbnQgX19zY21pX2Nsa19zZXRfcGFyZW50
KHN0cnVjdCBjbGsgKmNsaywgc3RydWN0IGNsayAqcGFyZW50KQ0KPiA+IHsNCj4gPiAgICAgICAg
IHN0cnVjdCBzY21pX2Nsa19wYXJlbnRfc2V0X2luIGluID0gew0KPiA+IC0gICAgICAgICAgICAg
ICAuY2xvY2tfaWQgPSBjbGstPmlkLA0KPiA+IC0gICAgICAgICAgICAgICAucGFyZW50X2NsayA9
IHBhcmVudC0+aWQsDQo+ID4gKyAgICAgICAgICAgICAgIC5jbG9ja19pZCA9IGNsa19nZXRfaWQo
Y2xrKSwNCj4gPiArICAgICAgICAgICAgICAgLnBhcmVudF9jbGsgPSBjbGtfZ2V0X2lkKHBhcmVu
dCksDQo+ID4gICAgICAgICB9Ow0KPiA+IFRoaXMgaXMgdGhlIHBhdGNoIGxpbmsgb2YgdGhlIGNo
YW5nZToNCj4gPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvcGF0
Y2gvMjAyNTA3MDcyMDIwMzQuMzg1ODkwDQo+ID4gLTEtYWxpY2UuZ3VvQG9zcy5ueHAuY29tLw0K
PiA+DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+IEFsaWNlIEd1bw0KPiA+DQo+ID4gPiAtLS0tLemC
ruS7tuWOn+S7ti0tLS0tDQo+ID4gPiDlj5Hku7bkuro6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0
ZXdvcmtzLmNvbT4NCj4gPiA+IOWPkemAgeaXtumXtDogMjAyNeW5tDfmnIgyOeaXpSAyOjAyDQo+
ID4gPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsg
WWUgTGkgPHllLmxpQG54cC5jb20+DQo+ID4gPiDmioTpgIE6IFN0ZWZhbm8gQmFiaWMgPHNiYWJp
Y0BuYWJsYWRldi5jb20+OyBGYWJpbyBFc3RldmFtDQo+ID4gPiA8ZmVzdGV2YW1AZ21haWwuY29t
PjsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47IFRvbSBSaW5pDQo+ID4gPiA8dHJp
bmlAa29uc3Vsa28uY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7IEFsaWNlIEd1bw0KPiA+ID4g
PGFsaWNlLmd1b0BueHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgUGVuZyBG
YW4NCj4gPiA+IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4g5Li76aKYOiBSZTogW1BBVENIIHYy
IDAvNF0gaW14OiBhZGQgaS5NWDk1IGIwIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBPbiBNb24sIEp1
bCAxNCwgMjAyNSBhdCAxMTo0MeKAr1BNIEFsaWNlIEd1byAoT1NTKQ0KPiA+ID4gPGFsaWNlLmd1
b0Bvc3MubnhwLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4g
QWxpY2UgR3VvICgyKToNCj4gPiA+ID4gICAgICAgdG9vbHM6IGlteDhpbWFnZTogQWRkIDIgbmV3
IGNvbW1hbmRzIENNRF9DTlRSX1ZFUlNJT04NCj4gYW5kDQo+ID4gPiBDTURfRFVNTVlfRERSDQo+
ID4gPiA+ICAgICAgIGlteDk1X2V2azogQWRkIGkuTVg5NSBCMCBzdXBwb3J0DQo+ID4gPiA+DQo+
ID4gPiA+IFllIExpICgyKToNCj4gPiA+ID4gICAgICAgYXJtOiBpbXg6IFVwZGF0ZSBFTEUgZ2V0
X2luZm8gc3RydWN0dXJlIGZvciBpLk1YOTQNCj4gPiA+ID4gICAgICAgc3BsOiBpbXg6IEFkZCBz
dXBwb3J0IGZvciBuZXcgUFFDIGNvbnRhaW5lcg0KPiA+ID4gPg0KPiA+ID4gPiAgYXJjaC9hcm0v
ZHRzL2lteDk1LXUtYm9vdC5kdHNpICAgICAgICAgICAgfCAgOCArKy0tLQ0KPiA+ID4gPiAgYXJj
aC9hcm0vaW5jbHVkZS9hc20vbWFjaC1pbXgvZWxlX2FwaS5oICAgfCAgMiArKw0KPiA+ID4gPiAg
YXJjaC9hcm0vbWFjaC1pbXgvaW1hZ2UtY29udGFpbmVyLmMgICAgICAgfCAgMiArLQ0KPiA+ID4g
PiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9LY29uZmlnICAgICAgICAgICAgfCAgMSArDQo+ID4g
PiA+ICBhcmNoL2FybS9tYWNoLWlteC9pbXg5L3NjbWkvY29udGFpbmVyLmNmZyB8ICAxICsNCj4g
PiA+ID4gYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL2lteGltYWdlLmNmZyAgfCAgNSArLS0N
Cj4gPiA+ID4gIGNvbW1vbi9zcGwvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDcg
KysrKw0KPiA+ID4gPiAgZG9jL2JvYXJkL254cC9pbXg5NV9ldmsucnN0ICAgICAgICAgICAgICAg
fCAxMiArKystLS0tDQo+ID4gPiA+ICBpbmNsdWRlL2lteDhpbWFnZS5oICAgICAgICAgICAgICAg
ICAgICAgICB8ICA2ICsrKysNCj4gPiA+ID4gIGluY2x1ZGUvaW14X2NvbnRhaW5lci5oICAgICAg
ICAgICAgICAgICAgIHwgMTEgKysrKysrDQo+ID4gPiA+ICB0b29scy9pbXg4aW1hZ2UuYyAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDU3DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tDQo+ID4gPiA+ICAxMSBmaWxlcyBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAyNiBk
ZWxldGlvbnMoLSkNCj4gPiA+ID4gLS0tDQo+ID4gPiA+IGJhc2UtY29tbWl0OiBjZDc5YTI4Mzli
MDE1NzFiNmYyOTE1YzIxOWY3MWMwNWUzYzk3NDgyDQo+ID4gPiA+IGNoYW5nZS1pZDogMjAyNTA3
MDgtaW14OTViMC1lMTJhMTM1NTI2NTgNCj4gPiA+ID4NCj4gPiA+ID4gQmVzdCByZWdhcmRzLA0K
PiA+ID4gPiAtLQ0KPiA+ID4gPiBBbGljZSBHdW8gPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g
PiA+ID4NCj4gPiA+DQo+ID4gPiBIaSBBbGljZSwNCj4gPiA+DQo+ID4gPiBJdCB3b3VsZCBhcHBl
YXIgdGhhdCBzb21lIG9mIHRoZXNlIGNoYW5nZXMgYnJlYWsgY29tcGF0aWJpbGl0eSB3aXRoDQo+
ID4gPiBBMCBzaWxpY29uIGNoaXBzLiBJJ3ZlIHRyaWVkIHJvbGxpbmcgc29tZSB0aGluZ3MgYmFj
ayB1c2luZyB0aGUgb2xkDQo+ID4gPiBhaGFiIGNvbnRhaW5lciBhbmQgb2xkZXIgaW14LW9laSBi
dXQgYW0gc3RpbGwgbm90IGFibGUgdG8gYm9vdCBteQ0KPiA+ID4gaW14OTVfMTl4MTlfZXZrIHdp
dGggQTAuIENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gd2hhdCBpcyBuZWNlc3NhcnkNCj4gPiA+IGZv
cg0KPiA+ID4gQTAgdnMgQjA/DQo+ID4gPg0KPiA+ID4gQmVzdCBSZWdhcmRzLA0KPiA+ID4NCj4g
PiA+IFRpbQ0K
