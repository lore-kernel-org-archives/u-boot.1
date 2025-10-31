Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888D6CCF9E3
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 01:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80A083642;
	Fri, 31 Oct 2025 02:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCmRWUy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E14B83849; Fri, 31 Oct 2025 02:49:52 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0DA8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-378cffe5e1aso19139051fa.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875390; x=1762480190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uP+NYAYs7pQUw8PYeGSnoEIYS5BwtNusPAtWf3jMV10=;
 b=DCmRWUy9Qm9s766qvMU4WA0Otr7mJScbn9o0ePOjS3htpv5rg6hMgc8a1wsV9JkW9A
 mSfJG7pLRl5j5v0iiCLTs/LdMUuTg4LfnJYIkt2wm0bVTKgGgoEEP8EHdxDrWWQX+mFt
 dT4TFAqcKiBxWitbbG+GpPJYQVGdliPbbsubCOrgYC+MTOvcwonl40kWs5s5RA3bQJjo
 nQNm+ObEbA3G3dFn1AI0VKILoeekO6IyAD+/5QYzZ+D2zQxcVR+S/r9Osfaoa/L0/lya
 PtlbqNHdmP/gZR0uepl5E6PMx39xyDiI38K/FpQ7Q9m8DI5TWLHZbcbPbVWV0ki8eMOm
 yaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875390; x=1762480190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uP+NYAYs7pQUw8PYeGSnoEIYS5BwtNusPAtWf3jMV10=;
 b=ldxbscXDOY6xZWjFRPRxS2GjKE8lIQantkCAxZMXEj44J63ROdriSAn2WzVAT/vCA5
 REBd+izi0OzB00TxeioSGXPO6CSQvKLL4JLjO7/+/AETvN1YUcnojI2t60ZsimiOFCr7
 g8/rvuXT3lG+fkZmzXXNLmpBud8WOBDZx24IGh1jFA6Sfs2E6GFVV3TGEyjN6vajhXAz
 euC5Ysvaf8E5K084O7STL95niObJRFjFgkVWv0XAAgr2AJaV1IHe/vwtdhVABzay5YW4
 3DEzCPNg7xqvozAxh4patW/4ATXfYWLiZl+2H+/nld+igCBcjRgjI5EAD7qt31gv7cta
 Ip5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl/g+hZyiDx3tQgWFvEASo+N9sZNL8WKta41HVxJ2c16485SkD6CosI3mEgTMILASC9Zz0mMY=@lists.denx.de
X-Gm-Message-State: AOJu0YyglLtmR3krYqi8dEMhkp2Kpp0ScYLKVLhJnhBVN0r/xd4Yelbi
 taXWXDabuw6OiZvJIHYeKmF/GGzZyD7BWjWmnOTD8HXwM63PrimR4mBH4Hmo4o6GiqoTPd+F6zG
 cuFB3kZCZW0mhdFo4mGCWF03VwFlbusM=
X-Gm-Gg: ASbGncvrrjd6lwxvPry1tQJ/BGuTw650Rg+MogAm7UE1cXOdEFTvgfUtpvikFr5xXxH
 0l10RlzOvF74bSKjtnTznxmRFf6emGg2KRUFzCm6vLovexTYrwIo06FUHzgboKWWOCgs0nF6uE6
 XpPktzNKMboIE5BuhVBaYoJKWNgHv83OVVWjszR61YSPfQeL4R+Zy7kZeoAWSyijKET0/bXuqA+
 VmD6ap5cb8H6lWfN0z5ZWtm1jKIcG8MZi3rIwJkpamFD1qayqL2LNalX6L2k7867DThKi4LWHKB
 UT6XSjh1
X-Google-Smtp-Source: AGHT+IHGBNesiGBDW5HA9dZ3ddKOwFCT15n3zMpdSgIS3FWoJW3lhKyEeHUDz0GRs4/ZdTw+ekbeArq1ERwdFXDiuW0=
X-Received: by 2002:a2e:82ce:0:b0:375:ebfa:2986 with SMTP id
 38308e7fff4ca-37a18dd5164mr4740281fa.34.1761875389670; Thu, 30 Oct 2025
 18:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251015063347.518171-1-primoz.fiser@norik.com>
In-Reply-To: <20251015063347.518171-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 22:49:38 -0300
X-Gm-Features: AWmQ_blw3-WH_KEjT45dXBl5oDzr2vUQOXXEW5OpqMX5MVLOPIGSczxNOHLYGQk
Message-ID: <CAOMZO5CLaFRb57ZdRJZZMDarLZvaBKsN+mHGU0vd6uN1Ls9LeA@mail.gmail.com>
Subject: Re: [PATCH] thermal: imx_tmu: Always set thermal trips from fuses
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Wed, Oct 15, 2025 at 3:33=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> NXP i.MX SoCs are available in different temperature grades. By default,
> device-tree contains only thermal trips for consumer grade parts. On the
> other hand, part temp grade fuse can be used to determine thermal trip
> points. We already do this in imx_tmu_bind() function. Now, factor out
> this functionality to a standalone function imx_tmu_set_trips() and use
> it for both cases. This fixes an issue where 'cpu-thermal' child device
> would set different thermal trips than the parent 'tmu@44482000' sensor,
> depending on which gets used.
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks.
