Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331DBCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3619847C4;
	Tue, 26 May 2026 14:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WXdh8iZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47DC846D3; Tue, 26 May 2026 14:42:57 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFD4847C4
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mr1SqRq6etqDxN022xPNS0NFgwjVDZlETsev5AV47DNMnHJJ+x6c8VReI9/AIkIRy4WWwJssKXHvJSMXuuzWyrfIt5zaxy+1lcShERC16LhQxkusysFj3q7f15nlL9sgme+Fv0un9wDRUFERVeG8nRV4XTe9eBw8fk8fkfg6Zp415c41mJr3y8QLwDwIfeCM1/k2vza/1R5R0uhLkaNWzqPhvJiH/yXfRnd6gxYGQVJWhggwzG2Pg01qpTN1hmhp5UFTV6in8w2wRUd++9ThYaOrcmi6mSAm/6tlUhcFXeq7JugymqkJROXxGojL2CJpkCATB3mClMFIpQqvlquBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEOKPpLkhaM750IxaUhR1+wUxJsvhYeCBzw6YOhTjlE=;
 b=DBbtIxzYCe7+EupdiIolzWYeEe5wCJytGFJrYmT7N/Fqef6K4gRNExtRm7dpVIA1qhUYhQ01gl0NyUgDNuLB78dfL9CNMATau127xnhthcNso1Gj7s3inaeB9Sz2p70sEf/2VpsfxoyYiotw6TSlvHl79ETxcUYQQAl79TXW8g0HsKDem79suBKV6MeAsdwvOfggb/Bs1RmUevyGzCKD+h1+tGnsrli1i6FPuN85IO2xGPWM1/82HAXwGvoy/oR69YOG0UWMjGKCuRxthCOIveslYWOcOCnMFiRT6jsA4hhpZj3Sal+Btcv2xEVgr0kGwPwcYQ/Eq7lUkj5tyUqH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEOKPpLkhaM750IxaUhR1+wUxJsvhYeCBzw6YOhTjlE=;
 b=WXdh8iZIJJSqBNZf4W7IQRtbg0iLNKCQxOQTXthtD4Ox6oDDr7nwadwM9KT69BQC7cU5yO/jkXHZMErQDAbD3h0iPAk1yHpUq34HzQ8DFae9HPvCPJMj7HIujnKzu2ZB/ed5MGUe6IW/fjr3URpVpilLiHo7aNZozm+i9p8Uwyr5j8AaVZikts9yuW/PZ2etAZ8r2Dg6+dB9m2RE1/s+YjTtO+ugUiawqliviNnNcQyARvcaHGhXorcx6cozF9CSb1Gq9XrluxANzVGM+/3h/FLfiWLnOIbnb7vzwGlzyYnhiq/1BQZpoT7MXOE0miWTpnCK0c1N+WGMFRnG7JA0sw==
Received: from CWLP265CA0467.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d4::17)
 by AM7PR10MB3953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 12:42:51 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:400:1d4:cafe::81) by CWLP265CA0467.outlook.office365.com
 (2603:10a6:400:1d4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 12:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 12:42:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 26 May
 2026 14:46:32 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 26 May
 2026 14:42:50 +0200
Message-ID: <8143ad09-bdf2-4023-8b63-22518acbec89@foss.st.com>
Date: Tue, 26 May 2026 14:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.07 =
 u-boot-stm32_20260526
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, Yann Gautier
 <yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|AM7PR10MB3953:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b5c98b-37c6-476f-ce19-08debb244ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|13003099007|18002099003|11063799006|56012099003;
X-Microsoft-Antispam-Message-Info: yAmVOdVT0O78onaYZvdLBiMenKwwTUNaOFx35aOXtG5RBcw96yc4aT0U3Vn7af2/A71oFMNc6TGxmSrOffxOyvtaF+/erM4Hrg9EGXqGBlh8w6cb0Se2hBBlHIFtM0NDigoVnosxjkl1w76lQahdC9PmRkksxvSLJ9RZZhqifW02pLM/0ONG4uZYVubQAwlwTiHeCNzzk+jIjIbmPkv98SRPje87YZc0l9tfc6cpDbbuC2cwSnHzc5r5DTqYCmWDJSYaKUqJ2QxfmYvK4jJiXh6YT/o3LhB9a5AyWXCYrFq66Sq9DCt4Y9wBoD4pSD0USE2QJ/mI7mEJbUPGfBvRzSiV0vFOk5NSNWh+6euhVz75P8HB0HX1bzDV0jbH1OBC+tjQAS1muvyl2cBNx5zrD1iI6EGRAzVvMUNrxVVPs2R1HInS7DLNw+jGrTgbb2gJigE83W9MKpJhDbW5LxgF3nyFADQQ2uNXcU+V6JNoTOF4fGmqLpw3JhNs1HHCev/x+72vMkVD7EUJSv8GvUMwXICSG1rVQxnEkFNSvwfhipk+h5qE+Hi8Oa4OOoQfLLJZ7JWE3lKVdEa8nY8mBlbZM49/QZMeOlFiIX4yunjcKOEr6gGkAqXpzLLenPq0i7X9eQD0XlXUbf5JIZDb93d7mjkHRW/6NItLd1t1B2qq663W3mBn/bSoWp1uCvgcbg+p
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(18002099003)(11063799006)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SNvN8olMGdWnm/NWRcxC+euDOaKz99lv1eXegbi8/seQrx/3ArG/EhwAfb5A4OmvtK2Sd0XX7D1deJ5hb5ST2oIW2kOaabDAZY/IG52WItpB2QZA1dgY9V94Ac4j6gWnAa75JGhzBZT6Tf9B9ldF7Aoc55DQLoSbPv9RwbcUE8umVv+EXNaFWmA9bMEsHCzHqC6n7nUBPBqk8JZtL8OLHVoliZrJgNTyIlO7OYs1Wek3NpZlOiokPtO62pGDOe2JCGWdge7zrGw44y3A7S7u3mOwAfI2BlXTrcB79nN2nrfijUHjQ/shkZGLK6qu7q60wp3wPHRoGRttPbw9WE2c4X5RPAJQS4n6lQ1MCiqTwzr4VFXM3l1CcQDC72kKLfwBHS1amAJ9QZpj+1Wsc46jLQ3qzUbyLQ6mQ73sxuKw8uj9o6a4Ahjy22C6lKab1fTm
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 12:42:51.1616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b5c98b-37c6-476f-ce19-08debb244ca6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3953
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

Hi Tom

Please pull the STM32 related fixes for u-boot/master, v2026.07: u-boot-stm32_20260526

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/30256

Thanks

The following changes since commit 76d62273bc8a5dc126ed79ed0fb65e5a97359577:

  Prepare v2026.07-rc3 (2026-05-25 11:05:37 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260526

for you to fetch changes up to 0c035ff60c1e8caee7fccd2673ce75380dee825b:

  stm32mp2: update part number for STM32MP251/3 (2026-05-26 13:46:30 +0200)

----------------------------------------------------------------
Add support dynamic A/B bank bootup for STM32MP15
Increase SYS_MALLOC_F_LEN for stm32mp15_defconfig to fix boot with optee-4.10.0
Enable Arm SMC watchdog for STM32MP1
Update part number for TM32MP251/3 SoC's family

----------------------------------------------------------------
Dario Binacchi (2):
      board: st: stm32mp15: support dynamic A/B bank bootup
      board: st: factorize STM32MP FWU multi-bank support

Lionel Debieve (1):
      configs: stm32mp15: enable WDT_ARM_SMC driver

Patrice Chotard (2):
      configs: stm32mp15: Increase SYS_MALLOC_F_LEN
      stm32mp2: update part number for STM32MP251/3

Yann Gautier (2):
      configs: stm32mp13: activate watchdog
      ARM: dts: stm32: enable SMC watchdog for STM32MP15 SCMI config

 arch/arm/dts/stm32mp15-scmi-u-boot.dtsi        |  9 ++++++++-
 arch/arm/mach-stm32mp/include/mach/sys_proto.h | 16 ++++++++--------
 board/st/common/Makefile                       |  1 +
 board/st/common/stm32mp_fwu.c                  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 board/st/stm32mp1/stm32mp1.c                   | 21 ---------------------
 board/st/stm32mp2/stm32mp2.c                   | 53 -----------------------------------------------------
 configs/stm32mp13_defconfig                    |  2 ++
 configs/stm32mp15_defconfig                    |  3 ++-
 include/configs/stm32mp15_st_common.h          | 15 +++++++++++++++
 9 files changed, 91 insertions(+), 84 deletions(-)
 create mode 100644 board/st/common/stm32mp_fwu.c
