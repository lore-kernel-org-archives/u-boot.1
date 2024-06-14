Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92F6C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3675788A1E;
	Fri, 14 Jun 2024 16:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HFeIV/tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3AD88A21; Fri, 14 Jun 2024 16:54:31 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 784E488A06
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-25606692f1bso1047947fac.3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376868; x=1718981668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s9ZEBQ0tr9CYiqVMKUMLwvy0+HqsZNXpIKUh6BHCgRk=;
 b=HFeIV/tw1ioHFPX2QDZvKl0LryU1DHtkvLSHmt3QHQFCvIDouI7PBrvldM44r/KZbY
 9CGp6YfbzRlxy/uaGZVt8JMYGn+1JZ4khygDIpZbBBx+ro/aPZ7u2gvDlHciYFRp5XF9
 kfprUnIGuZOoz/6vR0iEC0OEGJwt3YEfZDNNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376868; x=1718981668;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9ZEBQ0tr9CYiqVMKUMLwvy0+HqsZNXpIKUh6BHCgRk=;
 b=lpJabyYFJxejJNm0QJkRpbl1i+6Ir831rr5q/D5cnVjMefzlSX3S7c9DJJPzOzOWMn
 J+2CcoyKMXq4kZNLDeq8RVlBT/pLWEMTChFpUwmgUYRyKFvD673/ZKJi1AXy9q1al6f1
 fTEAD3XFQfDdIn8fYqlKprjv/xamOnlWcuJCIm8CTeO8FLendfcfcCjsAFyr9QIoONdv
 bgmnV1FXfreh4lHpgNe6N03NyTPjw4zdNVcyqIB3YgJVIeJRrXDhWnB76gUmKMoqY6Zf
 TTN7dz/XqirjjMXU47+TE1Q+qnOqd0i3/rP04rJYyDYHOrlECV8jh4Kl6H5yMzdcCYmT
 GmYQ==
X-Gm-Message-State: AOJu0YyF1XwB+CT48i65+8fRB4MzxiC20h4C5WLuLzcvRAoKurh4vuYB
 EmiZsvCA7JxhL+Lmusa14iv9YxkfNRDw7kky2wdnA5QozebpcnBefVoAyZtfvLceNXG2iSiPbpn
 SnZ0/WQ==
X-Google-Smtp-Source: AGHT+IE69hlAFrfmfabUBsVvfJkOAcdiQ2wLEfExSGYk/QK1J7eVxSUtNxzG7/lyEguo4+ACEL0mxA==
X-Received: by 2002:a05:6870:d107:b0:254:ca65:1ed3 with SMTP id
 586e51a60fabf-2584288c8f8mr3123500fac.2.1718376868301; 
 Fri, 14 Jun 2024 07:54:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dmitry Gerasimov <di.gerasimov@gmail.com>
In-Reply-To: <20240602152613.32338-1-di.gerasimov@gmail.com>
References: <20240602152613.32338-1-di.gerasimov@gmail.com>
Subject: Re: [PATCH v1] imxtract: add support for zstd-compressed images
Message-Id: <171837686784.2655592.12478570162499827872.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 02 Jun 2024 17:25:52 +0200, Dmitry Gerasimov wrote:

> Allow extraction of zstd-compressed images from FIT using imxtract
> command. This is especially useful when one has to load an image via
> some interface (e.g. SPI) rather that just to the memory.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


