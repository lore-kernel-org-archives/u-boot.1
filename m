Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E22BC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60D18796E;
	Fri, 12 Jan 2024 07:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dJPnH29Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C14C87971; Fri, 12 Jan 2024 07:11:56 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A938796B
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Olejuj2BIcg/Uro8xiSni0h2AiVDA4UxnitZ4djZvIZ/hVTnAhDqDSLeT8A7TRgqWQKPAs0joJkJYnPyA/MMxHg3exwdW1dNsltLxGouIgAj1BL4YzqckKCj2PIdQrt3hn2t1YU95Syok8JD9vxQKoDba5LJq8cVRO1OrnIUityafngrsiO0VJIinwM2AGmzMszQKdmjGgBmJv8kUl1X0C9k5SylCIVqj6mh5fMklRw+uQC4wOOBmCY0KWP4uOFS/q6GnsSjcMyZNXpZVdiO0Mos0CpYo2d4TQw81+XN3tkIposqxMaSKIgrgbWvSp6ph/AkJen7PIfT2fc8tzJ0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV9O/34pOrZZxnJvnDEnTUvFMO8cRaqdgiV4pp/Td/o=;
 b=JA8XToGX33ZD3liVXaAjXFrlxxu5AhTrUW9WVDsY06GkLM0YcjI/GFsbt9ErccGDlwcU7ecH3O2QF18KpqFEDRB37BQsT/A7SbimUO8xYod+tIO8ez5dcH9UzHwHTGfoV6c6BIlbYUDUAPqGycnSTzphi8RtHP7jKZA6aEJVSo7P3iU54VunGLMc3bgFYe1OGFK2iWCg2u4sc9G402+eY7/iQ9OUcWhm4wRTShN57noAcUYo2RYHzqciVajiIU48TQyOiXdEgmBUGpH/uKIDAnxIPDf79WWsAMYI9HE+O61NhtUvH9YR4dJYSh8vTvPNVTSn96cQwU5stTireMtTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV9O/34pOrZZxnJvnDEnTUvFMO8cRaqdgiV4pp/Td/o=;
 b=dJPnH29ZmtcQh/PVVuGpldoPcwlgrOY6yrp2eLzA+H3ii1ECSAlhd4Magx9B75jybWKz4Ilgy+awk9IdiC4JAeY7d+FImLgM1WKOKuEOiWkKhfCDsTDM4//g2l+LBjl5gxKfEQtXavX9AIIGxQPt05pRpozwp12KmOZs94dVwwY=
Received: from SJ0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:a03:39e::30)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 06:11:50 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::34) by SJ0PR03CA0295.outlook.office365.com
 (2603:10b6:a03:39e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Fri, 12 Jan 2024 06:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 06:11:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 00:11:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 11 Jan
 2024 22:10:26 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Fri, 12 Jan 2024 00:10:25 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 0/2] xilinx: Update the kaslr-seed property
Date: Fri, 12 Jan 2024 11:40:16 +0530
Message-ID: <20240112061018.3280962-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: f37c9d9a-92d9-4102-4e0d-08dc13355cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQ1PaIujiWgdZYuSN/8HyWDi7XIeBTK7UfsqAm5xzZYNcj3x7Nn/5PYvJRwkiZibU9lFKClnfbdLnY0v8aPaDPQi8ii72rm5EXO71SeHrkW12kLJnCW5DH7D2j1PfFhAET8GnU+fz+SDeFfbOeCUHg6kZhaTQ3vv0NMhyK4LAsLI5PdAIxwUBaljcPQyV0SJvN9R8irZttBOG+x2wzOD44R0G5uzEJsfWPj1MRqai2iRuz5C7+eWAEgnuJ4XcXpOOastIZNj1DKN+8on5isEr6GQLDa3ICjtJcte5vj2wc8Cf4HpIYSQdD1CMpTviqL4XAH5iElbmdVLyoEdpZj0lBpqxoLi5KbpDg59kLzfoXXnlPEHX2GvcL+XRcraftOKSjiMq4395tCk5U69SfmssfHhStfNt37GMZkyiziOznvKvGFWoLoE4n7U2jBeEab0hr+sp4isx5a5Ag16Ia+M+Ay94II+deIze3nRX8SL58MhoCLR0E6Sogd2XKlMIi4kW1YpkdkKAEZ+AcztL7sqxiFopMRTQv4a6j/qm+hxPDMZDwqY63c8zkmH8TTXlhNFbJs5Lnw8tos0TJU1lEJZ3VxoI86sP6YBHb9kyVY1sbvx+sMgF16zls4uB6GLHHB5LOuoqzE5lNaoMwfTo6YcqUrdb38XBqzGcoJq2cbUM6PoWBwOa9n1b/q1M6T6Nh1UJP7FpRXWvaY0eBC5jrC+tqhcfjEBFgSzfDCuaO4gZNNKeJNpc+U1MQgwv8I0+hVvqmWDy8WqMnlX5f5rxQPSnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(47076005)(86362001)(36756003)(356005)(81166007)(8676002)(82740400003)(4326008)(6916009)(1076003)(83380400001)(426003)(336012)(2616005)(107886003)(36860700001)(26005)(6666004)(478600001)(54906003)(70206006)(316002)(70586007)(41300700001)(15650500001)(4744005)(8936002)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 06:11:49.2882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37c9d9a-92d9-4102-4e0d-08dc13355cfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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

Update the kaslr-seed property and enable the config
CONFIG_OF_BOARD_SETUP.

Venkatesh Yadav Abbarapu (2):
  xilinx: board: Update the kaslr-seed property
  configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP

 board/xilinx/common/board.c          | 59 ++++++++++++++++++++++++++++
 configs/xilinx_zynqmp_kria_defconfig |  1 +
 2 files changed, 60 insertions(+)

-- 
2.25.1

