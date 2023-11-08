Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DFCC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123D28763E;
	Wed,  8 Nov 2023 05:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QGawMT5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47D687713; Wed,  8 Nov 2023 05:26:38 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E692D874E9
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a877e0f0d8so3600917b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417595; x=1700022395; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nd+CP6Y8NtLRsG03kF/YdRGWevobV6M2x2ArynB1gt8=;
 b=QGawMT5JbpRhLKEX41QaD411wQ+jPSpIfYNXlJD8HF2SXq2zUFIi6pb5SgS6fSEANc
 GhksRa9GymCMt4l5ei8xbTrQayu+uIxUHNI+x722Oy2ip9NPsu9QB93pYBpkvIZNBs4O
 zQMJX4lV9v+1um3R4Voga3r9OJTaV8/rzSG8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417595; x=1700022395;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nd+CP6Y8NtLRsG03kF/YdRGWevobV6M2x2ArynB1gt8=;
 b=W1DS4pSr6DoS8tZcqhe7g0DpPlvbbqioitP46Cfxr6lvNGV46OJPzMgMd7CxykSMsw
 Gs7bqftxASX1P4IFmnihvdzSE15wvwlyJojaykvPU6/HM3lSGEZfLWSA+iFeu2lm068G
 r8zwDLS+bO0By2g1Av/7AFIMbPwa+OKJ5WmmSj5EwOVcgN4wwJA0UzZn7OGfiRa4Feaq
 mVeqdNbF9WtymDaVWR1xsu8neF2iC66IfKl333EAfD9xJiP0ZnRB7eOjBSjDdp7G8P/3
 A6EkwvSJXpwXgihx7aht0PK2B6Ib3FPNPARLCAx5yAiz+TXfQv2VRadBk/XRY2RwtbOW
 sA2A==
X-Gm-Message-State: AOJu0Yw2opVUA7euhQMtJWHDsZVAokDtUVkymFeN16HcOlN3g5HqdC+h
 Ge4FEd6fubm1ZgmvRwMxPV+hICbTGRMjh8opSH5z4A==
X-Google-Smtp-Source: AGHT+IHP24l9cnmR9QiO9G0XIMhPmIRgRV8ikx1JK5yaYacPLRZLzI6Hzo4Lj1R7jC+rYaPOUg04zP6EQaVQ23oApAg=
X-Received: by 2002:a81:4f07:0:b0:5b3:3109:3701 with SMTP id
 d7-20020a814f07000000b005b331093701mr3827396ywb.21.1699417595440; Tue, 07 Nov
 2023 20:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-22-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-22-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:09 -0700
Message-ID: <CAPnjgZ2JM4gJcGKc=jmwEADZq+ruXv6mo1EJ80fcjt8GBcXkQQ@mail.gmail.com>
Subject: Re: [PATCH v6 21/25] spl: Convert NVMe to spl_load
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
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
> This converts the blk load method (used exclusively by NVMe) to use
> spl_load. As a consequence, it also adds support for LOAD_FIT_FULL and
> IMX images.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - Fix invalid return from spl_blk_load_image
> - Explicitly initialize load_info members
>
> Changes in v5:
> - New
>
>  common/spl/spl_blk_fs.c  | 66 +++++++---------------------------------
>  include/spl_load.h       |  1 +
>  test/image/spl_load_fs.c |  2 ++
>  3 files changed, 14 insertions(+), 55 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
