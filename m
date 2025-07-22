Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B89AC83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 07:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0716E831E1;
	Tue, 22 Jul 2025 09:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aw65w7Ul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85FAE8329F; Tue, 22 Jul 2025 09:33:22 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A864882E26
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae0d7b32322so793165866b.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753169600; x=1753774400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0KrhHtG5sBgipFQO7OGtfjevbkZa1ZiQa0S08aIL8Vk=;
 b=Aw65w7Ul8l6oHxoEXYbrpAdCjcTRX6Hc1Wdzy5+bbN/e0Jn6peOuPwcKrov/HnpUXg
 1zkeEZU8gQDWrVPULrfk8cRqFk24eYaJ7kQ5xXBO1s8H8CBGuVP50BElGM1nTTkLhtIF
 NdLFmmE9zuZ33hIn2/GZ0vIhz8OT7X2Rc0vT1s1H2IPi2+vJ6tzw8a+rUZyqRn6euFIT
 Agrcfnfc0JNvLYPWElkOvy4cHpl1IwNHyLDpmSTLQ/qR/q6DGMdP77Mc9Vxtqm9uKV5T
 UIe7+4JJJytWldIOfAS5mpqvjZtqtPITDhRcKP56Z5B56rNwhBtg9kFA5SkwflbJiD3B
 8Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753169600; x=1753774400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0KrhHtG5sBgipFQO7OGtfjevbkZa1ZiQa0S08aIL8Vk=;
 b=PNXOobA0KaaikZx5Xy9rooYVav1Q0klPjF1A1+oZ1DYRZGzbJ3xaRXqFy0JbcgDvpc
 8g0Q2V7/T8x3KdmJeyrlZeMs9t4sCGLOMiT8BcWYNlgOOHkIBMYCkDHiwMBBqSq/8+ni
 +BlgJlhIIiuFZs3Qnp+94zwhI/PTsZFg09RZ0jIJFpkUbiWRMqzKmVS9a4xivRNtMtyA
 aszE/xYaOQQrmWjMVFW/54APGpr0ToZyJ4bDqiws0raB6jmQB8Ttwbc5ELrpi7HuqznA
 J8CBpdktatDVQlgzuDvya9N/xPkjTsi61AjS97PXyn6Cbdjw52SvFm1qwD5y2FPLhxqY
 fMAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSBe8OgWSEY4F/YRChpwvP4gXnRR/grmg8CXN9LL7ek44ocuPPI+IPnavBGYhJdZeRLIx6cVk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx26BAKMyuI9w61DZ2JLH9IK2eIU96+3FDecBwTm3RdgjkoizYG
 KVQSAmKOQsseknWKmH7IaD6J5YWqsVD8Kxuf235F1E34OYgzPf/SRIYKVMREkjV7jzLoTGe4Ui/
 wM/Hrrp2BiwaN8z7CCD4FILO0JfcosnA=
X-Gm-Gg: ASbGncuN8iygwXdfXtQ2KEVeXU9VcBpN/LBMw4xiK7F7GyJEL26p+Zpd7Yc8/zTqiKo
 YriMJF0PWRRPVmPsx+OrGCfQ9U24LrA60SpURzgbTNURSauOt1wu7Tggi3qE8DfWkVY83fpf/qk
 OGkeUZ6sF1X9dRhqNeYovdT+AOjDT2DUlKPffSNw/ctNItdsSxeXwlLaqBRxXto9qQk72Botps7
 z7K
X-Google-Smtp-Source: AGHT+IGAnXP2BKd5vErlgsGS/kNw08epFLG4wz8wKfVShEFGZrWu3CdP4++EAE/mT3kPMvUiVKMuYkGx1oXWAxXisVA=
X-Received: by 2002:a17:907:928c:b0:ae6:a8c1:c633 with SMTP id
 a640c23a62f3a-ae9ce0a451bmr1910998866b.34.1753169599650; Tue, 22 Jul 2025
 00:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
 <20250720-samsung-mmc-fixes-v1-2-cb705abfa594@grimler.se>
In-Reply-To: <20250720-samsung-mmc-fixes-v1-2-cb705abfa594@grimler.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 22 Jul 2025 13:03:01 +0530
X-Gm-Features: Ac12FXzukCGD00X3_perd25nYpynn5zE2cbW9Az_zFV29OKUTE1MEmx9NUCRtmk
Message-ID: <CANAwSgRFuMENtqSF_5cEkTWQNraALauCbseGEsk9bM6ZDSC9cw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: s5p_sdhci: add samsung,
 exynos4210-sdhci compatible
To: Henrik Grimler <henrik@grimler.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 u-boot@lists.denx.de
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

Hi Henrik,

On Sun, 20 Jul 2025 at 22:40, Henrik Grimler <henrik@grimler.se> wrote:
>
> the Exynos4210 devices in u-boot uses samsung,exynos4412-sdhci as
> sdhci compatible in their DTSes, while the upstream DTSes uses
> samsung,exynos4210-sdhci.
>
> Add samsung,exynos4210-sdhci compatible string for s5p_sdhci driver as
> well so that it can be used with upstream DTSes.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
