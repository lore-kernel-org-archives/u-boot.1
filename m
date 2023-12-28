Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD3C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BAA687B14;
	Thu, 28 Dec 2023 17:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="ATWnhT7T";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="ATWnhT7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD71F87B11; Thu, 28 Dec 2023 17:55:30 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9898787B1E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=C/n1umQCZ9ZWL0wF+54XOcJ5p8oHHjyjsDd0lJRURx8CPSELInPmNuJyZYyqrzxwQfANOzTLDQHw++VUzbUM5xCkQJrhRjcJOuF1GTdB5dvsadpoRKoYY98u5EoyRH4DOx3NFut50cL8w5POrRBSQz7yz9Nf4MudOxy3xuzf37yRhr2sIAKmrdoKx5t5vPPOlqV/tYJTp5Z70nnepqONm0jDNzOHDBGkjCFd9qbp/cAHfLVySRkP89GqvbzsVQcHroNnmCWGVFl7vYMxIBQHpl2d67Bw7i+lIp3Wi3kuMrrYQbPlD0HQwdnCZ2hTvC7XyLyS39zmDCurK4I5a9JMsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+F8e+TV/6xpKuKNO4NH0NHW/WyYTfxf40stnmSmIew=;
 b=KRhu78scVOmJrR2CJfVyo0umEtgC+Qhyx+DUjNghVGTkGtqKXRZaRnTZKnieud2TqzXY1tLYEmG28yhsj9nGofsOrZlOKVP/xbqTH9pTFj+ktAFYtmuV3f/+/R2R8xJRUTxvw1mM7jDLcJtunckkfcqerYKrrGzlauzco5fyttk/PoF++Rpp0q8y8Uvs2fmSsMXFK9hyXG8lh8oEajo/O1B4yZ90O3dtIIFquXO5xgDOthzrMR3HsrYgl7c+hfnCmt5fqyMU4YvFXcEvsoi+VFh/Pz6GWsmjwCwauCxRKusppp0CFlmGRKCBzfq1Pl1ao8j1llmJS8pZfp43e8AwLQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F8e+TV/6xpKuKNO4NH0NHW/WyYTfxf40stnmSmIew=;
 b=ATWnhT7TUCZoxVPkw1ZFxx2mfiI4qw15tXH8IHiXwJz0WyLxmelVUChnFe/ppAVFFxHSmm0Eng1qrgOY48+spWg9qczXaFXQoaCmymFTe4ycQZxLYcJBq/dk9V7pSGdjXSyyrYxiUpxF7JhC7ksG1zV7r3h+zZ8qM2wWm49DkaTWo6lkp7xELnWxMbXakI8blucNNncxnOD1/6RwCBEset1kN4HuvaZ6VAaeVIGVbBrI6CQSKi0lnYgw4G2fuJGH5vvJyM3+qMNn5cCs9KOCjGAjbNH9ZsJ6ZgjBEuOfOM7b/5i6CydVg9COzr22yTUM6gRtxWBQ3QRLv0SzTWNX9Q==
Received: from AS9PR06CA0482.eurprd06.prod.outlook.com (2603:10a6:20b:49b::7)
 by DBBPR03MB10295.eurprd03.prod.outlook.com (2603:10a6:10:53b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 16:55:25 +0000
Received: from VI1EUR05FT064.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:49b:cafe::82) by AS9PR06CA0482.outlook.office365.com
 (2603:10a6:20b:49b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Thu, 28 Dec 2023 16:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 VI1EUR05FT064.mail.protection.outlook.com (10.233.243.113) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.17 via Frontend Transport; Thu, 28 Dec 2023 16:55:25 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 ED1192009538A; Thu, 28 Dec 2023 16:55:24 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown
 [104.47.11.233])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 0CAE72008006F; 
 Thu, 28 Dec 2023 16:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE883WJwq3R7s8J+ri954soPZdEmLUAKkH0BC4s3pON6asP2ykPEpTJz5h+XXK7chWRejNv90Kbcb/kfc0/zjtxubuE6wk5AtKK99PM3emXcFd4sl0K+riDjL51ask7x2EclwHJO50oSn20TiU5lX1GIG9l/S1WA0bYRIKWy5hAi6XoAg6ZJxmmskEw2OCe/8ygzE7E8xCr+jioBEUtsJS6YAxc5Lm/UKsJ7BA/MoMNA6Oi/I8Mtmp5lSXlT/z+R175QvAKyuE7T7enCp1+/xNt9pvshgO3cmKHMKvQzaJ15foPP9rHVM3wtOqizuvpxOhasMVlh3GePzm0x8qo4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+F8e+TV/6xpKuKNO4NH0NHW/WyYTfxf40stnmSmIew=;
 b=QZ9dRo+NlWZvvAkmUzd6L0kqteMWSbt2u+rGPyyMho8b1o4P/48O4tdC/gZd8/XEpMZYm29Y7OvE74BF3cbimpEpiAN2WjcV/W4YlI9WPAApw1xvPgN5NoKMuuomG8Cs2j28z2n/3QEqExibpU6+VNszaSfZIxaiynvqnAiCIgmjYiZOONpiZI/9Sz0LkldgphZLAW7Tspxjc7H5qf+foY5SP2X/GH5aDC1Ulhd61C6xwQtmvJCMoL5GEV2Qt9zSutO/ejg7sfhXrvboUJVpRDwy40vAeKYFrHotw37Y9CW+IY11Urzk/4GBWZGgC0bSr7sZ1Tv2lMoYSsdyVkL7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+F8e+TV/6xpKuKNO4NH0NHW/WyYTfxf40stnmSmIew=;
 b=ATWnhT7TUCZoxVPkw1ZFxx2mfiI4qw15tXH8IHiXwJz0WyLxmelVUChnFe/ppAVFFxHSmm0Eng1qrgOY48+spWg9qczXaFXQoaCmymFTe4ycQZxLYcJBq/dk9V7pSGdjXSyyrYxiUpxF7JhC7ksG1zV7r3h+zZ8qM2wWm49DkaTWo6lkp7xELnWxMbXakI8blucNNncxnOD1/6RwCBEset1kN4HuvaZ6VAaeVIGVbBrI6CQSKi0lnYgw4G2fuJGH5vvJyM3+qMNn5cCs9KOCjGAjbNH9ZsJ6ZgjBEuOfOM7b/5i6CydVg9COzr22yTUM6gRtxWBQ3QRLv0SzTWNX9Q==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB3PR0302MB9234.eurprd03.prod.outlook.com (2603:10a6:10:42b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:55:22 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 16:55:22 +0000
Message-ID: <a18d1127-4393-44f7-b1d6-9f26d0c3d727@seco.com>
Date: Thu, 28 Dec 2023 11:55:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/12] cmd: allow to enable CMD_NAND for SPI NAND
 devices
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
 <20231228153922.84323-10-avromanov@salutedevices.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231228153922.84323-10-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB3PR0302MB9234:EE_|VI1EUR05FT064:EE_|DBBPR03MB10295:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1e1ca0-8b21-40ea-a87c-08dc07c5c9b1
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: OYxhH/jOqChzpjFwnuBfB3a9A4hKBcDjtrczGueu5iZDC70NUpARnMauyopqYcyHFe6Sj00THhuKPh5/Z9irljuz9o8rfNNr1tPKr4KXaOkvyGAw3OahDBv1nAWp4ydZujt/0P7brR8+Slvt0Z6W7UN33RhXGdhtORULURUA5yg2ueebW1ONdZzJqipeqlOT+oxt7uVyMDESAIivKh0xN9X2/20S33rdybwVm5tItjlDCvkVWdFKUxzCg5uXXALlSc9lJnkknTs1/wtNkN9qSAUkBSnbFOspCgk1SNoNoI4yk5GApe6qUZ4fZHtgF/2L7j0rEsO5Pp3XITgmJTN6UYc92L0ojPIHg5A5irLg47xz6ho35OfbVEn6iHCDtGSI42RH7yKE4BpaVp44L0K9A18W6nqd3NadVBrCFSGaMv8YYkKSCkHwUYTOXZjODgi5kDGj08nQTVOPn0AOuwzWIca3JoDYD+bMNqdWLoIUYe7PR7xDJtcnOp9+HiFgimN7mZtgbYBzAB6txLugjwk1MgtPJb9+78BjcJkucaTvm5/xNa8lj2bs/BD4bXsT7eW9QEjD4vtBxgDul39vFTNk0T9/z8ftO6rWE7mJityf+kTYzpOt67VaKgF7RKtzvINf09Lk88eBmdP3LrMJ8FNULAImPUq4ggYdlQJ87nCit/VZmFna2ZYslOtBgxm+EVVbKK9YdcxKuPGpJl4OJbRTQA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(41300700001)(26005)(83380400001)(8676002)(8936002)(316002)(5660300002)(7416002)(2906002)(4326008)(4744005)(44832011)(478600001)(66476007)(6512007)(6506007)(52116002)(6666004)(66946007)(6486002)(66556008)(38100700002)(86362001)(53546011)(31696002)(38350700005)(36756003)(31686004)(921011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9234
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT064.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6fc2117b-943e-416e-6bbe-08dc07c5c7bb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lk7xSKxOlWALmBs1No+YwY+eeZonK0CR95+2eCbw3Vg0mrmUOo6usaL4EODvrQ/OZqusas1XlVLX/N+jQ7t/4+00uweGzEAXCHWDyhSS6MUMUqGbAYD05YQGzWnk2E47Orn4+AajKsKF6XntFmtaFRPKea7B6D6vP+PEP34MMBNSc10t3Gi4c0PfOHhCwHxm7Zwtb4WHsMlG6xAB1NYycpQR0JaamBn32UgnsQ3a6740ZmUb6DpJoAAuiFmOgatPTdm47Rl1mMSnzlWmMROLD1iNCHL+cYNLSmHWWNjgR68B8sHe1QANQ2Lq39JSQi3siP1OsBDAssp2Hx16NgeIBhZHYe+wFBU4W9ZmjFnqhAO/sPdk2Z2DC9W6FqKMArbiFciSXb7hD3J8qi6OBNq2yCcr6iRqNRiDoJoqt2O3rQPY8wMP0z1JrQfUFB9OjMuBeNWxfNN9eYm9NN/nt1aFpIf3gfIrE+iXJeke7j9fB6zAlKpGFeDtlqWYzVdhLl+bMbvZ+1fGQeWEDz3IkyeQ+qZbPzinm4r+i54nHTLyPv1ICTGHFMpFkvXIKhcOzWHAhkc3hHWfXNVo40y3RJ9ne3vYKRZsE4fdm69mYofu14iWSsqNsqHEzMiyil4ImECdbbQJFJqVGJzDJO8sqDxPLBr/Z1OQHrPQI4QV2bmb/SKj0WnjEAd0U2QjtoG7h9yFIiyc7QP9kKItR6s4L32F9G34K549O4HvS6cbb5Rlox8gE3HER8oPGDhmuI1Ztp4EyV1APgagtFBrNbd9v6zc/ammtCOZ+xHwxmi8FZwNpvQ=
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(36840700001)(46966006)(316002)(8676002)(8936002)(31696002)(6666004)(6486002)(36756003)(2616005)(478600001)(86362001)(6506007)(6512007)(53546011)(26005)(7636003)(36860700001)(82740400003)(7596003)(356005)(34070700002)(336012)(83380400001)(41300700001)(47076005)(70586007)(70206006)(5660300002)(44832011)(40480700001)(921011)(2906002)(31686004)(4744005)(7416002)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 16:55:25.2645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1e1ca0-8b21-40ea-a87c-08dc07c5c9b1
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT064.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10295
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
> Boards with SPI NAND also can use this command.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c47523a03b..c8484576e2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1367,7 +1367,7 @@ config CMD_MUX
>  config CMD_NAND
>  	bool "nand"
>  	default y if NAND_SUNXI
> -	depends on MTD_RAW_NAND
> +	depends on MTD_RAW_NAND || MTD_SPI_NAND
>  	help
>  	  NAND support.
>  

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
