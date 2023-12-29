Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96CCC47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 18:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F8487B8E;
	Fri, 29 Dec 2023 19:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nG1ChFXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7018687B9E; Fri, 29 Dec 2023 19:55:40 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DA7876A5
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 19:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d3352b525so79825505e9.1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 10:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703876138; x=1704480938;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bROYxE1yiK1ei+jEywWliB2W039jGNKpoS1xjSPLvFw=;
 b=nG1ChFXwt3r1vU6d9q9klCacFeC5WhqSsmtYCyn8QEB37O7gjlwPhSh7dSPeWxf2Lq
 4QDLeny+nYPwbN5STEbTBJQwB92vrtV836iCWLCc0t7js3fuby6wghsOduDxRWoX6KVd
 AdNEy+hoINSOxi4/6koL9iZ+s0DC3/V2fA8ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703876138; x=1704480938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bROYxE1yiK1ei+jEywWliB2W039jGNKpoS1xjSPLvFw=;
 b=J8bg6tnJu2yPetgPBl4ViUus2wko3rYnQmSNRkuDsaINuzd2l/0rBFk/2OcOg0q0fl
 6aLp3yTywxtsTkjhlYzMYaUGCp3Jn/05RqWkS4u3Gy62wKtlfWopWIURP5u2xERV/b9D
 0zFRuN8Jz4gGZTNKxljHCEQO0B2XkbrxadJ2l7g3FK30iVI9UikFjB+1P+hGbnT8HFN/
 Z+swMemNA1P4tolXUmPM1F50zJMxGmhM6lBA34K6EbyEbwpqr3g1NdVMqSOOiW8xDOQV
 /Ef31q6fZV1T2buKrZTXY2bvQQayP/kFUJHkdcIYM6OjDBnrGawBqD/NoBwgebZfL5iQ
 4hfw==
X-Gm-Message-State: AOJu0YzZEzyjoBnrWZEP90YKhgQVBlcEDEG2Xht9QEC/SOe3fL0zH9vk
 ZCWnOcIcqVMqXie1y4i3oAUkJdeKxVnSoFMLV991TbDUyR4=
X-Google-Smtp-Source: AGHT+IHXJixRPATX+I9GE2aW5tBUyhVcWh41RreQsJwgPv+fSiZGXpGDPkmejmAYs9/Wl1YhGT1Q1A==
X-Received: by 2002:a05:600c:1c82:b0:40d:5b0f:47c6 with SMTP id
 k2-20020a05600c1c8200b0040d5b0f47c6mr2889321wms.7.1703876138135; 
 Fri, 29 Dec 2023 10:55:38 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c35cc00b0040d2dfb10e0sm37464398wmq.11.2023.12.29.10.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 10:55:37 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Date: Fri, 29 Dec 2023 19:55:37 +0100
Message-ID: <5740853.DvuYhMxLoT@pwmachine>
In-Reply-To: <170379713946.899302.2054678070497875668.b4-ty@konsulko.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <170379713946.899302.2054678070497875668.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Le jeudi 28 d=E9cembre 2023, 21:58:59 CET Tom Rini a =E9crit :
> On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
> > During 2021 summer, Sean Anderson wrote a contribution to add a new she=
ll,
> > based on LIL, to U-Boot [1, 2].
> > While one of the goals of this contribution was to address the fact act=
ual
> > U-Boot shell, which is based on Busybox hush, is old there was a
> > discussion
> > about adding a new shell versus updating the actual one [3, 4].
> >=20
> > So, in this series, with Harald Seiler, we updated the actual U-Boot sh=
ell
> > to reflect what is currently in Busybox source code.
> > Basically, this contribution is about taking a snapshot of Busybox
> > shell/hush.c file (as it exists in commit 37460f5da) and adapt it to su=
it
> > U-Boot needs.
> >=20
> > [...]
>=20
> Applied to u-boot/next, thanks!

Thank you for the merge!
If there is any problem, do not hesitate to mail me and I will take care of=
=20
it!


