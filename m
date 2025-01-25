Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BA3C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 17:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C047680EB5;
	Sat, 25 Jan 2025 18:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NB19y2mD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9E980836; Sat, 25 Jan 2025 18:14:04 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F8080ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 18:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5dc052246e3so6420728a12.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 09:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737825241; x=1738430041; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a1E5LyUmbBegtlNjee5noTkxH4ne/VkoRi4YTmLd/IA=;
 b=NB19y2mDWAOMv4zA8SVgeGEhTxE8ZSjh7Jts7obeyDi6BLez93G7z2pNeaCAIUwgN6
 507xcLSGizM6KI4Ru476fuQFOpOdx+Zn0a56dxsbbjFNaLXQs0JkhkSVp9vcR1Zljyoz
 l9a+uISQHousRLhDHbHJ3z30hc+ptzojxxcUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737825241; x=1738430041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1E5LyUmbBegtlNjee5noTkxH4ne/VkoRi4YTmLd/IA=;
 b=QZvLcqbXa6n6i+5hS7t1QtyAzFfEX/kYyIAmIzfOUur/Ct0ek57dSo4KPCpw9KorFd
 V53PJ3OzMeq19ZaZIc1K/eJHZ72omG2X512adbrJFQc7bHmpYDJuO22PHZhZpHqIyett
 pWQwhfKUtCtqctD7a+gB0SEt4mgohuGUojdJ/HIcDjtfcuPUZLgXHM5hwh51k1Xa8KWP
 uE3yFoBDUBR8beWlImfmuANk6coM8SLg6l4dhjiocSgUBIJfq+v995EsC09qGA9YmTPG
 rlFyytEi3T1m1SGy8FptUbpdybt1VIUKlLatCbeorKStXS9eAQqJg/VgADsoKtAkwMSc
 94sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxCm+QKiHhBoZezbgCXBN/VaohbEOihDiyHCeYe1qdcBUGkBNZ8ySAfJGRIX6d26TcnwI1cEM=@lists.denx.de
X-Gm-Message-State: AOJu0YwN+VAF9RIW3womxWYZowxCL+G+oRHeINufu7xEPVGZGp+OkeGh
 AKDhRB0IzXbnkQFpunjnxHPW/FeGPr8ijC1iqZ+1ro4+12o45aQyNmtPVOonAsI+holL8QU1Gaz
 5FAx4S8L1v7G1PVdywcippWKGb3ZDvJiwoJVZ+OmoxtCTz6w=
X-Gm-Gg: ASbGnct6PJFRvBogbAnUSaOcU8hW3MM8AddrnJ9xrPtJhuBCotVD0GAV1Cb5plmE+Bj
 +Z6EYsJOt30as5CJhn0F7zIhiPL5WM3RxJ4TmQTtQs/nrwzGmOzzK0s2S7rchH04=
X-Google-Smtp-Source: AGHT+IF46Tdap5vSCdJtSBcIsU+fjJpc577+6lTxo4Uie0+GJKHwJT6XwJ96CQ47rHwHvva1dPSDsu7jAz46cmhfXYc=
X-Received: by 2002:aa7:d858:0:b0:5db:e7eb:1b34 with SMTP id
 4fb4d7f45d1cf-5dbe7eb1d19mr12162523a12.13.1737825241234; Sat, 25 Jan 2025
 09:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-3-raymond.mao@linaro.org>
 <CAFLszTjYm8UBchOffiayzjbJrTsj0_HsV3qL6zwmAVQZSv++rg@mail.gmail.com>
 <CAC_iWjLM7dxJ8_gU0Fd13nfkY-_Z2ttsVM_rwNJ_dBoRQOF3wQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLM7dxJ8_gU0Fd13nfkY-_Z2ttsVM_rwNJ_dBoRQOF3wQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 10:13:49 -0700
X-Gm-Features: AWEUYZm4VDifiCJhvU69K4ljBVyL-pBAyU1-pt4gK8wzaxNudyG2g0ny555AjDo
Message-ID: <CAFLszTgX-p1TxPny4oGNWLPx_piEYh_7PkgrWUYNQsaFbEJ6zQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tmp: add TPM2_PCR_Allocate command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Tim Harvey <tharvey@gateworks.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Ilias,

On Wed, 22 Jan 2025 at 23:23, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Sat, 18 Jan 2025 at 06:31, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Wed, 15 Jan 2025 at 13:02, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > TPM2_PCR_Allocate command is required to re-configurate a TPM device
> > > to enable or disable algorithms in run-time, thus this patch introduces
> > > the implementation of PCR allocate APIs and adds related cmd functions
> > > for testing.
> > >
> > > To test the feature, ensure that TPM is started up.
> > > Run pcr_allocate command to turn on/off an algorithm, multiple calls
> > > are supported and all changes will be cached:
> > > `tpm2 pcr_allocate <algorithm_name> <on|off>`
> > > Run startup command with argument 'off' to shutdown the TPM.
> > > `tpm2 startup TPM2_SU_CLEAR off`
> > > Reboot the board via `reset` to activate the changes.
> >
> > It would be better to have an automated test.
> >
> > You could create one using the sandbox TPM, and you could add a pytest which can run on my lab (coral has a TPMv2).
>
> The sandbox does not support PCR allocations and I don't personally
> see the point writing device emulation code.

The point is that we can actually test this code by putting the
emulated TPM into a known state before each step and make it easy to
debug what is going wrong. The only way to do that on a board is with
a cold restart (so the TPM is reset), if that is supported in the lab.
I think the QEMU tests are useful; they are somewhere in the middle of
the two extremes.

> The TPM subsystem definitely needs better testing and I've already
> discussed this with Raymond.

Well, the TPM tests don't actually work at present, or at least the
board I tried.

> He will start sending tests later on.
> We can test simple features on the sandbox, but whatever complex
> features we need to test will take place in QEMU

Instead, you should spend a little time upgrading the TPM emulation
for the tests you need. It will pay dividends in future.

Regards,
Simon
