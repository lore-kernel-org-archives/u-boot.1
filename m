Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8369ACD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 10:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6088884119;
	Tue, 16 Jun 2026 12:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wxlVXw3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C74846A4; Tue, 16 Jun 2026 12:33:27 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E7584105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6607048fa62so4134258d50.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 03:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781606002; cv=none;
 d=google.com; s=arc-20240605;
 b=WgGvRKCzUoCmok4qCmCXqBBsIDML3KcSb9K5nwibC9Z1SlnMFkXlAeYivmswMTdIep
 texTw9eGhKVh9jscI4/TEWglOgR2bm+0Xg3Xhm/ySSgdYoyYVR/QXmEQzq/TiUwVmeQV
 8NsHvgJ7f+xQEpAVJ34qIV4PPuei0JsFvU5WJQpioleISEE9j6lS9KMw4kGso07ppuFW
 BcQWuhTVZeUEXBZnDzOd0fjbU/5JuLCAiIWcJQo1r0zip6Nef0lhjCe81Sz3jfn3Szyw
 0wnf7gZUp8WVWBMlxC90aEKZHTkOr4JUY8Tt6kHK6pgwJIle32+K3tgSjAdSCe1mFWhq
 8OGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GhAIzyaRQhl0zbHQf56VSONYlRH4x2Ao48MzMoUdQco=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=lhIMPA15fHN/SRbrsmGVCo8OwpQ3ylgsgf+i10dTdttX7ObvBTmVviiDx1AoVV2/Nj
 Aeq5bF56tBuYll/XshBq8whztasnHKnlPHmC+3N39t5Z+nYE6eX1B7OGkPvS+h2YCytS
 WL9yB3tkA3t0SCZ4La+fNs3luyxDlM7a919MlwIMkmrXMC20ZDe1KYLCJdY3fNig0F30
 Gd3JW+ybp8YDlrMY31wqcSrlal6y1aNZiUQFGWcpmpaD+JZcvCIdEk9C6FwHMugzZOi9
 opTa32dp/n1jKLZIU9btI4OABa6vvvEnIpU5MI8fpX+3zxqzN06EjScVYePWlN2qnyFu
 26TA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781606002; x=1782210802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GhAIzyaRQhl0zbHQf56VSONYlRH4x2Ao48MzMoUdQco=;
 b=wxlVXw3uBZkgWrbZcr6o4yXBGVGFjI5VViJKqzO7ilJcGwg2m94jJIyh9bde/dVmhY
 nGH9Bq7CinrSMRXWtiaY/xjSgk0ZZ/swH94pa/FIMK3tNOeFjvDcD4oMfqdU0cbHDq1L
 cvFyjqdQRIkYeL76YF9g2oUunWSRvMDX8zyudfIX+BMlQl1yNgLwIrYkDnCcEt25I0Fd
 wwSPafYd00bd44Pz7yUZqigaJXnGhsFik/NWjkh0TfuMAtNzNZLlhUJi5rdKEgz0xiTX
 ugKGZfE7mNxwtud0qjB+tqRW2YdzaMEYx46t8L42uYeO2q95IwYZ/JTvCGxOg4SoXBnp
 UIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606002; x=1782210802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhAIzyaRQhl0zbHQf56VSONYlRH4x2Ao48MzMoUdQco=;
 b=csEkrWYJtXZ1ceF7hfgtrmL+0mLa/zNkAM+iIj38miHL1shNrZIdRcqk2voULtqaRS
 38yyhRY+BMc3ythEpM0OCkZXrs9ut7rWQNbDlc+WBdoVNgRPxDpknCo14ulB9m+kNhdz
 zmRc6aDJSGOL5uYgl7btAqcsht2zEtCWEAgxvRO6cL46wxtRYuCaFtvhxDUZQUTMnG6b
 LQKcPJXsGlEOhJzdO9L7NPx1AL/F9r4aJgds7yuTfWr5zCdklSHscwMrlv1FbEziuGB3
 p1BOpkQS996+a/rfabwWLqMNOOgZw2vBVSlAIe5jS6Ddyga2XoKRZ8aSMWvws5zz/Zaq
 74mA==
X-Gm-Message-State: AOJu0YwpJxjS/wVAOspZ/YRDITF/e39Ijd70dJJcv5ociL4CwTCxko3z
 VS9nmqqrkhBh5utnXthbeloAewY478TKMjE01LqJbcbWu0UwgPv4tTuHAMUuY4jS0Zlh21e1vuD
 dq+m7Cv6bE14w8Aa7u/cq7mQ5500MQGhaKQJWafWRjA==
X-Gm-Gg: Acq92OHP9Vb2Wh8Q8lwpJr4I+eHfQtzlQrQApMh8EE8Acpvx97ja5bCNd3IUrfymxfu
 QqlSfnYFO4y5hjNvzL4IsxQdhfRZp7wyvDfuNX7hcMfumBj1ml1xJ01XZa3RS52IEoXE8vA4LHE
 lqPpYBPTPfqJVabNVgrOH8ojLMmx207N995hGP/kZsUCqLHZ6Wmu7nGbGkLp8J/cOFkY2kpPj4b
 c9uZWvB3YHgGFPfKhapy5ng+bcf//PHEpHflk3ZEPNQhzYGWN6sRYXPuIl45ZNYPnnJ1oNhmka1
 Y+zFxYuOwkTC/O6EOOEVWjKHXVNoOffVahs3+u1/0v1JdyihHMlssXY8pFDzPwOkkmQuT0ts2WM
 dK9SSqP71VgN7mDerlrFHpOtS0z6f4i0A7XgnhfMV9BWxamdjbwR078G29B0ZIZCNI+RsJKx4BI
 Nf99WIYK2noJ+LiPFqjwRiJm5O8hxxbZ+SSpXozziFPvVk1JW4c8izA+KvYuuxQhWg75t7Bvmop
 TV/RUn7aMjEKX+FEWrnItNJo6UQqZrqgWpG84dYZVB2ORwEuoqvxLnLXyzQEAnVylWZqEgIBCil
 XrZo8psteG5MFPQhbNMiJwyB9XgJLTRzxlsknDSVSax9SO8DLygxkFyWO6cVY8tK+so2tw5+MXA
 LUYaaQA==
X-Received: by 2002:a05:690e:150d:b0:662:b4ae:f37d with SMTP id
 956f58d0204a3-662b6183fd7mr2303325d50.37.1781606002453; Tue, 16 Jun 2026
 03:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
 <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
 <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
In-Reply-To: <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Jun 2026 13:32:44 +0300
X-Gm-Features: AVVi8CfY0l2cf4H8uJKkDMiEsBaz56O5wd4rKnnVArAmgQ0m-IHV_TGxFMW1XWE
Message-ID: <CAC_iWjL2f6oHSfGYtiDy2rPUzpDKRdwR7RvEJUQaNqxO0rc70Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
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

On Tue, 16 Jun 2026 at 12:39, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 6/15/26 15:25, Ilias Apalodimas wrote:
> > On Mon, 15 Jun 2026 at 16:09, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Ludwig,
> >>
> >> [...]
> >>
> >>>>>>
> >>>>>> I'd like the eventlog to be initialized before calling this (look below).
> >>>>>
> >>>>> What if I removed the log parameter from those tcg2_* functions instead?
> >>>>> The event log belongs to the tpm device IMO, so should be initialized
> >>>>> with the device.
> >>>>
> >>>> Measured boot EventLogs etc are primarily described by the TCG specs &
> >>>> EFI and we only have a specification for it there. The DT describes on
> >>>> how to pass it over to linux with sml-base etc.
> >>>> However, in the EFI case the Eventlog is allocated as ACPI memory. So
> >>>> you cannot allocate the EventLog a priori, until you figure out what
> >>>> method you are using to boot. We also have use cases people using it
> >>>> only for RNG, due to limited memory, so we can't just allocate it on
> >>>> the device bringup. And lastly... Some first stage bootloaders do not
> >>>> initialize the TPM & drivers. What they do is prepare an EventLog and
> >>>> expect U-Boot to replay it once the TPM is up and running. In that
> >>>> case we obviously need to preserve what we have instead of starting
> >>>> from scratch.
> >>>
> >>> Ack, we are on the same page here.
> >>>
> >>>> My main concern is that I *don't* want the EFI and non-EFI code to
> >>>> deviate. I have some patches that I am playing around for quite some
> >>>> time and rebased them last week for this reason [1]. If you think
> >>>> those help your use case or make your life easier feel free to include
> >>>> them.
> >>>
> >>> Good idea and orthogonal to what I am doing I think. This duplication in
> >>> EFI stressed my brain too but I can't care about EFI right now :-)
> >>
> >> It is, but the deviation in EFI is pretty minimal atm.
> >> - EFI calls tcg2_log_prepare_buffer instead of tcg2_measurement_init()
> >> -- That's what my patches fix
> >> - EFI has it's own version of tcg2_measure_event() -- That's easy to
> >> fix as well,.
> >>
> >>>
> >>> IIUC you are centering the change around calling
> >>> tcg2_log_prepare_buffer() in efi_init_event_log(). What do you think
> >>> about aiming for tcg2_measurement_init() as central starting point
> >>> instead?
> >>> That would allow to remove even more duplicated code.
> >>> It should be sufficient to have tcg2_measurement_init() accept an
> >>> optional pointer to pre-allocated log buffer memory. Attached patch
> >>> maybe explains the idea better (just as idea, won't compile).
> >>
> >> I agree. In fact I mistyped the functions names on my previous
> >> email.... I really meant tcg2_measurement_init(). The patchset I
> >> pointed you to already converts tcg2_log_prepare_buffer() to static.
> >
> > Replying to myself here, but.. In order to do that you do need the
> > unification patches. tcg2_measurement_init() will need to allocate the
> > appropriate buffer depending on EFI or not.
>
> So this is how it would look like with your patches on top:
> https://github.com/u-boot/u-boot/compare/master...lnussel:u-boot:tpm-with-ilias-patches
>
> IMO the untangle patch is not needed. Does that look sensible?

You can skip the untangle patch the way you've changed efi_tcg2.c, that's fine.

However, there's a few issues I tested for
- A u32 err; that's not needed in EFI anymore
- tcg2_measurement_init() calls tcg2_log_prepare_buffer, with NULL. I
suspect you meant to call with elog, since the EFI booting is now
broken and the kernel complains about an incomplete EventLog
([Firmware Bug]: Failed to parse event in TPM Final Events Log). But
since we've gone through that effort, wouldn't it make more sense to
have tcg2_measurement_init() set the priv->log if the pointer is valid
and provided?

/Ilias
>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
