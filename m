Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DBAC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 10:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3438883E7;
	Wed, 19 Jun 2024 12:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N5stJzGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A374C8840C; Wed, 19 Jun 2024 12:33:34 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CEC8839C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 12:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuCEc6qcbMEFyASwdZg129vMENi2Wdkga0KJkmnn8IgclevjjX8UlIewoYIny7U8UFoXsqUE2PWwFKLM7OZ/5/C6S6ZfqOCleQMTFBlF3yskqIaQKSkmpBh3/oh6YTUpi5BKV2KB/4SdMCG2AA/2Wv8JoyEd5dWwbYa4v3E1B2OVt7R+AoZ2c5b2VQJQ+tEG3l9hfpm5l/zZq0n0TRuggIA0JkhPdr6+4mY73JZmrJQs12fe+yj0ekkKX4yBi80gJalYvoAXXBNdYiDlh73Xq9u46V85rYj/rtbhvQPq8IKNGQGKc8u3MX40Q9yzLP3Gp+zvFpA+fnEVj/vCGi2sYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjABTLIL78/OLxSyuQEWv22GwHG7NUFOBdJo3FLawzM=;
 b=SJdW0Pzrut22x00W5K+l4lWE1RpV/fJSxPctoSrJOvgChMTkiY0GQwlB0bYDyQqvY8QyatrlKhxEHmiVZijqAxi3r7dg0AC/s6KkhifVnYo8HKz/PE0z9/KJf2Z3CqWvQdRjVVcXUdalJ8FAMcX4O4UrIxK0vgO+k8+lQ6nknp4oXV4no3iFGQ7fSCebn9miRhF1cuzZuBTBg56W3C1sVKgaOVmNSItyJsNntFoKTPFdG8/nDcKyxwPGpog/qF9k+N8KpMvnX965w1Q8EL7I68Be6vxSu7WsCh7g+Hu0eEnGiMMZHwvaHThAOPt11oRJqHUG9Fyr/cbC0JyhZ6hqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjABTLIL78/OLxSyuQEWv22GwHG7NUFOBdJo3FLawzM=;
 b=N5stJzGDtDjk2f5n5Obt+T+BASbdCMbrinJmVCGnij9rAqYXX4kyVfu/LEwgGIOuMJChE8UsIBVJrK0QcmcObNRYLENaYwlLz5nWZl9XmYvSOPUdXY+knYKN9J5ZA8PxxGWTVEnmL7sQepHnvnf4f8kp6wHwi1AyQl51r+Vba0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB9749.eurprd04.prod.outlook.com (2603:10a6:10:4ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 10:33:28 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 10:33:28 +0000
Message-ID: <90903af5-098a-486b-b9de-48b232d722ec@cherry.de>
Date: Wed, 19 Jun 2024 12:33:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
 <233bf248-735a-4564-8559-236a10ea89be@kwiboo.se>
 <4a5cf733-68c5-405f-91df-f87583d9c6a5@cherry.de>
 <81133178-c476-49fb-ad49-dfc00d7a4adf@kwiboo.se>
 <f2183ce9-d7c3-4952-a585-be5138cad9a5@cherry.de>
 <173e84c9-9c0e-4ab8-add2-1f493ca14fe3@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <173e84c9-9c0e-4ab8-add2-1f493ca14fe3@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::8) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 799ffd39-b40a-4f64-33e0-08dc904b41cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmRQSDJKMGdRMkprY1c1dVczWUNYUEhDNVlWU3puQk5pdGRPVTR4Q0FrYU8y?=
 =?utf-8?B?dXVweDBJTlg2R1dPa3ZoSklXUmFKOTQxdVFKY3ZtMEFQTS9RNTVvamRGc0ZE?=
 =?utf-8?B?d2xWSGh5U0F1bGIvc1NsaG9VVUNDQWZqVTZiQXNLUUcyY2E5dVpvZGZjbzg3?=
 =?utf-8?B?bS9XN1JGL2IvVjY4T0RxeGl6VUcvYk4wcGo0TTRHcFZzYWFBclduQlJTMFVZ?=
 =?utf-8?B?dWZ6TVhCOUY1NTJabVhLSnJlUFRIYzZCOU8vbUpMcTcvWTZnODJqOHRmWCtm?=
 =?utf-8?B?YXFiVmt6Q1Y1eXpKRFpqZ1NBTzhLTHBrM2I5ZTJ0Sk1oaG1VbmtRUWtqa0dL?=
 =?utf-8?B?bUcrUUVxN2xrTXpUTmxNK0JhWEQ5SEh3MGJXdHJpL0pMUit0Ti9Vb3BzMWl3?=
 =?utf-8?B?R0p1UUZuRVd4YW1ZSUN5UTFSM0J1WE5vbnFjVmplTW9lb1cwTDhpM20reTM0?=
 =?utf-8?B?WHlJa2tWYnVxSk9NbzZuam9idnY2L0F1Tys0SHRUVWg5cFhEK3FiMFNGcEo4?=
 =?utf-8?B?SDdrOHhjSEppTjlLbmczUzVXaGc3M1cwUnJvcDdlZmpzbDRoa2xGOEhLTVY3?=
 =?utf-8?B?UVA2eDZvdnpOTm56UkFEY212QXlOcENweFFNa2t1dXBJU0U0TmN3M2JxZXh1?=
 =?utf-8?B?a3YrS0pteWNDV3d4RFhnS240TVA2WUcxbVBNWDJrRzQ5R0I3V2phTHNFSEx4?=
 =?utf-8?B?MUl3SXplS04xWDRnMHBrT053bDZycitiSWdmRVQ1ZHM0QjdBVUVGYWNoNUdo?=
 =?utf-8?B?RXgzTjFWR28xdzJKSi9NRlo0TTVFeE00eTBpNnlVVldPcmhRY3h4YUNuTVB6?=
 =?utf-8?B?dzVuMWpKQjZ0NVdHVnlabkpOMUdFRkZibVJabHZ6d2g0MVlTNWJrMXNDbm1U?=
 =?utf-8?B?MkJiUWtSdnNQUzVqTmx5YW0wVXU1ckpNNXhxb1RYV0p4QjhwOStabGczUUNB?=
 =?utf-8?B?aWZ4TlJIWVpVdExDbzRlcng4VzB3MDhmS0I1Smt2eHlnUGVPRXcxRG90Q2pU?=
 =?utf-8?B?blBhVGhhdHdpY3d4V0hsbzNiZXMzOXdNNUZpVnNPd2hJK2pwNnJ6dUFOTFpB?=
 =?utf-8?B?ZHlXeVAwb2tzbUlsaVlyWm5GR0lJT0VpSG5sK0Fqd3FjS2Y3UDNha1htR1Jj?=
 =?utf-8?B?NWYvMEVKVG1zbHBWdWxpU2dPZjBiUVB1aXdseGFMVi9MQmgwOTJBWmNLUE9G?=
 =?utf-8?B?R25tNTV2dC9EMklmSGJQYlY2ak1PQThsVk5UQjNEZ0xHSllBTVplZTFQL0xR?=
 =?utf-8?B?OTJhaG5MbXBIMnRVNXg1MVBxbGlxZjh1VDFOVUZsZmJBSVdPbnZiRTRMMVg4?=
 =?utf-8?B?OTR0U213TE01NXFaQUVyUGQ1Q3ZvZmdVclVFTzVwbGJLTGhDWTdkcEh1OEc0?=
 =?utf-8?B?RFUwVlVFblI2SG1heUg4cS9VWmZwaCt4cmNiYUcvWkRWUFBzdkFHRDZ5T20r?=
 =?utf-8?B?eDdiLy9uaCtLT3RDb1l2RmM2MFovVjdKR0RJWXBiZnUwYUNvUkxDMk5oOXVZ?=
 =?utf-8?B?Vm5wT3UvWTZrd2g1OFV1Q3JpTVpaZjcxQkhDNWRjQ2hYenJMY2hqeUpIeHlt?=
 =?utf-8?B?bFpqKzdwRlZjK0M5Y2F6RnFFNkZCdWI3a3VBSDZMaEJsRGxpMk84OE8waTRi?=
 =?utf-8?B?bCtNejhsa2RaK3pVMDBma2Zjd0xuZmdBUVQrUzNDNTZ6U1dRaEdaSWVNVXBZ?=
 =?utf-8?B?SEhTTklNaXd6R20zMUpBNWgzclc0dnkwYmJhZkdId0NVNDJPRU1TZzRyODJn?=
 =?utf-8?Q?vUMEdUlX2TeozRftUieF3gsN3iHwiPipQHC/7A2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VoZHJBc3haWGdxYTgvVnAzM09vSmo4T0RwcGxxUm9FYloxWEs1MFVOSFY0?=
 =?utf-8?B?MGNCWGdER25VZ2xpY3hpb3Bkc0ovdTM4WVZ1OXlXaldZYmNjSEhOKy81TnlC?=
 =?utf-8?B?azFDaDhPdis3Y1E2Y25UVVY1YW50a1FMNDQxNm00eTZ3Q0JHajBmaDZ5dXk5?=
 =?utf-8?B?eHhuMDZUOFFyK1lNRUwvQkd6MGxYK2ZHb3c3SVhkWk8wRmJkMHRHWXBJRzAz?=
 =?utf-8?B?TDFiU2dacXZhUjNoczZ1cG1Pdit0WjJUTk56QU1iRDQwRXBReS9STVlDVXlT?=
 =?utf-8?B?TXFqai8xaFpXUlJ2Q3I0Sjh0WlhqaHB5cENHamdqdlkwRndqdVhXOFMzN2pt?=
 =?utf-8?B?djhpTXNiNDMwSG1TUkpITGVQK3pjWFBFQXNPOXloWHJweC91RGE2R1NEancx?=
 =?utf-8?B?Wk9vUStROVZUY1NLdTdjMmhpdGN4cm1jRkdmTjVpTmljT0ZzcU9kZ1o0ZnlY?=
 =?utf-8?B?cEVsVVJaaUg0a0l1VFFkcmF3eEVrV2FmVFpzSGpzSzE4QVRTMDdhcy8vNEox?=
 =?utf-8?B?Nmh3VEVXQWdVNlpRZVJlRUhHNDFSWmRqdi91YnRUTnFERmhyWnJYMU9wb2x5?=
 =?utf-8?B?cG02QnkySmhDT21GLythS2ZXK2Y1ZC9nWDRRSXljUHVWa3BwZzFSbVRsaEV1?=
 =?utf-8?B?aTFLZ3gvSkZEUkR5ZmlDSjB3Nm1hWFptN2d0WG9Va3hJd2hrWFFnQ0hxUG12?=
 =?utf-8?B?Zmo0b2ZkaWQ4Q3ZuZVNhZm1TZk5IaVJJemVRdkpJU2VpUE0zZWwvYldrbjg3?=
 =?utf-8?B?Z1JkK1ZJRWloSjF4dWlqbGhESWd0eGROcFFPUnhCNTMvemN3bjJyQTJEZ1NZ?=
 =?utf-8?B?cERtVzlYaGlISXdHay9abkdGbjhUZktpaUkwTC8zaEVMb2N0cFZVRFQ0d09q?=
 =?utf-8?B?MXZIOHBUaTZyVHBCYlRGN1ZhWFZyK01pUmIzbFJ5WnNpTmZkZzFnaFFTNE9M?=
 =?utf-8?B?c2tGRVQxaDgrSjFCbkRTOFRLWlFMbGlDU21oNDF6anZHeDNhNDQ4VG5kR0RU?=
 =?utf-8?B?RXVwRW4xeFFwSWVPSkZiQ21lM0YvRGh1SUF2RTVHVEZYWW1LLzRsUlE5MUZU?=
 =?utf-8?B?aDNKbVVSVjZoZUtSejZIUlhwMm5uL2lJZzVqRXplUllsKy9UaTJSSFRZVGVu?=
 =?utf-8?B?b0hDbHp6MkVueDlBRlRONXEwTW5JZjVRMDFxZUFTVHd1OUtqRzcxdEF1UWxT?=
 =?utf-8?B?b0pQV0tnYVFGdkdEWm4xMjNjWC83K3BxRkZpbFdQbTA3WnFSbjJheTFTbFJ4?=
 =?utf-8?B?YXgwVmVuelUwSjVCVG1sVDVlTXFtc3hNekY2TS9jRXdFa1VBQUFKSGxGSWQw?=
 =?utf-8?B?RHF3eFVRNGJTaVhYNTk3Y24vTXpQZXhPZDN3NXlWRmRxaVRrUnp0YTBRNFBT?=
 =?utf-8?B?aEFJR2h0YzZkKzBUZzRIR1laeG9vS3BROTVFNnphNDlUV0lJMVg0a3FvOHVv?=
 =?utf-8?B?K3Y3K3dIbnZpSXppTXNyR0Z6clk2WE5KM1hqeXNxUno1d05haXRmVEgwRUhq?=
 =?utf-8?B?aFdoTE42Zjg5UHdvRU9OQmRXZ29VdE1hUlQxclgzRXQwOUd6dVFselB6OFp1?=
 =?utf-8?B?SlR2a1BPR01tY2ZuU0hnNTJmU2hjR0REL0tma3h4V0NQSGw0MGtKZzExbHJ0?=
 =?utf-8?B?Q0F2U0l0L2NKYnRWNU9yNUM4T1owUUtsVkpGb0gyM3IwODBtZktsYndtQmxB?=
 =?utf-8?B?cWV1Z2hoZ0pkZzArR1FyaG5tU2ExQ0pjVit6VS9QaStHT0ZtdGdKOU1WS0pu?=
 =?utf-8?B?YTNDTVR3eUpHdlJENURaL2hiQWxWTzVCUE5iNDdDcjJiYXVUbzJaTklEcXc0?=
 =?utf-8?B?ekUvaTl5OEsvOGlkS3BhNjRZNjRoNWk1L3RkS1VEdUtjdUR1MGdQa1NPSFRt?=
 =?utf-8?B?NS91WnV6eldFcVZSVmxXR3VIcTR6QVVGdUVJM3RPcDRHZW9zT2RtMW55TWxr?=
 =?utf-8?B?Y1U5SSt0cy9iWkM1ZEEwb3VuVzBkdDlBamQzZzdNUGtIblcyUkJ5U1lPMTdr?=
 =?utf-8?B?TjBLMk9OSGx0SXd0MVhVSTJtWFhFbE11dWI5OXlkR3FRbHFzbEFtMmpjSXdS?=
 =?utf-8?B?Z3F6RDM3Um9BK09PVUVmUCtIZHNxclNXK3JHaHBvTUN6ckdhQVZReXhkWXY2?=
 =?utf-8?B?OTIyRzJIUytOay9rdHloWGZCdThPM3d1c05pNWFDK1h1VGNFUDUzRkZEdzhB?=
 =?utf-8?Q?nliz51qJyM4TQT2wIaxx8Ak=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 799ffd39-b40a-4f64-33e0-08dc904b41cd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 10:33:28.2641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNlGLI86ocbPsNtCnH+owElf1Jhxgv1v8Ce6EmMQ4339yI41p5Xxsm77sNSgHpMQCRwO0M3arb3/e/lbC1oLFxtiFwZVW0WEvnX71kpceSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9749
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

Hi Jonas,

On 6/17/24 8:53 PM, Jonas Karlman wrote:
[...]
>> I'm wondering if we shouldn't do the same for U-Boot proper DTB as well?
> 
> I think that would be good, and should also remove the need for the
> recursive pinctrl lookup for bootph props during pre-reloc.
> 
>>
>> i.e.
>>
>> cmd_fdt_rm_props = cat $< | $(objtree)/tools/fdtgrep -r -O dtb - -o $@
>>
>> to
>>
>> cmd_fdt_rm_props = $(objtree)/tools/fdtgrep $(fdtgrep_props) -u  $< |
>> $(objtree)/tools/fdtgrep -r -O dtb - -o $@
>>
>> I assume we need to add a bunch more options though.
>>
>> But that would make sense to me, the fact that there's a pre-reloc stage
>> in U-Boot proper is already a bit odd (to me), but if we have something
>> that behaves differently than the pre-reloc stage in earlier stages...
>> I'm not sure this is a good idea?
> 
> Fully agree that part of the pre-reloc stage make little sense at least
> on Rockchip platform where full memory is available before pre-reloc.
> 

Will try to come up with something.

[...]

> We can/should probably also extend fdtgrep to remove disabled nodes for
> the VPL/SPL/TPL.
> 

I didn't find any disabled node in SPL DTB for RK3588 Tiger and RK3399 
Puma, so maybe not worth the added complexity to fdtgrep right now. But 
that's a good idea :)

Cheers,
Quentin
