Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373D1C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 20:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1164388103;
	Wed,  5 Jun 2024 22:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HoPnjqWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7369E87B4D; Wed,  5 Jun 2024 22:09:10 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7951988356
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 22:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6ae0adfba9cso1182966d6.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717618146; x=1718222946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5UrBwgEiXVqBKQ3lrxXwhyHNQnXWqy4vOSKW5b4wL0A=;
 b=HoPnjqWwkbHbr7LkC7ekluYdQf/71TkdQfSmAPesi8pmAwnRg1e6wr8KoJSW1hkFkw
 k/hv7y5WiqU0Rgn/YhNyyjLUWZP7MllFjLrJm9iJY+ZD/QfClgYvlkRfJ0Hjjc8R9IPT
 oSgnCxv7QgbeobLqGBWzTx4JgcUOHJ6mLdnFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717618146; x=1718222946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5UrBwgEiXVqBKQ3lrxXwhyHNQnXWqy4vOSKW5b4wL0A=;
 b=wefSXaE0cEqKm1tX2Eiall8MsfVK3dZpoN5bO8wTqHieQF8fyBlKCPo9fUrJzkFRls
 J8IpvA/a6Ha2hgG6QIASIncyGX2kEb0vMHhxRRkrOz+PEp+VXnq8CjkQVoO3Fza65nWD
 6GMuKxQw0axjv5Q1j/SJZv4aR1wx9owzE5WpYNGyrqUzIpRVFxEbV7NySua+MI07oaGO
 0q6fXhCwjX4M9kyYYxWiLqKyBmylaIXyiZSCHWCtRNzKLMctSfGZVsgz+AoZrfV40YzQ
 zb76ZlCya7jLQIAvMRDtMQc/ReykemEpK+V2zv9kkx1qGsiz7MeYv946YGcjaQyv+fHP
 aosQ==
X-Gm-Message-State: AOJu0YypTU6JW+aVmR9YxBhMY94Zb79RrmJCzC8Zw+2dObIH2DdOph6Z
 rvbz+kaWLudSyL1TquJ+l5bIszi3rgVp6Au5RbcHNybICdbC38bAp/kkjPXQz21mjpy7N5o7IlW
 HPfzwrj+4OyJVKHllWLGBNA0nUkNDx9PoXgPZ
X-Google-Smtp-Source: AGHT+IGL5uEtnumJxrMU6jclK0TSY1gzVtgZ3gND+TwLiPA2LSQF78Ysc2AMVyQb6GOvKuHxYgP/JiMgLa/4KZioHeE=
X-Received: by 2002:a05:6214:3c88:b0:6ae:d65c:7c9a with SMTP id
 6a1803df08f44-6b02bfa1747mr45597246d6.43.1717618146286; Wed, 05 Jun 2024
 13:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-10-sjg@chromium.org>
 <20240605144224.GR68077@bill-the-cat>
In-Reply-To: <20240605144224.GR68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Jun 2024 14:08:54 -0600
Message-ID: <CAFLszThEeXFtqf-Yk+_WbJ2GJtkFdC-R-_nWH2HAE9rjn0d8ag@mail.gmail.com>
Subject: Re: [PATCH 9/9] Revert "arm: am335x: Enable SPL_OF_CONTROL on some
 configs"
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Tom,

On Wed, 5 Jun 2024 at 08:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 04, 2024 at 09:25:21PM -0600, Simon Glass wrote:
>
> > This is a partial revert which makes boneblack_vboot boot again.
> >
> > This reverts commit f4b64e9736e73ceec14d51600bed9a8ac48f9fe8.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  configs/am335x_boneblack_vboot_defconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335x_boneblack_vboot_defconfig
> > index d473a1a793b..3ec4abddd77 100644
> > --- a/configs/am335x_boneblack_vboot_defconfig
> > +++ b/configs/am335x_boneblack_vboot_defconfig
> > @@ -40,7 +40,6 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> >  # CONFIG_CMD_SETEXPR is not set
> >  CONFIG_BOOTP_DNS2=y
> >  CONFIG_OF_CONTROL=y
> > -CONFIG_SPL_OF_CONTROL=y
> >  CONFIG_ENV_OVERWRITE=y
> >  CONFIG_ENV_IS_IN_MMC=y
> >  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>
> So, this change was a while ago. But I did it because some of the
> drivers, tho I forget which ones exactly, really were not functional
> without SPL_OF_CONTROL enabled. That said, does am335x_evm_defconfig
> work in your configuration? I think we have to keep am335x_evm_spiboot
> because it's so radically different from how the rest of the possible
> options boot, but I'm not sure we need a vboot defconfig? Or if we do,
> it should be updated to use the #include logic these days.

I don't actually have an am335x_evm board, which is why I'm using bbb.
We only have the vboot version, since the non-vboot was removed a
while back.

In any case, with this patch, bbb boots again.

Regards,
Simon
