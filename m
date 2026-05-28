Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF280CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 03:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD67D846E2;
	Thu, 28 May 2026 05:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=axiado.com header.i=@axiado.com header.b="A7ii1NhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCAF848B9; Thu, 28 May 2026 04:38:57 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C0D5846E2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 04:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=smtong@axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn79dYF7MzrR8sty4fy42VXCBuyoFsZ75D0iRc+6sdsTm7qiTzmPfXRUzRzu0j4pCWU+kiWbubzU0VIv//0LRsJdtnW59ZzkFA3sHmbbvLgQe8MIod/+ArcTWM4zlue2e8Js2S9Ia7a8V3sEy5HMs1ICa8tvfZpdPKpayFiPI3xw0C+R1X8m3IXCT/jfmPNX7Qs3Q9ewMx7XcWpdMPRR89J+pXLNAJo1TWBJ12YIM/+Nw8UF2lF4OayKxaq6qaFDi0hqCoLDKC/YFB3/aWv58lxx5cEZKw6q7q6s4yRVafwpWj1fzyWRh6fcznEws/NgDmT0d+oPQtWx3uFnugKq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfvyhSe2CCkNWZx6fwprtaEu51SRHdFhF45y8L7OrM8=;
 b=DSxSNjwx5Td1NhpoVrrcvvF6xPy7dTppi5UDNGxoeIX/81bj3Rn5UbAt6sjhuXCozD7VK7CCNeOG3Jl5niLNScdPwjFWBd+waMA56NYdLIalsq+3xft0jM2KmzPe3yL7HznbyQOJO5BE6pGp9vQZsC5hIEJV9/AMlnSkc8QEDWTOCrafTRNIIgzXdguZC0famQUja6mjO0YGagyoRNkQCS1VJ1zlySLd+HGfQ2wk6nParXw4oyT2gW6mNlrfP5TU/qd9Zqp6xDTl1NrKqBQT/QmWiF7BkN5lHHrDeSK3BFoNeffVvCmCchUXSYCP8RO4V4kq4uFhbclmiM7LOheLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfvyhSe2CCkNWZx6fwprtaEu51SRHdFhF45y8L7OrM8=;
 b=A7ii1NhB+ibi3s9Yo/+o87vaIfJe8Wv3+E/DaACPQEwsWNAgcCIbRuRIQEf90xHEs1RnPEiPaEIt/sLrxbMGOsdH9Ptr+IH9qhi7kQXD7YKybdj+30ZeZ93R4cIkBqQ8GeNhDv8VmJTtxa5U4d56GsdpbDGBs7Y00Vmdmo9finiJmaDYas57RLd+ZXlV+ITzdoQ/lIwtJWDBh/Ixe90w4U2xUTPTmAcPHe0h9nx54mTIKfCg6hSGmMBDfhl2XW97iUKmPL7cZZ+v34BO+3yuRH72QBhPro0YAqcxZv+iIGFQkaT32r87SMAqk8Goc58j3zKSUY3UBR17QGs/9fAalg==
Received: from SJ0PR03CA0130.namprd03.prod.outlook.com (2603:10b6:a03:33c::15)
 by DS3PR18MB927691.namprd18.prod.outlook.com (2603:10b6:8:347::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 02:38:50 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3f) by SJ0PR03CA0130.outlook.office365.com
 (2603:10b6:a03:33c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 02:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 02:38:50 +0000
Received: from [127.0.1.1] (super-compute03.axiadoRD [10.4.1.87])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 9AED94186B58;
 Wed, 27 May 2026 19:36:30 -0700 (PDT)
From: Siu Ming Tong <smtong@axiado.com>
Subject: [PATCH v2 0/2] This series introduces initial U-Boot support for
 mach-axiado AX3005 SCM3005 board, a quad-core ARM Cortex-A53 (ARMv8/ARM64)
 platform.
Date: Wed, 27 May 2026 19:38:35 -0700
Message-Id: <20260527-review-v2-0-10daefddf47d@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKuqF2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NLXZCi1HLdlCRTA0tjC7M08yRzJaDigqLUtMwKsEHRsRB+cWlSVmp
 yCUi3Um0tAM63QgtqAAAA
X-Change-ID: 20260519-review-db509386f7b7
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Siu Ming Tong <smtong@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=smtong@axiado.com;
 h=from:subject:message-id; bh=IaIsyUATLubXPcmIr2RHKoGydYUDifsh5qDeuhqJQYs=;
 b=owEB7QES/pANAwAKAXwcqHIUQvOOAcsmYgBqF6qwJQkvz/7OW4R0uqO2wh+codO9yUSAcZZL7
 RFwwzmXzD+JAbMEAAEKAB0WIQR3Lze7GwS3XzAkT0h8HKhyFELzjgUCaheqsAAKCRB8HKhyFELz
 jse7DACB/WvX24bt1S9uOPgOYzS2U/8U6Q41CvT0XlLb+bnU8NEzJWMvwqJHbaD6HatYPRinUsN
 BukmD5fv6qeCWwyrhb9hHGWNh5i7uQy3rOSdhGQNP/DXL0Qr8tlss7atZgkyjxPtnb47Srvd1DV
 iUdVshvGVDn3n8R+Q+3l+orgBvL9ZqsN+gwM+uIxp+QVlSL+aPLbvPR9SG9R6zjgIdNNqPjdfGm
 5CqKOPCBpZx4OReCDyldRKRTcweKlVvhGAD8IvUzNqucfLxvToGeOTOxmEvRdZR3sety/Cj1yda
 ZX5F6VPcnhJEuScebh9aEDDbRhwPNw4x+bCoAcHhXevKzuD0WO5XQWEPI9OLFlwW/YeeQcnachr
 huspz4dMyPZf7sx3R2AXNx6EtDivPuymv78yxr7O4PrDrlb0PAVdtugMlhHlH7zq2C96lrqogtM
 CwGDsBhkiD6yMzcXfyh1wd/nlgdt4YSqxly2P3HTXvznEZ7U30WNyZz1/0laiveb2lM64=
X-Developer-Key: i=smtong@axiado.com; a=openpgp;
 fpr=772F37BB1B04B75F30244F487C1CA8721442F38E
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS3PR18MB927691:EE_
X-MS-Office365-Filtering-Correlation-Id: fa10dc7e-19b2-44fb-5a74-08debc624014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|13003099007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: roK8+mkHR+FirpsovlDbrUfS8w/fTl9SBxDS3s4xoL7Q5MfZ2upaEAC+/dy1+l2UNT3UUNI7QTJwnWMwLUZlSf1khCx72ql5ILmYyZTmzUFt793Tde3cp0xxbwUTPw5p1uZfWUnoCnQQEjVolyYtXCCN76yrG6HpVuP62uNsMe5IFU2M8J45g4KTE4/OKjvVUPnfZBHVpere0ZMPyNZdWsxkH1WElWArywMp4sdR+ACFY1Z30WzxnfaiHq9SFZf6BzT9gLerFkel3qkt0gD4AR06DKNdmepT0nfow73jK6vltF83Rn6XBNGufW0fxafdWWMuqpTqkZDecTtKsAVOAKFm0GfjigaV5gkb6yz4bzVHjH0g02da9BK03C+NBIYf5iKKUGP7a+hH8W/PEUWeObJFysmofwJX/Sev7Ci4cgGroBpCZ90mxpSlQLn7kQYZN601OlZV5dhM/Lxj+i5gMsRaguBRCdRmLyow+Bl2xFKIzP8h1e9pgIH+CpEipGI7XBK1cIcAfosU+PoqCjjWV+4fFf5ljtk4H1fI6ZgHsjpEPRtzcTmvPxgYhE9kbK4DLACcXx3G1UwS/n2sVqh+yjtGzH2XKMQdNtRhhECjdsoowspizx6pOvXpKs7y+jE/keL4VmFJsZrQBjeYqnT11fC0Q1fnOUGBMF9UPt5/Cmt780H6m3izd5b7+mgWa8vLKtgOo5ax2y3AlU9ZsNT0ZZLiXQatztgp5lnt68QsTxk=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(13003099007)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xaHDxU9wSQKhF/wVR3D/K8q6BnvfCeQYf5mGpZayLrcCWiv6IlvufvcmFgEq/SKhFQBD+6zEZb0fWR0YcGTRtnTjFoQRuOgRyooKRy8xpr1WEWtOWelk/FmbsKII1aoZECx3hWFuxQJ5K7+3KK6/Nu6jYLScyR9TK57bP87eMlzCjtaAa6iVsWAyJm+8WaYlODAB1ittJI0vEpFDhCzYhDVTS+5XYXb10PITd2oDcJZBk3Ivnk/uj+H8eEtezlwaCnIsa5NNDw9hW+aohZBXhhLUA3tL3EkuDOFpt1+wL4J+1eVst1mV36DT3wOAe2Vmbw85Jd9Ur71yudeWJ6RrWRASkruxiZCBuJtFoFCzkyVL1Kv/rlHFxZzF+yblse86hhU3ZNAj1sFFYTsU0pPd9yXVYNVStiMerNol8W9+aOtYJziLunHMvKc7t9T1/kzt
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 02:38:50.0619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa10dc7e-19b2-44fb-5a74-08debc624014
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR18MB927691
X-Mailman-Approved-At: Thu, 28 May 2026 05:00:39 +0200
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

Patch 1 adds the device tree files: an SoC-level DTSI describing
GIC-v3, Cadence/Zynq UART, a fixed reference clock, and spin-table
secondary CPU boot, plus a board-level DTS setting the console to
uart3 at 115200 baud with 2 GB DRAM at 0x80000000.

Patch 2 adds mach-axiado to support Axiado SoC-based boards, Kconfig 
plumbing (AXIADO_AX3005 and TARGET_SCM3005), defconfig, board source 
with ft_board_setup() and a MAINTAINERS entry.

Tested on SCM3005 EVK hardware

B4-Revision: 2
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Cc: Siu Ming Tong <smtong@axiado.com>
Cc: Prasad Bolisetty <pbolisetty@axiado.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Tzu-Hao Wei <twei@axiado.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>

Signed-off-by: smtong <smtong@axiado.com>
---
---
Changes in v2:
- Added new mach-axiado with support for SCM3005 boards.
- Link to v1: https://lore.kernel.org/r/20260428-ax3005_scm3005-v1-0-7fed19ee6fe0@axiado.com

---
Siu Ming Tong (2):
      arm64: dts: axiado: Add AX3005 SCM3005 device tree
      grm: axiado: Add AX3005 based SCM3005 board support

 MAINTAINERS                          |  11 +++
 arch/arm/Kconfig                     |   9 +++
 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/ax3005-scm3005.dts      |  28 ++++++++
 arch/arm/dts/ax3005.dtsi             | 100 +++++++++++++++++++++++++++
 arch/arm/mach-axiado/Kconfig         |  22 ++++++
 arch/arm/mach-axiado/Makefile        |   6 ++
 arch/arm/mach-axiado/scm3005/Kconfig |  11 +++
 board/axiado/scm3005/Kconfig         |  15 ++++
 board/axiado/scm3005/Makefile        |   5 ++
 board/axiado/scm3005/scm3005.c       | 128 +++++++++++++++++++++++++++++++++++
 configs/ax3005_scm3005_defconfig     |  74 ++++++++++++++++++++
 include/configs/ax3005-scm3005.h     |  29 ++++++++
 13 files changed, 439 insertions(+)
---
base-commit: 052988aa29bfd506d7ce207fbb3f5374a5dbecbb
change-id: 20260519-review-db509386f7b7

Best regards,
--  
smtong <smtong@axiado.com>

