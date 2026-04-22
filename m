Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7ABF9EDCC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 13:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE3D840CB;
	Wed, 22 Apr 2026 15:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RJd5AToK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8C984178; Wed, 22 Apr 2026 15:26:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8504A83BC8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 15:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLJ5DE3PyFsaokrKabAXTZqcOQeolFGPPx0ORMTIMZ1jCU+0JhU8FnBspvBT07z9uMA3wLcjrSoUPY9FRbTFQOMA7DqWN+6+V6u9Jpsd0f5/d+UE4MIC44IouWLVMS48BT6nNEAXV3RW+XqZWPKwFuGC4vq5764G+wN+Sh2Jm3cV8NAO0Y8zun7Nc+3c3FFE+N2k6g1gXAH0hD3xXl/RX6UvbJxmCdBXDUCCo8QfmDodF/zengp5gtYTPa9ZP+KrTE68pbEMpEd6PdXHE8WlUAD8sojq79wp5Kr8HBnob8KU5H2vwdd1MBAXjM20GQYpYX3cRXWf2mI89ZoO5FSJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7l4zGwvVuHzBQOPfIdm3RgzXT9UBK3v/NdabkllVfc=;
 b=KWrhJKEe/f54l/D43nJbXMhnSk5BxncRZWESP7Giz3l86f1qQ9WWzNgJfzHKqhkn7WydAeseqqJxWqyMyXQCPcAIH92qYKgiCSMWpBjpeJHsnF5L2JMQqVoribwDhYqlguNuL5XwLxpwOBzB5ahI1KSXd1IlSoogMo0mmuRCBljpEU0BBXuaiaVK9DjWxSwhNf/4aI6atyMji1MbnCkMwo6tcWjyjR6IzbimWZLX//4FDcpPP7XJ/o4vEE+JhNLieRJFXbxFueDBGBDPMub/UyBoDqwCrynV5UdX0tE27ru0pIKUHZQOQglLdnDToJahIT7j8zCm6K7QQvKeizfnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7l4zGwvVuHzBQOPfIdm3RgzXT9UBK3v/NdabkllVfc=;
 b=RJd5AToKfQ0LtHY4NVSpiJUjcd6POtHNvKigt7XDB4nOSG5ax6GBGzQrM0BooiIVTq3FC+zIIYhjUHzzMZAvbPr912Hh8Joe9TRKf3pmcC6v3Z1Dfo4Qpu2gUBAWoSIhKQn5mw2sfiMdAqNV4t+UCRSzWJURe9+mifsEy2xAltw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB10243.eurprd04.prod.outlook.com (2603:10a6:150:17d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 13:25:58 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 13:25:58 +0000
Message-ID: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
Date: Wed, 22 Apr 2026 15:25:55 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Couple of clang warnings for Rockchip boards
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0304.eurprd07.prod.outlook.com
 (2603:10a6:800:130::32) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB10243:EE_
X-MS-Office365-Filtering-Correlation-Id: b18a80da-e252-42fe-cdb6-08dea072b05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|10070799003|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IGN/PpPCX7sg6X+VdqNBgZBP4PL+cZjiFwBVr69AkGmvjaNgeyVpMKG9r+Bk4YD5j3LEyCCzXlixotMiZBj4lffiqkDVcmoUv16bNZ+2DVn2cjTjvr20zxhH9CrNdVnK3grr1aHfYxaYR+QDAmX4L4s/h3LlyBNnqVXec/hZdSYs+wrnUIkqxSWhc6HVPs9XF+rKKhxCJ39aa1Qy9hiuXv4RX+gDnJvoQzdKE0UaOPL4DEPIpmeJ1CnyyYfk0ljIcHykSR8ZqlBsmRCk8uiXCE6tBaJPO4MCGFKpIx8c/Zf6ZpbHpSP3hSNvV7tyzE0mCH3VMiojLu8tOH7z45xWEre2I26bUgP95kyItgD0ss7Y4FDoA/rzYEHhBw1X6RdNrwFK38jpRJRNN8mFF7ZpIt+0TW7iNMYAiqdbADBoRYLfSx2XXVQXe5nXF6qpKMoMKsVdZwsRSuRrzq46emSVhjHW6dIwTIwfaJoFRge8dhVJsYTlwWvQzkIJIOZ95i7oFjZ78jeiqqbVe9hIo8RiDcC1pRW8/yi7SwmAstWhDtj/nSquZseHb/NrTpyFiH3MZ7JCv4/U0MAKSLwKhaA0KqQ8a7yq2yaRaVPYka7BC3e+iJBhpemPkT71ggppvZscp5UV1KsBLRxybN454Nz2GgB550NKuqa+8eHlKRfgSB8nh3NK4wgpuWKKeHxOBNiX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGRoc2szMG9MRjR6cEdrbWpiMVR1OXZ5bi9JbVJXTmNtWTZmUVB4T0tSaVk1?=
 =?utf-8?B?aTBqNThQN2pXZEovVzBmcFVTd3FJVVppM2ZzUDhtZ0ZEczFYTDdYMkxBVHcy?=
 =?utf-8?B?aEt4Q29ObGNES0JJRzFwTk43MHpKd1RubHJ5YW5wSkU0YnAraFNRL3ppUkpU?=
 =?utf-8?B?c2VkMUxJckVZOTVOTE56QmhoUnZHNW9nWjkvdGk2OTNSM3hQQldydk0wWWRD?=
 =?utf-8?B?VG10VEFzbVZXZ2xqYTJtVXozc2FLWkJqNFNCRFdYV2lWQnVZSmdha0dOUjNP?=
 =?utf-8?B?TU5DTVVacngxTXJuS1orV3BSQ2NpcmUxbTlCQmRoeU96WTZGSitWZzNQZzA1?=
 =?utf-8?B?ZW9nQUNGZEsxbUNxRzVYOUQ4Y2VmVi9ud1hKUmhzOEh2a3dRaHJlVkEydlMz?=
 =?utf-8?B?NHVvT3VvNEVvbkc0ZnVZc2xvOWI5bzhqdzNja2VweURreEV1U2NYL2ZNMWhx?=
 =?utf-8?B?TmxvQnBvYk5mL0FrNEVWd1JZSDlTYWMwMGtwclk5VEZKLzdqWTBSY1ZWRXBB?=
 =?utf-8?B?WEg5WmNXN2lIK0tONmMrSmdFZ21OU3hXK24yNFdiMm9DQzRMbnE2dms3NHIy?=
 =?utf-8?B?Qm91OGNmcm42ZHZYVll0Nlk0ZVNTbEpyNHZ1emZYbHYrSkNvYzl5RDQ2Vnkz?=
 =?utf-8?B?VXpLSGlaWTR2cW5uQkpPcUVPdFVSc3M1ZUZCT1pnNSsrTG84NzRpNEdUQll2?=
 =?utf-8?B?VE1WM1VaU0RBTFhpTHoyU3cvRTNIZjV3N0E1SVc2VklhMDZvM1RiUWhFaGFB?=
 =?utf-8?B?VmhicUQvNFoxOExzK3hlMTRlZlUxMXQ5bDVkT1VyZ3JRR1VyeDhJS0hWU1ZG?=
 =?utf-8?B?Vy9ySTVVb3FralVpSFBPeWUrSDJGMHB2UlpBRHhjREQvQWd0SWJsYmo0cHdu?=
 =?utf-8?B?YzlRL0g0YVFBZmlkV2dPNU5VTlA1UndQOUszanoyMTdhNWs3K1dxNDhqYmQx?=
 =?utf-8?B?QTNyRWxJeUkxMSt2eHpOdkk0UGRmUnZZRGFOUG5zczFuczNCaVh6NmMyWURV?=
 =?utf-8?B?K1NMaVVDalhoWG0wQm1xenk3dURyQVlzU0VKOFl0TkxySnppMFZlUGhxNVVa?=
 =?utf-8?B?RjFMNFdQM1BLSmtFZzVlOHpOb2t2UkMzcUVEdFY0UEhKelo5T0FWdytWOWpa?=
 =?utf-8?B?QnNzeVRVTFRhQ3poc3R1d2M2WldMOS9oaWVsKzlmeHAramNsSncvb293a2M4?=
 =?utf-8?B?Q3dseG80OWZYZ3VHa0ljRFVFSW5Tb2E0RmJ2L3NRRFR3ZkhXV3RNMldmR3Fa?=
 =?utf-8?B?SmZzaXNiVHpQeXZtdmdmd1Q5ZTAzamtPR1poa1EzdGRFUkkzcXVpVFZhOWxN?=
 =?utf-8?B?bEt6dE5jcDdaV1dacEVLWGk4RkovZTF5bHVZM3N3SytTWGNqTXNKT3RtQndU?=
 =?utf-8?B?TE9DaGFtRFlhdVkzV2sxRUZtbWFQakpoaWRNS3B0QVp6NUlsckdSZkdGNFBn?=
 =?utf-8?B?bThscjlzZmFsdmR4UWY3VHBsbzRva2wzVXJibEZDNDc3dzg2ZjI2NUFJTXlm?=
 =?utf-8?B?YldrQmczSngxaWhYZ3cyVVVuYXJEcC9aWWRNdVJJL211OEsxSmIrUUo0WFlx?=
 =?utf-8?B?b3VncFRrMGE5YVpRUkduTktieks4T21XMXdvSVphczlIOXFwYnFQNC8zMStu?=
 =?utf-8?B?emtzTEVEU1R4MXZaOVlramNMalhMbFlRMVJ2T1g1UDh1ZFArREZWcmNwR2hT?=
 =?utf-8?B?ZE5WWHRQSXcyb0srNEIvV2s1ZThFeTg0Zk9qdjFxeHhlemgvVE40RHljczRi?=
 =?utf-8?B?Q0x2SHk0QThPUm1Zcy9IdHpzOURXRDkzWU5hckR2N2JtUHJRVC9HMk5TTWJG?=
 =?utf-8?B?c3RhcnBsYVhuZFYxRE1OSWEvZVU5eWZ5ditDd2pOeXdGN1NRdFlGa294aE9V?=
 =?utf-8?B?T2pQUVB3aXRpM2VMeVN5SEViZFh3bk5vMEpjc1NqS25GbHhDOUdSYlJpMXJI?=
 =?utf-8?B?TkNMYzBxTEFXRHh1QnNxSVZEU0EyZ0ZMWllRMlZvR0lKMEV6YjdRYUE3dDF1?=
 =?utf-8?B?SldlNmx1bU9tc2N3akxsaHJUM0R2OEdiY2NocmxHZm96ZHpOcUxxakczTUc3?=
 =?utf-8?B?WS9EVk8yWUozVVp1WGhqZHNoZllWSU1iZ1g1cEdndDFGSERkWUgzcVVOMUY3?=
 =?utf-8?B?T1I3cC9wSHdFTDBJZ2pEUTNacGVzR0FVV0lpZnAybllGdFZjMUY1cStrZ21v?=
 =?utf-8?B?TVNuWEN2WHpQRm40em8rM3EyYlJaYWlKNjVmY1cwb2JyMFkwNXZ5YmFyYkFz?=
 =?utf-8?B?VytSeHY1NEpNQVkzaE9sQzlUOHRycUluQTFWdUxlMHJiQkREM1NORnJqNnhO?=
 =?utf-8?B?cjBQQkR1cENjZks4MUlLa1FIRENFcTFFM0V6MGFHTmJycFF2OEFDMUFvTGVM?=
 =?utf-8?Q?sdX+vsjrqqbI8UR/kM7SC8f3oSlgKHPGxv8DJ?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b18a80da-e252-42fe-cdb6-08dea072b05e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:25:58.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2PmOaahna4cuqrzeQcJCX+x5rgKuPUYL1+pyZAs005aiG0UG2xhWl39orkg4kVP8h1HIy7PomhZMNiTnbjbV3Yk9E/e4A+YDO8ooWMW0B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10243
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

Hi all,

I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs. 
First, let me know if this is a bad idea :)

gcc version 15.2.1 20250808 (Red Hat Cross 15.2.1-1) (GCC) for both ARM 
and Aarch64 machines report no warnings (built with a config fragment 
enabling CONFIG_WERROR).

For clang, I went for cross-compiling using either
make HOSTCC=clang CROSS_COMPILE=arm-linux-gnu- CC=clang O=build/ ...
or
make HOSTCC=clang CROSS_COMPILE=aarch64-linux-gnu- CC=clang O=build/ ...

First things first, I can't even build any of the Aarch32/ARM with clang 
for some reason, so this only applies for Aarch64 Rockchip platforms.

Some platforms couldn't be built due to hitting the max TPL limit (e.g. 
PX30).

clang version 21.1.8 (Fedora 21.1.8-4.fc43) (or clang version 22.1.1 
(Fedora 22.1.1-2.fc44), doesn't matter) issues three warnings:

1. Chromebooks EC fails to build:
In file included from 
/home/qschulz/work/upstream/u-boot/drivers/misc/cros_ec.c:21:
In file included from 
/home/qschulz/work/upstream/u-boot/include/cros_ec.h:12:
/home/qschulz/work/upstream/u-boot/include/ec_commands.h:3578:2: error: 
field  within 'struct ec_params_charge_state' is less aligned than 
'union ec_params_charge_state::(anonymous at 
/home/qschulz/work/upstream/u-boot/include/ec_commands.h:3578:2)' and is 
usually due to 'struct ec_params_charge_state' being packed, which can 
lead to unaligned accesses [-Werror,-Wunaligned-access]
  3578 |         union {
       |         ^

The following

diff --git a/include/ec_commands.h b/include/ec_commands.h
index 23597d28b2c..c5f9777c0c7 100644
--- a/include/ec_commands.h
+++ b/include/ec_commands.h
@@ -3575,7 +3575,7 @@ enum charge_state_params {

  struct __ec_todo_packed ec_params_charge_state {
  	uint8_t cmd;				/* enum charge_state_command */
-	union {
+	union __ec_todo_packed {
  		struct __ec_align1 {
  			/* no args */
  		} get_state;

seems to fix it. The upstream EC git repo 
(https://chromium.googlesource.com/chromiumos/platform/ec) has a commit 
with more changes, see 65da9cc08766 ("include/ec_commands.h: Fix 
unaligned access warnings"). It doesn't apply cleanly (and I haven't 
looked into other patches to backport for this to apply cleanly). I'm 
not sure what we're supposed to do here? I also don't have a Chromebook 
to test.

2. RK3528, RK3576 and RK3588 boards fail with (replace rk3528 in path 
for the other SoCs)

/home/qschulz/work/upstream/u-boot/arch/arm/mach-rockchip/rk3528/rk3528.c:98:45: 
error: value size does not match register size specified by the 
constraint and modifier [-Werror,-Wasm-operand-widths]
    98 |         asm volatile("msr cntfrq_el0, %0" : : "r" 
(CONFIG_COUNTER_FREQUENCY));
       |                                                    ^
include/generated/autoconf.h:372:34: note: expanded from macro 
'CONFIG_COUNTER_FREQUENCY'
   372 | #define CONFIG_COUNTER_FREQUENCY 24000000
       |                                  ^
/home/qschulz/work/upstream/u-boot/arch/arm/mach-rockchip/rk3528/rk3528.c:98:32: 
note: use constraint modifier "w"
    98 |         asm volatile("msr cntfrq_el0, %0" : : "r" 
(CONFIG_COUNTER_FREQUENCY));
       |                                       ^~
       |                                       %w0

Note that all Rockchip SoCs have CONFIG_COUNTER_FREQUENCY set to 24000000.

The cntfrq_el0 register is 64b 
(https://developer.arm.com/documentation/ddi0601/2026-03/AArch64-Registers/CNTFRQ-EL0--Counter-timer-Frequency-Register?lang=en), 
though the top 32b are reserved. Android decided to ignore this warning 
in the Little Kernel with 
https://android.googlesource.com/kernel/lk/+/923541d4c23565a47d020d84202a6f77d22fc149%5E%21/.

I tried to follow clang's recommendation and switch this to %w0 but it 
fails with:

/tmp/rk3588-a0a4b8.s: Assembler messages:
/tmp/rk3588-a0a4b8.s:87: Error: operand mismatch -- `msr cntfrq_el0,w9'
/tmp/rk3588-a0a4b8.s:87: Info:    did you mean this?
/tmp/rk3588-a0a4b8.s:87: Info:    	msr cntfrq_el0, x9
clang: error: assembler command failed with exit code 1 (use -v to see 
invocation)

I tried casting CONFIG_COUNTER_FREQUENCY into a u64 and it builds and no 
magic smoke when booting a board. Whether this is the proper fix, I 
don't know, but the warning is then gone. We could also decide to ignore 
the warning like for Android's Little Kernel (where and how much this is 
used is unclear as the repo isn't seeing much activity).

The register documentation indicates this is not used by the hardware at 
all, so even if it was broken, we probably wouldn't see a difference?

3. Boards building USB TCPM fail with

In file included from 
/home/qschulz/work/upstream/u-boot/drivers/usb/tcpm/tcpm-uclass.c:12:
In file included from 
/home/qschulz/work/upstream/u-boot/include/usb/tcpm.h:12:
/home/qschulz/work/upstream/u-boot/include/usb/pd.h:212:2: error: field 
within 'struct pd_message' is less aligned than 'union 
pd_message::(anonymous at 
/home/qschulz/work/upstream/u-boot/include/usb/pd.h:212:2)' and is 
usually due to 'struct pd_message' being packed, which can lead to 
unaligned accesses [-Werror,-Wunaligned-access]
   212 |         union {
       |         ^

This file is apparently adapted from upstream Linux, where the code is 
identical for that struct. So not sure what to do here.

Cheers,
Quentin
