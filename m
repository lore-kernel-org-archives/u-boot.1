Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34060CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 21:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77E881FEE;
	Wed, 20 Aug 2025 23:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gcIBOp/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B0982E67; Wed, 20 Aug 2025 23:08:38 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7635C801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755724115; x=1756328915; i=xypron.glpk@gmx.de;
 bh=9qzS+4ihK0HjJb9KPREIuRNaB8VvD4kcl3BNNZeofOM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gcIBOp/cxjl+hv8jzFhCsj1Gm9jwrtT6/7mh+4o/g+T6qUdbsSvTdrck0zhTl5YK
 FpQlkwOEskD6aOJbXm9h4N1yagBnoJ7syl/87zJiighnMNQ1pwd9WpMRLwFoKvX2v
 Xp7lrBPtNQmEXivpz/J9tLZ/keYPiK4GaTrNPgWA4V4k/4AsOpaskxMd/UtKivod8
 Nnmo5/THuzSeZfCbaC0Y28AO5xGbeSFnjHnlcjR9oZV4D0f0icE2sqU6GF/crIwJK
 0q+ohhliddnt7qCOOmJv1V5K6l+arcxFYDoh8pBDxhRrqibdLExEk/C8l4tCljx23
 0oudGMfDJxKmwL4FfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1uBKMt0v7Q-00ppZi; Wed, 20
 Aug 2025 23:08:35 +0200
Message-ID: <b8fa5fa1-0028-43e5-bb14-db94fd16bf3c@gmx.de>
Date: Wed, 20 Aug 2025 23:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] doc: Add riscv to the list of architectures in
 tools/buildman/buildman.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-7-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-7-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AMcOBKlCNtZJMtXKQbXbQayqMAdCEc1k9eLLfD/fQLYx2LeOmZU
 ceKVF+SbNoLhw7aWw8ydS8Y1HXRWB04g+NOargF+ej6jiEnbdg82fyGM4bnrOkS/4CJeGh4
 fmkRbfQI4hJLuSEjqrSWd7ppoSQZLtms7oPT58bXXVP1t7shLOhzU37026sjrKkog6ixXzb
 eJtGAI5l+gDQZNiShjTpg==
UI-OutboundReport: notjunk:1;M01:P0:VWEGrjuVSEQ=;5j3e9u1FFifWs9UqGuQXtvyljjH
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
> ---
>   tools/buildman/buildman.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index d5d22732088..7944adcd867 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -478,7 +478,8 @@ Setting up
>  =20
>      At the time of writing, U-Boot has these architectures:
>  =20
> -      arc, arm, m68k, microblaze, mips, nios2, powerpc, sandbox, sh, x8=
6, xtensa
> +      arc, arm, m68k, microblaze, mips, nios2, powerpc, riscv, sandbox,=
 sh, x86,
> +      xtensa

The output examples above this line should also be updated to show RISC-V.

Shouldn't we provide human readable names, e.g.

* RISC-V (riscv)
* SuperH (sh)

Best regards

Heinrich

>  =20
>  =20
>   How to run it

