Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B18EDEC03
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B7A383F0A;
	Wed,  4 Mar 2026 05:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="K0IYL8JV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2663283F61; Wed,  4 Mar 2026 03:42:11 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47D483E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 03:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0UkZgfMiHtcZ12SB9ZwJdrbMirTheb9UNva68rg46i2WUuyvlgR9ua/UDaSOxbqTdr0nUrAz4LyDU+zoQcbcTOQ9ZOAOhTpMEUJeC3rPgu60i9+G2FxGSLeLPB5jlt/SXEK6xV4+XxIEkMujNWaFuoMO1fPOOazeZMUTRa2rFLEHk8YBMMtPRViWj5Bf46BPe/ZNyxg84qxDrgdo1TZiawShc+IPx0OcJ1YNNZuW2EMdakr27sUWJ4gDnuJYo1Q0ZApQrom7MfExjyiSs7V7SmKJegCSoDv4zEVwS5I8yIh8RsXrZ9VwafMHJHHQjeZOIRP92QfsEYebMmKorJvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tf4MuZvtCWf51Zd6Cd77LyN87OEmdiPxFXX6l/iSNBY=;
 b=SHt524H9LNVDLY6WcS0R0YvVvNbSPe1DOFZL9xrWTFD2wi9Rlyg4MX5hVb23ozCAuYn56SWtYmZ9ZLbLkvzg4R4zK/Cx816lKfhnudr2lZivz0sv5ANZlTrTCOTN7mfxuxWbTEAVx7gQV1gGG368cnafj/wLNIMHfHIg6jU3LApljm3/LqNAeg2Jtn4Qvy1RQQjhUMi0HIo9+NzXZwTeiQmipg1ODwUwjt7AFnpZYrJ8TvzR8CD7SYGCeDgqwQUtAYJQhbbAZgETRSsEhMLQacSUX1YKbsHhugTrB63KthdQrKndDz1hY4TddjzyReV5Pi5OL4EW5e7BDLz+KAtiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf4MuZvtCWf51Zd6Cd77LyN87OEmdiPxFXX6l/iSNBY=;
 b=K0IYL8JV8Khh7WaF+wChp9q22qVs8RgmC8NI+G2ISpCQuMOMk4i7orE4ICh2MkZ6xTGABcZJBXLYaVKWlQ/AGmRfTkXhqJzMDQEMuhEB+DLBns/Ka9+aHYLn+DOLevPh0es6jyEb8CTgY7L7SuWFJGmJGZdJ7PZn4uqn75nKLL+PHUSvM8EYaEXJ6+419BDKFtwN2l2iS1M2MfWSK5LjXCUcyhHh+QQWZKaIdvcpOzJUvSsCJT6yeL5L8MtOAMONJ4FGBgUqWFqiMNqKyk96r5DuX5mFLKAKmBmrvaUYeM9WKz5SdSs83TLFMs6u5QwEmZ6+b5MwSIVFbeAyGUAWMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by BN8PR03MB4913.namprd03.prod.outlook.com (2603:10b6:408:df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 02:42:05 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 02:42:05 +0000
Message-ID: <09b4a249-15f5-4e0a-ae51-b248aa57bcdd@altera.com>
Date: Wed, 4 Mar 2026 10:41:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
 <20260303143721.GM1388590@bill-the-cat>
 <20260303-choosing-chivalry-6f892a14eaef@spud>
 <ca14a108-6308-4b48-981a-a0d20b716ded@altera.com>
 <20260303170554.GR1388590@bill-the-cat>
Content-Language: en-US
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
In-Reply-To: <20260303170554.GR1388590@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|BN8PR03MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1e0b62-454a-45e2-a251-08de79979eb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: kuTlx0rpT3Uss16eGlbxdv0jH+L50AcT3kdbn/+49m92tLKKnIoor/u16DEIYYWarykifUIpHSPb/oY/qXHFf5j1PefSfEMWO8sXJ0oYnwUW/wp3kZ0t3k72zCxNymqLUo3ksqPi8uzZ3tUnsr56IsT99f7Hryd0EJSBAL6j3cg2i1pYWqGJWTgiQMsh5rPqsOS37/XSliHJ+ZfbEHZqXFO/nenSEkFuRisdQgFJqjY59xEm4IY9pgwtc8WGWTXKNhU6CAzaw1lVD27Q7jv4AhXzOouiYagD5vuK0Iavge8fBJtWukEM0nCcvV5dTA4Cbg5EKOaY3123mVOtL04cYh9KeFlTcLLNH9TIZOuo+X9sWfoKIFeuTT36IsVTpcnbtDYhMJYRiixC3wke6jIfzHBxlGwKKC/Y3eqXD6Sn+u/GSIBEu2vR0rNO7c3NZVr5pb1G1th9eaEXkSQo7gZtpbGhLfhjW4GQ3kkB76LKkfkdXVmOxTfj5G9jEtubeV0fgxx11EynCYMPVYoMmI+1bsSSCfX4NT07uqtIKG/t97g+yKYINJ3xZkDiuFn9r/GVWf/bq2JrAlkh3ALKMk24oc4vAFHXHbnzw5NP15P33GtlB08dUBsJSvpg5dqhPAefK29zJK5nDY4ObdlmgwMKtJ9T8mnNvmt2Wkw+1isMzqKIZZ8Evhp8+QE9wQeTuZ7oiDkrR6JcyNdLfE1982108N+oheL5bmEAR5R4quogh8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpYZnFNZzYzcTBTeGJrUVhJOXNhZytzUUZ2aHJDMjRlKzZMY0tidXFIck9o?=
 =?utf-8?B?WFc1VVY2bkRVUjFNY2JmTThJVGpMUU5YYTVYaVJQMDRkMVUya25ZMzBIMXd2?=
 =?utf-8?B?SEQwcDd1TEErdHRSOWJxZ2RqTnhBNmJabVNMaUxJbnlialJaQnVqbXJxYjNS?=
 =?utf-8?B?bm9sRXNhSXJyMDliRS9nbGcxdXl3M1RFRU93L3ZSWDd6MkFDdTZlc1dHcUl3?=
 =?utf-8?B?UGRFa25IMTNrUEszTmtlM21DTUFMSXNYTTZKaWFUTnY2TjZ6Skh1Q21HVnpW?=
 =?utf-8?B?aHRKaUZNREVEQVh5bHBVa09vd2ZBNkdCUjFQdGtrZ041MjZ5YWhVMXM2SFVz?=
 =?utf-8?B?S3l2cWxsMlZyRUVQMzNNTmpReFA3SW5iS1E5bUtoUE9nVGw1ZW5KTWZjRlA4?=
 =?utf-8?B?R0pMWkZQclJDTUJ5YkFZUzE3QzhoUXdXMG03OGY0T25Qa1Z5N1FXRXB1V0FH?=
 =?utf-8?B?bjMvRUNWRzdPRDZhRWdwTmpQVEczNkgzbzZaWENLaTlNMy93YXFtU0xGeklz?=
 =?utf-8?B?dTdHMldiOG1TZzJZUjRQN1N0cURPeTZjM3hLaVVsdzF6MU5HMk56RjN1WTRk?=
 =?utf-8?B?OGtpLzc2cWl4WWxORGQxM1NwZFhUMFc0azdnTjFBbmwxa1E5cVFENHBVeDBh?=
 =?utf-8?B?KzczMGVKMjBtMmFTb1pxdVFwZWpqSUpiWXcrTG1QSnRaTzRPcXlPZUtvWnE1?=
 =?utf-8?B?UDh2cm1CcEs3dWc0MXp4dDA3TUZJbytlamxhbU8rV2E0Qk9NNXlLdG5MRlVJ?=
 =?utf-8?B?bWFoZ2JPVWFPdHBQNzI4MVMrZ2dRSU9JaG1EeUJaTmI1S2N4TS9PbWo4N0Fv?=
 =?utf-8?B?MlpNN3NGa2lhZkh6U0lwc0czUTFnMENWeXRpc0xWcG1pV2pWRGl6NjRDZFk3?=
 =?utf-8?B?WjRIa1BjTlUxNHFkQUFOWVN3eHVwMEZic0R4c3hVT1FZZmR1cU9nUFpoRmpu?=
 =?utf-8?B?QzRWZEVFZXhYLzZPMTdPN1grK3Qwc05rdXYyZE9rWVlieWFzK2ZtN1RrcFlp?=
 =?utf-8?B?MG8zbGhWVmFKdzN6eVdPNWE2WkRSbVBGTW9mUjlmaWhwNkxDb3FtMTg1OTJk?=
 =?utf-8?B?RlAwZU8veDMzamJzYXJEOFBOTHpFM2ZLTXVnZFBwTmdCWVpUeE0vNUZMRGVH?=
 =?utf-8?B?SnMwME9kajZZRnZSV0hERnRsZkZLcFF6bC8wMVNyWU14T2pDUkpBNUM3OTEy?=
 =?utf-8?B?OHg4dU1TZXlFbzNSWjJ3S2NJMUw1WXdzbzVpY2xOSDJMVDNYYUFQSUc3ck5Q?=
 =?utf-8?B?NEx3MS8yb04vMUNWQTNKK1l0R3hmejg4Z1RnTFNTUjFub0dmcXdlZFBzczNv?=
 =?utf-8?B?SWNFcDRXUHFWVGRQeVdQa25BbXFLZHBaUVhXbGJORjVTdkFFakV6c0JKclM2?=
 =?utf-8?B?ZEU3UjI2NVE0V2FrcDB4T25rSVFxM1ozZlNWWGY5SmxsYTNtYnNMNFlUV0Rl?=
 =?utf-8?B?eUtnMWtNQStCQ0lPWWhOU2k1OENwM3RhSjIwb3pGekhDbnhoWmYrNnBSV3dB?=
 =?utf-8?B?MkNIK2xONVB3amJUOUtCZS85dzVvYXZZMnBEZGdNUEVaQlNMZVE1Ymw1bEEv?=
 =?utf-8?B?WGF3V29wWlkyOVdiN0ZIMFNzekJrUU50WUI1TDNsbTNPOW5YNjZYcEtIb284?=
 =?utf-8?B?T0lneFhSTFR0NVNpRzVNZjhsOTJ0NHFqbEFFQlkyRmRadEk3RkNIc0JIMEdB?=
 =?utf-8?B?dWRxaVZiTjBUK2NTL0ZDYU8yc2h2Q3V3QzE1UTRoQTVHNmgxajlsWjFiWkRq?=
 =?utf-8?B?TWlRcGtYZlBYdkprRW1MMFJFUFNPSE9mK2tyczZMcHNKYjNkV05ubG9oNE42?=
 =?utf-8?B?Rll6QmxwbUpIQ1pKREk2WlVIVDBNZFhzZUxIbGEwNUE5RkgxcUdXM2EwSGZN?=
 =?utf-8?B?YnNSQklPRGc2ZDFnTkxsRnlpMDREVE1Tb0ZZMGFOVk50TTExKzROcjN4Q0FS?=
 =?utf-8?B?eEVPMmJHS0MyNUI4Y3pDaVB1MnBxeXJ5bzZrdkJDR3NpbyttM2wwT01PSlhL?=
 =?utf-8?B?TU8xb2xoV2lyZzVsdEJPQUpFUnFyRjhFZXdBaVJUU2x5Q0RVNTB1a1pGSHJn?=
 =?utf-8?B?V2RrbnpLUWU0SmRhemRBUWx1NkF0cS90UnowVDJPd2crZDFBYkJweUVpWE5h?=
 =?utf-8?B?dFJqWmNGUHdHY2F3VDlaUUhNVEV2MHFhc3BJbFBaMmVwRXY5NTZBRGc1OXVy?=
 =?utf-8?B?UW9jdXJlQkI2NWN5VXNNRnJTZEFIaDZ6cTlRc3d6dGFMZHliY1hmZ2l0MHhy?=
 =?utf-8?B?Y0lMTUwyb25ON2p4VlpNVTJRYXpJcFd0anFGTVMrdDV4eHllRys4cUdoUHlJ?=
 =?utf-8?B?WVRkQUtDRTU3UE9hc05XRFk3djRWWm91RkhlVDN5aFlGR2dsMFlXei9DbEh5?=
 =?utf-8?Q?BttSHuEqZYRhHyz8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1e0b62-454a-45e2-a251-08de79979eb7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 02:42:04.8852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvGdr5IAz/sHn9Si73S60FskcSOHWGR2cB7QtTxULoBiGY50JjuQjEnPVEOFP1lzcKlFwSzuyU1LOKLdZbHJUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4913
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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


> 
> Thanks. And can we reasonably follow what Linux does here instead?
> 

We don't have ACPI in our devices, instead, i think that can be replaced 
with DTS.

-- 
 >
