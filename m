Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17327E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4CC801FD;
	Tue,  7 Jan 2025 13:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EjFXXTqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2938036D; Tue,  7 Jan 2025 13:13:09 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94822801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gglhqwjrI32tll+j0UkFiZ0+2+rQw3iXHKfWAUvTvtYo084dpq/MhLXKZmFs019MU9pnZ/vS4HEXJhRNVis5dlCmqkv8ZBMtUJ6aJpqXlwyyWZW7pAtlQTPlno7nF0+GCwP7Sd9AsxRbWet0WUKyGILLxJ4WlRaUHoRMXV8QJnUCKDDjhDVoPwa0ePDZR6JTES2ThOZbU90PX3S2loqSsJ9EvtdRGoQ7Qqli1a8Usv55jCYn4zwmuGkOcLea14/vVV+GdfHO2vIsZKWJ51kVCYR73+nGYarO4hNbvvIAdcngXeB4aFg7mp4iI2Zzh/zsQCIJZ/0AlcR+lw/lPJzm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBsgOUmu5Nda1zTrg5fYWgTi6SciBETaGC9wSifgim4=;
 b=qNI3o2zc4C36mC/UGpzNRGExHu1jK0c8Nj3FulZKKYKSym0ns9p2k4zfsGWphTGzdMVfHgafd03SuKVlhGr2WUF5RYerO0ySRg6EQdi0ZkELwAvsoVzdhgbfds4ngA7aeJ924H6jvxpEx4dXAjVFgZKDDJZlP2fZRK2B4FMDcDkMg1Yf58mCNp1S0ny4P3m+8/2Lk9hrHnZy+DBlRYe/3/7T9OZbvvgCUByVlM0X4N/lbp3jusnPHXtjdcTzWU0CH2XeOLPRANi5uqsNkVAQ+KNA4ev01/Xe5As1Za2HJHI57E6rc9MIacmKb0yV84yK69Bq8FqCZjIur2IQg4zZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBsgOUmu5Nda1zTrg5fYWgTi6SciBETaGC9wSifgim4=;
 b=EjFXXTqLrJErKgXp5Q6J2qQrLeuQ+qUlBwmmGA7Fil8hBBpImDCi6kdipCPa7o8AaJx+NZkKjhlnRcWzOaWERDlPFLIFEfL5kbZ+ci7DiYM1LWp54iQfEwAunZ0M4dc1bqDM4UmLjFitE9p4rG5tI7JdGZ4qImZ9anijfPuA1xwoGZKFkmYB/8lNKawGWak1BOj1K7BBcbzN40Yl960DdnIZuiLpTdT/ApO4O7RYJk+zbN3O7vhN1elvSAWZbKZISaiPn4+/CqLUqpePscQBC4ou1DxWPwPt55Qi6LQRE28AL7kjbDSGxi1ep0K2Yg54uHXKRHwlCnlUQBGZozv4xw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10774.eurprd04.prod.outlook.com (2603:10a6:150:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 12:12:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 12:12:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Fabio Estevam <festevam@gmail.com>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?UkU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMS8xN10gbWFpbGJv?=
 =?utf-8?Q?x:_add_i.MX95_Messaging_Unit_(MU)_driver?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAxLzE3XSBtYWlsYm94OiBh?=
 =?utf-8?Q?dd_i.MX95_Messaging_Unit_(MU)_driver?=
Thread-Index: AQHbXasiBXQqClH7UUOixpHlhGHx6rMIrUUAgACOwACAAP7wgIAAjDaAgABm5gCAABFEUA==
Date: Tue, 7 Jan 2025 12:12:59 +0000
Message-ID: <PAXPR04MB845987C587C15B599A266CEB88112@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-1-6744df5dc020@oss.nxp.com>
 <22f8e29b-1372-4384-a5d4-5316c1f4f160@denx.de>
 <PAXPR04MB96447B0DA009A2730D207B7FE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <001a00ca-5980-4ffc-8fe7-67267a71615c@denx.de>
 <20250107044653.GA9383@localhost.localdomain>
 <27d250fc-ec48-4850-831f-b4d76b8ed240@denx.de>
In-Reply-To: <27d250fc-ec48-4850-831f-b4d76b8ed240@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10774:EE_
x-ms-office365-filtering-correlation-id: 64cb29da-6153-464e-4753-08dd2f14a089
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZFF3dHF6VmlZNTRHUHJrNDBzRjBIWnliYzRGMkpldUlhRSt0YXVnWWp3QVA2?=
 =?utf-8?B?TStaZmN1Qnc4bjlxNm9hT1VzdXkwdjd2VDd0Ym5hYU43czdMRXA0aDV4YkV1?=
 =?utf-8?B?algyb3NCeG9xT3ZlYlJBMkJQYlFHZ3Z4OTNONERFUThadjZ5RWZhcmNxQ2ZM?=
 =?utf-8?B?WG8zdmtucFplWmZJa0NSNUxVaElDbzFQMmR2RVU5YUlId1pvV2dIaWlyeWg1?=
 =?utf-8?B?S1JmTHJyRTkwdldrTWl3dGRUQ2wrbmJHWXlxcmpMRWcxcExkNE13OXdWRU5Q?=
 =?utf-8?B?VFJ6TDZaZlBYdzRzVnQrZWxTc2cxZkxnbjFhblAvcElvdDROM0VUS09SSzhs?=
 =?utf-8?B?V2lVdXc1dzNycE5Xa3BOa2c1OG9ydGRYc1RrZDFHa3FtMzhjTjRmVEhNMEly?=
 =?utf-8?B?TUlkcWVLZXNUN3UweE5id3hJRTVqWldKb2NTMUhyU1MvN0ZzU2hlbVZhSE83?=
 =?utf-8?B?d1RZNk1ML0R5cGNWU2ROVDFMQ0MzQjBoY0orL1VoM2dSQ1lQK21vNUR0OCt2?=
 =?utf-8?B?VGVTb1B4ZDlmZ2VOa3ltbjkydVY2ZWE2UlJTSVJIQ0c5REpsd0FRTUtsc0pp?=
 =?utf-8?B?MGwrQmtwVStOM2RFUmYwaWxHd1M2OWFhb3hodk5kam9HY0xrSnFkOXlpeG9H?=
 =?utf-8?B?VVRJcnFicVMvYmlWRldoZ1lDSnQxNUlwbk9oYXpvMmxKZkdWcHNWNUV3aDJa?=
 =?utf-8?B?d1lrQVZPTmhQdkVacVdvbEY0V1IrYVg2U0R4MlVyUE14TlYzU1ZicldqR0FN?=
 =?utf-8?B?QnBqcE8rOU5YMEd6cDFDdnJUVmN3cVRUb0RpL3g1TEp3MFgrajVXQkNQMml3?=
 =?utf-8?B?RDZ0NkRGUFlFSUlSdVNuTmRkclBmN0Evd0xpT2g1d2V3VTkzRGJrWTdqcjBj?=
 =?utf-8?B?UFVDTGtWK2VSUFplMVRIUGZiUlkzOEhWNzhWMFZROHVDVnFvRXg2eWV6V0Z5?=
 =?utf-8?B?SGtYbFpCenBXQU4zdXFXNFI3aFR1Q2o2MDFDZnNTOWVkcVA5ZUp2eG0xVzVM?=
 =?utf-8?B?SnBUUWYvWnZZTHZocmh3VzVUd1BqMlhnZU5ONEx4K1JnaHJzNDFROEZ3THBh?=
 =?utf-8?B?OUord3pKT0JtYUxBMlRGcS95dy8wa3pOYXZ4OVBKeXVZVERlMW80dFgveWxo?=
 =?utf-8?B?ektkUk9vMFBFM0F3dG4vUzJERXYrakxPYmRySlB0OUdYNmt6ZEdUNXhDWHRE?=
 =?utf-8?B?THdrWUdhcG1YekNCZVlqZU0yWkNva0hEUGl2aFl0Yld0NkRxelZ3U0lkbENZ?=
 =?utf-8?B?Nkd6eEFyNm1SVVBlcVRNcTRYOC8xVnBOREViM0cxYi9maTJyallDY3hqQmdW?=
 =?utf-8?B?YXRELzgzSWhQRVZhbFVFZjhpS05pYTNyakZXSzIremJlZk1NSVloSi9EeElR?=
 =?utf-8?B?VHlPSTJKRFpoN1A2dERYbjdLekhrd3JzenJ2VlhMMW44U2QxVGtIeThRb1Yy?=
 =?utf-8?B?ZHhhVHB6ZGI5NitiRlJGTjNCUGRORW16YWQzemdwN3pHNEFkTUtxbXlpbzVj?=
 =?utf-8?B?ekJTMm92U0Jka2NZdFRzdzAwd0E3UkFTYytPVE1QNVgxT0dlc0NyRzNVU2Yx?=
 =?utf-8?B?YkRINlRicm9WS3l0dVBKOGI4NjJKMGpNMmhvNFFCbXdVTmtxVkF2UDE3R1ZK?=
 =?utf-8?B?VTBSWFp6bHUyYmd3Z2p2RXpaZGlmRmFURGU1dnJ0aWRMeXNOazVIZE5IbWdp?=
 =?utf-8?B?eU52QXZDdEdqTGFXWitWTHFzQjZLY20zYVpyWUgyNGlHTWJYa3FoVUh5aFBo?=
 =?utf-8?B?NDRUVnREN3FRazVEWHRmQW9YeWI2dTdTTDVScDAwbXlLRG11aFplVy9ZZmFw?=
 =?utf-8?B?RmRJOS9XQTdsZmNsQzJKRW51QXVyb29Nd3NVZlZsMVdtbUwwZGdkRHhPVlFz?=
 =?utf-8?B?ZExsczFTdjJGZW1nT1NXeElmTk9JSEpGTGxsTVFmeFNpcEtqaTV5QnNnRHFa?=
 =?utf-8?Q?3WoVimyvdfLGwGMbcta9Kgfv8uebiqHL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3VQTmhzbG8zN1Y3ckx6N2lhOEhXRU5URWN4anpSS1Y2dSt5L2JycWlyVGxo?=
 =?utf-8?B?SGVWRjVLclBmNDZBSnYva1lqejRoTnBPdm8wb1g5MFNRZWs0R1NnMS9vKzB1?=
 =?utf-8?B?VTkybHpNK0hVVU5jRXBZNXRjbkNUZkh2VzYvbFlGWG5xTzM0aEJUL3JpMGxH?=
 =?utf-8?B?MExRSVdQNzNjdEtSUkFzSzVwUzQyVVBqa1RhL0tseFRhTjNKQlB5RTNRYmJn?=
 =?utf-8?B?RVhDeUJ2cFZFSUhKendUY3VnQmhBRUdqWlJVY1dUbFgxVzdNZnB0a2dKMytz?=
 =?utf-8?B?OWFSYktpajY4emRmaThJM3RPVndPSU9QUUEwNmVJdDNRVW9jMjRPVVBJZmli?=
 =?utf-8?B?bytBVjBDTXBIaFY0NEczSFpxN3htQ25CaEtqWXdxdFZ2TTNreHdYVlJDZzBt?=
 =?utf-8?B?SDhaNHlObG5TRkFsdUE3UzJDY2tJK1dRNzAzUEFvdTN4c013L0c5cHU0aFUz?=
 =?utf-8?B?UDJhKzkrb2ZQMm1ocFBIM2lYVmFxUk9yQWtjdVBFczQvUzViN1pHc2NjVnpo?=
 =?utf-8?B?R2RqVFZ5bjlUanlvNVpoTVUzWFVTaEFRWklUZlYvcGVYT0lWeWxFVURXMTFF?=
 =?utf-8?B?SkRjVkluMHZJMzZtMGJLMUMwTmRZUTZrcDlEWDd1aVBiQ2lzbVRtUHlkdDND?=
 =?utf-8?B?dFV1ZFZ3WTNmdVdMaC84TWhFa0hadEFLem8zRzNHejF4S3FiZExBMDhKWlha?=
 =?utf-8?B?UXcvYVdteGR5bkVaZDBYMWpEN3BKOTB0NDRyajlqdVJxZ0diM3pTQ3l6TG9Q?=
 =?utf-8?B?T1lwUXd4Mmtnamo2d0Z5Z0pvYkpwK1pKTUU1eGIxMFBvZE1iNVlXcGpwbTRU?=
 =?utf-8?B?VTJmTHhKUjl5eFJkMzl3Y0t3bkFBRm1wWFZhMHdlY0ZQRVNSajh0YzhSRDRE?=
 =?utf-8?B?UW1NcUU2UU5sZ1ZuNGo3RU9qNUkyVWpjOGI4U2RkVkg3OVNDQjlLRnV2SEJC?=
 =?utf-8?B?cmlzSHRHR2wrMWhJdnhQdWFGYk84ZVNPTTFYNURtMmRmUEhQYlpKOVhIcG9C?=
 =?utf-8?B?d1NPa3lTNnNXUjhKVm5penpWTVFZcXY4UTFKUzFXbTZINlJlZFk2WHlyN0xy?=
 =?utf-8?B?MnU4VUdDZFBlVmkwN2gyNkNSRjV6akxHcWRGSVNxZjV6bXEzZ0RJYmdFWm1E?=
 =?utf-8?B?dmszTEZIYTNyVGZpdU1mS2xKS1NsVnZUWThpVjRSakZNRTJEVnhkNXkxYkRt?=
 =?utf-8?B?ZmlGSlRPWHRQWUFNTmVsdnVzWm83ZHVjL0hlRTlKekRyRnRCWEtvV3FnN1JZ?=
 =?utf-8?B?R055bEQ5T00wanRXUW5HYVFEd2N4M0NzU2NvNFc2cXdVUlZsNXd2SzJDRHEv?=
 =?utf-8?B?SW9aS09uS0hIOFhmMFlvamNZNEIzMDFBOVRXSGkxbW8vYlhvZ2NQOU40WDFS?=
 =?utf-8?B?WVorRUpQcHBoaDFGVXpweWkzSm1OV0N2Q1oxS045QTJaS3NnNXFDendFWjhW?=
 =?utf-8?B?VmpjT2NaZ3A3RlJNd2ZYcGNtVFlZTUVjb3pPQ2RpSjdEYmpubUhtNGVQOS9i?=
 =?utf-8?B?dERmaHdUUVM2U1IrRG1FWmNXQWJMTFlyOUZkcXhibDdKZXFGa05mTGduSE9k?=
 =?utf-8?B?S3JHTWpZUWRSZHd1ZEROL2QyYmhnNVRTQzQwMEpRYlFoSnNscjJFd0k4aEpR?=
 =?utf-8?B?VWsxUGp2RnViK1JlczBpWmYzaFptZTRvWW5YcWlyQzlHWkowWUFGRE1IbE4y?=
 =?utf-8?B?enFTL2NicGRZK3dCbWRNTFJLR3FMaS9XOE5iV00zTHpraDA3UlpOaUVRb0hj?=
 =?utf-8?B?Uk5qMGY2RVErQUhFNWZvOVpQeGcxZ3pSVG9vVWg1YXhFWHFHSlQ2QktlWXdH?=
 =?utf-8?B?ejVERnJ1ZzBwNDR2SStuZkZsdlZNd09sdDFqdXdrZUNSYXpWbW9VNEgwNGN5?=
 =?utf-8?B?clFEbmNvaWpjdWpTWHJmeXBpVnA2NmlVMUVuWVpqNGljNGJ5SlFpSG9hT1ZY?=
 =?utf-8?B?TEFndXQvN3g3ZzN4bjdMNWxuZ0VUajJHcDljL0R4Z3ZDK3hEWlB4MjF3NXk4?=
 =?utf-8?B?MmtrcGIySjJJTU95b3k3Y1lLdlkzWVRwV0NOS3BhRDlpZXJyb1pabFVBUGor?=
 =?utf-8?B?RnNWNnNUclkxMnJ6L1NYcXdIcVJteU04ZUU2UUl6QnNUYU44bjlrZG9VbFFr?=
 =?utf-8?Q?S4Ak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cb29da-6153-464e-4753-08dd2f14a089
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 12:12:59.3905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8avMGnQH47vUX7NHqnGbpGxpAioyXPzPyptJdxWJZTwALN3E27RCtNadeosAnN9rF/eVuQCYnrzVevpPwWw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10774
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

PiBTdWJqZWN0OiBSZTog5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAxLzE3XSBtYWlsYm94
OiBhZGQgaS5NWDk1DQo+IE1lc3NhZ2luZyBVbml0IChNVSkgZHJpdmVyDQo+IA0KPiBPbiAxLzcv
MjUgNjowMSBBTSwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gT24gTW9uLCBKYW4gMDYsIDIwMjUgYXQg
MDk6Mzk6NTdQTSArMDEwMCwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+ID4+IE9uIDEvNi8yNSA2OjI3
IEFNLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+ID4+Pj4g5Li76aKYOiBbRVhUXSBSZTogW1BB
VENIIHYzIDAxLzE3XSBtYWlsYm94OiBhZGQgaS5NWDk1IE1lc3NhZ2luZw0KPiBVbml0DQo+ID4+
Pj4gKE1VKSBkcml2ZXINCj4gPj4+Pg0KPiA+Pj4+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJu
YWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZw0KPiA+Pj4+IGxpbmtzIG9y
IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZQ0K
PiA+Pj4+IHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiA+Pj4+DQo+ID4+
Pj4NCj4gPj4+PiBPbiAxLzMvMjUgNzo0NSBBTSwgQWxpY2UgR3VvIHdyb3RlOg0KPiA+Pj4+PiBG
cm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4+Pj4NCj4gPj4+Pj4gaS5NWDk1
IE1lc3NhZ2luZyBVbml0IChNVSkgZW5hYmxlcyAyIHByb2Nlc3NvcnMgb24gYSBjaGlwIHRvDQo+
ID4+Pj4+IGNvbW11bmljYXRlIGFuZCBjb29yZGluYXRlIGJ5IHBhc3NpbmcgbWVzc2FnZXMgKGUu
Zy4gZnJhbWUNCj4gPj4+Pj4gaW5mb3JtYXRpb24sIGV2ZW50IG5vdGljZXMgYW5kIHJlcXVlc3Rz
KSB0aHJvdWdoIHRoZSBNVQ0KPiBpbnRlcmZhY2UuDQo+ID4+Pj4+IFRoaXMgcGF0Y2ggcHJvdmlk
ZXMgYSBkcml2ZXIgZm9yIGkuTVg5NSBNVSB1c2luZyB0aGUgY29tbW9uDQo+ID4+Pj4+IG1haWxi
b3ggZnJhbWV3b3JrLiBDdXJyZW50bHksIFNDTUkgZXhjaGFuZ2VzIG9uIGkuTVg5NSB1c2VzIGEN
Cj4gPj4+Pj4gbWFpbGJveCB0cmFuc3BvcnQgd2l0aCBTTVQgZm9ybWF0LCBhbmQgdGhlIGhhcmR3
YXJlIHVzZWQgaXMNCj4gdGhpcyBNVS4NCj4gPj4+PiBJcyB0aGlzIHBvcnRlZCBmcm9tIExpbnV4
ID8gSWYgc28sIGFzIG9mIHdoaWNoIG1haW5saW5lIExpbnV4IGtlcm5lbA0KPiBjb21taXQgPw0K
PiA+Pj4NCj4gPj4+IFllcywgdS1ib290L2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIGlz
IHBvcnRlZCB2Ni4xMi44IExpbnV4Lg0KPiA+Pg0KPiA+PiBQbGVhc2UgYWRkIHRoYXQgaW5mb3Jt
YXRpb24gaW50byB0aGUgY29tbWl0IG1lc3NhZ2UsIGluY2x1ZGluZyB0aGUNCj4gPj4ga2VybmVs
IHZlcnNpb24gYW5kIExpbnV4IGNvbW1pdCBJRCAsIGluIGNhc2UgdGhpcyBkcml2ZXIgbmVlZHMg
dG8gYmUNCj4gdXBkYXRlZC4NCj4gPj4NCj4gPj4+PiBDYW4geW91IGFkZCBvbGRlciBpTVggU29D
IHN1cHBvcnQgd2hpbGUgYWRkaW5nIHRoaXMgZHJpdmVyID8gSXQNCj4gPj4+PiBzZWVtcw0KPiA+
Pj4+IGlteDYuLmlteDk1IE1VIElQIGxvb2sgdmVyeSBzaW1pbGFyLg0KPiA+Pj4NCj4gPj4+IFRo
aXMgcGF0Y2gtc2V0IGlzIG9ubHkgZm9yIGkuTVg5NS4gSSBjYW4gYWRkIHRoZSBvbGRlciBpTVgg
U29DDQo+IHN1cHBvcnQgaW4gdGhlIGZ1dHVyZS4NCj4gPj4gTWF5YmUgeW91IGNvdWxkIHNwbGl0
IG9mZiBhZGRpdGlvbiBvZiB0aGUgTVUgZHJpdmVyIGludG8gc2VwYXJhdGUNCj4gPj4gc2VyaWVz
IGFuZCBkbyBpdCBmb3IgYWxsIHRoZSBTb0NzIHJpZ2h0IGF3YXkgaW5zdGVhZCA/DQo+ID4NCj4g
PiBBZGRpbmcgb3RoZXIgU29DcyBzdXBwb3J0IG5lZWRzIHRlc3RzLCBidXQgdG8gdGVzdHMgb3Ro
ZXIgcGxhdGZvcm1zLA0KPiA+IHdlIG5lZWQgbW9yZSB3b3JrLiBXZSBjb3VsZCBub3QganVzdCBw
dXQgY29kZSBoZXJlIHRoYXQgbm90IHRlc3RlZA0KPiBmb3Igb3RoZXIgU29Dcy4NCj4gSWYgeW91
IGFyZSBhbHJlYWR5IHBvcnRpbmcgdGhlIE1VIGRyaXZlciBmb3IgTGludXgsIHRoZXJlIGlzIGEg
Z29vZA0KPiBjaGFuY2UgdGhlIHN1cHBvcnQgZm9yIG90aGVyIFNvQ3Mgd2FzIGFscmVhZHkgdGVz
dGVkIGluIExpbnV4LCBzbyBpdA0KPiBzaG91bGQgYmUgc2FmZSB0byBwb3J0IGl0IG92ZXIgaW4g
ZnVsbCB0byBVLUJvb3QgdGhhdCB3YXkgPw0KDQpJIHdpbGwgbGVhdmUgdGhpcyB0byBGYWJpbyB0
byBkZWNpZGUsIEkgbm90IHByZWZlciB0byBwb3J0aW5nIHVudGVzdGVkDQpjb2RlIGluIFUtYm9v
dCwgZXZlbiB0aGF0IHdvcmtzIGluIExpbnV4Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo=
