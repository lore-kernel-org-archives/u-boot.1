Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AA5C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10A6838EE;
	Thu, 24 Jul 2025 23:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jw2/3giV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C4C838FD; Thu, 24 Jul 2025 23:15:34 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6224835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55b50590cb2so1499123e87.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391732; x=1753996532; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGL+Y6aOVztqgi36iny+vftie8iSugZanI93KftPc1A=;
 b=Jw2/3giVpkyrmo8IYIyq2gADGRSelX7r3Y+7P/e/VQI8GercBolhBh7TsVbHmjqX5X
 OZaC4Xsarxq0WAi0E/WwsjUsH1CP0b9TeZElbkzYo6R2asKkBehUoLGTXTIsNjG1WwHV
 DO+pWx9WA0m45q0L9EMPqpdSeplMML0HaEVnMZ07DIZ55oVn0uvLwnhLPl+ZW7VKTazw
 MFMzV1w3wL5UXRWMOhlP915Mxk2VYUB/5R7zATxOAgJWqqljsGfgzRiPp2A5ovkxeRb4
 NOrRBqTATdXPopAFGNrGXzdvHhrGVScCBmgCW2YViYMBkaov5JaXry4Eeo7jkhZ73tkV
 uJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391732; x=1753996532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGL+Y6aOVztqgi36iny+vftie8iSugZanI93KftPc1A=;
 b=KGr2ZccNdK7G1ULeznlSaFQyAfFfhHJn2b9FLGUUju1rzoPSWGrIha5Wg17wN/AHaG
 UUws4SorL4b//iGhOy6Seb0z2THkPgT1zrWuGaczqCR6KgHmyUFvxSLKRTyP81tNuOrV
 jypfl8xnSm6ryfWfoDuDFMrDlhgaqTTDi8TdP/6UJX0XZQrTeUY1Yb5fOabvMVqODB9p
 aq/Fg7xzPuWCjq6Izg30UPX+LJ+O9nv+HFP7MAmdeuFZttW0eeodTUEf8+5Ol6yFvcXC
 BRXY/nIKybzNzlttfwlUTIs/RNAiy3PJjwNhCVb+MfNPYWEnVSL7RwoUj3l7Es361LGW
 VQhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc+auPdQGMSTk5hUzATPMfyrPHWRZLnq/n2k8gmDkRovwNJIqS1GcBXkVyOeUI4P5zUt3ctkw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+9MhYntQjThBVrPvQJHq/RBUtIjWwe+xcIUNrE/N30r8Fr9iS
 uXfy7yys7/Z8lvSLc6BMbIqF9lEX8IAcuXbkWyxuHUPnMWvtZ8OtNBvE04SHMJ+dchuXV3dkPRL
 k5w/6HainsGNPB/yy9PDNUzFhWS9nZ6E=
X-Gm-Gg: ASbGncuFTSHSAOsOcJVLLP/tfaduRAfhnuPYqsW3YWkXXg1CSHMXFGYsCpYBuYGDyW9
 GWxs35NlWY9HPnBrcm79u+Or4oLm71TuQ9BqDQJk7c6DDBauX7OJ4RK5ug3s1ECoo7XdjcnaIUG
 JCKfTvjG2qZkihQSG1Le39Q4NZPISdWGF/yiRa9iccf4THFK7k/iWMHK8DzQWzosRbXzVH5hcfb
 9qo771KyR3gA0GsfmLLHXSnTHeMZLXsVJ7TQM0=
X-Google-Smtp-Source: AGHT+IHBqVeengo+2nOE0WObLd0J4S3kISAoZAhA5K8aMrX29Urv2WMjgxF2DCiDHxhxzVkD5mQhGXRyGyrpg/KfaXY=
X-Received: by 2002:a05:6512:3d03:b0:553:d910:933d with SMTP id
 2adb3069b0e04-55a513d6ef2mr2483536e87.48.1753391731905; Thu, 24 Jul 2025
 14:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250717110210.443381-1-ivitro@gmail.com>
In-Reply-To: <20250717110210.443381-1-ivitro@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:15:20 -0300
X-Gm-Features: Ac12FXxxDSP2gda7lnBBS3YQhCmtY58xpfsNJpYzigm6s_bk6BGAVyY_r89xmVA
Message-ID: <CAOMZO5CCfhdcYBxKmisfSZSG9zxC6s0S7FMaW8HpE9+QjT3bYw@mail.gmail.com>
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: add verdin i.mx8m mini 0216
 pid4
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
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

On Thu, Jul 17, 2025 at 10:40=E2=80=AFAM Vitor Soares <ivitro@gmail.com> wr=
ote:
>
> From: Vitor Soares <vitor.soares@toradex.com>
>
> Add PID4 0216 Verdin iMX8M Mini Quad 2GB WB IT to config block handling.
>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Applied, thanks.
