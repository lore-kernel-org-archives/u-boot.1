Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E286FEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43AB86FFB;
	Sun, 20 Aug 2023 23:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KPMvjoRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D6586B7E; Sun, 20 Aug 2023 23:57:42 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6155386B86
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5298e43bb67so4431456a12.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568660; x=1693173460;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FLJ6SypCjBbxjOYeS0v56/5W50z+rlSpkUtmj2eBDA0=;
 b=KPMvjoRax8OyepgHYpe3MBlfv1KU2L6qTCI6dp1AxEEmki3n8gps/qGxguprZZohwW
 rZajRp60v5/N2+LiIqFmrYniXWu7AfDUWQuzxmTvlQho7FDjcX2jyT5udLlIQexprtZN
 gTbjCQX5dhFNUTYepkqMLpC4+kAU5xCcqgkjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568660; x=1693173460;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FLJ6SypCjBbxjOYeS0v56/5W50z+rlSpkUtmj2eBDA0=;
 b=kyS4dSiR/Ue+xQzcD2H2DKp21Oc+n43vvTE8wWaGnAq4mcHIdToyvQsTws9+T72qT5
 DuPJOS6Q+FDXX2N2qzO3YEUGXMoTvQnRMJ31/I1f1EkV7aK0CcTJ6zq9P5qdXvop/c0V
 XwPa6nKy6LpaJmGtOh9NnayrOaQ7eFywcizcbs0aN72a9u9Cfe/ukqjNIt4JoLgIRx9I
 WQ+cFp3POllHgYKU6SsZeps7pVQ7IUmoY4si5ZQld4K6ohm19c3U1QXJiY3iOzssdTGS
 ezpY/YH6BkOOf7KaY7bmVuMTtHCMn+Up0x/aj//4fW6JdyVZKp/XPNupTzc6BYGOrcVb
 UJzA==
X-Gm-Message-State: AOJu0YzXeKY7GUH4FjqywO1DyXpRxjStD5ivN1Mmw7iSMnEAlNocL9um
 mwzewNUekeBaAetZ2CV6RB177caikUB7wJxgn7pHxA==
X-Google-Smtp-Source: AGHT+IForRosdwb1J1norfPQCPeAi+G8eSHS8/AwnYUBlzEFf+Yq/RwM5jwoqxE7Yq8CqVpazCYgHciC6vs9fjR4SOc=
X-Received: by 2002:a05:6402:26c2:b0:522:ddeb:cdcb with SMTP id
 x2-20020a05640226c200b00522ddebcdcbmr5927832edd.18.1692568659962; Sun, 20 Aug
 2023 14:57:39 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0LQD1HvWFY5xFvkX-1Bq0kddNNGK5f_YbH_8yvdLLJXw@mail.gmail.com>
References: <CAPnjgZ0LQD1HvWFY5xFvkX-1Bq0kddNNGK5f_YbH_8yvdLLJXw@mail.gmail.com>
 <20230813025701.417028-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:39 -0700
X-Google-Sender-Auth: wdFytU4j-JqFxKbTpJvkjA-ISSM
Message-ID: <CAPnjgZ3CC=Kks+iQ_HYx1N-OtAox4xUtMi10NB_0=mK7ah_bdg@mail.gmail.com>
Subject: Re: [PATCH] configs: sandbox64: Enable MC34708 driver
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 12 Aug 2023 at 20:57, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> MC34708 PMIC driver. This fixes ut_dm_dm_test_power_pmic_mc34708_get test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
