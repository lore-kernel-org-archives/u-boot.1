Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF72CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3B58341A;
	Wed, 13 May 2026 16:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QBy+dOgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FCA0836AC; Wed, 13 May 2026 16:03:33 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6503480F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bcc2b199c17so598897366b.3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778681011; cv=none;
 d=google.com; s=arc-20240605;
 b=Ff6pxC9u7B7OMOvdveum3nJV3DFB/d2UdazD4P7sLYNmJYp1XPJyQDCQGGvd0CbKeW
 lpNYWObbiJh3QUTO0N7WTOGAQ6EO2htz1qSJWoZc190+55LtVbzu7qKEY/Xa2X/zFWuX
 eUj8T8RikatP8vapbOI9WLNV6zsjrsJRWYRCCUZ/0OkpP0kGU9GxWfEW6fXITc8Wld/W
 zXJREbLpM+m/kvFirCNpfZDef2qfUgAzohn5QgezWHDE7D7YqfOqOWkySIx2pWSv2Nbd
 00Dv3mkCKl6s3pSxb5+lF/NeWUpGtSeX8VZMpIfgPvjQSGotLpFxzKFiXbZPy9QV3ZCM
 Bwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=akeRurVKZWLVgcZUm6O5jq1iGEdpAYHhLYqkkdgq1tw=;
 fh=BTFB4szhANUdeKdGhUtFNOkjp2T4RwfYw5Yk7MO0OCE=;
 b=BtNKmGhEOPvAGtlefi1ywLWKWKnODnol88SYIUtSUwbZQkbblW2gU40x/Eqen4xyHa
 Tlhr4dkirJBigDuG7svmtvOyR8QC+8fLBe0/XaRaL0M2yym+KQC+IipZHA6FX+HJ8+6o
 UJLPST78r/c554Rr5wFmrP7VeQK9niolMU5yqwEqdBkCGntdrGhG9bb5ZWIUnFTU0hrR
 nXfomrGJ2hWN+qyzAuEvZi8JPqtscOmHBPLlwFElY6atAej1y2BbrA1GWpWMDRjNOFTh
 5gcuk+V+/hOQkHx6HF/GqY/WrBsCs9Zw0vPiCR/XFQ50EyW3ZkJGNNQC/PRMrUxOg0yM
 lKHg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778681011; x=1779285811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=akeRurVKZWLVgcZUm6O5jq1iGEdpAYHhLYqkkdgq1tw=;
 b=QBy+dOgfPVX/eXLmcUbaHauISNft01CoRPFpEfhq7IZoTW8V3uY32oiB/d+W9WiitO
 rKsqdnUpeTRSbPBeKhC3KvBozhcQY/GSEEK9Hh4rRO37MDbdurw4FCJhp15Af/jlXGt1
 PCvoife0c9Gyl6HAgL6bxXsLoHecWyQtHM0so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778681011; x=1779285811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akeRurVKZWLVgcZUm6O5jq1iGEdpAYHhLYqkkdgq1tw=;
 b=hHFxLDHG3pXAFDzTh0IE0h4TQDNPKbPLriHEg4qe+kCD7jRU4LVVVko7+uoULVo5Tt
 EPs4TlkzVLnBleLw4ZexD65E23B7prSsbTGW8BbU70Wb5TxqwzNP1J10SarnSrvqI4tT
 kDDt5WA7WT6u3LSkvgCE79yUGPD/0a4GRbCuzvL0gCwGd/6xV3IU+dXnBnO8Al0LEi34
 j1YonnXehKqQ4z0zj0sAP9tLVmal78SpG/nN5XZwBr4RQlao2pzBhDGonzobDXPTlz4D
 /QqGMMLmBr0nfC278VqJ8lnq8Gmyy1TXtBQ++TD3Gn1oHC/csJIytd2NP+altyig7I/w
 eeTA==
X-Gm-Message-State: AOJu0YxccxQtny7CZx8CMscT6ibh1L+BwpWjdnk6LEHpu6oCz/TufMYb
 JGNFvCkRXnEzh1ir2rLyr9BEmekYyqoPIs0qzXFSPg5o2mP5zXx5dDCcPN8jKelMRK8jFR8nLzr
 leLv9iIY5yWXYR/4UmymNZnt5bbAJK/xPDXeDxULMi7zL6wYGDysIjw==
X-Gm-Gg: Acq92OF7G0aYPHWhTnGOqCVM2cz+kb/3QMvr/bLsmEM/Cytr82kLpURzFIJo7Jk0osf
 nilhvS8Gol48zzf/+hnKIWPzHEoIbjWWUMf16plJ+Z0J7ENvyXl93bqoqrRKrIExzqe2o5BUTfx
 45q3AezAllqgQY+BN6iym0GitVZk9OiMtYzuIP6XUMPD6UIoMxKaQ0Si/FKw9/7jGLxWkCkV+h5
 H1U7YljkRIOZzxAuAfx+qUGgLT74itHemqjNIFXZKqXwY8EK47/a1m5TzY6/Z2HM53fbUfKT4fV
 8jYokw==
X-Received: by 2002:a17:906:fe4c:b0:bd3:6a05:459b with SMTP id
 a640c23a62f3a-bd3e2505605mr192107466b.34.1778680990659; Wed, 13 May 2026
 07:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <CAFLszTjc1w3WTmXLbgQifH8ZBUyN-sF-NQ-bvYq45tqWscVuZw@mail.gmail.com>
 <48643850-76b6-464e-a317-d3df81291a7a@siemens.com>
In-Reply-To: <48643850-76b6-464e-a317-d3df81291a7a@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 May 2026 08:02:57 -0600
X-Gm-Features: AVHnY4LVd5WVRkk4OAsyji55MGuyb526rP5jzxTDFL1p9fgFWSK7ZHu4SPPDcAc
Message-ID: <CAFLszTgG1Q1LdS--hY9K6cSr+H2dbzQ3qkvEyUCsEJDyGRbfFg@mail.gmail.com>
Subject: Re: [v3,0/4] Improve FIT signature handling
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de
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

Hi Ludwig,

On Tue, 12 May 2026 at 09:26, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 5/7/26 18:39, Simon Glass wrote:
> > Hi Ludwig,
> >
> > On 2026-05-07T12:06:22, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >
> >> (optionally) enforce signatures so we can't accidentally boot
> >> unsigned fit images.
> >
> > Since you are adding a new policy knob (FIT_SIGNATURE_REQUIRED) and a
> > new verifier path (fit_all_configurations_verify()), please can you
> > add coverage in test/py/tests/test_vboot.py for both the
> > required-but-no-keys case and the iminfo signature path? Without tests
> > it is easy for a future change to silently regress the fail-closed
> > behaviour.
>
> The function also tests image signing. That's mutually exclusive to
> having conf signatures required. Should I adjust the function to not
> expect successful image signing tests when
> fit_require_config_sigs is on, resp only test the fail-closed mode if
> fit_require_config_sigs is actually on?

Yes you can adjust the conditions on the tests as needed, or use pytest.skip()

The goal is basically just to have test coverage. Sometimes we use
sandbox and sandbox_flattree (or sandbox64) together, so we can cover
config combinations.

Regards,
Simon
