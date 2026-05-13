Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D4FCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 05:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66019838BB;
	Wed, 13 May 2026 07:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mBDLxYE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39EE183EEF; Wed, 13 May 2026 07:50:41 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F758341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeMFwo20M+1B6kIIuWeh39LtqK8elbUb/tJkos6IdyNP8+DuqEkgRu/2weU23OcULIIB60+gwXD9UDJaOqZKLrh9LX/fLXuE596y1ubJ6jQdRwWau3mesdT6iKbpH9XPzfQzcOaEEgF6JgF5tR7x6aHvTinMRubkr0Pd7TbiCAbTmH1f0vQCe0hyRMwK0trpjdeMLzVfBl13BWs0wjYYevtLhORNk6MkrikbJbAbeT8kWESOIaXBo/ftzQf/JpuOPNqYAHD2c/dCiDTBzHykVEpu9ZqWifF98f5x9rU5qZRtz34hJ0esZU5RlMjUtryEt2fhMwHOc+YninNmLMXGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3fhcZRN6QcQIIkxEkcitVe29RFEnuLIJaIPdePXXOI=;
 b=Sivf+wNkDUd+1tCqC7j3qx5jp4/73wx2NB9LL/ZW5lPbUm/QHeUnGFmdc2gzxGSf0rT3WWzD2etMFkTjBUvAcUrivjpkmQtIXIxMyyYLn/EYRAlUWzm+ogY9KnpAGxEyVsPSN/HO6DKZfH4LlmFrjK/Fc4pPtxtqPAeBJPSvCLJLAiIG4ibFUl8je690NUo8CGCWY7FIa1VUIU0/CJ5JoHlw25js3hWO5xhTJbWKTirnb1D8bda5Eef72FhRbSJX+cXB9HcdwdQ+egNPxvs9Xd7wkv+O+veDgAHxJGU+EPI7ILV8cy5c2AqIshiHZ6kRTs4Ms50LhvNqN1IAiKQZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3fhcZRN6QcQIIkxEkcitVe29RFEnuLIJaIPdePXXOI=;
 b=mBDLxYE6DCihuvKGxMAep47zbsJwO0uMa80JP8G6FcHhCaHTI3mEMcpHmdEIPtTONsXijk1DQyORvUsnyf7ju0dgFJtFH6KfnqX1gcewMNW0B+uK6dhYBfIpfMQNbEaggRnbV2rlC/pxp1MXNT43dh+oq8VZec4vRvonnOdAFMj7iIqhWaSspnnLUU4lHWZKU5OhGrvwyE5o/9EnbRI2tQTjQ3wwxNR0yreABQ/ESyc8mfyoqHKIhu9JbFWynK0cG5EL/wBpJDMzoYe9XNPSdlN9DeeZD1JwnB6SVL4bUtWKov7rU/gK7Fy+Obl/UJF9zTMU//Vqwza1CEMKHdKI3A==
Received: from CWLP265CA0383.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5e::35)
 by FRZPR10MB9865.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:50:37 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:401:5e:cafe::92) by CWLP265CA0383.outlook.office365.com
 (2603:10a6:401:5e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 05:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:50:36 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 07:54:25 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 07:50:36 +0200
Message-ID: <0a17d96f-19e2-410e-aba1-c2657b881b02@foss.st.com>
Date: Wed, 13 May 2026 07:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Pull request for u-boot master / v2026.07 =
 u-boot-stm32_20260512
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <f38d7ccb-c9fc-45f0-8083-a2e6b6819496@foss.st.com>
Content-Language: en-US
In-Reply-To: <f38d7ccb-c9fc-45f0-8083-a2e6b6819496@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|FRZPR10MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa91612-f1d2-4f00-d0e5-08deb0b38e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|56012099003|18002099003|13003099007|11063799003;
X-Microsoft-Antispam-Message-Info: KeXx8kVmMH4jwqbIfapw9cMC02Em9MPty5ToH5StOOejrW5o++ehhQLEv5z06cmIf4n5AF63SVkTYgUZBZLhc2WMrPHVnV2j9z96YhuOLX5ldNpOPbP/Ac5hjiNRrSlH9+jdC22rcPQZggYN2WxwfA8ke3SfrH0vu8AHMIr2PZ25N/I9mmLnGtNvE0PUXT10XjmZZRBXb3popaGp3FnP/d3tswB2KS8OTatltBNPHB1NJn2y8oo3umzluUF/kz/TGJMAK7/aLwMrecFUgkHuD80jpiy104yVf2fdTZRoB/t+vn7gM6VPXWwt2P1W57E0TCmpJdVwkHW7UNRFWDfj5O2BziERQsfMa++OLm2dWwJd0D4Q3D05t++Q3+6Upl4fpRqzF2kPGGii7yOJwusRBMenq9gQb1VstWMNmOlh1MVRrGXrWIxZKJ99dug2FLkEZyNnhrSIQmrBVWT5D4LZ00qcwBu3UwqV1MdoJqAnioO5OphwI6qBhskldwEUwrHbx7D/WDv39koNDImGIlEV6PQTgY2z1ZJ8DySEkxwoywvfiqZeFndPeNpsyOTpR9tMrPNW/nnT/4FHPGYe3TqR5+OvlQvPss+7Nv9PiVxPlW68zjV3oeboJKQaOvEgEnVRLzrXcj+nHXvza/uE9Igl+jR/t8Umq/q+w9KrmDzWNH5y6HJZffXRmUQq8d5tp8pc
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003)(13003099007)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eAP8cTw4Us4zG/Y6rHzOjVHCEkgYM35l1EZ0rTOFGXWHCO6Pi9E1WhZhqJ6LqJQ0UKdaE8kvDNeKZJ0rHAAtd7otPMHSw1AMobjHpXzT5oCBiRF5S7tZLwQfcn6/Bi1dfZS+1DASc5qd/fz2esOdgcfsDr/Uf8uew2YA/xxxhzyiaUemvemVLBki1N+afpCTrmbt+c/VCeHjr+mnjAxQYrWVKFn+sEcQ4gNzJb52Q45uI88Rdi1lEZ/jcIMgAeXkxDw8guCx3jHYxCMKwGMPbh8cvRw5DUg9ht0TVJto38xDdl5vj6dzVHDVANTKRIBmGHvBck8rCd2NeTNWGFx+WuYnnY8VnGwInhehpQ1pwe/KbQTnh1s6txtNj5U4kJ7V+Steg6E+FgJsZIxVclf6CsahyCSeXkVUH33eI8WhCB8RDLpg1G9oW959Xhy+VyOH
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:50:36.8499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa91612-f1d2-4f00-d0e5-08deb0b38e7c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9865
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

+U-Boot mailing list

On 5/13/26 07:49, Patrice CHOTARD wrote:
> Hi Tom
> 
> Please pull the STM32 related fixes for u-boot/master, v2026.07: u-boot-stm32_20260512
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/30081
> 
> The following changes since commit 5732bd0f457b4c671e46574d64d4acb099c0f0a5:
> 
>   Prepare v2026.07-rc2 (2026-05-11 16:05:08 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260512
> 
> for you to fetch changes up to 612256838acec75407b1a268459c3a9dbb63c7f9:
> 
>   reset: stm32: Fix compilation error (2026-05-12 15:52:53 +0200)
> 
> ----------------------------------------------------------------
> reset: stm32: Fix compilation error
> Remove remaining non-existant STM32_RESET flag
> configs: stm32mp13: Add SPI-NAND UBI boot support
> Support metadata-driven A/B boot for STM32MP25
> 
> ----------------------------------------------------------------
> Austin Shirley (1):
>       configs: stm32mp13: add SPI-NAND UBI boot support
> 
> Dario Binacchi (8):
>       lib: uuid: add partition type GUID for extended bootloader
>       test: dm: part: add test for part_get_info_by_uuid
>       test: cmd: add unit tests for part command
>       cmd: part: support lookup by UUID
>       test: cmd: part: add UUID lookup tests
>       fwu: add helper to get image GUID by type and bank index
>       test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
>       board: st: stm32mp25: support dynamic A/B bank bootup
> 
> Patrice Chotard (2):
>       arm/mach-stm32: Remove remaining non-existent STM32_RESET
>       reset: stm32: Fix compilation error
> 
>  arch/arm/mach-stm32mp/Kconfig          |   1 -
>  board/st/stm32mp2/stm32mp2.c           |  32 ++++++++++++++++++++++++++
>  cmd/part.c                             |  12 ++++++----
>  doc/README.gpt                         |   2 ++
>  doc/usage/cmd/part.rst                 |   6 ++---
>  drivers/reset/stm32/stm32-reset-mp21.c |   2 +-
>  include/configs/stm32mp13_common.h     |  13 ++++++++++-
>  include/configs/stm32mp25_st_common.h  |  15 +++++++++++++
>  include/fwu.h                          |  11 +++++++++
>  include/part_efi.h                     |   3 +++
>  lib/fwu_updates/fwu.c                  |  33 +++++++++++++++++++++++++++
>  lib/uuid.c                             |   1 +
>  test/cmd/Makefile                      |   1 +
>  test/cmd/part.c                        | 227 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  test/dm/fwu_mdata.c                    |  48 +++++++++++++++++++++++++++++++++++++++
>  test/dm/part.c                         |  53 +++++++++++++++++++++++++++++++++++++++++++
>  16 files changed, 450 insertions(+), 10 deletions(-)
>  create mode 100644 test/cmd/part.c

