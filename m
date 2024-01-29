Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF1BC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7D487C37;
	Mon, 29 Jan 2024 13:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cAwaJ52p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454B587A00; Mon, 29 Jan 2024 13:11:59 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101B487D64
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-602cf7dfeb1so23876477b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530315; x=1707135115;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8yNpHqX7YiOyrEGifbUTBjBGEfCMKZvo8MtHImOXHc=;
 b=cAwaJ52pwb+vMG83ozzJly3lVYgm/92cUjKH9jbmKKkL7xJ2oYfsTqztX+XKMlubu6
 DAUHJoCOmQ6Gqp5pZKnvAHSVNTLUymhr49wicPfDCwv57HNdfB8eZe2rpMXlayVVe7l8
 VW1qaRlPbzVgCOpZHA2GEQ+O95KVVHwrHBfgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530315; x=1707135115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8yNpHqX7YiOyrEGifbUTBjBGEfCMKZvo8MtHImOXHc=;
 b=QsHLr/IqIOw9br99eqnbXPJ0JDJom6aIyCMsSvelHmyTU4PHXBNmlxEgyQVR+qdCoQ
 TtZ2owk1E1R1VJxLM/4KQl7+aS8NQWEIg6KlpIQL1dAyTzwxoM5LYCQJKDuQzLy7ZwDh
 0/lfuTEmpE3+6OscGY1fmtoLMjBlXAMB5AOdX4/h71bM9PQZ1OJD3SW0rUFhv3spHd8s
 MU7LxfuJB6SSQn3FssUlvz66z5XTTjbS3ZkDKh1avMoWJKIzvCNoHTVT30Iv1LUeo2MN
 PVw2Xl/Khvc6veEJPILQOV9gNtsvSCHo0uvpE3FFm1F3wheUlHjhHDQVSx7tW9uOkaSD
 E0qg==
X-Gm-Message-State: AOJu0YyuXZjkkHqkq2XZOexAVNu96D8fk4qVr2X/hDzXCdyZQl2mMhkN
 ZFgDNdXOQzJO4l0sCvXpovwNQUhuxzuGjoDnw50d8WWIQWEA3+04eaqZxrKbbauktdEb8q4YIpL
 iGmHEPJJdsWXRE0c00n4ClNX6W1fRnIyI7sGtdA==
X-Google-Smtp-Source: AGHT+IGKhikUaXzU0iZ0k+SZ5VrNUF4q+FnAktIL0c9Bxe0FPO7ia6pVcpHHQRpTIHcycxqzDxUVyasxlR9EdFQrOLc=
X-Received: by 2002:a0d:cb41:0:b0:600:255e:9320 with SMTP id
 n62-20020a0dcb41000000b00600255e9320mr3418278ywd.21.1706530314651; Mon, 29
 Jan 2024 04:11:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <c8c0d5bab3cbdf3afe3fe964cc76ad5cc365188f.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <c8c0d5bab3cbdf3afe3fe964cc76ad5cc365188f.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:41:44 +0530
Message-ID: <CAMty3ZAA7c80kjvGxt2QNoz-hWqDuzB6W=XN_JK9bzmOMc5CMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mtd: spi-nor-core: Clean up macros for
 Infineon(Cypress) S25 and S28
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, d-gole@ti.com, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
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

On Fri, Dec 22, 2023 at 11:16=E2=80=AFAM <tkuw584924@gmail.com> wrote:
>
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> Some macro definitions used in Infineon(Cypress) S25 and S28 series are
> redundant and some have inconsistent prefix. This patch removes
> redundant ones and renames some to have same prefix as others.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
