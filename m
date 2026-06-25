Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E23CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 16:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E39884704;
	Thu, 25 Jun 2026 18:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IwLoxb+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DDA184894; Thu, 25 Jun 2026 18:29:30 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128BA805D7
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so1040999a12.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782404967; cv=none;
 d=google.com; s=arc-20260327;
 b=QFZqIHrGnee8IGuEp9+E313qe7D+St04HrayTwCPpvGfG6KgQDlw+rxLOGFcy/EAdD
 NkF9bl6ccXczXPAWwIGeTCzsFKMZU52sSKt9yhaAH1gFUGA5mMbNbzNqxgjBbsZCo926
 NrIcFqBNxo5mxD5WnC6VWNUNtYe/6MA8NNmeSSlb1bGTxoXB0MEkb9wzexzplB1EcZw5
 kxJdezRCG1QjDcd95nl6Km8CWKDr0d1VpSMCtYmDOc45tApO5GvBOLV/iq2NRUT9vo25
 c91HpBiS/D8Ddft52UXy6MhfSMxhm7LTGlV5RlCABot8GfeyRGohE0Sf/el7kdmGxit6
 gxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ql/lvVB+DJGH6piZ94Mou1KcrA2bYx3XVMfVf8fM5ME=;
 fh=aR7hUKKh2HNrGYKdSC4xLsytBE5cNispTjSDyWyCqOE=;
 b=ADE+gUpiFS7L0ospuyUy++uh8W0Djasvz08B8PYG0J7VSx9JHHtjeIuSwnAjXEVK/B
 CPN+LNqzTTXcxz/m8vzGGiBWZH0LznFR6CmmZpEZ3ZlmtLQ3LP23N25eulVQqQ+5RswD
 zOgt12eS5WIuAaMLc9QnqnI/Ek7XkPxfWE+1rEpqGYeo1W7AtiDlitimiK6vrAVdXVN9
 939yAL4j255BxairrGtvPihThASYBvHJEpRJD7suwSArXNoxVBZ5y/BKz+IJ3oTT8+yw
 RtZ6jm+Qqe06vLFIlkC6D+Ye6nDhfDXwd8K6b3qfhmqNZa52zy2Z7Ayi6FsyAx6c7Hhq
 dLXA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782404967; x=1783009767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ql/lvVB+DJGH6piZ94Mou1KcrA2bYx3XVMfVf8fM5ME=;
 b=IwLoxb+UWSjxsUyyZBLqSx9JLivtmkauY8dWHnFKrd63E5exZKHstPZno0fYxssR2R
 Z+d9S0Sip49TqNZ8E6ffZ5DuV3jyZFVei03do8j+80INXFnAhmLtI4VBaTC7qoHtW/fu
 XntFuxoPLUmVzqbqfAzdLQFiChKJYlhMeorKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782404967; x=1783009767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ql/lvVB+DJGH6piZ94Mou1KcrA2bYx3XVMfVf8fM5ME=;
 b=oEBtEiatnG1fUP5WVz3ftxjiyDJp3V797ebj+hqsRwBJOdq6skxI4Sfci9ulO0PAhr
 2LjA6Ne5umgqSN+l8EHfEyN6mIy0e6ud/P7BWoKiyhDoFo00rTbr6JKvWA1Ego3xOLFK
 Glfav70t1r0x349BKTgPA31DJg6d5c59ovgSqk1+0PPC76PKxfUORQ1yPp4+et3i+a/+
 tCdPtQnZLIXGMPVeJR2esigEi0KLOnEqyNS8dUSOJ0j6mXyR9x6mAd0SkAMlykREOREL
 GtsMf44Pk98nGjSyFdea9gWrYEcMYunMi54URuIV4MxUQcIVfiAuzn6dUApVdYhXX+97
 aMUg==
X-Gm-Message-State: AOJu0YzmfOkPFTioLDMjkvWLwZ4nI6hVFm98mbwk/X6vyeYdV4suT3Ih
 psdJkNTfhqLu7ttGgGhclmQHVkU3SgWnOzsmg4cUm5tgZo+W6j9j1yoNgazhq0ymEZQ6Ya17rqK
 /YF9QB119ta9/LmEvrAtT9GyHgWuJ3ap8jt0m8xNB
X-Gm-Gg: AfdE7ckIW7sScjsj6kjLNKPYvArUopHCYvCGKlB0416cB8bBifPy224jU6hToviDSkd
 AgWOQFyjM6N06yBaIVm6CMX29huuGKxqfH1z8tsmdOpPlnGherjrpbm0Zf26ErVcuVxwzo1n8Yn
 hUzYlYQeJHR+Kz4zD+Zl5ccVIjTqTSol8HT/VSbNLFiZOo/8BgPEN9d20Bp7K7w3g1S2s5zp/jE
 825sysrLuVmF5U1D1juwT/FbZ5iDFDdOb/4scvLTfLIDPHCjGvWsBf+svAef1aTj+hBX/iBdg==
X-Received: by 2002:a17:907:a2c7:b0:c0f:d987:444f with SMTP id
 a640c23a62f3a-c1205eef014mr251663766b.28.1782404967508; Thu, 25 Jun 2026
 09:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-ml-switch-ml-links-to-patch-msg-id-v2-1-1f15d8655c8c@linaro.org>
In-Reply-To: <20260625-ml-switch-ml-links-to-patch-msg-id-v2-1-1f15d8655c8c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 17:29:14 +0100
X-Gm-Features: AVVi8Ccwqr9RSXUoOVfk6HwW7sHEMhNAsmnKpVfGwoJV5beZ6ccQl9yWQGt3NGQ
Message-ID: <CAFLszTg1JGDPe9Ms-fV6O1ws17ktDxmfEGfc0Wgj5TqzVfbDWg@mail.gmail.com>
Subject: Re: [PATCH v2] treewide: change email links from mailman to
 patch.msgid.link with message-id
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Gaynor <simon.gaynor@ezurio.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Xuhui Lin <xuhui.lin@rock-chips.com>
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

On 2026-06-25T15:36:15, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> treewide: change email links from mailman to patch.msgid.link with message-id
>
> In preparation of the migration of the mailman mailing-list currently
> hosted on the denx.de infrastructure, migrate the links in the code,
> comments and documentation to https://patch.msgid.link to be future proof
> and always link to the expected content data and uses the message-id in
> the URL which will help find the appropriate e-mail in the future.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> arch/powerpc/config.mk                   | 2 +-
>  board/boundary/nitrogen6x/README         | 2 +-
>  doc/chromium/chainload.rst               | 4 ++--
>  doc/develop/historical/generic_board.rst | 6 +++---
>  lib/efi_selftest/efi_selftest.c          | 2 +-
>  tools/rkcommon.c                         | 4 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
