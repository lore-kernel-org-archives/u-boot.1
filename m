Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C68CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA398464D;
	Fri, 15 May 2026 14:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FDHKfxLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 073F684688; Fri, 15 May 2026 14:59:44 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA3184099
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so1057685266b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778849981; cv=none;
 d=google.com; s=arc-20240605;
 b=kMP4foiAwqcuHyTkEiHDbzm8+NEcX7E18nDuRDOyPjiQ5WrSTxnUCPihzdzFqE8VsI
 X3nlOA+bDFVx646mGM3bHOHMDBROyse6+9J18RHRFhQAj+l2RMnYusmL/uNi/5J8x7MH
 vCdncMO39AhS2HX6ngqc9Wd5LA1n0Exp+AZP3dJ7SqrhiiaNjgsw4rh0M2RPxf061oeE
 aRQ2yAy0T/9J3946Y3FGU9gebX0nfFbffKaDcb+Rw46dR/nWwxCjwgQPOxS5n96YFtw7
 ATRELM9iczcYN3O0rluktVpk8zfjZe7DNDCU0l4mC6WKMR7xTvlWR/OQNAww+zfNeUpi
 0JKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FxF+gkCL/XGZQRnWTlDkr1DjBsMHgjUI9orLdCXXXTY=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=MApDNHXtpCa1Hat73kEwuyLWr2Dk48du9MWZeB3mNKqIDhzGGLu30zrhBQIc6bwchd
 Fcgr9rjBPG52QA70VP8hojLDT4ywIniM98PK+JNEQtJ82FYB6ZL3sl8l6WQiHIUCIg76
 nabTc6PzzuqYcVCzXM0cxuy7jzR1Fr6QIundTzF/fhuHLq6o67g4vf+az1qsidHfho9D
 4+uLekZxw2o2r9zKZT+VD7gNXN6pGk2CJZSfvxRpkij66EuLh55JSHZsVkbnrloobjZ6
 qd52lzRnjSx4tCl/xY/fqzh/4Cw4ilvGjRuP450CKjaMlYDfQd2ZbDDQKECUWMUG9TkE
 1JXg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778849981; x=1779454781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FxF+gkCL/XGZQRnWTlDkr1DjBsMHgjUI9orLdCXXXTY=;
 b=FDHKfxLkoJno2JJL5HCDBbQYp92js/dr0ftPf5FB7pDJopWLOjz1lWhVPDT8Yw1n7j
 OGPhQKbUXwOFYua/+ytHUABEEmUQG0HpYMzm+zrOnFUtQj6B5ZTT+Lm0becEbMRKnqvM
 94cugOUpW/13U0GaXwuXxqZevAAkRUUFiX2Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849981; x=1779454781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxF+gkCL/XGZQRnWTlDkr1DjBsMHgjUI9orLdCXXXTY=;
 b=VpaCoAt8YRR8EsFcOhB3zHWEiLEh9BcQDz4VX/GKN5GPQjM6kwvQjSOBs4h4JP7vFt
 rsAIJ1KRAWf5lZ06r4TV2P11DcFTGdVZk+UYi6s9UT5qbgiNqoQnEMwY9TpGeT24vJyT
 zyQGeNf8Upy2oolpQ7wTVYuyWDMdvO2LYlE2wqkLEirGvQyte1wIbGwidFymrCQ4Zkgs
 tDuiHOGmI1ZZKksjI7vGxA20eAwRgkybtwyJ3rlGyrllW0GOw7iSZ1ILi8PqzvZsA23A
 k4S2Kn8VX9H3dQfO0jdvC9TJGu7qeK55jwCZLI8m03on5fVCo/UvdCBh7lbMZ0dAUER3
 zJmQ==
X-Gm-Message-State: AOJu0YxqkIP+hACcR5v8H6mrf1y5sfACZ0CJJeTif+PzfOLdUmgEwVqK
 r8q3zajsWfARxrn+uk4KrxzW3VipDYMniyBrDu67M6AY0yKgtyG/F4CHHbF8biX/zB4zfoFl78l
 tDevoGgybFY732Py+UQj0PUe0MdyfrpdkjXqygsNKwSn0mRu7P+Tq/w==
X-Gm-Gg: Acq92OELEeTOx7JH278bAb1clqp/JdMzfGREFT/GaWwCHQM7D5Hh9pf+J2t8DUqAo84
 luxuFNPxGE0hZymRR+UY/GGo+VuCiyuAeXesI96t7tqcSO96nWt4+aEepXwfxchZtEN2/WsVjsc
 oRj6H0+UvDs1ZrbSiXnfpAv5GCujTtj/xflt9grkEmmme+LwVf4mCn3FUY5QBK1Ve/AV0lI/LQT
 suOru3vkGa+d33eTLCoO+7Ahw49f2K80rPKcQHLDkZObfjjiMDv+m+VdHu13xgGnmTNXVIluyiE
 g4RmudXPMI/3aQYqC5MQtiBP57A=
X-Received: by 2002:a17:907:e849:b0:bd0:6293:bd0a with SMTP id
 a640c23a62f3a-bd5177aa3e1mr211880866b.7.1778849981512; Fri, 15 May 2026
 05:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778657347.git.weijie.gao@mediatek.com>
 <4139e7bef0bb12225a18e3b205dd66b77d8ce543.1778657347.git.weijie.gao@mediatek.com>
In-Reply-To: <4139e7bef0bb12225a18e3b205dd66b77d8ce543.1778657347.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 06:59:28 -0600
X-Gm-Features: AVHnY4IpJmg5Ie8u1B5NcAuLviDfvJBzB_IEj9Kv9mZ6uLVoTq0pjcyvcm-7f9s
Message-ID: <CAFLszTj2akYxyTix3gLCgNo1b0ee7-mMnMvDxV+tPwtAQ3Uxhg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] env: ubi: add support to create environment
 volume if it does not exist
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-05-13T08:02:45, Weijie Gao <weijie.gao@mediatek.com> wrote:
> env: ubi: add support to create environment volume if it does not exist
>
> When U-Boot is booting from a fresh device, the environment volume may not
> exist in the factory UBI image. This is a common case where factory UBI
> image contains only volumes with valid data.
>
> With the current design, even if the volume is created manually, the
> environment will still be unusable (e.g., saveenv) before a reboot.
>
> This patch adds support to automatically create missing volumes before
> loading environment. This will make environment available at first boot.
>
> There are two options:
> CONFIG_ENV_UBI_VOLUME_CREATE: whether to enable volume creation
> CONFIG_ENV_UBI_VOLUME_STATIC: create static volume (default is dynamic)
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> env/Kconfig | 20 +++++++++++++++++++
>  env/ubi.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 74 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/env/Kconfig b/env/Kconfig
> @@ -716,6 +716,26 @@ config ENV_UBI_VOLUME_REDUND
> +config ENV_UBI_VOLUME_CREATE
> +     bool "Create UBI volume if it does not exist"
> +     depends on ENV_IS_IN_UBI
> +     help
> +       This option is useful if U-Boot will be booted from a fresh device
> +       where the environment volume has not been created.
> +       This is a common case where factory UBI image contains only volumes
> +       with valid data.
> +       By enabling this option, any missing environment volumes will be
> +       created before loading.
> +       If CONFIG_ENV_UBI_VOLUME_REDUND is also enabled, both volumes will be
> +       created,

Trailing comma should be a full stop. Also drop the CONFIG_ prefix -
the Kconfig convention is to refer to the symbol as
ENV_UBI_VOLUME_REDUND.

Regards,
Simon
