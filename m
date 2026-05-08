Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772A0CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15ECA84D0C;
	Fri,  8 May 2026 17:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bGEOFmZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557B384CEC; Fri,  8 May 2026 17:28:04 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6921884D0C
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so3884830a12.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254082; cv=none;
 d=google.com; s=arc-20240605;
 b=GbI7QppBkDw1gGt8gBAo/ze79p7vlcvZ6HydSGSUwSOwn+IhO4fXb3+NHN7GIyYDkg
 JwXW87knwEo5yAs7MFU5Aq7fvPpL2GpqADmPCAg/70lYbRmMNqdgtY9eEjBlSqDmbsdm
 uEFXJjKL4+xAwbFA3h6jtpJQpW81GW64vN/OZ9Jz0W8tIKsrrloSOh4NX9thfM4yxlDf
 LfuVO8kVUXCh2aml/OhPBIG+vS5AUh2jbMJ8qsICHHCd+19fmvz6ex3DIAR8NG2pFRaw
 A1ez2dlNYpA0hY/a8VDfHzS5rO5qMD3atURKAIRNsm+hIRWg3g0OIeom+tQu10lWV3qY
 tsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k5EMNQQk/uYAC0L+Rv+3+ZxCNsDsHYQ3ARvng+VkCKw=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=kIg1PjrKVa3RTQtx9IEPUK/J7Oh5zwOmPVL7xggalxKhVB/of2TekzrzqKYSVTd5B7
 utz5FJ9JFWTMA48w9N4jmgltv2RaNXjLUqvv0kuouA0WeDxpwTmpSwu4cyMMMxdFa+Fd
 Vj+Cw+BUXJXSZHvX2pWjz4ahB7FLOLWqZLMEXeliIkYKTn9aVSMZIRAte7Yf7GVZOeCl
 ZRL3NDmCAsqD4Oqdepfj9YJcpfRYYgqG9Ekji4iaIYUfbPL3Cz0ETfZaeW8lHwj7DjcU
 3CX+TOOmAHbRIcRZR/ahBwqCgRepPXDl1DySXN1Xpfb014ELgjSCJYP6sTS9D04SqqIc
 MgzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254082; x=1778858882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k5EMNQQk/uYAC0L+Rv+3+ZxCNsDsHYQ3ARvng+VkCKw=;
 b=bGEOFmZBaOwrjDPjdDuvsq4q2ZZSs+kySrVAOikYiZa0DFNOfKfTSD3T2bvvaCHNW5
 GcAFGf2grxb7t8/4S+A0OfhcO4/csVE58HAih04BY2ovdo9UJiKSml8JtWF9/wZP6tyb
 3qBTZvkjTxmZbolWRuV2LTGRw+vaXm3arVOak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254082; x=1778858882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5EMNQQk/uYAC0L+Rv+3+ZxCNsDsHYQ3ARvng+VkCKw=;
 b=Irc4NLbc5Po6Apf5aNVhwoSqLyo5jtOG+otZ9tqXejCWZI48E2qr2B6eB5jnJaWlR7
 E9Am3pVTBc7foo5bCPjEihKmQEAmbdf1lhkWlBQ4TjGiM3yd6uXBwfj/GkpEmmoiM17T
 dGgQdKcayrkRdpEN9929udrhB4cLxB3OXpa0RNQMdczAxtEc/d056tCbceOVhUtHop5M
 CnD3pqXCQjsLA6OU8G7e/fqgRyLA9FuKvlcuyTP6fZiXz4LOG9E692fPteiXmyz5GHki
 VMsTjAuec3iHn5HByHdX8X/u6nprMl9Oe6sH6XX0lDuMVDjVzb8Vf3UscaRwO/wbxAWN
 wzOw==
X-Gm-Message-State: AOJu0YyGHIdr+MaLDl/pYAk8ZtEbkG1bRMXZhfBdCFg/hBQzX2w/QXUX
 PT2eWWXVwTZynjCA+3dNrbkyln027bPh5A7rLZ0yrZOeguKf1mc7syGbldOTZy52Ha66oupmgsF
 OZEOz7E8PfrUJXVMJQLF7x1SO2SmvCU2c0z5SEM8z
X-Gm-Gg: AeBDietH4JBRUYTGi5FMUy5emca/XBlEtQpLCE+yxrZ5sYUwEgU8wWS7BS4h1n7hHIU
 2mH4+2UeEO2mY0v4UX5rZ3nEUIlAGFkbItWK6jAj820pWmhYsESmakHRpu8w6g2QyPGtXbWyVwU
 MnY+14wo8IeeAI3UOE6yNMyTa1sCzg81ySk1yP4CMgK765Zbng3ZUy8x62t4aM2U68/H/UqGASZ
 99EyL/JGZ5qsdnvlFzJDQvHF9rGpN/7Uv83wwkEth6MOqQ1bKR2nnY03VuYTB3tKp0Ahuo57qTt
 7WW6/A==
X-Received: by 2002:a17:906:6185:b0:bcb:b796:fb18 with SMTP id
 a640c23a62f3a-bcbb796fbf7mr7720566b.41.1778254081721; Fri, 08 May 2026
 08:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-16-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-16-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:42 -0600
X-Gm-Features: AVHnY4Jn2pbEkydGk-m6wv8bEWIFd0CYHB8w1Ul0aMgVkI3TExXjoFHJYKcw8JM
Message-ID: <CAFLszTiK-E_OUQJJOJmr2JJDQtsQoLvgW=vau-KHcgg84exwMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/64] usb: dwc3: import from kernel v4.12
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
> usb: dwc3: import from kernel v4.12
>
> Sync Linux kernel dwc3 changes from v4.11 to v4.12.
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
> List of commits: git log --oneline v4.11..v4.12
> Commits imported:
> 018047a1dba7 usb: dwc3: keystone: check return value
> d325a1de49d6 usb: dwc3: gadget: Prevent losing events in event cache
> f1d6826cae30 usb: dwc3: gadget: Fix ISO transfer performance
> 682179592e48 usb: dwc3: pci: add Intel Cannonlake PCI IDs
> 8f28472a739e Merge tag 'usb-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> 2bd804017435 Merge tag 'gpio-v4.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
> ba7756d08212 Merge tag 'usb-for-v4.12' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> 9840354ff429 usb: dwc3: Add dual-role support
> 41ce1456e1db usb: dwc3: core: make dwc3_set_mode() work properly
> b202c42cbf81 usb: dwc3: debugfs: remove unnecessary | operator
> 6b3261a27428 usb: dwc3: core: add current_dr_role member
> d6e5a549cc4d usb: dwc3: simplify ZLP handling
> 4199c5f8bccd usb: dwc3: ep0: improve handling of unaligned OUT requests
> d686a5ff6a2d usb: dwc3: ep0: pass dep as argument to internal functions
> 7d5e650a5fdb usb: dwc3: ep0: use immediate SETUP on TRB
> b5c7ed5cca82 usb: dwc3: expose dwc3_trb_type_string()
> 90abb425d949 usb: dwc3: debugfs: return strings that match tracepoints
> 26c9f3e391d1 usb: dwc3: debugfs: make use of dwc3_gadget_link_string()
> 2df301cd3d71 usb: dwc3: debugfs: downcase OTG on 'mode' file
> ff3f0789b3dc usb: dwc3: use BIT() macro where possible
> aad7c2596495 usb: dwc3: trace: change format for string to cmd trace
> af771d731b8e usb: dwc3: gadget: Fix starting microframe for ISOC
> 3a932b0f50f4 usb: dwc3: exynos: change goto labels to meaningful names
> f3bcfc7e68f0 usb: dwc3: remove dwc3_gadget_init_hw_endpoints
> 47d3946ea220 usb: dwc3: refactor gadget endpoint count calculation
> 8261bd4e91e2 usb: dwc3: make macros safe to expression arguments
> 05428ba983e6 usb: dwc3: remove dwc3_log_msg trace class
> 1966b8657d05 usb: dwc3: make sure UX_EXIT_PX is cleared
> e47ff590cc57 Merge 4.11-rc4 into usb-next
> 4a56e413b50c usb: dwc3: pci: Switch to devm_acpi_dev_add_driver_gpios()
> 2c93e790e825 usb: add CONFIG_USB_PCI for system have both PCI HW and non-PCI based USB HW
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c   | 109 +++++++++++++------
>  drivers/usb/dwc3/core.h   | 261 ++++++++++++++++++++++++----------------------
>  drivers/usb/dwc3/debug.h  |  28 +++++
>  drivers/usb/dwc3/ep0.c    | 151 ++++++++++++---------------
>  drivers/usb/dwc3/gadget.c | 218 +++++++++++++-------------------------
>  drivers/usb/dwc3/gadget.h |  20 ++--
>  6 files changed, 392 insertions(+), 395 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
