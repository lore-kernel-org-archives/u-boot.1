Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F16C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8355C40A74;
	Thu,  3 Sep 2026 22:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-psKDxQ3zeY; Thu,  3 Sep 2026 22:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0B4A140B87
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788473616;
	b=PxXhty+ruFOs5KKLp2UZb/GlGDKgJNFEQe1KvYGvVH2Z+KbWRG+0S3hSGQT0uAIf1aOj
	 8rp5gRiNsunCPwZqs+Fd2KQNHrr4+gremRRqIv0IjbFZkjCiFjYni5bFeaUFcHWjG+yRp
	 /IQ6RRibA6GwY5z70+FbWlzHy5DAyFHktAMczmh1+NaYMf4crcPe84nWboFwEwg6DIBwk
	 OT9gEZzFMmsCqqNsNK77MDpx+TGdWQQF0NaLTm7H5r6r0lL93UAn39Q8Zds2H+CrZv1N/
	 BFq4VeAnXOF22Ne3HNifN/owYpRW41j91RRdpf4OxjVc1LhuJAMSbbo7s3YeZoFUR8Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473616;
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
	bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
	b=lI16jC5EVHq/Gi73fJnZfCC6AlhMo/N1Rxf5jqr0wVrxlyzDg2NBtyCvfX25CKevt7JM
	 O+4Ta2NoANwjCv9H+pvtQMKGGxPFXer098B7txKZyETEXJCqOOJOPXaviQm0ZExNDOgSj
	 mMLxqeAwh1p3EcjxeaMmKRuvJfct/4+rrApsRHHfnSeQ5Lku04M70Lmo5eCEP9bBzDy6W
	 Q+DFYTuz2n/EFLRaax6eIa8HyVidc9xOYd1WHSmdNv3BZViyGMOCVmIXqS777QOcG+FBj
	 yNpPTHf6/Cw7uKvVNlvyv0M1QYVi/sE29c44/OarlcT3oHE6j+hAoDIYcAOOuRwobvw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473616;
	bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lwTw2UQXecM8K/zyN6V8AexDJGgMlsNe4Y4CKzejL8oohtToAnk6BMr5vpoBMKxbU
	 3/XBQuH7FiAbgRMqw5ZTiO9OvRyh/uDRz8vGWFsF19//U9PqgWqm9gCnwlV1sQWwIj
	 m3uvxbBpWUJVLkw6QX3A17nUkzEDcebyPZfsgjOOx82bDb91DUIt/Q8CbzQoA8mW1k
	 sCEbRc3ijfHfq7MjR8iKZ7+QsgaYEgmxtO1hDHGGfo9sczYZ90Os9g5vgIizTd7nnu
	 KPz7dwOct1d/fqHsttVtgC4NE5sO0FBsH92KzEOyBWJ4FVmqPLpr9Ly2Z4opEO4g5i
	 DGMNfxMUIe/Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B4A140B87;
	Thu,  3 Sep 2026 22:13:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 25C1D498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 163AD40029
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q3eQCfl_GaF3 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:22:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5FA6340329
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788470550;
 b=X4KlMYtw+6uQueaovzI9jkoMZQFF36OuqVEyk6ZsCnXqezNA05vU5PxKwYXE6tZkOny/
 LUsEwEKWKBKaUtUnAnDCkzW7v10oheqsbyI0g1RqUSBDXIR777Nw8jASPdXg2cDQTSbwq
 pLVjgAyZLddfW9rMOw/Xm2hdUIM7fYlEYUSitsHmcr78mT80cnGi8/mFkWs8j79tdkgn8
 vujdECvjtmoZea3gvq8MMgxx1XCi8+Cm4/TQ2okVyMJEO1KgnaZW9AG9W/wTOFCqlP7o0
 PmqOmKnxDF5hxSqBoQW5MIZ3HjvTuhIFOrKGusxAhalgZVV87xfWntD7vnosyJcrdng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788470550;
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
 bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
 b=JhxUn3rTuAVUwJ69f/obQo46/SiaLUyKjTbBWtlRIxE2MhV1Vmue/lW669040aiTFcLg
 X/bs3sS9LxJ5wiXiD+MuMSXp2creqbifeT/tEGGwG+M/hgFhvGWq27jBepknI/h1u1HGF
 32345L/BwdUGnPTNjIYViZVuwp2UvOgz1bRZZTIb2RMbx1IE/z9eLB7rL3b6g1ssqhdD5
 wzYXZ50vhzc+qY9LWPiiyiqQiRRXnaNMK0ypQzYqOWe1TvKuubPjYSwLjKZhPFIbyUESs
 8mgGhgf29zYkBMnyfKaqQWIkW9MU86FopPvTzSkWe7kBJBKkCcDSnTAVntsRi78w6eA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=mFBjqGgg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=mFBjqGgg
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FA6340329
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McX+DVXicRBT8e4WYLF3nTXmmNVVguPLZcQFLVqJ/UDpsf7JzXOcRdwtbjabL3aNS0PuhqihYHQ2AkcrfH9A2m0c/sof4kd33WKTYrTyg53NrBMFCFwZpxCux7mNPfBXvx/gcPg/lN9V8ECT1SskAnQyvMlX816xZXV3+lSiK2v2LxGLOibFMGVqmargiMYA9WzEEXXDTes42hPct74ZNhhrRHlKHoP3zwIwfEmCheDU7W0vGfl6WS4P/reuM8rBAbCNsM9gHpkTnoHc1y54BkKRUEVbK0VDAazrjl+7U1Ixnl/KaNa6lOI7HYmzU4mbLaJhpk3cMA5kD3Xwjc8LTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
 b=Z0rGXMitA0C9cBIZAhFUu3edp9vQJpJA5SKFskwv3xA4rT6veZJK/HrQ9Cj4goGUjoDweNqrWkpJPEZZkOOQYLkq7KazYFB9FPXkM+Xg7drLQAHprm6R9Wy20HiOxSZ1U921oeQ/jXh8SxoqawYsZmUvOz4rKIfvurcp3FYkhxyH2toBGy0HaEtBl0JRduFJ9cFZgfHcZarH4H4QHnJ00kUUdr6bzOF37FlTuVgpiNITe13Fdz2CfUKcLrlu+fl6sHwzUsZSybJQBdCB634a0e/LOdyiUsvJeJd3TCYtw0oLc7w8IqyE/zBVn/3Tlpe4gd4WhAR0b+OXxkIQVA3F9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHOYGVZ4TcSrafpCA7nGexbHa9DeDRSlI77mxyzA4Ng=;
 b=mFBjqGggFf9GHWCSGEpA87Tp90Wad3RfTzDccPMsxZZzldEkAivSmfD4m9Q8vcdIg3zxRf7oQFD4o7WNqGagTZ4uuL4bwPdKpBmsbZu8ciMv183hm9V5hqOMYPiIdME5A8XoJYfGFYp8+t3HIBEaveBZo21w9qE0xM49MxJVJLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 21:22:19 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 21:22:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 2/4] optee_ta_avb.h: add TA_AVB_CMD_READ_PERSIST_VALUE2
 define
Date: Thu,  3 Sep 2026 23:22:13 +0200
Message-ID: <20260903212215.2331118-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903212215.2331118-1-ravi@prevas.dk>
References: <20260903212215.2331118-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0002.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1365f4f6-56d0-425d-d8b2-08df0a016fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|3023799007|10067099003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: mQ8jPnLxY4+t/uz2dasW4UojCzlkGDZd9qsSYWynnQf9IR+e2toMXyg40zALI/xV0nrycA/NNs/p3nFTd5mSW+YwteKcONxQGLmDNxGrxEa7Ly1LmVql32RKSwjtzyyqOSizBT/TVkAVN1GlA3xh07iFuVu+Wr0f7egPf7hc+T0754gGn3ZdDDuTjHH1eOVwdG80CSiaxWeMsVtJKokHKPPlz0VEaJXUr1OvSolNVg2zq3iU9hitxIs+1YqLPs2vMKlG5WJ3lxaMff5/UyCkyD65wQhnyPRZt1SJAKX0B+9/pYh0fJwfrpppG8QXSM1V3UYjSEYdy2J+qpZteV/Qw5wZVJVykMC2rzrD4dPoAa4aTNEvpNpz12CuFVC7M0FG/c+12U/lmEnhSngmFm+gntE+Wi9n/Sxhy4BELxGoN5xo99zGckcBMOergMTypg/VoI2aQB3zUyXU3qBhl439J2lEH4Nl4rIWbIcLtCUWxsXs5aqjp572/MICXhIe2OELvnj5TD5mkoxisCWqzzrqDHTY/+sxP0Ugje5ov+vvrUpQLbJvLZHY31oeG/O3WHQlbK9YkxQUmWiwMkX2Vg++GbBrjGzk66is4eO2qy6J2x442LLQuda+11UijPEeyvjrUcvA+Ud8STVSgtN2xzOaMt9idbyaa/Hio4U57/sIpO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3023799007)(10067099003)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OggaU6WIsdHWlHn8c90FLMVnHFi3GbK1Cz6rtb5vkospPaI8+vY1L9uCyvjR?=
 =?us-ascii?Q?qNcZu9CkZmUv0LZaOZ9ThxMYJHys4WVRKf53ScVpddZ9wsei9P2iYrkAeojw?=
 =?us-ascii?Q?e70lGJOrlOOW0WkSCWguxckkEE5j7k+KYZ5XqCyvGmjBATATbAMK0pPenyZc?=
 =?us-ascii?Q?zdllP3MTh1JAcpQItpkis/rKJBnlZWGuuIOhKUzSp1TMADINV+gpJJk0ljHz?=
 =?us-ascii?Q?C4tNCAtDibfhAKVyMISYbR+CFJpFlk03fwp5MoPIN5dRRioiXkevF1DfHPRQ?=
 =?us-ascii?Q?L+GFbpznpfqdLIGStAtDiv2IvZcPihQgBzJz552sbMKlm+5oGPYgXVTlasow?=
 =?us-ascii?Q?EwxYMwo8M9ZHH+roscJmc6/fkBkp4AZ9d1Mo5p718HW3bMis4GMAplgDhqJf?=
 =?us-ascii?Q?ywGqbS/l0U4B5zsoCc4l4IMr4eltGNd7OEldt7kk4rXpiCdX6o6HCQ4GOIH4?=
 =?us-ascii?Q?e7xX6XguwcXAKC/f6DJrKsfnChJXqGZeyIvSJwnGS84f4P+q8lKcTNEmfhRy?=
 =?us-ascii?Q?LQCIHTZrHKe48NW3Ww6FYUPKGfY+QVMwMbvNS5FHIzBCqn3EpxngorktDlTr?=
 =?us-ascii?Q?0QxwNoGfXo4r1dPMcmBLkuCOsIkp12fmJf8SdVwH23v5qsqd3rZ5dob+Zxab?=
 =?us-ascii?Q?araQ1R3DPnrM7Set3OGzXb3iR2LIF9kzQL1hGevsWiHXuFVVAElOoEszmx/w?=
 =?us-ascii?Q?qpGORsD4/sFdPV5WYVidk72Jf/UqZUfmLymt7JJQB2g0ExphoOFGNR95QsT+?=
 =?us-ascii?Q?NSLP2uIfe6UcNcSkz0t7Xe5Mu6P3aFHKyLGxvt4UcytnESeiKj9LySUV3mgD?=
 =?us-ascii?Q?aT/+rSVPhFKA5GjG89cJFsf6l+FV2OOHJo8ofaD/LK6WdQOHcFGV75NEBR0i?=
 =?us-ascii?Q?yQtsQYkMVhHII5RC/zPqU4yVafy5yhfHvKdyU09xOueBH82LXl/iVmuORwzO?=
 =?us-ascii?Q?WKvjgrejfFdGpNtjiKgrLA4OUWv3N4cHZRSbPVzd7tiTuf7IeypbKfQSvFZm?=
 =?us-ascii?Q?418tcP4RsJiTfdWRfxqeFn/MsLyzOlNu/iLIBIBhL0nGK/zWRtJ5HeyRLpfC?=
 =?us-ascii?Q?uqWOSN9j1M2BlA0H7lYI+fFaQgjpZ9mbcBG4GWlRoN9TmMCK79+mXXtkPrvd?=
 =?us-ascii?Q?Y0HfgcILhMskRocPHCqBzo5JLivVIm5BUNNp6/DICNWKM4dyskhCOAKnSoxC?=
 =?us-ascii?Q?Oi0/hla2bu9aQXWo7hO93cMqNkAW3ZoyDNWpXSH+WVTjP9/xenL1T1ysWOls?=
 =?us-ascii?Q?c3nuBurtZ4XZ9clWjk0iqldftmT0Ci2TLF0BtHeb8TXj+U+WvoGscMGxozpX?=
 =?us-ascii?Q?t4rlGVfvrgpi9O3NbKvDvE3nJc745AnCZyferumhPFuaB1AeK1kYkX/K3kEZ?=
 =?us-ascii?Q?a0zdMLWLYr3vRt3k9ubTs2yuiGV9Be7HCNxFBqunUzg/A/Mp70zg7LTqPKXT?=
 =?us-ascii?Q?YuK8cYFtsDuUUQa0StBrf1wLZuc8gXi+u1wP+IlFSNGYmMOWg3U7Xk6Jys9W?=
 =?us-ascii?Q?EygGtYzIXMrIfZZOW79a+noIua5/DFhoS6gNG7o/GwHUJVkGMGXUlsqoT7kZ?=
 =?us-ascii?Q?mvcYtNzqJOeQxjENqFgUJQgOG+KUt89f0vJV+ZvYF6tIPq9fGUI6y16Tn0Nc?=
 =?us-ascii?Q?tzIKIVLd0MAe5BciyoH2/j6inMAsM49K6rdhKTmUk6hmNisa8GLNdSkBLkWJ?=
 =?us-ascii?Q?9fBBSL0haLwZcg9f4uEWhBuabkFp5ZGbJh1Q6WMftApxVT2U4H9aUWN0qsXW?=
 =?us-ascii?Q?FxJutwhBU/zRWaLmPXYWPti+tIyTVOE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1365f4f6-56d0-425d-d8b2-08df0a016fd1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:22:19.8193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsNnnq/262/nngxiMJLw6loBNz+V0XuDiL+pNx3hthOiUKD8nPSlqywa6ORTzIZknmsKxklJ3Qt0DHtfKDsJfxXvYccTq/4mQuWjSPJ+sqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8445
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:19 +0000
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

Add the new TA_AVB_CMD_READ_PERSIST_VALUE2 definition, and synchronize
the comment for the existing TA_AVB_CMD_READ_PERSIST_VALUE with
optee-os' ta/avb/include/ta_avb.h.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/tee/optee_ta_avb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/tee/optee_ta_avb.h b/include/tee/optee_ta_avb.h
index 949875a64cb..d8db6d257bc 100644
--- a/include/tee/optee_ta_avb.h
+++ b/include/tee/optee_ta_avb.h
@@ -47,6 +47,7 @@
 
 /*
  * Reads a persistent value corresponding to the given name.
+ * Only reads as much of the value as will fit in the provided buffer.
  *
  * in	params[0].u.memref:	persistent value name
  * out	params[1].u.memref:	read persistent value buffer
@@ -61,4 +62,15 @@
  */
 #define TA_AVB_CMD_WRITE_PERSIST_VALUE	5
 
+/*
+ * Reads a persistent value corresponding to the given name.
+ * If the provided buffer is smaller than the value, returns
+ * TEE_ERROR_SHORT_BUFFER and sets the output buffer size to the true
+ * size of the value.
+ *
+ * in	params[0].memref:	persistent value name
+ * out	params[1].memref:	read persistent value buffer
+ */
+#define TA_AVB_CMD_READ_PERSIST_VALUE2	6
+
 #endif /* __TA_AVB_H */
-- 
2.55.0

