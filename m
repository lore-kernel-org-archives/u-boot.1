Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5342C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 19:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09CA889B6;
	Mon, 22 Apr 2024 21:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qf6d0jjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 562A2889B6; Mon, 22 Apr 2024 21:36:04 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A53889B9
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 21:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5aa28cde736so3009468eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713814561; x=1714419361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wMK8372XYiOtoRZmKpDP1tyJFP9vJPNeOXN9L6aQZRQ=;
 b=Qf6d0jjEZFtexUA5D71E9oDPvsA9/haY0FEQbuLsXryU49xDb6FBylesCayT+bRFc1
 7fCvRphHtErfwCZYc9LsYp2sroOa9wOA617tuzqmPnhLVJp5HKiTU2ut3oXvjDifKwE7
 MAA4QzHIIaeX4hAxPyofg/dZUn4RIf8kw6cQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713814561; x=1714419361;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMK8372XYiOtoRZmKpDP1tyJFP9vJPNeOXN9L6aQZRQ=;
 b=YIkPWipv9Ie/xSHUL0fykIkzdELrnLOu9PuO04D/+mAO7PxYY/sYt/3DTy7Uy09act
 0zGv9HBKuTfXrRM1QkWlPGJSR4vw4TXqq0YE1fXIQtTYJqUOrTQMwAJ8LSo2D7COGuUV
 jDhz36uwW2o7ye3C0IjJYycwasY/iZthH31x3CQRW/diMUMjD22CbHY4P9K0InZp8588
 HW+6qi5FAVagCEMhCEVCjiiPIgyYienEUALpjYj2djL2+CT67MaQggv/0GqWtGWlRvI5
 pwVtmJDkY8ajhrE2gdhzVidUNgWEu3UICFQETd3kv3SZ+ZGhPv4WYBNzgzumChvdVSUa
 q3YQ==
X-Gm-Message-State: AOJu0YzsyhxMnIRcIj0tjGv0//GiSJUUXpW9fuVmzJL22P7VnWtLn79z
 AHwjaHKKDqdyeCbkKfHbgsz/UEGnU4MRO4/TgDUq+uCMEyUNe9T9xpYcxOsrRGZc9176hutpyXW
 zJ8TlrQ==
X-Google-Smtp-Source: AGHT+IGwwnUqKNZVkiGyCXjrjI9cYSTZjNlpuA+R1uL9OEPUPaMve0PwUqrzxTZ0Bw6H3wxlLBMOXQ==
X-Received: by 2002:a05:6358:5d8d:b0:17e:b887:5558 with SMTP id
 s13-20020a0563585d8d00b0017eb8875558mr15276892rwm.7.1713814560691; 
 Mon, 22 Apr 2024 12:36:00 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 kk3-20020a05622a2c0300b00436b2135b51sm4492448qtb.64.2024.04.22.12.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 12:36:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240422164454.1900211-1-trini@konsulko.com>
References: <20240422164454.1900211-1-trini@konsulko.com>
Subject: Re: [PATCH] doc: release_cycle: Note when next branch opens
Message-Id: <171381455969.1909236.1278566855247229308.b4-ty@konsulko.com>
Date: Mon, 22 Apr 2024 13:35:59 -0600
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

On Mon, 22 Apr 2024 10:44:54 -0600, Tom Rini wrote:

> While I have said this in various release emails, it should be
> documented here as well that the next branch opens with the second
> release candidate.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


