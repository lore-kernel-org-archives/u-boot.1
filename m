Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F1DD116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 10:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F218844E5;
	Fri, 28 Nov 2025 11:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="s0mBTvBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF5F844E7; Fri, 28 Nov 2025 11:51:23 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8555C844C4
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGE4B5EzkKbeKcCKhBEagF2PRLHuMCF8QgINTrW54xYwvQHP2BEiCCgqX2uQZRfIskIP2qa2N2IGNQRNY7gaayOwf04mKO5ZV5uQ98o/e5mae6d+MZbJlRsZNxXA5xeNOBF0XErSzS1AaF7o4+7ZxL5FqwcUyviE/3xI3kvaL7JlsIaSb9cDzSyP2asmZ385/al4OmfTfCt78+F3CgIICy6dq7+dGJzSLGunXTzSPfydlVPqvWTtsxUvBk/cNNnY4WkX9uz3NMXDnLBgJqraUrFz9cNwRAAnAyn06aZESqVTvYJjKw4PteKFr6myvK71DrLnmoAmVRKyajgzhIHelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17S+mzY1dcb1crgKoRI1RG1sqO37vCWpGUToF/v4PJU=;
 b=vKPkQaSBfjQJ0h9vQbGo2WtWaHSGSQEvxe4CxrNLLLn9pTveMAg3Nl4nQ9IHQCX4ykM4LWkmwL2I7rtWR9add0S/+FVi085eNIIijNuNxUIrd38j2eJqn68GiVGuvejkqmt0Zy+V9OLoLRAhgUoGPI9Do2SH/He+7wAS+Rn/MrlR8Rb2a4sxXtTGMh374nOEtKqg53JpSI2Ii6VvL23rVmpMV0XDSi5QCD+Z1PWFhUTgarFxeQMz78LNKAkIBOyZ64TmoXBd3ozXPEFkHDEUivqzxmfE3e8Dpsos4po8u1RcxjlP0T6B8w/PhW+8HWvZmNmW2C/SlLflt8gYQNH6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17S+mzY1dcb1crgKoRI1RG1sqO37vCWpGUToF/v4PJU=;
 b=s0mBTvBqF/SpK7ZEwoCVrkVaPlbKgeusfc99iCQrPaE2fOBRGx18iGm+QsJP1+FVMRQskxq9d/RSfrT2AYp3UgQ1ji7jiKwi8rtc4iF6c49lBhx+KKV7CdY8ESuKXFwX8+62XW4/ClmKhI7wb88taYDVd7/HDLDyVqBAl+WqSNc/zuGHi7DYvVwefIuAQWeKIz9vFmFQ9EUVm+IWSaenafIpbxZQXqtWc0ha4OXqUdCPO18crtEGOhaLnYzsdJzZE0yT5gDzbvdpAgGiojP48ZdR8eWRLnHqwBCGgit2zHCH82rH/Zz3kYoRfKsEwS7ub4HMEPmy7ie8se4Z7WWRgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6669.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 10:51:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:51:19 +0000
Message-ID: <1d42f643-41a0-4a16-8269-5bad7bf8953e@siemens.com>
Date: Fri, 28 Nov 2025 11:51:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
To: Brian Sune <briansune@gmail.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251127192136.168-1-briansune@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251127192136.168-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b55130-a6be-4e15-83e6-08de2e6c0fd7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UndhMTQvdE9NRUZDUUhaVmQzeWgzZzgvaG1WOGpvdUJFb0xLK0ZxVFFqT05I?=
 =?utf-8?B?WEJlaHVkTStqMnhYdDNDT0dNMUJXalFzQVpYRCs3NFZiUVczWC9pd2xoWjRp?=
 =?utf-8?B?eE9aWWVOVFhmbmFocHNKZkhhSDFlenlqOER2TTV4VjdsK21MUGF5UmQraDd2?=
 =?utf-8?B?aXN2dXFCSFM1VWFDUnhJblBhNVdXTThsNEhxT3ZUamdrMFljRnpWS1FIaWU4?=
 =?utf-8?B?VFp0azBMd0x0TlFTanIzSHF1R25tUjRHNjl5MW4zNGRJd2p2QmdzN25GN0Yr?=
 =?utf-8?B?cTdxanR0ZFI1SmxaVG5henNVekZnWDMwM09TMkMxNzhuWStETkZuQ0FENmc3?=
 =?utf-8?B?b0I0SEx0eENibHNBNGxmWnRDbEZMa2xIVmh0MWFQK3o5U0FSWEY5c3FHekxl?=
 =?utf-8?B?eHhKRGFoNjJpZ0pOY3NUakV4dDMvbnBuTW5hWGpEem5NbmtIR3Fqakdqakhl?=
 =?utf-8?B?eEtuNFc5bzRGUWViSUpFb2plSDRsdjBvNmtldlFWRk16MElHWUhFdmtLcHdn?=
 =?utf-8?B?bm02UGJGbUROUU5aam1Vd1VIeG9FOW5hQU0wYi9UOXRQZkQ5aVk4TXIwNnNl?=
 =?utf-8?B?WnZoaXNCbEF0d2VvUkdxWmJKWkgxYzJFS3RjN0JRbU9zYVUzMHNzd0IrVGFP?=
 =?utf-8?B?c2pQU1dadE5mVUQ3cWtPQW11dHpzZlhkUHJWdXRJNVpiYWF1RUE0NFZhQ2M1?=
 =?utf-8?B?WmNKYWRhTUtTOVFBL0UyaXFjdEttNDlsTGFUVlluVi9nZjF4Qnh6UGRTcjRR?=
 =?utf-8?B?dkE5emgrNU9DVjlpcWx2dHpxNTdKT2hKZUdEMjlSYTdCUm5ZMzBSOWpUY2Y4?=
 =?utf-8?B?RkY4aUlrN05VZFRmcklMNHU1NENMS2s0aXRhZDFwT1dhNlFqVlduMzFhb2Uv?=
 =?utf-8?B?SDB1N2FDNjlQQmtjSlVZMURmcERJUVQyTnk1U2pKTlNXVDFpbTZyRGVvTTZD?=
 =?utf-8?B?ZHVkV2c2cVpENVZhZmo1QWl1LzRadWFLMjZBRzArQUlkVUpQN1UrdktzY0Rm?=
 =?utf-8?B?YWVZc3FJaTNuY2hLajJZcW5xdjY5cDVRV0tPMTlqeWlqdEpOcUhMWmlxVmlF?=
 =?utf-8?B?a3U3dWhtUmdUbWtLd3Y2TTV3cGNtaU9SZUNrSlNtWDJ0aGJDSXVxUjNUb2t1?=
 =?utf-8?B?cGo3d0tPL2w3U2t1RmxyOUJDbFg3LzRseU5EWjZjUXFqZmdpODdaWE1qKzda?=
 =?utf-8?B?aE5Xck9MSkVkd1JWUE1pbS8zVFFBMkdxc2xrQTRMd2NTQmJ5UElkQ3VkVnlT?=
 =?utf-8?B?S3RINW9Sa0VONVZPYjVMdXV4OVJkeU5kS0pkSmFRTnltM3NCa3ZLVlduZ2FF?=
 =?utf-8?B?dG1KRC9WVStsbVBCRjhuS0M1bGhpeGw1YnNlR2kwOUZ4S3hPdEF1YUxwMm9u?=
 =?utf-8?B?LzcrTDJIS010d0lwc281ckI2YWxOSms1VmxQcVpYbmtjREVUaGZ3cFJ4bTZk?=
 =?utf-8?B?U0IxaUR4WUdqL3o0MTNxSFZkeVNSdXRablprVCtuL0E2Zk9Tb00wbWdVLzZY?=
 =?utf-8?B?NXZjNFhKbkhlemdncmdjSmQyZjJ4cEtEQXB4Sy9GZWRmME9DaGJQdFpMVkNF?=
 =?utf-8?B?aGZQdUEvL25MeURYZWU2WTBrQW9BNTE0cXR5TnB4aTRLelJlV2RJSmZsZkZX?=
 =?utf-8?B?YXJCTzFablJxaytxbWV1bjZkMlRQODl2ZHdQTVNJUUMvNUNLbmttczQvY0ZK?=
 =?utf-8?B?d1BVVy8zKzl2bmx0THE5cXNYaE5aS2hhUGtPVUZwNTQvSEFPUGJHTmpxRTlL?=
 =?utf-8?B?NmJIT0gxbnBYZ1R2eUlRQWltNUk0T1BXSFc1cTJQVkZaL25yYXZwZkpPclRY?=
 =?utf-8?B?QzgwZWI0aUIwU01JNTFJdXFBYU1DV1Baa0N0by9hbjJWNWJQMStPZ1ZHNFBr?=
 =?utf-8?B?RWphdlhUWjN0TE41ci9BSjRTRkFreXg1S2dNWjNkdHJSdDZEdXZLUFVEY3N2?=
 =?utf-8?Q?GnINsnnJYIIx0kD+0YpN+CQYwjF+OIBa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akp4YndXOU1Ldkh6TndWc3gyaW5Palg4TjUwejFTUndOWTJGejBvWWJVWFFE?=
 =?utf-8?B?N2RQR0w4NU9wWXVwcVRhbjlaUmFhcTErekowb2NqSE5rRzdlVUtaeUZxVDgv?=
 =?utf-8?B?WmlieWVxbnpobjFXTlNERC82NWl4OTNnTW94SnBTQkNjalVlRkVWR3RGcWRU?=
 =?utf-8?B?UHpha0pFTDZpQ0ZiYmFCTURINTZnTTVxWEdpRE51eXgvaG9jSGhKR1JxYWxh?=
 =?utf-8?B?TjlYRmh1MDgzSmdkTHk2a1YyM3B1QVpQNVJKSW5IVHI4c3l3MGVRbHBEajAz?=
 =?utf-8?B?djNEMVJDM1Q3VVNuaEpUSG1XSFJicCs0YUhBT3luQ2krdVE1cHIzN1FqOXQ0?=
 =?utf-8?B?SzdoYlg2OU1TNWlFaEpCU2VUbjBVdko3ak0vbkFjZFdkU2NENDNzVUFXUk51?=
 =?utf-8?B?akt2dW1CQXd3REV4djhIOEdOVklFdk9jYVB6RFlub1pKRDJ0Nlh5VmhPTW9w?=
 =?utf-8?B?S3p5dEt1UWx1bk9IcUU0ZXlOYjZRV3FaelFzVnl4REU3aEo3U1d0UDJjWUxq?=
 =?utf-8?B?cUt4SVg2NUpyckJpRlVKbU81QmdoWTlzUEozZzdxZ0s5Y1VlV1hyaUZsTEdY?=
 =?utf-8?B?UGlyVlUxbkgxeklJdEM3c1E5RzVXWUw3T3I3R2haOVFBTUdlTFBZdllTU01D?=
 =?utf-8?B?MlBwdFpwekFoUG1HMnZuSzhmbFdNNUNLb2lFRXZHajVtMGdjNENYMkV1Y2dT?=
 =?utf-8?B?b1lCeEtMRmZEeFE0RWo3eXI3MDlpcy9JU1U2YmtLOEtTUUgxOGlHekRZaXY3?=
 =?utf-8?B?amZWVXZUQ1lJM3Z1aDJ1L2R4R1FwTTBwUTdtSHk0SUVkeDR4bXdkVVBhaGVO?=
 =?utf-8?B?cG9OcVNqZmR1a0hjQ0RVcm80amNCN2lzWHo0Y0ZmNlJqdW1YZWdwN1JBVWFZ?=
 =?utf-8?B?akZOT09OTzk0M2tGWmljYUJWUEc3Y2RWb0FUM2JYeGZubDlzSjNucitpUTBp?=
 =?utf-8?B?cGJla0FsZERRR2trcUp2U0RRSUN5Z0FQYW5jdk1uaHU0VlY4TW5VT3FDSUp0?=
 =?utf-8?B?eThMQzhKN1A4UzAraEFjT1BSalp0QjFwYit0dVR6V0w3aXBkaitGbnhqd3NG?=
 =?utf-8?B?azhLRTFMOWd4UDRBaDczcXp5OWpXa2VocTBFcFFzUjlKeEd3SndrQXhSb0o2?=
 =?utf-8?B?ZDdReVFyTnBxUXhoUmxtTGZqaW5HR1pvU3VpWDlqN2F0QkRDaUFjcDF0V24z?=
 =?utf-8?B?QXE5Nk5ka01xMU5jRVBDN3FuY1A5SkdzeTJHZTVWZ2VYV3Qwd05jVGdWVEZ5?=
 =?utf-8?B?MUVnckR6M3E2R05pR1dmS2tmUFNYRXYrR3ZuSnZFUWV5V1dyUi9qVFpUQTJK?=
 =?utf-8?B?cWkweUo2OC9IaEROZWFLeW9UVHdGME5WYytFOHRwZG9GNHBvSFpPTmlrQXpR?=
 =?utf-8?B?SzhsbWNUdGM1Y3lSQ1pZbzBhWUVJblVXVXJtdVh2MUppQmthbmNFcDlLa0F1?=
 =?utf-8?B?K25XSUxqR3E2cE5NZmdIMk1oUCt3ZnBiaWc5QkNSMUQ4bkRvbW5wWVV1dERo?=
 =?utf-8?B?Y3pWVEZGQXZxOS92MkdUdDk3WWMrVk1hQURRSHhJS1Y2RFFCTmZsbTNDQjZP?=
 =?utf-8?B?aEg2N3dOTkFLRXRDOU5HaGNDZHFxcEhTY1V6VjVka0h3T0wxM1hWOVE0cG45?=
 =?utf-8?B?YlZjeVNrZTYrbEk4aURzL09NeFJSSy9CTFZ5c3c0VlFxZUxxOW0rdDhaTmFG?=
 =?utf-8?B?WDJkTEtsUi9EUlh2a1FqcmljWGhjSkxWMzZ5MXZiOUxtMVVHeXBCbTdYc3Qr?=
 =?utf-8?B?TkFOL0wxck83TzZQTng0cmx0QWxLMW1TeDFQV0hEYVAzZTRaMGpQL1krRTJ0?=
 =?utf-8?B?S1I3RllOVGJqWjFxU2p1RWdSbDhqVElTaGFkRGF2SitueXU0VStGYzhSakJk?=
 =?utf-8?B?dlRTcnIyR2dIQnZvL0ZGK1ZVYUNhcTFLUWtiUFRCMXFyYTgvMmRiUTExVWZ1?=
 =?utf-8?B?UkU4c3E1Mlh1UWM2NU9ScWtZMW1jNW52SklLaDFyR1hPVnFUbVNBbHdTVUZK?=
 =?utf-8?B?Rk14N0FnTnhLOFAvRXArRFUyYVZ3R0VEalFmU09HeURkaWorMU0vRk54b244?=
 =?utf-8?B?YzZkYTZLWEdiR2FYdEgzQWJMTFRmUS9uL1FOUktueUVERG9lRnZXZkJjT2h1?=
 =?utf-8?B?VHlWdmZhaGhONElCNnZwTTVzUjNxbXRwaDIvNXo5YmYxREhma01aUkkvK2ta?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b55130-a6be-4e15-83e6-08de2e6c0fd7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:51:19.1191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/wpiZjBB1byEyZWszUFcdUa7HKob8rKYgEU0BRUnsjLMXVXcEzelClBwH5gdHdghgUONvS7FJZpkSr7Kplisw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6669
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

On 27.11.25 20:21, Brian Sune wrote:
> Thanks to Jan Kiszka had provided info on
> u-boot is not able to boot by u-boot-with-spl.sfp.
> All three TYPE, #, OFFSET mode methods are
> nonfunctionable on combined raw boot.
> Explain a bit on the cause and solutions.
> The major cause is spl+u-boot structure is
> defined as 4x[spl+zero_pad] + u-boot.img.
> Deal to this configuration since GEN5 is used,
> the spl would require to seek by an offset
> on top of the spl offset. This means for
> each spl=0x10000 the offset is 0x40000.
> However latest u-boot do not consider this
> major structure on GEN5 socfpga.
> 
> Meanwhile, the default include file as Jan
> pointed out is completely wrong syntax and
> caused issue.
> 
> Combining both concepts, the minimum fix
> patch is provide as follows.
> 1) Offset is control and default set to a
> proper offset under:
> SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
> 
> 2) Only GEN5 socfpga will be affected and
> minimized contamination on other devices.
> 

Most bugs are device-independent. Those should be fixed separately, and
I was even asked in the original series to split further. Let us iterate
on that, I would say.

Jan

