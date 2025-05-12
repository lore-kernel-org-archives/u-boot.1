Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7124C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FAA805D7;
	Mon, 12 May 2025 11:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dbxr+iDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EB28091A; Mon, 12 May 2025 11:00:13 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B5A280050
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5fd0d383b32so2397745a12.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747040409; x=1747645209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RYbB8yvsL9FUF+o47spUR3iIxmWTbZFl3UDGXbkCeyU=;
 b=Dbxr+iDp79Ma8de4mwd5KBfUXq+MUpcdRELH/G0GzDPFEXPoYVFZi3GgETMA6+2iA3
 M8N/DHi7KTBGO6KpXa6IxTZrrij5pGia1pulKi4hG4fYHEP0FO2osP+aglNOrPW//VlK
 Hk5NrM25461WosFrXaT+TkA4Ug4Xhvd+faVEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747040409; x=1747645209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RYbB8yvsL9FUF+o47spUR3iIxmWTbZFl3UDGXbkCeyU=;
 b=LPPEqGZHMHBp6dcIYsPhWDuRZl0WIwMCQ24ly9DdCfY+l6jLmGEoa5QHdDNDmz7e8P
 SaQhuPbpw3qbr/taGI/+t4BLaC1Mptp7EqSuRZzwZz0qdZNtYlZVmjlACUjrQt5/Odbu
 FXMDZdvkkog0DHkm/tnstEvfslmCGe3cn/Me0x9+Eg9eQzLSdvdgnw7at98Lepk0o3MN
 dsn4ej/f/CV5Uef46/exEqQ4Zfa+obCtPhH1Z3sVGjBz/Ip8ZGlbILE9mWWimCAcfsHS
 4WvL8mtLVNRUzPpvXCaGzLH804k0x0S4a/ZXmi+CUnxGj4G2l6xPNdfWkI4z3mof8Utp
 LOhQ==
X-Gm-Message-State: AOJu0Ywron4Kej76HQPnr/VYuxBxySbGDUcNH8JsRoUOg1ID0KJcTjtC
 B/Fms9NloILwJqR/aj7wx5VsrRsFdRREownZtvbJnDfgOD/ioHCLuF6AYDGN8rE/Et7fiwaxMfB
 RzcALQsFQBTdoffKdk1v6C2e7KabfD0oS9akt
X-Gm-Gg: ASbGncubHJmqu8/aYRaOjtGxVyLX7ppvlWJScUfZf/BZhu/OQEYzX7sWjoX+U2C9wIA
 AhmfUN6qyYbj+XSdKJtAw+8Go6OJzBQG2pj8dFTtt7yIDozaS45/3SpsZ6PHPMI4FGeIWemTzpp
 daHX85xscIYQ8jtLGo4/Hd9JyHfCbUT7K7egnkHtET5/a4
X-Google-Smtp-Source: AGHT+IEfqMO1wCyXiTkOAl4T+JfiNUWKMRJmmePryynUOyu7sOjUWI5dLCsWJ/TjTxRFQ9qRgQCEvl+cl1oexb43v18=
X-Received: by 2002:a05:6402:2711:b0:5fd:1a42:17b0 with SMTP id
 4fb4d7f45d1cf-5fd1a421bc4mr5034599a12.9.1747040408799; Mon, 12 May 2025
 02:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250511141828.2367318-1-sjg@chromium.org>
 <20250511143915.GN603748@bill-the-cat>
In-Reply-To: <20250511143915.GN603748@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 May 2025 10:59:56 +0200
X-Gm-Features: AX0GCFvQfckBgRCa8pBrX3XZMasyX962o8zeRaU3zV7FnInMxtnOhFIdyUGRVcc
Message-ID: <CAFLszTgPsnCxGjh3Y6rLotuMSocTHrMzE0VAoUw_8VVFeh4XSQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] script: Improve the QEMU scripts to Python
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Richard Weinberger <richard@nod.at>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
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

Hi Tom,

On Sun, 11 May 2025 at 16:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, May 11, 2025 at 04:18:15PM +0200, Simon Glass wrote:
>
> > This series updates the two QEMU scripts available in U-Boot:
> >
> > - Converts build-qemu to Python
> > - Converts build-efi to avoid sudo (unless SCT is used)
> > - Introduces a proper settings file shared between both scripts
> >
> > It also includes a few documentation updates.
> >
> > The next step is to get these scripts running in CI.
>
> This extends the anti-pattern of "one big repository for everything"
> while also expanding upon the scripting that I already said I don't want
> in mainline and I thought you were going to maintain in the
> u-boot-contrib repository instead.

Apart from the philosophical side, your original complaint was about
use of sudo which I have mostly resolved. If you are worried about the
size of the repo, these files are small and the repo is already big;
in fact it grew nearly 30% in the last year.

Another comment you had was about CVEs, but I'm not sure it is
relevant in this case. I suspect we could find another way to make
UEFI SCT work than mounting a loopback device. In fact I was hoping
that Linaro might get SCT running in CI.

Anyway, yes, I did add a script in your contrib repo [1] . But then I
decided to see what others would do. It has been three months now and
I haven't seen any contributions to it. So it may actually be that no
one sees any value in it. I would like people to use and extend these
scripts, e.g. for RISC-V and for booting other OSes. I very much doubt
anything like that will happen in contrib/ but we can keep an eye on
it and perhaps I will be wrong.

I'd like to suggest that you consider another PoV on this. If contrib/
becomes a thriving marketplace, we can always delete the scripts from
the tree.

Regards,
Simon

[1] https://source.denx.de/u-boot/u-boot-extras/-/tree/master/contrib?ref_type=heads
