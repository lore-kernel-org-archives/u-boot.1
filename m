Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7001C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 10:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329A088986;
	Mon, 29 Apr 2024 12:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jCKy97hG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DFD88987; Mon, 29 Apr 2024 12:37:40 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0550E88986
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 12:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2b1f5c8a577so132096a91.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 03:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714387055; x=1714991855; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COy/QoOU1sa968wWaP3q9CGGs9c1ApyqfIjsKOyFNAU=;
 b=jCKy97hGlpwZTBuu+K+V2haq+k1t6ZFYppYREnWzgHBgd6szZULh3vEg8lJQkZH/3d
 55WHX5ZI542Tn//phj5WrNvw7lVLRMFKqpmgrDbsiwC9Y0DSee4ob5bZr6Syj7aHRo0c
 mx9ZF7wY1yFHQ1cK7gRkbuqUWCJ247uki8PP+chenilmhkYgH0l66VvMe/oyvNp5aMDT
 udtz71S79E3677Dn1gC3ZVvNSzJsc5PrEIp+L+wo3XSpcTnVP4mx8lXkssjTL5NYZczZ
 DIokWL7tynPdTlW2tB9T69jXWDcfnu6CZtojO9iozpXZn+ovfPnydQS2PesyOMdf6KAE
 fidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714387055; x=1714991855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COy/QoOU1sa968wWaP3q9CGGs9c1ApyqfIjsKOyFNAU=;
 b=EiCSPbY82DWPiP6d97VUWgQao33ikVkBnsafLsSc/iLStI9onutfrQ+TYIeY2qPzSx
 dYHq6qVm56aXXvQRs1vVe679GJdOEjJK4CtQfoum65ok7mYu+qOBhxYTvuOBtt49Bvp7
 WTF/sd+IgKN95IP/vxQhkCYzVy4NqR9n7BR552jPwONfrRSDS/++dyfzYugKCxul57wm
 rSIJ4C7tML7Py2CLCg8MbPrTl1asTZDzEIcBDhBuR/eyfeF2R4b1I/0oPZ+7fjccLbYf
 F3reRHxSSQhmvPpLCnl+FazsR4e9aoFZKKY8zDY8zhO62aHqqHoLUiCeo2QXSybxT9Ua
 hHmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU59cMv6LmYlvBrcm/aHdNqWqoVAD6gmPkpz8iY6hrIJ8KZ07+7L0VdBcD50A0/lrolGSIstdnsqnrF6iIQUzh2ugDXFQ==
X-Gm-Message-State: AOJu0YxEZfjyHWU/AYLVA/XdRtwiubzhaYgLTs9ooOkUdAQRIz1V1XaF
 /7iKEDmhDrlTGowPTqoLuThOUsW/Ur4HBDgld2HnbqMG0y3YfPgUK/odTTSvhKokaPcQivvlToa
 vsaLs2/MJomxwQ+hhbHjDvTaB0DU=
X-Google-Smtp-Source: AGHT+IGSO+ezcScQ2YyTvn5bSjFfQASTXh134eK9ACVCO+9kf7yHrrvIbk5UOIjmJFbevICOtlk3L4L0V61Bky5f4/0=
X-Received: by 2002:a17:90b:1088:b0:2af:3a82:53ef with SMTP id
 gj8-20020a17090b108800b002af3a8253efmr9942036pjb.1.1714387055580; Mon, 29 Apr
 2024 03:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240424091222.10843-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240424091222.10843-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Apr 2024 07:37:24 -0300
Message-ID: <CAOMZO5CUFkCCokJhs3Cxrd6J=2PHBSDEN5wrZxSU0aJRjPRxNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] imx93-11x11-evk: Convert to OF_UPSTREAM
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
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

On Wed, Apr 24, 2024 at 5:12=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> patch 1 is to avoid build break when using upstream dts
> Patch 2 is moving to OF_UPSTREAM
>
> This is a resend of V3 imx93: Conver to OF_UPSTREAM patch 5,6
>
> Peng Fan (2):
>   dt-bindings: imx93: sync clock header
>   imx: imx93-11x11-evk: convert to OF_UPSTREAM

Applied all, thanks.
