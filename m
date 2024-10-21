Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856DBD15DAE
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C2188901;
	Mon, 21 Oct 2024 17:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J6rwwa2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061DE885F4; Mon, 21 Oct 2024 17:23:21 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 221F988901
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2eb9dde40so3706849a91.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729524196; x=1730128996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nXnjiO7mkXBFkF2SdWA/swj6oYF4snMYyChrsR8rUzQ=;
 b=J6rwwa2KBXex0C2Mnrzb9d32/7EZiDcVtYJDpttp/Zd+qMon3HrkUitmBo8Vm2UUSq
 +Z+usZlunYiuMR4Pbwqg/gMot1QGWtnsUoeZCVmt69cNPsdvLiwVb2owzkKo9QwWEYG5
 wOvzbYny1GKAEIr3kt/UEJ/y16Zc89LbUPeTI7Tw6qa5LTXdsu3Qp/bxyZATzki4T/nZ
 cfeNVR2aGPb9cjo1Q+VOIopq4VqbzrXrCsRIQQ6m4iJi+ZAwARuwczn07LGmII+bRmN0
 7EeGj5Mrp6QH9WlctpdsCuKaupregsxJJEiHI7YxLnbkJnz8wsLA4R2juhU03anXuogo
 85NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729524196; x=1730128996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXnjiO7mkXBFkF2SdWA/swj6oYF4snMYyChrsR8rUzQ=;
 b=MNw77eOJ0TDgL3zFH3gxKxqAYJ5CYMdzOnHF/dPNPk0G0jZlggVFTrGccrgZbSB0HN
 KsHFnLtgAkFNn7ajtua/bwSxRuNaXzNxmgllToJ5XYBf8jrzkFw38nelRdShexRfWMDl
 r3mjc3ZxCKioYF0Q7WIPDg56lHr6MdYiLkPecSK9TtA2i9+nEMGEsJ7q2N4lMs9ITwXx
 x1A0MQwBsbxE7R8mKN4PbEVkPKmEMoGODLsErixbKDOp7xpKF+Io6LLvTkzxKGCkDNVV
 VA0qutaI+EmoCcxVP8QoRLZM7hRvEx4+GLDQtVpgylgiGIRS+44j8kM1bgZliakuApTJ
 spCQ==
X-Gm-Message-State: AOJu0Yw1N/tIiXzbZq7aa+YUa4jc+TAo6HEsB/eWfWF58iZhYSZEz415
 5GC0T0Fa0djDpOe+lvPzDOZZzqvxilQrTnFZxgxBdaIOvilUHDtOc1gXwlWjDRDLexC39A+Ujjh
 8uqK52N+EfQX/z5Bg8qfG57pNbQkDAB5JO9ZxGA==
X-Google-Smtp-Source: AGHT+IHAap0eAWxLZNMPbDVwctCXgE+pavlqAUOLtydvx7DSbbmx/mQeV83uivRR/95ZvdXda7fti18QDpkypPJ3Wt8=
X-Received: by 2002:a17:90b:3b4f:b0:2e2:d181:6808 with SMTP id
 98e67ed59e1d1-2e5618f6650mr14851487a91.30.1729524196595; Mon, 21 Oct 2024
 08:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-11-raymond.mao@linaro.org>
 <20240819221928.GJ1626301@bill-the-cat>
In-Reply-To: <20240819221928.GJ1626301@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 21 Oct 2024 11:23:05 -0400
Message-ID: <CAEfUkULLt_0=aKkjXVx6RiBkC7YuK8bsmX+dHC3vmL6UjC0PCA@mail.gmail.com>
Subject: Re: [PATCH 10/10] tests: update smbios pytest
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Stefan Roese <sr@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
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

On Mon, 19 Aug 2024 at 18:19, Tom Rini <trini@konsulko.com> wrote:

> On Fri, Aug 16, 2024 at 08:46:53AM -0700, Raymond Mao wrote:
> > Update the expected test result to align with the smbios library changes.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  test/py/tests/test_smbios.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
> > index 82b0b689830..ffa4ea795ec 100644
> > --- a/test/py/tests/test_smbios.py
> > +++ b/test/py/tests/test_smbios.py
> > @@ -32,7 +32,7 @@ def test_cmd_smbios_sandbox(u_boot_console):
> >      """Run the smbios command on the sandbox"""
> >      output = u_boot_console.run_command('smbios')
> >      assert 'DMI type 0,' in output
> > -    assert 'String 1: U-Boot' in output
> > +    assert 'Vendor: U-Boot' in output
> >      assert 'DMI type 1,' in output
> >      assert 'Manufacturer: sandbox' in output
> >      assert 'DMI type 2,' in output
>
> This needs to be done with the change, not by itself.
>
> Sorry but I didn't get what you mean... but shall I exclude this one from
the series?

Regards,
Raymond
