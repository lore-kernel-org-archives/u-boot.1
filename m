Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDEDCDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B9089048;
	Fri, 27 Sep 2024 00:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dsot7CN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC88988E5A; Thu, 26 Sep 2024 23:30:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A8B588DDE
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727386250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JhIUhSfqEs3b7/fQ/6ulsjKq/dBl6uE1L7vg3meKls=;
 b=dsot7CN1evKxn/aTQ5mLJmP3HKAHpjKR/a1j9rAYEF5FkRTjd0yJbU3BWXYxCeafFry+Lo
 q4b4VVmMDS+GTSbKggxmfrmUvkdvgawjeq8hTHAywk8B0b6FfycfIOhuGGFSizR4i/3Zrf
 AknIw4reTFrNKDNEBMXUTHCEizUZ5Yk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495--txKczlwP2-WcjGpxTv71Q-1; Thu, 26 Sep 2024 17:30:47 -0400
X-MC-Unique: -txKczlwP2-WcjGpxTv71Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb080ab53so10051345e9.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386246; x=1727991046;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7JhIUhSfqEs3b7/fQ/6ulsjKq/dBl6uE1L7vg3meKls=;
 b=DqrEy5nx4h/5w481JNujp0o4JWW86VUrA8fLSek7gxykwyQQARHKCrqwHnf9Kd2lgO
 L118UWtf9B8U77LW1GfLdFJi92e+lobMaJMBfZ1ObF95O48Yj+JEbaoxM/w//tuDrQDE
 ZYBe3NO4Zak2QAu/LN5lfTZLfo2xELLtkVfagotmAEOsTGZGK7Qq3uIiF1oUgzt6Ui18
 4g7XqljJbWKdJj6UnwGjS3nIdHoHnwc1zbRZDkZrURkmqlL+H8glAoyHkngfitZsJyhf
 6/Geo7jUBHHQ+P68IUeettiiwndmSwJeE2nVXLc3iruU9EE0jg36ZRAeHW+unOASH+YL
 J9Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Yg/U7UqRsq+fANPoFxp70qgtPrb5Q/XsJ1RWwgHoDmaJ2sIA7DfxoTdfGmfO5NrO9gx2O5g=@lists.denx.de
X-Gm-Message-State: AOJu0YwYJ+kzDLnLYmS+voLcECjL6BWN1JkFUiPxoGPBHQayG9ikah2u
 unQpAynbWwtkYF+6bpn0pxiL4n/IWsoUsbXTd0VCE+VIl/idtIDCNuq4BJsulSwCqOLtFbyLLpL
 FiPQHkkaACBIeYMNRP5NXjMS+k/7+3E+FOokUCwc+ceucQrnMuVM=
X-Received: by 2002:a05:600c:1f91:b0:42c:bc04:58a5 with SMTP id
 5b1f17b1804b1-42f58491434mr5899155e9.33.1727386245853; 
 Thu, 26 Sep 2024 14:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo4LFHKJmqzU8e9Spx0s6hN2/td6Q3cnW6+9uYm1d9QviTHiivnSY2KW2fLq3Oal01dwIoJg==
X-Received: by 2002:a05:600c:1f91:b0:42c:bc04:58a5 with SMTP id
 5b1f17b1804b1-42f58491434mr5898975e9.33.1727386245472; 
 Thu, 26 Sep 2024 14:30:45 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6665sm791887f8f.54.2024.09.26.14.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 14:30:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Enric
 Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 18/27] igep00x0: Drop unused status_led.h header file
In-Reply-To: <20240926204455.963584-19-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
 <20240926204455.963584-19-sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:30:44 +0200
Message-ID: <87ikui85mj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 27 Sep 2024 00:50:46 +0200
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

Simon Glass <sjg@chromium.org> writes:

Hello Simon,

> This header file is not used, so drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

