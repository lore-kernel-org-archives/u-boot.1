Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4493EC5DF94
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 07:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4491A40621;
	Tue, 25 Aug 2026 07:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Shl5LoIOl3r7; Tue, 25 Aug 2026 07:55:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787644501;
	bh=oQ+UvU0f2ZMkIPHN3zMnqjDKDBqPQxs88CvK9PbtagA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=paDIHEJSI1Eajbq6U4+wJR3l7R+JLPzSqXNJ1NUz23sWQf46j7BsZaeMvrWGUnYLN
	 J0nRaWkF1cWZd3xsDVn2jQfQnlKx8IR8sm6dBPFfzYZsb8H2e/2vchIQwDcBJkSHM2
	 ZHBezxGtkHa81ynBzPLzTt3ehS0o2E/TAA7RfhzHYJiVuR1wWkEVyWnrd6FnAs89vJ
	 YvfRAfTva56R7Jss1yLHwK1kGDZsQS2cg76+5w8sdoQwevf8dQbn5Rr8Cm8a7O7Rqc
	 eKU7zlPdTOFOD8LRNdeDFQZcZVq6IXtMX6gjXkJzEFCquk9tn62pxGfn6jW+xjvUDq
	 rr41Vl7rcvtgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37978405F4;
	Tue, 25 Aug 2026 07:55:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F867118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8558480CD3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kFHNnMtPQ0mT for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 07:54:59 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jw4qE0OR
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4941780CB2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1HAtQdpHI3EMuGYX8GK3jf1tFzTJNC5ouO5ZT2GEUoebi6hZpJaKRCjDQeJwgZHDs2VxIZJYNG97vr6hz92VoXorPJCqTLENfCHnj/Qnm7lQBo67pbh9gEERmnyfiNEiJLjq6jNBg0siq927L2jO9QA4PBHtFptHZtJi6wuF/65TPis1Kc5u1V8QPoe5FOXFNBPkiXVn0ofR+2B8QQohrFASlfwYvliKWFdSOiM/N1QeBjefGlltQhM1Oll/HJfsqecDntDATWMMrGkKEuw1MHZ6vOGQJRyfAxHRV+fq3JTTpy3wwEXdEOzDbTH/jJZg0EI27ROG6kvuWfckpSNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ+UvU0f2ZMkIPHN3zMnqjDKDBqPQxs88CvK9PbtagA=;
 b=ZHFdBIfPHlor1xng2VsgyIIX3yvkpfTUuXP2T96AP+oDCS2t3c2A+kUYf1/DJMiY8YUyqHIxGmKH3ZsmsTU9H84VOWo/ei9NRIxY5R6sQTUQVygWHnAeJpIV5ITJjIpD4TJsLpIhaZ78tHBWcNNU6c4Pe6LQFrpYqISsH+PmsktYCabMgebyVQgyQgGt5OPYO+KB8/kil738BWkTQxWaW1acC3R5tb+Hf6KWmatN/UwvpvYLxE8BmPaktWDH2b9ol8j1BHw6IkYiYQbqsddAQkVyIDLalwha7X0ZOF9ORp20w+DA03g+tcvAqfbn/k4nulSietNJOlnYd8b+qXDolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ+UvU0f2ZMkIPHN3zMnqjDKDBqPQxs88CvK9PbtagA=;
 b=jw4qE0ORtCgg5gWydAT3bQhcKJRuz0lKdfk6itQVrLRwrKRLxSl0qa8GfzSjV+hdmRVvM/D66gRENReMoMsJ5i/5mm1gWoUTtDTunOksWeQ/Iz9TpxCGO91ZHHYkWn+ZukAI8UmVqGX6fpguw7RyDv+RIntoqW88Fvd0Fd3qzUWIlJhntT49kP1TAWcPWvCd2HBN0TjIC4I/+1BNTCTJaOJ7HkKc2repqDcj7++ftW3p6KV48W3FaPpbjI8q8lg2wLrQm06i9XrWmqJZueXfLdBiM3suomUVfiYdXeLUFb/Lx9Oi0aO+m3t3sbF9L+jdZRvQQRwFOvSFGnVNoXjEQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM0PR04MB11929.eurprd04.prod.outlook.com (2603:10a6:20b:6fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:54:55 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:54:55 +0000
Date: Tue, 25 Aug 2026 15:52:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] spi: fsl_dspi: match the Layerscape DSPI compatibles
Message-ID: <ao1Jwo9RPsGX9dLr@nxa18884-linux-1.ap.freescale.net>
References: <20260824134229.2709937-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824134229.2709937-1-vjardin@free.fr>
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM0PR04MB11929:EE_
X-MS-Office365-Filtering-Correlation-Id: 222eda48-601a-4036-aa8b-08df027e2716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|19092799006|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: 007Yi5kNJ5ohoYiRGBXeyMwls3YDiUYC1AyaoFXPvmkkeIMhycFmJKBilVlaGw+snn7/hDyRVKoobI9N0f3OUKLYgOOpxqMchJnRO03tFMX/wepQV48HXpSGH7LEsb7IpHziH9GlKmf7tGvEScMRLzLPFOaKsiYtx2oY4vOMuty8DjSlF9AbjrkqY7gisjbHSrFhracoNzwv5is2nh8V2msctTdpf73AB4/JobqFJcuiVJHcqxmFtB8WlhBeSiVZ0ChGO/3DD1s94TM9WBek0g+vIKg2tsWULOLXGjjhI88QJ8R++vKr883BItesMnrlojc+FBFha5xVlpjf4c1gVXa3bgHyYtXRgHtrQoZLA+4++oYBZAaqb+3I26R7OOCW7wDOV4txaeZKeFvO6Xs5mL4JkyHl/PwZCwRAIHSs7BZhXqrIKoCTfrYIeA6+MNV0LB/bt+//2tQ5tvyLWW3AVc5ZY/Og2+ubjEGhUdkxxhnpRpyJ3OEOozzYoeEvt9MjxxhCn57uANiEGhTGLZTIDUDFbFZPK26GMERJbEB24qG4Wq4NKk28Cn5LqdRG4zuXx6B4Viayh8MlrhPH4JvlUgFQaASnVH+HhoZS9PWKDerBAeZW9VJ2sm4+lWZv3WpeCcNw+VyL0PIqx8Ct720i62pwwztQrTLPNTlx6d/kxBEsA17toywlYY76Kz43ZuvbkKjI+epVPvKSCwwytWjshPhYh8jROwPPs5Y+SVy+bDPn4LYwgQYgltzrBhx/jjBu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+w2Z8wUzEno+Ur7DFibs2pE7j9y7qysQy6VlJEOXR08ABQ2npCf5N0LTpgxL?=
 =?us-ascii?Q?3MqXfJjZnwVU8QzuafThoQkL+M3ChLEd5Xf/4RegMx/+Nl+o31GZWCd/oixL?=
 =?us-ascii?Q?nzf5wpMINmu5TddSZPFQ0XUxFwRsaxjHFWBaso+5Em+XmPVmp8mlgPMNkreu?=
 =?us-ascii?Q?2jkbHyyWl4ivspGaQxS02+e/MjHBcod3Iqeme7p3LKVWUB3z9+++zfarcM1D?=
 =?us-ascii?Q?5kgv8KXRsFrR51czzca3cO7QVNi6Yf6Z9/jz2+mbErtR5aVIuXcWQ4C3ACRZ?=
 =?us-ascii?Q?O5o1vt6GBxChP6sllINdKULM3D3snw+PgCu89NWHTELihejMd1a/SYJk9Su1?=
 =?us-ascii?Q?ZdHZs2bvvef84ylb7XoXvIrXZ13rWHxLr77e0h3nRP+34hAeKLtUo4ibqDd6?=
 =?us-ascii?Q?tJUcr6JIfWv68bjncan64mYLwFEHSw2MXEt4EX5EqscUuSanGkWHEQbxOmYP?=
 =?us-ascii?Q?kg4ehTn1lIVbtTe1kcgQLTBLP38YfX5kFWX2HmnTLrZqGwmkwxw+ARl6DPq2?=
 =?us-ascii?Q?nJeGSHmEE+SXMrnL1iSW6o0Trf8G+xTsqV6mJJpCwjW5jVJAVn95gHTqTG6N?=
 =?us-ascii?Q?rTlZleABoyZTlTO5orhTOyXF9BzXZXhZFp3f3XkKCgV4njE7yLR/7GmvxtPZ?=
 =?us-ascii?Q?p1Jt4ndhOzFfhjpXvPY4dSkFCbtkuahRhRel8IrPH4yFy4AujqWY1ZS8jcjO?=
 =?us-ascii?Q?Jil9FHjL/MW+AZyOzqnYh0wqhuVZhmCfyV2Bwc0LVjSjnERWK7L9C/4YXdD7?=
 =?us-ascii?Q?vDTgJ4eMsr2bLNU2nCzv8B/0SdMoJrPDEYqTXVxgabLJU9iFJUwAa1exy9uU?=
 =?us-ascii?Q?Zp+epOuZ/YV6Niob3GvFlOEVFLV5N0j3gOVMZhPoP1B8wuJcQmrf2XPPAQTC?=
 =?us-ascii?Q?b3GANSLL6eQgVR+0khCBfTA5qpyXV6TvImJNG8dmMd4UMG8XiPtrwDr39GNz?=
 =?us-ascii?Q?k/hK0HpF6x8OQJsCi8hTLekSUAeCcsu6a+bE0FaRe/Dxm82snpuN0Uw2elk1?=
 =?us-ascii?Q?H4kS5s+A54QXb8r19P9wIIr+RsDLCNzZxPUf/RjiPd1/ZJwT9j1M5Z42WVzL?=
 =?us-ascii?Q?FuGt8qXqAf7BjDG4FJ/9QUyHplGFyqmCNj6Vq1DK8GEiPoSunK4qMnp2ts9h?=
 =?us-ascii?Q?Kw5qqeS3LxOmyv+NJXzeyicXEQslyEa7keCOMPRPhcTa18L7zizylTVKhvmX?=
 =?us-ascii?Q?XkBr32OVk8/yqeD9VQXJxeiLtdWN/w1P64XV1Ff2rc9r+tGQFqXXBFmgRQKR?=
 =?us-ascii?Q?FmFADOaY31gc3CZGWl7w0rjwUHuqHfiN6/nTBtnZo8NiBg5Lx76Bv7TRvEDh?=
 =?us-ascii?Q?aPRLvdsdhLVLDETLDjM5TEZusjI2Dpu8+KbOI03ZCMVDzJXiwmaKS45jdGRd?=
 =?us-ascii?Q?hQzD3FOEbcplt7yMP39dnGlq+3u0lh1BMa9gq/CgdxqCwusbgWMa4MfvADU0?=
 =?us-ascii?Q?3Czb0oDjKqm6F0z0VO9AAFZD79MBExGzkCD4iGTftitNFxVhrdbsm7+QJU68?=
 =?us-ascii?Q?w72kFswUAZ2RlSq2nzPLROwEW66pOPFDR/1qLB6Ufz774SP/qxmuaeMs5E7S?=
 =?us-ascii?Q?7Yf1Uloxjfvu8gOfe+j2nkhW2/Gx1g9E9iWAd5cw1NUUmD1mLmA4CdJ3AeL2?=
 =?us-ascii?Q?PYy0q+2RhkkLerxWuGb0Ka0KX8/UvfZphMLDTJEArn/PO9kxjwBsI9H5ciqh?=
 =?us-ascii?Q?45g9XnGUyYXmuAJpW19h+UsVR7XzIpP6IqiuzUIqxNBcAM0k/2OfXoo2T8aq?=
 =?us-ascii?Q?PiyFT+s0S39VElxcJxllKyrQFOCLd4COYX/m2h0U9nhfHFjEGF5y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222eda48-601a-4036-aa8b-08df027e2716
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:54:55.6302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw9Zr6ktLvxPJnb7moIe2vBxA2HmwlwIb3swOSpJC+mfQNYFWxw+BFrI418DaSl3XH3Xvv1f2EicLj8gVzWvx6UIhXwfTV/1Zv0yn9PGfXHiOsEBP/zmklbrExyC+ZtF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11929
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

On Mon, Aug 24, 2026 at 03:42:28PM +0200, Vincent Jardin wrote:
>The driver matched only fsl,vf610-dspi and fsl,ls1021a-v1.0-dspi. The
>Linux device trees under dts/upstream describe the Layerscape
>DSPI as "fsl,lx2160a-dspi", "fsl,ls2085a-dspi" instead, without vf610
>fallback, so any board built against those trees leaves all three DSPI
>controllers unbound.
>
>On LX2160A, dspi0, dspi1 and dspi2 were having
> "no driver matches".
>
>There is no code path changes, only the match table.
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
