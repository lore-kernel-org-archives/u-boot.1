Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AADC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FCCC8782F;
	Wed, 13 Dec 2023 17:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hgp/S3k3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591DB8782F; Wed, 13 Dec 2023 17:26:26 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1872877E2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ceccf6d88fso973877b3a.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484782; x=1703089582; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOol0FgkpcJxPxZGqtmcaeTk3Ir652hMQBNEl6SPk+I=;
 b=hgp/S3k352PGujcTUF/Nqd7q4IQMcYJkJ0tAlPB/JlVZTJIal/h2cM8eJPH4p7SxiO
 SHUtNoGzeh7kmRssaG6dQh+mJQZycgXOz2JBtBfVLJTSF6cNBVwBtxmCpzmWNX26pbM3
 To9172XizSfxiFpeaE7Ls6QJi3jgACoqvM/l4BK+ThgT2lhEvX/gJD+y8f8XxLh5iU+0
 UxEK1L69OnYSspMQc5frBD0AAt+6PcpGi/9fif5+6HRhkaV/rs2REhfzct0T9i8nNkt3
 XZGI000GZiCCpAQMw2lViq/jyn8zvdUSWg0dl++GbYizF/VZO2QRWn0hKU86wn69Z+sm
 Ig6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484782; x=1703089582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOol0FgkpcJxPxZGqtmcaeTk3Ir652hMQBNEl6SPk+I=;
 b=M2G9ZQzN/Updb3dQ3kcyW0oHgXLRuej4rTfGWYHRTyBqSWCZTB6RTXdjo0b1DF/k79
 g9+05Kf37lqTePtVhzW4RBVxkPE68aB2X4sELiRA62npz39+xv/yEjpZgddLVJ+qJFkx
 cmvWRtw0V9O1DKZelhg4Gb4Rma9iMJxrpISUr12M7FCHeD1aOlaEpRA9hPa5Rww0uSqV
 /9VP1JKGKaBEp1Tgq2a5QfyP5oP2AnQO4nwORJjb56TjRR8HZ+E7eYY91ND5QO9Do9Xg
 2I+rFOL3nTAZjdXc1VCe69nuoE24KDR8GhAL7NINUfETHSy3ru66tD9DdAa9qWiBTq9u
 OvHg==
X-Gm-Message-State: AOJu0YxVdk3pPcsXAN3kwIlxhfApOv1Uxah3NkuLGw/Di7yMfZRUiLny
 nXn1NayowojJG4FDD9Pzis6CjanCMwbuCbuQbTk=
X-Google-Smtp-Source: AGHT+IEaXBFmEEu2zeTztGvqgCcb5VBkcWHP4Se0aDwlRP0nWCvIfMVZh17o/smDsSFv8aRWT7jQVkFTfomMvtxGvC4=
X-Received: by 2002:a05:6a00:1254:b0:6bc:ff89:a2fc with SMTP id
 u20-20020a056a00125400b006bcff89a2fcmr17511111pfi.2.1702484781915; Wed, 13
 Dec 2023 08:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20231018183352.2168191-1-tharvey@gateworks.com>
In-Reply-To: <20231018183352.2168191-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:26:09 -0300
Message-ID: <CAOMZO5Cb0E7TXd_kg=w5ee6LRnozR9BC79uX1R+0LfG7PYegvw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mp-venice-gw73xx: add TPM device
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Wed, Oct 18, 2023 at 3:33=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add the TPM device found on the GW73xx revision F PCB.
>
> This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx next, thanks.
