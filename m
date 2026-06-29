Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16ACC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 19:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A8584A81;
	Mon, 29 Jun 2026 21:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MR14ubxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20BC84A9E; Mon, 29 Jun 2026 21:08:23 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4800084931
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 21:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-664e3ed58bcso1011281d50.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782760099; cv=none;
 d=google.com; s=arc-20260327;
 b=npX3L8zDrrOh9H9LTMecZpH5YQdmIwtRvFbVOo0/Hb6qU483b88Kqm8OP5FTlvCWlF
 MrGOJMSzfrLyeGR3AH3iQvPODVp8CRNgCSxiGyqlsndWFKteeWDM1xBDXerV8k/oCC6z
 tZEbIeq66T/Si/uearfcHkmDwXvnvrjKFHBEE9fYKt59j9IRNu1XAzwXFO5e9cGdw+E8
 rwwenoU4j7GW5Q17xMCMyCnRKrHbz6R1e0HPnu+pTTH8Z/+AyDRIKp9tZCAJR9pwSiKC
 gRs+/aU/CQqirDU9swtqHiN/Xf0NeAO5tIv0KGg5Hp56/zwxqNOSnRyPSuNRNReQjJ5O
 O9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MeBaccUNDK1P49T6xEa6NuC/sIaT8umOOstkU4f3jl0=;
 fh=ojZ4C6AiUc7ffkyOwzORAyX7yb3UlI+hws0oMiJjoWU=;
 b=jIP8toB6MlFb6XGFGIhn/pOVj7ukQcEImltCbDF2wA2lSzFVeqAERCC7grVkTa2rxq
 7goIX9ddPMqy/vCwnQbPljaNRDzVfzzAAoznGglU7KlV8KQZNaipVylKkk/vz9xheb3u
 s9ZLxaodyIDM15vVmJJAU2tGA+qQycc9Xql6dC6diFpLQMzJ1pQX9yg5te+/EdVmGTMd
 i03T566t5AP8enu//aAV2YtNi0KEKX+d2F5wLSClX3UeypLymQGYIHjhBcHeqDg+/aWV
 n83JNHFSFZDRO7eEZiFpFQraQhaOaH3X9CYqXdixKernU6AGq5gHIAhGUp+FOzIGSIpK
 Y2fg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782760099; x=1783364899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MeBaccUNDK1P49T6xEa6NuC/sIaT8umOOstkU4f3jl0=;
 b=MR14ubxr19fXR28Vf4HWBzmC3+UMuLleo+q1ofia7E5uEKnXwi2nn2OemDENVKevc6
 jhcoqtPag1/k0MNg0dy9VJ6ei/uMg7B1pQJn0saRc8iNaW5ERiSl+GRfiRNqkITlFYOC
 2LZ0n+SwEEZ0y2SeCnwfPHXwHGrn8t+G4QY1Lybr2YIYYsxBYqnYKd+edrRYjjNgZDaU
 LyTPeGcIoTb0KuAdBnsQ5kvsl3RIHs7/pLQRJtBQbCYXbCtH1247/IaGRMMEKXoZcFVu
 wYzgbZ84fmVaVoUQjyKmowybVLOBVou9AfOFAnWbmKwH1ID0EQTKKv4cIEBkX8TUEee7
 AjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782760099; x=1783364899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeBaccUNDK1P49T6xEa6NuC/sIaT8umOOstkU4f3jl0=;
 b=WZVhL9OdQNHth6OqAY4yKlvH0ZbM3PtEPX9+B6fj78hdIN/BsUE1z7+EZpBBbNWamV
 CQAuEINSVSfJ9/Bc/lGl/+75FXdMRXP36pUqXS1FFpUOMorVBhHj65mKgfk683Apf/VS
 2wOEcbuQJuAnQM97C+foY+sAeSslZitxPd+T7mOr/rMFMLx0uLpBVYPliG5bBxl+/gf1
 DJnFyQ0sguVOWnmdJT+EUgLimhnEkF01cOQyk5FN+f4+rflHvPb/GysfBCh+YWm5Anyd
 9yDaSmfetxWTkk9W3Q/ZleKkynaH3+ibdbIAl6v3TMm9iQf3DZS10saeREE8nluli7J8
 kRmw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+/WFozbaj81DOKuCdqpejSnWD4j0ooO/y8u/k3oQV07NDWWnUjqRzHwRmfb0SnQAJjqB0V2o=@lists.denx.de
X-Gm-Message-State: AOJu0YxseUVqeaNZW1cgcDgVnq+40yiO9NwACVLg7yzd2S4FcR0B9WfO
 pMidMaAbBNVPYKnxivJOfccCXFyCQlToViR0MoZ01ZuFNYakbYR+xbIcDHE80Urj/yC8Uwc3djT
 BdPhI6PQwrRXqEwjlzK0kk/8xU+8+z5Ff4G9erL6Vvg==
X-Gm-Gg: AfdE7cktHVIN84s89zBjRsXDiNR4it/8/vag/Ll9KJ2qZ/lz4tCoz4GSrOMDy6U5O+I
 0eqr0joL+UIeLqIVJcdu5nZOIUjbY+9tkC/hXTcP48anf95eJ8qV8XdlbqbGDZ6m0r0bPHgSEi8
 YWU8pNyo1+/0r/2kC8onEYjnjtv9C8VATzbuKgC8zUUX/D0iEmzLPuupzZbBiur5eYjOxQ6dMAn
 HxFsQmAwO36fQoQ7aADHL4MRfkFwk+/BO6pagaG1i9JVXd1jhVLTcjFmldxlynjW5EDx+CgU5B5
 UZpsRKB1BXbwTQF0TBFVEfWWrydXAP5nRWydnPx6ASoGgZfGAomdTU+amlSa8pE1YfQPi0XH4Lz
 3AEYmXq9+eXwZo2NwSYUzsK/KI82wmrHREgeT3c93SfLraBky11hFPfXqTOFM8dyIo5ORq8UYXU
 XKUQ8nOa4dNzO4noz4Ly/ZsHZFbPadD1mnllN+djCD5Ov87tqghUd+9elmdcUI+wbul6by1tVtr
 ye9Qv+zWzwNlAJt9Q3oNZCh8r2c7Vu6hQP+03ZeT9tFah983ypOXdPvmi1NUJSb31J9IiZk0d9D
 jqhhcF4FT0yG7UUPL8yrtxI+YaZSqZ9GXMz+EABwF5zA2AVr/plzCDF/1ftJA5hg3616FpU=
X-Received: by 2002:a05:690e:2581:b0:664:cab9:5242 with SMTP id
 956f58d0204a3-664fadf77c8mr422299d50.17.1782760098933; Mon, 29 Jun 2026
 12:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <88b37a74-6d98-4a6f-8f77-4ff5c47459c2@amd.com>
In-Reply-To: <88b37a74-6d98-4a6f-8f77-4ff5c47459c2@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 29 Jun 2026 22:07:43 +0300
X-Gm-Features: AVVi8CeBFJOvvnBcOkEpJ9H1gBoiI769t8R38UhO81FyFsnSj71Ntwfc9knQq54
Message-ID: <CAC_iWj+isM=utVFXdKY0RuQJZ9qJQe355PAd=TrCZ3YvLzVymw@mail.gmail.com>
Subject: Re: [PATCH v4 00/64] drivers: usb: dwc3: sync code with Linux v6.16
To: Michal Simek <michal.simek@amd.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>, Andre Przywara <andre.przywara@arm.com>, 
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

Michal

On Mon, 29 Jun 2026 at 13:53, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Jens,
>
> On 6/29/26 10:43, Jens Wiklander wrote:
> > Hi,
> >
> > This is a follow up on my last two patchsets [1] [2], where the latter only
> > with a small change in addition to posting all the patches.
> >
> > The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
> > ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> > to u-boot"). Since then, not many kernel changes have been ported back into
> > U-Boot.
> >
> > This series synchronizes the DWC3 core with Linux v6.16. To provide
> > a clear audit trail and maintain bisectability, I have structured the
> > series as follows:
> >
> > 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
> >     to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
> > 2. Milestone Imports: A sequence of 50+ commits follows, each performing
> >     a "snapshot" import of the drivers/usb/dwc3 directory for every major
> >     kernel version (v3.19 through v6.16).
> > 3. U-Boot Adaptation: The final commits (based on Jerome's original work [3])
> >     re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
> >     required for U-Boot integration.
> >
> > Note that this is compile-tested only. The CI pipeline on source.denx.de
> > was used as an OK/NOK indicator [4].
> >
> > These patches are also available at [5].
> >
> > Thanks,
> > Jens
> >
> > [1] https://lore.kernel.org/u-boot/20260507092843.358908-1-jens.wiklander@linaro.org/
> > [2] https://lore.kernel.org/u-boot/20260624123025.GA3245275@rayden/
> > [3] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> > [4] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30524
> > [5] https://github.com/jenswikl/u-boot-1/tree/poc/usb_dwc3_sync_v4
> >
> > v3 -> v4:
> > - Restored obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62) for dwc3-am62.o
> >
> > RFC v2 -> v3:
> > - Rebased on v2026.07-rc3
> > - Configured out a few prints in drivers/usb/gadget/udc/udc-core.c
> >    to make it build for am335x_evm_defconfig
> > - Applied provided tags in [1]
> > - Published as a branch
> >
> > RFC v1 -> RFC v2:
> > - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
> >    dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
> >    from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
> >
> > Jens Wiklander (60):
> >    usb: dwc3: restore to original v3.19-rc1 kernel import
> >    usb: dwc3: import from kernel v3.19
> >    usb: dwc3: import from kernel v4.0
> >    usb: dwc3: import from kernel v4.1
> >    usb: dwc3: import from kernel v4.2
> >    usb: dwc3: import from kernel v4.3
> >    usb: dwc3: import from kernel v4.4
> >    usb: dwc3: import from kernel v4.5
> >    usb: dwc3: import from kernel v4.6
> >    usb: dwc3: import from kernel v4.7
> >    usb: dwc3: import from kernel v4.8
> >    usb: dwc3: import from kernel v4.9
> >    usb: dwc3: import from kernel v4.10
> >    usb: dwc3: import from kernel v4.11
> >    usb: dwc3: import from kernel v4.12
> >    usb: dwc3: import from kernel v4.13
> >    usb: dwc3: import from kernel v4.14
> >    usb: dwc3: import from kernel v4.15
> >    usb: dwc3: import from kernel v4.16
> >    usb: dwc3: import from kernel v4.17
> >    usb: dwc3: import from kernel v4.18
> >    usb: dwc3: import from kernel v4.19
> >    usb: dwc3: import from kernel v4.20
> >    usb: dwc3: import from kernel v5.0
> >    usb: dwc3: import from kernel v5.1
> >    usb: dwc3: import from kernel v5.2
> >    usb: dwc3: import from kernel v5.3
> >    usb: dwc3: import from kernel v5.4
> >    usb: dwc3: import from kernel v5.5
> >    usb: dwc3: import from kernel v5.6
> >    usb: dwc3: import from kernel v5.7
> >    usb: dwc3: import from kernel v5.8
> >    usb: dwc3: import from kernel v5.9
> >    usb: dwc3: import from kernel v5.10
> >    usb: dwc3: import from kernel v5.11
> >    usb: dwc3: import from kernel v5.12
> >    usb: dwc3: import from kernel v5.13
> >    usb: dwc3: import from kernel v5.14
> >    usb: dwc3: import from kernel v5.15
> >    usb: dwc3: import from kernel v5.16
> >    usb: dwc3: import from kernel v5.17
> >    usb: dwc3: import from kernel v5.18
> >    usb: dwc3: import from kernel v5.19
> >    usb: dwc3: import from kernel v6.0
> >    usb: dwc3: import from kernel v6.1
> >    usb: dwc3: import from kernel v6.2
> >    usb: dwc3: import from kernel v6.3
> >    usb: dwc3: import from kernel v6.4
> >    usb: dwc3: import from kernel v6.5
> >    usb: dwc3: import from kernel v6.6
> >    usb: dwc3: import from kernel v6.7
> >    usb: dwc3: import from kernel v6.8
> >    usb: dwc3: import from kernel v6.9
> >    usb: dwc3: import from kernel v6.10
> >    usb: dwc3: import from kernel v6.11
> >    usb: dwc3: import from kernel v6.12
> >    usb: dwc3: import from kernel v6.13
> >    usb: dwc3: import from kernel v6.14
> >    usb: dwc3: import from kernel v6.15
> >    usb: dwc3: import from kernel v6.16
> >
> > Jerome Forissier (4):
> >    usb: host: re-import xhci-ext-caps.h from kernel v6.16
> >    usb: gadget: re-import epautoconf.c from kernel v6.16
> >    usb: udc: re-import udc-core.c from kernel v6.16
> >    usb: fix build after resync of DWC3 with kernel v6.16
>
>
> 4 patches are missing.
>
> b4 am -l 20260629084507.3254232-2-jens.wiklander@linaro.org
> ...
>    ERROR: missing [61/64]!
>    ERROR: missing [62/64]!
>    ERROR: missing [63/64]!
>    ERROR: missing [64/64]!

I do see all of them in my mailbox and u-boot list is cc'ed. Haven;t
tried b4 though


>
> Thanks,
> Michal
>
>
