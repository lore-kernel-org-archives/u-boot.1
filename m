Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C664C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 05:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1832832EB;
	Thu, 17 Jul 2025 07:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69779832DA; Thu, 17 Jul 2025 07:12:22 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30628832BF
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 56H5B2as095416
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 17 Jul 2025 13:11:02 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 13:11:02 +0800
Date: Thu, 17 Jul 2025 13:10:58 +0800
From: Leo Liang <ycliang@andestech.com>
To: Tom Rini <trini@konsulko.com>
CC: E Shattow <e@freeshell.de>, Michal Simek <michal.simek@amd.com>, "Martin
 Herren" <sputnik@on-the-web.ch>, <u-boot@lists.denx.de>, Andreas Schwab
 <schwab@suse.de>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>, "Chia-Wei, Wang"
 <chiawei_wang@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Green Wan <green.wan@sifive.com>,
 "Hal Feng" <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Maksim Kiselev
 <bigunclemax@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Minda Chen <minda.chen@starfivetech.com>,
 "Padmarao Begari" <padmarao.begari@amd.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, "Paul Walmsley" <paul.walmsley@sifive.com>, Peter
 Robinson <pbrobinson@gmail.com>, Rick Chen <rick@andestech.com>, Sean
 Anderson <seanga2@gmail.com>, "Simon Glass" <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>,
 "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>,
 Wei Fu <wefu@redhat.com>, Yao Zi <ziyao@disroot.org>, Yixun Lan
 <dlan@gentoo.org>, Yuri Zaporozhets <yuriz@vodafonemail.de>
Subject: Re: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly
 used value.
Message-ID: <aHiF4hl5ochHoWGT@swlinux02>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
 <9529db2f-ff07-448e-99b4-65dde605b0ec@amd.com>
 <b3f95ac9-a847-450b-9d5a-64af5e84a47e@freeshell.de>
 <20250716170015.GI193579@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716170015.GI193579@bill-the-cat>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 56H5B2as095416
X-Mailman-Approved-At: Thu, 17 Jul 2025 07:25:12 +0200
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

On Wed, Jul 16, 2025 at 11:00:15AM -0600, Tom Rini wrote:
> [EXTERNAL MAIL]

> Date: Wed, 16 Jul 2025 11:00:15 -0600
> From: Tom Rini <trini@konsulko.com>
> To: E Shattow <e@freeshell.de>
> Cc: Michal Simek <michal.simek@amd.com>, Martin Herren
>  <sputnik@on-the-web.ch>, u-boot@lists.denx.de, Andreas Schwab
>  <schwab@suse.de>, Anup Patel <anup@brainfault.org>, Atish Patra
>  <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>, "Chia-Wei, Wang"
>  <chiawei_wang@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>,
>  Cyril Jean <cyril.jean@microchip.com>, Green Wan <green.wan@sifive.com>,
>  Hal Feng <hal.feng@starfivetech.com>, Heinrich Schuchardt
>  <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
>  Jerome Forissier <jerome.forissier@linaro.org>, Junhui Liu
>  <junhui.liu@pigmoral.tech>, Kongyang Liu <seashell11234455@gmail.com>, Leo
>  Yu-Chi Liang <ycliang@andestech.com>, Maksim Kiselev
>  <bigunclemax@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
>  Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
>  <mkorpershoek@kernel.org>, Minda Chen <minda.chen@starfivetech.com>,
>  Padmarao Begari <padmarao.begari@amd.com>, Palmer Dabbelt
>  <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter
>  Robinson <pbrobinson@gmail.com>, Rick Chen <rick@andestech.com>, Sean
>  Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
>  <sumit.garg@kernel.org>, Thomas Bonnefille
>  <thomas.bonnefille@bootlin.com>, Wei Fu <wefu@redhat.com>, Yao Zi
>  <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>, Yuri Zaporozhets
>  <yuriz@vodafonemail.de>
> Subject: Re: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly
>  used value.
> 
> On Tue, Jul 15, 2025 at 06:35:17PM -0700, E Shattow wrote:
> > 
> > 
> > On 7/15/25 04:27, Michal Simek wrote:
> > > 
> > > 
> > > On 7/14/25 15:33, Martin Herren wrote:
> > >>
> > >> The most commonly used SYS_BOOTM_LEN for riscv is 0x4000000 which is
> > >> used in 25 of the current defconfigs.
> > >>
> > >> The previous default config value of 0x800000 was only used in 8
> > >> defconfigs.
> > >>
> > >> This patch sets the default to this value.
> > >>
> > >> Command used to get the stats of the used values on RISCV defconfigs:
> > >>
> > >> ```
> > >> grep -l "CONFIG_RISCV=y" configs/* | \
> > >>   xargs -I {} sh -c "grep -H CONFIG_SYS_BOOTM_LEN {} || echo
> > >> {}:DEFAULT" | \
> > >>   cut -d ':' -f 2 | sort | uniq -c
> > >> ```
> > >>
> > >> Changes in v2:
> > >> - Resubmit using another mail provider to prevent mangling and signature
> > >>    attachement.
> > >>
> > >> Martin Herren (3):
> > >>    riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
> > >>    riscv: Set SYS_BOOTM_LEN default to 0x4000000
> > >>    riscv: Remove default SYS_BOOTM_LEN from defconfig
> > >>
> > >>   boot/Kconfig                            | 2 +-
> > >>   configs/ae350_rv32_defconfig            | 1 -
> > >>   configs/ae350_rv32_falcon_defconfig     | 1 -
> > >>   configs/ae350_rv32_falcon_xip_defconfig | 1 -
> > >>   configs/ae350_rv32_spl_defconfig        | 1 -
> > >>   configs/ae350_rv32_spl_xip_defconfig    | 1 -
> > >>   configs/ae350_rv32_xip_defconfig        | 1 -
> > >>   configs/ae350_rv64_defconfig            | 1 -
> > >>   configs/ae350_rv64_falcon_defconfig     | 1 -
> > >>   configs/ae350_rv64_falcon_xip_defconfig | 1 -
> > >>   configs/ae350_rv64_spl_defconfig        | 1 -
> > >>   configs/ae350_rv64_spl_xip_defconfig    | 1 -
> > >>   configs/ae350_rv64_xip_defconfig        | 1 -
> > >>   configs/ibex-ast2700_defconfig          | 1 -
> > >>   configs/k230_canmv_defconfig            | 1 +
> > >>   configs/microchip_mpfs_icicle_defconfig | 1 +
> > >>   configs/milkv_duo_defconfig             | 1 -
> > >>   configs/qemu-riscv32_defconfig          | 1 -
> > >>   configs/qemu-riscv32_smode_defconfig    | 1 -
> > >>   configs/qemu-riscv32_spl_defconfig      | 1 -
> > >>   configs/qemu-riscv64_defconfig          | 1 -
> > >>   configs/qemu-riscv64_smode_defconfig    | 1 -
> > >>   configs/qemu-riscv64_spl_defconfig      | 1 -
> > >>   configs/sifive_unleashed_defconfig      | 1 -
> > >>   configs/sifive_unmatched_defconfig      | 1 -
> > >>   configs/sipeed_licheerv_nano_defconfig  | 1 -
> > >>   configs/sipeed_maix_bitm_defconfig      | 1 +
> > >>   configs/sipeed_maix_smode_defconfig     | 1 +
> > >>   configs/starfive_visionfive2_defconfig  | 1 -
> > >>   configs/th1520_lpi4a_defconfig          | 1 -
> > >>   configs/xilinx_mbv32_defconfig          | 1 +
> > >>   configs/xilinx_mbv32_smode_defconfig    | 1 +
> > >>   configs/xilinx_mbv64_defconfig          | 1 +
> > >>   configs/xilinx_mbv64_smode_defconfig    | 1 +
> > >>   34 files changed, 9 insertions(+), 26 deletions(-)
> > >>
> > > 
> > > I don't mind with these changes. It is just value which can be changed.
> > > 
> > > Acked-by; Michal Simek <michal.simek@amd.com> # xilinx_mbv
> > > 
> > > Thanks
> > > Michal
> > > 
> > > 
> > 
> > Is there some reason for the value from documentation about the
> > architecture? Or is it arbitrary?
> > 
> > I don't really see the sense in a default value which is simply popular
> > but not founded in an architectural reasoning.
> > 
> > The values do not change often (ever?) so I miss why there is any
> > default at all.
> 
> So, the default for SYS_BOOTM_LEN isn't so much arbitrary as just no
> longer reflective of modern times. It's why there's larger defaults for
> ARM64 for example. Likely RISCV should just also use that as the default
> and platforms with very small amounts of RAM should stick with smaller.
> 
> -- 
> Tom

Hi Martin,

These changes seem reasonable, and I'm fine with them.
If you send a v2 PR incorporating Conor's comment on the first patch,
you may add my Reviewed-by tag.

Best regards,
Leo
