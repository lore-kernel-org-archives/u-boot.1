Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B610C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE8484A51;
	Thu,  9 Jul 2026 00:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L8eyzqPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA7D84A63; Thu,  9 Jul 2026 00:36:38 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2616384A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso687931a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 15:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783550195; cv=none;
 d=google.com; s=arc-20260327;
 b=DnVfQBiTp4O86fO3nS5Gwv8xHQLEytbjABpvvBDiInTyL8QfcJkEZye8QilWwOqin6
 8aedV3vzXUl6xjPWfp84y4cn+X7bhuEHTYl7Sw9Me0+MHvtn7MzmnXrzWsVkWVUSKosg
 q8iZpx/kXNn9lgPaLeja7EZFu11iKHgO/kaj4YyYGGdhzf1yWnaGdRHQcWeEn04xFNIV
 CLePw8084VQYp6/lP9fEUsAQkKKrB7MDDAmwqRkQrlupS8wVDbfKanE9sLZR5rAJ4vSf
 ifYAbMzo2/3zx8wocnjJvoVElteO+jSVR8X13Na4cx9QuHRzPmc8efZbvJMlJ4wB2xAj
 vkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+x/gBE8PRFvzMehliEXuHGlEsinV6OuzttC+T9WFLJU=;
 fh=S2MZQzSqIWNbws6oc2oUBWycF0VqCDl3YTwjfqyIKKs=;
 b=TlllB+XNySrgmQreFHP6mZCeSTmtVjLxqRLO324RIbbAlkXIOIa9KlRQcIqgGcmBT3
 FYSyqlVK2Q3d4hm6oHTMMcJ+D5YrlR/KPqee14t3ggBXKWWhWyGTMcx+TxPTEQsQE+qS
 1yRCe8rdCUVL0aYY3gxavE6BZQhgsRyI99RPI0oyuhM4B66AGdjDzpc1GUSUZaavkply
 vM7sQfkiRHlIQ//RsLZgAfzeZWMLjMPTBODNqXJ7EcmQjjSc3v3Kq1WUcwo8YS//NK7u
 ZplbADuWzVrZmrt9DSjdSJjxslVriw/JXD5DNNBK5WpWCi6T9cYEMDidsevC6Zw25nNw
 6/iA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783550195; x=1784154995; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+x/gBE8PRFvzMehliEXuHGlEsinV6OuzttC+T9WFLJU=;
 b=L8eyzqPteGDgeR2R1e7+HCzD3SYoVSBSO9Nt95uqa2G9rRChxqwFsIskvJ4sCffP3l
 AsNontTlIMbFuFOU3rmDzsZGTpYRw7LOWLgi9l3BFt6xG+xLTEOzuLAABnoK5VUVjp49
 pmCdkZzxgnxuD2ozrzYWXW4lqWx8VE8bA5l8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783550195; x=1784154995;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+x/gBE8PRFvzMehliEXuHGlEsinV6OuzttC+T9WFLJU=;
 b=WmwzTWxLMBWFUQ3Eti9LF6u2P8qBhqAVa3ZJiUad9WVRzYlR3VL+K5n+8eG2iJO5UP
 48H7lvpLG63MFFegeayUU7chf95b2sbxt3zVNKyU7pd5/kAXogoLjj/YJe1pxCIvKlZg
 Js4tjLSA1zVAI5UjHJiKLUHj2LOwEc2tQ1anHYv+VwJQPvOIfq+M5xWnRUJDq22XD9JV
 eB7IGa5ttadHf2c/7mTL6WLdtxaaDd7TM/0tWDuhUEmfOSxtpeIxFQGDCaEm78Bbq4Zl
 6bld77e0p/xYqTiPgNuwb2hRnP+cW7wb15W53wno9KT/RzNYkq0BdOdX8u5pVQWL7cWN
 Eusw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2YonDYijlAtMUs39yKtRBboqCVvIPxkLb2XKZ6HqB8pZD0STVuDkUAAIqNIMrtWaQn2pv80Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzigPmHGAKmiEmKvrWzf/nRsr9DEiIU3TPTBel2Z2IiOxxYC9W1
 PqWF7zgtaHUdWMgN1r74e6oxgvJP42nB7EiIRDS7ohthC9iQJQhxBDO0yzUGoy/PPnBZ3+6R+u1
 0bvB8obKJMsTrWsojQGqBdNpjscpriLEwFDA5YrB6
X-Gm-Gg: AfdE7cnegmJnkR+zslPOFV+KeuQmJwfQgowGY5MM1zKncoskqmMl7hQOqX+QIPlq5ol
 sx3IqtlqRUEdwGY+h9xHtvxLlpK4YoiOAwj+FfASoOjUbXwoNAd/EiABBln/R53QJ9faEf/tllJ
 j6keT99/IWMiXfRH6IqRyBcSoRzngoS1f3NLtThjHiGyn0XURpS8teG/n3HylOgKcproMEonMV8
 pAf1UnyBYq7M+poHCKavAamOUU5mFr0CHUluoueMoxTZkRZioBkSxwVq/Sj1V7mIUQVOOGjp4wf
 r2xMH6bw9X4cO04LJ3LrJ8qYtja7vkgwFntTPWw=
X-Received: by 2002:a05:6402:21ce:b0:69a:b449:f8cf with SMTP id
 4fb4d7f45d1cf-69c01b75cecmr85063a12.4.1783550195436; Wed, 08 Jul 2026
 15:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260208212624.3413494-1-festevam@gmail.com>
 <CAFLszTgP0wCfQOZ=DJhbdPWC4k8e66XmNtF9cO8z97oqPetdRw@mail.gmail.com>
 <CAOMZO5D9NuWVkJ3PH1-wmTmvzq76=zrEKEekYozoPRY8ZjcrpQ@mail.gmail.com>
 <20260706135451.GU749385@bill-the-cat>
In-Reply-To: <20260706135451.GU749385@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 16:36:21 -0600
X-Gm-Features: AUfX_mx9TG66kCq44NNFLnl2ALWWVgK8Li0wISC21KrwckBWbgMKGl_XuTO-ZFc
Message-ID: <CAFLszThWp-AHJQeAx4EMT0sxnZmxKws7x7V4Tb19gmkP=qqBxQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ARM: Add RV1103B Omega4 board support
To: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Mon, 6 Jul 2026 at 07:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 06, 2026 at 09:31:11AM -0300, Fabio Estevam wrote:
> > Hi Simon,
> >
> > On Mon, Jul 6, 2026 at 9:27=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > > I recently got one of these boards and have it running in my lab at a
> > > basic level (boot to prompt, SPI-NAND and MMC).
> > >
> > > Are you still planning to send a v3? If not I could handle Jonas's
> > > feedback and send out a v3?
> >
> > Please go ahead and submit a v3.
>
> Until the situation with u-boot.org is resolved, it would be better for
> you to handle a v3 Fabio, thanks.

Oh well a bit behind on email and I already sent it, but perhaps Fabio
could send a v4.

Regards,
Simon
