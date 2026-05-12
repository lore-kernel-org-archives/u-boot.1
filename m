Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DFFCD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A924836AC;
	Tue, 12 May 2026 21:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="ov7i/nCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3415783CD3; Tue, 12 May 2026 21:10:55 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F269F8341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso12306469a12.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613052; cv=none;
 d=google.com; s=arc-20240605;
 b=C7cCXjvgwgJN7YtbCJtv8qVNlI1qXkloIxmsJmeJCZ9qpmR04+VspWa25lJ1AKZS5W
 Q6XjUAx8wqe73KQ207R3tNKFTcVUDiTQBFUIA7POE4XYJP4VOMBilsXMR+u0/Uh7u4Dk
 kBY1VJOPQDtTogmLupvFfWtfKArJLdmVZzbVUUttyOcUpd53MVkXVcYW2iEZ5y86zspE
 UT+tKNy84TVMnvlQJ6PNlQhHVGxrFswj0GJnsFKfeIkHIKngEwwA8Dv2Jk1LpJAURIqB
 VgJwTqQ/HtHYTYGTYlMWede8FTHgTT3j+XkH3LkUBIpzI5y5qVFKB1s52LiLM6Ydxge5
 qrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DcM95zT3tqIaRgHVJvAUTEPYxP19YVy0C7lcGH0eIGM=;
 fh=irTjv1ICKVL4RK/3mKpZ6/UcR5bai5de/JLU+YBkX/Y=;
 b=ZDbVtmHHXlcmJ4bLMUMjjA+WrFQeDJtcRL90vClNion3Zceqx7lU0PE1xpT+ixvuPm
 88NMTPJdYodtLgSdy8t0cDq6KRWFkr1ft7PxYkahP/JMydwrnS+hzDWdRlxDZdM2bVOt
 0K0rN0xkDdHZ3bAwHmUeTGq6u3zSb77JJ94d5HCTus35nZt14pZRp4JpySErgKOXM2wX
 4/AUJHsKfZuyvFfSUasGUwHKtYmvQ1bfTSWt9TsOt2ACUqP4ZB35ydQVndG/2YIS99HP
 XPi/jmh+DI7tXJx9sxyaU89tbWaqbO4ZrBuUf6oT9M4epjaqJiP9TDNysDvZo3NKa/VM
 DyiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778613052; x=1779217852; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcM95zT3tqIaRgHVJvAUTEPYxP19YVy0C7lcGH0eIGM=;
 b=ov7i/nCqFsJpm150CuIkBKH4iderKnZKtNaAqjtnnmlc0Xul9z27YdKdx2pXC8VrwD
 Ib943j7eepqIjBnqp5Co7N22J4vtoeJ0YyeerSh+f79lpYNca5/8qkuuzeditScWwK14
 icAllkkQJ7eQcTkbgKIefRWhi3cNFzP5BqS7GAm1//VVSMvwNaM63yE0nhFmOiM9+4wA
 I28mLbs8LL4EYDhuTcE9GolN7iZu/4gRc7g1HZm+EZBc88AT0HwONxcpPrz0yOC/vhxD
 s2fJIFvXitDgbyI/v1MnWTv87j515LB3H+rkequOPYW5MjuiA7S7Vguax6pqWzrEdeL4
 J9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613052; x=1779217852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DcM95zT3tqIaRgHVJvAUTEPYxP19YVy0C7lcGH0eIGM=;
 b=fNwFV/VoEzpaj8ayk0wwGaW+ob29gznWbYm0XMEMjSb6xPDPXK9ZRu3YYbzN/aBBRW
 qyLsRdeIbC5ldocFoH02QCdOhSQMbT/3aLhk+8sIFGJ21i8CT9ZagU2tOD9+DistXwZT
 ypIYkxrYgsLElpLlLsy5o9WWKCuurlMnIPhvqTwMPVLTVuKYMZeI4MicLKqHZjazgtwV
 cJ5Rs16Koo8NhLO1PeJqfrA0dH+9yiqZO52uzUAuS5fV1lorDfWS1xQ0pBFKQip9SYQF
 B8rEyifyPf8Z+eDW9TkRzm3ebTGmave2Jpd+j7hrY55KEVdt6IbXmOMUaHSxNlwTA0wX
 37CA==
X-Gm-Message-State: AOJu0Yx5a6/GY17Sr0wCCyBe8NfbMmdcg82q2M58ibbUGT3/WFAYhjIU
 uSErJPOBKtevR+LYBdHbHmAgm4i6aYFmH361aYxR/YlkfteE7Af57NqE8AnNl0a2JNwDw7+TmGq
 cuHSVQeQ3XRNj+UXrzG2jqNsKzGliWxA3DVGdVyeoTw==
X-Gm-Gg: Acq92OH6ZCmY7rUG8axPkrpX57/IZiZhMpHKrIAiwcM4vs4BqYMkYOK6nE7l+uijCMA
 zas66jKEIQaph1GQBdsKgfxWP3jB2H8wRS0de00g8h/9TKaqfBdviwVhf/5jZZy/k6UbMske+cG
 mmqmGn2D0znC5V+RoWqbp1dpfjJ+v/2ZW4x1MDYCt00AjK42Zql4nj4FwF8Vl2lV4j7ZjBzqdJF
 MWa5UXnUJ2QTxT5CqfNSI1PZ7fIgpRY9pU6bE5HxklYT2yLc2kvXMu4NBBonsVWnOjBRfRObscK
 tjpSIiu6i3lpj+bhZY0q/ixwK/QJzsLktFsMYeFbPq5LAaYdqlE=
X-Received: by 2002:a17:907:3f86:b0:bd3:8be5:cf59 with SMTP id
 a640c23a62f3a-bd3add39c5fmr19276966b.12.1778613052099; Tue, 12 May 2026
 12:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-font6x8-v1-1-8cee71a7cc71@flipper.net>
 <20260512170938.GO1858239@bill-the-cat>
In-Reply-To: <20260512170938.GO1858239@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 12 May 2026 23:10:41 +0400
X-Gm-Features: AVHnY4IAf3qzy3iWQ6VCBYVulFgAlLSzKzMNuxnqFa3DXn8jyD9Jxh3z1QdtGnw
Message-ID: <CAKTNdwEQcCzwegbA83N-7uFh4F-24PD4UDon1PXGrdor38Ec6Q@mail.gmail.com>
Subject: Re: [PATCH] video console: add 6x8 console font from linux
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, May 12, 2026 at 9:09=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, May 12, 2026 at 04:38:14PM +0400, Alexey Charkov wrote:
>
> > Small screens on the order of 256x144 pixels can't fit much text at 8x1=
6,
> > and 4x6 is virtually illegible, so add an in-between 6x8 font from Linu=
x.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> The commit message needs to say what commit / release from Linux this is
> taken from, and since it's not obvious what file this is based on, that
> should be in the commit message and...

This is copied over from lib/fonts/font_6x8.c in the current Linux
master (the last change to the file was commit db65872b38dc
("lib/fonts: Remove internal symbols and macros from public header
file"), but the font data itself seems the same as in the original
commit e2028c8e6bf9 ("lib/fonts: add font 6x8 for OLED display") from
August 2020).

Will add it in v2.

> [snip]
> > diff --git a/include/video_font_6x8.h b/include/video_font_6x8.h
> > new file mode 100644
> > index 000000000000..c338377a0bd2
> > --- /dev/null
> > +++ b/include/video_font_6x8.h
> > @@ -0,0 +1,2574 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * 6x8 bitmap font from the Linux kernel adapted for U-boot video cons=
ole
> > + */
>
> here as well. Thanks!

Will do. Thanks for your feedback Tom!

Best regards,
Alexey
