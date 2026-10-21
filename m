Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B84606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dd71bJ3l;
	dkim=pass (1024-bit key, unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256 header.s=selector1 header.b=sXRY1SQN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04B8A80D09;
	Wed, 21 Oct 2026 07:44:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6yIDbg3mmbeH; Wed, 21 Oct 2026 07:44:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 486B780D0B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792568671;
	b=JBF9e9MeshquXMfiEDyovVHKCR+oOlKBMYZ4Xh4R9CnIZIWb1w8+y5pDomxGlCn4gLYr
	 n8doWjWWv4ADlN6HvJz9HuUYB+mT4kPwoh3949syc4E28RlbXYXx0v3SBokqFXAzf7YOI
	 btki3Ei7Ia1Y8nF5JgrDLNkov2nhMXZcDDs13rQDMU+YpmoHKSwDNPXJcxJZWurOasHCE
	 3v884chM0uXDb979rIriPk4cfNMe2ESK7LzdgbUyPlO6E8xGxd+59rFS/3QLsehyVT7j8
	 bDNR8+3JUkUl4PoJGcSLp7kklES2tHtLzp7+SW866qAhiABWOyQTdbfgmXXzEzyQM5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792568671;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=avVi/2QcUpWyBvogXocjjrciYEEKySEOPzbKt/SGuj8=;
	b=cDVZj+9FMYDrWw3tVaGDSceKcXW/Qj5XyuzEw1Sf9Y/km/+v3Yxtx3q0dKKxTpGTvrTt
	 2Y2LWfCfxYg542Qex2hoiqeaMb9okJg2yGrmrrtg7VUJxuM5pif2wj1oN2LPj2h2beeNN
	 OQ4Z76TwzP81ZnbLNoSPMD5Qj991OHJvhmFnXh5dvYbSCuM1S1z+3ukhJ5OOPEMGfUMJg
	 AmnZuUEKvXP82bPENqrVvsKFfcsUWtcqFg8NaLsdqV6Ary2ZkZH3r1j3X1o04DtGtSUb2
	 EgVLgoT5/Q3vkTBgTBwiUkOq3k/n19OAj69ASSNVDbLh6+qKGZFpI7rm6do6/16mGGw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=emteria.com;
	dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256 header.s=selector1 header.b=sXRY1SQN;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792568671;
	bh=avVi/2QcUpWyBvogXocjjrciYEEKySEOPzbKt/SGuj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dd71bJ3l5furskovQzuyWOxYI2qXVKpbHbVlbiEkDFUodbTtxhBMkyEElUajV+4zV
	 oYZR4PPpAV8tAeMtfdKcYTj2rru9y0mrQ+gSrqQTJl/zVZHtABoZFDty+x2RyrKB5N
	 43hRWAMtJY4MQRPbM8NjnWybprFqOBIuNBqXG2PP0mIld5nv0OrSwfQlLFkerNcwIc
	 LL2DCQPs6IYOXqTtYPgy3xjKaWdgeS05vEGfKeFsxLdIspGrymb7sv/vSeY391ReUX
	 U+u1qsgyj7gpQIPfaMnsixkLehLXtijeECb2/tIzJBreaEYv4X5DMYI9yJOfR5c2rP
	 LPx7JAPjSd/sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 486B780D0B;
	Wed, 21 Oct 2026 07:44:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 913743A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 827E380D0B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8AL4DpgsMy3f for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 07:44:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3790180D09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792568668;
 b=enA/LcrDp8hfJss+/JPEZC4fw00pqM9JhdW90wtvT5qpwKAPOXTZ2urb+DxKtlWY4iNK
 1GKvvQqgphJfRTuN2lKn6bl8kY2KLFCFjnevBv3ZFXvz2M4CpIfLJoqCP6XSMaxGlFeE5
 F9YVHgcPbiDC5NtF7WkR5TGWrlz/vDTi+ox3gRki3d6T33F9I9PFxtm8BHcKrw8CRwM6T
 pOq6PfhRkwMyB/hoHDB94zGznYdvVWraFb4jHOcdKWxQHo8Q3ubyJd0nbtXmYk25ClciL
 PJ0XgXs3PKJirpHaCZ2dvGcbB7msrBUH3bh9oszw+MiSRg3tryQp55/TGWfdyhKcy0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792568668;
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
 bh=avVi/2QcUpWyBvogXocjjrciYEEKySEOPzbKt/SGuj8=;
 b=CVdMPbaLjWZ4M1BLVN4Rmz1HLa0w++AUUi0+DMPoi5ykyDaDgkTRk60grYrlfPIYP8ff
 KoV7ACuL23RSVMS0mjFgitw79bzbuEa13aTZKoS5O5Ifys843Old6G2zui8OtHDn+cmW8
 ll9q6jHVp54NR25RFiHCYChNvRTjHHye5DcJR3FmDMdzfkfwljTZ7otwtagCAjXgn5Q0E
 /1LXbwLy0R8Qea5kpMVhYzNKdLTx42uRL3f2mjV1Q13DRP3PwsN5zLbNB08RsYO2/p+eD
 tEmrFtOytMkXSzWiUvRrPOdkSSNb9kF0KOvP3pSE89GHtFJNmwbYB76F5OveOVxlOGw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=emteria.com;
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=sXRY1SQN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=sXRY1SQN
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3790180D09
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXfQP+TjZQEGJw/jwkSffBpvyLMrYfwyMF8PT1Gg/jyjRzJfORPCbv+5fsrcG35jPT8X4EBv4Y/WEZ2IgdjKeNiPeTM1lkD8uKrakr5C0avJ02YV2AHB5DD/zDBkiEnFq7GOuYda0wSfDT/gDeMLRfFVEusCR67neOj7LJHp/vHhw5cotrQpP+skm5lhZLDmx8DB4pa3NfJt0J0di8EMv/MgNQrk6mDPPpFBxY+bATtq0BXystpQXGCpo4XDEUMx9UZ8a3nJWQ/GZT+VNsjTyErJ2PP/ceAR/G3ysA5VRZkQ9Ggxu/mXdaDiQSCg9FYWxeIVvt8fG2Y7A5PhyXhRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avVi/2QcUpWyBvogXocjjrciYEEKySEOPzbKt/SGuj8=;
 b=A7Hpyz92H9q2XhiyQTC2e7WarZQO+fvmEzJIJa+eSbbUjXXwHjdAuyBwVZlD6teJXZ9AKydG6WjmTE0B+i8LJK7ik/c6KoCsMuywvMg5gTVQyXAUFx1PfMXfo1UsFxnxSuOUY6JcaKvJitORzW20tkNYSVyBPhdOcRgXFvPZS/A/hNwZrcK+DalP9yyPueA4Gddl45XC2/DZn7p6S31SKRtrPTTbfWnHk/DwPktNlqWNp6Ft8BDVszXMXViI7zfCaclba3ZTQ3h4zLK6rIgaliJYTcdIVxMtpLGeflwmLf8n4K3A1pKbvn0K6B+FleX8AxgGFxUGIRIdQbC6aIaLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avVi/2QcUpWyBvogXocjjrciYEEKySEOPzbKt/SGuj8=;
 b=sXRY1SQNjKEGnYI70DyTMOShu/OHLq40iqQrc7ngvYps2E3TbPnLSeTkmmYoJkwg80Mp+wNaJEe1/bl2XBe03ThBUZ/8glPvM907n+mXeODIyvaYgFMoDBl9L8NW3lpY034BInJIO1QOzl6aD80j3eZ7Be3KVqhQBdlqzyg/j+Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by VI0PR04MB10372.eurprd04.prod.outlook.com (2603:10a6:800:233::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 07:44:19 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 07:44:16 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: sjg@chromium.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@oss.qualcomm.com,
 glaroque@baylibre.com, trini@konsulko.com, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>
Subject: Re: [PATCH v3 3/3] avb: Take a storage interface in the AVB operations
Date: Wed, 21 Oct 2026 09:43:45 +0200
Message-ID: <20261021074345.1282758-1-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszTiRKgzf8kqS4dWxj5SWGp78j4eMiX5Q3dTKS4MT=CKx3A@mail.gmail.com>
References: <CAFLszTiRKgzf8kqS4dWxj5SWGp78j4eMiX5Q3dTKS4MT=CKx3A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|VI0PR04MB10372:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b78a05-ea02-41ac-6e58-08df2f471bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|10070799003|1800799024|376014|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cJsu6/fz5FAcnpqwR5bhLKo+3OIDUlscP2RfYJkhTwwKi5+BF/uOka/YRRVQgL1SfUljTblmtRo9Hg4hKvUtO01H5B/F/c84OpOFHp4ZCWisd68fpUA4dga4ykwqALeg24Y/g4RGoPPnKqHkke9Q7RSXf6UpHXym1wSHdrgikJDQbBP9uPNoGuJ3FopUsyv6ph6nQ56RNm7yjia3WWosnyvbwSEEDQqX0U5wRsVaVMR/xb+DpoPKjTOuNiJvgZLa+gClTa6z0es/ZrTUDB0JwVoiVqJEx0pXp6QsJRe9eBs4U98VzM5snnYn29MlNSDKyncFRdk8tvHJwm9GnoUR2UMVs2svPRFkyA+SPzscB77nXtaXNRxp44vangMNQr3lBcQTHkUFzXSKMmzq5uzft9d1Y/Qxq7pDU3AHriztMxFFCoWmOpcPj0RKKm+bnbknFNHxXiQMKaJyjgnhAluVnEBf93O45/09fRPPhCeUOgRhA1zY96oCMu6aI9W8i1aUAEt7FZsplxv71ltD5LBvn8inABuFTNNvEYvMBfaPcRfvnG4prM4QUCr6FUSHf8Ol6XyBxbjYGFDSqJFyN3yDYYEy0Dwi28gW9EeCwHc5xyReX85whO+F1hm42il8CcA8n/pkaPqhn1I2eNKCAadfTGW+Y7Rw1UvFG82O4OU4zTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(10070799003)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YHQdHBaLi1m8U7MZkgWUh89zO2s+UTqsN8kWxEI3gE/cQfI3CGhQjODFvHEQ?=
 =?us-ascii?Q?CHTW8ygZSrCb6u0TcaCb8VNFi6yOosd2ira4M4YwCMhulhDe7U1ni2vHZvoA?=
 =?us-ascii?Q?XSNW3V+B3MHjbKcbgfe8Mo/uu4gGuAGW02Oned724zzrD/H1W2XMM3ByHxaE?=
 =?us-ascii?Q?R+YfUsyDwwNaVfHuihuNnb/o0ke0lKtis4oVyA3/pwoJcAJ6dJxUfqJ2+xa5?=
 =?us-ascii?Q?Tdg2Pt7hhS/R/eAfvSUMA0419Kjb018Dpb+hAuD2lH4TOdMXy4mJ3sOTrt89?=
 =?us-ascii?Q?+c3cHLAX+HPIpjnGQ1kstHDg7qxS8j1fOOMoi4QDve3Xc3R5XpQNBEg4OyFc?=
 =?us-ascii?Q?uVnTzhMKd671DYhWJtWlHHAdjo73eFLUNfzh645pSjWkglqIuvBG4b00u7iV?=
 =?us-ascii?Q?wjNYdaZxdCuKywWTtVj+am83fRIzsh1BmMBLU1F9k7pm5uX3zfv4yKCSPDWw?=
 =?us-ascii?Q?ExqZRV19ABQvP+RC4pIo5yl5XbrXpSxeegv95c/3HqPhRv9LoF1l2OxN000e?=
 =?us-ascii?Q?di00vCsdytZaY+DObZI9RWERfRibh68NlYD6beVNHP6K50ZUXxuswIQxpap+?=
 =?us-ascii?Q?jZssp7rRtDhFzFtdPlWlAd0ACrIaDjiyVCVB99wPq4O5UdayKazrmu47KA3T?=
 =?us-ascii?Q?acRS8Iwkc8YM4V5XZjop50LnnZTvyCewfayOv8osloygpCQEeAEbfFTHvHxb?=
 =?us-ascii?Q?PBzruHeVa/43rgDKKf98qxYnZa0XuT/jgGeG+CUJlR+KD6OCJ1YntpunVGkz?=
 =?us-ascii?Q?LwktHPfHOu8sVOzLRTszhMF6XgOJnqH6lNbpUe4SmCkIv4TkNnNSL/Owvfc6?=
 =?us-ascii?Q?o6SDLp2WrzwmRXMRM99Uspk0FptmeDRHbUO1CZf8ETOfQV+LFdcaPRxW3Mv5?=
 =?us-ascii?Q?rlYii3Fzb7k0B4wl/JwjH/LFaBQQOYPfrLJxPz/w2sDwZOS5yC55O3wmLIl3?=
 =?us-ascii?Q?02oWfFqteqadFSDBAVagKUyCL3lNbW/KG6r1uK/uQu/BM9o+8fhMq2aroVYx?=
 =?us-ascii?Q?E67r2jUkKbohHAcfyBCtvG5/4Aldd0VBnrk0jBKmPVmuH/azkYwdUlOEPv8B?=
 =?us-ascii?Q?9ItKu78UUAbg9Zo9FaNKTPTc76detKgcVbB2Sm3aWcRmA9K+zvZl1ecK5B6t?=
 =?us-ascii?Q?Mzj7omg5PT7rJf95v9ar/S3L7snTRj0H9UUCkJfHuEKolXCAFO+BLNU4Y2ip?=
 =?us-ascii?Q?ga6S1Di1EblCZU0sZ45xEQeLOMZbxSiwa2xlP66wXIuyJJyqGginvvxpuwHU?=
 =?us-ascii?Q?sOeBf7BjtJRJQzv+2dwuhdX7iRredZYi1RQvfym0dvC53Ize1JQQ/9EY7qfP?=
 =?us-ascii?Q?H2TcOAhk+RGPM916xmF7otvp2T8H3sd+ZSGD64Zk8Yr73zMmhTlrwXZPkSNN?=
 =?us-ascii?Q?x653MdxX8bcKrIt9kxo4TzjHPmiK08kCHezx27NaGD8+bdCzqV/qFrXioPnf?=
 =?us-ascii?Q?vNA/Ddqg4lEruno58OJaeUmdrmH7xqrYcL4HjsoU1fLndIG+cTYsafTyjKA3?=
 =?us-ascii?Q?NzJcTHwTxtzuG0d5zn3i6TrkZ21MOk6W4sDGvRGBcVrnG99Lisv2FK0eS5/q?=
 =?us-ascii?Q?nzUtT8F8DSAstyBowJDtZjhuq4mpjSenbKcoiCMvBT0NbADOlMOA8i9PcanC?=
 =?us-ascii?Q?kVu0bjHYgh3w2Z53nNrb1zO9yhRIHQ9xzB7fIRo+YrnJAwltuyzesjIllIGZ?=
 =?us-ascii?Q?DXpGF0trpcJObkpicJic9VceU/NkY6OEsXzp8rtVz3dqYBiBREuk0xhf3n91?=
 =?us-ascii?Q?2bikPv/USsV21dtZTj+63yOEact+S5vXqgw1Tdum7lRfoktm7zMe1NSOvAgN?=
X-MS-Exchange-AntiSpam-MessageData-1: 34ot2IndtAZoqQ==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b78a05-ea02-41ac-6e58-08df2f471bd6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 07:44:16.7956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIWLUff8g5hxwzEc0//qjTzyJtnbnQtehTz2fMf+pwKy7RIzkMb2oGjvt3QvjQG8N6/79AuHhqWbZWUmvdIMUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10372
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

Thanks for the review.

> As written, a board maintainer can't act on this.

Igor's "optee: do not announce RPMB from within a supplicant RPC" should
fix this. It is still at v3 on the list, so there is no commit to point
at yet. I would like to send a follow-up once it lands, naming it and
adding the "mmc dev" hint you suggest.

> A follow-up could guard the mmc path with IS_ENABLED(CONFIG_MMC) and
> drop the dependency.

Good point, and happy to take that on too: avb_init_mmc() calls
find_mmc_device() unconditionally, so it needs the guards plus a broader
build check.

With both heading for follow-ups I would rather not respin, if that sounds
reasonable. The series has Reviewed-by throughout and Igor is rebasing on
top, so a v4 would mostly cost him time. Mattijs, if you are happy with
that, v3 should be ready to go and I can provide a follow-up afterwards.

(It did reach patchwork as 2322465, not sure why it didn't show up in
the first place)

Thanks,
Jan
