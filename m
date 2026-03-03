Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C58EC145F
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C731839DF;
	Tue,  3 Mar 2026 15:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CTfmbwbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03EC83F4C; Tue,  3 Mar 2026 15:56:06 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E543C838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 15:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Omb7/wtu/a+qpK86qSDO+KKfMGwKxBEW9usR+hUxb5O1tw+gsnBCunGS/WXZi/+VUgt2AsmH6dZAFDa/QoNGnEvaxfW2bM4dRLaZgTZSz83bS0scE3jsc5R4eYFx6SHZfuYIFQmlf1iyQcBdBUkTLK1nNtpkwgztMwmv1QN76TIuacDa9mNhKfDaVHK+52q7CQVughXYJRULxUHEgOEbwxAKrV0IjtOQ3Fzj8SKgtqkuFbuaqjHw9hYmukJYguawUPkzv0GgUQTtU2cC24E060QFGZr2f9Vy5ILKxUg9ZaWcW5pV87BIHaY5PNenyPnmhBDAKp/Jr49gkULKMbckmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mHZvw3Z3aME927a3zkU8EidESI1AEMMG0wnwdhDV8c=;
 b=FA7QNNZs55EHGB/d2rajN37Cm+FkV0pjlfxih338QGA1upodA5LVonCXImWdobqLu7XZRJgdDWzSPghjzzNME0CS7/LdwmVAN5eid69c9EHVnRFtkNKdhEKzeka/nUb0WH0hWVscd2o9D5+Sf/QdNfpd7S9afGLL0f7lcEkWLtYe6dj8dxEvcjP23prgOXAyAzPaWIukKcln+Xsc7HlXDm8IKWjMI3ey/wIlqwKy8uzw4FAi6IDbFFdSl/3y/3C2DhLe0NOV4JhoyfZxIMXBJ3GHxQpbuKmhVhylniTth9C4T+GkYuuRcwSBnZwrSfiMLHsT3QR1vaV3m6dS2GAPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mHZvw3Z3aME927a3zkU8EidESI1AEMMG0wnwdhDV8c=;
 b=CTfmbwbOGnv5jbo8sg8J1VcKeq9WGQLK2DKNUofhnr0iC3x1TtYyzAS9qklHTgE5R5cSjWhWszOTHg88XpUDBA/jCtQ2lp6ZPo/8RUzT+RagMKqqajZD2gaHSERW8L+zZ0L6Hdn0g37x8IsYmVv7U9poorx6QQX8HWafn/BJoPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB7853.eurprd04.prod.outlook.com (2603:10a6:102:c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:56:00 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:56:00 +0000
Message-ID: <65425736-8631-4080-b1d9-498ac58c9584@cherry.de>
Date: Tue, 3 Mar 2026 15:55:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/16] binman: test: Move FIP/TF-A test files to
 test/fip/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-12-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 132f42dc-c104-49db-2f43-08de7934fc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: nJ/3tCoQaNFAYG41zF/E9bolDk0jFYUhooWbHC78KE8xs52+bqIcYb0poNXoopxbxbsUfoXVbGJk3ZpP91L0amOCoJgvkYqFIFBwJ6zZ5fgidC35OzHTK9Li/S9Gc6aN9rMIEQEcJb+b9Amew5SNcLuGw+nqJaLiPwLrnRhyvzfXGNNys3PYB9CxoVL+lz6Rb795lSGgYyqa1Z+3aT5jKhG3NwOUvr+71E6agShimnN+dpVLGCHWBSrJ4e83VKrayDhCAI8jQ4uT7Ne0YxHWZkKfbt23FXQHwEDE3V9OLQExKCmaczH83b2GfKk2cftXAJqpvs0i1eYVKOXmgNh8EQYDnEALD5pJ0D8D/+tetH2X5px0u6zYJa6Gw7Iwcw0F59GS6TgF9fwFaaH+hiGowTplNGK6/FUrN9eDZeIZ24hDKpgA4Ro2dcaVkXYapmm8qIDKoLPc7vOotl0ro65rFi3CvY6pQkU9424cZOD0Ng/n++b4YJDoX9SaWuOSIqg4cFVwQQB2MVG3jWzOyhNlR3xchUauycQVRvzaHR/ggoFN8I5GU3FhWKfGBKzNvYdjQB8RDtZ8uFU2Q11rcadYve5E/1zxgdqNMjslBtReHmhSPpp+7WV4f56VrOPe0uCrkemqcGKuOtQ9KUVHlNPVmSpF/qw0gI7rO4CKmtPKVMPNHcORljQYXULOx3pXCgJIGANyFhd+N0q+98GBoamrUCgwZ89EosStTkgQlPHIfyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJ2UmlHRENzbmtEWWRqT3FtN2M1cGhkZVpuNDBKMGVBVGZ0bG9vZlVyMXNH?=
 =?utf-8?B?UWFUSTV5UDl2aVN0bUdFeWgxdmo2SU9URnVrT3E4ZlIzWU9yRGowOGNjMEVx?=
 =?utf-8?B?ZEc2NDZpa25zbjRZVTlNUkEwRk16U3RHNGJCMHp6Qkh0Rmh0RUYvZTFSMXh0?=
 =?utf-8?B?LzJpTFZrZGdBYlFnUVRnMS9DMjFMb201MldtT2dLd0I1WTQ0YnRnbmpMaDBa?=
 =?utf-8?B?UmhidmljOUh5SEJWejZYV1JiMGpad0liSzRvV24rL0dGNjRIN2NndzhVcUdN?=
 =?utf-8?B?YWsrelNTWVBxcmlaV2tuYjZKNU81ZTR4ekNKZWF4UWhwUVJNT01JcFMveFA3?=
 =?utf-8?B?eWc2b0ZnR1VnSzJiWFRwYU0ybUE5MFB2NGV6dFJOUXRRL3NVU0FIY0RaVlB5?=
 =?utf-8?B?UGN6UTdNTXRjQ0xEVUZsWEx6amZmOUlHWU83S0NXZUdnWCtkQVR6SzFndHVL?=
 =?utf-8?B?NU1xdHBnVUZiMWd0STdpQmdnN1FHcStNNnBvV3lQZG5RczBxbGxZMGltZkwx?=
 =?utf-8?B?dUdZK0cvenovNmxCTllpemljY254d1Z2MXNJV2JLM2swY29vWGRXRTNGcm8v?=
 =?utf-8?B?ckFsUU52c0dIN1gvWkN6d1hIY2xuTk04dHFVY3BpNTlhZE8vQW9PUmthRDhQ?=
 =?utf-8?B?QThYeFBYR1psSjlNeHdWY0VUWG9nTjlRSlQ5Z2p0U0FoTHFTRDI3bHpQcHly?=
 =?utf-8?B?eEtJbnBkVlFERFZrR283Z0ZQbkgvaGliZDRDWDdMcmJxdEI0aVBuSnhoRGpn?=
 =?utf-8?B?REFjYVV6SnJjdEl3OEJjS3VFbWdTODVUVUFJN0xDczQvT25jS0paWDNSWnNu?=
 =?utf-8?B?MDJzVnh0VWI4UVYrT3JrL0FCVTRqQnpHeFJ2bFhZS1VlSmJ6Q3BkZTczeGhk?=
 =?utf-8?B?RlIvYjNmbkY1WTM2dDU0L3NIZkI0dm43QnFVWFNqOXlMcVI1dkswVFFBczNZ?=
 =?utf-8?B?WmNGZGVRYS8vUlRLZ3AzdHk3YysySlAzb2N0TFBsbjVIVkIxdDZmNXQwYVY2?=
 =?utf-8?B?WnhaZWtMV2kyVnFkSFg4V1VqSUJqT2lRQ2RqK1ZyTnlqRzdvZEFpWTFCUk02?=
 =?utf-8?B?WU5RdlNNK0FuSlhNY3NCR2xYUUIwTk9YSmh5QnAwenkxMmxQbk5OSnJDU2xU?=
 =?utf-8?B?SENtd08xKzVUVDlzTW5GT1BSSGh0MjBSbWRRNm9NRlBXSVJsYWhjT0RBYkpR?=
 =?utf-8?B?eFJOTFhUVEZFRFhkN0hZY1F3V1I0TWtLU2NxenpPRjRGYlhFUGFNVTFtaXRN?=
 =?utf-8?B?QWtqSDRqWklGTHRmMjRWeVZNQ2o2WHc3WTRCb3JMM3NiakxYWW02YnBQT2NR?=
 =?utf-8?B?alVsczBPYWgvcnR4a3BBbmx4aHV2dDNDRlBXSWpmVGdYMHdYcDFoa2g4b3dU?=
 =?utf-8?B?TnVyc2oxamVDOFdpSUNIQjhBZDlrUmRuT201SXdxZzF3V1J4M0U0NDdQM0Q4?=
 =?utf-8?B?RzhUTVV3d21MZVE5N2JwUHQ3a3V0eWpWU2o1Z3pCT2o4ZzBCZ1I1ZUZyZXNn?=
 =?utf-8?B?MEVpZ0hkNVJMaTQzM0Z6aTI5aWlDU1Z2Ri9uWmorcXlQK0ZFM0VrWnhFbUQ1?=
 =?utf-8?B?SHN2Y1lmOE4rdVZ0QnJacmZhcXJrczVXQWlISFA3MTVxVHJUNjZMb2c5bkN6?=
 =?utf-8?B?aUxEc2lSR3F2akcxQXFyRGpSY3ZKTG1aZ3ArMzZRcDIxNFZYTGRqaFN5WFJt?=
 =?utf-8?B?aXJwN2phQ250OFFCSDlWOVN4LzdpYXRnVFcveWtEWDl1c0tJVmxabjlEeFNy?=
 =?utf-8?B?TFpZdkdaUHNMUHlheU02bE9IL3hSYkFQakFOYTJoUmNtZzlwR2p0SVNVUFYz?=
 =?utf-8?B?ZTBwdnlKYlp3dm9KdEZCTFg4a1NDRzNSWHUvcW95aFQyOEhvdEdQQXdUcmlY?=
 =?utf-8?B?U293ekJMWjJxUVd5SXBRZG9YZENrc3I4aHRPSGo0Zy8yMllVcmZ3dG1pbk1O?=
 =?utf-8?B?azQyeldyU0d3ZzdKWER5UDdMM01wOXRDdnI4MjVobkFidXk2cnpzS1p6R0RY?=
 =?utf-8?B?dU1nQ3MwckxxNG1jMmlzVVp6Um5EaUg1UXV1K0tqYkhucjhycHFoSTVkaEp4?=
 =?utf-8?B?N0lSZVN6UHRncXp6OXl2YStDbVVIdXNFZkJmWUN2VThpSERDTUliVnU2QldQ?=
 =?utf-8?B?RzgwcG5yY1NsQ21EUnlXMGM3WHZ3b2E2VXI3U1E1SHE2S3gwRVRkU1NTcGtv?=
 =?utf-8?B?SGtKaWxEQy9zNjJtTk9mVG1jazJGa1Y5OTAvMEczU05FRnlZS214MDJvMTAx?=
 =?utf-8?B?VXgyN0JlVVJhYS9sUk5VVzJUdjFWdk93YjFCMUhRMmdIS281RXpjTnhLeEQ4?=
 =?utf-8?B?OEdiL3ByWk9xOHJnV3d4ZTQzN3ZxczhidXF2RGg1TzBwMXZQR3dkQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 132f42dc-c104-49db-2f43-08de7934fc08
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:56:00.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSwr0TLkeuALBrm/oqooSE7+IfVbDUTy4ddyJg2xG116leC8v7MoMidhoYtu5YXf9HMHNOShmc9hFyteHNGat0OrR7vdctp6LBVgBQraAxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7853
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about 15 test files for ARM Trusted Firmware FIP, ATF BL31, SCP,
> OpenSBI, and BL1 entries into a fip/ subdirectory. Drop the numeric
> prefixes and the redundant fip_ filename prefix, and update all
> references.
> 
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
> 
>   tools/binman/ftest.py                         | 30 +++++++++----------
>   .../{169_atf_bl31.dts => fip/atf_bl31.dts}    |  0
>   .../bad_align.dts}                            |  0
>   .../binman/test/{354_bl1.dts => fip/bl1.dts}  |  0
>   .../collection.dts}                           |  0
>   .../binman/test/{203_fip.dts => fip/fip.dts}  |  0
>   .../test/{207_fip_ls.dts => fip/ls.dts}       |  0
>   .../{209_fip_missing.dts => fip/missing.dts}  |  0
>   .../{205_fip_no_type.dts => fip/no_type.dts}  |  0
>   .../test/{201_opensbi.dts => fip/opensbi.dts} |  0
>   .../test/{204_fip_other.dts => fip/other.dts} |  0
>   .../{208_fip_replace.dts => fip/replace.dts}  |  0
>   .../binman/test/{172_scp.dts => fip/scp.dts}  |  0
>   .../test/{210_fip_size.dts => fip/size.dts}   |  0
>   .../test/{206_fip_uuid.dts => fip/uuid.dts}   |  0
>   15 files changed, 15 insertions(+), 15 deletions(-)
>   rename tools/binman/test/{169_atf_bl31.dts => fip/atf_bl31.dts} (100%)
>   rename tools/binman/test/{211_fip_bad_align.dts => fip/bad_align.dts} (100%)
>   rename tools/binman/test/{354_bl1.dts => fip/bl1.dts} (100%)

This patch also depends on 
https://lore.kernel.org/u-boot/20260225225040.2568118-1-sjg@chromium.org/.

Cheers,
Quentin
