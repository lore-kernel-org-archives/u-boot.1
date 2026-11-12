Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6721606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=exXYr9KK;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=fkfeEsG1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5BA560902;
	Thu, 12 Nov 2026 08:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4e-h7WojP-r; Thu, 12 Nov 2026 08:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E05FA606DE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794472065;
	b=GxxpLK85l09tNM8vnPKmw2T5M6fhgrPUhip/QZDx7zz6tYy8zg38pKSDiRidnUYfOo5d
	 2jG9gUbycd888tBqU1MFFIU4bjt1L2+cEeshBlsATBYuXymbj113SjkLT99SsbCiclofu
	 VKmNftZ63I5rmYqbeyM0C4YqB078llS30DysuDHMOJSoHnyJFcSfFodoe6AcS0pIjUz/E
	 0VmujuvOI+H74X0RMkeJ1yEmCUFbZhbsAPrOcyv64/tjUqWqpU2XCq2ppxDijo2FUjSfd
	 aUa0OtkHA1ud030oQXGfQWhLEVeh7nazIDk+hUuyjU6LMpOueAmef5j78vGNhalflVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zwd2pgjc1sBgkjJCAuOwEzq1mMBQiFwNisxJVjQ7EOQ=;
	b=CIEuUzAmVLqmKVdwLxVhD+s13WwdlXwBz3OnCVBO1IoQT+dtKfHAtOuikxfPIvYg91HU
	 dRI9zjeQm3XisKIGd/fxFHWwWsVQ1+vkSwiO6xHBQmQEAEo50Bg4N1YO/FW7FxjGe0/1+
	 DwvndOFwiNCScXv3/uNjkM4fSdp0auE1CuU3p0E3Uu+z3046bUpd52besxkM8JJx2nBg2
	 +Lo0jSciKNVP9XnJX8TyZn6pSrSxA7ewMoYZ1P6V4k+PBV8wR2ZeIVFH8ZE8hNENiIUW7
	 7HQdwz5BAdCLQnBD7xuXYDU8cyukIxfzF5xCFO8DTa8e+jfCOCsqQEIhr/Z1nZKww5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794472065;
	bh=zwd2pgjc1sBgkjJCAuOwEzq1mMBQiFwNisxJVjQ7EOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=exXYr9KKgr+lP8krIA8ciWcQb9v04j6ZtEmPiMTmjzJoWsCwThtIlVPtur0VQjI5l
	 dO2HDOldfhaZQwm6HHirdSn3c7on1ZIif/3MharF6tB0CMXEWRqE46kkVV33vo/m7F
	 yLgp6Lw8H4Lin7WJgihBbq+zx4ZUvSxbktdicvBaTHqRc2KIuPteGP3pzpI4B5pt9m
	 FqzuOk+jwFYMQGEdbLXSmDMd9KzcAr5ZRkoQBdogkcu2llIe+D6yJwMKhjXzHpxr/N
	 4rgDucKpchE9Dgmqyq4TtwflbUabiuS61dgljUrLZyQz7oSLGvjlHgdKRXQUnFubdm
	 TYCZyW3/+JY7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E05FA606DE;
	Thu, 12 Nov 2026 08:27:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA11D28C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA77140A58
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pnuVAZnyqFW1 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:27:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 82D6540A52
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fkfeEsG1
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82D6540A52
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwd2pgjc1sBgkjJCAuOwEzq1mMBQiFwNisxJVjQ7EOQ=;
 b=fkfeEsG1p9shY69w5HsbIKwBo06wDdkymo/wvNj3BfLUYjWlmyIMF1JZbHdLPCWKkkkX8zMvtCCHKhYcMYgS5GPm/aR1a1xvXju8cyF+4/B6b9PouyUDeFKIjgKkV4k4CZVYlEWBh6bT7ubamxiGqNtpta+9FHaot6bdLBNsmws2HwCk34QNG0/tWZgdPG0hAangniEDqmh1XMuq/ezByNXqTjtaYQ6ApQ8WMS1+wxL4m6Agpv6oqT8e7dS6gLLhUzDU4SF2Rx7Hj9LSZGw7XKKCkRCkGU2LbKXdt8/820/+lfzck6ryWI7eOih39TK9hVmh7tkHH0dVJrMhQTRzww==
Received: from DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) by DU0PR10MB5386.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:328::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 08:27:35 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::2d) by DU7PR01CA0036.outlook.office365.com
 (2603:10a6:10:50e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 12 Nov 2026 08:27:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:27:34 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:27:34 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:26:52 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 12 Nov 2026 09:26:50 +0100
Subject: [PATCH v2 3/3] mmc: mmc_boot: keep hwpart and capacity in sync
 after changing PARTITION_ACCESS.
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261112-upstream_partconf_fixes-v2-3-5eba1cf22b1a@foss.st.com>
References: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
In-Reply-To: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|DU0PR10MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e57ee0-8df9-420c-f540-08df4096cd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|22082099003|10067099003|11063799006|261102123227099003|261026121527099003|261021121427099003|56012099006|261021123027099003;
X-Microsoft-Antispam-Message-Info: BjwJWlQqd7q7XqVu52CKnEExJ+sh3G3YXl2c8+6gLSIW04MEPArH0ghN27q8+77HUg4DEePDxTMHC6pGz/tNfFmI3i9SYtMubrqsSSiL6xG/NgfIzt/Su38j336eAX/3fp48nXEBa2x1y4UFhY8STvqJz20oRIl0qFBkcCcjpGPdQDjuvy9/1G//Bd1qWzUts8jW8dUecVP/91lgiKeBcRliaNXd4w/rCPt/0lDOyWh23IAoZe02p968i441Ox0Gb8HoLCJTYwdBCv+coV9rTvz+wUKzMrGJDidfYxYjN2xda6kdhndzcREfTmT78KcarJawxJPrk2IjFf4HFOfEK0pATWkLbZT2z820LeiLUaf6torAYBkKJymCxWYSh+s2YB6tHRz4bg7I6O72hRG+AJ/KruyB/6V91ARraI+6bd654lJMVpt4xDCHsTlibIjBxbUEHb5drLhDrzBW6NfAbrmG+ga9e5ig7coExs/SeIsqm6RyBGKaCq/acNcaSHLsmye5dsh+3IFDFIk0V/NtVQztzS9Gw5NzlgRCPLZzY5SoLDbIkhyqDHHw40sA12XNzMXQUEjOmcWED4tPUCVgUJUhNjGTr2hgOy9+K4yoKALaEJZ7zI7DV6+vLjmTcCcT6ShfMpQngwlYxXM5ngFZwNEBvvWxsCNRClro0EUwqS2E24YmnQ95W1vCM3UY5BJgTBLrsGXfvr2/fKYdQcKj/A==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(56012099006)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o2IN24EIzdikfn3m9ju842Y/KY9NpcL0SoGDls7RGE4mSarQyZ9xhlmdT3BhzmQI8vadDNlSFsYfhWYVNDdBS8Fz7i/a2/4bb6rtX4gCBbcGNvUqYILrGGx10he9hcGeEtRu29jH0MwsY5AgVz/07hpzvEDLnZ/tvE231DIzB/v5yCh9mbyuJBrI81oShI8bR/KibEePg6h5NUq7eeYrEfI8Wz00CiaGAjB52k+oPpmoIDQX4TZFPAdbwFd3arTT+PwKtk37gkT+Utb+d1vecOn+pJZR6mDRvnqOT2XNopzDzc8datl09Rgt7dtwxfssQanTTz1i19FgjVf+PpQMkxws+pWOfdAdqlH1fLoNu5l3hF6SSYQD1owmZaM8jZ0xA5F1/HX1juTEUNIvNmCCp5CFm11v7pW19YbETAaL6HT/70I/rh8QHsmkUfy1BEXK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:27:34.6785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e57ee0-8df9-420c-f540-08df4096cd8e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5386
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Select the hardware partition after partconf command as it is already
done in mmc_select_hwpart() / mmc_switch_part().

Fix "mmc partconf" command issue.
For example for the sequence on STM32MP157c-ev1 board on which we got
mmc 0 (SDCARD) and mmc 1 (eMMC).

before :

STM32MP> mmc dev 1
switch to partitions #0, OK
mmc1(part 0) is current device

STM32MP> mmc info
Device: STM32 SD/MMC
Manufacturer ID: 11
OEM: 0
Name: 004GA0
Bus Speed: 52000000
Mode: MMC High Speed (52MHz)
Rd Block Len: 512
MMC version 5.0
High Capacity: Yes
Capacity: 3.7 GiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 4 MiB
User Capacity: 3.7 GiB WRREL
Boot Capacity: 2 MiB ENH
RPMB Capacity: 512 KiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

STM32MP> mmc partconf 1 1 1 1

STM32MP> mmc info
Device: STM32 SD/MMC
Manufacturer ID: 11
OEM: 0
Name: 004GA0
Bus Speed: 52000000
Mode: MMC High Speed (52MHz)
Rd Block Len: 512
MMC version 5.0
High Capacity: Yes
Capacity: 3.7 GiB            <== incorrect size for EMMC_HWPART_BOOT1,
                                 still EMMC_HWPART_DEFAULT's size
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 4 MiB
User Capacity: 3.7 GiB WRREL
Boot Capacity: 2 MiB ENH
RPMB Capacity: 512 KiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

after :

STM32MP> mmc dev 1
switch to partitions #0, OK
mmc1(part 0) is current device

STM32MP> mmc info
Device: STM32 SD/MMC
Manufacturer ID: 11
OEM: 0
Name: 004GA0
Bus Speed: 52000000
Mode: MMC High Speed (52MHz)
Rd Block Len: 512
MMC version 5.0
High Capacity: Yes
Capacity: 3.7 GiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 4 MiB
User Capacity: 3.7 GiB WRREL
Boot Capacity: 2 MiB ENH
RPMB Capacity: 512 KiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

STM32MP> mmc partconf 1 1 1 1

STM32MP> mmc info
Device: STM32 SD/MMC
Manufacturer ID: 11
OEM: 0
Name: 004GA0
Bus Speed: 52000000
Mode: MMC High Speed (52MHz)
Rd Block Len: 512
MMC version 5.0
High Capacity: Yes
Capacity: 2 MiB              <== correct size for EMMC_HWPART_BOOT1
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 4 MiB
User Capacity: 3.7 GiB WRREL
Boot Capacity: 2 MiB ENH
RPMB Capacity: 512 KiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

The previous mmc_set_part_conf() implementation set access to boot
partition without correctly managing the internal mmc variables.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/mmc/mmc_boot.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc_boot.c b/drivers/mmc/mmc_boot.c
index 986e6c500b1..859aa5fd1d8 100644
--- a/drivers/mmc/mmc_boot.c
+++ b/drivers/mmc/mmc_boot.c
@@ -216,6 +216,7 @@ int mmc_set_part_conf(struct mmc *mmc, u8 ack, u8 part_num, u8 access)
 {
 	int ret;
 	u8 part_conf;
+	struct blk_desc *desc = mmc_get_blk_desc(mmc);
 
 	part_conf = EXT_CSD_BOOT_ACK(ack) |
 		    EXT_CSD_BOOT_PART_NUM(part_num) |
@@ -223,10 +224,20 @@ int mmc_set_part_conf(struct mmc *mmc, u8 ack, u8 part_num, u8 access)
 
 	ret = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_PART_CONF,
 			 part_conf);
-	if (!ret)
-		mmc->part_config = part_conf;
+	if (ret)
+		return ret;
+
+	mmc->part_config = part_conf;
+	/* Keep the block device in sync with the new PARTITION_ACCESS */
+	if (desc && desc->hwpart != access) {
+		ret = mmc_set_capacity(mmc, access);
+		if (ret)
+			return ret;
+		desc->hwpart = access;
+		blkcache_invalidate(desc->uclass_id, desc->devnum);
+	}
 
-	return ret;
+	return 0;
 }
 
 /*

-- 
2.43.0

