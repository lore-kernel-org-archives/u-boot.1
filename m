Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B765BC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 13:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00C4160E23;
	Fri, 18 Sep 2026 13:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZxH8JQOiF3N; Fri, 18 Sep 2026 13:28:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C4F1960E0C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789738113;
	b=BN+x/aKdprh4x2AC8/feQ76k/ahj1niFmqH3yGfspM8YFDRuT5rkvqz9F1IwlPDoyS/s
	 5KmkyuPitIwrElKAdeISaSfW1hOhEfJo8VqIa4DItr7tt6y+W8740j4uN71+CYuJK/CF5
	 wT4ZG8rpF3IkOJQHirNgY9JVRzEinKx6YwZRJ3iVPXi4QvG/NGPQSzO34yl6SYZJuOooL
	 2kI6UboCMAwM97wSMS7W+zGTxmYVylmMIfCFu0z5AvykJi5LNNHJhc13uaX0Z8nkRJ3sW
	 3NLRW8gIokWl54nO8RJ4XH2plW1g2au0t+yQ55IB7QnpooG7uuyASFld8MFyxTHuNyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 Organization:References:Date:Message-ID:User-Agent:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=HW/iFBEcrWicvE3Xllm2CyUQpmBKeNjfTLsy0YEA5Uo=;
	b=FQD3xARr84LwrU6wOEYcAO+Tl7ptp25HXxVVVBiMTcBCNTKCcjzao30zFjKOY5ETdfpe
	 6NGF2UvGfuWJCDTtZnAVbBVmelbjjCTsK3RNdLMXHjoIikOf/YPcSXQSMdmAmUzyrH2oZ
	 SzGQts06oc29WS11AwFdYBL8z8DrMNRqOJnOPBROE48oZUrVeT76VJCJarVhYfkXdq2cZ
	 5Id9ySyKfjI9qRhtk0Qn3+4OKRQcllYqBrF9aCW9KQFW+7rQC26Txk7/qjEIqPD115cEy
	 YBqqH6xhXahe5F4MdiFcrLTQPY0GCZolo96Mwa9YF+FfEO0Lxq4gYTlCOauujG0pMog==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789738113;
	bh=HW/iFBEcrWicvE3Xllm2CyUQpmBKeNjfTLsy0YEA5Uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ndZo6MmRpTPf2BkHN3i2Tm5ChlEHsrkqF2SwzDo/nRqBDSnj/zNj0V8AuDOvUAS4B
	 VxH9ndLRsD3HmhLTSHlFsjLE48tHrxw3fYWlKem4PQzIBPqvDkzffMcz5dyzPIifg3
	 hK+K4Ai80wvdpvtjQEUeFpOT9K09v0I/hpgZSx0AEWeBge4TH0/sEKZChc4VW9KgnC
	 NsSrPYSlqQLPAxmcwpnk5V4qRYIb+8+g6bMXzOHCEbRijHP2QXqboXt7dq+H4bmo6K
	 wauLjfh8lQinkE9Qd2rRXz+fLWtt+FP0esUKHVhzxiD2ug0d0CRuqFOezMdJnR2PCQ
	 ZYo+ttvAHEV4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4F1960E0C;
	Fri, 18 Sep 2026 13:28:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB15F13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC7DE8127A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2K4KS7qcLDil for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 11:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8EED781141
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789732306;
 b=IwWn+7nlH0EAubNJzoPKWpDnKqUUHsaqnkrHgakXtmzEQHuRkYqoTDm0Yakl9GkJudIQ
 X6BiUKvU0CxUiD6CkEoXbjxaZx5I+373599x/E1d2oL4C212qsRBmJalt/FpKwSxLGxo9
 /k9xQ0gEcWjnkGZaH45zM90ZYsJEHOOwIZh+0SmL62Hce8UOFVxBGbtGUrDfZFvFTRgOL
 3InqUZILOZTrE+vpAQeIMXlvRdi4v8Dl7EQgdmZsQEjVRWhxgWVAKDea3tu/sPJhBHFOZ
 Ao8kr/EMICrOSvDX9Kpe2fWKnRgU/5poF7kZqUno9L1j90fq4+dWYY0jRi6urxil5Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789732306;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 In-Reply-To:Organization:References:Date:Message-ID:User-Agent:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=HW/iFBEcrWicvE3Xllm2CyUQpmBKeNjfTLsy0YEA5Uo=;
 b=qVdZZQJTxtk/mNgFnUY8L91Q0QUkMrTWirGk52mJCHfI7sc31e4qWZ/1f/RTXnseVoau
 wZBqEQRogctbAkUrfhTfIu4ohxVOLUsp6psOV65Zj04B0Sro4bmI0p2FecPaoGOWCwAC9
 B2c1iX4i7hpO1LffQMt85SO4nBNN3l+qCq3pY4E4h1hPvyOwbLAET20CEug/chzk4YRVQ
 BejySiciT/pHlSUwlD5A/W5XN/cswLQSYLLjzP0sCSSvJD3X1jYEH8ZJwOXxwRiHD4Wdp
 HZeehKdi13jz1hit1YwB+cC1FPB8utLpffdFplwBDVH82ZVBhwqlzy8D31Lfe0cgDCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=W6maeDUM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=W6maeDUM
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EED781141
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/MWFGjnuiqOM7NvYBMpuHlE2stn/B/OoFqdJOHGmJ9xiGBBpKtSbUn7Ks7Ll84cHHzLDWISSaYdm2Li0ob+uDrH/Hg4gnn+JuGna9s+y1lrSgNr2ae9MJr+O0mh6NseHP41tFn85ezOiPlsaniUzdsSIUrzRaGTviLU2ef/U5xnZNsoFw7a6Pa8pxUjoQEk3q66oW7ORwRZDt2KJTwU7CXjaUearqBZGRd/VBVY7V4QlQ9zd6TKQ3vWhLsyB/eX1GBWDrfPakL5vLDqSCnjcR3WdknJe+sTCTVUgWCz0BRu31ApQ5uOks4PdNpkY3zZKhOyJfrD458SauelMGu0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW/iFBEcrWicvE3Xllm2CyUQpmBKeNjfTLsy0YEA5Uo=;
 b=mb5h+R3sbXsCthCM4DBdzne6kVrcN1fcUpx7OAyJ0KTyfmnkfInNX3ycqZG0rtEw879+wxuJps9WkD6iP7kpU1/5AG86zbI1TTJXi/AGgqFpdK0SFBA0y6aZ5+3lKT+iuttousYaSXO/uknyZj0L8yIc68ujhLHFp/7nhk2+Fx6cKusbVr2h3s+i0bLYC7EUJFeb5fUJPEm5Ly5tOAviC18O4oWoNFwAZkN6cGP6ntHbhoW0J279JiKMkyJHLEVHd5YUlDwxBF8SoL9lO+LMP12dOeWUdT1rHFuVQoXeb8BJHOk1jtE1MRBYZIgG5Y3KPD99Ykp2gOo9b4P07aXycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW/iFBEcrWicvE3Xllm2CyUQpmBKeNjfTLsy0YEA5Uo=;
 b=W6maeDUM+a2sr53exxSxmo7r3PBjj7Hortu30+EGON45koWKjgcYv/5AXM2QOahRKxpZpaR4OfO2ooE+nepu9O0gnJK4QtoVhOWy3qTtgc5AmKwevuZaXjpp7Fo8m/iikR/eMAkR6wn9OfB4E7McvPIYMnfqPIYLpilntBvOOi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AMDPR10MB992293.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:70c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 11:51:39 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 11:51:39 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org,  Igor Opaniuk <igor.opaniuk@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/4] optee_ta_avb.h: add
 TA_AVB_CMD_READ_PERSIST_VALUE2 define
In-Reply-To: <CAC_iWjJ3b6J+khJj2jaiMHyw3VEzK1OiNRP2BNfOGDOTt1ijdA@mail.gmail.com>
Organization: Prevas
References: <20260903212215.2331118-1-ravi@prevas.dk>
 <20260903212215.2331118-3-ravi@prevas.dk> <87a4pttgch.fsf@kernel.org>
 <87cxup9p0f.fsf@prevas.dk> <871pattxgz.fsf@prevas.dk>
 <CAC_iWjJ3b6J+khJj2jaiMHyw3VEzK1OiNRP2BNfOGDOTt1ijdA@mail.gmail.com>
Date: Fri, 18 Sep 2026 13:51:37 +0200
Message-ID: <87wlsisrp2.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::28) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AMDPR10MB992293:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b12d77-7d76-4fe8-ac04-08df157b32d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: pxLRGCXkapk/Z3DYKquKovm1dcC1PTLZ1TSzAkiG7VVRpa599ZrCi8KohzRMBpT+BAJ8JhsNW/4JDJNH1mjdlFB9JEsyB/mx4DhXemvBCfFKnU69P9n6Xbs64KMuv3o6A9PtGmhRS/WBumiqYK5BkMiO0JFkeoiKUjenVF2BMEZGs+lDTOfTkYzz492c+7yVNnhYnTbHvPsb4Y1VqqYKMSyOvYXyiljV1STHX3FPnviG/7trhSnF/cSVyAzZjO8l8hh9EQEjleQGU1dTzzSQ3H1Yw5nv23LZs2Q5k4qM/tGjpLGQ2Xz4EpOt55OxJiQ2LNwHQkjBJmfooiiXmEj+/B07dvI0XJE7OecIuMXb8ELhPOlQUkJs9XftJLvYWSPbm35Pw01mFkURJBYtq4G4BrXzlm9ywjIf39A/Cm7coce+VI66M+fMpXb+cPq9bZGc98NoPjZauy0MeR7Cqy0O6LKRxDoBChh0fjYhfkSrF8I0rcdl93dnEtuqteJTvh4vK9jvAVA8L+yMGp9xrD+NyQIkPb6FcKnhfz2nDz+yDNtacLlAOn7PsgtmcT4BhcouKSVNsZN/lQuSGjSWvHOwJ78BUjK9FFCfA2WADhgN59UIxSJpkbWY0/xcH7FcIuUd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EAPR8XC1AoZlU3iekQtAbXaQW11RRwLEUUQpTwBOI8IPOI+jPoiLw2VQUAHH?=
 =?us-ascii?Q?zb8IWpxvwuecxvVJOPJAq/RVqAuU9f3R5DTysYapyZJCgPHOd4o74qmAuaXP?=
 =?us-ascii?Q?gAsno2b/OtPL7VUIZjcY/MQ7i3+0JuF7nUFH8XiDkYqZ0d2S2b4crVGPW+Df?=
 =?us-ascii?Q?1pitCvxOHqguerjI2NBgaJtbpWCpOv6gBaDNQGX18GocS1pry0wZSFpfcB1d?=
 =?us-ascii?Q?T0jbdvUYxMiD7xkmEan90Guq0JzhUGWX5rpgPmi7B+8nSUJxOZ2M+q0lUYiy?=
 =?us-ascii?Q?OaqiEPLm9Y2BjCIkf0cwSQX76HuQ0pWNyzA265AMKXnLt9UCstQs+Gf6o3QR?=
 =?us-ascii?Q?QPEC/J4aYQyxYReXLMeUzTfR3u6sOZooA6Fny7/E4k457P48+/NLosuYXo0L?=
 =?us-ascii?Q?rfaRCKi6dz9BIw6e+/xdkiZEH1oG+cLwSD/0b7FV4SqvE5NZgBB9ucCVQgYg?=
 =?us-ascii?Q?BETQnhG51vcgMNzPTndf5g/QWydJ/GQ6PG4k6RtSE78LcaPsEXWqGktLF2lt?=
 =?us-ascii?Q?/p+KHbEl33TzptZYXHkfKNyhLZspJ+GnrwlpWl9u2S3g50FDy1RRqF+jY9Xd?=
 =?us-ascii?Q?dIMsedsgHbNqi0gRza8X9S2fs89fDcRGEdISUh0IksClvB9J9oNe9p3xj9JG?=
 =?us-ascii?Q?fZfcyfnz4Hs/x+fqqbjIoo6aEmQxw+34bHFeK8uhrza2lctIAIZEET741ZG8?=
 =?us-ascii?Q?chhbm28mbnPwhSQe5k4VMe0F4ZXDl1xQZOApawjc3cq7egUtvDjNcrIi/q0e?=
 =?us-ascii?Q?jGZD1uCqtVNnUzNOlAsUKy4RQNLbAj12Ith2Fuh6gaN4EGOkn4UhPWYIr4z8?=
 =?us-ascii?Q?suirkLvgke4tfee7CwdVhiUZs3fsVgeVkWhofHUXHsg6hak4MJ8r6ZMNXvoL?=
 =?us-ascii?Q?Z4VzIfTqf+TmXMq/evJKVqjII2KdXHVWLOXgykegRi8ljz+afcru+CxtMEDT?=
 =?us-ascii?Q?m3v0EegY2Uhgir8zjaIlH2j5nBfNhrH5w7CdudZzOvM5xUyjcIITmx9dZrJZ?=
 =?us-ascii?Q?lkqtdZDEXf9l8tjOyo4ojihqQJLflGY3R0smZRF71JweuYxEqt0+tedgUG3D?=
 =?us-ascii?Q?32sgIeK7NR9BOkgh1NHWPYbTJYsOe2D4whqQOvgewfm4/Ps2XZHi4plZJTAI?=
 =?us-ascii?Q?7aInysUQ/AbKXqSWTHbOyjZYx7agoQqMCx2Kux8Jh0JVXpPrl/EArH/AZu7x?=
 =?us-ascii?Q?5Xd+uGtSKFsxA+8vE7afDb8wxSo5+ZHWbca2Y3keLQHxb8xZYyLSRUY5srqN?=
 =?us-ascii?Q?JOwK7yPgAPCzoAq1ZhYBfsEeNHIw0tBShGDRsV+kyWEF3Ia813d8TXymAUii?=
 =?us-ascii?Q?BmbKfu6QKzYDhIiTUlrImTJxGkl/WS7JY5WmvHeJ+fvaDZMjBtqqOQoAxwry?=
 =?us-ascii?Q?ymhOwziLaxctahHnakJVd78x6AoTBaRUGkLR/ERro8fEylay5X5bF9IhOcX7?=
 =?us-ascii?Q?cbHv6bCv7Q8yodHFQIZy5o+79xfEGpsHAIn5t1X4R/VlCPHlsuW/cixvac2n?=
 =?us-ascii?Q?SjEJm6v5FEPtiOzgl/ibapBJBwNIT1qYCIsxr0rgfPEtjYWowsLNZTxT+nA2?=
 =?us-ascii?Q?q03G/ZniL4Gtj+dRiUwqa2dD2SPFBQUgG9P99TiPHnu+09W2vJX0RQbK/zds?=
 =?us-ascii?Q?K6JKqm+PzsblE3YZj3h2evwrGYZHdJivDbW6nHZutLHqTMVaKW0bQdDmVQ0y?=
 =?us-ascii?Q?BdSidElmGUKqd4pxSNidPlenZuPaQmVDMQbZAIa++ko70KtLPzAPBEdM5ElF?=
 =?us-ascii?Q?WquFvK8LTJmRTypQSnR6BS0pCCJP2ek=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b12d77-7d76-4fe8-ac04-08df157b32d5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:51:38.9893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHij2RUsQlLZ90uLNMc9qcfF2k0bEck75c+aLOguNlSF4o7pNgwU83EAbUXo/joEhalHocDvQxtVYADsVm08a75rXjeP9Q5PupmM7ldx6HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB992293
X-Mailman-Approved-At: Fri, 18 Sep 2026 13:28:29 +0000
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

On Fri, Sep 18 2026, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> Hi Rasmus
>
> I had a PR ready, but the CI seems to complain on RPMB read/write tests [0]
>
> Can you have a look?
>
> [0] https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/pipelines/1320
>

I will, but not until start of next week as I'm heading home now.

Thanks,
Rasmus
