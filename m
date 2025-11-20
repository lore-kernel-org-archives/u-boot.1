Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F83DCF8860
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 14:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E2C84067;
	Thu, 20 Nov 2025 15:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BzUqPJ98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445A584068; Thu, 20 Nov 2025 15:59:39 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3571283EAF
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7HceQ+gpEtLY63TESWiE27Ek/GkIkhL+R5HNecy6m0SNwObDldGys+qY3r1jqMGzVbmTvTM13IS9TK3hNG2GEZ/JufesS5cYnIq/cbk/oAXTHA0LpshofXsA4VR+wHCPTU4WJegPzcJEKfOzD/77Sdh00XjQLYwBMwLXHfLxDTkchR652SqSjLb8SqK5C/9KiVEF/r+iD9wxVCsixhRFdhJGSI2+FuYm/Hktvfb4K0vl1jWvbTLEdiLzt7AOdl0VqcBfMOpr+yvezRSTGABh1Sh+/DqG2E0Ee7HRMDEaHcq4rvoo3sOiV3NW+rxcPVgHUX79tP7AIRJUj7TLq93RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0CRqUDJmy/OOgwJ/fREFOqXT/cd/8SM+bbevJPY8KY=;
 b=o/qZKNv7cWBW1CT6XmBBvS0E+aIXLUWOsUwc8g97Dt567YMqgwiLxB0zEZmfTtCcfGe+rnbAzimibGKAkaVTvY5r4+2CZyriNxXo0D3W7WDsqbGf0spO93M8jrHkmjEyOA3P6haJtIxjyBGvEmNdAvNNQsexZNHvGMH9jkpYOhNzK9SJWiOhuWRITQARmtTeyGoNjbiP0PyXKupG2CoyZqfth9i5muQKOk+uIjDxAa0nvYVF0GKxSu1vCgW+HJbqO35qEDJOqEEpLBg3TBUW68afbbpFw24nzanu+hqljUeePw5bERgBkquZ6fLJv7V90cJ9ioe6IGteInxy26Ek9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0CRqUDJmy/OOgwJ/fREFOqXT/cd/8SM+bbevJPY8KY=;
 b=BzUqPJ98it2iGapZJaOESSb32KEOFsVwTAztNQTJSnVRVdGnYyq49eL2tXieaJMmywLkQ1FgUL3tED0OOpkcHIqaH6g2PopCCOHi8RGc45ka+mMcuawsPXgsR3U+gd1wuuyuZ4jnP9AhrwPu+OZIsq1vohUnjPeU53q8qZZRaI8rHZq2ykdQST9iaBebj05jZktLQlUwACimb84Rj5s4Bp1VcUNZJH6HDRiiSoNqSwmZPVlzyzrJzhFD8Uko+Ig+0J/PzsMkQXrQKlHYu6UvucE5IJgVBYCBY9Pua4tUM7vQcZoD1xJNw8zGR0rScH5VGEgKMBkbn5rzI8uc7SWV1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MW4PR03MB6866.namprd03.prod.outlook.com (2603:10b6:303:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 14:59:20 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 14:59:20 +0000
Message-ID: <3668b44b-9525-4bad-8d24-de10311a4df3@altera.com>
Date: Thu, 20 Nov 2025 20:29:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mmc: sdhci-cadence: Add reset control support
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-2-tanmay.kathpalia@altera.com>
 <aRv_hIwxZshKJQI1@nxa18884-linux>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <aRv_hIwxZshKJQI1@nxa18884-linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::8) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MW4PR03MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: a21aaa00-0308-446d-41b6-08de28456209
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm9Ga2N4eVpaZmlOT01lRklQcHJRSWpCMjIwa3VKNUJyeW95OHRPa2FOOGpm?=
 =?utf-8?B?cW5oaVZTZFFMaUx1OTZhVEMzaHIvWFBMdlB6bnpkSm9XRlJUdGYzaWNPOEQ3?=
 =?utf-8?B?TEVtMVFZbUlNRFpaYktrdlVpMGI0ZUIvY3Myb0x1RHZFT1l5ekVWZ2VCa0tp?=
 =?utf-8?B?ZnZXN1ZhUjZhVkRLYk8vZXI1MStlNlVrVDlGK1JHK3JDbDRCV01yd3hGU1Vh?=
 =?utf-8?B?MjVKSTcrd1JjcTdKdWdiWTJveHNsRDJtL1pVN3hCaEZNZXRuUHVvZUdWTDFZ?=
 =?utf-8?B?Q2VFd0kwT2VkMGEvTUlReDc3VUxTM292N01BbmNHeEkvNUlydWlxSWxlZ0NI?=
 =?utf-8?B?cjI4emkzLzhUaTUvQWxxYkFaSVVqTG85bWhMWmZWWERDOE12TjRvMzVEVzZr?=
 =?utf-8?B?QUhaN2NHNWE1RFhmNkNCRi9sVVBLTTV0N0lYMGhuMDRRdFo3L2wwdEZtNDIy?=
 =?utf-8?B?aGVWZHdNeENWSEFLWUZFdm44V09RL0FBRUhFSDRyRjFnMkdwOWVadk42Mysy?=
 =?utf-8?B?bTZRdmZEM2NPckVGRzdCVHNRTnV6YzBqbDNDYTRvTWxYOEhrVCswZHhzbk1S?=
 =?utf-8?B?WHpOd3c1SUxGWmdyUnZ5UDA1QlpmUDMwZ1lCYzJYUFRGZXgrVGc5M2VidHNm?=
 =?utf-8?B?eTd4Y3piWGdUS3ZXS0dFOUwxVXI4b05XTWJSbU1KWjFlTTM1T01JKzRMZTB3?=
 =?utf-8?B?OEZCVjNNS0tYVlI3OEJpbk42azUwMHdVdnBwQlNzeDlTSktOWUtxclJ5K1J4?=
 =?utf-8?B?a2NvMmpseUtiUUl4S3FPeTBsenNic0h6YmlwejcwblNhRFJORVhUTlBBVUgv?=
 =?utf-8?B?Nm9zdnF4RXhCR1kzYklqRDhLUW9XUitwMUVDR2prRnBFUTg3blA0SDk1Zy8z?=
 =?utf-8?B?UFdTVGZCYVVaUnJUdS9LdUw5QTNmU1Y5NS9RczhwS1pnSUNkQSt2Vng0YmtK?=
 =?utf-8?B?aExJREwzWHBSU0thRy95VUlPajFBRS81WVpONHhESTluOFdtTldqb3BEaTVs?=
 =?utf-8?B?aWU0bStpUnRDaFZWYS9BSlRaL2VqbE50L0VWZk44aC9mTWd6NXluWnhoYks1?=
 =?utf-8?B?dmVzRURidWpXYzdLWDFGTEYraWNGS1V5cStNa3pwN3RnVURoMldxbXhFaFJE?=
 =?utf-8?B?U1NBSkFXUHk3MTdHU1M3OUtBc3U5bUp5d1RkSWxraUFPdVRMQ1ovOFJnSmRk?=
 =?utf-8?B?OFptR204c1pZbEMwTFMvS3VmVy8wR1oxQzBNUE9PWlhoUk5WV1JGTDVsZUht?=
 =?utf-8?B?Q0dZK2Q1aElyVG90Um1XTDJyYW12cG4vTFFlRCtTTHVDQS91ek96WVd4OHVO?=
 =?utf-8?B?L2NmaU5yK01QNE5CQ2hTdXdyUXJHRDMyK2ZOckgxVVpEcC85NEE4cisxVjFi?=
 =?utf-8?B?Z0lrQVJGZCtwTnVWZ0FHNTZmRHRyZ2YvUTdSOFhTb1h3K1FrbzgvQ3QwSHBV?=
 =?utf-8?B?SHd6VVgyUENQMThNMmhvZ3lLZG5IeVZUR1ZtRDFPbFY4bzVORFVzdkR5MThw?=
 =?utf-8?B?YVBhZVVOdDFTUTNRVFJUbVlBbFIyRkhBS2hTa3lNUGdGdXYwdE9YeEp2VzdG?=
 =?utf-8?B?YzRhVWF1Mi8xQk82TGhBOC9oUEZZZlhra2ZRNmtvTHM1N0p4ZnhQMUE2b2N6?=
 =?utf-8?B?SWtFVXhVdTNSNHVLa2NHbkVGOVI2N1JTdGxjUnhMNnFJSFlNMEhUMUc0NGFa?=
 =?utf-8?B?Tm9hNm5qS1k0UFQwTU9icDR6dG43NExwRGVXY3BtQmlIS25hWjNjdWs2NXRI?=
 =?utf-8?B?bGhabzNCYkh4UmExTGdJVFNvcVhpK2IxQ2QzZTdVWFZsUFRXcG56V0ttb0FE?=
 =?utf-8?B?RDV0VTRzVTZ5N3M5ZEczeXlnd2Q3V2ZxbTFNSXliNTZRR2x2NGpleDF1Vnh4?=
 =?utf-8?B?b2VBclFlNGtqWktGWjNhMGFEZnR5QzBOUlJDTVJwM3dvVUdZdG8wNm5TUkRR?=
 =?utf-8?Q?jMR8JF9BKz+f/lZCWmx6HjuObq3LNkp7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVBoNHJzemtFZXFheWJzTTR5a3dDM2FyWnlWR1lEbUJvbHBGQnc3VzJuNEU1?=
 =?utf-8?B?cWJROTB4bXAzcTNpZ2hJdzJXT1cra043aG9oTE1OL2VlcW54ckNXU3JTK1Nw?=
 =?utf-8?B?TDBHYW1nSjM4SjlsTEFkbVNYS01qRkxZVk1YemRFV1E2N3UzeXZsbGFCT3lR?=
 =?utf-8?B?SHFZMVJOUGJNdW9tUFRqR3N0a0FlTzAxaDVwcXlBVU1sTzRjek1Obi9ORnBn?=
 =?utf-8?B?TkdiN1p1eEt6eUxSQko4QTVjUDJHdlE0T1hWUmZFc25xMkhjbzBFUS9HdWN0?=
 =?utf-8?B?N0pHQUFVOEZ4SDRWa2xLZlpGQm0vcjhpYWREZ0d0TVE3WTduaTRYbExRTXZY?=
 =?utf-8?B?NjVDbFJxUkhtSUxlMFNCSkdra2VIdTNwZ25pKzZ5L1VBSk1pR0FIdzBqZjU1?=
 =?utf-8?B?NEpsY1BhdXZqZHE0ZldWb21Qb0hmclA1L1E0NHRRbHBQYldtNUFNYkVKVzUv?=
 =?utf-8?B?T25CRVZyNndTOGZZbXUzZmREeUl3K0xEbWJlU1dVbWVRVlZQK3pVVW9uWGt2?=
 =?utf-8?B?TUl5RkZ4T0d2VGFvc1RQTDRMb0R2dXg4OStXS095Y3RIeWJ6Zm1qZjZiWmhJ?=
 =?utf-8?B?OHlyblpSTFRBMTNBc3gvMXZQTUpZUlQ3a29ONG51bnBTUXZiVjhKWCtrblpv?=
 =?utf-8?B?amlEbHdDWkxJd3JBOCtCRkZ4R3lNRDZhQzRNTFowdG9BMWVnYURVRzJpTUov?=
 =?utf-8?B?c2FuSjdQZmhramZOVjFZQXZ2NlZBdWFDTlBUSmlrcVloLy8rSFBVVFNMaGli?=
 =?utf-8?B?dGlZOTU4YWFoaGY5QVZ6R0NJSlFCaVJGSlU0NWFKRytCSGtZU24rRjZoS3FH?=
 =?utf-8?B?Y3ZoLzExejV1K2p4MFZiY2t1TUJNbVdHb01GTGNiaDdicllyLzNOM0gveEdO?=
 =?utf-8?B?NjdFMUNiMHQ3RHY1MlJHK3l3cDVDVWh5S29iY0ZUei9YOHFYUG9Da2t1anRW?=
 =?utf-8?B?bTk3VlVOcFZrOTlqTFNtYjdrSCtSSE9IUktzRkhCeTE1dThlSDRmMTBhUnp4?=
 =?utf-8?B?bVJRaERnaVFYVTZRSkdPYUZkMi9DZ3JkZWxoL3U3eEdiU3RTYmdNVnpacGVz?=
 =?utf-8?B?cktWN2ZhRk1qNXgwY0JUNEI3U3cwWmN6QWdhYUJHQkU0Z21HcWF1clBVYm5K?=
 =?utf-8?B?ZUp4bFFJR1B0TDZMeVd6KzBDaGRnV2Vub0dLQ0g1anNNY3RzSkxhT3hKUlcx?=
 =?utf-8?B?ZFUvT1Y1Y1NXaEM3K25UM0phR1lnaTF1dEM2cTBMUG1hWG5HMWFkamt4Zmw1?=
 =?utf-8?B?dzliaS9ER0loRHM5UStYL3BmbDRoaFg4bFRVN09WVUp0VEZDWGVDaGRmK1h2?=
 =?utf-8?B?M1ZINzVtWW5EM3pWUmQvMUYyRnhEMTI5SlgyZGZZRzRHUXNMcm5OZ0NBSXcw?=
 =?utf-8?B?YlV0V1RKb09nUWM1NVJGVmRWU2p4a3lFTFM1N0tYRDRPT2pIcjF1NHllTUNC?=
 =?utf-8?B?ZHpESGFzNVR0RHUzTFRuemF0TW5HZTM1K2xySHVQblEvQVg2UHlTa2Uxckhp?=
 =?utf-8?B?MmtoMm5ZL0ZqazZjVWZJYmdSUDhVVXgrTDVmdDhPRHYwNWtkdmJOKzhCVjZw?=
 =?utf-8?B?MnMxMXk2RGJReThFNlpqVUgwSmNseFppdE5RNFQvam82QVBUd3BiNVZQUWFp?=
 =?utf-8?B?TzBTR2wvY3FOeFcxT2F3NmRsU2hmTGV3QkRFa3JsWVVRaTk3UlNtckRIMkVZ?=
 =?utf-8?B?WGxoczlGSXBrTUc4U2pxa3NiVXRuQ0NyMGdJd2k3aEQxTlRDTitnNStmdkJQ?=
 =?utf-8?B?ZXM4c0RIeTF1eDVYNmI0WVI4RnlHZGFyYnRRSzRvek5pa3p1THV1QkF2WUt3?=
 =?utf-8?B?V2w4R2lZaFpSdXdEKzNCYnEramlrRU84cG0vTkNmYW1xZ3ZTMlZBTDhkS2tP?=
 =?utf-8?B?OVQrT3N0bUlKRE1McERxSmFhSy9oekRBUkJaMzc0VUxlcUI0QURRSm1hVHcx?=
 =?utf-8?B?RXhJbEJDTUFtTHVybHdsVk53TnR0TjBDSWtrc3RlR0M2K3V4Qm1nazZNK0Rv?=
 =?utf-8?B?RG1XZ2xPNzFJUVpieCs1d2dKSkx2cmhPUW9Za1RZWkRpV3A5RHFPVzlvbVMv?=
 =?utf-8?B?MElwNWEydVFjVE1RWFhHTU5JUlMyamZLd1pBRTB2SFZCeUZWVDE5WGhYdXFD?=
 =?utf-8?B?UTd0YjEvUzVmNGdOc21SVnZwSllsSTN4OEdzVWk4eFJYcVRVaDZVa0E4VnRa?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21aaa00-0308-446d-41b6-08de28456209
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:59:20.0147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4w1uTy06kXfwxLSokF5ryxwVcIF8CeMvpvYGgK+ty+qcFOWzzMrs4KCDurWLuBjUaMZxC5cbSqNTXk3ZzrUJreRS4M7HflSqte7x/byk3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6866
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

Thanks for your comment, Peng.

On 11/18/2025 10:39 AM, Peng Fan wrote:
> On Mon, Nov 10, 2025 at 09:37:30AM -0800, Tanmay Kathpalia wrote:
>> Add reset control functionality to the SDHCI Cadence driver to properly
>> handle hardware reset sequences during probe. This ensures the controller
>> is in a known state before initialization.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
>> ---
>> drivers/mmc/sdhci-cadence.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>
> ....
>>
>> @@ -225,6 +227,12 @@ static int sdhci_cdns_probe(struct udevice *dev)
>> 	if (!plat->hrs_addr)
>> 		return -ENOMEM;
>>
>> +	ret = reset_get_bulk(dev, &reset_bulk);
> 
> Should this be optional? Some in tree platforms may not have
> the reset supported.
> 

Yes, you're right-some in-tree platforms may not have reset support. In 
those cases, the code will print a warning message ("Can't get reset") 
and continue the probe process.
If you prefer, I can remove the warning and let the function fail 
silently instead, or is there any other way you would suggest to make 
this optional?

> Regards
> Peng

