Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8478C79FA7
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 16:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C105405BF;
	Mon,  7 Sep 2026 16:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hutdwLdK7CIU; Mon,  7 Sep 2026 16:31:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EF78F40575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788798690;
	b=nG/IuW7aex+Ne33ZlLnZsb6hL6qW/u7iQDQjbwCwF2i6oSVwGyrqZHLz0a+4Kyt9IbMD
	 MALLJVivTTQ4jTYayT0OmESwOKkyVOFlGfP2DS4UlSYeIArw7nff5luG7RKqB6Myz5y7c
	 KlinfWmWvWSfwC7Lh6rDUlEu12hAv5k6YS9pBam0qpd0+K2V50Ze/zLCXLulMl0qeVvp1
	 PVwJ4j43fTSb1enqkv6n3r9UDpo5k/XGjuGM07Tu7pIwlKI+DwOvtnd5jGLmqsoDXngco
	 QHB47POYIzH6YtRU45DWnd4P+SocIC84fADQIH+AWsBmDLQWxiEp2kJvYzsx33Xspwg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788798690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gUpbeFVlGiihXboCVNi3lrRI4SloJZEiLmdCIh6gddA=;
	b=bkaEtXsNTEOr7duZ0/qUbD99623B2+mqgbu4XBq6kWREl6Bhy8x8XobUYt6o8scx0u8k
	 51kz93jjJngXP74kwqK1mnQjiQPtX8hGn8B5XLEO2wfjQC5YWr9yG5+v+L9HtFqo7mkcw
	 8PpNT7f+jElNBRmvuMvJkEa5zzoc5FkdS3u7hDUGD98nsdFTUh9kjsHYWb6PeY6+8CEFB
	 NIo+iJ3YSqVDCwS9AilPEIe6kADzVKIxsxTAMND01V2B7vo0LgQAJTex25tf0nCfGMfFn
	 hPWsjGQ9W3+ac9+CxEV7IMIV4PQpLTpWcx4CPtyFGyHBWtFLotl2o4wca+yXB+zA4EA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788798690;
	bh=gUpbeFVlGiihXboCVNi3lrRI4SloJZEiLmdCIh6gddA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ddgpOS1lgeW+LnwxIYSl9NfuhvsUazF1amXoxc722j9R3htns1XOrrQR/tlWMZcdx
	 s9dMav9pHp1RUREm3DY+zHBMUMXJNijW34blu5yoayr7h/GLZjFz9vgvd/2Q10LEXk
	 bbfVjgutcV0tVXpC8fv8M2phm7LGizvCFwpw0sCWDQc9hRUHfSZoEXT48mGFehIyvs
	 dPV/tAFk5UZyuPDM3huKPBaHYM4nV1I/DrZc7zOaeTpTs2n/OCxA5/s2Jn5z+/RPij
	 CfDqw9oMARg5br06Md6PANJSDUAUVilV77gI+8RyG5Bkia5ffHHAT36SdnSY+VRF7B
	 l4rrHijAXbfrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF78F40575;
	Mon,  7 Sep 2026 16:31:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CE9AA48
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 738184007E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAtlNu29iWrK for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 16:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 15DE54005A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788798686;
 b=fenEAg6geZ5hYfDrvjQ8vDWbAgAf/BNrzfDLF+TCRmIfRZLZuMhZq+pqc/mLBH7B7O6r
 B/WTUYvBhIy6tTDJ4AYizFPM5zZHLQGGsLkLdet+eeNF65AjoxxcOybWMgzaaFVahDqJI
 YIY1g8CNo+nQf78ubInq5Nxk2yg5jcvzuiVYYMFs69Hbwq3tz+zZ6QtgFIGYrWL+6WV/h
 lZ1RIR5qxDyg7MjqTArHnOTpd7o89gW9PTpBVjTsik0ZDg5Apx4U42QIIZKS8dW11nzSy
 Lt9uQM93d3Uv65DJSD72alY8Ew1dzRUlEKJEhs8pOcM8wWNFNiPgl5ZSEC/ojh1A9sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788798686;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=gUpbeFVlGiihXboCVNi3lrRI4SloJZEiLmdCIh6gddA=;
 b=SJ3dcX1XvIpkb2pIjRApUaJSkQAMmJe2nRrYoXoAgBU/BYTTxwi6iMx795tWIeijLyqp
 0FnKcMEdAFnJMvO4KBLHr8JQFpCxe/qM3r5NWjWkFYF4CeaGHuhFhaoTY4hCnxizyaUhA
 rje7/yMWh6NfFxFlSGl93SQu7MqI2aquXTPZllLfl3zcyyhAOm85ld3K9EceWWjwjfyqR
 1Xo90zqckAVaLInJPVwI08e2rkddCIP8IcVeoInk6G0B6+oKld1pG6nYy5pX/6iNEuzoP
 Ip+rCgjkXCOXDqOn/QeHILsK1lNap1rv6uAWAddjAQoxdyHrepztRElEJhczTtsrkAA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=lN19mnYt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::12b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12b; helo=mail-lf1-x12b.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=lN19mnYt
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15DE54005A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:31:25 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5b4ae0b3308so2627102e87.3
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 09:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788798683; cv=none;
 d=google.com; s=arc-20260327;
 b=q5ITovw/kaFxpVjoslHKsB7T65/2MzU4jzoH68C1Lm8o6ezMgOZk5nEFKj2k3VX9MP
 mE5/ov2M38pgqwwtlrGLiAdY+3GyXi7okmtD8I3G09zr35tQANYfVr7DhuXd+84+NbAI
 nonzHEy/bj2z2PCnvtYy9CvUw0HQ7DfsNkCsf69X2JVb842ZCL5YRere26np+KGvmLsj
 OqVR/WFxtGdQsb7I9pAG+6scD/8F9OhLqPDdTlV+t39wlK260ReRe88nx3ajTJa+sNVg
 VuQpNldBmbrPsfoYktESoEef+SUDpDDUmdtrHm340JBfd4ODWEm1X3NkfwU7/UJDOgOg
 LnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gUpbeFVlGiihXboCVNi3lrRI4SloJZEiLmdCIh6gddA=;
 fh=XbUK3YtwQ1xf/UYxa6MhB2NWaTNdGmXCUMWd14mLxe0=;
 b=gPoSRGfeV0GONOV4D5MELAea5QO9/67hjre0CAmn1O9BN28hXyZWDH6rjIELk2NdJ/
 rAhEAA17iC3wDAaCB0EwGehN2DMfLKsHYrBa8QHKq27UMwd2ISgjsyogxYndcVLMOAzU
 MFRPsgCW/yKktTN/s/Q//miBzd7tq7AKFgZZxQmbVuwQMRtR1aUT7Rj4kuBzoB6gWn6N
 NVDFvgAtkFJo8ov4NVmSsz9y1h/G18ftF10PH19hwCbvlIEqHMmMqTcHFhU4cF06Tzq2
 GhreGsq5BO48xg9Yynsc8T6PJ0DzOyUJT2cIHy40fezu8yiwz3oW2XLsiPsNHlM8A1Gv
 n/ig==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788798683; x=1789403483;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gUpbeFVlGiihXboCVNi3lrRI4SloJZEiLmdCIh6gddA=;
 b=lN19mnYtDX73eARqSRZbzGnSkKfowda0BqIrbFY4r53oaGXZmsI1vA7Imozv4pWCKT
 YpU85+vrnz/f0qFUcPPjbmrA06npv2qP9Ucsr3WCUYcw5RtIJ7NPnSGtL0LVUiDLqbkW
 iYSh7z3BSYGeJfZN0QxTSPfckFYrTpe8Oh5/H7FJ9B9CyKaGrLJD/DAFAxF9LamWJaA5
 GLDtRWFrxswdFqdgr9sCxciF/Uv05fGxVCIZR0zW44Eq+OfvaAPAe39YaSiO2dHAsu1u
 wpufqGsSBUq//VyTfAmhymCAwdSySzyz5Qw+S2T3K5LaqXwbjoCvo/8Jul7yv9fGuVem
 YSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788798683; x=1789403483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gUpbeFVlGiihXboCVNi3lrRI4SloJZEiLmdCIh6gddA=;
 b=KgpSmdItVty9iNkyrPlNXhATl/cpL1rqUWzGNP3ONJB1mNORsL6hVt/e+KExAu7c39
 usumRsMcoBnQsUFWtz6q/2Bcp3+SDeqx1SaskctW8NqJeI4GIapWIL3/dUDDeGseSoCL
 bopzkJL0rprE6Dj6oysq4lVtogAUXYJUyOfaqAO8Pe50s3FhnW8UdLWgFXVqiT8vJc95
 HHUHlFVh0zqzoE/ShMhxOu1O37QMhtLX2jQUNcZleCyWn8RyLtqAo+gRT87duoD++So9
 I/GE5COEig4je44PXTSMM5zlFqP2k+vnZBz16+fWzy7hAIx4Yn9ke1SMKBqyMXnNpHI/
 iEcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7PQ9kAlJPr9k0jMXhV8aXbj9Kk7zYMsJO6+xwVbXzIGq2OK4ECny6lN2TPRsiJ29NhSCd30k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nCYEqLwN2YCmptMrbBZFeEp9b1h+cjZUaw4/NZLUM/yTX4MuUq
 oAD4rUO43Q+k9qZMOuDDo0fMfIVGgmIc+BStRsiGyAlOhmqzN3ZasiDTmoooDSp/lrj60j+7SiT
 0MJ8rKqo+56wi71dPDCmM+bceOGZ2WPUSWjZcT6MUeA==
X-Gm-Gg: AYBFou0MVhssET5MHTGjGsWBZ1jAX0attsD7PCfsP0Bn/Q0W0tjGeCajfNLy1EiXzFv
 P1j/fhnd5LJF1zeC9twbRubsOVNn0e5AnqLnF2he+B6v4MJJ2jTeFDFv9pmVCG3uA9o87M5feCI
 gUSHWpdZlfg92GdmaLljeDJtfEhejD60TV+3m+bUvH7m869s3hlx9g9x3zZx0+gn+CNuMAVjPd9
 RTkTaFJeiCFMqbuD6vpqB4nfHGsIYAms/ez8auPwwPqpL+3bo0J0yotZH/axH8ruupByKpE5fG8
 e1DeuKJ3cGpuhMUz6yf3LHfY84sNPf189JasPh9vi742LfBd8vatU0V6qg2cgMCvqybNYvPZy6A
 3dW6UebE1sTiKFeDPj7pgA2VxlV9yxvwlb2cBiaMKYrnGmbswpP3ORIZGsF0KK9IFYdr9V4dA/S
 nHzw==
X-Received: by 2002:a05:6512:a88:b0:5b4:aff2:d4bd with SMTP id
 2adb3069b0e04-5b616f34dffmr4039685e87.16.1788798682510; Mon, 07 Sep 2026
 09:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
 <20260906-m4-v12-6-89eb5a8f879d@riscstar.com>
 <ap560PSIq5GenBe4@pie>
In-Reply-To: <ap560PSIq5GenBe4@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 8 Sep 2026 00:31:10 +0800
X-Gm-Features: AcwNN1VbAnZ2qUl980QfSZffEwQH3AkofcwlCwaLOvMyFu9V_r19HGZadVK8Hek
Message-ID: <CAH22mJzKt2ihLLA22AN56SB3Q7jOpayyzLZrrRLAsN+u=Pz_5w@mail.gmail.com>
Subject: Re: [PATCH v12 6/7] doc: spacemit: flash on K1 SoC based boards
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Alex Elder <elder@riscstar.com>, 
 Andre Heider <a.heider@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>
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

On Mon, Sep 7, 2026 at 4:51=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Sun, Sep 06, 2026 at 05:11:08PM +0800, Eric Chung wrote:
> > Add document on how to flash images into eMMC of K1 SoC based boards.
> >
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> >
> > ---
> > v9:
> > - Add to generate the partition table of SD card.
> > v3:
> > - Add document on how to flash images into SD card.
> > ---
> >  board/spacemit/k1/MAINTAINERS |   2 +-
> >  doc/board/spacemit/index.rst  |   1 +
> >  doc/board/spacemit/k1-mmc.rst | 271 ++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 273 insertions(+), 1 deletion(-)
>
> ...
>
> > diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.=
rst
> > new file mode 100644
> > index 000000000000..0be5d5fa1c39
> > --- /dev/null
> > +++ b/doc/board/spacemit/k1-mmc.rst
>
> ...
>
> > +Chapter 2: SD Card Boot
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +
> > +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This guide explains how to prepare a bootable SD card with Bianbu OS f=
or
> > +SpacemiT K1 based boards and how to replace the U-Boot binary on the S=
D
> > +card with a custom build.
> > +
> > +Prerequisites
> > +~~~~~~~~~~~~~
> > +
> > +- A SpacemiT K1 based development board
> > +- A microSD card (at least 4GB capacity recommended)
> > +- A card reader for your host computer
> > +- A Linux host system (for ``dd``, ``sgdisk``, ``lsblk`` commands)
> > +- The Bianbu release package from
> > +  <https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-=
Minimal-K1-V2.3.3-20260128183217.zip>
> > +- A custom ``FSBL.bin`` and ``u-boot.itb`` file to be written to the U=
-Boot
> > +  partition
> > +
> > +Prepare the SD Card & the image
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +**1. Obtain the release images**
> > +
> > +Unpack the release package to get the image files. Replace the ``FSBL.=
bin``
> > +and ``u-boot.itb`` with your custom builds.
> > +
> > +**2. Identify the SD card device**
> > +
> > +Insert the microSD card into your card reader, then run:
> > +
> > +.. code-block:: console
> > +
> > +   $ lsblk
> > +
> > +Compare the output before and after inserting the card to identify
> > +the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``=
,
> > +or ``/dev/mmcblk0``.
> > +
> > +**3. Write the image to the SD card**
> > +
> > +Run ``sgdisk`` to generate the partition table, then use ``dd`` to wri=
te
> > +the images to the corresponding partitions.
> > +
> > +.. code-block:: console
> > +
> > +    $sudo sgdisk -o /dev/sdb
> > +    $sudo sgdisk -a 128 \
> > +        -n 1:256:767 -t 1:8300 \
> > +        -n 2:768:895 -t 2:8300 \
> > +        -n 3:2048:4095 -t 3:8300 \
> > +        -n 4:4096:8191 -t 4:8300 \
> > +        -n 5:8192:532479 -t 5:8300 \
> > +        -n 6:532480:4726783 -t 6:8300 \
> > +        /dev/sdb
> > +    $sudo dd if=3DFSBL.bin of=3D/dev/sdb1 bs=3D512 seek=3D0 status=3Dp=
rogress
> > +    $sudo dd if=3Denv.bin of=3D/dev/sdb2 bs=3D512 seek=3D0 status=3Dpr=
ogress
> > +    $sudo dd if=3Dfw_dynamic.itb of=3D/dev/sdb3 bs=3D512 seek=3D0 stat=
us=3Dprogress
> > +    $sudo dd if=3Du-boot.itb of=3D/dev/sdb4 bs=3D512 seek=3D0 status=
=3Dprogress
> > +    $sudo dd if=3Dbootfs.img of=3D/dev/sdb5 bs=3D1M status=3Dprogress
> > +    $sudo dd if=3Drootfs.ext4 of=3D/dev/sdb6 bs=3D1M status=3Dprogress
>
> The bootfs/rootfs part aren't U-Boot-related stuff, so please omit them
> from this documentation to keep it simplified.
>
> Then the only binary we need to extract from the "SpacemiT release
> package" is env.bin and fw_dynamic.bin.
>
> For env.bin, I think this U-Boot port depends on no specific environment
> setttings? If no, please omit it, too; otherwise please provide a .env
> file in upstream U-Boot tree, and make it the default environment to
> use.

OK. I can drop these binaries.

>
> For fw_dynamic.bin, I think SpacemiT K1 support has been landed in the
> upstream OpenSBI tree? Please check if it works with upstream U-Boot.
> If no, please try fixing it, and then it's okay to stick to the
> downstream OpenSBI, but you need providing a guidance to build it from
> source if possible.

The patch set is for MMC/SD. OpenSBI is another topic that does not
belong to u-boot either. They should not be mixed together.

I prefer to address one topic per patch set.

>
> Then you could fully omit the step of downloading the "SpacemiT release
> package".
>
> > +The SD card is now ready as a bootable system disk.
> > +
> > +Understanding the SD Card Partition Layout
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The role of each partition:
> > +
> > ++----------+----------+------------------------------------+
> > +| Partition| Size     | Purpose                            |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| ``sdb1`` | 256 KB   | FSBL (First Stage Bootloader)      |
> > ++----------+----------+------------------------------------+
> > +| ``sdb2`` | 64 KB    | ENV                                |
> > ++----------+----------+------------------------------------+
> > +| ``sdb3`` | 1 MB     | OpenSBI                            |
> > ++----------+----------+------------------------------------+
> > +| ``sdb4`` | 2 MB     | U-Boot binary (``u-boot.itb``)     |
> > ++----------+----------+------------------------------------+
> > +| ``sdb5`` | 256 MB   | Boot partition (kernel)            |
> > ++----------+----------+------------------------------------+
> > +| ``sdb6`` | 2 GB     | Root filesystem (ext4)             |
> > ++----------+----------+------------------------------------+
>
> ...
>
> > +- If the board boots successfully, the new device tree or U-Boot image
> > +  is compatible with your hardware.
>
> This sentence looks extra, please drop it.
>
> Best regards,
> Yao Zi
