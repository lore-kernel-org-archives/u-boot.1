Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DD1C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C9CF869B4;
	Tue, 15 Aug 2023 00:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kqy5HrKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78977869B4; Tue, 15 Aug 2023 00:43:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C19869B4
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52256241c50so6588769a12.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052978; x=1692657778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xDwB1NFJH3gMYoGJtp77wrw6JgQJFIqZ/Y1f48x2zIk=;
 b=Kqy5HrKUPXuEp3zTsMTofAOFubitHEpgEjFKay++kpCmdP3Tgj852EcbeTlGL2iBBm
 vaiqc5hyOKDOqRkdfqvTr/prvILsI0Hk3LSAN1YX/7yWIfpM7QHC63/63TLsGJjGJxOm
 IC/8Kqp8MgquWZUxllaAh2E01T0NtEpARaKqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052978; x=1692657778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xDwB1NFJH3gMYoGJtp77wrw6JgQJFIqZ/Y1f48x2zIk=;
 b=c1q6uqiqV2bpjw1sFyLzDQWDpSi/pf/rwJSnpr03QnwGpntQ9aMAHU3mtPgqpAJNEg
 BFKudFev1rI/i/OWYNvXpE/cOKMO+3Z2G/1ldGcyhEBWhzChLFE5bOo1mdRFglRRiJpd
 G59TQMroUoGMD1d2tr3NGzdo59md1thbrlUmjcSRyHKVQHJ3rM4FU1C+lRP+vv/XlFMW
 3tl9ghhEd2X43vXiVDafYfx5BvANopaxsA0eJmV9AsDuXokKFfo4pIEHTvS/AmyB8Esp
 AUuTP3uhrABCDPikcN6OlKm+NZXYnGq/5ouk/eErkj/joqPptQ8ehF2P+blSAY3LXklv
 3/OA==
X-Gm-Message-State: AOJu0Yx+QmlTtO1e/Bz5vXqUXbHkDfzTMWzOfp8jYCFu8Ui0jNjIad0T
 Vkn7G1eENOcNoC3pUnVPePX1A9Ocu0e/XuPtjQf2BWbKDphYmR8FBm0=
X-Google-Smtp-Source: AGHT+IGKOfSwSC3t2W5d/Wpf9+KKtJuSyJkggN/WiyW537GTtdNennMY4v1GRnZzdBwB5fNE1007OoZRpsKHY3p7Z9c=
X-Received: by 2002:aa7:d584:0:b0:522:1e24:afb6 with SMTP id
 r4-20020aa7d584000000b005221e24afb6mr8362395edq.0.1692052978068; Mon, 14 Aug
 2023 15:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230813201038.413362-1-sjg@chromium.org>
 <3a9a731f-15f8-02dd-b0d1-9626031e0c77@googlemail.com>
In-Reply-To: <3a9a731f-15f8-02dd-b0d1-9626031e0c77@googlemail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:42:46 -0600
Message-ID: <CAPnjgZ05xtrLQZiKC7t4NQvMJCAx2E7bu+LyPTqKjAmAPq-kwA@mail.gmail.com>
Subject: Re: [PATCH] x86: Update cbmem driver
To: Alex Sadovsky <nable.maininbox@googlemail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alex,

On Sun, 13 Aug 2023 at 21:03, Alex Sadovsky
<nable.maininbox@googlemail.com> wrote:
>
> Dear Simon and other developers,
> > -     cursor = cbmem_console_p->buffer_cursor++;
> > -     if (cursor < cbmem_console_p->buffer_size)
> > -             cbmem_console_p->buffer_body[cursor] = data;
> > +     pos = cons->cursor++;
> > +     if (pos < cons->size)
> > +             cons->body[pos] = data;
> While at it, is it OK to increment cons->cursor unconditionally,
> even when the buffer is full?
>
> It's better to do it after the check, isn't it? E.g.:
>
>         if (cons->cursor < cons->size)
>                 cons->body[cons->cursor++] = data;

I believe the original intent was to indicate that the buffer had
overflowed. But prompted by your review I took a look at the coreboot
implementation and it now has an overflow flag.

So I will send a v2 incorporating this.

Thanks,
Simon
