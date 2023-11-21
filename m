Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1E8C5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73B1875CB;
	Tue, 21 Nov 2023 03:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QeNCrLS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 772CE875E8; Tue, 21 Nov 2023 03:16:55 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A10869F6
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5ca055de41dso17970817b3.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533008; x=1701137808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JiZzI77kHNl1F1CyceiEGA/Ld2MTzlidiPbTka+YYME=;
 b=QeNCrLS984+q29wIsT8oCMkofrLvDcnrDBVdfpXABCr/3EBObygYF1wDNLob/1hGlN
 IWvI89VM+55FtnYNtgp0yAtGIeXJSSsNJuXJSg7SmTDOvOje57wpsfZ9klloDxvNsOjs
 lKyJa2E22kSug5HnWFplsLIceqK8qU4RmZfQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533008; x=1701137808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JiZzI77kHNl1F1CyceiEGA/Ld2MTzlidiPbTka+YYME=;
 b=qifs0dLWsgQizNnA7ZPOIlBEc6cf1wzv9A2bgY/aq+jkw1C+koWQtJolSKzNQX6Zpn
 bndNMpW2f9z6wRHwhToszy6Hyss7tyOOipR+uKOug00bex8a58K+XQwT2PNs6OLQGytj
 uFHNC1Q+pnptICxbtDD/OUBVO4IvTJqmn5H5jaWBjuEiLzvaYHOhWLmXcGPk70W9OeHZ
 xtmvi9p74XQt3MCfdmSbwdxETFR0jiNzCWkwy464bJPwm4mwqRZes9Wpt75Z8zYELnHW
 GthJX6Ul6C1q93GvQYAgUffR4/Qx2mCBgyZ3JK1N6Hc+KHPzf+kDGSj0YKFUJk7s90uG
 0GJQ==
X-Gm-Message-State: AOJu0YyIuLBOQ/Lyid65ttsxnHRNetexvZbgHoSAbR0Ur965ct+9ijZI
 byLZ2AYwfHqoC5qiQAvd35uHHlzLM8rWIEghZdEboA==
X-Google-Smtp-Source: AGHT+IHuaI9jRAxztlUUHJtztSVplz5qIjNw/0hkY+wGlQQ/7QbVN04KIfZvwxtvTTCnNGy+UhFqs0D+zGq2jw8IyjA=
X-Received: by 2002:a81:6256:0:b0:5a7:bde8:51d5 with SMTP id
 w83-20020a816256000000b005a7bde851d5mr4268459ywb.32.1700533008211; Mon, 20
 Nov 2023 18:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20231008213646.622002-1-sjg@chromium.org>
 <777a1d08-708c-481e-bf90-46d7a9667b67@gmx.de>
In-Reply-To: <777a1d08-708c-481e-bf90-46d7a9667b67@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:10 -0700
Message-ID: <CAPnjgZ2V2Nc9k6ujMZT2Wyo7C-nVSu=h++_rUv6rvmK0rG3s-w@mail.gmail.com>
Subject: Re: [PATCH 0/5] smbios: Deal with tables beyond 4GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Mon, 20 Nov 2023 at 18:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/8/23 23:36, Simon Glass wrote:
> > When the malloc() region extends beyond 4GB on ARM we may end up with
> > an SMBIOS table in that region.
> >
> > Add support for writing an SMBIOS3 table, which supports a 64-bit
> > address.
> >
> > Note that this problem does not happen on x86 since it requires the
> > tables to be placed just below 1MB in memory, unless
> > CONFIG_BLOBLIST_TABLES is enabled.
>
> With this series applied on qemu-riscv64_smode_defconfig with 8 GiB RAM
> I get this output in Ubuntu 23.10:
>
> $ sudo dmidecode
> # dmidecode 3.5
> # SMBIOS3 entry point at 0x27ef28000
> Found SMBIOS entry point in EFI, reading table from /dev/mem.
> # No SMBIOS nor DMI entry point found, sorry.

Yes, this is the v1 series, which I abandoned.

I suggest we do add SMBIOS, but in -next

I can take another crack and this series in a week or so.

Regards,
Simon
