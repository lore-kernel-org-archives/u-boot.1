Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC325EEAA7B
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 22:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA988669D;
	Fri, 15 Sep 2023 00:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CdTal1IO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264D28669D; Fri, 15 Sep 2023 00:43:39 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5727786661
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 00:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52eed139ec2so1690311a12.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 15:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694731417; x=1695336217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KxEd3Kel1ce1GLkybEQUe4FzSLPhWsLqId9zJLPPiec=;
 b=CdTal1IOlA7iB2tXP6CGiwCmUR3BKRHFFXkNFOyFHonb5wGbnJ6kUfvNIiGspl1iJG
 +nLlbvj1cL5jX+d5ogLdKMBUcKAdEQESvv4zHsO4YDi6PRhey0Nc+m6FXI+xkRkYDMYA
 gRvE/5RFx+C/5C6iMfVNVVkC5UnL7l9//Yg40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694731417; x=1695336217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KxEd3Kel1ce1GLkybEQUe4FzSLPhWsLqId9zJLPPiec=;
 b=RXSTLFrugSBDQMR4G71iRWMRP6okQyAnMn25yVhvlzZ9SAgKXcLuqHmtdaUOyZi4gT
 7ZWcDyTYc93EfDyXrIA9qzrRs7BIfD2CAznpttxhs8zuUeFvJWXnb0FSsYQgCxOShw3t
 2uKZo/esWv+3GUpXHGy2lWRaU7V1aN085klqI1kR1hVldYVJO4qEEvAz1dX/kAZ/b2ZY
 UAmuyWeyK+aUpvHH6Bh8QFUP10dDJidZr3AL8hPtg9CpOvWSw6ru43PgdGt/UwbsLMxf
 CnpO7dChH1RKdO8UB8B9+hA0ynKTJMw301LfR6/T6KzdSFmx1ILwRQKjSC/Lw0aq/RVN
 TDSw==
X-Gm-Message-State: AOJu0Yxu7tOthZdqY2odktozJZBLwNnMux2tY46l91z3IJMB9CCEYsWl
 Iize/KirjtCCdfANxdLYopECoMTMwpxLWq0AKN8x9g==
X-Google-Smtp-Source: AGHT+IFjihhTBR/9fCW/T4Pk2gw8YVAFcfYiE8Y7/g708FyWwKTBPGkg2mSeTW0iXXlM4eng6yJksXZDeJNZ5ujP3wc=
X-Received: by 2002:a17:906:c451:b0:9a2:23cd:f05a with SMTP id
 ck17-20020a170906c45100b009a223cdf05amr6036223ejb.76.1694731416775; Thu, 14
 Sep 2023 15:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
 <169472311537.1507631.3823107473012828432.b4-ty@konsulko.com>
In-Reply-To: <169472311537.1507631.3823107473012828432.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Sep 2023 16:43:25 -0600
Message-ID: <CAPnjgZ032j0Pyh=AMLjf8=Z8PrcTpVsu7fy3MOwvfccJ9HNW+Q@mail.gmail.com>
Subject: Re: [PATCH 00/35] treewide: Remove unused NEEDS_MANUAL_RELOC code bits
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Thu, 14 Sept 2023 at 14:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, 06 Sep 2023 23:29:40 +0200, Marek Vasut wrote:
>
> > The last user of the NEEDS_MANUAL_RELOC has been removed in commit
> > 26af162ac8f8 ("arch: m68k: Implement relocation")
> > Remove now unused NEEDS_MANUAL_RELOC code.
> >
> > This is a follow up on way over decade old commit
> > 2e5167ccad93 ("Replace CONFIG_RELOC_FIXUP_WORKS by CONFIG_NEEDS_MANUAL_RELOC")
> > "
> > By now, the majority of architectures have working relocation
> > support, so the few remaining architectures have become exceptions.
> > To make this more obvious, we make working relocation now the default
> > case, and flag the remaining cases with CONFIG_NEEDS_MANUAL_RELOC.
> > "
> > It took a bit longer than expected, but now we can really sunset
> > CONFIG_NEEDS_MANUAL_RELOC.
> >
> > [...]
>
> Applied to u-boot/next, thanks!

yay, thanks indeed!
