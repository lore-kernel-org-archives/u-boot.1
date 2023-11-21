Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65211C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6A987250;
	Tue, 21 Nov 2023 18:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qSumhpyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170D1870BC; Tue, 21 Nov 2023 18:40:47 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B9487250
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so2712811a12.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700588443; x=1701193243; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNqcHs84gyKXgdyclXcOrm85jRA+HuQNZktkpqZNYpM=;
 b=qSumhpyO4CwqMoQ/BXj/nN7edQUNbvFum1HeTYz/3t4JUhikG5hOEwIXGevxbLIbfN
 a2zaEWaH3Y4on4s2+kwbK87yQcFaudoQKFVE7O3EbaXN8/LitJ4lPIsTNjKxMqHgx7uv
 uYjEDNU2KD9TL9IM6sYsA95hSpKwth5qZ2ojosOspeXJMCvGdtDIqQCZnAUg+wxdJXh6
 RZNrxJu/I95/Yw/wUjZQ0Z+KPsELZgWgQV4rG7+XMjMInM6qOM/zp8xdB0WwfhlIC0Y9
 sYIarV3ukW1O42B403bRNQFrmjQVHLmGhFiELibF4C+yEl9HZk0iRoL7pGUmB+5NezqD
 NhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700588443; x=1701193243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNqcHs84gyKXgdyclXcOrm85jRA+HuQNZktkpqZNYpM=;
 b=kCPGHtX52BBigfWCVfedMdCWLh4HAPnvWLj+iaJMjGMZkWZeneoNEh+gjS0q9oRqYM
 gsaou5tTiEPyt/h4nqgr85idtIw29Xol1PSEe418JmQGlfFvMyRMN0dGP9Xq5EFHsnhP
 tVK3esVFQZDh7nuVlXlUfBqivxgmBLW/yemcmQ+nQF+rM39q0M7n1cFapDiSPAGgeiB/
 MD1djuIZPqpnwhJqhJmDB/0BhvYxIgofD/+5kw8yWT1cCo2HBiKqXYMDU7iyOdD2sGYz
 mrwxMxAHEvCh/PP5VImxch0mEOGe9gwIxH2QVJ2W8Zc9h2IJjIsz9MU6395bbdOsIYVU
 NNww==
X-Gm-Message-State: AOJu0Yzndw/CsFRRdLqc6BwmeVb+P11jV+ZtmfqYxG+pYFV3dN9V0w23
 pc8Kxc5r5UVCvbRuyXXeupJpZ/PVSSCCBO3956i86A==
X-Google-Smtp-Source: AGHT+IHb33jEAePtyIr48q+yumHnCi2vF7+/ejBR8WsGuvzz3rcg3FM4oiczkm3mWAFu4R68wL0YGIb19c8Qa/brU9o=
X-Received: by 2002:a17:90b:384d:b0:274:4161:b9dc with SMTP id
 nl13-20020a17090b384d00b002744161b9dcmr12100107pjb.31.1700588443306; Tue, 21
 Nov 2023 09:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
In-Reply-To: <20231107190601.17151-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 21 Nov 2023 11:40:32 -0600
Message-ID: <CAPLW+4=nvd-4WR5duO9N0cbYRfoG63N64jf0uXtN_Rd0LmtpGg@mail.gmail.com>
Subject: Re: [PATCH 0/4] serial: s5p: Cleanups
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Minkyu Kang <promsoft@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

On Tue, Nov 7, 2023 at 1:06=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> A small collection of cleanup patches for serial_s5p.c driver. Should
> induce no functional changes.
>
> Sam Protsenko (4):
>   serial: s5p: Remove common.h inclusion
>   serial: s5p: Use livetree API to get "id" property
>   serial: s5p: Use named constants for register values
>   serial: s5p: Improve coding style
>
>  drivers/serial/serial_s5p.c | 71 +++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 31 deletions(-)
>
> --

+ Minkyu

Just a kind reminder to review this series.

Thanks!

> 2.39.2
>
