Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ED0C79F83
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 10:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DC0640B69;
	Fri,  4 Sep 2026 10:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LEY8VHSxTLxY; Fri,  4 Sep 2026 10:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DE61240B48
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788517141;
	b=CkChSvJmoTvQ0iGk+kiEjB3dnMet/Bkx4Gq/us159Pruq8F7X6iFDtH7GaU/HBOgxe59
	 fT6ErTfXhcLpRFC6CqtNRZhtOZXtXpQ0+FY8zEPeYEEZcTBzQ7KnnBW0xte2e4PDBNRkm
	 8slTfn84S58RtCKOGhe2yifUaOT6jCozP5Tk2YLEt8xaobvqte2r+fcW8YLMxyE8ncf4V
	 VZcVHHzOs+lGtxCIkbIDG4zdTDVf2E4aMb9hJ6JD1vcarPnRheKyc8uShMeeFTCa3lmhe
	 tEIg1Fvf5hR9BTsW0K/v1/+2dBhy7kWYksKzUFtuEYpf3RXfLenRgPy6QEHO58vMX5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788517141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=5dM90Rgi7lMaA68LMXCb6NXQHPslMCRybW/LqOAMBzc=;
	b=IpgUIqR2gUIYA5Qr1qNOlTu8p40PUhcK3EiQSp3kT0YcQLvJ/tJmGkdXonHNKkxzPh4D
	 lnM/6y7RIY4M5CB+u4xvYF2uk48G1UytMkvskOpYY7BKK9YFsFJjKvC51nINsLy6/Y4N5
	 8ehObK2R2yJufCuP/1pI5zo6qT24e3huqt/fTVDvW+ppJ3IDgBY3o05aiLa/QLsNHnVd7
	 ERy64TB9spW1M+sJUXTjrKI0H/A42cKJwXmfXjgO5syBKw/mm50ezELYEXlc67Nyh49A2
	 +BXwFvNdnNLHtIB6+1TurcWgJPZMC43Bh58gKY3HB9VFip2945BtINz+oj5kgURPxFg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788517141;
	bh=5dM90Rgi7lMaA68LMXCb6NXQHPslMCRybW/LqOAMBzc=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IV7L89cKTyku3hMRb+eIFqY3C2LJWEO7EVDYq9hHpUHg8aW5JCszqGRphMTtdWqF7
	 C+/9N2fT9wMqbtCbt+IgXiOh6NDOXkVbI191R67jAOD25LvqUUnmW1X/q1HAf7aPjS
	 phTR27zPgt5o5H7xuAKqcyTcBSfN8xOFy5gE0hvPVhUC2BHo8BOuacUL/XXdv0bZKQ
	 VwJj/NBeVwngNsuY+9c745FJ0zZB7TD7cwHvwjq5MZzKWIZd41TjqQJCc/BciY/6I2
	 VBUoRIo6nvJV13PXnZrQgs0AAPt9uwtnsOfCnvMqrMbj+YyKXWNv7uQshkgMmDORLX
	 cu18OeNmOpKxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE61240B48;
	Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E885877F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E591A810CD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tv_WBCPSLO2z for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 10:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 12D4F810CC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788517139;
 b=qeRYqdIkSZDkTucnuoQkRr6TKlH1ByLApMa0eOw7W7UawvYvRIspyv/HISEy/v69F0ZA
 /EBR/Iwa9I2NJ/WRVkrNLdS5GIihYFPKCMOKKeIjU/9IBvk3n6OjtDCWAvzlUMy0V8Eyx
 NuNck51WWdMxlJXxdONRiqh2rgq+QTazLGqdseRxYSiFkKBkSmkJ7wZ779F6QnbW4vqrr
 e+0fRrSrH5fXll54lSnZ8y0GoqaAB/kPcGhP2q261zbTCFln+MsRXpflYsD+i4tid5woT
 0dVlMGi7sVx+1AMnd7/b0l+S11rtwDTeKZiZ/VqVqf3XbM9gXILQjLs63taR8m5gVXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788517139;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
 bh=5dM90Rgi7lMaA68LMXCb6NXQHPslMCRybW/LqOAMBzc=;
 b=Wk29y/5P+lWG+dTIi0JTXJbKVbWbcLy+X6PVeXJdCY0NakAfZsClKFtIZ9tmALUgP2ph
 3BkcTa0k/iTGIUUpihtO7yBHtTNc5/R6v7zCm5bRpmrtvk38VTKQOtv38XsgKR9vPbVGc
 SITGeWNko4ysDcmliakxTCSpt3QM5FkwN0f8a8Fqj85QHsv+k4qnmRgF0cCQkc7altTTE
 7qc1wn8+k5rVswmLoix0QIty8sAuu+J2r6oCAWiU0YvIiS8GZl8tdNdSyvCa18LvvWdar
 jdhCVd7ToRA3zDKOZfndR84LzIAx3jPp0a1hv1d42FP7RStoAfClF4pCi4cvb+8dvSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=UOZKd+UE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=UOZKd+UE
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12D4F810CC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omGgQCqlEokL9aHX8OgyzCLOeC0x1Gemabfzo8np33Nm6n8pYZlxSbQvU+RPEMNZlPgWSA3VLqMlfQU5fRpAJ01mPlPb15h1qW6CyggSphN5Io173kKPbSy+N13BtqY/6wkaKe18vuGyi9tdgzrWRJZSAgRuRDTFTDX7k/cjtr6lCLwch33+puFa6PjXSHVZeyc+u7w00Ise5OqxUzuvhHxXAR7ANTgOmPkToOOrLG2YEF3ddzijHQyYFrkhhcVqQgaatGOK5jd0rtvJUng7lADCyIkz0/rw0TA0VA3vuxlokY2SKswWgNXGlAq4p5l0jneFCFTqquE3gs9e9OkSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dM90Rgi7lMaA68LMXCb6NXQHPslMCRybW/LqOAMBzc=;
 b=Pw+nx2STiv+OzJejbvvgjcz3ng3CP874wmY9pSSeoBKIPLhuFza4gmrVh8ThNXxTxZ5FokU246xUisIAuynhzsLveXz+/kzVVAohyKod6rJ2dDLdQQTOz9B7hnAaIP+vNWCAedIp2HBvkBY9S+yXcV49YZFkPFywGVFSYd5qnsKEtJdorcO82oA2upRvwF3szJ1DN8iZeqGi2EuLWtjRPgDVXoYr7vG0f5DOjPychH7/hwOKu2ix3WGKv/R5GI2dwoEAtRkeXHTtIYi1h4x8CmV6MQgA/z8WyH3boASWAjWgntT79FywjO6hQMDr87OqzKdMLuTdNvBLdq1UEZ41zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.87) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dM90Rgi7lMaA68LMXCb6NXQHPslMCRybW/LqOAMBzc=;
 b=UOZKd+UEGfvd72Zoc4HuMY30qjGMFbLccmKNWf202nfjbpFsHmdlMjjAimLU471M68bCz+gfF+JO1p6XYUE4WxxjP0EW3c3MqGhzz4n2uXRYDPsDjc8nLxVjMm+WrCjiFxB7++v/KPGTlao+83ht8BJqPhevGDlU79cC317hXhLdNLeVd7puWcuYBDygh7GIvc7oZxCevlBdEdWAD5fZz678v0iLX2l4h43yeis15W+ygwb10q/bgnhuD8GkT1yQXGx/lfkihPoc/UkGzTuGZ/WyvP+8wriaLzB0+m8PP1qXuofRWdIfzOCY9bLLd17t1RzWiOmOnSSkA+3J3gH1qA==
Received: from DB8P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::11)
 by AM7PR10MB3573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:18:52 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::4f) by DB8P191CA0001.outlook.office365.com
 (2603:10a6:10:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 10:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.87)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.87; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.87) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 10:18:51 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:20:47 +0200
Received: from localhost (10.252.0.201) by ENXDAG1NODE3.st.com (10.75.129.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:18:50 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3] configs: STM32MP2: Update config for STM32 SoCs
Date: Fri, 4 Sep 2026 12:18:39 +0200
Message-ID: <20260904-upstream_update_mp2_defconfig-v1-0-695c0abaac73@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP+ammoC/yXM0QrCIBQA0F8Z9znBZAX1KxGi3uu6wZx4NYKxf
 8+2x/NyVhAqTAL3YYVCHxZeUsf5NEB4uTSRYuwGo81V3/SoWpZayM22ZXSV7JyNRYphSZEnhRe
 PNHrE6AL0IxeK/N3/x/OwNP+mUP8pbNsP4RnGG4EAAAA=
X-Change-ID: 20260904-upstream_update_mp2_defconfig-d5bde4bddfac
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.252.0.201]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AM7PR10MB3573:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8d518a-04ca-41e3-ae0e-08df0a6deaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: s3t/KJ+Vt/ZIFZSg71gK/QQuLQT/nXZHwkDIs2qd1UxbWbGY4V1csIYMtSEjaq3hHU9L+Je8PR1+C/A5AfokBx0eZ4mj24HtXaPs2QlZN+YdsNbkHdYYySY0yZD06d5o2VHx36ZpjJvHH11zkaQnVV7+BDxstTt/iIFl/dtaI0HAFlTGJbdPvFYupYZbFE2aRImZBzRoydvMdmxzxJCQsA52zFe7SAQurHzzV8AWQuWC5hxfBHHWzH/cvgsh0VSV/RkaJwIyrAtC2Lw9crezUfQN5b2MK0X/eSqmM16Kg3izsSWSf33czQUy/gIMsghbdBCkDWLeQaeOlPQLq3p8emfx+1PKMovdfi5XuuFX7yucgL9N6BCIckOHfJbHqRIuH7QbWyWkqTRpvbD13qUfoihQnPT2zzc1MnCdrLws23zTPOQzQ646ucUhoK0jJBwLDMRtd3bB8AUFZ6zfeY9DgQMymNXoz4otTQDeh7hrhIc0sEalhgLAcxiHCnEDMizraHi2xOqFvZ1ewKvNFj+JDkhBf6tty86y/8N4jYxQCpKxyQbIha/2iIDx/HK4FdYr4krdZLPiv5+2TyU3DKSw/ZRbTdlnfpWFjbmteh1PjbGEItnu4XLMf63+Dyh5BoIfrsfx37nrp7bF28fJONITcxn+nxIXzQBM0pYCRgk2i94=
X-Forefront-Antispam-Report: CIP:164.130.1.87; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ywi4yWc/NcGbyFQzR0VXbg8TbtFKCh/qn5JBMNV7bXD+DnREHrpDeND/Q9mX8Aj99SPG/Od86f1FVdhoZ5UdjwMMgLaNO13TasZfozVpltkl43z2u/3bNdVbggL49Sd76m+yVNqplPTla9BdR95otzx67++ynII0MvBFNSAPFHYBl+D/7q7wys0wlYUy9BBzg86W5QMj5hzb65REj9kdkdyZYu4Cvpi99KbdEo9NkgKjHXc3Ocm/G6SaBWDhZF+Cyd6LshgeGTegPmTutzw6V8aNqvqUKqvOrzeNLxosCFGa2xTkGHfXMU+Dw0CccnRZlPQy3hKVgyTTS7I1GlgcrwrKHnUzWJnaXO9WNr7FBSpdvkyQFqvsqkNmn+GXlAxz0FzcisoW6ELAF0OtE/XZxuqtAShpSVLe9RJbxuklnxut3EvKbA21EeotnCXStwBK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:18:51.8121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8d518a-04ca-41e3-ae0e-08df0a6deaf0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.87];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3573
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

_ Enable CMD_BDINFO flasg for STM32mp25 and STM32MP21 defconfig
_ Synchronize STM32MP23 defconfig with STM32MP25's one

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (3):
      configs: stm32mp25: Enable CMD_BDINFO_EXTRA flag
      configs: stm32mp21: Enable CMD_BDINFO_EXTRA flag
      configs: stm32mp23: Sync config with STM32MP25 one

 configs/stm32mp21_defconfig |  2 +-
 configs/stm32mp23_defconfig | 28 ++++++++++++++++++++++++++--
 configs/stm32mp25_defconfig |  2 +-
 3 files changed, 28 insertions(+), 4 deletions(-)
---
base-commit: 1c5004ffc5e3f000eca6cada32af7c83bd925c2b
change-id: 20260904-upstream_update_mp2_defconfig-d5bde4bddfac

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

