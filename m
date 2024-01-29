Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A33C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0AF87C37;
	Mon, 29 Jan 2024 13:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oRICBegf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62BDC87D18; Mon, 29 Jan 2024 13:13:38 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526C1876F8
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-602cf7dfeb1so23895087b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530415; x=1707135215;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMdOWVMhGF3f3jsNUAW5GtP9/pv+DAAfB18T9cer5wU=;
 b=oRICBegfbvKNxxS5iS33ATquuwY/PgFwWg4BZEidwaSQVE/r1Sys3UWHrEmufANOkg
 ZHFSC34TMti/vgGcyj52OKiu/eQInry+kVg1Zei23c+lG8hHP+RWZBfMi709lm07XtXc
 sxNQZ33AX/rc7x0WzsUXvmVq/Ok7OhBC3FNvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530415; x=1707135215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMdOWVMhGF3f3jsNUAW5GtP9/pv+DAAfB18T9cer5wU=;
 b=qNmE3DKPGRXW638BBD1T3TBYEHAREmJlTJYpKOTAXIPxj1B1enoV3Gzi45bZn9mGak
 LcENtKfFj0/wzJQzrA8Ek8R5GpaRQU/YUYk9ny1ZY8Rj3HigN/iLTeZkdRghzrV+lq8j
 QiZQ5ExohgcqyTCmigbSdmndYTy5+QSdAsC8mBbQfuZBB0gBZ2ilxplUjWkzcpuXshR0
 hc9nCq7yzJS0mZkHBT/C4Hbj103jLjofiMB9TwJuQ4gsagwY4fkLzZnj811SmRUt1tXP
 /BDkRJxuSrACwPc2MxeKTQybM3RPvOFZxozpfSKP8kVhEw7bCNpWkYTkpiNGDegjmww4
 RD1w==
X-Gm-Message-State: AOJu0Ywp6toZIkWSca9e1cB4ewj4Eo8GKxdvu7HjSOLMBSYhPlOhQow8
 cZv+n3lRZNANM0+8l192ECleUkbp/NsDas7lgu67vs3D8Ic/FMyqu3sT5uHTQwbhSGctDjwTKv8
 RPs2mXFwCGKMjfzLO/6ArUF5H6sjp1O2V6MX0qA==
X-Google-Smtp-Source: AGHT+IF9J9o8/Pu/ESVz9SROaP2rdku0k5MEl7xfL8FFKnKFHmHH0uvH4KGdzPYxNldbbmFPdG8qF5CEHJe4CyqDPHc=
X-Received: by 2002:a25:9004:0:b0:dc6:4c46:4362 with SMTP id
 s4-20020a259004000000b00dc64c464362mr2484832ybl.99.1706530415070; Mon, 29 Jan
 2024 04:13:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <f3fa3d21143b36b0f7993b5c731c885571136e5d.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <f3fa3d21143b36b0f7993b5c731c885571136e5d.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:43:24 +0530
Message-ID: <CAMty3ZAn-6ctVGX=Fm1vmfLmftQu0UokYW2MM7-S+wYTXgqJ+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] mtd: spi-nor-core: Rework spansion_read_any_reg()
 to support Octal DTR mode
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, d-gole@ti.com, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
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

On Fri, Dec 22, 2023 at 11:16=E2=80=AFAM <tkuw584924@gmail.com> wrote:
>
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> In Infineon multi-die package parts, we need to use Read Any Register op
> to read status register in 2nd or further die. Infineon S28HS02GT is
> dual-die package and supports Octal DTR interface. To support this,
> spansion_read_any_reg() needs to be reworked. Implementation is similar
> to existing read_sr() that already supports Octal DTR mode.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
