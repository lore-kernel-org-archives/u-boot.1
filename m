Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFFBC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE30D84867;
	Wed,  1 Jul 2026 00:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="RrDQCbd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CC984B22; Wed,  1 Jul 2026 00:25:51 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C3DA84A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DC4F911872A; Wed,  1 Jul 2026 00:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782858348;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=z+cd+m41KyCkC1A/EVc3k6kraQnJY/zYdLC4rZA/Wgk=;
 b=RrDQCbd0HJCUOf7hh1AlymVmdyGzBZqUvUcCI4Yw9iLY3HbW3XZRuNy1+lMYAg79aBNyXT
 zaJeL4+W2oZ/I8e9MUhb7jbyCfkpIMxpyUzWkTKp77mZYp/SC0er6gAEg/QujRe5K8Rb1j
 SABMrRhHxGH4zO3c/f/IpxCFQcsLYcKGd+5jODk3ynyf5u/uK58Fg4t8ftahREKnnJOl1l
 x2skuECFltWsQgXJKrXqrhNj8u1f7WO88IzUwAJzUoHWsgFUAn921r/Dze7R6VC4mmx08Q
 piZkFCGUdh/kQI9ttfk1zB6n1nEUr2lwJtp8scYPEilsK7ZS+PFp7RDQPH2cEQ==
Message-ID: <b6430de8-7eef-4ee1-bcd6-0976d1f54d27@nabladev.com>
Date: Tue, 30 Jun 2026 11:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/64] usb: dwc3: import from kernel v5.6
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Alexey Charkov <alchark@flipper.net>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-31-jens.wiklander@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260629084507.3254232-31-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/29/26 10:44 AM, Jens Wiklander wrote:
> Sync Linux kernel dwc3 changes from v5.5 to v5.6.
> 
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
> 
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
> 
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
> 
> List of commits: git log --oneline v5.5..v5.6
> Commits imported:
> dad2aff3e827 usb: dwc3: gadget: Update chain bit correctly when using sg list
> 42cd5ffe46c1 usb: dwc3: debug: fix string position formatting mixup with ret and len
> 5ee858975b13 usb: dwc3: gadget: Check for IOC/LST bit in TRB->ctrl fields
> aac96626713f Merge tag 'usb-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> 85c009e8e5d2 Merge tag 'devprop-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

The merge commits should not be in the list, right ?
