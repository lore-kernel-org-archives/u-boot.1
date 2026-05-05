Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B703ECD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F373F8497B;
	Tue,  5 May 2026 17:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GM29mOZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D138684972; Tue,  5 May 2026 17:15:59 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B745F84994
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 17:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso969996966b.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 08:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777994152; cv=none;
 d=google.com; s=arc-20240605;
 b=lr7LF0UNThfKM2vuIINJd4R0YPpO/7phDtOJ1AfCZBYD9FvnLMzY+2aXuNXRNY6JEX
 kcHDg0A7REho6qmBGIEG6YWu9Vpwt41dBPj6bYg+lDsUjcJteZGlptdFbYCqJa82FPhd
 RK20/pcgN32WTPg3Ky37zTUNzkhUwkjz7d5n+ivSv78WlMNvycJR6YBBrPYfam43g6vT
 xCiec7LUGM7XfL8WDr7kjqhqIOs/NzFQNDR9hhTvYkDEOOItsNDkn6BuHXNv0Yc9bnsr
 4tvAL693S3jFbE9bcQNEX/G7IKdydjTJtk6b/yQsqZ4nmLMO+gLxT8naGFefgPvwlTCO
 iHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BPDtcpnAxEh8FuPvh8M+iGe6Ce2JugRs+/D7Y+xamLs=;
 fh=NOOJLyTmARVTOzWlYRj0oaWCUL6/rnOFhhpJn4l+kts=;
 b=DOFK5CCW0CVqVi2rMPu+4ah7btCKB1bqiBOTt5E+K/dheZdLDfwrQNC8m75cdp6E4Q
 cQ2dYPQmYxf77Jf2qGApffZCy7Kt/65GvodGsoKsEn2pfrCj2xgooAjczp3W6dLNMlow
 mEjLm2oRNkq4yOQ5wN4Bl4UM0XyRz9LzjlrX9QW85VpXwmwmTDDS6s/v3B/f6kVWiAHV
 Ogu+Tpxc5itM+Wzdn1dg4pEeolyQj5Lk3eOL8Oib9/gsKNSU77f2YSJ47wFrrhcnoVei
 78ds8NGJMYel4XFuMW5CvNCfZ4nospV/gBobEPc16eKyZh2VudADeQFtWlj5JkNZ4oJt
 gIEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777994152; x=1778598952; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BPDtcpnAxEh8FuPvh8M+iGe6Ce2JugRs+/D7Y+xamLs=;
 b=GM29mOZhX7ZGMFfzXszOb+N81XkCQznfvU5n8jUU4gcGvV3lDYbLdLVFxs9tGOCwc2
 zU5k+03pHg/YZlwAWE8LC60Q5gIDpWPIMP3xO9NWOapE9lSz9Pg8MFCIhfWIt87qdlNp
 CSkC6zJlrrs9CM9YepbFE/uZIQ1Oq7e6mZCZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777994152; x=1778598952;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPDtcpnAxEh8FuPvh8M+iGe6Ce2JugRs+/D7Y+xamLs=;
 b=U1uHc5KjbKqgOeNrefpaOertsM3nED16eD/dnIwQTF5H2vwJJk0mwC431xdWir09yp
 NBbRua2nCtOXyFzVYr5T6nkdu2Z43jj7PDau0VRLO7q5LkAinEhKGNoRgp1Kf+BTLFHi
 NWn8+CzPnT+AV8fRuTwNePlzILb+omP3RHVkrjjOrMvT8h3SH2PadHhY3fW1wzYW4Xwn
 CEUgoe2EObIJcEpOhDVJbXzpaSGilglz87mr4MPsvoWbA9UUNa5YQXZbS9oCovuxhy7k
 f/A/P4TPVBWqrt25vhGg3hQ6SpOVu7QtCSt7Zh7W6Xn3FVa+1EFqb5vvtbDpY7fWIyKA
 ggUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9O1FuTe9qioxaG/bNEhE8YNpmiLxZL4HkdeF/o/1pKQJao79YoEQoz0DlI6/8jxAE2uJlQcdw=@lists.denx.de
X-Gm-Message-State: AOJu0YzG3esgouRf8UUftFNqk63QEC8Vwxr3lVODY/+/yBkBw5+Qkge+
 +HyLkfjJ2A9bC6gt6y/eJR17iM5odMrKxuJxEUqw0194FsQfLqdlVf6rN+4peMCkN1Kh5dPH3qa
 UbECwL1yDk9Bg53bnrsuKSgGffJMEDNCSiCtNKR+n
X-Gm-Gg: AeBDiesrkK5ClOcp8fCokOzMDCtZztkgn00GqxOzCzkEcajWpRiirzEqHfou0vbRwnB
 UzaT4aoS2ij1KENb39AK5r/yJ8E9asZnRWBVTtPf3j3vKtPFq+EmjdW5hNCFeBf/P5JPZlkY9xk
 4R3emzkMeLcGGiQq0wuFb9nxllVrwhj/V092aQA1a08hWEa10Y9dcI1N6R+kqo/EfOhkAcXURzg
 AFi0PUTl0D9XJ2Rbj1sJTcSCzX+27TXg9hEOz5mAn0RDqcbZ43AWW/pUqZiYlCxCxm1t3HatXrB
 Zot0r6CulhXZLP90/hJ7GbjUAaE=
X-Received: by 2002:a17:907:a48:b0:baf:3fa:5b4d with SMTP id
 a640c23a62f3a-bbffab33934mr776301966b.9.1777994151875; Tue, 05 May 2026
 08:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-15-b19301d1948a@cherry.de>
 <CAFLszTiX7VJzT_mYS071Vb5jOBR4pqtpuM9LoqR=6m+qMNLsyw@mail.gmail.com>
 <2202b6b4-41d4-4bcc-be89-b50f4c18662d@cherry.de>
In-Reply-To: <2202b6b4-41d4-4bcc-be89-b50f4c18662d@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 May 2026 09:15:40 -0600
X-Gm-Features: AVHnY4KavGm8OG5SIsrAMv2dg71bX7MBxE-lFBt3lygC5CLv7wFh1nQYIqQkzi4
Message-ID: <CAFLszTjWcADrm_2yhaN5dq5HQ7AxAsqVTa0ukFMx5nooD_JCyg@mail.gmail.com>
Subject: Re: [PATCH RFC next 15/18] kbuild: enable -Werror for hostprogs
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: foss+uboot@0leil.net, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, Rasmus Villemoes <ravi@prevas.dk>
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

On Tue, 5 May 2026 at 04:52, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/4/26 10:38 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >> kbuild: enable -Werror for hostprogs
> >>
> >> [ Upstream commit 27758d8c2583d10472b745a43ff86fef96c11ef7 ]
> >>
> >> Original commit log:
> >>
> >>    The hostprog compilers and linkers do not share the regular compiler flags,
> >>    so they are not affected by CONFIG_WERROR or W=e. As hostprogs are used
> >>    during the bootstrap of the build, they can't depend on kconfig options.
> >>
> >>    Enable -Werror unconditionally.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> scripts/Makefile.extrawarn | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >
> >> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> >> @@ -109,3 +109,8 @@ KBUILD_LDFLAGS            += --fatal-warnings
> >>   KBUILD_RUSTFLAGS     += -Dwarnings
> >>
> >>   endif
> >> +
> >> +# Hostprog flags are used during build bootstrapping and can not rely on CONFIG_ symbols.
> >> +KBUILD_HOSTCFLAGS    += -Werror
> >> +KBUILD_HOSTLDFLAGS   += -Wl,--fatal-warnings
> >> +KBUILD_HOSTRUSTFLAGS += -Dwarnings
> >
> > Just to check, is there a reason to keep this and patch 16 separate?
>
> Backports from Linux kernel where they already are separate.
>
> > The next patch immediately undoes the 'unconditionally' claim made
> > here. Anyone bisecting through this point gets host tools failing on
> > any new compiler warning, with no way to opt out short of
> > HOSTCFLAGS=-Wno-error - squashing would also let you drop the comment
> > that patch 16 then has to rewrite.
> >
>
> Fair enough.
>
> > If you'd rather keep them split to preserve upstream history, you
> > could mention in the commit message that the next patch makes it
> > conditional.
> >
>
> I would prefer to, it should make it easier to then see which patches
> were backported or not (git log --oneline). But I understand this
> unnecessarily breaks bisectability, so no strong opinion.

Same here, up to you.

Regards,
Simon
