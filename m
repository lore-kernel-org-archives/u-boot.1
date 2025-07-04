Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEE3C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A7318206E;
	Fri,  4 Jul 2025 15:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DL3ZROAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD0A8277D; Fri,  4 Jul 2025 15:48:42 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F40806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-553b60de463so1060263e87.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751636920; x=1752241720; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKmbsOYdM+UV46fOUz3FnlMjmjc6CM43hLped3hcDM0=;
 b=DL3ZROAVkkf4UB1oRO9ygvBNXFl6xsQuVplcsJieEAkIspjbiCpppVFL/MCBwW7t5P
 VPeai3xs13r/4eA+hYHXATLetodWczqLTKMT3lkyqtpeJgpm4U2jw/3/RwDPCA6jBOhf
 lV79T16q6UtHWtyYNJG6v2nWmDUwB8nw69X9LVkY0NOiG9kM9BL2vN1jc2FOP7A9u+2a
 EBZED3YxPq0LZ9G3AWXH/6MNKMBrKzG5+NnghAZ9leTb9HZCsu+OmHNUsbaBiU4jBtJu
 tSwl3Lzrs01y1/WnMvl7HYo8jIyn237E8OgnZdEdDjWOplGRM1YntDbooZIYB9xmhlL8
 WxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636920; x=1752241720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKmbsOYdM+UV46fOUz3FnlMjmjc6CM43hLped3hcDM0=;
 b=hhgL1iQw6PKLX4ZkiLFvrd3lHAdgutEykULVZRBCWzHlvQtLGUNNVD/xHfKYD1znKK
 cVg2tb9/SIg4svwnaDbIuVJXfL5gA7ZkGQQBlc/HnrT3iY0q9+XOUHO48w47TGfhX6H3
 DSB1h8IK5GdvY+2vPECdDRaTen/GNnGWGOSDZRnMnH7FwePM+s9ZoDvUDQwDkorXxYcs
 6u2NJv3jyR6+ZU4+PWmanXz9hhoxmVGs36hVrZEXyKUouPC8cNd03OhjrOVrLQKIZkB/
 cgVhPIqG6ShP/jeT0Dimu90cDsv0EQfpFNhXpwXVyLbxdfmq5wQvZ+YLmAFQa0xx1pth
 FiWQ==
X-Gm-Message-State: AOJu0Yz3QEXRjffAdiiPzssoBMc4tc3RusRBCF1olBFtkLANej6TDgJ1
 T023ztHQUJ9kZXIhIgLHoPQfYIBENGRdc5St5SZrAd8hCYnWzjKndLnj9gfdsh8/aEtNeRe4FIB
 w+TX/LalVhpcMF9bfoWx17tOBlspX0fw=
X-Gm-Gg: ASbGncsltghQOSqMAkFPvYvm00FP1lZc58MQaFO6elppEdvlCrpHOVybZrUl4pQfLZJ
 4xMTZ8nt/98gBPkZGcu48sW0QqG5hBd9TSYs2SJFRqFa009gajeyYloVOJhtnro6ktMpFclh2kp
 /QZ7thylMnoiVaZs9e8mCvy9LIBUcfq8aS+Rc4AHOhFGC35RTlMoRj+CWHcLliw1et8zi0F50pO
 A==
X-Google-Smtp-Source: AGHT+IGTIbUn9Sec1pNeeCnvPFjDtgZauGFZfgfuebE5iWFcjSTgt7js5pW2vOm3p8xsybQ2X8ES60KAxHF8/xzFGkg=
X-Received: by 2002:a05:6512:2399:b0:553:2e27:6769 with SMTP id
 2adb3069b0e04-556e656a34cmr856721e87.7.1751636919693; Fri, 04 Jul 2025
 06:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250704130319.3814676-1-festevam@gmail.com>
 <20250704133105.GD6424@bill-the-cat>
In-Reply-To: <20250704133105.GD6424@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 4 Jul 2025 10:48:26 -0300
X-Gm-Features: Ac12FXzwc3vpTqbg5TI6jozwxY0f-_N9T5Fi3Q8wKj9fubl09B4KVNUBXApOdO0
Message-ID: <CAOMZO5AtVXOxWjMQeVeUtbU1Z_D_DvQ+0a7OzzHUskSK8wFJ6w@mail.gmail.com>
Subject: Re: [PATCH] mx6sabresd: Increase CONFIG_ENV_OFFSET to fix boot
 regression
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, otavio@ossystems.com.br,
 michael@amarulasolutions.com, uboot-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Fri, Jul 4, 2025 at 10:31=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:

> If we correct the size limit for where the environment is today and
> switch to CONFIG_MULTI_DTB_FIT_LZO do we fit within the limits again? We

Yes, changing to CONFIG_MULTI_DTB_FIT_LZO generates a u-boot.img of
715488 bytes.

This fits within the existing 715766 limit with a 278-byte margin, and
the board boots.

After disabling RTEM and PLAN9, the binary goes to 715200.

I can submit your suggested changes to fix the boot regression in
2024.07, if you'd like.

For 2024.10, we can discuss whether it is safe to use the current
CONFIG_ENV_OFFSET, as this is a topic that has haunted us from time to
time.

Thanks
