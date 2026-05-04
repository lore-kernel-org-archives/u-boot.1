Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04E2FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 716F78483F;
	Mon,  4 May 2026 22:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Di86ugfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9AF88484A; Mon,  4 May 2026 22:38:48 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1A38483F
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67b6a6bd7b8so1618677a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777927126; cv=none;
 d=google.com; s=arc-20240605;
 b=HEGEMtbXsnOeYFzPYV1dhmIZFk+aLBX3lpbpLNAjW4OwP71/yu9uCCBZ11lH2ONBrG
 yw+T2zVXHi4HcVCVTJDLKW/XtBmkDhH3fYQYC6EMHRYc6YnIDwcCTgjAnqTEa2pukivv
 VpVwcAJtqFzV64PpBEA4SzK4nmaTQbn8VPykxIbNaWwIGWRAyVks99ACgGmCxH5ybSHC
 kxmc5CDTrVE6NqrpXGhJsUarnS2oFfBX/on1tp3hv0SGcketdN1C4JqTgkoovstAfSUY
 2ph5Z90Y/xJNMa7ZihXmTAqTXr1movGKmn0T5AlAsk/Jt82f6lswiHCHeTBw6FILlCvv
 Hx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6+OF5OSGCvkRLAzDwoRCTIjhBxwbFl+rh6m4qG2kUhM=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=P1qo3xym/IXGSOnrM8Z7FuQGSA6LlCojsLaEEXQB5qfDCmSs69lpjHVPRn+LTu1kCX
 J5+wpMar5naDMrA2UGZg9miaOAhuDRe031MVeKRLH542FR7MeuRSsrPU0G82p94R0NTU
 VF2fXRUtklKgH7h1yr7BJ+qmkADMTjxez2RBtqOL+vkZp3EdoQFWSVtPAgQyBt0d0Lwu
 Cayjwf5e7youu+7cgOaSynCg+kuYOQMQG9csgZUoQZShkvvVl7hQMgLoA8pOSmky/kNl
 W/DrXONHCAzLrjvWNPmwojUtjSB9FBSPJatiMsj895EfjFszGpgEjW1/6gyjT2DsAOar
 BVvg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777927126; x=1778531926; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6+OF5OSGCvkRLAzDwoRCTIjhBxwbFl+rh6m4qG2kUhM=;
 b=Di86ugfFVO6ULYG8NSqcQfAI/ZJzOasB9nFE9M3pLny2QALEVXIa8Jbb9Vu468AePR
 PgUIxpa9v3FPywC4GReISQug8TpE2n2J/E7oER/Mi3Aol7HlbcjBYNrq/Ec0+ccnrqzE
 tArtOWvLyC4cQouzYP8E6JecroFrLFiHJ9uxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777927126; x=1778531926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+OF5OSGCvkRLAzDwoRCTIjhBxwbFl+rh6m4qG2kUhM=;
 b=SdB7pkRHcLRAgb6M7oTbPv8PHpGXHXDjacx7KRHcyCAgo5/QvlAnta9kYBvph2uTPi
 qnpNjJJ+2LFg+u97vdJyuIlhelOSWX/gVFf5cni9IahWGCs/yeTy7m6uvjcxqY4Bjkbx
 MsZV8/QuXPHnK2AD8NmjFggXrE3vb2kx1dtN3l3XVC/NVICz0b5SsQ50ovtUa3hkFoBL
 6fCoSxzD6BH0UnAkKUo1XqeodCyPjzOr/N/0neyo6cWRbS/bqZSMqMDw3nWw+ePdDUms
 pksW0NgYEAbJRU4oaKDTUWoTYrxIOct41oTSL8lMClxMm6QdjZ3AIX+HK0kvkZsRjadV
 IHYg==
X-Gm-Message-State: AOJu0Yw9xj0zV2JII2SztZFPMiPPe9sLXkrXuOXpMIyt0FiAuobUoaPH
 HoKxKT7m36plNpqCbA5jjS/EDOw5CbHqsLE08MvfEivhTmXlm+VognX6HhsQtPPmeJgI7ZTI08p
 0sfbA50OfmlSSuJ80yTxUUDwQI+rbrvmBv/wL2QKO
X-Gm-Gg: AeBDievPjLu88dnSN1b7ZlR6v3dRJpak7wv3Egj20TyujHZkdT5TAaRf9mcHCbR6QLq
 29fp/wlE5zvJXzphngVl+bWwQ8t3huUCTMokW1OvUPXWVcE/SikQJanPvJPOULahHqgLua3BB3e
 lXEjDfqiPvb6fWJ/TVhHhIGaA+NU+vmeunDK1Dh+3EZUylPMjkaWRRxTsXE8LbseqTGhus5M5HN
 EtwXwyrHKjqjQBAthOYUNz+gbfVSLkOlk2inm+53mj9VteeUJ4ds5JtW5ODn/SLP++5A6nF/OlW
 OBtYoJCSAp+bNp4sVAG2s+RXnBY=
X-Received: by 2002:a17:907:c816:b0:bb2:713a:e474 with SMTP id
 a640c23a62f3a-bc3d0653c4cmr68697166b.3.1777927126290; Mon, 04 May 2026
 13:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-18-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-18-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:38:31 -0600
X-Gm-Features: AVHnY4KgulmNRqZlBvtLyw85ffygQsScV0moutV8-kRNgVXqCfwKJFJDLpVfLdk
Message-ID: <CAFLszTjra2Tcsvki4qKz7h6EBshDccUP0M-6QkHpLMKAUYBw+A@mail.gmail.com>
Subject: Re: [PATCH RFC next 18/18] buildman: set W flag to e to be consistent
 with CONFIG_WERROR
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> buildman: set W flag to e to be consistent with CONFIG_WERROR
>
> Buildman currently only enables Werror for KBUILD_CFLAGS (via KCFLAGS)
> and KBUILD_HOSTCFLAGS (via HOSTCFLAGS) but nothing else.
>
> scripts/Makefile.extrawarn now supports --fatal-warnings for the linker
> and assembler, which are enabled whenever CONFIG_WERROR is set.
>
> Let's make buildman set this variable to enable even more checks.
> KBUILD_CFLAGS and KBUILD_HOSTCFLAGS are kept in case buildman is run on
> a git-range where W=e is not available, it's better than nothing.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> tools/buildman/builderthread.py | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
> @@ -233,6 +233,7 @@ class BuilderThread(threading.Thread):
>          if self.builder.warnings_as_errors:
>              args.append('KCFLAGS=-Werror')
>              args.append('HOSTCFLAGS=-Werror')
> +            args.append('W=e')

Please update test_warnings_as_errors() in tools/buildman/func_test.py
to assert W=e is present in the make args alongside the existing
KCFLAGS / HOSTCFLAGS checks. Otherwise the new behaviour is silently
untested.

Regards,
Simon
