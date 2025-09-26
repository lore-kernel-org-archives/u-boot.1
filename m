Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C12DCAC5AC
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 05:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF758206E;
	Fri, 26 Sep 2025 07:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HZQIzUip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD0C82A9E; Fri, 26 Sep 2025 07:34:06 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5148144A
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 07:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso1585202f8f.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758864844; x=1759469644; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgKj0r8nysyjDLgPIfNENSQMYmIlifZI6PuZogSp8zo=;
 b=HZQIzUipDbE5Di/5AzitmXcVdRVQ2NFA0XjR1nSgGxiwsMSyzNPdIEW37YrKBJB3KN
 Rv8rQ9qF+BYHncFrqNLtTfgkO/bM+OtDkuy8BdZZi7uH1PSevL3lTJDOpJtraxdXnBil
 x9y3QaHEM3WyWjWhtUaSG54Npz1Dg5KwuY6DKNlWGjXtWVQfgCsyDa5anzxnZOxHgq/D
 QXcMEVg2m5KCUyGUOYQC787gPWFRDtqLlOELRzj9j/ngE0v0Q8IoQHLH+RorNzESk+LU
 Hch2RRG4oIamrvgI6Gh4pv3/0393NBy1YQiMsfLn08wOwVpBgTdOPEhSebNKHQ/JyVPO
 6YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758864844; x=1759469644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgKj0r8nysyjDLgPIfNENSQMYmIlifZI6PuZogSp8zo=;
 b=aXMqmG7LJobtHVo3UVX3j7m2/pgK01o4aNYBAPnyeJl+abnH5A4QJiIcFsMv/7dBmg
 6iQySHbFGJAQE8xaVKO5qu/ttinU9PRbo/k7UTVgRJnE/hoLWw4h/QUvi4AYZ+lCbdUM
 IPsccgqmx2Y2s+c4coiHfiAFWzhSffWtVSo2qTX9srjck/hxYQfP1E7hT3N1XxG32NMT
 HKQ5JdVS0ZeXqHYNSl7JQ4tDukRm+U39Xgmv5BpMpEKnDkfSDNeipwTrCEjpPSQ6enwr
 Nt/BexrUdpIYAx74I8KfhXUUhMqh6HlHcEO04zC95tBeWFh8dqSAW4fSriNcQqD258XT
 bPOg==
X-Gm-Message-State: AOJu0Yy9mDbg00PY4Bie+a7Fuha7JtglS2vvJ7D1fcseWiRvTBIARHLz
 HIqB1pDx6XbbZ6N25oGBqBr2BbRiU8l4KqBLLYPWdkgeKjL/BsysX0kID/3ANbMRxPRJRPptHwi
 2neVhCTpoBNvl9E6xrVcuFB1AWgLqig0=
X-Gm-Gg: ASbGnct90F8ehyWv7DTw9xI7zr4LupEUXIExN6IVD8CoRl5umGnAcvzhQBzaL7MhDWJ
 6d/FFMpmHmulZruqdSq6c9L/1u13Oa04Yn5rdy3MxQ8NNwO50X+E9tjtiHfbrgyGuFDXTOIqmkX
 c3RDWMiPDdR7bdxEob+J10Wotv2TvFnpdSlXei6QkAJZ+eaqziYBbRMqW0rFalCv6PIyq2j7RfT
 PZZZt0/J//JnsUCZYw=
X-Google-Smtp-Source: AGHT+IFA5L4Ptd90qDJ2sOCWun8oczfaX42Dy9V53TDkWF6aMegHRACHOqf/D+VT+m4Fekb0qcBJSR2Zld+MBaUkzhc=
X-Received: by 2002:a05:6000:2204:b0:3ea:d634:1493 with SMTP id
 ffacd0b85a97d-40f5e5c1023mr4556582f8f.3.1758864843687; Thu, 25 Sep 2025
 22:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250925204535.3561174-1-trini@konsulko.com>
In-Reply-To: <20250925204535.3561174-1-trini@konsulko.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 26 Sep 2025 08:33:52 +0300
X-Gm-Features: AS18NWDw0bAgZTP6M0Fv--5zknFzH-gHoPV8nkxvlDcm8BGe5Z0f04S99Bv3shA
Message-ID: <CAPVz0n1gTbwUNtN4dFbo8vEEOqqQNhborqy=7+A5CyhGcusJ8A@mail.gmail.com>
Subject: Re: [PATCH] crypto: tegra: Tighten TEGRA_AES driver dependency
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thierry Reding <treding@nvidia.com>,
 Ion Agorria <ion@agorria.com>
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

=D1=87=D1=82, 25 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 23:45 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This driver relies on tegra-specific headers to compile so make it
> depend on ARCH_TEGRA.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Ion Agorria <ion@agorria.com>
> ---
>  drivers/crypto/tegra/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/tegra/Kconfig b/drivers/crypto/tegra/Kconfig
> index b027609307b0..0f2acaaade1f 100644
> --- a/drivers/crypto/tegra/Kconfig
> +++ b/drivers/crypto/tegra/Kconfig
> @@ -1,6 +1,6 @@
>  config TEGRA_AES
>         bool "Support the Tegra AES"
> -       depends on DM_AES
> +       depends on ARCH_TEGRA && DM_AES
>         help
>           This provides a means to encrypt and decrypt data using the Teg=
ra
>           Bit Stream Engine for Video/Audio. Also may provide a mean to
> --
> 2.43.0
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot-tegra/staging, thank you!
