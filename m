Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD22AC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B7B87BBA;
	Wed, 24 Jan 2024 08:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EEAJfG6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A719087BD2; Wed, 24 Jan 2024 08:15:17 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DC487B6C
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d2dfe83fbcso1630383241.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 23:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706080512; x=1706685312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w9UUJ1jEIAu/OEb/uio8LthOlPcYqa+BWrMdRR8AkBs=;
 b=EEAJfG6i7i+QL6sOKQsgsnTDB0ps0iNqkESTeMnyw8LLiXLFtEIo+VCO9LVwI3jHSC
 xMfAQyihzRrXQ3w7+O4Rk75Njj5+XucM67mmhsb040swsH+pP5X6du7nX4za/XtgVAwe
 TbEVi5cwcNxEwH+LgGR0AO7f8Io2Sks0CxGfchU1sqdnw4nFdOq3Na5udfHPd/eIfXhc
 v+HH+diGiYz4cP/8mFuDtxIoqiRqQ8Hp533Up0B4VnmmgfsW50QTX8kmKKUD4Gfvsboq
 fI+KLRmNMckuYmCr3SDKKVxyQ+8JHLIusw/uZZOhdEwLp1wKhGaBGkixAeB0a2ZW+QBl
 iZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706080512; x=1706685312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9UUJ1jEIAu/OEb/uio8LthOlPcYqa+BWrMdRR8AkBs=;
 b=O0lUQnHFqwwxJsW34XVZsKs3mQf7Xp+jkHzDaV9vuVcvIMH7LxNAO2DqVR59fOERzz
 6YodACVxejIpbU1jwuQFt3buygoZeW/dBsiSE2pCXms/NJvN0dehf9xsc5P1k3vJH9jX
 6B4p6E9MDhPLL9d5EmUB9thGWLpklXaePbzadVYhVsXwmowEJ3zv+NL4hMQNBxrfkzJ7
 xcxs0W0n66dtqd+7fGLLPhnkZmpsyx5x2IWISquX5vvHkNMEy/tdSRNadyQZcf1ke38j
 Rh9z4fymDYfYVqNhRnbIlVqvaRfodbLnEPrd45ehCTU+aZujlFcRsiDXY9dGmNlEYPZR
 C05A==
X-Gm-Message-State: AOJu0YxVSAWK+6zvy5FrbBjVY49psaHvxKy43sp/FzQ9YPX02cRIPxcC
 +N0juLnyPU++3/YR9rYau4WxbKh91gVpclBvVVJH5wphJrTxGS1xcGJKAGvEsVp/eH0m7BHgx6Y
 OEQlrEWlFB5NxfT6zp5fM8SgTt448PWMRg+Vg6A==
X-Google-Smtp-Source: AGHT+IFi3m9l3xzzoRFMwQTyK/1YmdgMta/UHyv7EC8M43XBFOV5580wzNYt4ga1l11FjlYWKFDqRwIgXPvU9Jb1ewE=
X-Received: by 2002:a67:edd3:0:b0:469:a64e:9748 with SMTP id
 e19-20020a67edd3000000b00469a64e9748mr3775148vsp.21.1706080512179; Tue, 23
 Jan 2024 23:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240119155646.qq7bvgmha6cyftkv@nullify>
In-Reply-To: <20240119155646.qq7bvgmha6cyftkv@nullify>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jan 2024 12:45:00 +0530
Message-ID: <CAFA6WYOkySPKN0JLgSOZrnDAFvGq92h4fwM2c81b8m2g1gVV3g@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
 mark.kettenis@xs4all.nl
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

Hi Nishanth,

Apologies for the delayed response as I was on a long weekend vacation.

On Fri, 19 Jan 2024 at 21:27, Nishanth Menon <nm@ti.com> wrote:
>
> On 16:05-20240110, Sumit Garg wrote:
> [...]
> > Prerequisite
> > ------------
> >
> > This patch series requires devicetree-rebasing git repo to be added as a
> > subtree to the main U-Boot repo via:
> >
> > $ git subtree add --prefix dts/upstream \
> >       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>
> Please use https://

Okay I can do that given the widespread use of https://

>
> also what is the baseline? didn't seem to apply on (fails at patch #2):
> next f28a77589e75 Merge tag 'dm-next-7jan23' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
> master f7cca7ccc511 Revert "test: hush: dollar: fix bugous behavior"

Okay looks like recent merges caused conflicts, needs a rebase.
However, for v4 you can use this branch [1] for testing.

[1] https://github.com/b49020/u-boot/tree/v4_dt

-Sumit

>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
