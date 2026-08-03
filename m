Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E700FC55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 13:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54F9680B3D;
	Mon,  3 Aug 2026 13:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g65jMY_cgZ_a; Mon,  3 Aug 2026 13:29:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96C0280ABB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785763772;
	bh=dnnvhXlHYe1Ki9J+/eD6KK8BzT1QxAbqv3Y4bhWoaeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyqst6hr2pGtg0WOuouhcnS6nMiq1ROtjRr20TOsmeJ7E6broQkM1RhMn6mABP2XO
	 j8a9WWx14OTB1YH59qt4YjJwAkYCyaUdThQOXikoGlQcd6K42Rx4FHOjFjq9ARx6Tx
	 x8YXSQx1ImomuclX9n76zO1wEBy/H6XtrIN0dp2FpJdimnrz/V3V2rpfuCBS5ULnD3
	 4xe7y3C3vfFsU/tYt3hrrMajtLTGT8LXIl19CPcLYmWZGaHAg9G1e84m3Rn1QrJ6Pt
	 0gZmsAQsdNvVSWNiir8eBCA+jMnEqEzW6x6M3nIxDOndieecAU4rcY2Ftq1pbE+Xe3
	 41A8WckN1AaNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96C0280ABB;
	Mon,  3 Aug 2026 13:29:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B07943A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1BC680ABB
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:29:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sb7ceBvrTHPy for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 13:29:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D09AA80A5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D09AA80A5C
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D09AA80A5C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:29:29 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c160420289bso507129466b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 06:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785763768; cv=none;
 d=google.com; s=arc-20260327;
 b=fF0I7xiJMok8WzV9U9NOKH4FGL+usy/1ERNh9YFUI4sVcCt38yGndRPWQzKHK4g//8
 V5ZQ1lp6t0u0UUPoAFrzRtU7CfFOcmgBXKtiyvP3A43l+4Cb/Vwm6+1ldrbL2SCJHzHO
 HRc2OXlmUmFqO5R743YoLFty+HFF2Jd5v8HvED8BjL6XcJmwS5iTqZ4eek9bTOpQ0kGE
 uzCvkl6utNZr3/4yMzx125NEcfuq5dDxmMlC24ihcbsnYgIywRT9zrISsdXVXkcGAvdL
 /IlNXjWjG8D9uLdj0gNF9DOBPcnzWSQtDRbfXrCLueYa25rbXeFaP7X1beQacKYxTDhJ
 E1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dnnvhXlHYe1Ki9J+/eD6KK8BzT1QxAbqv3Y4bhWoaeM=;
 fh=LvpZ4HDtMB/OchJXxxrNqOQ36qbRTFF7MqYqOQzHZGo=;
 b=PjCo9hesuTge4/M0ygiBQzK0pdrX30lZoWB2xAH4rx1RZi79d6Sofk+l8Sgh74bxed
 /dFYCpl6HYlUu/V/tiANXRLbC/uEmhaZQh4IRiwNd5+uXILqyH+h2fvJsfhFSyIjPa1z
 rsNOnPocU7XgdV1NtgWxpcJl1GsyJjOyBnDpsbkDH2fwp1P0adsHpNYNzZKcPXYL1u/e
 dTpsfCvpzLbSBDF9aJQcJLOnAl/5p+9QpR5CNfyVf0dmRZqT+Z2fEfXBlrSz5YEQQyiH
 4FpUM5zKG0LCjCyr18mVTarXuXEgN66Ranu+Ug9X6tmy3ICEBfXwHj5I+NPibNUv9rDv
 dlCg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763768; x=1786368568;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dnnvhXlHYe1Ki9J+/eD6KK8BzT1QxAbqv3Y4bhWoaeM=;
 b=nYnAc0vDbo8cGWmDqr8aqa7kfp5LiGihzZMJ7HmvSgI+5c23cw4rhdQpyne8MdrxYi
 OJ/vkblUjRUuFQ0xU+dJ7zuTyyoc28h8SA1sNPLBG+aHlqsaLOcasguq6wKspLxAVLSs
 omW598vmVvk68Gy0/j4eWKJOFI2f6dVKFSxCOvsygoud1C+1pA28+vZrZfuLoVDckcwn
 GEqbXgSG1ckuPCamzXbEYErgK2nqoyIutoroNjpyuvvI7NxorPfcyAW+GhesvDR75Xxs
 XZK2kRXFuj1zohqOUBUP9uldsm/+dFpAKA4d9amjXGeOeLUQKqOwNLn/CNXKzF3nAvUX
 Kbrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwOGU6e/phb9+iD7ZpZDUHwhYoZJmFlV5cvPgLLrQwIVgQUEMdAqy77KwubVavgQku8oE8GI4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzvznFWd/zc6wtoGOqykmXNam5QSq2FDOLXmltgmR2FOvDBiOpQ
 EUrzK4y1DO0RaZUtffg2qLiuBEg1guM75SoK3NgFg4HVr1RRVH6DcFlTFO2vBPkfTcZ6kuois9o
 b6ObEmIorV2prg3ZPHLEI3NmPeYh0N8v0nLOfyhWrpA==
X-Gm-Gg: AR+sD12u8bebEJLnHom7Kq9VmTKy+bC+CCCCqms/ptfyuIadw69DY85Vz0wKio1dT12
 wLwDm1c2ud+2gi1/UwuOB43i9DQzQ8Z1NXI5m2pdDFRvPmRqCBozKQP3UJ46uT/dxHw9u2/mK/J
 UrbkEt5mGkHx5IH/Z12A4Tyhn8xogbdGJxlwvlK9vQJC1L8FJe7yzHRAJDesL/N72WJd+u+UXhp
 ObZaYmjn4TFdPwkFF2XjijAAOBrcbO03gPtVoMsXEo5VevfOhybhHcH9FrflcbYW4o0pe7Ds63I
 iqyIxqupX0irXCIdvdOLHZAWcdyRzrdwcFx9B9e0boreg0ZuIUMob9bEfAxNMrzI82Z4/UfDlTk
 T
X-Received: by 2002:a17:906:fe46:b0:c15:fd85:c5f7 with SMTP id
 a640c23a62f3a-c1fe7eebd21mr913338166b.4.1785763767846; Mon, 03 Aug 2026
 06:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
 <CAC_iWjJniUgONw47_WXAZZRsvrT_y6SJTyMLMOa+Hn9zy5BeFw@mail.gmail.com>
 <CALeDE9MOOjXRf4MAt=N-BmDdEQ522nQabEB7uoAcmf6t9fADQw@mail.gmail.com>
 <CAC_iWj+SD6axn-auG+rsE=c=0aaLDHaVv7jmS+1t4T_Y4BZ5zw@mail.gmail.com>
In-Reply-To: <CAC_iWj+SD6axn-auG+rsE=c=0aaLDHaVv7jmS+1t4T_Y4BZ5zw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 3 Aug 2026 17:29:17 +0400
X-Gm-Features: AUfX_mxixa8Din5y4LFtLQqX1ADvWNdv7hran6I9KJ5OaLxFYgihtgeW57Ur7l8
Message-ID: <CAKTNdwHiNVy5rEYi9erzJ2E5EskZ8PsbCfvhxG-Y9c93j1hdSw@mail.gmail.com>
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
 d=flipper.net; s=google; t=1785763768; x=1786368568;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dnnvhXlHYe1Ki9J+/eD6KK8BzT1QxAbqv3Y4bhWoaeM=;
 b=XBk5s1xQzL3tTQwkgMK6mJOc9Kbl65mEbBsfbTM/bPJhdlAzTIHijj0eVSZ37lcyc8
 h7MTDnxvdN3JGYySMTV9kjNd2SwzG7HopJWCIQBXj6wIEMcbVetg4tXxZs85z4pBM/vD
 kECq2GIJSevvsnVlcXqnqhnSQpu/2M14IRJAYl7STq8eZt6kdlRrgZzGSIqPX0wxoS3o
 0c5jdHM9pNEL5V6fDEZnTK2qqpKXQj4RC8gODzV/NfgkxWhetipgSOuDiLBIgbLQIAGL
 K4TLRT0R8fyzF4j2T1Osw0+AvCIJcaZ3eVWdRxCfjiTW6aS941hNFZ3OfLlZwAHK2SL5
 Augw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=XBk5s1xQ
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

On Mon, Aug 3, 2026 at 5:07=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 3 Aug 2026 at 15:33, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Mon, 3 Aug 2026 at 13:20, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net> wr=
ote:
> > > >
> > > > Several GPT header fields are read without converting from
> > > > little-endian, which is wrong on big-endian hosts.
> > >
> > > Probably because we got no BE architecture running EFI.
> >
> > Isn't the EFI spec explicitly LE?
>
> Ah yes, I forgot that part.
> Alexey, you can drop that patch in v2

Does that mean no BE system can ever have a GUID partition table on
any disks relevant to U-Boot, including removable storage? It doesn't
have to boot via EFI to benefit from GPT-formatted storage, does it?

Best regards,
Alexey
