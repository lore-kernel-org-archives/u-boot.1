Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7230CCD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 16:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDD784CF2;
	Sat,  9 May 2026 18:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZwBnwAXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C71984D68; Sat,  9 May 2026 18:47:43 +0200 (CEST)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FB184CEC
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 18:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso3184482eec.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 09:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778345259; cv=none;
 d=google.com; s=arc-20240605;
 b=iOkYotIgFtE8ZtY46CfZa1EsvHDRJ/tqCWoSRX5FnWN1qmPnHVRR9GpStKG6Y63v68
 r3V0AuneRFxVaM9NsyZysIKVSFfIjz6KYAk/uPOHqFqYAzbpp1L0pGncNdmT+XHWccO+
 G8eg4eadD7BbBM/zywlYwpzBe5YY7yTNdccacbu4lZgu3hjPUX0Zpmei2CGHXPEeKkNj
 2f+SnI7MOF0W9Aj8/R3htX3OmfHTL1cGAEzxu+x/cFTzfaH78WOE7YvqfQpDrZh3s1f3
 /j5gxQoAKZ6iQlW5Lt0hTyJUdDnUmgp4OKTkn//7hRYXKG3NN7xDu3ymHn4s4lmeYZLp
 +BrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yl55wnnoih47rr2V3k0s8/PkXoInYFUvIFSP9pQXHZU=;
 fh=NbL1UtTKC0x7fUW18qQWobdeBynxeVXzUKcjNgMhygI=;
 b=eEfAzaVkBQnQRf1mvN4/3J7aEpUR/GoiWK9uQYvjVYrNl/v3fxm5a3NBnDzmcY5eiL
 iVOBLZM/PLSmU9+NcAZhU+DB4OAKNbWnxUfEpjfJN1THcSLYxWYdkvZ0LKusHRCGHEnE
 1IKPZS8PcvAFpyrL+eA347uNvXgOq6K1VriTkL4yYYnzlwHkLqWFJxLoncQNtAdubLLt
 RdtrGAZU77UC3IQ8/3kNqaLocJzAAvMRCAMlbnfDhenJ2BVv0b37MZgftlVJpePvNwKN
 mqhD6BAcNL7vpfoStuuSGNsfkCDn4wL2y3ULYwnGprcmnDbMJ5z4xQ5Pfj9ZMLA4EPfh
 gbUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778345259; x=1778950059; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yl55wnnoih47rr2V3k0s8/PkXoInYFUvIFSP9pQXHZU=;
 b=ZwBnwAXarbEcza5Y/YpQx67Ap0liW+eSdolS9+6F04xcE70gv/xhCa2LfNvHJdg4YP
 HhK9i1S2CqTSqlr3Dm0vPe6EG65CNXy9lEBrqpecxtiFtMxeKRbYZEoU4nA7S5uwdHeG
 /fHD9naRgv9rsbf65jNZM9B6gCfAu4YGN/+r7f7wcs/JZqS9yVt0tiRDNd1Xe+obEH7J
 0N9V5pY4IYtCD0GNEnRBynlaf8bnCRKOCw2te25PxQSD2fiLYlECkWpIpxMwOualpJCK
 CbJybZoAYoG76xLAXkk4/1IiwU2Tz7haWgK/8C5y+wxRNKi2GxRxLRjUYyzq5SMCRlMS
 NPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778345259; x=1778950059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yl55wnnoih47rr2V3k0s8/PkXoInYFUvIFSP9pQXHZU=;
 b=j7Kdj3t1yH48Uc3W0RiAhbKPJUheL22WqSvvDuULCtbh/LTDWQBnXOo8tToa6P3cxs
 t3DY2pcKS/W2uUcE5uNylUU3XChEk9FmiVsq4TGnvhxXFidpt2aj5Qi4Nv5AaAAlnlfY
 OlP/v/qUJMK8HHRjtwtq8/6wFacHmE1DSF+NtDxs6FLTLsJtd111CGtUUXyfC+XyrACN
 Grx7sFvKAMrGm7CHvCCNPWKeYex8mFqjbNRF7eV8guw4+Y/YG98K4o6Q+X+KBQDIS81Y
 U5GuHLI7ghg88OEdVH8t8a1DwePriTUEUsM82Xr0w72SwdpO0oG3Q3Fb8cHtScvx/fEl
 iH2w==
X-Gm-Message-State: AOJu0YwKpm+2/ErcBEhjH5y5VSEHj0R78uyVSVy9npVN1bB8MXb1vVwn
 d3uxBbff2kU4KiqUXxFl3vGrVfMtgeLOzcuXhCNOsg1edA2FXBKsgvyjFpih5fJjF6PKKVVvaxM
 sEMUf0uqlB7hlzBczbMugTWJclpXYl8g=
X-Gm-Gg: Acq92OFWG2CUFfOEfo2H+xsj+LGigrVmJnNSyIzmVW1vwbMJ79qNMbGpYVSWtdeQ6Pl
 MXI+7McmQSEwbnfnKwA8+hAVYABZVoecTSE69Mok2jD7DP5rq2Fo5pxT2LhkPiZxZ0wRHEUx/CL
 H93cNlg/n3xM0ylQMWYopStDyAwjbfNH0Uw6tvHabMjVUnkYU2ymL+YjvNPTROiLYWD3j5msPcA
 s6KF25q+Qc37hm0+MIMgewv7JtYnnDzVw9u3F1vQKPYai0CIXbh+1/v0tlzt3AorUB9khHiF50C
 FSKTcVnG
X-Received: by 2002:a05:7301:6793:b0:2f3:986d:2d01 with SMTP id
 5a478bee46e88-2f54d79b94dmr7089242eec.19.1778345259511; Sat, 09 May 2026
 09:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
 <20260509151308.23067-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-14-marek.vasut+renesas@mailbox.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 9 May 2026 19:47:28 +0300
X-Gm-Features: AVHnY4K6jwHAhNQyUe3fSIGRO9JjJStt75VaMKbY6Sdvn2lMmR0oTA0l4Q2cQFA
Message-ID: <CAPVz0n2TSBEpN5sw9nk7KWwoy5RQx2MoFk3ycut+QtQMuUbN_A@mail.gmail.com>
Subject: Re: [PATCH 14/14] reset: tegra186: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
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

=D1=81=D0=B1, 9 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 18:13=
 Marek Vasut <marek.vasut+renesas@mailbox.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/reset/tegra186-reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>

Thank you!
