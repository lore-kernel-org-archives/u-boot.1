Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0FEC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D81A88898;
	Mon, 29 Jul 2024 17:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NLb4Goyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 689E18887A; Mon, 29 Jul 2024 17:28:49 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6237D88835
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b797a2384cso17710566d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266926; x=1722871726; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gu02446pudOxl1JT0WegvBm9A+6YVZMK+iXZGCq8v3o=;
 b=NLb4GoyxSQRTPhyyHbdPXxo/RppfriaQ68xKmi+LakbHE6K/qQYszIKm7g61Co54hk
 KadJ7vgr9r18hYg7kA9DB43o5B+IqEDX5lMsvrSqKikgkmGsBpxCdkN8Z4AUps+Kk/E9
 EMnWgI48Fvs1FYyZixk3OtF/CV0xVeRD4Z9ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266926; x=1722871726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gu02446pudOxl1JT0WegvBm9A+6YVZMK+iXZGCq8v3o=;
 b=sEBZDWNTLINjkWs4HvgD1W6We01SnCqQoccJVu7/gyXzCthRjl+wurAqPBXQxkzeux
 ga75GdG6pmdwZy+Ii/lEIQvkxxnPm8gNMBUkjGHAU7p4PjPN+kuwKWDxib2OLCsYz22q
 ycPhig8xnM4yqT8LO6mynPMy2bS2J2A3ae4g7ujoDJu/uWzzsCdYmruUbvNbOcRqwUJz
 ZiF8AukNl3m3htfErqmPjC1QMFPfhkv62HCovxii+gkyYUMMJHpWzjsC1v3Wum7bA0Q/
 t57Dkb2BruGDd9Qd/frSc3KRjoflmnlzOKxxAXR7TN4f7s34btucI42hLKnKU8JFlFT9
 bICw==
X-Gm-Message-State: AOJu0Yy3ZSW82JFm9weemN4xHqbSttTAWW8/bZqcuaCRWK0r+TOUQIEs
 DbcvbNWCd3qgU7UDVGndKOsjhujrQs6n90y+VVKV3lI2ke7+zpEZ0boQ/QGjh5quVhNZS/3eR8g
 jlTbo69exx0C6iS2yj0r0jbrADsY69nQIEmmM
X-Google-Smtp-Source: AGHT+IEPdD3MVhOl+R9sMMGwS47PhGJF4PXjx8ZQO0a5ziMR3o/oQrMiNChpOwWe793p/uIqer8pKm+feAIX6WMPo6k=
X-Received: by 2002:ad4:4eed:0:b0:6b7:a87b:e9b9 with SMTP id
 6a1803df08f44-6bb55aa04f8mr118731676d6.48.1722266926338; Mon, 29 Jul 2024
 08:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-6-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-6-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:35 -0600
Message-ID: <CAFLszThx58gUURPicts3cwH3UcFyr1FHFPfqvWfGXuGaE4=Tzw@mail.gmail.com>
Subject: Re: [PATCH 05/17] serial: serial_pl01x: Implement .getinfo() for PL01
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com, 
 Maximilian Brune <maximilian.brune@9elements.com>
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Maximilian Brune <maximilian.brune@9elements.com>
>
> When ACPI is enabled on arm it will use the getinfo function to fill
> the SPCR ACPI table.
>
> Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  boot/bootflow.c               |  8 ++++++--
>  drivers/serial/serial_pl01x.c | 24 ++++++++++++++++++++++++
>  include/serial.h              |  1 +
>  3 files changed, 31 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
