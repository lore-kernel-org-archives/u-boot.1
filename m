Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EB4D3ABC9
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 16:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C829888EC9;
	Mon, 11 Nov 2024 17:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZRS8hwma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5967488E75; Mon, 11 Nov 2024 17:11:17 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3934C88EC9
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 17:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b14443a71eso373602185a.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 08:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731341474; x=1731946274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QGZZ5Cr3zabIUoC5ldkc57xh9owp79rd5S2TJBIcaU=;
 b=ZRS8hwmaNA5FzGBM45w7SpJQ8Ib5pY4BepaWE4FmO839+tg6urS0oBdrwOlZHgPoF1
 E32o2bx/xB5k/KfJBq/bO4pM1ilrTrog7EVa9BxA4ofml3ZPxR20DhZuUZ/OMOl2uqAA
 DHuzSxSlXf4iXopK54uIqvtD5kFtmhmP+1WBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731341474; x=1731946274;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QGZZ5Cr3zabIUoC5ldkc57xh9owp79rd5S2TJBIcaU=;
 b=UYWslnipJLVF4SiNETBxCnh8jW7xE1bPy4Q06tPKn8pOaX+PQGyoOx4geH4a2lbB57
 IKxJI0VIy4zmbeQWlFRDdIkc0bJLfpocYlz5qxfNqlgdkTu6AHkxelji2s9y+OoueJEu
 ZqIGQTYU7A2aVEQqxhW2hdP5dolG7QL8FBCLid3mmgMMeYJZ59wJcgD9WZ2g799kL3Bj
 AWJUv1teoPc1p+eb6mtGau9j9t6b3F3nDus1B61+t2LJZyoEWUN43xaM1O2dnCQ4TYKL
 HzypeeCkuRV2BYFqeDhGQC67rigtG0mvSeQe8OqOSRNM2cu7Ip2STlYhHsC4Ow40e9Tw
 bQ6w==
X-Gm-Message-State: AOJu0YzAd2kPSx+Zd8JsGDSTD5Zpg8hCavdiZobre2FWTJtjj+85YcqO
 /IU1xZRHKg3eocBkTM5MvObtjDjx3PDCvEG2W6nM5YWNCfSrmG5AKg7603EFcctLmSH247EynkF
 6DP4=
X-Google-Smtp-Source: AGHT+IGVAmg6QFHHLjNaDPi8nU8tVD2Vj2mCUbdhq4enMOvG8klOskiiYXaibuchLxd+v9QBXfSOGA==
X-Received: by 2002:a05:6214:5413:b0:6d3:b636:eccc with SMTP id
 6a1803df08f44-6d3b63717f3mr96542376d6.21.1731341473939; 
 Mon, 11 Nov 2024 08:11:13 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396630f80sm61247146d6.103.2024.11.11.08.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 08:11:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241111-io_lmb_apple_dart_iommu-v3-0-32c05da51d72@jannau.net>
References: <20241111-io_lmb_apple_dart_iommu-v3-0-32c05da51d72@jannau.net>
Subject: Re: [PATCH v3 0/4] Fix IOVA allocation in Apple dart iommu after
 global LMB mem map changes
Message-Id: <173134147259.373368.13366241380547526820.b4-ty@konsulko.com>
Date: Mon, 11 Nov 2024 10:11:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 11 Nov 2024 07:56:30 +0100, Janne Grunau wrote:

> The changes in "Make LMB memory map global and persistent" [1] break
> mapping DMA memory in the USB xHCI driver when using the apple_dart
> iommu present on Apple silicon systems.
> 
> The IOVA space used by the u-boot driver (low 4GB) and physical memory
> do not overlap. The physical memory on this systems starts depending on
> the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> manage these distinct regions in a single LMB map. In addition every
> device has its own iommu and IO address space so sharing a single memory
> map between all iommu instances is not necessary.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


