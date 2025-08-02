Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B600C87FD2
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 05:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A61BF83B5F;
	Sat,  2 Aug 2025 07:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GqwJQg02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCBC83C01; Sat,  2 Aug 2025 07:10:17 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C905A83B5F
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 07:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso2058469f8f.1
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 22:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754111415; x=1754716215; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiZSVDCXeug0OGUK4TkD0Ph9vgObYvEhyLm3EyH5IKk=;
 b=GqwJQg02NqaM2Vf7xxH0tHnLHO2Zog3ltHRhXV/1H4cKdmikmZ8OewoXmU29mrO6tE
 ztF0k9bm3ofxTzB8V3/bYbVbt0UqX2CVY2dI14bkB970pXkSd7DZu896XX1p8wBQ8PJk
 RdHBjHsx7fjGZb0WkmD3Zrdo/+DMAahmDXeFmOfnJTNUDbg4043fMQZDBAMO0BHNeusi
 I45v+EhXZxjk/RTZFcaR4uMKeFXVHhnYXbh2MTpah9HZqHK78yV/6IekyzAcJ4/iH9CB
 F3QqPTWsnFFXtNZBJcyGFypprtfWdREgzuk1VAUWwgF9zpB4MjXN0lqdwg6yCb+vIYfJ
 Mrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754111415; x=1754716215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiZSVDCXeug0OGUK4TkD0Ph9vgObYvEhyLm3EyH5IKk=;
 b=OXTgGTLkHIKwkVWHE67u4y7MVxJguibKP3kkB7EXPoT/SNyCmyP7j8j5lL2GGsF8MF
 BxS0grUIeDppK+DGnePYNd1NjDsmlLyntrB0NAb6Ho27FmPjctf/q2I33B+X2KU4t+6i
 AsSSGwcmqEeXpIYj62wgDmraHle4T8xtPptV7P5/euDpSgDtVPGE5kES6Csb/f2JhC2U
 2As5tY+KytycRPdYR3f90Fn+slPNa8de240/xPVbA7Y0PVqh+zt/fuL6uZF+mQsWz9u+
 xY2rnYqWULUH6aSywfu9O3H1fe27m5aY1S3cWboF4EsnU60XruAV791jH6274zMFo9Ls
 gg5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrwfKfAhOSFU4iI4WPLK4t52QX+QAkA7zG/GC78pAKJU779MSO7nLMhdVXV9a3j0US+9R5CM4=@lists.denx.de
X-Gm-Message-State: AOJu0YyqvjJ9JmycsY/Zi+nbnJLe2c2HAyS0MzAMJf0Bq/Z09H59hxNQ
 fas/pJz/DZCbJEuHhxyqZ+t+zqq0mZVppPUt8w4Oe7aiWYpmnAzUe8HDwdhAlsUGiMLXj+pKgiE
 f3hPS3EyrAvxdiy2SnreZSg1yDltoiZp/vIyz
X-Gm-Gg: ASbGncvhgYCI/6AZkP6xSHijO+TOnynuIw4vVUx4oZPMm5OCtYKOlxU5hPHwz/9EZ3S
 Ghg7k1TqnCL4uQ79LAga/YnScLyQKf4RK+sZXrDohQPkw7gUvVGy7IBeDWAdytFIGkF1dzd5yCG
 /+G48eAyle7mPXoJ5864gZQ4lE1+FXVrWBOeR+vNX/VIjyucoe5JJEzmwCQzQqU0I8fcxJEGfOD
 l+2+nEZkvSffgX+ZIg=
X-Google-Smtp-Source: AGHT+IFQ2GhgvhnWRp9mHTAZzooxhwwsA0BRxjEyTddJYi/A4kd0jd1LvlCqgKMY2HlSIiOk6xD0mIvFCrPw6wlfPNM=
X-Received: by 2002:a5d:64ed:0:b0:3b7:590d:ac7d with SMTP id
 ffacd0b85a97d-3b8d9561d86mr1629508f8f.1.1754111415172; Fri, 01 Aug 2025
 22:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250731193656.286806-1-ion@agorria.com>
 <20250731193656.286806-3-ion@agorria.com>
In-Reply-To: <20250731193656.286806-3-ion@agorria.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 2 Aug 2025 08:10:03 +0300
X-Gm-Features: Ac12FXwQJOQ8tJmJr9-ruasnIrvM7KAENEX2ixHilfTkHKlgTPunIXw6kDg2j0I
Message-ID: <CAPVz0n0-3gU7V-_-LpVh6oDuRvvP4ktWikVLzibbd=H20FyiTA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] video: panel: add Sony L4F00430T01 panel driver
To: Ion Agorria <ion@agorria.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=87=D1=82, 31 =D0=BB=D0=B8=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 22:37 Ion =
Agorria <ion@agorria.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Sony L4F00430T01 LCD module is found in Samsung Galaxy R. The panel has a
> WVGA resolution (480x800) and is setup over SPI, video data comes from RG=
B.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> ---
>  drivers/video/Kconfig            |   9 ++
>  drivers/video/Makefile           |   1 +
>  drivers/video/sony-l4f00430t01.c | 210 +++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+)
>  create mode 100644 drivers/video/sony-l4f00430t01.c
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
