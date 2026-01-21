Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF940C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 20:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EF883B27;
	Wed, 21 Jan 2026 21:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jmju4MJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21FA283AB7; Wed, 21 Jan 2026 21:48:50 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037F683AEE
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7cfd95f77a3so198570a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769028527; x=1769633327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjKR8YwuNZP889Tq66EYnOxj4m98Fk8XTQBZvh05X8I=;
 b=jmju4MJPDT0Vl/jsbV47iyPxj9hRHfieqD4vYfLmqBATkKlFzFZHtcDy9z6OdyhiNk
 YcsSbgo4NnCDPKQiTxBeO/k0ooq0d3viS9JyVgcynEkC3MMhvsCLJ4NXr471MZnTYAOl
 57iKg5tIuDO/S3YAsmCpetlYh0nx4gBOUY0G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028527; x=1769633327;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yjKR8YwuNZP889Tq66EYnOxj4m98Fk8XTQBZvh05X8I=;
 b=bqlu38cWi+cLVAAuynpve8GD1qbROGXGq9K/OHtQgcsZObgGE+U/P1pMdqBj3qCpvv
 FKNzUcEU5UX24vmcUDPNSWHh2KbkkUsGPuuk0Zt64nGmMoqOxhIvVKFcNWcjPQiierfm
 HAcAavrSG+mGLFLC9mpCw+TUvzgyjBCFqwbK7cZbJRDqA5X29mUJX6ZH+gq1rl0MFK5S
 szY+3RzksKWQ/Qu8cdNWlfwYSxIyPXFyszJK1lt/Vs4iEkYrhTUmDgkdVh/EbELW20qn
 Pk8pJXTaveuLI8UKdjrmsaBEw88CUgwSR9USDETIjru2bu7Gna/9ox4DmqQ/LgdZCPpk
 GZ8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoKBY7lKUk7hY2G0VBUZcUnYd9qfev3RGF4oo2aX1ed8j9hE8x+NXh/OSMbBOesVpM8pCsZ4g=@lists.denx.de
X-Gm-Message-State: AOJu0YxIADnOUmphIxItjPzYo+aKvrb30dyerOh96JQCDRzmpaTy+hEw
 21Fq2X2Un+LIoNwCR7smU7wpr9kVHNdzF8/4erNa4Gt6cjvW9qn8E3yFkyP4BBxOxIMp9m2M480
 /+meJfwU=
X-Gm-Gg: AZuq6aKHfb/QGMwhDjMMKov+zozqDowyHjWSKa6VoutmS2OdF0fy9DjL8Dgs4gOhRE1
 fqdAo5Sq5Id0I1HhI4CxRZe8Qw+8jT6AA/byYSKT8jpSgNQ7sUvW9+2AdQK9NnYdOAs7TiS6aOk
 l8xTHlHWG2XKrxpHbAIGqhzqP8MnKgGCAu8kHfscvaOmrK4iiSiM6XVBj60XkMNt5JjL0nndJdh
 /gEysE3xFyZKJBZaQZIY0oIF7IDLQiI6MILJ9Q4WL4xd7rnLqZDsKbmi9BrSCVteASABs17KD45
 ceNrAouuQvSr59VPOZArQMDkhmuUDWpQ3SrndcWclcZV7+wG/Bb+Sfxz5IIHHxOfPUMDN5OO8GA
 0IB+C+rGDXJHTsGHEi9UMmQiIQlu/UpzrbCi7psyUOl23aV91xHHWnXbHv7Rhh86SfHaA9qMLkW
 O0IreJMq2nGO35ZFa1gSHPCDqFw5Tw4ChFvLs7ptKwByHM7VQob8kRhRAWNPLMyc6+bDZBC3+LU
 aQutQ62++fwWH+1RJGeuqa47Dn2TW7FmBjmkTmnY8LUTals
X-Received: by 2002:a05:6830:25c6:b0:7c7:5d72:566c with SMTP id
 46e09a7af769-7cfe0137951mr8991759a34.24.1769028526745; 
 Wed, 21 Jan 2026 12:48:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm11134487a34.6.2026.01.21.12.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:48:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260114-pinctrl-mtk-fix-syscon-lookup-v1-1-2649df7a1f49@baylibre.com>
References: <20260114-pinctrl-mtk-fix-syscon-lookup-v1-1-2649df7a1f49@baylibre.com>
Subject: Re: [PATCH] pinctrl: mediatek: fix failing to get syscon
Message-Id: <176902852596.661474.2426831204196916812.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 14:48:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 14 Jan 2026 16:37:19 -0600, David Lechner wrote:

> Replace uclass_get_device_by_ofnode() with syscon_regmap_lookup_by_phandle()
> to get the "mediatek,pctl-regmap" syscon device.
> 
> Depending on probe order, uclass_get_device_by_ofnode() may fail, but
> syscon_regmap_lookup_by_phandle() has logic in it to handle that case
> correctly.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pinctrl: mediatek: fix failing to get syscon
      commit: 04413ed0c1bde24bdb4a15e5d75a33f1f3fa8bfa
-- 
Tom


