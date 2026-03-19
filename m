Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1651090234
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 14:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7758F83FC0;
	Thu, 19 Mar 2026 15:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 160B883FE1; Thu, 19 Mar 2026 15:24:59 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA31A83EEF
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (ip-109-41-243-10.web.vodafone.de [109.41.243.10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 2B54034A;
 Thu, 19 Mar 2026 15:24:55 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 15:24:54 +0100
Message-Id: <DH6TT2ZV6049.33QOAOWOYSDWL@kernel.org>
Subject: Re: [PATCH 3/3] armv7: ls102xa: fix SPI flash clock
Cc: "Tom Rini" <trini@konsulko.com>, "Ashish Kumar" <Ashish.kumar@nxp.com>,
 "Priyanka Jain" <priyanka.jain@nxp.com>, "Kuldeep Singh"
 <kuldeep.singh@nxp.com>, <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Vladimir Oltean" <olteanv@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260318142949.2479033-1-mwalle@kernel.org>
 <20260318142949.2479033-4-mwalle@kernel.org>
 <20260319141112.3mcbxhhuh5ougbjb@skbuf>
In-Reply-To: <20260319141112.3mcbxhhuh5ougbjb@skbuf>
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

Hi,

On Thu Mar 19, 2026 at 3:11 PM CET, Vladimir Oltean wrote:
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Thanks!

> I think we have a problem in the RCW as well.
> https://github.com/nxp-qoriq/rcw/blob/devel/ls1021atsn/SSR_PNS_30/rcw_120=
0_qspiboot.rcw#L8
> Those values should be interpreted as bit reversed (so 0x00000803 is
> 0xC0100000, i.e. the same value as U-Boot used to write prior to commit
> bb6f3c0f7634 ("armv7: ls102xa: Update SCFG_QSPI_CLKSEL value")).
>
> They are reversed because we write to SCFG_QSPI_CFG prior to writing to
> SCFG_SCFGREVCR. In fact the documentation says about the SCFG bit
> reverse register "This register must be written 0xFFFF_FFFF as a part of
> initialization sequence before writing to any other SCFG register."
>
> So it seems the QSPI clock frequency might be already out of range
> before U-Boot brings it in range with your patch still.

Yes, I've noticed that too. But we have our own repo of the RCWs for
our boards. But yeah, we've basically copied NXPs values. So the
60MHz speed is still lurking there. But instead of the 75MHz, 60MHz
seems to at least work (and nobody noticed).

> I can take additional RCW patches if you're willing to send them.

As said above, we have our own repo that isn't a fork of NXPs.

> Plus, I see since commit ba89878d7029 ("armv7: ls102xa: make QSPI clock
> selection optional during SoC init") that SYS_FSL_QSPI_SKIP_CLKSEL is an
> option too, maybe that's of interest.

I've seen that, but haven't looked further why there is that option.
Probably, to keep any custom clksel value ;)

-michael
