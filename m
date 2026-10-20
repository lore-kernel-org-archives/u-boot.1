Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA6606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ySLCoVxO;
	dkim=pass (2048-bit key, unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=h6MKavVe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30ED2407F5;
	Tue, 20 Oct 2026 17:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hMAqqUmScrTF; Tue, 20 Oct 2026 17:22:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 864BC407F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792516923;
	b=XWcpXK/q7tKqMsck0XrKc5L4Ty/LM2X2Rcc68ndUsTK9F43JUQ+zce7AZG5wRqZFlJXf
	 O0DBcKYTzZ66Gb1InKMfJ6uONfIaROKsQp2dnliKvdld7xrU2ejvjdn/ZGYv9COEWINf+
	 gWdcKa1/P+rDECvnKjDSgKjAm1kE6D8QeZYlg8TmvlY03U00S8GIfV3mow/5W6jS8oHrV
	 RDEsEqC9yY4S72c8VDrrk8J0HSV9hcdMWQWE4dVEBpaMJN7CkI0NCTZcBK6G8BASZREsf
	 JqQjhrBoAo6iyLids+KdccWdy0dBEpEdpLege5cPFzMew+NuA+EFYoPFxmQZZctP1oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792516923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bAFKcUrcQc/HGp/8fQGNiCWVCzD2hMD91j3189gp/wY=;
	b=YJaxXZIwdxfxwp5ABCYProrpriNoXZWdYfWSuUCrdQ0/9m8yS8bIvxAT/kFTGpKDf4R1
	 ETQKJxPB46GXM/KZI0XbgrTtgypqHsq/tZA1P0JcKBxoyjSVhjNwRqxYLdgStDnmERNeM
	 hTbQcK/f0/k4fjX+rYo4cj1hE0ThPOhVVLMSivVO6gT7LCG7xXs0ArWdhmazAPPex+Ay5
	 5l/CCDWi8st7yq/ZfHQdb1s6C3jA9foVttPcVIsuER+AFEcPXw9deV2Q+aVjO8h/63Xw9
	 IPlBixGhMXgenOb1m2phCDGbcNaNNSyHpNTotxyI4tjYQiQMB5nx1e0I3U8cpyqertw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=sigma-star.at;
	dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=h6MKavVe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792516923;
	bh=bAFKcUrcQc/HGp/8fQGNiCWVCzD2hMD91j3189gp/wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ySLCoVxOwbZdGh1n7JCLXov6ceg827aEOLzf9RGsdkci+g4Z7kRxF3wopfdnWOkK3
	 98o+m0uxJr8OVZNMNhl0u/1v1Bll5raFfEs1QQH5Xr7MFRBcpxwhUtjC6DmtJdhc0V
	 W4c2jsqtOHvKVlJV/y1RUGR58wVNILcQSqHc8yXZijcR9V0xEDNK7pfgvRtLrjRhRu
	 wW0vFSZh1ha9PMzbNxckirCNXN0ZC+TSNaKEBGhjUjpp/HrccUBvWxezJ00qY3+uq6
	 2dVc7mfWvVpFP6uXvA07KRRe5H4UGIbiRUB3J8WV+UKSH17ZszYf7JSiQ+SrHPzzFz
	 beNZZ4TtA7j3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 864BC407F9;
	Tue, 20 Oct 2026 17:22:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C31A769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12255407F9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zAdgO_meEIyq for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4FD70407F5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792516921;
 b=B86Too8RurNILI/+PGq4GFsreaLUlUlmdAeOrFydRvZ0dqKRHKM52GELLcTmtOlSseBh
 8nRj/V0CQ0WmH3759UlOABAgmsBaf43+vbn3f0oztliNJcclkT5H+dVkJCzhDq6oDggFU
 7S+dW+CxiuUKn0Pp3nVkpFyj9TRWXWjLSCdZqBUyIKe+xDHSLRyEUwmZ7j8a3V2JM4Q52
 YGbhO7dwSyu212AF3VFuKopuSNCoQNoFxKL4fGSRvTY1hX6Li878s0HphhSqbUcZpctuI
 7Mrx2+76dXM+n1Lqiir7V9rAV2eMc5ApLE1bZ7MRno2PwDI1/jBUQzMQ35A9dso91vA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792516921;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=bAFKcUrcQc/HGp/8fQGNiCWVCzD2hMD91j3189gp/wY=;
 b=DiKmJaTOCiyNgNMiF05uu4bdbvvsrN8wBMbRllaQHHBtazf4O1ZmANVqCGUl/08LkVTa
 pae0wHOePg1aCkxfTgLOu1DpUvZ8AIXNJ5yHX6kkV4gKvWMDT41V5wzZnacF6uDtNHlDZ
 Ku7Ad9abwqcXJH2j4GsgGUsWM7MnPs2T4W8rAQ/ZZxtBlx66NUTpG+/Ki1WT/Ivzm51c6
 C1N8Ny2LxnaTSMOEgQRYrpfQ7toPBEFp2iXcZBn1mPTbEOGMqHl3YZ1XYNz63lTIGSm7X
 NuAraevHeFy1fzqYuMSfUf+rKd+j7Mkl5usYA5VODTOZEadPKQG4vtiuyI8QoaqmRsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=h6MKavVe; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=richard@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=h6MKavVe
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4FD70407F5
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:21:59 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso24285095e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1792516918; x=1793121718;
 darn=lists.u-boot-project.org; 
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bAFKcUrcQc/HGp/8fQGNiCWVCzD2hMD91j3189gp/wY=;
 b=h6MKavVe97VY3JnyiQvehcfmIKXZeZUuisXexYFWYqOT2u2nIu30VwwWmyOZRIUhYU
 IG5+JCwlbzfpG4FoWXyuknzWvOW9eHs5THoU1rLDc9pAuuLOpq5a0gCi85TDYC9romgg
 C/uALq9sxhiwdawetT/xOgbcJd8Xy5MFwnWlqwM/d8hPAvkvzqqLEKrOwWFoVzZ50Agm
 BCjhAxWMJbO3uWoVF9X8+9rJriLyE3njhxMBx2X7x8MZ2/qMIMprPOSefO5ngEhAXDv3
 kbSxn01vUev3UYuB/MHtufD1SJ1LVcUMGpnPnkUc0ahCNreCvpC5F5igD4osAHLsL4vK
 HQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792516918; x=1793121718;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bAFKcUrcQc/HGp/8fQGNiCWVCzD2hMD91j3189gp/wY=;
 b=AV4wP4NpLYCAFNjQl7Ka1mUd48f+D6ExqSLEIMQteRgts4fzqHCvLUNZ1t/23ei2GX
 dacNqljDGGLhZ0gOjFf+29aXRPcjBgzF/hw3Sa3s7AMlTjf7Dt9bgqP4zy7D3mqnt6WA
 QIEXSMg0n57WQy/FxdxE00M+dbiBIai1djspTDg0YuXixLjuaif4nnlWD0PY2BH83jkO
 F0ANN8XhhwhuEPXMMMqlXHvNu437CtZ/348Q3aGlesSLYFLFrLx80Bo9kpKZvMUjLS+W
 axvOSHeltgIh7gJBKLfi5z2e74mHHZR8AuvX1K9NUFZLlvkbUOWV/umtsPTOFOSCm9Se
 EunA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaAFarNfCEksntVUadDkl8Gwm9mNYyaMj9i2yBD5qH1I/4o0AI+wI5cGlzn2F+wbq+OPMRMpg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLOSCcVE1uzsqjqa8TwJsJx+e7HVtYxfbY6x4pBPiQxRBbbd0x5
 +vg0YWxji9/zcqu9iXKWuDktCwxWEfszv3+ZkrEZ0Q1ABIHVZ9kde3201hjBU/eqeEM=
X-Gm-Gg: AYBFou2AYcrf8sliGBtlQ8YciGEPFOoZcxsfznzAM5kLN2J2Vn9O80QhJn2e/c+F85z
 kFeRMy/xDuyzRcXb3mwbSq+6245zm9p3cBrYwhoYay0xHq/s6e69lKG1iWYTMVKJoO0rcanv7zf
 /ebAkyyAaIbW9DJCGTr0j65MUfpKE9911LK5xYROeKrByjbNN4HiWBDStYhq4V1Qyqz1BMs1+yO
 RyATd487NkxGF756pFzW+/q2l8eIfMJphAEL3kWEbZppGfvx3H+rdBasYD28RphBTGteI/kzCdU
 +LJFZ0A5W8EyUyDNY9L6UiERw/81QdXzQ5xK6F6N8aEIglj9EVWhYE64KyFS3HJfghHKLNS1v8Y
 Z7v1wJiGpC+prDVWRAiBr8hqnugvR3rv86xIP0UarMlPQkf+6S9ozwvt5qIU4mL1C0iIBZKf3Xs
 G/PtF5JMJSipwVlL8pkytB4Nyx6EXkEVC9EGci68RqzPL7qghIz94B/Xt5EQn3WLYAdqCjq3DuC
 Q3D8qS33RFLpR4LKzTW1m1oXA==
X-Received: by 2002:a05:600c:4684:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a1d76001e9mr240113395e9.16.1792516917648; 
 Tue, 20 Oct 2026 10:21:57 -0700 (PDT)
Received: from somecomputer (146-241-50-45.dyn.eolo.it. [146.241.50.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d324f8sm80564665e9.6.2026.10.20.10.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 10:21:57 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Marek Vasut <marex@nabladev.com>, Fiona Klute <fiona.klute@gmx.de>,
 upstream+uboot@sigma-star.at
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
Date: Tue, 20 Oct 2026 19:21:54 +0200
Message-ID: <CCZZi50ESNOykhy4pWjDCA@sigma-star.at>
In-Reply-To: <CAC928Haem8N=Ab68A80Dy6Re3obLFfgCO04667GONkKF=Pv0-g@mail.gmail.com>
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
 <CAC928Haem8N=Ab68A80Dy6Re3obLFfgCO04667GONkKF=Pv0-g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Dienstag, 20. Oktober 2026 19:04 Massimo Pegorer wrote:
> Hi Richard,
>=20
> Il giorno mar 20 ott 2026 alle ore 14:30 Richard Weinberger ha scritto:
> >
> > Well, I have a different use case in mind.
> >
> > What if you have something like this in your bootcmd: "env import -t ${=
loadaddr} ${filesize}"
> > to import variables form a file like /boot/extraEnv.txt?
> > I like this a lot because it allows applications to set various u-boot =
variables.
> > And to make sure to allow only a trusted set of variables, CONFIG_ENV_W=
RITEABLE_LIST
> > is configured to that set.
>=20
> How would the detail clarified by the documentation fix break your use ca=
se?

Yes. I always (wrongly) assumed that importing an env is protected by CONFI=
G_ENV_WRITEABLE_LIST.
And I'm very sure I'm not the only one...

Thanks,
//richard  =20

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


