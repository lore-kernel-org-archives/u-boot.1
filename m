Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3158C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 18:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85999887C6;
	Sat, 20 Apr 2024 20:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P64ANeMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF76887D0; Sat, 20 Apr 2024 20:37:21 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B30E88791
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 20:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e4edcde7a1so5522005ad.0
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713638238; x=1714243038; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kr0iEBzBnThGsFtbI+R+dzCxocAtqeaa3OBdg75piPM=;
 b=P64ANeMVV6z3+V8NidLsiDBQ+KGxWoWObygBnajgf74koccWy0UU+Hk28TI6cWXaM3
 YtKt7MpzqvilazUsYdeoCHqNxEw3Zh0/HAE0U30Vk6Sg794JezA6CydjGNtnJaZQ72BU
 nK/52B3wJ6Ix919LuQC/km8pu3JOl/YuvpnFDFlPtXZ8QpfM+sJzMXa98iiayzstmgNb
 HnSORkk8M51vu89P4wGgykP+HS4Kiar0ZqFslbHhQZIX72hMzJxWv2kSaJGkCWzSt1t1
 LaDApoCdgn60xMbWWIDOOQi3G8RtH7Fa4dtSatBEuhDtbJ8HNmbL58VbrbK7J5mUSKmB
 +Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713638238; x=1714243038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kr0iEBzBnThGsFtbI+R+dzCxocAtqeaa3OBdg75piPM=;
 b=UdC4629jrAjHDtXnx57ntiPea98rh6Lmvitr8Y6+pMQYQ6fA/kITzEJe6ccKnBTfux
 Gg4w/PW/1OI6gkrp7WOFgQM8XfW0CDamoxZabccMBwqf0J2TSCDVYjtok9sBrXvO1pVL
 WvLknux2FJT9heBrwnfUJt8O23+EJCi5aBMJSLwXVVS2ANhsAOnZTH8uDRIq7RGrJEbJ
 y3PG9zeCiMPIyCBhJehC+jfa06rjVXLCWByPNjZ2e6liMKqc3kzEjCVpS0K5PmKRbKb4
 XNqgfsSv9HIBBnyvetU/r+Il1iUeltI3gsnYaHW+C/lpjOAGlujS1e4g4nBsrtOuLaak
 YQng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW802UiAy3EY/eyaC2Ek0QyRLUSWb0XV8jZkTyRPfZzVLzITkMzlRY/se/vQKH0csaMTIvqf3zQO++R/KwuQSfxqM6zmQ==
X-Gm-Message-State: AOJu0Ywhr3UVjOyHX5WhuiFDhWhvSDl9rMZ3ANyT7Pqkbmg3YevTYaMB
 ZqeB2UVKj61DQqbZX9sTuXnLC9NwIYB/bNqHcu4GVd7WtuSNaOU2TYfIwoQv7oNr8hds+XV+bBk
 6UIZEeDiP1jHr4vgMip9iqZn234Q=
X-Google-Smtp-Source: AGHT+IE1dbmVHxmpewzenqFy0Bh7ciodXXLt4pCRBW5OtMsnDZsbhs0xEfzYbqnLtxiEqcwBUyfh0ghWuopSH1B7g+M=
X-Received: by 2002:a17:90a:6982:b0:2a5:3249:d230 with SMTP id
 s2-20020a17090a698200b002a53249d230mr5509853pjj.3.1713638237933; Sat, 20 Apr
 2024 11:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240418131247.19646-1-francesco@dolcini.it>
In-Reply-To: <20240418131247.19646-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Apr 2024 15:37:07 -0300
Message-ID: <CAOMZO5CoRpAmhqxdOqz+xZBfqeuHLtzhyd-npuSsi9HbGS9QdA@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: imx: Remove not needed env variables
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
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

On Thu, Apr 18, 2024 at 10:12=E2=80=AFAM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Remove not needed variables from environment and include config files.
>
>  - setup variable used to be executed from some bootscript, however
>    it's not required and there is no point on having this small helper
>    here
>  - boot_file, kernel_file, ip_dyn variables are not used anywhere
>  - fdt_fixup variable is just set empty
>  - defargs, vidargs variables used to be used from some bootscript,
>    however there is no point on having it here and even old legacy
>    bootscript can work without them
>  - removed CONFIG_ENABLE_DDR_TRAINING_DEBUG, this is a leftover from
>    some copy/paste
>
> On colibri imx6ull/imx7 NAND module, remove consoleblank=3D0, this is
> already the Linux kernel default therefore useless.
>
> Various Linux Kernel command line options removed are not-existing
> left-over that applied to some old NXP i.MX downstream branch
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks.
