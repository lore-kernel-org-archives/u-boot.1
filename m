Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9D9FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F30843B6;
	Tue, 28 Apr 2026 10:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tEG/4Iky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB9D8432A; Tue, 28 Apr 2026 10:46:39 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE2D083693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP39L6Zvn7JDVmLHLCWBr1YBQWSE7YZ+71B3leHuOpOOPQoOoMQ2BPCZnvv0eEkM8GU50ZIJPwscsFGOhr8zB8ek8MV7CzaelZypGg+bvG3jnkOwBiOjXKLJpkiZuRBVKzjzXTb40nqW3uLGUkRRgr0JaJoXX7yr96s8wu4mGjoW0EtY4+PGy/smXquwyMKEOoM3gYQXBQ4kQZsu50OE/eRAp0j97X3jgG3yO9Z462tSdRqTpeoq5cpt1CPmkLMIVf3pAfOYPWvwzvvrDCrUfz10/zaB2eX3/5G9fl7+DrdVFntmWol+cjTOFATx4oW2YDJ1qhgMZITwpzwbS0vZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGfve6aCBu5PgA2qHXDzQk1tYza/TD8GKpWLwHj5RIU=;
 b=NSL2OIKCUARUx9cMs9lTbYplRbGNSNNAp2R9OUY2LBb9nNmfM7RB8L3JMIb3e0dnJTR2zvCrzc5RJbj9pTgJXWE5ZZys233HT9ksNufu8Jq1osLgPBm/iY1A/YR8RqN2zpuOKfIHS+NfrxCpdqQC5eom901VRVRaHglvY/NXaGCfm6yknaw3B1QFztbkWKSlndW0RIdvCbJfrvRo/cYfye4vNibEhXTKvDEPO0LBAxn61dkB7+ESLtdpHvHHAqEQYBTr839tc17gI2Fp0bOetS54FDVip/x5XMsrqdERYNuGNZ1VzK9Cz+txeG7LdyQ869jGAe6ApSp+YFqyr5ngPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGfve6aCBu5PgA2qHXDzQk1tYza/TD8GKpWLwHj5RIU=;
 b=tEG/4IkyYFXYaYELgnnIXbDfm1nBHB0aRKN1MZcALvtns+TyV7fRz6kimFOI2KoyYYSiEyNwzCW5qqTmNUUtQM+nYuO3xdMXV/+YXtM8fMMh8T9cpHodmiRBxR+8AKifW7ldBhyjvAZROXD4MLdI8Q1pwdBsTuOQlS48cF2NkQE=
Received: from BN9PR03CA0466.namprd03.prod.outlook.com (2603:10b6:408:139::21)
 by DS0PR10MB6893.namprd10.prod.outlook.com (2603:10b6:8:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:46:33 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::da) by BN9PR03CA0466.outlook.office365.com
 (2603:10b6:408:139::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:46:32 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:46:32 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:46:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:46:31 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8kSTL615433;
 Tue, 28 Apr 2026 03:46:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 03/11] arm: mach-k3: Explicitly identify TIFSSTUB
 images when discarding buffers
From: Neha Malcom Francis <n-francis@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <trini@konsulko.com>, <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>,
 <hnagalla@ti.com>, <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260425033742.1519298-4-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-4-b-padhi@ti.com>
Date: Tue, 28 Apr 2026 14:16:15 +0530
Message-ID: <177736597529.3159199.9566202587406883931.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777365988; l=611;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=7mQ1c+XLJSw7H1odc4G/4XeJ3Dx2s5r+5FPFobNG8JA=;
 b=EROK/PiQiCYSQM+a8ZhiOAQ3R+uh69B76M95gp9ktW1uVH+Ln9e3rMArwzXaiiJ5p8p+WYidU
 loMTUyY3UatB6O7rUIaKx5dYxD0B5dKc6dTHKUdy5d9EmpLdjGycuDW
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR10MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 004c1fa1-8a8f-4270-1c1c-08dea502a611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PyucrL+Ev2DyUFtV7LFvysoXvTIWiXm3xcOGU0RgOLMoiZa6caspmZFD+CIeF2DS4rTuOQn+xo7e6s9lefXFLuMLFECGL4bAfOzAQAmTc1XgZtOybJ4qCFwdAbKZlMM69uTB1ywA9N2sOmhUmT/NkYDKMtW+kXUCwjjvnqUSC/y7uSp/F55VGEZy7Myvj/ycLLjgPZ5fAWE4Zb8DJHArMEzu0Xc9zAN+1+rRx1z9ANMcfaNR27gL2klTY2/7lLmdgioe4KuW74hIcOBmYTljIS4m1Wg10sV7P5dGUTexNWeKFXUjAGa5IeAJSb5g12+H9BGyqTEk1eXkWEIDEOcukXZ4IUiij9PlrJHqe3GTUUcvx0yr+69KpmCqtOw0gHx23kR5smeqOZ8VtdLJ1dO/HTIHJfu7OiVZ8pNOQ0bfO+CUbOYxc6QTWtJu9K38VCkShNGzCNk0Ne0zgE4+8EkJH1OhEZBY6uOvwC7gajQw7mDIkxckCWOEjmIqjDcGHrMVEQCdfGtVVARN13ZvvjIEnZag358o6LqGmtWsLxtv9jYNk+NftVnvG3tozs7S9x3qHNBtelNwSqihQPt5K0xdT+y2zC7FolSB4ZI85Tj8sOovDe6SRfmCUjfotMwzDkQsPx2nJKB9xv+zkhSbE37EvcYo32IQ9fEte8uqcBHGpLanWqhnOf70J2H9mazi6p61jB7vNBa+Daw/PqZCvnspLPSJpra0paW2cf+xnLt0nGBv34v0GXWZIh2wrKktug3g/C9TrEcaO2a5Jp2yTROQgA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jHxV7na9gNRbVtVh1K/lxP9aBbQ76LAifU5/yJLbZNR714pZ9Uyol6ZXns6sBKWKy0xuwVCxgvPQucaqtfD/G+/OuR97KqzJUaaId9RxCV5pJUoQ6j2+GCFviHSL9C4CkFx3mV9oMSk/Amdzt7uloDqmWrddKbo7mKLMrhbrgllEdyBfPPEbkavbcp9NPAuoq3EUMgI5FYtS5Oj+tGU98spDxJbZcdHp2SgIT0JLOSNU9zLlwPrq46+kQuMmbyA+kyxgPrIwJmNTzavu2+zBslRFcs4ffGQd6cMYCHToZcUaxtj1XZzVRBE17m7glyvBxLe4FuPV0/NISdAvzO5nLG9whSLlMF9M4e64hPSP8z4qEEd0Jo9kGoiifAzppim7+ac5zJy3Ze4euxTJAFg62ViVWWVRvfkdGYQp/gZBTU0RzvLuuDwO+eGgeFYI2nF8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:46:32.6584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 004c1fa1-8a8f-4270-1c1c-08dea502a611
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6893
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

On Sat, 25 Apr 2026 09:07:34 +0530, Beleswar Padhi <b-padhi@ti.com> wrote:
> The board_fit_image_post_process() function assumes that all TIFSSTUB
> images appear at the end of the image_os_match[] array by using
> the condition:
> 
> 	i < IMAGE_AMT && i > IMAGE_ID_DM_FW
> 
> However, this assumption breaks when new image types are appended to the
> enum and the array, causing unintended image types to match this
> condition and having their buffer sizes incorrectly set to 0 with:
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
