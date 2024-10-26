Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C9FD10BEC
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 08:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5516888DF1;
	Sat, 26 Oct 2024 10:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aUCSZqRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAE888DF8; Sat, 26 Oct 2024 10:53:21 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF0988CD9
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 10:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e2cc469c62so2019675a91.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1729932797; x=1730537597;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQP6ZISNGtCxHCMKtWFGXP45Ar7kRjUEThhVEVu4pGQ=;
 b=aUCSZqRvmdh/EuXMsvc7XDB3HNr9GITw+fpLzcYr0/lqL1uJ9XpKKUO3WVxTE/5Dod
 2brE39V6DyI8uAzpBu3Pv7h9/AKll0IoWW7dnCsNf5NAv57WEdjsgBV/9p7HcuekoWih
 DnQVIbMGnDd/sMBqMnYYdeuIRgLWtJYYfqDwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729932797; x=1730537597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQP6ZISNGtCxHCMKtWFGXP45Ar7kRjUEThhVEVu4pGQ=;
 b=uUAlo5Z3CqdKcy3AjDgwVFSG/6KOjbDX07+TOo7uZN6fJnFvfpKlQEPTg6kVPrmHps
 /a/JOmIWdElXNhQSuZ4ecfBjGWorFZBbh1+SfHcvBfhAalhgUJPWSXaM4koLxWpHH2AN
 Cj0ZZ6/2jaonrQIWhJC2MPyIg5zZ5/Y9397ebpNR7wScUo8UHyMuHM8OpwP7JAbDNgR/
 1EzL4nRy9Xb8O11C8zAOxquK5ru/RWOWc01qI46jfT1jJP4eewQzfiV0uebFFKCrRM9D
 YvH0TG+ns4ZsDpZtAtOxtDkpY8DBgzICz5M3havNrj1a59ecHTOMaJ/vGfXwQ0Oqw0GP
 KzfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMEH4Z2uJZ/eCDl41i7uNRbt4detGz3s4SuhJ9ubWFUmLxr9hVrZJzxfmDw9dudqm+hhr8Rvo=@lists.denx.de
X-Gm-Message-State: AOJu0YxQIt52ZjUpMXbkIJnRfyfA+0A25hQ3tZQXXfA+xxike5taZaUt
 foEMihcGu44O50rns8uaOD8vIrTrKTvdUvHWSW4Mzg7klsKZ93AuOxDYTIF57FKRO4WDzzss2Xy
 5HvWDjL4cjphkWeRsNvBoJr7Snn9IrbxmSU5ChA==
X-Google-Smtp-Source: AGHT+IEtdUnDR6AY4bTDQCI5AcI7WCWNfIGkTxF1fFP/9n5o1g5hpDQ0eMG4dzaspvuotZSvSwpueG5+n9WXwV0PhK0=
X-Received: by 2002:a17:90a:68ce:b0:2e2:a8dd:9bb5 with SMTP id
 98e67ed59e1d1-2e8f105e834mr2381830a91.12.1729932796999; Sat, 26 Oct 2024
 01:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-3-heinrich.schuchardt@canonical.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 26 Oct 2024 10:53:06 +0200
Message-ID: <CAOf5uw=kzzTmPHCOLnzQ4Atx7WkAjt9NE8McnWxvPnZFMFHcjw@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs: ext4: free directory node in ext4fs_exists()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

Hi

On Sat, Oct 26, 2024 at 8:42=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The directory retrieved in ext4fs_exists() should be freed to avoid a
> memory leak.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4fs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> index 15587e92e3e..21714149ef5 100644
> --- a/fs/ext4/ext4fs.c
> +++ b/fs/ext4/ext4fs.c
> @@ -209,12 +209,17 @@ int ext4fs_exists(const char *filename)
>  {
>         struct ext2fs_node *dirnode =3D NULL;
>         int filetype;
> +       int ret;
>
>         if (!filename)
>                 return 0;
>
> -       return ext4fs_find_file1(filename, &ext4fs_root->diropen, &dirnod=
e,
> -                                &filetype);
> +       ret =3D ext4fs_find_file1(filename, &ext4fs_root->diropen, &dirno=
de,
> +                               &filetype);
> +       if (dirnode)
> +               ext4fs_free_node(dirnode, &ext4fs_root->diropen);
> +
> +       return ret;
>  }
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

>  int ext4fs_size(const char *filename, loff_t *size)
> --
> 2.45.2
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
