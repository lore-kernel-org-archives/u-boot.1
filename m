Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99DCF46C5A
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F168684105;
	Mon,  6 Apr 2026 18:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MBtkoCxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE91884034; Mon,  6 Apr 2026 17:51:21 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F9D8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso636816366b.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775490679; cv=none;
 d=google.com; s=arc-20240605;
 b=exsebhlISAgb2pRPS0CADHfFJpJ7Q3GE6E00mCVzvA73PAYLz+iyZK9JS31wJz8mOr
 lZtX97VohoooB+3RjYPEeG0Erm5kAvsn7xlvnVzRUIUeVbRUhdiCfzkgsxLvfd9d94P0
 I504Y3BUrA+0a9YK/9Inc/6Vhqx/3GuiW7IGX/ITXqsjN9YrzA6Kw2gtlJbBBtlGORMY
 xH8IWyXdxx1WEaz4e9cGNfkRH4m5ltqJzSfHxqp7Ol8iwKj2maqVgwXnqw2Q6wL08PKG
 N+B9eK3+klaQK5ub7b2X+wSTGHCTf1j5kW7O486YdQgRvk1VJGCXbhMTW6iNX4rfHwbH
 SlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JcXQrv507HNNdQm+vQfVDJHeQexVXJGdfKrcI/zNI4w=;
 fh=lajVl/IeoACZS/6yuLfZkN/hPyImAZ81vhSDRfkAdyk=;
 b=O4mGl12BP0X2Glw2yahux9z8Y1Uk81QDmXQsbhqyq/7Etzo34aS0UDBP45qaW9ZOpw
 iubRSxVNJ6SJyN+Q6r50k5AYjIeDcjktwmj1RS4gzCObJZ23T/Cs9ou8mzPTgmqz8vrI
 BZVKMA4RwoTUouvJ7VXlQTNylwJ8iW5Yabb7/g6QrxKEpaXCTjpKsA+DoJ8VLZM7jF4+
 Hr5x/meneshcPllanBwTuC3h0Z+R8GAllXX4TpTi6G4IMPjlSDWx9twrArsAKm918G9v
 st+HTXH2wbyB5xWvNPYmNS3AKMy/2OE8gppG0EWk6+Pr3fU8nCLx8QO2+GNO8AXrfw0L
 Sd2Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775490679; x=1776095479; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JcXQrv507HNNdQm+vQfVDJHeQexVXJGdfKrcI/zNI4w=;
 b=MBtkoCxVM1AWABLH+u9sCXs7A+ll1o1wJAgz1bgEPoM/iNBF9w/4SRdbD2sM5MYS8D
 UGuybaxka5OiXwgvkwwVodtf/UeRf7OYMHFlzHF0ddQOQoQY9V3g0sdEA60GpuWHAfmx
 Z9Fq479i1Hdj9TJQzhONExxvqfe/+D+sP3bw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775490679; x=1776095479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcXQrv507HNNdQm+vQfVDJHeQexVXJGdfKrcI/zNI4w=;
 b=LFcqQcw2PkjSUkK9vO834mdgaD953U72lxy7f7UF9aAUwJfOxCOmmYprhUjymEoBPK
 KbBsxjq2DMVCHQr5eJBkjum54tLp7SCqUcqMrdIjOqICjImrG9q/PMnFqohabXmLinuq
 l62eOCFHHWcsqcgs8jbAvgdv9CGIfdgH5mS5V/dKCeCBnJhW3V+3O550zobbVCMkxM94
 10yJHskPV0KjCNJPfTiAxku5JoItGuCsv/6aqMTffFtj68Hlkyhre34afa9H9SPPQY+a
 jNLWySGHQYieR9CpKTo2zqut3NY8p4PSKQfPUCT4ilw045zM87BIALFysRPkaxpP4xiY
 3tQw==
X-Gm-Message-State: AOJu0YydS5bdzXHNuq095yiSD0xVsg85Pm0OV0tPM4oghtTkPoAiESkD
 ay0gpOSLUYBpBCCzFsoRCyIWT5cTUS+H1MKTsWQ6JHS9HmwYZ2JF5e/vr/LDkoROABMGf9lM/WI
 DfRUMnQD60n1jeF3s31pcQLbtdKFrAY8WA+CCVzHv
X-Gm-Gg: AeBDiesXZ1pmJh0W65qBGVGi3pCGJ3nzAi1HO0rk8Bx1gxAiQGBj6ZZyr4OYKmbXLpC
 w56oaHZrlsJyqqCDppWawD6+NueeEkBSXY8/1JXP8eBckU8jXYbpOuwYSooWXaDiPB8FOSqdn8p
 hlPay5j8OodUj4eaoc389vPSdBGIqlA/zQ3ALQQPskFviEEJkcg44DdzDFwE0Rg/z/v2Cstbv/x
 r/Ps3GDHCQxvhYfUqWsm5ZZShY/Vgx6Ot5cRFfPckp6o6wavGkw/CBeeqTDGVuyrlvBxB+6AfFq
 vnCGfg==
X-Received: by 2002:a17:906:518c:20b0:b98:4d6:8c9c with SMTP id
 a640c23a62f3a-b9c679a584emr497213166b.32.1775490679268; Mon, 06 Apr 2026
 08:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-2-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-2-9e6c2ac66587@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 09:51:06 -0600
X-Gm-Features: AQROBzAMX1xXP4WZUJFZbDyLaCsDOEyvicRkCkmMG5ikq8ZmTu2F6J6faa-9xUQ
Message-ID: <CAFLszTjTU_RMf6hh97+mTgxDMN97Z86XR+gFDyZadX5vq4qdnQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] of_live: support in SPL
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 06 Apr 2026 18:50:33 +0200
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

Hi Michael,

On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
> of_live: support in SPL
>
> Add CONFIG_SPL_OF_LIVE and if set, initialize of_live in spl.c
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>

> diff --git a/dts/Kconfig b/dts/Kconfig
> @@ -86,6 +86,11 @@ config OF_LIVE
> +config SPL_OF_LIVE
> +     bool "Enable use of a live tree in SPL"
> +     depends on SPL_DM && SPL_OF_CONTROL
> +
> +

Please can you add help text here? The main OF_LIVE option has a
helpful explanation. Also there should only be one blank line after
the entry.

> diff --git a/common/spl/spl.c b/common/spl/spl.c
> @@ -510,6 +511,15 @@ static int spl_common_init(bool setup_malloc)
> +     if (CONFIG_IS_ENABLED(OF_LIVE)) {
> +             ret = of_live_build(gd->fdt_blob,
> +                                 (struct device_node **)gd_of_root_ptr());
> +             if (ret) {
> +                     debug("of_live_build() returned error %d\n", ret);
> +                     return ret;
> +             }
> +     }

The U-Boot proper code in initr_of_live() wraps of_live_build() with
bootstage_start()/bootstage_accum() using BOOTSTAGE_ID_ACCUM_OF_LIVE.
Please can you do the same here for consistency and SPL boot-time
tracking.

Regards,
Simon
