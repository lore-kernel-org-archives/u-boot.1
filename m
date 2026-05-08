Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B3CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B1084CF2;
	Fri,  8 May 2026 17:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PfJBStMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87F684CF3; Fri,  8 May 2026 17:27:43 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3851084CEC
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso945405a12.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254060; cv=none;
 d=google.com; s=arc-20240605;
 b=fu7glULSBaNxbdKOVHMIdtA2qTAsIP9ZKcZ57Uzvg0FeZqKeTd096JXO/9KcTB1f9f
 qTJyvdihvJZ0D8FxG7f5ntOSL83BR68n9kuw3kk9BJ/6IUt3G0V2bvr7GvI0GO0s2Xr9
 tUoLnFT5jkBXbCsrMQ32EIm//epxdWpgo/mDvRndVJbhC0RET9FJfeHNokg/th53QkeE
 w7XMvlmXMhUyJPz9CBgv1c9hudgQh/N0W3SCNAD81KnSIXI1OVD6OzjPDxRcJG73lqga
 /bhgzWFOU9CPHWtQIQQer+Lhcxd917CDoM7YWBrmjnd/lBw4XHTO/Bu6rIJB0LruaQwa
 vKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wxx9g+Ho7Y97kc9DBHd7vddrpaAfivbXNjlRSOS3DB0=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=ZYwt7x8fuBGFm0YdRkYvevpf6WDddh7HcSa0QcyanZFdRRjcwFlki2zf01JC6VTYJ8
 OpMyYTNm6IH5gwMfS1JL7m/In6n1Dzu/9NXIfIrYnjPHobaRZvfxox9Db3UNUBUmLJEt
 oXN/uirEV9yK+bVfWwAAZQuBn45EiCRxzZh5rkxaDtZs1fg5fLzLO98vmONgZcCySW5t
 YEnXvF++Eq0OZZYJNIroTfRyLyIUK0doKepsMCdHQiaRLe4XLIKJgl2CNm1Vrd5afFDU
 abiuGby/PjCD3gS0rOzwEBJaYhekZCHiKgAQunlzUD95V2oQq/EDunOOICq41Y4fSnpS
 97cw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254060; x=1778858860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wxx9g+Ho7Y97kc9DBHd7vddrpaAfivbXNjlRSOS3DB0=;
 b=PfJBStMDWnn0AETwnA7FZWdmDwZAccvhTzbTKf1lYySxCBuM8v1C8rdgczDRYhoich
 nB6+dP2x/DvjSlYOM6kdfRaz6HN66TArE1WwkhY3cYEIOlXaVQDi3Sz6a5gQW9TbhhSi
 ipBNRPR3sZTVU9OPgKoyYNM+RQyUhkRZOP2+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254060; x=1778858860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxx9g+Ho7Y97kc9DBHd7vddrpaAfivbXNjlRSOS3DB0=;
 b=BMSTg/r9SZSozmwN1rwmA61FP+rjn+U8PRWwwjRi1OIbi8LUsoSbWyQgOrF0506rnA
 xKImdy7zMug5NYb19uVaYibtCUp58B4dyYOszLx/IfOHIJbzi8/3zu2QBej8f+1IqeeP
 4LcfRg/Y835Upey/K9rF+Fy5qK1Lc1t/2bbAvXxK4lgh0eoTIJu8jSuMcaYQPAMXYrFb
 9EQvUPf+7KC9wN7b7TqZoaMGQLXsEZtOm/p/lRw4BIIUmEhQlP637Po/xSxrUre5HA3n
 Agd+TxZ1ZtUmwZz50pCDBGK1iW8L7bhD/rro/4CpHbD90aK7ixjykgGSKrYRcCr6zFB+
 RAkw==
X-Gm-Message-State: AOJu0YzZljE8deNRydzYIWOrUOk5ZNUxoQDya/279apF8xlFRvUQwZ8I
 VAM4hStGbuqM33dcyE8WCP/9BtwcBQ017bg1fz8M4t5JCMAOv81rraocOm+3l6KFZRdK+0q4051
 PUWWEAv2Df+/G96GgTs0kW9+ppphI1mKztc2Zfis7
X-Gm-Gg: AeBDiet33h/XrlZdbVBdNH8wp8Et0ok0BSgNA14yUfyUDI/62m9O8rVEghpCmKuhdEw
 62NaR4qx4Wf+bUTQSpUtwwTY1B00a/xW3rBQSuA0p7ro+KSv9IZslAKE9iF8EXVaIYPOhhK8PVa
 CUKQYQ5H0gSW8ggQGhFxPVkAEsUr63zTLj31g4BVQMS/b/nWclnocPdYRlg8Wof2eT3djbbdfna
 E9HGyReVFC+AK52m3seUKS8LCVjBpxUrL8sQgoQ6k3Jsw1yGjBXGUThsVUT9znRlO9yWfUVaMre
 91r43Y9fqEOQE1em
X-Received: by 2002:a05:6300:210a:b0:3a2:dd8a:5087 with SMTP id
 adf61e73a8af0-3aa5ab86d84mr15129907637.46.1778254059643; Fri, 08 May 2026
 08:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-17-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-17-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:45 -0600
X-Gm-Features: AVHnY4ItJWp5m3bVj7piJIg2EQRdwE-mf1sZH5X6SkUz0JIkpgjqvOZCDD1ms2A
Message-ID: <CAFLszThAyVnts3aPgmpyxinbZMuVfxNQpr_kV641SWoNoAwwpg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/64] usb: dwc3: import from kernel v4.13
To: jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v4.13
>
> Sync Linux kernel dwc3 changes from v4.12 to v4.13.
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
> List of commits: git log --oneline v4.12..v4.13
> Commits imported:
> 40d829fb2ec6 usb: dwc3: gadget: Correct ISOC DATA PIDs for short packets
> 4a71fcb8ac5f usb: dwc3: gadget: only unmap requests from DMA if mapped
> ee249b455494 usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq
> 541768b08a40 usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys
> 408c9861c697 Merge tag 'pm-4.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> 362f6729cbb1 Merge tag 'usb-4.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> de3ef1eb1cd0 PM / core: Drop run_wake flag from struct dev_pm_info
> 24040a58379e Merge tag 'usb-for-v4.13' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-testing
> ece7af5f787e usb: dwc3: exynos: Handle return value of clk_prepare_enable
> 46b780d46bcc usb: dwc3: gadget: increase readability of dwc3_gadget_init_endpoints()
> 958d1a4c40dd usb: dwc3: core: program PHY for proper DRD modes
> f54edb539c11 usb: dwc3: core: initialize ULPI before trying to get the PHY
> e0082698b689 usb: dwc3: ulpi: conditionally resume ULPI PHY
> 9b0a1f95c4b4 usb: dwc3: ep0: make sure wValue is 0 on GetStatus()
> 7d8d0639565f usb: dwc3: gadget: implement ->udc_set_speed()
> 94116f8126de ACPI: Switch to use generic guid_t in acpi_evaluate_dsm()
> af32423a2d86 usb: dwc3: trace: decode ctrl request
> 3587f36a125f usb: dwc3: debug: remove static char buffer from dwc3_decode_event()
> e42f09b85f20 usb: dwc3: trace: rely on __string() and __assign_str()
> dfc5e80578f2 usb: dwc3: gadget: slight cleanup to dwc3_process_event_entry()
> 436841d53dd7 usb: dwc3: debugfs: slightly improve output of trb_ring
> bfad65ee9be2 usb: dwc3: update documentation
> 04fb365c453e usb: dwc3: replace %p with %pK
> 6acf116c9558 Merge 4.12-rc2 into usb-next
> 65db7a0c9816 usb: dwc3: add disable u2mac linestate check quirk
> cdb55b39fab8 usb: dwc3: gadget: lazily map requests for DMA
> 202adafe5a6e usb: dwc3: gadget: don't WARN about lack of TRBs
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   |  57 ++++++--
>  drivers/usb/dwc3/core.h   |  48 ++++---
>  drivers/usb/dwc3/debug.h  | 247 ++++++++++++++++++++++++++++++++-
>  drivers/usb/dwc3/ep0.c    |   8 +-
>  drivers/usb/dwc3/gadget.c | 340 ++++++++++++++++++++++++++++------------------
>  drivers/usb/dwc3/gadget.h |  22 ++-
>  6 files changed, 549 insertions(+), 173 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
