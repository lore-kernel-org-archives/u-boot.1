Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7035AC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 01:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 913D887EDC;
	Sat, 13 Apr 2024 03:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CLu7jBP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D975D87F19; Sat, 13 Apr 2024 03:08:37 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E49D187DF3
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 03:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712970514; x=1713575314; i=xypron.glpk@gmx.de;
 bh=3Z3QHLxT1ABytuMps2rmz9LbfYFh9yB3ZRDYB8IH1mU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CLu7jBP5Ul/iYK9c2fwDT8+v7mpHzSwTf+KORzuYeNClTTgaEQnadgE1w2XTYfhH
 j8Q3fIxmrpIomJQ3i20E1WUaI+F5KpJLZd4UDWxAWwMuzLZW5PB8TzqN8wjcnIryb
 nD5ZXvtxURdDlMYbQtiolVUwiFAAzJBMo9jy6HuRVedWa3mrPStKC7ZqlHQ/Eb/72
 iVh2/a8cSylBaeLXJ3c0xSVlPxhVVMPceFG7VIrUZ7WPvKGEbcCEzdnDJu9QDWs4E
 aF4f7Ih9FH/rl4gWzwBzs1NWqQzqQRqh2lDqM8Z7qtgytJITaiAPLu0FXElB2tXHI
 /qrHPVmDFTy3lq7EQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1sOQq83Dpa-00gaJS; Sat, 13
 Apr 2024 03:08:34 +0200
Message-ID: <abf23260-8ceb-4886-9fb0-32de02d2b0cf@gmx.de>
Date: Sat, 13 Apr 2024 03:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/sphinx: Bump idna to 3.7
To: Tom Rini <trini@konsulko.com>
References: <20240412142317.966448-1-trini@konsulko.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240412142317.966448-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/tw4rNwGyUutdlQ4PrXuaIe+wxWCCZndw1K4lN6Wmg6fjtaeFrn
 qUZw/XNn9hsfCliJAZwYPf5MTHOSaIgIBU9NOlRzWq1r5CRjf91Mk707peKvG8VyWQsMxms
 yUd4myad7YJFFGAhSuLAgU0DA2OFXz1AWN4CmeupGJhPeVERPo2L7rrqG53FgeQazf9Hh8I
 5BbYyQFErjyGLbJO+MdeA==
UI-OutboundReport: notjunk:1;M01:P0:+df+VXQjjhI=;4vW9Pz8n3rG4pZgsELAWIAnu30B
 ly6u3bv9oMD4t1aapoePJAB2v7S/3iHIxdQfdvRafOOzwWFmGugSEh+wuuJtksXGdLYTPIfZ7
 +eNoVPp5fxIec3cTgtjlY3nT54LCHkV/HOoJlChznFeLxx+Rmbt9Xn/G1sJam3n6V14IY5r9F
 0TCuisxUw/3/dFLXDrtvrS7TpW/8fm+Y/F46x3R9obOL/A+XiQtfFFKCD1ixelgOjgna1KCHy
 FH6erN39mupwozdIs22AyaJdlFJ3tSpHQ8uV7UdRA82fNKqOR8q34IFnJZOHxEV6O7qhIjO1o
 kjLr9o3s9Uk6sK4CkgadfJ6cDwAuGl8at+DmRR16u4cpU3lwkHkFxgM7p0KLAhXyhKtMrWB9D
 7hi5qTH5rC/PRxUgEryO3ReSXKms+o/5By4B4N8qE9RvfI6uzNT4j4E09EiEdzS2BlaAt1Y+q
 2Tf8Xzf08F3TZFiFkoQuvyPxQ89f2Z33EeyCPpzT8+jm7AjobiG8SZQoiO5NFZtRxriM5Rs0j
 bg734F14e8XOFVuBXyc0Io8XWPKiAFUDfIySCdbFrGrZ60nJprIhhdTqxQb5+FFN/BydETvWr
 DJGcCl66rNHt9KXAmcWXu/+aZLb8015gZx12Mz2mbX1xMo1numwsoMU4BCXCxm24gv13BBKJs
 UE0TMm/1sgLRPukMcSwDputc23J+Ux21rLD1/UWLdbBaN97Tqwvsy2M+HMP5QWrYraDvplhx2
 olZXFJK1KJCZChT6GLZSjYt+DlsVsVvWHG1HeQscitOGZ6G3MeJ+ZcwTIGvdhHn//NRxOuCyw
 wvsT4kIVuFhkXie3S8cfIt1bauMKJLUpiPJWHg2v/MxOU=
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

On 4/12/24 16:23, Tom Rini wrote:
> While we unlikely to have an issue with CVE-2024-3651, it is simple
> enough to bump our version of idna to receive the fix, do so.
>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/sphinx/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> index 840c6cedfde4..5b4df36804b5 100644
> --- a/doc/sphinx/requirements.txt
> +++ b/doc/sphinx/requirements.txt
> @@ -3,7 +3,7 @@ Babel=3D=3D2.14.0
>   certifi=3D=3D2023.11.17
>   charset-normalizer=3D=3D3.3.2
>   docutils=3D=3D0.20.1
> -idna=3D=3D3.6
> +idna=3D=3D3.7
>   imagesize=3D=3D1.4.1
>   Jinja2=3D=3D3.1.3
>   MarkupSafe=3D=3D2.1.3

