Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864E6C27C52
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 19:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A375788126;
	Tue,  4 Jun 2024 21:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EFY12QW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EFB687D0A; Tue,  4 Jun 2024 21:53:45 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 056D7878E2
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 21:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K385h5unM16HG9YuXmsZDv+RIKniYlMckJFbkx7e5cjmN9Koe0N2p3ImV8bwujirt1htc7cxWpp/HcL64n45qAaSfDPQeVg9l4RqZzEbx08es9y0cBozbpIK2Ot/NA48PhmRUgq+EUrWYvj771/QQ8+MKGofHa2XgqTKlxae91/+4f84rUI5SAxs7TvJ6ZEdGYU169wDeqfddZuRWD6LKRmvHqt74eleryUwsE8lPnI4LWFtznKb1Y+84hRnI0+ae82O68+eNA6HwYR1C0hvAgNWLCkr+LjXTlBJcTV9A2Bz2ng1BxOW+Dz1XoCWuQmaF7PwH0I8v2oJGT75ncw87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8tPtWWRqbXCf5cxh8mzdnCLHJNqKfaP8z/X0rMBlNo=;
 b=kbgqtzPS8kK+nGTRbpzbninkO9QYpSwpSaV1W7efTvfsPHsUceB0xUhbnOZC9qdSRhZo4ruevFSsrn3H2lMp0DFsDNMx5U+StMVbcG/5n7ecOTDIetNn3fhZTg8Fp94MnXv0K8DPBwG6ngsAVtV7MLH/e3t3Vudn4d2JENpDV3rxbF9Ke/up6VmwTeRU5nXdY6OpnP82jlsGA2xb1bmMQ2ae6pbER7mkLnvZijagjjn3SmkE3m8V3u1AnaUK0cD9Y1aN4bvqtX+f+7finD3eWO/rxTrmvaykanIWM62ywvXBUgVa3NVd0oOxQ0Ogr5zDLEkl+MVG05jQxPFS7eqsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8tPtWWRqbXCf5cxh8mzdnCLHJNqKfaP8z/X0rMBlNo=;
 b=EFY12QW7Jxh30CaPbWj+ooJyjUoDDbR1IX5ouNX1Z/leH8nmAPQR5v2q1Chvilo9Q+5iTY+v2NAmpGI7A8qsRLwDv4HR75r8BeeBrk3DtDohOUQpNhj/k+PUjSDuXGyI4ecTFeWOTq/vd6has2LbVh9ZzmeFYRTWUo1ELx2rRnA=
Received: from MW4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:303:16d::29)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 19:53:39 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::2) by MW4PR02CA0014.outlook.office365.com
 (2603:10b6:303:16d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Tue, 4 Jun 2024 19:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 19:53:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 14:53:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 14:53:34 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Jun 2024 14:53:34 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, Sam Povilus <sam.povilus@amd.com>
Subject: [PATCH 2/2] doc: add clarity to what a "fpga" image is
Date: Tue, 4 Jun 2024 13:52:56 -0600
Message-ID: <20240604195256.1820285-3-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604195256.1820285-1-sam.povilus@amd.com>
References: <20240604195256.1820285-1-sam.povilus@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc9fd49-6b41-4391-ba14-08dc84d007c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qRpqAwAkojAVCs/s7N9EHTwKQ15/5b+u9zEjzdwP7YXIAxnoZ+8mDBfh3Ug8?=
 =?us-ascii?Q?Iija6pEuysT/tXFGGifuahw4SgGl/aDaEEExvQlQib7kyQiz6tIJoBOt6tgP?=
 =?us-ascii?Q?lmJlZNFQN7YRWAcw8rBtn0zWuwfTox05JqP+HOvudrQs/CQUOVL5+GBxAhV5?=
 =?us-ascii?Q?KPHJIP3XBD5QSXPd2OWotjWCs5FR95xcNT29NHUM3IfELd9oF07A8eD28iSf?=
 =?us-ascii?Q?Ka4QxQr6f+yjSMy8t4ba5u+cSg2mPavxDkhTcxOYnbB6hRwAbH3OBRx+Wpet?=
 =?us-ascii?Q?fq5leG56zfp6NsrF8F/vJ8v+18JPbZmoMVP6aqgkFyJSOUjEjfFN19A6EY62?=
 =?us-ascii?Q?Itzg891zbbqUe5d1pU2rJd9McDEtP3QTD1jqMVFZ7Vk7sYc7o2HXyM5ITAE7?=
 =?us-ascii?Q?4z7RNHLFjkA30yUmIhGyTwTlw45m0/4WcC4hgegzuTdSChQD2BvD3MokFldX?=
 =?us-ascii?Q?JIjbyc3GGYdiDIw+9E5WpHQNHezWSv3u8BDxScy5iOpoEeuv08Jk4oHtZdKc?=
 =?us-ascii?Q?Jt3fsvlAYethvBAdskL29f7fS38/lTx5iDHXHcUD6yQUKB84wsuZa6/fwTLk?=
 =?us-ascii?Q?LAQ4+cwJc5O5QTd1ljGfqnDyDUyU1w/s5ahSjETPZ95Mr5X85IL3s8FQ5md6?=
 =?us-ascii?Q?Y3TmzQz66xb7lJ4XapWbBXUkuFM0C+VGreWEUWVQyCcGwKqmK/W9DphdcMIr?=
 =?us-ascii?Q?o8qBAS2KGd7B5nYHRAjJmuAFIfDrOCcOSVZqKZUgueC7fCmxfGVbEjF+MBlt?=
 =?us-ascii?Q?4WUN7N0/6r8fFI5BTTRmOL4RJyVc0cU8pY4QKAsAv+xRJA8hs3AcLZXb87qE?=
 =?us-ascii?Q?rjOA1vsqpkNeF9i357VJTXOcA73eII/fxfAkfviicZCcubU6p8fX15BoWUP6?=
 =?us-ascii?Q?IUjCHcRpX4xcgOjrICT1fK9JxXtTCGrkeCJq0gJ/27vlml7VFAJM5kekMc4B?=
 =?us-ascii?Q?oczQNv1pLtapPfNiha2VVvmdqYZuQF1zTRMNUeeaqEX2ZW7JhAjCV7jCdtst?=
 =?us-ascii?Q?8ixNYtRRfv8k1HXfH+HeVn3dzPaNviFv2O+E2MBBMeF8e3n58Ay9AfmnXaKT?=
 =?us-ascii?Q?7uEDBW3EbuaZTep3cMm5+wsEpZjx4gN/bXnEjuYBxfHgA9S9Z4o1BJoQdE+e?=
 =?us-ascii?Q?TiwwsZDIPmA8G/TLx3cv4Fy6Y9XBvF4YSctumIOqa9KGLHT9pGWvySrp0KKw?=
 =?us-ascii?Q?rmxZjZmKS+ZikbtvQHLqBdF5nwV3MsgaW060e27YbTUFRLQRoQdiYnM6HFa5?=
 =?us-ascii?Q?Gk2xjGwvWKbXMRlZ7ZI8aoHsGr3UqqQCneeUHn+Ph4cBEfosIR9TWgak9I1u?=
 =?us-ascii?Q?lCfw4g2PoiAPpFKYdH2T1Mt5CxtxTZ7M71Rw8VfbvEvFpHOBXcmhWwcJfIL3?=
 =?us-ascii?Q?6vIdshaxWIYEgsJ477QAzzQiXjaY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:53:39.6930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc9fd49-6b41-4391-ba14-08dc84d007c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
X-Mailman-Approved-At: Tue, 04 Jun 2024 21:57:40 +0200
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

Update fit documentation to clarify that FPGA images are vendor specific and opaque bitstreams.

Signed-off-by: Sam Povilus <sam.povilus@amd.com>
---
 doc/usage/fit/source_file_format.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source_file_format.rst
index 310225d839..7727ab77c5 100644
--- a/doc/usage/fit/source_file_format.rst
+++ b/doc/usage/fit/source_file_format.rst
@@ -198,7 +198,7 @@ type
     firmware              Firmware
     firmware_ivt          Firmware with HABv4 IVT
     flat_dt               Flat Device Tree
-    fpga                  FPGA Image
+    fpga                  FPGA Device Image (bitstream file, vendor specific)
     gpimage               TI Keystone SPL Image
     imx8image             NXP i.MX8 Boot Image
     imx8mimage            NXP i.MX8M Boot Image
-- 
2.34.1

