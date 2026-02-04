Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F62E8B386
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D5B83EF9;
	Wed,  4 Feb 2026 01:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZSqiFgRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E3A883BC8; Wed,  4 Feb 2026 01:23:35 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661CF83F15
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8837152db5so988532166b.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:23:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164613; cv=none;
 d=google.com; s=arc-20240605;
 b=TXZZErgxOKEttCdHHdxIA1wxdfB5uDJ/Dvq+uD9IWQwEP/GG9A4tZSwZeZp37ftNfA
 wA7jgqvtBnhnuer44i7OukTIhlHIJB4cqjlh9OXDBXyoiRSMJqtrnoh7vlVaHrE/bU/9
 o0NH2g8XjkkF4qdOEVcd+d6pJBjNbKVhD6jlU0lR9/801cvAHYF65tXJqjR7xs+yzvYk
 sEBKq3baBeooruvIDB9qBWcqkaOflx3+Iz9JMdrk+LazIErFahnNhO+UumJWRPGdXj9D
 ditFbz8+lEbKp3H4K53sy1ko5uJ7orzL566+SR4TqNC5ivl8rM19zO9U88Ogm7CNAyKK
 eLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cpdd49RWxezL4CviQwyBHwkIcKqNUmDt3wHpCXfDSJk=;
 fh=69e5oXAXTye3X+NqleIkM75H1t+32sbQzikiXoiIVLQ=;
 b=IhMPkICGAhCO9vzBaWE0fVoPnaBQMV//XeU1KnYiFho9S6n8G2vLiNQN13NH3pG61X
 PmAUlRUSUCh8khrRlccYDSRP7p+mprISiRt8NndRuu28nvRSlDG2eMz5LF8wSB6XEUvp
 bSHtJC3aZwKswRPoaLeoGum/d73xZ99eP8Jf8pRzjxq3/7AWJJAUnHfkdgOgnv/mw0D5
 hfvSE/wspOZoHE+DS46YX9hmZ9i4O6I8dhXvZcxYopLTYbXcUmxW1KU9Bab9KzA0rNST
 lTFxcCCQhgWDVwVNz/2ib3ug0pHSrYKYrgHc4M7udXSCoxLV5KDwZzgsx+jDLCJMeaWJ
 7V1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164613; x=1770769413; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cpdd49RWxezL4CviQwyBHwkIcKqNUmDt3wHpCXfDSJk=;
 b=ZSqiFgRdTbrmYiopPgQKnhQSC5ueeLkLUU4OVCvtbXYb/EHifuPNM0whtIHdlVJY5i
 XZO946OAbQvv1TA553QpkTzeFRlUbNWRwxzzTl1c2wageGgKulrV73T6VAC9ze1yNtgf
 DRjdC/e902lML2zO4pBUVKZtwdK8eNilw6MTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164613; x=1770769413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cpdd49RWxezL4CviQwyBHwkIcKqNUmDt3wHpCXfDSJk=;
 b=h+MfcS5l3mPCHo7R1yEnRaqqO9rVLbWdSOfKsq0lKxF5gkNUGOsvx/hcnZUmEBq0bt
 IXV8VOzXSGEzQgD89K0EdSCfRByUq7blxYew0cCTsnkmk810HNd6EvkS5VYkK80eq59q
 N5xraPQ8ax1cXd6qKPb+YlCoJnnv9eMnuty4ljSajjkCVFQU/Up624oLv27hAWaPosR0
 VwlwO1UuhLT0wDpXB+GPWNSmVPDkFaTgn6VRtY44CXkCesbTpN/VVebEfMOgvEKkncvf
 dAzS12qwAJ71DSugqx7gzp/PE4S9QLURLEhN1Bhj8extwPcknwShiadG4wEQbW6nlUDB
 W+QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2tP0Y32Niz60/hwpNEleorBWpXcAS6OYn66WlhaCeFwEY+xxKb0n152b0WmgbVTv6IXFFam4=@lists.denx.de
X-Gm-Message-State: AOJu0YzsY42xTJLJQTjSige5XnNnWihJf60Up4HGsn7rYLvcCBKzeIws
 Bdl4HSIfIzHjnmAPZX79oQbJ3YKq0mNvAobEogVqnKEfRR98hJm0XfIkzPoYFkahUM78a0NjC/H
 5GDVO6iUaTjveR/Y9Wen1Z2fa9u2AEc4emSWk6NMx
X-Gm-Gg: AZuq6aIlPRsrLl0xY9/UnR+Kt15YyhSr2qu6+BWKqyPWDMKObEySjhWfqn3h/ctKnV0
 shjQuXuiMeRPnuAr040Q0euFcGEtdcP+XjP9A59QVIQNwtmD/yuNRSPcPV6rXClGojfBU55hgv3
 ZLkzFYFu+Mn3VPpq+xczAcQicVQKf08BAMcqRyhGGwm7nVFidqCX1ejXoJRxlk3TOBNo8/pwvYn
 /R8NommHmXriVwT3n0UkeI3yakCQ5IVEdpyY008UxkXAklqWFVphwJrBqeDYdicrHUEp1gUGAvO
 G60j4ng=
X-Received: by 2002:a17:907:9409:b0:b87:33f3:6042 with SMTP id
 a640c23a62f3a-b8e9ef30599mr74989866b.9.1770164612904; Tue, 03 Feb 2026
 16:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
 <20260120-clk-reparent-v3-2-0d43d4b362ac@outlook.com>
In-Reply-To: <20260120-clk-reparent-v3-2-0d43d4b362ac@outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:23:21 +1300
X-Gm-Features: AZwV_Qge1N1F4pN05hETXcIWO6qRCiQwqfdDk4RhSm32iaDiVa4tBXDivpzljdA
Message-ID: <CAFLszTgd2nr=-+RYoNADFGPDp25YTc8F0SXbmDBost2Cvn8y6Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] test: dm: core: add some assertions for
 device_reparent()
To: forbidden405@outlook.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Tue, 20 Jan 2026 at 08:07, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> The original tests only assert the return value of device_reparent(),
> but does not check the actual relation between the new parent and the
> child. Add some assertions to check this behavior.
>
> It also lacks the logic to test orphan/root devices. Add tests for that.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  test/dm/core.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
