Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736A3CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 17:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5EF835B3;
	Tue,  4 Nov 2025 18:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="dUfyLVAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F3A8003E; Tue,  4 Nov 2025 18:45:08 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF348144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6y3PYAhYZQ8tueh7ZiRNisno2gWejxtpvkbQ6sAk8Gul96sNrHjXVtP2a5AhkG+i7vnlhpmaPT/6lIfcu2fX4VLVzRK318W9Nd28vQyZUAmq09TW8LdXejS9VFoCcTLwD/jGyP9GF6vQxVhLcCOthySsNzGd8ZopBFmZUUzQ8XLmpWoloy1LAPFA7/pqO/URYneICp4l9D0fFf9k6fPImju0j+0wUrJVHBHEEVgBzQ6ndlfM2l7GdwQ7PSQjvuEfvleRUsqfIPjsADWMmToWX0KKaENL2z0f7IBrh0LJffXnEVxruUK/275/A7YPAkJZbQ5j4loNZ0yfqZCOooIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKd32n5yY7kI88gMGpwjsoywHXq270GRRKdXsdBouos=;
 b=jNfG6HJqg2F2YcWpNVtLS3Qe2VFRdAnJF6CG0rInufiAMCzHAsjCHpsZZ4gDnrdjR/2qFWxhslQB+txBZik83y8a+A47yS4dE0GJs6U+x+PZCVnexkKAPwx1oK+ESSKmGgaxQ/qmvWgDRN1HGrb5+hxSAvwP46sIdE2QoSXf+G0oJmVTNXRdL6ecWgf1crHVPhfRPAVSge47sRv1PpDjy1zlNB6e/DayuaGjWVtJJ7ntxxNtvs47ZX6/QMlQD5BFNlrLweiSXt7GAyfU92tFy4h6YzpVtQkXuzJUB20V/XBQ2mpkJHSZWFPia1kqB8kfikfKtBDjXe50GTVPtAeHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKd32n5yY7kI88gMGpwjsoywHXq270GRRKdXsdBouos=;
 b=dUfyLVAQjYaLWvtjzE0q9WIRfLGbmBEow/wQClHdohBmfSEHaKYtVkBhkYyHz6FT6GN60d4rYLL2Qn+w6ewFXpncfTykK3LnZ7wy+g2zrvcG5Ki+Lj4TECcTl5vV6XmgE8GpPAe7LPtpTX/Bt3yIxvq3qp5HBHiuoegmA8Q5U3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:382::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:45:03 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 17:45:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 1/3] test: gpio: include in build, and fixup bitrot
Date: Tue,  4 Nov 2025 18:44:56 +0100
Message-ID: <20251104174458.3385564-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174458.3385564-1-ravi@prevas.dk>
References: <20251104174458.3385564-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 62557334-bf8c-4498-c74a-08de1bc9e269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sq1YeXZNiBCtmHCc6kXPK915dvuUYGumSzXWTuU3LBkuGxygNfOoIWUZVgHL?=
 =?us-ascii?Q?uuur65BQbxJsZz+FauB7cGxmf9bEYipvQbdFQB11gvZKI5gfRk254a3uPMhM?=
 =?us-ascii?Q?gw/L5uKCbtyMv80ULvkeaKXw4v/j76i5nVJeZuYMA8i3sdsz481cqYXnGy6l?=
 =?us-ascii?Q?gxJM82BZjKx9dvzOUADwqeMACnV1HsHfz6GmHXoycyeU33gy05aRuECJ5V6y?=
 =?us-ascii?Q?F7s1qBRt07F+53pcgC444ZpyG1jEiSKV8/Z3m5AESVv0YZ3wLsP/g9FWBuul?=
 =?us-ascii?Q?lpYJAGDmTxTrz6fj3xJwbCprnPPf5Q0v3XWpQlmZON43oD2QotHnpVYqYkSI?=
 =?us-ascii?Q?op3BllOeMJVnuC1UHztNPBkaRGK5FAPdBTNdHi8FaKMKSnGYkoAGkKlv9S40?=
 =?us-ascii?Q?0JJ845RBCWUOaanFNLyn3T4AUQQv57UQBcYAYMjP9GrdD0iN/vnyO4OaEIuY?=
 =?us-ascii?Q?yoOOLqS8lkgd9s+f9MTVBGJ70wjOTgiOv4rEne6uUSun1PgswE5UJSfPYKgW?=
 =?us-ascii?Q?PcgmFEZPzBvuDFi4jLDSgL5WpiYe+C/5rC8uKqBQ8iEZI3v2F5CFRAXw7X9N?=
 =?us-ascii?Q?m2zY8yD8YbM5tKsaR8BYpTe0E7y0tdDhOkPoz6Ms9mcyWh+LNppuYJWGy3nq?=
 =?us-ascii?Q?eSaq3naUVhg03eNJG9lO8Zy74/UDLtYspd9hN0ueXnUkMUv/MqOPtYIfeK+c?=
 =?us-ascii?Q?LLN9t87oMMYohip9gKX78w3dbsyu/E0IE/UmZC77MVEtDEYJG3pYHNQft78l?=
 =?us-ascii?Q?I7GrwUMUHDYi+X+Hy5wj5CmWfuw1Xgj/m8uzHcfq8iKc5qpHZzDAQsMb5zAc?=
 =?us-ascii?Q?yxOZHMtCng4ejADNDjPES9UlnUng73EajGPy4QagUfh20sX91jOTqGiBw5qM?=
 =?us-ascii?Q?aRAug9MwgLua4wxuRC0sTEokXG6UO2mLBcGigWYDNFqRWza/JxnFAAizj/ns?=
 =?us-ascii?Q?iKohX6bOVdj12bGAXMLqdbC5NDbP8ssge3nnZMSjzT5/EJch3jo1f94xtHwh?=
 =?us-ascii?Q?lW/F07R/pM02Jg02L6qt6Ypc0489vFZGBv1IYQK1ydmAVPvSe2EKxSiD88sS?=
 =?us-ascii?Q?cOY8lNwSlPSrDdoonj6xw5WG+eYa9OKvU4j/cobBBdFG8snvwsRddrur0O2h?=
 =?us-ascii?Q?zuEqF6gy4heSOiL7G81AQFj3KrW8OrgLSxer4QLf3gsUib0wu++/69GtsGmJ?=
 =?us-ascii?Q?0SXwTidofCfGDBufXbuPzCw/mr1gzLHeSX6vkwoad0HC4/TI31Zec5Y0GpF7?=
 =?us-ascii?Q?VJBr81g22gOo9aQmT8Or+gAYIjIgl02nLUGTds4WvD2YhVqx/Dl/8/+DmHOL?=
 =?us-ascii?Q?kycNIMUGBouCtvCuIuxwWsqR8c+eOBTqo98ulg31WJVoMgzisdecIecKciXF?=
 =?us-ascii?Q?rpbDsWDGi/29vWRjWmS+xvO01myzHfUv453CXgxj2kwQ9Qoksqo1C1VVEn3v?=
 =?us-ascii?Q?ySV47s13ZPibB6oMxs20fGQ5Q5bUsO27gJZWAkr0rCzKUORbbCHOaCv0SCxX?=
 =?us-ascii?Q?0AtqlesgjKqIgPVpM8aQ+YVBjKWI3toBELE1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyNpr05w6W2tljGXMCke9lwoqhL5KB2JSiFaMJOldRDxj+pcYe4sd7dtmsfa?=
 =?us-ascii?Q?9NHsOlst6imalyMnLOOi8m1uPj36RNl0Q1Zv9xgZm5C3QJ9RCxOhYyQJIE2B?=
 =?us-ascii?Q?LD6Ww2UgLTObppYj2m0bpTUCY+7ZGgkmU2eJQMPW3bwTOtn+rDwufBQUxWgW?=
 =?us-ascii?Q?56hVnpXscsmn/1IU9c2FC7W5WhZwD5+1oI1jmITpPVFyeoGPwHScD4uZcOVi?=
 =?us-ascii?Q?8a6PzLcGA/tkGT68+vh1J6X37m6jD82TmvqtUPf5e7ww3muw8edRszyP67I0?=
 =?us-ascii?Q?AFSy9mgaZ6Mjeg0mdy5Sc5tN4l5PueZ6+J8jImjQsIRaLbpzDDLyzvAySW4w?=
 =?us-ascii?Q?i+6HN6Cbq88Mb/HM44VU/IxlWcLhW4IxQMNDcaHmWIy2ha7HgB0UhTZn/VU5?=
 =?us-ascii?Q?uavA2aeDYnBsCvh46ZlGdFZ7AWNlFMjCXNqCih+ga3LBDcLC62T/BHD3lZQm?=
 =?us-ascii?Q?+22MqKu/O9VkXOtU4oHjnaS8sfPCjMf50XJwfhuqq30ZGix+mj6iSdN5P3kp?=
 =?us-ascii?Q?Eu3lYkGpjZhzEJrnVfUB0kCK0bAjoM+3X7SuAnExqu9JX8fEtpPMWJE1hqT9?=
 =?us-ascii?Q?I9EOycKdba6hDPqXjYRyGragMY6r8qi+t1YmWaAIV2x9imyMam/TkoT69/yn?=
 =?us-ascii?Q?pBxKy7I6F+aB4rsbLPFCDFoTxezSzgIXUIImVCT4B0wWFXxBVC8nH4Ik7NHB?=
 =?us-ascii?Q?plM760dZHugL2jDu6M++O4Tc8S83ugAS+rprTd42Brc+djbHLUU5NRMBUyX8?=
 =?us-ascii?Q?e0/lIrF7+G0wUt6nC9UlUOnOVN1PPc+Rm5piQYlEDerO1xQ0yO0B9KGkVS0j?=
 =?us-ascii?Q?z98X/ZBJMMfr0BQhli8crsmsIxuVrtz+A5SGmSAYVeSFpu2kxoEaNfPLd8FF?=
 =?us-ascii?Q?bs+prRTkElZ1Q9ktf8wOXezu52MDzy4RbXav72jK4kQwKQqtAdb/ZAsy+O7C?=
 =?us-ascii?Q?AXJ5VfuEb/qfhB4f+GBiTcsqQsuanL54yo8G/XTsXwk41WBNlDWtbghWxWqE?=
 =?us-ascii?Q?VMSArbqZkwp9yEtyVpR8MLolmxyfbCZktgR7YMzRNKfQieLM77g5yCFY4xC+?=
 =?us-ascii?Q?0Bj34xv1ECCVLtslLkFfjdXhF3vGtFdLDdwr3PZlTcH5r4Hb+Tl9hZlDGBHa?=
 =?us-ascii?Q?bD6XD5WlQ/PxW51PbACOGwtm18hEuoVyr1LW0/DguVx/clQKQWN3WVJH1Znt?=
 =?us-ascii?Q?YPjzjUKStncuPsPwXfEocS1Y2gsERmBLP07xin5rw0HMFaNiXaR0A6f82J6e?=
 =?us-ascii?Q?MTBk8PaJame5W7RcHwoHwVlmg9oK6C5km6rhFsmOxZEQchOoLA1ivbNeE6vr?=
 =?us-ascii?Q?dncnrNmgZ4zgNWUeuMm53/tMMEWHZQtCngCKHbunspxik8iPrMtQNO47hWvL?=
 =?us-ascii?Q?CFhwbn0M3P2F/lSCb+yUwH6+PHj3y50dX4GLacwsybKQfasZMqUWR9OiWsC4?=
 =?us-ascii?Q?doMzFub0CZjl0Y/WNT1MLJOSTLvIhQVyCDV2zRfP2SUVm/n/7GjwPLAx1khi?=
 =?us-ascii?Q?jKTG5xt2ZNRdSfySYxyqR5Ugeg4Z2nj1Jdmk92hFsESQr7tefqLZElvkyzfR?=
 =?us-ascii?Q?725e0Nf+mC5M7UVB4bTIa90WxalNxm7N+ftmur8reB1ctdlk5gltYM8wBldN?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 62557334-bf8c-4498-c74a-08de1bc9e269
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:45:03.5342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DO20HNM3Q+Fbjig0SgOgvdeSSu6tk3Gsp++x4HTX92gIZDpOWTemUmhBFRwcCU4vQbhCFgm1s8ayU+USQ2M0amy2drdfQJGFL/fHJQU7ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6286
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

Commit ebaa3d053e5 ("test: fix CONFIG_ACPIGEN dependencies"), which
got into v2022.10-rc1, accidentally left out a $
before (CONFIG_DM_GPIO), with the effect that test/dm/gpio.c has not
been built for three years.

Unsurprisingly, the code in there has bit-rotted.

- There's a missing ; causing plain build fail.

  That code was added in 9bf87e256c2 ("test: dm: update test for
  open-drain/open-source emulation in gpio-uclass"), which was part of
  v2020.07-rc3, i.e. long before the commit causing gpio.c to not be
  built at all. It did build at that time, but also, the missing
  semicolon wasn't found when fa847bb409d ("test: Wrap assert macros
  in ({ ... }) and fix missing semicolons") happened in 2023.

- Commit 592b6f394ae ("led: add function naming option from linux")
  bumped sandbox,gpio-count for bank gpio_a in test.dts to 25, but
  didn't update the expected global gpio numbers accordingly.

- The "lookup by label" test likely worked when it was added, but then I
  inadvertently broke it when I noticed that dm_gpio_lookup_label()
  seemed to be broken in commit 10e66449d7e ("gpio-uclass: fix gpio
  lookup by label") - which landed in v2023.01-rc1, so after gpio.c
  was no longer being built.

  The "label" (which is a u-boot concept) that a "hogged gpio" gets is
  <gpio hog node name>.gpio-hog, which is why it used to work with the
  strncmp() but doesn't with strcmp().

  We can either revert 10e66449d7e or append the ".gpio-hog" suffix as
  done below. I don't really have a dog in that race; when I did
  10e66449d7e, it was because I thought the "lookup by label" was
  actually about the standardized gpio-line-names property, but then I
  learnt it was not, so is not at all useful to me.

- The leak check now fails.

  Test: gpio_leak: gpio.c
  test/dm/core.c:112, dm_leak_check_end(): uts->start.uordblks == end.uordblks: Expected 0x2a95b0 (2790832), got 0x2a9650 (2790992)
  test/dm/gpio.c:328, dm_test_gpio_leak(): 0 == dm_leak_check_end(uts): Expected 0x0 (0), got 0x1 (1)
  Test: gpio_leak: gpio.c (flat tree)
  test/dm/core.c:112, dm_leak_check_end(): uts->start.uordblks == end.uordblks: Expected 0x2a9650 (2790992), got 0x2a9700 (2791168)
  test/dm/gpio.c:328, dm_test_gpio_leak(): 0 == dm_leak_check_end(uts): Expected 0x0 (0), got 0x1 (1)

  And it fails with the same differences (160/176) even if I
  remove the three lines that actually exercise any of the gpio code,
  i.e. make the whole function amount to

    ut_assertok(dm_leak_check_end(uts));

  Test: gpio_leak: gpio.c
  test/dm/core.c:112, dm_leak_check_end(): uts->start.uordblks == end.uordblks: Expected 0x2a95b0 (2790832), got 0x2a9650 (2790992)
  test/dm/gpio.c:325, dm_test_gpio_leak(): 0 == dm_leak_check_end(uts): Expected 0x0 (0), got 0x1 (1)
  Test: gpio_leak: gpio.c (flat tree)
  test/dm/core.c:112, dm_leak_check_end(): uts->start.uordblks == end.uordblks: Expected 0x2a9650 (2790992), got 0x2a9700 (2791168)
  test/dm/gpio.c:325, dm_test_gpio_leak(): 0 == dm_leak_check_end(uts): Expected 0x0 (0), got 0x1 (1)

  So I suspect that the leak is somewhere in the test framework
  setup/teardown code - dm_leack_check_end() isn't really used
  anywhere else except in a dm/core test. Bisecting to figure out
  where that was introduced is somewhat of a hassle because of the
  other bitrot, and because of the SWIG failure that makes it very
  hard to build older U-Boots.

  So since it's better to have most of the gpio tests actually
  working instead of leaving all of gpio.c as dead code, #if 0 that
  part out and leave it as an archeological exercise.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/dm/Makefile |  2 +-
 test/dm/gpio.c   | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 2db0e3b8dfd..a261b3fb4b7 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -25,7 +25,7 @@ ifeq ($(CONFIG_ACPIGEN),y)
 obj-y += acpi.o
 obj-y += acpigen.o
 obj-y += acpi_dp.o
-obj-(CONFIG_DM_GPIO) += gpio.o
+obj-$(CONFIG_DM_GPIO) += gpio.o
 obj-y += irq.o
 endif
 obj-$(CONFIG_ADC) += adc.o
diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index b45946c143c..34a5d1a974e 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -29,14 +29,14 @@ static int dm_test_gpio(struct unit_test_state *uts)
 
 	/*
 	 * We expect to get 4 banks. One is anonymous (just numbered) and
-	 * comes from plat. The other are named a (20 gpios),
+	 * comes from plat. The other are named a (25 gpios),
 	 * b (10 gpios) and c (10 gpios) and come from the device tree. See
 	 * test/dm/test.dts.
 	 */
 	ut_assertok(gpio_lookup_name("b4", &dev, &offset, &gpio));
 	ut_asserteq_str(dev->name, "extra-gpios");
 	ut_asserteq(4, offset);
-	ut_asserteq(CONFIG_SANDBOX_GPIO_COUNT + 20 + 4, gpio);
+	ut_asserteq(CONFIG_SANDBOX_GPIO_COUNT + 25 + 4, gpio);
 
 	name = gpio_get_bank_info(dev, &offset_count);
 	ut_asserteq_str("b", name);
@@ -110,7 +110,7 @@ static int dm_test_gpio(struct unit_test_state *uts)
 
 	name = gpio_get_bank_info(dev, &offset_count);
 	ut_asserteq_str("a", name);
-	ut_asserteq(20, offset_count);
+	ut_asserteq(25, offset_count);
 
 	/* add gpio hog tests */
 	ut_assertok(gpio_hog_lookup_name("hog_input_active_low", &desc));
@@ -135,7 +135,7 @@ static int dm_test_gpio(struct unit_test_state *uts)
 	ut_asserteq(0, dm_gpio_get_value(desc));
 
 	/* Check if lookup for labels work */
-	ut_assertok(gpio_lookup_name("hog_input_active_low", &dev, &offset,
+	ut_assertok(gpio_lookup_name("hog_input_active_low.gpio-hog", &dev, &offset,
 				     &gpio));
 	ut_asserteq_str(dev->name, "base-gpios");
 	ut_asserteq(10, offset);
@@ -161,7 +161,7 @@ static int dm_test_gpio_opendrain_opensource(struct unit_test_state *uts)
 	ut_asserteq_str("pinmux-gpios", gpio_c->name);
 
 	ut_asserteq(8, gpio_request_list_by_name(dev, "test3-gpios", desc_list,
-						 ARRAY_SIZE(desc_list), 0))
+						 ARRAY_SIZE(desc_list), 0));
 
 	ut_asserteq(true, !!device_active(gpio_c));
 	ut_asserteq_ptr(gpio_c, desc_list[0].dev);
@@ -309,6 +309,8 @@ static int dm_test_gpio_copy(struct unit_test_state *uts)
 DM_TEST(dm_test_gpio_copy, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
 /* Test that we don't leak memory with GPIOs */
+/* Disabled for now as there seems to be a leak in the test framework itself. */
+#if 0
 static int dm_test_gpio_leak(struct unit_test_state *uts)
 {
 	ut_assertok(dm_test_gpio(uts));
@@ -319,6 +321,7 @@ static int dm_test_gpio_leak(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_gpio_leak, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+#endif
 
 /* Test that we can find GPIOs using phandles */
 static int dm_test_gpio_phandles(struct unit_test_state *uts)
-- 
2.51.0

