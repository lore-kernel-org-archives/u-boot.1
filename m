Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCC2CDD0DB
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 19:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB878904B;
	Tue, 22 Oct 2024 21:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wQFi+4H6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE8889024; Tue, 22 Oct 2024 21:41:12 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806BE87042
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 21:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSQthnSPbIF6I9NwMVrqybMKLWK+sgvHj5ab+bt7Uem8m8s74aJSoHHAa3YTfEEF2PEWj8bYT0/nLQUrY/Y+ZC617SCOV02b7rjJGEkeuhewfxjQVfMzC0E8n1+xNtRjFKFTJbA0o9Ac2dppz7JY3p3bkxEaokyZh9QHNPhvhN7uNHs7S4tkHdhj6HQ62QKHt4jzyMVOch/XfwNkl6yv/Hx5167AncIpFIm0KHacVFdbZo3Qsxf0T/tYnhoQX7kR0/Svwt/8D9cVIYTl71NFvrMd7eEsvnEtk1oGOin2hQCqqz0N1F3MsmYfsX4POCzb4fQ7QqYlflvAYH6i88NzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE6cP9mkkSdxtHnEVSoZK3wwwnlZVbner+AdDfgj0Oo=;
 b=QIjavDLTbDz9WK4oNh5A+CyKFOLDjXYoEt3+SRQWTLg0KQ7aEOl86/aqhoI59UqGs5/B5R8Lbiy5LGtgcmBKNmZAdqb7QQFa0ithYfTB/fNCr7tICp96Tt+czq78FZd8jEbsW3BiD+JUTdsTrW4sV7ZKlOaGKr0YUPSfTeaY+Q/YkfcW8ur9n45Wa4tFOpHfT7kKxVXHCcrHkil62TsLQxpbqyZbP355OZc2YJp4jd9Pcz+QSFqqq2ToZE4xNaz6VeIjEEnnwTiYqkK38UkMJtKTC7eNg7/sJbQHDShapFU0sOripE0tPg4NChRgfPVVqVFDBHi5G3aB2m+8SEbj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE6cP9mkkSdxtHnEVSoZK3wwwnlZVbner+AdDfgj0Oo=;
 b=wQFi+4H65wQlxloZwXxyQ8fti2jbRlyJ4CK2bDye6SCa0IjV9CRtDybPRaOmOJumlzTf+ta3lMhCAbxZMPS+LvuTsGlhHS3AnvLJXzrmsw/fltP7oIwsJ2kEFMJyevi4U6VAi4IBvRBWBNLGf2lXF5jeJnOty3owDdKHa0KXL5yIDNj5kovygMI/oLIYPaSi0sLrctoID53Qs0S0IQVhU4V/tuXba6N5j+mFs0pt5fsfdQidDUtcqFKydKWewrrIx2/DOEc96K+6pVUCdK4Wk2TB4vyvFOedcogTJLQ9Ip7uZz1J5zyxUYEMILWYJGm8lNbGggwHyuQ0fBpaB1Ez4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB8033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:558::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 19:41:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 19:41:09 +0000
Message-ID: <a7031021-c8b9-4bbd-8089-c35a4d4e7ee4@siemens.com>
Date: Tue, 22 Oct 2024 21:41:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
 <CAFLszTitiTcf6HF_3FAxreBDOw8CFSekf_MHEzPcqwzj+b+bPA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLszTitiTcf6HF_3FAxreBDOw8CFSekf_MHEzPcqwzj+b+bPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 956a683a-0efc-40e1-ff45-08dcf2d17a13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzlWdmdaOW5QU3NDN0FKY1kxdm1WQ3JRUzg5S0NmQUcxRTExWi9xZ2laNys5?=
 =?utf-8?B?alhZUkF6bEFxV3dVbWprUnZOMGJjN3c4SVluRzA3RnpFcDJuYlRMT21sV1cx?=
 =?utf-8?B?bjlOeWlTSWcwTUhqM3Q0Tm1iZXBmR2xRTU1XeXZod3dpTlhzUUZKaWppQUJk?=
 =?utf-8?B?dGYzZ3lCdnNoNWlqNHo0b2pGR0QwT3lvR3dva2thejBSOEc0VzhOTVZ1TzFp?=
 =?utf-8?B?anJISUlrWUJnQk16VGF5b1IwVGZvSFRnZDRXVWFLSENJaVIvL2hGenRmdGVt?=
 =?utf-8?B?NURDR3Y1Sy96MUhraU1qWWFMSjNwQVlxWXMzYnRzdWYyclFlTWtRMVpnMHBX?=
 =?utf-8?B?aEhheWgyVkpDTHNXUHhyWGs5eHhDbCtpY0hyMExSRFZ2S09BQzYvMndmaVJi?=
 =?utf-8?B?UWVQZGVUVTdMbE1vVFhyUUE3aHhuUXhVaU9CeTFuV1o4Sm9QaGVxVnB5dUp4?=
 =?utf-8?B?MFZUdVhqekl6aUx6dldYRkZzdzdnTTNiMHA4c3pwK01PRUZaMWQvdmtPb3By?=
 =?utf-8?B?bUNhM05WNVF5dkV6Y3B0Y3EwVGVwb0pNRHFxNFRnV3FGK3hpNHcyRGRuSDky?=
 =?utf-8?B?dUpJRzdTSkVtbWN0TndQczZ4WlA2SGh2NmJmRVZWbGdoQkp0K1liVzAzcEN4?=
 =?utf-8?B?R0xJenlQWnN1TG4yRTA0OEJCUFZvdVRDVGpKUGxPd1JoZUV1NFRJcUg3NGZG?=
 =?utf-8?B?M2p5QlZVMUNxYy9sUWhzOUZTYUpORmQ1bVQwU2FSZ0NyS1NreVJYQmUzUEJ4?=
 =?utf-8?B?ZngyUlJWYjhyOENkOE5UWDJUUWdxTjYzcEF1WkRCNWk0RlRhK0Z2aW9uUFBB?=
 =?utf-8?B?RTA2dEpNa1ZkeWNLWmRFbVU3b3JkRW5PVytJdnJLdTRXWkdHUXc5dE9ySVRl?=
 =?utf-8?B?ejFnd3QyQVhUQkpHM0NPVmtTVG1wRlJlUUk4d1FSZnZxLzZkU2F1RUdzaXJP?=
 =?utf-8?B?NldhNXRLcGx1ck9ySGM0ZE9mMmFXbVF4Z3FocnAvOHRHdHlWT2RHaDJJbXlw?=
 =?utf-8?B?MEFERjRRVnJJMm1ZeVhROW5RcVJkNVFkaXBDeDZ2M2VicTN0UmRqaDZOaXU4?=
 =?utf-8?B?WVYzL1lWT2wzaU5KTDYzWHhXN3NUTDBzTmRJMHV1NStlU3ZUY0RiSWt1VEwx?=
 =?utf-8?B?encxVk4rTGwxYTMvV3dQUWF5UDVkaGhxdnZrY1NZbXE4eHI4ZHpYbmJHVXRp?=
 =?utf-8?B?ZW1NWGRLaUNzSVVUTzJkTDd1aVNjOXhqVlJtYnRpaVdHN1ZHbDQ4MnpYTXBu?=
 =?utf-8?B?L3Ribnh2MXpxS1dyMHMyakh2cUgwcXcydFNxSUpscFhKck5vUVdPRGpZRVpv?=
 =?utf-8?B?eEoxd1ptcnlTQmwwOTNxNWorQThRSHdpYVRUcG1hdjVwc3NHY1podEd2Yndn?=
 =?utf-8?B?TG1OY0NmZWdQeHJ1OEs3S09LR0VQcU5DVXhNYkpaVEhSVFRkdlRwc3BPaTdG?=
 =?utf-8?B?V0FkOWwvYUNwMlV2OXZ0Ni9kMGJmclJybWdDRFBzOStzTzgxN0FpanFkV25E?=
 =?utf-8?B?dVRTRXA4Ym84VmZyNE9Pc2ZaUVQ3NDkwcThSeTFKV0xNSVZJbTJmV1RpSVRE?=
 =?utf-8?B?bGxPZ2Vpc2VtcXRRM1p2YUVERVBONUpIZkYrb01OMXMrOU1BNFl5K1dGWVdL?=
 =?utf-8?B?SHlOc1hGTU5EWFovcGEwSW82OXpVMkZ2bDhQN3M2OVh6UlZnQkRheFp4dnoy?=
 =?utf-8?B?Sk1aTjBJMk5EbGRpVzRYelo5ZDNvVkptWHFmamE1ajJmYlBteHRwUWozVVdh?=
 =?utf-8?Q?i5y2+2k56T+6lZLI+3uFiBxW9mQV5k48P558uLK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBBWXJHaEpxWHpZUUJZRkhUOS9WaGxsYXRRWlFybFFyUnlHUldLcEw5MlZU?=
 =?utf-8?B?amdlaXJ5d3hVL1c3MUpkSEJLNDVlV2lKdEhZcGFIalA5SmNXR3YvMUVNS1ho?=
 =?utf-8?B?Si9yT0lGT0N2SEErK010ZDNHTEM4RGNKYlF6emVZS25YeG9GQmVjOXdsbTUv?=
 =?utf-8?B?VVJrREp5dWluT2VzZUVIaGFRV0ErMUsyQnpNNm91UHVCS3ZzTENlN2tUZGxX?=
 =?utf-8?B?VUxDbys3Y2FCdmZ6VFcrZHk1SkNIaXprL2NiUHF4WXJINjBvSk9yNFNLd0Zy?=
 =?utf-8?B?YktBWlBObGJRMjFMNFdYY000bTYzWnBFTDdlYTBaYW5rajFTOWJUTGoxSFRC?=
 =?utf-8?B?RTNYK2hCMnZaSm5jUHFNclN4OVhtOGZ5ZnBuY3M0S0FaeTdUUktyejJJS1JQ?=
 =?utf-8?B?a0xzNW11R0o2UlRuZlhycUl1MzE2RmdwVE5rS09qeFBINUlqaUw2L1lkZVps?=
 =?utf-8?B?UnRWSDAvSUJhWlUvZ2YveUtBUGZrN0t5NFBLN0R3eWtEK0xjOVdGTytrMFUx?=
 =?utf-8?B?ZTdoaFBPbXhlbzJPNkZJZ2ZFY05pUS9VNjNOTVMyK0NsenBRRExocTRYRzdC?=
 =?utf-8?B?ZFI5ckwrNm1ncENuRTJsT1N1WlNQTWd4bjR5bmZVVDhqdWp4MWRtQnUrZThY?=
 =?utf-8?B?bXZhdWw1LzRCUHl2SkN2UVFKMmwxVmRienRlMTM5ZHhUL01raXpJQ2c5OWdL?=
 =?utf-8?B?MEhCdGthbHp5SXlzSGlMd0lueG1OVFlPTlV1cnZ2bko2WnBMbVpRd1pCTGxM?=
 =?utf-8?B?RS9Ja09GclZjL0dtU2NGcHlBZ2c0eXlyR2xUY0M3YmFCZ0RONXlPTzZlTEVq?=
 =?utf-8?B?U05QUThPS0dTK1JjWG9oMFQ0enlZdVdMekZZUlp1RUlZOHZTSmYyZSsxdGZP?=
 =?utf-8?B?cnluZkVTdWh1NXNkYzJJc3NrdWhUMkNmbklkTWxBQTZ1TkxWKzBya1NEdFRC?=
 =?utf-8?B?OEd4S1lXRlVpcXo0YnRLUzJJTitDR29NOTlOTjlIeUlOSE8wbUtJelp4RFdI?=
 =?utf-8?B?N2dxdEhsOFYvdlFRdmRQMjJXUHg3cURTdzNyZlVPSS9DclRvZWJSWEl2TzMy?=
 =?utf-8?B?cEQ5MHVlcCs4M3RyWDROQWlJc2R0cGN6Wk40U1k0Q0FTNnNnbHV0cDR0dE5j?=
 =?utf-8?B?bHlnbXlhRGw4bCt3VnQySzFBTnhldnczaVViSEVqejJNUDVNYVZ4VG13NFJ2?=
 =?utf-8?B?bWNWenRjOHVKVE1CN2pHbG1ET2lLa2VMb01vSXBobkJ1aU1VUEt5Q1pSUE1W?=
 =?utf-8?B?OTJmUFBnYVdiNVM5bmtmTnFiZ1lXQUV6ZnNjVkM4WThhN3p6akxidncxMkhC?=
 =?utf-8?B?Ujk0WFlIcndRWlI2ZU9PUTc0SGVud2dQUEpkak5DUDVxRWo0aWdiVGhmQlNy?=
 =?utf-8?B?dnU2YXpvcU5RUTI3Rm0wa3ZuOGtKWXlLaHRmb1VBWTBSTUFqSE5xeXp6WUFI?=
 =?utf-8?B?U04wZW9KeXVsalNLOEthL2VTS25pRkRlNTNMOWFQMlp5dFlwK0JSWUtzQVBu?=
 =?utf-8?B?OTBHbU9IQnU1ZmhnMFF2WkxoRCsvdzFBN1liT3FKd2RRYnpoSm9PL3VXYjJk?=
 =?utf-8?B?Y1hCVkhtT08xTzdQRW0zWE1UV3RZZW96UmJPTWxIS05ib0NWcTRtaGFSQW1m?=
 =?utf-8?B?Z2phbWU0M1VUTlNPa2lERnZrNjd5MUFHQWpXcUtKdEFkTFU4bEFCUmR6UnU0?=
 =?utf-8?B?Ujg4amI0T0xDankremRNakYvOTNMb09XRUxUaVdtY2VrcE9xcU5yb0J1Qit1?=
 =?utf-8?B?U0JWSFZKajVjdG9GcXBSdmZjSlhodTVLOTkvL2NIS2M1TFhjTEFlOElGYTls?=
 =?utf-8?B?dFJRM0FFaXA3Z2VyUnduUUlNRTJLbVZlOXhLOC8zZGpON1VHQUxYWjMvam16?=
 =?utf-8?B?ZjEyaGFFVERwVUE2dzdJVVZWcjVjbWx6a2JmUmJtdmN0dExOS0IzcWJEOXJn?=
 =?utf-8?B?QmE2V0lsRHBKdVB6bUFUVUp1Rm5GSll0VVRKcjhvUklDRS9EcVdRRVp6L1pI?=
 =?utf-8?B?cjM3WVljMDAvaERJaXViaE5LMEt3MWd0VUpjazNKdlR4UDNMcTR0L3g0U29o?=
 =?utf-8?B?L3puSnd1TjRaS0t1Ty9JZllYMEJEKzBlbU0zelB0NVRqSjZuTEM5OFZwN2FC?=
 =?utf-8?B?dkw3bkphdnp4VGVtclZhcmdxZmpKY1ZNcUtCOHFaemltWlphZ2JYRUZVemlz?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956a683a-0efc-40e1-ff45-08dcf2d17a13
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:41:09.0995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUpt7R3R9UsU3AAJE3dTR39akD4c1QupPX20K79bF0/zyumelHL+lsFYP9knlo8ZeYWOhmXUqGBKihzFQKZuJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB8033
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

On 22.10.24 19:00, Simon Glass wrote:
> On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
>> be first used by the IOT2050 boards.
>>
>> Based on original patch by Li Hua Qian.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  include/sysinfo.h | 1 +
>>  lib/smbios.c      | 4 ++++
>>  2 files changed, 5 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> What is this used for? Would you mind adding a comment for it? Should
> mention that it is a struct uuid
> 

What exactly is unclear here? The System UUID is a part of the SMBIOS
spec that U-Boot just ignored so far.

Jan

>>
>> diff --git a/include/sysinfo.h b/include/sysinfo.h
>> index 8a77ef44856..1c5008b5f23 100644
>> --- a/include/sysinfo.h
>> +++ b/include/sysinfo.h
>> @@ -49,6 +49,7 @@ enum sysinfo_id {
>>         SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>>         SYSINFO_ID_SMBIOS_SYSTEM_SKU,
>>         SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
>> +       SYSINFO_ID_SMBIOS_SYSTEM_UUID,
>>         SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
>>         SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>>         SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
>> diff --git a/lib/smbios.c b/lib/smbios.c
>> index 7c24ea129eb..1441fa4cde6 100644
>> --- a/lib/smbios.c
>> +++ b/lib/smbios.c
>> @@ -387,6 +387,7 @@ static int smbios_write_type1(ulong *current, int handle,
>>         struct smbios_type1 *t;
>>         int len = sizeof(struct smbios_type1);
>>         char *serial_str = env_get("serial#");
>> +       char uuid[sizeof(t->uuid)];
>>
>>         t = map_sysmem(*current, len);
>>         memset(t, 0, sizeof(struct smbios_type1));
>> @@ -409,6 +410,9 @@ static int smbios_write_type1(ulong *current, int handle,
>>                                                       SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>>                                                       NULL);
>>         }
>> +       if (!sysinfo_get_str(ctx->dev, SYSINFO_ID_SMBIOS_SYSTEM_UUID,
>> +                            sizeof(uuid), uuid))
>> +               strncpy((char *)t->uuid, uuid, sizeof(t->uuid));
>>         t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
>>         t->sku_number = smbios_add_prop_si(ctx, "sku",
>>                                            SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
>> --
>> 2.43.0
>>
> 
> Regards,
> SImon


-- 
Siemens AG, Technology
Linux Expert Center
