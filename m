Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB2C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 03:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69CDF882BE;
	Sun, 19 May 2024 05:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="SZd5tACW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3417C882AB; Sat, 18 May 2024 23:04:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B5B881BC
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 23:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716066254; x=1716671054; i=fiona.klute@gmx.de;
 bh=jckCCtmwlQ78+1s9nYXAbxjqk+WsXk3fL+T0pmdhh5M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SZd5tACW8OlD8Osau8jlcS8l5yi3HoS6sDZfInElhEwwltA2+DMXmEYDVea4c8ak
 INUW4qQO6P2ifQyH4H7/+sX0frDrb898hCclbnFKsox6owLhGOWhKPufE8u7Cd5pc
 z65K2BMjwDDU41XlTJyjPP3qWRZD64WM/4cC1ZwhtGkzryCBu4UE3TwPS3wkOKEaO
 lfAUUpj5U9FiwynWbdhH1d2011j6ye9+dEm60ExoGsFhHbrcHNY37BXeoR/QFur/5
 6Pl2WYQf7OTuCeWduu7QSxh22x/kOrBmfPAx+PUaROvNgLbjGWveLjooTibti2JbZ
 x8xUTWz3bJRWqZS06Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.125.1]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1suAJl2a59-00n5hi; Sat, 18
 May 2024 23:04:14 +0200
Message-ID: <d8175e23-f1c7-4301-bd2c-ac51ba4b103e@gmx.de>
Date: Sat, 18 May 2024 23:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request efi-2024-07-rc3
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>
References: <63cd77fe-73aa-48e2-af4b-a3de9ea09d0a@gmx.de>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <63cd77fe-73aa-48e2-af4b-a3de9ea09d0a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cpE91FMZC+GbbW/zZYMNOHifrenJ7XARLD4FUzKwaX9nd1LnENe
 PHTDcD2vQiZBbiL+rys24rP65u8+SZ8rr1lypj7pqo6z8Nlf2CYCU9pEqsBqRhO/6jIPTKp
 9Wcz+zRG8a6JBUPk8y5qRicgl0GQSygiAG+4h/ewMwvcgYhcpPR8pyr5zhlqigwZAtPDszo
 u4u8sas3vNgQZGKdEet9g==
UI-OutboundReport: notjunk:1;M01:P0:CNM9EI3ui0M=;g5LEbQtOwDd4AGYhU8gYJf3AubV
 7Z1rFv0Aeq59z+kXpWW02R/XiYdRfcpNh1dlKHNw02O436vWKQxAbX9NFkzpxuenY+zgBEOxi
 enqjz1WaPi4UTlVT82Kupi+ruaW/n54zkK8k4/Y0mQYGO1xhqIZ+IjWhIoBy9LHPtf91gH4O/
 iuvFYyY4ifU5UvAcRBgWBi0IJld/blkpnDXUof3uQ3+1SNsUdcDCRnTaR0oZ6XYRiaJWREyPz
 vs6viLODgiL6AkzIpUPv3FGXwGm2POMkdNSwZDuuZRpe6bo9EiLT65HsoejPhURKkdYv0PeGG
 Qqy3PaMmu08Kn/Djp9aOg+WSO8HntgnVbgF2B21jNWWRIBTRAj9dqzW2kmKCPa+KTzGGxcjhu
 lYOO6mqxFWDcl805AjOqQzOAT/9tiqDnXOzzI+BdJp3FQuwaUIOmR/0Oce/mfeHHql8Z1VQZl
 F68HVJPdCU+wwAPB5fxcY+VskrRZMaAXvvybl/QXPyC72VOBvDdKXA8ClwbJGOGwHl+oAPbeX
 Y3ek1vNVpEpwqsWx3Goyou/2+KchGYnBK77pC82EhxWaSQPQ7u0QpOGeoec4qlVK4KtZi/UBK
 tZEhHyvkdadvzgiadSbbhuHzNkEn10vZhRm+k4yTohO8Kc1Qc5WaUMCqU3zNVVWnEErJ0qajg
 rSokY+ik2qt8DDyolnPeSbD5xH+hlIlUJCE+rortSiWgOJ7RxJYjugTJevps2TlWyMqcYEsYR
 pzRAGawC8FWaglxOtr8mjVLRT33qsecL2/VdYNoiVU1ykgmyDrMEiXuQtOOV7aR0R1D0AaVy1
 NDqbfQSzkRVbvbVns+5k5CQ+dVK9d0tTAMy3IDzBuy9m4=
X-Mailman-Approved-At: Sun, 19 May 2024 05:41:38 +0200
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

Hi Heinrich,

Am 18.05.24 um 22:51 schrieb Heinrich Schuchardt:
> Dear Tom,
>
> The following changes since commit
> 3be9f399e911cfc437a37ac826441f1d96da1c9b:
>
>  =C2=A0 Init virtio before loading ENV from EXT4 or FAT (2024-05-17 13:1=
8:43
> -0600)
>
> are available in the Git repository at:
>
>  =C2=A0 https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-07-rc3
>
> for you to fetch changes up to 41145d93556e3f1d38e5147f4a6fc65610229ab4:
>
>  =C2=A0 doc: process.rst: Document device tree resync rules (2024-05-18
> 10:36:59 +0200)
>
> Gitlab CI reported no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20753
>
> ----------------------------------------------------------------
> Pull request efi-2024-07-rc3
>
> Documentation:
>
> * improve netconsole documenation
> * document device tree resync rules
>
> UEFI:
>
> * correct handling of signed variable append
>
> ----------------------------------------------------------------
> Fiona Klute (2):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: Detailed example for netconsole set=
up
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: Update netconsole examples, mention=
 stderr

it seems the git branch contains v2 of the netconsole documentation
patches, not v3 with the prompt formatting change you requested. Is that
intentional?

Best regards,
Fiona

> Tom Rini (2):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: process.rst: Use subsubheading for =
"Phases of the
> Development Process"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: process.rst: Document device tree r=
esync rules
>
> Weizhao Ouyang (1):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_loader: Fix EFI_VARIABLE_APPEND_WRIT=
E hash check
>
>  =C2=A0doc/develop/devicetree/control.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++--
>  =C2=A0doc/develop/process.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++++++++---
>  =C2=A0doc/usage/netconsole.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 49
> +++++++++++++++++++++-----
>  =C2=A0lib/efi_loader/efi_variable.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 6 ++--
>  =C2=A0test/py/tests/test_efi_secboot/conftest.py=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 ++++++
>  =C2=A0test/py/tests/test_efi_secboot/test_authvar.py |=C2=A0 4 +--
>  =C2=A0test/py/tests/test_efi_secboot/test_signed.py=C2=A0 | 10 +++---
>  =C2=A07 files changed, 83 insertions(+), 26 deletions(-)

