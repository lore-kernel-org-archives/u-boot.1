Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ACEFD8FE0
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 17:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB8D83F4C;
	Thu, 26 Feb 2026 18:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ja60LA+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 390AB83F4E; Thu, 26 Feb 2026 18:21:00 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5406583F36
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 18:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-389d5138820so23688331fa.0
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 09:20:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772126457; cv=none;
 d=google.com; s=arc-20240605;
 b=SDC4iLL880Dy7PB2aPQbN1+remdftj/SmGf+zsudgbHo++ekleLK8EjrVNTvI+qEvu
 PDBUI4djodgu/dfDvaKyWG/KmK04iKkYmIsfOxIifGJT2DRKS3bnPe3zDWAundjbHJtb
 lZHekB1NUhFHWTOMU2iZZYUjISWVp8Utfj4CD8uB5vR2aq9uGBU9gJE5pnFVmW0CsCjB
 LCFccoSD9EN6nUMH1xPV+qn7REgGR/1Kh3lStA7BgkbHLmMWjnhH15/q1KWbJmD5RdxQ
 KV20vPKePEAC55EJbgBFCV32laMjsOPGDMC1V6KvbGdwZ2fZw7LzWW0jIF7y+uinzjDa
 cmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SuPzdvWvdLSSspwxvJ8VSUF3NWr451ZLJWdRxVeR6L8=;
 fh=7Mr0VKM3s1XeUMK0NEAezqFvY0Oc3c5lSHUq8xuiUdE=;
 b=SHPfb+Q56AquxWdvgxo7BJY7rLl8Dzq9AuZIlT06ySwrlgS8PX/H715IeomDYrViSM
 VCjR2Mk0UyWrHmQANE2UYine6OgJmMdIc8ioxHarEbNhxck83HeZXAR9f+uxv0qQYeeu
 npHZev7Dw9KcyJiJCA/+rbrDWaJiRviyZr61fpdgkf5H0cbPCPEBRa+4pAfUETI9Ye63
 oiXkh9RzatdEER2w6i2NULXjBu6e8L+h04Tm3SvZ3uDfGgCsnGclQepgIL7B0dKNTFRK
 bjxFexHNtkqhlyJ1lUiw6+xgCNtCjUyLqLrcw6KMstSSmoyA/fbXV7dm8a3414VOc1A8
 9v6g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772126457; x=1772731257; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SuPzdvWvdLSSspwxvJ8VSUF3NWr451ZLJWdRxVeR6L8=;
 b=Ja60LA+tzZOD3zEb3KLWCBoL//Um/D1SgPn8bT5Hutp4Xh0LDtYB7l7XyydCD1z1D1
 w4OWENFppHXLp1KKeeji9DdywKCfaqPEKEJcri4edNQvp0UpLbyNcMxancbgr8L7xkqS
 mslCtVqfTYqOG2XQtsrf8AH9ZWMpucrp47bLqAC28+0lIllahycB5qde6GcV87NW6gRz
 Oymkrqyo0E638E6mZg61MSpNLK8opBMcf7Ta/PlfHEjXXxa32StUoWfAvmJ7QB4DBQEk
 Se1jO9Oxzfv9Cr/jd0x8YKqXB7kkrisn2vJ7Hy6In6avSNVbNMD2aSfe4H1YRErjwBVh
 aTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772126457; x=1772731257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SuPzdvWvdLSSspwxvJ8VSUF3NWr451ZLJWdRxVeR6L8=;
 b=c/Z1D8rB5xmMLp+F1eqlfQg/0g5Zdiil4YhLj9dDESifuG4KXkM14q445Z5QHu+QUi
 pf/F3YOWb8ip2yzDGX9KZVhuyXyM+VmVOmukEFDYdMrnBh9W4tZvY/yTrn5feIxlyNSN
 SAFiZkvGZjr5ilxr4vK65+DrTL8wtROU9VBmFMp4wc9semYx2shVkLJgkX8G9zANudCB
 mmoiS1KaWwzhzNfpNzY3aXhFDCCxt7XvUSZcPlQMt84YouJ/ytrauACcz/yXKQwpWJ4v
 ukzg9GjAj7r3p2JzjnAy2IFISj/W5YSdMgpsOJxK03FGyKD3OHlioEKHJ5h5AdMxSgjp
 iYsQ==
X-Gm-Message-State: AOJu0YyhdSz41C4c1NRHhtugWmWNgj+3SqkD2UaEq28ImtI8q4IzUBfN
 X1R0k+4imXNmW7VIRMt3X5mZn0yiO8fP3644QOPHG6nBYTqipzTkHCfN7RfslTrgqYzJHwHUkLS
 XFirihxrj9Vr9HFNfx2jzIVGJMw6ukzk=
X-Gm-Gg: ATEYQzyZhsBMVrV6f/JyObsDf7atzqmJCRdPC2n2aYPB8wZddkwDtwaLIWYJ3q6XGyI
 oSFAovWofP3Wjf5oSS9j3BV6JYVpEhL2xkL1Pw7b81xSoP3jm9Aj4ofJW0r83Wb/0bV4uIQ250W
 vebayVx93pjRsPOFi1unXKFfARl+41NLZphYVfMc2J9pRfch0dJjZVm2u1qqlTOHl3HB2mk1bKY
 EkVv6HYz/7njWsWoCZh5WtiBW0W9zAeY1gFHE5X0SFMEPCxc1KiEHzzxmF4bp7F6CJLWhLUbDaD
 0FQazX9GdzbmNRILy9/deHxDsZSkVFxYEgDujYPrCWUcF7gKYrSFCshgjZXVBIHfYDrV29BVlfS
 aX98dOQ==
X-Received: by 2002:a05:6512:ba1:b0:5a0:fe72:f74 with SMTP id
 2adb3069b0e04-5a108a89252mr1326940e87.12.1772126457224; Thu, 26 Feb 2026
 09:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
 <20260225-imx-pinctrl-v1-7-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-7-7a149ab8feba@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Feb 2026 14:20:45 -0300
X-Gm-Features: AaiRm53aeEg_CNejoD2IJIotBRcg9_SeJ0CuTv2O35_p2so34cDzkbOms19aMuA
Message-ID: <CAOMZO5DH4ptUyVnQeW+b-ocswXYSfZznepjyKXppzhCDnvCezQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] pinctrl: nxp: imx93: Rename to imx9
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Tue, Feb 24, 2026 at 9:14=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> We are going to add pinctrl data support for both i.MX93 and i.MX91.
> Since these SoCs share the same pinctrl driver structure, rename
> pinctrl-imx93.c to a more generic pinctrl-imx9.c and update all related
> variable and function names accordingly.
>
> This prepares the driver for supporting additional i.MX9 family SoCs.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pinctrl/nxp/Makefile        |  2 +-
>  drivers/pinctrl/nxp/pinctrl-imx9.c  | 34 +++++++++++++++++++++++++++++++=
+++
>  drivers/pinctrl/nxp/pinctrl-imx93.c | 34 -------------------------------=
---

Please generate this using "git mv" so it appears as a rename rather
than adding and removing files.
