Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68105C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA42A846F0;
	Fri,  8 Aug 2025 14:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UYq5ZO1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4378584707; Fri,  8 Aug 2025 14:56:16 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969B9846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-55b8b8e00caso2576616e87.3
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657773; x=1755262573; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZP/18iptLfTw+XjnBdb3S/2c6tAoghbkQ89JfYHDlY8=;
 b=UYq5ZO1FpUt5/Vtnnm6ULxSrlKESweZGkvumZF9d51oH68wikEnF46GrCOe6IBhgxg
 T6+Elw0AcBVZhD3LbNxCEa9r57oksiUtBqS4XcCD3ZpBaOrUkgtb2M1ou7c67QHmo/SW
 lJD6iw5tSFfl4LUEv9SIS3EWvm6Ta39B4CzQjQ+pvAgkoAI0SkSfMBQLi8tLAxlzM6Jv
 zTEge1kmIGevuwquRLC1vmyUl24nFDgMn+rDZEpzc7WrZ1ZJif6Z2uu2nGKrbMvY2c+B
 s22fx/DKz60hv1sTqDKRCtIYMtatPZe9cXsSyGh4AfkgFl7zUwvGeHdW5b8b4qtnwT1h
 cHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657773; x=1755262573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZP/18iptLfTw+XjnBdb3S/2c6tAoghbkQ89JfYHDlY8=;
 b=t0yiRKte6DBFHvy0nfhVrIHAnShdtyJA4opAQvQCfOZ1MOEdY35+WMXsOwh7hSIJcf
 QG4MmVeic27WzJ3reufKi5PlCrpHAQ5vwf4BskeGzZhY0akMA+JArer6kkaNE/475aqQ
 UCdGyHht2Y40zqwlQsgfuvsCYFhXJHJPQ97IcLxQmBuA57oHn2AH7+VS5mCmCggxRXjv
 l40fpLa7sVRkFDYWQuBljzY4wHUqH0hX4vhzGYb0tN/uCu8RMEDmmnbWchwFSjodbnmJ
 OqHo9AouAITO0aAz11rhHbwcl6TCyHwmQcOemmBOppPdAduSCk0ffj/xcvQCYyxct87M
 Ahig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdljdLMWC3SFfVpTl73pKqF9ayn/IdZoA8sItSWwokZMXJADuA23UfI4dsCVfAE/sTqGcA7cQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwwGyqEyCiCkSPu2g+rzIooVSXNYLr0i6pLfw3icfuTqUCUsOtg
 W0Hs09vy2Ga4iUFvQfgoV1kc4rWxhaPFZWigkyIat9GQ7GaTV5mr5xmwsszrD/oBIz9sBWtjVrS
 0jpMP2IJPU4Lpz19HQlIukw3BcQYnPHM=
X-Gm-Gg: ASbGncsRhV7cCqxuF0eAD+/bbNmU/fOw9ruw1zPqRC+HS8zXY3mt+j+vabzAdp2rmWU
 73Vd9wCweW+jicB0ULjKpe6k7rdkqUbYSHRfh6U3+QhsCK+w0iTeSqqgvkmLrcj8LVt8mgAPxfK
 AuVoSXnE8YjWWUbzHou1eAhXmfq6j/bZdpjRTwA8E7tvRSIJ4Z8vUmyfGKmvI8TLiJEmEOynzSi
 HIehA8p3rQ0nR0W7KjSzF4jP74e4eBmm3U8FA==
X-Google-Smtp-Source: AGHT+IE69pS8/lb4nEvndlAilwtHvazoh0DrWtP6NiY8UtSmcIOwr+xHRLIvTIHoTFXJvYC1IU2t2MLp4LhRY2D6rYU=
X-Received: by 2002:a05:6512:1254:b0:553:a632:c7df with SMTP id
 2adb3069b0e04-55cc0075ca9mr852466e87.11.1754657772538; Fri, 08 Aug 2025
 05:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-scu_api-v1-1-89470de6d9b8@linaro.org>
In-Reply-To: <20250728-scu_api-v1-1-89470de6d9b8@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 09:56:01 -0300
X-Gm-Features: Ac12FXyWGFuneuyIWJHBzxe_VKr726dP5PqQMHxBSfT41knAaUrlVxEOYcFTmwk
Message-ID: <CAOMZO5Ac-T3NXhk81EDAesgR3F41hyHE294qPzK=hWDtXVPB5g@mail.gmail.com>
Subject: Re: [PATCH] imx: scu_api: Remove unnecessary NULL check
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, Jul 28, 2025 at 1:42=E2=80=AFPM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> In sc_seco_secvio_dgo_config there is a check for data being NULL but
> this occurs after data has already been dereferenced. All callers of the
> function provide a valid pointer for data so no need for the NULL check.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Applied, thanks.
