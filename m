Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F428C4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 20:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E2887B05;
	Mon, 12 Feb 2024 21:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RxYSBxDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D843587B3D; Mon, 12 Feb 2024 21:44:55 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BBB7879DF
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 21:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-46d239a4655so570092137.2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 12:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707770689; x=1708375489; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hQdObcl6o6xYxp46gERjvMOQCPmJjeO3tkoC5r52lQ=;
 b=RxYSBxDt6KX+hN0FfuToG5M88lQcLhteM3iOqDHfBXZRrnXVtYBgj2ZyhbGrJllfW7
 7poIMgbvvmhzwMVisRPQ2ztX6/uo9E2B4VkIKf/ekf2o0DFoEK/Nuxni3Yq880utajsA
 N0UqL1FMqOcUMsx+rgVBJQFmWUM+AwB7WFh23YLVTyNh2hZ/X6IF1+HjUCzHp1zaEScY
 b+iNLPzbtA8gmmRxjS1sfyeau/nscROwbv511bpQSm2e8aFAOVhopQ4X3xJ2rOnrRZhw
 rcoEHX0g/qPzVeHp+2T4LMy0W7bmc3vhtUrGTuuWaCJ5H4jLVstoOPC0WSWWf0zkT1EX
 57FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707770689; x=1708375489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hQdObcl6o6xYxp46gERjvMOQCPmJjeO3tkoC5r52lQ=;
 b=HKYnrSO4i1w9KrphaOos1gKR/asjP8Y/m2dV0QjJRL7V1QfmIy9cNvLNMFISFZdjgO
 1bXbQA330pUrt3Vt4UHgTrVuKQUfTmn47LZZOo05euKMCB33r8JAvlgedXfCy/lu4/60
 S7CsWSzc4abyJN/hV++12SiOyccKOac933dDfrAN7z1rCwXJObLPSdbOJ9fLHjXRhcO1
 mjGYUgkqfN54A9LQJFT8PEwsCv44uqroIjMwil5CIi/oE5WvG4qbFP8td2ncILFtFTFa
 uTLfPJoO9WDek3BHYCqJYwCmRu5e3XEtfGLVfK8aVes6mqo1HZDAHF0RUDFHytUPoZG4
 6Gtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlZfPNJAa27SFv9aHIBdC8HbgyzXfCh+ZIZkBDA7jwU22mCrb87eWkdUXxKLw52JnQ5q3lP0BtzJgrSFhwbPWbrGQ2/Q==
X-Gm-Message-State: AOJu0YypdEIGpSts23JdbqS016STOCNVnfn32oYW3c1sMWW7AE9z+Qlu
 L75mUvuRO2XzPfVGbOlOa7QxzQG9Xr6AyvmMzet2TcbOwLQs+9MGWqvDL2E5KP0HFbkFBVjdQfD
 HT/6HiMEcnlIikgmsaJVPOlW9y10=
X-Google-Smtp-Source: AGHT+IHwfqf70liivG0gvgGuFr6AfKGZJyZh01x7oQoe9qcKoUNLejo5ibw8QGQJFGN6z8XyJMn26GQNZWC59xPw3x8=
X-Received: by 2002:a67:fe45:0:b0:46d:3c29:1ad6 with SMTP id
 m5-20020a67fe45000000b0046d3c291ad6mr6695543vsr.21.1707770689155; Mon, 12 Feb
 2024 12:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20240212155332.541949-1-nm@ti.com>
 <20240212155332.541949-2-nm@ti.com>
In-Reply-To: <20240212155332.541949-2-nm@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Mon, 12 Feb 2024 14:44:22 -0600
Message-ID: <CAOCHtYjBCeHa_gT41NyRkuHOi0xkGrXFHxSKfSObWaTWdahyig@mail.gmail.com>
Subject: Re: [PATCH 1/4] board: beagle: beagleplay: Enable 32k crystal
To: Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, Feb 12, 2024 at 9:53=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> Enable the external 32k crystal similar to that found on other
> production AM62X board. The trim settings for the crystal is board
> dependent, so the sequences tend to be board specific. Since this is
> a configuration that needs to be done prior to DM managing the system
> and all other muxes get set, do the same from R5 context.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Tested-by: Robert Nelson <robertcnelson@gmail.com>

Yay, WiFi (wl18xx) now works on the BeaglePay with these 4 patches on
top of v2024.01-rc1

debian@BeaglePlay-57:~$ dmesg | grep wl
[    1.892839] wlan_en: supplied by vdd_3v3
[    8.437425] systemd[1]: Expecting device
sys-subsystem-net-devices-wlan0.device -
/sys/subsystem/net/devices/wlan0...
[   13.241739] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
[   13.246116] wlcore: WARNING Detected unconfigured mac address in
nvs, derive from fuse instead.
[   13.246155] wlcore: WARNING This default nvs file can be removed
from the file system
[   13.253088] wlcore: loaded
[   13.788451] wlcore: using inverted interrupt logic: 2
[   13.842464] wlcore: PHY firmware version: Rev 8.2.0.0.243
[   13.938371] wlcore: firmware booted (Rev 8.9.0.0.83)


Regards,

--=20
Robert Nelson
https://rcn-ee.com/
