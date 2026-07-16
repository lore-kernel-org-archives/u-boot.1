Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1857EC4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 07:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BF784C03;
	Thu, 16 Jul 2026 09:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="cUcJP8d7";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cUcJP8d7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A58F84C2A; Thu, 16 Jul 2026 09:57:51 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5A984A3A
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 09:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JtUJXT3oVTomkFrShZUlyBwCFbqphizDFU2Qqz6VDOmBoY7dqxglZPiKXVc/G1jX3TzzmxnbpIieqD953Vtb/Mv/u+v9pSXHhyQZhbx0XbdO9GIpId3Ywd32UtJYVE2sLhbVAxujwJrBlChItrcMPOuk84ExwnAYPzEmlD842kS5RGC1C+QM6oAKuuiF6PRPHBAxZ5DVN42aVbw1Sc0vY7rewnHoEszByMn+DiKZJyJbJuxa3XSij6k+mS1ZhbUVdlxrDnw8yx5Q4uwB8XLlzv854bS89ZdXxpSRjVw+18U2s0TbiDQPx05isDVNCk+ZlL8U6hyrz/foiRVhJAwQDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYouxr/pgwsMH2qKCdDPi3AYlEonuoksWe1LvNa6kOQ=;
 b=uMAQ6cfiVh1uIDKyzMJacZQSDE2CQT48KvBOpBF17FcyGygwqCSYeDOTwQveLzsNyxTKTx3PFpj0FGP39ageYG92EGnjRmNLpo/6jNuWplG+Yye97nKqx/42EMTYyzs3NJzCswBksknGX1iKicIquOC4tA1YHKErCfx/NaFCiEztdKKdQk8vHg1CUphXqR4SB2QT4cIDdNGJH5OqsvVH+Y4wTvQa533IczyifGQ2NI3C0FHozeoY7W+/sDRQeC4jGarnQdTl0hJ9VnTmqSu67hMX8sR8mbuoPGKAhfBMUZtNASdprBeu9eR3qZ3rbUkbs/3Lgry2YeMI68x6yPJqmQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mediatek.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYouxr/pgwsMH2qKCdDPi3AYlEonuoksWe1LvNa6kOQ=;
 b=cUcJP8d7G9TPJv4waCaQnkhshBzO9XpTDHC2q6xh9TRAFaufIlLeFBcjrn6goPRrZMUW8GC2hJfZanTZpH2gWN9z8Ctt65ixbAcTvVHARnrACwsrLB9j2gCDzFSYi5PkN/QiYLhzjvJx70TmiabSl5HzkVz1+xP7f8TQW6m1lEg=
Received: from AS9PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:20b:488::30)
 by DBBPR08MB10651.eurprd08.prod.outlook.com (2603:10a6:10:53b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 07:57:40 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:488:cafe::78) by AS9PR05CA0012.outlook.office365.com
 (2603:10a6:20b:488::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 07:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Thu, 16 Jul 2026 07:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBf92CUv4r6zcJjo3Zru0RScXsd0mMxkazI1DMf1ekAZ6ZGhSQg6Chs32hcwB5Y1MSimeIqGD4E0LNGI7pEqI7GafpNfZN6NK0Jlgxg3wJSJP8Ycdu0Uwn62eEtEw1nQmfby3GLPehZa8GXudkK+FD9XlCjpd6zJunqGEE2rX3918QA79VzojgMCJR9A85j8AoOKvKU+qi6EnJb0nqstZ5vgujScdN1rR1cXs1Mr6PjQJEsFMSVWk6dr/IuIhZJ7r36lnFmvPwHA6xkso5RnwZlbSuKbb7W60fub1WbaGvOzWPQ8Vwo8az4r8L9bP5N7WNgB0XH1bZ+Idx7DBfzRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYouxr/pgwsMH2qKCdDPi3AYlEonuoksWe1LvNa6kOQ=;
 b=E60S+Zj0mZKnhh+hXJKEs8YFfAFggD4eR5Tq3MWU6u3LAejwOGgBShyUh3ncIAzMH4lWFxnPFtx76aF+KKXF7wRuHhrhusKtUqmOlYlxaoXjQOIk9IMqJ+zyYyBW9Qe+fWIGq5wfgNuqyMSfgeqb7TLTf7cdf3HdO9TccCTaSu2wyq5qXpRvWUHqzEH9UbPowfBKPvREXiG8BK/d3PzqhXfLxsM18xJ9YCCzLNXhW8KjVbf0n17yEkBi4Jfew15H6ylXZHMoSYEon19+P6JHgx+ZNCJ58VxjxtSj6yGvFdIPDe1x7yN26OIMDsiUCdqu+FFqjjeoqWfUjlXSZiqj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYouxr/pgwsMH2qKCdDPi3AYlEonuoksWe1LvNa6kOQ=;
 b=cUcJP8d7G9TPJv4waCaQnkhshBzO9XpTDHC2q6xh9TRAFaufIlLeFBcjrn6goPRrZMUW8GC2hJfZanTZpH2gWN9z8Ctt65ixbAcTvVHARnrACwsrLB9j2gCDzFSYi5PkN/QiYLhzjvJx70TmiabSl5HzkVz1+xP7f8TQW6m1lEg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB10475.eurprd08.prod.outlook.com
 (2603:10a6:150:152::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 07:56:32 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.016; Thu, 16 Jul 2026
 07:56:32 +0000
Message-ID: <c62bd0e1-3a4b-4dc2-ac46-d310a7d53c19@arm.com>
Date: Thu, 16 Jul 2026 09:56:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: handle chained pbufs in transmit path
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd@arm.com
References: <20260715084236.172815-1-weijie.gao@mediatek.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260715084236.172815-1-weijie.gao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0189.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB10475:EE_|AM4PEPF00027A60:EE_|DBBPR08MB10651:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a75ff0-443e-40bf-02ad-08dee30fe82c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info-Original: P+3cHquom/xvrYWvMnrGnsv7GgMfxrATjx9wUjshtTPGQYI1uz2h1CXgYzXXQyMf81E4BdyW2Cd/OAoUAVPVLgDYUatnKPQoOu17f+px/4mDwlfuGlEQjvbFxyPn0hH6dMbck1NAit0G/RjXZVKGuQwdJ7dCK7enZFAzgkvbl3XHTqVHRUS3LKQjXQu27dK8Cp/vDKp6tNMqY3vYmLSjYV4FHZt1FBqVB8dOydxElq/Z5ft1vUVJ3v64lt/Mng32rf9Jgw1cZww/mTO1NrxJH7DwijLe/TA7s/XZTQquCuPvHn8PGpLeZZb918ETUDXl/PDOuH34bnN5MHibkyPOOu6t2kg+OTrTsP3Pt2la6BV8beCTpmY9G6hG5ekko6e4hPVbp89+MhQgsqeA73LomJZ77+i9U9zxtG9oERJHiHNOZ7hxSmtma0TvWwgtM7gpWsIft+UFGqVqYTKwVlH+4tLufspNQ9X48/2REI3yLY8l5z5pXsV28S3FCrb4pG3dkVzqogwtx0s339Wc8bMI6iBN8jnRaIn+QY2dWFmO1mNhJX+oeldMQsnDQN6Pj3jSjPQSRnyeobwjGKLwXXxuoAQ0N5PaeVOEeXbKVEF1AO/7ps/P3n2gLh6gSDoge1BZeOZsUo5qGOmV6W95aUU1W2ch924upX6yusssLEl0UAY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: DhgDqJbkb9hpCndH6GEesc4qhIStPn7xFj6SN/j3j6FXUa3utFx0nbj+OPuKBHwmn+Ip8fZCvTp3lrHiMMNNGzf9hC3EhxhAd8pPzg4BEzik+jmd+pYBx/1govXHckrNdChRjXFrwfSkeLkHfPc0U9QUrmv3H9F8rR7eQBLfxsOvO4gBidlrw6SV+O6IBk13xcWBVwhA8Vr8909kVPgLJJiOgs5zeEVhzEMJKiigiP2kVKVy9GeZCQo0ZhrIe3TqHAFfUe1iGkY257vQ3ta7jLYYL5uvHvA6rID6YLofSLz3nKpQSm9uI4/S6kn4LDYcB+xf2h3BLnzhLVCFebtzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10475
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a004019a-4d43-4eba-ef35-08dee30fc030
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|35042699022|14060799003|36860700016|376014|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hbBFmqod7eQ7Yi4LLFGqceeq1IqZ+eFc7BC2kHEskksrvEOGdrvML/XuVF9aSa9pyKf2Hu+YYfHfjWU5YMivwDu9jaFOUQ3shbOuLrfa7TJcL5GoGPfFeGUF9jRmMpYKhoaNaEOD5OqXwoOGGYc89uDbxm/UAQRJ8g8L1UmEVyxokVSRupnjDwRwICHAHaM6ki3NuCzT7qNNNDmYdwgVhR5DVmGUo7FaL1mezJwmRB5MvqGH7zGUS/GSXurizDc7jts+KRyAbFgkgH5HAwQmcoWyMsiTV7SwFp+8izEyi3Hinpn030QLkEp+vXUSMvmjZhVF7Y+lFQfMgMiq5K/eAPLfu1ma1CUkmZOHS5GUjfUfD19DgOD6XtKlggbOyzH+yDwkzXcTn0kmJFmlHZ6DqE19dqaOxtft5w+pHnOgf1L/rk3Jj070nXSX2fD+qovr+3JWcMA1WCJLVNm3eFqQge6BzFKxdN1pdLSgT+PWBOEpzl0obDOjBH3wGn5S3Tb6MOJbXTTvEE/+WjRSOgclHbFnq8fmv2HvuB3eBBz/JLd8xy1IsRAN8/7k+jcg31chqY4pEw+u8Ui/ga5IRplO305I+idzIo4VgPo+UhsO4kViynpcpbGrjfhbG9fNFL2gueK4YwhGjnfQwzc4tKyqG8qSozM+lj3V1vLsk+jrI/9HZsGN7kLZ7xdnUOhgU8o/7PqUC+h4lJyw92j5/ufkTg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(35042699022)(14060799003)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dxlWeDY6JRnf0PeonfgD5S8Flk72Q6uBMzLW4puFhfSBcPz8+j08tdx7m+6ZN6tdSNHUT30MJR6GoNiNIWNj4VKPVWAZ2eV0tWbo8dUdxJxDwo4qliePZmMjpKu1l+5lKuPsHCaliAOXxNK+qeZo8RSUKVGMN9YQRLZUEK9Cbf4xogwCzr8FOp4DRo1yV07Ewyg/AZeK4HRW7WXc0rufEA2qYuqz63RmkVIheSHbJa+7vRjjFNQc/t4Ho8qXJNyUhy+fQZolbJZRW2fV36Xqsv1qffk0RlDiNGvIqtQ+QckcPcnjFpEtNT6mP2OPO+JNsw/pwtJRZnqvU+n49rV64Cf/LdzFv8aGOGEBFYdPdNNPLCpR4WNL2Pj+dtYo63IuGVYFIs2QMJKGapTo0YhAA5NzRgl6YI34EJI505HN40mxYKSvnB9mTkp+4Bokzzb3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:57:39.1563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a75ff0-443e-40bf-02ad-08dee30fe82c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10651
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 15/07/2026 10:42, Weijie Gao wrote:
> LwIP may pass a packet to the netif linkoutput callback as a chain
> of pbufs. In this case, p->len only describes the length of the
> first pbuf, while p->tot_len describes the length of the whole
> packet.
> 
> The current transmit path only sends the first pbuf. This can
> truncate packets whose headers have already been generated for the
> full packet length, resulting in malformed frames on the wire.
> For example, the IP header may record a larger total length than the
> actual Ethernet frame length.
> 
> Assemble chained pbufs into one aligned contiguous buffer before
> passing the packet to the Ethernet driver.
> 
> Fixes: 98ad145db61a (net: lwip: add DHCP support and dhcp commmand)
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Good catch! That was a big oversight :-/ thanks for the fix.

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

-- 
Jerome
