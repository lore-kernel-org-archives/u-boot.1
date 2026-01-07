Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FAECF6BE1
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE4948400F;
	Wed,  7 Jan 2026 01:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="nGC7QfHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9183C8401F; Wed,  7 Jan 2026 01:35:18 +0100 (CET)
Received: from ps83.spcmail.jp (ps83.spcmail.jp [35.75.198.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 341DF83C4B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from ip-10-10-28-85.ap-northeast-1.compute.internal (localhost
 [127.0.0.1])
 by ncs82.cs.local (8.18.1/8.17.2) with SMTP id 6070ZC9t317297;
 Wed, 7 Jan 2026 09:35:13 +0900
Received: from ip-10-10-28-82.ap-northeast-1.compute.internal (localhost
 [127.0.0.1])
 by nmg81.cs.local (Postfix) with SMTP id 4dm8FX6LqNzMpsff;
 Wed, 07 Jan 2026 09:35:12 +0900 (JST)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010024.outbound.protection.outlook.com [52.101.229.24])
 by npr83.cs.local (Postfix) with ESMTPS id 4dm8FJ2FP3z3kMcY;
 Wed, 07 Jan 2026 09:35:00 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz5sd8vjn4TnxD5bN2ZleCfZstIuXQJkKzSZTUGX7mPFBPwwavgzTE6uSoMlJHxj1XWd1/Hztxmq+te3GtrVcTrKgRZnsIA4KZMBi46sNkuGM5hhdQnJy+bcBRFOM14ZMwOmT5iJ8kdJPveB184++B5bFmCTKhoLrO4ejV6qvKvHtWASIY2CLlBH4OG/Z1MarbpJWEIlXzTQWaSYY20bOECeNJQ3Bg+FzB8Ot3khFpNsi7sMLuSLegRcXrPSAt1UUS7JulTnlS/I+t+KbA6s2XrhPObRjh9mmjdeWCTjYxWRAfiKTcpu0vrw2VkPnRHWem9O7N19MkJ+ABWGJX3m4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoiAxhGWxy9piRv+Pj2S+NKBfMsx1homt/0a4hl4368=;
 b=ZjsMomviI9COXPM8pbZ4gMyZuwDE+czyqKySvBUe2/OKt69gIJpSb8ahyF0zg5HdaZecqnfryxy5sW5UKO/mJXHthRvm949U7xkPuyxfnQmIDvMy399gbOnre+F3UTUCqT3/VHniK7JZ4PbVZowhGHhuJefLuimA+U+6rMDYdoxtwI4/22DyR5+JOMflihWHl3RaM8zyRxTqp2yEsnepHz2SlKBSkkX40L/kSJZt1ZTPQ02EzpCcuHxWbdsJvChfB+e2ln9rp24L1fyW7G318PF2aYnJ8Pw+T6qtUx2TQW4V3sCsTaVw8a+8QzDZd+lmhThVyksGoF046ZlkzhGWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoiAxhGWxy9piRv+Pj2S+NKBfMsx1homt/0a4hl4368=;
 b=nGC7QfHUOrwTVAlzzCTe2K5mkzVIRO6F43ZJV8Q5UTNxvMY4U6CFZA5JE0IMSc4fCU3kf1rOpyeTrUNLhsAmqWi6YYAHKoioIP60h/FrXfYsl872IJEpb17InmkHPV4/VYbcV6u5pwahnkQgDRl9awb8NvM+az7TwZIDn+QeKgs=
Received: from TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:289::11)
 by OSCP286MB5830.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 00:34:58 +0000
Received: from TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72bb:904a:5ff4:ffa2]) by TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72bb:904a:5ff4:ffa2%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 00:34:58 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH] bootm: fix boot failure from compressed image for
 IH_OS_EFI
Thread-Topic: [PATCH] bootm: fix boot failure from compressed image for
 IH_OS_EFI
Thread-Index: AQHcWsKjUhHjG3Yy9EagI2hYvVJ5vbUIAHsAgCu/IACAEmI8cA==
Date: Wed, 7 Jan 2026 00:34:58 +0000
Message-ID: <TY4P286MB56414901328FABBD084BCD36E384A@TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM>
References: <20251120233851.2726487-1-kojima.masahisa@socionext.com>
 <b60d74a5-8085-4c6a-ad90-bf59dc41e37f@gmx.de>
 <b7e755f4-2925-4400-9efd-7cb8ca781847@socionext.com>
 <dac913bb-b8f5-46e4-b729-3387bc8988f1@socionext.com>
In-Reply-To: <dac913bb-b8f5-46e4-b729-3387bc8988f1@socionext.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4P286MB5641:EE_|OSCP286MB5830:EE_
x-ms-office365-filtering-correlation-id: bb5284bb-42ab-4b29-a559-08de4d849625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UEd5czE2cmFEMXRpS3o2bmRYbklyUGF3TjdvR3NENEo4MnJFU0poTEhYYzdw?=
 =?utf-8?B?aFI5TnB5eHFheG1pbDgrNEEzeUFZUDZ5MVdtZkJ4S2hOQU9iVmhmM3owTDN3?=
 =?utf-8?B?V3E3d2Fhd3pYc3l6d21JeUt5T0Z2UnYrdTBDS2lUVkQwbnRwWnRuRkJHL1A1?=
 =?utf-8?B?eVhHekdBeXNWOTZRSDloL1J1YVJoRFMvMCtxMWNKL20wTm5NNVpyR2J3Qldn?=
 =?utf-8?B?RmZnS2ZmZlQyVHJsbXljSUYwYmRkaHZkdklxWFJVUndqV1ZxTmIxRVFqSEFu?=
 =?utf-8?B?ME1Ya0pONE8vV2EwVDlTeXpJZ2ZyL1lnZnJVYklocG9RQ05VTkI0Z25uWUh4?=
 =?utf-8?B?RDcrQ2hTMThlMmhKTWVKenBoVkZYRHRObnpKdCtxQ0RnMnRBSDQrS1RRdVky?=
 =?utf-8?B?U2tSUWgrNmQ4b3lMK2lSUVZ5Q204dXM5VDkwTEh3UERZZDJ4M3FPT1NDRExs?=
 =?utf-8?B?dUNEb05qN2RrS2U2SXByU3dVemZVdFdhY0hXblpQODVYZ1g1TFpScEo5Q2Q5?=
 =?utf-8?B?WTd6S2tTbVVybVh4Kzc2UU1ZRE90TnpETzVScVVhaHNXK0JGWmV5VHNsclU5?=
 =?utf-8?B?VE1yL1pZWjQ2aWxnbHJRVVVDVCtWMjFkTHRtSnFIcUttTCsxYWd0WDczYmpC?=
 =?utf-8?B?b3dQd21yNm1QZGR3SlZ1ZmFZNHVhWjBMNFdSck5LWlVEbms4alBHN3U3SUVN?=
 =?utf-8?B?cnpLZ1JlVityaTR4RGI2bGk5bnZ0VWFyL1RKMkJoTHYzSDc2M0JJU1FZdm5a?=
 =?utf-8?B?TXM3N3JWcncrdS92OGJuUHo5UDJYcWxwSVZnTkF5Z2RXa2lPU0FEczZJUHFH?=
 =?utf-8?B?a1I0WjA2OVF2RmIwY0lBUWgveEdRQlFtRm9kVFFhbDFHTFZ4T0pwa0pKME9h?=
 =?utf-8?B?T0lrVmVramplL0YwQ3JJVHptdUVnYzd0L3RCM3oycUcvZXlNdVZJbGhEUFFr?=
 =?utf-8?B?Q2xoTEF5NmZSK2lkdlpZa21qNGFCRUtYWXc0ZkYrZXA4K05NTVFIM0g2S3pr?=
 =?utf-8?B?dXdMaS85NndGQldDSS9KUWZkYUw0bHB4VU5haE9PNk5aeXNCZlZGNEJpbS84?=
 =?utf-8?B?ek5VUG9TUU1YenhGSjdVOVVnWUpFck9MSTd1RXZEaFBURVZlclRERmI3cmtD?=
 =?utf-8?B?bWx6a1pXUnVIeDA1UUFkcHFudWp5N1RkYXBWOHZ4di9vaS9OV1Rkbjd4VlBa?=
 =?utf-8?B?MGxscXBHZHpnYjV4NU1XUmEyZE8vYUZSek5qL0xnTmZMRWtycnIzZG9DZGZz?=
 =?utf-8?B?QVliMG0xY3R2c1lkSTE0UzFOVnBScElTcGxYbDdhMkxDMVZjbjlJU2pDWmx0?=
 =?utf-8?B?ZVY3c3VGeSthZjAxUDJQaXBuV252S0xYWlB0Tm5PYjNZZ05GNTFvaGxibzdO?=
 =?utf-8?B?VE9sZ29xZU51eVo5S1VKSndseWFvOGd2THhzTTlwKzNwZ1E2MmhoM1RlRjVU?=
 =?utf-8?B?V3ZhTjFsbUJrVzBVQXdiMnk0ODgzUGM3a2x4b1N0L1R5Qi9VNFN0Qk5CVHh1?=
 =?utf-8?B?UGxUUmJZbndDNTF0NXlaNDVEQjdlbDZUZWV4MlRsdUR0YnoxVlpxS3V6dm5w?=
 =?utf-8?B?cDk2N2llQ3pDNDRXNnBkem5WaEwxdHNkc2Z4S0FTWlNvc0tXV0gzUU95ZFhw?=
 =?utf-8?B?ekQzSmNrV3A1NnhzT2E0QUdzMk9HdjFpQkZPeC9NVGVST3RVVFMvNTlVVmcx?=
 =?utf-8?B?SGIxSk9wZjJkakUrNUw5NHYyRHpDOXNVS29wU01iZEJqMlU2YW9XNEVGZ0dP?=
 =?utf-8?B?aFRPaExlQXByZzd0L3hMVWVWVG5wdXJ2aDhUdXRIREVWeklIdG5GU003Z1ZH?=
 =?utf-8?B?TnJMakRPSHNCdnRFS0pZVTh2N0hKd2V3b2tiWTJZWFVFVkM4LzlLOEZKUVlP?=
 =?utf-8?B?YUZ0N21EcFNSMytESG5zVE9SdHBGZ3Q0UnoyaTNtakJZSi9Icnc0TVI4VnRU?=
 =?utf-8?B?a284Q0hPak9pTjd4bVVkZUlPUFZYNm9YQitoM0hJT1lCRFZoSFFiOXV3RkRY?=
 =?utf-8?B?RTYzQnlsSGhvdVZKSTVEcVAyWkpBMzk5dGVrM2pYSWRxNml2MiszWVhYQkx5?=
 =?utf-8?B?MnYrSXM2REFjQ01BZ1REekJWZDlLbkxiS1dnZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2VGLzZiVStLS2lnbHFrVVhONFVabGM4Nm5sa291RUxlcjNPT3YyUU5MbUVt?=
 =?utf-8?B?SHF6VSswNWdZWVViOHdQaW1jb1VWZ1piWitzUWVZWjZFM0lHa0NxRWZTNUUw?=
 =?utf-8?B?WnBTb1g1anVxazFOL3lPc3RDcERMRUgrTjI2akk3VlNhQzhkRHI2K2p4cXBQ?=
 =?utf-8?B?M2wyNGFscUhJTEdSTWlyN09Tc1ZZS3lDM1p5TXJ4T1h1Q0xqNUQvUy9JWnFZ?=
 =?utf-8?B?eGNSdDFUSU1ZMGwzV0s4a1hqZ2VidkYwdHJzM2I4V3cyRldBcTlmeTcwUjFa?=
 =?utf-8?B?ZGVxTGlVOUF3RG0xNStad2M5QUttQmxqcVhJU0NsM25XZWNHT3ZDUVpvZ2NF?=
 =?utf-8?B?YTZaQnFjRlhNVEpOUFQxZEZ2d3owUmNWU2daeTFqOHFHazJtLzF5cmFGV0lG?=
 =?utf-8?B?ZUkxbWM0bXV4V1VTN05uQ1h2REw5MmFRZ1FiRStCZjEvb0h2VVVzcXJhSitE?=
 =?utf-8?B?enNtOUN0UlJwQ3RXTS9NY210TExpZ0p4b2RYdXYwVU9JZFRrYjJwQnI1Y09C?=
 =?utf-8?B?TTVVdkNzUnRkS0ZwaFk2bUtvRjcrTjdlbkpOaVJEcERrci9Ia1ZuU2dZcVFk?=
 =?utf-8?B?Z3lYZ1k3Ny9hUnBsWDNwNEVRUzRzWTlHbWoxMTBXRG5hM2JFZ0ZSWlpKc203?=
 =?utf-8?B?Qm1BR2FHTTErcytlTXA2YUVMYkZsMlR2QTJZcWtub1RQUWxNTzdqN2xjZlJD?=
 =?utf-8?B?NUJwM2ZBOWRpMEM4UW5aYTdSbUZkWjB2azdjL3Jqcmp5OVhvZ2JrYkNJQ2Rm?=
 =?utf-8?B?WnZTREp5ZmV4cEcwVUtyQU1aTHN1eXhIVjZVVmtIcVh2WWRRQXFZMmxFZ3VV?=
 =?utf-8?B?WmhqL3p4OUVrK3JaOElsNnlsSlN6MUhsZkVKdGU2aEZZQzRwZHJJWkVBTnFl?=
 =?utf-8?B?YTFXMzZRSWtFTU5mazQwZnZ6b1lraDcrL3pXWU1xN29ML2NOZUlxeWNNL1ln?=
 =?utf-8?B?T1YyUXJXRytCamlKemQvR0xGaWVWWVg4UUhRVEkzc0Z0ek1ONEF4SncySldz?=
 =?utf-8?B?YUpTTGZWdW9YcmpGeWFzRnZod0ZxU1pWbkw5VzhMcHBFdG8wbFRYK01qakJO?=
 =?utf-8?B?Q0JCcGQ3TW9MVEN2cUtBYkt1Q3Iza0lzWEFLTVh0eEhQb255OTJqWGhQRWtR?=
 =?utf-8?B?bUUrMVBSVGpoa3hMUS9pcERLa01QejlrVDc2UGxMOVZoaDdwT2pPeTBxVHJj?=
 =?utf-8?B?VHdyNENTbU5Ja3BiT3ZsVUJKTFljbTV1QTJYVmJPR0RLZlJyNTlLWjlob2Fi?=
 =?utf-8?B?WDRpT1dqeVhPOUZ6WDlNZ0tyQzZTcUgyS1J2MENlMWtjYkp4VjA4WUpmV29a?=
 =?utf-8?B?akdjVyt1M2lsdzlzc0V2TDhET1UyYlJUcG9QVlVBZ0w3YmJGQlE3a1F0dDhZ?=
 =?utf-8?B?TzBoRkI5Y0xPQ1RxT3dFTkhHZUtPNXEzeWFYWUFGdmNQT29ndVZaTGhQZ3BC?=
 =?utf-8?B?Y29KbzFzblhCbi9HZXBlVTE2bjhhd1JSNmpsRzdVYTI1eEFrSGpuY1FDZ0Nr?=
 =?utf-8?B?T3V6MEkwekQ0a0pTZDJZQkhZTU9uUkNVc1Z6b1hkb2dYbFFITHFXb2libDkv?=
 =?utf-8?B?V2NZNUx1aVVpZS9QNlFOanF0RXN0bTBHK2JFd3RqYUpRekVQNmlFcGp4MFZ0?=
 =?utf-8?B?YzNyMTIxZEc0eUttVTJxSlhGMUZMRDFOU2t2SHlWb2hpam1maXBjS09HZzNx?=
 =?utf-8?B?bFl0Z3dGUmV6RW9aSDBVbXdVbUdDcGZIWEtkTms1NmtBZkpOQzJXZ3hmRmVZ?=
 =?utf-8?B?SkdrVDJvbkROcjBmczdQcUU1aVA0VlR0a0ZOQnpkTEpQMGJVaVMxQlM2YjEr?=
 =?utf-8?B?dG42K0dlZ2tZMENucmVManErNEZqV1RhMjBkTE1ISVdMNmJ6UDlreUxtQm83?=
 =?utf-8?B?K3hyOGw4R2d1OFdiSVN5WXFwOTJvVlpVS0VHTDNYcVZ4VnBtbUdhYjlsbzV3?=
 =?utf-8?B?V1VmSUl2Z0ZMeFp4UXZQdVJiZ0NUbFJPNkE0cHl6ajNDVjk3eGZQYVcyRUho?=
 =?utf-8?B?MFFvcGY1MUxwY3BpVXFLWnhjb3hJeTcrYXc4dFBycmhzYVVlRzdHaENvNUV5?=
 =?utf-8?B?d0lyblBpUjh6WDN4UlA2VU1vcElmZ2prVS9VNjlJQzg2eklIclNqVStNNzB2?=
 =?utf-8?B?M0hYNFFSZ1hVTVRyYVF6NG5TVlZCSFVUZmVDejdMZ3YxMFN1cHNNa0VJY3ls?=
 =?utf-8?B?bWIwUDFFZ053WCsvVlIxMmU1LzRqaGNwQkFtWlp0OVRsVXAvVzBkZU9McDNR?=
 =?utf-8?B?K0RaWGUzeEtFcGM4VWtaTWs4RW0vcUF5NmZGR2I2QWJPNXVMbXRTOFpBeXVR?=
 =?utf-8?B?Tzlid1FhOWpObk5tdUE2VnEzbnd1ZjBrTU5jWGFMOTU2NVR0SnNuMzNmRlJE?=
 =?utf-8?Q?hAx7S8k3vJllQrq4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qEJNMWpeRl7l6QhSXFdla3GHc+BNiGADAc/D+vTuV8nDcE2bRzFR97nKCA3ZFutpPuXY1liwAMQ6KxS9YjedqlicSynuqBQWQCBR83hnBEveqXmNzMPB1ayAe3CyjLDf8bpsAUDTmcv572d5WQjPZu8vwjdo5IT5+bDT+10PhobmZ+b8shYYq0sFbikaORWPf8zH8j+pVTiX3UXcc5gwN44DS4wvA/dtZ/5W6m2JZtNoWZSXSlkAHbP/FRfxyyRV0cWgP+6AOM03kAtcISuCXEmJi+Ed4F8RC3BSclJ5FWM0VLvCI8Uz+3bv8K/MWxeeQ6/SAOC/pSqCS60QTXM3Fg7KXwzZF1eBbkqqoxpnNmW2tIYGYoussVyaUWjGMbhqUMht20meHOJU3Sn9mnEA/kWm+dwGot6S6LHbPzgnQSd/oIMRCDFrOwRbsE+2Jl6YxJwEImMyMwJdEmvNIcuroCiYBNKsywhVOlAxsI6PdEWNIYHXov7WApwMfTYX0JXivNcbJIM8Bi5KRkhMNJw26Efe3h1vm1GuwvkWFG+BhNAWYLvLfgzrKCThdb0udbdgc0vLmVWC8nshAqgXiRvwWtVKLbFxG1DGU1RSsKuht4/9vz3L0AV+cYjLJGxj6YkvZ0CUK7AvIM0goTa8v00Bo+mMQR2f2q6e6cY/0vJHRivsuCOsGgJoRECqWptknw2UdqyTLU4NhAu1lPaCkv6DSVpZXWjXg23xGMvitS7ZETqVDSTI4Q0zxHND1bVvvGGw
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5284bb-42ab-4b29-a559-08de4d849625
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 00:34:58.3060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyS0CF4dsRSnVFkdWnApKUjquDxfuoTkbgxIOD/WKTBSmSkBtvXqzJ/sO4TRBRaZ7l13rBq2bQron4HlOOSQvvhlXAhJZc5D43WUEahCwNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5830
X-CC-Mail-RelayStamp: CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To: <hayashi.kunihiko@socionext.com>, <u-boot@lists.denx.de>,
 <xypron.glpk@gmx.de>
Cc: <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <morimoto.masashi@socionext.com>
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

SGkgSGVpbnJpY2gsIEt1bmloaWtvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEt1bmloaWtvIEhheWFzaGkgPGhheWFzaGkua3VuaWhpa29Ac29jaW9uZXh0LmNvbT4N
Cj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAyNiwgMjAyNSA0OjM4IFBNDQo+IFRvOiB1LWJvb3RA
bGlzdHMuZGVueC5kZTsgSGVpbnJpY2ggU2NodWNoYXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPg0K
PiBDYzogS29qaW1hLCBNYXNhaGlzYS/lsI/ls7Yg6ZuF5LmFIDxrb2ppbWEubWFzYWhpc2FAc29j
aW9uZXh0LmNvbT47IElsaWFzDQo+IEFwYWxvZGltYXMgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJv
Lm9yZz47IFNpbW9uIEdsYXNzDQo+IDxzamdAY2hyb21pdW0ub3JnPjsgTW9yaW1vdG8sIE1hc2Fz
aGkv5qOu5pysIOecn+WPsg0KPiA8bW9yaW1vdG8ubWFzYXNoaUBzb2Npb25leHQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBib290bTogZml4IGJvb3QgZmFpbHVyZSBmcm9tIGNvbXByZXNz
ZWQgaW1hZ2UgZm9yDQo+IElIX09TX0VGSQ0KPiANCj4gT24gMjAyNS8xMS8yOCAyMDozNCwgS3Vu
aWhpa28gSGF5YXNoaSB3cm90ZToNCj4gPiBIaSBIZWlucmljaCwNCj4gPg0KPiA+IE9uIDIwMjUv
MTEvMjEgMTc6NDEsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+ID4+IE9uIDExLzIxLzI1
IDAwOjM4LCBNYXNhaGlzYSBLb2ppbWEgd3JvdGU6DQo+ID4+PiBUaGUgYm9vdG0gY29tbWFuZCBj
YW4gaGFuZGxlIHRoZSBjb21wcmVzc2VkIGltYWdlLCBidXQgY3VycmVudA0KPiA+Pj4gY29kZSBm
YWlscyB0byBib290IGZyb20gaXQuDQo+ID4+Pg0KPiA+Pj4gICAgICAgICMjIExvYWRpbmcga2Vy
bmVsIChhbnkpIGZyb20gRklUIEltYWdlIGF0IGE4MDAwMDAwIC4uLg0KPiA+Pj4gICAgICAgIDxz
bmlwPg0KPiA+Pj4gICAgICAgICAgICAgQ29tcHJlc3Npb246ICBnemlwIGNvbXByZXNzZWQNCj4g
Pj4+ICAgICAgICAgICAgIERhdGEgU3RhcnQ6ICAgMHhhODAwMDBkNA0KPiA+Pj4gICAgICAgICAg
ICAgRGF0YSBTaXplOiAgICAxMDExNDUyMCBCeXRlcyA9IDkuNiBNaUINCj4gPj4+ICAgICAgICAg
ICAgIEFyY2hpdGVjdHVyZTogQUFyY2g2NA0KPiA+Pj4gICAgICAgICAgICAgT1M6ICAgICAgICAg
ICBFRkkgRmlybXdhcmUNCj4gPj4+ICAgICAgICAgICAgIExvYWQgQWRkcmVzczogMHg5MDAwMDAw
MA0KPiA+Pj4NCj4gPj4+ICAgICAgICA8c25pcD4NCj4gPj4+ICAgICAgICAgICBVbmNvbXByZXNz
aW5nIEtlcm5lbCBJbWFnZSB0byA5MDAwMDAwMA0KPiA+Pj4gICAgICAgICMjIFRyYW5zZmVycmlu
ZyBjb250cm9sIHRvIEVGSSAoYXQgYWRkcmVzcyBhODAwMDBkNCkgLi4uDQo+ID4+PiAgICAgICAg
Qm9vdGluZyA8TlVMTD4NCj4gPj4+ICAgICAgICBOb3QgYSBQRS1DT0ZGIGZpbGUNCj4gPj4+ICAg
ICAgICBMb2FkaW5nIGltYWdlIGZhaWxlZA0KPiA+Pj4NCj4gPj4+IFRvIHRha2UgY2FyZSBvZiB0
aGUgY29tcHJlc3NlZCBpbWFnZSwgdGhlIGxvYWQgYWRkcmVzcyBuZWVkcw0KPiA+Pj4gdG8gYmUg
cGFzc2VkIGluc3RlYWQgb2YgdGhlIG9yaWdpbmFsIGNvbXByZXNzZWQgaW1hZ2UgYWRkcmVzcy4N
Cj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBNYXNhaGlzYSBLb2ppbWEgPGtvamltYS5tYXNh
aGlzYUBzb2Npb25leHQuY29tPg0KPiA+Pg0KPiA+PiBIZWxsbyBNYXNhaGlzYSwNCj4gPj4NCj4g
Pj4gVGhhbmsgeW91IGZvciBkaXZpbmcgaW50byB0aGlzIHByb2JsZW0uDQo+ID4+DQo+ID4+IElu
IHRlc3QvcHkvdGVzdHMvdGVzdF9lZmlfZml0LnB5IHdlIGFyZSB0ZXN0aW5nIG9uIHRoZSBzYW5k
Ym94IHdpdGggYW5kDQo+ID4+IHdpdGhvdXQgY29tcHJlc3Npb24uIFdoeSB3b3VsZCB0aGUgcHJv
YmxlbSBub3Qgc2hvdyB1cCBpbiB0aGUgdGVzdD8NCg0KVGhlIGN1cnJlbnQgdGVzdCwgdGVzdC9w
eS90ZXN0cy90ZXN0X2VmaV9maXQucHksIGlzIGFibGUgdG8gZGV0ZWN0IHRoZSBvcmlnaW5hbCBw
cm9ibGVtDQpvZiBhIGJvb3QgZmFpbHVyZSB3aXRoIGEgY29tcHJlc3NlZCBpbWFnZSwgYWx0aG91
Z2ggcnVubmluZyB0aGUgdGVzdCByZXF1aXJlcyBzb21lDQpjb25maWd1cmF0aW9uIGNoYW5nZXMu
DQoNCj4gPj4NCj4gPj4gNTM5ICAgICAgICAgIyBSdW4gdGVzdHMNCj4gPj4gNTQwICAgICAgICAg
IyAtIGZkdCBPRkYsIGluaXRyZCBPRkYsIGd6aXAgT0ZGDQo+ID4+IDU0MSAgICAgICAgIGxhdW5j
aF9lZmkoRmFsc2UsIEZhbHNlLCBGYWxzZSkNCj4gPj4gNTQyICAgICAgICAgIyAtIGZkdCBPTiwg
aW5pdHJkIE9GRiwgZ3ppcCBPRkYNCj4gPj4gNTQzICAgICAgICAgbGF1bmNoX2VmaShUcnVlLCBG
YWxzZSwgRmFsc2UpDQo+ID4+IDU0NCAgICAgICAgICMgLSBmZHQgT0ZGLCBpbml0cmQgT04sIGd6
aXAgT0ZGDQo+ID4+IDU0NSAgICAgICAgIGxhdW5jaF9lZmkoRmFsc2UsIFRydWUsIEZhbHNlKQ0K
PiA+PiA1NDYNCj4gPj4gNTQ3ICAgICAgICAgaWYgaXNfc2FuZGJveDoNCj4gPj4gNTQ4ICAgICAg
ICAgICAgICMgLSBmZHQgT0ZGLCBpbml0cmQgT0ZGLCBnemlwIE9ODQo+ID4+IDU0OSAgICAgICAg
ICAgICBsYXVuY2hfZWZpKEZhbHNlLCBGYWxzZSwgVHJ1ZSkNCj4gPj4gNTUwICAgICAgICAgICAg
ICMgLSBmZHQgT04sIGluaXRyZCBPRkYsIGd6aXAgT04NCj4gPj4gNTUxICAgICAgICAgICAgIGxh
dW5jaF9lZmkoVHJ1ZSwgRmFsc2UsIFRydWUpDQo+ID4+IDU1MiAgICAgICAgICAgICAjIC0gZmR0
IE9GRiwgaW5pdHJkIE9OLCBnemlwIE9ODQo+ID4+IDU1MyAgICAgICAgICAgICBsYXVuY2hfZWZp
KEZhbHNlLCBUcnVlLCBUcnVlKQ0KPiA+Pg0KPiA+PiBUaGUgdGVzdCBzaG91bGQgYmUgY29ycmVj
dGVkIHRvIHNob3cgeW91IGlzc3VlLg0KPiA+DQo+ID4gQ2FuIHlvdSBzaG93IHVzIGhvdyB0byBy
dW4gaXQgd2l0aCBzYW5kYm94Pw0KPiA+DQo+ID4gVG8gdW5kZXJzdGFuZCB0aGUgc2l0dWF0aW9u
LCBJIHRyaWVkIHJ1bm5pbmcgdGhlIHRlc3QgdXNpbmcgdjIwMjUuMTAuDQo+ID4NCj4gPiAgICAg
ICAuL3Rlc3QvcHkvdGVzdC5weSAtLWJkIHNhbmRib3ggICAtLWJ1aWxkICAtayBlZmlfZml0DQo+
ID4gICAgICAgLi90ZXN0L3B5L3Rlc3QucHkgLS1iZCBzYW5kYm94NjQgLS1idWlsZCAgLWsgZWZp
X2ZpdA0KPiA+DQo+ID4gVGhlIHRlc3Qgd2FzIHNraXBwZWQgYXMgZm9sbG93czoNCj4gPiAgICAg
ICB0ZXN0L3B5L3Rlc3RzL3Rlc3RfZWZpX2ZpdC5weTo6dGVzdF9lZmlfZml0X2xhdW5jaCBTS0lQ
UEVEICguY29uZmlnDQo+ID4gZmVhdHVyZSAiZ2VuZXJhdGVfYWNwaV90YWJsZSIgZW5hYmxlZCkN
Cj4gPg0KPiA+IEFmdGVyIGRpc2FibGluZyBBQ1BJLCB0aGUgdGVzdCBmYWlsZWQgd2l0aCB0aGUg
Zm9sbG93aW5nIGVycm9yDQo+ID4gYW5kIGNvdWxkIG5vdCBiZSByZXByb2R1Y2VkLg0KPiANCj4g
SXQgd2FzIGEgYml0IHRyaWNreSwgaG93ZXZlciwgSSBoYXZlIHN1Y2Nlc3NmdWxseSByZXByb2R1
Y2UgdGhlIHRlc3QgaW4NCj4gc2FuZGJveDY0Lg0KPiAoc2FuZGJveCBjYXVzZXMgU0VHViBiZWNh
dXNlIG9mIHRoZSBvdGhlciBpc3N1ZSkuDQo+IA0KPiBCZWZvcmUgZXhlY3V0aW5nIHRoZSB0ZXN0
LCBkaXNhYmxlIHRoZSBmb2xsb3dpbmcgZGVmaW5pdGlvbnM6DQo+IA0KPiAgICAgIENPTkZJR19B
Q1BJDQo+ICAgICAgQ09ORklHX0JJTkZNVF9GRFQNCj4gDQo+IFRoaXMgdGVzdCBpbmNsdWRlcyB0
aHJlZSBpdGVtcyB3aXRoIGd6aXAuDQo+IA0KPiAgICAgICMgLSBmZHQgT0ZGLCBpbml0cmQgT0ZG
LCBnemlwIE9ODQo+ICAgICAgbGF1bmNoX2VmaShGYWxzZSwgRmFsc2UsIFRydWUpDQo+ICAgICAg
IyAtIGZkdCBPTiwgaW5pdHJkIE9GRiwgZ3ppcCBPTg0KPiAgICAgIGxhdW5jaF9lZmkoVHJ1ZSwg
RmFsc2UsIFRydWUpDQo+ICAgICAgIyAtIGZkdCBPRkYsIGluaXRyZCBPTiwgZ3ppcCBPTg0KPiAg
ICAgIGxhdW5jaF9lZmkoRmFsc2UsIFRydWUsIFRydWUpDQo+IA0KPiAiaW5pdHJkID0gT04iIHRl
c3QgaXRlbSBjYW4ndCBiZSBleGVjdXRlZC4NCj4gDQo+ICAgICAgSU5JVFJEIER1bXANCj4gICAg
ICA9PT09PT09PT09PQ0KPiAgICAgID0+IGxvYWQNCj4gICAgICBMb2FkIEZpbGUyIHByb3RvY29s
IG5vdCBmb3VuZA0KPiANCj4gVGhpcyBpdGVtIHVzZXMgRmlsZTIgcHJvdG9jb2wgdG8gcmVhZCAi
aW5pdHJkIiBmaWxlLCBob3dldmVyLA0KPiB0ZXN0X2VmaV9maXQucHkgdXNlcyAiYm9vdG0iIG9u
IHRoZSBGSVQgaW1hZ2UsIHNvIHRoZXJlIGlzIG5vIGNoYW5jZQ0KPiB0byBzZXQgRmlsZVBhdGhM
aXN0IGluIEVGSS4NCj4gDQo+IEF0IHRoaXMgdGltZSwgYWxsIHdlIG5lZWQgdG8gZG8gaXMgbGF1
bmNoIHRoZSBjb21wcmVzc2VkIEVGSSBhcHAsDQo+IHNvIHdlIGNhbiBkaXNhYmxlICJpbml0cmQi
IHRlc3QgaXRlbSB0ZW50YXRpdmVseS4NCj4gDQo+IEkgZm91bmQgYW4gZXJyb3IgaW4gdGhpcyB0
ZXN0IGJlZm9yZSBhcHBseWluZyB0aGUgcGF0Y2gsDQo+IA0KPiAgICAgIEJvb3RpbmcgL1xob21l
XHVzZXJcdS1ib290XGJ1aWxkLXNhbmRib3g2NFx0ZXN0LWVmaS1maXQuZml0DQo+ICAgICAgTm90
IGEgUEUtQ09GRiBmaWxlDQo+ICAgICAgTG9hZGluZyBpbWFnZSBmYWlsZWQNCj4gICAgICAuLi4N
Cj4gICAgICBGQUlMRUQgdGVzdC9weS90ZXN0cy90ZXN0X2VmaV9maXQucHk6OnRlc3RfZWZpX2Zp
dF9sYXVuY2ggLSBhc3NlcnQgJ0hlbGxvLA0KPiB3b3JsZCcNCj4gDQo+IGFuZCBmb3VuZCBubyBl
cnJvciBhZnRlciBhcHBseWluZyB0aGUgcGF0Y2guDQo+IA0KPiAgICAgIHRlc3QvcHkvdGVzdHMv
dGVzdF9lZmlfZml0LnB5IC4NCj4gWzEwMCVdDQo+IA0KPiBUZXN0ZWQtYnk6IEt1bmloaWtvIEhh
eWFzaGkgPGhheWFzaGkua3VuaWhpa29Ac29jaW9uZXh0LmNvbT4NCj4gDQo+IElmIHRoaXMgcGF0
Y2ggaXMgb3V0IG9mIHBhdGNod29yaywgbWF5YmUgaXQgc2hvdWxkIGJlIHJlLXBvc3RlZCB3aXRo
IHRoaXMgdGFnLg0KDQpUaGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZS4gSSB3aWxsIHJlc2VuZCBp
dCBhcyB2Mi4NCg0KVGhhbmtzLA0KTWFzYWhpc2EgS29qaW1hDQoNCj4gDQo+IFRoYW5rIHlvdSwN
Cj4gDQo+IC0tLQ0KPiBCZXN0IFJlZ2FyZHMNCj4gS3VuaWhpa28gSGF5YXNoaQ0K



