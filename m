Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EF8C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 09:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0D287ED9;
	Tue, 27 Feb 2024 10:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="liEIs/sC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5587187F50; Tue, 27 Feb 2024 10:00:17 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D20E87ED9
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 10:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4704c69a3d9so552479137.2
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 01:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709024406; x=1709629206; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HdVhDHXCTp/5LQqcLSx7mWe3PUeYZIYWpni3pAXzNwM=;
 b=liEIs/sCqI7XHvGjRSYeS9aui7OWUc41rgcLtigjODl9ir6mVO9kUOe+TRWK+ZpkXR
 +gq9uyalyzuvZisYuQByYWx3JVsx9q+ayetWH1ZxoHLo2xpMmCb68Ib7a2YBBO0CUfUi
 V1EQkSI7z5PGlG3MEMwSIZW3wHcfBSRShdfFeFgikRjWeO3ROp5qDyYrZQWziP4ehWs6
 zYkecFVZBe9NoAxKLysb6H35vVbXYv+Hl6Lz/+WkCOUa3fmQLfml/haJweBzYXuxq7Nt
 hZTlO1OQR8OZNFk/ZOrBS/Z3XxaZCGLRxBMdpZ9eF0nuQmzIDXNeDafq2sRUD3cdGKiJ
 aXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709024406; x=1709629206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HdVhDHXCTp/5LQqcLSx7mWe3PUeYZIYWpni3pAXzNwM=;
 b=X+ih/wmMWc/HJ5LxZMf4fHVBt80RwvWvvBKDuPmxtAHK3tsgi7n4uIPuioT2LmyFCr
 14lVhWNWO26SepoDfN53fEXbImNhf9VfM7h0siyIx0OpaS2UYIJYTnvC7IS8fQrjd3lq
 p3vItBMRTgNR5D9RMjOSVHUt/3KFvPS8ifMagtvXHqdEeZ5svsopdiKlq1F4iOn1tZDh
 b1VyC+wYBHkH2IMKeFiIvHoRUc6xeRccigPHE86gLx6VnH4pUSYPWeKB/7xi25nxt4ux
 zMQfSTdRnrCJKw319vMiF+yOBokvNKfedYVA9ThMF8d3ntSU3SBCc2KX4cNTaOUDcgkY
 qw9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdXCWAvrzF4WU4UkqSCws0rIinV6EmIeGajw1VeAFcaKIyEngGIuFkxrTv8d8lhZ0wS4qH4SyTCVHBuV0c1Uhp2Yz0ng==
X-Gm-Message-State: AOJu0Yy21Ed7UiUekCnyUgTIt6DbCXassm8OKdMzu766WtERaV1OTsd4
 dwPqRV988ZTJCA852GHGa1OhLvBID+HJgtsZMcTzcMAlZ1hxnt3SuZ8ZqT6YrWaG1f1NH0EO4Ue
 0c5FvASFxDB2lcwhFehVgoZQfb54P5PH7o+cbjA==
X-Google-Smtp-Source: AGHT+IGplupdpVsmr2ch8SeiRetDCcklFmx13ca0RsXjVM4Ng8kWevhPZfJfPKoZtVttlvPuKaCJI+N9lxBxBaQh0Qw=
X-Received: by 2002:a67:fd64:0:b0:472:55e1:7d33 with SMTP id
 h4-20020a67fd64000000b0047255e17d33mr588535vsa.30.1709024406036; Tue, 27 Feb
 2024 01:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
 <20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com>
 <f0a0f05e-054e-4a19-ae0a-cd9bc442238b@ti.com>
In-Reply-To: <f0a0f05e-054e-4a19-ae0a-cd9bc442238b@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 27 Feb 2024 14:29:54 +0530
Message-ID: <CAFA6WYPPcqxds=rNB1LjGvM=dnVL=YdbdBxnTrJXTyTCwJqQMQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] Makefile: remove hardcoded device tree source
 directory
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Nishanth Menon <nm@ti.com>, 
 Andrew Davis <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Hari Nagalla <hnagalla@ti.com>, 
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>
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

Hi Neha,

On Tue, 27 Feb 2024 at 13:53, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Hi Bryan
>
> On 27/02/24 02:49, Bryan Brattlof wrote:
> > Some boards that choose to utilize the OF_UPSTREAM directory for their
> > device tree files will need to specify that directory instead of the
> > traditional arch/$(ARCH)/dts/* path.
> >
> > Include the correct path to the board's dtbs depending on if OF_UPSTREAM
> > is selected or not.
> >
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >   Makefile             | 18 ++++++++++++++----
> >   scripts/Makefile.spl | 17 +++++++++++++----
> >   2 files changed, 27 insertions(+), 8 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 0f0c7f30d2717..51b57d26857f1 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1184,6 +1184,16 @@ dt_binding_check: scripts_dtc
> >   quiet_cmd_copy = COPY    $@
> >         cmd_copy = cp $< $@
> >
> > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > +ifeq ($(CONFIG_ARM64),y)
>
> This would fail in case of R5 builds, is there any reason why you choose not to
> use OF_UPSTREAM for R5 builds?

Although I will let Bryan elaborate more here, the essence here is
that OF_UPSTREAM=y means that the target DTS files come from
dts/upstream/src/<arch>/.

>
> I understand that R5 builds will require U-Boot DTS (from U-Boot code base) that
> (ideally) should inherit the kernel core DTS (from upstream), is this support
> not there at present? Let me know if I understand incorrectly.
>

However, with OF_UPSTREAM=n you can have U-Boot DTS placed in
arch/$(ARCH)/dts/ like the R5 case but you can include whatever common
pieces required from dts/upstream/src/<arch>/.

-Sumit

> > +dt_dir := dts/upstream/src/arm64
> > +else
> > +dt_dir := dts/upstream/src/$(ARCH)
> > +endif
> > +else
> > +dt_dir := arch/$(ARCH)/dts
> > +endif
> > +
> >   ifeq ($(CONFIG_MULTI_DTB_FIT),y)
> >
> >   ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)
> > @@ -1209,7 +1219,7 @@ endif
> >
> >   MKIMAGEFLAGS_fit-dtb.blob = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
> >       -a 0 -e 0 -E \
> > -     $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
> > +     $(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
> >
> >   MKIMAGEFLAGS_fit-dtb.blob += -B 0x8
> >
> > @@ -1407,9 +1417,9 @@ MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
> >       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> >       -p $(CONFIG_FIT_EXTERNAL_OFFSET) \
> >       -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> > -     $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TREE))) \
> > -     $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
> > -     $(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
> > +     $(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(DEVICE_TREE))) \
> > +     $(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
> > +     $(patsubst %,-b $(dt_dir)/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
> >   else
> >   MKIMAGEFLAGS_u-boot.img = -A $(ARCH) -T firmware -C none -O u-boot \
> >       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> > diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
> > index 407fc52376a50..d074ba2350065 100644
> > --- a/scripts/Makefile.spl
> > +++ b/scripts/Makefile.spl
> > @@ -559,9 +559,15 @@ FORCE:
> >   $(obj)/dts/dt-$(SPL_NAME).dtb: dts/dt.dtb
> >       $(Q)$(MAKE) $(build)=$(obj)/dts spl_dtbs
> >
> > -PHONY += dts_dir
> > -dts_dir:
> > -     $(shell [ -d $(obj)/dts ] || mkdir -p $(obj)/dts)
> > +ifeq ($(CONFIG_OF_UPSTREAM),y)
> > +ifeq ($(CONFIG_ARM64),y)
> > +dt_dir := dts/upstream/src/arm64
> > +else
> > +dt_dir := dts/upstream/src/$(ARCH)
> > +endif
> > +else
> > +dt_dir := arch/$(ARCH)/dts
> > +endif
> >
> >   # Declare the contents of the .PHONY variable as phony.  We keep that
> >   # information in a variable so we can use it in if_changed and friends.
> > @@ -569,8 +575,11 @@ dts_dir:
> >
> >   SPL_OF_LIST_TARGETS = $(patsubst %,dts/%.dtb,$(subst ",,$(CONFIG_SPL_OF_LIST)))
> >   SHRUNK_ARCH_DTB = $(addprefix $(obj)/,$(SPL_OF_LIST_TARGETS))
> > +$(dir $(SHRUNK_ARCH_DTB)):
> > +     $(shell [ -d $@ ] || mkdir -p $@)
> > +
> >   .SECONDEXPANSION:
> > -$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, arch/$(ARCH)/dts/%, $$@) dts_dir
> > +$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_ARCH_DTB))
> >       $(call if_changed,fdtgrep)
> >
> >   targets += $(SPL_OF_LIST_TARGETS)
> >
>
> --
> Thanking You
> Neha Malcom Francis
