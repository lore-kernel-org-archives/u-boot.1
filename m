Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA75E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 00:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 935AF8006D;
	Thu,  9 Jan 2025 01:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="b/sXq3BY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F59800D0; Thu,  9 Jan 2025 01:49:14 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 254D08001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 01:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzV4HROXA6wmjyiuow8d454+7oiilTuDJPVew25f4TQxJzGYVaSQls0X1+cnbdV3qhuILRwX9c4w+fhZepbeGtXr1WjM9FI9EDS7uPVGCeeO3r5Phq/cFB3CmfNiMl6RA7igxd8rvUqw0rK/DQnxqpmOmYeEYkG8FQvrfa0W6XW1upvl3gvGS16x0lhZjM+GaUA+K75yRcutDpHl9GOsyeN7OMop5KFWOYWEXPgwcOLz9pByZscGhUjTrWvsoJaXgbNRAJt8kjgYkzJY87ySjM9Sm4ThWbMwzJ5psCR35t8EjvcPqNzEKcLFf+xniW3FVHV71mvoBBuqhj7164apHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=862Fqf+x8RbJz4fj7gQ8sLg4lQYsGqs3wF2Vtoo+NLk=;
 b=cHa2fzBogjJSTLaEqYI3brf8qtM0IF0ne+9O3Z3oranSEW8wovLLA6LRflYaKqfQFVa063JRTA8VtG2yMDTAppRn5B/1CKVEHBdulNEyNbY2vlzmyWHHwRXZZKVhCE74Mm1d1jEaYYYuObt8mzkMearGw2obyK0wdDDUP5p1LC/kDjuYXdYC2/d+pxSzWsiyfo8V0uIq89+fEU8ORL3571FrB9pEzlBlT/s5sqjaMv4cZTrRDREfcvEtDCTk4bU9vLHfU1ZpPL+f7LV7aq99eIHk4t/7SgEf+eoyyphFKptxACF3i66ee2bkh2p/0+1gDpvetHw9HV4EGZScLb4puQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=862Fqf+x8RbJz4fj7gQ8sLg4lQYsGqs3wF2Vtoo+NLk=;
 b=b/sXq3BYASrwto3n7BwACw0pVXmhr+ZtNMihrXyEjwqzSl32/90JxtbzdOFq85cef3riiV6YL0w2ASjIFUKLbxR/rym2iJrR1t8+ENa9UnKlKet5SXvd5moSnX40WUnwIhZ6cdOZA2GpZ7Gb+2HP0eMeLfEHjhwzmgqcfTUwMdx31lwCjMfvQaLDIQvIXIa2q5c037GCyogM7B3jeeWKFk316JEKJIL/TP48mbCkB3De9xsm4qU5qBXs378cbd5dc4Dg8YM5eu9YYkFQNzW+e9Of/3b/clvlinsmq/qfA0qgJlZtBtBK/O7l3HEHqGlymMkXWUCKgDzrecmmtqCkqg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 00:49:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 00:49:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?UkU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtFWFRdIFJlOiBbUEFUQ0gg?=
 =?utf-8?B?djMgMDIvMTddIGZpcm13YXJlOiBzY21pOiBzbXQ6IEludGVycnVwdCBjb21t?=
 =?utf-8?Q?unication_enable?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAw?=
 =?utf-8?B?Mi8xN10gZmlybXdhcmU6IHNjbWk6IHNtdDogSW50ZXJydXB0IGNvbW11bmlj?=
 =?utf-8?Q?ation_enable?=
Thread-Index: AQHbXaskxsBsxS3nREu5830UMpr0SbMIrgKAgACb/gCAAPGYAIAAcFOAgACCRwCAAQgbAIABB2MAgABmZNA=
Date: Thu, 9 Jan 2025 00:49:10 +0000
Message-ID: <PAXPR04MB84597A7947C6019CAEC5C92C88132@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
 <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
 <PAXPR04MB964475AEF1CB007B5949088CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <dbfd7a78-06e3-4e42-961c-5130f1707f26@denx.de>
 <PAXPR04MB96441C57A9F06EB21FF1FF59E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5633e9ab-0841-4f1e-9810-743359ac9107@denx.de>
 <PAXPR04MB964422B7AB4E75400F36C017E2122@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <ab77f12a-35b3-4b26-a801-3db315aea1d2@denx.de>
In-Reply-To: <ab77f12a-35b3-4b26-a801-3db315aea1d2@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7930:EE_
x-ms-office365-filtering-correlation-id: 2e3757ff-e030-4f4f-370d-08dd30476def
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?YUNXNUJJaWd2Vkg2YzVjZUZEQmNsRHdKSkI5SCt2TWRxY0NLVzU4NmRTTWxJ?=
 =?utf-8?B?SFFad3NOMXZQNEllZnp0aXpieG50MGVIOG9YTFpUQzZ0aWFkUjBiQ3ZNeUN1?=
 =?utf-8?B?Ykk1OTlSbTRFZG81NnJxQlBBdlNRbHVVN1I5WjhadDk5dEpXUVJkeWxrNFMx?=
 =?utf-8?B?ckVnQTFZZmlKZGU4empDNDBEb1Y3Z0l4ZVBabzdtQzJlNVptUWhUaUJndHZC?=
 =?utf-8?B?WUQzYVJOVVlsY3dpWm9hSGpKZFhJQTdTL0kvR091QkpNWlh2UmlUMTJpNTE2?=
 =?utf-8?B?dDY0NDY0S3VKU0lETEViVnRyUXZVdXQ0ZjBZRk85MndGaENUNHVnR2FGQ1BO?=
 =?utf-8?B?L3dOd2RTbWpMSXkvNzZ2YytETTQ0aDI5NHBmUW9lUkFOLzVGTFVnWmRPTWc0?=
 =?utf-8?B?TG84L2RPOUNTQitZQVd0UldYdEZyZDhXNWJyZElXU09jUjc3YWQvWTllU0lC?=
 =?utf-8?B?M3ZzQ2tVbzZ2U2dka1NTdjIydHdJNXRKbXhoQXltRDFrclYwRnBTc3QzeHA5?=
 =?utf-8?B?NmlGdDVYdlFBM05nQnZkUm1OaWlmV1pLSUhBQ0ZDRTFzNUMzNDhFSlZldFNO?=
 =?utf-8?B?YTJ3cURyWGczVUkwTysxUGFCSnNZWFVBNkRXTDBJWDVZQWZ5VDh4aDc0dFkw?=
 =?utf-8?B?emxpQjd5ZE9ITFRwb2MwZzhJMjg2VlJCcjdlektYY1h1SStnMUNZWldQakor?=
 =?utf-8?B?TjVVY2Y0ampubHNObWVqTmFncWFSSXBNUFh2c2lqTzRsMldpdUVhYXpWcE1J?=
 =?utf-8?B?d3NQcUxDRllQSmNybm5qVkVRYk51MFk4UXJmMm5vTmZ6cDMydW5iS0x0SWsy?=
 =?utf-8?B?L0NVeVhzN2xURm9PcW1zMXd4QzVDOTFEZWU1dDNrZlRtQjl5YjJSUnlUUEJW?=
 =?utf-8?B?MG5yaUowUmRrTzI0L2xGWnEwRGRHSkNBOTg5U3E3ZUtyeFhaV0JGQ1BGK3JN?=
 =?utf-8?B?cWxEaFdLbkE5cEV0bGFMblFOMy91MUh1WjkydVpRQnNuK09YVzQvNU9rOTdP?=
 =?utf-8?B?VWl3T3p2RFZaeGJEK2lzWmd6V2pwcXZBWGhCMGh2aCtmakY4WVVpUU5WVUpk?=
 =?utf-8?B?d1piaWJ6Smp4bDFPdnRmcU9LL3pmMHV3ZERvREJrWTdBRTRRQjNzTlN4YTBo?=
 =?utf-8?B?QytUWmc3VGlQM2tRUFlSSXZOaU5aVlFLUVlzM2pLMFByckJCbDNQY3NnNmRx?=
 =?utf-8?B?V0RwUk9WN0FDQlNpZ1IxK1NKMGYyeWd6QmEzTGhhODNyWS9uTXNZVGdzNkNG?=
 =?utf-8?B?T1FabFhJR3c3cWx5eFRNSm1ZQWI1MG10WFRubzZyWEJicDdzR1k4RURUaElp?=
 =?utf-8?B?TDEwTUtPcjdlVlhiWDdiU0pScGZTY2ZKbUcxalJva0VIWXYrNXRBUXM5Ylp3?=
 =?utf-8?B?RXE1djkxc2FmL2NoclkrTkZ0UVpWUGZVMjA4cmw2VUJRa0txVEFiTVluK2ND?=
 =?utf-8?B?VkxsOFRUQTRWUkZHbXBxalBKTFJ1cW5tbzFJbXZGSWhrZlMvbTZ3NXRDMHJ5?=
 =?utf-8?B?c1dCR2M0TEUwMitnWjdmeEVHT0RmK0JHczgyTEZyWDVocjlOVC9NTG9USGJX?=
 =?utf-8?B?NUhzOGZUclFHanpZbVVOSHhKQVdZVGhVanNEbUZ0NHZVUUNmQUV0L25oSVRS?=
 =?utf-8?B?NDN5Q3IzUTBJQnJMNUtoemxhWWhuRzQyNzhIL1Fhd3pNQkozM0xMWjg2Q3ZQ?=
 =?utf-8?B?S3FqK2h3YlRrYmNJOG1BMGVEVTJLYTR2Ym5EVmFzQ2dYZ3Y1TWN0SExaZnZ5?=
 =?utf-8?B?V2ZuZ0hka0luamlqVDRkN1NrU2pmcksvNjVSd3gwZTkxU0NxeDFYSmNyUW1n?=
 =?utf-8?B?TytGc0NOQm5jeEhkNDg3eXZCWitzOTBaY2RleFdKSW9yUVNGTFpEZHNWUGZs?=
 =?utf-8?B?Vnp2QmcrenZmbEVkd1VFSVJPODBlTDdnbGlJUDFXdk4yV1lxSWtKSjVxT3ZW?=
 =?utf-8?B?MUVDdHJSbmdBVTF5QWlMNXNSSzlmV01XdEFzeXF0ekpGL1Q2bFo5dVFOdjJ4?=
 =?utf-8?B?cTdLR2RXU0pBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDRNZlVMVHZ4MDgxMlZka28rRmRjdVZzdXZEUG1ndmdaYmF1bjBUakx0dkZX?=
 =?utf-8?B?REJMOWNNYmZFb2RWTlllWk5NOGNORElBa2F5S0tRaEl1UzlCSFYzcE1ESWlQ?=
 =?utf-8?B?eFVWNjRWaU5yR3hRQzg4UmFRc2M0YVlTUTR6NGY2eHMydmRkVGR4b1YzRUt6?=
 =?utf-8?B?R2dpN2RqTnJhSUNwa04rNEwrVnh6R0UzUTJrajQzMytONWFYL1dKMWtpVFFP?=
 =?utf-8?B?b1lZQ0VlL0doZit6cmRoVjdQbm1PWlF6ZjZGN3p3alIrSW5PRlpMTWVnM24r?=
 =?utf-8?B?Q2xTVERaMGpIQ0QxSENQczVQbCs3QXdJbmVMd3RIWHdITVJNRmdRbnBCMkVF?=
 =?utf-8?B?WTM4QnNwTVNTTXFaUFJBdHY4YUlKSis1aXFKdFBwSFNUZE9wOGdvMjBFV3d6?=
 =?utf-8?B?Tjk2QmI3NXJibHdRL0g2QjltYzVGL3FoaVN3U2dsNDNiWUNEL1BkZUJpZEVV?=
 =?utf-8?B?WTRPR21ES0g4OERwVUFoMzFNMEdwMUhLNENKWlpzUzlNSk52K1BDMGdZUDZp?=
 =?utf-8?B?MGxTSWQxRFoyd0h0UTJ2bjdkVUM2VWhjUWsvZEphSXM3OVVVTHh4NGtEOXA3?=
 =?utf-8?B?OEhONmxHdUpkUWRCMlBja2F3U1VmbWdrMEFsS25STjJCRFFJQjdzeFJFUkFo?=
 =?utf-8?B?SmF6eFBNTFFKSGVvSHEzR09BdTNURXhibDdMTTlpL1RmSXUyTlBqN3diNG1Z?=
 =?utf-8?B?OWpQZWhuUnFLcUMwcnRCeXB4dE5QWGJhNVZpbXNnbzYwZjc1blhOR0ZkeGdk?=
 =?utf-8?B?aVR5NE1aY0djYWJWRll3TC93OFlxVkxOR3B6cE02RkE4TnpRNVEzUUZhVVd6?=
 =?utf-8?B?dm8ydVV3aTNLendMbnlPWDB1ZTVPUGlKU3FpT1NPdENFSVF3YWFZWG03d1kw?=
 =?utf-8?B?cjVWU3dWRzJPb3JYVGs3dTZwOUdlcnhMRDRKMlFKVGRJcTIvdWRKKzNZZk0y?=
 =?utf-8?B?RmdMeGp6Z3hrUHBaME5PNU4vdEd5U0lXay9xOFZxeGhpajhtMFgrckRJYkpI?=
 =?utf-8?B?VHd2anc5UjFRdnJQVHFpdmprdlh3MW03SURpMTZWeVdsblFEVmN2aENNZm9G?=
 =?utf-8?B?WmNXQk5xbVR1SWFhVnBVeWJyQmR3TkJBQ0E0bG51ek9wR3ZTM3JTV1pOejIw?=
 =?utf-8?B?eW9FK1JCeHZ5OVppVjRNdVoxNUZqZlFrN0hUSXhDb2FSTnNHUkwrZTY2V3A5?=
 =?utf-8?B?WU1aYWZUTWdvWWZrUmZXdk93U1NPTHY5YVRjRHZ3UUt1a1lzWnBkSXJEVFFU?=
 =?utf-8?B?VzFLQk14UFhPQ3ArMWhvbDlqVDB4R3RSaVliREptajVwOHpiVDVNdk5lVy9B?=
 =?utf-8?B?Qmc5T0xaVmJialVhN0NPWE9MMWViSDNjUXJvVEpsNENuNUd4M28xRjNTMElP?=
 =?utf-8?B?SkRTT2syWCtuakdLWEhrRlRiandyNXZPb0VlNEFrNFgvNVVQMmUrcU0rS2V0?=
 =?utf-8?B?OWRxTmpsT2hmdHhpS25ibTE3L0QvckY2Rm94N2VEai9JMkVvSUtuTkR0MlBm?=
 =?utf-8?B?c3VuVjNHOGNvaUNUMnM5UTJmTkFuenpPdVpoM2VCY1NUUUM3TEpOeFZ6eXE3?=
 =?utf-8?B?d0Ira0VrRG45UWx2Q2cwOUhHbGZ0TWp6ZWtLV2phRHMyL3VWMlhLbFFRTmZz?=
 =?utf-8?B?eWlBeG9qVHVoNmtSaDhZc2dtbmV0Nk9sZG8rQ21MZDF5OFVkSXJCVUpCNUNL?=
 =?utf-8?B?OUlHZmpsbGRHQzVRZHpXRjVUakd5SzBVWkFDNHBwV1BhVmxyUmFrR3JLM2Z1?=
 =?utf-8?B?bWJsTllnZitQZlZhdjRPWEliK2hINGxHNzB1eXlXWDRCY3lqK0t2L1JWTWRU?=
 =?utf-8?B?YVd4Ym5kbkRQaE96dTN4Z1pVcGEwMkE3Z3J3UG03ZTRoN21SWHVyeStXc2Uy?=
 =?utf-8?B?bkhnbjVjK3FQUmFmbU04WmRHWHpRSUl1VHZIcEdNbGU5VklmNGlzSmhJTVRw?=
 =?utf-8?B?REwrYmRScklGaFBSWGxRNDJWOVNDQjM2SzZudnRMRFhaZ25tazM5MS9rTmF6?=
 =?utf-8?B?S2I5QWtMNDVaV0g2cmpkTjdJTGoxV0FXMHBQcVR3Sy9TNG1DekVYUld4dXVy?=
 =?utf-8?B?OG55Zko2YWQxZ21FTWhmSmlPdDUwTWpOVmRrTUUwNmlQdjVXOU44b2Nzd2x0?=
 =?utf-8?Q?IzLc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3757ff-e030-4f4f-370d-08dd30476def
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 00:49:10.1403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t45XudCAkKb2x0eklPMoqTR7EfnZZKjUtuhREUoFCgBYA+tanaKJcuvBN1XQJYM4gsXXaOn2Y+CnRhnFr59iIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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

PiBTdWJqZWN0OiBSZTog5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2
MyAwMi8xN10gZmlybXdhcmU6DQo+IHNjbWk6IHNtdDogSW50ZXJydXB0IGNvbW11bmljYXRpb24g
ZW5hYmxlDQo+IA0KPiBPbiAxLzgvMjUgMzo1NSBBTSwgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0K
PiA+PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+ID4+IOWPkemAgeaXtumXtDogMjAyNeW5tDHmnIg35pelIDE5OjEx
DQo+ID4+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+
OyBUb20gUmluaQ0KPiA+PiA8dHJpbmlAa29uc3Vsa28uY29tPjsgU3RlZmFubyBCYWJpYyA8c2Jh
YmljQGRlbnguZGU+OyBGYWJpbw0KPiBFc3RldmFtDQo+ID4+IDxmZXN0ZXZhbUBnbWFpbC5jb20+
OyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsNCj4gTHVrYXN6DQo+ID4+IE1hamV3
c2tpIDxsdWttYUBkZW54LmRlPjsgU2VhbiBBbmRlcnNvbg0KPiA8c2VhbmdhMkBnbWFpbC5jb20+
OyBTaW1vbg0KPiA+PiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IEFscGVyIE5lYmkgWWFzYWsN
Cj4gPGFscGVybmViaXlhc2FrQGdtYWlsLmNvbT4NCj4gPj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMu
ZGVueC5kZTsgdGhhcnZleUBnYXRld29ya3MuY29tOyBWaW9yZWwgU3VtYW4NCj4gPj4gPHZpb3Jl
bC5zdW1hbkBueHAuY29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+DQo+ID4+IOS4u+mimDogUmU6
IOWbnuWkjTog5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAyLzE3XSBmaXJtd2FyZTogc2Nt
aToNCj4gc210Og0KPiA+PiBJbnRlcnJ1cHQgY29tbXVuaWNhdGlvbiBlbmFibGUNCj4gPj4NCj4g
Pj4gT24gMS83LzI1IDQ6MjQgQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gPj4+PiDkuLvp
opg6IFJlOiDlm57lpI06IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMDIvMTddIGZpcm13YXJlOiBzY21p
OiBzbXQ6DQo+ID4+Pj4gSW50ZXJydXB0IGNvbW11bmljYXRpb24gZW5hYmxlDQo+ID4+Pj4NCj4g
Pj4+PiBPbiAxLzYvMjUgNzoxNyBBTSwgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiA+Pj4+Pj4g
T24gMS8zLzI1IDc6NDUgQU0sIEFsaWNlIEd1byB3cm90ZToNCj4gPj4+Pj4+PiBGcm9tOiBWaW9y
ZWwgU3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gV2hl
biBpbnRlcnJ1cHQgZHJpdmVuIGNvbW11bmljYXRpb24gaXMgc3VwcG9ydGVkDQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4gVS1Cb290IGRvZXMgbm90IHVzZSBpbnRlcnJ1cHRzLg0KPiA+Pj4+Pj4NCj4gPj4+
Pj4+PiAsIHRoZSB0cmFuc3BvcnQgYWxsb3dzDQo+ID4+Pj4+Pj4gdGhlIGNhbGxlciB0byBjaG9v
c2UgYmV0d2VlbiBpbnRlcnJ1cHQgYW5kIHBvbGxpbmcgZHJpdmVuDQo+ID4+Pj4+Pj4gY29tbXVu
aWNhdGlvbnMuIFRvIG1ha2UgdGhlIGNob2ljZSwgdGhlIGNoYW5uZWwgZmxhZ3MgYXJlDQo+IHVz
ZWQuDQo+ID4+Pj4+Pj4gaS5NWDk1IHVzZXMgaW50ZXJydXB0IGRyaXZlbiBjb21tdW5pY2F0aW9u
IHNvIHRoYXQgQ2hhbm5lbA0KPiBmbGFncw0KPiA+Pj4+Pj4+IHNob3VsZCBiZSBzZXQgdG8gMS4N
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiBIb3cgZG9lcyB0aGlzIHdvcmsgaW4gVS1Cb290LCB3aGljaCBk
b2VzIG5vdCB1c2UgaW50ZXJydXB0cyA/DQo+ID4+Pj4+DQo+ID4+Pj4+IEhpIE1hcmVrLA0KPiA+
Pj4+Pg0KPiA+Pj4+PiBUaGUgY2xlYXJlciBleHBsYW5hdGlvbiB3aWxsIGJlIGFkZGVkIGluIHRo
ZSBjb21taXQgbG9nLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGlzIGlzIGJhc2VkIG9uIEFybcKuIFN5
c3RlbSBDb250cm9sIGFuZCBNYW5hZ2VtZW50DQo+IEludGVyZmFjZQ0KPiA+Pj4+PiBQbGF0Zm9y
bQ0KPiA+Pj4+IERlc2lnbiBEb2N1bWVudCBWZXJzaW9uIDMuMiAoRG9jdW1lbnQgbnVtYmVyOiBE
RU4wMDU2RSkNCj4gNS4xLjIuIFdoZW4NCj4gPj4+PiBCaXRbMF0gb2YgQ2hhbm5lbCBmbGFncyBp
cyAxLCB0aGUgU3lzdGVtIE1hbmFnZXIgcnVucyBvbiBNIGNvcmUNCj4gPj4+PiB3aWxsIHRyaWdn
ZXIgZ2VuZXJhbC1wdXJwb3NlIGludGVycnVwdHMgdG8gQSBjb3JlLiBVLUJvb3QgcG9sbHMNCj4g
Pj4+PiBHZW5lcmFsLXB1cnBvc2UgU3RhdHVzIChHU1IpIHVudGlsIEdJUG4gaXMgc2V0Lg0KPiA+
Pj4+IElmIFUtQm9vdCBkb2VzIHBvbGxpbmcsIHdoeSBkb2VzIHRoaXMgYml0IG5lZWQgdG8gYmUg
c2V0LCBzaG91bGRuJ3QNCj4gPj4+PiB0aGUgYml0IGJlIGNsZWFyZWQgaW5zdGVhZCA/DQo+ID4+
Pg0KPiA+Pj4gTXkgY29tbWl0IGxvZyBtYXkgaGF2ZSBjYXVzZWQgeW91ciBtaXN1bmRlcnN0YW5k
aW5nLiBJZiB0aGUgYml0DQo+IGlzDQo+ID4+PiBub3Qgc2V0LA0KPiA+PiB0aGUgU3lzdGVtIE1h
bmFnZXIgd2lsbCBub3QgcmVxdWVzdCBkb29yYmVsbCBpbnRlcnJ1cHQuIFRoZQ0KPiBmb2xsb3dp
bmcNCj4gPj4gaXMgdGhlIGNvZGUgZnJvbSBpbXgtc206DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAg
ICAgICBpZiAoY2FsbGVlKQ0KPiA+Pj4gICAgICAgICAgICAgICB7DQo+ID4+PiAgICAgICAgICAg
ICAgICAgICAvKiBHZW5lcmF0ZSBjb21wbGV0aW9uIGludGVycnVwdCAqLw0KPiA+Pj4gICAgICAg
ICAgICAgICAgICAgaWYgKChidWYtPmNoYW5uZWxGbGFncyAmIFNNVF9DT01QX0lOVCkgIT0gMFUp
DQo+ID4+PiAgICAgICAgICAgICAgICAgICB7DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAg
c3RhdHVzID0gUlBDX1NNVF9Eb29yYmVsbFJpbmcoc210Q2hhbm5lbCk7DQo+ID4+PiAgICAgICAg
ICAgICAgICAgICB9DQo+ID4+PiAgICAgICAgICAgICAgIH0NCj4gPj4gQ2FuIHRoZSBTTSBiZSB1
cGRhdGVkIGluc3RlYWQgPw0KPiA+DQo+ID4gU3lzdGVtIE1hbmFnZXIgbm90IG9ubHkgaW50ZXJh
Y3RzIHdpdGggVS1Cb290LCBidXQgYWxzbyB3aXRoDQo+IExpbnV4L1FOWC9SVE9TLiBTeXN0ZW0g
TWFuYWdlciBjYW5ub3QgYmUgY2hhbmdlZC4NCj4gSG93IGNvbWUgb3RoZXIgU0NNSSBwcm92aWRl
cnMgKGxpa2Ugb3B0ZWUpIGRvIG5vdCBuZWVkIHRoaXMga2luZCBvZg0KPiBjaGFuZ2UgPw0KDQpD
b3VsZCB3ZSB1c2UgYSBLY29uZmlnIG9wdGlvbiBoZXJlLCBzYXlpbmcgQ09ORklHX1NDTUlfSU5U
Ul9FTj8NClRoZW4gdG8gaS5NWDk1LCBzZWxlY3QgdGhpcyBLY29uZmlnIG9wdGlvbiBhbmQgbm90
IGJyZWFrIG90aGVycw0Kc2F5aW5nIG9wdGVlLg0KDQpUaGVyZSBpcyBsZXNzIGNoYW5jZSBmb3Ig
U3lzdGVtIE1hbmFnZXIgdG8gY2hhbmdlLiBJZiB5b3Ugd291bGQNCmxpa2UgdG8gZG8gc29tZSBj
aGFuZ2UsIHlvdSBjb3VsZCBkbyBhIFBSLCBJIGNvdWxkIGFzayBvd25lciB0bw0KZ2l2ZSBhIGxv
b2suDQoNClRoYW5rcywNClBlbmcuDQoNCg==
