Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC78FD375F
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8459483FB0;
	Wed, 25 Feb 2026 15:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LRgaHOZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9632783FC0; Wed, 25 Feb 2026 14:43:39 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E84283F00
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skuJtvtD4ssYC7FAmYFoH7hYnFF395blm8mmDiXDfFIKO6iGyXwD0a9Ao6Q95knQYkP/bg8Kqi8gceheDnC2orbp55yCT/hypXysWDWMoi1oA5voy3oIT+3ldaS62xUkK+CQlWFEx+upCMn3eBWY24gDW6LyIUKDADfmjTPKqhvdsg4NzObOjqYkt0LFiu+a5aZejnyYxc2Nt+TL2HLA5paXZZMcxOuFdqtZn21FWgLk79zQS6Qob926/x4qlym1RUrVH/tAaMH8QnG0eBiz0zaWgBcM2kf2X39H/XJraGWVwA1WaSptKouRLddIzCi8oH5F3Al8vDbkn1AfvZUfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF8NMKj8UZKqwzQw46tiBGTZ8kpXiPnh9rKItM8BX00=;
 b=jYgsUA9okvccPYULgDTspYQwrYbrq21k9LnizSttDVBQQyMtc7BAsyJnb7miwhxTrjTd9legPEgR39t/nHi64oniKBGFDH6ZWyLIpVzsCdfuOAQpt19IDz03c4gx3nYBIZMLmpqWCCKBTcA57fH3+Ly1VVDsAckDtTMdm/Aq8uXpA7PSMFWmZtVDrrvq8Hxiiwysb8V0isZzq6He+8K4TYev10w650THDo4CfzGVMlE01euqVd0oSJhhVhPKX0Qbw4QTHXsb5N3wYBLtxMP7rPo7RAFG9TqR6CVWYludXGxw0b60Gx0o7uQBZdyVKAxgxNdeBCdGcMroz1lPcbf59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF8NMKj8UZKqwzQw46tiBGTZ8kpXiPnh9rKItM8BX00=;
 b=LRgaHOZ+D0he2fI6AQwfMvFBUc7fPUePUkdgrFFfeONTTPVRKZUuBXM6oKeNQZYVpjUZ8BpmEskAYK04CFbS0HNkRCRvab0GLTbuDr5GlKc27JyQEPvtK/kZAYPRO04m99YUkTX3/A6zc6wmexdUXYTCTYtO2T01n88XDCz2taY=
Received: from BN9P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::27)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 13:24:35 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::c1) by BN9P220CA0022.outlook.office365.com
 (2603:10b6:408:13e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 13:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:24:34 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:31 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:24:31 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGo011150;
 Wed, 25 Feb 2026 07:24:28 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 0/9] board: k3: Sync rm-cfg with TIFS v11.02.09 firmware
Date: Wed, 25 Feb 2026 18:54:16 +0530
Message-ID: <20260225132425.3096103-1-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MW4PR10MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad24bae-8a74-4760-10e3-08de74713764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|34070700014|36860700013; 
X-Microsoft-Antispam-Message-Info: FnLKOytu6ZuvgHOUK38IK4ZLdjOY40zVpL+IDChiHVgA2wZVXasACbZDfU6p2I2T8FSqV3yH31kFPtqYtauqM8SJwefCk4WnZTPQjzi4eHgoq12GGfatY2Z3skQKDYjKf35SIbOzPXZ5l5r8DeHdjxNUEuZ4fvy21MEzi9xCLnKEeqiQwLcoVLZNdbJJ19Yt0MZNeviOCv1IiSNtvfo0cL3TNZF/FuNm7R+1ENlJ/VACgb0/edFCKTUv1LFfpBIBXGXaorKcg+oiFicBBIQcU2W/KXCTmSr2wt/pzfOv9v48ObgDh9e0Jtt5mIgdoyupUZSPlNPP8ykH0/PQ1CM+weg4wytI1/gzJ7cr7ROEf9sKh6NIF76yu7MR0RbgMIXalpK1wjRntHpou7AmEIXlJjD5eofWTA/ZRI7pENNSvNTM7rjt8Jf6B+yZmNLbwq5kC6eQb18UIM8WeB7/DiKhD+wziPBlxhF+o+DG/Rizp8qnhjued0Q9DJnZVSVSW9SfelJZDXE9tJprfgVp8e1SAnF35OIHuyY6PWP6BlXy6sN4DICjrGppzBNlKQKaI6Q9L8Rtstpxq5krFbOD8s1AWS7T2nhEW2ZKHh9oi8lO9dnFhqmPAJ/lZnmz1YPgEnnbSZQQANOSZcdt1bqLNSfw1uXAy2xyOpQ0G8UrY9qghw7+3jOqnH9jEXra6dbONiY5eJc27ipWWRnkbY3s3CbtUttqiI5LpFHXJQDGIqvJNHor06UH7AWyqLxoIq/TmmAuI15HYU9HX3h3Aq0CIvTquHj2GbenzoPPGwmd85N6SUct5SK4OADEI7MKzwNzOkTXrQ4XcxykoeCT6vWJC7La0w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(34070700014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kXzy00CteeEACFTf/z8N6iESso9KLPc45tQIjfX04SJKGaHlcsozzIHsj1xdXX4gEmSLRt7OXYZKKOMaScMUCIL/3Da7VOF1DLT/fepRB+OA7vXhWbcBFFNEsjDAjvqkeSDrPgXvoHzY4cuO7kQghvVPPWEMRl1WkTPEaiMfQMPQ5vJNRpkrb7fOB6LDWSqLPNrXLYKsT+2mzaQTh69kON25+WBcTEJJKS8tApa/N7aSW62Kdz/0qS3pQzyFEJcJ4TOamXQO+WtdlH54wmUsbphUj7K0IfPz3kPk9x32MQN4OefHvpuAJWymquTuNfJQ4ej3doFFwZX8GHUm7RgJF/nWxmaM+cyb4F9780Io+7E0+wsqr4vBwcg3PTtmEBFVH+p8snjrLkEpM0KugAxe/F4DCpUe5V2PMReTXieIt5UFmOaZLe2uI+iMIXFWP7jU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:24:34.1496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad24bae-8a74-4760-10e3-08de74713764
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Mailman-Approved-At: Wed, 25 Feb 2026 15:01:23 +0100
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

This series updates the Resource Management (RM) configuration files
for AM62 family devices to align with the TIFS v11.02.09 firmware.

Background
----------
With the latest TIFS firmware (v11.02.09), an additional virtual
interrupt and event is reserved for MCU cores to DM usage on am62x,
am62ax, and am62px devices. This series brings the rm-cfg and
tifs-rm-cfg files in sync with these firmware changes across both
TI reference boards and vendor boards.

These changes are backward compatible with older TIFS firmware versions.

Additionally, the am62x platform was originally introduced without a
tifs-rm-cfg.yaml file, unlike other platforms in the AM62 family.
This series addresses that gap and enables tifs-rm-cfg in binman for
am625-sk and am62p-sk platforms.

Changes
-------
TI reference boards (patches 1-4):
  - Update rm-cfg.yaml for am62x, am62ax, am62px
  - Sync am62px tifs-rm-cfg.yaml with TIFS firmware template
  - Add missing tifs-rm-cfg.yaml for am62x
  - Enable tifs-rm-cfg in binman for am625-sk and am62p-sk

Vendor boards (patches 5-9):
  - beagleplay (am62x-based)
  - phytec phycore_am62x
  - toradex verdin-am62
  - phytec phycore_am62ax
  - toradex verdin-am62p

Note: For vendor boards, this series only updates the rm-cfg.yaml files
with the required interrupt reservation. The tifs-rm-cfg.yaml files
cannot be updated without access to the corresponding SysConfig files,
as both rm-cfg.yaml and tifs-rm-cfg.yaml must remain in sync.

---

Sparsh Kumar (9):
  board: ti: rm-cfg: Update rm-cfg to reflect new resource reservation
  board: ti: am62px: tifs-rm-cfg: Sync tifs-rm-cfg with TIFS firmware
    updates
  board: ti: am62x: tifs-rm-cfg: Add the missing tifs-rm-cfg:
  arm: dts: k3: am62x/am62px: Enable tifs-rm-cfg in binman
  board: beagle: beagleplay: rm-cfg: Update rm-cfg to reflect new
    resource reservation
  board: phytec: rm-cfg: Update rm-cfg to reflect new resource
    reservation
  toradex: verdin-am62: rm-cfg: Update rm-cfg to reflect new resource
    reservation
  board: phytec: phycore_am62ax: rm-cfg: Update rm-cfg to reflect new
    resource reservation
  board: toradex: verdin-am62p: rm-cfg: Update rm-cfg to reflect new
    resource reservation

 arch/arm/dts/k3-am625-sk-binman.dtsi    |    4 +
 arch/arm/dts/k3-am62p-sk-binman.dtsi    |    4 +
 board/beagle/beagleplay/rm-cfg.yaml     |    4 +-
 board/phytec/phycore_am62ax/rm-cfg.yaml |    2 +-
 board/phytec/phycore_am62x/rm-cfg.yaml  |    4 +-
 board/ti/am62ax/rm-cfg.yaml             |    8 +-
 board/ti/am62px/rm-cfg.yaml             |    4 +-
 board/ti/am62px/tifs-rm-cfg.yaml        | 1476 ++++++++++++-----------
 board/ti/am62x/rm-cfg.yaml              |    6 +-
 board/ti/am62x/tifs-rm-cfg.yaml         |  867 +++++++++++++
 board/toradex/verdin-am62/rm-cfg.yaml   |    4 +-
 board/toradex/verdin-am62p/rm-cfg.yaml  |    2 +-
 12 files changed, 1654 insertions(+), 731 deletions(-)
 create mode 100644 board/ti/am62x/tifs-rm-cfg.yaml

-- 
2.34.1

