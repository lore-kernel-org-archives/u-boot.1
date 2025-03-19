Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97740C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4079182131;
	Wed, 19 Mar 2025 16:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gc09bKaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DB582131; Wed, 19 Mar 2025 16:04:31 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0504382063
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2ed007aacso1365019466b.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396668; x=1743001468; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OcsPD9Apu74KzI8jlBLI3n0QSglTkVt/s6nQEszwzr8=;
 b=gc09bKaAxNbY5JSzXkTTunEoQvvFaeAusFFbMlej4MSjL3W/y8tZjdZArPKZ/wmBl/
 DM18Rx+XtYNYbtCn+Kx1xeO5COXjqTqGimQ3dOEZILTQhtdRZKH8lMc/LEJqkwlSXAev
 z5DjaXiQOLC9ThntM+dALIVZuh1hxkjFAMskg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396668; x=1743001468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OcsPD9Apu74KzI8jlBLI3n0QSglTkVt/s6nQEszwzr8=;
 b=rfpDWDOTXwhq8FCxtOLkqTJo+kjero0riU94/vCRhJzxy0hyYJKQAR5dPrp2WyZJ6v
 N34UmNmON4lkRawcF5i6wtEcuWl1KnZt1jGslrUNyfoHSLMqFa4GbxbKmuP7ar5F8JkL
 Ug5rJKz7IKyvE4UljtQiZHuUIzk/qjr+kwz/OroMlhMAz4q5nVvaXwUNAlrnzI6IMKf6
 2Ewx6Yy89T03ruwEYCVvX0amtecxgkBe7yTNaSmkrm41JpJrXfUlm6lW98XK+IQCVMD0
 Us/SgehKTKBIoQCIcVdr9rEfDIO8I1L8xhuf2KXl+7SHHSLMm41zKfti90W5ZA1psWv4
 nBuQ==
X-Gm-Message-State: AOJu0YwG6rUSYaoZTG3l50pv57vnzAWGDvfP2E+iVPtWcSoVBR2Z9BNc
 RRCAzr/s564FyLnKxfVbGUuZMsDsmgqWWIMuOK+cj4r7prxy7F5NBwGDlPJTKgpZsEZQRTop8/j
 XO64l7YE+/Da5gjWr4NGWPlT9jzvuiwdDTji/
X-Gm-Gg: ASbGncux1E58B0/8sosge6Xll1BX9zFYgcSkalbielBcL+T4chHUBzln16TMA4Iw5xl
 EPKPuys9xh+9PuXzBEuCtU6u8WfTWiEaTyylOg30M1aT8GVthfDt6XTTTaB9HZlqw78uFNrcPnN
 LOEeshAfpNntQscjz1XZuauS8nhGI=
X-Google-Smtp-Source: AGHT+IEy8abcv1JX6sprv72DT40lGQPcuwJan0P/1pK1RT97ipR094IB9/IFF8TGPX0tOBBLADwzSUdqm0R59PzTfh0=
X-Received: by 2002:a17:907:bd0b:b0:ac2:4db0:1d22 with SMTP id
 a640c23a62f3a-ac3b7f90165mr361947766b.42.1742396668356; Wed, 19 Mar 2025
 08:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-4-sjg@chromium.org>
 <20250319142438.GF2640854@bill-the-cat>
In-Reply-To: <20250319142438.GF2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Mar 2025 15:04:16 +0000
X-Gm-Features: AQ5f1JoC5GQqXSo4KXXDXjLst6Tf5TCtisjhQjY1yn0W_NX8TClTNkbPJM8JfDM
Message-ID: <CAFLszTjG-uhXLWE7+fWZtHLfjns7oAEqcxr1Q2NNgVnFaAUH=A@mail.gmail.com>
Subject: Re: [PATCH 3/6] test: Add a test for strim()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 19 Mar 2025 at 15:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 12:59:05PM +0100, Simon Glass wrote:
>
> > This function trims whitespace from the start and end of a string. Add a
> > test for it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  test/lib/string.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
>
> This got me to ask "What even is using strim and where did it come
> from?". To which the answer is:
> - A few places, but it's probably reasonable.
> - Linux, pre-2011.
>
> I say the latter because we're missing a bug fix to the strim function
> that's been there since 2011:
>
> commit 66f6958e69d8055277356d3cc2e7a1d734db1755
> Author: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Date:   Mon Oct 31 17:12:37 2011 -0700
>
>     lib/string.c: fix strim() semantics for strings that have only blanks
>
>     Commit 84c95c9acf0 ("string: on strstrip(), first remove leading spaces
>     before running over str") improved  the performance of the strim()
>     function.
>
>     Unfortunately this changed the semantics of strim() and broke my code.
>     Before the patch it was possible to use strim() without using the return
>     value for removing trailing spaces from strings that had either only
>     blanks or only trailing blanks.
>
>     Now this does not work any longer for strings that *only* have blanks.
>
>     Before patch: "   " -> ""    (empty string)
>     After patch:  "   " -> "   " (no change)
>
>     I think we should remove your patch to restore the old behavior.
>
>     The description (lib/string.c):
>
>      * Note that the first trailing whitespace is replaced with a %NUL-terminator
>
>     => The first trailing whitespace of a string that only has whitespace
>        characters is the first whitespace
>
>     The patch restores the old strim() semantics.
>
>     Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>     Cc: Andre Goddard Rosa <andre.goddard@gmail.com>
>     Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>     Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> --
> Tom

Here is the comment for the function, of note given Linux's disdain
for commenting code:

/**
 * strim - Removes leading and trailing whitespace from @s.
 * @s: The string to be stripped.
 *
 * Note that the first trailing whitespace is replaced with a %NUL-terminator
 * in the given string @s. Returns a pointer to the first non-whitespace
 * character in @s.
 */

Given that comment, I don't see a bug here. But of course we could add
a test for it and adjust the function too. PLMK.

Regards,
Simon
