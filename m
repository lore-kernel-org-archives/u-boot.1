Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB97E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D9F802A1;
	Wed, 11 Dec 2024 17:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="tBcVqlPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E74A580369; Wed, 11 Dec 2024 17:20:21 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5016380040
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 11 Dec 2024 17:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDRJR7l7x5xgLAqV6l14AjR1Z8Tqb1Q/E5K3FkLYd7ldJhFG5JfI0wCtT67p0VoTkU0DKFrvBQH6lAqnQ2KqF8b3WbG+k3TGgqZGGhhgbIPC0HH2wI0yK4HCAVE8s6qs4dPL/OMZG7IPSE9zIoOIi6sjy4AIJtC+BY7tqudYtJ5yFI/mzd/51uzb4RT5EPedj0ni5qRbtbsdmIrvdhUtJz3EPcqCQQ41J/naMCBOyiGyrgW+FMWIp03qz+Yetv5XdXK+B1iRmuxuK9MzOGyray/8/f9d3gyxgQNngEMUybxiWCcg0tiIJTOU+SyrK8IZLLtXjm1MCmKziFCLQ8c/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLzIxiWMc1Tw6M8papPu/R0GznGeyDjKXyujgpWAqYI=;
 b=b/lt85yDLEYRI7DmMp3VghBwNsCDYat6nR+ZwYOrJxBrUWCh92qQFGfkmXQdROrLdXK3iCccKLNIGA07sG9lLj9SCFN4P8VdXcxBpsPY0zRqMqc5QEdZRop+bFrOIcSCNEv6kKgp29t3iHv1wev5sDvlVtEADdsJJbBBg9NVu1Xr1OFjChB0Cogu5T9i1bqXKQqhzU6VeOiZ6qh/4LBoAPHm+ND+YQIw+ep1cX3UNX9VrnreG5lhJqVCUAr57hVDaOo9R+I6xbcsRT9jTIK2D1AzKmwHwXxCxDJQNhHSDHBrxPGyDvDatQ8PEXopIYPcsEBzs8Na26zjo5Qhe1JlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLzIxiWMc1Tw6M8papPu/R0GznGeyDjKXyujgpWAqYI=;
 b=tBcVqlPjGV8tyxF8knGPmDuW+wCT7hxAGX0p8ZQxc+oIObj5tzwaStpORIcS1Zj7HxCx2grHrbMmYrOpT8thMDfew0ZRldoeBTRNF4Yd/AiQ4TpJcM3MpYStBYlvZY30KPiqrvM3edtQemA7zcnAC/5r+4ecVZW0dOXAW/G/j4Q/TLoMw536B9oNABJHlNLoUTrJmGg32Af+p58ts/jHLLaEbqR+7UORMRckP8aEzZ35KlgAzk1ywHD6EkWtl5HyJoIwwSq39iKJsVXocJuVazoBzJR/o10udizs13hHNa8zVLUvjDMbfwCcYTCWtVKSxfHsmJ6K8kPuL1nsaQ1dYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PAZP264MB2765.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:20:16 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:20:16 +0000
Message-ID: <a10ca15d-5f0b-47ce-8c83-15d990f07430@softathome.com>
Date: Wed, 11 Dec 2024 17:20:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] test: lib: add test for key derivation
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
 <20241209094159.8355-6-philippe.reynes@softathome.com>
 <CAEfUkU+KwcdO5h88YYZYDa-y+XEp9u8b2ufQzY9677Gt0WdwTQ@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkU+KwcdO5h88YYZYDa-y+XEp9u8b2ufQzY9677Gt0WdwTQ@mail.gmail.com>
X-ClientProxiedBy: PAZP264CA0113.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::7) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PAZP264MB2765:EE_
X-MS-Office365-Filtering-Correlation-Id: 75077845-3fad-439b-5345-08dd19ffb28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHoxNVhiU09KTllZZGtNT2VXVGNmN3ZZWTJ6cEEzKzhTL3YyZzJDS0tkMUFj?=
 =?utf-8?B?TUpSeDB5cWFVck9UOWVycHUzRTNuQVlGT3RUN25JbERMUzdsNHNiQ3o5dkdY?=
 =?utf-8?B?bzZydlo4N2w0Y0NHamdBNEkvVTNIb1Z6Z0V6RWRrOUVlYXdKRm92SVQ0Yyt2?=
 =?utf-8?B?US9wTGpBbVNHS3FwZ2lHLzBQQnRrYkZQV1VQaWZpbEhKMHJ1NW5keEFKaGxu?=
 =?utf-8?B?RzM3dmtQd041YXNNK2owQWtSbWVUazhBRFR4NlBMdk0yVWs0V0Uyb2VTTU5P?=
 =?utf-8?B?WjVwVng2VWVsVEI0T2srRXIrbDg2ZzUyOGUvcThFblo0ZlV5U09Eb2E1RVN5?=
 =?utf-8?B?d2NTOWNONUR5S24rMDlYVE4rWU5tbFI0SHVxWVNkVUNLNWJRQnBiUHY4cVU2?=
 =?utf-8?B?cUhqV0pQTFFJUUxzbnRRRy9yMVVicVBjaVNPeHo4TUlSK2xGRGtqdmUxTXJo?=
 =?utf-8?B?N09RRzZGU05kajRlOXRxWFgxMnlQTEhrdmd5VXZtb0hIRkpRTXVxbjdmdnpt?=
 =?utf-8?B?TU5EcG9XUUwvNW1sYlVFVHBmNkNFM0ZaOTZjYXcybHVmNTBzbGpFVnlCV1lV?=
 =?utf-8?B?eXZyL0Y5ZldLTzJGaFJINU5Oakw2Um5LSGE0QUNhZHNRZHVrVG10bmFQTERa?=
 =?utf-8?B?Z1ByeTZnNXZRTkJQSnl5MGoxeG1FQkxZYWp0emhXdHhSVUtYTGZtVWQrTFFh?=
 =?utf-8?B?ZUQvV0VraEJWOVArTXRaSXRvdGhqdTBlN3h3b29aTmZlVjg2dVFSR2R6ekVu?=
 =?utf-8?B?Z2tjSWdxbHNkSDJyL0N3d1dvendIUXRaL3hjOE42a1Z4NVhFSjNRTStPVGlk?=
 =?utf-8?B?NGZ4aTk5ZmVYRjJmN05lSk1Sd1cyWjNSNktaemN5V0lRcGViUnlINVJidS9W?=
 =?utf-8?B?cUFidUJ0b0tNOWhJeFgxL3ZMSDNIMzZkbDFyMHdaaVNmVDlwZUI0bm1yKzZC?=
 =?utf-8?B?WENVWFI5NmpzLzJvTUpHVjFmZlJaVjFnWDVaVXNtS0RyTG9vekRXQ0M5bXVO?=
 =?utf-8?B?RktKOC9FSzlMMTBYVHBWdHA0emtTS1o0eFpCa2JHcC9PRzIzbDlndlNqNG02?=
 =?utf-8?B?M0hvS1M5bmFQSkhZOC9mSm5RTFIzNkhVVkN2R0EvUXlRNk5LdWJTMWhvYmVT?=
 =?utf-8?B?NDdYUmJNOEkva3BobnBBTmFmcGtEQmlCOExRcUxlOXNmK1piMFZlcUlES3pD?=
 =?utf-8?B?c2ZuNEdvR0FSZmxUWGlGVFM4MDU1ZWdDRWR5TzNRWVlxbWFQKzZ6WDF1REZo?=
 =?utf-8?B?dmhUWkhBL0Y4NnhJdjJLUWJvYXFzeEh4bmttbDJFZUVIcG9hZU9DMG1OTStV?=
 =?utf-8?B?U0JoQXFnalQ0QnUvQ2s1bU9EekhlMSs3UWlyVGEzY0ZEM0RTam1FeG5TdE5D?=
 =?utf-8?B?ODhDM1VkeUVIN0FvbUtQcmQ0NEx4SllNUzhxZ2w5akdYT0tLMkY0a1pHY1Vj?=
 =?utf-8?B?OEtqTXJuSlI2TXBLM2psdWF0cmJWbFFraU0zYmxvVVhyYThZdjM3aHdjQytD?=
 =?utf-8?B?Q2cyM2d2QW9qYmIxU291TlJYa2JMbjVuTTFRanJBdnZwNkxvcUdkKzRKMWtr?=
 =?utf-8?B?aWNMV1NlUWhRcWVIUUtERk5wYUwwdEFwVjQ1WGlsK2dHMHhjalZkNzlvSWUr?=
 =?utf-8?B?eEYybUg4bTBENm5TYmJPZSt4UW5oNzZrY1lYcjZnQTJwTFNLYUJqZitRKy9O?=
 =?utf-8?B?NHBCNUdYbDJZcnQ3WHhFWmxGdmhxU01IYlpERVc5QmViT21hOWEvc1d2UnZZ?=
 =?utf-8?B?NDBjbUVjZWJhNklMWXVyb0pMNS8veVBhR1d4bUozOUFCZWpnUUhTa3BXM3ov?=
 =?utf-8?Q?MijP2tSI4AjItFiOTxpKATg/PGLhM7LwcU728=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVIbTNDd01nY3JPKzcwNUc5UXJJRWRlM1JVZXpvRG9pU3U2OHJyWGlHL01z?=
 =?utf-8?B?Ri9BV2hhUFRXV3JUUXlZVnFvWEs3UGVrMlkvdWdBZWc2ajhVVkppU3FRVVdy?=
 =?utf-8?B?ZFNwQy9XcTI5eE1UYzVLdThWYW5ReUNhQVFxdE9qY0t5ekNjTUEyanFBQTVq?=
 =?utf-8?B?Vm1Sc0tHWGUyWnVueURvc1NQbGxpQUhHQnVhRFpIblJaUjBvazlEOWx3dlc4?=
 =?utf-8?B?QkpVdHlFcTgyWlZrRDB6Qkx5MzFSNkxqdEhFYkV3T1FOdHhjYjY3YmhSU0xJ?=
 =?utf-8?B?U3k3a3Yzd0NoaEJSaWJ1K3d0SWwzTFFNUDU0SDYxUkVDYzRNS3hTaUpLU0l3?=
 =?utf-8?B?RUpGQ2tJUFhycHVCVTArQmo0OVdKZW9uWVg1enVybGVKdE01MzdFaFpFMFkx?=
 =?utf-8?B?OW1BTkM1S1BPNkhrK3Z6bm5HOGxKN29DN1FKcGQwR3VZNmd5TWNTbFRzTzVO?=
 =?utf-8?B?NVNrdyswdWdsRVR1alhpSk5wZVFMMjhLa0d2bjZ2TERkMENXZUwvQlpPWFE2?=
 =?utf-8?B?ZlZ1U1FlOWxIckZ1WUlHVS9lei9LM05ZZnZxK081RW1TT1ZEWHptN3M3M0Rp?=
 =?utf-8?B?SDkyb3RaaHUyMUl1QXRlWjZXOXNEVjJueU5jajhqNWh2WWl5dDcyWi9LdWV5?=
 =?utf-8?B?cVA5NDljaUVNcmM3bEJVTVI1SVZPdCtTTVRVUVpiOUNoWmhuTmN4Vzc0ZCtE?=
 =?utf-8?B?YklBQmUzc2dhWFl0TS9DaVc1Q1dML0UxbllnaDhsK1F4TDhQTmpDMnZMNmxE?=
 =?utf-8?B?SWthYS9FNFkrZ0ZlUnVyVDFPL3Q4clVHeUVHNTZDenNzeVNjbENlZ0ZjOE1B?=
 =?utf-8?B?ZFl5WFpyd2doNHppdmpnWm8yVlpkZWZ2LzhtRDFCNGJPNWhsSTF6Qmw4aXdF?=
 =?utf-8?B?Q3dvbmpKamlWMWVSNHpYVThzeXdSTEt2M29tbWxjKzJOVm8wdjJkTitxbEcr?=
 =?utf-8?B?T2ZFcFFZMGl0NHZiTmRqZDhtdTM2b1laMW5yZmFIRWl0YUQwZzY2ejVzSXVZ?=
 =?utf-8?B?VzBPbGRBcFcycytJOWViVy80Uzg5M1g5TWRxdGtYWGo5NEVMUENscW4vTWg0?=
 =?utf-8?B?aEZuUXM0SFhPT2dxYTF3WGdGY1pXQm5GNWNlNllFcDdqUGRGeSsvckJ1NHZT?=
 =?utf-8?B?emVGb0RVNmFVRk5GdmVHOS9iYTNwcURqSmRGdDFla1hLT2pDTEh1N2IrdGcy?=
 =?utf-8?B?dWlHZGJrdThSSEZEbm8vV3Z4cDVuaUtQZnNJQWdZdHhwMW9XM2xOQldXRTky?=
 =?utf-8?B?MWg4TVRWdXc0TzhqZWlyUUdhSVZCclNyZnpJai9uUFd4YktOeFRPKzBVUXFv?=
 =?utf-8?B?VFNHWjJxcm0zUnp1ZEdJVmtla1lXVkVYQ2djN0xxVTkrUG5YWi9GaHBmcEo4?=
 =?utf-8?B?ZFZ1TXJOSC9BZk1ZMmZsNXhXN2QxN0tSdHdtMFJmWXhNMWxuQTJLWnNrS0F5?=
 =?utf-8?B?bEhxTlZzQm5vTDNrV00zeFErREZEczRLbzlRcGJwYm1GWnpaRmF5eEk2bTg0?=
 =?utf-8?B?L2RDRVhQU0ZTWU1wZExOd3c3U0QreUQ0VTBjNm10VVN4cE9KR3AzKzFocHpi?=
 =?utf-8?B?THhiRlg2U3gzZFdVeUU3NFVZQmZONlpKUFBoREJFeXZTQnFEejhLazB3cnl4?=
 =?utf-8?B?bE1yUDNFWkNtTjQvb3VrSTJqWVdLT2VCTk5tUjNaQlRDOGthTFNBTlMzdWpv?=
 =?utf-8?B?MVdCd29OeFdYVmJDTkJ1c2lrbWZmaFg4Vk9zUENFa3Q4bUxNbWFKK1hJMm80?=
 =?utf-8?B?aDBreFRXNXh1ekxjVkF6Z3JpRG50aVE3MVE4Vk5EU1ZOSmd0UUhRN0VtdUhL?=
 =?utf-8?B?cUtnQ1hOLy9uN29wUHBRT1FjNm1GUWU2cHJ2V0R6dlllWnhSMzRtTVdBSlJU?=
 =?utf-8?B?Q1dqcWQvbkNRSnlpRyt2SWtBL0VDVVRTRnpYZWNaZzVpOG45RTJ0UGNnOW1L?=
 =?utf-8?B?aE9nR2hvT1l4S3A3eXAxOXF2UDlhby9ERHJhWkJQa21BczF4aFJWMGMxMnBu?=
 =?utf-8?B?TDhBSk5JTitreG5DQVpHK3lFNGFYeXFVVkFlTlFINUdBbFlibFJVRWtHRzlk?=
 =?utf-8?B?TlZaNWJDYk5vYWRFT0Rxek5OdDNJbnhrRW1QcDdibmZDbytLMjZrTnpobzFh?=
 =?utf-8?B?Q1I0aEVxVjJpNlg2OGNWQXRRaTNjWG5yZ05pZnltTWhleUlBNW5WbzUzdGlx?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75077845-3fad-439b-5345-08dd19ffb28c
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:20:16.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKa9RzUSAYFwdM8TstkY3Jr1HccIsj2tAumCiyjR+UsMz31hTOsT2UdOn5DsR43idBBbRmvORzOL+ODlvy0+9aT+kZuo6tEmN7AcVn9RZxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2765
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Raymond,

Le 09/12/2024 à 17:36, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Mon, 9 Dec 2024 at 04:42, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds a test for the function sha256_hkdf.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      test/lib/Makefile           |   1 +
>      test/lib/test_sha256_hkdf.c | 104
>     ++++++++++++++++++++++++++++++++++++
>      2 files changed, 105 insertions(+)
>      create mode 100644 test/lib/test_sha256_hkdf.c
>
>     diff --git a/test/lib/Makefile b/test/lib/Makefile
>     index 4c0abcba81a..24ce6ed8f00 100644
>     --- a/test/lib/Makefile
>     +++ b/test/lib/Makefile
>     @@ -25,6 +25,7 @@ obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>      obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>      obj-$(CONFIG_AES) += test_aes.o
>      obj-$(CONFIG_SHA256) += test_sha256_hmac.o
>     +obj-$(CONFIG_HKDF_MBEDTLS) += test_sha256_hkdf.o
>      obj-$(CONFIG_GETOPT) += getopt.o
>      obj-$(CONFIG_CRC8) += test_crc8.o
>      obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
>     diff --git a/test/lib/test_sha256_hkdf.c b/test/lib/test_sha256_hkdf.c
>     new file mode 100644
>     index 00000000000..ca173a13afc
>     --- /dev/null
>     +++ b/test/lib/test_sha256_hkdf.c
>     @@ -0,0 +1,104 @@
>     +// SPDX-License-Identifier: GPL-2.0+
>     +/*
>     + * Copyright (c) 2024 Philippe Reynes
>     <philippe.reynes@softathome.com>
>     + *
>     + * Unit tests for sha256_hkdf functions
>     + */
>     +
>     +#include <command.h>
>     +#include <test/lib.h>
>     +#include <test/test.h>
>     +#include <test/ut.h>
>     +#include <u-boot/sha256.h>
>     +
>     +struct test_sha256_hkdf_s {
>     +       unsigned char *salt;
>     +       int saltlen;
>     +       unsigned char *ikm;
>     +       int ikmlen;
>     +       unsigned char *info;
>     +       int infolen;
>     +       unsigned char *expected;
>     +       int expectedlen;
>     +};
>     +
>     +/*
>     + * data comes from:
>     + * https://www.rfc-editor.org/rfc/rfc5869
>     <https://www.rfc-editor.org/rfc/rfc5869>
>     + */
>     +static unsigned char salt_test1[] = {
>     +       0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
>     +       0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c };
>     +
>     +static unsigned char ikm_test1[] = {
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     0x0b, 0x0b };
>     +
>     +static unsigned char info_test1[] = {
>     +       0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
>     +
>     +static unsigned char expected_test1[] = {
>     +       0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
>     +       0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
>     +       0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
>     +       0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
>     +       0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
>     +       0x58, 0x65 };
>     +
>     +static struct test_sha256_hkdf_s test_sha256_hkdf[] = {
>     +       {
>     +               .salt = salt_test1,
>     +               .saltlen = sizeof(salt_test1),
>     +               .ikm = ikm_test1,
>     +               .ikmlen = sizeof(ikm_test1),
>     +               .info = info_test1,
>     +               .infolen = sizeof(info_test1),
>     +               .expected = expected_test1,
>     +               .expectedlen = sizeof(expected_test1),
>     +       },
>     +};
>     +
>     +static int _lib_test_sha256_hkdf_run(struct unit_test_state *uts,
>     +                                    unsigned char *salt, int saltlen,
>     +                                    unsigned char *ikm, int ikmlen,
>     +                                    unsigned char *info, int infolen,
>     +                                    unsigned char *expected, int
>     expectedlen)
>     +{
>     +       unsigned char output[64];
>     +
>     +       sha256_hkdf(salt, saltlen, ikm, ikmlen, info, infolen,
>     output, expectedlen);
>
>
> I think we can add a few checkers here:
>
> ut_assert(expectedlen <= sizeof(output));
> int ret = sha256_hkdf(salt, saltlen, ikm, ikmlen, info, infolen, 
> output, expectedlen);
> ut_assert(!ret);
>
> [snip]
>

I have added this checkers in the v4.


> Regards,
> Raymond


Regards,
Philippe

