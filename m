Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C356CD18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4089B891B4;
	Mon, 14 Oct 2024 23:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KjLoAMkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B910891B4; Mon, 14 Oct 2024 23:11:58 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14021891C6
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46063b6b82eso13578111cf.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728940315; x=1729545115; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fqUM+cRorGUKUNqHrb0XB/RrUf8fDnPSn/hbORR8NoQ=;
 b=KjLoAMkkYaeQYYsy8fuChY5334v4ryXLgSFxSvBfyo3ACGKSf+P7uXEW3SfwLzhzki
 dHgW0oaB5u+h6ojU1vy1EYPkjBz9RzEm9uNXdmF5C/sgNs0v7jFLt4CgzGkfvxHlNwhe
 sXCfuyPdcbA/6ClgCHffa52zhTRlGhdFdEaoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728940315; x=1729545115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqUM+cRorGUKUNqHrb0XB/RrUf8fDnPSn/hbORR8NoQ=;
 b=EtJnCi4aNlq1VS9f6CsBIdg5svd9wUwWkSQFEqIYmCnCTxy86QPE6pLjopeagCMhbT
 XKsRHjV2XvTIhZTtwMYv3pXEph2ym3tj3WJzedoVofmBMh+DLBpKZgqBcGUA1YliKKiN
 ZT920egEHNf+IsAEXj4HWuBTsPFBmOCYUU1RkNXr480Q/+kRg9MUmTP2IdPJXdl+UXbh
 fff/1IWwsuXCv0JK0wtWU0olB20FB44OmbAcOK4GWVZe3WNPk8qGcF1p9xwLy/NMUev5
 sIZ9RDKnxV578vihi2e1afOQGyGspeDYfjRkYmklBFscjObw2V1UvP055feXVK09sAOy
 v/Fg==
X-Gm-Message-State: AOJu0YwMGPMthyOkwF1pxcnHyknlkAhBAu5uXmLkp0VSdLNJMdMf7AE/
 ijUkLN5iHkwdYW0M3gMm93kHN1WZ9ArzCPgCg9cqo2e2AAT/LfDVu8io9boZgwY=
X-Google-Smtp-Source: AGHT+IFpMTFkea+iF68niSowAofJxM+N09PooKB9bryjswKuEz8KYfqzAVzOCAnXVOCd7GJy3GFqCw==
X-Received: by 2002:a05:622a:1999:b0:45f:40f5:143b with SMTP id
 d75a77b69052e-460584c356amr175499141cf.53.1728940314587; 
 Mon, 14 Oct 2024 14:11:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1148c6c8bsm458788885a.11.2024.10.14.14.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:11:54 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:11:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
Message-ID: <20241014211150.GX53053@bill-the-cat>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
 <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
 <20241014035122.GE53053@bill-the-cat>
 <CAFLszTiVsoTdKiKmPVugc9cLk-A+XM2EdiPUE0AFK=g8RPx+0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g27CEZeaId5Wr51v"
Content-Disposition: inline
In-Reply-To: <CAFLszTiVsoTdKiKmPVugc9cLk-A+XM2EdiPUE0AFK=g8RPx+0g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--g27CEZeaId5Wr51v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 01:13:41PM -0600, Simon Glass wrote:

[snip]
> Or perhaps just have a way to turn it off? I first sent this patch
> last November. It is just wrong to generate output like this which we
> don't want. There isn't even a test for it, so just add a way to
> disable it, and be done!

I don't know that it's unwanted. As I'm trying to get Heinrich to
explain, _why_ does efi_setup_console_size need to exist, and do what it
does? This isn't the case of color-coding the output of tests as they
happen, there must be a reason we care about knowing the console size.
At that point we can figure out if the right answer is:
- Don't generate that check on serial ports, it's somewhere between
  misleading to wrong.
- text-based tests just need to expect and skip it because there's a
  good reason to need to know the console size and not just assume
  80x24.
- Something else we won't know until it's clearly explained why we do
  this.

--=20
Tom

--g27CEZeaId5Wr51v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNiRYACgkQFHw5/5Y0
tywaYgv/atRAozoyVs+lrRnoWq80U6GTonRYHt+gvSmu7X6tNry/aEClyDJcKkIa
RoUVbAoTOOqcUm30jiP61LxNWJsDecBi7Xe9XrnoY44QHcTExKKAypKa/SmBwP7/
rITvv2jUgHD689lEWCvmIMUOp7I/etglNc0RXyubfd+8BOFF1nX+TZEDFhWsM34O
7gXz68gOO2JVSfRivLvXcYGLNma4XjVK+e5HmWXnUesgoMb6Idly8VgEv1oEFFkP
UJUFyi9AXHuaMap6/A1ouDekYwRlonGXgy4eRbwwN32QVaD4j8lEsjg26Tcam4ka
MsXnX9eGee8PRQZWfwaieEHzoEEEpWNwjyMfazZ8T8bqealXstLl9Bthhs5efMr6
teCFhYOmD4ICibrzqED4gnT/4R4WakJz/50J3DCGxbt57eioLCWXEZmJV1M+rqnn
1MeoqP1jI1aj+mNICGnckdu8vBzF9RyhLaYTomaIeGcM/PI3HHXaBCjpjDcf1U2r
+1RD47qM
=tu/+
-----END PGP SIGNATURE-----

--g27CEZeaId5Wr51v--
