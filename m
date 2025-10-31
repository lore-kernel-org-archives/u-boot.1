Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A7BCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 10:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF4483642;
	Fri, 31 Oct 2025 11:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="UToW0p/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F6F983849; Fri, 31 Oct 2025 04:35:11 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51788331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 04:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6cWr6o98uH6G4M6XxXMu3RXoXEhVrAMv72+fRWbQyvoiurMJInPkNZBA7sTq7+/+NwrCFNaj4UILeycW1TRJkGlL2XMxY14sLoBgFvtpteS9khBmRR6kKyo+uG1WKS9cMtiFDleo4PCZpK8ZokRRyUFkEEsmgSAqHweNGLRWh1YA36q59Scujm/OQUMcGJoRQVQECcqccuqe15l4PVlVNUlEgxRkM9tB0eA4GTGZkMT2C9yORApFs7gQiBlAcwj/E3uNFjt+YIK6GWTXNBld63WgXowztPatu00gduFyFWnwHLsowJW/CBADARfkGt9uHlz5mG4Jlw0GtEOg+Y/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=112IxGUlC0DUXVwmF9OBJuSLzPZPBV65MqEJJfJvnnA=;
 b=G/ZDxJQ7/hh6jo1QfSq6r6TueidgI3RHDRoO9eFLBDocOp6Y4pklBr9pdFp4nGRGaDeNuHb/0cvHCAvLdIUxj78Wye/5veh9ySBzfZ2UtQFGi/Rs4meeKXwQzCunTUNOIj1wjdiO8di02rD+EJwnP0gSfksmYgxHUBpn6RRelhS+noJU6adt67HUVn2XLApvYYU2Ext183P4Fq5mrLOnT4dOU9/cB9uqney5r41WyQPzWvES7kqlgin1mncp/FipaPOIHL4AtPIA4ohUqPMSY540GGWWpnO38THak+40WFlqeNdW/LwARv5AMy9g6D1MS+m9os7brf/lybUFCYopAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=112IxGUlC0DUXVwmF9OBJuSLzPZPBV65MqEJJfJvnnA=;
 b=UToW0p/4OqKVIE8N+OKlqR755pD8eyHczvQ7IVebhfeJN8XT09itWEiavTr2uIa+tend2udkqikiOHk7T6fVc4HLdDIwEYNxenBvimRI8AAbKdcSVslNTpDcQiq5UHgMplb2kA+B5H8NQsBmMJvHLG8XkwCSyGng6cYXQYnK7PYH06d9U6UbsD0NsiroRAK7h8lMdGWXc40nUWwwYtm4RD9NRt0iDi6BAmx43YN6MN85frKs9eAvowsKUQL/3yLZPfNrRL1+XxyESdMCME1MG+WWp2xhGlztND3VsDXFiCz/zwQRm4E/yi/Q6uEt4mdDG7coBqWvIT5ieAM58e8Uow==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7377.eurprd04.prod.outlook.com (2603:10a6:20b:1de::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:35:07 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 03:35:07 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Etienne Carriere <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTog5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZmly?=
 =?utf-8?B?bXdhcmU6IHNjbWk6IERyb3AgbW11X3NldF9yZWdpb25fZGNhY2hlX2JlaGF2?=
 =?utf-8?Q?iour()_misuse?=
Thread-Topic: =?utf-8?B?W0VYVF0gUmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0hdIGZpcm13YXJlOiBz?=
 =?utf-8?B?Y21pOiBEcm9wIG1tdV9zZXRfcmVnaW9uX2RjYWNoZV9iZWhhdmlvdXIoKSBt?=
 =?utf-8?Q?isuse?=
Thread-Index: AQHcSVF8VH31uGvtp0uM85TXtY6P3LTat+KAgADfaiA=
Date: Fri, 31 Oct 2025 03:35:06 +0000
Message-ID: <PAXPR04MB9644C919B6FEAE6269F759FAE2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
 <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
In-Reply-To: <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM8PR04MB7377:EE_
x-ms-office365-filtering-correlation-id: e990f8f6-a559-4a44-2364-08de182e7c8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Z1ExdlRTaEI2SjE0SWljeEtFQmNUT3BDZmZsdHZ6RUdmbTVFS1VjTnY1enVS?=
 =?utf-8?B?aHlub2Vzd1BsUnViTTFzdS9nN0htT09yMFh5eDFDdnBTWTFwUTI3QzcvQ3Vz?=
 =?utf-8?B?NGMvMVIvUWYyZXBSdTAyNWYwaGxONEtHbllJUC9IcHhycDNSUmUvWThzSHQw?=
 =?utf-8?B?djFrcTk2UmVDNWdzSWJkckJ6T296RkJEamJJRENwMUNtL0U1S1hHNlpWazR1?=
 =?utf-8?B?UzlRSkdNcWgvWHV5QjNZSThmSDRjZ2VXSkhmODZ0VjVlaTE2djJSM2l6VURy?=
 =?utf-8?B?T21VQjhianY4UFFudnhZT2V4bGRsbTQxK28xSzV3V2NiM09UOGN4cHkyd3VX?=
 =?utf-8?B?STE5bVBYWHVxT2FwUUxIcXFQR1VDQys5QUQ3TzFZOFZZK2dBbUE0SllUZTJl?=
 =?utf-8?B?aUFVbGdnT0kwSy9OYlMwUTdkeXlzdm1OU3ZSWmJrZnlwQ1MrZjZhQ2hSRGJn?=
 =?utf-8?B?WWdnWWxSeUloU1BQVEJacFk2NVk4RG1qZE11U2g0VEhOMGZwcXlXZE9hN2Fj?=
 =?utf-8?B?Y2U5UkJqRHMzWkRnMFdDTVVKL0N4TVVUUGwySFJydFFNbnUxWkZad1h1RXU0?=
 =?utf-8?B?TmEvdVE2YVdNUk95NStqb0lYaDlrTXFFdUNYQmNtRWRxK3VXZ1NZWnFPOW85?=
 =?utf-8?B?YVpLS3Q2a1c4YTIwd2ZDaTcrQjFNcHZsZ1c5RjZxVWdXYXlUb1hWcUdGMlVP?=
 =?utf-8?B?bTI0aWkvR2NGSWZBSzR0OG0xZFUvbXJXcVEzUm5WQzRJWEpGRzBwWmgrc3U0?=
 =?utf-8?B?TlBoOCt6MGdZT0hwTWVXZGNQM0dHT0pkZTE5ek9FOWF6MmdUMzJGWXFad1R4?=
 =?utf-8?B?bWswYjhCQXNJaU9LaUFLdUhRbEFtc0RKclRWVU5TWkVxYlN5OHVLdDZvOEo3?=
 =?utf-8?B?b0FiN0lVNytlcWJxOXJXTUt5U1ZhOXU2ZjFkZ2xTamlqWHcvVTl6V1NHb3B3?=
 =?utf-8?B?NHRGNkJ0TmhRODFhdWRmTlQ5Q1lFM3BKa05IVnBOZ3RnS2J4WUxyNXR5Y0ZM?=
 =?utf-8?B?QWlvWnhyVmNmajZ4aFdxa1lHUjRWcVA1L3E0QkN5TnZUdlBzZEs0Mkg4ZlBp?=
 =?utf-8?B?M2MyODNpbk1GR3NOR0o4WFZxMm5lcERyZW9pWGw1MEtnb1F0bnluWFMzUjB3?=
 =?utf-8?B?bFRSazIySVhkS1MwT3RkRU5tM0N3YU1PWGxZOFh5RjN3YitYdzFIM0Jhbmhn?=
 =?utf-8?B?TFVTNFVPWDFzZDYxYldsdUlqcUcvaHF4anNYWEVZenpBdUdLV29aSnEydklF?=
 =?utf-8?B?MDZYR1UxejYwSnJwOFN1dVRaOGZRQWs4UEVmM0ZrU1p6UkdaNUdxYkFYdG1H?=
 =?utf-8?B?MlRMOGxTcFVLaXVRRS9HV21uR1BadTM3VjJrMHlJY3gxeXhVb0pFcEEwbHdZ?=
 =?utf-8?B?M1MyYUtwTnlVeEJPZzFaWUdGZDRocE5Hd0VHeXBCaGxQZVNVME9YOXNacnNK?=
 =?utf-8?B?S3lsYlVnM0x1SGNqQTZXQSszcE8wbmtEYUF3eEZ6TFRrMWdMUGFhb3pZd2VJ?=
 =?utf-8?B?TkYxcEgyeXRzVjhUa3EwalZFRTFrQytLSitZeDlwTmoyR1JwR0tac29YMENB?=
 =?utf-8?B?M2l4V3ZnMC9uMUl4NUFMa25keVRFbFhDRFk0VkIrdElaSjRvdEh3MldFSnFj?=
 =?utf-8?B?cm42eXI1VWUxTTNtQVdQQVJqQ0R4dEwvQmxRRmdmOW9OUEZqN0pFbkNSbzN3?=
 =?utf-8?B?VUszQk9ZMUhKREw3QkJxVXI5dG9JekdGNk54WWpLR1RxNzF0a2luNTB2eVNE?=
 =?utf-8?B?V2h4OVpVNlFWV0RvQml6UU9wZGNIbFczVWtubVUwbTR5RWhwNkpkMksrUUJR?=
 =?utf-8?B?R0FreDJoN3VhVTdHVzRhbEtiRnZjUlFwcFdPUTR3VWlHT0dDRUZxdEhhUHpO?=
 =?utf-8?B?c01kUlRYTDFOa1VsY0c1UHEwb1c3MU45VGIyQXVaS1RkVjNpUlBpOWhmL0sx?=
 =?utf-8?B?VWVieUc4ZWw1R3dOajBqSlBsQ0Q1QXhrMnV3cmRXMzYyTzlYc2lDUWwzOTlF?=
 =?utf-8?B?dkNIeExUMEF1Y3pZblBjcGp2ei90eWl4UDBaL05DalU5aHkybUJuWWhDc0sz?=
 =?utf-8?Q?rOIVrj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFV2ZkRmV0JidEl3NUpxWU5udEFKL0VCYkRhVmd1QlA5cjBNNWk5SmxOR29s?=
 =?utf-8?B?RmF4QnVzM0ZjVEVtYkZzb3hhWXRteVNXL0JCb25zWU9hQmhhZnE3RHZMWGhL?=
 =?utf-8?B?NmhObmV1bUxLMVRmSVhWYXRSTDBkWko0SWk0M04zbjcwbmxoYVdtZWRLanNo?=
 =?utf-8?B?RDNkaWxhSHY4dGNHK2NyTnU4UkVLWHd3YXM3cHBzWFhaamNvYWgvMUhVNkFr?=
 =?utf-8?B?cWo1WURvYzBBbGlqc2xmTWNoWS8xU2w3NC9OV0VCODM3VGRhRmRnbklKTlBx?=
 =?utf-8?B?bEZlZndaeUI2bDBvb21oMUNQSlU1Umd2WHBYY2RwV0xScndweG1kT0FidFFI?=
 =?utf-8?B?MUR3M25icVhHcDlJbU45S0lkMmk4MHF4SWliazZuQXlGTHg3b2YxaXYrRkZP?=
 =?utf-8?B?aDFDTWx2TmkzWjZYSHZUQWRIRHVuN3IvSmxFa1hlbGlWV3BNczZHL1RoUWRE?=
 =?utf-8?B?RkpzclRORFNYUGNlRkNsNVpVem5UL3paK3FsSkV5b0tDVnRvd1NzSVZZR1VR?=
 =?utf-8?B?WGs5M3ZpdEtQclRLUDdvOU41aWQ5VGdIME4xejd4eEhPVG03cXA0QUFGci9D?=
 =?utf-8?B?c1lQN2dseGM3cm1pNUYxQVA4NVR2MzJFSHNkcFhiZFVUT1dXcDBmYmZDWmpB?=
 =?utf-8?B?Z3lnQzQzVTgrWWJsTmNXbGd5MzlrR01SL0lxQU8vQ0lQYkxvQUZkZFVrSzlJ?=
 =?utf-8?B?bU5yS1ZFKzA2d2hWZXBDUmVSUjk5bW5MUkRBYTE3eHNLNlBrOUxuY0J6VGRY?=
 =?utf-8?B?RWN2c0U5bGR3K1NJTUlFNDJjbFBBQVJQSUZRaFN2M1I0UnBHQkZETGRnOUNT?=
 =?utf-8?B?NVFQUXYyS1ZkdTJUNytMUGx5VFhBdVNKV0NTL2xjRkE5cW1MM1FVT0M4K0VJ?=
 =?utf-8?B?Y3gwelhvQS9TYjdGS08wTTk5SEZ4bmxla3J1bk43SmRyWkk0REdnb2NIVzBp?=
 =?utf-8?B?QndtMG1hb3puc0hCQy9weEVtSGlkRzBvZXBiVTdJaERWMWhxWFNJSEpQWmJ2?=
 =?utf-8?B?blY0SlAzVTdkZDJZUXdGV05QNkVRYkN1ZHZPQVBOOE5Rc3BJTS8xOWlQeExm?=
 =?utf-8?B?L0dLREVBay9pTmdzd2dsNUxUY1VUQ0dONUJyUW9kUHh0UmpodHdpNFcyeU45?=
 =?utf-8?B?WnVvVEJuZzBGallraVBFOEZtd2k1ZXIrWENjL3IxTnZ0ZUtJdXNZU0prT09u?=
 =?utf-8?B?d2VSUStlcWp3Zm8zdmdGSW0wL29OdE1FTHYwOU1Kd1JTczBVTDlpdHBFaW1k?=
 =?utf-8?B?bzZiUGo2bk9sbVB0a0prSm5yMEZoUEUxSWdGOFhSV0RWVWhicWxSNU9wekRC?=
 =?utf-8?B?Mi93d1R0a1RnYTNqVjFXVDJwY1dWK3JVV0lpTDRyS2JFL2pySnR1LzZrK0pm?=
 =?utf-8?B?Qk9KY2JJOVMvRVQ3dkZGaXRiRFdNYVdxdUg4QW9DUFZoQUoybEdpbWU1YXV3?=
 =?utf-8?B?SThRY1h3NGYxZUJ4TWdtdnJVZmU2cTUxekk3VkFUTEVUZEhUb1VjSUlmcDVH?=
 =?utf-8?B?SS9NdU8xbjRWNjE1cFpScTVXTVRFRnBQeDhSMlY0SGVON1cyODRpRW5qQW5T?=
 =?utf-8?B?SXFKWGh3NkRJTjM1alI4d1lMRGdLaWR2QUJ1RUJsN1N6UmlyTTkvUE5IT242?=
 =?utf-8?B?aGM1aG5VQWlhZzdCQ2twczRVMVRCUXpvM211cG5JSCtqRWQvcmZkUzBmd2Jn?=
 =?utf-8?B?OXFqS3RJdEZvMElFRU1KRk5GK3dQZkFEUllaWWJRc3dEQ0x5ZDMyVDdNMnoy?=
 =?utf-8?B?anVuWGdjTFdvbjdMQldLTkh3d1UrWnNudVVWcjQ2SjhXU2RJdmpRRnJCL0Fk?=
 =?utf-8?B?SmxHbUYyKzllU0Jmd1VKb3phRzNxV3J2RFEzOEp1Wk1FMEIzRFduOEw2TkFE?=
 =?utf-8?B?S0dlNmIwOHh3bXRveUEzU3c3aHVWaGt1aWlGOWdZSjZlRVlHdHpKeWdVbC9s?=
 =?utf-8?B?SFNqMlZTMmVjajlIMGY2aDJ1THkxdUJIcElOaGRGUEw1UllHMU83TFNISU05?=
 =?utf-8?B?K0xPd0IvcjhONXhrQkhCbWZ4NTVNZkpINHlOc1Z0bjZXYmluUjdYcjlreTdZ?=
 =?utf-8?B?dzRTcnlodkMwSkdlRndGWnZ3eWI2NndGTWhxRHB6dzNMbjZYSDV0SkRvdUdK?=
 =?utf-8?Q?oNzA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e990f8f6-a559-4a44-2364-08de182e7c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 03:35:07.0424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iEk0dXzN34pEWeEgFi/kjnKtNVJms/BCR5nqw295V+BW3h5NM5ouQqT9aHgqunRrVG6cAIue7eQmxDLEWGbgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7377
X-Mailman-Approved-At: Fri, 31 Oct 2025 11:57:12 +0100
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMOaciDMw5pelIDIx
OjU4DQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+
OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiDmioTpgIE6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54
cC5jb20+OyBFdGllbm5lIENhcnJpZXJlDQo+IDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5vcmc+
OyBQYXRyaWNrIERlbGF1bmF5DQo+IDxwYXRyaWNrLmRlbGF1bmF5QGZvc3Muc3QuY29tPjsgUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28uY29t
PjsgVmluaCBOZ3V5ZW4gPHZpbmgubmd1eWVuLnh6QHJlbmVzYXMuY29tPjsgVmlvcmVsDQo+IFN1
bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiDkuLvp
opg6IFtFWFRdIFJlOiDlm57lpI06IOWbnuWkjTogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogRHJv
cA0KPiBtbXVfc2V0X3JlZ2lvbl9kY2FjaGVfYmVoYXZpb3VyKCkgbWlzdXNlDQo+IA0KPiBDYXV0
aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xp
Y2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVw
b3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMNCj4gZW1haWwnIGJ1dHRvbg0K
PiANCj4gDQo+IE9uIDEwLzMwLzI1IDQ6NTggQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4g
DQo+IEhlbGxvIEFsaWNlLA0KPiANCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2Fy
ZS9zY21pL3NtdC5jDQo+ID4+Pj4gYi9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc210LmMgaW5kZXgN
Cj4gPj4+PiAyMzc4NzE1NTlmMC4uY2QxYzA4MDFmNzIgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJp
dmVycy9maXJtd2FyZS9zY21pL3NtdC5jDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9z
Y21pL3NtdC5jDQo+ID4+Pj4gQEAgLTYxLDIwICs2MSw2IEBAIGludCBzY21pX2R0X2dldF9zbXRf
YnVmZmVyKHN0cnVjdCB1ZGV2aWNlICpkZXYsDQo+ID4+Pj4gc3RydWN0IHNjbWlfc210ICpzbXQp
DQo+ID4+Pj4gICAgICAgICAgICBpZiAoZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LCAiYXJtLHNj
bWkiKSAmJg0KPiA+Pj4+IG9mbm9kZV9oYXNfcHJvcGVydHkoZGV2X29mbm9kZShkZXYpLCAibWJv
eGVzIikpDQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgIHNjbWlfc210X2VuYWJsZV9pbnRyKHNt
dCwgdHJ1ZSk7DQo+ID4+Pj4NCj4gPj4+PiAtI2lmZGVmIENPTkZJR19BUk0NCj4gPj4+PiAtICBp
ZiAoZGNhY2hlX3N0YXR1cygpKSB7DQo+ID4+Pj4gLSAgICAgICAgICB1MzIgYWxpZ25fc2l6ZTsN
Cj4gPj4+PiAtDQo+ID4+Pj4gLSAgICAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfQVJNNjQp
KQ0KPiA+Pj4+IC0gICAgICAgICAgICAgICAgICBhbGlnbl9zaXplID0gUEFHRV9TSVpFOw0KPiA+
Pj4+IC0gICAgICAgICAgZWxzZQ0KPiA+Pj4+IC0gICAgICAgICAgICAgICAgICBhbGlnbl9zaXpl
ID0gTU1VX1NFQ1RJT05fU0laRTsNCj4gPj4+PiAtDQo+ID4+Pj4gLQ0KPiA+Pj4+DQo+IG1tdV9z
ZXRfcmVnaW9uX2RjYWNoZV9iZWhhdmlvdXIoQUxJR05fRE9XTigodWludHB0cl90KXNtdC0+YnVm
LA0KPiA+Pj4+IGFsaWduX3NpemUpLA0KPiA+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBBTElHTihzbXQtPnNpemUsDQo+IGFsaWduX3NpemUpLCBEQ0FDSEVf
T0ZGKTsNCj4gPj4+PiAtICB9DQo+ID4+Pj4gLSNlbmRpZg0KPiA+Pj4+IC0NCj4gPj4+PiAgICAg
ICAgICAgIHJldHVybiAwOw0KPiA+Pj4+ICAgIH0NCj4gPj4+Pg0KPiA+Pj4+IC0tDQo+ID4+Pj4g
Mi41MS4wDQo+ID4+Pg0KPiA+Pj4gVGVzdGVkLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAu
Y29tPg0KPiA+Pj4NCj4gPj4+IFRlc3RlZCBvbiB0d28gYm9hcmRzOiBJTVg5NCBhbmQgSU1YOTUu
IE5vIHJlZ3Jlc3Npb25zIHdlcmUgb2JzZXJ2ZWQNCj4gPj4gZHVyaW5nIGJvb3QuIExvb2tzIGdv
b2QgdG8gbWUuDQo+ID4+IFRoYW5rIHlvdSAhDQo+ID4NCj4gPiBIaSBNYXJlaywNCj4gPg0KPiA+
IEFwcGxpZWQgdGhpcyBwYXRjaCBvbiB0aGUgVS1Cb290IE5YUCB0cmVlIGFuZCBmb3VuZCB0aGF0
IGl0IGFmZmVjdHMgdGhlDQo+IGkuTVg4VUxQLiBPbiBpLk1YOFVMUCwgdGhlIFNDTUkgYnVmZmVy
IGlzIGluIFNSQU0gYW5kIG1hcHBlZCBhcyBub3JtYWwNCj4gbWVtb3J5Lg0KPiANCj4gVGhhbmsg
eW91IGZvciB0ZXN0aW5nLCB0aGlzIGhlbHBzIGdyZWF0bHkgIQ0KPiANCj4gV291bGQgaXQgYmUg
cG9zc2libGUgdG8gZml4IHVwIHRoZSBTUkFNIG1hcHBpbmcgaW46DQo+IA0KPiBhcmNoL2FybS9t
YWNoLWlteC9pbXg4dWxwL3NvYy5jOnN0YXRpYyBzdHJ1Y3QgbW1fcmVnaW9uDQo+IGlteDh1bHBf
YXJtNjRfbWVtX21hcFtdID0gew0KPiANCj4gPw0KDQpIaSBNYXJlaywNCg0KQ29uZmlndXJpbmcg
dGhlIG1lbW9yeSByZWdpb24gZm9yIFNDTUkgY29tbXVuaWNhdGlvbiBhcyBNVF9ERVZJQ0VfTkdO
Uk5FIHJlc29sdmVzIHRoZSBpc3N1ZS4gV2l0aCB0aGlzIGNoYW5nZSwgU0NNSSB3b3JrcyBjb3Jy
ZWN0bHkgYW5kIHRoZSBpLk1YOFVMUCBib290cyBzdWNjZXNzZnVsbHkuDQoNCiAgICAgICAgICAg
ICAgICAvKiBTUkFNMCAoYWxpZ24gd2l0aCAyTSkgKi8NCiAgICAgICAgICAgICAgICAudmlydCA9
IDB4MjIwMDAwMDBVTCwNCiAgICAgICAgICAgICAgICAucGh5cyA9IDB4MjIwMDAwMDBVTCwNCi0g
ICAgICAgICAgICAgICAuc2l6ZSA9IDB4MjAwMDAwVUwsDQorICAgICAgICAgICAgICAgLnNpemUg
PSAweDFmMDAwVUwsDQorICAgICAgICAgICAgICAgLmF0dHJzID0gUFRFX0JMT0NLX01FTVRZUEUo
TVRfTk9STUFMKSB8DQorICAgICAgICAgICAgICAgICAgICAgICAgUFRFX0JMT0NLX09VVEVSX1NI
QVJFIHwNCisgICAgICAgICAgICAgICAgICAgICAgICBQVEVfQkxPQ0tfUFhOIHwgUFRFX0JMT0NL
X1VYTg0KKyAgICAgICB9LCB7DQorICAgICAgICAgICAgICAgLnZpcnQgPSAweDIyMDFmMDAwVUws
DQorICAgICAgICAgICAgICAgLnBoeXMgPSAweDIyMDFmMDAwVUwsDQorICAgICAgICAgICAgICAg
LnNpemUgPSAweDEwMDBVTCwNCisgICAgICAgICAgICAgICAuYXR0cnMgPSBQVEVfQkxPQ0tfTUVN
VFlQRShNVF9ERVZJQ0VfTkdOUk5FKSB8DQorICAgICAgICAgICAgICAgICAgICAgICAgUFRFX0JM
T0NLX05PTl9TSEFSRSB8DQorICAgICAgICAgICAgICAgICAgICAgICAgUFRFX0JMT0NLX1BYTiB8
IFBURV9CTE9DS19VWE4NCisgICAgICAgfSwgew0KKyAgICAgICAgICAgICAgIC52aXJ0ID0gMHgy
MjAyMDAwMFVMLA0KKyAgICAgICAgICAgICAgIC5waHlzID0gMHgyMjAyMDAwMFVMLA0KKyAgICAg
ICAgICAgICAgIC5zaXplID0gMHgxZTAwMDBVTCwNCiAgICAgICAgICAgICAgICAuYXR0cnMgPSBQ
VEVfQkxPQ0tfTUVNVFlQRShNVF9OT1JNQUwpIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICBQ
VEVfQkxPQ0tfT1VURVJfU0hBUkUgfA0KICAgICAgICAgICAgICAgICAgICAgICAgIFBURV9CTE9D
S19QWE4gfCBQVEVfQkxPQ0tfVVhODQoNCkJlc3QgcmVnYXJkcywNCkFsaWNlIEd1bw0K
