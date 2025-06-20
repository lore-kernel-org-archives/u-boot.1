Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEC0C7115A
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 02:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E8382CDF;
	Fri, 20 Jun 2025 04:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="irkiNJAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A452C82CFA; Fri, 20 Jun 2025 04:37:40 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7D782CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 04:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70f94fe1e40so14676787b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750387057; x=1750991857; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEP9b/jbhHCZRE03d1UJPsiYjr50G5ckio9SNpMz3kw=;
 b=irkiNJAtdC5hsDvWyFyRGwA0aJJgnEkKnoPrRMUB3NfCA94G0KXY5ZzHKjoJFsMMrl
 M2JhMzed05ujgu4GRDwWs8JTl/2KfP6pgEER9AjEF7pGhs4FlZslNOv3EifgncavDOJB
 fvrgpB6E5LM42BjNatN6RFxZyAB01bDzPhR9mYc1ha94+yVPTARCsxLHJeWD50o5gHVu
 r8oqChyJ5rIk21hApZ70EIgmF9mv/l1Lrrq0PTatm/BaRZurBW9uYPwZJ+LlpQGPSjkc
 HS+gSSasOCjpVNsW0zbZ9AB6sopZk2qqrS59t0iZ0r5UBfmSOPNRNeKxDlDiui9i0ojC
 D6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750387057; x=1750991857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEP9b/jbhHCZRE03d1UJPsiYjr50G5ckio9SNpMz3kw=;
 b=OG4VvZzH4J8w6fZptJON0VVQY74k0rhTujxrame2Ju0/NcZ2PBsLRe2mkU8s2vEcrK
 UcsXQXk1x0By6bFIV2AeJCBFpmApAbX8qYKI99OvdwGQbDvfcVij6mTbfKHR7Dp+yMUg
 tLTxYAC7/55gEhuG0Q/FSs6x7//JcfBQl0Oi99o0fxDdIgQ+QvtDYinW6+Eq63CY7iWJ
 XMgJ7b8D4tPyHCL5UDoX0Bn8A9eXg7/7SH2SRihuLv0l845p/JsZHjAnHF7Tb/bJI0EW
 C3F2iVJf7NqMi0s3TY4YXSugK5r4bJqHVIMI4pZ7sEOaWQ6UGoxGM72ineKOwM/SPD2R
 XVYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzKsFEZ0c4HMYQscT35hizfg2g7m0QgFatnbvtmVCyz/iGPP5Q4I1Mam3gtSVlWKwDletAqK8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8PFx0ni1VJfPfJDhhka03y9vDTftRTpO8iylValMyfh1PpoP4
 M7q090T8vg/SNAQpdcVqWsm7lxqRwe0OsruUN+ACJFjY67rZedgoQakqaFKKkgj9WVDZ6W+IIcK
 6bY87A6DVv9SZ0GzLmNq1mNBSlgngsH9pQyO9DitpMw==
X-Gm-Gg: ASbGncsMBw8PTCTFZO2dvrn6p1+M3+amR0I0apIobiW0fEOTLIyh9nR7t5b8ok17RPU
 wf4NVfeiyU1O/T3rMLGnJ2BY235em2w1lKbO6FBR6W6J0oLeYRiAVZRKnzr1E5TrIrk3mJ7v8Is
 +i3p+wwrfZjuZ7CGljjArEMVQ0HPW7t+TWTYj4acq0SYB0ni+eTKwO1cSvQDAkAsgilpfVu8J6q
 aGgiw==
X-Google-Smtp-Source: AGHT+IEzepUlZG6nQp6M+YA2RouALjMi4/T1feFkIkiYJRezfgQSnBKj0yXihcG87VzIh02JEFSz36srGhCdJocr8Rs=
X-Received: by 2002:a05:690c:296:b0:70e:404f:6714 with SMTP id
 00721157ae682-712ca535b20mr7833497b3.19.1750387056903; Thu, 19 Jun 2025
 19:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250112235843.25738-1-semen.protsenko@linaro.org>
 <be394627-0cbd-4658-a45b-7cbd4d1b4db0@gmx.de>
In-Reply-To: <be394627-0cbd-4658-a45b-7cbd4d1b4db0@gmx.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 19 Jun 2025 21:37:26 -0500
X-Gm-Features: AX0GCFtrG9ok79zAZW_-gZuDEi-uHnns5GBm5Cww8k4H95GdbOZdtcMt2TlzqkE
Message-ID: <CAPLW+4kcjK7om-7tSzOL0TcGpbAowwh_pF01F+EfvJ835uMzHg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] efi_loader: Call efi_init_early() even earlier
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

On Mon, Jan 13, 2025 at 1:29=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:

[snip]

>
> There are two DM functions:
>
> - dm_initr
> - dm_initr_dm_devices
>
> Before dm_initr() gd->dm_root points to the pre-relocation tree. So I
> guess we should not register the DM events for EFI before that point.
>
> Shouldn't the DM devices only be scanned in initr_dm_devices? Why is
> E850-96 doing so in dm_initr?
>

Sorry for the confusion! After further investigation it turns out this
RFC patch is a hack, and should be ignored. You are right, the issue
was in E850-96 board file. It was reading a firmware from MMC in
board_init(), which indirectly probed the MMC driver before
efi_early_init(). I took care of that in this series [1].

Thanks!

[snip]

[1] https://lists.denx.de/pipermail/u-boot/2025-June/592698.html
