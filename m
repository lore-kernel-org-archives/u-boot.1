Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521D4FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE9584119;
	Mon, 27 Apr 2026 11:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="j8aeH6bX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48EB984120; Mon, 27 Apr 2026 11:40:41 +0200 (CEST)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF38183C14
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso30208c88.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282836; cv=none;
 d=google.com; s=arc-20240605;
 b=NMbf0q8CUUD+XdQbrTrNt/AQAHVErnMvKc8RzNW/60eWILxVvUtLFp8TX55Sfox1f7
 NNGTKBuiijVcDYfMGIetzt89ThPIPSOeP+79Mi8Otds0vjv0sZ9N1Qywrez6th+mD6uz
 NwfOn9RysFFpNyeQyuB65wxAJ8g5xxnj/RsIiVErGlQz1GMhg614QlkMA6PcYVGWQWDp
 EjgwqytDa9ObbjcWWo9mFyqCdQNB0ToZpIoBG3C4wULHBzjLxa5n85DXpuXGgXUihZUy
 3HFVW4sZVm9Gkfq1xZigk77jxTUpGkUP4pVWO+X/ZuscvAnjeiUpZfPDbNVc4FtXOcPy
 ZbJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dpWTiETkoYc66QXyAlFBuRIgwCFLh1SE0xuTGlRj2fo=;
 fh=arT6RGR3pLCmB2R2uhb7st9Io/ST89xiylWqXTTE4II=;
 b=AfKO9heeORR3z+giDJ38u5baZE4vx0OjdP8MyAc1Se7eCKiG70OCnXVXfN7tterimK
 5HCfWWgLr4IAU3wdZS7i3UhnsG6NzeBKCcBNLcpDjsbl9ygDGPFNuHKduNqMxK8fAgy/
 y8fFdxjAzIeh4zQ+Jeayv6+cPtkIbJKTGMzoS+60MDtV3VixXtcvF+I2qLn0Cz6pkVKI
 XJ7LFXbldGl9vhV64gcncwFp3qwKhqpqdreRiYEIuMgwLdc/joc6Yq/Hb4tjLzzOVvI8
 xgWur/+7W9WfV+p3V19m9/18zKPDRSXWj37AyPCdqA4rEOp9XQZMhCBy8DgjOkXGi3vi
 g7Sw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777282836; x=1777887636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dpWTiETkoYc66QXyAlFBuRIgwCFLh1SE0xuTGlRj2fo=;
 b=j8aeH6bXhjGNJLWstdvQI9kcIl91v2KXjaFPx0/WJqPQ+OwLzSxo4R+fqHXHmM8Sxn
 SEfWW8lVDDNmrkVE/v+kg+YVzfkJm2dS/ZL4Eq1bDvvnDkg8IDaQ8CRXeydkxHwQcXB6
 k9Li+L7lNIuX8ke1EgyHGHO8mPOV8kwLk/eMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282836; x=1777887636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpWTiETkoYc66QXyAlFBuRIgwCFLh1SE0xuTGlRj2fo=;
 b=pXA1WNDbZSZrq/AKy1Wgt9Y9yFZFCC73DBdCG7h9vMficPpkZgPvH+O6oIzwJU43ZB
 zvpazyHYwCxL1DCoOQU0HIn+oQF84JyzKtNiAdsWaY7vEmhNh/CNVyN/6SQB0wWRwOkW
 LxfqYUnq9YS7wsHGmimARDCrNIYIaJjHb3Jvsk0fZAZVnxxFHLEbwChb7iHa6V9lpgiW
 jO5eSZG6KVKKqkjtL6IYefoTQ/tsFHlIcovjThLuCiP+7ZRVDCP6O4YS9jd+oHWCCbHw
 bwulxqFjxFV3vy53yxMyujbmhw0+A70yZ0U1DCO02AK/VoyQDFl2JlfNkdx6MsA7MH18
 h+EA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dBKJdmn7KRriKqiv2JDgFPH7oZeJ02emoJwM6il3Qr2UkvTParleSWhlyTzW/u2qwtF4yZFQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4TLRY1vPFYBWGZRXFxSkBoF7lalbBq+NCP0U7QkgtkrAFl5Tz
 /0c7ujQpuVjm2eDoidoOmU02u8/cc9oVxOSSiMpC1ciGB66qLJ2cts4FROCMhYcZHHSDkQONMp3
 /R6TxHkYbe/6QsGAEnqZv0YwyyZt/U5ZlRKVBVWqcbQ==
X-Gm-Gg: AeBDievWas+wfVY9c8WG0+CckVXOgcqK7WHQV0TSQyFGb+6DyDCKceO+TCUIOOLNVkg
 DM28bMBw9MG44lm+B+U+S6q6lPVqpB6sVx3e7Eb0TISG49eKZRHU6/89MG+t8ACqx23G/JAWQy0
 yBGsp5iemOG21tgDz4WO/NqKVgAhhFdRYdKeSUbOEEDG5yqIHIidtq7sntXcV9htA+kcSaBYDMT
 FsnNeJO0zC3hqRqSDBwZwpx9FSnUbnarUNDOZ4HOY+t3pD0dikUp+sAblp5lbSAbMmOtrAvomY9
 0Ngt217xyrKVYkENYg==
X-Received: by 2002:a05:7022:388f:b0:128:d5f1:d594 with SMTP id
 a92af1059eb24-12c73f72832mr24647976c88.10.1777282835781; Mon, 27 Apr 2026
 02:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260419100123.2427364-1-daniel@thingy.jp>
 <aezn6_Jpj1RG-RxF@google.com>
In-Reply-To: <aezn6_Jpj1RG-RxF@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Mon, 27 Apr 2026 18:40:24 +0900
X-Gm-Features: AVHnY4IssDoh_pUpjFFFQYDA80okOMpNEyGiALMs1yxq5GGwmhWP4_R7AjrrcVg
Message-ID: <CAFr9PXk3FpXnK_BJsdnh8aH9DPN82X8GA8aG16U=5CeL-RbpiQ@mail.gmail.com>
Subject: Re: [PATCH] fs/erofs: Fix build for m68k
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jnhuang95@gmail.com, angelo@kernel-space.org, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Sun, 26 Apr 2026 at 01:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> Since round_up(x, y) requires y to be a power of two, I was wondering
> if it might be worth adding an assertion here to ensure this?

I think if we need that we should maybe wire it into round_up() so it
checks everything using it is passing a power of two.
I thought maybe the linux version had some compile time assert thing
but it doesn't seem to check either.

> Additionally, a bit further down in erofs_map_blocks(), there is
> another instance where roundup() is used. I haven't checked the
> generated assembly, but I'm guessing it didn't fail because gcc was
> smart enough to optimize it into a right shift? Since erofs_blksiz() is
> defined as (1u << sbi.blkszbits), it is also guaranteed to be a power
> of two. Perhaps we should replace that one with round_up() as well, for
> safety and consistency?

mmm maybe I should grep for all of the instances of roundup() in the
erofs code and fix them all at once.

Thanks,

Daniel
