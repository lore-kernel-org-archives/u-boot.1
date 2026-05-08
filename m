Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF6ECD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE35A84D23;
	Fri,  8 May 2026 17:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KA+pjg8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31F584D23; Fri,  8 May 2026 17:31:56 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F6284CF2
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bc1f3a393c0so325532666b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254314; cv=none;
 d=google.com; s=arc-20240605;
 b=kPQC9+PDGSecOjPpBPyaahjABLu8577rbIQfrZ2+cShhb4M2DcmkQcMsig7loSZ3nU
 UW+7VeufzCU9NEG8fqY6CpXMrU8m/7O+1BkUAQID/jjg5+g5uQ77JId2Sm7vJ8xPmMFS
 Q7erqSEjbU/5iwE/p/RcRe0tU6MCffhC2Gegg5LDOEQ+6wUVcOTrbgBEYr0wZHSBgogy
 uNpbjlbPba+5NR6HdKHH1cQz5UufPaxK6VMj06bfWYQzFZO9y4n96TBmyQ9pOSzpFxcf
 j1fxB7NBBCsk5wsrIKJdEQ9hislsq9lIqjkFmYgTBXj8Q5KrJ1ZW3gdIFzNeAPriBB36
 OKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HTrSc1cT7Wz0CgNjIqtfm1NMqzaOS2XnmtncLt+VcF8=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=ix0SXPfyo19c+4pS7eKo9PiyX7RXJFQXbgFiHIL4hYUTmifWY0UzqYLMWGXZVAx0HS
 x88ChEMGtbG0e+fVDwgaSiDRvKP5rd5ktL4ZGacoemtthLxLxa/Il8XwVX9m8iV6sve1
 l2AKSEahPQwN0h6phTrdbtGo6RxQJ3ThV4GcZKUR+ozFJ1f2o6UVI964W+RspXGHxiLk
 hMjPUoEiFiNtLCUBJg0wkeq+s0TRwH7sgXU5cx/PchglRwQ+2Im1c7laCOMXPeDhkwlb
 UazN3Mfwt63PCrb1nui44qmO0NMecKCgDqnVTgMa3KtsgtwYhit5AK5kOLx8LZlffpmK
 Xo2w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254314; x=1778859114; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HTrSc1cT7Wz0CgNjIqtfm1NMqzaOS2XnmtncLt+VcF8=;
 b=KA+pjg8ACFTnzVrorNz1/fsDn4dMGSCFqko9/AD0eeR6eme5xoFu8kTw2ZaEnDkGII
 k4BsXfViauFG2PQv+pMRp9OA9CG9ZZuNNcPzDnFVDzxrf1NdyW/Lb4h7mF2q+mnG+j1N
 dhJtbSEMiQdtrwJEIYvsqKAz23JcgyICz12J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254314; x=1778859114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTrSc1cT7Wz0CgNjIqtfm1NMqzaOS2XnmtncLt+VcF8=;
 b=CfgtxRW0TdNtngxEg6NDnYO+Gza7+ktTy9v8XbSFxfUkHNW2TpPkShZ7bs5JXDFsO9
 6c9EJVrZO3UZLq0KAKABFnzYO+TY8Dzksk0CPjl7EwFlz7iFHv8+rFwiMEP39E65s21+
 Lf3NhrzRIEVCsoDoD4ELCKVK8x9jsFHH8El8Ftm2jUcE7S7BlNFdyowHqSllpgVLJVwU
 OVB49TOlBiqbhqeuGB2l0YO3N0n5p4PYHlXDoONCa9gcALBoo7YqfUwkSW/3cIN9JNv5
 GWO8jvTXIrSVsTyLe6dlb4cN5AEWdxU0meK3llqALwG1PTEUk45WYDdR5VpF0Thel2m1
 Swsw==
X-Gm-Message-State: AOJu0YwCZkhkGuRfvDXOK13+Dq2Wpk8iFLTiEHemGITjIHRhWHbf5c1Z
 YvxLnV0J5nkJ9L0CCYN1hn9D5Ua7DtBETWQvIgJLjUKszOwn1YTbpfKwedtdbiTl2Ko4ysOWK1b
 GfZwyPXjDBXOjczWpdLCZgNK9XJVFcoiFrdXKOq7P
X-Gm-Gg: AeBDiesV3INnpsFlPRQuP+OAden02IQ/5a1H1FQVlW6RK+Lp41JJPwUHKWwC2kBE/8n
 Xy+ZUPAiG2tLSDxk+fqmASwtbNA5hSxPLhhp2BbG+iifu0ZS7tfO8fwOHwhd49FMY8cNMe5TD5p
 WgHVNZxC4lvwe13ugGppq0mrWguY9XKdxCs2s6mNYdovF1bl47HDLcCBPof5psXbjdOb0Je0Y1p
 wKqweCDSloVqRf9sWcghZHiny8/0377mVR5psNgiwnTHcCGOSq4jWkJok+Nb0quotEC2EVtujfO
 +YZZEw==
X-Received: by 2002:a17:906:99c1:b0:bc4:75be:62e3 with SMTP id
 a640c23a62f3a-bc56d137fc6mr790195066b.33.1778254314315; Fri, 08 May 2026
 08:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-26-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-26-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:31:38 -0600
X-Gm-Features: AVHnY4Lzl45omNBgvkNKjmQoRSUGvee6gvVC4lTfAhuinr3VToQ5RyilBaMDhDk
Message-ID: <CAFLszThV2=4vQ59Ug1TjnphTiFyZwmw8iVZU8rkX64qhtTFsaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 25/64] usb: dwc3: import from kernel v5.1
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
> usb: dwc3: import from kernel v5.1
>
> Sync Linux kernel dwc3 changes from v5.0 to v5.1.
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
> List of commits: git log --oneline v5.0..v5.1
> Commits imported:
> 7ae622c978db usb: dwc3: pci: add support for Comet Lake PCH ID
> 98bba546e82d usb: dwc3: drd: Defer probe if extcon device is not found
> dc8b2a691dc8 Merge tag 'usb-for-v5.1' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> c7152763f02e usb: dwc3: Reset num_trbs after skipping
> c5353b225df9 usb: dwc3: gadget: don't enable interrupt when disabling endpoint
> 15e99b13b44b Merge 5.0-rc6 into usb-next
> 9c7ebc99b382 usb: dwc3: haps: Workaround matching VID PID
> 1381a5113caf usb: dwc3: debug: purge usage of strcat
> 7790b3556fcc usb: dwc3: trace: pass trace buffer size to decoding functions
> 3aec99154db3 usb: dwc3: gadget: remove DWC3_EP_END_TRANSFER_PENDING
> 9f45581f5eec usb: dwc3: gadget: early giveback if End Transfer already completed
> 974a1368c33e usb: dwc3: gadget: don't use resource_index as a flag
> acbfa6c26f21 usb: dwc3: gadget: clear DWC3_EP_TRANSFER_STARTED on cmd complete
> 7c3d7dc89e57 usb: dwc3: gadget: remove req->started flag
> b2b6d601365a usb: dwc3: gadget: prevent dwc3_request from being queued twice
> a3af5e3ad3f1 usb: dwc3: gadget: add dwc3_request status tracking
> eca6b49430c6 usb: dwc3: keystone: Add support for ti,am654-dwc3
> 169e3b68cadb usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
> 54c9da1bcec4 usb: dwc3: qcom: Add support for MSM8998
> c9381e185fdc Merge 5.0-rc4 into usb-next
> cae8dc3b685f USB: add missing SPDX lines to Kconfig and Makefiles
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.h   |  12 +++-
>  drivers/usb/dwc3/debug.h  | 156 +++++++++++++++++++++++++---------------------
>  drivers/usb/dwc3/gadget.c |  65 ++++++++++---------
>  drivers/usb/dwc3/gadget.h |   4 +-
>  4 files changed, 130 insertions(+), 107 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
