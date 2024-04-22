Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76C7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 11:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3839E8876E;
	Mon, 22 Apr 2024 13:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h7NSnaX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DCEB8876E; Mon, 22 Apr 2024 13:18:00 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B4D88793
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 13:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ab48c14334so628789a91.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713784675; x=1714389475; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMegAQe6ZD88OtisZ2QzJozLhln7ADEiYM/ORfhMpao=;
 b=h7NSnaX6UvwpkNLsA4CyzUFoNI8wwW0d9T/IXl29pZrZwHMakLwBLMffY5pcgPYEE/
 r3lvZ8dCiWlPIIXjWxloAg1RECuVoEGsLbz47I41dM61+6LIvOuD8RV3tbluSefpuPEU
 A9VkXUg9W1FbqF//cN7XDjogGAGYcmiX72IuQzpXXKNGxmTxEuc/+j9Ag9dH4/OeZ6oG
 YK2gxBZeM82+c4up+hZcEbUSz1kTvufDnnSW/+iqzCq0emhRmXJGVIGqKQl19SV4V03e
 E6XQQdWRmspweBlECyJFfA4O5DrAy4OFKnPuyIM3uneaM3BMTZf6Ov05DB0cl9uFNvBu
 hjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713784675; x=1714389475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMegAQe6ZD88OtisZ2QzJozLhln7ADEiYM/ORfhMpao=;
 b=A7XNG9usuJsSVKnorxd15Wl49vOo71llhd3OVSQfP7JR2PGqILAV/hsTH+8RznQ1yL
 29xe/GpZH8/1EzHEkMVmB/iwtfySkdb1Qx2NN8EZNNoWjMqBw2+efI1mEKbgeUzjAtot
 1eTmyFf53suges8LGzxGBH1v3UxICrExVk3SWbP+EPslcfhS6D51OevPR+gYEzBdIVNQ
 ruHZawi3cuqrI6uf8JPVN1pmlkv8DUmVxTHJ9bsLxAcQ49INrmZEl5HIGAcTPR0i2FQk
 hgHlmGdQQ368THD84qaTg7Bck4zcoB+YAJ4srbKGU6OtoaoLC3uirKOBQ0ZfQmr1DGyE
 K+JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWKUwat+Ima1YHZMbePKWoU0zPrMStjFgRUnORO9MZvYq4elCtMIQCx/HB/GA4od/MpPVrXXG/62kGtxkVZxJ47cnXXA==
X-Gm-Message-State: AOJu0YzNSJYEaxaoiSPIoHw3lsOxJJniCi2V7r35qP2/87NZ5oT4oQrs
 YO7mW8Dltf/l/qNxhYSt+zsJxKbTThj0S6gJA/246ZIPUunBnSqn/oGJOyCl74DNhc9HMs2Tcsy
 4MQrZfD5U5OZuXXtTAtW9L61b4SP7Yg==
X-Google-Smtp-Source: AGHT+IFq/AuQPNUiCLJX8bGJLk1HPnNwkk4nhzQPvHp0XGEncKJBQeM6Z82J+zLOf/mWy8FAg0F7jpte9CBFU8p+3SE=
X-Received: by 2002:a17:90a:d302:b0:2ac:3c42:57ed with SMTP id
 p2-20020a17090ad30200b002ac3c4257edmr9438281pju.1.1713784675194; Mon, 22 Apr
 2024 04:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240421140745.25870-1-michael@amarulasolutions.com>
 <CAOMZO5DbWbsT==bTczp9b4uHuBR6dPsbsHEfoJTugTp4zwTJjg@mail.gmail.com>
 <CAOf5uwnruzdTfsbMqvU9UEnsL0Y5_xWs8tCsGHCTPAbHbxb=rg@mail.gmail.com>
 <CAOf5uwmGtY--s9CNUPVeLYghw=O6+DCpaPUJoBrJnWKkXR7CoA@mail.gmail.com>
In-Reply-To: <CAOf5uwmGtY--s9CNUPVeLYghw=O6+DCpaPUJoBrJnWKkXR7CoA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Apr 2024 08:17:45 -0300
Message-ID: <CAOMZO5A_j993PXvBMK3CZvOC+A6CLsyO__gihEfGZcwoFAHdGg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mn: add video clocks support
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

Hi Michael,

On Mon, Apr 22, 2024 at 7:36=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> Are you considering if I wrap properly with VIDEO IS_ENABLED?

I prefer you resend this patch as part of a complete series that adds
panel support to an imx8mn board target.

Otherwise, if this gets in as-is, it will become a dead code, which we
want to avoid.
