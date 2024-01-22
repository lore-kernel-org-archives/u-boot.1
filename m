Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15894C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 10:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B53877CC;
	Mon, 22 Jan 2024 11:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="W8p5OjhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C08877F4; Mon, 22 Jan 2024 11:49:34 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30F58751B
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 11:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZEmHKF9j4C6xWJZ80MZY29kBwQoKPBtbAEJK64COIJiJExv6ym7AAkbcaT9nmV6xkun6PVE9e3yvLiQVWSZToTvZkBsSpPQfgk2egk5sVfZA3QWsI3/JRm9A4Ohsn40dlIUzA7i0hl+07gAsaLFcAPBtoaFVamTiZ7CyUinML1KIxGWPgph6/jIQ24y5NOQjoPM8M4zqmNC2ofRAghVB/p8YQ2fLYYwKpvVQxcNlpQhPa6SqzBrtMRdGko5J010/L/i92WJTFG7lQUbrruzlif1+iY+V9tFQMX7klWPeIQqXDwIWsWCUEXZS5UxUQpUPbD3ajpjjqdnPMusYvOp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u44b1pOw1j6WcF1cImd0ECfc7dRRNi6FwOEowaElBW8=;
 b=MUKBAFmscnNGF9njstgts/wDDpfPc5Txi3aAEK6ks4IKoCsorLhhSvsjLQT0vEve1tY62J577jQ+dJS7u70NX7RALX6WPWr2QjOhohE2tXLLJRIfEqEfLSLTOLWiRLkhZfh7UoMpZyKIUpTqi5Rnnkrkm5WVUuSQG4FMnlQxvLt3KXM6yTV0al9WgiEHLRHHtBn/dsJwSFE1SaBn8PiZyoLD1Ty++RlBFwx6T8fIuAKUoffop07eXpXH8ZWFPnAgmD2rfG1V+sTdr/KHjFYrfXPS2BkpWOzfaxGQ3Aq1FVnBjvZfeRwPgl+hF007dziSTKFTOEs1VDDCReKt/NKOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u44b1pOw1j6WcF1cImd0ECfc7dRRNi6FwOEowaElBW8=;
 b=W8p5OjhRH9YvPOs2zXenfxJXg3zEItFaskaHFhX3lDMQbZ/F9VTQqmEIm/FWe0nf/uW+Gs2ysqNm6iBCnDOt7FUsbcZX3N//YyCkWbeHyLuChyD5UXgxMDqExaXm7Z5wGNUffJhuY+lmb5nnJBQ5wIfLn5pg5yyRYgxlkuOG3AFc1+jjs+F+fRylUoxM92ne4Y/Y1ysArtkp6u4q16NTfQg2X3Fzpvg8PurdWji189TGcpIgT/ZIWOWlZIFKp5Hu2K9mZYMaqFuaFLqgZF92Vdsu5sbIKNTx/iQT29d06uZxMIfWY5Lb64uTtlsDPjFEEKZBDwi3K6iLufO3ok+aKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB7682.eurprd04.prod.outlook.com (2603:10a6:20b:2db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 10:49:25 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:49:25 +0000
Message-ID: <ff2cd476-e230-41e9-b9b9-bbf15f8fcfcd@theobroma-systems.com>
Date: Mon, 22 Jan 2024 11:49:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] rockchip: find U-boot proper boot device by
 inverting the logic that sets it
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, heiko@sntech.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se
References: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
 <20240117-rk3588-spl-boot-dev-v3-4-72cb989e6da8@theobroma-systems.com>
 <afc5d7e1-030b-48f4-b414-ab4a918debb9@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <afc5d7e1-030b-48f4-b414-ab4a918debb9@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: df0acb38-b2e7-42e7-314d-08dc1b37ccd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suqfELkxZfx/pWQikTlT7klQ+1yp5MYdQkAuQ9j4vlGo/gi+AP1PbYPZ3eYX5zTdIEF+SVHyI3Wviihv3Uq3J9ocdXlhwVs3nLvgFKZYaiJi3sViEHd4nWOyPjeNUrHYofUYdZvCodtctOmLAQIwtB0uc0itoknASjvytfCx8cGO8Z5YBPnTjRkk0f95qLemhl5TwC8zrDcoFYmzXxGTHYz2LVABvho0PWrGPWUODLB5T8GHcvt3tmsuYfC+dxRIxyXdm5HGkGqcgSCnTmGOG3F2InllO50LpMx7TYpsgdlCoukLOGxamCGgrDIj4dx+6Q7WUHntA+QIrSXpABC51vwBER9k7nS6lCQqILvLw5nA2ib5yyAehR+xre3VEIPU3sEsRkhgaMv5OU37lxjZh5en5RUAYsPgJKbNBnRyWrTrbK4HNowtp8u90pzMLW48st4YeFpyotOFt2ZNyYPa9UZl0c1WABeQeIm1pRtTo4ceiyG+ODbFdMcPm088JsmgMsigxsEwtkoZR/EbHDIbEvQ/DSNzpRwiaehJSYFFMLkUv1ZTc5HoZTgLZwSYWhNGw2n0JAAN3IWW4p7bx8wpHGPjfFrXEDBxc3DyN6PNB3ITzLNsSA8MLGTaQ+3zSKUO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39850400004)(396003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(6512007)(6506007)(2616005)(53546011)(5660300002)(83380400001)(2906002)(66556008)(8936002)(6486002)(966005)(66476007)(4326008)(8676002)(66946007)(478600001)(31696002)(316002)(110136005)(44832011)(86362001)(38100700002)(36756003)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5vVGpBeHRKMElXM1JyZEtNSXg0eWtlb0tYcDM3a2JhSGpEYjJqczg3THkv?=
 =?utf-8?B?QytyRFlNVUtySEZheWtTTzIzVVVIbU9uT2szUlp1VXZmT05iTkdQL1Y3MGpr?=
 =?utf-8?B?N3UxSVhkbjgzUjkxalNuSzJSNlZQZ0JSaHYwNlVCZ3p1MjNnM1hCMXZBVm1M?=
 =?utf-8?B?cmRlbGh6ek9LK28rRW95NllYOVBkTlJmMDVXeUV6SHhNWlE0QVJGZ0VpVzRD?=
 =?utf-8?B?N1RGUUIrRFZWSmx0VVBEMWhsd0J4d3paVWIrd0JWMHFzZ2V3clczWk5CajBB?=
 =?utf-8?B?RlI0dHdqR25DTEQ2SzB4RERrOXRORnhORm9RTWNVS3FCU0hBK2lZK3dGMkVK?=
 =?utf-8?B?OGNyTDI2QnkydkEweXl4K1pVc1dHQUlybTRiTzFRa2dNckZtVUVNclB5S1Jh?=
 =?utf-8?B?OGJXVE0wRmVsTVVaNGM0OVhqUFZVYUF2eCtXREdMKzVDeVhSMVJiMW9CbVI1?=
 =?utf-8?B?bHJRR21IaWFsYUg5aTNMa1J5cmdQL1VtdjY4Z0tNUDNEUWJCNGp1Y3Zsa3Bi?=
 =?utf-8?B?MW5JR0JGbUdQc1RMZnZ0TXd5WmN5NzFjL1ZTdnlXUDVuZXQ0ejE5NGgreWJF?=
 =?utf-8?B?UVlqN3VaNFJNUWU5VmFGMXUzUUtvb1VyTmVPOXpWeW9DNWpqcWViSWV5dk5v?=
 =?utf-8?B?WXdUNzRkWHltQ0pMa1ljakVjNkd5NldUdURRNkxBMGdRMTRHci9kL29ROSt1?=
 =?utf-8?B?bDVLVGZqQW82L0pMNVBCanQ2aWFsbUpPT3h1ekRha3RTUk43Y1NWWDhZQTNW?=
 =?utf-8?B?Q3EzS2hWdmdVaTNvbWN2V0w4VThVaGNXdlpHVjhIdWNlMjlYNDZ2bnZMZDQ1?=
 =?utf-8?B?V1FLODFKdWs4VitoaytscjdFQ1Jjb2wvRTRiQlkzMzNlV2JVc1crS25aNFhq?=
 =?utf-8?B?TTJrRWJGRFVmbk5lQ2U5alBPQzlzeFU4MXRNekM4VWlVbDllV2dpaWVURmhl?=
 =?utf-8?B?MWJ5ZUh4aGFSdHVKczdRZ1dhZUdoaEVNaEdISUxxTDhyTVlXdFZtUXI3d0NV?=
 =?utf-8?B?QzA2RmpQbG50eUJkL3V4NE5YNVJvcFBpTlBHS1AvRUMvOTdMK0JtTmtHK3FO?=
 =?utf-8?B?Z1JjaE8weVAvNFdCRHcyb2pES3FJZGpQaVlUMHVhUXl0ODAzZTR2ZVZ1K3hy?=
 =?utf-8?B?bVNhTTZjS0haWmU1aWxlM3ViY01HTlZsNmc0OGJpWEkvOVgxZU91SmRlRWpL?=
 =?utf-8?B?eXJhcERlcVpMaUJiK0JHRXczOENkWlY0Z0tLWVh5cGF0NEt5VXdNOEJQREFO?=
 =?utf-8?B?UHhmcE5yR242NUJLQnNzbE1MRjh1bzdyTE1vYkpLU3UrTU9NY01mOVowQ0tp?=
 =?utf-8?B?U1hSay96aFBueWw2eXIzd21FaGxhZ3FyLzE4Vkt1allyMTR3TW95bTNJZHNz?=
 =?utf-8?B?T0hwWlhQQ0Z1WHFDU29ibThvUWhWMDJ0MEMwTXdzT3Bva0dzRkZNYThxQUtD?=
 =?utf-8?B?RUl6cXI5QURQWmFOdVVKWVNCaTh5MXFNdDFDaGdCZGcwNTg1MnhDZXNBRnNT?=
 =?utf-8?B?RXFTc2dzclpBV1hEN1gwWU1sOS9iQjM4Ui9GUjBJVFFSaFFsTzRKbEF2VXNH?=
 =?utf-8?B?UFlCNi9VNE9zbTVZNXlnNDhBN3JGWGszYnMydU1BYkhlODdLRHM3UTc5SWhy?=
 =?utf-8?B?L251K0V3cFNvZmQ0ZEljVVhZSE1Ra283aW9sVDA5WlE4YmtHTXg2WVVHem5r?=
 =?utf-8?B?eW85TFVlWUF0a3dSRWNsb3RaVXlGL1FkKzF2NUdwSG1LVGl1WUZsc3BUVmJG?=
 =?utf-8?B?VVp1OHBnc2dqbmFBZm9NKzFnZWtJWDMvMVZsNmJyVkdPTVFwTVBMMFl0d3o4?=
 =?utf-8?B?STk4aTFiY092MlB0NCtaREhuV2s2dUVYQitmL3Uzd3lmVWFJNnI4dC9KUHVB?=
 =?utf-8?B?TFFRdWpPNjhlRnlBb3RFY1NzVmxNNXc0OU1ldDhOZTMxRWZXRGFUUjhpMms2?=
 =?utf-8?B?NUJSeHVtOW1VU2VtcFpsaDVuRjVob0hDWnBBbldZRmp1SnV1TWNhVndzTkRX?=
 =?utf-8?B?a0tsamFNTUh4WHQ5V215VG5KWUNvS3lxRldBTFNURjJpTnkvVDdjT0Zmd3Nn?=
 =?utf-8?B?VmN0R1VIcThtcFlIV2lka2dTcXRGeDJGT1hpK3dpejFZaHY3MnQvUk1nSStX?=
 =?utf-8?B?eEQ0dE1Lc3pRL09oeUI2bUM4cEREOXgrY05xZWV2eXE0TGJCVDEwaGs5RHYv?=
 =?utf-8?Q?YBrJ+kjQZCWWO07CNUJSSIo=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0acb38-b2e7-42e7-314d-08dc1b37ccd3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 10:49:25.4660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: im5bViZrYDK61h0+eYga2If+zmWDDT9EVlP7tuIOxzmHKDpAcUNk501BWF4XrOJ8cfsKKl2oMIFJvkMEkR4LFQ0AlaKsm3WJd/bjdt9d0XWtDucDmVMGMqmeYeebJTHM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7682
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

Hi Kever,

On 1/18/24 11:12, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/18 01:22, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> BOOT_DEVICE_* is set by spl_node_to_boot_device() depending on the block
>> device number associated with the MMC device the SPL used to load U-Boot
>> proper from. It is NOT related to the mmc alias in the Device Tree.
>>
>> For SPI flashes, all SPI flashes will return BOOT_DEVICE_SPI so there's
>> currently no way to know from which one the SPL loaded U-Boot proper
>> from. Therefore, let's just find the first valid candidate in
>> /chosen/u-boot,spl-boot-order that is a SPI flash and return that path.
>> This is a best effort.
>>
>> While the original implementation may have worked, using the exact same
>> mechanism but in inverted fashion makes it less likely to have
>> surprising corner-cases or side-effects.
>>
>> A nice side-effect is that all existing and future Rockchip SoCs now
>> automatically have their /chosen/u-boot,spl-boot-device set.
> 
> Error happen in some 32bit SoC:
> 
> +arch/arm/mach-rockchip/spl-boot-order.c: In function 'spl_perform_fixups':
> +arch/arm/mach-rockchip/spl-boot-order.c:242:31: error: 'struct 
> spl_image_info' has no member named 'fdt_addr'
> +  242 |         void *blob = spl_image->fdt_addr;
> +      |                               ^~
> +make[3]: *** [scripts/Makefile.build:257: 
> spl/arch/arm/mach-rockchip/spl-boot-order.o] Error 1
> 
> 

It'd be nice to say **which** boards aren't working so that I can 
reproduce locally :)

I eventually figured we have GitLab CI/CD for your maintainer 
branch/repo here: 
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines. 
This also helped me figure out this wasn't the only build failure and I 
could send another patch before you had the opportunity to tell me I had 
broken something else :)

Giving the link of the failed pipeline would really help, please think 
about it for next time :) Thanks!

For people interested in build-testing all Rockchip platforms locally, I 
used the following script:

"""
#!/bin/sh

# Copy **some** TF-A binary in the parent directory of U-Boot git repo
export BL31=../bl31.elf
dd if=/dev/zero of=../zero.bin count=1
export ROCKCHIP_TPL=../zero.bin

for conf in $(git grep --files-with-matches ARCH_ROCKCHIP configs); do
         git clean -ffdx > /dev/null
	echo -n $conf=
         make $(basename "$conf") > /dev/null
	if grep -q -E "^CONFIG_ARM64=y" .config; then
		CROSS_COMPILE="aarch64-linux-gnu-"
		export TEE=
	else
		CROSS_COMPILE="arm-linux-gnu-"
		export TEE=../zero.bin
	fi
	LOG=$(mktemp)
	make KCFLAGS=-Werror CROSS_COMPILE="ccache $CROSS_COMPILE" -j$(nproc) > 
"$LOG" 2>&1
	RET=$?
	echo $RET
	if [ "$RET" != 0 ]; then
		cat "$LOG"
		exit $RET
	fi
done

exit 0
"""

Cheers,
Quentin
