Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD28606A332
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zMHMQ38J;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NL3gs+f/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8B3260858;
	Thu,  5 Nov 2026 09:03:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVHmQaAtya0V; Thu,  5 Nov 2026 09:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D4FF60862
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793869424;
	b=PUblBSNnlDvQ1J5JaKUR+BJ6F0iCF3Ziofq/e+Y11zagIDxMX9TeWnLViOIViUStbQIZ
	 N7IlEr2mvRdIawvcJKi/+1gUsiljNxLt3xMF9NNEwKm7EGmarP5DCe0mV5Usnhu435XXM
	 EW+teCueX0/uSrPzGGQ1+v5zx80rsqEf1SMCcrwnqvcDhzsAsepSJdeG+zgtv6hSnf0C1
	 LqRQNq4xYkmQsPUtXQEiFCeOefKloSRm/qPWSxlbuBFRkbo0m75QZhBFvEWozV+mRP/W8
	 /qwiC6zW8mTce8/qUEFqIj43d9HC4bzdXQ1EkNAa27ewt0N+eSadh7qP0IXG+1V7zZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793869424;
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
	bh=mrBt9d2p4NZ2OBnY2Ew38SgikiGhQ8vljQSLK+0YGXg=;
	b=U6azCSFAFtsQIs/RBeHUFqDSIiBzruQ3mwIe9+1dlnQk7+f8vG5IDz6uH6/a3vDHx2ET
	 9YYHEG/87kiRTMjGsHrBejVeEModZr+fqXg6a+Y7REs4OsyJO/BcxuAsLQ6+FCK9FTy1q
	 Q+jYwOfIo9CtejJ++5JsHsy69MRZFpzuQy4pcIFRz0AtKKMAzVna+rb7hErHs+SfggDZO
	 tK+EY1/JwPaur4Lfsftkis902FV6G/OzAeB14Jy0V+5RGJ5Qyu6DbwIVHxA/kaMjCVIFC
	 Tgd+o4OYgbp7Z84V8TZ3MWYim8Speh+0A9PeCgx4/a9QiJ9YtFlv4Ml6Z2fI56DSuHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793869424;
	bh=mrBt9d2p4NZ2OBnY2Ew38SgikiGhQ8vljQSLK+0YGXg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zMHMQ38JqD9WFamiI5V5AzTLCh4z6ewVVfAEdLSBj2szcACkzSB+9ZF978J6XD82f
	 zKXtEK5UVMI8JGfefmza/LOIUnSWmOB80mEEo/MzflG7xxGS0jA5ZuOjsgkJAW4+we
	 3omkl93tolonokAqWeVY+ZAa/la/pviewmBm/6e0mbCwoLXTp+8DD7Xwxs0uxy7+kN
	 cWjrZkcrGi+ypkYFBfS8LtZUWkJIb+CWxa1TKAQ6By2BmKJRrloVRlU89mfbZYUflT
	 mBH2i/RactjrAPvl28GRHLFvNzTJxPZLndRhOMAdDH6etKfm2ZmrxgEzDJtLIxmBXq
	 FHGtjPKwewfRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D4FF60862;
	Thu,  5 Nov 2026 09:03:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5C1F52B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3068810DB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yes6Y4aj8k8d for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:03:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 624FF810EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=NL3gs+f/
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 624FF810EC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrBt9d2p4NZ2OBnY2Ew38SgikiGhQ8vljQSLK+0YGXg=;
 b=NL3gs+f/RXjSCEyaqmSgdlUBjYuv/MRxqTK8YbiZm7KC2nwd3TcS1/3rpZ+QtROWcKnim/wDriDFG/MjZ/5eqWcG89B5SEKuvySUZ7GsJWaIS72+lhy459Q4eNAeTug2M3sGZuZo0Y8ff8MKkfZNmB7MtxjUeVClHc5/16P/Ee3CAi3gyzvraZlfNEw2pV1oPMMd9RqDkvXighoz6qg0PHJwKxSzg9oyLFHsBTxjw/uyHTQRhw6hilwF5IsVqztA/S+3OW2PLfZyaemroSHX3upUgKLRRy97HKyJfXE/a/wvseyQQIe5J0cYN2Lvqmh/4DHdDSR0HgwHhE8f7vNn6g==
Received: from PAZP264CA0156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::17)
 by DB9PR10MB6313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 09:03:32 +0000
Received: from MAD0EPF000008B3.eurprd04.prod.outlook.com
 (2603:10a6:102:1f9:cafe::64) by PAZP264CA0156.outlook.office365.com
 (2603:10a6:102:1f9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 09:03:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B3.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 09:03:30 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 10:03:59 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 10:03:29 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 5 Nov 2026 10:03:22 +0100
Subject: [PATCH 3/3] mmc: select the hardware partition after partconf command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-upstream_partconf_fixes-v1-3-6abda284aacf@foss.st.com>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
In-Reply-To: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B3:EE_|DB9PR10MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: f07f4200-e831-4f76-54b3-08df3b1ba9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261026121527099003|261102123227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: SgO0qdAAuXEeploXq9aM5a8+ysVeZqc8dBGKqLAaodhHTmO4RgUI8SAh+nn1IrUJRSwluhtwAgvyHXqY/7018oF/MO7YrDnEprSH7TjkXE0e4dDqZkZW9+NyF0V6TdxXlSBP9HhPBq+jx+cUgAHTeJgDD0HJX18y3XK4fbJ0rIwjepC3Mzp+qLLl6HRvu8YdsTIWn4dK/nR4h7dwyiJ2fqG0dO7N2C/GqiXbUeLCThrWpM2ybBCThYkYlwj0BQofyd7KfORn7hcRP76En3CQEm7fNVNlOKxq/x0JkEk/9teifg7Qt4vkEHZg7VtZ5HsYKg+fCugzBNYWW9vtDtkx47eRPXOGFtzDyQf/dsue47xep8CoOZbvzEUgKMkfnZX2lTZgDHy04l8EF8Ye3RYNM7EgCGZ4ObkKUHaq9cXps/NhOsHU0aF+xWYTTO702Ki2BdOWXNYMJYV/GuvyVx2/WD+fPOSxT+i3wATb5IsSi0KvZ9XTpS3B9drYP5k8NXsPyzDssMwglOiytr0ONrkTJnbfS/tqyPqLQl6/qtD1gFLHBVJ0enILfDEd0gI2R25jdpz0K8DxLKLTrU4t5C3kVi7DLXAAGpt8Q5KBxxjaSEwznS47j8P0gx2Z6l1K5/HGiA2xGN+sqeRZ1c2ZqH/XCEDc/0iIj9EuTl4iaL4htZUBaiTFlMmjnLCT9fh3xzuod1BYPqNUzhnLQFwIIRD2EA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: myltgweh5lVJObhz1fnk0DQ2L+bcvlOV2yaYCY7FNwqqostDBarfik/e8Q0jPpRFOYq3YU2i+vYUvXp82rR78ofcGnR0pHnSpoE85R/Z/UqAz4Flc5ds8Ot6fJRiKRshHFRUr5Xu5ht8Shw2KuFp+RJLOTk3hlAeHnEPJl9bZzZVOHwvgv9Uu9RMDtIBLxC0d4MMYXmAxEhUkkRJaPa8Rv8t1qr2EkVYIZXKRhm2x7MOqzRNNLzku465ZoNPeViL8k05qxd3D2sFm7uqEoYl6ajRBbDzCcY0CZj20Vlwb+4Gcqgf5z3hxPiU57+VBfTGYeFHy4bKl4EHt2holOuEYSdRqmABKO5k+y2l6w/gpXi3j3G6r0C9RfLrRHftFrjodnMorXsU6Ty0DafjHcyaxYUDYubTro1pCN7raHNMc0iDV7yHm5U2VeDFTxlMwj+n
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:03:30.5816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07f4200-e831-4f76-54b3-08df3b1ba9af
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B3.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6313
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Select the hardware partition after partconf command as it is already
done in mmc_select_hwpart() / mmc_switch_part().

This patch fixes a "mmc partconf" command issue.

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

