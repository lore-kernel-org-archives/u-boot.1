Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E18F30299
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 02:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B69840C1;
	Mon, 16 Mar 2026 03:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eT6QnfqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347ED840A6; Mon, 16 Mar 2026 03:44:19 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57320840A6
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 03:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b97b333673eso86339166b.2
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 19:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773629057; cv=none;
 d=google.com; s=arc-20240605;
 b=kcL/783Ws7Qzxl3iz0sBEBhen9MFT7C92q8Mnc13xpIvODWz+8aUXGEdk/YKiDqQLT
 +2t5WnY1l4E7jwWllxTzW+bNSN5pAZ4HuO2AmkxdIa8SXeXXjQt5BiItNDAGM/SVgLQt
 FmfzbNXVpLLZOKbCohm8yAxCpM1Y7XMCjrn/re/u7w/8l559021Z1EkoKCAXKAeibAvh
 sgOPzf0F8mmamLBngG/YOM/nXTno7Z1tO4e70XHxtMk2yaRElxH7MhYnS+YvHC3dl+dn
 G70KYBLJqw3IFSBdonaHZeNLuBMTuMlglOAwSqQlakg31AU8lIML9Z3kTZxWZu1nh49d
 MCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/Vkjf+RNSSYrUO8rsfoYo1sA2Y+yKoJT/oX5OiuzqHw=;
 fh=TsG3XnFtjD4o6judHyhOSrz3zHo3gKH3ewqjVF0l/cY=;
 b=gyAVIknPcg4DT6sU1hoqMeVkwVbS/Yedr1DNxHWnmqCJ32EYZxIDhK2j1CUkSWaCNY
 p4swghrfX5HllMycVhTlXq+cjb9sI85HCvVPD/SukKBTJJXU9vu2/YhvEWUq2b6qPDKJ
 9HjD96SJ/mvc8hsc6i16u8SQbjogzqYf/VEJv+OZ9S1iCNtuu5xC3bPx8YQPEmaDUDAR
 0KY1nvWWhZeZWBzbecoQa34lw04zgPUyfYjaZO1Zo3TckJBe2EmPxDKHyYakY+B47G+h
 /edvFpgY/qlQmAvoZzbFt37CpdGAKRpHyfcDXX7aYCuTgwHf2uwBvAqIi/ioCkiUfnhb
 zzbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773629057; x=1774233857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Vkjf+RNSSYrUO8rsfoYo1sA2Y+yKoJT/oX5OiuzqHw=;
 b=eT6QnfqGmVEGWaq06vUKrqStQO/9ejFcajdS6QvkGWvUYx70IjPfDvi3cmmpOYYxxr
 iNmdHBkq79t8hKG5UmYtHLf+iO032GthSkWrBsWPP0fZp3yS71ENJE3dGL0VE3ToNnum
 PBcfEsztYztllg8G4PBaZ18HdKAdWBC/Jj0R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629057; x=1774233857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Vkjf+RNSSYrUO8rsfoYo1sA2Y+yKoJT/oX5OiuzqHw=;
 b=D7jjVFDsYLXauAIbgHS3uQMpQCnTGjOSb9njCRBDCsQ0IDv7QT/aPQWgd9kRaQCSiI
 0dGukXR5KoFSXUPTEm8jHN0l/FwfUH6UgLlB+0WwHZcd1xmMZEEApbyqXMhBPP0zufDE
 4wT86LsXXkLGcvcM2vQl8jb5BH6B//fixFBLK2QQbt/f4XWHdM+mOlHxfRQ3UsL6xaSe
 Um/wSuc7lhBJzSx5ZAoC9jlHRMiicNFo+kMfqGrqhRBQcAZB4p6+GHdOsRkSx2cWMFxt
 QSMsgo0oB8PtumIAZO/b3ErI58/yLdElGOZNLpVW+22udozRWUZj62u0ULSAMwnOeQ9U
 hELg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrDJU492RJV+DTbRml8HjO81xRvEkx5MfyW4+WvjotWlHRCORAbLHisBuj04sxAPSPKovnePQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxOS0qC6JPHXewS6+hObWQdoRImzaLFTNd5FcE70x37kKlk5Rzh
 K1Xq9qqwsTSOPCJfxdasHBafyiMKiQZhtyhfSDqwqAS3iiLbpxTawzzwZIc+CM981r7T3b2Nu7F
 6iRppXgazRUkRGfzf4OKK1FI2S3I1YDrLIYrFdc+5
X-Gm-Gg: ATEYQzwsYjAGV/j8vA1G6OBww8f0503anExNza6cFBk2vxiCbSmVDnWXLUldT8Vty8i
 SeJCC3GHsd3LVAkksL+rNvUHdBkj//juTo0a7uKGBV8zTYA5VS1xiulW03rUU5e6qF1F3TgaaIj
 vlCCyw+OpnyqDis1V7PvmCfuMBjk2qjwz84bXIB+3is7SGWEbVNsSd0Gzm+og0noyXtUxM78LuN
 Logri/vynAI6VqBaAqvMWdkMTnqgNSa1u+DQ5Vj5OCw38p2LrPzYOP1jVo3DXhhkSCWIlhn0nIx
 tkYmHTEapDu5h3i+
X-Received: by 2002:a17:907:97d0:b0:b97:a5a2:cec8 with SMTP id
 a640c23a62f3a-b97a5a2d12dmr198295766b.11.1773629056826; Sun, 15 Mar 2026
 19:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260306190542.22920-1-ansuelsmth@gmail.com>
 <20260306190542.22920-2-ansuelsmth@gmail.com>
In-Reply-To: <20260306190542.22920-2-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Mar 2026 20:43:59 -0600
X-Gm-Features: AaiRm50D-xhLHqzzeR89kUJIMpfcuaiSt5zZEiX5QcrWSQ-I0Ebhac1MAaYmSjM
Message-ID: <CAFLszThpMOBm2vP7n9douwNX7PbTTx_od7ayEH5s=QZOLBhDEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Paul Kocialkowski <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>, 
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, u-boot@lists.denx.de
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

On Fri, 6 Mar 2026 at 12:05, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> When dev_get_priv errors out, the ubifs is not umounted (if used).
>
> Correctly handle this handle condition and while at it also return -EINVAL
> instead of -ENOMEM as a better error since no memory is allocated but is
> actually an invalid scenario for fw_get_filesystem_firmware().
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/misc/fs_loader.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
