Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D75E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 21:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA7A80141;
	Thu, 12 Dec 2024 22:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NQ2Hieyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1258018E; Thu, 12 Dec 2024 22:46:27 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81C180137
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 22:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6f277a1ecfdso3613797b3.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 13:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734039983; x=1734644783; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3BP2ahSGgEqYxIo/WqGSc+8UvtDuYBtL7GgvdOtkNY=;
 b=NQ2HieyhmVEuPUckyl8H0g/s1Th4e5ys9dlQP7btlD4aTuwL+kcnLJZQS84tGkvVoj
 +pr80QidUYoa1neVgJ28gm3+/tamVq3+xCyn4h+cdTK+0H/FkjBwzODgu4LVoGRB2Yby
 vP0fQyv5P8aHC8DdV4D07mz6w+AVlOd2ZpHXfmsAo3nA/uPr+/Ms0H+HzcVG18Kzb42G
 WfNt5nWpoYWE2GR+fVY+4J9UXw+JE2B9q3K+W3eBsCpdo0P4ilBrj3WfqaEYisWcNWAM
 RDbw3wbrfxMVR2kAJ+Tw/NwsyemAWgWo6IBTU5uDbHxdS53zTig/ZT9BSJxB8DlJNj9c
 TVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734039983; x=1734644783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3BP2ahSGgEqYxIo/WqGSc+8UvtDuYBtL7GgvdOtkNY=;
 b=riDGFnG7oRJLwJJcwRSKL9tT3lLNhDOuHh+86IQNcds98t+hDfrR2jUNFEYxLyTlSk
 azSrqO7zJMkFyTSS+pZ4joPWMoH1stVITB4aofMMheYDflsL3rEiy9OHoeO8BXCChcj9
 hyIhPtkqLipdqESGjU/ulTJuOX0reY4zov9IE4l7KwFVYG+Kf4fW8ZPIAy6wpe+kxoVd
 ZzmnwWEEkIAU1enMwKXM8hxim8n0EUAxY9zqvoLE2jx+qF965g00NBilljx4NKnbHEDu
 tx3Szy4g9m2yZcAD9IDpi9hrNJZIpV2zBq4qj1tcODh+DvC8ARgqdwU3KS5WhUdws6Or
 38YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2FT6HvwPjHh5Y/7Z2kYC1PWkaDXv/GrlT8k9ybP37pKq3fkFzDtV2b6QLNvYudWBHP63aLhY=@lists.denx.de
X-Gm-Message-State: AOJu0YzKlKn/idwWWrR+Mi5Tf7LtcKXN41f4Pkyj19mvYhPpL5ZIRG51
 XzY1x8J6roKEgHafdAyhDeh/bMf96a349xFgRLTOQ2NeQEBYUcsPm87RczttJ2n2A/5bxIJ3dpF
 PuI/UMzNqo7BJ+s0lnOzbf3q6K5bKcplI01wC4g==
X-Gm-Gg: ASbGncv5vDeEggFRFO106SDaAQHoAUdX6mN85uyZiMVGQLBQ6lurAY3NuHXQzzaWAmA
 PVj9eMkY6h1a7INKLj1su7WnbbCPnPEBsa1ETDw==
X-Google-Smtp-Source: AGHT+IFhqnbs5cUUmUnEOzRJ+tIe4DI5vsVHVpLG3THgT7EveOvaOwRaHbDkm1smXoR1J7tdu+JRy2vsd4CdTldv3IM=
X-Received: by 2002:a05:690c:3392:b0:6ef:7290:d482 with SMTP id
 00721157ae682-6f279b23667mr3106257b3.22.1734039983626; Thu, 12 Dec 2024
 13:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <CAPLW+4nTJ-hPA6d6PD5siVkW3VcbDkPbkmujVe5rAqFCPfUGFQ@mail.gmail.com>
In-Reply-To: <CAPLW+4nTJ-hPA6d6PD5siVkW3VcbDkPbkmujVe5rAqFCPfUGFQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 15:46:12 -0600
Message-ID: <CAPLW+4=ByMMrzm7iSbf5Ouqm8c+cEe00AJQ1Z2Mc6C13qKhfDg@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Cleanup the LMB subsystem
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Nam Cao <namcao@linutronix.de>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Thu, Dec 12, 2024 at 3:30=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> Hi Ilias,
>
> This series doesn't apply as is on current master (tried MBOX file
> from lore). I'll still try to review it by merging conflicts locally,
> but please double check it on your side, and re-submit in case of
> actual conflicts.
>

Never mind, I missed the bit about this series being based on mine [1].

[1] https://lore.kernel.org/u-boot/20241211022550.2995-1-semen.protsenko@li=
naro.org/

[snip]
