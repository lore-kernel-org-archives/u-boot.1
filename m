Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E782CFD379
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 09:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CF983F89;
	Tue, 25 Nov 2025 10:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="j9nvnctu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5557E83FAA; Tue, 25 Nov 2025 10:39:53 +0100 (CET)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE7383F88
 for <U-Boot@lists.denx.de>; Tue, 25 Nov 2025 10:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail3; t=1764063589; x=1764322789;
 bh=vJfoqLuGz8lRKJXmBzqBDCkMKs6r0SnkYvMIfpeYxBY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=j9nvnctuZ3Ty7/nyJvYdNvX3xpqAr2WXo1SsJMZN4W6GjJo3s8QGFb07tXFKixYTO
 zRjVcj/3EKtQ9K3Zzxx1darOViCWiOVYFMdZa9i4HshAJS6/WZSFctgzeoNYlGzXhi
 drEvZtRWbo19Pas6/RGUSNIT7hWs2o6wAsl5qSrSyIvl35FPeLOtmIYsT0NWBk+PaU
 c57FzNotfvsUfuCsMlRZ5dlyFX5ONzJThJltjHqRYP7ZktQvyGuEr7DxWCtoTAiY6h
 Frepp+lppcKgU5ZVwsMN7CZ+5MLezbdBM710H5POzcN+O+czWiIulpOxrYLgQ+iJtN
 D4V/Idq+uOHsQ==
Date: Tue, 25 Nov 2025 09:39:44 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>
From: Philip Molloy <philip@philipmolloy.com>
Cc: Ozan Durgut <ozandurgut.2001@hotmail.com>, U-Boot@lists.denx.de
Subject: Re: v2025.10 env Kconfig rename (fb5235239aad) removed backward
 compatibility
Message-ID: <C58WyZI-cXWdM3MWfaLG8qEPGWxlyHAq_VyyPNZYcusA4ExLn7uhTdXE3iVmVM6CsREi6u8dfQ2IJJjZAq3YqW_kZIdKOQwm4FjwOSA-KkE=@philipmolloy.com>
In-Reply-To: <f8fd3d39-9fb7-46f2-973d-7e0b595e1ad6@cherry.de>
References: <DU2PPFBA6D4FC4D0E86306717E76599508AFDD2A@DU2PPFBA6D4FC4D.EURP189.PROD.OUTLOOK.COM>
 <f8fd3d39-9fb7-46f2-973d-7e0b595e1ad6@cherry.de>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: b98beb3dad087b50fdb0ca3dcc4ec8a6caceca61
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Quentin,

Thanks for the quick reply and patch submission to Buildroot. I'll leave th=
at discussion to the Buildroot mailing list.

On Monday, November 24th, 2025 at 1:32 PM, Quentin Schulz <quentin.schulz@c=
herry.de> wrote:
> On 11/22/25 2:18 PM, Ozan Durgut wrote:
>=20
> > [You don't often get email from ozandurgut.2001@hotmail.com. Learn why
> > this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >=20
> > Dear U-Boot maintainers,
> >=20
> > I hope you're doing well.
> >=20
> > I would like to raise a backward compatibility concern regarding commit
> > fb5235239aad ("env: Rename DEFAULT_ENV_FILE to
> > ENV_DEFAULT_ENV_TEXT_FILE"), which landed in the v2025.10 release.
>=20
> I don't think we ever advertised backward compatibility for Kconfig
> symbols/defconfig.

Is this clearly documented and communicated to users such that the vast maj=
ority would expect this functionality? How does this work in other projects=
 that use kconfig like the Kernel and Buildroot, among others? If there are=
 differences why have they taken that approach?

As Ozan said in his e-mail he is open to collaborating on a solution.

Best,
Philip
