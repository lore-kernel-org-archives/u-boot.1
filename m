Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A147CC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8318D608D0;
	Thu, 15 Oct 2026 13:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zwcm6kb8giaL; Thu, 15 Oct 2026 13:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 37C7060AC7
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070106;
	b=MLC/KIxuhzLmzjBrrSXYYkxXVvDdiZZkXYbzcTCgr6bMPRQtO7MPhbKTAf4DLkc6u2VK
	 khBPSFhiGf4CP1nBGo2bzhuouF1uZ9GVRLc1b6I6TNc3pms52HNIyphNMUTIO5cPkmLdP
	 fVmjkS2DwNj+2aQ4CjP+HnyI/q8/qd04ZmpYo9keeyKhe6UxXZMdACMMxab+ugBNSFKMR
	 18vjoq3AK+fV+aKJI1btvSJYAgD3y6iTSqjEBTWynbLaIb0Ks+3Kl4qyVhgcjEu+mL7ub
	 OsLVdz8qqN55qbvgD+fFZebWtHRYrm+36OIPfiNm5qOjpHUNoWcnTF+dzTBzcZOsekw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070106;
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
	bh=+TZW7oVVSQX77/gU1AaaE/f5J967Fa2W2N6XGWfI0Cg=;
	b=XdlS766FBg6++YIMUgZMg1IK6VAO5yLX9VrW0+s8rLBwGlY/e0PglkyrsMwNLEcfyjp0
	 PmnqT+OmvkiyFy71Ve9unrlIwHgwxLTt8mPzjVifozMcCZUHIFddI5nnY2lrmkn/ObgTV
	 18EhTSP11VsX+F82orWnqHy6+7jRWriTJaS4gwKoyiyQ5o3gQtkbrOy7GJXqD+Dw2Rh47
	 gO6vO8pHY+XdZj+jDw3DaqXtv87/GqUEV14iU/LvMT90/9BhL6DjhMScLPXnQZ+V8wdla
	 Nm0tygHKDu42l7HuS2i4f5APb6EVbJOk1mmh9XH1ynPvlluQYb1m7IHcZiFZKiqvVfg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070106;
	bh=+TZW7oVVSQX77/gU1AaaE/f5J967Fa2W2N6XGWfI0Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxD4ygoKJWJ8N6E4r7AKgPoKeL1/VNVbUUS4q1zJKp9udjrAwskc9QbU9NpBdPCNX
	 wzLPs4eWC+JDkS0LSG8jl7bYhf1IMMGrbJSy3RFg0gnAD1NJE4U9kKpNjKan+mc0oT
	 tjxpq/HYFk0aPHFQxRYGZm2zeiHo11N6/4Rk/3jAL0iQrdcaLHkJiddac/Ip9VqCKu
	 dwDfx1fsJlfYvTPC+6cWZ533Gpd0Og0EpdadNj9x9lOW1S6XNsTfRHrriwjcF30xBP
	 n0oq+oOZd5ut0TarQH1hQ0NHopDJILcjQ+A1y1rZEP7XsLSjm97p3B8N5WDOCKvh9+
	 bamSY9Cz1bK5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37C7060AC7;
	Thu, 15 Oct 2026 13:15:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D04D255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7ABEA4080D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAsOHck1mfZP for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97721407F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062836;
 b=nnmj5xQ/TZGPwEQ3KuhDyE9RAcwBYZvAuKI/dovczIPQIOorfzkI8O2rUTiPre2NGT4E
 6vsDTTWjk+Zq865vvrt50bdrpt8UcxWW4iuLMozuE3uhgr273xSdmwJpHG1jwVpupJrVd
 EmHQuYkjm3boRBAd+bf6YzO44ucbRg+9uFngAFY+4AqAHs/j0xu5pEtcif9OL8PZhM99O
 +Oh8X6L4b5X1PNYBhHnGqi2aDCr2Fe52Vz48ZXm/egpXv6E+NzbntgZiFV+YTvzRAktus
 p7flHNEWl7z6+xE13Bc9jLZciR7Gt+qOR83daeCv6tj41+vl5hBjxq+vgNgWrjKjeGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062836;
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
 bh=+TZW7oVVSQX77/gU1AaaE/f5J967Fa2W2N6XGWfI0Cg=;
 b=pWLIVn1W28bT3cnqLIouaeQjiq0O6DZawR39U24+gzZg4mfkdqTJbhBNU1yPt4fz6qyw
 1rR2Drbt//NYbhqnnfHdxDCOFjFvIFiWSEmd8beZBFvJ/IpDR+0NCygFfnGW8mWlBq7Nf
 zhFl+XZI2UgtIvQoBrRg2Cy/bPd0+j8WNKFBdpIjp7rzco7DZo6zsKkLgQ1on6Qa7/s1q
 82NVI4886Ep05qG5WlpF4BLLqw8c6LeC4BiF1fCBEtgJ5VVyYHuCqiuk+4elQCQ2lrcYV
 igvQlhotS2gvpRD+7s24s4oXUYIOcKhvxWNDzeUsqkTVXh+CPims7PrdeJnlxXsqp3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=jBEcacgH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=jBEcacgH
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97721407F3
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEh4M6KApTjWod4fzW7UNqA6GCDg4ZWCBzWptlqE8l5VRx5wqgJDCLcWFjgFRLJiii3Da85vx4Botb4OwX3AW2d0Gn2WD803BT9ezodOi/jilXpSylla9CHHyybzdVByJfqy1blE7qgEDzHnT9L0njYNVO3kwRTFEiwrO3iUxdyUSPzX/JCBml7UTqNySYHIyoZIF47qCamrORArZVNP39L6Xyd8r/fJ0WqdwNgdFGNMNrMESlaDwL/0L9Y3EuptHkiTkzH7L6wTxrnp8ZFaRF0bw7kkacCknFSKB66qeWR3Nr8oHWF+MtJmucUJDqiDsAl6ngtRPSEl/5b9u/3lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TZW7oVVSQX77/gU1AaaE/f5J967Fa2W2N6XGWfI0Cg=;
 b=ogJaSzbsA0aDX3WdaZ7MxV+6SNgxKS63Q+2xf9RSpFJP/qLx9/LgOKR05FlY6KZomDPHDaddwfXn27zDg5MrIyrzJL1SBJYu7KtwczMPUm+F307ikbonS17y7BgPshrTSO0pOgzKjQOBBxYThYGOy8gTrRk0a2BnEDCZh9GBHkj1qzC5vFBE0Kj9DSmdm1jUfZWMLTThwAZ+K5xx21wviGOr8UypEptOFi6Pz3Sk7t3BLaufij1pyyaU1X3P837VYVEbmuZ/ysXNFla3HjSNcXNZv7DHCc7VFVCEo9SGlOnv3MUL5OjR5OMky38v1J7f2dZD2BDaUFkIjNaoZgF8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TZW7oVVSQX77/gU1AaaE/f5J967Fa2W2N6XGWfI0Cg=;
 b=jBEcacgHY/VQ79CaG10eYzS3MGH2GyaE25eCMAWqnGbpBMEITJolTcY69Y2V690AWYWVwLc1piI9QdELFU+zCugL73migYquPtrrCfjIF8isIPTp2LoWHDyGrrdjUI8thxQSgtn1tCVSdAz1fyL36M/P2xK5ZBNcfrnL9Wu4w//Sj6SLlXeqXBYa6kkCNa+m+J6rjqBTYvfcTpxE8TUTfdgJdy28wVrAO/8bog7yKsHMysi6Set9qJhQXCYcycOdEwGjJxhaiSbJa3Whk/dHNWVI5lz3w7J+c7/3owMcAMjsNrYqKPPETX+RikeNJL+eW3SG9T5FU8x4CiUUYgYt7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:13:50 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:13:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] virtio: pci: Fix legacy private data lookup when deleting
 queues
Date: Thu, 15 Oct 2026 19:13:17 +0800
Message-ID: <20261015111328.1269775-3-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 943ac69d-dd7b-45cf-a63e-08df2aad63e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k2kFXkgkwZokqG0MCJWfZ0UtIvAf5rxfd/ftu/GT27zvLl5YXKmyHiMIiYBiBWU6jyGa/g7XyaVrVFcBdWot1yQu1CFA+TK9r7pYlB62eR6Nq4gMXHgdMjWwjxQTVOH/NRfMT+MvYQz/DlxsnI6xLypFPJZV/jBu8HVIgPaIVRUpTz4myvrW/agXPJHK29AZeKOCeAR9O9NuoNUtqKxK8rzkCUp4eQZYwVLP6vAmEb18WdSLASuZTXwL4spWQ54xcaCF0Fe7rdOtFQOtFoD+djweauUi87ZBQYjzhcpU9Bcik831areWUiw7wv0K15z7Yr5PCodrlAoOXscCn2+AkJZvk62MZmYh7iZJKxSFiL6gvSZX/aDY00pSwqGrHwdcRMCLeSbY7nEh+5XHB+NmWBFxDRcWEejbTZFNQQulGR+Z2M7qCtfycrmyBszrsaRIELwMyRT+Q4qBzQEwsroC6lXfQggj23JZTbzCcbRFY2we0NKycyvRo+t8f+A7/+WckiFiP8GJqkkuSDPsfW+33vaV9KhPUTIQXLUCczqp2bzu9XZkwNCSm/M62dP7qVYoddrTqUoKZ1jgkgRFSdgDEPPhlRwRCM/FTQRIHKEv+/Cf5Q4cOLWlT1e+C4DDxZJZX5LukrcL1Jp0QuamKSWBkLXmf+c7Uxzlj9HBKybZvic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVjQPNepEhjFf1HSuodUHCTHcQsz8qN6DLfuSZzGzP70pECMwsqv/WSImqCu?=
 =?us-ascii?Q?aNZ8nHmLyNNRQvbI0GgLMTPCkfrYC6NCe7H8QlqK90gyjB8wA2wuj82LM68v?=
 =?us-ascii?Q?Sso+sLg4aV58tplWRGsganm0m2Rfev9gdjyVLyOovVOTj8lzyaKpf0D7c53C?=
 =?us-ascii?Q?YA6nwuJV3pqc7GW0UkzskR+SpduFfyB5zq2+StIy4HbJ9X2DQy+v77uUkg5u?=
 =?us-ascii?Q?snnrFK2oyf94/bM52QPEgfHBRNpgnQrltK4nxUqUn8KPctssbr7uwF/8Zz/u?=
 =?us-ascii?Q?1oYuSc1LXe+/543qGLMnKhcUGZ7R1W/b1BD0My57FTwqQIWedP1zDtGP5wqm?=
 =?us-ascii?Q?qK9RAbnvwOmqOuiohmmRpSgdOeOVli8csZSVdV3H51awSZMU2DamYtevgnE1?=
 =?us-ascii?Q?xjeWSkbbPm8SP4dZTrGuP1TfN1blpQdW0zzBgYLfiBEBSmuL6GO1ZvSc+mwN?=
 =?us-ascii?Q?0L0p6FM2WJ4MoXW8FFu39J1y3VbqHwifZ81e9aK2OwvVZk6wQF4vgliuemNM?=
 =?us-ascii?Q?swGaCsWCHAx1h3PKG8m8un15CLJqHQpS5QzwcQSpXGepETrJwepAsV7Zbl4o?=
 =?us-ascii?Q?W4jSaUHrYvaYTaNmu2Azu2tR+vknZg5GGFaudW1QdtIzOoNuwMdJZra0Gfmf?=
 =?us-ascii?Q?6PNprSSsUgBNeFyE6gTspcMiQ4x0BjCsnEnJZvMEiQvf7YtbK0IArBGgh5ih?=
 =?us-ascii?Q?gLdvnZGq6/b+LXaZf0HsNR9W78cMrAzV6zTVzKhNUA/m7L40QWHs7e66U/zr?=
 =?us-ascii?Q?Y5Kz/gFRpR9KDajCli8y32HnEzqhKwvUFtVAb1KOs+BSaisXCWKzz6Xq/zPx?=
 =?us-ascii?Q?YThxzSEoKfS7O4GuttngOdTKzBavGtsVXVUR3j8VvtKFkYHsF30qY+ZS7E9g?=
 =?us-ascii?Q?bN3Pt0tzuNXYMQkNDPjPhyjw6rFvrPAOwOfg6BEeFO+ynCK6O81U79XHru4j?=
 =?us-ascii?Q?Or/lolb8KR2R5vjdRyug3yv2dThvrhI/tpwZTR/U9EOv3xckppIb6lhCv7U2?=
 =?us-ascii?Q?XTw6FR1udSD9/LoDUo59xhYHMg7Yg/oO/ORVEmyq7o0t+MNwAiKM2cQ2FrVc?=
 =?us-ascii?Q?VAFR9OyOnXsY4kK6JieW5XkxzVlm6kKLKSpNildPiJntbBrPbPiZf7CtwklB?=
 =?us-ascii?Q?beusTr+a7xt5IrrNxMIhR+aA++1ZfNDDs4y6AkhIPN+2dnsOyPyZzWf8WTNf?=
 =?us-ascii?Q?x56cIIaUMV/Pxbgv3kJ7bLceASVnQQnfAopJnW7/Er7sjiWqWZUGS/7xecy2?=
 =?us-ascii?Q?7n/gMootdwAp5E/tvBCcshkWqm+lIpSSDoQGGL3mrxgUOEWyMTlgOXIcqhpg?=
 =?us-ascii?Q?46FO7K2WW7QX8PAnnNphTD9rNbjTmYNBFCpdgEYTgDZM4zcod5wzpZGt8Qz3?=
 =?us-ascii?Q?On8G8p+sd0aJvM7JfJYHJW++UaF+bFss1q87ehT6jPLPaUl16ZeVu3sxTXC9?=
 =?us-ascii?Q?00deArKq5CgVCU08+EJzxFrHC5VWXFx4S02tzPiblKPbrk2N3GjbTvbmOB++?=
 =?us-ascii?Q?HdEX3DhGvNElFRS8muZLT00kCMrvLj7z14uydxoOLolCvUcATj/Hgz4AJKMH?=
 =?us-ascii?Q?SIyxT+BBUyiqSsyG9DQG2DLiloPpoP+t/pPF6QE0fupHRIbYMIXj/rknM0js?=
 =?us-ascii?Q?ftIVdSZ9Ob5C0FeOmhvb7Z0N7D56giCRsiisGFTWhBvWt1OmDk7pZdiIrcb7?=
 =?us-ascii?Q?L56LwLiv2edW0VVC8ao7CD5VNL1G2V9XnmhBt0Ztb2CeAq6/WgzpZx1Ht+s7?=
 =?us-ascii?Q?ojEQLyvxt52hcMeHeQY4YKw6Ngm6xnY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ac69d-dd7b-45cf-a63e-08df2aad63e1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:13:50.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyfBMcaWmB2gns2iiugTp6V44TrOCMI+O+yKrdiCanf7dIrBL8AOf2WesKhI8fgKV8zkbVC0lWbBhMmWsy7KYMAaDSMo1kA9kk9z1Us8BCY=
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

The virtqueue's vdev points to the functional device, while the PCI I/O
register mapping belongs to its parent transport. The current lookup
therefore treats the functional driver's private data as transport data
and uses a queue pointer as the register base.

Queue deletion can overwrite the queue's list links and crash when
unlinking it. Fetch the parent transport's private data instead.

Fixes: 4135e10732a0 ("virtio: Add virtio over pci transport driver")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 drivers/virtio/virtio_pci_legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 15f8c6e7d25..369c15bd88c 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -226,7 +226,7 @@ error_available:
 
 static void virtio_pci_del_vq(struct virtqueue *vq)
 {
-	struct virtio_pci_priv *priv = dev_get_priv(vq->vdev);
+	struct virtio_pci_priv *priv = dev_get_priv(vq->vdev->parent);
 	unsigned int index = vq->index;
 
 	iowrite16(index, priv->ioaddr + VIRTIO_PCI_QUEUE_SEL);
-- 
2.53.0

