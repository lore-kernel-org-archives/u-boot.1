Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F9FC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9295D60783;
	Mon, 17 Aug 2026 13:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0T-nctQQ1qJz; Mon, 17 Aug 2026 13:33:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A84AC60732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973639;
	bh=01im6OvD8zluOdaSq3d5e3wZ8PwNYxmrFXl2EyuditY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M38sPiMpwFI0BJNhGMYe5v2ILOXRGnqAxwIZqKsZKfoTj40eS8DiyuEB3iWcrYPMS
	 au7f70Kx1cJlvOrmGArJ8Iw+swx7NqR0v8xAceE/cUVsTqXxQtXPxyOrhwc0ZFoL7u
	 /mEbWClOGg/7nLa2HmUTylmCgwWJwKL0QXysRd6bpgwh+LeefLkjWoVfPMjRED00R1
	 7kWDb7nOY1EQ8dgR9L0lqUKrdrHaLeMv24R1J4mmEmXZCFDdexXOVQqC/HsCPHSySM
	 eX+r2N0Z2+YOFI3bg12jCIobRZETJviMZdulk68skDbDbiSBXLMx1nd2uoNMWJE5T5
	 i4c02F35kMPFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A84AC60732;
	Mon, 17 Aug 2026 13:33:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2453C147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15AAD4053E
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oTGEO6dR7VdF for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:16:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A87E84040F
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A87E84040F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=CgN0gT6d; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=dJlfBXLT
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A87E84040F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:16:42 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H6B4k9015555; Mon, 17 Aug 2026 03:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=01im6OvD8zluOdaSq3d5e3wZ8PwNYxmrFXl2Eyudi
 tY=; b=CgN0gT6dcjeUoyb0IlK6VRNlN3rPLB1iSeJ9hMYA+dmewNs75Tg/h6UY1
 hcMw1qF4Q7A4y2i7zLat1p1XxsJV7x0dOREwpQHKPEwThGzAenxUquV7qxZr6Bh6
 F3hc5y0c0Cb/sTnkMWPgbEjgYqaIL5Wg9jEzQZWMFgzEe8xTJIg0UIy1Kpb7W191
 D/+7noDMR4Zk/wgB0MYQvKw9Ykz1+SM9HoaOc98kskZtMk3Y/36GAZ4fkA1nt6uk
 SQVrXkfbHG/RF81USiANXfa5hcTAfibpZ7/AQ5jGZnOrSqkafIDdYiLNRykCcNru
 9o9SOMiyisbYYDFasu3a/fhU//ptQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g3vt78knw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 03:16:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayyxNaPrm59Ae4ycNKi+fm0dYUxZbUsE5VpxWQnXwz7hPPXoNDg9TCgX/CZMlb7ZtGbifyoHOsGTgn80Yb+EJ4fp3PV02At5N/Z01ry14F2VjVWINwXBo/Ui5Dfbi7pBQYoaiwBvIHHWHd+mA+Uh5PaKjyoeRFHNmmKq+d6APhOWmWU2ZF5ikaVjFYFJT3UGdj/cNDcusjxh/PIPEycKmGyz3p3EDUTcpWWRcqgneLrN7cFfyq6Kxbi05bIhQmYTXM3Jy1JGRVyV4ym65VjNMdxn7J1H6NLKn9Zcfb20MbgeyowuzNWoc+5k1t8ZvC8EctYZjSKBY/6N2wN+jOZAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01im6OvD8zluOdaSq3d5e3wZ8PwNYxmrFXl2EyuditY=;
 b=hINRfEW7jjKkANcQd33KDdj9eVwSjyWfq1gVxd+V9E8o0z5OyHqICeThEK0gMjwF3YDWUy9FkrI4CIwMexSPXpzPdgUQfDshm0k5nkBxtUqMDZY4+dOPhXPgpg8N+0tfe6GYYgEnLMMFvlirlM5uDqeBtdV4SbIPU4XApUzzXqkHmVO3KySOMG/dvquKtHcgMHr1ECxhUaVQqwHvg+XVbXARKZbufoQR7ih5EryBkRTiMo7buLE12DWEI9a2bagqxIebjxzWD+/y6+HHvyc9MdipqlCkCvdkmteS9w/TGDy3slGWkIM2NoKY//afjMd0vMHUX2i4WpsaOwsu4KOfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01im6OvD8zluOdaSq3d5e3wZ8PwNYxmrFXl2EyuditY=;
 b=dJlfBXLTBL/DkHtw7sUmnJl03eXb9ZqaGru/25Wj8h/XVjUavwc/sM1016sVmFMDNkQsYvBJGOuAqF9Gcg6Puud4xw4tiz6jYGlkJHhpsTG61XDP6b6d+sq970J4o+nZZ5s/+JLbZ4Ig5XHqmFzQ4hro8Cf2J4CJQEXeEPpZ+tM=
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by IA4PR10MB8254.namprd10.prod.outlook.com (2603:10b6:208:568::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:16:38 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::6d) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 08:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 08:16:36 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 03:16:13 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 03:16:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 03:16:13 -0500
Received: from [10.24.53.154]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67H8GBuY2273894;
 Mon, 17 Aug 2026 03:16:11 -0500
Message-ID: <26cefba7-df22-4043-9383-b5451ce7cf95@ti.com>
Date: Mon, 17 Aug 2026 13:46:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Semi-Falcon Boot Support
To: Tom Rini <trini@konsulko.com>
CC: <n-francis@ti.com>, <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>, 
 Gokul Praveen <g-praveen@ti.com>
References: <20260814102153.44487-1-g-praveen@ti.com>
 <20260814145645.GJ3297518@bill-the-cat>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260814145645.GJ3297518@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|IA4PR10MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 41efbb37-91c7-4eb6-cf10-08defc37db58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: AHkOWBUM4rw35Eis0N15uCOTgx5ux9xCIy96ZX+9x41C2fJFN3VQow/hCIYzlRuEiukNZ09LwKAXfwZ927qLabhKolnsaFihD1ZPbKBq5XO+i/CdL/h8XS7bkIQ4F0WvF29ZxJyOD3KvldI3W5+LP+XY5syFw82N757sf5DCXHHkesQoQgTzRVmB32qM+SMBpji/axweWpH+zm8pPmp5lSby1/guOxMZu4yf+X2bEKE+UEi2SAA6q4UKutr62ZOaSU4+rHvu90fo3hA3mCixFgmD7sdIEjkMEciGThaweIkjcKY0fZfEeYYcPCLvCvUJLCr5XzDKfoIyWZT8haCx+cqu9nc36zZQ55eF45eZrDRoYh11KHEd03R/iy8xw0QZK9Eslm+h+vSmCLnFdxA0GZONajV+jqKL4r52mMCJ8PB88OGUCqitX6TwcKbTYwFWFg/diNJjt780ryhBY0oEmT1m0FHtKcvQE0vUTFbKR7aUIa4hFKXu9d7NXG36bMfGHd7ACKn7pI5eoxrAz7NrXx0PmQNcla6wH0Xdts/C8uBtqdmy530sH7Ayaz1huICYr/EIuSgQ+inoF2/QVppD1b+eP2EqEOQ0Ho0uuJvjV+QC0PsleJc8AUELqtIKdosFNYv7b/FHJGs2ac2o8ekjfCU6RYJcspoTASQ5AzIoEFrAjzK/NbFUcxKmo56zEeINTEWCXtr1CPrBSBKum0aoYw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ymWDJXq/yaS7d0gCP2prL3pmMZvwyn6xaHj/5fkz0GKZ5CmTjk0ctxWBQrW6uKs8rczjqSodq7iyYPVWUcthZpVuztxAk9NOXyJaG2WqF09CZ2kd+IMgBEyyOEhi7rre34Mm1tWCvWnBqWVijTerC0pgDe2NmtZJ62deOr/lf1gqG9WaoGuG41SHXSQ16Uu4LUdsmd1nQYyDUFg20c15WPm2tNlBm3MS42ilvUdK0hqwXUuAp058K/GYNbrqnf3cz5bMY+EpD/FzSPQ7D7Er01iptb/yPMHG6nTc/ZAos/WLr7SRpuopwy/UmmrE5Y8lLsmmKJnrUlIPajfKt1aix3cX+lPAxeAliHDaHsOxl4aG38aTvjsDa+K7T6QiP+zulzGMjFhkeJUKYsIL+c0bdT3R+bOQcqL1KAJsXSx6FQLjYai6iCzcqKdCnmxzuBqs
X-Exchange-RoutingPolicyChecked: FDv8dAxew+KJ/w4iMhoT7Tiyas7wCdGUgCT8PIeYIvvduLTQy1UQMb6cnCiP0yKGN0SWpxHhffPr40qfJLVAEJMkuXo9C2XWzw3geN3oFWmi0d6Itn1uYB/Q/Pd7iTgEEm6fN4G1xWLBUU2XrD0selvmMLzpp6WLr9TR+ViWQwzoyvHWAq8oE90tZXrCdg+n4f7ez7faijFp8VYbHjpKsQ3XsCSD9gepg+dkH6Y0xD20yB6nYGpjVh8d+4b+9XYEp/iuh2eWcOjg3XgObLgXb/KhU9jTdpwtHQne2zKDc3CCRmhr5CZDG9SjpQiJTkHwVdE3X6CHidMIhN+7h0yO4A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:16:36.5404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41efbb37-91c7-4eb6-cf10-08defc37db58
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8254
X-Authority-Analysis: v=2.4 cv=CZ04Irrl c=1 sm=1 tr=0 ts=6a82c368 cx=c_pps
 a=ZegHLSctVnYqdC7w6owYpw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=NEAV23lmAAAA:8 a=dxWucAsCQabmWX3DkBUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2MCBTYWx0ZWRfX0b3rP+OqXsL4
 GQCU0O3/FXI6jiedD5+xh28W8hm/6JlSSyv+PLojhj+avRc8OCsG3nUy3jU6dYCF6vrF1sQpoIE
 sJyvs1uH1VIa30vmZbOdYAxluWa3BEmAPVGQV9TvPmxwB1C3Vj8+G5ZKm5iqH7/BDa/MEzPqJ/r
 4I65uhFMBB6xuUeKxYvq3P81rgT3qNaKWrya6XH5oiwPG4i6TsY+iyimXp/t4ayrdSvIwdJrpD3
 6Zl6+P5W44AEAJQL+bUtAme9y0scvW8R01WEwJZQ3q40u3CJmOHYq6hdIVAw1RA03ShrSUNc2+Q
 L4irDEBkJohssyuSv4IZhDw/08623SgNGhNb/bHbTUxXGmXx7vyuxZJj+oQaZv+fEg56rvlv0lp
 28nRGcmvikvmqVA89mKzUHN7GT3IUd1/IxFJy1CcbuMpGm5y1geDh2E4g6VUJeOFzNAWuID19OE
 YuDikqKgGEEa8iZjsEA==
X-Proofpoint-GUID: ipSn_5vIQbi7m_czoX1dKqW0ySd9Du5X
X-Proofpoint-ORIG-GUID: ipSn_5vIQbi7m_czoX1dKqW0ySd9Du5X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2MCBTYWx0ZWRfX9o9f5Gu6D14m
 eov4X85ae4SAYRmlczFYhqEgft7CimZWDC9NnMf0tuOiB5pcRPdY+RIIPCTAtP10kUlLTE7FNCa
 8ufCma4b2goLq0HhML4y3n7WlDA863w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170060
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:57 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

On 14/08/26 20:26, Tom Rini wrote:
> On Fri, Aug 14, 2026 at 03:51:50PM +0530, Gokul Praveen wrote:
>
>> Semi-Falcon Mode is a hybrid boot approach that bypasses
>> the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
>> boot times compared to normal boot while maintaining U-Boot's flexibility for
>> kernel loading and system configuration..
>>
>> Boot logs link :
>>
>> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
>>
>> Gokul Praveen (3):
>>    configs: add semi-falcon mode fragment for k3 devices
>>    arm: k3-binman: add tisemifalcon.bin for semi-falcon mode
>>    doc: ti: document semi-falcon mode for J784S4 EVM
> This is just doing what many other aarch64 platforms do, of skipping the
> SPL phase in Cortex-A because something else has already done any
> required initialization, unless I'm reading all of this wrong. So my
> feedback is:
> - It's not "semi-falcon", it's just "no SPL". Naming differences, if
>    any, should be done with that in mind.

Actually, there is an SPL in Cortex-R5 which is still present in the 
semi-falcon bootflow.

Its only the Cortex-A SPL which is avoided, which is why I did not name 
it as "no SPL"

*Normal K3 Bootflow*: R5 SPL + TFA + OPTEE + DM + Cortex-A SPL + UBOOT + 
Kernel

*Semi-Falcon* *boot flow* is : R5 SPL + TFA + OPTEE + DM + UBOOT + Kernel

> - You should make sure to structure this so any K3 platform *could* take
>    advantage. I seem to recall part of the rationale for the current
>    approach is that some variants might only have a little SRAM (512k?
>    256k?) while others might have 1-2M and so easily fit U-Boot in SRAM
>    prior to relocation. It sounds like this specific family has a large
>    enough lower memory bound.
>
Yes, this is structured in a way that all K3 platforms can take 
advantage of this approach and changes.

Additionally, as there is an SPL running in cortex-R5 even with this 
bootflow(semi-falcon).

this bootflow can be used on all variants irrespective of whether they 
have less or more

memory.


Thanking you

Yours respectfully

Gokul Praveen

