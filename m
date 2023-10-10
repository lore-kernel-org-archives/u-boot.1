Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE8BCD80C1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A51886E00;
	Tue, 10 Oct 2023 14:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bP74AlJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6727386BED; Tue, 10 Oct 2023 14:58:47 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA06186DE7
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59f4db9e11eso66489597b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942722; x=1697547522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kmJoxZVHR6xFI5tpJF24/RLBsqYPhYnfHJxcb01WbZ8=;
 b=bP74AlJU8Q+Tk+dsgDq9qacr+86iPiJ6ROyaMVetaCcH+1odvulIbNTuTW/501GJmd
 RXnQ6pXclLThKsPXeX0+THLFsS3lHc+RvZRJl1z84g8Jc3mcAAdmAJwMcwL5n3NDz6zq
 r5YqUNvqlAk4K++P5vTptoX0S/YHWOzFz2j/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942722; x=1697547522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmJoxZVHR6xFI5tpJF24/RLBsqYPhYnfHJxcb01WbZ8=;
 b=oN6IOeQNLjNrMKnMQ7FlrSwOj4THDRLHr6OQDNUa64d5ymB/K/Ca7G/1KgEuDofeNs
 FjeOFdtMhZnL5rhEcyk62o7EDxRHoNcoJu7CMwpD25DAdSulr1GegbrPSjVmQGktgzlb
 lfsf+cfgUBxcdjlvWOvHdpSygQItRqb5cFoXh3aJStbt2HkIR9KKgWb0hGsQQ3/VM52P
 zJFd16Tl6q6J669o66ARKJh9kPyCE9AQc9Gn6eOGvHTr7WKJOZXuS5p6yIyfrDhuhJ25
 yj3vuUZBfDhcCFixx9jwF20RRhf+LRk3QFkIyZaiLKOdwtVft6rwpRzOtBWbAKAcvcbR
 tuLw==
X-Gm-Message-State: AOJu0Ywvr8X2I5VCL7NOVeBEVLNrR4zvdCH7enw0BSVY39v8tZooGH/x
 BPFyms0/9lY6QJm2WHxTWNrQ1vOuVT54j2c1Py68Eg==
X-Google-Smtp-Source: AGHT+IHpJ9DKzKeVgftyLxTQha1VEfrbuMs9nbMvaTe8XuiFVMFXHKpWjD82zN9rUQk73No8x9PbDA==
X-Received: by 2002:a0d:dc81:0:b0:589:e7c1:96f2 with SMTP id
 f123-20020a0ddc81000000b00589e7c196f2mr18674160ywe.46.1696942722467; 
 Tue, 10 Oct 2023 05:58:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 e82-20020a816955000000b0057042405e2csm4389831ywc.71.2023.10.10.05.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:41 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] bootstd: use ARCH_DMA_MINALIGN in memalign() when
 allocating memory
Message-ID: <20231010125839.GC2227687@bill-the-cat>
References: <20230919212722.16216-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vhGbjxqF7H4UMq/y"
Content-Disposition: inline
In-Reply-To: <20230919212722.16216-1-mibodhi@gmail.com>
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


--vhGbjxqF7H4UMq/y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 02:27:21PM -0700, Tony Dinh wrote:

> Use ARCH_DMA_MINALIGN in memalign() when allocating memory to read the sc=
ript from the media.
>=20
> Ref: https://lore.kernel.org/u-boot/CAJaLiFy05F3Cr4X4G2mVkppXnBEFZrHQ+5Cn=
gYN8eJPg8ENWkg@mail.gmail.com/T/#m26daadc2463fe653b814a94e6309e5e6bb6be1d1
>=20
> Note: this patch depends on the previous patch
> https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-m=
ibodhi@gmail.com/
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--vhGbjxqF7H4UMq/y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSn8ACgkQFHw5/5Y0
tyxvDwwAlv+79whZqP5h9pA7Q2qeJIEVx+oI0qtF/KrrtNTyRC3Jj7EJ6x+V/BOQ
lurYsnUj9vlsjI4F7ymRaVFz6Bb9dkAxlt7UnTtNjJRXONNA8PCdQk4n9vVRikIQ
AWpNHMMmWpkoL1KYfPjWXkzpm+bWlHc47EKnWI+rp/CIhE1iQaZqdcIDODiXmICz
jgq/hpiggJkD2H/FifpgfYvPi4djRJWyDGghxjJS2unhZc5FyX9ksXaDDae0P1UL
9OrkjN9V76iqFI9/XLs9QX04a4H9GdmIuw2tOHaWQGG1hC/J/eeu3OKceLsJkEfo
DWQYiVEB2t4zJwd4cP1QpC9tPhDqYY0BkMdY33AjTtEdpKbBA0t42ppOdeUw52bi
lOpX12DAat6d+o36Cui5+jeT5thnEaqp7Pqyw0k1aEXcT8uhXgvvgmVWWSpjpsBk
4YDYeHd6DdopEJEkLXweaEEirnBnFClPOkAqUzmPMlrTKMX88PlB5JFl5qshzZ0w
Xh6Ce7Eg
=2SB1
-----END PGP SIGNATURE-----

--vhGbjxqF7H4UMq/y--
