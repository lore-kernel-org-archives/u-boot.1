Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C25C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC3E0837F2;
	Tue,  5 Aug 2025 16:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="VqViEPJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18FE8309D; Tue,  5 Aug 2025 13:30:25 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4453082E26
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/9feXG1pAFXJJ5hV87wirfyK2JoBqd0rKhtZyVPfqyK0rwh+/G0uO3H1lRDsDo9ugztd4tJiedr8Ms98ffCZeMysUoyQbBMU30TzeYcQ4n36XvtLfAVAi1fi7C65vyOplhCtXZmFJAwR4uutKDfewhqtW7EnBhTeSp5QKSfLZ4c5CeqyQ5UANs+4km8mWslyqadEeMVQrLSb9sv3snUWq/bJ+mgI40OSCDUx41Yjd7PFFvxr33rBgjyPTP3OMwQr11J4hfaRJBvh9ksYN6zVoqyzGsvEJ21jLaZJ/6JMxaHNIdLFFXjMt11F3LAlq3EdmwzzPAbvS73/wk1wsgF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7mfKTxKP6AStWZ7m+KjpX4lbwMNo2QJBBNK4dxytt0=;
 b=jOHacOFt1pBjHjofHxwciEf4LRKavh91WvxCS3e77Z/kjvSdGsYQr4S3GfQnh2lMq5LJlMuOQUYWMKA/cjeSunpEU/1LUkFFJyi3YWvV9c23q4aWaAwNJUk9QOql0bV2+y5NlQHnBjA6J3lqrNH2qRJjn79r68FwlGyZaoEAIp4i7kA7x8vctrFdFk+EMFZiFeScAO23ZjDcZ5QdZ4/b+fxvYLGnUhGTbl7jCS5ynwXWwoT3h2aT3/KE3vyoyKgiByufiYRamb7UcEPOaFLFiLo9jNCk5+HjOn/XyvZt7VHZWd3ZXJ3F+BmGp4uyD+Cp29nbDES9a0XhtWHONPlt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7mfKTxKP6AStWZ7m+KjpX4lbwMNo2QJBBNK4dxytt0=;
 b=VqViEPJ1F2G+/Zwm7PtGxEX9cHCbEgJmtPo/ysF9bWZkY7sEEjX2818xEaBdoMztBXdTLpovAqufS1hOKbXSJwLDxGI/to9BOqNIrTn9Yy+HA+lSQG566etZ7UghbS/c/LwluhFLy/CQdkNWwXh2JFl8gFTsGVxneAGRmAFL9mryi276MGg8nxxJvBWjRO3xp2xDFTHtius3OAbqjzkDUbuSU4hR0/8ZvkuudCkfmPdawj+GvpR775yLHCHYHDfVy4v8dr6U56yv2M6Aqus9BoYlVNF7Ao3OKFxX4FWnXdtECD83p2g72j5cLGNNlCspoKXtIdHSLUgnY3RmvGS8zw==
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com (2603:10a6:10:291::22)
 by PAWPR06MB8812.eurprd06.prod.outlook.com (2603:10a6:102:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 11:30:07 +0000
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d]) by DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d%6]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 11:30:07 +0000
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: RE: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Topic: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Index: AQHcBe0S3kynZXd3OkScXc3RsybZB7RT4fIAgAADLRCAAAP5gIAAAjow
Date: Tue, 5 Aug 2025 11:30:07 +0000
Message-ID: <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
 <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
In-Reply-To: <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.22.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB7849:EE_|PAWPR06MB8812:EE_
x-ms-office365-filtering-correlation-id: b0f02633-90ab-4cd6-9ea1-08ddd4136e1b
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q2s1Tm5RSWo0TjZDc0pFcW5HaU9qcXpwcEdyeUIrdWNoRzk1ZUIzV2F6SU5B?=
 =?utf-8?B?NThFMFk2RXpUYkliSFJvTHJBZGplb3pVU1lnNEhsNnVZbm0yM21WZFhCMEtv?=
 =?utf-8?B?ZnhYWmlhengzMFlIdlFXUGRUSG56YzVCUUdNeTJhaTFyY1U1dkptaUpoRzhT?=
 =?utf-8?B?YXgvOEgyazRYQVFGemE1M0p6WTVYVzUvemlDTTd5UnFJb2tJalV3dUNzWmNQ?=
 =?utf-8?B?TEVOTVBBdDJYZDBaaXJ4czhkQmxMcEdCMk1SYW5XMXBRQ1dFRjRLMUJ2MTJB?=
 =?utf-8?B?djdIN29ic3RRWDlZZlhERjZ6djVmeFN0bURDTHFqS3M3TlJadjZyWEpwRzgx?=
 =?utf-8?B?MVQ5c2w3ckF3clZLSFkwNVl3c0ZTcmNmSEVnWmtFeE53OHBBakdQRkJUUng0?=
 =?utf-8?B?VzJlSExrREYzdmlpVG5MajdnV3gyQlFTb1ZmNzVvcXlwbkdUdEwrTDFKVlRw?=
 =?utf-8?B?TDVkNTAwMnAwcGZGQ1BmM2U2SkcxcXJ2YkhYTXVkcTJCZ3VaOE5MVU42VzB1?=
 =?utf-8?B?Nmw3SERuZkt5R09wWHRiWm8ya0tsYVQwaktZS1dMY0VJQXNjMkhGaUwvVndU?=
 =?utf-8?B?OFUvcmx5NHgyU3NFUXk4Y21RRnFzc2Q3bkF4OHpZQ1RGWHJxMENIaEEzVHpo?=
 =?utf-8?B?UVZiMTZ4WFNPVGYzT3RYaUFhSTBUSDFTaCtubEsrREFub0ZmZkdLVVF6czJs?=
 =?utf-8?B?TkpiTk9Ha0FRVElqVkY3aG9CUVd1Nis3eVo2VDN3bmpsTmZSZUU1VUUzcWtW?=
 =?utf-8?B?bjRYOENGdjIxYldQUU5uZU1lOG95TGltUHdxMTBGQ2c5cUlDd0ZtaWQybVVm?=
 =?utf-8?B?dFhPK1Jza1hJY0NNUUcvVmV2eUhnYmtaSkUxK3FhM0VaMGRXazNRRXYyY3ln?=
 =?utf-8?B?YzRlRitCVC9Rc0xvV3dnZG96cHNVVGRTQUlza1E1dmpqS3NmZFVjaERjeGhh?=
 =?utf-8?B?aXFpY3FEL25aeCsvWmZTSEoxcSthRWhTQVRvT3ZzbENpQXhlcVNxYXB3RHE4?=
 =?utf-8?B?RXlYc2dRaDlNRFBQMVJTTzRIK2JxbitSalZ2VU1OMHJZK0VDanlFejBBY1d4?=
 =?utf-8?B?Qm85VFBGTHhIUndveXEyM1U4RiswTTFXcEUxOHRXb3JmZGgwTmdWcHJKMjla?=
 =?utf-8?B?N21ZSGNHeFpBWG1SVy9zcmIrZTNFamRLNGtkazc3bGIxamJLRnBkK2YxUzFL?=
 =?utf-8?B?azU2SjZRRE1BUEo3RkQxUlhub3dacU0vcFZObU5tT1c2NEtuVFhMb0lSbldm?=
 =?utf-8?B?NFl5cEd4QU5lbjViekwvbzlPS2I5WXAzNjZXNkpkVmNQN055MVErMWR4NHVK?=
 =?utf-8?B?SStacXEvcTJPeGFkRlJ1eXFWUWJFM3JSY0FmTi96SmVBSkJwVkg0amdVRUtr?=
 =?utf-8?B?SU1vRUtwVDk1eTZhby9ZU3QzR0lSbU0wOGQ4VzUwR2FlM3JnSU9PUzdMVWpz?=
 =?utf-8?B?L2U5c0s0VURiY0IvZDdsb0tWNjFYcHFtdlFVb0JSaDd1WTZEUys1S01aK1JJ?=
 =?utf-8?B?dTlvY1pkekRtUTNMNFdMdVUzRjIxa2NCZVQ2U0JwSThRYnF4eERId2g5QTRD?=
 =?utf-8?B?YVJNdnNXZnVRV0NIbHc5YkxNKzRBMXBROS9Ndmd1SUNXdnRMNjlIQ3JiR3J0?=
 =?utf-8?B?elRvbzJDTVFhcVNxaGh5QTlHU29ybjZudUh3Z295WmxkSnhOQm1HQjhnQmV0?=
 =?utf-8?B?MmN1WEdNWllFTFc4RzZMS0ovVTJ4NEY5dXlSQlZmMnY2dU1VaGFxT0Z0S3VP?=
 =?utf-8?B?cG1kZGRtcUYvSkNTSXZyeG50RkRpMExiR3VYUGEwOFdiSDdKckJMS1VTbW41?=
 =?utf-8?B?aE1QRWdTV3ZFc0NHbm5IQ085NXI4bFdUN20xOHNPdDE3NlM2V0IweTB6bi96?=
 =?utf-8?B?cUwxY0x3SUN3bXRKWE5DNTFmZldSaldKaVB6UDB2bWR4SVFQdkZLU0pmbDBN?=
 =?utf-8?B?bTZ5dno5YmNhTkovVklueGFrMkFpdFBmL3dDMTY4VGRMcUdKZHFYeSt2eVZD?=
 =?utf-8?Q?tWhIFRTxcQ7Mxpowntg86qczt8Dq+Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7849.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHVIc2t2anJyOVIxTWFWWjQ3bm56NjhxNlQwelNyUVMzSjJEY0ZxWS9HVkht?=
 =?utf-8?B?ZFVXTmhGdlBaR1JOOVZIUzErUnFsTG9IZlR3eTlZZmVFRDRoOCsxV2RsdUFq?=
 =?utf-8?B?cDZzT3BRVXFKRFMwM09vZ1kySmo4VmtkRnZiT2gwUDRhSnZ1eUF4ck9oWUxC?=
 =?utf-8?B?bCs2ZWNVNytHQ09hK3dNWFhZYnA0czhybnVFeW12c1NYRTRybktubDQrakMr?=
 =?utf-8?B?TzkvTnN2RXBjWlZJeEJnRmlrOFMyTDYxQnVmV08xbGlrdTVZbEdDYy9SQXMv?=
 =?utf-8?B?dmVHWHR4dVZmcWtaUzRCQTVmelk4UHhmejNYUVltZm9jeHZBSktHeUxSSkxi?=
 =?utf-8?B?V2V5Zk1QN2hCYllOay95ZVVuVWNqWFJBTlJqcUZwNmdBdW4vQzRacTJ0L1dm?=
 =?utf-8?B?d3lhd0V4RkVHS1piNGhWTVRTUk5UbWJmclo4QitoV1NmOUthT0tmVUVwRHBs?=
 =?utf-8?B?OEx2K3MzcUJ5N00rYThTTCtyc09RaGRPM0U1VHdZL2VUWVN0VitMQVdxVTFO?=
 =?utf-8?B?MGJ5bzFuQzJONCtBRDZ6ZW1TQjdsSTltMTZIZ3NVaHBGaEl2SFRVZTBCMGJW?=
 =?utf-8?B?S2Rla1dXSytsZm1MV1VSL1BVK1FyT0o1bHdMT1dGSnMyTTE5czR2OW9MRGtj?=
 =?utf-8?B?cm1INlB5MWRFRWlwRWQxUUU4QVlwMTkxY08vZVBEYTdWb1I3aFVFRUNCRjhO?=
 =?utf-8?B?Tjc0aGtQdExtRkVwb3ZtS2hGNGwxcWlDQ1I1SmtoU05SeDB4NnF0cSsvNjgy?=
 =?utf-8?B?a3E3K21RK0dWRGxibVF2VXlPTHI4WUlidjBIZGh2cm1YbERsRkM4bS9vbjJt?=
 =?utf-8?B?UlZEM3JHc2RFTm10bFdwVG0rUVppRGVvUGdwc283WCtvWEVVcnJBY3ppOUYx?=
 =?utf-8?B?YjR6RU1GczBuNHM3RzlNdlBpYi9CbTBUa0JXUWo2eFpPZTJXYnVUOTFKdlB1?=
 =?utf-8?B?SFBnelpjWmxRbVg3NzVSRkg0aFlaL3h4WDhPZDI1WWxhWGZZM0ZKYzQ5UERn?=
 =?utf-8?B?UEJVYjdQMldXdi9ER2N0VTU1NytraGtwTktqWVZxYXIrZTQ4V0pVbmdyWHJr?=
 =?utf-8?B?ejRXWE9OanRvT0QrSHRLMFdlTWYvaWdlSzRjb2RhcmNXK1BhOFVkWnNOSnJH?=
 =?utf-8?B?S1ZMSEdzUXpNV1ZiTVlqamxrQlREVlVYd21GRm5aSnBiMGtFM0gweTh4OTI3?=
 =?utf-8?B?bnFrUXFYU0JSQ0FpTWNiUHo5bk8zc3lVRmVoVWV0a3BzTXEvb2NFc0gwMXE1?=
 =?utf-8?B?cWR2YlZhK3FqM2N3N0pmQmdSRGhHV0hGVDZxNmJBellnb0ExcWNNNy9HYUl1?=
 =?utf-8?B?ZW1LVE1XM1BtV2RJUGlZUnVjbURCTVZYVy9wamhNTjRzRVJ2azlrc1BzTzFt?=
 =?utf-8?B?VklzVXBQRUF3cEZvUE1pQUYxcWJKOUovOUp4K2EwWDRWYS9zQys2WE1MMnMr?=
 =?utf-8?B?K2RMN2pwU1picE1sRzFmeDdPb2pRNFhKTlNPa1NOcVBiQlA2QTZDblA4eUFT?=
 =?utf-8?B?YjJleVVsbXIycFZmWU40V3NSeXROWWIrMjRSUlpqTjJodGxrOGFyK1NoT2sy?=
 =?utf-8?B?ZWQ4VWNXVVFFVG9iaDJIYlBOSzk3OWJITXgrQzlOVU5MREhQTjhxQzIzY3NQ?=
 =?utf-8?B?S003dkw4ZGhtQTFaMVF0VVBFbzFsV2hmaktNYW5yblR3amgrb0FUTUI0dnVv?=
 =?utf-8?B?eDkxRWpYSG1mR3pYUmVkZmdHTUxEZXhsZjlUZlBEay9EZURPTEZDOVJRYlJV?=
 =?utf-8?B?Yi9XSUw2NUs5QjUwZllEaE1DNWtXeGlqS0E2bWRoZWRUalNTdVlzMGRUa0to?=
 =?utf-8?B?WHZlZENXSHJBcjJKdml4MU12cisvWmN3cWZ6SFFuVW1HdWowRCtkMWhsdElW?=
 =?utf-8?B?VVNaNStrcnAvTVZOdHI3cHJaWmVENTgwQmdaMDNiYkhEbUF1WEU0aVFKWFRh?=
 =?utf-8?B?QW5TZWZsc0NYMFRCQStwbTZ4NUNvZkpCeXpkZmNLNGpMVGY1Q1N0RmFCZ2dI?=
 =?utf-8?B?Q2FodFRlOGV6bm51YWVTbWNzOE80aExOYUE4ckNoTlVCb25OSFRKbzNuY0pi?=
 =?utf-8?B?a0RtQXlBMXZSd2c1MFA4ckc3ZWtEWjlMYTk2U2hMbTh5bU04ZG1RNksxQ0RL?=
 =?utf-8?B?S0lxa2tkSWVMaGQ1QnZzczRyZlFmMDVJMU9DYnZldmRrTUV1VnhlbGo1YWlD?=
 =?utf-8?Q?Rk7sXWXExHJqqfCA/owQ1d4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7849.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f02633-90ab-4cd6-9ea1-08ddd4136e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 11:30:07.2709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFGkjtsTCF8Oe6C/65z0mbzvGM+V0CReEhI2y7+qoRVSBeOKA1RAqYAYEE/WwOfIormxXxeF9AaIADfLAQ1uDkbW9he1i67/cKZUfGgdY9AHLRy7F1DMsTQWiXw0s1NJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8812
X-Mailman-Approved-At: Tue, 05 Aug 2025 16:22:00 +0200
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

PkkgYW0gY29uZnVzZWQgaGVyZS4gWW91IG1lbnRpb24gYWJvdmUgdGhhdCB0aGUgYWRkcmVzcyBv
ZiB0aGUgcm9vdGZzIGlzIGRldGVybWluZWQgYmFzZWQgb24gaXRzIHNpemUuIFNvIHlvdSBkbyBr
bm93IHRoZSBtZW1vcnkgdGhhdCB3b3VsZCBiZSBuZWVkZWQgZm9yIHRoZSByb290ZnM/IEFsc28s
IGhvdyBkb2VzIGNhbGN1bGF0aW5nIHRoZSBhbW91bnQgb2YgUkFNIGxlZnQgb3ZlciBmb3IgdGhl
IGtlcm5lbCBoZWxwLiBJIG1lYW4sIHdoYXQgaWYgdGhlIGtlcm5lbCBpcyBiaWdnZXIgdGhhbiB0
aGUgYW1vdW50IG9mID5sZWZ0IG92ZXIgbWVtb3J5PyBDYW4gdGhhdCBub3QgaGFwcGVuIGlmIHlv
dSBkb24ndCBrbm93IHRoZSBhbW91bnQgb2YgbWVtb3J5IHRoYXQgd291bGQgYmUgbmVlZGVkIGZv
ciB0aGUga2VybmVsIGFzIHlvdSBtZW50aW9uIGFib3ZlLg0KDQpTb3JyeSwgbWF5YmUgSSBtaXN1
c2VkIHRoZSB0ZXJtICJrZXJuZWwgbWVtb3J5Ii4gSSBhbSByZWZlcnJpbmcgdG8gdGhlIGFtb3Vu
dCBvZiBwaHlzaWNhbCByYW0gYXZhaWxhYmxlIGZvciB0aGUga2VybmVsIHRvIHVzZToNCg0KRnJv
bSB0aGUga2VybmVsIHBhcmFtZXRlciBkb2NzOg0KDQpgYGANCiAgICAgICAgbWVtPW5uW0tNR10g
ICAgIFtLTkwsQk9PVF0gRm9yY2UgdXNhZ2Ugb2YgYSBzcGVjaWZpYyBhbW91bnQgb2YgbWVtb3J5
DQogICAgICAgICAgICAgICAgICAgICAgICBBbW91bnQgb2YgbWVtb3J5IHRvIGJlIHVzZWQgd2hl
biB0aGUga2VybmVsIGlzIG5vdCBhYmxlDQogICAgICAgICAgICAgICAgICAgICAgICB0byBzZWUg
dGhlIHdob2xlIHN5c3RlbSBtZW1vcnkgb3IgZm9yIHRlc3QuDQogICAgICAgICAgICAgICAgICAg
ICAgICBbWDg2XSBXb3JrIGFzIGxpbWl0aW5nIG1heCBhZGRyZXNzLiBVc2UgdG9nZXRoZXINCiAg
ICAgICAgICAgICAgICAgICAgICAgIHdpdGggbWVtbWFwPSB0byBhdm9pZCBwaHlzaWNhbCBhZGRy
ZXNzIHNwYWNlIGNvbGxpc2lvbnMuDQogICAgICAgICAgICAgICAgICAgICAgICBXaXRob3V0IG1l
bW1hcD0gUENJIGRldmljZXMgY291bGQgYmUgcGxhY2VkIGF0IGFkZHJlc3Nlcw0KICAgICAgICAg
ICAgICAgICAgICAgICAgYmVsb25naW5nIHRvIHVudXNlZCBSQU0uDQpgYGANCg0KV2Uga25vdyB0
aGUgbWVtb3J5IHRoYXQgaXMgbmVlZGVkIGJhc2VkIGZvciB0aGUgcm9vdGZzICJpbiBydW50aW1l
IiwgaXQncyBub3Qgc29tZXRoaW5nIHdlIGNhbiBjb21waWxlIGludG8gdS1ib290IChpZiB5b3Ug
YWRkIGEgbmV3IGJpbmFyeSB0byB0aGUgcm9vdGZzIHRoZW4gaXQncyBiaWdnZXIpLg0KV2UgZG9u
J3Qgd2FudCB0aGUga2VybmVsIHRvIGJlIHRvdWNoaW5nIHRoaXMgcGllY2Ugb2YgbWVtb3J5IHRo
YXQgZW11bGF0ZXMgdGhlIG10ZCBwYXJ0aXRpb24uDQoNCkkgaG9wZSB0aGlzIGNsZWFycyB1cCB0
aGUgdXNlY2FzZS4NCg0KVG9tYXMNCg==
