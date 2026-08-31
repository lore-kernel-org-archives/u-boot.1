Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE79C624A5
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 07:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 704C4605D4;
	Mon, 31 Aug 2026 07:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TaoUSKbnEVdQ; Mon, 31 Aug 2026 07:47:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788162479;
	bh=Rhj0J0jcKLc81fAJXWB4dFATfZyX/n1Fjc/gnzv3cHM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdS7122n51imS7sbh2s4a0I3Qid+M/LSAM31y8swvMeF3qE3kjnxMixSS/gKO80mN
	 6/A1DHQxdkRJffrU1di85RkAVUDTBreh5twWcgxYfzh95X3VRqDUBjR6saS9F4rAxi
	 9cxvHyTORUiYWvBOg7wEPkNc5k+J+VL7oLLWDSLCnbmv3Q/EA5F1vpFGicHksrASNa
	 NWhrEjWNGAHRslKNzjG/TZnDJSdDaeYQTgisbOWEZkgNw7+AoosMnnXgV2KhLxoAd0
	 W21zR54ISwCipy4eKTHo2QA6IBK9vUMlen4eaKaaSWEcrnX24Ii/itwlmc0ryms667
	 q+lrplw0/m8gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4066B605DF;
	Mon, 31 Aug 2026 07:47:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80B0A2FC
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72E8740073
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3ns2s9kJ2aK for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 07:47:57 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=VoU18dbh
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8577640056
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS2eB/jw/8y8bzaVybZQ6Q6qHwXW5/qrRoIbu1FO4ZADRYB+E6JOHCRvSMlT0irPsKaUEU+PILfhQ8t+yxKlWqb8kOv+frsZqwow8vkVVpPfXvPxQpN6Tv235HDsHRSamjYegRNpmbLfsQ0kLqa2UOK8EMEpqSWKzj5yaEMsJNkeT2+WfujYBQiJbyVGSvmzj86LQsARwtA6HsWmz+1QxeMPMEPGA47Dp9cSOsJFoYnKVePPR/xYhwSGvKuxiirUn5/3vty0dS5FUHRBvf+G0ZbTRNQiiHH0DJ1Il2UOU7UXCX73c0gZvKL9bYAENppuEsEtSv8fkWVs4aj8hi+Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rhj0J0jcKLc81fAJXWB4dFATfZyX/n1Fjc/gnzv3cHM=;
 b=BY6/pAm6ySeBSY8/+nHUwCDQsqOW8CrqpSqabofHYPORCYyf4xrVsMqu1tb/UC23Sv/AB/54XTp/O0/eoptrfkDmD5wNND+7Ugtjs5Lqb1d5cz1oLKvGZv49D+Sm+EbfaoblaiqdUjNY4RO79En2EdY8yvnECifmBiiKyYVNxyZ+kuXlQVS9NzNPmnBPtEVCjVSrl++PRdak3Q1nBWVv8EjlBRO2ANAoKCmZ7qRwUeCwq8vqZOYcjDiVeuXaOW3WOfkAQzUSpAZF1uApMO75oP3vzsbKF4gbY4vGGUq9M0AvVry7D+i4IYC99AtDb0t/zywbwsgWXSh5Yn5KXvjslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhj0J0jcKLc81fAJXWB4dFATfZyX/n1Fjc/gnzv3cHM=;
 b=VoU18dbhuJTvFmnCpWtl8JtDQxYCW4w3HCRxplJkyyzFClTVbkU2mMp/YNvIt40jARkwZSrXDal68EAW+XlX533ZAsKyBuP5huoxilPbvXpQXnghptnJTwImU3zDmvJb6ezyDC4h04bEzoPa7JK66NqoT6zA+bK+kxI17HlWDfapvWu7XeaAErVLDZU8gpznfCP8QJjkhQ6BKkeZgNlgmUtN+4TqVwkBi2N+Zj3hSMaqmkHPfRV97IRLgfBnZ8TNULMDHIi3nMErVvkqNEPMMdsmHL31aR5eYLMdq2MiVj5//fERPQpY3D+QhiwDh3dAIz7iEOuMd8HWKGGRaoD1/A==
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:47:51 +0000
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5]) by AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:47:51 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, Johan Jonker <jbx6244@gmail.com>, Primoz Fiser
 <primoz.fiser@norik.com>, Lei Xu <lei.xu@nxp.com>, Joseph Guo
 <qijian.guo@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC80XSBib2FyZDogaW14OTNfZXZrOiBhZGQg?=
 =?utf-8?Q?i.MX93W_EVK_support?=
Thread-Topic: [PATCH v2 0/4] board: imx93_evk: add i.MX93W EVK support
Thread-Index: AQHdLtkVrVsm0UdifES7YYm94+f78La33FIQ
Date: Mon, 31 Aug 2026 07:47:51 +0000
Message-ID: <AS8PR04MB8721F91D2C6A43E006262368E2A92@AS8PR04MB8721.eurprd04.prod.outlook.com>
References: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
In-Reply-To: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-31T07:46:16.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8721:EE_|AS8PR04MB8690:EE_
x-ms-office365-filtering-correlation-id: 85e84e5a-6a73-4318-219f-08df07342901
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|23010399003|366016|56012099006|10067099003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: UtpTTo2NZnu7S87lI27FzXjaLRtlGP/5GZd6FzvglwiPPZenkti6whobrpe6iGHahpYtsk8C/9sPE1hWgVY8bXUnZRWW+10wEZFW19au/t+nEy5pbPkCFVENP5QSs0B8XfZZKuRvzG4WyBwxHI3W/e0xwyLbKt490sesruj0Rx6qTRwf1gdBtDSfarogxWB8Lee5KBTArxPlS9g6nEg7VqmIWCQ9ncpQyiHzQDRlvtJjIX5qraucuSsyIo7vvhS/8L5PIucFv44bhVodzEhZOtUpeCoEKv9GGyq/xp19EqCVexLfZgxyhksLMbodsan8Xt2J3tlEHoYHqCPGhz04xWOGF83v0CI1wgBK+qg8CnH3wdLM59EHzhUHBWX8Xhl8PxzVPcWTLdzittX02ckvSmpPxK4AbKKMB0RZH/gxUaSenAc6DgcRbkmaIAjV8XRQKOXS6cJb5OFbTFLQXD7egz88YgPEko+djbKHsCsLZ1ZicqcB8d38QdxSVJwxyhx8I3o8iItIHNzcagRqBiNlvuhNxYTmLukz6mFJBkx8womV4hWwic3kbnqKX/ctSVbWrw9HfMYzdHpB4iTomLkrQTMNgssUqyad1aAhN1l7oTN+hVIw40Y5A4bkRgKZQFwRKM6BFJjXzM87rXSpAg6n5NteiislL8HPba5JAHWfc6AVFuU5vvSEIXBKksw9bB2uoOpcVinfitJYpcmkVJ2fTL+SFUyXURdo201emj4aO1Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8721.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGxpSGFnQS9xSlBtTzUvN2FVa1dnUDNJUTFISjlQSGVoOTRqOEFheDF6eEZG?=
 =?utf-8?B?bFIrTzAxUUpsYXpKWjU5dzJ4S3ZZRE9oVVhYd3hzS3BuNnJDcmtSTGxFaTVr?=
 =?utf-8?B?VG9adkNSS0JxTHdHQmFzYzVyRW43WkxTMHVUYlVVTlhnRXg2Nk1UZWR3WHhW?=
 =?utf-8?B?V2V3WjZVN1FrNWxvUjgxMlE1NVcxVitSWjFOYmJXQkt0bkVadmlwU3NhaVpC?=
 =?utf-8?B?ciszalFUbmtYRVZNOE9jNWl6ODV5Q3JiRWZSMUhvNmVicVI0NXNBckpyTnBx?=
 =?utf-8?B?UkIrcTE4dlFmMkNzRGszTmJSN2tIckU5SUU2ZjBweGt0aTR4dGQxSnIyd3ZO?=
 =?utf-8?B?ZFEybzFlQ3c0M1lHSEFlMUQ3RmhRWk13bGo5Mi93LzFoS29zOVNRODJ4bVND?=
 =?utf-8?B?Y1B2aDZLRGliaWFRZEVuQmJZSkQvUCt3Znk0K0FoNFpDT1Bzc3lWRHVTVDNq?=
 =?utf-8?B?SE9NbEppYnpQK2dxcFJYR0FsSkFXMjVYd1VmUFFjc0JDOXBHSHNKZGl1ZHAy?=
 =?utf-8?B?elJPbFBqR3ZXUmcrVEZUWkpMS1dXL2FBS3JqQ1NjemZpV3RYNWN6SXE4dGpx?=
 =?utf-8?B?cXRPTE9hVmIzL1BDb2p6WnFPK0ZaRGk5byt2bktKbittNHJxNFJndi90OWdY?=
 =?utf-8?B?MmRrS2RPMUxpU20zTFdYOW1WL0tidEhlMVM3MUYxa3NmbGR1dWVzeDNmYllq?=
 =?utf-8?B?aFhSbUtqejdWMjNuMnQ5RnBsZkFZVWdXb3hsM285Nlo2VVBUaWFvWjRjOUlE?=
 =?utf-8?B?TldRbmNTcFlnQW5aUG5rNlh3MTY2eXNtOTBiZVM5T0grcmgyU1Qrd01COW42?=
 =?utf-8?B?bUgzcG95L0tRYy9tc3Z6Q29FNHJmTUxwSzBodkk4bjgwNXdhSVFxUmxncnBh?=
 =?utf-8?B?Y2M5S3dvT3pjdXJlMTdHR1ZiVDJYcmpxazJxZU1TQndlV1pDTWFOeFQ0Nk50?=
 =?utf-8?B?aHVyaVJxRUNJVHdJYXk4M0JNdTk3KzlVNkJZdmtlZXlRd2pKY1NxZi90Q0Iw?=
 =?utf-8?B?MFZKWDBQK2I5eFhvbkJiQ1N2ejc3L3RuSjRQdGR2ZHlFekVKdkNtSVV1NnVF?=
 =?utf-8?B?cFJIRU5uekhzMC85NTJiRC9aVFY1WlY2UjFKblRCRHVlR0VIWE1IMkwyWk1J?=
 =?utf-8?B?VklnU2pnZEVxclMzMEpYVlpzeENnZEw4U2VCY2JIS1FkRkNoWWhsK2dYUzA4?=
 =?utf-8?B?MnJoODFSUkhEYkQxMWNNMCt6bkRqU1FtbHd1VG1iNXh4KzhDSWdjWUhzU1dx?=
 =?utf-8?B?amRjaDBYcU16MXZQWTUwUFl0SDRDUGxLL2dGZzdLelM3TjVVQ0E5VzJReFRN?=
 =?utf-8?B?TGJCQzYvcS9JUDdjZ043WlMwbHhpL3ZZVGxlSjFRN2pyU3NxNzFscjJUWDJO?=
 =?utf-8?B?Z3JDQnRwK1B5M3YvMS9HaHc5U24vUkNYTTNnbEo5Kzd0NUpqckowTUZFL1pS?=
 =?utf-8?B?SXErbXBUeVBWY29WRGRLaE85YXByNE1BNFNHRzFuaEREL3Y1TnJBallqV0xY?=
 =?utf-8?B?NVV4Vk9PLzVTcG15SVJISTIrWFlsaDJvdlFpRlhSR0JQTDVac1NheWhtL3hw?=
 =?utf-8?B?QkpuUmwyYkYrUWZTS2tkaE9yUzA5azNvRjVob0VaWTZVcXRySGsxamFjR1NJ?=
 =?utf-8?B?K1FjcTRNcWx2NnVONS9XRVhWbGkvM2ZuTnNQZmUvdVFhSEYzcFFiZjJrbm9B?=
 =?utf-8?B?T1huTng3S2ZZdlQ5UVoxNVNkemFwTGpWUmZIRFYzRlN4RGxMcjc1aDVOalJw?=
 =?utf-8?B?L1dQbS94UFpDQXYrWVZjQnpTWHkvcURZeFhzMUUxNmdhcGlMa1ZLZmd5MlV6?=
 =?utf-8?B?TERETGhzeVl0OEJOTVphSnMzZkdqWFlNWG1pQ09NbnkrTW1YcFc5Yy9tTEtF?=
 =?utf-8?B?cnpzWlpSQldlQndSc3V3YjJQWmtpKzhubmszTVRJbW1Lc2pQL1ZjeHhzcTRI?=
 =?utf-8?B?UURRSGFMM1BrbkRhT0ZLejR2RVN6aGs1UFI5Sk10UHF4WGFJSnJTOW9nY0dF?=
 =?utf-8?B?blI5RXZDUzNnOUtMSUt3UWlFdW9YK3p2a3R4YlJjYU51N0t1T0JmbE5TTFps?=
 =?utf-8?B?L290K2VvYk9KU0NTWlh4RXhKTG1NYWZ5WVBqZnhrVWZRZGtweUUrY1RPZERZ?=
 =?utf-8?B?R3ZndE9mVmNWLzNzWSs5MUhMQWRHSkFHV0x3NGJDWG9KYm5XbjlMN3lIcTNu?=
 =?utf-8?B?RUhBUGNSVCtZKzdhUUFDYXI1V1llbVlKM3hsajUxRVI1emVSTHlnVDd4S2JK?=
 =?utf-8?B?ZjZqSmM5SjNaVnkrMmhKQzZYQ1VLMGc0bDJFaHV2eGJPa2xMRWpCd1psNHRu?=
 =?utf-8?Q?/kzPZ5OwxNHaBNL05x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8721.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e84e5a-6a73-4318-219f-08df07342901
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 07:47:51.6835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dz4D1BsH2R4xw5zId6WMlXSHuUT7kzsJOIBokr8GP+PQL+E2a7G1bnRndcVJTbN33i1jK+r+exUoV9swxKG7Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6
OiBBbGljZSBHdW8gKE9TUykNCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0OOaciDE45pelIDE0OjE2
DQo+IOaUtuS7tuS6ujogZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47IHUtYm9vdEBs
aXN0cy51LWJvb3QtcHJvamVjdC5vcmcNCj4g5oqE6YCBOiBUb20gUmluaSA8dHJpbmlAa29uc3Vs
a28uY29tPjsgSWxpYXMgQXBhbG9kaW1hcw0KPiA8aWxpYXMuYXBhbG9kaW1hc0BsaW5hcm8ub3Jn
PjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IEZhYmlvDQo+IEVzdGV2YW0g
PGZlc3RldmFtQGdtYWlsLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPjsgUGVuZyBGYW4NCj4g
PHBlbmcuZmFuQG54cC5jb20+OyBKb2hhbiBKb25rZXIgPGpieDYyNDRAZ21haWwuY29tPjsgUHJp
bW96IEZpc2VyDQo+IDxwcmltb3ouZmlzZXJAbm9yaWsuY29tPjsgTGVpIFh1IDxsZWkueHVAbnhw
LmNvbT47IEpvc2VwaCBHdW8NCj4gPHFpamlhbi5ndW9AbnhwLmNvbT47IEFsaWNlIEd1byA8YWxp
Y2UuZ3VvQG54cC5jb20+DQo+IOS4u+mimDogW1BBVENIIHYyIDAvNF0gYm9hcmQ6IGlteDkzX2V2
azogYWRkIGkuTVg5M1cgRVZLIHN1cHBvcnQNCj4NCj4gVGhpcyBzZXJpZXMgYWRkcyBVLUJvb3Qg
c3VwcG9ydCBmb3IgdGhlIE5YUCBpLk1YOTNXIEVWSyBib2FyZCwgYSB2YXJpYW50IG9mDQo+IHRo
ZSBpLk1YOTMgRVZLIHRoYXQgdXNlcyBMUEREUjRYIG1lbW9yeSBydW5uaW5nIGF0IDM2MDAgTVQv
cy4NCj4NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBSZW1vdmUgZGVmY29uZmlnIGR1cGxpY2F0aW9u
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+IC0t
LQ0KPiBBbGljZSBHdW8gKDIpOg0KPiAgICAgICBpbXg5MzogY2xvY2s6IGFkZCA5MDBNSHogZW50
cnkgdG8gZnJhY3Rpb25hbCBQTEwgcmF0ZSB0YWJsZQ0KPiAgICAgICBib2FyZDogaW14OTN3X2V2
azogYWRkIGJvYXJkIHN1cHBvcnQgZm9yIGkuTVg5M1cgRVZLDQo+DQo+IFllIExpICgyKToNCj4g
ICAgICAgaW14OTM6IGNsb2NrOiBhZGQgNDUwTUh6IEREUiBQTEwgcmF0ZQ0KPiAgICAgICBib2Fy
ZDogaW14OTNfZXZrOiBhZGQgTFBERFI0WCAzNjAwTVRTIHRpbWluZyB0YWJsZXMNCj4NCj4gIGFy
Y2gvYXJtL2R0cy9pbXg5M3ctZXZrLXUtYm9vdC5kdHNpICAgICAgICAgICAgICB8ICAxNzEgKysN
Cj4gIGFyY2gvYXJtL21hY2gtaW14L2lteDkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAg
MTIgKw0KPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9jbG9jay5jICAgICAgICAgICAgICAgICAg
IHwgICAgMiArDQo+ICBib2FyZC9ueHAvaW14OTNfZXZrL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAyICstDQo+ICBib2FyZC9ueHAvaW14OTNfZXZrL01BSU5UQUlORVJTICAgICAg
ICAgICAgICAgICAgfCAgICAyICsNCj4gIGJvYXJkL254cC9pbXg5M19ldmsvTWFrZWZpbGUgICAg
ICAgICAgICAgICAgICAgICB8ICAgMTIgKw0KPiAgYm9hcmQvbnhwL2lteDkzX2V2ay9scGRkcjR4
X3RpbWluZ18zNjAwbXRzLmMgICAgIHwgMTk5OA0KPiArKysrKysrKysrKysrKysrKysrKysNCj4g
IGJvYXJkL254cC9pbXg5M19ldmsvbHBkZHI0eF90aW1pbmdfMzYwMG10c19lY2MuYyB8IDE5OTkN
Cj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiAgY29uZmlncy9pbXg5M3dfZXZrX2RlZmNvbmZp
ZyAgICAgICAgICAgICAgICAgICAgIHwgIDE3MiArKw0KPiAgY29uZmlncy9pbXg5M3dfZXZrX2lu
bGluZV9lY2NfZGVmY29uZmlnICAgICAgICAgIHwgICAgMyArDQo+ICBkb2MvYm9hcmQvbnhwL2lt
eDkzd19ldmsucnN0ICAgICAgICAgICAgICAgICAgICAgfCAgIDcyICsNCj4gIGRvYy9ib2FyZC9u
eHAvaW5kZXgucnN0ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiAgZHJpdmVy
cy9kZHIvaW14L3BoeS9kZHJwaHlfdXRpbHMuYyAgICAgICAgICAgICAgIHwgICAgNCArDQo+ICAx
MyBmaWxlcyBjaGFuZ2VkLCA0NDQ5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gLS0t
DQo+IGJhc2UtY29tbWl0OiA1MjcxMTVlZjY3ODNjZWM0OWU1NjEwYzUyM2MxMjRiMzk5MDExMzYx
DQo+IGNoYW5nZS1pZDogMjAyNjA4MTgtaW14OTN3LTg0ODRjYzgyM2JjMA0KPg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IC0tDQo+IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQoNCkhpLA0KDQpH
ZW50bGUgcGluZyBvbiB0aGlzIHBhdGNoIHNldC4gQ291bGQgc29tZW9uZSBwbGVhc2UgdGFrZSBh
IGxvb2sgd2hlbiBjb252ZW5pZW50Pw0KDQpUaGFua3MsDQpBbGljZQ0KDQo=
