Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B707C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47D068142F;
	Tue, 28 Jul 2026 13:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K9EsNcJDg-kK; Tue, 28 Jul 2026 13:00:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61A8881403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243631;
	bh=S0PLjGAtNvlSUGDmLScXosDQ4GUONx0iuZmDjcUZgqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1ASAufY+G1a1uJ1eoPU+CSOzL4H6j9hgB7k0aHUM4fhrE1tSQETXOBHfZrUKCE7Qe
	 Mut0qYdEGUx8/0nQB0a3fo26nevJ9dJxdJfAiaMgcwV4BgX1bCOVtF4cXE4JYyoNB2
	 5EkS49sOsdl+ws0+PCqVjvtdlRezQVxDQFtuaVuWRmZj+0tqsUpvimNOdK9y2nqe/0
	 iOdN2pRzwxSlWa28e0P77VT6f35A8sTDhdNzDXvggUj/Gv0oglcv055N3An9JyrRPe
	 xSOChF0gx5e1Eqo2QE51nm5ugWlk31cX7ZI8pEL3npXpQqZeMTyH7Aco23/RtSkKkB
	 3oS5DfQodRohA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61A8881403;
	Tue, 28 Jul 2026 13:00:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8B342E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA29B402D8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eaLW-5L2GRlv for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:25:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4F321400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F321400D3
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F321400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:19 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so6267266a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237917; cv=none;
 d=google.com; s=arc-20260327;
 b=jThECiPs3q092f3+dVaooyB5u0KlbmgIyTdzBN+0p+NHe0dkqAi1cMPrQRiYqKu+c4
 5x2MusWtWU+IQ7MGckUx8UbsAT6t13g6tdt9lo9r+XCPhfnBENZbwsEKpERXJGhm3FMH
 OndmF063P2/vGwwbKV8gVOlnT0jZ8kxXE9pwB7Fbdc4OEx9ZnIkB5p46YCBuglVZE4fZ
 6KtpkQmKslb0QXebffiELUWysWcM8qaME9/yt7HHE+GtMqZies+R+6ZGQuSQ28GuiUpt
 Uzs6a2fPGW9UcTV/aidasYoJApXPC6LLcLnoeCHbOu3srqs3TvnaoVGvGMMU65iKNeIF
 dR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S0PLjGAtNvlSUGDmLScXosDQ4GUONx0iuZmDjcUZgqY=;
 fh=F3A8iYmsBhsOqUPqopAmbO13VrP7+eS+MzeVyCmJKNA=;
 b=Q411BGVAjnVO6q71jyTIDyMXy/weqUowxdFYVpDfleOpkShtmPr3t4vzKODNiR4Rur
 OitG/KBEv+SHxsxmUzD23VXY8v1dWyo9fClGHwvgyEIVG9PeRegrLzr7IVQnDO8BWQSF
 Gm2J2D3w/wNtqw8D1IctyFsFT3FI59+szgraXfchMYNgKM8YrdMTZyHw6WT8LL2DeKJ6
 NSBdjccfpNqBJw6rC27nNvbZsRvpb7x+bxc9ciXpc69RAIAHkkBmqRB1KkWXJY0wkNXe
 +RDwFLKX3envgDYNo8V4A3OjUyjiR0UO7WkePpMeghs89lItR/9slQi9/ua7ITuxCvet
 nazA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237917; x=1785842717;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S0PLjGAtNvlSUGDmLScXosDQ4GUONx0iuZmDjcUZgqY=;
 b=KbCnoyXuk5Fq3ev4BEvrvOBceSKZS5vEkna7POrEaQ4eoj8lYVm1y+MQLdkcN0UGVC
 eDChYw8Njx3aT28GUwLwdC4FowoT+6VZhSlKK3R81pOuF2HQOgxXFX+rYYRGAwKTeIzE
 E/t+fVUSbQwMRQl2gMbR99QmnNisDl3skJZS3JLnVxVeyO360HdIMaVsf6iIkrr8ZFW5
 9vnSxflNDN+KOMD8IJ0AfyZMypxLpXvQKIdpTu/oxBii1ngkRmKeltZa/k9+7buLMl5k
 vR65K+4tsG32IRT7qof2lw8NvFWTGjW9mVvl9D7iD7gTn0TMNChCKZPcs7wzjMoH+kX5
 VSJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrn05XTTYvKsf84Ihbz/0f+4XQwzcD2YMFiSTMmpTCckKf0Asf08P6JsDiWs3xku673+bJzIn8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzoyD27lHneZhUVn4CI14exnVEWbW624c1QVGTl5ot5W1gkCtxJ
 3epOMHNBdhhCzijoMFie7BjUAExDIAgA+YOqWOZ8hJRwz5jgoDujaW95iwDW4sR2crZyv+gtCSD
 yv9vR+kfLz07H20AvKqOJWNwCF4RDTJrLQVBhFoDG
X-Gm-Gg: AR+sD11rtweph/ipyMpn0xWlCd/e9O1SJHGcJipqA9RjpJJcxQkX3pWZa3eNPAFde8d
 Ks2YenU8k+uBs0W0K2WelXkUcJoMbyH38jHFgFItYKsRrkALkJGhmlXmLb08VptqQIPOhGrUTJV
 7excjb7x7k4zXvRiM68NOPLCoJN8soztxyr9c17oVbkAJE8wX8o6Elr319E6YvxRp6pUP0b1FZt
 5bqBOQ+KLfEoGAakONn3A4HDsYR1lLDu5WIurwg64Jrf1BH7PJIXwbC6ZSs
X-Received: by 2002:a05:6402:2b8d:b0:695:822c:1083 with SMTP id
 4fb4d7f45d1cf-6a034a9b550mr1041371a12.28.1785237916887; Tue, 28 Jul 2026
 04:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-8-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-8-3c41f66d4522@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:25:03 -0600
X-Gm-Features: AUfX_mwJ02w6tYz32lzylO3LC0-bhwfBoLNsnLa_zFGoL3v2RckBydqygmgQOGI
Message-ID: <CAFLszThzQE4F8Zmeb9E-dS8CPUMsSuvkPutCEezRCfJ6ax+ASQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] boot: image: add FIT decrypt-to-buffer helper
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237917; x=1785842717;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S0PLjGAtNvlSUGDmLScXosDQ4GUONx0iuZmDjcUZgqY=;
 b=lBNogRPBxOCab4URA9X++CD7+vLkfwD4UM4bMMVUdvkQSz3bRLrFm/0SoVyKN2d9tZ
 i86CBofOs13Y/3iulEEvG1LZHD/5H/q+8e8H5s//SzAvsiDTWynbUQ6IPZfgUnHbvAMz
 pEjc4asKxa+en2ddNqOCSQiN02R/8FHiQm11E=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=lBNogRPB
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi James,

On 2026-07-20T04:13:44, James Hilliard <james.hilliard1@gmail.com> wrote:
> boot: image: add FIT decrypt-to-buffer helper
>
> FIT cipher support currently allocates the output buffer inside the AES
> helper. SPL often needs to decrypt directly into a caller-selected
> buffer, for example a load buffer or a scratch buffer used before
> decompression.
>
> Add a decrypt_to callback to the FIT cipher algorithm and wire it up for
> AES. The existing allocating decrypt path becomes a wrapper around the
> new helper.
>
> Validate the FIT cipher key length, IV length and unciphered-size
> property while preparing decryption, and build lib/aes/ by phase when
> FIT_CIPHER is enabled so the target-side decrypt helper is available to
> SPL builds. Use the DM AES provider helper when enabled, retaining the
> software implementation only when no provider supports the operation.
>
> For U-Boot proper, use decrypt_to for in-place decryption when the FIT
> payload is already in writable RAM. The encrypted data is no longer
> needed after hash verification, and this avoids a full-size allocation

Decrypting in place overwrites the encrypted payload, so a second bootm on
the same FIT re-hashes decrypted bytes (fails with verification on) or
decrypts twice and boots garbage silently (with verification off). How about
addding a note, and ideally make the second attempt fail cleanly in
the unverified case? What do you think?

> [...]
>
> boot/image-cipher.c         | 45 ++++++++++++++++++----
>  boot/image-fit.c            | 33 ++++++++++++++--
>  include/image.h             | 39 +++++++++++++++++--
>  include/u-boot/aes.h        | 27 ++++++++++----
>  lib/Makefile                |  2 +-
>  lib/aes/aes-decrypt.c       | 91 +++++++++++++++++++++++++++++++++++++--------
>  test/lib/Makefile           |  3 ++
>  test/lib/test_aes_decrypt.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 290 insertions(+), 39 deletions(-)

> diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
> @@ -4,37 +4,98 @@
> +#ifdef USE_HOSTCC
> +     return 0;
> +#else

This host stub still claims success while leaving *data and *size
untouched, so a host caller of fit_image_decrypt_data() uses an
uninitialised pointer. Since image_aes_decrypt_to() already returns
-ENOSYS on host, please make this one match so a host tool fails
cleanly rather than silently.

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
