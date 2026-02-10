Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA151EE6B73
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 03:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368468388D;
	Tue, 10 Feb 2026 04:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OCpmNfaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B37D83BDD; Tue, 10 Feb 2026 04:55:10 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358E18309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 04:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNKVC9wygqXtaYatiELrCtfOsRQk0kk8R4tEhb24zRdtDMzBQk1o3/vmQ9pfe6Vuheqa1PN347HE7V2Pd83hIj4GjemJnOzkIiD667JjdNe5N5wdTElw8BWpE9OPFNE6TOy4OILoBTdo71JsedbB/UQ0QEXgLk1Hh18HMGjlKLgLFWYh6JwgsUse4paw0K98j/1/JArqZ2a4RN+Ju6gpbGxCppZnvJEnRiHMFHBA7eMxXwCQmZZtnqQfGZtr9nxNC3cRj8bb/mYCgQoP2imnmIUEYlZQJubQFScAf1/zyeK+8Ond/+orOeP8IpZPDT/+mPkfG5PRSzwzBrLvlWtYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cGjdVGe4+2U/xZvNKViyvfXaxbDR44ShJ6nmNeTOMQ=;
 b=SAkyw0HP2f2sqyU3fhUn1WVNOsYiA3jnDhiUB0sPV3U8XrL1FKXHurSXw2p0xrYPKYrPgVb019RPk1V2Oz1n9Rdxy7i07xtY1Sx9HlUgAWfdjXUcSlM/OuA4jKGEUD/qcRXBBN5JcFwnaFLqbCLjije7acSqaJU0c+8AIZ1SVOe69pR8B/dPZV1gvGl9aGbF8/Bima7S76Oh8XPf+aKyOT0K6+0gFzQIsweoQewoER0MHVCIExIldCC6KjoTM03+j7dBV5bA/72kI/wPToyZ4sdbfFBfDpc5uBBLm6NiAuRdH8Dg41u+I2T6HSnZZUBFAXLTGybDJjYlyAyRtKC7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cGjdVGe4+2U/xZvNKViyvfXaxbDR44ShJ6nmNeTOMQ=;
 b=OCpmNfaH+F6DWSHq1rjzw8kX85sogmMKccnimojYwzn3qRiLxYGIi4/hA6ixC8sKe9DDSbI8PH2FaJ8AiwbGa8RBIvAbBmdlCRh1NfY+EM46SVjmaeXuIaaHyBTvTboY3wsSNqUT0PCLfJPr0Wi3meemIbYEjE9l9FBfsfa/dnanghrRsV5zAkfdoNZhFMy7wpQccjU/5bFiYp7CV0SrfXfHKe2NUM9NykUjrYUkKybK5ZJtNIBHqImI8qQLOo/LFe9TL1zlI8MV1JqT8zG7/cuQSca3ibUBWfeYTVLS64wLmDwDUe7iwhc5WOmmMOEdKazHS2iwt/+YA2kqHD4iZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB8349.namprd03.prod.outlook.com (2603:10b6:806:460::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 03:55:05 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 03:55:05 +0000
Message-ID: <990121d3-5735-49db-8066-5dce734aa37b@altera.com>
Date: Tue, 10 Feb 2026 11:54:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: dts: agilex5: Fix DT property naming
 convention
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
 <20260201151343.27560-2-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260201151343.27560-2-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA3PR03MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3159ca62-6090-43c9-f08d-08de68582c98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1dpQ281Sjk1NDNnRG1iMm9IZWN1cDIySXF0U1RyVHlqUjdEOFNVY1hseDRQ?=
 =?utf-8?B?bzNsTkVYa3djVW5IV0QrVHVwOHYrT2ZJSWk3V00wZTdXcURpbzJncFNpajhO?=
 =?utf-8?B?UEk4NlZxaDU3THlIMStrWnVCMytMOGxuZDVSUGhNcFlRM0U1UmNKbWo2ZDFY?=
 =?utf-8?B?cEZXTjRUTzVVbk5zZmhJQ3JZTUtEZlc1ZU5tZGhvb0JoOWl1enZRdzhONFI0?=
 =?utf-8?B?VW1iK0lNcmhZTUF2SEo3WEZxS3IraTJpZ0dsQXBvVjgyMXpQZUpaR3lCZWhS?=
 =?utf-8?B?M2RNUVBad0RmaEdWL2VXUGg0eEZublpMY2RDOUFVLytUL3M2NmFrOTExM3BS?=
 =?utf-8?B?UU02TXd3UWR2Smc5Vm9sZU9NaTRGNkV5UjNSYUtOWEFPWUFBL1FQelRTMlA0?=
 =?utf-8?B?bjJqUDUyc1dKMXZld0tHVURhMjdGKy9sUlR2VmxNUW1FVlhUR1RDc0NDUzZB?=
 =?utf-8?B?eUl1NFdsa1dzRDdnSldjYnV4UFA4M3IxbkpwVW1QdnVOaDlLc21qVjVqY2Zx?=
 =?utf-8?B?RlJwemdRY3NiNE1KZXJPVHJlVnN2M3Fnb0RWbGZ3VlIvU3NFVmFiUG1yYWxE?=
 =?utf-8?B?NVBKOHgweW1XVWl5Q1M3NiszUFcyd2hNWjdkOTAzdWFmZExTMmZuSHZIRHlS?=
 =?utf-8?B?eGNhbCttOTJORW53eGFmQ2NYSzV2YVhhcUdWQmt3OUtEYWh3NStIT2ZrMG5x?=
 =?utf-8?B?ZGZKcFZFcnFTZExQaGpzeCtic0tRVXFKcWdMdkZWdDZBN2pFdWRoRzJlcjZW?=
 =?utf-8?B?QS9TWURZQmhRYlpaVGlOaUFoMy9penNsTUVtc2EvYXZrK3l2MUdDWGhhNlZ2?=
 =?utf-8?B?OEI2UHdJNSt0eC9QRWg3OFFXSHJXTDZ0UkJTNmMrQzdzYk9jaW5KNCtYYVlX?=
 =?utf-8?B?UjRjZTRCalhNcGJiL2F1WEgxZ0RtdXIranpvS1lyMWRXd1FUK3hNM00xZkY2?=
 =?utf-8?B?a0VHb1I0bXlqdkNXZ1puOFY4NTFoNSsyK1V5OGZqZVBRTXhZUzBXMEtCS1JH?=
 =?utf-8?B?Q1R4dHA5M0IwMzZSL29qNDdOMVBDeHcwMHkyKzgyUFVmVCtMZGJGcDFMeEdI?=
 =?utf-8?B?WmFrY2VPM0tINCtSQUNPUzUwSVlqV2Y3NUtCZ3ZQM0o0SkhqTlhKbW5NUDNy?=
 =?utf-8?B?dElCRms1L2xUZTE2cUNFRmJIUHl2MDZzNVREZnBCR3J1b0tzQjk0ZVYzbzFr?=
 =?utf-8?B?Uy8wck1FK0txL0hCMWdGZDhZUi8zZUdBamlQa0tlYmQ1UE9RekxkSEhFZTRo?=
 =?utf-8?B?RW5zWGtQeG11NGtQZ0poT0lNS2VFZ0QreDlRd2tmMVdKaWZPd0d5UHpnam9s?=
 =?utf-8?B?SStQcDlpOHhmRndMbnFpZmt2SVRDWkN1cm5rNURSejh0UUw1VzZFS3dmeGhC?=
 =?utf-8?B?b0FsU29uZVhPckgxMmxLYkRTbVZDbUNlemRuRzVFRFdSbUY5dkcxVFRLQlYy?=
 =?utf-8?B?dUVOWGFYdWtiS040UFlaWGh6Y25KRTJHb0tnbG8wcEQ3a2FvUmQ5azVicTZ0?=
 =?utf-8?B?NFdPRVNqUlNhakNHb3huNU8wbDBWemEveVpXb0QxRVZaK3BsUG1MQWc3M1c5?=
 =?utf-8?B?R3d5Tk9GT1c0SUdiQS9ZWFpORmMrVHpTclJDWmlLbWF5T2pRKy9nZG9TLzBp?=
 =?utf-8?B?Z1p4eFdxd24xNXVmU2FJbmpJT1ZXaldUb2dYcXliVDUvU1YvQnZpT0h2NzlS?=
 =?utf-8?B?c0lBZm9qbFFSUFh2Ti9rTmpMUkUweEQ3andsN1ROUDhaR2E3N3VOT2xZZUZ1?=
 =?utf-8?B?aE03U2Rva2lnUUFnREdrSWVGVEZ0UW53UHhROCsxam9EZ3NjcFNXK1Y3SmFi?=
 =?utf-8?B?eFpPNkdYd0dOTlZFWk5ZVzdVRzl1NkNqeFhaYWFMYkVsbnkweVlrVjZjZHZ5?=
 =?utf-8?B?ZURxVUtZL1g4bEFOdWpaVHpzUU1ZMGpNRFJRMWxnMzd0a3Q3SzAwZXBrVU9U?=
 =?utf-8?B?bGpTcUEvcXYyOWwwQUJBcGkrNHBBeThtTTJ2NFJwNXNmaExEUTZSUS96aFFR?=
 =?utf-8?B?YlVyd3RMbDRocmFXSXpRNXJUVnlMQWFuVFJBT1crT003UUYxRkgwb0p5WktN?=
 =?utf-8?B?UjluWDFGbTF0T3hrVis0QUpqa2ErTzBVdlFrN0Ywd0kxT09vVHhyaTdhQkhI?=
 =?utf-8?Q?Si2g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZaNmdVWVZSa3VudEtjVG9TU1laSnBWSEQxQkg1bG9GK0lrZnlmSklpQlNt?=
 =?utf-8?B?VDJXR0hTc1F3VXNZcU50UGlmeVE3SFZtakNEZVBpZ3RQUkZ5S3ZXY0twcWtM?=
 =?utf-8?B?Qzc1LzhFY1EvdFduZkZUejR0clNQM1Foc25aM3RtdXJ2SWg5SFZwZlAvbmp0?=
 =?utf-8?B?dlZyR1ZJSHk3eEtZOEJnYlVHd0FWaTVIK3FuVkJzaFdxVy94cVVXY0tjbkl4?=
 =?utf-8?B?SjlIWXNjVnh5VWg1YVRNUEZGc1lVQ1JoaUR2VG9oMnh5Q2owVENpRE5tQ1JH?=
 =?utf-8?B?ZjNRUTFyQ0JPU3NTSlBvNW5JWHJ5dHVnRjU4TmlKOXpDRTRKQlhZZTg5K0dl?=
 =?utf-8?B?aW9SazRRTlRiYVRPMHNFZFh2TnI5QjE2YWRvVEtzUlpIWFF6WTJYdDlHNy9m?=
 =?utf-8?B?eU1rbDJYYkZDRWpObnVlcnBzLzlSR1RlUmNCQUR5WmhBbmxSWGdBY0EzUHdS?=
 =?utf-8?B?VHI3RTkwMG4vN0lJcHF5dmpicjBvSk9OblpMalE3RWUxMzg1M0hCVmdUeG5k?=
 =?utf-8?B?dmpsemlNbmhtWVZFRzFIdk93YkhwMkV0MXEwaDdZRGg3dTE5R0x0eWM5VGVB?=
 =?utf-8?B?QzU3OVVIYlkyLzhCcmVoV21lMzlwSDk0WklNMUpWSUxJUEdGc0h1VjljelFU?=
 =?utf-8?B?dWdYOWdaT0hERlNFdkZyaDAvcWtWUmpnUUdTWlRPaUhSWDFZWGQvUGlBc21B?=
 =?utf-8?B?N1ZTeTZVZ0FXVHc1d3hVcmpsc3hsOWpXR3E4YU55QTFJbnpNTHNWN0NoNW5z?=
 =?utf-8?B?NjdGR0pXaitHZGdSOTdhUi9HbWl4bzJ1cTNUS2tycFNSOEprRHA0bFpyODJ3?=
 =?utf-8?B?R3QzL08vcThzVU1PN0JHdENmMCs4bWZWMnpRc1Y2cE9yR0o4QWtlRXN2cXFR?=
 =?utf-8?B?c0RWVVBTM2ZscEh6MUJPZnJGbXNGY2w4aVo4dGszbW1ER1lldVpXMWJqcTcv?=
 =?utf-8?B?VkhzWlNreURaK1NVVk9HMVo1WUhXbW5yZCsxK3dKeGMxbDBVTEVOeUx4dmds?=
 =?utf-8?B?UU95YlMyV3M3dmRVdUVkOGZMUTIvOHBIQVpxVlA4b1YzNmVrZlprZzhuTGQ0?=
 =?utf-8?B?czVtVTZNZ1IvN3dXOFRCdTBubUkwRVlpbUxJTHY0dUNXZnRaMjRhaDY2V3Y5?=
 =?utf-8?B?WFBBZFBETHVOa0hmWDhsQmZlSzQ3cGhTK1hrK3JsNUY0clR3T25QejJGQmJq?=
 =?utf-8?B?eWxrSEt6b08rbjhXK08yMElUZUNjTHJCL0Z4OGVCNzlVbXZDVXNGNnA4UzFp?=
 =?utf-8?B?bzErOGxiTFQzaDEwVGZjNXFsd0EwNTRBbHVwVkVhaisvTHJNajFycEwvY2Vj?=
 =?utf-8?B?Z1ZER3pVT210OHlHM0l3cVp2RDFYSzhWVGxuUFIyd05rQjE3ZG5EOFdkTC91?=
 =?utf-8?B?ZTZkb283K0trOElMemx0NXpycDQwUE91R1BGYkNFVjBDLytQaGFiU2t4WmUr?=
 =?utf-8?B?bkdmZDhwdzY2WmF3bkcybnRObTZxYS9iS1g1cmVsVFMvbWY4ZnBqeDlwWHI4?=
 =?utf-8?B?c05iSHRnVVNxcEYyQ2dyUk8xV2xDZ3BnOW1iMngxbnBwbXZvNmRuc09sTmZG?=
 =?utf-8?B?ZlYrZEUyZzNWbDVBaG1qdXBtc0VQK0lxRTRFMmVsYWc0K3E5SWkwRTkvL0tL?=
 =?utf-8?B?Q2JtcVFGN1cwTnVOTVd0RXdTcENOeDJFYnFwSlFlNG50Y1ZUZENTRE0xbkdQ?=
 =?utf-8?B?dC91VHQ1U2RpWXBvVURnYlFaUUJmcCtnbE95b3JlczQ0V1ZsNTlvWXJUU29o?=
 =?utf-8?B?WGFIaXVyOGkxVzRibGxhUXJMTjVUVzlVTnRpWlV1S3oxL0xHSXZyTm85NVE4?=
 =?utf-8?B?cmdKZVozSnNaVXFGS2xzckFOOVF4TWluQlplVnQ0cjBSTlZYWk9Pa3c2OUdn?=
 =?utf-8?B?dEl5WVhtaTRacDNqc2dMSm1LNWltQWd1WnArVUNjK1pPbTdnbC9OSTdndDgy?=
 =?utf-8?B?UlRybHNRdmMzQUkrUXJMQ0hrS25Obzlaa2l5OUZXT3lpZGJ0MktFekVSNE0w?=
 =?utf-8?B?NFAyRDAxT0JJd2V6UUROeHN5bXlaeTNNTUpraUFxdXBDMlNTZjc5MmpOK00v?=
 =?utf-8?B?WkpUV3RjTEVHVVNGNXJzRStyYkgxdWNWb29xbXlIQVdrVml2TUVWeHpVRTlX?=
 =?utf-8?B?bng3cEYvVlVjS2xjanlHN1RUOVJVYzlteUNmYU1CRXpQOStHaE5mQUJIalNG?=
 =?utf-8?B?dkpIVWdlSU1oNUFwK20vS2w3RENTTTdBV1o1dXFYd3ovYXhTL1UrTUs4YUlZ?=
 =?utf-8?B?SmVCK3BBYmU3TTcyYzlTcjluVzBNRHA4UHdzTFJSTEJTVGhlVlZTd0drTnNX?=
 =?utf-8?B?RWppZ2JvOERUNUNGOTYrK0lEc0Z2WU8va2hoVTgrWXEyYXRMbTN4b3BZTFF1?=
 =?utf-8?Q?bLYcuJ3iGC9gpaYY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3159ca62-6090-43c9-f08d-08de68582c98
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 03:55:05.2272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcrOuizEpzJpUGFn4ss5HBtZk14JlOViY8pa1V8ZQlDyNv3/+4Lo1EPxJxirtXg5/gv/cHZUMR9bf5iewT75V4v5mRhcEA0Fxn40Hmy4SMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8349
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


On 1/2/2026 11:13 pm, Tanmay Kathpalia wrote:
> Replace underscores with hyphens in the PHY timing configuration
> property names to follow standard devicetree naming conventions:
> - phy-gate-lpbk_ctrl-delay-sd-ds -> phy-gate-lpbk-ctrl-delay-sd-ds
> - phy-gate-lpbk_ctrl-delay-sd-hs -> phy-gate-lpbk-ctrl-delay-sd-hs
>
> Signed-off-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> index 5a7aa5841e3..b443e57b1cd 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -119,13 +119,13 @@
>   
>   	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
>   	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
> -	cdns,phy-gate-lpbk_ctrl-delay-sd-ds = <0x81a40040>;
> +	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
>   	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
>   	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
>   
>   	/* SD card high speed and UHS-I SDR25 mode timing configuration */
>   	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
> -	cdns,phy-gate-lpbk_ctrl-delay-sd-hs = <0x81a40040>;
> +	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
>   	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
>   	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
>   	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;

Acked-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, Tien 
Fong
