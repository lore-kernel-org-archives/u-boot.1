Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686FAC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 15:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF651809A5;
	Thu,  1 May 2025 17:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NjQ0lXTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B6D180EFB; Thu,  1 May 2025 17:05:03 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3CF48081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 17:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5f6fb95f431so3931025a12.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746111897; x=1746716697; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7LUiJUJYS8MOYLjX+ZRmze2uTeLl3r1XDRz4vh/gBUQ=;
 b=NjQ0lXTYnSLcY/StneV3w3LBuK/kHZ8WsuC8udjw0EaFI31ZTDqbXlnXtrPZNFFkCh
 g0CGX5MnDpWmysy4+HeEu0pKvCPKfFeoKi9qtwVRJNAPMZN0Fyy/FE3hiSil4aU411gw
 FHVFcE/D8ehIvElb+tKZJMnO5hkmxiQ9TpelA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111897; x=1746716697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7LUiJUJYS8MOYLjX+ZRmze2uTeLl3r1XDRz4vh/gBUQ=;
 b=VtZ+cYsucfuvyiI/YQS5fu7Iaj3N/t3qbzAy5q+sYeQLpzwHqzmPGpfC4ITaZQd4NZ
 FAzC+4gFym9hvydvlocZ+XVXEbZYGZDwQNgo900ETLnB1GZSoBgaE5zDFiTQ6NcsCll3
 Mj1IQF/uMhm31Y0cs7R6/yBD1Nlc9hNWwtH8uD0qpwut71I4QiItarLemWp0fGWVvNLz
 DiJmZMxGRqD8CqJl82q19i6cRqQqWQFkXDwO8La8D4meOOUyvQtx5dA5n0JkUa3CCZWF
 EhacpG2yH649NvHsJcpdK0mWqo/N6I8FS0rvPjyqJTyrwBydEzS3HVMoTvWFX3t3rqA3
 d3mw==
X-Gm-Message-State: AOJu0YxgpGRlVtxwRh4fHu5ACdYByyRFd/xL2HN1jfqcJfsY4lCt7aN1
 cadj6DOPQMHxVOb5eFYLJkAgXQqBY1NPRN4XROszJx98y6R3PF17qab8lgAMHwQkXLXLZ7D6vG7
 UcRVUrnciqtADBdszf7RI7EtaiVxntNzdlW8v
X-Gm-Gg: ASbGncvv+D+OX2wqA0A3O6xdzEzq2aw20hz5OhAXUPWP10Cqyg4G1B4HiaiAGKdJJXP
 d3D1S+Gmzk4lQwIe/8TsfrPNnwlgyKg2MAEZTTEvcyxUggy9Jb/2QM5vLphfda+ikalKjYTmvJa
 lCZOn6NplpkZtbbKnpo3rhrZW02TgTvzU7uw==
X-Google-Smtp-Source: AGHT+IFk4FDdjiX80I0hqg0Yx3JsyennSvpxUki/8Z7iDQk7ohJszZZVqudmEfMf5PwzVo9IknncMF8pN6ZqQywFE1A=
X-Received: by 2002:a17:907:a195:b0:ace:51fa:be56 with SMTP id
 a640c23a62f3a-aceff3c13f2mr215483166b.19.1746111897174; Thu, 01 May 2025
 08:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
In-Reply-To: <20250501140617.GD1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 09:04:45 -0600
X-Gm-Features: ATxdqUGYhdz5zniJ-qoiq6UYk0CTvpIpgcKX87blJ_VNVBAa0csZoq2MExc8x9Y
Message-ID: <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Oliver Graute <oliver.graute@kococonnector.com>
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

On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > This file reads from the environment but does not include the correct
> > header. Update it.
> >
> > Drop the unnecessary config.h while we are here.
>
> Are you sure about that? It was explicitly added in commit
> ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
> includes") probably because of CFG_SYS_... usage.

Well I assumed it wouldn't build if it had it, but perhaps that is
incorrect? I understood that CFG_ things had to be values and you
couldn't #idef them?

Regards,
Simon
