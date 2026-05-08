Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A6ACD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00D784D5B;
	Fri,  8 May 2026 18:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kq1fDelt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9BEE84D93; Fri,  8 May 2026 18:41:01 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED15084D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso3494108a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778258459; cv=none;
 d=google.com; s=arc-20240605;
 b=ZhN00TO+mOlAVVAl1psrkOra+/EZa1jP48lRhqRQlIdiT7DkIfmJoPTV/8MddKDCdw
 om8wLp6NP/wkCJ+XNeudc8V7LrfWZfTqHQW4+qgRvlUyM4m275VhMchtG5TIOfvn8wcA
 sf6FS2J/pWTZcB74SmmLbsLJcKbE81XGKI6Tr8L/O2t8ybycOMzh1uexx/UH0MifA4MT
 psHzFJDFksjay+BlJaakGIgtYtSTIbdUpL0foLdAjLY/0jl4ydugnuDknPNchO+tN5Nl
 0WOYj6S4fBvOsKxFK4d7fMdZ5d9ZtZWmT/AG+yAFzCaw9wGUxRBl7q9SdJ9t1Of1p0Xj
 mZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BdmdzIbTnwOb5bw2vAAlqEf80YIBzhesThqJ34gSZtM=;
 fh=YVGh+cwB/Iw4GI91mdqkW9HvoqcwPi52SADCrka08X8=;
 b=JYIoPwkSpwvGl8ZvmOoA2OpxxmMoEWshIZVL9AbK7k0hJ5aA34iiI+UZUzC9xE9I8a
 MvhHdwh7RUhzMEt3Kq98OpvPgDlBJH+FFgN1UVDVT+NCpAfyr/Up6fPTzPRLX+rSseis
 8tGwLWSD7P6lGIpLy1wIdDnQuscnCOyRxgbhMOxYcSTnheZVk6q8Y0RZro0VlnxDohoZ
 gB2Vl9bVKFENcQf0ei1AzewHhyREG4J9eExvg/Zxb5744l/haGq/SaNB9nuzTWRLV2Tg
 MS+N2CjDymDYBauuLhYOzd2t3YiJ71MzGhf16S3+2oL7/LdcWGN8qstVyOwFZ7fCZQYP
 IRfA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778258459; x=1778863259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BdmdzIbTnwOb5bw2vAAlqEf80YIBzhesThqJ34gSZtM=;
 b=kq1fDeltYEH2OObB3ur++fb9Vlz/VyyjG/1HcbMcCylEHF2HPsUpeGTm2u5Bdd6uz/
 uusX0JEC5ZzlnGw1ZMriyg4xRdDPFDLunJYqYg8jmWSrKkPuFy8IeSyO3900Hmo+GYje
 +Qq/zWCkKDOCu/bnPHaxtHzLMu1zCV1rth0zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258459; x=1778863259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdmdzIbTnwOb5bw2vAAlqEf80YIBzhesThqJ34gSZtM=;
 b=Q2d8mIEvaFGoSAHYfTlwYo08WO2+USTl+nK1+QRgwJKVaue29eUEVNlBpAhO9Na6xa
 XcolVNKAfh059HBKnm9CVkX0lnDJ5HBfujBWp1S4ecRBoeuTiZKpzEH6wFiuAH/tassq
 5dzBhQdX20kHlnEawX72IACxAgUmSxztKJ8HNwRhXRg4pE7S8ETiwIYuu9cachZ5wsBD
 H5jPgRNZyIY5rN5AeJWcqfhWSpPINqTgphuTUcSuPYkJS2aefA+LRvpvHvh9Fs2nHrv7
 43zgKcJrOwIP/5Rq7geGZhIDAfGp59vDYmNrqDPk8sXZjLHR0FYqtt4oc+wptlne8rpN
 9wUA==
X-Gm-Message-State: AOJu0YzQAWmZgWG6ZwaLHDjjqYjez+sMm5Xxjocln/nLbN5C8HJQWI/+
 8e+PfDuDYl0VOXyLvnRC4kZv2ABEjnbfllXz/dun69PAWZsugI2SuakKG4BqlecAyTmeYN//dV7
 Xgur4xup7SQiSVGV2fNejlCoOBS/MWJVD+XH1tM9R
X-Gm-Gg: Acq92OFHdC4fZ7WMFFL9fxrnkhYGAyK8N7HLBaKnj4s9TlEYPYMbw43S2KuygWvxjO/
 3927EaaiABqFsRfNSHWzXng36SsfpZ2KkLtG0xxTOn93ANsuFoQR0ROyluBKEk89jDouwnOlrAX
 TgEOBW20ZpFjkpdjjsuEg2DWYqv4Za9TQ6GvijM3m98vbQYV4Z4F8ZZqkjnkKEWvKHhCjtkE5Sf
 7eVEBSijNytnggLLSEa9Zdq0nGyoSbVd4quv6zuP6qL/8K2UX8zorJraiOjAQq6eeTYH06LLI/B
 cmsk90JzjmQTAsZm
X-Received: by 2002:a17:907:3c83:b0:bc3:c753:b03b with SMTP id
 a640c23a62f3a-bc56ae2a7damr817071866b.3.1778258459334; Fri, 08 May 2026
 09:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260507220757.209233-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220757.209233-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:40:46 -0600
X-Gm-Features: AVHnY4KywcWZ1n45Xz6no1VJQtwENlAeBspgbvaTxyq5cCppxX_4Up_uvr79hkk
Message-ID: <CAFLszTihYSzHXrPVekbvoW2ALkTKNF4xqT0A0rT_roMdUh4Mhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: bootstd: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On 2026-05-07T22:07:48, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> mmc: bootstd: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/mmc/mmc_bootdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
