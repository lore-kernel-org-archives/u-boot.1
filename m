Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E54CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 23:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3A08318E;
	Wed, 17 Sep 2025 01:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B50883280; Wed, 17 Sep 2025 01:58:02 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E2B8309A
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 01:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.145])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 07D2EB220596;
 Wed, 17 Sep 2025 01:57:57 +0200 (CEST)
Message-ID: <4be72e1b-7385-4216-8cca-59928983f2f2@freeshell.de>
Date: Tue, 16 Sep 2025 16:57:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: visionfive2 depend on
 SYS_CONFIG_NAME automatic dtsi inclusion
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20250905050301.900528-1-e@freeshell.de>
 <20250905050301.900528-5-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250905050301.900528-5-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


On 9/4/25 22:02, E Shattow wrote:
> Rename visionfive2 per-cpu jh7110-u-boot.dtsi to
> starfive-visionfive2-u-boot.dtsi for inclusion by search order for whole
> starfive_visionfive2 target. There is expected to be support for multiple
> CPUs and boards, so let's use the automatic dtsi inclusion that is a
> better match for this.
> 
> Depends on patch: "scripts/Makefile.lib: add CONFIG_SYS_CONFIG_NAME prefix
> to dtsi search" [1].
> 1: https://lore.kernel.org/u-boot/20250826214708.309271-1-e@freeshell.de/
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  .../dts/{jh7110-u-boot.dtsi => starfive-visionfive2-u-boot.dtsi}  | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename arch/riscv/dts/{jh7110-u-boot.dtsi => starfive-visionfive2-u-boot.dtsi} (100%)
> 
> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
> similarity index 100%
> rename from arch/riscv/dts/jh7110-u-boot.dtsi
> rename to arch/riscv/dts/starfive-visionfive2-u-boot.dtsi

N.B. I guessed wrong the SYS_CONFIG_NAME is not representative of any
defconfig name. v3 replaces this patch 4/4 and refers to
starfive-visionfive2-u-boot.dtsi via CONFIG_DEVICE_TREE_INCLUDES extra
.dtsi include in defconfig. That unfortunately makes it less visible for
DEVICE_TREE_DEBUG=1 so I am also having a look at improving the dtsi
automatic inclusion and DEVICE_TREE_INCLUDES handling. Anyhow "config
name" in context of SYS_CONFIG_NAME is perhaps referring to the Kconfig
config fragment include '.h' file no relation to any defconfig.

-E
