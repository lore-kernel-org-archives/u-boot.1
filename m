Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011A5EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 12:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D410A86D59;
	Mon, 11 Sep 2023 14:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SnOmRhb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC0686DC6; Mon, 11 Sep 2023 14:32:43 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4943286D14
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 14:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewXnzzt2KoRSGrztTl9kBsTr8KDX3TlBmImhxePtziChSYIX0HClIYFZmSLk6vaUvYcVFlpDe5rB32o9AQVo7hlvTZkp0fvqFwiThbDjXcOnjvEnp3tpfQRUnq8ASLhrLuC93WZ3YU+bEJxZo9SqIXfspW7xbsgFByp10EpxnHXArOm3ngMgfi3q5R+EySnyBC6MSaWKw87CFxeY9wiO1dlxJbbzUYjW9NF8ZqDaWdjrWxdHGL1e0vhQcvTLbJALcFbjCg5AWBj2yhQ+7B4f9m4f3p424mB4WjfmhZnmG+7ziN6BwjzcIfT4qU9+iABOyizUL/j8fSYfFLtryMrBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym57q+cHZ4OKqhxh1cdfJC6gu8b8ZSfQ9C01ymvkc9o=;
 b=c9PQJJbVU9PdRrNS1Dl+ILVk17tA0pXdFuAjUJonKLsRFKDWmDJOsLXlb/KCHyiYWQI4bh99l1zDhBi5BreNEOG4AcARiEkGK8F3xa9RGjcna97Ni0h8VTND0Y+gDxFa5aP9xuzVx7TjyHHjmEW9LJSnfPbn091GJwynky/kkLZt0yBGuBc/bsLSpT7NzTUjcT8s6a4xDMX4MHtyTMcLu8zVXb9GWsvr8a/Ae7Vl9SHdCCNiO2bqzykn67XRgMdQ+Iar8j/NVqymwQSUc8+YXUnWL7fFGl057KFfIaznntGfYtU4+Q2Cjswv+3RLNTBjEXcGxVkou3da41Y/p/w6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym57q+cHZ4OKqhxh1cdfJC6gu8b8ZSfQ9C01ymvkc9o=;
 b=SnOmRhb9PbyrSEpKqVXWKHhlQMQB/ivXo6qF7DgbOkw/fFPaUHCDztZvfAt6FvDYvqxAlmPwu/YKWiqnCqNoZpNuJqC0krsipaqeZKoLuCYeM+s0GE2M5PgY2ftzgVAHCTpymFFf76xoOAg4UoCBP7TUwWJY/BjgnZtCuML0hwc=
Received: from BL1P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::35)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 12:32:35 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c7) by BL1P221CA0017.outlook.office365.com
 (2603:10b6:208:2c5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 12:32:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:32:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] trace: Use 64bit variable for start and len
Date: Mon, 11 Sep 2023 14:32:27 +0200
Message-ID: <734d41ddc4b5711fd93d3292d7049df3f11472e2.1694435541.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694435541.git.michal.simek@amd.com>
References: <cover.1694435541.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2g75ZbSx02lNeqaWhX3EgXJdcoVcJ1wMKmUDYLqzy64=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/HDe3KrxVP5hzhJsr/kfr25AY9fuxTj9uqVStDJjxX
 iSgZ+KkjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCR3ccZ5pfW7nt39F198RSd
 lRc3VqpP+Opk2M0whzfj1pZbCxZUbL+6a2FvVI7edg6VvwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1d86e4-f2da-4fe1-f523-08dbb2c32d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3gwsdxne5CJHL8QIXFUJffXaFauJ7e9PHK74Q+OOs4BwIfgSFoHntrNeV0mIsdMqBkFFhZ6VhVcRzMEcUJUvBrGKzk/ZsGG64jUKsj6VSUkmdEIKq1iAtXrbGvyj1XazW6nIVVGLDcV+ejDWLoUWG2zsU5u9b65zcHVpoGmXpZb/OfJAWYpMMNKa/fwMdwy0qaL3/wnWmsr66pD8Jwvpix+WiBamLCAW2KG3fTtG44GDUYM3c+rAGQWJff3csUnUbAvcQh8rkNPmJ7ak64mtuxrHUaV6Qm9vnt/XPqwJkeCEutmyGuiFuStUVxm+i1B7sUyukF7QkXe8n/0U71E9iqs5Mo5bqThCwFiF4KPkjqDZ3aBHjOzV5hfj3G6+PAx5PNjFPwhkGRevVWIJ+1iEQveeo7Q/fi1VBpy+PZm73TOpcLmsJTI9OXNyZwN+xy7NX46AwULeAQfDRsNYMkgS0clhbGddYT1hZ80AIAv1GYbMBlWsuDQnFdU1aSl64BvkL8eGSC7jnnfWkkQ15qinCpaezv8hRhCWUegXV129kHYHL1ORQpvnRRTD7VVNs62951h/pT0u7EGfYB10/NSkhDaIksctpckyU3RA65yDSt2RLqThjCjLPi9ExhHkgIYK6VVAFwZ42L1NVHmmHbFqQfruOFM7zkDQdxUrhxcsEfXBsfQErZD6M3ACTpNCnSUxpkjOIwYDut20z+MDOVfn4p/IvPR0sJJn3wzCf4qPVp2bHPZspnM5zOKJZnqf8TJO8nJdwnz/yT7Qwz0G00e1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(8676002)(2906002)(40460700003)(4744005)(44832011)(36756003)(86362001)(82740400003)(356005)(5660300002)(81166007)(40480700001)(36860700001)(47076005)(8936002)(83380400001)(6666004)(426003)(336012)(26005)(41300700001)(16526019)(2616005)(110136005)(478600001)(316002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:32:35.2405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1d86e4-f2da-4fe1-f523-08dbb2c32d69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
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

tputq() requires variables to have 64bit width that's why make them 64bit
to clean alignment requirement.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 tools/proftool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/proftool.c b/tools/proftool.c
index 101bcb63334e..869a2a32c510 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -1493,7 +1493,8 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
 static int write_flyrecord(struct twriter *tw, enum out_format_t out_format,
 			   int *missing_countp, int *skip_countp)
 {
-	int start, ret, len;
+	unsigned long long start, len;
+	int ret;
 	FILE *fout = tw->fout;
 	char str[200];
 
-- 
2.36.1

