Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC575E7E0BE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 10:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0462B839A5;
	Mon,  9 Feb 2026 11:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RzDae23b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD0C83BC9; Mon,  9 Feb 2026 11:34:29 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900688397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 11:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpCigOzsdJEVVy2CtgoKQ/UqNr7qse65xdGSv/P2pBdZbGsxcsx3uj91Zrt5Oq5UXw5vsigwpXLw39jblH6PmDECgWXBsAorZtANS9Y/e7q2DuLwd0Ageak1xgWU45U83gWzb74NCfMXa55j2wDo2HOqzFpe/21Ks/e3xOkxaC88YHrKLKFOLQHBbbozQ2Li447mx1ZG09UsoBUWCBTrGLeurrZMyu9me/Qao8H5KYz4YBGDOj96GHRoXFAXOzRvqZxYnDI0uGsVQLlgtHCddbbNvug364fRh+HdES24UFgng1lpOnzJbA3V1OG3ujWcBRsnhzSPv/kHK4lZNeBj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUysnEuHCKSWS4SuvlkQqXwcMkb+dI9VnL/o5+X7kpc=;
 b=GjsXpegCMS9t71Wg5Gt7BfFUA8JMSiREeLYJ+vH9rDqeocYdGyEJNTKXXQJAfMikk702E1e5CLuIgjpjy7GgRmcdDLRUwtBfrEq0UVn1XF/693ywT4d7hcMJZjuzJZDGjnE/WI5SyG2XU0OG9FynYxiLK/HXuJ+WQoHHNWz6gHFxS35Va8iZ0uNVPhGwfjgGCqGiqaoVHJd3DxuxIa5m9vlzwoFSliqG98Ga6EZSBVsmK1NamS3VdO/m8+rTS/AbxQlg82zKmDzkf4G+7ck76D2OkzEoYeO2txF10z5l3KLEL20N8qBrkROAIkmWClY/53GL4aIwTom8prmALvPfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUysnEuHCKSWS4SuvlkQqXwcMkb+dI9VnL/o5+X7kpc=;
 b=RzDae23bIqdgJ5ydiLLDUhD54gvtj1Ca/ooA5jcnptnf5ZboYHxOHNVt7HySEdbeaWVDsX1XOaSAP1PiwWaejwpIknW2BQ/hfOyemrsaxD9tgAaabB+w9O55yalXgIXXHQyHbaBTbEAo/PMoiurbYhvosD5bWzrQlF2+zW+y/Q64t+IdK0EmpYGVDYwHgj9PSFd1j8PpCfazsYPbzJTNHPBB6ftNYQRKISh6vK+RZFoMykSh46yp6PnsOvMCl0UgFrBb9E1MZqSXoRmBNQ87utVikfpFO3LjKymRdWMWKG7/1h2a8ILo/3DAqDceKUT3/UBTehtZUW/Ucu/lpwKNnQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:34:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:34:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, "Ross,
 Fedor" <fedor.ross@ifm.com>, =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Frank Li <frank.li@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam
 Ford <aford173@gmail.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Sumit Garg <sumit.garg@kernel.org>, Marek Vasut
 <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMTAvMTJdIGR0czogdXBzdHJlYW06IGFybTY0?=
 =?utf-8?B?OiBmcmVlc2NhbGU6IFN5bmMgaS5NWDk1MiBkZXZpY2UgdHJlZSBmcm9tIExp?=
 =?utf-8?Q?nux?=
Thread-Topic: [PATCH v1 10/12] dts: upstream: arm64: freescale: Sync i.MX952
 device tree from Linux
Thread-Index: AQHcma+oADPiASMwFEGyK6mRH6XVXg==
Date: Mon, 9 Feb 2026 10:34:24 +0000
Message-ID: <PAXPR04MB964411EF269E12B1B7F20689E265A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-10-2103d0222a0b@nxp.com>
 <20260205153850.GK2603314@bill-the-cat>
In-Reply-To: <20260205153850.GK2603314@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS8PR04MB7768:EE_
x-ms-office365-filtering-correlation-id: 83c93770-2e2d-4fbf-1267-08de67c6cb4f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NFZ1TzYwVFdHRmYxL0JKVVhuS1gvMEpDSWVXWnFidEJDbjRzUSt1YWI5VHZx?=
 =?utf-8?B?N1FMVTlhZzMyRHBEUlp0RFY5ejFEVGlMa29zdGpGeENXL3QwSjVvckI3aUFR?=
 =?utf-8?B?dGlzck9BYXYyRkd5Q25rditwM29laGRTd1pFZkZuR3NFN21ab1VRN1d2OVcw?=
 =?utf-8?B?ZzkvRkQ2ME1YMXo3ZDQrOTVnRmhkTUluRGh4OWE0eVFrQnF5UDViWVowbHQz?=
 =?utf-8?B?VVh0SnF0Y3dJTStpQklvMjh2UlVsSU1DUDh2aVV0Ujc4S2lFRHg0NnlSUUlM?=
 =?utf-8?B?WjBmNzRJNk9KeTI2UEZaTGtNVlNGVWpTR2R4RXd4NHhHR2Z6Ui83SGVaT3Zl?=
 =?utf-8?B?MlZ3YWhrVzV6eW14WEZBcGcrSWlmYzVRaThPSzlxWHBPZm5ZSDh2RjVIRTZN?=
 =?utf-8?B?MDRVc3pML1pFczBXSUFtR01CcTNnZ2lBZEk3K0YyRlBuWlFwWE1DSDkrZk1J?=
 =?utf-8?B?OEZhZXJMKzVOT0VWUSt5Qlpwa0x5K1RwaGVneUd4WjVGSlZURUhSaWhPdUxP?=
 =?utf-8?B?d01xU0FhbzhIODNWQTFNYW53U0tsYUxkRWJmUHY3OGR0a1ErSUhwUElFNzVT?=
 =?utf-8?B?MkVWWTRsR21HK2xpVUNmQWxDOWoxbjI3RDhHRksvZnc3S25rM2pkTWV6c2hH?=
 =?utf-8?B?c3pSNllEVjN1S3NkUHZDQzNJTU80MUZQd0oxTlR4VFhZNC9HZVdBTWFxRVgx?=
 =?utf-8?B?VlNXVGxFUEdZN2YvcENhaWZmcnpvZEZnVStxbm5mWjVTTW5VeFlrZXpLWVVB?=
 =?utf-8?B?cXZTT2NiZkRLTGt1YURreWIzNjBtVWEzYmd0eDY4L1FQeDE2UjVrMXhGai9z?=
 =?utf-8?B?dndBeFVKL2I5Y01KSEp2Sjg2VCtVbFNxTnVvc0tUZHRaRTVLa1hKV1B0VHM0?=
 =?utf-8?B?d3Z6Mmo2d1NYb2lub2N3NUpZd210dUFQMHZQNERYM0IrbUVuQlhJYllWWlk4?=
 =?utf-8?B?RzFmaXdFQnhVdG84RGtudm1CRDVZaEVvc3I5TDdYYUhVWmh6K2w3K09yYnJW?=
 =?utf-8?B?K0JMVWNmVmVGSFUrMmE0c3ZFZ09ERGFxajByZDJPMnlqZ0JBN29FbGl5TUpP?=
 =?utf-8?B?d1ZITzJpOHRncXdEOHY3bngybzAwL1o1YmlyNW5yeUhDUmFYTm8xdXAySVdt?=
 =?utf-8?B?N3JLVUZuYnV0UWxtQ0tRanNIc2hsMkxiOWV4QXdmZVc0OUFOT2xmQVBuNWNG?=
 =?utf-8?B?OXZPTzJHOUZwcjVHWlA0dWtBZUphV0Q0bFpzY3dJSEZPMko0bXFhYnZRckxP?=
 =?utf-8?B?ZTI2TDYzVU10SzlpdkpHa1VvdGUvazRqcG1iNzBBc3VOeFNBNjZSTk1HWFdM?=
 =?utf-8?B?c1d1ZTdRdUhnM2JhYWRCTHNZL21JVTA5dVE2aThwSDZHTDNja1Vrc0gzQjVl?=
 =?utf-8?B?L2tXeGJ3Wi9iNXNsd3RWZFZPZm8zcEtlQkhwc2tnYk9UTUY3V1FLWkk2MmVM?=
 =?utf-8?B?enF1aW50TFFma2xCU1MrQ0VPcERQLzcxVnlYNFRzYWtsTUtNWS9HbzlEb05G?=
 =?utf-8?B?SHBsMzN3RVdhMWMxM0d6KzJlcVNYR08wb3JENy9pcExyU0g5dUY0Z3h3U1d4?=
 =?utf-8?B?VnorOVA4SitPK1VvRDl5KzRWdlFRYndsOVovWTdkb2lEenZxZEpacDNkTHUy?=
 =?utf-8?B?VmFVamFxdUNMT0dmR1Z3SjdMR2hrandLWlo0YmNiQUFVdkxKZ1oyYm1ncUsv?=
 =?utf-8?B?Z2FBcDhnblhzay9ERmxOMzZQOWhNWjA3OHZsRXZJc0dkYzhmM1JLbU5hRFJS?=
 =?utf-8?B?cWJSNnRFZ2hHekMwTW55Q3pRMUVxSjc4TnVJVHZNUURmREVQMUdIdXNjZXlz?=
 =?utf-8?B?akFLSVRvUHVWVjdPN3BDOUxLZ0NETWVObUQ2RnFtRnhDNTBPWXZNb0NwR0tv?=
 =?utf-8?B?eTJZOFB3Mk9tdUlPd01PVVZ4eURKNDMvdFNMUC90S1VSN2hWYTNLaFYvbG5z?=
 =?utf-8?B?Y2ZBNEZ2aW5DWFZNT2c2Y29HYlpvZEI5VnRod1FRdkQ4Sy9aS0d1aXJ3SWtY?=
 =?utf-8?B?QnBlQ2NtQW9HWC9UUnV0Y3BMbHdNVFR0bHNmY05zTHFOYmwrK2lucTg5V2sx?=
 =?utf-8?B?aVVxWmJOb20yRDliNDVsb3BGV2ZFZmIxQkJDSks2a1ZPbVIwS0VhVlNOSnRI?=
 =?utf-8?B?UkRncGJHckZXOHdScWFEREUzOGFJTWJsTTFyUDlrYTQ3dk5tbmNZZXNjdWNt?=
 =?utf-8?B?N3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1pQN3A5UGR3UWRDY0FrYnNrNldqOTZPS211RFBxbzJRUWVnT3BRSERoSkRs?=
 =?utf-8?B?cWgyRlZOZVdQRGdpTHFtdjV2aXRvbVh5M2pZMkxidzdhclQ0T3JtQS9pRmRV?=
 =?utf-8?B?NjU4V3R5bFVZT3VPVmJGSzJUNXhZcmpXR2VEcHREV2IrVGF6R2Q5R2lZQmUz?=
 =?utf-8?B?MDRZcU41VWt0bFBUVHJGTU5ueUJ2WS9KeFdieVlESUtzRXEydGFSZXpQeCtl?=
 =?utf-8?B?ekNQSVgvdU44VGZnelRIOHlKeGxCU05nTlVTcjNwcVpxRnBaclFnT2t5S05C?=
 =?utf-8?B?a1Fnams3K25oZXdFbllVMHRBcE9DSkwxWkcvK1ozVVFGVzFiUjVXbjVlZExG?=
 =?utf-8?B?TE4rNkhyRlliR2Z5SkhMaUwzZmdqbmFlaFZvMEZ3dm1JTFdJOFJlVjhoREFC?=
 =?utf-8?B?RmhqblRKc3d4SlBXTnY1OVlHYk9rLzZOSFp6MUFCZDVrNDBaZW1kNzdscVVI?=
 =?utf-8?B?S2hJZW83S0VCKzdHS0tMekcvU1o1Q2k3VU5CZlRXTVU1NjQxSGp2U2d2SGZs?=
 =?utf-8?B?VUd4VVE2blhZZC90SlZHNE9COG15L2NXWjY5QTlJYWcwVmFnVDhQVEV3d3N5?=
 =?utf-8?B?bGNHQklZOFVyUnFMRjhEbitUSkFnb282ZDZJVUNKK0pCVzd5VHMrcEdybVp4?=
 =?utf-8?B?YkNjTlNoeXp0ei9rdmVneDhGOGdIT1ZxUDllR1loeTBEaUJhaEVNejZIL0tY?=
 =?utf-8?B?Q1N6bmlYd2c4S3lIcU11U1NLZ1dDZ00vSit2dWFjRzk0bnlUeEJXd1RJQlFa?=
 =?utf-8?B?cis5dTF5aW93R1Q2MWkyRjRpbVk4ZzJNNUJYOHVZd0F1WFludXBRS1NYRFdN?=
 =?utf-8?B?N012MEE3WTRNUWVaSm1Db0gva0lITGRubFpIeUxIRDZybjU1bDlucTBVOVVD?=
 =?utf-8?B?MkJjMnB4N05EMlpXblJuSzBFbThSMStvQkh0YWhmc0trVXN6Ui9KOWlaUVhw?=
 =?utf-8?B?aDF1SXU0OVBZNytFcmhwc0ZmS2lnYUtFQlArekw3V0Fqa012MjhLSXNnQyts?=
 =?utf-8?B?NURGVDlQL1ZkZWVSYXlJRWJuaW9VcWdsNlh5NzFrMHNmYjNMR3E4c2lnUXdF?=
 =?utf-8?B?MmNqN2pMblQ0Sk1seXJ3WGIzU08rRld3TlZTVVFRR0FDOG1UdElDeGI2Q3dm?=
 =?utf-8?B?Q0pZS0FPS0plVGpCcWJsR0orQUowMUlEeXFoVGRoYTRDY05aYzZPWDAzKzNM?=
 =?utf-8?B?T0c3S01OOXB5UjFBRjhTV2RhaWxuZDFjUER0dnRXNTI3dnZlcGhSNlQwS0Rt?=
 =?utf-8?B?LytBVFNBNnNqT1Nrc0p5MGRITXdRTUVYaXYxTGlHTzhTSndTdVVpS1E2TmRG?=
 =?utf-8?B?a1Y3NTFDWlZsdktQUnNTOWNWb2djY1B1REoyVmptam1sdHpuZTdKaTVhSW9w?=
 =?utf-8?B?akFkVUhpUjVPUStaZVdZL0txZDlVOEo1cUorWUI2WXBFemxhNFk4T3JMUEp6?=
 =?utf-8?B?TUxhS0V0SWhXMDNYWmJKM3hzOTNMcVU4eWtqL0JNa2FNazJnVE1nK2dxb20v?=
 =?utf-8?B?M1NPWFNnMWVQSDdpQ0NPeGpIRmw5Smc3bVMzQXpXZjMzYTUyZTEwU0IwRExL?=
 =?utf-8?B?N2twRGoyY05CQWtVSU1VUFdHVFJhUXdDOXp2TVdhRytnKzJEZnRIVExFQS9B?=
 =?utf-8?B?QU5qR3k4YW1LS2F0cDB2S1pOVXhjUGhkbHE2aUFDalZRTWkwclJKbEJZWFN4?=
 =?utf-8?B?cExONk96SGdpYTQwS09YcnN5VExaVkhWd2srMDR0djVNeVFTbzlYWjJHL2Jj?=
 =?utf-8?B?anBDRWtFbndIem50cExRSjdQRFZHZGhQZS9GMWhZekErSGRVWDJXdDA2ZzBm?=
 =?utf-8?B?R01KVWNVMElPdWJUdTBxbTllQUJPTnc4YndjQjIrS0RjbzA5Z29jaXU1dmR2?=
 =?utf-8?B?ZUd5ZkhHREYrYkdwQ3IyQkdzTndDUWtPYXAydmRUaHVSb3RHa3RwVTg2OGJw?=
 =?utf-8?B?SEdYNDhubEpXdkhUcDZvWmNLU1IyYU1pZlM2Y3BUdjI2cCtKd0NTR1I0TXpl?=
 =?utf-8?B?OEF6OWgwY2owZWxqREdOMUhNcWpCaFR3RHhIYXVBZFRZRXFJdlNINVV6cEt4?=
 =?utf-8?B?VmdIQ2ExanFTUFIzd3dCRks0UU5LelIwVlNwejV2QVRYc0RKSVR6VlMzemJn?=
 =?utf-8?B?dVVnbFhhV2tUeG1HMGpIRkpZdnVDdW9mSHkxd1pDc0ZzRHUwTTQwOHFLTjlZ?=
 =?utf-8?B?R255QVdpZzBETXhTMUpGVFBIaEVpb0E0cXJjbk5pdmNEcjc0eVlpODNYZFpE?=
 =?utf-8?B?U3RQa2FUeTlHK1RPZmdmSi9jUk1MNUhaUXJEYWl5Y1NHblMyck5yRzdyMDM0?=
 =?utf-8?Q?iLvH841U9G7lhj1z3r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c93770-2e2d-4fbf-1267-08de67c6cb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 10:34:24.4703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QMDrh6F3wNBFcLKO3NAWKZmu3IDAapdVMdwhIXg+z5pAhkBdNjIDCf6Go0gh63kDVp+SU80L0arTaQqeAI6DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVG9tIFJpbmkgPHRyaW5pQGtv
bnN1bGtvLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0MuaciDXml6UgMjM6MzkNCj4g5pS2
5Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g5oqE6YCB
OiBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7
IFN0ZWZhbm8NCj4gQmFiaWMgPHNiYWJpY0BuYWJsYWRldi5jb20+OyBGYWJpbyBFc3RldmFtIDxm
ZXN0ZXZhbUBnbWFpbC5jb20+OyBQZW5nDQo+IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFllIExp
IDx5ZS5saUBueHAuY29tPjsgSmluZG9uZyBZdWUNCj4gPGppbmRvbmcueXVlQG54cC5jb20+OyBK
YWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyBNYXJlayBWYXN1dA0KPiA8bWFyZWsudmFzdXQr
cmVuZXNhc0BtYWlsYm94Lm9yZz47IFJhc211cyBWaWxsZW1vZXMgPHJhdmlAcHJldmFzLmRrPjsN
Cj4gUm9zcywgRmVkb3IgPGZlZG9yLnJvc3NAaWZtLmNvbT47IEpvw6NvIFBhdWxvIEdvbsOnYWx2
ZXMNCj4gPGpvYW8uZ29uY2FsdmVzQHRvcmFkZXguY29tPjsgUGF0cmljZSBDaG90YXJkDQo+IDxw
YXRyaWNlLmNob3RhcmRAZm9zcy5zdC5jb20+OyBWYWxlbnRpbiBDYXJvbiA8dmFsZW50aW4uY2Fy
b25AZm9zcy5zdC5jb20+Ow0KPiBWaW5oIE5ndXllbiA8dmluaC5uZ3V5ZW4ueHpAcmVuZXNhcy5j
b20+OyBTYW0gUHJvdHNlbmtvDQo+IDxzZW1lbi5wcm90c2Vua29AbGluYXJvLm9yZz47IFJhbmph
bmkgVmFpZHlhbmF0aGFuDQo+IDxyYW5qYW5pLnZhaWR5YW5hdGhhbkBueHAuY29tPjsgSmkgTHVv
IDxqaS5sdW9AbnhwLmNvbT47IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPjsgU3VtaXQg
R2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29tPjsgQWRhbQ0KPiBGb3JkIDxhZm9yZDE3
M0BnbWFpbC5jb20+OyBGcmllZGVyIFNjaHJlbXBmDQo+IDxmcmllZGVyLnNjaHJlbXBmQGtvbnRy
b24uZGU+OyBEYXZpZCBaYW5nIDxkYXZpZHphbmdjc0BnbWFpbC5jb20+Ow0KPiBBbmRyZXcgR29v
ZGJvZHkgPGFuZHJldy5nb29kYm9keUBsaW5hcm8ub3JnPjsgU3VtaXQgR2FyZw0KPiA8c3VtaXQu
Z2FyZ0BrZXJuZWwub3JnPjsgTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT47IEpvc2Vw
aCBHdW8NCj4gPHFpamlhbi5ndW9AbnhwLmNvbT47IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxp
Y2UgR3VvDQo+IDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHYxIDEw
LzEyXSBkdHM6IHVwc3RyZWFtOiBhcm02NDogZnJlZXNjYWxlOiBTeW5jIGkuTVg5NTINCj4gZGV2
aWNlIHRyZWUgZnJvbSBMaW51eA0KPiANCj4gT24gVGh1LCBGZWIgMDUsIDIwMjYgYXQgMDk6NTU6
MTZQTSArMDgwMCwgYWxpY2UuZ3VvQG9zcy5ueHAuY29tIHdyb3RlOg0KPiANCj4gPiBGcm9tOiBB
bGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+DQo+ID4gU3luYyBpLk1YOTUyIGRldmlj
ZSB0cmVlIGZpbGVzIGZyb20gbGludXgtbmV4dCBuZXh0LTIwMjYwMjAyOg0KPiA+IC0gQWRkIGlt
eDk1Mi5kdHNpIGZvciBTb0MNCj4gPiAtIEFkZCBpbXg5NTItZXZrLmR0cyBmb3IgaS5NWDk1MiBF
VksgYm9hcmQNCj4gPiAtIEFkZCBpbXg5NTItKi5oIGhlYWRlcnMgZm9yIGNsb2NrLCBwaW5jdHJs
IGFuZCBwb3dlcg0KPiA+DQo+ID4gSW1wb3J0ZWQgZnJvbSBsaW51eC1uZXh0IGNvbW1pdCAxOTM1
NzlmZTAxMzggKCJBZGQgbGludXgtbmV4dCBzcGVjaWZpYw0KPiA+IGlmaWxlcyBmb3IgMjAyNjAy
MDIiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9mcmVlc2NhbGUvaW14OTUy
LWNsb2NrLmggICB8ICAyMTUgKysrKw0KPiA+ICBkdHMvdXBzdHJlYW0vc3JjL2FybTY0L2ZyZWVz
Y2FsZS9pbXg5NTItZXZrLmR0cyAgIHwgIDU5NiArKysrKysrKysrDQo+ID4gIGR0cy91cHN0cmVh
bS9zcmMvYXJtNjQvZnJlZXNjYWxlL2lteDk1Mi1waW5mdW5jLmggfCAgODY3DQo+ICsrKysrKysr
KysrKysrDQo+ID4gIGR0cy91cHN0cmVhbS9zcmMvYXJtNjQvZnJlZXNjYWxlL2lteDk1Mi1wb3dl
ci5oICAgfCAgIDQ0ICsNCj4gPiAgZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9mcmVlc2NhbGUvaW14
OTUyLmR0c2kgICAgICB8IDEyNjYNCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDUgZmls
ZXMgY2hhbmdlZCwgMjk4OCBpbnNlcnRpb25zKCspDQo+IA0KPiBUaGlzIG5lZWRzIHRvIGJlIGRv
bmUgKGFzIGEgc2VyaWVzIG9mLCBpZiBuZWVkZWQpIHRvb2xzL3VwZGF0ZS1zdWJ0cmVlLnNoDQo+
IGNoZXJyeS1waWNrIG9wZXJhdGlvbnMuIFRoYXQgZ2l2ZXMgdGhlIHJpZ2h0IGNvbW1pdCBtZXNz
YWdlIGZvcm1hdCB0aGF0DQo+IHNob3dzIHRoZXNlIGFyZSBjaGFuZ2VzIGZyb20gdXBzdHJlYW0u
DQo+IA0KPiAtLQ0KPiBUb20NCg0KSGkgVG9tLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcu
IFRoZXNlIGkuTVg5NTIgZmlsZXMgYXJlIG5vdCB5ZXQgYXZhaWxhYmxlIGluIHRoZSBkZXZpY2V0
cmVlLXJlYmFzaW5nIHJlcG9zaXRvcnksIHNvIEkgY2Fubm90IHVzZSB0aGUgc3RhbmRhcmQgd29y
a2Zsb3c6IC4vdG9vbHMvdXBkYXRlLXN1YnRyZWUuc2ggcGljayBkdHMgPGRldmljZXRyZWUtcmVi
YXNpbmctY29tbWl0LWlkPg0KDQpTaG91bGQgSSB3YWl0IGZvciB0aGUgZGV2aWNldHJlZS1yZWJh
c2luZyBzeW5jPw0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZSBHdW8NCg0K
