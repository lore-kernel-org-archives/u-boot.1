Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1290C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 17:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74C0B842FC;
	Sun, 19 Jul 2026 19:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="PvYE2xcc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F7B842FC; Sun, 19 Jul 2026 19:01:49 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56FBE838D7
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 19:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784480500; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CRtxJHMGBFIAAmvIYmxMCY84SMiRIufk8YW47ppiybfUItpbxtke7Hkm6C2SDQEfum9A2yh0Gqem3SfYF1MDqrsXMATlRcpvIO38dKqDKTQkvPe9f5jIUijSRTcupFrC+wqDlb5HFIvCZbfL0G5v/7uPinuxppeYPlpeVd//ays=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784480500;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Z3ruDrGIc3DGbvMVqboIrwkZlXiPTmmmpr4AkwzTm64=; 
 b=f7/ambQ0OWWj/Z2Fp28ADgst45hsTBEfyScsptZ2jjrz23tqZq1J1WGXJ1pTsYNLhUzT2ZPX1/ag2WbasoJsX7lXANr6Q0CyM2zk/fcF5LMrtJWJ2RfHcYTCC/a9ku0rSKAjTmTFDP/VBWUX8ZRAgBNP10E09omGRhD1QULWQUA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784480500; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=Z3ruDrGIc3DGbvMVqboIrwkZlXiPTmmmpr4AkwzTm64=;
 b=PvYE2xccekfQmlYdUpb6NJCMJIMapJGzMgKpINyfqihFBAgV2emtAuftO7Zr6SXZ
 5ognkB5tRYrhIL8FaxwiG4D/bJFCXfLwsPsjSJUKTPpvTqrSuVZbqTGUKc/NYfNCru/
 5tj1sgaGxSjOcHgdKU7mTpTzwuoTQLPMDRHyCX2A=
Received: by mx.zohomail.com with SMTPS id 1784480498530588.7915506450299;
 Sun, 19 Jul 2026 10:01:38 -0700 (PDT)
Date: Sun, 19 Jul 2026 17:01:25 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v4 02/10] pinctrl: k1: add IO power domain configuration
 support
Message-ID: <al0C5dYG7SaWZHYo@pie>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-2-dbd01185f911@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-m4-v4-2-dbd01185f911@riscstar.com>
X-ZohoMailClient: External
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

On Tue, Jul 07, 2026 at 11:21:43PM +0800, Eric Chung wrote:
> Dual-voltage GPIO banks default to 3.3V, but when externally supplied
> with 1.8V the internal logic must be explicitly reconfigured to match.
> 
> Add the ability to program IO power domain control registers through the
> APBC block. These registers require unlocking the AIB Secure Access
> Register (ASAR) before every read/write, since configuring a 1.8V domain
> while 3.3V is externally supplied can cause back-powering and pin damage.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v3:
> - Add SYSCON dependency in Kconfig.
> - Fix not sorted issue in the driver.
> ---
>  drivers/pinctrl/spacemit/Kconfig      |  2 +-
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 83 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 3 deletions(-)

...

> diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
> index 3ebc397213b..95344f4ec72 100644
> --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
> @@ -12,6 +12,8 @@
>  #include <linux/bitops.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> +#include <regmap.h>
> +#include <syscon.h>
>  
>  /*
>   * +---------+----------+-----------+--------+--------+----------+--------+
> @@ -34,8 +36,23 @@
>  #define PAD_PULLUP		BIT(14)
>  #define PAD_PULL_EN		BIT(15)
>  
> -#define PIN_POWER_STATE_1V8		1800
> -#define PIN_POWER_STATE_3V3		3300
> +#define IO_PWR_DOMAIN_OFFSET	0x800
> +
> +#define IO_PWR_DOMAIN_GPIO2_Kx  0x0c
> +#define IO_PWR_DOMAIN_GPIO3_K1  0x10
> +#define IO_PWR_DOMAIN_MMC_Kx    0x1c
> +#define IO_PWR_DOMAIN_QSPI_K1   0x20
> +
> +#define IO_PWR_DOMAIN_V18EN	BIT(2)
> +
> +#define APBC_ASFAR		0x50
> +#define APBC_ASSAR		0x54
> +
> +#define APBC_ASFAR_AKEY		0xbaba
> +#define APBC_ASSAR_AKEY		0xeb10
> +
> +#define PIN_POWER_STATE_1V8	1800
> +#define PIN_POWER_STATE_3V3	3300

Space and TABs are both used to separate the identifiers with the
values, please choose a unified style.

With this fixed,

Reviewed-by: Yao Zi <me@ziyao.cc>

Best regards,
Yao Zi
