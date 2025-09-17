Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0C4CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200FC835AA;
	Wed, 17 Sep 2025 15:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SP0gpGsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB03833D0; Wed, 17 Sep 2025 15:34:17 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D68835C9
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-571a58b385aso6228443e87.2
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758116054; x=1758720854; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ev7wYMC94jWk7ZUzwASYVuGvFpGp+l8VfzpmUZixJ0E=;
 b=SP0gpGsSecvUA6icRsWNaw9IfkanrjTb0PlEDpK7SujeF6X+sxJOsjbvqEZiit32Mm
 qKvmtF4tVFY7pxXcZY0iqzUcm/TEfVgPFdeuL10gMROb4B+GUj9jT/66tvfRT4OvmvlU
 njqirvcG/FzlM83J9HE+fsJZ01IfPgoHA/5FFmNvWIoCFIcdlChUVMLqXBUEafR6GZTa
 HnqYoHZCzW9jLHZKcmoTALokmo5W4YHuqMv+nofR04scLmUKn7HO2QZo3VqzGULCuQ8t
 skZmdp+zRXw7E/wSxpclUmaG6WD7wdD5f7RKIici6MfUupUpOd8TL6BR9HYqxJBUv4ss
 R+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116054; x=1758720854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ev7wYMC94jWk7ZUzwASYVuGvFpGp+l8VfzpmUZixJ0E=;
 b=EyRkTY+PtSI1lZCC8CyalXUxhkpJhTjdKC4fe8K4bJ0NI16wKSd/R2S5nev0v1qeMD
 xZhbv75mtWI8GuOS+nsYhTjVpDzTF6ywGG4Kd94jjKFDFunOa6981j2WHFeHL7FEnj2Y
 iaNo+SmUUT9LeUaJPB2zpxtisovoYSXMJfmA4PwmLzOsc2eIzjvaok1tAPJVLT26vdnX
 rkB8ln03J4wrlxEdG81Fnuad7R1RlW06ihuRJz5ymlFaMJT2rasCyz+MQcqOeqAXbpqf
 o7cAQhAfqW+8qutd6P8FL5rkeDU2PeOhJgQau3EpgWlhUeVdyAk/WgtWDFZvfbYE8tGh
 x6HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq+ocW+zFFXFpkqPpoAbquMc+Y3r02cWKkMn3C51LBMahT6ERIPLYHm8+42sGXvFFtdRi5LRo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz46UfVJPzNc3B5u+mpS6lvtL6yAlhycQIXvs4c2kjcrNJrQm7D
 cOeZ7YZOuek+Uz5QABSlaBvV+hEH0/nD96zkIbkERugEcffYxGeTT5+oSNXbsbptWTvHvS9oNLP
 46gYR+kpYhXNCYkf46UHhlg/Hiuryl58=
X-Gm-Gg: ASbGncu6yj1hHS1kihWZHo1XTnOtY4C9EHx3N9ThZ135fv4qm9OI3KZyxA4uE1r4URZ
 u1CF3JaIY6iITodp38fxSfbPjBWMC4fXI0YuM8l2h0y98KgHrgdYt0LCsb7M6nO/OiL77zMbTLH
 jBNEQq8pPKrEaOZqfBg27GMK7uDmZDFsZjpASjl6XNYNV2kvpJoHPWLRqg4WwJhG1QFGRTNb+o+
 /ypgKLzaDrt5fJ3ki7vQsm1LhEGXUOlQ6Ijr7cfJb43c+oqxQ==
X-Google-Smtp-Source: AGHT+IF6BIrNpBsuaiwI1fD6Ddwzw/q/Ewfs7OJazFWRJAK5rl7ETzS2T548zlALa3JJiW/lBKl2OltxcyzYJMR5NsM=
X-Received: by 2002:a05:651c:2546:10b0:339:1b8e:e07f with SMTP id
 38308e7fff4ca-35f63ba4444mr5874351fa.19.1758116054053; Wed, 17 Sep 2025
 06:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250906-imx95-v1-0-f2a5231c1d0f@oss.nxp.com>
In-Reply-To: <20250906-imx95-v1-0-f2a5231c1d0f@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Sep 2025 10:34:02 -0300
X-Gm-Features: AS18NWBf0-oRRIX0Td9tdzdoM6mNMQVpF_xxytFjpeAfXzu7LeT2-UOWtkPLIp8
Message-ID: <CAOMZO5B6aMz+Bb1a8+SfZK-rZBCCyytVSED-Btz6BOZURis_Tw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Restore support for i.MX95 A0 silicon
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>
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

On Mon, Sep 15, 2025 at 4:27=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> Changes for v3:
>  - update the binman etype to generate a configuration file and a .bin
>    file
>  - update Get ahab-container.img in imx95_evk.rst
>  - rename configs/imx95.config to configs/imx95_evk.config
>
> Changes for v4:
>  - update nxp_imx9image.py and add testNxpImx9Image to ensure 100% code
>    coverage of nxp_imx9image.py when running binman tests
>
> Changes for v5:
>  - update nxp_imx9image.py and add testNxpImx9Image to ensure the patch
>    set passes U-Boot CI
>
> CI:
> https://github.com/u-boot/u-boot/pull/812/checks

Applied to master, thanks.
