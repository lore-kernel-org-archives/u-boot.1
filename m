Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB987C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 06:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302B6801FB;
	Wed, 22 Jan 2025 07:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TMvjD6z5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6B880283; Wed, 22 Jan 2025 07:20:47 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA24801F5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 07:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4b60c221587so3609450137.3
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 22:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737526844; x=1738131644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N0y5rTPIweGann6oq8+gN36Tmp4hLahaeOE41Olhbu4=;
 b=TMvjD6z5po/x135N+oEyheFlntol/sF3DWsoQ4yGnpPhk2+bl8g6sIMjcgjXjb+1Jw
 vUUDJh2UD/mvvKuZBdEQ/0zzF1OwDCgl9ef6StN2xMTJb0gygihcCs9fJ/7BxTU8uJqU
 t6LWdowAIwmXrfBdJXPzzcEZW22nxNqpFoUsDOCVvG4vriApgA0JAW7sEYTh7t7s/+7g
 m+JHIETfCTj4HWh9NRimJnKjPxFG3UWKoiiQjOV2qWrwQ/LV7Mv3PS2LExjRbWYdgAHs
 mDrwEJUXBZlRUVKcqmWUz6h70n8UfagZQVcX6ZFogUBj5kEgBfOnUZGITkojccmaJumb
 RfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737526844; x=1738131644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N0y5rTPIweGann6oq8+gN36Tmp4hLahaeOE41Olhbu4=;
 b=ZiS4IuPYJcXFgn0Yc8JrfGZSgf7wSdRKTnw34hcc/tlasP4MhQK/WS4xixkSY4uWvc
 DgYaIm7EL+H01tgPzfY8PrR4HR+l0ZCftZ7lnr/E4yU7uwCSLAdNQZFTQ565IZoF3zOs
 8YfBAbOpwZmqB2ivk7YAweB5mvRa5AtK6R3iyvfRP0pU1yDHPPelv2DvGl3o4htKYc2V
 kb0j2lSWJHgzaxWaglW6wFKtg3guM6xxkaz7wVIXtABsB/u1092MelUcrS2gDQu/gq56
 E5tzLxTzoVN/spUYHJpKM6aXKQ+efMPSdD68gPlJMjn8Hkqf4TO8YuzeXgHmRMnPgNUE
 Xayg==
X-Gm-Message-State: AOJu0YyXCkO4vvRfc0c8WmQyqTlDqhsJ0qRrVrQYvryB7/tH7VB3qvC/
 T+3JafUkx29VDHPkbWf/le1zdMFB90PPwAbmTeXRkKrsSuAP9KthPkfPf9Lp16FRB7soIjmDALk
 oz3eAzz6WH9pritl8ost0l4Slx730dyWTTMs5+A==
X-Gm-Gg: ASbGncuPX66KnNYSwMNK79eH2xhOd/zPG2VBePVFfMRxgFofL8SXTxGw6PKPqxEcXtZ
 wO4RiXYakWnaB3C4s48Vvn+nhq4iOBIbiN31zLhU22V9fETgRslLCtw==
X-Google-Smtp-Source: AGHT+IGuBPZgRPp1D3nhedpEJ+seND1LTip07KKc3umKUovX44+1TS0FQNVMAO66mPMtnwzplrjZK+uGEPqB1vamZfg=
X-Received: by 2002:a05:6102:d86:b0:4b1:1b67:6a5c with SMTP id
 ada2fe7eead31-4b690c77495mr15728123137.18.1737526844294; Tue, 21 Jan 2025
 22:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20250121203147.4133618-1-trini@konsulko.com>
In-Reply-To: <20250121203147.4133618-1-trini@konsulko.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 22 Jan 2025 11:50:33 +0530
X-Gm-Features: AWEUYZkflzPz44vyXcXgSBu-GqKDVkI5YLQ-xuV2dLI26OqV7af_mUWc9sLhe-A
Message-ID: <CAFA6WYNNMvYNEdPRhaUWasgmS-74U3-sssoq8NYqON-t81NTLQ@mail.gmail.com>
Subject: Re: [PATCH] Squashed 'dts/upstream/' changes from
 9b6ba2666d63..8531b4b4988c
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, u-boot-qcom@groups.io, 
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
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

Hi Tom,

On Wed, 22 Jan 2025 at 02:01, Tom Rini <trini@konsulko.com> wrote:
>
> 8531b4b4988c Merge tag 'v6.13-rc7-dts-raw'
> [snip]
> git-subtree-dir: dts/upstream
> git-subtree-split: 8531b4b4988c2c9bddc90ea74f2d3e2dca9d5056
> ---
> This will bring us to the v6.13-dts tag of the devicetree-rebasing tree
> and so match v6.13 release. Changes and changelog omitted due to size,
> and everyone who is listed as a maintainer of a platform with
> OF_UPSTREAM enabled has been bcc'd, while other lists were cc'd to avoid
> being marked as spam, hopefully.
>

Glad to see DT subtree resync, it has been smooth up-revs then what I
had expected initially when we introduced it.

-Sumit

> --
> Tom
