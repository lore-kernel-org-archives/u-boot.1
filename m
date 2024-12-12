Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DFEE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2433A801B0;
	Thu, 12 Dec 2024 23:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lipzmj+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 068DD801BE; Thu, 12 Dec 2024 23:15:25 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D5C800D7
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6efa5bf5202so9581387b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734041721; x=1734646521; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P78WjJpaWk9WfNHKHWYtw7DQaDpDhPaJvgXTwtEYA8Y=;
 b=lipzmj+Ze0nM0pAzEK9AqYZJDD2t+/xSnQRttWKhve+Kgh5TbTG8sXp1JGndm0xXMY
 70FJVe3N2llhO33ubrSaFrvILzFcCRTP63qvAavaG7biHDxARGPeZ+VtsZ5E+BEUGqil
 JU8Ifel7tM1K/lchs2drSg5JugGWiTy+Ylz9jqrwXnI8rUEiG0oOZO8l84lgcx8Az6gi
 8Y8jV85RiPS9xF6lsCDVJQRVSZ/Oa5ej0D0Gz3rwBxI+uPZDvIUNxp4s2umNPEQniJn6
 WCMcnwZzXoE4TtANsELeCkWeMh4jFiKEMHv6O4cn01EwCQzSWYXGXG/TUSQ173UDBuTX
 zIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734041721; x=1734646521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P78WjJpaWk9WfNHKHWYtw7DQaDpDhPaJvgXTwtEYA8Y=;
 b=gPkrBMnQCcXgilaNqJMPDYlN6pAJtUysQktfulYlWFA0jsPihCTgHmAgnYpwFPI+0A
 oe9kP+d/KDkvF8evEb8489nDBMSFh+FSCftQnzGSC0sUjNY33n+k+Cilsv+YxTjsU/ZB
 iFnDQ9d/zkI+M47EawwfRuL0QAW3fRYnOa5hFhrJ2pKmfbPPN7nJkkX2qKvsRxY3NK8z
 fHZushBBs+w+b6BfpGsNCd9ph1VSku6op8lg5aoknrSnF7QOd6r7qPKXGGB3QXWDJyw6
 5DC+oJHg/A9m04fpW68KvQpyxLUlgCKqhlbwLTrzbntugejUHdvXlpt8HxiK1GujFLv0
 baiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1WXW7xoTcIcprcpkStnoReQGYrP2dJq7lqsoMb2IQYwfLwi7jUUhF9Hhh/dj0nSkbc5czazw=@lists.denx.de
X-Gm-Message-State: AOJu0YwG5YhQnmVAcZYAB8BVe4gM4B3jpnZv9SV13b1cptxDzNpXH3Jl
 gRfzva5ctNDD+P6FJi517CpLQXeh16Tp6YSmltlN7ML7gzJdJV+vKr0uIG1sghTp4OJ86xdkzbE
 Y54ibh2Z3DjzhL+6cMlQiLIwC5bYr1dFv8hBgig==
X-Gm-Gg: ASbGncuXazSVCKLJKpbrp03qb3WVq5xc0QxJQEcHqqVmLANgyzIPCmtdQVqlV+f3H2m
 q96BCUDLemHB8tZzo0uJ7SijEv/NZOfc8JYMMmw==
X-Google-Smtp-Source: AGHT+IHi+ItBWF6AiYh6SoZ1/FxYzOLP8fL9nG8Z7cI7Cq0fAnd53A1U8k3chd6dbubyoeWdcGQ44QfBTjZUxzsohxk=
X-Received: by 2002:a05:690c:6301:b0:6ef:6035:828e with SMTP id
 00721157ae682-6f279b9bbb3mr4584597b3.35.1734041721730; Thu, 12 Dec 2024
 14:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20241211105504.453234-5-ilias.apalodimas@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 12 Dec 2024 16:15:10 -0600
Message-ID: <CAPLW+4npOR5wng=iV+3Cw5bE-qp4_cKwDhE_2cz9FJ_jXBY7Gw@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] lmb: Rename free_mem to available_mem
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Baruch Siach <baruch@tkos.co.il>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Nam Cao <namcao@linutronix.de>, 
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
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

On Wed, Dec 11, 2024 at 4:55=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> free_mem is a misnomer. We never update it with the free memory for
> LMB. Instead, it describes all available memory and is checked against
> used_mem to decide whether an area is free or not.
>
> So let's rename this field to better match its usage.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

[snip]
