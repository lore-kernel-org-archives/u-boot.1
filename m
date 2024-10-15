Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DDD20683
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 22:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E7888A37;
	Wed, 16 Oct 2024 00:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NWOqnh4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE41889CA; Wed, 16 Oct 2024 00:42:02 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2318D88A1B
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4a470d330a5so1693078137.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729032118; x=1729636918; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KqdG9tdY6HWZAjQGrxLGs9eynjVMuaKBm+w/Y+SQx3o=;
 b=NWOqnh4Dd/autX/qqYvHmiic0Or/sPI3puBLyDXBD2uNLoPXr4fUer1ZzgMSpzGgv/
 z1ANZzR0ErPnG6khFJUab1szNNn4cL49HbBNQVL+DwhftL4LzK/xxxENrYDeqi1Ztdm/
 sbaVrkMsWOQZELGZ7Oz83npl46jqzKvz/Z/8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729032118; x=1729636918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqdG9tdY6HWZAjQGrxLGs9eynjVMuaKBm+w/Y+SQx3o=;
 b=MMPkRxx6yYBwvnvBD1Y3VIkey9Am1X+nDfb0uwK/p6fgpcXRzQY5K7JLyM+8taYzYY
 H0DFkn1G+ZeWB+WBtWGf7Ze4jnYa5Bj+jL08UORz3J25xiKyfF+BjypnNUs3dFno2ruR
 O8ZhvqvC4M88dQoIsTLd5BQZzYoCn9J1WuvXz/Pv9kr9xwN3s5Rq3KyfR7Po5eJZ/cq6
 OMAzxQpbw3YJWofbqCGTfx0sVyzF7s/t/WapaeUTlowMMbNaxtdzGnRI7476BL9yfANA
 MvkuAAmOvqJP5vbfWfMzqm/fDEKmtzDxqcgqiZ+Tf4t3G0p2QTHgVxnCDd/uUaBnwyX3
 pcDQ==
X-Gm-Message-State: AOJu0YzNe+eDCg7ulZ7Ir9b+bOgyApdhJ9L4+tk1jz3e4Iqtrw2c8FMT
 /GwefiBq/vtELr6ZzYplPBg1/brhpCCcn+z6F11hVcfi9PuMEMC1Zl1ta4kgJI8=
X-Google-Smtp-Source: AGHT+IHcY/9Ei10y65hi5IOtRAJyn6yKc1fwxDruMX9ZmeBlMVvjGgTJQ8Fz5hA7hrIuGTSUtV5KKg==
X-Received: by 2002:a05:6102:2ac9:b0:4a4:9541:e38c with SMTP id
 ada2fe7eead31-4a49541e4bbmr7627945137.0.1729032117864; 
 Tue, 15 Oct 2024 15:41:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2290f983sm11351856d6.21.2024.10.15.15.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 15:41:56 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:41:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v12 00/21] Introduce the lwIP network stack
Message-ID: <20241015224153.GA22599@bill-the-cat>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ScBf26Z2w530991X"
Content-Disposition: inline
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
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


--ScBf26Z2w530991X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 04:02:50PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
>=20
> Prior to applying this series, the lwIP stack needs to be added as a
> Git subtree with the following command:
>=20
>  $ git subtree add --squash --prefix lib/lwip/lwip \
>    https://github.com/lwip-tcpip/lwip.git  STABLE-2_2_0_RELEASE=20

Can you please rebase on top of current master and repost? For some
reason after I add the subtree and go for a b4 shazam on the series I
get:
Applying: net: lwip: tftp: bind to TFTP port only when in server mode
Using index info to reconstruct a base tree...
A       lib/lwip/lwip/src/apps/tftp/tftp.c
Falling back to patching base and 3-way merge...
CONFLICT (modify/delete): lib/lwip/lwip/src/apps/tftp/tftp.c deleted in HEA=
D and modified in net: lwip: tftp: bind to TFTP port only when in server mo=
de. Version net: lwip: tftp: bind to TFTP port only when in server mode of =
lib/lwip/lwip/src/apps/tftp/tftp.c left in tree.
Patch failed at 0010 net: lwip: tftp: bind to TFTP port only when in server=
 mode
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: Failed to merge in the changes.

--=20
Tom

--ScBf26Z2w530991X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcO760ACgkQFHw5/5Y0
tyzPwAv9F3oPjmmoCxThQsyA1vBtcGcLz4RFwhetFGpSJpL3Skv1WkYVqYTF+9O0
T1xRgT6OgYo6e5b3dtxCDCjSADLzY59vnSWubcR+Q3MnnvTtRQjaAtipGIGi9LOy
QfSdFWk3lwvlXEaAMcXnSQ2su2eMeB6MK2QHtns1i//Fi+BiW73r01n0ILyiaCSM
HesQDDRL27Qk7QAT8+/xEI3+r8N6yD7kWsS1d4YJf0Z/wQRALqtjL5gEobqT8zhy
JDWXhbDUTaodqqPecX9UeceIBwjU2NHphH+eO7Q20jUOstLOStfX4HxL01jugaZ3
bbTRynUcfvMvD24bywJzcIfhVjkO8dq7hf6LlUhX8EDI/K3KAvcrRK9d9XGGzVJC
QeosL4UcpSeAZahatAvQFu/CtJCSzXDdu89gAug7CEn2b4A8x60jGbf+QBclZ/DA
StFdbPAaWTCSk6RB/AOqkGT2HWEl1E2sUUo8M9JjiuoPA4ALXL4CPIfY8FR8/r5j
PM14hvb+
=2qh5
-----END PGP SIGNATURE-----

--ScBf26Z2w530991X--
