Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DA6CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D3484D13;
	Fri,  8 May 2026 17:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LW0mow4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0588884CEC; Fri,  8 May 2026 17:28:06 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0388984D11
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bc356898256so369779166b.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254082; cv=none;
 d=google.com; s=arc-20240605;
 b=FY6QKIA2NeYu2loDpbFBniBq2h0skTZ5NyfXcjie7fTYzmTC8+ugRkFHBYDuCOtHde
 Vbm6uqODnSqfM5ZZXntGQW28shjNXki7NzdJlt59k8T/pMNVgyvzqGFYR+FWJMgAusQg
 18WuK9cVYzBbemXBLQdwXiXvDmuIgEDxi1CbYKaY+XZJviSb5+IznxOQBkt/XrT+NYl+
 cQxzr5IN7TJW5SSlt7Ls8TUJm8N/nSNmkI6J6HsD2zeujqI4Ad3zQVX+WP3iz2Tg76Js
 nH0pKAS7lJ6vaMJ6YJrpZC7dXiM9gS3rV9YgSjc2yYNaWHN9vLm1C4VjypftaF/RMVp9
 Vwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RPiRSDgkbw2zGes5U1Z9w3qd+pqaaoEEFGnX5BtMMuA=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=CK8SyaPo+SZ5/HdEzQJBPYIJk78ytn78ki7NaH2j9WzWxHjdJpfqf4peatW/ZP3zUf
 m1b8WgBraW++BBY8hzvWgJLQQYXbkZWzCbDJr1W6zcfKP7Z7ugFrIsdVL0TV3d3iRw9B
 eNJG2tQZgbmbuEY+5AGbc9tvCM/aDqrBZznaA7zZKrSHvVRhM1+eUVDf9hoc/SSNHH37
 NqJDj+qBfvDZFGHQMeFONnHJJ4SjMGGzHzqy3PDdigHBcJTE96eBepQMofyjK7+zuXd3
 KbHt2bkpnlqCqaE3wlmQIVGb2/fAodQlVFJ3VCyd90BLNx0h4tmPYyVUC3Sts/555d1M
 kC3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254082; x=1778858882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RPiRSDgkbw2zGes5U1Z9w3qd+pqaaoEEFGnX5BtMMuA=;
 b=LW0mow4TZ+bnZSy99Lj084Yv9UF8hroMtIMg8maLMMOkD9qv9HpDkHL5JbbWcmIXNM
 EF+akSgzzJ9QqEs8/lEfieqPi0AJNE+f8W7us+ksOh5+Hbok4eqIzcbB0Jv5ijzrawRE
 TQRdMzXZbMpPZPq424sqbFWrXJtMh7gI3BYtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254082; x=1778858882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPiRSDgkbw2zGes5U1Z9w3qd+pqaaoEEFGnX5BtMMuA=;
 b=Nr9J9lcLjmaDPGUh4QV4ZjC8r3OKJpbx7y2Bgke51m1pzU8Hn0rp9AHSiZGCeS/RFk
 JjnfD4m9aZGQH6zHC0rqXSd0Xr9bPhp+HhfFyrOU8cnj/kuPiQMvbFSePSAUaTvEhrNb
 lBj1l4TyjqQavsWzt8axWAGTMbjk4pkQpO1CYslt611pUz3i+QklOMWuRarkCvSdKenW
 slAUaLILx3RNp4fMhm0nr3MQiObqp9uZ2XVxhPrrCtInB/wn37naImv6aSEm0DMC6TdY
 AkU+FmId6iA+bqOrWSqPaLOZLjHpxJGrweM9322eshiVX1xnwekIfSHMEht8G79qObxI
 CT+w==
X-Gm-Message-State: AOJu0YxNoYB03lWbQCWlj2sODE1cW0Qb41YbvjZ5cn/TZT6RD4WpB203
 ARa7J1HKnvE/TwqvXMGeuC5tkqoDagMs+SNAWm5olyjTje/BoBisY1DoV9Kv5Ff10xKhl3ptRkT
 WJ/F93ashnflCiC84mvtKA6k8UQh0cd90Owg4wA1U
X-Gm-Gg: AeBDiet3ykeu6h1r3QWa1fBJA699QVphBNV5ZQDl9P1Tu4ArOLauu09Bh6aMhFsLpuu
 MguQKJqPtu9RQ0LzAQ3RpPs60F/44qoNMmtW9zkpei8VUGpshiBQiryLmk46uZUHsjMMnWazVmk
 AxP7A8v8ZWhS9MWnFZ6dR98S7Joa624JqI1rURAhujzSbp4FvmyQbISNrMlyHzC5tJM/YkgAgFF
 vSuG21O6T8t0uo60EXBKlgWf96nSbIgwpJCL8JB+eRqVABchj3qaE3wdk7VWOvsHSnh/rjXtOIf
 c25GGQ==
X-Received: by 2002:a17:907:7b8a:b0:bcb:9a08:fffa with SMTP id
 a640c23a62f3a-bcb9a090128mr35946866b.23.1778254082397; Fri, 08 May 2026
 08:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-15-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-15-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:38 -0600
X-Gm-Features: AVHnY4Lv45FL9zL97_TxErNdCSYEo5yf3DUc4n-Ydw7-GBQeEKmQdGnwNhSFryc
Message-ID: <CAFLszTjQBxNZLmUiTfw91W7rMwGHzzx+uDscrkmM+-A+YMmx4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/64] usb: dwc3: import from kernel v4.11
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
> usb: dwc3: import from kernel v4.11
>
> Sync Linux kernel dwc3 changes from v4.10 to v4.11.
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
> List of commits: git log --oneline v4.10..v4.11
> Commits imported:
> de288e36fe33 usb: dwc3: gadget: delay unmap of bounced requests
> 35b2719e72d3 usb: dwc3: gadget: make to increment req->remaining in all cases
> 0913750f9fb6 usb: dwc3-omap: Fix missing break in dwc3_omap_set_mailbox()
> 1551e35ea418 usb: dwc3: gadget: Fix system suspend/resume on TI platforms
> 73561128eb72 usb: dwc3: Fix incorrect type for utmi mode
> cf3113d893d4 usb: dwc3: gadget: properly increment dequeue pointer on ep_dequeue
> 7369090a9fb5 usb: dwc3: gadget: make Set Endpoint Configuration macros safe
> bc46e23c3425 Merge tag 'usb-for-v4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> e42a5dbb8a3d usb: dwc3: host: pass quirk-broken-port-ped property for known broken revisions
> 28781789051e usb: dwc3: gadget: read IN ep FIFO size from HW
> 692665c621bb Merge 4.10-rc5 into usb-next
> ffb80fc672c3 usb: dwc3: gadget: skip Set/Clear Halt when invalid
> 538967983b88 usb: dwc3: ep0: Fix the possible missed request for handling delay STATUS phase
> c773bb0b9264 usb: dwc3: omap: Replace the extcon API
> c6267a51639b usb: dwc3: gadget: align transfers to wMaxPacketSize
> 905dc04ea796 usb: dwc3: gadget: allocate bounce buffer for unaligned xfers
> e49d3cf4926a usb: dwc3: gadget: extract __dwc3_prepare_one_trb()
> 843053093f47 usb: dwc3: gadget: simplify dwc3_prepare_one_trb()
> 0e4018ff5d12 usb: dwc3: exynos: Remove MODULE_ALIAS()
> 3e27b3f66a56 usb: dwc3: exynos remove suspend clock unspecified debug message
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.h   |   5 +
>  drivers/usb/dwc3/ep0.c    |  14 +++
>  drivers/usb/dwc3/gadget.c | 287 +++++++++++++++++++++++++++++++++++++---------
>  drivers/usb/dwc3/gadget.h |  14 +--
>  4 files changed, 260 insertions(+), 60 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
