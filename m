Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4C4D5B156
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB8A8908F;
	Mon, 28 Oct 2024 22:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DBcYpyms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDDD890E7; Mon, 28 Oct 2024 22:02:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9CBC8907E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 22:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730149336; x=1730754136; i=xypron.glpk@gmx.de;
 bh=sQIV9N0akjdnPNcC5+lLnpTtbjJGzVOQsUlYDO2f8Ts=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DBcYpymsoCo3KfiQ1yQG0LVFGNkIOpNSuigLPaWaivxxyCEiFFrj1Sp4p629zQjk
 0y3di0prVv98hG5XhqYAkoGOp4RinULaL9nnHIvDJMEMSpPMNiOr5zSP5cJycM73b
 pZdTXE0Hgmh220lr5WjMB9kPpzbvCRkkyHJAM6ewJHKXU8yiZHEz2TyggfBf1AgvB
 DNAuUi+bwcCkJGuA9n3t9lXVaizItI2XVn2W2K02K3Bl+/U3VlYO+rf8Wr51XEHH2
 VhlvkPpEXuKVSt8hrfzXts9ap4WbYx/UTmyTSkPTwMnlUhBcZu1JHK5JYSWupJBj4
 3jbQl5XP6RpngBg1Og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQIv-1th0tb0WTn-00ioB1; Mon, 28
 Oct 2024 22:02:16 +0100
Message-ID: <e29cdac5-8c91-4e6b-a7a6-e94917c12fa6@gmx.de>
Date: Mon, 28 Oct 2024 22:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] test/cmd: Make some "ut dm" tests only available on
 sandbox
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241028164844.2308549-1-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241028164844.2308549-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RozK2z4OFuFXMOFo9DeTdant2gavviosrsnroCOwRvncB1VJzYK
 zaAV5Zmk/Fl7fs0SomTgReJNj3vDP4fgAdMit83/twLFnBnGv2sdtfwoFlDsbQVCVLQfEhB
 +5/nXruyXJALZodt8RUDtl5j0kPvzZXH5oG7UAafLzC7g3aAxEguAYhLV+Bx3dLc5Btn2nU
 u/p1Wi2teEQKpdbme+Rtg==
UI-OutboundReport: notjunk:1;M01:P0:/K8ltJC0nYw=;S91RzKi6rwhIJwVpRd6HoG+UTuK
 IWYpZsK3jHoT09VQYrnQ/08JnGXsqfAysTaTuGcRt0z2VNnHtM9JtfISUQbRhiHUfl9GgCMZD
 DNha+iGFB4MRnXFysNLOQj7Skrr+K/5/ngS/Q5TuoRjDJRzoQ6FufB1p4GuVD0RW+rucDP+Rt
 hxUbzaKzuCoElV9KI18SDmr8Xm2RUznBsd+p4fTmQ9qPjsN6Su+j0IJVT80YCWq4rzVe8kcyP
 2DTIKwnnz48AXoeI+qfDYoeRvV8QeMkUcOoCyQ4c98584OFoYvChwS5ZzTWz8tc/ur3UFcXhx
 WTZMtfR47ZOoP74LVBG3nz5zAAPO4WBiXFD26VX6O6wxoxxzDCFccETLjtQs2NeHkUlokaIKz
 VtorPgKehIVgjIVwTYWutSNgtMTafE/K9AY9DTxHTLsRuXO9Uk0UvULqSGdlXV9R+oqblUkjv
 A1YTcfo3ST/o18kMQK2waXekeohOqGpklqlu68HyVBPcm3bYQ1Hy4Aqn7En2unNKVawUtNRmo
 8mRd10Rlt84ExDjnDX2GEl4MCT4AQ25lK75as2iZVZ6OC5TcnP5T0xLJHSlRBomE5RSDH2Mgr
 6KOUiirO622WsEcO96DK42fcDCCEMsUKpFSYSEtCIEg4OrOqp8aJkNpRLsh5tTs1xrMRoZ6Ed
 tDhft4HFYHDdAZfRQ36m+u0+lNQMDvWq1oChv/mSFcQtVua/5G8yKM1JtljLj4+ccSojP89Et
 5kixzh7joI9g/PyRn+MNPmrmSS3CyNKTwuCRuPsPtRQit/42wGVFAvxVENM/jdXpb93nCc9sC
 57rl5xOsTkGR8Il7PGrzy5Vw==
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

On 10/28/24 17:48, Tom Rini wrote:
> Currently, the "dm" suite in unit tests (ut) is only available on
> sandbox. Make sure that all cmd tests that are part of this suite are
> only available on sandbox and not attempted to be run on hardware (where
> it will fail to be able to be started).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>


Adding a comment to the sources describing that the tests require
sandbox drivers would be helpful.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


> ---
>   test/cmd/Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 4b487c1d2cb4..fe7a2165af22 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -25,16 +25,16 @@ obj-$(CONFIG_CMD_MEM_SEARCH) +=3D mem_search.o
>   ifdef CONFIG_CMD_PCI
>   obj-$(CONFIG_CMD_PCI_MPS) +=3D pci_mps.o
>   endif
> -obj-$(CONFIG_CMD_PINMUX) +=3D pinmux.o
> -obj-$(CONFIG_CMD_PWM) +=3D pwm.o
>   obj-$(CONFIG_CMD_SEAMA) +=3D seama.o
>   ifdef CONFIG_SANDBOX
>   obj-$(CONFIG_CMD_MBR) +=3D mbr.o
> +obj-$(CONFIG_CMD_PINMUX) +=3D pinmux.o
> +obj-$(CONFIG_CMD_PWM) +=3D pwm.o
>   obj-$(CONFIG_CMD_READ) +=3D rw.o
>   obj-$(CONFIG_CMD_SETEXPR) +=3D setexpr.o
> +obj-$(CONFIG_CMD_TEMPERATURE) +=3D temperature.o
>   ifdef CONFIG_NET
>   obj-$(CONFIG_CMD_WGET) +=3D wget.o
>   endif
>   obj-$(CONFIG_ARM_FFA_TRANSPORT) +=3D armffa.o
>   endif
> -obj-$(CONFIG_CMD_TEMPERATURE) +=3D temperature.o

