Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0920C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CD188354;
	Thu,  2 May 2024 15:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D+iOsnWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD6BE88361; Thu,  2 May 2024 15:16:11 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C458834B
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 15:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jassisinghbrar@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a5966f5a76bso140789266b.1
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714655769; x=1715260569; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CSnPKIoAjXTIqHnTo1hVSOxafrRD011odSIZ46v5WA=;
 b=D+iOsnWl+x3WdNoBITVaWWFlokiREufgbot9mJS/gLNjXd8vqlqklBQ5+PXgraIPWe
 GU/8BivbR5qUyHAv5pXzBX/AF2IQUrdUMKEdz0XpQ1isWBpenemZxgsZQfoaJ8dU6iyv
 pk+JlLYrqI4Yr6ZrFhHzWNOuSXf40n/fEKWxVhdupwEnEVwTkPt226VmJI8x7NFLC9sA
 aQqcLewbOnzx4Fy2EBVxj6AHzlsz93GWSFQyN5EmvG1vWIjuuc/aeqCaf04gIdQhtUDg
 qlAUmqUhhIhAdxppUQyb/UfpJSKUbLVvoeaS23Ly5yzz6En7zzMPLXh4092ksJ/+axqP
 NG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714655769; x=1715260569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CSnPKIoAjXTIqHnTo1hVSOxafrRD011odSIZ46v5WA=;
 b=abvTBQvuC/xmx7Brl3eNb/1IaAMN2lxzX3Tz8/i+GqzZOHvT/gRKEyNdX3PlZH8IP+
 afqqb08nKxitrH4mqIaO7qmCNWir9ZhOOK/KQvMPN3Sh2xhZz0UQuliCGRcoCYjPI/vc
 81DzhIF4UvGrWLVLMld9Y/7z6+mEThT0U98xWYNGxZVt76mJqg6F0PO9Dl7yJUJLWH5c
 3BJZZf9xjEmcEgF6J512lVJ89auvZYBLFN4TMHin6DfgK2z+3g0dCROHxpN9AxHmga48
 PX9IGfhapgjJHtgAECMkJazbcX5MuxF1v1ck/eajn8c1lVxO+PgvZ4EQO7oA7MIGHusc
 nc9w==
X-Gm-Message-State: AOJu0YxLzoNdxB0o9ArJ/XMT3hFPgdzhVKkqSXSBTt37qWmLozbenVy9
 q11de++QHvSInEI+d+Pj7YJ+ski0LS444n3gv6xJ9fgDfqxU05gXe839Pbo4UQyJi8Pfb/hDaBT
 a2ajUTV9W3e5U7MZjSq1exkvYP/s=
X-Google-Smtp-Source: AGHT+IGwV09A5Snl7dmpmoqKXi9rs9tW8g5BMA8SgbejtPKV9TlDQKMYof41J7PAeQRu45sd7Q8PIOw3lzkMQ68eZkM=
X-Received: by 2002:a17:906:31d9:b0:a58:bcb2:5e33 with SMTP id
 f25-20020a17090631d900b00a58bcb25e33mr2098912ejf.18.1714655769051; Thu, 02
 May 2024 06:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-32-trini@konsulko.com>
In-Reply-To: <20240502013138.2383421-32-trini@konsulko.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 2 May 2024 08:15:57 -0500
Message-ID: <CABb+yY1AWgfWuxh_rkg7zx24P9aCQ68t8qiHpv_n0vKnAoUEzQ@mail.gmail.com>
Subject: Re: [PATCH 32/81] fwu-mdata: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jassi Brar <jaswinder.singh@linaro.org>,
 Etienne Carriere <etienne.carriere@linaro.org>
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

On Wed, May 1, 2024 at 8:45=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Etienne Carriere <etienne.carriere@linaro.org>
> ---

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

Thanks
