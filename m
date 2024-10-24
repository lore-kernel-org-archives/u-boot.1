Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFA4D0BB6A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5377892E1;
	Thu, 24 Oct 2024 09:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sr1JFZTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05550892E8; Thu, 24 Oct 2024 09:49:09 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8317891E9
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so6368385e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729756142; x=1730360942;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zhXeFzgTrZYyvLuhLypEvIBklun1v0+XIgGCaClhSk=;
 b=sr1JFZTczWqZCK1E53hk2vVTawblVB8iQMcXe6N1tzxDdfFojWuWZ+NsCDjKALttis
 k+gxTemCBjy42BHh7R2/iQQlEuhGtJx9kvIwTHGTM6ljn9dBsRynhpbQLtDdEbKTON1X
 XH+drgoVUj8pR+QgSXKrKthXONW44rOrad1UDaFhSAqOUu9A6QHrcRLIZUpW0w6TPqdT
 llJpdzqucuMMa3bUG/D+XLnmmnHgTByp95hM7sA6p3+8Nj9Yo/BBQQG07Eb4bsxems4x
 PXOf/T1/jagwl4pfAwSkBYcNOCrnyWi0KsMxcOffeWLcU8/+fhslTYD+OiAul8piQp7k
 FU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729756142; x=1730360942;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zhXeFzgTrZYyvLuhLypEvIBklun1v0+XIgGCaClhSk=;
 b=YzyMfo4S2QeHLBv2gLKzKWMZ5br1GMUqDDC9/XkialljwVWQj5tMDjfj1nMghwVjn3
 xMYnptgFX4eNIwOn+e3UMC9tcwYR2ksAeyx74CxXvgoqmoZTJG+I1XsAfDtnC8b3eRwL
 Ko3nN1kHUFPcWpPdzkOAmfV6OL09jaqf659paCim5oROfJ550QBQMihEvR7KDRgp1WGY
 nEN9D6EHzSpbzOqItJ8i6BzUIqN0+M0tkuCYQXzuQNPelsZK21GQC0UsEilglLJ2vNDV
 0NdEnt72EBxy8VPrkuW6Jx1bnRqbLfYhFzSGghaSMiQtbv7fVfAp4aOH+4rgHyXlaz5f
 0NaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx1OO840elsuQzYhb3dkrgcNLTpx7uuX7z5mjxQH1k2vm32maxBUsHiekoxRvmbDrr6DtAAKY=@lists.denx.de
X-Gm-Message-State: AOJu0YyNqhUOS+NKcQPMcTe4OJdWXuIWx/McTJEwk6DN+nFinJ54zBP8
 DcXKVDUM2IMp0hpdsOz4WzradeLPRZM/o6DGXycitWSBgNjwrQi+/z+Shr+yIBI=
X-Google-Smtp-Source: AGHT+IHnfDtsrtiBQZcgGbIQQMs15iibM6pDFwcpoqcN2wy7WXPxCxwB2u63v0wp5PXU4SKKJxENPw==
X-Received: by 2002:a05:600c:4e41:b0:430:54a4:5ad7 with SMTP id
 5b1f17b1804b1-4318c6e895bmr8937115e9.1.1729756141252; 
 Thu, 24 Oct 2024 00:49:01 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186bfd04esm37662555e9.25.2024.10.24.00.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 00:49:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
References: <20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org>
Subject: Re: [PATCH v2 0/3] image: android: misc fixes when using on
 Qualcomm platforms
Message-Id: <172975613982.462684.11194674923567644395.b4-ty@baylibre.com>
Date: Thu, 24 Oct 2024 09:48:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Thu, 17 Oct 2024 16:44:41 +0200, Neil Armstrong wrote:
> When trying to use the Android boot image with header version 2
> on recent Qualcomm platforms, we get into some troubles.
> 
> First the kernel in-place address can be > 32bit, then since
> we use the Android mkbootimg, it uses the default load address
> which isn't big enough to uncompress the kernel.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] image: android: use ulong for kernel address
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8f8e646d790199f023f82b8100b6e160d510206d
[2/3] image: android: do not boot XIP when kernel is compressed
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d5a85e8e95db57e350a092af62077917c7edd571
[3/3] image: android: handle ramdisk default address
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/21e7fa0e3ac599737cd235bb5233765e8a1b8b0f

--
Mattijs
