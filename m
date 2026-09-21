Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CF7C982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F8BF80C81;
	Mon, 21 Sep 2026 20:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yFMo9tmM498d; Mon, 21 Sep 2026 20:22:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5C99380C33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790022142;
	b=lmdM09q/vvdKiwjFiOjh6kQNO2zbMppkYKPGFpKgVDfleMjxTJj5eB2lcrARyr3kIb0t
	 tdF61/wGK4yK5WOYf906AEOp3qkTtcl9/20bWZmS8Fefhkq18m80i3PBpBx6O93g2e4kY
	 x+8hmhIozMsA+y2TZ1+jeyFKi6h920bNbkW0CklTlWbQl9U3BPUNcbkGpoKMuTNF/ag4l
	 L7Ey1O6NRdIvGlmWjm8MmDOJwU/CZCw0VNUETdP/o+ooOIwPiHqAzw3y8Bo1XJwU6X0Jl
	 2CHmcaBWJLAJ/MEbxNRfq9A/OmV8saAgF0Ii9xQGE1DaPvufBRrVjVqxn3SNeErehBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790022142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FZX7lrjFQ6Fp7mJeVpIGR5BdxMM78dRFW6RTlHbfkhU=;
	b=NXfk67BThI1JT8/WsdnLHC1PXsgOib4cdxSeMEC3ZFDAlhJM+Rpp4Tdsc1zguTO1LKIs
	 FjUTU3G+zybWnnZNx4EELKGbzS420ozbeU1jVQj/KlhKRSStyMzFZREMh9kMtIz0gcN7S
	 Egk2tpxbYNcq1WbQ0totwxgyIgNojz+Gvaf9Rx31ka2cu+qd+DzlFjay9WAiujG+lPB48
	 T6rn+CqQ9fq5tY0jOsb4GajjAp1VrB52vdQFTWiDWgDlqFHUBrOwr7rNRRR7IuMTX6W5R
	 prlt9TXFqOOYZ+DrEN02G7JFXDE0HOpGWnk6HaLL346NHBOWdCE4RJw61FsePOUaOQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790022142;
	bh=FZX7lrjFQ6Fp7mJeVpIGR5BdxMM78dRFW6RTlHbfkhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yEZYvUp1ne5HFThfI5IS+Kqn9tcxRCUCpfxcd5ay1lhRkw8R1L/f133up1AB4oTtU
	 rre/rbxxlnkEWZgp0TU+9UEJjMt2dUcK1cLBNLg4gCgdkgJ/ugw0GrPw3zZpGqS2fH
	 Q8IQNqOszxu54YEnSvvXFerV6ZhxxSpe5WlMYsNd3IlO82YV4umE7zEl7ZB3LDUmI4
	 fD94oTCDWcxfuQZoLjxuKcqYdwQlSa5ITx5WHC24jcweXPrc1dW4BfWPLyztUtbZgl
	 DqLG6C/OJbg8x9lL1prU31tBM7IfUMgDJgGkZy04pzrmLixF3yyXVhtWSfjFywki/1
	 y1I2NO0O1t99g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C99380C33;
	Mon, 21 Sep 2026 20:22:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EDEF2D4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54F35400B8
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9co3VrU4wyi for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A1AFC4008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790022139;
 b=pHnleMVN8k/GrJX5/xuZSci6SWtHJq3/nGK9iEpvTYZaz+91gbG6MWxWQU5bN2SX0pR4
 d4J+a16JRKf/JLN6s1TmxBOZoIYHfXMDd9++zE478fELLPPvppKxRWWToDQapYoaG1NSz
 E76VKT4ZSxUIeOTGK8/8i6/mTCEKUD2sq2/9NZSYKo9aFe32WFUgA16yMREUpDjx+YD6i
 apfifpJ9n96DMxrx6nJKmgU4h46qEVx0T7OSm+VFnfugVSUBTivm50lzoRvAu+hkFE85m
 65VKd7IiOQVxy43U1Pu0TZBNaz80APrE173jlRCCmokivAV552L5C2X2VhvTJ2H+AkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790022139;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=FZX7lrjFQ6Fp7mJeVpIGR5BdxMM78dRFW6RTlHbfkhU=;
 b=cxya3S3hDj2zX8vsjGvSSUm45EP4VILsw2IXzWeL6LN0p2JE9R5FlVsAjIXOel4rFTRI
 qKB9gr3poIuM3NPFGRpBN1ddnCSFpuSc9V3pNQYc7NFHtFDjmyfoO0kYgv2ZtOnezFfr6
 pcY1dyB6iV8WOJGxAvQvhtqhn42HtqG/YphKCuOYIWpcBx8zQfzkBmrGO6BzPshhGO8+u
 gzkfEJfS6zbjORF/Htv2HGH1my/8Uw3izrRu0goN/7+yriM4i9woAy6PviPsrlMJZ00zJ
 zqlseSFJMQNIFGGZ7i96t6MBIYOCbmC0EaK+8tEmrItGyi0E8chcOTi/zhsgeSh4WfQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="N/rFlUtf"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N/rFlUtf
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1AFC4008B
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:22:19 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6bcc0c495efso1768099eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790022118; x=1790626918;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FZX7lrjFQ6Fp7mJeVpIGR5BdxMM78dRFW6RTlHbfkhU=;
 b=N/rFlUtfByZcHo4KFQPZ+Cu5k7Az9r4d4pWKz0qEoCwlxNYBfltIicwdt6UjYxqRpP
 3+7jHaqrcbBkyt0O3QeQp8se+6H9uhik6wFNJXcsgjhFe9LQVZ760ooi9P2cj8jSYwgb
 7lWCyXLWAsqAXAJBKWs0dWZ7UH5B2tvaY8nkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790022118; x=1790626918;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FZX7lrjFQ6Fp7mJeVpIGR5BdxMM78dRFW6RTlHbfkhU=;
 b=j44KWV4zZQUlnRyAds+LGVWDHpPHHEmpC3skLK8XiyxZxs4VaYc7tOi/Ab9UrIZ8B6
 cH++jU4yjCqUJ9aamwPn1lUghugjj1UrmVb7MZWrUtVtX85Krkgsoc9MozegI2Qb6Q25
 wvikEGCfUD+zvwgw0ytS6nsQd+ntaxLzmv7JVG+95UgmDLf3miPGVLI0ZzQcMwX9wbzG
 foRAwKzwgTU5U0E1Q0DHOTGoEJi3YmJ055v2VXZoKQERQWECaPpv0iiJ4spX+U+YOHKk
 ggF0IjpNiElwA4wE6IyTu1o/+VEhPQzoGWds32Yv+EWY1NRaz6gI70/8+E7NVXNpuRzF
 D5HA==
X-Gm-Message-State: AFuF++mppTZLTO5hCfrltFSQZqqbMyARANDiOe4Q7G9HkqwhO4w1jKIO
 Rw6uJRU3YJWfQZ9CqHhe3w1VU6ejv0Pr3gfe9W1/V+9xBjq5SSDHIf2tMQLvChLxhfc8EYtf3j4
 5Pvg6kQx6lvyS
X-Gm-Gg: AYBFou2+kM8MjtooTWMtkd6tz33yAXT0hZRvf+rOza++lVLIEUEPNjrsLxwxCT/qZjl
 NPClf4CWQtYZjPUNeo6n30VUuouY3egv8gVy1HdJJlOtvuDixsenHpWa+jCRiZew1Acrc/AEog7
 Ht7qFkCVaTEPFymHrRvsEWTXZ0p8+BW0meTL/lENAh5u4GD7keXjBO22CnfjLoZB9i7oqz6JJTF
 F/dESYrfuY+QdAx66ywumt2HNPbPnkaKIyDZ4RKNGfwwDEQWPI3z8KFUQM9p10ZgTCDUMe2tlin
 CWfbcIk3BfkpSwhOrji2mcsKUOytSxDSechQDot2SMwCJiI1vdZxeMyXhHvTxSHjVEAkJMLWN3h
 +pSLhUkh+XdWEWfNTqYV1AgBHO+dTQ7U3F3oFl18RAGK9+UL7iWXJrumy5hB2w/6tWLCWZghR+x
 BvbaHeQX9T4iyfX/SaIeY0stjTn7kOD3b9eBPhyENWYPWeN6ZSfk1Ode8B0T6hkb64wLPL04WYn
 1rUdYKx7jPpDksslJxT3DoZo2TRbx8/gD/kmE/GLtjZeNSxBPy9SUw6aQkjkqIPfpf+Y1ukyPP9
 qYOXgYEvqwS+Q2+HmDE=
X-Received: by 2002:a05:6820:c93:b0:6cd:3fec:de77 with SMTP id
 006d021491bc7-6cd3fecf39fmr7492814eaf.77.1790022118074; 
 Mon, 21 Sep 2026 13:21:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-814768b6c99sm1142633a34.18.2026.09.21.13.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:21:55 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:21:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: u-boot@lists.u-boot-project.org, Weijie Gao <weijie.gao@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/2] arm: let a defconfig ask for the Linux kernel image
 header
Message-ID: <20260921202152.GB858934@bill-the-cat>
References: <20260920151512.401899-1-f@lex.la>
 <20260921155055.GZ858934@bill-the-cat>
 <20260921191406.3028860-1-f@lex.la>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uQZFHlK63UnLOD6O"
Content-Disposition: inline
In-Reply-To: <20260921191406.3028860-1-f@lex.la>
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


--uQZFHlK63UnLOD6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:14:06PM +0300, Aleksei Sviridkin wrote:

> Dropping 1/2.
>=20
> The board keeping me from the select is downstream: an MT7981 router
> whose U-Boot support lives in OpenWrt as a defconfig and a device
> tree, with no board directory here. I will carry a MediaTek-local
> pair of symbols there instead, one selecting the header and one
> holding the offset base, and leave the generic ones alone.
>=20
> Does 2/2 still stand on its own? It gives mach-mediatek the same
> default TEXT_BASE for LNX_KRNL_IMG_TEXT_OFFSET_BASE that mach-mmp,
> mach-rockchip and mach-apple carry, so a MediaTek board that selects
> the header links without supplying its own. If you would rather every
> board spell out the value, I will drop that one too.

It's unclear to me, so it might be unclear to others, what the use case
you're trying to solve here. These symbols are used for (typically) when
we have some prior stage loader that assumes it's booting the linux
kernel and we need to fake this enough to get loaded ourselves, instead.

--=20
Tom

--uQZFHlK63UnLOD6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarGR3AAKCRAr4qD1Cr/k
ChowAQDezJlp4Pp40a/GSmj7GfzXRx/iAT1KjMffGuVe7GWLLAD/U9MOTmqOVViG
unIRKSppmW06x9JRCEfdp7BsQT3w4AQ=
=aanL
-----END PGP SIGNATURE-----

--uQZFHlK63UnLOD6O--
