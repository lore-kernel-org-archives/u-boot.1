Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52E8CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5B3846B0;
	Mon, 15 Jun 2026 14:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="US5pCcLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E093E84704; Mon, 15 Jun 2026 14:11:56 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D32846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBF1742B6C;
 Mon, 15 Jun 2026 12:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271FC1F000E9;
 Mon, 15 Jun 2026 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781525512;
 bh=NRTP5KlZhyKYAq3wvPQZZmiB0T7F7lAwxX8TDFLt1U4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=US5pCcLvR0JZJ+xW6ZL6CGsoCOpr5KJHYXeRnnUy2gXDXNExNeAcoYicWzSbiVQOO
 Fom3sAOPqhR4P7nv+OsPAl5frctpWUvUHQ49/Touyft7JFsH/o666FzISNzhfcNoay
 hVQGnIlEKrZqqnnGHZflRHCebEjMfbVB1GMbOK6XS6mhpxix7h63F/qHNKN3N4nS9X
 dyV8NgATHlAQTW1e5mEGaMfWu5ifHl1ZUqWYmUpOZhc3bWs7XwJjuRAUZ8Mbc0UbDs
 oOlA5wrf7L52477Wsy+nCVija0HEGfJI8guX9UpJu85WdXy/5PBtYlHBbHvwRu86uI
 XkXGYJRhB19ag==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, Casey
 Connolly <casey.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 0/2] Fastboot abort key support
In-Reply-To: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
References: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
Date: Mon, 15 Jun 2026 14:11:49 +0200
Message-ID: <8733yohuka.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sam,

Thank you for the series

On Tue, Jun 02, 2026 at 18:45, Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org> wrote:

> UMS already offers CONFIG_CMD_UMS_ABORT_KEYED, which makes it possible
> to bail out of that mode by pressing any button, rather than only
> responding to ctrl-c. This is particularly useful for phones, where it's
> not possible (yet... hmmmmm...) to send a ctrl-c command with the
> available phone buttons.
>
> This simple patch series introduces equivalent behaviour for fastboot,
> and enables it in the qcom-phone.config fragment where it's most useful.
>
> Signed-off-by: Sam Day <me@samcday.com>

Tested on khadas VIM3 using khadas-vim3_android_defconfig.

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Sam Day (2):
>       cmd: fastboot: Add keyed abort option
>       board: qualcomm: phone: enable CMD_FASTBOOT_ABORT_KEYED
>
>  board/qualcomm/qcom-phone.config | 1 +
>  board/qualcomm/qcom-phone.env    | 2 +-
>  cmd/Kconfig                      | 6 ++++++
>  cmd/fastboot.c                   | 9 ++++++++-
>  4 files changed, 16 insertions(+), 2 deletions(-)
> ---
> base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
> change-id: 20260602-fastboot-abort-keyed-1064ecc677de
>
> Best regards,
> -- 
> Sam Day <me@samcday.com>
