Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E7CCD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 00:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6EAA848BF;
	Fri,  5 Jun 2026 02:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D99v2zbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6889B84995; Fri,  5 Jun 2026 02:10:32 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD2A84874
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 02:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5aa68cd8dd3so1285208e87.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 17:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780618229; cv=none;
 d=google.com; s=arc-20240605;
 b=h6m2KBpXstCnxqd5Cy5bCovViEKdz3uE37ut1z3dH9COabPKt0nd90U1OV5vf1vBGW
 WeKyjYblCBLCufBtGXBx6bQXGyIPDrwHZdrphhWT+a7z1iViqOWai4+2Pm+4TwgHkPgK
 GoOUP6qph7+/TB6YFSUy3Xvoh2J2jCvaDgeRrmh1lj7FBMhxToEtUed3bVzFRBnwQu8m
 toyh14brSIVJUEXHLFUqKJwjHLq+VsdzTbUBZnxrNAQ5bikaSwPVv3M1c0V/noLC4Tg4
 uHAogIqGKk0K427qoXdCvUn/TVLD59yOsKYWJQ88sfR7oTuHSulXXgpE6HTZaksI7raa
 Gujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tcip8iD9OFL3eXUX5N7KqX6vNvVu2+K+aTRMNAUym2o=;
 fh=lHsdnKcj47XH0bTdooxOnDF7zV05SIrpSAYhJ6IZ0Nc=;
 b=faqOBL02SsXXi4SaxTIyqMZ+L4z1huuL77xH2PhcswKQ09rKm/caqsP8bpGWZiUttZ
 IbBH283neiiV327wtJuMJh5cJ49X217VEEtMDNpavoGdfjL3Xuo2hUfEHcGlIdbL+k8C
 DCwNOZzBbs2aXbwBCdESh2LgQKR06yH7fcEtHl7wqyetKWFNqCVEshrLbC9+GBeXvfED
 Q07PrPlgdjcCaUw9uJlfgRAP/g1hJQnVVHSwOqL9E4Ro9tozidXn828ax40g5KAzZNhe
 bzHPDDCs/LswBXooyPJz9oiA5/30zjK42PI/8fRz4NM2xbWdJEfEnTZw+nNGG//d3pft
 wIhA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780618229; x=1781223029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tcip8iD9OFL3eXUX5N7KqX6vNvVu2+K+aTRMNAUym2o=;
 b=D99v2zbbc0vOwglbAvZhoBfM1MWX8oe695iUg2AmUpC/lxmPSyLokODELzo6Oxp0sh
 /qVWrebCM7ui/GiaSNxmOIKXW7FDl3Cs3QVw810Hu33kTl8UmIoVIf+ViRJ7tC0NGexn
 KaezJBQjf8h1yflnS0SJNlZKZi/6DtSb8GtQMVpbxWlGHOroLsMEnL4PZSFcDyfuI3QN
 ZA3Wf/IONz1oc0myWFmICYf3dGtDP5BkErhkmo1fFwNcYDahYgV5VnWx5peBPMRhLAQC
 4d2PM6aB/QE9bPPTgu6Cfoeo+cJw+AhKtVWBPnW3wf5GMm8RGanpdDka8hEkyoOsx8tA
 ryDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780618229; x=1781223029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tcip8iD9OFL3eXUX5N7KqX6vNvVu2+K+aTRMNAUym2o=;
 b=k5ihBRA6JD6fjYw3aTEnqZSm7dJ2O359E2FK0U2aQvlp2PCui+e/OM+jukfJ4Uywwx
 jy8bQ5reyMo6lt7EJgTg3CJZD3GEHZDNw4ay7oJMTuZ6sfZPDKIeLDfCeNZew0WUFuSP
 vqqtk0Tsw+5OMalaYJsmkGc5ioIxZzzD4s+lCtbUmeqMYVhGDH/BpLijDJiOo9wo7sid
 ec7dVvtAqtYD+EZNkG1sL1mbja9z+gxo6a9kVh/D5cW+3eKhiCRLxaufBKusDAxR6bjW
 f4qebDbsQpqBsQ5QNNDO7wowotiCXrWNzRhnB5s7bEdcvndcx3spb5sgG4B9wIw4rMJT
 teOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uCsoxdi+bWWnY1jNo9xGtnR3RyRCJ0M3uQSd/dLOBNysGfymzIa8S4zVMIPAuAIX9hjNSCHU=@lists.denx.de
X-Gm-Message-State: AOJu0YzDo/GcguUW8KPNEeaZDn9IiOynBaVKp8c3j7UGT5gHi1TPbeQD
 d+0gAxcpj9DZRkxkAYJgmoFaGb8UgCSzoFz4rNisUAW2qedn2toHXRSok1e8+IA2ob/cd/RJobL
 rgDYhOAZQ9YWOJhg91Yp+WPrYWbymWfmUNQ==
X-Gm-Gg: Acq92OHob3jeedYzeV37k6DrSeC5GPd9M7CcTStZaH40jV/tcfWGuj+k79RibEww4B5
 WZ5zbu95b2UOYMKu6lf8+wmNgy1gN7se0OrINONYk8xH/nNtIjoK9Cyz99VKFY3+yRJ72fDX7HR
 U/wkFPXsv7VfPQCsbdf9PfNN5kToe8JUGck+BZZL3vpT2UflU/tXlvaYx07SAcvA/0rN4Eeh1kX
 ppVUPR8O2/UpIvMPqFUoxyMWIOhIvTXUA6BbgqFnVW616uVmWO2LsTP2ZtMwGJ9YM4qPGtpflwd
 sJrMG9f2Bp1fay5D1dbvMzhZCy5GqH6pMHugrjEuBFXwzQ60rOiBqtSva3EBGq5Vbt2fLandCYV
 /IYa67w==
X-Received: by 2002:a05:6512:1285:b0:5aa:5e22:5add with SMTP id
 2adb3069b0e04-5aa879ed345mr343115e87.0.1780618229323; Thu, 04 Jun 2026
 17:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260520135138.1047110-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20260520135138.1047110-1-ghidoliemanuele@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jun 2026 21:10:18 -0300
X-Gm-Features: AVHnY4KD2kIC8ztpOULSvvbia5bco9PbrAiXODZqe_WjSqBVJ-pwaG9LbKTyyrY
Message-ID: <CAOMZO5A=j9i35Ztvydvy8Bo25tgNhzQy9tU8q0Yd3UWbf+TPNg@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: verdin-imx95: fix ram size check
 calculated addresses
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

On Wed, May 20, 2026 at 11:08=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> The ram_alias_checks addresses are 32 bit values. When summed as 64 bit
> values the calculation is done correctly, otherwise, if they are summed
> as 32 bit values, the sum wraps around.
>
> Fix by adding uintptr_t recast to the base address.
>
> Fixes: 60d8255d8dc0 ("board: toradex: add Toradex Verdin iMX95")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Applied to u-boot-imx/master, thanks.
