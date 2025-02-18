Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED73C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 11:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8918807F1;
	Tue, 18 Feb 2025 12:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hNgXm9fH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A48180ADF; Tue, 18 Feb 2025 12:53:22 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3ADD80077
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 12:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpZsooI83B5B3jmgdgcwSid1WKQg/mA97bxfdt0bdzFDBBIDvE9lm6+eFNGc9goMCimNFo8AzO/EI2Rz2qq+uplNdwtU/NT+vY5XukugTvsoBPdvsf4gIk+iYzYkssF7RP/iElKVGlM9Aw4eAdPl13G81gJgShUgyHnfpCsyb92hhh+wRS81tlfdHcN7gmToXe8ihSd58fgdaLchKlRpLk85afeMnieX+2PKnKiPlByPX0hPi/oHBt7tiyBWs3NgJz+zwfVh4MBU3sGRYsVpWtsjuopkZCEvM/ckZSH9gi0UplpxWwudcCjCcU4YpU4wkU2H7g7WINCpGMo+saENmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4wqucsl0pk0jNUp9ovUlUiry0cjSzsKJtMRN3daMKA=;
 b=V1YQHzHobrOuY82aYJ+35WcO0zonH0WfZvMXvt68OgTxXC/Bz6QhY97q0zhKAuMEKmRozTNDk/a6sp4vp6CHnH7FNzwCs3wpoG2imH0XaxzRZSk1JEz71yGgh2GRbet+1D/SfZ/wARKAKKK7ArrjwtShlhlpXHb0pLLjWduvv9QiCGmqonRG6LGaJgg/kyAvAjoVf9xEvduvc1IGS0wVqMYLblvQrLYRvtVSlKHpHzdyGGUctBNvLg1WTz6atGdQtognoWNH0YKC6Mlc+bYA8IVvlDSQn6Xa++LVYzje/SugZ3sU4s+YGU1+yCyDaszkVPxTQRdvLDxDZF6YqD2PGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4wqucsl0pk0jNUp9ovUlUiry0cjSzsKJtMRN3daMKA=;
 b=hNgXm9fHJfAMEE6CGAkQJv/I09W/v0sk+a9iQ7FQ9b25uU0nACnniqJbdWvPh8TsDUgm+8BjPhn4tQWD0QqMxHx8WaGG6qaGZrAMA7n6s0f+V1kr9IQ7yknXdNsSDmAfmq/xSwf2RHFxr5YeO8wwjJdSuQBbuE9+FPE73MfY8M+qA03q2r3Tci88hAxWYvGgx9M6Nz5rQUPvYZr5KVeATCfTFQXAD3FfAzNSrH95RNzC78prrv9atFC7zhA6L+UOacztO0lTp8Pli6ckTm+cet23/4NL4ykf4OxtVvktyUbbDmbmGtpBAomZjAT7vu6nk+zMX/ji+aWZRXAcM91cNg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10079.eurprd04.prod.outlook.com (2603:10a6:150:1ab::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:53:17 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 11:53:17 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjQgMDQvMjBdIGZpcm13YXJlOiBzY21pOiBhZGQg?=
 =?utf-8?Q?pin_control_protocol_support_to_SCMI_agent?=
Thread-Topic: [PATCH v4 04/20] firmware: scmi: add pin control protocol
 support to SCMI agent
Thread-Index: AQHbZ1F+XbneYzJjuUCxxW5MfO0jxbMmAJoAgCcn5QA=
Date: Tue, 18 Feb 2025 11:53:17 +0000
Message-ID: <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
In-Reply-To: <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10079:EE_
x-ms-office365-filtering-correlation-id: 004d12d9-f428-4a5c-246b-08dd5012d558
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?UDlkSVZIbTVJTVBFczZxM0sxOWd6bGdiZ3V5dHQvWkVmdzJLTjFLSkJKeVlI?=
 =?utf-8?B?Y015T3JxeEt6SVhkOXM2aXdpK0dzVTVCMGQzc0tieG42RHhiSGpCZUp4cDd0?=
 =?utf-8?B?YkQ2cEpwZ292aXhOUkhJcDdGb1ZmMjdjWDkzN1dpVjJrcHN6RkVFeWp1a1hJ?=
 =?utf-8?B?dDgvc083WnFESDQwWW5DTzR6dTl1ZUE1TEw2cFBHOFRtTEVjNWJIZ2k1dWd4?=
 =?utf-8?B?WmZab0dJUzlvaFUydEZHYTV4MlVRR29SMURoNjg1bjJFU014UzlOWkJhNUVL?=
 =?utf-8?B?L0tjN1ppcUJsTWhtS3V1OGRVL1lDSklhVTFiWGRLL2QvSFlucE5qZFJ4ejhj?=
 =?utf-8?B?WkIxSE1UamQ0YytMeTIrS0R1RWJ5cW8xclo3dHljc0dYQUhxUXEwaGNiMnY4?=
 =?utf-8?B?S2RTUzhtSWV0WUhXMWdycEpVMFBTSmxlY2JpWnZ0NUhyUGVrTXRPN3V2d0tP?=
 =?utf-8?B?MnliMDFMSTMvRkg3bG52cjB5SXozTXpCT3dtTjdYZHFiMWpNbkZGeWdadlZE?=
 =?utf-8?B?cGJwdGozMVllZXhBWlRPUkQyVk95bk55N210MGY5aHV4S1NRamlpb3FOMDhy?=
 =?utf-8?B?UU9FTFEvM0szWWt6K0FnSzVqdkhoeEp5aEpmUlFIdENMd0hsbzAyTmVlR0Zt?=
 =?utf-8?B?ME1WcHJoNTVwc1cveDRHK21XUWtxUndVVHNPc3ppUlFwR1dSVlBvb3JWUkJY?=
 =?utf-8?B?dVIyWW1QcjlxZVJmOTZCcmZNdzlWdkNrM3dQWU5JRnIwVkVkdVV3bzV1Qnhh?=
 =?utf-8?B?QzVOTXgzU0I5QlcrWXkvekdYdDJVWXg0SGpLdWovU1ZwSVRDVExUS0FIMGg5?=
 =?utf-8?B?Y1BVYnhpK2lnWnpCTyt6V2VWVlI3QUI3TVZtNFpSRUxlUUVWa0cvdXJnaWsv?=
 =?utf-8?B?Z3RPdVZDalhva04ySDU4b2RkUHlNeGUrNWhvRk1paGdWYnRNajdwWHJkZnB5?=
 =?utf-8?B?QStKaXFnK3FaL29IN1NjK3F4RHdQVC9tMVRYcW42TitQUE04RDVoT1hRVFhO?=
 =?utf-8?B?Ry9CdXpaeitnL0hzdXRQMnQ5b3dXYjZHUlc2NStPTlR0YnlKU29saHJvK3BC?=
 =?utf-8?B?aWN4c3M3ZnpPSitybWhLcGZjVjlQVzdGemZHd1VwNjkwc2ZvTnBnTGZsQkdM?=
 =?utf-8?B?cWh5dERsaytJT1JGWXUzaUlUMWpJQm5IWFBNTG1vbS9oVUViaUt6UDFJSUJF?=
 =?utf-8?B?d0t5MWJhQ21QMFU1STdqMkpGUUt0aFdGZFFOQUlHZDkwZS80cWVzbVQ0SDk2?=
 =?utf-8?B?VUZmUnVWNmNIODRpY2FBUWwrc20yeGt6YUdRamd3KzRwQnNoTC9xWDNxdUYw?=
 =?utf-8?B?VE14SGV4SFI2SHAzVWVaYmVkaysvNTFTTE9oRW5BRnZjeTd2VFBqeWhnZnor?=
 =?utf-8?B?ZzZTNkVpRkdrOEtHZ083TStzeW9SSkJpeHFJQXN5cFZwcTRyWmtWaWlZYnpq?=
 =?utf-8?B?UlVIZmY2NlY0bE9Yemk3Y1g3a1V1dFZSQ2I0UWdXUFhhRUFXVFVCMExLVDFO?=
 =?utf-8?B?cHZsTzFvL2VmUDVLRXFvZVhZSkZHYTlpcGRYQ1Z6QWx0RW1QTkdnY2g4NlZ0?=
 =?utf-8?B?Uy9LalFIMG8zMGg5YzZvTlBzd3ZLSXpjT3pVcUplUjlTUmUva1FJeXpXLzhT?=
 =?utf-8?B?OEJ1WHUwMGp3S0R4QktZNGJVQnI1WjhqRzNvZmFJUE5aT2E4QjdpakN2T1dZ?=
 =?utf-8?B?bG9lR2w4MVE2V0U0MXJ0WWhqMUNkNFhrN2pPb0FOTHV1VFB6N3ZqRmQvV2pm?=
 =?utf-8?B?YUZrc1BHQ003K1hPWG1VaWRLUWpjOUkzZkdMU2tKbmg2TmNtTDVXOUdpNGJN?=
 =?utf-8?B?eEdRZG9rem1hYnJlUUNxb3NTQ1V0WmNWUmtDRVlJdXZNN2pyR3Vkd2dScjEr?=
 =?utf-8?B?ZVhETDZuUStpV2JBeW1CVzV2RUUvdzY0Y1kyTzRsdnNMd1RGRUZCU0l2OHEv?=
 =?utf-8?B?UU05RXF1akJWTXBxS3UxbUo1NHpvVHNTNGpNSTZ0Ynp3bjNmYjBCTmdhZEQ0?=
 =?utf-8?B?MVhJb1A0Z0RBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnJrbHVrdVREMDhSZW1ibUFUVW83QXFqaHpXS3dZSkgyVlk0MlFIdmRZV3pu?=
 =?utf-8?B?Nk1BaGhYdmVKSkg1Ni9oaGRidmQ3WlRYbUpRdFgzeWYxMWlTekNVelFvUGN5?=
 =?utf-8?B?WC9qWVBiM25MMUpQQ0lKM1Q1RmRScEtLWFprbVBUczJNSkZSQytkWHIzQ1Zz?=
 =?utf-8?B?Uys1T09oazdjNCtUMnlKZDA0RTRqcy83SEZjMUZubURFck5iZXozZC9heDNn?=
 =?utf-8?B?WE4zek5FZ0tVUDZSMFFZbDZSWXpFcFRkWEhtMGxoZy8xMElxdTMwQUg1ZWFQ?=
 =?utf-8?B?UVo1dGVweG8vS1RTZFk2WDlmZkt1MldaVG9iNzI4ZTY2bFNZaHdDMktKeVBw?=
 =?utf-8?B?eVVlc0NtZWRVam5KdldKKzAvSmZjUzdIRlovUndCNUUrK3NrUWtTekFvcUdG?=
 =?utf-8?B?UHlWOHVYMHhnMUgrZEVreU9zWmZQTSsyZ2M5RXpab20weU5TbTRQcTVoVUoy?=
 =?utf-8?B?eVcwNmtxdkxOb2RjTXZmMmhuSVRuRHViSm1JKzlrRDlvQmc3OXhBQzFrL0NB?=
 =?utf-8?B?Q0s3c3FCTldRQWtHQ1VHVmNQZmlibjhZNlhiVW5kQmNuOUUyT1hpOCs0T1lj?=
 =?utf-8?B?L0krTklpWnNGWGxiaW9CZXNwbk4xS1NxUWxucVpXOWpBTzZDbTYxQUx3QmZT?=
 =?utf-8?B?NHoxekloMkF5Nms0bjI2b3laNE5OZVc5dm9jSUlaOG03R1RaZldTTmlub2RQ?=
 =?utf-8?B?enhoL1JlYUhDTXpkSy8yZ25CNm5RZHl4Uk54WWtaM1NIZ3ZuYnhHb3VXekY5?=
 =?utf-8?B?Z251a1lUQW5saTk2TG1CNGJ3SExBbTB5cllMYTEyajZiN2pUNnZaOG54REFj?=
 =?utf-8?B?aDhadTVGQ1RCS3pOanVjQS9nN2M3ZUlJSkJvelBUS1VwN0RuNlNJN0NxM3NX?=
 =?utf-8?B?RWZBT2lFZm13ODQwOG5NcldEZVJVZnNuaXpUR09GNm80QmRvNngwSVcrOUxC?=
 =?utf-8?B?em5MeEdXRWJPSiszQVJYRThVczkwKzZPUUdWTlFNVWx4cEYwLzJFRWJwRUxj?=
 =?utf-8?B?djBwcTJXT295aENoN2g2TnpIdkl6Yldaa0VneEtSUGFneU5QbWhhRjA3Z3d6?=
 =?utf-8?B?bWhlRnkzcUZRVGQrVC9PWmp5WVlWVlQ5UE9VVlZZYkJ0Y1FhQlRvN3c0aW9D?=
 =?utf-8?B?VVVCMUtrb2pwZ3NySThHRUNLS3k1bHNtQ1k3S3NpL2lreS9QT3FBRkczeXNu?=
 =?utf-8?B?RTQzYUZHRDd2THJ6aGdDdFlkL3JEcU1Xa2F1UG9zVVZGWnZvQUJHN0MwUXhF?=
 =?utf-8?B?MXA0ZWh1dUl1UzhtUkpsRkRJOWR3SUthNGluRGlRdEZZSlhleE8vSkRnbDNN?=
 =?utf-8?B?SlFUSEZ6eVBBTFBLZVBONFpSTXE3MlZ4cjlubUNkSEtyY2pyenFaRTVQN2p5?=
 =?utf-8?B?cmxhRXlPSFBIM0dsMVNkT2t2N2NtTURVeWViRVQ4Vk5YWFZFNzJsTWc2U1Uy?=
 =?utf-8?B?blN1NHRoS1F0cmxNdjd2NTVQMGt5UlV3S0ovUVZuVHZJbTJUUllXM0NhSGFY?=
 =?utf-8?B?d1loREZUbXdmZjkyQjY2U09UaUZldjF5RStoV1pOOTk5bkhVUEZxb1BCcVhU?=
 =?utf-8?B?ZjVRM0sxTWxtbnpZMjMxd0tPL1Y1TDVHeGpQaXdhM2R2bDk4dGxEVFBUZWFt?=
 =?utf-8?B?cGdCMDkwM21CQkIyZVpBZGlGaktDeG1FLzVBeVRRbjNDUFVjOTBqb0tQTlNK?=
 =?utf-8?B?NDhjQUllLzFEejVWbGVCY012cDdpVmFyNkw1Um5YeERxSUMyZXZNUFdZdDAx?=
 =?utf-8?B?MmxXaDBCSDc4eGVvQWFuN2orRm5XdnZrK1ZGZk1BTGFXZ0VhbFlQWWs0UTdk?=
 =?utf-8?B?aDlpaWtHcTN1ck1BTGlxb05KQXJRTnRWdEJPNjZHUjU4OFo2cENqSk4rcVM4?=
 =?utf-8?B?NGw3VFRRaGwzVmlRVEZxTVRGb1EzVjFuWXRMTW1mckVNVUl5ZzNuOCswWG1J?=
 =?utf-8?B?Q3JCU0hBcmZBc0hqRnNXTE43bTluQTRjOFdROUFHS3NseFhoZURxOTNudDAz?=
 =?utf-8?B?bnZ5a3F3dkVia0ludW4vYzB6aG5NTzBPM3N5WUdRcFg2NlowaUNpc1ZiWTJr?=
 =?utf-8?B?TXlNdDNpN1dGeXNEdHhadHZZUVRjTnFkTDg0dXR5TktyamltdW95Y09TNDk1?=
 =?utf-8?Q?5eeHcS79MTVq+GonOdETkS7Lj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004d12d9-f428-4a5c-246b-08dd5012d558
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 11:53:17.5336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyLW7hEwWc0scLtEFLYSfmjxSPqeizBKMXGEfA8VCd6mQINPm6HxUZbNHixVjyd0Merb97pGRIQdObz8PN71EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10079
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDHmnIgyNOaXpSAyMTo1NQ0KPiDmlLbk
u7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgVG9tIFJpbmkN
Cj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54LmRlPjsg
RmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJvb3QtaW14IDx1Ym9v
dC1pbXhAbnhwLmNvbT47IEx1a2Fzeg0KPiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT47IFNlYW4g
QW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPjsgU2ltb24NCj4gR2xhc3MgPHNqZ0BjaHJvbWl1
bS5vcmc+OyBBbHBlciBOZWJpIFlhc2FrIDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+DQo+IOaK
hOmAgTogdS1ib290QGxpc3RzLmRlbnguZGU7IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2Ug
R3VvDQo+IDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHY0IDA0LzIw
XSBmaXJtd2FyZTogc2NtaTogYWRkIHBpbiBjb250cm9sIHByb3RvY29sIHN1cHBvcnQgdG8NCj4g
U0NNSSBhZ2VudA0KPiANCj4gT24gMS8xNS8yNSAyOjI4IFBNLCBBbGljZSBHdW8gd3JvdGU6DQo+
ID4gRnJvbTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2ggYWRkcyBTQ01JIHBpbiBjb250cm9sIHByb3RvY29sIHN1cHBvcnQgc28gdGhhdCB0aGUgcGlu
DQo+ID4gY29udHJvbGxlciBkcml2ZXIgYmFzZWQgb24gU0NNSSwgc3VjaCBhcw0KPiA+IGRyaXZl
cnMvcGluY3RybC9ueHAvcGluY3RybC1zY21pLmMsIGNhbiBiZSBib3VuZCB0byB0aGUgU0NNSSBh
Z2VudA0KPiA+IGRldmljZSB3aG9zZSBwcm90b2NvbCBpZCBpcyAweDE5Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvZmlybXdhcmUvc2NtaS9zY21pX2FnZW50LXVjbGFzcy5jIHwgMTEgKysrKysrKysr
KysNCj4gPiAgIGluY2x1ZGUvc2NtaV9hZ2VudC11Y2xhc3MuaCAgICAgICAgICAgICAgIHwgIDIg
KysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zY21pX2FnZW50LXVjbGFzcy5jDQo+ID4g
Yi9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc2NtaV9hZ2VudC11Y2xhc3MuYw0KPiA+IGluZGV4DQo+
ID4NCj4gOGM5MDdjM2IwMzI4MDk1YzRiMzViYTA4OWVkNjA4ZmNkYTQ4YjU2Ny4uNWYxMDFmNGVk
ZThiNTg1ZjhjNTYyYTQyOA0KPiA4NmUNCj4gPiBhN2JlNGVmMDk5NTMgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9maXJtd2FyZS9zY21pL3NjbWlfYWdlbnQtdWNsYXNzLmMNCj4gPiArKysgYi9k
cml2ZXJzL2Zpcm13YXJlL3NjbWkvc2NtaV9hZ2VudC11Y2xhc3MuYw0KPiA+IEBAIC05Nyw2ICs5
Nyw5IEBAIHN0cnVjdCB1ZGV2aWNlICpzY21pX2dldF9wcm90b2NvbChzdHJ1Y3QgdWRldmljZSAq
ZGV2LA0KPiA+ICAgCWNhc2UgU0NNSV9QUk9UT0NPTF9JRF9WT0xUQUdFX0RPTUFJTjoNCj4gPiAg
IAkJcHJvdG8gPSBwcml2LT52b2x0YWdlZG9tX2RldjsNCj4gPiAgIAkJYnJlYWs7DQo+ID4gKwlj
YXNlIFNDTUlfUFJPVE9DT0xfSURfUElOQ1RSTDoNCj4gPiArCQlwcm90byA9IHByaXYtPnBpbmN0
cmxfZGV2Ow0KPiA+ICsJCWJyZWFrOw0KPiA+ICAgCWRlZmF1bHQ6DQo+ID4gICAJCWRldl9lcnIo
ZGV2LCAiUHJvdG9jb2wgbm90IHN1cHBvcnRlZFxuIik7DQo+ID4gICAJCXByb3RvID0gTlVMTDsN
Cj4gPiBAQCAtMTQ3LDYgKzE1MCw5IEBAIHN0YXRpYyBpbnQgc2NtaV9hZGRfcHJvdG9jb2woc3Ry
dWN0IHVkZXZpY2UgKmRldiwNCj4gPiAgIAljYXNlIFNDTUlfUFJPVE9DT0xfSURfVk9MVEFHRV9E
T01BSU46DQo+ID4gICAJCXByaXYtPnZvbHRhZ2Vkb21fZGV2ID0gcHJvdG87DQo+ID4gICAJCWJy
ZWFrOw0KPiA+ICsJY2FzZSBTQ01JX1BST1RPQ09MX0lEX1BJTkNUUkw6DQo+ID4gKwkJcHJpdi0+
cGluY3RybF9kZXYgPSBwcm90bzsNCj4gPiArCQlicmVhazsNCj4gPiAgIAlkZWZhdWx0Og0KPiA+
ICAgCQlkZXZfZXJyKGRldiwgIlByb3RvY29sIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiA+ICAgCQly
ZXR1cm4gLUVQUk9UTzsNCj4gPiBAQCAtNDM2LDYgKzQ0MiwxMSBAQCBzdGF0aWMgaW50IHNjbWlf
YmluZF9wcm90b2NvbHMoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gPiAgIAkJCQlkcnYgPSBETV9E
UklWRVJfR0VUKHNjbWlfdm9sdGFnZV9kb21haW4pOw0KPiA+ICAgCQkJfQ0KPiA+ICAgCQkJYnJl
YWs7DQo+ID4gKwkJY2FzZSBTQ01JX1BST1RPQ09MX0lEX1BJTkNUUkw6DQo+ID4gKwkJCWlmIChJ
U19FTkFCTEVEKENPTkZJR19QSU5DVFJMX0lNWF9TQ01JKSAmJg0KPiANCj4gSXMgdGhpcyBwaW5j
dHJsIHByb3RvY29sIHJlYWxseSBpbXggc3BlY2lmaWMgPw0KPiANCj4gSWYgbm90LCB0aGlzIG5l
ZWRzIHRvIHVzZSBzb21lIG90aGVyIGNvbmZpZyBvcHRpb24gdG8gZ2F0ZSBhY2Nlc3MgdG8gaXQu
DQoNCkN1cnJlbnRseSwgaXQgaXMgdXNlZCBmb3Igc29tZSBwcm9kdWN0IGZhbWlsaWVzIG9mIHRo
ZSBpLk1YOSBzZXJpZXMgcHJvZHVjdHMuDQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0K
