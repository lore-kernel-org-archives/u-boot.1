Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7371C44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488ED84BF4;
	Mon, 13 Jul 2026 17:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SrylC5Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F4684C03; Mon, 13 Jul 2026 17:18:32 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1AD84AED
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso5939537a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955909; cv=none;
 d=google.com; s=arc-20260327;
 b=ENt0LPjZpIw5j9dkBi1qCU7aJE5H7OCZ4CR/JLU+8++K30AmccymQH8qfc4Kwx5eG9
 utyZyzsRRefM6E6zGE32O0BLiUWt1QxLDIJkdV8jIjVWKAniBucmn5svJjqkxtuPkN5I
 eJymAgYGxQDkGmJMXWUmTSiH8r6KgLAzXxkmNuLmDLGuKa6xxH+buJYLls5FgFuA3r6F
 +Gx8W6mEMpcunRJUUjZCqJ2hLKG1DKiidqI0h81UPx3sDsR9l3+UhqOS2ME/DiUqdb77
 b7joy9VUB3bdvmbSH8aWHazWyfGPVCpLZS3h8ToavuQPsxJxpmghVZEhPkpUEo8jAK+l
 UGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gng+6vZOcn05AM2cji6Zf+LAVHHBJ2esCepoInobYbk=;
 fh=PyjwEzEerfNTAogTmdr24rImNeWEP6ZOU1L+B22eC8w=;
 b=LLPmmVnMhpKAJQK3h2GV+OIGBpSgmeAFOakYffhPRSoa/hHYlqYh5RcBRXp81QLt2l
 828/DTEP9+DaVlcRn7pr69v4r2+ZPiTB8fc5xW6GIY2uob9aR/mK8CyzhK3Dwu6JhGno
 lmrqo10z4pdBtAXMHBrWz+cWi+KWfwJhT8NCosk0ff8QbllEvWIyqHXU3T3fdI0iVaEX
 Yfq7D/XIS+Gv0l+rhq0PswTA4W/LD7tiMY7/M8nqWT+16XCZ0i4WN/3Z4WqOCHH4kqY8
 JChfEupBYcCoKnjUr1NHx4MQMhpdTgrwmvaf1V/zbwbmxa50SkWDtyyogdc10iLyv9O2
 i/HQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783955909; x=1784560709; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gng+6vZOcn05AM2cji6Zf+LAVHHBJ2esCepoInobYbk=;
 b=SrylC5RxZUsopQui49zOq8Pym9SOzvJVI8uA6eoSE489Ocs1usQOVpxCkNz9idBqTf
 +du82SjcRcuENQEpPBlNJ1ah+QxNETcFoPYJDSvGzL5MH8Ws5j3VBMS0hdzce+CO3EQS
 y5M6ralr1A6jRa/DaUBrbs7COH7vloDJDeE0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955909; x=1784560709;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gng+6vZOcn05AM2cji6Zf+LAVHHBJ2esCepoInobYbk=;
 b=R4Y7iTh/Bc5XTFRGbCjyTHrPtJg5IiT/CC9qhtm9xQI+4UTJ0MNKQ/fsMSA7H6oLEf
 N1fhpa4lHWnYksHg9he3+obHXKfCxeqtJC2wL3SLEiaEE4sEwssoGq2gb+/OzFT+ubTw
 UtkAc51CBuRN49ftI+nMz2/k+L+4Y+OihlsHyyDopS3fRN+1GzKcxoqmKxUJzIqYCSy2
 9YotnjtvO7IlJiM6gTVG6wroDwuZ2WAkTp643nb5weBFF4veSEUXZOrn7CNpu5P2p2e6
 0nQ0z55Jv5HSkrl8WGst5GdmJLGg/WzfYvTVrma7OVY/oBcpo7fDKCoXQ/xglx2uWrKG
 YPnA==
X-Gm-Message-State: AOJu0YxPNoP5Tnirl+DcZ/8C36ULdrbWK3WvTYvKiO/fWoK8OMJz4gaN
 pUJXEcquLXoqg9mN5RHXxBeVXneNAjwWGiGlNp5QxMvZlU13D1MoIf5yfcVipdh8IrwacZX/GGR
 dC09S0UEBJJDCvFkcjz3AZp+mAHFehMBykscJytYj
X-Gm-Gg: AfdE7cmYvE38hoiz0r0ykhLKexILSPK43hb8cd0+o1C8ybH14MAv8PeCl2YDvmDW6PO
 7njwmXRia1nqDlHQzo77dtx2k9AIQQk24ZJm5hhJQQ4ZSVSYZRrxC4VwCwmoJB9qi9rUiQJgS5J
 hlUUZoFZk4JxnYHC7DDDEDA+1FoumCDqpH0CRdtJUK6Jr6iuTMggXsQOrEx8i8cdpYaf8k4QABi
 AYMESQbSwVsszU5FxxKDNJW9KkSrS3/OzzO1vZgGz19Hlhl/KvO9O0MOK9LlBwO+kaTHT8=
X-Received: by 2002:a05:6402:5193:b0:698:56e7:8eb3 with SMTP id
 4fb4d7f45d1cf-69c5f0c012dmr4238962a12.14.1783955909572; Mon, 13 Jul 2026
 08:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-7-ravi@prevas.dk>
 <E34yhAlCVCKvRi2CPJi8pD86DADiz_24yKo13BW9Np4OH0VAVkCjdc-PkziRdM9IWfrE9bMWZliPPmLlpjWcug==@protonmail.internalid>
 <CAFLszTjzRQStvr-Vs=aOQ=BaMKBPFmtkPfNXKdh7XNsZ9hacSA@mail.gmail.com>
 <87o6gbrleq.fsf@rasmusvillemoes.dk>
In-Reply-To: <87o6gbrleq.fsf@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 09:18:17 -0600
X-Gm-Features: AUfX_my6bvweW7_f8dElSshdKSi_uS21I7xEGePV_erRusXlRwYNYYscivGXFvE
Message-ID: <CAFLszTiKROOrM0DcyyeyiQhEUr+0xs=KVM=QZjTG3RBTNBVBdg@mail.gmail.com>
Subject: Re: [PATCH 6/6] k3-binman.dtsi: insert keyfile and distinguished name
 templates in all ti-secure(-rom) nodes
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Mon, 13 Jul 2026 at 08:53, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Mon, Jul 13 2026, "Simon Glass" <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On 2026-07-10T12:36:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >> k3-binman.dtsi: insert keyfile and distinguished name templates in all ti-secure(-rom) nodes
> >>
> >> This should not make any functional difference, and downstream boards
> >> that already override the keyfile property via an explicit .dtsi
> >> fragment for each node will continue to have precedence over the value
> >> coming from the template. But this makes it much more ergonomic to
> >> have the keyfile and distinguished-name have consistent values
> >> throughout, because one only has to override the values in the
> >> templates and not each and every individual node.
> >>
> >> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> >>
> >> arch/arm/dts/k3-binman.dtsi | 20 ++++++++++----------
> >>  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> >> k3-binman.dtsi: insert keyfile and distinguished name templates in all ti-secure(-rom) nodes
> >
> > I still see lots of custMpk.pem in .dtsi files after this series so
> > I'm not sure of the exact mechanism for your claim in this series. I
> > was expecting it to remove all of those?
>
> Well, changing those are not needed for my immediate purpose, I only
> need those in k3-binman.dtsi to be updated, as that is the only upstream
> file I include. Yes, they should probably all be updated, but I didn't
> want to pollute this series with tons of mechanical changes, that can be
> done as a followup if and when this lands.

Fair enough, thanks.

>
> >> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> >> @@ -330,8 +330,8 @@
> >>                                       ti-secure {
> >> +                                             insert-template = <&keyfile_template>, <&distinguished_name_template>;
> >>                                               content = <&u_boot_spl_nodtb>;
> >> -                                             keyfile = 'custMpk.pem';
> >>
> >>                                       };
> >
> > Removing the keyfile property leaves a stray blank line before the
> > closing brace. Please can you drop that while you are at it?
>
> Of course.
>

Regards,
Simon

> Rasmus
