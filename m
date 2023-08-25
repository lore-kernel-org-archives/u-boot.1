Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D214C7EE2C
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 12:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D898680E;
	Fri, 25 Aug 2023 14:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3QYsUKzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D377886A1C; Fri, 25 Aug 2023 06:56:58 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E1D8657C
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 06:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt+hb1zNcZmUbm1ByMbF3XN+HUFLJgLv91+CIh0lCtVllCiHD6iaMhy+uf2BoBzm/+tzdFsLqqnQ4WL/WMkY9m44v6K872pN7dmKKapfQXkdI1wRzvLWq0YukZsfvWSRl4R7KnaMihbFhaHP7wlr2V1vMiC7V4m1FqK4h3N8/YHC+2eYsLkSnVGAeuMr00aNA56FkxDpqDEAUUPz5mPC7/JcmHWUU6vtcpNhl7PXnHEgzDf6YtSLZAymI7xOa1FV/Dx0RjcWqjlnAjSKmRnawBbCDlc5nzbNzuaAoWaVNTeMxEo0CR+cJukn32rI+2WHaHfy+x0xVpL2Y96RNbqYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC41q+SgqPZnqn0EzJ5yCHo/TD5qxE+CjCLG8zN/r7Q=;
 b=nzwBPPV3K1AfzelJSDVxUwWMDHNdzrfoszye4IDEjs2yosUCzv1hNC2St/7ZLvj3dAdGguDXzCkL0WARI8Nh2wz5tutOS8UDk2uhM5GmAtVP8pL5ZF1YqB/8BOcAIbFaNi9E5EnJtEKvnQRJO+gT03eSSvTaiieiUHUO/n0H02igolfcGE+bOwObLsVZ+FM0f/NX0xt8PMf2gxWbPDgyraAoKMlAtDHqjty4sGZMCtV8obrK2c6VIGQkYeoWPZvd4aA/zzrM3ALB7KgKmEpOmxNGEOi8SU3kpIiN62eqnOPgfE7t0AWlDuCyx9+9GsAlPoW8lqL92ETVTPx3lYr6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC41q+SgqPZnqn0EzJ5yCHo/TD5qxE+CjCLG8zN/r7Q=;
 b=3QYsUKzm24qxyCjIY2TEQP+0apwsjzmq/dlL+9SdYMGpEFzjo5r+iUftZFWRDmTmSKJgXBVHAg8lsg4dyuYWdFubkkFdw7X9NDA3IgikYF/MD+cCaDYsAC9d79eiVTp2Yle/qzXBynikbucfPQqJVKpuVCPRYNS2v6k8mJB2UNQ=
Received: from SA0PR11CA0080.namprd11.prod.outlook.com (2603:10b6:806:d2::25)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 04:56:52 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::8d) by SA0PR11CA0080.outlook.office365.com
 (2603:10b6:806:d2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 25 Aug 2023 04:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 04:56:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 23:56:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 23:56:49 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 23:56:48 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 0/3] arm64: versal-net: Enable CMD_KASLR and TPM
Date: Fri, 25 Aug 2023 10:26:38 +0530
Message-ID: <20230825045641.32728-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: 580633ea-3bef-4ce4-afca-08dba527b183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+68HuODfRk3pLTRNGwC67a7zRpbs2YK4Bu8W2AlO4/Kx88AIrun+fB9lv66kOITuJPZnW8I7/4UV6V72/8E5UYm1JMwnBUktcIJlwRDrHTwnbvNk1FGt+D/0CpXDU18ay0SvZeRCGmSrEwvz38UDFxXDMMK0eju1qT/nQo3Mvi70FC3t477fqwxnQputc+dch3JRLJYNQOHu6qUB2coj/9DUdE3TTqebWoccIWQPgeho/6GzjHW1XK4E9ucOAefg6+oOdos7GEJMEv9YSwOYfZDs1IFBx5afVfWujlvinyubxgq16hjmKu1u5JIz81Mio6BJnveezRfYI59FPfUFTsbuyWrf9p5KDtW5U35ro8cUiy6SpYMNsdegQnB/3d5eiXWbU2LXCR/DynWD//fCWtaaKkVtznDtEdOr5li/EDUlHiligzEJQx2Eh9+zLQ08SVYuG7iUUcMs86T2pDlXPXb+sCkE/xYBaEEwioJNCTSmEvimxSSobVADThgCvPUNCoQgerkWsJ+ljyQF3eQnZRvgQsjz98Nm0nd7h0AWvO1qovK0ZlPYnqxEDTtvpvWbuP+EXOn0FOrdpL+1L4ZB8MfScV9KuNslpfyWi4BHvr0Hc+fl1JcNE4b4goThpTVwtQO/rNS5rbI854+6U+h3WUiVvP1V0rwxmk7GmNPUkiAPAlLNJYO4hHwefYg9eZvf2y024Jx9utaOJ7p/wtm4Ge31ldTN0MbYkVCOnOIOoNwLEBC7vlMt5TYy6dg9bTisw5VTeV0yFC0ZiPm/xoB2ZacCuWn6mPRiOjRTmRLxZskTc5VQKSY4GvcC6YGL3WfBeaneLISONiMAef6Vr/6qQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(54906003)(70206006)(70586007)(316002)(6916009)(478600001)(26005)(36860700001)(356005)(6666004)(40480700001)(82740400003)(81166007)(41300700001)(86362001)(2906002)(8936002)(8676002)(4326008)(1076003)(2616005)(40460700003)(107886003)(5660300002)(83380400001)(36756003)(4744005)(336012)(426003)(47076005)(36900700001)(473944003)(414714003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 04:56:50.2468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580633ea-3bef-4ce4-afca-08dba527b183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
X-Mailman-Approved-At: Fri, 25 Aug 2023 14:39:25 +0200
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

Enable the command kaslrseed and tpm.

Venkatesh Yadav Abbarapu (3):
  arm64: versal: Enable TPM for xilinx platforms
  arm64: versal: Enable sha1sum command
  arm64: versal: Enable the config CMD_KASLRSEED

 configs/xilinx_versal_virt_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1

