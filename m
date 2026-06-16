Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462BECD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 08:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879B984869;
	Tue, 16 Jun 2026 10:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eeLSv01K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433F284884; Tue, 16 Jun 2026 10:41:32 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3A3846CF
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 10:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-660e9fe3c3aso2465094d50.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 01:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781599288; cv=none;
 d=google.com; s=arc-20240605;
 b=a1e5IJB835OumMP3sfTWfn0HatrYf6qXWHS6gQImcXmWvAUjTSxY3y6rHegs/KNQAd
 ey9Fd6Vvj3oH1oljuwTLOrMn+m//iAsptqErFXjyqfrDIuWL9Q54+nMkTXL7kvGL/r5b
 b2S5sMbE5eENrcbwBnE6zUNIB0B3h407ndVU5LR2p/EmBildr5ImsqxbrjekQViAxrF0
 9zVplKbA2z62x4mQWL8WaynAuCrG6Tm7xxTuxCfg2ABcxCyaOsuV7KlOJHs9M/r6TzcK
 B2+VtWiIifsAepk6RnI+6bYmWwaUVk32WBbc/x6EbB16+8AKFZ+4D1yW1wTCKAUwQlrO
 4+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LvQw8cDUfD/465RdzcnFvxdvGWX88meFoDGrr08dVFE=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=QUTFzW/zpW50kenlxNygpEIjVGIV1yHnWMm0KwBpw+49aYFzIxxyuisW1otnrTl5zQ
 bGXI+3Z+/t9RqiN5M4zPmT1xzYyN5OqkYqnEJoKj3+9O0TlctBFMBiLYBiVIFUU7LkB9
 X91GpYlwd2qFskQdopd4Yx0QRzNSIAqzvcTB6LLCy2P+7z2GZLrc2FTYLLTzZAzB+/85
 TSQe8UO4G1zhP47yw4h5/aUDxRF+3cuhv/3upHe9mmlae1AwWz2uWWep2MznJXoJTMAz
 /7//Tqt8Gl/4BodpX44x+U2CF7XZ8RP2Osl1RUlgQgyvsqDZpCqrDpj9cfPLgLMQU4cD
 6h2w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781599288; x=1782204088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LvQw8cDUfD/465RdzcnFvxdvGWX88meFoDGrr08dVFE=;
 b=eeLSv01KoNuCyCccz1serin+/NuEFlfOyXeVF9nlajS14+Xin9K7WqIp76Iy1+JsWC
 fOoMb0kATltQOUDXG+ddutMyT3JDL3IZ/Cti3fu+3E4ceLW2jMPCWOBHi6P3Xsntl+hN
 9LfGJN0V9Kwz5uw/upXXglzG8wb5KTaqxDYK4OifPxkP6D4gLwrsoQaIUZ9xpae3u1Eq
 nhIjszvCA/HrEvera7fdpNCXclmGM5XS+dkDZTwazZCZnCSIPuV8nLSxGiOBNI9IGFlz
 gpw0EFPXvmO5DDmAuCADk9zUIU9XSb1z5tWrIQCtOH94B4slhOHUXUCrrB2Hy4+FroEB
 Dfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599288; x=1782204088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvQw8cDUfD/465RdzcnFvxdvGWX88meFoDGrr08dVFE=;
 b=AtQUXD/6KmE+XS0khggLvJRfgDOLmcPYozjUK2S061erksShh7IT4V1jcgoaFRGRB3
 EIE473ng2h+ca6xUMh8cFSAgyfkq+GP+Q9GP5fHSUCDb+YXbOF6Sq4X3K0I7kWZ17aUS
 wE0SdEKDCJigpYKXplWLd7Ah006ELNGmnkJXQK1NaducIlhhVgvF+AYM5eLbfCt/mTed
 j4idwzSBj17P9ogyiCo2frZbxf3K8j2s6qnKHUBw/CPTjirqn9cbrDvjqaxNtPDnp858
 2jxad/4vEQ1HINGqkc0GalZRqURNRhipNRzWm8oAwRZnpznFP+kqZ7kUwqAfBctgR63w
 0qdw==
X-Gm-Message-State: AOJu0Yy/7crFR3moaoRLCwTLzrIObbXOG+sfq1D6drliiQFuJDG3RfTa
 nM02lRamZ2Flj4Xidb6oe/3PrwzeM7kEcWECtIc5AYPhebvpaAWVpszGMQ3PQ+F9Y10TBKI9UDQ
 xjw2AsIKWzVKbiGCQMPWNuf223REjdIcCUuDIC9TQmg==
X-Gm-Gg: Acq92OEBpDmMg9R510k4BdVdm18954wZnIdFrv56rfdjC3LfKq2vKJbGMmRNqP5pi4n
 JGoYtKvwSLkiznRgakFtTPLKyhvj0ahh4meoMs7Pjzt+1K+CrN94mo4JM9DuE6uM20MQLEZ5q7h
 iZp4Rdk5sfOljZc29lH88FpHaFnNTML1vwyzdKfiY4BlcuTN/G6OVyWQwOlBvH4xbFNMI+m0Lxx
 xC05EeKwteHQnyB6qMMjnbGOwh+tCdvYiODDkWmOaXp9gDJADVcQjg744Qa4sww5AW+PDPEO5PU
 b8XKtAuijA/yjo0I4ktRgvf6LCSUg1t+fGlb9jYjOXPv7Syvm2QjpgDEnMHXshKDWN5U7Y8VyP2
 Xd94VYmjJWCCfEkVPfRR3smUNqXKj/uZF60lfGQ7JtCIO/03Z6lvGXwcjDWGYk6Fq5Hr224iBTc
 nrvGtok5udQYgI22VDJRkDPSkfu6Ki1urpMT3gdhtxMzgIK2TPv5MMtn6CRh06shETYBow1gSQC
 TEwZHDfReWJ2hea8P+Lu5NXoOQWyKpkQwiMjORHwZsMOLuzSzxXVjCWCwewpW54WbT9OcM1aDYF
 Oe+zmj6JhANGJCaXp5WYMCQzwJl4siCpJgqk/+mqJWzVq1cCs6pjuFsnwmPTmEi/DyGiI/zGgiN
 qdmec5Q==
X-Received: by 2002:a53:d00f:0:b0:65c:513f:5a43 with SMTP id
 956f58d0204a3-662b60dddc3mr1652629d50.22.1781599288399; Tue, 16 Jun 2026
 01:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <b7449d8c-f4ce-4112-9060-3f76963813d2@siemens.com>
In-Reply-To: <b7449d8c-f4ce-4112-9060-3f76963813d2@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Jun 2026 11:40:52 +0300
X-Gm-Features: AVVi8CdS3AU7Xs0zJCT5a8J6p-gmXkCSmDGarwsfrhG7ePsc3ux1hz62oUnFJEw
Message-ID: <CAC_iWj+twmGF84XQTHRuRXUU872Zr6W2_C53KzKS5oZbOC43Cg@mail.gmail.com>
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

On Tue, 16 Jun 2026 at 11:12, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 6/11/26 11:57, Ilias Apalodimas wrote:
> > On Wed, 10 Jun 2026 at 13:52, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >> [...]
> >>   /**
> >> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
> >> index eb6afe49e77..db3f6f486e9 100644
> >> --- a/include/tpm_tcg2.h
> >> +++ b/include/tpm_tcg2.h
> >> @@ -162,12 +162,14 @@ struct tcg_efi_spec_id_event {
> >>    * @log_position:      Current entry position
> >>    * @log_size:          Log space available
> >>    * @found:             Boolean indicating if an existing log was discovered
> >> + * @allocated:         Boolean indicating that the log was allocated by u-boot
> >>    */
> >>   struct tcg2_event_log {
> >>          u8 *log;
> >>          u32 log_position;
> >>          u32 log_size;
> >>          bool found;
> >> +       bool allocated;
> >>   };
> >
> > I think it makes more sense to define an eventlog state with a u32 and
> > replace the found boolean with it. e.g
> >
> > #define ELOG_FOUND BIT(0)
> > #define ELOG_ALLOCATED BIT(1) etc
>
> Is there a specific reason why explicit low level bit operations would
> be preferred? Since the structure is only used as internal data
> structure of u-boot, what about declaring bits like this:
>
> +       bool found:1;
> +       bool allocated:1;
>
> Looks like that style is also used within U-Boot.

With the patches I pointed you at there are a bunch of booleans before
this as well, so I doubt declaring bitflelds will make the struct
smaller in the end. Padding/alignment will probably give you the same
size.

OTOH the patches introduce more states that are conceptually relevant
to the eventlog.
The updated struct looks like
struct tcg2_event_log {
void *log;
u32 log_size;
u32 log_position;
void *final_buffer;
u32 final_position;
u32 last_event_size;
bool get_event_called;
bool ebs_called;
bool truncated;
bool found;
bool allocated;
};

The TCG2 code behaves different if GetEvent or ExitBootServices has
been called as far as the EventLog is concerned. So I think it would
make more sense to encode the last four booleans to a 'log_state' (or
something along those lines) variable.

Thanks
/Ilias

>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
