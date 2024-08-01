Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF52DC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40ECD88B40;
	Thu,  1 Aug 2024 16:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iuotvOos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACCE88B5F; Thu,  1 Aug 2024 16:42:37 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51FAD88B56
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b7a3e468a9so49654826d6.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722523352; x=1723128152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dx3O4PniHzVFOiLL78vH0A7bBaqkfecNs4WybB6jsYs=;
 b=iuotvOosCwGp2IFRVBNy3+Wpk3l2QVIvfAJA2ekpllSLnRxeC44SEV9EsuaLOMrR31
 A7XdkbS5HUmOLYhBiSW+m0mEbnzIEtcPbT7DIS5Ah/HAldTweVY3JjIJFhkTo2AqLw5h
 sJjes4PYC2ewCJTx7uyzRER2hup8VUwB6LV9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523352; x=1723128152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dx3O4PniHzVFOiLL78vH0A7bBaqkfecNs4WybB6jsYs=;
 b=remcMNXb76VeII5cL1M4/vtX9etHuz32pvNWQyec0O8xgXrT1Hbj8QNtiTLFpubw+R
 2O0BrAJqcCWaWRyzo0W7eFrAETy7Blda8GyDAOpgq+ugSPyywGIzUp7zxOzYpeL3AArY
 sMYq+9YkkHKKBzzfRjq0T/crSAxCIAweD3sBj6QDjnLOYS8bLy8tEDwF4D1Ne7C76qft
 pZvL8Y6boIfcot8ItO9aO7TkGVf22mVBLIj/yMYc9i94RZW7/ieOzyCoQItXneJMMHOP
 tgvUPVWzFE8RrY0QmXTAHmm6zE9G0sUrwDdulOxvJR+3uKzPJKnh6jfpKz8uO4Oe3gvb
 J/cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm6pSZGSoDM51ynfxQ2x0bria0kTBjwKo7hgGFWsSc2JoosU6WYGMotIhxGnMC80ZkdjnCPY7gKnqqGgT4e9gnFysngg==
X-Gm-Message-State: AOJu0YyNp5AR3QkWJdwfD2FV9hGsCaL5zh/WtN/q6E2IaCGkemnsyNZr
 6HCHwwBnUHq6SOeiYfTOBGDV0yVuysC/xLgUnFyXJVvw4AvMAIoyF4Tuat+lqyOnwZGN+npNprl
 h0oLW2BSTYrcaHhP2sNIIAMvwcTpWJ1P0/Ora
X-Google-Smtp-Source: AGHT+IHxRPZdiINUhUWDXPhf+Yo9LE9p77HhlElagRQ0pDCYb2cv8nEa5MhQk9/kG6xobgoEagm9vtEAE8+CS7UofNM=
X-Received: by 2002:a05:6214:4a02:b0:6b5:8dd2:468b with SMTP id
 6a1803df08f44-6bb98482365mr4429016d6.44.1722523352131; Thu, 01 Aug 2024
 07:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240731134257.686017-1-admin@hifiphile.com>
 <20240731134257.686017-3-admin@hifiphile.com>
In-Reply-To: <20240731134257.686017-3-admin@hifiphile.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 08:42:21 -0600
Message-ID: <CAFLszTix0ooymfjCL=QSM43NCaF9a=x_3p__KRPPEPWfzw8Dow@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] dm: core: Show device sequence instead in
 dm_dump_tree()
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
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

Hi Zixun,

On Wed, 31 Jul 2024 at 07:43, Zixun LI <admin@hifiphile.com> wrote:
>
> Currently uclass index is shown in DM tree dump which ignores alias
> sequence numbering. The result could be confusing since these 2 numbers
> could be different. Show device sequence number instead.

I think it makes sense to show the seq instead of the index, but
please update the header for the table to say 'Seq'

>
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/core/dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/core/dump.c b/drivers/core/dump.c
> index 5ec30d5b3c..c812d87fa4 100644
> --- a/drivers/core/dump.c
> +++ b/drivers/core/dump.c
> @@ -40,7 +40,7 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
>         /* print the first 20 characters to not break the tree-format. */
>         printf(CONFIG_IS_ENABLED(USE_TINY_PRINTF) ? " %s  %d  [ %c ]   %s  " :
>                " %-10.10s  %3d  [ %c ]   %-20.20s  ", dev->uclass->uc_drv->name,
> -              dev_get_uclass_index(dev, NULL),
> +              dev->seq_,
>                flags & DM_FLAG_ACTIVATED ? '+' : ' ', dev->driver->name);
>
>         for (i = depth; i >= 0; i--) {
> --
> 2.45.2
>

Regards,
Simon
