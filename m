Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2BACD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF594846D3;
	Mon, 25 May 2026 04:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G7tg3+UE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E260484859; Mon, 25 May 2026 04:35:06 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F11841D7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es9yowcxSf7FrrCfDe1xOueBRU6NUKm9J/0rSfiKASvBnjdUMof73gNic8WDyq+8uLuyZougF6uWrptxW5SLTmDXSu+WfBWyv6U9RKt9f2uPWILRORN4BMZvBECsCzqQFUdsIbB48N7l9TLziv4l+yh2cYa7WAf50tCn8DGusOHRO+jANXqb4Z4DwJDOCn5WE6WmZi/RpncCioPSodoagJUCjLhqGFI2DZZnHWqrAmqZQegooen358weKSh8z4jsnJ5xtT1AmSnlbyLAlVF0E2xVqXPbF7WQJWQXeSwUxz3FuiE2Mxek2hiOtqu2KRdR5ZxqkB+qitFZvN+9Rjuchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1GZcTv1h5Jr6A/kfgWOZ/3co0Qo44UbHTklpRXjbCw=;
 b=a5dXy8bm9axrxb1ZN0eme7wWgco39zJQCz+fZHtRV/XdyKt1Nwfu0reH/5luJ+bQqNcGDkLKLYC4vOYYHwYas59cJc64JMIr8qIsQsn+K7l9LTooCsHJr5LDe+vTkrVwu0HQX45SXJoJdFMV7CGNhHXYmxXKFkb82bfliZd+GgHew0EMm+Ns8q0BiWROXGFiHHC4+QDMPuXs1EyVuuqIp3omyCEItQi38IA/TLaXTZwLn9K4gPAibLJm+mkEJRJjQuafuX3OSqkQeb4Lkre7jYd+C2dZ3hdxFWretyX0tiOF0Rz6dh/N5MLkETZ9hFGG8eH+aiVP6K/I17Mque86kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1GZcTv1h5Jr6A/kfgWOZ/3co0Qo44UbHTklpRXjbCw=;
 b=G7tg3+UEgxFFR0ru20sKYX/2QWz0EYE4HcR4UmRDeKIdsmvK0S0854QzCqLYX8bQrqMa1Pc/sZYrbhy8ypBeZOMb2ccPT0pGEkoDKY/UX8GD7EX/QwLbVEevtIxkGqAvP9qPDA8vl/WWKyiyQSOTONsNCuRh7zT++65/WBDG5ZpcWCDKjZHw7SvD+TyQ/msiIom/SLBVFqaajU376Wju7Sn8+fVYiUaWAV1mtSATkZrhBQhvJCsTGYsqw0bBG8O19PvV+Swbd8Ua6BeqeUV19k7PmvcZhYuggUZ7Iu65gknzs8YNZhwCvzzaSrz1EwDn8nKBk5N0yvKx8gJsT26rCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10118.eurprd04.prod.outlook.com (2603:10a6:102:45b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:35:03 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:35:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] watchdog: Use device API to replace devfdt_ helpers
Date: Mon, 25 May 2026 11:51:46 +0800
Message-Id: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLHE2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNT3ZTUsrSUEt3ylPx0XQvjFIMkyxQLy7QkAyWgjoKi1LTMCrBp0bG
 1tQASdDqdXQAAAA==
X-Change-ID: 20260525-devfdt-wdog-83d0b9d89fb0
To: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10118:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9c511b-3734-4c22-0e4b-08deba063930
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|56012099003|18002099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: cv/ih5zrcWICgWlpGUUkVPTTS8M8DwSG7LZ+xfxAQ09a+Z7LLAMlG1gTe0528QK7TQ7qfnZ9UPUbdVnvEKeocJzjH9cVJspMqS85stCcPVHlUIVh+ddZeMD/CjTJ3wBo39DTHLyXKUcvZEuL+C1LdtRDmzyPxo2S7Do7rA6fptEUl+jejkfoNl6wVXghlO7fPHBLuXlkjQLo5sAyGc0OXgxU/RENUQ+8h/lDHgf9K83zzv0OvK9cbitl93gsqWz5ZyH9lOhgNLymalHx+jO3dZyACN+V3yQdLACDvvBcWUFsVSo3ogd6TO6BtJZYwp4hZnjzsjclG+aIWpJEmO0GqRG++69oikdPG1cn/QxfWNwuKEmNEIZIK3RWwmUrzysIIUzOGEydbXRtV8DEdnlHkvAxqaZSB1E1kcPXkEzDy33BOUMxXZPwDGr9MiR/Yi3SszCCl8cPiaA5qd93NX9HqkkKBGO1dQKzJfO5iZfU0xdR0Zwo/4fIOpn5gRTCWw4vukiQU4vM/+EX0lvY30xtGIahzl9N7Yk8TdePBesLCiJWdWVz5pWkLGDKOg/eXtjt66x+09j6gZKwBdHB6NwvOQuIYn/9uc5sR3hm/D9ZgR0+tD5cotCiUTzjb0f7+LztGsVKCtlVKAbl8NtY+VFDL64GJcguFMI/orJoxbeFFiAsBedZkNrgusJB1kz5AlGe6LAoT/JNHZUkQNKuEFDjsviyAs6Ap8dF5FOCb9Dfym/zJzmRQDnoTWXfWzp1B+Kn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(56012099003)(18002099003)(38350700014)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHVCSGRZVHI0bHhxdFU1UlhTS1Y0NWhibEVjczF0dVp3c2JUWHNDVVhrLzNW?=
 =?utf-8?B?eHJtMkJKN3JzNEtWUnVxNHVhR2Y3WE8zZ1BCRWtWbnRHNXpja1dqZG5KbHF6?=
 =?utf-8?B?RTd5Y2JGbGRScnBmMGlCVEwxdFZIWmxWK2d6SWRsakJKdmtaTmdGcFprd0xO?=
 =?utf-8?B?STAwVmlIdTBULy9TSXRMcjhKa05FSk5iZWhiK3VHU1RIM09mc0UwTlR2Z3Nu?=
 =?utf-8?B?elN4ZUVsZFNpaTNyYlRwbnZ5VE5ka1ZaK1p4TzdXY3doYnp4TGJWY1RIQWZs?=
 =?utf-8?B?Yk5lUHZCemozSk44d1FjdjMybG94WXNGbXBHSUp2dFFWU3BGM1F2TlBDcXlv?=
 =?utf-8?B?ajRUdUhWaktBN3NkQ29NTlRHc043Vk0yRUVxV1lCRFh3Z3lES2FFR3hXKzgy?=
 =?utf-8?B?QzlHMGpZS0ZSV3JiOHF2SVowRUZwNDQwQ09iMkxpMWs4THZ2VWZXMXRMTUxN?=
 =?utf-8?B?eGFhMHpoVUFCUmZhVjRmNU9Tc3dkaUdGWXEyQ3dEOUdCNTRYZXFEVUE1bkFF?=
 =?utf-8?B?ZXRuUm5qenNrZUQzUm5KdEI5YXFSaWhFWkRmcjJwVmVVQ1MwYjZ2Z2hvV3hQ?=
 =?utf-8?B?bE5QLzhmN0ZXaWxVMGloUFpGRVVERGwzYzZUQzNKWURYWnRwK0t6dWdaS1cr?=
 =?utf-8?B?QnVJSXFqdFRuYU0xMEk0eTJ6d0ZGTlJJTjRSWWNUajlpaHI3dDROS1NCZ2VZ?=
 =?utf-8?B?Si93WHNieFBSUGNlOUV2empWUy92YUNCazVDc3pyME9CcDNxYWNJcC9mZENm?=
 =?utf-8?B?MDE0Y09HT3d1RzNRSmYyaFkwb0pCc3RabWpLZnU4bTRWNm9YR1l0WWFQcXQr?=
 =?utf-8?B?K0ZuRUJwUTk4cUc0WUhudTU1eWh5LzVWSnhIaGY4Y3F5NUdQeWxwT2EwTlJs?=
 =?utf-8?B?QlV3TlFTSlZvNEFCZHJnTGNOSFNCUXhKWk5CdURaQzdkejkzYkUveFgwOHY4?=
 =?utf-8?B?QkZqOW5mUTNodG01QTJTYVI4OGg1Yk5OaWJZODA3Um1RMFdWRmk2bldVcEFp?=
 =?utf-8?B?Z0o1dUFzTHFnWmdDeGd0MmhKaWdNMkcxRzRPYk9ST0xBd2ovTzQ1QlpQTFd3?=
 =?utf-8?B?OFlBZFZUTkpqTWU1bUxiNXNuQ2JndVFIYzBCV3paeUJDTS9yeXlZUUVxVCtu?=
 =?utf-8?B?bGlQTStjbmZoNmhCbTBlNWhiUWd3REtNTXZoVXZleUVsc3RQbkJ0V3lXcmM1?=
 =?utf-8?B?SzkvWU9Od1dmS1dNbTduYktXQjBFcjlTWEhPZ1BQcnNOL2I1Vy9RS1pNa2t3?=
 =?utf-8?B?OUh1K1lJaHBKUkRlTDJkaWtqME1LVzFMd2Z6SWlHSkJhcXlrbEd2YjJDWEE4?=
 =?utf-8?B?VG9BT0RVM2JJRWhDR2VCTDhVMFY5T1R4aE5SUDMzS0pZeG9PVGtMa1pVM2RP?=
 =?utf-8?B?L0VYK0pqN1IzUk1uOHlTSWZYZFVrT1F4TUpwZUhTaHl1Q09ZSzk5cFVha0Ez?=
 =?utf-8?B?RWJLazJmYXpuWW1XdmR3R0VFZVJIU3FHa0FuMVc0Um1VbGplNHJwOEd3Vi84?=
 =?utf-8?B?Z3dLTjU2MmZ0eFM5UjY4SG1kbHJUVGVGeXNpazVqLzBwUXlrSmlKRUIzOHpp?=
 =?utf-8?B?K2ZRcFFCOHk3anEwY3U0QmUwTk1SMUcxM25XZFgyYm8zMFJCdW1INUVWNy9Z?=
 =?utf-8?B?a2IweC9Xdm9VSzFicTdyckxGcXl6UWcvK2NsSGdCUkkwUUIvL1NwTVNMU3Vi?=
 =?utf-8?B?ZXJHcE52b05jL1c4bU9LL04wSnl3OGVGK0grdWdhZXNJUXAxSFJTMWFod2dn?=
 =?utf-8?B?c2Z5ZlhyL3hJSHcyMnlIZ2JWVTNLU1IwTFhqMW1KY2pCVW9kajlJUXdnblRC?=
 =?utf-8?B?YzFKMUs5M1VwWCtjMFhkbjVhQ0RZS3VZOGhBK2t6QnVRQ2pzYmJNclBTT2RJ?=
 =?utf-8?B?ZFFXUnVQdFhKYVVSTFhZY0R4TDFHM0g1TEZEcU1kYmRGWE4vcG1DOXhvdElo?=
 =?utf-8?B?TlQ0N1dtRGlIMzhnYWRFYmtlTzJCYWp0WDcwUHRQSDVDSW1ZcE9ZNFQrUmZW?=
 =?utf-8?B?UlBYQmNJRGVmVXJJdFVIOHhCRmxPM3JJOVZnMXY2RGJvSTRyMXdWRFhtQ2Zm?=
 =?utf-8?B?ajRDSUtCTkF4eXVVNUk5U2d2SE9MZjRqZzZNazdIZUwwNjVmSThjK3p6c2h1?=
 =?utf-8?B?OXBVWHk5b2E5YnFKUWFDSDdTRkdjZmtyR3lqaW5LQ1hicUg5STV5ZXBLSW5u?=
 =?utf-8?B?RWtvM08wOXZLMkxaOEFleG5Kekx2SlhNUUpIclh0MFUvaGtMQXl6RUkrSjkz?=
 =?utf-8?B?cjc3Z3FIdXFlbW1sYmltN2FycE9nMDYzVEhxN2lndlQvSU94L0cyeFlETVdS?=
 =?utf-8?B?Y3VzNkpmUzlKL3F6SHA4ZnkwaEcwTStqWHo5Vk02bmNHT2QrT2tqZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9c511b-3734-4c22-0e4b-08deba063930
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:35:02.7212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDI4Qc51aKyfAMwvX1UgaF7Zq4Ui9RhhagoqnIPeyeiFQ3Bk47RLoqCUua2INpH1ORA1D8fxgnKNEp1IADTZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10118
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

The goal is to remove the direct usage of devfdt_ APIs in drivers. The
device APIs supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      watchdog: orion_wdt: use dev_read_addr_size_index()
      watchdog: rti: Use dev_read_addr_ptr()
      watchdog: mpc8xxx_wdt: Use dev_remap_addr()

 drivers/watchdog/mpc8xxx_wdt.c | 2 +-
 drivers/watchdog/orion_wdt.c   | 2 +-
 drivers/watchdog/rti_wdt.c     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260525-devfdt-wdog-83d0b9d89fb0

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

