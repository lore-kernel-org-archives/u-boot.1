Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3D606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uqD0tCqB;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N+bb47zG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02B666075D;
	Tue, 20 Oct 2026 14:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e-o5fBt6Qg-J; Tue, 20 Oct 2026 14:10:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 568FB6082D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505420;
	b=q/Lw4Ma43tmfry5qK1nQ2pUoI0ZvljvuhuViRnlSw9dUExl4Xa1ss8B/EF+uqCNGyFXw
	 Tjv/MSV7MFAGXkquDKRLPmzgtXGaI4bTPtyPyC/9iMXmYLvqawOH51RCC6IXCTADjBZ1G
	 eCUKx5Pb/6plmmj7U8SOrFNM7shA1neOoWqhVD9t2Z+EaKggjMJGyDw3TicdecNEk+xel
	 mPsxAmpebzXfylcXbAqRo7ZYSLTcbZzuhUFVR+qu94pNynH6fSqz6bwN17E6guP2FmoPt
	 TFZUjerweBBKeS4TCX8iVmHjvdlomoxOQwQdDuvuvnCSbr/qqL1B9YaYdF6CvUKr6tA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
	bh=hd/jXs7k2IqKMS1M5Dx1AC807m+YbQRb1sQfmgHylas=;
	b=ZZ5sEcYXSRw5+kA85O6HSi8rn+ITccP1/NCS60NQpw01xECSn3kYOVORuSw9LkZ13sn7
	 cp9tDfLycmzMI75tWCcSRIYFO1xQEtCBgdZTTNZPoV5A5HCd1hhAf2RQT9j7gS/sZV7XW
	 9EjzTlaP2fvtY25EZbTMFvYAv0eWT1ngbOHPK5yxV4ai3ZEG1m5luSr1kSh71bX/h4kpw
	 grqqmwsAQ9Anzx1xlOrCiRqronhXbs+G+hSP8agJ9p3ibBS/Kn+IF877xaAx9Tmuw5xy3
	 pNchzJWbAFgeRAd/uplFUsulOXN8UhUjwrDKWNGeoxuCJxbZ+KJTtVPyGvKy/5SGilA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N+bb47zG;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505420;
	bh=hd/jXs7k2IqKMS1M5Dx1AC807m+YbQRb1sQfmgHylas=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uqD0tCqBD93Y/rAc/pidqMvofQMy2AmjZlg0Ql8yyL2iJ2Yd6Uog3SXRa3UrelpH7
	 tbLMl1LmbLxA1n7AXiNjzIDRIv+7cPFoQNV3k6oZfNqSSVuPzwXY8RhCqRtgE5WJRL
	 9+e1MtYsolBrDPVqYVotqSZOT2vDQIf6gL8P4qo7lEOFDFd1elyX+EvUGWSh1B+UkM
	 0MM4t1i43R4Bgpq6eKSTFWY77wvJ/FRnA733Zi0qUGtpOIw9U556Te5EJcHGy9ucfz
	 n4Tv+zrQr7CdluLGKOTT0hF7Xxzb6DGjvYhzThCXrfZg7W+yKWO9CsYSp+5uRNuE6L
	 6VoK0V/yt4RGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 568FB6082D;
	Tue, 20 Oct 2026 14:10:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 073861AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECFF36075D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZEtKGhBYPssG for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1718C6082D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505418;
 b=m4CyAHqJ2COQo4v/VUbvj+1AJ8+hba7M5Xd01dbn7PcdsHQKHCWMjE79ka9oBNtZpzAl
 NWnbDrwTHAhbajyXDuY6AJRq3f840bkaDzebb5dHRkFNxgz3ClqQkp65axylz5lyjVbOO
 5+SHxWdy5rZ3k25WSUQmLp8OuFfTK6XY98JQDSGd+A5zPxMw1vdmHhHGpOhpEKzriMexG
 +HCm2CqgZIytfptReiG0NWyX5BsmZqORib2mvG23SNfcEnzaMrtdNr/yUJ6qLWWL26wjl
 QQvWfQkD0D453c2g+8g6gFLxgtFjXa7CdpQ879hoFp+TWq5zFT1qhJFErqw64DgG+Tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505418;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=hd/jXs7k2IqKMS1M5Dx1AC807m+YbQRb1sQfmgHylas=;
 b=B3MK11voQ0pSJAQHD1Hka8QTgQ/NHcqMqCVZnKXlHrXYKy/urkL3tBp0v7R1lXrNJttp
 rZTSnUMpY2Ptp9Y25ZBlAS4XbFny5bOxNpbgOtcNHIpmejULW+eMYtlLW24oMUjBbV2ZW
 EvAy+35hKaNa9GD4unqTyxbKSx+x1dVqUMIxr9JPMKSVHX++F2qYWZyVgZMbOtkGhw5o8
 xR1c8hNynv7KfhD88HqiwO4QkBHWhn2aMe/ESFZcxlZwyRIUKbkwCshCACMhyzY9KV2Wl
 HrJv22o5pEp0aCkYl03939XWX/MVhzYDHuSFceQ6+def7UdaNrjV1RvWWNcY0fiV5ZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=N+bb47zG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=N+bb47zG
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1718C6082D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVwhnTIuK7UZocf7vTKCgxXDMn2aj5yIHJ5ykEVtZD7VRCRqavcY04yZYkEGvdJbhD8BpoWnQonNoxcJAZ7QlLjtbensyRXQw+H/UjHtMC4azTr5Ofb1VQjWwhO3zKcINs4VSLoqu/XTn9cR56ZXPJ5a6UPOOgnIjltEIwBx0MKSZ3YbYqGj0c6Ki7MAzbmH/mRb5rVjRpNtGEiBoGKYapC3mleZh2e0Mon4UV3kF9Yh7wJg/D7pDI6lmONWzqsSDgy+ocBpwblAdDYC74FwxkNn7AH6FLH2iZ1pvF3s77k1Ne3eOqLA0caA4pQhHnJLnJSUSRgBbuurkTE7BxV1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd/jXs7k2IqKMS1M5Dx1AC807m+YbQRb1sQfmgHylas=;
 b=VeR+lAJy1pMDelueIitf5hyo6XAnJJvyN+Zr0nTAOFb/Dvd0/0ZN7VUwLIEdKw39aDWJ0pZlocxr5qI+IhyUUdEHcesiOujqK/qmJlF/cAyuk0CqxAY4HwMfmLTP9IpXIY65czZkiQ1xLUi+jdixXxbVJBlAaiAui+MWvo2XBx62itmJ3ymA8M9EiVPIMnQfJOIxPlp5R3OJG08X5x6+UeYNHg8uNXj9Z4DGSyNnkDvi5WhTY8fopst2/Uf9Smj/hgovNzj4uSIBqfUvr43CTllI2n7jr+8vJbXcfOIuwvOnKtMyDiL4/ol16ve7MvojgeGDCNyldRsFg16BNS49yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd/jXs7k2IqKMS1M5Dx1AC807m+YbQRb1sQfmgHylas=;
 b=N+bb47zGuf2UXZyMTR8ZuxQMmfW8OmQaWxUu/1nSracusrJSaFrpkOjW2cdU6d/fqISLA3tncE7rTytVgPRzAqsDu7dihSUloBGZ3eq/6Na5DRlbcx4QvdvOogvArtlpiiH7qWNbYQJ6rjag8NMSeIec75MQUIwX19Il7138900=
Received: from DS7PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:3bb::14)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:10:11 +0000
Received: from DS1PEPF00053452.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::58) by DS7PR03CA0069.outlook.office365.com
 (2603:10b6:5:3bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 14:10:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00053452.mail.protection.outlook.com (10.167.23.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:10:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:07 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:10:06 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/11] xilinx: mbv: Add support for using bigger boot images
 via bootm
Date: Tue, 20 Oct 2026 16:09:29 +0200
Message-ID: <c3df816738a711e5643bd023806b7187a6bb8edf.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+NXG5gAdIZKxV7xgp1DLh5FL1KeBkhXbWfGdTq+1fgY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5MrLUnMrLYP3PTnrLLhrd3/zN7t+cHkL58/5+epj
 oROz+SzHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRm52MDFt3RK/jUNz6Ytkv
 5f5nnSe7C9bJBd/P/3SOf92bdxLbBTcw/M+ozHGZKZ4pv3i7fxGj2HkVnp23f/xPLX7Ucox7+g2
 l++wA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053452:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: e32227ab-4e4f-4197-658e-08df2eb3da5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: XuUoz7BpIctGuyq1Caaeflwp+3oL3PbF3EOkTIb7W1OYN/g33nltyvY/T1ZvRS6vOkSEg/SixBJ2SFW4HiJGMcuqKYQoWVYQc+57dJhrZROrkn9oV2XHYZ3buHbnYOajYi+2hkrdR3eY10j7ocdcOemdnA+bR0R2DXvj3Ti5e5MNOIg4AEfL9S4eXO3EtFkL4exVQEHGou1nQnCPQyf1rYrQkB9h94I3t/tHxVspusmLIVdT+71orVx9KeU1AtchReAKG6yWSOnxGBuWML7qpxJgXu328oC/GCqert6kT09De8EQ037rTDkOXBvwfWxhlQFTt39tPz/Xs87t+4ikl42sE6olEx5vg62qXYV4stVA5t34nLsFEJvw7AtWUCsIpNqT00RpjOBV5tR3iybOH2/iE0MstZqpHMPCP1Q4ebNSIDqkL39yRN6ja3665O/RgQZQYdPXFHpTZ1BtDHctcR5cli+lqLbJvN23DSr7/wAtwELknJSNtKeLi4lVwQYYq9cpZEMTo4xWjED1ohPUPD27SXYRrwidZvGVzDRlhapLM+wU2p9vTDq3biu3srUwOQMoA6bAaBXDcenw4I8hwYKSbjEqV2/j5TDRL3fd+385nRVjq+LdiJMoV/XC8I0maxcE+KtMZqaNGKqbdWKT6xAQ3JjYiPlt15h7lvYW30Tzxr3uVX/6qWiJ4F70H2XOM3DSV9+SNx4z4CKbieaiOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: alEJt+SPl7+SxuGaXmY+uJN7ljkUMDd8W77KJ9s1R9NEPngnIkEr/weMpz+kEtLtTd/7kZs53gqiFYxcYEeBw1ialzAELqIUhgPP2jUMV0rElNADhUwuAbnpwQfNYwmo7dJSx+bHVrvIKi8McCAiw9UKFGj4XVnQNqCgtWZIIVoCUh8ZoHceQeE8/E7hzvi6fJ9mcX9UL7fiFVr28Gn4iqe3NZdeY6d0TFI6Wgqhhqs1AT1zbbOeOP78CZy9/Uh2Bh2I2BY1igXH8y+1NKCWxMcCkJrKcTq2qhUms3/0LgesvMX+5aLAWQb5am/PwupxDzXXafwPzQ4pV601KKE2vcqL/I08SEz7/HOWp8AMTxl4W1jT6RG6x2U6vNYcZ15JjwPjve8slO0m0xFnm1cQODm/SXoAVqWuURNhWH2TNaR9B5ISRX3KNoicwY9m1Bgx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:10:10.7152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32227ab-4e4f-4197-658e-08df2eb3da5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053452.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Current limit is 8MB which is quite low that's why increase it to 128MB
(default value) which should be more then enough for the kernel with cpio.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index d75d7e2e8ed4..258b65ceaa68 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -13,7 +13,6 @@ CONFIG_SPL_STACK=0x8F000000
 CONFIG_SPL_TEXT_BASE=0x0
 CONFIG_SPL_BSS_START_ADDR=0xf000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
-CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
-- 
2.43.0

