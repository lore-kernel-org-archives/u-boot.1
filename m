Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E41FC10DC1
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E8A8787B;
	Wed,  6 Dec 2023 10:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lUFJGthE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB2B86CF4; Wed,  6 Dec 2023 10:33:43 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE19D8787B
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djHFUU5ERgcOfNL6kYdq3vq7+L/2Fjzd1yoX0VqSPfZh8pOffRgde2Kz1XLf8IeBWV2VGf5095LJKTe4suoq8e+r8uYYiV0TnAbai+I8wa2oDvRHXDs9Va7PzIfl0Y/Z1//M5hyIxbP+qwhyw1W/OocXw673+ogufA3crFAuUQYxu2X1y15M9/DX041NavafZ1K/Hwz2WIXfsFvNjfD4UDtz2K9nPji/m3jM0cjQUfj17rScQivfav1FP9tNvlt9Sro0tTiml+f0mXB7TWG4Z4NgESWC0z8MM2fzbWH9w3pKqoyFyO2t9DmFXc6MIym/epEG9RQNIbOcwc3p8UgiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0XUqSqybeRAgvEfeu9FIEziBIIS85pKuAEThLv90wk=;
 b=WH63s2BAlO8cshNAcZ0/gTzf4CxXqjpsJRV9iFoHX8k+bV6nubK79ZeSjcYNraGhK3u57RLcyqmhhieoqaw8uUmiY81jm4lCcYOx1Z+pjco2QZ6niFIU6/ZybHhDqzYx7pJV7MVjGCKQOIoWsiPFE+6jFkr5D01VCRaRcOuc/hTpGzcTBO4CD63gOUQJeSGGjhFwLEXItJNfKhY4F7KebtnHvalhuCmfTwkoBLgxk/DrL7hnRubHmarecuv3rfYSIWch3USq+0EPGgnOu9mOmBtRLJPQiUvUTM8SZ5ttnzaQChZMYxf8uLGnkVuIYrKSN1n8YEqTT7VvwBPI69cgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0XUqSqybeRAgvEfeu9FIEziBIIS85pKuAEThLv90wk=;
 b=lUFJGthEPulvvgscfHlbUVRQmZ1XgU8XslRH6Edh21TCzw1TNMwEHHLyrB5HteR2SUHoNJW4r8a1XK5xfqjIwmeH/VMSickbvtovZ2uEFWw8EEYLmkmZyf3OkQdcskEZG6v1/+D0HFWtydwR3AXdyMBUVWLYEDZKu6jeLYq3pcg=
Received: from DM6PR07CA0074.namprd07.prod.outlook.com (2603:10b6:5:337::7) by
 IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:33:37 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::7a) by DM6PR07CA0074.outlook.office365.com
 (2603:10b6:5:337::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:36 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:34 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 23/30] spi: cadence_qspi: Write aligned byte length to
 ahbbase
Date: Wed, 6 Dec 2023 15:01:34 +0530
Message-ID: <4ee70ae802be4841b64c7f64d9b3a4538e110869.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: b816dde3-e6a5-418a-e4d3-08dbf63e6cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XO0y225h5YmqBt1o2W4lU/WMMHJoK24SyqAYQ0322OzIaFuNwCAZ2oV4KGF7bPPnqmXxXsKN5PSIGVxJutGXDYhGgmF6pwW1WVG9XEWa2EkkiE0DcyebF9HH7FCqzJKFd4ACda2iHn6Y8X5fPJfDyYNwH7/Tc698XTVPbEX6im6jLgb2GmOYxxgohceWwag3Wxj96xqJXbZyg8fTm5wBZE5Tgt0KrYo7ld0k5iQVsnSLUYOQpteB8B9ikOhEooTKoy9X0nJBrnseLPOc8eHdkO7dqzPqungk8qEqszdKDqVO0RM2TVPJROUscbi+X8KEENQx4RFjFOgzpw7sUxnK2BIQRCjyIFTjdEo9pdXZ9B6H17eWp+R617GYyd0Yr3aupxoWlTM05XF0KkaOmy+qR2Sv9q86d30Oi+yEVPOMoI8i1N/zd0yuByc6eDbvWekNufu1a2vyiGA2E1sx9h5d/lM3h2bCUegVBeT2KaFdy/GTKY1SiVvq9EwgoVAgws1zS1/LsTP1+EYd7w9G26nORuvRc5LRtBNI1JuVwHbrydt2Vt33AgD0xA3uHb1hoUq6Qvu09vsRtr/otrXERzJqnAnOK7SveggSlOfYZoVVd/6pn7wZo6xc9wREnRL+KoqHJw7eJm+OHzNY+vIy/HSsrRFGGQmTc6vGAmqNZERT+Kqq6eZ13yKK0cgbWTHiuO6F+KXWuV92qi4kDYts68W1eMLHYAzQiBObqGCARytGpHn/IdAs7g5dZ1b4YecWUlcsOy1lzExk6W8z0sI5xTXzMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(40460700003)(5660300002)(82740400003)(2906002)(36756003)(41300700001)(86362001)(478600001)(40480700001)(36860700001)(83380400001)(2616005)(26005)(47076005)(336012)(426003)(8676002)(4326008)(6916009)(8936002)(81166007)(70206006)(70586007)(356005)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:37.5065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b816dde3-e6a5-418a-e4d3-08dbf63e6cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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

Incase of non-aligned length of flash data, ahbbase address is written
directly with byte count. This is causing AHB bus error's sometimes and
resulting in kernel crash while booting linux. To avoid this write 4 byte
aligned byte count to ahbbase address.

Also use a temporary variable with 0xffffffff data and overwrite this
temp with unaligned bytes data before writing to ahbbase.

The value 0xffffffff is chosen as this is flash memory, worst case we
will write 0xff to any location which doesn't effect any bits.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 43dc4c6e70..1d0e6c2180 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -934,10 +934,12 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	while (remaining > 0) {
 		write_bytes = remaining > page_size ? page_size : remaining;
 		writesl(priv->ahbbase, bb_txbuf, write_bytes >> 2);
-		if (write_bytes % 4)
-			writesb(priv->ahbbase,
-				bb_txbuf + rounddown(write_bytes, 4),
-				write_bytes % 4);
+		if (write_bytes % 4) {
+			unsigned int temp = 0xffffffff;
+
+			memcpy(&temp, bb_txbuf + rounddown(write_bytes, 4), write_bytes % 4);
+			writel(temp, priv->ahbbase);
+		}
 
 		/* Wait up to Indirect Operation Complete bit to set */
 		ret = readl_poll_timeout(priv->regbase + CQSPI_REG_IRQSTATUS, cr,
-- 
2.27.0

