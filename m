Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C865BC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 557F182103;
	Mon, 28 Apr 2025 18:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hqzFaCg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831F58210E; Mon, 28 Apr 2025 18:10:30 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 784578056A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54e8e5d2cf0so3804570e87.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856628; x=1746461428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UHC4Z85uPLubRzlYNRwtWvp3EEUHpP9KZaLrp9xi/0=;
 b=hqzFaCg92WVPtor9yAaUi7h7D3IQLCoWXgsgpda5h3dedWzWDqTxFYtLoUDgWHwBqK
 HxWpjGFA8JTrxRC+ka77o1XH1tAn9Rr/urW5e2hDUkOPWuPuYjZYaBGMAjHH3qeEY835
 UV/9jqLE+R9Z5L7ui8EB5qyhBvsBr1sUb+7LkQW3uWWfhRAPsi38PbhRc9G1jnyzgiMf
 TEPg73Po4Xi8JYZ6ZaYTdSgXfaDhnAOpGXuvzwSjxwXIiyfPE+1BCKyi89B6qOqJOJem
 4p/UAebpH+EuR2CJmFLV6Qn8C8FZxOj3VfanqQOUao6GR+IPWcjVC3UHx/ycHKbCBoVL
 2rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856628; x=1746461428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UHC4Z85uPLubRzlYNRwtWvp3EEUHpP9KZaLrp9xi/0=;
 b=SRGcxZdYjKPkiUGYnBQQHwgQbj9ETd9FcTPYeEe+C15OzHXN7OInk1knYLvepS0CAr
 TmF/xF0cJ8fRQJTohfN2ifGxKlK1CYqZAOU0OLyJ+b0LNAYRBWLKiTX1LhTDGDp/vMkE
 sg0rQ3TTPQmtg9n3ZJJY9EdgrKayXnF1SFVDW4UD1sASIIMuWd2sWhcqh/aWOZmGW0qS
 nuhMb/lHZf8JAOMLA8M8XyhU3B2767e4aET4yq33RekEasHkML5k+aW/R6lIzA+CdjgT
 gR1/AClRDL84Uyi0Joq1rwUFHeGkAVGJsjygRjVGEpiniUxAxuztqT8j8XhDGP+nnusa
 ZF3g==
X-Gm-Message-State: AOJu0YztvypycMokb2xEgvmhEjguOuTm4yrSgbsKNQ9hEilfD4IE9g2t
 3DY9ZjFdkbwGQLo3gqCK2xGxbVlU+YziDKaigeFr0lyh1E5ycX4jB3m4xUoB7X+FOrtCFbexY/T
 9hGztIT1QqiBGu271R1Q8+JRwkcs=
X-Gm-Gg: ASbGncsI/YIvBnWGpYAnrzN+a9wIqLXORwKu+yKELAVhKSCIx6jhYd82ouQXeTWw2fQ
 aZ99oo/9a6dlhhum6YNIk5eBRfemuWCPsV1hxqWOmys3X99C3vo80qp7FXQLmDYfU3RHvkkZvCH
 8tEMaPtX4USien9KU+ZJjDyyvXy5ftPU5RQuhjUlbTCYHrU8Gx89CMCw==
X-Google-Smtp-Source: AGHT+IEHqF3ws9NYyoJ/vz+NUWoB29HnhRr9V7Ut43/qrvWhvpSzmCD2eTNKvQh1EX+JZyeAlmXxgfgPK7RNeDo/a20=
X-Received: by 2002:a05:6512:2215:b0:544:11cf:10c1 with SMTP id
 2adb3069b0e04-54e8ffdb59fmr2808204e87.30.1745856627121; Mon, 28 Apr 2025
 09:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250428052858.100083-1-hs@denx.de>
In-Reply-To: <20250428052858.100083-1-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 13:10:10 -0300
X-Gm-Features: ATxdqUHj_ySOqRCsVUojJQ8rhoNtW8R8jbyl-qpJlKCEtq50p8HpTqNVWiU31b0
Message-ID: <CAOMZO5Cdove2kqg4FiAZi1EFy5od=miX4jjou7p_d8zHNMG66A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Updates for the siemens cxg3 for 2025.07
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>,
 Walter Schweizer <walter.schweizer@siemens.com>
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

On Mon, Apr 28, 2025 at 2:29=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
>
> some small updates for the cxg3 board:
>
> - collect common Kconfig options in an include file, which
>   makes syncing downstream defconfig files easier
> - Move the U-Boot Environment setttings in a txt file
> - minor defconfig updates
> - remove now unused file include/configs/giedi.h
> - base is now
>   62ea9c329a0 - (origin/master, origin/HEAD) board: starfive: visionfive2=
: Order board detection logic to match config

Applied, thanks.
