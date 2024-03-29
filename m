Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3B7C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 12:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE4E881E5;
	Fri, 29 Mar 2024 13:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WWz99H0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1109488233; Fri, 29 Mar 2024 13:54:55 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20486880A1
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 13:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d48f03a8bbso25680581fa.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711716892; x=1712321692; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p4dhfI3uUZmeiRFbMvxo3et5Ex5AH9wASHxIMl1A9YU=;
 b=WWz99H0DlCRRqTRpf7RRaXtLkwAB+JcROLC6EqQ8gGk6jtA7GF+v03tfOK4eV0/Grx
 rlkmzPDyMs+5XEOg09v8kqakrx3kBv32VAeCn4X2W6jz9+a2LzwYLlP5/Sx8FYkPKmI/
 I7lNocYB5Obr3rqgFwfU7b2GleJpE8k2rJ+C1MyvPQ2YbzsyRI2YDhsLoOtxbvZeqTVz
 /bzN2yS15Il2tjuS+A4DOCPC0tKUghQB6msaiTm1LRYxNw9zsFsLhlNNciNLJW8BByeL
 yLWbhQRHkhL5smVZrbuSbneMRRLm7CZ6EapXYXf4VvTECbV/U3PORqL/MuZZYZqgCLTn
 8DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711716892; x=1712321692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p4dhfI3uUZmeiRFbMvxo3et5Ex5AH9wASHxIMl1A9YU=;
 b=EICPX84jOw91QtOwlyXBpLOy5EoebitiKkY9m04dJn6vtzeMdl0pfcl763I64aC2/7
 2h6u4ggGKt5f/nMrqCOJCt6266VAWBEC2zzPrc+qWrjltPE24O65UBFM4prLl6TiYIxB
 oYmyGcPf0atkJ4DHDoJzrxn3jsEdFIKKN+Kr+wr67eteJU6//nqmRr7C0cWSb1KFx2Wc
 DqspLu5HA5UO/a6cSCGWg+F/1iV40lYhljPnA1UdtRCBRSLdjKSjmjS5XmZyP/HWTr+Z
 kRgmp/jYOgZBRPZLORQRyu3QwMDKVrkbGZGanVZdn533pEjV8tr/Voszm1uBL66Q1sw2
 8RwA==
X-Gm-Message-State: AOJu0YzrgGHYrwRU22Pa62ipgTn+f935tfpkYPIsYfR/9SjE2tqgw1Bo
 8nJwXy7p4aEhDnJL+6iYT4j6AIU00mOHvUvVEofFUmi6nmHGHhV08qnN/tVAu1hA5cfiCIH5Izz
 5wXXDB6IJeGsgjzLe5YolChVziEkdCoNf8yu5MA==
X-Google-Smtp-Source: AGHT+IGHtoyMuOSZ25bsnswlk3rNkpopaTungh+tO9J/EUSEgKR0CpoXSfUbiohqLTn/u2SzHk2qFluNpZCMjz5nTPA=
X-Received: by 2002:a2e:b81b:0:b0:2d6:dd34:d38 with SMTP id
 u27-20020a2eb81b000000b002d6dd340d38mr801760ljo.17.1711716892412; Fri, 29 Mar
 2024 05:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240329071929.2461441-1-ilias.apalodimas@linaro.org>
 <7b9afe57-7454-49d9-930e-abcaa829b0d9@gmx.de>
 <CAC_iWjKS16PCDYmpmsRabpaAeV=7Q0NS+jPVJZLSYduqEReQvQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKS16PCDYmpmsRabpaAeV=7Q0NS+jPVJZLSYduqEReQvQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Mar 2024 14:54:15 +0200
Message-ID: <CAC_iWjKhyAeuOrgi68=O+-Ssth9zX2GBwbXJgFqJApWfvpFDnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] efi_loader: conditionally enable SetvariableRT
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, caleb.connolly@linaro.org, 
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, pbrobinson@gmail.com, kettenis@openbsd.org, 
 ardb@kernel.org
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

Hi Heinrich,



>
> >
> > > +     struct efi_var_entry *var;
> > > +     efi_uintn_t ret;
> > > +     bool append, delete;
> > > +     u64 time = 0;
> > > +
> > > +     /* Authenticated variables are not supported */
> > > +     if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
> >
> > Adding EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS here would make it
> > clearer that all authenticated variables are unsupported.

Looking at this again, I already prevent
EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS unconditionally in
efi_check_setvariable() since its deprecated. So I'll keep this as is

Cheers
/Ilias
