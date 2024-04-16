Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB99BC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFFF88224;
	Wed, 17 Apr 2024 01:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZRKhfsgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C36BC8840D; Wed, 17 Apr 2024 01:47:58 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A65880E0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so5130186b3a.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713311275; x=1713916075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OvDph59OGpyphStNS3prUX93j+wn7AEdPwuucwTECxQ=;
 b=ZRKhfsgKIXwL+jiehQRqbZOjxOEj7NLcaGg8ZQu4fChKEsozn8zZFA5jMcI3ZR1UkN
 TZ7T07+xALz+MxWStRw3EWsvjvgtzWlTEc9wQman7wMBe6W2EIGgw6+JoN5KYDT9qVB0
 faAOWypEKTtit6adNXCiTxgJ0CuuEpRLb1JSnnw3id0fqA9vTP/36y2xOJKctuiG4Wo4
 KZGlm5hqJt/Je6dkflBpOoWJSwERkcA5yrkFz7FrAMfabkg3k57DmfHPDCHRFf2StYQc
 dzR03D1ZM0XQ/XGtc8R26yMP4gqtYP1KV9eNtR1LgJXsP8kq0L+2hKQR8+vyrqwZOSgp
 qA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713311275; x=1713916075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvDph59OGpyphStNS3prUX93j+wn7AEdPwuucwTECxQ=;
 b=UX/4YPQniDzc5coEA6nE/JDcw4bi/kwQidKjmMr/tD1cayapDk3yBvTyFZnOy5M6ue
 aLooNOXTpChKR0+WiAVlSOFwHjb17SAcWJCelCD9VWJpWOU3bwzgC2WDWSQJKe2asVbp
 YBk79mYISCjmBo/Xhle9Qj6AeoZvdgxseW76fUw0JX3X/kLN3xTnQG8AA4Ga+Mbeln9S
 WxvGb2W5cm+myljne4Kx5h/HRciPN7rBVR/Ej4lo8l0cSv8fo5QNG87uW4QvZ+vkry8+
 OX/zYimW5MtQ12JRX+R88/pubiPGdiCJ1oFMWwVaY69axJIRQtcoTlu8yoULnaFEMjxG
 DcYg==
X-Gm-Message-State: AOJu0YzBDC/GbVcV9UOgDmb/aRkg4Dp5+kvn58hznQ8lRSe20QkqBB7d
 0RPa7xxaj72QHMSgk+CWkzmYdTBs/mfUbwof7qYirf0TiCuJKJ72g4TO+7vhXNnFxnGD0Q16Pom
 krfaYBM6kqCNQWHKnnWuWZTF5+Fed8Ylzry5UGA==
X-Google-Smtp-Source: AGHT+IFvAttUJV/I4tjqiZYd39jxKnm9bIXBZ+OifzS2wzt7GWN0XjGuze3ggsS0iT7erpjyUsAZuXYRCahiagsrwPg=
X-Received: by 2002:a05:6a20:100f:b0:1a3:a039:d11b with SMTP id
 gs15-20020a056a20100f00b001a3a039d11bmr16413323pzc.24.1713311274820; Tue, 16
 Apr 2024 16:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416230133.GZ1054907@bill-the-cat>
In-Reply-To: <20240416230133.GZ1054907@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 16 Apr 2024 19:47:44 -0400
Message-ID: <CAEfUkUKFG4pVR3nHw-GM1Ub2SShnSDgA+zhwTNHY+pSkuaHvXg@mail.gmail.com>
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
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

Hi Tom,

On Tue, 16 Apr 2024 at 19:12, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:
>
> [snip]
> > [1]: bloat-o-meter output between disabling/enabling MbedTLS
> > ```
> > add/remove: 231/69 grow/shrink: 12/5 up/down: 60196/-11166 (49030)
>
> I don't know if this is qemu_arm64 or sandbox.  With buildman's size
> comparison functions we see:
>             qemu_arm64     : all +75537 bss -88 data +24 rodata +6349 text
> +69252
>                u-boot: add: 274/-12, grow: 12/-4 bytes: 72002/-3800 (68202)
> ...
>             sandbox        : all +57008 bss +32 data +1632 rodata +352
> text +54992
>                u-boot: add: 143/-75, grow: 21/-18 bytes: 64058/-16523
> (47535)
>
> So please look in to using buildman to get more details about what's
> changing, size-wise. Also, my goodness, that's far too much growth, and
> we aren't removing anything? This needs to be a whole switch, not just
> an addition. And then look in to what we can tweak / remove. Are we
> perhaps not getting our usual link time garbage collection done?
>
As stated in the cover letter, with this patch set, we still build the
original libs
(lib/rsa, lib/asn1_decoder.c, lib/crypto/rsa_helper.c, lib/md5.c,
lib/sha1.c,
lib/sha256.c, lib/sha512.c) for the components outside of EFI loader.
Eventually all these will be completely switched and removed.
But I think we should do this in a sparated patch set - It is too big for
one
patch set.
So, as the first patch set, this one will introduce MbedTLS and enable it
with
EFI loader, after they are merged, the next patch set will switch other
components
to use MbedTLS and remove the original libs.
What are your thoughts?

Thanks and regards,
Raymond
