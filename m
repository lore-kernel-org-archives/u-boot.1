Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14198C369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 12:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BA982CBB;
	Sat, 12 Apr 2025 14:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AI5ESU31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A02782CF8; Sat, 12 Apr 2025 14:45:06 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2130482BE3
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 14:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so530783466b.2
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744461903; x=1745066703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=elD7bHomfErXW0M+NrkDAtFojoMC//x9zVUz4j38oPA=;
 b=AI5ESU31OsjTRh0k7mg1gq8AxqqpCHrxVDpvm5aGJWThSfRYAg2TrI/m1a1/+Psx/I
 Be7O3sKRoXPBxSyGOSI2e4HB9PIQn+SmFRVESkxuvuyfXyErU9f4VvuF4fD7sU0rYQwB
 Ic/EXWy9zI/TLV3Ti9bzuTx8LHsnYzlc358XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744461903; x=1745066703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=elD7bHomfErXW0M+NrkDAtFojoMC//x9zVUz4j38oPA=;
 b=Dik/vaMWPyqjl2kczY9koSvnDsWOVgNz42DNPpDUgTM+a2rFadAn5UgTO7K+KP5V0S
 Boz0uEZeXRmecB+6nsEWUTDaswDxyHq17RtAsJgPfFMBosrBPp3AhMYQn8mTRI23g2gz
 2OkO8gMYihP5qT2kT1sLHmkpyc31kkk5sj4JjBhVUq7l3uBwdP+scS8BSsds4cU7TqfC
 kanUmvu9mEuYH3Bf8f3PRtodQBJ2SopSmAMNoxChyNkMRp6MtYXGWIZORdSBAuc33qP/
 6ePNaV6y3NXW++qfIhSCqZvub9n0PQ0KVZasoBF7Cv6XThmTXzzk0kkzCs4/PUEu+2xN
 jgzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu0P1Bs5lKAyG5l5pvJGBe6CAMo1g3jc0+Y+bzEMXGCAcL0c4i1VFcUi+MVcKnTRXV7wyG9mQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxD0MZseyfZTFlEOPgcYLQtXdqqiAj+Spbsr/x92KwFcgEVGzTs
 s3LIglYMbk8wl7ZstIKou84L77/s+8LHYsWiE2v50dPq/l81fwXvFYZ0+F2Yw3oi9m59frEEb5k
 Rhs8ditgQAwLna1gWKbDGcer4vbrszEukoQ7F
X-Gm-Gg: ASbGncuSu/BzJG35Mq/9aZrJXdeaO94ka+yQNxkDY21uglXdOo9J4Oa/hil9FN+avoM
 tVpG5XwmA05jvBsfLpOvHs4lkPJOzHJDXMmKmTCKw0kifbBcSRvhKZfH4exOimkcpFPOZw39T01
 fJJY97MhxFUf0m8oCH8FkXpWy/htqVFjKDhQ==
X-Google-Smtp-Source: AGHT+IHg4KQ92JVove1NeGzeVJKF9fRdnGAchltufcZmK0dM/t0izSb/8kMXJsuBV21sRaI7K+Mi9ulgt0XSy2maIXQ=
X-Received: by 2002:a17:907:7209:b0:ac7:3911:35e6 with SMTP id
 a640c23a62f3a-acad36dc23emr511971166b.58.1744461903466; Sat, 12 Apr 2025
 05:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
 <20250411153040.1772000-2-jerome.forissier@linaro.org>
 <CAFLszThbA1fjziOrLFfRwFQ+aP=FZuF_M4cBYsnTZAqEMr8LTQ@mail.gmail.com>
 <20250411184611.GW5495@bill-the-cat>
In-Reply-To: <20250411184611.GW5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 12 Apr 2025 06:44:51 -0600
X-Gm-Features: ATxdqUH80qQjZPL9g7UPL4yPRPoLCCOvI9l1gSVEroserVmHwRY6fa517BkeKPU
Message-ID: <CAFLszTj-t+2+B-fBL0stpn9RJ1-Eat_dQ2E65Na0PTCaNB=c8w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] efi_loader: make efi_exit_boot_services() call
 bootstage_report()
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>, 
 Adriano Cordova <adrianox@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Yao Zi <ziyao@disroot.org>
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

On Fri, 11 Apr 2025 at 12:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 11, 2025 at 12:32:12PM -0600, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Fri, 11 Apr 2025 at 09:31, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > CONFIG_BOOTSTAGE_REPORT is currently supported in the bootm command
> > > only. Add support to the EFI boot.
> > >
> > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > ---
> > >
> > >  lib/efi_loader/efi_boottime.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> >
> > If you have time, could you take a look at unifying
> > announce_and_cleanup() with the duplicate code in EFI?
>
> And the duplicating code in arch/{arm,x86,riscv}. Maybe there's some
> good place we can stick the bootstage calls, board_quiesce_devices() and
> dm_remove_devices_active(). But maybe not, I'm not sure honestly.

Yes. I started a series at the weekend to drop board_quiesce_devices()
but in a few cases it is needed, so then I thought about creating an
event for those 3-4 cases, but then I didn't go any further. I will
see if I can at least send a WIP series this weekend to help.

Regards,
Simon
