Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A26AFF885A
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8165C846C4;
	Wed, 29 Apr 2026 04:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=axiado.com header.i=@axiado.com header.b="sd2IMoka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B502846E7; Wed, 29 Apr 2026 04:32:49 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FD7846BD
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kmitran@axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2A9wIF/Exz/O0KgkephKF8cs1IGmCi6v1gqCDvmFg0DNMaN6MDQiUBVzQCa4r4pmQnDQ4d8tdCq3M9aN4sJeD+xmIWEGmDDb0jchI3iNefClg2jFgxdwV0tIyM+tZyWSNftCWUtc5jJuUu5XQ8HagJE9jICaxfbmHCegAWDOcefVQxk703V9sNHkvyM8ZzRUNTCdF/3PWX9j9LZqOyfMtDP9eANfkr/EGefnEmd0ZydGK8/4Y2XpjafKH0q5Lp1YsNQTjjnAHENDOt9aBpALVJxRa5M1tVIeNANm8awzQlwsppmOSk8szW/8C9twELDtbhI6+cp2Y4GwUbxErDkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbzoIVy/9Ye76r3LgDdnSebAKdcZKy5gfcF8PLFq+7A=;
 b=H1vCRtey9654jeVzDxLq2muZiU0Z+LLs7R9Rrdl9RJEgYHjRS/4f6HtCi+bEr9bN3sbdd9fnRZp8Ovs3ICeEdk/2qhA+aO30NXU7wsBtf4ot0XvIQXd/NYHMOQuPGsbcLQ664JcXsuWP+mPxbCfgI9B+qLU4IxxBiiEc+aeBx9xmJXImPgGbb1qRdzDyCaW/52HXPGuRXr+CBvXFRcPV14g0KlGoOMzcRmHPV/Jig/RMqeNEeozmIC6ACfuWN/WFO0yloRZWrLpjUmTLdLydFIayErtbNbBKRiPKN6gvEpGvfsk8LK/K5Q7u7Mg+houAKiVe7C5lmrdPsKy8ohdn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbzoIVy/9Ye76r3LgDdnSebAKdcZKy5gfcF8PLFq+7A=;
 b=sd2IMokaseIvZ2MyxFmHWraRAcwISFXCMtuVP76chTDGE+RGnTwvfhnDQpBweFoca+0wzC1VyL3o3eL38sXOkEc8KmDhNnxb0MV4UIcGtPK0xDPSdYlKEsQNr5uzrag29EZQS1PwZjwxD82qNIrIpCv/z1npZuFh6RzE3GghMet/SAfvMEKy4almUybYDZAryUeZyazov2z/yOZieWx916xsxTSaJaK0dpf2PNFqmUy6DWutlTFuuT8e/urcLNf0WH8ELcY/8GHd0pq+aFYaRlhseRW7x9xeAomENOZVazB2OKAbRXozY4EO/husDY5p+pAhXhltBt66C8pk4j7CBA==
Received: from DM5PR07CA0049.namprd07.prod.outlook.com (2603:10b6:4:ad::14) by
 BN9PR18MB4268.namprd18.prod.outlook.com (2603:10b6:408:11d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.27; Wed, 29 Apr 2026 02:32:41 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::e2) by DM5PR07CA0049.outlook.office365.com
 (2603:10b6:4:ad::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 02:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Wed, 29 Apr 2026 02:32:41 +0000
Received: from sw-build-jenkins04.axiadord (sw-build-jenkins04.axiadoRD
 [10.4.1.35])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 928F04186B51;
 Tue, 28 Apr 2026 19:30:49 -0700 (PDT)
From: Karthikeyan Mitran <kmitran@axiado.com>
Subject: [PATCH 0/2] Adding Axiado ax3005 based scm3005 board support
Date: Tue, 28 Apr 2026 19:32:35 -0700
Message-Id: <20260428-ax3005_scm3005-v1-0-7fed19ee6fe0@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMNt8WkC/2WMywrCMBBFf6VkbWQyjTW48j9EZJqHzaJNSSRUS
 v/dtCD4WF3OhXNmlmz0NrFTNbNos08+DAXErmK6o+FuuTeFGQI2IBE5TTXA4ZZ0vy6XgCAaMpr
 alhVpjNb5aQteroU7nx4hPrd+Fuv7TtW/qSw4cG2hlaCcIolnmjyZsNehZ2sr46ev/nwsvoOjM
 9AYZUl9+cuyvAAwAg9T7QAAAA==
X-Change-ID: 20260422-ax3005_scm3005-402016adcabb
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Siu Ming Tong <smtong@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=kmitran@axiado.com;
 h=from:subject:message-id; bh=Utkm86B0Ra8d0TL+g9y6B/V1ClXrmEiCt7wyRxexdjA=;
 b=owEBbQKS/ZANAwAKAfykr3bAxbrPAcsmYgBp8W3HWCGGEsqy5C1tT0t/Pd/AFSkB5XgLfqHC+
 MFW35kPxkiJAjMEAAEKAB0WIQQykBiJeI5kfMQLrdj8pK92wMW6zwUCafFtxwAKCRD8pK92wMW6
 zz24D/9x0LUUo0meXVnN5011byom5VVLtwLo2EwiFwvCVw5Wqu5d5MKG4vQ1CF4Ru8DvmP8JOYY
 ee1K0zw8YuTsbYcC9MnUJiMKIMKjC+T2vOFmDJZKeh1uv5359Fvc2fYfwooUAsFJE0k/x3VNK6d
 2+GZJ3q511LvlKqnSNRhABrDaF7tdv7/Es3nzyjQZvnziOdCPajjaNNjOCyRRdXlGSQBtlIHVPu
 NBK5cN9F+Hbqh1sD+FqJt0EtTrgvOK9T6uECuqdlFQq8JVcDSYYNIo40gA1Z4+ZZqQ5/4Tov+X3
 g+0px642Cqo0Ie9+F62pqmlrUUky33QzyxclLAOIjzsDdtrsUnSTa2vcB1FHxLJfbujm2pcSAW0
 EhV7hCl8dW8iOPWmjOaP8CRQXYkkOdMH/6Y8Hyk29V/I8n3WIVPqjWcl8mEBNPV/+2Ysd/htSkp
 E2SpyGfD9gB0nkC6O3H6hBEdKEsZDXEcpiLFZEkHG6rFkGQ990/cacjyEWWcIEZEzBTcvd9E9I0
 lneNKZ7CIG5vUwnSROoXcp+pZaUKvNq5Xikl0yqjSD0pKp7eq8PlNm20JIgmsTtA1NllzU4C8PO
 ucv5QKWrZle2IeLPnjTuPCbEBow6vrehgqGd1kqL6K++DtLYY5EQ5a8hIWU4h6+2sUomAiv4MUA
 +61TxJSA/gFPP7w==
X-Developer-Key: i=kmitran@axiado.com; a=openpgp;
 fpr=32901889788E647CC40BADD8FCA4AF76C0C5BACF
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|BN9PR18MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: af0051bb-cf41-4c47-b9ce-08dea5979646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34070700014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3BVcqJM98Uzf8el8nXDw1bEfty2ulk/9PwKB8ziQex2ITFg5jQvRKNpLQq3/dyu3cWgTEPU/C3UvNlqr0As4pXbP6CFjdZ1cuXWBJW/gYqbAYNJBrgF93KPQFh4RTft08ZHeBdS0uQuxg5kNDcl2fWkv0OvXBmWZ8PGjYIzgy+oN4xETmjqk0qaAfKBWsATh20XnuKWcaJkyv1sRn98xAmoMncoLMKo+9cePJ6ZB3U17yH8kwF1W3Ef6aKsmK7oWu85qRN+fqV8XLzg/kqPuL0HGyjxPe1HkS99BRgG3WLb7RyuW64PWfh7dNK9F91KO7pp5IXt+VSeTSWyyyPwmdYVDVoqOGnIsrG10EM6dbJopbNIXiv8JYFgzDYJdPxZylrz8ISbmWpKtNzh0NcrwDw69fMMr6ua9TFD6+AxhKzX4e+ablDgOT0ZYkqOWxiYXqQTshkgKwq48yRZlrPm2r7RTYlwslA+qk5wLh+3ya1ke9nJdfvQlo4P3aFWiHr3el82NUuFnbt6U1ID8NF5kIoUVMcKKKvyNI/vSWzO8k/1YowkGUcZOsdmTqsejjURrObrIms/DgtOGtt0ytSLBXjdbmxdQvR/f4nG9gH/MK6SApWI4YuSBvRJfWJlWrHbllAP16W+RS4xi3Xpokps8y5WCtxAgyMa4zWxxsfvm3oLQh1v7QSmnEmuhDbVk9ZR3AoWfY18ShnoOZ7P1P3km9HTACrS9Bn9Uq68KFL+W+YzUSXoqc1L1fLdCtyjpDonbkoFTgE4dA5PoMRGAdU4tFQ==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(34070700014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hAjojWZyOZ/9HxRJLIVnz6Sg1HspJBeVNQcryrY3P7KFnzkS2y1nWy6GitPYcTsxY/TvHq021pOQYy1/XntWIaQJTiIfEJn6552lH2cU/2Pj9fyhuRkM8qJbVsfACCBG6DA+8h8Skb83CtdjV/t6wlTpBBz8TnVgufbzNtUEzWC97Lq6ibwcVa/JTXTyZ/W+wzVveiJxLFt9s66HbqkgIqb+18fVl9ShWhzghbusBZoLkbk2iVyimz251+fZHCwrwouKoiMSp3Ne2Lq0JK2Q8WoxM/NncBB5/PKdQwKpBZa7/1sXS4gGW9EvpWIZ4+mwQ9nzELOk+0fbiuwlgUUbFjDhjxxCR4R8ricUOCJJAn4X6PdPfhvZgNYPDvimqKwWCsoX+CTZzLJEXCIWVRzFQPRDWjC+XonnKHu9esGyWuSdinVfP0xxpQrZn1afdpj2
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:32:41.1342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0051bb-cf41-4c47-b9ce-08dea5979646
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4268
X-Mailman-Approved-At: Wed, 29 Apr 2026 04:43:57 +0200
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

This series introduces initial U-Boot support for the Axiado AX3005
  SCM3005 board, a quad-core ARM Cortex-A53 (ARMv8/ARM64) platform.

  Patch 1 adds the device tree files: an SoC-level DTSI describing
  GIC-v3, Cadence/Zynq UART, a fixed reference clock, and spin-table
  secondary CPU boot, plus a board-level DTS setting the console to
  uart3 at 115200 baud with 2 GB DRAM at 0x80000000.

  Patch 2 adds the board support: Kconfig plumbing (ARCH_AX3005 and
  TARGET_SCM3005), defconfig, board source with ft_board_setup() to
  fix up the spin-table cpu-release-addr, a custom linker script that
  pins spin_table_v8.o at offset 0x2fa0 from text base, and a
  MAINTAINERS entry.

  Tested on SCM3005 EVK hardware

B4-Revision: 1
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Cc: Siu Ming Tong <smtong@axiado.com>
Cc: Prasad Bolisetty <pbolisetty@axiado.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Tzu-Hao Wei <twei@axiado.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>

Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
---
---
Siu Ming Tong (2):
      arm64: dts: axiado: Add AX3005 SCM3005 device tree
      arm: axiado: Add AX3005 based SCM3005 board support

 MAINTAINERS                      |  10 +++
 arch/arm/Kconfig                 |  17 ++++
 arch/arm/dts/Makefile            |   1 +
 arch/arm/dts/ax3005-scm3005.dts  |  28 ++++++
 arch/arm/dts/ax3005.dtsi         | 100 +++++++++++++++++++++
 board/axiado/scm3005/Kconfig     |  15 ++++
 board/axiado/scm3005/Makefile    |   5 ++
 board/axiado/scm3005/scm3005.c   | 128 +++++++++++++++++++++++++++
 board/axiado/scm3005/u-boot.lds  | 183 +++++++++++++++++++++++++++++++++++++++
 configs/ax3005_scm3005_defconfig |  73 ++++++++++++++++
 include/configs/ax3005-scm3005.h |  29 +++++++
 11 files changed, 589 insertions(+)
---
base-commit: 052988aa29bfd506d7ce207fbb3f5374a5dbecbb
change-id: 20260422-ax3005_scm3005-402016adcabb

Best regards,
-- 
Karthikeyan Mitran <kmitran@axiado.com>

