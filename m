Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D393CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 09:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF1D849C5;
	Tue, 23 Jun 2026 11:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RsJ+bLqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66462849CE; Tue, 23 Jun 2026 11:42:51 +0200 (CEST)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28AB1849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 11:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-30bbe98c3f0so10382568eec.0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 02:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782207767; cv=none;
 d=google.com; s=arc-20240605;
 b=NFKsM0Erk9SJ2nsF6WDNbk4RPCk+CGkWy5fbDwL7P2CfnHBEFdGg4T+MnNSmCyx7ck
 8g+6dTLu1F3mW3tgmewzc3Tt/pk11NXvvVkgR+Ttsz3KvpGRZIHtgV3LifAiZ6YdAJAp
 nQRhSuVlkFY3AtT42pkw6Ul0CeuZqybLOvkIAKGGJri3Rt427CaUeopbFg/QO8izFg+n
 fTLmaK7na9bHr0JVf1s5prnHG5AZ4GJ4cty3UJABM8XAKKE86N0PlXG5Hrbg50edLOxO
 pfkf+hAEt4eGn4lZHXhTtmH9mo7LZCDWc4hc++JHnlOgakmDTX5JobGZekUAqwBK48cB
 INeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xvta7ZL8YIktGcPTRt//weulLDrx0uWseJqn2V/H+5Q=;
 fh=yhzy5YT8XMI8z2O5Icaj7D0Wz9zv6LlAkU2kKa5KxXk=;
 b=A5F9ugLQ4cd7bJfjGzSHR1lvlv+ieVprpCqYs/ZXHVkwm85Hx3lTP1nLJOr/rgcxcM
 JVr7qsJ9TkDdjf375ALrz5fLx6sXGo6hbduilzB4ayNzUDHOiF1zf2L+HnF7soDQENhS
 bCbvPfJcYc3M4WA/W6D/zzaQrHrbH+HwICRgsAcLlwkJXZgZud1NbXzMRRteTQeLFOdt
 qS+GuJHUc3yZYSgAex7FYNBU83y1L7SrnDkJgaFjkrVNkdOHzlQIwJThwN+DmhbZqgL6
 NyEc7n6xCTCWhSuthsx1BJ83D7yOfApt8QitATJaGtTNVC7X7E4vjMRpCKJhPJj/cC5T
 p5RQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782207767; x=1782812567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xvta7ZL8YIktGcPTRt//weulLDrx0uWseJqn2V/H+5Q=;
 b=RsJ+bLqvV1xj1hI58ekyMzL77TUJPCTOiQwYbdZmG1yJOpt3VuMgksWufge+vpK6Ex
 PR0w6IfDqMRyrhIaK1EMM0QCW/DcDYX2U3frTet39F8XUAU8689XbAb/japAd7IXPzAG
 h9WwKGQsNCf3MQITrq++s+69Lf6Qb1FRqeJXIgA/CUfGCHkjbL+2deHDOhvMTA2jtgZ9
 Sp64MiJTKTFzbmezzZft+NnnmC1svhXW01REcAht3Rz0dZuYpd03Q0IPeU2FP1thcGiM
 zwDO5AKlLYdrTuFgccZXAxQ+PU/A4ke17ofl+LyQosyKTO5sSAd0VNwJFwd8lm1Y7OJ1
 hUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782207767; x=1782812567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xvta7ZL8YIktGcPTRt//weulLDrx0uWseJqn2V/H+5Q=;
 b=UVYs8Tk5y7Yqs12NH+KWksY+yzh7j6iyv2pY5kzZXP6SX0sba3sSuK7W2+u+SXAySO
 89wRV6m47BHgo8CHUQLdolY/kk9BJ1Yrrk1UxYXQMRwaV/eKg9h5oa8Xot2T5qozvsR0
 nMwhCP+jDkRBxjdXITBnozHliP5FmBKjrBOq+uLwOYcID0r/phQnavO/JakQ2f+4p9W5
 VgKfFau00CIMeTITC4U3cTeoNYaX4abljeJOG1XfxFMccy14+wzRXnEkgmpv0Vt/zTev
 ywKEmb5s6tkxqaaijr1bM5KHUa0h0VXYtHf0LVIb0Bg90HJn7J9yaQKiBp8wwXGXPbT5
 WJ0Q==
X-Gm-Message-State: AOJu0YyK4JZYOWdVnvDD+BDLnaKxOUXKsKPaaoti+K+kh+C65maztzBp
 QbHwMkBIheCjLLFh0Jfui9VNyLLWHh5O0wkLcqaY9FPdDbHcDea1UtrcOjQD/fiUwW5MXcnX5Yo
 zNayWDFXoyI80EhYIRiIq7JChtMYICOQ=
X-Gm-Gg: AfdE7cn9af0O57kdgToBVusNThShKZoapJ+VvMGN3nFYwjxlEtM7bUjltv/8+e087a0
 1+ObawEB2LXhP0q2y+JYzngsaK2wgxHG6nO3iRVeGp4iRlfA/SFnNMvIyVIsr0HcisIzJgDhRcg
 gPn5EX884i6f4Z52MgErZnlfMxNQFQVrMoYv1qMJe0BItRP87D4UGnjlDJFn/FAaHxcwrHP24wy
 fttJmLMNKcDuOR69AGeGabimps4kf/V0WpWy6UxqBfitBPez+3Q5/ZkaZkOJrTfMa182L5eK2mt
 Be50hQ==
X-Received: by 2002:a05:7300:53d1:b0:30b:d31f:1577 with SMTP id
 5a478bee46e88-30c58c821b6mr2031221eec.34.1782207767359; Tue, 23 Jun 2026
 02:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
 <0ee5047b-3421-4657-a4ef-6261954fe526@cherry.de>
In-Reply-To: <0ee5047b-3421-4657-a4ef-6261954fe526@cherry.de>
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Date: Tue, 23 Jun 2026 11:42:36 +0200
X-Gm-Features: AVVi8CegFDzwP2ZqUBd8D8v5G-BFBM1MqRVL9KubOest1L0JrGnPsLflju83yIQ
Message-ID: <CADU25KKvYc4xsPY6E7-r_pQvuKAdMBY3w0D+-R-x=zh+vfL_5w@mail.gmail.com>
Subject: Re: [PATCH 0/2] rockchip: odroid-m1s/rk3566 watchdog support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Quentin,

Am Di., 23. Juni 2026 um 11:10 Uhr schrieb Quentin Schulz
<quentin.schulz@cherry.de>:

> > Unfortunately, the TRM is rather tight-lipped about what each one really
> > does. Per experimentation: Setting it to the "first" global reset fixes
>
> As per TRM (2.8.4 Global Software Reset):
>
> """
> glb_srstn_1 resets almost all logic except some registers just
> supporting hardware reset.
> glb_srstn_2 resets almost all logic except GRFs and GPIOs.
> """
>
> which is similarly worded in PX30 TRM for example.
>

Yep, it certainly sounds like srstn_1 is the more "complete" reset but that's
mostly just a guess from the wording

> > the hang and makes the watchdog work as expected in U-Boot. This is the
> > first patch. As the PX30 does the same thing in its arch_cpu_init(), I
> > believe this to be the way to go but I am curious to hear if anybody has
> > more technical insight on this.
> >
>
> I'm not sure there's much more we can know (would debugging this with
> JTAG help? I've never used it so don't know). But it's been a pain point
> on various Rockchip SoCs already, I'm quite surprised the default is
> still global reset 1 and not global reset 2.

It seemed to me that the default is just "don't touch the register bit". The
hardware initialization value is 0 which triggers srstn_2. The question is if
srstn_2 might be the correct choice for some boards? As you say this has
been a problem on other SoCs already, I would guess "not likely".

I have a little prior JTAG Debugging experience but no usable hardware in
my private posession. (Don't think the Odroid has the relevant pins even
broken out). However, I doubt we could do much more with it than confirm
if srst_2 locks up the SoC or if it hangs for some other reason.

Cheers,
Andreas
