Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F25CA100F
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 23:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B82832F9;
	Tue, 23 Sep 2025 01:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LgeUTt1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C889983390; Tue, 23 Sep 2025 01:04:55 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C221983211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 01:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-57e36125e8aso1579275e87.2
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758582293; x=1759187093; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIE9O8RuovSccJNxyH1UCjFSOHuXpHgZs9OxriSL31c=;
 b=LgeUTt1J+b2RcJlbDfaeURWvUsvdY3WS0iFK30PLD08opjs6RWUPt3ftv9QT0lFk60
 EJ3s5eBjLW6wwcTRNNP3F7nccIHEJHB9MNUp1BJydxts/Mf+4iKdKpWrswMpbNmcI5SB
 EQMADsEzg06lHHl90dqySfIZ0QAsXkCH4vkgF2G/vj0cLH66Ldab0yivWhfWhlF8C2gn
 mkvHezvUh7fkJVT0SnkL6yI2GXG8wT4UrZ17GIBTI3tf4J3ADFZpokyD4Hy2ZcfGlqaO
 RTHp7LTrIHaI3oP0G/mEFUS4g87QoMcgGm2yBmcr19vAoZqaEgrMtzYFyEfhPpGhuMfV
 MZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758582293; x=1759187093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIE9O8RuovSccJNxyH1UCjFSOHuXpHgZs9OxriSL31c=;
 b=N22rUK1+QzodrlyoPpqAZlUp7PlIwmCyQHcj66Ubo2KOKsCX6Ffvjo/aXWhx/DE5z1
 ybaYk1wHbuGhmuXYhx98q5ziLQS4ntcq5Tytqy+MNsTfZ2m+zLNQ7zEBMUJLVb1olkb7
 d9B7RNIixi1P6oVPoRN4IumoFgc80/W5ReuzmpHvqFh4WqHyWNut7LmpiH5EVCwSqcxZ
 YFX6XtD91dF6Te3G6/J2xaplnWhgacbZ1VhcznpeQEk7uFUrkZytBYjd3OpDOsevI1Di
 bNF8kBnPgr0q2Py8/cXEooeZquxU/N3yUp9N/fRAws+4Em+VHc3sbvctvCS/ASfWQJwd
 43Dg==
X-Gm-Message-State: AOJu0Yzz4oHnx8gFeynSSLvsp9NbPn+T6p1ZJL3B/6+fy/SQGR5N133R
 zumjFNC9f4wHyljsu3Ml5G2oTITfXGysjZkvBbwCvyO4zf80SNxNXRcECZ9GreCXkPDb/rrCMYS
 frzRrJYcK3/hU0PfbI623iwrAmsXcJrM=
X-Gm-Gg: ASbGncsd6VWlcQlBs5Ox5MPwfVHM9ufNxS7eL6nDIn4db6iIWTvi8MdHCg4x8M10P3e
 YW0b1MVvCY38cX46jCzVk/GFUiaIia9o9lnNOUnM7oWi7eFSq3zBosAO9HLSyaUJUIb4Op+T4/w
 goNI54lcDEUiIxTaDxJaTO3ral0z40Ad+ntZoFMiyGjjpTwWxdM8NUzd/sN6+smVRVp6Y+0LUTH
 nTmhnu71Rul9diDUYUyN1mTulNFl/0dM2krEwo=
X-Google-Smtp-Source: AGHT+IFEpDeTDLxvdhWTF/V6tudmwkpGhCgb4PUMxwutJO5j5/7X9JSdiwy3imvgW35y3FpOH9yXJ5INbtSj16srejE=
X-Received: by 2002:a05:6512:2210:b0:577:5ea7:1484 with SMTP id
 2adb3069b0e04-58070328f26mr85389e87.6.1758582292621; Mon, 22 Sep 2025
 16:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250922111143.1204915-1-ye.li@nxp.com>
In-Reply-To: <20250922111143.1204915-1-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 20:04:40 -0300
X-Gm-Features: AS18NWAl55zZ5QGC-v3aLuC8-zNrVmEhuFen7jpMLcr9MpVM71CQJRHlTdnsfG4
Message-ID: <CAOMZO5C2u-bn5jET1QMrg7yg=FLSgfEGchUvwEhyNY-W=cDEMA@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: nxp_fspi: Use second last LUT entry for AHB read
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, peng.fan@nxp.com, 
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
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

Hi Ye Li,

On Mon, Sep 22, 2025 at 8:12=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> Use a dedicated LUT (second last) for AHB read command, so we can
> directly read from the AHB memory-mapped address and booting M core
> for XIP on Flexspi NOR.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

As Tom pointed out in other patches you submitted, please make sure to
run checkpatch on all the submissions:

CHECK: Alignment should match open parenthesis
#156: FILE: drivers/spi/nxp_fspi.c:543:
+ if (op->data.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_IN &&
+ op->addr.nbytes) {

total: 0 errors, 0 warnings, 1 checks, 27 lines checked

Please fix and submit a v2.
