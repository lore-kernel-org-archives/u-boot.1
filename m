Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8E9C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C2587AF1;
	Thu, 28 Dec 2023 17:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Pp4R+hU+";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Pp4R+hU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A86C87AD5; Thu, 28 Dec 2023 17:51:26 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4319087AF9
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=BVGc21tBdxNOPYtxQGLueAHKc5sjYT6raWFRCQYGVrsqIL/DTRLiOuhY61E7aAjL6IfS8hnyFeEVXQfLpcmsut9r0DfK+MRMAznsGl0ls+jVUC+5bD5bsmZrE3+31k6j4KGFrsvc6OCyMGqm3Qfr+Me0gEdSOo/fAPPBUjM6voMHKHWNfEvUB28b30QHapvyyy7Q+/J6TFwgubDCZBAgSCGjfccPudZsL71FPKfFsxPg//0yPnJQjD/fsPeQnd8oSeMoKWEe1XRZkNcGTThO6dIpqTC1JaGVaVWnhneBdkDDcxefYJWc24yp8fzxtmqLLr+drxV1logyMCH3GVXxFw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4xVDED7tbEGMyljbXq/JHeoqHQD8Sked96x6LInCGg=;
 b=hj6Z2jeEisop5oqYgvuDS7SxaapDm4NjBmFYXj5c239NQW8EujzmjpLFbWW/rOQZYOMufcT6FJrrwf1Z5GmuOw1gV3q8jmKxkBeO8izTKNxLEkY7PzHwKBkTmYB/10MHrVJxZAYctFa1XAtALMWpwY9B/pSgjx8SYl3V0r2Xm6yIiEBZ1pmxYERFJOuuOzE3hnXZGe+iWR/EwYD1tzgMO2A4VrguCVu1Vd8VZYFWtP5w0YH4+mIAvH1EuO1sDcEE8/noJnjz2uGnoD99WuWKHOHJyERJbm2AWISCocbpb/WoRu+o6nn1VAkIrj0kpFD6jwt5H9FhpZkKl+RNkWKjlA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4xVDED7tbEGMyljbXq/JHeoqHQD8Sked96x6LInCGg=;
 b=Pp4R+hU+T3qwm/g3J5cZ8PnRoxA/LltXGTm1i0VNLsSgVDOhAJ6+kbb9UwfH+DiXorgA2KDQTGiikkUlZgAKS1a927YjrkgJwY8ai7sE9yZy+OMDNyfWRgpWdkjmGOgJbK0CLfQ2Dajto7ui01VsuFlaMO5NUZqs0cqmy3a//+Vwe22ESKipnPuB020H2P3AI9KhODsODix5+7KW3G+L3nzjcXO4WdCHIYrmVyWIKEdejTubMMsSFnkcbiW1/UYf7PTdARZMIpkLzSHO9rIZt8u8fZ6ee6HIT/4+EQSUNaVOY4jpSIpdrJFafEab4XB8+su7eO8mALEzCcPKa6azpQ==
Received: from DU2PR04CA0083.eurprd04.prod.outlook.com (2603:10a6:10:232::28)
 by PAWPR03MB9180.eurprd03.prod.outlook.com (2603:10a6:102:337::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 16:51:20 +0000
Received: from DB8EUR05FT010.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::41) by DU2PR04CA0083.outlook.office365.com
 (2603:10a6:10:232::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Thu, 28 Dec 2023 16:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 DB8EUR05FT010.mail.protection.outlook.com (10.233.238.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.21 via Frontend Transport; Thu, 28 Dec 2023 16:51:20 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 CFFDF2009538A; Thu, 28 Dec 2023 16:51:19 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (unknown
 [104.47.1.50])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 63C4A2008006E; 
 Thu, 28 Dec 2023 16:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4EMnD4l2qvVMApB1MnQZ8OUvq9uGQqFghaAKdVar2Hz95K4IgupvZZt5VOgUO/strI7lhKRsc4X6Lw4hmpJYDcidRY3tisXMaIrFw3xh8g4SrBrft5Y1oxwqc7CailanOc9gvBXkOwneFsWde0NeomLJpXOYA0oZZaG8IOcm8pjZSfrWOpu1+0JoGPfhlzsrSE/C/QnB9vhuxJWkRw752CO4VOoLaaltF5rWUIb5EzIJacw7wz8le/LwrcyQUWVs1mDHlrYxI6n7h/9KExrr4N35DbpnX0Q3UTB75u5/cwr3+KrcpbOCdSXTCeFeG76OxrGqV/sYfyfCceAZw4oYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4xVDED7tbEGMyljbXq/JHeoqHQD8Sked96x6LInCGg=;
 b=YMw6gezVJiaMDDn7XRLGSB9aObEmSdtUgKtKvwg/KO8/HLJ8klzVBarVrU85hl43cgvWyyGxRTPOvw6CrFgbSgvzehHvQMQdtxlSJFeiHNLjVN8pL7CCdj8Wd8tn1uU0QAwzc9FxQ239EJJwP6zg9a7KkSyatbTTpHaM4w5DB9OkAvCElD9pWk6qjkdP1F1+Wg6Q2qhqToFAuRJkFptF1n2JOpYlHN86K1IuxWZ1SDl06O43TnOnLk74bUddOU2OTHwXEETdBBl9GrwnIngBNf9npIG8kfgNZHzINRYvr2o4rsjzCdR5rrfsKy2wSq0aJNN8hofTKn/mw33OwSHpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4xVDED7tbEGMyljbXq/JHeoqHQD8Sked96x6LInCGg=;
 b=Pp4R+hU+T3qwm/g3J5cZ8PnRoxA/LltXGTm1i0VNLsSgVDOhAJ6+kbb9UwfH+DiXorgA2KDQTGiikkUlZgAKS1a927YjrkgJwY8ai7sE9yZy+OMDNyfWRgpWdkjmGOgJbK0CLfQ2Dajto7ui01VsuFlaMO5NUZqs0cqmy3a//+Vwe22ESKipnPuB020H2P3AI9KhODsODix5+7KW3G+L3nzjcXO4WdCHIYrmVyWIKEdejTubMMsSFnkcbiW1/UYf7PTdARZMIpkLzSHO9rIZt8u8fZ6ee6HIT/4+EQSUNaVOY4jpSIpdrJFafEab4XB8+su7eO8mALEzCcPKa6azpQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB3PR0302MB9234.eurprd03.prod.outlook.com (2603:10a6:10:42b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:51:11 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 16:51:11 +0000
Message-ID: <275562bf-ab8b-4ad3-9f67-fee9ee62c752@seco.com>
Date: Thu, 28 Dec 2023 11:51:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/12] nand: move NAND initialization API to nand/core.c
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
 <20231228153922.84323-2-avromanov@salutedevices.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231228153922.84323-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::29) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB3PR0302MB9234:EE_|DB8EUR05FT010:EE_|PAWPR03MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 66006817-4a9e-40a6-51d4-08dc07c5378e
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Rw+Sn+tjZD5+pnrpXRz8XCLQ/8z0yyhBxT1yL/3A7tOLaJYHU7FaXGCQe0HNuxUSbkEpSzbl5u2hLz3y3Sgf0LaHiwHsAxn6jRoH3RZjYglplKK9wr5awWzI1M2R6cc4GHF3EuzYIse9V4xOSXAKWCtFn16oGtT/Q3m5lHJg0wkOHlTlMK8Q1uknJ1qqz5uSP1HpqJxFKp0J4iwsVooUY2693Hwd+NGtzersiGmu24rPFh/H4Gu1YhvWEVtkzHP8doADUmpj6undF5po5VAD/XTOGaOo6P/DQ36tmXJftqhbTkvqwLdPl/aMWFNf7NmHCxLGdJ7Y9Hhic3i/fjarEFF+FxsHMmFCJubAWLZb6YaZ95RHaaMWp3MLXWOOa1ftAVUj275e/BrqlmyXXHTA90SgD13yYSti3q19VZOgEZnRqn0BSu/cmiKJqw5CbljPRrl027tUVnL6muCww8YLZHdiFVM6iNfsbDczTkYTHzfSt9oygkHquC1iLuNwu1jOyn4xlEu6wOvOcOyOwEc8HPbubl1kbqIWkPJsUAOqO9sxMdSoUl8iAwclg9+c9Pk7bW/aBTf+u/8Dg/EsyrYjgLbFSgOTDbhjeHghZME3UJK2P6pyfB7cdUvCCKwAykvdTn/In42pWUOgSrnRl3Xgk6yF9WnWvAunX07cqkgj3NNpvXfu/q9eQUaWqX0b1WBa6oLfsxru6z5Y1PgQrNN6Lw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(346002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(41300700001)(26005)(83380400001)(8676002)(8936002)(316002)(5660300002)(30864003)(7416002)(2906002)(4326008)(44832011)(478600001)(66476007)(6512007)(6506007)(52116002)(6666004)(66946007)(6486002)(66556008)(38100700002)(86362001)(53546011)(31696002)(38350700005)(36756003)(31686004)(921011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9234
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT010.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 769b9ea7-82cd-4e8d-a570-08dc07c5322b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7tmSuRKG7yU9ANvFWOUXMFrDTq1Ffsx+ncITIGMqt2CBLJBOfC+/SCHVLDmyerx3emUJ26JkpQm14qn8wu16KBYFr11dzdLcEcJd2HRcoAn/CzmNPDgBZcHu9xgNOP0TviQsN7+8nPw9BBWN8PbI7GUKFGUuv7Y8CnpfMu4GIkT8M73NLeyUeEOEmvYBAMx4meL/2vOQrFuScpNPzUY3nFkI+nW1akGDWM9fOOrKsQM9o2QttuPS89FwabgAFnlEHbi0c7GIElp6Gi7yr2S2KGoXTK1K04RMKtCsvYtiAMbmCYpLQHuXphm7S51m7JdTHRLYTW3RNPGVFpDdMzpGqnVvFT0NZ6uju/fCqBOulTcrBSMfoNJjp7koa/1d+RwVpqiORMiBIc9ipiqteYgAsGGLnnO2k981PkKVLl6kJRCZgJF8tEVvJXUMxQK2f47HnT4KPVBQ3GTwD3huT0pyvHa7Cq3Qvf7Aoc/lY5k7AZ+muJ6ZcHd1OMd1C4FB10TzLzs8wUzEg4vEiaBmy/AVQID25gpi/T1yC5t9XLWOQSliUzxtKBv7sjhOlQ0Ukw0FvjLIAzIEtPIuHv8Z/P8BkRFQfANbflhE4B60r0HWmJhSblXJcFCS3x4P9spPbFqnzUIJM0C4yKuQSjEtBUT/slEBvY4F9FUt9ErWpTEickTtkOvo2OnXVHF6/wK1a7iT+aTDI5+CFI3RdhDu/L+P+lZuXCyJQgmIBPotGscdj4MN1LSVVjhfU/Nla0KV93zBLAIYJ94mcAnEI+jkhnXj7HZTX4sclPudjiZXyMowWk=
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39850400004)(136003)(376002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(36840700001)(6666004)(40480700001)(2616005)(478600001)(36860700001)(6512007)(86362001)(31696002)(6506007)(53546011)(82740400003)(70586007)(70206006)(34070700002)(316002)(36756003)(41300700001)(47076005)(6486002)(31686004)(8676002)(921011)(8936002)(83380400001)(4326008)(2906002)(336012)(7596003)(44832011)(7636003)(356005)(7416002)(5660300002)(30864003)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 16:51:20.0855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66006817-4a9e-40a6-51d4-08dc07c5378e
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT010.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9180
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
> nand_register() and nand_init() is generic API for both
> RAW and SPI NAND's. We have to move this functions
> from drivers/mtd/nand/raw/nand.c to drivers/mtd/nand/core.c.
> 
> Functions designed to work with RAW NAND should remain
> in drivers/mtd/nand/raw/nand.c.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/mtd/Kconfig          |   2 +-
>  drivers/mtd/nand/Kconfig     |  10 +++
>  drivers/mtd/nand/core.c      | 136 +++++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/raw/Kconfig |  10 ---
>  drivers/mtd/nand/raw/nand.c  | 134 ----------------------------------
>  include/nand.h               |   2 +
>  6 files changed, 149 insertions(+), 145 deletions(-)
> 
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index c56840c849..1902351719 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -260,7 +260,7 @@ config SYS_NAND_MAX_ECCPOS
>  
>  config SYS_NAND_MAX_CHIPS
>  	int "NAND max chips"
> -	depends on MTD_RAW_NAND || CMD_ONENAND || TARGET_S5PC210_UNIVERSAL || \
> +	depends on MTD_RAW_NAND || MTD_SPI_NAND || CMD_ONENAND || TARGET_S5PC210_UNIVERSAL || \
>  		SPL_OMAP3_ID_NAND
>  	default 1
>  	help
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 78ae04bdcb..9a1d4ac0dc 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -1,6 +1,16 @@
>  config MTD_NAND_CORE
>  	tristate
>  
> +config SYS_MAX_NAND_DEVICE
> +	int "Maximum number of NAND devices to support"
> +	default 1
> +
> +config SYS_NAND_SELF_INIT
> +	bool
> +	help
> +	  This option, if enabled, provides more flexible and linux-like
> +	  NAND initialization process.
> +
>  source "drivers/mtd/nand/raw/Kconfig"
>  
>  source "drivers/mtd/nand/spi/Kconfig"
> diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
> index 4b9dd6a926..ff298e3a0f 100644
> --- a/drivers/mtd/nand/core.c
> +++ b/drivers/mtd/nand/core.c
> @@ -10,6 +10,7 @@
>  #define pr_fmt(fmt)	"nand: " fmt
>  
>  #include <common.h>
> +#include <nand.h>
>  #include <watchdog.h>
>  #ifndef __UBOOT__
>  #include <linux/compat.h>
> @@ -18,6 +19,12 @@
>  #include <linux/bitops.h>
>  #include <linux/mtd/nand.h>
>  
> +int nand_curr_device = -1;
> +
> +static struct mtd_info *nand_info[CONFIG_SYS_MAX_NAND_DEVICE];
> +static char dev_name[CONFIG_SYS_MAX_NAND_DEVICE][8];
> +static unsigned long total_nand_size; /* in kiB */
> +
>  /**
>   * nanddev_isbad() - Check if a block is bad
>   * @nand: NAND device
> @@ -250,6 +257,135 @@ void nanddev_cleanup(struct nand_device *nand)
>  }
>  EXPORT_SYMBOL_GPL(nanddev_cleanup);
>  
> +struct mtd_info *get_nand_dev_by_index(int dev)
> +{
> +	if (dev < 0 || dev >= CONFIG_SYS_MAX_NAND_DEVICE || !nand_info[dev] ||
> +	    !nand_info[dev]->name)
> +		return NULL;
> +
> +	return nand_info[dev];
> +}
> +EXPORT_SYMBOL_GPL(get_nand_dev_by_index);
> +
> +int nand_mtd_to_devnum(struct mtd_info *mtd)
> +{
> +	int i;
> +
> +	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
> +		if (mtd && get_nand_dev_by_index(i) == mtd)
> +			return i;
> +	}
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(nand_mtd_to_devnum);
> +
> +/* Register an initialized NAND mtd device with the U-Boot NAND command. */
> +int nand_register(int devnum, struct mtd_info *mtd)
> +{
> +	if (devnum >= CONFIG_SYS_MAX_NAND_DEVICE)
> +		return -EINVAL;
> +
> +	nand_info[devnum] = mtd;
> +
> +	sprintf(dev_name[devnum], "nand%d", devnum);
> +	mtd->name = dev_name[devnum];
> +
> +#ifdef CONFIG_MTD
> +	/*
> +	 * Add MTD device so that we can reference it later
> +	 * via the mtdcore infrastructure (e.g. ubi).
> +	 */
> +	add_mtd_device(mtd);
> +#endif
> +
> +	total_nand_size += mtd->size / 1024;
> +
> +	if (nand_curr_device == -1)
> +		nand_curr_device = devnum;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nand_register);
> +
> +#ifdef CONFIG_MTD_CONCAT
> +static void create_mtd_concat(void)
> +{
> +	struct mtd_info *nand_info_list[CONFIG_SYS_MAX_NAND_DEVICE];
> +	int nand_devices_found = 0;
> +	int i;
> +
> +	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
> +		struct mtd_info *mtd = get_nand_dev_by_index(i);
> +		if (mtd != NULL) {
> +			nand_info_list[nand_devices_found] = mtd;
> +			nand_devices_found++;
> +		}
> +	}
> +	if (nand_devices_found > 1) {
> +		struct mtd_info *mtd;
> +		char c_mtd_name[16];
> +
> +		/*
> +		 * We detected multiple devices. Concatenate them together.
> +		 */
> +		sprintf(c_mtd_name, "nand%d", nand_devices_found);
> +		mtd = mtd_concat_create(nand_info_list, nand_devices_found,
> +					c_mtd_name);
> +
> +		if (mtd == NULL)
> +			return;
> +
> +		nand_register(nand_devices_found, mtd);
> +	}
> +
> +	return;
> +}
> +#else
> +static void create_mtd_concat(void)
> +{
> +}
> +#endif
> +
> +unsigned long nand_size(void)
> +{
> +	return total_nand_size;
> +}
> +EXPORT_SYMBOL_GPL(nand_size);
> +
> +void nand_init(void)
> +{
> +	static int initialized;
> +
> +	/*
> +	 * Avoid initializing NAND Flash multiple times,
> +	 * otherwise it will calculate a wrong total size.
> +	 */
> +	if (initialized)
> +		return;
> +	initialized = 1;
> +
> +#if CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
> +	board_nand_init();
> +#else
> +	int i;
> +
> +	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++)
> +		nand_init_chip(i);
> +#endif
> +
> +#ifdef CONFIG_SYS_NAND_SELECT_DEVICE
> +	/*
> +	 * Select the chip in the board/cpu specific driver
> +	 */
> +	board_nand_select_device(mtd_to_nand(get_nand_dev_by_index(nand_curr_device)),
> +				 nand_curr_device);
> +#endif
> +
> +	create_mtd_concat();
> +}
> +EXPORT_SYMBOL_GPL(nand_init);
> +
>  MODULE_DESCRIPTION("Generic NAND framework");
>  MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index f0100a601d..31949f1dff 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -3,12 +3,6 @@ menuconfig MTD_RAW_NAND
>  	bool "Raw NAND Device Support"
>  if MTD_RAW_NAND
>  
> -config SYS_NAND_SELF_INIT
> -	bool
> -	help
> -	  This option, if enabled, provides more flexible and linux-like
> -	  NAND initialization process.
> -
>  config SPL_SYS_NAND_SELF_INIT
>  	bool
>  	depends on !SPL_NAND_SIMPLE
> @@ -29,10 +23,6 @@ config TPL_NAND_INIT
>  config SPL_NAND_INIT
>  	bool
>  
> -config SYS_MAX_NAND_DEVICE
> -	int "Maximum number of NAND devices to support"
> -	default 1
> -
>  config SYS_NAND_DRIVER_ECC_LAYOUT
>  	bool "Omit standard ECC layouts to save space"
>  	help
> diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
> index eacd99c4e2..edca824d77 100644
> --- a/drivers/mtd/nand/raw/nand.c
> +++ b/drivers/mtd/nand/raw/nand.c
> @@ -15,68 +15,10 @@
>  #define CFG_SYS_NAND_BASE_LIST { CFG_SYS_NAND_BASE }
>  #endif
>  
> -int nand_curr_device = -1;
> -
> -static struct mtd_info *nand_info[CONFIG_SYS_MAX_NAND_DEVICE];
> -
>  #if !CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
>  static struct nand_chip nand_chip[CONFIG_SYS_MAX_NAND_DEVICE];
>  static ulong base_address[CONFIG_SYS_MAX_NAND_DEVICE] = CFG_SYS_NAND_BASE_LIST;
> -#endif
> -
> -static char dev_name[CONFIG_SYS_MAX_NAND_DEVICE][8];
> -
> -static unsigned long total_nand_size; /* in kiB */
> -
> -struct mtd_info *get_nand_dev_by_index(int dev)
> -{
> -	if (dev < 0 || dev >= CONFIG_SYS_MAX_NAND_DEVICE || !nand_info[dev] ||
> -	    !nand_info[dev]->name)
> -		return NULL;
>  
> -	return nand_info[dev];
> -}
> -
> -int nand_mtd_to_devnum(struct mtd_info *mtd)
> -{
> -	int i;
> -
> -	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
> -		if (mtd && get_nand_dev_by_index(i) == mtd)
> -			return i;
> -	}
> -
> -	return -ENODEV;
> -}
> -
> -/* Register an initialized NAND mtd device with the U-Boot NAND command. */
> -int nand_register(int devnum, struct mtd_info *mtd)
> -{
> -	if (devnum >= CONFIG_SYS_MAX_NAND_DEVICE)
> -		return -EINVAL;
> -
> -	nand_info[devnum] = mtd;
> -
> -	sprintf(dev_name[devnum], "nand%d", devnum);
> -	mtd->name = dev_name[devnum];
> -
> -#ifdef CONFIG_MTD
> -	/*
> -	 * Add MTD device so that we can reference it later
> -	 * via the mtdcore infrastructure (e.g. ubi).
> -	 */
> -	add_mtd_device(mtd);
> -#endif
> -
> -	total_nand_size += mtd->size / 1024;
> -
> -	if (nand_curr_device == -1)
> -		nand_curr_device = devnum;
> -
> -	return 0;
> -}
> -
> -#if !CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)

Please rebase on u-boot/next and also move nand_unregister.

--Sean

>  static void nand_init_chip(int i)
>  {
>  	struct nand_chip *nand = &nand_chip[i];
> @@ -98,79 +40,3 @@ static void nand_init_chip(int i)
>  	nand_register(i, mtd);
>  }
>  #endif
> -
> -#ifdef CONFIG_MTD_CONCAT
> -static void create_mtd_concat(void)
> -{
> -	struct mtd_info *nand_info_list[CONFIG_SYS_MAX_NAND_DEVICE];
> -	int nand_devices_found = 0;
> -	int i;
> -
> -	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
> -		struct mtd_info *mtd = get_nand_dev_by_index(i);
> -		if (mtd != NULL) {
> -			nand_info_list[nand_devices_found] = mtd;
> -			nand_devices_found++;
> -		}
> -	}
> -	if (nand_devices_found > 1) {
> -		struct mtd_info *mtd;
> -		char c_mtd_name[16];
> -
> -		/*
> -		 * We detected multiple devices. Concatenate them together.
> -		 */
> -		sprintf(c_mtd_name, "nand%d", nand_devices_found);
> -		mtd = mtd_concat_create(nand_info_list, nand_devices_found,
> -					c_mtd_name);
> -
> -		if (mtd == NULL)
> -			return;
> -
> -		nand_register(nand_devices_found, mtd);
> -	}
> -
> -	return;
> -}
> -#else
> -static void create_mtd_concat(void)
> -{
> -}
> -#endif
> -
> -unsigned long nand_size(void)
> -{
> -	return total_nand_size;
> -}
> -
> -void nand_init(void)
> -{
> -	static int initialized;
> -
> -	/*
> -	 * Avoid initializing NAND Flash multiple times,
> -	 * otherwise it will calculate a wrong total size.
> -	 */
> -	if (initialized)
> -		return;
> -	initialized = 1;
> -
> -#if CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
> -	board_nand_init();
> -#else
> -	int i;
> -
> -	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++)
> -		nand_init_chip(i);
> -#endif
> -
> -#ifdef CONFIG_SYS_NAND_SELECT_DEVICE
> -	/*
> -	 * Select the chip in the board/cpu specific driver
> -	 */
> -	board_nand_select_device(mtd_to_nand(get_nand_dev_by_index(nand_curr_device)),
> -				 nand_curr_device);
> -#endif
> -
> -	create_mtd_concat();
> -}
> diff --git a/include/nand.h b/include/nand.h
> index 70c1286ccb..16cfc2a24a 100644
> --- a/include/nand.h
> +++ b/include/nand.h
> @@ -25,6 +25,8 @@ int nand_register(int devnum, struct mtd_info *mtd);
>  struct nand_chip;
>  
>  extern int board_nand_init(struct nand_chip *nand);
> +
> +void nand_init_chip(int index);
>  #endif
>  
>  extern int nand_curr_device;

