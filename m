Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB456CAC5A8
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F6983447;
	Mon, 22 Sep 2025 16:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jU0uTF8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82AB383448; Mon, 22 Sep 2025 16:21:11 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F6C83443
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-57bd7f0e5baso1604168e87.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758550869; x=1759155669; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qi3LrhA1FdvffMR/GrhOH2F/XhA+1VZW8esxNbIap3Q=;
 b=jU0uTF8z4RZMSMo9yXyinwMe+QjcguQvNxcbs/yzJ56Y+DaGH11vIZ5w9bXU6PbP0Y
 0cSZJZTSpK6drRV1HofPXWqeikb9XIKHLWmy0cQivslX+tRiuWc0zpzxr7dLqC1fHg4F
 Q/le/lN+F2RSN2f/Q8H182x+2fm3EZfex9epvSKscpPYO5KscBCUEjp9OOnBGDs9MhXK
 LHm4mplcsUhzu4K0TWJiHDox3eEzJaPiWYHYpmqz89x2SFuQE07aiDBj+g3KCTVZawhE
 95lmY1CmPbLNbASIyUPCeWGsB1mv2zWHPndr7wAdBLwTU3fNRgfJCWq7vnFgAEzwYn8p
 fDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550869; x=1759155669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qi3LrhA1FdvffMR/GrhOH2F/XhA+1VZW8esxNbIap3Q=;
 b=OLULp+qg8KpY9yNuoT9gZYkoxpRDjQoOovTON+EhI21LfUZ587A4BBjXADltPZeA8v
 sX0yhkDysHk6683T10yTXXT+A6achaRKY9YSh4wbnVkUhqVpDWzJVTA0gfSDCpmLHLIB
 BfkqsBGnS282otkeD8J2cze1dga37bCuVWVimhUx17QFCO8b56TDXZAJrVVXu6vA/CJ/
 rAJt23GTqGTbnsa/jNeGcTBGIeKu7L3MRkNvjOpZdVTYGjSBdkJSuD1T5kBc4/QcAf60
 Z7Q/Cb9v3/pOySwDW9D0Ey54Py3zKwUp48clGnIdflTHNXim8H8N4OUBdUBHaIChzJnb
 OrAQ==
X-Gm-Message-State: AOJu0Yz0pzVmK/2mw8fAOB0Y9O3VuLYr7fj1I4Bxe/iYU4xFd0lqmUg9
 R5gcuZKfACistwxVbMfTwsARlfx+BLLP0G82hs68mE8a3FnYVO8d0s797e00lh3vwKI1wpXwhfF
 U4LDYJu4017gvAPtMs5N4IGeUDgddinc=
X-Gm-Gg: ASbGncv20toBENZPqFUW5jFMLUBTAemi3zHsp5XdT/+HipqeQiobxqtxUFfgtFqo+29
 VBa+CoL+9qbDNzBOkhJhYpWIuE5C1Xpmm/sN4XONjPW8AusjxGJN0d4FEBBgD5Nfy5WKWSaULzH
 y8mwLpnC44qQuoXUEY+jEXNOlGX8OseEFFClYNMfqUZGLvSyOrN3id0tTvjKgmmLb5y4iloXHm6
 3Q7tXd7y+BU7hbfJanWph3rOM9151qI6fxUU1o=
X-Google-Smtp-Source: AGHT+IHRlSBt3niF6efs22Gd48QE8BNubpa6Qd+aa0UmS6Eh50jqYEi5U+6kpcSTBHbcY9bBKPouPmCj59YdZ14/M1U=
X-Received: by 2002:a05:6512:3089:b0:57c:2474:372b with SMTP id
 2adb3069b0e04-57c24743888mr2699250e87.49.1758550868653; Mon, 22 Sep 2025
 07:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250911095841.3659022-1-ye.li@nxp.com>
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:20:57 -0300
X-Gm-Features: AS18NWC4qFt_9D_mLScLkG6nswWx9NTRyVbAsTJR_Ojiz9ySIYF4p0NfQF6LSNA
Message-ID: <CAOMZO5B9LEWjJZM0L_U1N4E9NWbCnDvDD2G4UfurQ2i6esYZyQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Enable PCIE controller on iMX95 EVK
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com, tharvey@gateworks.com, 
 sumit.garg@linaro.org
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

On Thu, Sep 11, 2025 at 6:59=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> The patch set is used to enable PCIE host controller on iMX95 EVK.
> We need below driver changes:
> 1. Add iMX95 support to pcie_dw_imx driver.
> 2. Add iXM95 blkctrl clock driver which is a abstract of clock gate
>    in hsio blkctrl for PCIE.
> 3. Add vin-supply enablement for fixed regulator, since iMX95 EVK
>    uses two levels regulators in DTS.
> 4. Fix issue in clk-uclass when assign high clock rate.
>
> log on iMX95 19x19 EVK:
>
>       u-boot=3D> pci
>       BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
>       _____________________________________________________________
>       00.00.00   0x1131     0xe101     Network controller      0x00
>       00.01.00   0x1131     0xe001     Base system peripheral  0x07
>       01.00.00   0x1131     0xee00     Base system peripheral  0x80
>       01.01.00   0x1131     0xe001     Base system peripheral  0x07
>       02.00.00   0x1131     0x0000     Bridge device           0x04
>       03.00.00   0x1b4b     0x2b43     Network controller      0x00
>       03.00.01   0x1b4b     0x2b44     Network controller      0x00
>       PCIE-4: Link down

Applied the series to -next, thanks.
