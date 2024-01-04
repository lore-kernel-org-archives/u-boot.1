Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C61AC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E60C876C4;
	Thu,  4 Jan 2024 13:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Lx2hgAOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8127D878FC; Thu,  4 Jan 2024 13:00:16 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A371874DD
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55614bb435aso2472352a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 04:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704369613; x=1704974413;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmQdDX0oOIWPBXKRK1PXdPVsJMcIoGFQN4kDZg0liNU=;
 b=Lx2hgAOf1GsQ1SQdnZbxldv9LNZcrxPU+lvebKzryMsRORLIguf2eARJxkAxTgj852
 X5Zo+hmDqIC77hyinAWUfgwHksUmXIudgthBlDoFoJ+T1vyzB2iMbRHopxaGg6VBXWEp
 AX2j3fmMahFBTN3taBsKoBO2lKfy4NnXZ4iqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704369613; x=1704974413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmQdDX0oOIWPBXKRK1PXdPVsJMcIoGFQN4kDZg0liNU=;
 b=B+CBD2yhON3hkMQxFczUX+1Ke5D7YoJNS4q/BhtvHBeIWiw2IdhUDd/YmEDppkUgiv
 P237Qbm40MES5xxYaKOBtDEEDDYsw0qh1vxlTbeQ4vdhSFnpJNc95x4U3c2/JCe40EtA
 02JKPycSzHsAnjsucLp9in/mTUh+odJWvIZRewg18df5OGPZ4/+QR1ABECLyrOP3A+L/
 fWs7uVjaRv9YBbYKu3bkB16KUsVZs6SNN6Yu9OJonOW72GFavkmVoAnpzzFOMZPD/cWs
 vNaKFR2x7aqhfeHVzJ+EfkCP7E4/IRAjXqO8sZEWMMWEpxuLzz8AswfH486rHCNFpIc4
 1IFw==
X-Gm-Message-State: AOJu0YwZxvUD3/QGJduOMoNBxqziIrgcVzvf3bhPjY6t7FqhIi48Pqq7
 c6qGyrLdmsOot6wW7nVMMiS8fl/l/kam9lC1o13W3x6FYV0S1g==
X-Google-Smtp-Source: AGHT+IHh5DH+FZAw1NL0H5/X103IJoXgyp/FJIdjdMQVBlLV1Etnf6Go67ASKdDOoIn0HUVdg0UiqbxBFQL2gjlnJfU=
X-Received: by 2002:a17:906:f10b:b0:a23:75fa:c16c with SMTP id
 gv11-20020a170906f10b00b00a2375fac16cmr417141ejb.34.1704369613371; Thu, 04
 Jan 2024 04:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
In-Reply-To: <20240104114619.280513-1-o451686892@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 4 Jan 2024 13:00:00 +0100
Message-ID: <CAOf5uwkd171=hg6o56HA4ss0Na1juUiao2f_ERbV8WpnAwXLoQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
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

On Thu, Jan 4, 2024 at 12:46=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.co=
m> wrote:
>
> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> crashes.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  cmd/sf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/sf.c b/cmd/sf.c
> index 730996c02b..e3866899f6 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const a=
rgv[])
>         }
>         flash =3D NULL;
>         if (use_dt) {
> -               spi_flash_probe_bus_cs(bus, cs, &new);
> -               flash =3D dev_get_uclass_priv(new);
> +               ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
> +               if (!ret)
> +                       flash =3D dev_get_uclass_priv(new);
>         } else {
>                 flash =3D spi_flash_probe(bus, cs, speed, mode);
>         }
> --
> 2.39.2
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Suggest to add documentation of spi_flash_probe_bus_cs in a separated patch

Michael
