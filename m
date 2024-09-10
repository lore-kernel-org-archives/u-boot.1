Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0ACEB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 11:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741EA89016;
	Tue, 10 Sep 2024 13:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Qby+2vXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4879E89038; Tue, 10 Sep 2024 13:25:19 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBBBD88641
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 13:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRYMrXe4PbhZO8z3MtgXb82Nx+CmsKAqmRJWnxMgJYuybW8lpPAsE1TBvarAvLCdgrOWhw04McNKtjft85RL8ImJMegStuKd5lH569cqbdrh0Ut1CKuipig8dLSvoIiCVzx/Ux/Eye8HIx8UVa6R88aMeOUFbQWdPQ+L6jrPle/S8GLNbJ0frMmHiGWGMfkRSIXyHJ1Vbz+Nc4vwDPvE7R6D8mbWLB0QVp5pHKxUmuYZO1q0GC5FVgEQVCyMqnhF3c78k9xPyXMZ8bVt+oWE/2iBYVKFD1c4I0HHbolnvEsjPKr0sXhtxC5LP158oD9NekCYeILhKO0wbp4oeg8BBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE4NFCt+hDL01Vklv7KfseAw0ZvvUbq8O2ACZ579owM=;
 b=t9JB9Um1VOmUAOMiQvB6ACDkpIeZjRNK1nHDWiUJDhMM80JetCrLzcGPaAVcyfiqS2vq5AvrIWAvGgaMm6Jp8mxt+j5bEWFj76nYOG1GEGGTlBBhW9XYcK9iXuHgSHnSNSH7uyP46t8SbyXHwV+cjpucBDRTObxU8r/8fS+C3h15GAYVRe6rOjFvHXlYhY/JibGVoXSHRBmd6sHTJHzlaLzXXNqlOG5K2jhipL78HDepyRbE3uMUrCbf8ebfVzBnzG65Og2QkQSR0l/LmqLWAhDvNIxU5bRod98yGwjB3DXKzpl/jQFtYtQCs72uAavpEZTsG7wt+Q18Zp7yxbIH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE4NFCt+hDL01Vklv7KfseAw0ZvvUbq8O2ACZ579owM=;
 b=Qby+2vXmLtHTTH5B6M+doL2t3cui1RnwRi/foqljKIiPVgEygiUx3I3443ec49EDet+s9lnYrvI+AsAjibfXfJABiNlskoRN7kjFvworoo0CWs6EWKpWNF7V4Illgv/X1zhx5aUsYCm3z0jy42mVzM3JvbsZ1bFb7zc1a5F+/h8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA1PR10MB8405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 11:25:14 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 11:25:14 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Tom Rini <trini@konsulko.com>,  Emil
 Kronborg <emil.kronborg@protonmail.com>
Subject: Re: [PATCH] scripts/Makefile.lib: do not include
 CONFIG_DEVICE_TREE_INCLUDES in dtsi_include_list
In-Reply-To: <20240903215936.2193393-1-rasmus.villemoes@prevas.dk> (Rasmus
 Villemoes's message of "Tue, 3 Sep 2024 23:59:36 +0200")
References: <20240903215936.2193393-1-rasmus.villemoes@prevas.dk>
Date: Tue, 10 Sep 2024 13:25:16 +0200
Message-ID: <87ed5riwdf.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::7) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA1PR10MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d50086-69a4-484a-6f1c-08dcd18b3d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z50urjSbjn83M4fAdulZFAZA3PsBnftS4oigEbCZykn0snuodpNELhNXFTKi?=
 =?us-ascii?Q?Dn+IhWNh0VZlrZ+TGuKdbKzbwip0K6I4NuLGDY6+hRTs2IX3fgL3dy0vcvQC?=
 =?us-ascii?Q?+5ysk6/ibtjU3VLZLODBijxcaNCutOODCkycpcHN9QQkiDfCjbQOx7NxYr4f?=
 =?us-ascii?Q?kLXkotUrkN7uzhGJgv/QNklxgCB1f1QNdHha3J7OMGLBhXkJa0iXGxFhDqUT?=
 =?us-ascii?Q?yBGAdNkxPuRnN08xXe0oTpDfAZFY4CWB1w5ZVhu5qhrwz5uWPOVxs+xh4p1F?=
 =?us-ascii?Q?HCy4ayHuACbsWPzY2le1WUwwHQIw7W3J58WjZdsf3H3QNfgOLX7n3G9gva0c?=
 =?us-ascii?Q?BigiDmX5j33b4yjyXnSbT5p9DESKHX1XpjmfKLx3+5PelkRMIaF797ZdBkIU?=
 =?us-ascii?Q?MNkgnTsKwZR1V3KLBX66L1PAy5jC+k+kKJ5LRaXg3mTbEJgvRzTPEjNBPK9g?=
 =?us-ascii?Q?/ns/uzZ4WkmKTt63SKKZI7eYC9lL00E3YiTDn3wFLZp1t0cpCVyAMnRgAW1j?=
 =?us-ascii?Q?O5jWaGGkJNi5a7jqkF+VAvCfV/ZK2z6V6j9aE9C3tXmtOUJjX/00NBnIUpZh?=
 =?us-ascii?Q?gX6yysdczioP61TL8GmZ9ujRo5GfCzzlEKayfRWEB7hPDJhPpVN8bqw/PtbZ?=
 =?us-ascii?Q?n+xxM6mFd6K8FSTKWT3lLb+URKXU92MFudtpAOnL/2jekX28/6NwXQkJoa3R?=
 =?us-ascii?Q?9Xo/DnbFtp1/Ujl7CIAtOoUNhMk08cxCz9v3/ghVJrp8jMWExm5kgzpoCAfH?=
 =?us-ascii?Q?cyZlRaeNMfB47+Zr7mpYeVwZkCyT3G6j4u9Ra+FPttPKDuEgk7PEy8GXOrkG?=
 =?us-ascii?Q?62HOVh/jPH2hi8hRBgLwnWv4SHyhZSGuBvEXWngNyw0ph3kUiFz7Pu697lg9?=
 =?us-ascii?Q?X73wHagdbMpU6F7vlqSS2DS4X26W9jFz7EMniCoPy2wwbX1dBy1HHJhWO0UQ?=
 =?us-ascii?Q?xuuUbaaL85OGlUtaoidhK4WoWJprBg4nJ36j120h9zq7Z0j2w/x9Po7FvR1R?=
 =?us-ascii?Q?43oUgv1ZhVdX/xYAWPfTYAeObYRpglfKO2SK7SK4oVwPVAI11V3n2g4at97K?=
 =?us-ascii?Q?jhQ9jektqaBinzg6B3IZZZc8qKZJW33EtX1hm5i4/yRY6GPWUQx1QBQxs3+t?=
 =?us-ascii?Q?VKGKvJ3/0T0mGtNPXqSc6uQbTWAiJoNVLakJtcxmpyOTpzD8cKQ3/UD2kClC?=
 =?us-ascii?Q?aM8Q/mNMfl/pCVNIlsFjHcwy2M2zR9aVV0rUzyUokfMgRv4x4yCy5qrIVN6t?=
 =?us-ascii?Q?SrE1h/g5xpBtXcJvAfhd6xMwStGZMMYC8WFs8s5qPVLQsDv9X7TuowOJTQDy?=
 =?us-ascii?Q?vnrGdHjk2q7tM3In71rLyVuAt5sEq5SHHO3Ns1HWUyxjMoFET6zQSqZgwLW3?=
 =?us-ascii?Q?mezKtp1vlDZj1Z1vEq7Dg3UVjOtMOvEvUEeyAIGxllt+ikV4Pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yxsz/Txg49I1X+3dPR/+AXP/g+nno9GPAT4msCTm/sTd1aiN5E/3g+4PS3ZQ?=
 =?us-ascii?Q?y6/NOplPCmVE21OMyyKdozCvYrT1+MJmC5OKBzaEng5FhzSVrQf7VaOG1NOt?=
 =?us-ascii?Q?k29lFRHLfpEAFwrUlp+M2PoFa5TyfNLsEHIFbYitB+VU4Km3jf+YxC8c/KNP?=
 =?us-ascii?Q?5NahxLSeWsGpW6Id4qji431ezWfbeA28Qk1tApQ3cEE4E64cTPrNa3XfFWoG?=
 =?us-ascii?Q?vmc3wr+5WsCLLcQ0xS3lU3L8SFTNsOFvunxvS0X/cvTnTG3xTae2Cm4HGgDc?=
 =?us-ascii?Q?2uTOybwcOEnO6sQqbT97XxWl4CTTnToBCymKi3DVB/O2mMjMDMsKdBoGovWl?=
 =?us-ascii?Q?Khe/FCz0+yqROGlIzvd6bxCPSvxHfALj1SVT6bGcMrsAhyg58yx2otwZuidG?=
 =?us-ascii?Q?QAaImUHzkDDTJ+iexB9fQosoauMqz99OIi63582WPq1w7kqe1U7a7hJVlLcS?=
 =?us-ascii?Q?hzCS39XNoWz/jFMT3fVMlXTJJ4K14WxWoWMyR1wHvJno4LKi/OgLhQSI3Xfp?=
 =?us-ascii?Q?Bk2wfceYhF6fIjRppt4jTIhDw7bUJrsbR3q0VutQLVvjtYI3rIiVdQap/hMv?=
 =?us-ascii?Q?tIu6pXlL9dtoObPYG6MErEncbnIg+Dyf1uZHrKYGf1cWqwHxa06QpfMF7xr7?=
 =?us-ascii?Q?9dEge5BL4jTFIAk6Jbt/9AJcgBmTMtQAqEwMfHohNe3VrQq0xW+c9ikecszw?=
 =?us-ascii?Q?oy++OBt1sQu1DgN+jQx9HX5pKT9rAY8ZL+EIxr0dUKcmp4Lgzv5srqhmRIwq?=
 =?us-ascii?Q?yr+xCuD8BS+oUlPATy7CtrL0a+oj7WSv13LYN5VBohh4Fny/ajXFmsSN/7Eg?=
 =?us-ascii?Q?XnCATIxjNF/rOmCx8ANQhwbd35h8cDOsUgCJkTFAJi0c61OP9BEP4+5Hagzi?=
 =?us-ascii?Q?Uh4J3dGOTeRjK/f8CrjbMu2TiJzIHdSSnJNdl7CsneQaT+wjEs+qCuCAB0Ww?=
 =?us-ascii?Q?7kmaPGzQ71sB3/nCKzqkgzxoNw1kjSFKp1hGlj5ccG9q2Nje4rUH26ndLAG+?=
 =?us-ascii?Q?BHAJsvbLLFkKRaTB4nrfY0c+N81q2MsxiSmNjrUtDfP93kKbGT2Fx3lf3gon?=
 =?us-ascii?Q?uz+szBltsvtTrrklytYBzkHp/XGZ6i3qNQ59gEMTypisiAAjnXU81DBJvHDq?=
 =?us-ascii?Q?x+MH3PmGtmjwLs0uaQ4Ysp55zOxYzRIKPeMDMmtX1q1B6wcSjbplALLixkCo?=
 =?us-ascii?Q?fBNuJYpk2mJRUm4ukUmXHAp1PeSMs7EVUyD3/xlWaKvZM+iV/IhlGbyfIvUY?=
 =?us-ascii?Q?i3e6R0OfANjN2VnEqc1qL1dTlaTTOxtsU11+NdbpzCA3R6T7juixNc0mNNEd?=
 =?us-ascii?Q?byO43l5NITaAbyZKXI1LwBqRQZx5u5PmEGY+3qYyJNabWbFoF2rE6MpyhvK0?=
 =?us-ascii?Q?aMbH2qhTy+H1db/yMtVe/VysMaxim9lWrZSMFPhj7eALA/brOqM7rdjLXC45?=
 =?us-ascii?Q?zBFu8etxhJHDZsgK9n9Km2TNynDqc/NsX8foy4aZ/YeRvoxDeItCaaIeNPEe?=
 =?us-ascii?Q?MknmyXBxJXPlDvKfQN6asOTl+yuATb9T4lpkLfGFH3E9mq811PS09x/+Dhzf?=
 =?us-ascii?Q?f6K9A2LrliZGgeiJey1Od7u1p7L8T0eQn5PDLgZbO+XpY4NLYTK+6wLLjJhI?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d50086-69a4-484a-6f1c-08dcd18b3d8a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 11:25:14.4352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjYtQgAITWnOtxe3efuHUegs8JWv3zkfBs6MRNxaBcCO24rpbcY85kSzD3L+PYWlZHwfvHYrrzqooGNu5DqEWfkGdEnKKOXvNjS1XmN2eqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8405
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

Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:

> The commit mentioned in Fixes broke the
> CONFIG_DEVICE_TREE_INCLUDES feature, with the result that any board
> setting any non-empty value for that fails to build.
>

FWIW, it's quite easy to reproduce, though I don't know if it makes
sense to pollute, say, sandbox_defconfig with this to keep it from
regressing. Anyway, just add include/h2g2.dtsi containing

/ {
        config {
                question = "Life, the Universe and Everything";
                answer = <42>;
        };
};

and add "h2g2.dtsi" to CONFIG_DEVICE_TREE_INCLUDES. Or put the file in
/tmp and add the absolute path "/tmp/h2g2.dtsi" to
CONFIG_DEVICE_TREE_INCLUDES.

I know we're close to release date, but I'd really appreciate if this
could make it into 2024.10. Yes, it's my fault for not noticing and
reporting sooner; the timing just happened to mean I had several
customers end up using 2023.10 (making use of
CONFIG_DEVICE_TREE_INCLUDES), the breakage happened in 2024.01, and I
hadn't had occasion to use this with newer u-boots since, until just
recently.

Rasmus
