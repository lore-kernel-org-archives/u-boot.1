Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0E6E9E30C
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED21183CEE;
	Wed, 11 Feb 2026 14:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CjNLnzkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F263883A5A; Wed, 11 Feb 2026 08:14:29 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7E38367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 08:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXiJ8/lq+ZI3TUMMWtZc7eXE+G5JSeVl7YtEidyEIDN88O/+jl1faWTj2pONRyTjT6CDM6ENkTk/+5O0Ry7MPLoULEMe58UOqrtXtqBujIqbcyPyVZN3qotS2mavk7vMtuEZ6cwV1TrxksT7dO3ephFVca/fyRnPKSR9RDd0SUQ3po9RzlQT3f8sPwd47rfOYcaoSkgqNE1fQzTXyv2Ciye7KXVN0Kg6DzW8+pU+1TzxtTYZyY3dFlx9wbwZL6fCWP5lmJPDEg7fUTRxmMhGVWHndTF1zURsyQ0kZqLT5Jqm88DteZCTpC/0Z0cca4Fzw69OAs4dmvYmmWl4owbi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfGba2dk45bgOf4m5WKowvoScZArP5n3+BuVZLsy2t4=;
 b=H+rHgEPfOmEoI9bjFsiqSOezkD47hVCgqJymmbl7BhR1s4gGlz4KHFYsAuCabhlabkGbSd7aAQKpu+ICbL0V+9nMGjEFdud8/8BJlBM0gsm+Wr1B5/Q+DZCn+0xLfCKPmZ+9oOZOQTyWxHd5S6ZJJZC6yWKWU1aB4LVPS5fI2yLxNOP/5ABxMQujJ+nHGK/tzikYYUmZ2vAhBrUvC+IiCggloaZJCUGsjBxOS9YhlJnCfxLTLjQ/UudPPvXEGnImbrLFqhyLt5Nj/RsrIeb+My+UMdiCUFM7SANjSghNcIvTlMFCWLXw0yssYqN873HJ88Jxu8ToS/VI18MbnoKVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfGba2dk45bgOf4m5WKowvoScZArP5n3+BuVZLsy2t4=;
 b=CjNLnzkVl2Cve3qKg7CY5rtUDD9tpoxdLYETfy5ek831g8YD4cCmmGgjHn4UnUvYlJZvG+M3DU2HV3rFNCEmaEwyhoCtj1Nz5dd7AlnBoDiPBtCq5J8apSQD8JgLUcfUEQbO6fXizUzMD9/6ZtjBvtKr1p0ktdF0nVkYDvkztprZ4GE5NAD/L6UlsVczP9sp5Fh1m0YdfT8JmkNybTR2Pw3+bgK3Oq0RSLxNPSe++5JbqF9rjI2C6MwzkOMfnu7r6yFal2l1R5RMH07XaB5zRsVY9XQIEsenvitNVxbTa1CpiawxzTxqZBL+KatsDkLLHgmyh2CBUX/PLjCmBTBgBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY1PR03MB7192.namprd03.prod.outlook.com (2603:10b6:a03:534::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 07:14:23 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 07:14:23 +0000
Message-ID: <074a310c-5ba3-4304-ab37-2c85d8cd58da@altera.com>
Date: Wed, 11 Feb 2026 15:14:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE
 Kconfig option
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-2-dinesh.maniyam@altera.com>
 <20260203145742.GH2603314@bill-the-cat>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <20260203145742.GH2603314@bill-the-cat>
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY1PR03MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 3968f078-637c-47dd-3773-08de693d2eb3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWdsd0krdFplU2R0RXVPUFltbnFPbnBWei9qTWxTcjJrNmNsdW5CUXBSZUtw?=
 =?utf-8?B?Q0JKYXptZm13c2lTYU04Nm5mUWV4b2x1c2lHYXpkMVdqV3ptS0xmZ1ovZWcx?=
 =?utf-8?B?T3VJdGMyanNKelk5dStzNExHYi9QVjRzNDlHQklTUmFiNnRraXk1ekFUTEZI?=
 =?utf-8?B?OGNiTEZFMzBvSmQyVi9iWEE5dHpoOTNTUFd3NTA5OTY0WFNpSW5Qay9NTWtK?=
 =?utf-8?B?WVJCNlJaUjBTZGw2aC8rdzZEaE92N01Eb1FnUG1zTHIwSHlhdGZGNXp5b2ha?=
 =?utf-8?B?cTE3U2hneHIyeGR4bEFySnZ3M2dxWHRQR1VyRDVlYnR4cTczT1dNdUJMSis5?=
 =?utf-8?B?bVJJZDFXWm1TMDNxcytuNUgzMkFQakp0ZTI3T0hEdVMyelV4WlNyS2lpYU1E?=
 =?utf-8?B?ZkNlL3kxQ3JKQ3JYdGR4bEFsc0JoZ3ZIbDJleGlZMTBqS3ovd0dLZWxVK0Fq?=
 =?utf-8?B?NVFQYmhjN05Hdjc2QXZHQ0cvRGZiY0JiQVZkWkY2c0x4dVI0UGlZYTNBL3No?=
 =?utf-8?B?WkM4WU9TVUREenVRbGs4N2k5RUpJQ29kbEFjVFovV3ZvTmUvakNuVk5PUk95?=
 =?utf-8?B?YU1pVUw0Z0VCT0lmSkRnMWJCc0dYQU9uTzdvRlV4dWhoYmhwNjZMMy96TC8r?=
 =?utf-8?B?T3kxMFg5eEJUYkZHR21MQloxbFJXWWV3SnR6YmpDVTdXZ1RJMUFzSmZyb3lD?=
 =?utf-8?B?YWs3Z0FXNWJFdGtxL3FrK0owaWV1cGZtT2tiMytKb2pMMkZ1emRGRFFPanBP?=
 =?utf-8?B?NEpEMU9WYlhnSU9mcCsxQXcxTW4wbmFmMXpwbEVoVXVRMkw1U21QZXVhQkti?=
 =?utf-8?B?WEIwYjZVL3kzckVnTk9HckJNSTk5aWJFeWNTZkRLZHFIaC80NDJVRU5FcDY0?=
 =?utf-8?B?b1JWdUFiWGhqbjBHbHpuVUlFMVBCc3A0dkRaL1Y2am5MS1F4VEl1QUFPV2tp?=
 =?utf-8?B?c2NSVUl1dmFaZTZTcWFOSGgzRnVKZ0VwaHpOWDdiWWcvZ2FQNWdiK0ZDMUp2?=
 =?utf-8?B?RXQyMTFXeC85VkZxWkNnMGQyQXlhQ3ZMaUhLdk03eGtYOVIrRERjRmI3cTRZ?=
 =?utf-8?B?TTZrejA3VFJqZGI2ZkQzVDlSRjZGVXFXSDJtUWZ3aS9IQVZVUXAyUC9vRCs0?=
 =?utf-8?B?Z3VicWRtbUpFa1JVUXI4ajJHS0MxMVFzZ1dKRlVLbVZrd1dyZWdRdlF0TjJh?=
 =?utf-8?B?dVdDNitDcmNZUXJEejZic1pXdlA5T2duVjBUeUZieFhDT1hvTkZSOEQ0cXhH?=
 =?utf-8?B?eHU2RGxmNm9DcFllTkJ2L1FTTXlvTktQT01rWDRPRXlTZFFXMFV0cUZ0N2Rs?=
 =?utf-8?B?RGU0a215UXQwVnFUdDNSMXlraGNHOGordWk3aDRWUC8vMVVQdDNpWkFWTlNT?=
 =?utf-8?B?RVhjbm5iZGV2M0JvMi9XMmF4Y2RPQlpFdlpFZUNVdU5vQWRzQ285Z1JpQTZj?=
 =?utf-8?B?Y3dFRFRGQitYS0tNc01haVlFbFFFYS9OTmw1TitrZWVXclVpN0Y1L1JuU2NT?=
 =?utf-8?B?RyszUTRlT2xEdlNFd05XRjkzZnkrc1BLNHV5NEtyS0k4ekFJRWtxZ2NqbmpI?=
 =?utf-8?B?OVhNeFZxalZ3cjlaNjdFUzRESlBDU2hlOWc0MTBwa3hsWHRXaHNDSFdrQlZD?=
 =?utf-8?B?TWFaZVYwVmNucE9XR2JZUXhnUkNBeXBqNnp4bjZkZllXT3EzbzRLUVM5c0Ny?=
 =?utf-8?B?NDY2amJ6RTJwY1JYTzl0QUZacFZBMlY1L1ErakxiNEJRWm8xaUFsQ2JPdnVF?=
 =?utf-8?B?dnVzMXRJNThMYWF1OE5SaGtudlJpTVR1UkN1TkdhWlQrdHNKb1R1cGNoTHFL?=
 =?utf-8?B?ZHZDL2YrRWo5N2wrZFVseENjc0VBWEN1UUpJc3RwYkR0QmszbmtCV2JSalBs?=
 =?utf-8?B?cXZOK0h0UG9IUjNPQlhjVjJ1MkZBQTd0aFcyY3hqeGZ0d3RhY1VCdFN3SXZL?=
 =?utf-8?B?djVTeW53Zm5HWEV3dSt6U21NT3E0b2hJRm5NMmMwL3o2U3kvSkhoS0wvdkpH?=
 =?utf-8?B?b1Y3S21yUURMVHU5bTdQWTY2WFRsdHNpeTdubXdzSndvVENZUEVzMndVTjQy?=
 =?utf-8?B?WkJQRzg2YkRib0JRSmpDZHFveVpZU3FDN281bWJxTitRNEI3bmwrdGZNUjNt?=
 =?utf-8?Q?x1Bo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FxWnRwL0h6RXE3OHhaNWlScEhCc25WSENWTmJ3TGF6OU85MWtGaklCeVBV?=
 =?utf-8?B?OGRxR1h2elhVZUZQVlAzd05oSWxaZGZDMVhpbDRoeTRqSzc4TEcxZC8wdnNk?=
 =?utf-8?B?YndyWFd6NUJtUE11OEhRb1QwU2FOQU9Za2hzRkNwQVFmVkN1VVJ4YUZHNTQ2?=
 =?utf-8?B?cTZrR0kxMXV2M0JDaEJ5Qit1TDFZYmp0dCtVU1NETkE2SkVKaTBMdlluYXBK?=
 =?utf-8?B?bUQvYXRDVXc3aW0zYXhCYkhBay9DbTNLL1VuUGdGYXdwQTNYMWFUVXpjeUlu?=
 =?utf-8?B?UFhyUWsxQTg4eVFOUzVSeEZkbEhBUjc3KzN0czNPeldMVjREMEdJWHNNZ01u?=
 =?utf-8?B?Qm5uR1czSExoVnJ2anlTekFheENTNkxsT09SVmlCanBtd0pZMk1Na1d2d3Ez?=
 =?utf-8?B?ajUvS2VPZFE3ZzFhdEUyc2o4TXUvODVjMDhsVC9xeEJGN1U3a21ZWWV4NjRX?=
 =?utf-8?B?Wm5sRHROTDBKeFR2VEVSZHZTc2UxYkVmbyttM3l1UFlTYTY2MjliSWhYUW5B?=
 =?utf-8?B?dTNLSjAvOWgvUHBmUDhQaXEvYnFCSHR5U3M2YzBkOXdUYmNEaDVxbFk3R1d2?=
 =?utf-8?B?Ym41RXpxYlp2M0FkVS9ia2UwZXZPTmxoSWFwNDFhZEMwakt4Z0hyUXdDN1Rk?=
 =?utf-8?B?a0xOVGMvVnUyQjkzclA5Z090VWdoYm5lNUdHWHBqdlNtNTc3dnQyS1RGbFJK?=
 =?utf-8?B?ZE1pbThtb0wzZFJuQXVOQ3Yza1ZqdXVNZVRVb0hEQ0VkWEV3VkpMMG9CbnN0?=
 =?utf-8?B?dm1aMHIydW1PZXB0RzNlZVVLRi9UclFGMmRKQlY3enY3VHplaktsT3hNQzRP?=
 =?utf-8?B?Um1VbENORnpoN3RSYk0zZWthYkd6akJIZ3lGT1lNM2N3NHJtck9kWFV6SW1z?=
 =?utf-8?B?bTVkNXowVndPM2pydENvYy8wajFQQ2ExYWtwblhFL2FDWFNZbmhPV2FmQ2t1?=
 =?utf-8?B?eHlrbFEzZmI2WjdVbmdtMmdkVWNtMGNMbFBDREl1bWhmOE84NllybUNIbHVt?=
 =?utf-8?B?UmgzZTgzTXZxVHp6SE5nMlVTYXFyYURNdFJRZTFmZUdKdUFTdTVKcUhmMmV6?=
 =?utf-8?B?eWRKM2JvV1VLaUNhQ2w3czJQN005ZlhuVmNDYXVsTU03ZGlXTjRMYWJ6aStO?=
 =?utf-8?B?SXJGNnQyTG1BeDRMR3ZoL0VjRjBCRzdHWDlWazcrUVhxZFloN3orQ1A1Vmtp?=
 =?utf-8?B?ZHEycHFkU21hVUdYUXZaU0xjS0pNNU96SlA0ajM4OTRBM0J2Z2NkQkdxbVE0?=
 =?utf-8?B?c0oyTWFrR21JY0pnL3FvTTZCU3VMR2ZCa0c1aTlQbjdMZWVwZHd4dFF5YzBC?=
 =?utf-8?B?ZzdSZllBSFNVQU5Vc1lJNHo1bXljNDdaT0lmNjNETERFWXcvKzhHeVdHUTIr?=
 =?utf-8?B?TUVmdlEyaCtjUzkvanJ3aUJ4akVzR0VYMXFwSVFvcmNuVExGY0dSNUU4dmli?=
 =?utf-8?B?QjNtYkNwdVlXSC91dDByVXlzUnBVNm1QdXZXS2lVTUhVQktheDlNUlA0ZUFY?=
 =?utf-8?B?dzVaTkpUV2Q1bUQyMm1jTnpaQnAxc2JOTnZCREdNZmxTSGhGZFhaSVF4OCtC?=
 =?utf-8?B?dGllZVMxK2JNeWQxQ3pHUFpUV1E5a2FtUXV1Znc5NmVuQVhWNmJOZnFJSU1w?=
 =?utf-8?B?U0NsMjluLzltdlk2TWQwcHF6OEpTTEJTanFOemJncXlDVlZXaDE1UWQwY3Nu?=
 =?utf-8?B?N0tNandaMVFnV05Jb0dzck1iSzNrY1Y1SU1MenVKRHR3Yk4xNjFZc2pOMmlB?=
 =?utf-8?B?TmNqTEtQT0dzWDZkMW4yYTh5VUdWMTZDZEd3bG5FOFl2ckFtZXJlNnh5MmZi?=
 =?utf-8?B?RnNaT3M1NnZoR1FIZ0FXRWkxSXdOQXgyUkF1RlhuSmovQnByaDZ6dmRRUTk2?=
 =?utf-8?B?ODB3VmlYMVFxVDJLbDFlSzhUV3RqaCtUNEJTcFNhSzVSOFB3VmM1MUJ4QU1W?=
 =?utf-8?B?WDBYdHVFWGh4N0poaUxUTi82RjdXaXVXbkZaR0pFNVZJVTVKYWtiSG15S3dC?=
 =?utf-8?B?ejh6KzhETUNOOVFra1lMUDQxWnkrUnJoSVVHTnZDNnZqNGd1eUFxdUg4ak1H?=
 =?utf-8?B?SU9OL21vdEV4ZWRDS0Q4STFnT1FBSlMwMEtyMHhqVk5pVWdMeWV0dnZ0QVdk?=
 =?utf-8?B?NlI1ckxvRWRHQUF6bzl4SEVhSWJMS2lxZkt3ZUsyanNGRnlrL0V3a09hUzVP?=
 =?utf-8?B?L0Fid1JhZ2lHYnV5UCt1MFhpd0pHWU9xZmpuSW5KRC9KdEJ2MFIwOXZDVkkz?=
 =?utf-8?B?emtGOHB5Y1FwNGJTQUkwOXRQUUZ6N3Ardkw2N2pyMHh5SXZSYStTZUV0ZFRy?=
 =?utf-8?B?dmJES3dLUEFUOWRuNHU3N1FDVGtaZG03OGEvMkZMSzlYOXIvZ1RZUDUzbGxa?=
 =?utf-8?Q?q4EpaLTlRp7EKc30=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3968f078-637c-47dd-3773-08de693d2eb3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 07:14:23.4389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UWMw3OSw+BDIHSHhA0PMs6tmXU/d5nJgbsVETwNUO4wWJPYwP6sp5ASmBI/ctrTjjw09dWmOPwvbEfxdKD0C0eKYttRx/4P3s2eaRXysJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7192
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:53:33 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On 3/2/2026 10:57 pm, Tom Rini wrote:
> On Tue, Feb 03, 2026 at 03:47:17PM +0800,dinesh.maniyam@altera.com wrote:
>
>> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>>
>> The SPL NAND MTD framework requires working driver model support
>> and sufficient memory resources, which are not available on all
>> platforms.
>>
>> Introduce a SPL_NAND_FRAMEWORK_CAPABLE Kconfig option to allow
>> platforms to explicitly advertise support for compiling the full
>> NAND/MTD framework into SPL.
>>
>> This avoids accidental enablement of the SPL NAND framework on
>> platforms that cannot support it and provides a clear capability
>> boundary for platform maintainers.
>>
>> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
>> ---
>>   drivers/mtd/nand/raw/Kconfig | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index e0ff28cb21b..d73d8ed4404 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -809,6 +809,36 @@ config SYS_NAND_HW_ECC_OOBFIRST
>>   	bool "In SPL, read the OOB first and then the data from NAND"
>>   	depends on SPL_NAND_SIMPLE
>>   
>> +config SPL_NAND_FRAMEWORK_CAPABLE
>> +	bool
>> +	depends on SPL_DM
>> +	depends on SPL_HAS_BSS_LINKER_SECTION
>> +	depends on SPL_MAX_SIZE >= 0x40000
>> +	help
>> +	  Indicates that the platform has sufficient SPL capabilities
>> +	  (driver model, BSS support, and SRAM size) to support the
>> +	  full NAND/MTD framework in SPL.
>> +
>> +config SPL_NAND_USE_NAND_FRAMEWORK
>> +	bool "Use NAND/MTD framework in SPL"
>> +	depends on SPL_NAND_SUPPORT && MTD
>> +	depends on SPL_NAND_FRAMEWORK_CAPABLE
>> +	depends on SPL_ENV_SUPPORT
>> +	depends on ENV_IS_IN_NAND
>> +	select SPL_SYS_NAND_SELF_INIT
>> +	select SPL_NAND_BASE
>> +	select SPL_NAND_DRIVERS
>> +	select SPL_NAND_IDENT
>> +	select SPL_NAND_INIT
>> +	select SPL_NAND_ECC
>> +	help
>> +		Enable loading U-Boot from NAND in SPL using the full
>> +		NAND/MTD framework instead of the minimal SPL NAND loaders.
>> +		This provides bad-block aware reads and flexible offset
>> +		handling via the common NAND/MTD infrastructure.
>> +		Platforms enabling this option must also provide working
>> +		driver model support and sufficient SPL memory resources.
>> +
>>   endif	# if SPL
>>   
>>   endif	# if MTD_RAW_NAND
> This still gets it backwards. Whatever depends on SPL_DM needs to add
> it. The max size is something that needs to be set for your platforms.
> The BSS requirement is not correct (there are platforms today without
> that set).
>
> Thanks for the input.
>
> Understood — the capability-style symbol is not the right approach
> here. I’ll drop |SPL_NAND_FRAMEWORK_CAPABLE| and instead move the
> required dependencies directly onto |SPL_NAND_USE_NAND_FRAMEWORK|.
>
> I’ll also remove the |SPL_MAX_SIZE| and BSS assumptions from the
> generic Kconfig and ensure the appropriate limits and options are set
> in the affected platform configurations instead.
>
> I’ll rework the patch accordingly.
>
> Dinesh
