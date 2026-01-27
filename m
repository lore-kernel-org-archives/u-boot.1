Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F2FD2FEFA
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 23:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C68841B9;
	Wed, 28 Jan 2026 00:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="DFT+AQzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E5F841B9; Wed, 28 Jan 2026 00:44:01 +0100 (CET)
Received: from ps83.spcmail.jp (ps83.spcmail.jp [35.75.198.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F7284164
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 00:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from ip-10-10-30-85.ap-northeast-1.compute.internal (localhost
 [127.0.0.1])
 by ncs81.cs.local (8.18.1/8.17.2) with SMTP id 60RNhtCu3208374;
 Wed, 28 Jan 2026 08:43:55 +0900
Received: from ip-10-10-28-82.ap-northeast-1.compute.internal (localhost
 [127.0.0.1])
 by nmg81.cs.local (Postfix) with SMTP id 4f126g1QfNzMpsfg;
 Wed, 28 Jan 2026 08:43:55 +0900 (JST)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010000.outbound.protection.outlook.com [52.101.229.0])
 by npr83.cs.local (Postfix) with ESMTPS id 4f126N5Qb8z3kMcY;
 Wed, 28 Jan 2026 08:43:40 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqKUQWF7YDZhCptesgJoFNOI9E0Awidn/Kk+kUbmNSOarABx2Qeh0vuB4MXAC7etZT4AsNIj3dwleqzV8j7UAfHhxKjvDqncxXDft/OHBXcEZec9+LNL6tzEP+KBFdgatXTvIF/Gi90EENe3rW52FyQ4pkgSZnovjdCfxC7pyeA82Z7HSK0l061EGW6StWaKStidfxQ/vr5KBjSAzd/3scbvrdPyOo0S1BqUVTFkxm6L++bNjd645mI1q750CkqnGDemtB2cO/3SEXagekQOcqTDtOQMUGnDXZi43N/mVkdZDfadLZ3XpLY6QdKXtNS0bA5P6wASk8GbWivED8su9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWaTJqbQsQSX4N2N7DNWf5IeQc6GlPtnJewq1uhKtdg=;
 b=NUfXZjgXKkgW73U6D4JYdw0a33T1B0370sVHoNBGTQtWhdNAacP0TMwS0T7Tar7ko786L4pHFB/23A4LezDT0lc7Fjrawm6fqTiC99cnkcj3rmsCwI2CNlqgQbThisAIU8DyW2UQqQaU9tqxiq1gn/uTTWRZ/1/5iRs4loJnoUOmOZfVbNd+Xqq3ZSWiQW+339igjMEWLN7l9KkN4B0dAz/7Mor5ROF1tqsZZpnySfJbi73VAa3JnJtt9rzLYHRzET+fk/sr4vxmrFqsgwlrV86nWaMk6OPPvhzbLaHKaSmx6tlBluWefuNToRAaUhlzn1apSe+H0iiOp9Vfe2eyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWaTJqbQsQSX4N2N7DNWf5IeQc6GlPtnJewq1uhKtdg=;
 b=DFT+AQzr04BHmIkmIVTzh+swuFHyoxDisoCTgPvTBoTN9KcEi88H5F0l4BVx3Mh09nVwgfHLSyoBdP9lPGv3mQzWooBah95a2lSdgjKoNXtlNrBYFGO17rm2q5Ws33XvyczRWj1iEtdnF8+jzJLzE66P1z7KyD4CUOfTwF27k1k=
Received: from TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:289::11)
 by OS3P286MB2392.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:151::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 23:43:37 +0000
Received: from TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72bb:904a:5ff4:ffa2]) by TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM
 ([fe80::72bb:904a:5ff4:ffa2%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 23:43:37 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH v2] efi_loader: fix use after free in efi_exit() with tcg2
Thread-Topic: [PATCH v2] efi_loader: fix use after free in efi_exit() with tcg2
Thread-Index: AQHcj6ijmgBgdSLJkUu1TBZOVrx1BbVmrQYw
Date: Tue, 27 Jan 2026 23:43:36 +0000
Message-ID: <TY4P286MB5641B58AD614E306B6A41EC1E390A@TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM>
References: <20260123105814.1083834-1-vincent.stehle@arm.com>
 <20260127161843.2676862-1-vincent.stehle@arm.com>
In-Reply-To: <20260127161843.2676862-1-vincent.stehle@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4P286MB5641:EE_|OS3P286MB2392:EE_
x-ms-office365-filtering-correlation-id: b8cd174a-6832-40ac-ca88-08de5dfde43c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|1580799027|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dnBJbEY2VnJQV1NpMWROL1lwK2pPY0U4MWJkZ29BY1ZxVVVUQmdRbmg0ZGRa?=
 =?utf-8?B?eGZabW50clROUThzT04yTi9wL1JQRU5HeVhhVVhyTXZmZTRtbStRVUJZY3Q4?=
 =?utf-8?B?NlZPU3U0cVlvcFhtQ25tQVFWbjJiV2pQOWJ6a3ZxWlFJb2ZaOC8rTG1SOHJB?=
 =?utf-8?B?cXYxZjVoTlYxY3pJeENYWXdEL2h6Q1JNeHhEaHNKQVg1SFh2bk5sQmNBUGpQ?=
 =?utf-8?B?d2xpUng4RG9iRWoyWmRCSVRHT3ZXR0NDZUMxYUdpZXh6aytRdTNmNzYwdHpG?=
 =?utf-8?B?K2hkdEx2V2l6QmFDQitxUnAwUVVCYlBzenlDUVZRdDNZSHRaRGZNU3dhQXMr?=
 =?utf-8?B?S3psZnRDdlhTOE0wcGhxK0pybEs2dTFmb3NqaWlUWTVNdnFPbWo3TXBST29I?=
 =?utf-8?B?RWZSTkpBSHE2ZThkUWgvbHo5bEd0U2tqNEVHMWJiMEVIQ3dGUVVZUzVWUjJ4?=
 =?utf-8?B?UTVZN2VXTTZxbmpCWTBubndMTmhBWk43K3laTkM0anpCRHU3ckE1eWhhZndz?=
 =?utf-8?B?djJUVjRqaEhpWnExVkU3N2REU3dLNWFSZWpDZnFUeklLekVEWkhPNjdMSmUw?=
 =?utf-8?B?ZTcxYnFpQlkzemNLdXcxZXF4Z0dnaEhZd3JOZmx0d3ZSbWFXVG5WVURLQ1pZ?=
 =?utf-8?B?SW92VmxGVDdUWkJ5TmJEajNWZU5KY2phRElwcCtHWFdsYlo1T3pPbDc2N2Za?=
 =?utf-8?B?SSswZzYrSW0vWDI0ZnkrOXVGeWNUdXAzcEQ1Q0JtMU0wc1Bxbys5ejdXZmc2?=
 =?utf-8?B?NWNWYjBSTndPa3V6RVJDbVlKQ2hlb2pENjMrWjNTWlVtMDhnS0VyYkFkYzFh?=
 =?utf-8?B?aGkvbHNQUm9EWWJxRXhvTld5MGFzb2NlRVlKbzRDamM3dDZRb21wQUY5bEdn?=
 =?utf-8?B?QjhLM011Z1p1cU1BZ2w3clN0bmlDVlFpcTNwVDJ2cllrVlhzSjR0dDFaSVhu?=
 =?utf-8?B?RldjWW43aktKUnFMbFp1bis4Q0t4K2ZPL2J6UE5hTUt0NUpaMzFNVjFZc0t6?=
 =?utf-8?B?amV1K2RxNldiWWNDL1VXbUlJY0dMbFIxM3UxMWRZT3B1R1d2dmdVa2swdDdr?=
 =?utf-8?B?SlFsYlk2TGhLOWpXeUxORDhXYVFQM0hPUVN2N2g4SWFqMGlBYkh3K3VKN3R5?=
 =?utf-8?B?WE82ellMWXBpMXhZdHkwUkgrRVl1dG9QV0IvemQyWW9kc1V4WmJpTGpSUENp?=
 =?utf-8?B?bU5KMzlScVRha094R3VkY1RPRmY4bnRLdE5MbE5GQi9xZkJqbVNxZVdKcnd0?=
 =?utf-8?B?Ni9wbDhHRGdJcFF1TUtFcUs4SnJwV2NFM2wwZDBWUXJuMThSZlRxWnY0bWZm?=
 =?utf-8?B?S3h0dHZwYjZGS0k2NGtaY0dMWHN0U1o5WS9pTWV3emZ1Y3VYWE5OQkNqSmhG?=
 =?utf-8?B?SXk5ZGl2bSthT2RaRUtDVWhiRFdxeUJabk5XSHJzcEY5Z2IvL0JXVU1Mb1J1?=
 =?utf-8?B?Q1prNG9zdjVPRmJYbjVYb3BXdHgwelZObHorenpqckY0MTZ1QVVzMmVOTkRU?=
 =?utf-8?B?djllTFlKaTBHak9KMWlkTnRiUU40ZmFHNERWWGFuYUtvb0dCdWJhV25MWGFD?=
 =?utf-8?B?TC80WVd2WkQ5VS9GK0hPYXBtcFYzNUd1UCtmb1puSTlaYzk3S0hpMVNBa1Jr?=
 =?utf-8?B?c1plWmFnempqdE9POFl1S2J0VkV2b1VRVzNaNnFSN01HS2dURDNkUWVselNu?=
 =?utf-8?B?OUk0THRuVzhqandaVWNCdk1aazRTVUR0U0o3R0dVMExUS0RzUlgybWFvVlhS?=
 =?utf-8?B?elNVM2JvVG5JSFhZL3NnU0ZFRmNzeHBlVGhMekJaVFZWWmJtYTlHSStad2lU?=
 =?utf-8?B?ODhCUFdVSHVQcHlNQUVzek5WZXVLMURnRHI5L2IzK1J4a3BMTkxXVlFMeERH?=
 =?utf-8?B?VTZycDNVdUErbWJwdUxiUnNjb2FJL0xZeWtQcktHbWlnR04ycFlsZTNGZFVw?=
 =?utf-8?B?NmZiSEZsTmRieEJWSENiTGtkcFJnYkFxZFhYbE5NODdyT2JVb3A3bzN5Q0gr?=
 =?utf-8?B?OUE2VU1wN1dob1pqV1VTTk5yaVdhT3VSbDA1UHlQYkkyV3hnTkJSZ0dFcm9X?=
 =?utf-8?B?eTgreUVRek1rcUtIeGlwTk5tUlA4SjJZbUN0YmZyL0VVcmE0aWNGMUJpcXYx?=
 =?utf-8?B?THQvT2dQdGFzYndxYm5jZWlMWXB4dVZwMyt5Wm5zdmM1cXNIYjZCTDlMdjRD?=
 =?utf-8?B?WlFTN3JzSzNDQStpaHpPN2dISkxmcnM2aFN4cEllMUFzaVJ6Zzdmd2lNM3ZX?=
 =?utf-8?B?YktrTSt1WDgvNXhjZXA2OHl5ejJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(7142099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVlFZFlSdnNJZUJrMkFXR0R5d3NOZ1BNb2ZQWG9HRGRrVVdZOTdrWlNzeFRs?=
 =?utf-8?B?aS9sUDNNcGUrSm5rbmliOUJ6b3JweUpQOFdCdUZzNDNmSDBlU1ZsUWR2MTlB?=
 =?utf-8?B?ZitMcjNFZExEZ3JjNWg5Zm56bDdqNk1jeW0rVHQ3b0VnL044ME9OdmsrbzBo?=
 =?utf-8?B?WEVtMjhyQ01kdHAzb0I5bmh3UjRTYkxlaFJ4RGVlNEdjYTA4ZUkrZUxaRUVQ?=
 =?utf-8?B?REpPNGNWejA3M2xZVVlHQkUwdGViT1V3a3RCRHQxTmdnTHYwazBXaENjaExS?=
 =?utf-8?B?eTh1dkQzYXRWaTRZZDgxb0lOSTRxcUxWT1ZSaGlteWkybm1TK1lqZmtIcEND?=
 =?utf-8?B?cVRlTHozaE1yRWRKeVJZUW0wUXZUSnlRaC9VVFBJRnhLY256Q1dtTXhTbWZm?=
 =?utf-8?B?ekFKVFJONUh3RWVzblR1dzh0RjRldjZzUmhsd0N5QXdTUTgydUUxZXRURFV6?=
 =?utf-8?B?bzgxcnhrYkFkTk1GRFJ3Q0pXcThHYXRTRXU4N0VvK29SU2l6RVhTcE5MNDlI?=
 =?utf-8?B?NzNhaEdrVURKNXJlQ0pHeFZRNTl4UXJ3d0kzYVN5cjh5RExtSHJjMFB4Qml2?=
 =?utf-8?B?Z0FzZThHZDhobzJaak0wMSt5ZlUwbGlYalVqRERMTHc0SjBXcDh5MHFPbDJn?=
 =?utf-8?B?YWJvMEFMT29nK2xmTnBKWU1ybkhiU0ZiRVI4VVNpNkN2OXUrTzd1SDNwQy9Q?=
 =?utf-8?B?bHF4ZmhPdW5Pd0Y0ZjVwa0V0UjFBMlZwSGdEQUdCaEs2R1AxSERZVnNQazlN?=
 =?utf-8?B?bVVVWnhuVSt4cWlJSTl3MzgvQ0V5cFM3L0I1ek9GaGgrMDVHdVloaFVQMkVE?=
 =?utf-8?B?N1ZmcEJycXVaaTcxZGFrVTZpQVIrTzJPTTlKYklHc3Zod1U3RWJ3V1hXZkk3?=
 =?utf-8?B?SXJCa0tqUDY3K2xsL3BkVnZkQjJmNllHQ3NZLzRsYktQNjQybkRvRDNvdklN?=
 =?utf-8?B?VE1pREJENU9sR2FzU1lNbVkrMjdNZEVQaEN4Q0s3bVdTU20reU1ZWVNKVE5n?=
 =?utf-8?B?bjFZNmR4by9RcDd0VXNQWmVRL0VoajA5YStxQmtGWXpzd2g1TEpsZFpndkts?=
 =?utf-8?B?bGdZWG5FWm5KdnJYTkhHbi9kcXZsRUR2dGNZQ2ZCNDZZNzlmc3F6amVObXUx?=
 =?utf-8?B?a1Z6Vk9OVDBHYTdZaXA2OE1LM0VYVEJMY3FrdzQvVW1zc0E1Qi9meUR6U0F1?=
 =?utf-8?B?ZVZXTnF4R0NVMXRobWY3RE4zclBjM2RYbS94TVlLalJLUERETVJFenRFcDNM?=
 =?utf-8?B?azlqZW1XeFcyWGNXQ0ZzM2ZORDJUOWJKNkFGeXdRUXB1T3lpNGY5cWJNSEFa?=
 =?utf-8?B?U1FEV0ppaXk3M2ZFV2R4UUNaNnJFMkxiSkpPTFhrZnBPV0FtNHovcys4ck02?=
 =?utf-8?B?Q1pDejVrRWd0aUtuS3V4RmtVeE9XczZYYmhFQ2FpamUyTUxPNGp0WlAxak1Y?=
 =?utf-8?B?Y2hLRVQ4ZGlFLzVGYUJhRXllMEJHUGVPODAzYmR2NUhLZjNUMUNQZEhzMnk1?=
 =?utf-8?B?bG5mek9nWEtJKzl2R0FiTlNhMWFhVUY2Vm5Vb2FYamhxem5uYVJIaXJ6aHZL?=
 =?utf-8?B?M2NqNlhFdzBiaXlYYlBYb21RUnV0UDJZWWRMcHpidzJPWGM1aFVDWFptbE1m?=
 =?utf-8?B?NGp4WXZUWC9vaGxkRW5LQUd5RXQ1bHRVeXRTaE11b0pVc2J0cXd4aWZBRFFu?=
 =?utf-8?B?eUZPVDE1djV1bXRnLzlaQ3V4VGppdVlnVlNqWVJUc1VBQUJGWmdHVDVPa05P?=
 =?utf-8?B?VC9IcmQrbjlWV3Y1RUhBWnc5YlVFNklpaGdoVFAycm5Gc1dWTitLUFMxVHJ2?=
 =?utf-8?B?T2ZmQUZpUzlKd1RPbVFWSUlhRk5pQnorU010NjQ1cTFpV3Qwbk1xN2dJc2JR?=
 =?utf-8?B?d1ZHOUdxVjljaUZDa2ZEWHZLOFQ4b3gyY3IrUXNrU1ZmVzJHUVd4MjBEMHNr?=
 =?utf-8?B?OHlBM09CdTFzdVdsejlqNkNFelo5aHdGT1JXMlgyTzR3dkJVRkVneUpsTmpH?=
 =?utf-8?B?VDVTaW1KdUxwakJTa3BJa29NUTV0WVBMSCsvcmJBOW5SNDh1Wm1HRWQreFhN?=
 =?utf-8?B?Skgrc2hNY1lIeUtHVDI0TTViNy81b2ZjNk83QldsN2xTQWhRNlA2TVluZnUw?=
 =?utf-8?B?bzNRa2Nsa091TEJCalZsZk9tNW9ubSs4OWxWK0pvdDB3L1BRS0xaZXdhSDNj?=
 =?utf-8?B?d3pOM0Y3RGoyMDRQUm5lUjRTdVNqUHJlUldJVUkvSlZZUFQ0MEwyOFJTenI5?=
 =?utf-8?B?bWFUYnQ3aFE3U1d4aHJ2TlVJQVo4elJNZk5SVmtlcHRRRWJ0UjFmRFhvbHNP?=
 =?utf-8?B?dzhlc1Z5ZnVISlJPR1lxOGVGMVlYRnRBS1I3RlRTbktiTTV6RE5wNDM5cmJT?=
 =?utf-8?Q?mbD3YBfFJmmBBB/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WTNk6cMvPzr2NmkJtw5u26F7r+X5XZXPuDPTxvuSFF4UUmPDp8YgglG/pq4jyPdUr7GwR7wARJct9dlLmiEitySF4AoDXL7shHfVNZb7yNR/B8HLzvZyKT3jvyV6d+mlKd1B/ETolwOh1Lo7FbFCeO/M4GhO7UBFTKMFVWywOoQIcQqHcaD9jb1kl/ZAooTvrftV3CiN0N8JTHw942ilklzTVvt63zD+WendL/EP53jsggYR8Y/f7lj0op7mBFx+79+siT9pTUGdUYPTpq5nUZ5kdHeu/hIcXAVqGQG/HZEDzjz/Cw83H26kBdlC6a9gc9L0Kmv2AnU7/xjwW9isa8nOZ8iagk3irCRCOga6YQFstWgCbCVSLo62LVBp6nlVGrJIuAQGETqDTtXTAdaUcDLzEm8K/mn2/CND6voueTUlRmS3VkAqfwHBpVLEKmwZScDDfBBCZwYGuY8MN/swK1kuBa2uNxwVmmV3zVcOCE8JBV2oxImSuV8P1Qdh1hMKu9BzbOxKoIsNSGk2CmXsjBaIEUutFnyIGB7IisPoQD8erqhPQ8ulXs5t21vEuvJ9hSiCFsxTho3QwjmTHUgPmnlL+ohd8oGNs1e03zjQ760XRpQp5/fkTJ0fWBAR1H1JalO7rAB2k4BONY8KikAaAHvugLNkG/2JMv++OB3nsD5axJvWSaHxNuf19Sgv1haJ+0RGpvIT7SZya8WMfyibRmFmGh5nTtOa9Pnh7GTQQNhHc5KAkRbewFrLHeuFlrzf
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4P286MB5641.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cd174a-6832-40ac-ca88-08de5dfde43c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 23:43:37.0192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGTSoBIGDmLAlEUUHaOaFtBKr/NLx0yAW542+jK9qBEg25ivK+Y38g9TZv9LF1U0W0IVTzqNBMlaeM4VkjL383jp9ElAo8AOOA6WmkP1CJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2392
X-CC-Mail-RelayStamp: CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To: <vincent.stehle@arm.com>, <u-boot@lists.denx.de>
Cc: <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>, <trini@konsulko.com>
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

SGkgVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5j
ZW50IFN0ZWhsw6kgPHZpbmNlbnQuc3RlaGxlQGFybS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
SmFudWFyeSAyOCwgMjAyNiAxOjE5IEFNDQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZWZpX2xvYWRl
cjogZml4IHVzZSBhZnRlciBmcmVlIGluIGVmaV9leGl0KCkgd2l0aCB0Y2cyDQo+IA0KPiBUaGUg
ZWZpX2V4aXQoKSBmdW5jdGlvbiBmcmVlcyB0aGUgbG9hZGVkIGltYWdlIG1lbW9yeSBieSBjYWxs
aW5nDQo+IGVmaV9kZWxldGVfaW1hZ2UoKS4gSG93ZXZlciwgd2hlbiBDT05GSUdfRUZJX1RDRzJf
UFJPVE9DT0wgaXMNCj4gZW5hYmxlZCwgdGhlDQo+IGltYWdlX29iai0+aW1hZ2VfdHlwZSBzdHJ1
Y3R1cmUgbWVtYmVyIGlzIGFjY2Vzc2VkIGFmdGVyIHRoZSBtZW1vcnkgaGFzDQo+IGJlZW4gZnJl
ZWQuDQo+IA0KPiBGaXggdGhpcyBieSBwZXJmb3JtaW5nIHRoZSB0Y2cyIG1lYXN1cmVtZW50IGJl
Zm9yZSB0aGUgaW1hZ2UgZGVsZXRpb24uDQo+IA0KPiBGaXhlczogOGZjNGUwYjQyNzNhICgiZWZp
X2xvYWRlcjogYWRkIGJvb3QgdmFyaWFibGUgbWVhc3VyZW1lbnQiKQ0KPiBTdWdnZXN0ZWQtYnk6
IElsaWFzIEFwYWxvZGltYXMgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz4NCj4gU2lnbmVk
LW9mZi1ieTogVmluY2VudCBTdGVobMOpIDx2aW5jZW50LnN0ZWhsZUBhcm0uY29tPg0KPiBDYzog
SGVpbnJpY2ggU2NodWNoYXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPg0KPiBDYzogVG9tIFJpbmkg
PHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gQ2M6IE1hc2FoaXNhIEtvamltYSA8a29qaW1hLm1hc2Fo
aXNhQHNvY2lvbmV4dC5jb20+DQo+IC0tLQ0KPiANCj4gSGksDQo+IA0KPiBIZXJlIGlzIGEgcmVz
cGluIGFmdGVyIGZlZWRiYWNrcy4gWzFdDQo+IA0KPiBDaGFuZ2VzIGZvciB2MjoNCj4gLSBNb3Zl
IHRoZSBldmVudCBtZWFzdXJlbWVudCBiZWZvcmUgaW1hZ2UgZGVsZXRpb24gaW5zdGVhZCBvZiBr
ZWVwaW5nIGENCj4gICBjb3B5IG9mIGltYWdlX3R5cGUgKHRoYW5rcyBJbGlhcyEpDQo+IA0KPiBU
aGlzIGNhbiBiZSB2ZXJpZmllZCB3aXRoIHNhbmRib3hfZGVmY29uZmlnICsgQ09ORklHX1ZBTEdS
SU5EPXkgYW5kIHRoZQ0KPiBmb2xsb3dpbmcgY29tbWFuZDoNCj4gDQo+ICAgdmFsZ3JpbmQgLS1z
dXBwcmVzc2lvbnM9c2NyaXB0cy91LWJvb3Quc3VwcCBcDQo+ICAgICAuL3UtYm9vdCAtVCAtYyAi
c2V0ZW52IGVmaV9zZWxmdGVzdCBzdGFydCBpbWFnZSByZXR1cm47IFwNCj4gICAgICAgICAgICAg
ICAgICAgICBib290ZWZpIHNlbGZ0ZXN0Ig0KPiANCj4gVGhpcyB3YXMgbGlnaHRseSB0ZXN0ZWQg
Zm9yIHJlZ3Jlc3Npb24gd2l0aCBzYW5kYm94X2RlZmNvbmZpZyBhbmQgdGhlDQo+IGZvbGxvd2lu
ZyBjb21tYW5kczoNCj4gDQo+ICAgLi91LWJvb3QgLVQgLWMgInV0IG1lYXN1cmVtZW50Ig0KPiAN
Cj4gICAuL3Rlc3QvcHkvdGVzdC5weSAtLWJ1aWxkLWRpcj0iJFBXRCIgLXMgLWsgInRlc3RfZWZp
X2Jvb3RtZ3IgXA0KPiAJb3IgdGVzdF9lZmlfbG9hZGVyIG9yIHRlc3RfZWZpX3NlbGZ0ZXN0IG9y
IHRlc3RfZWZpX3NlY2Jvb3QiDQo+IA0KPiBBZGRpbmcgc29tZSBpbnN0cnVtZW50YXRpb24gaW4g
ZWZpX2V4aXQoKSBhbmQgdGNnMl9sb2dfYXBwZW5kKCkgc2hvd3Mgbm8NCj4gY2hhbmdlIGluIHRo
ZSBldmVudCBtZWFzdXJlbWVudHMgc2VxdWVuY2UuDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvdS1ib290LzIwMjYwMTIzMTA1ODE0LjEwODM4MzQtMS12aW5jZW50LnN0ZWhs
ZUBhcg0KPiBtLmNvbS8NCj4gDQo+ICBsaWIvZWZpX2xvYWRlci9lZmlfYm9vdHRpbWUuYyB8IDEz
ICsrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL2VmaV9sb2FkZXIvZWZpX2Jvb3R0aW1l
LmMgYi9saWIvZWZpX2xvYWRlci9lZmlfYm9vdHRpbWUuYw0KPiBpbmRleCBkZGM5MzVkMjI0MC4u
YjQyNGQ5MjQ4OTYgMTAwNjQ0DQo+IC0tLSBhL2xpYi9lZmlfbG9hZGVyL2VmaV9ib290dGltZS5j
DQo+ICsrKyBiL2xpYi9lZmlfbG9hZGVyL2VmaV9ib290dGltZS5jDQo+IEBAIC0zNDk0LDEyICsz
NDk0LDYgQEAgc3RhdGljIGVmaV9zdGF0dXNfdCBFRklBUEkgZWZpX2V4aXQoZWZpX2hhbmRsZV90
DQo+IGltYWdlX2hhbmRsZSwNCj4gIAkJaWYgKHJldCAhPSBFRklfU1VDQ0VTUykNCj4gIAkJCUVG
SV9QUklOVCgiJXM6IG91dCBvZiBtZW1vcnlcbiIsIF9fZnVuY19fKTsNCj4gIAl9DQo+IC0JLyog
ZWZpX2RlbGV0ZV9pbWFnZSgpIGZyZWVzIGltYWdlX29iai4gQ29weSBiZWZvcmUgdGhlIGNhbGwu
ICovDQo+IC0JZXhpdF9qbXAgPSBpbWFnZV9vYmotPmV4aXRfam1wOw0KPiAtCSppbWFnZV9vYmot
PmV4aXRfc3RhdHVzID0gZXhpdF9zdGF0dXM7DQo+IC0JaWYgKGltYWdlX29iai0+aW1hZ2VfdHlw
ZSA9PQ0KPiBJTUFHRV9TVUJTWVNURU1fRUZJX0FQUExJQ0FUSU9OIHx8DQo+IC0JICAgIGV4aXRf
c3RhdHVzICE9IEVGSV9TVUNDRVNTKQ0KPiAtCQllZmlfZGVsZXRlX2ltYWdlKGltYWdlX29iaiwg
bG9hZGVkX2ltYWdlX3Byb3RvY29sKTsNCj4gDQo+ICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VG
SV9UQ0cyX1BST1RPQ09MKSkgew0KPiAgCQlpZiAoaW1hZ2Vfb2JqLT5pbWFnZV90eXBlID09DQo+
IElNQUdFX1NVQlNZU1RFTV9FRklfQVBQTElDQVRJT04pIHsNCj4gQEAgLTM1MTAsNiArMzUwNCwx
MyBAQCBzdGF0aWMgZWZpX3N0YXR1c190IEVGSUFQSSBlZmlfZXhpdChlZmlfaGFuZGxlX3QNCj4g
aW1hZ2VfaGFuZGxlLA0KPiAgCQl9DQo+ICAJfQ0KPiANCj4gKwkvKiBlZmlfZGVsZXRlX2ltYWdl
KCkgZnJlZXMgaW1hZ2Vfb2JqLiBDb3B5IGJlZm9yZSB0aGUgY2FsbC4gKi8NCj4gKwlleGl0X2pt
cCA9IGltYWdlX29iai0+ZXhpdF9qbXA7DQo+ICsJKmltYWdlX29iai0+ZXhpdF9zdGF0dXMgPSBl
eGl0X3N0YXR1czsNCj4gKwlpZiAoaW1hZ2Vfb2JqLT5pbWFnZV90eXBlID09DQo+IElNQUdFX1NV
QlNZU1RFTV9FRklfQVBQTElDQVRJT04gfHwNCj4gKwkgICAgZXhpdF9zdGF0dXMgIT0gRUZJX1NV
Q0NFU1MpDQo+ICsJCWVmaV9kZWxldGVfaW1hZ2UoaW1hZ2Vfb2JqLCBsb2FkZWRfaW1hZ2VfcHJv
dG9jb2wpOw0KPiArDQo+ICAJLyogTWFrZSBzdXJlIGVudHJ5L2V4aXQgY291bnRzIGZvciBFRkkg
d29ybGQgY3Jvc3Mtb3ZlcnMgbWF0Y2ggKi8NCj4gIAlFRklfRVhJVChleGl0X3N0YXR1cyk7DQoN
ClRoYW5rcyBmb3IgdGhlIGZpeC4NCkFja2VkLWJ5OiBNYXNhaGlzYSBLb2ppbWEgPGtvamltYS5t
YXNhaGlzYUBzb2Npb25leHQuY29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpNYXNhaGlzYSBLb2ppbWEN
Cg0KPiANCj4gLS0NCj4gMi41MS4wDQoNCg==



