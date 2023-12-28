Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E2C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C9487B04;
	Thu, 28 Dec 2023 17:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="UOhdWK9z";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="UOhdWK9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F9F87AFE; Thu, 28 Dec 2023 17:54:49 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4113D87B04
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=iodUV4yeWdCVpEoOEnGC55qS0bzMT47XEGgG3jr/6cHuWvV81Nt2LBA7kLThkbqW4gRXzNzYzMW1niO+mkIeyQ8iurjVvj2UCYpAZ1Dco/8QctO5b2HWVHh/PqL2DN/Jd/kCVaf2EF7uQncJs4PeUSpkRzoJwMVmKRXXiXxVLZswlJW2ntWlZsm6LJvKdfa5o7p9iFjY+zHJ7RrmFHYsDczYLUzfijxQJHFtNZTinCtSdm6+T2zHjiou0ua8BTopyDL/v3Lbw/G+cusi6UecRZPqJyCRom6gaO4sDe9P5n923MKWPkfdczVNIjp2vlM2uISiGaBKOrGSSTHwJy3R8g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKc9rYAPCsFzuUP+b1KLTnLwPN91A5L+TJMvn410PJ8=;
 b=blLFLrp4hD5nEg9K4eVOVJ35caMh22awtKn5AwO0s7OXVbh/+vW4bJQhF9fVqVreKqhGPmb4Oyb48nh91cnkmAQgySXYTxefuYbGtB4gYsj5gBVwSVibd8u7lAiLPynRrZYkCan9JOnIR01xsuhDriJtDs0Tla6kftkI8HdVGnxPl5dUAB76FVkUArznee2vOxgO0NH8f1WKZksPcQEJboD/xXAtDN5AgmV+v653DAO2/oxTiA+hEd9EjFMUKMgdA+HLC8XpNvvXvU8Xl+8YzvegTxn+EGBr+t47tWssN4MMospEDcSnY7kc2xDOt2nh6/1P6PySag7zfcsiT/urPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKc9rYAPCsFzuUP+b1KLTnLwPN91A5L+TJMvn410PJ8=;
 b=UOhdWK9zWyqQ+pkZzL3mIEI3FqoSqB/qCTrXEMzEfN7lKcLPf9lvEcE9s/6W9VYPO/Gf8vvEfYccU4DzxPXjJSDZyEwehCqhassuZyKnQsVsbK3WZVwW+zkRWjdxruGqDf4F1bAOPQhdT1vDkDd3iHlH/rlalU/dE06V6Q7WeuUo4o6kQWSXOKFyEFHO8G7l/b3pN6FVivdtUudlhW21qJquKDD4aQ7ZKLXFnzQe8OlA3b9sUxst7knDybq7PL2RyrXU+bpSZWtJVnIEv/IJVDmnseKmR9qXuslsCdDOxHPdroZt63vjOqpzQoX1IAX463BTkjypVbiTRYSNNstJ9w==
Received: from FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::17)
 by AM9PR03MB7852.eurprd03.prod.outlook.com (2603:10a6:20b:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:54:43 +0000
Received: from VI1EUR05FT021.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::a) by FR0P281CA0143.outlook.office365.com
 (2603:10a6:d10:96::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19 via Frontend
 Transport; Thu, 28 Dec 2023 16:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 VI1EUR05FT021.mail.protection.outlook.com (10.233.243.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.20 via Frontend Transport; Thu, 28 Dec 2023 16:54:42 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 770712009538A; Thu, 28 Dec 2023 16:54:42 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown
 [104.47.11.233])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 19ACE2008006E; 
 Thu, 28 Dec 2023 16:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc+adWpCnqAdVtQobeqnWZhvWSmISIJne74QUoxy7ftNaeP0MRKhNSl3d3u8w/Yi1OTSAnjQqz3XyLK7N8lzh1kfnUkjDf+5s8IxSn41YK5EOUCa3OnmNkJoMvIYSO0EakRpkBOs3srYgaQqQXrmHH+ke/CtRkgzkkzsSyL5SFLU/Ec61YnHKbapvmdLqnNwa4pAwb9W0Qp7i5TK7QsaGLgvHb5FmpV8Cs4Qc03rVcpM6AkVYwAGuT2De5X8Wq6SdzpLEzoPLmta0TIHtYdxRpPCsLn+BGLS2uh+hY73o6aWBD5NM/NdLpNgU24JQj8N+2fCa9VSgrlPIeuj9GXfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKc9rYAPCsFzuUP+b1KLTnLwPN91A5L+TJMvn410PJ8=;
 b=jzp8KRei5PjjrYe4ElB7wMGM1Tlke8wSH6CsUJoXnFrW2U3xVs+6zwmD4HcS1lBCaFWI0ARPJnfnEX4l2srBLaQ/PbMUT+HZjtzs0r4DBJ0LIoFAhGVXJdRRjPg3InRDG9UvUwVgsBMpnTSjbW3qUi+KEWf8riSZdItwoeE3wI8oqYijh3uGBscHd3jllkGwalbEAqc3woNG1CBcnqOxgbA5VU3ThcdB60DCoXMjO49W8oHFIhDDCb9zmEHOqQbeqXCbrL2KVsNDrwbNof67op8uXzbPZ9RY0TVU6X7Ue8EjCPhu3/2ZNrVGZbQW296fFpHqojThGn4c4rXuq2nhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKc9rYAPCsFzuUP+b1KLTnLwPN91A5L+TJMvn410PJ8=;
 b=UOhdWK9zWyqQ+pkZzL3mIEI3FqoSqB/qCTrXEMzEfN7lKcLPf9lvEcE9s/6W9VYPO/Gf8vvEfYccU4DzxPXjJSDZyEwehCqhassuZyKnQsVsbK3WZVwW+zkRWjdxruGqDf4F1bAOPQhdT1vDkDd3iHlH/rlalU/dE06V6Q7WeuUo4o6kQWSXOKFyEFHO8G7l/b3pN6FVivdtUudlhW21qJquKDD4aQ7ZKLXFnzQe8OlA3b9sUxst7knDybq7PL2RyrXU+bpSZWtJVnIEv/IJVDmnseKmR9qXuslsCdDOxHPdroZt63vjOqpzQoX1IAX463BTkjypVbiTRYSNNstJ9w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB3PR0302MB9234.eurprd03.prod.outlook.com (2603:10a6:10:42b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:54:36 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 16:54:36 +0000
Message-ID: <c28c37fb-e5e8-446e-a4a7-b0d7de458caa@seco.com>
Date: Thu, 28 Dec 2023 11:54:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/12] fastboot: check device type for SPI NAND too
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
 <20231228153922.84323-11-avromanov@salutedevices.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231228153922.84323-11-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB3PR0302MB9234:EE_|VI1EUR05FT021:EE_|AM9PR03MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dbecd9-099e-4fd8-dc39-08dc07c5b068
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YGv0cNmJmD/aV9o4RGWizR4f7Idg/qpUaBdyj3RtPgiRpY+YTyHJnUEH47OAD8JQTtOgOihdI1VbVm2nLlQVXJ+ilEa7sFz3c/bQk75f4PYhfZwpviLuhFFGln5iEVl3T63W1troQnqcnMGyqbYNhMWAPS52XvbmZrMkm+PAizzLyYiAFIGF3WcqbSHmjDNmhWX8ojtIWxA7ARMqmB1sXTXIgT+MHXWW7V/ZTq+tfdvu8oNF0LcpU31Ca6cpCX32Rb2eP8gmDSN+Hr6x/vpkZROcbrglUg8C/7aOf07APwFzbvXfZQRlqDAWdHwZccbH39yQFabO3y8BOnFGlgy9Jbwl9xbSex+z7te7GjLM/DF7kokdXFwh8jUhf1ICAl0all8U+ePUAJvctUsxO6S5xuCvg6EFTDjWPW0S6V+0+Gep5JBYjJStGW0kOtZilTWQ23HwPaVXjTzeSvZAvF8wiYywfC2kI1cSi2rCme9tNi0vSZUH8MBwJo7WOBM3E4vsvtYF3CykXNHwCHPrBCykvvf0S6sUk5LRKjWqwnRaBzUg16wfmcDUkd/6t9N2UtLmi9mXP58inWQjnj2/56vRBzR9paVUn2iDnFwIwlswlmyHQ1nvB9AE3xgK0CAs6u/6T+Pag0XsKYzc7kelio+zl27bUOdJ8voQyjvvsBUb5NnOd5K1Bsumos/EBbtHSnGH/iQSw9fYsJZ23DiJ5b99/g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(41300700001)(26005)(83380400001)(8676002)(8936002)(316002)(5660300002)(7416002)(2906002)(4326008)(4744005)(44832011)(478600001)(66476007)(6512007)(6506007)(52116002)(6666004)(66946007)(6486002)(66556008)(38100700002)(86362001)(53546011)(31696002)(38350700005)(36756003)(31686004)(921011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9234
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT021.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e6229894-46ef-4f67-bc45-08dc07c5ac52
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8j7nHMrmICgSPmGpJO0mgFZg60ZKO2/ExZWDSo8HU8RHdv/Ops8ja3QvI87CPWflZP4FerCHVEpQC6X5DWlZC7u10ZISw0tBYevSNLEXn7S41Am3O6A1DtgyycnyltAWgUkTq2BfhlAX0y1RAy9vlJpt9VpQcsJqJYDKbAztDDwJ5ZsPggcf1HpHV2LvDr5dx+5Kz8LI1zijAH+2NghnV0x7jmqijn1K6HZwEXm8R7hUQIH1yfriEiLH5CoagBJXd71/n8g9hXAxasP0zNl5FCwAVfHgrA5ZxmWnLzzaCQx0mXSO0HvI7zmfeYUKNLcrmac3S209QIv6tTbtKhjPJz3vxnftKg5R5y/vXR7337ViJoJ7VZBkFVTZotGGeFlKbVAToOubwIIb1kLntMmSDRjA+zf6p5VwVTpEvn3A9XuiUS96OHMYKEZ1he5d8j9Z4rkt8Do5V6hjb2uCj6V+1qzcsB1ttEXEsMajAMVJRgdJJrTqfbYKTrm3wINyYhiuclgYV0a9KQIrWIjHwupUTbky8tX0xGKZAd3ASoTs0C9S+SKKTPENgJaBX6wLVoLbQ8ETJ4Epg7pj1f9Zjvqe4rbEpJAVrfZsCTIHj+r+/PQLRlbZfO2SSZE1CAXwLjy7mifvGhWK6AentJeJRcoNDoQ+uM5TbqiaqDlh1dWmX+fh83nbQ7tKMzdVFv0DWlwQQ5wVoDKnrAkhoS1Hj90vgZvgf6ILif0pJF5twQa5y96ljVpHJ19eiTVDXDUYlyc6Aq8jMMQrbW21cYATuUorAjprGJ49ScGLHwnRxUqji1s=
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39850400004)(136003)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(34070700002)(478600001)(5660300002)(83380400001)(8676002)(26005)(8936002)(921011)(6486002)(336012)(53546011)(86362001)(40480700001)(4326008)(70586007)(70206006)(41300700001)(36860700001)(31686004)(6512007)(44832011)(2906002)(316002)(47076005)(31696002)(36756003)(6506007)(4744005)(7636003)(2616005)(7416002)(82740400003)(356005)(7596003)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 16:54:42.8444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dbecd9-099e-4fd8-dc39-08dc07c5b068
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT021.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7852
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
> SPI NAND devices also supports 'fastboot erase / flash' commands.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/fastboot/fb_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index 6d3a900c77..39d888301f 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -53,7 +53,7 @@ static int fb_nand_lookup(const char *partname,
>  		return ret;
>  	}
>  
> -	if (dev->id->type != MTD_DEV_TYPE_NAND) {
> +	if (dev->id->type != MTD_DEV_TYPE_NAND && dev->id->type != MTD_DEV_TYPE_SPINAND) {
>  		pr_err("partition '%s' is not stored on a NAND device",
>  		      partname);
>  		fastboot_fail("not a NAND device", response);

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
