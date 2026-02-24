Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3399FEFB7EE
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 09:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBC283D3D;
	Tue, 24 Feb 2026 10:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B+F/rSlR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD3883D8A; Tue, 24 Feb 2026 10:33:57 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B89D83BC9
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 10:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linusw@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 20A436111B
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 09:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6964C2BCB3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771925632;
 bh=SuL6pth4ioT31DfBcqxAotMpYtbob7ZaDZ5zIZ4ZVZY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=B+F/rSlROH8cfmbnAj6tWp/pcTqbqtdihhbBqJ52cnrMsAUQTicWWgNsW4LwaIRgR
 MmuZWJTn5bKa2KmjQlUyJ2pal094QRCnH4Ig5vR0433FqZbUllkYnMfqOGVJoChfZU
 ctBtsnGflnqALQ+NwBZQBgyYxbjjrWJUhD1WH7mmghhTfQDw2NLkOSDCEF25jJN+qt
 CAecSxoU6QHojGPJNDPNTVeHLYBEtOSxSbWgFQ5XIezTG5uDApmaVm5pHXlmNn+xAI
 kZcXPP11qZXYBfqgG7vdx83Zp60RVtWBnJsv1yYYxAssbDWEtpQRY2qPiP0qbQX3MN
 K+7Sc9MvkbiDw==
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-797d6f934e2so51621737b3.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 01:33:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWty9Mz5mHlN90YyI2wjdTAy2f59aIshnvFkfVCBm9f6cnIHBsHi/N4/y6QWBu102ALjnVwxfA=@lists.denx.de
X-Gm-Message-State: AOJu0YwkNi+fkRq2IhmYog00ZQ2LM4e1pIfJtQXinw0NFk3Gxxu119dL
 q6jcCXTufKCOMxiJ+QObb5I+2Yu1tSplJMfbq/MISzGuOuieWnXlXHfmIv6ekPW0QvMc927rCcI
 JZpGHtGCvi0u5Np7pT9WvvJEnh0uasOg=
X-Received: by 2002:a05:690c:e:b0:794:ff4d:9233 with SMTP id
 00721157ae682-79829174e81mr116805647b3.59.1771925632028; Tue, 24 Feb 2026
 01:33:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771856828.git.dan.carpenter@linaro.org>
In-Reply-To: <cover.1771856828.git.dan.carpenter@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Feb 2026 10:33:41 +0100
X-Gmail-Original-Message-ID: <CAD++jLkWsgENcCxqnYmkP3kgdWJFKJ72_aZX1r_Qjjc+_q5qGw@mail.gmail.com>
X-Gm-Features: AaiRm53mXlP6ro7ZopYdVjuysdkzv8vVDtuaFLVGv5D--fvV3r8CikAJanK8DVo
Message-ID: <CAD++jLkWsgENcCxqnYmkP3kgdWJFKJ72_aZX1r_Qjjc+_q5qGw@mail.gmail.com>
Subject: Re: [PATCH 0/4] u-boot: add SCMI GPIO/Pinctrl support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Anis Chali <chalianis1@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, Greg Malysa <malysagreg@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Jacky Bai <ping.bai@nxp.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Philip Molloy <philip.molloy@analog.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Utsav Agarwal <utsav.agarwal@analog.com>,
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Yao Zi <me@ziyao.cc>, Ye Li <ye.li@nxp.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>, 
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org
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

On Mon, Feb 23, 2026 at 3:33=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> There is an existing SCMI pinctrl driver in drivers/pinctrl/nxp/ which
> lets you configure the initial state of the pins via device tree.  This
> patchset is a more generic version which provides GPIO as well.
>
> I wrote two small cleanup patches to the NXP driver, one which renamed
> an enum and another which made some white space changes.
>
> The next patch adds an pinctrl driver which lets you configure the
> initial state for the pins.  But the main thing is that we need one
> driver to handle the SCMI pinctrl protocol so the pinctrl driver does
> this.
>
> The last patch adds GPIO support over SCMI.
>
> I tested this code using the SCP SCMI server on OP-TEE over Qemu.  I
> created a custom mock pinctrl device in SCP.
>
> Dan Carpenter (4):
>   scmi: pinctrl: add pinctrl message IDs
>   scmi: update comments for scmi_pinctrl_config_set_in()
>   scmi: pinctrl: add pinctrl driver for SCMI
>   gpio: scmi: Add gpio_scmi driver

Looks good to me!

Believe it or not but I have not even the shallowest knowledge of the
pin control implementation in U-Boot. But for advancing this I can
at least provide an ACK:
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
