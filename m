Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE52C35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 03:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB25E803CC;
	Thu, 20 Mar 2025 04:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZDt+8+Wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F88809D4; Thu, 20 Mar 2025 04:39:41 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5536C803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 04:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so538103a12.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742441978; x=1743046778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0nkNmLhJ9YsT95wGpmPPm57xNFORphIoQX/KhCDleHg=;
 b=ZDt+8+Wp7+YoYbY00s/aASGFc1TA4pGdK0ZNNMH28ING3h5VRS9ztea8xdk4h2B+cD
 sKb3EOy02gkVjhTXfIvrdfVhJzQmR31vuZ5GHztrZuwHW79QUg6uuQ0NX1hS2+Tj4saw
 5s6aW4dnt1OylAxHHrguKYAc2xGKNkkch5hQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742441978; x=1743046778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0nkNmLhJ9YsT95wGpmPPm57xNFORphIoQX/KhCDleHg=;
 b=HoKrkfmEpEYrKc4X4hWBmdqA9l9O/AkEhiWk5q/DVanXdqpMB6K+BeVvthL7tpJHOq
 KV3Vr8x5irz+pVlUo3ftz6NiWI8FiYOk1SE/cJ5gHrtM7u/2H0V8bXbB7ydxmzE8Rsul
 y2SFbbKYMiTdeV4qmojB7TEvpJnddwqzfkzPUDw+wPhGOQBV1N5XGOrKnpNTzy+Vpi/E
 TYgJouqRCjAUOfCxDS3y5hpmNhP+0UhUqROnb5iPBsSgoni0yiGY92LNdHiZL4vV239A
 AVG3+nKMBj9U/7a0oUC+Gzn9KQ3yUhES6tSZQGmq6se7zOWA9RnO2q8K/JcZVPRGBGKt
 0ueA==
X-Gm-Message-State: AOJu0Yxj2IulsdpO7rjAgKiCuouasyvxZQ0Bp67GHPMvjBgao2wcleZE
 Qnzn1nEdUiSU5c59b6LCP5dNMg07EH3SkactQIYUxCKnslPv4zSp9YhquPkSbIUhNeSto7qW/VL
 2pwjHh7zZbXnFi+ztO1fVWSKs9PDv2T/0ui26
X-Gm-Gg: ASbGncvH2juKYtlFXjuADdSAX0Xz7/HpVljNi66vT+LgVapsmuZm8oc4n/5VfcihJUc
 N30qzGXYONTbWRuPqZb+8KjfaxE8VrHU0BGdjjJXEssNhz237+rHp9EtIWpE8O2hpNph9LXGhXD
 kQ+aAK1EgVhyUKFcjliFdpnQPxfZo=
X-Google-Smtp-Source: AGHT+IGOooJ+sKEeaZ5UbfqHcQzTU9qCKLP8pHPYFSezmgrJMopx3d2SyY58smaNGP5axNjP04UYSG+yTEXd11Nfn/g=
X-Received: by 2002:a05:6402:2810:b0:5e5:e022:a73d with SMTP id
 4fb4d7f45d1cf-5eb9f6c4270mr1564227a12.15.1742441977685; Wed, 19 Mar 2025
 20:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250319145512.2391122-1-sjg@chromium.org>
 <20250319145742.GI2640854@bill-the-cat>
In-Reply-To: <20250319145742.GI2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Mar 2025 03:39:26 +0000
X-Gm-Features: AQ5f1JqxTT07N2WFmiPwhTCQKY5CvHikfyI9nZHyOTHA95khvGCferlR2V7UvFM
Message-ID: <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
Subject: Re: [PATCH 00/52] expo: Various features and improvements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Julien Masson <jmasson@baylibre.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Wed, 19 Mar 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass wrote:
>
> > This series collects together some new features for expo to make it more
> > useful for boot menus:
> >
> > - measurement and display of multi-line text objects
> > - internal alignment for objects (e.g. centred text)
> > - editable strings in text fields
> > - new 'box' object to draw a rectangle
> > - highlighting of menu items, rather than just relying on a pointer
> >
> > Expo's boot menu is restructured so that it is possible to iterate
> > through various bootdevs and update the menu as new ones are found. This
> > is more in keeping with how bootstd works.
> >
> > A new textedit object is added, intended to provide a simple text
> > editor. Future work will complete this.
> >
> > With this series the boot menu has a better layout and appearance.
> >
> >
> > Simon Glass (52):
>
> I see you haven't internalized the "don't post massive series" feedback
> yet. Please, stop posting massive patch series. Figure out how to
> logically break things down in to smaller chunks that can be
> meaningfully reviewed.

I could split this into two series of ~25 patches, perhaps. Would that be OK?

I believe no one else is using expo yet, apart from postmarketOS,
except the trivial case of 'bootflow scan -m' but I'm hoping that will
change in the future. I believe that Linaro is mostly encouraging EFI
bootmgr and the text-based menu. That could be converted to use expo
but I doubt anyone has looked into that, particularly as grub is being
pushed as well. I did look at converting the existing menu code a year
or two ago, but it seemed better to eventually deprecate it.

Also, there is a following series which I split out and will post
separately, but not for a while as I have a lot outstanding.

Regards,
Simon
