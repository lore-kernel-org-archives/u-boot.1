Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61B3C2FC2E
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4071A86B60;
	Thu, 17 Aug 2023 15:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="qUuvG8xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 744D786B84; Thu, 17 Aug 2023 15:47:13 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB8886AEE
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thomas.Mittelstaedt@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyG/Z6dZz5PXwlg1QfcxQb5reP2xQbhZKsg5ZbvuT5qqf5FWT/o7lzmHqPuZFoQsCYk1Xh9fETmTExuBppP66yel31UoM5T3oY/TMVuL1uHUOFHpvDkNL1lDblryrqNFarj4pHK68/9bQYm993Wtb306HikspP9xUejWfpCss5DrVnEaR45/FWW/xIX0tOzNOFRQ6Xv3VT3f9lSjEnT2XKgx5zIAHiXnYCEfGiGf1/TOSyGjoowtY4scnivZKzTlJ7EBnylsBLPWPyHpHZmvc+D5P/BmO4rDjoFVXe8uVjpEgCo0QOxeYpoDuBi6xdSF/m5XPmnRUGEIh6w6+S0iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAtGPEZ+RRB0AOxOmAVZItkExH0oCtpeD91LQ1WN5P8=;
 b=d9rLb58Gi+yIMUzqirOL8bVjab0X1RD10w5pGoDVGlBH9+PiGR3ybpHt73YvzBHIFSZMHdEKdBvFgBVv2dW46qwUfJ5Ei29+W2WKhRVn4xBm0Ay7mBbPeudHeGtO7m7+FHh4x9mJKtCsilhUXC2XEnt6fUf1gZYCaD2OQXbvp+qK/fKRw/+RWhHhyl3W6e3NzNUyC7Ui/3kHlnLsADb7oWlL+pyugUJT6bdZi3LB9zGMIkkXggttu5PSNLcdkcOwlxOEUGnFw7MPTjysQFmFeA5B6BrtqUqPwEG2pCJgrckx7Qm2XYEQsv4e9W0MqWheE75fjHre6b+1esdxqOBCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAtGPEZ+RRB0AOxOmAVZItkExH0oCtpeD91LQ1WN5P8=;
 b=qUuvG8xcut/IvYqHpBHBHFnmNAhPmKCdroM0Fkc3wxI9xPy+Yjp5q+vYavwrB3LUtJBqDxpo3VEm8u40A6HNi8RHrGX0mU1SGEDLFJA99D0IovrQJfwLXZImpZhucHhTVg5ntfALBuLPI0rsTw7J9kWhpoxywLvAMETQDvlHTgDsazjF6O+6elMOslFEVyanqD1iI0QDGALd/eysyK1bEXaJdtygYR5t3wLAAXisWQmIqqSxWtTzwuKGfWrGdpQeMue9Fo4GerE7iNt1l9GzZuiLQPyotUPR9cqpVlmhOQXxTYPqpN8j7qmaT2XvYmwHIi6/5mvXANgHWa6sM1Gniw==
Received: from DU2PR04CA0082.eurprd04.prod.outlook.com (2603:10a6:10:232::27)
 by DU0PR10MB5432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 13:47:09 +0000
Received: from DBAEUR03FT065.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::2d) by DU2PR04CA0082.outlook.office365.com
 (2603:10a6:10:232::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 13:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.201 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.201; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.201) by
 DBAEUR03FT065.mail.protection.outlook.com (100.127.142.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.17 via Frontend Transport; Thu, 17 Aug 2023 13:47:09 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 15:47:08 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Thu, 17 Aug 2023 15:47:08 +0200
Received: from localhost.localdomain (10.141.98.21) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.2507.31;
 Thu, 17 Aug 2023 15:47:08 +0200
From: <thomas.mittelstaedt@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 0/1] *** Documentation to set up U-Boot with VirtualBox ***
Date: Thu, 17 Aug 2023 13:46:46 +0000
Message-ID: <20230817134647.49259-1-thomas.mittelstaedt@de.bosch.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.141.98.21]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT065:EE_|DU0PR10MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0b1264-10da-48e1-acdd-08db9f2873b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ovNwmr1U3Cux5GvdqA0Z7st1rAzz+nxHQvbIrrFTJnnp/TrqCaO+D9h/w7sPkDDv1OGrlvBK8TVvN+WSCLrusjXylFYfN6/dHBck9VQ5aebURg3Zp6SaK+fUc9T1GSWq3gtAFvsJg1pmWrJ5y9vyfpVPwgT5Cl1WkV23eZjdhHwPmMQkxY7YklAcA6RnyMdQv1EYAnlYQlWTU/sb6QHxmpLf6kQ6TU3en0K3LWAT9/bFbkMD9xifcin5Og+t/Lco4i+HrTgGHRoBalXOHBKo082YqEUcv6qKIp6Ddwx+JCSC41hmwRhC9CGEbqMcA1P/eNu/U2YrxV86cmSRI57VoZB8iduH24Pf0QsL6Ykaaw+zAc6JIvtr+24HuXYURxxR4buyc6+MdVwr02h+xHQKKcb2n0hOhHs0s8ZQriEAdmhT3FyaPQG7DT3XCKRBrSVROZHi8G4SZlHp/PcdX0RuTWNi146kh1OQyREvKrxF6V/t16jDoOCEnGKsuNDB3M4/0ka/BASp2XDoZmKPWUeO7ubCq4rh0pmxOsaW4ANvuTijDYpAw27mFQaa/JODgJ/IrceTMxPYPFXfaOQ6HSVGYbQbO+SHrMXDwUa0z+0SJSkAN/iO4t6e+qQE4q1cH8++mblCzusEo/XddjECxH3vzicjtaLBsgwljsVSHIbwSygrbyl/N+7pvo5mwabnLBMl+ly1+kMhynbPClJldy2RrWKJWAUBs3x8YFCjCCuhFefA08Aw2GDvbhG+OmX0RnomZO8bEFSoGv4/LAzN5t9AB8pL+lEOvWUTB2DUN464tUA9TH7fyOZ7/4oJxYlriUD
X-Forefront-Antispam-Report: CIP:139.15.153.201; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(2906002)(47076005)(2876002)(426003)(4744005)(36860700001)(336012)(478600001)(6916009)(70586007)(70206006)(54906003)(316002)(6666004)(2616005)(16526019)(5660300002)(1076003)(26005)(4326008)(8676002)(41300700001)(8936002)(86362001)(81166007)(82740400003)(82960400001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:47:09.0601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0b1264-10da-48e1-acdd-08db9f2873b5
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.201];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT065.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5432
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

From: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>

This documentation explains concrete steps to install and run U-Boot at VirtualBox with x86 images.

Thomas Mittelstaedt (1):
  Documentation extended with specific information for VirtualBox

 doc/develop/uefi/u-boot_on_efi.rst | 76 ++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

-- 
2.30.2

