Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B40C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 11:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7150660749;
	Tue,  1 Sep 2026 11:48:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pflBK2aoyPHK; Tue,  1 Sep 2026 11:48:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788263306;
	bh=c8LmaIXUahbclwpT+v+aoH2q7UQLakzAX+V+s7sllL4=;
	h=Date:From:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sVB8wuitvCv4VWB9hG3QPl2WWOJ4cd6ksSF8V2rkq3nGe7dHtUnxlA2e59/9tx1Ht
	 VYnl3N+J7aoAr1sZNvNQQ14974xYzeG3yGRZbFNJVWHLnFvewCckDUrokdlDmP82py
	 V1VewgAIPoZWltkMBQ7OMb6NMMoXTOf3sdBpSvdkjvu887r6kmoF1zCIfyuuGIUzra
	 C7SNEs4dWWQo6VloU3wLbFlY0pQYqDBdc2z+hMoBMN4twVaeVsaT4Yl0JIfov9IKO+
	 EKJ9gwRvmjT1mlVKvIHOb5aPRBfG8FZDXHcJ4m1U89eRaJ0vf3pJZwte+6XFGQDfFp
	 dufPQv9ftHKow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4B95606E5;
	Tue,  1 Sep 2026 11:48:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAF47105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACE8F401CE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWG__6F42Mt8 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 11:48:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=KTK2RxUw
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1050F401CA
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSd3lXjH9kvBDOLzLtbNqTt2dz04bSFMUfB+8BdFvC6ntatnVUw1rBD4SnT+m70+1gods41A5YKh9aIi8mKDDn6FaMenZkRfJKX2CDPHOo1FbkziToEhyVoAzdaRstJtwPMU8a5p59mkeRpmERodDYn7B0j2CO3sHIkgETdOSVjphTcaAX2QY58XNftxrfROA5vE7QT2iVhu5wYBDgWjpDejotHgW23y9p0epUbN9LfRSgLTB1YCdifb3eWYylMbVQtngzWq0k4nbz+X3W7V1lZzualPZOEYt7zo0u+Szm1IjKjvxg7l35LYB5hsdYuxd+LS6I1tEC50rEq+B3upsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8LmaIXUahbclwpT+v+aoH2q7UQLakzAX+V+s7sllL4=;
 b=ErCNC/cLc1gCoWaLkHeG5z/oMWCKphOz5VmMYvrusjJzayCyB/Lm8b4F3gaLLjuG1s/7OPpD74TfJnP/DKMcjH2Nh2T8C7JfHqI4n9V/AiggetfoGiIWjWyUeq2lVWg/h3r4YGZXny2WGAOIaIEaF9XSh4dWWu6zhYk0gh8FPuErpw3q92ScL7c4GgzqvJzVh1F/EOnifaG/lwD8zbGeYXBKrQc1ZH4WcH616a53xvVi00ZYv0xl24gwTdmYl0fF6sAv25YaOwNtskflEMMXzvKrO6YLXSi7EWaE/McX//64sGDoysCXHpRneNuu0j53QMBZTLE4ZTUogW1ov5Pq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8LmaIXUahbclwpT+v+aoH2q7UQLakzAX+V+s7sllL4=;
 b=KTK2RxUwbIXXOVtR/cyCvmRzn+xmUhJ7FpXdNGX7o4WNjk7/aZeVDEW8/b0Qeq3s+PZH3ERYvXsuUFgwXJxqVn6KfZDYd6LnvWpK74ghHO0vBy6DPVRRWIT9pExD0pV+bBwFJTgVu0Dvnjw6OoURx+XrB9+RQnwYDwfdtawVwtZR9r4A/J8As25zrst7GRt6ZVCOYbGqIqHSdwLGYkwESqn0YnP8JjI8qRrHqSEReHsU63J193FzbdI40etxSmHim6bStzws6XlK0vZUB8aSWl7OC2pennk4AhUpYU7s2l3ylt5mH3HuTVnKrCZYYJ2j2nVkzxd84kqZojhbqz2XcA==
Received: from AM8P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::18)
 by PA2PR10MB8699.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:48:15 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::1d) by AM8P191CA0013.outlook.office365.com
 (2603:10a6:20b:21a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 11:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 11:48:15 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 13:45:33 +0200
Received: from [10.48.87.93] (10.48.87.93) by ENXDAG1NODE3.st.com
 (10.75.129.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 13:48:14 +0200
Message-ID: <1b650381-f4ca-4293-88ea-496e825ab9fe@foss.st.com>
Date: Tue, 1 Sep 2026 13:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot next / v2027.01 = u-boot-stm32_20260901
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Marek Vasut <marex@denx.de>, "Sean
 Nyekjaer" <sean@geanix.com>, Patrice Chotard <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6C:EE_|PA2PR10MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed678b7-9922-49d6-7132-08df081ee884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|56012099006|13003099007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 0lzG8v1souyb53HK/XtuRsPeSXCFX8WVryA8ZQtL8eAc4UTOV9+3fydhmAQnGFYuCLZXrH8beP7GehN0CYnHAkTDbHYb0sQwS4eKJ2WaUfkjFZ5BK6RxvGtwU1Lnasl80PqZ4p6CAegiXvi7XQ+JWChNwqjRrRSkzoeGivLxr8iRxp/J6yK/r2CCnjR1j4cpVBDuWHXEHjOv8lAFHXp5AJQnOPOC1gZH7OtE1ItietxYqNKLchuUvL3jK/gMY71sgOEBC4n8zval2Z9CXokICtqqHP5rW/ebM2RTYFR2k1sWyc3VanurVeU1xOmituBQGUHS7ntO131txr7joA9u7oMxhcoO2Bm4lZ1UEghjtp+QkTBQ2HwXY+I5WItcuffYBljDrlb/eJzknwNlCX4DsexXd56sxzfABErUL97aae/Wb9k+zZ/JryHFN5b5p1TokvMSLIGjZZRcTqRkmBMYz+2H0BUsMfs0yWj/+EJKJMVTDPDt2/Wv+orxzjQ7XNlQXr7l/UIJkp92OTG+OPDaXPRYySj+Gm08Hfp5cdHVtr1PWHaE3Ulf5HyTOmCBYbc3ZV7+2iZOHX0O4oqdXFMq1NCdqBEWAvmZn23rVauVUuMs8SVTR/9PyyzuxhQywxxU52SHw1fPvdVL88OccyIf1A==
X-Forefront-Antispam-Report: CIP:164.130.1.88; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(13003099007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NkdFAdbKTslQd66MSVQb3L1X2BFBI1RhVUTz1BxAAeCm1sAlDeGjygZfAbNB6TkxajnUcDGDTTcu/eZ/h7suO+85Ws0O/kq5sb4R9s+sdWrD+WaBvsTFM33Jn1HMhpzPC1nlwayWrTX1yv/9gbqKLolTc4efeauicEF6HiQdX/o7fZaPRhy35nRgYUSqNk9HLIqfQtKENI3C72DdCCQVl+RJtXlqiGs5dsUm4XANxVSMH9Gtr5HExpRZ7Lp2G013I0/UuqHRKJyv/lv+HmUytu4O0SW5J0kfmjW4wswuQFi27RFXtHQb/vVtDsNS5/2o94oTZI5zfrncyDG070faBFenKVZQffJeVo0LVcIIcUDNKU7cNcihU4Y/UVXjHkP4KT5wpk1KT9woyRyUvN9nKJxzELKYiO+IBcQ83mf6MP6yPhqDt+alwMTWDC/uiki1
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:48:15.2127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed678b7-9922-49d6-7132-08df081ee884
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.88];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8699
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom

Please pull the STM32 related fixes for u-boot/next, v2027.01: u-boot-stm32_20260901

CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1143

Thanks

The following changes since commit 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc:

  Prepare v2026.10-rc3 (2026-08-24 18:46:24 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260901

for you to fetch changes up to 295f19cae3f4cbebdb8685e3fe063c983a46fd1d:

  stm32mp1: spl: support loading U-Boot proper from eMMC hardware partitions (2026-09-01 10:20:03 +0200)

----------------------------------------------------------------
STM32MP1:
  - Add stm32mp157f-dk2-u-boot.dtsi file
  - use debug() for image entry point message
  - spl: support loading U-Boot proper from eMMC hardware partitions

Various fixes:
  - MAINTAINERS: Replace STM32 and STPMIC with N:
  - treewide: Fix STMicroelectronics spelling

----------------------------------------------------------------
Dario Binacchi (1):
      ARM: dts: stm32: add U-Boot specific dtsi for stm32mp157f-dk2

Marek Vasut (2):
      MAINTAINERS: Replace STM32 and STPMIC with N:
      treewide: Fix STMicroelectronics spelling

Sean Nyekjaer (2):
      stm32mp1: use debug() for image entry point message
      stm32mp1: spl: support loading U-Boot proper from eMMC hardware partitions

 MAINTAINERS                              | 36 +-----------------------------------
 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi | 11 +++++++++++
 arch/arm/mach-stm32mp/stm32mp1/cpu.c     |  2 +-
 arch/arm/mach-stm32mp/stm32mp1/spl.c     |  5 -----
 include/configs/stm32mp21_st_common.h    |  2 +-
 include/configs/stm32mp23_st_common.h    |  2 +-
 6 files changed, 15 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
