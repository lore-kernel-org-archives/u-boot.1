Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E924D10375
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBEAD83A5B;
	Thu, 27 Nov 2025 08:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="xlggn078";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4E283A8F; Thu, 27 Nov 2025 08:29:33 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D96839DD
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8oCwHvQuozOmVQvOVd0alTo6Q4pJYfAEYoEfJErQ9KVChbcIjWa9nn3bdnHF+1loP6pFGxDJtZaiKAm59opnbOdyeeXqgNsbMk5g2a8sWZQC/uWyzXE8H0K5hAa2hq/gAEyLmuQP6Hrw6tRj4o3h1TljXZvLIODmwDa6ZzitdlRLyvi29QOtmJNyjZyb+da2g7viLRmcfae/qUXxzNKTSS1fd8uaiwpg+FLltIDv+wJWqTeCTdZoZ8apxcp8BFxNLSucrK7cpKMXSwtoMNz85riFg0lH+5j8hN6zg/KAWdhdlFaT47A1g1gbccSnxqTMU0mo8UAlm5rQfFt+gjjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTzA6So3TgRZUvrk+ce4IvH7tTjQoZFds1+lsUjgYGA=;
 b=ov/VEQDqfvzDqS1Z1T2NIjnu73QVMLOZhLa6TyuxhZowjcVi0q4+PYMUg15PxS1qbjcpxXTEssChLMTIlCrjllSqxAgeJGz+eyDKxN90KjrmL0ZaFmdhn/ISnszBnFHmQWN5fB3/u8NMwh/n4TpVNAUm9nJv2rAEsQFEayfciA3/fztXApgzoLTcICZMETuk3osXQ/RSle2IdINAEysX3RTT4o0qH2Jxy/CSW0HCgyxPNotInOgg+Ik7hp/7L0DTtMeuH8u2xY9RtNIUheQ/y30qaDe/FGp+VMgh3CRd/C5ZaXJMPPbOjm0XPobA/rWQyR/FuvfJHHaEII+q6R/k6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTzA6So3TgRZUvrk+ce4IvH7tTjQoZFds1+lsUjgYGA=;
 b=xlggn078h/J9EqyE5LOZvIeOf4VkLocMo8pqpiw8VbBhpsWAOph1iF5FT+Gq/jh2z9vZg4H1rrhYe2tMzFIJ/8wma/V09w0AWzCWH59xb3Sg1ScrDBSo4EDPVhJ+YPOJWKjnftrnNsvnCxD4Qq6C968Yi4JUDpnEjYi61DP1aABcPVzXHsvVYcmrWQSi+4KSr2W6+neuctTTFPMQtL2YvS05n7wLb15HBhWeUJmNG0v4mBoqUYVYS5iqF4yKd5ZsUsooJhCoo6QovpS0lYigfYh6dZMHGquDApUyixHnwGqDgigEz9PNIps9MzBvJqMzuZSfPawviBkfYWqqQsrTsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 07:29:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 07:29:28 +0000
Message-ID: <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
Date: Thu, 27 Nov 2025 08:29:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
 <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3903:EE_
X-MS-Office365-Filtering-Correlation-Id: 18addb88-a040-4b54-3142-08de2d86b2a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXoycHE2V1ZJSGJvMDBwVHVkYlRydVpJTkdNQ09VQnRVc1BJcnRCR1N1MWxY?=
 =?utf-8?B?RHB0SkswMitidWY4Y0c3S00rWHhVcXhoYkN5cTd6UU4vZHFBOGZNSXBJTDBH?=
 =?utf-8?B?SWc3VUd0U3ZrdW16OWhtbHdveExJV29wU2l3OXh2U24zL2pEdmxXMFdLbVRp?=
 =?utf-8?B?TFBvV05HcWxydTNUME4wZUM1UVFJMXoyeU50bWQwMk1QcFJxQko4b3lDYTNK?=
 =?utf-8?B?TEM5Q2JnL3FHSkluUUZnSkFRVzJwYnhCd0cvQ3RwRzkvcHJEY29Db0NpWmlJ?=
 =?utf-8?B?SzRlTloyRFlWTnpKQ0gySFc0N1pFdTRsanNHbzVKM1NpUjhnNUM0cUR0QVpp?=
 =?utf-8?B?WGRoUVhnaFRLZWg5MHBsbDd2V00wY0oyNmpYcDFiTWxjdERWd3ozVVZBblBt?=
 =?utf-8?B?K3NYRVdMaS9RdHpwT0U3OUJGNlRtUnlwQjBRODZrQ2hTMFNPL0pxcytrbG5h?=
 =?utf-8?B?S2k3OHNjVExNK3MzalR0NkVBRmUxRHZiV2xsd1hUZWphVkdFc205ckduQUs0?=
 =?utf-8?B?c0dza0dRcDlhc2lKV1Y0WVE5L3FBOFhLNkNVWE5KYTYwZHZvL1M5VHgrV1Y4?=
 =?utf-8?B?a2pQZXhwakdoT014MHY3NWJRc0dIYUlSaXdBbFNvTGFvSUdLVEZqNGtKdEp0?=
 =?utf-8?B?SEJHbHpYQW91Snp5U0xEYW9KUnZ0Z0grVjBFYmpweGZsanlJVjNyS05IT2Jh?=
 =?utf-8?B?c1NiOUlnZEZXVDJXVWYydmFxQi8wY0FDWU13ZmdMSWpmYS9wRU5WY1E1WFpZ?=
 =?utf-8?B?eFQ1elZLbDEvNVRSOVQ1Rjh5U0FialBMaXpaQVF6ampOcWgwWHVnQ2JsZWFH?=
 =?utf-8?B?azNVWUJLZE54Y1JqNFF1TlZxdEJHRlBUT1hQcjh2NEQ1ejhIR2QramE4R21Q?=
 =?utf-8?B?bHVZQzZORWFTLzNiUy9OeVdsNFBzZEt4T09uNis3Z0hzY0R5MS9oZURBNC9L?=
 =?utf-8?B?RGZHM3dNSjRzeUZKMGpMbEgvRFdacHRSZFk1NG1aV0MwWjlrM0lRdGt2WURp?=
 =?utf-8?B?QmNxSVRxQVZ5SjA0dXhoUHdqbnNzUjRLMnd2aVdFcGhuSnhqaDZzYWQrdjRq?=
 =?utf-8?B?TWg2UzJXcmE2QkV2QkZTdlFYODFSWkpTTGpWRTZvWHVrcUd5L2RzZ3lSZVlR?=
 =?utf-8?B?djlmVkpnNWhJSS83THhQYjNCMzZaRE42bE9memdRLzhFWmlWUDVRM1ZLd0c2?=
 =?utf-8?B?RFRMWExZV0RUN29ZOG1VNnBZK1dTbkZWZXV5Z1FxSkJKNDZFRjZTUlJ5amRw?=
 =?utf-8?B?elJjSjBCcWFQcEJVQnI4S2VaMHREaE1jeG9uTlNHeXllaGw4SkwxcDJ5NUF4?=
 =?utf-8?B?Rkg0ZkdIM2gvNGdwbGlGT3J2RjQydjNYQWFVMDJ3OXBvYlZvUUVNUFVidXVa?=
 =?utf-8?B?SFJEd0hHV3BXNGhNRFdHSG5Kc2s2d28rOEZzeWJCMitaWlM2bWNGa3dOY3B6?=
 =?utf-8?B?QVByVHc2YXlYMlFwdHUySHd1amNsUlA1RkhPaUx6RVMzV3ZVdkZXZWFHekVW?=
 =?utf-8?B?TEo0bkNMbVhVbE9zbGh1N2Q1WFZYZURSdEIwVytEMXNPQjFWM3FSOW1Zdkx5?=
 =?utf-8?B?OFlvR3JRa2hsU1NkRCtuVnhhRmMvZ1c1SWF3b1UxWUY5S2dsdS9DMm8zT1FR?=
 =?utf-8?B?RWZOU3hJb29SdXFlTDZneXZLVmV6RGgxUWFacHl2ZHZ3MU1jRnpIcE1udm9o?=
 =?utf-8?B?L05ZSUJOTjFVVlEwU1k3ZGJxU2w3VU5OMzZlYy9MNG1NZzlTYWxGYnU0YTh0?=
 =?utf-8?B?OHhyQll4aW5wamRWdGlvOEtWeENRaHRobWE5dEhtOGxITGR6SlZtV3pvVjZ6?=
 =?utf-8?B?ck9xQmplRFNweTVKOWl1MjVmNmRxSTlKTG9SbmxTaUZxdThvaWwvVHZUV25I?=
 =?utf-8?B?SkhRRk9ZSmcwSENMOHVqR0ZLTnpQSjZybjVkbTlpalk2SXBHL0FiSk04aHVv?=
 =?utf-8?Q?i1kHm3aBHikByING2pjmZRMP6J2JbRWC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHFxV2EvaUtLRjhncmVHcmNqb3REQ1pvV3dEYk56SngvanloTlhZSnlVTkFQ?=
 =?utf-8?B?aGZMYlVpdGUxUnNoZEFhQjJwQldhRWFmWmRpZDByTW1ZNzNoV1E2WDJESmRV?=
 =?utf-8?B?ZWVjMWVrbUxEMHZleDBJUHdrRnNlOHdvd21wNnkzNzhsWFEvYXEvYjJ3bXVK?=
 =?utf-8?B?dk1Ddy9vNnJqQUdnWjQwSTJyaXRhc2pEV2RiRHNaKzhPTXhsWnkzSy9MNTl0?=
 =?utf-8?B?NXBKY3BGWW52bUZBZHc0MzlRWm9zckozamc4Rm5QOVFzVnowWDBTaTVQbXdw?=
 =?utf-8?B?Z2JiNXRxTGhQUTNIdFY4MXVrd0VsQUtGWUcvZkFDRjdNaXF3SDF5Zi9DdGgv?=
 =?utf-8?B?bkZrUndjVjJ4Tk1OSnoyMmVQM3pNcGlKYWRRd2hmVGJQOWI4RkdjelE2RzNT?=
 =?utf-8?B?MkhJSlJ2aStPN0ZtMFZ5L05KSXp5SmVMWW5hY2NENnNWNm45Q0hqYVcyRFV1?=
 =?utf-8?B?U2VhMWZ0aUpybGFPaXhNQy9seWdBY0ZvLzQ1TkllYkJONC9na1BwbW9Od2du?=
 =?utf-8?B?UHczRjlDMjhjZmVkTUZjV3BXVE5CN0s2Y3EwWFZOUjIwUzkrYzNaMFVVbHZS?=
 =?utf-8?B?UWs3NTFTTitLbTNnMkx1QzhybTZJdFgxMDZCSVNtOEZUODdMS2dHVkdTa21N?=
 =?utf-8?B?YTIvRzJTRjVWZWZHQUNaWXdjV1p6MDhWbGlycnczdzlXYWcrdDJNa25MYVFS?=
 =?utf-8?B?cStlQ2NhUVJtSFdRZTZDODZOdHVpSVEvbGo3bFBhRjVKRy9UQjhCaDltWmlw?=
 =?utf-8?B?NC92NWErMUpWSVkwb1lVbG9jZURyRFQ5Ky9CdDBaT3l1VXJCekxVNHUvOVho?=
 =?utf-8?B?MnVhNEd6ck9NMUlpczcvK0RTb09KbkJKTnZQbXR3VHpXY2F5aWxmdFZDK2Vr?=
 =?utf-8?B?MFE3ZmIzUFU5Tmd2SHNwcHRLZUp3elRrV0ZUU3Rzbmd2eStDdkkycm5MY3NV?=
 =?utf-8?B?VEtKckp6cVdnRWV1YmRIbnNkaS9kOWtwN3k3elhmVHBON001ZWVsdiswV24r?=
 =?utf-8?B?Zi80U0VSMFVPVUVsWlZLNXh6RnVhTkc5VmFuRzA5WU9XZldGL0k2SW1BSjM0?=
 =?utf-8?B?dVplK283Ly9Va2s3dFJUYlRBYXU3YXhxSW0wNThJYkNPQmcvVWlleVJ1UGxH?=
 =?utf-8?B?NWR0QW1ES2tlMVFDeW83b29yQlhpTlhmMzAvNHpFVmFkZnhqTU5PNlRTMkpz?=
 =?utf-8?B?N2JHYmJ5Q1ZQYitveTFWejlCWmJOZUhiS1pnaTRJclY1anZ5SXBZeVRCZklj?=
 =?utf-8?B?U214WmhRZ3REQVd5cWlmZHB6TlZERnhnUjdod3AwWGtkUjRpUmNnbFpXcGQw?=
 =?utf-8?B?c0pxUlNZZ24yYUJaRmIwNzNYd1R0Z1M5TmNWSk5ZaDF4MkE2Y2FLT3ZKOTYw?=
 =?utf-8?B?UDIvcU1LUlpDWTZsQ2Zoc3E0QUg5WVdnYjlmVHZtWkozZUh2ajFGWDZTYk5w?=
 =?utf-8?B?eVdJczJoOEp1UjNDdUFVNjFiaVRSUjJOdUowTGk0SEZmOEE5ZkxlL0xXMHMy?=
 =?utf-8?B?YlhNUWg0aGJnNnlXUEduVllCZDhyZ2crTjlBUmhseDFteHVKMFNmOGtGTms3?=
 =?utf-8?B?WGNGcnh3Mkh3YjBadDZMalB5NFJLcGlPRGd6UzBwSmFXYkJ2M2RmbkQyVFBX?=
 =?utf-8?B?M2ZmbDlDK2cxZ2RlU2dVbVgzWElEbUdrWUpMYmVhUXdRYUtsRWo2UUNWR1lH?=
 =?utf-8?B?RlF5U3RLWUxkczhhTG5jYXJLWDI1K284N3BlalJzM0kxQ2Z6R3pMTFQzRWZi?=
 =?utf-8?B?OXdGa0JQSmNyOVdvUVlTL3psRmFHRFZDM25IWE1EZW1sYVkrNWdhMDlHOWg1?=
 =?utf-8?B?OHA5WHo0KzZvcG42Uk9abXZjdHlZNGRydzlVbDhDVWVSdEt6Z3RTcWkwRXV4?=
 =?utf-8?B?eGZ3dEpad202ZlBFdm5ZQnN1TmZrSUtCZDJwZkx6RE9IN0IrNXRUdXpJYkYw?=
 =?utf-8?B?ZDVyYU9wN0NoSzg5OUFBTHZJV0JUby9VMldZZWlldVhUci8wQld2Rlc5Z0ts?=
 =?utf-8?B?TlBtNERjc3RoVU9SVjhiU2N5R3NBSWdtTlNlbWt5OFE3SlVIS0I3NUhpUmdZ?=
 =?utf-8?B?R2poYUI2SUFqcDJTVkk5Smo1cU9Bd3JnQWFodllsZXZGZ083UUZGdFJVVzVm?=
 =?utf-8?B?OXdnUjNOeHRNUzBLaHo0ZFg2WTVEbW12QTNPdWRuNDF2Z0tsdkk4VVVRWk03?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18addb88-a040-4b54-3142-08de2d86b2a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 07:29:28.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZfvytHkAgsm2aSUT5gwYIAzrPRMREnrJuaKJ5A31iUBNPWVnjS7B2JbAOIpp6WO2gaez+HbsNdIaU1PdMq2jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3903
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

On 27.11.25 08:20, Sune Brian wrote:
>> I shared our wks file [1]: We create a raw partition in a legacy msdos
>> table, set its system ID to 0xa2 (via [2] when we use a hybrid partition
>> table, or classically [3] before that), and put u-boot-with-spl.sfp into
>> it. SPL is picked up by the romloader, but SPL in upstream completely
>> fails to find u-boot proper in that partition. And that is first of all
>> because SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is enabled by default which
>> ignores any partitioning and only uses a hard-coded sector. If one
>> switches to SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE mode, other
>> bugs after 2a00d73d081a surface like no longer built code or wrong
>> offsets inside the partition, and you also end up without u-boot proper
>> being found. Whatever other partitions or partition tables exist on the
>> SD card does not matter for SPL loading u-boot proper.
> 
> Ha Now I see what you encounter.
> No wonder. Because it is not supposed to run like that.
> (i am no software experts)
> 
> I might be wrong, no shame on that I do simple software only.
> 
> So what T.F. had mentioned all aligned will all my build and
> no additional patch is required from first place.
> 
> All there TYPE, #, OFFSET can work.
> because it never uses the old method of combining.
> 
> A2 <- only SPL
> FAT (boot) <- u-boot.img
> 
> Actually I mentioned this yesterday in our discussion. Maybe you
> skipped that important information.
> 
> All board defconfig after 2025.05 is outdated; no one syncs those.
> 
> That's why I comment that the file "u-boot-with-spl.sfp" is misleading.
> You have to turn on "FAT filesystems" change MMC boot partition
> accordingly.

This is not how upstream is currently configured. And upstream is the
reference because it not only sees vendor-related changes and decisions
but also other refactorings. And all those need to be kept in stable
state, irrespective of some random downstream trees. Actually, some of
the breakages I'm describing and trying to fix are not socfpga-only but
are conceptually affecting all boards that may use raw mmc loading today
or decide to do so in the future.

> 
> This is why I say this patch is not a must and combining SPL+UBOOT
> to A2 is not really needed but only for backward build flow compatibility
> concerns.

It is ok to work around current issues in upstream, but we still need to
fix raw mode loading - or drop it from the tree if it has no value
anymore (not my decision).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
