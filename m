Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51D7C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120CE87D50;
	Mon, 11 Mar 2024 14:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="nIrFgsKp";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="EVQL/znx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B1887C48; Mon, 11 Mar 2024 14:32:54 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFD487E3D
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1710163960; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=QK9HFZ3/ghnWzrpcA0DqmHkv3mBaU2xOVbF87FjMQn+EaajF1lpTpOP6L9wUeyXHk4
 fKzRQbTlN9pgVSPYV9XS010g9cAy0LvpW6nj50p99YBPy1i9nOsKzd9z38cbhy1Iqn1f
 jDCCSbVKsMgCvNp4Ij6cu5zFKMhMRLDZk3CaVDo388fdv6CoGBXHuB++ZXKLBkT0/DYA
 6dHVmnu6WaTTWPMb1iVZ1iTM5IlRmOfZTdKDCtuytFOJHWFmcLH1mbXOYJ7fJZ1Qy5lv
 thygOxp7soKdyPhV52p4TjYk2RgUJPcpCaoMl+Dg63shdNjPmy2k3+MvwCxRzJ2CWar6
 PQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710163960;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=kzO3N9EWTk2qiwTw/dUDnGK2SsFp91M9x6WOoDGec/k=;
 b=qjprTh9F/9xH/7p35njhemvncZH8fflERQHfAKPWMopbn99zr/TTYBswNMOmWRDw/q
 lp0rXAkfscRviy2eSN2aFygbFECEA5/u6mqBparyQFNP1a6nBlyTG2IKS+7yX9UskEI7
 pdw/JP1gTKfq5kwUrwLw4CfsXUco8b7DZkQhrNr0UzJRzg44WibWErGVkW+l7i/oW4uJ
 nc3U3eh315OHraMWs876Z92CE6sy3YMnqIAEWMdjM0V8Fwg49Giho3YMNz5XEtRwc7Kr
 I9IVvnq0QQPo2qZIrELszA12SQTiqwK0y6ryo1eAlfDl8c656izSN88FcB/qoNZykJK1
 px6Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710163960;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=kzO3N9EWTk2qiwTw/dUDnGK2SsFp91M9x6WOoDGec/k=;
 b=nIrFgsKp8XMXvGBAz6bDU5QyAF3z5A48EUyCwZH4x63M4RtyuSFBFBpf1hCEfhBgIw
 +xNqM2vq81GyrOF/85gcUR+rz/IDJxkC7nVQbp6srhxGOaCMBb9pJ1+NNv2V/lVdbKPf
 s8aEWL4A+cuNyrBYB/mpUFv2qDq3ZCpuDzj6ObSfJaOvmGuuFQSksCLlwThhVbNu2hIi
 mwU80BWn5o4Dj/AqaA/aqyEbZe5evkk9cHl7avyqG8089AkmvRzndNqEXKhhJp0WRY/5
 CSCnBea3jSJFRB4hRZYxrt/Vahlj6L7QmBmuLDqKNZ0Xp5sRst67DoAwP4MtGVbtHy43
 5ZwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710163960;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=kzO3N9EWTk2qiwTw/dUDnGK2SsFp91M9x6WOoDGec/k=;
 b=EVQL/znxW4of1Rs9Lv+f/VAC9QeMCzBcvEjtr9IAFokN2qz74gxsKD6E+BeD1xIGKx
 G/8Uidq/0+s5Vo4zPjDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8pqN1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 50.2.0 DYNA|AUTH)
 with ESMTPSA id ufb40802BDWcbio
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 11 Mar 2024 14:32:38 +0100 (CET)
Date: Mon, 11 Mar 2024 14:32:32 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
Subject: Re: [PATCH v2 2/5] apq8016: Add support for UART1 clocks and pinmux
Message-ID: <Ze8H8CyriUP2qjsD@gerhold.net>
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-3-sumit.garg@linaro.org>
 <0867ce89-b6db-482c-a0f6-e2d2535dad30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0867ce89-b6db-482c-a0f6-e2d2535dad30@linaro.org>
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

On Mon, Mar 11, 2024 at 12:27:11PM +0000, Caleb Connolly wrote:
> On 11/03/2024 11:10, Sumit Garg wrote:
> > SE HMIBSC board uses UART1 as the main debug console, so add
> > corresponding clocks and pinmux support. Along with that update
> > instructions to enable clocks for debug UART support.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/clk/qcom/clock-apq8016.c       | 50 +++++++++++++++++++++-----
> >  drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
> >  drivers/serial/serial_msm.c            |  6 ++--
> >  3 files changed, 47 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> > index e6647f7c41d..a620a10a520 100644
> > --- a/drivers/clk/qcom/clock-apq8016.c
> > +++ b/drivers/clk/qcom/clock-apq8016.c
> > @@ -43,6 +43,14 @@
> >  #define BLSP1_UART2_APPS_N		(0x3040)
> >  #define BLSP1_UART2_APPS_D		(0x3044)
> >  
> > +#define BLSP1_UART1_BCR			(0x2038)
> > +#define BLSP1_UART1_APPS_CBCR		(0x203C)
> > +#define BLSP1_UART1_APPS_CMD_RCGR	(0x2044)
> > +#define BLSP1_UART1_APPS_CFG_RCGR	(0x2048)
> > +#define BLSP1_UART1_APPS_M		(0x204C)
> > +#define BLSP1_UART1_APPS_N		(0x2050)
> > +#define BLSP1_UART1_APPS_D		(0x2054)
> > +
> >  /* GPLL0 clock control registers */
> >  #define GPLL0_STATUS_ACTIVE BIT(17)
> >  
> > [...]
> > @@ -94,6 +102,33 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
> >  	return rate;
> >  }
> >  
> > +static const struct bcr_regs uart1_regs = {
> > +	.cfg_rcgr = BLSP1_UART1_APPS_CFG_RCGR,
> > +	.cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR,
> > +	.M = BLSP1_UART1_APPS_M,
> > +	.N = BLSP1_UART1_APPS_N,
> > +	.D = BLSP1_UART1_APPS_D,
> > +};
> > +
> > +/* UART: 115200 */
> > +static int apq8016_clk_init_uart1(phys_addr_t base)
> 
> I know we're still dealing with some tech debt here, but I'm not a big
> fan of this approach. I notice that the RCG and CBCR registers are all
> offset by exactly 0xff0 between UART1 and UART2, what about adding a
> second "index" parameter to apq8016_clk_init_uart() and then offsetting
> the addresses by (0xff0 * index)?
> 

This would work for MSM8916 where you have just two UARTs, but it might
be misleading since the UART blocks are actually separated in 4 KiB
(0x1000) blocks and not offset by 0xff0. UART2 is a special case that
has different offsets within the 4 KiB block, for some weird reason.

If you want to calculate the register offsets properly you would need
special handling for UART2, e.g. I have the following (admittedly rather
ugly) define in the TF-A port for MSM8916 and similar [1]:

#define GCC_BLSP1_UART_APPS_CBCR(n)	(GCC_BASE + \
	(((n) == 2) ? (0x0302c) : (0x0203c + (((n) - 1) * 0x1000))))

where n is the UART number (here 1 or 2). As a different example,
MDM9607 has 5 UARTs (1 to 5) and there only UART2 is special-cased,
while all others follow the standard offset with 0x1000 offset.

Thanks,
Stephan

[1]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/qti/msm8916/msm8916_setup.c?h=v2.10#n40
