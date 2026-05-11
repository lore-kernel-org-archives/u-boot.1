Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE507CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1828394E;
	Mon, 11 May 2026 15:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eeWt8ZLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3F383CD3; Mon, 11 May 2026 15:11:11 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D2C800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so3218441a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505068; cv=none;
 d=google.com; s=arc-20240605;
 b=NzxREibWRB1d7c/WTTXtN+MvTikeP2XpgDUeqmJMCq3HTnM2dI0HtWRP/ZrArZs0VI
 AdenK/e76dW/uf4BZFrrBJJJg9ST2oj8R9ZfmXCe59aVCS+fdiAyHgiO0ea/5zpXnmPb
 W7N3ruEpE5F1GWjk5acJxiqKFDQBoirVCCjEs5Th1wVqe7frfNZTRWAJcv935sk1Fb2b
 cghtEu79IEt3Nxp1OXarj3b266W6u10D6qlH95JUWjRIVZ1iOF9Ie6lFu8VJbc1IryGT
 xsa8iqMlOynRgQjQ5DS5bXKEfahu3JBVPBdls5u8Q6QMkmxsKfClvp9tg/0lFkAGMgDZ
 7ZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O6l/QLtgRAdH1Yqt28IBgcrzKD65Jl/2YrahzN2pDW8=;
 fh=iPgt1bMIwV2uG6O8DMJiO3pmO2ll8c43yH00JVFIFGs=;
 b=jRchwVamSof4LAYq4vM0X8dn3qUuCKpXI1ZJNVCoDO3DECBU2vH8DrK0Ual2Sj6zaM
 /EOM6aMEftJjDsAv+bOgfaHrfCENTR15m6kUXx2lfaSl2/cC3+eLv0uszeYyplR1ZXip
 +aYZvD9Qa+f6oZ0Ekp+Capl6F/rESYfYpizzvdS9a4D/4flBtbTqG9wNE3GwJ1O1+HZd
 S+C0+tq1+MLL3NMDBuU1iBmV2XPjz1+Ago9/VwoRp7eTEmJWiyT+l7a1LjYpEr3x9oGH
 VYfQ0aXs7tZ5HV1XPAflllf9EIzK/ddpMy7PmnwCvLaiX0SaHKVbarXcieaWmEY18hoK
 lQVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778505068; x=1779109868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6l/QLtgRAdH1Yqt28IBgcrzKD65Jl/2YrahzN2pDW8=;
 b=eeWt8ZLrIy4RtOilIrlLpoLbUJiVhOVaSR4WA7D1DBoWD6rwSVrSoTkwop36K0uPhU
 oV+AZxd9o97KP5rVrMVJji31fhOtNFsb5U1y3PlV/RnjhROhePRcd3JoKtAqCU1tjxOy
 4FbumPOWZVNkaaBedeZ+BKxlE2d2dB2GOf9pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505068; x=1779109868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6l/QLtgRAdH1Yqt28IBgcrzKD65Jl/2YrahzN2pDW8=;
 b=KQb/euEAbIxcOEQjfEQb4uk51Ds1tVriSuSyBmZtp1wZoUElXahBL/ZFoPdN/BGcPY
 rFL/c+phjUya/Is/O/4GnhMfN3PkxxxKrij8tgbY2xOu/cw2LNGizpIWTjg/e9Hywwxy
 y2XdG9AXgasYT/77emvwxWF48MEqVL0dxB19GVN/RTgNoL5KVbSpX1GW/2e93zBvrGH/
 BecABdivld4+rzhn2u5/fXhxaUmx1Z9+R/K8hBOAlQaX2JmAZoUaGT69C+S782xZxEC3
 MUeZCjZ6DCZVI6Mik067w+EXGlSJ4NpJQE2FQkaT1/cDcM+5LKRuihdZXHyIwDh/hTWH
 F7aw==
X-Gm-Message-State: AOJu0YxJ5Dpx00aOadD1MZs1pBdaq5Cx0HIcCDufwKMIdSkSgY/QkTmE
 F1lWFPulIFTeEPMUIPNDWlTAvUVcUmW41oFACXFEm/Wi+mE+yScWBBT/hOS2tjtdXYoznozSyt5
 ygnuh8oWcYAkst0rbXeEEoLraOpJJHl1Z8ON5bNss
X-Gm-Gg: Acq92OFEBczR89VpHUoFn7PS8iBZQEYdL5ExHnt5Zmayi8wL7lx1G5BYV/woELp1Jr4
 nVEx+c+q2/4naCn6dPIg1xumMoLPOMDToJl23Lnoy6DQUisoLfSmUiAr6B5ZAlg6g96ZHQeCEhl
 6G5CkiWKFtqfHsuZp1Mezuuk1d2TtAU2orjzNMWuMNeUkHK7zHxnM0y0aQISRVp7eUI3mAaDPZX
 X3IcwqGZ+M9LCx3yVaN0aBquV0cidp/CZTxU/A5QS/Grx/MvjKabrKTMr8h9Ey3PZHbqQff+fAB
 2DALyw==
X-Received: by 2002:a05:6a20:6a2c:b0:3a2:f2b1:1ac with SMTP id
 adf61e73a8af0-3aa5ababcb5mr26711319637.44.1778505068036; Mon, 11 May 2026
 06:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260509203136.46745-1-kettenis@openbsd.org>
In-Reply-To: <20260509203136.46745-1-kettenis@openbsd.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:10:51 -0600
X-Gm-Features: AVHnY4LzFbccVoaQ4Hn42aoUUjYXxgWtacEf243wIuVygI6YZVmg1gDaqh0YZrQ
Message-ID: <CAFLszTga=8LFjUU=PjYKztMiMaHJ0MDQEh6+h9RnCiTMTOHzPQ@mail.gmail.com>
Subject: Re: [PATCH] smbios: Do not fall back on devicetree without valid
 mapping
To: kettenis@openbsd.org
Cc: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Janne Grunau <j@jannau.net>
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

Hi Mark,

On 2026-05-09T20:31:36, Mark Kettenis <kettenis@openbsd.org> wrote:
> smbios: Do not fall back on devicetree without valid mapping
>
> The smbios_get_val_si() function may get called for a sysinfo
> property for which there is no mapping to a devicetree property.
> Avoid a NULL pointer dereference in this case by skipping the
> read of the mapped property from the device tree.
>
> Fixes: 83b28b55d74f ("smbios: add support for dynamic generation of Type 9 system slot tables")
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> lib/smbios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/smbios.c b/lib/smbios.c
> @@ -292,7 +292,7 @@ static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
>
>       /* If the node is still missing, try with the mapping values */
>       nprop = convert_sysinfo_to_dt(ctx->subnode_name, prop);
> -     if (!ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
> +     if (nprop && !ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
>               return val;

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
