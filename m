Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0263C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 13:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4899487948;
	Tue, 26 Dec 2023 14:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KRZslLpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A0D87948; Tue, 26 Dec 2023 14:58:00 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC06A8791C
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 14:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYDZCXvpgAtkb0vtvd0poZjJ1WYUjP1gIJf6Ln+20hEgzip4bIXjj8ngh3m3KY7ubD2eTT2VDFsKly6Q9ObhpNsEsGKIw6R4wFpqwuDKLlFVUycVxjm98FsiLfYBMGSB7/ZZmdEjqdE8EaihsB7/E9oZM9OkTxW1g4OmuRVrogGzuJRZvrWIF0sM/qQZ76f+UmSaZGv8aGKPlt9DJoT3ufKOX/3DM2vqxdL8+SccKp//Zswnp3B8UPsP6TkumwAwQsUwFoYO/pt5KQZMO5Dkvujmwh15meOHnez6y38tXj99pNv1wWnHJlD4/2C7+IuSNforfiZiH1k0dE2zsP/cyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFLLCnYtXjP7ElUcOZbc3PjaIlKWvS6oivkiqxXXD/A=;
 b=bZy369gyBBRR4sJqOWl8/EYWEl98/uJLugELyIIT2igevRifq1Bt2KkUt+d9Dym2Gq7a2KwHN/pw7BVtp68IgFtX8g2ACp0kyxcIPETbDsN/UlKM5er4y/kZRRYg6MWl4d7Ni6Qc4kjAbdy6ZNBmohKhUrTzu6n++9CynRK7hmge+FzN+VZ/3aCuDkQIV+LQ/5fvy2m5DOs5Bax9gKX1O/ipM8NPKvOf7RZzc6/KtJV2lVL6uDvvroLDRvW+izkTZGnea4AAAKs29wbUHkLf8zbRSlpQX1RGMu9EIiia1RkTvW454pCxNKWens9xEMTefolPHg9WYQLICk8VF/RrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFLLCnYtXjP7ElUcOZbc3PjaIlKWvS6oivkiqxXXD/A=;
 b=KRZslLpFvRzHft/dDstx2UHJrAtN9Sr0iA8sCMzqWeaHYylo/4v8Zb16jj/3/Bk5vFzRIqxn9pU475vbYqvN+8BdULaSWWOFybKy8xj7mhbm/4+XWkXHK2denYcVmPBh1HcC8o2Wn145iHWcWfjc6MdJUhyJPHvqKhBPgBhxOPA=
Received: from CH0PR04CA0032.namprd04.prod.outlook.com (2603:10b6:610:77::7)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 11:45:14 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::85) by CH0PR04CA0032.outlook.office365.com
 (2603:10b6:610:77::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Tue, 26 Dec 2023 11:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 11:45:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 05:45:07 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 26 Dec 2023 05:45:05 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <lukma@denx.de>, <git@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v9 2/8] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Tue, 26 Dec 2023 17:14:47 +0530
Message-ID: <20231226114453.577589-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
References: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 070fcc86-c045-49dc-6928-08dc06081f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMjyq7OEwUeG/r1ck09W53q/A+i/dl9KJwY8BkfgKQtQcdC6Eop+HaPCf34hBOsbbewQ8Z77PtdSqcia2sr1Pn42DROnc/51WCTJsjwnq/CK66jDRVgOidtWkc747cC6l1Yg/zSIizMJfZiskzgc17cIbWoTJE7Gs20ra9C2JoIihUMI64kgF6CJlh8zCs6CszGJ1J5rxRxWZ6ghbBpDo+ThdJm2rgmrG8KKUxuaYkktR4UTfXWdD1ItjmoIhm/VhFVQS8G7qFYsaLO8awpGKwYQ7R0JjDO/v6haR7vL1iJp3I2125cp7RvC8sHAqoRS9GnwOUnpb3zkCMQRwrK3No3T9byZnLIGHZSnyEXBV1YVBbqTtk8YW8BoX4Fj2zWUYngRFGjsXWr55q3ekpUXoDVp0pd3C1h3aeNTtYFWswPc8dn+fPUR/lo2Agypn4uVWcn1yV+6B1mWIzxIfHo9bSMOqSbNnQ81HIwJskyQyQV8B8ed7aZLymj2jeF1Vp9AUpyjiZSbEFmXEokShoU2DyEkJNhXz5WPjaKzHbea5CqhnwiF1gVkAgwZr85yk6mlptTec5rZPSbfPhB2maym4uuUJTYFLksFQQ1FSxS2zMf1EP6mD7mMymWS7vYfrElOFcwUvKo9jA/RkEimbVjjmJnTwCt3eE9aToSm79ugZ1f/MydOOFRY1x3vl25qeS7q+uAAr8dOMoLX90lw9hNWPejJj5JouRgC4gvY/aziPrN+lpE1Gsl+8x8IBZWi+MkF7WkkEjptcYCeSXUx/TzI+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(316002)(8936002)(8676002)(6666004)(478600001)(36756003)(86362001)(1076003)(26005)(2616005)(81166007)(356005)(36860700001)(82740400003)(83380400001)(426003)(336012)(47076005)(41300700001)(54906003)(6916009)(70586007)(5660300002)(40480700001)(2906002)(70206006)(4326008)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 11:45:13.6410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070fcc86-c045-49dc-6928-08dc06081f77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

Add support for parallel memories flash configuration in read status
register and read flag status register functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 50 ++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 9d72dff85e..6d1bd4d54a 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -438,8 +438,9 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 }
 
 /*
- * Read the status register, returning its value in the location
- * Return the status register value.
+ * Return the status register value. If the chip is parallel, then the
+ * read will be striped, so we should read 2 bytes to get the sr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_sr(struct spi_nor *nor)
@@ -471,18 +472,29 @@ static int read_sr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading SR\n", (int)ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] |= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
- * Read the flag status register, returning its value in the location
- * Return the status register value.
+ * Return the flag status register value. If the chip is parallel, then
+ * the read will be striped, so we should read 2 bytes to get the fsr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_fsr(struct spi_nor *nor)
@@ -514,13 +526,23 @@ static int read_fsr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading FSR\n", ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] &= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading FSR\n", ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
-- 
2.25.1

