Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01694C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9FAD81117;
	Fri, 18 Sep 2026 06:48:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gjewW_CdjpO3; Fri, 18 Sep 2026 06:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F163781163
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789714098;
	b=qHMkS7E8r/12ag9dFaTu5nG5qh1+MUo56LGEZHTtjmUW/BgmnrHUKcnLBImp3rIrdxo6
	 odC6UbiR/kTNu4m7HT+BTahKSJig/TPShXMgX/QL8gWbFr2nWUGu9rSVSoL7pg0vkSjw1
	 e6xuuIN8K94m9qa0tBZr2cUYebxqMLMhD/FkhpxCAg84qWZDC78NNpT4YUZMO6ODtPk24
	 BgeeRNaPLOrbkUopAZQjszD+KoX/JUDclge4ON0t6nnunzXmF2/RwAyyxUJTy/pi0HNM9
	 V92rHwS5W/KlgwohGjxLG+3FjADZT3HVq0GpmpoLTmwCAovMJWDx9J5Do8EI+Iyu+jQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789714098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I5NYvbYN1OjdNraOizDMTKHfk+G68hUwCe/A8oEniqU=;
	b=O9t8iQjU59GaALa763dblxCwuSbMU7VCO/5Rr4HJtC52i3wiVXXNkc+VFVgquz5sQoBJ
	 L0Kupebi3Od6sNN0eH7uHqOmUcWmvvb3QBiA59YItPnwfkuY1fjpp8CkkGPyZedEy3XH8
	 vMVsvTuochkZ1eK2s5KADTPmWmgYnc0ORq8Uwv+UzgMDJ9VQwD2Abv0AFIZMGuK/qgkqp
	 UtIqpAqaPh0ofoxeqY2RdMerJxKi3n8JlOeQYcHB6ULheakSus5HQTJjz+knjwz0vA4wE
	 zHyAUiaUmnsO1ZBteHuUSghx2lKJI6QeIgK1Uju+ql7yAwvSvkjial/zv2gmYcYHkiw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789714098;
	bh=I5NYvbYN1OjdNraOizDMTKHfk+G68hUwCe/A8oEniqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yNXC6qoRU5+1nnSxKmQJTiGlkRkiHgUybjUx5mmXY46ol7szuPiOxOScf192e0Zi/
	 gArWWgMe8tuvj9sPsM2Ls+WJKhyiY1mGmqlY6N21cu52G3SZ6v0NNwmIOz1PRZLYrn
	 2myF/byeyjI9gvoEMDH3cdiAFNptDqhTUgVCUFUCi+x2bwJB6rq1BA7cn1GyeSaM9h
	 Z6cdX66mrmabtm0AO7xuJO3hkWtg2NmgbvkZWo0jA0GdopHDPlHlGG/HSJC0+yyKd9
	 7x1dMFWUvAJcAJ/BjxnZi6nv0OuFy0zTq/8mys+7U6ZXWyzxAIKy53mph8qEmAPVvJ
	 R2bEp1CycpQ5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F163781163;
	Fri, 18 Sep 2026 06:48:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 54D233AF
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43718404CA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rb-8SMLsJdDO for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:48:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 24819400CC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789714095;
 b=TXDP2qT799IFFqcodFDYcykJATH0B/3r33AtwUBtNHyE6g3y+8fDYSrIKyDKXd1KIKI0
 b/AJm1fA5KVQbWquLf8ondfalSBKQNymIgBG2vM8gGCC33MHRnv+fl0p+skEubRB+FrHz
 K1ky1yJ/YqXao7DWzmLY6+wkBVT0BgISQmHCElZ2cIguhWLxjn52JVejFLm+Qxx8Phdqe
 5InRq3tAfOgJAOZjQJCDCC8nH1yn7eOX+s1If0E+1VB4eZWWBEmFoqr2+8+BfT3bRpJot
 ozSPgP0LTwkN0XP46gaOnARgWDB0/2Dol3XryUJrSXhnowJiA3KyZ5axLz/Zc9A6lSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789714095;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=I5NYvbYN1OjdNraOizDMTKHfk+G68hUwCe/A8oEniqU=;
 b=r///QZyE3XGWcpxfIXRCAE9oJnEzbDWfHeSiBnLblxetoEYr9qUwabdEfhvNJGzFXrVm
 ODdXKys+kvnFgAM9JnTh3PwO79+Z4pYbJLsZlzdHv+19g91szfmpQuMjZGQE2ROrL/lAa
 1L1k+4rKAaS8DPpZ3fdLEbzQKNgJXRutGEY/N0eJcfZHgjRqiv1AezGfJvzYwHFrNMhUt
 o8p0Xz4v7CmM1/JR1Hl53w+oFxT5wepKK6HGVlyEilg7i29DIijBGFNqOUoecYp4wGvxd
 gGBEnsmW323BprZMELbhsaJui03g4ldM5r9jHZ0usfGs+qsYZfa0hZqKjgAtmWd8VUA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lTsaA2Tq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lTsaA2Tq
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24819400CC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:48:13 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f55efe5so54551766b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789714092; cv=none;
 d=google.com; s=arc-20260327;
 b=rbaEg12RNDopK3xy2pzLn/02pCa4M3yjbwt1uVrh/EkeUOWuRBaMnkVc91t0R6ZXmS
 K0rlbVnhffiakCaOfBZq3zYZ5MbNtOCCVm6h+PEvcQn6yfil2rFwb/12xlRWsF4sJ4Po
 vo2ATU77hioflVyuXTHbCLucytavaelIBhZUkJY/bzy2Khp6yVdCM9hkFXh5nMRaQf3F
 IthCJAVb5E0kUpuSN3Wmfa5aZeKhCJLptUXiJIxtDiwh6WI9OdtF+qQ6aPWAW1mtqMYb
 BD0aBEc5DlKtrrIvtjmkAQKp2eZAtggRZai8vO75a6++LxNUsrOmGUaAD2tJazey655e
 sK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I5NYvbYN1OjdNraOizDMTKHfk+G68hUwCe/A8oEniqU=;
 fh=WZHfgUaukd1yK7Jm6ESjxS1kgrsDM1WiddstkLrJDUQ=;
 b=SOGNO/AZrgW0v5tfzxNa5BzPupPtHm38ai8tVtc65Nw7Ac3XzN9JAjTfkE2YlUcg+d
 2naSYw57lu23ImZDaS0/lri9LhJ3pBprhA5VUanTdeCBOV/VZNLj/aO8SHgAcoI/UCMR
 qCm+RlPeie2mN5e/g7fXrwcDyskk7670golIEvvvIRkCyj3REYgIZtApqst14JaWa2KC
 eT8Wv8mE2Yd2tlt5GUCub8LzrUQN74xGLZOqvBZHfpKAA12N44CeRzRaWggV7SHAYwOc
 OYVKaBxT/zQI3TmWPi1AsSga7E7AArQce3vfg0j0TiMYWRqoFRk67to2bfkuXgtSjFVw
 KTLA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789714092; x=1790318892;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I5NYvbYN1OjdNraOizDMTKHfk+G68hUwCe/A8oEniqU=;
 b=lTsaA2Tq8ttWMCQUFThZyvMKKY96OJIsFCgiv9qKoMcdb/GL7usRb+BX1eT1XUM0vF
 MP+2cAj272ro1ZK+X4M2W6YxtTCHtJ57Ee5+p5V4QAeTG4FvnBIlQWSmPbdbbfbhtBJP
 1AljJvDNRQbnT4xwCShcMzFTyHwGHVNC3sxse3+IddYACMgiXdjWSXL7xRZAcd007Ds2
 /VpS57q+cmjQu9aMHb4i9qXn/tmvKmUmy/73jbswvW4BOsv09rzk+2QmXd6h3C6Z969w
 kChG0K8Vyv9Bz3nAeQMY5myTdDy8lLK4NC2ng8aPeJEdBNy5rnr+ClR1ihYm3yuEEIjb
 da4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789714092; x=1790318892;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I5NYvbYN1OjdNraOizDMTKHfk+G68hUwCe/A8oEniqU=;
 b=zTHLUSfKgvPG71i6N1oJzsVZmr+boNvp3jX6CNHJM+jjhUgF83BxAMs52mAvGVAeWn
 mrVpHH63Y1+hBZTSEYjQMCZHfzDxPEyvHVNKQNmEexgO1o2CrLGERgnMHn4WPSGPPOW1
 y6CP1mmlkOpleK48ieMrPvCQ0lBkwMnmhnPN+tffJF1moKQ/bF1vSbtWtYJS5WMJv7bR
 tYUCiXO87eV3QUEn7R0JKEfA61pC9oAEXX0s7IMC64KOoSE5FUkJUuAE44a0VJSTwJft
 7Lxqx1dPg6UyebFNxicxHJUlgDXQLzkZDlZjbY44i57sWl6fvn716UO2EdzceOMrajKd
 LCyw==
X-Gm-Message-State: AFuF++knzbx2IKRZ17nGVlEbRTdOfR+fK702REFQVlRn59Q+/RJwYWIo
 FLoCCRG3+e4bt5iIv69PJ/fjwMCW6ZsRg+854VY/dJKTlSdt+bwm/AmV0IMIgFNJfQ9zS6pi3CA
 wDF2/0hjbbwb2BdBrb5/mtGCrYU77IBSSos40J482SA==
X-Gm-Gg: AYBFou0UdWFYL8RK23nqPSqN+rMALLdQg+B48w6I2Ym9dD6d4PKfkBrHzlc1jRtzhcM
 Xh+HZ5nk1/Jm5l44nrevqo9Yi/Eli3QoNur44Kq4tzI4PbuIoAo8C40cdlBBFhQxTe66pHJer6t
 RI23OyI/1KuJCMoXYQffa5YnIkg1G7cMytOXSWuCvzQFNV6t1SXLp8dTTJ1iv8nBeLTydTGhS+o
 FAMJtLqJxn3AQ7NHxcx5WE3E95ttTto1I7OGp2OdyQMV5LpwVwVH0iu6+OxJg1p1klWnSvZoCZp
 CxpiBlRrQ0wRpwpGf/7N1urEN5wn/3AGokS+vkBnqETpoGw45hupItdmiG89/ltiVS8SQEbqICV
 ypEpyr42YkQUb
X-Received: by 2002:a17:907:1c0f:b0:c29:d62b:fcfa with SMTP id
 a640c23a62f3a-c2a156590b7mr160674066b.2.1789714091611; Thu, 17 Sep 2026
 23:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
 <20260917-spl-fit-compression-v1-2-7985ac56ee9e@flipper.net>
 <20260917195225.GK858934@bill-the-cat>
In-Reply-To: <20260917195225.GK858934@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:48:03 +0400
X-Gm-Features: AcwNN1Wb3kzP-mrB2qsXqGgkMNx1wSypYjtsADrSeaXWBeVad_xlaz1zJh8w8js
Message-ID: <CAKTNdwFvQ-JLD_SdYb_J9zj-vNfMUC+zd0Gt0RC33F1_1949sQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] lib: Build xxhash in the SPL phase
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 17, 2026 at 11:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Sep 17, 2026 at 06:02:23PM +0400, Alexey Charkov wrote:
>
> > SPL_ZSTD selects XXHASH, but xxhash.o is built from inside the
> > ifndef CONFIG_XPL_BUILD block, so it never reaches an SPL link. zstd's
> > decompressor calls xxh64_* from code that survives --gc-sections, so
> > today the option only builds because nothing in SPL calls
> > zstd_decompress() and the whole library is discarded. The first caller
> > would fail to link.
> >
> > Give xxhash its own phase symbol and build rule, the way the other
> > compression libraries already have, and note in the SPL_ZSTD help how
> > much heap the decompressor wants, since that is the other thing which
> > may stop it from working.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  lib/Kconfig  | 12 +++++++++++-
> >  lib/Makefile |  3 ++-
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 6b6b90bc915c..6e6df5b3b191 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -833,6 +833,9 @@ config CRC32C
> >  config XXHASH
> >       bool
> >
> > +config SPL_XXHASH
> > +     bool
> > +
> >  endmenu
> >
> >  menu "Compression Support"
> > @@ -1011,10 +1014,17 @@ config TPL_ZLIB
> >  config SPL_ZSTD
> >       bool "Enable Zstandard decompression support in SPL"
> >       depends on SPL
> > -     select XXHASH
> > +     select SPL_XXHASH
> >       help
> >         This enables Zstandard decompression library in the SPL.
> >
> > +       Decompression allocates a 94KB context, and nothing else: the
> > +       single-shot API it uses decompresses straight into the caller's
> > +       buffer and takes its window from there, so the compression leve=
l
> > +       does not change what the SPL heap has to hold.
>
> This is good to explain here.
>
> > With
> > +       SPL_SYS_MALLOC_SIMPLE that memory is never returned, as free() =
does
> > +       nothing there.
>
> This is already noted in the help text for SPL_SYS_MALLOC_SIMPLE so we
> shouldn't repeat ourselves.

Alright, I'll drop this part. The reason for including it was that
multiple entries into the decompression routine will leak that 94KB
context each because free() is a no-op, which may cause issues for
users with tighter heap space. It hasn't been a problem in my testing
on Rockchip, though, as its SPL has the luxury of an MMU enabled and
hundreds of megabytes of guaranteed addressable RAM.

Best regards,
Alexey
