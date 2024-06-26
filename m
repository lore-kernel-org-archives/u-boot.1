Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C02AC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8E687F33;
	Wed, 26 Jun 2024 18:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iFkTExx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E675F87BF4; Wed, 26 Jun 2024 18:42:32 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6E0880A5
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5b9794dad09so3175870eaf.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719420149; x=1720024949; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=anF1WnArzc/XTgUz27GLyuwSoD6PJCo5sULWUjQb+rA=;
 b=iFkTExx6pl+ech3NtP16IaFVBYlz6Ff9nj/W+bGJAabB7kceO6llPKrlbt/ecG51+r
 XOs4FEevREHyLfJLUL+8m/VzzCOP6tAPoBirJbNq8WtujgejvZLTDDe9sOe32+x5aFsj
 c4ce99SrlCqnmXH0qTJQbnvsdrq0qg1tVXBP5m1Gj1i7FVdybV5+D4iSeFuhN45MXT+X
 Zt3VwbLZhwEh0Gb7txG2u3YKdlXBAC2+oQ/hb3sHMtmhH0N4wvaiXPO04sAP0qWYOxl7
 80i9+CEfE0EKWIXhSLQV6pML9rxAsfRQhkXlrPtU4NFjKAnRIOiQ0e9tVohI7ZvT1W4n
 pRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719420149; x=1720024949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=anF1WnArzc/XTgUz27GLyuwSoD6PJCo5sULWUjQb+rA=;
 b=tv6nAUDgZPPHLuvxNHTdXiiqId/C8ZMLg8cz5mQIkXt9OVD2XOLjDCOGnXU+In7Xzq
 eGGkwI06Sa26tFylvSanmSatbmimbVcPe/RNl7l/vol9VLVJJkoLnPtHNLABqNBZr1F4
 rLznFjc4POaqgcLLbDo0XZxgqzISxgd+Sql1V7uHVkyZSCPoN0UWJuFjMN+Y2Eld4KVe
 quDRiWxebp3bBdM6neKDO9Cg45kwxC3PWbOpV36BzvMEdn1eCD1C1Vm7QL4hOluKUPKu
 d1pj6Bb6haC6basFLbFT3QJG/1Rl0iLFvUT6eioNNPSKJ7WooI2sKZCD8s0B+/vvQ6Zv
 Mmjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp/f10oe4k7MMykURP8Ht+HHOhBDNjrQxvlCBlmX6+cVdRhU5HUdEGVwpfvZZTK8EGAdjgCFUkm0lnCuGfv9B9O1ZFvQ==
X-Gm-Message-State: AOJu0Ywq7gNdUgIxW3ISEEUX7vUECVrdIcSDci6JIUhUhjb1m+/6letb
 R6ktC+LpvrPuR+aL7eRgzLfbvM3XluCdopEqpJfqSC02s+lFR3yURNXqOqUJyiAk9Jl8Y8cpuDW
 RJMEQbbB3sslYg75SkLigzJy1/+8=
X-Google-Smtp-Source: AGHT+IFH+4uh2w0Hx9dPqr1iNNdke1wn3d95ZY1+aVr9BEZnBZ0gZp5wL8CX34NCdby3ePHkeDKlKrJvn7LRSvW8YlI=
X-Received: by 2002:a4a:3c5c:0:b0:5c2:27a4:34e7 with SMTP id
 006d021491bc7-5c227a437f7mr2032356eaf.3.1719420149119; Wed, 26 Jun 2024
 09:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
 <CAPLW+4=xXM8m7y030kcxTBwgLfm_cud8HYrwF0k75=GOg==zAg@mail.gmail.com>
In-Reply-To: <CAPLW+4=xXM8m7y030kcxTBwgLfm_cud8HYrwF0k75=GOg==zAg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 26 Jun 2024 22:12:12 +0530
Message-ID: <CANAwSgSw3ZkZBaVeAUoj6hCtGoydEmMEoLBaEkU4JW586M5TEA@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com, Simon Glass <sjg@chromium.org>
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

On Wed, 19 Jun 2024 at 02:26, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> If there are no new comments on this series, can you please apply it?
>
> Thanks!

Tested on Odroid XU4 and Odrroid U3 boards

Please add my

Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
