Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA41AC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E827886A3;
	Wed, 29 May 2024 18:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="faWHQ1us";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55EBD8860B; Wed, 29 May 2024 18:30:20 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 260BD88616
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6ab9d3de222so11307836d6.2
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717000217; x=1717605017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y/AlVBapIOMNCXv1Umhqbl8weJJW9pD5wWxCvwWz6Ic=;
 b=faWHQ1usHyrMQyrx6YZ3tPc0wVEXexMGpdJ59KesIpRMAOS98I+yOcDNEy+3rpjvqd
 C73kkqefEeKWDhub7VzWzZkVMXs3fmbUGjTOFXKilR5PC4F+vH4zNm6r9aa+OWCV8pwC
 bJln0hB1VamJsTxq0nFwzqpnUSsuGHN5onnTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000217; x=1717605017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y/AlVBapIOMNCXv1Umhqbl8weJJW9pD5wWxCvwWz6Ic=;
 b=XsCLzNRn3JwN2XW3EcfUv7XnB2jYNM2ruwCshBd2CN8T8AWO8MTr/Hvl5hMmG5zj3H
 mvamBHyNNz3hZ1Bu/ZMMG3RqcXzA9Jk/s/EdpnrpJ8mNLxtJQpOJ1hHpEDuwrtB9cVFY
 5T+gMQc3UmToChjsnvauXWcTnXJznPRetrrwqUCFQOxHcKM4wqoxmZu5tZ44jW9yOkbh
 Ew8JkvYm3qF20Oubvbq4/FeK9DE4N9Bz2XTekBb9mITYtvRbrPFDnGYC6ZVByfYMK6CC
 xQ/I2egsbLKrPjHGBbfi/z7mbgCPmwjxzWk9SJ6pwnIpqsOj9OMkSEKfszRuxE6WYW1U
 e2kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCiqlnJRWdM4Z0vrU4b4yggQsivXmh6tg+d6/U+XABppbmVZGQTnVPs2iXeAin9p6jbezkRrQsaXpN7t2Pz+FrlvSD4Q==
X-Gm-Message-State: AOJu0YzvcpPJcQ2oZaZNmHe7VvtHO0roHVHBSwqrSrSOgxYginYPOqS7
 IY5xnPFbfkuZ74mFX2vg+KM/qfT3tkdEwRCHWKdBCpocD8bWG15i2P0amaH1R6m2gOtgNOwC0S5
 l6ws0PxcGgj/7tcolYz48xIt1o19ZHuvasybeW1meIxU2mYg=
X-Google-Smtp-Source: AGHT+IG3FawvQcQ9n7q6Lz8nGPrkSlN5/IT8qRSBTEjFSgHtqVvtGbYqNAq8FsmrQobRvnDEhpJl0impv7dXjYY0+Gs=
X-Received: by 2002:a05:6214:4382:b0:6ae:9c0:d180 with SMTP id
 6a1803df08f44-6ae09c0d28emr1994636d6.60.1717000216866; Wed, 29 May 2024
 09:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-6-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-6-c26f31057bbe@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 10:30:06 -0600
Message-ID: <CAFLszTgtJi+QE4Ry70jDJbqg3rgTMXEqbt-RROQ1kQwR1Qv-Ag@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] tools: add genguid tool
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

Hi Caleb,

On Wed, 29 May 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a tool that can generate GUIDs that match those generated internally
> by U-Boot for capsule update fw_images.
>
> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
> with the board model, compatible, and fw_image name.
>
> This tool accepts the same inputs and will produce the same GUID as
> U-Boot would at runtime.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  tools/Makefile  |   3 ++
>  tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+)

Where is this tool used? Can you add a man page and test?

Regards,
Simon
