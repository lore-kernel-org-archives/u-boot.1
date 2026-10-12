Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B489CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE0936064A;
	Mon, 12 Oct 2026 12:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TRGwmkW6d0nY; Mon, 12 Oct 2026 12:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E461F6061F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791807470;
	b=kuzIKjrXefCIm+KgVgEX6pMxErhTj9tHlEW7AQwwAGGF7YykZKKXYI4vqGyKPQbUDVSO
	 EMN5qS0L0ovdKqWhN8gHfzIp4oLejTktgKswMoDlYdMOb4Ku+6CVgAwaxadjgdRK0uBdF
	 fF4NWafVvp/EWyCea+x/O6DLBaJDJIoeESyviWchBkZwwv+EPGcIkwxZ+m/hiuG5EKUu2
	 s85RUmvoHjtDcNSMfIA+Sc1y+NR/rW7aL68Uc+axLXsUs4jWbn8qw5aDlc6UijLavp/Xg
	 gwI9x1NNmrcAoiIlqAuAJkyyFsU+WrEbTaIKL7PhCm5Em+3/jI9Ghu3XOfS3BKTeitg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791807470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Eu+W+FKmwQmYgmHkXfXtREIQZ95qVHjDIXQn8D/VDBc=;
	b=HVfFKAcunnssiSdIM6I1VVDED+sUmXMnKoNd7AIr0qfppMOz8sdJ84ZpcLWZtbnm86vm
	 yRL8p2A+vICpsOtx2f1XyozxBll4BPD31THnMobiG4vRvUPvKsRi7bM2fmtouytNcAc12
	 cg7frN4/G7ZV5DPBeJWJvbi29zyS094tYXbAokm5Za8Yc8iodVQ41hwE33JcBLd1qmsvc
	 B7ZFPCGueUDlR6gfP2ya4404gMa+KAoKGg7UlwOHqhFuJM3T+CLp8TRiKLnQ+jqD0FbNu
	 XqAS5V+Z9bvnTWWWduOQxgsaGL9j71OUUw/M5+Bd0H4RckzVA67G5XjrYVY9QRCWqqg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmXSj0Ax;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791807470;
	bh=Eu+W+FKmwQmYgmHkXfXtREIQZ95qVHjDIXQn8D/VDBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t19LEST2fodeH9nRh8K0vV8rrwfjYk5DoKE07i+dojBICPivbZpB9HJ0CJE//QMqZ
	 PjIf81mLSPiStiftybBEoN/b2+dIyt+ONTf2+EiD5a8axMLBhFWM0dowxUIklp16IM
	 h0uFlK5AyfFC8nLBXqY1hqo321pQcV79NtUgkc171jE0m9Xv8s7QZdK9l898jzvn0s
	 OnRN73e7mkT1feIWVbn9kArPHdS7ruyVF0xVNmuE6IUgO8kpBfLN0HeqLr54Zcki1I
	 PNzzLZ2FBx9my3Sb2eTb6sjuOUO+bLRjM4yxDifqD6YGA0/JnoDjFJal4luLYpGy2P
	 XCAhkS/s/D8/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E461F6061F;
	Mon, 12 Oct 2026 12:17:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 793B4105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 738F76061F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sw6u2HgJUOwx for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 12:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8FA1605F4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791807456;
 b=MC4+lSSztAtDRx2FvYT9hq6B6QX6Gjg6B3Cv09SoWN2815nmHB7ejKKjlJPpZ65uN+Uy
 Q44m9zzoHIqy75rKirGA3y9Jilyxr3q9OOqM0skzerf76VmvwEeCQ3IsAIkhJdyrFC2g7
 KFAboGHGxWcTnOzN+JfslpDxDIbPqbx7kNoLwAdJEmM0ahs8zT0ElOR8kLgmrJu/6mtsk
 V1Vv33MwxhwVsvLz4lCsi2ETFH9wM49r/G1PLvmzTYYIl5wxt9qwjKZbr3RTyEk94Q+qG
 vckzaEp8haIZ8/K25hCTvKmfkDAD8xfmn53EQfWK0TkkmltDzI8yGYaeOE6XdpKIy9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791807456;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Eu+W+FKmwQmYgmHkXfXtREIQZ95qVHjDIXQn8D/VDBc=;
 b=RpYow9K8ynL9vVQsHdptRjRg/Hofdr3kKcBoGbVjp72O9okKuyd3bo2YFVj3E07tNErP
 EOtJXWd2VtiU974tuJ82l6qzaqn9tGZxvAlELdF/HsQFeIyzAC3nWgfUvem2jcLuggGTi
 VKis6PYrnSWfuUaE1aXAFJqOj1CkuLCb5YXfEzFcqtNznxo6FAJvWmNQTilYeiw5LN06a
 upNnftkdPa3+aNjz07M2ik6vI4VtZGhVXWEZdJ6/LldfS4kosd4L9Lh6QRVdPl0JxPp4M
 Kif2e6DnzRgyxDMrW9U8bI5UuBQ9qkEV2gbrOoC8hlagnA0PzdRcCB/c94ZE8GKV5SQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GmXSj0Ax; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GmXSj0Ax
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8FA1605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:17:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85BB743735;
 Mon, 12 Oct 2026 12:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89151F0089C;
 Mon, 12 Oct 2026 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791807455;
 bh=Eu+W+FKmwQmYgmHkXfXtREIQZ95qVHjDIXQn8D/VDBc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GmXSj0Axln0FRHH53f2mg9gLB0jVn4/0fcWFwr+9vNFBEaRTCAm6qr8auqvH9MM/z
 JKirBuvEQOXQl9TWdy6x+G6Jpwv6a+nfLjSBkhkLFil5/QvnEPXyE+wxNzV9slBILX
 Tdmpx2jNKJyOIYOMui8sCCd6Ot5rM69bNohxZuv5qOS7NFHsdvg97KraJgyD45nSwA
 C4DGrWSE6Z3BBLqPw338Tebfq9NfD6hi4vSQfkazfrKCxFcNztFHxPAcC0e+gvKr8a
 NZ8Eh9pt/xFECFSID4XWztjM35NFdVY3zHOz4CXA8ZrqXLu0YH8WxXEOIjtCN46oXz
 pyT/1M5UU3V2A==
Date: Mon, 12 Oct 2026 12:17:29 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 1/2] phy: spacemit: add K1 USB 2.0 PHY driver
Message-ID: <20261012121729-GKH26088@kernel.org>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-0001.DaveWK225@protonmail.com>
 <20261012090434-GKF26088@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012090434-GKF26088@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Dave,

On 09:04 Mon 12 Oct     , Yixun Lan wrote:
> Hi Dave,
> 
> On 12:32 Tue 06 Oct     , Dave Klotz wrote:
> > The UTMI PHY at c0a30000 ("spacemit,k1-usb2-phy") feeds the K1's DWC3
> > USB 3 controller. Port the Linux driver: enable the PHY clock, program
> > the PLL divider for the 24 MHz reference, wait for the PLL, then release
> > the PHY's resets and enable its clocks, the HS TX clock and the
> > automatic host-disconnect clear.
> > 
> ..
> > The divider has to be written before the PLL is polled. On the OrangePi
> Right, the upstream kernel driver also did this way
> 
> > R2S under FreeBSD, a driver that polled first and never wrote it left
> > the PLL stopped: the clock enables did not latch (0x60ef read back as
> Sorry, I've not fully understood here, "polled first and never write"..
> Could you elaborate more on this?
> 
> > 0x60e9), the PHY gave the controller no UTMI clock and the xHCI reset
> > (USBCMD.HCRST) never completed. Warn if the enables do not latch.
> Will comment at code below
> 
> > 
> > Also apply the vendor's HS DAC current setting (+15 %), which the
> > FreeBSD driver that runs the R2S port does.
> > 
> Any actual problem without above settings? I'm just curious,
> as upstream code miss this part
> 
> > Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> > ---
> >  MAINTAINERS                        |   1 +
> >  drivers/phy/spacemit/Kconfig       |   9 ++
> >  drivers/phy/spacemit/Makefile      |   1 +
> >  drivers/phy/spacemit/phy-k1-usb2.c | 173 +++++++++++++++++++++++++++++
> >  4 files changed, 184 insertions(+)
> >  create mode 100644 drivers/phy/spacemit/phy-k1-usb2.c
> > 
> > +
..
> > +	/* Release the PHY's internal resets and enable its clocks */
> > +	writel(PHY_INIT_MODE_BITS | PHY_CLK_ENABLE_BITS | PHY_DEASSERT_RST_BITS,
> > +	       base + PHY_RST_MODE_CTRL);
> ..
> > +	val = readl(base + PHY_RST_MODE_CTRL);
> > +	if ((val & PHY_CLK_ENABLE_BITS) != PHY_CLK_ENABLE_BITS)
> > +		dev_warn(phy->dev, "clock enables did not latch (%#x)\n", val);
> So read back and check.. if this situation is happening, a warning
> message won't save life.
> 
> But, I need to check if the "enable bits" actually reflect the clock
> enabling status from the hardware perspective.. but even leave that alone,
> I think using a poll() instead of a readl() is a more proper way to go?
> usually it will take few time for the hardware to settle down..
> 
I've asked SpacemiT internal to check, and got this info:

Setting "enable bits" will take effect immediately, it doesn't reflect
the clock status, so this "readl() & check" isn't useful, drop it

If you still see problem, then probably need investigate other way..

> > +
> > +	writel(PHY_HSTXP_RSTN | PHY_CLK_HSTXP_EN | PHY_HSTXP_MODE,
> > +	       base + PHY_HSTXP_HW_CTRL);
> > +
> > +	clrsetbits_le32(base + PHY_ANALOG_REG14_13, PHY_HSDAC_ISEL,
> > +			FIELD_PREP(PHY_HSDAC_ISEL, PHY_HSDAC_ISEL_15_INC) |
> > +			PHY_HSDAC_IREG_EN);
> > +
> > +	/* Auto-clear the HS host disconnect state on reconnect */
> > +	setbits_le32(base + PHY_TX_HOST_CTRL, PHY_HST_DISC_AUTO_CLR);
> > +
> > +	return 0;
> > +}

-- 
Yixun Lan (dlan)
