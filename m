Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3218CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79319848E2;
	Wed,  3 Jun 2026 19:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YN3QZ3/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3BE848E2; Wed,  3 Jun 2026 19:06:08 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19708848D1
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bef1e6423e7so272510566b.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506366; cv=none;
 d=google.com; s=arc-20240605;
 b=fQmiL5jPNk4r4ssIDqgJlO0Rdt6Jj6LtPXXN+ZTs2qnOEez9Ed3PtEF7LoewDQ8gFI
 KQq0rADl5w6TQFzfEgy/NQNyYuEW9iBN25jTZlWAuFP8Kj2Io/jaYl78ciJ/V53nUcad
 xe7fEIrRCA94quMjben4kzmvwUWKLYL9V5rdfW9yK7Kz2I2SYuG/h7vxN6T25gqOLTTP
 UcNd3vwm9PcLXR4BV/8tG9tZhyQCoHNtotcE4JNKRGCLavIkxabHp2gZi0dUIgt8Bfkx
 QoK1ParFz/a7lghaTGoiHWrwdEZRUyVA3136SE7R5+IpTGxi8XqMC4QaP7WbLfHy1FYS
 h3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C1U42p29gNQNJ2FopYP8vJ2nOObjIhN58B3DMZyaTUg=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=i40K6UcyIWhNBVQXU1E7nx3k5mv+M1ngaVoSQFueGlgas9DvGR+2IGzUJLbIiEK8n8
 Cc4x3NTna0jFuxl0tWWL5rhICxpXPVYRzjc7EgfGPiBilOr35gwsnbpfw/mCA+m8eg9z
 b6oxZFcpq1DsPtq7MTQ1JJJSvdUwkUNssrps2qseVo/2P3JSsUgelpcO9dsWD1I5Yvyz
 F8KkjM5fx3Ndm33bhHJO+kq1HMBuiAggmzE+kkA3pPNsdWKHr9h0uuYd+Y1mT8YHI3px
 MfkQIBfbo2fzPeJcEX0+kGfZamU4b8RrrIQW0NJ3cNqKKAF0X6QAq+nf88GG9F75uO3+
 GwHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506366; x=1781111166; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C1U42p29gNQNJ2FopYP8vJ2nOObjIhN58B3DMZyaTUg=;
 b=YN3QZ3/FU6LCUWU7ISm+gDx8C+JO1r31AFAunzUDd5g0qyLrp6/whbr3x2kgihpo9Q
 8/iryYNFsUJt9DX6oQ+r9Q7rY5UmRWGpsW/MdzGgOXiUl2uugEG3YVvZ8a77b1CP2VKA
 48r3XSOvLSES/FOLyQpBUNXs2EmEC2rmf0+bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506366; x=1781111166;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1U42p29gNQNJ2FopYP8vJ2nOObjIhN58B3DMZyaTUg=;
 b=cT5PbNFLkPlGf43yCjVbH/kNC4wts+3dlbODTDTIvh+dV+NlYJm1UxgY9nCiNR5rKt
 SfzKdpp+OeDB+1GbS32tHNgfOSATy07noQKHI9t0IEbz13ljZywWF3YTj5ktI4rmi9Sx
 hiuqVYEsSZKGkFflPLzEWTbpmhFog8VLO5TdUXTt10xDMCeRkXy6FI6i+xwEhbNEWklB
 gVFctFgTeRPyCZGx8qkK43h7BMv2Fnt+2MR218Xnh4RENCfdVHJWaJ/FG4FtjgXqZ0nP
 Wrw6lcOhkg8ZVx+f+IkHIgZM79/nVWf+7T0qfHLGJLXIxgNmssykYh8gTfnjx+jkDqPi
 9cEQ==
X-Gm-Message-State: AOJu0YyxTOCE2ozTfPMWQihgmPWbmlQZ+X5/NMGHRkItMjSOuCLh0oKp
 ESfz0CrTJOcm7DS3IPaV2mcegWOuSEiO2HpXGKRK/7x8DdCabhKiLgCIWhxoiOV3kLQXbLSRAQR
 Sw74M5xogreirvSeWW1E9AlxHFWaR+FgzESPUARAxUOwH+JhOIMw=
X-Gm-Gg: Acq92OEY7nQEN1ZEVclDkNSZ8TPMRuu8w5johmU0xPQt1YRk7eAsEIMZ6mSm/d6CjMF
 rVNw6Wyt0nYPtORTvoZBkA5xOFkUweCK4RLeGS4LlO8PjtUMcTQh1sEeGeeeSa0YiaPU3lB6v1d
 XMFIDiWppM2bfYOigqNr7gil7tH1/8q/cMxEBacFQ+go1DKAX22Q5VYzum7VFOtoF7WLgwNMwU6
 ao+ItIc+VCHa0UGE6HfJLPBhd/R1vBe4o53ekDUL7tORyDos4KNQeBFffvM+Gjvho+iyaSkvgTc
 Izaainnjr/8e0ul7k32Gjjcd78o=
X-Received: by 2002:a17:907:3cc7:b0:bf0:1c43:bd22 with SMTP id
 a640c23a62f3a-bf0ad207c57mr233423366b.19.1780506366550; Wed, 03 Jun 2026
 10:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-8-dmukhin@ford.com>
In-Reply-To: <20260603070743.1268544-8-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:05:01 -0600
X-Gm-Features: AVHnY4IV1ODJI97DJE-tGQaYFf413jIPIPMDlQFw8ql93Uv7qtpBUL0CVHa6QCo
Message-ID: <CAFLszTicN8YHy+rfWqtoQ8hr-4mS76psZ7khFP+_yvRy-iYYeg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] tests: reset: add cold/warm reset types
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

On 2026-06-03T07:07:36, None <dmukhin@ford.com> wrote:
> tests: reset: add cold/warm reset types
>
> Extend reset tests to cover both -c/-w 'reset' command flags.
> Make sure sandbox reset tests are passing.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> test/py/tests/test_reset.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
