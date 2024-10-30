Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B09D5CCA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE3488FAB;
	Wed, 30 Oct 2024 14:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FYcMwp6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317DE891F8; Wed, 30 Oct 2024 11:33:48 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43BD890AE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 11:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6ea15a72087so25948607b3.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1730284424; x=1730889224;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nHFHL+yh0ghY8Jnvo30o7uW2WpaN/45SGY7zNK1fSA=;
 b=FYcMwp6nkrx4UlRzpc4A6VjeFmIWn8UJxSeKtXm2NYZKLQwR13fIp0ie4AjnwCN8hl
 Imr02dVwSV0AxpZYRWqkwAmirddPgkKFsECQufij7hVkaswpdu+Ow4iLRd2xrr6nsUZe
 oQTzi7KaOdaUL1TbTBFL/sP0X9E//PpXNQx4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730284424; x=1730889224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0nHFHL+yh0ghY8Jnvo30o7uW2WpaN/45SGY7zNK1fSA=;
 b=u53smLdTSotcCpVV/nRkWXYBi38WrJWp8vakKOR6Kx0LsAl+SFFjC0QKxnC6Hqe/Gw
 PhwRGsvK4IboeG2HZcD8RR8Yka7ATErFQkgCt9py3dIa7XrY1zhZFK0jHP1sJ9OVUU06
 yGOiZadTi3vy00u7Kc321J50ploSYvRVSJfcuyU4u4rQwN+dZ6zscZZJPpoxuLnE5GKt
 5k4HBzSDXX3GifQ2Y9DuMLAZD7BD4gjaZFqouO5wdK3yaGuUTkEYdnnt61trTKZbtHZl
 vsn8v+dqXCp7SSACI4cTOcpuOY3DMaGS1cj1iIHZMHZmcVriS/GfngrnmRgxqnZvaVl/
 Pd0g==
X-Gm-Message-State: AOJu0YwkGvgb6uNeXPM4GHa0mxzeLPdu+39U4IGv/EyTHHKEKSqVRqS2
 ImCTzFdkmp5oF4tqR9nRKFEvN+o+ZluJIPICCH0sCvGR/lHv8bp/3ze/DfpBfAjn/yA6NY6nXVr
 Zg47/2uZXQHw0wYIrEsk1StlrKT0EscuKqQD8nXCLBSZkAGMlGSk=
X-Google-Smtp-Source: AGHT+IGoTHZE8RPPt1Yff40nueyu+POcqJ/m8R9pocAMfcKuKaRY82ev+KFHNWU3WjiAmA38kflryqvHLn+KuymdZN4=
X-Received: by 2002:a05:690c:6a0a:b0:6e3:dc4a:34b0 with SMTP id
 00721157ae682-6e9d89947b6mr137174347b3.22.1730284424601; Wed, 30 Oct 2024
 03:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 30 Oct 2024 16:03:33 +0530
Message-ID: <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 30 Oct 2024 14:17:52 +0100
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

Hi Marek,

On Sun, Oct 27, 2024 at 1:48=E2=80=AFAM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Remove undocumented nor->addr_width =3D=3D 3 test. This was added in comm=
it
> 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
> without any explanation in the commit message. Remove it.
>
> This also has a bad side-effect which breaks READ operation of every SPI =
NOR
> which does not use addr_width =3D=3D 3, e.g. s25fs512s does not work at a=
ll. This
> is because if addr_width !=3D 3, rem_bank_len is always 0, and if rem_ban=
k_len
> is 0, then read_len is 0 and if read_len is 0, then the spi_nor_read() re=
turns
> -EIO.
>
> Basic reproducer is as follows:
> "
> =3D> sf probe ; sf read 0x50000000 0 0x10000
> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, tota=
l 64 MiB
> device 0 offset 0x0, size 0x10000
> SF: 65536 bytes @ 0x0 Read: ERROR -5
> "
>
> Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories sup=
port")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Pratyush Yadav <p.yadav@ti.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---

Is this patch-set next version for 'previous' reverted series?

Jagan.
