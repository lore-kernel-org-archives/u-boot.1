Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E4EC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 12:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 777B287BF9;
	Sat, 20 Jan 2024 13:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ACifcZTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E57E87BC9; Sat, 20 Jan 2024 13:15:32 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7FE87C9A
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 13:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2904c81f26eso160511a91.1
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 04:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705752928; x=1706357728; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDmOktWnRg7mikqYDJlABKRVd36FpSGAgWuiz8RLouE=;
 b=ACifcZTN6lQ10fuNte+Zuy6D3J09rEEczi2a0KZGoEaRoz8y00arUJcB8qAy6AS/yr
 7IjgXM+FBunQ7tKsU1tmRog8UN1T5L3VkKa5kFpdBma1F0qNAEBKONPfFIUbMdj0d7O4
 71ACH+DAftgb9S8L1di8RP86mCDWnGZ9YWUiB9gOXN523oX6Av2GsEfdZ0krHLPL10Hg
 YZe6X0zxLSINHgw5Xkr7PdEAod66r/oKPT3qdjSe/7P4Hj46En3UZGlY4nqMz2hoJT62
 KWOyUpeYSBJAG14QDTzTQ5tLBS3Upg/tvp3sEtEm5VwB8o8G7ukucGnC7nePC7n8w781
 fHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705752928; x=1706357728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDmOktWnRg7mikqYDJlABKRVd36FpSGAgWuiz8RLouE=;
 b=XWU8HV2/MMqkLB2khTm93kHrRBMpUCBPJR6CM9giBzqmBuOwRZcB4V14YzIB8xEmHU
 a+UbGTFIckedgSFAMJgGFovj0fnSUzZ2PMXzcEzwJgkuMgxKRF7l0+xF3BazFuc9OlrS
 1wOA2JdqSbXqugipPBbsNnwsH3ZdYH9cZjFIOCOyTBa0zaYQQbc4tgW9CY/Nf6aLYrTo
 bvBFlPWY+VvZnEIzguTHTkpH9QlhieyKu59NzmbSWtj6D+/j0VqhGqMip7w8NOz4hZ5m
 PJQQvX9jwD+Se7OQGowNIxzjKJuMjh8nCEV4ejWX5d7o2raB/gR74AGcJHfyzZ/zaJAr
 Gkog==
X-Gm-Message-State: AOJu0YwFQgdxn6LlDytWY8CoZmUBvYVz9Bg4HP0xHyqukxmE83JdwG4a
 bKS/hkRI1W3glUmDBlQbV8BHvdPkFc+Zom3v2tptWeF8dSMSIoOn3aJraIJujhYXxG6Ku0IMy0O
 b5po7LaC6nmi7VIZKIE9MdtNdzTUuCf2L
X-Google-Smtp-Source: AGHT+IE23+eIWK1w/S0YssfXtMwH5wc8H6v5qPZ9C8mfxFTS5gI5kkUK/0NN6SV0glhwF8SzxtA6VcC8hOVi1T4dVd4=
X-Received: by 2002:a17:90b:3443:b0:290:4cc1:5051 with SMTP id
 lj3-20020a17090b344300b002904cc15051mr1799415pjb.2.1705752928376; Sat, 20 Jan
 2024 04:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20240119160814.11387-1-marex@denx.de>
In-Reply-To: <20240119160814.11387-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Jan 2024 09:15:16 -0300
Message-ID: <CAOMZO5AbM1OaF-Bvf5a4qwwvvnVDLhSgb+RU4rDtDc-GCHiSwA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx: Enable SPL_BOARD_INIT on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>
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

On Fri, Jan 19, 2024 at 1:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The CONFIG_SPL_BOARD_INIT lets SPL common code call spl_board_init()
> during the SPL start up. On this particular system, spl_board_init()
> is used to reconfigure GIC clock parent to PLL2 500M, which is the
> configuration expected by the Linux kernel. Enable SPL_BOARD_INIT .
>
> Set GIC clock to 500 MHz for OD VDD_SOC. Kernel driver does not
> allow to change it. Should set the clock after PMIC setting done.
> Default is 400 MHz (system_pll1_800m with div =3D 2) set by ROM for
> ND VDD_SOC.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@denx.de>
