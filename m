Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37521C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 05:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E72D8206E;
	Wed,  2 Jul 2025 07:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RXa5JkDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FFBC82ADA; Wed,  2 Jul 2025 07:49:19 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0287981FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 07:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e7311e66a8eso3672404276.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 22:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751435356; x=1752040156; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pib+thVA/JoZ3DsXhDghpHapb6ppDxvRjonohc3BmmY=;
 b=RXa5JkDaLcfVe0wdUN182iqorZ+HRnYLv6AWz7LcORoCWdkyKRIoGi139+DbCpPNxV
 eZdQXN/Ht2b13SbnUfAkbT1t4A8CKkfswqSSqmCYLfdinLN8jpxI8OkMDrV/mP9RIPuo
 KCHiEfjMD8nN/EzzZ8avhuiY1WE4efcEA84/dXHYN04NqvGLbefh7gmveMA69Q4PcHyr
 1bHG3QcaCeuB4xg+Nn0id4gLKWN5eyX0EzAmcjjn0XPOl48Oouh+/mZYUNZ6B/4r43+4
 lAVfevChXPMGIpYrAAOtgucQISJzPr2XZRZYD2eL3gNSR1otwSjc7R01IPdtABcZqzSu
 gmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751435356; x=1752040156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pib+thVA/JoZ3DsXhDghpHapb6ppDxvRjonohc3BmmY=;
 b=cyZHBaWKSuT6gwp+w3Eppoh4LPycPtj3i/CwWoEUTVhVsgRGzC9MsS+qXgF6naoIaL
 Rl51F4eJwYPcvFPHWPM9pFoClwIlAv9t8fGP0fj0tKkT7WGPnpgA6CHWraSMqLiMrmrb
 mFjSt4MDacws+WCZNJxftN3j/7GSw/DEDw48/dORYOz9cwN9/v3E9YeF1XuExXexYFuL
 cs9cJJGYpQNdnz90K3rkBvYq5SXfWozJ4UcYhZ6aIUj5XXQU5Cbc5pvAF52JgM+L3sX1
 cRAVijWPtqHg/z298ce4BvMPgKGqKit9+dPWTjNp5DKPt9BrnJkq2mxh2zjAi/DOvpl/
 ZxyQ==
X-Gm-Message-State: AOJu0Yz3LWctjoD/FlwWBzkEEsdu9+52lB0rxolUVzWeMndAyORChpZt
 HrEQH0LwcFuWoDlk9AMyUwFOltxQ5p+Pkf06jMXxv7LXpGJZ8uZZVjokFR6VS+OVU6BiLwvvIV+
 QSH3+g9/XE0rJwd47/QLb7rwDwbN4BXbtMeMNeB3m7PxtEizyjcod
X-Gm-Gg: ASbGnctzxV+8bS+E39g8PyBHViYNH6ACekGJ4WqGjxcL/WmIhg1iyPZaG2olDYkPRcx
 PLc2micJk8hdjDog97aGeFD6UlRXqicwVNNs+xAc63sPanIfZjJ08CetHXUoax2wxPCy8R8tj8k
 KLgS2VEff4x5JtL2RPPJyA2qY9l1BGO6a+7a9BcjI/3gZT
X-Google-Smtp-Source: AGHT+IGhCbVypZz1Z9iEfF8uXbzzsm2SiWTBrBzb5XhMqKpJ817GlNa+FSO5bwyVtxDUT7Tq53DOKEijPIkfUIHaKt4=
X-Received: by 2002:a05:690c:3502:b0:710:f1da:1b5f with SMTP id
 00721157ae682-7164d4b7c4dmr19414887b3.34.1751435355848; Tue, 01 Jul 2025
 22:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250701104319.716162-1-sughosh.ganu@linaro.org>
In-Reply-To: <20250701104319.716162-1-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Jul 2025 08:48:39 +0300
X-Gm-Features: Ac12FXzZGEVdoDRukUOrJ-KJRWwohAAznue-NmRAQBU18JxcSGeY4yEuodScdJM
Message-ID: <CAC_iWjK6Uf3Xs==KcDobxYcjXy1OT46AknLQopZW-vq1gB2L8Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] eficonfig: add support for URI based boot option
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Sughosh,


On Tue, 1 Jul 2025 at 13:43, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
>
> Add support for adding URI based boot option through the eficonfig
> command. Also add a basic test case for checking validity of the URI's
> being passed to the wget function.
>
> Changes since V3:
> * Do away with boot_file_option member of struct
>   eficonfig_boot_option - patch 1.
> * Use the uri pointer being non-null in
>   eficonfig_process_show_file_option() for selecting menu items -
>   patch 1.
> * Put a check for lo.file_path in eficonfig_edit_boot_option() before
>   calling fill_file_info() - patch 1

Overall this works. I can add an HTTP option and boot it. However,
there's a difference from your v1/v2. The URI is not visible anymore
when you try to edit that option. Am I missing anything?

Thanks
/Ilias
>
>
> Sughosh Ganu (2):
>   cmd: eficonfig: add support for URI device path based boot options
>   test: wget: add a test case for validating URI
>
>  cmd/eficonfig.c      | 129 ++++++++++++++++++++++++++++++++++++++++---
>  include/efi_config.h |   2 +
>  test/cmd/wget.c      |  20 +++++++
>  3 files changed, 143 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>
>
