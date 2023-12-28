Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC7EC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B6E87AFE;
	Thu, 28 Dec 2023 17:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="ZUpInyju";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ZUpInyju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D4787B04; Thu, 28 Dec 2023 17:55:22 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1097F87A7B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=odEfu+btlmtZgUXlDsX1jcDPxnvRB1OZ1FHXMMdUBmFKnWxPmzCm1Ju4VVxkoLJ1xsBQpm1FIHxqNpiW2cWhynG1Rmnlt42yLsZUq9yR6obTZP++4FChGzp6Hmm1JnkSyUiZyF7ADTDmsdmArzHvAf+raUqiWiYyzLT2kG9noGMw5wuQNi8+h5I8lLZp4vvzSn5ATAq8qCziRyztinMRG2iDvFkjrvI46bjmswgfxcKjbVYIX2hXAxgua44sJBS3RZ2U7X+qCmA6EAfZ6ToqGLSlFvCsW03LqkgbsfSZNjsOFOb7vz6VKWX24D8d8tYWnxq6iN/k3oqe/RwbSYXrFg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmdllSmNyOnGOIuH8c1Fy1cYVll4d5C6PpDeSNY0/V4=;
 b=fhYboGVbU8lWSPDrt+xYV5hAV0AyZ9UBCLHr0i+mTfAKKnGV3/5kzth5z5I4UkmcMCTp69O0pNobJszCqb+ywl7xwPd6o66IY95L3zAGmMiSA0L6Ey7TEDJzJYFBmTdM/yw8v5wi8ahLVxRHEuYrm3LubU7dAa2/5OTvOtysTMwVMVmYJ026OWpsmbLknR1BM2eFn8SqzfmEx/PSJeqwbvkIYdxT3A9eDVzQ2vdTxilnL0YW6KW0eW+WBNiBkkg93lNHsk/OZqsPzLp9/xYfo4D/pzN/4/ri0jqrNOB4jBPUaHy9558VBxfkTqGPu39BLUCFRz7A4RT+GRjazgEpLw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmdllSmNyOnGOIuH8c1Fy1cYVll4d5C6PpDeSNY0/V4=;
 b=ZUpInyjuK4gZo7dTH2sAIretRugUkyE3RRrBTBPg4EEwogbwsDnKdrSbnNLhu8fBEqWGcGImgSTZHWfi00YX1brYJJI+gSwsQ173MOjcaT2jf1jilcChNqU1npQ3SYLAES0XnXDFWSWRul9F0GLvb0EIXLJb3ev6MCT/GPa4eSKEC2AxteGGHeVY/vFE6rgJPAv5V2mGDTwD1X6LR1AI76N+rheuxOD2OZuTJqc+UwVJPAmenko5HIWbcbMtA17LZZGULk+57rRTRW6C86Gv5dm4ipRSw5zZAMOMavvHi7/IJw6yaIssWCYQ/JtXM3hmnMuvPizHiq/AbgzUyowVCg==
Received: from DU6P191CA0063.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::19)
 by PAXPR03MB7746.eurprd03.prod.outlook.com (2603:10a6:102:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:55:19 +0000
Received: from DB8EUR05FT018.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:53e:cafe::18) by DU6P191CA0063.outlook.office365.com
 (2603:10a6:10:53e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Thu, 28 Dec 2023 16:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.83) by
 DB8EUR05FT018.mail.protection.outlook.com (10.233.238.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.21 via Frontend Transport; Thu, 28 Dec 2023 16:55:19 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 CB08A20080F88; Thu, 28 Dec 2023 16:55:18 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown
 [104.47.11.232])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id C7B032008006F; 
 Thu, 28 Dec 2023 16:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOM5ryL8B8s8gDk3SipxDdU2jEiZ5GTY6E7ZoyqKWNRY9VKkATOfi7wu2GgIT7Z84gw7/XKgcX+kumUmQJZtnHTDVvAflxTnFccbBSLZWwK+EIaVC37h7Wz1/BrYhX8M2JHtG3InF/4iCpv+8e+Uv5lqUwUsNTXJCqs7hD/gErI71dOYuwWv1m92iMWp60V5Fa8shcjobUh3qRkQSzG286kNACujKJACAIvsLWf/qoDaSV4Wq3JprCfhnYM93oDGXn4UFJtoPbMlP4gjz0HyWAUjnMipWNwNMCq31Fw/nIHSCLfMi3+w+DVLUltIj1I7Bo7nhTyUnB+363ZhoRxAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmdllSmNyOnGOIuH8c1Fy1cYVll4d5C6PpDeSNY0/V4=;
 b=XYvE+Evwm+MLdsMHDZbUHNQZAxPWO2PEiXq8mzTfxfOrTpZvOxSf7JbKqDsvULhi1fOmne9yD0v7Z68Ud35yGfltK9t+xJbiNKdFhsyg4DWxSby/eX5CL/+rHZprciUZXFTEa1K2caQ2dUqVp4CkGu/AExdazF9cajydppnHnJx6Rn6YggcIcc6PCBRwA4f3Z5W7r+IfiEyYCXwSqjWP0kzGpXKtRzY/5wHfvRZafqqhYIrtpelNm/i9MiJecG1kpjRrC1zP8SvP63JpBRnYpEVCiUvSx0qFD7w04d6j3XkhJH2b52Ojf2X+5YKA8WNeNYMT6xT6EZx+b+z61rL+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmdllSmNyOnGOIuH8c1Fy1cYVll4d5C6PpDeSNY0/V4=;
 b=ZUpInyjuK4gZo7dTH2sAIretRugUkyE3RRrBTBPg4EEwogbwsDnKdrSbnNLhu8fBEqWGcGImgSTZHWfi00YX1brYJJI+gSwsQ173MOjcaT2jf1jilcChNqU1npQ3SYLAES0XnXDFWSWRul9F0GLvb0EIXLJb3ev6MCT/GPa4eSKEC2AxteGGHeVY/vFE6rgJPAv5V2mGDTwD1X6LR1AI76N+rheuxOD2OZuTJqc+UwVJPAmenko5HIWbcbMtA17LZZGULk+57rRTRW6C86Gv5dm4ipRSw5zZAMOMavvHi7/IJw6yaIssWCYQ/JtXM3hmnMuvPizHiq/AbgzUyowVCg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB3PR0302MB9234.eurprd03.prod.outlook.com (2603:10a6:10:42b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:55:11 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 16:55:11 +0000
Message-ID: <2494da5c-c11d-48ad-929d-8def09eae4f6@seco.com>
Date: Thu, 28 Dec 2023 11:55:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/12] fastboot: enable FASTBOOT_FLASH option for SPI
 NAND devices
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>, michal.simek@amd.com,
 marex@denx.de, michael@walle.cc, stcarlso@linux.microsoft.com,
 tobias@waldekranz.com, seanedmond@microsoft.com,
 abdellatif.elkhlifi@arm.com, neil.armstrong@linaro.org, n-jain1@ti.com,
 xypron.glpk@gmx.de, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, frieder.schrempf@kontron.de, sjg@chromium.org,
 hs@denx.de, dimorinny@google.com, mkorpershoek@baylibre.com,
 patrick.delaunay@foss.st.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com
References: <20231228153922.84323-1-avromanov@salutedevices.com>
 <20231228153922.84323-12-avromanov@salutedevices.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231228153922.84323-12-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB3PR0302MB9234:EE_|DB8EUR05FT018:EE_|PAXPR03MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a330b3c-e124-494b-3086-08dc07c5c603
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: t5YHDbCEem+gVkPxjoYXfqZebK7gx/YJKFDPH6RSX3TxBSqoIULUv1Ldgu23udgUvjGlPCMun22CdSQy8nRKGU0nSWi46UEKc3GpfByhO5IvLwu1P3ervdtnExIDAnjw38t+6fVoMg4moJMDGbWaEFPOnKdBaPIXfGonVUitxxYtHv5v4RxRwPDCXFTPjE0G8BaTEJJ4EDZaX9nJ5VRyV4pTqLqcDd0DfDkQoBIynziuxe+cfJhbGcxC/1YHzDIwogUWQfrnB4ZtzohhAVubZ0Lx7+WJv+opeDGLvBafJMnUGLUMQq5IBWgOzd479xtlX3BDRUXTzEO7PQ+V/1yaCGPOfbwINLQUYbvSt8zg9HxL3aFtp5mlWJpKzbnoLKIkwTjJWOxlpJT8Pjacj83NCzzJACcXWBFCphtJFoF6hmuj9eIrM/WSbetnjRLxFwQAcwRbXfV228bBXtErxndMAI7LvT0p+5FLPfpjtc5eofhHK4nbnNm4fSEp/pop1AIQ+aWnJdgzLKkZNHAzjjGsVJXaOVccFFH+E1mLApJhR63tnIbVATSDt+n9CDkpf856jD2hWDdPD9rR7FyiXMiASSRBBnLo79/wQMjKdDGFb2Lbdopnem5qWpdK/XkKOKbFP9dUZwlbrVrDty4zbUOnGBbqwnDnUEjEQwWYYOPGHFB/Bp5kgNuIa2fQfFw2AiSb6QAQOSKd/DnCATDouw2D6Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(41300700001)(26005)(83380400001)(8676002)(8936002)(316002)(5660300002)(7416002)(2906002)(4326008)(44832011)(478600001)(66476007)(6512007)(6506007)(52116002)(6666004)(66946007)(6486002)(66556008)(38100700002)(86362001)(53546011)(31696002)(38350700005)(36756003)(31686004)(921011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9234
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT018.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fb734ee7-7cd3-490f-a455-08dc07c5c0ff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gye55MySFuFg0F56LMlO9CsCvze72ZE8MNX7AzOgl7mY0ryQRakOhwmlIafYcpWcCLpCswkQr+yXzVgoQfMskXMa7p6/wQ7osxf5+O3odISDiOpONIxjhlb2xsK3RM+TifYiG8RTGuXxIhIuwnbXuMg3RWurXq/uRF492rCK15q9gpq0l2pfcMR0qEzYbeHPzPhX1gxriiYz8hpMwiqpEamlk8v9L6B5KgJqfWuvHF+x7b8UOuagzoOqri5w+M27aShNOG1BxIwO32QcwBNJ3ZlJuIg/e9aoaP8BIVmIOT1X0HgWTX0tlpoEt8FU5heuKlkuDoWL5h+f3G1T3a3IuoLiBj9+esYUqxJZ8XCox+qfIX4ZNdNzLAEUlUJ/9YqgSohEOQOSEgp+QC/2ubfDD152Ep/jrhd03SSPJGTdvkeDyZCJnkfjRA7ELJ9nxkOzEmf82mkodlrik0R1cAldcMLgKksmQ1w6qcKfwbe47KQ4edxiD/CDCI+LvYYqiKrB6LInXAIybSuOWj2vk5Ody+r36vcV89MNpRpquHFZLXO0JgsOtU/mlqg2sWjH4hcFTeivOhMU9ihTRnYvVIeAWibhPaNB1T5ME4h3yTRapXOj+98WXKOXY6me6sVpwT8S37iAteUrWfWQFjDz0p717n91HClZy8fDv7krAJoIkKeTynwjYecq0dO6s2WFL6ws+PC5NinQhhekkk2U0hqJ1CW/KsjHmeEOJKVmMovD8KfF2AbxByj4vsVTZxxg/XvbQ40jo3C9nXW72mlzbaJhJv/vzac9qnsfVPxNV14XiY8=
X-Forefront-Antispam-Report: CIP:20.160.56.83; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39850400004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(70586007)(6666004)(86362001)(31696002)(6512007)(478600001)(53546011)(6506007)(2906002)(26005)(336012)(2616005)(8936002)(70206006)(8676002)(316002)(4326008)(5660300002)(7416002)(6486002)(44832011)(34070700002)(82740400003)(41300700001)(7636003)(356005)(7596003)(83380400001)(36860700001)(47076005)(40480700001)(36756003)(31686004)(921011)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 16:55:19.0411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a330b3c-e124-494b-3086-08dc07c5c603
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.83];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT018.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7746
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

On 12/28/23 10:39, Alexey Romanov wrote:
> From now we can use FASTBOOT_FLASH_NAND option for SPI NAND.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/fastboot/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index a3df9aa3d0..3cfeea4837 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -86,7 +86,7 @@ config FASTBOOT_USB_DEV
>  config FASTBOOT_FLASH
>  	bool "Enable FASTBOOT FLASH command"
>  	default y if ARCH_SUNXI || ARCH_ROCKCHIP
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> +	depends on MMC || ((MTD_RAW_NAND || MTD_SPI_NAND) && CMD_MTDPARTS)
>  	select IMAGE_SPARSE
>  	help
>  	  The fastboot protocol includes a "flash" command for writing
> @@ -112,7 +112,7 @@ config FASTBOOT_FLASH_MMC
>  
>  config FASTBOOT_FLASH_NAND
>  	bool "FASTBOOT on NAND"
> -	depends on MTD_RAW_NAND && CMD_MTDPARTS
> +	depends on (MTD_RAW_NAND || MTD_SPI_NAND) && CMD_MTDPARTS
>  
>  endchoice
>  

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
