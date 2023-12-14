Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C037C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC96487B79;
	Thu, 14 Dec 2023 19:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OR6iKKmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC4087B76; Thu, 14 Dec 2023 19:24:48 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EAC487B76
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5df49931b4eso61265067b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702578285; x=1703183085;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smhFQBc9WZvP/h1kG9wGblIzDb3ynOfW79PyLdiNzFI=;
 b=OR6iKKmHrx7TTojFpDGz/PByFXM9UQPA61zXqLUTkaYKFjx4FBwC3fKCD9tyMfOVlC
 gIYuNq1whmQheT0pCRnoc8NkdB+vaQmbqXt9pDiLYJFgn0m0+DYUF2TqGwx6xpCVr9fU
 nmHaYzMK+dJGX5vkFAEu+62XvCQAsrof+e6l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702578285; x=1703183085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smhFQBc9WZvP/h1kG9wGblIzDb3ynOfW79PyLdiNzFI=;
 b=gsrOALgmh/L722Qc7egrO87SHsxMQO2m3Zkplb1Uh/kSp7+giVsqZ3VXdLlzrdg09a
 JwqrejqOFqb6BMukRE0l0Fex8BYh19W1RpNohSjTYcSW+Mo3rVTQm+7HetmAk8HEx/Of
 f3owX/4v9oP0DTj95AP7U6Idj1jJ8ehLN8zYEi8XoXEjdVog3+joOya5m24JZH3SvZMr
 O3K985EcY/0QENAECWf42Yy0DpA9tjBzbJeLAnQSCbNVnObZLDDubqylqDwgX5o4Aco6
 XUDuyDlRH9mFR7/WG47fS5IhsrV+doU19NizMK+xzQnUZoS7NE1OLFAyJgyb9IRZGzYn
 1hpA==
X-Gm-Message-State: AOJu0YwT8u+5Cd/KvAfekD9gYp6fFsw5MWGvSNxMu6iqH3C62ThY5aTE
 px0qTRKWlNgjIEc5eC9cwIs67DcXrx7iEeRomWA7RZ9tfLaOIsmDb5I=
X-Google-Smtp-Source: AGHT+IFMSfikE9thga2LtANXuExwSGcLcH8wYCYOZpxSdzTWZqHclKvAnMuRmjVyucCPXGDm2t7VySEWIcNihpkqn4s=
X-Received: by 2002:a81:d242:0:b0:5d7:1940:b380 with SMTP id
 m2-20020a81d242000000b005d71940b380mr8851731ywl.76.1702578285165; Thu, 14 Dec
 2023 10:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20231018033802.5356-1-bruce_suen@163.com>
In-Reply-To: <20231018033802.5356-1-bruce_suen@163.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 23:54:34 +0530
Message-ID: <CAMty3ZCKsO3VJJaQ2qroiZDspUNqfaWM99y8eBneAOh+g5rqyw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: add support for xtx XT55Q02G
To: Bruce Suen <bruce_suen@163.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, bruce.sun@xtxtech.com
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

On Wed, Oct 18, 2023 at 9:08=E2=80=AFAM Bruce Suen <bruce_suen@163.com> wro=
te:
>
> Add support for XTX XT55Q02G(1.8V,2Gbit).
>
> Signed-off-by: Bruce Suen <bruce_suen@163.com>
> ---

Applied to u-boot-spi/master
