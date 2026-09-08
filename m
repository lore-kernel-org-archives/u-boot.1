Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AD7C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 21:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87B3D60703;
	Tue,  8 Sep 2026 21:24:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UhdXhsv_W72Q; Tue,  8 Sep 2026 21:24:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 96B8460715
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788902665;
	b=XF4Kq0Acn8TV3fMbfVDHH92hYVFE2F6zEqzYeSkVeuYmZeXdIa8wmSY0XgMuXGiVbKri
	 emiQeWXXdvKWm8LJhRSAJo7zWpCVQ7oy3Yl5wT1uGQhA8lXklH+R5h3SxvR6AJK/fR8zI
	 jod4xZqWaVnIJSqIhHp9xrpAXD1zU6LYiUdsivwRVU2M/TIW2rz3Pv34XvY/iqWHpwJWo
	 BNLqNqiOb+fvm67H+JmA/snVLByEAdHyLpAmktaivY1LiAB4ebr0XdXQ9Iyq1kAKLkGMV
	 1H6Qlxr9T/j8KwU42qKtLjhW4y+P30Qh83lkTYwnflprW76/1xj6cyGeBLUf2FDx4tQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788902665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7C/V8wOt5iT83mm9a2dED9/e6vuoxAw/zzFf9doGtqA=;
	b=pRWD8RRY5p4xHN3v8WumbwKxwFXLzsA9s22DTAAFA/Ffv1JWEPhN1sGJ2mbZMJhhWbOP
	 /HDvsCW94PJj9Ied8zlMk8nxspBLTbOz1xPzt+MclqLfLoVeNGl3b1ZtyMwW5298Qt6AB
	 f5aYCdzXtX2t7MLFhFN/Vn3C/Z70be1XEucd4iYr+PQ+sRSItclALrx+BgZk5sVjDN3lc
	 4FV0bjOJW7uiiiFLTqCUet2g357QLtPtAw4kF9ApXM5UBQDBO+zVcCal1W9o12DEirPg/
	 XPGVUWJx83pLcO0GVEj+zJhsAlpsen0GkrM+soSieRco9TM4pR6BdOYGsKVoFkwL4gg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788902665;
	bh=7C/V8wOt5iT83mm9a2dED9/e6vuoxAw/zzFf9doGtqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nb2OH4JP1KULgnucZdjQZOjpfWE+ESFURyVhK8EnNRwJ6uEcY0mAhANRitsE6EpH6
	 Hrg9XaN6hvhleOBI1pq9Fug7v6auyf1vyHCzAtp8+ml8TN92z/nNKkA/wij0UVDl0c
	 bFpV5c7oy3rhtxzVh75H2LP8Hn9tKlnTiFT0mh4Tuw/P7F/Jir4mdtmiV8ZdWKpXuW
	 S6afVBTDk/Yc0oZEfTYEcNtk3aHuLgg6CRXA0BPPodzluW5aCFC4TsRplxI9ViAk3b
	 BHFn2SDv66R9NduUeU/z809zAUg3aOIRi58RDkL7M51wvlmNwdlu85yryuZCrKQesR
	 xhzUNQuF9v4dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96B8460715;
	Tue,  8 Sep 2026 21:24:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F519769
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 21:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20EFD40659
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 21:24:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBEb1OO5ZLje for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 21:24:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 55BF240651
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788902663;
 b=auM1FOHJbCizIih1eyN0KvlO9iWoZ+mX/7Kf77HtcVv9cdC2Q5zT1ZpVaEnBEg1iz+/4
 kGMfGOzkTcZL9c5+GDJ5hoYzWEQKSzW9zrqVUnenWOAhn5L669ZwbcYQrF2kp/L+l8tyh
 dHLppUna3A0uf79tN6jyiAERMeQrQSA8pm6+Y2mFl4uE1TG9EkELhUVRrevJMkn1zCa8f
 yl/ovw6y91mIPFZk+Mv2e8F9f/dztm2yAcfISBRL/fll3+FOPVOzwklwqaEQMYeMqceBL
 51ZEDptTmI+MahBOMGrpkj0z+Mk+yFT2GAVdcla2+GWcl5XC2sLBoTmhKO7UOQxvXpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788902663;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=7C/V8wOt5iT83mm9a2dED9/e6vuoxAw/zzFf9doGtqA=;
 b=LaCD+IKxMt4WBnsRAO8CWsuT6sDOX4VQtQBrpFXbqvlxL4LsJbq700zgxRUKDsiNpc6E
 b27VOoOqNOtl/1fvJTJeyp2jzK4YTmO1qE0BdPjWUnzOQHSb7jdimQVgvJY/y5pYspARK
 BGCMSzAGdGMoQC/ePtdQOmJ70F4ljGgM7vbifmEzzgCozMvs3Q9vdarOvJH+f42g4MZc5
 b7Pv/UVJ/LA+hzHm8wSY8A37p8tP00aD6jVf01gfACR4n0oJiX+ZUR80zfDsvWvRZU2an
 eDsEY9IMCt8jsnsFun2q48HDbXMYFSRL7i74WqnU/N7uqeHMtmh8eEhRtF3cSb6Hu3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nlrMSBk2; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nlrMSBk2
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55BF240651
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 21:24:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B29154055B;
 Tue,  8 Sep 2026 21:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D9F1F00A3A;
 Tue,  8 Sep 2026 21:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788902661;
 bh=7C/V8wOt5iT83mm9a2dED9/e6vuoxAw/zzFf9doGtqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nlrMSBk2cym2+1jCM044UJvJzUiwNCoDPIk9Rum7nSG5HM9awrWz4iYUuKvanhuZp
 DEbr7G+Zlknl40ISCiMK07ZA8Ao+p/2gzL0vCns+3c6h/Bm7OuhCOVlTUyBFORJv3K
 SBX7hhkTL2Vn4FlGibXF/E5MuQQ3++fgv56u3YnSCnN+hzSrrU8clJo8y7m52vOnfS
 R+kbzRLbGVOAsQnqOEpKbgjuJQTDz682cZrJZn3YpIb88otZOFf1+OvpdXFXf0gZki
 GVph7ta3ur1kRCfzUXzMXtUy9H2XbkCDcSTe5K2q1TWxrYUmEEPsobp52CQJYn/Sjm
 K/6a2ddL5IF9g==
Date: Tue, 8 Sep 2026 21:24:19 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v12 2/7] mmc: k1: add sdhci platform driver
Message-ID: <20260908212419-GKF2330@kernel.org>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
 <20260906-m4-v12-2-89eb5a8f879d@riscstar.com>
 <ap52h-_UQz15JRVU@pie>
 <CAH22mJxMXA0gcBUJrqMGymWn-BjrnEOBd-t5rUjnwakrMaZkYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJxMXA0gcBUJrqMGymWn-BjrnEOBd-t5rUjnwakrMaZkYw@mail.gmail.com>
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

Hi Eric,

On 00:27 Tue 08 Sep     , Eric Chung wrote:
> On Mon, Sep 7, 2026 at 4:33 PM Yao Zi <me@ziyao.cc> wrote:
> >
..
> > > --- /dev/null
> > > +++ b/drivers/mmc/spacemit_sdhci.c
> > > @@ -0,0 +1,684 @@
> >
> > ...
> >
> > > +#define SPACEMIT_RX_DLINE_REG                9
> >
> > There's an on-going series containing fixes for SpacemiT MMC controllers
> > in Linux upstream, and I noticed this patch carries same issues for the
> > delay granularity[1] and minimum RX tuning window[2]. Should it be fixed?
> >
> > ...
> >
> > > +static int spacemit_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
> > > +{
> >
> > ...
> >
> > > +     if (max_pass_len < 3) {
> > > +             log_err("Tuning failed: no stable window found\n");
> > > +             return -EIO;
> > > +     }
> >
> > and here.
> >
> > Best regards,
> > Yao Zi
> >
> > [1]: https://lore.kernel.org/spacemit/20260902-07-k3-sdhci-fix-v1-5-b15c5d0f64fd@kernel.org/
> > [2]: https://lore.kernel.org/spacemit/20260902-07-k3-sdhci-fix-v1-6-b15c5d0f64fd@kernel.org/
> 
> OK. I'll include them.

I'm fine if you do this since the patches are quite trivial, but that series is 
mainly targeting for sdio support

-- 
Yixun Lan (dlan)
