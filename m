Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BED3CA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 08:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B1BA406D4;
	Wed,  7 Oct 2026 08:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p0lPmm9LQsxP; Wed,  7 Oct 2026 08:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 61082406AB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791360338;
	b=hcvGJ3EUMBYqErVF6qDkOFn+ja+GJlrL+N8LUofuvznqIwOFfyBOrK75M4PvwQx0p5fl
	 wewSHugriF4f4KEcvd/1fmkupEpD2L7+zWu8N3gjSAOnwSQpwHSqbPItcFnxvcUwrwCVy
	 RSTMtTO34AldxVWiyRBaYT1xY7jwuuVK6v0YaffNGphOhyrfZagFE4rO77cPos9MBrIBm
	 VKInH6qizxF+7oebXuuRmuQjaBVwxd7dtK5HOrTZZp8n/Ep5xKMGq6XK0+pyx8dzOyH7Q
	 7byhyIvCEp1Ih+7srZvQbazuejDm6rt4hO9U+3dWlmq8EkVxTlKy1fpQkg1h6Ji6Rng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791360338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DhHWwG4KVwBofO6Zp3hJOo2iF2XPwlbND9jQ2s3UOTc=;
	b=CwXjyIPNuoCmRscEDXnlyi8nsp2/U5tVnfZDtrVZrwozdVS5cWr9xpOoxJL3+dUM0EL3
	 RyR2v8/zHJcB9DreoQTdxhxqDPXaIk3VdeolJ96SfSee+rhJcHl6U+3Nvfuzf2XYNoj3o
	 0XDlY++0xSXVVNgCjLCF+s/Jr3o9sMkxkbGxZ+611ngHDRP7a84oxRlgJLaScjj9dsL5P
	 PsfRKJ0mhGdw++JePWHuo0qdCav5fJrsTDBP5qXh9ZodShyAiNZ84tAN7w0pO9D+4ylmI
	 9fAMxhFxcpcqpWHBSQqJg2Qn9hRasGTp2WsB5s3NbBESTFKfDHdrMpjBwylLN2A47qA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791360338;
	bh=DhHWwG4KVwBofO6Zp3hJOo2iF2XPwlbND9jQ2s3UOTc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tb6tuLUnWc9vhRcJecFqJ1nljBNQ1smsa6D9RLUwkiD0Ghe66bCZx26kZDjUkHfhJ
	 KZ8tmwSnhSFfDGOyfVjZgKz7BAu0AuvEnMCd2uSmFLEKtReMD8kHVbPoY6EdB0sQ6V
	 +ZttN+YtGqjxVOx/W+zC2vssYmCteGAdtfICCNx0LdG2FexPUI32a34YhNzwZ1J9VG
	 sYgy4ai3PBcQTvUVyStNWEhs3abOya57NghdlWRQtB8VxsOCets095ixO0XKjUEWEK
	 cYAKU0I4lAHBsArDXnj5wlV5HgYqUH9cgyUb7LfoMesrzvu0+es8uhwA9pkj5V9M+l
	 KIB5iOOjDgVYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61082406AB;
	Wed,  7 Oct 2026 08:05:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BB6A341
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 960B340070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TttBcmOkI6aL for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 07:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8D7FA40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791359773;
 b=FjgnNXrZzVFOY56+wr6faclFQ9e4SudCdhv/NNKOkaKkuTNaenkewX+igTADj/Q1QFZc
 wCQqnYumNkf+kDre3D4+hwnbwcoDGVfxu5C0HHmdqv1FFY4flbeIj0E9WdYmuH0gIOGRM
 AdAwkNOH9y19AGJKGuLYi/4hn/LMVys/JMFz96lBtqGTAokwY+d2mHHdAFq7BlSPDcSXT
 t0LjUE1OseljHuEaOg1j8hkc5q5IsOBBl3E90exU9/eAWULct/MdO958nEIFUMGKhEFzT
 hKjnE9TpBjBK/D86ps4fuuiVBe5a5VnYT2Z6M1bqgXfEHvNWdq2k6mqymZAA3mUOVGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791359773;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 bh=DhHWwG4KVwBofO6Zp3hJOo2iF2XPwlbND9jQ2s3UOTc=;
 b=NFRDlM59Fh4njbevMRwBa16tq+XQKM2Zoad8cGI1NFDELgc2NaIuKMyBW94zFIuSN8JE
 DNF9L0Zht27mh0UqdpxBtppOK/JRCeJkR/gDDgZqtmLvpiTFk0wt18fETo3q+yQqzEBjS
 R/EyEyQgRZemxmifZ4MvLzGVhINbYlXcerVR1wo+B7J0x1JXuM6Pld7LCYs5oilHYU4T+
 AkpTQi3tNgfLwg5OQUDE5qqYu3jVAlgr2EgOipECmZGD69l9Lus0SCfPcIuXP7mvegIKF
 u5IBqKoM8ArKkAxDY9wascE3UMMDEuzXrmIGHwIFfvw0rbtik61o2O4HSKfVqfk3nBg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=kontron.de; 
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=hsYtkU9+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=hsYtkU9+
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D7FA40062
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRkIeZzKbLFdAcwqVTkd4BVwNac9+NHhv9NtP7779Dtv7H62pVmwjetU23ug1S9gsmQoMiScnPwYh12ZLTbKOv2UTN3mxKeL/gL4gfHwobkkV0FPqzCJfEwTxszfDIQ+0EO1/6+mQJn9WMbLCykC8zdPKUUQH7a0KSWyeQfQN7WZ/t8RKYCpOadW+rkkFd+ldwF8BaXBV064cvJoqa7E6mYtf/mU23dd5cdajA6Ibq4TogWFg/e5H76dwzEEvLMlBcai1imLqErvwH0iZdqSHPoCVcq0iJwqQTE/CX4u3JgZqlz8FpQvd1HRWWIseQx+ZSIjdu19tH1V3TGoiCdqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhHWwG4KVwBofO6Zp3hJOo2iF2XPwlbND9jQ2s3UOTc=;
 b=sIXijku92PUqb4HuTPHKrGZlen3kgLlv4sSntNbpQP6d44zECCM1tMHq7U5PmeuHGQoBlePFvatlUxUEySzDDU1YT5ZsoiGMh79rkECdV7KBpzjbxcxVVrbFY1g8W4TUGFdBmHajZdnzlPkm2fwgm6rAemzPvVlwPLAPbynfj9fEQqvm9SlK+Q0SyPDK0+9xoi8WyrPciyqTR/J7FKMPn4g+SuMYJvwC+yYRWn3FavcfkAO8kjgrRdlNBjArRAfIwwX3a9Y/SWgLgsmvGTGHyX6y1LsDMGo+96zLs0Q0WyQVl4LA2enhPKI164gqBU5iNtAYsfy05weTUxswQ2P7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhHWwG4KVwBofO6Zp3hJOo2iF2XPwlbND9jQ2s3UOTc=;
 b=hsYtkU9+a/+MiyrL2oGI6yVjmtqT695xg7yVk+XVupkTD4kxcYlnV0/DokD6tRdCwv/TkfJhPRQMiAcfDvoDPcx6jD9dTdFxRU75eAyrcaQDvWBqfMZF4L6AbA0ZdzDUxbLGLMp0EMaj72FBXj/s26H9MovjRut2l0XSNHJlW+KgQNqXwE9Gn/mLIDOWwRppvXuGwuCfuEp7eXenvcFJ6/Fc2PalAUYDvNna4GUhzfubAo/Ha95iqX3WDzI9ZI5q4l0f5RkIACu74AsOxUu45+H4KV8h4Wd+SLC+II/nJEXemXWpHaKBaWFMTkfKv6IYMNjzwnxf2zaPS2j98tUPKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::18)
 by PAWPR10MB516996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:3bc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 7 Oct
 2026 07:56:03 +0000
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536]) by AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536%6]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:56:02 +0000
Message-ID: <0fd81914-a485-4bf1-9161-f2d4f0b17f54@kontron.de>
Date: Wed, 7 Oct 2026 09:56:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] spi: spi-mem: Transform the read operation template
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260927235716.1872707-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e4::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR10MB4273:EE_|PAWPR10MB516996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa8b979-5563-482f-7ed5-08df24486ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dCFiMges2FsR0oJ4CVG7Tup/+XjVfDI9ZMmjXTjSzbZ5QQe9HpVdS2XWREF30uEMGbXW6LuUEwq8L19r6Wx6ZHNmd+OHcNku/GvcmqGq9LemZh3AycoXmp6XCUJ5sHFYmOkn/6iHfsK5MGdZMrbHg50mAvNR4msvnF01eDwNMWgfd+VNNy78TtvhW8uKVHj2NLSjWGNrQndqAdQwX7ZZ7Zy1FZ6pFJ+rie3rGs3u1IrgZey69qM5Tv1l1BjYFbi4RnQvoyxoQxZwKB7hqUqiFiLzMsLkEHN/Q4+zsZUQD+07nIezbcvofJ/jJ7x7JmfCtYs58/Tm3IKAbvzOJcE6RC94FfKeFQAznw3fSDzig4JKgLR/P4U8NUIOiR7ap1CpNJdj4bJuS5Dhi/J3MUaDsVQDYvZqcqOYWUEVJj6rZL2gjCtAm1gpHrTE0W/I9utFmHj1Sig8XYFV1HPx8JvEs2DI8VjujV9YtYBff7LEK/SHm9RblkMHEqa3qDpwdD10zSEh7HEqxgqrnTYmjNOpOkayMF03kgNCEbVVOdq0Xa/0/Vz8QhdvTWA1dOclewxJmbpUKFdnfq6ronRWtQnfE4dwR9CxFMtraBYU6jdW4XdlN6BrVDY+1CUfCZ7qTB5dv48gq+1FMQ4o84Lx/Z4tIYsyaX3Bkosz+Zw8q3JvtZsOOQjK5Y1Bhzb87rnvgYCHC4Qk16bAZ9+d9PcerI58aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzhOdVpJUno4cnl1Z21ITno2eEMxWkNWZUJJK25TTnZZdXkraThYZGp2RlBY?=
 =?utf-8?B?WG5LUytNc1BsZktlWTNZS0hjb1BtdU5Yd1pOVTZwM0x1T1JHc3BxT0xZdnVu?=
 =?utf-8?B?NG5ybHcyc2Q2U1NFSTJvR1BocHRnVW1aZEY3bkozSGF4RGxTN0Zvekw3NDJR?=
 =?utf-8?B?YW8zL2hWQ293SFE4RW1aYVFvUmIvTzdacjVjTUs2V0JJM3ZEdUcxWVlndk9a?=
 =?utf-8?B?T1hnZHpYVXhGWTduZm0yNjRYRHdENlZpejVxUStiSFpzS2FvcUdZaE1BMDBP?=
 =?utf-8?B?dzBKTGZtb2h4b3FUY2VDYVhzZkxRS29vRS9JQnZnbUhuU1hnS0hPdDdwTStt?=
 =?utf-8?B?Nkh0a0lLZzNqWGs3WUVHTkdxWHpETnloL0xZZEJkT0xndUlrUGpKZXhEdVlj?=
 =?utf-8?B?UXQxcUd5U3F3Y2dPc3I4alJxT1lJYWNYSUJrdnRFMTM4U1phMDJYcnhKMlFM?=
 =?utf-8?B?a1NwT3ZHUWFiZmY2M01rQWRLVWVuOHVBUGtuU0VVem4wSTh0VXEzL3I2K0Y5?=
 =?utf-8?B?RU14U3RrdWNNdThTNGNmK0NYYjBLN3NRWFBIRWRWUGd6K2tHR042YkxrUkl1?=
 =?utf-8?B?OU4wRHVTZmJWTWFFWjhzQWZRTG5MdjdldFU0K0I0NVhNaG5EeWRLZlpLTVkw?=
 =?utf-8?B?UTJSbSthSWMzZ2dSY0lTdlBTeU1OMmNvTnZBakRvYmpBa3dmMklSU1JaVUxU?=
 =?utf-8?B?NnVRSDFjdGNEclhsMUpBNTBnWGlPZkIwS0lKWldIQzVZK1dMOFZaM09JeFJQ?=
 =?utf-8?B?ckhHTS96OGNZdlhCS3FOb29KQzNOaUl5TmlOcVp6QjYyYVRUNW5KRnlaeHVu?=
 =?utf-8?B?WVl3NE9JMXExUWlvdkFzZXBLTXBGUGVaOXRtZDYySWFZOVhJekpraHhueG53?=
 =?utf-8?B?RVgyeDA5alpzRy9yV0VzMWVJMXlzc2JNdTYrT0Z2WHVMVFNPekRHc0pOSkJl?=
 =?utf-8?B?UXg0Zk5ySkxtUlNhZktJYmduUmRTM29PeVJYZUd0ZEswUkljWlYzZ0FZYllE?=
 =?utf-8?B?YzRBdzAwV3hlN3FWOFJCQzJjbzh6NkFwRGRJb0k1VUJFeUhwK2RoWjdZeThj?=
 =?utf-8?B?NG16azhHRG5SUmhMcFhYL29IeWtqV3VjMWdSaXVaODZMUklwV0cwN3JtQXRH?=
 =?utf-8?B?K3hDRzBFQ3RmQXBORnRjTDFXL0M1YlpwclBQY0xCVlM0Nm84Qk9aUlhhY01a?=
 =?utf-8?B?SnU5RzVnT2hzQm5NUjZrdXFMN2h6c3ZrbncwdDJYRmVVemRIMTl5WjdQcHZU?=
 =?utf-8?B?MUtVbEFxQ1k3ZStCbVgrU25OeXMvT2FDbVgzcHVjQk93RjNYa0VybmI2TDJE?=
 =?utf-8?B?a3I5R0p0YjljNVgwSW5UaDd2MGIvdGlZOERzZCt1Zi9OMUdnZlFhd0s5cExV?=
 =?utf-8?B?N3pMZ25EdzhiYTMvajF3S0xsSU1uS1BOc2lNdENLaXFjczAxMVhBeEJSRTVE?=
 =?utf-8?B?aTlURWlkeCt0Z1FHcng2M1Z2bjYzdUY5dkM1NWp5c3FqVnFnVDUyZk5mRXRt?=
 =?utf-8?B?T3lsaFcwcElCUW91Z2o5WEk5L3lRdmFsbjloWktUZzVwWWhWU1pFV3JuMlVZ?=
 =?utf-8?B?MGNGL01WbU9iREdDdVRYVlU0UFNYT0ZUSVJ5S3lzWGkxWWxxQXFpVTVKTnVq?=
 =?utf-8?B?TjlNV2prTDNxa0ViQ0ttVVRuSDZpRFpiRGpON0JKMlBIYnZyU1VpVytBM1Q1?=
 =?utf-8?B?WFg5U3VpUVZVcGp2U2s2YjFJenJ0Um9raXk2aGV6MkYza084TUZsWkFvQnBU?=
 =?utf-8?B?MkNIalRzOUVuUDBjR3hNUUM1YkJpdmplZ2pNbHAycTlFbGQ3cDNveWJnbEV6?=
 =?utf-8?B?aDcybUJQZGJSOHRFZUVMSGl0eGlRNVZOUDUwQ0k2ay9XRmFYSXdpSzJ6V3JV?=
 =?utf-8?B?STZtQXZjMUNNVDVHQzFTeXF0U2tOQjNDVG9MY0VaVDMrRDFXbmJtNTB2VmZh?=
 =?utf-8?B?Y0M1L0wwWHBFQ2Q1TnMxZktTeWx2SEN5Q0MzWExyUkZYQ0V2R1htQ0w4eTdF?=
 =?utf-8?B?NWNGenJxK3lrYURUZ2pHeWZhcXcwQVA1Q3pFM3VMbitkQ0VUcEViOGpsNjY2?=
 =?utf-8?B?ZE1zQ25abnlzODh0NEpwTWpYdmQvZ2gyWnI0Nm5HM3JaaWdwZm5lMnlYWno1?=
 =?utf-8?B?aFhkL1Z5eHFDczFUNFk5WHBUaFNqZWJ3a3YvMWdXcitKVXd5QmRsRitIcUFa?=
 =?utf-8?B?TkU3WUF4NlJCYmJtTE5hQ2dDenJEaUFzMEI3azR5VGZ6STlBN29lb3crK09K?=
 =?utf-8?B?TEo3UThTeVJSOTRnZkVjZ2xIVEd1bktCYnFNbGdqZmlZR21yUklPa01xcDV6?=
 =?utf-8?B?K0I5Y3RXSHdUNkJjMUdKbWp3MEF5Y1VGMVh4Z3dYSDhwT3pzeWZ4aW8zUzJP?=
 =?utf-8?Q?TQQowoNmVNu7LjX8=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa8b979-5563-482f-7ed5-08df24486ed5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:56:02.7071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dggcRLGeh00dHlTQFGR8qqD1JTT+N9nLKqTD3Rjmc/rYMfI72Nh8/iRyIdPZDtAqsN7TbRdCicr1UqcMEHQJ3fFAPY7xSLeELsAEqIHgEW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB516996
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

On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> As of now, we only use a single operation template when creating SPI
> memory direct mappings. With the idea to extend this possibility to 2,
> rename the template to reflect that we are currently setting the
> "primary" operation, and create a pointer in the same structure to point
> to it.
> 
> From a user point of view, the op_tmpl name remains but becomes a
> pointer, leading to minor changes in both the SPI NAND and SPI NOR
> cores.
> 
> There is no functional change.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> [Linux commit: 39d0ea33123ffe0214217b529830ad91574c8757]
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c    |  4 ++--
>  drivers/mtd/spi/sf_probe.c     | 22 ++++++++++++----------
>  drivers/mtd/spi/spi-nor-core.c | 20 ++++++++++++--------
>  drivers/spi/airoha_snfi_spi.c  | 10 +++++-----
>  drivers/spi/spi-aspeed-smc.c   |  8 ++++----
>  drivers/spi/spi-mem.c          | 15 ++++++++-------
>  include/spi-mem.h              |  3 ++-
>  7 files changed, 45 insertions(+), 37 deletions(-)
> 

[...]

> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -401,15 +401,15 @@ static ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
>  		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
>  
>  		if (CONFIG_IS_ENABLED(SPI_DIRMAP) && nor->dirmap.rdesc) {
> -			/*
> -			 * Record current operation information which may be used
> -			 * when the address or data length exceeds address mapping.
> -			 */
> -			memcpy(&nor->dirmap.rdesc->info.op_tmpl, &op,
> -			       sizeof(struct spi_mem_op));
> +			struct spi_mem_op *tmp;
> +
> +			/* temporary use another dirmap template */
> +			tmp = nor->dirmap.wdesc->info.op_tmpl;

Looks like this should be dirmap.rdesc, not dirmap.wdesc.

> +			nor->dirmap.rdesc->info.op_tmpl = &op;
>  			ret = spi_mem_dirmap_read(nor->dirmap.rdesc,
>  						  op.addr.val, op.data.nbytes,
>  						  op.data.buf.in);
> +			nor->dirmap.rdesc->info.op_tmpl = tmp;
>  			if (ret < 0)
>  				return ret;
>  			op.data.nbytes = ret;
> @@ -447,10 +447,14 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>  	spi_nor_setup_op(nor, &op, nor->write_proto);
>  
>  	if (CONFIG_IS_ENABLED(SPI_DIRMAP) && nor->dirmap.wdesc) {
> -		memcpy(&nor->dirmap.wdesc->info.op_tmpl, &op,
> -		       sizeof(struct spi_mem_op));
> +		struct spi_mem_op *tmp;
> +
> +		/* temporary use another dirmap template */
> +		tmp = nor->dirmap.wdesc->info.op_tmpl;
> +		nor->dirmap.wdesc->info.op_tmpl = &op;
>  		op.data.nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
>  						      op.data.nbytes, op.data.buf.out);
> +		nor->dirmap.wdesc->info.op_tmpl = tmp;
>  	} else {
>  		ret = spi_mem_adjust_op_size(nor->spi, &op);
>  		if (ret)
[...]
