Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6822BC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 16:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C4D87A7B;
	Thu, 28 Dec 2023 17:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="YmGup2J2";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="YmGup2J2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D1687AD5; Thu, 28 Dec 2023 17:54:26 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD9C87A53
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 17:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Z0194cyhDGIGANPIlSSGHhnaJnHCK4tUmfcILBxpcpW5850QnFcpqI2yAqzUjdlvt1elWqnqYDt+7k4TIVPSECgk7ScqEjGx6qUx/BKuhc7JqW+a3Jv58LGo+KUS7VwQXIYxvNeOeCa39sfLlWm4pHleVWcEgob5cpsblJTjjQmha7XRtrvE5W9GrSh8cfsEBuRS7Ytf8CDHgivsFwiesaC/Zc6WbGGB0PoFfsj2kcpUKHkQ7aLTlYZ1IB8lKqproHSpD3iSjLDUJh1mROsBv5vOSrBbIpmyRDk/hB8e+G56cyMpB4GMT6RMw0qgR8ZmL13IjzqtnCqnGsQuil7qvg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIraZ/cEVyZ3h8JTW1P8eGShgu6I24Aby84lqtQovwE=;
 b=nBg00adWSRyb9DaoMgaRWmtC/FwcY3zrNrAviqeVfsuea6uZXZI63BB3dvcK6UFolq554wn0b0I8WfOJxi+8qXk0JR6sVBeqDACeq+FuyPAHs1XvIJEAQN7ReLlPgSthYz74qy88g3an7jYHXAns0gIkra80fmz1RH9Zrxp50vRKtV80TaP0knC4k3HRxg+3VGiCBbuwv5XRxeT2fyyVMYZUjyuPtMxlN3mTvPYD30WvLW1M0WL4+VFpt9lWOV6oUDqNm4QB8V5xCz+DCQrTj3snwg4i3D8pYC+bFYMhZfSlkLMA4q3OrxiuJhrE5fQnjBSgyJ78Nt23bKur4OYTuQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIraZ/cEVyZ3h8JTW1P8eGShgu6I24Aby84lqtQovwE=;
 b=YmGup2J2dbNtfPLFePmbiY2AZjmAS7A2PaaAz3hzjbRM5FxXP3oriCfhB5VlCoyCS8cbBTD0PsYP/J8CxPJ56t77m6g97lIAolF2Mw2ynZURuXBMTdQPOXad5Ht9L8vLdiaWejvQXmWJQgzd0U3ZY1bdgMkXTpIEnnhcfWgj4nr1daIgxB1yrUFJoRA56Ns2FOZdCx/G1jOIuwc9IK0zsivVi29eOG6JZOKBrfMdqFGzbDLaLGoOM32mzjC1mY0PSaXQdd5nvwK0R8Az70MVJaICXQxhqt77AqXhGm46D5ORvp98XjCaZYdqMtFjmHR/MbvNckUELnulsC91DVmsYw==
Received: from FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a1::8) by
 AM7PR03MB6385.eurprd03.prod.outlook.com (2603:10a6:20b:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 16:54:22 +0000
Received: from VI1EUR05FT009.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:a1:cafe::f9) by FR3P281CA0096.outlook.office365.com
 (2603:10a6:d10:a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19 via Frontend
 Transport; Thu, 28 Dec 2023 16:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 VI1EUR05FT009.mail.protection.outlook.com (10.233.243.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.21 via Frontend Transport; Thu, 28 Dec 2023 16:54:21 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 27C4F2009538A; Thu, 28 Dec 2023 16:54:21 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown
 [104.47.11.233])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id CBF6120080075; 
 Thu, 28 Dec 2023 16:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN/swLAieaduj/9OlzgaVZ0wqBfUCxSD5Z+n2rSrS1AZreYSO9ti0ILWrAUANkrY69jJ/3X8YZ0Kv+vvPXL54PEf8d+WK2VzD0kcB9uM78uljRE3/Rw0l3ipcT4vD15h1cVVBsP6VNTl6QgJvYusq9Uls15oZbo3mv/oBqsGNBnrOI1khwoPdBzU0DviyqZg2OyJbBCHty/jexJ0cet2W3zPwovGcN3NNrzkIByHxMiwytjrNuWfOtoxqDV+/6OxN2faLxlfoVyYHDAugI5ZDwEN6Wl7zowEJzlg6REzVjk8hKD5AhjMLBPMbgRcbrVUFmbfPZ1jhUkNgKbGcvyEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIraZ/cEVyZ3h8JTW1P8eGShgu6I24Aby84lqtQovwE=;
 b=MUK2hSwMZvVdvI0u+wNlMurmLY6DgXjuOz6iuOLd+66D/GWACkoXTMal8KtCK/CwQ3VDx3kVy1Qpg++DzJvj3v65SciS13VT6TgbVSkuxLl1RdAIT57Suer0YcTJ6Q95RKtAXZj6H8ZcwFlSIXOwlhfgf/bbMwsgkyE1W5VmfovSLt+5yfG70jY8QeZTejEdDhP/trdUh5uZaGv31K5mMzzwkJD7D+j27/WonKEHbEQECix9KG6DMqjNlEeSXZd2q6+dUgqLtowcLdCqZ44y2zHDlYqmqUgPmBLPpy8WR2oLL8Fx30XrWXRc9P0l6dkdMhHOT2UPyu0GR6e1PyCHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIraZ/cEVyZ3h8JTW1P8eGShgu6I24Aby84lqtQovwE=;
 b=YmGup2J2dbNtfPLFePmbiY2AZjmAS7A2PaaAz3hzjbRM5FxXP3oriCfhB5VlCoyCS8cbBTD0PsYP/J8CxPJ56t77m6g97lIAolF2Mw2ynZURuXBMTdQPOXad5Ht9L8vLdiaWejvQXmWJQgzd0U3ZY1bdgMkXTpIEnnhcfWgj4nr1daIgxB1yrUFJoRA56Ns2FOZdCx/G1jOIuwc9IK0zsivVi29eOG6JZOKBrfMdqFGzbDLaLGoOM32mzjC1mY0PSaXQdd5nvwK0R8Az70MVJaICXQxhqt77AqXhGm46D5ORvp98XjCaZYdqMtFjmHR/MbvNckUELnulsC91DVmsYw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB3PR0302MB9234.eurprd03.prod.outlook.com (2603:10a6:10:42b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 16:54:16 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 16:54:16 +0000
Message-ID: <7bd0dfd4-6b04-4e49-93c6-3f09a2a0b2f2@seco.com>
Date: Thu, 28 Dec 2023 11:54:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/12] fastboot: fb_nand: add missing newlines in
 pr_err() macro
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
 <20231228153922.84323-13-avromanov@salutedevices.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231228153922.84323-13-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB3PR0302MB9234:EE_|VI1EUR05FT009:EE_|AM7PR03MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 4348c66b-88b9-4d7d-296b-08dc07c5a3b2
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bMPD/UDkKweRsvImo1QYADai/VYHsD6+AScPDzD44+BPpBUB0x3LGUmHmATD4osbzkRLU69kpoNbgcd4m3hdNZXcqJmvmGtVV59IpZjxK+XTa658+rOi5v8r3vAVrOmSAFwzQwbZAEyLcC3UqBEvZ9+z6WkRnp2P4EZ7OCjU5YCostA5G9s03mVAPRPzu/v6rmEAfVNZHJTXGN1WruXuSQiWyeL6KGEAWzaKfP5Mrqni4UIwzLS9LmrWGL5gOuDZdEZvdOxk160k3aXHt8A7IZS14QJEz6TQHeeJOkTVNRs/e9kCca1T+vKG24VK7d11H/LZvXymOGx/8+jwKoRfFSqOuXtV1okXiZ+G3NJffPTM3S1QTdWAeSgSiArzg22x44H41qTRAhE3wPE4ktWt0EMb81t4v2Wqx3DldzEiO2mK4pvLn4KQIstgNkgB5fFNbchQpTQXyprsEP1yXtlRYXWSjIyoLK43ZL/F+Ea14emwc+fiUnTc4Ox3QYnbd/NaptLOvKEHBV3YciPB/1mhqg0rSK2OBp6GjgdTrrxjVVRU7x4QnpOlNk96cfh4Vg8CZ7CKNOtgF4Z9gXiZUp/4OrvQNkmcXVm37gVhC+1Hby5wgTrMt+iuZF4R9asYXAsEufw+lg9Y89EsVOprAFfHZ+CHpL8AOm1Mq8vGQz3YvIFGVc8ppG0RwR9M32c1vjlL4gWLrEUxH0omuuc1VUf9GQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(346002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(41300700001)(26005)(83380400001)(8676002)(8936002)(316002)(5660300002)(7416002)(2906002)(4326008)(44832011)(478600001)(66476007)(6512007)(6506007)(52116002)(6666004)(66946007)(6486002)(66556008)(38100700002)(86362001)(53546011)(31696002)(38350700005)(36756003)(31686004)(921011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9234
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT009.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3f2bff23-adc4-498a-2f1c-08dc07c5a0bf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pl6WFj6Wwkv5iiHdczpefw2jUaRrkzcQVyUTytEcgDChsphvRz1hw514xvDQBBvs8CXVyUVzcUCFGgBmVUFuOInVGe7Cpr0amGkGpnNlhpg2GE/5c+UDlu416Ud63LYUvIXPf9MTiXyVYvC+9MI/YxzJhzruty2VCTqERFYhrcJn9+1YxNimKtnO35k25NTlelXILucFX9AfsvGTRg8NaMnniPpP+wQ/Tfsvhi0aFtsYh1rFbjkqBm9GAYt1gr/HwvM8alGlzK0zB2xTD9lUBZit42KfDaB+6T9awXF5ebhrJYHds3iG8h+0HYQ3/My68cpjoRhT+I9Htt88YbUDH8IWcEn/usWWmwR+68Kxg6KSYPAgDA0CGPAN7YA3neYgw5U2DANTI2iQBTUu8dtSdIzyzypp/PCA4gWTmQ2lsV4sP4eHvBIuLR1Vp3JCMAJdiGmwMFk7GP3o3QuU/Vz4vr0bt8B1z5kFLUKHlAWaDP1dh6Nw8k2D9pOtExb5wRJ/GOxM3YePe88dAKmdmFzdyr5UOBw0bLTq9kwbRxS8r8Zf193iJsB6WAl/FF6LCJtiJz9drDHEoCtUTXqPQzO+CBlxgadHJvNeeYPzOFMCdy1OK31ozpadFa+Lyhys7RtCpONOilvIzMcRyD25AnqqN/R98JvOu79DnvMF6+1HKBOQ1OgECEQjj92DC8uGYp/IMvGKALoviirCU6lPraCSnxi4kdcO3X6Gqab/Glt92K6PAcB/lcII1ImpTDNRqkEZqZ/1rshnf5gzJCH3qERbFAJZzkxXFuP1mCg/Tk5gidI=
X-Forefront-Antispam-Report: CIP:20.160.56.82; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39840400004)(346002)(136003)(376002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(44832011)(40480700001)(2906002)(7416002)(31686004)(921011)(70586007)(70206006)(5660300002)(4326008)(8676002)(6666004)(8936002)(316002)(47076005)(53546011)(36756003)(478600001)(86362001)(31696002)(6486002)(26005)(6512007)(6506007)(2616005)(336012)(34070700002)(83380400001)(41300700001)(7596003)(7636003)(356005)(36860700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 16:54:21.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4348c66b-88b9-4d7d-296b-08dc07c5a3b2
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.82];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT009.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6385
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
> pr_err() doesn't add an newline symbol when printing.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/fastboot/fb_nand.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index 39d888301f..9db1903e41 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -48,13 +48,13 @@ static int fb_nand_lookup(const char *partname,
>  
>  	ret = find_dev_and_part(partname, &dev, &pnum, part);
>  	if (ret) {
> -		pr_err("cannot find partition: '%s'", partname);
> +		pr_err("cannot find partition: '%s'\n", partname);
>  		fastboot_fail("cannot find partition", response);
>  		return ret;
>  	}
>  
>  	if (dev->id->type != MTD_DEV_TYPE_NAND && dev->id->type != MTD_DEV_TYPE_SPINAND) {
> -		pr_err("partition '%s' is not stored on a NAND device",
> +		pr_err("partition '%s' is not stored on a NAND device\n",
>  		      partname);
>  		fastboot_fail("not a NAND device", response);
>  		return -EINVAL;
> @@ -178,7 +178,7 @@ void fastboot_nand_flash_write(const char *cmd, void *download_buffer,
>  
>  	ret = fb_nand_lookup(cmd, &mtd, &part, response);
>  	if (ret) {
> -		pr_err("invalid NAND device");
> +		pr_err("invalid NAND device\n");
>  		fastboot_fail("invalid NAND device", response);
>  		return;
>  	}
> @@ -242,7 +242,7 @@ void fastboot_nand_erase(const char *cmd, char *response)
>  
>  	ret = fb_nand_lookup(cmd, &mtd, &part, response);
>  	if (ret) {
> -		pr_err("invalid NAND device");
> +		pr_err("invalid NAND device\n");
>  		fastboot_fail("invalid NAND device", response);
>  		return;
>  	}
> @@ -253,7 +253,7 @@ void fastboot_nand_erase(const char *cmd, char *response)
>  
>  	ret = _fb_nand_erase(mtd, part);
>  	if (ret) {
> -		pr_err("failed erasing from device %s", mtd->name);
> +		pr_err("failed erasing from device %s\n", mtd->name);
>  		fastboot_fail("failed erasing from device", response);
>  		return;
>  	}

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
