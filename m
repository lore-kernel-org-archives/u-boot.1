Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C78EA7185
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294928421A;
	Mon, 20 Apr 2026 06:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KrMQkv5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24C984286; Mon, 20 Apr 2026 06:07:04 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6058422D
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so474780766b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776658021; cv=none;
 d=google.com; s=arc-20240605;
 b=NcJibD+iH4rPLkGbvdgSW36yzp+l5E0k4AnsqKQ6H5lu7GME/Pl364pAA+fqruf9G9
 PCrADhdMX5i3p1OhT65lrSw5M5GzOFjikdNN/7QjoxqroIeCsDonYQR7anH90cv5ajxP
 43VTCGpivsO4Yp/zxwkdca6lNVd/gPK2b8MbH9VvDAwl60+hk+QYKwhq12SparGxMcxw
 Oe1wpeJK3KNu1sHi9M/lmN3sQOZTL58dyaZe+Lmb/BYLuyANkHVjw5ualZ9zsK8eHpBb
 6A4T8TS+bazvcwx5OoJAObMgKxeO8cBTibIXx1eckkxW1YJlUFbmSunNxEqeCw5Yr/Nm
 AK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zMzpsjyTcGnchD++r4WqdIWpBgtOHq2joCU31TuzA3g=;
 fh=OrOUJSsExG5RjfvIgiijnb7BV+3AoNCQKUPp+YQ6jBk=;
 b=YZahbpK3Sjno4X1mpX3W/pudsrVwbtkZm8vZmZDGijM2hc9oxwGyzqEFlT4rvCWrvX
 5VLLJWDTTxDOAamtnLhj+SxNztfbiU12OrklnwLkaM9NlkHEYLE0O9aT1+/Zl/MGvv15
 6XRHCOVDqKYiqPOfxFJEu2gjf/iaCP6dcLcAEos9hAwqHuNbwrapqv7Z4Nx+2oReQV91
 eaS9KFhZiTJuoEAMK8mUe+UYL0KZivsf9RjAyJNn2fQjcOcXV8dJzqWLyA9uPb1YKjht
 +qzhzVxzsqxY6frCGKKndCnr+tK33LnVEoD1QNx/quBqKzr2Cx4qlLNQlhdoElOlf463
 t5JQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776658021; x=1777262821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zMzpsjyTcGnchD++r4WqdIWpBgtOHq2joCU31TuzA3g=;
 b=KrMQkv5fx4pn3kLVEirzFeBF1OdOk1qr05mRSRg6LRYP/yQJcWEhd0W9X1WglAF5nY
 bomcu/e/Ms/DwXdm5EKrDnyAJQxUqfEzrQv4Blio8tTyKYRk1G8MVOpWfAmIOwb+lNyG
 YJ4AsqOs+jEoYPaA9Oj+HzEO4F84sJYrR9sqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776658021; x=1777262821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMzpsjyTcGnchD++r4WqdIWpBgtOHq2joCU31TuzA3g=;
 b=sJz9vlPgZTKwN9eCtCSVlb935OluCW9IQK097EA65tNpvIcvwVD9eQSw6+Xii+z3hg
 fjamAqSAVNhP6vjJZkFYLA0PKOZG/ectcM47TyPhGguDQXTXxM4dbwNFEYuzDZ7nUUqO
 zdUlxIGmPpNwbSVATJ7iP4eVWhnmxzP3cOK7wCDQ444y7KCHXZ2sqcSp+RgP7i/ARJBT
 9EGuBL+j2uXZWakTAHrUxMBhduihj4m5K4bqtrmiJOoMGO9Stkp7y0XUnwwqxSdImAoH
 xq0+mvMk1GJpd0nsfsqc7c3NTZ16Cy+vGkjbmpdix1r3K94Oep8YsO37UZb2ffDtyfCQ
 xGQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/a+AwNBIHCrw6hcWO2NrnKh1ZoOhN64wbwo7lCnMroXQHyoMqR3mapaOKGhKOF2xvHkiMdFyA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl9nPH0GdBvBOzju7xrQ5+Bjkugxg4OOIZ2wz9xT4VvtXwEAu9
 x5AuWroNP5+Ax7TAMvnZCli2OUYwEkq0+YqulVzDOW0ACaadNFcYRgR4y1+ntpoq8qnCKnYuISk
 3nd6jvC+3ujckrcqmxlFrtGfQzuALtCdPESX5Y4eh
X-Gm-Gg: AeBDietoYbh5qGWcTDJjK7tFDkMHc3meYvLpxW0TsHa0WRlhNmp3mFCSlLUDdVV1DCE
 5MzPXNe4IHzPuEmUrNajjf588b0QCD974C28y9ejuCnCG0g9nu5y7zVrROuJoE/wPb05XPDajdX
 I69pW6FnxT24O0X4hDc9NBD+gfAsDWlD3wPNkkk/bbQRtphkQ+OgtmT07n20bu1oJc+s+ifmyeE
 WkoqqoPV2ImDwwa3FQT4oSF8NzBACOqFyW0Gb1Ky2TT+mP8tREYg5rGIFjEDPR6wMAaTyG+INRa
 wVx4LmPZP0jWQgAwECumP/FJl0kBBA4=
X-Received: by 2002:a17:906:9fd1:b0:ba6:8f34:b416 with SMTP id
 a640c23a62f3a-ba68f34b618mr263747766b.15.1776658021489; Sun, 19 Apr 2026
 21:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <20260417120951.3454249-4-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260417120951.3454249-4-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:06:43 +1200
X-Gm-Features: AQROBzAqoeC2A6I_Hltx3aHZAnc28yr-PyqT4fB5SdI5ACYQg-Xlwh-CaiEq_ag
Message-ID: <CAFLszTjkLMCvGDeL793E0zN9X6N+o0kGXcaiKRrWsYzwSVHgOA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] configs: snapdragon: Enable FIT multi-DTB and
 configure IMEM
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, 
 gchan9527@gmail.com, mchitale@ventanamicro.com, maximmosk4@gmail.com, 
 jonas@kwiboo.se, marek.vasut@mailbox.org, quentin.schulz@cherry.de, 
 peng.fan@nxp.com, sajattack@postmarketos.org, 
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com, 
 e@freeshell.de, yangshiji66@outlook.com, jan.kiszka@siemens.com, 
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com, 
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, 
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

Hi Aswin,

On 2026-04-17T12:09:44, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> configs: snapdragon: Enable FIT multi-DTB and configure IMEM
>
> Enable CONFIG_QCOM_FIT_MULTIDTB by default for Qualcomm Snapdragon
> platforms to provide automatic DTB selection from qclinux_fit.img
> with overlay support.
>
> This allows U-Boot to automatically select the appropriate device
> tree based on hardware parameters detected from SMEM, improving
> boot compatibility across different hardware variants and reducing
> the need for board-specific DTB selection logic.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> @@ -12,6 +12,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>  CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
> +CONFIG_QCOM_FIT_MULTIDTB=y

The subject says 'Enable FIT multi-DTB and configure IMEM' but this
patch does not configure IMEM

How about 'configs: snapdragon: Enable FIT multi-DTB support' ?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
