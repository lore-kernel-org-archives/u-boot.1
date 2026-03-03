Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2091EEC1431
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 11:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8672383E7F;
	Tue,  3 Mar 2026 12:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Zbd9jG8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF1583F30; Tue,  3 Mar 2026 12:31:54 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E725838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 12:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlKOANjFV0xOXj04+4TqVT8Ke/BeRW7s4c8VjnNfFiCioPE6T65nQ9/0pX3MlPZQJPKOqoyQt6zlRr2Irposf2K1YBjxr84ZMUDSNWTNceQhmCbQp5XNnB9xrvT++umcn2kEX+MM0qALbsFOjb0ekYtmGQttSatWJV2185kt9tkTyAo4wN2hazSVlEbdXvPgtvGYb7srETwDv5iE3RrZhZ33Viz4ATQ35W4KylnXfONTgYSgqeiQrKZKEG6gIwCcvANC/Id7i5zDbdDAjtHHTRQS1zycm0aJj/2Swc6+9bEWaIZZI/s8IA8WcYKk+I9m9lKNWGLjJX5t62/3rDSy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1fpQnthChJQhFvPgfZvImx5Mc07G2qQIO8bCmFyutE=;
 b=OHxK3k1OS8BNkR1i3gg8hcZopM5hKoNx7AGFScEHizMaT3FV7xovWqM6VxZxqcRp0UhTiVwpZf7s8xQRucxnFBBmPE24c5qGhWuHaQkFg/GPgzkVZN19xjEoahAgj7KxVZEYg7aV0DMDf+r6PaD64fm59qKJ7uuFTu6HvbCr26S2fzwvlRMGZ6+PAnuAa0TtZnTHlZY395OGDN4t0UiHIPgWlhhaEi5ta3H4wgtHNs4R3Fugf21nGRzERNK5uaKMFuv163VAAsOyZpp23gEFbVydbBD3+EnNOLrgVXNtOsR1UfxPdZR6pIMsVieIjjkKY7G95Wp/WQm+KwTTC4VTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1fpQnthChJQhFvPgfZvImx5Mc07G2qQIO8bCmFyutE=;
 b=Zbd9jG8yl0AA7Pu8AAIRoHISu8LXnUIZNJvHQ40sdImxJAEj6mtWA7Suzs1lZCVjLqa5yJ/3nT4L7EscC/y3KbujGCNmw9R9ppOjWZCjP+S3WwJIRySsE1at1fh2S8rlXuHUtC+fE1gFbsN+GMwEaYngwisLgIoM1640GQTR6fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB7774.eurprd04.prod.outlook.com (2603:10a6:102:cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 11:31:49 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 11:31:49 +0000
Message-ID: <c9f7ece1-de09-4cea-8bca-7c148f3e2aaa@cherry.de>
Date: Tue, 3 Mar 2026 12:31:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/16] binman: test: Move U-Boot variant test files to
 test/xpl/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-3-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 817cac44-ae43-4202-550f-08de7918758c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: XHjL1CjPMbq9qUaQJRaZAfC86Jeh72BPl1zrUNpQwsfngsX1E+Y6P9FINFfLwoTP6poxx64/lfsztW5ancZnWWD4y3iHd3KSNAeAleiG5AJjqqkvwu5CmpYKaudjrxG3vbFWKJjd/DSCFq7BLUFdDYKCrmtJkCzgGg0T/KzedrpIrYN6VpuKzMttNTFB3m49fxfEoRrIKxHVFK8XFZsPOquVcOD0Z0DoIanfwEYv8hoRPQnb6oER2Byy7xWO/WuhEnMSPINR6gPBjWHRZvm3H/n0iQdHmgWnGetooDfR+jKnLQRH5Qt+ZLL4rKi6bdezvEctNi5C7Hf3/cVQ34BNkyknzYNE7IeH9qKAzZiFvZfRDUXpk5YzjS/rOCAB1TRe1LRNBQJO9/TTzUCbN954ZiAx/j2v0Ue7lKaoG7DuylC2H4WrsxexZy5OrcQcD44mVHSLVvQakHMLBhAyypRWJrgyb9mtCwKYO/9S1Asn/hIzAzlWJ5R8njEbWx+3gc1/SISniPfySikhzHeT5Yg+GsSBNYF/3FDXBTiOLXIGnXX+GabKy5VlabXKdKTD4enSj+YgKaHtP5c+JhxhlZxSy1FyYAMcp/UGtEuHwTFs+zNyUp0wJHE+oIBC1CzeS0PgVBcdVrt5HQO2FiiNNYCET2YJGdK7LJRAewnUmSm+FgdhrMT8b45sJmaKVJrodudF+JoGeZPwPGVLAYa+B0g/faS1iiw+lN/VGqwiGM6soNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy90TXlGaCtyeXhRMlJnRXMzOVM5ZW5MNkpRNmVraFZlTXhpOUs1dytUZWJ2?=
 =?utf-8?B?QmNFc09jZk1jbko2cXRNckE4QjlmdDFiaDA2YXZTRG9ZQWsxWm9JZk5EOGI2?=
 =?utf-8?B?b1VVUURvWWFXbk8ySnNwSlQxOThZaTNtdkhEcVRsTE9DclkzKytDSjc1V1Fp?=
 =?utf-8?B?RjFvSVZJY3o3NmpFdVJQNmZJVkhkRnViTi80NFdmSkpqa3YrMGI0alF6T0U1?=
 =?utf-8?B?eHZrN3Uyb1VCS3hsMlpnU2VyRDlORTZVRHVneXNOSDBsaG1VY21zZ3VLM3d3?=
 =?utf-8?B?aGVXUTBJNmNxdzRHUDJIVVJGczUzRHN4US9vV0ZWRjdsN0IrRURpUzRnUjVr?=
 =?utf-8?B?U1krTVdjQ2hKcWlCSTkyZHVQNkdrNGxaSlZNNGdOWTh5M0FScmhoWHhCUVVj?=
 =?utf-8?B?WFcxM0JNZDRrYjdQZUdxYWJnNjFSdmxNNklpOGU2V05JeEZLV2dqNXdZNnkr?=
 =?utf-8?B?eEhNaWczT2t4THhjaStKcC9OTEVzak8wWS9LZllHa09rYS9rRW54M0I3SFlJ?=
 =?utf-8?B?U3pxbkIxQnlER2JMRUF2eWNTdm5vcHJDdTZMQTBnMTdYQS9VaFVrNE5PSzZq?=
 =?utf-8?B?dGdraFRNSkNZQ1pjMGhQUjhoVVVpZThDRDltN2l5UVVvcVJ5NmVIUVNGRHYy?=
 =?utf-8?B?WURFcWRsNFJidTlnRlk0WHI3U3lURnFVaHdjM0xMN0hwSVg4NjNSRlNBSE5F?=
 =?utf-8?B?MlFmbTBock9tUk9ZWjVKU1pEbGF4M2d2aWYxS0NIZDdGbWlqMlRTV3Irb1hq?=
 =?utf-8?B?ZXNWM1Ura2RRcDNXQ1VVTi9JdHA3cEdidUVLdXJnQjVCY1pBZldjNXNlcUU0?=
 =?utf-8?B?ZGR2Ni9Bd01ZUXdpL3pPd3ZqMG5URThFSkhYSXJ1K0pXNi84TTc0Vm9LNmk2?=
 =?utf-8?B?ZE1yeDVOTUhUd2h3eEZNM08rVVFUek91NUlGOVd4NjJyV3ROQXdzV2c4aVNY?=
 =?utf-8?B?YXltVlVYWEZSdUtERmRCWXBma0V4S1MyVE9QcXU1bWVuNEZqeElheXZxTWc2?=
 =?utf-8?B?aXFGaEo1ZGtpaDIxWWJMZnFoQzVUTXlOZ1Vwd216MGszMFlIbmRmRHhtMFN1?=
 =?utf-8?B?c0w1S3VGU1ZOTnVrbVJmeU91Mm5QckRManpTUWdmdFFJcnRVWGJGdE9zb0cx?=
 =?utf-8?B?b2p6ZDIvNDY2bWttSFVWTUZNcVJNaXd2b2F5MDRLM2d6MzR4R2UzZTNhbmd4?=
 =?utf-8?B?S3NzdUdhcG4yVWE0UHRURlRxKzNVdnBLUjF2VmEvSk1WeWFRZVdtTlNHaWFZ?=
 =?utf-8?B?YUU4dkVYYnBSemRsY01wbFJoMDZiSzVpdjQ4ZVhPN3h3d2djZzl4ZkF3Vmpa?=
 =?utf-8?B?MzZOWGVKcXhhbUpyTFhUYkZPNVZiMUNpMnBUdkRQNVFzVWVWUnRlNjRyeUoz?=
 =?utf-8?B?TFY2VlF2YWIzSnNCSm1jMUZaYVRIclR3cnNrSklIY1Fod1gxdFBjMDNZdWNU?=
 =?utf-8?B?VlNqZkN6ckJNTUg5YjE5VWgva2JwNjJlUUdqWnhCTVF4NVFKTTV3UFV2ZmhR?=
 =?utf-8?B?ZGEwUDFGOXBORzA2OUljeDBzeXRZSnRQNWRYdXNiWm85M3dvNHZuL1FWUTJt?=
 =?utf-8?B?TzdKTk9EL0ZTVGhCdnFUV0xndGlhc3F1dDllSUV2R1pEWmdYa0xyZ2haQWh5?=
 =?utf-8?B?TGFQS1BhNXNCY0RBVHJFVzMwcFM1Z2MxWUw4Zk9uZFVoaFZOcXNWMGpBWEZF?=
 =?utf-8?B?TmlKNm1PTTlobnVoK2RpQUQySUk1R3dHaDlWRXVHemRwUEpoc2NobWhlcnNz?=
 =?utf-8?B?Y1B3dXQrWEZDUnpIcUFpUXk3dWh2YS8zWG02YWpkUzdSQVdYbkhZMTV5M1VE?=
 =?utf-8?B?RWFYR211TUpxZ0dpdVlZUndvOUVZQnFrREpVVWJCajBoUHNybFRUdk1IUnJP?=
 =?utf-8?B?b1ppREl3N2VCOXhjcDNvN1VRdWVVY0REL20zdHRRbkVuUmY4NHhySHBBRGVD?=
 =?utf-8?B?K2YvQVZhZVBEeXcrYWIzZGVIZGdTTWl1TnFGZCtvNk9VclRnV1RXWFdrS0Rv?=
 =?utf-8?B?UEY0ZTZsbjB5bWZQV2MrMGJ3RXF4NVJvdXhjT3JFVFN3TVNGbGUrSmI5WUF0?=
 =?utf-8?B?T2pjWm11bjZwRkp0SFpXU3FOL05HZkpsajA5Z0ZINjB1U2VCdGJheXBNR0hi?=
 =?utf-8?B?ZURYL0xXRlNTODRmbkVjTTh2WVkzN0F0L0ZPZDhMa3RXM1hnQ1BIbkRUSElM?=
 =?utf-8?B?bUZBcDE2VnFJN0RVc2RtSGU2SzBxNnNPaFdEa1UyYnJnb2MxMVB5RU9SV2xY?=
 =?utf-8?B?REh4Q3NIQUFERTFidDlFQmFCN0hyL2JRS0dvOVZ0cmJBQzZIdzRyMWNCMEJo?=
 =?utf-8?B?UXl0VmcwUTQweGduSXBwZG9pS253RHJDY2xlQzdBd2ZydGRBeEliQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 817cac44-ae43-4202-550f-08de7918758c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 11:31:49.3022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pUcUvW4JsLDwlqvLjzM+A+RajDnGqDojFKtUmJxDLBUcO3GrIzIDzDMM0SRVUWVjQPX2XoQkzPOzHOjm6Mi/wmwW0ysb6PZidBWp/+67ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7774
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
> Move about a dozen test files for U-Boot image variants (SPL, TPL,
> VPL, DTB, nodtb, bss-pad) into an xpl/ subdirectory. Drop the
> numeric prefixes and the redundant u_boot_ filename prefix, and
> update all references.
> 

Nitpick: for DTS where there's only one property, we could use the name 
of the property in the file for example. E.g. 256_u_boot_vpl_nodtb.dts 
to xpl/u-boot-vpl-nodtb.dts. Up to you.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
