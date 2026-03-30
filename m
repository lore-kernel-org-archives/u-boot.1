Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61471061B04
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CB883F69;
	Mon, 30 Mar 2026 16:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="nJclMTu0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nJclMTu0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F1784020; Mon, 30 Mar 2026 16:35:07 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FBB983DBF
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=L+nH38BGdHTNLG5Y5qJVbEpGemSCGQoeogIxnyOxi4yfvfZal8S+hJysLbvzCtulcg744TE5AKcDSb58JGIfuCEQrQOompD5+c+LOfETGObM9aH1jc4dPGuyDtYFsPUbEMEolNdExFbhu25er3Yi5Ggsz2lvmHWEneCSeck55gFsw45yN6tqAVMCsXYVNkgD0afbBGRVgxoK+3wD7mBmBeDzdK4G/3E1PhqvnudJeQQUN74c4ODqgxVDgPrhYcvln4+Z5jIPFavzxABv8VEucPWixAKctnW0E7niRol7Lg8njibJke856zE4hrPPLXsgJav80YSxJ0qCxc4lsA/csw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z530Z/+KeBUlxq3nspc/J+JAB6v9QZYLrlTrglCO47c=;
 b=ySPLKPDmNKNLgShGQWqbQlsbwM6yLoQncTOTbcnXTnGkHGFbyCZyFtAoiUtib12DQzzJnJh/fyJo+glAqgxOF23adj4aUpymWsClUI2zJVxCT6YYAmzsTUXwHW2DeDawlM/WSHG5706YVGhr8PQ32P3E42VPIl5BjY654/o+jL94SNjZlXgs1iMOlf5qWhU7AB8FgR4gR2ZX9R5COO0bQxPCqgUUZyov7zphzJmZo48BOA877oQsM9u2yT3xor9H4rhsJjvlzMa5aOUn9rS/P5gM03UGIlWSmiMETwL+hIitZXKZ/242iqnmkYitpRlmq5Hf+Z0lNgXdhfwdGHyNWw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z530Z/+KeBUlxq3nspc/J+JAB6v9QZYLrlTrglCO47c=;
 b=nJclMTu0E4L3S79KsGRqBQK1hYWXes9P0MMxZJskv9BoQwAqat1SsmIvMBNOsfHFcYAbwK/Ef5deuqAl4Rjen5VSStDoUOHGCJbSz6PqRxhYHcDrHvaLmxWeWL74ZTdCOQfls14dEc2O+j5FM2FFmk4LSOq8mSYrz1Rv4R7WgtY=
Received: from DUZPR01CA0352.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::15) by GV1PR08MB11179.eurprd08.prod.outlook.com
 (2603:10a6:150:1ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:34:57 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::dc) by DUZPR01CA0352.outlook.office365.com
 (2603:10a6:10:4b8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 14:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8FEjL9GB1QIpelXqf0rzw2TcEdZYIiw1J2giaf6VPMcqABWHerboYQIMBsOasU7xTjfqbBKcnO+wQ/83txiskMzH8tw0WdWQrpqBBF+GuvymR1Ljw1AtoEMBI/+Sn44WdMgoB73rOGBMEtW8VM6yiozNTioBFOIz1VtIFzOXAT0RS2huzdzNRbf1Y5d09uUve/T/PiqYK1N/eKn8/z32vGGAGIG4wJkL73aEU7QT93F8skV1OpUcWraTHzTfpJXoZ9ZiWyhzxw0wb7e72rY1dfsEvN3iog05tnNQUS0/GnNHQX2w/9qhDOMkMW9e3/0tSnlhecVEY2s9iqiaOwWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z530Z/+KeBUlxq3nspc/J+JAB6v9QZYLrlTrglCO47c=;
 b=amPG+fw87IRNPOFoNfMAabGZEeYJqZ88+Upt5u4ucrrgsw+Hgr3B5XYKx7LHk40dbD21YmnaGkwoIrVsvoCVZd4D8JOJaWMXL19lkI7EttgTT/oLlCJ1MFw0s7Q/OZDzLcYA6haOtM8ZpSGkvHiY+PaXgHYUZTLtTmb9SBpURgGkn/2B4Y68GApmQ/FMvX8cdLtp1sOvu6X4htzVkbCU7M4DKl7vQIP2xLPDa/75BmAdp15cwoeFbahZpgJTNJsqF8PQ+QnYcGVkFl2txbJxTFDPPhiVSHRp4n7W958B14xbJO9H2GziX2cCr3fNWqcRE+vWpK+c40VmD5iK50MZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z530Z/+KeBUlxq3nspc/J+JAB6v9QZYLrlTrglCO47c=;
 b=nJclMTu0E4L3S79KsGRqBQK1hYWXes9P0MMxZJskv9BoQwAqat1SsmIvMBNOsfHFcYAbwK/Ef5deuqAl4Rjen5VSStDoUOHGCJbSz6PqRxhYHcDrHvaLmxWeWL74ZTdCOQfls14dEc2O+j5FM2FFmk4LSOq8mSYrz1Rv4R7WgtY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MRWPR08MB11705.eurprd08.prod.outlook.com
 (2603:10a6:501:96::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Mon, 30 Mar
 2026 14:33:54 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:33:54 +0000
Message-ID: <a0f3088e-89a9-4eb0-88e8-4e638a9515ef@arm.com>
Date: Mon, 30 Mar 2026 16:33:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: tftp: update image_load_addr after successful
 transfer
To: u-boot@lists.denx.de
References: <20260326104158.4182723-1-pranav.sanwal@amd.com>
Content-Language: en-US
Cc: nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260326104158.4182723-1-pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MRWPR08MB11705:EE_|DU6PEPF0000B621:EE_|GV1PR08MB11179:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc4af5c-f461-4242-d3d8-08de8e6983d3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: ItzVvEjRYQKPzTtJjKjl/ZcGrVJVp7ldeipRSuZcTh1LA90V0/dUBOo4p2fNwEHv6ITDmoKHm8yT1VW/idK9EoNmi23486YUXxsWFL9g6B84PFLQk9tabBi5BPkQyLoS3uGBWTmsgzCLEF6mcl6q/Q3YTteAviOiE3bTnXXA0zV1StIv3GL9IWyTvpJj6QjIS6Nc/e0vN7YyAMquTc5xeMDOEAggR2Xsp0pVuJD4SCtR3iPyc0lYCHNsBMrEXn7WT53xdDZG7LTxkX85Uhg7yNyxSJ4FrdN8tlOL10l9M3iQKP+FqXqk1jM9Nbettj5Yl+cACj8epiPioLriBXVtnVKCjk4DZYaLAuyOTXYZmK9MIorSdRPTJYYv8Hq5EA+y64qs8heFgM/wRP5pNrhi0+GqqgdGy/reU2ABXsfm7xxjFY0Z9+6ddcw5B8CXcdplEeSGmQxVAt2N7CpCOATkxRvoBTsCyE4MxTYsltNerfzZIoNRXoeo4voxXwHPzN6znw3jVY/FbfCL/xDJX0vjt+u3B4k1KjtwLLHIsWP/DV4i/MfFAwMJj/Ri9GCDYpkficJh5ESzf1jr6W+STJRjunuVWxoaj/YxO3jMuZqgtb2ppgTz4TWHABq+EtXy8JtL9kvh558qi75osVlzfNJcba52MMZCkZVdFc8vU6ZAVX9RQ0NlWAwrlDx+GZDlwI1atf7rSP+kXKbqyNlI7i7Bq7a3vOXnN+ETOIYl8nEVJzA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: VS2Ri0l8jGa3jMehcLwJy3D6uZWVwwepiNohgGChSujwdD91cZGfN8ZsVkkeGz5gHJicfmab/s/wOaTeK+aQD+kP6rOTCDb5Vhqc3SNt7esbJPkQDCwYJEKi6fyqsHSjPTwd0lfnxvvnnfALfP3NOa+5t1pP44X8dcdHXW7WJgpf2gXLo7jzYrPZpjPV+e3eBClMphb9VvJl4FEMF6ulWY5NqCd2mmFU0SegSXnQHyCuejWGF9RrcpM6NDex7P/IrQwZ3NyUHfyPRqRqF2mS6pJilz+sSKJzXvkiAqj6E1QJExDFZzBMMMIEDjPBWbZz2p9/EPSZva+QhaYWzhbj4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11705
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 72b2ae78-f1c6-46cd-f6cc-08de8e695e71
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|14060799003|35042699022|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MqCoYN+X2GU+1g1rlXnKQijkPH3FvxzkRfvwZBzheCKMVEa5J79P0xXpvK7F53IKKP3JR1nPa12JG+NxY8IZ5FwEG22Lkhwccj5Hc2yQ+pm52Vl16pxz/+9/eAH21eIjZz9fFrUeQkqg0ImmPHbvRJnc5XYSX12T5B/MTLHKhTNpPJ9OXCay1wt5AKqy5tH7SWYHPWrYfWdJLPbPlpOuCvHP4NHmHY17cAHNeFAt7nzRlH/4x+f0UZz1WKiEvabCDXDdIjgSNYVLMDdn1JtAJknRNhOOE91vamH5jT8ae7D1uztj+OedLVuyGluwit5ymX3sj0O0R/JNkzlcJRXpkJEkvjBERkmStgUmR2W4utszrRte7Gud1m/5SMo0ijgL0lLQgVqhQRIjyrk+WLFW20SJGEc35S0oRixyyufQgam4VWnk6vxZ+AlJIOXhKsdT/0PxAuOwSTWOY5TI6I+BDUfmd591bqstzQIjuraHTy7JRrXq5CQh95wS+Kz45rXpZPFjdGO0HqUgj2KOTbF0pz6Mh1ApKrgfQ4h6jqsWqQqMBNgCM2zfCQs58l9rbE4a+GR/yn3ruCpOGiGAFq7ZCq7ojfKc+SAnDdlIDduEOZufVvNLfTQhie4Oemol+bdIhQuCfD/AeEXgB7TWPNzHesujrBUULt1LAQcLgUlYCjjfr5i8rkXlFw7aiizekDRH2dSUWzN5Quokfz1n+7CamP2NwpPFumCvWPH6yAq/PrmouIqqbUAu74DqSxbTW4vgCEN5PLmtu7+Lr0WNqij26w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(14060799003)(35042699022)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZEMakxZdCWJ4CVFO8rMlxTQeQGMFnljz1fgT3afjRUQlcvK4z9THpASsp3ByUcEsuuZC03QsCeNcmTKFjSzQPzdU/oAIwlsXFNm9/+NvVSEpesg11aeeuFL2Og9Z2N1TkADraWf/Q+PGQJo5aH3xPUudqQMG2ZTxOix/XJOEY8jbwuSmUD5apMJwRCNyPRm4t0p2KLQ6wjMucSm0RdIHpITYXLckp7AMkbCSzRxogNd46WyOvsoUWV66f/p9zWFgzgmkRwu6kXOcMbz8fGjh6KTkzVcv/V252kxu1nrqXFQf9+a6OD2Z3lnp6eXjFXXYGiqLQHoEUfdtcmTgmaAC6s9uLdElCEUnAPDFSSpYmrXnGWqt6fJdjRbyHoDbZEgS3cYlqXln1zPk11x2u47YUE4ptE7KmYSTDmHNu0y256RcSMB+8C+EkWzzHTXnlunq
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:34:56.7242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc4af5c-f461-4242-d3d8-08de8e6983d3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11179
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



On 26/03/2026 11:41, Pranav Sanwal wrote:
> do_tftpb() parses the load address into a local variable laddr but
> never updates the global image_load_addr. Commands that rely on
> image_load_addr as their default address (e.g. 'bmp info')
> therefore operate on the wrong address when called without
> an explicit argument after tftpboot.
> 
> Update image_load_addr to laddr only on a successful transfer, so
> that it accurately reflects where data was actually loaded.
> 
> Fixes: 4d4d7838127e ("net: lwip: add TFTP support and tftpboot command")
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> ---
>  net/lwip/tftp.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Added to net-next.

Thanks,
-- 
Jerome

> 
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 5c3becc68c6..7f3b28b8507 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -368,6 +368,8 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  
>  	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
>  		ret = CMD_RET_FAILURE;
> +	else
> +		image_load_addr = laddr;
>  out:
>  	if (arg != net_boot_file_name)
>  		free(arg);

