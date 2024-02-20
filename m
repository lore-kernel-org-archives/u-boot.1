Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFBAC48BF8
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 03:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CCFE87CF9;
	Tue, 20 Feb 2024 04:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EHNMZTYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36CC087FBC; Tue, 20 Feb 2024 03:53:59 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A18D287FAB
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 03:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so47250075ad.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 18:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708397453; x=1709002253; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKaC9I41IZROVNeU84rU4Fo3pNHCzCofXueyKxI+jK0=;
 b=EHNMZTYDebSi3Uom3YN0PAKPSpmoHlYwJzpIJAlsKs/pXy7M7Ll+WEKqC8w/daoyA+
 E1Ere4ExNlz7KpB5NxHwQy4oWsj2PVacEOT+YUKeuMGgQND+MEGTMhJ3VD9sTo/LgPBO
 tx0ST+V1K2S7wIZx8JN/CIihnFn0fn57fULQt9eNBLZOzQkjYhuS+GWxtbzV/4vbBkF/
 lX3dRN3v6/IcPu/zjwS4m886rCdZQWyOtvON2VaLPcHqhnzuCwlm8DGGxRFB38c4eB3d
 pujFETqKIUZFY0l4DDIDsIMyiM1RnmHLuk3l3t1S53DIK8xRROQju90aPtgGchG0fXUS
 aPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708397453; x=1709002253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKaC9I41IZROVNeU84rU4Fo3pNHCzCofXueyKxI+jK0=;
 b=VEXLctRRwOTmCA6HekciOE9LAi+/Macnm4cKcSb4ET/PjKj9ErTaasHbnq1omut18l
 MoloiF6VPbScz//ES9L9Tn7An4V5+rrFcKmTGIKk5mcg6NsVdPFW8WQ6ooTyyfMRyoIh
 bw4+XM4dBMT20oYVhKW4tX/6d3Bn0N3UIdbIq2ndbg4CjWOSvkD+5rguTWVLtfWyvI5U
 4NlHYX2GANNnjlIrNFe3f9tnEW4chYRXHbNVjTWtMB2Tc7qglbkRfOwPg+zvmwdaHQwe
 Siz5amSowuB5utTFX1gRKzr/D83K/6J4npdc0ShZm5bTAjPI6X9O3BGrJ6PNRh4SMcQy
 o5fg==
X-Gm-Message-State: AOJu0YyMJE/CTgXVYIvDJeL63fqY3wljCmk8rY2o6f4kTvNyT6sUWShQ
 OqhwO4/wD6emYzPcqw1F/PaJPkImxem6dXdCJhBubKZXgUZypur2gBGSQzq8cd1/id6OyUN/q9U
 6ZoL+ov1kfQdZa/lVO7vkzHYVLpLyfaRd/3E=
X-Google-Smtp-Source: AGHT+IG6TRzgFzwwNbohOu8JeHKZ9Foe9pPw4R6aC9SlmxapACHrkHXh9ijdfLsBNeyqaDrEh1rpk+XKDtlny5OP5ig=
X-Received: by 2002:a17:90b:2251:b0:299:3723:178c with SMTP id
 hk17-20020a17090b225100b002993723178cmr6773383pjb.40.1708397452756; Mon, 19
 Feb 2024 18:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
 <CAOMZO5B+eZhJOifRiux0n8VXLkQgwc8Q8215ybJgJ-LHE8RAAQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B+eZhJOifRiux0n8VXLkQgwc8Q8215ybJgJ-LHE8RAAQ@mail.gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Mon, 19 Feb 2024 21:50:16 -0500
Message-ID: <CAJFTR8Tjk8b-DZGxu2f4-LBoZdSqE5oDvyTY-DDOJYUU=DSvcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Fabio Estevam <festevam@gmail.com>
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

On Mon, Feb 19, 2024 at 7:53=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Mon, Feb 19, 2024 at 8:01=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.=
com> wrote:
> >
> > Add support for booting the imxrt1050-evk from spi.
> > Add imximage config and the ability for SPL to boot from NOR.
> > Enable binman in Kconfig and device tree for imxrt* as it is used to
> > prepend fspi_header.bin to SPL and u-boot.img.
> >
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>
> I see the following warning when applying this series:
>
> $ git am v4-1-2-imx-imxrt1050-evk-Add-support-for-SPI-flash-booting.patch
> Applying: imx: imxrt1050-evk: Add support for SPI flash booting
> .git/rebase-apply/patch:175: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: imx: imxrt1050-evk: Add documentation for SPI boot
>

Sorry, I somehow added an extra line at the end of
`board/freescale/imxrt1050-evk/imximage-nor.cfg`.
Do you want a v5...
or `sed -i -z 's/\n\n$/\n/'
board/freescale/imxrt1050-evk/imximage-nor.cfg && git commit -a
--amend --no-edit`

> checkpatch also complains:
>
> CHECK: From:/Signed-off-by: email comments mismatch: 'From: Jesse
> Taube <mr.bossman075@gmail.com>' !=3D 'Signed-off-by: Jesse Taube
> <Mr.Bossman075@gmail.com>'

Huh, this is very interesting and I haven't noticed before.
When sending git send-email lowercases my email.
It seems like all my commits are like this.
Do you want this fixed?
