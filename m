Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566B0CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B921083642;
	Sun,  2 Nov 2025 20:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fYausrtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF14E8389A; Sun,  2 Nov 2025 20:53:56 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9592830A0
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b4aed12cea3so697767166b.1
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113234; x=1762718034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zKC9/sDWGRbDZFwiXnEnXWub05R3zyJyMlHLPeK+WXc=;
 b=fYausrtA3cpKRQBS4DYpID01tOtxt84Xd8bXnF+CqrMojWfUYp9K3kK+WcCDKwe4rh
 Pwtr3PcHUC3a/zC8K+YXJ31b8ArDyzYBM4WLqnW6vzMzq55CXvgyo9Yq4Xkf4TIWldys
 FNw3YoBJUy6SgCxk4PH5C27BteAgD6XTYb7G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113234; x=1762718034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zKC9/sDWGRbDZFwiXnEnXWub05R3zyJyMlHLPeK+WXc=;
 b=a4Mvg8F8Ef/srbFoLRNMfo2Q/f8kaPBO3f9Y6t6iIipeV3NQaMSMxyNroH910/II9m
 Y8d5M353yMKkrBRZDK7ZRZP44uVqMtX27gLxrAoaX4HfhBaOYtuYTyPLMO+Ina3bN55/
 ly6bF+zbyNAfxXRNKWJu9K5qdsqLp3PjiLJ1lGG8FaUClMYj6eFpKu0uxVtaUXZVLYoa
 OJd8a031eVA5GTW8bkD4TOcGMU/WsekSHrGSs/6ycgx1afihQp9yTmhL5d5aR94SNGcJ
 X00xu0V2X3UNWpgkrq2TvsCQCcwwZGDCtaHIFyTM+SytY+TodLqIrMRcOL8dliTgZzg9
 94eQ==
X-Gm-Message-State: AOJu0YyFu4sbhJ6v4FLhFMoPJbJp8be6xb/3pcRFFJ2uwICDJh6dyI2y
 Do/eumrDcmKrZrX63pEYcGPdJKv2NPvtLqvC6D9wp7+Z0acASqWm/iUh4aMVam9Kik68+nioAtB
 ymRx1fTRt3zHbSNlnpgI43iiqSch1+Gr8iEEgxbw8
X-Gm-Gg: ASbGncv8q3itCYNxu7RU/GiSKanV3GgF7KKpsmHc50BQ9nLjvvNnVskhiVx8q0laNiy
 mKMBUq1mFpOckH3s2JYjDj+7ljs8Yzrs0A1E5zaEYwu0Njde8tfj/kcslgMQBbQpmf2c1xXanca
 kjC2JcEQBG8ID4xASDa61fN7Eo95mLb71fYkPQs3U3Q6QBXtXsNX6Z4q0ABrIBdZepDgWvnJQoP
 6x6ipc1ih5pOjbHlEUtChke6FiUEmSA16zCx173kVR1Mpbej1mHqZyFl4K2NE+u+N4o6+4X
X-Google-Smtp-Source: AGHT+IGo++57DszUpLZ1H1EbbALoyb3406c1lFFsL5BOlEUJv8bO2aLIWeOlo5bodhWnQEQmkeJfkJkYEeYbWz6AYRk=
X-Received: by 2002:a17:907:807:b0:b6d:6ae2:b85 with SMTP id
 a640c23a62f3a-b707013ee16mr1175372266b.20.1762113234112; Sun, 02 Nov 2025
 11:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
 <20251031-rsa-pss-always-v2-2-a29184ea064d@cherry.de>
In-Reply-To: <20251031-rsa-pss-always-v2-2-a29184ea064d@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:53:35 +0100
X-Gm-Features: AWmQ_bnjcYe9JUKRmJ4b48JdJMKwDsFTH-8TC-ZHxq5xtzP2SzWsQXB8W_k_sEk
Message-ID: <CAFLszThQ5Er9LvvL9=kwPdHHjk5+1FMaReuBMSHpaT+_KDJPBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] boot: remove duplicate config entry for VPL_FIT
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Alexander Graf <agraf@csgraf.de>, 
 Loic Poulain <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 31 Oct 2025 at 18:08, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> It's defined a bit later in the same file, so let's remove the
> duplicated entry.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  boot/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
