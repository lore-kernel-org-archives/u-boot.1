Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258B2FEFB6F
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 23:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13BED83E81;
	Sat, 28 Feb 2026 00:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FXvLCnka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD2183EB3; Sat, 28 Feb 2026 00:27:57 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A60483A1B
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 00:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65f73225f45so4442408a12.1
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 15:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772234874; cv=none;
 d=google.com; s=arc-20240605;
 b=BXUPLKAuLhzVc94zQwJCR+BVcOVIehAu/fPMr/yD9Wzg9nsMQTs0YcvdyXW3h59Be0
 8EA2VgvaQovMLObAXyrBnCXggaHeMJ9Tf7TYI8QG1aaDzKHb+wrV2z6JL7zxRoA51bDc
 MGu6sl69s2J0FWhANox3dHkYpGDLhxlh+cP7CakYMoFOynPylVNaBpKv3eOk5g8SEzi6
 OGoXFcZVEJQ8BQ/+7vYn55vF0KiVW4HJ1iNxC5WvUFNkKNOYsv3sa3KuxBu8tnqWI3Ea
 astmmmWygQ2U/mytjcDoYrpHOzMVH/Xcii6eiXkqehGSHgb5NRdhYmAsHzTsovSnLWsZ
 dnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F8HaAGbA7nu2Wf7Qr5bMrRubiIpbIQb69KFuJC/KNcA=;
 fh=uFfMeDWXvxBgJQo4Ok+l4D/5E3ZRFKnyz3dfEUYz0a8=;
 b=O1X0JaUyYLa5d/7SIibZSpdm8EUgTFlEeq6ap4wc6POlIxggSKHTf/JZ9YATUMB7as
 lRm3u6secyeggtMvvPlxkbmUzM4XUFBPO8+I7Pc40F7qgduPdIyVOVZwKxKNAo0rtnOf
 zyxn5h6FeSTq6bdtOpG5WmGe/A0FZje7H1kIggZM2VpBOvuCs/fiNI/Em42mLYBvPsd0
 +8Pzkdc9h1jae0QjZaHqLqyeAaihBnSFSYh6RiPONGmZRnu33znfGHYnKEc39Mk741Fb
 jtjYUZhmOO9hYbITu2mqfPsSN7WaefTh6nBM/vSfcfZXXhFxvzWlnr8HELAuw98f5/Rv
 c6Lg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772234874; x=1772839674; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F8HaAGbA7nu2Wf7Qr5bMrRubiIpbIQb69KFuJC/KNcA=;
 b=FXvLCnkaPGf5Yj3qaMwF+Dp+IP7WMd+UPgg133AHucUK9KRia/ekO48keDT51C0kV8
 8KS/GcBIHFXj8mlIvHJANWO8sd7bbM2dDJTZpSnfCH7CVJ/1pnsu+NbEK1uvPOP8bwpm
 Te4wZLiP6k/jTJlS5yH/fOq9sSNd11lAKSgQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772234874; x=1772839674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8HaAGbA7nu2Wf7Qr5bMrRubiIpbIQb69KFuJC/KNcA=;
 b=JGwYE+V32x4nlR5wAKzUwXnu481vFwMX1hrTEUs6ksnMdCikkCamR47TY5wJCITQYJ
 ZQPntMs1Q1cnbCDYeNhbEw/onkaovhsK+vszfPPnpnwAkYRdwyigYAHkC5xvil8DTZD0
 Lw8k8wF3te6oG7830hPShNIHE21oBLAHrLPBdSKjGUO5e4CiPaXulmTeWOtB4OCokpvS
 33yLBq3vtQ2wzh/7+yg0uAWDnAmvYxyYwMexv4jT6IFyxuSqLzEGbfG7U/Cg8r4VKOYN
 tyIcpPyIAKy+tB+AdjMvosEpzVtuavxOcm++GzqeUugnrqrQy7O19befzNSGun2QYsZS
 4bog==
X-Gm-Message-State: AOJu0YwimY3kX7XDImWemGEnMbTMb9XI7N0oxotwoddf6yOHmgNCS1i8
 jnAWw9LaKvGvsSqs7BnhK/G3zwiQih/sOmyrR/1Uc/QvKyUUYWjEx89ZMj4d7WKKn0Nx6BCGEZw
 bhXMrO83og29fAv2UVQgd7gvEwIZjNwvNfMgLvYxf
X-Gm-Gg: ATEYQzybS5Rb1tstZhzPF/D0GZETvuISHgjf8dNc1ELJ6/Naw2z+LGv8UAScKm3MrZX
 rd1eZLh8oc6sf+NLPNY2gVVseyU+yKJUNCkTmflsqEBq02gVIbK/V53+UokSIG8gsam9A7U713H
 ZSFK1SrFwRKDi94VdKuDc4AdU2OIN9sWt9YW1HhhNVZxyi+5GczMdNLm0MY8t28KrefKdDMI9QG
 Oo49zPTQjO8y8bFJgQArr/JiC3N8pLzMHEDFJUDDEVthnYDLqJ2+/rhWrmEfv44InvAADzJu3X0
 Bbamuw==
X-Received: by 2002:a05:6402:5245:b0:65a:382e:7254 with SMTP id
 4fb4d7f45d1cf-65fdd6e2174mr3099165a12.13.1772234874261; Fri, 27 Feb 2026
 15:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224161302.GX3233182@bill-the-cat>
In-Reply-To: <20260224161302.GX3233182@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Feb 2026 16:27:42 -0700
X-Gm-Features: AaiRm50D7vnTR1_PXBjBKEBw-NeBU01rqCOqas4hr8izDg0CCRxwOxKpcRYn4r4
Message-ID: <CAFLszTg86o0jPEboB=XPiDTn4s4pZnryDK+P=BKmzKY292DbgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] bootm: Clean up arch-specific, pre-OS clean-up
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Leo <ycliang@andestech.com>, Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
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

Hi Tom,

On Tue, 24 Feb 2026 at 09:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 24, 2026 at 07:25:42AM -0700, Simon Glass wrote:
>
> > Each arch does something slightly different before booting the OS. Some
> > archs even do different things depending on the CPU type.
> >
> > It is quite hard to know what actually happens in the final milliseconds
> > before the OS boot.
> >
> > This series attempts to start cleaning up U-Boot in this area.
> >
> > The basic intent is to create a new bootm_final() function which can be
> > called by all archs. It provides some flags for a couple of necessary
> > variations but otherwise it is generic.
> >
> > RISC-V, x86 and ARM are converted over to use this new function. For
> > consistency, EFI loader is converted as well.
>
> Please include all architectures in v3, ARM is still not shown in this
> series.
>
> > A noteable change is that EFI_LOADER now does bootstage processing
> > before boot, if enabled, thus producing a report.
> >
> > There is also a patch to drop EFI_GRUB_ARM32_WORKAROUND, as discussed
> > recently on the mailing list.
> >
> > Future work could take this a little further:
> > - Drop board_quiesce_devices() and rely on driver model for that
>
> Potentially, but there's non-trivial uses that don't fit in driver model
> today either.
>
> > - Similarly with udc_disconnect()
>
> Please look at mainline code again.
>
> > - Look at converting EFI to use the same function
>
> You said a few lines above EFI was converted? Please make sure your
> cover letter is consistent and correct in v3.
>
> > Also, the comment for cleanup_before_linux() could use more details as
> > to what it is supposed to do, to reduce the number of arch-specific
> > variations. It currently does different things on differents archs and
> > is mostly uncommented (apart from an ARM-specific note in a README).
> > Ideally it would be commented with exactly what it should do, ideally
> > at a high level so it is not just arch-specific.
> >
> > While some of these arch-specific differences are necessary, some are
> > just due to the changes to code over time.
>
> This is due to the entry requirements for Linux being architecture
> specific. This is more consistent than it was 15 years ago (especially
> since RISC-V looked at arm64 and copy/pasted as much as they could,
> which is a good thing!) but still an inherently architecture-specific
> thing, so yes, we may only end up with limited overlap.

Just to pick up on this point, yes different Linux interfaces are
needed, but that is not the target of this series. I am more talking
about the differences which are either unintended, or just a rusult of
there being more development on some archs than others.

Regards,
Simon
