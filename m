Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91665606A334
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wo68d79S;
	dkim=pass (1024-bit key, unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=jxZxMVRo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E81E806ED;
	Mon, 23 Nov 2026 10:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 60erO3l9Zm_4; Mon, 23 Nov 2026 10:23:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AEE8080956
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429407;
	b=on6eVEqRzXTLIR4aidH9lSn8sz3b8h9Qv/+WZpioYS0TsTuoAfZ1oWLBQcA/ibK28D9K
	 X8wd15eDKYsSpcD4ZKxzrW/Gb/C34/u2NwGeJBKttgazQJfLEto8Daub1AjEOZOfi3aad
	 I3jnXN2fQ0SvZ3IIma2lkj+1prHvHCwLitL5lpma/qH2A/OggNEuWskTE7mYfMt6evzgP
	 WDYrKiTCcKt4euvU2MUCdf/XlSG02zVTZUD5tDa8UjPLA4+5JByi1JyhPSNCWz5PrShcY
	 7NsejfRKtqaV4U/oqvEYcnJE+mMbwzpNMDNN8IvGzVI+cT0ejXurMXyFJLtMHK/+tCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eu67hp64HWjydaR7eDnqlvlIRiK4690UvTHilXEHUSQ=;
	b=WrHZwNB5futtmpT73erd+jPiKS4ysLwzhpiG+U2bQJc6slPYQWU/S3V1W0+YSOlNxLlG
	 +zva84uLLNapQMBvCsYOTcHZLVCRWyR6OtTfOKVxzY1IND4DrsddvoeVEnZABFoyOqVRE
	 1jnEBsWA8lmmX08sWV56Rc8mIUFz797JmNu9om/UepQ72efq4kkZCiruPpLABefexsqDC
	 RPkvbI5qyUaCmIbXAY+b6nNNCD4hADxkLtZAzdtgsbbysjiJ8inhpFdC6bPZjHYM4qekX
	 aWJyNadnx9w8CJJzOk23gWNgFFCWRplzq/5VQFmEKHFehE2lJQhUIJYJWL0csg4/txA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429407;
	bh=eu67hp64HWjydaR7eDnqlvlIRiK4690UvTHilXEHUSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wo68d79SOwluUqxRDluOzhe+bwISfmdt5ZTTzuYgJ5OVgrZdkF7o6QwRiNVIGEuwB
	 rmfi/9ZXE2ae2vTosaUho6J5/RabGt7rMSQXzWCytQN7Vy1KCN0eE/80Ck/vV2Ze2z
	 aBWHFN1w/WlPr+8b91rnADs4OTjga7cb2EawZ1z6ZnP3akb4P914MOG6apZzEV9rpm
	 3HUompJw4S3XCtN92QBwhVVGcxWTmAVjEcS7VsFYC4XH4JKW6kJDvqqgRu839dtlMi
	 dfgctzoDmlJ19LTpLkv1neYAo3lnlT6pmYeMuLVvasW0VIGinozQ49/tzLP9s8RTHE
	 8pew/tiNfIe8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEE8080956;
	Mon, 23 Nov 2026 10:23:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39D92371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 372EA4066D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLkdfLbUM0be for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04E684065C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=194.104.109.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=jxZxMVRo
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04E684065C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1795429402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eu67hp64HWjydaR7eDnqlvlIRiK4690UvTHilXEHUSQ=;
 b=jxZxMVRoHb+AEvrS4ZBfAS9N6EkNSoU2En6Se3fap/XULsccj83FnoKCbTsucTpwBDyzUg
 3rKPXmL1zwuYqWysZidqUewMjtIxR0QAw6h+QK1TawmAhHCUb2zHg8srIg+0UyzfDsjZqO
 FkgmxsRyS8MCZ3mK6YMHtyhQAE6Tyas=
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11022086.outbound.protection.outlook.com
 [40.107.168.86]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-25-Xr_U11yYPFWuS9xLs9z8RA-1; Mon, 23 Nov 2026 10:23:19 +0000
X-MC-Unique: Xr_U11yYPFWuS9xLs9z8RA-1
X-Mimecast-MFC-AGG-ID: Xr_U11yYPFWuS9xLs9z8RA_1795429398
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR4P278MB2192.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:c2::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Mon, 23 Nov 2026 10:23:16 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:23:16 +0000
Date: Mon, 23 Nov 2026 11:23:13 +0100
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] arm: dts: vf610-colibri: name both modules in the model
Message-ID: <awQUEfOxoY3HndVW@francesco-nb>
References: <20261123101145.816388-1-mehmet.fide@gmail.com>
In-Reply-To: <20261123101145.816388-1-mehmet.fide@gmail.com>
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|ZR4P278MB2192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afa250c-4e3d-4c5b-5fac-08df494bc987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|261021123027099003|261021121427099003|261022075727099003|261026121527099003|261102123227099003|22082099003|18002099003
X-Microsoft-Antispam-Message-Info: cNg2xbZqOjM//Z0htVshycPUhLzqRG73yNRgQpn+HwMXWG1TWOBNqgvsY4scpfzKDJzdfROIV/mMbOqBzE6YC+rCVstPqOdZaMO/2SiWBiF5tTkQlfi5YNsXoU2AeXb4rYhr6aaNNzxixKrWGo2++teWB9/aUN6JnE/Br5RJs6OCNJa9dmYslz/mtvMcquX6Du7N3Q84gJxWsZPGao3IGfK63NpVyIuMtUFCL5PluXVRzQkMegbb+AeVJM9HcywScNOHQqCHo0eeZ9OMvKkImnsdGk/A0Lrdnru47q7OISOF9Ni/xaDu9PC5SK0wOnMd5G96eWEPY4Awo6sTCMD+M2E09xsWIW1F9WTzlvABKbmzbTNO+TJAF2i6SWfuoG+3at9qOvOq6/ny3sh16Amb/cUQspic7t1cH34Pfv/sGOhLLPp3Tgjn/ec3jx8PdnLLufQzowm1ZCFJxsGNHZE3qja1MuFqdVnOYb7kNeUrlf5J1R5XRIC6P5rsmGoeMPgyiqm9LxDKSIQHp1M5qrAJ1/WhRxsa6M5cMGWm+99utBqonjgoptIBCArVtJNFu4QsZKFOaBqHuAxwydL2a18F1xd2DIZ3V4gwMUUHrM4bmR6Xbxf7cH1TGs/NrKUyFjL2FdjFXSJ1eRrq8+5DmAE4ESKEREBPUqDr1K9sszkLeyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TXmA6NYuM2skZ9NaUautJ0zDsFNWC7KIO4ir75+8qnrpbYklZcvddQemz4n4?=
 =?us-ascii?Q?H7/SwI1/fHnNZRnn3jIdY/E8A0eLhh26WRGRZa+nMZt3DwzohPhK6Eg+pQ7d?=
 =?us-ascii?Q?ODDkpIrywe7S47b+63VMp1c6cuzy0K7VzbXmLFej4gqHIMXY1FsVHtMbPakM?=
 =?us-ascii?Q?oTaZeOcx8qsF6HzgKcWahMzxh8J4popQWcU7jo3NAA4ReJatFHp02j3z/oFf?=
 =?us-ascii?Q?OEOH82y96v3xdy9bTwPnOrwK7+80+F4hlr38pupB8n0HF8/Z74yitZfCQA/x?=
 =?us-ascii?Q?gQJZaJrIY0uJDCAxpUE2ziZbroDFMDlUZVHymInHeo8IrlUQJhmFFCV9FbYs?=
 =?us-ascii?Q?kEnKPU6B/B5r9l0sVcGSOs8yxq/q34e/3QUr9kj2OOFe7SGrQWO1l57IgcPC?=
 =?us-ascii?Q?cEnrJA8mjU9dC1u8mScQZ78MLg2FKbS6Wv1eJgzRSpq6JbnpdEgzFC0lKZCC?=
 =?us-ascii?Q?sIiO5hllJC+8RZbAxVJlpUiEjoumkOeJAO7CUqMeLO+I6Eru2iwPzcUpW14P?=
 =?us-ascii?Q?pRYKvV/d+RsMF++gk8bzrDhnMYu0A8Da8IFXTN2OVEDW2vUWMWDe1DPbCTBn?=
 =?us-ascii?Q?6mh9nWfi0Rr7YsPHP7TirEVMCS23p4LulGgsl1m4XGNeebn2HmNadleGYuuI?=
 =?us-ascii?Q?DU69C/QMbz8GWg0ylZgvngviBWKijpJu+XL1ahcDy2p1ZvWMJT9XTUb5w5uv?=
 =?us-ascii?Q?bzWMFJKz0VnKOdGggxKXQ6XKOVuLk1RKzbUj1EIZOERwUMOmdtebvKA9vupi?=
 =?us-ascii?Q?UThpdSd5XBvFeTocgMqMBS0JvQi9xQJ5jeEztRdDT/+VkyXbbHiynMSKV47G?=
 =?us-ascii?Q?kRpcVVGw/pYHJKHoPAQ66humBmqdLw5ROJUWOFXKmS7Z4ZSW9POadwqYocbX?=
 =?us-ascii?Q?DP1iY2wmwuH7XUq7PFkg97PaQoqC8PO8Xixj5HgWabL5DYrWRPD9YAYmqAhw?=
 =?us-ascii?Q?egU74B9pRXe0u1Xf/Ryb/LRzMevUGj9ydQHSse5mPbkyP6NXPnBg2B2UM3t6?=
 =?us-ascii?Q?Vmokj1niXOk9UdfP91gDNZupuWOPcfe0JMXrB7piL4bgX5rWFyA0PEqsreCc?=
 =?us-ascii?Q?hm6C4Knb04Ny9mbxMnKcL1XqxgPqPERXPLJndHrU38MTVWZh86XOlJwmCZYQ?=
 =?us-ascii?Q?xzVd0BoDIz/6oDaebWKBGd35CDTVZtpl0S7kzyYZX4AnHA7Dp+F+sDr9xi4O?=
 =?us-ascii?Q?Sba63F9zHvbd+jurv4NNPkXUm//B4qAOCCLdTzlL/OtUtigf9JciS+qLU+P4?=
 =?us-ascii?Q?7cNAh6abXXyljxWmwRpl5erLwnydbz/xvnCKASmUg61VztcGjcuhUFGJho07?=
 =?us-ascii?Q?TRiOajG466U7kkSxecSaJ2ZDmJEzljc+UbKe1gXY1PbguxqVcw+M0G8WfHLx?=
 =?us-ascii?Q?tiIJxNrjlb6IHZIycc+pMoP9M6FddjR3UWfBNFWqv1FO6PGZmo25D11YI7aD?=
 =?us-ascii?Q?vQKmf7cf+c1N4WilUKKfAUB3Wv8jo5CBLgmvEz9ULdNUs+vYzTNdA+ZM/zd/?=
 =?us-ascii?Q?sOuz0oJpxjggFieAso79/3Z+zh1hMsxMR68C+U8qEDE8Ha2a7ogcpoCFJsKs?=
 =?us-ascii?Q?/ClPA3rkqnfG6c8qmDfJxclmkPV+9VmUfEbJRRTp1ow+rTWajsXRHv6CQm4f?=
 =?us-ascii?Q?eA/i2iUmBBzvTzUGw+wxAAdb4HwOd5nwfPicFq82Jy3tqoIToHGkz2Z7EfJa?=
 =?us-ascii?Q?DBqQo/QUFyFJm3VKrPKVqRarmAwzw7zyU9NXwFa5z7+27uwZSsrcf5wqKKw6?=
 =?us-ascii?Q?YBguYAeY3HY6OYnW2FtcQLEhuKftrtY=3D?=
X-Exchange-RoutingPolicyChecked: OH9Bktuo0DeSPIY4bg27d0MHTrrNZyzOG9BLhNgH4m4yUuQjfu0qnx+ygG/QtnxqbO7uRf+laNCgilSWmZKeTPnNNWw1T9Ci7u6Y4GmYg06NA00/A2XAua4HvGEWKzVlLXe4F/EWimmGGxYHsqpQx3etqvS/mVmi31SryR9Y0vNGp9jPrs3NdAB+cbuEV/XgyOojXXA0G9dZM5+FW/JsZydPmBWu7n8X8g12lN6Aw0+4NwmUPw+HfxdrcTDPXGHYVHmWZTrtnPpjhMAW+m5T6BRfDckP+D5Yngnq9ID5IsI05t378xpRUst9DS4/6G+JZvOvRpM+Bdra0kBnhyr8iA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afa250c-4e3d-4c5b-5fac-08df494bc987
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:23:16.4698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcvjUmfDJYgRD04JEP3gDm0HZ8w6Jr3u4RP7UEhMJjiBXSqjC1NyoTgRGbbd1L0ii1Wwz2pjTZcReia2hh5WJFvqBS2gqpT4zNSsery9Rb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB2192
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O7GUQxFhIuFiP-RHHfIUxOfVz5Defl5LzUBsxfIkpbU_1795429398
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 11:11:45AM +0100, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>=20
> colibri_vf runs on the Colibri VF50 and the Colibri VF61 with one
> device tree, vf610-colibri-eval-v3, whose model names the VF61 only.
> Since U-Boot prints the device tree model instead of the module name
> from the product ID table, a Colibri VF50 shows:
>=20
>   Model: Toradex Colibri VF61 on Colibri Evaluation Board
>   Toradex SoM: 0013 V1.2B (00131201)
>=20
> Name both modules in the U-Boot model, as the device trees of the
> Colibri iMX6DL/S and the Apalis iMX6Q/D do.
>=20
> Fixes: c19981ab9acb ("toradex: common: Decouple board sysinfo from the pr=
oduct ID table")
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

