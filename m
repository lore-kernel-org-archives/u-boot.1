Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA58D74ED8
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 14:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052F183B21;
	Fri, 23 Jan 2026 15:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F8kdcCmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF1A83B32; Fri, 23 Jan 2026 15:17:43 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53FFA83B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9mVUmE5fHSbl6MZFZrhEKBMcwiphz0zL4TsQJzpfrkvjFAQPftiWybar8jOJnJ64LaJ7uCd2mUieF1NuHIRCThWjJVz5qhjrpLIEPg/YnYoiIs3IZ6iywcSDDxe8IvpQeM3OB2z5xQCuTxkJEtj86Pa//RshndrFBoAz38n3WwlIPl6ahzi756yLc+IcYEilB0kcm/EPocZpxEw7pbFcjro5b04Fc9uqt2DbOXZYtw5KhooeCMLLW0y0KyA0JARfDTpOCOgDhU8gP6uyrl555v+YWFvze/jN/osmnHkdjjhn79yRhlagEayDQ7fwBJb3TGvZeP9CuQSHRNWV0PIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yGHS7KHehE3/NB3zC0jwR9DDWSsIoq1aCgms8p+VFE=;
 b=DObDOPjg4zNY1qEZaLnEqUh3nuH3vxDK1rUjAFQENbc1Z2qq3oywIZERbr5QfAhAuUEvQEHMEKrN9uAVHzsN0zNsrPMu1l+mpZttLvpuCB7xgSSriDjRCyCFqSh2Vop9TceHYMjcWRUcIH3gB6vCm374bAFkMUVasbc8e6RKvFxpjyteo3GoKEnAWRjR85ycggXHEMo/n0/sNpeIalF1NLZFh6oHSWdYXypov75bdVi3tvXmuO2n4FvG7WW+8E068JbyIAMf25epTJ6yLVjMjyojUNbzQDe10IyH8GH8yqWYqebc+hcjA7jzjEAxvwYiFOpR2k1u0a+8iUyFnOaOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yGHS7KHehE3/NB3zC0jwR9DDWSsIoq1aCgms8p+VFE=;
 b=F8kdcCmxMj4zBOAWjO4zzOys+vNiGTGzDNy1q4TA6IQb9qWBpkLqD4aUh5qhz52EiPe8foFSx/NDDK/ho/TXLulp40ndByNSpaX6kpLHWeMoYnnz5DT1C99hxA8FG6TYyB7JD4CfkTB+AeGmCinj2WiK+3o0VtesHabuefCj9nY=
Received: from CY8PR02CA0004.namprd02.prod.outlook.com (2603:10b6:930:4d::21)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 14:17:34 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::3f) by CY8PR02CA0004.outlook.office365.com
 (2603:10b6:930:4d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 14:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 14:17:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 08:17:33 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 08:17:32 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 08:17:31 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Raymond Mao" <raymondmaoca@gmail.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v5 0/3] efi_vars: Implement SPI Flash storage for EFI
Date: Fri, 23 Jan 2026 15:17:20 +0100
Message-ID: <cover.1769177838.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2414; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=d+mEaGRmP58uN/hfsRYQ+m2Or0McctQm2iQiErfYTrk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQWN32a9/7Rs4c/Xd4vXPL9n1lbl6HKfM3dN11dl/NMb
 +Sz3nf/WUcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBM5LcLw/+Eh59evZn/NlLV
 h//hqrbOSclFzhq7OtWE7y/f9OyewfsSRoaFIvOXm3o/cDDu2RziVCBjc2/HIytjt+sJ7Asn3Gl
 7nssBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d05d45-c4f8-4252-c629-08de5a8a26d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PBXq9wzzrwyvk5e5e1EHP9PX/lHQX0XFDpIqOYIewIieuyQvkxGXLnoY1KGj?=
 =?us-ascii?Q?7KZr42MxzuUA5UWWa50OPt+wj2rW9YUymflnDZcBg8YJrBuh1deSIozW9Vlt?=
 =?us-ascii?Q?S10H0CaldHBLVVhhB2w3YrNaNP8+Tn+8UigEuih7cZmahTaq0zt8zWHHZCgD?=
 =?us-ascii?Q?vuW9Kuo2M6QKAOJreCw3Jqwav0Ow02OgM7MAONGbeFZiNKxycI0FrN9VraEp?=
 =?us-ascii?Q?kEm02GuaRYK686nd683rV0fPd0xKE207giW0EwfHXF5fTkweTVR73h3WUMPJ?=
 =?us-ascii?Q?9b4+AIqOcb178t5z478sn2KGOrA7FxMMkMP4ZM301pNeAlgEtE0p1L9Sq4S1?=
 =?us-ascii?Q?MfJ+zYyyNLT6AqfrVMdfd4hAbjMamHuCwsmsLs6uc8MF1MJ1jHkx3MiPjTIR?=
 =?us-ascii?Q?6EFjL2MqE8S0nEO9nHYtuRpziHfOGKkc69H9nUYNfqcZ9NQJ1uIvyvybcstz?=
 =?us-ascii?Q?l3yuW/vvTyirvXJOnH5bXXCNsrvSL/UxaPrCoY8WTiZpY8elEgO1xCMCGlgY?=
 =?us-ascii?Q?r28Y9bBhA1QzQSsCbjzxPB03E4O87ERcqV4FQ1FdNY3uftJ9EXjNeHcqzQbJ?=
 =?us-ascii?Q?JzWWHFXHkOB7PwluXvaWIgGMfV9cAX1ZKCQODgV/aj7EnYOa1OR35AJOXHLs?=
 =?us-ascii?Q?hBiXvGvVPbT73vMpo3vDgIl3mGVIvchToK5yUpBdixsCDC+w9EJZhG9NzWg3?=
 =?us-ascii?Q?Pknf6A5A/fWcW3KzQXbnA0f0xevRRbq0DQAIjpjP49NdDqgL3JcMVZ9hfubx?=
 =?us-ascii?Q?yyjXBGvtgDHi7BJtmI9uzLvT60A9wJteIyxYqpQ3a8eANZsgM/KJmDCekG75?=
 =?us-ascii?Q?/2OPV9pWMRVlggsSscw6myKuDD1WIE12RHMw6CoWS0218lWvh1wI0gtYi0DG?=
 =?us-ascii?Q?P+RBjDWzpDFtRpjeBgc/ncIsTmO5gmkidvOLEzR4zVqPZ8fCHIBjlw0MVsRc?=
 =?us-ascii?Q?Qx+46EI5wip/wje3gKg4/wcsAH1FC9d8jHJIxYm2w6RiNGjy/fcRYW1IOtYj?=
 =?us-ascii?Q?lgnA1/eIumNFRP2Y6dg/nL5KW0ubwANTM/5WkZRYg8OCLE9Ig7wFL5haYzsc?=
 =?us-ascii?Q?s7Oak/jMJ83d+FXQ1ezWDeSQlDQJpWIFukeI86utmoXJcuU83jGI6CyWV0UV?=
 =?us-ascii?Q?deo3V+AK04nWincm3e5uOmn37J2iJCh7AiTAI2KOW5L5T7jkIt/nHlecR7OJ?=
 =?us-ascii?Q?dI+F3yPQo28hsPLXnwO3Xi7y3eHisfPnZHEUwQsO7iGYZ8/llBgAj/s7TiIK?=
 =?us-ascii?Q?KJMGwFfdIr7CtpZReVvaApdjDeNPSo31RnnJ+48jhoAltEjpw0gqICaEg/3Y?=
 =?us-ascii?Q?be/C9wdNnuqQOC40zoi5i9+sHrWCYnNzLWHIFJrdfjmBHVAcOA3hnDumP/nX?=
 =?us-ascii?Q?MgitZe1O2v/ihLFZG7GST5hPNrpidN4BIibQPDw1KGYBRdAY1a3TwhOxL48i?=
 =?us-ascii?Q?82z4CTEWvIbksGv7MH5c5zUCAafhxyutHsU8L/OzvTdbLfgKfnZ84cuZl9Bd?=
 =?us-ascii?Q?U82TMFBnnaMlLNjNViTyAidUrU4yhE2FeA/U/eI2UFdUmWbDUVaivTnKGT+s?=
 =?us-ascii?Q?fv9h2kamWXlSSRW56A2AJrzk3eAQQt8zgmrOyyCglva5fno2Kq+zP0oYiycw?=
 =?us-ascii?Q?/yBAdRfAH7Abz9WjQq1vvPdvV8xBa1PN4CyrIONZAZ8cuPLjpSF0Z7vJHKZo?=
 =?us-ascii?Q?3tCEnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:17:33.5610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d05d45-c4f8-4252-c629-08de5a8a26d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411
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


This is updated series based on v3 version sent here
https://lore.kernel.org/all/20231126220836.374956-1-i@shantur.com/

that's why I am continuing on v4 instead of starting from scratch.

Tested on kv260 with saving variables to location where User MTD partition
is.
CONFIG_EFI_VARIABLE_SF_STORE=y
CONFIG_EFI_RT_VOLATILE_STORE=y
CONFIG_EFI_VARIABLE_SF_OFFSET=0x22a0000

In Linux:
root@som:~# mount | grep efivars
none on /sys/firmware/efi/efivars type efivarfs (rw,relatime)
root@som:~# printf '\x07\x00\x00\x00Hello' \
  | sudo tee /sys/firmware/efi/efivars/TestVar-12345678-1234-1234-1234-123456789abc
Helloroot@som:~#
root@som:~# dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
       of=/tmp/vars skip=4 bs=1
1352+0 records in
1352+0 records out
1352 bytes (1.4 kB, 1.3 KiB) copied, 0.380992 s, 3.5 kB/s
root@som:~# flashcp /tmp/vars /dev/mtd16
root@som:~# reboot

Reboot and then in U-Boot:

ZynqMP> pri -e
...
TestVar:
    12345678-1234-1234-1234-123456789abc (12345678-1234-1234-1234-123456789abc)
    NV|BS|RT, DataSize = 0x5
    00000000: 48 65 6c 6c 6f                                   Hello
...

Thanks,
Michal

Changes in v5:
- Invert logic in efi_variable.c and avoid #if

Changes in v4:
- New patch based on review comments from v3
- Extend Kconfig description
- Extend commit message and describe efivar missing part
- use unify methods for reading/writing variable

Changes in v3:
- Fixed compiler warnings.

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

Michal Simek (1):
  efi_var: Unify read/write access helper function

Shantur Rathore (2):
  efi_var_file: refactor to move buffer functions
  efi_vars: Implement SPI Flash store

 include/efi_variable.h          | 18 +++----
 lib/efi_loader/Kconfig          | 34 +++++++++++-
 lib/efi_loader/Makefile         |  3 +-
 lib/efi_loader/efi_var_common.c | 42 +++++++++++++++
 lib/efi_loader/efi_var_file.c   | 65 ++---------------------
 lib/efi_loader/efi_var_sf.c     | 92 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_variable.c   | 19 ++++---
 7 files changed, 195 insertions(+), 78 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

-- 
2.43.0

base-commit: f1e312364c7ea2bc4936472dda22b8c0447cdb03
branch: debian-sent3
