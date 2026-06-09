Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2156CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 15:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3A684704;
	Tue,  9 Jun 2026 17:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="HoDG+1lS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2644A8485F; Tue,  9 Jun 2026 17:17:28 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C2C8466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 17:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1B358115D27; Tue,  9 Jun 2026 17:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781018245;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=AiqTvSq3OZj6a5qF4Oe67up3eJzkhh4vNJl9FzDBRQg=;
 b=HoDG+1lSwb/sZfWx/cx1YdnfG++63Lbe3bceImlVyW1NlgSrL8uzO4PvB5n6Cu1snBtcwN
 5PTzq1938E9C1gUJ3Z8LSTKz+AtJN2LpDT4+f4oHnLr4ioAmVHt+g+f575+RCLV6SFsFXg
 vG6DL5ffvxUcncQ1UyN7bP0wPMqspUCAd6VqYEd/bDWYEUXXDjKlIqQqsCvyz+RHBGEMQa
 FxNOHjIEVLdmuzZFXh5b5Ln101OKeIN9kT8k4zSXkDmDxME7ijnzWAwSpp5X0WWcVYfGJc
 bx1RpgaQO+JhBnWXAg91Cd0/GSkc5rt83mb23J+DQwT2jWF212uVFZ12KCN1/g==
Message-ID: <901d5ab1-3597-44f5-ad40-9ad022b2d2a4@nabladev.com>
Date: Tue, 9 Jun 2026 17:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
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
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
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

On 5/7/26 11:27 AM, Jens Wiklander wrote:

Hello Jens,

> This is a follow-up to Jerome's patchset [1], addressing previous feedback
> regarding the monolithic nature of the driver update.
> 
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> to u-boot"). Since then, not many kernel changes have been ported back into
> U-Boot.
> 
> This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide
> a clear audit trail and maintain bisectability, I have structured the
> series as follows:
> 
> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>     to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>     a "snapshot" import of the drivers/usb/dwc3 directory for every major
>     kernel version (v3.19 through v6.16-rc7).
> 3. U-Boot Adaptation: The final commits (based on Jerome's original work)
>     re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
>     required for U-Boot integration.
> 
> The final diff is identical to [1]. I decided to stick with that for now to
> focus on the method of how we import or update the code.
> 
> Note that this is compile-tested only. The CI pipeline on source.denx.de
> was used as an OK/NOK indicator [2].
> 
> The previous patchset was tested on xilinx_zynqmp_kria_defconfig and since
> this diff is identical to the previous, it should still work on that
> platform. With the help of a custom build script [3] and with an additional
> patch [4], I could boot the Kria KV260 board and make it detect a USB SSD
> plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> platforms using the DWC3 driver are still OK, but at least there is some
> hope. If this breaks your platform I'd like to know, and if you can send a
> fix it's even better.
> 
> I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. There
> were a few conflicts, even when backing out the original U-Boot patches on
> top of the original v3.19-rc1 import. However, the resulting state still
> diverged significantly from [1].
> 
> Instead, I've imported each new kernel in a separate commit. That way it's
> very clear which kernel patches are included. Since there aren't too many
> patches for each kernel I'm listing the relevant commits in the U-Boot
> commit message for easier reference. I did this with a script so it's easy
> to make changes, if the approach is OK but we need to tune it. With this
> approach it should be easy to tell if a Fixes patch for the kernel might
> also be needed here.
This is nice, thank you.

Could you please send a V2 with the current feedback addressed, I'll 
load it into CI and see if it passes.

Thank you !
