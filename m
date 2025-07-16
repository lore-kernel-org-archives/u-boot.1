Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94B8C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 04:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6384983106;
	Wed, 16 Jul 2025 06:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE3C83123; Wed, 16 Jul 2025 03:35:30 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E16830C8
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 03:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.71]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BD418B4D172C;
 Wed, 16 Jul 2025 03:35:18 +0200 (CEST)
Message-ID: <b3f95ac9-a847-450b-9d5a-64af5e84a47e@freeshell.de>
Date: Tue, 15 Jul 2025 18:35:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly
 used value.
To: Michal Simek <michal.simek@amd.com>, Martin Herren
 <sputnik@on-the-web.ch>, u-boot@lists.denx.de
Cc: Andreas Schwab <schwab@suse.de>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Green Wan <green.wan@sifive.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rick Chen <rick@andestech.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
 <9529db2f-ff07-448e-99b4-65dde605b0ec@amd.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <9529db2f-ff07-448e-99b4-65dde605b0ec@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Jul 2025 06:35:01 +0200
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



On 7/15/25 04:27, Michal Simek wrote:
> 
> 
> On 7/14/25 15:33, Martin Herren wrote:
>>
>> The most commonly used SYS_BOOTM_LEN for riscv is 0x4000000 which is
>> used in 25 of the current defconfigs.
>>
>> The previous default config value of 0x800000 was only used in 8
>> defconfigs.
>>
>> This patch sets the default to this value.
>>
>> Command used to get the stats of the used values on RISCV defconfigs:
>>
>> ```
>> grep -l "CONFIG_RISCV=y" configs/* | \
>>   xargs -I {} sh -c "grep -H CONFIG_SYS_BOOTM_LEN {} || echo
>> {}:DEFAULT" | \
>>   cut -d ':' -f 2 | sort | uniq -c
>> ```
>>
>> Changes in v2:
>> - Resubmit using another mail provider to prevent mangling and signature
>>    attachement.
>>
>> Martin Herren (3):
>>    riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
>>    riscv: Set SYS_BOOTM_LEN default to 0x4000000
>>    riscv: Remove default SYS_BOOTM_LEN from defconfig
>>
>>   boot/Kconfig                            | 2 +-
>>   configs/ae350_rv32_defconfig            | 1 -
>>   configs/ae350_rv32_falcon_defconfig     | 1 -
>>   configs/ae350_rv32_falcon_xip_defconfig | 1 -
>>   configs/ae350_rv32_spl_defconfig        | 1 -
>>   configs/ae350_rv32_spl_xip_defconfig    | 1 -
>>   configs/ae350_rv32_xip_defconfig        | 1 -
>>   configs/ae350_rv64_defconfig            | 1 -
>>   configs/ae350_rv64_falcon_defconfig     | 1 -
>>   configs/ae350_rv64_falcon_xip_defconfig | 1 -
>>   configs/ae350_rv64_spl_defconfig        | 1 -
>>   configs/ae350_rv64_spl_xip_defconfig    | 1 -
>>   configs/ae350_rv64_xip_defconfig        | 1 -
>>   configs/ibex-ast2700_defconfig          | 1 -
>>   configs/k230_canmv_defconfig            | 1 +
>>   configs/microchip_mpfs_icicle_defconfig | 1 +
>>   configs/milkv_duo_defconfig             | 1 -
>>   configs/qemu-riscv32_defconfig          | 1 -
>>   configs/qemu-riscv32_smode_defconfig    | 1 -
>>   configs/qemu-riscv32_spl_defconfig      | 1 -
>>   configs/qemu-riscv64_defconfig          | 1 -
>>   configs/qemu-riscv64_smode_defconfig    | 1 -
>>   configs/qemu-riscv64_spl_defconfig      | 1 -
>>   configs/sifive_unleashed_defconfig      | 1 -
>>   configs/sifive_unmatched_defconfig      | 1 -
>>   configs/sipeed_licheerv_nano_defconfig  | 1 -
>>   configs/sipeed_maix_bitm_defconfig      | 1 +
>>   configs/sipeed_maix_smode_defconfig     | 1 +
>>   configs/starfive_visionfive2_defconfig  | 1 -
>>   configs/th1520_lpi4a_defconfig          | 1 -
>>   configs/xilinx_mbv32_defconfig          | 1 +
>>   configs/xilinx_mbv32_smode_defconfig    | 1 +
>>   configs/xilinx_mbv64_defconfig          | 1 +
>>   configs/xilinx_mbv64_smode_defconfig    | 1 +
>>   34 files changed, 9 insertions(+), 26 deletions(-)
>>
> 
> I don't mind with these changes. It is just value which can be changed.
> 
> Acked-by; Michal Simek <michal.simek@amd.com> # xilinx_mbv
> 
> Thanks
> Michal
> 
> 

Is there some reason for the value from documentation about the
architecture? Or is it arbitrary?

I don't really see the sense in a default value which is simply popular
but not founded in an architectural reasoning.

The values do not change often (ever?) so I miss why there is any
default at all.

-E
