Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01596C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 15:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B3B87807;
	Tue,  9 Jan 2024 16:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="lZQ/8ZTD";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="lZQ/8ZTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3335386EEC; Tue,  9 Jan 2024 16:46:10 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25B287807
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 16:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=V4s1VC8WPIUkpHpz/b6LdHIbOPdErOs+xTcdktTrUDljqmIDqqkJfPgVLZshWZmIpWVTkFpvp9oWWKXsCiZnmKFOVDKSeui7me40qvJL3uQ8pV5fL/9KhadXXk8wC/5HdfxA9ccinEBSXWxoBpdEIZKmgeO5JlkfBgFL9GRh0F2vdFP5/I9hB3tWhk/v/gtqVf3LnuAA8IO3CkqoirT6bhWr92Z9wzFNfKksN9q7LSlsM9wZ18NRt5FDqPzf4dr1iGhyHPe1ViMXsMX98yMYuV4kiWOJvjBITU/xvXwAVJpeC0T3dZ323ppzWYSU05b7TVlTZiAHyiobJ4AR117vcg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv5NiK9/edhxbcikOVejT5ZW2Vhos85wCWEn58od6IM=;
 b=RsuXxdHDy3ZnxjZPYSy3IDR2lcIlAMnwUqURx7YoRpWRm3lhJxw2YJnTMXVVWCWo568pzP8dWljGm5F4ihbHupI28fn6Y76hQdROuAFSj3NpaplhjonHaiBYVFt0PykFJ6iTolOfXaKNxyhzUSrV7cgeeZ5CO11cNeXGfqDFQx6+V//TxMzQkX54hlaR+fKiULrmqWz9OL6c7vNoAnX51LoR9jE6Y0wrCmgAHK5Gs866bAjaScn+HbPZdUlUOBXF756/CsVpmEB6dUmOv/GlRAX7fPtfyrWFjG4y2UXhIxV/ffOuytqu/pb08JclOnVdlWi3EjRdCWhMfQxeH8COMg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv5NiK9/edhxbcikOVejT5ZW2Vhos85wCWEn58od6IM=;
 b=lZQ/8ZTD1xxZ2/FmW752K/cenwOQl7jA15KvMOKYJOngqiOJtet4IMQva/3JYlVRI1v4sarzdw0pAcIFfPTEiyjy3nv40bKIndR3gwa3lCyDMqblB3gB1QqBPuQ3XcpcFfErwWc3fg+ejKQSZvAILWxuMLyOyBHgJlQ2YCA64IVODNZPpXNe+uLfrAghpsbeLxgXtjHOITBfOFWVfk9n//Au/HzMJLXxosKgbgZdU+mkQkwqB2R3ArH3jsZAkoLlhE4f6nnN9vjQMv9Ed9PFfDEyMuzNQOJrSXihb7mbwVPB7q19zh7Tis7COfLv9P5a07RacwDvtSrtcUp7lI2Fyw==
Received: from FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::13)
 by DU0PR03MB9424.eurprd03.prod.outlook.com (2603:10a6:10:41b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 15:46:03 +0000
Received: from VI1EUR05FT061.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:48:cafe::60) by FR0P281CA0050.outlook.office365.com
 (2603:10a6:d10:48::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15 via Frontend
 Transport; Tue, 9 Jan 2024 15:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.83) by
 VI1EUR05FT061.mail.protection.outlook.com (10.233.242.254) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.32 via Frontend Transport; Tue, 9 Jan 2024 15:46:02 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 33AE420095380; Tue,  9 Jan 2024 15:46:02 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 1551C2008006E; 
 Tue,  9 Jan 2024 15:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW/gO/rnWMfIW2etbjmzJDKVMrLqfFu9jvNZ2Gd0EBznkgt3OUTWMM4+0wKmE1MWcaDgnqyhP0x9kS5v426mnwOvkYB6JRepKkb2KjzxPmsAUFFlZUWXSvzhn6PMcWRWB5Zzya4Q1rMtH5w6CIldAaDP9I1MBq5yti/F3vzwuj9EJb6uvhGcYVwZijMCKFnDef1hPbuMKFbBLZPiM8w9+p8KCFGG+w/wQd3jnEvurGBUVGcC3jq5mIb7420btvc6PoUjPY1s+0eR7CRDfBOrY1uKqxmqwBMRQpYvtDDW/IlC/9kECSY49NIZ4d3bOSBznEVk+bZAeOgEFDQ1d585Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv5NiK9/edhxbcikOVejT5ZW2Vhos85wCWEn58od6IM=;
 b=ThBorxuJ99khcyQgDy8E7JDTsECmG5Z91ziYQRTchlh4rmsIV/Dd6Tyuea+E0BxcpXtL46bsLwbLk0lsX2O0w6KNnQe/ur1vSPXih2ffCvMrl8zP4DY802OFn7/7JeL0fO+1rb+uOYEeMFZc1M0Ld52d7ZbWBAWMfZdiPiqDgTv/VhVXr9k57w1yXemByRf5I3wVJEsKAfX7UVt4789W9NikAAz5ofIhI5wR2PHBiRFRpKnW1ccZ8gWaPmC8M+PrUaXgnKpMKBA+018wbu/rVIaVkR7jWZj80JPShYRIhjUgHiMKPydjtnOdAkvfm5An/7r1HVpsjU587JqBA8rM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv5NiK9/edhxbcikOVejT5ZW2Vhos85wCWEn58od6IM=;
 b=lZQ/8ZTD1xxZ2/FmW752K/cenwOQl7jA15KvMOKYJOngqiOJtet4IMQva/3JYlVRI1v4sarzdw0pAcIFfPTEiyjy3nv40bKIndR3gwa3lCyDMqblB3gB1QqBPuQ3XcpcFfErwWc3fg+ejKQSZvAILWxuMLyOyBHgJlQ2YCA64IVODNZPpXNe+uLfrAghpsbeLxgXtjHOITBfOFWVfk9n//Au/HzMJLXxosKgbgZdU+mkQkwqB2R3ArH3jsZAkoLlhE4f6nnN9vjQMv9Ed9PFfDEyMuzNQOJrSXihb7mbwVPB7q19zh7Tis7COfLv9P5a07RacwDvtSrtcUp7lI2Fyw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAWPR03MB9060.eurprd03.prod.outlook.com (2603:10a6:102:33d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 15:45:54 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:45:54 +0000
Message-ID: <48b16521-f1aa-4f78-ae9d-96832da0da72@seco.com>
Date: Tue, 9 Jan 2024 10:45:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fastboot: introduce 'oem board' subcommand
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "dimorinny@google.com" <dimorinny@google.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "patrick.delaunay@foss.st.com" <patrick.delaunay@foss.st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
References: <20231228152522.83291-1-avromanov@salutedevices.com>
 <a3aea373-80fc-4799-894b-b0879e63da39@seco.com>
 <20240109102746.75iqizxeo6fxq4cu@cab-wsm-0029881>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240109102746.75iqizxeo6fxq4cu@cab-wsm-0029881>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAWPR03MB9060:EE_|VI1EUR05FT061:EE_|DU0PR03MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: b01cfb27-38cf-442b-18a6-08dc112a1578
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lpF9u8HeWjKRhuGEmfRtvc3oPuqst4PEp2+YB5YL5Fs5uiWjkxrMctCqYaPcrHIs+nsXGtuG4ndryssLiEwYuuHm/BstQw+qIkwJ7OC+zxkdA5eGhajiNUZWCZQrdZ1zXjtHVwSk7e/BcH11Ja2cyPKBOVSll/viAgfVPsiqGj77TK+wMaMrzuyJknUskdxqT6nHUogEWqDOJn42uGt6p/E4k56chB3TKa61UMn/NiHorp3goHODp45gr2Qif9a+y1PfEm0af9h/RsPdcUtIJsgMbxMpRV1nA2kcVbFABIdjJPEvcx6KmDtlna3IdP7o4mo7yxrFgdCc/fjg3W4Ma+mdiO2cXHAYVzssdrmjghdxY9fM3AZDr7Or2CUMmFFN/kRzLoH1c8sOxyPF16EYHq2aw/Fs0GC1Cu2mUkDkOfv49+TtqAXygh/uUiKcOfYxD1Pv18bJ1ZVk/HZcKLOW8N42ewk1TLi4Nhj+JaMWrhyC6RVtsPVV91kePjqEJzC8ejtAbF3G6gf3IKYhxWnH0JN5e0duIJoF514sAZqBQRgRpbp1tBx6bpx4F1VchHcepvhVDz2DrKMSX71rK5x8j0q273DFm/olb3+ThfnmN2gd2Dwrn/AHHKOB3/gl4vGskodYhOu0IEEz0nmdLr1XGBHkDvEVUmrR/QwsxzUU3aHw8dzKqyZPGcYJdGalmt3b9OGj+/bnSPW1viK8M43Clg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39850400004)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(2616005)(52116002)(53546011)(26005)(6506007)(6486002)(478600001)(6666004)(38100700002)(6512007)(36756003)(41300700001)(31696002)(86362001)(5660300002)(4326008)(83380400001)(2906002)(66556008)(38350700005)(66946007)(6916009)(8676002)(316002)(44832011)(66476007)(8936002)(54906003)(45980500001)(43740500002)(139555002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9060
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT061.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a2606339-3748-40e2-4fef-08dc112a108c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9abNtCHVzPzCc9Wx4oIAhYVbSevMTpdHhHTZUPgCRrtabQ5YvUV6m8ZYauG0+21A12qUlisGnm9LB8VY4w+hUhYpg8T2Pu/QqRXOdf0oB+GB4p33g7lIgVspXTA8vQaw6XW6Qu6yluVDCfzNhqbGYe7JnTa1XrLxf3H6f70iCbITpRtt1nHrjgnFsp7oFTp14UaI3foYi8dKDvdTTEcCrH0ATG97n5Fq9uc7wdGCr7h8iHZ91Aen9vi8SbVtABQTNmgadHrgJ6D4nywSM9jZpgt/RzJPtmToL7SDDNS/LnfcEdw+4SVqplEcX7r/gdCZ/x1+fyzNEvBzVWET8NU/x/QI4qjCkr/Naf91NkCyTw1V3W0oMsYCYb8umHedodzi7zTCOVCBm4PwApDH8dPhVpw9nXpH9f8nt1URlbytm/xsmqEl8R7uOFTVYFXxIJAmAgmZ4XgilutVZK8xT6ZqKR6SWUtMwNFgzBMGdqmro0Q4Wi6W8MnRCoG77wUxEtSWS/ta44xX6tWLge180V/ZsR5q8ONXOHFmxHpYDBPKhx/XNtLePn98cYEmpA7scaM1ieriyVq3n+7LNPvJnBtpAq5sg5CVw7uyr4AxeadiXmioRAbgEulxDaW1X8Sl6OyoDFVAYJ3FSLz+HeLbvjsbG9yKjyClQyePKBRE9qW0CUdaMAb33LlQLjMW5BgxsLFw4mQCzjIiMzF1/kUXTNNJmGIc/un4FpxEZiSaCqzcrx26+d4BJRpCi80YHHC2p4QuYohYRkkr6VJ/O6/eeG54FsI1/ASstCMI1rmB8DyZ+8tOktdwyTA67JlRcZBhSpnz4fQXF2mVjE+t8/+i8nVIcw==
X-Forefront-Antispam-Report: CIP:20.160.56.83; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(136003)(39850400004)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(336012)(26005)(6666004)(6486002)(53546011)(6506007)(6512007)(2616005)(478600001)(83380400001)(41300700001)(5660300002)(2906002)(47076005)(70586007)(54906003)(4326008)(8676002)(8936002)(44832011)(70206006)(316002)(6916009)(34070700002)(82740400003)(36860700001)(36756003)(86362001)(356005)(31696002)(7596003)(7636003)(40480700001)(40460700003)(31686004)(43740500002)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:46:02.5164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01cfb27-38cf-442b-18a6-08dc112a1578
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.83];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT061.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9424
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

On 1/9/24 05:27, Alexey Romanov wrote:
> Hello Sean!
> 
> Thanks for you reply.
> 
> On Thu, Dec 28, 2023 at 11:45:04AM -0500, Sean Anderson wrote:
>> On 12/28/23 10:25, Alexey Romanov wrote:
>> > Currently, fastboot protocol in U-Boot has no opportunity
>> > to execute vendor custom code with verifed boot.
>> 
>> Well, I would say the most conventional way to do this would be something like
>> 
>> => fastboot 0
>> => source \# CONFIG_FASTBOOT_BUF_ADDR
>> 
>> and on your host machine,
>> 
>> $ fastboot stage my_script.itb
>> 
>> where my_script.its looks like
>> 
>> /dts-v1/;
>> 
>> / {
>>     description = "my script";
>>     #address-cells = <1>;
>> 
>>     images {
>>         my-script {
>>             data = /incbin/("my_script.scr");
>>             type = "script";
>>             arch = "arm64";
>>             compression = "none";
>>             hash-1 {
>>                 algo = "sha256";
>>             };
>>         };
>>     };
>> 
>>     configurations {
>>         default = "conf";
>>         conf {
>>             description = "Load my script";
>>             script = "my-script";
>>             signature {
>>                 algo = "sha256,rsa2048";
>>                 key-name-hint = "vboot";
>>                 sign-images = "script";
>>             };
>>         };
>>     };
>> };
>> 
>> This method is especially useful to pass complex parameters to your command.
>> This method of course requires commit bcc85b96b5f ("cmd: source: Support
>> specifying config name").
>> 
>> Would it be possible to use the above method for your use case?
> 
> This method sounds good for some cases, but we have encountered some
> problems that prevent us from applying it:
> 
> 1. Looks like this method requires access to UART (for typing 'source'
> command). Open the UART is unsafe at devices with verified boot.

Generally the idea is that you run source after you run fastboot. E.g. you set
your altbootcmd (or whatever) to something like

while true; fastboot 0; source \# || boot; done

so you try to source whatever gets staged, and boot it otherwise.

> 2. We use automation scripts to flash our devices using fastboot
> protocol. A typical example of flashing scripts (device is already in
> fastboot mode):
> 
>   $ fastboot erase bootloader
>   $ fastboot stage bootloader.img
>   $ fastboot oem board:write_bootloader
> 
>   $ fastboot reboot-bootloader
> 
>   $ fastboot erase super
>   $ fastboot flash super super.bin
> 
>   $ fastboot reboot
> 
> This method doesn't assume what something typing additional command in
> U-Boot shell, even if we have access to UART.

I'm curious what you actual usage for this is? That is, what do you need
a custom command for.

--Sean

>> 
>> --Sean
>> 
>> > This patch
>> > introduce new fastboot subcommand fastboot oem board:<cmd>,
>> > which allow to run custom oem_board function.
>> > =
>> > Default implementation is __weak. Vendor must redefine it in
>> > board/ folder with his own logic.
>> > 
>> > For example, some vendors have their custom nand/emmc partition
>> > flashing or erasing. Here some typical command for such use cases:
>> > 
>> > - flashing:
>> > 
>> >   $ fastboot stage bootloader.img
>> >   $ fastboot oem board:write_bootloader
>> > 
>> > - erasing:
>> > 
>> >   $ fastboot oem board:erase_env
>> > 
>> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>> > ---
>> >  drivers/fastboot/Kconfig      |  7 +++++++
>> >  drivers/fastboot/fb_command.c | 15 +++++++++++++++
>> >  include/fastboot.h            |  1 +
>> >  3 files changed, 23 insertions(+)
>> > 
>> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> > index 3cfeea4837..4c955cabab 100644
>> > --- a/drivers/fastboot/Kconfig
>> > +++ b/drivers/fastboot/Kconfig
>> > @@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
>> >  	  this feature if you are using verified boot, as it will allow an
>> >  	  attacker to bypass any restrictions you have in place.
>> >  
>> > +config FASTBOOT_OEM_BOARD
>> > +	bool "Enable the 'oem board' command"
>> > +	help
>> > +	  This extends the fastboot protocol with an "oem board" command. This
>> > +	  command allows running vendor custom code defined in board/ files.
>> > +	  Otherwise, it will do nothing and send fastboot fail.
>> > +
>> >  endif # FASTBOOT
>> >  
>> >  endmenu
>> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
>> > index 71cfaec6e9..4d2b451f46 100644
>> > --- a/drivers/fastboot/fb_command.c
>> > +++ b/drivers/fastboot/fb_command.c
>> > @@ -39,6 +39,7 @@ static void reboot_recovery(char *, char *);
>> >  static void oem_format(char *, char *);
>> >  static void oem_partconf(char *, char *);
>> >  static void oem_bootbus(char *, char *);
>> > +static void oem_board(char *, char *);
>> >  static void run_ucmd(char *, char *);
>> >  static void run_acmd(char *, char *);
>> >  
>> > @@ -106,6 +107,10 @@ static const struct {
>> >  		.command = "oem run",
>> >  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
>> >  	},
>> > +	[FASTBOOT_COMMAND_OEM_BOARD] = {
>> > +		.command = "oem board",
>> > +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
>> > +	},
>> >  	[FASTBOOT_COMMAND_UCMD] = {
>> >  		.command = "UCmd",
>> >  		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
>> > @@ -489,3 +494,13 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
>> >  	else
>> >  		fastboot_okay(NULL, response);
>> >  }
>> > +
>> > +void __weak fastboot_oem_board(char *cmd_parameter, void *data, u32 size, char *response)
>> > +{
>> > +	fastboot_fail("oem board function not defined", response);
>> > +}
>> > +
>> > +static void __maybe_unused oem_board(char *cmd_parameter, char *response)
>> > +{
>> > +	fastboot_oem_board(cmd_parameter, fastboot_buf_addr, image_size, response);
>> > +}
>> > diff --git a/include/fastboot.h b/include/fastboot.h
>> > index 296451f89d..06c1f26b6c 100644
>> > --- a/include/fastboot.h
>> > +++ b/include/fastboot.h
>> > @@ -37,6 +37,7 @@ enum {
>> >  	FASTBOOT_COMMAND_OEM_PARTCONF,
>> >  	FASTBOOT_COMMAND_OEM_BOOTBUS,
>> >  	FASTBOOT_COMMAND_OEM_RUN,
>> > +	FASTBOOT_COMMAND_OEM_BOARD,
>> >  	FASTBOOT_COMMAND_ACMD,
>> >  	FASTBOOT_COMMAND_UCMD,
>> >  	FASTBOOT_COMMAND_COUNT
>> 
> 

