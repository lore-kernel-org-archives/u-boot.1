Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441A8C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 05:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761DB87D14;
	Fri,  1 Mar 2024 06:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q2mkVHYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D13987D14; Fri,  1 Mar 2024 06:28:38 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE2B87CB1
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 06:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jaswinder.singh@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-68facd7ea4aso13440086d6.0
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 21:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709270912; x=1709875712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GYJvDxGrsJ97Y1rf1tH7M98mZX9sQDEr/K6ILG4FgsA=;
 b=Q2mkVHYNif/HtoC/7Vg5t6P+EfhOwWPpT6kdy1QqrDhXNGs+nS2qCAtO+9ayLhhPDI
 DQ15YbdcIQfeY/yNBulphh2cV8H2U4UPlfFCzkl9wITrZGgaqCH34EJ4TYGhSQ9FocH2
 RzBmsaY+394AnzL0wvGBMIUIElNmFRTsfxvyIDiuDJtyvFryBhLuYKmRxH83h8Icws2v
 IhqhzOzY9YctyLrYyV+elhQuf9AwE4FxJ2ctjFiKPFKaifxX8e+X56ly9WuKCErriA5o
 x8wO3TYUjrDu7QwcbSNZiWmaBB9ORR0iEkXpZtGWnNg7MD8Y2qABlS0Igl/SBPKXEY26
 YADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709270912; x=1709875712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GYJvDxGrsJ97Y1rf1tH7M98mZX9sQDEr/K6ILG4FgsA=;
 b=DOeLY79TvyxnMFCrZL3rDSmgbNkNRM6PWRzxlysfgtSRrgNsUCLl3QLHqykvDGKyyN
 BtyFZ2wze9LBJpHhyiuf7dQxSlHkzGlKhGLIqiB11NshOeMrpPWODUBBwfXG8cLk73qr
 LiCyuNJ4Rnc/5ENJ+v+D9vnbDTY0ebI3slBjEIWMNtn10vx9/qxgHvuuTfeFfzo5gnGM
 v1A6PIif1/iyQK85SzklYhFOWdxC/g/cfgU+PzpNQ52Xf2ySoIYwY/IqhFTnCNcMA0Dk
 BpA/xJB8PI/LwOu/NRYDlI+uLcatv2qAw5VigGrGisXZNmgZFIgsqthlOLeNhFsfApP8
 gbug==
X-Gm-Message-State: AOJu0YwXvZmZ/NH1vsGK0ofPAREUd/ybIfYDFxnSGidwU3H2FD5ozjJX
 a1CdpZTFpPR4Os8IvNqEOhEvSpk0L24J7GAsY1VEYfF2fkoM6i+4sJrrdyWOaAEqxKua4VtS844
 un/Y7UCC2xpesGAmL71InatxbiTLlUoL+HONHKQ==
X-Google-Smtp-Source: AGHT+IHFlylit4mnP4uVOi2TGDfwnOGT2FXfw272O6WnrR44iZ06JbT8xQMjMacOBxBgwki6/tq4vblx7/25jXBieH4=
X-Received: by 2002:a05:6214:2266:b0:68f:e858:a1e1 with SMTP id
 gs6-20020a056214226600b0068fe858a1e1mr6399917qvb.25.1709270911850; Thu, 29
 Feb 2024 21:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20240301043840.2310148-1-kojima.masahisa@socionext.com>
In-Reply-To: <20240301043840.2310148-1-kojima.masahisa@socionext.com>
From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Thu, 29 Feb 2024 23:28:20 -0600
Message-ID: <CAJe_ZhcWbqUPkjgQNhHmB1_O-6SH-sh9LRnrKV-EjR9HdkbcZQ@mail.gmail.com>
Subject: Re: [PATCH v2] board: synquacer: developerbox: add myself as
 maintainer
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: u-boot@lists.denx.de, Jassi Brar <jassisinghbrar@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, 29 Feb 2024 at 22:38, Masahisa Kojima
<kojima.masahisa@socionext.com> wrote:
>
> Add myself as maintainer for SynQuacer Developerbox,
> as I'm currently working on it.
> This commit also removes Jassi from maintainer since he
> no longer has a Developerbox.
>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
