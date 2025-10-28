Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EAACCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB6D83987;
	Tue, 28 Oct 2025 09:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Uzl4ewUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD76A839A1; Tue, 28 Oct 2025 09:00:33 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8265783976
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFXiJvlZ94Zrlp/1+AWPKd+0eeQWjGQp99AKhdi3oGrf2cmB8w+N5faVwBuN8tJIwlWq0R+s33Qo+v8JHbR75J4FhZkhJ9N9L8OuEwVtJs4LtKwN8yLUsmlUKxIT3pVjiZz0YZjjpNCnENEgKawdgarHFh1sLA/EIHlqRpyBI6+tDTjbMHe8kMxhZ/dvrUqpUZdrVxC9pZP38WhNrH3LE9+3/XaAaSVSa5dlW8OrMoUbS70L/RFy20I0G/JFBV9/YO3fXKFkHfK2BxlrQXvXTnKIA8PVY5fY25MoOLMoJ0qItC3zvu1evvs2odhH0dIs6TV/EOmjcqO+tXLkhOuQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv1YZOnF1i62DsXTDqJhdu/8y5pW2EuDk7Eg4ZlfdWI=;
 b=rf5Vgo8uu1RHAVCrc851nG1RLT4TJfdBtAuLQmPMjER+ipBD1P0EeCiYYBvD8YTwu+9+AJe5i8SC9p0ndFBOY8Hv9Q5jGBdFHPniNClhqVIInMWjzgxVNoD4XbhUbNCmMq4RK/asUiyGaMDBhhVjssCCrb1j18KylC1/Px/qngPlpxFzPCK8hb0q5WZOWHHmMtm3jIbv3NQrfuIVx+e/x4UsKkJAWJezc8lay9D+vEAIVLpodeQ7yZyVSyc3Khkxvv/OtRFJadH6URXzbHdFhEzC2QSQCdTYCZTGpQsUG0lTvQx+LZyKKkiokBqHSYMt30fpy/Ig9ISrGOt9HW9bfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv1YZOnF1i62DsXTDqJhdu/8y5pW2EuDk7Eg4ZlfdWI=;
 b=Uzl4ewURMSO7JPsUrMPwFIoeUfoh9nC0NqVI3dF71IyY/yH93on9HgLrQEO3NGa7aoXfLXSljTxWtPDyE+d37umhC9rcNSNy6ODdPjSbsfuZ/zlIal8ac2PRVbrteMHozqsXp9SBzlQTxNaIidZLLsb/jnJMa0ArQeAONVPcdmhLAxYpIAdmS/ahiaXo00jzX0KFqVcv6/g/oFq4Bkgisqjkl87mPTSK67FhGWNvS+sznMoNUcFxINGP9JIsoOzcaO1b97mG7GccMMCg7Gqb9kfEWyppfaHsi1JzvEvX+VNp1/gZicuW6he5Kf4F4Z0gJceKEdVsYYh6l2vfe3vF+w==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8522.eurprd04.prod.outlook.com (2603:10a6:20b:431::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 08:00:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 08:00:28 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Etienne Carriere
 <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogRHJvcCBtbXVfc2V0X3Jl?=
 =?gb2312?B?Z2lvbl9kY2FjaGVfYmVoYXZpb3VyKCkgbWlzdXNl?=
Thread-Topic: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
Thread-Index: AQHcR+DsVDQcTzqDsEmZCx0ooY/C6w==
Date: Tue, 28 Oct 2025 08:00:28 +0000
Message-ID: <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8522:EE_
x-ms-office365-filtering-correlation-id: cdd2a96f-51e3-4a5b-ead2-08de15f80f0c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?gb2312?B?aUlnaU9neG94NXZHT3hTbXVmanNFRFFGSW5CSHdLbEtoeWFXaUlTK1U4U2tz?=
 =?gb2312?B?d2hGcG50ejd1SDV6M0g5NUF4YTFodkNpWjZDbkY5eld2MGJQODMvTldHbTJQ?=
 =?gb2312?B?Mk84aHk1YjNjQkFMYVpqdUlCdWszUVVMbko2YTBCelhQUDJKWXJtRWtlWENl?=
 =?gb2312?B?ZmJGYkpUNUVxaklNNjJYT3ppNVhyYk51eCtmUjJmcmNKOWE2bDJxSDhHMG55?=
 =?gb2312?B?Rjl5RGJlNnZHTXpPcGh0RGR1YURTTmNucHhLVzJnN3dHNldId2FwK2ZUNlEw?=
 =?gb2312?B?elIvOXpPTWhUaGlGcDg1Rmg5ZlM4alBXVlBpMm5nd2M3V0t5bVVCam1Xc2t0?=
 =?gb2312?B?RkhlczQ0ME9HQUtVNUdpU29TWjZtS1U3Y3JlcG1tb2pybGdTcW5PTCtOY1M1?=
 =?gb2312?B?bWs4VDYvWXptKzZLTjRIa0d4RTJ4MHJLaG9HaTJ6TzRtd2R0OGJCNEhpUFpE?=
 =?gb2312?B?OW9CSi9MeUROTUphOXFjMUR2K3IrUXFlaWQ1V3AyUExJUXRZNC9WWEYzSnB1?=
 =?gb2312?B?SDBpN2VQeWEvMlFONHJSSlp6MUh0RnN6dXJlK1VMaHhCM2YwZEdteGdnNlFR?=
 =?gb2312?B?eFhlUnhYemowRmQvMzlJYUt0aDVTY0dZVlFwdEY4WGpYRGRZRjVLQjJoVDZS?=
 =?gb2312?B?a0d1RDJ4aWxFUXdrSVdjWjB0T2FzZUF4T09QV2xuZTNJNlZhZ0NpMnFLam1O?=
 =?gb2312?B?cXdiRTBMMUQrcE1vR0lRUEJTb0kxTlN4bThUWVNjcXhuRXBNVjZua0owcDdW?=
 =?gb2312?B?QTE0STd0T1BQRjJiQTUyazNxWlc3dmFyNUUraDZESjhKMlhmWCtLWXdPWU15?=
 =?gb2312?B?OUlKei9jdzR3a2F0d0RSMHhBTFlVU1JJZlJkTjVyZCt2MlljdmdTUkZZNW5j?=
 =?gb2312?B?b2QwOWJVRWV1YjUxQXJqMzZGWXNpZCtheUlJVDdxRStPVnY3bkZHL05NTUF0?=
 =?gb2312?B?aU9QUXhOME94TUxuMzQzbDBIQndIWFd6SU51TUtES0xFdHlxdXF2VlBObjJB?=
 =?gb2312?B?UDJqSVQxN1UwVW9LM3Myb3RsbmFjay9YV0dIbFFkMUZwMUkzOHAyQXFWM04y?=
 =?gb2312?B?S0hZZUNwSEh2SmVIUzIrR1BENXMvS0ZTYXZhSWZqWE9yVkc2WXVPWkdvd1gy?=
 =?gb2312?B?Z2pGbzZGbmZEVlhiVnNOb3I0aDJVZTdWb3JoUzQrSGVtbTVrd2RlOXl6MzNv?=
 =?gb2312?B?a2dISEJITlFONm02eG52MTF1anoxTWpTOWtFYjJRYU9IU3RrRzRvNGpTTmVk?=
 =?gb2312?B?aEtiUzlIM0NUUFcybWFJY2s0azFOUFdmVDRPeTUrdVAybExVdEhwTC9TcTVw?=
 =?gb2312?B?L2wrblhBMWd5eFR3ZVJKMzBRWitTN0w1b0hkMjVVTUtNMnVBc1F4OWgxQ3Bp?=
 =?gb2312?B?MXkyQjc5cXBNaFN1M0ZqaHNHTlRNN2hIV3VkeFhYMXdoYjNXZUJUVHBlclJw?=
 =?gb2312?B?WXloRURoMk10WnVTYTBzbE5XRHRFeHBncUpFcm5yVUo4dnFlQnZqNjkwNzdT?=
 =?gb2312?B?Umk4bWd0SmFRUzM3ZUphdlZVdjZoVWNWSFFsMjlaRVVPZXFNY3drbDFCdXZS?=
 =?gb2312?B?bGczMkNJeVpQcGFWck1WMGpLYVRXQnlUWTFrS2R0NSsvVCs2c25jWUVIOW5o?=
 =?gb2312?B?QTZwTWFiNllqS3dQQUpQY3FWeGNGWVBhMFFvbWExcVR6U1RselRFRjBQRS9D?=
 =?gb2312?B?c0tMTlhTM29JK1JBS2xia050QUFsSXYxM01NWTRvT1E5enN4YmRZR1BEMDRq?=
 =?gb2312?B?MzFUdjgzNERCbnlNMWtIeTJBR1dsOExoRkxiN2dQVTEzczdJNFZLMmhpYmph?=
 =?gb2312?B?K1FiaGg5Q0wwQ0JFS0hpdy8wS0QzL3hsa0pvTGNLNkhUdm1hby9CRDM1Tnpl?=
 =?gb2312?B?N3Z5eDVXeTVIUnBFcEdJbDhaN2p6QnVmaGJ3UXRQaTBYMUprZFU0TTRkUkwz?=
 =?gb2312?B?R0RNcVo0eVFFRXFVTVlmYW1GYjZpMEJwK1pMNk5PdjlOZHdiQ3IwUGFYdkpE?=
 =?gb2312?B?bzdCdGNYZnNubmJ0UW1zSmF3bHVCanVidnVSQjZsaVpiVWlLWnpFVWl5a1dp?=
 =?gb2312?Q?LK0Asi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WklacDJ6dThXQURYK243aDVpSW5BL0JEK25EQzFMcHJESE1GMDVCY1Bma3Np?=
 =?gb2312?B?OFZMZ1RtdXJ3RStUNkFMeFc2N1Avd2Y0VTI1QjRQQm5MMWd1ajJHZWNWRXlQ?=
 =?gb2312?B?SDJOcXBvZ3RhZWxPUEpWdXRMa1dWU2swMjVpV0hlNXJueHpHbGZNdWFZbUZk?=
 =?gb2312?B?ZmdNUVRRS20wQWJBZ0cyM3VmMXRhdmNhbWwrSmZJVXVKd0lPMW56YldYN08y?=
 =?gb2312?B?ZXgya1BvS1NMWE5YU1VxWnZUT0lNcS9DM3h5MXB5VkJyZXlsbzlTd3dFWkow?=
 =?gb2312?B?VGZ0SFllS2k0R3k0QWtjNm9UREc2R3JoTDJaaVVMMXp0YnVNRE9aVnF4czli?=
 =?gb2312?B?bnEwZEZZUTFBdWFOM1FXT1ZDOFlwdytWTXByU2xQR0hjSjUvYTIwZXNFVFE0?=
 =?gb2312?B?T1liOWtKMkI4WFd4THc3am02S2paVks0dzRYZzluQU9nd0pVYWtTSXNLekdR?=
 =?gb2312?B?bWhSZ2Q5dmNZQVc3OVpSNHNrdDFUT2JqNGNNYnZHMkxzd2E0KzJ6VlU5L2VL?=
 =?gb2312?B?dnpkbGhlUm96dzNHT1ZZNTBDTlBIYlNrUlVBYmpjZDg2Z2lRYmQ5cWVCVk1Z?=
 =?gb2312?B?M2hXSWFueUs0YVlSbDlzUjI0NlFhc0lvQzFVSVg3cFNPOTNsVGovNE9ocEph?=
 =?gb2312?B?RFJXZFBmMnVCK0VsYjN6TGxzTCtyVHhCRDhHY2NTd283L1Q0UEt6ZTBhamFW?=
 =?gb2312?B?OFY3ZUR5S3hnVEpqOHNQRGs0a0RyclZ6T0J0THVFejRJaCtCRFZJTUVXbGVo?=
 =?gb2312?B?MkI1MzRweWxlQkQ4ZThka3JlVy9YUHJwRzhTdGZMZFlGVFgycVpDZ0xFejU2?=
 =?gb2312?B?dGtYbTVIZW1WakFoaGpNQzhSN0hmckZYN2dOVWhiLzNoclZ0Y0VXbGZPTDNL?=
 =?gb2312?B?c0w0eW9JeVM3Z0lndkVQOVc0Z1FuYjk3bzBDdmZFNy9oODV0c3d1bytMVmhl?=
 =?gb2312?B?RHVPUHh0WWozNEdZSjhOK25KMmxVN3EwSWFES3JpbStvQW1VbDlLVGs4ajNp?=
 =?gb2312?B?bGxnRGlHMWtWd1ZvNXRTeHRtNXlpOHZxKzNuS05zREJMSnVVN3Q5VmFuMDdR?=
 =?gb2312?B?Q1gzSGRnZWhjUHFEcHNHRW5EaHpBY3RTTWZQaFdQT2NrTjkyZjFBT1ZBZUxG?=
 =?gb2312?B?aGg2bjBseGE2ZHlZemxmKzFoTHFmTXZyUkxRdjNtK3l3RUZvQ0dDb0JLY2kr?=
 =?gb2312?B?OEFsT0ZWcVI5bXFTeE1wOTQyKzQ1OFFXYW1CNHJLczNtNXBUcHBwNi85bkdr?=
 =?gb2312?B?VDdaRndFcDdGZ1FacWs1blhZeWtyUTE2M0xBNmpoY00xUmppM3hwbldGSHMv?=
 =?gb2312?B?cWJGRTZCdG1tdlJLYmNKandKMlg0YVJVQ1VSdm1KcERUUDh1Z3YrSnNQTklV?=
 =?gb2312?B?azREWXdQR00rZkVsUjJYUHIyYmdsOHE3NEx0L2M2RHR5L1hyQW9CdlR0SWZj?=
 =?gb2312?B?OEg0SjExL1M0SUJUcGQ2V1BpSHBCVXJ3TU0wbVFlM2lqRkFUTWRIb0Y5QkVq?=
 =?gb2312?B?N2k2OE9WSjgwaHFTMjJ1WWg5MEZoMVc0aEpNWU0vaURFM1ZQY2Y2SU11VHlS?=
 =?gb2312?B?RmYzbHFZYnd1UFRoZktDb3dWYnVrcU9TQ1VTNGpGRXQ5Q1BER2c0TGR0ZmlF?=
 =?gb2312?B?S1BBZXp6MnI2MXFVN013S0dtZjl5NXAyYmVNNzVGNWJOYndBVXMrMEN4RUxy?=
 =?gb2312?B?SFdORWpoUDVWdFYxQmJ5V3M4UjJzai93cHFFZ3lKcnJUZkZHNFo3a3M3a2Rv?=
 =?gb2312?B?NytwaWx3QUozVXlIb0ltRklBVlF5SzBBYkVFTTlDU3VwSVZIeTdnNUZWNlFz?=
 =?gb2312?B?aTJyNnROODdVOFBqYmRhRVBENlloMWFtOWpaWThGR09LWFJ3SHpObGFndHh5?=
 =?gb2312?B?djhDY1BlLzYxbXAvc1dvY2lTL3FoeDZaQi9IQ1dLdkx1THBXV0tyWXE0aXBV?=
 =?gb2312?B?NUFYSiswSWthY29ER202RjBrNGZqeDIva1hMaUl1c2VsOU1RSUlad2NyMk1J?=
 =?gb2312?B?UFFGMDhoWUlDL3hZUFAyczZPRUdBeSt2NE56K2RyUFJmUi9yTlJ3bThiU2lJ?=
 =?gb2312?B?OHdHc2NsaG4rRDZxT25RQzhnbk9PVzYwNU5QMXd2NklDS3VsWms4dEM0Mm9Z?=
 =?gb2312?Q?EzLrp8TPHUpIRq03T6Q6siyJL?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd2a96f-51e3-4a5b-ead2-08de15f80f0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 08:00:28.1719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNN+Iu9uJ1i2a2Wm27ePUQFm5ZiF0UDOj/ewWWXa9eaQjzFJko2Ksn4zt0ZqytkTw/lQ+HaoQ2a2MNv0GleQ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8522
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxp
c3RzLmRlbnguZGU+ILT6se0gTWFyZWsgVmFzdXQNCj4gt6LLzcqxvOQ6IDIwMjXE6jEw1MIyNsjV
IDU6MzUNCj4gytW8/sjLOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiCzrcvNOiBNYXJlayBWYXN1
dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IEFsaWNlIEd1bw0KPiA8YWxpY2Uu
Z3VvQG54cC5jb20+OyBFdGllbm5lIENhcnJpZXJlIDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5v
cmc+OyBQYXRyaWNrDQo+IERlbGF1bmF5IDxwYXRyaWNrLmRlbGF1bmF5QGZvc3Muc3QuY29tPjsg
UGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28u
Y29tPjsgVmluaCBOZ3V5ZW4gPHZpbmgubmd1eWVuLnh6QHJlbmVzYXMuY29tPjsNCj4gVmlvcmVs
IFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiDW
98ziOiBbUEFUQ0hdIGZpcm13YXJlOiBzY21pOiBEcm9wIG1tdV9zZXRfcmVnaW9uX2RjYWNoZV9i
ZWhhdmlvdXIoKQ0KPiBtaXN1c2UNCj4gDQo+IE1NVSByZWdpb24gY2FjaGUgYmVoYXZpb3IgY29u
ZmlndXJhdGlvbiBmb3IgU0NNSS9TTVQgbWFpbGJveGVzIGlzIHBsYXRmb3JtDQo+IHNwZWNpZmlj
LiBFdmVuIG9uIEFSTSBzeXN0ZW1zLCB0aGUgbWFpbGJveCBtZW1vcnkgbWF5IG5vdCBldmVuIGJl
IGxvY2F0ZWQgaW4NCj4gYW55IGNhY2hlYWJsZSBNTVUgcmVnaW9uIGFuZCBtYXkgaW5zdGVhZCBy
ZXNpZGUgaW4gc29tZSBTUkFNLiBSZW1vdmUgdGhpcw0KPiBub24tZ2VuZXJpYyBjYWNoZSBiZWhh
dmlvciBjb25maWd1cmF0aW9uIGNvZGUgZnJvbSBnZW5lcmljIGNvZGUgcGF0aC4NCj4gDQo+IEl0
IGlzIHVubGlrZWx5IHRoYXQgYW55IHBsYXRmb3JtIGlzIGFmZmVjdGVkIGJ5IHRoaXMgY2hhbmdl
IGlmIGl0IGRpZCBjb25maWd1cmUgaXRzDQo+IE1NVSByZWdpb25zIGNvcnJlY3RseSBvbiBzdGFy
dCB1cC4gUGxhdGZvcm1zIHdoaWNoIG1pZ2h0IGJlIGFmZmVjdGVkIGFyZQ0KPiBpLk1YOTQvOTUg
YW5kIFNUTTMyTVAuDQo+IA0KPiBGaXhlczogMjQwNzIwZTkwNTJmICgiZmlybXdhcmU6IHNjbWk6
IG1haWxib3gvc210IGFnZW50IGRldmljZSIpDQo+IEZpeGVzOiAyYTNmMTYxYzhiMTYgKCJzY21p
OiBjb3JyZWN0bHkgY29uZmlndXJlIE1NVSBmb3IgU0NNSSBidWZmZXIiKQ0KPiBGaXhlczogYjJh
ZTEwOTcwZDQwICgiZmlybXdhcmU6IHNjbWk6IHVzZSBQQUdFX1NJWkUgYWxpZ25tZW50IGZvciBB
Uk02NCIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dCtyZW5lc2Fz
QG1haWxib3gub3JnPg0KPiAtLS0NCj4gQ2M6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+
DQo+IENjOiBFdGllbm5lIENhcnJpZXJlIDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5vcmc+DQo+
IENjOiBQYXRyaWNrIERlbGF1bmF5IDxwYXRyaWNrLmRlbGF1bmF5QGZvc3Muc3QuY29tPg0KPiBD
YzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBUb20gUmluaSA8dHJpbmlAa29u
c3Vsa28uY29tPg0KPiBDYzogVmluaCBOZ3V5ZW4gPHZpbmgubmd1eWVuLnh6QHJlbmVzYXMuY29t
Pg0KPiBDYzogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT4NCj4gQ2M6IFllIExp
IDx5ZS5saUBueHAuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGUNCj4gLS0tDQo+ICBk
cml2ZXJzL2Zpcm13YXJlL3NjbWkvc210LmMgfCAxNCAtLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmly
bXdhcmUvc2NtaS9zbXQuYyBiL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zbXQuYyBpbmRleA0KPiAy
Mzc4NzE1NTlmMC4uY2QxYzA4MDFmNzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUv
c2NtaS9zbXQuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc210LmMNCj4gQEAgLTYx
LDIwICs2MSw2IEBAIGludCBzY21pX2R0X2dldF9zbXRfYnVmZmVyKHN0cnVjdCB1ZGV2aWNlICpk
ZXYsIHN0cnVjdA0KPiBzY21pX3NtdCAqc210KQ0KPiAgCWlmIChkZXZpY2VfaXNfY29tcGF0aWJs
ZShkZXYsICJhcm0sc2NtaSIpICYmDQo+IG9mbm9kZV9oYXNfcHJvcGVydHkoZGV2X29mbm9kZShk
ZXYpLCAibWJveGVzIikpDQo+ICAJCXNjbWlfc210X2VuYWJsZV9pbnRyKHNtdCwgdHJ1ZSk7DQo+
IA0KPiAtI2lmZGVmIENPTkZJR19BUk0NCj4gLQlpZiAoZGNhY2hlX3N0YXR1cygpKSB7DQo+IC0J
CXUzMiBhbGlnbl9zaXplOw0KPiAtDQo+IC0JCWlmIChJU19FTkFCTEVEKENPTkZJR19BUk02NCkp
DQo+IC0JCQlhbGlnbl9zaXplID0gUEFHRV9TSVpFOw0KPiAtCQllbHNlDQo+IC0JCQlhbGlnbl9z
aXplID0gTU1VX1NFQ1RJT05fU0laRTsNCj4gLQ0KPiAtDQo+IAltbXVfc2V0X3JlZ2lvbl9kY2Fj
aGVfYmVoYXZpb3VyKEFMSUdOX0RPV04oKHVpbnRwdHJfdClzbXQtPmJ1ZiwNCj4gYWxpZ25fc2l6
ZSksDQo+IC0JCQkJCQlBTElHTihzbXQtPnNpemUsIGFsaWduX3NpemUpLCBEQ0FDSEVfT0ZGKTsN
Cj4gLQl9DQo+IC0jZW5kaWYNCj4gLQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gLS0NCj4g
Mi41MS4wDQoNClRlc3RlZC1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCg0KVGVz
dGVkIG9uIHR3byBib2FyZHM6IElNWDk0IGFuZCBJTVg5NS4gTm8gcmVncmVzc2lvbnMgd2VyZSBv
YnNlcnZlZCBkdXJpbmcgYm9vdC4gTG9va3MgZ29vZCB0byBtZS4NCg0KQmVzdCByZWdhcmRzLA0K
QWxpY2UgR3VvDQoNCg==
