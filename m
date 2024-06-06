Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CB1C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068FC88423;
	Thu,  6 Jun 2024 17:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h8KIlAnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F28788453; Thu,  6 Jun 2024 17:04:28 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2399883AA
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6afbf5b88ecso5475046d6.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717686265; x=1718291065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w1WvdJKPP4mGxg59kxdIKAcApExEBhQySZUao0Y0SA0=;
 b=h8KIlAnhZ34ydxghda7FD7L1ahsitoHEtW7x/zoEhIy+y3gr2TOcOPfNelHGI9N7G4
 LTWZfGZ2Uhmhw3s0Gl4PCGvyhXlSrC5V32X29l2RRCN1oTUHwtQ9rwpwYS8fcyoy1Rpg
 HIoYSLa+LKmzyHZ3ljQdIdWVAuhjwMd1kBIzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717686265; x=1718291065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w1WvdJKPP4mGxg59kxdIKAcApExEBhQySZUao0Y0SA0=;
 b=L0XpAPGUvY7CPaS34wIRr0j+53aHDHdSf/Ywx5YBTuaer2nT/8uNFmjeTo3uNaRRjU
 ayawY8IVEojNtVe0muJG/SLBGywahHpqEMt4C8XcPHE5/B7XPdeLf6fY0xJTJuy3KofB
 stIYuYSKkb/rwQWIkzibPHcERVN+SVQiZV5KYBYQ41o4AFjJicdMmCpDu4HbhlOvbu0P
 h4teUh6fU8x8zN38RVq8XPsrvWGJ+CFt2f+cKErzuUkpn1KPqf08ABwiS1sMnEkz/4WY
 CjgUR4L0Ra3IoNwvKXHiJ/tWdez8abRWdeBK/ie+Gayv/Xvift6H6WhTTi2NuXNFAUvu
 +G5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu/NSR6VualnDOsjpdvhzHqAMXz5b83pUyZVCtOHrgBUiMJMURjLAicU+fw8B/O9Jpt5JfPKiUHar81Ije5z/oCAOomg==
X-Gm-Message-State: AOJu0YwJrTm3+G7WxhmiQogMRNZEPTOsYr5hRKEtTgF4ESCH3A16sw5W
 LegVkhNlWxym9a1GuS/+Po6DYu53CUQMPB3EWRQTQ5U77t5+eBTwFBLg7SXimirkXJzgf6xbahH
 UthlYIO/iOhR9zZSGdyfjMmF2bQI88jU0xztw
X-Google-Smtp-Source: AGHT+IFIivq+coG0csLNe7nqyD0AcE3kOaCPbYKWNF0sXoYsRZq3ZJGq+TPCXxwHIrCTaK7txTq554P4y0ua4t/WHVI=
X-Received: by 2002:a05:6214:498a:b0:6ae:4e11:8c34 with SMTP id
 6a1803df08f44-6b030a6fae8mr65095506d6.52.1717686264605; Thu, 06 Jun 2024
 08:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
 <20240605-pmic-rk8xx-v1-1-2349fdf68aa0@cherry.de>
In-Reply-To: <20240605-pmic-rk8xx-v1-1-2349fdf68aa0@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Jun 2024 09:04:14 -0600
Message-ID: <CAFLszTi8EBc8PJ20qyNSXBYBMwHB8cpb7C_6LsKWZUOg6oqZOw@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: rk8xx: fix incorrect device used for
 _ldo_[sg]et_suspend_value
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 5 Jun 2024 at 03:33, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> _ldo_get_suspend_value and _ldo_set_suspend_value get passed the parent
> of the regulator (so the pmic) as first argument, therefore this udevice
> should be used for pmic_* callbacks instead of using the parent of the
> pmic.
>
> To avoid further confusion, let's rename the argument to pmic instead of
> dev, highlighting which kind of device we expect as argument.
>
> Fixes: f047e4ab9762 ("regulator: rk8xx: add indirection level for some ldo callbacks")
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/power/regulator/rk8xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-bob
