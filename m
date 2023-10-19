Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF36CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97638717E;
	Thu, 19 Oct 2023 15:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iuVI9oHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC908718A; Thu, 19 Oct 2023 15:59:43 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06A2B8701D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507bd64814fso4305482e87.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697723981; x=1698328781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vmAtKVINV76NcV5Md7MQ1O5/YgdqCTC+YY9x4Eu25ZA=;
 b=iuVI9oHK9CtQL8Kfu7eTDkHJZmVg2W+efh37ntpG3NM2CZfMDuZhNFy2phpyzgyowD
 KeJDnPGRMmmt+4ueaPIYkJCTPdOuKCgW/8S4WDh0qhJRRzGHdg87TD2FH4mDslUCNyB8
 eM6sTDOIoLDpEU3GX5I0qc9P0cNLcAg/faAvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697723981; x=1698328781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vmAtKVINV76NcV5Md7MQ1O5/YgdqCTC+YY9x4Eu25ZA=;
 b=Xutx7RpclaKUEmZ7/3KXyZqFdubVbM0+grhZuQI7FUOQu5nuakbuq3O3hYrK1/L3q4
 DCj+dyhm9OQxWyXwruDgA+CKYCXcIQ//SFRKRj6C52x90NQLvqu+Fk5PQ4rF4pkPUARj
 tPOHS4dcPXPl86wG3PyB8WEQHv94Xinkw6o621NIp8BHhrerzQzDGYZGqVy2/IEVcUKx
 aPAJADUuCsHE+qSKl8QS2PQjH51CXHylPUxULIfk+fvuRHQc5guAsCcbHJ82Y+rSM37U
 C5i1moKJ7mSYTJc4OU05y6utII2c0Fv9xExtO3bMRzFeGQfQ7J6bApLMbmM+AKRTyUwo
 Xq9g==
X-Gm-Message-State: AOJu0YwpAS02j5NE8yeUhgt3JifHkcZGutUq4d3A/5dnVPPY9AQ7ZqVo
 6WOQ9gR2wFGCxp8DB+CQgF8gLyTaWFC7F/+/q37/8QyImouPYKE/p6w=
X-Google-Smtp-Source: AGHT+IHJ/dNbVvGo9Na8OBMiJQqjGND1eyoajx05p6Ppayjr1noKFne3hSrBcr744pstcaAdP/60CtGPXVhvCCeIfVU=
X-Received: by 2002:a05:6512:34c6:b0:507:98d0:bec4 with SMTP id
 w6-20020a05651234c600b0050798d0bec4mr1499776lfr.54.1697723980861; Thu, 19 Oct
 2023 06:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-15-sjg@chromium.org>
 <20231017140216.GW3119521@bill-the-cat>
 <CAPnjgZ0WmpCGbV8a8Ri7+myZTMSw-3R5QjP_kY9qvU3-2JOuKg@mail.gmail.com>
 <20231018123947.GN3119521@bill-the-cat>
In-Reply-To: <20231018123947.GN3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 07:59:29 -0600
Message-ID: <CAPnjgZ2rHNvKBESAc8=4ajKDYwn0HrBhyrt1yEFhncQXH_QHxw@mail.gmail.com>
Subject: Re: [PATCH v3 14/32] bootm: Allow building when cleanup functions are
 missing
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 18 Oct 2023 at 06:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 17, 2023 at 09:31:04PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Oct 2023 at 08:02, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 16, 2023 at 04:28:05PM -0600, Simon Glass wrote:
> > >
> > > > There are two cleanup functions needed during boot which depend on
> > > > CMD_BOOTM: bootm_disable_interrupts() and board_quiesce_devices()
> > > >
> > > > Provide static inline versions of these for when commands are not
> > > > enabled.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > NAK, these functions need to be available to boot the OS, regardless of
> > > command line existing or not.  Unwind things in the other direction
> > > please.
> >
> > That won't be a successful strategy. See my other reply on this. I
> > have had this idea since 2016 and have looked at it every now and
> > then. With bootstd it makes more sense since we actually have a
> > framework to boot without the command line. This series enables such
> > work, but cannot include it.
>
> I don't understand.  The "cleanup" functions here are to ensure that any
> devices that we've touched are in the state the OS needs them to be.
> It's not "we ran a command", it's "we loaded something off of USB (or
> network or MMC or ..)" and so we must have those called.

Right, but they are in with the bootm command code. We could pull them
out, but it is only a partialsolution. Really we need another series
to allow 'bootm' booting without CMDLINE. In other words, we cannot
boot most things without cmdline today. That has been the case before
this series and unfortunately this series doesn't change that.

At present we cannot even build without ~CMDLINE - that has regressed.
I am trying to patch things up and make it build and add a test.

Regards,
Simon
