Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5A7C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64F280805;
	Tue,  4 Mar 2025 16:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LdCWejXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD5080805; Tue,  4 Mar 2025 16:48:11 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB4718004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso10826043a12.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741103289; x=1741708089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3LCOitwsW3mbj1Rek1hhk0E2IO5/+MpX9/F9pGicvDs=;
 b=LdCWejXjTsARjC4qFskamh7Awl6qPE81T++xWIz1u91QSye8Yo2VO7hpc6UGiTGp7A
 NkamKcz7qn8IyILKzrYYhQ2ozE5z7guJg0D+NPdDGSb1uVxytB5NzEPIMxQZqd81+0et
 gxnLgFChZjTo3s6aidtRKYING6wE5g22igcU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103289; x=1741708089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3LCOitwsW3mbj1Rek1hhk0E2IO5/+MpX9/F9pGicvDs=;
 b=HyGOOWgXrI/uZjMLQkOq9jNsL/V3IzolTbgHrnaYzv/NYN3UVhQcSW1xYDaIDW2Ymx
 Rapw8Al1BsZ9l+0BcvFKG9zsCo7qlX01/OqSQ9WhON6ANxhiYwmoMsn9wI2LRyWQBidr
 X8oBJJJ0At6c/Tmmx4pq/W2Q4yqvX3EBvWfctfnh/qcRx9FUDW5iOHrqAAfh4XwUglEZ
 s1U6Oza8SfIjo4U58oUwKh0O7SWQzo8TF26o0n+YUt5lLpQFQrv8ZKjWnQHSxZ87MGsZ
 ZIpztiRD/rKATPF/BNUEf576SJJ80dYhhEqTWlzHL6EUMGv8k7nniFa61B6rbOqptGXW
 RBvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBByIs2OLtVlcHgaue7T2ACumkBspzO/GhzixY4SUzRu5FKicwGa8uDNwmf0T3/GkCdMWxUyo=@lists.denx.de
X-Gm-Message-State: AOJu0YzR1sGqT9aXoGJo22NQXBxzGa2NbYEudT8qgJP1hI5rRIduDlV+
 nEVnZGYJu7Z1P50gRULDmjXQcnbvF1QAADyeaTFdGuhJbb2A1PbJCIAjV+tuH3UVqJRTlCSJkvO
 UWdRwoBdxUHHrNpOzIDFUkJz68ks0W7liEdBB
X-Gm-Gg: ASbGnct9ZBGCBTFwH6tO54jkldphA3rvfIGovQW7AK3e3Y+ycLChxb24vxiuKqC2QGY
 WlyhppWxs+3uYYMLBNOmuLZ4UfI35Bmg4dVI7HRl/vOyjmpisivZS37VzhfX6m2mvqXlWbHgJ/O
 8hWXBEhTYMCGOEPRDhApN9fqRmfnk=
X-Google-Smtp-Source: AGHT+IHe/VlkAWZZeT4z5VU0jsML3CrnjdVSM5R0EDiXqvScYcgC7xBsHRiZNDbgZzf2K7dm2qWf/kLup+HpQcAtdO4=
X-Received: by 2002:a17:906:8d8a:b0:ac2:55e:c3bb with SMTP id
 a640c23a62f3a-ac2055ed789mr90950566b.2.1741103289270; Tue, 04 Mar 2025
 07:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20250224120214.147646-1-clamor95@gmail.com>
 <20250224120214.147646-4-clamor95@gmail.com>
In-Reply-To: <20250224120214.147646-4-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 08:47:57 -0700
X-Gm-Features: AQ5f1Jq_AScwCfDYUcJkoABaudgr-WLOfPbxPQzYm8Rkonfbx9FdMwSpyNVfatM
Message-ID: <CAFLszThJop_Lu8QWu5uVf=M354K58bxH9xh9JJSgDXd_HEF-rw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] video: bridge: add transparent LVDS de/encoder
 bridge
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heiko Schocher <hs@denx.de>, Guillaume La Roque <glaroque@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 05:03, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Add a simple and transparent LVDS de/encoder driver with a powerdown
> gpio and a power supply.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/bridge/Kconfig      |   7 ++
>  drivers/video/bridge/Makefile     |   1 +
>  drivers/video/bridge/lvds-codec.c | 128 ++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 drivers/video/bridge/lvds-codec.c

Reviewed-by: Simon Glass <sjg@chromium.org>
