Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E59ECE7B05
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214BA840D7;
	Fri, 14 Nov 2025 13:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jmZlb3kV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 335E0840D8; Fri, 14 Nov 2025 13:44:38 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C70D838CE
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3437ea05540so1965015a91.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763124274; x=1763729074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tXXqbkTFx6Du2zvnPyMLP8JBdZbr/l+2jRVjwq/WF8o=;
 b=jmZlb3kVY8ShTRTLq4cmX/ofuJnVNps65ntzkuvChBHtAYbFt1NcsLUvsdQjayhJxX
 DVN3JBWZKLB9IjrRQc5BoyLgteX5CXnD/75TPOLHkh0niKbV32rBjr+EzaOVHlSFi/DS
 H356Fs1sVorYed4stJ00XheXTpqy3AgjliTHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763124274; x=1763729074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXXqbkTFx6Du2zvnPyMLP8JBdZbr/l+2jRVjwq/WF8o=;
 b=WPRlWQaupEAUDN7zEKwofA1fLZXMmoM9jzHBnWoEdV4M/3lvnOP/bsVbrzPWOZMPkc
 fgXoVwQzYqWfOZgipv821GSDrHm6WnjK/p6Zp6MW2YAutmTriO5H5ApKbnYg8viFK9vI
 GGdwImdZOp4/c47loKzADveZ/sTRH/ut3H8mmaTJdtr5g9n7IaKzKe9C9Hj82AziSoso
 jPDBKGy6kIHPJs6H6DrsFBW7X6PTzy57wo5XhEStTUA4sgz2aKk378QBXaswbrxH4Ai0
 dhvjA9OpSO0EjCx7bSpe+sbhWuHGqP+E1iY+obgGNUHUC7/iX94GJKmfmsAtKoh+WX55
 vV5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjJ+Gj4NWWfnn0ErAnPL8VRFacGjs9rQUABL6xVdsz4dpPlqQSda20FiaraPrXt1aoo/ns0YE=@lists.denx.de
X-Gm-Message-State: AOJu0YzFXPh25xV5nXpZXjnqSqAHrJGGG+NI/sN/mfrABEXspGq+vJ3s
 HXl1ehzutDqHD3llCithBXFnAX7RgiA5MaJC6DoactiBkCpN3LVRKcW/j7Gm5hSinpOqKFoSuMV
 sEbYvq6gw0/dPP2vFy67Bq3oKS+k4IA942qyWNc6O
X-Gm-Gg: ASbGncvglagranE78S6hFed3xydW8ka4KoC5ZfKrXuP33nAU+em1plUijvWfoOwG0ue
 RP8RnHvtz3ryqP20rKQy72ggDPekB/sBEXdQ4hiOLfF9lpb11w1mD3swJssYA1HspGvdMOOZ1X3
 kk2yuYuCmdD2eHDkHiXkMKXw6KNqFmgG5x3fOrteShB6BpJcugM/WzQOGjot0EBYBPfpHDOKYRG
 iXJJeNwDZaEgC3AedRwury9FGxxJAScsuy5lPlan+60OoJAz8iZzobpNSlHwAnRR/MDlYTkcCLK
 AHU0jC0rg5PnKsk=
X-Google-Smtp-Source: AGHT+IEfCA9m/mEzlU8h0kl5mu7qTiqdUN4yr4AtKZxQfQ9AVvwOMD6iH8HVVqrUmeb/Hq7vU6stATDLw2CX1U1nE3A=
X-Received: by 2002:a17:90b:2d85:b0:340:bc27:97b8 with SMTP id
 98e67ed59e1d1-343f9e9fed3mr3412183a91.10.1763124274545; Fri, 14 Nov 2025
 04:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-8-heinrich.schuchardt@canonical.com>
 <CAC_iWjKmwO=UGpGoHG3E=P+6mkSBS1E0n-WFxX0SNj6nTwC7Mw@mail.gmail.com>
In-Reply-To: <CAC_iWjKmwO=UGpGoHG3E=P+6mkSBS1E0n-WFxX0SNj6nTwC7Mw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:44:00 -0700
X-Gm-Features: AWmQ_bl1iI8ySvp889Jc63wXUFX-6cFbLNmXsD7pmP8XxT7DBCmepnjXa9kjJ8c
Message-ID: <CAFLszTgsN0VBtTFMR9Pz6hgDrQJVw0HJ3NBBf-SsfPN6Bzi95g@mail.gmail.com>
Subject: Re: [PATCH 7/9] common: default CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

On Tue, 11 Nov 2025 at 01:31, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > For some tests the current default of 0x400 for
> > CONFIG_CONSOLE_RECORD_OUT_SIZE is too small.
> >
> > Raise the value to 0x6000 which is already the most common value.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  common/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

This doesn't affect the pre-relocation value so seems fine to me.
