Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464F9CA5FAC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12311608A8;
	Wed, 30 Sep 2026 12:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7wLAPbf9YyaI; Wed, 30 Sep 2026 12:54:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 47DFD60A4C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790772842;
	b=i6vth6oscmAFvMfAOsz08AHgXge5X/KUHM6xKUyYY9j2MMYwsSZ/fqB+xHxJjiJp6Kx8
	 Y1SZ7XTaVYIkGRtY2QEjSUtizCUxBOxQhrGdWBeptxpN1oqgw/Ku47pUJ+VmZGH90sskl
	 ptFY6bArItpDaqH2yebsnrCWsgb0b94l7+rKg+V/ZdGvakHqT4IkCDV1cweICM4Kv2zX+
	 SPaPH8wcNv3bAM1CUuqdnwLreAKgFeE2mwfb21JdWCiKag+QdSUhFORR37GzOXlHoosgh
	 fpFwQeU0muG9UAmVdLI+s+CZXgzfxQk9IGYLh1jt2Tr9ZC2xNdW9nsh2OodT/NGt/lw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790772842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=cNJpxvl+Vffnq3YZXHNGf1ettcekU2qNyOhxV9UmS7U=;
	b=du/RQZqfUwoYlQ57jFZddYkH9PK7R+3/YGSIZqdNa1OjoZXSeOea42JsybwqvcBK9mE6
	 V3WMwIKvUFk1eNONWQlpnmxOKzkREBbf9GHPWRSvv/pFbyNUwkkdo5hPRsrCn/iZVHP6w
	 dqOVzgEf+cpkxychn/ftYITYWvc380w5Ic3w3YDUn5EB3vW+JZnT21h8b3ErLOuJW74/W
	 69VmuDAGf4e2UEwHABl9sRH/4wh8JhCOMqaLUHwZLukm9zUKw11Ye0z375FE6A7nDQYmT
	 3EUEhG53rADTKGym/LfNt7z8NAG4OuSFjDlylczxpYqVS7jO1iOXv/aRBmOVBJoWo9w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790772842;
	bh=cNJpxvl+Vffnq3YZXHNGf1ettcekU2qNyOhxV9UmS7U=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iFRubqe3s5qMk+0WZnge+NN/c8wtMifajfaYV9tDmuyYXDrwtQqW/UP8Qhk1rF//c
	 hcRyIkFLspLRDhL1ogtfMywRYVwbJgNo3OdXVQht4fdiq3qat+stW8PYikWXvSuz1S
	 bArxrdKOEoX1zJY5bIHburx67bm2JnEeH/PpA1WJbihdjaG6W4d/JKL7LsYcT+26Lv
	 unMReyrZHW4Tv7jsojKqdCcptxkSMZzbtBiDkAc5xSrzZyvFmI9PJZ4OvrMiIUbJnU
	 jwsO6DzX7Yg2039J9a4zJQIL5YRqu4Z7suuCv9KGZzUQAHGS38HWoywAVWGmItdAkC
	 zP35TAeOWXX6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47DFD60A4C;
	Wed, 30 Sep 2026 12:54:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DFBA333B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C525480ECF
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kWkkamKBAT1z for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:54:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3F98180DE4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790772839;
 b=MlQ8Q5o2s0++7rEEcWLv7+8MhlonSOEO/xovWWhrRkK81NsItqeYChmkcBTkeyS2qYtq
 7JK4QKpeI8x/WoBP7TJD35ehDVKHU8E7qBd4nWcV14vsTZQOawAZbON2jPkkSZPbqsN+4
 dQDPN1H2L/cLwu4NeqLp3xI3msHphWXiMpDRjPL95hIkfBQD7muNmJayc7A3qvu7bnIIt
 NYPUXpT4BIk/5vNxeyN/uCC0cUN9CPKX5H6PVEKFZCqIRyDI54Da/pXiuFcb9RvGZf73W
 +2CWqnfF42RxJQ0CYXfm2tHy2mKW2EWVHSxaOuB+MbIzqTLc8tNsVt0WAx9Xjqwp+EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790772839;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=cNJpxvl+Vffnq3YZXHNGf1ettcekU2qNyOhxV9UmS7U=;
 b=s5wNOBAUQbnS3RKVAUJ+1sObZEqVwmCF06KjSFPV+/m4KZQycLUrMWtENLL+WUMQ01o3
 5qDAU06W69pIlalDxaa1WkAmEcVNnj9fh1ujStNc4Wh/QkyTAZQBwEGrskDY+HoIqiBkx
 f8camhS6oMQrd7fIPsgDkXM2wLOdzP4FpcKy5oNStY9o2QW5JpQUVB8Xv5U4mdi20JorY
 opRvHqg/D0Ndg2br+7ciKrQ2tK4mPR6vriLQzZLmakVL0FisdbSkpZn4+5QW6I+Np/LK8
 oCle51sUfHcRCx2924/ZW0GxnC8Zmqc9mQrXb/tJN+opdO0IkBDIxlN2Ym/W/eX6e7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fxp9IrNr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=prasad.kummari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fxp9IrNr
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F98180DE4
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3GkQWGu4+RZUacnxG/Nbv0CkJf7babcs3U6z5VaAgJ2DiVok2D02zuzZxnmD+v5cpXk77sYsR3a2S6+sjj6I03BxKjvnBQsHidpwDVbt9a3QFC83MDko6BAcXoCdRRYM23koXzewbOrBd1IuGDvA8lrQ0RKbKFjdYEy3z9NPdPgqOUL5twL1ul3I39hn3PAXWz0FoDSUqecMSxew32Rh0rhUScIOGodZiigQgDTj3uR2Y7V/bLsV8m3px4EF6SuFeE3jfV4Igk431Gd9LochfHshbZv2DoyRADQ13WwD4RtYD1NJJS0eYNHETglBCtYUE4pbg+Uoc3q1csdn0G3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNJpxvl+Vffnq3YZXHNGf1ettcekU2qNyOhxV9UmS7U=;
 b=PbC871GAmWcZrR+GqGTx3K40qmepB5cwKmK0Ry8lrto5I+Hyps76zlfJugRFJq3dPaaUplcDi5OTczJjfDW6dryJgp1IN4ZuY0eKBc09sBPRnBD4U0UIiXH1sQ4z6aF4Q2L3/tXZVK3itBZGmJ9BhWlwf1Kh1x46cAcusVXob3PzGN1/ObAX6BtP139d+Mr8wnWeCUFVtNyHnsSs92KLo407if5J0hm3uccmzuHN0cK3Z7jaaC6ox/FsWbApmgC9CSIORnf9BgguU3Dd13cw4mK3vgvjPEGdwhJFJbDkCEk4K7W0blU+nQZGEwmKlNbaGBZZEM3Lz7yOxKJs4dVuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNJpxvl+Vffnq3YZXHNGf1ettcekU2qNyOhxV9UmS7U=;
 b=fxp9IrNrxghIfGBppnblmcRweOzas3hrUa0GQu2uldwLWlwhYFzokXsRW8qdASuNICkgD+E59JgxfigagnWRDoe+uUgv+w+sOJ2DNlMKvhzS6qYcBzZ8TJqylu0B95XYLznIEcrTbm0Dt5EGizNwpsne+fsSyM5N089TJKIyH04=
Received: from SJ0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:33b::16)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 12:53:53 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::13) by SJ0PR05CA0011.outlook.office365.com
 (2603:10b6:a03:33b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.13 via Frontend Transport; Wed,
 30 Sep 2026 12:53:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 12:53:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 07:53:51 -0500
Received: from xhdkummari50x.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 07:53:49 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, <trini@konsulko.co>
CC: <michal.simek@amd.com>, <padmarao.begari@amd.com>,
 <akshay.belsare@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] fpga: versalpl: fix OOB write in versal_align_dma_buffer()
Date: Wed, 30 Sep 2026 18:22:10 +0530
Message-ID: <20260930125209.1030679-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ae272a-a51b-4332-b133-08df1ef1e1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: FOnfdYZpyG8pvvpRclGDrXKaDO58xZPuqFqyH8869WXmW1j0HtrhFAvvjzbJkq3+3jxWOJvO2Dx5B9ETZnUXPOspwpjwX0v1b4bXHbg0KILgTP5dX0kfP/kcSnLxU3cjRw9Lm2gToRHMhlI7Fg8guB0qLWU43hnMFf4qvcMRkND8c/mVIadIxyPU7eN3/j1bWnDr1AJTHMQ1rkmmHolIGOyPZ1BhjjX+ev/6YE5F5xkgFIWqLLhHy5SkdDO27vRQu2VG/ipOdf2j9vS7veHwYc3F+hqhddhhJcR7FY99hiqurhz6+SLY7nAw4Zddxe3gMRiM/LvX9HiRkKjAgGATmJquw/OWcjr+/9ykvDjwdLqnyjllvxwmublXR5u+64xuZKS6SZSnZwQbPE3uftDGuW3Fvhxsv7osYiTuyRVHMTQyA08WPDVdpaAAtO7PQ3YVQ0YsxJRrQTxiMdkpxiZh2vdsA/w+TFsJZmj1ECQwOl5JFVryMKzxNJfiwayhRjl7AseoepuJvPzp7FWUNa24pmkaQAfGueDUbofsMu6vOaPa17KWj25adbTDICxj0zBsm/O6muAapJXYqux1clYJWjFKFbaMgKHelRto6KoxQxtM6Nq7QV2aoRQQcDyhF0h4YBGiMZcEdsYR37n80HSELBPXDjRIxQ5arcLLyf6EjxTqMb/TkvbYW2lSzXBAxMUjb4GCnJt0OTM/W67wxIZk+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y6l1yfbzXfYzyvfL3ON79j9YWuF437LJFGvIt1bpEXW0uOsZMMGr/WbLhCPmUUZpdj/06jKju8e30hzMkW1Fwlwck08gv+DXogXH7wEJhRGbA+kgib8zZ71jqHzKX3qh+oEiz7g0qicGJ/3lKBBIGRArj678o++clCbtSAI+HtGpT43xcg9zp0wPaE0fpT7ZXn6h+z3WQsIZDWaexExhtr4Y57OTJ9NOTujXVCkH5BX/SZfs3q7J26UsvbVYD+8Q7ybh1cVVFnhjClyxbwcBfCSBHxmxzvNyAqGCvWgh/AAeqr20jwo2qGDpZx1NxZukze3rb9ZrnyLZx/Qg2BYYU4ajUy7HDPaBdNnport81+hc+8+7uhq6DpUDfdsJCIzCMjkfR+hYFEc/Tp8BIr82TsVwfoPwBn0F0PZCId/FRRgLZI3apwJ28xHgsRPH41HD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:53:53.2651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ae272a-a51b-4332-b133-08df1ef1e1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

versal_align_dma_buffer() rounds a misaligned pointer up with
ALIGN() and memmove()s the full payload there, writing up to
ARCH_DMA_MINALIGN-1 bytes past the end of the caller's buffer.

Allocate a separate cache-aligned bounce buffer via
malloc_cache_aligned() and memcpy() into it instead, propagating
-ENOMEM on allocation failure and freeing it after use.

A misaligned buffer larger than the available malloc pool now fails
cleanly with -ENOMEM instead of silently corrupting adjacent memory
as before an explicit, diagnosable failure is strictly preferable
to undefined behavior that previously went unnoticed only because the
caller's buffer happened to have trailing slack.

Fixes: 26e054c943a7 ("arm64: versal: fpga: Add PL bit stream load support")
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 drivers/fpga/versalpl.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index 3cb56cc0dc9..3ad7a54baf1 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -10,14 +10,25 @@
 #include <versalpl.h>
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
+#include <linux/errno.h>
 
 static ulong versal_align_dma_buffer(ulong *buf, u32 len)
 {
 	ulong *new_buf;
 
 	if ((ulong)buf != ALIGN((ulong)buf, ARCH_DMA_MINALIGN)) {
-		new_buf = (ulong *)ALIGN((ulong)buf, ARCH_DMA_MINALIGN);
-		memmove(new_buf, buf, len);
+		/*
+		 * ALIGN() rounds up, so an in-place forward memmove() would
+		 * write past the end of the caller's buffer. Copy into a
+		 * separately allocated, cache-aligned bounce buffer instead.
+		 */
+		new_buf = malloc_cache_aligned(len);
+		if (!new_buf) {
+			printf("%s: Failed to allocate aligned buffer\n",
+			       __func__);
+			return 0;
+		}
+		memcpy(new_buf, buf, len);
 		buf = new_buf;
 	}
 
@@ -34,6 +45,9 @@ static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
 
 	bin_buf = versal_align_dma_buffer((ulong *)buf, bsize);
 
+	if (!bin_buf)
+		return -ENOMEM;
+
 	debug("%s called!\n", __func__);
 	flush_dcache_range(bin_buf, bin_buf + bsize);
 
@@ -51,6 +65,9 @@ static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
 	if (ret)
 		printf("PL FPGA LOAD failed with err: 0x%08x\n", ret);
 
+	if (bin_buf != (ulong)buf)
+		free((void *)bin_buf);
+
 	return ret;
 }
 
-- 
2.43.0

