Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90813C35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F058C8197D;
	Fri, 21 Mar 2025 08:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EPt69kSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614588198A; Fri, 21 Mar 2025 08:29:54 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7302C8141E
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNKPkU6KnEMB+I1OZpq0UCDpYtmGeREMz/4hfEtOhENRTiptjqv1SutCQEltqaYS5gqlw4ObQVMKtD1OUrQi6LJyYbNWZhRpGBiT/KZM6KJplJ6bnhA6D3GSNI8ZWjj0J0A35nGwG8TBJiHbZucmKWT9O3COMf1R2w6gqCzMqny20HaNbJoCkJD4BHzUFdoKfPDGdcQ1DB3YrrGKjyx0ocI/fZ3EseyEdQG9N1QxIP3iB8zOqMrQN4MTZl1xLgOt161MK1sCN44oK6N0AwFdBXz6tPYcjSJcEJ8rxluRJMKqyEcELhamhTRlD9+snco3TqW1LLEFcQdIEroroGVEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmHKIAr5HbihEqxq3I89z/DRtHFUg7D7pwHW4FskoT8=;
 b=hjmHh7yjyplf+2FwbInfxYOIT/4NCk/3/8PbBBxyc5XRHh27wM6kEjoRi5I0D0ICwN0kAyRlwUTNwklyExcJLcAazeintVZXdsK9ak+eSNiAPFeCam09X9Jr8F3CjThcsF5u11tBqc/dTv4nDpG0VNsCyB24QbCmbVj/SQVfWYWuH/Kv8WqvzLgKI0LqgHcVi9wVfNuxUNZBY9Eteop7XJ4LRbTvZMTL9roWLe72lkFfaoXTpNknZ3rqz7IShqHf3G8AtEQiS/O17zP3sA+Ua6Pshsy9Y0uOwvR98BiAdUQn34u0dd0MtoNjuFOFJMss/+EIHu/FoUBnWc5d0KlD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmHKIAr5HbihEqxq3I89z/DRtHFUg7D7pwHW4FskoT8=;
 b=EPt69kSiFgKu57roBpnf147XN2cAqPu/p+yk7ZHp4eos2Iu4KiSff8G/vvvBTZLhS5u5vOaa1Iwcm3ZUQgvtUQBTfkwIHD/432ZmDRHsU9BUZNqOaxsipjvV+HdfOWdQBwMQDSJliTA7Kr1gF8fQ0AN3f9MZNBkXNyo3k6mWpsIwrHAYx5RyP96RL+RnaR+BaW6Qvaimtt2T8gtcJ3xbhQ5SWRoA6eVPmkKDQeocRMMRsSzVrBbsgo/7NouSpmcSuq1uj7bqXRvZU3EQrd03nsZ/LpSYCf5/s0sMcoHCpjPzy4CyRWULKj6L6bhfrAUHR2PBNP5G6rOBc1+Pn3sdPA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 07:29:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:29:49 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IOWbng==?=
 =?utf-8?B?5aSNOiBbUEFUQ0ggdjQgMDQvMjBdIGZpcm13YXJlOiBzY21pOiBhZGQgcGlu?=
 =?utf-8?Q?_control_protocol_support_to_SCMI_agent?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?B?SCB2NCAwNC8yMF0gZmlybXdhcmU6IHNjbWk6IGFkZCBwaW4gY29udHJvbCBw?=
 =?utf-8?Q?rotocol_support_to_SCMI_agent?=
Thread-Index: AQHbZ1F+XbneYzJjuUCxxW5MfO0jxbNQy1yAgAA15YCAAQ5sgIADuNAAgAdZAACABABdAIAA1qkAgAKqv4CABvo6AIAP3hKAgAAao4CAAciNYA==
Date: Fri, 21 Mar 2025 07:29:49 +0000
Message-ID: <PAXPR04MB9644DBB97F3C1EDBC22B8F9CE2DB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
 <20250224022831.GA9876@nxa18884-linux>
 <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
 <PAXPR04MB9644FE1F92AFF132649A7EA5E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <3b232bda-000e-4f6b-8661-eeb72fc78b67@denx.de>
 <PAXPR04MB96443A9429499C5FF777EDEDE2CB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <fb46746a-1d50-4226-8f56-2dade4f52891@denx.de>
 <PAXPR04MB9644E5C1DF5B039D6BB65F6DE2D82@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1a99da2c-8076-481b-aec4-8aff3f1f7b64@denx.de>
In-Reply-To: <1a99da2c-8076-481b-aec4-8aff3f1f7b64@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA1PR04MB10399:EE_
x-ms-office365-filtering-correlation-id: 486d39f6-08de-4ae8-394f-08dd684a299f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZzdTUEQ3MUJ3L090NGN4REkxOFVqZjBha3JrR3ZSbjZsbHpiWjBYOTZ1dGpl?=
 =?utf-8?B?SGl0cjhuSEYrVHVNOEljYUc4dithZzNnLzNyWUNuTURaa2h0clR0OURTWXNa?=
 =?utf-8?B?RlVKd3I0Sm1pL1JQYVdxR1NiOWpwSU5yQ2VWMWFKMmg3NUxpc3V2TENvb25u?=
 =?utf-8?B?QmU3VDFUWUI5bEowOHNnQ2JYanBGTG9ISmNpVEgzWTdHQzM4QmsyRVZyM2Fo?=
 =?utf-8?B?R0JYRStmaTFsVkpqVWdMWE5HV0JHUlpGUVdCaHZrRVhhaFU1bGhFckdobk1E?=
 =?utf-8?B?KzZZUGY2R1lZR29sU2Fjd2pFdlFFUjlteWF4QmpxT0tDTnFuOW52YkcyNTc4?=
 =?utf-8?B?TjVxaGF5RGtyTUJ2U285RjRjY1VibHdrUnpJTEt0ZDdyUVFJc2VYR0ZlTzg1?=
 =?utf-8?B?TGdsSXEzZUFoanJGMzJMVGlab0E4aFBUYWVWRUxzZXJGdlpyc0xYSlp6M09Z?=
 =?utf-8?B?Q25UYlVxUFhXallhRjRLOTVJZ053a2J3b3JwSCsrSEM2WmFRZWJwSjhuWkU4?=
 =?utf-8?B?RHNTRUlwdmlUcGlkbkRYZ3ZsYWczVXZHcjhSTHYyMXFFRmhvTUlCS1BlRGpD?=
 =?utf-8?B?bDJTU3UxaUNxR1BVS0xUSDBIeEYzNTNlTS91UVVIVm9kUVlCQ3BGV1JLaXpj?=
 =?utf-8?B?SnJ4VWkrMEJ3R25UMnhUREdvMnhiT2lQMmJhcy9LWFNZa2VTeG5TaURRSDh6?=
 =?utf-8?B?M044b3ZONS9IYVh1OUdqS09TRjdyVzRuQVlmSlQwL3l1VTdqdmtWZWpOT0FH?=
 =?utf-8?B?YkRhMG51S1N1OFZNRnJ2dFJjZmJ0L3FydklhUG50VU1hb3JRZzFTNG8xSVlh?=
 =?utf-8?B?VGd2dzY4SWYzVmdDb0dCNXZSck5udUgyQnIvVXRkMGVnODZCNEExdFlEcERE?=
 =?utf-8?B?WksxS3p3V1N2a1NrR3Y1U0lJV1ZIdzN4OG9YUHdzSFl6YmhHRjhqeGZtVEMx?=
 =?utf-8?B?V01NYWNTKzdKZHRtMTZjL1VxNkUxVEJiWGRuMWNiSlRoK0FENkRzczFBZHpx?=
 =?utf-8?B?L0l0MkVTcnpNdzdYdmJ3QkJCRDFCYUcwZkdlR3FkOVR1VWlnWURMbXRCWlpD?=
 =?utf-8?B?T2lNWXZjU1ppa3dSMzAxb2dnTUZqRWQ0WGxhR09heGpvYkVjR2NEWjdqMGVX?=
 =?utf-8?B?TCtRMGNLdll6Yk5pQjJRTXJGS1BhRHdaQ1VuRUppRzJlTm5lM1p1MFhwaUdE?=
 =?utf-8?B?VnE2eDdvNEdNWUJPNFBKUWUrcmFycFhieU0zczd3Mnk4S1hQeXZRVHFBQzN5?=
 =?utf-8?B?T1FrdWswQkh4YTdlTTZQRXlKdGZBL1JYWUsxUk56NkRrQ0ViSHdSVXRUQjBJ?=
 =?utf-8?B?YkVLdXRJZkRyait0a0wvdVB0dUd2eURxQnJaMnlISkZnTWc4akQ5YXZ4MUdx?=
 =?utf-8?B?d0ZGbjhkQUlaaVpmcEpLNFdlZ0lJNkkrbXJZamdsdDJlZXY0TWNraWZ0NThZ?=
 =?utf-8?B?eXNHcWxGQ0x1N1ZaUjJHU1VzTS9sbEt3cHA5YTlBWG52bklxTHB3YU01WjNq?=
 =?utf-8?B?bTArMkZQWnEyUGtMZjRQdHorZFk0NjYvMS9lSDFkTVdiK3EvN3piZXF2Znpw?=
 =?utf-8?B?UWNwM2kwUUo1YXRVdm5pMUxTR3RSb0M2dGJaSzh3dGEzUVFzTUhhd2FYTXNM?=
 =?utf-8?B?S3FXUm9MZnNiMFBRMzJhemt1UmxNQm4vTmhGSVAyb2ljTDNpanc2VVVySTNK?=
 =?utf-8?B?Zy9pWXBYVFR3SnhHWnZ0eEZJN2hSUUgrSDhOZHNKdEdsTUpkTUZlbjZmU2sy?=
 =?utf-8?B?dzludGdrNEdlejdJa3pSYUR6c2RkVXJtdmpteHdZQUk1OEExVGRLa2pwbFJt?=
 =?utf-8?B?Y0FHV09QWUI0NDFQblpGemFXcytiS3Z1UWlGb2FwWEdob0tvYkdFUisrSWtv?=
 =?utf-8?B?TkZ2SmI1L0l2VGI0Y1FZTzkzbHFtZ2poZk9abGxTV3A3TkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVIdlBIU0FZQVdYM2ZNMTNMQUxZbHE5OUhVem9JVzZrOWJWeEpMOXdvdkZB?=
 =?utf-8?B?ZkkrS3dtOW1xbVpnK0pERHNUblloZWNQYnBpTGpDa2xhTU5TZ1YvR04rUXJQ?=
 =?utf-8?B?ejBINlRjQkxSckRsQkN0SW94Z0ZJc0pXUTlnSk1KZk4wN281MVFMK0cwdk9p?=
 =?utf-8?B?UkxlTzVrTXcvSzlNQzJ4ZEptc2ZMZTFzWE1ROTlHdDcrbURqbHZybHJWQ0My?=
 =?utf-8?B?RnMrd3BGMFJsOVg3N2J3TmREeWxQeUpMRlRHWWlZdVhwMFRuUlI3eTZXTzN0?=
 =?utf-8?B?MTBpMmIvWHFNWXpseUtwVnJ1M1V1Qkx1VWNQWjIybTltR00xQ085VW9mYzBu?=
 =?utf-8?B?K0tYZll5dEQwS29LYUhzZWtuN2ZRa1RxdEtHOWNIM0xwY2xIdGdSYzZrZEpR?=
 =?utf-8?B?NnZNbnl5L1Y0V1UwS2pOTXUwZHZaR2lXMG1XVzc2UjNqSmlacDQxcUt5TGpL?=
 =?utf-8?B?QjVIWU9iZjBJVWRUWEU0d3JIRmdwSUNIYzZsOEdDanQzam1EYTdlRFErbUJ5?=
 =?utf-8?B?UzNRelVSaHlFNVlZUDA5SFNBblRmay9BZ1lmSFp3RFNGSmZmVDNBMG5XUjI2?=
 =?utf-8?B?M1E3MkFCUDdwWFdGWkhOaDR5S0VLV01kSkM4L1hITm45V294ZGx4Y3NLOHFw?=
 =?utf-8?B?MFZxbUVsYzVjT0JMS3hqOUJ5eVpnN09Ic2FEdlgxUWRGWjZOQmRsaE5WVWRs?=
 =?utf-8?B?R29nR1RoN21abHJObWgzQTVKRkVNbitlTXNVSlBQaS9hT1BobStyYXVrZ0Vv?=
 =?utf-8?B?b2dqUWFmNE9HYURtc1MzS2ZSMzJKMGR3aUZxZ2VVZ2tFWXNhSGlGYTJnQzJs?=
 =?utf-8?B?UUQ2dEVrN1hJcGQrbmYyMzRFWjhYSHFlRE5zTVkzWFRQVnUwZ3BKVnF6UTBN?=
 =?utf-8?B?TGRMQUJpdWYxUGFTOC9FSU9MTi90TzFIWDVwblpnTHl1c1h6UW4vS3ZJdVBB?=
 =?utf-8?B?anZPQ0lVUjdrMzNSeHpna0pZVVZNZDVGejRkSWJieGxQOG0vS2VwMk1Lc3JX?=
 =?utf-8?B?SUpRcERNdmFXYUlhdGJHajFNK3lOU1hRN0VkV2Z2Q0M5RklDRUoxNXRCbFU2?=
 =?utf-8?B?YlE0QkRLYWNtdjVxR3A2OWVNRGlKdjVFczVkaXRQYUlVZGgrMHBMaWQ3OHdt?=
 =?utf-8?B?UFNZZlBycHJ5aU1MNExaZHMvSGlFbGplSkpKb2J3MEZ1NHZBSjhGZXhmNUJr?=
 =?utf-8?B?aHlKTW5JOHNDbTBpcnkxTUtncmgxY2xDTU83TG5jMks5ZkRDekhGMUpvaTNy?=
 =?utf-8?B?VDV5Y3oyZHpTS0NzaDlwVk5ndzAvdWN4UWVDUHBZM2VPeVlOQnU4QWhMRDZt?=
 =?utf-8?B?N3BqMTdJNkExcGpwanN6OHRrTFdKRVNaSmZHcHlIOHNhS1RReWh5NzZaZFM3?=
 =?utf-8?B?Y1U5UDBLWVVjeXN0cVkyY2g1clJzdUYyZDB2WVpBRjk4UnpERWRDdThRemRx?=
 =?utf-8?B?dUdwbnJxeEUvZmJFL015WVUyM1JENit3N3owZTZKV1ZqNlN6ekdudjBNTWtm?=
 =?utf-8?B?elB3YlVHakp4bWN3b2t4cmp4L0VrMlNWbE9Ha0k0SmFYdDlYb0E5YW5ZMkR2?=
 =?utf-8?B?Ui82RGVURHozRDgrMm5HQ2dlQVo3eGJMWlJBUENUUm1KQWxBOGN2RGJmVHAv?=
 =?utf-8?B?T2hBM2VFa2hrdXArTk0zQWs2OWJDRTF6L29Kbk1nUXJMMDBwTFNTdGRldlor?=
 =?utf-8?B?Ukh2RDJ3RGVUNWJRRG9DTlBUbHphcnJCaFU5TDBja2x2TkxiTFkzcERzMVlw?=
 =?utf-8?B?c09IMVZBa2tzYnJDM3dtaUkxdVkwTml3MGdSOWY0SVdDd1MvaVJsZ3ozQTFo?=
 =?utf-8?B?SitTOXV1d2xmc0FiRFNpcnNKQ21EVGdMMldrdjlqS2FKaHd5V0lLRXNEUXdN?=
 =?utf-8?B?K3RxbmFYanlBZnpsNUZDbE03UmtLcWJXbTB4M0xTRUlaNjdiRFM0QmdUbjcy?=
 =?utf-8?B?aGJ2eExUL2d5QVRXSWxMOW53U1R2YVVnclhlbi9mNlBsOTZTT091WXJncDhv?=
 =?utf-8?B?Wk5aTjI3Y05wVjhVVUlmNTFoMjBJUjJsMnhqcDE0djJWK1JHNUFsakRheCtr?=
 =?utf-8?B?Z2hHL0pPREE4QkIzSnNZSmt1SjB0WVE0bDR0cytMbE5OMjlFSEJGNThHQWlx?=
 =?utf-8?Q?C91zKK0vPuy1LkVd6SE3o8VFa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486d39f6-08de-4ae8-394f-08dd684a299f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 07:29:49.1139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24zgCqfidNwa8QuHfcijSt31QDjU+dU+YxEEB1r0XLSXh+vfQpmaSHa/VMyMzuyL+KtWlf99Wq34igw6GT3T9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgyMOaXpSAxMjowNA0KPiDmlLbk
u7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgUGVuZyBGYW4g
KE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiDmioTpgIE6IFRvbSBSaW5pIDx0cmlu
aUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZhYmlvDQo+
IEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54
cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFuZGVyc29u
IDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsg
QWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gdS1ib290QGxp
c3RzLmRlbnguZGU7IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2UgR3VvDQo+IDxhbGljZS5n
dW9AbnhwLmNvbT4NCj4g5Li76aKYOiBSZTog5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSN
OiDlm57lpI06IFtQQVRDSCB2NCAwNC8yMF0gZmlybXdhcmU6IHNjbWk6DQo+IGFkZCBwaW4gY29u
dHJvbCBwcm90b2NvbCBzdXBwb3J0IHRvIFNDTUkgYWdlbnQNCj4gDQo+IE9uIDMvMjAvMjUgMzoy
OCBBTSwgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiANCj4gSGVsbG8gQWxpY2UsDQo+IA0KPiA+
Pj4+IC0gQmFzaWNhbGx5IGR1cGxpY2F0ZSB0aGUgbWVjaGFuaXNtIGluIDc5NDBhOTNlYjk3NyAo
Im5ldDogcGh5Og0KPiA+Pj4+IEl0ZXJhdGUgb3ZlciBib3RoIHJlZ2lzdGVyZWQgUEhZcyBhbmQg
c3RydWN0IHBoeV9kcml2ZXIgbGlua2VyDQo+ID4+Pj4gbGlzdCIpLCBjYWxsIGl0DQo+ID4+IGUu
Zy4NCj4gPj4+PiBVX0JPT1RfU0NNSV9EUklWRVIoKQ0KPiA+Pj4+IC0gU3dpdGNoIFNDTUkgZHJp
dmVycyB0byB1c2UgVV9CT09UX1NDTUlfRFJJVkVSICwgaGF2ZSBlYWNoIG9uZQ0KPiA+Pj4+IGxp
c3QgYSBwcm90b2NvbCBJRCAoaW5zdGVhZCBvZiB0aGUgUEhZIElEcyksIGFuZCB0aGVuIHVzZSB0
aGUNCj4gPj4+PiBzY21pX2FnZW50LXVjbGFzcy5jIHRvIGl0ZXJhdGUgb3ZlciBhbGwgdGhlIGxp
bmtlciBsaXN0cw0KPiA+Pj4+DQo+ID4+Pj4gQWJvdXQgdGhlIE1YOTUgc3BlY2lmaWNzIGFuZCBo
YW5kbGluZyB0aG9zZSwgaXQgaXMgcG9zc2libGUgdG8gaGF2ZQ0KPiA+Pj4+IHR3byBkcml2ZXJz
IHdoaWNoIHN1cHBvcnQgdGhlIHNhbWUgaGFyZHdhcmUgY29tcGlsZWQgaW50byBVLUJvb3QNCj4g
Pj4+PiBhbmQgaGF2ZSB0aGVtIGRlY2lkZSBhdCBiaW5kIHRpbWUgd2hpY2ggZHJpdmVyIHNob3Vs
ZCBiaW5kIGFuZA0KPiA+Pj4+IHdoaWNoIG5vdCwgbG9vayBhdCBkcml2ZXJzL210ZC9yZW5lc2Fz
X3JwY19oZi5jIHJwY19oZl9wcm9iZSgpIGFuZA0KPiA+Pj4+IGRyaXZlcnMvc3BpL3JlbmVzYXNf
cnBjX3NwaS5jDQo+ID4+Pj4gcnBjX3NwaV9iaW5kKCkgZm9yIGV4YW1wbGUgb2YgZG9pbmcgdGhp
cy4NCj4gPj4+Pg0KPiA+Pj4+IEkgaG9wZSB0aGlzIGhlbHBzIHVudGFuZ2xlIHRoZSBTQ01JIGlt
cGxlbWVudGF0aW9uLg0KPiA+Pj4NCj4gPj4+IFRoYW5rIHlvdSBmb3IgcHJvdmlkaW5nIHRoZSBl
eGFtcGxlLiBQbGVhc2UgcmV2aWV3IG15IHBhdGNoIHNldC4NCj4gPj4+IGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI1MDMwNS1pbXg5NS12MS0yDQo+
ID4+PiAtMg0KPiA+Pj4gODZkMTVhY2JiOGFAb3NzLm54cC5jb20vDQo+ID4+PiBodHRwczovL3Bh
dGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvcGF0Y2gvMjAyNTAzMDUtaW14OTUtdjEt
Mw0KPiA+Pj4gLTINCj4gPj4+IDg2ZDE1YWNiYjhhQG9zcy5ueHAuY29tLw0KPiA+Pg0KPiA+PiBJ
IHdpbGwgdHJ5IHRvIHJldmlldyB0aGlzIHRoaXMgd2VlaywgSSBhcG9sb2dpemUgZm9yIHRoZSBk
ZWxheWVkIHJlcGxpZXMuDQo+ID4NCj4gPiBIaSBNYXJlaywNCj4gPg0KPiA+IEFyZSB5b3UgYXZh
aWxhYmxlIHRoaXMgd2VlayB0byByZXZpZXc/IPCfmIoNCj4gVWdoLCBzb3JyeSwgSSBhbSB3b3Jr
aW5nIHRvd2FyZCBpdC4gSSBhcG9sb2dpemUgZm9yIHRoZSBhYnlzbWFsIGRlbGF5Lg0KPiANCj4g
VGhhbmsgeW91IGZvciB0aGUgcmVtaW5kZXIuDQoNCkhpIE1hcmVrLA0KDQpJIGhhdmUgc2VudCB2
OC4gUGxlYXNlIHJldmlldyB0aGlzIHBhdGNoIHNldC4gVGhlIG1haW4gY2hhbmdlcyBvZiB2NyBh
bmQgdjggYXJlIGluY2x1ZGVkIGluIGNvdmVyLWxldHRlciBzbyB0aGF0IHlvdSBjYW4ga25vdyB3
aGF0IG1vZGlmaWNhdGlvbnMgSSBoYXZlIG1hZGUuIFRoYW5rcyENCg0KQmVzdCBSZWdhcmRzDQpB
bGljZSBHdW8NCg==
