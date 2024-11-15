Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3DBD68BC8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 16:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDA1892CD;
	Fri, 15 Nov 2024 17:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WR+YjmgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6355989326; Fri, 15 Nov 2024 17:12:44 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339BA89294
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 17:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b1474b1377so57784585a.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731687161; x=1732291961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IHo1A9p1iBEYx9r+hwXW9T3BHqGuBlvI4qkZjmQxN+Q=;
 b=WR+YjmgBl2WmsgFFQIAPy7Q742VKR5q5h9p/d/NGxt/hlg8anW+QjRNXNyaq49wzrh
 fj1kYIkXatbxxxEHIbI0HwRRf/o7+FAdiOIAd2NAixk9PJ7YYg4rK/HBWQdIncGZZ7Se
 xta/5z8YDTDWvO2fPEQIvJCIsw+hfVR3BMsfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731687161; x=1732291961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHo1A9p1iBEYx9r+hwXW9T3BHqGuBlvI4qkZjmQxN+Q=;
 b=KzVKFNwSZOp464ZsYHHJoYQTIj+LBy+Mw1zrgfqoZoxgGxQ4vHyjebZyjlQX9Xwofj
 pJdtC1HBu8j/t2/4A5sYMFkvH8wlQm3woZeS3yJz/yIVUtP39aVtqGfsIFjjkKKoExqw
 wWYoDJfVmh/ghokjRxJvFr1S5ELR7kbjSCJ/sGygy9FFXD8WWEhWY31EM123iKijKhTu
 e4UnLOzI2iNGVcHAFRKoJhI3uEHqeCofotKIzi/eRA2oDhv1YhCYiVoikxWXXwqgsdcn
 6P/WgqsXoxlGpR5dHqYl8t1yoxOipHcjAcOmu0LtkUwDMB9KRriSHZnVgyztaRuP9e2/
 he4g==
X-Gm-Message-State: AOJu0YyqOd+c4dbDTkUVIO8G55vvZ7Y3Hg4Z9/OLEksv5CzAFojyjrst
 21tZAbd8sueqDefVuZloRZaTt3YaXifPnD65fV+X2IWMMH+fNnKu6ZxkRdaIe2M=
X-Google-Smtp-Source: AGHT+IE5v9BxyVPLVKwXdY0J+U0zt9jwnFwr8SaD2Z9XySj0WqbEinLi1sFyr1wy7RLe7RUZv3Z6vA==
X-Received: by 2002:a05:620a:2993:b0:7b1:45be:2e87 with SMTP id
 af79cd13be357-7b3622b8bb1mr357492685a.18.1731687161003; 
 Fri, 15 Nov 2024 08:12:41 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca4f60csm171033585a.100.2024.11.15.08.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:12:40 -0800 (PST)
Date: Fri, 15 Nov 2024 10:12:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 3/9] buildman: Support #include files in defconfigs
Message-ID: <20241115161237.GX3600562@bill-the-cat>
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-4-sjg@chromium.org>
 <20241113024035.GI3600562@bill-the-cat>
 <CAFLszTibM9CwXeTbF6OuFrW4YSSs058qa0OysY+fWy7vV6WRkQ@mail.gmail.com>
 <20241113215324.GW3600562@bill-the-cat>
 <CAFLszTh71mmqUL62NdS_M6=0nOi22+4FKZNMHm2CibqM+gD_CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YLXmEvlS5tI9vEAv"
Content-Disposition: inline
In-Reply-To: <CAFLszTh71mmqUL62NdS_M6=0nOi22+4FKZNMHm2CibqM+gD_CA@mail.gmail.com>
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


--YLXmEvlS5tI9vEAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 07:26:56AM -0700, Simon Glass wrote:

[snip]
> This patch fixes the 'buildman doesn't support handling #include files
> correctly yet' problem.

This is good, and what I wanted to see. And the final patch in this
series shows that we can indeed trim down many of the current #include
users to be fewer lines, and that things like:
$ cat configs/qemu_arm64_acpi_defconfig
#include <configs/qemu_arm64_defconfig>
#include <board/emulation/configs/acpi.config>

Now work with buildman, too.

> My other patch proposes a way to allow
> buildman to build things with fragments. I'm sure there are other
> options, but since buildman can potentially build all the boards in
> U-Boot, it needs some way to know whether to apply a fragment.

I keep going back to, why does it need this? If it's important enough
for CI, it's now a 2 line (or so) defconfig file. Done. No new code to
maintain. No new jobs to run. And _every_ config doesn't need to be done
in CI, either. We have things like
board/asus/transformer-t20/configs/tf101g.config which just change the
device tree to be used. And once that's upstream, there's no value in CI
building that (there's no value today in CI building that, we don't do
anything with device tree warnings, etc).

> For building a single board (e.g. with --board), buildman could
> perhaps allow fragments to be specified?

On the one hand, yes, it would let me think about changing how I do CI
on hardware to use buildman instead, but on the other hand I don't think
it would make anything easier, so I probably wouldn't.

> It seems you are asking people to create boards containing the
> required combinations?

Yes.

> I see with TI there are two possible fragments.

More than that, if you count cases like
configs/am62x_evm_a53_ethboot_defconfig and
configs/am68_sk_a72_defconfig where the latter is just changing device
tree BUT the desire is for end users to trivially and non-confusingly
know how to build the board, so "am68_sk_a72_defconfig" and not
"j721s2_evm_a72_defconfig am68_sk_a72.config".

> How do we keep those working in CI? If you are wanting people to
> create boards for each (which is fine by me), can we produce an error
> when a fragment is not used by any board?

Not all fragments must be in CI. Not all fragments are "obvious" either.
It's not always clear when a fragment is or is not valid with another
defconfig. Solving these kind of problems seems like it's a high effort
and low return on engineering time compared with "make a defconfig".
Especially now that we can lower the effort bar on making the defconfig
as one tested with "make" will now work with buildman too.

--=20
Tom

--YLXmEvlS5tI9vEAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3cu0ACgkQFHw5/5Y0
tyyULwwAuYNJ+tJPytMvzvkPo2E/t96g23JztPc5olvfqh1kFP5OrgBxRkBQ7OGv
sOMEdyCdfJb5/vIDUp/AO9ivqWHzqtB9/+pGdoS1E6vYi1SQelxgIbu80+lAuyVo
Fa5CoOGgIRGgvQ2XhKT0FTW7Axfi5WceeMVivWMQK5rsqQmIQLcSi2FU8dmYfuH2
ooaEnnMAdWV5BZiBOTTbFC1pB6KQz+YYdDPmUjUOXHIYz8pqoPAu+8Z2ZR6ZG9m8
4r85IXeVHcMZF24en76l9hJuFpum1shW0jp1ia1fZ8vbikZ5uUpKgYufqea42VJV
/nqJGGIuIhqPssWejn0qemMszM6y2I3HZfY/IHH8gezGr4nrw1GCbxYROvyzhokJ
HaTtxJO/aRUVxle69k0ogJVQUuvBso3+BODqV+kqjEg+/cp/gFJ4ihXN2m1Eum1R
POf3sk7+SdcEHm8dLWaJ3S3khhaKOnWXEbmrxXeCZMHgpR71Y+uP8Vdvdg5CfVEb
vozVY/ZF
=LcAN
-----END PGP SIGNATURE-----

--YLXmEvlS5tI9vEAv--
