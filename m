Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BDFCA5FF0
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 13:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35FEA80D73;
	Tue,  6 Oct 2026 13:00:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZORt-Llt_I6e; Tue,  6 Oct 2026 13:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0502980BD4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791291629;
	b=W3hkxiMBaUSceQCVyrhWe8d8fHaQriBp7dZEYhFyeXq5w2J8u8LmLUzlYjVDgT91BzTs
	 mDBRoiJSknU0H4VCX0vqebBPv/lBYxkzOEqxqvh/GmPq0MrnSMS5WPm5va0ENfkmn6a6K
	 iaMpAtstMBtnFHnBRPwlgKMDxXxTn/WvQm8cFN1xCybE7YHLrAMnxIikzp+rBrbM02+UI
	 RYfmyGJ/lXKXgCLiN38oLnj0G9P0N6rMbZftuuUmQaDk71lJw7igywLnHrhCECGWCUy77
	 Ei+JZhDOC3jt05uI55pldxdF1Dm4iBs9VwYLgQIhi/LQA05grqpYpkky8rZ/0AMBylg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791291629;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
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
	bh=Dhn0YDIEMSw0jb52Oave7Wc5N+GXHMOAhpYGNtJY0Nk=;
	b=eqAhxW0csfNS+gLdqwQhFykdnwrJaPoOnWjc1vUR+eLVAvtIlo1He7HEFJvA9pr41nxr
	 4DjlDqi1S+VaxbduUlKYkkpPeLdbMTAiW4BhSLvzFx82Nq0/zpAxSZ8khOlmMU4Rs5S5C
	 a+IKd26yUmHKhVIME5gNZsalXd6AJn6IjAJqvlbJZhW5b25u0LOwez/8KvOe2S2bnWA9A
	 IJh80AIZinn/iCjPtxWsxUji20Waw0jNRGZ7b9oH+iCXjvAGJtbUV5/fvrGmrozZ9X0TJ
	 gGUz95cg5ExBJ4yFND6x0LvF+tq7LYLgtx4gri1Gf0VJLyX9Dyla9rGUkdNXzWpOGbg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791291629;
	bh=Dhn0YDIEMSw0jb52Oave7Wc5N+GXHMOAhpYGNtJY0Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xfZuSB68/Gel/KYfN7ufS/rCv1UlO2qFXublNbmpLHQptBsG9V2XFiJzCJFtkyjtH
	 iUg6gDwLU5IzA6PHOxaTZdoZqPaB8iJ+etAvmLAsMeoHQ9TKeBKp31TW06JzE4qjuV
	 ndW8F+V0aLezicTw4C5wx9WrIc+WeLSF9qYCtUM4oXo0tCo/PGJBNr8OVQJRZfjtET
	 GWoCt2waZQVG+/SxXlwzghQSLNyYbwxzPzr0cTSqqUUHzuHzCrzWyFTx5d3uT5NagC
	 lQMYRGb9VOdmaqGg/a1YwoD0WnsjBvRl4I4axtuzqeleHCxvjOkLuj/KYuBBLzGeaF
	 sSwDs+wpq8HQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0502980BD4;
	Tue,  6 Oct 2026 13:00:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A2942E0
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B1F640563
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KTMmAjsopf5H for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 09:28:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D7EE40553
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791278933;
 b=tcWnDqs/hZRAtcT4Vuiv1DWeN0PZAde3ORVIyyI7+xBSbdge2ij6PLycXEUfp22/1yFk
 agu37xVdb8yPQq762O21MkuGtFlA6ThrxXgg1ep+nsxSWhP+9mqqrrRb76kerPm720Ywv
 k2wfjtEhaCK8pEU2MQ7hIgE7cjAbK8ciWI6E8T3LZ0sL9o+LN4EEx62wwxDv/LvcJDuqt
 iQnRVh+Mj7UhrU45meHWZUa5f3paHmpn0CrJb1GNwFZHItNqy9jnQPyREJ5CE75IfrEXe
 42CvGsPv4h5jz364QHpyHdbojHBl5CzVMhXKDudHBbgGQ37g+uWXXNRrm1GdstHJkKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791278933;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Dhn0YDIEMSw0jb52Oave7Wc5N+GXHMOAhpYGNtJY0Nk=;
 b=W8tNsj1lzW3UdaPOndgbFWL1DlpVyxNJ9VcfkFsuqmtwTdWxe8AFFP5xIRNYFYGa5/Hj
 6pdMo2KVbSNg0mcyQBrVs8Zf24T1RMETuDC5RXMcyzWyVlyedaxmUepFmnrtlwOF2UXmm
 ySnBXUYq3MTV0c5Q6KSDG4Kv6hCIXliaBSUgunhW9CdO4EKsGNdvhsRvMIUR4AzEiV3Qb
 sZMVBBOb7zsIjbSsh3cdZS4xDvTSsR5UNCajeJBD1UiFInDL3Q2XjkNi7xkfp66o9YPLZ
 Htw2fIgzXCNSGImIFPzS5K3nIwz5xL4uP4K/vCLXvF92Ju9KBpz8JsqphhWptH/QJIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=emteria.com; 
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=Cy7k8BWo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=Cy7k8BWo
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D7EE40553
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oby4PWSuH5ujwUekvIuOsWPlbYRZt1ocz629HlrDezmlk2MkgWiEAUB7W+Bc9aqaqA9nNaODUW/Z2gqBcjZL4sYa85izxSqvpx07EfNOUD6NLlrsTIwy1EOwGfIHu+csi4JFU0SglKJGlmoT/Xmo9d1Er0YziMaT1TpP45F+sEn9VnaTninb7rnK68eOtJMHAkGQ+ZLrdt0NdqhSM37tHI90yibmyf7Q/rTle6MHonfBv+pHJY32TweSZX+q6w+PuR4AqKZOZZZrU+OQ9zlxEKdeiFlAa9ahiUnLFs23VnHE8ccuYiBZDYFcGHub3cOndtsxQ6zxaer6seYPKrwYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhn0YDIEMSw0jb52Oave7Wc5N+GXHMOAhpYGNtJY0Nk=;
 b=Vh0VZgGAEA5Sut4Fw3qYySJUIz5A3VYc6MLt6FXCEt4KozFtdI1hhPkGZPy0S5vmCNL+hvorVOkVmTG65T5BgMO/9+uV0jtRBAjToBM65IB5gSRCEqv7OVK8sTThVwT6ut6xu8d1S5TQQ6RZxyd1nq0fie4lQyWU9KJfaM0zyb2oapSkyY+CPFnGU7C2t8J5ORHVqpMsUk93QIeTL4QM8cq7XvbwYXPnvj0FHmV/cLBFu66YvHYCISVkDIMgu8U7d9lQQPG861//PQm92K6qyO1QZqSfX+MEZBoYgQq1UI4vPFZXfeGjF8k2tti9fnwwPdadWsDlY5OHznlpX9aJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhn0YDIEMSw0jb52Oave7Wc5N+GXHMOAhpYGNtJY0Nk=;
 b=Cy7k8BWovP+W1IV+eWRadVnWAjR15kSSnY158xf87eQSkRob2RTsp1gjpRTmH8PTzgFFkjyWCTS92rUkzdFOc9nv+quzhCHCE14nij1MlYIUMbCddWvBNVZg2Jbn+0nNrjx37kI9YcTAbtbroyYu9Vlzb5mnqQo3DOjGZnicsW4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by VI0PR04MB12007.eurprd04.prod.outlook.com (2603:10a6:800:314::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Tue, 6 Oct
 2026 09:28:47 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:28:47 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Jan Kehren <jan.kehren@emteria.com>
Subject: [PATCH v2 1/2] avb: Drop the mmc naming from the block IO helpers
Date: Tue,  6 Oct 2026 11:27:30 +0200
Message-ID: <20261006092732.3577974-2-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006092732.3577974-1-jan.kehren@emteria.com>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|VI0PR04MB12007:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5c6e36-c52a-4de8-679a-08df238c3928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10070799003|52116014|10067099003|56012099006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UhdlyaQCSPLRtmvEIebd6Iatj33Rnh9TwDDqLxkK/3I4Sbjmp02KC5L8m6OtRtYaB6QR4lhq85xEfsqVgBIhFItfcfHWZRQjZolHEQ9/PFHddlcWI8No1fZgbraWxX8wxMvEFgAZxMng86j/rsdeTTGFd2xuc5gbbaZZlSZ/MbVxifPnckfYck9vjnBH3+iXAVtFmwRsvrCebFBSGA6OcdxWbsLceBdHSVWcaXkKeh8z9nUhY501UB5fuJjg1nMpzpYKqM18ysT86olzOPweTE+Z1OsApTItULhLAyvdLxe7Fz4FAZLRP8/c1UUMkb05qemttyLGdHTjf6OmaGDXVHg3pEon35eSMSuiEgaUD+D5SdrCDt2gEw/N4afHc6G8dieAR35aAvwRIyXV7XdzJtZ+2s0a5mNRCepPtXLtAjrz35PdB0Ue+FopT7R7RmYBux5cuqiPXalmjMb1VgbGqUxuyehWEWvC7elq8kHq3uYCyfBVkFKikIcKHn+9nM0486+9PAnhC6aOB3iqEaBDa6IFLw0ENQ0197Iz8iFBSzfQqns+a/NEVqqPavJ/eMVzYEcDpCE3vjTPuTiwGCdNSgwAorz/CNH+2LjI34D0JWkx0NZPXIYgiHPxY0ccqCb95LE3f9/x/2eZBOKrYuqBDCSUBYYEWBHK195XmYjRUYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(52116014)(10067099003)(56012099006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TLSa2QIhddmmhghnN3uLWE/dQNODRzQqy+OItWciJkWW5oY9XZvcXMzAxVW2?=
 =?us-ascii?Q?ou+yRyaKT6cfU/TYK6UFeXTUUPjghpYRaQEzkui8HOXkv0UQ6xksn8Nu/9PG?=
 =?us-ascii?Q?Ts9wApCGjC9P5hmCV7e6HZbz0aBGwH746HDOSU+axfY1e7tFhly4Bmv3kuV3?=
 =?us-ascii?Q?O8dxgcfbADr7y7sjLpKrVyOCZWmOn2VZkiCaIUBiYCYz+sCNKJ4hnojvdt0p?=
 =?us-ascii?Q?gSeSEba1m8EMrHrk4DIw9VCFc85fqo+Dqn5jlOrATlLEDi9m0paTXfou7l0u?=
 =?us-ascii?Q?EIxi1w+NEYWrtkYeuj2y/YV3DXX6v7UJPEoVBgeSUJ4uTi3oOLVMctc5SqIf?=
 =?us-ascii?Q?cgSkgew3j3tG4kaemP/lSANoOwiVro+36jq1aqtbpRrwXfqVhE82YHLVt0pc?=
 =?us-ascii?Q?jgVqhRyhHvXIfhVV2H8zoapB6Q0GvXSZrvThT/aDF0PCBpb3B0HqEhfouhgi?=
 =?us-ascii?Q?ny9PGRvTKsuKbmMEEfE46mvIaoVHA2NLJiG8yDOEBF0zbxqTbuEBwfC14YIJ?=
 =?us-ascii?Q?um5epibLtWFv20X7Al9VKuJGo3PZ8KYrVzjDduJpj8Y7+wX3jTToNN5xbkPR?=
 =?us-ascii?Q?m8U7ruEhshR2jA6D4LUNBlztu8SN19uj+jV/TslhdflDMxjiGaEghXO69KGW?=
 =?us-ascii?Q?5xgdw4ovw7OJVDL5xyNeHEjS40lwUJy9Y5e+9Z/BL+C+/OOyHy+FPENrhy/l?=
 =?us-ascii?Q?3E62TBW2RHcYPvaPxIgnuZbSfEFrkNrCjtDWDQUkZ11+a63mcnoCiYFWxW7s?=
 =?us-ascii?Q?XpunoRMEVqhARCPzTnAKJi4hzL0WfA4u7EDNhruRW2PVqtaXzFc4e/P0LuxA?=
 =?us-ascii?Q?C1ZoUy22I5cRguPd4gh/CtBAWSMdmzkDSg5feKwtoPfhoeWzfhdsgH4qDP2T?=
 =?us-ascii?Q?xr45WRC/OFJPkJ8atsETz2a/Yzu2CS9qMQ7qt2y5+Xr1Q80SKLI3sA5rVGNW?=
 =?us-ascii?Q?JTFmTkf80F4b4DxJukRkhmwaBOmJaxTtSoS8mwKwjdyN6MeaKOfgctcPGN/n?=
 =?us-ascii?Q?VT3y7LWnclZ/dKCq/vnvYQWzYrO++3cnFCfrXSnrOwhr1kVFO0VRKj1VAqSO?=
 =?us-ascii?Q?p3rOU2tqan+ag0/IBpNSFAljmWHeqtlROTtPJtux3dWx1guZvw44o0rtwTt3?=
 =?us-ascii?Q?c+ym3EW43jvRnin9b7OdSGgyGHoCZ8LmP1nPJB4/Nu0J0oUHZshs6OY0nAEV?=
 =?us-ascii?Q?+HvYEitYlq5zMYZk8tbYlo+eM8ON7FrORAIymJmlHH8BXTBwvEoERkflcHQb?=
 =?us-ascii?Q?7yNZ8zr0bFxrJg816W7upbbtaYivZ/qWhsCXNYFEcTlzRzWsy9wI9JarrV2C?=
 =?us-ascii?Q?SxoYxWc5Lv2WI1IuMubZXIVv3z6tLcgWBIJVRtRkG6+tR852bURqiojFlnGP?=
 =?us-ascii?Q?0QaN5s+s8ifs5GioSWFDyNMwToaUy45uHDhlL5cn/wCarh0Z2rQvwtns7zMd?=
 =?us-ascii?Q?+g/GWfe8BxgdosdyZ2nA3on0dfyK+WYEwq0MF23HxLfEQ1oZjyS1W7fAStzb?=
 =?us-ascii?Q?k7natRZjXX/DQ7gGBzlIuAANfWHKjUhe/X30LvDGfI0ONMmqzZISsDDNrdjE?=
 =?us-ascii?Q?ACrhc87FbPJWCGv0GDX6A8Gb/aeOR6jijX7dA7nwv74fCvT4ZKNVNwrCtmRJ?=
 =?us-ascii?Q?sQX87UYBP5ey29AUPnNX2Zoi2NgGi47v9nn2f42ckJ/7WoSjl0Oq3VoKfBiT?=
 =?us-ascii?Q?UeYVqpnHR5iiZ2u/xY56/7BZuhT7+9nqLot2uTcecofxqvd5bng2zovq8t74?=
 =?us-ascii?Q?XnGodK0ESybBlFgEAxRCG5vyjULr4AQd/g2q9JEFY3SKc19ystng0eP39tLP?=
X-MS-Exchange-AntiSpam-MessageData-1: J80FqNesvF6Cfw==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5c6e36-c52a-4de8-679a-08df238c3928
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:28:47.2117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVpSxiUg3mugsYHORhJAwBY2jeszYI4TCt33mCMvo8TPCTn89P4yO0gJYy47xzimdDRA8kBD5QeEH8GD33ug9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12007
X-Mailman-Approved-At: Tue, 06 Oct 2026 13:00:03 +0000
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

The AVB IO helpers and struct mmc_part only ever touched struct blk_desc:
nothing in them is mmc-specific. The names say otherwise, which makes the
mmc assumption in AVB look wider than it is.

Rename them after what they do, in the AVB namespace rather than the block
layer's: avb_blk_read_and_flush(), avb_blk_write(), avb_blk_byte_io(),
struct avb_blk_part and enum avb_io_type with AVB_IO_READ/AVB_IO_WRITE.
The block descriptor field loses its mmc_ prefix for the same reason.

No functional change.

Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
---
Changes in v2:
- New patch: split out of "avb: Take a storage interface in the AVB
  operations" so the rename lands on its own, with no functional change
- Keep the _and_flush suffix on avb_blk_read_and_flush(), it still flushes
  the cache after reading
- Re-align continuation lines that the longer helper names had broken

 common/avb_verify.c  | 106 +++++++++++++++++++++----------------------
 include/avb_verify.h |  12 ++---
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index b96cd1ebd7..fc29433c3c 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -304,13 +304,13 @@ char *avb_set_enforce_verity(const char *cmdline)
 
 /**
  * ============================================================================
- * IO(mmc) auxiliary functions
+ * Block IO auxiliary functions
  * ============================================================================
  */
-static unsigned long mmc_read_and_flush(struct mmc_part *part,
-					lbaint_t start,
-					lbaint_t sectors,
-					void *buffer)
+static unsigned long avb_blk_read_and_flush(struct avb_blk_part *part,
+					    lbaint_t start,
+					    lbaint_t sectors,
+					    void *buffer)
 {
 	unsigned long blks;
 	void *tmp_buf;
@@ -342,7 +342,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 		tmp_buf = buffer;
 	}
 
-	blks = blk_dread(part->mmc_blk,
+	blks = blk_dread(part->blk,
 			 start, sectors, tmp_buf);
 	/* flush cache after read */
 	flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
@@ -353,8 +353,8 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	return blks;
 }
 
-static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
-			       lbaint_t sectors, void *buffer)
+static unsigned long avb_blk_write(struct avb_blk_part *part, lbaint_t start,
+				   lbaint_t sectors, void *buffer)
 {
 	void *tmp_buf;
 	size_t buf_size;
@@ -382,19 +382,19 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
 		tmp_buf = buffer;
 	}
 
-	return blk_dwrite(part->mmc_blk,
+	return blk_dwrite(part->blk,
 			  start, sectors, tmp_buf);
 }
 
-static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
+static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
 {
 	int ret;
 	u8 dev_num;
 	int part_num = 0;
-	struct mmc_part *part;
-	struct blk_desc *mmc_blk;
+	struct avb_blk_part *part;
+	struct blk_desc *blk;
 
-	part = malloc(sizeof(struct mmc_part));
+	part = malloc(sizeof(struct avb_blk_part));
 	if (!part)
 		return NULL;
 
@@ -421,20 +421,20 @@ static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
 		}
 	}
 
-	mmc_blk = mmc_get_blk_desc(part->mmc);
-	if (!mmc_blk) {
+	blk = mmc_get_blk_desc(part->mmc);
+	if (!blk) {
 		printf("%s: failed to obtain block descriptor\n", __func__);
 		goto err;
 	}
 
-	ret = part_get_info_by_name(mmc_blk, partition, &part->info);
+	ret = part_get_info_by_name(blk, partition, &part->info);
 	if (ret < 0) {
 		printf("%s: can't find partition '%s'\n", __func__, partition);
 		goto err;
 	}
 
 	part->dev_num = dev_num;
-	part->mmc_blk = mmc_blk;
+	part->blk = blk;
 
 	return part;
 err:
@@ -442,22 +442,22 @@ err:
 	return NULL;
 }
 
-static AvbIOResult mmc_byte_io(AvbOps *ops,
-			       const char *partition,
-			       s64 offset,
-			       size_t num_bytes,
-			       void *buffer,
-			       size_t *out_num_read,
-			       enum mmc_io_type io_type)
+static AvbIOResult avb_blk_byte_io(AvbOps *ops,
+				   const char *partition,
+				   s64 offset,
+				   size_t num_bytes,
+				   void *buffer,
+				   size_t *out_num_read,
+				   enum avb_io_type io_type)
 {
 	ulong ret;
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 	u64 start_offset, start_sector, sectors, residue;
 	u8 *tmp_buf;
 	size_t io_cnt = 0;
 	AvbIOResult io_ret = AVB_IO_RESULT_OK;
 
-	if (!partition || !buffer || io_type > IO_WRITE)
+	if (!partition || !buffer || io_type > AVB_IO_WRITE)
 		return AVB_IO_RESULT_ERROR_IO;
 
 	part = get_partition(ops, partition);
@@ -486,11 +486,11 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				residue = num_bytes;
 			}
 
-			if (io_type == IO_READ) {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 1, tmp_buf);
+			if (io_type == AVB_IO_READ) {
+				ret = avb_blk_read_and_flush(part,
+							     part->info.start +
+							     start_sector,
+							     1, tmp_buf);
 
 				if (ret != 1) {
 					printf("%s: read error (%ld, %lld)\n",
@@ -505,10 +505,10 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				tmp_buf += (start_offset % part->info.blksz);
 				memcpy(buffer, (void *)tmp_buf, residue);
 			} else {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 1, tmp_buf);
+				ret = avb_blk_read_and_flush(part,
+							     part->info.start +
+							     start_sector,
+							     1, tmp_buf);
 
 				if (ret != 1) {
 					printf("%s: read error (%ld, %lld)\n",
@@ -520,8 +520,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 					start_offset % part->info.blksz,
 					buffer, residue);
 
-				ret = mmc_write(part, part->info.start +
-						start_sector, 1, tmp_buf);
+				ret = avb_blk_write(part, part->info.start +
+						    start_sector, 1, tmp_buf);
 				if (ret != 1) {
 					printf("%s: write error (%ld, %lld)\n",
 					       __func__, ret, start_sector);
@@ -538,16 +538,16 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 		}
 
 		if (sectors) {
-			if (io_type == IO_READ) {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 sectors, buffer);
+			if (io_type == AVB_IO_READ) {
+				ret = avb_blk_read_and_flush(part,
+							     part->info.start +
+							     start_sector,
+							     sectors, buffer);
 			} else {
-				ret = mmc_write(part,
-						part->info.start +
-						start_sector,
-						sectors, buffer);
+				ret = avb_blk_write(part,
+						    part->info.start +
+						    start_sector,
+						    sectors, buffer);
 			}
 
 			if (!ret) {
@@ -564,7 +564,7 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 	}
 
 	/* Set counter for read operation */
-	if (io_type == IO_READ && out_num_read)
+	if (io_type == AVB_IO_READ && out_num_read)
 		*out_num_read = io_cnt;
 
 out:
@@ -603,8 +603,8 @@ static AvbIOResult read_from_partition(AvbOps *ops,
 				       void *buffer,
 				       size_t *out_num_read)
 {
-	return mmc_byte_io(ops, partition_name, offset_from_partition,
-			   num_bytes, buffer, out_num_read, IO_READ);
+	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
+			       num_bytes, buffer, out_num_read, AVB_IO_READ);
 }
 
 /**
@@ -630,8 +630,8 @@ static AvbIOResult write_to_partition(AvbOps *ops,
 				      size_t num_bytes,
 				      const void *buffer)
 {
-	return mmc_byte_io(ops, partition_name, offset_from_partition,
-			   num_bytes, (void *)buffer, NULL, IO_WRITE);
+	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
+			       num_bytes, (void *)buffer, NULL, AVB_IO_WRITE);
 }
 
 /**
@@ -883,7 +883,7 @@ static AvbIOResult get_unique_guid_for_partition(AvbOps *ops,
 						 char *guid_buf,
 						 size_t guid_buf_size)
 {
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 	size_t uuid_size;
 
 	part = get_partition(ops, partition);
@@ -920,7 +920,7 @@ static AvbIOResult get_size_of_partition(AvbOps *ops,
 					 const char *partition,
 					 u64 *out_size_num_bytes)
 {
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 
 	if (!out_size_num_bytes)
 		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 66655aab87..8c97adbfbf 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -32,16 +32,16 @@ struct AvbOpsData {
 #endif
 };
 
-struct mmc_part {
+struct avb_blk_part {
 	int dev_num;
 	struct mmc *mmc;
-	struct blk_desc *mmc_blk;
+	struct blk_desc *blk;
 	struct disk_partition info;
 };
 
-enum mmc_io_type {
-	IO_READ,
-	IO_WRITE
+enum avb_io_type {
+	AVB_IO_READ,
+	AVB_IO_WRITE
 };
 
 AvbOps *avb_ops_alloc(int boot_device);
@@ -78,7 +78,7 @@ const char *str_avb_slot_error(AvbSlotVerifyResult res);
  * I/O helper inline functions
  * ============================================================================
  */
-static inline uint64_t calc_offset(struct mmc_part *part, int64_t offset)
+static inline uint64_t calc_offset(struct avb_blk_part *part, int64_t offset)
 {
 	u64 part_size = part->info.size * part->info.blksz;
 
-- 
2.43.0

