Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0F8D277D8
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 09:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A84784206;
	Sat, 10 Jan 2026 10:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="XikuEamn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3128432F; Sat, 10 Jan 2026 10:05:10 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA74484166
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 10:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768035902; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RPpZ3WGui8zfVFmvwwvlGeCNWC+U82PQ2MA9OSyZPugTi0TVOssesLqkuFW8qo0Lfvdx+SD7ozd299wku1XSV8wSPtjBRqlB1cmi+oFFcfRiU5eQZgMijLM8IA1XiNmuUmTZuQYqct2XqkFbOO7W9Gco7zYEaxBOGGPHrRaJGxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768035902;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8u9nRJ8+4mbkh+VVUhLWvQw90/oLWiEV1VYAcEDJHWM=; 
 b=gktzeVNUrQrsytovRPnC6V66uwgsQ0jk6GoQJq9B07rOGBBaJ7Cd9PYjcHZnD8WnW2Q3wVWTdo9ndVyKsKLE5r3UiUfndzXnCtMnZK7HQIZ9nKgM3Vtmex8KR/oIm/6WqYkb05Diq6yaN13wJwk0nuxTYESC/aqv78Jx6xFOXL8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768035902; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=8u9nRJ8+4mbkh+VVUhLWvQw90/oLWiEV1VYAcEDJHWM=;
 b=XikuEamnKoakSbDoBx2nPtmvVsqfJNleOJ/6gVsnTPQGhWpFVm5A+wWXRy/yz0ec
 irngxeqXW1OECNsNRPyjTG4+9UThUBFkmz+ZYQ2YL2+0XfnLFbpj2u7s6dRClJlWp5f
 CQQ/9iRu/oRurlrisEHy90YmngNZG56IpBWM3CKk=
Received: by mx.zohomail.com with SMTPS id 1768035900409723.2400984080132;
 Sat, 10 Jan 2026 01:05:00 -0800 (PST)
Date: Sat, 10 Jan 2026 09:04:23 +0000
From: Yao Zi <me@ziyao.cc>
To: Christopher Obbard <christopher.obbard@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Jonas Karlman <jonas@kwiboo.se>, U-Boot-Denx <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, xuhui.lin@rock-chips.com
Subject: Re: RV1103B: Attempt to upstream
Message-ID: <aWIWF_sZ5Epf5zYN@pie>
References: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
 <879112a0bf19df9d79bee3dc33557bf382e0d839.camel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <879112a0bf19df9d79bee3dc33557bf382e0d839.camel@linaro.org>
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

On Sat, Jan 10, 2026 at 03:20:39AM +0000, Christopher Obbard wrote:
> Hi Fabio,
> 
> On Thu, 2025-12-18 at 23:45 -0300, Fabio Estevam wrote:
> > Hi,
> > 
> > I have a custom board based on the Rockchip evb-rv1103 (RV1103B silicon),
> > booting from SPI-NAND.
> > 
> > I can successfully boot the vendor Rockchip U-Boot v2017.09 on this board,
> > from SPI-NAND
> > 
> > I am currently working on upstreaming U-Boot support for the RV1103B SoC.
> > My first RFC attempt is available here:
> > 
> >   https://github.com/fabioestevam/u-boot/commits/rv1103/
> > 
> > Build steps:
> > 
> >   make evb-rv1103_defconfig
> >   make
> > 
> > However, I am not yet able to boot U-Boot on the board. At the moment,
> > the board does not boot and only prints "RKUART".
> > 
> > My initial plan was to avoid SPL, similar to the evb-rv1108 approach
> > (described in board/rockchip/evb_rv1108/README).
> > 
> > Before going further, I would like to ask:
> > 
> > Is the evb-rv1108 “no SPL” boot flow a valid reference for RV1103B?
> > 
> 
> Great to see the RV1103 being upstreamed!
> 
> 
> I have a Rockchip RV1106 based board, the CoolPi 1B https://www.cool-pi.com/product-category/gateway/cp1b/ which I'd also like to get in upstream linux/u-boot.
> 
> The downstream kernel/devicetree is at https://github.com/coolpi-george/coolpi-kernel/blob/linux-5.10-gen-rkr8/arch/arm/boot/dts/rv1106-cp1b.dts with defconfig
> https://github.com/coolpi-george/coolpi-kernel/blob/linux-5.10-gen-rkr8/arch/arm/configs/rv1106_cp1b_defconfig
> 
> The downstream u-boot is https://github.com/coolpi-george/coolpi-loader/blob/develop/configs/rv1106_coolpicp1b_defconfig
> 
> I wonder how similar the RV1106 SoC is to the RV1103 you're working on ?

Given that the devicetree for RV1103 in Rockchip downstream kernel tree
includes RV1106's devicetree[1] and only adds some overrides, I'd like
to say RV1103 is basically only in a different package. They're likely
the same silicon, probably with different qualities.

> I only ask since the RV1106 SoC has a similar prefix to the RV1103. I don't have any other information about the SoC.
> 
> 
> Cheers!
> 
> Chris

Regards,
Yao Zi

[1]: https://github.com/rockchip-linux/kernel/blob/1ba51b059f25533c5529b7f68186190b47d6a7b3/arch/arm/boot/dts/rockchip/rv1103.dtsi#L6
