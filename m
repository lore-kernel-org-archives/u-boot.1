Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9821BC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 06:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE8F87F8D;
	Mon,  8 Apr 2024 08:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=in.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=in.bosch.com header.i=@in.bosch.com header.b="A85vWRr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62FA87FA3; Mon,  8 Apr 2024 08:02:07 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37DD287DCA
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 08:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=in.bosch.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Gireesh.Hiremath@in.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kqg7oiwBClLo5iWoV7s1yA7vRTOGAikgxitjc/Q+ICgxvWn76KdD/ZOnkVBgnksiN99IF4qulnrFiZQuViRecXSk7IJ7M8tQ+f/wZq0oAUVosLBLK2Q3PgKHURygdQ6SfNfjtbnw3dvgjxQ/h5uMtU3D1ee538YCvol+CwWVapu7cHUUczq9Nci8WQoKLAxymEZ+9Zh0gBkgzfEqP7tyl6oZ7PmrMCi2qAvxWsBYvsFmLNFDtvcv4p02I2hcBPw1xQd2b7eqRvMXYVtw5EOF7XQFgeNUabq1Pl3WG7PdYevu9eLJbAQd+zqk1ks9Foh4pEMEPlEJu1gGbQQgEA4KnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W22zPQXMTG40IV3BeGwAmWHf3cakHoydyPMCcW0u4iI=;
 b=Nq48bFSArBhMG9GD2xvilDdSp5jh8iJhPMCvdvz6H3+OGNaIhA3k089m+4JQoU2lPSRgTbBDl/5SKq+Cw9Pds2UpNoyMYItVbmn3OioO9B8nMqC/4yBjDwsaEOs0I9Ljumzm7tkqq8bHFBEtToMJn1alCScJSYPERvIC2jvF6JxY6Rn3DIopJI0Mm/N8AqGQat0Ami0KgpcmY6r+aULTrnSQGivdPip969ARFFY8AqUa7jllL2eqq6qgVThntMLhilpr8IZ2ZtHnM0kLfsz+fPIrbWpyIhZ3Io7QQcC3ou17fAu6n2jyYP/0Oshs9B102ztfkvMGwOQJdBKzSBGtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=collabora.co.uk smtp.mailfrom=in.bosch.com; 
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W22zPQXMTG40IV3BeGwAmWHf3cakHoydyPMCcW0u4iI=;
 b=A85vWRr2ZbijF7sSZqxctAO8lPVDO6qMspkliw7AiITldL/I/laNOskYM2DGXF9rG+cO6GdPPjHjywmilRULmOXdGELItilU8iA8bgDuQBiUBMJsnr+fI5PNdo9Qul4wOXP38CNW8MFrWVETQhaBNJhM6abf8G6mM360xr3qP9WkbCAWBAtNd3VXxi4L9Cpn1CNKyC5bi+huJMTWNW7Hf2fdF6xtObiaRY9+ggbPqlkbJindxT1NtaO9rF3FaI6WfHtOibd5GsoqWF9LvzvKMK7eYJ4LdoXIOPC7tgLLeHi/BNyCsz5qS82SAIwzntyHaoXNOI91nir966pkCZompg==
Received: from AM0PR10CA0095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::48)
 by AS8PR10MB5808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:523::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 06:02:01 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:208:15:cafe::8) by AM0PR10CA0095.outlook.office365.com
 (2603:10a6:208:15::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 06:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.206 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 06:02:01 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 08:01:48 +0200
Received: from BANO-V-0001F.kor.apac.bosch.com (10.139.217.196) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Mon, 8 Apr 2024 08:01:46 +0200
From: <Gireesh.Hiremath@in.bosch.com>
To: <Gireesh.Hiremath@in.bosch.com>, <sjoerd.simons@collabora.co.uk>,
 <Govindaraji.Sivanantham@in.bosch.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <martyn.welch@collabora.com>, <u-boot@lists.denx.de>
CC: <VinayKumar.Shettar@in.bosch.com>, <anaclaudia.dias@de.bosch.com>
Subject: [PATCH] configs: am335x_guardian: store boot count in AM3352 RTC block
Date: Mon, 8 Apr 2024 11:31:19 +0530
Message-ID: <20240408060119.3675-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.139.217.196]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS8PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 43651ef8-8d36-45b3-fac7-08dc57916890
X-LD-Processed: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IhTxGSIQnnwyJhgUxAFg6HbCplLV9b5C3sNNhqa3DLXGgOchZPAfPumIeeO3JsKYrLtJXpwMxe22H1j8yL2v6wcTj0RYd5v5r24gnKPMhYI1oCMRMWQfraPoQtZ+wznD0dp7ir5K88Ke2IbEIsvrob0lL4/OB3fS4sc5my4bOB6bkrzqlatFRSWSIFiStB8FFiciFgT+vnisjIEpbRlfI6IRVGXwnj+QSuCat+k05quDir2m9PJYL8SQXVNzGZHHYg2ui7gA4p2r5g4BSiRQ1eWsL+9OaL06kl9RscdzqhlmWsjNu+keri9/d2T2FCN1qEtN0XBIIveyWLEvy1ehACPm3g5fKTYJsV0X1ZeZk6vu5LRE2skZSA+nu4EczZ4JWvqsfcttfjiz+3FToPx/laEPjRO7QpBfOagZuFZ83Ed/8zEk+0rAzFBgYhOMFsCSFUZr7ak45wxtSAnyCd6ITmiBbAovSY1LVlpZNLqWzT1VOnfv2kIlUlT7LkwcC5YLW/aWb8zPQOz5jxWPaN4f5hxyolEPEURcf+mo8K8w+DvPAVaT/TKfdaeWCsCprDh9seAAIz18XmhcVBCKNlsBJ/IVL0cw1kOAvPwauVt0bDT/8hKf5Tc2l7itMAg5FiORS8zCOQ68rwpgWfKOpkt5LZmjEJZ1A3a2xnmP2kFDIDDyS4eFAwjooJ6l+j7JGZHtKdWl5EAGETjmQ6gbyClhDYuMz3GeJWMq+pgATBLIGEyeZ1G7kDJCsiEHUEnnJxD
X-Forefront-Antispam-Report: CIP:139.15.153.206; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 06:02:01.5192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43651ef8-8d36-45b3-fac7-08dc57916890
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.206];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5808
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

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

store bootcount in RTC block scratch register

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 configs/am335x_guardian_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index 75138542431..abbbb03d33d 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -16,6 +16,7 @@ CONFIG_AM335X_USB1=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
+CONFIG_SYS_BOOTCOUNT_ADDR=0x44E3E000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x540000
 CONFIG_SPL_LIBDISK_SUPPORT=y
-- 
2.30.2

