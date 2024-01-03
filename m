Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB6BC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 14:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BE786F64;
	Wed,  3 Jan 2024 15:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f4fDkDGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A073871CF; Wed,  3 Jan 2024 15:06:10 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD8D8701D
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 15:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-556aa7fe765so1436783a12.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 06:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704290767; x=1704895567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVg6L6M95ysliyLVCtfNc29lklgwexUIXOTkUKpSxIM=;
 b=f4fDkDGhi06npoVtgkywO5vTfZvH8YOEwr4ZNkUltH05P7T4CA7K/BAelrvW84gQW+
 lwBWSnwvteXDzUPIslGTQ5XDT10rUADeblZQOYJzzCREYokpUZnc9gJZPTjhAQkutmnK
 nDCAoqBZHgOserJhUYNe3kG55L5AidBtR0YBa+F4lEqtsYrMlSp68KX2ZUmvlsff3NoN
 FKKS8akWdmZwEyBJ65efPZb8k6ttDWx3N21ezrLtaCHMxNAgj/d4EEfBus49TLnJeBDr
 myij+Ixjbo6eJKkCCT38oZUkSjtvptrrNZ8yNDSEWz4B8Tkw/8ZUmJKjMHIRf+NVReZs
 ddUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704290767; x=1704895567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVg6L6M95ysliyLVCtfNc29lklgwexUIXOTkUKpSxIM=;
 b=mSDIA1vIDHGCxBD8wAEdFaCpm6gELLf+kSy0bMEQoLd5A9GNZ+uvIBvXbfcC+91xMv
 n188f0Y0y4HpYVfqgGevrzqLy8imCegyNo4axDIsGgAhsnQtV6zZsNxZDA1T8EIy3lNF
 CfR9KULrmOHMZL3aYQacPfHIOlaivXwaIDt/DS6zC00bCO7ma8apEUZy+8PzuRskKEA6
 RdJ2qQ1i1QDpuEuRYPRTYHSx5reJDknkoQ3w/Wl/UJXqh4yLcPfPmUJW6MSZVMs/RSDB
 MOJ1z97smd6joePg8qNnAaC02wFtTnnvyYFs9+72kDnEo+USTgvyZLdZJawHwvMUpSvl
 zDvg==
X-Gm-Message-State: AOJu0Yz5lkdDBpxIOwIE48/ox5o0g8ccr9LX/Q4eSSDcxZwzwRJSfIuS
 cclgOeLIM1NfuwxA549hjv1ZmYFFLh6JTf1FLO0=
X-Google-Smtp-Source: AGHT+IG4Etl0UVNoMSLMs6hkLEbiaxCLaatUO2R+q7oJI7WPpjPU1aJyn12qLbBBoZt+1m4x3IURL5SOzwRyHOzy+lQ=
X-Received: by 2002:a50:d7c1:0:b0:553:63af:43df with SMTP id
 m1-20020a50d7c1000000b0055363af43dfmr9158336edj.6.1704290767027; Wed, 03 Jan
 2024 06:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20240103130716.4144892-1-sumit.garg@linaro.org>
 <20240103132611.GH1610741@bill-the-cat>
In-Reply-To: <20240103132611.GH1610741@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 3 Jan 2024 14:05:55 +0000
Message-ID: <CALeDE9MTYhc0DN3q8SWRqqqe4M0v23kd8WpmkCPoA=UzPKcvbg@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: Move APQ8016 SoC derived board code
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, sjg@chromium.org,
 caleb.connolly@linaro.org, 
 neil.armstrong@linaro.org, rfried.dev@gmail.com, dsankouski@gmail.com, 
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com, 
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, u-boot@lists.denx.de
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

On Wed, Jan 3, 2024 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jan 03, 2024 at 06:37:16PM +0530, Sumit Garg wrote:
>
> [snip]
> > Tom, Simon,
> >
> > Is there any U-Boot policy in regards to board code going forward? Are
> > we moving in a direction to get rid of most board specific stubs from
> > generic U-Boot code?
>
> There's not a policy, no. But this brings this platform more in to line
> with others (assorted TI SoCs) that already have "board" files under
> arch/arm/mach-foo as most of the board hooks are already abstracted such
> that it's per-SoC with only an occasional further hook for true
> board-specific changes.

I think AQP8016 is a QCom device (db410c) not a TI device.
