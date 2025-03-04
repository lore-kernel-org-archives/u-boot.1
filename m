Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B317C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC178142D;
	Tue,  4 Mar 2025 16:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YBVuvz4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA59801CF; Tue,  4 Mar 2025 16:37:20 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6E2817D8
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390ec449556so4659144f8f.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102638; x=1741707438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jA4t9mH6dXJHnyXLxRXzIAfrw8+iLGelefO6s0A4ypE=;
 b=YBVuvz4gH4PaFgQvn+XufnARdHqCJu931ihxmpkOxR7Q3vazN8tMiDnWc68414/Spb
 67b00zdhdb56hfiCCZkyRhNsdu6SXcCZ3+asvFhl1owmSq5LnpVHERWqdSxWFsm6NkSU
 xsH6gKBAwPdMa1QCMRTnxSpBnzJea7GL4Lwvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102638; x=1741707438;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jA4t9mH6dXJHnyXLxRXzIAfrw8+iLGelefO6s0A4ypE=;
 b=lNyOgxTUtjS1VcgYvuoEeCHYguOKnzI+Q8k3Ys+MArP4nO2YUjol+eDBMfy0Hy85Y6
 ClrOSPGbgZrFujMTW8SzsfTWJiKCqQ2X8nWR0MW68D3hMg6xig+a46tpNB1UdiSKJG7w
 bLvFG4zKqxWp/1gQUOJOb75H4zBBt9Ll+XJrcu7TSzcMvCb2FOABgUvnqHNCeGZRu5lk
 BUrx4SN6Tf4NgOO6DFwKMOEwsKGZ3h5qLNUaWzVQDY9RzGvi0Ypf6mm3tmZGgVkczZ7n
 vkh3KRk+cwpzEGHp8gqE6eHZxU9cABHbD4jlB0H/EHnd26cTw5qEH9zIJ7XoGEQla1u8
 IBHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTZKGiVofm0R+TFxAYRrf3hPnYzwkkH5Twvk9woiu40383zBAhzhr9k4JRFahmbG6pNsAiTU0=@lists.denx.de
X-Gm-Message-State: AOJu0YxM1PQooEhnrxWkhFD7m7KS1cLPCqZTKuYnsslBx1BK2FXZP2HR
 dugqLI0OwWb4ecBj9U0+s/GcTBj643MvLJU5HBVcSOAouaeaBxpuzCFpk71rgI6d97UiHAlGWb/
 0p5X9p7xGF1v5P8cYmz+u3AtwXySpVbFA1Cjb
X-Gm-Gg: ASbGncs4lveq8n/UiOj7TjYAKSIaEfgwcaiAoM4ZjuOJXLds4LgPpJCFCAnYhJXPobQ
 Uj9uaK2yYspYu0ueMcU5aAdJxywjnLjA+KNTkD1YvjSyjuEF/uugIT3sSevC4aDQSIzy4RKvWzZ
 edwtqhSjQqR2ClbDAM+J1pnEqqTY4=
X-Google-Smtp-Source: AGHT+IHhs4K4/KIthNoq2mFmm00R6d8LmRQ4fcV+YDPmN9h3p0eqwUnKgKbpQPNF0FS9hd/uoKZmWcUqWBE8LKgv2lM=
X-Received: by 2002:a5d:60c2:0:b0:38f:3245:21fc with SMTP id
 ffacd0b85a97d-390eca257e4mr14394422f8f.50.1741102638207; Tue, 04 Mar 2025
 07:37:18 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 10:37:16 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 10:37:16 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241018030027.842749-2-sjg@chromium.org>
References: <20241018030027.842749-2-sjg@chromium.org>
 <20241018030027.842749-1-sjg@chromium.org>
Date: Tue, 4 Mar 2025 10:37:16 -0500
X-Google-Sender-Auth: yganrTnaZbGb7HIRvDEzciqAD68
X-Gm-Features: AQ5f1Jr8z9pmSQvqJ3v2NeOatGbcKlFlvac_XNINgjlEW6AypE8RmcSRlZ5ayhs
Message-ID: <CAFLszTjeTPqiPQvw-EJb1umZajVrip9vvOTX1qgO57OBy8jy=Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] membuff: Rename functions to have membuf_ prefix
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Ion Agorria <ion@agorria.com>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

The double 'f' is not necessary and is a bit annoying as elsewhere in
U-Boot we use 'buf'. Rename all the functions before it is used more
widely.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_extlinux.c        |  6 +--
 common/console.c                | 32 ++++++-------
 drivers/serial/sandbox.c        | 10 ++--
 drivers/usb/emul/sandbox_keyb.c |  6 +--
 include/membuff.h               | 82 ++++++++++++++++-----------------
 lib/membuff.c                   | 66 +++++++++++++-------------
 6 files changed, 101 insertions(+), 101 deletions(-)

Applied to sjg/master, thanks!
