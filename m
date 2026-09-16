Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24ACC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C69F580E2A;
	Wed, 16 Sep 2026 09:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E27RpKUmm4xF; Wed, 16 Sep 2026 09:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BDA0480E1B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789552573;
	b=kr5fWXiqmrka5kiWrxsnoE+bZgpSSQJ6gXiWnuJs8paz0BOTLgUdeYuz7G5OxM6WQXQ5
	 xqYnLE4yy2zv2oyXDi/v0O8sux+DW7PHOzXBRPcyOsNZ46NwFmD/sUVXEgCOGOvC4VtYz
	 /z8Gj9nNVML/ykpbVZIkMK4xa8Kuwn+koX5gpGoA1wpac5AVsXKM18el5EICW4MWecI6F
	 k4GXeOt1a1dWSuSPD2NHVasg37bHiiEKGuXCl7DLNUChZtyKClIh6A+cbmpO7TRRsgPSf
	 A3qLIA7tlAuxu4FQSH5Rl361UIowX0et5JbcAGtdGhCRNpU1ZkqdAlEpXPgI6MkTjtw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789552573;
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
	bh=ILdf/69ofWf52Kr1Tdp7oMoELDAtYrW3JNxZvgvSA4E=;
	b=ntPW56HcXODkC9ZNEUl/N8GNBavGTaGmdKFdNSkpOf6AouvHqrT9xxkxCGmSkRuoQgwT
	 1dox1aE0icrpPuYRxM2PS6FbgUe/dgaEqIg6QcWJMSm4C9t8M7WgHzJOJlDr6j/Vbq8Ug
	 z2uG8rg5kx/gMWJlhB9WQEJL+P6DHBBJKl5+qnUns2EjsqVOxqbl1U+5sFQHr2dGigcGc
	 V0M3XDM1TUeKOLiJK4X3eTR4BVPrmAptwAVKoqJX1aVnDAyyR71UBSzN5v8an1/3mzpNl
	 W4d8HNxKhN1pHCwCLX4wqEKlC/OwWOqPPugbh7tefCWRax7Am56ZgCYHTd7IJIu1+7w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789552573;
	bh=ILdf/69ofWf52Kr1Tdp7oMoELDAtYrW3JNxZvgvSA4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DVEOSG0Xq7Y1CUeJYAnBLHcmMTDnABFjXwM0f9MtJOaA3c2g5ubTxvBwD0cMiHx92
	 P0xEDcEvN8rpLSYyY/wNygScGM1bCpQTr8NMpw5bn62ZvBwjtog+JMgAVdHVF8Udb4
	 wm0uBTXSIYX5vZmtfK9QSX2chziy0UfXxU4eRBZ/A53jvw4gTG8GeJm5I7e7lA5hQ1
	 Rjwe5BUZrv5Khz0vnNM9IFbThRrVK5aOdbXPpdCPco88n2qdx6L2deGWKm8raYOBTw
	 OExHjkQHBwFLXuvABAYFO+2gN1G7I68v894iIZt+dUHDjZ4WPYuZS5g8dRDRtfSiaL
	 kUn/BSTDIAYGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDA0480E1B;
	Wed, 16 Sep 2026 09:56:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CD7423F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02796404EC
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jPv-AZiBP4YI for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 08:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B00374052C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789547094;
 b=MEl0UL0DPkZWOGhvv/9oLbctNLNlWpd0zU0VYRRMCQ6k1SedJ3ijsR0NvUkqIUoAbt7o
 AFotKPjnrPQ2J4+sqoh+lMngl4D8PmQ9lxNPzfrUQsTOb+FKA1O2E2k2iJU3z/wSDkpxg
 vAqu75YVqU4JlwxPRAL3+N13AVLhGLRghQtNFDcjc3ogXmfa4afy8w8JKV45J/a0PRAxA
 5oc1vzEDcD0xs5Llmj0XVvzQ0rod9elDth2kJGqq1DHhospgikg51tN2DnmcRqgIBCNX0
 7Zle+K1rtyefIsXkBXxYwnmlYl7EAmMoWg5NYBjYiUQWOdXuZLkrc8DI8rJgTbaFU8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789547094;
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
 bh=ILdf/69ofWf52Kr1Tdp7oMoELDAtYrW3JNxZvgvSA4E=;
 b=VkACfUVsnNXemjU+uX5Lynf2NpV+6DaRFaR1LA2f7GD9ssbMYbdt2WtS5tlaUxaGYmPz
 hJNOjfOXdSCnFCCME7CybmdCkoiVkjDnb1zkomU7IeU1GLAwXrJH/zQEpUe7Mkxhcvtbe
 HNKsAfzg6EcAk/WyesY1aLvp6fimmr6/Wav1JUHoudlLtPyJRP33zF/LnXNqrExMyWMnt
 YhpMgRNc0OKp/vfzaLdgyi4ZM25nw0FKtF+5Y5GqNJCCbqEcimb1ONzoOrhXYLka3ZY4S
 WHz5hVjWPXurc/vb7KljveQF7Ji+NHuJ0+hVJ4i0zkTnUAAkgTWP9MHCHrPEAnMeC1A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=cCLFuM8h; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=cCLFuM8h
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B00374052C
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 08:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLzQk4HF0z1//CkXUkXiTu+Q9Zk40O+F/rUPQQvmLk7q+jOL++ZvAhjWSyBUriL7LK8LjQyn2BfP7ZBsBAS4P3bGJ0MVcHmNKH+JG55RvL1k+z3mX6lkF7XMxkJE04dPL/t8jz7uo1upU8IYIUpYWGif6ZrjMKm3JE1tfKUcTdQMggNczumYutI101Nss034+PqCndw8eBv/zvcT0wK0CHwyvaKOCchxtJF+UsSmr8uvZ4cw2y77363/iAUtyKihKqo2eune/b/fihA2ucaumeEE6HbHfAImyEGzMz5Q1V30NMvzwxVdyDUXPkFDWvecBWgghDnnqLoVFx+/b/bx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILdf/69ofWf52Kr1Tdp7oMoELDAtYrW3JNxZvgvSA4E=;
 b=q2ITcGMNgoKmCGsSwHbtHAMMJPCZHGmwch+fPCfizYt12Zxasl4T7Q2oB2uH2z2M10rd9bq0knz+jtGufWRGCkw1AYGodL1aEzV1l2lcxroCxactzDIPMhMaoZpBhhhMsSYWcGjV+EVxEgbG8WGR+jDfmxXiaFFy2T2ukRn0vf30JlWtFFqtBbNE+qXijIBuyIeQGgK0Sl6fKgMXB8L45C2vnqO5LZCPdn1tWpl+uF8DP1Hsm/rPiEu34qP7SWaiYK9xJ3OqIVH0BOF4eSrqKetxfUngKkITdRH6XVE3PdQZS5/k3zXPIJFzeEYi6Oj4rn+u16p1XImHmAoFIsrlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILdf/69ofWf52Kr1Tdp7oMoELDAtYrW3JNxZvgvSA4E=;
 b=cCLFuM8hRUl8PrO/ml+dA4kvgDzKBIG52/RfQ8H/lcgbbF8CRL3I4yqd9emldA9HNfB7hLnxGOhjE2bn9pV8XLfA0EIz1rRWGsNB5OqrwBck5ZBh7s5Xvm8ceMe8JzvOm7O1jJECJeDCbDeFtTuy61OMq7wjHt0x2u7J3TjMFDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by BESPR10MB412733.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:12d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 08:24:46 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 08:24:46 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org,  Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 2/4] optee_ta_avb.h: add
 TA_AVB_CMD_READ_PERSIST_VALUE2 define
In-Reply-To: <87cxup9p0f.fsf@prevas.dk>
Organization: Prevas
References: <20260903212215.2331118-1-ravi@prevas.dk>
 <20260903212215.2331118-3-ravi@prevas.dk> <87a4pttgch.fsf@kernel.org>
 <87cxup9p0f.fsf@prevas.dk>
Date: Wed, 16 Sep 2026 10:24:44 +0200
Message-ID: <871pattxgz.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|BESPR10MB412733:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d961fc-8c46-405d-5cd7-08df13cbf76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R66wwVyomOf09PIUO27Y2KTbyGOTFxB7fKueVSQUBJ7EvAZ6s/GkAqqvW3jmxJIQanLFqcvUCv+lR2eNWoDgm/Lllw9e275jaz5jiu9pnlvf7E8yUivLOOYp5D4sM/hxN9P/tK7hLPHipW5ChiVWqj5HGEEJ2c5IQhk9A7+GipSNN9cGAjuO9jr7jVZM18pdOvHABngmnxkDbdjBBPYkfC2qT6SKdcra1C3VKdMAl4WDJYYleMVNz1RA1a4mYEBBu1GcZYabTqNI6T4rq6+TjS9WZu5KrPb2Lwf0Qhc4gnop4dsay95avJcHyxdE0lLKydoU/4jNEHsku0h0UqdK+h9UieYq6pK/bryttwE1xDTmnsdJAMuUCqYrWSOiUikaRMSp7NNdJ6PQQYZ/ecGLbZGacpglbd08FDOiIrtc6+hE4489rh1n9XzjrpcPM10bxqSJI+iecqw2ZaRILv9JxejdY/DIy/c97wEdgsXHbue8GAgI87yITTwDeqmjAK6Hv66o3Uer/v3+Tp1vxKfC8ithj2C3HxXE4ZQUe7BduqzC1BAy+VGFnOXQpQmRGBjr0WyuDI9E35zROhkJOTBu/nVWCkX+xNzwgwllurfgMQgRMu1at2uFBK12dqgFbrM9qeW/Rmu8DXXrsrrb/7V/EJ5eeuisfbCzTGmbEffUGa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b1Iiwa2splDtKt5UDmwjW7euJvWYAnz/3NXm+5DYKinlA8mtd4xNxqkgSoA5?=
 =?us-ascii?Q?TBVKqek9IfhpAf/m8PC/eg8s7BMN/1Vf2Z1/Spbil5uj55EVyLLFIEcTZIXI?=
 =?us-ascii?Q?6kZzUVoyzU8ghTIA5KFmnd3bvbmn1tPiozK43bBGgx8im2vRIIGY02sghhu6?=
 =?us-ascii?Q?+6axq3hCVyVQ4Cf2+F6BJUxlLZ9lwUb1xn9xOwj+1ZuSGPZaitQPRCum4Qm/?=
 =?us-ascii?Q?24OCkZeORrZ+9ghB8qSbhsPM4b1xo/oiJrTmVNJJad1ZQURjUDnjd5oieiWf?=
 =?us-ascii?Q?GMZLCsVx++WqLaMgtk43CPRTKQ/b/OFwgWw1d4t3hNjol3a16hqi1I1PPv2G?=
 =?us-ascii?Q?Cjv6lOC20NXcS0SE5U+SaqpeFgo2yVAK24yjbsuueeF5XBkKO090LnVaL+pi?=
 =?us-ascii?Q?6tV/GYBqGkKW4U5Ie566fQfUwWp9y5eK538S7GcNSa1c5myqf40Ou9cnJGlt?=
 =?us-ascii?Q?H0+DNUMXaol63lUL9a4keFzisrx+q5JoCJiVOiaD2T6Z9ny0rPIdFPz1jcmo?=
 =?us-ascii?Q?w9ky3PbWilaze3JwnIgHuh/AV/OlElk3/ejqk/J/F8sJx40R1sjy5FPbJWn0?=
 =?us-ascii?Q?26yKqcp9YMngDcT+S0sj1P7Y2BBXVh0jP8RHd0bD5Kg1EVaiNvkfD0nxbnde?=
 =?us-ascii?Q?gMbpr7YgOyhedbOlKHaGvlqX1Qdh5JcnVnDJthpX/nxcnix+4SI2OEe+H87s?=
 =?us-ascii?Q?+79NE5ENkaAcZ++5baK3DokhZvIXHjV19/nGBNfeZtbbzew1uzMss4X0S8ga?=
 =?us-ascii?Q?MPPNPjYA7n57vG/GW6KcyNDrJA7LpcT65/1VM45lc6n3I0n9zkJBhnwv9meE?=
 =?us-ascii?Q?dsR3pJ06Oaph+pmjGNbPEPnArtRer1cK2S2VeUIMIb2YONMSWc2BQgzkTdnH?=
 =?us-ascii?Q?y19SJ+VZUfE0SAVl82Yo+BeHsJX/+qP39xThJyfFDjcSvkFc3QmueutHbgEZ?=
 =?us-ascii?Q?atvVJ3xvv6iNmgkv4odMmn5BQRAtrruNrKKYdgcdarWs+3qioQr3DLNy4Y6a?=
 =?us-ascii?Q?1FMrVsf4CwjkA0ki3qGPKdBkSqOubn8WWbf5gywt0lOuFSLxQc7VCqtyC7+7?=
 =?us-ascii?Q?GElo6+2ZwcDX37FZcN+xj/gsQLa1EnMdR97MGWxBg2E0mRr3/WVteYnXBsSZ?=
 =?us-ascii?Q?PD6ZS2Fhl+oP0IghK7XNjDa6y50mzW96w8RgjaCFulVMYijFB1lqWgjUIVzX?=
 =?us-ascii?Q?n78GIcXil8s6T5f+JEyeYvdrspyddNMYU+UBnmzbJl0UQAbKYSYWs+KdX7p5?=
 =?us-ascii?Q?u4CbaP2jR06WuDlwHmvS2rp5TMRV9eF54fs4AedQVWatOCOqmwgl1N2NNZkk?=
 =?us-ascii?Q?EH6T5d03HhhqQyGVm8hHaYOqgjYzGlc90vv1uLMso72d2uH1oEC7uhEOOJ3O?=
 =?us-ascii?Q?YLF/wyj/5w/8mp/WF27rBEsWHVKG2FmgxNH/vXhuHK26O11r+1EeAOQNY0sY?=
 =?us-ascii?Q?o/mu4P/EItCN2HmY+NHlKcfMEIiuaZtYdx9qBGleTBNkKpW7ZLgwzgAPvVRh?=
 =?us-ascii?Q?1R1TGb5/sAN13ReCZJM+YCLUV1EoK8wDQIId8+/cZHO8sMMgH9fp9GbS29gK?=
 =?us-ascii?Q?4gXzX6HX8DJ0ca9AO/l25HwQXhoICLJl9Ae29F9X0YF+vsGzBW3jHidtHbvk?=
 =?us-ascii?Q?je12ZJwJFdSIFt0C5aVigLXzCxDeCyb2sgynN3w+AcruWArENHaFXI+jDu+n?=
 =?us-ascii?Q?+cDYUJv6RvEP30Z6vZwD7yx1blBwboPLANdU/bmgPUvemWb0ty1UTpvfRLed?=
 =?us-ascii?Q?QaoL6LIpmTpY8MgqIOGMZ8m6SzRKfzI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d961fc-8c46-405d-5cd7-08df13cbf76a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:24:46.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLeiugz/b6wBhd5mGiAxiyxdWIuY/dD6sGggBXTV4jy1e1CDrx2Bsxd4n1Ur8z4OJxr8uV5tuqjNCd/rsDpQ414wObYvX/eChDVNUe8M2kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB412733
X-Mailman-Approved-At: Wed, 16 Sep 2026 09:56:11 +0000
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

On Mon, Sep 07 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:

> On Mon, Sep 07 2026, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>
>> Hi Rasmus,
>>
>> Thank you for the patch.
>>
>> On Thu, Sep 03, 2026 at 23:22, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>>> Add the new TA_AVB_CMD_READ_PERSIST_VALUE2 definition, and synchronize
>>> the comment for the existing TA_AVB_CMD_READ_PERSIST_VALUE with
>>> optee-os' ta/avb/include/ta_avb.h.
>>>
>>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>
>> I see that this is not yet merged here:
>> https://github.com/OP-TEE/optee_os/pull/7959
>>
>> I hope there won't be any other changes in optee_os, otherwise we will
>> have to re-update here again.
>
> Indeed. I had hoped/assumed that since Jens gave his Reviewed-by it
> would be merged soonish. I'll give it a few more days, then ping to see
> if there's more I need to do.

The optee_os side of this is now merged.

Rasmus
