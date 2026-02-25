Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D985F5543B
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 02:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8647C83D8A;
	Wed, 25 Feb 2026 03:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vtRt+F9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9233083DCB; Wed, 25 Feb 2026 03:24:37 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3395483C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 03:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd/gtBAwy11RK02gkiJD7DpOPQxk6xbg6sPsKpMtyu7CH9PHQ7l28xNmfGvXWSumnz1HC7ADw6NF6I72DOv3XMKQ1A8Oh4vNqAPRFaxk3SilX5dN4GUkwG4fyYFs77F/sTCaqAv10UOBilnOFCwMBC6V+iBVLy4UgAram1YxR2YF4q92nb/cBx5x87No6WY83VxfwPcob6/lPHRj/P0+4zb+/fxik0ZQd5D86ZWcylkhCpUmOYB10ognsIkJ49/5Bmt+Ite+2+7RY3xGLTBJ2JehU43wKyIG+ZsXdMlDFUashZ3QqbhbwT5StwvV2Si892A22GwDANtE7TDgwivwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5aJD2vBIjOjCISJLQJfDxTx7b1kxh8sQNPzVqbqCRI=;
 b=wJDAS69wm2qmnqDMUsuX37kk0A6aqtEE7AJYnRtRptel2U130dwMgYZK1DM5Mstq58s55nCaC4FsfeVtsQQgkIqbmGtea8Us9VkRwttyLnRyHOER+vYeR02yw/XqAjgEVBlGvqrjVx1Obrs9qh2u06tSDNcxulHYNw1CUP6wrWe4JTih6WcUjXqNtEDTaRZyzy6na4fAydrkIpy4m1uqPanGr0aSBKfhONtu480FsDMSg++5Nr24xTgWzv0npr+/ixsuMJ2AZF5H1IsxkbK2eyy0dM1qt0qAVoZHMM2rRhY2oZZoc7d0yuQFASQgiKXDquVJ+SXwV0V5eDdI8KxrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5aJD2vBIjOjCISJLQJfDxTx7b1kxh8sQNPzVqbqCRI=;
 b=vtRt+F9w1H/HSzCt1F2BbiioK8bhSgCDbxITvVt40SG2F+2riETFKCeygEb/6pYL2ABjyxIrh2l5AH98IHHe9PwcYBDGVXkw6ZSWXe5dheBSrPbY1B4bQei4RgDcYgUAAOZCvPUOmKk2Z5Rb04HE2H1SAyr7gi1ZTAQFccdHdF+S8hY5NrE/I6NO6eEEOR18vEsyuQNDU/0zYRUw1ze2RBC2GVET2YilKtAQjA88+AJK99sfry4F6mi+lVvZzILhH6cQZlJZX+U3ez2CqvbdbRFF+oU57GForRNRkz5L0xJPM1tOgCSu2q5am4lEVcRjTGRxmY3Sq2y4k7C+Sx80eA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8945.eurprd04.prod.outlook.com (2603:10a6:20b:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:24:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:24:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: =?utf-8?B?U8OpYmFzdGllbiBTenltYW5za2k=?=
 <sebastien.szymanski@armadeus.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Julien Boibessot <julien.boibessot@armadeus.com>
Subject: RE: [PATCH 2/2] serial: lpuart: handle Overrun flag
Thread-Topic: [PATCH 2/2] serial: lpuart: handle Overrun flag
Thread-Index: AQHcoOc2jGLwvLjsXUGj3LovjW3Yj7WSucqA
Date: Wed, 25 Feb 2026 02:24:32 +0000
Message-ID: <PAXPR04MB845909E4C5FC076A9EBB9D908875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
 <20260218-lpuart-fix-rxfe-offset-v1-2-86a78b224f13@armadeus.com>
In-Reply-To: <20260218-lpuart-fix-rxfe-offset-v1-2-86a78b224f13@armadeus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8945:EE_
x-ms-office365-filtering-correlation-id: 218d6291-6df3-4f87-89ae-08de741502e3
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YXdBWDJBdDEzQ1p0RTUzdlluaHU2cmJqa0xzY2JpMWVuV2dxc2VQeWlBeVd6?=
 =?utf-8?B?c1dlMUdQR1c4QnhoamUxczc1dFFERDhlSGFiM2M3d1doQ2ZLaWF2dUM4ZkRQ?=
 =?utf-8?B?ekg1UWxqbEpUYjhRTzFLeUR6VlZjU1hCZ1hjL2F2N3BnRk93UnZ4eE8vMGR3?=
 =?utf-8?B?M09iMTYvaHNUdy96bE5xNGh3dEVablBDQlM4cGMzRGx5MmFzNFdiWFFDT0pF?=
 =?utf-8?B?Y0lJOGsvUDZKZk5RVFc2djBRa0pDNVZ5R1ZSalVSbUQwYjdwek00ekRHclhI?=
 =?utf-8?B?S21ZL1QxelpjZ2lXNjVlb3pwcm5kR0hYdlZ6Yzk0TDdvdzJtNktSTW5VcXJB?=
 =?utf-8?B?eWM0cEw1NWZHTXNHSHIxbGh3RFoyNUsvamF5cGkyWWJFQ00vOExzbDBmSXQ5?=
 =?utf-8?B?aktnejlqM3lZSVJFS0o5dkdrZVQvNElSZ05Yc1h4U1o0Q1IxRnJHdnFmWEVn?=
 =?utf-8?B?NS8rWG44cnZEVUZGeGZVYTZxcnhhUmptT2tFKzR4Rk51ZllPalJoZ0tnN2gr?=
 =?utf-8?B?d2puVG51ZXdKNk1IQ0d4QmtxNW1RUTA5MStXdmR1dk1adWFEUWxvalZQZlNT?=
 =?utf-8?B?NTJtL21YaURKS1ZSUlNlQkw3OHRpUjlkb01MWXVkNWRsZEpjWXoxWTNYQzd6?=
 =?utf-8?B?d0oyaHlxdHpDQWNFY0JtbHBYUnhwdWdVOGU3NE1KKzEzQzZiN3d2OXF3V2Rp?=
 =?utf-8?B?YW5rMm1pVGIyL0thYmVoY25aQm1DTCtCSWZZWEczZG1nNENsOGtrK1ZSY2ZK?=
 =?utf-8?B?ZFlmV3BaVThwNkJzM0pIOFZCcDdJWlMzOHVpUnB0Uzc1cDdsS0V5TTdaTUUr?=
 =?utf-8?B?RUM0TkV3YWdDMERxSllKZXFZNDdLV3ljWEIwZmpwZi9Jc2N4alBOdm92Y1Jw?=
 =?utf-8?B?NVNjVjRQMGlpMW4vQUNUM3l4amFVSDl3RFUwS1NzSDl0c0lRdVZJR04waDI2?=
 =?utf-8?B?K2ZpSDdiTDgwa1dPdndGdFkvWGNCVW5XdWZmVjRZWDFRTTVBQlB0cnE2YzNz?=
 =?utf-8?B?Wk0yZUVzMHJkRCtiUmRBWXVsWVJsa01kTlRkUGxGTnpreGw3R1ZNN3dFU2gw?=
 =?utf-8?B?NC9uRmpCcUoxVjI2SXVsQ3NZd1gxWklwTTdHUDJLY1l6WW9tSmU3c2ZjODYx?=
 =?utf-8?B?WEg1dk56MlN2L3NvN1VXTmhiT21JMzFMcTNXWmVjd2RRajhsY2I0bEZUYXpk?=
 =?utf-8?B?TlQzZFFkUWZ3OHZYazExTUJZbEE1Y0VvU2V2RjVLN2tXaXg0UE5LQXVGUnJ0?=
 =?utf-8?B?NklNVVBIbms0c0FTTkY3b1FDZWl4cjVkWEtZUDhIcWo3TCtyWmo5cTNqR1E5?=
 =?utf-8?B?c2xKbHdTRWpLeEJkVUhtVE9mMHdFazVkb1dxTHZVUys1ZmlYYkJTRmpNR0tk?=
 =?utf-8?B?SlBjU0dmSDlkVVdDOUdCYWlnMzZQRjB2VGpBQlBGUXRhZWorK2dnWVVvSFJw?=
 =?utf-8?B?R0lBT0NhYmxUYlBEWlVtVjgyajdWeFB4bDdCVEdlSmE5L2h2WWhseFJWRnNH?=
 =?utf-8?B?M0N4RnRxZDY5aGoxdVZkdEx3TU1NQTM1M3lSdTlrditFZ0FRdHN5bThoRlZt?=
 =?utf-8?B?cEZTLzdXaXlyZDZmRzZmeEZXd3FBYmNCRWVqWVlmTzhWQjNTNVgzMG1kQWht?=
 =?utf-8?B?Tm9mWkpuSENNSUw5SWV2YUVyQXVSd0RyMzdLQWU2ZnRmdG9kcDlVbUE0RWFk?=
 =?utf-8?B?aWh6aFZQNWhxV1hRVEVFcGwzd0dsUzY4ZVpjYmFxbGZEbmJuVzlQeW9OQ3dC?=
 =?utf-8?B?L05udEU4QVFjdmk0K0ZYWnByQ3JBNXJRQTFvekVrQjFKVWRjaGl0eWRxbEtG?=
 =?utf-8?B?b1N0T1hBUXBDekVucVU1eklmeTBmbUdiRnVRY3VWZ1pLMG5HL1k0K0hLUTRR?=
 =?utf-8?B?U0hXdjB3eUo0cDk5dXlpeHJzTUxKSFMrMlFWdWpRb1JHQXRSelFxcTM1Skt5?=
 =?utf-8?B?YkRSSEpPd2NGdW1jZHVXU0UzMnp0Vmg0Wk13MGJRa2pHcm5wSWxGSFZBcXVp?=
 =?utf-8?B?bFRWZHE5VDN6TlRIa1F5b21PYWkvZXRJTEl1bG5HY252czJlQzE2UENIdmlT?=
 =?utf-8?B?OE1xV0hYaVlwVHJiT1BiVHlaKytEckRIUERkT25UbUw5K1hsVXdBOHdyazBQ?=
 =?utf-8?B?ZkQ0TStkRlVLTlZ2MHZXVkN5cVZVTFhDajBMTmJJcnhPRDc0eUlsWEZHZ1V6?=
 =?utf-8?Q?UQeqV28bZ2w8mSRMbgsy0Wc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXdpVmVLRjNWZ2E1UnZwZE5wSndVUzhhR3NCMGxrRDlJR1RTK3l2azAzMTRK?=
 =?utf-8?B?TmVjV2F4UXJic2Z0SEVFOUdYUWliMWVNS2FaYmFJWHhOKzI2VFFBN3Jsa2E0?=
 =?utf-8?B?UkxPNjczTElaVERCd3hLNHN2L2dyV0gwUVlaTGtCUFE3clVkLzhEbnpkNlRy?=
 =?utf-8?B?VS9ZK281ZSt5Wm9TdGVhNitUNHBDK1MzQzBFVjlGaHF4S2YzKzVhNHNqNE80?=
 =?utf-8?B?QjlOZHdVbGhtNXVoSHg1KzczODI1bmw1a0paWFAxd2hENTlxcmJuaXhCYkFR?=
 =?utf-8?B?Q3N3Q3Z4ckl6UWh2dkFOaGZMWURtYlkwelhFai9icThOUWkweWVadkVYUm9Q?=
 =?utf-8?B?WTNMWHNhT1gvdDNqbVhnaDRsczV3SDhlZHJNY2VHU3NLM053NFhQMjc0U0Qr?=
 =?utf-8?B?RU1jcy9WZEtDUzRzbElqYjI2SDBYUFphSmJQZlFGQXJyUmNWV1VaclpIc0g0?=
 =?utf-8?B?dDBJSGh2RUpFVHMzZkFoSVpuTURJb1JEdzJBWDVKbFEzSVV6L1hjU2Qxazlu?=
 =?utf-8?B?ZFEyVHVLUkFUYnNWRWxrYS8zN0hSSGJLOWk2SjR6Tks2bnlIVHBBSjNGRnZ5?=
 =?utf-8?B?NXVtaU0wYkpJWjd6STNrRDBPMU1vSHVTU01VdVdXUFQrZTNMNnRMVGNSMDRM?=
 =?utf-8?B?dUUyUkhiNHBORHVORTlkS2xSM2xPTDhrdzlmSGI1SXBrMmdPWnp1WjZEeElB?=
 =?utf-8?B?bnFTTHNVZU0yS2RzQnVyYmVzdnhYS29RS24vd2xUN1FKU01DQmpZeWo1UzBR?=
 =?utf-8?B?ZEh5Q0FFUWVKT0dJRlhxaWNkVHNJS0Z6cVZybkFaZkFacDl6c280b0xkRTlz?=
 =?utf-8?B?ZkhxSlZFQzFVZkIxVjhJYldVQnNldjk3ZCtFV3p6TlVpUU9iRTFHYWd1SkxB?=
 =?utf-8?B?K0l5THpXaXB3SjJJV2pHY1dmeTUzK2RzZE5VSXZ4L3ZKOTZ2K1lLazV2T1NT?=
 =?utf-8?B?Rmo0bXFzT3lGM0lma2hyM1pqK05FS2s0dksvRFZwcWdGcEtxbjJrR1daaGpD?=
 =?utf-8?B?cjdoSjBGVmV6RFJVTEs3TEFwMXpZTjFiQnZwbDF3L1dlRUVTM2VxRDcvUGdG?=
 =?utf-8?B?TDg3TG5iS2xYeXRSbTIwV2VyZEkwT3cvTU9RTlc5WUU3UWtMMVloVElyZWxT?=
 =?utf-8?B?dnFuellxTXJTbXhrVGVlT3V4TTF6MEJ2a2g5UTh0emdBck1JYWpvOERqc3Vo?=
 =?utf-8?B?bzlZQ2tOYXRjZkRRNnpqMmduRW9KMlBTMWJCVHFSOWhoN3cxV2NUdTd1amx1?=
 =?utf-8?B?VXNYN05oNk1vR1VEaFFpVERNajRZaFZkcUdrRzNtbVdnNjlzaTNvekZxNkt4?=
 =?utf-8?B?dU1WUy9DYmdZRUtnZEdLeTF2b3hZZVlXSFJzZ0RjQ0ZCcm1pWjcxNzlPSFor?=
 =?utf-8?B?ZytrM1NjZms0RVhpY1NEZjNRZUhPcDVTTnFhelV1MFBEQjB1Ymh2L1hyRFRy?=
 =?utf-8?B?M2pDVFEyRnB4aS9kclNhRXhTNm4rS3dNTW12dElIODJaMXo2MkN4bWZhY3c5?=
 =?utf-8?B?NndldjVRR1lHYmxtRFlaNm83VERiajdJeFIxakN6RGRlYkNuZXdwNWVXYUhK?=
 =?utf-8?B?S1kvTXhKcTJFdSs3MFhOQ1EySFM0aXdhUWVQNkczTStzTEFWYVdOOUx4UjdO?=
 =?utf-8?B?bS9adWdMcDB0MUQ5dERSWkkyUkUzcW9JNEFiOEpCVFY2NHpWM05YS2g0NFdF?=
 =?utf-8?B?NndqaW1kbEZvQnNtU3R0UG9xTVYydENseVlLQkFhMFlhMU52SlZCS0JmOFEw?=
 =?utf-8?B?eTVhVGRsdW9yRVVYMWQrcWdkaVBxeUY2NTg2aTgzUndsRVdIY282TEpuZnQ2?=
 =?utf-8?B?VEkranJEdUFaRUR6SEVldzY4RGF3RjRDRDhuWExuV3BsT1lKR1RBQ0tqNWtk?=
 =?utf-8?B?SzJnampnbzliUnl6UklvcDdGeFBWVVlFVGNNWENkS3ZhOThxZjhYTG4xQTBh?=
 =?utf-8?B?S2RlWkg2TGNJQklGVm5WUk8rSFdHeCtOc3Qwam5RY05FZURneERrQ0pBU3Rl?=
 =?utf-8?B?UnVoMkFRLzIxeWVoNDVkN3RVUDdNY0k5aWNoYTl4b2JUQU9GL0pIeUxHYndS?=
 =?utf-8?B?VHNqQ3A4Zno0TThxUUVOUDhCMXRHaWFnWmJFd0RlVjAxV09UcHdVK2UwQ2Ji?=
 =?utf-8?B?TE1tQ2dqWjdTQW8vMGxnMjlYbkZxNlErUG1ZYWcrTVJiaVlVT3NENksrdUdk?=
 =?utf-8?B?ODZjRHhYUGM5b052NTVYNDFxcW4yeWs5aGZqN2VpaW9PREpCOVBBcUdYTkRD?=
 =?utf-8?B?ZXl3eFJlRzJaNElobndaNEdGMHlJZGlZNTdKbWFxQ3JPRVhIMldiakU3L0pN?=
 =?utf-8?Q?N94LdV/7IPkNs+RGnu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218d6291-6df3-4f87-89ae-08de741502e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:24:32.4611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWgfrv+nyWFpw5rJQY8yPrzy+CCWfwBzlixZ541U7w+QiJp9G1uI6UaqwU9/gR5x65WwEAQfuhX3O2n76gbXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8945
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

PiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBzZXJpYWw6IGxwdWFydDogaGFuZGxlIE92ZXJydW4gZmxh
Zw0KPiANCj4gVGhlIHJlY2VpdmUgRklGTyBtYXkgb3ZlcmZsb3cgaWYgZGF0YSBhcmUgc2VudCB3
aGlsZSBVLUJvb3QgaXMgc3RpbGwNCj4gYm9vdGluZy4gSW4gdGhhdCBjYXNlLCB0aGUgT3ZlcnJ1
biBmbGFnIChTVEFUWzE5XSkgaXMgc2V0IGFuZCBubw0KPiBhZGRpdGlvbmFsIGRhdGEgaXMgc3Rv
cmVkIGluIHRoZSByZWNlaXZlIEZJRk8gYW5kIHRoZSB1c2VyIGNhbm5vdCBnZXQNCj4gYWNjZXNz
IHRvIHRoZSBVLUJvb3QgcHJvbXB0Lg0KPiANCj4gRml4IHRoaXMgYnkgY2xlYXJpbmcgdGhlIE92
ZXJydW4gZmxhZyBpbiBfbHB1YXJ0MzJfc2VyaWFsX3RzdGMoKQ0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU8OpYmFzdGllbiBTenltYW5za2kNCj4gPHNlYmFzdGllbi5zenltYW5za2lAYXJtYWRldXMu
Y29tPg0KDQpMR1RNOiBSZXZpZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo=
