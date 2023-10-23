Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D17BC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E8887905;
	Mon, 23 Oct 2023 18:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNMkYpSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A088B87825; Mon, 23 Oct 2023 16:52:53 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C475387809
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 16:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stacey.pellegrino@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso7161072a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698072770; x=1698677570; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rsqpqw2rfHt4mM/7dqMa5/Qeoh7k7bPaJilH1c7+YDs=;
 b=TNMkYpSsJlotzwn7oz5cOAkFcJ34gQvF0vggQBhVuSvC4T70xCQ2BfVQFiIu3KRqgP
 XVe6m/izIBKd+MENezBdJ0JSAGHeCoSbmZ6HVrk2kRtcyNmD/SzQATVLHaMeyhyh4OTR
 YCXv8kRqLhGmXTO/WWZwCifjrXOfnyVKsoIb9Ubvv0MgziiaTNJqMMHAFkIU6Iz2VoCr
 rhFx+NOKWt8UMmZGTHzy7ku2pv9keustEG2FWWKPfG9LXLKaH4lkcCdIEkNG1vHhxxZo
 oNc8AHFWZZrvdGQ3BrCRZmD7ewrdpvluAEOfx/7xjuIr3QX2FcDNlkAmXFzBypMO/m1l
 1oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698072770; x=1698677570;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rsqpqw2rfHt4mM/7dqMa5/Qeoh7k7bPaJilH1c7+YDs=;
 b=hlTiuJnBVg0weRz/JS+JWXgHwXyJWeWLw/P3pFtIbPRRMHU4TQBjsKn6IVAnJj9ovD
 vmj6MFzLU4fYIW8W5SK6EMartSKiVPlbnl6mLjcKwoXZ2yay+hNSdm/h8tG+YbB05UJM
 HUr266ZRHW67m4fHN4TZPO6/GS46apVqFCip3PUX8ton/g5aqJTiFGngI8fLRdwtStff
 Qkzc1HHh2colSwFqmhqzgt5xCMJyJK5H4ao/+uHcoAJ6BJnwf0ZlsI74p9kahNuV3+F6
 qMNnE9tiD3k1++D427JjLKSDySVPWEp9hbQyMEaHCsZs5k6IrSQDvGo3xbgcAir9Qlt/
 pSCQ==
X-Gm-Message-State: AOJu0YxLDoZXWNSreCV4Si80CSQjTXAKhYCuja3m/IzG9A6ngcvtkyUu
 MJV8ATzG32/xdUZQ1XBDdHoUJ7L53cQJC9yBLkk=
X-Google-Smtp-Source: AGHT+IETZxMDenqyoxy1I2lueooLQl3nGwjxP9FR75Rbb2VZQttu+oiE0LMO9PlxoE/FBywIALsr5edjq0NqtZtpZIM=
X-Received: by 2002:a05:6402:2293:b0:525:4d74:be8c with SMTP id
 cw19-20020a056402229300b005254d74be8cmr11859771edb.14.1698072770228; Mon, 23
 Oct 2023 07:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAKNxVbNWrLrX=rzb4RONo96AtM+G2NKs_2g28WohgCwVkFstSA@mail.gmail.com>
 <20231010-dragonish-harmonica-d28cc5ac811e@ifak-system.com>
In-Reply-To: <20231010-dragonish-harmonica-d28cc5ac811e@ifak-system.com>
From: Stacey Pellegrino <stacey.pellegrino@gmail.com>
Date: Mon, 23 Oct 2023 15:52:38 +0100
Message-ID: <CAKNxVbO6hso5JqwoNbC2rr8kfhs5cq3BgoE1XvynaxtQQ=L6Bg@mail.gmail.com>
Subject: Re: ZFS support in custom u-boot build...
To: Stacey Pellegrino <stacey.pellegrino@gmail.com>, u-boot@lists.denx.de,
 zhao_steven@263.net, wanglimei@orange-pi.onaliyun.com
X-Mailman-Approved-At: Mon, 23 Oct 2023 18:53:56 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey Alex,

Many thanks for your email response! Updated compilation configuration to
enable CONFIG_CMD_ZFS with make menuconfig. However, when using the
build.sh script it tends to overwrite the .config file for the u-boot
compile in question. Steven (CCed on this email) from Orange Pi is looking
into this for me (so I believe)? Upon getting ZFS compiled into u-boot will
then be the options needed to pass for booting a root ZFS partition
accordingly. All supporting information regarding this would be so much
appreciated! Kindest regards, -Stacey Pellegrino

On Tue, 10 Oct 2023 at 12:01, Alexander Dahl <ada@thorsis.com> wrote:

> Hello Stacey,
>
> Am Thu, Oct 05, 2023 at 11:22:14AM +0100 schrieb Stacey Pellegrino:
> > To all those of concern,
> >
> > I am in need of help regarding building u-boot with ZFS support for the
> > Orange Pi 5 Plus.
> >
> > I have tried working out the following...
> >
> >
> https://github.com/u-boot/u-boot/blob/22ad69b7987eb4b10221330661db4427e40174fb/doc/README.zfs
> >
> > The URL link above specifies using the board specific config file, which
> > for the Orange Pi 5 Plus is (so I believe)
> > orangepi-build/userpatches/config-default.conf.
> > I therefore edited this file in question with CONFIG_CMD_ZFS="yes" and
> > uncommenting the line install_zfs="yes".
>
> In that regard this README.zfs is somewhat outdated.  You should set
> CMD_ZFS through Kconfig instead.  Which means: pick the matching
> defconfig from configs/ subfolder, then run menuconfig and enable
> CMD_ZFS, and build that.
>
> Not sure if that Orange Pi 5 Plus is already supported by U-Boot
> mainline already.  From a quick glance at the defconfig filenames I
> would not know which to pick.
>
> > However, it still does not allow me to boot with root ZFS on the NVMe SSD
> > with the official Orange Pi Debian v12 (Bookwork) ARM image. ZFS does not
> > seem to be referenced in the custom u-boot source code build output as
> > well. I followed the build instructions located at the following URL
> link...
> >
> >
> http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_5_Plus#Compile_u-boot
>
> Oh you should have told before.  This uses a custom build script not
> part of U-Boot, probably to call U-Boot build.  Please contact that
> project on how to change U-Boot config instead.  Or look at their
> build.sh and figure out how it configures and builds U-Boot.
>
> > ...but am I required to apply a patch to the u-boot source for ZFS
> support?
> > If so, then that could be my problem. If a patch is required, then how
> > would I go about applying this accordingly?
>
> Although they seem to use an outdated and patched version v2017.09 of
> u-boot: probably not.  Please try with enabling CMD_ZFS in your U-Boot
> config first.  It's in the menuconfig, also in v2017.09 already.
>
> Greets
> Alex
>
> >
> > Thank you in advance for help in this matter. Kindest regards, -Stacey
> > Pellegrino
>
