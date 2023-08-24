Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B395AC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38718468A;
	Thu, 24 Aug 2023 17:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fIPJOzCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7B3852DB; Thu, 24 Aug 2023 17:14:25 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1291283F7B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58fb8963617so56825997b3.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692890062; x=1693494862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s1VJt08D8neLd/fvyQDw5SBQkUW4MVJb5NLNgmZTks8=;
 b=fIPJOzCTRHWIbh3qOoX+Z5kaXuxprAlppri6TmLCKi4FLzoPZe6I27g2UxZrm2LJh8
 BhoStaD7/RLNHo/Zl1GH0QCHtwUUk6t2C1I8C87kFL3VVh1IZYcqq6GRPCisNeXXmZmp
 SfO8GSBUP1XIxWxUWpzwE/oNz3QWyLYAVl37E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692890062; x=1693494862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1VJt08D8neLd/fvyQDw5SBQkUW4MVJb5NLNgmZTks8=;
 b=e3Fch2exnVTEq+GSHsMy/sIcQlzBNciOi3VT1UNZeH/bnBdiP79oTdeDu6x0E2FFbw
 9zrB9KsjqlfrfcUsS008NyPKuKdJaH+/QsaxPxfU4CQQk0wITWCSafF0Fv8unk3bxo/Y
 K+932uxE4E3cMlX4PuA2wRj9FkteUcft8UM+YQnXBJvDaYplmnN5FXCvZ5SSkzl4OluJ
 l1CQoAR1dOY8Um7uKeRr9H05SRZa4gB2WBCeEW4GzUMxY0aZdkiDYCz2Obna+9bEpbpb
 yyn2+/2R6c4oTE8xq76igFBsqBe6Tq73P4dlcUIhmcomTFqCOWRWSGf9iCZuwGEGMsSC
 TDMA==
X-Gm-Message-State: AOJu0YyqgTvylPwfXsdwo7KxsulX1Sbd6y3SfXVswwcXWqxZaOyxv8Zg
 iXz9ZgckIduzUI0zceNlJzzXIw==
X-Google-Smtp-Source: AGHT+IFxmSiYbvodVecLQS/AjUM0gKYLdkaUTm5PjaJKQNQJnqBcVq1j+34wybPwgCXuAJVk60tMpw==
X-Received: by 2002:a81:4813:0:b0:583:cf0f:152d with SMTP id
 v19-20020a814813000000b00583cf0f152dmr15024779ywa.6.1692890061681; 
 Thu, 24 Aug 2023 08:14:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 d77-20020a0ddb50000000b005794a9576f0sm3980842ywe.9.2023.08.24.08.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:14:21 -0700 (PDT)
Date: Thu, 24 Aug 2023 11:14:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Dillon Min <dillon.minfei@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 6/6] stm32mp15: Use u-boot-spl-stm32.bin instead of
 u-boot-spl.stm32
Message-ID: <20230824151419.GU3953269@bill-the-cat>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824030304.1555547-7-sjg@chromium.org>
 <3ab486b0-be22-48b9-7417-742ed8360f0f@denx.de>
 <20230824142505.GM3953269@bill-the-cat>
 <4cbffed6-6a07-1a56-bf10-7303e2aff78b@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZSfaC3nGqLOtAzN6"
Content-Disposition: inline
In-Reply-To: <4cbffed6-6a07-1a56-bf10-7303e2aff78b@denx.de>
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


--ZSfaC3nGqLOtAzN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 05:09:07PM +0200, Marek Vasut wrote:
> On 8/24/23 16:25, Tom Rini wrote:
> > On Thu, Aug 24, 2023 at 05:12:45AM +0200, Marek Vasut wrote:
> > > On 8/24/23 05:02, Simon Glass wrote:
> > > > A '.stm32' extension is not allowed anymore, so change it.
> > >=20
> > > Why?
> > >=20
> > > This will likely break a huge amount of scripts, I'm tempted to NAK it
> > > unless there is a very good reason.
> >=20
> > This is in the cover letter.  Today, buildman --keep-outputs doesn't
> > actually keep the needed for booting outputs from a build for a number
> > of platforms.  Simon's response is to stop having a free-form list of
> > outputs. With I guess the caveat being ROM-defined names (for example,
> > we still keep "MLO" because that is the literal filename TI ROM looks
> > for on FAT partitions, on mos of their 32bit platforms).
>=20
> Why not just place the free-form files into some output/ directory and be
> done with it ? Then they can have whatever extension they want, as long as
> the output/ directory name is stable.

Yes, an alternative here is to just extend the list that's removed in
patch 2/6.

--=20
Tom

--ZSfaC3nGqLOtAzN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnc8EACgkQFHw5/5Y0
tyzvyQv+MeDLK95du07wAhtZZK61NKOOhy0HC8/arU8ccE0RlA8Go00e2eJ6cuGO
WDyqOlVe9KSyOUlcPyftVuE5PfxIjuelg9b4qWIasQs2qV5JLIA8N/kNT9vyfX/0
2GFvYqe5/IIyAhz3Mc+YEseqf7R0PzExq9B1tTi/HL2Ko7vhCTD7Ds/kMc3oB8H7
AmAAFe+Ht2QOVg7W2uOlpfZ+nCqMXTdvKsFqDj5BVzWQpe9984EkMzd5wbk6KcCe
G/IEsWdYWOP2Xj67WlBHuM0f5oDe17D1rFfKbBTdjtRWb5IdwZ+X6P/k66m+DqIx
sy2HI22Udqotmgn38kyEH0Q6oy+kuTmeB9IBrNquBGZgEAoqnGMTi2dZwPhrfdca
j2jvVxrcUkIR95/NrAS3FchRJmJNlg1yq3u+Vtro+/b/lsvxThT9sYgowsUDA4Sk
fDqeK6A8OK5WkzHyDDxFLmQQG4AC1a7Rl1BlwGJW8RSsWO+UJ4VcFvtmKDuOgLvt
I+O91imz
=amKo
-----END PGP SIGNATURE-----

--ZSfaC3nGqLOtAzN6--
