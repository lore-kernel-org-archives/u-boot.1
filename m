Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052CDC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A5E88818;
	Sat, 20 Jul 2024 14:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gP195gZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3380E88671; Sat, 20 Jul 2024 14:36:19 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2453C88671
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b7a0ef0e75so15460446d6.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478976; x=1722083776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T5qqo8uBQYZkrfRGMYJPLxc8ucNh3FjvDoRH067C5rw=;
 b=gP195gZLKmRY64w80l2UUpWwd/62mVpGp8JUxVDvrzps2LnSLbYdGaj5+joGzEMaFg
 CpHpfaQ0LobHhhW/qSrkAZjVhPK3lzfh7L56xcJJ728ef/MOa6RW0RWye3WapjmnaAcs
 hAN4lQSd9EoWlI+R8XAnZACajydeHFQCiP1us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478976; x=1722083776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T5qqo8uBQYZkrfRGMYJPLxc8ucNh3FjvDoRH067C5rw=;
 b=JtFgcNrKhIMtx2JooUsSP8qeYnuGwVpwhG6G0xsxMaclpVyoI/tmA8aROCABe9v0kf
 KNfpVW6UKa/oP75hspvp8Sl9n/KPjsnvIIwHWRDrASsRxwPlIGIhCk7gV9uhygHV8DqP
 jl1aQklqzBOD8y3IlKNwaQT+mfOrX1nqjMlgGZD6rlpOBJCTbVCPHIlGAHUYWU7vmYKT
 QnQSpu/ZxBAQ+WjpEl5kriyiP0R2r38fFuqcUzBWXm7VWiiXL1qL7kZavjIw8gz2GEYj
 DlHyCvlKhqKG2rMXI62iQp3zb8Q75LKNIZfsITaP97CUvyfQj2PsD5xheknzPVZ9/2Ct
 qmpg==
X-Gm-Message-State: AOJu0Yym7kp4/hKDpvvrhHrSMcWBgsyaC+kVtTS3kzD0qQighX4jeWyd
 FCpdo2rq/NccoBIN3myzBYsol4gvKvqh3/Y9dJGdlDRVlwHNZNMpy3bsHNFh2g3FXlyrJnPFfIK
 J6sKZl7efAMpqFcpKC4QzvCDJ0EsHmz2U2tCRW0cB5zWyJz8=
X-Google-Smtp-Source: AGHT+IF5cfnHHmhr0bAaOAc8jPE72eENKKCnsVmAl4b0JxjJ8evwUWQBNqo2CBkwbzNYFPmxFeSB65UXhBLyOA3EKjQ=
X-Received: by 2002:a05:6214:c63:b0:6b0:6dba:c947 with SMTP id
 6a1803df08f44-6b96110c522mr12806086d6.18.1721478976054; Sat, 20 Jul 2024
 05:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240719191656.3323947-1-agust@denx.de>
 <20240719232422.3403700-1-agust@denx.de>
In-Reply-To: <20240719232422.3403700-1-agust@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:05 +0100
Message-ID: <CAFLszTisgs06W+OGSOTJ_fbGX=VxCRA+PU46U1zOBn9AX_ceSg@mail.gmail.com>
Subject: Re: [PATCH v2] board: keymile: convert to CONFIG_DM_I2C
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
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

On Sat, 20 Jul 2024 at 00:24, Anatolij Gustschin <agust@denx.de> wrote:
>
> The conversion to DM_I2C is mandatory, rework to remove
> use of legacy I2C API.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
> ---
>
> Changes in v2:
>  - convert pg_wcom_expu1_update_defconfig and
>    pg_wcom_seli8_update_defconfig files
>  - remove obsolete CONFIG_SYS_I2C_MXC_I2C* in all defconfigs
>
>  board/keymile/Kconfig                          |  3 ---
>  board/keymile/common/common.c                  | 12 ------------
>  board/keymile/common/common.h                  |  3 +--
>  board/keymile/common/ivm.c                     | 18 ++++++------------
>  .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c  |  8 +++++++-
>  configs/pg_wcom_expu1_defconfig                |  8 ++++----
>  configs/pg_wcom_expu1_update_defconfig         |  8 ++++----
>  configs/pg_wcom_seli8_defconfig                |  8 ++++----
>  configs/pg_wcom_seli8_update_defconfig         |  8 ++++----
>  include/configs/km/pg-wcom-ls102xa.h           | 13 -------------
>  10 files changed, 30 insertions(+), 59 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
