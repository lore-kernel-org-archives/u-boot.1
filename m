Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D5C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 00:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE948122F;
	Tue, 25 Mar 2025 01:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="NNmXmTh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B35A7806FC; Mon, 24 Mar 2025 18:33:43 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DA7800C1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3061513d353so50963251fa.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1742837620; x=1743442420;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8Yc/dhSE0ffsz72PLz0Y9k0WgG7syZhZW08fMlCfjA=;
 b=NNmXmTh5NdCq4oS3giEa4Wgr4kjhrUpgb8ODGTj3uFLjXawO+x5BQYroZ7tC2bLdCB
 qfTi6IQkLozrEe17EX3dESpiV9CuI9bSqibEb5fZbUYG28IuYMR/5RwXaAj36KTePWbb
 c/gmmzzainBgYpntWix53ilGCN5EQsoAFKzh+9FXeLiPFC+evZdVz0GBEwy6NxdloqJR
 EACsE9CiV6QCurKhgyEhDpNEfg4dB2t+M479FbZ4b7dEeWUjUudCo5gtN6fcQj2c9gN6
 a9WmNd8LQKez4PmDVywLFrNLpAjvjlDxE5hAjTl6GBcjvfkPnuD9MzJ+ohyMvegImfqP
 092A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742837620; x=1743442420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8Yc/dhSE0ffsz72PLz0Y9k0WgG7syZhZW08fMlCfjA=;
 b=uHaKzn9SRBVMHAHx97TdtJvPXB3ISBjHtNy5hxqRs61lq5CknJTRfSe1iEqm+GXynz
 XcQUz36MWeZMBJsBlcU8h3fyOU+lEo0k2lU/LhXtxdJKoXTZ0ipLkTxKMTmAFHZjDo2a
 luKGJdhqtVJRWFJGjN3be+DZjU3zW7pJq7K19nblokP3WfzLbRK1FNfeacGuD5DiRJ3t
 ZWoDyOflJnrjjwvIl9f8IQFEUEAQFcW1tfmSl0Z4D92scGg+Bw0NFD426C4BCHZnhRFy
 qchD9gBfX3mBCA4mSQ2x0DNaQ4G5fLN0m803+yRVmntGULzSsOLO/rd2EElT1HWx92SZ
 tfFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6UQvMDP5rzP9uh4IcB09vpbi88XH2OOgCMAIGLfJ842efJ0DSERdnkRwzSKDpdCzTVLOqYe0=@lists.denx.de
X-Gm-Message-State: AOJu0YyN+KY2n8qK+DocYbCravkEjz9qaxZp37CBc/Rr+eFwTxHKa/nu
 v4e1Klnc2s+2gOpOKVcztIOwduseHIIT4kWixXuCtKTotOqjrrYlFLI4rgO+92Vmb7HOvv9nUeN
 X066+1uXplkr2IivCv/ZQjLWN1sdJfWbI9aZ7qQ==
X-Gm-Gg: ASbGnctRcP8FXH4ajJzmRM/hmIEN62EojA0mW0nZwozXTDtvUWut/GDnwqUKJbAMShN
 lODO0aKJL2HhiaV5Czcl2oPfem7D4oTEFEr+ta4LVIn7MESRZ/z1/ofYqjOLIr1V4W0AU6lB7Pc
 bPl+55Ixn3sFEmG/EQMiemMyvhUQ==
X-Google-Smtp-Source: AGHT+IFVniUgjC7UtEBFc6k6jDQqKbuGC7rMYrIXhUBFONlz+WWQL54WeIpjMtdsw4WnMnwzq748LJ/yU9Vy0ZFmvU0=
X-Received: by 2002:a05:651c:210c:b0:30b:c980:c5b5 with SMTP id
 38308e7fff4ca-30d7e1ff66cmr53492991fa.5.1742837620260; Mon, 24 Mar 2025
 10:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
 <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de> <87v7rypcoy.fsf@baylibre.com>
In-Reply-To: <87v7rypcoy.fsf@baylibre.com>
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 24 Mar 2025 18:33:35 +0100
X-Gm-Features: AQ5f1JoqggvKL5D8M-ex3KGYdVOIovcVVoHjI4I4yZWf0uAu9QFATFcxgL96Y_c
Message-ID: <CA+GyqeaFbV3BM-1YFW4iJ3nYSL5jXfRS+_Gg7AEUg9d1yxjSjA@mail.gmail.com>
Subject: Re: usb:composite: data abort on second ums launch
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Mar 2025 01:35:45 +0100
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

On Mon, Mar 24, 2025 at 6:21=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
> I've tried to reproduce this on master (2025.04-rc4-g244e61fbb7f5) and I
> don't reproduce this with the VIM3 board using khadas-vim3_android_ab_def=
config:
>
> I'll try to understand why it's behaving differently between the
> sam9x60-curiosity and the vim3.

Thank you for your test, I think it's because VIM3 is a large SoC with
plenty of RAM
(SYS_MALLOC_LEN=3D0x08000000) while SAM9X60 is much smaller
(SYS_MALLOC_LEN=3D0x81000).

Each time when ums is called 2*FSG_BUFLEN, 256kB buffer is allocated
and it seems not
freed as fsg_common_release() is not called.

Zixun
