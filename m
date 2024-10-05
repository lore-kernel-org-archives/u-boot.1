Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14FACFB421
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4885A88CC9;
	Sat,  5 Oct 2024 18:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d5kCGWME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116E488D03; Sat,  5 Oct 2024 18:50:56 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F66E88CC1
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53991d05416so3677583e87.2
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728147053; x=1728751853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=je3Kkt98H6xwXiXWHt5Y+N9Pxkx4x8fbfugAojXA8RQ=;
 b=d5kCGWME8wx+cpDhBaIl9LZGhfQNoDg0Qi+lpqjtJGmF7dMMmSsEmBnhsMAn+YURmK
 c5DJ8J6w6MxUROL6BRp2kUYHo+/m2mkb4ZfFdh0+q7FR7kVKFMZDYFDcYMZDMhVD5XeI
 R84pA0gMLH65ImodBoPihzM5GBKsja6VINW2OW9jKq3i4hzuHPnRg7yDMfLaY0R3iyyd
 ZaxAzEHhTfV4ok7EdXl8+qfQ7OjjH9CGAaQCnGGbTx/bjdL2NIfIxNgtFjGTvz4Rl5Ky
 HMom+EG3wBPpUkPmnW2EJ1QHe5mwiqzBiG+vTJAm26A6IV97zLbxC/uYcb0C1tGKdxQQ
 FC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728147053; x=1728751853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=je3Kkt98H6xwXiXWHt5Y+N9Pxkx4x8fbfugAojXA8RQ=;
 b=DQXyFHSXE9+WyMtveRoBHuGjo3TrZCv0QE8QPR4g4Sq461W5ogCaV9nFe0Fr/76TSh
 2Z1U1KPJ2vsp7VbqZn1QCTF1d4d19pJuvWGNfCVdJZ5IegWF8Gnw+dOHyU+g3JhFubo3
 TLBkazuyrNhX+6/QM3W0tcLPtvTwgIxnaY15k5aUgLahCrcqZwDuQVFpFVNQXXoTf23q
 F/MR0qHsGnVmiLrdtiE5cNrbpWNFMbmrzmZkWQJWMlV8XmOZoxn/OXl6red/KQ7Qsmc6
 +QvX5NM6ENajWDZmTR5GeJpSk/orhwTETpEReYFna7FJd1qzxr8QMjODhBVQQ67yRcRl
 2VCQ==
X-Gm-Message-State: AOJu0Yz2v81naM7Z2rnOvvNVTrzFGm7WxMRF1Hdq4JMw3+Lnh4M1cArs
 uDbjZWg+fwLQo+FWMluHsdMtiE8obJd0D3wN9dTLiFm24QRgf020/sj2uVe3BV52mECChLqAv2e
 4dHoplhUDW9XKjBudWRbxoB3qUxY9dRJ5
X-Google-Smtp-Source: AGHT+IEGL6Yc3+xdal9Wg+Fi7bsZ62qA3d9j6U+J3lCKizZbJHjA9P7p/An0AFIgK4Z0nPTQdIRJNzCBxEkjcbQNYec=
X-Received: by 2002:a05:6512:138d:b0:533:4497:9f29 with SMTP id
 2adb3069b0e04-539ab87dd29mr4585246e87.31.1728147053251; Sat, 05 Oct 2024
 09:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241004125450.1923873-1-festevam@gmail.com>
In-Reply-To: <20241004125450.1923873-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Oct 2024 13:50:42 -0300
Message-ID: <CAOMZO5AMH-26eA8ReR7Pw3fipM1rKX1t9Y7vvgdmdB+HrPYHkg@mail.gmail.com>
Subject: Re: [PATCH] lxr2: Add DA9063 watchdog support
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Oct 4, 2024 at 9:54=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The LXR2 board has a DA9063 that can provide watchdog functionality.
>
> The DA9063 watchdog can cause a full POR reset, which is preferred
> over the built-in i.MX6 watchdog.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx/next, thanks.
