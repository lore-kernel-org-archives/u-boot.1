Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F846C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E8BB80D36;
	Mon, 21 Sep 2026 16:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ptHjtcEuET-s; Mon, 21 Sep 2026 16:11:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 81DF980D29
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790007085;
	b=mN+NDdWr3XOQR3RLjN8kHYpmIad9WfD5KhoB5Du9OEZPkHzIj4zzmMO5k++Kfm1Jmj4X
	 1z30HEfaMiLHBkpYZhP1CtmzSv/v2QPyI1jhMCetu2x/GAP48Mu9C1J4O0KwQAwWgCS+m
	 uwOqTiAUnn5tI4OgufYDjYIZaOTTdQequAHcjGk/LTceqfpOXO71Ypy4EgRnwb/glxSgJ
	 uqUAZDV4PvZd6MKnDTaJ2dvKvnIgVJkwCXcbrp+u7TVR5wPesmwWtvylxBHdkxT+jjfMf
	 uiak6Y9dvPbjgc59LNeLf5GHgmQPBf5emn3L5BV5WocK3k0h8pQ/1vhQxPwig818t3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790007085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jSPnphC45WgqGC0A5t+DVSHcWuSvGXMrHBOIAwqRxr4=;
	b=SThKsipKeEw/Y6e9SFzHeDq6TcL+begN66G0okIHL9YKVYiZWLgAAplu6P81Y2Dbfdne
	 epfEFyopaPPPbCeig54mAK9PFvHIvv4V2zivb299MRVTi1sKZOY5s6j0ljGzviyzv5P93
	 /MnfKTcj6IU8JFDbw/twPhPzd5uOE/K1T25g6NM23qJ44bThjnC3oamPQyuq2dsYTEKAC
	 LBod28PVfSLiYAgCrBlwuUxLFHjt3fx4detPhIpO9pk+q3vhnrqXg0nN0XpID0rYDRe0a
	 AAK8ODEGJXPGo2hoJgGuN3Gbsv1LQB4oOd5ahE2u/V1AVEZuaSp6/VbKz63KnFO8TtA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790007085;
	bh=jSPnphC45WgqGC0A5t+DVSHcWuSvGXMrHBOIAwqRxr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kpNwu8/mQ3XjvJGT9O2L1yeIr5MfilgAurgJuAIpYDuEMVwAMIHjCWqMCVGYQ/MbY
	 O90p/7eBh/00DLG+j5uYthLfkx6W/kuMcA+QkkqEY78SyJ3YeYOm8v/ZGpiHSGU/so
	 j0y6n+IKgBo1VjeBkTcnXdqoBpvptd+XTkMz7G6/EEt2aNbMdzxdN/7fXOylEaZFOW
	 xJxAHnKdWYLY3Vq8I66J7DU9D3eZ50BLQJ8wrgY0IifACp79OBsEL8hxHmmdDgfBjL
	 yDag0esmJw+nrD4ApPNWV3Kmpu9P+iYRh/Dz8O3WS+maFNixM+5TIaGs2AlxMAZFX1
	 kQibYSo7IvV/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81DF980D29;
	Mon, 21 Sep 2026 16:11:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A61813D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C1DD401B9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:11:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcpBrbMdIG1t for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:11:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4F2AE401B1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790007082;
 b=ck5kKN9CvHd0TCx6n8unO4UZ1WSKsAK2iOV95CnkOFrirxKvxVrO/ICJvKh9qEzeFdCb
 xFptQwIXP5Ui051w64rx+d0wCIyWZe2J6UyFalKcu6QRuxDhxGsj5du2wVXd/j3wPceQr
 N43zYIavuLrVL8874tRAwOi+ibtLMIdAO0ZC+jMfjh4werNH9HoPlCfLCf01QtiRIK2gh
 JI3bWrULF5kvBTvUZvYBfpyNInTHoA2a+4cURZe49THwtws7neA7WqtYiS6fPwhhv5C1N
 mAh7nThzxkMR/PEJhLUiDm+jXuod10K3qSVZiNjgF16WY/6a7i1yYvmua8wuEe6KJBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790007082;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=jSPnphC45WgqGC0A5t+DVSHcWuSvGXMrHBOIAwqRxr4=;
 b=adIS0ZDhDAgeWNsQ9vidd5kfcQ9UQIfKwrvrd8ma1cu3WNFnijHDq66VrB90zbgXRQa9
 PW8ZxuTSlPi9c4Q2/SqIYgLLzeqYQQ7SlthKhLEp3b5ha6IcgqWwUESXYiNIymjhtcnQG
 YMCKyWlTGlIrEnlPpaX03eda782ze0WMD73oZxZYfaDsNDx7c96cfdAHaB6nmAO+ZHmHv
 GyEaX6ANITF/kgd3QkmiAJBJZOmwHgSye1GGv6AR80S2SBZTSY5rPH/XdOkxbUOHmABwC
 fr6zS4BU3ccnTLADmWCR5xuXemTO/Fl/GxoL9r5qiH6Ywy5J/mEOmJGg+lCQAd/T65w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=bPv63VtP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::2b; helo=mail-ej2-x2b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=bPv63VtP
Received: from mail-ej2-x2b.google.com (mail-ej2-x2b.google.com
 [IPv6:2a00:1450:4864:34::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F2AE401B1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:11:21 +0000 (UTC)
Received: by mail-ej2-x2b.google.com with SMTP id
 a640c23a62f3a-c2940ef15c1so395690266b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790007080; cv=none;
 d=google.com; s=arc-20260327;
 b=bhZ7rUKzWTQLqKVFbzgc9kBqz7XgQLOeqC8ZuxsdAodZSniepP8ed9UhNd0l+rbIjL
 sZduj/F0y3Qh20HX9xKj/1MognVqClLDtzoye5d/yi2n59HQFIqZvgXVK8j6rx2H0MuQ
 GufcglaJbYKMp27uv3Pb19rcFiCz4q+kvp07yI9DwLGiiHSIgMl1g5NcBHq6P3+IBdq+
 QudiQ9ifF0dVQX/a0/fjWUwUx0A/CmRHxnvpAeLrQBba6LUCzIdJU5IwQzWh41eNxkQk
 nyoS0T/XktvKXwluzF8xGKGrAO+fXPr926RxmLNBUPFVdbkBD7n6s+/r7CM9AioXC16q
 O97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jSPnphC45WgqGC0A5t+DVSHcWuSvGXMrHBOIAwqRxr4=;
 fh=6y/pU35iRfXxioFqOusdgqk6qBGB5at83bcXAB2La3Q=;
 b=iIDJC7sZODXqn2TBsScJqsyDabsBrUAoPXTJxkI1EjdjNQP+kDoYEQDmNQ3Td1b0q3
 ePIPXo31quKtxMpCPpeU5hvM9KlBbhYHCrYQh1+ubWgUklSgjXBN+QNTZ/uT0K5Mj/Tn
 oTYhwZvSYT9SKT/ihRB9kRYWSzzMpMzwyZSrfDYq/ifBgbcD+pQPSdmyqyCKKn74XhUj
 /0gtYk85QTke5diazoxHJ24CsvpDd3PSYSlEqlIQ+exjZsy2uaYkDggkQAuBwYTUrwjX
 qfUq8kOWlgiKFOvlqfMaM36sPxFivKFYFYJt7s0Yf86cJ0OoIXYJVmjH9l5n6Iys2neu
 LnWA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790007080; x=1790611880;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jSPnphC45WgqGC0A5t+DVSHcWuSvGXMrHBOIAwqRxr4=;
 b=bPv63VtPp6GK+tn71wWC/ORDBTsguULK6w9c532zYROz9yxmHuFDv2gPx0bl7aQOOb
 1BUhfZhORDRdMnBbHxs7EFkm479pfuVeW8HJX22QPAujlgh32v6NLIjtEQ1HGe8iyeyK
 o4jiqErEnn5SD48M4TMEF07DPsh7iVts7a/QekMjP1SRyz+GZ1K0PwVS4d3MYo0U0J5x
 z21GNJLzcO14hIM4J7qT6x2Bn3kocdx2+tbxBNW8iSceROyaXc/xQuKReG2+EWMeGTXG
 bffDnWe3X+IzF6oPzTe27w2Pb4xzw8S9OnvFEkqBOvQIKkepf82t3Qzj1wRKy03OJcpP
 r2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790007080; x=1790611880;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jSPnphC45WgqGC0A5t+DVSHcWuSvGXMrHBOIAwqRxr4=;
 b=KiAOhzlrqR4nQ67PNPLliOqyUd0utTeQUCqYVCMB50NEQtEYM2HaBR2dC2QgW15RkL
 V782oMdH/I+9IAPXuIVT5ezFtqP45xGF4qW22iFRTcUmqJye6fimcuW2Sd7jJ+s8vKNp
 rJONS9fQAitKZf1cso9dvNaRx9wtMb2CpuvxT2VK6n9BjTgbNZM2L1bIBRsR7zEL5QVo
 4TuG5ix9h3rKE5f/8vUN4xzNkw4jh1Gmhz2bT8MNGZNrtZBImgkGmMUDJ6tCvpwtAAPG
 r5rQpLONtVCnhKP+da81ZIKJXz2fXXBtFSwsucncaVN1JzlmLl5xm76m8qv882RdPXdY
 MQUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz64ATjnqU9E+jPtqYaWhcM9bqBXE8zFTEx8gUlKhvLioQPduT/mTDNn36hm0If7Dh6dA9KcH0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ku+ERgUInTo2E5HFRqzGGVmYg5IJ9zhM6CMERDoF3NS2xsy36j
 WzNFuuyHPwcy70mRtsSiNiq65BLb6L8ymebkyIV+XnUsMislxaabar3taxUCrB4N05lXEhsrJJd
 gKIaqNxkduCN4TbOPws9jeVTRyd28CPQqNlLCN6L7Rw==
X-Gm-Gg: AYBFou0v1ePUrUXChdu0NCQUjgM0UOt6HSkmmWN18sYzAgRaORtm8jLLPADoyNDLKdf
 XgrM3kixqqPHd2+GDJm++HkzPw8aFb/S1HI/WEPqFp2ngGTQDo/m3JWtbqAr+51pVMYVGHUgNYq
 aACvVoRAlI+xvInG/2sKTRWCMpVuL+16JoYdRh2YCe6vxLLR7GvyzOYHXmihmxGUKXLxh+cDOz4
 18HsN6/0ATOOEsu2Z6ftb6XpnjiBq/De1UIc8gaEkJViHUscL6LR+s/LQGJrEdu6m0incGuzRKU
 jFXPQoqqxNhS/c0hpemfDIT6MnNaJCNkn45OYGD8qg7tv4JLz7nwtUxP6Q==
X-Received: by 2002:a17:907:e11c:b0:c27:420b:7c79 with SMTP id
 a640c23a62f3a-c2a8acf45edmr60656866b.48.1790007079703; Mon, 21 Sep 2026
 09:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-3-28e946f57357@flipper.net>
 <2b6b6f3e-8fee-4b55-9ed4-89ac704e67e3@gmx.de>
In-Reply-To: <2b6b6f3e-8fee-4b55-9ed4-89ac704e67e3@gmx.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 21 Sep 2026 19:11:09 +0300
X-Gm-Features: AcwNN1Wf3JpFU9E_htyEsE7NVTVLtWOrujoCDDSWXJ4_-beqblavqPk-tLUWOBs
Message-ID: <CAKTNdwF0-Kjw+8m5pNLP8THugxDoLRHq_Qyct2bjuhQQipVp_Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] lib: Let SPL minify zstd on its own
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
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
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 u-boot@lists.u-boot-project.org
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

On Mon, Sep 21, 2026 at 6:47=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 9/18/26 12:52, Alexey Charkov wrote:
> > ZSTD_LIB_MINIFY is offered only inside "if ZSTD", so a board which
> > enables zstd for SPL alone gets the full-size library in the phase whic=
h
> > can least afford it.
> >
> > Add an SPL-scoped variant of this option and key the build flags off th=
at.
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   lib/Kconfig       | 12 ++++++++++++
> >   lib/zstd/Makefile |  2 +-
> >   2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index ec6f162dfb57..1292185e03f8 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1023,6 +1023,18 @@ config SPL_ZSTD
> >         buffer and takes its window from there, so the compression leve=
l
> >         does not change what the SPL heap has to hold.
> >
> > +config SPL_ZSTD_LIB_MINIFY
> > +     bool "Minify Zstandard code in SPL"
> > +     depends on SPL_ZSTD
> > +     default y
> > +     help
> > +       This disables various optional components and changes the
> > +       compilation flags to prioritize space-saving.
> > +
> > +       For detailed info, see zstd's lib/README.md
> > +
> > +       https://github.com/facebook/zstd/blob/dev/lib/README.md
> > +
> >   endmenu
>
> Why wouldn't you want this in main U-Boot too?

U-Boot proper already has this symbol, so I'm only mirroring it for
the SPL use here.

Best regards,
Alexey
