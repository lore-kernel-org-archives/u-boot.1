Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA724C43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 05:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B666F849BA;
	Tue, 30 Jun 2026 07:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XZXIoRpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C50AC849C5; Tue, 30 Jun 2026 07:57:24 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F6D484979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 07:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4486c5813afso119928fac.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 22:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782799041; cv=none;
 d=google.com; s=arc-20260327;
 b=Hokdr5yT9GsQDUlkyjIcfTeDewXNCqCHscxHioLI1JJLqB64fsYnQwU5/YYAU99gKc
 6A6p20rVgLMypaOk3MKRSX5vUhH/w2uAqLnSQs53TS2adu9X0rb3pcyql0IlEog0TUlY
 7XB8FrYNNCBqlwhOGTw2sGTKaQ0FFzu2Z9EYxgIn1nv0Mr05/HyafptFgD6eH0s3WPQt
 idhmUd4ieU0OYGVj/WRyaf/BnGMzTVPq+1xnwqLTe3e9JDgse5jrIXRWpCUTiCqU3LSg
 IUUwCpI0B2Iltpk8fXDZKp6GVP9bXicqdckrIEJQxmyuOd12dXqqHFjLNwu2dT5giRNT
 0ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ycc5BzP01bpM3ZMJBQme9BAhdQJuG2kxK0O8jUN+YLQ=;
 fh=HXlBjaFPKNl7/dGz3iKj1O0uqLhSeI1LiJaypVLYyI0=;
 b=FwChxewoCIxo1Vf0yxG5Aj92VUHUEgS+1j//82esaJog9YbLfIfuuZBVSOQogIvxQl
 VGS3S62tUGatsIlKjCSyUfK6XfY7rkjBG963a1LpDMPxmptLtmZU31eR0QI+Qyc3UXZc
 W/u23gRpJskAPwp+plUWeZZFXutle3LZUUpZbnS4cWyI8aFpE3Tx3YWoKYAIwH63YiC4
 fSt/KeXdcSBUXClKEl0P4JE14MCQjMb48V5zv7bY8t522jTK7w+emKoT3kf3c5d2v+5R
 D9ocJ3c+qdP/NZp1PxteWqC1v8E0Rw1mSRcguVizYQQhnQn+rdb4AI6lH0llD+1lKxeR
 0Fww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782799041; x=1783403841; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycc5BzP01bpM3ZMJBQme9BAhdQJuG2kxK0O8jUN+YLQ=;
 b=XZXIoRpdEFaGLfnVSSzzc9Ui6QxyD31krXx8qAJyVw+Jm5KzPwZDC1UhuZUydCAguJ
 HEY40NicO/S28EE0BqR7dWm9+D9hzHYn6TrkFq6qPCPbbnOG08tei+DWzgWgu9lKIe2e
 wQIV+tYajBzKoAjU/dyAl4cn8JujPL0wIOSnXO2DH0Eu8sd3hpNCIMRyq8xBcPd1IZcc
 HA5FgPqWic1fsbsAQWD2qOpWbLpGnUvGSToClAxJCzkfLLBZB801eMhMhUaMFCKLhmMt
 7mS/WdDIH5dlD1buejLkClgb5vm86kMlG1OjIWtpS5jdJnC4qksmn28enpcaf3FARlho
 RfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782799041; x=1783403841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ycc5BzP01bpM3ZMJBQme9BAhdQJuG2kxK0O8jUN+YLQ=;
 b=nx8prc+axirowEek8IOYzjN1EZLpMO8ODd+1tT1/WRzw7ZA8jbdr59ZFijvLC8KMfD
 Glg4DZ6vYoxOj2Frz9508b3qk8iv1fz3KBd+t4Vx9XaBKEepU66OvR2mRLsRM1FFr7jK
 JJLoD6jh0j8xZtEnjS3EuHiP3e1kPp1MzVEUg/PL8PnyS+kuhNwHFj1+UzYfDBaLGR6L
 h5Ix4gwddtegMnRCV3X7TmTa4RfXDzT+u87IXdaR7G2UyjURzeAx8lrGTNi4s0vKaMNb
 LiQCbkd1bHrFVSXhEViiFTAPhoyWbCAJb8TjfwNpqyqWJ8kxw0pwYvOmQIZZ3Pv/X/Yb
 jycQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfkN9+9dTujQKchJ/kkEaUHxfRmbd/L/VTJlS7QMhCu7Z79Gsl7FC3TiJYEMpphKFfDQnE2Pw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywsh1RkJkxlDEI53lkd1xfyfJMv2GfyN/h1W6WXvh8Qq/CLiC50
 vS1XA3vzp7ySRpN2zGZgd0u5wr4v+36qD2zHMvBusFMPE/WJ1W4kpa+f9qj3XwgX50js8sDJYBG
 d1/xYOCXlC6r7q1waubvnjLErJVJ4efmmMS/Qny1hFg==
X-Gm-Gg: AfdE7ck+b19ywHoHWhBcTpcMpaQBikHZgvilaznxrpsG6xXe4wIEuPch7T55xGeRFG6
 LACyD7NNeMqL5l0/M36SBxwODFAV/1gX9wKHZPjfgwXaF/9f4qor4Yznn92nMYRbDuyydeseWGw
 l/2fgPG2SK0S/EUUebxogVKmHwyhdwm0+bh5TzxjLjHLQaRzYSYThB2cy/DyqaY+PfZ+6U4uCw8
 aCQFhg1Asa85A22WvqbqPyxnfLAGs7VaaDzgtUiMtMS2U68k+tvByOjEu13+wVBRIhdHKZdD8C9
 jvUg+iRTsdp/idTKj4fHUDpM8sY=
X-Received: by 2002:a05:6870:d185:b0:443:1de6:beb3 with SMTP id
 586e51a60fabf-44ae2bbc415mr323687fac.5.1782799040724; Mon, 29 Jun 2026
 22:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <88b37a74-6d98-4a6f-8f77-4ff5c47459c2@amd.com>
 <CAC_iWj+isM=utVFXdKY0RuQJZ9qJQe355PAd=TrCZ3YvLzVymw@mail.gmail.com>
 <bed15a62-5645-4ae2-a207-b65d74ecc11f@amd.com>
In-Reply-To: <bed15a62-5645-4ae2-a207-b65d74ecc11f@amd.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 30 Jun 2026 07:57:08 +0200
X-Gm-Features: AVVi8CcliAmU07AEYBT_pVK1BsosTPZb1nkekKd549aqLmQciEfEpHsyawJTY1w
Message-ID: <CAHUa44GibYFZ8fWK0qTVN5gU9h6JV8yDuv1eZ9Q8bV5qV2LYaA@mail.gmail.com>
Subject: Re: [PATCH v4 00/64] drivers: usb: dwc3: sync code with Linux v6.16
To: Michal Simek <michal.simek@amd.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
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
Content-Transfer-Encoding: quoted-printable
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

Hi Michal,


On Tue, Jun 30, 2026 at 6:37=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 6/29/26 21:07, Ilias Apalodimas wrote:
> > Michal
> >
> > On Mon, 29 Jun 2026 at 13:53, Michal Simek <michal.simek@amd.com> wrote=
:
> >>
> >> Hi Jens,
> >>
> >> On 6/29/26 10:43, Jens Wiklander wrote:
> >>> Hi,
> >>>
> >>> This is a follow up on my last two patchsets [1] [2], where the latte=
r only
> >>> with a small change in addition to posting all the patches.
> >>>
> >>> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven=
 years
> >>> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux ke=
rnel
> >>> to u-boot"). Since then, not many kernel changes have been ported bac=
k into
> >>> U-Boot.
> >>>
> >>> This series synchronizes the DWC3 core with Linux v6.16. To provide
> >>> a clear audit trail and maintain bisectability, I have structured the
> >>> series as follows:
> >>>
> >>> 1. Restore to Baseline: The first commit reverts U-Boot-specific chan=
ges
> >>>      to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1=
 state.
> >>> 2. Milestone Imports: A sequence of 50+ commits follows, each perform=
ing
> >>>      a "snapshot" import of the drivers/usb/dwc3 directory for every =
major
> >>>      kernel version (v3.19 through v6.16).
> >>> 3. U-Boot Adaptation: The final commits (based on Jerome's original w=
ork [3])
> >>>      re-introduce the necessary glue code, XHCI/UDC updates, and buil=
d fixes
> >>>      required for U-Boot integration.
> >>>
> >>> Note that this is compile-tested only. The CI pipeline on source.denx=
.de
> >>> was used as an OK/NOK indicator [4].
> >>>
> >>> These patches are also available at [5].
> >>>
> >>> Thanks,
> >>> Jens
> >>>
> >>> [1] https://lore.kernel.org/u-boot/20260507092843.358908-1-jens.wikla=
nder@linaro.org/
> >>> [2] https://lore.kernel.org/u-boot/20260624123025.GA3245275@rayden/
> >>> [3] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.foris=
sier@linaro.org/
> >>> [4] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/3=
0524
> >>> [5] https://github.com/jenswikl/u-boot-1/tree/poc/usb_dwc3_sync_v4
> >>>
> >>> v3 -> v4:
> >>> - Restored obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62) for dwc3-am62.o
> >>>
> >>> RFC v2 -> v3:
> >>> - Rebased on v2026.07-rc3
> >>> - Configured out a few prints in drivers/usb/gadget/udc/udc-core.c
> >>>     to make it build for am335x_evm_defconfig
> >>> - Applied provided tags in [1]
> >>> - Published as a branch
> >>>
> >>> RFC v1 -> RFC v2:
> >>> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("=
usb:
> >>>     dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3=
: import
> >>>     from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
> >>>
> >>> Jens Wiklander (60):
> >>>     usb: dwc3: restore to original v3.19-rc1 kernel import
> >>>     usb: dwc3: import from kernel v3.19
> >>>     usb: dwc3: import from kernel v4.0
> >>>     usb: dwc3: import from kernel v4.1
> >>>     usb: dwc3: import from kernel v4.2
> >>>     usb: dwc3: import from kernel v4.3
> >>>     usb: dwc3: import from kernel v4.4
> >>>     usb: dwc3: import from kernel v4.5
> >>>     usb: dwc3: import from kernel v4.6
> >>>     usb: dwc3: import from kernel v4.7
> >>>     usb: dwc3: import from kernel v4.8
> >>>     usb: dwc3: import from kernel v4.9
> >>>     usb: dwc3: import from kernel v4.10
> >>>     usb: dwc3: import from kernel v4.11
> >>>     usb: dwc3: import from kernel v4.12
> >>>     usb: dwc3: import from kernel v4.13
> >>>     usb: dwc3: import from kernel v4.14
> >>>     usb: dwc3: import from kernel v4.15
> >>>     usb: dwc3: import from kernel v4.16
> >>>     usb: dwc3: import from kernel v4.17
> >>>     usb: dwc3: import from kernel v4.18
> >>>     usb: dwc3: import from kernel v4.19
> >>>     usb: dwc3: import from kernel v4.20
> >>>     usb: dwc3: import from kernel v5.0
> >>>     usb: dwc3: import from kernel v5.1
> >>>     usb: dwc3: import from kernel v5.2
> >>>     usb: dwc3: import from kernel v5.3
> >>>     usb: dwc3: import from kernel v5.4
> >>>     usb: dwc3: import from kernel v5.5
> >>>     usb: dwc3: import from kernel v5.6
> >>>     usb: dwc3: import from kernel v5.7
> >>>     usb: dwc3: import from kernel v5.8
> >>>     usb: dwc3: import from kernel v5.9
> >>>     usb: dwc3: import from kernel v5.10
> >>>     usb: dwc3: import from kernel v5.11
> >>>     usb: dwc3: import from kernel v5.12
> >>>     usb: dwc3: import from kernel v5.13
> >>>     usb: dwc3: import from kernel v5.14
> >>>     usb: dwc3: import from kernel v5.15
> >>>     usb: dwc3: import from kernel v5.16
> >>>     usb: dwc3: import from kernel v5.17
> >>>     usb: dwc3: import from kernel v5.18
> >>>     usb: dwc3: import from kernel v5.19
> >>>     usb: dwc3: import from kernel v6.0
> >>>     usb: dwc3: import from kernel v6.1
> >>>     usb: dwc3: import from kernel v6.2
> >>>     usb: dwc3: import from kernel v6.3
> >>>     usb: dwc3: import from kernel v6.4
> >>>     usb: dwc3: import from kernel v6.5
> >>>     usb: dwc3: import from kernel v6.6
> >>>     usb: dwc3: import from kernel v6.7
> >>>     usb: dwc3: import from kernel v6.8
> >>>     usb: dwc3: import from kernel v6.9
> >>>     usb: dwc3: import from kernel v6.10
> >>>     usb: dwc3: import from kernel v6.11
> >>>     usb: dwc3: import from kernel v6.12
> >>>     usb: dwc3: import from kernel v6.13
> >>>     usb: dwc3: import from kernel v6.14
> >>>     usb: dwc3: import from kernel v6.15
> >>>     usb: dwc3: import from kernel v6.16
> >>>
> >>> Jerome Forissier (4):
> >>>     usb: host: re-import xhci-ext-caps.h from kernel v6.16
> >>>     usb: gadget: re-import epautoconf.c from kernel v6.16
> >>>     usb: udc: re-import udc-core.c from kernel v6.16
> >>>     usb: fix build after resync of DWC3 with kernel v6.16
> >>
> >>
> >> 4 patches are missing.
> >>
> >> b4 am -l 20260629084507.3254232-2-jens.wiklander@linaro.org
> >> ...
> >>     ERROR: missing [61/64]!
> >>     ERROR: missing [62/64]!
> >>     ERROR: missing [63/64]!
> >>     ERROR: missing [64/64]!
> >
> > I do see all of them in my mailbox and u-boot list is cc'ed. Haven;t
> > tried b4 though
>
> They are available now.

That's good. I got a bunch of:
[PATCH v4 64/64] usb: fix build after resync of DWC3 with kernel
v6.16

Is being held until the list moderator can review it for approval.

The reason it is being held:

    Too many recipients to the message

Cheers,
Jens

>
> Thanks,
> Michal
