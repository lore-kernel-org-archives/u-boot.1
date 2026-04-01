Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16A7D35171
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 10:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9B6840B5;
	Wed,  1 Apr 2026 12:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X2alvPfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1C184090; Wed,  1 Apr 2026 12:25:19 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DA58407E
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 12:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaAzz0KS4+sLcRWUa9IkKxElngtD/0jsgZ5pUUeW0CKAOGQ/RLqYIxrENBR/VLDEgzhgF8prmD864UI8K5zI8Zm36LcHIst/9ombAXRSuPzZ8TWg1S9cEUCZb4X+KzCWrhKVbbu7ljEg9m4Bafm9mbpryKIsWKCim9PZXGx/O8kVuV1EPPo/mLwsK2t1mY0yAFTo1QxXR5Xrgx+flVMOzRsk5cn2D/A+oN0Pc3D+97Gw2OqO+d7EpuXax+b0VCYWNuqu58Sh+qdibtxqyaISlP5sBHlcQYdhjVNTEqSj/N20KwKzJ6H4cdcRxtzTEqnj9tSNbhRyYaekyfnA8ix3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iahwMHNFwzrB8aDOtdj0LAvCGmXyuuTOcDxvvvPqyt4=;
 b=pJgoB33xDWiTMui9umgCg/2TRdgaoweis4EQtOhQXemmtGCI2SHkPxeZZebdiNKF2zs4js1tIe0elm3jH05u38WAMuzby7BnFUwZvuD48ST9fyW1ZfqNp8R+hS3/6oWoRqnkkZjZlAzhBCBUkLdJ+GIR6MtcLUbRq5HDqKvFY/4fWk7jsJgOzR3NaVkqgyLw2i1TSxRNCPt/usxm7opZhRNQb/3TxQIIxcNrTuiLPIKCkudXvV/FuGcJVG2fAZy+gceD+psNXBJNApzkYTue97qJZPL2u3QIpz74db0O1NFBTFbrcNKNWG7kIN5qxZMHtoJfRiF+KjAy3mY+S/qG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iahwMHNFwzrB8aDOtdj0LAvCGmXyuuTOcDxvvvPqyt4=;
 b=X2alvPfKq+pwu9hozoc900BHqHDYnbhiTHSl+7K2V/CQpWVff+KFcfYMHXBEGtmkLF12eqVbmp6iijnXlw4i+Z/ZXg+yc2ZpUM2v/w7s8x4unIiQgHAgUDrODRfcHEjfBQk1uMTZg8HVhNoO8FGBtFer/fV7hDlLj342/xo6jKY=
Received: from BN9PR03CA0435.namprd03.prod.outlook.com (2603:10b6:408:113::20)
 by CY8PR10MB6684.namprd10.prod.outlook.com (2603:10b6:930:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 10:25:14 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::ab) by BN9PR03CA0435.outlook.office365.com
 (2603:10b6:408:113::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 10:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Wed, 1 Apr 2026 10:25:12 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:10 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:10 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631AP9kc4093302;
 Wed, 1 Apr 2026 05:25:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/4] fdtdec: Introduce fdtdec_setup_ram_size() to
 determine the memory size
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <marek.vasut+renesas@mailbox.org>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 15:55:00 +0530
Message-ID: <177503910099.1968416.14447346293143226977.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775039103; l=553;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=fbauF55P9RtcuMUMpEsH8d90QokgU3qeE56l7NPa4nU=;
 b=jcRQ0UjXt0Jro7VbZzQV/ojlQ8RO32pN1PsIsRKDAWFuI5zY/DI4NBEZcoLSQcqyQp3glTjby
 96dFnwOv3SjCnaF9dRgq1YD3npA3LwlEUcP2ErYaf9VbDjVm7dLLmDy
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CY8PR10MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f11ae7-924e-4580-e969-08de8fd8f543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uIcBAqXzXJ6WuBk6JgGFolYLVeOu7CAgykyEdcWZX4KEt+VkPniX/82IMvOZVsbYAIi5NmV6TTxe3ePl5n6aVa9HRPe4c5j3SHSzxHM9Ky+8nqQlJnldDdgb+XXUY1hxTrtnVY0ecuXa3d36O5Y+uNcsB3nXNet4azfcOcacfVlO8mBCH+APPsDsjL2NRSjprFreQSJeT2Qloh5rqDcnwC+vP8h8KMvouIg0ydbFk6Fj6/NuEH6qAKSA/QlbB7LagV0carXXpz4YI8cuGV6zQklkWZZkptjLPp73LWy7TRFgRwObJrCnTBOLOpxiz88r/tHnSWzEeS0q26W3/vde03efraIZQOLGXypGVYJS0PvVLPFixPrve8QNAT87vJNVs/w89i2AkI350Qy86/dknao7IHmOsFuoNdWpl1jfpEduaell0uHOicOoShxMorjlxjRFMUij/Zy2Pyehp+tpCh4JQayfq9Du7N+0DGjspol759YWov7wbkE8EfZXxE3V/2Fmavv+KwcZuPpVxw3LMj9QakshLTDW8vA8f22WZNs1/aqrJbjH+kncbkIPSseiDlG+2OZTfv9FRLKrqhOha/qasC1fDqTpAcBWQN10FsQxIn+7yfFPIwxY3yXq/4pl5YA2sstzeVczPatMciXGFw1ucX4kcQnAIl+4VKhY/qgqu9p5PXMUWubVfEHbet7MKQt/y+RapoeWTXuoqm7K4Vgp80R52b1c72Gb2WCTK54=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9CNWeQHRGz12rfV77tTWhr/mh01yUpTemDpjFPpCSgTTyv3o6pqYwBs4Z+ixJWEA2OK2JY+cX6NWLW4LCEuRdfeiuWRXCNm1Mme/etS5vD0rkkTkSkSM2+mxg9qWOI8b9KZ1f+5DLRUoD07RzrZR6hBW6CoYBUozNYozONYWF6shCu5/LLUlzfYOB+0xVrj5nSTk+MCn2vp+IMSDoXCfQgiuYeSANH61/08D1DaXLeDEfqyirrgJhrEAsHZlBxERDRpE8upUqaRODkGARKHUR0bbwyf16q0TJlxDuWxF6Hjc5KNN8KxrLx13D890j6V0kdVd12n7LRw9M03GNfgKyaSj19QaO3waykpWl4pUHtq1rqg0cqqCmlwdLnud1g+YSO0ezmstmU6vBMLhRL8fICR7/91bcN8XzJ09ASHEs6PuAsb9KTsSLOL2kfAKczTj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:12.2616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f11ae7-924e-4580-e969-08de8fd8f543
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6684
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 31 Mar 2026 11:01:13 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> We previously added a fdtdec_setup_mem_ram_top() to determine the
> topmost address of the last DRAM bank. Similarly the overall memory
> size must be calculated when U-Boot gets relocated to the actual end of
> all available DRAM.
> 
> Pre-patch:
> U-Boot 2026.04-rc5-00012-g5789f787c8a6-dirty (Mar 31 2026 - 09:13:34 +0300)
> DRAM:  4 GiB (total 8 GiB)
> 
> [...]

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
