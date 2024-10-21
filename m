Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA3AD15D8A
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 13:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C8A88F0A;
	Mon, 21 Oct 2024 15:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WmpY6XW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC24188E61; Mon, 21 Oct 2024 14:53:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F97488E42
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 14:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729515230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pnN4VyRQXe2yB4lbky1d30Ntd0kIS67yIWNcAn13c24=;
 b=WmpY6XW6o8lVsf7pee7mV0D/y2LzNTPsOArc7we1nRfSaYvthMv4zBbZHhgjFn4Iv3KYTq
 J7yVHhwPxW47iUnOsGQZRYKZnW56LZxsfqODIrIf37IShxFaN/vG3wh6hCkSKaEZ6lK70q
 bE2aZADXAaaE9JI6QeFgKq8Yiqk0aF4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-o73koy5WOs2l6KNGASzk_Q-1; Mon, 21 Oct 2024 08:53:49 -0400
X-MC-Unique: o73koy5WOs2l6KNGASzk_Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso15399275e9.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 05:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729515228; x=1730120028;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pnN4VyRQXe2yB4lbky1d30Ntd0kIS67yIWNcAn13c24=;
 b=n7b4B1J6Ypjk8X9lfh2NmetxrCCO+PSAfOeEtt34vQ5PGk9GPskQ+aIC/7c7Za8tc2
 cbqh4DEXlngubh5+AuiLDGJTfMzQGREf0W+GWMj+0ap3Zf+fIQ3dK6CkNTJe6CvUqgN4
 8lhMcr04K/6lX0WHr7d+oXpnCGoMMUxnuECx1qC3Qtk5ygUZW2Ex9yS0H25D+LQd3xxR
 DrQuG3roCjdFV4ElAee59GkWS/tIwCDbjjOIbnBfB8kIeSY9PTt6C9f0POCHUM/t94iJ
 aJGBnWJCvuAOQ22+h4DGCoEu5ugdZefzEbUPa/P6gdvIyVdaniyoMgeVRvVZ7tpBGzOM
 9dgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrmVY2LhIF7PGnv5okoYsu4B8zTw3RE65xWuz8jCOrhdqVFGFeCkRipRCUn4UPPh4l1Nzgjgc=@lists.denx.de
X-Gm-Message-State: AOJu0YxOSJdgRLg4K+Md49BZSsgS5cBae/27TT8a40LiizrcRlpDV6+h
 +c2wAQ6lOoUDpI3hdQObV8NRrKz67NAMKAKAPLcQvZTnFCF/akfGNrXeuL4ftXwJnMy3n9EMRyO
 qNfKvxRAWWthLjhbUHL8beE4jYJZipI0CSWsZxIB/Zr+HuzUBMBE=
X-Received: by 2002:a05:600c:46c6:b0:42f:8229:a09e with SMTP id
 5b1f17b1804b1-4316168f9c7mr127596465e9.29.1729515228013; 
 Mon, 21 Oct 2024 05:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcolsidmEeOZZz2OB9ErkNh55uw6msGloUq7P0ZDEt/P9p+fjvNjvFcHYXoOqKA9ZspLGetA==
X-Received: by 2002:a05:600c:46c6:b0:42f:8229:a09e with SMTP id
 5b1f17b1804b1-4316168f9c7mr127596305e9.29.1729515227669; 
 Mon, 21 Oct 2024 05:53:47 -0700 (PDT)
Received: from localhost ([195.166.127.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a37b71sm4291666f8f.14.2024.10.21.05.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 05:53:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Enric
 Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 18/25] igep00x0: Drop unused status_led.h header file
In-Reply-To: <20241021113839.318572-19-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021113839.318572-19-sjg@chromium.org>
Date: Mon, 21 Oct 2024 14:53:46 +0200
Message-ID: <87r089r50l.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 21 Oct 2024 15:02:15 +0200
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
> (no changes since v1)
>

I've already reviewed v1 but you didn't keep the tag.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

