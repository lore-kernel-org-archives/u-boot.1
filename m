Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53708CCF9FA
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 10:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F268394E;
	Fri, 31 Oct 2025 11:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="RfWrQPyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B05838AE; Fri, 31 Oct 2025 08:52:16 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 815A98331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZkptTCQWC2WfH4ZTnBkFKzxaKEvPK+OhWg+7FlIXWVmiTibyNjqGXLxcoOU/fLAbZA5TTX65FGk2jwy+WOTIpxpWDVz3GxJpiuQer8lMfbJwixfHgHDkye31uAqCUFHGQQ/mS12MlEUIGQCUYdLmxtOWRCDDKOfsGOEFsfeyprKEZ/canozIS/5LUFlr2aG0iICAQrBjdwKC3npesd0ytuBi8+zu7ES7RQOliADTZkXlQ+DQbU3b1LHHt8yioCcm4/zYS3DcgqApo1l8eD8d6Hr4YXbAgvboaBHro6GlIVdLaRWXVWgFZL/y9l1yGV/qvP0PW3kurUmAmTOJcsHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdteHwtApJHhcyniDiYZBmdXLvLKb5H4ykBIJp2Hm8E=;
 b=PkgKQF9j0KRnfKasda1WuG5/dLmnlJIqvY5HuuHtaysxDNV4DSE0JKouaZXRwBLIvB1QFBcJ0BOxNaKhWE2KU0wY4xsMHdaNRheu/VP0v5Na6eyZ8RF2OnG5YBSgXpx2pDgUdj/qRykg4a7NBT+6i2/0pWcY8yac703BgrdicBfogGSTBAmjmEvalnyvGtaW2wGeUHClwI6fUTWBAr0Fm7GE0LVn5LUE5bso5fLmRLQ6695qimMNyXXK1uKJcP30aBfLx2xfWu5KBu2TgtgQT98zADvJSVyIb+fz5Kb8P6znmkiHCabmTxgb5BUP8Shi8SYJ5jSvqwcnbnUfyX4PDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdteHwtApJHhcyniDiYZBmdXLvLKb5H4ykBIJp2Hm8E=;
 b=RfWrQPyroTx2j6kGunNKmZAUzKVB9R6a2MhxIZZm58PKX7EwNMd4MPAOjUIKGW/yOCN8pProK7hcm/8IeLbcuqTu4siG2mhrsBxEnkmaWxzDoYVYWotAzROYuao7ClXNM5ePdtAWj4S4uVyYEKTioQFJCryFVCnus1/iwc3QMJTAW9JcRnkPkWo/cGYP5IB4A6st1VRK6XD60NElYR03vbH0XcyEtjXVDGUZAE7Seg6huFgtLiAj9JA1LA14Oo51pcM7nWjx+NqGteGuX9Fd6llHsTfriQUKCS7qOShJLIj37XRzAPMTBOEPxPIka32n5VHl74DNNJjRuJs9R0YBXA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11434.eurprd04.prod.outlook.com (2603:10a6:10:5cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:52:11 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 07:52:11 +0000
From: Alice Guo <alice.guo@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Etienne Carriere <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTog5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BB?=
 =?utf-8?B?VENIXSBmaXJtd2FyZTogc2NtaTogRHJvcCBtbXVfc2V0X3JlZ2lvbl9kY2Fj?=
 =?utf-8?Q?he=5Fbehaviour()_misuse?=
Thread-Topic: =?utf-8?B?W0VYVF0gUmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZmly?=
 =?utf-8?B?bXdhcmU6IHNjbWk6IERyb3AgbW11X3NldF9yZWdpb25fZGNhY2hlX2JlaGF2?=
 =?utf-8?Q?iour()_misuse?=
Thread-Index: AQHcSheFlyrYRNUGyUyrWHPOj/5oPbTbpHgAgAA9ogA=
Date: Fri, 31 Oct 2025 07:52:11 +0000
Message-ID: <PAXPR04MB96441809F6362E35C7D3E052E2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
 <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
 <PAXPR04MB964436F50D41BF186019598FE2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <ad762bb5-fb1d-47db-94ca-b8115f077e6f@mailbox.org>
In-Reply-To: <ad762bb5-fb1d-47db-94ca-b8115f077e6f@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU4PR04MB11434:EE_
x-ms-office365-filtering-correlation-id: 071c8e6d-d6e5-4430-183b-08de18526645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?K28yaitNaWhxdVJiMmd5MmMwVVdYdVFkT256eHoyQWwzQ2pBMzBOVXIwQS8w?=
 =?utf-8?B?U0g4NFpKMnM2N09ONmFIQlQ2eGFtYXMvb2VvZDhQYWpNbXZqa0FTN1BKVDNw?=
 =?utf-8?B?VlJpN09LN0QvTmc4Q2VIbTlmR0lpVnpSdDlVaC95OVZ3Y3dVN25zYVRmdEpp?=
 =?utf-8?B?R0JHTUlVTWp2OER1UEdoay9hN3l5TWNUcFdHRngzOEc0Ym16QkJIdUJwWTho?=
 =?utf-8?B?MjJSbHVrOWZNcE1IYVg5YWRTTFN3S2lCU1NqTXlvazZ0aTBnMGZtdUVWVjlT?=
 =?utf-8?B?SDloVzRSSlRFSGhaQkZkREpGZ1Zwd21vRktNMm9QeU9EYitRRG1VQ2xxeUgy?=
 =?utf-8?B?VUdyeXZjTjIxeXhKYjdKSWZJUS9MZXpVdEttYnVpa1NkRFZoeXBPRTFyODdK?=
 =?utf-8?B?cFhPUEhQTGxRVU1MOHhmNDZjSzJJTC9PZTVSL29ZQ3JIN1owNnBQcUEzM2JX?=
 =?utf-8?B?M09NdEZjczB4NXBpam5odTBUb2xBNE05Tmk0Q1oxWTJ3cEVoZlRidW5OTDk5?=
 =?utf-8?B?azdQanN3amlSVEg5STE2WHlFV3h2TXlVdHRzSnJXZHBDWk1kRlZ3cE05S3Ft?=
 =?utf-8?B?aVBQSjRWSUw4NG93bDZKSndTZFJjb0N3MU5KWEMyTXJyREJQTmhDVGpsV3hi?=
 =?utf-8?B?aWVoT21xVHV6em9iTm10Q0JuTE9iS3JXRExBc2dGQkVKTVBYa2VrUVMzWkRp?=
 =?utf-8?B?YjE2TkJ0c3NEQVl0NXJsWUpzdjVsYmw4blBRRjFmWWkrMDBVcmY0OEtXNkNk?=
 =?utf-8?B?N3I2c3g4TklMSkwxUWtYVW0raC9XSmc2ejhhQVhWZUFXY3l0d1AyR0p0N2d6?=
 =?utf-8?B?ZWxHOVY3MGRJZzd5ZmFidFQ4TWxqdlR5WjEwUFovMGpFSHc1VzlGNEtJWGtP?=
 =?utf-8?B?UkJRYkRyMnpSQ29sQkp2c1hvZ2FKM1E2dU9KaWVOZFltSFBYdzYwSjdDSFpB?=
 =?utf-8?B?WFhCQ1pZMXRDeDNEa3FmUGo1NVdYd2ttNTlkNEtuN0trZFVzeHoyUWoyeHdC?=
 =?utf-8?B?a0dRRDVBdTFtY3JHdHdtdGUrSVNSd0cvQnEyT1B6eDJoa2dMcEd3MDN6ZjI5?=
 =?utf-8?B?bUdkKzZaTU13eHRKREhjeTQ3UkR5Q09nTldYU2toRGFFYWZKaytNdDh0Rmsy?=
 =?utf-8?B?K095YnhPSkxJVStJL2l6eXI4R1FnWFJvSWYwMXNMazZhcUJHb2Y2M1MyZVlO?=
 =?utf-8?B?V0pENTY5WmtINS9kU1orUml6QXhGNG9WdnpJODRUbmhBdG1sbGZKdFJsaW1L?=
 =?utf-8?B?dnlGeUxRWXN0VGgydll5TUFDZEtjbG1pU25USjBsT2wxdlJ2U2V3U3o3SHJK?=
 =?utf-8?B?TmlSUU1wajVNVm5HUUNCb2JFVlU0Y21SQTZUYjk4bFgxVFpQZzRuNEdXNUtF?=
 =?utf-8?B?blFLclMwTzhrOHFQVTJleTBkMC80ZHhqRjFaVWN1c01YOVdUNjN4SmFkOGtX?=
 =?utf-8?B?bWRsc2dHUmM3ejAwS002VzBrTlhBYm9sU0lIT3BQZ0ZZUlJzR2hFOUxjT0lt?=
 =?utf-8?B?OHE3UGl4SGdsd3UzUGRVVktPY2NlbWg1RFExc2FQeWRnQW5aUHQ4UVltZ0NR?=
 =?utf-8?B?QzEvaGR6N0JXNjd4TjJOTXVaOXpjRzVyTjlPaXNiMmlRWDZiUTRZaHlEOTBr?=
 =?utf-8?B?WjBsbmhJaEtQNU15ZkhWMVFpSUplR3huM0JCUm0zU0huaUZsRU9mbStSWFUz?=
 =?utf-8?B?RzBCMFdiakd6b1pUMm12N0Zzd1RRN0E1T3crZ1lVelJRclBnb01IRU1CMkRR?=
 =?utf-8?B?UThXUWVQRFNqK2VXclhDT1plUlg0ZUEvdllJVHE2VXl1akNEQjQ5OUJsRHY4?=
 =?utf-8?B?cEhZV3ZoZEtoVFFzcFRLMm1rK3JCaitQWkFEOVZzZm92RFdBMGxBa1NaRnFB?=
 =?utf-8?B?cm1EYjhGQ0dSRnBDTlZKelBiMm1iSkFKTmprSjR4UmdqSWtqNzJBTnB3c1pj?=
 =?utf-8?B?RmtFNlBTaUdJTVpkeEFHV2t0WHo5MVozekpoNXdoYlZRaEt5SE1Ic1ppdVBt?=
 =?utf-8?B?R3RmYkdTSEFBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1cxSVN4dU5MTEI2YXNqU2FhTEY4RmRxU0x5WFA0ZGV6V3kybHF3WlB0Yk95?=
 =?utf-8?B?eGtqWkRsUHg3ekJhdHJmWHI5aG9MWkVqNDE0L25La0d6dTdnWDhzZFp5SVRE?=
 =?utf-8?B?RW50NDJqRG5jc3JzRWcyWFBpTkU4ZU5QbElnWUo0RmVrNHV0NzFZM0dEaCtw?=
 =?utf-8?B?TWVKSnNnM2RlM0ovdXg2Y2djei8wSGdLYThHSW8vV1ZDOE8wV08wUnFlSVZD?=
 =?utf-8?B?TXlwSUtUcE02OTdObHhTUGh2S0NkVmtjMHYrczg4b3pxeDNaOUxUS2hXTEhz?=
 =?utf-8?B?ZnBCdXN1eVRmL2ZLTWM0U0ZQbElLaGZaaHl2NXFMcCtZY1lmYjI3SUlXa081?=
 =?utf-8?B?bmpoTWdCNGU1NW5aZGh5Z1UwTjN5MmVqNlp5NDlvWCtIM3lSQzBucU1XWTF3?=
 =?utf-8?B?TmwxOEpudkZJWHd6RFBzY2VNSEdxbjFnKzFpeWpiNTg5c1Y3UFNuR1ZIUzBp?=
 =?utf-8?B?VjJPMlBDM3pFUHRFSVRCMDlzMnlPYXRaTXVmNG56VnBGcituSklKdlhuWWow?=
 =?utf-8?B?U2RVMTF3M2hEQzl5RnlBVWpSQW9MQTROL1dNdUhrS1c3dE9lSythSEZIUG16?=
 =?utf-8?B?alpKMGlTa1YxQjM5SmFZQ3RlUmhrQzA2MXhVaDJVNjFGd1FCQXlMckt2Rks0?=
 =?utf-8?B?TU95c2FaU3ZDT0Q5aWVJS0VtdmpSbTBrWk52Q2ZUeHNHWWkzc1ZNL1VXdDdj?=
 =?utf-8?B?MFBYeXFjRk1yY1YwcFJyMjN6YVd5NnhxT3QrNzNzRGlxRU5ZVHBHcXRQUVhE?=
 =?utf-8?B?QW9IV0J0c0NLQ0o1NGk2cHJCVzVYOWF3RWN2MWRLRGI1d0dHOGp3MEFDSURI?=
 =?utf-8?B?OG9aMHVhamM1R0FTOVdHY0ZTd1ZnOGpMa3N6MTVKRjl2WEQ3NHNRQSsyeVpZ?=
 =?utf-8?B?R1J5TFgzdm56MjZWbHoxNDhteFJBdlFGajhNaXJoM2RGZ2c1L051Q2Q0a1Fy?=
 =?utf-8?B?VlFSaHNoKzJ6bWVJaGVQVUI5aGpVbjNSMjlPK3M4QUQrYUtNT2RFeGl6bWpu?=
 =?utf-8?B?VkRzK2d0VWtIUnBMdDFnYjZBcXY3Y2dPRVlxVVhEZjFSbUV1dVV5WTR4Rjcz?=
 =?utf-8?B?cTVwZHJObUo1WkMzM2pBU2xKT1MxaFNrNUtidUp0aDd5NGtuTmlZSHZ6SkFs?=
 =?utf-8?B?U0xoTThHeU83L2FXS3hRblYzcnBJSFpDRmU5M3FzK1dySWR0SWtvYXB5eHpP?=
 =?utf-8?B?cE5rL3FtdmxIUHNSZHU1WmhBaWRlSjZhakVUcFBTVVEvRkFTaUR3RTRhaWps?=
 =?utf-8?B?YWdoNkptM0RSRnl3ZE5zSnFDM2d1a0ZoeEtuMzF5K2d4U0F5VTBuQ3VVY2FK?=
 =?utf-8?B?VzVadStSeGFnYjJuMVZPZ1d0UmJWT2RlclRCSlhXTHd6UUVjaEdiR3lUTHUr?=
 =?utf-8?B?QVJMSlBwUFE2d2hEcGVBdXdEekZyWW0vbXFxekN4dFhHd0ozenBJbEVqbkpw?=
 =?utf-8?B?YVN4MnMrRG1ISlFjRGthTnQwRkRteFRieVZLZmxGd1Q4czhJZlVhRjU1QUx4?=
 =?utf-8?B?NzgwTEFlcGptdHNNc3hwcXUrcVcyeXN2a3pwWk1ETk9ramQ5UDJ2RWo1RlVV?=
 =?utf-8?B?eW9rekJMWHNGSGpnaHdHTHpSN01ZUmJWc1JHL0FrNFpJV28vRHNhdFZXekZj?=
 =?utf-8?B?eEpLeitKS3BjWjNFMWduVThqM09tdTF3NmlXZHpqQ0dSZlZsenBrK3lIMmlU?=
 =?utf-8?B?TEYvZDB6M3VKVitUSHhDSC95MUFRYm43UGtiNzRZYXpDSnd3N3RrYmRGOXZZ?=
 =?utf-8?B?cjd2T1crbXlKRHhsV3F1cUVwRzJ1NC9BcjNKWWVzTE52TDlHQ2FzaWVDNDl0?=
 =?utf-8?B?Yk9TaTFjTlZYVUFJcHY1QlN2cmNNalNla1dtM1BPT2dWOElPcjVVb3QvcEc5?=
 =?utf-8?B?aE05aUphS0xWNVBhWHJCZkpNNHROdllOTFFsRnJJNnBKWlRPWWU3VFlNOTJ0?=
 =?utf-8?B?cDZ0RkV1bDNwVVI3SEViekZKVDF6enRmcnJIKzNKRzJSZ2IzYldoS1lBc2lZ?=
 =?utf-8?B?S3dsRGxTeGE2cFg1SUFCRGtiUmZvbHJOMmtIZDFjaVdxNXNqL21hVDJERVUz?=
 =?utf-8?B?QjFYc2dUOURHWnppY2tvQ29WODRrMVc0ZWdlS2I1UWF6R2UrOTUwNHoyTlNM?=
 =?utf-8?Q?LA+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071c8e6d-d6e5-4430-183b-08de18526645
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 07:52:11.4924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kcm7kd9ar1PBf2CM1tKb5a7D5WpP1cn6mNIPbe/RtWWZeKLxcpPkQsM64jtIq1nKbBlvHSkalBDXBt3wOqjYsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11434
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
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMOaciDMx5pelIDEy
OjExDQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+
OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiDmioTpgIE6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54
cC5jb20+OyBFdGllbm5lIENhcnJpZXJlDQo+IDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5vcmc+
OyBQYXRyaWNrIERlbGF1bmF5DQo+IDxwYXRyaWNrLmRlbGF1bmF5QGZvc3Muc3QuY29tPjsgUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28uY29t
PjsgVmluaCBOZ3V5ZW4gPHZpbmgubmd1eWVuLnh6QHJlbmVzYXMuY29tPjsgVmlvcmVsDQo+IFN1
bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiDkuLvp
opg6IFtFWFRdIFJlOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0hdIGZpcm13YXJlOiBz
Y21pOiBEcm9wDQo+IG1tdV9zZXRfcmVnaW9uX2RjYWNoZV9iZWhhdmlvdXIoKSBtaXN1c2UNCj4g
DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUg
d2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRv
dWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcw0KPiBlbWFpbCcg
YnV0dG9uDQo+IA0KPiANCj4gT24gMTAvMzEvMjUgNDozNiBBTSwgQWxpY2UgR3VvIChPU1MpIHdy
b3RlOg0KPiANCj4gSGVsbG8gQWxpY2UsDQo+IA0KPiA+PiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0
byBmaXggdXAgdGhlIFNSQU0gbWFwcGluZyBpbjoNCj4gPj4NCj4gPj4gYXJjaC9hcm0vbWFjaC1p
bXgvaW14OHVscC9zb2MuYzpzdGF0aWMgc3RydWN0IG1tX3JlZ2lvbg0KPiA+PiBpbXg4dWxwX2Fy
bTY0X21lbV9tYXBbXSA9IHsNCj4gPj4NCj4gPj4gPw0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiBCZXN0
IHJlZ2FyZHMsDQo+ID4+IE1hcmVrIFZhc3V0DQo+ID4NCj4gPiBIaSBNYXJlaywNCj4gPg0KPiA+
IENvbmZpZ3VyaW5nIHRoZSBtZW1vcnkgcmVnaW9uIGZvciBTQ01JIGNvbW11bmljYXRpb24gYXMN
Cj4gTVRfREVWSUNFX05HTlJORSByZXNvbHZlcyB0aGUgaXNzdWUuIFdpdGggdGhpcyBjaGFuZ2Us
IFNDTUkgd29ya3MNCj4gY29ycmVjdGx5IGFuZCB0aGUgaS5NWDhVTFAgYm9vdHMgc3VjY2Vzc2Z1
bGx5Lg0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAvKiBTUkFNMCAoYWxpZ24gd2l0aCAyTSkg
Ki8NCj4gPiAgICAgICAgICAgICAgICAgIC52aXJ0ID0gMHgyMjAwMDAwMFVMLA0KPiA+ICAgICAg
ICAgICAgICAgICAgLnBoeXMgPSAweDIyMDAwMDAwVUwsDQo+ID4gLSAgICAgICAgICAgICAgIC5z
aXplID0gMHgyMDAwMDBVTCwNCj4gPiArICAgICAgICAgICAgICAgLnNpemUgPSAweDFmMDAwVUws
DQo+ID4gKyAgICAgICAgICAgICAgIC5hdHRycyA9IFBURV9CTE9DS19NRU1UWVBFKE1UX05PUk1B
TCkgfA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBQVEVfQkxPQ0tfT1VURVJfU0hBUkUg
fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBQVEVfQkxPQ0tfUFhOIHwgUFRFX0JMT0NL
X1VYTg0KPiA+ICsgICAgICAgfSwgew0KPiA+ICsgICAgICAgICAgICAgICAudmlydCA9IDB4MjIw
MWYwMDBVTCwNCj4gPiArICAgICAgICAgICAgICAgLnBoeXMgPSAweDIyMDFmMDAwVUwsDQo+ID4g
KyAgICAgICAgICAgICAgIC5zaXplID0gMHgxMDAwVUwsDQo+ID4gKyAgICAgICAgICAgICAgIC5h
dHRycyA9IFBURV9CTE9DS19NRU1UWVBFKE1UX0RFVklDRV9OR05STkUpIHwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgUFRFX0JMT0NLX05PTl9TSEFSRSB8DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgIFBURV9CTE9DS19QWE4gfCBQVEVfQkxPQ0tfVVhODQo+ID4gKyAgICAgICB9
LCB7DQo+ID4gKyAgICAgICAgICAgICAgIC52aXJ0ID0gMHgyMjAyMDAwMFVMLA0KPiA+ICsgICAg
ICAgICAgICAgICAucGh5cyA9IDB4MjIwMjAwMDBVTCwNCj4gPiArICAgICAgICAgICAgICAgLnNp
emUgPSAweDFlMDAwMFVMLA0KPiA+ICAgICAgICAgICAgICAgICAgLmF0dHJzID0gUFRFX0JMT0NL
X01FTVRZUEUoTVRfTk9STUFMKSB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBQVEVf
QkxPQ0tfT1VURVJfU0hBUkUgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgUFRFX0JM
T0NLX1BYTiB8IFBURV9CTE9DS19VWE4NCj4gPg0KPiBFeGNlbGxlbnQgIQ0KPiANCj4gQ2FuIHlv
dSBwbGVhc2Ugc3VibWl0IGEgZml4IGxpa2UgdGhpcyB1cHN0cmVhbSA/DQoNClBhdGNoIGhhcyBi
ZWVuIHNlbnQgb3V0Lg0KaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS91LWJvb3RAbGlzdHMu
ZGVueC5kZS9tc2c1NTc3NjYuaHRtbA0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZSBHdW8NCg==
