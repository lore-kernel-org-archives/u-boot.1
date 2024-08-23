Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E846EC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 12:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F008882C;
	Fri, 23 Aug 2024 14:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="I4Qy84XR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B79388850; Fri, 23 Aug 2024 14:29:55 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F198488641
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=896554e7b9=benjamin.baratte@st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8xRaO032643;
 Fri, 23 Aug 2024 14:29:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 STMicroelectronics; bh=lYEeYaqRUPJ83GYvQ0wcj3Q0rDB6rSORNx6NIRrP3
 H8=; b=I4Qy84XRxFqdhY3EoAh8/UTmDXsgVIBNa2AP4RbTpQ74rtxrQfOXIm/yb
 S8POyOjpu/Go6nzn4J9A+z+02XIPoCrEnETwE4VNuTp+RpeRzAe1ZXOxmSHiV43y
 ayB7PGjVNzQuMPjwlJKZIeETgX78XsvwnJvOdYFopdChFVztPJu6fTAURHydwRWR
 JX2P0/Jr/Dfyjw1wyv+yi6EdOAB20GZ6z+d1VvpreZMR7LwBAKnSxKq/cZrnIrZF
 JZGk/jZBtkto+5GNM70rItKyoHzeEiwI5/Cw4OITamp18X+daC9r+4DIWqmnIM8z
 upTGXBGikqbItYPnK4WRiNhFo4o8g==
Received: from eur02-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2042.outbound.protection.outlook.com [104.47.11.42])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 416qd7rt9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Aug 2024 14:29:41 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZAla6/WGp4MAfNwLLn/PwT1gNg6qLa8MtGntg9MXJPtF6FENrGPx7I1oY27QhCJF8RUzJwhyecln0iTtsmLRBCJyOCT1iqR29pXY4Ax/O3o3V3AB2yoT+ICVJ9Jyyq5DTyWEyfLzGc41QO+N9SYzuGTsc/K1cpBcv6sM/pE/dR7vH2jDVYksKteyN4+HmKKpm7/cUWmzQRgPIsV+Xm8C5guIGPTANJuWb17XXighRAyG1fA71u8AnTotWLaUUGTJLGkLF3sScThLg1FnYj2zklc3vJ/c8JoOkvasN5tTzM3LPcZMSdC60n0XE75IaB/RJwNXC/3LVbHE5px2Qj8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYEeYaqRUPJ83GYvQ0wcj3Q0rDB6rSORNx6NIRrP3H8=;
 b=PIxltjRovFoyUuwk2/4LF6koYEzDC3cWDaz+kB3ckJJ0b2j214zkWy9FYSVe9QaF9zN7EyroooVCltKD96sdl4Z/O+CLrVxTMpeOBxeTOo0YDCNhplcA3F/JuALdj5/c5PzwCzU0+3XUGNL1D6Zot2eC52z0N1WYn22L8o3YPrlEuHQ02rNuI4zKa+ksi5mtVJNbgQhhr/tFRSx2ztr4uyfxjzK1MwQBEECUUewGd00O9Xg3iSfDBYqx8V+IATsFMuf8wPYYDqcjssbkDk4+1EB9o3VghvdZ1g9zWnKQuCUbQvPIW1+spaFDXo9JgJb64S0ymhCtCYQMpRO+/GE62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22)
 by AS4PR10MB6038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:575::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 12:29:39 +0000
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370]) by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 12:29:39 +0000
From: Benjamin BARATTE <benjamin.baratte@st.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "akashi.tkhro@gmail.com"
 <akashi.tkhro@gmail.com>, "abdellatif.elkhlifi@arm.com"
 <abdellatif.elkhlifi@arm.com>, "eajames@linux.ibm.com"
 <eajames@linux.ibm.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "kojima.masahisa@socionext.com" <kojima.masahisa@socionext.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "sughosh.ganu@linaro.org"
 <sughosh.ganu@linaro.org>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: RE: [PATCH 3/3] tpm_tcg2: hash algo optimization
Thread-Topic: [PATCH 3/3] tpm_tcg2: hash algo optimization
Thread-Index: AQHa4cED1psWA0is/0C8CfzNGZn8ArI065gQ
Date: Fri, 23 Aug 2024 12:29:39 +0000
Message-ID: <DU0PR10MB5244E4B10953B67C52F06322E1882@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
References: <DU0PR10MB5244DD7996739E6063425201E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
 <ZqeitfLsRW8_Tet_@hera>
In-Reply-To: <ZqeitfLsRW8_Tet_@hera>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-Mentions: ilias.apalodimas@linaro.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=0e14545f-d436-4743-ba45-fef223d5839d;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2024-08-23T12:25:33Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5244:EE_|AS4PR10MB6038:EE_
x-ms-office365-filtering-correlation-id: 3e3a54e6-8461-40bd-4af3-08dcc36f41eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-7?B?UmY5TjNwZktndW80UlJlYXgwclNyc3BnaG1LdkVrellsRXJKbEhtYVZSa250?=
 =?utf-7?B?cGhDVUQrLUxuclJxZERvdlZReThLSG96TUtNODJaRCstVmFJaU4xVEtzYjd1?=
 =?utf-7?B?RmZQdUwyWWVRUHFlaE16aWgrLW90c1BaVHJIMFh2RDdpYUxrNXdHdUZvV2dS?=
 =?utf-7?B?WlVuRWpLaystUDQwNUlTM25iU0o0bkdNUSstVmRnaU5JZXovZG1saEhXb2h5?=
 =?utf-7?B?SlBoa21lY3NxVnVGSDY3eXFkM0lZVGlRd0w0QktSZ0ttQWc1Ky1meUxTQTIw?=
 =?utf-7?B?cjNHaUdnNWk1VDhvYzF0OXlDS3dmYURXUzd3bEpDYXhSdk9jNmFMcGs0RUs5?=
 =?utf-7?B?U2s5SnpRUkttVjFUWngrLU5OVllZWWY5SDl3RktpYXRRYlpmRlYvQ1VqUUdh?=
 =?utf-7?B?ZHZCQk15NFlLWDhYRndlSHNRS0ZUeW53cVJmSURha1p5Sjd3Q3lVdkFSa0Uv?=
 =?utf-7?B?N3BvMVdIKy05djNRKy0vUkhNb3g5NGk2dFFJKy1KVlV3bVdJbjRYUkMvb3dV?=
 =?utf-7?B?RXhaMXZuT0M5NGcyenVrUEVPT2htQ2o3cC8vSk1VRjFFYnNOWHZWWW12OUMw?=
 =?utf-7?B?L1psbmhwRjM5WUx3MGRvbEp0SjVCRmdTKy1hbDVZby9USGh0ckZlcWFvQmxq?=
 =?utf-7?B?eistZGhxN0plT1hpUFdyRUdpWEtLaEVMVktNdERTbkE4dTNoVEJkZmpxbFpC?=
 =?utf-7?B?US9vNHhVQXhKckkvODZTNzV3OE9oSGFaeDQwYU1JcG9aVmEyVzNFVnhOa2FC?=
 =?utf-7?B?cXd4WGFSdExhb1RKWGVWNzBjYWpYZnVoYklTb1IyNXFjYjZrc1J3VlhGKy1J?=
 =?utf-7?B?MUU4aHVWTm9zTDFlV2d4cm1tWmsvaGptYkJzb1BvM09SUmFvczE4R1BISmdU?=
 =?utf-7?B?YVZsYzZFWlZPdExDTzdQNHNjV1JrdUVYb1lHTlExNC9WaVhEaFlvcXY5UzB5?=
 =?utf-7?B?L0NQT3VZQ3Z0SDNGY1Buekc1NUlQOGxtbU5UcXYvV0hRemlTbjdYa3VWdVZJ?=
 =?utf-7?B?U0hqem1HZnMwaU83NGx1YU1CYnUzdkZIYXhMVXZsYlh4aDhlVndsSHZWb2tl?=
 =?utf-7?B?Sno5UHV0VDJ3VEw5Y09ZYU5hbjF1Yjd5My8wY21MTGV5QVZleEo3Rk13R3Vn?=
 =?utf-7?B?VXhUS1FLOFk2dDBUU01scVVrRFhONG42UWhEOHJIVkZjWFlSVU12dWxnbEZk?=
 =?utf-7?B?NGlWYkJraVJFZVJwd1I4ZXZzYTNtNkt6RUxrdXFNOHNlRE05NkRKT1Jubyst?=
 =?utf-7?B?UllqSDRHdlFaTFUvdXp4dmxxVEtPbEdZQXVYMjlieSstbVJpZ2VkYkZMb0pF?=
 =?utf-7?B?NVZ2aTNwL2ZDZEI5TTczcWtXNElqYWt0TkNKVkJ4THB0aEpGUHIvRzJiaGpr?=
 =?utf-7?B?UnlPeE5RU2R6OTYxY2VtNk5SOUcvdSstMGczcmFsbXZZRzhjczQvdVYxRmNk?=
 =?utf-7?B?anRQN3FJV09ySFM1cmpWY0loNlVORnVlRU9lRFNJYkxQM2hpWXBFQVdSZkFO?=
 =?utf-7?B?NmZUTDU0Ky04amFkYzNlWlpISWZLNlJLUzRaNHBJV1F2TmVIeFVLbE04emxP?=
 =?utf-7?B?blZFZFlZQkhRc1N4T0hVQWEyL2lYM3lWanpBQ0UwYWN3ZkJGUUFlRlJINHM1?=
 =?utf-7?B?bjdxMG8xb3J5N0NUUzkydGRyREVSeGFwQnZzMFdnemlaWGRpZ1IzWHhIckpk?=
 =?utf-7?B?eTlpeEtkaUhHcUNITzNZUjlCTFk4QTFpWjgvNi9QQVZQM0Z3a20zeUc5eEdq?=
 =?utf-7?B?d3dxaGZ3R0FlZGtGanpneVNacTUzcEJodGZhUmVDZndtTloyaGpOcXlRSHo1?=
 =?utf-7?B?L2FFY3lCR2lGQUdKbVR3blNFLzlqbzQrLWFOKy1UajUySTlLLzNPT09vMFls?=
 =?utf-7?B?RGUzdUNad21qakJ3ZEpWczk3RWJLODNUSHZBRVpaVnQ3Yk8vV3VZdFdRMGRv?=
 =?utf-7?B?Vk94Z2t4YkRRK0FEMEFQUS0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?L3FPMmNONXp0NXlDWUtndjllKy1UaFdFNzF6T3pTWGIvUXZRYk00dERndkF2?=
 =?utf-7?B?R3ZBN2pKWDJQWFVaMzlIak9wOXZEMGFKNG4yNDEwOVA1MzR2Vml0anRWNXU1?=
 =?utf-7?B?ajVodk5yUk9ydWRpUWlrTFozRFRneVFYeFBXdXJ1bHh2enA2L0hMdjRQU1l2?=
 =?utf-7?B?T3llVnNOekZBR1lNQm9rd1pYOVRPM3NFaGtCaXJPalRNM1dZSmpsMkExTk1k?=
 =?utf-7?B?ODVKbUM0eDVwRnV4L2p3Mzk2SVZlRGJHNjlUOG5Jb2E2TEVmN3RNbkE3eDU0?=
 =?utf-7?B?aG90WU9kQkJaNGkzUW0yNGJBNVJWVVIxdHZOT2ZUR1BOeUppTXpHZzFmTHo0?=
 =?utf-7?B?T2E0ZHpGSHdvbG55bFE2aVliZkhPRThLNystdnB4L2lvNWFRcVNUd3d1SjFB?=
 =?utf-7?B?eDZadS84aUdWY3hlYWxuMmpBSDBmVXFZbCstODg0ZnE4YjJYL1BMbUZSdjJG?=
 =?utf-7?B?cjJjSXZ3Z096R3dLQTBTRDJscVpFbDNPV0kydi9mTXEvU0ZXQjlVOVJKaWNB?=
 =?utf-7?B?RkNycGN5VzZnUi91VVRQZmJmWmZnOU5WUG4vOGswdkdTWUVzL25TRm9HR25R?=
 =?utf-7?B?Ump3WlFBcGR5VnlDVWlFeGR2NllGMkVkQWxhQUhCbjQvQlF2OGd2ZDY2NWFl?=
 =?utf-7?B?aGNhckFjdTJpcXVEWmVoSERvcXU2ZExpcVUvMXZKb1Q0VDVWWHpxdFJzZ1Bo?=
 =?utf-7?B?a2FTRVdFSlFIMGpMcFRtL1JkczlSUistZmp3SjYxc1c3ei9JSVZkRGtXVVM2?=
 =?utf-7?B?UkZBL2FLR2NGZlFqR1c5VEU3Zmp6V1pTZ29rWm5rYWZhbFlBbEd1TmRPbGFC?=
 =?utf-7?B?RWlWaDE4UCstb3hpQzRBZGlJRTgzaDk5WEoxSEpndEJlQXlUaSstSEltRFk1?=
 =?utf-7?B?ZXVOWEpzdEc3S0t0M2syenNxaTJERWptV3dTN1VOKy1SUjRhWEI3REpmaDNp?=
 =?utf-7?B?Yk43ZDd1R01zRC95VmdwOEVZcS9LUG9vanBqOVJnUnYzKy1pRmNhRzlETjU5?=
 =?utf-7?B?ekc2SVhFd1JEUDFhcG9kYlJuOFlWdlRMYVE5amR1Q2ErLURiZ1YyWFc5Ky1o?=
 =?utf-7?B?eU5oSGp1R0IyRVJETEdqQVo0MzU4Ry8xTEVFY29rNnA4dDVQaDRrV3JzaDRr?=
 =?utf-7?B?QldhM2lHY200emN3SFJpY3lVbnJaUWNnVlhCWEJza0R5aGdobjRRTWFJYjUy?=
 =?utf-7?B?c25vaFYvUGZleFVYd1I4dXpvdXRaM013dXhxM2ljZ2FVNVN3ZjcrLWpjZktE?=
 =?utf-7?B?VzU1TkI4cmxwVnpUYjQ2SW5hMXdvZjlHUTY1VnB5VE1SRlA4bFNWUHFmdjQ2?=
 =?utf-7?B?N3JsWjBvNzA2WUxCc1A5NWVpenJlMWtCVW5kTmJQek8yblhXdUM1UUhsNVZH?=
 =?utf-7?B?TXlRS1M3MkkyRkhkeUtmeXNvMU9PVjFjT2VEN1crLTFtbHMwV3BTZFVkSm05?=
 =?utf-7?B?ODMrLUxHOHQ5YTEvUnZKd1BHM0lYa0wxUHlkckIrLXFicFFPVkFyY0hheDF4?=
 =?utf-7?B?cGdwcnpwQVZhc1ZvNWoyREpHQmNZbG94YlJQUWNaYlRUd25WMmE2UnBOZDRa?=
 =?utf-7?B?STdCM09WVmNMbystSmJodzU2UVIySXNMSVJ0bnVtUnFHV3duaWErLXlzTElO?=
 =?utf-7?B?TFEvWmxjUTF2ZGtjZk1FU2UyWjg5Sm9ZQk5jWVhKSzJwc0o5TTM5bXFsR1NM?=
 =?utf-7?B?blhORDFpbzN2YVlTbjVVUmxFQ3FwZzFCL2FkNjdIZ3RtektFNno4TzNlbGhZ?=
 =?utf-7?B?dVNSSmdVbTBPd2F4S1M1SlE1bnQ0blVxOGdkTW1lbkdSL29VUlliL3JMNHRQ?=
 =?utf-7?B?dUdoM25lKy1oQkM2Nnlic2U4eXlBUG5JQm5RcXdMcmQvNWdmY2ZCaVJCVm9p?=
 =?utf-7?B?ZE1ZazBXWjgySUxDdE04aUpaODB5Zm12V1dxQ3VRdGRHY3FtdU1KZ2V2U0tJ?=
 =?utf-7?B?SnBuemhiV2dGTGhLbjI3MTRlbGhiMXdWMVAzOXFOQnRtb01DYWkzdTdIUE1w?=
 =?utf-7?B?MkQyMnV0cU1ETlZiWk03bkRqSTRlUld4c09WOCstbHhHa2VoQUZyTzZxUEwy?=
 =?utf-7?B?L0NtbTNVL3ljYnpvZnFJQkZ3NWZhSG9QSDA1Lzh1ZS9Udm8rLUdrUTUzRHo5?=
 =?utf-7?B?NVNQYVVQUnh5d09sSHRkbnlDY2ExZWdEcVUvVzNXSzljN0crLXp2cXJ4dHBi?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3a54e6-8461-40bd-4af3-08dcc36f41eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 12:29:39.4443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvBLBAHSnhFXHrnrDlBIx2iGKpoLlczjVgOVq8RZvsEeQm/YlNJ4MY/s5Y/VALFt21HeizuhY8nbeSHZ++eEJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6038
X-Proofpoint-GUID: flPRrAcutigSIma656c3rtuk1QypSwVK
X-Proofpoint-ORIG-GUID: flPRrAcutigSIma656c3rtuk1QypSwVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_09,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230090
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

Hi +AEA-Ilias Apalodimas,


ST Restricted
+AD4- -----Original Message-----
+AD4- From: Ilias Apalodimas +ADw-ilias.apalodimas+AEA-linaro.org+AD4-
+AD4- Sent: Monday, July 29, 2024 4:10 PM
+AD4- To: Benjamin BARATTE +ADw-benjamin.baratte+AEA-st.com+AD4-
+AD4- Cc: u-boot+AEA-lists.denx.de+ADs- akashi.tkhro+AEA-gmail.com+ADs-
+AD4- abdellatif.elkhlifi+AEA-arm.com+ADs- eajames+AEA-linux.ibm.com+ADs- x=
ypron.glpk+AEA-gmx.de+ADs-
+AD4- kojima.masahisa+AEA-socionext.com+ADs- sjg+AEA-chromium.org+ADs-
+AD4- sughosh.ganu+AEA-linaro.org+ADs- tharvey+AEA-gateworks.com+ADs- trini=
+AEA-konsulko.com
+AD4- Subject: Re: +AFs-PATCH 3/3+AF0- tpm+AF8-tcg2: hash algo optimization
+AD4-
+AD4- On Mon, Jul 15, 2024 at 01:33:19PM +-0000, Benjamin BARATTE wrote:
+AD4- +AD4- To properly enable code optimization with hash algorithm, all t=
he
+AD4- +AD4- reference of the hash algo should condition to hash enablement.
+AD4- +AD4- It is possible to fine tune the list of hash algorithms based o=
n dTPM
+AD4- +AD4- configuration.
+AD4- +AD4- Therefore if dTPM supports only one bank, on one hash algorithm=
 could
+AD4- +AD4- be selected (TCG PTP specification mention in case of single ba=
nk
+AD4- +AD4- support that SHA256 must be support and default value)
+AD4-
+AD4- Yes, but...
+AD4- In order to apply this we need a function that +ACo-configures+ACo- t=
he TPM with only
+AD4- the supported compiled algorithms.  If a TPM is configured with more =
than
+AD4- what u-boot supports, there might be security implications since we w=
ill fail to
+AD4- cap all active PCRs. On top of that the EFI TCG explicitly says that =
all the active
+AD4- PCR banks needs to be updated when extending measurements.
+AD4-

I'm agree with you, but this is more a configuration issue in that case.
Today to do such configuration, we need to do it with tpm2-tools under Linu=
x
But if U-boot is preventing the Linux kernel to boot, this will become prob=
lematic.
And U-boot API to configure the TPM PCR will be more than welcome in U-boot=
.

This will allow industrial user to manage this configuration in U-boot inst=
ead of Linux.

Best Regards,

Benjamin

+AD4- Thanks
+AD4- /Ilias
+AD4-
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Benjamin BARATTE +ADw-benjamin.baratte+AEA-st.co=
m+AD4-
+AD4- +AD4- ---
+AD4- +AD4-
+AD4- +AD4-  include/tpm-v2.h       +AHw-  8 --------
+AD4- +AD4-  lib/efi+AF8-loader/Kconfig +AHw-  4 ----
+AD4- +AD4-  lib/tpm+AF8-tcg2.c         +AHw- 38 +-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
+AD4- +AD4-  3 files changed, 38 insertions(+-), 12 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/include/tpm-v2.h b/include/tpm-v2.h index
+AD4- +AD4- 9848e1fd10..ec3504de44 100644
+AD4- +AD4- --- a/include/tpm-v2.h
+AD4- +AD4- +-+-+- b/include/tpm-v2.h
+AD4- +AD4- +AEAAQA- -285,38 +-285,30 +AEAAQA- struct digest+AF8-info +AHs-
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4-  static const struct digest+AF8-info hash+AF8-algo+AF8-list+AFs=
AXQ- +AD0- +AHs- -+ACM-if
+AD4- +AD4- IS+AF8-ENABLED(CONFIG+AF8-SHA1)
+AD4- +AD4-         +AHs-
+AD4- +AD4-                 +ACI-sha1+ACI-,
+AD4- +AD4-                 TPM2+AF8-ALG+AF8-SHA1,
+AD4- +AD4-                 TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA1,
+AD4- +AD4-                 TPM2+AF8-SHA1+AF8-DIGEST+AF8-SIZE,
+AD4- +AD4-         +AH0-,
+AD4- +AD4- -+ACM-endif
+AD4- +AD4- -+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA256)
+AD4- +AD4-         +AHs-
+AD4- +AD4-                 +ACI-sha256+ACI-,
+AD4- +AD4-                 TPM2+AF8-ALG+AF8-SHA256,
+AD4- +AD4-                 TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA256,
+AD4- +AD4-                 TPM2+AF8-SHA256+AF8-DIGEST+AF8-SIZE,
+AD4- +AD4-         +AH0-,
+AD4- +AD4- -+ACM-endif
+AD4- +AD4- -+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA384)
+AD4- +AD4-         +AHs-
+AD4- +AD4-                 +ACI-sha384+ACI-,
+AD4- +AD4-                 TPM2+AF8-ALG+AF8-SHA384,
+AD4- +AD4-                 TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA384,
+AD4- +AD4-                 TPM2+AF8-SHA384+AF8-DIGEST+AF8-SIZE,
+AD4- +AD4-         +AH0-,
+AD4- +AD4- -+ACM-endif
+AD4- +AD4- -+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA512)
+AD4- +AD4-         +AHs-
+AD4- +AD4-                 +ACI-sha512+ACI-,
+AD4- +AD4-                 TPM2+AF8-ALG+AF8-SHA512,
+AD4- +AD4-                 TCG2+AF8-BOOT+AF8-HASH+AF8-ALG+AF8-SHA512,
+AD4- +AD4-                 TPM2+AF8-SHA512+AF8-DIGEST+AF8-SIZE,
+AD4- +AD4-         +AH0-,
+AD4- +AD4- -+ACM-endif
+AD4- +AD4-         +AHs-
+AD4- +AD4-                 +ACI-sha3+AF8-256+ACI-,
+AD4- +AD4-                 TPM2+AF8-ALG+AF8-SHA3+AF8-256,
+AD4- +AD4- diff --git a/lib/efi+AF8-loader/Kconfig b/lib/efi+AF8-loader/Kc=
onfig index
+AD4- +AD4- ee71f41714..512fb710b5 100644
+AD4- +AD4- --- a/lib/efi+AF8-loader/Kconfig
+AD4- +AD4- +-+-+- b/lib/efi+AF8-loader/Kconfig
+AD4- +AD4- +AEAAQA- -405,10 +-405,6 +AEAAQA- config EFI+AF8-TCG2+AF8-PROTO=
COL
+AD4- +AD4-         bool +ACI-EFI+AF8-TCG2+AF8-PROTOCOL support+ACI-
+AD4- +AD4-         default y
+AD4- +AD4-         depends on TPM+AF8-V2
+AD4- +AD4- -       select SHA1
+AD4- +AD4- -       select SHA256
+AD4- +AD4- -       select SHA384
+AD4- +AD4- -       select SHA512
+AD4- +AD4-         select HASH
+AD4- +AD4-         select SMBIOS+AF8-PARSER
+AD4- +AD4-         help
+AD4- +AD4- diff --git a/lib/tpm+AF8-tcg2.c b/lib/tpm+AF8-tcg2.c index
+AD4- +AD4- 7f868cc883..66573b838d 100644
+AD4- +AD4- --- a/lib/tpm+AF8-tcg2.c
+AD4- +AD4- +-+-+- b/lib/tpm+AF8-tcg2.c
+AD4- +AD4- +AEAAQA- -96,9 +-96,15 +AEAAQA- int tcg2+AF8-create+AF8-digest(=
struct udevice +ACo-dev, const u8
+AD4- +ACo-input, u32 length,
+AD4- +AD4-                        struct tpml+AF8-digest+AF8-values +ACo-d=
igest+AF8-list)  +AHs-
+AD4- +AD4-         u8 final+AFs-sizeof(union tpmu+AF8-ha)+AF0AOw-
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA256)
+AD4- +AD4-         sha256+AF8-context ctx+AF8-256+ADs-
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA384) +AHwAfA- IS+AF8-ENA=
BLED(CONFIG+AF8-SHA512)
+AD4- +AD4-         sha512+AF8-context ctx+AF8-512+ADs-
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA1)
+AD4- +AD4-         sha1+AF8-context ctx+ADs-
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4-         u32 active+ADs-
+AD4- +AD4-         size+AF8-t i+ADs-
+AD4- +AD4-         u32 len+ADs-
+AD4- +AD4- +AEAAQA- -114,30 +-120,38 +AEAAQA- int tcg2+AF8-create+AF8-dige=
st(struct udevice +ACo-dev, const
+AD4- u8 +ACo-input, u32 length,
+AD4- +AD4-                         continue+ADs-
+AD4- +AD4-
+AD4- +AD4-                 switch (hash+AF8-algo+AF8-list+AFs-i+AF0-.hash+=
AF8-alg) +AHs-
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA1)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA1:
+AD4- +AD4-                         sha1+AF8-starts(+ACY-ctx)+ADs-
+AD4- +AD4-                         sha1+AF8-update(+ACY-ctx, input, length=
)+ADs-
+AD4- +AD4-                         sha1+AF8-finish(+ACY-ctx, final)+ADs-
+AD4- +AD4-                         len +AD0- TPM2+AF8-SHA1+AF8-DIGEST+AF8-=
SIZE+ADs-
+AD4- +AD4-                         break+ADs-
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA256)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA256:
+AD4- +AD4-                         sha256+AF8-starts(+ACY-ctx+AF8-256)+ADs=
-
+AD4- +AD4-                         sha256+AF8-update(+ACY-ctx+AF8-256, inp=
ut, length)+ADs-
+AD4- +AD4-                         sha256+AF8-finish(+ACY-ctx+AF8-256, fin=
al)+ADs-
+AD4- +AD4-                         len +AD0- TPM2+AF8-SHA256+AF8-DIGEST+AF=
8-SIZE+ADs-
+AD4- +AD4-                         break+ADs-
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA384)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA384:
+AD4- +AD4-                         sha384+AF8-starts(+ACY-ctx+AF8-512)+ADs=
-
+AD4- +AD4-                         sha384+AF8-update(+ACY-ctx+AF8-512, inp=
ut, length)+ADs-
+AD4- +AD4-                         sha384+AF8-finish(+ACY-ctx+AF8-512, fin=
al)+ADs-
+AD4- +AD4-                         len +AD0- TPM2+AF8-SHA384+AF8-DIGEST+AF=
8-SIZE+ADs-
+AD4- +AD4-                         break+ADs-
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA512)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA512:
+AD4- +AD4-                         sha512+AF8-starts(+ACY-ctx+AF8-512)+ADs=
-
+AD4- +AD4-                         sha512+AF8-update(+ACY-ctx+AF8-512, inp=
ut, length)+ADs-
+AD4- +AD4-                         sha512+AF8-finish(+ACY-ctx+AF8-512, fin=
al)+ADs-
+AD4- +AD4-                         len +AD0- TPM2+AF8-SHA512+AF8-DIGEST+AF=
8-SIZE+ADs-
+AD4- +AD4-                         break+ADs-
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4-                 default:
+AD4- +AD4-                         printf(+ACIAJQ-s: unsupported algorithm=
 +ACU-x+AFw-n+ACI-, +AF8AXw-func+AF8AXw-,
+AD4- +AD4-                                hash+AF8-algo+AF8-list+AFs-i+AF0=
-.hash+AF8-alg)+ADs- +AEAAQA- -236,10
+AD4- +AD4- +-250,18 +AEAAQA- static int tcg2+AF8-log+AF8-init(struct udevi=
ce +ACo-dev, struct
+AD4- tcg2+AF8-event+AF8-log +ACo-elog)
+AD4- +AD4-                         continue+ADs-
+AD4- +AD4-
+AD4- +AD4-                 switch (hash+AF8-algo+AF8-list+AFs-i+AF0-.hash+=
AF8-alg) +AHs-
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA1)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA1:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA256)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA256:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA384)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA384:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if  IS+AF8-ENABLED(CONFIG+AF8-SHA512)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA512:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4-                         count+-+-+ADs-
+AD4- +AD4-                         break+ADs-
+AD4- +AD4-                 default:
+AD4- +AD4- +AEAAQA- -337,10 +-359,18 +AEAAQA- static int tcg2+AF8-replay+A=
F8-eventlog(struct
+AD4- tcg2+AF8-event+AF8-log +ACo-elog,
+AD4- +AD4-                         algo +AD0- get+AF8-unaligned+AF8-le16(l=
og +- pos)+ADs-
+AD4- +AD4-                         pos +-+AD0- offsetof(struct tpmt+AF8-ha=
, digest)+ADs-
+AD4- +AD4-                         switch (algo) +AHs-
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA1)
+AD4- +AD4-                         case TPM2+AF8-ALG+AF8-SHA1:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA256)
+AD4- +AD4-                         case TPM2+AF8-ALG+AF8-SHA256:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA384)
+AD4- +AD4-                         case TPM2+AF8-ALG+AF8-SHA384:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA512)
+AD4- +AD4-                         case TPM2+AF8-ALG+AF8-SHA512:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4-                                 len +AD0- tpm2+AF8-algorithm+AF=
8-to+AF8-len(algo)+ADs-
+AD4- +AD4-                                 break+ADs-
+AD4- +AD4-                         default:
+AD4- +AD4- +AEAAQA- -450,10 +-480,18 +AEAAQA- static int tcg2+AF8-log+AF8-=
parse(struct udevice +ACo-dev,
+AD4- struct tcg2+AF8-event+AF8-log +ACo-elog)
+AD4- +AD4-                         return 0+ADs-
+AD4- +AD4-
+AD4- +AD4-                 switch (algo) +AHs-
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA1)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA1:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA256)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA256:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA384)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA384:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4- +-+ACM-if IS+AF8-ENABLED(CONFIG+AF8-SHA512)
+AD4- +AD4-                 case TPM2+AF8-ALG+AF8-SHA512:
+AD4- +AD4- +-+ACM-endif
+AD4- +AD4-                         len +AD0- get+AF8-unaligned+AF8-le16(+A=
CY-event-+AD4-digest+AF8-sizes+AFs-i+AF0-.digest+AF8-size)+ADs-
+AD4- +AD4-                         if (tpm2+AF8-algorithm+AF8-to+AF8-len(a=
lgo) +ACEAPQ- len)
+AD4- +AD4-                                 return 0+ADs-
+AD4- +AD4- --
+AD4- +AD4- 2.34.1
+AD4- +AD4-
+AD4- +AD4- ST Restricted
