Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE578C79F85
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D33260C18;
	Fri,  4 Sep 2026 08:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0deCSov1ZQMS; Fri,  4 Sep 2026 08:37:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B133260C0A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511067;
	b=QvZm9yG33KODlYgakoiVGLIWk3oIiSDcauZV6VPXIXER73sV4urJEY/SHOkQIp1p1+vR
	 z5Q97NV2edtPqfuKBxSxl9pqgDrrtBLgHjadn4UNRvOyxuDtzL8h+QQ1Ba4PUa6WaFWRd
	 AzroF/bbhIsfi5GiMeYPTe3WA4wOih7uVsA5NwyZQnoSsgVTe8A3HplEkCDTHCWQrkMqq
	 jimpL1zk/fqUbDPwesQ6ZTQ9+rCNXpaCO1qciwB/MkVJJH5WDnSHBk6n91jNIAskj3zel
	 C8c6yHpM0uvpfvlYmGNS1nkfZTzHYr+iZutOcn9vnh6D71Q2SJDYZAsPEgYRtmYViiw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PoyNammNa3y/Q3+KU1XhFNSEAO3ibkoEFyLnRuk3lnY=;
	b=O8TybuqVTKoVEFS403/v5U0CJjbNdUobl0QKokKT19nllV53js1kyJ1ZMeq9AkK/8FOf
	 mg/7Qh7VDN9IPJEKlIGlE1jJJ288qN2QC8DZ9xPNKTj7mhqydTeqU3RTg10U4RIru5tnF
	 rdq2KltHSYG+19RLW7KQZYKpJBeKaiC7J2MNpW8Fy/DkDhoimgIejbrcDuqPDZ+C869W2
	 4L303LHGcNCn+6PnvwvsRrPNJeR1q+v5qQ4sf2Bcq2Wg9w5rjiMwEAHS991DlhGBhJTPd
	 uVwwE+mZcJbfW6LoyvZyBg7rXRBxe9IVTI+vDX2+aToIq3lnnvZaaPvS8SZmXJZogXA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511067;
	bh=PoyNammNa3y/Q3+KU1XhFNSEAO3ibkoEFyLnRuk3lnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0ePMIvJnupZmzbFmZzebJT293dn2n26NXFSNihwGiEPsfTHihsQxtmLUedyhjBMgG
	 Hw8eiZQDpGZA3vcuNcotFKyuPfFdVB6rBArTPo36WA+Q9Xnmy+i7ueEw0xEkEk0yJR
	 aMaxGTACVi6PjQclsX8sQ4kZIrDvHuZ4uHO6lk9s44VZgjnIVMyTyvcmSpGg/7Eugt
	 6cufd8LNhnzYFvO2fl6tcvqIyletw1UkbynW/wtIrUGDgqbeFuG8FVIU4a0fUBPKdu
	 CJiOJkAJDty+9kLVpY7bF1vVR2+fI3GN5jh1ZUKHH+hbTKA76YwPnZGk981hVuAjrB
	 1ZUJyepcRQSDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B133260C0A;
	Fri,  4 Sep 2026 08:37:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B3CD3AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F03DF4013E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ix8Oargyhjqt for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AE0264016D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=EkSKiXakZtg/HREYts0OQRvxw3AkgHqKexrR1lOkDLrzjKIXcuXwHomhLOHnkqGw9X3I
 XYlmc/r3ZVlyrbv+ymN+lPzqIxBnPSm8oQqXbsxN1jx9HecIwDyPH7sqYE/0qkvNpf+Tr
 TXk5p4D/zjTw4wzqTavUYeUUCDZEvIjyHflOWJKHZnxkOCeLSIAwOzoJ2CS2CKCW2E1Ei
 G9jNmrYNB5EEY3OLKjl+rYuzgl/0lXMk0w9EcKqoUs8dVw3AdLeBTIY6wlL0iHnEDAqJl
 nAUmixrFhkN6ZZwtF7m5GlkWeu2vI0MsW+VEMc2dz2ZXq/maOYch8fdse1hVeeamonQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511049;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
 bh=PoyNammNa3y/Q3+KU1XhFNSEAO3ibkoEFyLnRuk3lnY=;
 b=sJPk2LIVV8weNnoptxoly9SSmd3BoyL+M5YLEJQSfPqfeTskfjekaado+3d4WWltv3Vc
 pbIKlJ733eYxL/Y2yHO0q8xWKhlTL7kIDR77tOErudWmhE1E/jb2p9T73yL0piR3ai1hW
 HozZFFHaQ3EKPD59wchhnjKWSjtV5uWlU+PbyrgrV1V9NQbxSjAVwpc9RCaFltUDKSguW
 vcDnrVq/bLPCZx/AavD+PBvJyXTN8UACi4j7OgdXoIM1hUT16rOtGRZBve3hbDSvQtrg/
 S8K1EW1VBknFqE0M3AFQDGFa93MOi1x364Bxt6n8/MMqP46aJzs3a8e+TZzo1rjHCZA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Nthnta+a; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Nthnta+a
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE0264016D
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh+EmawjCRq6Sn9sANE34Z9/bw7IgBx7Hit0zCt+4SfvnRfcMZWDFlCe93gcgcQilXWF18FEM5zYBDcduydMchnyXmLqV5wG4SUIuJQMWNFOsvX3SRpeYWiYu1UzDkJGM2t9JO/N1wfvZn5mPCjJJ9IfJgw9t7goohKywIouw93CcX0Z0gFsojkMKgmuQjJvK4yWGm1QfYgiiPWo2GY/AC4FDEGlfaOnHUiOWJpk/C30AsqlDHfeZfeK5Iu3H3LVNki6urgySE2RyF+6Fd95Jw+xtpMGaR5YHlBT54W3xg1IVlYA0HiI8hNb6VHkFwv1qKgeU7XUemDsORC5qR3zLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoyNammNa3y/Q3+KU1XhFNSEAO3ibkoEFyLnRuk3lnY=;
 b=QATGGxHq/fLxpdarBcZ6UJPVtVpTZLMmgiOiXn2HSIFEQ/VnEiv+umjPjKiZB64P0KD5P/fylXb9zaV0Yr5BW7wsURZxLg0HWgNl/b7ID3NKIJq6JjZfwgYpZ4+yHQ6zgs2lS7HZeSy8m7hsItmzMHR2K52OTIWqNuslFTyviDFSd1eVFsdAMynkq47vSuIXpUnzQW7/fGrBkVZYmOVCkRqGSOgvFyJjCINWGdDwmBzcpTkBEZv1RujSqpiaXnLnimi0tkrPm81Zodeg9WSSZOzTG/wK0niQ+aonEIh41Ex/nTHm5s16wRxtVs4iKACkYGLY6f2HoqSTYNtcza/vwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoyNammNa3y/Q3+KU1XhFNSEAO3ibkoEFyLnRuk3lnY=;
 b=Nthnta+axSE0QGQMONfy9Ag3TUg3QEbA8LGM8Vk90Z3FY5lWl4oy5wDsWPZGkxmWO7WD/OYWtDCJR3tAWAEOzIB9w1g8uK2bzSMEdn1wttPdhoYqRRd2Edycs40MKp/Rgp+EiXyiwRh2IoGFcQBv99Sx1fd4GAvXeBdZjCSFbxH9rC6eqlsf6VbQJsqXcHPg7t78AQFH8t7+KnjQq3fLXZVNcHhCRM5RLwQYEHNupVfmx/N+5FgLdRWuYKwn+L/F3+P+2ojvHiNgg15+QNXZfCXLBu6up7a1lUym/DjJqf/cDIriKPGJDaet3ds8tZIzAdhf0SPPQB/9KAO9Licu3Q==
Received: from PR3P189CA0008.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::13)
 by MR1P264MB3538.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:52:cafe::8f) by PR3P189CA0008.outlook.office365.com
 (2603:10a6:102:52::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0784C202C1;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v10 03/15] ecdsa: initial support of ecdsa using mbedtls
Date: Fri,  4 Sep 2026 10:37:07 +0200
Message-ID: <20260904083719.53132-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|MR1P264MB3538:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b29769b9-7519-44c2-a50a-08df0a5fbd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: GdQLi3POz9itkffO8WA+v/fJzq4OGwYEyClmLKIH9AWRsTdvQJoEABmO/hsd5696TwH1w4vkQnocexgn8Fd9u6sILskHuXlqEsIWTt40Wq+PqThEUYWZ6RIawXLYtUDc6NxoH4lE+HSyN05oi9m1wgWtG2P3dbiLwlvAY3dyceUDjMwHQLbygUqoln3Je+nYaRwsz3KnUIUBcVFonIJV09Q0Sq0gJu4UHLBm0Vua1rEVXe78X+7q+Y4A+8cS6MhXL8OE7QAJbvHYvCY0mPBESnSBSCz7+x7ibvMF/oetIt0YJdkP92Hghs9BIvAq6XgUBcpmk8p4NCRq0304AeFzEBBK0m3SsNXvQ5QumIJiPrHBKlfWn0L1p6I6Tpumtg55AgEy9xKyLUGyS35wZzQhk7V3ZrSs9eznSh89hbqVMYptrtmXlF+uvwAIbmkqZCCqUHrD11CqjDN0o3frzsEphugyo8qBqSQeRmpybupXfanaxfcY5H0SEia44JIll2FTBPmsbdPiFHmtBO5hy10r4f67zPfFB2r/MqPTYwXFoYfLO3T+mGnYPZoMF9yEh/AD
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B98jAQ2HHrtdRo6+YCu9QKT2LwzbLaIMwRGo/qDRUbFcKov2AxAOQDgRjx8vyYjxnBkIeY7gsqx09vq5eFUR1uZxr15UnWV/WNOsyGdHJVxw8aw/wlQHsNzC/7PqROXAN9txtlRNCKg44CfNbQwVhD7Inxw7mzBxbbShXLUyfWx4CgryyxOhtIVf7F3J+eIf0pfBC4bI2ZvpE6wCUgNpnDiz6ZTY5u4fZtD8KlwCf+65Q7CdQI5caJZG7mNUPgPSnmHsMYuih/r4jM+8b/Vr1AMhipoKVmRACsygOYdqHBD53F9eDkN2UHsZgCKRYy95RQaRSyQt3KPU1KMwBlGDacY1O2HmoPGD0SkAfS9Ov23Q/VNUqTFKZau0vvKO6a9ap69GPhTv9fggy+f1/O5Nzb7rC2Rri2tSRGnbSQrFg7QJCGR0UTReEoXNZdyHGLnz
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.1599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29769b9-7519-44c2-a50a-08df0a5fbd29
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3538
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

Adds an initial support of ecdsa verify using mbedtls.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- rename sw_ecdsa.c to ecdsa.c
v3:
- rename sw_ecdsa_verify to ecdsa_hash_verify
- stop on first group found
- check signature len
- use debug instead of printf
- check function returns
- fix memleaks in ecdsa_hash_verify
v4:
- move struct ecdsa_public_key from ecdsa-u-class.h to internal/ecdsa.h
- use DIV_ROUND_UP
- some code cleanup
v5:
- add kerneldoc header for ecdsa_hash_verify
- read error when setting Q.Z
v6:
- add ECDSA_VERIFY_MBEDTLS
- fix kerneldoc: doc not add a space before :
v7:
- no change
v8:
- add some useful comments
- avoid using label such as out1, out2, out3 ...
- code cleanup
v9:
- no change
v10:
- no change

 configs/sandbox_defconfig       |   1 +
 include/crypto/ecdsa-uclass.h   |  15 +---
 include/crypto/internal/ecdsa.h |  39 ++++++++
 lib/mbedtls/Kconfig             |   7 ++
 lib/mbedtls/Makefile            |   3 +
 lib/mbedtls/ecdsa.c             | 152 ++++++++++++++++++++++++++++++++
 6 files changed, 203 insertions(+), 14 deletions(-)
 create mode 100644 include/crypto/internal/ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index b9991d269d9..63682ef0e74 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -390,6 +390,7 @@ CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_HKDF_MBEDTLS=y
 CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA_VERIFY_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
diff --git a/include/crypto/ecdsa-uclass.h b/include/crypto/ecdsa-uclass.h
index 189843820a0..047a5eda2fc 100644
--- a/include/crypto/ecdsa-uclass.h
+++ b/include/crypto/ecdsa-uclass.h
@@ -4,20 +4,7 @@
  */
 
 #include <dm/device.h>
-
-/**
- * struct ecdsa_public_key - ECDSA public key properties
- *
- * The struct has pointers to the (x, y) curve coordinates to an ECDSA public
- * key, as well as the name of the ECDSA curve. The size of the key is inferred
- * from the 'curve_name'
- */
-struct ecdsa_public_key {
-	const char *curve_name;	/* Name of curve, e.g. "prime256v1" */
-	const void *x;		/* x coordinate of public key */
-	const void *y;		/* y coordinate of public key */
-	unsigned int size_bits;	/* key size in bits, derived from curve name */
-};
+#include <crypto/internal/ecdsa.h>
 
 struct ecdsa_ops {
 	/**
diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ecdsa.h
new file mode 100644
index 00000000000..244a07d1f1f
--- /dev/null
+++ b/include/crypto/internal/ecdsa.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#ifndef _ECDSA_HELPER_
+#define _ECDSA_HELPER_
+
+#include <linux/types.h>
+
+/**
+ * struct ecdsa_public_key - ECDSA public key properties
+ *
+ * The struct has pointers to the (x, y) curve coordinates to an ECDSA public
+ * key, as well as the name of the ECDSA curve. The size of the key is inferred
+ * from the 'curve_name'
+ */
+struct ecdsa_public_key {
+	const char *curve_name;	/* Name of curve, e.g. "prime256v1" */
+	const void *x;		/* x coordinate of public key */
+	const void *y;		/* y coordinate of public key */
+	unsigned int size_bits;	/* key size in bits, derived from curve name */
+};
+
+/**
+ * ecdsa_hash_verify() - Verify the ecdsa signature of a hash
+ *
+ * @pubkey: ecdsa public key
+ * @hash: Hash
+ * @hash_len: Size of the hash
+ * @signature: Signature
+ * @sig_len: Size of the signature
+ *
+ * Return: 0 if all verified ok, <0 on error
+ */
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len);
+
+#endif
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index e019f17d6bd..66bc16db451 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -308,6 +308,13 @@ config ECDSA_MBEDTLS
 	  This option enables support of ECDSA with the MbedTLS certificate
 	  library.
 
+config ECDSA_VERIFY_MBEDTLS
+	bool "Enable ECDSA verify"
+	depends on ECDSA_MBEDTLS && ECDSA_VERIFY
+	help
+	  This option enables support of ECDSA signature check with
+	  MbedTLS certificate library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 0c86c90d15a..b96db812afc 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
 
+# shim layer for ecdsa verify
+obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) += ecdsa.o
+
 # x509 libraries
 obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
new file mode 100644
index 00000000000..ca4e572e638
--- /dev/null
+++ b/lib/mbedtls/ecdsa.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+
+#include <log.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <crypto/internal/ecdsa.h>
+
+#include "mbedtls_options.h" /* required to access private fields */
+#include <mbedtls/ecdsa.h>
+#include <mbedtls/ecp.h>
+
+static mbedtls_ecp_group_id ecdsa_search_group_id(const char *curve_name)
+{
+	mbedtls_ecp_group_id grp_id = MBEDTLS_ECP_DP_NONE;
+	const mbedtls_ecp_curve_info *info;
+
+	if (!curve_name)
+		return MBEDTLS_ECP_DP_NONE;
+
+	/*
+	 * This curve name is read in the FIT metadata.
+	 * When this FIT metadata are filled by mkimage (or binman),
+	 * the curve name is the alias/name provided by OpenSSL.
+	 * And for secp256r1, OpenSSL uses the alias prime256v1.
+	 * So here, we have to manage this OpenSSL alias.
+	 */
+	if (!strcmp(curve_name, "prime256v1"))
+		return MBEDTLS_ECP_DP_SECP256R1;
+
+	info = mbedtls_ecp_curve_list();
+	while (info && info->name) {
+		if (!strcmp(curve_name, info->name)) {
+			grp_id = info->grp_id;
+			break;
+		}
+		info++;
+	}
+
+	return grp_id;
+}
+
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len)
+{
+	mbedtls_ecp_group_id grp_id;
+	mbedtls_ecp_group grp;
+	mbedtls_ecp_point Q;
+	mbedtls_mpi r, s;
+	int key_len;
+	int err;
+
+	key_len = DIV_ROUND_UP(pubkey->size_bits, 8);
+
+	/* check the signature len */
+	if (sig_len != 2 * key_len) {
+		log_debug("sig len should be twice the key len (sig len = %zu, key len = %d)\n",
+			  sig_len, key_len);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* search the group */
+	grp_id = ecdsa_search_group_id(pubkey->curve_name);
+	if (grp_id == MBEDTLS_ECP_DP_NONE) {
+		log_debug("curve name %s not found\n", pubkey->curve_name);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* init and load the group */
+	mbedtls_ecp_group_init(&grp);
+	err = mbedtls_ecp_group_load(&grp, grp_id);
+	if (err) {
+		err = -EINVAL;
+		goto free_grp;
+	}
+
+	/* prepare the pubkey */
+	mbedtls_ecp_point_init(&Q);
+	err = mbedtls_mpi_read_binary(&Q.X, pubkey->x, key_len);
+	if (err) {
+		log_debug("could not read value x of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+	err = mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
+	if (err) {
+		log_debug("could not read value y of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+	err = mbedtls_mpi_lset(&Q.Z, 1);
+	if (err) {
+		log_debug("could not set value z of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+
+	/* check if the pubkey is valid */
+	err = mbedtls_ecp_check_pubkey(&grp, &Q);
+	if (err) {
+		log_debug("public key is invalid (err = %d)\n", err);
+		err = -EKEYREJECTED;
+		goto free_q;
+	}
+
+	/* compute r */
+	mbedtls_mpi_init(&r);
+	err = mbedtls_mpi_read_binary(&r, signature, key_len);
+	if (err) {
+		log_debug("could not read value r of the signature (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_r;
+	}
+
+	/* compute s */
+	mbedtls_mpi_init(&s);
+	err = mbedtls_mpi_read_binary(&s, signature + key_len, key_len);
+	if (err) {
+		log_debug("could not read value s of the signature (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_s;
+	}
+
+	/* check the signature */
+	err = mbedtls_ecdsa_verify(&grp, hash, hash_len, &Q, &r, &s);
+	if (err)
+		err = -EINVAL;
+
+ free_s:
+	mbedtls_mpi_free(&s);
+ free_r:
+	mbedtls_mpi_free(&r);
+ free_q:
+	mbedtls_ecp_point_free(&Q);
+ free_grp:
+	mbedtls_ecp_group_free(&grp);
+ out:
+
+	return err;
+}
-- 
2.43.0

