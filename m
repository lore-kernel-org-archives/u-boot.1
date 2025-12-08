Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC14D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 13:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A3E83B49;
	Mon,  8 Dec 2025 14:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TH2c2XE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9241A83B4A; Mon,  8 Dec 2025 14:20:53 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E186283B32
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 14:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJrVm690uYhgwpAuJMifYMqIVSQPiveSuAZ8AmtfaJDiqtqZhH8leOyThahhQMQ3UdfJc4RoNJMdDcNSY6/l0Twm7cvVtn9DDoEVYX5ZqvvuC8RwUnF8T7zAXCNcR2I0VxcK8sv1qln44+aXvua4SjWUj4VBvGrASeFDeQxib61SO/bO5N4EaycPX/03RTdnWhQyW6y2CWc8mDMldx1AUqJpTEGao7s1O6saYkHILdWXGAwehJJWvZuxGgzlE7FtdfuWKPd48v2tqL7T9C7n7rrwwMV/ntkgkDAk50eYy5f2TZRN/KZOYiglk26KctT9GGYeDQK6rjYMNEArI3knaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Iddkdnnd6Lu2o8DAFXz0CtMQHfySGyXVsnjPRWfC14=;
 b=c0Q3uT7xUX1hP+hQFeR14Mkury4N7Wfj9qBGIvMwAGV5jTE2qOMaihzMWSEuXzLzKHQCtyEWmaRe+zLDo4LWLlOOaW8WUiz8KlQA46sXRKtYSEOsLaQ9x7WevbJyV01ZopJDAZ136d1WF30/mx/xP0wmmtfgmbA3hes2HFyz/XS1MEg/2AdDAulQSJ6dc9xkD3ETgkn3iEmv88D1rLAIqUVPl+K+Fzo1Lh1Uha+dNQ5Xku/tSxsnWWPc7LxzdlL8S4gjwFnTcP8RpScZ0qq6JSG6GwWQGKZTjcuMnOQKW4v5+uW1ZotOOalP2+V/Aia1Qr2c1KYZBefu47SO18YOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Iddkdnnd6Lu2o8DAFXz0CtMQHfySGyXVsnjPRWfC14=;
 b=TH2c2XE9nQJT2N/ImV6TFBYB19LgVKvZuPUDvdpUYU1na5/MjL3NSspm4zpAiKWSaXektqiXX9usP5iUt5k0XPfJaUVlKu9HDxOBaJNnUGtuYxYaoSGakGBGzs7qeoud9iJhLUJmaE3aarVXtk8ez3CwLykUCPxeWEeUXrTlWx8=
Received: from SJ0PR13CA0154.namprd13.prod.outlook.com (2603:10b6:a03:2c7::9)
 by MN2PR10MB4126.namprd10.prod.outlook.com (2603:10b6:208:15f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:20:45 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ec) by SJ0PR13CA0154.outlook.office365.com
 (2603:10b6:a03:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 13:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 13:20:44 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 07:20:43 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 07:20:43 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 07:20:43 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8DKhxD3672812;
 Mon, 8 Dec 2025 07:20:43 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 8 Dec 2025 07:20:42 -0600
Subject: [PATCH tiU2025.01] PENDING: configs: am62lx_evm: add GPT GUID
 partition types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-gpt-support-v1-1-0cde970713c3@ti.com>
X-B4-Tracking: v=1; b=H4sIAKnQNmkC/x3MTQ5AMBBA4as0s1aZFkm5h5VY+BnMRpu2RCLur
 izf4ns3BPJMARpxg6eTA9s9hcoETNuwryR5Tg0adaU0Grm6KMPhnPVRoipKnEZTz6aGJJynha/
 /1kHk9kM5Kuif5wUjpxiWaQAAAA==
X-Change-ID: 20251208-gpt-support-01340cb89d89
To: Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
CC: TI Linux Patch Review <linux-patch-review@list.ti.com>,
 <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MN2PR10MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aba6b3c-e4fa-443b-d8ba-08de365c97b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YitjbHFiRGp1UnpiMHB4NWpRbXZ1OFhzT2NNZnZRbjhsbUU4S1JvVzZSMHpK?=
 =?utf-8?B?VmhLTHVSVzJQV0tSVlZtVitISm9TcjlVeEZKenZJYXI4K0wySEVFN29qQjlZ?=
 =?utf-8?B?MzVEVFIzeWVuQjBNeUdQWVhXalBVaC91SXI5VHM5RVFyR0RGNmUxVldiMmYy?=
 =?utf-8?B?NmhrQlk0cWFzV3cxVnNHRCt6UHJVTnVkMFZRRnF1bWxBZFhQeWJjQUV4MGZY?=
 =?utf-8?B?ZEhtVU5SWmxNbTlVT1Nrc2o5T29KZk5xcEFyOUFsZXJTVFBQQVpEUFNZZUhK?=
 =?utf-8?B?WkVwb2l0Z3htSlRyK0prT2RTSEdYbkFjcXJjMEoxUEhSUU4zc3BDdWpEV2Rk?=
 =?utf-8?B?WThsWXo2ejlwWWFRSHdXOTFKM3JZNXhkRVBaOXlNMDdZQWg0bVJ4M2xtay9n?=
 =?utf-8?B?UlVtb0hsTWQ3YkZwb0JyN1NTTVdSYzhGOWpuNEpIeEs4RmVDTTRDQWZGWnF0?=
 =?utf-8?B?ZFpjMStxZmM4c2lLaURKQ0JQR0xXV2Y1S2t1ZmZGZVFmdTBUTS90TVNxd0VW?=
 =?utf-8?B?ZHE3RzNqSldLYXJEVU9EYmh4YWRQNlp5YnVneFFWbkFFbktBbmVKVGQzbi92?=
 =?utf-8?B?cGFOUGQ5M1o4bmFnVVB6Uy9yYVRBMjlnUmlGTEYwaFkzOVRFZ3gzdElmL0kr?=
 =?utf-8?B?N2h6bHRLSTVZdEljRVVsZ3FXaUJ4MGJNajF4a1pCbnc4Y1BXcXFzK3NuL1lt?=
 =?utf-8?B?TmZYdXFWdHBJK2JZQTNiT29qWE9JNUZnVStKUG5aenVySm5XaitGV3RXd0pq?=
 =?utf-8?B?Q3VtYTJGT3J0WkZlVzdqc2JiMnhON0YzWlIvWnBQTjdBTGNXQmNjaHVMbDJ0?=
 =?utf-8?B?dHc2UkxUS3Y5NlFQc1dub1gyRlZUVzFSaHZXalpGZjhYaDRxYnJKMzJ0ckVD?=
 =?utf-8?B?M0hhbStXZEVoMDNGeEdZUFJzak5iQ3pZdmF1T2xYK2grWld1aG5HdUVDSEo5?=
 =?utf-8?B?QXAzQ0VNUmo5WVl0WElvd0dUUzg1YlJlMVoyN1BQamg1dDE0V3N6OWw1OXhp?=
 =?utf-8?B?RTNkKzh3dWtxODJ2NjlEOHVsUjkvZHhPQngvbE43WitXVUU2Mzhreng1WU9G?=
 =?utf-8?B?M1hkb3JXQTkyei9lL2Flalo2a2VuSlZNTm5nYmdmM3JWVXBSK29iVWFBaFhu?=
 =?utf-8?B?T1ZXVHlyaGJiOE1OMWhWL0lsQVJPTlovRE0vbDRqK0tiOG5DY0dDTjdwQjZI?=
 =?utf-8?B?S0dFcS9ueFpGYjNTWXlhV1Vqd2t1UU05dWhLdWVIZkFTdm9LM1JzK1VCRnFP?=
 =?utf-8?B?VXpGYm1IUVQ2WEorVXhhZHZOMzhMbzA2dFFQNHJYQlNGcndGTkJ1RWJ6c3Iv?=
 =?utf-8?B?V3NOWFJtZWRmbHliWDVnVDJqenRWY3lBUUdHeXk2dVhuMFAzZWZiQm1yVDBr?=
 =?utf-8?B?enJ1a1gvcUpRSERHbVg2Lzk4ZzEvZmgyN2o5d2prNWlTNW5uSitKcW16NUxC?=
 =?utf-8?B?MzR5Z1BMUkZNSUJhSFhqVG9zVFVQbzNqQUNLR1ArVEV3YWpob0YvSzFxT08w?=
 =?utf-8?B?REcrdHF3dWtjRFBZbUxtVTkvMlg1TGdTdjFWRjE5aUlXRTg0dk41ci9xYU5F?=
 =?utf-8?B?aWZqWklTYkxWL0N6Wm90bHMyRUpEVWtIak5sMXlDZGRIUnI2eEFLRWF1aGVE?=
 =?utf-8?B?b29tNDdXVHRXNGRhd3FJbnU3NXp6YVdOYUxqMzBwQmF3M3lWdW90ekFJaFBS?=
 =?utf-8?B?dVJEYnI3MjVyU243c3hpSXBGYlFNTllob1g1SU9OQlRhbjR5Ykw0NUlJL1hk?=
 =?utf-8?B?RFVPZTdEUW9WREtsaUp3R1htRWg4WCtIRWp2WURmaTJZcDJYQmlISTNuS3RO?=
 =?utf-8?B?L2IyUHdiTFEzL0srdCtOa0pwak5hdXlXNW5ZdklOMVRwRFZZZFZJRGNvWExG?=
 =?utf-8?B?Yk5FV241R0ZpcjVmNHE2UERKb3dqZm5FdElTLzlaR21ZTnhlSFdVa0lLTnZw?=
 =?utf-8?B?R1NlMEZHMGd5cDR5c1pWeDhZNVA1QVVVOUtoZVI3dHYybDVJM1VxcjJUL2Np?=
 =?utf-8?B?SEpoZHNFcHY0UlJNaE16OGtRWmdOOVdFRWVtUEhzd2pFa0tlL29TUDhGanhu?=
 =?utf-8?B?Z0crWmg2YU9xRURlQTlCalBDN3pCKzJiRjFWc2VoSWpJemxQUUtoVS9XdEFX?=
 =?utf-8?Q?RIHQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 13:20:44.2512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aba6b3c-e4fa-443b-d8ba-08de365c97b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4126
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

The AM62Lx family of SoCs support booting from a GPT partition table
however the boot partition must be marked as an EFI system partition
(c12a7328-f81f-11d2-ba4b-00a0c93ec93b) and not the Basic Data partition
(ebd0a0a2-b9e5-4433-87c0-68b6b72699c7) which is used by U-Boot if
CONFIG_PARTITION_TYPE_GUID is not enabled.

When using DFU boot to flash a new part with an empty UDA partition
using the correct EFI partition GUID will still result in writing the
basic data GUID which leads to unfun ROM debugs.

Enable CONFIG_PARTITION_TYPE_GUID

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 configs/am62lx_evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
index 139e9b07df4cfb065764acda477c19b31544ed27..532bb0454dfd00bb7dd2e9d987f4110305f81ca5 100644
--- a/configs/am62lx_evm_defconfig
+++ b/configs/am62lx_evm_defconfig
@@ -148,5 +148,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_DM_THERMAL=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_PARTITION_TYPE_GUID=y
 
 #include <configs/am62x_a53_usbdfu.config>

---
base-commit: 7493977a537fe3f8a45814c6284b942f7f09e035
change-id: 20251208-gpt-support-01340cb89d89

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

