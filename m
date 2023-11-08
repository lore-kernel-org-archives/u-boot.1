Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA2DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CCE8775A;
	Wed,  8 Nov 2023 05:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T7L6aQxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A7087738; Wed,  8 Nov 2023 05:27:08 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B27387763
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5afbdbf3a19so76299757b3.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417621; x=1700022421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oaX65tj7t57ifPlD5tJzbrDzKriCL09crVmAVZTAjfc=;
 b=T7L6aQxWeLbgFM1ETS9IvEdjWy7eQBdfI3U0NzQLo6QLgIarQEiPkDY8z9g+J09L4y
 zceVtrLKCRINnKGtPxvZHHKym/sDuFFToTxDXowHhWGg85YK8K0GGFMb+JPKJHdhwB52
 /63/zwYoo9qZMPpJb1siCgWieAZ3N8CpARAYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417621; x=1700022421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oaX65tj7t57ifPlD5tJzbrDzKriCL09crVmAVZTAjfc=;
 b=WRZxF3HxfC8xxNj4zoFMoI6kjV+mM4sRx4fbJ5593kmawIr//tzuz1skowwJsuJPrD
 W1ie+I+l3dFJ3UnIJZ30w716M5YhesAmePGDK+3RAPK4VtOwOdiux7W8Pvg96DyczR1S
 i3OH3uvxjzqEGVK5Y3r7r5wApaIVTksmkf+U3yInWbO0kAXtDHnqb0WwzmCXiOyy0WQn
 RxVgb6BocWBXaTK37diJH+AbGkVyo5pmc8M5ojVcI5PP5Y5Fssh1Jof1LsJkY0x1v5Tk
 Os2N0qT27319eH9JLt2I/Hzk0LsCFTI/N5e8OvgB9PEyCtxgJ1rjPbiZvrJbITQPdh0Y
 LTRQ==
X-Gm-Message-State: AOJu0Yyv7cjAo65EaAWr2pb7oigiAbl2Cx83iBUN3W2AziSAVlwuPHSc
 ItL4BqT9c87cTp4d33p0U/6iyxLgvk79lhEbEWftIBodYKzp+xkp02k=
X-Google-Smtp-Source: AGHT+IGj6yeltLkk8I4ZdrTbq8Zw/amFIiSPqYXkTAWCSqCI+YrYuEVzS+dAf2SqJLiNvG/JQCIntvGtD8D24NMfnEM=
X-Received: by 2002:a0d:df87:0:b0:5a7:c1f1:24b with SMTP id
 i129-20020a0ddf87000000b005a7c1f1024bmr788644ywe.22.1699417620599; Tue, 07
 Nov 2023 20:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-18-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-18-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:04 -0700
Message-ID: <CAPnjgZ23ud1TP6+S6SbViVzLfQmfY=UtgK1Faa_LmkrkEjeWxQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/25] spl: Convert mmc to spl_load
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> This converts the mmc loader to spl_load. Legacy images are handled by
> spl_load (via spl_parse_image_header), so mmc_load_legacy can be
> omitted. To accurately determine whether mmc_load_image_raw_sector is used
> (which might not be the case if SYS_MMCSD_FS_BOOT is enabled), we introduce
> a helper config SYS_MMCSD_RAW_MODE. This ensures we can inline spl_load
> correctly when a board only boots from filesystems. We still need to check
> for SPL_MMC, since some boards enable configure raw mode even without MMC
> support.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - Add SYS_MMCSD_RAW_MODE to help determine whether SPL_MMC loads
>   anything directly.
> - Explicitly initialize load_info members
>
> Changes in v5:
> - Rework to load header in spl_load
>
>  common/spl/Kconfig       |  8 ++++
>  common/spl/spl_mmc.c     | 89 ++++------------------------------------
>  include/spl_load.h       |  1 +
>  test/image/spl_load_fs.c |  3 --
>  4 files changed, 16 insertions(+), 85 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
