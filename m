Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CD8EE14A9
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46902869D7;
	Wed,  6 Sep 2023 23:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dHlCZuIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 200AA869D7; Wed,  6 Sep 2023 23:58:19 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B44B869D1
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5921a962adfso3591957b3.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694037495; x=1694642295; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H5Z48cKkt7e4tLVcpEeDVlXTPgu7gzvq2BRYlnD8EOg=;
 b=dHlCZuIoIoO54+B7Hh1DfsHjrhyRvulOr/ive/J1d8aF7VsGPzf+GE62MVHTBHh4oS
 cQllQ1RL/YzGfx4gxpFYGNWTdDAzRTCmosbcCcK/hTvgqzb9F22yp5l36ZIWfMxZkXiI
 OYfpfu4sTrjQo1uRUYZzEkTt0Id4IbMhImOwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694037495; x=1694642295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5Z48cKkt7e4tLVcpEeDVlXTPgu7gzvq2BRYlnD8EOg=;
 b=cZnHlnhYhkrg/uubl8dUy8RiHSELqLNrOuJ9o1uxt/AhHyAhgnZKn2ldQeVyWanrrY
 wHBZ1S5TicSMqQO6bjBCZwHucPatDauDivg0Z+L8gfBXsuxrClTlY6nIBqRjYsyDfuna
 xf7UDHrpmoc9NfMDPDOH6W30PCOOgHTXixNHYLd6U1NycV5XSIp0NzH7tFjRuMp49p4x
 uN4MW4cHMoY+4GieBfD1/d4BCtf8j9lRkAZhXFqkdJFAJx2qo3O2LWQUonQXyUypvDst
 Iqaae1qWBKvQ5N5uaQy832IOBIEVTNItZPLnxpetuMadvniBNOkkeAurW8QYrTyVUx4v
 abXg==
X-Gm-Message-State: AOJu0Yyh/NnDNMzFSFGCx25M+qGXTfQfBNlcxZAauSeP3sLfz/8vjchc
 /mTKHS9EzSnDMcmlAqARZby3mw==
X-Google-Smtp-Source: AGHT+IGJ6lhcObaEy/M73K5xN1Oh0flPMB/VSZetF64ZUlHve2NjbQUKBBjOETuatnRU9d7UXt/9+g==
X-Received: by 2002:a0d:e8d5:0:b0:583:af98:6fb3 with SMTP id
 r204-20020a0de8d5000000b00583af986fb3mr19168157ywe.15.1694037494754; 
 Wed, 06 Sep 2023 14:58:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 x75-20020a0dd54e000000b0059565f338b2sm4025593ywd.98.2023.09.06.14.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 14:58:14 -0700 (PDT)
Date: Wed, 6 Sep 2023 17:58:11 -0400
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230906215811.GJ305624@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ltvToISCyBwJi5Y8"
Content-Disposition: inline
In-Reply-To: <20230906142139.GA1236014-robh@kernel.org>
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


--ltvToISCyBwJi5Y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 09:21:39AM -0500, Rob Herring wrote:

[snip]
> On A/B updates, that really doesn't seem like a u-boot specific problem=
=20
> to me. No one wants A/B updates in EDK2 or anything else?

This specific case goes back to:
https://lore.kernel.org/u-boot/20230410232112.72778-1-jaswinder.singh@linar=
o.org/

But I believe Sughosh and Ilias are basically the people who are in
charge of the code at this point?  So perhaps a step here is some advice
on whatever they need to redo/rethink to get something that is
acceptable.

--=20
Tom

--ltvToISCyBwJi5Y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT49ekACgkQFHw5/5Y0
tyycLgv8DoS6UAzuOK6NIi2pdgZS+zezeIFNooiQqzqpnIy6CRnY1PdSL44+6xz7
QNIOirmxLWsYIOd05Et2bqKF6bm/bXXWh7bqHkPIMYd3McW7n6XFcGgzLy0YMMZL
AwCv6zD0pw5Gn7Jw86MCGQJ9Z3E18NraBnncc6QkIboyEnGyb05/if4gieIsBFlW
dXzQEZMkKCA2az95PdCrFs2732vFadv3Hk8HWpmrH8M2s9yCHLCkKuXrUBfzoTig
YhHu1CwIQe0kTeGlNgwEfvybBIYIaO0YzfFZk/86TVZrgovGZzdWZHXjnpss/HG6
Lkeb74h6yDlSODMqUiR3idkaoyoT07Ao3eO3+jrBsTg/5tIU51iHogU3CU8GpvTQ
dBvP7DU8+icGBI5P+83PyOqd46pWyhYwOktGJIGvuaqx1QXO3DZ/3io864RKiD3w
JZ6elvafr57suUEPPaAcwRXiLhZ3rH47uSPoDsO/Pk2W85EMjLHWogjMvPvfzL9F
f9xz+H4F
=512E
-----END PGP SIGNATURE-----

--ltvToISCyBwJi5Y8--
