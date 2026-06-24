Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA72ACDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 04:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114618460E;
	Wed, 24 Jun 2026 06:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Mkrd5jSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A04C84671; Wed, 24 Jun 2026 06:47:14 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF39980287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 06:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782276424; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K4OnYxVkzVVT/vUQanJH/mb8Sui4s+WJQGmXQ9GIPD24/bSXXtI+kCK1Otoj4ATRhWXpjicZjQdhDguf9BOy+MeMf5gRPAPYRIEvFVXiXWVnlGUHHC3T2oCjyVamrkG1L56OwHAWa1xynJ3MDdPuKfbM9BbsqFS8CXiiYTTFSkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782276424;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=44cj+C2Qe2k/Juo7eKK+/Quoz7tpze6s+/LCJ6rVjkc=; 
 b=B0QIgGWxI0iDDwPVlo4BkyhsVjn8QRf19bNyGtCn6vGZOL0rJo483mJnslX8buCNN6xn7fSLk+c8wTgR6VyyYMu3z8Vnu9N8uouwwuNVyeC8VHGL/JWcywMCGjXUzRJ43cWbxZkazTSaCtc28vXnyXPmB0Ep2iFSeDQTwkEKSUE=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782276424; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=44cj+C2Qe2k/Juo7eKK+/Quoz7tpze6s+/LCJ6rVjkc=;
 b=Mkrd5jSaEH/1G11Inpr1DfT02aUC8Y34i5ojg0SRvWiPjkkqO6UqN6lPm0jbnZRn
 BH/tT8z8TQx4tLZQYKxHymyPT+7NSHycnmJIDdhUdgA9xN57GCb70LRwCYVbAC5ZwVM
 BdnzBLJmHldYZdC59h5E7G/7N++GCKyiSfwpCggE=
Received: by mx.zohomail.com with SMTPS id 1782276421587121.03361146736268;
 Tue, 23 Jun 2026 21:47:01 -0700 (PDT)
Date: Wed, 24 Jun 2026 04:46:50 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
Cc: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de,
 uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de,
 samuel@sholland.org, Guodong Xu <guodong@riscstar.com>,
 Scott Bambrough <scott@riscstar.com>
Subject: Re: [PATCH 2/8] mmc: k1: add sdhci platform driver
Message-ID: <ajthOhWTPVMIyMfH@pie>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-3-raymondmaoca@gmail.com>
 <aiz8E_EFaSj9q-Fl@pie>
 <CAH22mJwsH9gPo6xTrX6G+9weAbaV2pk6XGqi=Xshng4XuaNvcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJwsH9gPo6xTrX6G+9weAbaV2pk6XGqi=Xshng4XuaNvcg@mail.gmail.com>
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

On Wed, Jun 24, 2026 at 10:23:35AM +0800, Eric Chung wrote:
> On Sat, Jun 13, 2026 at 2:44 PM 'Yao Zi' via uboot <uboot@riscstar.com> wrote:
> >
> > On Fri, Jun 12, 2026 at 04:18:55PM -0400, Raymond Mao wrote:
> > > From: Guodong Xu <guodong@riscstar.com>
> > >
> > > Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> > > implements the necessary platform-specific operations for the SDHCI
> > > controller, enabling MMC/SD card functionality on K1-based platforms.
> >
> > Is there any reason not to re-use Linux-side K1 MMC driver,
> > sdhci-of-k1.c, and its companion ABI? Since Linux commit e9cb83c10071
> > (mmc: sdhci-of-k1: add comprehensive SDR tuning support, 2026-05-11)
> > it is now capable of operating on SD cards, too.
> >
> Excuse me. Is there any ABI breakage in this SD/eMMC device?

Yes, I only take a brief look, and at least the names for pinctrl states
differ from Linux upstream, as mentioned below.

So are there any reasons not to re-use it? This driver has been
carefully reviewed in Linux side, has the expected ABI, which would
reduce your work of upstreaming.

> > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > ---
> > >  drivers/mmc/Kconfig          |   7 +
> > >  drivers/mmc/Makefile         |   1 +
> > >  drivers/mmc/spacemit_sdhci.c | 934 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 942 insertions(+)
> > >  create mode 100644 drivers/mmc/spacemit_sdhci.c
> >
> > ...
> >
> > > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> > > new file mode 100644
> > > index 00000000000..392ca389fa9
> > > --- /dev/null
> > > +++ b/drivers/mmc/spacemit_sdhci.c

...

> > > +static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
> > > +{
> >
> > ...
> >
> > > +     /* Set pinctrl state */
> > > +     if (IS_ENABLED(CONFIG_PINCTRL)) {
> > > +             if (mmc->clock >= 200000000)
> > > +                     pinctrl_select_state(mmc->dev, "fast");
> > > +             else
> > > +                     pinctrl_select_state(mmc->dev, "default");
> > > +     }
> >
> > This doesn't match Linux side ABI, where when card operates in UHS mode,
> > pinctrl state "uhs" is selected.
> >
> OK. Switch to "uhs". By the way, the upstream DTS file hasn't been
> synced into uboot yet. This is not easy to find.

I'm not sure what do you mean by "not easy to find". You could always
refer to the dt-bindings maintained by Linux side for ABI description,
and we want to keep aligned with it in U-Boot side as long as possible
to reduce maintenance burden and improve interoperability.

> > Regards,
> > Yao Zi
> >
> > [1]: https://lore.kernel.org/linux-riscv/aUDwDkd8k_4gD1yc@pie/
> > [2]: https://lore.kernel.org/linux-riscv/20260108-kx-pinctrl-aib-io-pwr-domain-v2-0-6bcb46146e53@linux.spacemit.com

Regards,
Yao Zi
