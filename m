Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F24C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 11:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26CF88877B;
	Fri, 12 Jul 2024 13:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="nvyT5tlO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCC08877C; Fri, 12 Jul 2024 13:29:18 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA0187DDF
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 13:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36798779d75so1681208f8f.3
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1720783756; x=1721388556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlUQtKIyhbLFlQRteGkCnQIWBZp7ceouFI114gfM3+Q=;
 b=nvyT5tlOvGdJNvbGtLuAL+utSHYeqqPYwY27llQBlr58RyHIfnTWCeYBfHxEYl3LBl
 bB8AlfQ5FbQQvrabLV2NXelMfQXz1TnS10/P0+Y2onxFY1RwdgI0PpIovmpr7oynbdiS
 GvcHLeMybkMt5Sodw3HcinR2s63ycLEg4+Y9E7ikb3A4nvANuU6hlDuOPPKMPqiGo9ma
 KFdnxpq0s7HjXPglpZzFW4xU55x9l2vwdkQ5awWm7SBnRA+XoYLN7o/PvONFc+U8W6Nr
 oPb9nb9eD7JBRYmochgHX0vzP4Za5iC8iBTiIBZUvmtC/W5GXfBAjKlJ8XA0rCemGlbS
 sALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720783756; x=1721388556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlUQtKIyhbLFlQRteGkCnQIWBZp7ceouFI114gfM3+Q=;
 b=B5QPRG8Jd2pL6+LY8W3eVjHQRgl/Dqw9fa++JJ05WenhxaScd63mdY6R4qr52ZsPHS
 sjxgjQUuRgxtp4aIu9v+2fqK5O6hdIhiHPyH9DHxIO10N/KG9BzldGBsY2fzWF2Es1vx
 npOcC+0fou0WQcWcqidX6vfl+FksvFRFb/8u4e4uQioX/CVLIWgaIwr8Gmn/aM+FUS2/
 pHCHapJPpeBKTai0lYfwShQA7a6zlHP39jsbINzLATo6OMThToO1HGcaoiatlZAT3CIv
 t20EqWsT6MyH3Vq1RAbOGnoc5EtTqO0fCflUcC9bfVHzDAntyp+6R4nwt8gM9UF6bCW/
 wxdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBJqJT3FvVJo5piGLAVkUv2NplVoIJcUqljhLmis88hTKwDe2KHx+oViUI6/K2WZQJBkrkRmEWK9nXlvz/jVBsNV4f9w==
X-Gm-Message-State: AOJu0Ywoez5W49wTyfM5DzyenkzEwiSgTGvdsPAS9Us88rZZUv3LKUi3
 di9r49QL90tpYsyqmi3H/By1I1p5ls1fxvwtQdFY0lmTmFgT7cjojkQLyZvPYic=
X-Google-Smtp-Source: AGHT+IELvoairWDNlOgKvDwwb6feqMRQDw4IB1VUCABHDX5z8I2FYtLp0SRTomfUqwMGpuzMTWmRuw==
X-Received: by 2002:a5d:47a6:0:b0:367:927f:980e with SMTP id
 ffacd0b85a97d-367ceadc88bmr12304600f8f.63.1720783755718; 
 Fri, 12 Jul 2024 04:29:15 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2ba4aasm21877505e9.35.2024.07.12.04.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 04:29:15 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 2/2] ext4: Fix zalloc()
Date: Fri, 12 Jul 2024 13:29:14 +0200
Message-ID: <15231895.JCcGWNJJiE@somecomputer>
In-Reply-To: <85482355-3c1d-49cd-9b43-ba031fbfc707@gmx.de>
References: <20240702194223.31998-1-richard@nod.at>
 <20240702194223.31998-2-richard@nod.at>
 <85482355-3c1d-49cd-9b43-ba031fbfc707@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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

Am Freitag, 12. Juli 2024, 13:15:56 CEST schrieb 'Heinrich Schuchardt' via =
upstream:
> Memalign() is called in many code locations.
>=20
> If memalign() has a bug, it needs to be fixed in memalign. We should not
> try to work around it in all callers.

Agreed, I did already:
See https://lists.denx.de/pipermail/u-boot/2024-July/558477.html

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


