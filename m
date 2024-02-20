Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B0CC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 00:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CA3887F16;
	Tue, 20 Feb 2024 01:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZO0p/txh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF84487F16; Tue, 20 Feb 2024 01:53:34 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F9C87F63
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 01:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso1491999a12.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 16:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708390381; x=1708995181; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvzjHQMa11M/lgylxYi0DBM/rzjPIydEeemFqDnxygU=;
 b=ZO0p/txhuklxBUknIVO8s4jzE1MAm73yX4RxMiA1kjuz+0ATxu1S+RaiJ1O3fPsZCy
 8Mmo1XscxdhL6zGCIvU4HhbsONYm7MdwxznmoJVbV2stL3MBt2z92j6sdaDU9DBPaWH/
 12i1fUvwApkPLqhJo6OLVCnfXm2NXSWmGE/NP+sNJLHx5djcdowER7PjbfdoCC2tzVtx
 5dzAHEVaS7l5Xo3W6FwhR6GeYgfD4B2Hrs9bwQ7zh97bKQn9Wv4imM8Dk3QoDgfOfP4l
 pZesaUze0uJdSlc3fKA40R0GeB5gOzj+NlLoebRWSkzIqbZd2VydBroujNNXSKd3RYd8
 H3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708390381; x=1708995181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvzjHQMa11M/lgylxYi0DBM/rzjPIydEeemFqDnxygU=;
 b=b9xYCozDONWYH5pLrp/AGgMHF/KB7u4v+TkNUMbfVveU6cXqEmbus3UEhgL4R7r+aN
 0K0MvrcFIvXwWNpsLiyu53WdTV98l1/0ZjJJuoUYhzXucjb3ybscrhQqCqlA64LoQPlY
 e+cGnv1hacA+qw4TyMcCuIPjhbA+1ElEuLEN4rzZfYiT5xoq4pPm0SF/A3ht4XanCZIC
 ArTtIw+brxnvOev5lQXeF25Rh4b5/MnwmcxWexyufp7YFLRB35RO8bPCnmdAyC0RzNNV
 shn6LGlOp8xGt4c7/sfeQemVlf2luZ3vToXzTO3emplZUZR5dFxRTTT4QXIdxdsXGwEG
 txdA==
X-Gm-Message-State: AOJu0YxFCUlOpNPomuSma67v0wRWexfjqNea9+jV3gZ9MjSX+kgK21Gd
 2R2IKM/7bI/rNKsMMuZYUkZmOZgc9ZrPLgdnjoADRAHQDb/RnseWCPoqVU5clcoKqlNWhu0lkRq
 2QEfuhKUBu3TTVSx2g9/skrDMaho=
X-Google-Smtp-Source: AGHT+IGJ6pnVYg1lvpgEHK1ec+yZwlmFQoMCdGpdsB+bgmalWoEQ0bYn9YPNWFohPAnV4lMrJ6bWUudu5Axid/mQoow=
X-Received: by 2002:a05:6a20:2587:b0:1a0:b3b6:e2c9 with SMTP id
 k7-20020a056a20258700b001a0b3b6e2c9mr800863pzd.5.1708390380689; Mon, 19 Feb
 2024 16:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 21:52:50 -0300
Message-ID: <CAOMZO5B+eZhJOifRiux0n8VXLkQgwc8Q8215ybJgJ-LHE8RAAQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Mon, Feb 19, 2024 at 8:01=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:
>
> Add support for booting the imxrt1050-evk from spi.
> Add imximage config and the ability for SPL to boot from NOR.
> Enable binman in Kconfig and device tree for imxrt* as it is used to
> prepend fspi_header.bin to SPL and u-boot.img.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

I see the following warning when applying this series:

$ git am v4-1-2-imx-imxrt1050-evk-Add-support-for-SPI-flash-booting.patch
Applying: imx: imxrt1050-evk: Add support for SPI flash booting
.git/rebase-apply/patch:175: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: imx: imxrt1050-evk: Add documentation for SPI boot

checkpatch also complains:

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Jesse
Taube <mr.bossman075@gmail.com>' !=3D 'Signed-off-by: Jesse Taube
<Mr.Bossman075@gmail.com>'
