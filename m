Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43C2C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 15:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06EBF88A39;
	Wed, 31 Jul 2024 17:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722439762;
	bh=daCEQeDovOEtciodmcUIS5ZUDoQpr+rh3s/I8OXh9Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QRrUlc22IlFGhqECaxG6Y6lFw8qOq2wS8AOmidQ5E1KuuKQFY63nKXrF/cyE3DCMx
	 0FoqML6bZ/gDuqdfnmUaEoLf45PIQW8KU8wTz/FMoEDMVQSa4HZOcBwDHaqAQEgf7L
	 bOq1qesAk8eZeDk84tnyTy2ZQXBzJaU2f4h3JcZIfSu1hj4qXY/opK2uWgLjnZ77gE
	 UZu25TXiGfxY2wyt/BWsZ/5BFxNJLvtlQ+RAUDNeflWqzFxTAOWghu31sgynNR6uZk
	 NyXgube+x9DnDpVU3URBwObLUU67SxJrQz+o6ZI1j0DfhUzObFzuiLnVnbhkyQeWeZ
	 6s+1ZC8Q8YnqQ==
Received: from crub (p54833c06.dip0.t-ipconnect.de [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9AC6888A08;
 Wed, 31 Jul 2024 17:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722439760;
 bh=daCEQeDovOEtciodmcUIS5ZUDoQpr+rh3s/I8OXh9Mc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Rh6oS4gHCR9xGZQagcWX29ETnqMDD7HGcDp5p2Wrm43PZ59aYrppgBwW/bhJCC+a1
 K7Jy4bqFeJa5Nv4H6ntuxRne6IlyDJBBU/spGOaQkzO4pPHJsg6AHAo9Vk8xlof4SJ
 f81MJfjcng2FDLOZHB2Y3Bk4BK538vgeg/VjnLb/FrqxMbblJBFzOidqByVT5fErxR
 GIVod0mcP+LtLiGtU6xq7ric9aY7fG1NIPwpgYdr4R2ffB9C3las7nfM9ZdB25Dd8E
 l6CgE6xVC1xBiuYzE+c5ZqPhTKFFhn33agSyojIjx8RUJqhDtQx+WQupbcUGsQQhuk
 K5e0akxjQzSVA==
Date: Wed, 31 Jul 2024 17:28:56 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Angelo
 Dureghello <angelo@kernel-space.org>, Anton Bambura
 <jenneron@protonmail.com>, Bin Meng <bmeng@tinylab.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Nikhil M Jain <n-jain1@ti.com>, Ondrej
 Jirman <megi@xff.cz>, Peter Robinson <pbrobinson@gmail.com>, Randolph
 <randolph@andestech.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3 0/5] video: Improve syncing performance with cyclic
Message-ID: <20240731172856.1f6596e1@crub>
In-Reply-To: <CAFLszTjr18h6oeFnNF6A5+D70LWLYXDDQLJ-5V6qO-pjW7qA9g@mail.gmail.com>
References: <20240704074859.2956745-1-sjg@chromium.org>
 <20240731010407.0ff6a929@crub>
 <CAFLszTjr18h6oeFnNF6A5+D70LWLYXDDQLJ-5V6qO-pjW7qA9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Simon,

On Wed, 31 Jul 2024 08:38:35 -0600
Simon Glass sjg@chromium.org wrote:

> Hi Anatolij,
> 
> On Tue, 30 Jul 2024 at 17:05, Anatolij Gustschin <agust@denx.de> wrote:
> >
> > Hi Simon,
> >
> > On Thu,  4 Jul 2024 08:48:54 +0100
> > Simon Glass sjg@chromium.org wrote:
> >  
> > > Now that U-Boot has a background-processing feature, it is possible to
> > > reduce the amount of 'foreground' syncing of the display. At present
> > > this happens quite often.  
> >
> > This series breaks turris_1x_sdcard SPL build:
> >
> >  https://source.denx.de/u-boot/custodians/u-boot-video/-/jobs/878470#L646
> >
> > Should we enable CONFIG_SPL_CYCLIC for this board to fix this?  
> 
> Oh, my passing run was from a month ago[1].

I see, turris_1x board patches were merged later.

> I think I need to change a Kconfig condition. Let me try that and resend.

OK, thanks!

--
Anatolij
