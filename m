Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8374E82CB5
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 17:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E260864DD;
	Wed, 27 Sep 2023 19:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="biLXOV6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 830FF86D9D; Wed, 27 Sep 2023 19:22:10 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFDB863DE
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 19:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCXPpd7depzjlH6Z6HBb0wIDo/JY3/PpcqLObYwxdZLC0sqw+2DkKaxupxaHMJ8liya6cZgYDZ08bPPChu/cFE3Cj2PjofcoX5XpHGgQ5RMtuKMK1PO5UHV0K7R/Bkfbp5EX+61OVJvtb1/LLLmHGsTsg6wFaSNLcjVCqbmClB0YUUNppQOae3ZICNkDMsfXOYBVjwPf1s17DvH+e4ezsKBdTbV30Wex8dgDxp8mUOyTlzROx3JfJLNq+bxU89J7VQ1oFEgIxZjIMgYvFeQZGyuwwJw0B1CoCrEoINAF9FbQOtbRBil5KTP14/dNinp/lvo88qRYhhQuQ214eyojkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biDvOSvs/K6cJsqBRhBlh2JShU2Of9U0czzQV3pqm4g=;
 b=Wo+k4tpBd26QIWULOEx5MKeONUP7pULtRwz8gjPA7d6oe3OTSixSO6Dmr4d/qO0xiH51ehfHrz/gqXPxtmSrkFUd8t5ejHKlcXFmrgbQuSdux48iFvEXHtQkodPHwNrvRarUsMVfvb5z5zsjB7gcTYQ6VSAiCVYzxxZsGCdurqIWV01fQCGPOT8KiN2C0ThGuBEG+nJskgQFtGSTq11fbwqvtYb8Evl8GKedGS7+QEhFsTT445YA0uD2YXMi4duaIacnp+x5HWiQoODpY5TeDeVQMkSCNgCm37S8mAm7bFuUi1SqTYbhvcX+gUcBvD9vINkx7A7tWAO4WYEUcWyP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biDvOSvs/K6cJsqBRhBlh2JShU2Of9U0czzQV3pqm4g=;
 b=biLXOV6k1ingTdWFBRhcdOn+LwyhZ/epOyG161NtlK0yxYD+Z+YMQDU3TYxOePPHSOkLau76k8Tvr6bsMhbta3yhfUwEnBHp7GOytK6974COg8zcxraKr7CX/hZPHslrh3bNXcm8z88SGVyI37jmcNy2Bs58nFzf+OIw0AQSshGLsxmLux75yTNLQZb0OlxZ2QQpca7wVjF1qUirYQae2AmZFkGKIJVHPA9ebTLk75FMU6wrA5nAxwiTw4HgOvnExKmNCQlwoMbeMLTaOBKDX8/HQ3cP2+rbWIsAtHz/pJ7pfK/OrjWD3/HQR3xYvmVZK0ZkX4qGfc3HGArQh5cFMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:476::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 17:22:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 17:22:06 +0000
Message-ID: <0ce3edbb-d501-4f93-90b1-3c9fa138493e@siemens.com>
Date: Wed, 27 Sep 2023 19:22:04 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] configs: iot2050: Disable CONFIG_CONSOLE_MUX
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff741a2-1bc8-416d-0a7d-08dbbf7e45f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIUpjdlLTKV4k3pMpwvr3nS8wdoYaU4m9ySF50maQjtfNCSTGukNqLRz21fyFyncWVvs9wCjnlvqYdDhAFCQexv3O2XiEnjDEGqs48lErp/2XUXGALyQLIeh/G+dyxSfy535bR8S5YaU1cYDEVvmQGcqdAQPU1uHNh3Mmm/PvKmvnm1w1zSO+CYuNC23kFXioAu6P3ag6M5BqoovTyoZRy9OLuUedKxfKKXJit+Cl8IrtL9T1fEBn/OrJX7Rtf2/9u5Gax/Cql7MtsWb43O+mYVQAqxiW3WKO5zaHdyjAvk4x+9qNlLZg47+fPAvMezKVWe+VtI2IRQDrwqAgb0dTYHBLsg0aoNfM84P7Kj3fFu+mGgKVhdmmvswIrVCQ6ZoOR/xzoHm5bGmELbKUSsJTNsrurIUgpbI5OKPNq5dQOKFUGkvSapxXziyvX6u2ESsuQ6hzbfRI9TL6xVnZLAS6Z61k+daLC42OcnoyL4aAQBFr//J8XD6APATmTpyLO6WNvo6tXZkMyO9gylkmQZok6u1JX0jHVlhdGxtXezTpERmFCycbdK1441oVQA6EvVMidf255WFnIQAiyrfEy/KT10RNKgt3U68MLqFPjDHe/a4uklXzeZb8tbeZ1mJmsI+eJpD0jIB6FTouIeoFkd31g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(86362001)(31696002)(36756003)(31686004)(26005)(6506007)(5660300002)(66476007)(6512007)(110136005)(66946007)(8676002)(2616005)(44832011)(66556008)(41300700001)(316002)(478600001)(8936002)(2906002)(82960400001)(6486002)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWl6TTVzWmxmSXR2a1U1V2t6NXpuRm85SmtMM1BvTFdWdXcxQU1Sb2xrUHZQ?=
 =?utf-8?B?czlqZzk5eWVlcGhNUjJWcFFVYlorT2ROOTY5VWRoY1BCcGdPeGtFVHZ2OVJS?=
 =?utf-8?B?SkloTU1nUkpCVWZ1NHFyVWZYR2puRStyK0RoV3RqdE9HRDRHUVE1RXcrYWFB?=
 =?utf-8?B?dmZkRDJYRXhRYldYSXZjVEhKQjNZd0xxbFNLZFA2UTVzTTBhK0ZhY2tVYVps?=
 =?utf-8?B?b1k1SFVZNmVONzhEVUtUOUdPWXBlNGllbmdwM1VMZlVmRm5HeEt1d2dCWjZk?=
 =?utf-8?B?ZTJEZ2lsZlR4YXExSXppdDgyQTdYT0hLdXVTQzlsNzB4L0U1Nk5hY2VuWTAw?=
 =?utf-8?B?dmFpNXY5K0RjUktKSFR4Syt0dWw2Rk54cGpVbmhpTTlubjNHN3J5ei82eXBV?=
 =?utf-8?B?Ym00UVpyRTFBWnE1dnR3dDNnRUYydVRidms4VXVDaXB0VDYwN2dMTjlFaFli?=
 =?utf-8?B?bElubjl1K2Z5aWRmSVFkMDZQYWEvb1Z0blNrcGplZW5SNmFBcitIZXo1RmFY?=
 =?utf-8?B?UmFHZW0xcDIzeWxWVmFUQk5aWWMyZkROM1U1cDd1eTRpbmMvMUc5WkUwS1ZF?=
 =?utf-8?B?TGtiUUNEWEdURUNzUmtRaUxuVG5aeEt1aVlVZEY3RXhwQm8xMFNiTEdyY3hz?=
 =?utf-8?B?NXNTNnhLdUVaN08zQUs1QUxjSkNianFYRjFGdysvcHVzRFRnUEY5QVd0S2wx?=
 =?utf-8?B?UTJXQ2RTcnQrWEtVcU1oQUV0WUZudzA1VWh2cC9aUGsvRU9hMkJPc0tkTEpE?=
 =?utf-8?B?dnhON1hLOUFjS0VydzBtcDBGTlFKZUsvUDVDSFhLTEhNZG5aaFY5ZzdhZ0RZ?=
 =?utf-8?B?dkQ5YkY2SWs2cncxa3JGQmpaKzRJUUFYdE5odGNkMlgxd2RqMEZRMU5pRFRu?=
 =?utf-8?B?eUd5SmRIdmRUdkRNWlVqZTFQYytCd2UyVjgyRXk0aUw4Nmt6NjNHWTFZWDJB?=
 =?utf-8?B?bVFXV0NCWWdGTmRXK2dRT2o4K3M2ekNnais1d2JjMmVOTm44dVhKNFJTU1Zx?=
 =?utf-8?B?eHVSSGF1d0dkdTBpcDhEY25HU2NtUzJQa0NGNkhuTFlLWlpldHZKdEplME85?=
 =?utf-8?B?WGY4N0dzR0hsR2VVbTVzN2hra0xaWWpXZ3VVZExBQlordWtVWW1nQlduVFdp?=
 =?utf-8?B?RklOcHhCdmhGemZ0M1VxVTQ4ZmxYUVI2ekxzMlVjSFJxdnV2NGg4YWpqaHBR?=
 =?utf-8?B?WEw5dkJjWTltMS9OUEhkTEZsS2E1UVY2R0dWMVA3d0pQTWkwbkExcXdFN0Zm?=
 =?utf-8?B?TCtmYzNUZE1EZTVDVU1DUGd4VEVIaFNPTTh0dmVFYXBBQ0tCb0hRcG9jcmpM?=
 =?utf-8?B?N3VKN0ROZzBIY0NKbU5aVEU5N2xQM2czUDdrbmczaHBEOXB0YXdMSnFScnFX?=
 =?utf-8?B?bHJ4cUVnbmUzVGZvbXR2aWF1YmI4em5QNXkraGFRVTFlZjJmTTE1MDROd0JH?=
 =?utf-8?B?ODZMZ2wyelJRQkdTUUtuYU9uNWl3aHVremU3eGpYb3VHd2NkT2loS2ROcDdo?=
 =?utf-8?B?RGVHUVFuMjNWd1pjMXBWV2JIT0xNWHpzbmtWN1dMRDFNajhnWVZIMmd0RU9Y?=
 =?utf-8?B?UkR2cTVVUVNqZDBxL1haakVSZDlNZk1LL1c4WUowYWkrbElWRWRUaWh6LzJP?=
 =?utf-8?B?eWRLaWg5YmQ2L01VYnVjSmR1c05zdTIxRkhjNFhuODNJQkRlWDdNcytPVWZB?=
 =?utf-8?B?aXJKRU5MTnBaYWJkUzU4eEY0R3lVMklFdXJtRzBHVXl6Tk5rc1cyeFhQRE1m?=
 =?utf-8?B?UDhtWG5Vb0pPM1hMK2w5dHNxZlJ2dkFVeTYxR0VVYjNDcmFZYUwwRVgxLytM?=
 =?utf-8?B?bEM3WHByK2xFRjJTT0tTZHlLRExqelJXTkdCd0FId0MrWnJSUXhrM3EzZitQ?=
 =?utf-8?B?Y3ZQaWdCQWlJMmg1WHZXNFQ5ang3QXE3WHJ2a2FmWHJ1Y3FMdkU4RTJHTGsv?=
 =?utf-8?B?MVozaDRQS1lTZThwNDRGRUlKdkdiNWxlT2IxR2hkeFcvUGpJQWZUdm5hRXZB?=
 =?utf-8?B?VnVRbUZYNC95WTV2b1pFWkZTME1hbFBzOUs5ZUF0aE1NU1Ztb0NRWGU3eDd4?=
 =?utf-8?B?K21iYjgvZldTMXNqMGkwNnF6S21ZQUJNSFpmQm5CVzV2OEZEY2tOdHl1ZVBq?=
 =?utf-8?B?czREdEd4M2l3VXJ3L0MvUmNWWW9uUVpOeU9GaUV0YUpETVF0TGVsVVpTU1Bq?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff741a2-1bc8-416d-0a7d-08dbbf7e45f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:22:06.4873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3Zbxif088maEfm4uxugImWX8pTDFe61mXB8xIkB2GdXSlW7vPO6m9LlXY+LrjAXp+cCfWG5PG/MKjxICNFg/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5578
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

From: Jan Kiszka <jan.kiszka@siemens.com>

We only have serial as console option, and leaving this on turns on
SYS_CONSOLE_IS_IN_ENV which is also not true for these devices, leaving
an ugly

In:    No input devices available!
Out:   No output devices available!
Err:   No error devices available!

behind.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Fix for 2023.10.

 configs/iot2050_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index bc9ca16fac3..3f05f8c38d7 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -18,7 +18,6 @@ CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am6528-iot2050-basic"
 CONFIG_SPL_TEXT_BASE=0x80080000
-CONFIG_SYS_PROMPT="IOT2050> "
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_SERIAL=y
@@ -41,7 +40,6 @@ CONFIG_AUTOBOOT_FLUSH_STDIN=y
 CONFIG_AUTOBOOT_PROMPT="Hit SPACE to stop autoboot in %d seconds...\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_BOOTCOMMAND="run start_watchdog; run distro_bootcmd"
-CONFIG_CONSOLE_MUX=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -62,6 +60,7 @@ CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x380000
+CONFIG_SYS_PROMPT="IOT2050> "
 CONFIG_SYS_MAXARGS=64
 CONFIG_SYS_PBSIZE=1050
 CONFIG_CMD_ASKENV=y
-- 
2.35.3
