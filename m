Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1CDC55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 13:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CBAB4068E;
	Mon,  3 Aug 2026 13:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qB6LG_AtaC49; Mon,  3 Aug 2026 13:40:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A910A4066D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785764418;
	bh=YYG8H5pXZUrwHasKah1E904wVnVm82puBqBoj7XTtmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xkwDRThBayIb78r/iPgBAOkdd32O65ynMG+tUpyQRNRZDXHaNQUhE0wbioPw4wVCZ
	 W+5UyuFDbf/kjnAmrad5bJ/Ol/fiwso/BTr8238bfY+8fJR3fVrf6fbJPF1zx2/vzL
	 WyWZj2qImc0AlgHh84WP4MlN4xEEn1FSmyqNw5tAXs57EiahJV7I/yNzqVkQH/w9l6
	 iSJbVUJNHACf9xKXL37KZ0V74Ie9bgrOhp7GlixKgWLnGmOH4JDp/my1WyHrmpdJVE
	 tA/1ANN2Cwn5JjJnolG4gItvtsCzSGSHO6mu2H1WWoQRh3zUq6i1d/fYP+WwmNsiVE
	 UbSrZLKjGR8Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A910A4066D;
	Mon,  3 Aug 2026 13:40:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 84BBA218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AD7460768
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1iUhTCfGfVR7 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 13:40:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7DC436075D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DC436075D
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DC436075D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:40:15 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a051b73866so5449561a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 06:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764413; cv=none;
 d=google.com; s=arc-20260327;
 b=XNevCdhpCv38jO9AYll1LUc8regYVxeHWYAef9eaoyOJE5SJrGAFyxybhEJJ3RO5zP
 +N1D1qYsY70Lh+EpBbl6hlz/4J1JaFMiu5btaTC713TfmDSU59rKje6PhLxgnXbfJFKp
 IMNov2OaxP2KoWD7JlecIOZZyuhHjWtmWGTwzWckXZqCnE5Va0/h8qIPNDzZKSC2TyE8
 8nXDQDIBi1DOmb6BYYggMMzlO2TqUWp7TEujgplJu4V283xT4lI2aZbfzrJj8TC7JGHH
 8WKMcT8uVg1DupGmthXfRCqkBSqYp4eanaBba/jOFctayaZZ9f27GQeaR9HZ/HDvv3lB
 28jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YYG8H5pXZUrwHasKah1E904wVnVm82puBqBoj7XTtmg=;
 fh=1NERUeDO1krte69lYLk/9jgCoDN2AoB456fJLkKV3N4=;
 b=hDddOZvTc/zbIuPZeCsEOPJkpikKS15XH12ya3npbCqBCchXB2bbwalVEXLYOp58zV
 rNGmrnL88Nrgtgc0TIsT+RQ3z5Ztipg0ExlDRe0KPO2CioPLb1xdsv9C1RGUYLfmzvCd
 eoMdAOmWreeF+Gz1qkssl5LbD/jzFpKAZ0ZEuXqZ3/5LTy1OSu2YLBIUud3ZBVcpBQYq
 9r46lJiw5vB3L2/p4864RUbBKyyylYC8MOkYn0VlRbu4TCj91yqyo+iAb8p8LB7BMQ4i
 dUFQ6R3XZ9uPcHpZAWQpQnn7fMfgMeZSKuTfYbE/dpJQIYKuCo3M3HysFZ2GUdHLSgqS
 33Zg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785764413; x=1786369213;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YYG8H5pXZUrwHasKah1E904wVnVm82puBqBoj7XTtmg=;
 b=iSaWVQlxhQU6d/uS28H+BSx1ccQS4dSgG76W4XTru8aM8vNxWU1nHLJ+qhvtkA4/QL
 0KPqXTiQcETTJbo8PeUuHhhcZO/vegUGEji2mssFR9oIl8hKdqaB/KG6G0chLIeWMJoo
 i4lGvigcK5kLR/qcipu9RZOcr24+JJtdXoA3gU5F0hIQrrG6+g8LQMF/WzQSbDA/5894
 GEZ6FcgmOFe4Zt0P4baTVQgo77LU4IglKkQpqwpgzbV8Ov45RHrsOuPRPusfvTYbde2i
 vmp04B8eHqqqtZ+HWJdP6p3jheyZUmG9zCIpX92pUzZvKWkJfA/hS+D91fLU8XwfkIwH
 /YFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdfQPC35hxDl0BYN5cH8DQWwr92Vp8EW1GbXWIrgDPlvE25//kZIThRCY/5jiXfnCt4lKuagU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxxUAWMJewGepK9YK7lvC5jvKrn+R/XtCX+nHPRqPY2J6eFY3qC
 uZCmvet63u1oJrBbbpcYjyPC7nNNG1kQQtl0kUIO2rHfKxKGcftAQHumb3uVisFFmIWN5b5DJP0
 ZxW7Kdk5qfw6hMYwB1YkJ8p1jZIC4SE/e8k1s6QOa9g==
X-Gm-Gg: AR+sD111zThsTmLJPkgsOT3lkJLMU3SU7ma2oYufRjBo0ZosOjUJGmMTNlYD6XpTF5w
 7sO0WgU4SZZlB31l+msUVxpRIOzdijlC40QwJssGNJen6jBpRhCwIUAuY2QFlAEnid6Eh3/8UhB
 euHr9LY9u/tFwt/jnugIlcomSVy4RhR1SP/if5bHMnI3lNjV2yHkQC9gJd+peu04ByThhtBzuv1
 gzzMgpzNOxHNVdTLhSszDVClouiZvFFtlB3+mPvZ9l1WXs8PX2PVb82x5/k/GWOOx10StjcQewi
 6LuYVl6UaT1cTKBeJp7htbVjCeHdAGf1d9JMRTRXca2mgX1+c8Iow7OyASyHbyKjN4NQTprfXTp
 p
X-Received: by 2002:a17:906:6296:b0:c15:b67b:523e with SMTP id
 a640c23a62f3a-c1fe7ef886dmr875764366b.19.1785764413208; Mon, 03 Aug 2026
 06:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
 <CAC_iWjJniUgONw47_WXAZZRsvrT_y6SJTyMLMOa+Hn9zy5BeFw@mail.gmail.com>
 <CALeDE9MOOjXRf4MAt=N-BmDdEQ522nQabEB7uoAcmf6t9fADQw@mail.gmail.com>
 <CAC_iWj+SD6axn-auG+rsE=c=0aaLDHaVv7jmS+1t4T_Y4BZ5zw@mail.gmail.com>
 <CAKTNdwHiNVy5rEYi9erzJ2E5EskZ8PsbCfvhxG-Y9c93j1hdSw@mail.gmail.com>
 <CAC_iWj+SbvzKB2ogB0AtGRzmG26HNZAMU0dQ0LVVLpuJhkLTaw@mail.gmail.com>
 <CAC_iWjJvdsuh+bn+2QVVhnAgPEGg+4d5YbeybMDqA490G-b=fg@mail.gmail.com>
In-Reply-To: <CAC_iWjJvdsuh+bn+2QVVhnAgPEGg+4d5YbeybMDqA490G-b=fg@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 3 Aug 2026 17:40:02 +0400
X-Gm-Features: AUfX_mzJMIOIDJBA9FOx7yozI5IEFQLgaA71mey00ylntWz689J7goWhoVZy9_0
Message-ID: <CAKTNdwGwkUdbn=nvti0y6kGk1Gbat2OipjEj5oCZzvdzUw=v5Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785764413; x=1786369213;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YYG8H5pXZUrwHasKah1E904wVnVm82puBqBoj7XTtmg=;
 b=ErilWIZZA28QcR7PYZRgsjkuJumQ9lZTxDhlR394xuYr461l0PQPwta19rvDrWVYQm
 g3UsGWLiqhe+bFgWZz6KNRLxAHfI4zjbQhp7earLUMLg6DapOp2SwPrxc/12ci1E3U0V
 IOFWskdgMb9l2K+SbvoNJqTkyI2eTpw0xOOo7QhSQtFwzccD3yReE59tANYtfxejgjqs
 su/hs1XDwU1MThcSQ5uFKzFdjzr615rUDCwg0JSjFl11U1wj5KYFfquGPPpXEim3nDwh
 I2tTDcNJkKP65Csz0imNhYnYtNE+/EMDwcO1TYXczoydBYzka/LhSo9wwZ/v1ojOtK41
 vG7Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ErilWIZZ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Aug 3, 2026 at 5:39=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hrmm,
>
> On Mon, 3 Aug 2026 at 16:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Mon, 3 Aug 2026 at 16:29, Alexey Charkov <alchark@flipper.net> wrote=
:
> > >
> > > On Mon, Aug 3, 2026 at 5:07=E2=80=AFPM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Mon, 3 Aug 2026 at 15:33, Peter Robinson <pbrobinson@gmail.com> =
wrote:
> > > > >
> > > > > On Mon, 3 Aug 2026 at 13:20, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.n=
et> wrote:
> > > > > > >
> > > > > > > Several GPT header fields are read without converting from
> > > > > > > little-endian, which is wrong on big-endian hosts.
> > > > > >
> > > > > > Probably because we got no BE architecture running EFI.
> > > > >
> > > > > Isn't the EFI spec explicitly LE?
> > > >
> > > > Ah yes, I forgot that part.
> > > > Alexey, you can drop that patch in v2
> > >
> > > Does that mean no BE system can ever have a GUID partition table on
> > > any disks relevant to U-Boot, including removable storage?
> > > It doesn't
> > > have to boot via EFI to benefit from GPT-formatted storage, does it?
> > >
> >
> > It doesn't but that's the EFI part of U-Boot we are changing here.
>
> Ok I was too fast on replying. You can keep this patch. It's not for
> the EFI loader.

Got it, thank you!

Best regards,
Alexey
