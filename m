Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11091F3ED51
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE0684154;
	Sat, 11 Apr 2026 15:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KBm9Z5HO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A4B84181; Sat, 11 Apr 2026 15:27:29 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7CA84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso462272766b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775914046; cv=none;
 d=google.com; s=arc-20240605;
 b=E2rFbEbX8QfGMaG9N1gneqqXsorsaoNxGsduY9Y/jFoOSTLkiMlamQR8+kg4gVSBRH
 8yDMM3rwrHmuEZwHBxE82bMuZscXF5CSTklOKV3CLRQ+8HwyEL/wdhNlUHWuq0iNgdih
 PLzYdXV4YL1BXIpSDX4A/7HidcmiOLFsI4cFCmL8vAyS4d8SN+kZMddnsinqrYCSLz8G
 5QIL8nkQ/w2oJZ4kM3OhZBWAWbFQXQGroBtLOJjltsUz804hN3W3V+yESzd5+cfwIZ6d
 VqEU4CBZlhIV+lNbdYXcwchjkvI7M/u5hZk5o40L8LkAcM0phXMqh4cfiij2qtpkTReB
 1/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3nFeXn9W1MJhkDiMcpiGfDuGKmWhUk0giAp1Ce/JpjE=;
 fh=1L6vZ7sPlbPu6y+g3mNCPeF2C6+dBJkeSiSHnCxwzC0=;
 b=axxGdjGYeQdbu5ZeFyTaqWcJ+tuzhi/rMDNvif1q42uVB1raydf2ph70PtVM1TC3Cn
 u+GQ+brSunr0K7i86YHBhD+NuSgcKIwxZMLtoCs2ApYQa6xGhX7bYVio5ePO2dz68Nqn
 OLGwPr3P6qHSRmoA2eT/OAVYWIUK5uqw4mit2r/u6YxZDykUXIY9Ui9ylNuqmuPZzJZV
 1+rBVJcfugcCH0NNudAOe7edeyugjqFNxt+xyimAagARgJBY4bPedyxeeB8ZpT5K/lO1
 u4gjyQ4ozRTv/9kcVoE7lN+i2uyPezW6jrp5kFNvGxjHx2Y00QvyAFFtNpTTjNM8PkOi
 lfWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775914046; x=1776518846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3nFeXn9W1MJhkDiMcpiGfDuGKmWhUk0giAp1Ce/JpjE=;
 b=KBm9Z5HO9RNQyzTmSXpoTQ34gZP9ELYT5EkYtDWspSPRTWGbXM182fQBWSStd8AORo
 QFaAyKgrpg31xB0KUv4ATCx9r+EA9tiC1VtFHqckETiWpyUDQSvFhfXRH5qt7rlVTWre
 J5Rx2H+wBsaC6wRFbtcKppatBKinUwsRBZERk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775914046; x=1776518846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nFeXn9W1MJhkDiMcpiGfDuGKmWhUk0giAp1Ce/JpjE=;
 b=hw66hRdlhkCYoN39aN95MVtIWvutegX1El4TBggbUNJuKZc6JDMjQUfwN4pKcrwkoB
 Y18PmG3qEt1GLQ7p15Al+Zw65GuvD7VLR28aLr2dik/ozTWiKgbV82szqO7TnNGO8HLe
 08JL6hQEryKe4JvWSZHLFwHeIG4dy4h5L+S8oAz5cpEBDLuaxL2cJDB36gsKnDVl43bN
 cZiUB+Px4wjC8igoi4dFRSlllVwXUP7tkKU3Lz+OSHZ7utHSNjyqynJTB6ftOE7YiGO6
 7NkxqwR3qZtflwkM2743vfj53N3ITkM70JZWS4/J4e1jL+vNxoUfkIyWx8wEUTO4mPrz
 Zqpg==
X-Gm-Message-State: AOJu0Yyg4aSlHfVfSv7Heh6I8fb4lFJmq22ayQalKyP36+uw6UXUbhyI
 2pxqJHSbxcEKTduPQRUTjB1aSpFf2TQAu1wsqmRESVDWBKG8zUPGCPy6JSPjS3JXWtNa5bCfaFU
 aHZ5Ce9vzk9kIiWrlRx1RBbCqJgVaTdUi2Ngm28Sj
X-Gm-Gg: AeBDiev9i8KpRUfh/JE1VpR5aYjDfL/KbmJOmNHo6GkmfgGV3TXczX6XWGX1NNb0mKy
 3jSxqNLksEtV0lMsDWRbLRdRXiJvYXmCNJKYP3HsZF2sASHInA172iSGnplVGRW0tRQ29p3RXpj
 4ihysDspiEsdbRzAw9Is2I/ND4hup5f57ddFLCRM9znyWkOLLxL2arz08Z9c4dqsbIj/iN4i5aj
 OS2TurhXsNePQNxgO1QkxjW4TW1mnjQtgK2EOVAwUPjrHFFl8405GC8uLbyZyO924l+s/KVjsxD
 3QahAdpZQc5H99au
X-Received: by 2002:a17:907:a03:b0:b9b:e61c:2f43 with SMTP id
 a640c23a62f3a-b9d724ca822mr396053666b.23.1775914045971; Sat, 11 Apr 2026
 06:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
 <20260408-ui-cosmetics-v2-1-721dc6d2116a@postmarketos.org>
In-Reply-To: <20260408-ui-cosmetics-v2-1-721dc6d2116a@postmarketos.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:27:12 -0600
X-Gm-Features: AQROBzCUk0kRr5lE5ttM2naQCAIOeiV7uKSj8bxPHMu3t7Vg8Q4_Rqk9qgUSa2U
Message-ID: <CAFLszTgwK5nUs2QA2Mh_pkTXycAiA0L4ukD8qywubW1AmTetxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
To: funderscore@postmarketos.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>, 
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
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

On 2026-04-08T16:34:55, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
> autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
>
> The autoboot prompt used to only be customizable in Kconfig when
> AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
> autoboot prompt alongside a splash screen, there is no reason for
> AUTOBOOT_KEYED to be required for this.
>
> Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
> print_boot_delay() instead of a hardcoded string.
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> boot/Kconfig      | 30 +++++++++++++++---------------
>  common/autoboot.c |  2 +-
>  2 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
