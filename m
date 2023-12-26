Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23AEC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B988795D;
	Tue, 26 Dec 2023 10:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IhtftdiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C3A87961; Tue, 26 Dec 2023 10:50:35 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D738794F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-594c7443cc5so4769eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584230; x=1704189030; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltjrEMAj8rtyv0y+W7bXeFen0k2UOOvHbny0Aw+8v4g=;
 b=IhtftdiGzXqKviycpu8oagdTg4VmVmvmy6VeoKL50OOPOXwVAAoLT4uR1Amgjz9OGO
 J1PpnOxYxkve+UfVHf4ZJKseXPevM5t2HnsAAOARtJxbDovGWBLAw9wcQ5xfAWIpnsHh
 tZwVBeQoDVXhEml9F9KUaQGNAfwHzA9f46NoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584230; x=1704189030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltjrEMAj8rtyv0y+W7bXeFen0k2UOOvHbny0Aw+8v4g=;
 b=Kl/Peq8iakFA6BFj0Vag0sOsHIFoS8uo+tXsOLfjgFJzqlt/N8rX+ODabf5g+1WWOE
 upsvf44OB70BDf+G82izQOmUjdBOKy+DH2aESSQUy0LIfFoNAutlMQCD+QYPjwnGLoqF
 egAvs1GEwGp7LNIQ4fsWzgwPdUSiJFfKt7dAYsr+Ao+w5N4eaRFmp2NO1Xp6pw/6H4hJ
 c7v31j+ZFMoASIC0ZvEEs0bf3JvFS24k52HcHEsS77Gk/5g5uL+SPrAKcxEzwJxEe9CJ
 Hl4ep5wPHlT3d079CUAvssefyAOSwJMoOOBQOujsuHCMId3VOFQj92tX+jVTerQUT4+U
 HXIg==
X-Gm-Message-State: AOJu0YyGtQwnVkUA8TxusbCABFmVdY671MNji77vSBTLXhadjHAr5NPV
 IsZZIb3ksrbs7U8n0a3jznTJglOrTf0y+0JTbD/7I2XmIkoi
X-Google-Smtp-Source: AGHT+IEuSupUi5cXMS8P/+iOoeu8FtWwSXrRiBOBTPigZCMNX6EGXHeqLtID4ZNYiFcU8raXgu9o42soh/FrXM8nurk=
X-Received: by 2002:a05:6358:71cd:b0:172:e3d3:4906 with SMTP id
 u13-20020a05635871cd00b00172e3d34906mr5511800rwu.34.1703584229945; Tue, 26
 Dec 2023 01:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-7-maxim.uvarov@linaro.org>
In-Reply-To: <20231225153929.8284-7-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:14 +0000
Message-ID: <CAFLszTh168V4TQwxxFo_cwMic-W9BQ1kcP-pDVZ_wvrHAB55BA@mail.gmail.com>
Subject: Re: [PATHv2 6/9] mach-socfpga: do not overlap defines with lwip
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Dec 25, 2023 at 3:42=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
> Fix compilation issue with overlapping lwip and march defines.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 6 ------
>  arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 9 +++++++++
>  2 files changed, 9 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
