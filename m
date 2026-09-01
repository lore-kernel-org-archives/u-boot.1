Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9BBC61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 22:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56D8A80DCC;
	Tue,  1 Sep 2026 22:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HivxSPnoxW2A; Tue,  1 Sep 2026 22:16:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788300968;
	bh=0PR6kYGizRcRjeLv4dIemc3uK9blR3/2LqS0305xiTc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s43vbX8629uLZ5oSn1BYiPWjv+2M6n+fBBHjOrFKi4+aORT7OUTtYBw4jMwoIOkrY
	 LDHGlG45dXJW9M1q1XHUMG8HAJnVK6GYRw6FnglIN4JGvtaEvI5W+0Z53cI8bAyagx
	 b0RoDYBbPogIQeUlRlPzHYd5KHTwpkW3fp8Ag7KNo+umGbnu1a51e04V2hQ+c7Tq/X
	 6e16UOxdJmI16wvnSh9MKGp1rVCFlEuA1ZNXP7zxULOl2mjOOiumHa4d5Pcp432x94
	 sZa4321qhF374nQjkdtuhWQWm8FuZY7SwSzAL1CDGw+cZ5b13gNohFT/IY0AUqYte7
	 oPXQ1ICZ+qpFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8815A806CB;
	Tue,  1 Sep 2026 22:16:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDB8F127
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 22:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7CEA4011D
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 22:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UA7PlQEPpWaT for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 22:16:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.143.241;
 helo=mx0b-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=ubJhsAd7; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=Qd+xVd80; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=Tyqj8HVl; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=NnVEsdM2
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56C05400D5
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 22:16:01 +0000 (UTC)
Received: from pps.filterd (m0367129.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTxjC3379844
 for <u-boot@lists.u-boot-project.org>; Tue, 1 Sep 2026 22:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=0PR6kYGizRcRjeLv4dIemc3uK
 9blR3/2LqS0305xiTc=; b=ubJhsAd7dSJd9Jmjq8LAUvujlyAdX59Ss5q794n+A
 oVj0IdEPYvReGBh3E/nfEfWVncoUBF9nWp1fmL36h6LWwQT4AVFM12k9x4JRh5fb
 rMmDWwxPPJbT/KuBt5YYHyl+7xkMImf4BlIdW7ZbGbRw8JOQ2VX4o7iPeBkZGTyA
 Tp3EpdHtz90RetDQwtQUpExuCrebPkHvqD/gb3TzzLn4/k5KeRQtKS7FrNIBOnOf
 d3BdHdG//MAlHl7A+g1cEbZVDK8o+js6j7lWk0cBcgWCwY8fukTWnu82tko2kquz
 s3NVMerFQUpvL+BtbjzIwnv67rNKNdQxtYxAzcKui8shg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ge4th1m1m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 22:16:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGoREJzBh6SRJm4S3JE3L5AS6z4QZ8rCg5i117ZcZRjE/kn0g3REZlV/09iA1rSBDz3ok6uA12YEYSFJqGFgg1A5a1GzuAQow5GNPco/inUdOPdPKKP6WsXGLxJj2oVY1IROgHC5I0at9iLVHAuOYrYl21sn6dFEfPW1PmpetKEeg1S4OvOjbPbeNGfm7atiKzFY6A4+NEj2ZGZoOeSEsJgPOrPDDLlFC252GcnDJ9Q1EUVMTp4DvThAzAIEnVxq2BMmjwcMkmosKRRoM7EepOB+8ZU/yWiHQRW1PObumnKV/npTm9klnnbmOwNstavB1KFyEURmCibjKS5lHa1lww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PR6kYGizRcRjeLv4dIemc3uK9blR3/2LqS0305xiTc=;
 b=aSQk6uz3iM2uxM5SGklA+c9iQPzc/odCb0EOXkjEjywJeNTq0ZAD17b+9xlohNLqyeZt84t2ySyaxoscZ/eD4DXho+kFQdVChNx1xjRCf5CHKxSmD4RosldxxZaU/CHiFr1MIAW+jvObRCB06bJxZHFCB0hJ4O1EJn49NLTfoqCfLlIxQWB10k3wTXlPRe1AFscWHHeNP+5RhTCELgsH5iLvx+pNsqIOxM3awY/HW8LBrWN6Kqp0BvQSKJrKOOrxLkRlpBPA/gFH0u51yp/TVpFqW9020M9xQL6yxql472Zr6wE96b8Ix8AXfqSd8ocq3G0/UzThIG7z1BrYFigomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PR6kYGizRcRjeLv4dIemc3uK9blR3/2LqS0305xiTc=;
 b=Qd+xVd803lzaiuOQf69bbfzeYfrHK4/oxVuGwJXyS+KXE8JcqP+TUu0M1n4U8bilrV26pdxHXSiYha0nLKQoPFSBGF2Rw4Tuez/yFDBsUC8mEkuyg9ahvLKoycGLKGjfU22lAMaA91xj+hJlLwX2M9KjpOTrZCy7OzQ/KFugDoE=
Received: from BN0PR02CA0060.namprd02.prod.outlook.com (2603:10b6:408:e5::35)
 by CO6PR16MB4129.namprd16.prod.outlook.com (2603:10b6:303:a6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 22:15:56 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::ad) by BN0PR02CA0060.outlook.office365.com
 (2603:10b6:408:e5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 22:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Tue, 1 Sep 2026 22:15:53 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KW3qJ4079941
 for <u-boot@lists.u-boot-project.org>; Tue, 1 Sep 2026 18:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=0PR6kYG
 izRcRjeLv4dIemc3uK9blR3/2LqS0305xiTc=; b=Tyqj8HVlbn77Pzw5M7A3JUS
 yuQ2dGVqd230EaY486Trb8afkO3Vs7ySMZgY+v8Um5gFW+USzPEn8wFNqGVib+Oe
 C8MEFDiNBmxSEXDztujxN4RdQ9nAeHg4GEKx04PGNBspmkCPfksGOmOmHAhOGWZ5
 BpP11r47VIrIuz7U8ODinT/6NEkokJoGfv4zIUV3VohOiqCSP9NZxPiai9Y9HkKc
 C+t9Q9XcWOkxhhirRr4CGo9lcj4ZbNkIocNgsgDKWFVimERtOqRRa6DHQJd3wduc
 VgyJ8UJR3POKVlyyJtkWPXy1pKQGBU/xJGQD3fKQoAONL35m4LoNK6siYR0oEFA=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=0PR6kYGizRcRjeLv4dIemc3uK9blR3/
 2LqS0305xiTc=; b=NnVEsdM20xeb9Phn2sAkY+EYmDor15dmHQFueGtnFdn5zuF
 ZMZDgd727qtBi0uGodTS2gPhOJQsEkyzaz5SapQCbITRdlWQot1wRbfTtywOIbrV
 Tr/Is4mNkbS2B1tFC20tZP5/7oW1pzC2r/kDAcs0JxR8co/WzfjmPbtYQ0JUAr+S
 5VezxjLBLf+/0bJVq8HJ6erzz9XQ1Hrrkn0C4HWqS+yPNaKJNcZ7iBOJ3XYnEXMZ
 DWk4s+UGE6+TK+BRq/pw9gnFwdtocAekGp071IIO3K7fb7sxZ1qrc8adTZ3EcEBm
 wcboP6W+ivWaeSX4Q088WqyVAtejD75T1aoi87A==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4gcg9y3x21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 18:15:52 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id 1WlixQZuIfYH11WljxQN4N; Tue, 01 Sep 2026 22:15:52 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: 1WlixQZuIfYH11WljxQN4N
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.u-boot-project.org
Cc: heinrich.schuchardt@canonical.com, ilias.apalodimas@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, quentin.schulz@cherry.de,
 sjg@chromium.org, trini@konsulko.com, Denis Mukhin <dmukhin@ford.com>
Subject: [PATCH v3] disk: update partition type reporting
Date: Tue,  1 Sep 2026 15:11:15 -0700
Message-ID: <20260901221113.969840-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010195
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|CO6PR16MB4129:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b14a73f8-8708-404a-b657-08df087696f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: iyPbN7//9b+XhzyxrT0fDtV73oxL81R4LwcFBI7lFIS0mdjZBrgS72NZ3N8MxEaxSMDT5ccY6Zq1KLxEY44vbDoW8jW6BCOupuY3/TiN1ENZiDZrVJpCiRx7p1wFWdtLlg4OeAUamdnsujuD1EMPjjKFn2mzsuxZdwzV8T7LRKq3KtVV9aXg7ugEWk1Q/m/KSRxmDK/ODG8ccuqglyCpw+z2xIAY0iUDosAbmNk0c7LZIsHnKVP4+TZKG9+mHbAdQZlYZeycZj9btd3b4ocFTRA6TA2+KAryq0PrkMeHXCxozbuudgNW+amWB0Qhl8s1fIhwlsOvdh74suHYZASIb3ReVS/5JTgxr+O4o2VeyhRzTm9pZrdqxzsw5lsb/ttLwOi8b6au8ONqw1b1vOS8jGenQZ3dzrRyaF/r9Jyo+5M5GoLyT8BrmtYuX3DPquRWjfsTUQic3XrbctTs3K9LVL4I2qM4W0xY/72OC4vKycNERwBut9YJjblUJI0ZTX43hmWIyxQVgNmq9RD9f5jbDuORk1l3TajrLWSUWz7S/NoLUj7MTuZ0NLriQKG9NfnORtUeqfvum1NWguhtHN7j6bDH0Wc3AF9GvXz27ohdoVoTg5ZR8TRD3WRj90NgMU92D/bL30HWoFpEtQyVEbLQSu2cr12nAJH1Yc6dsVv3+/DqkfpbXq5QF9kK2htmF87bVMC2R9WaTYtIUFKVIyzRmQ==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LWfKETX/NfktU688wpeQ1gc38Ory29YBZ7tUbGadn+uzXKX2IZd6uZFN6gRl2I9YeKszbdh+XFS8sOEtFTh0CDRDMe8KxyW8+zP0qc3ONFSTsEZ6hnt+JXFoHRZzTOSfNYukxvG31BtbRgLM3Csqhwd4OseBPrqxPSBjWMc/I6sBMupN4SHYg0sqoFA4560msS+DQIjHNNPIg69QuRENVDQXeSAoCC18SQTSGLCL8g9idmo8Q9ohQaRhe//Tt8BDdoVnfnh7BvltYxxCRRKpEg2xYS0DYsxiDpDXHmk8jclVxL95mmq9EXAAA37kCmlIb2iofHcDjbd1AHUQgSI/rWqbfihP2CNENMDb4QmOmMrAp1s/u3HeHUeZsl31S5O9lRCQzmr1RHfqCCiya+VJtfj9HLlgd3+5TjBfNn+aiK14iMEg6Stm8t37KSISfznC
X-Exchange-RoutingPolicyChecked: hOznjmCOHVklgvldU2mOh6evz5TjfXpZxpbYRH5B9wzmPmSfSAPnI11WImIEZxT686EjCidAgxNzxn6Z0n8uaHOToLEqsauR9wsvX31cO8hua31gDtD1JqlZMRKNGWjZuPCFGUzIpdD3IHvJ6zuP4FSuP9OlTWrxHra/egDszpa4bfmdDRFS/Ug+cfLtDATK8WF7eAr/NkbQERD1GOerW1bP038KKVAE43DUyz+fhgVd94XgzeyKOyTIqL7kxqYqegLusHlZmnBebOwu7OGV/PHN2/n0SHw+Klxba/vyJAC/hTak2H0VpThfb7MLQr5b1/aWi90U8dZOPU8viOk3gg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sRfr9+UMD3v2KyGt5nM8kvNK67PqChriB7oP7z4+2iXqncngCwDFJkOvqJFBiRQrJCtlfnD64jdBsgsYf0QJPt7715R0pTvFZsIDCqxhyuLWWqMYk0iaXS/MLEjmuWG8cbKVia4qgJ2t8QaJbeSud9SQBSN7jfVK9jgC4sGfG2Id7Eus1J4rDTkJERsIuvyq7au7yFq6IPuu88R/2lEPReqaiGVJ3EjGorJvZGEN6A0Q/ojJfdtrUOs7hn8+nCF816UpM54jOYTZSSzA5gAeSkECoLZBCjzspDXoI0XDt7OZI8phOyA5BFR4I5dtJu29oi5/J4O2i/W0xwyiUSyLZoifK0er+7jqWZ/pE3w0iophBoAsZjpgYWZvvC+YXss5kS/8mUBlEAwjSw3b02fiqaWW056JyxOn9Oticb3pDOf9VxaPeSP4D5DUtCmCfdvGEER6et0Qbm13h9wI/b0chE1JmZBO22sGaPxQhMWEoZbX8TU6S1ETXjYhfXGeTsr/XS/Eenf56ryPT1vS2j8jkQlLwHQOU7Js87LnGgd2RhBWLsOg1xzRnTBcM0g/QRO/Fgu2ncCAmU3pBNNkr0PY8JMy5Rey8ZmqlT6YOk5c8Afxr0QqhJ8OFjtxOeXci+LSJ7eI/KKAJJS2x7OUrW+5Mg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 22:15:53.8951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b14a73f8-8708-404a-b657-08df087696f7
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4129
X-Proofpoint-GUID: l78BGNRjrWSFIi8-tX4wyKgKxSl4Z1Ht
X-Proofpoint-ORIG-GUID: l78BGNRjrWSFIi8-tX4wyKgKxSl4Z1Ht
X-Authority-Analysis: v=2.4 cv=QJBYgALL c=1 sm=1 tr=0 ts=6a974ea0 cx=c_pps
 a=vKxAdbwNlT/VBnJ0vobx9w==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=X3KReqg2EL6A36SYCKpz:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=NEAV23lmAAAA:8 a=YUneP3UB9ZmWW28UWM0A:9
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE5NSBTYWx0ZWRfX6E+dvb1l2xbc
 UCllBGjuiR3l3+XLOngDLcJa5fZ9ErwnhMLmxEtdE9Iff8TfZaiT+/az89TI5jPaXcNU8bL9Dra
 f2ekk17jgSQY5CzoUEX+7/H1QyOAfIwMBPQgyez3a0xWXmaT658q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE5NSBTYWx0ZWRfX3sDt0Y5BVpf/
 bC5+iFd7FxMWCH82+W1SULh4awNTmu4G/atTmr7Qu7zuKbKR8bjz2puTKg+Owu2zaSBgc1dyc7O
 NxMC3vxfflmdYMgkgsrWSdEiqXMZFrn6r0resyxwr/EJ0bs+0xeHOUYUuIV5EvjflWNXVCwVMId
 QkPOuywvE5+GtSFYlFz8ozIi9JC2sMAQ0KFx25lZC6BsjlbMy4MykFv5DUvgQ0TrSaqqil8z2nF
 b3/LcXKZh+QcOZZ+VorC2Sl7jpIUAQuZMglRwExU3mjlexjxAEf9TPmPJEGXtrZpjpHIgUdBNGW
 jP3FjY4qaBR5JDvceui4zueBpjCD0fVtAJpyuUz3IG77V6EPUsXPJnCvJzSPILuA+v55l5cWWCj
 QlG+GMkjsqcFGbR2bpd4tiBd4un8F7dXavOCgs4qpo3rmWN4hFTwKICWN6+NVLq+SLdX5ngDRAf
 DfJE+vbHCPT4e/TTJQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010195
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

From: Denis Mukhin <dmukhin@ford.com> 

Partition drivers currently report "U-Boot" as the human-readable
partition type. This does not describe the actual partition and can be
misleading to the users of this information.

Update the human-readable partition type from "U-Boot" to
partition-specific type.

For GUID partitions, when CONFIG_PARTITION_TYPE_GUID is enabled, use
gpt_pte.partition_type_guid.b directly for type reporting.

Update the relevant tests and drop "U-Boot" check in
blk_get_device_part_str() since it can match against
gpt_pte.partition_type_guid.b (e.g. "linux").

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- use gpt_pte.partition_type_guid.b for CONFIG_PARTITION_TYPE_GUID=y
- do not use BOOT_PART_TYPE
- add per-type partition string names
- rebased on tip of next

v2: https://lore.kernel.org/u-boot/20260818190426.3567429-3-dmukhin@ford.com
CI: https://github.com/u-boot/u-boot/pull/1036
---
 disk/part.c     | 13 +++----------
 disk/part_dos.c |  5 ++---
 disk/part_efi.c |  5 ++++-
 disk/part_iso.c |  2 +-
 include/part.h  |  7 +++++++
 test/dm/scsi.c  |  2 +-
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 316a0b09a097..0fcf3af0efbd 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -381,7 +381,7 @@ int part_get_info_whole_disk(struct blk_desc *desc,
 	info->size = desc->lba;
 	info->blksz = desc->blksz;
 	info->bootable = 0;
-	strcpy((char *)info->type, BOOT_PART_TYPE);
+	strcpy((char *)info->type, PART_TYPE_NAME_UNKNOWN);
 	strcpy((char *)info->name, "Whole Disk");
 	disk_partition_clr_uuid(info);
 	disk_partition_clr_type_guid(info);
@@ -473,7 +473,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	 * host's own filesystem.
 	 */
 	if (!strcmp(ifname, "hostfs")) {
-		strcpy((char *)info->type, BOOT_PART_TYPE);
+		strcpy((char *)info->type, PART_TYPE_NAME_HOSTFS);
 		strcpy((char *)info->name, "Host filesystem");
 
 		return 0;
@@ -491,7 +491,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 			return -EINVAL;
 		}
 
-		strcpy((char *)info->type, BOOT_PART_TYPE);
+		strcpy((char *)info->type, PART_TYPE_NAME_UBI);
 		strcpy((char *)info->name, "UBI");
 		return 0;
 	}
@@ -643,13 +643,6 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 			goto cleanup;
 		}
 	}
-	if (strncmp((char *)info->type, BOOT_PART_TYPE, sizeof(info->type)) != 0) {
-		printf("** Invalid partition type \"%.32s\""
-			" (expect \"" BOOT_PART_TYPE "\")\n",
-			info->type);
-		ret  = -EINVAL;
-		goto cleanup;
-	}
 
 	(*desc)->log2blksz = LOG2((*desc)->blksz);
 
diff --git a/disk/part_dos.c b/disk/part_dos.c
index 4e1d01b2f21e..4b560fde1fba 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -273,8 +273,7 @@ static int part_get_info_extended(struct blk_desc *desc,
 				info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
 				part_set_generic_name(desc, part_num,
 						      (char *)info->name);
-				/* sprintf(info->type, "%d, pt->sys_ind); */
-				strcpy((char *)info->type, "U-Boot");
+				snprintf(info->type, sizeof(info->type), "0x%x", pt->sys_ind);
 				info->bootable = get_bootable(pt);
 				if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
 					char str[12];
@@ -321,7 +320,7 @@ static int part_get_info_extended(struct blk_desc *desc,
 		else
 			info->blksz = DOS_PART_DEFAULT_SECTOR;
 		info->bootable = 0;
-		strcpy((char *)info->type, "U-Boot");
+		snprintf(info->type, sizeof(info->type), "0x%x", pt->sys_ind);
 		disk_partition_clr_uuid(info);
 		return 0;
 	}
diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8b17ec2e91a..de7048639a6d 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -304,7 +304,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 
 	snprintf((char *)info->name, sizeof(info->name), "%s",
 		 print_efiname(&gpt_pte));
-	strcpy((char *)info->type, "U-Boot");
 	info->bootable = get_bootable(&gpt_pte);
 	info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
 	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
@@ -316,6 +315,10 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 		uuid_bin_to_str(gpt_pte.partition_type_guid.b,
 				(char *)disk_partition_type_guid(info),
 				UUID_STR_FORMAT_GUID);
+		snprintf((char *)info->type, sizeof(info->type), "%pUs",
+			 gpt_pte.partition_type_guid.b);
+	} else {
+		strcpy((char *)info->type, PART_TYPE_NAME_EFI);
 	}
 
 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
diff --git a/disk/part_iso.c b/disk/part_iso.c
index 6e05b2feffba..7b4e61f2099e 100644
--- a/disk/part_iso.c
+++ b/disk/part_iso.c
@@ -135,7 +135,7 @@ int part_get_info_iso_verb(struct blk_desc *desc, int part_num,
 	/* the validation entry seems to be ok, now search the "partition" */
 	entry_num=1;
 	offset=0x20;
-	strcpy((char *)info->type, "U-Boot");
+	strcpy((char *)info->type, PART_TYPE_NAME_ISO);
 	part_set_generic_name(desc, part_num, (char *)info->name);
 	/* the bootcatalog (including validation Entry) is limited to 2048Bytes
 	 * (63 boot entries + validation entry) */
diff --git a/include/part.h b/include/part.h
index a9d0039a522d..48ed4f21f1d5 100644
--- a/include/part.h
+++ b/include/part.h
@@ -29,6 +29,13 @@ struct block_drvr {
 #define PART_TYPE_MTD		0x06
 #define PART_TYPE_UBI		0x07
 
+#define PART_TYPE_NAME_UNKNOWN	"unknown"
+#define PART_TYPE_NAME_ISO	"iso"
+#define PART_TYPE_NAME_EFI	"gpt"
+#define PART_TYPE_NAME_MTD	"mtd"
+#define PART_TYPE_NAME_UBI	"ubi"
+#define PART_TYPE_NAME_HOSTFS	"hostfs"
+
 /* maximum number of partition entries supported by search */
 #define DOS_ENTRY_NUMBERS	8
 #define ISO_ENTRY_NUMBERS	64
diff --git a/test/dm/scsi.c b/test/dm/scsi.c
index fbc36a742446..66859c991df1 100644
--- a/test/dm/scsi.c
+++ b/test/dm/scsi.c
@@ -30,7 +30,7 @@ static int dm_test_scsi_base(struct unit_test_state *uts)
 
 	info = &part->gpt_part_info;
 	ut_asserteq_str("sda1", info->name);
-	ut_asserteq_str("U-Boot", info->type);
+	ut_asserteq_str("0x83", info->type);
 	ut_asserteq(0x83 /* linux */, info->sys_ind);
 
 	return 0;
-- 
2.54.0

