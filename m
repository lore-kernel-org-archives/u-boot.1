Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B20CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 14:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACD383FEC;
	Fri, 12 Jun 2026 16:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BkWmef1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A2B83FF5; Fri, 12 Jun 2026 16:12:25 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA52F839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 16:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-396753f343aso9888831fa.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 07:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781273543; cv=none;
 d=google.com; s=arc-20240605;
 b=NDQXAnmraJ0YB+j56C0waWJMszYUReFfTnJ6WCW1DyTdVsIodQg5eaxqWd2cRClxFf
 QbKDfp5RQ0p/5rXR9erb/4jsA5LLY+tqa9nDSmQnoRKtWjAzdrzOXKyLmEZz11jbl4a0
 LqjMClfH39moT5gXtQ4ej/0pMdVmJjszsRpwoOTxQlEhgPmIQteZHpk9Q4QZ17z9piB8
 0Sx8BKon4iiBj2rqrFS9E3Z6lIrEAmXVtdabdPksWCqZ3opHH2SN8e6kPuzHihkORM4V
 y2Rvc2yXbtGuaQEEyM6ME44YJ+Wt7I9ruk1tkfYLVdLThZ8+PqjO+192/eEEF7uf7mbZ
 nl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BumFnBDvgmcUFQMtNu00/37uVg9UrGbKGbvmG8SBbHQ=;
 fh=nOqLM05GE9PxAKiRVI4Q5B6CXQVwVv8OKBfPLMpCKPo=;
 b=WJZd7lqyQpdfaJkuTG4AZbGvuonJYGWb6iTtyp559rt8FX/95euOpi3kFf7betgRHh
 6nmGWdN3HqUOC0n4W7VQts0DN39dBneZO27dY/FLbaTvraH2G189iKaSJDxhEXYRT8xA
 kICqIIAsm05TBFFpWeiobBrv4Dwzj9TpjNX1MlPw2R6Rd1IvoPfihAYeJ7d3kG9Fk3lZ
 uvIgjB3FKYUrOZiCU8zqM/hnlKuoq2liaBSlYvUrx/0LX+sQsDIwF6wvVftf91130bPt
 TSwkKuyYyMMv/w5zwa1F6cU8gVAHyJ0C795soIsg6G0DUNf+TJcPryUsiktWc6NkDxZp
 bR/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781273543; x=1781878343; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BumFnBDvgmcUFQMtNu00/37uVg9UrGbKGbvmG8SBbHQ=;
 b=BkWmef1hx93HUOTc4z3lliW8Pva/qiA815M5yYA2QBJobNadqv4jr5kO3elbAie8qr
 LJgDHQyTy0FLwz/pOhBDBGowm6X3xUBA6ceFKPTmLgR8wDACaWJeYJppVHjHfQfiLnlx
 2dilGykksBVaYgFTKO8f2Bm0I1gMRwPIAvtkmeqoMmR5922FzJ9ZGxrCxBbw2l7iRTFf
 TV0AgeEsqgEw4le8XjQT+wNpBxbG9lmjKlWy7nIqD0GcOPAzWJUaiIuUFMxj4Fl3W4AF
 POFxsbPDNdXONtNIbddvVoArXsuU5BoqYh+m2q2FgKktgC3842P8lD4UGur+FKjhvJ5f
 nozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781273543; x=1781878343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BumFnBDvgmcUFQMtNu00/37uVg9UrGbKGbvmG8SBbHQ=;
 b=NZPWxJVzGo11vFQRjDGNNvwd/f20EyjFc/xT+H/zQmHGj7KRaZh8X2LfbTdQCjlpCa
 Etdro/BFqqxeFIKTd0BStu+II5uFFvDT2vVxDY1anw726uxFtIPpZfxK2NGzxReK1gWm
 vz3O7M6XVwTqeXErpNX72WaRVnZRVCyyN0NbALyEo5W25ZFElqqCQeGKikMeJHTVjNvb
 Gjlqq+60OLN8V7GtIaFVABXThHBOfdXShrjtseRTyPBrpACWXjJI39LijTKzX8ec38Yd
 zn1X8qwBLzu1vRAnSKa+GeHGrQBvYv4uhXlU2FhH5Hz9EItCvhVnCrEmyum1bKP7Pufr
 6qcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UVCH7GRxDQ/cYq59Cg28MuKiU6F8TSRkUFFvoQTYpoCgKXPS94xcJxN11JwyAl8ogwPCP/q0=@lists.denx.de
X-Gm-Message-State: AOJu0YxSL/vOrE8cRFgzveaGYCdNb1PpgmPvQcRVWH/PjWtXdMN3AAqt
 qssqMVCqDAJnFjro5OvEHQXrxFx1FbqzkyS/qwyMX3OQDcR6O25ZETaWfZGuiJsg0Hl4Mo55dA8
 7F7WiOpWl1lpiO3tvL/0wGZ0f3+IEMno=
X-Gm-Gg: Acq92OEIXoR7jO0+gfVYxju3C/l8nLe7R7jwIp2au/6viInG63hwYDnavdn1IqFL1Aj
 fbkLbsz/qt7bwXuoDZgjDdzx/O9yz4T3o8nR4YqJgdvRmCbgWEc11wBaNuWJUyFTskr/h6L7Hrw
 iTY7qyPUBPh0qaMSvUHHLSwJhUtkarHRvJEEWh3Ebi48nYcYYJa9URyNbc1qwPkQC7jHrjDjDQh
 Zg8kUZlQ6a5+djz8qYyzfEzRODhu7lLO+My6iH+VXDxpv5bNx61vYfB0PTeVck2t2kWUHkDHg9F
 0gqf/mqcXJf8xbis2WaGe6Pz8IEGEPbUa1qUEN273gOzA+ru7JMe6CsuarovCkUxaqfqnVig
X-Received: by 2002:a2e:a592:0:b0:396:a7f5:5e9c with SMTP id
 38308e7fff4ca-3992b2d309cmr11078441fa.25.1781273542382; Fri, 12 Jun 2026
 07:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
 <20260612131149.GA8915@francesco-nb>
In-Reply-To: <20260612131149.GA8915@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jun 2026 11:12:10 -0300
X-Gm-Features: AVVi8CfktOfx6EK4zWNj3Wa_nHsc3iJAJsM-goGr4Aqke-_7oAFaeFgcxLc0ptU
Message-ID: <CAOMZO5AW-C8mB17vgam-AbKfVNOEv-_aC_zsOBv-aUsi9A4SKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] configs: imx95: enable PCI_INIT_R for Toradex modules
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Franz Schnyder <fra.schnyder@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Franz Schnyder <franz.schnyder@toradex.com>
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

Hi Francesco,

On Fri, Jun 12, 2026 at 10:11=E2=80=AFAM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> On Fri, Jun 12, 2026 at 10:58:59AM +0200, Franz Schnyder wrote:
> > Currently, on the Toradex SMARC iMX95 and the Verdin iMX95 the ENETC
> > device is not enumerated before network initialization because
> > pci_init() is not called. As a result, no Ethernet device is registered=
.
> >
> > Enable CONFIG_PCI_INIT_R so the PCI buses are enumerated early enough
> > for the Ethernet Controller to be detected and used.
> >
> > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Fabio: to me this is material for the current release (master), up to
> you the final decision on this.

That's OK.

Tom, I don't have any other patches in my master queue.

Please feel free to apply this series directly to master.

Thanks
