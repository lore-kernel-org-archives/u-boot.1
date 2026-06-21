Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEEBCD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 07:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE3F84844;
	Sun, 21 Jun 2026 09:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pBEA4LEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4F784873; Sun, 21 Jun 2026 09:19:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F47683FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 09:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782026362; x=1782631162; i=xypron.glpk@gmx.de;
 bh=TLfkW6yctG4B00cVQ9c4Kwk9lJ8AeuW/hnEG1Yi+HVk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pBEA4LEyO0A10fQudBH/cWILDdURFSqCghe6t72mqUV2j5QzIUMG2iprX3StTkZ2
 CsSMZbAi/n/LEQWfcgWSnmhWMcxI6xt0yBmxHSvcP+AL2sXzOSAxm4WkiLwjjlLCi
 ScKy6GF/ni7D0zVTx/+oJO7/X14REJkm0GXxrpUr+i3Io+xtla6nIpXsHWYvpWAzg
 AdlySgKZIGzDj56+DOZ3E6zfCFQS3nPiIXx4p4hVETyPkEHfpc3JaG95RNyjupEGl
 gwkhtMlWNPE59d7tnE0bLjq5Wa0Q361cZpzLCFeL0b8L816THJxL3jPRmH6dY4HpP
 QEYw/gG/04GTvoJ8TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1xMxmy0PQY-016FbQ; Sun, 21
 Jun 2026 09:19:22 +0200
Message-ID: <38727cdc-5675-432d-abc9-092eb49fbace@gmx.de>
Date: Sun, 21 Jun 2026 09:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: renesas: Document Renesas RZ/N1D and RZ/N1S
 as arm
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260616033614.137946-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260616033614.137946-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Rnk1Q+pB5oo+n85SUdiWOr3mzB8N3Is221HEOgKYtl7a1xfrA9
 ad4nA10Lu0Gh6DTr1aZRZD3hOxJwL681XRF0IOde0WzykCkJSt6wDDDLor30keYOudyO5P7
 zqP1fMvAJ6GrV/8ESoY0/qhr7cJ4QM7XBWiSa0OswkLP9yrfpLF2Vs113M1uxcBAZtbxhgQ
 SIC2pmo6YJ1c5sz/9U14w==
UI-OutboundReport: notjunk:1;M01:P0:liu+EzJHchw=;0vUe+jedTIVolgvqeT/fPMkUgol
 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
 9t6iOdEagpXD8tYztfc4dg6hUZM=
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

On 6/16/26 05:36, Marek Vasut wrote:
> The RZ/N1D and RZ/N1S contain Cortex-A7 core, which is 32bit ARM core.
> Document the SoC as 32bit ARM instead of aarch64.
>=20
> Fixes: a5b9f959439b ("doc: renesas: add Renesas board docs")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   doc/board/renesas/renesas.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.r=
st
> index 6702d5879b5..fcfd51aa19c 100644
> --- a/doc/board/renesas/renesas.rst
> +++ b/doc/board/renesas/renesas.rst
> @@ -255,13 +255,13 @@ Renesas is a SoC solutions provider for automotive=
 and industrial applications.
>      * - :doc:`RZ/N1 Family <rzn1>`
>        - Schneider RZ/N1D board
>        - R9A06G032 (RZ/N1D)
> -     - arm64
> +     - arm
>        - rzn1_snarc_defconfig
>  =20
>      * -
>        - Schneider RZ/N1S board
>        - R9A06G033 (RZ/N1S)
> -     - arm64
> +     - arm
>        - rzn1_snarc_defconfig
>  =20
>   Build

