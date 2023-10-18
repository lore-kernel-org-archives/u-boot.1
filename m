Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C849DCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490DF86F70;
	Wed, 18 Oct 2023 05:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iuUzmcyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1790986F69; Wed, 18 Oct 2023 05:33:27 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0AD186F62
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so1097592266b.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697600004; x=1698204804; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7rZ6FDIE65OI2LfIpqpcDfiFCyPIcsCPsNOEpzvoZe0=;
 b=iuUzmcyV33XlSqmrAlCU/mPqYYNJuFk2bAz021pj5TDtQ7ukbKSNfJMf6PfBE9mKl/
 yMCh7FEf0uO26ml4JPBPcNOWdQ9B0oWUTTdjTLUeVKmxgb0ITbAZPw5ai1MNSZKx9Upo
 KMxitRXa7tgeHzxZ9L9FN3RM9c5MlAjOfhyXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697600004; x=1698204804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7rZ6FDIE65OI2LfIpqpcDfiFCyPIcsCPsNOEpzvoZe0=;
 b=StjuIVBplHKvIi/s/h1OAaj6Wn6XIBhfxzPYkssQd5+BUTW3cntpUi1/DTiEa6Fv2j
 fhO6RJpQsUROFkrulFacf4RySrIvGYk74XTSaaW/xsJFISzQ6ga3LFbyhlBBS73sYosB
 1mv1rUNobo0B0RNRvGe9Id7YBzagOfQrb409YlcYJomrRMVdzXlC4yQObPj4gLWImTX7
 JPXNsmiRw6KjDGH+d1o2GQBTuhP5y9zuQibgK2TkL3cZaoZJt2qoGrEbE+9dpDMgwax9
 6vG9mKUQ/EvboFkT4pQU2Bd3QdShvpoIhw/NQ5nYURRjLY/rimmj34WCh5YFqHxNLiuk
 xJWw==
X-Gm-Message-State: AOJu0Yx/SDG9aoZY7IUQ1tb/Jq7IoUAChAX7bdcK6L1B4zxCExTa7Ahk
 UXqvokh0BaLqU1xgytZH38yCi5CaYsLinzlLE1a5pQ==
X-Google-Smtp-Source: AGHT+IGcs0iKka2b3S8ypp3kdrXZPNSqx63xSDLoSDEPANxSY1JUOtRL/syjsJEnFPNDATeHziphbtbbC2e1kWFG9zI=
X-Received: by 2002:a17:907:86a0:b0:9be:2991:81f9 with SMTP id
 qa32-20020a17090786a000b009be299181f9mr2760589ejc.1.1697600004065; Tue, 17
 Oct 2023 20:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231006100737.343745-1-n-francis@ti.com>
 <20231006100737.343745-2-n-francis@ti.com>
 <CAPnjgZ2RAwdZxZMccwcLL5QLs-HyBcx6B=LLKfVSjSb0qpjGxg@mail.gmail.com>
 <c052dc27-e919-4f62-a104-4412954e7032@ti.com>
In-Reply-To: <c052dc27-e919-4f62-a104-4412954e7032@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:33:12 -0600
Message-ID: <CAPnjgZ2RvujUiVrhpb-v7Z94JTyP=1e6ptc=mC7A6rVF9NZxdQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, u-boot@lists.denx.de, 
 vigneshr@ti.com, u-kumar1@ti.com, a-nandan@ti.com
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

Hi Neha,

On Tue, 17 Oct 2023 at 03:58, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Hi Simon
>
> On 08/10/23 04:39, Simon Glass wrote:
> > Hi Neha,
> >
> > On Fri, 6 Oct 2023 at 04:07, Neha Malcom Francis <n-francis@ti.com> wrote:
> >>
> >> According to the TRMs of K3 platform of devices, the ROM boot image
> >> format specifies a "Core Options Field" that provides the capability to
> >> set the boot core in lockstep when set to 0 or to split mode when set
> >> to 2. Add support for providing the same from the binman DTS. Also
> >> modify existing test case for ensuring future coverage.
> >>
> >> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> >> ---
> >> Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
> >> Section 4.5.4.1 Boot Info
> >>
> >> Changes in v3:
> >>          - updated function comments
> >>          - removed inconsistency in setting bootcore_opts to 32
> >>
> >> Changes in v2:
> >>          - included TRM link in commit message
> >>
> >>   tools/binman/btool/openssl.py           |  6 ++++--
> >>   tools/binman/entries.rst                |  1 +
> >>   tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
> >>   tools/binman/etype/x509_cert.py         |  3 ++-
> >>   tools/binman/test/297_ti_secure_rom.dts |  1 +
> >>   5 files changed, 17 insertions(+), 5 deletions(-)
> >>
>
> [...]
>
> >> diff --git a/tools/binman/test/297_ti_secure_rom.dts b/tools/binman/test/297_ti_secure_rom.dts
> >> index d1313769f4..1a3eca9425 100644
> >> --- a/tools/binman/test/297_ti_secure_rom.dts
> >> +++ b/tools/binman/test/297_ti_secure_rom.dts
> >> @@ -9,6 +9,7 @@
> >>          binman {
> >>                  ti-secure-rom {
> >>                          content = <&unsecure_binary>;
> >> +                       core-opts = <2>;
> >
> > here ^
> >
> > Do you think there could be a binding file in dt-bindings/ for this value?
> >
>
> Sorry for getting back to this patch so late, but wanted to ask about this. I
> had seen a last version of getting the binman compatible in dt-bindings but I
> don't see it merged. Not sure where I would add this property in.

Yes it is difficult to do anything genuinely new.

I am anticipating something like compatible = "ti,secure-rom"

so I suppose you could create a header file with suitable values for
this property.

On the other hand, you could wait until there is progress with the bindings.


>
> >>                  };
> >>                  unsecure_binary: blob-ext {
> >>                          filename = "ti_unsecure.bin";
> >> --
> >> 2.34.1
> >>
Regards,
Simon
