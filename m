Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA316C982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B68D80D18;
	Mon, 21 Sep 2026 12:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uSN0KOfs_qfR; Mon, 21 Sep 2026 12:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C530680CFE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789995263;
	b=Wep54QZzUqpp35/FBxWjXETi3mLJQ/CrCMUGlDuizmAamAPRHeBpL1ccRkUqZjOzTT7V
	 WVc/QTQvhCU+czi92gQlAoIxmyhlhcrtGpoGvL4VMl0Oid9Jx6p1zeeO59N16laAYnCQh
	 NzDfEVJPgb1UcZ7pUB9wzJBy0rP5ZSmEBAq15zMP6pGKPluPlQmCrk1vs/6+pB61+ifQT
	 bymOX6Mwz8ZY4RFf1esiNPmIbJ8xRizndV4loLtXFfS+m079TzfR/kMoIQkPrIasvO3cg
	 PEzUTKYnShifjwqoU4iN7pp3mb13yJo5CzMaLzC0GnG6mcLzP4K9wZUZFjjoVscYIoA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dMHvsU/OnoVpc4jJfRK1J2alKJrQdjyVbRQ54EzQXf0=;
	b=cEchMlXw4Ce6g1qoHXKzJU9ygq1pLQrsXE5bSMWGWW1BZat8lxX8BFRUPeV2xoW1+U6F
	 i6yrBImcOrwaNHlQj63QQNIGABLrt6gOYNkftmmsu+MbR4qxXxW4ih+l+oSmrO0bTY0k3
	 q/Y3u5CSAXViW8rx6pZdUmcMpypJ8htR113VW+0SmPMB3VlZA61iRekKnZSEUSgkb9+HC
	 dItn8cXQ+w4jeuZMfHy3gJl+UwiD6nX4oZLHU9DUONyLHRGX3TY+1DcumKiAmlk+8aqXp
	 xlkQTXXIqLLAML504utdoe7JYe+dytncna3QwHbc0q/9hr3jhZba2vlEYcc4HPFz1Bw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995262;
	bh=dMHvsU/OnoVpc4jJfRK1J2alKJrQdjyVbRQ54EzQXf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=06OLAe0wTzapbf2IH0/x07OqYPx2eexP3NaZ0c6+3lQO6ZQ8kDUJzdREm1vQ/h+Sm
	 bo8/vbRfodIwpk4WE7nNgJ2eWww1IiZCwVxEFaw+MKpKA/N1c4w+XOUg+c5Ievq1CY
	 r18TvG+7EGz7mHqGiY11fOrt5nFsUXVA17sD1qP1IPqye8irFx4W+bFgreUizMeGFG
	 Bg/HCdfN0QxpvwLqnT+I23BVF3meGdU6BtovJ4DFi073bRRYLCGwGK92FNPJMdWKJV
	 I0Ym4bl0JVoAgEK8EvXJbh0NntkZ7pRWmUICPer5MFOiZClPzTOlsgKuzOibWguZhh
	 0FsVv5Xe9LbPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C530680CFE;
	Mon, 21 Sep 2026 12:54:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A5FA224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C0BA40D19
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b87c2UYwlWUb for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 03:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 045A840AA4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c000::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789962653;
 b=rfGy/swI44wSOLa5advKfeMtX8+wsrcdr42rhb7DFh3Ye8Huc9RTCUgxaRdubVDaEThC
 XaPhPVhmd9SXhYD9DFSZ1YNVJL7yv9iOaCU+t4WAfSCaq9GKmwFJ56bFEOXdp2lC73gnV
 Vz2L42pH99RQ2IT4fi5uSLH56FRVU2zD4j8/YjNvFy8hKb7BoYP/wnxZQS5ZmJoUHcCh+
 zJm1wRUnBcDkME1U/iWKF1UXbnbGrvS614kYyXHQmNu/EsHsaw83S0tF1swz17FHyi8Jy
 dTuiVbFe0saaCli/7sKmrVC392wY95YJHV6Ug22IrRNaidjQRKXqp7AVhc7jtGSm6Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789962653;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=dMHvsU/OnoVpc4jJfRK1J2alKJrQdjyVbRQ54EzQXf0=;
 b=EiR7kZIDTaU566WYBPumgnXOo0J12lclbKQEa3g8DxoDmEMTKuY6mJqgegFRXixOVKAa
 1R1u1JvfRfLBoD7Su8sdRobJPriNZKTr6DVtG7kIYP510ss75Lrohvcy29eb1MPeYEThE
 vrB01OM9IxRiSGKpgS0NS6pm8EIQ77pM3O0b/eh7TB9J+x9xewU1W7ck7TVvR9tRmsBzy
 SOFghHNqWxjeFHUPYW2QyD9M0UuUq370ekwDvPoM2KYDpS/kNyCeNFpN23di7WlYAfouJ
 9oSPZtObYbBR6U1qDXD4LxUfSUdxVH6Nz9JnNg6y3tL5hHDa7nqjKPY4DvGGHCOfqWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=F20X6pKk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c000::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=F20X6pKk
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 045A840AA4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 03:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBpAxP6FWN0Y63of1xkVQ37jz/2pzYA6vXY9SKVQK+YFR4q321ZrgQvbm62qe23wSVcTHm3eAhUedlbx7V3hgL7WwuNCUptEBdTmqkD35F6hf2aXXUnqi94f1cOrNp5Btz/MdtO2dsqd/aNV4X5fGyrWTdUBC2aoG/GxWHEmOwWszl1Cm6rwI0fGOlWy8bQYWXEYU/gTEdLpP2KL0ug6K3rVTnZHOeXNP/5t2OkrDVzI/3dWWGGQtd502jaVRTDN5QnoXhZP40HtE+xtaVHyDP5wIy5jY1sBcYqrQF03XNrAoX6qJAU8TPzpkUqxkoikmq+D3tuirKIXiRwziXRY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMHvsU/OnoVpc4jJfRK1J2alKJrQdjyVbRQ54EzQXf0=;
 b=IRX/XU0frxCEU4l1E9XOymDUrH4JUcD5MRJMtaKLCBpkxyrkL+yvP7I+ePzwb3jIW2NWghFyTjyutDfWzDgYzLP4UctdVlDdquewQ8d+n36iCg6eFnCXr5j+db++Eo3WDnrj+g6gbhE0yvXDe2+MeaFwK1BPB+B/3D8faiEzsegfFKddeIe5Ry5fRbzyz7F70AdUJ+ATbHaM9hMVC+DXhIzpb2DDxPS6rQb9vO1nWKKTl99mG6OZ3lV3k5pf4ZVQJFGuwZwEL3YcaTVYwGuhJ+FCxNuyNbS66UWLCslV1U7NZjcjbqj1EWmDRzTcVC+FCt/fI7leUBA6QLRHHGeI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMHvsU/OnoVpc4jJfRK1J2alKJrQdjyVbRQ54EzQXf0=;
 b=F20X6pKkQmzEiVVMCMtFn5fY/SeD5XnLU4qwtO7vrq8VYg1CmzA71SrDTqkbZVV84V5L4KWTipVbxt8FDh5TBCkmVL2tCcidSNX1NHJ+x9b1B4bYnUcO6Ss5am6oOIWCikY4JlR72/5R3BFYsvQLlP+OyWexjNb8az5XWr0RaSxH2ZemR6LimwtF9fd5WKij7d6S5yVAZneRJ0qDU9S/oCqK4jydXLEP6/GBcm82NmaOMYBNR6FtvCPab0LeRJ0/9ps/wKViKcGldIAH9abpt2WKRkOSbiCh2ANef9nretpYsTk+t7rpw1aIQ2Upc6MR2AhTlvrgxmldj4s6ldSYDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by MN2PR03MB5312.namprd03.prod.outlook.com (2603:10b6:208:1e9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 03:50:47 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 03:50:47 +0000
Message-ID: <c97dd7b2-4375-4352-86ab-8870a1dfea4d@altera.com>
Date: Mon, 21 Sep 2026 11:50:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mmc: sdhci-cadence6: configure PHY control register
 per speed mode
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <15e724cc7260e5f280ccced5b453b2978490df79.1787710268.git.tze.yee.ng@altera.com>
 <ec129b92-3fb2-4f1b-bc9d-2a901163fd76@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <ec129b92-3fb2-4f1b-bc9d-2a901163fd76@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|MN2PR03MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: e878ca11-0bb5-417d-f639-08df179384c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|3023799007|10067099003|11063799006|4143699003|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dyGejMztSdF+QPrPCf+h1Wpveb6rMXGToJW5Ms01MSNWA3KXUE0rCX2psS9svDUsVa5ynlqMKA0AQ0zY65hgSMePu0JZEuHl5z/sd5uXF7HtX6XHEQ+SDRVr1JuGfjfA8PskXcKai0IW9Cs1To82TSojlMhmlqmiKZKyQAn+T3Y61hVQf2gzPKXyuxxx6nDFnUyivYv/aNI+jl1wDWE8nTB8K+ZR0qXBCaHmehdgQcC/MHb2ETlVt7kkeRntL5IHoMndH4t9OSyOLdMZ4kAExegyTOeLI6Vbb6SoeVJ0a/k1UtB4hKMPEe4T7UWtrY/0VUU6I1lPT9qqzrFum1gbYDYRMOXUrgOS1VHJXTAmPFxEt2ehwXS6y0QIOdGqwcyTfbkLozjFJV+hQKkr7EAMwSvjM1jJsIE3zIgutm+WjePAS7FZSIBWAJVx+b5x6RJlVUeedgUWzl+hjBpCfXFEwKf9iixph350iDE6pZvJy7PgSB7xu38e+m06/nlgU1IiRnAnW48qIj2OnnPKowHbxaJo+izOjyu3tD9HDS7JL/sIy+8BCiS/ArbTMdPCzeftf16+1bB4E9rGPimbxwaBCswCc2VY25bkSFtL01KbJoYBuxUKWl7DJLv/uz9PofXx8VZ8Rg06jNJ8owzhv35xkfYzAeXK5X8Xzh08Ht4g+VI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9ZeWZWNnNhS1VEQmRVTi82OVBCNEN6UnRUbVpUZ0lodS90UmQ0S2FwWVRk?=
 =?utf-8?B?bjlhUFVWSmtKbkpCVU9nOGdjY1AzT0EwVGdjYzVxUytLczk2QVpydi9iek1t?=
 =?utf-8?B?a0ZleGxyNDlmMExGcVRkdUliV1FKMndMRm9TS3FTVUh4YytmNGZ1alFNRGxp?=
 =?utf-8?B?VXdkR25ucW1UakRjbitFWjlURU5UOFpMemUzWjlFMXFKTS9uOUhja0JXL2dr?=
 =?utf-8?B?V0FDR2VtaDY0emZYTjVYSUVpTTYxOVhVaFNrdlJENStMb2doalFQYWRQdTgz?=
 =?utf-8?B?RmxiU0doMHdpOEt0OHhONkVWU1djb1JjbWxpdGpsUnFsSFlpQ0M0RDRqanQ0?=
 =?utf-8?B?b2FGT3pVS0VxTlVhMnJtUDY4dGlPYjhLelV2NjZjM3dpSElxTHBEeS9iVWNX?=
 =?utf-8?B?bEhrZDVRd3l1QjlwdlJRTlg5YVhuQ3F3SmgySmRTS0hjSGgzaGJlSXQzalpD?=
 =?utf-8?B?K2VYYUNqSjZCTGd3SldzUWJGL2dqUnJRQmhIajlKK1RBTm1oOEhXQ2JoZVl3?=
 =?utf-8?B?WkVxSTFkVVpPMWlpVmJNakdPVXVkTHZIM0lkSmkzK1o1ZHFjbjdwS3ZsK3FT?=
 =?utf-8?B?SE5DWHVwa09uR3R4VjljYlZCNTB2bnE2a283YkV5RVpibTVRK09DK21IOTY0?=
 =?utf-8?B?TXFsL3VURmltRmphZWd5R0NOYS8xSUNjTkN1MHQyLzNTbXlab3N6aElzSkVi?=
 =?utf-8?B?UmN0ZHdMZVYyWGxmcFcrS0lPRFhvcTZwZTA4ZWNqdWgxU1dDeVplMGJYS0lT?=
 =?utf-8?B?QmFSd3YrODVXeTVrVkZmKzROVjVzSndnZDY1WEh6NmlNQVJZSVppSzBBTEpw?=
 =?utf-8?B?WW9EcWtnWHkramdUUTN6ZDRtN0w2Z0l6Vm14SWtMUVRIU1EyWC80aFFaR1hD?=
 =?utf-8?B?T1JrSlZIZGZBNnpFODMvRXUvSjVkaldJR0tVdWk4SDF6WUUySVdMdWtSdDZT?=
 =?utf-8?B?SmhVOUVyWllNd0QwZnBPeE9WMllKMmNHb1VuVDk5SWxabnI4Y3lPMUFVQlNL?=
 =?utf-8?B?Vmo4dFVmNE5VTmJ3WHlzOWtRL2QrTTg1L0Zxd2cwaVo2bm1yWHFMMWlWaXY2?=
 =?utf-8?B?bTVFNXhHSjFKSldNWWltazNZOGJhUWxzL251YmhlRnhCZXZqMGx0bXJpcTFa?=
 =?utf-8?B?emZoWEpoOUdqYkdaeCtVYjE1T2hjM3lvdldnemZtY1E0d1R6ZndjbURreWpK?=
 =?utf-8?B?VHZwRHFkTXVRSzBpRUhOSkswTS9idjJsTWVJeEVRb2psSVNNSmxPTSs5NnJF?=
 =?utf-8?B?SWdhWXViNFJ5RVAwUXZOV05CUERLMTZtNDFLSjhrcWlRQVpaZVVLWmhLKzU1?=
 =?utf-8?B?R3FUNlJCTGlGWk5YUUl6UVdhUyswVWxyWXk0MEtXVTNjS2NNTkkzYk1mb1Fu?=
 =?utf-8?B?akFZL2FjalliSUx3SkxWVnZQRXFlaS95WEJvWGhneFpwQWY5M2wzbXRpeFdu?=
 =?utf-8?B?RFpLVFVPdy9hakxjZUxuUzFRRWtqSkpUZnVwWmpZMnFrODUrdllZT0NqdGk5?=
 =?utf-8?B?a3JRRC80bHMwK1VIZWpIVjB2aXp4UEdCK0tGRHFUL1pudDRxR1hZcVJFSFg4?=
 =?utf-8?B?d2MwR0N3ZElBTUJ0TU1oVFViTUFLWnRxcXY5bGdnTEd6ZFphcElLQ2lJeldy?=
 =?utf-8?B?WWRNaDlDMllnRjdCOGVEUkUyVTdad0ZqSWpWdjJBMDAvZzRFNDBGbXB3V3R5?=
 =?utf-8?B?NHJLUTJnMlhkWE9CTFlSdkZWcUtKMjNjNzJNN3dNOGRwdFBzYXQvK1pJM0dM?=
 =?utf-8?B?U1QwYkE5V09xaXpzanZXY3N3cnlMM0wrRWF6QjAwa0FQQUw4Q05Bc0Foa1Ny?=
 =?utf-8?B?NXR0LzVETWRQb3JCVjcrcThVYXJXam9uU2h6SElBUHdHWHNERDB5bTJydWVS?=
 =?utf-8?B?ODdvQThDK3JhOU04WTQva3pnMWg5NUE1Mnh5K2F5cllhVGJZWXpvaWh3SVBK?=
 =?utf-8?B?ZUdrNGZkUi9yc2RDdjE5NGNzWlV2QUF0UWN0b3NUMmdEeXZYaThPNHVJcUlO?=
 =?utf-8?B?NzA4RXg5R3VmckFNTmczZUtQYWVReFFCNklCR2p0VHZxb09QMGFNQmNGSG5R?=
 =?utf-8?B?aHgvVVlpQjVCMCtFTzZQTVVVckh6WDZHdkxBeWhkT1R0NkJiNGI4U3QycFor?=
 =?utf-8?B?WmZJeUovRE5vTzFHWml3dHNUY2srRytEMnZ2Ly9mSEUrWG5nUmZsNkdBZXd0?=
 =?utf-8?B?TFdEYkFqTjgyQURiWDFnaXV0Z2p4bGIyY0pNbW1aMUtMTTdnQnlNV3krUnZv?=
 =?utf-8?B?RmtWMnludllZMzd5TER0cnJtRXIzb2JSS3VqM0RPRTFsZG84enlWWlFnQnN0?=
 =?utf-8?B?WXg0eXJ2NDZNYlJmK2hxeEY0ZVc0U3JCaURRb0NRdUNkTkV6VWw2UT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e878ca11-0bb5-417d-f639-08df179384c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 03:50:46.9530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6n16MZOjXtSQGcLrfb1aP5uNwPZrgTKWfSTph2Km/aWqn2cQWzpCFgs3/9+vwG8Pfyceh9mkQOR/xXGzJmGLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5312
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:54:14 +0000
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



On 13/9/2026 5:06 am, Kathpalia, Tanmay wrote:
> Hi Tze,
> 
> On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> The PHY control register (0x2080) holds phony_dqs_timing (bits [9:4]),
>> which shifts the read-capture strobe relative to the data slices.
>>
>> Extend the per-mode PHY configuration arrays with a "cdns,phy-ctrl-*"
>> entry (default 0x41F0) and program register 0x2080 during PHY
>> adjustment. This lets each speed mode - and each board via device tree -
>> select an appropriate value.
>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
> 
> The PHY_CTRL default needs to be corrected. All six tables also use the
> same 0x41F0, so this is not actually per-mode.
> 
> Please fix the defaults.
> 
> Regards,
> Tanmay

Hi Tanmay,

0x41F0 is the PHY_CTRL (0x2080) reset value from the PHY spec. The 
driver never wrote this register before, so the PHY already ran at 
0x41F0 in every mode. Using it as the default in all six tables just 
preserves that (the write is a no-op unless overridden), while making 
the register tunable per mode/board via cdns,phy-ctrl-<mode> in DT, e.g. 
on Agilex5:

   013b:    cdns,phy-ctrl-emmc-ddr = <0x4010>;  (phony_dqs_timing = 1)
   modular: cdns,phy-ctrl-emmc-ddr = <0x4000>;  (phony_dqs_timing = 0)


So the defaults match only because the reset value is mode-independent;
the real tuning lives in DT. You're right that six bare 0x41F0 literals 
are misleading. For v3 I'll add a named constant 
(SDHCI_CDNS6_PHY_CTRL_REG_DEFAULT = 0x000041F0) for the default and 
reword the commit to say the register is made programmable with the 
reset value as default (no functional change), overridable per 
mode/board via DT.

Does that work for you, or did you expect distinct per-mode defaults? I
don't have validated per-mode values, that tuning is meant to live in DT.

Thanks,
Tze Yee

