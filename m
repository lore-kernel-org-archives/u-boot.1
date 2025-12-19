Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D7AD74942
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 03:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A9A5800AB;
	Fri, 19 Dec 2025 04:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="SE2eKtwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6234183106; Fri, 19 Dec 2025 04:23:11 +0100 (CET)
Received: from mail74.out.titan.email (mail74.out.titan.email [3.216.99.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A20080050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 04:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dXXt402t3z2xBL;
 Fri, 19 Dec 2025 03:23:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=a/X9cOtlGe78a6656SYdfizmGE0VMRQjGEPdeV3+2fY=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=from:to:cc:references:mime-version:in-reply-to:date:subject:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1766114587; v=1;
 b=SE2eKtwvys3h0F4tfmkj6kYTTOiHlJ0S5NrKZA/j1vWnTGOSIrRQ1BCpb6bwo/ohROu3QRr3
 MAzl3FAmJVBMD+pEMpBKBsuGDO+Tk5XcoMTLKtPcMJz7KD6xpnFomwPp9pp3EdXN7H14nsqHw7D
 yLaA8JNdXJFefDmtLYUjrz4M=
Received: from pie (unknown [117.171.66.90])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dXXt11hwwz2xBp;
 Fri, 19 Dec 2025 03:23:04 +0000 (UTC)
Date: Fri, 19 Dec 2025 03:23:02 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Fabio Estevam <festevam@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Jonas Karlman <jonas@kwiboo.se>, U-Boot-Denx <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, xuhui.lin@rock-chips.com
Subject: Re: RV1103B: Attempt to upstream
Message-ID: <aUTFFpDswwsVYdI0@pie>
References: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766114587807990686.27573.518678248260049341@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=6944c51b
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=NEAV23lmAAAA:8
 a=AWZi2RE4U0veD8EFqocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
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

On Thu, Dec 18, 2025 at 11:45:11PM -0300, Fabio Estevam wrote:
> Hi,
> 
> I have a custom board based on the Rockchip evb-rv1103 (RV1103B silicon),
> booting from SPI-NAND.
> 
> I can successfully boot the vendor Rockchip U-Boot v2017.09 on this board,
> from SPI-NAND
> 
> I am currently working on upstreaming U-Boot support for the RV1103B SoC.
> My first RFC attempt is available here:

I think the upstreaming process should start from the kernel side,
then we will have stable devicetree ABI reference to work with, instead
of creating everything from scratch in U-Boot.

This will also makes it easier to enable OF_UPSTREAM.

>   https://github.com/fabioestevam/u-boot/commits/rv1103/
> 
> Build steps:
> 
>   make evb-rv1103_defconfig
>   make
> 
> However, I am not yet able to boot U-Boot on the board. At the moment,
> the board does not boot and only prints "RKUART".
> 
> My initial plan was to avoid SPL, similar to the evb-rv1108 approach
> (described in board/rockchip/evb_rv1108/README).
> 
> Before going further, I would like to ask:
> 
> Is the evb-rv1108 “no SPL” boot flow a valid reference for RV1103B?
> 
> Any guidance or pointers would be greatly appreciated.
> 
> Thanks,
> 
> Fabio Estevam

Best regards,
Yao Zi
