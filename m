Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36523C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 15:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF3E48874F;
	Tue,  2 Jul 2024 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iNwhExE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A81E87837; Tue,  2 Jul 2024 17:51:47 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752B388712
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 17:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6ad8243dba8so23746746d6.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719935504; x=1720540304; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lMj8y7oC6lQLIY5/1i3nbKtfFETlIsYsCKUN+5ZH6pk=;
 b=iNwhExE8tRuKgnN7oeCjzQXDCf67cBd1i3UCguug2n/exn8EwRI8cgEqqGLWHAnGcd
 rRP5dj8EFobvj6bjeK58luj/D5NlQe6qvfsfdjPfIsZEr6LvXA3ROmzTh3uNiW5snbgw
 CZLhQEdgKrWXKdPv9MINUaLMoKpKGcthWwHxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935504; x=1720540304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lMj8y7oC6lQLIY5/1i3nbKtfFETlIsYsCKUN+5ZH6pk=;
 b=MRKecgQsVrFsEkrmbAmbtRD8SdZz7IKg3gxEb5fHPlE4+vspJOv8sZD4WM99wilOyo
 b4sw/IT0J9dWn9todwyS/G8FNZaLO91FXXZUkb6Oubgmsn7a/ukV4YjIkMB3y/jJTf5U
 aX0pOgmeUoeZXC1PIZKQK561g2hr5evSx0X/4yB2CjFqwSEqFYIuZbiln1/0NW+G0ZyE
 VR6fWzcPynkvXjPM18aOCC55INnA+PhGahOoKokqGXJvVWjbUSYYQGp2BsNHEimIf4mC
 kOVoX/EHHSfk6c+TQO3xRgfwrgqooPlTe7VM5XSU0lfRVFGpnz0E3Lu9c023Gpi/esHK
 EOTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+YHvzardHEkr79clIK9MlSopY+Jn5TnQRs1yCUCyEgldOs8cFTjYqv1kVqK4AS1iRj8PkEwG5et/dtSt13M5a8RQQMw==
X-Gm-Message-State: AOJu0YyNEZ4LNxEBZjoitoXtOa4Z2m+K9+ODfzSYFkHGsxRwPQxHkIny
 cOg6hLhDT5l43bZYXMngIzb1jxrHTpBCW3J6Tkp2qZrKljOlBgO5TrXXoVFexuvwOMt3sVNL0an
 dqYsjhSLq81yOPUtAtcuCELSO+kMaUNmkTe4k
X-Google-Smtp-Source: AGHT+IGEDz7j/Jk7oeH59I8gLwsjMmW6cNdIjwxhiNbRzla7CyTbCVSozwPDiaQppjCASg0bkhlzZATkHUJqzb1yFB8=
X-Received: by 2002:ad4:5d6d:0:b0:6b5:de3b:dc24 with SMTP id
 6a1803df08f44-6b5de3bde4fmr2434526d6.48.1719935504453; Tue, 02 Jul 2024
 08:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240701204242.6036-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240701204242.6036-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jul 2024 16:51:33 +0100
Message-ID: <CAFLszTj9W4eD7Z0EjV3ie-Z3S=HaVnf9j6OSJEQNECft_EA-1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: fix heading level of itest examples
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, 1 Jul 2024 at 21:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The Examples section should be on the second heading level.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/usage/cmd/itest.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
