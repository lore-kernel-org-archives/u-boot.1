Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F41DCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 07:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9275D83071;
	Tue, 16 Sep 2025 09:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rFkhE/VF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769E5831C2; Tue, 16 Sep 2025 09:57:57 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A9482C84
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKr3fI4Czbo3dTqmaIvxVZFk15EVAdY5fi9fEreNQH8Hl3gTnzjfuDFzz5qZldmWIhLWbvULrOckH43gWnHobrSJIBciSx9Wh8qa2Lj0rZW0C/gt7u+pQtDZ1uoWzRGUibHQ2jodU21HoCAMqay9RInQvdr5Z5rfU6qZL25WSIzlqYIYfyj/jWhGxLbUa7oJfZXnmBDjFXlD7NUZo3QmCK806wpWB+7A2R1lTzhfND0X/6lVoOwK5QbbZCGPmosCklJRAMygcPUFdRXlSbu0LSaDjEq3a5hvaicHRchQ54W50mMTdRFHuXiRD0tNaF/iyPJ7LLXIjU1JlMKGiXoY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouBIXYjgL8RCRxE5xvbOyItZIhMxbpieyj1LBLQieZ8=;
 b=A8BpEhimpyXWtHp/Onv9hpaKBlulqQU960maerOjPHwKIoTfQ/Wdls18AZF4aHkTv7F60IvFgDSpABbgsD74a2KW7NctTzp13/0kNjqaPpNuKnBIxSWF9HAUV0K4hvKL0TMTTwFErL37SMdCt7t+I7SsscdBtrNc7s4Nbur3U4tqSrAgUSBbKaW60iGdl+sWR/Tfp+biPP98bbLMQVBaMl/afJOytLfFppqJ6dm26D5H3K/JhWXFXEG6/2HSr0YT9SVtJLVkGPQnq/gsTSzoszYEhly4/vd5VIgqg8q6wEHuw8HCMLP+TkZ1lfe8im21RB5bBAnlj4Zt/HfHc0odHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouBIXYjgL8RCRxE5xvbOyItZIhMxbpieyj1LBLQieZ8=;
 b=rFkhE/VFbqn6cYAHpRHjbZ66LzomjoBV53yQA8QWpUpPKYRyjM2Ds/FfvEr6CnbDOHcWemZAdQ+L6cfg651P18JtIqy43DPsBlJ5rxgNBzz74KxvhZEi5rQniF4Rm0sCnfRrseN03oNH5diUZRfVdvzTmwMZrb0aVgNS087/E58=
Received: from SA9PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:6e::12)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 07:57:47 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::e3) by SA9PR11CA0007.outlook.office365.com
 (2603:10b6:806:6e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 07:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 07:57:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 00:57:46 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 02:57:45 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 00:57:44 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, Marek Vasut
 <marex@denx.de>, Padmarao Begari <padmarao.begari@amd.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] usb: onboard-hub: Make i2c-bus option
Date: Tue, 16 Sep 2025 09:57:37 +0200
Message-ID: <59931e60e6ffe1f3e7605037ea3b268b9bb1cf7a.1758009455.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Q4aa2FKp5B6IB/031XDsepl9r9qu5+H8p0gtyDqubMo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSclChS45h4+v+px29vRh0RcnNidYlp6771emJfUdRji
 0LtGedudZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBE/PgZGfb8+6PNv4DryEnO
 6KbwPQI7fjxYzXwn9KqEyfuK+5X6vpsYGR6pcEse6TDtEv15QDFmcmttoYXu/6+7etzK/ryR3VD
 GwQwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: dbca79bf-13fa-468d-9353-08ddf4f6b9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qBhORZmSjgsGD5wAU7Et+5adbDtUFnEmjIh4YrlwPg76ERJcifZORP76YHYF?=
 =?us-ascii?Q?KWW8GT3elzOBJ93WpHam4Vi3482ao0kpFXucZwsMJMPSFL95xCpH1cP05Wjp?=
 =?us-ascii?Q?MRrsd3NKKGJWBXfZtMKxW8AqKMcKmGaxvhuvpIEyeXFJzfqWzMDFtDshRzVW?=
 =?us-ascii?Q?lUcGQfKprM1CxNuWEeE9ehDIVg3rW48twdBvCsyddYhmDlYoIMll2pi/Pif1?=
 =?us-ascii?Q?r6aeOMgyCVUIU36f/ZIwRNemowGoQSDY9x+ultWTlR2f1NX1S0ctbZay/lBn?=
 =?us-ascii?Q?7opj7kwps5zObFDWojWe1UY9Ll3M0TuAn9hRIKz39rSkhFGwgyCXrY6ORC+O?=
 =?us-ascii?Q?DJouEEyiLUjIUZ0kHVTRVYcDgmEATiOX1Izwakimo8v/ipWhSFuzD85ZkxXi?=
 =?us-ascii?Q?mxDU2cmUxRqliqhVWlTAzmuQhnu7l3pL4etoJAGOSRSrWIrNIWbqOzvgzlmZ?=
 =?us-ascii?Q?wiw/dR+cOsMo3EHt+6FAPdv1mmSUs4UM5qJhYdXn5k1hO7BR7RzcdYoJWyyP?=
 =?us-ascii?Q?q2YZarhna2gjtOiiaHENObrgMbcNWW0d+EPi74WQCeBC/Sq3ischaLCt+XGG?=
 =?us-ascii?Q?gjwn9Gr5pyxN9m9/rcFdRzedmH/MpWhM4AzUIwd/5Yx6NkNAOttU5c0Ia295?=
 =?us-ascii?Q?3aslnyZVSvFD0xX0IAbU88g7WLBs5wHVvIqV/2+Iz5GxeHt5hk8sS2jtzqSS?=
 =?us-ascii?Q?TGJvqRVR3+5dv7oMctdGuyVB64d/nhvO1cGl2j0oKiWRBswPXUbk9Cz6sB6Z?=
 =?us-ascii?Q?tLwp1CjRvMPcVIXxlHw1HtfRKrvzYRcZ9SMCQvDFVKNC8V2DYhMp2+6QMj2n?=
 =?us-ascii?Q?IYY2T7LqNcQxYQtv87OdY2c5PQ/CVMOo/8/XKtQI2PGuBfAij4bOjxtD5koy?=
 =?us-ascii?Q?/qR9ciE++EfA8MEzdhsMFT0PayNR18um1XfX1BmrjoZTmFHV6034aIJmMLHR?=
 =?us-ascii?Q?kX0hJsomqBC+pwTAGpOogFoG99bbvi9KsrSODsdPWkAKtVvf7gB+c/MuCrRx?=
 =?us-ascii?Q?adYAFDC1DZC2XR3AdV2ckS3T7Xm0MUdgiPrjwsYB0E99LukpuQKJ/CQrhEkS?=
 =?us-ascii?Q?fP0Sctt6HOL7+ORILx44Quk5nbkGP7LNO5FE9lpsQiHIKhrtjVTHsRW2cJhz?=
 =?us-ascii?Q?tF6Tad34iuXfncgnBuyTXIQMMy5aVS81o8yX+qTeR4Fs6uuTr7Tf50O3112i?=
 =?us-ascii?Q?yh4ERfqq1c+2LmVuE8ADMTK3Kel1Wuta+PaMt9dfKzH1wYot94eyXBY0x4K4?=
 =?us-ascii?Q?B2y8BwyvUGvp2uqggRpQfM9zAF1FLvP9G2xJZvL43XIBO6oREScEbHuQLwW8?=
 =?us-ascii?Q?vsW21jBdFh3SgWJi9pR/1g05pKGz5oXas8pSMfwtRy27pdySGclPMdWSBEG3?=
 =?us-ascii?Q?U9KZJq46qDmq1ec2P0k/LN0KCv9UlwT8gomWae1PFWj4jUTtk0RJTbvVcPN0?=
 =?us-ascii?Q?rzpchtPFT8v4tfSEBFNi7Qd1jsf7KSUgYLflJxsl997bEUXmg/SQa1tjtTJ8?=
 =?us-ascii?Q?KMHsfs4TOq0Po/k7RNXTDa/0OhITdEYq6Nb9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:57:47.2687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbca79bf-13fa-468d-9353-08ddf4f6b9d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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

DT binding doesn't mandate i2c-bus as required property because hub itself
doesn't need to have i2c connected.
It can be in standalone mode that only power regulator and reset should be
handled.
Or hub should be configured via spi interface.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 common/usb_onboard_hub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 70fa349a8817..c025200ca71b 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -62,7 +62,12 @@ static int usb5744_i2c_init(struct udevice *dev)
 
 	ret = dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle);
 	if (ret) {
-		dev_err(dev, "i2c-bus not specified\n");
+		if (ret == -ENOENT) {
+			dev_dbg(dev, "i2c-bus not specified\n");
+			return 0;
+		}
+
+		dev_err(dev, "i2c-bus read failed\n");
 		return ret;
 	}
 
-- 
2.43.0

base-commit: 07c9cf2778d9859ada8cb4733b64ff707f992b4f
branch: debian-sent3
