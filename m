Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27C7C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F38387E3F;
	Mon, 18 Dec 2023 16:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N/DnmBsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52C487E0A; Mon, 18 Dec 2023 16:02:43 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7117D87E39
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e4ee907295so17525317b3.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GCKDvNovtKE0EcR9IpKhMa1/OfxtG39pQlf/LDyqMhU=;
 b=N/DnmBsgsbKLjIYP5YBoPzTx9Kkmr2dgo7Bjr5XteO+LwTMvta5oeNwXkmIaXKuJoE
 O3KpuxJjppkQap9GNz1eRFWbFR63cjA73BvI5Kk86V8Qw6uKZV5MHQJ/U782IzJntR1N
 KbmG6ihmtaKOxOZzvk4Rr9PhMGsY7pZEvA3WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GCKDvNovtKE0EcR9IpKhMa1/OfxtG39pQlf/LDyqMhU=;
 b=sp1awMRzOFS1ch0lKUMitpCOg56D28XJY6RQQLcikeTPzOBzHkvgsb7kV6KeLbn/0J
 WRbFWDFbqJrpE11au/o7d22PJ1yR/GWFSJyiSAwIRqSO1Qhs0X/TBLBeT2Judc3DdO+D
 UzVpvaC2v69xDMaE3CzRqU+b29O9Bo789pySJBearbWh2gvKJKLhW3ym7Un4ER3eDP9y
 eu0Z88qVgfsyA88DycJwS4+8gSYfFVdslzc+0KPW6X8N4f9v1RgcNbFfsHMMyeF8OXCQ
 j1yKyQM51rtQBW0WXxUiaCP/dBEGQEMRSZGXH+71B7AcYoz1ykcgw968Dqp387oh12Ht
 SJCw==
X-Gm-Message-State: AOJu0YyI02PeMAg/5Tsxke4+tECJmDkSqfIzQuPTZZ5Y6SMG4TEyeweW
 Cq3qBeHiKaeAgjgyvZAwVEjNwZO+Nhya/wE0VlM6cg==
X-Google-Smtp-Source: AGHT+IGL/9p8q4SYSV4ciQSSEzaDe3X268N33wcsy7oNS3GavtEvEZMBWamMKCTgs2Uj8x3IKjkM7hRz8luRUU2SEm0=
X-Received: by 2002:a81:7285:0:b0:5d8:74e6:e4c5 with SMTP id
 n127-20020a817285000000b005d874e6e4c5mr12436721ywc.98.1702911752805; Mon, 18
 Dec 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-9-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2C45f_WhDQz5TKk_THVh5HZ8t6PzozKZ1ROF4r16Cw8Q@mail.gmail.com>
 <3dd6f971-0c2b-402f-b6ca-0821f8cccfa3@canonical.com>
In-Reply-To: <3dd6f971-0c2b-402f-b6ca-0821f8cccfa3@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:34 -0700
Message-ID: <CAPnjgZ2hhOhQtcH0DRLx_tPaGowA=Jbr+n5DcQ6+fjijcS1LXg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] configs: qemu: add config fragment for ACPI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Sat, 16 Dec 2023 at 12:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12/16/23 19:46, Simon Glass wrote:
> > On Fri, 15 Dec 2023 at 06:33, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Provide a configuration fragment to enable ACPI on QEMU.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >> v2:
> >>          no change
> >> ---
> >>   MAINTAINERS                         |  1 +
> >>   board/emulation/configs/acpi.config |  3 +++
> >>   doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
> >>   doc/board/emulation/index.rst       |  1 +
> >>   4 files changed, 28 insertions(+)
> >>   create mode 100644 board/emulation/configs/acpi.config
> >>   create mode 100644 doc/board/emulation/acpi.rst
> >>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Are you planning to enable binman to build configurations with config
> fragments? This would be needed for testing in CI.

We still have not decided on a mechanism to name things which are made
up of a base config and a fragment. The current proposal is [1] which
I think is probably OK, but I have not tried to look at this in
buildman yet.

Regards,
Simon

[1] https://patchwork.ozlabs.org/user/todo/uboot/?series=380278
