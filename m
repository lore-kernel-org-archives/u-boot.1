Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27189C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 07:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71629829E7;
	Wed, 30 Apr 2025 09:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WA1IbYIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CB382AFC; Wed, 30 Apr 2025 09:44:44 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0DE8216C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6f4e3618437so35598366d6.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745999081; x=1746603881; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOwFNjw4UGbzstvTDP++3di0pkYKAeY58A2klB6AyjQ=;
 b=WA1IbYIhPnvsq/adcFkfHw/Re2PCs2HHPglCtR2Q+SP+QywPPvcBUaqCegkMyeO672
 uwpzn3BMF42+jylNhB2PhtA6n7JUvU4tG+Dm3hXnqW1UFKRXuQIOzgDgzqbWVsH8rxWM
 rfqIF9UDHWiFckuHNDNk61Z3w+sWfTRMzRghCB9WLAg6fwLFBPOZ5ISz97K9txb3uzkK
 vUpC/iIOOBBLmU8WeUEnALOEBklmpKMt6tmrcCKHtRxroU8BEVHkHbgp5BHsrflhjjvv
 MPqn8DIy0v9LJUjHIWP68rjHa2ni85LG9Yhe0WTw98zLD6xydxpAcPBFNNToboxGNHU5
 c9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745999081; x=1746603881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wOwFNjw4UGbzstvTDP++3di0pkYKAeY58A2klB6AyjQ=;
 b=ph3E9B/bFrKFfVAAs86pbtgdpzbCmJe8N8mHMWsjg7Hq/cizV+NyGV6hJsxl6Sh3St
 /TmAL4QsDRggVlGMh93z23OlVhCblGbkgqNMOdVkF3+YxIekhylNVfIQwL7VAGBhJbd/
 ilggx4JadMKzp87jwoTsergnfgoftHKv3HeRMNhOvhzOpuzGLbRP+6SZvZczab3yi4+f
 8+hwFe1Gk0LzrnFA6RhgnlBY4mtVBSeKotsKzk2tXDM4r0lfcwhR10qSotWieaWAxyUI
 UknR7r0uZUlKxoMyLTlmR7hjK+dc5D1PgC0jrRDs3mVrlmgsr7pJKywMZtLmQZKvI7I3
 Fvlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtTU0j3OlViz3TnWjWkG7/liLagdv87lmGxpRiJj9H5KFMo6XhW542LKJraxcCNNkT6t9cl4o=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8Cnztx46+MC7BoLedcZ22dah6A03K6kvdJuzaWZauK3swkWv+
 15P7rGs8vdk6p2At6T6+6z33AXMrKc5I+ebox5Mn3EHNa6WoexrQ0Hd3ud/npQEO6LIm1uQX5RZ
 BNf7mfzNTTwZqMjJHNnpP+52FIXM=
X-Gm-Gg: ASbGncvDuvXBkJB11bIFSaDPcalC74sboJUAOY5aLSjh1rXobaEGmU7hSDFHbNl8rxI
 irQ6paJNquia4j2wSQY+PbXHptWNK/RvqqNDuAVr1IYRAdDntGC7bLNgnZ8XUpQaDw+ONfcB+J6
 isZKTRsKWHD+DH7nvHKRnBSQ==
X-Google-Smtp-Source: AGHT+IGl2Mcu1l8knfyO5lFf/Wh+ytnPF9m2XZnSMFlfqEsHUkCEaN2A4YcVDHSNMhJa3ZdvgYFBkv97MYy1d50UDbM=
X-Received: by 2002:ad4:5ecd:0:b0:6ee:ba58:e099 with SMTP id
 6a1803df08f44-6f4fce977femr39909086d6.15.1745999081438; Wed, 30 Apr 2025
 00:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250315092420.793-1-ansuelsmth@gmail.com>
 <67f42db9.050a0220.16b640.abd2@mx.google.com>
 <CAOf5uwkU_hTEa_D+pEouXmsiQYMTNkHdr+z0boVO43BW7wkA7g@mail.gmail.com>
 <CAOMZO5BFntJ4kFFrtrFRL77RsM18LtjJDv1kHWSZViZMW1m3XQ@mail.gmail.com>
 <CAOf5uw=Sueqm+5XbqpjVJFVzLRnHZZyU6hV+=07DDXSEqqwApg@mail.gmail.com>
In-Reply-To: <CAOf5uw=Sueqm+5XbqpjVJFVzLRnHZZyU6hV+=07DDXSEqqwApg@mail.gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Wed, 30 Apr 2025 09:44:29 +0200
X-Gm-Features: ATxdqUFNymya7J1RTzxl3i9XMf9K_M8rI3DXndRQZgGfXrfcDce2FRbdtBq1hm4
Message-ID: <CA+_ehUyDtCpfPhRe57a5AD99kszxfJ-xmaGV_ZE+4QaxeBJTEA@mail.gmail.com>
Subject: Re: [RESEND PATCH] clk: fix crash on clk_set_rate clean rate cache
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Tero Kristo <t-kristo@ti.com>,
 U-Boot-Denx <u-boot@lists.denx.de>
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

Il giorno mar 8 apr 2025 alle ore 07:56 Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> ha scritto:
>
> Hi
>
> Il lun 7 apr 2025, 22:03 Fabio Estevam <festevam@gmail.com> ha scritto:
>>
>> On Mon, Apr 7, 2025 at 4:58=E2=80=AFPM Michael Nazzareno Trimarchi
>> <michael@amarulasolutions.com> wrote:
>>
>> > Can you review it and pick if needed?
>>
>> This is not assigned to me in patchwork as it is not i.MX related.
>>
>> Someone else needs to handle it.
>

Any news for this? Maybe Tom can ping some maintainers for this fix?
