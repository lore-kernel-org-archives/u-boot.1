Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C4AF94CBC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F0F83936;
	Wed, 22 Apr 2026 04:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lN4mT1SM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9060B83FE9; Wed, 22 Apr 2026 04:26:13 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E848352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 04:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba3b9601b97so699745366b.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 19:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776824771; cv=none;
 d=google.com; s=arc-20240605;
 b=cfQf4q0+JjSiCqlLlmeUGo2m/ws4ghGMpey6Edv3uTIpiUmZzjH12bNFpqPhi3hwQQ
 hgRIzxLEY+/8r8eliNRYxXb4ApofvqnOlPz29I6Qro1ZCSYKx6pi6BX5/vtHwu7o7/IX
 ucUZFJKTxYpigJwXbmvfwVXzZN8sXPgKGwbLxtUzcR1Z7ZDhJDdkzJ+SGI9w5WfjcCIu
 qt8P4odgODKo2PbjWFFD4wDy3dxm0W0YtD64tTGBE+G6MHhIokKG5xT7U6aoG5IE5zm7
 PTjRV08Xloww1J8p1SAVw1Hak+hFPlsKPvlxKQTyKXyrn8cAqxGlTf03NAlrv1EXxL0t
 xFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AxPLfq0cMqC4yF/Sao1YXUQi+kAhpZXFUuRL2wLsHeM=;
 fh=2eNLhdZdX6ZP+iCKBrivsuSbQYW/BnAeeLSw1FItJ1U=;
 b=h6a9gS0Hfv/jUvCT6kXHD39mGk+Wmtr3tEEs5naGU5w79svg9TPkbQo6G1e9Hw0ruw
 0p0L+R8z0J6JH9OmNHqfxKB5lsHyqCpnULXR4gy0YHRjvYNxwzMgEKyNHyYQN2zGSJni
 W6cOs46SrTTCkjs5plosBdf8rIWXcnbcEMAj4LsMx5mSxWyWxz6LJj2phmP0JqLLt4th
 dg9TbUNbEmbJvmzrWq4TPbnLsmsfzgfP2VBTReBQT9sUKS6T6+Eks7BAjakv7CWKG0/h
 bKNBFkNmcT6fJBLPs0kUMLAfOcmvMv73worZSJueRny8be219lrBYbO+bVwG6YeOCpVc
 fY2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776824771; x=1777429571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AxPLfq0cMqC4yF/Sao1YXUQi+kAhpZXFUuRL2wLsHeM=;
 b=lN4mT1SM8xbn9o7sWVNz4qFqXMPk1OJ/OuXyXxhBQd3Q4b8/XIC6KThoscic+D7J/w
 cPGnGFgU5ZkdfLa1ZWmdC61J9JfnABEFsZkQ2RWch6ClYSlOUQjxZbe2VWYul1DQRA7l
 2XzdDec7rLvUfi15S975EE6Ge8A5PRRWrkDck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776824771; x=1777429571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxPLfq0cMqC4yF/Sao1YXUQi+kAhpZXFUuRL2wLsHeM=;
 b=lW9thFrWuxFjwMQ3J/gDYmRpdzyA68Z0VtByuYB6D2nmZYbdyOB8Dmhh/BsgGa8c/V
 Pxj8DCyVjxHd2+ASx2DQ5sHSzyqID5hCMESXkYQoZGyEco8eQU1oGCCvNRKNAXMkTvP8
 /YpY5ZSdKJttirEZsMfe/R5ak/6D4qPotV+g3VnHhT0F633YCn1/yTE8wSejWOk9CmJb
 nLO5TLRsFdb+gQQ59vNuov7hDUjkvUGs9E6x0K97XJmJ5lVbFCVhpx2wry9XfCo09V19
 fIBN6rKtRKsS3YheZuSXaJiBcguCPqwI1r67wnLUNaqIXbqK31OCD/ylIHlPUOOHd1Ry
 jsqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w5u0OuHCMmVkOGfdB+x7xrsY/Q1ee4Pri4EVIXD2ijzeXq9DGVtLKeHCDXo4aukX+2mbDDaQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyqp4nQ1FHvHsyGLI3yuxoUTz+CIHU/BhmgdQIlOBhKstd5a2bf
 AonQY1I96Iq4tt1NhEoKJkbUG/rSUf8/dWK99mithC90SC+BcwphnSM8i1bqXRo+m/5Wvy5eTpv
 V5y6bFZnjzWAp8sCnbGvWg5lbi8a5nPNiTUQs4HZU
X-Gm-Gg: AeBDieunwLMU1wTiJLsLvVZ7yxH5WOC5a5W6lUnB5RcoGYqZOz6GPBY/r5nyD4hfdna
 mX0ctN26oOIaD2mkAOJCNIB7zGlWmC3dTOKEfy5vfMEkd8VjqHe7ckWECtH+CDCy39Q9oEGkbFz
 JZ43TBAkSxP5fZE1eISRCDmAUtqyBs7X7pO36tgOEgcYYx9VL+0ofC96JCjzQi89aGIVp0V5Pr9
 zWKqwcPQNoWAYnhneHMgg8k7I6acu7UgHXYOtxS4ogl6ZgzRUsiteARoOGOSpUF5FAuBN+ptJGL
 YOMtmOMckDSHqpKNaYdV
X-Received: by 2002:a17:906:d54f:b0:b9c:c5a2:c82c with SMTP id
 a640c23a62f3a-ba41b8d5c58mr1047856566b.40.1776824770894; Tue, 21 Apr 2026
 19:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260420012348.400492-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg+nfKGCaHGz6-GHoQ+KntLYYdUTZqfYGpBdsvLSW9FZQ@mail.gmail.com>
 <0c112980-e5db-4acc-97df-c1097c41112b@mailbox.org>
 <CAFLszTgV6L=G2-MpBgYh3h=4QM0r0V-aLueS3zUgTCTx3YmcpA@mail.gmail.com>
 <1f18aeee-ca36-4ec3-af50-d3ebe49c2a4f@mailbox.org>
In-Reply-To: <1f18aeee-ca36-4ec3-af50-d3ebe49c2a4f@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 14:25:59 +1200
X-Gm-Features: AQROBzBNPtHrrbn0z7PsrCQZjNfif6RC9vybIXeiKZYMJt38kp2P5UGBhFjj6lU
Message-ID: <CAFLszTi4w7d1rVSViaShX7yT=QWHx363Y4Ac3MSrqJ6N+6Ai2Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, 
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Wed, 22 Apr 2026 at 13:46, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/22/26 3:15 AM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Tue, 21 Apr 2026 at 12:48, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >>
> >> On 4/20/26 6:14 AM, Simon Glass wrote:
> >>> On 2026-04-20T01:23:26, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> >>>> kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
> >>>>
> >>>> The fdtgrep command will reduce the DT to minimum size, thus eliminating
> >>>> the extra padding configured via CONFIG_SYS_DTC_PAD_BYTES. Reinstate the
> >>>> extra padding by running the output DTB from fdtgrep through DTC with the
> >>>> -p CONFIG_SYS_DTC_PAD_BYTES flag again in case CONFIG_SYS_DTC_PAD_BYTES
> >>>> is not zero.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>>
> >>>> scripts/Makefile.lib | 7 +++++++
> >>>>    1 file changed, 7 insertions(+)
> >>>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>
> >> Is this something which can be added into fdtgrep itself btw ?
> >
> > Yes I'm sure that would be possible: perhaps a flag to maintain the
> > same padding as it finds in the input file.
> We can not determine the padding from the input DTB file itself, so the
> option would have to take a padding parameter. But I wonder if it makes
> sense to grow fdtgrep this way, or whether using dtc to reinstate the
> padding is better.

I think fdtgrep is cleaner. I'll send a patch.

Regards,
Simon
