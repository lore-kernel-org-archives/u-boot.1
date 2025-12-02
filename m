Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47E2CFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 03:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBB083DF3;
	Tue,  2 Dec 2025 04:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="h8TvFyUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E0E83DFA; Tue,  2 Dec 2025 04:36:18 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3CCC83DB6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 04:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RobiWxgub6H67MKGmmQ3eataBkhzSNMRoMkAYNcHpDZP8j1M4llz0ISsCqENgrmDBmMxtkBo/eiwjbJzMyzGN+DBqiHT2ku6nCmaimd6WSvMxFDiwVCovhoToRqdGCMSlTblfVow2u2/mtKsdpdlbjUMjv1fc/LDMCHuIgODv+QbgDJ0Bp8qUPoezAOCnHiG2LhcoXYgXYRc2sFr15uEktfw3X3LmN++JDH9BFPCJ5y4Hu5mkScqaH4riw++dXfHpS4wjTdDZGX6AceN7BFFPNlIy7HeVMDk0plRSi0WU0wp+a6HYcpvVaD5rGOwIDmtc+LXPiSr+1mhRf3dSddS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMSHQdYG9th50TgPGLdXTWsHJnviRD/y8gAPSTWHmso=;
 b=c9GHA9UUFpcfxhD6wDq4c1eQYv5zRX93aRxPXC1++ckV9pvCrAgaDmXT+Pdot1e+wt+/0pB2/q3D2EngdRUOZEI2MPascCzdSQpBgHQ6zoNVkJIYtE1bf6IZE088lcDHh8i2xQSTibqtV/+JsOAOkicrlJSxMM6iAxSm9kzo0oU0oC+j1P0ZRySAgl6upgB+v4LSMg1oTeQQT8nGuH5i4jQ84mt1a5n/SsEAR6jzWFGTQO/G//pPM3cBQS1lWBpgHBLyjU6FZ2eng2wwmSHOio7g0191oSprLCtctup0KJkkFVrKBRVrN2rbm7OmSCJhhiyYV1SRWAER7CI0JnICug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMSHQdYG9th50TgPGLdXTWsHJnviRD/y8gAPSTWHmso=;
 b=h8TvFyUbDeHIEybpQLJDzUSjXz0UHQjl1nWLntidemHfaAaxAAgHTrlS53SsjLaky26gs7s7P5tsnEGv/TrdZJfMvAVjWJ44d+mXfCcfnccLGJ+VZbiJEAibnFSvU4YLg8Kwqgo0QCYyanHIaynnaL5PBfXg4WqdqN10YZbNV7P9Ybd5r7R+BsZ8/RK7ZQHqmggeHz5KqJJC00N5dGkD5ZP80WXoGUzWBbj67UiMEAN+sLw1I5Ebhfv9eSY+KUd/6RAvUfWEH3wQCrEOfly38TjFDX+zCFfY1i2YE4n5DZLqD4/doFL4ZTSX3+3bT8D7Ulsm4PwjQCcUJAOuGgv4zw==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 03:36:13 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 03:36:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Joseph Guo <qijian.guo@nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Stefano Babic
 <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>
Subject: RE: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Thread-Topic: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Thread-Index: AQHcX4PqFDJT+6oYvEeFUAwT4nevIrUNKvKAgAB9BgCAAAFHAIAAAFHwgAABygCAAA7SEA==
Date: Tue, 2 Dec 2025 03:36:13 +0000
Message-ID: <DB9PR04MB8461A3967CB098498288476388D8A@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <CAOMZO5Dxi52OzFEBWU1hnn2HfHc9EZcgmwW=p-N-+Oy+JHQBHg@mail.gmail.com>
 <aS5PECe5b8576MTk@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
 <CAOMZO5CbYn544xKUb6QApg0bzc_cQEqqTSSC1r9SUgyfpQGSEA@mail.gmail.com>
 <PAXPR04MB8459355C0CE42DFCB11B17E588D8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5BbFUSMp_sOt0FkBMh=4a1QTbpFTjSMfTNDGvxo3ZEqfw@mail.gmail.com>
In-Reply-To: <CAOMZO5BbFUSMp_sOt0FkBMh=4a1QTbpFTjSMfTNDGvxo3ZEqfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AS8PR04MB8753:EE_
x-ms-office365-filtering-correlation-id: b3005653-dc44-4061-2636-08de3153f175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eGU3WlRHOFNrQUE3NXU3bXdMY3pWb0g1ZzRGaVcxNlFSWGRoZ3Z2M05BUGM5?=
 =?utf-8?B?Ti9JTzlCSDZZbFBkZ2haSjFlT1BNcTVxYUxpcnNjMEZSUTFMeklEbzg5SHNY?=
 =?utf-8?B?ZTltdGRIUlVXbmRoNno0bXY4cXN1OUYvLzZJbmlyb2V4MjBQOTNuQ3FlbHlG?=
 =?utf-8?B?c21IZGlmclhiK3g1K29yMWR3SGt6UWVWaGxLVnIyU1lTbU4yUUVUR2JmemNX?=
 =?utf-8?B?ZXpKeWRBNW9vV0Y5Slo0eUw0MEl6QXZkNEhFam9UaU1wbjVZTlBsWEhIcjYy?=
 =?utf-8?B?TWo2Y21lL09lSUpUK3lwTHR4ZEdUK2pCekVBL3hjOUlFUC95aXYvVDVnMFBP?=
 =?utf-8?B?S2hGSTU3a05Ed3Vwb0VDSERPVk8ySjQzVzBHR1RHRU05Y2xVRnl4SHIzc0pj?=
 =?utf-8?B?Nm8rZGMvM3M0M3R6em81eGhvdmt4TFE2UUdmTGFMcWNRWS9tY0xsUUZhYXdR?=
 =?utf-8?B?MG41aW5KRk02VVVRM1VoSXBvV1hNUUx5c0JUbHZrUWlKakJSSHdzRHRaSHBh?=
 =?utf-8?B?dWpIS0toZkVzOGNBQXVKSlREZWJscHdCS1ZMemZJcFYrb2VPTFNpamRObHpP?=
 =?utf-8?B?VEk2UG01T1VkNmk1L3NqUU9HUUtCNDZpQ2hlZDhyTmdSTXF4U0xTQXh4R2lX?=
 =?utf-8?B?OEZUcEtKSVFId1ovdk1BVjhES1N4TENpV3RZT1UzRWtoYkgra1pJSjZNZGdl?=
 =?utf-8?B?aUR3K045OW1kK2N1NmorbEp0RGUrbmdBdHVldGpIdGFadkZEMGZ6ZlU2Z2lV?=
 =?utf-8?B?TjZ6ZWl3U0RITXpmcEZKZHZLdkJFeWhPdTdxV2JZOE5NV2ZTOG9aWHVGdVFr?=
 =?utf-8?B?VDVURFEwbDJDVE9xMFlKMnZhN1ZQNjk3MHZydnVwSUduR0ovdkgvWEN2NVZQ?=
 =?utf-8?B?N00xMnk0MUR2Y2dCN1dKV1pGbWVIUnl6dHAvVStzakRUMkJUQ2NTM3dXOERF?=
 =?utf-8?B?NGhGYlJ6NDBZNVZjcWVjSjNIRmJPL2lVZW0xYXlKdXhjdzZOa2RhU2o4WFJC?=
 =?utf-8?B?RVkyK2NpRkY1UUVsMi9WL1lZNXlNeXVBRW1qaXd4MjA3T2dkY1g5a3huL240?=
 =?utf-8?B?M2t4aCt3QU9BeVRmbkRwUDNjb3BrUVZBUTVXK1NFYmRWNmcyakprU0FLYnA1?=
 =?utf-8?B?ZWM1ZnMxang2OXk3OGxGZHR6R0ROaFFYbC93enVXZFlQdEVVamdnMW9lUkda?=
 =?utf-8?B?eXhaSnBHaDJWR2ppZ0dtc3lyYktkeFdUR2lrQ1d0Umo3WVA3Z3BYV1pObk16?=
 =?utf-8?B?WVhPTXdPMTY4MjVDTFRPOWdpeEtuNmdUdFNldHZnV0REZnNoYjJmak1uZTl5?=
 =?utf-8?B?Q3dpV1VrVDZNZUkydnZ0TjRLdXVlSW5jS3JUdEVBcUxQaXkwcFJjb3E2N1Js?=
 =?utf-8?B?SjFtY0o3RlY3RlY2byt6NWc2aWF2SXlXVThhMUhtNVNBUkROZjFVTFFOVXJk?=
 =?utf-8?B?Z2crNGQ3eFZXRW03SVk0S2g3NEdVa1pPYVFNQzF3TFBROTNNTGd0ZjdWZEdL?=
 =?utf-8?B?U0FLL2FBVDFhZVVLOGdndXIrdzhoRnhOeTY4Y1pzcmpVQVVVUlViZEJpUnU1?=
 =?utf-8?B?aG44Ni9aVXBNa2EzY09NV0FxeEZiaXp0U3Yya1ZWVVhydmVxOUFGUTZKbzZ1?=
 =?utf-8?B?U0h1bkNldHNDOUNERWFsT0ZXWHV1aTFZdVJubHV2YjR4b0xNcDhoZlpCMEhq?=
 =?utf-8?B?eGU1S21wSmJUcGlpWTVuMjRVV2FkYUdwYk9waVovU1JRc2dKRzhnNmJQbkU4?=
 =?utf-8?B?d2JOQTdCcnpLSUZmWGFKbUZYc0VpdDRJVVQ4NTR2c3pYM3I3ZklNOVZLOW5j?=
 =?utf-8?B?MDkyamxTK3k0OFZ0VlAxWkgvZEFKSHNzdGFrRmVUdXB3NWVGZ1I4aE9rU294?=
 =?utf-8?B?NzFzWG1tWjhEbnEvUU5HRDUvNDNVUUJLcjdsWFdZTDNUT2t5aUdXYk5va0Uy?=
 =?utf-8?B?UnlNSXpUa0JMSWNIMm9DMHo1elRFb2IwaTlHeHpCSzFaOGNnMm1MSUtwRE5k?=
 =?utf-8?B?ZGthU09OQUlyTlFJWUVOTTZuWGl1ZStFQXpEOTNqbHlvVWJoVk9MT1Nsb2E4?=
 =?utf-8?Q?lsO5di?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmVIemErYUZSQVpiUWpKTzEvek5tdVQ2NlU1VGUwdGJmWWVEcHNXMUl3dDEz?=
 =?utf-8?B?cUxDemxITllJS291NG93OVhFckNudkc0MHFWbC9icVUvTjJRMWdhdjBGMndK?=
 =?utf-8?B?ZkNvRHJxSG5DeVZ1UUNLb1pzd1ExZXJXYi9BL1pSWjhBbG0xR01yZDZxUmF3?=
 =?utf-8?B?dHBHWG9XZlNGRUtSWUw0dmhLVTJBRDYyeS9qc24rN0VkWlBlMVlmdzJuS1Uy?=
 =?utf-8?B?MXh2S2NNUDZZMUFCNExLeGZoS1dXMmVqWmRvV2kzcGp5WE5MM0FndFBwTXVV?=
 =?utf-8?B?QWI5eW9ZMUJQbGI4NndPWFJGbFcwaGpGc2VzQ3JsbjhyY1FqaUdyK1hmRzR1?=
 =?utf-8?B?cmNzRGRHT2tTNGRoS1dFUlRqcVJ0eE1IY1hDT1lyaXlUeWNaTEJDY2l5ckg4?=
 =?utf-8?B?RWpSR3lRZmkweVRLeGZBRi9vNVR2c2IrcnFNYlh4dm5qUjkrZWd2SWdiV1g5?=
 =?utf-8?B?NWUxc296dWw3eFUvZ25XQ2EzTHpPdnNhT1FRZzFBd3NsR2ZURVIxM0M3NDZ4?=
 =?utf-8?B?OXhxUXRhc1QvUlpLOFAvQVEzbkpFNDhwVnpmakdDOVllNXRsMXhGRDRnNzBG?=
 =?utf-8?B?Yy9WeTdlVjNpekNzcGJWN2czMGpmSnRoZEcrQmxFQXFjQjdyeUg0SmV3RkF3?=
 =?utf-8?B?WGFnTGMrN0pDY1RhdFo1QnRCQyt1R1UrRW5NN3lEdEpxQXlvTTYxTkx4L2RF?=
 =?utf-8?B?YjR2S1ZtQk5xK0RpNUY2dWVMWElYUnFvSVFreVlycHpVdkFHemhRRmV3Mmxi?=
 =?utf-8?B?TDh5T3VqTkFRcnAyTm9teW9xTExvUE5PTmhLbW4rcWVDdEllYzlHN05iWktk?=
 =?utf-8?B?MUs2U2Z6T1hMZGlzYi9Hd3Z5N2VnTERFNG1rUFFUdW1ES3pKWVBORUo2Y0JF?=
 =?utf-8?B?WGFMc25sa0RLV0YvMXd2V1AyODlWUEpCSE9CVkpVbndLZVI0NzIzYVliNnhh?=
 =?utf-8?B?cDg2Z3Y0OVlVcGtyTXZ6SkpUSjdDSGJGeUFCRy9HM0VQZFpnMmlpMm1HWXM2?=
 =?utf-8?B?Qk1hQ3laSXV1RzhSdWxVWlJhYnlua3VGMGJFMlNpTkVqcjQwOVA1bnAya3BJ?=
 =?utf-8?B?SjhLNW90aFVFS21iNVByQjV0eDNNTmlzbytIWVBIcnc3UHBnWm5BSHpWNXNJ?=
 =?utf-8?B?WUFLc21MMWlmRW00WHhNZUM1dVFPNUZCNWFMMDJHSVh2NHF6MWxBRHh2bkZ4?=
 =?utf-8?B?dGlsQ2g4TFhFUzhFa0ZsazVQd2RObk8yRnBocVJEMzE5Yi9TV0E4dzhIU2FD?=
 =?utf-8?B?ZFd1dlo3N09JYTRWa3RuSnhaczRielhSOVRiNUo5M3VCVWVBR2o3MHRNeGZz?=
 =?utf-8?B?U3p4VEtoUWR4NU5RUEJPWmdUYVdmaHBITkx5Zzg0My9lbjZVSU1GQlk4T1I0?=
 =?utf-8?B?VjJoc2p6QU1FK2c0WmVneWo1NnIyL2o1dGlZQnh3NzVlT1hBNGpSTzUwdkUv?=
 =?utf-8?B?d2U3amhHZlgyd0tpeVhWbFZDYXNiYUNGMEkxQUNxVEc1S1NLNTVNQXdoLzNR?=
 =?utf-8?B?ek0rK2ZUMEJpbjhabHl5Y1NQdFlYVm8wZVRWWllVUHdjS0l4eGdNd014SkNH?=
 =?utf-8?B?Y1BSTDB0MERxTkdEQjQ5MVBxME5SSGE0SmNEQWdxZFY2NGFqaG8rcTJXem8r?=
 =?utf-8?B?NGdhbVZZbGVSUDRtZXAxbE56SE8zWFhMREdBYkw4dGdaVkNRdE4zWEJPYWV6?=
 =?utf-8?B?aUZkTmdQM3htSVVsdkp5eUpwZVpIeXlaaWRVeW04Z2xKZTV4WEpKc3diUVNk?=
 =?utf-8?B?SHlhbC9yNFpxWkFPSjZjbDY4eDU2TmNlanFsNGE3a1hzOGNabXU2TW5VMnRE?=
 =?utf-8?B?R3EyRFFKZEZLQU15TXFVdWwxNE14T2piWDZTdnVjTHIxbXAzVjluS2NLNUgx?=
 =?utf-8?B?QUFrNUMrVnRaRnI2MHFTVkF0ME1kU3RkVHBwSWhzanJadEcrYkxmVGFITFJm?=
 =?utf-8?B?NUNDeGFIendrcHJOYnk0R2FydnhtRGhEaEZXRFh2eFZPK1VZSUZ2OUVyY0Nu?=
 =?utf-8?B?VTdPYmxsVVhVVTBtc1Z5Mmk5VlozeXhUSUhJZkdrNU94U1hTTGp6eEJLNE51?=
 =?utf-8?B?MEhZR2lwbmJyRUlza3JlcXBEMGphbVA3T0xJU3ovZVhtM1BsMHRKajJBV3cx?=
 =?utf-8?Q?0+4k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3005653-dc44-4061-2636-08de3153f175
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 03:36:13.5780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9/NhlzZluVHs9LPIiX79P92bizShBxuHS9tZ/NlZY6EDIFy3P9EQblZulQsaI6H8uqeFIjtKLAjmAkhbN/Tnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gaW14OiBTdXBwb3J0IGkuTVg5MSAxMXgxMSBGUkRN
IGJvYXJkDQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gTW9uLCBEZWMgMSwgMjAyNSBhdCAxMToz
NuKAr1BNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gV2l0
aCBFQ0MgZW5hYmxlZCwgc29tZSBEUkFNIHNwYWNlIG5lZWRzIHRvIGJlIHJlc2VydmVkIHRvIHN0
b3JlDQo+IEVDQy4NCj4gPiBXaXRoIEVDQyBkaXNhYmxlZCwgbm8gbmVlZCB0byByZXNlcnZlIERS
QU0gc3BhY2UgZm9yIEVDQyBhcmVhLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlv
bi4gSG93IGxhcmdlIGRvZXMgdGhlIEVDQyBhcmVhIG5lZWQgdG8gYmU/DQoNCkl0IGlzIGF1dG8g
Y2FsY3VsYXRlZCBieSByZWFkaW5nIHRoZSBERFIgc2V0dGluZ3MsIGZvciAyR0IgRFJBTSwgaXQN
CmlzIGFib3V0IDEyOE1CPyBJIGNvdWxkIG5vdCByZWNhbGwgY2xlYXJseS4NCg0KX193ZWFrIGlu
dCBib2FyZF9waHlzX3NkcmFtX3NpemUocGh5c19zaXplX3QgKnNpemUpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KeyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBwaHlzX3NpemVfdCBzdGFydCwgZW5kOyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KICAgICAgICBwaHlzX3NpemVfdCB2YWw7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBpZiAo
IXNpemUpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgICB2YWwgPSByZWFkbChSRUdfRERSX0NTMF9CTkRTKTsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAg
ICAgICBzdGFydCA9ICh2YWwgPj4gMTYpIDw8IDI0OyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBlbmQgICA9
ICh2YWwgJiAweEZGRkYpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBlbmQgICA9IGVuZCA/IGVuZCAr
IDEgOiAwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIA0KICAgICAgICBlbmQgICA9IGVuZCA8PCAyNDsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KICAgICAgICAqc2l6ZSA9IGVuZCAtIHN0YXJ0OyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICB2YWwgPSByZWFk
bChSRUdfRERSX0NTMV9CTkRTKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBzdGFydCA9ICh2YWwgPj4gMTYpIDw8
IDI0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIA0KICAgICAgICBlbmQgICA9ICh2YWwgJiAweEZGRkYpOyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KICAgICAgICBlbmQgICA9IGVuZCA/IGVuZCArIDEgOiAwOyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBl
bmQgICA9IGVuZCA8PCAyNDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAqc2l6ZSArPSBlbmQg
LSBzdGFydDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KICAgICAgICByZXR1cm4gMDsNCg0KDQpSZWdhcmRzDQpQZW5nLg0KDQo+IA0K
PiBKb3NlcGgsDQo+IA0KPiBQbGVhc2UgYWRkIHRoaXMgZXhwbGFuYXRpb24gdG8gdGhlIGJvYXJk
J3MgUkVBRE1FIHRvIGhlbHAgdXNlcnMgc2VsZWN0DQo+IHRoZSBtb3JlIGFwcHJvcHJpYXRlIGRl
ZmNvbmZpZyBmb3IgdGhlaXIgdXNlIGNhc2UuDQo+IA0KPiBUaGFuaw0K
