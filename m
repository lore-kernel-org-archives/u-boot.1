Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DD5C7114A
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 06:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4637880C83;
	Tue, 17 Jun 2025 08:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Djd4jjZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 320D782B0F; Tue, 17 Jun 2025 08:17:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB8628070C
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 08:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750141053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Smu9Peb2wBCZoPb9D6A85Vu7HXQARZRwS/N7mQvLp8Q=;
 b=Djd4jjZHs/lwtlXHvi7dZUOUbC4fuuFvQA3GZxWr8dZHx32zG1VRjon2WY4l6F+rEHGDVT
 9hfL1bD6YErGNA2P5Yz687Vy5WkD59x8KZ8jB8lEwMtVoTk0gO0Y+7cYnXxBky82209nA5
 Vt950kLKA8tZgJGqyoRNeZttL3cUDxE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ATmkyzPpNqq4WVyMFDgw4Q-1; Tue, 17 Jun 2025 02:17:31 -0400
X-MC-Unique: ATmkyzPpNqq4WVyMFDgw4Q-1
X-Mimecast-MFC-AGG-ID: ATmkyzPpNqq4WVyMFDgw4Q_1750141051
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f7ebfd00so2423772f8f.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 23:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750141050; x=1750745850;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Smu9Peb2wBCZoPb9D6A85Vu7HXQARZRwS/N7mQvLp8Q=;
 b=ZgN85eMBbHeILfVf80jZsBixzpOUVaOXZuKaay5D9uoGFL5sRIu3wGD4aPybWfzMCX
 1PVF2FCNRxlTs/iwACOVJOyy6zM/o1giUqoUOuN8woNISh98fmA76UY00OJp2ioRkWE8
 EGd3civfpubNhXn6D2JGMg2coRqhhiSLanwEcvDs18ievWMZo0KQlYlwpxGsTF89GiS2
 PFO3yUDT51PV3UjBBxH6Xou4c2+UL609xzY0yTQGvOD2H4rqigECNA9QpNfXqinntZ3a
 jD2zXlmQWXx6UASmsiDDm+c/7LuIJf9pV/4t9Bad+1RGWBOKn+/M1EzptkhCvZAA97H/
 hEzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCHe6vvmQ5cQpiDsR3TwsUOVeg+c1jcHskJFmJrMSZrIPCvnhbeYjHp+cVxlA4cGYRFos9Ep8=@lists.denx.de
X-Gm-Message-State: AOJu0YxQI0/n6842kV2ReohG0KLMyMcNN12FApOsbgNEw4iHtc0MZ2zf
 iGBoYm6XUCbWJMZMWjowEyNUCw7uUNeTGj3eV5D8/XVsaXlJlPEieBxSIy6h2bhYKN/0/SgLG8n
 Rog+MDYGYeSyeAtYcHnot0WImcyxXqgmb5M8p2M0XXSSqgHroFUCrJqM=
X-Gm-Gg: ASbGnctpji0LNr6bQTlWiPLLjRqTpTwmjFtYczdDhpIEJCV9xyXSPI8Oc6UJnFKdwdJ
 rz/1Iq5LZX66UdPoifEdWEnG/zDgA0JqbrvwjRtSGFW5exQh8jHwr4rHSMaoBjTGhvukJ8xRZ7P
 ycxf+NT4nE0vehAejIa+P1HymvvnF0TwNZAv6QI1ky9pLJDN1TZ5HVM0Db3EyZvRSc+XLw1r27S
 A7FG4zfKxMcNAu77kOI2HzNgAbnDTX9s4f01nCojP6TJu7B2/rlNSdWnUEbUXaA0HvqTkL3Ps9y
 dXi5c/N5h9LTJQ2CcbWDb4xhQGkljciXkIuCsZs/8SnRabB9RA4nR31C7MJfExNSyo9jgpjGybI
 GLj61
X-Received: by 2002:a05:6000:4105:b0:3a5:8a68:b836 with SMTP id
 ffacd0b85a97d-3a58a68bccfmr324053f8f.44.1750141050621; 
 Mon, 16 Jun 2025 23:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/0gKOa6mGJFmB2Rw0DYZYe4raQJTzGanZ3+mWKdtqZ4EIC2Z72NyCU8XgXpEs9Po03k73zQ==
X-Received: by 2002:a05:6000:4105:b0:3a5:8a68:b836 with SMTP id
 ffacd0b85a97d-3a58a68bccfmr324032f8f.44.1750141050290; 
 Mon, 16 Jun 2025 23:17:30 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a7e51esm12816775f8f.40.2025.06.16.23.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 23:17:29 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yu-Chien Peter Lin
 <peter.lin@sifive.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 2/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default
In-Reply-To: <20250616220917.34189-3-heinrich.schuchardt@canonical.com>
References: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
 <20250616220917.34189-3-heinrich.schuchardt@canonical.com>
Date: Tue, 17 Jun 2025 08:17:28 +0200
Message-ID: <87o6umdh8n.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WvwBKNl7UCVPwr36c_Zfy8_FyifH3cwL2-ve2quPotY_1750141051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> writes:

> The sandbox is used for a lot of generic development, we should run the
> UEFI tests there, too.
>
> Reported-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

