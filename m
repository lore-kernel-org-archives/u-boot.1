Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BB1EB271F
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A9A8388D;
	Wed, 11 Feb 2026 16:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhE3IsqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2716B83D71; Wed, 11 Feb 2026 16:56:54 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E2383015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4tTbVYHpU9OalhjgTaaRYTReKJo41gcul5bFi2yZbb+3LGfQQIP2lcsYnd7TcIRweTs5AVdnKfzZL02rc7tYmqiHg4dRalpCkO3Ws3xRZtbH+2ZYxnAnaakR8QnXQNJYCOhV991AyOMxyXdlcmzuZ/3qgnIsTvc+jnra2srpzCUW1ufqNluiSdI1HV9H+KYS/7Fgpofokzc3JvLfcm8XAy7x/ASMyeBZqGMLdorLJda4c5VXUIGwug5AV4uuiM+OIXAThJ1xwLV4o5QFBnk4L2dpz9SAF6dfe3jiaTaU2FBWXe1YhdyP9EmQ8jlRT/GnzygzZeaeQDPq7Z4aFotTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpIOiOWGOsurqZkWVuaVdVrNBZNE2OOvAqKRNUHkEJQ=;
 b=T6KrfZbhGjVptfIx++3xCpfOFKAOHoGVY7IiQBlN8VP4aV6XWM0NavDTdUyXb98JdcvpTz98tWi7d0tcush92Zn/tVt/dGTDkdmhawodW4UFbpKU6A5Orz7hkpVQJ+7Tx8FniTNLlEJOTE/YonXzwGZILAtMU1hNC3/G/fTYkbybcLPUtiqvV6+di4OTNWRlAFEyvrhraxIPo7l6UgVLq5bruk/ywSYE+ekNOx4nyL+WRM8PkvL0HErLg0jd0Q1GHlz9veiRdg0cXhtQRaIcnN1e0gSzobBMMDvHqmkDQyaV9+AV0R54T+6IvUs3IgBJKVzXawIkBx73iPrEibsu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpIOiOWGOsurqZkWVuaVdVrNBZNE2OOvAqKRNUHkEJQ=;
 b=yhE3IsqX2utAjjQ0jbvMQ6JLIjjRZDqsO46T8IA3N4AajT1ZtOEVlMjpKxtc1m6bZERSidiWrETeNb+CMOJGpUYMgVnsiJ0AIQTGgA9BkDP+XTpVZHIabEpGW0yOW8NLnid5qJo3sUu0bgQQmwwFYKxt+cu51JxiFTuk++H6hsY=
Received: from BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:56:37 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::31) by BL1PR13CA0197.outlook.office365.com
 (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Wed,
 11 Feb 2026 15:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 15:56:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 09:56:36 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 07:56:35 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 09:56:34 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Jonathan
 Humphreys" <j-humphreys@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v8 0/4] efi_vars: Implement SPI Flash storage for EFI
Date: Wed, 11 Feb 2026 16:56:19 +0100
Message-ID: <cover.1770825377.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3006; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=t/wTbpljg1saJkNWfd9gEJqqr+iEKPL5FRkZuPI15rU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT2LFsZuLVasXuubf+GdLfubdmzJebOvR3O7PkjpOPyv
 gtC0y5Ud5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBElIMYGf6WVfcWmPZ1X3jP
 +PchjyHja+VoQe7K6FqeryorU1VszRn+ittWVdVF7+N8rfX+1qOpjMrXLsYXJS2Jbs5o3rhmksA
 7ZgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: e75524e1-e32b-4b28-99c3-08de698622f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bETgKIpFAVhWdyxtgSD7pj6xW9VD2I1yTA58hWD5/XtIwvuVHoIXFa0CdMAw?=
 =?us-ascii?Q?yZP0b94xyn6+iqw7PakbfADe6LOisQ+vlNAc/0pvsUXywNdfwkMYH7q5Ok4/?=
 =?us-ascii?Q?U0R8GGQc/EkakOgcCEH0gNmawplouDnYpEG7SqZQGXAncQ7CrzE1JyWOTLZd?=
 =?us-ascii?Q?q7eI315GNTwJHkpIGRPufNmAgkN8ZY0pnNcnyZrLknQRJQU/NbPmNFiIwbmn?=
 =?us-ascii?Q?yYD2x0LyPGGDcUvWUzcdrlQeF2qVbTIybS4r7c5lhkM612Y0onDTPd5DYFoY?=
 =?us-ascii?Q?kMfziX1gBle9GYuuLMhnXh0ZELGxkBhZXRFZl+P/+Xc7SFhTDkay6t5PTJyG?=
 =?us-ascii?Q?g/MmdqC7Hx9gbyxOf46P7JAEJsA5aTuhDlTTvi6yFliKr6oiIJuQdf5tQKIn?=
 =?us-ascii?Q?3LxQKZQMGolTU71oTAW4B66lylrNsjrnpVtyI7g5xaZogGlWBu+WWoaj/wsY?=
 =?us-ascii?Q?nUIs2YG+MNeo9yKmtnapkY9NruqBJormDbLtcFxCsDehDBUZ8UliLWafclzE?=
 =?us-ascii?Q?DpErcok5jgikRgc+Nhdq/x5KH+/wJuPULJM7Iqg1jBaglM6hYQ9uvh5TE/4c?=
 =?us-ascii?Q?qDyxn08pZkhp0eWW9aEmKy+fDSbYv7wGIOboHeOf6CCLfIHHI/8p5dHMc8dX?=
 =?us-ascii?Q?LuSYXUaitPZzldPQf71RfgSp6ACM+Dwwv7c4PutxjKff6cX/tRdFEoXh2ntf?=
 =?us-ascii?Q?s9v0DhADEAHLCCzHfHki3QFSh8YFZc3+VFofR/ReY0TDUCAJTPKhmRQ73KCn?=
 =?us-ascii?Q?fl0dmUpdI+klO9qoNO34j7G/aSXY3zUd7JaV7JuHTJSjnswrB60eQPp3nMX3?=
 =?us-ascii?Q?hm3u2UX7oHmEkuZ0lQsSd9LsK/UCsXohHTTHrNhNPzcxaTGsoFf1hnKtGoUe?=
 =?us-ascii?Q?bddKDtkpSCnV9rJsvEdKT0tOYsNzQa335HeQm7mDnI2DGRWVfdWhCUzz2J25?=
 =?us-ascii?Q?NwWzg4xvoZEuMcDErdYgEPI9jKslTvaYSaNAAD5+vsrzWak83QUwdhmLUw3l?=
 =?us-ascii?Q?5lfhQFEDuyhwiOoQJF0qy+yauMoKO5jX7x09Ef9oH4edcKOnyyVcmLwXSqA2?=
 =?us-ascii?Q?ENZRsr5OtjuHflmlCMDVcU4giCXL/GwLSStGGCG9I9FS1LVKggYFP0zqEduo?=
 =?us-ascii?Q?wtAu3WrOcXw1DEG+1IMDlIeIEZFLZqwlAbi/HdPTTXybInRwEYaufJh+D7Pk?=
 =?us-ascii?Q?WTDJbFec/eL810nyxnmQqZTR/rN03LzvGiWqd6m7GwyZeC1yskWTjo8QW7sk?=
 =?us-ascii?Q?Pjr08oxORdAkKgjb968EWQ7679hObMYlWCFr2/6FkrS2jNof/9kIr100br1N?=
 =?us-ascii?Q?Oyj0BCAUto7tvGr1Qc5OW50L0a42Ff6Ydr4TRKMz2Cr2fxuDQQbc/uCiyfoI?=
 =?us-ascii?Q?/Ts3sq5SHf02Fjr2Bj/4YNpZMTK0vLIcbei6MrxK92k8KsZzOdJ0KVkoIOTp?=
 =?us-ascii?Q?ubYipCI3Hxi0ihzCzuqNan791rWFpSMDEvmzhoMK4fbRq7V4NJxp5lHzrQS6?=
 =?us-ascii?Q?Lk7g8UKhvmyYkbC2HFFsg5Dp54Q6YzD57FiWPo1FOoOdym1+aUOuSjxmaI6l?=
 =?us-ascii?Q?LOdunx1ghqhZMWVi/6FL9ZgtnDb/yiRf9xXuxezbIjPRxZjYP4HYPn/kD2gw?=
 =?us-ascii?Q?8JQBqVhqi2T5SBCWVQYjvtlpFU1vm4gTAq80t9/DSiUfZLlIjmngvo56DK2X?=
 =?us-ascii?Q?onRl1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gcaGaks121SVl5WRGmmm91UGpJHtZrKpCU7Brnr+5HNbNUvTmBNrIv6KlKGEQdG1f87Ci4+DYP2ZNlNTTpkbWtGCGefqRATkiGUOlubqGyNjcowvHrsK+qFT6mAXucvjE2K9LwKy/svYH3WIL+HYlspF+0gjTROIdrjuKGduL3ybsGLQ5lP76rtQ6+X3dOGVFnR3o3kO/uxPAXpXrCFoe4EWLMwS63f4wrzRJd/RgN2ntU+oowjYHifZKFYbRHSz+0PvSuxzyPHayGl+rB9zylXfwbU85xmctOYC4fq1nTdMnbaBeA8APd/GwmJxLkau/jTUP/QGhsKQg3vQveBd5w1TyM03PEN0I4Ze/h1/a6vrro3UfcUtimIOX38FlJU2lD+Uv0E0INRVyG/LwWeKFd2kyH3Q+BnsYMYmsGa7yWszyVNIBr30TKnyLhoHB59G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:56:36.5788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75524e1-e32b-4b28-99c3-08de698622f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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

Changes in v8:
- new patch
- Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE_INDEX

Changes in v7:
- sed -i 's/efi_var_from/efi_var_from_storage/g'
- sed -i 's/efi_var_from/efi_var_from_storage/g'

Changes in v6:
- Return EFI_SUCCESS in efi_set_variable_int() when
  CONFIG_EFI_VARIABLE_NO_STORE is enabled
- sed -i 's/efi_var_read/efi_var_from/g'
- sed -i 's/efi_var_write/efi_var_to_storage/g'
- sed -i 's/efi_var_read/efi_var_from/g'
- sed -i 's/efi_var_write/efi_var_to_storage/g'

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

Michal Simek (2):
  efi_var: Unify read/write access helper function
  efi_loader: Setup default location for UEFI Variables storing

Shantur Rathore (2):
  efi_var_file: refactor to move buffer functions
  efi_vars: Implement SPI Flash store

 include/efi_variable.h          | 18 +++----
 lib/efi_loader/Kconfig          | 38 +++++++++++++-
 lib/efi_loader/Makefile         |  3 +-
 lib/efi_loader/efi_var_common.c | 42 +++++++++++++++
 lib/efi_loader/efi_var_file.c   | 65 ++---------------------
 lib/efi_loader/efi_var_sf.c     | 92 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_variable.c   | 19 ++++---
 7 files changed, 198 insertions(+), 79 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

-- 
2.43.0

base-commit: 8fe0e8e4dd573290bf845ee3fb12b346509be028
branch: debian-sent3
