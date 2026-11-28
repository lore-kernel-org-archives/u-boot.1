Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D7606A31F
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d/QLYdWp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dD/DrWRH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 557BD8114E;
	Sat, 28 Nov 2026 09:55:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0BYoEoDtRrx; Sat, 28 Nov 2026 09:55:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7DAFA81184
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795859710;
	b=Uj41qJNn5uxECRpMHPM/hsnG2IUJoT4CnCHK/vN/SvUoortNdtP+PwFFQIAL28yWtOz6
	 PqoMwE9eSdzYiFfTWiwpLdxPp8/nzBBOAvdlm9/NMFEbTL0PyCIvMmbbF8QM0PKO7/XQs
	 X3s2D4kNRw8mfKU/vHPgiZrPV1GC3iq5lzBWAdIohZgegFDYNwTtHIQJYhqFUKhXcScs0
	 AWRxFuicnZvPgxGGSMsx7Jv19gALKOUBom/x4PqlFEdeWhTLl8v/AepmDMV6QG37OY4UK
	 1m2iEM0Q6KJe6fJajkEU0mfyH6J7ls2QnxpgaZJcdFGTRgbCgo2qVrG96QUdZfyUIng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795859710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uwM99PSGREPj5mA03ZbZ9Op/Os2Bg67aVE2BVrm4H9g=;
	b=alWxqJPdZnkmPdWSevCS0SG7I8MoaRPUuvUWycBRUTC4cEGYu1zNZk7h0eJ3sEp6DqWO
	 E8iY8JoryLQmQrG2mPOc7BOemsTHllpNpTs0SNJoyqxfsdJYCpxiIqMzpAPJqYhzfgGTH
	 6GZt4XnThyfeZ2bjgN3BaTUtx/c8NST6X9dBFb/zh9dKK7NDRbg+0QkC6rlNf751dFh7n
	 hUfA8/jToCDWfXHicy5G8SP6AxG+nEhvc2XsWPq/H9d4EWztie56ZR+qzyeTQ5Hxxun7Z
	 3Cwr/ag6PEoZeJ/faPI3PdDVAU9dmv8/qnslzkYNyZrhjX9gX6zmBFfCbZk7HsOsqEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795859710;
	bh=uwM99PSGREPj5mA03ZbZ9Op/Os2Bg67aVE2BVrm4H9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d/QLYdWpHTMzb9jF8Ir/3EIKDsVkanLwTkD+cc1ZwVDJcSCC/dIS5oc5VIVJqET2M
	 u2oArD3/5vM9NuK6ZmqjcuNPfAWX9u9ynBsyOjOvQPOJpEBlVDQZD477cFgP4Eon5b
	 37sZf4b9b79MWABWp1PMGFxNE0i1aQXzXnXazoWh5C/veb8kscvBcbIbEE+lGzmT+O
	 Vv0sgC1PqRixg1AADTtctMAlKqCJtjzz7NC14R0TctFMLFn3Stb3AU0N8fmksdtyij
	 YOwILhKUIutjHxAaZSvRGL3dw4PF9g90NnIxrepPf9tQRGOvTe5JPY5rMPEvy/9JJi
	 N2TwijK7/V0qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DAFA81184;
	Sat, 28 Nov 2026 09:55:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E2C83C0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 09:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73FE360615
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 09:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DndV26yJ-4qo for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 09:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C60960602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dD/DrWRH
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C60960602
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 09:55:07 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c51373ae637so490123866b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 01:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795859706; x=1796464506;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uwM99PSGREPj5mA03ZbZ9Op/Os2Bg67aVE2BVrm4H9g=;
 b=dD/DrWRHx7w1e5DkktHlMCpPvqkQfS3bFnmJACze+V2Zy80jvqX0rL43u+pYyt29km
 yZvZ2D763vQY5OMtMdri472U1rpvOJMX2M6dPDfCLdsh4DvZEkWM5dGFNzvOxgVm5TQI
 VjlJxwWlDbegqM6a43XDYR6n2paba/Ji0Z4sQalHvrCU7YlJL4/QhHU1NiXDnZ4SOk4Z
 1AtLOkEsKAOfGJ2iV/ISdFHAQyT0iW43gdZSnPGRvmvZOUsaBP+MwNC8ewHv8k2mRi+w
 7spvQvHxb0kd1LoIo0pcCtivd4+MFNruOWNzXCPCRwlWXUw20M4JZlTsADdx7BIDHjCG
 M9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795859706; x=1796464506;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uwM99PSGREPj5mA03ZbZ9Op/Os2Bg67aVE2BVrm4H9g=;
 b=niJdGgxpiVmH9HVJvSSwMM+tFVqqj2rr0mLkSGbrEkB2yd9SFHdNMmmOssRsgE+MWL
 jjGQ2ity/orJCJHY1DyVXTYlPu7VeIZFio4+ZBM3AG1gUXcNN0bLQKRR/dr6THgZJGr2
 /QgnB6oHN95kpMUzHSAnPX5/j7oa0eSdVj1/FzVMl8AbsoWgXBNsLsMpkPZ5Mc/+Lzmv
 +Kd/LwpzhH7fxNUf4ydyO5i3b1uSJa0FKg3752izipSNbSlD4AP9/czLUjNSz4b2p/oJ
 QpTXIdLGnph/MNVWpBDa9Ga4p7EvkI2dbbjuywRA9ETpAWk9pgUXd/l6UzINnsKfbYNL
 +QgQ==
X-Gm-Message-State: APuU4Z9CkLOGwu+A3FKrHz5Epn5I4XDLi9DtcKM+FRvYhuwvkMOwDdvu
 hxaFXSXoTcIlXes3OChjaqSlMp+t6TbNkDr7B+U/gIPff4ZoB+meNWvDLu0nHL8igUnlGdNdS3N
 GYGMYL+Jvq6IqFdPeifhnss4ekABE0zM=
X-Gm-Gg: AZFdTZedEiOPlHPb3x/2a99irGW9OMG+PkNppQo3kxxKBzi+K9FAh4GaUaAFig6eQ7P
 06MftcFPTMyaDCTiqALnGzJRa8a1L0lxMBXdLaOra3sgZOYzDEOM5OSMh8gumauNxogVy44VK4n
 xrzvgG5hqIH8kVEiKNs8GERKp6mBTN0FIMC/+aQLT3Do8EvwZZ1Onc5iEvOXxywaC1v7+QAXAjn
 QHpNrGGTZP24lx22tsRq9kiF8ax4FboL69Ago5z5Zg/YW0uQvIvgBK4dbnH5bWFV7Xr6NcwMgD4
 +l9bKLlz9Ua5uJ0bbg8lLVf4UUV/rfLO4unC6VJ2J6AacDw9+pLDTiTLMLLz6Qk9KSNcUJIpE1e
 tmvmxehsysezTRV2iQb3INP3fsMRV4D1bmiL5lxHU0XMNawU+AMfOGMVK
X-Received: by 2002:a17:906:9542:b0:c46:a607:6922 with SMTP id
 a640c23a62f3a-c513a99e9e0mr1788823466b.25.1795859705777; Sat, 28 Nov 2026
 01:55:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-legacy-block-tpl-v1-1-aeee138e9288@postmarketos.org>
 <CAC928HZLjxgkuoyMaZa8jFimiVPTGX+hkuN6dppCJeFja9axYA@mail.gmail.com>
 <tp61ew.2jah7hm6wep6j@postmarketos.org>
 <tp63eh.1vrvzthhsnbk9@postmarketos.org>
In-Reply-To: <tp63eh.1vrvzthhsnbk9@postmarketos.org>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 28 Nov 2026 10:54:53 +0100
X-Gm-Features: Aa3M54qKA3bTJJZ0ZyphufYyJs3EzucIeY13rAc9NyqZMGBPw2pSTRZUKLi6K20
Message-ID: <CAC928HbjpZvm+ytSDg_GwWBbo4u10C4OGckOtg==5tP8ohLFCA@mail.gmail.com>
Subject: Re: [PATCH] block: add legacy block support for TPL
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@jo-so.de>, 
 Johan Jonker <jbx6244@gmail.com>, Denis Mukhin <dmukhin@ford.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ferass,

Il giorno ven 27 nov 2026 alle ore 16:37 Ferass El Hafidi
<funderscore@postmarketos.org> ha scritto:
> On Fri, 27 Nov 2026 14:51, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
> >Hi Massimo, sorry for the delay ^^
> >
> >On Mon, 09 Nov 2026 19:51, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
> >>Hi,
> >>
> >>Il giorno lun 9 nov 2026 alle ore 09:01 Ferass El Hafidi ha scritto:
> >>>
> >>> Legacy block support is only selectable for SPL. However it is
> >>> useful in TPL too, where the full block driver (with DM and whatnot)
> >>> will not fit.
> >>> Add a TPL_LEGACY_BLOCK kconfig option to enable legacy block support in
> >>> TPL. Note that it is hidden in menuconfig (just like the SPL variant).
> >>>
> >>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> >>> ---
> >>> As I've been working on some TPL support for Amlogic I noticed that I
> >>> could not choose the legacy block driver (while I could choose it for SPL).
> >>> Given we only have 44K available, DM is a tight fit there so I'd rather not
> >>> enable it where possible to save space.
> >>>
> >>> Adding the ability to select the legacy block driver in TPL seemed like
> >>> a good option for the same reasons it is already available for SPL
> >>> builds. And indeed it works just fine there too.
> >>> ---
> >>>  disk/Makefile          |  4 ++--
> >>>  drivers/Makefile       |  7 ++++++-
> >>>  drivers/block/Kconfig  | 12 +++++++++++-
> >>>  drivers/block/Makefile |  2 +-
> >>>  4 files changed, 20 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/disk/Makefile b/disk/Makefile
> >>> index c16876e2073..18b839f6ecd 100644
> >>> --- a/disk/Makefile
> >>> +++ b/disk/Makefile
> >>> @@ -10,8 +10,8 @@ ifdef CONFIG_$(PHASE_)BLK
> >>>  obj-$(CONFIG_$(PHASE_)PARTITIONS)  += disk-uclass.o
> >>>  endif
> >>>
> >>> -# Must have BLK or SPL_LEGACY_BLOCK to support partitions
> >>> -ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK),)
> >>> +# Must have BLK or LEGACY_BLOCK to support partitions
> >>> +ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_$(PHASE_)LEGACY_BLOCK),)
> >>>  obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   += part_dos.o
> >>>  obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   += part_iso.o
> >>>  obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   += part_efi.o
> >>> diff --git a/drivers/Makefile b/drivers/Makefile
> >>> index 5403206159c..989be07cd02 100644
> >>> --- a/drivers/Makefile
> >>> +++ b/drivers/Makefile
> >>> @@ -74,7 +74,6 @@ obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/udc/
> >>>  obj-$(CONFIG_SPL_WATCHDOG) += watchdog/
> >>>  obj-$(CONFIG_SPL_USB_HOST) += usb/host/
> >>>  obj-$(CONFIG_SPL_SATA) += ata/ scsi/
> >>> -obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
> >>>  obj-$(CONFIG_SPL_THERMAL) += thermal/
> >>>  obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
> >>>
> >>> @@ -82,6 +81,12 @@ endif
> >>>  endif
> >>>  endif
> >>>
> >>> +ifdef CONFIG_XPL_BUILD
> >>> +
> >>> +obj-$(CONFIG_$(PHASE_)LEGACY_BLOCK) += block/
> >>> +
> >>> +endif
> >>
> >>What's the purpose of the ifdeffery? I would expect it to work with or without
> >>ifdeffery exactly in the same way. If CONFIG_XPL_BUILD is not defined,
> >>CONFIG_$(PHASE_)LEGACY_BLOCK becomes CONFIG_LEGACY_BLOCK which does not exists.
> >>
> >
> >Yes, CONFIG_LEGACY_BLOCK does not exist. I believe there was a reason as
> >to why the legacy block driver could not be chosen for U-Boot proper so
> >I didn't question it. That's why there's this `ifdef`.
> >
> >Is it something you'd like me to change in the next revision?
> >
>
> I got pointed out offlist (on IRC, thanks!) that your point might've
> been that the ifdef is unnecessary and can be removed for the same effect. And
> indeed your feedback makes a lot more sense that way. Sorry for the
> misunderstanding, I'll fix that in v2.

I should have been more straightforward and thus clear.
But I had doubts that I was missing something.

Regards,
Massimo

>
> Thanks a lot!
>
> Best regards,
> Ferass
