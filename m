Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0BED10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319C18397D;
	Wed, 26 Nov 2025 16:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X7zeQR4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 668AE8394E; Wed, 26 Nov 2025 16:07:12 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239D68398C
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiclufUIyN9iIAulhZGgaH/dWDIvkjE+ApSkeN8qLw3hzEYHjx122YVNZWtQgDVsASDscbtQ2JZJgRL/PMFGNdr1YgdbH2n58iFnbC7j62QCQiJKltD+thL2XXCULb2FL+vvtKQKmuSoZn8udspocIZBkUbSSoS41eTwYzUDYAFcXOam487aBzmVJjRhYjfyJpzU81WTvGnkDJiDx9QCqzWzTdLDvvqtUr+uXVnHi8Z6nnXb42y6BgRS6ELwWBuypkVb7LpLW4tkXZv8HxgzwYWa/45mZS9T66xKCIkvikV7GOyvZ6hMl62laENhPmp5XjBmbjuiYg5BeoPUg+jQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ1taBl1KxBVh99rzkUVO+2KAbiJzlYciVgK35QpiLY=;
 b=G+mk0Ft13XrUidG0rYLF7q1KQ5lCJLWEd1MgUkAafFo5isvMPAjoiZq7ZnFw/aO5MlTuA1Ww7VZ+NKZa0FDreUM7xmwKLFbrhKTbY62R1O+bey9Ix0vABcM60rp0BbDBShM7drFKR+14JveNzIb0wqDnoePoNajV70OKbRKf76wTy8NvZRRxJQiwsX+3UjFAyxae8TVlOdhWuvb2TDqDKnzaVWDUbvv+VL2Vq5xxaUit6dvW5OyE0mc/wC6mmN36Nx+HK0lzMMEA5+ycz+kPYVTn9U4pssbGVGaFDXTnaLbKpEiaOIb0aLF96H0Fa7KUKrlXLUNDC1R+NqofFcCDNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ1taBl1KxBVh99rzkUVO+2KAbiJzlYciVgK35QpiLY=;
 b=X7zeQR4pH8ujMxrJ1ZKEo9+Mro5DxU/DTZKFePFtzHI1yqTvxNCAHOjfFEFW+NnQGRPHTMm+pbY+fdpGz+OLQEW3YquUO54Nua3fAmVnjf94UO7b4BEeAP4UduVAIy2pLE7p5UPUONDfftutrYXbvqZmHMC79vipmpEsNEBkq8I=
Received: from DS7PR03CA0183.namprd03.prod.outlook.com (2603:10b6:5:3b6::8) by
 DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.13; Wed, 26 Nov 2025 15:07:04 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::32) by DS7PR03CA0183.outlook.office365.com
 (2603:10b6:5:3b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 15:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 15:07:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 09:07:01 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 07:07:00 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ufs: Disable UTP command timeout in slow mode
Date: Wed, 26 Nov 2025 16:06:41 +0100
Message-ID: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MGsvG9fFg0JwSxyI0HAoFXjaXxLzjd8mM9x5vbTauAA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqizf9N9ve5qj/+KiLRWxXztSJs19/eWpxxC79VcGTS
 XGcpnXhHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRz5EMfzjnahtapTw+Leq9
 TnH5E2enlIBZc1cvEn7Z91+QvU3ZQZ2RoaNzh3+dc2ljo6thW6DNzZNrqn+s1jM685xhUqFa48F
 jnAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: ebffc12e-212c-4824-e122-08de2cfd7593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SPBdyvHeZTfjasmtiH5sk/BEKsVrGvxovJnhhen+Bd7FK3kythPmzVoKh2/d?=
 =?us-ascii?Q?lBQHOdRJpk7G9U5XNcxnf+4J+90BahREUo1Rg5ohY4r6QS/ekZGCWnmPwZfq?=
 =?us-ascii?Q?B3L5+h/VCIeEC3JatCU+oysjK87JbKjlWFhF3DSK/pQ9/z7Hr4ll2GOVoiVq?=
 =?us-ascii?Q?/Ik5pmNn69kU6WYueEel6kQE1+wW7hJXvo9ZZn5MZ1i2vOrkjF7tCDj5b4PC?=
 =?us-ascii?Q?nVeAQoERFUrbp9lUgeW5cA5nsxpfFDFA6c6wgupWQdaVUiHfgWT9B+vSACns?=
 =?us-ascii?Q?3rs6QW/i4/c6WookFhdSoKUo+UDcLzflAjsBed21jBhNqcUYLFLpNBgkBASO?=
 =?us-ascii?Q?tI8jcSwhs2uU5e775ONAjMxUh85qpaSfoslPdCLPtsTdQmWLl2JKysDUO2H3?=
 =?us-ascii?Q?Kd+13jytvd0CNOWdMthIpEVYBJ6z2VOq5Yf4TcGzWl++q+s0Dm8ZoCfXWdkk?=
 =?us-ascii?Q?mihh8Uc0xvU31vjEIMikhTNkSXmAinCe8bkGip4oOYu1/KOzOSfpCjvRUPHe?=
 =?us-ascii?Q?m7iy8kPwUOlyvYPc2M55pNwxv7/UhWHCUUP7SpgNy3Z4PEY0YADwcvKKjwoZ?=
 =?us-ascii?Q?kxFkLGrJ7I07BFdF2Jk0NNnNCxZpyhGcIRvWiWEqw6C8gGJq3JZZN99IBbcj?=
 =?us-ascii?Q?Zimgc9XrD4KuGxrY0b4LHjj3W9ofzjbJiMgApuSdUlCj+gifbVixYEuQ3e50?=
 =?us-ascii?Q?imm4rg0Vt6vOGBDCwFP3C56RTTR+3QD0pWahU/b9EOKmpWkZHyKqcsPkGdK5?=
 =?us-ascii?Q?aYYuzFmprRiDrN0jQTRuTnOM+JCnanbCEl9Afgi5lETsCiipt7goo3Rbmw+i?=
 =?us-ascii?Q?u5cP+hmugcGT19hK6QCbe3Kz2YMK86nImKxPEPFd0MFR5h5+WLiytAVdrbdq?=
 =?us-ascii?Q?S5PXMlbteXw1hB4UkhV7As3i3hSFfKHAxR6HvJOJ3AE0Aw4hw21T/17bdbjt?=
 =?us-ascii?Q?EGDoXwP8cICC1VWutWT3mMJVI6g4me0mipCKLq2rcRsbLiFHE/vX46RSWfkd?=
 =?us-ascii?Q?yCxaBIMnzeK9wstp+TGo2aDCfUF0SKK5BXah3qBQ2EtbHUeJwNHRaeiNM8dn?=
 =?us-ascii?Q?D0eNtx79i9+Gkt1kzyzhiOHPHVxhp1NBIJEMdsvoeSajQdEj+GyUNvtgpI2E?=
 =?us-ascii?Q?a4yPQv58FiVokrW64aJX04nJRgU5EdHXZCV5c/MfzV7ZrXeYkAPoDPPl7My3?=
 =?us-ascii?Q?gl5J52eLMJf2brZOZJbpAAN0oXqg8HLJJ6Mfyuqw4+0YtYTFTtEdnvQD1SLi?=
 =?us-ascii?Q?eUrc59zOdQNTMrnNdR9zVZuFouOWlOR6X7WJywKsrY3EuCcp5fZcNHL1QV3K?=
 =?us-ascii?Q?dqNuTY7qiWqw8/0z/SB+pbJ9Frb/dpY0GN0Cfb9fsEa90j84HQmuf6PJN2ua?=
 =?us-ascii?Q?Aw3zp+mq3EY8W4kPqy4YscBVdF3YcVs1M396rqOIrzOYV/26taiDL1CwLCzd?=
 =?us-ascii?Q?Jq+S7ojijaXm8RVg/q9wjFA69fp4E65oY1iuiwoJYIaGcXB0R7JWtOF2s0nO?=
 =?us-ascii?Q?z6r7drZdwyKjisduAddfULSf4jAHSccwocsx+JDvWaKdaLwD1MDJQeNzrmOY?=
 =?us-ascii?Q?9laQWgjwqdauL/QwgE8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:07:04.3696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebffc12e-212c-4824-e122-08de2cfd7593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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

From: Padmarao Begari <padmarao.begari@amd.com>

When the UFS controller is operating in slow (PWM) mode,
the driver is disabled the timeout for UTP send commands.
In high-speed mode, the timeout remains enabled to
detect stalled or failed transfers. This change ensures reliable
operation in slow mode, where command completion may take longer
and timeouts are not required.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/ufs/ufs-uclass.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3c8e4299259c..7a80a9d5664b 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -917,11 +917,13 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 		enabled_intr_status = intr_status & hba->intr_mask;
 		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
 
-		if (get_timer(start) > QUERY_REQ_TIMEOUT) {
-			dev_err(hba->dev,
-				"Timedout waiting for UTP response\n");
-
-			return -ETIMEDOUT;
+		if (hba->max_pwr_info.info.pwr_rx != SLOWAUTO_MODE &&
+		    hba->max_pwr_info.info.pwr_tx != SLOWAUTO_MODE) {
+			if (get_timer(start) > QUERY_REQ_TIMEOUT) {
+				dev_err(hba->dev,
+					"Timedout waiting for UTP response\n");
+				return -ETIMEDOUT;
+			}
 		}
 
 		if (enabled_intr_status & UFSHCD_ERROR_MASK) {
-- 
2.43.0

base-commit: 966dbf4bdcb2970846eaf61271ad456aa802688b
branch: debian-sent3
