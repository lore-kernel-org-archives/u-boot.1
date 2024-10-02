Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D27CF31B9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 04:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2871890DB;
	Thu,  3 Oct 2024 06:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HRboADNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8638E88F75; Thu,  3 Oct 2024 00:56:03 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46FC8912B
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb399056b4so2795836d6.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909755; x=1728514555; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tYJJRoCg72HK9e0hgFldw3GVUMAmA6OH0gYMuWFBKqc=;
 b=HRboADNydjFeYnCXpLcwS6tvTi+KvEvJkeN28I5aVXT/rU/1VU6ANd02lmsM7U3HhX
 wX/4Bjr+wu1KP+cYLfkzRbvb3COyMi2nMsvM+7/CG5hwn5LZJUNV0jukM3XlLyMgS4Fr
 gVggDZrds9gVv1lY1tdT0o4pe9djv3FHN6wRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909755; x=1728514555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tYJJRoCg72HK9e0hgFldw3GVUMAmA6OH0gYMuWFBKqc=;
 b=ak5SJhaSCJ/+8rdNfI6HXnduRFUAOO+s6pRL/l4xZx/zmlx8etDcxaWi5wRagvBAS2
 FYNWAiOnWO/JNX9sk6PmYuyo+LNHHZtkQgThWCL8OxgMNreT21btsZI5Zm2Dm6EmzLdt
 7LhMQIMfxvw8XaS04Vwy9u2Dz+AY+oHlO65nOittGiF9N/y16oix9nWN5a8q5efhkRTY
 hITEiTnIBqm+rUDl3jAC8gUxqJx9qfC5JYh0VYY9r6E9Tq2sXa7Qee7sk5kibtmzp3dQ
 /s1CqhGZIkyfclIe16cMra95/8JNv0nZwDMzMp95Kci0Ov0GCxjq9K6V8cuzboYs/d7V
 +dFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3qyuZmIF3jvcWP9sgfTyTp0TrUnLKJGy/dPO4lmLjqoEgSZf8B+aaxGuPpQfp/7lu9HNvk3E=@lists.denx.de
X-Gm-Message-State: AOJu0YyqybV3spGgIq2VVqlvzhEMqEQYjNkvPn9HxqKJ253MlmWtQKF2
 ID3TYip6NMOj/zUy+MbGGi4/mUB/kkzzv+iZjSqTl/aHoAE3UPSiAykMVuhU4tdQK06tlu3KYDE
 A+8To4PpkbpwDbgXCOK4d4aBvTyQuluo6iK+s
X-Google-Smtp-Source: AGHT+IFggRSutYZ4wNrZroodIm5xhzFjLflrOWWEu5x+mVdX24/+J0JNozMOu09Yzdl7KxPZz3HGYZdrKcvik49L2iQ=
X-Received: by 2002:a05:6214:2d02:b0:6cb:830f:2da9 with SMTP id
 6a1803df08f44-6cb830f2e01mr52232376d6.5.1727909754716; Wed, 02 Oct 2024
 15:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-6-ansuelsmth@gmail.com>
In-Reply-To: <20241001122511.8832-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:43 -0600
Message-ID: <CAFLszTh-E-vK8Ren1LnNkUsk9vMaAgBN6FHxHVfqnZo0CnDaxQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] led: implement LED activity API
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Yang Xiwen <forbidden405@outlook.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 03 Oct 2024 06:40:55 +0200
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

On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement LED activity API similar to BOOT LED API.
>
> Usual activity might be a file transfer with TFTP, a flash write...
>
> User of this API will call led_activity_on/off/blink() to signal these
> kind of activity.
>
> New Kconfig is implemented similar to BOOT LED, LED_ACTIVITY to
> enable support for it.
>
> It's introduced a new /options/u-boot property "activity-led" and
> "activity-led-period" to define the activity LED label and the
> default period when the activity LED is set to blink mode.
>
> If "activity-led-period" is not defined, the value of 250 (ms) is
> used by default.
>
> If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> led_boot_blink call will fallback to simple LED ON.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/led/Kconfig      | 13 +++++++
>  drivers/led/led-uclass.c | 81 +++++++++++++++++++++++++++++++++++++++-
>  include/led.h            | 51 +++++++++++++++++++++++++
>  3 files changed, 143 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
