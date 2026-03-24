Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61679F54AAF
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 13:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36E8807C0;
	Tue, 24 Mar 2026 14:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZBwkojXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494CA82A9E; Tue, 24 Mar 2026 14:19:50 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7A080087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 14:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linusw@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 90DCE44562
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 13:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728D9C2BCB4
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774358386;
 bh=sUwWBN+L5vBt9MtcOkpmh1ZOM7hZjiguyxrPzePsaKY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ZBwkojXHCEuqyjJnqLbKWotstbK7ZjE2NNZDrmMjagJCAmEJxNPpWr5dnWC2XRb3K
 6SZ17Qi8wlHH8f1SXfgOg0v77Fz72v/Ztj/3BIccauCldcySJ5fenExVF2mYDMGS1d
 Beq78vhQTVkEPoYOKV0s1OywqSBalDb88eu956IDIfwykmmLVZPc/fDSEFiD3lwjsE
 b0wQ075w2rBHV5KKbwAJrPiXp7D1ZnPaJ71oFxmi7t0iFBbVcV4ljGd0ZC9djVhyyk
 EDZiJ8xyX+nLza+86ZRtpBDgj1mYIhvXwVq6lkyshWuGjmwxPxM06m1dSoISJkr3Td
 XP26s9Dwqa1Kg==
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so1186342d50.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 06:19:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWMMqwnqgiDPipJ1XAntChb8uGCfAvl+xt92TvB0yPmkZYziyV+4kY3vKDw8OnBwf9AV0r7Tns=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9vGyTgPTdVGNrdtB6CPge4666XunGhfVeiHaBAO09fYtcNijY
 hxDQp+nO0140CCmdARo6pP8Zy8x//6HoL5rTQGYp0zLk3dcWm5+mRyIkqGyaJoFFpspC7vx3ZHR
 xdWtkAlFAY/yZMCEivr+NtDsW+UmSw5k=
X-Received: by 2002:a05:690e:1a52:b0:64e:c68:8ee1 with SMTP id
 956f58d0204a3-64eaa69ebe6mr11550490d50.8.1774358385617; Tue, 24 Mar 2026
 06:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773256350.git.dan.carpenter@linaro.org>
 <1048331f5d3c8e0cdbe1542bcb65bbf942a4275b.1773256350.git.dan.carpenter@linaro.org>
In-Reply-To: <1048331f5d3c8e0cdbe1542bcb65bbf942a4275b.1773256350.git.dan.carpenter@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Mar 2026 14:19:34 +0100
X-Gmail-Original-Message-ID: <CAD++jLmfRVGGHH1EqMAeSVHVCr1-s2JPyuY_w=2h35_mKUXj2Q@mail.gmail.com>
X-Gm-Features: AQROBzD_rVrAsbDukAvkngaYGMUewIR7TXu0vqz0CaG8_h0ydLheVygvbWR3rso
Message-ID: <CAD++jLmfRVGGHH1EqMAeSVHVCr1-s2JPyuY_w=2h35_mKUXj2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] scmi: pinctrl: add pinctrl driver for SCMI
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@denx.de>, Greg Malysa <malysagreg@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Yao Zi <me@ziyao.cc>, Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Anis Chali <chalianis1@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, Ye Li <ye.li@nxp.com>, 
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 arm-scmi@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>, Michal Simek <michal.simek@amd.com>,
 Cristian Marussi <cristian.marussi@arm.com>
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

On Wed, Mar 11, 2026 at 8:41=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

>         scmi_pinctrl: protocol@19 {
>                 reg =3D <0x19>;
>                 pinmux1: pinmux_test {
>                         pinmux =3D <0 1 0xFFFFFFFF 18 1
>                                   0 2 0xFFFFFFFF 18 1
>                                   0 3 0xFFFFFFFF 18 1>;
>                         function =3D "f_gpio1";
>                         groups =3D "grp_1", "grp_3";
>                 };
>         };
>
> Under linux the pinctrl subsystem will parse the function and group
> properties and use that to handle muxing.  However, under u-boot the
> pin muxing is done using the "pinmux" property, which feeds raw SCMI
> pinctrl PINCTRL_SETTINGS_CONFIGURE commands to the server.  The
> numbers are: selector, identifier, function_id, config_type, and
> config_value.  In the example above, it sets pins 1, 2, and 3 to 1.
> The linux-kernel ignores this pinmux property.

This whole thing is a bit of a hack and shortcut to make hard things
simple isn't it?

The information encoded in the pinmux property is identical to what
is found in the function+groups property and that is why Linux does
not use it.

Also device trees looking like this will not pass validation or be
accepted into Linux, as it is not part of the official bindings, nor
will it be, so it creates a necessity to maintain forked device trees.

If U-Boot want to do things this way, I understand it: it does make
the pinctrl default set-up simpler, especially it makes the code
smaller and easier to write, which is something bootloaders like.

I really can't endorse it though: with deviant device trees and
information stored in paralllel in two places we create a
maintenance hurdle.

Yours,
Linus Walleij
