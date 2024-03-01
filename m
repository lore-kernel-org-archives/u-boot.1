Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9099C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 13:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 554D688145;
	Fri,  1 Mar 2024 14:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="stQ4div0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4207887DB1; Fri,  1 Mar 2024 14:31:00 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFED687D9C
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 14:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7dac7cfbea0so396058241.3
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 05:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709299855; x=1709904655; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fmW+Gom+bQZQ9DAn5I4HIlirJESHqzEAWADW2X4dBGQ=;
 b=stQ4div0D54M9vnxVqcmrUJFUvpcpEJDZOmiTAOjrqW3OD/3/qkuwCmrx6cYl0s3gV
 kxgSxrrARBDTrWe5vCmO8xtASnFjSUs2exvXS/fIG9DqSwXs9EXxFaDkkMShISGIpUnp
 sB4Rb2CAe93SFUICospC0uHKhuRfuvu6KL/J8Y53lvUe7Ysb4HDn6RYyCNKG59DHGK3S
 ufIF+bcOh+N5dDAZypeg2gkzKSft9d7q+ABNrwYP4pyEK8ht9hI1DqtxutE1cJX+ew/w
 edhK8cKMbHnN8FK8jEPbizesdGkG36Q3IKG2DegT9FMSepiMcyZJ5hjH1BBVdX00qt0W
 hreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709299855; x=1709904655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmW+Gom+bQZQ9DAn5I4HIlirJESHqzEAWADW2X4dBGQ=;
 b=w0I+N8aaFp4n7Bvzw9Iulf3z21SSJNeq1g2b7J196K5NPhS5LfyAdounWgamWv/gyC
 NHFfQMbuIZY14fmqiANBY5TONA/qpCWR//lMjhFzOuwa7I9R493jrWdPUYm8iEmMHvRO
 9FENPt5klwznGZeMvEosNNlOrO2chhRJ4dNuRwqo8MFIxT5tGC/yalWIc/xJkS9NvSj3
 wuG+FUZIO9EBQ695wU+L7sme4nuokY2B/dbgzE2OouWHExidOQDLuczcJWT3m9WWO1/p
 e//E1D2GYs+MIfF7SAfc6WDeHHRMg2o2Tl1Eam4pEy9ojwzhgxPrU6Hdn3+2DKFC5VRe
 Vqsg==
X-Gm-Message-State: AOJu0Ywfl5RGDtCxnPqsrv4v2yxq/CN+ZLX4EJtn7N6y9JajgKK4lxPB
 n0/mGjpS71llLWaLHqn5Fw5j6FUNQrbK4N/uklYR9X0dWpkoJ5eaCi/jHC08Ko/BiO0f3LLC+M+
 vhdFmXRK88kNGw/Z6vjjpgq1xi8WlGwc17HiWew==
X-Google-Smtp-Source: AGHT+IERYN6FD+ce26rlSrhxwegOZictuCUZmOkr0vsqMniZ6brEcuJ3cqv+Fr4oghr0FA+r7sP5efET26N5AfxoigI=
X-Received: by 2002:a67:f8c3:0:b0:472:9ce3:dccb with SMTP id
 c3-20020a67f8c3000000b004729ce3dccbmr1122941vsp.30.1709299855481; Fri, 01 Mar
 2024 05:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
In-Reply-To: <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Mar 2024 19:00:44 +0530
Message-ID: <CAFA6WYMBMQH10cHnsfmC5efkkohfzftz=6u0N4RMXrVrByZzOw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
 nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk, 
 paul.barker.ct@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 01 Mar 2024 14:37:28 +0100
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

On Fri, 1 Mar 2024 at 18:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:
>
> > Changes in v6:
> > --------------
> > - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> > - Patch #3: Incorporate fix for sandbox CI failure.
> > - Patch #6: Incorporate shell script comments from Marek.
> > - Patch #8: Incorporate documentation review comments from Paul.
> >
> > [...]
>
> Applied to u-boot/next, thanks!
>

Thanks Tom and everyone involved with the reviews. I hope we can carry
forward from this effort towards a healthy devicetree story for
U-Boot.

-Sumit

> --
> Tom
>
>
