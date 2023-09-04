Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE29AC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3695F86945;
	Mon,  4 Sep 2023 15:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eNXs5lxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F0B86828; Mon,  4 Sep 2023 05:16:08 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C8286867
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9LvRTi8fZA8Z6JIBQsxHufOFqiFVKiBy9Ziu+RKPhjtbo6BN4sVemgfUFqVbpE1wWQE7OmHquY6db9YbNLgiVDkr8DXGZrP1LSZ/N3GKQ/TGOx/rWLlWWCYQr8/8W6BFEcDhcdpo2098tqI5Rw8V/Ypf2x2NDjyEVPrzZs6K1KIXkzmymk3GwbSIWyEUEjkUvxyMLFsDidzlxluNuiDOfcHsGZOb4l99TjuW+mJGOQxMdTo7uVHHll0tq5WeMqS7i6cBxTQzr2J9xPoDvPHmBMyaszIrkNeivzLyPdsg4yFVN7zKpSoKNO/oFxTEgrTI2UtjrFuZTqTP8mURwnf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+wph8x7VAhJKDi6b5Ei7ZgGQr83UMRAVQiizz9iM0E=;
 b=kWAm5vM2O0wfMlsydDu7dk3DLdwV3Ps4OOWNkao7bCXUJAvOFPzw4NfFu6EWtgPa6pyjgNF7tOLRWRXl1h8p/iIgGeRxs2VXwvpj1fu+chDdZJqOD38Y1qZ6SkVFR1LgJXAjgMa6L4MiveokkJM4QzltZkHrb1x/BnsV5DKpHyBmS2HR7zy0VS4tts0ah7j8JRtgaOx4jc6/JaS4Da9y7/fWDI0CnlQuq3k8JTqFAwNW3R4grmb85qtAYvBIEo3k9Jt6vv0NiLYDj4OSXpcwma7TvfUjRiLHMB2OzsbZnaatZ4v1BCaIgVXAMC4k/Lp80OrcqETh6SBCbSMfc5ShhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+wph8x7VAhJKDi6b5Ei7ZgGQr83UMRAVQiizz9iM0E=;
 b=eNXs5lxaa4WVKYjI7aSgWyA1nnrcMVfpINy+1ZNLsA0yyBj9qfkqwAHPCEgkJWbPSF8phsgpZ48SgQDXTkTSAvy81dA8tqEFnH1qkLg3HkBeAMj0VxEBspPKWYNwj14M0TcnYpt3w6WGJ4822oQkujvEAWfyqyCPDcrMVucJc6k=
Received: from CH0PR03CA0427.namprd03.prod.outlook.com (2603:10b6:610:10e::30)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 03:16:00 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:10e:cafe::dd) by CH0PR03CA0427.outlook.office365.com
 (2603:10b6:610:10e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30 via Frontend
 Transport; Mon, 4 Sep 2023 03:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 03:16:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:15:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:15:42 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Sun, 3 Sep 2023 22:15:39 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <rfried.dev@gmail.com>,
 <seanedmond@microsoft.com>, <tobias@waldekranz.com>, <sr@denx.de>,
 <john@metanate.com>, <git@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 1/2] cmd: thordown: Add proper dependency for
 CMD_THOR_DOWNLOAD
Date: Mon, 4 Sep 2023 08:45:27 +0530
Message-ID: <20230904031528.11817-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
References: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: d5689488-504a-4fba-e19e-08dbacf543cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bk+rlt0sPsCuYiBi0nnMJZRuRhsn5lBpqV02xDIG/zqeE4UwC34zRWnQ3s/0OHe4lfE7Pl/yYNyd1xYom2EnaPQHLRmjtnmB0DsnR1xa5AFq0FTT15y9fOH0zWcGPX+xlqZJwNXyy5MIVrDwztLGvgNyOf8w+U4FKs4cdiuPCH+nypvsIsfHQ/ujE5XXY0F7FxSsTlB55lADPI/JXpZsDhJumkaOg0AlA8DJ0BMRmC04zS8SBCWKGwHm2rE25zNJw147Wtw/oLml2V5TESPKdKLFia+g56zEWWI8Tz6MaA+ThylMHA0D1RdWOCo9HnZvqgaMp1RlHlQyYlnJaMXvAaDPgfMm4zkkdsSKGd8cY9p4wkNCB+ol5gsNiELpGVr86Mf/xF68okHNpaMkn1z3MkvJDhrDncT84cxUbigymnFhjupRaMwszRRGHS/j9TKAgLlOOrm/Q4b0+z1z6w10OXUuGqfrBUnvCOl/0zy5sGA3yt/4CcE80PPcNtSHmiS6mRnyKjrSc73GkjJ8pI97Qo+lBjEGewcD1Esr7sHL++BcNp5DAUiPlPGeoCGfz5E/8UHSn3ydfuA19mIlNMk84PQ+DP8RKZ88WuFgayg6OxMkGBxM2W8xLf/qjHLU9UEwn+6wcU1wkbC8jIUjHOsZe/YBkKBqkwQrACY95ubndME9FiIJW11EY15Un/6E+40+jdvKhxgFQR0VqoXChuST1wDSRRJrvoLn2ZTIiYhOL9lZ0Ds9N8T/U+KGyBLqn289lf596rESU2fxWBa39Y6itQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(70206006)(70586007)(2906002)(36756003)(54906003)(86362001)(316002)(6916009)(40480700001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(40460700003)(1076003)(47076005)(2616005)(83380400001)(426003)(336012)(26005)(36860700001)(478600001)(81166007)(356005)(82740400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 03:16:00.6806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5689488-504a-4fba-e19e-08dbacf543cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
X-Mailman-Approved-At: Mon, 04 Sep 2023 15:58:13 +0200
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

When CONFIG_CMD_USB and CONFIG_USB are disabled some compilation errors are seen as below.

cmd/thordown.o: in function `usb_gadget_initialize':
include/linux/usb/gadget.h:981: undefined reference to `board_usb_init'
cmd/thordown.o: in function `do_thor_down':
cmd/thordown.c:68: undefined reference to `g_dnl_unregister'
cmd/thordown.o: in function `usb_gadget_release':
include/linux/usb/gadget.h:986: undefined reference to `board_usb_cleanup'
cmd/thordown.o: in function `do_thor_down':
cmd/thordown.c:41: undefined reference to `g_dnl_register'
cmd/thordown.c:48: undefined reference to `thor_init'
cmd/thordown.c:56: undefined reference to `thor_handle'
gnu/aarch64/lin/aarch64-linux/bin/aarch64-linux-gnu-ld.bfd: line 4:  8485
Segmentation fault      (core dumped) $CC --sysroot=$LIBC
--no-warn-rwx-segment "$@"
Makefile:1779: recipe for target 'u-boot' failed
make: *** [u-boot] Error 139
make: *** Deleting file 'u-boot'

Add dependency of USB_GADGET_DOWNLOAD for CONFIG_CMD_THOR_DOWNLOAD to fix the errors.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 cmd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43ca10f69c..ac58000eb3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -544,6 +544,8 @@ config CMD_SPL_WRITE_SIZE
 config CMD_THOR_DOWNLOAD
 	bool "thor - TIZEN 'thor' download"
 	select DFU
+	select USB_FUNCTION_THOR
+	depends on USB_GADGET_DOWNLOAD
 	help
 	  Implements the 'thor' download protocol. This is a way of
 	  downloading a software update over USB from an attached host.
-- 
2.17.1

