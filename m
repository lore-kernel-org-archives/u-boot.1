Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D11ECA5FD9
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 14:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D7E2607D6;
	Thu,  1 Oct 2026 14:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJG7ih5rdLpG; Thu,  1 Oct 2026 14:12:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4919F6081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790863943;
	b=gAXJbqvi7XuEo3freTYa01+phRiZOJVWXLAytZFa9CwV2wLXQuL+LhCcxiGP6tULqfiA
	 bVNuJ4eNwF+HgjEWfGReohZ6EqtwNLODE9YtvM6LmhR5AWT8gQTEv48bfXlI0QNula3B2
	 qphwRDSMKPBl6rw/Iyxld+8lBUJcMpoNGagRzNvw+sLnqQFEIBx31OD3SOvtCaXtV3za+
	 8c6tGXTzMR52575G7/BfIjs605ArG6J1FIOOu6AcwgntDGE4d3l9aZ1J+7CkF2GP0SeuQ
	 kTOVTgVmjeJjINoHyICl9UaPq2W3miNNcnwlEzLG/DjtfM+s88a7VoWIqoUdbLPaK5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790863943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7Y3bvx5NFT2Ffjf/BmZLhMLT7MHd3Zszlmum4+6mBmw=;
	b=qpsfiqF9jrkuEb4x9tZ8H3Gs3PoVqT5cLy6VTM8rVA+RVGJRfrGx8F8uZweKJHhb/uaQ
	 cMxjOAq/diXKZHirA4E8907RF/b05PQj14bd0sRdcdNiX2OyCjdCgPQ6HP2+TumyGavw6
	 u/mg82UYOIlZu8EKanZE6SvSUZnbQ93MXJtdUtgtDQ7zJ+GUU+av/IXUmBYxwbgNUtO7z
	 kOydDb2FeYryREYmkccFsYLzGLKxKeSYM0pczXgm+zUjyYwoXTcSb49zNAWYegq4CHQoI
	 5+VgRXhvuTbu+Eh/NHL959vkEHqa2qczOrmhAgAROpaePFZMvcfPfDeLDHPBjHhYr5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790863943;
	bh=7Y3bvx5NFT2Ffjf/BmZLhMLT7MHd3Zszlmum4+6mBmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vQF/5/QPjefM5JDsu7bOWJQgABUHEzI4oN63l0k/vxsnt0kR1w1z/YMBGut0eOJXW
	 NH1741ilLmOoe/xSwpbhPLZeXBg3P4poXDlY4vJVUVgAhvmu/n08dkH+SjF8mzEBWr
	 ITDRbl/98NPdQXX+0t37LP9lN0NEf5F3dODMxEb0HKceqCpmL3d930r3/m6vteIyNQ
	 Uf8esdu8+7oY6W3kT+q+/HnYgPQMiqkJot5ZK4L2VRk28rua2O8tYIID/tcsucK9TP
	 HjP6pKkryQ5EAmH2I1rh3tTa8EiFo27KcNaAsNkFyfx3iUSNk94XnPGHogFJD0/8yT
	 5Vym22T6/ONUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4919F6081D;
	Thu,  1 Oct 2026 14:12:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4640832A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37B384056E
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:12:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-aPpkSmZzec for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 14:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6C21340383
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790863940;
 b=mPkxN6fm0sObUK9UNZvLx0iCr6qJgI2vcVSEneXBvo8zn+5H+nnpXmW03lWYHqdftvVZ
 UavngqLdK5z2E2aliAQQ7cslGvfwWFOn2DXBhVPvlrAuyNC7J0gnKjRGyA81zQwo4n92E
 K4SNtnuWIyUzXWsz6slXh0dBdt41n7lRahTqUrWr+0xIERX/eLEjIWzX1QT8n2w5lN423
 LD0EoQ6uEEs6CVUq2IhBMUJMGmpnCi0VAFyyBmmSk0ldOZTECYkfakqH/2bwuxCQqYD3m
 wXYYThrT01O6VIgnw9aOtiR/PPdMA1b+TT6xlxC9tb3+bRRVXkxSObjE6EgISurMrSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790863940;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=7Y3bvx5NFT2Ffjf/BmZLhMLT7MHd3Zszlmum4+6mBmw=;
 b=DC9wvlHMNzhbeODmOwTyM/0mNBwycW/QWH9m/Byw9mc7uA8ZN/MAQvPH2sHl5bTKX7uL
 oNy/0QdEqR6y+uU/rdFtdE39Ig8CoirDdV22RGd923MSEKKPY+QvZ+WVoFmngyySyvEzu
 bda58ZNgdBd1eB22s7BMhzf6Kzuj2X4nUaYB9ynq3DhAwh3hAuNgPJ840gOCJYuxfW+OH
 UJ8BpYSJbX66TagL/VZRZxkhheKmJFYlwtzRo4C11AzurA6zLEGNtnapon40lw/7mgqWs
 hZNFLouszO0jRM4zQJ3I2/c+grlnytjnuaiVGuulLxQM1TE+Wfpqy+l8OHrIxf6JcZw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Qtr+fom6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::d;
 helo=mail-oi2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Qtr+fom6
Received: from mail-oi2-x0d.google.com (mail-oi2-x0d.google.com
 [IPv6:2607:f8b0:4864:32::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C21340383
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 14:12:19 +0000 (UTC)
Received: by mail-oi2-x0d.google.com with SMTP id
 5614622812f47-4f24fa1585eso746537b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790863939; x=1791468739;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7Y3bvx5NFT2Ffjf/BmZLhMLT7MHd3Zszlmum4+6mBmw=;
 b=Qtr+fom6zVM/HhKUCzf3ktbegRGf49fSKxxEQDcmXCWruXhyq0jU45vO18h+uig7VZ
 45dstRfCweGpKBX7o/emZd1o2to+YFitK54P1Qu5k+mFka/Z3nIJ29ZwvgtZqu/rxju2
 Fh19HKkBEVmmZsBadu23ycCZESaELpd8jJbvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790863939; x=1791468739;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Y3bvx5NFT2Ffjf/BmZLhMLT7MHd3Zszlmum4+6mBmw=;
 b=t4r2NvpQtcfKSqpV0aEY9moTXgkSNA0yLWnZmUM4jJ+eVscIEFaedWG+I84+yGNm34
 ze2wdqXsyHBMiT5KvAygA8egNMzuCEQs63ssrgn78GNA8bxdH77fL4PD+gG9uDj0zUp8
 HS9tIOflaPR7TXpcbKc5SeA+DVywdPVKK+3s8+JQS+ru76sSV9+Khy6M7ZOQMd+J0cs2
 tfYrnRV+cyoV0GQGxpkNhytOQ4Sh6O7vApIS7g1SjuC6GLXSl2eC+8XFzo8YzGFhUqRm
 h8fdvbz4i2/D3uEJQPIKyStY9s3O3/BhBb/PnJqGLy7TS09T4+2O2VGKT5S0qswxCZiJ
 OCbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlVNpx7kNPELAByTQGAUedPMeOyox/sJ7eylkis+ITYzaGmdJy3yIco57qDagL/UPsknmdZxU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lct08wPdGZGr34/EpoG6cAIUAaw3hGPAGZc/cDL3rnGyiJTqR2
 mVqpce8urIuclP3jf8xbQywIvB8nF94rdt+AXb8ez/YyjmuecpaFpEGclZXFxbXveN0=
X-Gm-Gg: AYBFou20++MUimGLMiIgdBjXf3EjNsSt1/k/8y1JCKCldOrJuw8aDOaTyN6r3YHDIfl
 MzeF/AOMVFB5+7jFQkdmfYR3qTzctJtPIag0oOG7XekSpJIGdeNr+L/BCuzmXpbsnQxwJxL0eqX
 Z8t8VpvF+RS9X1rkPAG2cqJKkMyaSmERKcSUhmq3uEoEjqmfsS8+lFP//d2TbrBUBbnya+Vou6b
 KA4/67Mx3TFz8R8nu6KrfXAQeGbZV/San7iEl+Rtgj1o2M3iM82/x2xTgGHcwI9rIV6qFpQG5Fg
 HOG47oufEkXbgFb1sGAR/wkvUl2Xhzk1D/2DeKYVbCvvfpEhJaDcn4DVtFlKDMhrbzHA1cIPTsI
 2Jj1eLVyE5Mdvj9WEzgIN2rg7m5EvCVTqW7Zo0k+R/AhUd1bjzdi8rL85IUNhFa/dEmFz8M50dZ
 sBfXllDEdzzbevnYl4YvZPyKOhrHWgBwCzsNEYJcdjpEyEI48cJA0IYVTHtn3Q9dkasoOQ19SwF
 xmVRQYRkWG9t8JvhLLY9r8yVovjIZ2fwaFn+KldzXyl4K1FK77TZPFaUFB609zmEGu0lG6mmEEz
 PjJpaCvWql97S387iDY=
X-Received: by 2002:a05:6808:17a3:b0:4d6:9412:45c6 with SMTP id
 5614622812f47-4f1b8b99b6fmr5085258b6e.66.1790863938641; 
 Thu, 01 Oct 2026 07:12:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f345b14325sm2379300b6e.1.2026.10.01.07.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:12:17 -0700 (PDT)
Date: Thu, 1 Oct 2026 08:12:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board_f: fix use of uninitialized variable in initf_upl()
Message-ID: <20261001141216.GM858934@bill-the-cat>
References: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
 <20260915184953.GA909517@bill-the-cat>
 <CAFLszTgwv8dDCbgfWHBhToR=e6NHW2FD5Lk7t1xbSte_4fdUBw@mail.gmail.com>
 <20260929004919.GA858934@bill-the-cat>
 <CAFLszTgZ+Z2LbgxqAV9OCM8vatC1SB6Rc1=ex__eC5VzgU-Zxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rO39yaDWK4nTgwH1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgZ+Z2LbgxqAV9OCM8vatC1SB6Rc1=ex__eC5VzgU-Zxw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--rO39yaDWK4nTgwH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 02:30:12AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Sept 2026 at 01:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Sep 28, 2026 at 08:39:37AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 15 Sept 2026 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Sep 01, 2026 at 03:50:35PM +0530, Naveen Kumar Chaudhary wr=
ote:
> > > > > If the malloc() for the UPL handoff structure failed, ret was che=
cked
> > > > > while still uninitialized, leading to undefined behavior: either =
a bogus
> > > > > error code was returned or, if ret happened to be zero, gd_set_up=
l() was
> > > > > called with a NULL pointer. Bail out with -ENOMEM on allocation f=
ailure
> > > > > and only read ret after upl_read_handoff() has set it.
> > > > >
> > > > > Fixes: 0fc406ab20e ("upl: Plumb in universal payload to the init =
process")
> > > > > Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> > > >
> > > > I've seen this a few times, I'm curious why you have 11 chars of the
> > > > sha1 for the Fixes tag, and not 12?
> > >
> > > I probably copy it from the short log, which currently uses 11 -
> > > sometimes I forget to look it up and add the extra digit...
> >
> > Why would the short log be 11 and not 12? That's what the kernel (and
> > us...) moved to from 8 forever ago. But also, that was a question to
> > Naveen...
>=20
> For myself, I am not sure of the mechanism, I thought it was
> automatic. I only see 11 chars in the short log.

That's so strange. The default value for core.abbrev is 12 (just
checked).

--=20
Tom

--rO39yaDWK4nTgwH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar5qPwAKCRAr4qD1Cr/k
CnweAQCYTGn/6KdhusPFAytaL0cfvkje/Iu8y0KZamLJVdftyAD/dxzpxi9GIwYC
NVn1f3c7W7sYOEpwLdptOwBBhI0ekQU=
=n4sV
-----END PGP SIGNATURE-----

--rO39yaDWK4nTgwH1--
