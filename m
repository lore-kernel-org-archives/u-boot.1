Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1960CA0EFC
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 13:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E808982E67;
	Sun, 24 Aug 2025 15:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AnAVf2df";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F0C83043; Sun, 24 Aug 2025 15:34:05 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F7782DA1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 15:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-61c51f57224so614087a12.2
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756042443; x=1756647243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tdUSFE8/6Urdujb7YT+L06gKB00frxisKHF0pJLZ8U4=;
 b=AnAVf2df7Vw8hVn7sjvtPATzagHmnK/015wzm8erKFNtABU7pkd+8ET16xJrCLPIn0
 iGQpei/F0N7Gu0xQyI/qZJTGRmp0qm5ECgN92OYXH9Z79mXAysNy6j5Qe0YzRwuWveSF
 3Lf8JFsZxy2YeNxEJgbRj8PYnKS8sLM0XB/Y3FQ3f1vX3gGVe6NidAVt573oA8FrwSyd
 KNU8ErcylkcguXu7z/QVO5JGRM1wPQksSd0yiniFUWE1NPMzvYyXI+9v8YYZEHGHEUJk
 5AjX7EHPQjMJF2UPDwkwGdJZxKeoaejNeLj2OE1ZPPlesIp2itbJ3XYeN8xANPBOpsih
 8HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756042443; x=1756647243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tdUSFE8/6Urdujb7YT+L06gKB00frxisKHF0pJLZ8U4=;
 b=eH3ejBlUug7Tuxrd1bzGiXo+oa+sAP8Ec17xEBGrP73oj77KIBEBh55i6HfRY33EV9
 tn2HqH8r8xGESoTHNqLDcfX61eND8GBmWUb4lo6ulIv1963xl2dBWlPppm3izAwhanUh
 m9PgZD3GiFZLrYtX0sxDMdROiQ4/DtCeIhYsOo8DlKxd91XbsjNOjT5VuyjT28P9Do/g
 EH4EuWzKIMOUFGcIHE6DTIPoce/8T/1sLjh2X0hJLnyCNx5IhXuz7hspYCADcy2YHag3
 Q9lRgwccL9EDo9O5F7xZEJreuwp1t3y7x/6eKd/Xk4l6F+7joaE/wk2PbzuA3IKK4/42
 gk4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJejbcelZAG8B3gmc1W+9fthdYNCRaZG2ynPgNd4PYRXvTKZ3RkTyapb43+8UGEqnhgYTWVrA=@lists.denx.de
X-Gm-Message-State: AOJu0YxvW13T0zZSYHSdAEruG62juWx2HmIxSG4Kz8GRcDTk+XtPHE4i
 x0sxGXt4cl1o2sgnkv5WdhrvuIPmY74PeXWIEItf3J2mCNeKrxfhhL6MZw2JL2CK2X9UPxTM4ms
 lXMQE8ydQgfpVX8vQU1tb7lP2ZLbS8WA=
X-Gm-Gg: ASbGncs3ClUgsxjoR7bxjHBWjiQF79kAxjqCQyLjFmTVpwfXP/RGRO721zeSByKF2YG
 3zIQ4FGs6DpePpY1s9nRyMecVQ8DT4oP8j6UZs5Sc6OXzkJZ/k+1czokTDBb7sEz4r9SLkXNdfF
 GuN0pb2G9OXmRJlO+oWjGSXJvGikvmzGZ4SISjjrzNNQd5kgOwZcLfc04YbSvzUDum/ZrmfHLlH
 nFnag==
X-Google-Smtp-Source: AGHT+IHuCiZ6GzgaS6ZnfjUYlOhAUN0fHeIDEfEVyHQ9HK2ofXNCmf5VT/1P3AqW/Kx7Uxkrx3HtFMpZenSEP6oXVwo=
X-Received: by 2002:a05:6402:50d1:b0:615:adc4:1e66 with SMTP id
 4fb4d7f45d1cf-61c1b708a40mr7751960a12.25.1756042442698; Sun, 24 Aug 2025
 06:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
 <20250822-b4-exynos-power-v1-1-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-1-9e2f2f740029@grimler.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 24 Aug 2025 19:03:45 +0530
X-Gm-Features: Ac12FXxHowpRDdfqJHX-fgSE-_Bw9abdpMs3HZUVWRHRBX0YQJ-BP427yToVFXY
Message-ID: <CANAwSgQ+Cwkb0O4Cp2L5BvyuB6qtiJn68qaSY2sCZDYD-C7=7A@mail.gmail.com>
Subject: Re: [PATCH 01/11] power: pmic: s2mps11: look for both {voltage-,
 }regulators
To: Henrik Grimler <henrik@grimler.se>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de
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

Hi Henrik

On Sat, 23 Aug 2025 at 00:13, Henrik Grimler <henrik@grimler.se> wrote:
>
> Linux's DTSes uses regulators { }; while u-boot's DTSes uses
> voltage-regulators { };.  Look for regulators, and fallback to
> voltage-regulators if not found, so that both type of DTSes can be
> used with the driver.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
