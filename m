Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F65CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323E383314;
	Sun,  7 Jun 2026 21:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="PVI01P6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D375F838BB; Sun,  7 Jun 2026 17:53:44 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0565801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Sun, 07 Jun 2026 15:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1780847620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWMOaWhJP2BxvQOSM/T8LP6kDxubWSj+Ohzq8OQgkwk=;
 b=PVI01P6DORGv84XE1AuSlgC0aMcmQ7UDrcqvODzeuElINjKpfGnufiAs+i3YT34jxlTKBf
 txtHz7BXPxBEFUl2xxi50CvGGIiHvylsAJd2mU4tYcdagr0nlytq339ng7djzdwDknhQqX
 QsuVGiKIJdNpD0/eikhO7XrI1DLe4yNbBs4jC5Yo46wRGT4gTVVyf+gJ6U5HSd/XdIybxi
 GMEhfeqn7cUeovRnlZdfvWMi2FSIFsqkLRSPISM++tyn4MXaLwhrFSg4nIt46vm4S9bhtv
 dReACHmX15vslSLYiwlgIkarySx1qEW7uuY8qzsreDG/XEQ7ZIeC3vIfJu24bA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, Denis Mukhin <dmukhin@ford.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Javier Tia <floss@jetm.me>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 00/13] Generate Android boot images with binman
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
 <e21e557b-1573-472f-9666-2bffdb0f4e86@linaro.org>
 <tIT4bs5x6xJ7santHOgWRakaoZ-AJjcaxOX4BW8jop3rcmOLVy8kooUuTmH1QJViVTgyHjeSiP9TvRiH_zcwYTMB63CogsgYT61ORUBllYA=@samcday.com>
 <bd859b0f-45df-45e5-abb2-99076d503a59@linaro.org>
In-Reply-To: <bd859b0f-45df-45e5-abb2-99076d503a59@linaro.org>
Message-ID: <tg9qt2.upy19kfekeu5@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:32 +0200
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

On Sun, 07 Jun 2026 14:48, "Casey Connolly via groups.io" <casey.connolly=linaro.org@groups.io> wrote:
><...>
>>>
>>> I'm really not in favour of adding a binman node to the DTB that U-Boot
>>> uses, and I think it's kinda dumb that this is the only sensible way to
>>> configure binman today...
>> 
>> I see nothing wrong with that. Can you expand on your concerns a little more?
>
>It really just goes against the goal of using upstream DT. Previously I 
>managed to get binman to parse its config from a separate DTB but that 
>was hellish to integrate the tooling for.
>
>Having this random node at runtime for completely unnecessary arbitrary 
>reasons feels just wrong to me.
>

For what is worth, binman config typically goes in -u-boot.dtsi, not the
device upstream .dts. It also doesn't have to be in <device-name>-u-boot.dtsi,
see for example rockchip-u-boot.dtsi and meson-gx-u-boot.dtsi.

I'd guess binman is more geared towards boards where multiple firmware
stages are loaded though (e.g. you have to load u-boot TPL then SPL then
TF-A etc), rather than just one u-boot.bin that's inside an android
boot.img.

Best regards,
Ferass
