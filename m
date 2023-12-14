Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C34C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182AD87AC7;
	Thu, 14 Dec 2023 18:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="tiy06+qG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB90687AC7; Thu, 14 Dec 2023 18:09:42 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEAAB87AC0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a1915034144so1094043066b.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1702573779; x=1703178579;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dZV8CwtZbi2MilF+aClPe8UnQ7df00zoLkwa7xy9cg=;
 b=tiy06+qG8KPFX2E2NuOfZ9QPJNvLg50jNzA6CxAGf+yqUnJGF50xPgcvfjPUFjdneq
 tC+Lj4s4SiJ8jRGUGF463qomVseKw68tGoyUuCu0CpetdWecxNZvmZ46757rSmS+nDbH
 g0mK29qZVMaqyNehRd7dEVPNcxQKNTgfbONSp0C2dQ8yOxIZAuvPI+aj4yf0YrRPGcjC
 XeChVSX3z+RJAhIYRMza1pfFHikdiJ8YzchnxKgUiUDTUHAsH2KOIlIQrrewZNgy4pyE
 mtTu4FY/a4FU+omgxX3c0sqVdyXL97canhRQA1LrMu+uL1dKd/4tqGDHnu/2rcf7NfuM
 SXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702573779; x=1703178579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dZV8CwtZbi2MilF+aClPe8UnQ7df00zoLkwa7xy9cg=;
 b=w9256TK5Ne1Gt2ZzJIIlk/jF4G8Q8F6ErroqRSKvi4sndPtR5zYat3SijPa83YXlFk
 FR1jKXsJY6QozBKRQ1LbDgRLZvNomDQQQWfT0B0q1Gt3RaNcw2mliSF78RAYi2RWNxDQ
 XLY52g852uAkYZd3GoI0GHDd9blR+K7R4fENMSfN632bAKYv977EJDZodnGilxSMKrGO
 SDfYk1sJume84FSGdThgMi5N6F4XWup2BMNh6Duc7qy/qY/VWjRxUPT+1srLLy7Go0SJ
 vxPkMJ02Q0IVzyVPAhr+MYOVQ+KsONo4njb9Zj81XBltCHyJY8Q5Q14abSN4A1DH7g+s
 Gj2A==
X-Gm-Message-State: AOJu0Yxh7FuZF7xS/h74frlpnkLzS3fR9ttROxw1ILkuxEkbdoNmzhAK
 wUUwJ9unerkxtEZRbDbLBXXRligRXoY3EXZVID42tqWQUQvb7bJUaR8=
X-Google-Smtp-Source: AGHT+IFCgAP32ZIPaY5RzWmA/PKvmxtJWoNMIpNs0KADhIK1oFZzw979OzMgnH24UoMe6hh8nLMrVKib5Z3tshEFhuo=
X-Received: by 2002:a17:906:204:b0:a1d:4434:4f06 with SMTP id
 4-20020a170906020400b00a1d44344f06mr4671118ejd.25.1702573779182; Thu, 14 Dec
 2023 09:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20231214162227.1199831-1-tharvey@gateworks.com>
 <20231214162227.1199831-3-tharvey@gateworks.com>
 <CAOMZO5Bx5Rb3oh2MCeh7ebuwJaLM3ZxUM7F3_2bP6TkPUrQY=A@mail.gmail.com>
In-Reply-To: <CAOMZO5Bx5Rb3oh2MCeh7ebuwJaLM3ZxUM7F3_2bP6TkPUrQY=A@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 14 Dec 2023 09:09:27 -0800
Message-ID: <CAJ+vNU0Pg56JKbN6=V6-0+Dbd6xnkyNF6LUCY=rR12nHD1HZ8A@mail.gmail.com>
Subject: Re: [PATCH 3/3] imx8mp-venice: update DRAM config for 2000MHz
To: Fabio Estevam <festevam@gmail.com>
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

On Thu, Dec 14, 2023 at 8:29=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tim,
>
> On Thu, Dec 14, 2023 at 1:22=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > The imx8mp venice boards can support 2000Mhz DRAM.
> > Update the DRAM config to support this.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> Do you consider this series material for 2024.01 or 2024.04?

Fabio,

Thanks for asking. I suppose I should have put a Fixes on "[2/3]
imx8mp-venice: fix DRAM bus configuration" as that one does resolve a
real issue (patch 1 just removes a bogus file and patch 3 is a memory
speed improvement).

Should I re-submit or do you want to just queue all three in your next
fixes pull?

Thanks,

Tim
