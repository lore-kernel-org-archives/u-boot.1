Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD68AC5CFCF
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 10:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAB6481005;
	Tue, 11 Aug 2026 10:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ni-T1rEPytwZ; Tue, 11 Aug 2026 10:53:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E53581010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786445621;
	bh=ym62MmdFPdFMANiEeAG2A4mSXgy+eBzziO8CnD0r6VY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bhzFrg15w8tojLkDfJXUBQi0COTG5d3DYI6jl/JLKP3numxwfa+h/BnMoVi+8HA6o
	 pXWVZ2JEh4HAtPfusrWv31E347xktJZHZWtGK4f+rdbpvlg/bNX+piAYzWE30sviL2
	 /bODR/K2KonL1gdEyRFQFqyD8koe25+KQl5Jx4MKCEuQhnL7WzQh9lqEkTOU6BXV2C
	 fq9lmmejMBVQpl05UctC5mxKgB32duAZXWsTbECcELrUZvnWHtUoMitb7/T+ynEjwO
	 z4TaX9I/SiefRLlYA6tP2bt2hAjlpf7+qxnrGUDITCIVHQE1ZUz7/hsQBEzUTmPbOD
	 JiKQ6DDCp+YTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E53581010;
	Tue, 11 Aug 2026 10:53:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08260345
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E23D96076D
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9adZQop0Nufy for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 10:53:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3393F6065A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3393F6065A
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3393F6065A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is0fjiPK9TQV+OFzq8YgcJdbcQu7F7NBzccdoM46QgDoCDhnUngPyGPSeNx+cCIhh9bwzkReQpsrJRyOfUiebULPvaafRpYfv8GRfQeJ4cQqXifP77S4Fla3QvXLfySGufOmyg/IoycKgDNrrI2JvfwwCEPAlAFPDsn4x6l+bTLZOE/4KZfY5z5RY2A3d9kwihs//jZzc85rltIGry0zy9p6vRLmjTomnd4EU+IolG1pQoWRrUwpOuOWEIb59YHCUAXL+22jDjD54HZTlX1gPwu2+FuQKL6zo7/ZCPCklXgYeUvzl4VDNgcLyV49xgEaoPYBMzQ1A36QvJ/5Gte5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym62MmdFPdFMANiEeAG2A4mSXgy+eBzziO8CnD0r6VY=;
 b=sgK8nVR3GkJf/dE0T8LHPS92bJ3HiTKa7B69xLAFDtvYPrr+nk4reUJglbPtaKb3dLvBSYprpBsezcdjNI+ygsqw3msrDDYkJkmirGUU55Nlt53zMDipl0/9QczR75BB1rFYSLuhAfHLkNvMTgwB8DcOeuVOdN+afP0cNy7yCBGPAk5AX355NItvBrC/kwQDI3h3j58vItN3Pmvqds83k+3c+Ry3/1pdNo9R1MEBmWR4PwqieTIu5rqkFvLrnkB/WKjsKoMGY5ITqXokudHnCDdzUZ2bbhvpd5r+yLCz7uYHMsxoFT3O8JJyArJ2hWoFNUZbMG00K86YcDNAArmVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:610:cd::9)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 10:53:32 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::1b) by CH0PR03CA0094.outlook.office365.com
 (2603:10b6:610:cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 10:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 10:53:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:29 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 05:53:28 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/6] gpio: uclass: log when a gpio offset is already claimed
Date: Tue, 11 Aug 2026 16:23:09 +0530
Message-ID: <20260811105314.3837228-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811105314.3837228-1-pranav.sanwal@amd.com>
References: <20260811105314.3837228-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc577c4-a36a-49be-de89-08def796c824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X0FRQ+aptRu7fpYQQUwWMRjb+jOnO4+W8Fn3Q79SqyirZWBvXv/eQJwJ4eU6fXgqftARDmZsuHk5Sz3yX12DlIP/z5ooIgYwIt5PRYJlyE3drqtUQdIGcbm6Iaomc1yLmTmhsVVuW/9Md6RCzPnWzArkZunzCqwQRLEHxwGFQrtRm0p/T23lbkdZ2S2U1zLZ2droJL11eo2rO/+H/nK+x3dVeua/xYtfnae5BcfhwHgysUsCgBHhAnJkDEApsWksGzMuhlw3GHCrM0pvXFhf8rfJmZauOv88A2P8Wax76AxZQJMPydZR/EBB30Zjnqm+ZL71Nph9rRALoQ/MzKkqiv2NxvDyYsoCzROVKoAeFfEnqsHLhyPEjWtnFLCkbs7Ze5+/eZiCNS8h7DwQ1zvYKcyZfk8YnVRbZtccvU0/hdIxnFPGh0csyaSNjvBY3Zr3IU6LXhIJS4apx9totTntUIrpsPtLjeTF5Cb2hX2AZ9ySDrSXNNr4cZ+fAZ4RT6A5T+bgTKngaQ19Njpx/pF5GKGzi1xg0LbXUYR3VHu6fSA2ZvgX315gCpd/mkcQ91XpR1Ra5LxT4JJcLe0SxD1Jx1suaXuApRyGCUwYwr+o58wQq4w/9lC6KVSo/OvQUsA7wHiu1wGFJ3BMkcsGr/+SCy7OcUGFcoZM0TTK7f1T/7QXOsq2U9u29QCneKl69iBY0J03aO1oc3j4lxnQBUXbiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hIdNMStXtE2SLJWcnMw9buFCZFysylrXJ5vfF77WHPeequttAj7q3/tXfGZCJlG2v7P5OLwa86g+kbEJ2UI63NWpeHPAIpyDy9KeJF/SH3W0InVU5y8DsyENUnLeocax8xulEDwJcZXqMKvwNayscXMAjhNXxM/DiqAYg0/2QQd8M4FlwbAiL5dBLalA0Jd87xVv6S38eCyTR8zhoFzSmSaYSwRIuzui9WGs7+HJs5jqEazESyu1CCB48wy6/Fh48ztGy/r/NSy9HRelI72OWg9TyVRnAwN5U17/LITofaAM3r2utsjts+KIKsGz8JNrIVUBW9c01ht1JiM6zHJkwrLITuQ1EL2FhurBhab51sZ8wqNx/USjWW9dQJHk7VIwYSM7zdn+b8hm2shiQDOgAuERPVYe9obfUlZyD2g4lrw8pASP/j2PFC/nwiC9MF5x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:53:30.7400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc577c4-a36a-49be-de89-08def796c824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym62MmdFPdFMANiEeAG2A4mSXgy+eBzziO8CnD0r6VY=;
 b=IaQiNNydZbTIdpkXcFSiyibtEKjNe6i1LDMVrUYtoVnROgBHV2cK+gWnG93/2a+O8OOy1Fsv+gr9GFRUSlsv/7VDfBrFVpYge/0IGLoJEhexiyOGFyeDVM5d7NeHKD9xbsLireVOC7F+qt2SVo8JnKXXcC70QQBBqRTFLWRA58I=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IaQiNNyd
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

dm_gpio_request() returns -EBUSY when the requested offset is already
claimed, but gives no indication of which label already holds it. Any
caller going through the uclass API directly, rather than the "gpio"
command, has no way to see this at all.

Log it at dev_dbg() level: silent by default, available when actively
debugging with this device's debug output enabled.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/gpio/gpio-uclass.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 7559b8dc7e2..9451b7db4af 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -391,8 +391,11 @@ int dm_gpio_request(struct gpio_desc *desc, const char *label)
 	int ret;
 
 	uc_priv = dev_get_uclass_priv(dev);
-	if (gpio_is_claimed(uc_priv, desc->offset))
+	if (gpio_is_claimed(uc_priv, desc->offset)) {
+		dev_dbg(dev, "gpio offset %u already claimed by '%s', requested label '%s'\n",
+			desc->offset, uc_priv->name[desc->offset], label);
 		return -EBUSY;
+	}
 	str = strdup(label);
 	if (!str)
 		return -ENOMEM;
-- 
2.43.7

