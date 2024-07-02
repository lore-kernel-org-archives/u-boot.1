Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409C0C30653
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 01:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1158C8863E;
	Tue,  2 Jul 2024 03:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YqsaODbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A69881E7; Tue,  2 Jul 2024 03:14:56 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148608840F
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 03:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ2au6u6klCqIchFRByjAe8DE1vDH7cqEJGO6ErmoDb/+dFULiu1UzuZg9ITuTpWdYGX/e6LMzPTVExgMWjUygC7M85hmgTvzF37fXJLdloyeJaBweEHPaj2/+f5PUFopuAu8c/ZlJxno1B+xdB0tydCax3W1ba6xU+AEwq0bxrjn4oPiMuG/h/6HY7haJ8euf8ghhsI6ni6GckOGD1lc55ZufYEZ2kabbD6Rw5twVO0yuELn0f2u5jZ2201Wp6pZurI+MQTwrlaTVXxJ4N0LqmufDCv7v0U7H61eZf/qNHkhJPkyLTFJeV7aQgOZARk375vINlhQG2/Oggiq/dWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GNI/CpmscAsn5bL4KKJDkKQ1XykmCpWRP62bUxPi0g=;
 b=ByM7npw2UBuS6qnBnaZM+668HHHUrvtM0ttyyGEC4ic1mplTc5cwvmNVw1yYkOjFy52invE2SgS7ehbNkmsfhssSoHa3AWqwY6Vi2/Knr92FcsocyFb+VRUU/Rm3jlqdUaPb6tXJC49P4yxUKFKkMQ05Kw6RMOE/6AQkTiIMXulCV2R9hgV3iOim4FWbTfHwEmE1B9JnFKi8VkuGrQ4zmR+SxKQJyv/0DitHlrK8Oyn+t6QZJihKir1myHvAf8pQU3y8fPxqv8Z4OGwhpq18o6P5q7QJ7pEiOAQFnLk3Z47XNeZ5lE5UBpQPKkiAB1jj7Tn9zfO37s9atE2R6GwP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GNI/CpmscAsn5bL4KKJDkKQ1XykmCpWRP62bUxPi0g=;
 b=YqsaODbg1kE0J1LfBSMrd07dMOUyZ1SrZbImSkGpvwFiUaVq61M3ykLqPVIc0LqQpF8TQJ1mQr8Phb3LYtUu82Gz7spwml+SycRFfPFszUQrBhhS0E1zhVno4wJby2SZFQp4dXFQTLc6Jmy9S8hAG47M4Sky5AIb3UQvEMGVLSM=
Received: from DM6PR02CA0117.namprd02.prod.outlook.com (2603:10b6:5:1b4::19)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 01:14:46 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::4a) by DM6PR02CA0117.outlook.office365.com
 (2603:10b6:5:1b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Tue, 2 Jul 2024 01:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 01:14:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 20:14:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 20:14:45 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Jul 2024 20:14:45 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC v2 0/2] FIT documentation link vs copy
Date: Mon, 1 Jul 2024 19:14:38 -0600
Message-ID: <20240702011440.2888308-1-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 0883a5ce-7608-4054-98f1-08dc9a345cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4UobPfupyQap8VmKkafFA2rV+xKhpBU32Yajyi+yR67iCzPDhBPkgJaL0QNq?=
 =?us-ascii?Q?zp6tzzCrZwBtBIw95/a9nISo9tuyptsePdAGvKihnbpIDtzJ6+Cqxh7C4ing?=
 =?us-ascii?Q?lgQSyZ8HScoiEcvBzNVvtlX+29WxaNIfCSqH4WNBBJ9P79ECkCvpiWkFt+iX?=
 =?us-ascii?Q?aHCMZgCatKbHOwlu0ymDZExpCSk+4F4jRS49elDr5b6EA6IOA/KB1GCPjPah?=
 =?us-ascii?Q?/AGtm4vf4D9yuHvawshxCraP5580XXd3CDuYps5cQGhD5oEwkUnO9IGRqLA2?=
 =?us-ascii?Q?eTIzyiOMo0XIq+/xsoYCXUhkia2B+iYvcCXxhf5m9Ba1SPH3LO7x7NwcYUKL?=
 =?us-ascii?Q?7FJgG5xpky5gD6SVnqRRZ23vfucNB0hTXK1JsOcEOS3PWpt/KD2ObUo2a91a?=
 =?us-ascii?Q?zNtBZLWGo9R56wowuvNC2kyqLtUEIwOOFFwEACzJNAB62GOR9gOJUAsb1IdM?=
 =?us-ascii?Q?zD3nQgBnbiHtKhoydrQ0uEo3q7qo8HvpESBMu1JaNbDrRBHUOmsK1sgJ9bte?=
 =?us-ascii?Q?r4/9KuIELxka1ltLD8qC3hi7pAiHel57icBTZLLhqPU9okvvgwpiaCCe0Hh+?=
 =?us-ascii?Q?gHlGTFDKSPNeyqMTdHBwsvHeiJxvIux+3ieusU5kLrWCVnSjc30nrBdlPAds?=
 =?us-ascii?Q?L81mfQbRYORI6XVe8irEqRrJ+haoz1tQguZepV8+J73voJdRUGVh1jryvTJX?=
 =?us-ascii?Q?jW0dWi0i7XWMrYwVnRWXWXD7fWbIAUCzLeXmVfJzRxUMMqTdrsBp4benOc4C?=
 =?us-ascii?Q?2O2QqBS6+w/E+d3icNXc9VNusKnA2rDPm9AQ9fpXKaZ1KhgesUAyvQYgtcLN?=
 =?us-ascii?Q?hMUCLF8ETw2ccuU3fNIanSDgIfXqi177HF9413coZCWW+3TLq/HMK7wAPk1u?=
 =?us-ascii?Q?CtUf1fEUgUL8az62WFiO+gFLGBdXfBjg5N9xON5Qex3QZrFrt6Q/3Bb4nRri?=
 =?us-ascii?Q?Yft4fvUy6Vj7CjmxT8h/tgeAdFi46YN+OFNMS4CZ2TO1L43qIKUYfZfRBqiM?=
 =?us-ascii?Q?J0XJq7aIJrxtqb82vzvEFxrOEz9zHxsr5wOVW/aGbIX478Cnqf9JAZg2mAR3?=
 =?us-ascii?Q?leHp/fOVEzhtU1HMUZLom7s9zPg38zeBgeEETv4qjPx3+ZC40xj6trwzP+N1?=
 =?us-ascii?Q?wQperyV5tLKLEXtKSvFiPiLQx9JFyRqTvr+l3xaWncLPFN+jR/nMau/aQuWB?=
 =?us-ascii?Q?0eN2dQWYJUYkLnnzBNO+ImxI6Xlo6T+3DdLqwf/P7sWbqFc1ilYVFHJkVTts?=
 =?us-ascii?Q?Vdyzqbh+FHeyD6ReFRQ+HW4VFoUXv2AhZJBUQSAsB6o4OvnjOq0MWxFlo2Um?=
 =?us-ascii?Q?VAH9Z+kr1/KS5wuWVaifrR/2I07nZBtblxt9EjZoLy3ZtceokpN4hOSFcRor?=
 =?us-ascii?Q?LyhzKq6hqThAuyBxaHRtC51SuxbhD9KSCurgm8L5hOe5UXb1oSc3gXO18opC?=
 =?us-ascii?Q?xQ1SGYVW8jslq2EMIPQHHttxINV9eXdY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 01:14:46.4089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0883a5ce-7608-4054-98f1-08dc9a345cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
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

I'm proposing linking the FIT documentation instead of double book keeping it, 
it does have the disadvantage of making it more difficult to see the 
documentation especially if offline. 

v2: update table of contents instead of removing

Sam Povilus (2):
  doc: Remove FIT documentation that is elsewhere
  doc: add missing table of content links

 doc/usage/fit/index.rst              |  25 +-
 doc/usage/fit/source_file_format.rst | 682 +--------------------------
 2 files changed, 25 insertions(+), 682 deletions(-)

-- 
2.34.1

