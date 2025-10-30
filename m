Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD3ECCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68CD9838BF;
	Thu, 30 Oct 2025 06:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jlF3sk3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B5A8838D5; Thu, 30 Oct 2025 06:02:21 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A67836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63bf76fc9faso1209485a12.2
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 22:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761800539; x=1762405339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CkxGrPAKx9oUqyWqSsgbjM/+eFWmTt7OREyX9YfXtmk=;
 b=jlF3sk3z8KlEszVVITq/aZFgfd5jOp8QGWILDE5MNARtaVTS2/6587mrTYAunBWGHc
 eaHdWf3unxO6/ZdvkckfWGaxItiUt0icbYp82++E+apZQ0XM3QX/v9AUQ6yGpBR4EEUA
 ZZFijQuxHaCYT+ZnMARYZgqmedEHpYI+5rf5RUUXFedhfif0ioQ8FSSH3www1Q4S89EI
 QjmgYd/7JPgxpqfRk7tsm4t8K7x4cl9CtMtP2Iiz89rYE0luMWDAeofpe4z8R6b4h0fC
 PlFNMDKxKwrgigJR2vFL6ijylOB1rDjmIcwzrnb78Og+3Yqk2xqZsTNNPKVy447/4hUu
 1FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761800539; x=1762405339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CkxGrPAKx9oUqyWqSsgbjM/+eFWmTt7OREyX9YfXtmk=;
 b=PfebJrTm4ld/3ddjzdakS/LuZiqe8hVP5CJVJNJcqn445pG+ovkUElZM8+t6qP7vX7
 hV4SipQ8gF9garxlDIGPQObYw9lqdPIdacQ9mCYt1+sa0kxFbpe5jVi9LJLya7yLDGIR
 iPpqoVIh60XvIs0CSmMfMo5xaku8QhF8i3l5mVOwCv7RCsfrZ7vXUh1bTiaHfgifzx8M
 +eRXOTNa1Qgy/jG37FLtQgPquHB4YXWAym1ctanaobxizbf2bpx7fwsG2bFvvkETkaPb
 lN/9LVlj43supfB6YtTgoY3W2/JfIb4BO/uPcpDK5dnB/0xUrZ8SEVnCv1FMhblr1Z6h
 rirA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPViqUQgAbBPDPe5Ni7tcjwKSPX5U43qs0MYtT8JBnhAJ9xA82iAL03qNEuc7ttSDdX8FfGTw=@lists.denx.de
X-Gm-Message-State: AOJu0YwEGdIalbMJEpTS1OePQ6rwgrln5gEZ56dU/O9FQmVG/p5NvzXg
 Z5IwYriP38CveCoSjXtFLyfhBd+F08r0HVvu38QwFDT3CJmr8+fCG64eifmXVoSknSGdYcrTR9z
 /8zRwZ3cqn5sP5yUdMtHc0JBK/tTB770=
X-Gm-Gg: ASbGnctKSGg7DYgXeDPUdlxB5Njo6PRstUcjXiaWVn88zM382uaGnz6p6HlZrXoKc25
 EYp+nY8RX6Z7vlRKV2GEoVshob0xKj7JfRMFcxxj2gzASZtxxNqrLX11nRs8HOkIDLkWRvV7z9p
 rNEE3zNUflD1HVWWaR6CoTEXEFewcZpDjpWgLJxR81vJLE9F/w/JpbN1fNlfqB31UKbJixBpO/q
 bvnqL0ZcDQwuGEVny5vJ1jDFcMaA9EJGW31xLaRKix05uFz9wQqN9569VNyGr+DSqQrVg==
X-Google-Smtp-Source: AGHT+IHG0RkZdB/CpQu0Dd/JjJRXBWmP09gEBxamu/kHRJ0qrprX4n5TIOBEk+QBYuRtUs7+PUkirtJJh/0XjCOloeI=
X-Received: by 2002:a05:6402:430c:b0:636:9129:8826 with SMTP id
 4fb4d7f45d1cf-640443dc7e7mr4052146a12.38.1761800539053; Wed, 29 Oct 2025
 22:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
 <20251026010658.19271-6-semen.protsenko@linaro.org>
In-Reply-To: <20251026010658.19271-6-semen.protsenko@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 30 Oct 2025 10:31:58 +0530
X-Gm-Features: AWmQ_bmGmUonz_9zEMn98tdB1OXP2BDYXZWwIYtJCVCMnOUZrgeNzWR4vMhFMTk
Message-ID: <CANAwSgRq3CrRXfxKFUdSvM9M46WLmzXTOXkVtRAqfyoQMe0AxQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] mmc: exynos_dw_mmc: Add exynos850 compatible
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Simon Glass <sjg@chromium.org>, 
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
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

Hi Sam,

On Sun, 26 Oct 2025 at 06:37, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Up until now "samsung,exynos7-dw-mshc-smu" compatible was used for
> Exynos850 SoC, as it's present in its device tree. But Exynos850 device
> tree also supports "samsung,exynos850-dw-mshc-smu" compatible string.
> Add it in compatible ID list in the driver so that it can be matched
> against this string for Exynos850 device tree.
>
> No functional change, as the driver data is just a copy of
> "samsung,exynos7-dw-mshc-smu" data for now.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
