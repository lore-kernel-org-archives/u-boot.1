Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C810F3DFD
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE00283E7A;
	Mon, 30 Mar 2026 16:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="gSF2+0LW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gSF2+0LW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE6A83F5B; Mon, 30 Mar 2026 16:27:11 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BA283D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DfelbbeHUQoFHN5142nK0lYu5LHkH27ozu14iaYkKv3ZUJrRhQ0VuFHn/m9sW2xzFEapzk7RL+v2B1jK81+Jsw3Sv18nNFScUxdG1FhiyUudsYQTg0oAFL9v77H+vDs0gqAVTgUCiEAZX7720HSXHa7xqjGzWUu/Gyl/576qxdf8LlgUPDDzalBZ2our4iHe85a0bBOpERwUNlE7VlZwWsPgDAI7qAkl/JnMLZfP6JIsaxY+sRoPIe20Q9D2+TvmF2p+DR5qnNQ7xzOCBqU10EI8q7nPydFwOHlLOUXkD3Q/5RLw3CATyX4TCLXuKKr2N4BaoSDQO24sJZDpRp/khQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqEULsiMdvq0urcbZhfCvM7gxocOoDVOYTqPLrcD1Ho=;
 b=WO+3gRcz5YT1eMOvzMzyj44KH5elKbbxbv3rTy39pGEZgqOuZAKsNwE7uW1dDcEgaaZ3OzUMUBvUMB4E3Zy0ssrmVUUvTciDeZezjx7GnHVn1R7JqNEKAkoEQ6SSf75byXyNi66GYAALnt0Z6cP+eLPg1EyzdBjPufyZVAuu9mZruEN9fQH9AIlwTGSp1vMUgiI0HEfH+ALhhb/Cm3aHQjZWOpJHPjXb8vfP7xN1pSegoaD2IZxtHerpDHDncCvi4TRL56CsjxM79QaQR4KqIU0cWpnF6nZXPapbed7apNcylS8J6w+40pUbWMirGjrwUjVurDbwBv5hoGzAmCKoeg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqEULsiMdvq0urcbZhfCvM7gxocOoDVOYTqPLrcD1Ho=;
 b=gSF2+0LWlWYZl70074SRMxbEpNqe3UqVe2lEnsE4xPb2A4vSAVZL3PmOqYmsIrhW4o3B//K9IZfVBQpwSRWYf9ED/bO3oqEfYrVcx41QcltNuOQbcgFBC4uYH7+F2HBzRM3FFZkSVz9cWQX+Jf421BWQGNJZSFEK+iItMGV5HBE=
Received: from AM8P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::16)
 by VI0PR08MB11408.eurprd08.prod.outlook.com (2603:10a6:800:302::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:27:06 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::57) by AM8P191CA0011.outlook.office365.com
 (2603:10a6:20b:21a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 14:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JposvrXFAgA1AKZ9M3pfjZ/84HDNKjuQT1EwkvrvZs13V+BFN+ORlSPjO0F+p2yU4JZK3YM4qUnNG9sIinarBCnBduqHT919EFFnpC1fmWJ8paJFvZnR1iaHfkPzkFytFhe19cr4+DmqWVaNb+BrXF67/SN65p8uZuS9J1s45fp8+2grSK8JfJFcayp8HrlQl19u6YdNa//RIfZJmu9LFaU1cKNl5iOPnQhlRGwEIRCuuorF4o+ef1sz8QajwETyJz8Hm4TnnojCf/Cyg8QTrpFqrUswoN12KtUq+VY3sxDrKQh+I+MRqaddE3CT2qoRnNaHHP+WaMbnLPsR2TeJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqEULsiMdvq0urcbZhfCvM7gxocOoDVOYTqPLrcD1Ho=;
 b=sbUGM30luk0ryhdjU/1TWtlzLJEP/EqO2V1KQy2glLbjbj3ygCZs5BiRDWpcYa1NImElZ95m8W1BbvgeMGyssqpEtLQwp/tind33/lk8wDIhS8ARw9UaOEhM9l83AjL2zXeZJzz6AMaTJY4gyPM0pc3c+xRdwsMWttNB8l1m9e2v6NdwP8qL7nyro2f7ISkT3oUrzD8P39zRtpdPgofVDxEQSyXa750zHq+DRfXlNJ3Hs/+ZM/rv/9V0MlfzsKR4xRua5PetcxkXRfxbgikD6cv99TFefUpHgtV4yzAGkXDTDfoErrIL3Yse/3XpuG6IDuTA7jP5CWkxlYe/+PbVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqEULsiMdvq0urcbZhfCvM7gxocOoDVOYTqPLrcD1Ho=;
 b=gSF2+0LWlWYZl70074SRMxbEpNqe3UqVe2lEnsE4xPb2A4vSAVZL3PmOqYmsIrhW4o3B//K9IZfVBQpwSRWYf9ED/bO3oqEfYrVcx41QcltNuOQbcgFBC4uYH7+F2HBzRM3FFZkSVz9cWQX+Jf421BWQGNJZSFEK+iItMGV5HBE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB11392.eurprd08.prod.outlook.com
 (2603:10a6:102:50d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:26:03 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:26:03 +0000
Message-ID: <856eea5e-69a4-4613-b6ad-8f3119085bc9@arm.com>
Date: Mon, 30 Mar 2026 16:26:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Correct dependencies for HIFEMAC_ETH
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20260323195300.2363561-1-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260323195300.2363561-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR3P189CA0074.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB11392:EE_|AM4PEPF00027A64:EE_|VI0PR08MB11408:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf223d3-c185-4255-f527-08de8e686b67
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: e9x0CgWyrNXAR5N6MVxWeoJW6YyQ8EuyD2lxWvQlQQ1MJTjrBYL0aYxSqd6Nr3iLU5Nb9EOUt4pLoRtBmk7x8XgANefATl7nZxndI5X1j9bGu4I2FvGGhKWRV4lrvP4WgXOKjMY8d8GMdMddVvBL+CZG6+H4FKKuPWonCcJnIJHL3e6qAv2kINXcbYkk/L7IJDVVgQg8rlIQ5pY++cutxC4YYTnTA2qcbFUvR2PwMsw1AUlnvNcz5iFY7GXgodPVMcOUSFkaJsUEOgiD9cXGHtuq74Pn+n4ZKbD424b/7yv/JB4rwA0EaWjJFCmazA2+1vNy+su+KO6VRHCazC9xn7xYs70pUUBMlqpgxrzu2HRgwb5HwbWC9a7Bge/xjr/3ZwNIxpZDgVuWS20W857HQC1ostm7bPFS5yXairhfBchbcp7HcVplFn0m2WlSZy5N6iqn2e4BapNz0vVLkA77gGkF0OZjdJ5cuv4hR4PQtX4tiff4DbNPGHnBFdl/Er8sFyU7Qd4tRMbH6UPg6ahphkQAjFYm1/JC1KVEtjle6z2FRCIwsljHr/e5oK3hUOgw3xubboHy2E3JMi1aTEHMksWUgPVJzj1u2twBBJ0r5n5aVsRaJzY5cQPjFMwMTLokF1iJwGYbMAn97jWTBuPAG5Se7yrKh3k/ce0U+jU2qxnq8T3m+GBwx7881matXyPYxOxAte/JH1NoB4lu4aVUGZEzSZ8ASbqt4UgsawIbUGA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YR+kfVqZdeGduuBtMWdKbwrKXjuabpc/lHePd7fMa5zj4Cm2w/V+hy9oqJ8aa+r0bPSeEcuOj6gNWr5uaKhPcm6cdv08hqpNwCqQbkEf5iwR3TYaQvcdg5oCxUtTLLw8q2M/bP4febjVWE3EfGWvfm5NnauJ2NQg9XPuTVSdZRcfn2MuILZJ65yCOseJk5KVHBJzFOWUKPUT9XEZuqRGfePgGvJeOtNLv6aThAkbSi6928oj2kzC2Pg1GpCWx+wP57gboc2QfvVF+8w3l5RPSn+a/G/I5s+zPSE/zgoQL/z1bvhp3xjEIaYF+Q0CDKnxtTy66XAcnNFpml/u9UzlkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11392
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f149cc9-e046-47d0-2372-08de8e68461a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|14060799003|376014|36860700016|35042699022|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9uvK3rRcFy9LeVe2Nnqiy3n1PEdMulJwXCTxTowu4tO01E3EZ8gQQhaPOU/DoOfFDxloaPwiEVB3RzcepAsJMAJMp1L66Wnwqf5EKph7M70CXxWHbD4CtwmthRkwTLsquqhu9fW+OL4CGo8J9EEplKFpfujnVtXZDTvPwyZhk+zGInNugi1AO+qJ0obQWrhg02nqt3TQfjW5iJN63siyOf9mDhRtQG67qIUwnmM9mjOtP9wRHI1EhoVjZIWARh6Z4SmANHKmtUUZT/qplugHSAVE7D6ka+ni6VqMRMxljZ3/YM/XGq07MyWhk1CrM3VRQoHJN2rxUvoSx7DpZMenVPblSdj9D22eNDDWbknGePU1CRcm0VT2BNNjK0/B2+LmR0wu1qmptvfKcwlg5OEnO1qATOgPGA6EsXsCpwoEoQ6GFApgxqF6YJuwUbKad7NStrZj5R4BeI4Ahz0mrlRyMCf2t8f+uFAFeq3HN//GrA0Q6i70f+G9eS0o0hTLR4an54Kapuayae2PzdD3ynz6qoediAjwspDk9q6mXLimueauX6MHGKFq+undQb3rVUu21UzIGfuAAyPUSWGgcNeG+02pTIwdmMNpL1Uqn5C9TvHPOb/oNgxhr7jy0J+xpOH7YGr9TEIGHo8XH4xjdB7bM9/GCJ+tJvxG25xNkWsAptoI59bF6UFlawlqc6hk3T3RBLfgsvMQxC6zrc5Rdho6Cryf88WYk1C9hQXg4p9ArVsJkFd29U3xll+sblTDDUUA
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(14060799003)(376014)(36860700016)(35042699022)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YLURxscw1c+nOJy0f0rBBqogSbNUgvJzdDPqwiGPfoET7SezJpMhVzt66zuDuWJWpxGkzr+bLMCBOzCKiu5u2Jw3hrw4oMvKwaZrV4DpiURsBvmflJvQLIznp15052JGQnu7J1L7V8i0GFZE+Sw8zuJH91QVrZdthmY+KZDSe54nJqKZFa4mmGIg1mwFo/KEsqQEjyk169ODSjvFAWGrt9pZr07B7rAH3bJBd7zP7SyR2ay6ujiGtcty6ewgDmvLELrSXMYNhyXXv3fmeUibZBfbW12rImVpchbMWywL3Ptv+5RI1/+YMs+NlaHhVauQpgQtLPOB/kDKx/zs8X9JH/PTwYIIJZY+ZiIpXhxoiMS0pOm0OtzPGYdLQ2hFlEFcLzW1cIfvzjFBNLJFlwbSESY+qBtzUMjPzTkl9wpSNxT3ZBoZMCmekMTZlPzivlyX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:27:06.2228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf223d3-c185-4255-f527-08de8e686b67
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11408
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



On 23/03/2026 20:53, Tom Rini wrote:
> The HIFEMAC_ETH functionality can only work with both DM_ETH_PHY and
> DM_MDIO enabled (it calls one of the functions that requires both), so
> express this dependency in Kconfig.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> ---
>  drivers/net/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

Added to net-next, thanks!

--
Jerome

> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 9d4e9f069701..ed07e286676c 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -983,6 +983,8 @@ config HIFEMAC_ETH
>       depends on DM && OF_CONTROL
>       select CLK
>       select DM_CLK
> +     select DM_ETH_PHY
> +     select DM_MDIO
>       select DM_RESET
>       select PHYLIB
>       help

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
