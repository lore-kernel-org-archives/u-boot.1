Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD36CDE00B
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 23:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6C5847C8;
	Fri, 26 Jun 2026 01:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LqSa6PVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19BEC8495B; Fri, 26 Jun 2026 01:21:15 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08F884704
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 01:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ranquet.guillaume@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-845a3c05df9so253432b3a.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782429671; cv=none;
 d=google.com; s=arc-20260327;
 b=Hc8mwerhR2gY7j0PnGKu0wwEoU1aKGm2nxMHQRo5j4ycpODKHk8Pt2sP71eEpxdHaN
 m3/nHKf7FkPeUTwcm02lqtsoG2UCpF59KpYvZCUV4Y7v29MiJau3RX+xFpdi7yWNrHhM
 7KnU6TQbjewfpKrNTIeGa975Z9u696J0zjqe2jIPL6KmjXXYhDxnHRt3mjnhYQeYQhx6
 Ka05F7HfcWw0ZTWx88/iG/URyBjJJjQkOy7jHrWAvcqw0M5VbuwtJr+eUHZvAHXhsmyq
 3b+feakGTbQUHrgYD6YaZ24u0yebBd+wvQf4B+w7/wW3JTmvft6FlPY3fTGVDK60DbU5
 d32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I6Lq8KBarNfaGEwd8vX0fpdbdg4O69DQimS0NZidUpY=;
 fh=hP/jyqAwf7hxPVrsAw/NgyE2DJX3fvHQgN1JQZJMyPI=;
 b=GbFdCs/YFRhs68baV+1+WkHnEXp0ynz8dKi5W5+/dHOkc6fPOm34+VoXcsmdW5NZUV
 jhq/gFmwm6rNqeyJNzwUa+LwzINI+Y9rxxh6wS53wC83H02t4VOGHjk6jflDxpzFf+hs
 AbOvBNoL5Jf4gCmxJMK4BpAjbT9832/+UXcMDsGo8G16IV9ggAOGQBFhwI9qE+kyqa/7
 Z/fup4eDtIC07jp5HtTX+UybUZ2egGCtURthVTzlg9srEO1mgl9YRnPlnV4hpLq54LyS
 mXsJhZrn2O79xbUD1olXf9cz2EIxOKV1nrZfBQES1k82xvE5QkgtQOFR+GxAuguLuKxw
 SwoQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782429671; x=1783034471; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6Lq8KBarNfaGEwd8vX0fpdbdg4O69DQimS0NZidUpY=;
 b=LqSa6PVR6O510C36q1S/GBfQ+KNoOTJmVtZSLv8apbyXMrL4xtu8l2iOYZtoDV2zex
 KqzWNCnRGT7XQxLzdH7CvcfjKr16KsJPFPZD3faWAvUzl46WTNQxho+xhyf5wnpoY9gA
 wupVyRQVLEJmAfKlfcD++KVG4Q1Hg+7trtCbuQIDsDkjN6snoMscH3kKZ7+g6LjXAaWJ
 LWyWCxUa53WBNfvFc5eRmr1G0YMeuDSoEp4aHMjjA0Y9doKi+y0lcgs6Af7blQEZZ+9D
 ODAySyEcFaS58ekAE4NdOrVyTUCynisecN0tzAKaLv7EEzuqIx9QYBfmzCXVB7P3cN+7
 XbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782429671; x=1783034471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6Lq8KBarNfaGEwd8vX0fpdbdg4O69DQimS0NZidUpY=;
 b=jnKtPLWN8BM7/bUd7lfi5AnAYxr1EoOvUefqCIJ7GBDHISEOQQtxL/dwfnDkO0zu/o
 qD7ellD2zMprbkuqe8iPT0CTc7BUtfkK3UW8N90Kq/JhMPKNzJ33uGaNkg7Gm+I/jmCi
 MBpbOjcGxDnLNxxlNfW+JJ7ApDOg5XbfnFiSfVe6ZFQtsN/TC/kGxZLlAWurAB40ZSSp
 tHIBv8PTgYZ41hziLeQ/V3uQp7ftYA6uABbwLxQgOcZj/a/mcOC+ykwOztGRe33npEcn
 u8JBjgB9LhGyc5SHebMXBj7FgcRFgAxZyz8m42yuIFQ4/EDkyzao+X4cw8DFc31XbtAh
 W34Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLap1uuPU0iMzAKYavO2Fe5T8iUMz4fjscc8t0UzinIGg0KHQZYzdyyRxazOSmItK0CAh47I8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyra+PDuw/F8jqldGf/6v88hA3nIpXcHsUxEt5MLpsvf3gB+Q0z
 nTC7XAqLVtLmqZZwVwMYpugISsux37ABAfwg5OmXmOYMF7Vj6humeBs8stHfEEVM217P1N/GUiu
 xAIBrC+QX3rLku+CQs9jkTYlJkPCoOb0=
X-Gm-Gg: AfdE7cl4WOaZRpmICc7Un45msJCCyqPG5wf4eXNq2g8zx8exaj715OVF49FocRrcIEG
 IuKb+acSbvOnC5/ibigfU2x/PZGHY6l0KA7AcmF9oLxB6uM/SfkwVsh49Maapnr/rCJcctrWQnE
 vGTjCjn3ezlb2qfsJODVZCA6bhqKkiF+6XTlWYzVJrGGtOkm+uXwfUh0/gDL7raoZwIWj+iDDy6
 ULaeGwiLhN4eaFLwJ/EdDeBLXMP2GCzoVB1vYWBbJxhsBmFAQEefO1VQaAXk824gjoxPtj4mFY=
X-Received: by 2002:a05:6a00:3a03:b0:845:3914:f039 with SMTP id
 d2e1a72fcca58-845b3b6766bmr5486883b3a.26.1782429671235; Thu, 25 Jun 2026
 16:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
 <4D95B3CE-66CD-45E0-9DB8-2CDD45622920@gmx.de>
 <CAFLszThvYf0=ebaGqprxy7unbVomC+tu-5uQM2auEZeiNCZpmA@mail.gmail.com>
 <CAD+NunbVCgmyUdfd4WX+i8iZZ4FZy5bwBRdrvsH4B6us9gqwfQ@mail.gmail.com>
 <CAFLszTh6+tKdfSWNzKAfyCb67a0U+m7A3YEaOhS3HXZHcPBvyQ@mail.gmail.com>
In-Reply-To: <CAFLszTh6+tKdfSWNzKAfyCb67a0U+m7A3YEaOhS3HXZHcPBvyQ@mail.gmail.com>
From: ranquet guillaume <ranquet.guillaume@gmail.com>
Date: Fri, 26 Jun 2026 01:20:58 +0200
X-Gm-Features: AVVi8Cd_727D3dVwQKkXI1k6-gfG52cY1Hifpqweg55ldJc0XEf96FBizF02Cr4
Message-ID: <CAD+NunbsGzaH=YKx=Q0MG4QWmPX7RwbQmpuGb=Px+eVXcQpaEg@mail.gmail.com>
Subject: Re: [PATCH v2] arch/x86/lib: implement cmdline configuration property
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Guillaume Ranquet <granquet@missingno.tech>
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

On Mon, Apr 13, 2026 at 3:36=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Guillaume,
>
> On Mon, 13 Apr 2026 at 04:48, Guillaume Ranquet
> <ranquet.guillaume@gmail.com> wrote:
> >
> > On Sun, 12 Apr 2026 13:37, Simon Glass <sjg@chromium.org> wrote:
> > >Hi,
> > >
> > >On Sat, 11 Apr 2026 at 05:25, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > >>
> > >> Am 3. April 2026 16:28:23 MESZ schrieb Guillaume Ranquet <ranquet.gu=
illaume@gmail.com>:
> > >> >Implement the cmdline configuration property as described in the sp=
ec
> > >> >[1]
> > >>
> > >>
> > >> I can't see in the spec that the command line property is x86 specif=
ic. Why would you try to implement it in arch/x86?
> > >>
> > >
> > >This is a little tricky though. It could perhaps be handled in
> > >bootm_process_cmdline_env() by setting bootargs. Both legacy bootm and
> > >bootstd (via the on_bootargs callback) would then pick it up without
> > >any arch-specific code. But I haven't tried it. Commands like
> > >'bootflow cmdline set' need to continue to operate as now.
> > >
> > >Regards,
> > >Simon
> > >
> >
> > Indeed, I've looked at implementing this in a generic way but it
> > requires a bit of massaging to get things working.
> >
> > I was also under the impression that no one in their right mind would
> > use the command line property if they had access to a device tree?
> >
> > Tell me if you think I should propose a generic implementation?
>
> I'm happy with what you have for now, so I'll leave this to Heinrich.

Hi Heinrich,
Any feedback on this?

Thx,
Guillaume.
>
> Regards,
> Simon
