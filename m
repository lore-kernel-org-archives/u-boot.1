Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8266C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDB98871B;
	Tue, 11 Jun 2024 20:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NwAV+Yb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99FE88744; Tue, 11 Jun 2024 20:52:14 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A178588701
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b07e641535so7356366d6.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131931; x=1718736731; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aTG301L0/ryYByZcaBQjnqcyymvuv7xfSfMo2yRdG8Q=;
 b=NwAV+Yb95PQx3YUV9186WjPZAKi3ue6VsqEgHI+YjJTJCalPu4ZbC45s2gxNyI6YYT
 7BRI5OciKup2NP/BZ6ZrdN/P6FVS8FgOikENOeAKoVhsmK0usnXUIrScGcWXCM4DXhk6
 q3RKjjuWDQiQYl9AGQ+FRfQjKj44C3RAbTgeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131931; x=1718736731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aTG301L0/ryYByZcaBQjnqcyymvuv7xfSfMo2yRdG8Q=;
 b=rq7MpvniVJ4kk8KqYH/+pDz4D5vEtL57+W1GDzeVZ/XQJ4sLWaK5JVjg+/OaX4kZik
 qoDi2Bc59bT4TlPeTzkYrXOjIKQmen1kbtVR/PARXRujFZVkV3jxqpdGdDtzidU9s12o
 DJZ7C4VMezNF1K/GQ5tj6zvzeFSisy2RBRTXd7nzbRXCNLvTVdc5J5OJPwzO6GFG07LI
 iSzHvu/3QgHTccSfv/dsWlMDTPfVGdhsH7Kr/iPr73IdWBHmrwPHm/qTbE6wHCUl4jKf
 8K+uhlXW/fd0OqhNuiZOYv+vU8xW2Ct01PZmr3DqhE0cIhcwLkcN8nz4atzLYWQ2gC31
 eMOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpPgdaqmadIefQrJc1uTlJk/PEy0zAsyA+5pM2WD1VoPj4RdUGhlyTTe+7vC4dK+h8SjSDqhv/Yvh41dsYKfFJMRVsWg==
X-Gm-Message-State: AOJu0YxMe+XYFFoqnxRCHo6eq7BrmCiPUmwQXbDn/+R3wWAInDQW4b0a
 R+B/uGRFhuBISR2NwkQ4RcIr6LgNBj17HPgUtoyKSs9aUCONjgnfNQ2iG7wIuPCnbBVbtTQsPCa
 gHa9a7X1VZSuJYTDjgckOoc4HGSQF6bCN+ULq
X-Google-Smtp-Source: AGHT+IF78uMzSLFl+EGkL16SYoN2d4lmnODhLa1r9dio8Y08mmMXW5YLnXxELovt7YlsknNoNbokf4AMnG3tj8LPf+k=
X-Received: by 2002:a05:6214:4598:b0:6b0:6512:94e3 with SMTP id
 6a1803df08f44-6b065129607mr122338806d6.62.1718131931635; Tue, 11 Jun 2024
 11:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-4-028e82b0b620@cherry.de>
In-Reply-To: <20240611-misc-20240610-v2-4-028e82b0b620@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:00 -0600
Message-ID: <CAFLszTh1jGdZoZ0-MVUN7PF8w74nDK9gQBy3PwY+Cy4x9666zg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dm: core: fix typo in SPL_DM_WARN prompt text
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Tue, 11 Jun 2024 at 07:04, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> It should read "in SPL" and not "wuth SPL".
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

It might be my accent

Reviewed-by: Simon Glass <sjg@chromium.org>
