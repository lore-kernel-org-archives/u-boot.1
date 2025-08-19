Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F98CA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3AB80422;
	Tue, 19 Aug 2025 06:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="a645kO0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B9B880EE5; Tue, 19 Aug 2025 06:34:49 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0BD802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg72tdYK98Q5ktpQGfetN0xxFpgcKK61mJu9f3t5ADb0omcMp/5VROAnvawDJ3/wXfI1CQsZycNvta72ue/gGh4c83O2ISDoS64EWndZqUas2RZ00jmxhcZZM1ScUPA31r8t9lucFJssp9cLWdIrZSYBY31B7ryq96LG4jpdeBsSgD678LTze+m65BpaxTfvP63/CguaTWvM1tAW9IDCWiU9OMsaNJDq4nBdsK+HjhxI1S4jFtSZfq29pdu+yfQhdF1x717Qc6omlqpAOrmKzZ2v3ctcW/a7zRu/u6daMcL0V9S6HGDXITPHJOfWj4OdxknfaLbL1dy8h942jabqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeDIjgSWSZJRehhGCx+tmAWHpuBaqmLWoK+c9dbStYY=;
 b=i6VJewzTf3olEWbmt/Btn39FPL9g1tMGRfJ57MPBypZG0MO/xaa4OWmcSOKJLY6/7wGfCnJobE64PwMEtqlEtvv9cZwhtSh74lyeNRCZ5t1M/1IzDgHIFl8JcpC5Uil3IhjuwnQvQbp9/qK5J3SdqTWnq93k4Bwu6okB7zpHODNRKECBBlpuSJbAqeJZNU5+o32wxmbWQzpgNXNJys/wOR5639NpitPB8MqD+9eelTle/veCl1yw8CIDJDl7wkbZh+N/NigRaZZ/REkTai8l9o49NT3hHGVD3AeFyplBN3ucC0WiMNdPlIXe6ho+AVxJhTacHaizxg/sUsuOmXRMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeDIjgSWSZJRehhGCx+tmAWHpuBaqmLWoK+c9dbStYY=;
 b=a645kO0g5KzHtWwdUWVHq8tG8WnxxHMq4TRamK9kYdtnVuZI+b7NCtklHaLjETNgxs1Kb2P1etIU0t33gNy5LD48T7px1QeS7t35lu3EJ9eFdPRyWHuDh85luNfln9IGL7a3STnI1n11OADr9k0lE8PJiml2GL8R9n/H9C/ejqugTHnTKpLmreahjC0oIfxaSoiJR20CvSC9GinE8OFv3tCXxJUXqOnkvXAMFfbS+0BkWL8qa+KyTukiwafCEn0dmexumcKs1lcgMVr85ozHjq3HGIWUrbBXmH7I+MWJpJyQOLXP5PGtK5OEdi/IyMRjRMoo+d2dNcRMpN0tEr1oUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5688.namprd03.prod.outlook.com (2603:10b6:510:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:34:44 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:34:44 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] configs: socfpga: Remove SYS_BOOTM_LEN from N5X VAB config
Date: Mon, 18 Aug 2025 21:34:40 -0700
Message-Id: <20250819043440.6126-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: b892fc82-b2d4-4965-3093-08ddded9b8a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ROoLwEX368S7X6AAoV3fyPSdcyvrhDNt5UASuQnNjU86Ws27B+9daBY2adfj?=
 =?us-ascii?Q?6hkLIQfQ3UFsnwMl8QnTtQW8vfvwRhBnYAbm00zhD8FEXp6QmoidX11ttax9?=
 =?us-ascii?Q?srULq0EFpaGd5BBDc7jNo1zl5SO/I65v98MmjV+jDitVba9dCxQRtcmrqqdT?=
 =?us-ascii?Q?oX0uKpUFQsWNsj/lIGGpIn0yx2i/FwY57rMERbyIvhdaZyet8PITBh+g++ub?=
 =?us-ascii?Q?7vtwdq5zMo9V4m92vUTejtJTJbyJYBqY75+i/YmLrYF1/v//X7ILIcnH3ulj?=
 =?us-ascii?Q?GyMTv2PIFGz9X7jE54FVS7grJ8wyK+Ro3R04jNIncOiZS6U6/qdGGNE94qbJ?=
 =?us-ascii?Q?nAfflOrKTVeJwrQMUrz3ysReAFGdinci0Frh+6UAdk3BfZIdig/HH9mwQKYH?=
 =?us-ascii?Q?+9GZt5nSrGBUgeQBhcQRvnvWjP9wsIMxcLyuixP9d54+9jPle6WGcROTD+Fd?=
 =?us-ascii?Q?AnJz9Aaiwl1MqYNxxH86qMGGxVIsKZ3NvyoULcRJJOkwoMZ1S0rq4sIbwpEL?=
 =?us-ascii?Q?y6Z17q0YmEOZouFwrOo3cNlC628+1el+NbMj2ZUrJ9ZkTx5dZGHbm1HW/odD?=
 =?us-ascii?Q?3m2KQUNtvmn4yhjeoIW1bihBY/UT1BabcwkR0NS1TzvJ98XUM3S+ktuWbCq3?=
 =?us-ascii?Q?oz7c7tmX6mFOSoDr9EeTUoCJSobxfHW8SrEgkfYsHrsDlZuBplN79dp7nbUA?=
 =?us-ascii?Q?qHRkGr2xlwxUrMBDyUs1fhi3kTOjDAA9RBYH0uh6koRIEWUYTngKPNhVwXuN?=
 =?us-ascii?Q?87ViqNsypL8vqzbO1k1/K7lTdPRMTBR25ozL4oZ2ghWRVVW70Eoj9gaio2HT?=
 =?us-ascii?Q?YfWARrAgeekOBDYsbKdD0x8E6EcMHRjYzHPUP4MSneKOCNzlbC1PC11GwlnI?=
 =?us-ascii?Q?sHNYiFyyjPZMJUx6sM+ZL2GaINc7A7LNA/0tvcWk1thp2U6X32E5UH/vYVgt?=
 =?us-ascii?Q?OxZHDrJlGGJccjHxtExTedFrERG1RZJpQWvW4Hcc/1djTIBozI2WtdByI55a?=
 =?us-ascii?Q?gYZrPKU+q6M9A2u9epTn7QTxUH5C0hTBxqiTLrZiJAFAEl5T0yvA9SRmnN2v?=
 =?us-ascii?Q?ynIiqIYX0C4agXzXrgaIit1xwFkA2isdIjVwtztmJP0A/Dz/N77PJa10EaAr?=
 =?us-ascii?Q?kVZ/IB/XqSpy6KDkvVEaIIedZjBsDzM8KivEkJKgYl2GS51U/XaW3kS8i6Sf?=
 =?us-ascii?Q?7RUqfBXFhOYrowEvYEULkH4mNk7Ui/xsrpPK78tWy7HuHlIGgdrPCg6M4iNy?=
 =?us-ascii?Q?S3dnQPl6fQBB9bD5lv76C8bW3WByPEz7Ga+keOZL8DuSUAq90mKW2vG5koc1?=
 =?us-ascii?Q?kNFf7vafA0lAAP1dExRoUe0T/jN3xTVr3qZNasiZ8/yVYeiCkktjp3f3goIs?=
 =?us-ascii?Q?STi8/YQ/26ogGOWdAehcFmCZCRB29gJ20zueOz04cTXETDyXTjR+fJP3fIoP?=
 =?us-ascii?Q?bOS3+EfHePE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BiltIb3CX2kIjsqlNNrCC7TA7wlrbYCuEx9Ck8V/UqT1AJJrbYF5ozJopRCP?=
 =?us-ascii?Q?fimsFMQndW/DCo6vXkXJURSjDsR6HB41G0lfaYPXBlEiKmyYFkMVPfR2ni1G?=
 =?us-ascii?Q?FhKnCKvPwFaEDtb7E8MBSTzqzN2Aeh3xWDma4tqkr1sfncfybPlRS318iiDW?=
 =?us-ascii?Q?Pl/XuBiu8Q19P1z20Nfid+IdQl7nQ0p5JCYcy56450Ok2bdUI3Sjta6tBx2A?=
 =?us-ascii?Q?55NvhWmUJi8LkEfBlpgTMg8yrJeBq2f9h5Hhnt7oX3D3ZGgi+Tn05GY25lXB?=
 =?us-ascii?Q?kzj+3il4nW8ECDzAeH0nVwH9GzLcvvZJnijubJ9YGSO9zS+HRsEMGb/xRBdk?=
 =?us-ascii?Q?LHmrr51mMKQRIO2nr3bcPyxO/4PyiKTX09nHZfWw4RJkbWpn4ed2k1Gw2uDt?=
 =?us-ascii?Q?9DjaQFrxmd0LFj+USXpMn4avOQz4vVZuBosZiqafuJXkM+y4PMOG1aIjrqiD?=
 =?us-ascii?Q?exCriuXSWzO978xJmji7CUI2WDLmv62309kkUgXHdJc3N4JuPBKv24BQsK2l?=
 =?us-ascii?Q?fZhBQTsQF0N/BktcpD6CFfk3N7JfAQdRuw2CNvS1L4vvgHWe97GHunQ0xxFl?=
 =?us-ascii?Q?Quvun9FRbLRCU0Jr1sGOSsD27MCqn0TCd/RgoNOqdjI61wifE40V8IXDFYFJ?=
 =?us-ascii?Q?kKUFU5ge5rIJ/EZ6k6xDMW6ZYuNpwyH9hUIseGl9MkWfckx5IpMnT2Odg7rM?=
 =?us-ascii?Q?ArKEkEqUvRZBTso2snL9QgF2gG/okbxXcalV6TyvEbEb53fOn751d7x7ApJ0?=
 =?us-ascii?Q?7qnn7ksayiNL4WPRfQtTTS181yxVvrrd6E6UpshTrn6CT4RXtx6Xfd5CfuPV?=
 =?us-ascii?Q?spxoC65PziWIf//JmfY+5DyjoiIBA5w289JLvW/BN8/8w65ctuDGYiJmVoX5?=
 =?us-ascii?Q?/etopKaoafMx/KloTdtZJoms/unw202l6ufl/IT5QRMtgjY2PTLejW1uDCcZ?=
 =?us-ascii?Q?XzXnldyNn8TiwV/f/uARO1GBuldyqVBTGr63xBSZj41+rjaH+GINQCKBoYgC?=
 =?us-ascii?Q?D7ogGxhhqdabHZtKCKO5fvY4X6XgdorIAqdoatAyNLrj3Pqy5AQC+GbBG1iY?=
 =?us-ascii?Q?e5bhzWNL05PFnIUVFsyt+uGLD+1lc3najo7a4BR/L1NScVkbAE+EOS4MZe1m?=
 =?us-ascii?Q?A1j2r4ZyI97Elc+GtDt7064aRpCPlOO4+y6ImzS338NipvSr5zosceIp8SCI?=
 =?us-ascii?Q?yPcbMQ6ac3CXEhthHz4rFMOPtxlrTTel0pe7s1C3JaPx1gWU7WPgoSFmQAN3?=
 =?us-ascii?Q?WaLYBBPF5HGd49fF/tCbRv7XjLWm9mMH/qsCu4SEja3bD4NpSeinGIAmmzkP?=
 =?us-ascii?Q?hEM5JBAmnN6eIW+CaJwwqU2tF76udk6gygtkYOEQ5jGMKVDoA4P538ORJMGn?=
 =?us-ascii?Q?+XfwoFKRtNtzH7nFpdJyPEkTASWttS45HbLJkhcVSY7FslkponmOtMoDVq6V?=
 =?us-ascii?Q?DR5uiWHIapq8+9uWr9o6F8aPhv6Zu75ikQUJMrfx6jsS+IqHv6AzfLAMGSZh?=
 =?us-ascii?Q?jm9hvhi+WD/hh5FpkrO0hPniMUK/5zmkPcDlaVKIoTzvPVInwv4GQsjK9k39?=
 =?us-ascii?Q?A5HFfQviTiiQxcWrC3TlKXo08gKNcRBKvifZOUxtzAqZtvE9PpPXGHaTxZrz?=
 =?us-ascii?Q?ULOQehOe8uqzqmV0CD1ccbs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b892fc82-b2d4-4965-3093-08ddded9b8a7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:34:44.5454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/K0+/914XNQhEoaECy9GMEajg5LwGr4vzdNTYLRqq4ODLrYOUfR5HQZgj4KRsZSVUVsr6klFB0m0kDp3soFVushk2ipF/ubELFn0CY1BW1BXldgtf4l/x28NZChF6j2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5688
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

Remove the current CONFIG_SYS_BOOTM_LEN in N5X VAB defconfig.
Previously, the size was set to 32MB, but due to larger kernel image,
64MB size is required. This 64MB configuration has been set as
default in the Kconfig.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_n5x_vab_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index c0dc8558153..92cd0fa6add 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SOCFPGA_SECURE_VAB_AUTH=y
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
-- 
2.35.3

