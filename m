Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08677C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF51686F1F;
	Thu, 26 Oct 2023 16:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UJOih9w+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEDA875F6; Thu, 26 Oct 2023 16:19:25 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA18686F12
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ba8eb7e581so211965b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698329960; x=1698934760; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUxlX5TRgzzCXKOBQPd2wNelqd4y/iG6tndJcqMGd2w=;
 b=UJOih9w+fytroiTXYUJtptlKmN0CDKd/J66EC27gTZWrxzuAf+m5VjUsHxv4Y0MC4D
 L00BG9KQhnAMUS48TMP/eoLsZrLtcfXY+GijD+HocGV24Z5EujcAFJfd2pD1+x67Rg/A
 kU/YTbZNkz+IUupikwTbrJ7vqFFDuMnyr/DcyGLLlgjWlPivlwjjTXpSIcrGrRWz5Moe
 3jXlpP60NeuIQtExBOYvaNt+TycXPAnecKGoa0r9cOStLWsj2Sj0oVtKYTrEfIDOnu7v
 bJXpqkpbIfWKOCEvSeTcJ1fA80EwKqjI7sMQTNg9p9cpvmQ5Qs83uK5QlQZiaVaXSFde
 2dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698329960; x=1698934760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUxlX5TRgzzCXKOBQPd2wNelqd4y/iG6tndJcqMGd2w=;
 b=MDVtPqMaBdnAC1GbDTLUS4vG3tzzzC3DGPtJEcWdEgpIXNOKGSgFW0S4AZTR+N7cTv
 0snId4oDT8l9suvRH3H3w4naWQeSZ+MCh7c50GW6PMSGoHw+0drnTmIv6cIE+azKgrT2
 ttlOtBtS0NL/WY1vdljZ4QPc4Ev68So3+TCXZj+/YS98pLRqzLuiPYiQMfg3QhWHWYU6
 X69lqCW9pzDLSTqQHmgJuQ2VC6Fbr6O9IeCRpiReoGDzTd3zZ+NcuTrZGd8X//WJStJp
 YBXhfXNtu97UbzDWi1hE+WFEzmR3vsZLPLY1+I1W4Yk6eF/i/q1J9WTpUsJDKKb0FL6k
 Gqkw==
X-Gm-Message-State: AOJu0YxSogumxL8mO8J83/dK0sGkGuqntUNbyMDP1yJW+L+HuvHlsImE
 IOD/G+ctM8+h4nNuS0Q2yNsjE4ucJV1hlr5wu6ivv9r8zdM=
X-Google-Smtp-Source: AGHT+IGx2hsjJHN0QVU2HUv64EwUQJbMBLfwU2vC2eyXdAE9wefs3Pci2Ug2MN2YgB0nnjEFkOCIlP8GqPsuxm8RZ0M=
X-Received: by 2002:a05:6a00:1a8f:b0:6be:cb8c:92c7 with SMTP id
 e15-20020a056a001a8f00b006becb8c92c7mr19755204pfv.3.1698329960227; Thu, 26
 Oct 2023 07:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
In-Reply-To: <20231026073220.244387-3-marcel@ziswiler.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:19:08 -0300
Message-ID: <CAOMZO5Di_OQ52vyB87oDLgaY_iHtqzqKq=L1yrS0AaqCzM0L_w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
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

On Thu, Oct 26, 2023 at 4:32=E2=80=AFAM Marcel Ziswiler <marcel@ziswiler.co=
m> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> This fixes a regression in the eMMC fast boot mode case where the buffer
> was missing 464 bytes.
>
> The code figures out how many bytes must at least be fetched to honor
> the current read, rounds that up to the ss->pagesize [which is a no-op
> in the USB download case because that has ->pagesize=3D=3D1], fetches tha=
t
> many bytes, but then recorded the original upper bound as the new end of
> the valid data. However, this did not take into account the rounding up
> to the ss->pagesize. Fix this by recording the actual bytes downloaded.
>
> Fixes: 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use of spl_load_s=
imple_fit() to get full FIT size")
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Thanks for testing mainline U-Boot and fixing it:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
