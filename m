Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB17D3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9028F89128;
	Mon, 28 Oct 2024 18:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bl0yIlz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A417E89128; Mon, 28 Oct 2024 18:04:08 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC5FC890B3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so4956188a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730135046; x=1730739846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k6XdSxOJyAv3V8/wrmQjcD+w5Y5LS1kUjYB1GYP3y1k=;
 b=bl0yIlz3qbSshqEX/WBUXcvfeqKmc7u4GTcYluYLdeyevVMC2j7RDmtU8cqaxVW749
 8qfsPC17D3XGqwAA1KhJN+bVCcFS8C+ihiPmyMhfu3ziMwvecZ5FZCASoutzE8xYtbUP
 F5AfcegqgWGBmOK76N0xj5lMJ0ZekXJFW6gAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135046; x=1730739846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k6XdSxOJyAv3V8/wrmQjcD+w5Y5LS1kUjYB1GYP3y1k=;
 b=THKVK6HyHmeyw4uquM/9cQUllBaneKSo1eC5it5Hz9QI6q+SfJrND9s1PUID1+ow45
 0IM0qngOjNXw8LXEcH6xS7mLZKTeppdq3nwp7Om00cQ7OB1pV8Y+etwkhVqW9FDLE7Qn
 SAuiSghNOedXxhTaVVXWSNoqwyFku/999wHB5neDDjD+aP9/BAEuB/vYOqB9HqhsbKhX
 8t3UAS+yW0vR41PhLvBdwbYtl9eNz9DgrhFhflK3Yuiot4P6a5BObJ42P6fjrRr1w75P
 9BFh1CCvspsE8rNfh8X4ks7HOQz1ldkmtGKgGtT0eQrKuc99t9IbJwBcX9/+LsaANkKt
 pvuw==
X-Gm-Message-State: AOJu0YyXmu3yTepkCgJ5E9SIuWReWvCdqPOi/3tEUrtZJDQ/7ZeRlH/i
 cBIBipTG7GJ3U4rniMg2cap9SuDN42jWP3TlVx/CpPe96tH00ywgd9JIYksKiclMtdi33a7QFyT
 reYeEkdqdIrl37BfKCNHexdeAN4lytgkp71PD
X-Google-Smtp-Source: AGHT+IHX2oBMHR0xpMHQLZdWN3hPAzba7op/SLYTBlQLAI4JjYnEUX0Gpe2H9zzyxM9MHpuYAsx8bEThXnKBGgLuv1k=
X-Received: by 2002:a17:907:8689:b0:a9a:bbcd:e63 with SMTP id
 a640c23a62f3a-a9de5ecd05dmr894799166b.14.1730135046146; Mon, 28 Oct 2024
 10:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-2-raymond.mao@linaro.org>
In-Reply-To: <20241022200543.116343-2-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:03:55 +0100
Message-ID: <CAFLszTg+EpReRc0HmLYCfXC1YpSqAR+v4nCAHwPSMDDw+Q_Www@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] smbios: Refactor the smbios headfile
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Wan Yee Lau <wan.yee.lau@intel.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 22 Oct 2024 at 22:06, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Move the smbios field definitions to a separated simple headfile,
> which is a prerequisite to be included by dts files.
> Add new definitions for cache information.
> This patch also includes a few of code optimizations in smbios.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
>
>  cmd/smbios.c         |   4 +-
>  include/smbios.h     |  81 +++---------------
>  include/smbios_def.h | 191 +++++++++++++++++++++++++++++++++++++++++++
>  lib/smbios.c         |  44 +++++-----
>  4 files changed, 228 insertions(+), 92 deletions(-)
>  create mode 100644 include/smbios_def.h

Reviewed-by: Simon Glass <sjg@chromium.org>
