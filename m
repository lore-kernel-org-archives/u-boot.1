Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7A1C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0058C87C6A;
	Fri, 15 Dec 2023 19:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EDXs9JYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44EA87C63; Fri, 15 Dec 2023 19:41:09 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755E887C6A
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28b18920659so93495a91.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702665666; x=1703270466; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DF39FZOOKmtV07JkUrkdDBkUNENG7uXP6hHUIar/RMs=;
 b=EDXs9JYODZWvm0xiEXyYj+awdAuZGEgC/CjddXroc8JxoYRouBVZjRA7bGuJ1xSsfl
 qVTjJWtoEHyIvztZ6HRFJGqIqdNRngINCa+wXNv/L3ds+w6Z3mO1W4DWILegWxel98Kh
 oOYMjrnqGrc1Y370mcLePLdmRq1wzR9fM2BXRQ4TA8ifhKcxlJSy4kvvdpdBEBETqStD
 3PRFUFR6FLPEmHQwljhSXccmDUU7qiPVs3lX+3Z3rGoxUBLxonCJgGLGNQcGJ/+ZRKD4
 aCUe8IdM3dUrKsHprTjFqbV1lGjYKhFZXLxUoKz/RgemCB8yOq96tsDIDNEiI0WFxCEZ
 ToKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702665666; x=1703270466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DF39FZOOKmtV07JkUrkdDBkUNENG7uXP6hHUIar/RMs=;
 b=CqpSpW7lo1iVIXA5gbJQ/6q4gBO5ysfehZrcusjF8X9PFilZtuPLcASC/nczeOtDdo
 s7wEtwte3YPx89K/KiApTZww8wTrUdFvcx+nlGX+wHeH5bO9AssXs63koR2xbJsvcQhp
 XcyIlnEvuUV1mf6Jn8DQc/+GKKA1fp74myTnGJyXtkpoCjsvcl3L/WxASh9hnIG1Y/lq
 FS1agSrnVVyy+xBrxgz86kaTTGObg5pVKCWtMJ4OQDDgFL2oGeipnKcg9q86/8RwBYob
 yYSvJgSIcz07wVVKE5NnbDvmO7vlCoj7LEr5vQRPFVhq977S+Vbh/T4ySZWOZDYQFe/o
 CduA==
X-Gm-Message-State: AOJu0YxF/NEildzRbIIxj7aIYBQ57YDaLntr30sM1xWGnkuviMRfBHQM
 I70qz0QaWcgGoXIK/xOGmOCU4ZTjNbzbg+wIsKE=
X-Google-Smtp-Source: AGHT+IHGk/2s6bydgj+5f/ZLflqA+jItMPXtf3cahPu9PY5pVNGoc4cwFFwHPs3/Et+4hrYtReanMZkLvCG5mfyTZDk=
X-Received: by 2002:a17:90a:c08:b0:28b:3637:e246 with SMTP id
 8-20020a17090a0c0800b0028b3637e246mr1729137pjs.4.1702665665755; Fri, 15 Dec
 2023 10:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20231214162543.1200276-1-tharvey@gateworks.com>
 <20231214162543.1200276-2-tharvey@gateworks.com>
 <CAOMZO5DuRnmNpT-GZxkjL4UmwNW-NyQWf+VNy4Q+N1=aitUptA@mail.gmail.com>
 <CAJ+vNU0XbwbQoYDHm59LrFaK_hv29RkeZvbK=QCUMkoLYNM-hw@mail.gmail.com>
In-Reply-To: <CAJ+vNU0XbwbQoYDHm59LrFaK_hv29RkeZvbK=QCUMkoLYNM-hw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Dec 2023 15:40:53 -0300
Message-ID: <CAOMZO5BBDM2rzhxqe_kw8ADexUtsNxYfnueFtASkNxp561nquw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx8mm-venice: prepare for dek blob
 encapsulation
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

Hi Tim,

On Fri, Dec 15, 2023 at 3:34=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Fabio,
>
> The commit log details are not valid for upstream. I was basing this
> off of 8d060e4a66d6884341fbb3d8ab1d837a3f173d47 which made it upstream
> with the same message.
>
> I can submit a v2 if necessary.

Yes, please submit a v2 and I will queue this series and the TPM one
to u-boot-imx next.

Regards,

Fabio Estevam
