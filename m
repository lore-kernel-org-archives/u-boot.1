Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A43CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7740986DC7;
	Thu, 12 Oct 2023 17:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LcgibaYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B38EE86ECF; Thu, 12 Oct 2023 17:30:41 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B92F86DDA
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so170378766b.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697124553; x=1697729353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M7pEb9D1cf7iOxrteybkd74CQt7Hwhb6NyYM3KBOwQc=;
 b=LcgibaYcYPpqSfV0UnNNcaYSJbwQDay7HCKI2qFM5BT5SFUz6wWxFLAHzEWWOOUoFu
 X9Rwr1brWX08kHDFuzcinlPTFAz7PQc77nVMJlA1UJdrYKKrCMW/ZCHQfK+iEel/hSzx
 Xv+DKP897GBtKC3kVCOhjX/JCKAb86bNNHZIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124553; x=1697729353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7pEb9D1cf7iOxrteybkd74CQt7Hwhb6NyYM3KBOwQc=;
 b=vWuGw22Uw966EK3U/4wpQAeKdzKnEefcAaTmSS6uErlWz4ZWZ1tqHeQD3hg2iD5XkR
 EqZL8KPbuRi98S+L722FoFY+Kd5oPNehShYp9A3hNRerdv4ALOBegWsTbboeHq9XJwZi
 HRP2l/QXwHMnQq/9i7dwvveqIzjHFtG7R20XzggdzcQ44aUw0h2vjTb5ANZXIkeL9XaA
 3WNAPrzK1qOtipZnHK95moB/ZvUmoEdeJqgX5hHpDNEcUWV2qKo8kNLxgJ4az44qgLeM
 LrhV/+gSmDWedJkoyXptELDI8ncTPEkUs0Z2azNyMUpE0yxJcRvjKOgk8y4DgguUlWX+
 wEsg==
X-Gm-Message-State: AOJu0Yxm0fB/qf1n+CjWZm/GhJ+uf80B99l0Lw3ffhHSAjIQ4b7mMt+9
 dQpWZXsgiPwaIngwSq7eNdGDe+tu+knTbQbOzPswbQ==
X-Google-Smtp-Source: AGHT+IE6MCxvYH5QBOVqTJ4cZm4NC2DsaBXiSHQ1zJHtY0RegfJYn1XVt/vZMxdExRjfYfm6ewl9cnx98y5nJkt5aps=
X-Received: by 2002:a17:906:2258:b0:9aa:25f5:8d95 with SMTP id
 24-20020a170906225800b009aa25f58d95mr21806459ejr.59.1697124553317; Thu, 12
 Oct 2023 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
 <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
 <20231012060209.ufdhnpqnxjcetx75@ula0497581>
In-Reply-To: <20231012060209.ufdhnpqnxjcetx75@ula0497581>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Oct 2023 08:28:51 -0700
Message-ID: <CAPnjgZ29tq6wL=F0Kk8g75dotXMz67n-TpaMbA=QUBfGvyei2A@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] binman: ti-secure: Add support for firewalling
 entities
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Wed, 11 Oct 2023 at 23:02, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi Simon,
>
> On 11:54-20231011, Manorit Chawdhry wrote:
> > We can now firewall entities while loading them through our secure
> > entity TIFS, the required information should be present in the
> > certificate that is being parsed by TIFS.
> >
> > The following commit adds the support to enable the certificates to be
> > generated if the firewall configurations are present in the binman dtsi
> > nodes.
> >
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> [..]
> >  tools/binman/btool/openssl.py   | 16 +++++++-
> >  tools/binman/etype/ti_secure.py | 90 +++++++++++++++++++++++++++++++++++++++++
> >  tools/binman/etype/x509_cert.py |  3 +-
> >  3 files changed, 106 insertions(+), 3 deletions(-)
> >
> >  from binman.entry import EntryArg
> >  from binman.etype.x509_cert import Entry_x509_cert
> > +from dataclasses import dataclass
>
> What all python versions do we support in u-boot? I see that dataclasses
> are in-built from python3.7 but for older versions we would need to
> install them separately, do I need to add this in buildman requirements
> for those versions?

I would prefer not to worry about Python 3.6 if possible. There are a
few workarounds in buildman for it, though.

Regards,
Simon
