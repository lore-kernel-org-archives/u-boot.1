Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED560C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08BE587D6C;
	Tue, 30 Jan 2024 13:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z+itSySj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9697487CC0; Tue, 30 Jan 2024 13:39:56 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8068687D6C
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-290c5c705d5so356665a91.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 04:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706618393; x=1707223193; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPJynva6mjRSvyoOup0FFA/ObH99e8tXSmSgLHXvpTo=;
 b=Z+itSySjDvhVARsmnZvg9QrqAIk8nHBdLwLo++HlOp+GdOr46owbZDYx41Z6nKzaup
 ZjzDBvqMR9AT+utVDm6B0Jcg9Ygeaxpb1Vx+WrHFc8Zukzsise8yC8IraGQux3jb5rvG
 w80GwudlrkW9cQjmNxmbZ8THORqR9sS3LLdoWLKc6byydLIlIOo7ctPvVeVdy1a71s0k
 8qc7XfWeoeakBZkCzpWX8Lealc946IUHelXagL26jFg6MXg3bzPPyvRWm+OaxyGL0dCZ
 bVRRK4Ey0Bq55bmaKqoXdeVfGcPmOEyrhAOKZZn4waQ/+LEm25P1WHgC7PWJ1SfWeo2Z
 8dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706618393; x=1707223193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPJynva6mjRSvyoOup0FFA/ObH99e8tXSmSgLHXvpTo=;
 b=KPzCyje64T045J37ahAHsFbRgN+9Jj1VdKwp46tT+JkjLzf6Ltr6H9nqx57jJQWZzG
 anDFw9eOUlCqPCrqeZlhORq0gvAAl+E/y5K5pRlliXYttckNpnLzqITbbg+iMq0gIEDm
 UdDnPRDPA/t138JLHZPMzsfnIziEyD1Cnj15OXZIWjooTHFoSKGlylh4MPvDRO3Py+mC
 1abK/qmqX/Xw2tjOtkS2GwGkmKYKGV5liexe1FY3s3d7iy5L3dVM/3F1sLqv7RrHqMxh
 ot8FA19SRomF3+fVY38jnav5DdZirtFbEo0oTT6+/3JKf5HsVi23FlB2ogQjgQ6LuZYd
 mEqg==
X-Gm-Message-State: AOJu0Ywggg34yAMgivUHAWaj1lo8BtA9H0dHemXN1dFg00+kohGx5sSv
 yQzepi8E2P57sx6+rjvyWXfCDiZWQnKXF6Ah0VJxBXF7oIRKpkGvPV+GMQ7zOCLIUJOvoOdlj6r
 QGBdUePr8/das3rkGtTj1nUYdNyL8Vvhh
X-Google-Smtp-Source: AGHT+IGFXYR+Xkn3hvVpv0q98AXtFNcKmwzIrO/t+1oB09pQmg8T9XcZxTiu6Q4vrhUaG3pK6oaQXqIZ1E3GIQauTvc=
X-Received: by 2002:a17:90a:8b89:b0:291:465:db9e with SMTP id
 z9-20020a17090a8b8900b002910465db9emr9251650pjn.1.1706618392895; Tue, 30 Jan
 2024 04:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20240129-usb_support-v1-0-8bd2fe84005b@phytec.de>
 <20240129-usb_support-v1-3-8bd2fe84005b@phytec.de>
In-Reply-To: <20240129-usb_support-v1-3-8bd2fe84005b@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Jan 2024 09:39:42 -0300
Message-ID: <CAOMZO5CLRqVP_ZsZzZOC4cNjPccYQvka4Uf0ruOQdBP422ttAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] phycore-imx8mp: add support for booting and flashing
 emmc via UUU
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Mon, Jan 29, 2024 at 4:56=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:
>
> add support for Serial Downloader Boot via UUU as well as flashing emmc
> via UUU on USB0 Port of phyBOARD Pollux.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
