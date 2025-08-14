Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E108ECA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 17:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55FD2839E8;
	Thu, 14 Aug 2025 19:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gag/7Wsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA9EB839FB; Thu, 14 Aug 2025 19:07:32 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C50839D7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 19:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-55ce521f77bso1166733e87.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755191249; x=1755796049; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4wrV72FBbweu+vrtAalyJjOaVVtDO9OH57APWhMWrI=;
 b=gag/7WsnfEsJFO2PQB0ZP/JWOROOYTrE/ekiKvSooFIuZVk5YLq0VHdDD0fGcGwbIx
 NDu4HKUYCRFPr2byZjt4d6EeFnMpP32XmMSmEA+DPO6kMKvPH9hCq4sb0ECHuXYunpk2
 tx9qfZnGf5M+XsNneXbPEaoaOM/nXNMrNbRpleMQgq0ZzelXG/oqhDMGcvGrlhdjI7XN
 UubG+auhTDyGspr73KlaHrLHLUn0oYrxXj1lZQYZbOi2K65HQKqqRXmuP7bbquW+Rwao
 i/5hPGJFIaTWzuvig95OiK7pUWq0CB8guMUmcNkDicbQN3Iu9vMDimZw/ouq+MKcE8sZ
 mrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191249; x=1755796049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4wrV72FBbweu+vrtAalyJjOaVVtDO9OH57APWhMWrI=;
 b=Slw2LiXCZGugLwmmn59Ikz01LwO7Akz4gjOh3+xPWecelFwKJ5d6P77TYige/Fkog3
 BTFjBJjl9nf3oCrFOCBYgEcbpR3UDwfZzXoK9/5yLMQAJgE2dY2Yx/WgSwKBljwKYpL/
 JnfNJo8UlWReyXzEZGaNjoRHyNEFtFjfe1ejZLv3sv0uR8RsWnt9P2ktJYgEL5iadeKV
 frb5KW0JrHOpQ374SNHUaMIiaysWpFqD3auFFe8tXD6YQwoXVxPvnu7NY5lwETjqEt4Q
 2Pzm0LmNyQjV8KeqfoqVO6SMk5GfhElQS3w1KK1b2uYYPux+p9JU67PmfCT2OiHOaoUf
 FlCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4lZqp7AEr0EPTYaR+oJvw5BAK1Z3es2otKS4JNi4YHkJ5pWtVMvlpz4+shER6iNtHDW6p6/c=@lists.denx.de
X-Gm-Message-State: AOJu0YxhgPTjNsDT9JN88nxWUN/cJMbgLCa/NwG/nuFDI+xQxPDEO9nD
 IMKMQoJgw1q80ohM/rKrFjSLmeumLrIcxQNzpiL9U82iGzvvq5cvjXtj4+NAs/9Pyz7ucuaYRDL
 KgH8vSQx5ufuPr/H2se/6IDaQ1mQRlNngGxu5
X-Gm-Gg: ASbGncu+UHTAQXA1lB5FpVKexOGBgyY/PFRRpLoorKSfb26wvehKwIA8GYeDua0gV+C
 HHRZrj1xd84sAWQ1OdBqHSCOyPHKZa8uIaUplEqYDX+jFVmV4DZ0bAOAWcqVnC9dZgeIStvKqPz
 ChfORqtQ6IuWwGxduw+IQ8FvGUCZzhsVIy2UR4rmh9LvAaj8UzfsocL7TAk+qz/jT77TDDJjZ+p
 hq4hD8N2U7kvUdDMfRFW+HOsFpOWhNfEyYMgmzg3CMMPKy8
X-Google-Smtp-Source: AGHT+IFJ16MdE4awCzjPd5ju87U0/uT009b5mnm7UWjgDv2v5SWHzUiAdRiY3rK74owsAeUciGZ4R30xEI6llLwBExc=
X-Received: by 2002:a05:6512:114b:b0:55b:93f2:6b58 with SMTP id
 2adb3069b0e04-55ce62a48c5mr929179e87.8.1755191249179; Thu, 14 Aug 2025
 10:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250814163926.1205901-1-jeremie.dautheribes@bootlin.com>
In-Reply-To: <20250814163926.1205901-1-jeremie.dautheribes@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Aug 2025 14:07:16 -0300
X-Gm-Features: Ac12FXwWIZHKv793MhNsNhCsQTqI_Zl8iENC8JtxakC5MIjQijuY8hXcmvt5bSk
Message-ID: <CAOMZO5Ank65-NpF+b4icn8BxCAR11VEUPt-v4VAMrQeu0Xr1NQ@mail.gmail.com>
Subject: Re: [PATCH] imx: imx93_evk: Fix conflict SPL early malloc address
To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
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

Hi J=C3=A9r=C3=A9mie,

On Thu, Aug 14, 2025 at 1:40=E2=80=AFPM J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:

> -#ifdef CONFIG_XPL_BUILD
> -#define CFG_MALLOC_F_ADDR              0x204D0000
> -#endif

Should imx93_frdm.h and imx93_qsb.h be changed like this as well?
