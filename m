Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193C4CA5FC1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B48DA80F89;
	Wed, 30 Sep 2026 17:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GI8q5oE9jCkX; Wed, 30 Sep 2026 17:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1742E80FA4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790790973;
	b=U9SetB9INT0JAGjNMrZ9ZDticQuLpam4GiWiaJTXtrMG8P+WlcLf2MNBcwiyetuOH/2j
	 LaCzGJgRX5xv82A3ZKYKNxIykJZ0dRum/wI7832u0mdB2odzC9cdW+TYJQiOXnHBwGKm8
	 QAF6otr7ZxVMIpPbHsW4NhDIew9a3aumjlav+aZk7RDMMkt/KU64ezknlJfK5HQvI821u
	 N78k0+hpb6mvAPdZaCuX8L7yn2iyovqToDV1ycQ3EedcNQMYH/PBSh+PpOPCJ5a8t2Yhj
	 8ruSUQEK8Dp11gmwSxeA/0f2xrmb+F286X/uFY4mjtJglrxGZcLJIqNOSisr7Wu8eGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790790973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+lbka4jmhnVRaSZk+0VYb0jiSg8Hn6q4v1E7+XMa5QQ=;
	b=pKzzFhBI9/iY8hlA8hC5tJb19ZBd4ptZfqGSRw/KMFutfadew/QmEs1hezFKa+uvp5Pw
	 dNTaqJXrv7VURPl3Fs8L+jugJz4YYurACz3eAdiHSp2ja7S+yUfMxHqSYRPCYOgvYfkTG
	 nhlU1smtrEfoMu+fKCTRybLsKDSErhXcVF9pPP32cmB90Eg8tcf3Ji1eviMXSLRdtjTX3
	 ErNw+LZ5SSMTH2mUa27sMPP0orcWZjCzNAm3k/icMCmWtOdjwlgEWqoajYsH00jVhxiWP
	 i4bl092f6PY0oj+dQb1rVsyW7QFZV8AUsNdDoE0b/AfDFU0Sx1HYqB+R1k1myYXXOnw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790790973;
	bh=+lbka4jmhnVRaSZk+0VYb0jiSg8Hn6q4v1E7+XMa5QQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zvKmx3Eb1wZVM+v7/3gwb8reki74fEy5Jep7PBU4Wx8MYnyk9GjH6XOlGRMLaQMIy
	 SF9VuQieh0yD3QMjfCh6J4pxhZypTi9cmtt8YXb1MtwLp7urSctfecRenYFDUpmkru
	 tr6XdQifCpSNCtFSaASFrCcVO7i4qkeNeKsoQVHFOHYlt0F5YBDNQlT1rBExWu0eXf
	 nUZpNkClXbA9gqTXTJzXPtUPm5t0ggBWVPJDpbr9a5cR/kSRXCWVA0gde4nrbIr/OS
	 xxmp667Sjn4TAE8F7rfXK3Khn79bwyyU2QH06vILuIeBVkOOK5r1MIrCP8TGlyt+fR
	 9lg8VUpymFB6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1742E80FA4;
	Wed, 30 Sep 2026 17:56:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC828380
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDDB360B57
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWpUw3UErQSZ for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:54:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CFD65605DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790790840;
 b=WNeuyNW6GeFWXcbuVJmXSo6N2nqBB7VCn9BpfPL61xYPCVZ8v9U848xF3K8EVYa9OyD5
 AZlmC4HhZmggXFA6PozfvdOsw9gntBeDdygsdXKUmht6oSBh5lytBmvc4hlz4dFBt2yoF
 oNBPCZ+9yHS33pw0y/Tl4aAV2OI+KdEKlB/HCYZmX7z3tWDKf0EMYDEimVaa0/H7bAg1f
 7Rfup0PBu1ErrnAst0Aj2UcWyeTbPCowIyTYHMM48XXRxxsOpohY2kYlcY/Ayckmlrp/A
 4Iz7lyJkqdzgQ8zdBGfcnUkp2cMF4VX5Vgttkc9jHe+vo8d+d5IBN9MUgG1Le9EfaKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790790840;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=+lbka4jmhnVRaSZk+0VYb0jiSg8Hn6q4v1E7+XMa5QQ=;
 b=ViUARh8odz/6s/MwKRAVvj2tAaLgxagdk3R1sRFoloRBwepHf7rc+/OjsK3v/jfpL5yb
 DAjPoz+rDQkispuXk+2wEZjcNreWEhwBj4woDekCtx3/+bgBZJ4ylaSJ7eWA3BC3Pu4Z3
 seeTId4YM2bZyPckQE3dGyokoMUMEh85en1EZKoIjNhGZyL7IpkY0q3Y+TBrYrmeM8ueF
 Dlkr3upw4SKe2ndwYVe0p8I3hEfyZXex9JR9lhqAZdRiVFQX0+rLaRmwBKVTJHpZvEd0/
 MXsllEIHAoe+d62xyS11OV6KRhb6Bo3mDABWWKHXGYzz7n07uBfuMIY0KY8TwvyK+2Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PhAno4ZK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::e;
 helo=mail-lr2-x0e.google.com; envelope-from=aford173@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PhAno4ZK
Received: from mail-lr2-x0e.google.com (mail-lr2-x0e.google.com
 [IPv6:2a00:1450:4864:38::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFD65605DE
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:53:59 +0000 (UTC)
Received: by mail-lr2-x0e.google.com with SMTP id
 38308e7fff4ca-3a652e2149aso49892911fa.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790790837; cv=none;
 d=google.com; s=arc-20260327;
 b=D3Sswx5WUp9Q+vMXeiHimrzBI6WeapaxzJC5S4Prq7CfgJY+w0xLSd0k03xboIlm8E
 rgjRXvroaICa5weIGhJzaqGXB9TQ2Mn3qSR6OiUWH5ivVlcQyuR8PvjVO9pbXlbxrRQ2
 XDM7Zp0Tuj4NuxKKClr3YX9UfDITumkzYHfbhfqxRB+u0ObK3KYLxQs05s8v2hnMIWp1
 91xU6yV0vcoIQ7XCQm9dOqXheNAq6RDP1CxhA4aKmNKv8EqOL+X+4qYUHIST5/oFtCvU
 zzxWIOIZboqJjNOnzqpMQZq/j6wdyxLvJJsnBo/hv7qB8OHoP4GEZyRhEi+XyYIpWvdK
 1jiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+lbka4jmhnVRaSZk+0VYb0jiSg8Hn6q4v1E7+XMa5QQ=;
 fh=qTvhLRZ92jY1+OfL58QTXFZ7uob/UpYTgFyRlPgtAR4=;
 b=iX659oRCN8086BcKFI3CYCXuOS6kadaKbAJnaO78G1KBdEK0Xa4go6g/t1RxV6KWIZ
 Ogw4+hL0hQ4Z9dB+8ZVAvG93o79rahUH2A/WSB5to8/sEAKKeo5pmB0CioMmApQ9B99o
 BGIAryGQM9FK9OxxhFu8N7bXfjm9N4mDhN/yzubJicWZC6oLvCIC1R6I2irouf1Xfpph
 MEGbj5cEstlJ7ND7DCUUaA+fM5J8jN9fEjlcYjNRG71AaETBfXN70Cw/1L2++oBCNnAL
 m1KPt92vrMRPndyBY2UwkExdKL5q3I27GYWf6MIxz608xs7cpLBwdg/710BEkt0Oawd9
 hFYw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790790837; x=1791395637;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+lbka4jmhnVRaSZk+0VYb0jiSg8Hn6q4v1E7+XMa5QQ=;
 b=PhAno4ZKy3A6ejKf28mpHOfL869QFctHyEvIndPXKkCxalKIUsaPLZ18N8mkfkkDN1
 2EiSvjpmdmZehJu/vwamOv50luy1Xe/lfQ0mGifHLJXauXC/PJ/B45v3rW1ryWK6zZQ4
 JOv4V2FOfbGYd0arun/XGaaFw+4O/NDQgfGb4HrlLEenI+3YD8VaNnvw9Bcm/HSjYKCi
 Wcjvv2QRlFK6jAh3wLvk/PgBuzkslwDQc6xf6q1PwTho7C6YcuQlMtSVi9I7CLloBKVJ
 nyfzZdFMjTqXSGMppZDXba1p8nG2Jd3cprA0x1C8bPoAmDZC5TbbT4k4k+KjfCBAVLNp
 KBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790837; x=1791395637;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+lbka4jmhnVRaSZk+0VYb0jiSg8Hn6q4v1E7+XMa5QQ=;
 b=fAFTCeJ7m5vWo/85unRIZpqVgMmszmfDAnk7gcyomxjepmDRZBbihoka6roAhCZjjg
 W/9+4tT6lfdVj+DMXtU8Z1upJrZ4kOIMCuzPHUGy/Oqabp4XEhrJ0zQUKcGFtUFVkitY
 5KG8hArYqIUtcRNTlzPCCzTsqgjLiU18jrj/83lgvDztngZwVWj1eH4AFLBT+/IBf7qZ
 nGkj2zWDV3OG3bdWCX2siEcgg8tPU5aJcaPIYp9yCKeNLamgs9MdlsKv1E/CctWfLl7m
 e7vy2+m8OEI2PeIbz/PQviq0+3AyUcQiCR2XUcNQuQfWvN+xIgfdlB6r6bAeNQMHfkLr
 H+3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNv6s1G9wnxHr0pSG9RbblOaPAXFHeDUkWuwJj/i1W0EJJr29ba5aX7KfxAbP8utzuQC4dmUc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKrq7r6xIDQJjhd9LZWLBGmCXZ6vb/ZIP9earKu3Vh019iQmqYh
 mf7P1M4Hr5eD93VoWvoZk2ns5+sH1ISYrtbCOoEY5aenoARGpeA0lQlhXBRzGPTnWXFp8OwIIG4
 esv8VYfWSSxGMnr99f1OYIFdsRB2jjBg=
X-Gm-Gg: AYBFou0Hs1a5H5uOHfdNB5uBHNBKD3w09FkDoaw3FplcYG+AxPuL2J77CrIOWRav8QN
 +rBDNUf82w4cwIQH7oN0IRTeUx4vooIQ+su8VocesOAa5rdrlIOnwP3DQzPyqjYN6LWMwieX3fF
 XaVsytOad1HjghgGN1hzsDHCVUWR0/bk4NzocZuiymKMxraxm9PzSJXOqRs1kxssj2g7k4++Hcw
 Tfiz1mrkmNLqhqWc0Q1gE9aoSuzHWxE/g0KTrcRPet/vpan9VKAv+QPRrDLvQpiFZvHoJkePYur
 cC/+G4Nbtqft7uuDao9T3MHq0BiRP+kfpfpHskXaWkmqOCyyd+9PhFc4iRZqjoWlmqaEy4QuK4h
 DD5WF3DlyZ8nf4byHRp3O0vo=
X-Received: by 2002:a05:651c:1509:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a7791fd5c0mr8390541fa.22.1790790836999; Wed, 30 Sep 2026
 10:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260913155253.84181-1-aford173@gmail.com>
 <179078865386.467656.9091674646926534530.b4-ty@konsulko.com>
 <60d018d4-fd00-4c26-9b0b-f1ce288d65d2@mailbox.org>
 <20260930173919.GI858934@bill-the-cat>
In-Reply-To: <20260930173919.GI858934@bill-the-cat>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 30 Sep 2026 12:53:43 -0500
X-Gm-Features: AclHuK_-TPpWb8VkTp6CnLlHa_x8Tp1oZIzdP_hAe5vuzuVBaQLUB6nFZOB14xg
Message-ID: <CAHCN7xJxZ7w+qT7yOhCV781oU-9thN+5W1oNk3rSdvfXbRk+dw@mail.gmail.com>
Subject: Re: [PATCH] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit
 support
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Huy Bui <huy.bui.pz@bp.renesas.com>,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 30 Sep 2026 17:56:10 +0000
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

On Wed, Sep 30, 2026 at 12:39=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Wed, Sep 30, 2026 at 07:37:58PM +0200, Marek Vasut wrote:
> > On 9/30/26 7:17 PM, Tom Rini wrote:
> > > On Sun, 13 Sep 2026 10:52:53 -0500, Adam Ford wrote:
> > >
> > > > Remove the Beacon EmbeddedWorks RZ/G2M/N/H SoM and Dev Kit board
> > > > support along with its defconfig, config header, U-Boot device tree
> > > > overlays, the leftover pre-OF_UPSTREAM DTSI files, the Kconfig targ=
et
> > > > and the entry in the Renesas board documentation table.
> > > >
> > > >
> > >
> > > Applied to u-boot/main, thanks!
> > >
> > > [1/1] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit suppor=
t
> > >        commit: 3f31d496ecaa6240f1e578cce389a06798d66c30
> >
> > This is unfortunate, oh well.
>
> Yes, and I'd like to thank Adam for all the work he put in on these
> platforms over the years.


It's been fun.  I hope to  do it again. I am still monitoring the
mailing list, but it's not fair to maintainers to keep something
around that I don't have hardware to support and/or test anymore.

adam
>
>
> --
> Tom
