Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56DAD111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 22:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4803483957;
	Sun, 30 Nov 2025 23:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X218xkIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA368399B; Sun, 30 Nov 2025 23:09:21 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96E083935
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 23:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5959da48139so3450977e87.1
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 14:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764540559; x=1765145359; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak72vqUqWD7TEZGLUkmoCCSls8wg/A8pKt5EEXR/6Eo=;
 b=X218xkIrvxLmNL4N41bfX7Etjnrd8Ru4ZIZey+bkm2o45JJ0Q40uPhnmq+Fh0hbRrn
 stq79/q9Np+ZpRwMI/yxGU4zcRXD5OkG2cYFTPjJXRNLkf7EDI07wTWDde5iGiy5BNrd
 KmSQAjLZSrtP7yUrLhxhGhA3anL6WddctebXlH3pTqKbQUpsMD/aG8Rp5tCdaORpfZrf
 rtzC4lQrypIXJ6eSU2x/b4JTgjX82mkRtU59xCSAcX+EeaTSNXnxmgvfgqvlpfcOhsjd
 wqsJhap0gcU0H/TGhfyQRs4xSLMjomDrxvNsN+0zE0J4KSPVYrw1txpnmYnufR8TVHmm
 fhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764540559; x=1765145359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ak72vqUqWD7TEZGLUkmoCCSls8wg/A8pKt5EEXR/6Eo=;
 b=SUN0TJ6qejI0X6PH2cpxN1CVtFZyk19CdijZ4GdgShG5sX0RSVqzuHXcFQSErgYvBz
 Y3eOo0fuhqFUYLgCtDhGoSw9Ya+MbpDa+l6VHZyfcExe8rYeIC7kXLxMkV+28EO/AyO2
 l7pTAM6BqAX650331T/ZKFJvr+zrzP9JRVJbk+02UYtOmraTtb/BFmXfRSc03SPyGdxT
 oEX6YYLSWbzQzur5LT7UDDkO+1PjBieiPBEWOZbFCziVxCc+uGOTNoRFppWPPn8j/SXK
 DzDhcuerTa+bPbvXa0f9guQx1HMGHLgsu2xsyLQ5Xhz64nq3hagf8IQLxSiYcEJt8tiS
 ZDXg==
X-Gm-Message-State: AOJu0YwS+S2nnW5Fse1gl0FwS7Jw5gSDA8dO1euvG5qhkuSJaRN7R45y
 joM3knwmbeESp5DsDm69gLNiV+fCrIsfqQzWJR9Jm6YbAHauUuUNXUVzc8p2XLebx/vlDescr3x
 DS6vXTm8Ac1wM61tHseXFbMEgzYyjTQ8=
X-Gm-Gg: ASbGncsUHgwlHFAtcZbtqAlQCvifmex6JdR6U/7W9U8ZfedTUQpVnXDUnzt6fHceP63
 V1rniSzQYa0NJ6HiIE3hYheA8EBoW4J81DwhGO0oJxKK7eGTif5SnOBeZMqyB37FnHt1OeYeG0t
 Bzd4g6c8t1/PKBHZPhUIZUAbmeRmPuw/aH2b7hVX5dDvsfVesqfOKLLF7TThDp+5WrsnhPRj1bt
 8KTROKS6FRuKtGTkdXUBpd0vnL5dOmo9IS4yOkHSeA9B26aKXR87LtcGEgLnuU3Yngu0BPGTYs/
 1F8jj9fpQtCepF0vjk3cEyjftlg=
X-Google-Smtp-Source: AGHT+IEOJcVzq3wJFIH6Qt3VxQ+yrDjwFeeidoppkOQjRoH5ZW2FpUGTT6qw4zk+iCsig3Q4kCWlua5+WpZqK+xwdPU=
X-Received: by 2002:a05:6512:3d10:b0:595:831d:2308 with SMTP id
 2adb3069b0e04-596b4e5298amr8623531e87.1.1764540558808; Sun, 30 Nov 2025
 14:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
 <20251130-01-a733-soc-support-v2-6-18bdd4376fad@gentoo.org>
In-Reply-To: <20251130-01-a733-soc-support-v2-6-18bdd4376fad@gentoo.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 30 Nov 2025 19:09:07 -0300
X-Gm-Features: AWmQ_bnHvrE5VvClEN731IF4cEfOYkHQKOOLCbxqUd6JrTcAyOXhC5-bZ7cqewk
Message-ID: <CAOMZO5BG63ndAg7yTdMtBi7nHQjCGcrS9Sr0M5XfAiBkrC-oAA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] gpio: a733: add initial support
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev, 
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
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

On Sun, Nov 30, 2025 at 6:47=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:

> +config SUNXI_NEW2_PINCTRL

This name is not very descriptive.

What about SUNXI_A733_PINCTRL?
