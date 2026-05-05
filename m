Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32427CD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 11:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F968489F;
	Tue,  5 May 2026 13:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="corygbaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D24848A7; Tue,  5 May 2026 13:58:33 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6649B8488B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 13:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiscUsTZyCLlp6LfsTACWPjP1Dt/PxrV+HTEGQw84BWwy2gpSbgVEG6G1e7Ql7/cWMqu8vUb0zheqwX0/Fy362BL+PPQOXkv9Ri0jjjiTy+FiLa4/vRnwUyTYzDgxKwHk4liUnB/VLDVEJfPc+4D7jeoY/RSBa2kjlw56ECoHcrS1Rk1rTTw/t/Sm31ZizUlJGhfl0dMuXIxAcE9fh1mkXLcNCihOHJGxnghBp9tab9HsKMYm7Cl6Ii0qn1FDTlUyur2OnC3IFxjPx+kfPnJ/FndHmPyO4Q4g2SlIfQ7yBBjq/73lZy10WMp9AtqnzC4CxHNM2JWSkDaDHpNQ1YF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udktcNzY5mADWyj9ixgKmnil1fAcL4An88WCBTjrhjY=;
 b=IPo+Bhb+XuS8OwT0MQMnwS5gc8wYX0dzM8WTTvUNq3vkrKn0+BFw19xjeAWetn5BUldNSqBBuUopCtDPibO0qP4zS1h77QrcR1IEWqvSsFQTPOsc4P6OUaGLUpkT1oVa3oR9LrEyp55KHgz4S/8SoNZRh9uMUz/HtsttaLBST/77hoTXyPxQwzGNMGRjOS/gcap3xtw2Lz4E2RuWjp+vClSsKNSAcKGeMzgd8ocrXIa+42NRYiFxXb/1poE5u/n60UZedlGG/YfHBUL9DJ8MPgrAwSHgOvwrlBkA1puOjb++S6VpqCLcAsu6+2i911aHi2wSz33XbtYj8Mb1uwTHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udktcNzY5mADWyj9ixgKmnil1fAcL4An88WCBTjrhjY=;
 b=corygbaW2qxJCOfbQyOjU5RPgnriyoC4EK67noWww7DpyLYWTxm+WK7aOiVQVMA5k29OzJohRuidPrJx5q+QMwpmTwiwDBj3RAFLX1C8i6NjCZ2DaT3vVXmaRbFn6rhxpbDVBnEimWOObOgFrIMFjfWvFWVDLnKm413s9Vnw5zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB8249.eurprd04.prod.outlook.com (2603:10a6:10:25c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:58:28 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 11:58:28 +0000
Message-ID: <af74c5ed-a3a0-4f2d-a261-269e31882711@cherry.de>
Date: Tue, 5 May 2026 13:58:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC next 00/18] sync scripts/Makefile.extrawarn with 6.1, 
 enable WERROR for host tools
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504180429.GJ1614990@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260504180429.GJ1614990@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b4ff6d-bc62-428f-c6e9-08deaa9d9ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JIV6a8xt0/IFCRZ+vJvSdw3VFBW8k9Ktz7wV9m/LKTcbhm0lQTTP90FXXkfelTuwXkow0edeqeCjMHAju2FKst5bh7c6uvNaz7/gdRVUU3JTkomvxzWz6KGTJ71DXcdSKSjNXM9iJ47ZgeF+ebsmzhhialP87PZ0VxsohS3nGj8rTQBsPGPlcPtiKTT75gwtusalHOnN/J7Zl9SXEFGejeQbGI9R5J2k+cDHryK3vqWMNbUUfZVBXm0eLi2u1SUPNqnPFXDYzCIDJif4yTjgPYwT2cnrv4oTJkBUxf7isLThhvZAkipkPxqdZD5KWSzfTut1EPTz2PlPN3mpRgwuenY0ZSpz25scCQ/cAm2gyUnKK8yw3mFxurVNvSVaa6/dMzFVUNEr58eaE65bMeKzpgahd+o2jtaNw69pVx7cynwto5RwAhusiV+WkzyR3kvMr0UpZhbCe0PSeZKL1wD7OOzjRdxH/qOiIDf4jSAW7ZDJ5RToQbxnIa38WPr3wSkhnJeHENKdOK/YslfY7dR9jUESxUn6Dr6usRgZgZ8oQuvE7E092/KAtc0Ea9XZ0fwIF2NYwkQT5AWx3J/1jrV0kHHXsbTREETVzGmuPmecdTWgd3yAPuO7DJw9dsG+lB4Nz/OZJEPDAq9h2yIq0WYWuPLCNqWvyLjcYiEQNeHWuRxrcESCiKKSR6ZRAKI995/6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K05xRE90ODhNWmJoaHdVM0tjV0M3d3kva25mSHFSQVA5aVFMSUVWY2Y0TWgr?=
 =?utf-8?B?RVkwd05MU3gxM0J5RHJFTGFrSm9LUVRaaTRVczYyMTRXMk4venorODZTeHFM?=
 =?utf-8?B?dTFuVDhpUkFNMkJwc09LSHpvN05Od1luOEpyaHcycWNHYWs3N0hzc1VZQ2RW?=
 =?utf-8?B?RnpEZnkwelJkdjhTQ3hpUVZZeCtVck9aMlZvdDJjRWF1ZTdWekVnK2tocnpH?=
 =?utf-8?B?cUw5MHAvNEluR0Ywb29FZ2JiMW8xTmFSTlVFT0RZUWdsc09hQUlJK0hoK2ho?=
 =?utf-8?B?Z3czS3JsSjVrd1BZRjRjWWpJNUZiNU0rbE5sMStOeUZiZUdCRk8zWlQ2WlUz?=
 =?utf-8?B?QzlhalZRNEp5VEl3S1o5ME9Cd1Y4QXdjV1liMXNOcDl0cFNqVHNuU1orTW5H?=
 =?utf-8?B?bVZ4Rk02bG83MHBKN1RLQll6QjBhME40S29UZC9BMFNFam5OalZnY05abENm?=
 =?utf-8?B?Y1Y2N2Exbk9WdGwyWDlLQnorUXA2c2hheDdnaGo1b2xkalQ5TDRTMWJXMnhS?=
 =?utf-8?B?UFRXME96ZjVGNDU1KzErWGFLMjZzdUI5VWk5U3kvZ2YxbmRVQjNSUHJvcEdw?=
 =?utf-8?B?S3dqdUh4ZysxeUR1R1pWc3NmQUpMazJDUEhPZEF2T0hBU28zRmh1YXhwM213?=
 =?utf-8?B?d1g2Ni8xUFNpQUJmZ2pJVVFsY2lLMlZ2c2dzZVNOeTkyTUU1Ynp3emFCam1E?=
 =?utf-8?B?RTB5M3NmdjJHNXY3R0VrZ0V1RFdGTHZaNEdwR09GdmsvZ0UvNmxiNHBCUXVj?=
 =?utf-8?B?cUJtOW91cVB6R3pKb08rTnFnb0dNb1dXQWZGSmVxY1JwUFhzc25yUzdkYzYx?=
 =?utf-8?B?QVRHUzVRV1lScG5NOUZ2L211VDdqeFFwbWxsVm8vMUxrSnJLWDV5ZGUrdHUv?=
 =?utf-8?B?ODhsS09CQ3JWcmVsV0FpdWM5eWZPTmRzYmNHSzVaazFyTnJZTnRmaEY0T3RP?=
 =?utf-8?B?S2tKcit2dEFDVW94ZEVJMWZmSys0M0FLQU1BOUh0QWhMQVYyMjZIVWkyQm9w?=
 =?utf-8?B?SmZlcnZZUzFNaTBiUWJ3b0g2U0FQKzExVzFDYllrOVdMYlhYTlJ6TTBLWVda?=
 =?utf-8?B?eS9rNURqTlhMaXB0UUVUL1ZnS3ZMWkxkR0dCUXo4a0o5NTN0MHd1aVptSng4?=
 =?utf-8?B?TldqTEsxalI5NkVhVUtoTDJvMFV2ZURraDdOaEVMQlZiN200SGZmV014b3dV?=
 =?utf-8?B?TkxWY3p3dmV5YnhyOGJVWUJ4ZjVTaXR1Rk9yRVZsS0Vra1A5NCt1c2lqc2Uz?=
 =?utf-8?B?cFZ3cXZ5anlrWG85RXRUWHY3ck44NVkyMzd0VmVCLzlMd05wQmtNWlZiUXBC?=
 =?utf-8?B?b3MvTnMvL0FNSmdGWUNaQVU2SXJiVFNRUmJFWkZzZkZEWWpoYmtTcUxWY0xE?=
 =?utf-8?B?aWpxSVFGYTZ6bFY2Ny9YUmR6eTQwb0hISkl2cDdTNzZ0N0pjT0N0YlVLN2cr?=
 =?utf-8?B?Uy9EK0FJdlVMS21ZUnc4cU15aCtaWWVGZi9Dd2taMkhUNmJhTFdLT2VtNHNm?=
 =?utf-8?B?OWRIOFZQWUZ6R3dvOUs0bnFDSzd0ZS9sSG8rNmhEMEN6KzRCQkRGbVROR2Vh?=
 =?utf-8?B?aHBuV3U3azNjUmdKTWFPS0I2LzNVWmtIcnlHMmZkaVh5MEowREhBVnJ2ckVV?=
 =?utf-8?B?RnFpejhOaWxLbUhoYUNDc1VIK2lqL2FHRmVYRnhodGNseTlsekN4eGhBWk8y?=
 =?utf-8?B?Wm9HbFVFb0J3dUdvMTFBK2tYZ3QxSWxCb1B3ZHMxSTFldDRueU1CdzdzR2g0?=
 =?utf-8?B?ckxtMFE5dXRWaGFXMFZWdmxCZWx0Z2tyYTNFTWQyUmxYRHYwN1ZMZnlGQms3?=
 =?utf-8?B?eGo4NEVPajN4S1liWmRkbGtmTkNrTXNLZW9uWDcvQVduV2NpV0R6WFRoN2F6?=
 =?utf-8?B?aGtNcWlsOW9aOVZGK09RVGYxVEs2VTEvYldRK25FLzFzc0pTYmlETnBxOU0w?=
 =?utf-8?B?TDZ1cjFqanBHaGFLeElsV28zNTN2dDl3OTR3eW80WDRTNVJ1d1hSTC9BZzdC?=
 =?utf-8?B?a1N6SmtBclNQVStSa2FDWmluY0laWTRNbnNoaTV2MXdObEFObGJ3bTdIVmk5?=
 =?utf-8?B?WGpRc3cwdTZsZjU1L0ZBVG9qbWRrVnR1UzFwVXF0WGxyUnhTaUVRRFJBdFVj?=
 =?utf-8?B?NE9XamtrSDZ4cUZVNGFYc0dIQ2szQUE5dkVmbEcyaHI1QTh2UUNaSHY2ckQx?=
 =?utf-8?B?TGhlNlo4eXRNVndKbGJFQkZqbXBCeWtyaTdTTTRRYlFvWEpGNS90bkJKcEFG?=
 =?utf-8?B?TFowR2RMdFpSY0d3cWcycDNTeDVaN25Kb1BlS1N6WXRLWTlCMVZkcVVUdGhC?=
 =?utf-8?B?bFB4ejJab3pBVm92MjE2V3IvVFQ4Y1dYcUR5SU5VOENoM0xvYm1TUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b4ff6d-bc62-428f-c6e9-08deaa9d9ea9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:58:28.2769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LNlJ6tF0sDZyAnI9R7XZBF/qpeMMsbQIK5zOWzCXcxvbktBN8uHy5SxxBO/tvWsSxGnWQsK/nr/5/r3gl+pGq8tKVZB+xkXpnfWLjGH4Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8249
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

Hi Tom,

On 5/4/26 8:04 PM, Tom Rini wrote:
> On Mon, May 04, 2026 at 03:20:27PM +0200, Quentin Schulz wrote:
[...]
>> The first two patches are for fixing pytest calling make directly on a
>> "dirty" build directory as generated by buildman using the clang-20
>> toolchain, but pytest does not set HOSTCC and CC to clang-20, resulting
>> in clang flags being used with gcc).
>>
>> One can simply reproduce it (after backporting up to patch
>> "scripts/Makefile.extrawarn: sync with 6.1") by doing so in the
>> container:
>>
>> make HOSTCC=clang-20 CC=clang-20 O=build/sandbox sandbox_defconfig
>> make HOSTCC=clang-20 CC=clang-20 O=build/sandbox -j`nproc
>> make O=build/sandbox u-boot-initial-env
>>
>> It'll print:
>> gcc: error: unrecognized command-line option '-mno-global-merge'
>> gcc: error: unrecognized command-line option '-Wformat-invalid-specifier'
>> gcc: error: unrecognized command-line option '-Qunused-arguments'
>>
>> This is essentially what's run within test_env_initial_env_file in
>> test/py/tests/test_env.py.
>>
>> While I'm not unhappy with the patches to pytest, it feels to me we may
>> be missing something else for the u-boot-initial-env make target to
>> update the kconfig symbol based on the toolchain being used when called.
> 
> Is there some other target in the Makefile that should catch this kind
> of change? It's not just that build target that needs to be remade, it's
> everything, yes?
> 

For the reproducer, one actually needs to do

diff --git a/Makefile b/Makefile
index bd33437fdfd..9079131f81e 100644
--- a/Makefile
+++ b/Makefile
@@ -1007,15 +1007,15 @@ KBUILD_CFLAGS += $(call 
cc-option,-Wno-format-nonliteral)
  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)

  ifdef CONFIG_CC_IS_CLANG
-KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
-KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
-KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
+KBUILD_CPPFLAGS += -Qunused-arguments
+KBUILD_CFLAGS += -Wno-format-invalid-specifier
+KBUILD_CFLAGS += -Wno-gnu
  # Quiet clang warning: comparison of unsigned expression < 0 is always 
false
-KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
+KBUILD_CFLAGS += -Wno-tautological-compare
  # CLANG uses a _MergedGlobals as optimization, but this breaks 
modpost, as the
  # source of a reference will be _MergedGlobals and not on of the 
whitelisted names.
  # See modpost pattern 2
-KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
+KBUILD_CFLAGS += -mno-global-merge
  else

  # These warnings generated too much noise in a regular build.

Which is what's being done since kernel commit a1494304346a ("kbuild: 
add all Clang-specific flags unconditionally"). I actually had this in 
an earlier version of this patch series and forgot I removed it.

This seems to apply to envtools and tools-only as well, though make 
prompts me for the desired state of symbols that are now reachable, e.g. 
ARM64_CRC32. And if I rerun the same command, then it works. It seems 
like the config from the previous run is used? I don't know if it's 
related but those two commands call make directly ($(Q)$(MAKE) 
$(build)=<path>). Do you have something in mind maybe? Or some more 
commands to run?

Cheers,
Quentin
