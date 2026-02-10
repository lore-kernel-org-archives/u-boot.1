Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1964E94626
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 02:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1948366F;
	Tue, 10 Feb 2026 03:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mPxxQbKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD448388D; Tue, 10 Feb 2026 03:22:34 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F545805D7
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 03:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRdtXrRHKJ1G/sErAumJ+5R8kWl75mN1QSA5iXOp7rtFQcxJiNfxJxy3Vsaqypau7bUtBIxhClD2M5YEYOYFuOuY2rFN42Mr6hOlT0BFUyjKYCmwGdJpxkLbhsZ6xHrGl/aQ2dv96HOJNGT4tl8aXjzvHKbJNVKl5lqZXVcQSbSwttCMOGnhY1mhs2ps4zPdB2tilK7uC3ekOOBtiXZxDYR3UFjNe+huR8FjdPKb5muIP5Ju6/tdYESBnIprgZ69WgKe4BIeoTnOvgcugEZ4Z7bBhSrBma4vqF+yJ3UtWqHEV16cj7m72W/jTet0pwUvhUgjZaStRBI0PZA3EytW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDvgoJtr+YZEnvlcsFqKEOkYI4OUgNYGH1qACo1jbaw=;
 b=fkMGgXUN9y7Z/Uua4m9qAR46RO+0j+k4oPo7cu8MUqo5ahngFvBhfxhMTNrnI9XzSCcKUgQj0vk1EJEUD8h/EyH/lMAiG6I7+pGkDRAMjWlGmrRkQSxOb0hyJaKCAr73HLXK3Lzzruik0XxOlgAbZjC2y96yVwNiwq518eMnLkIAyubw7yJ6Ko7qkIe1SmMcKmDg+Ow+QYXfoVf9GP++54YSL614qIlqq6uXOZQJiXZte2IZSK2FWfRmzdVsqOwPQ69VmSXCxGmVZlBC72PC/4AGFPxnQH3UJcQHPDUTiFKDDVHQld6+38NCIAx1Ou9DNPCRwu5Bd42d1lacLJil5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDvgoJtr+YZEnvlcsFqKEOkYI4OUgNYGH1qACo1jbaw=;
 b=mPxxQbKLcaizQ+GRwQDvMxfN3Dt6goO2WcJvbJ4GMUFvAsGbecCWhP8qlBcai7zQrfCwuqmmR3bQykhAbyZ7eWfkU/EG3/OkvtRAmOGWdG2tyYiRkkRaykvaS+Vu9a9F9tHr5PtSBUrsUUuKVMDDY/JRWc65mS7YqecU6iBgXMUHo09YsK1OkoaYmKI0iOnx3OJHCJGngTC4Z47BDmeEEDI/lZDSbIjXrea8SPwT2ZKsFFzAtil6ZPk6GRafW3tEbSrv++PiY+9FHhQ5NsaP8ark503kt8SAIxq+O0ZxgpeOhBNt8G0vjlHRX+AtMBREg5fSTVO43bvlcKhdd5vqNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB5375.namprd03.prod.outlook.com (2603:10b6:208:1ee::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 02:22:24 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 02:22:24 +0000
Message-ID: <f34c3ceb-daf8-4283-8a58-e7fdf7d4ea90@altera.com>
Date: Tue, 10 Feb 2026 10:22:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Replace TARGET namespace and cleanup properly
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
References: <20251223123910.4639-1-briansune@gmail.com>
Content-Language: en-US
Cc: chen.huei.lok@altera.com
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251223123910.4639-1-briansune@gmail.com>
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN2PR03MB5375:EE_
X-MS-Office365-Filtering-Correlation-Id: 4249af10-e2db-4d38-bfe7-08de684b396f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bW1tZS93VkVzRndpbGkzTzRVcVNHdDJRZ0N4N2hEVWxrYk40SDNTRlZBVE5R?=
 =?utf-8?B?TVRUS1ZvMzBTa3pDUWhaT0FVWlU3UnZ2UzBydUFlU1B2Y2hCRUdyZlZaZ2g1?=
 =?utf-8?B?VnFzb29iVU82aXhUODl4VHN1SlFvdENobEFLSm84TEw4WGhVMkFHWEhZTm5r?=
 =?utf-8?B?REZQZ2dud1d1cThUSFA2UTg2YlpXcDN0NzEzbmdiK3daeWJGVHhCa01wUnU3?=
 =?utf-8?B?WGNnaHJ6WTdBODZBTkE4ZStlRUFIdWNYZDdKKzVHTlJSSEFIczhpa2JicVky?=
 =?utf-8?B?ck5ibnZDU1FOUDdPVE9hRDR2ck04WnYvcWk3ZDcyVUgwV3B3bkNUY1I5RU5K?=
 =?utf-8?B?Q0R0ZWRVc0RmRjUwdkVGZitNcVpPWDFUekhsNGhTcmdZeXdUM1o2bldEcVBW?=
 =?utf-8?B?YWI5SmZJb2N6TlYycHAwRzJVN0V6blhldDNaczBFaVdxNnRoM3NnRS9yWk9j?=
 =?utf-8?B?U1I0RmNkR1JjRTE2Mlh5ZGdNRk5KQnNDVWZ5cFhHTzNBV3RBeVBxYWo2aVNF?=
 =?utf-8?B?QXVscUI4SW55cDF6TjlONEl5a1JuUFRzR0NMWExrS0ZhaGlER25lNGQ2WGNT?=
 =?utf-8?B?QTBPMDBPNkExb3B4L2lJc2lJRlhhcWYwMmROZlI1TFNKWjRKb1VjclBXc3Zx?=
 =?utf-8?B?bTFCVXRDWWhSek4zTVQ0aWdkbDYxK0xhVk5LaVFna1JKM0g1ejRDSzY3NXdl?=
 =?utf-8?B?a0tadEg5bHdDVDdXOUZNd3J6WFVNZDdzeW14RGVodmJ2Q3ZKeGlkVVRIVGZr?=
 =?utf-8?B?TUk0YWdWQWpKOWlTV2VlZURrY3hsNWFyUG5XdDdGUDFFbE1XdThGTkFOcThV?=
 =?utf-8?B?TjF0NFFoak5hOC8wVTdHNWtSQU10bHZzNHNiRTc5V1YrbDdsWU5sRTdZOVRB?=
 =?utf-8?B?aWVudVlqMGNRQjI1WVREVzlIVm9keEoyemZta3E0N2tPbit1RW9KaGJtM1dK?=
 =?utf-8?B?UE8yMUV0VDBSck00RFArOG1mSkRuZklrUjJqcXNYQ1RzbmFVVjlhZTRMWTlp?=
 =?utf-8?B?TG5kd2ZYSG9DcmFTeFU1azZBS3RYMTJsWVRDSDZ6Q2h6ZzA3aEowcVZQUkw1?=
 =?utf-8?B?MWVOOWdBWXZFdk1aaHB0VDI0cE5iT1hvaTVhRlJRdlg4Y09aQVFZcnJ2elZz?=
 =?utf-8?B?bXIyRUU0VHlxT3RGTHkwZGM4eTlaSVdZMTQ2cEZRbHZwN1VOUzBZSVBRSEYw?=
 =?utf-8?B?OTdkN0F1SklwNnM5MFFURkdJeDZYZDZDMFcrNEFXbUllNnFpRHZoSndoTk0w?=
 =?utf-8?B?UjBhNm5ZNFFXQzVibi9zWTY0RlJncE1PRC8zUmZMYk9rdmZpNytTUzBBcUtI?=
 =?utf-8?B?cjhyK1dxaTZvYmlEU0JvQWp6U1NpZ2V2YkhQMUtMMmUzODFmUlBmSWlBZDNj?=
 =?utf-8?B?bjNhd3ZKQlRtWmJoek5yenZyRmRxT09rbnlhZThqZHpIRkp6ZTRlSUgvRUlh?=
 =?utf-8?B?OFNJSVRaeEVTZFkwUnlOaHZ3Skx4ZHBxcXRpN3JTYWQyalJVRWhiNW91THda?=
 =?utf-8?B?QzVzalg5enZzZzNBanl0K1dGL3p1SWo4UGN5bDN6RXBoTnE4dlp2MC8zR25Z?=
 =?utf-8?B?eThPdzdqa1hRT29paVhxMlpjM3BrWXJjTWhsTmhkdlZwdWhtMVJGMTNCUG5Q?=
 =?utf-8?B?M0k4ZFJOZDZBb2Juc2pqc2xtRDBidXR5eGp4SVo1UkYwYlNodTIrazVjNHly?=
 =?utf-8?B?ai9NV29wOVdJcGtDQmlNcXVuRmZ4eUFESVYzcDBlOWZGQmFsb3BpUVJ1VjJS?=
 =?utf-8?B?cGh6ZTVlMVpaRituVmdKZjA1Z2s3YnZEV01mOFR3akRDbHUrenp4bW9VL1Zl?=
 =?utf-8?B?UFVYekxBajJwbk9hMHh0c0FCcFFLaGJxV1FjUzUxd1BzRWdaaCtxN09hQS8y?=
 =?utf-8?B?YnExWEd3aHphMC9rR2FGMDZoQ05USXhpL0MzWUwwbEtFM0lWV2Q5WUtUUlJV?=
 =?utf-8?B?ZllyZGc0dE5vdTQ2LzhhV0ZUN1E3ZWxxNFpEbE5yK0JkRFVNL3NVWlpFdGs2?=
 =?utf-8?B?TVpkZ1VwdnhtRGVDOXVoc1o1MFVFNjdwTk1JWVRtcWk3WjlNRUt6eXdMa2Jj?=
 =?utf-8?Q?vwJQlE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE9JaGY2dFBkTCtjZjkwQmRDQlFtK0NJUzkzK3I3Z09wTjJUSnkvaEpvblMz?=
 =?utf-8?B?SW9CVzMwK1Y1dWZ4WmxFRUhxcVlVL1h5cEY3UWQ4MVNXcmpNYjFSVTZteGdm?=
 =?utf-8?B?d1NPVUxpeGhybjh4UmFyS1pzd1FjOEk0b2VDUjlORTZwNHJiMXlmRy8yM1dK?=
 =?utf-8?B?UTZ0bVowTHJpd1BCeU1hUW5RS1RwV2UzSW81dzRteTBja2N6Um1vc1JRZEpW?=
 =?utf-8?B?ODFWSXZRR3JFSEl1WmJiMWM4N1o3RmRtMnhaUnJUMHdMQUdlNmVYa0IzbjQx?=
 =?utf-8?B?dnBESHpSbm1QY1NYUEFHRWc5cEVGdTdSYjFzM0xXM0o4N3lzM1hJNC96eFV3?=
 =?utf-8?B?Y2dDZ21sMGVmQ2tOc3dBa01Jck5INWZpLzIrckJsUG1XYXlWclZyUEhnVHR4?=
 =?utf-8?B?eG5pOTBoOUJqZk1qamcya1Z2WFl0Ty9OeTJGTnhOcEpHSjhma01FUDVrUDdz?=
 =?utf-8?B?Z0N1SWxCd2hqS0d6UVdiN1I3RU4rVm1lejlmdlVCWVpqL1JadnhzN041UUxS?=
 =?utf-8?B?eU5PajJjQ3pxSFppSVFMV1EzQTdPc3FVM1hTRlR0MmFTYzlDM09ET3NJMnNx?=
 =?utf-8?B?Q2pHLy9KSGp5VnYvaXhmUUduMXk0WVVNdEpRMmVOU05SeXRlM3I5R2RHNHhx?=
 =?utf-8?B?UjR5Y3ZkR3FNUXNkd3lmQWJ0eXE0UjVIdDRKZ1V6dGI4eU85UWhWaGJ6TWll?=
 =?utf-8?B?dXBMaXJ1WmZON3NYUVQ5WThUOTh1OVJteU9vd1loczdMU0ZXSXJrTnRyYzU2?=
 =?utf-8?B?QVZXaDhDRmNmT2pSdkxNV3UrOEM0Qmp0UHk0aEVTL3JCQU5CMlF2djFBZ1Fm?=
 =?utf-8?B?b1lQSDB0c09EamI5MXlvdnFzUGE2QWlxL1hyQWx0RWVMNVVacDNKTmpXMWJw?=
 =?utf-8?B?Tmd3Zml1cms2ZjlvaTMxSG5ZVTQ5MnE3UXBSb1E4QUVaYXBZeTZRQWIzcEUv?=
 =?utf-8?B?TDJiaTlyNklsdHRDQWtiQmRjWFV6SE5EdzhwSG95NVdnQmZVcnV3WDM3dlRo?=
 =?utf-8?B?b1RqbWV0OFNCd0ZpMXBFdWU0ZVNHdTlpeitHZjlPN2JvTXh5bC9hMGwvRXpx?=
 =?utf-8?B?QjczYUhUUHd6VTA3YlFGYkd5bFBlNGJ1U3NVc0ppYVQ5RU5kODBjTkFrbjVT?=
 =?utf-8?B?b0tjTm84cy90a1RUT0liVUROazArOHZKNWhpWnZvb010cms0UmJQUlZhcEx6?=
 =?utf-8?B?Sy9jM2t0TG1YLzNha2xzdTM1VjhsdHN2cml6ZG0wVE1xc3JyYWIrdHhYeCtl?=
 =?utf-8?B?NUJGMk9LNC9jalJIQy9VNW90MUJIaXRUTVR4eW16YXpKam16OEovckZJcDUz?=
 =?utf-8?B?RXovZDI3cDgyTHVqb2xwYkhNOUZ4L29TNTE0UGp4VzFGVmJxNXpPTmowV05z?=
 =?utf-8?B?MDJ5OE56Q1R4eUI1RHhyRHBtQ2NCVm9YeXB3T2dLNjhYNXJLc2FxVEQ1Mkxy?=
 =?utf-8?B?SU04Q1JmMjJVQStyeUhoMWg2cm5XK3pRTjRSREw2N29SQ1I2a2hQVllqWGRD?=
 =?utf-8?B?eENFMFhmcDgrOUVlKzlRL2U3Q0VHVlhna2JWc3NWVEZXZ2ZkZ3U5Yi80TXBF?=
 =?utf-8?B?cmxhVVVia0EwUHQ1eGRocHVIczU1Z2pxMjA0b3cwUS92M2lWa3BUSFJRQmxQ?=
 =?utf-8?B?b2x1eWZ6WlFXd0hhR0FVcDllSUdGZjZWVlZnbExnU1QyTTlGTnE1Y3RxMU9M?=
 =?utf-8?B?MjdYV1g0dlg3UlljVjJPVGdERXBPTENWTzBXdVU1WXNranYzNWRQWjkwK3Vq?=
 =?utf-8?B?MEFjNGM5S1h5bERLYzZTL1o4T0w1QnByODVheWRucnV4cXVPNURDdzdTNUJq?=
 =?utf-8?B?ZkhmOUs3a0ZTdVJCUlhRV1NadGc1ZW1iUms0d0FIdGhHQ3IxaDFMOENScTN0?=
 =?utf-8?B?Q0s5cEZ5Y0dvL1JjNHhXaE1Fc1Z6dG9zOXlncG1DZFNKWFJNd2ZUV1lJQ1RQ?=
 =?utf-8?B?REZHZ3RPbzRjbWtlU2FMdlZySG43QS9HMHcxdXpJdmtZYlV3SXNzNVlmbjRZ?=
 =?utf-8?B?OXMwT3FYanNsc3c0eUlCVXFJREtPTXNIL2JrLytDY0pYZXkrMjlpTlBHbURm?=
 =?utf-8?B?TzVsYVBtd1J2QWcvN3FNYVFWbWN6Ykl5RjhRZEh1ZDB3ZGRNTjA0WmZuSXdR?=
 =?utf-8?B?OGdyT2g4bldnR1NtL08vcXIwZVE5dG1pYTFTK2RFZEF6OHRDYWd5WlZkM05B?=
 =?utf-8?B?WjRCWHVjejVSN0xXaW5rOExxQkcyMWR1cDZrSHRYbmhuM3FWdUc3VzJHZ3lx?=
 =?utf-8?B?WVZDY1A0cnd6Y1VMbDdvWDZoT1V2aGM0VFF4KzFIQk83U0xpQnlCL1k0TDh4?=
 =?utf-8?B?NmVRR1o3MEhNNC95QTVSQklka1RCQys4T2VyeGZkTWZsVHczbTV4STR4T2Ra?=
 =?utf-8?Q?ioTjweGJ3mVr5lcA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4249af10-e2db-4d38-bfe7-08de684b396f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 02:22:24.3765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bht3RFJT4oHIRVPFdRVNpMCNVVhZLpJ0vufDE5Gz5EorvGvSWvhApo2KeKF0PeEy54VjLeJzp7m39y7NHxQReL0HEptwF10dlMKWUxWVCm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5375
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 23/12/2025 8:39 pm, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> TARGET namespace is for machines / boards / what-have-you that
> building U-Boot for. Simply replace from TARGET to ARCH
> make things more clear and proper for ALL SoCFPGA.
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   Kconfig                                       |   4 +-
>   arch/arm/Kconfig                              |  30 +++---
>   arch/arm/dts/socfpga_agilex-u-boot.dtsi       |   2 +-
>   arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |   4 +-
>   arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |   6 +-
>   arch/arm/mach-socfpga/Kconfig                 | 102 +++++++++---------
>   arch/arm/mach-socfpga/Makefile                |  32 +++---
>   arch/arm/mach-socfpga/board.c                 |   6 +-
>   arch/arm/mach-socfpga/clock_manager.c         |   8 +-
>   arch/arm/mach-socfpga/config.mk               |   4 +-
>   .../include/mach/base_addr_soc64.h            |  10 +-
>   .../mach-socfpga/include/mach/clock_manager.h |  14 +--
>   arch/arm/mach-socfpga/include/mach/firewall.h |   2 +-
>   .../mach-socfpga/include/mach/fpga_manager.h  |   4 +-
>   .../mach-socfpga/include/mach/handoff_soc64.h |  24 ++---
>   arch/arm/mach-socfpga/include/mach/misc.h     |  10 +-
>   .../mach-socfpga/include/mach/reset_manager.h |   6 +-
>   .../include/mach/reset_manager_soc64.h        |   2 +-
>   arch/arm/mach-socfpga/include/mach/sdram.h    |   4 +-
>   .../include/mach/system_manager.h             |   6 +-
>   .../include/mach/system_manager_soc64.h       |   8 +-
>   arch/arm/mach-socfpga/misc.c                  |  18 ++--
>   arch/arm/mach-socfpga/misc_soc64.c            |   2 +-
>   arch/arm/mach-socfpga/mmu-arm64_s10.c         |   2 +-
>   arch/arm/mach-socfpga/reset_manager_s10.c     |   2 +-
>   arch/arm/mach-socfpga/system_manager_soc64.c  |   4 +-
>   arch/arm/mach-socfpga/wrap_handoff_soc64.c    |   4 +-
>   common/Kconfig                                |   2 +-
>   common/spl/Kconfig                            |   4 +-
>   drivers/clk/altera/Makefile                   |  12 +--
>   drivers/ddr/altera/Kconfig                    |   6 +-
>   drivers/ddr/altera/Makefile                   |  14 +--
>   drivers/ddr/altera/sdram_soc64.c              |  14 +--
>   drivers/ddr/altera/sdram_soc64.h              |   4 +-
>   drivers/fpga/Kconfig                          |   2 +-
>   drivers/fpga/Makefile                         |   4 +-
>   drivers/fpga/altera.c                         |   8 +-
>   drivers/mmc/socfpga_dw_mmc.c                  |   8 +-
>   drivers/mtd/nand/raw/Kconfig                  |   2 +-
>   drivers/net/Kconfig                           |   2 +-
>   drivers/power/domain/Kconfig                  |   2 +-
>   drivers/reset/reset-socfpga.c                 |   2 +-
>   drivers/sysreset/Kconfig                      |   4 +-
>   env/Kconfig                                   |   2 +-
>   include/configs/socfpga_common.h              |   4 +-
>   include/configs/socfpga_soc64_common.h        |  10 +-
>   scripts/Makefile.xpl                          |   6 +-
>   47 files changed, 216 insertions(+), 216 deletions(-)
>
> diff --git a/Kconfig b/Kconfig
> index 1d600342685..8c6952cdf47 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -524,8 +524,8 @@ config BUILD_TARGET
>          default "u-boot-with-spl.bin" if MPC85xx && !E500MC && !E5500 && !E6500 && SPL
>          default "u-boot-with-spl.imx" if ARCH_MX6 && SPL
>          default "u-boot-with-spl.kwb" if ARMADA_32BIT && SPL
> -       default "u-boot-with-spl.sfp" if TARGET_SOCFPGA_ARRIA10
> -       default "u-boot-with-spl.sfp" if TARGET_SOCFPGA_GEN5
> +       default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_ARRIA10
> +       default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_GEN5
>          default "u-boot.itb" if !BINMAN && SPL_LOAD_FIT && (ARCH_ROCKCHIP || \
>                                  RISCV || ARCH_ZYNQMP)
>          default "u-boot.kwb" if (ARCH_KIRKWOOD || ARMADA_32BIT) && !SPL
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3db5474a05b..fabd853b36f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -30,7 +30,7 @@ config COUNTER_FREQUENCY
>                          ROCKCHIP_RK3288 || ROCKCHIP_RK322X || ROCKCHIP_RK3036
>          default 25000000 if ARCH_LX2160A || ARCH_LX2162A || ARCH_LS1088A
>          default 100000000 if ARCH_ZYNQMP
> -       default 200000000 if TARGET_SOCFPGA_AGILEX5 || TARGET_SOCFPGA_AGILEX7M
> +       default 200000000 if ARCH_SOCFPGA_AGILEX5 || ARCH_SOCFPGA_AGILEX7M
>          default 0
>          help
>            For platforms with ARMv8-A and ARMv7-A which features a system
> @@ -1150,35 +1150,35 @@ config ARCH_SNAPDRAGON
>   config ARCH_SOCFPGA
>          bool "Altera SOCFPGA family"
>          select ARCH_EARLY_INIT_R
> -       select ARCH_MISC_INIT if !TARGET_SOCFPGA_ARRIA10
> -       select ARM64 if TARGET_SOCFPGA_SOC64
> -       select CPU_V7A if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
> +       select ARCH_MISC_INIT if !ARCH_SOCFPGA_ARRIA10
> +       select ARM64 if ARCH_SOCFPGA_SOC64
> +       select CPU_V7A if ARCH_SOCFPGA_GEN5 || ARCH_SOCFPGA_ARRIA10
>          select DM
>          select DM_SERIAL
>          select GPIO_EXTRA_HEADER
> -       select ENABLE_ARM_SOC_BOOT0_HOOK if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
> -       select LMB_ARCH_MEM_MAP if TARGET_SOCFPGA_SOC64
> +       select ENABLE_ARM_SOC_BOOT0_HOOK if ARCH_SOCFPGA_GEN5 || ARCH_SOCFPGA_ARRIA10
> +       select LMB_ARCH_MEM_MAP if ARCH_SOCFPGA_SOC64
>          select OF_CONTROL
>          select SPL_DM_RESET if DM_RESET
>          select SPL_DM_SERIAL
>          select SPL_LIBCOMMON_SUPPORT
>          select SPL_LIBGENERIC_SUPPORT
>          select SPL_OF_CONTROL
> -       select SPL_SEPARATE_BSS if TARGET_SOCFPGA_SOC64
> -       select SPL_DRIVERS_MISC if TARGET_SOCFPGA_SOC64
> -       select SPL_SOCFPGA_DT_REG if TARGET_SOCFPGA_SOC64
> +       select SPL_SEPARATE_BSS if ARCH_SOCFPGA_SOC64
> +       select SPL_DRIVERS_MISC if ARCH_SOCFPGA_SOC64
> +       select SPL_SOCFPGA_DT_REG if ARCH_SOCFPGA_SOC64
>          select SPL_SERIAL
>          select SPL_SYSRESET
>          select SPL_WATCHDOG
>          select SUPPORT_SPL
>          select SYS_NS16550
> -       select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
> +       select SYS_THUMB_BUILD if ARCH_SOCFPGA_GEN5 || ARCH_SOCFPGA_ARRIA10
>          select SYSRESET
> -       select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
> -       select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && \
> -           TARGET_SOCFPGA_SOC64
> -       select SYSRESET_PSCI if TARGET_SOCFPGA_AGILEX5
> -       select USE_BOOTFILE if SPL_ATF && TARGET_SOCFPGA_SOC64
> +       select SYSRESET_SOCFPGA if ARCH_SOCFPGA_GEN5 || ARCH_SOCFPGA_ARRIA10
> +       select SYSRESET_SOCFPGA_SOC64 if !ARCH_SOCFPGA_AGILEX5 && \
> +           ARCH_SOCFPGA_SOC64
> +       select SYSRESET_PSCI if ARCH_SOCFPGA_AGILEX5
> +       select USE_BOOTFILE if SPL_ATF && ARCH_SOCFPGA_SOC64
>          imply CMD_DM
>          imply CMD_MTDPARTS
>          imply CRC32_VERIFY
> diff --git a/arch/arm/dts/socfpga_agilex-u-boot.dtsi b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
> index 770f6cad292..c0f932d0e11 100644
> --- a/arch/arm/dts/socfpga_agilex-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
> @@ -264,7 +264,7 @@
>   };
>   #endif
>
> -#ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
> +#ifdef CONFIG_ARCH_SOCFPGA_AGILEX7M
>   &sdr {
>          compatible = "intel,sdr-ctl-agilex7m";
>          reg = <0xf8020000 0x100>;
> diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> index 6f2fe7bf746..df864d53630 100644
> --- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> @@ -8,7 +8,7 @@
>
>   #include "socfpga_agilex-u-boot.dtsi"
>
> -#ifdef CONFIG_TARGET_SOCFPGA_AGILEX
> +#ifdef CONFIG_ARCH_SOCFPGA_AGILEX
>   /{
>          chosen {
>                  stdout-path = "serial0:115200n8";
> @@ -27,7 +27,7 @@
>   };
>   #endif
>
> -#ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
> +#ifdef CONFIG_ARCH_SOCFPGA_AGILEX7M
>   /{
>          model = "SoCFPGA Agilex7-M SoCDK";
>          chosen {
> diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> index 93a8e0697d6..88f0154463d 100644
> --- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> @@ -28,7 +28,7 @@
>                                          os = "U-Boot";
>                                          arch = "arm64";
>                                          compression = "none";
> -                               #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +                               #if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>                                          load = <0x80200000>;
>                                  #else
>                                          load = <0x00200000>;
> @@ -47,7 +47,7 @@
>                                          os = "arm-trusted-firmware";
>                                          arch = "arm64";
>                                          compression = "none";
> -                               #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +                               #if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>                                          load = <0x80000000>;
>                                          entry = <0x80000000>;
>                                  #else
> @@ -106,7 +106,7 @@
>                                          arch = "arm64";
>                                          os = "linux";
>                                          compression = "none";
> -                               #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +                               #if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>                                          load = <0x86000000>;
>                                          entry = <0x86000000>;
>                                  #else
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index f2e959b5662..f6adf93b32e 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -1,15 +1,15 @@
>   if ARCH_SOCFPGA
>
>   config ERR_PTR_OFFSET
> -       default 0xfffec000 if TARGET_SOCFPGA_GEN5 # Boot ROM range
> +       default 0xfffec000 if ARCH_SOCFPGA_GEN5 # Boot ROM range
>
>   config NR_DRAM_BANKS
>          default 1
>
>   config SOCFPGA_SECURE_VAB_AUTH
>          bool "Enable boot image authentication with Secure Device Manager"
> -       depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X || \
> -         TARGET_SOCFPGA_AGILEX5
> +       depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
> +         ARCH_SOCFPGA_AGILEX5
>          select FIT_IMAGE_POST_PROCESS
>          select SHA384
>          select SHA512
> @@ -23,32 +23,32 @@ config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
>          depends on SOCFPGA_SECURE_VAB_AUTH
>
>   config SPL_SIZE_LIMIT
> -       default 0x10000 if TARGET_SOCFPGA_GEN5
> +       default 0x10000 if ARCH_SOCFPGA_GEN5
>
>   config SPL_SIZE_LIMIT_PROVIDE_STACK
> -       default 0x200 if TARGET_SOCFPGA_GEN5
> +       default 0x200 if ARCH_SOCFPGA_GEN5
>
>   config SPL_STACK_R_ADDR
> -       default 0x00800000 if TARGET_SOCFPGA_GEN5
> +       default 0x00800000 if ARCH_SOCFPGA_GEN5
>
>   config SPL_SYS_MALLOC_F
> -       default y if TARGET_SOCFPGA_GEN5
> +       default y if ARCH_SOCFPGA_GEN5
>
>   config SPL_SYS_MALLOC_F_LEN
> -       default 0x800 if TARGET_SOCFPGA_GEN5
> +       default 0x800 if ARCH_SOCFPGA_GEN5
>
>   config SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE
>          default 0xa2
>
>   config SYS_MALLOC_F_LEN
> -       default 0x2000 if TARGET_SOCFPGA_ARRIA10
> -       default 0x2000 if TARGET_SOCFPGA_GEN5
> +       default 0x2000 if ARCH_SOCFPGA_ARRIA10
> +       default 0x2000 if ARCH_SOCFPGA_GEN5
>
>   config TEXT_BASE
> -       default 0x01000040 if TARGET_SOCFPGA_ARRIA10
> -       default 0x01000040 if TARGET_SOCFPGA_GEN5
> +       default 0x01000040 if ARCH_SOCFPGA_ARRIA10
> +       default 0x01000040 if ARCH_SOCFPGA_GEN5
>
> -config TARGET_SOCFPGA_AGILEX
> +config ARCH_SOCFPGA_AGILEX
>          bool
>          select ARMV8_MULTIENTRY
>          select ARMV8_SET_SMPEN
> @@ -58,9 +58,9 @@ config TARGET_SOCFPGA_AGILEX
>          select GICV2
>          select NCORE_CACHE
>          select SPL_CLK if SPL
> -       select TARGET_SOCFPGA_SOC64
> +       select ARCH_SOCFPGA_SOC64
>
> -config TARGET_SOCFPGA_AGILEX7M
> +config ARCH_SOCFPGA_AGILEX7M
>          bool
>          select ARMV8_MULTIENTRY
>          select ARMV8_SET_SMPEN
> @@ -70,21 +70,21 @@ config TARGET_SOCFPGA_AGILEX7M
>          select GICV2
>          select NCORE_CACHE
>          select SPL_CLK if SPL
> -       select TARGET_SOCFPGA_SOC64
> +       select ARCH_SOCFPGA_SOC64
>
> -config TARGET_SOCFPGA_AGILEX5
> +config ARCH_SOCFPGA_AGILEX5
>          bool
>          select BINMAN if SPL_ATF
>          select CLK
>          select FPGA_INTEL_SDM_MAILBOX
>          select SPL_CLK if SPL
> -       select TARGET_SOCFPGA_SOC64
> +       select ARCH_SOCFPGA_SOC64
>
> -config TARGET_SOCFPGA_ARRIA5
> +config ARCH_SOCFPGA_ARRIA5
>          bool
> -       select TARGET_SOCFPGA_GEN5
> +       select ARCH_SOCFPGA_GEN5
>
> -config TARGET_SOCFPGA_ARRIA10
> +config ARCH_SOCFPGA_ARRIA10
>          bool
>          select GICV2
>          select SPL_ALTERA_SDRAM
> @@ -105,17 +105,17 @@ config TARGET_SOCFPGA_ARRIA10
>
>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>          bool "Always reprogram Arria 10 FPGA"
> -       depends on TARGET_SOCFPGA_ARRIA10
> +       depends on ARCH_SOCFPGA_ARRIA10
>          help
>            Arria 10 FPGA is only programmed during the cold boot.
>            This option forces the FPGA to be reprogrammed every reboot,
>            allowing to change the bitstream and apply it with warm reboot.
>
> -config TARGET_SOCFPGA_CYCLONE5
> +config ARCH_SOCFPGA_CYCLONE5
>          bool
> -       select TARGET_SOCFPGA_GEN5
> +       select ARCH_SOCFPGA_GEN5
>
> -config TARGET_SOCFPGA_GEN5
> +config ARCH_SOCFPGA_GEN5
>          bool
>          select SPL_ALTERA_SDRAM
>          imply FPGA_SOCFPGA
> @@ -125,7 +125,7 @@ config TARGET_SOCFPGA_GEN5
>          imply SPL_SYS_MALLOC_SIMPLE
>          imply SPL_USE_TINY_PRINTF
>
> -config TARGET_SOCFPGA_N5X
> +config ARCH_SOCFPGA_N5X
>          bool
>          select ARMV8_MULTIENTRY
>          select ARMV8_SET_SMPEN
> @@ -135,23 +135,23 @@ config TARGET_SOCFPGA_N5X
>          select NCORE_CACHE
>          select SPL_ALTERA_SDRAM
>          select SPL_CLK if SPL
> -       select TARGET_SOCFPGA_SOC64
> +       select ARCH_SOCFPGA_SOC64
>
>   config TARGET_SOCFPGA_N5X_SOCDK
>          bool "Intel eASIC SoCDK (N5X)"
> -       select TARGET_SOCFPGA_N5X
> +       select ARCH_SOCFPGA_N5X
>
> -config TARGET_SOCFPGA_SOC64
> +config ARCH_SOCFPGA_SOC64
>          bool
>
> -config TARGET_SOCFPGA_STRATIX10
> +config ARCH_SOCFPGA_STRATIX10
>          bool
>          select ARMV8_MULTIENTRY
>          select ARMV8_SET_SMPEN
>          select BINMAN if SPL_ATF
>          select FPGA_INTEL_SDM_MAILBOX
>          select GICV2
> -       select TARGET_SOCFPGA_SOC64
> +       select ARCH_SOCFPGA_SOC64
>
>   choice
>          prompt "Altera SOCFPGA board select"
> @@ -159,85 +159,85 @@ choice
>
>   config TARGET_SOCFPGA_AGILEX_SOCDK
>          bool "Intel SOCFPGA SoCDK (Agilex)"
> -       select TARGET_SOCFPGA_AGILEX
> +       select ARCH_SOCFPGA_AGILEX
>
>   config TARGET_SOCFPGA_AGILEX7M_SOCDK
>          bool "Intel SOCFPGA SoCDK (Agilex7 M-series)"
> -       select TARGET_SOCFPGA_AGILEX7M
> +       select ARCH_SOCFPGA_AGILEX7M
>
>   config TARGET_SOCFPGA_AGILEX5_SOCDK
>          bool "Intel SOCFPGA SoCDK (Agilex5)"
> -       select TARGET_SOCFPGA_AGILEX5
> +       select ARCH_SOCFPGA_AGILEX5
>
>   config TARGET_SOCFPGA_ARIES_MCVEVK
>          bool "Aries MCVEVK (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_ARRIA10_SOCDK
>          bool "Altera SOCFPGA SoCDK (Arria 10)"
> -       select TARGET_SOCFPGA_ARRIA10
> +       select ARCH_SOCFPGA_ARRIA10
>
>   config TARGET_SOCFPGA_ARRIA5_SECU1
>          bool "ABB SECU1 (Arria V)"
> -       select TARGET_SOCFPGA_ARRIA5
> +       select ARCH_SOCFPGA_ARRIA5
>          select VENDOR_KM
>
>   config TARGET_SOCFPGA_ARRIA5_SOCDK
>          bool "Altera SOCFPGA SoCDK (Arria V)"
> -       select TARGET_SOCFPGA_ARRIA5
> +       select ARCH_SOCFPGA_ARRIA5
>
>   config TARGET_SOCFPGA_CHAMELEONV3
>          bool "Google Chameleon v3 (Arria 10)"
> -       select TARGET_SOCFPGA_ARRIA10
> +       select ARCH_SOCFPGA_ARRIA10
>
>   config TARGET_SOCFPGA_CYCLONE5_SOCDK
>          bool "Altera SOCFPGA SoCDK (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_DEVBOARDS_DBM_SOC1
>          bool "Devboards DBM-SoC1 (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_EBV_SOCRATES
>          bool "EBV SoCrates (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_IS1
>          bool "IS1 (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_SOFTING_VINING_FPGA
>          bool "Softing VIN|ING FPGA (Cyclone V)"
>          select BOARD_LATE_INIT
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_SR1500
>          bool "SR1500 (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_STRATIX10_SOCDK
>          bool "Intel SOCFPGA SoCDK (Stratix 10)"
> -       select TARGET_SOCFPGA_STRATIX10
> +       select ARCH_SOCFPGA_STRATIX10
>
>   config TARGET_SOCFPGA_TERASIC_DE0_NANO
>          bool "Terasic DE0-Nano-Atlas (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_TERASIC_DE10_NANO
>          bool "Terasic DE10-Nano (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_TERASIC_DE10_STANDARD
>          bool "Terasic DE10-Standard (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_TERASIC_DE1_SOC
>          bool "Terasic DE1-SoC (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   config TARGET_SOCFPGA_TERASIC_SOCKIT
>          bool "Terasic SoCkit (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
>
>   endchoice
>
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> index 4e85bfb00d4..b6f35ddacc4 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -10,7 +10,7 @@ obj-y += board.o
>   obj-y  += clock_manager.o
>   obj-y  += misc.o
>
> -ifdef CONFIG_TARGET_SOCFPGA_GEN5
> +ifdef CONFIG_ARCH_SOCFPGA_GEN5
>   obj-y  += clock_manager_gen5.o
>   obj-y  += misc_gen5.o
>   obj-y  += reset_manager_gen5.o
> @@ -21,14 +21,14 @@ obj-y       += wrap_pll_config.o
>   obj-y  += fpga_manager.o
>   endif
>
> -ifdef CONFIG_TARGET_SOCFPGA_ARRIA10
> +ifdef CONFIG_ARCH_SOCFPGA_ARRIA10
>   obj-y  += clock_manager_arria10.o
>   obj-y  += misc_arria10.o
>   obj-y  += pinmux_arria10.o
>   obj-y  += reset_manager_arria10.o
>   endif
>
> -ifdef CONFIG_TARGET_SOCFPGA_STRATIX10
> +ifdef CONFIG_ARCH_SOCFPGA_STRATIX10
>   obj-y  += clock_manager_s10.o
>   obj-y  += lowlevel_init_soc64.o
>   obj-y  += mailbox_s10.o
> @@ -41,7 +41,7 @@ obj-y += wrap_handoff_soc64.o
>   obj-y  += wrap_pll_config_soc64.o
>   endif
>
> -ifdef CONFIG_TARGET_SOCFPGA_AGILEX
> +ifdef CONFIG_ARCH_SOCFPGA_AGILEX
>   obj-y  += clock_manager_agilex.o
>   obj-y  += lowlevel_init_soc64.o
>   obj-y  += mailbox_s10.o
> @@ -57,7 +57,7 @@ obj-y += wrap_pll_config_soc64.o
>   obj-y  += altera-sysmgr.o
>   endif
>
> -ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
> +ifdef CONFIG_ARCH_SOCFPGA_AGILEX5
>   obj-y  += clock_manager_agilex5.o
>   obj-y  += mailbox_s10.o
>   obj-y  += misc_soc64.o
> @@ -73,7 +73,7 @@ obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH) += secure_vab.o
>   obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)  += vab.o
>   endif
>
> -ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
> +ifdef CONFIG_ARCH_SOCFPGA_AGILEX7M
>   obj-y  += clock_manager_agilex.o
>   obj-y  += lowlevel_init_soc64.o
>   obj-y  += mailbox_s10.o
> @@ -89,7 +89,7 @@ obj-y += wrap_pll_config_soc64.o
>   obj-y  += altera-sysmgr.o
>   endif
>
> -ifdef CONFIG_TARGET_SOCFPGA_N5X
> +ifdef CONFIG_ARCH_SOCFPGA_N5X
>   obj-y  += clock_manager_n5x.o
>   obj-y  += lowlevel_init_soc64.o
>   obj-y  += mailbox_s10.o
> @@ -105,34 +105,34 @@ obj-y     += wrap_pll_config_soc64.o
>   endif
>
>   ifdef CONFIG_XPL_BUILD
> -ifdef CONFIG_TARGET_SOCFPGA_GEN5
> +ifdef CONFIG_ARCH_SOCFPGA_GEN5
>   obj-y  += spl_gen5.o
>   obj-y  += freeze_controller.o
>   obj-y  += wrap_iocsr_config.o
>   obj-y  += wrap_pinmux_config.o
>   obj-y  += wrap_sdram_config.o
>   endif
> -ifdef CONFIG_TARGET_SOCFPGA_SOC64
> +ifdef CONFIG_ARCH_SOCFPGA_SOC64
>   obj-y  += firewall.o
>   obj-y  += spl_soc64.o
>   endif
> -ifdef CONFIG_TARGET_SOCFPGA_ARRIA10
> +ifdef CONFIG_ARCH_SOCFPGA_ARRIA10
>   obj-y  += spl_a10.o
>   endif
> -ifdef CONFIG_TARGET_SOCFPGA_STRATIX10
> +ifdef CONFIG_ARCH_SOCFPGA_STRATIX10
>   obj-y  += spl_s10.o
>   endif
> -ifdef CONFIG_TARGET_SOCFPGA_AGILEX
> +ifdef CONFIG_ARCH_SOCFPGA_AGILEX
>   obj-y  += spl_agilex.o
>   endif
> -ifdef CONFIG_TARGET_SOCFPGA_N5X
> +ifdef CONFIG_ARCH_SOCFPGA_N5X
>   obj-y  += spl_n5x.o
>   endif
> -ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
> +ifdef CONFIG_ARCH_SOCFPGA_AGILEX5
>   obj-y  += spl_soc64.o
>   obj-y  += spl_agilex5.o
>   endif
> -ifdef CONFIG_TARGET_SOCFPGA_AGILEX7M
> +ifdef CONFIG_ARCH_SOCFPGA_AGILEX7M
>   obj-y  += spl_agilex7m.o
>   endif
>   else
> @@ -140,7 +140,7 @@ obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
>   obj-$(CONFIG_SPL_ATF) += smc_api.o
>   endif
>
> -ifdef CONFIG_TARGET_SOCFPGA_GEN5
> +ifdef CONFIG_ARCH_SOCFPGA_GEN5
>   # QTS-generated config file wrappers
>   CFLAGS_wrap_iocsr_config.o     += -I$(srctree)/board/$(BOARDDIR)
>   CFLAGS_wrap_pinmux_config.o    += -I$(srctree)/board/$(BOARDDIR)
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
> index 28554b7a109..c1f6315898d 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -60,7 +60,7 @@ int board_init(void)
>
>   int dram_init_banksize(void)
>   {
> -#if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #ifndef CONFIG_SPL_BUILD
>          struct spl_handoff *ho;
>
> @@ -71,7 +71,7 @@ int dram_init_banksize(void)
>   #endif
>   #else
>          fdtdec_setup_memory_banksize();
> -#endif /* HANDOFF && CONFIG_TARGET_SOCFPGA_AGILEX5 */
> +#endif /* HANDOFF && CONFIG_ARCH_SOCFPGA_AGILEX5 */
>
>          return 0;
>   }
> @@ -144,7 +144,7 @@ u8 socfpga_get_board_id(void)
>          return board_id;
>   }
>
> -#if IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
> +#if IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_ARCH_SOCFPGA_SOC64)
>   int board_fit_config_name_match(const char *name)
>   {
>          char board_name[10];
> diff --git a/arch/arm/mach-socfpga/clock_manager.c b/arch/arm/mach-socfpga/clock_manager.c
> index 134eaf08e0a..da71f5759db 100644
> --- a/arch/arm/mach-socfpga/clock_manager.c
> +++ b/arch/arm/mach-socfpga/clock_manager.c
> @@ -18,7 +18,7 @@ void cm_wait_for_lock(u32 mask)
>          u32 inter_val;
>          u32 retry = 0;
>          do {
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>                  inter_val = readl(socfpga_get_clkmgr_addr() +
>                                    CLKMGR_INTER) & mask;
>   #else
> @@ -45,7 +45,7 @@ int cm_wait_for_fsm(void)
>
>   int set_cpu_clk_info(void)
>   {
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>          /* Calculate the clock frequencies required for drivers */
>          cm_get_l4_sp_clk_hz();
>          cm_get_mmc_controller_clk_hz();
> @@ -54,7 +54,7 @@ int set_cpu_clk_info(void)
>          gd->bd->bi_arm_freq = cm_get_mpu_clk_hz() / 1000000;
>          gd->bd->bi_dsp_freq = 0;
>
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>          gd->bd->bi_ddr_freq = cm_get_sdram_clk_hz() / 1000000;
>   #else
>          gd->bd->bi_ddr_freq = 0;
> @@ -63,7 +63,7 @@ int set_cpu_clk_info(void)
>          return 0;
>   }
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_SOC64)
>   int cm_set_qspi_controller_clk_hz(u32 clk_hz)
>   {
>          u32 reg;
> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> index 2290118f747..8b104b81f91 100644
> --- a/arch/arm/mach-socfpga/config.mk
> +++ b/arch/arm/mach-socfpga/config.mk
> @@ -2,9 +2,9 @@
>   #
>   # Brian Sune<briansune@gmail.com>
>
> -ifeq ($(CONFIG_TARGET_SOCFPGA_CYCLONE5),y)
> +ifeq ($(CONFIG_ARCH_SOCFPGA_CYCLONE5),y)
>   archprepare: socfpga_g5_handoff_prepare
> -else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA5),y)
> +else ifeq ($(CONFIG_ARCH_SOCFPGA_ARRIA5),y)
>   archprepare: socfpga_g5_handoff_prepare
>   endif
>
> diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> index 074b9691af8..61982c2d508 100644
> --- a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> @@ -7,7 +7,7 @@
>   #ifndef _SOCFPGA_SOC64_BASE_HARDWARE_H_
>   #define _SOCFPGA_SOC64_BASE_HARDWARE_H_
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define SOCFPGA_CCU_ADDRESS                    0x1c000000
>   #define SOCFPGA_F2SDRAM_MGR_ADDRESS            0x18001000
>   #define SOCFPGA_SMMU_ADDRESS                   0x16000000
> @@ -47,9 +47,9 @@
>   #define SOCFPGA_HMC_MMR_IO48_ADDRESS           0xf8010000
>   #define SOCFPGA_SDR_ADDRESS                    0xf8011000
>   #define SOCFPGA_FW_MPFE_SCR_ADDRESS            0xf8020000
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
> -       IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) || \
> -       IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
> +       IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X) || \
> +       IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)
>   #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS         0xf8020200
>   #else
>   #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS         0xf8020100
> @@ -84,6 +84,6 @@
>   #define SOCFPGA_OCRAM_ADDRESS                  0xffe00000
>   #define GICD_BASE                              0xfffc1000
>   #define GICC_BASE                              0xfffc2000
> -#endif /* IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) */
> +#endif /* IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) */
>
>   #endif /* _SOCFPGA_SOC64_BASE_HARDWARE_H_ */
> diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager.h b/arch/arm/mach-socfpga/include/mach/clock_manager.h
> index f0431c081d8..48001dbff21 100644
> --- a/arch/arm/mach-socfpga/include/mach/clock_manager.h
> +++ b/arch/arm/mach-socfpga/include/mach/clock_manager.h
> @@ -17,22 +17,22 @@ void cm_print_clock_quick_summary(void);
>   unsigned long cm_get_mpu_clk_hz(void);
>   unsigned int cm_get_qspi_controller_clk_hz(void);
>
> -#if defined(CONFIG_TARGET_SOCFPGA_SOC64)
> +#if defined(CONFIG_ARCH_SOCFPGA_SOC64)
>   int cm_set_qspi_controller_clk_hz(u32 clk_hz);
>   #endif
>   #endif
>
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>   #include <asm/arch/clock_manager_gen5.h>
> -#elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
> +#elif defined(CONFIG_ARCH_SOCFPGA_ARRIA10)
>   #include <asm/arch/clock_manager_arria10.h>
> -#elif defined(CONFIG_TARGET_SOCFPGA_STRATIX10)
> +#elif defined(CONFIG_ARCH_SOCFPGA_STRATIX10)
>   #include <asm/arch/clock_manager_s10.h>
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)
>   #include <asm/arch/clock_manager_agilex.h>
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #include <asm/arch/clock_manager_agilex5.h>
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
>   #include <asm/arch/clock_manager_n5x.h>
>   #endif
>
> diff --git a/arch/arm/mach-socfpga/include/mach/firewall.h b/arch/arm/mach-socfpga/include/mach/firewall.h
> index 2b436b64816..b47b577ae75 100644
> --- a/arch/arm/mach-socfpga/include/mach/firewall.h
> +++ b/arch/arm/mach-socfpga/include/mach/firewall.h
> @@ -138,7 +138,7 @@ struct socfpga_firwall_l4_sys {
>   #define MPUREGION0_ENABLE                              BIT(0)
>   #define NONMPUREGION0_ENABLE                           BIT(8)
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define FW_MPU_DDR_SCR_WRITEL(data, reg)               \
>          writel(data, SOCFPGA_FW_DDR_CCU_DMI0_ADDRESS + (reg)); \
>          writel(data, SOCFPGA_FW_DDR_CCU_DMI1_ADDRESS + (reg))
> diff --git a/arch/arm/mach-socfpga/include/mach/fpga_manager.h b/arch/arm/mach-socfpga/include/mach/fpga_manager.h
> index 481b66bbd86..fc084823b51 100644
> --- a/arch/arm/mach-socfpga/include/mach/fpga_manager.h
> +++ b/arch/arm/mach-socfpga/include/mach/fpga_manager.h
> @@ -9,9 +9,9 @@
>
>   #include <altera.h>
>
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>   #include <asm/arch/fpga_manager_gen5.h>
> -#elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
> +#elif defined(CONFIG_ARCH_SOCFPGA_ARRIA10)
>   #include <asm/arch/fpga_manager_arria10.h>
>   #endif
>
> diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> index b8f2f73e283..ae5af1f0100 100644
> --- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> @@ -19,7 +19,7 @@
>   #define SOC64_HANDOFF_MAGIC_DELAY      0x444C4159
>   #define SOC64_HANDOFF_MAGIC_CLOCK      0x434C4B53
>   #define SOC64_HANDOFF_MAGIC_SDRAM      0x5344524D
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define SOC64_HANDOFF_MAGIC_PERI       0x50455249
>   #else
>   #define SOC64_HANDOFF_MAGIC_MISC       0x4D495343
> @@ -29,11 +29,11 @@
>   #define SOC64_HANDOFF_OFFSET_DATA      0x10
>   #define SOC64_HANDOFF_SIZE             4096
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10) || \
> -       IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
> -       IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10) || \
> +       IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
> +       IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)
>   #define SOC64_HANDOFF_BASE             0xFFE3F000
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)
>   #define SOC64_HANDOFF_MISC             (SOC64_HANDOFF_BASE + 0x634)
>   /* DDR handoff */
>   #define SOC64_HANDOFF_DDR_BASE (SOC64_HANDOFF_BASE + 0x610)
> @@ -43,9 +43,9 @@
>   #else
>   #define SOC64_HANDOFF_MISC             (SOC64_HANDOFF_BASE + 0x610)
>   #endif
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define SOC64_HANDOFF_BASE             0x0007F000
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
>   #define SOC64_HANDOFF_BASE             0xFFE5F000
>   #define SOC64_HANDOFF_MISC             (SOC64_HANDOFF_BASE + 0x630)
>
> @@ -76,17 +76,17 @@
>   #define SOC64_HANDOFF_FPGA             (SOC64_HANDOFF_BASE + 0x330)
>   #define SOC64_HANDOFF_DELAY            (SOC64_HANDOFF_BASE + 0x3F0)
>   #define SOC64_HANDOFF_CLOCK            (SOC64_HANDOFF_BASE + 0x580)
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define SOC64_HANDOFF_PERI             (SOC64_HANDOFF_BASE + 0x620)
>   #define SOC64_HANDOFF_PERI_LEN         1
>   #define SOC64_HANDOFF_SDRAM            (SOC64_HANDOFF_BASE + 0x634)
>   #define SOC64_HANDOFF_SDRAM_LEN                5
>   #endif
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
>   #define SOC64_HANDOFF_CLOCK_OSC                        (SOC64_HANDOFF_BASE + 0x608)
>   #define SOC64_HANDOFF_CLOCK_FPGA               (SOC64_HANDOFF_BASE + 0x60C)
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define SOC64_HANDOFF_CLOCK_OSC                        (SOC64_HANDOFF_BASE + 0x60c)
>   #define SOC64_HANDOFF_CLOCK_FPGA               (SOC64_HANDOFF_BASE + 0x610)
>   #else
> @@ -96,9 +96,9 @@
>
>   #define SOC64_HANDOFF_MUX_LEN                  96
>   #define SOC64_HANDOFF_IOCTL_LEN                        96
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
>   #define SOC64_HANDOFF_FPGA_LEN                 42
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define SOC64_HANDOFF_FPGA_LEN                 44
>   #else
>   #define SOC64_HANDOFF_FPGA_LEN                 40
> diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
> index 0b80e952131..5a6a76b5ace 100644
> --- a/arch/arm/mach-socfpga/include/mach/misc.h
> +++ b/arch/arm/mach-socfpga/include/mach/misc.h
> @@ -24,7 +24,7 @@ void socfpga_fpga_add(void *fpga_desc);
>   static inline void socfpga_fpga_add(void *fpga_desc) {}
>   #endif
>
> -#ifdef CONFIG_TARGET_SOCFPGA_GEN5
> +#ifdef CONFIG_ARCH_SOCFPGA_GEN5
>   void socfpga_sdram_remap_zero(void);
>   static inline bool socfpga_is_booting_from_fpga(void)
>   {
> @@ -35,14 +35,14 @@ static inline bool socfpga_is_booting_from_fpga(void)
>   }
>   #endif
>
> -#ifdef CONFIG_TARGET_SOCFPGA_ARRIA10
> +#ifdef CONFIG_ARCH_SOCFPGA_ARRIA10
>   void socfpga_init_security_policies(void);
>   void socfpga_sdram_remap_zero(void);
>   #endif
>
> -#if defined(CONFIG_TARGET_SOCFPGA_STRATIX10) || \
> -       defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
> -       defined(CONFIG_TARGET_SOCFPGA_AGILEX7M)
> +#if defined(CONFIG_ARCH_SOCFPGA_STRATIX10) || \
> +       defined(CONFIG_ARCH_SOCFPGA_AGILEX) || \
> +       defined(CONFIG_ARCH_SOCFPGA_AGILEX7M)
>   int is_fpga_config_ready(void);
>   #endif
>
> diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager.h b/arch/arm/mach-socfpga/include/mach/reset_manager.h
> index 1d68034cb55..97bb48474f3 100644
> --- a/arch/arm/mach-socfpga/include/mach/reset_manager.h
> +++ b/arch/arm/mach-socfpga/include/mach/reset_manager.h
> @@ -39,11 +39,11 @@ void socfpga_per_reset_all(void);
>   /* Create a human-readable reference to SoCFPGA reset. */
>   #define SOCFPGA_RESET(_name)   RSTMGR_##_name
>
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>   #include <asm/arch/reset_manager_gen5.h>
> -#elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
> +#elif defined(CONFIG_ARCH_SOCFPGA_ARRIA10)
>   #include <asm/arch/reset_manager_arria10.h>
> -#elif defined(CONFIG_TARGET_SOCFPGA_SOC64)
> +#elif defined(CONFIG_ARCH_SOCFPGA_SOC64)
>   #include <asm/arch/reset_manager_soc64.h>
>   #endif
>
> diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
> index 4b010be9ee8..5d72480dc13 100644
> --- a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
> @@ -39,7 +39,7 @@ void socfpga_bridges_reset(int enable, unsigned int mask);
>   #define RSTMGR_STAT_SDMWARMRST         0x2
>   #define RSTMGR_STAT_MPU0RST_BITPOS     8
>   #define RSTMGR_STAT_L4WD0RST_BITPOS    16
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define RSTMGR_STAT_L4WD0RST_BIT       0x1F0000
>   #define RSTMGR_L4WD_MPU_WARMRESET_MASK (RSTMGR_STAT_SDMWARMRST | \
>                  RSTMGR_STAT_L4WD0RST_BIT)
> diff --git a/arch/arm/mach-socfpga/include/mach/sdram.h b/arch/arm/mach-socfpga/include/mach/sdram.h
> index 79cb9e6064a..9a261eb9383 100644
> --- a/arch/arm/mach-socfpga/include/mach/sdram.h
> +++ b/arch/arm/mach-socfpga/include/mach/sdram.h
> @@ -7,9 +7,9 @@
>
>   #ifndef __ASSEMBLY__
>
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>   #include <asm/arch/sdram_gen5.h>
> -#elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
> +#elif defined(CONFIG_ARCH_SOCFPGA_ARRIA10)
>   #include <asm/arch/sdram_arria10.h>
>   #endif
>
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager.h b/arch/arm/mach-socfpga/include/mach/system_manager.h
> index 5603eaa3d02..3d5bd81e1b5 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager.h
> @@ -8,7 +8,7 @@
>
>   phys_addr_t socfpga_get_sysmgr_addr(void);
>
> -#if defined(CONFIG_TARGET_SOCFPGA_SOC64)
> +#if defined(CONFIG_ARCH_SOCFPGA_SOC64)
>   #include <asm/arch/system_manager_soc64.h>
>   #else
>   #define SYSMGR_ROMCODEGRP_CTRL_WARMRSTCFGPINMUX        BIT(0)
> @@ -85,9 +85,9 @@ phys_addr_t socfpga_get_sysmgr_addr(void);
>   #define ALT_SYSMGR_ECC_INTSTAT_SERR_OCRAM_SET_MSK      BIT(1)
>   #define ALT_SYSMGR_ECC_INTSTAT_DERR_OCRAM_SET_MSK      BIT(1)
>
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>   #include <asm/arch/system_manager_gen5.h>
> -#elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
> +#elif defined(CONFIG_ARCH_SOCFPGA_ARRIA10)
>   #include <asm/arch/system_manager_arria10.h>
>   #endif
>
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> index f768a3a55cb..8be98d0ee46 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> @@ -12,7 +12,7 @@ void sysmgr_pinmux_init(void);
>   void populate_sysmgr_fpgaintf_module(void);
>   void populate_sysmgr_pinmux(void);
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define SYSMGR_SOC64_SILICONID_1               0x00
>   #define SYSMGR_SOC64_SILICONID_2               0x04
>   #define SYSMGR_SOC64_MPU_STATUS                        0x10
> @@ -62,7 +62,7 @@ void populate_sysmgr_pinmux(void);
>   #else
>   #define SYSMGR_SOC64_NAND_AXUSER               0x5c
>   #define SYSMGR_SOC64_DMA_L3MASTER              0x74
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
>   #define SYSMGR_SOC64_DDR_MODE                  0xb8
>   #else
>   #define SYSMGR_SOC64_HMC_CLK                   0xb4
> @@ -73,7 +73,7 @@ void populate_sysmgr_pinmux(void);
>   #define SYSMGR_SOC64_GPI                       0xe8
>   #define SYSMGR_SOC64_MPU                       0xf0
>   #define SYSMGR_SCRATCH_REG_0_QSPI_REFCLK_MASK  GENMASK(27, 0)
> -#endif /*CONFIG_TARGET_SOCFPGA_AGILEX5*/
> +#endif /*CONFIG_ARCH_SOCFPGA_AGILEX5*/
>
>   #define SYSMGR_SOC64_DMA                       0x20
>   #define SYSMGR_SOC64_DMA_PERIPH                        0x24
> @@ -218,7 +218,7 @@ void populate_sysmgr_pinmux(void);
>
>   #define SYSMGR_WDDBG_PAUSE_ALL_CPU     0xFF0F0F0F
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
>   #define        SYSMGR_SOC64_DDR_MODE_MSK       BIT(0)
>   #endif
>
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 07694107c8a..1eef7893e54 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -54,7 +54,7 @@ struct bsel bsel_str[] = {
>
>   int dram_init(void)
>   {
> -#if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>          struct spl_handoff *ho;
>
>          ho = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(*ho));
> @@ -65,7 +65,7 @@ int dram_init(void)
>   #else
>          if (fdtdec_setup_mem_size_base() != 0)
>                  return -EINVAL;
> -#endif /* HANDOFF && CONFIG_TARGET_SOCFPGA_AGILEX5 */
> +#endif /* HANDOFF && CONFIG_ARCH_SOCFPGA_AGILEX5 */
>
>          return 0;
>   }
> @@ -261,21 +261,21 @@ void socfpga_get_managers_addr(void)
>          if (ret)
>                  hang();
>
> -       if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
> -           !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M) &&
> -           !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
> +       if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
> +           !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
> +           !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)) {
>                  ret = socfpga_get_base_addr("altr,sys-mgr",
>                                              &socfpga_sysmgr_base);
>                  if (ret)
>                          hang();
>          }
>
> -       if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
> +       if (IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X))
>                  ret = socfpga_get_base_addr("intel,n5x-clkmgr",
>                                              &socfpga_clkmgr_base);
> -       else if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
> -                !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M) &&
> -                !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
> +       else if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
> +                !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
> +                !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5))
>                  ret = socfpga_get_base_addr("altr,clk-mgr",
>                                              &socfpga_clkmgr_base);
>
> diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
> index 5222b384434..b74685df168 100644
> --- a/arch/arm/mach-socfpga/misc_soc64.c
> +++ b/arch/arm/mach-socfpga/misc_soc64.c
> @@ -94,7 +94,7 @@ void save_boot_params(unsigned long r0, unsigned long r1, unsigned long r2,
>   int print_cpuinfo(void)
>   {
>          printf("CPU: Altera FPGA SoCFPGA Platform (ARMv8 64bit Cortex-%s)\n",
> -              IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) ? "A55/A76" : "A53");
> +              IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) ? "A55/A76" : "A53"); return 0; } diff --git a/arch/arm/mach-socfpga/mmu-arm64_s10.c 
> b/arch/arm/mach-socfpga/mmu-arm64_s10.c index 1dc44ab4797..33520aae6cd 
> 100644 --- a/arch/arm/mach-socfpga/mmu-arm64_s10.c +++ 
> b/arch/arm/mach-socfpga/mmu-arm64_s10.c @@ -9,7 +9,7 @@ 
> DECLARE_GLOBAL_DATA_PTR; -#if 
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) +#if 
> IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) static struct mm_region 
> socfpga_agilex5_mem_map[] = { { /* OCRAM 512KB */ diff --git 
> a/arch/arm/mach-socfpga/reset_manager_s10.c 
> b/arch/arm/mach-socfpga/reset_manager_s10.c index 
> abb62a9b49f..67b16180ae7 100644 --- 
> a/arch/arm/mach-socfpga/reset_manager_s10.c +++ 
> b/arch/arm/mach-socfpga/reset_manager_s10.c @@ -79,7 +79,7 @@ static 
> void socfpga_f2s_bridges_reset(int enable, unsigned int mask) u32 
> flaginstatus_idleack = 0; u32 flaginstatus_respempty = 0; - if 
> (CONFIG_IS_ENABLED(TARGET_SOCFPGA_STRATIX10)) { + if 
> (CONFIG_IS_ENABLED(ARCH_SOCFPGA_STRATIX10)) { /* Support fpga2soc and 
> f2sdram */ brg_mask = mask & (RSTMGR_BRGMODRST_FPGA2SOC_MASK | 
> RSTMGR_BRGMODRST_F2SDRAM0_MASK | diff --git 
> a/arch/arm/mach-socfpga/system_manager_soc64.c 
> b/arch/arm/mach-socfpga/system_manager_soc64.c index 
> 913f93c8f94..94624deef10 100644 --- 
> a/arch/arm/mach-socfpga/system_manager_soc64.c +++ 
> b/arch/arm/mach-socfpga/system_manager_soc64.c @@ -12,7 +12,7 @@ 
> DECLARE_GLOBAL_DATA_PTR; -#if 
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) +#if 
> IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) /* * Setting 
> RESET_PULSE_OVERRIDE bit for successful reset staggering pulse * 
> generation and setting PORT_OVERCURRENT bit so that until we turn on 
> the @@ -39,7 +39,7 @@ void sysmgr_pinmux_init(void) 
> populate_sysmgr_pinmux(); populate_sysmgr_fpgaintf_module(); -#if 
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) +#if 
> IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) sysmgr_config_usb3(); #endif } 
> diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c 
> b/arch/arm/mach-socfpga/wrap_handoff_soc64.c index 
> 7105cdc4905..ecde90f76f4 100644 --- 
> a/arch/arm/mach-socfpga/wrap_handoff_soc64.c +++ 
> b/arch/arm/mach-socfpga/wrap_handoff_soc64.c @@ -29,13 +29,13 @@ 
> static enum endianness check_endianness(u32 handoff) case 
> SOC64_HANDOFF_MAGIC_DELAY: case SOC64_HANDOFF_MAGIC_CLOCK: case 
> SOC64_HANDOFF_MAGIC_SDRAM: -#if 
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) +#if 
> IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) case SOC64_HANDOFF_MAGIC_PERI: 
> #else case SOC64_HANDOFF_MAGIC_MISC: #endif return BIG_ENDIAN; -#if 
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) +#if 
> IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X) case 
> SOC64_HANDOFF_DDR_UMCTL2_MAGIC: debug("%s: umctl2 handoff data\n", __func__);
>                  return LITTLE_ENDIAN;
> diff --git a/common/Kconfig b/common/Kconfig
> index 47d17f4e7c6..ee26bf8c96b 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -55,7 +55,7 @@ config CONSOLE_RECORD_IN_SIZE
>   config SYS_CBSIZE
>          int "Console input buffer size"
>          default 2048 if ARCH_TEGRA || ARCH_VERSAL || ARCH_ZYNQ || ARCH_ZYNQMP || \
> -               RCAR_GEN3 || TARGET_SOCFPGA_SOC64
> +               RCAR_GEN3 || ARCH_SOCFPGA_SOC64
>          default 512 if ARCH_MX5 || ARCH_MX6 || ARCH_MX7 || FSL_LSCH2 || \
>                  FSL_LSCH3 || X86
>          default 256 if M68K || PPC
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 3b7b6cafef8..749e2dc1395 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -545,7 +545,7 @@ config SPL_SYS_MMCSD_RAW_MODE
>          depends on SPL_DM_MMC || SPL_MMC
>          default y if ARCH_SUNXI || ARCH_DAVINCI || ARCH_UNIPHIER || \
>                       ARCH_MX6 || ARCH_MX7 || \
> -                    ARCH_ROCKCHIP || ARCH_MVEBU || TARGET_SOCFPGA_GEN5 || \
> +                    ARCH_ROCKCHIP || ARCH_MVEBU || ARCH_SOCFPGA_GEN5 || \
>                       ARCH_AT91 || ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
>                       OMAP54XX || AM33XX || AM43XX || \
>                       TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
> @@ -589,7 +589,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
>          default 0x8a if ARCH_MX6 || ARCH_MX7
>          default 0x100 if ARCH_UNIPHIER
>          default 0x0 if ARCH_MVEBU
> -       default 0x200 if TARGET_SOCFPGA_GEN5 || ARCH_AT91
> +       default 0x200 if ARCH_SOCFPGA_GEN5 || ARCH_AT91
>          default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
>                           OMAP54XX || AM33XX || AM43XX || ARCH_K3
>          default 0x4000 if ARCH_ROCKCHIP
> diff --git a/drivers/clk/altera/Makefile b/drivers/clk/altera/Makefile
> index 858f828e537..693446b3d89 100644
> --- a/drivers/clk/altera/Makefile
> +++ b/drivers/clk/altera/Makefile
> @@ -3,9 +3,9 @@
>   # Copyright (C) 2018-2021 Marek Vasut<marex@denx.de>
>   #
>
> -obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += clk-agilex.o
> -obj-$(CONFIG_TARGET_SOCFPGA_AGILEX7M) += clk-agilex.o
> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += clk-arria10.o
> -obj-$(CONFIG_TARGET_SOCFPGA_N5X) += clk-n5x.o
> -obj-$(CONFIG_TARGET_SOCFPGA_N5X) += clk-mem-n5x.o
> -obj-$(CONFIG_TARGET_SOCFPGA_AGILEX5) += clk-agilex5.o
> +obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += clk-agilex.o
> +obj-$(CONFIG_ARCH_SOCFPGA_AGILEX7M) += clk-agilex.o
> +obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += clk-arria10.o
> +obj-$(CONFIG_ARCH_SOCFPGA_N5X) += clk-n5x.o
> +obj-$(CONFIG_ARCH_SOCFPGA_N5X) += clk-mem-n5x.o
> +obj-$(CONFIG_ARCH_SOCFPGA_AGILEX5) += clk-agilex5.o
> diff --git a/drivers/ddr/altera/Kconfig b/drivers/ddr/altera/Kconfig
> index 4660d20deff..615e0421abf 100644
> --- a/drivers/ddr/altera/Kconfig
> +++ b/drivers/ddr/altera/Kconfig
> @@ -1,8 +1,8 @@
>   config SPL_ALTERA_SDRAM
>          bool "SoCFPGA DDR SDRAM driver in SPL"
>          depends on SPL
> -       depends on TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10 || TARGET_SOCFPGA_SOC64
> -       select RAM if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_SOC64
> -       select SPL_RAM if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_SOC64
> +       depends on ARCH_SOCFPGA_GEN5 || ARCH_SOCFPGA_ARRIA10 || ARCH_SOCFPGA_SOC64
> +       select RAM if ARCH_SOCFPGA_GEN5 || ARCH_SOCFPGA_SOC64
> +       select SPL_RAM if ARCH_SOCFPGA_GEN5 || ARCH_SOCFPGA_SOC64
>          help
>            Enable DDR SDRAM controller for the SoCFPGA devices.
> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
> index 7ed43965be5..8259ab04a7e 100644
> --- a/drivers/ddr/altera/Makefile
> +++ b/drivers/ddr/altera/Makefile
> @@ -7,11 +7,11 @@
>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>
>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
> -obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
> -obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
> -obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
> -obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
> -obj-$(CONFIG_TARGET_SOCFPGA_AGILEX5) += sdram_soc64.o sdram_agilex5.o iossm_mailbox.o
> -obj-$(CONFIG_TARGET_SOCFPGA_AGILEX7M) += sdram_soc64.o sdram_agilex7m.o iossm_mailbox.o uibssm_mailbox.o
> +obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
> +obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_arria10.o
> +obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
> +obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
> +obj-$(CONFIG_ARCH_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
> +obj-$(CONFIG_ARCH_SOCFPGA_AGILEX5) += sdram_soc64.o sdram_agilex5.o iossm_mailbox.o
> +obj-$(CONFIG_ARCH_SOCFPGA_AGILEX7M) += sdram_soc64.o sdram_agilex7m.o iossm_mailbox.o uibssm_mailbox.o
>   endif
> diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
> index 2d0093c591c..8ee7049b164 100644
> --- a/drivers/ddr/altera/sdram_soc64.c
> +++ b/drivers/ddr/altera/sdram_soc64.c
> @@ -32,7 +32,7 @@
>   #define SINGLE_RANK_CLAMSHELL  0xc3c3
>   #define DUAL_RANK_CLAMSHELL    0xa5a5
>
> -#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) && !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
> +#if !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) && !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)
>   u32 hmc_readl(struct altera_sdram_plat *plat, u32 reg)
>   {
>          return readl(plat->iomhc + reg);
> @@ -106,7 +106,7 @@ int emif_reset(struct altera_sdram_plat *plat)
>   }
>   #endif
>
> -#if !(IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) || IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
> +#if !(IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X) || IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5))
>   int poll_hmc_clock_status(void)
>   {
>          return wait_for_bit_le32((const void *)(socfpga_get_sysmgr_addr() +
> @@ -347,7 +347,7 @@ static void sdram_set_firewall_non_f2sdram(struct bd_info *bd)
>          }
>   }
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   static void sdram_set_firewall_f2sdram(struct bd_info *bd)
>   {
>          u32 i, lower, upper;
> @@ -397,22 +397,22 @@ void sdram_set_firewall(struct bd_info *bd)
>   {
>          sdram_set_firewall_non_f2sdram(bd);
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>          sdram_set_firewall_f2sdram(bd);
>   #endif
>   }
>
>   static int altera_sdram_of_to_plat(struct udevice *dev)
>   {
> -#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
> +#if !IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
>          struct altera_sdram_plat *plat = dev_get_plat(dev);
>          fdt_addr_t addr;
>   #endif
>
>          /* These regs info are part of DDR handoff in bitstream */
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
>          return 0;
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) || IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) || IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)
>          addr = dev_read_addr_index(dev, 0);
>          if (addr == FDT_ADDR_T_NONE)
>                  return -EINVAL;
> diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
> index 6fe0653922c..e8090f91002 100644
> --- a/drivers/ddr/altera/sdram_soc64.h
> +++ b/drivers/ddr/altera/sdram_soc64.h
> @@ -15,13 +15,13 @@ struct altera_sdram_priv {
>          struct reset_ctl_bulk resets;
>   };
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   struct altera_sdram_plat {
>          fdt_addr_t mpfe_base_addr;
>          bool dualport;
>          bool dualemif;
>   };
> -#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
> +#elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)
>   enum memory_type {
>          DDR_MEMORY = 0,
>          HBM_MEMORY
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index e2593057fac..1658c73bca4 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -46,7 +46,7 @@ config FPGA_CYCLON2
>
>   config FPGA_INTEL_SDM_MAILBOX
>          bool "Enable Intel FPGA Full Reconfiguration SDM Mailbox driver"
> -       depends on TARGET_SOCFPGA_SOC64
> +       depends on ARCH_SOCFPGA_SOC64
>          select FPGA_ALTERA
>          help
>            Say Y here to enable the Intel FPGA Full Reconfig SDM Mailbox driver
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index f22d3b3d86e..ccfed94717e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -21,6 +21,6 @@ obj-$(CONFIG_FPGA_INTEL_SDM_MAILBOX) += intel_sdm_mb.o
>   obj-$(CONFIG_FPGA_STRATIX_II) += stratixII.o
>   obj-$(CONFIG_FPGA_STRATIX_V) += stratixv.o
>   obj-$(CONFIG_FPGA_SOCFPGA) += socfpga.o
> -obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += socfpga_gen5.o
> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += socfpga_arria10.o
> +obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += socfpga_gen5.o
> +obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += socfpga_arria10.o
>   endif
> diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
> index 4a9aa74357e..822183c5785 100644
> --- a/drivers/fpga/altera.c
> +++ b/drivers/fpga/altera.c
> @@ -12,8 +12,8 @@
>   /*
>    *  Altera FPGA support
>    */
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
> -       IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
> +       IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
>   #include <asm/arch/misc.h>
>   #endif
>   #include <errno.h>
> @@ -48,8 +48,8 @@ static const struct altera_fpga {
>   #endif
>   };
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
> -       IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
> +       IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
>   int fpga_is_partial_data(int devnum, size_t img_len)
>   {
>          /*
> diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
> index 6219284df3e..c8da6ead0ea 100644
> --- a/drivers/mmc/socfpga_dw_mmc.c
> +++ b/drivers/mmc/socfpga_dw_mmc.c
> @@ -58,8 +58,8 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
>          u32 sdmmc_mask = ((priv->smplsel & 0x7) << SYSMGR_SDMMC_SMPLSEL_SHIFT) |
>                           ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
>
> -       if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
> -           !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)) {
> +       if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
> +           !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)) {
>                  /* Disable SDMMC clock. */
>                  clrbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
>                               CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
> @@ -95,8 +95,8 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
>                  readl(socfpga_get_sysmgr_addr() + SYSMGR_SDMMC));
>   #endif
>
> -       if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
> -           !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)) {
> +       if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
> +           !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)) {
>                  /* Enable SDMMC clock */
>                  setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
>                               CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index a93b00cdb7e..9b0bb94a86f 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -212,7 +212,7 @@ config NAND_CADENCE
>   config NAND_DENALI
>          bool
>          select SYS_NAND_SELF_INIT
> -       select SYS_NAND_ONFI_DETECTION if TARGET_SOCFPGA_SOC64
> +       select SYS_NAND_ONFI_DETECTION if ARCH_SOCFPGA_SOC64
>          imply CMD_NAND
>
>   config NAND_DENALI_DT
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 544e302d600..9db5cdb7f73 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -192,7 +192,7 @@ config DWC_ETH_XGMAC_SOCFPGA
>          select SYSCON
>          select DWC_ETH_XGMAC
>          depends on ARCH_SOCFPGA
> -       default y if TARGET_SOCFPGA_AGILEX5
> +       default y if ARCH_SOCFPGA_AGILEX5
>          help
>            The Synopsys Designware Ethernet XGMAC IP block with specific
>            configuration used in Intel SoC FPGA chip.
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 0ad885c9e8b..b4b836a459c 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -20,7 +20,7 @@ config APPLE_PMGR_POWER_DOMAIN
>
>   config AGILEX5_PMGR_POWER_DOMAIN
>          bool "Enable the Agilex5 PMGR power domain driver"
> -       depends on SPL_POWER_DOMAIN && TARGET_SOCFPGA_SOC64
> +       depends on SPL_POWER_DOMAIN && ARCH_SOCFPGA_SOC64
>          help
>            Enable support for power gating peripherals' SRAM specified in
>            the handoff data values obtained from the bitstream to reduce
> diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
> index e57729f0ef9..36a205f9fca 100644
> --- a/drivers/reset/reset-socfpga.c
> +++ b/drivers/reset/reset-socfpga.c
> @@ -115,7 +115,7 @@ static int socfpga_reset_remove(struct udevice *dev)
>          if (socfpga_reset_keep_enabled()) {
>                  puts("Deasserting all peripheral resets\n");
>                  writel(0, data->modrst_base + 4);
> -               if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_ARRIA10))
> +               if (IS_ENABLED(CONFIG_ARCH_SOCFPGA_ARRIA10))
>                          writel(0, data->modrst_base + 8);
>          }
>
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 0181f6cd581..b0cb42c7fb7 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -196,14 +196,14 @@ config SYSRESET_SBI
>
>   config SYSRESET_SOCFPGA
>          bool "Enable support for Intel SOCFPGA family"
> -       depends on ARCH_SOCFPGA && (TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10)
> +       depends on ARCH_SOCFPGA && (ARCH_SOCFPGA_GEN5 || ARCH_SOCFPGA_ARRIA10)
>          help
>            This enables the system reset driver support for Intel SOCFPGA SoCs
>            (Cyclone 5, Arria 5 and Arria 10).
>
>   config SYSRESET_SOCFPGA_SOC64
>          bool "Enable support for Intel SOCFPGA SoC64 family (Stratix10/Agilex)"
> -       depends on ARCH_SOCFPGA && TARGET_SOCFPGA_SOC64
> +       depends on ARCH_SOCFPGA && ARCH_SOCFPGA_SOC64
>          help
>            This enables the system reset driver support for Intel SOCFPGA
>            SoC64 SoCs.
> diff --git a/env/Kconfig b/env/Kconfig
> index 4430669964c..5a93f09a947 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -964,7 +964,7 @@ config USE_BOOTFILE
>
>   config BOOTFILE
>          string "'bootfile' environment variable value"
> -       default kernel.itb if SPL_ATF && TARGET_SOCFPGA_SOC64
> +       default kernel.itb if SPL_ATF && ARCH_SOCFPGA_SOC64
>          depends on USE_BOOTFILE
>          help
>            The value to set the "bootfile" variable to.
> diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
> index 2acfdc7df4a..36d6bfb3d03 100644
> --- a/include/configs/socfpga_common.h
> +++ b/include/configs/socfpga_common.h
> @@ -11,10 +11,10 @@
>    * Memory configurations
>    */
>   #define PHYS_SDRAM_1                   0x0
> -#if defined(CONFIG_TARGET_SOCFPGA_GEN5)
> +#if defined(CONFIG_ARCH_SOCFPGA_GEN5)
>   #define CFG_SYS_INIT_RAM_ADDR  0xFFFF0000
>   #define CFG_SYS_INIT_RAM_SIZE  SOCFPGA_PHYS_OCRAM_SIZE
> -#elif defined(CONFIG_TARGET_SOCFPGA_ARRIA10)
> +#elif defined(CONFIG_ARCH_SOCFPGA_ARRIA10)
>   #define CFG_SYS_INIT_RAM_ADDR  0xFFE00000
>   /* SPL memory allocation configuration, this is for FAT implementation */
>   #define CFG_SYS_INIT_RAM_SIZE  (SOCFPGA_PHYS_OCRAM_SIZE - \
> diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
> index 3d09a06f63e..4d333c63ad9 100644
> --- a/include/configs/socfpga_soc64_common.h
> +++ b/include/configs/socfpga_soc64_common.h
> @@ -41,7 +41,7 @@
>   /*
>    * U-Boot run time memory configurations
>    */
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define CFG_SYS_INIT_RAM_ADDR  0x0
>   #define CFG_SYS_INIT_RAM_SIZE  0x80000
>   #else
> @@ -118,7 +118,7 @@
>
>   #include <config_distro_bootcmd.h>
>
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>
>   #define CFG_EXTRA_ENV_SETTINGS \
>          "kernel_addr_r=0x82000000\0" \
> @@ -182,7 +182,7 @@
>          "smc_fid_wr=0xC2000008\0" \
>          "smc_fid_upd=0xC2000009\0 " \
>          BOOTENV
> -#endif /*#IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)*/
> +#endif /*#IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)*/
>
>   #else
>
> @@ -245,7 +245,7 @@
>   /*
>    * External memory configurations
>    */
> -#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
>   #define PHYS_SDRAM_1                   0x80000000
>   #define PHYS_SDRAM_1_SIZE              (1 * 1024 * 1024 * 1024)
>   #define CFG_SYS_SDRAM_BASE             0x80000000
> @@ -270,7 +270,7 @@
>   /*
>    * L4 Watchdog
>    */
> -#ifdef CONFIG_TARGET_SOCFPGA_STRATIX10
> +#ifdef CONFIG_ARCH_SOCFPGA_STRATIX10
>   #ifndef __ASSEMBLY__
>   unsigned int cm_get_l4_sys_free_clk_hz(void);
>   #define CFG_DW_WDT_CLOCK_KHZ           (cm_get_l4_sys_free_clk_hz() / 1000)
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 52f014ad332..214a07d54a0 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -266,11 +266,11 @@ ifneq ($(CONFIG_ARCH_EXYNOS)$(CONFIG_ARCH_S5PC1XX),)
>   INPUTS-y       += $(obj)/$(BOARD)-spl.bin
>   endif
>
> -ifneq ($(CONFIG_TARGET_SOCFPGA_GEN5)$(CONFIG_TARGET_SOCFPGA_ARRIA10),)
> +ifneq ($(CONFIG_ARCH_SOCFPGA_GEN5)$(CONFIG_ARCH_SOCFPGA_ARRIA10),)
>   INPUTS-y       += $(obj)/$(SPL_BIN).sfp
>   endif
>
> -INPUTS-$(CONFIG_TARGET_SOCFPGA_SOC64) += $(obj)/u-boot-spl-dtb.hex
> +INPUTS-$(CONFIG_ARCH_SOCFPGA_SOC64) += $(obj)/u-boot-spl-dtb.hex
>
>   ifdef CONFIG_ARCH_SUNXI
>   INPUTS-y       += $(obj)/sunxi-spl.bin
> @@ -430,7 +430,7 @@ ifneq ($(CONFIG_$(PHASE_)TEXT_BASE),)
>   LDFLAGS_$(SPL_BIN) += -Ttext $(CONFIG_$(PHASE_)TEXT_BASE)
>   endif
>
> -ifdef CONFIG_TARGET_SOCFPGA_ARRIA10
> +ifdef CONFIG_ARCH_SOCFPGA_ARRIA10
>   MKIMAGEFLAGS_$(SPL_BIN).sfp = -T socfpgaimage_v1
>   else
>   MKIMAGEFLAGS_$(SPL_BIN).sfp = -T socfpgaimage
> --
> 2.34.1


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
