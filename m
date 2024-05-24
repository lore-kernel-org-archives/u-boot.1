Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF6AC25B7C
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AE5888EE;
	Fri, 24 May 2024 18:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caZYHi3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFED1888F1; Fri, 24 May 2024 18:28:48 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F381988647
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-65ccb89b2ccso377808a12.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716568124; x=1717172924; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TeLLWBXAQBNvbGupQK6KjbQ8kBamnmr1O22i1DR2Uo=;
 b=caZYHi3JfKt6ac9egHEcfTQluYqdBd9StD6Y6IDrXZpg4dCFkYQdICXzQc8cGIiow4
 rxWKhRXi9if7ZRitOyoLtt03MgOePJkK+YV7rkjxITctgOqI1DjS+p4DpGWN8NFaAfPn
 DnKkhc0wfDOCb9jG7ylKA1tsNL3QzxxjrFaaWkenqiqvKQ85zdd/pC9tsd80vfF5xx7E
 VbWJFZ4ZI5Zn5wmmCD8cpPWLHbsZPFaZGIA2nZzcqF3lTnWARgDqVFnBknwOrJIt1ES+
 Ts9dOUrUrBxvctJIa6nEjy9unC2UsFb5O7efYgrtPGplVDD9w1+GmM8UMEsR+c/avDD7
 CPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716568124; x=1717172924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TeLLWBXAQBNvbGupQK6KjbQ8kBamnmr1O22i1DR2Uo=;
 b=u/19/whaTofNqzT578spjTk8eehJxlCdJTtNxt/YckbgGrWiOJkTlE6rDlM1dWNYmo
 R5VuvfpU0GNng1Cm0/tanMtzoL2gruq5srrtBgCg/vE+Dbv1PnjXiIXgtI/thmJFhQvV
 K6v51Kq29PWNFA0Kl045EMYk8kbNAR2fI9thVtivbT+f2novv7GYAPKqUHIYzwzHdW6s
 8tgQpg4mLOta/2GvLzA0gthO8yuJ8xGst/y6oWtajCNwlh8XXtIdjtovNd/qV792P0B1
 wBwTTEXxcEanMeDqa1jgBcTm20tmjkOs7Gx+RH6tbLpYb/4R7xSjzPzidkj8EZfs2D6y
 GkRw==
X-Gm-Message-State: AOJu0YzFXgWn1x/CtTOFmstDPOGt9VPD40ubAdlY/wmDcYOHjv36qwVk
 7snFxwEvLzl2YptxTKLLv7KjE2eXjYlfHtGxp9KAljZW5A7XUWx2fcLkHE4VKlzhkihOrmrwPJK
 jUat0P/9FppZVHj+e5FnEwInNHNo=
X-Google-Smtp-Source: AGHT+IEfl0f9d/8ilEesNzxy+G/IsmOw/bymIxWjQAbXjCnmsCKOlijPKa3ofNI7Kzt2bszrHE0eYU74QL91pCP3YuA=
X-Received: by 2002:a05:6a00:2176:b0:6ec:ee44:17bb with SMTP id
 d2e1a72fcca58-6f8f3e843a1mr2740235b3a.2.1716568124505; Fri, 24 May 2024
 09:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240521093950.8810-1-marex@denx.de>
In-Reply-To: <20240521093950.8810-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 May 2024 13:28:33 -0300
Message-ID: <CAOMZO5BEVrasUbEQ0brX2PbfW+W2eTmWrruZrtD9b_cwgrMonQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Increase PHY auto-negotiation timeout to 20s on
 MX8Menlo
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
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

On Tue, May 21, 2024 at 6:40=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> The ethernet PHY on MX8Menlo board takes a while to come out of
> reset, increase the auto-negotiation timeout to prevent it from
> timing out in case the ethernet is used right after the board was
> reset.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
