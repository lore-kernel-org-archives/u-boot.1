Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C560C44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D48839DF;
	Thu, 22 Jan 2026 09:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Qk4EfxOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955F183A1E; Thu, 22 Jan 2026 09:54:46 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C81280077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suYP36HR9z384skQsc/wF7Hn4fPeQ0oTjjP1gNmbXmFJ+j7F1+06z9PhG8V5JhLvMZu6LLykMvCzJOzNy3rmIa4yIw4dNg4g84Eo88RShIHvpjqkAPnlim9JfWCxmBJ08LjMmhMeJO2J6tQEsA6kFsZkjVN8qgWOpYE0GcdxQuGKfvFk48HfVgMywJdmBo5o6XxkNybsSdPOTtg8PL4Hqxcmvbmr9KN0zwnUO2GzTnliZq8M2nPzD5sfYbUn66VPl9V5+zNZy3rwpEXGDkVOXDSRgMq3+7VcBWT242VA8YiRaeV35glc5SKh80taBtUKfu1bbNZaE5BHn4EOLR7CcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFGNtF7CIdQkg/Odvz+5suBx27DfrrJfy63ebcm83zk=;
 b=rtM6DvwoWasVWtA9IqyeyX8Q4B6NUuKgEev+1ScsyKAix6WkQam8xmXJjYtdrau4vlbdlXaXuBbUWWaCf2o0HMKZ/OH6QZGMtrarz3V8jBXqUhshngQ6HuWDMjSfYnN6CTSyWuIxoJQMG9JFVxPVAN29qIxUEmPKg8KG1X25SoCmA3bg51UmJKYfTglOEYYut2kM8j2LkhkxtrxdeXx6Vz7NzVVhTnJHus4kxTxTL3Kw5i8EpE0vEW0QQMWbQLOgwqy9An5PS2F9H+lvBqQFWWTg2TTnEByHNvcbyRbGvjTokMN/ee+uLNrdZRp7s/SqklRvI2O03/HY1QiS25SogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFGNtF7CIdQkg/Odvz+5suBx27DfrrJfy63ebcm83zk=;
 b=Qk4EfxOad6fA1IvPxL76LIUFyjIB7/a013/Gyr1TpbIn1f5ihal4tX2qt9IN4bFT3XOu1h/UHsx3G1TuusLlGDBI1lquYGpTCvjtlCEEWny2H+b1pstLzzFdPkSF6Hj0qC+SmPQWBimoj8qA0Lmv1gtKV83xDdGW/fFaLm+LbEaum5LaueC84GvbJd9yuy5vsHhsDCmWJlMMjmebXtaU/nlpJLzwaMxsQufaf1OS4WW8YmJf6+y2ixE50xgy3Hjx96Dl+UuVfx96vijENXtczGnxmsxDTPAVHd2DBx9sS7N/43TSQ+OO8F2SJsZPFlYbICeA5GV1C12ljkjPctBFzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 08:54:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 08:54:41 +0000
Message-ID: <fbb97475-6cf4-488a-800f-44b83d38e615@siemens.com>
Date: Thu, 22 Jan 2026 09:54:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL
 to support MBR
To: Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-5-javierm@redhat.com>
 <5c6c0fbc-4560-4a88-b52d-97c66341ed30@siemens.com>
 <87zf67e2mc.fsf@ocarina.mail-host-address-is-not-set>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87zf67e2mc.fsf@ocarina.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 711b2583-63e5-4124-5c0a-08de5993e1ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGVWMTdnK0kvTHI1dkZSd0lrQWJWdldCNTZTd2RtaDdWVFVLTHZRWXBtRWNM?=
 =?utf-8?B?dFJmSnFlb1BZTEdQcVhjNThVd3lqWU9ROGhMcjM4NTdSWmtOV3FRbWlrc0hM?=
 =?utf-8?B?LzJ2U0IxTTdYamtrdGJQM2I3Mm5LTFhlK2tWOWU3L0NFQVUzdmdiY0pFQ0pq?=
 =?utf-8?B?Y2pRL2wxU2hsZTNnNlNXQ0RzZ045TVZ1MFhmamp2OHJ4eXdMZUhWaUZqNzdC?=
 =?utf-8?B?Rm95ZnFPWEpEZFViMHlKYnlOUi9obzdaQWJZUjRCYTZSc1NNYnhpWjlYWnhM?=
 =?utf-8?B?MUUvY2wraXM1cUdNb00zamtmaHB2UmNQUnJNWmh1ZUJVdS82Njl4UDBWbmVz?=
 =?utf-8?B?NFd0TG1VM2RMa0xMUFE1K25ZM1hRbHVrTkNVWjNUWmlTZXJrMzVZdlVKM1JJ?=
 =?utf-8?B?MFJDc3I0L2lpMlFGR2JpT3JXZ3NIdmxBSVNsOEw3eFpKVXVLWjZJYkJXeEVo?=
 =?utf-8?B?NXBNbGVSRkwwYVRtRUdBZmtCRmN4cXdnd2FFRXUrYmh1RE04dUlqeHlxYk5L?=
 =?utf-8?B?UndDcmUzRjhpKy9HNnh5dFBsQnVFTlpreFl0RGxaUXQ0OWg4UTJ6STMvYzZM?=
 =?utf-8?B?MytudTNMNldURHJsYkxoRFVGbzNVZER4TUlBK3JsV2FaWGczdUR5bDdjSmZ6?=
 =?utf-8?B?VjFwd3NZaHQ4MVAzR2tGai9RZjk2WTdlRjNNTUF5YVR6RDMzT3FhWlZXYWha?=
 =?utf-8?B?T2lic096UVZHYzU0ZFBDSWNxMnhhM0dBWTNieHV2TTIweVorVStxY2tpbm5R?=
 =?utf-8?B?cDJ2cEpNQnUyM3hDaGR0QS9GcythOW4yZ2FhRHRqVXZyNlJGNlNNWlMyb3Jv?=
 =?utf-8?B?WkhDUDZqdVFPZVR1d0lCVFRNZ2lBdHd3cW9uRk8xYWJLUnE5UVBtYVJJNHJq?=
 =?utf-8?B?Mit4dWhMdDBWWnRBc2poSGdITHRGNW5Fc2cyT1djVmErczRMbWNlK2ZHRTNi?=
 =?utf-8?B?emlKSjNLdDZSdHZlL1F0UzRRTG9OMXBRLzIxQVB2bkE4K05zYW1wb0RLNEV0?=
 =?utf-8?B?WElwWU5QMXY3dThsbEk1UzBrU1FWdVdLWkt6UDJ6Qmd3cDVkWm9ydmhQdDE5?=
 =?utf-8?B?dVhud1VxYUU2cFZhc2lNN1JLcDBCUzVDdU4vdnFZTElXcTFJMXQ4bXR4aFFW?=
 =?utf-8?B?bjBsWmNvRGw3aHNVT0drNVdYdlVCUXlreW0rbFRoMVRzMXpGR2Y2bUlYNGp1?=
 =?utf-8?B?NDN4Uys5Y0lUWkhFRFZjbTd2emRDWkpHb0I4VzdFelcvQ1dhY1YwbmZqcG5J?=
 =?utf-8?B?T0FWSXJTVytqaGtCdEFOajlCRUNiUjF2d01RemlFV0Q5ZzN6a2JEMklacldT?=
 =?utf-8?B?QTNhZGx3ZW8raEpnOXJXWjkzOTY2UnZDa25NU0E0VHRtYnVqR2xEWE9tMWM0?=
 =?utf-8?B?ckV6ZDdoS3dITXpZR3BsaHh0bXM3d21EaTRlRWZnVkhOZEYwYU4wL2l0Q0x0?=
 =?utf-8?B?eTZNU0w2UDRpcW5qd0Z5eitRU09heGZhci9VNmkrL2hSRit1NUJBUDk3dDk5?=
 =?utf-8?B?Mm5taG5yYmFmMGs2WSsxRmpHSWY2dHBGUmc4RjYzWUM0Rkk3QVRVSFV4SUpT?=
 =?utf-8?B?cG9vNXRBNWxxNmVXQ2lpWXZROEJIam9WL3YzOXFFVWZSa1NUa0h3RmJadURl?=
 =?utf-8?B?S0xYZkh1UDZzdWx1OGdNaHNiUGF3cFFtd3ZvY05tYmhmSTd1bmtuY0JIc0ZY?=
 =?utf-8?B?Wmk3RkFyVkNtNzQ0YXViR1BuMnJyQ0FseVdXRWY2Z3lSZnRacHB6eU1oMEU2?=
 =?utf-8?B?bGIyN3ZQd0xhd28wRnY1VGhpeTI1emFCM2lvK1lsWjNTb3k1ZEVHKzNOZHBn?=
 =?utf-8?B?RUtUMDZXU2J6ZnVSd2p2eXdyVVhKc2lNQ1kySDZ5QzQ5b0N1SVppY0xoTXFl?=
 =?utf-8?B?NWR3TjFTcjJPMU1nQlExSVVhR2RQUUZ5dU5ZSFpjdXFNZURMQkVJenFSaFla?=
 =?utf-8?B?SWVtV1c3MlFReUxoQi9rY3NKaTVjZW5vMXE4RWNnK1hnZW1tc3BXcU9GK2hp?=
 =?utf-8?B?akZiRlFWV0xCTmFyNDFmL3k5d0dieEt0WTdoQ2FQZUlMMUo4a2UvOUxhdG11?=
 =?utf-8?B?VXNYbnp5TzkxSG50dXAzUVV1TDdOS3daamFKc1FWa0FDYVlVNmxQNnBIb1gz?=
 =?utf-8?Q?1TSc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXQ2SXFKUU1rUEVGZ3JTWk12a1NiVHEzNW51d2pCMFR5NWs0d2lSbStqaFBV?=
 =?utf-8?B?WVlaMUNVR25rNTN4SmtFM2M2Ri9Od25MaU0wNFAzNWVxWUhQZE9idEpXZkh6?=
 =?utf-8?B?ZHhCYUJjLzkwcnYwZk40cENPZm1CY043Y24xZTU3aHNXMDBFNGZHWFFRQ29Z?=
 =?utf-8?B?c29nMXVLSm9CS2F6Y2czSlRYbUVGYU5Vc2xtdFhjWEZBSHE3eG13OXlQNmpH?=
 =?utf-8?B?OVM2V0tFZmpTaisrM0k3NHphdi9FbTMwMnBUSUpWNnNyMDVYMVBlaWM0eTRG?=
 =?utf-8?B?UEFaOTJrVFp1d2FOMlhYK0gySWpESW5lSlZMdFoyTjRiaDZCaDRQT25mMWxp?=
 =?utf-8?B?cDAwSVJFTmdpamJxRHl6Lzg2NHpSL0VsbzVtLzJxTVRJZnkxbE9zRVBEWHZR?=
 =?utf-8?B?TjlBM3EycXo2bVRCM0I5Q3BOVm1NaUdzcDF3dW5oUVkwbGNDc0NXMzFYOHFs?=
 =?utf-8?B?RlRSVWQzTjA5R1NQajhPTUU5VmZENmt5ZkRqajhFU2YxMjF1RGRsZStmc2Jv?=
 =?utf-8?B?aENaVUhzT3FJYmxUb0tCWENYeVZUOTVZUU94OXBGclBSeUVEMTBqd1pQQklC?=
 =?utf-8?B?OEZodkVzMVE5NWpZZnNTYkJCWTJNVzlFbkxmZjRWNWMyVTRsZ3VjMnhyMFpp?=
 =?utf-8?B?T2hYeGZnR2VTNVNaSmhFN1JrZTFQbU41R3hCdUlhTnV4ZXYwMFVGd3h0SkhF?=
 =?utf-8?B?N2VtMDhqb2pRYzFCb2pUZmkvQWgzaEdVaG9TZUxsWTIva3MzQ0ZZVk9YOUJD?=
 =?utf-8?B?TkFkdlRYM0QwaW12a1JkbGdkTHJFRi8vbnNGcTFzOWd5M3ZsQXlBVDZnUHVT?=
 =?utf-8?B?ekZRSzhjMkl6eTFjRDJxUnVlcVFkbEJ3Y2FHdDRGazNwQndrUk0vdUx0dkFL?=
 =?utf-8?B?VmdvN3BtTUxNbGVrOUhXREUwc3JaREFNOGY4Z0hJbCtGMTl4TUd2Zy9IOTdm?=
 =?utf-8?B?STY5aytobkpxeFFHbHIyNjZTTnNHd2NnMjI1S25nSEswRjdUaVdDZnpaUld6?=
 =?utf-8?B?YjBOakI4U2dZZXRROE5qV3p6NFI3eG9pdkdBL3VzTmVVektZbGVHd1NYL1ly?=
 =?utf-8?B?K0w2WXNIL1dWR05lME84WFBpWnRCLy90aEpZSVlUOFA0Z2NGQjluazk0MUFX?=
 =?utf-8?B?VS9zeEdJM1FFNlYwWk9DbVBwVHpKSjROWmJuM3BVT3RCL3JMNXVnNlZhQU41?=
 =?utf-8?B?bTYzOFlIWDRvaTY0TjJTZG8rN3NXaStFYit2WDRUTDVjdi9RbUpHemovZGM3?=
 =?utf-8?B?WkcrMi9nOXFObCtWV21kSHg2ZnpLT1ZlazQreStab2hqb3cyRlUzWXdmdUxD?=
 =?utf-8?B?dHJUTjVvM2IwakQxMys0YWNsTm91R291c245bVY1aUJuaGdnWElLa1YydlFs?=
 =?utf-8?B?WW5GMlkwWDJSZjBCbjk5eFowQW9ET0t2MVJ5T2FvWW5vUHYvbEVMMVpCV2I3?=
 =?utf-8?B?anhPZmVpcU1DWVQvRkpRdU9GcVRrK3o0OFh2UGlzZ0hSbW9jSHFaUVloT3A2?=
 =?utf-8?B?SExSWFFUUngrQkxGSlBlejY3MlczbDJ2TUc2R2tRRVNFMHloOGNHMTlSWnJW?=
 =?utf-8?B?ejlxcTYyOEFlVzFkcklwVUtGaDZIYWdzOUMrQmZSYVphSGZkeTJKOUlwYW1S?=
 =?utf-8?B?RzQzaURrVWdiZmRWWHo3eEJ3cnNsT1VpR3JOUkJXSzR5RVVuRzRaRHZaVTZv?=
 =?utf-8?B?OU1DS3hTZWpybEFHNExxcjJ3UnpzSVh1ZzJpdWtHSnUyWWt6dG1xcFArOE5Y?=
 =?utf-8?B?anZVMnJvRi9mZEd2SWhhTTdoamIyS3dzMDFWZTMxT01rY00wRjRJcU0vWkV1?=
 =?utf-8?B?bFhyd0lPR09OQmg0UWZucDhJeXhzZmNBWkpxT3V6bjVOWlBxa1BGMUROK2l5?=
 =?utf-8?B?RjhwdmR4S3AvVTJPTUxCQjFBUmczY3RER2ZQY0tObFF2bWNQVEw1K2FyOUVj?=
 =?utf-8?B?M3dqcGJYaUZMZVBtZGJLdmlJMVdaY25EUmp2SWZsWFpDc1JwS1ltZDcrWU1W?=
 =?utf-8?B?Z1lPYkxYYUM2T29IeFU3ZE96bnRPYytwZ3J0RmwzdVI1WXRpRFRxeW9xVlVX?=
 =?utf-8?B?TmY3NlYrSVJqbFMxY0hZU3dQaUVYZER1QlV5OEQrTkZPUVNFbDg1SDRKcTMy?=
 =?utf-8?B?YytzV0gvNDNCMW9jWnlyWFY5dE85V3hUT3lVaU9DSnZ1QkZYLzBMNk84Z3Rl?=
 =?utf-8?B?TWhSY29aMVNxZDJ6dk1vQ2plWXRLNWVmaGFja1RUZU5yRmZDYTJwRUV5RS9p?=
 =?utf-8?B?aGUxK2tBMCsza2s5YkVLY2FPQXN3RFdaSlNob2MvZlZDMFJFWG1jRVFCaTgw?=
 =?utf-8?B?NWFtek04bmRhVE1HNElhV21pY3JKbjRVUG01c3gyQm9SajB1RDhaTVUyUHhL?=
 =?utf-8?Q?MulEseh2G76Mc0tU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711b2583-63e5-4124-5c0a-08de5993e1ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:54:41.7839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw71f8djOX50EQ01Nv8U026mIf5OP0THSEJ5uFLJXCDPe/L/NN0Q+yf7/RxT/QB3u/4DGuQwXFtX0pFcdx7Zew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7780
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

On 21.01.26 10:28, Javier Martinez Canillas wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
> Hello Jan,
> 
>> On 20.01.26 14:36, Javier Martinez Canillas wrote:
>>> The EFI_PARTITION_INFO_PROTOCOL provides detailed information about
>>> partitions. The UEFI specification mentions that both GPT and MBR
>>> partition schemes are supported, but the U-Boot implementation only
>>> supports the former.
>>>
>>> This can cause compatibility issues for platforms whose boot ROM only
>>> supports MBR. This change adds support for MBR partition tables to
>>> the protocol, making U-Boot compatible with systems that require a
>>> legacy MBR table.
>>
>> Normally, this is simple to address via hybrid partition tables. I've
>> done that already for two different SoCs (TI AM62 and Altera Cyclone V),
>> and this allows to use all the nifty features of the modern GPT without
>> upsetting the ROM loaders. Do you have a SoC where this does not work?
>>
> 
> Yes, I know that could be worked around by using hybrid partition tables
> but IMO using that could be fragile.

Try it, it's not in my experience. Again, you gain modern GPT partitions
this way, for anything but the boot partition the ROM loader needs.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
