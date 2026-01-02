Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD38E9410B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 07:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7EA83B34;
	Fri,  2 Jan 2026 08:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n12+NlqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C0283B4B; Fri,  2 Jan 2026 08:15:53 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15BF383B27
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 08:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-78fc0f33998so76186367b3.0
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 23:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767338150; x=1767942950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tz+06JEEDjLtia7uhQXB22Yb//YFRBpxvit2LvOglsI=;
 b=n12+NlqTqhXQjewm5OF9XB9kToOXVVMpFNjL4AfRHyM3M+DpL3uIzuYrjDykiTT+jH
 io9Wt8cu4egShd8Fv4urRKOnk4MnNUNIgARC9ZnwaF5xS5YVJ3dGhM9Yq2Zbz2lXHSUd
 hBz5DpaBZInce0X6ZhUUv9VjHNcXONy4BX544qhGPedK58p3PEWDeaDeM25kZDaCIWlL
 RLSpxmokDxdMOtZnuzHwM0TU/qGqWQg3Z7SPZ1sbLR/Et0HVw3OQpeuDh/psRVstej3K
 6AN6IcB/ezlJcvtZHXI5vytYch5X3lxuev3hN0I6eV7KCD0CRPcjlIVSGLNRSdKC8h7c
 h3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767338150; x=1767942950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tz+06JEEDjLtia7uhQXB22Yb//YFRBpxvit2LvOglsI=;
 b=NT1VKB+bHCWJ4Cf/vTH4phbp1E9bCWWe988RI/YGG9wOk99dwKdm7t4BnJBLCAfXH2
 fxzgHiPaJT/6oSjGQ6bCV6slhduhr79fKJayUJ9FWZLNC9HewWdoE6fsJ0PmIRzyQ1MI
 dALeZh2FMgiG72aaiuZVacjSjkQDaedMVABg2kMN49+qmigVavEBGXUZHTqvjVaPVdF2
 zkDoBUO5A/sEPBs6+dngEEjlK/mJU+fPI7kmFMWHhwKIbBysx21E1Xt4hdSCk2yJq9D0
 GCTQVNLIH6w+3iH6L5VQ7ym6fsC//yAFp4LEYxGA/jMlvJ6OtmYCYn/FZHjaCPnylw08
 zFvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9INSY8iyFd1EWbDtwxSF3XullMtWC1KGMSHAIzTT7TW2sDQnsotxuJ5xqeGKGrnLdflMd4E4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6lYPuhSI4ur53VKGL3EnO9znVktVzzU7J07YDShuHJ+nizHmB
 JQ6EReoLOxJI6M4gvTjKGqiqOdbdOSvm+nqJ4H6rLEJleqmzfyfmjGTSXzE2/dFzZAY5IPGptIQ
 R1Nm1RlLMXIDWO3cKdLCiFFO03Ds8SZpWTeoP4iqMPre4LcgZyd0e
X-Gm-Gg: AY/fxX7swdLtyP+YyYJfefRLGQtABxSHdvypKzOO2BS9KaQJOA8u1dAWLysYUsGRGru
 iEED9pi6saJATQvaij+ATaR0qyDgWB5+XOWCFghSlpAMymjCLungFajg/xiaPKU1PRW/KU2bKBJ
 6ALetbGKtyDRNERdHT2mZigkEydmnsSH1MtVOD4PLOLN5pyH2Cqh6zTVo7+RcepCfXxQOwApbLl
 IUm8TPZ8OMGds/2ghJ/lQcweDBw7vNxHwf8ACMCdXWxIdJC/kkAFBpUfYjr/isfaFud+eaIb6Om
 NupBx2rCiljKCI/ivBu0OBDuX4QreZhJz7IxRGFCXsV8GaqpOfbeGOVVY1t4QBjOQ/cMkaSdrcp
 sxZOSDwZmvcp8CZP+dsezSP32ppY3v1qJ1gsfJb/X/gw52jeY55YBEKeDSTWqYOwsJv13FY/B9s
 8fL6PoSv+C/Ll9x7WP46U+16XKjhdwyL1rlbUFLQLzttdvWAM7UpsIAD2nUa/Z3o+dEMYjcj1tM
 U5PyGvoF1r6VfWY2qWF4+WTix5+VkyzbTL98ikibSZzl+06UurOG9LntRepJocj4ANP3NFZvXOl
 mENsRSFRGCjY++gY0pDBekNM1GsrGJ0=
X-Google-Smtp-Source: AGHT+IETf1svtIGVUsba7LUOgMhcWklpOhX9H9GPlhnsN4WiE+WuXzV9xbm8Fa7E37h/yzJ+3F+GL0f71oINJaotWkg=
X-Received: by 2002:a05:690c:6c8c:b0:787:ca87:595c with SMTP id
 00721157ae682-78fb3f04582mr580231577b3.9.1767338149864; Thu, 01 Jan 2026
 23:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
 <20251017-usb-dwc3-exynos7870-v1-1-fe46e2ed1908@disroot.org>
 <a9c78f0b-ec57-4af6-b577-3c6570d31b7a@mailbox.org>
 <ee7311712c5f02582a5f126a299f4a8d@disroot.org>
 <da02bdbb-11e8-4375-95f9-fc142a3b838b@mailbox.org>
In-Reply-To: <da02bdbb-11e8-4375-95f9-fc142a3b838b@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Jan 2026 09:15:13 +0200
X-Gm-Features: AQt7F2r19waM2xWcvNfhVl16WUIbJJnW8lgkbbwLpk_fnJKR8Ui1iRTub90AZ54
Message-ID: <CAC_iWj+rj=tLPGA3BzAzVjwwOQiOkAka4i7xYt=zYSS6+QcFvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: dwc3-generic: allow fallback of dr_mode property
 to "otg"
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>
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

On Wed, 31 Dec 2025 at 23:29, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 12/16/25 8:45 PM, Kaustabh Chakraborty wrote:
> > On 2025-12-16 11:13, Marek Vasut wrote:
> >> On 10/17/25 5:30 PM, Kaustabh Chakraborty wrote:
> >>> Documentation [1] states that the default value of the dr_mode property
> >>> is "otg". In this driver however, this case is not handled. Add simple
> >>> logic to fall back to USB_DR_MODE_OTG if its reported to be
> >>> USB_DR_MODE_UNKNOWN.
> >>>
> >>> Link: https://elixir.bootlin.com/u-boot/v2025.10/source/dts/upstream/Bindings/usb/usb-drd.yaml#L23 [1]
> >>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> >> How does the driver end up with "unknown" state in the first place ? What is triggering this problem ? (this should be in the commit message)
> >
> > When dr_mode is not defined in the device tree node.
> > It isn't marked as a mandatory node, and defaults to OTG. That's the
> > reason in the commit.
> >
> > I will add this info in the commit message then.
>
> Understood, thank you for the clarification.
>
> +CC Ilias, I think Jerome was also syncing DWC3 recently ?

Yes, but I don't remember if the host port setting was part of his
commits. I think he is planning on sending a v2, I can check what's
the status on that.

Cheers
/Ilias
