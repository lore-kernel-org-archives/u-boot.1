Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AD0C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 23:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8C18824B;
	Sun, 21 Apr 2024 01:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713655197;
	bh=5IbYlCURX6GOp7Zg726oiOCDfphpXADAwnL28w7ndpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JU8QTjeVU18CdWjaQclsSbAMitRU/DzhVWCAZcp/y3k0f/gdfotCbiwrJxQvDbEWT
	 1Th4aj1tdwwqqS37xNKkbbiS7WptAll1BaHCDZSDkl2JiRHGPJwVqQCwZ3WTMt1GvN
	 KzV67pAk51XgDcJfGMjDwAQaz6GZdK9CxuZcX55o6t91ZIG2dz7e/WWvJLqckAfXZx
	 5CadsqtF6fcOzURwzly/2xvDGiGmHCewO3SwfVkmQd4k8AQJPJIN1J+1G/bmCNPveY
	 jXpcFnxQoMTalhhCUBY5TKeMU9iuto/ndfI5Q3kPSldNTrVdyJsfeQ3LVatB1LerIi
	 PKB0RedrR/Ojw==
Received: from crub (p508b6ab0.dip0.t-ipconnect.de [80.139.106.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7680587F4E;
 Sun, 21 Apr 2024 01:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713655195;
 bh=5IbYlCURX6GOp7Zg726oiOCDfphpXADAwnL28w7ndpU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UhMgkS9Op1tndeGKO5+nv5iHMAxMGjsmbzdTiZTK8QGFqSK4+s65MccOVwZv0XEOO
 v4l57BwigqonpTsbUaJ6lCMiU1vcrOvrgEON6trWhgl9Fqp99gxfpNXVhh1iLJ05lD
 7Z82JWmOHdNK9NuViYrUMhH9PWgl9xldCwunAK05wtakZKcJaTifKXWHyZCh86i566
 a5Sm8ahHRx43r6G6tF57nZwBE6RmbjtPYPexBTzwIbp+ringU2S2Rw0l6GnxRnlQq/
 F889d44zNjpbmEw2D24EJe7yPlyVzIKuQ7kieMSbcThFhRNoPtL6SOWwsnWzdLuEgM
 dD3/kugn6lY2A==
Date: Sun, 21 Apr 2024 01:19:34 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Jagan Teki <jagan@amarulasolutions.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Andre Przywara
 <andre.przywara@arm.com>, Kever Yang <kever.yang@rock-chips.com>, Simon
 Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Andy Yan
 <andyshrk@163.com>, Robin Murphy <robin.murphy@arm.com>, Da Xue
 <da.xue@libretech.co>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 00/17] video: dw_hdmi: Support Vendor PHY
Message-ID: <20240421011934.2d62b8d5@crub>
In-Reply-To: <CAMty3ZACYxo0s9=J3qu9Md1FrskcQTJjY6=2TiUpvYPHE2_Rcg@mail.gmail.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
 <CAMty3ZACUq6_hf_y7uM30EVmaVGtnqRH01sDWwZgKMNoLXw=CA@mail.gmail.com>
 <CAMty3ZACYxo0s9=J3qu9Md1FrskcQTJjY6=2TiUpvYPHE2_Rcg@mail.gmail.com>
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

On Thu, 14 Mar 2024 14:55:32 +0530
Jagan Teki jagan@amarulasolutions.com wrote:
...
> > > Jagan Teki (17):
> > >   video: rockchip: hdmi: Detect hpd after controller init
> > >   video: dw_hdmi: Add Vendor PHY handling
> > >   video: dw_hdmi: Extend the HPD detection
> > >   video: dw_hdmi: Add read_hpd hook
> > >   video: dw_hdmi: Add setup_hpd hook
> > >   video: rockchip: vop: Simplify rkvop_enable
> > >   video: rockchip: vop: Add win offset support
> > >   video: rockchip: vop: Add dsp offset support
> > >   clk: rockchip: rk3328: Add VOP clk support
> > >   clk: rk3328: Add get hdmiphy clock
> > >   phy: rockchip: Add Rockchip INNO HDMI PHY driver
> > >   video: rockchip: Add rk3328 hdmi support
> > >   video: rockchip: Add rk3328 vop support
> > >   ARM: dts: rk3328: Enable VOP for bootph-all
> > >   rockchip: Enable preconsole for rk3328
> > >   configs: evb-rk3328: Enable vidconsole for rk3328
> > >   configs: Enable HDMI Out for ROC-RK3328-CC  
> >
> > Any comments on this? Or is it okay if I send a PR for this?  
> 
> Any update?

Series applied to u-boot-video.

--
Anatolij
