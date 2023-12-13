Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA131C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBEC87905;
	Wed, 13 Dec 2023 21:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vl0Gczh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74442878CF; Wed, 13 Dec 2023 21:39:34 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70C9878CA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a1f8f470903so552921366b.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499971; x=1703104771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aus/8pTcXHVgk0sjUDZzsffPZqEGTJsQ8dYD6BgW/Ck=;
 b=Vl0Gczh0BqcK1NT8S7a5xc/cDmfCwFXTXPr0FugOHWhP14PHpxhtof+j6eYy7V0X0n
 csmHdhbHA0po23YmmP8DsYrVevkAPU5G1OVluzcRpD0sT3OWR/pfCZEl1yLFO84DYHYO
 euDW9m/izoycJ76NVxdq9aoAaHG5wIIZWOwBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499971; x=1703104771;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aus/8pTcXHVgk0sjUDZzsffPZqEGTJsQ8dYD6BgW/Ck=;
 b=IVxKZMIsGDwqe+FNuZn1+T5xHU6fWZKpPLIhpjTPgdlpEIDvZK/HCfHt25ffP2ZZVx
 gAPGVNVdlEJYKCStiTWL3W8rmH7TnfFA8eQR2CcMFBIBGsCxf3twh62OQ3S6vkS2DQMI
 FGgVVn82s1XxzajziIxqGtA0SmRrTqemujFOjBPcyofFQBO0oVXOcfvIVeZ4/ID+r+dX
 Yg+RnxAYn/QO6+DHOUvEn/tMaKTrHeqRyo0gKLhqBw3ndByNEB9tpGAah8T8WvZS/xh/
 2XESO+m8oLD58dKBxbc1dqqu20ffwry0Q9UcibbIYz3KZrb/9ygcqZNBuP04xFdF8uGW
 dobw==
X-Gm-Message-State: AOJu0YxXiPhTd10Ic5UCN9cnZSKCxxh073a9GOjiC+xbzot9w8LCjlPK
 me6rJWqJLgOrdF6os0SjPdxRR7iKUdlxpzN5wVR+/w==
X-Google-Smtp-Source: AGHT+IFcQFj6SOsVZWmnpaVZKzaWVSqSkzNszJo8TE0XYqilM2DOH0HTWtZjS1zwYBud5Slb9E85YHdJjcbUQxjvjH8=
X-Received: by 2002:a17:906:6a09:b0:a1d:53e7:dcb7 with SMTP id
 qw9-20020a1709066a0900b00a1d53e7dcb7mr6327162ejc.41.1702499971410; Wed, 13
 Dec 2023 12:39:31 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:30 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-15-sjg@chromium.org>
References: <20231002011553.463514-15-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:30 -0800
X-Google-Sender-Auth: xCIFq1KaLepRVIJP04Yfx8nRrfE
Message-ID: <CAPnjgZ3AJXkGszREbHF65FjpjWrKW4eO8=Wykpsxf_9oQy8uVA@mail.gmail.com>
Subject: Re: [PATCH 14/34] sandbox: Add a dummy booti command
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Add basic sandbox support for 'booti' so we can start to boot the test
ARMbian image. This is helpful in checking that it is parsed correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/lib/bootm.c     | 7 +++++++
 cmd/Kconfig                  | 2 +-
 cmd/booti.c                  | 2 +-
 configs/tools-only_defconfig | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
