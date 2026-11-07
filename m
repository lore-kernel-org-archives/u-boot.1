Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E11606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0TMyex2u;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=fP6vaxtm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1C678138E;
	Sat,  7 Nov 2026 14:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9aXpvOcNM36v; Sat,  7 Nov 2026 14:24:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFF6F81327
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061490;
	b=mGLrnpRpSEzZ4qDUOsR4IcP7rCTVT2sXE0hXJdnVbslyBEoVnV0SWCD6rjKdbcEKGltU
	 sLyNzCjbRhNNp/8wowBN8zPyYArgFZEgl9Pwwdnn5xh43N+PyzuDCzYnolTyHnzaizQXj
	 aY6/5qY7yUJAl27wyrAvepEXwKKRVa2VL+b2i1XKcCj8K2mtn0huWQvWoDSfniUWfaWOr
	 ww5H/fA60iPHAPA5ByDWQV0BcYioKfrBtBd/8BOxpe7LNWa+IyBtNGRI0Wv89YoOOltO7
	 o3ybaycp7YyHTD9FccQlHAIUmm+AnR8QocsQlLTOQXJFFjulF3wEno45mhwK9F9LAUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061490;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=q7Z2NHnZVQqBRUdBXtrthBvH5Piyg/2CYr+jSuhtxn8=;
	b=LWcrfu98lsOKn5XXNHcsjpCw7iUp98NOHCNzoU3kYY/MkLcISsf9V2qKQgpc9HekKiGO
	 KJYEeGu1Rgdpzb4jELCW/hE1UFlF7MP6zpurQWrLaHTjmdqaSpRrJ96m7dv5S98rUDuf8
	 LyaBQ8j08kbQxS+I9NBBX0nahin6/jDj4lAPFWaxefQwp7hzw0oo8PKt0IDtl0TMxp3tQ
	 ZiIWcjacmB2s5N+2LfM/HsgvWvJlQoxzVFe/1/YZktzoJOdrAKFJb3CzrvIvu1Uev2oVs
	 j4CzY2Jt3OysivL0ET/6Bp11UWU+49sBw9qnsqi3c8CZL8v56Oz/cdlE2vM/YH9U0zA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061489;
	bh=q7Z2NHnZVQqBRUdBXtrthBvH5Piyg/2CYr+jSuhtxn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0TMyex2uE+rf8p4PBoo/86+vlxv/+d9bJKAkAAIK+Qse0Uly84b4NNTNAD/320cUZ
	 HQzN1oH+1nftu3va6aNSbfdv+JXnApWwqEt35yvKCLI0PkDZ5zLGqisLqZ8YB7ryWS
	 z5WkRkARyQIcmP/7HHXdVUJ2UgszdVgWIHUBpg257Gg+GWsIa6B98ZbOjj9PyyW5i+
	 1RQoEX4FK44LCjNvF+DMaD28wqciSuQCMGQb6FeerMuZtJ/1bGZbAoWoDpIP5H/BPg
	 C0+lGyosjQpOK1JMRKPHzSmD3zG/pYrM8MkRl7WueKsV5u4y3+r6BpIppsISYmkpuc
	 nnaTQ/cDAnTXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFF6F81327;
	Sat,  7 Nov 2026 14:24:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CCD4634D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE05240761
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:24:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXhsdhlqPHMa for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:24:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 729634074C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=fP6vaxtm
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 729634074C
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:24:47 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67c24619b19so960755d50.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061486; x=1794666286;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q7Z2NHnZVQqBRUdBXtrthBvH5Piyg/2CYr+jSuhtxn8=;
 b=fP6vaxtmEEHlUXQEFHU+1+N3kfSecfm3mO8JfOly1wPgBRUOBKcVEb9uFA4irQD+ov
 /FW+8FYfPWcYkJ+3sd+VpHqWYyfxnKHv5MywwT5evX5Yx52LAfSg8XoLw9GESm401zSL
 QPLt2mk+y0pEX2K9f644JtNqTUsdzwP7CdIo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061486; x=1794666286;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q7Z2NHnZVQqBRUdBXtrthBvH5Piyg/2CYr+jSuhtxn8=;
 b=eJDx3+yQxNHFa/weS0rACxwgCmkjMa5fgWn+CG62r3EkmMidM/quMf219HnwDir1rq
 mArIvXjcmagRyYxpwIbQoMy/VO9EUEnbaxE8Lz5IiS1jbj1fCjUytXn5RXyatVZARFow
 TzmmOFtgus9EmTNzHHgME7DC7+doL3cQE99jYJp1jTnGQBxaYJZhSGEL3SWi6A9AeH7p
 hbNAGVxhP6qCkGqolAbv9FavY9lwVzcVlcXa+7UR4JcWyZR29y4iwfj9hifisF9A+q1L
 v2fTW2yLECg3nzipMMfMPY3AZBkaQaGJ9vaKWbnf6oYpGdvDoIxxESOCe/kngZvnfffq
 dE9g==
X-Forwarded-Encrypted: i=1;
 AL+hErGI7mylO/jgvaxI8XXENVbAMpjsN6UlTfD9PUS2Lc+s3DsGW3po7mR59yyNcaodZ+YVUpC7eBY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/DqWkyhUVINtXOOjsDqsPd9JadsGjfBfyof9Bx+J+F8sz5UcSq
 z+Ngl9SAkHLoQOUwYtjr+KDtid2ih/aRIFMeFT0cwhAYgDpUsv2WndkAQRwpIee4xiD2IOy1RiT
 Cw948YWpXbyXUZGLer8xQ9CpHqLKF9AwaiQou+WkJfQ==
X-Gm-Gg: AYBFou2t3BdsuQ/bdQAFetDD9rxZ967lzVwOUi6XLb/hpwsdxNal/5l/0lqf9nBN597
 2Hn67LFKptsTs3b5ZnEBIEloqtbdzFZ+NkHB7bgOaegHPRuiI2A89AhXq6ul5isRTNPeV3PIzBj
 7Vwqqd3GtOOHkuidxsqmTWsMIQUArjyYghuOqhi2aamHVkfx6w2HAL8Mlacc4qFgnsjCZZ5b7+w
 8FWkJ52RUd/FciNxthtGSEtAr/Ro4CVdIeZ/tE09tKaC99oAYX0OcAZStE1dNaqG9lRhn1oI5BF
 BnudtD1ivsl+rQstAhI4yOWmNs/58lqEIXgqpK83WTY1pRC6lhUOw16g6hWoY5zKmdNU5MLRlEk
 4mBoAk/VlQTPAUnmx/uP3mVe4M+E/PeBnhm3XJ+eoWlYhiwbe1s6AOQziEGS8rQHQeCf4D39bGR
 rx+26vxB9Cfao=
X-Received: by 2002:a05:690e:16a0:b0:679:1517:497a with SMTP id
 956f58d0204a3-67c1469e711mr3411760d50.108.1794061485899; Sat, 07 Nov 2026
 06:24:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104085036.4012238-21-dario.binacchi@amarulasolutions.com>
 <99888b6a-90b6-416a-bce2-b5e83d36de0e@foss.st.com>
In-Reply-To: <99888b6a-90b6-416a-bce2-b5e83d36de0e@foss.st.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 7 Nov 2026 15:24:34 +0100
X-Gm-Features: AclHuK_K8AWblRNFxzR2R9eA2Z053TD30p9UcuMpaUUKf4lXgWSc_npmh0mTFZ8
Message-ID: <CABGWkvqjUDr0=wgAOznX6=XgYV3BcE1PCGqxexxkL2+9L3NWYA@mail.gmail.com>
Subject: Re: [PATCH 20/33] clk: stm32: propagate rate changes to the parent
 clock
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Lukasz Majewski <lukma@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Patrice,

On Fri, Nov 6, 2026 at 5:46=E2=80=AFPM Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 11/4/26 09:49, Dario Binacchi wrote:
> > Since commit 901e0d95df3b ("clk: stm32: fix clock counter"), the
> > set_rate operation of the clock is called directly, so the
> > CLK_SET_RATE_PARENT flag is ignored and the rate of a clock relying on
> > its parent, like the STM32MP25 LTDC kernel clock, can't be set anymore:
> >
> >   stm32_display display-controller@48010000: fail to set pixel clock 27=
000000 hz, ret=3D-38
> >
> > Use clk_set_rate() again, which walks up the parents having
> > CLK_SET_RATE_PARENT set. Unlike clk_enable(), it doesn't update any
> > counter, so the issue fixed by that commit is not reintroduced.
> >
> > Fixes: 901e0d95df3b ("clk: stm32: fix clock counter")
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >  drivers/clk/stm32/clk-stm32-core.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk=
-stm32-core.c
> > index cd6bdee5412f..f9a0ba2f5748 100644
> > --- a/drivers/clk/stm32/clk-stm32-core.c
> > +++ b/drivers/clk/stm32/clk-stm32-core.c
> > @@ -168,17 +168,12 @@ static ulong stm32_clk_get_rate(struct clk *clk)
> >
> >  static ulong stm32_clk_set_rate(struct clk *clk, unsigned long clk_rat=
e)
> >  {
> > -     const struct clk_ops *ops;
> >       struct clk *c =3D NULL;
> >
> >       if (!clk->id || clk_get_by_id(clk->id, &c))
> >               return -ENOENT;
> >
> > -     ops =3D clk_dev_ops(c->dev);
> > -     if (!ops->set_rate)
> > -             return -ENOSYS;
> > -
> > -     return ops->set_rate(c, clk_rate);
> > +     return clk_set_rate(c, clk_rate);
> >  }
> >
> >  const struct clk_ops stm32_clk_ops =3D {
>
> Hi Dario
>
> This patch is coming from ST downstream tree :
> https://github.com/STMicroelectronics/u-boot/commit/804e2d5f7b376703a465e=
1a9a81b5d7db7adfd01
>
> Please, keep original Signed-off-by: Gabriel Fernandez <gabriel.fernandez=
@foss.st.com>

Thanks for pointing it out. In v2 I will send Gabriel's patch, keeping
him as the author with his
Signed-off-by, and adding the Fixes tag.

Thanks and regards,
Dario

>
> Thanks
> Patrice



--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
