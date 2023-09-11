Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367A4EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 12:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F1386DA7;
	Mon, 11 Sep 2023 14:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8+bL7Ej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A1586E1C; Mon, 11 Sep 2023 14:32:45 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C2186D8C
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 14:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpUvgepamUDczllA3lehCijU6kiweMALa+xW8Oz9theYYNLm/VZ5kM5qO/nHGrZkd/W5bDn8fTum19WDp1LkLtCwDC4n+48KxNbbkroleMmt4oKLTTfslFYl8llfizsPJabnypfc4K2SDrE763MHyxHEXqsmSTAAwKK6ScxXLDcZSxLOalto9uQRM21P3p/qY1Hu8iFttv/OL6xhZEqMAcWhlscsCEOeGXsNAOFBFsgWqCTaXgtRkZz2mXvyvB0yaKoUegI3at8WJ7UceKZMRwo29XO1i4siyXKFF+cl2Q2QOAVe6IFg97DuinFgS9XMmoBqjQx6LIi7w7i9QibuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ/auuBfbo++ey35WWCX/pUr9WdCCJkZ5sUkcAEexZE=;
 b=TE3FIByN9JaqImBFkNso95Jt0e9PNHi8uD76RT/WSYLetEKRXH8IcADJ4r1WGUIMPEl1SZZUrA/RbSw2SSctcIB4qV02a15aw1ZQoLjINCTW8j2W6M3184yo7UqQhtW2NNN5+I/wRbfRjMLf060X6coc5kc7Qd4PvvUJrGUP+R+CYGY8+84RP33ZrT7lJQPS8znwQheFLRGgvENbnBtBOie1BV3RQces2nN+vueuF9hbgWgcFK//gHcEvPhFFQ65c3m41NwXy9/9PMA+KGF4zOkDTmhSPAtym/+cCn9+I6T7w01O1gs6IdcFyeMl5AzOvbOXYCKNZafEqBrklH06dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ/auuBfbo++ey35WWCX/pUr9WdCCJkZ5sUkcAEexZE=;
 b=s8+bL7EjxfBNnVq1bHzhuFCaezRwWoHYNIIZ5ozl2ywzqoa7PfNZi5dBDJw7V9IWLW7D/Bg/UZKgbhtYTVvd3XRjMuVhtl3ino/1TtYSXz0Q/jozcSBEGjq2PwZazWzDe9w3pFFB9sBSAEZCQyymSUnCW9b4BhGpNN/MziNNQis=
Received: from MN2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:208:134::45)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 12:32:37 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::bb) by MN2PR16CA0032.outlook.office365.com
 (2603:10b6:208:134::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 11 Sep 2023 12:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 12:32:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:32:36 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] trace: Move trace_clocks description above record offset
 calculation
Date: Mon, 11 Sep 2023 14:32:28 +0200
Message-ID: <9d02ae765d23ed8b82af8db4f288492c30d08ae2.1694435541.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694435541.git.michal.simek@amd.com>
References: <cover.1694435541.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JJ/Tc74EfZLfyoFGuJ3s0SY1erxiIZ7bFbTJcOlyjkA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/HLdWuvHuCJey+1PpnTtfoMvXrCe5r7moytOfN+LdY
 uvjE+Z2xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIl0P2GYH//rm9ntb24d9tGv
 /tgufFUaYBqjyzA/Y+O25xbLTeZvT5y8/ce+1Xe+vuUuBwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: b8949494-b81f-49e1-64b2-08dbb2c32e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+cjt/6mASbviwgv7DCUTtfisY3IEhQkofcdZOdiW86f+o6qYpGyaXVjwWgQGcyhEcGbMccKAj/kvq1u5l4VS1DH9maY2NZTim9epoFQ7HPUlZwM9Kikhbt14pRE+Ixr253+B3aP4A6l0Ay0eUO2PAgjn69rIyie//nw9DRZ5XR786AkVN1npb8bft+9bLAFt7NDfkgU/eAS+etLxCER+3HD/LYCHqbmSO71sh5M+aNY+s5e11E97s3LXsee6SfgTMnrvRxjqPypGbI+2UYdGWQSvNjnZieE6D2RqFTFeH7uIKBgofx3Ydh60w1JWm/HIUko9qB6RqEIHRMG0Y0V25p753AP2ybpntKssaVz+r50LhXPNFxrXIrA/6+q6hTuO7BpcaIcHABjPL3b3c/bScHgH3ON0N86tPOOyLYE2pewFyWTdw+2OpmYNdOdQNzlliigb3XHY/YYwelsLNq41PQv0/OmRen4ED5RadbhxFFCJmSPw5W1s083lUsDxZKaxxAxYV+7mfWvH5kUUk3IF9ygzBc/zoUpi4JLohBu6OyLvZVh1rG//7H1Nu8odRNeicrHFJLrx7BB8kmismb1tCOBEMAkMfn675aiGUoz0cVAmi4ka6+glNMQmReAcTB0VKGomKPYTWM7jZjss/YLkMY9bftfL8ka6PuUUSq1vbwE68gwZ77iDnm8OTdQC5h1EZOW+NWZWNhFAPJtbvsu9GLyWqRPrUTSdbK8x4R+TBuAtLk1RgYxGP6YGoMPkWwGmxJ+X99FQvttvZOpDLzLmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(86362001)(40480700001)(44832011)(5660300002)(8676002)(8936002)(40460700003)(2906002)(36860700001)(36756003)(336012)(426003)(83380400001)(6666004)(2616005)(478600001)(81166007)(26005)(82740400003)(16526019)(356005)(110136005)(41300700001)(316002)(47076005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:32:37.1776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8949494-b81f-49e1-64b2-08dbb2c32e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

Flyrecord tracing data are page aligned that's why it is necessary to
calculate alignment properly. Because trace_clocks description is the part
of record length it is necessary to have information about length earlier.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 tools/proftool.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/proftool.c b/tools/proftool.c
index 869a2a32c510..7c95a94482fc 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -1500,6 +1500,10 @@ static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 
 	tw->ptr += fprintf(fout, "flyrecord%c", 0);
 
+	snprintf(str, sizeof(str),
+		 "[local] global counter uptime perf mono mono_raw boot x86-tsc\n");
+	len = strlen(str);
+
 	/* trace data */
 	start = ALIGN(tw->ptr + 16, TRACE_PAGE_SIZE);
 	tw->ptr += tputq(fout, start);
@@ -1510,9 +1514,6 @@ static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 		return -1;
 	tw->ptr += ret;
 
-	snprintf(str, sizeof(str),
-		 "[local] global counter uptime perf mono mono_raw boot x86-tsc\n");
-	len = strlen(str);
 	tw->ptr += tputq(fout, len);
 	tw->ptr += tputs(fout, str);
 
-- 
2.36.1

