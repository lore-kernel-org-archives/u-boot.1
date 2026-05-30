Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9849BCD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 13:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04FDF84693;
	Sat, 30 May 2026 15:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="neVACNJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3164846A3; Sat, 30 May 2026 15:43:34 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069AD84671
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 15:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bdbcc6c4500so1431300366b.1
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 06:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780148612; cv=none;
 d=google.com; s=arc-20240605;
 b=Z9ED7fFZxorNUQxbECf1/Q0p7342r2klX06y9zgl55ezrpC0OfE7gjU/GXhZS//4sV
 aCw4E0jEDkvQC4DmDhyQj1pn3OW1z7nwp7jbfRJDvpMdzLke50JbKaU/3Jzz1BZBcn1p
 w+s6nOfzGdT2jUdTtAXbkA2jDFpYQC+jzwnQSRucSEneKkwTD3jlEqrtJRosHu1B4/IB
 RpzcjPktpKL99ulQQdjAr9GuJ9nUi8cfiIl05Y/eDXhAo/MDqAp2k8SCELWHjp43/dAv
 DzthlvJ5y23i+QZ9vmp2AL4GFMXocXKPTmZNqZIyZULaFdGJ5DcMF1U2KySHzcJx/W3U
 LAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3RQTLNWnJ90leWvSNGO+BnxYT8g2QLLdf2bA3yGanQM=;
 fh=PDXRaoBkJUW6/3RLkg+PTE56OBrI1+W/XV1JhLNcc90=;
 b=OgMSs9VqVWlbCqCgb46nmTE5joogCRHQqFoU1awMJs0HbBTpmcHUXEAZ4xQGKFWzrG
 PPYZ+o5yzCxYeCTsb4iu2IU8aUBp9LTg1mwYQFyO38nSTSARyb2x8+7pdsYksLYI4mky
 fdxlHtgBL3qJmFBZTglEA+jmxt8z0q1THELDV2p01a1GBP0bY/B/XwSuOxUjGys/C5av
 yDT232br0IO1UymX3GyaJFD24LnAPQHHSe3TI7LLZDrvhlpgew8INniLnKe0v+ZIwrgs
 kTgKpmNfP12jMdnOG3sWRfJHB5+N9bCCDCz2M6aeahjezUjZZip3o6NE7QShtDvLLe7u
 zWAw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780148612; x=1780753412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3RQTLNWnJ90leWvSNGO+BnxYT8g2QLLdf2bA3yGanQM=;
 b=neVACNJku6popS7MHin90RED1nTU1Zup+En7jh+pvQj4PJvQeq8U1YgYjMdlDlbvPr
 yqhilFVfOjwKQ3XsOeq2y1cgXrceq6CAZxTQ8R/XZb4SrBH+AoGR1DWjhsV9VbV/6Gm2
 EXYkY5NIMMKeCuHzhbeTV5SbwaOSRmGwv7UrQt8I2TooTjLwVHGt/UBcjRoCx1O68wE1
 WEQf39y2cBQ+gKYxbeLLwqG6R4QdSUTvwqq0ElZyR8I6NES1xMASvlxD8aSHatIyqIn8
 H9RRaz+1IQ+st3cPEYxUZEEMfuN8goO9Quy+VPMsf6kquyC4HSEKN8FMwmT5Fgtw6SVg
 TSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780148612; x=1780753412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RQTLNWnJ90leWvSNGO+BnxYT8g2QLLdf2bA3yGanQM=;
 b=P5YsHjotKXlRYInBJIfazBZZaDs4Xc7zUOfCQiPqs3dXa/hy8hmel1grhWVKbpZgki
 fxTaxH0Yxr5ocsWIeJM7Dw/GtbYfCTciKa7wYMqgbL5BQkZ+uMZTp3q+s6a0xn0QwDyY
 XLCtzPW+QB+Jb010Fv4E/w4LucvDEcHLFhpUmnnMg9FpWRRDTTyPI1nEgX2RB64sfM+e
 Zt5lpNB+Y+1O8Mq+2eGnwfj42ApR0DGS91imXvOFTRIgeQAFmnEm6vP7P/1j1lraUbN2
 Q4yEP8JJBDwh0aauH8BsYvIMB+dBb8Vw4lLWzna6MdOD2/zus/tgtqqa4Pyzmiiyu8sO
 k9Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mLCPXvtfU1tI/UzCdAHzAgytYwtof6ZqxLvrbF/unHgDKxPRotJO0aRrTooDBH9nLhSNfwaw=@lists.denx.de
X-Gm-Message-State: AOJu0YwaxdGqE5s+kOpWTHw2byJFS9p7bGvEMVSMSgc8cakSbA9a78fg
 ejp0/9CcBrYSh4WmFcbOOHywtdbx/pF1LLYIgLqUnYXeocY0G0+PdWfaq447iBduawVc+qwY6fQ
 nNzhFHX7X7Xoa5plukeojcg08D4nNhgE=
X-Gm-Gg: Acq92OEAk97iJI7yITMrfUXbl8trw04GHlXNLe4DewntHernk8Hs8AZAl9nHs8mXD7K
 UD4GrSdomlzIfw0aNw7v9gIKb/gA6seH0lDVW4aJ7lZfConbhqM19T5CpD85nYENAraNe/8lE7o
 RpaVI7MDaCACUCsl74VpZZphql8luOeap9MiJfdCzX8wtL82TeRJRVxL+nZTPAqJTImMWzN12p7
 5W8syEyE/RfaMnXIpyi6hlHxXbVmxbVWuSGR1ffgGc9pR0ndocTi/M1dctF5O2r++MNWN/SjSnP
 CFTPMQMK7gqJjBw62wNrBr3ISTlUQWWaBTdfPvx7JWGnU9rRZfcrgEO7YL9XXYuw/Y8gj85CUKi
 XpuRbzSAbgTlKHimON/MmLJZu3BgvvAsLzjXS1MyErnK6MuWjHaeziMG+YPSeVzjAO6gg1Ryhke
 8frPXSr+ThXL/C
X-Received: by 2002:a17:906:6a26:b0:bd2:bd3:1ef8 with SMTP id
 a640c23a62f3a-beab3445bc0mr176057566b.35.1780148612173; Sat, 30 May 2026
 06:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260529162942.281897-1-pbrobinson@gmail.com>
 <d0cb15bb-d4d0-43b2-bf14-b36a62da1dad@mailbox.org>
In-Reply-To: <d0cb15bb-d4d0-43b2-bf14-b36a62da1dad@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 30 May 2026 14:43:20 +0100
X-Gm-Features: AVHnY4KV-RE57kCZ7i_5GVgvS6kkCpHzO9Bxj1Ly8U3eR8A7bUJnBi6f42bv5xE
Message-ID: <CALeDE9NzKS15mMqLEmpBfwXHajN5hr5kapjuguf1fnCXC-1+GQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "lmb: Reinstate access to memory above ram_top"
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

On Sat, 30 May 2026 at 14:27, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 5/29/26 6:29 PM, Peter Robinson wrote:
> > This reverts commit a3075db94d49f415658bf7e961e1eae90d9abc33.
> >
> > This causes boot issues on Raspberry Pi 4/5 in a number of ways,
> > the mmc needs memory < 4Gb, the mailbox needs it < 1Gb at the
> > very least so there's some work to be done here for that platform.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> NAK
>
> The revert is wrong as that breaks other things, like use of DRAM above
> 4 GiB boundary, which is exactly why the original change was implemented.

Read the thread, Tom asked me to send a revert.

> If RPi has limitations, then those limitations should be imposed on RPi,
> not globally. Please add the LMB reservations on RPi only. Use
> lmb_arch_add_memory() to add those restrictions per-board/soc/arch instead.
