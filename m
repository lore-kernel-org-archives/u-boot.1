Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE14C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 13:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72BDD60DC9;
	Fri, 18 Sep 2026 13:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tqf5VujaPQww; Fri, 18 Sep 2026 13:50:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C74F360DE5
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789739411;
	b=hOaeaiJGqhJz64moRG3QwuLV36+XFkPGQufKdCcFqG8GJ+nJwhkrPWjXyVaNfqgbeC8U
	 dgES5yNyDd0n0QyrH4e3qYMSUKPwg0g9hjrZhsiqjfDks4WNdbOnlqojaCQ9QEnjt2iCC
	 Ttl8KYjA1Vu9fXV8YM3jjdjKdcQDhPZqgRbVQohJCXgR50GFI94IcgCANbN1fSkd0npxj
	 YMXyZ9i6ggFwGxTmJ9trerHJBQEnlEr+Pw2tNYWanXnuSaMR8Hz4PLjgd0Yin1tNn0W/p
	 f4RZZTp07qc6HZSe52H7oC/BUFNf17M8JxYDgbLSvuHZYFBAine1mMBQ+bGzyNuE85g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789739411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=rrRFtlBPIYhEaYqDhG0iIlibv3lGPmmXFP1DPxlNLjo=;
	b=piv/EajGomJl30M9Dm/Fawq41JN4eVoXdD1tWa6l87PnBz88Abp5MpG8WjHw4IFW6u4d
	 J7E7weQHSSuQJnQovcqbuiFHi3eb8AMdwTVOIMeY+1Fpafs2bgXUA6991W5O9do1zPC0c
	 /MXb6f/j/7ZMlBHwrg80tQCCvcadCV2xJV5SKtNAQYch5oBdi/NIZn0aknhOBzFq/wPIU
	 LgX0Gl31HQUjYpabBmNlKc7PI2CuO34F3BzmeyTWgfTmWVzUXgrLDrf4c7NCLW1LruKSk
	 oTKDgWJt/IQytKPiZRucZyWt9/9ft9TAusoWuuh/z+sUe8/PyCelGqpyPFuSbwmb7aA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789739411;
	bh=rrRFtlBPIYhEaYqDhG0iIlibv3lGPmmXFP1DPxlNLjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BmC2uf+Q1jD/MHzbTwXvZ2wz5rnODUErmUtPUYhO0681Jk8MnmSpkf1IlYVGHOXC0
	 kVM6tGDBiYZVCVo5+U6E5+ALQz/onXIn5GEKoOCYpwQUoA08cK+0IRKvd7tVim8evG
	 Cc5CWL0vXqReQAHzvxuuRWztMQ05oZzzlOb3UE86UlRVMGHuOL0f2JyOUEE0vKKPPB
	 BGFd7JZ1eU6jeZ24v8LhNKtilMoGEezkXwgQ2iEGF4qBI0Qqf7JH3BfYh2GZQzsY8s
	 Dxxueowr0iDP4FYyj3bba/SKd2KtwLtHFfRA/yoxlMM5kurXF8dtDtO6kre9f9rwCF
	 acHO/fqFe9ftQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C74F360DE5;
	Fri, 18 Sep 2026 13:50:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 36F4929B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BD56812A5
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dfgqExnMlY3 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 13:50:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 418C68125F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789739409;
 b=cD55Qga3hvUfZjQyI4NKW4JYorLmT8akQHhRX53qBaYQa+EQEt7HtYGcOOfKHox9busx
 exLdYkbSis9K7NEkF76VNNmw70hHiLrxaf/Fl9vPQ8bZ90pYzxBhXmnl/7uuxaSUvYM/H
 VeBIyvdZ2VnAXznggNBbnDv979qXgfdQMKe6PnkiSRK9650FaNrAPSzZllFUR92lp9MbD
 F96H2WQryOvYURG7ZDo60EA9eaijoOMB4iPcUkyBXBKFwLGekhrI7LHFZHgK0RanYujz1
 /k7P5sIXigOTZFeBig2Pmk5QKxYXNSR1ZP9xtGzlLpS7CEagGGKAwfRuY2cCbfvBbxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789739409;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 bh=rrRFtlBPIYhEaYqDhG0iIlibv3lGPmmXFP1DPxlNLjo=;
 b=SQ5Cgddx4hDJ2rupj+5vAe/5XS5SYQ1zonIu9QJUBjHgzeIC+BajWIR5f43bKBTfywF1
 wyD6CfZEcVFbSPht3P45+Szt1AxPhoayJ4mC3d7/NI8j/kV9Km83hKJxj0H7G8Rr98LQm
 OFwOxvP0CkSd49iKGM48WobQZF7cx0rcyFvdctQnQ2GhW5FlUdrpZGQD7jsLoUNY+1Jl2
 f2SKW3eRqqSvsLGGSAv+qN45QJfbqk9LYlqm7iq6p5tiUaE9f9myD/olCd/KMsiLKjPdP
 UCU6Hp68NTODCfLkFBl3aSQg4+enitlJxEuxBh6Be13nvRwlxYJqsfRVlYzkyjCxQCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ayCcbPaQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ayCcbPaQ
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 418C68125F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvr6kczHU0GLOMjTJhAHB52am52cs7LGyBoqzZo20Jl5YqcC3UN9gUVjTUEVHW9ZJ/lIZ9U/pyCNvb4RUo9P0lVj99HdLWBT61tI+GqqHY3PGSUNhTDrTm4gDbnBwH6uqMce/DEvCuxrdRZ+BdMiepHMJgcWqCNzyPbUPBu4z2yl9+mihBqxZ+2GBtZodfpAJkDjxrg30lP475CRZ1Dpdk9yFX/98rD52OOeKpRyLB/mOuxREn85K0ciuSMMU3DYvKV4CeKTIK0Zkd5KhqsMILiYYMz0NU/7d1sCVejeLKXM3y2KKoZiuEVEiOJJBCVhw9DXdd5/l2C7qEUvTaox4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrRFtlBPIYhEaYqDhG0iIlibv3lGPmmXFP1DPxlNLjo=;
 b=yZrKUuc4X2cS4AcE3J8E9mw2DnvO0pzUKmOmiRVkuPprOTsoOottaR+dUBwCuUR1I1jMHYvEyn89VxAlOdDyZikpD9KADJuk3aeIImKAnZZ6h6K6SGQ5XC0Hvggs0xpfBbM389B2O9vBxEKG9cQ+egDtKOQoazcw23sLemND+00xkDV8+MdWgRASG3bP9gHD1P2ktu1PlchBf+l13LvLlv1c6NENGvW7juB8xhQD5JF0yOMmWJ81IWNC8Rzuv/v9fZ68fbVag5E98twgDF1wH/9ryOcEwZ5lXO9WWUnjlSS0pLSaBBNGy/oyhZl6a3krvAk6Qvp/9CA4mp5VP8GTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrRFtlBPIYhEaYqDhG0iIlibv3lGPmmXFP1DPxlNLjo=;
 b=ayCcbPaQcogbeo/2mvZa5KHckc1BZ5XIj1Bpwzdb/XfN6loSDeboHpGUim3oemn2X5yxNgW+wh2zBscP8xm+r80rJ6V2iUPii5OdCHU+CJAmdPQCOvq4eF7lr38D3uJOvZXEqri37xjT3ACQ3jiH3nqjzFvifgExLi8w5GR3jnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MI3PR04MB12439.eurprd04.prod.outlook.com (2603:10a6:290:74::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:50:02 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:50:02 +0000
Message-ID: <180d8edd-2743-47ad-9904-866d76bdceef@cherry.de>
Date: Fri, 18 Sep 2026 15:50:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: rockusb: terminate full-speed descriptors
To: stevenjoezhang@gmail.com, Simon Glass <sjg@chromium.org>,
 Eddie Cai <eddie.cai.linux@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0188.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::45) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MI3PR04MB12439:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6423f8-0c28-4bb3-8776-08df158bbcac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|3023799007|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZCDf5nEXhXHAXlxuG7eHNaJ9ZZzmvTqhE8Xq5NXDF08RuCADezeiiqCGiqCbjWjb1iPH7NYYqernIY69WzseFQCD1uVVwULkjKtbtPCDlziana4f3qMrVs4iMymQZ56OglhS+jsITtGf4MsC44xbeWpOsgsWqV8Ek331LqqcVnJNtVCvMHUxfW/6rKa+bVl5n4/6RwLrWBvsofFK+grn3gNxlb1YdYC1WuQMi2NrTK+BaDU0Fzu5DuqgAn0DdFHxoPumWejA1kA9OrfpHdO7K0POK2ytuuN101bTVMU5m0dNCeOoxeJ8R7saFrGwD6PX0wBIkPZcn4A8ZfG3LtSnj4WREMdsI8lOIZUXrt0iV8+7FapxDvFmuSSZiWFbBhSK4TPflbKWDVLxjic7TdF7Rxmxi4LlxXIHLj12vloe16YTQr/Nyg3JcHQgGFSfE7+FcxYckFauDcRTGr5RDJX5lmfjlg2BsQ6FvbQrZF4ZsaxWGSCjWVRFnuAmnomPXxZKc6S3QWA65RkCjAHGh3UlMx+R6OKTpr7VN3Ch6nFOzmT3k1LmzYYxgvFa70vgxhNCEf1LtCnEP11NXmBVCBwjC5vyBBf49YXLP6UFaL+Kb4G0IDatWFmyCD93TXNVKdeSXHV6O24+AR9YBsyw3l8hrnt/dFK1YfFIcg+ITnB/2M8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1piOWk0V1VMSjFUWEFnTDhYcyt6REtEKzcvQis4b0loOEd6Y3I3SWlaVVhK?=
 =?utf-8?B?dE1FQjZSS0tZVzUvUkhPVmRQRCsxY05FSXJPS05kbGJzbjJJNUN5SkplQThE?=
 =?utf-8?B?MlMxQnVJTjd3K2poN2JXMXY5ZXQyNlFIWWFWWmdVZ0JYMTV3SmU3MzNuTHhw?=
 =?utf-8?B?Y20vR0JqL1ZoT0pUSFNTRW5nRTI0Qk50RlJRcXZBMm1MZG14Z0tDOFpvNjgv?=
 =?utf-8?B?S3F2bzdLN2sxcktTRGwyZ282WEZkNFJjTUZaVlFEYUVVd08yWTlRYTAzR2Fs?=
 =?utf-8?B?N2JPS1pvVDJLZFUyKzcreitMb0xVUng0ZUtmazVjSGt4MHN6UlpkTlVwdk9X?=
 =?utf-8?B?Ym9KbDNGbWY1bklHbUpSc2JrZ005ZE9PWU1iTWpSWlhIa0lUa2RpL0Nxc3ZW?=
 =?utf-8?B?SGd0NjZ4dmkvRm9xR3NPZUJrTCtsZFFPNyt5SGo5bFlyMVBVc3E1VG9lZExG?=
 =?utf-8?B?TXkwS3ZhQzh2VEo0VU9MalRTekk1MWFJWE80WExXWHhRazV4dktRRisrN09v?=
 =?utf-8?B?eTZqbU1HUVhqMDR1U1N2c0xRdnhlVGkxZTVNZi9wZlJJZldvSnZqMDBuZ1I5?=
 =?utf-8?B?UHUvaENyZlBoMnVKTE8vRzRWdGU5aXl4VVRiTUxzYUUybXVmYnR4MkwyOHVO?=
 =?utf-8?B?SEtKNkVhUjZCZlVMb1RLRHVIZWlSKy9ZK281NkJsL1JKcjNzQWFuUzlsY243?=
 =?utf-8?B?OEQ4eVEwTjN0MUxkK2FUbFlkcm5wbzgyWVBSVDRuUkRvT2dsVWY2T3RkeFdL?=
 =?utf-8?B?aHU1UEFrUFJOeFZ4bnNzWWNocXlMa1orbytpRDZCNWJZOXhGMk5hMEZlbUgr?=
 =?utf-8?B?WDg0UHdPK0d6REFnaXc2STI2ZERFM3ZndHpyQ2R1SVRJclZuWEtSV1NyY0I1?=
 =?utf-8?B?ZmpzZWVqSFFyWEhoYzRlL1Zsb0M2NWY2NXJ0YnFnNFdMd2NjbGF2YTBBQnN6?=
 =?utf-8?B?eHF2RXNwV2h6d1pNZGh6bWxUb2V2VEdoZUx6Q1lBaEFjc2hOOTgyWkFDNjlS?=
 =?utf-8?B?ODJ4a1RFY1dXbDJUZmlmZEdlck5IR2ZlWXRkZEhGL3JsVndDRXIxZzc2R01Q?=
 =?utf-8?B?OERLVlRuVy9naWVoeXFjaEduYkljRFAwWFhqbTdMcEI0MW95cUY0STFYVDkw?=
 =?utf-8?B?LzJYMUJxOEZDcU1jOWtjN3BrN21jbFl5Rzd3QmNJS3hQTDhpalNRVFM3VUdP?=
 =?utf-8?B?clZaelJONnhVNS9RMThxZmZUTjFpRDBmamhwL29tdlJwVXZGRStzdVFxN0dB?=
 =?utf-8?B?MW1Qd0hEd0FGcnNEQ2I4cHlpUmlTL2Fla1B5ZUpYSFNVUjMwRVo1M1V1dkFs?=
 =?utf-8?B?UlRRUmRrdnJIMzEwSWtoMnpBNzFaOGlwRTNPYzI1WmRxTXJUb2haTDlTMUk0?=
 =?utf-8?B?SVA3SUg5RSs5QnBTVk1oNkdJQ2ZWQ3RRZTJuWTdXeW5Zd2xPdmpjZWs2L29E?=
 =?utf-8?B?cnhoaHI0NnNQTlNBdENUR2xNUW1mLzdBZGFOQnJDbldOOGh1MFJlK2tPU2Nj?=
 =?utf-8?B?aTA5OE1PYkRDTXA3UW1FOW9Yb1N1OU8xd1JuNmlxODdFVkpxNW16SWZGZjlI?=
 =?utf-8?B?eHh0Z0tXK0JyUWF5L245M01SaGVxdFlsci9aT1lsTDBlSWdRTWtUTEJTQStP?=
 =?utf-8?B?YWRSZ2JJU0pDNmo1RGZKeTR1TTQzcHl1b0FKOTl2U0F2Q0JkK1ZLTkZ4b3Q0?=
 =?utf-8?B?VWhhMTdxakgwaE5tQTFDdHBSMUxWeHdnNDR0bTZtM291YmJxbzAwcUthT3ZU?=
 =?utf-8?B?aUd4S3ZuZlpiZ1JyQURsZHM0aEZ1MjRDdTV2SWVydmN3WVprR01IcDIxdFgz?=
 =?utf-8?B?Z2FIZG8vR05SazUrcytPdDZiREZ0RDdvOUVLWXRDM3BBd01GdEVKaUdKWmxn?=
 =?utf-8?B?S1lySXBXTllzRHFSQ2U2bVBBZlFXL2labWdEaVNhckdCYldFZGtURGRRM2c3?=
 =?utf-8?B?VHp2dWhiMXQzR01BTE12VUoxUmZQdHl1N2MxZEd6TXJXaWI2RnRJS2I2aTJ5?=
 =?utf-8?B?M0Y2dTA4UXJTS21LaC9nL0JkZFdtNFZLQ2ZOODNkWUxnd20wUFVHb1ZuWisx?=
 =?utf-8?B?WHRkK2hCOGpCM3NJRHR0TlpnK09WMlFUTE9ubkZSRUN4ZnFnL1JTb3NxeCt1?=
 =?utf-8?B?enV0OGpIaWJrcHhmaWVENEx5b0haTmVHSG5iN3hsdEtudUNOL2ZKcDIrRzZo?=
 =?utf-8?B?d1ZPWkE5QVdKVURMRVFkb3Fia1ZkQXJIbm9EWEZMdkFMLzg5WmF4Uk1USThT?=
 =?utf-8?B?Y0JYMUdtUXZvazZ3OWUwZ0huMDBJNmU4UDJCdFM0Y25KdFAxeTB5YWFQUkVQ?=
 =?utf-8?B?dlBCcjY1OG4xNWJrdUZEWE52L0pxZG02b0haNlBUa3EvSGhRMDZGZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6423f8-0c28-4bb3-8776-08df158bbcac
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:50:02.1695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn0IvowzVRG3ECrDzx+xIdPyNRvqeOaZNSBIKsHqgvbDxFRbgAl+zMSq+8+1BdGPdZBFRdyqcygd6NV+BrHgrvC/TqlgF57ygmuIKSCGutg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12439
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

Hi Shuqiao Zhang,

On 9/18/26 12:11 PM, Shuqiao Zhang via B4 Relay wrote:
> From: Shuqiao Zhang <stevenjoezhang@gmail.com>
> 
> usb_descriptor_fillbuf() expects descriptor arrays to end with NULL.
> The high-speed RockUSB array does, but the full-speed array does not.
> Full-speed enumeration therefore reads beyond the array and treats
> adjacent data as another descriptor pointer.
> 
> On a Luckfox Lyra Ultra (RK3506B), the adjacent interface descriptor
> started with bytes 09 04 00 00. They were interpreted as pointer
> 0x00000409, causing a data abort in usb_descriptor_fillbuf().
> 
> Add the missing NULL terminator, matching the high-speed descriptor
> array. After this change, RockUSB enumerates at full speed and
> upgrade_tool can successfully read the eMMC.
> 

usb_descriptor_fillbuf() iterates over the array, but so does 
set_config() in drivers/usb/gadget/composite.c.

I've quickly checked other drivers and it seems they all NULL-terminate 
also (either explicitly, or in the case of drivers/usb/gadget/ether.c by 
having an array of static size with fewer elements than the array can 
contain (and thus they are NULL)), so they should be fine hopefully.

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

At the organizational level, who's willing to take it through their tree 
once reviewed? I don't mind but I'll be waiting review from Lukasz, 
Mattijs and/or Marek before doing that.

Thanks!
Quentin
