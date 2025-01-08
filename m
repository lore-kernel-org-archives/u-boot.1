Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAA1E77198
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 02:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771408036B;
	Wed,  8 Jan 2025 03:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xK/uoU0Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531FB803DC; Wed,  8 Jan 2025 03:55:57 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150BA8007D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 03:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMN/l/aYYr7KhxyNknjwJjTs9+wldUIuWRS4IItBlXVDpRCueZZEj/9X1H18Ijnoz7pOL4Pilghekp07GqnpfIiPOw4P50FJqSm88HtpmHL59iMU1gKASaesjCbMXb5CxnvX5mzi27/ZWT39uxLM/VShs4zHWG63BNBQf5Kry4wQQoyR/6/8N8T6J7Kziavq27fTj0+tpCi8uv8J9ufHnOjS1pKLstevWokUVIDgQk3P8keNvHwBS4wcC1+EQ/fwe9g+5cszIy4qa0cQvw3h8xfnrPNdkWBZjh+gNLLQYyGPOixSXk5uvsdTCPKLL10WEeRcUqNzVoeLAQPqD8/knQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH92itv9RZs2Dfa2Uxpl1On3nmpEPhLpQliLmlmGRAY=;
 b=h/kiNvitawJoCDV3lsLmT+b4nplhImnPsP4q6bxbwxPr/QSKKXDYRiLRjjuapAn4wcS53QwFp1gXqEKsMkZr2I10+Zw6OVf4B0eL52A0bONCsuquFHLdpRsOpct08ifQNQN0nHNzwWPuE7aW/zMeT7QHLuGw5oKU4wKh/OOcYD5lawHX7R9brW+uPWr1dUmojReBNE0UShDzCEH5tLkBHPk9ZcURwg4rDTME7ol1LDB81mVCdEapmqB5tpJvA+X2awq/VPl9sfOLda8lu+ANTvgEaV0psTkWoogEfKXa9hHwDJvWlyLl4K2yKPeIhEm8KAS9W91JF3j8oor0jmIUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH92itv9RZs2Dfa2Uxpl1On3nmpEPhLpQliLmlmGRAY=;
 b=xK/uoU0Qm2rqkGmMOGvB8keB6ygaGgvblPQ/QQ6YxQrK41uVzAHUcJLlDM+926zOQEn6nQh+ghJtFemancZDF8Drvdk5rab2bv/JzN9Q19wq8x1ps1cMZD5zFEgWkB2mJZzLDrJpLiYKMV90OzxTxt8jBHFQusV9SpvBJZS5n3lMZK6WOWczCm/f+II6igFXtupozfRTMdwRjLTC9ZnEWkuhfbo5QSuugswmi7nSOZu8uWvtFMPvv3vBZvQrCT3IMBqhXe3WgDVCQ5+SBAAZZm3q3TM6yyMbX7AzeE6V9VxXMJRXuWQVpgdkw+OcoCbrMJfYS1Ep3dSFASgUmdpL+A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10407.eurprd04.prod.outlook.com (2603:10a6:150:1e9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 02:55:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 02:55:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAw?=
 =?utf-8?B?Mi8xN10gZmlybXdhcmU6IHNjbWk6IHNtdDogSW50ZXJydXB0IGNvbW11bmlj?=
 =?utf-8?Q?ation_enable?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMDIvMTddIGZp?=
 =?utf-8?B?cm13YXJlOiBzY21pOiBzbXQ6IEludGVycnVwdCBjb21tdW5pY2F0aW9uIGVu?=
 =?utf-8?Q?able?=
Thread-Index: AQHbXasjFNU2xPM51EuHJGhVQiV3ULMIrgKAgACb/gCAAPGYAIAAcFOAgACCRwCAAQC3oA==
Date: Wed, 8 Jan 2025 02:55:48 +0000
Message-ID: <PAXPR04MB964422B7AB4E75400F36C017E2122@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-2-6744df5dc020@oss.nxp.com>
 <1bc61bdc-2ecd-4705-9873-8e0e3257a6a8@denx.de>
 <PAXPR04MB964475AEF1CB007B5949088CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <dbfd7a78-06e3-4e42-961c-5130f1707f26@denx.de>
 <PAXPR04MB96441C57A9F06EB21FF1FF59E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5633e9ab-0841-4f1e-9810-743359ac9107@denx.de>
In-Reply-To: <5633e9ab-0841-4f1e-9810-743359ac9107@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GVXPR04MB10407:EE_
x-ms-office365-filtering-correlation-id: c17f0f38-0a79-401e-93ce-08dd2f8ff47c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?RzYyaCtMNmc5MVlzOG1YTTViN0t6VWVLcWRrUHZ2cTBDZVNoaXM0SlJhTzFJ?=
 =?utf-8?B?Z2pGVHA2UXVqaDF3bitzOWIyUjN2SDVYU2hZKzZ2M0M4bVlNNnJLcm5nYisw?=
 =?utf-8?B?WkRUTzUxdlk0aEJ1allDZm5vNTMwSldabWlIUDVrUUtCMHVEbmVZdUlhKzU5?=
 =?utf-8?B?ekxrV1F1VzN5U0VVeHBLcFhadHdrd1lvbFhKL2pHTnVraVpuUjVINE52ZGhp?=
 =?utf-8?B?Q1JNZFdpNlJEMk8zUnhTdEtBb1FFU21Rc1RIQWVUTE1Sd08vem1NbjVYTjdJ?=
 =?utf-8?B?WE1odFpDMXU0WUJqZm5QTHFoVDExVTZuT3VFWUw1bEM3VnhaMzV4NmthbTV2?=
 =?utf-8?B?Z0pCcmowNVlhY01yQ2VBV2hqd2luYnZ5RWFjb2hsdDhMZjlXVFQ4WDZLOXVs?=
 =?utf-8?B?Y3U1T1N1aGNIUnI1V1ZncVV3RFNkbk5uRG5GV09uamhpdGVuRVhnOGVZUDRV?=
 =?utf-8?B?SHAvd2pmbURSL204R0pCQlNidUYrZ21EaXBPQUN1cEN3T2UwT203bzhuaG5i?=
 =?utf-8?B?Z3VaUVF4VTBLNG9KVFJvdGFVZWVTUjFJT3V0MjFpTStOVThGeFlubk43VlEw?=
 =?utf-8?B?dUtaclp4MExJaGNFRkRQRjZ4ZHptbmNjSktuY3p2cFBuT3R3ZkVuK1FGdHJo?=
 =?utf-8?B?NnNtdDRsS2FNaVIrbFFsbzZnTGNwS3liNjd6aEptcWdiVTF1ZUNMblBDeGJV?=
 =?utf-8?B?MUM5RWQ0enZXbDRQeStCbVRXQnhTL1cyK2ozMTdyc2xDR3lTeHVZSjNNcVho?=
 =?utf-8?B?M1FJY3d4N1o2Vnplb3hUM2lwMTJHUmJEWkkybitYMXFDc0REbU9NN05QbXFz?=
 =?utf-8?B?Y3QwdVV1ZVZqWm9aUExVT3ZJcFhNaTRGd2Z2YjRrcXlwYklpb1Q2dzBRdnpy?=
 =?utf-8?B?QWZ6Z1RjTGN6SWtsZ0ZSTU5oWW1wRUU4M2lxcFRJOWE0eE9KdFJBOEthMTJu?=
 =?utf-8?B?THJCYU12SzdndnJ3VTR0aUw4V0hmcE0xY2t2QzlkWThBaFpwQ3RrRzFOVC9o?=
 =?utf-8?B?MFhRZE9vOU5jZjJ0bWJNSGFvNHo2MENHeEZNKzVpOGN5dUkxbFBZWlJiR1pw?=
 =?utf-8?B?ZU10em5JUHJOQ1g2dWpFa0NDM2pBRzVGOFR0RlkvR1VTemtPNFR3Q1lhVW5B?=
 =?utf-8?B?bm40NlA1T1NuVnYrQWFoTVNPc3liU2g3aTJ6Y1hzVkpEM2dHUGdHbWdsYkJF?=
 =?utf-8?B?MXozcDI5NG5TWm5VQVBWeWc3S29JTHRFQTBLaWZod25NUTBoenZGQmg2a0dF?=
 =?utf-8?B?L0xPUDVZdUYrOWROaXJXOC9tQ2dHOUNTWWJYblo3R3cvUHFPak8rOS83a200?=
 =?utf-8?B?WHVHdnZpb2NnOUFja2V0YzdQY251SnYwSGN6cFJtT1F0RXBMdTJWcWlHTmJW?=
 =?utf-8?B?UHZqVE1CYW9vNS9iM25UVzg0WlMvTUdRSVg2SkZBVTVIQUovZVdVQUhGUWkr?=
 =?utf-8?B?U1lhVFRTL013T1YwTFZhQzIvR3ZUellXVVRoTDkyS2wycWxCbEN5VFVsRzY2?=
 =?utf-8?B?ajl5dFFQMTV1aVZSRXBGbkJYN0liNDUxZ1F3OVU0c3dEc0k4L0s0b0xhcW41?=
 =?utf-8?B?U005Y3lSREIzQ1dSdW5SWUlkdGIwb1hJdVhYZERwRmVTYWtid0xEeU8xNmVJ?=
 =?utf-8?B?MUZMVUFxejhmakRkc2NCVHlPT29xT2pZWUhwcjZ3OFJjU1B2Znk1YVdadUtL?=
 =?utf-8?B?MmtrR01qRGIwd1VEWTBaRXY3YUJaci94ZnVIM3E0aCtaSzRvZVVsdnNLcTJJ?=
 =?utf-8?B?WStpd0VWUm1FUkcySFlJc2xZNS9KSEoxNDVFc3gzUWppc20wNDUyOGlNYlhH?=
 =?utf-8?B?SEtZZUZDM1F6RXZxeWJ0UjNZTDhoNEdiclp1c0Ixbmwvc1BoWDZEdUpWVTJh?=
 =?utf-8?B?QThwY0VKZk0xaUtiRGl3NFhpYzlkNkhiRjNrSGVjMDJMVzd4V0lRN1ZXQWxE?=
 =?utf-8?B?bUhidDMxZlNGSGhYdFZ5c2hiaXh4Q2xvZTNSanRZV2xRa2pHOFlLbCs3LytO?=
 =?utf-8?B?WjdDbFB2ZGx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE50dkprRGxPYjRmbFphVmFyQU93emFFc2tob1Y4RTdJZ0dNWVU3c0FVYllu?=
 =?utf-8?B?Y3BvVUFTd1F1MXhtQ1FzcHRQb2xqWE1SbC85Z1ZHbWoyR3I4a1V3K0NyUm9Y?=
 =?utf-8?B?MVdIM2JIWEhyTktWSG9KMEgrZm5MdHhERkZqK2h2ZFJ0UWhpZFliTTFJOU5D?=
 =?utf-8?B?UWI1YitjclZvM0hRYXNQaEJ0dy8vRzBpN2ltL05xY3M2M05aRkNUeG5LZG8r?=
 =?utf-8?B?QjlySHYyNUdGUHRGZzhXV2JBT1hTdE9vdlhrM3JSTlpJVUNxRzJPVjBZcVUz?=
 =?utf-8?B?MlZreXp0MmJyRjNGeTdRWkRPSEFuenh3QkM1STd5RjdvWVhtb2RlSlYxR3lz?=
 =?utf-8?B?ZlJ2NDFkcmdBRHhHMzk1OFBEd2l4Rzl5UjVweWUyeHdLd2pkUkdJc1JEbDFY?=
 =?utf-8?B?UE5hSXMwOUloQnN6YldnMjdLc1VBS29Ca0JzamJCL0dLc3hDNmlpcTBmRXk2?=
 =?utf-8?B?VmZKU2VNWUN3THFiWnBJeCtGYjB5TTdzY0FoMHV6SWVnVnNpaFpIWTh3Vzdu?=
 =?utf-8?B?eVZvWnB4QUE0YnllL2ZZSnh1dFlvZVNyTi8xRisvaUF0TlFGZDZ6a1liU2Z5?=
 =?utf-8?B?UWFpcmk4WWhvdUpUZUgza1VDcnU5cURHV3JzMDBBbDFnMGxVZHRxSm1EeS9D?=
 =?utf-8?B?dVlXb0tmc0phNmhzazhnam9VeTd1T2FjUktuSkl0UCtKYjM5WlcxVDlDK0t0?=
 =?utf-8?B?ckpzRGhZbndFa21oL0Q5c0JCZllRMDFSNk5PM0tJQlZhMHpjc1owcEx3ektT?=
 =?utf-8?B?aVhnTnQ3Ym9YSFpYdEsxSWpVcEtEMDlBQW1iK3pQSDhGYmlWZ04xMk5kckJF?=
 =?utf-8?B?SytsWTNsVUYrUlFYc0NHU1psYlVqSVM4TVRyUDIrZVRUOFFLL2pQYU1URnJB?=
 =?utf-8?B?amo5a3hPUEsrb2hYTmFmKzN0dUs4bjFzZ2I0OHU5QnNPUDJuTlU1TXd2aGc1?=
 =?utf-8?B?bmNrOWRMRzB0NGQyek9yRW93VFFqU3lpTm1WQ2ozWFFVTmdEbVhzMUVySm14?=
 =?utf-8?B?N3BmZS8veEZQd2FpQmlWTzVIZXovZWhKT2lnRklJWW55S0pKZEJva3Z4V0Vm?=
 =?utf-8?B?N1V5RGtiZUVpdXZxK1F2K1RaNzUvNTNrK2JHYys5Q2UwcU1mekJoaXRYeFdT?=
 =?utf-8?B?V2R2ZlRWTExqUm5nKzJjamlXTTA2b3ZaNEhvTFk2RFpFUk5ZcHNJQUxmSjJK?=
 =?utf-8?B?NzB1eTdmQWpqOGFpeDNuZXd3amtwMFBRalVqVEVlM0lMLzJzbFJWVXdzT1c3?=
 =?utf-8?B?ZXdzcFpQNjBkNlRlaktMbFpGRHBVSlpDUUFncVJFMHVOQ2lMcGxKSEdPUDgv?=
 =?utf-8?B?cHdlYStHcUZTdnB6Nk1RTTN3dk42ZjhPMzJUamoyelFXYnhFTHpVNjB0ZXVH?=
 =?utf-8?B?Y3NacjFremVMek56ZG5LbnFiVnFyU2I4dVp0Z0h1dTR3YmxaNEVnYTkrWXVw?=
 =?utf-8?B?ekVSWFdVYkFmUjFJSXg2VTZSOGdmS3BLSStmOTVyUDFxZHd5RURPVXp3WEtv?=
 =?utf-8?B?UjNjaDVEOXozM2dxZ2w1eVVOVldqTlB1MkREZmhTTGRZSFZNOU5zMmR3L1VZ?=
 =?utf-8?B?MjBBVnZsZktDWnMvNHd5eTBvWEJ0bmJmZGplUkUwSzB4UHpvMEcvMWJJUnFi?=
 =?utf-8?B?UHJjaDJHd1RKRFZWOUY4ZVVwRVU2eEJLdGUzK0FVbGJxUGJVbkZhaEJ2MDVM?=
 =?utf-8?B?NlgvVjhQTWEzNnZiNDlKZ0RaRzExRWVjUzJ5TDF1dVNGT24vYit6S0ovdXFB?=
 =?utf-8?B?WmdFRnJOWG1nUjF5TjdiSlZhUWZka0hTZURCTjNGMFkrYkZDL0ZvalJBTlNH?=
 =?utf-8?B?d0hVdHlMaDJwRC9qUm5vLzl2ZmtESDBGS3JTQjJTMFhJRzVwODMwdkQvOEds?=
 =?utf-8?B?Yit3VGJSYnpoSWJVeVMySlRoL2hKYm1UKzhLOXliVzV5aXQwRHRWSVM5bm1S?=
 =?utf-8?B?UXgyM2ZadEJmdWNoS2IyVk1LRXJ3bUxKc1o5UGtEcjdjc0JFdXBldFNCQVdL?=
 =?utf-8?B?Sms3SlNnaDlmZ1dvUU1XeG5GV0czMnVrTWZwaE5kQjAzN3M5MGNwcGkxVkxi?=
 =?utf-8?B?MkU2SlRQd2YzdGV4K3dRT051bFMrYks3WjJ1K0pCNzBxMUdBT29hK09jSG5P?=
 =?utf-8?Q?ps2rNmYvEoZAzZgAygCjQc3gi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17f0f38-0a79-401e-93ce-08dd2f8ff47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 02:55:48.4989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mj+HjWfwMLhTY01PMnV9oU+g6a1zqx7JQbEm0kB/HL+QKvjpIkVidRsVYoM3+37lTKekgirPVqsso2Z2zdApng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10407
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDHmnIg35pelIDE5OjExDQo+IOaUtuS7
tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBUb20gUmluaQ0K
PiA8dHJpbmlAa29uc3Vsa28uY29tPjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+OyBG
YWJpbyBFc3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC11Ym9vdC1pbXggPHVib290
LWlteEBueHAuY29tPjsgTHVrYXN6DQo+IE1hamV3c2tpIDxsdWttYUBkZW54LmRlPjsgU2VhbiBB
bmRlcnNvbiA8c2VhbmdhMkBnbWFpbC5jb20+OyBTaW1vbg0KPiBHbGFzcyA8c2pnQGNocm9taXVt
Lm9yZz47IEFscGVyIE5lYmkgWWFzYWsgPGFscGVybmViaXlhc2FrQGdtYWlsLmNvbT4NCj4g5oqE
6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdGhhcnZleUBnYXRld29ya3MuY29tOyBWaW9yZWwg
U3VtYW4NCj4gPHZpb3JlbC5zdW1hbkBueHAuY29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+DQo+
IOS4u+mimDogUmU6IOWbnuWkjTog5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAyLzE3XSBm
aXJtd2FyZTogc2NtaTogc210Og0KPiBJbnRlcnJ1cHQgY29tbXVuaWNhdGlvbiBlbmFibGUNCj4g
DQo+IE9uIDEvNy8yNSA0OjI0IEFNLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+ID4+IOS4u+mi
mDogUmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMi8xN10gZmlybXdhcmU6IHNjbWk6
IHNtdDogSW50ZXJydXB0DQo+ID4+IGNvbW11bmljYXRpb24gZW5hYmxlDQo+ID4+DQo+ID4+IE9u
IDEvNi8yNSA3OjE3IEFNLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+ID4+Pj4gT24gMS8zLzI1
IDc6NDUgQU0sIEFsaWNlIEd1byB3cm90ZToNCj4gPj4+Pj4gRnJvbTogVmlvcmVsIFN1bWFuIDx2
aW9yZWwuc3VtYW5AbnhwLmNvbT4NCj4gPj4+Pj4NCj4gPj4+Pj4gV2hlbiBpbnRlcnJ1cHQgZHJp
dmVuIGNvbW11bmljYXRpb24gaXMgc3VwcG9ydGVkDQo+ID4+Pj4NCj4gPj4+PiBVLUJvb3QgZG9l
cyBub3QgdXNlIGludGVycnVwdHMuDQo+ID4+Pj4NCj4gPj4+Pj4gLCB0aGUgdHJhbnNwb3J0IGFs
bG93cw0KPiA+Pj4+PiB0aGUgY2FsbGVyIHRvIGNob29zZSBiZXR3ZWVuIGludGVycnVwdCBhbmQg
cG9sbGluZyBkcml2ZW4NCj4gPj4+Pj4gY29tbXVuaWNhdGlvbnMuIFRvIG1ha2UgdGhlIGNob2lj
ZSwgdGhlIGNoYW5uZWwgZmxhZ3MgYXJlIHVzZWQuDQo+ID4+Pj4+IGkuTVg5NSB1c2VzIGludGVy
cnVwdCBkcml2ZW4gY29tbXVuaWNhdGlvbiBzbyB0aGF0IENoYW5uZWwgZmxhZ3MNCj4gPj4+Pj4g
c2hvdWxkIGJlIHNldCB0byAxLg0KPiA+Pj4+DQo+ID4+Pj4gSG93IGRvZXMgdGhpcyB3b3JrIGlu
IFUtQm9vdCwgd2hpY2ggZG9lcyBub3QgdXNlIGludGVycnVwdHMgPw0KPiA+Pj4NCj4gPj4+IEhp
IE1hcmVrLA0KPiA+Pj4NCj4gPj4+IFRoZSBjbGVhcmVyIGV4cGxhbmF0aW9uIHdpbGwgYmUgYWRk
ZWQgaW4gdGhlIGNvbW1pdCBsb2cuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBpcyBiYXNlZCBvbiBBcm3C
riBTeXN0ZW0gQ29udHJvbCBhbmQgTWFuYWdlbWVudCBJbnRlcmZhY2UNCj4gPj4+IFBsYXRmb3Jt
DQo+ID4+IERlc2lnbiBEb2N1bWVudCBWZXJzaW9uIDMuMiAoRG9jdW1lbnQgbnVtYmVyOiBERU4w
MDU2RSkgNS4xLjIuIFdoZW4NCj4gPj4gQml0WzBdIG9mIENoYW5uZWwgZmxhZ3MgaXMgMSwgdGhl
IFN5c3RlbSBNYW5hZ2VyIHJ1bnMgb24gTSBjb3JlIHdpbGwNCj4gPj4gdHJpZ2dlciBnZW5lcmFs
LXB1cnBvc2UgaW50ZXJydXB0cyB0byBBIGNvcmUuIFUtQm9vdCBwb2xscw0KPiA+PiBHZW5lcmFs
LXB1cnBvc2UgU3RhdHVzIChHU1IpIHVudGlsIEdJUG4gaXMgc2V0Lg0KPiA+PiBJZiBVLUJvb3Qg
ZG9lcyBwb2xsaW5nLCB3aHkgZG9lcyB0aGlzIGJpdCBuZWVkIHRvIGJlIHNldCwgc2hvdWxkbid0
DQo+ID4+IHRoZSBiaXQgYmUgY2xlYXJlZCBpbnN0ZWFkID8NCj4gPg0KPiA+IE15IGNvbW1pdCBs
b2cgbWF5IGhhdmUgY2F1c2VkIHlvdXIgbWlzdW5kZXJzdGFuZGluZy4gSWYgdGhlIGJpdCBpcyBu
b3Qgc2V0LA0KPiB0aGUgU3lzdGVtIE1hbmFnZXIgd2lsbCBub3QgcmVxdWVzdCBkb29yYmVsbCBp
bnRlcnJ1cHQuIFRoZSBmb2xsb3dpbmcgaXMgdGhlDQo+IGNvZGUgZnJvbSBpbXgtc206DQo+ID4N
Cj4gPiAgICAgICAgICAgICAgaWYgKGNhbGxlZSkNCj4gPiAgICAgICAgICAgICAgew0KPiA+ICAg
ICAgICAgICAgICAgICAgLyogR2VuZXJhdGUgY29tcGxldGlvbiBpbnRlcnJ1cHQgKi8NCj4gPiAg
ICAgICAgICAgICAgICAgIGlmICgoYnVmLT5jaGFubmVsRmxhZ3MgJiBTTVRfQ09NUF9JTlQpICE9
IDBVKQ0KPiA+ICAgICAgICAgICAgICAgICAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgIHN0
YXR1cyA9IFJQQ19TTVRfRG9vcmJlbGxSaW5nKHNtdENoYW5uZWwpOw0KPiA+ICAgICAgICAgICAg
ICAgICAgfQ0KPiA+ICAgICAgICAgICAgICB9DQo+IENhbiB0aGUgU00gYmUgdXBkYXRlZCBpbnN0
ZWFkID8NCg0KU3lzdGVtIE1hbmFnZXIgbm90IG9ubHkgaW50ZXJhY3RzIHdpdGggVS1Cb290LCBi
dXQgYWxzbyB3aXRoIExpbnV4L1FOWC9SVE9TLiBTeXN0ZW0gTWFuYWdlciBjYW5ub3QgYmUgY2hh
bmdlZC4NCg0K
