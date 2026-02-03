Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2272E8305B
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F3F83FFA;
	Tue,  3 Feb 2026 08:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a/pivlAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D6683FFF; Tue,  3 Feb 2026 08:58:12 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD1783FF9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpY51+iDMOsVTsiIy1/2TKb4/DsjodfLul6ki4qJ8sZctnKj9ZKEYRA50b37leO2Y1yZS9nVQ6iZqWnpS7XoLPaESLKb0h2oG6pmOZKVRYiUJ5mDGzo+3vEKwDLQY7WBvNBai3Yco+W8CZImiu5dm70EX7DGOppIFEe7X0NvkHw4IWlAYHP/N8jr19aHfeEU3uTRnlhf/k8T3bIr0aNio8LxS/HJyLmjSOWLCflRVGSl9Oya66A8BM4yrhjvPYeRztxnFWc4AfJ2/fEYacVBPyLZ+0GSCheFhozHtcu3GocN9JWcWAzRi/crip+Hc/cD3nhoJRDQg8xsv5Jz4qxHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICYvko4NqnuL4RbrmncSDUveKV7TpjiAQ3J2E8p2T3s=;
 b=YpIgW+wfVHvSREavOmpF+Llsu07c4slH0JCmAiq0cbXEu7C90cSrIDEfBsclMccdjgHD3iuU7cGAT3rjRCOlRzvqE9+gpbsO6/FOl5tzLeUjHAgkLD6iDNhv5fQzXBjlUwXUXlPFwPzP6UjUDSFUur53YEwZCY+mxfJX/079zQxSrY+LKCl4cU+I76iJHYRvjib+LjjC8UGAXU5QPgletIlDulCgYctLS4S+cd/o/31w/VACZaDYgsmlC8o6i4/aI3TWdZ9E7v7/h2+HcbK4GQoeeXeNmKZdlPM4IPlqvAfxcAJqw420anm7gcdLZNzQto4/2jsH4Iid6yp0uP4IAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICYvko4NqnuL4RbrmncSDUveKV7TpjiAQ3J2E8p2T3s=;
 b=a/pivlABTI2xIBhjKhpm2algiGtiCyxAcRw3w6aFFnNfvpI6uKX86dqbpAUImkLdQ9ih6pUasH/dk0g+yVnd4VoW69DDLQi6ioJhTocmBUiF484D6WBR4emUx+q2TJD3Cok/L+VBkj2jlBN0mRiLdoBhRTC89u9KWWN90qKXw8k=
Received: from DM6PR02CA0144.namprd02.prod.outlook.com (2603:10b6:5:332::11)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:58:04 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::54) by DM6PR02CA0144.outlook.office365.com
 (2603:10b6:5:332::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 07:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:58:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 01:58:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 01:57:59 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 01:57:58 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v6 0/3] efi_vars: Implement SPI Flash storage for EFI
Date: Tue, 3 Feb 2026 08:57:52 +0100
Message-ID: <cover.1770105470.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/EMkcomMGgmbiJZb5tCGLb4De14Gcp72HgDPwpKTVcQ=;
 b=kA0DAAgWqwf+8E71EfUByyZiAGmBqoKiFpZ7GIFHGQ2jxyNEfUdP0V72BobYD40aUuKSUWJY8
 oh1BAAWCAAdFiEElwIsQKz21qUWp1lvqwf+8E71EfUFAmmBqoIACgkQqwf+8E71EfUDxwEA1vPb
 kN3v58Uqnqi8lire54LF4KR/zFIPtz1ABJhPq5cBAL2Ly98d/3TAit7vXtypU69n9nkJfm8gs7a
 CxNcZahgE
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d24c63c-47fa-4a9c-214a-08de62f9f59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p+PJ++0jtSW1CbW1SDYQXMLazRv9TUHokkhl3b8623Ze4PYIHLb1Oq/DmCQM?=
 =?us-ascii?Q?9aML1qvWFh29+jbGRu716OihFhp847p7JiqqwnjWRx1OlFhdeuOl508oYsM0?=
 =?us-ascii?Q?Re3TIGU8NvQ2APzmlwr6koxMqu3n3xp7mwjFkVXND4lKYMndO6AnMjW7ssfS?=
 =?us-ascii?Q?dKj7tuLdRQWbejT67UOuXe3SIRT3ctlNP+D5UUyOR6z+lGj1XYWNuIFcTe2U?=
 =?us-ascii?Q?A5VACDHN4rea0o5Lmx/gDT4Mo9ipTf32GvUE2yDfrjEsVmyeNs1bOc6X7zUj?=
 =?us-ascii?Q?LHkj/waXjloIHaREy7DTZgYZD2fxUFTP+U/GXjh93OfkDvWKn6h0fbYP0lkm?=
 =?us-ascii?Q?hQSfmHpq+05Ekz6mJ4FN/CAabWxCJwyJHJOHw+hhGc/KYl5K7sO8FMXz9k/7?=
 =?us-ascii?Q?g0zUilihBRY4EChyvFvet4GWJ71SonqoTrOD5+QgRxJzi1nFiIU7sNxTJPiP?=
 =?us-ascii?Q?iJPjA9y3TkIhsSiAHqD5v5V6sgBzdPd0K2XlFLbtY3vIVQGpoQbvvRF610jm?=
 =?us-ascii?Q?pVbT4gCY4SezPV6bXesMvZTEgRfd2ZQAx+DmjixoF3dc7v4U61TIDwKRxTHQ?=
 =?us-ascii?Q?34unxYPOE6d0JWu8F5K2I+KLCIDor0e0+zHjlHrQea4vA75mkXUbkBKJ8pCy?=
 =?us-ascii?Q?uAJMZ4NnWFfOqeubpGUwJJ9V04miAxwhhQhJ4ZK1byMzmGzQNdX2HgJMWZTV?=
 =?us-ascii?Q?BOhbP+eppN/IHH0W8kYdV4E3IO/6ENJSHoseJheO/tnGLiRPdKXSiyxnyTRH?=
 =?us-ascii?Q?v51OIKkjC7+WbDp3Ib5hxUsHFJQaz8D4LaHnpIBaThgyraJFlF2xxYKN2zsi?=
 =?us-ascii?Q?9JwEl8d6g1pJUJ2Q6RQJT9rYWI+YjPqBjBuwMcaFIL6j7eQyyWNy3V7J9bx4?=
 =?us-ascii?Q?UAOKR+j0etiV2jU9KdX0t+lgBNmqdGmTtsmZV/KimSmLEsSfUR7pAAdnqP/T?=
 =?us-ascii?Q?HrPgpGwRtHc33nu1Sy/A+LbW9dxboeuxUGIegPCCIWo7iKZ+RR4acUtxHV3w?=
 =?us-ascii?Q?/XGDzjJTk4ZikAQwzLBxqzC1m3AchZU9I0FakX8zfTXkaOrIio1Ez4vJP6UH?=
 =?us-ascii?Q?FnWqkD/ihJ6aw6SYaXt2SdVzhhC4Td7ypUSth5KQIkwB62wNmtVE/pkoEQw7?=
 =?us-ascii?Q?Wyfw/kJdoK+DZDTFZiKpp2q1p5N868TKUY2W7JpFF9K59n5C4KgG8Cnws9pL?=
 =?us-ascii?Q?Bx95u5U8crNeBkieLc5zZdbaPfGd0vUKjqdvlv3N2MzzMb+YC01oG7Wpxhb6?=
 =?us-ascii?Q?YqwT0R91aju6O361gfi1UGNNikSx7I8hZ97PP9/VHmbi2EUCvYqctpji4SIp?=
 =?us-ascii?Q?Vv6DlPF8vWwDXhy6kToiEEAwrEW76c59laHdX+WYXaKdSAqBpMb9LPCBZL3D?=
 =?us-ascii?Q?57gkhrESu5irkd4rG0pzcJW1F+GBgTWkb9/PxTVsHqa8qtGXgdBe7Ag/7uPf?=
 =?us-ascii?Q?Kb5ZsTkvqfCHCLWHGCX5/Vsqr2yAKXOHuo+cpGXPEGsQe+AgVjhbDy4cuRuT?=
 =?us-ascii?Q?mgfXQ29cP815DOn3mtZgXG5FayxOkmwBhavqJONKoI9iBhvD5zXc4wwLVBB7?=
 =?us-ascii?Q?u622xKPKVuzUTbh1YeWOh3Ja39Md3g7xHUaStI6oDsO5g8modwx++ntm6dt3?=
 =?us-ascii?Q?kIvSYbKL0QPqsezCwcXCYb621dWwVDJjW2eCX7IbJCwO/KPkLXq3FJ3wUjzi?=
 =?us-ascii?Q?NszM2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p6Dnd8OolJXt1eIeMP/RdbiJGlqcWJ3wtEGvwkQhMfbKCW5k8an973pGQRzTqzwHqtd1Couq5lIBH5wciRqnr5Ex+8ddC31pvWerzaBmnGU5r5Qj+uQ6zXU9XHiN1JLpIyuyeMfow08bxGo06ovMVw0yVwY/Q6MLfzPAXw5eMwe/YiYgesn2RbQR3NJfN/6ZGlnQcE3xLwxLyCK2TaQnChiSPpTKyI5kvC2+Bf7zwPgTWTiPx1AvmNproIIzGLWEGTvQWmHzpaVZEFcGqHrG9s3iACtee8ZwNjgvpt8E3tTyEbLE1SQk7VrzEBkYh3Edq5SiipLVHMfuOaVWXMIgUnMJ7373nw7tvTuUL3akf6xbi0RIDcCRXiA+qk+fi37eZPvRs11Wk4Q2I5X7ZH7cKmrYlD5Dhn8Y9Zy9CP3Aup13DMWdZkbrWo8HQKzEFq1X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:58:03.9887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d24c63c-47fa-4a9c-214a-08de62f9f59e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749
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

base-commit: e206e3ab2ad266935b81f5e9d3af2ed47b866826
