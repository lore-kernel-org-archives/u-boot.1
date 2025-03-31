Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FDCC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68C881F7B;
	Mon, 31 Mar 2025 15:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="btOKaFdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20FFF81ECD; Mon, 31 Mar 2025 15:46:20 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C31FB8144A
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c13802133so1269251a34.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428776; x=1744033576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKKBUslwCLHr8fQtdjEiCG5RargjRDag4F3UEmgKpm0=;
 b=btOKaFdgwvmojjnGgOcgQqDNunNQOoBJD2VOpNGPadwmS4eR9Zw4Hb82TLGRxD0JNA
 cXD4E5ocYAS79Y4sexALlyoK6KhtO9UzvJJIHoUMTfKlrIGFSSCXK1/CmqSf+4Ttj8RP
 O0jmMKDN4vTzUFnceSe6fn2lE9DyAudUZgraA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428776; x=1744033576;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKKBUslwCLHr8fQtdjEiCG5RargjRDag4F3UEmgKpm0=;
 b=JPJD/ri+Owu4aJGFxQgn8dIuc09r1KKTxi7fKbCtQr8OxEBhJo7eo1mWO0rJoTUaTo
 wBKAm+OwX9+OckttpOB/lfVZhBzBzy/GGKttZ6pk/DlpdfMkeBxk2vr9vPHJUtKwv6KC
 dsZdnXTTDslwChHKm0xffUENVo27gy2WRHvhCYbrCWDP3fO3H+P14F18vW/Wdpvq+ptX
 EVjP4G7zKUlLsG+rQfAlpw/hr4c3U75XU+V0fUDVUQ4BdjfjZflUV0Lidp2oB/FDOyuG
 WMOhB7ll38MDhMB7vojFDsx2ztG0K+oOuEeAWvKoX+93MqwNIyeX1DxQFxK8QeQ9Yzsd
 Pddw==
X-Gm-Message-State: AOJu0YzayS+JzetWtJtSHlzzBR0kAVJw76djjdjpgff9j1hao+zzLReY
 l0g9XOarxzhtp7QbMK7bll+R7L6Ges6i0UvXDXlwwy3CSYXp85wLJNg41yvltBzjD3sweenMlG3
 3
X-Gm-Gg: ASbGncuXYaKMxmpG9ptRFtMFyfpbCKV3ryNVzFqjXDif/1V2F7vzRdj3Ac58tTuAz6S
 n6tO3ZiSep2lomlQIdW/QtJs9V9f9M7jHzhSRSxo+Lq6RMjzVpKhC5sZXFe64COde5Sn1dmzEcN
 VlteL8oe37zrarLAdnn8pCVy4RbP9s6VbmSYALe3rgIR5nOZ2YdUjIOgSWzjSKuuOM5tZ3mHxr1
 XKUX/RCk2D5glRjvyZJbJvV5du4+crgO4uKy05NSsKpAB6rMmuvDw59m1+GY89qynE2OagWa2af
 dypKKdJ/p2jo51lkZAcLtqwxQf+8YaneW4eymUNcJOqsSJKDazzOVxRJIQHO52eUeM7QlkrMABv
 Igvgv
X-Google-Smtp-Source: AGHT+IGrfYB2eHzipejq7vf60X/pGJn4VgUi1TtnUNAl3pgB4oc3E/dGLWA3nkEFU6kFshCaOcCFDA==
X-Received: by 2002:a05:6830:44ac:b0:727:423c:95d5 with SMTP id
 46e09a7af769-72c6377db9cmr5811879a34.3.1743428776255; 
 Mon, 31 Mar 2025 06:46:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae78sm1456331a34.60.2025.03.31.06.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:46:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <20250307032213.75754-1-weijie.gao@mediatek.com>
References: <20250307032213.75754-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] arm: mediatek: remove wmcpu-reserved@50000000 node
 from mt7987 dts
Message-Id: <174342877491.1318045.17313521476646873483.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 07:46:14 -0600
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

On Fri, 07 Mar 2025 11:22:13 +0800, Weijie Gao wrote:

> The reserved-memory node 'wmcpu-reserved@50000000' only applies to
> linux kernel and is useless in u-boot.
> Remove it in *-u-boot.dtsi to make this memory region usable.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: mediatek: remove wmcpu-reserved@50000000 node from mt7987 dts
      commit: 2d611c2a02683ccee7b085f1f1e7b1b2edc5c773
-- 
Tom


