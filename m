Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204F1CCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2337838DD;
	Thu, 30 Oct 2025 06:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bw1EVEJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D83838E5; Thu, 30 Oct 2025 06:02:33 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF6D838D7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63c3d913b3bso1056738a12.2
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 22:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761800551; x=1762405351; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hpLTVDhWWhS6jbaiN1CkTQhz3gRnmfrVBfVxnAQ6I+0=;
 b=bw1EVEJeJ0q3h764/VrAwZ01XoW3SGwcO5M9rH4oToZ7kx15ErPpYZlGK9r6dfgY55
 bn2XjRuz6TpPkLjYnznQ7sn4JpADzMVHDOizCejFV4rnE5MP+O3XKtwnIYdLgtf8/USr
 pjfbxz2tRwR4ydoqyhjhao40MxUMwcu4bCaEffghx/1FpfbWhPO1gIl60C60GY1zyTRg
 h0XVDRudITmIQWuXm6uBG+Bb6mwgxVQjxrJTG5Molu+sYVLhXmZHyaXME3JtoUVrVbyR
 GrjrATQShZc0h9ynDtZAh9KWUdo3LNf8q5GODdyxrgLBfD2UgGSWGRKQd7bPDtFpt6WQ
 HV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761800551; x=1762405351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hpLTVDhWWhS6jbaiN1CkTQhz3gRnmfrVBfVxnAQ6I+0=;
 b=HGCx7UIxZdT2hTSNPUB9cfSb41CpL8A0whbDjGF1RfWoHLicKExcMSY44KzAllE99z
 M/VLOrKO4FZl7F852+JSafNHaXeq4Bip6CzMf/JH4nLYTMDzWGLM0bh9S8H+8cCr6WNq
 +MZNLvYoP44uu/CvzQMFWicn9n7hHnEkif2gCNMnKQSGgLtX+JTIsAowsg7nS9hzUBna
 wjW0cPkXhzWBrC9VBHHKWkbpZdcBPRP7FRkysAzomgLWKyjeXPCzPv2vvutimSJfpykt
 tzp4/fJ0B5Lv7fQsj8zX0OyvxhsIkyw582JJHdD850FBFDsH6vqW6lejl2wJECQfWse9
 pssA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6aqA9ZzCqjMFeIR1VfwAymE+afCN9YI7fOtHDOtSorp4ZHc2IScr+lZ9L1s5OGxm+5o5CZ0s=@lists.denx.de
X-Gm-Message-State: AOJu0YxZHul3AXJDTrw8W+RW9ky/1GfvtsCGjHXqaALqjrR2ysuM9Hu4
 K2X6CKPC0UG+MBH0JoZ9al3qfMux061vdHocz9abW9rfyDlLh6RRXc/wU0nVPgFxgKu7gy5uZPo
 aT7qEZKmW4D8YVtVNTbj7GNQ01n9eN8Y=
X-Gm-Gg: ASbGncsLd6ubhaNuoxEqNe+pYlX3HrLAixiHsuYDXGIPRKQWJdmbVAOlwIi1IRc/CTr
 s8CZo6wb1L6nEOEGasziCPIdLFaNQNJmf/DTQAoFQDIp7X6VF0x/OWCLoBvWjqTfijs3ARRyyKG
 SduXraYYk18z9q6jZhEZOdzk52DiwP/3u35R70i4NaBMrslPg97ugryVmpj48hXcFMqWzIqYi1r
 gA2de/nK/ZivtCtjj9BKb7c0TsopM23L09p1s7GPzqz4nglz8TnIwQV57kHIBzE/BLeeA==
X-Google-Smtp-Source: AGHT+IG5lmw1ml5dZMxPmaHw7T+KBt/iSeOIHFFbyOz1JwMogO+Msyiq6/O565U+/JMbMdLBQw6gVC+D9MiaRc0JxLI=
X-Received: by 2002:a05:6402:1ed3:b0:63c:33f8:f05e with SMTP id
 4fb4d7f45d1cf-64044251d98mr4412848a12.22.1761800551221; Wed, 29 Oct 2025
 22:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
 <20251026010658.19271-7-semen.protsenko@linaro.org>
In-Reply-To: <20251026010658.19271-7-semen.protsenko@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 30 Oct 2025 10:32:13 +0530
X-Gm-Features: AWmQ_bnC2XU2ihN8eUQBJai6KOwogNBKDhT2tQPH1CCVR6DwHEm_x81qnQjHvsY
Message-ID: <CANAwSgTf9KOhwwKiTHKzxn-UB1OpYTY1pce1pnSZF2=jBdFpaw@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: exynos_dw_mmc: Disable FMP for Exynos850 chip
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
> Add DWMCI_QUIRK_DISABLE_FMP flag to Exynos850 driver data to make the
> driver disable FMP in case of Exynos850 chip. That makes eMMC on
> Exynos850 functional when U-Boot is executed during USB boot.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
