Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863DCCCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17FDF838C7;
	Thu, 30 Oct 2025 06:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VSuihK8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1914C838C8; Thu, 30 Oct 2025 06:02:09 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424DD836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63bea08a326so789067a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 22:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761800527; x=1762405327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KfwJTvTURA+EkhQl8V0Shua2TIcT0j8kRaSzm8+EgL8=;
 b=VSuihK8mioW0jixEboRS0oMJRa9Iq5lvQMP6ZunxcZR4M89eFCiRPoNxbV5uqkZdnx
 Fb9SJGV4gB24plumtlLYiiO4HMoIPjaxDKuKJdiqfrpqbcE66M0hhryG+9LnS80Aak+7
 aZoGPcnJW2NmTtrlG+ciyCpJVjCY+5l68FVdHXrzwvkfMRBuja2+OnMQeH9GnUvsgQtX
 rd7L/rE1L3is7lVhmTWYPSgv8nQhhtphr+9/y+6zxv2T9kOAl9GrvDNudifF0qiDODwp
 aiMckdBYYO29zpH21OUw4Hj9d14rY9DLCfR9oOxgMZrUs2Gx7HdiO0oJCTessj3IikeQ
 BnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761800527; x=1762405327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KfwJTvTURA+EkhQl8V0Shua2TIcT0j8kRaSzm8+EgL8=;
 b=W9Q5HaqBy2uC7MWxvQ1UBZlBwP0kFchGD1B5A8npOa0ruTrixJKVRQVsXacGvbEUdN
 YWmEiQztDKfpEtGiKjH0axzNGb2qx1eeBHHUlbdCqJTCRaMsdeoutboRBNnQkh1PgueX
 +quwDqVtRDpHeRbKITAx97AxxCiPYe2EQogAyKUfRjcjM9/y8oiSaJV7WFA4kp8/USID
 PGFHzRpOuasHGtdpqU97N3HfdGHd1jDEcfrIa3J4MsjoNc6Ge1WSnZfuVQC6WILR7LP+
 lOjO5RvqPmKjhEBpjceoBK9mHLcx0967b/tk/Qeebf90rbRsf0Pbz2W5eil+3sK3VtRI
 ACaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsc+PodCAWyD9i1l6ihFMMhG5hGkoUzAZy5gNQZx+w/gN7id0YN0rraZrgT3yFAf/KF8b/1do=@lists.denx.de
X-Gm-Message-State: AOJu0YzNVuAKCICQhVh8axRDf1oTkljEpaT0jW0GHrdYWrgdh513Vbge
 pT+1ccxGnYU4xOBbeKAezmRpwOyNsOWuXL+rHDCf+zTdZuxEL85QKfxA1Pj7WHW2VdeAaoCtL8y
 0U+iXvD6SHQ/Y5rCDMPytxItjm2TDCm8=
X-Gm-Gg: ASbGncuTj/WLa4ifc/qIRU7LWUgFQSBQAYqtFW9NFwgvJji/b8GE7US4e483TVtVHSw
 Ce63Hi2pNV+wv7SQXvbGgDFdTH0mCUgHCLJqf4EBJRjVzZDmH/uEMfhv/iBitjAk8y5d1oJBFTM
 uf6mC/fvoJKnYnGNkFYhbcLDsM7AzbogHcHoJ07ZtbuXHytvzf/tdyC9VVDPnSgwbVVbonWa3Lj
 l1WuuegqsiDMk/Zw6MA+BsurZT0xBIxX42iI8M0IZ72RbFWwFdYKi9CsUTYxTlICr6Ufw==
X-Google-Smtp-Source: AGHT+IEO1tv8a5bIDrunFOMUYHalK5Ps+Q4//2+/YVVB47l6a3rWwF/oPkw+jvHemspI7bonSCN2+bfLs5MJCwxMQFY=
X-Received: by 2002:a05:6402:26ce:b0:63b:ee76:3f5b with SMTP id
 4fb4d7f45d1cf-6404425e4a9mr4019221a12.25.1761800526632; Wed, 29 Oct 2025
 22:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
 <20251026010658.19271-4-semen.protsenko@linaro.org>
In-Reply-To: <20251026010658.19271-4-semen.protsenko@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 30 Oct 2025 10:31:47 +0530
X-Gm-Features: AWmQ_bm1NLxpscOxHcxV3U-cUlity0C202hjVNfFzeno5jNgepkKKZWNQ2dK39g
Message-ID: <CANAwSgSchAby-x_GXByLgaaUszpqihX9MQHUVjVGdfhkj274ZQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] mmc: exynos_dw_mmc: Improve coding style
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
> Exynos DW MMC glue layer driver have seen a lot of changes recently.
> Stabilize the coding style.
>
> No functional change.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
