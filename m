Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2D7CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 09:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46261846FD;
	Fri, 29 May 2026 11:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lSoXu1Gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B417846E6; Fri, 29 May 2026 11:57:33 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F13A84704
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so2776578a12.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 02:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780048650; cv=none;
 d=google.com; s=arc-20240605;
 b=EKXNkbMqx9RJ8y3sKyMR2UpCl4kLU1yRmKzDXVrDBH9S9DEA5cSUSIiq7bhk5809Cn
 t44VuR61xJ+MtcVMm1Tpp+iHq8pWNocJFDN+w0WFPFFOpworgpmO1gRv3skR0x87r/6M
 tjOoSzPJHfLPZL8UePGJl6gbh30L9jVT3LaOTEQCmqmAe/BcocQ+dPqM3PuAplndtHTi
 XI5Sy6h6zAp68xiTr0jvT9mqtUw4Ao3b7jNFdiARq0L6cz/w81fV2G1+5CwTF+EUi+2B
 xNF8fH5fZ7y5Hpj+w6fJlYO3L9lMhHbEkLS3VEG70RK47yoNEHSfv5F8utxTDgxqYF6q
 toEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2T59djdf+n6/Q+e4W9dmUak3oEZuPGiia9yJh0zsYu0=;
 fh=Pwed0uR+fUcTESmvhLrbsa6n1RHCX2s8IPfo/JJetiI=;
 b=GQiZpuX0Adc/7DaUnatN52JTS2lPcq+WTrdApqNB5IUINXSBfq90BNnzitYD4VsDug
 HyAmqkWp1UOUOhnRa+nDCXBB51MeV8RVA+SIHa8fgARvEAjLFFb1mLmgEJh2hUKLyJQc
 RXM1arrSmY4NbVmtD6VoQIRtB4eenOfeOvkOnj8O7sPeYj1/GaJyUB9Po2KhjtgAWH6a
 659Syj1ehW36ATGqnsdFGVKTKLcjuQZ1VMEmLGcs8h7FIgQ0Xu/P5nVpz4G8pNvpkSFw
 yJEHp/esjZBxm2ZzaXeFefIfHqD2n2jIdJuGCqElUk7eUkFi3jWqYRNJScMqXpnqhGEe
 7eEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780048650; x=1780653450; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2T59djdf+n6/Q+e4W9dmUak3oEZuPGiia9yJh0zsYu0=;
 b=lSoXu1GwNPu2DOoIYHoD8m1CVn7eG7j5PjyOzT8rgzCd62SQaczcXXVql04LLQifaL
 /ZER6f7QbYcd7I+EixhmtZbvFoGSN8mRk4oiAJoYudoHMT4YqhNaxgsssJLJxFQhIX9u
 zKb1G6WLw6fU4Kwo0jzMyH3a3SHECaHMcIuaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048650; x=1780653450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2T59djdf+n6/Q+e4W9dmUak3oEZuPGiia9yJh0zsYu0=;
 b=EB8ZQMLpqqA2lJJ9KUC1mCnHxP/PW4PKB0yA9ssc/NDQOqrMqSwlsBMoHZSKpR9LyT
 K+H8Y+DGdIFURaruokbFy3yjmP0pMS8iZGRQY22bH0PWkok4dMF/9oEDp9k7tYvtv9Kq
 IT7dfsWV8mIvukce+jT6bIPUfdA843FI/4udUvaF6pLCzTqyTEt7QjFvJ7OY4Zso7pAJ
 RJ04XiKc+A+cPgNcqaPCA7Rds2l9oN4/N6tv79Gf0f4EVDMmrStV6m+IZA3zK3blpq4v
 ytGb2E4fgTrOODtDRUl7WbD3FiowQLyXpdpwszMleLfeCRO9P5VZWCLtJgwDvY4rGSoU
 xujQ==
X-Gm-Message-State: AOJu0YxjsyJPcVL9YBNMKlkWqHuX6Obg9H6MMye/EzXyVqKSGmuT3qSx
 bF2V9J1AQBHruui1GuGfP8x9Jk0pyEBDVx5Q2Qm0hQvlchtDbhQc9iUVhHDAxpCbwTmPfr/r0vT
 suQWtpIsQynG95RgbOsIfEjtI49spb6T6ELmnw3It
X-Gm-Gg: Acq92OH5fqWnGB0gjH/wnLaBTYoruEHHWeXr3qTfIhdzez4axJ7vSPDJmndP33u3UtI
 8yONgzYyHQMY5SNfPEHypn088ESbJLfxeL7m/3FN1BnzKXsYGrREJm8x87Du4k93x0Y13PoMSxl
 3SGi+KF8uV4riy8mylkXIYA+mH9DWtLCArVHhnbe5hKo3Zz0YWn4FPUjNuHRqeWxHKyac7jllM0
 kzpznj7vn3kWUiEIxjkb3sQSETyrH8TriVrS8ja8CuceP/AjYL8tNa2lIrrhv7aZjqVBljPCCDi
 +cLXz5LYkwe1PIAvYJ4=
X-Received: by 2002:a17:906:6a24:b0:bdd:90b8:e397 with SMTP id
 a640c23a62f3a-be9c8c68d2emr112777866b.4.1780048650336; Fri, 29 May 2026
 02:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-6-dmukhin@ford.com>
In-Reply-To: <20260529034441.2075305-6-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 04:57:12 -0500
X-Gm-Features: AVHnY4Jn6XRtZA06VkM-8vPy5LBSUIR1vZ2Peq51mGdYBXxa9aooYn6Psi8vX8M
Message-ID: <CAFLszTibnWUct2g2fhbdrVg+aLbo5H5TMC44sE_BEZpOOQ-VKw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drivers: nvme: Export nvme_shutdown()
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, sjg@chromium.org, 
 trini@konsulko.com
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

On 2026-05-29T03:44:35, None <dmukhin@ford.com> wrote:
> drivers: nvme: Export nvme_shutdown()
>
> Make nvme_shutdown() public so that it can be re-used in
> board-specific board_quiesce_devices() before OS hand-off.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/nvme/nvme.h |  7 -------
>  include/nvme.h      | 11 +++++++++++
>  2 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
