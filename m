Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27D6C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 19:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E82660E72;
	Fri, 18 Sep 2026 19:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gzx0xAbKQAgv; Fri, 18 Sep 2026 19:12:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E8C0260E56
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789758745;
	b=d3dhktHn+lnCran3hZXK8b8rAFWSgkUPu+q8vczoT12KfviidFJ2saD2cviz0JXRPlD+
	 yNEF8QmYnMW4eWasEeKrT8mUdcak2o54YBZtsL+8Rf20X58xIerV+h5btTH63lqpNwEhK
	 FbuCqg/3WcUe7unRtLra8voi/LahqfVx43hi5VEx0uOI3Nx80yzBpvvmVpZ4REk7+Mm8R
	 uFpI++2dk1HrJOeM5wDXOxd1DiBgS/0SsVPifFjeTHyyWRo75BgQoEuWmQRyo/lOspGrS
	 Sii3QCbcS4HdlOHWYv/g2/jcwYI8N+nlGiNKh0FyeQ6XLf5Gn5s54Ta1DSyXPUvFt6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789758745;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OaV4B9gp3nQpaQ6vyIKTBfCH8lrlc4nGfKJOh9QQU1Y=;
	b=HuZatApFF3lhwbLa63I4yIlkSilRRWSbaaHFqdpOEVe6JvfIhQZnFF7k3azabE0x8ZdS
	 K7+ZwTYZ41Tz7SlEo4q9rhU/6lkHLXcigY7UAsWRaYrYZe/uzoS16yW6F9lT6ma0Jt9KX
	 aTqSbfWCMIXdOnlYbcNPQmjVQkmKaiDGZgJsC+O99wDsq7g7FcD0qD885Vd0wts6DphmY
	 +eZJXbjZ3UaVJWK1Rnb8WIlCCzcrlcZeQcQQms3XVHzh34tHsk7PRS3Bnp0i6qwcbP/UZ
	 j0qYYieuOfhlqNOuY+TgJtn2NUKFw8/kLIDv2oVBYEfY8KdrzzP41Ht5BXXo+AEqH+Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789758745;
	bh=OaV4B9gp3nQpaQ6vyIKTBfCH8lrlc4nGfKJOh9QQU1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mX/8bswH046ZYGGE0HKRHwXdtErx7tm7xhB+SBoB88HsFmsNLVzIdJklV5TPitLON
	 HG7yoGUUUEybeCKmDyhFxeexX3+RU7VZqLfofXJsFmSeYcz27+UVWviSSS5AeBQRMy
	 rzIhNsBEGxhunNEDFD8F3v6KBWZGCncC3kfVjrFoSb6A0Pxf1disPgR4P36VypHTrp
	 CTiP4J/+zipBY37yrvO0ttFWn7md8peUvo9xkIkuSVADIHSPtgdtxw0gZnye22ECpY
	 1eLFWsScVLtN1VCYmVl3QA9bzgdzF9wZxehCHN5YqmhOlFDrJqqbg4/qswYofmEIvt
	 /lKWrGwHVDLrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8C0260E56;
	Fri, 18 Sep 2026 19:12:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D53713D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 19:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F345B81195
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 19:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pipxJRKUMKVf for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 19:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9932A81179
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::1d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789758742;
 b=K2P1ARtVfcWlduBiLRpnE6Gdzw7Rqh9nWZ3XZH34Q0vmhsyusujw5sWYhR/HlDlzoAKr
 RU7lhiufdnvTtJnEasyxTWeThUvIs063bW0N/3bY8K7dFeNVPe3myX8FDo7mrhIN2J5Wt
 +T7vSWyEwCrlxZy1jU6j3Z0ksUmZBBox1OZvRFZV1aWMX6VQEiOg0nkwAs4JG3+hJhfHV
 /84NCyJMHatLi8XeMc42vmBYnv6J7stz+ltD0Nx51Up02sUtQUxeUqDhBFZVSBf39BNBm
 X5FwNKWgxR1uMTh9b8efWmhG7lIrXv5c+p2KfqUw1xMWHdcMSZ1Pca/RTcCZNn/s/EQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789758742;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=OaV4B9gp3nQpaQ6vyIKTBfCH8lrlc4nGfKJOh9QQU1Y=;
 b=NbVkRu1LTXC3E2qoPDinGneO1pHrx/yhtDHHauIrLssjP4ZPxjk/y+VNlvh1BOkgAYYO
 GGh0VHUEJUAVCwbEKQJXFY0za04C9FHQlrj5H/ZpaKtfFPv22qd9ZKHh3g8J2Xfl8dam2
 tPkGW0K57k3P8RE31gdcoHM9M13ma2O17Sz1UyMqZzNNJqHiWtMISi+gm/YIm2UdklPG6
 gSJ8FH5Nmi4BnTACJlYWo1T7gdq5Kj/BxB669qrKRRv8qicn57wKzqyXs075pv/z8LwrO
 L2SefdwxAgGu7YMEoMqj+rpmLrPOidVplj20XLTnPA4Nd1qaO66MkJWPAtjI7a3lrWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=xGkUqdNH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::1d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::1d; helo=mail-ej2-x1d.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=xGkUqdNH
Received: from mail-ej2-x1d.google.com (mail-ej2-x1d.google.com
 [IPv6:2a00:1450:4864:34::1d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9932A81179
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 19:12:21 +0000 (UTC)
Received: by mail-ej2-x1d.google.com with SMTP id
 a640c23a62f3a-c254fa4c24cso181361666b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789758739; cv=none;
 d=google.com; s=arc-20260327;
 b=QJeDu1GKYeQHU7kofuS+ZkwG10kxZ0Y4HKZqvSgv09cYCuZ0ql/1NX+7/jnvoWKO0U
 YpJ7QkezkzooNzwUEyKxAf+zvZPRv5DNa81Qe4WYwb2CjmGdMPzEeNMfqHNIBehdsGQR
 CiJnIB3bZFK5kCpZ6JnAyz8TdefQJn2aM47cJAzwjVcLwmvuARriEnQ+oPbOkf7d6tnS
 UV5BNCN6eL4tE8alWjZPMEbP2I/DnVn4mydUVhDSJCMje1jpBwDPgP7/LGnmVqJH8vlN
 //Q+NosI6ih296vZBNKSzhghdUHn6DRe/kj2sQjS/b8W2CfaTnmDB3xWtdfq+5QIdLL2
 aZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OaV4B9gp3nQpaQ6vyIKTBfCH8lrlc4nGfKJOh9QQU1Y=;
 fh=k9kY7a1Wi14n0cNiG9IiAoGAT2s4BttBHc0XPc+Ktys=;
 b=LRI/a328k89HWwNno57pN94PokryP97tnaFSOPT9ZN5AUh0pPS0fcBF4MaKaayWbB1
 MLGehDcyQDYlfwdNZptWSN+gktZBuNIORwqgXD5AUOevk3IMg8kvRLh36xVohAlpRiXE
 BWGRnsFySpDBnRdscNFhEl6XgHYhQttVJv3k7jCR5JGPCKK4b2ffgK21OEnYzXUzmXCc
 FghU8DAuM//vrsdpAIRwd/kUWL7CH+U6ywOaR6DxVOmtsSD5Ppf6+KyxgOW7l4O2zPC5
 OfEKwZc+6MxXsnAdYTsTWmvI5jAW0p4SW9QY0o6WoPBWdNdbdPf+JOccb1hKK9BHLOyU
 097Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789758739; x=1790363539;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OaV4B9gp3nQpaQ6vyIKTBfCH8lrlc4nGfKJOh9QQU1Y=;
 b=xGkUqdNHD9/rjtYz3g/RyjvAYbKOvukNx0txEdpY+if5QtA6RRaSaJ5oVU19YAwfdX
 +fhtH6n7JAjEJor2wEMMWGi2iKqsrCI4cdl4DMyiElKoo3wQ5bTmjaUfFzzzGoXeEN3K
 qCbfMbe0E3VQpk3vJJQMQSHpEdvnYyXOSOLah+9Gw6zybKiPCkoMAoqXcefqc9CqtUwu
 /BSYHi8jtUbTXmuwKHLkhaorl8sx1SRDvRV43eGAtuVsh5r5qLTrmafJki3o/VMNuD+G
 ezRWUVVmxeJxBW0j78/o/kRo9a2Gm+xJoDl+lpcGUfJme5ZEV65tl3bLTaMQCclBHsCK
 +gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789758739; x=1790363539;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OaV4B9gp3nQpaQ6vyIKTBfCH8lrlc4nGfKJOh9QQU1Y=;
 b=a8FAENHaSoZA+Gcc2FN1LNfCVBP6vcvQy2EjPTQDBixADfL8okTBNsZpHAgVEVM9nq
 uobrLwpzVzFWynfyxMNich8JLVp60dR8RXUCfYzK4Hb2P8oYZIKB6MjxbICHyVolqIL3
 UryMKbJgoSQcqlhQv2kfuJU3D5Dy9G9JctZEDv2h80PLlp35Y4onRNAQmNio+42Hn4Zk
 z1sQhJoSuUYDY4KHpcRKowjmYw/bGaO6CjKVZYx4h2IvsIkUAaeainSy//dAeI0q5ikO
 8Zopp+e48RCnkxdhrE1Vb4ANQez9QGFoMR+d7J1k71O0JidNPlSME9RFbpAM9ShMC3hJ
 xcRA==
X-Gm-Message-State: AFuF++mMJMhRYNogbW6HpCzf++JoyWedmjExBzXWdXFAoOhZ0qdQBH8N
 0AIr6IJnjkPKWGDDUa79gbavFCixMRZUrkwLAHRC81airEkTlD0HoxLAWoGe9tfYVC4f4mknQRN
 dNm+Gm6wZbzzYK5XA0bWu61v9oceX8kNX0HiL3oGRsQ==
X-Gm-Gg: AYBFou151mkGq5TM4BI97qd+ySMM7rCiFvPVWAOQNRpWVVEEEaChVSzTS516qlcgNkl
 rWTvsrMzCa6U66tHRkn0dr+jojo/CrObqcoEWPaCPdBDyAoNZ79/icBxIXafDx+xravpbJiMs9r
 BBVW33Z0vKvWU9KnWZJ9HhZs+aWTZBCPmQGfVf2aziOw7sfojPXJuOKiP7EIh3SjQ+4oJyOPHeY
 pYpeC6lSWCjqKDm409RmQm2U4dxHu02Q6lu6JWS0J39wpzr9II4KYgtXq5ZslTTP10O9kS50uIb
 qZP/x8WQD5wA9YGKNEMRHmBCu7zDFygWJbe3TrM372TE8w6t7sIbS5BblvSY3/rCJySX9XSHMKY
 w12cIrjD2Iub4
X-Received: by 2002:a17:907:97c5:b0:c29:53b5:c69d with SMTP id
 a640c23a62f3a-c2a15cdadffmr362049466b.28.1789758738924; Fri, 18 Sep 2026
 12:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-11-28e946f57357@flipper.net>
 <77f7c2c3-f038-4558-a1d9-8a69529c372e@cherry.de>
In-Reply-To: <77f7c2c3-f038-4558-a1d9-8a69529c372e@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 23:12:08 +0400
X-Gm-Features: AcwNN1UC7568WxPTLDjVHPvdu2hBe9LH0rw60LZRZ1J9hZrHuc0Ap5PC9ikzt18
Message-ID: <CAKTNdwGRuKgrt3pcYWcAuy-OB0GqOkqVFC1i0HF_+e5Zmi+Bhg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] rockchip: Choose FIT payload compression via
 Kconfig
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
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
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
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

Hi Quentin,

On Fri, Sep 18, 2026 at 9:57=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 9/18/26 12:52 PM, Alexey Charkov wrote:
> > The dtsi infers how to compress from whichever SPL decompressor happens
> > to be enabled, so there is no way to ask for one in particular, turning
> > a decompressor on for something else silently changes the image, and th=
e
> > conditional has to be updated with every new algorithm.
> >
>
> Thanks, this was something of an eye-sore to me for a while already :)
>
> > Move the selection to Kconfig instead, with proper help texts and suppo=
rt
> > for all available compression algorithms. Each choice enables the
> > decompressor that provides it, and carries the compression level.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   arch/arm/dts/rockchip-u-boot.dtsi | 16 +++-----
> >   arch/arm/mach-rockchip/Kconfig    | 78 ++++++++++++++++++++++++++++++=
+++++++++
> >   2 files changed, 84 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-=
u-boot.dtsi
> > index 4ba6a87e78ab..a72b55cec05a 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -11,14 +11,6 @@
> >   #define FIT_ARCH            "arm"
> >   #endif
> >
> > -#if defined(CONFIG_SPL_GZIP)
> > -#define FIT_UBOOT_COMP               "gzip"
> > -#elif defined(CONFIG_SPL_LZMA)
> > -#define FIT_UBOOT_COMP               "lzma"
> > -#else
> > -#define FIT_UBOOT_COMP               "none"
> > -#endif
> > -
> >   /*
> >    * SHA256 should be enabled in SPL when signature validation is invol=
ved,
> >    * CRC32 should only be used for basic checksum validation of FIT ima=
ges.
> > @@ -61,11 +53,15 @@
> >                               type =3D "standalone";
> >                               os =3D "u-boot";
> >                               arch =3D FIT_ARCH;
> > -                             compression =3D FIT_UBOOT_COMP;
> > +                             compression =3D CONFIG_ROCKCHIP_UBOOT_COM=
P;
> >                               load =3D <CONFIG_TEXT_BASE>;
> >                               entry =3D <CONFIG_TEXT_BASE>;
> >                               u-boot-nodtb {
> > -                                     compress =3D FIT_UBOOT_COMP;
> > +                                     compress =3D CONFIG_ROCKCHIP_UBOO=
T_COMP;
> > +#if CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL !=3D 0
> > +                                     compress-level =3D
> > +                                             <CONFIG_ROCKCHIP_UBOOT_CO=
MP_LEVEL>;
> > +#endif
>
> OK so the obvious question here is "why Rockchip-specific?". I
> appreciate you're mostly working with the RK3576 but I don't see why
> this (the kconfig symbol definition that happens later in this patch in
> arch/arm/mach-rockchip/Kconfig) needs to be Rockchip-specific, we have
> other architectures that are also building a FIT image with U-Boot
> proper in it, so I think it'd be nice to have this setting apply to all
> of them so that it's a more generic approach.

The Kconfig selection itself is surely arch-agnostic, but I have no
idea if the handling of the resulting images will work out fine on
other architectures or what their constraints are, beyond what the
build system can tell me. Rockchip is the only one I can test, so I'd
rather start here :)

> I'm wondering whether a
> direct argument to binman would be more appropriate here instead of
> requiring all binman nodes to not forget to add these compression
> properties for the setting to actually apply. Of course this would still
> need some logic handling a binman argument and the compression
> properties both being set, and likely remove the properties from
> existing DTS.

Not sure that's a universally good idea: the FIT needs the compression
attribute anyway, and it comes via the DTS. Passing the compression
argument to binman via the same DTS reduces the chance of the two
going out of sync. The alternative is passing the compression to
binman via a separate back-channel and having it insert the FIT
attributes based on that. To me, that sounds strictly worse than the
current arrangement because it turns explicit settings visible in a
textual config into automagic.

> >                               };
> >   #ifdef FIT_HASH_ALGO
> >                               hash {
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kc=
onfig
> > index 1a2e7847c9e7..6e98534f28d7 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -758,6 +758,84 @@ config ROCKCHIP_MASKROM_IMAGE
> >         Rockchip SoCs support maskrom mode boot over USB. Enable this
> >         option to produce maskrom mode boot images containing U-Boot.
> >
> > +choice
> > +     prompt "Compression for U-Boot proper in the SPL FIT"
>
> It's not the SPL FIT.

Right, thanks. The SPL_FIT symbol made my mind wander :-D

> > +     depends on SPL_FIT
>
> This only applies when we build a FIT image with binman for Rockchip,
> which happens only if HAS_FIT is defined, which is:
>
> defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) ||
> defined(CONFIG_SPL_OPTEE_IMAGE))
>
> so you are missing:
> depends on ARM64 || SPL_OPTEE_IMAGE
> here.

Ack

> > +     default ROCKCHIP_UBOOT_COMP_NONE
>
> This diverges from the current state, instead do:
>
> default ROCKCHIP_UBOOT_COMP_GZIP if SPL_GZIP
> default ROCKCHIP_UBOOT_COMP_LZMA if SPL_LZMA
> default ROCKCHIP_UBOOT_COMP_NONE
>
> to keep the same behavior (not tested but I believe this should work).

That was my first attempt, but it introduced a circular dependency.
I've checked the current defconfigs, and none of them enable
compression. Worse, LZMA had been broken and couldn't link for some
time until I fixed it separately (it's merged now), so I'm reasonably
sure there have been no active users of these settings lately.

> > +     help
> > +       Pick how U-Boot proper is stored in the FIT which SPL loads it =
from.
>
> Don't like "how [it] is stored in the fit", I would prefer to make it
> explicit we're talking about compression here.
>
> Maybe:
> Compression algorithm for U-Boot proper as stored in the FIT loaded by SP=
L.
> ?

Ack

> > +
> > +       It is around a megabyte, so what SPL spends unpacking it is clo=
se to
>
> Size depends on what you enable so I don't think it's relevant to put
> this in a help text.

Ack

> > +       what it saves reading a smaller image, and leaving it alone is =
a
> > +       reasonable answer. Compress it where the room it takes up matte=
rs
> > +       more than the time.
> > +
>
> I think what matters is the following:
> - on space-constrained systems, enabling compression may help making
> sure the bootloader fits in the storage medium,
> - compression could help with boot time if the storage medium is slow
> enough that reading a compressed image from it and uncompressing it is
> faster than reading the uncompressed image directly. Whether it's
> beneficial needs to be experimentally checked on each device as it
> depends on the SoC and selected storage medium.

Ack

> > +config ROCKCHIP_UBOOT_COMP_NONE
> > +     bool "none"
> > +     help
> > +       Store it as it is. SPL copies it into place rather than unpacki=
ng
> > +       it, and the build needs no host tool.
> > +
>
> Please add a proper help text that is understandable on its own. It is
> not uncommon (I do it more often than not) that people will look up a
> symbol with the search function in menuconfig and will only get this
> information, it's therefore important to know what we're talking about
> here without having to look up the choice help text. Ditto for other
> help texts below.

Ack

> > +config ROCKCHIP_UBOOT_COMP_GZIP
> > +     bool "gzip"
> > +     select SPL_GZIP
> > +     help
> > +       Compress with gzip, run from the host 'gzip' binary. A middling
> > +       ratio, quick to unpack, and it needs no SPL heap.
> > +
> > +config ROCKCHIP_UBOOT_COMP_LZMA
> > +     bool "lzma"
> > +     select SPL_LZMA
> > +     help
> > +       Compress with LZMA, run from the host 'lzma_alone' binary. The =
best
>
> I'm not sure we need to specify the implementation detail of the tool
> used to generate the compressed binary? lzma_alone is also only
> available on Debian-based systems (e.g. Fedora doesn't have it), so I'm
> not entirely sure whether it'll stay this way forever (maybe we should
> switch to another implementation that is available on more/most
> distros?). I understand you probably did this because it's somewhat an
> important piece of information to then decide which level to use.

The peculiar host binary which nobody ships these days is precisely
why I decided to mention it by the name. On my main Gentoo system the
legacy lzma container is only provided by the
not-so-easy-to-figure-out lzmacon package, which then requires
symlinking under a different name for the U-Boot build system to pick
it up. With this help text, a user at least knows what weird binary to
google for, or what substitutes might be available on their distro.

> > +       ratio on offer, and by far the slowest to unpack.
> > +
> > +config ROCKCHIP_UBOOT_COMP_LZO
> > +     bool "lzo"
> > +     select SPL_LZO
> > +     help
> > +       Compress with LZO, run from the host 'lzop' binary. A poor rati=
o in
> > +       exchange for fast decompression.
> > +
> > +config ROCKCHIP_UBOOT_COMP_LZ4
> > +     bool "lz4"
> > +     select SPL_LZ4
> > +     help
> > +       Compress with LZ4, run from the host 'lz4' binary. The fastest =
to
> > +       unpack and the worst ratio, so it suits a fast boot medium.
> > +
> > +config ROCKCHIP_UBOOT_COMP_ZSTD
> > +     bool "zstd"
> > +     select SPL_ZSTD
> > +     help
> > +       Compress with Zstandard, run from the host 'zstd' binary. Close=
 to
> > +       the LZMA ratio for a fraction of the time, but its decompressor
> > +       wants around 94KB of SPL heap - see SPL_ZSTD.
>
> I don't like specifying numbers that aren't guaranteed to stay at that
> value. I understand the appeal to provide some number to give a rough
> idea of the size impact, so I don't think it needs to be a blocker,
> maybe Tom would have some opinion there, otherwise ignore this :)

Tom acked a similar help text on the SPL_ZSTD option itself, but maybe
duplicating it all over the place is an overkill. Happy to distill it
in the next version.

> > +
> > +endchoice
> > +
> > +config ROCKCHIP_UBOOT_COMP
> > +     string
> > +     default "gzip" if ROCKCHIP_UBOOT_COMP_GZIP
> > +     default "lzma" if ROCKCHIP_UBOOT_COMP_LZMA
> > +     default "lzo" if ROCKCHIP_UBOOT_COMP_LZO
> > +     default "lz4" if ROCKCHIP_UBOOT_COMP_LZ4
> > +     default "zstd" if ROCKCHIP_UBOOT_COMP_ZSTD
> > +     default "none"
> > +
>
> I'm tempted to say this is not the place for this and rather should be
> in rockchip-u-boot.dtsi for example as a series of #ifdef (but if we go
> for a generic implementation that applies to other architectures, then
> maybe it's fine like this).

Noooo - do you really like #ifdefs? :) Having this here means one file
to update when another algorithm gets added, as opposed to multiple,
which I believe is a worthy quality in itself.

> > +config ROCKCHIP_UBOOT_COMP_LEVEL
> > +     int "Compression level for U-Boot proper"
> > +     depends on !ROCKCHIP_UBOOT_COMP_NONE && !ROCKCHIP_UBOOT_COMP_LZMA
> > +     range 0 9 if ROCKCHIP_UBOOT_COMP_GZIP || ROCKCHIP_UBOOT_COMP_LZO
> > +     range 0 12 if ROCKCHIP_UBOOT_COMP_LZ4
> > +     range 0 19 if ROCKCHIP_UBOOT_COMP_ZSTD
> > +     default 0
> > +     help
> > +       How hard to compress, numbered the way the algorithm's own tool
> > +       numbers it. Leave it at 0 to take the tool's default.
> > +
> > +       lzma has no such knob, so it is not offered there.
>
> The option won't be shown anyway and it's clear from the dependencies
> that it's not supported so I don't think it makes sense to have it in
> the help text, however the commit log would be a very good place to have
> this piece of information.

Ack

Best regards,
Alexey
