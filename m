Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7FCC27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B4D884CA;
	Sat,  8 Jun 2024 00:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hb6YJtwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43298884D5; Sat,  8 Jun 2024 00:03:47 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5B988485
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-24c0dbd2866so1352954fac.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717797824; x=1718402624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wC3Kuw+gdRjc2wPOJ/arCJ+FfZ6Q8wwYrk/CSxCDSmY=;
 b=hb6YJtwkjKZ7Ji/MYzT0W+12IGF5XZj3HNjZ76SfJJ6edbLl/c+rXHUOipGfHo+S5l
 YK1/xX+SnDleW1iKevtsWOICInvO6s7sGonq6wXVKUu8Uv7WMb+sTFJWPRGJs+61NvYQ
 o2coNGD9pNC5Mm07KQ4WMA5BZnk6fN/pDYxIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717797824; x=1718402624;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wC3Kuw+gdRjc2wPOJ/arCJ+FfZ6Q8wwYrk/CSxCDSmY=;
 b=puMex/5vALa8BRoer3fq3k5m1y50ZNn1khD7T0P2U7UyqIBfUXi34QvLf1W+KxJSAM
 gjMfb6ntWQOx5O5MsS/X1TLQgErG6x7N9EmYWfhbercWe4H4jLJstXbz1dDn0c/BTFi0
 TizInTOShQ1GxcY35eL9ol8Ucy8w6lAELxZN85PeNa6qq+a2YT0DHMVEiYXoH2ieyLDQ
 9ueq8RAxDxUzKKMi+tJdADTAo2C5goHdyIVRVIuGbJ3mI9BE+DvdQQ+A2/3IEhMjzbBc
 0Wrgmb8qre+zPCE9TqEUnuwKkxPOfnnc9bWZW1hFdGW57WLJiEI57MfJsohAXPZFGFCj
 CL/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOY2ucZT4LhXbjs+yqoCNkoZpqcN35qeUHNs3fuvcJvayCejoK/DJk6IyhGKTwGDioPh069tCqerhTh6/LKzcsdO9K9Q==
X-Gm-Message-State: AOJu0Yzi2Y8kybcOThbS9AZMnKXDcq9UWuzJlVto9T8lnxONFEaJ3X0g
 KAAn9m2yX+aCKlCEeViHnp/Jr8wAJVtQEqt2GQraUAHRSXbdazGhwHzn75JJFEQ=
X-Google-Smtp-Source: AGHT+IFezrj18xHNAO5B3yy7iVLTh63Jxx6MiOqpdJyLFjndtSwFyjyviSZRdHYm7ehsu8CXy6UYFQ==
X-Received: by 2002:a05:6870:32d0:b0:24f:c31a:5c29 with SMTP id
 586e51a60fabf-25464807a5dmr3616671fac.43.1717797822930; 
 Fri, 07 Jun 2024 15:03:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254951da4d4sm58415fac.47.2024.06.07.15.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 15:03:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, nm@ti.com, Udit Kumar <u-kumar1@ti.com>
Cc: joe.hershberger@ni.com, m-chawdhry@ti.com, afd@ti.com, devarsht@ti.com, 
 sjg@chromium.org, emanuele.ghidoli@toradex.com, 
 matthias.schiffer@ew.tq-group.com, a-bhatia1@ti.com, 
 vitor.soares@toradex.com, danishanwar@ti.com, 
 andriy.shevchenko@linux.intel.com, bmeng.cn@gmail.com, 
 mkorpershoek@baylibre.com, s-vadapalli@ti.com, u-boot@lists.denx.de, 
 joao.goncalves@toradex.com, hnagalla@ti.com
In-Reply-To: <20240521105648.3780072-1-u-kumar1@ti.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
Subject: Re: [PATCH 0/4] Adding support to load secure firmware for HS devices
Message-Id: <171779782128.4156831.1892881409760456881.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 16:03:41 -0600
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

On Tue, 21 May 2024 16:26:44 +0530, Udit Kumar wrote:

> Some use case needs rproc firmware to be loaded at u-boot stage,
> using following commands at u-boot shell, firmware could be loaded
> 
> => setenv dorprocboot 1
> => run boot_rprocs
> 
> For Secure devices, secure version of rproc firmware should be loaded,
> which is appended by sec keyword[0].
> but currently non-secure firmware is loaded even for secure devices.
> So adding support for loading secure firmware on Secured devices.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


