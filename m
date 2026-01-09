Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4BFD26D92
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A57D843BF;
	Fri,  9 Jan 2026 19:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jJ/Dry2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D1284382; Fri,  9 Jan 2026 19:01:02 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F326484206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so8676858a12.0
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767981654; x=1768586454; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R1K2lKg5x8DxufrQ0pCSlg7rHjVgCk5NTeRhyYMPKY4=;
 b=jJ/Dry2Es0KlGdaWYpB5rs3aHSpTfhBsmUZ1t4orjCpS8rZRCaxBDyy4a8NeSv+6Xf
 oLZ9drC41VHloxW3WXVQ2MVWmWd9Oe6MGix3O+/RLDlSll9gIeU3OdKr0dVB6N3higCL
 7xprzOanuJIM6Bf2TvNJq6mp2+FA+HGOVoBYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767981654; x=1768586454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1K2lKg5x8DxufrQ0pCSlg7rHjVgCk5NTeRhyYMPKY4=;
 b=cLkrMszXv/HSoYCjEZMcldTf2oNbDtEibhIWXhKzjHTKyPCJlE121SIiBq+vSx/Zlh
 T+u9mr//RM87aFwPrk/SlDEJcboMazH6zq59VB0BXG70hHAN/NRFPyHsWlbIzLH1S2yb
 rJj65OrKcFDjauWapN03Q2XI+xkFGMbeqdd76foWlbTDKBuEoHutjf0t+Y0WG4LM1ngj
 F+QSLAaRIzYHL1efAqys5G+yunrR07B4tOcVaRX8DW8nKxmSH3FLOnRTWLENYpzm/ftv
 uJ4+mfUHy4lC3LpwB7WMu6UI8ZzTIZ9Lzo+rTqXexYtwFqf8osz4Vd9sLXoIS7fzm/9X
 s4SA==
X-Gm-Message-State: AOJu0Yx3sfYQh45pljPrKDfW95T9GG1IzKxeGFGzthM+c3Z+3U5l4YXA
 1s1/dlr0cx20/HmnUA+MEWD947yKMc89ayry/yt2Wq5ez4YjRfkkHB5BG1/lx3Mv1M+9L05N6e7
 AONvpzHqlr4evDlyZ0o9oQDUaSmZELqedowwdqQpV
X-Gm-Gg: AY/fxX6XGNQUUx3mLXLU5LolIvrJG7AM0MoZtmq6Hx5rhtHiAOdd9Et2nps60q/BjQt
 mIVVkr/lezDW2eolqil+lXShip2NjcDkxa4H6ryMUTBoJoxk0B9PKTreOvgjr2sG70Sjg6uO8y4
 lUdVx+Nn02EyIqE0dgmKPDIWswKenN3bDyK/LvQhwiKMy+CqwhiCfw/Hb5Ng8nEnvrHjkJ9zjg4
 H+8DWs6sBCx78gqr5R95Hu7gFqshzy4764t6BSQIZecqrDSGW+MnEJjL++/G5e7T1ehhg==
X-Google-Smtp-Source: AGHT+IF9vJFZ/l+8Fg+tLrAET8ehv7icFaHev/Uq8YSZisTgJZHsUosIIjaN0jIAtbumfjm7pxs7j2vIidXRd0HN/M4=
X-Received: by 2002:a17:906:9f85:b0:b84:40e1:c1aa with SMTP id
 a640c23a62f3a-b8444f4ab8cmr1185633166b.39.1767981654367; Fri, 09 Jan 2026
 10:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107010416.GM3416603@bill-the-cat>
 <20260109165700.GD3416603@bill-the-cat>
In-Reply-To: <20260109165700.GD3416603@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 11:00:41 -0700
X-Gm-Features: AQt7F2rNE-h5-27nFPThHcUO2cjBWKDZHxEYOkmJsOtPf1r-lP20NK0CiVPkL_E
Message-ID: <CAFLszTibc577gopg_biatH45h-iPsesjB+fa-2xZ9=cMzRS9ig@mail.gmail.com>
Subject: Re: [PATCH 00/10] bootm: Clean up arch-specific, pre-OS clean-up
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Adriano Cordova <adrianox@gmail.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, Bin Meng <bmeng.cn@gmail.com>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ian Roberts <ian.roberts@timesys.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Weijie Gao <weijie.gao@mediatek.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 09 Jan 2026 19:36:35 +0100
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

On Fri, 9 Jan 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jan 06, 2026 at 07:04:16PM -0600, Tom Rini wrote:
> > On Tue, Jan 06, 2026 at 05:31:17PM -0700, Simon Glass wrote:
> >
> > > Each arch does something slightly different before booting the OS. Some
> > > archs even do different things depending on the CPU type.
> >
> > Not that you should v2 anything right now, but, all of your patches are
> > doubly signed off, which is wrong. And, since you're no longer at
> > Google, for stats purposes, where should your contributions go (and
> > would you like any previous pages re-generated) ? Thanks.
>
> Following up on this part, as I need to at least update gitdm, thanks.

From now on you can do Canonical but there is no need to regenerate
anything, but thank you for asking.

Regards,
Simon
