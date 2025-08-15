Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1396FCA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 10:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B6383AA7;
	Fri, 15 Aug 2025 12:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VZeDf66K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE3583AA8; Fri, 15 Aug 2025 12:53:11 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A19A283AA1
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 12:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0eWbbWMp6NGbgBOPsUCQsX7QUqmRExE+cKet3brASnDnYkpc38E2OjDs/zOryApvs88YeZdwAeOXdOUXGZWY27VNWMVocVbcugN835ZedMoCjGdtFaGoEv34nGvm7UBtMJeixzskZz27LmIfX+hx1Zi9u8lT+VH2dXEmAuZcRXn++e6E5GXnS1JAW4n2LJjtZKxIumurvPINC3ypxyq1FCyReZOS7kF/7sug1c0jusA3+dQLpgQeLz8y/eMC9BIWNkDyiBXvKKUHGh6CReisDpB0fvxEi0STApXvOdwhNgXE706iHoM7bXnRmYf+NszAKB7coCCfWRoTjvBmUQK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEg+ydnUxGDhCaslMRZtIbon2/z5dL9qddlZvSEDqAI=;
 b=yFBkvqQF7SnpgncWZKv8riTk5x/HvfC2bCdN+q7PhtVJwbwnlQK/KB7Oc6Opi98HzYLyIvgBbomwvgPUUM4zI+SVzTyvmHMy3t44+uK7OKhnbFbYRPEaU22LQCl7AeIlVYqCEwqSs8hhT+iHGxwtrn01wjjO5nd6cs9qURIGAXykYq1RSdRIgnnbcWtsj4ElKn4fh7x4ceoNnJASZYHw/ChBwicVbvPbdU1BKtQI88oTcy5vbRHWQeCAs8Wyv954ZljZdMKBSvBStXNnvd3+HXx8N1x9X2bI6jHFW+hF8pcFjT2lxC4mP6wwYFQHlvmtFjAoOlcfL+AC8OWdYk9/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEg+ydnUxGDhCaslMRZtIbon2/z5dL9qddlZvSEDqAI=;
 b=VZeDf66K1V+oCtVTq0EgCGJ/S+yhZSIBnJZStoLQZBanlo+DRekc/aBw7oWA07SPYpoJ9gxCY7bvqmnr43JS/JI+HTdDntOtmO4GQ+sjmzZkkrf9PdSNOwmcbaF+07SsegggPWtfCzHa1rZGEKkScL0H2bayA88c5eMcoBlK7rqZHBWuxYfXHv7rnU4V+vtPfub+NS5MYv79JSwcXC1k92Ch5TVMc3rxxjFB/5R6iLnYEtyRBLuidv2sL/AfrFE8mA+Jjs66U7+5kfsftC6wD1rD3voz9OITeWN4F+vWRPVu93w/Z+++HxWnM3DQuA/kLHnILNiSIzZjBWtQPcjZbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DU0P195MB1500.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 10:53:08 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 10:53:08 +0000
Message-ID: <62807b7f-4fcf-41bf-9143-eacfe927b658@phytec.de>
Date: Fri, 15 Aug 2025 13:53:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] bootstd: rauc: Fix segfault when scanning device with
 unsupported layout
To: Martin Schwan <m.schwan@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0052.eurprd02.prod.outlook.com
 (2603:10a6:802:14::23) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DU0P195MB1500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcc5e6a-28fc-45b4-b592-08dddbe9eb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2lGMk8rUS9mVGVGQTYrTkE1cHhkSG1MT3A1ZmppeWdOamdIdjVNdSs2WHlB?=
 =?utf-8?B?Zkg1MVkvN1BtMnN5eVpZRmlRbVViRTYxR2IrSkNsMnBPQ2xjTWRLdUx6cXFi?=
 =?utf-8?B?VzJiVG1tN2ZNRklGbGJyaStjd2kvQndIZXRSTXFFSktiWEtIWWh1cUo3U3dV?=
 =?utf-8?B?VlQ2M0t2K2RobDZkajRnTVY3OE1LMkNNcHM0SzZmekIwaENsOEFpOUYzYVFT?=
 =?utf-8?B?R0NCOSsrdEJVeTc5djljdC9WeXZJcWNrc2RJZVV3MnFqS0d1ZlRtSExRaXZ2?=
 =?utf-8?B?Rm5ZL0ZadXBQQzhmSFExajFnNTJmbExEK0ViQkVYeHFuc293L3lQTStqTTF6?=
 =?utf-8?B?RzI2cUtZUzA2Z3N3OVd2dUFCS3JXU0MyMHdvWjYrVHNqVGhCLzFJVDhxNVhH?=
 =?utf-8?B?c0paOWYxMWQvNFB5amZjUXJYOExJcHJpcEQrQWQvTUZxMVlPMzcyL2FnbHlm?=
 =?utf-8?B?REFIWUFnVERoYlhsZThHb0pVcnVkSktoYTRIWWMwYjJMUUhKRHFLU3VLM3JU?=
 =?utf-8?B?VGNiRldPcXFDRmUvVkgxV0R6NERyQW9hZE1zY210RHd3Qzd4YkpaRFBOWGpp?=
 =?utf-8?B?WTUrWW93SUVyZjh2WVdrK2FmcHRGc2JVUjNhak9ZMm4wcEgyaWpsb1duaVF3?=
 =?utf-8?B?WFlrZEJCUno0Qm9BSVZVTVpZMEpkUlJWUStFSGFIOVorS3FMWU1wMmtXTmE2?=
 =?utf-8?B?R0t4YUZDanBjb0pPcDdpU2JxTWV0RXlQMUs4OFVWQktSK05XNWpvWjRrOEc3?=
 =?utf-8?B?YlNlMDJCS0VoY05oU3c5UXRlUXNMaFhKSjVhQjdubGFxSjZOeWRkZHB4SlUz?=
 =?utf-8?B?UkZxekJ4UnYyOStBa0l6aWg1N0VJcVkya1JnbjVuKy93d09UbTFWS0thRzZP?=
 =?utf-8?B?bzRWanB6dE9IZzZMSTQ1RklWQ3pjZjdFUVlZOGtua1pLL3U1R0lDc3pRbFg5?=
 =?utf-8?B?QlB0YjVHR2tSTTI5VDJlME14eWF6Y3h1d1RBWDNyd2k5bGkrc1pMeDF2SktF?=
 =?utf-8?B?WEx3d0hHVEh0aFRWbDdsTlZXUW9LZm9lZDBlYm4zU1prZ1ZXc29qMkMxRjNv?=
 =?utf-8?B?UHVIcGJXRkUvSmdBa3ViNVFPWVo1ZVpDRm04bkF1RSsyZG1GZ2N1OVJtVHhk?=
 =?utf-8?B?blJvUTFpb25RNlYwZE1mNWk2ZklYOFQ5OXVjV2lnS1ZlUElJYWNxSjdwWUY1?=
 =?utf-8?B?OWhJWTJZN2hZd29wQ3FKZmkzRzcrd1ZjQ2RlQWYvUFVSVkFQdHovSlFSeDRZ?=
 =?utf-8?B?NnM3NVBLdlJ4d3NDQ1BmNnk4Vml3a1BhSm9qM3IrQ2s0YVlDNlE0ZTVPS3da?=
 =?utf-8?B?RVpHdDJpUm96UWh2aUQzRnFvN05sME53VWljT1ZLWUJMb1RGdG93RlNGVHFk?=
 =?utf-8?B?dm9hQ1hVZ1J1Q1h6ZGpscTN4SDhQYzIxNVUzOWQrYm5scWxRclloTHNkVVI0?=
 =?utf-8?B?aDR3cWM4RXo4cWdkbVI1ajJBSjJoeTdhaWdJU1JCZzNOZkRKeHZjcTMvaVlv?=
 =?utf-8?B?VWJEejFEd3Z6MDF3V1JKZjE5QjU0dk9xOW1rSjBrWDB5ZTFZZXlNckMwZktp?=
 =?utf-8?B?alhVNWpQRjlVWWUyb1BVa0YzcXdDcUFGQWVvQjRMbEdsT0E3emJYanlwUDZw?=
 =?utf-8?B?Z2ZKZ21pOUE4Vmp0QWFkTXRFK3prQlh0ZU9Qd2JIcDB2TXJjSk9YZmI1NWVY?=
 =?utf-8?B?VERzMEwwRW9TTkcrVmdaSWFiTG9XeXhLUTg1Uy9XaUd6bFVoT1Jnb2svLzdM?=
 =?utf-8?B?TkdkSUFRZFdqMnBpaW9IZWFoRURoSGdYQTI3RTBHOHBSdGErQ041c0gzQUNW?=
 =?utf-8?B?dTF4ZXlRa1VHaVNzRVR3QmhkME1KTHZGY0RwZldXRExtWDNwUTJWNVRyc2sy?=
 =?utf-8?B?bmxYblRjOFNyRjYzVkNwM2VNVHJWdTMrZG9EL09QYWdDTkpPdEsyTXdpZFdj?=
 =?utf-8?Q?7VEcQhudoK4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L053bWU0UGtTbXJKQXEyb0Y0UVNkd3ZvNFpsbnpWQVg2emdPRzdiU3V4M3pX?=
 =?utf-8?B?MWZsN05HYmJEMWpNVmozZUJUOFA3R1kwUlZUZGZKV0JoV0lqcmYyTDh4K2hP?=
 =?utf-8?B?TlFKK0hkOEI1dkxCMXdkeGJGMllKUEdlQ1l5aXFHajd3VEQ4VlB6TG5jWEcw?=
 =?utf-8?B?M3gvV3p4NmU2QzVwY0Y0RjhRNU45V1lDYzVWVXZHQ2NtOHA3NDhoLzdrWkc4?=
 =?utf-8?B?UFVmSjBCbUJiYXNtTUx1dGhPNjZWYXVRb2NlaWE4N2NZcThPZXRsTXpzbjBP?=
 =?utf-8?B?ekRFM2FoU2J5SkV5RzhEbzNPTmYyaWZNVDhFNjRPalFWeFhkbnJLY05GbjN3?=
 =?utf-8?B?WkxSbm9EUWIrMWd6WmttWHpWSXVGM2RCWEVlRkkxaHJIV050RGttak9JMFQ2?=
 =?utf-8?B?VmVFSUpCMElRdDRaR3JQaHpSd0ZLY29XckpYRjk4Z3VlaFFXQ3RxQ1pROWo0?=
 =?utf-8?B?ZzVQUDg1Qk9HZ3NsRFBRanllVVg1eGt5WDZST1pSNDlaSW96eXdaNjZwUDlL?=
 =?utf-8?B?bCtvUlR4R0IrcXJtK0pFRWF0RXRRUzYwejdybllGdHBQU1ZEa1JneTV5THdI?=
 =?utf-8?B?YzVSblMzSFh0TFIxcFdqdEF2bUh0aWI1QzJUOTF1R1VXMUJlOER3Q01HK1ZT?=
 =?utf-8?B?UHN0TFcwK3E3UDVoVWtDeStGc3RjVHVLQVVQRG1qSUd1MWg2WmNmb3YxZFdV?=
 =?utf-8?B?NlQ2RW9VcVJWam1rdXVKZC9UbHVCV2oycXdVN1JTQ0RSSy9qdnQrSU1ZRW1M?=
 =?utf-8?B?MW5NbDlvMnpmWFpOZDMvTnB6ZVdEY24ySTNiOTRuMHo3Q2lxV3hvRDlOdTV1?=
 =?utf-8?B?SnplbzFGQXhIanNHZmplUVdmSkRNa0UrYUlrdC9SQzdTQXJxajJJaWgyQkY0?=
 =?utf-8?B?MC8rdUhUQmJGZldxemJieUN4QXhaYmxQMG1qdVlSRUdBUXNZU3FZT2tVMkoz?=
 =?utf-8?B?b2JXb1lMNENyNytpaldIaWRiN3Vod2NVQTJBWUVMMVVhMVdsQmc1dXpEdU9w?=
 =?utf-8?B?R1p2R2RqY2JxL3dhUys2N29rck5zeDJkVVNpS2tseHNZa3JzU3psL0VZaFZh?=
 =?utf-8?B?L05mU1RRSDNNVHRtVXA3UldRM3JYeFNpV2tHNGlGeWY3c2gzeTVBYTQ0OGt2?=
 =?utf-8?B?Y2NmZ3N3cnVaVEQxTWg3V2ZXU21MUUtXd295aXFVdVNtcEpDbEJJSjBPbFRS?=
 =?utf-8?B?d3BTc2hlTDlNMWVENnJPZ1JnaUo0QUlXdGJwQXR3N3VtSDk2RXRJYkJjdSt4?=
 =?utf-8?B?eWkrRVVTY2w0bmIzTnFzcXhJVjNxNEJTTVpkTTVCeElzWTRTWlNocVhySzZV?=
 =?utf-8?B?WThlK2ZLOXJrb0VmcUpFbGJ5UUtTZE1VRHU4QzBUNEwxNTIwL0RKMEhkaEZr?=
 =?utf-8?B?cWd6TUFBV3NNSU1VaGRNSU1KSFhpeXRlR3RJTExuTHh3V2czZktIa09zWU5w?=
 =?utf-8?B?Zm1DOEtwdTBNRDc1T0NQYnpNZm9lQ3RrdkhlWm10QmZTMnZwYjFVdStVMkw2?=
 =?utf-8?B?L2xscE1XNTgza2lDVXRYSjNTQmhKNVd6U1ZVaWtWRDliRTU4T3laYmk1Umkx?=
 =?utf-8?B?YzZmYWoxYXlPcTNpcUVlWlAvM3lnR2huNUQvcmxaLzNMbHZsTkdsd3hhSW9Y?=
 =?utf-8?B?QzYrN3pZQitGSkxmRWtVWVd3RmtnbHcxL0VBUmpPZStlSFJVVWNCNU5WeGZq?=
 =?utf-8?B?WjdsRUdBWWJhSStNY3ltUFVWQks1UGlJUHpWY2tqSEgyOGV6T0taMzY3Zk9r?=
 =?utf-8?B?c3R6ZFNxWWt4TVdEVk53NURpUWpyVzl0dVV0NUFTOHNvZGhUSE5jWW5mcWVR?=
 =?utf-8?B?YUZDU2thRDVvRkZvT0NEeUs2TVZvZ1B6WVJwTXcvV0VPRTQrNFg5TTh3ZUJD?=
 =?utf-8?B?R3owWEVnUCs1amNsaStzd2YyKzhkbERYY2VLY3lGR0pseDVnak5KTmRHaXFh?=
 =?utf-8?B?VDdMbmtnSnpoQ2FjTXc0M0VBTk0vQmd4a21KVUVvL3JYWFFXVERqMFBYWU0x?=
 =?utf-8?B?WGIxRlU1T1ZOc0laWHljTXQrL1Q3VE5hb2hxZk5xOE1Ia0taOXVGSkw5SnhP?=
 =?utf-8?B?aGhSdFdOZU15WVNDNGIrN3hBTDVFYTByVWZ6dWxadUxZQ005bVpnaVZZQmhY?=
 =?utf-8?Q?0JBCtWnsDVn0ZpIrGvuBdwDyF?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcc5e6a-28fc-45b4-b592-08dddbe9eb4a
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 10:53:07.9557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o/pWfeGOipiZMZxXls/1xrK9bWxBWILWrojG/6/Sx1JGnaqCeRK8pEJ4UnnozV1+fM0G542b/UEtsQXTnfs5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1500
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



On 8/13/25 2:54 PM, Martin Schwan wrote:
> This series fixes a segfault, that would occur at the end of scanning a
> device, which does not contain the required partition layout scheme for
> a RAUC system.
> 
> With this series, a "bootflow scan" should now correctly scan the
> specified devices with boot method "rauc" without crashing on invalid
> partition schemes.
> 
> Regards,
> Martin
> 
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>

I never run into this Issue, but you can have my

Tested-by: Wadim Egorov <w.egorov@phytec.de>

for this Series.

> ---
> Martin Schwan (4):
>        bootstd: rauc: Fix segfault when cleaning up slots
>        bootstd: rauc: Don't null bootflow->bootmeth_priv
>        bootstd: rauc: Move freeing private struct to its own function
>        bootstd: rauc: Free private data when booting
> 
>   boot/bootmeth_rauc.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> ---
> base-commit: acfacf452441d0a659e3afbd55fd6061aa17e647
> change-id: 20250813-wip-bootmeth-rauc-priv-free-2682c6355a08
> 
> Best regards,

