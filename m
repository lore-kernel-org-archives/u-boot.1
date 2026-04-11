Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C96F3ED50
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 16:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDAC6841CD;
	Sat, 11 Apr 2026 18:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="act1GqmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF61E84154; Sat, 11 Apr 2026 18:41:39 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA086841FA
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so19478875ad.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 09:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775925695; cv=none;
 d=google.com; s=arc-20240605;
 b=F5rYcbX9IHQnAcSGVdilEx6Dxco8D1LwaitGLOCFwRRit4+7qMri3g7ycfWFHEOE6j
 Sh9fIOwY1pMsZ2syzbu00Kw+8Qa714lnr4le2p40EWO9qtjU4eyizHQxPwdXD4Akdqe1
 G0WSARvxpncSdpDxzmKzh9DTSPOCGSYR7nwHQc6mRRH8twGN4wQt0bv8HjWSVmWngjsa
 qWf0T4nVYF7rff8Jhf/qsb2jG00T/6eAz2ArYG7jww1tP88mc/fFIf73lfIdz25YZwmc
 M79ly8UwwL/I22F9+vzBh1WCTCvWb3pgvpW1I0k+wU+tEB2fnm957bzsHcWmFz/HK4/c
 cotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aCy1d6icgFpeu/cOcsCQVw55m+4VPvGBMpjvNF7iu/8=;
 fh=zFVo0D+oitaL3GoMfL/Shio4UNsBj5Jcymm2+84UAqw=;
 b=N2K2pRPSGmLZ5608qDsccJ/JeZ8daapVC3UK+kE2qg9uQ1NuwdhsqBzaz8zJkxwN7/
 wOMOl4p+CHYh94Qph6tGzSnkQiiGiQJsRELjvEjOdDUUHPbBFt5apFqwjtU5suq6pHd/
 ZZi8EvQk+3oIDgDLDm9fl40DkdsuLXLqCQh+kL5wpRt7WslsmTKULAZBiqrVLRvDxIfl
 vLVcChm7HepRn7Tsy5W/I/b14Y2j+oYP28Wl9PUigChjUoPCZ2GTUkI1+ksqG2O7PV92
 c4cbpImmizwA8yl+rpXBQmyYj7BbN/PS4vT6o6HHdXwbHW7v0HsFPNPNi4CoedWGrhIL
 ixfw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775925695; x=1776530495; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aCy1d6icgFpeu/cOcsCQVw55m+4VPvGBMpjvNF7iu/8=;
 b=act1GqmHl2f2CbDv2Zgjy/LMwHIshXORi0419S7nIf6k8wqBW5jVlhYddFOAhu2WCK
 8CHVwoWAwAEvlJq7SFyEsyXT/Jw1DQ50klij8S5IWNSWwT+SSwlyQsE42Xrj1ArqG4rd
 wtuAXpiYKcHpNSF/oABnCFVM38uAk+83+NXsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775925695; x=1776530495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCy1d6icgFpeu/cOcsCQVw55m+4VPvGBMpjvNF7iu/8=;
 b=A2AP91CirspVuI5Xpi1kW3p2PDj/ftGi3ZW8ES5kbg357Q88hckFSO8J6MSCvCgVQf
 K5bYXBfsP1tQ1OM13ZC+Vg3THlGeSfRL3yW8H6d3gaseTEEbLeYd7zXTBW4Tnx/tOReQ
 ZfVw0zFwqk0lw6dmxBlxMhYozUmUquL5+n1ILLUOocCwr9oqRyiI+qA1qdgcBYwN1KB7
 Uof5Vbzy/SC5n2jiYoLgY7IhhmrZL5D5Hz3XMMhCAvKvRTlrLFAPG7KTLGu9uRBIc6y6
 IoK/uNTip5EUAQF7j7J4h00g21QzO4hA4aqfHvPfIJDKkCCQ8Q7jP0jWz0TGvrJmby5W
 K4PQ==
X-Gm-Message-State: AOJu0YwcYKEejsaTGjgvON0a8WoKa9vBezdzEsDE8OWQFk7SVDuiTLMB
 nUMREmm9dxiuysV3Ea+Q18QxSdHfbRkv4j3NEK5jn7bfivbNqfc1rGdApL+rMdYZdVg2ZrzV8gG
 ikVsXniZ2PwEgJOibqBnjHUV1eOSA5QT3fjyH7/s1USUzkXlQMBDUjw==
X-Gm-Gg: AeBDiesWcoFoKfE2uX+EjU2dFmwEWf8w3/nmZmqRqeLjswKl7wFKsW37FnDyKLed+3q
 lYOEel1Kv0wyUdR3NniOCRFewxYZxSF2V6+k10D/dymhEJ7njcBYuZ6xM5DfKxDui9gqQJqjTGD
 cqf6ZCW+XQrT43Y8dtnj5q6rSZRmszQy6MWJw/p7uzz97rlb0OuJ4/EaFS49NXt1R7jN5rEUoJk
 1qTVf5xPh3UNmRb/8s5Sniypa/GPKcWdhgPUh5ZAC7y7VdkpdUYmvjkFUo7U0I4wETEHrFwX3Ro
 3r38eA==
X-Received: by 2002:a17:903:3a8b:b0:2b0:5626:f75d with SMTP id
 d9443c01a7336-2b2d5a1c699mr83605145ad.26.1775925695343; Sat, 11 Apr 2026
 09:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260407063453.18679-1-gregor.herburger@linutronix.de>
In-Reply-To: <20260407063453.18679-1-gregor.herburger@linutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 10:40:58 -0600
X-Gm-Features: AQROBzAeqX1iBtyiMca-lBQtH8lh19VfbCMGOEpg4Tpst1qfK2ZYskCVSISSXSk
Message-ID: <CAFLszTgf3Zo0qMzz9hk+MRrxwzTa900LTrfH8gELbys5B7C33g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] console: add console_flush_stdin()
To: gregor.herburger@linutronix.de
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, David Zang <davidzangcs@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
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

On 2026-04-07T06:33:10, Gregor Herburger <gregor.herburger@linutronix.de> wrote:
> console: add console_flush_stdin()
>
> Add a common helper console_flush_stdin() to drain all pending
> characters from stdin. This consolidates the open-coded
> while (tstc()) getchar() pattern that appeared in multiple places
> across the tree.
>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
>
> cmd/conitrace.c              |  4 ++--
>  cmd/eficonfig.c              |  6 +++---
>  cmd/eficonfig_sbkey.c        |  4 ++--
>  common/autoboot.c            | 11 +----------
>  common/console.c             | 12 ++++++++++--
>  include/console.h            |  5 +++++
>  lib/efi_loader/efi_console.c |  7 +++----
>  7 files changed, 26 insertions(+), 23 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
