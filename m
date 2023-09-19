Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3D6CD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73C786A3C;
	Tue, 19 Sep 2023 09:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lYXqxX0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5858C86A49; Tue, 19 Sep 2023 09:19:40 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C73386A3A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a64619d8fbso702415666b.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107978; x=1695712778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiFpF1wntFdy/4RE/BbFMY77jfNxE99Ambg1CzMWNpg=;
 b=lYXqxX0KxadJ5w4Wgv2zFh5dVS+eQ2KkxKHFReGFddK4MEltw0GausLQc20ZrIczVP
 yUGOVhF88UkEJ2bsIpGY5UVNsn/ZwvYZQcbsCv07pYnWnufL2ATbDycr9UPbtBRzkmQI
 RX1pRXSpteIz1oE1dllnB5i/tXHugq+IrC8aRe7u3l9D77hZ2zY3vhEnFGoeYbY7Dx6S
 q4Bd5cf+JD5tCB9J8oB19tfg4OGvnIKP2nYPMYzbqLzcnzUKpatGjNUVZpZV6kEnIG1Y
 mf60HZsrb5ns3u2HfidE4bgtWm6rX67KUHgbalS748ouGvQfJSxsgvfePiN5JTq6yeKu
 V0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107978; x=1695712778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiFpF1wntFdy/4RE/BbFMY77jfNxE99Ambg1CzMWNpg=;
 b=H2RTVPJCpU5zNneD19soWljcLa5UxZtZzc8QKY63LiZ946y0QBuqEH1T2DbM86gfSZ
 VrP5tFKOXANNYjZ3aVt6X5bHzJkgkXFIMyor8fEemseqrjmVTEU61u+TIl5vXrtMz7lO
 cpz9rYssANOggptGKP4NDy5aSMdBEM82mywWiQgVohLrAwFYy3U9rJTxlElJM3AMa0xi
 4yvtU/h/Z/uq4y6UF/m2ajChkndwO5v4ecgbYk6G0KZwd5O5dnOKFLk2iC0WhXsFdixM
 g1wL434VpV/TTf49SR2lkX6aoBcVofHfNB4DIg77cftLqPFk1BUijiqxw/NsFkJ67rGK
 vuqw==
X-Gm-Message-State: AOJu0YyVlJf00DTodRrSE5EXPmPVemOirW6bxUnJ2kOuhJHWsVNJnrda
 myaOgj6wbp0aEn20AU2antgvpyqTegV+PFvgM4k=
X-Google-Smtp-Source: AGHT+IF5p/gyHCc12mQnGkbTvlBoSa2Ipn7uStW+47ucRtcJkhwpgsjE9zJG0l5IT8o4+DP+vQ+hc0jrn/X1ksE2R9o=
X-Received: by 2002:a17:906:51c6:b0:9aa:16c4:be16 with SMTP id
 v6-20020a17090651c600b009aa16c4be16mr9816639ejk.57.1695107978149; Tue, 19 Sep
 2023 00:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-5-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-5-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:26 +0800
Message-ID: <CAEUhbmXGUnVFFG-fLyrcSnFr=S_jhVjMUKPT0mjG1556M9Jrqg@mail.gmail.com>
Subject: Re: [PATCH v4 04/20] x86: Set the CPU vendor in SPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> We don't read this information in 64-bit mode, since we don't have the
> macros for doing it. Set it to Intel by default. This allows the TSC time=
r
> to work correctly.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/x86/cpu/x86_64/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
