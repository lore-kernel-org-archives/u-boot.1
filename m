Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23CE606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R4D0F36v;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SJjAy+H7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E91960826;
	Tue, 20 Oct 2026 13:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BH1xb7hluBYQ; Tue, 20 Oct 2026 13:46:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E09186082D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792503999;
	b=KWv3bI/qqN2WAyX7eIvwM6kpTGAWxlOjovUppsYDZ3NQRlxAaB9wt8NEYwg0zC9SbEcX
	 +qvgmnU0W6ZK2kc2PHNshSi+O5BDxmkABTIPqf527GAxU/7r9NgaQBqF5HbLCeo5Y61IJ
	 1/WG8+Fv1yIJFoiLWY0wis2stNhvdL27iuDpexX0kgzsbLTOQBDC9q4+CQ7RjjsyAirYz
	 s3OJh/1O14BeWszK1JgWWlx7hVHwfapHIy3V//4X9u2kEvFuHUct3MdyWBRlz6eKmdB/y
	 fJZ7rzkrW4D5xulTjMz7CHX62UvWX9pPWp3Ez5gVKip4itrN66Bpt2B12CXSIY5kp5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6SXUBjLSElod96YXGEQHzXGXT6qKKpKVv34gTn4FIsg=;
	b=Cr8p3NJWoWlDPD8DogLelfWiyYUWMmMK0kIWjugWTIBA8t7TdO7iuMDjZwCB0t4tSxUS
	 XlzcBIB6Xvk3v1l/vmh25ss0t6kn6yhxlwq5O+NVso3QpYC6IcOz29ycet8+OKZ6zf9no
	 zSKRdYFd03wbnX897RFA9+ZNiIO7Vnd9KhNDedG0uTmTQZ26B/KmauqzaKlFP9qLF2rtR
	 ofojUoP7NekMWtdtfTimQLhG0zfR3/UJzmf0ofmlml6RKKINwP8GtRj7AQ44GmiH3Joon
	 l00K7n+3N/gQFHfVni78MdCp9CV33YOxTMVsrPfJrvbDWNFxrMnf4S4o0ay4ob5yS9A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792503999;
	bh=6SXUBjLSElod96YXGEQHzXGXT6qKKpKVv34gTn4FIsg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R4D0F36vvzvxZ1ddH2V4CJn0u3m8N0h07GsRHTwodD95rVyDxJXCU8+jNfr6mZajm
	 gH/1rAeJRY9M7MYsc2tEBmbd1L4XIeu6VvfYOTKdEkCxaZzAMsDtpwwK0izHXSV7vR
	 jV5V6LysjbMXT9G8PcNYiIN6OyoGQewuEDK4WNgkD4GYshYJfVDfjmHVQ+BTHjQQ4K
	 fLuVgBcjCR7QlgctfbaL1SYaEK8XeRptVqc3pzWq4ICoCLpwM50w6y3a0AhH3iOAXw
	 6zgJged0+vLkoRrIvRBsqHq2+0VLa50DjRnUueh9BhzGQe9q4/jB4hj39/+MAQ0r+F
	 qMHh5i9GnbXrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E09186082D;
	Tue, 20 Oct 2026 13:46:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A7ADB1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9948D80F3E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9xD6rM9IyVH for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:46:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6A7480C6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792503997;
 b=Np499VgKBIzTFrSah6SY8K2zRvnHoyUMnA+0zOSblBnocOBlKjjaAWUmTtjCR6ytBEuX
 zP925UXwcRoGkBHKeRzZUPEmSL8s88bhlt0WTXGtAYbLjO0r4j4WfdwK6eAfyBSgfJynv
 uqVD0MRFUxPZtKhHVVg4cHDPbOrZ4G5SJ/P7jDMhswkjebg1QmW7mmudC+O7kUMqhBN8S
 jv4QAhFrVBR02ttEzd2QOFte+8xliZJEni5FtVlvL/ygVnbjePWCJwikYnH1hyZw9hwwR
 JtXBx7eVnEp6W0peCtsDDJoe5Qlmz/UC7ZMCj9sGKFo0lsLiRshxb0L1tkm+g4sqUNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792503997;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-Developer-Signature:X-Developer-Key:
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
 bh=6SXUBjLSElod96YXGEQHzXGXT6qKKpKVv34gTn4FIsg=;
 b=EZOGdEm1SU/1jSBiErcrz5LDVd2yGj57mUDG8SzMVjnA4qQeGfuXVz5s5HDFHiUCAJhE
 AfMX9n2AKxPp7ax50Ka+na3zzohNMaurT/czMu74To0A+f2QaSi0YVIu3dpeMG2WHqAj2
 fFAbjFG0RQbDH0N4XGKPDIcPhOs6Y4LdI67PVj4ODE0RurFalcO2C7aizhsXhR22vooNm
 yYkSDdIrMPCth2gyQ+X87+OT2p3Lg2eHJUqPlTB/1hCCRG/o0O6UMuhCjR4tusDfwlg7b
 l9R4BJMcgLxXASSvgomWv8yLG4t7KdIKmaxppvHs+uhR6+1V9jZbqIDBeIHDHr+QlUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SJjAy+H7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SJjAy+H7
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6A7480C6A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP/l4pWP8rbyq76/DDGWIOciv+7yPCQp2cUVotlPgB2jJSbeamPO5hNUe3h8MwpZDK83SDuavaC2A3bnQxrv+JyVQJ3rqE/2wJwqJIH6WTUbB+9btmW9ckzKws6XnasCKsVDgaSHW/Uht7xRGI8C4JLz1zOm6qcyZxvjFvehR50iwssD0TdKjL/5I36SHajBvI5JIO4VkZDH24vb/5zAUqv3vPN8OGUB0AtdrQ08T1r5Iu30UAwpUn7/FoB3YVAHIyaRpxj6QfjZsyoq4XuAilP/dTzzDuUXTpDnaS5YZ0zJeM/18aZLAce5Qa4dYBiYvq5wY9pgDPGl+Swxp5atiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SXUBjLSElod96YXGEQHzXGXT6qKKpKVv34gTn4FIsg=;
 b=c2xApAvVeUnrRS5wTRnmODwafPw+cmA8ckKueEA2q/rluOR1Cdk+t2+VWfuKoAQuLePrJXrscy9cnb8Gt0D4E8+ZZ8BoXjOUS+wpi3Ji5GX1cArWwSCFsGS93C8GkEN+bEzoPNnoXj0HKh3qRHBkT5DYOvzu+xbKebpSij/ITnP4iyeQY4F5wHP7mAJ2c/QCTjkYc3u4KWh4ZZPirf2ars+SuoBHlmNmni9IFNFrRXwF8XL2NF42CS0D+Rg1bzotPmNHooB+4uA1mWTcltx/jnsUXUjQCiMZOVtHoKJ9GMyASwjQiaMPb/fU3CV9TTCv+knnS/uhkNK+BK+fMnI+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SXUBjLSElod96YXGEQHzXGXT6qKKpKVv34gTn4FIsg=;
 b=SJjAy+H7Bm70x2EyttsCdYVL1tkG6xC1cAL0GONYExmW6ckpjufUiNqqf15H194pkImJ9tTjNGT3bpexUXizF8ejh2BCuAFM8UmY0N8knW/ai1NeHzIHefATyiSbPPSwbFNl8HY1jIP4gc+Jy/2BOC2sAemqOrUJHCe8s0u4RpM=
Received: from BL1PR13CA0218.namprd13.prod.outlook.com (2603:10b6:208:2bf::13)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 13:46:26 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::7a) by BL1PR13CA0218.outlook.office365.com
 (2603:10b6:208:2bf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Tue,
 20 Oct 2026 13:46:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:46:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:46:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:46:24 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:46:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Suraj Kakade <suraj.hanumantkakade@amd.com>, Siva Durga Prasad Paladugu
 <siva.durga.prasad.paladugu@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] fpga: zynqmppl: fix pointer arithmetic in
 zynqmp_align_dma_buffer()
Date: Tue, 20 Oct 2026 15:46:18 +0200
Message-ID: <f1a657871243e50a068872f4fadfbc9a5820600b.1792503977.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MEYF8vtg8ePcvAW4U7xr4qwjQvwu13KrycYiAQ+wb3o=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL1jLx58yL9366+/zvl+DrmywmS3Tfos33e+F7mr7F
 /f/fvef2lHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATebCT4Z/NnXqLE9dLOL1+
 VWde461ilruXbdjs2cX5a+17Fo0PbncZGY4svtz/1qYuSGjqElnW6JqP8fJzbjszbvn5dJm5sEH
 fQwYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 858bf959-0190-4b64-2280-08df2eb08903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|10067099003|260925022911599003|261009223027099003|11063799006|260925021911599003|56012099006|260925021311599003;
X-Microsoft-Antispam-Message-Info: u2qil8TRG8xSGdyEFra8qPwJst9hBDnc+fcou6WRcWI9OPYKW43btx2llal6WT+qs9M8dfZWwvhozzqzR9gt09mdMN1CePUUKXTbmcvS7aIPpvLW5i/dVNQdVNo+lCQnuXbwbB2RLsrqJ9dvYsMZpSGKuukN5wyVMDsx9yfJIDkOuyaAwZCTInPOuK43cd7gbY42it+tCdBosPn1yOb0MtfOdZUQylbOMfiBaQgLK8V62IUqG/d5P5QFgsCU5hAo6Ery/WBeWXukqvf9xgoxuqbxCu01FT5w38cA+NyQ3STDn0Dp+kKbcXcepYfyilxeiv+lGLgaOKFzhOQMRPby/vb92mHCHu7QxFKJTAypmW8Saw4kKfo6HaKZt8WDZB6ukk3VJ+DqT3dxmdv6cHEJYDMvpCyymOBIt9sulpBOUonq+8mI2I2aAZfKg8BAvAF88HXYmGBj6GtvyuL/2JnicRBXvnqP5LDWeXXCq7i6WTO009HW5P5TWTwTWUY939BGogkS+ytafyj4pEEalVz6ykKCpk5qUvo5R3Hue4g/9SGJtb0eHWNBsuvSUsABQ1kEIDreVt0EX8RZiGSrziwz16kESgo+Z1J4xSXyvh9zcf6UFCuYvMDIOEe5oCuRTAW7VQi4UfTzXqj5f5RltjPKVxAqtHzN1OaPfkyY4ETRnfo2IShiUHrBJ8Q7KvwGbvsygo9MwUofC7PPPYgBj5Lmqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(10067099003)(260925022911599003)(261009223027099003)(11063799006)(260925021911599003)(56012099006)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LjswI0frNPCx6xK/wTwX3prRr+P0ph9DL3aQfVYion8OLVl11cxYhgEguUpGfQALyNuZ5NnfQ2aCvxXLXTavlzlk3urXFe+LaZjRKr5Nfjyk4hfAzN8ZjoF5OFqcbF32f4+JVaOeBAWb8jQszE7kSMHb933G7Pyli83Jl701yUez8qXidaVsKxlcy8MpDwujZQAW7PQw6T/KsczKkjwYV6E2R26dqXa/npjP+VOQS4JVnxaVPYbzwwF666O4osZax4cTUrLEz3S9N3e6vG7dhkTIpGh8pFdvAIGxKiN2IVnkYqNrMfWyr5gV7T1rFXAMOdHnxQbTgdjcRI4DnZUi4zk2p2NWsnulQdNxtcbD/pC6+0LiKKZu11ZaNDGSbxrQGz5kMCYSSIg87vA9fshOGGxL5YaWZcTsVO1m05+XVD4aTaEocpNSrFga4TsKbVBE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:46:25.7272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 858bf959-0190-4b64-2280-08df2eb08903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

zynqmp_align_dma_buffer() steps an unaligned bitstream pointer
back by ARCH_DMA_MINALIGN before copying into the aligned
destination. Because new_buf is a u32 *, "new_buf -=
ARCH_DMA_MINALIGN" subtracts ARCH_DMA_MINALIGN u32 elements
(sizeof(u32) * ARCH_DMA_MINALIGN bytes) instead of
ARCH_DMA_MINALIGN bytes, so the copy starts well before the
caller-provided buffer.

Cast to ulong before subtracting so the offset is applied in
bytes and 64-bit addresses are preserved.

Fixes: 6b2450143882 ("fpga: xilinx: zynqmp: Add PL bitstream download support for ZynqMP")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/fpga/zynqmppl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
index 048d0d2e7a1b..24af1e0173e5 100644
--- a/drivers/fpga/zynqmppl.c
+++ b/drivers/fpga/zynqmppl.c
@@ -147,7 +147,7 @@ static ulong zynqmp_align_dma_buffer(u32 *buf, u32 len, u32 swap)
 		if (new_buf > (u32 *)buf) {
 			debug("%s: Aligned buffer is after buffer start\n",
 			      __func__);
-			new_buf -= ARCH_DMA_MINALIGN;
+			new_buf = (u32 *)((ulong)new_buf - ARCH_DMA_MINALIGN);
 		}
 		printf("%s: Align buffer at %px to %px(swap %d)\n", __func__,
 		       buf, new_buf, swap);
---
base-commit: 74d8eae19c90dadace5a16ee8b589fff563e086a

-- 
2.43.0

