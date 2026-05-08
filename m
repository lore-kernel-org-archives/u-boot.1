Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EA9CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA0084BBD;
	Fri,  8 May 2026 17:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G5emv8eH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C6F584C55; Fri,  8 May 2026 17:25:22 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71D4984B0E
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bc188a20e0aso286320966b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778253919; cv=none;
 d=google.com; s=arc-20240605;
 b=NHc80qqXdE9yxC5Dl4+Vaq5hgu/0CNjU7vwq3Kie+GiTlFNCeXBnzzRGffpOWzr0uW
 HogudRYRTYseDv5RsrV1vMlLgN25+hbb8bpOV9VoltXvalFd4nYN3qur+mD/UjAJVTzH
 9anEi4ppXjs0IiJVVqG0rerx8i6OEM3CEFoNA/NXaj7/eDkcbonw1kifA/0cLD8ZmbFX
 oy+Wo33spa7/FNml6+EvTWCfFY9LYMYa7bWtsOGRFyJqrs5EpA474db8wBBWNvqHEp6c
 UEQ/KPn9GFzwXocH3ZmmpamyNBBE7C3jrg/DnUkklRVQ5pfW1r6FKHqgsu3KS+28Z5F8
 1+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1OGSH/P8HHVvBzSa62pOuByjh6yqZ5G1+nTEpFJZJG8=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=QZI+iksiL0AVQxEyi0m+NSnClT+ndxIRqBCCpKsIX17H+bbbV8kmthw2dsmzfu/73l
 uC2B0mqb3dGNTurMUc9mIElLZn0jm2M/M6F3vXGi5ZoL+B3zqr6tNSrPEQTYxVmephFw
 Q1oYehTe9eqwoSyliz5CcIJU7t1a5LNGTaItg4iVLvCSXa6yunnQhTYOUV3qycGs8vjm
 Rn58vX7mN7kh9/HP6kjbnq06NtkvZ/WDsy7mZ1McKL6T9othOCSOgXq9XfOftoYZJ/e/
 FmuJk9NvoFPGsGyMzsMCJcJlcxmTtOBLXg+h+Vx7vh2kB0RRIitJNwww0d+6cV8aKoV5
 VMMA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778253919; x=1778858719; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1OGSH/P8HHVvBzSa62pOuByjh6yqZ5G1+nTEpFJZJG8=;
 b=G5emv8eHPOKasAmYlCTj4z6XC5ghsOA8NlmO8PXbddZIuoMSh+msJkE597xvJB6y1V
 iOmYB1qwTPNxwmECCXwnJaKQ8C95Cvm1xwCyWCTvuFwTEYaO6Z3aOExwxytLi3/m5pu1
 ZTcDAPVRDK5MJ6f2kVqz4vTGhbh4J2lTSc+4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253919; x=1778858719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OGSH/P8HHVvBzSa62pOuByjh6yqZ5G1+nTEpFJZJG8=;
 b=A79gNSob9bM9i3fsTScHQ+Z2CITcq9ybjSJu9WU4bpPqSS02ViNwKR7LQK43Q+OI6o
 SmwvfEmRkZE1uwNh2T/kuqEjHEKCJ9kCw14D4LiaU/4UI3plJNaYKhT0t2HLaGD5/jjm
 T6UxsKMACQRoJs39Eex5vBy9BRIKAywxvkYtD8igil4qbxxf/7WkZLPHAJPfUlHB6cFf
 RgMbpmrica3qbYW8pP61Oywu4jRAefGPYZwebjUkLSLH16Mq5PwDLrZpm13pMqja0tZF
 rftMZmaps+qvPRiBz45MjqMIOOaKpHwS87iVJ9joacrToZryVy4ffGgMNp8oL/QGr1El
 gdhA==
X-Gm-Message-State: AOJu0Yy5PA+OCCdYIBQj0BAV5wHnhu6QMDQlUkhIVWceBkYndHfhgvHQ
 SaahEjt3+1JSNodOm7qGZ409hzrryOsvFPQNLgC30SXy0XUGW1kuCfaqWUlX4YQ8agvHCgVRSHU
 fmTCf41CFDmcFue3zGyx6xC5hoI4RZzztrWOb7BvQ
X-Gm-Gg: AeBDieut5REsBgb21DGNeQZkRmFW4SSzOlrLxIlNXa8PLwonghq+VfMohK/FMbDEwZA
 afe7pL7hlAuIzNRuG1SXIB2UgGV2+0LvtZAKHLjCmzj+W3KderC41Dz8gMA9E/u48Ym1E+d22jQ
 Hn0MCDpCspCs5BjlH+9AEqPKar5FYwOS/FyJVDwIZ+0HgEZcQY6M2/t2Kbg7AHvBPN0lvE1QqWU
 XOfDCZUEcWP2R9ywNGNi8JK572fenr3xV4aQDb1jFieUDIT2OU6+RgAdMFCych9tVSg/jsTjboX
 1iDsAwnrPArd/rwLq/dIsgMcZYA=
X-Received: by 2002:a17:907:3e8a:b0:baf:e47:1b6a with SMTP id
 a640c23a62f3a-bc56cd3a9ccmr842509666b.24.1778253918978; Fri, 08 May 2026
 08:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-3-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-3-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:25:03 -0600
X-Gm-Features: AVHnY4LXNkU6D3yv45tKHTOUXx9Nk24if5OXg41eGqFeMcS9dlGkLTinHMOUceA
Message-ID: <CAFLszTg266BDVtf0XzdJhbFEQD=+LHB7jAaPHk_N_MN339f_TQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/64] usb: dwc3: import from kernel v3.19
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
> usb: dwc3: import from kernel v3.19
>
> Sync Linux kernel dwc3 changes from v3.19-rc1 to v3.19.
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
> List of commits: git log --oneline v3.19-rc1..v3.19
> Commits imported:
> 39e60635a015 usb: dwc3: gadget: Stop TRB preparation after limit is reached
> ec512fb8e561 usb: dwc3: gadget: Fix TRB preparation during SG
> 84a2b61b6eb9 usb: dwc3: pci: add support for Intel Sunrise Point PCH
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/gadget.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
