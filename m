Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508C606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eMVt2Oeu;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vDNsB9qC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D996160730;
	Tue, 20 Oct 2026 13:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kD4KlgwMSGCG; Tue, 20 Oct 2026 13:49:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2908D60833
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504184;
	b=j2UAlwKAEPv8rgQHOdJw7VpbjPlFbPgsux8miViwPTLgdwCc2ekFfWpyiBL+o3EXxcDo
	 35/ggDsxKdUJSaIdWS1VInF6F5HOmAUJ4oEOsEQdEd7o+w6rs+Qaky+pprKrLZ0Mwe++p
	 IVgeU1S3wsGad0Gi/PmIDkXLbnh/Y39kC7zKKxkXEL0SKyLuhfZbNo0l1VTWw6xr2XEmd
	 yTq254K8OklY20FiFNdk5bth+/j+j+k9CJC5ERHSqeOpcrPYIB0YI7Oji53KagjCIJVlS
	 v/9dKa+SSmG9Ve+18m81RawUNsjLb0TOk+yMBxVrs7bgN4d2GxNP16hHEh3LRjVn2eA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=GvsdZ4d86HgvHPYPmD9OUgVQfcXSYF0V5TadtbxTgSI=;
	b=ALhMDKxbk1I4XOJ8jlIHvq/aZXIbst4CdcZ60y9Nei3aAGnPGHb4DMv53V5Vtirw8X9n
	 +oM95wIr7ArIrvxyagMzoYQGxLC3x16z3PyQFoMUi8u6IgqRKc46PcAPWtA9Jpg1SWCqh
	 aHmUIbZyBjlAdOAyQbxmA/c5aGXypUXmCXH7qf3GgGo2t3KN7Tm5R/deOBbhi5xDx010u
	 RAjmYWzxD0yfFZ8coQncP69Q/1oYkZszDt2ypTOl3Ab5km9WGX8Ae4ZDxeJuTRw/fcZ35
	 d8LCQLH5xEqs7Xn4/dBaZjyHQwtZQK79mMo5SRWZyTW3urtpYSl9dmkxX+/kQYeUzXA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vDNsB9qC;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504184;
	bh=GvsdZ4d86HgvHPYPmD9OUgVQfcXSYF0V5TadtbxTgSI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eMVt2OeuVDp/OJlGffAyFNkYeU8TFiwSRKiy3ZnacUmQGZMbWRw6RLhHgTTl8CanG
	 DGbmp01+zSpMoM1qOXuAh5oOdR8oLInpQCrXWcCdA7unJznJKbH9HzxI3lGsTYnHt9
	 gpbBARQfpu1T2J1vSPz3aFgdRHmmD7AGTG+E8XnbO0vhaclBgXK4GdpW77NIyIJicz
	 6ZpYNc5LkRmMcWesOzS0VA6xLfIwZ6yMz5aDTbqk9M9ooxD5aN+4oC6KzhM3dzoC4q
	 Ewy0gdxxIgJELb7W/2DQRnInfwOLddgGM6AMsKUztXIjQIcBCeRYRu5E3NO61zS28r
	 fhVddBkY1qJNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2908D60833;
	Tue, 20 Oct 2026 13:49:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3739C255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D6466076C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8O3qXyyonXCa for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:49:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2DCA60897
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504180;
 b=SFL8aiPaul3qhITAd6hqwkCQ7wx6m+armhuVxqJqwV4vbaUt1xmEOFW7xpqQXCmRaQCu
 wBLQjJkLc8T2x6HZUHCr1rYdQ3eoM1RDv499vYvXAfK02OVrGUFCs+LbpNDqZP6uKGcki
 lIBDTgQuIorM3wFpa2qdAGLmcumTEUJm61kvj7/qmxEAK7fY+egozIRanwNNdbW0dDFKk
 aLrtq7MYPYuqPcOW6x3xM5OYkDjEyqaWJMO3UBTKReIUdR8I9XqWkOLqGgbcBTef42wDW
 UPSGIe84LejVp+FeAasNdU4bfqKg2b9ga4Crf57EiOvp7eso/WAkGRQMoGtV2+3Zrwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504180;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
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
 bh=GvsdZ4d86HgvHPYPmD9OUgVQfcXSYF0V5TadtbxTgSI=;
 b=bKrGWaNASoTmnLm7O7+A6tXcVUi1BDJpeldqqnwf5fx8uPnF/EZ4qigZ/JyCorIrzvO+
 QQowG/fbFxHxB+iOK7uKUoKeTpOGCwvYZlYP2hjUBY7hW1SfUAisvzKzFcaWQtahwE1iY
 n8Q3m5bG8r27fuBTf6dQxf98AAjP28Iuen8XOj3FTTygP4nOnC7uyuqI/s/Dtx4PYbIBa
 tn+rnQU9+tcBn7OEsJgvYA/F7wy87eJOifNi/v8vWCOXUr395jGbKqwx0OCsFKf0NdvMY
 iPx71dp/vkx4xgvJabIW+mvOtoZV1Tjv6L5HxqTIxYpXCcn96b1akBSafseJb6n3hWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vDNsB9qC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vDNsB9qC
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2DCA60897
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKT/vjwqD1R9lgq+ZXunXpsjmLuv9PtltmiQuy2qGE96C+g4h15I7jOvATHLa9+g83GZ1+lUSl3b/Iq01p4bXAS5vL+RSCw8/61hqCSYNsZav5yKSQr5HYD0nJTd8qcEQ2HV0/1bKoKR2bauN6cVRgKJ2+gXyw3SkLY5hYor5SLZd/kH+YGlpkH0QbW3GMd+SJeY3GvH1hOt4sBtbATn40Q79+qA4ve9aOxs36uhc4mbdFZBJsUjp/UpdRQVcNNz4gAiA+7Q3ZTh8y85mquIEQcFIkyeY+GDXtiSfyUxNctkKykJyVXe5AFYB9EaiHVjpcoMZOlHg5Mq6UZYiLeXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvsdZ4d86HgvHPYPmD9OUgVQfcXSYF0V5TadtbxTgSI=;
 b=oz5r0qq8f9YnsP+zvq6TpaWW6RPv0yBaxR+sMM/xT1raI7L01H4NiN/F/KoC1hNy3v65y4n8EO75E3jeXg13+QKRCbdCfj/RrFZCtNCyraAKzVhSbD5Vj1TLCx3QaSVex9gTsuNxenF87mQ/R7KjRClZdhhkNf6FCJoA7V1bh5JmfH4pppMRvA6+l65/t53b+5EVlar4XBDoYWzBrOr14fZKsOfdK7qe4k+UkqrcT328Hq2RbtRp+L/5XAyTQ60Q986NUkm4AuzOcpLHc0vTYWRzlTcZec1TpaHdd+8j4bP+aEo8QtHcIBdLMxcLCoJ3Bq4yEWoNWaFlsM0El+vKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvsdZ4d86HgvHPYPmD9OUgVQfcXSYF0V5TadtbxTgSI=;
 b=vDNsB9qC10ef0m8PVogRLMtX+RRYEY17d4nWJLFBOsUBvMLY32WuGzuakk8Tz55Mk7audge60K3Rx0n1GXF0hDbkRo48LLRhPIjQ+UYgsCqzPyn/RAlXzaNIYmSviwEbaqyFlKXzvTWZu8e8cw590an6h0nhHRLEb3md+ESTluA=
Received: from SJ0PR13CA0194.namprd13.prod.outlook.com (2603:10b6:a03:2c3::19)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:49:33 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::42) by SJ0PR13CA0194.outlook.office365.com
 (2603:10b6:a03:2c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 13:49:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:49:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:49:31 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:49:31 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Suraj Kakade <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] fpga: zynqpl: stop header scan once a full header can't
 fit
Date: Tue, 20 Oct 2026 15:49:07 +0200
Message-ID: <c5a62cccb6212fa870c46c08232358f4712c954d.1792504143.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504143.git.michal.simek@amd.com>
References: <cover.1792504143.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=5pmJpYx677EghBP96rU6cQUR3TB/7JuW0nXivhRuJqo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL4yyWtOcFJbp4z2zJ9WTvWvXvtiH29ddrF4st+ndx
 xUZZTI7O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAismsY/plW91k/LDghcpBl
 Y+ce/U/rMzgnmc///khUWskjeJkR63tGhtmvd/J5NNxnDZx+ruhPzMGVq+9ckDdMfiTbaj7rx4U
 JX5gB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae19cad-ffde-4e85-f1ff-08df2eb0f882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: UXLfOa4h+yJ1IPcZE2Urc2ecmUgrrT83WKijPx9Qwqeunw218vymjQxbJRHjWzWf5tyPQeuLsX1ou1NgwHNE7U9JwjTs1na5Szt5r7Yq8nIJfos9BFBgmbwfkhfw57TNNp2M7EBOV49oO3vUd7OFug3RRelMQSPUMOzCHysEaoSVjh9fmotvXJdtM/1Q0po3f9rU7Y8stwQn6MbDWygdJss9xU6tqoWS+hmPfYEF5035gqYxFa+xOl0q3vDVb9OM6IJu2b+J5gCVlTFQP9veFn2HOrMpgncA7zqcXVlAXCSgZ/lYeA36zQOvk6X9xd5lrHQXiQUyWdvptJOkmE9hfzpKJEO7KxNqmNf76HD+Qs7IL71napiNKFNP+K/VO8XKwBftBsIzlhy6RN+SykEGEZved3TGvdU0l62ECKz1viel6s9B8E6OtI/vsiFdetXj/ZSQmA/uyLcdmrTFXtq5Z4lE1gvRnBrbTDMAJk43I3aBSacJLtpvhmUjo0tbkpn8FpxSDITypDDgi9k4EngEkF8z0GutsjsQ1ZMbMlhH6BrjvsWeP0QeX7/kzu/7E3z9eGXlPGJEUamOzGDgEZ/wfSCOT0dVcyjNQmaj6XEGVBTgMh0eGXKbrzMx6LhWsvt7kuBYmI20RrhQelxNiWPx9FV9qkjmIUMldhjpGKltMkyl0P+Sba1/n7OQ/yShG57E7s0HFxxsdFwroVQeYKq9gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kG/9mzcU+clRj9BZAij3Fygs6KlebBB0wpG1yOvxD2yUVLKoAsDRhW3tfjL2cBBhuw8qntHLKbhFslEUpLY26MB/tG4/t4ukHoF2NVvgtkAefj4ZaSW1bNZwF3s981MUXXrw5XCIr/O4NLg1ksMp4Sk82tczuHCUhf3qsXwNRuwAyXWjaLa66XvUPMI33DHKJ12AbCTTOOxK2YyrMMaIdUAvALhvSw1PLrhBtrGlTePHwADZ+foY8lNTFTccT5ZlR0zQuX44RqtesI47t5bTRSNE1xsfV1rSQicVhhj3MtSgOaWB6Rr/GZxXx70qcMiyoJ9rc8z5tyUjjaPuuFw9Gh3D7RzgYSQzaOAND7V8X8ij8l4BREZe/SwmKu4I44PzJZ79B4rWySs4Zif7ny0/5dILtpjdbVAWAYmepbO/F/FLpPZIx/QBECZ2VWekNZSG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:49:32.7315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae19cad-ffde-4e85-f1ff-08df2eb0f882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
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

From: Suraj Kakade <suraj.hanumantkakade@amd.com>

The bitstream header scan didn't check whether enough bytes were
left in the buffer before testing for a match. Near the end of the
buffer this let it examine positions that could never hold a
complete header, and a match there caused the subsequent header
read to go past the end of the buffer.

Stop the scan once there isn't enough room left for a full header.
This only bounds the scan, a buffer just big enough to match the
header but with no data behind it would still pass, no minimum
bitstream size is enforced here.

Fixes: d5dae85f23c7 ("fpga: zynq: Add support for loading bitstream")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/fpga/zynqpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
index e8046995d7ca..8c4bdb5ccf66 100644
--- a/drivers/fpga/zynqpl.c
+++ b/drivers/fpga/zynqpl.c
@@ -135,7 +135,7 @@ static void *check_data(u8 *buf, size_t bsize, u32 *swap)
 	u32 word, p = 0; /* possition */
 
 	/* Because buf doesn't need to be aligned let's read it by chars */
-	for (p = 0; p < bsize; p++) {
+	for (p = 0; p + sizeof(bin_format) <= bsize; p++) {
 		word = load_word(&buf[p], SWAP_NO);
 		debug("%s: word %x %x/%x\n", __func__, word, p, (u32)&buf[p]);
 
-- 
2.43.0

