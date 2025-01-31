Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FA0C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 11:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C1782163;
	Fri, 31 Jan 2025 12:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H3gobXdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFBF782166; Fri, 31 Jan 2025 12:30:02 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AADB682161
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 12:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30616d71bb0so18901491fa.3
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 03:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738323000; x=1738927800; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3UKEPoQkI4fm5mfZBs9P9kjqm2kRkfFuVrGOLSW45o=;
 b=H3gobXdEiPVRn/X+aKDbS4/15/AaYrqLQF9p1mIOwWlNIyyPpBigfX0Q3bDJ8ccdFP
 KRVX4Pmqrd1IgmfTuKwjyvETUu4fhPqHppXHQkt7txwCU08k6YIPgiqF/CjTUWV4b7os
 TbearhnamsGLj2Ys+LX5bdGUX8gPI1QV6qS45F8QL2Y871PulaHUnWKK/5v7rQzFI4iM
 h8f+WmSiq8gAc4jK5LfeezTpW3Oik/UuSQ0ef8V7AXA8v9jdKaVqmgkVjB4rBYD8OQRJ
 Ck/N1YBT4FNLMOj/3w/uPtH5s7HyOnjtocqTAwYm8hgPTXZZmwux4XEn84XinJH0f1e5
 7rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738323000; x=1738927800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3UKEPoQkI4fm5mfZBs9P9kjqm2kRkfFuVrGOLSW45o=;
 b=hKaMoFnraDtkgD9i4HpPzJtIGdbG6lI63sV6tEaDAu8LLpNoJz1WH1uslSAl3t8Sah
 hvspWLBQfz0VTNviSuwttP5zQMRMIa9aa8lrN4HRtadp08XCQwS7d4IhT5piruTXDpkn
 3x/GdEy46ASVb4fKaz9tkQSN1Y1xWc0Pgd7P+i659WOf1eAKY+SMn6XmoQMnVu6AtwnM
 ePtJmh2jIH2aw9RBUSYXC7e3PqYMgMv+Hwsbs5z3Kd8utsouKNF1fFWDPslqtYMD56dl
 gUkcE7qQTYbAI+QgKP177jlqviVfDP+9dm8UXjuPGbMVLrZY7XRXVNHGLV9pojy5Ptiw
 zxuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3a42AqTqeDc+DbePIBiFrtP2Sz7/DKcp4NnUwDJHM0ZlEeqiKG+/xFW50ArasHFlVygwbO4M=@lists.denx.de
X-Gm-Message-State: AOJu0YxcBugxwC1y7BigK4Zki3gp4CiLoFJRwBWbZw285Zw9qQN1Te3X
 2j/9W4ydh2lV3zS+RVU0UU74kLFGaf/AQCqkRGdhCgSLGzHsm6bLYaMLLMXU5DHbaWh4BwkGJwX
 VMocTC3WTP2vGe1WdKjZxmmQ6+l8=
X-Gm-Gg: ASbGncuEYctSPfu40IY5uQQYbzsup2gqdva7/WdH0bx/+e01/j9D5yrNnPlTQ45VB9h
 CBOOq4Lr8e7qw2J6vDGOzk99jyEq2PXnrsjTtUwVl2gvcZ52KoSaFCBcPzRXgM+55CgCHX4Kazd
 tPvF86FwX6ygiKkJdLMd2N3MQYhWb4
X-Google-Smtp-Source: AGHT+IGsEkDnzESa7Bs8WX/jQlnDyTfnJKgWsXCMMUmGz8Y0/Gu0KabnHPRoUxRDA9R5t71HG3KmH7nxBhr6Avqhs8o=
X-Received: by 2002:a05:651c:2124:b0:2ff:d3c6:9cf4 with SMTP id
 38308e7fff4ca-3079681b016mr33366361fa.1.1738322999520; Fri, 31 Jan 2025
 03:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
 <20250127-msm-rng-fixes-v1-2-00f5d2284314@samcday.com>
 <67dc34b7-1d5b-4fb4-89de-5fb4085d98bf@linaro.org>
 <Nc7eb6ne1yjnHZwTHdp5SqnqYu3uZEkqx1Qtuuk-Fs54ipo0bfhxzbAM2WksLzDQfdztW1txZLlWxbdvy7kGvYoj3IaOYNXq1tefJQb6qPk=@samcday.com>
In-Reply-To: <Nc7eb6ne1yjnHZwTHdp5SqnqYu3uZEkqx1Qtuuk-Fs54ipo0bfhxzbAM2WksLzDQfdztW1txZLlWxbdvy7kGvYoj3IaOYNXq1tefJQb6qPk=@samcday.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 31 Jan 2025 08:29:48 -0300
X-Gm-Features: AWEUYZlIw7YMUUaBGAsFjOjGA4IqIHkRNv5ITjzeLbHdF_1O88TIPaJEF4Qw3-k
Message-ID: <CAOMZO5B0aKxmM52962AGeHthQurBnqM8Ob3es=xvM0=P-KoXgg@mail.gmail.com>
Subject: Re: [PATCH 2/4] rng: msm: don't enable PRNG if it's already enabled
To: Sam Day <me@samcday.com>
Cc: neil.armstrong@linaro.org, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Robert Marko <robert.marko@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot-qcom@groups.io, 
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

On Fri, Jan 31, 2025 at 8:10=E2=80=AFAM Sam Day <me@samcday.com> wrote:

> I'd love to take credit, but actually it was Stephan Gerhold who spotted
> this when we were debugging the issue together :)

Maybe you could add a Suggested-by tag.
