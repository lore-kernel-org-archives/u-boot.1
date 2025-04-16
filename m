Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FF4C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 16:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477B58214B;
	Wed, 16 Apr 2025 18:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mRGFUcpr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mRGFUcpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F41182A27; Wed, 16 Apr 2025 18:00:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03D182064
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 18:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=U+hxi9RvaExh7xXpSyldl3I4BrB1DNMd3ZPVo9CqJL0HG4sKNuXu1wV9upDEc/t5xqwKIMDvwWifhFL5Svww+Yaihq/vkXXpikpGzHidz70jvPt0mydmGj8YpkBz+8UBV514K8t7Le3ZtranQgjnTJVyNhNFaFTb+FCHvONwDUB+ts5pLi1pQ+WukGRfywfGPwihbHWmYLzTvO9at+ZAeUXDbm3qGSvWsncBPEuuyk33F9B78R87gvu/3QY+NrPJF3eXR8DS5lDR+OqbmIcdpH73IpQCDm9q/jf5/RtBTr/6VXi6a5YVeb3BkgkJ+FCcXBRSXBUMRug1Bu3l9TT/0A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jApvhjnR+WklRntoa+SZAR8eBRzFoSJXHaoTuvIRgDI=;
 b=KlFo2XVLi9pmKGt4GFDvdfYl20UNkkdeI9eCB66wR53fRHR8DGS6BySqa2JhOBY9xoerNcnZ7wYjfzJSiA3/ixFHeLGfpCFoSykDSuHlJFfkmHkxcrWtohUQYl6QXY+3KdSilq8Uxf5VuDII82rdJMocXHBooWHnCdy6N1Uew3ZJhybSvrfq0hkBqnBJtJDcb2UN9EeeHYb4zzcWjEZ7JjEY645iMFGJwY6dRS8ijrvfxPIXOURB0DZ62+EtkOvwUIs/nVin8aLgeOxMsKcr09hTQXLg7Zu8P9HRVzfoFFreLSH1HDPcL2/CD00dubOrUe7liq8QjeVlGsYQ6Ub8wQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jApvhjnR+WklRntoa+SZAR8eBRzFoSJXHaoTuvIRgDI=;
 b=mRGFUcpr9IWnCI9HbHRIpAMMdfUbRR+ZUi6zIJZl8tjV0LfxJUewriMW5KOl3az3opsml3RsfEDpICKKrfDqFEa9yClP3Lw1g1Y76yYCNoHrD7bn+sxwU0jd7dGfRGccFDhaWYb442DI+jMRQpLK2977pGKqg8YNIU8MHNdPnAM=
Received: from DU6P191CA0060.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::10)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 16:00:38 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::1) by DU6P191CA0060.outlook.office365.com
 (2603:10a6:10:53e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Wed,
 16 Apr 2025 16:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Wed, 16 Apr 2025 16:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3+lNvF4ErR9MbBA87q4BllaeRfTJM+uf8WsrFjca5N83Tw3pP9aHJF3OWcFQgqtFvTvtDXJB5T+8pQ8v5pBzOy9zT1BhE6dmFNl/99mYQFkw3/Sm1lIGD9J5CmFILlb55WSkVA7EDGocoG9csDvBKYUUoEgZkmo3UA6qsvUEI8B6swBsRgRYMljFUos2dJqzd9RdnvM8RW1zAI8YZrRxVmUgABjWdD27SNkJey8U5ntROXHi7HxxfYy9nX6k66vtpFRcPfzBX6XF5HXb/xUVazT47A1/Y4He14kp4P/n/8ora3QyllFHjIZoNLHlHd34hQoyNvFulw+2/OAcp/YvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jApvhjnR+WklRntoa+SZAR8eBRzFoSJXHaoTuvIRgDI=;
 b=Mhb6179Hx4LyR2/lijicxMUn2/P8vf5OCGOObv9BgIzpTRYToUfLlBPp5jkSI9AxUt/vHOSXfo91L8zN5fPSAfM4qHlEq1GUxQU4tCsmCDchQImdg9H5kHqTEPwAW40vLPpnmtinZMxED7UmjLJity1aX1wb3hLFeRNpGpvtXl8ssUhRnYiYa8dryXwMX6pr3uKyLEUT37RzSXmhojTMh8G+3g20LQTLPI+S8H+zu69N+DL/ujx1VUrKhGOOUulgVMcSGUL7uYjIC4WIzp8a64lAO/hnQVyJIrg0n94qv0WRpn96PeYqAP2qSXmJrCM2itnmcSkJfDmJQDq7gDEA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jApvhjnR+WklRntoa+SZAR8eBRzFoSJXHaoTuvIRgDI=;
 b=mRGFUcpr9IWnCI9HbHRIpAMMdfUbRR+ZUi6zIJZl8tjV0LfxJUewriMW5KOl3az3opsml3RsfEDpICKKrfDqFEa9yClP3Lw1g1Y76yYCNoHrD7bn+sxwU0jd7dGfRGccFDhaWYb442DI+jMRQpLK2977pGKqg8YNIU8MHNdPnAM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by AS8PR08MB6663.eurprd08.prod.outlook.com (2603:10a6:20b:39b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 16:00:06 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 16:00:06 +0000
Message-ID: <9e3f0c05-0055-4eef-9dd1-7628a020c00c@arm.com>
Date: Wed, 16 Apr 2025 17:00:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot-test-hooks][PATCH] Add support for FVP emulator and
 fiptool
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Manish Pandey <Manish.Pandey2@arm.com>, nd <nd@arm.com>
References: <20250415215034.1679664-1-trini@konsulko.com>
Content-Language: en-GB
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20250415215034.1679664-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|AS8PR08MB6663:EE_|DB5PEPF00014B99:EE_|AM7PR08MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: 499b6998-c757-455e-ee94-08dd7cffd4bd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?V0JJYjBtSjl0dUpUSXJQc2xRSW1yYnJXM0RpTzl2eUpwRGlLdjBrcXEydHd5?=
 =?utf-8?B?TGN5TkVLb0FveVBENE50cUdGQW1VK0RVS05RaWN2b1QwYkJZT3BIWThFblJQ?=
 =?utf-8?B?Vm1obG9JWVBBU3ZJU0pHSXFXK1o0ck5Hc2ZQZTU2blJxK1BESzdVbXZTWHhq?=
 =?utf-8?B?Y2RqOGp0MXhsVjljODdzOU9RdjR0MTdEemJvVDJIOEJMTEpGdXRmUEZFdFFq?=
 =?utf-8?B?Y3ZyTllFaXR2ZmQ1ZzM1Z3ZwWWQxKy9DMHlzRms5QkxuUWJlRXA5YThJWFQ5?=
 =?utf-8?B?S3B0aStROFhvN205VkQ0TXREMmdVMm90Ylc5K09qN2hnYUx4YXhJYzZ4bURE?=
 =?utf-8?B?U0JvSDMwdmwwUEZIekxmcmZhV09neEUrRXMzZWJoVjVDZmk4RnhJU0pnTklp?=
 =?utf-8?B?alRCMGMxTzIrWHRuOHp0TURUUGlOaUNpbnQ2OVFpSHlMK21GVjJWWGxyaWNO?=
 =?utf-8?B?MmlGd0U0S0lwbEtJRDVaM056dU14ZzNCb25OcE5qRVNpUURaeDhLZHZSdWFw?=
 =?utf-8?B?Y1JDaUV0akFFbDJkRzAya1VvTGNUbWVzTk1GMEVmVEszWlBBRVo0S09wbW9q?=
 =?utf-8?B?RGllM3AwcHRoT0hXdkJtSDBNMUVadVltRUlvczFEWVdGd3NzbGZQSnp4RnA0?=
 =?utf-8?B?MkF3S1Q0Z0V0ckYrN1AwblJKRFZ2aHR3czE0cW5WVDJVUUxWcnlrQ1o5azll?=
 =?utf-8?B?MktJSTcrVm9yMTNRWmpBQ01TT0FGVTIxMS9pQStYZ1Bib1RoZzRId0NHU0tZ?=
 =?utf-8?B?UFAvejFBeGRJd0l3MXNwSGhLQWVEVUxKMk9XRi9MaGRzTHk1bVFUaHhpb00w?=
 =?utf-8?B?Qm5KSHZHMUgrSWtmQlRXM2k5eEJCeXVmSzBzTDh0WTErODhVcFVJMDEzZFNZ?=
 =?utf-8?B?OWFGdjhQTHBUMVl0cFFDVlY1cStUVTN3WjBqNVNOQWF6OG8rQlIxd1ZjMFVq?=
 =?utf-8?B?VUZmZGlLNGJvaUgrRTM0dUtXSFFNQjlRbzZoVGlzb2JhV0QzWllYcWQ5VnZx?=
 =?utf-8?B?ZHF1TWZQM1Bsa2N2TFBZbFFvWTVqc29rZE9FYXlvM01PanJZUzgxVmo5WXBY?=
 =?utf-8?B?QUEySFlRNW1kRGlnTTNCdEM5R2dxc29sSDl5cjJMK2RYOCtUZEYycTVvMkRv?=
 =?utf-8?B?NUJlUTUvMkk0NTlZemJWTkVGd0g2di9wS2RNYWJ4N3NRektiMnU1QTBONU5C?=
 =?utf-8?B?SXk1MXNaZHU3SkFSZWZITUFZNER2eGZiUGFpeDdJT29oVXF0bmJKYlZNZzFp?=
 =?utf-8?B?MmNvY3FaMklSUUNldUMrcE40TkU1MlVZaVY4eGZFL29mTm5ycUdtTFF1V2JB?=
 =?utf-8?B?UWRRNEgwY2xLWHdmVEhVWU1DbGN4Q01pamV3OFdzbGl4L3J1ZFZ0dFpnZHYr?=
 =?utf-8?B?S0k5Ymt0cXhwTHR3cEdDWkNJTmZzNkx0RFcxTERqcG52L3lVWXFUZE9ldFdV?=
 =?utf-8?B?enQxeGhrdjgwdmVEeGwzNnJ5WXJpa0tRRWZjRUg3a2JsVzNwWlltV0VGNjNJ?=
 =?utf-8?B?K1lSWTByNVpzRjZYTUhVQXBHRUczQUVhMXhqQmV3Q2dWLzZkUTAxaVAxRHFG?=
 =?utf-8?B?V3paaVZrb3N4U0gwTis0cWdreUNsNC81ZnBNYkdUVzVNTUU0Z1NEQ0F6VUZH?=
 =?utf-8?B?ZndNT3NyNkRGT2hBQ2pxcXFqTFlNcjBYajRHY3JQVFVpV1ptRUpSNi96YVZ6?=
 =?utf-8?B?QWhmUWcxaVhzSXBNT3diSzhYUUd4a0tvNTh1eklIQlpRUit1ajZ0VHZFY2hB?=
 =?utf-8?B?WEk5Sm5palhtV2F0ZEhYY1hyTlJ5NENVc2VNK3MrMjZrZnVjR1MrdmZYUk1i?=
 =?utf-8?B?RVZ0V0EyQUNJSlBja25IK0JPZSs2cWNBZTVLWDBldTN6ck5PNFR0N3ZabGtU?=
 =?utf-8?B?Y1dRbGxrZVkrbW9IUGtwYVZWelo0Q0ViRkxONjhYZ3RQd3c9PQ==?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6663
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 378455e7-4f23-4948-d11c-08dd7cffc15e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|35042699022|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHpwNEhmc0lDWEJwVXFkL2lzb2JrUTVwUDJ6ZlErL3FiejVmWUpaSTZQcUpk?=
 =?utf-8?B?WC9FUU9tTnNEZlpqYnI1clRubWQxa0s2cVdUZy9VaFJsK2NwbTZZQkNSS0g0?=
 =?utf-8?B?dFJRV2dMS2tqN0l0L2RoSjUxN3NNSTkwYm13MElRZ0VPV2tGTGpEMFMwVlVm?=
 =?utf-8?B?VG1rRVI5TUtENDRhMFpqbEUyOWJPZEI0MUVXSmdpZGwxNWRLTlFta0dhRUpv?=
 =?utf-8?B?bjBVWS9JMWY1ZW90aTdaTFVMUlM5clhBd2ZtSzlVWXlCNm4yK0hnQTR6YnF3?=
 =?utf-8?B?TzVseTluakR3MkQ0TDhCZm9CZi9NUzNCZ0JFalFLOGUvV09LdjdEampFZFJX?=
 =?utf-8?B?ZDI1ZldBSFBWd1liS25zNXNOYWQ0QjBtWHRhYnp6ek8vdkp0cER3Njd1Y3dD?=
 =?utf-8?B?aVlyS08ySFpDUElwSHdJeEdpU01nbWVCeCt2dldubkJEMUR2cjNKdDhqZndW?=
 =?utf-8?B?aUlyWngvbXo3ME8rTnZjUjI4ZTNra1JrVmpTTmNqdkpYcHBSMEhhbDl0anNE?=
 =?utf-8?B?NERaR3AzdHFsV1ZNTjVkWDJrSk1DanVycEdiOGtLdldyd3U0clo5alJIWFZ1?=
 =?utf-8?B?cjQzVTdPOUN6aXZiZGhKUFJwRnhxSWNVWjNwczN2UGFhUHVPT3Y1TkwwdmxB?=
 =?utf-8?B?aVhsY21iOURjVFdSejNHRDZ1dktKTURBek9ZMmxPVnQ4akI1OEsvS0VIR0JP?=
 =?utf-8?B?SERXNlc5SHVoN3lobFROdmk3ZzFjdU15ZGxRUVIvNnNGckxOUE40ZzBJdmZO?=
 =?utf-8?B?SWlRNndxTmlaOUs1UEhrb3Awb3lydC9RRjh1OFkxOE1TcVpjUFhOUWp3Vlo1?=
 =?utf-8?B?WDRtTjlTclRWM1YrcnNCWmFiR3liaWJtOWJkUUNrTEhoMkFubjl6eW5ySnBC?=
 =?utf-8?B?VER3K2kvdXFOblVIbmpqbDNSOXp5ZnhoWjk5ZVFoWG9nVEo0VTVUaEZLR09v?=
 =?utf-8?B?VlJrNUpnRnhtVkMybkJkQVRzazhybnBpVHdyS3pOVjBEZ2thYzVvUllwNjl2?=
 =?utf-8?B?dkgwNTRBNXBXRXdLREFld3F5QkFGek05VEUrMEszTUNSbzVMeFdacXJWbWJ6?=
 =?utf-8?B?Tk9Wd0drMy9DbjdJQXpuaXJtM1F5NTdDVjBkbnFNajduWUV1d0dHbCsyZ2hZ?=
 =?utf-8?B?cVZScmVGWG1vamEvc1lxLzZFZHk2UVhUVk53NzY4MlNGMmRLd2xpTHYyWlFC?=
 =?utf-8?B?RnQ2dDhGQjBZM1V3cEd5ek5WWG9Scyt2ekYvZHh4WG40eDI2R0g0ZFhGZ1dn?=
 =?utf-8?B?bkJOZ0pOUisybkNzZXh6d0NzZ1dQSGFFWm90anZoWDZRQnJZcWt2RVVhRHA3?=
 =?utf-8?B?TmE0TmdiU3Njd2NyVHJQNXNZdnZXUi9TZnlpMFdLWU04VGp4OERUYUxjQmdZ?=
 =?utf-8?B?R01YeThvNUh5Z2hSV1BRZ3ovWUp0eWo2cFZ5bTRITjk4bUFxS1hOUTlpSTY2?=
 =?utf-8?B?WFkxdzdrVE9rY2kxSXJsR1k5SlJ4TWJ1elpkODNKcXhIYXZOaXNsdEJwRGM3?=
 =?utf-8?B?UFJPc1k1Wm4vZml2bFhpMmo4Zk5lMlZieFMzZ2NKWmFwZFJSeHFGOXQwWFJ2?=
 =?utf-8?B?MHdVOWlwRUNPcjhQUVRqbTVadCtDOXZBK0tKRkJUZy9DZjNta3JCTUI4MXRU?=
 =?utf-8?B?dDIzVEJmblN0UEc1bHZXU0xNdVpIOUJ6VEI4eXVGUmt2d1BFaVlWZXVQcTZk?=
 =?utf-8?B?clVxMS9rWFVOeFlYYXA3QTlaSHZScHRDODNHdE5lS3QvcTZLUTBGTzdmeTJD?=
 =?utf-8?B?NnVZMXRqaEpheU9uMGs2QUtoTTVGV01PNU44L0syVHMyc2U2c1lYc1cxWFRP?=
 =?utf-8?B?eFVoTFRqRktsdkhBTGVYUVpNSktwenl1V1JhUG8xZ0xtZi9CUFVrR3lQZmxW?=
 =?utf-8?B?N0xVT0FOZkEwTFY0cEttRTdkRVFHMWNEY1crRndBeUNzOW8vN1Bjc2NYanV5?=
 =?utf-8?B?eTVwMFUzRTdkNURBcUREMk9WSS8vK2dWNFZNa2RiRkh0alNOZzFCSEg0Kzc0?=
 =?utf-8?B?Z1BhSkEzNGdRWHN0SUlNM2t1bEh1NkN6NUp2Q2Z6cnJWQ3AvbnNFaU5BeDQ5?=
 =?utf-8?Q?kfdyMi?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(35042699022)(82310400026)(14060799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 16:00:38.3575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 499b6998-c757-455e-ee94-08dd7cffd4bd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
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

On 15/04/2025 22:50, Tom Rini wrote:
> This adds support for the vexpress_fvp platforms. In order to do that we
> need to add support for calling fiptool to update an existing "fip" file
> with our U-Boot build. We also need to support launching the FVP
> emulator itself. This is a little tricky in that we need to use "telnet"
> to reach the created serial ports and cannot just use an existing
> file descriptor for our needs. Finally, we add in conf files for
> vexpress_fvp to make use of this, and a symlink for the
> vexpress_fvp_bloblist platform.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Harrison Mutai <harrison.mutai@arm.com>
> Cc: Manish Pandey <Manish.Pandey2@arm.com>
> Cc: nd <nd@arm.com>
> ---
>   bin/console.fvp                             | 28 ++++++++++++++++++++
>   bin/flash.fiptool                           | 22 ++++++++++++++++
>   bin/travis-ci/conf.vexpress_fvp_bloblist_na |  1 +
>   bin/travis-ci/conf.vexpress_fvp_na          | 29 +++++++++++++++++++++
>   4 files changed, 80 insertions(+)
>   create mode 100644 bin/console.fvp
>   create mode 100644 bin/flash.fiptool
>   create mode 120000 bin/travis-ci/conf.vexpress_fvp_bloblist_na
>   create mode 100644 bin/travis-ci/conf.vexpress_fvp_na
> 
> diff --git a/bin/console.fvp b/bin/console.fvp
> new file mode 100644
> index 000000000000..eacae7d107d3
> --- /dev/null
> +++ b/bin/console.fvp
> @@ -0,0 +1,28 @@
> +# Copyright (c) 2025 Konsulko Group. All rights reserved.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> +# DEALINGS IN THE SOFTWARE.
> +
> +# We must be passed the arguments to pass to FVP
> +ARGS="${fvp_args}"
> +
> +"${fvp_binary}" ${ARGS} &
> +
> +# We need to wait for FVP to have spawned itself before launching telnet
> +sleep 1
> +exec telnet localhost 5000
> diff --git a/bin/flash.fiptool b/bin/flash.fiptool
> new file mode 100644
> index 000000000000..23014f2bbe82
> --- /dev/null
> +++ b/bin/flash.fiptool
> @@ -0,0 +1,22 @@
> +# Copyright (c) 2025 Konsulko Group. All rights reserved.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> +# DEALINGS IN THE SOFTWARE.
> +
> +# Call fiptool to update an existing fip.bin file
> +fiptool update --nt-fw="${U_BOOT_BUILD_DIR}/u-boot.bin" ${fip}
> diff --git a/bin/travis-ci/conf.vexpress_fvp_bloblist_na b/bin/travis-ci/conf.vexpress_fvp_bloblist_na
> new file mode 120000
> index 000000000000..ef6f0a4ee827
> --- /dev/null
> +++ b/bin/travis-ci/conf.vexpress_fvp_bloblist_na
> @@ -0,0 +1 @@
> +conf.vexpress_fvp_na
> \ No newline at end of file
> diff --git a/bin/travis-ci/conf.vexpress_fvp_na b/bin/travis-ci/conf.vexpress_fvp_na
> new file mode 100644
> index 000000000000..0f99cc9aead9
> --- /dev/null
> +++ b/bin/travis-ci/conf.vexpress_fvp_na
> @@ -0,0 +1,29 @@
> +# Copyright (c) 2025 Konsulko Group. All rights reserved.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> +# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> +# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> +# DEALINGS IN THE SOFTWARE.
> +
> +if [ -z "${fip}" -o -z "${bl1}" ]; then
> +	echo "The environment must point 'fip' and 'bl1' at existing fip and bl1 files"
> +	exit 1
> +fi
> +console_impl=fvp
> +fvp_binary="FVP_Base_RevC-2xAEMvA"
> +fvp_args="-C bp.flashloader0.fname=${fip} -C bp.secureflashloader.fname=${bl1} -C bp.vis.disable_visualisation=1"
> +reset_impl=none
> +flash_impl=fiptool

Thanks for the patch. Looks good to me.

Reviewed-by: Harrison Mutai <harrison.mutai@arm.com>
