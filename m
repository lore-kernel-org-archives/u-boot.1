Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9ABC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 19:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBD288335;
	Tue, 18 Jun 2024 21:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b3qXOKlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1640A882DF; Tue, 18 Jun 2024 21:35:31 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A9688335
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 21:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c2c1473f73so843024a91.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718739326; x=1719344126; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gE/r+WfnY+QAd+5/jzuFP4gTsG8i4Aqc0e3Dn5n61EY=;
 b=b3qXOKlwZIwuuESkWmZ7bZOSZBUfFvFU75TPpEhhMKyWKLAjni03t1wIHftmulbTsB
 0r51PH+/36bcmqZClmLMzW/Wy7C+oeWRQYFVe7GnjuESpkVHRETFqahNwzvAsFi6775L
 y+p+DlOcwmCK2rFxwpA3HPsAg8sh9j+xVSOZ+rfDSS1xucYw3V1jmpZWjFXIvmzffl3z
 AvtFsszCQ3hrh6Nswt/7cWaGKbwPVZtSmwRNG1dqijqKyBPjaALDjaWeJrp/iwMXZ3gb
 Cc2vZ3Rl3LbOxLeOq2Jd8pF3QGyf+2rpbPs2vjXI5N4x60X68CSIldypFuP7h/jcMBSO
 Jj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718739326; x=1719344126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gE/r+WfnY+QAd+5/jzuFP4gTsG8i4Aqc0e3Dn5n61EY=;
 b=LGIbcL6PCgdPSINtA3zw1SVTM5N/KXjdxnen3Nd4rG/ptT3JaNJ9FBj37TwOn/bwcM
 ALy15y2TIHGF5/BCjXxUPSpdJCGjDgujtX0P7xK7ZrVEHu0UOOZmcnKDqR+W0fAJWI66
 qquSsGvGxU7N5pJ3YDfe3fYPRvxUCYvByjDUWjDWu0zE5fIQjMc+k5b8je8wzYRiKiDw
 Yk2Mnp57ErZMfFyw14GTGsHECqdYUmjvFfmXFHEDKuJ75R+//Dmg0rOL4BEmb+9d5G+5
 1CB5NyX39/SQIpfuT/F3CET/SyvY7LUzlI20x8xYn2IjJ4vvI/kHbOh733VDDQ3Q6PdG
 NVkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+nePYGvcjBLOeLD8AkmrbTWYLOaeOf4pVzXvvi+XTjV/4HWdknXB24kEj8WE+WO6+Qk1KFgPtkCy2z+Vxpv6Ttx6DyQ==
X-Gm-Message-State: AOJu0YzZLJngA4+UjfHf6PlWwDabrdhyeIuZ62ITDZ7qCajn8cEF3FKP
 TDurx5HADSmvJZI+iN9tZaZzakyGeY44mVh4851dqfrwiq3gHvxc3JDjhV73LungNcNFfGBarLg
 0A8qD3ydrTFENnYECjLIjQ3qIdPc=
X-Google-Smtp-Source: AGHT+IHjGFsVnkMxuCBJz7ho2lKpTCe2LqLZmP0NjmjFemYLBJimFD8l5+ZYrOm7NOBNUZYS/Gicsc0j6oeYOuUljW4=
X-Received: by 2002:a17:90a:fa01:b0:2c4:d63b:cdf with SMTP id
 98e67ed59e1d1-2c7b5c83afcmr652716a91.1.1718739326136; Tue, 18 Jun 2024
 12:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240617191416.1351790-1-tharvey@gateworks.com>
 <20240617191416.1351790-5-tharvey@gateworks.com>
 <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
 <CAJ+vNU3rtrGkL3gQwEZW0x=ivSPqv-jxsdUX59bCcYRofe7Wxw@mail.gmail.com>
 <CAJ+vNU2KH8NgFkjWt5ZPKMauPjhLXwd-oNfGFy-+QHO6MWKARA@mail.gmail.com>
 <CAJ+vNU02a0VASJzAghDpSWm6XuOseQj9T70eRn0bD9deiHo6dA@mail.gmail.com>
In-Reply-To: <CAJ+vNU02a0VASJzAghDpSWm6XuOseQj9T70eRn0bD9deiHo6dA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 18 Jun 2024 16:35:14 -0300
Message-ID: <CAOMZO5Cs6xWs-PvMq1u91n1Jmt8BDsZFMUwK8hCx1LWN3VPSzA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, u-boot@lists.denx.de, 
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

Hi Tim,

On Tue, Jun 18, 2024 at 4:30=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> This seems like something from test/dm/wdt.c and unrelated to my patchset=
.

Do you have this recent commit applied?

https://github.com/u-boot/u-boot/commit/1fd754cebd38d7456caa82bef15225cbe77=
960ec
