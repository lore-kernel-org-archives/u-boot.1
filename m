Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EF1C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7165A87E13;
	Tue, 19 Mar 2024 13:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k10MFf6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DDB87E7F; Tue, 19 Mar 2024 13:47:08 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073E886D38
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e704078860so2624076b3a.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710852421; x=1711457221; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fveYhxUtSZasJeRB4CIuypgOaVCPrIUJ0bBkKiQ2IwI=;
 b=k10MFf6boHtMKQJSQu32PvMWQUrvT8bPZxaUJjPEahaL037FmCknGmpXQkohTYRX3J
 2Pm5B4mSkf5PlEElSfYpxAveE/M9VaKt6i74T362YtfQCwcA5amXD95SqDlaVETOWh1Q
 6/6dpU4o1FvZI1+K4bYrglA41HI1tKM+iH2GDjfP0u1Z8Zlw1HZXUazf6MvdJqU94cvk
 r2I2+zFFsJ5Ka5fIMDIeDVNDPk+4zn8ph+B3zwrKDbMdHdsWByeT4tvhSIrOgF2FdHdc
 HwGbdGAIY6wZ9KsfPL382JwohOKk3aTkOpeIZJHc7WLZ4lLOE7qO0KMEe6Zpe3tiNlBm
 dHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710852421; x=1711457221;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fveYhxUtSZasJeRB4CIuypgOaVCPrIUJ0bBkKiQ2IwI=;
 b=Qbg5FT1MEEsvX67nU2jTeigezzPv/1IhKTqRCbxHU9ohVsXIr2T3ZbO+7ZYTh1s70E
 WpNdG1RvNWHtchzuD1L3x+6sUGdT2anjcVe32BXArzHrd+VtAU6ssGvLu8qb+/f1WTa+
 DHnpXyY19El3KflLAF9Nic/u6yeUnAT71JAV6L5a7l/M6tclmYM6O/to8BuKtpo3B7LN
 kjeB5JVhDTgVjZGE/cUy8MfPE6Eek/ZYBN8cWhYfy9Pizlb93AZwEan9lTaofEZ7eHDU
 3PBbXHpIOsR0WNnnpAiReTfSPJNzvNvm+zVsO0s4WsqvzlHFYncdqBkwEKfaRbpwmWEr
 trYA==
X-Gm-Message-State: AOJu0YzeAzoo6nfn5WKxrbfIWZLCeCSLTznOGhaSRaijl63B5x1g3xiP
 yXh6LXoxcdHrNBjZFRWTafYu2gVmVYKIdtMwER95yr8EONwnxHpqOKifdPElMDgePXxnFFQNDq9
 3fviA192sYfjSF8hdvUDg9dxklOTiQ6y1
X-Google-Smtp-Source: AGHT+IEODyCWv1skJxeE6ZuP5IO0D+68MpaoHpVxLxel/Tc25wl+I025IT3rGc0bkI77UFEaAeYCHDUZ9hxa/9AZdmw=
X-Received: by 2002:a05:6a20:72ab:b0:1a3:683a:2cbd with SMTP id
 o43-20020a056a2072ab00b001a3683a2cbdmr4798316pzk.17.1710852421224; Tue, 19
 Mar 2024 05:47:01 -0700 (PDT)
MIME-Version: 1.0
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Tue, 19 Mar 2024 13:46:50 +0100
Message-ID: <CAHseuWC04cj0EMDLcVzOihVhcZdROXZWjK23DTAe7K9J7H=SRA@mail.gmail.com>
Subject: How to handle multiple boot scripts within boot partition?
To: u-boot@lists.denx.de
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

Hello,

I have a question regarding the loading of boot.scr file by u-boot. I am
working on Raspberry pi-u-boot setup and would like to store multiple boot
scripts in the boot partition. For example, what happens when I have
multiple files like boot-rpi4.scr, boot-rpi3.scr in the boot partition? How
can I specify within u-boot to load a specific boot script? Can I set the
load address for different boot scripts?

I am working on Raspbian OS and I am trying to use the conditional filters
within config.txt config.txt conditional filters
<https://github.com/raspberrypi/documentation/blob/develop/documentation/asciidoc/computers/config_txt/conditional.adoc>
to
load different boot scripts & kernel files based on different hardware
models.

Please let me know if this could be possible in u-boot.

Thanks in advance.
