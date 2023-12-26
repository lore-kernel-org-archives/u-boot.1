Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E32BC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 13:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8378796E;
	Tue, 26 Dec 2023 14:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HoXQt+3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E888795F; Tue, 26 Dec 2023 14:58:07 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A647878D7
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 14:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiWm1n2tyqN1WOsPLlP/CgrKphtR7ytEb1i6iXZ44tVbxc1WLTZUwUH1pLbzMas+Xsew0ZcADOt27NPDCnNRi5CZLuiiJO7C6jMfc7fd6yjj7rjUAXPQFPywpRzjBnW5/UXHwKaPy3g/giNdL6rfW65zdJIBFlPHpVUmgnylJQRzU50E96dYhIXHp0tNgByBwyuR1vmYeNHx0OUDCOuokMJqJLvqZjn72RURCeCuKG7eadncxZQd/XePhiEYOHjXOukX3ONK5UpQ4/J2JiCXOB3zWdRkmAKCRlaSAIIzaA9C0/H8Bq5/Z8N961HosAqdk3WbzzZ38Xwjc3qH6cZg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPKuRCw8CD40DrnZnmAY1/1DU/wSfNvhb6f1lBhuCkM=;
 b=TEQ9CktOOVohj3azrGA6u1iASOoMUTZUft6GR44NnH5pZJSSa3zvTPARUwKv2NLOz46nScGXnRvLGF69qobg6HF7gd8nsSgns76skhdf47xm26r/aSv9UCJ34d3q+5A73u409UeSVpBPkRZyH7FrEIF8d4eCO4PqpCZhRfBWUvgPZpSCzEoGKP4HCFkMl5A7cnwpZyCFpIMOISccibics5ouDgn8yhN/JLaXD76VgTrNf/gz/YS5Lkb4sJedAOLnnKDSVVRFlm41zOTuSZ7lCVnWduoZ8C9YcZTZwvyJ2lwKWPx4/EqQzneVNHKohEc9EzywmB3M0Ucfoi3bKCtmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPKuRCw8CD40DrnZnmAY1/1DU/wSfNvhb6f1lBhuCkM=;
 b=HoXQt+3eE/VrRxtCy+IvmTQNEyb1c6zAzhkGb9igtGCOxNL8ZkUGVSy33wwOhLqfc95rPivjISGaiU/lFNQq5AT9MogFl0/y2eLbZ3XdBGJ8bWSKcwP+oRTfognFiBIeVOR/tDFgMXS4uGvNixP6aC1SocXjn+KFv2YostO8s+o=
Received: from CH0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:610:77::28)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.27; Tue, 26 Dec 2023 11:45:20 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::3) by CH0PR04CA0053.outlook.office365.com
 (2603:10b6:610:77::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18 via Frontend
 Transport; Tue, 26 Dec 2023 11:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 11:45:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 05:45:19 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 26 Dec 2023 05:45:17 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <lukma@denx.de>, <git@xilinx.com>
Subject: [PATCH v9 7/8] config: xea: Enable the SPL_FIT config option
Date: Tue, 26 Dec 2023 17:14:52 +0530
Message-ID: <20231226114453.577589-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
References: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DM8PR12MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: e83cbd06-ed30-417a-b4e0-08dc06082359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzEG5MLJ/iwR1zWaZYk56CulKbks7VPs5dfjTBGJ0clm/KY63pVct4dVhU2rhydsGWkCJmp/AVEGhOivQN0c2JmITO60dm1sZpXhzj357my/wQuHywQzYVmEY1clsoRhTmWD7Xc3peMpMJrmgwYvzi390Alj75RvPA05U7ydrO6Iahm9F7VuDnQs4Po1YqfD6gbnlOowlh1igxxwxUftfkzJTFolyYDlfG8tL2ldaSh7GfuSmn+BYY9DD4lJmAvvKND45BiA88wmVLhyzjy/JeNX1Nwilkfw6hadYuwOW3s9mBUAnWGI5umMLXeKoCUtklOW5YsjC/hCOCnsalk+uHCh0Pk8oE8HHeR5mBtHcYtA+cSs1kmQA4tGYt/myzsXaY7/JHLXn8yQW0wBXWcTTlADi1KQMxeg2WFTegmX6u6IJEYUEWnDSzHZadETxn4S3KiZdFs4ZBzR0zjKZ3OLgIBp4F0jtfUeUcEcmBHWZdVDjFUJOTJXX+R4eX1E6eNSHY5YuIhPcqhG27VnlAQLGIMQLRktXSWNqVN3X+xwDWym7yS3uSlKEAmI2wbG8hGD3SJ5P7lnziKzSVNDgC+jTGr0SXUAJO6/8FmxE42rVKT3oci6kuoSdSwTb2HWipsG1uXHqZAaLI4iWDu//7y2i2Q4nenI+6Vy59gIQT/qBdosujaWqBRA3Wn/pV3IYCIXdQgtyZ/dc2zIbZ6k9K9OUHAOb+PkELQuNqE4n03aF+Aq0s2cae8YofQA7CquBZj5BnuGI0aRTL75awp0ReHsuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(316002)(8936002)(8676002)(6666004)(478600001)(36756003)(86362001)(1076003)(107886003)(2616005)(26005)(36860700001)(356005)(81166007)(82740400003)(83380400001)(336012)(426003)(41300700001)(54906003)(47076005)(6916009)(70586007)(70206006)(5660300002)(40480700001)(2906002)(4744005)(4326008)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 11:45:20.1573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83cbd06-ed30-417a-b4e0-08dc06082359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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

Enable the config SPL_FIT, as getting the below error
../arm-xilinx-linux-gnueabi-ld.bfd.real: drivers/core/ofnode.o: in function
`ofnode_get_property':
/u-boot/drivers/core/ofnode.c:1185: undefined reference to `fdt_getprop'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/imx28_xea_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index c1b0487f7e..882b6093c9 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -29,6 +29,7 @@ CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SPL_PAYLOAD="u-boot.img"
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
+CONFIG_SPL_FIT=y
 # CONFIG_BOOTMETH_EXTLINUX is not set
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_OF_BOARD_SETUP=y
@@ -123,4 +124,3 @@ CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MXS_SPI=y
-# CONFIG_SPL_OF_LIBFDT is not set
-- 
2.25.1

