Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77144C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 08:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68BED40A67;
	Thu, 10 Sep 2026 08:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UzBxDMp8acjS; Thu, 10 Sep 2026 08:04:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 775E040A47
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789027444;
	b=DCcKUAaqpbSWWFdPNLScKZaDTU3dhhHqIOclHaFlwTW9hxCYGqpkS3A49GqH2ejQDhVg
	 w73xmsQX9GIvT9e2rJz8NwDE2DmdmejRGtPXXCI7Kp+MCNdDCYTpmv2lstMdBm7x6RIZz
	 8kgYs+JC89Hc7BIi3GyA+d330mOKfvG7GAI6xGzV5yLk1ZQT1azUxejXd+DaoGnuSMuZ6
	 jzdwKvBO+mQrVt0nFBiv9IqjnKf+DAxpZYqp2i6bZL1eQ4fMv3OTZcxK/BEvRpK6o6aKH
	 Lth/pvE5V6ahnllnISfKej4thOxkwYO8n4oFpUbsoP5DucQdbyaSZv95lGO+xfd0/7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789027444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LPjkDVqerL95LDSNhILgodTTwnHbCV3oAx4o1Oi4ebo=;
	b=AFpVI7Ws7tKcCa2zZQt9vPI1mMs9MReKZLih1h+vTjL/ZuUdTYv6FZ4N48MvkB26uwd4
	 QAuxbZVZ/UpDrfTvELp5T6FGk53Fo6sKHGwgNo2Y/kwlCFjwqNhbgOK1kCi+DLG9k1ixo
	 ZU9RsBzFCqlLupysgBZ9I5Cl8jP9u2XEYfJrKcCYeaPtvjO5pt/ew4FyfiyPBKlUNY3gz
	 TfCyi3WJlfDXGP0LArzHPQtrS7SQp3k08ztmsAN2M0ovhIYAgRS6CTtf3XfxCibjOjESI
	 pJPJpcK68eIcysC+mkOqUjOspB7HrCtjgNjIoGIVLhNzr7+qVJPbODmAl6to19eip9w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789027444;
	bh=LPjkDVqerL95LDSNhILgodTTwnHbCV3oAx4o1Oi4ebo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qrK/ijZjfGUx3SavTp4rPgAQm5blN8GS0s+WGX0AXfbnoneD/sf68lyxam8o+6X5O
	 WuPi/FVk7Xxz/Z4+JV2RhyYFtJ6yOIORFXZLWxIjAZMsmRlVJBsbQCFtb5XvCbn+jX
	 yxcKwgo+o43EwydFB2rplKDmu0RjzcB0snvQ/Jvd3s3k53x923g3/0wO1ellhl4n3e
	 U1MGqKQRxIqYDsFDjn9GR+bUS83Aex1MDHP/7M5X4nJJ/q0PeYPLPLHIe17W6mrXxm
	 IflJQVDT1ukMSnDyIkwYFI97EDCOPbvpah9Xfiu91k1SYJfYKK9i4Aujc/Nq/xEo+Z
	 IsZPnr5AZiheA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 775E040A47;
	Thu, 10 Sep 2026 08:04:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 271D414C
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D428401CA
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ViNGH-dHCt6j for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 377F7401C1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789027442;
 b=j3xz85j+9/CBeYdJp5cILlhCGOpK0NnYKHKeSMJfhc/spRvJ3DR3vBw+Xi5f76wzMVw3
 HK0qe5FDDkjswBs451rQKnvU9frapJfLBgxcH9Tu4tiIeYZDQzPKqETi7v7nzcJON6czb
 zUlGofCHo/uFIrd64USencl2Gvg4fpWfgOzt9Zk4q7sZz/wY2wVd+TrrBvmlna/kgd3Vu
 evr7goGRR6hx19AfnjU3rx0bx297o/Sey5YkkFRcevMA/Fa+mSrH3+sYvtSwOcsdLBS48
 +m/SfRRyd3vXspHFkdnGK08LVfcHOAXDrB4BfTUsN36DijnJ9tltkWPDlOU1CoL+M2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789027442;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 bh=LPjkDVqerL95LDSNhILgodTTwnHbCV3oAx4o1Oi4ebo=;
 b=Bple2o6WJmPSoOSoCZk2ZGX56OkDQCZvHGx4JOTJqVVub+KiGtKSrj9kTc6k0mo+CK+4
 jhyHvB52yNq9J/TdTfaENCt9fi2ygW0dS889OSg8g1vmABl83NS+4DdeITSaOxwYu6NrS
 lDjQD2V4BefZt0uySqZQJzKsar8vB0OkPl+lnenqF5MIyYGzNIiwsFioxZTH9n+brxRU6
 ESQfcLnSV3zBmxCL35+lxC2FGO71qPCT6xXhB0nbf7PMvokFyZejiWe/R47mu9eJJKlFC
 e93zVXTgb+r2SRE/FXo3l95UFfig0rtn10DURksVxwLFGIV6lDG5KgUUjyk5WRN2R9Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rffINdjw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rffINdjw
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 377F7401C1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsNnOabiDRNzmMfUBkJlVPknmW2Lpyf2pfrP1hNb9zp1O4G4HvpwtflnqDx/A8a5nDX8YzL9KV7kv5eEZIFFrB+hXbzHYcKMy/EDC8fSub4nNXB3yqkVPkvDviykb4MuIeVYzyhZKbKTIVyvqJ9LfEFmM+w85DbuAeRjUePov5zvZLe/ShkVoBh4WCWYuM+uSvNFrgaT/pdI0SgZ0hHb/VIJUPnV30Q9CMGRbi1kdZLqseq0sW5LMs2W8T2CzFB6SkUfpNZXlM3/S/Qrf84v3C8ACCOE8gsSmd1HrwUTDyS07dETAqMI8jOuVr+N+rFkKSGxvQIhwaiUAIwd0+nHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPjkDVqerL95LDSNhILgodTTwnHbCV3oAx4o1Oi4ebo=;
 b=G6ZXc80kRhnI95+rZn6jrVUwrB61CBNdAXmtoR62YuJeXLw70hP1y5brkhM+PGCib/lqLmyfoXgujQXdYeSJVZoyrUJlmCh7P8Uv2sAzz2JX85H46HshLtZOgX/bqdpYhquNvu7fHShVpjyh26mlVoXv9h7YgBm6BB7DL4Xx8snCxHLLXa1fB1IQoPlG00jmi+9hd8u8OWj/2EmJoPMqdpmENIdpYOitzH+ipEFQCbmsiz7AZP0YUbwVNVVfA60sBAQbAVIL4lN1Q3MK17dD2VP0gnh5w7stY19BOLXbW8jFssq1LtjR27JhXl5vXK8RpbydFUDCU+Ui4lP3koNhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPjkDVqerL95LDSNhILgodTTwnHbCV3oAx4o1Oi4ebo=;
 b=rffINdjwdtJP3seyhM0zTR0PzUAqMuPsdesLLqewrUjPvViAAxRAPd8oBKxycMTNmSyVxg4dK6EYamSohMTO3P7GybTMpiBhC9dQ2khe3fLgcjcQVlzvUSRlRCsQ935bxmpT/kXfyZSLEzzyz6kF96UWsutnfNCVE8snOqdZFlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 08:03:55 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 08:03:54 +0000
Message-ID: <2ec7a375-ef8c-4ecb-ad1b-cfbf3ce12b96@amd.com>
Date: Thu, 10 Sep 2026 10:03:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
To: Sriram Sriram <sriramsriram@linux.microsoft.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Drew Kluemke <ankluemk@microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::36) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: b38e8833-d94b-4720-98e5-08df0f120ede
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|4143699003|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: sFKukTNsNMkPcVrq23pkvnUML8QWpQNKkWvg0SZc8z+Xsfpzg3ttjBVCRHEU24wZ0P4CUAgDeEmsqPJrzy4B6xXQUC1Kd/aJKNt1paDt5fp0eCyHfWC8AqH/DLwtLkw32NPyPqDuqiXBtVO/lBx/wRC7ax10q7mFGustpidpAasYdD9tad/oxaW6omzPDxTzNY9Dp27uUhOl/CQiV/lWBKR6sa+tzH9f5G3T01QzX+oOszDU9z35fzl4V2iACPgy0Hy5GmAUj/HyGhxcBPyQUR5FVYPrkxJvOmBBayH1b5EwG2kxjKOggamwGc8Panm+DgoNrtFvy93GlY35grh3XuXt5HF7u7ix7jGu495nn8ujS5Can1A/z4aWN8Qe4T0WGamANcbkNkdtx1FQiT5thN+nRusxp7eZ9qarG5TL6a7VMgWjOxh50tTD9oJeu2dMGsrpb3rhptLiMJ65yXBaD1cNz5XjN3PrdzpALC3glkRDyvmJMiZrK/f1H+wZ5RgeHUxaWN5iLyyRueprT4LXrKp1A8wWzv8gdLdoKKMbEPujnKCBRbbZiAQj0mAs/r2aUnOhF7jvFgVruIGL0cCXHLv9sIdHueCn8jL7ICR0yQGtTShqn7f3orFxq78HzpQzKTmhU4XQJujptKFWH8Hx+uMEDd2OoWVnT3m4JSwL2i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJwa0NNdEl4Rzh2bG14bW5ROG1DTXloUHpDZXR5M01EQjdBVWtWN2s3NFF3?=
 =?utf-8?B?M1FqRktUYkdkMVdlY3p4REZVTFlXMzA3b2xDeXBROFJDUzVIRnViZTB5c2R6?=
 =?utf-8?B?d3JVeUF5eS92RUVseGduMXJjcS83TVpuQ2FVM2RZQTQvU2tzQWFYQUprNXBL?=
 =?utf-8?B?a3puK3BhNFZoQUJGaUpzQi9yNy9zU1VFNVExOFJ5cUQwYnhiNFJPMDNLSjFN?=
 =?utf-8?B?ZlRLV0thejE5emdRWkpxK0xJc3hhRURqZm5iaStrcThvYXFKemRhcXdzYUY1?=
 =?utf-8?B?Q09yaXA4Z2o1S2JuQm1VOEFZYStDdisyRVYvYU9qZkNQLzJ5WlF0cUZZbGpt?=
 =?utf-8?B?TCtjR2Y0VVArTisrazRJQmlpN3hSSXlkNmZFT2ZMcDJOYVlPTDJlQ3REUzlW?=
 =?utf-8?B?aG1SRTB2VVhKQmtLWTZTT1ZaWnpCYkdqeWkrUW9GWEF5QTN1S2dSS1djdXRO?=
 =?utf-8?B?dVNPYllENlFnZ0ZVNFdxWG1wQmtqMkh5SGdycmxDeFR6TTZha1YxWjZoWHZx?=
 =?utf-8?B?TnRKcUF5b25uTjJCKzZWaFJrT3haUDBzUzRBQmsvOEwzY0EvV2J3K05rSER1?=
 =?utf-8?B?VzlUVmk1MUFKRURab0QvKysveThPL2MxUXIyR3dYbFl0b3NwdjIzUDY0dnVr?=
 =?utf-8?B?RVNscm1KU0JMY3hrVXdMdDBUTFpTb2dtQmNwcWp1YlNmM2tYVnVtZVd2Y2di?=
 =?utf-8?B?dWhhSUFTbVhsSEl5NmRjWkk3VVpHT1FWTVVCTVhlT1NLNjRMTHZEd2tFSzE1?=
 =?utf-8?B?ZTVla0R3ckZybHdIdEhWM3NaaUIwOXgxYldsRlJLNjBTREFSL0FnMi93T2Zn?=
 =?utf-8?B?YmR1N3JLc2JNRjdtYjlCNFIxNXRzU0xOKzRMd041WkRrQ0lTR0pOUUt2bFY3?=
 =?utf-8?B?aTFQMzF2VC8veVY1VHY1UENLYXdyTHFGVmNlanN3RDN4dkxBYTRLZVBjWlVo?=
 =?utf-8?B?UlVzaGwxZFQzbjhYZVhnNG94UnU5eGR6aEo4K3JlRncxSnk3UmtRTzlwNWF0?=
 =?utf-8?B?VS81a0NEazd2UmhuN1h0bW9QREplT09SeTBwWjhOcEJVdkJQZFg2clcwcDZN?=
 =?utf-8?B?eDdVbExDUWpPNHdoMUYzazdjak9LSWVVbkdHRkRxL1k5a1pvWkxXOG9KT1g1?=
 =?utf-8?B?NjNzY0R0bC8zd21rQ2JrY211cmRXbllNUGNuZG1ZYzMwWEtBeUI5bnM0REhE?=
 =?utf-8?B?UEZQWDVYWGtycjRsMkIwdjdCWUk2TUw1dkFLa1NyQ1ZmVWg0SThIeUdYM2Iw?=
 =?utf-8?B?b29WWVgxbU83L215WlBoczlrY1NRVjVBdXo2amdtT1FVejBTWGZtMWRHTzI1?=
 =?utf-8?B?YUsxSXVaSzdFUWJDQVFGckFBZGI0UFVzVExWQ2hlVUpmNmFoc3BwNis1Qnpu?=
 =?utf-8?B?L2VvSnRyUDFGNTREVVNsamFxTzNGR2J2K3o2aHJpTjZhUW1wcm5VUFBIZHNK?=
 =?utf-8?B?WnlxL2FkVHhqYkkxNXExZWpwUGdBTEtTQ0VNbmxtb1pLQXBzbDkwdEpwNS9J?=
 =?utf-8?B?eHlkbld3aDBtWmg3T1ltN3NXRUhvTm9sYkd5Qll2Q1VDc0FuOWx2bTRvanRo?=
 =?utf-8?B?eGJya1NoL1EvNXJySHJJc0RRM3BUR1dWVEJDeEQ1MG45T1UwQmZzUWpnTXlk?=
 =?utf-8?B?SDUwOUNkSjVKcHNKSFhNNEtJUFNkS21SWHV6Snl6aXdzVXc4aFZzUDhkRktn?=
 =?utf-8?B?TVFhM3lTeXJadkY1bnU0OUJzVDVJQkNDN1lxUHVVZVROU2J6dnhtVlZzdXlq?=
 =?utf-8?B?YmVvYXUvSlJaSkdVVHZyeGJ3dXp3dlc3dUtHYmxxYzhMUTdvVkVOQ0VFOUFQ?=
 =?utf-8?B?QXRFNXJtbDZ3cHVnNzB4WlladkcyZUFQcmozWU9QZnB2MkY3NG9VOXNYTXgz?=
 =?utf-8?B?N2pVdnhva3U3WDIydUhTSmNYSXNlRHlYQTFsRTNaTHRnVlJCc3pEd0hRWlRr?=
 =?utf-8?B?TjhmRCtSaTJ6aSt3TlA3OGMxUHlLMHVPd1NVYlRINVhNM2lwbDNFZHpTZ0Yx?=
 =?utf-8?B?SThhNWV6MGI5YklVSEhJaHNQeHFNVWhqWXM5ekljR0s3aDZOb1FabWVEZENk?=
 =?utf-8?B?citPVnYvaUVlTVg1dlNoeDJ5U1N5cXB2NWVOa0R1V0VuSU5XbjU2Y3FsNkxC?=
 =?utf-8?B?dFlYQVpreDVrWXJTeGhmWm1ndTh0TnM2UXJnNnplNmdGN2ZyRExMSk55cVFF?=
 =?utf-8?B?SVJwK1VzN2NWYXlXMmVseThDN1lETWNoMEZhK0g2Y0hvRnhCdno3bWdMay8r?=
 =?utf-8?B?OXdLTnRaQ0U3TGtob01FWGFiN1RJaUU0SDZRdmV3eUJXTHIra3hmNFdhS0Y0?=
 =?utf-8?B?SHJVTW5uaXJ6THNkSERJa3JaVk00enh4T2phTUpCVHRDaW1HcERYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38e8833-d94b-4720-98e5-08df0f120ede
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:03:54.4851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxY3QLGttO1F7LDpP//kNG9EWGTRBRYoWM3Dn/eRisWB1Y37L5TaEcw0/mr5LfFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
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



On 9/9/26 21:20, Sriram Sriram wrote:
> From: Drew Kluemke <ankluemk@microsoft.com>
> 
> board_name_decode() assembles the board name into a calloc'd buffer of
> MAX_NAME_LENGTH (50) bytes using strcat(). It appends CONFIG_SYS_BOARD
> and then, for every detected EEPROM descriptor, "-", desc->name (up to
> 16 characters), "-rev" and desc->revision (up to 8 characters).
> 
> The length check runs only after the loop, so it cannot prevent the
> overflow it documents. Each descriptor contributes up to 29 characters,
> so a base board plus a carrier card already exceeds the buffer, and the
> data being concatenated comes from the EEPROM.
> 
> Use strlcat() bounded to MAX_NAME_LENGTH so the writes are truncated
> rather than overflowing the allocation. Truncation leaves a string of
> MAX_NAME_LENGTH - 1 characters, so relax the check accordingly;
> as written it could never fire once strlcat() is used.
> 
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> ---
>   board/xilinx/common/board.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index f45b879736e..690991bb435 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -590,38 +590,42 @@ char * __maybe_unused __weak board_name_decode(void)
>   
>   		/* The first string should be soc name */
>   		if (!id)
> -			strcat(board_local_name, CONFIG_SYS_BOARD);
> +			strlcat(board_local_name, CONFIG_SYS_BOARD,
> +				MAX_NAME_LENGTH);

I actually got a path (c&p below) for the same issue some days ago internally 
and also reviewed it already. But unfortunately it wasn't sent out yet.
The difference is that it is checking len at the end of every loop to get out of 
it earlier.

Thanks,
Michal



  Author:     Pranav Tilak <pranav.vinaytilak@amd.com>
  AuthorDate: Wed Sep 9 10:13:09 2026 +0530

      board: xilinx: Fix heap buffer overflow in board_name_decode()

      board_name_decode() builds the board name by repeatedly appending
      to a fixed MAX_NAME_LENGTH (50-byte) buffer with strcat(), and only
      checks for overflow once, after the entire loop over all detected
      nvmemX EEPROM devices has completed. If enough devices are present
      and their name/revision fields are long enough, strcat() can write
      past the end of the buffer before the overflow check is reached,
      resulting in heap memory corruption.

      Fix this by using strlcat() instead, which bounds every write to
      the destination buffer size and prevents overrunning the allocation.
      Use its return value to detect truncation during board name
      construction instead of relying on a single length check after all
      EEPROM devices have been processed.

      Fixes: 52ff1626cf4c ("xilinx: common: Enabling generic function for DT 
reselection")
      Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>

  diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
  index bdccf0732d2a..964817d98e65 100644
  --- a/board/xilinx/common/board.c
  +++ b/board/xilinx/common/board.c
  @@ -571,8 +571,9 @@ int __maybe_unused board_fit_config_name_match(const char 
*name)

   char * __maybe_unused __weak board_name_decode(void)
   {
  -	char *board_local_name;
   	struct xilinx_board_description *desc;
  +	char *board_local_name;
  +	size_t len = 0;
   	int i, id;

   	board_local_name = calloc(1, MAX_NAME_LENGTH);
  @@ -592,39 +593,36 @@ char * __maybe_unused __weak board_name_decode(void)

   		/* The first string should be soc name */
   		if (!id)
  -			strcat(board_local_name, CONFIG_SYS_BOARD);
  +			len = strlcat(board_local_name, CONFIG_SYS_BOARD, MAX_NAME_LENGTH);

   		/*
   		 * For two purpose here:
   		 * soc_name- eg: zynqmp-
   		 * and between base board and CC eg: ..revA-sck...
   		 */
  -		strcat(board_local_name, "-");
  +		len = strlcat(board_local_name, "-", MAX_NAME_LENGTH);

   		if (desc->name[0]) {
   			/* For DT composition name needs to be lowercase */
   			for (i = 0; i < sizeof(desc->name); i++)
   				desc->name[i] = tolower(desc->name[i]);

  -			strcat(board_local_name, desc->name);
  +			len = strlcat(board_local_name, desc->name, MAX_NAME_LENGTH);
   		}
   		if (desc->revision[0]) {
  -			strcat(board_local_name, "-rev");
  +			len = strlcat(board_local_name, "-rev", MAX_NAME_LENGTH);

   			/* And revision needs to be uppercase */
   			for (i = 0; i < sizeof(desc->revision); i++)
   				desc->revision[i] = toupper(desc->revision[i]);

  -			strcat(board_local_name, desc->revision);
  +			len = strlcat(board_local_name, desc->revision, MAX_NAME_LENGTH);
   		}
  -	}

  -	/*
  -	 * Longer strings will end up with buffer overflow and potential
  -	 * attacks that's why check it
  -	 */
  -	if (strlen(board_local_name) >= MAX_NAME_LENGTH)
  -		panic("Board name can't be determined\n");
  +		/* Reject truncated board names. */
  +		if (len >= MAX_NAME_LENGTH)
  +			panic("Board name can't be determined\n");
  +	}

   	if (strlen(board_local_name))
   		return board_local_name;


