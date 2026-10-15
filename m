Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4494CCC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FA3C608D6;
	Thu, 15 Oct 2026 13:15:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QK9Z1uaWO_mV; Thu, 15 Oct 2026 13:15:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C483560AFC
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070117;
	b=ZwV2/dz+Qr61847f9NqOo/ILGpEPO/SR7HJzbIq38AEtyKUAiAtK9Q9OpzHLNtYX932N
	 u5Qo4iFzntL05/qBmS5oM8tQNnDeEkkowpjT14TWo63fShgi0to6px3BqlEB66RpdrsBL
	 ejIfbRUUOv4d8yYFNytcMXVNFe7VU9eqdkiKRkHKKiLvPXrOXskV3826F0vDmFKz5I6JI
	 nxNSawC4ehuJZ+FAhKsC6/B51tj8WXW/hPBUtlkeNyb0UZ/1BbuXA+FjvRSeb1tvIfSjo
	 d9dfxleiLcbKXUPePO+cDRaTXUqZHv9RGAH/rOiOp1l5WRrgnB9VhB1EqQ0R+QT0y2g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3ynOnUReowuPeXjpfql4NrTKBi1xr0wSIOy564PwGb8=;
	b=Q8v5uasdIExEOi5YvE0IdPyL5PwlXI4wsp54jKjyRu69zdy8T8pZvMFj1vBFbsNMBV9O
	 sHtjtOgByS4CjneNblsz8AElhDFSoBhtqUR8qN0NvR6A4WwQtDtVGXk4DJ9Jw5lKaFo2T
	 JCmO6QqjHjaXMjH1RpPGMWCOZPsNpu9s/0Jx4RlqM3N8knSd16rkZO/GExDA6GE9na5Jc
	 gw1+Rh6WKwO6whWMkpMhpKuJFmtB8AkZdUq1rYuwwM36sVTBv9Hpir2U1Ylzq2dtrjoLz
	 rFlaycKpnxFFOps7fxYkgtkokZiy2pHPcPNz/fZQb3hXJnOF37LGQwA94eKSsVb6niQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070117;
	bh=3ynOnUReowuPeXjpfql4NrTKBi1xr0wSIOy564PwGb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZWhdoTbt5iXsC1KOowWPcKps/H0z9NrV0u6sEeK2OmbVO42PXpUbIcBGw7OAFnKfp
	 sESoS3s3+cUJdhPSoHQ+6MNOq+a6C+oRb6anXwEwU3oENcsryki7U2sHd7QikTJxwP
	 uOVfsxqoi56WWNGSC98M+a0iUz4ulwjg85hjPxuOQvxz7i4ioElkoTQhxM4knWlVC2
	 hsa7EEHLoD9nRNwy1k/GYgnONjG+FORBWE3QTw3daGzvMtEzvFpYuIJyct9W0g6Hb6
	 /jZlfm8ztnHw/4f44f54ycT+CxhC+pCnz/u18MrWDv6k8JKrtx5+LGv2beydgCkZ5G
	 ux9o5cRskye/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C483560AFC;
	Thu, 15 Oct 2026 13:15:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 308AC49D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 219724084B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Hd1TAqM10NF for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FBE74080D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062844;
 b=LZva8RjHS+deW01I4nR8BD5ZCEP4eN+gn8ECinWlNkMYMTKOhxqyO6d/ARpjw7kqUcpy
 VJgt7SRjT2bo5EMDVbbgdeC3U+ZODs76BUZ0od/Q2D8NyWOnMYxJp0Y2KSZFpcwNror5w
 amyteNY4KkpEPsoGxFoqNpqQL9stbXLbQ42PH84yo8XzOJulnHPdZg8fjgIJItT8maKIZ
 OTY9fJE40/6omoOvQ4EIlb+7/fWqglPIhZ0rVaaVjU7KqI6/QBOuRTStkpauOUPpt5Mcj
 xS8bicgGD7pD0f+2CVxD4TxXmuucIoNRg/nKy1Isk6IlGP7UdL7DUGibKGOVN02AHgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062844;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=3ynOnUReowuPeXjpfql4NrTKBi1xr0wSIOy564PwGb8=;
 b=Wo84Psctij9HS+U6CcT2DJpVT7KgKnT0Lir/WQSYARR6s8zc8MLwW4hyMD1K/dt1lt7Q
 sCAFDkCTVrj8QK5yi3qwZewXFo2DbBsHEfB0bBVnCsrmS2glbW1AqZqgXxmUbtvwCDRc6
 3XTP+b2wBWsajrBs5VHjxhpea6NWZlZU6z56Op/hemQSDGdRb5jaMAHZzdBdtRd66/5OX
 7brpqu9eGUElS4MI8wD7bTAt8FIrNb/KLaQ9EslpV1nfrNi+OUJxiLUJBIbGtpHwbaG0e
 NKRFaF+YkQCS2kQ2FNFC9UHkrjqtZ9tx2SoTMfbPIZsU9xcYSAvr0u/8SFcB6oL93iQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=q7iPTJ6I; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=q7iPTJ6I
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FBE74080D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXUkknraHcM8F13d0PkrKQHiaNqK9iE06vpSsuA0CRRlA0/vhwzw/mm1lqIMsb23oNJQEHrzDWf7GqaeSPNlgG7zoLwIRU0EZ1mTOYahpH0+BWBRf1n/Asj9xd/mk19b65OMWlrr47WIox1GsXd26XPz2fIDmxZmXrLytwrVA8nH7i2GLztUXWUFPVskhQml8DHMRyoV6xMLT1TqVJ3t3JPNX9prnEDs0U9wxTKQnOAKBXwcLaYKDcaTOBAUQ5ihFTxfJg9yYXVX9lC45MN4LX/aWxuvhaExI5DNvSamIM2BwlS9uD885ecHPxsKi6pzYB0A8UCSjqTtgTKjaAxarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ynOnUReowuPeXjpfql4NrTKBi1xr0wSIOy564PwGb8=;
 b=w6qAV4FDxuXYvZyGm+sdwh8/38ZTy6vnAjLYh9S6szkez/wSNq4/6lSYos9Lle0F5/x6s96G6LLeniFuGs1Wr5w39sZ0VBVpdIZ+VS9NBoEJF9idj3mEuRulQ80PonwTUgJ8Puf2ZwIOTzpJKQu+D4jjLsq3f/1z99qwbuzcnY3D2dfIjQuihcENgqY0epxhRQBiqQbviIaKcC8R4Gu98uxcLoNzHDNpy2pr72Vg/4y2ar/v3G/IqHll0K6PoB3cmxilbC/6okCW9iAZwZXtJYiZGb/6wuGcFuM5aNOP2tnGnT6zPMX1LaJk9U8hshUL5ok+3TNHOCsWYDaLt4YnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ynOnUReowuPeXjpfql4NrTKBi1xr0wSIOy564PwGb8=;
 b=q7iPTJ6IuVgwMD9ycBAqc/f/eLThCXK9rd+ZqE9vqdfAR8FViDXcY9LleGuksHNTm3HEKmvMqkC2QXq8vH4VgtnSWhEnwfEK6GJvdehATZwbUxX/wDOPou2JVoIGc7issTQS8icNqtwbe0OguRVZw4x8yB7CPAMtGIZHqkEwjMJWawtZFOqyKekChATeS5QtALLcmjC9SPVyVzsbuSuxWLbf8uEuwa51wNTNMO0zz7kMVPVCnc/xbibWSN/x2zRufBYJ6sTsZ5r0n1LvUhvWYnL38GaJiejEYkr9xXWQz82tLYV7ni1EASWakxV+OKZScx3fg6eymAxWSkU/lZqXIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:13:59 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:13:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Daniel Palmer <daniel@thingy.jp>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] virtio: blk: Validate configuration before creating the
 virtqueue
Date: Thu, 15 Oct 2026 19:13:21 +0800
Message-ID: <20261015111328.1269775-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015111328.1269775-1-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 91919783-de89-4e8f-2e8e-08df2aad6944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Kf0epcWe29V5RYpXRWDcyVKT7veONylLnPNS8J1SvXBKNCX2mklqb+8snp8+OXLnUxfUIkPSAXpQgvmLuFgFgGg7BERW1RWfN+KqlJZ+53bfE+LRa9JnvCOrK/O7p2MRS11F1zpuwN8iESwBZRtfaEnyRapFp1m9tZvOZs3YbMypIKUdSNBOzprosSGGwpMduezPoklMGqwRGfbTSxWP4ozhaj3gj+rK1AYC7oUuirZuDy6NbHnKEDmS/deccSZX0Syo028VNc1sZBUXqOdpijch60kgsg65v6GKgcKCh3U6vud2uNG5q6ef0E77rxObGlED3aRyM+Q5U6UoMcfUg3+9QMo852S1C3ww8zyZcUqewpqC23d2qvazRrRjZ62rU+uUbo8UZstZz+pksdUJ3kd7CY2/oDBj4ltK7aPCSFhg4sFgOvImxbWd+TglUKGeMQzWBfXwvzhUz4VBxE2+o5Dy4RQvLTXqIj1xJIGJ8YB6x8qlmwX4vl58fN8AbmkPSl3mo6EJjh1QO3x0MtnRQjYh2UiTXdch2uCBhruAY2I6he8QEENnRjf0LSZ1rXfTWrqRT5vZAh4cbCAg6/16zSF9GDa3ScBdDWKXieRHw+nNwoDkZ9lmnPmqefAuQREDKReSrZWN3Mw6xi6UfFAqQU1tHuIJIMfkQH23DpX5I4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zm/MMwnschwdOyvY5NkXvK9kKsJIIpUIog0AOoQxqnD6cicWomQLqvBHoUX9?=
 =?us-ascii?Q?ScwmNo9scUyLn5hKKq62ZpDXvS8fhy9zVQxjLAsQGPp7qPzPK9flh3Bl6GA5?=
 =?us-ascii?Q?WYx/ggXuqR3FWjuHZPc2Dygzr+w9Oe41sQVBfV9zl9uDucdz/8szuicxm+q7?=
 =?us-ascii?Q?mOsvq9rg2q7KanOF96xm7UT8JWsOfaPXKVZlE8D6G0e8XnOFKSDav2c2VYTR?=
 =?us-ascii?Q?1hPIMiHBlQud/P4lC5bzJzde4K4rOsgaotAHvF2mMneRb9EJBqa8+KKsR0RU?=
 =?us-ascii?Q?hHcoB+SykNdkfZ5ZAR5/el4nEVRkMFSjJfquqGPDzivYpkSvKZYQWPrIvsSX?=
 =?us-ascii?Q?u7pc7SQYj84gkC9i3oFYIdH0lIpnk36sDWT0XYMEoSAJI3mxNAnQ+7gHcuIg?=
 =?us-ascii?Q?aNjh9C8Yo8XUzgVz4JIzWQQWAW/DKtV5XT2AYMO3FG5zdxp005DSarNX5y7a?=
 =?us-ascii?Q?ygZD0g7O2051aCyFaZKHXsq0n482t5+zHaRIauwf+gf9eSwnbKJy0pJZ69Yl?=
 =?us-ascii?Q?LetfiV7WtDRuiImErahDnA2QOrmc+ZWvqPO3jLxfVFcNUDTbMWnvlQaH63Yt?=
 =?us-ascii?Q?+J7e/NJDbtcnPe6+gnXmeW4k103SMk6CsmFWwuCdn9NuGAZ4djN5OH34tEBb?=
 =?us-ascii?Q?Asj8Hm9a6sd5Nyg8eUjQ1azpsn+GZ6LA5JFhzad+LXHLPDYaLxu4FmJuHLiO?=
 =?us-ascii?Q?5Rv3RuI9yNdPZdzx2Bu384wMqvAh19ZsmywoFvzmLvbfJYWkaAa6Vy2I3ccG?=
 =?us-ascii?Q?menkIbiIYzbX/tkFrkhDVHwrM2flKeph/CAdWYEZUsqw/+ezOfc5jMQnjJrK?=
 =?us-ascii?Q?Y0awbaPVKhvaK2J1ptguFxhIurgkZ5WDPiynBrxpt2YJI9mQGdlcQes+4XwR?=
 =?us-ascii?Q?aPZqFxT9uUnN/tuW9h3L0fHtbGG9++3ziKT7GTRTM5ad2AVUciglK92VoNYc?=
 =?us-ascii?Q?/sWKQZzjPTK/Ot9cnu4oBJdseJEkfifEblaZxo/WWabT5XNsJiitAudGUPs4?=
 =?us-ascii?Q?tmzJJdlLgLmpqd4c99jj2wAbRjdqPPsQ10OmHJibilB4RU86xOw/eZaGzOgG?=
 =?us-ascii?Q?NqDPdUac2BRbE+g1vzPJ2kkGLJbtYpegVLXqJsdCx1HcsGXLZEDpAZJgfV3s?=
 =?us-ascii?Q?qEB7WMHMtCIemRE7oM22jsK9mNBY08Zdd4LZuIG06DVmiqdfLunhUpuSaVZ+?=
 =?us-ascii?Q?tK+K/OEhXRYYm1Ktf/stgLXGeIkNlqX0LfDRHUiD3Pf/BYOR5O8k7CKlJrdL?=
 =?us-ascii?Q?WPfEBd0SSBQtRhdtS080KCHcI68KUEV5+vFDo2m3V2qenWnilejUc+Ln8BYw?=
 =?us-ascii?Q?sTpsSJHO6soF0LLCXVTvgayPJiBZlWxR1/HNK78RzaKYtg7N/Hp0/0f7sh5m?=
 =?us-ascii?Q?nm9G4luvudLhwSEdxmPjOXV59qpobgy7WbKdeMw47W79VVKFq09ziJF5v8SA?=
 =?us-ascii?Q?MdRX7QHMItm69fOkKSuoMxc7BQAh760sID05ExLX8Yk1Yoi9u7yWpQfjz376?=
 =?us-ascii?Q?EvGTGql697H8RHLCLMWH+H47sEig3tr7nxZdrEzkD/6gY3ljTHui5sa2gYKy?=
 =?us-ascii?Q?91BkxSyE9PF0X8fQPz0ZI4mCIGYY5lvxIiC07ewEymF+jrAdPrkKTSjNEsPN?=
 =?us-ascii?Q?mRBi7wmhGNFH4Q8uuOeX9/jFyF/Q0stSBmG8ZmQBgkOGcHWp+yEEwCRG83ai?=
 =?us-ascii?Q?6OAQGoaqCxlSgc0Ajek6V816Px4Ami6b4/pjdAtcEVT4jjY9ky4O9YhcNbC/?=
 =?us-ascii?Q?Ggw8hou4Z1ESl9nQtlYtCi7CjhaiqIU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91919783-de89-4e8f-2e8e-08df2aad6944
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:13:59.6066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEXt66IIGRDXrGJo8V3iBX9FMTZDGa4dE0ze5tGJ/WwHNpKDBPf8lwGM47fOnZT7dic/1eXsf/UzgdHo0bvySthdFQJFegdc9nx8Wsu8LqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6237
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The block driver allocates its virtqueue before checking the advertised
block size. An invalid size makes probe return -EIO without releasing
the queue, causing a memory leak.

Change to read and validate the configuration before allocating the
virtqueue instead.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 drivers/virtio/virtio_blk.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 404d9140cb2..3d5d29f00df 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -251,13 +251,8 @@ static int virtio_blk_probe(struct udevice *dev)
 	struct virtio_blk_priv *priv = dev_get_priv(dev);
 	struct blk_desc *desc = dev_get_uclass_plat(dev);
 	u64 cap;
-	int ret;
 	u32 blk_size;
 
-	ret = virtio_find_vqs(dev, 1, &priv->vq);
-	if (ret)
-		return ret;
-
 	virtio_cread(dev, struct virtio_blk_config, capacity, &cap);
 	desc->lba = cap;
 	if (virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
@@ -281,7 +276,7 @@ static int virtio_blk_probe(struct udevice *dev)
 	else
 		priv->seg_max = -1U;
 
-	return 0;
+	return virtio_find_vqs(dev, 1, &priv->vq);
 }
 
 static const struct blk_ops virtio_blk_ops = {
-- 
2.53.0

