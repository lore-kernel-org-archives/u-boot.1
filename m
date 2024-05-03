Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3B7C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 04:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8262D88B07;
	Fri,  3 May 2024 06:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714710880;
	bh=cG3z+I2pPvU/hnnfuGduc5l1Gk4v89PP6Y8sn/iwqsA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=JPodAfMbeAjO4ccXnUWuLj2wbQVHz7ynb8XeWitXMUpHAmWEQ8M8WsNtfP+5PJYh+
	 nRD48D+sVhADspasPQF3MvifGFGrz3Px6ztonxstmKJ1WquiaAijJM6kk0Gfab8NaD
	 X5GrWAhc59fukXH0oMiKuHB4Svt/pkmqDWh8Az3tPGhIVuKh9q36RAQ0CWJsfCYiJn
	 pheCWWBPJTPi18VZ2HLShDze9ftjIiVuLxIcyrRMgngtewUpBvnQsYocP0yoL+PG7n
	 alvwJAn2Em/lpAWes5lJpCXhzVfNsFjIaFik3zZfcM/rADouKgZM+X8Fr77ZMSGX4t
	 LZY55uF2XoRWQ==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7AA5C88A92;
 Fri,  3 May 2024 06:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714708811;
 bh=cG3z+I2pPvU/hnnfuGduc5l1Gk4v89PP6Y8sn/iwqsA=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=WTprEnj6evnnSQmGrsDFiPnvoz/WnfPaFtnNsefLeA0JEMWRHUvN+z3dZr4nz8lZN
 V7LPv3QNAS/7N2l4J337Kj2cNL1DK2XTpIvcjq6yxzYM0c811dwjXYJqcsxIuD2F9R
 424NDHcADcHo8LN9+tyrguWQOHOz0S4SmHJRa5Cd941QOpeTj/aXQ0TqFTwytfDD6r
 JX8ffdyLFLYaz1G9p5uGA0cAFOtpqxgJaViMR2YIFXIOrTjgO4ScW9d3jYoyU78u1C
 wJRCztk6YR7Fjp7Wrttj/Qa+q25eeGJC6136+ajaihaZCb61szDltmvsvgh8uKpOFf
 r6jC3E8ycawiQ==
Message-ID: <cebb1079-6662-e064-ad84-63d92213610f@denx.de>
Date: Fri, 3 May 2024 05:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 48/81] pci: Remove <common.h> and add needed includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Mark Kettenis <kettenis@openbsd.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 liuhao <liuhao@phytium.com.cn>, shuyiqi <shuyiqi@phytium.com.cn>,
 Minda Chen <minda.chen@starfivetech.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>, Michal Simek
 <michal.simek@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Moritz Fischer
 <moritzf@google.com>, Sergei Antonov <saproj@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Johan Jonker <jbx6244@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jon Lin <jon.lin@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Mathew McBride
 <matt@traverse.com.au>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-48-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240502013138.2383421-48-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 03 May 2024 06:34:38 +0200
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 02.05.24 03:31, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Roese <sr@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mark Kettenis <kettenis@openbsd.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: liuhao <liuhao@phytium.com.cn>
> Cc: shuyiqi <shuyiqi@phytium.com.cn>
> Cc: Minda Chen <minda.chen@starfivetech.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Moritz Fischer <moritzf@google.com>
> Cc: This contributor prefers not to receive mails <noreply@example.com>
> Cc: Sergei Antonov <saproj@gmail.com>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Jon Lin <jon.lin@rock-chips.com>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Maksim Kiselev <bigunclemax@gmail.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
> Cc: Mathew McBride <matt@traverse.com.au>
> Cc: Leo Yu-Chi Liang <ycliang@andestech.com>
> Cc: Mason Huo <mason.huo@starfivetech.com>
> Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   drivers/pci/pci-aardvark.c                 | 1 -
>   drivers/pci/pci-emul-uclass.c              | 1 -
>   drivers/pci/pci-rcar-gen2.c                | 2 +-
>   drivers/pci/pci-rcar-gen3.c                | 1 -
>   drivers/pci/pci-uclass.c                   | 1 -
>   drivers/pci/pci_auto.c                     | 2 +-
>   drivers/pci/pci_auto_common.c              | 1 -
>   drivers/pci/pci_common.c                   | 1 -
>   drivers/pci/pci_compat.c                   | 1 -
>   drivers/pci/pci_ftpci100.c                 | 1 -
>   drivers/pci/pci_mpc85xx.c                  | 1 -
>   drivers/pci/pci_mvebu.c                    | 1 -
>   drivers/pci/pci_rom.c                      | 2 +-
>   drivers/pci/pci_sandbox.c                  | 1 -
>   drivers/pci/pci_sh7751.c                   | 2 +-
>   drivers/pci/pci_tegra.c                    | 1 -
>   drivers/pci/pci_x86.c                      | 1 -
>   drivers/pci/pcie_apple.c                   | 1 -
>   drivers/pci/pcie_brcmstb.c                 | 1 -
>   drivers/pci/pcie_dw_common.c               | 1 -
>   drivers/pci/pcie_dw_meson.c                | 1 -
>   drivers/pci/pcie_dw_mvebu.c                | 3 ++-
>   drivers/pci/pcie_dw_rockchip.c             | 1 -
>   drivers/pci/pcie_dw_sifive.c               | 1 -
>   drivers/pci/pcie_dw_ti.c                   | 1 -
>   drivers/pci/pcie_ecam_generic.c            | 1 -
>   drivers/pci/pcie_ecam_synquacer.c          | 1 -
>   drivers/pci/pcie_fsl.c                     | 2 +-
>   drivers/pci/pcie_fsl_fixup.c               | 1 -
>   drivers/pci/pcie_imx.c                     | 1 -
>   drivers/pci/pcie_intel_fpga.c              | 1 -
>   drivers/pci/pcie_iproc.c                   | 1 -
>   drivers/pci/pcie_layerscape.c              | 1 -
>   drivers/pci/pcie_layerscape_ep.c           | 2 +-
>   drivers/pci/pcie_layerscape_fixup.c        | 1 -
>   drivers/pci/pcie_layerscape_fixup_common.c | 2 +-
>   drivers/pci/pcie_layerscape_gen4.c         | 2 +-
>   drivers/pci/pcie_layerscape_gen4_fixup.c   | 1 -
>   drivers/pci/pcie_layerscape_rc.c           | 1 -
>   drivers/pci/pcie_mediatek.c                | 1 -
>   drivers/pci/pcie_phytium.c                 | 1 -
>   drivers/pci/pcie_plda_common.c             | 1 -
>   drivers/pci/pcie_rockchip.c                | 1 -
>   drivers/pci/pcie_starfive_jh7110.c         | 1 -
>   drivers/pci/pcie_uniphier.c                | 1 -
>   drivers/pci/pcie_xilinx.c                  | 1 -
>   46 files changed, 10 insertions(+), 46 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
