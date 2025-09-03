Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778CDCA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 11:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CC5834E5;
	Wed,  3 Sep 2025 13:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PegXu+gV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159748350A; Wed,  3 Sep 2025 13:07:29 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC21833C6
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 13:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 91889436C6;
 Wed,  3 Sep 2025 11:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD8DC4CEF0;
 Wed,  3 Sep 2025 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756897644;
 bh=X0YhmhI8LdJjVkjnoLiNWHw4e9pLt/zcfsSC2YmBnyA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PegXu+gVtmRvYMG0fkjEMXKr9arUkXnN268o/KgB3VAfSORvyXT8HyxNjmf0rDU1R
 eLKBHvf3EabBqyC9wIQafUw3tNmiOUblIqzgpBtLbRHiCk7eUWdiwz00L2vgM9l8V+
 WWmMUwouAcpJTMYfDtbb8hOv9y9C/1BCA4j7ZCrGN0J4GPnw3az1R6Ewj8Tsk3/44Y
 /s9EuD59cSLs2aW3iV+fDU6+mXgpq0EDvf21pJlEaHkHpjfdwD9dJXAjFJBXISuXzM
 XGmaNm0l2CiO5IxxBNNnpamGKZ7hhT3OTLiGIt4ippibx9T/TLkst2Ml1g3/iXpg3y
 O9+KZwBIATh6g==
Date: Wed, 3 Sep 2025 16:37:17 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Subject: Re: [RFC 02/10] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Message-ID: <aLghZaUyZZpUHOzP@sumit-X1>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-3-hal.feng@starfivetech.com>
 <3b75e20f-261e-4a23-b2b6-d4f4596b5fb3@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b75e20f-261e-4a23-b2b6-d4f4596b5fb3@freeshell.de>
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

On Tue, Sep 02, 2025 at 01:03:09PM -0700, E Shattow wrote:
> Hi Hal,
> 
> On 8/28/25 23:09, Hal Feng wrote:
> > VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.
> > 
> > Board features:
> > - JH7110S SoC
> > - 2/4/8 GiB LPDDR4 DRAM
> > - AXP15060 PMIC
> > - 40 pin GPIO header
> > - 1x USB 3.0 host port
> > - 3x USB 2.0 host port
> > - 1x M.2 M-Key (size: 2242)
> > - 1x MicroSD slot (optional non-removable eMMC)
> > - 1x QSPI Flash
> > - 1x I2C EEPROM
> > - 1x 1Gbps Ethernet port
> > - SDIO-based Wi-Fi & UART-based Bluetooth
> > - 1x HDMI port
> > - 1x 2-lane DSI
> > - 1x 2-lane CSI
> > 
> 
> Prefer to see subject line and URL of recent upstream discussion or git
> web commit for the new or modified dts changes from upstream of
> devicetree-rebasing in this commit and not just in the cover letter.
> 
> + From upstream LKML discussion "[RFC 3/3] riscv: dts: starfive: Add
> VisionFive 2 Lite board device tree" [1].
> + 1:
> https://lore.kernel.org/all/20250821100930.71404-4-hal.feng@starfivetech.com/
> 
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  .../jh7110s-starfive-visionfive-2-lite.dts    | 152 ++++++++++++++++++
> >  1 file changed, 152 insertions(+)
> >  create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> > 
> > diff --git a/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> > new file mode 100644
> > index 00000000000..a0cb9912eb8
> > --- /dev/null
> > +++ b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> 
> No, do not directly add or modify upstream dts in dts/upstream/src
> subtree. We are not permitted in U-Boot to merge out-of-band devicetree
> changes to the devicetree-rebasing subtree as this creates more work for
> Tom, if I understand correctly?
> 
> Instead add or modify this dts as
> arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi filename.

That's right. dts/upstream subtree isn't allowed to be directly patched
but it is rather synced regularly with devicetree-rebasing. So please
follow documentation documentation here [1].

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

-Sumit
