Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E334C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FF924055B;
	Mon,  7 Sep 2026 08:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZWt1LzjKAcA; Mon,  7 Sep 2026 08:16:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 40A2E40556
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788768997;
	b=mEEvhkvPVyM6whwdX6fnWjk11ZOKyZaHWvdpDiFVoIn8TitQNurHRlr1RSHo/lgFochy
	 Ya6kISWSlGJGwR6yeOifZ9oVVevdd8A2iG4NC+cd///+art8h0BAs90x1yJS8EGmkxIcj
	 fTBSLCQdKYU5n0NeBneUYHw5YQGgb/kLgteQ2+KHMlJ16v+9FgbXcOhWIkVFDCpcOyrb/
	 1oLkAVUjm1zqe3ChEYgPrid+yaLiIQ2mFSVuE3SpGYXyadBePO39xU3KiYmEO6cIhCeuc
	 UqFrmcPYTJpT2YA+Q2hMcmx9MvQbXOkZ7p+fDlJ0/iAgoAe3Cm4kM7UPiLb05gkKz6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788768997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mKWc1FdcgK28n/tXD/NVwgIb0fypshjYEep7bBY8QhQ=;
	b=lPTvc+jsh3irys5aQl8xEmu/vW1s+B7uSszjBcFN+snh4YqvNA863u/T/TqJ/EvBNFxk
	 gZZ6AEzo5th1+weGebkagZYYgf3MM8gDZi7jc41EpspcsGXcap5N+af4jfNR4m+XacFoE
	 tqszXOk5jhG3d6IQjJEfNauBtEGP0A/OIparl7NwSzdoCmJLHkED+kveE2mWL2sWwf/qM
	 jWCErZkN0iD5HxuWgVbiVzxc76NSX/HF7+3m3nuaCqRI2ZrbLp6BcaJ2p9JKh8LzkFgL6
	 DeXk2Ynd9qF6wiA0LcnlaNCaTuNt/7CIu07frtF+Z9d2i2FTYZWZUd5FL7mT/Cnf/fA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788768997;
	bh=mKWc1FdcgK28n/tXD/NVwgIb0fypshjYEep7bBY8QhQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rxe+jDiSn4gaTVgGK1qJBMYjdY4fcnizx+RjhFI1VoWvnGehEy8K1ABNOK5IoyNXB
	 /fS0ubd4Wu4l1PNydctpkjFb1G1Rxr4JgiivkBCNvLwMKxidaadLTNFCw59VCibCyu
	 jRaTIHteS0n9+03RQmV4zJiPjr9JO7eF+HAR/lJZWgQfbVxEQ6W2bhNZrO73kZflK4
	 0sUv/DdK8Z2i47a0LHMI5qr8p8Mw3hl04tx/+h0dRTJNmXtwNAoSwWc0U/mRhlPnQI
	 hJ3pQYn6/20OsmvNaRX+YvETYON9ltzIsxH+I4C9SxsJ9CTc4353OO2wWAws1wTKnz
	 HeClxjeTp7k4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40A2E40556;
	Mon,  7 Sep 2026 08:16:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E54872C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53F6D80AEF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmXsb-VEjqFf for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 97C2080AA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788768995;
 b=Xg9fj2KAVRNHz7BWyW7AiW3F+O5EzcAttaH4ZIPIw7a0v4X+w0lxiiZSiMFYPplVyhtq
 mj8xR/kQ+FrqQ0KAqsdXE6oSvYuS2RLIhnKy1Pg0e8Zr97GX8n9pALERl3HS0Llu+Y9NI
 Hr/quBC19wR8dFJDxN1dp21vwDqdXfrgYCDLuh6OYNwnzy1Dq5S8Z/dmzsVQcS/eeYUS4
 AHOY2D6BkL8JNAov6wispEWcEMXO3ohf3h2hipiyH1ThiFs2C5yL6Ftt2xK/HZsZGLXg9
 TPp+GozGzbez4HrH5BBhI4gWG2lgj+04QZkVaxi2uDH/4FMxbr1b0/nTc5L/Hii5BOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788768995;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=mKWc1FdcgK28n/tXD/NVwgIb0fypshjYEep7bBY8QhQ=;
 b=W5X0qqaL3v+iv2Trnzw0L2XhJrGGwG+DKw47Rr2hQB3QYdkwv/jcrTRtQCcxpDiFaDnH
 j4QwLZWusCzVBUAcZz27V4tPUAdkchaXgz2nrNB3NlE03yX4iIhkRV5meLAuMUl8Yuqoh
 iHcVF6XsbZ0MtO9JIHjf/3lmzrR2XDNIqZ4QfgBicL31lfWtLddrO7yeNSml10Ex2M+E5
 yQQltgdm/q6PUdJkwENS1Tu1YKU5JhyTl4tAA6HnxRzoPC4vu/IEbF53BBRmzV/8+TPGV
 qKEN99EYmJTmHKJ9D9tuy2uOyoYB6W3MGfLAPQF0gBP9m6K7/k/hZug6WgM4DR5krJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Nk8h5rh3; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=GGZj5VEG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Nk8h5rh3; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=GGZj5VEG
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97C2080AA3
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:16:35 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68775xP42615561;
 Mon, 7 Sep 2026 03:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=mKWc1FdcgK28n/tXD/NVwgIb0fypshjYEep7bBY8Q
 hQ=; b=Nk8h5rh3yBqWZG0Dt4WgN4GOz0qwyzS8CdABJVdJW7pSfiyflvMQS8eY5
 emkO1ahEKUQixFDRDMAG6a6PSNP44hBpHuFsMX5gyyvgKSCStkJ40YzUdG1nox+o
 dHZgZLqx9rICFrZs98cdZwKhXB63d8XTqVGEFQTeVZmTSi/T+/QaxwTiSV4aVAQZ
 3IVVUcd1dOXSyV/mBOiPmg/O9WYJTpiHhnuU3o8gWuUFHt8QmyTYimShMkZ/IiHH
 r1D3w6trSEACD8VWC9+kPhM4jExGUswqG2ox+gEP275R1hdq4iy96Z9ZQbLCZMM4
 u6lXQdVdhQWnM+lGIrLKetZRUxyrw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gh43n4j8y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:16:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9ltT7jMbALLRP40Qk/TKVB4E62vjmiU06YhzVE4xD//iQ7baAV5ktz51qJ1exjHZVTHWJpZvIE3LfonL55o04QJAcxvZfzcG0aDAGGrYSEqgmFORhiK978j/OFFkhoh8E86VFUgRYSPPeiBdVLbgdFan0RXZIn/GY+5QkiVL/nEnMDNn8Y0AS30FJIRhDDKKen7WzEop9AwnbhhV6NcQZQ+Gjs+DwDHHT+Hf3RiL1h9ss1wEVfeO/HUeRPjgHhJEX4l2IP9jZZNvplavSGSb4JhT6oBV7aQROTc3qrri4Ii4mPAhQLDwKr8Pz618AbmQzW6FZYB5Iec3FdvPpYXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKWc1FdcgK28n/tXD/NVwgIb0fypshjYEep7bBY8QhQ=;
 b=y0kXtZgW4hFqKj2dx3RstxTmYrsUt3n8rpU9tj7UtPn1sf0C9xYDWlVg/bW7ZS73rmYyTjyAaAhA4ezxOVakQRP5lKA2T7cOWu7nWiIhgmGYMc0lNG24N/D7fUVzl3sPR/a+FoJg25FgfiV+gWNCSk6b/ldyQw6aJi0BODQdN9WtB/m6JbbNrwCk5kCAXxKDRbjQjpJsdCVoWbVUwzn5hRLYJRfLq/jfJ/2Jcifq8ecZtepHyIVGrWVxcAaDctW3K6bDX6SH1X6FBclTaq4W9W00emP1/4KJn948zq9V4nvptfJDU53W0tW8QKCD7irPLKrkJf1jhhiVYDkiZLEyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKWc1FdcgK28n/tXD/NVwgIb0fypshjYEep7bBY8QhQ=;
 b=GGZj5VEGsjmPz7U0X8bzZolRO2SsmG3qN6S6jYN+Vm2IUbvBsE31JX8yv9KNfJIj4nIL7LO+8PriNaOBwz54r0H8mYrTz1Pt11S8JNbZDs6T8X+PzHqqm1zl5rtPKQxNdtyLeK94xUBgX27VYAdwELlv2AlnblYCwbFQKhJro6E=
Received: from CY8PR11CA0004.namprd11.prod.outlook.com (2603:10b6:930:48::12)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Mon, 7 Sep 2026
 08:16:27 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::f) by CY8PR11CA0004.outlook.office365.com
 (2603:10b6:930:48::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:16:27 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:16:22 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:16:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:16:22 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878GHrx1137699;
 Mon, 7 Sep 2026 03:16:18 -0500
Message-ID: <49f809e5-5ca0-4070-9541-e8bc5fea3618@ti.com>
Date: Mon, 7 Sep 2026 13:46:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/21] ram: k3-ddrss: Add exit retention support
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, "Francis, Neha" <n-francis@ti.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-13-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-13-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR10MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: 6badf28d-80ea-4911-c4a0-08df0cb85068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|921020|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LZ3VtU1i7/iyT/InaPRsupWquXlOILh3tTIf3MDslvSBShAL7ZSNXFtuLlzAcXvd32Yq2HisWgTZ7ZzYxk56MP/xVsYhFslW3XaMYIX0tJRd2rDbhKdPFy4jOFbHZT6aOH+y63Q+e0tHc6bLSDHnXSSz5CQKmsMvFL4Qq/kTXIMmbAHLVGvSrPArehQX9IvSJq549Jzo7IER8nNylsOyt4TqY4agmW4WhTC9+eIZz58QJYtD114qptnYpQIk/2aJKQIcG7KVEMp/4yi+/tk1P4Yud6mGCsqOqD1GU/kZOtFzr0Am7PqJ7BCas3AwMtUDtOr/A75x5ZzNU+yKMu8EM+EQKOaOU7xOw5r0fp1hj1PLtDSoDMLmdn6CNmx55MfjPvCEZ+fLUYfDmkADHu3NbERolipOAIJlmTPkiQKWWjS1g+ztji0WtqF4eBJvO5ntPA60H0/boWwx18gH5TrUoIVuZF9wkPKEAzM58KPjj9Y/2+FWino6P5RUGjtq0KDcTX9ctmMRZoUPDIIs3esPnPUVvMBHG1VWIaUjLRAOMVt7c8xR9XiBsfo0fZnD1E5KFxj90YpASaWyX4lKK9pCtFxLTRVmRQxS72JvxrIGSuVI0p78SyClV4NbEmi2zTPKayNDVwy921friR7qd8Erz5VnFLqH8cnZ+QAvWvh/utgQxA9fbt0uvMYN9DdNT7fTt80k9V1RRom3XWYEIDrTdOfyfLATZXOZiscjsIjs2H1nWqncYaKluKSCveN07ihr
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(921020)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 971bfLv9ZVYwjbugNUZ2jC2VCIErVH3iO4kiRrgQf+O6iNKPtk7q5DQod4ZeyI02mbxv9h9K66tnC2A23zL5ZtPywlljfr6RVjEjqo7av/KAwFhkLiufMMrDdQAMTaeMGSW/SFWDB4T20ULbzx70f4nrEqn2ZrfMqx2JhdCuVxImjyhO9ohRYwGZFN2A99KEKmCSvcrPdC8K5EvdoKir8fJbcFi+TialtuX36VFhW0vhPTQwwUzaveC69oURWfm1z8p7/ZR+uRICG/HOWQkBFpGvVpJV3u1I5yb1RvU9mQ7Z+ISuqi0SKMultXgCuLNZc4vbxM7QRj+sUe/jigaFOqRqPIx7q/I72TNkihFBChc+gPaSCymTg9TFmUqoKg/KTio/8F9uE+hv1x8GJYfXX8Nk4nrBxnJANRezfqK/sQuKOdISbZ66/cpckzdDEcYZ
X-Exchange-RoutingPolicyChecked: iTV5niGqQmOmkQZt9jqRR5wVy5pz/WVeOP10eHLJ9Fs2L+zSojXmg26OXPZFr+zCJq4xrvvgHkDatpR/rNpQWUz61UHnQCJDnftHWSaj7M8mnmCJF0KrMEBV0TUfvL07lAWiE7CrI8ik55UMQ5SdTI1LQpaGH+49d5qLz2IGIQ+WpfFUq+umLSj/LWKcM+W6Ady+7O+yfe97gKs6Sz+PwfibK5qnfIbzOu8cccMcvTYQPEEQjP2Yi+KuNBE+Tj4YIZq300QeCz0pqSW0MWbJebUM+Pj27Te+FzGBGEluLczqx+PVtAMTJb8MBEtO5PfBEV7RrYJCZWR0AqvuclGMBw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:16:27.1637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6badf28d-80ea-4911-c4a0-08df0cb85068
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-GUID: 00b1j3bhgJme9nkRHDz0OGbDdNA5M4j4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4OSBTYWx0ZWRfX6c6PVASqAnYM
 4vElnsop+M6yFAc3S+7lEQMsCQGRgWJ673W81aNEUj0vK64lYG/BNILIoJIjSje8ca6xZNWL4X+
 10sH66AKua5koDTlUjz+5Hl51WRYH5T5//xANJnQ5E4kTNQY4ZAH+CUgiAEDkQgy2lj3kFGMCDi
 gZqWKAaG2Idzcz1P+irmPuwjRqx3azDEhQXueEKRwIBduRRv5M9rSt3qg/4+Wkyt79OJ4vbakby
 6x1Zza4J5Geyj5APSMcUVpccPNy1npstxFe8yEKQWJg0TN74f4odPHAWYsSQJrG4UO9ALL8DM4g
 1gALGz1w1ld4DbvYFHq5RW3W2FhtLsg5KY0ywZHqK2lo4o/URFT+mOZivyWtQRe5rOQD1QnvX8a
 oi9U1MaTRyx3cGUVZ8h49Xz0Kdj76TUlUg0UtrbCeYMkW3ryD2QjVQDOdlY4ky345qTZeTbP+T2
 0YZqpGFyVQ7J+3vAWkg==
X-Proofpoint-ORIG-GUID: 00b1j3bhgJme9nkRHDz0OGbDdNA5M4j4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4OSBTYWx0ZWRfX8Q06HTJw5ueY
 JYf3jpX+atREgekmN0ScTPobgv6vAaL4ojDhNOU4NBME06Qe5pa4iw6yscJmNq1ke/hHCL2K3YL
 VX/A3sKrWMVYFv3cnX3XUQm9H7vqE7g=
X-Authority-Analysis: v=2.4 cv=JdSMa0KV c=1 sm=1 tr=0 ts=6a9e72de cx=c_pps
 a=SJ9xqO7H1Prqh+YlTuKNYQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=P-IC7800AAAA:8
 a=sozttTNsAAAA:8 a=1X7Y-5BGwDVwlUI8kcUA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070089
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
> 
> Add functions that implements retention exit sequence of DDR.
> 
> Typical DDR resume sequence is:
> - exit DDR from retention
> - de-assert the DDR_RET pin
> - restore DDR max frequency
> - exit DDR from low power
> 
> We have to separate each action in order to de-assert the DDR_RET pins
> at the right time, because the DDR_RET pins are all tied together
> in hardware.
> Additional interleaving to be taken care and configuring of PMIC differs
> device to device depending on number of PMIC.
> 
> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/include/mach/k3-ddr.h |  16 ++
>  drivers/ram/k3-ddrss/k3-ddrss.c        | 253 +++++++++++++++++++++++++
>  drivers/ram/k3-ddrss/lpddr4_k3_reg.h   |  94 +++++++++
>  3 files changed, 363 insertions(+)
>  create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h
> 
> diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
> index 6ac7f682fb80..5dd4025bdbb7 100644
> --- a/arch/arm/mach-k3/include/mach/k3-ddr.h
> +++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
> @@ -7,6 +7,7 @@
>  #define _K3_DDR_H_
>  
>  #include <spl.h>
> [..]> +#define lpddr4_k3_clr_phy(_ddrss, _reg, _mask) \
> +	_lpddr4_k3_clr(phy, _ddrss, _reg, _mask)
> +
> +#endif  /* LPDDR4_K3_REG */

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

Hello Neha,
please review, if you have some additional comments


