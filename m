Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B10DC982FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:46:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FE4880E09;
	Tue, 22 Sep 2026 08:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxLCYHm7SWdm; Tue, 22 Sep 2026 08:46:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 384F280DF5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790066814;
	b=E6RRDQSINw9mkXT3F7p7v4P6o4xBNfPAF6v+O8hiv66H+1CjX7a4JpaP8uuXkb5RIrjU
	 jTXJXR/K/K9t6pZzs6DoeW3+4kgxCi6o92cfqg2OuRTNoH9i+Fmx88UAdOIslz/KlwRv+
	 Od8Gc5iIocnwmgmfBvAz2h3hgB65Mr/QkWuGjF8DkvbGbM0E3byQPL6ovpQ4FR3qWfR2F
	 hkEdWSIlPVggfRHeKZ5+0Oio301CMSXOWRS6Eb4Slqz9FDL4O5aQG+UL3SMX9LJ0z8RJW
	 0+HUhbk4fbKHAq7Z+jl5utQmdxB2hq13DaebBsvWVaHmj2Y+texPeEQCWCop8fMkL0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790066814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8cN7oVV1fQbCb4vsJ/ES86OWNgWHI6WMMJSNa5LKjOk=;
	b=BTI3yqlWEgKCr1/rF6cEDBINW1DMqXyCZDRRsR86gej21mWcN916SC0VqnAQc/iJveLW
	 G3AXAuudb4187HAIbXkVsdToZx6/jLpFLn6Nz3OhG7xAaBaeR2cfkSNJpLGelJTAT3CUX
	 71c+NcuUaA1/7BmtIJehu/G2qhCntKkTvw+ckWI0YXPgBmYU2rIlyTZqgMMlGzEeT20ib
	 dLTftDE2Db2EuF2ABZlftZOSSnEwv6SzJy9qyk05QB5XpecRn8zN9hZejHJ640iIP36uS
	 nQHhzggED397uSXZGHIzFs2O8kBRc7T9R2ro0L+ie3qjmeW2Tg5MNHIDbOr6aM5bJdw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790066814;
	bh=8cN7oVV1fQbCb4vsJ/ES86OWNgWHI6WMMJSNa5LKjOk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h6z7jzX4VAesFKo4c4fiM7Gmz+2uO6coQmMkNwQf0476f0Zvrxqwn328IjZVgX/2a
	 rgbRM8NcO2Vw8M/KUPhbzRDaNhwMLrXdp1QCqd5mlEwArtc4/SqPEbSyV7ppD+s4a+
	 TITAX24oW+XmSRjqvQj3Za4b8d0gjYAaY/kuIf6i1Jwp0NPHGyc6Iv2cvzJqiwaJS8
	 nzkm1E4ZwUsrSMGQtGXFLKPwSbogMlEYvwagV64nKw2HoZ3mqnfJ4SJHcs3s/jXcrk
	 BDgANqiJYt2gzxhxA+rTWhCUfVsZZtufOu8Jw2uGqod8OpG3Ja9hfPP3/aXODwVygr
	 pfpXTIrGnTfIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 384F280DF5;
	Tue, 22 Sep 2026 08:46:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8251A472
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7438D40194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BIWKLMOG-7MA for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6F10C40061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790066811;
 b=JZGO5Y/+SSP7pjSTsTIkEnmkkx9pvP7FH8eNaAmQGl/zOCDLUvZ0vrrsgGYi93X7VDjW
 omhPpfXN4FQ0q3YhpKKmX3S2bzFgq5TZXYN4b3TAgj5xCer5ZUb90qKmi0XQlzsRX1nt7
 qOF5sLF5mhCqHbBA3oSaCwEio3lcOFPkh25yrD8o1foKQm/wE/fzersTUj1zeXwVSuQrD
 luEwRLJoMwU0TG/6pdhGz5pDQq1/wl/V8Tk7ohvY6HIjzVYqvfgYdyJ/OPR2ZX0gNCC0D
 5xTFP6VDCOp/TLyv2cXjmZ6ECKHlo+ua2Tl8+yGSCL7hruJyZyYoQFrU9daku+7A2+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790066811;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8cN7oVV1fQbCb4vsJ/ES86OWNgWHI6WMMJSNa5LKjOk=;
 b=tZPz24lSMDZQMgDUwwDYKJX2P2TxZzycWhHXq4HmWou1utYj67YBs+T0VImErh7JwIXv
 kfPDEnNeN2IvXq9V2FKbIhdjDsRTYRfg1u1jnk/vKO8H/ZjLhBOWSdqiarW6A5qDjJvFX
 JxB48vGhxhQsWMQ2qAW6GslDryqABDF92F3iL7Ifzyd8qL9sDLVbE/OHpYGws3S4uK6KU
 yblHxq1I/5xLzCl4/R3b/igjJLmO101y169YRE9hX1TQDf+H3H6EJpmCkLDENTPYelIo0
 VjqDi1cpadSL5Q4Wcs1pk3RV6t6iqMzCflYQCry1HNnfLC94Oc8DiyysYnKK3U5tZFg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cdBPDq0M; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=aBcGtZfp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cdBPDq0M; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=aBcGtZfp
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F10C40061
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:51 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M7eeSn1034849; Tue, 22 Sep 2026 03:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=8cN7oVV1fQbCb4vsJ/ES86OWNgWHI6WMMJSNa5LKj
 Ok=; b=cdBPDq0MoX4cVC2oAQONT9SrFoOe5hUlKAnftzoFphz0XBKYr/jWS50gs
 Iuj53xbQJzwN8KY3VnL0bfmYlZC/mDX5TTeR1bFYS5WIXIG+aUKWk1LFsndqkPkU
 gHyYBeJ5lnt9r44yW8ISaeNQOYNioNxSAS3iLVdUzISjaIx/ZIiCh0DvX4tQ82Zx
 NMOpCyVWLpdkx1jppm2NV+YsSuRsZbTpNl0QoBhQMlbDTSdpnJk87h2pUuVU/5nm
 Yg0o4gcfC1SO/oH3qDDsKIiFgz9utPickY3d84Vdo25cPp3gPDttT41r7quDSTBf
 wdX7GU5RvQ4bb5xp0W6j++pM7HvxQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gugxm1rnc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 03:46:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksUe7FOTJy7MqC3zxtKUZdJOOiKAYAwJbBSkJEeetG78EPiHXStaLLMiEotKAPJhr5oMkXg6zw3mZhURffTaO2c2XdMdCefiLUEfBjdXYt/sLSlJzie0oP6J5ziGngU/EH3/H/+3Ay4njRabpaRS7vYj1Q2zhbyIer3Xh5V32KWjyK4PdbMUakgtVoDTn5kVI7lzWy9cJR8UIc28dSogtkmPEYNZ321I/GIrCC5fjwdPAqJ+iss4gHGDS6lWNs1T0j44O5reMqMi+ivdohWKEGcVYEji+fM6nvcIDezZoHArjLIjsebRJ/MEOrId407YDvre0VcVZUXLfGieO2XCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cN7oVV1fQbCb4vsJ/ES86OWNgWHI6WMMJSNa5LKjOk=;
 b=rY2yiRh0fqMV03Iz3yiRIwDZNXOS5BaaVLuhL5Sw60hRmPbZajjZJ9NdhI/vxQDjgLRr+1mTnbBFpF6TiAlxs1bNUAgZ2yShTLrfdfY3lCVT73c4sH6RMju93Vp2rulsnz1l08yO/Y8vRDp6oPqXc1xknyKNWS4OZruWff4xFikM3qFVbo/dPPTqd6Cb9y6zsujR3qYPXqS7nOEFRIU9FDDtY8FkXJJOTrSSKC+0s5lHI+nUWw5qq2VihLZYWnBBdvFmZOfy12NxLvW4TAjZFwwLUe6OGsgcOj1F//SO5+mcJNbJuKZTZp2u20eIs93wkjd4Smvj9n9YuLZZ5MCEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cN7oVV1fQbCb4vsJ/ES86OWNgWHI6WMMJSNa5LKjOk=;
 b=aBcGtZfpeKv7jEnlVDobD/IEbrp0aylnwj1cl4He9dj33q9NTrQGW/RqTAHFNJ0HlpNE501yPW1O4IYrw8I7iopLkoEnRp+LOorveRaoE7sFIR0A6CLICzjXyzhhqEigxTGtIGTn28EP5lfhjsfZj8PncI3Jm+XZAEJ4AhLZdHU=
Received: from CH5PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:1ed::26)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 08:46:44 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::38) by CH5PR02CA0021.outlook.office365.com
 (2603:10b6:610:1ed::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 08:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 08:46:42 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:46:03 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:46:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 03:46:03 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 68M8jaFP3813357; Tue, 22 Sep 2026 03:46:00 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v7 6/7] arm: mach-k3: r5: common: Invoke boot of HSM M4 core
Date: Tue, 22 Sep 2026 14:15:35 +0530
Message-ID: <20260922084536.2477291-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922084536.2477291-1-b-padhi@ti.com>
References: <20260922084536.2477291-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|BY5PR10MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0a7a28-5a74-482c-52e9-08df188606c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|13003099007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1C2N2qLkGObvRtfvvuRxIzjb0xA999aGLXGi1BCFAfl9jkD+LIqz2OAPs02PyeBws1yuF/VdS9lEZDNS6l84FYvyhtVklyUbkYfgPecA6YivjfDjQWSklzbZzO9K1pacOH15wafeHspNwTatlZSA+BwJas9kjQY7LQIyyuufY143JP3vO6UzCoVH8aWlIKW+kGdNCUzS4Z1gYdmZK39RCcTy1XikTVV/ux08Sqk0RLkwFWMf3uNY0k2xO6TN7akY44+omdFUfeJureHX5/1Ow1HCpzUFhcWwOwU6+nZoTLfXiTAwNuIFKSzMtakwx57EjNp3YZn+QTMc65p9M0GkbroKsHMSU7SZ69zFPGZllUZwv7SsPzFusLeVncIW0agXvR8F7DNx/15Qqap9ohaZU6WWpLQOsdjQ9wAm7paO/KpH6f6mdaqokcwVTFbAkIQi7yr0diqqjewIhzfwGHE0QKppR/kXqjAArOtLOGGEoBbA+hPVa4SNCVfXA171OlZsKkjXyC1HbQ/+helfY8ZMXPIh4nmSNa+ZEj3MVL1Hq0za3mSHaGssYhT305fBoytU7P2nR3lIABg6oevXkTEeeIuSkg4G5x5RJ3Fc78fjSf/2AXrXSeoY8KLcFOWfHRn4Euzxdu3ohIBnQM4FLKLOnNy39JFB3/HXEw8OQ5eD+H8=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(13003099007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 82XVzJKRCAvlZaI+ZZP1r0bXmbx2o6Acz8lCENpeXvtQyPidJi8YhaDqZA+tl3WKKHR2NXcmltY8fIOlSvAB8pHyW412z/JPE6Srz4ru/NvRtnfTcPBm9SoPa95QNekbyS6+ZKgIOIJvd/ln8nMgAmw7L6+VXYnIcve0np/pHliUdYSMToVO8bnRsqZlzHpW5C1dSqgRWglxTEcKgCNE32Ea6wVwYyK6VfXT//K7EItjwBN+O6dLOrIS6/RlTbiX3hIXizzU/CVEacX6jt67kV7SjV4cdOA9v1Vt/30SvzLt4XN3EbziPC3OXjvkD/fOhea5QbhW7JHhqZ5f6rGh+nr3JDdt89kdnWx49RGMOt8CUyKgfaQ3Yj/lLjSzb6hjmsT4gpXYrWsP83za2RgiuDYktd4CvTkM5zM+ecg2e+w0sYdmkCfIbuzC8h3V1haQ
X-Exchange-RoutingPolicyChecked: krT6RcBdHgqEId5ThiT0ps9AQzix2PEuNUTszZ58bfiipGOmW8G6oRSw8uBMdi9/ykox5E6nR2+vau52h+TMLx/f5+y6fQupGtZuYyQCvqnv1OUMOZEKyF5N0k2EB31mCmXd0+9htEGyKlSHb5O1NKCwXmpz9KtNk1pM+eRnWcYMoLsl8vYg3f/Vc6nQzN66a0TX3v38Gsuu+CefyPM7WyE3HYAjzgleIzVA5Ltb0iQqWxRCXhK62xoqHvc/A0Es7FzTlFFf+lcw1pyByiEyrQclAt/fANRFGcROJliATENCFUWTtbt/KiEKX6qSRGbbbIeS+x2eFBkTym/OwkuF4Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:46:42.6997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0a7a28-5a74-482c-52e9-08df188606c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-ORIG-GUID: FkSE8xSeMIo8cPYXGDFcTLytLVJkr0kp
X-Proofpoint-GUID: FkSE8xSeMIo8cPYXGDFcTLytLVJkr0kp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNSBTYWx0ZWRfX2dZUZfpxK/BP
 FQHZMS6IEFNffzGa5FvDfB8pASvry/0bXb+pd/lD4JM1t0qiyKWrl0XnY9WYzwEYGrSsvsd7oRz
 aF/KrHG/27QulZfigAe5NZ1mphmmUeSL2Mg6UDpi4Ma+S0ta4hRL0tuun6XrY11StNmTDYInClq
 yn145Luf82dvk7pc+p42DPLwgmOE90Vf9K+J4VixDveKhKFEvlXW6NqdxV9RvT3MF6zCJpR+Fuj
 MjMz9XVIqm+F29d08Qpu/Wxi4K44WSd9rhvF3sziz1HTgU3wj3pmiZocctxO/aZqPScEIY26ZI3
 eQNjvQQYSr+BK5bVNB58c5eySqKO5GeHyvVK2xdlaZoFqLgLVYF4OYzYIpWPKStSstkaGvFho71
 Apc3SfB9KLEXOiR7A2eac7ELOXste5Dtz9htCgxvPtLKzEfAQ6ERaH1mSFrtIAYlkKPfaCGxRNz
 keuWpwgvXBVQtK1SBlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNSBTYWx0ZWRfX2lxCZD6p81Wt
 W4iM655jQwarehrIWPTvk/ltQQgqEgdAgmQj76kqehOPOt/xa71TqmP0mGUYysLDINEKke2oNkV
 VruOWfVoK8i95lLdunnEde8E+IbV8/U=
X-Authority-Analysis: v=2.4 cv=INeXmQvG c=1 sm=1 tr=0 ts=6ab24078 cx=c_pps
 a=48c6PaPq82/B1OY+thwv9A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=kd79XEjvzcn9TLE12NAA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220125
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

The tispl.bin fit image is packed with the HSM firmware image. Add
support to load and boot the HSM M4F core during R5 SPL stage using the
remoteprocessor framework.

Add IMAGE_ID_HSM enum and "hsm" OS type to detect HSM firmware in the
FIT image. Track the load address for all FIT images. Load HSM firmware
to remoteproc device 2 and start the core using the remoteprocessor
framework when CONFIG_REMOTEPROC_TI_K3_HSM_M4F is enabled.

Skip HSM firmware from R5 secure image authentication as TIFS will
authenticate it during the remoteproc load operation.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-7-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-8-b-padhi@ti.com/

v5: Changelog:
1. Optimize if-else ladder for logging.
2. Call ti_secure_image_post_process() only once for HSM image (during
rproc load).
3. Add R/B tag.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-12-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-11-b-padhi@ti.com/

v3: Changelog:
1. Use remoteproc framework to boot HSM core.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-8-b-padhi@ti.com/

v2: Changelog:
1. Hang system boot if HSM firmware failed to boot.
2. __maybe_unused to decrease preprocessor usage.
3. Better error messages with return code.
4. Added Error case in if-elseif-else ladder.

Note:
#define PROC_ID_HSM_M4F seems to have extra tab in the diff/patch.
But when patch gets applied in file, all of them have consistent
tabs.

Link to v1:
https://lore.kernel.org/all/18e01808-499d-4690-995a-45ac5fd727d9@ti.com

 arch/arm/mach-k3/r5/common.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 13736ca5dbc..aedde7bda3d 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -28,6 +28,7 @@ enum {
 	IMAGE_ID_TIFSSTUB_HS,
 	IMAGE_ID_TIFSSTUB_FS,
 	IMAGE_ID_TIFSSTUB_GP,
+	IMAGE_ID_HSM,
 	IMAGE_AMT,
 };
 
@@ -40,6 +41,7 @@ static const char *image_os_match[IMAGE_AMT] = {
 	"tifsstub-hs",
 	"tifsstub-fs",
 	"tifsstub-gp",
+	"hsm",
 };
 #endif
 
@@ -158,6 +160,23 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 				     &loadaddr);
 	}
 
+	/*
+	 * It is assumed that remoteproc device 2 is the corresponding
+	 * Cortex-M4F HSM core. Make sure DT reflects the same.
+	 */
+	if (IS_ENABLED(CONFIG_REMOTEPROC_TI_K3_HSM_M4F)) {
+		ret = rproc_load(2, fit_image_info[IMAGE_ID_HSM].load,
+				 fit_image_info[IMAGE_ID_HSM].image_len);
+		if (ret)
+			panic("Error while loading HSM firmware, ret = %d\n", ret);
+
+		ret = rproc_start(2);
+		if (ret)
+			panic("Error while starting HSM core\n");
+
+		printf("Successfully loaded and started HSM core\n");
+	}
+
 	/*
 	 * It is assumed that remoteproc device 1 is the corresponding
 	 * Cortex-A core which runs ATF. Make sure DT reflects the same.
@@ -330,17 +349,19 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	int len;
 	int i;
 	const char *os;
-	u32 addr;
+	u32 addr, load_addr;
 
 	os = fdt_getprop(fit, node, "os", &len);
 	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
+	load_addr = fdt_getprop_u32_default_node(fit, node, 0, "load", 0);
 
-	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
-	      addr, *p_size, os);
+	debug("%s: processing image: addr=%x, load=%x, size=%d, os=%s\n", __func__,
+	      addr, load_addr, *p_size, os);
 
 	for (i = 0; i < IMAGE_AMT; i++) {
 		if (!strcmp(os, image_os_match[i])) {
 			fit_image_info[i].image_start = addr;
+			fit_image_info[i].load = load_addr;
 			fit_image_info[i].image_len = *p_size;
 			debug("%s: matched image for ID %d\n", __func__, i);
 			break;
@@ -356,7 +377,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	 * Only DM and the DTBs are being authenticated here,
 	 * rest will be authenticated when A72 cluster is up
 	 */
-	if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE)) {
+	if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE) && (i != IMAGE_ID_HSM)) {
 		ti_secure_image_check_binary(p_image, p_size);
 		ti_secure_image_post_process(p_image, p_size);
 	} else {
-- 
2.34.1

