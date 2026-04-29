Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ACCFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA89384894;
	Wed, 29 Apr 2026 16:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fIsU83wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F072848B4; Wed, 29 Apr 2026 16:46:11 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CE5841D7
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-baebe98afa0so741251366b.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777473969; cv=none;
 d=google.com; s=arc-20240605;
 b=QU1ZclFrYKKb8eQMRR1a7O0/QXcRjGmacuWbMwcBM5xSyn/ys/Wsknq/B69oR9rd6P
 14QuNq+4Tm3vp6tZolsW0b6XffSPXZCSIkZqwMAqUpJuxfLeBSJ0x2ISGtjGng8Rl8la
 h3FPgbXbnVjPNGtMydStm3VeO1wg6Cx4dROu+kgGBy/GT9O5NUdCN9IdLgYVKdznvozb
 TbUKQpyi0gSHhkpn+PpTtl4CH7eMPALkN/ZAgikDFsNTiilj9GWYw34c3DElOeb2RV0M
 8KyzBe1O4Hefq6kzO0wzOjuH803UD5psQaGlcpn8EeUlT/toDRQ229KLWnyE2pp5lKak
 wYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JDiJ7u/7VQtGyvXRNslL5D1lLFSODnAtsUgUDlLSYrE=;
 fh=RcQxRqe7UycvZcV76VWjauwHMbRaiieYSPPzjcGeqlY=;
 b=VlfDAqo8X/rSeU2Uqv3p8W/lHa0Dhube5w9eUTH9z4w59XhEwu2k+RgwwxAVQssFO7
 y3QVUWu27HnqPZ9cSWv2laZE54q/OoVi2jskqbltmh717tdElM3PQNKzjM97/Cyc6U/2
 HiTv3rMyhMx3t5Y52b6/ISgbBn87pfC/fHSmV976A6NAsf39ZwOtLZoQyDVd6mPzKHNf
 X6UHE1Di44Fu+bsRnKlUfPXTom98MxN29XrU0SEdioH15RvM3H+MgIpkUepdjfR3uNwu
 oESt9FBFNVC+WpD6z2OzWskDWW+JWF8NKpfYtL4triw8+sW4dDCs08A7j3Rozjau6cNU
 qnGw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777473969; x=1778078769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JDiJ7u/7VQtGyvXRNslL5D1lLFSODnAtsUgUDlLSYrE=;
 b=fIsU83wiFqHEZAJUqc5QVKBNCJmj3kqn2VQe60iQ0Nm9UIiACit6gmgwZfctyICHTU
 JXp9DrtIQf66ZDhLHgMaTVjgsiegHozx5l2KUvquQAs1zb7YEu3Mw1uuLnZxgoiPIbOO
 C7mQ5uVyFgY7wpaxxFSgp3lBL00VCc0Ok/sYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473969; x=1778078769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDiJ7u/7VQtGyvXRNslL5D1lLFSODnAtsUgUDlLSYrE=;
 b=GELbcwDi/AEWEspwkvO0s4ufto1Ju2d/lPcOCUW21ad4ruHhFtQfKQqWwsRgAAVg0N
 /GXZ3y05YrtbHSlbTBAZG9ajilMzMgV2mDhGh5emTDi65S+Ii0nMszZhj+fafLyGPgLt
 6tmr0hw7DHUATlra25kYHSFMEf/OGvZFSHbH2cMYSZ8/XE+6oZ+rS26lkAq8XnWPcM1j
 EZc68rTqBB4019hlsQzzMqEQfxINdlpzoQtj2g7XgaaK8QjH0lGZP8HVQ8m23vNBPZNC
 8Fg533oSLBgsB4loqO7a3upLC0vAZJ9eLvEG4ZQgsIK65RmVnfxBgKF1AgrEInFYg75V
 JwUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/RLCUUndnCm1M+ZfxeqRkauYuOIi8vbJpSzMaeTU1wAOp+V3GzI8MokzRhVAYyg+3EqITXsU=@lists.denx.de
X-Gm-Message-State: AOJu0YyvQ2Pquwg76ePz7h3YLPQjyduIMqGhLx4milqLJimo5JPRYxp4
 BCHs4WlIjnCuNwv9wmR275g3wWZMGogyDpvghX03DlEMFFxGC/vgkxju1SATVwQNOevR0WFnrgQ
 BZURzOufdZ6zvLRSPvMiUfoeQPPOFg+k74R2SDAzT8XYf7LH+nHetrw==
X-Gm-Gg: AeBDievSfML3YJCygnwJI+PLR9F/IutM+zx3ASnRZNMgZpDMUCTG9cFW/1q7HcaaX3z
 1yYJgqyEPNM1XZzKUHCnoWd82zD46QwWpvWrc0baZjAFjtOvzJsyJDQIKmoyJWXQaQ+e1zXcCdc
 RDYYzkutcxXRuH1DDw8d5e7XG+XAtWe6EzqolsJqLNyPMBJg9oG5ZtvwXCYFQAgkaYNX3Pay3rE
 EPeHzmw7Ty5iC5r16H7cK+i5IXBjUXN4OSFckKd0Mn3hufLfLKsZn/wie6JnVvWOa9yqTDBF+r1
 TaedF8wF9gW7mLma
X-Received: by 2002:a17:907:3e9a:b0:ba8:a21f:9c4e with SMTP id
 a640c23a62f3a-bb93ce89d43mr262565366b.11.1777473968858; Wed, 29 Apr 2026
 07:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260428142848.48156-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgKkn0cwfv97FBVDK+FdCM-6BfasCvsA2oDe5qdzeuS4g@mail.gmail.com>
 <db5d98f7-1036-4842-b70c-b6c1e3625ded@canonical.com>
In-Reply-To: <db5d98f7-1036-4842-b70c-b6c1e3625ded@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:45:56 -0600
X-Gm-Features: AVHnY4JFImAs1DtBG8n1fnPZhPcel_6iwNuf0kFvOAsQbwkN7Yikei-ino2vDCM
Message-ID: <CAFLszTjQMuaCxOTD-ecZZBe6nC6R2s-xE_w7x00K2HO=G4mg6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] .clang-format: add U-Boot specific for each macros
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Javier Tia <floss@jetm.me>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 29 Apr 2026 at 08:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 4/29/26 16:21, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On 2026-04-28T14:28:48, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >> .clang-format: add U-Boot specific for each macros
> >>
> >> Formatting via clang-format is controlled by .clang-format.
> >> For each statements should be formatted with a brace at the line end:
> >>
> >>      for_each() {
> >>      }
> >>
> >> This requires clang-format to know that the symbol is not a function
> >> but a for each macro. We use some for each macros which don't exist in
> >> Linux. Add these to file .clang-format.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>
> >> .clang-format | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 51 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> >> diff --git a/.clang-format b/.clang-format
> >> @@ -748,6 +748,57 @@ ForEachMacros:
> >> +  # U-Boot specific
> >> +  - '__for_each_child_of_node'
> >
> > Should the 'git grep' recipe include drivers/ and arch/ as well?
>
> Thanks for reviewing.
>
> What I did was removing the directory restriction completely.
>
> If we really need a comment, it would have to be in the # U-Boot section.

It doesn't seem important. I was referring to the '# Taken from:' comment.

Regards,
Simon
