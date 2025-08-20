Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FDCCA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 20:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B54681FEE;
	Wed, 20 Aug 2025 22:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jdchc3zp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7586582E34; Wed, 20 Aug 2025 22:34:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF258006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 22:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755722093; x=1756326893; i=xypron.glpk@gmx.de;
 bh=tIEuwf78V5MahneEdNZ+RqPTtT0bPWMOfvkOEeCf0PY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jdchc3zp2iwSQk1ht70LcTgA9QAfCYWM9PrJAiGJL85CiM5w9iFHLqXKRGU9p6Rz
 c4MatBNmduekmYUrUpC5yg4cnNHYls70Eyi28CXrcODhVm8hlnMU5sqXU0ibJ0VI8
 jmJJhTOnKxgR/wRRGCB5XebC39zoM9AldwSLtz+bIrDP8WWRsEhIXicYqAaP7Mv6C
 9fp/1QY7C7kZE1oo5Wq8AmTlkeKHdwh32tAni0uMnsMbwsSGldFHN/pRLaUTtsQIu
 G2Tn8e/SxnXHnN5PH88a0RvJdhB6rYYViM5u71eDANBTEG/quSNkkHcVSE7TWokXZ
 hu13VBp8VPMDWMuNKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1unSbi0wfn-000EqL; Wed, 20
 Aug 2025 22:34:53 +0200
Message-ID: <4be90bfd-dad4-4c9d-bbf9-64ea3f52a52e@gmx.de>
Date: Wed, 20 Aug 2025 22:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] doc: Fix typo in doc/build/gen_compile_commands.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-9-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-9-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETFqXzioAJTdWSHRpj/VhCRlcEcu7TyWhdCjIWz8c+eOWJgdudy
 ZLR/6bR82Bs1B4cwlMWHNxJH197eDFyN6C2ajUt//f0WMyuQPGOuMTdsqwFmJ/hYbMDBiBx
 mWxplrehva9Dwlblgv4DzK2mqLwD2Cx2baKZKwksPmSidJL5tICprzRWDQh88+MErVldMhe
 smXpkHx9PoXU3Nh4SuAbg==
UI-OutboundReport: notjunk:1;M01:P0:lTm827/TkU0=;Tox6hjSRDZE0EvzxmxtYi5pzHbX
 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
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

On 11.08.25 01:37, Adriano Carvalho wrote:
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/build/gen_compile_commands.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_=
commands.rst
> index d503764f9e3..5eb9e4ccb0a 100644
> --- a/doc/build/gen_compile_commands.rst
> +++ b/doc/build/gen_compile_commands.rst
> @@ -39,7 +39,7 @@ course) to have an up-to-date database.
>  =20
>   The database will be in the root of the repository. No further modific=
ations are
>   needed for it to be usable by the LSP, unless you set a name for the d=
atabase
> -other than it's default one (compile_commands.json).
> +other than the default one (compile_commands.json).
>  =20
>   Compatible IDEs
>   ---------------

