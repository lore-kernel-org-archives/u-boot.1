Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066EBC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 02:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1FC86A43;
	Sat,  2 Dec 2023 03:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FI5l3MRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EAD8874A3; Sat,  2 Dec 2023 03:27:36 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFC0865A8
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 03:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-280cd4e6f47so501026a91.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 18:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701484053; x=1702088853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6D1Nx0p+PJhwbKZDt9CyHXImE9PM0HmuH59luOjuTOs=;
 b=FI5l3MRmRlpVWK0iNJ5+1qM1DQxlexjnhANN/cYz1JfMqOegh4RYrDuEF/wvxEVmcl
 dn9YYuWyMM/NmxniQTr20EKkWFWXP25Gymk6hy4M17Tqh85HymiD8AoCsTYjqmz7/x4x
 oEXVekCwDyYbDRHghocaKBEK5kH+VFSTNbrfGcUBAKkp1gqHynHOVfeIe0FUEVAsfgbr
 BazkOcTmjbpPRaYHXEAlddghfN6y8ukkxUe/1E/o+d4bLkx5Q093vPHSfqEMeryRQF2O
 tCKiLnKS9/YusEkNC788cW/9a2EFzLEykFoxsDlNWtFNTDF/8rhYikkhBJjJKT4qE85J
 oriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701484053; x=1702088853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6D1Nx0p+PJhwbKZDt9CyHXImE9PM0HmuH59luOjuTOs=;
 b=CzVlJ4GejBhwSuqaJmIHBNtNQpiKZ+eh8QNhkfridFKKh0to3yNVx93c4Dv5agq1iS
 EPp80Cz/PrCIH3xOy25LgbhQs4hPaC99IpDZD1T3Mf8Mv3/+eusoZMKe5nIUeXMs7Q7T
 gic85+4Jqm1adRet/GPhxxVIsLHwiCStyzCBbNsgV9S5BTtldmprJnWz9ztHumn4JV8I
 eubyi/KmAOWHf+FvGvvRvh6aJ8ddiZ39dFfmRo9AXg9jkRHcQv77la5W4Xcki1pK74PT
 8KXaU14yPrfBznMIAQlYpKCmyAIRbJf2z3yQRvE7t5JoPOJ3W04Ku4KdVV4Jq0kadkvR
 kxWQ==
X-Gm-Message-State: AOJu0YwVSj8XwwDBWYkOfTuUBv4v2KBAC1qKlsFVTvg7shE1WKl6E1Y1
 JZYSQ8MwkqNLlmIWGxga6xCTK73aNjxLT/3IwNU=
X-Google-Smtp-Source: AGHT+IEURq+X6y8/KkGh5rpK0wk+Lco8nJ5BxFzHJXtfABY2D/62H0fRdJYH4jPdTU7AvyJKu6o+5+kAkFYdM4IRSBM=
X-Received: by 2002:a17:90b:2b48:b0:283:2fc3:b8ad with SMTP id
 rr8-20020a17090b2b4800b002832fc3b8admr7073832pjb.2.1701484052586; Fri, 01 Dec
 2023 18:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20231202014826.212858-1-marex@denx.de>
In-Reply-To: <20231202014826.212858-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Dec 2023 23:27:21 -0300
Message-ID: <CAOMZO5BhH=BXDqUtW6LEutvSaRU88uWp9PEJxMxg5nHsPu81AA@mail.gmail.com>
Subject: Re: [PATCH] ddr: imx: Handle 3734 in addition to 3733 and 3732 MTps
 rates
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>,
 Ye Li <ye.li@nxp.com>
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

On Fri, Dec 1, 2023 at 10:48=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The new MX8M DDR tool 3.31 now generates a programming file which uses
> data rate 3734 instead of 3733 or 3732 . Handle another rounding option .
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
