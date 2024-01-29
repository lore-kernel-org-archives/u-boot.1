Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0628C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 11:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120AE8785A;
	Mon, 29 Jan 2024 12:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kGnS89Db";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C67EA8784B; Mon, 29 Jan 2024 12:49:13 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3893E87A00
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 12:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5ff7dc53ce0so19769507b3.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706528950; x=1707133750;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkY/lkm6KeTH5UkyWCMXsTl4VJNTxEignO8o6JXzqnk=;
 b=kGnS89DbfwWox8NSbKo/o9+klcQrukFgE2p1zqaRATo+6RxzCmWXozLf/Fjy9f1OAa
 VeLiv54+QR/k4P/Od6uIwHMvx5zoln7vrHwK2X+e4680tBkshbUWxC7A3tqE66bDjtQW
 gy/cEwJXFZVYvIQbBvY5EcGld7+qN4nLJyS7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706528950; x=1707133750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkY/lkm6KeTH5UkyWCMXsTl4VJNTxEignO8o6JXzqnk=;
 b=Z3zGx7klyCvUPsk3WevTpNQjUdt/D4D5o7AdaWoiNJToX6chsc7X6DPa5AXqUz+KM2
 XQuuwmuOzDFJPXQWWnVPGHow7cqwgYW6mtkEGkP+MzAunz4liO91yJsobfRWqVr4BlWP
 baAaF/ctARN8Uo4vEr856wSp/ax8rzOkYAjFlfZbrD3hRoedtbtnBRVFu4ohXXAyGN4D
 8HizX0L5LdR1+hmmTX0CJVPTQBf6A8d34Zg24tMiUiOTMqV44XBBbSD4ogtYnRY131bp
 EU52uN67+ckgyLWzK0XITcfHZy2aDQhU3lt1lTiRfFhFpLY0c6EykZs25DttGeECQB/v
 2XrA==
X-Gm-Message-State: AOJu0YxrSW2RJDJEhPXG/CATF6OdSlokN5y9XrzdHYSmh4RUEkXdUGPt
 6wfRe4DTosdRI3vCudEtvHB2/Pa55KeU/cwjcXkWC/+u1YOLEygIYTt7LRWoSCjNunKz9DE/6vw
 T+eGz1fONzgmB+d3abEDNcieexG0dbeRZhnHoYQ==
X-Google-Smtp-Source: AGHT+IEU6Fl0HPApj64i4mHYTlas6F8VdHjXUiwP4/50ZVPwc4vVT/lODLBz1zQVEy/GFksqdvaxZpjRsdgA1l+xY6k=
X-Received: by 2002:a81:e809:0:b0:5ff:abb7:2234 with SMTP id
 a9-20020a81e809000000b005ffabb72234mr3032437ywm.25.1706528949761; Mon, 29 Jan
 2024 03:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20231221101331.3263153-1-bigunclemax@gmail.com>
In-Reply-To: <20231221101331.3263153-1-bigunclemax@gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:18:58 +0530
Message-ID: <CAMty3ZA=aWmEPHKLP7dY5+Vd4Adi=EPop1R8gG8X0PdM-LyHHw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: dw: add check for Rx FIFO overflow
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de
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

On Thu, Dec 21, 2023 at 3:43=E2=80=AFPM Maksim Kiselev <bigunclemax@gmail.c=
om> wrote:
>
> If even one byte is lost due to Rx FIFO overflow then we will never
> exit the read loop. Because the (priv->rx !=3D priv->rx_end) condition wi=
ll
> be always true.
>
> Let's check if Rx FIFO overflow occurred and exit the read loop
> in this case.
>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---

Applied to u-boot-spi/master
