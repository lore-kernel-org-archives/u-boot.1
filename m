Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C29DC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6135F87A69;
	Thu, 28 Dec 2023 17:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="jVaTnhKh";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="jVaTnhKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5505387A53; Thu, 28 Dec 2023 17:45:23 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579EF87A72
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=CNFVxsV2SdcMSrt57YIjsToAHsgsgvn2F/Fe8watpVg3pw+g/ir6tdYe8hjI4NbNk0kpanylW+xnysdY798Xyj3eLwzvJ3IB6fu4TR196RDEGZXVpYBzIVjDgn/5kZF0qAUIbwVQ7bW1Yu3NN8/Asm59Y7FufpvIjnt25sVGHrwE752NzrPGiu+k+IiCxgNl+idMMhnJc14qGX9egFlQLNaaW8OKnm0JE2ff7Q9ebhoBp5qa8Q3p/3cOq0rDAQOROapKsM/Nxo59B56yTKg5d3IuPl+BZtJ1/yexi0DgHyrAYGsgBkqPuba5HV1EGncS0sPo3Elcln8hi9p6D4UC6g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz5zke6DkfCBt1pd/IbXaJLUom2YMzGRgQsUN+SY99Y=;
 b=CTFM0EXJmhmm5s2Uxx69raLKJ3DDF/80VaXZzSl1wyoZVnrtT0xnhZ9C2KOoZCvjOa2QoY9eFoN/Zg+skBZOQ8EGPQQkhhW9RDb5Jt9XwnkmLHl/xk9/wC1Ty2PDu6tbZDvh+HBO3vVAWvU/RDw6HViRz9Vxs5bJtwSl/KwRaRORgL3H+2rTRVyVHcXy6Kyb6p8ZmDLlz6nlBUKZVv1XwyUXa4Ozh9vlfKy9D6/i4JgEpGLLe4VsG4G8r+sZSUR8pmcfUXwiTOxdLmFZPmEiG5u3cqKdpLA7GZMGzuvJYYZIFDzgp2cQIQr/TI/ZziPzgQ2ldmqJ76yRkbNhyMXw5Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=baylibre.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz5zke6DkfCBt1pd/IbXaJLUom2YMzGRgQsUN+SY99Y=;
 b=jVaTnhKh1ug9BvEDRPt9icG6J2u3fCCoipjTUyiK9eyFXttvZezNam2C90a5n6fMhj6K0/GhKAShLOC3rkjpWkvdmSyDA8cfYa3uSSqjCqGsqeXl6P/cB4YXzpXIqBIZnfqtlZpslp5Id/+lPpTjOuFZoP9/mJrA26lvdl9ANiDemTD0YyAIPTbKk9vRKjSKVg4C3CPnP3u/m5aRX+9vIPZXZClhVKs3bFVDA2/3owyNZGtwrbiJ183+qelHPXEcQX5cjZcGoCOK5jDmUMTVlJdr089Gz1uHsnZlVgxlTdoqQwLc0uPF/iJXuHyJQWUHOX/VgF850DYZmHyXZNzYgQ==
Received: from AS9PR06CA0725.eurprd06.prod.outlook.com (2603:10a6:20b:487::11)
 by AS4PR03MB8315.eurprd03.prod.outlook.com (2603:10a6:20b:506::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 16:45:19 +0000
Received: from AM6EUR05FT028.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:487:cafe::dc) by AS9PR06CA0725.outlook.office365.com
 (2603:10a6:20b:487::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Thu, 28 Dec 2023 16:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM6EUR05FT028.mail.protection.outlook.com (10.233.240.253) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.20 via Frontend Transport; Thu, 28 Dec 2023 16:45:19 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 1DFC320080F88; Thu, 28 Dec 2023 16:45:19 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.11.41])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 46F3B2008006F; 
 Thu, 28 Dec 2023 16:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEQtYB1StehROAwFxl5uVgwvdP0jtTjeTmUfJkkvC/hFdbIkkK+a2QLV7lwOMvsNoJ+y73/Vl7RhkzaSIadPrZDV/i4jEiG/3yPKFCPJ/XOLOj1uS307aqEwa9pfLuHyjTvMAjMBsDJ/JPvF19xPtP19TtxbJv7yLiv2CkT4WDk7zOc7qW553/ARISCtGfY7UskgcMCFuaJHyNxle9ENbqXzvyRiZ4MVAw1UyEPV34et3hOLIwsw+rg4W4U+xy+NxlXT+VsXq5YcVvzx55khMyBziTCoVQ8D4lTyK96+UPvB3H0Wqv7Rso6kgIEM9EgGx2A/dNrqzhbO8aQ5V8r73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz5zke6DkfCBt1pd/IbXaJLUom2YMzGRgQsUN+SY99Y=;
 b=jlYcFgd09dbzHwUCCVgj8r9DHSLaPl8lksrPOovBtsgnfU9JorpZYc8aQUURuDgpRFmIm8VhuKQMxgn9/SEGqRYklOrFnsAKCMzSeYpT2w5cBcyykXN18IhNnYiTyJ6wk5YsPisNs4zxmLLSA93bUP84GlAe9MgJt8lazyyB4h6vTzKkq5oTXEQ8FsrQP00uWXfuToWIwArTtgqXwRqe/X2SUW2I7/enK0AURlaHsiDSGkfihwO+IRUODgSCpM4lJd/JoTepG9+10iFLa7dU+/kqDRd78UM9DNEHeDebo1HG16jZGoSGDSJRglaa4ghc+S5y5BNXff6tY4S9+K55Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz5zke6DkfCBt1pd/IbXaJLUom2YMzGRgQsUN+SY99Y=;
 b=jVaTnhKh1ug9BvEDRPt9icG6J2u3fCCoipjTUyiK9eyFXttvZezNam2C90a5n6fMhj6K0/GhKAShLOC3rkjpWkvdmSyDA8cfYa3uSSqjCqGsqeXl6P/cB4YXzpXIqBIZnfqtlZpslp5Id/+lPpTjOuFZoP9/mJrA26lvdl9ANiDemTD0YyAIPTbKk9vRKjSKVg4C3CPnP3u/m5aRX+9vIPZXZClhVKs3bFVDA2/3owyNZGtwrbiJ183+qelHPXEcQX5cjZcGoCOK5jDmUMTVlJdr089Gz1uHsnZlVgxlTdoqQwLc0uPF/iJXuHyJQWUHOX/VgF850DYZmHyXZNzYgQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB9590.eurprd03.prod.outlook.com (2603:10a6:10:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 16:45:12 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 16:45:12 +0000
Message-ID: <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
Date: Thu, 28 Dec 2023 11:45:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fastboot: introduce 'oem board' subcommand
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>, sjg@chromium.org,
 hs@denx.de, dimorinny@google.com, mkorpershoek@baylibre.com,
 patrick.delaunay@foss.st.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com
References: <20231228152522.83291-1-avromanov@salutedevices.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231228152522.83291-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU0PR03MB9590:EE_|AM6EUR05FT028:EE_|AS4PR03MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 3632a32b-b227-4cde-e0c2-08dc07c46074
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6m0oQFzNH7aYwAk1vU96LgHJDFn4xBFRQP+7kfy6ZM5SMHK5eraZASu9AFpPTh8IizYWGYMcr1e3dzJjnmgAsMBiHZwOn7pQJCTiEtukysSP8dUrlHmpKbX4hmYmh1YRJbOOUszrFUo3+DvU99qiuGQjKj2c97z4/DI5ajwQ+iAnTx/0nAjPPdtP8CPPH7iJgruhheNNwCFEk5ypTtLvyzzTZu1ISfEQQFboJGvX0sIFvPvzg8YJGh77/VgBFP8BvWzPmGsp0YKX6kohwlgxLVOTQkFXQYm1OeUrCSPO5633hVZLTnChodGeT++uxNjGJrKnhKJnc8aTH2F+eau09+8G9MAks0I1K6DnSV2fLcCVw2b2FyconJnE7E870xt9bm7noSOZ1F99yo3Wasznn9n/vphQVMz/vLN5x2FbVxHymEpNJtFL2tD3ypRD0yuX6M5xhpF/MwqN99C3RL9f8jrjNZpA3UJlind9f+nYu/zIjOUh1w0GGA4aHa7fOmjtC/TxOiMpn62uN5n1kPVspXviX/0sIRbtyjzOkpSWHbZVPNHFUDNsqHSMaZodrhUsNQ5BvwZMSk/Okdgef7wSdLgNmq7Vr7w9j2krNOgmqJrynPY8En072p4bDkg5tIxbZvhD0t6hGAfwNVpiqRU/tl+osXjW0XA6Dnrc1tUtCJw4Bm0wlA9MAuqjp7leAgIja3qAj8Tv8DkLcX2GMTApyA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(36756003)(31686004)(52116002)(6486002)(6666004)(6512007)(53546011)(6506007)(66946007)(31696002)(66476007)(86362001)(38350700005)(316002)(26005)(38100700002)(5660300002)(41300700001)(8936002)(83380400001)(66556008)(2616005)(2906002)(478600001)(44832011)(8676002)(4326008)(43740500002)(45980500001)(139555002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9590
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5081024b-74d2-43f3-7dd7-08dc07c45bda
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiRpqr3njN3MnQTqcuXwlJsd+H+/Ep7Xvsr0o3hcxvyGwOa9NrJOq5DTGadXtdLGYH08cI8gZszzG1Zko8xjaXPjYql3KkILOZlB2KiSRxCeLznvkrX0H9P0vk1ad0veXXQm53KPultLAJ9V/T3DC1J6mS0hYoSAsFiKPFEfh5KmRcedXGRA8YZtwublD2UvIJxSWSLZluneSxECEaGB9SwevLdBoSNfSYtGgigmb5QLb1Btg/29pdYHTHaU6JmTepLD53UXEIl9TlLtgwxNBSotRqvn3WROVwF8Z0tKt+NTn2l/QnaAtaRiJqUWgA3SLeYgTvwVZZ+eq1DS0iKcQsFCs5nAdOTW3F/uBXd7fknujXCl/wQQyRlbiwgxX3K/OAeH0rY3GHkJe+GkP8cO2pjA6hjX5oPnq4f4eZWgHuYIbu38/cpoZRVd4jULs88iEPNVZLZsmQBHEem+CTW1OZVJyQPEqt5IMAA8xR1i2/jEhupAxcWSamwsfpJGchvq2RRW4WHNppuRxv6hu+lXV++sGQY6gaDzyTrsbkEVtGUhUJVtpBtgfSxyCGOK6Zqn/+Um98PJ/7XaBfSKWHmT6DxdxBTlO4PfnqailUDIMf9o95upRyNS1DY1J50C6/wWMeVh7NP/XCSWPXL7ZMqRzS0BmnEf3oj6jHCrWr5iE2O5sv4ctTVkWuIFvj8LIIVzqrDgOL9ukpzPAjPFUxS5U2XgwBIe81mqsKQSG8Y372hFn5rTCD4J113vR3rBDvVBOv3VT/a0dA3rkslYFa5yXaeKnMtpmRKTcD2tLuQjuZc=
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(2616005)(47076005)(83380400001)(41300700001)(7636003)(7596003)(82740400003)(316002)(26005)(5660300002)(6486002)(8676002)(36860700001)(8936002)(4326008)(44832011)(2906002)(336012)(34070700002)(356005)(478600001)(53546011)(6512007)(6666004)(70586007)(6506007)(70206006)(86362001)(31696002)(40480700001)(36756003)(31686004)(43740500002)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 16:45:19.2555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3632a32b-b227-4cde-e0c2-08dc07c46074
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8315
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

On 12/28/23 10:25, Alexey Romanov wrote:
> Currently, fastboot protocol in U-Boot has no opportunity
> to execute vendor custom code with verifed boot.

Well, I would say the most conventional way to do this would be something like

=> fastboot 0
=> source \# CONFIG_FASTBOOT_BUF_ADDR

and on your host machine,

$ fastboot stage my_script.itb

where my_script.its looks like

/dts-v1/;

/ {
    description = "my script";
    #address-cells = <1>;

    images {
        my-script {
            data = /incbin/("my_script.scr");
            type = "script";
            arch = "arm64";
            compression = "none";
            hash-1 {
                algo = "sha256";
            };
        };
    };

    configurations {
        default = "conf";
        conf {
            description = "Load my script";
            script = "my-script";
            signature {
                algo = "sha256,rsa2048";
                key-name-hint = "vboot";
                sign-images = "script";
            };
        };
    };
};

This method is especially useful to pass complex parameters to your command.
This method of course requires commit bcc85b96b5f ("cmd: source: Support
specifying config name").

Would it be possible to use the above method for your use case?

--Sean

> This patch
> introduce new fastboot subcommand fastboot oem board:<cmd>,
> which allow to run custom oem_board function.
> =
> Default implementation is __weak. Vendor must redefine it in
> board/ folder with his own logic.
> 
> For example, some vendors have their custom nand/emmc partition
> flashing or erasing. Here some typical command for such use cases:
> 
> - flashing:
> 
>   $ fastboot stage bootloader.img
>   $ fastboot oem board:write_bootloader
> 
> - erasing:
> 
>   $ fastboot oem board:erase_env
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/fastboot/Kconfig      |  7 +++++++
>  drivers/fastboot/fb_command.c | 15 +++++++++++++++
>  include/fastboot.h            |  1 +
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 3cfeea4837..4c955cabab 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>  	  this feature if you are using verified boot, as it will allow an
>  	  attacker to bypass any restrictions you have in place.
>  
> +config FASTBOOT_OEM_BOARD
> +	bool "Enable the 'oem board' command"
> +	help
> +	  This extends the fastboot protocol with an "oem board" command. This
> +	  command allows running vendor custom code defined in board/ files.
> +	  Otherwise, it will do nothing and send fastboot fail.
> +
>  endif # FASTBOOT
>  
>  endmenu
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 71cfaec6e9..4d2b451f46 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
>  static void oem_format(char *, char *);
>  static void oem_partconf(char *, char *);
>  static void oem_bootbus(char *, char *);
> +static void oem_board(char *, char *);
>  static void run_ucmd(char *, char *);
>  static void run_acmd(char *, char *);
>  
> @@ -106,6 +107,10 @@ static const struct {
>  		.command = "oem run",
>  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
>  	},
> +	[FASTBOOT_COMMAND_OEM_BOARD] = {
> +		.command = "oem board",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
> +	},
>  	[FASTBOOT_COMMAND_UCMD] = {
>  		.command = "UCmd",
>  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
> @@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
>  	else
>  		fastboot_okay(NULL, response);
>  }
> +
> +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size, char *response)
> +{
> +	fastboot_fail("oem board function not defined", response);
> +}
> +
> +static void __maybe_unused oem_board(char *cmd_parameter, char *response)
> +{
> +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, response);
> +}
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 296451f89d..06c1f26b6c 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -37,6 +37,7 @@ enum {
>  	FASTBOOT_COMMAND_OEM_PARTCONF,
>  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>  	FASTBOOT_COMMAND_OEM_RUN,
> +	FASTBOOT_COMMAND_OEM_BOARD,
>  	FASTBOOT_COMMAND_ACMD,
>  	FASTBOOT_COMMAND_UCMD,
>  	FASTBOOT_COMMAND_COUNT

