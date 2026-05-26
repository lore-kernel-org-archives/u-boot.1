Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AB1CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 16:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E990984849;
	Tue, 26 May 2026 18:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FyQWA262";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A49F8484F; Tue, 26 May 2026 18:18:16 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4893384659
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dd73b7c757so4960615a34.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779812293; x=1780417093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4XdSw06RJTK+lX9Jap3jqmQT/OD+CsekLG131M2/zw=;
 b=FyQWA262F0iij9SjyMoaMdkDFodVUV/j8Z+Fljr7KholtikRizBi2unNTbdxHOxQGx
 g3+lj2mAvH3pW59RsVhDEVPXmbwXLOiMCbQZOB9uM+CQqMFntLnIiQkyqNUuigoX8Ou9
 ANwSiBuQUMiOSgjtxwkZiz1HX9ynqa9rKsryU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779812293; x=1780417093;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z4XdSw06RJTK+lX9Jap3jqmQT/OD+CsekLG131M2/zw=;
 b=nrSoZjIDCOZ2BLA7WhGzwESV4JXaqYUvaOdK0vvUBuMfjiVvLG66YvllV+g8jD3ks0
 Zr7IwTAFmidyscEMGNaSt1TDEQva/njERWQNH/LHBZhUbuOxEiRVaQYzki0byNZSHpho
 73QFCHiAvGY7l2KReAwxFOgGyEKw5S7kj/ALJ0n3pX1mPxKMyzrHPPl0oCtsrhMam/CY
 95S/PmC9pnJN5kJ2X+DPhiteVmRf5bNz4i5xgtW4G83KC5iE3BRjgZ2n33hGQdQF5zHe
 zR0pm4LzlrcTRdRX6qZfH4eevGkRMJ3lCPAv2uspozTPs9NrQqZ6G8cbE7ngoj09iOOe
 xPbw==
X-Gm-Message-State: AOJu0YzgYMJ49XEKjHZ4IlA2nD0dczVN+hVqlftFhUqs0VMW/WWV0Z9e
 6hL5C4Ke2JclbKqlBpd6ofbnaCbeaNp4QOopYLMiBKWAwNc7uYnHB0QGVrizQL5Zipw=
X-Gm-Gg: Acq92OHt7owB6nit/D8lrvHfbAhLdakDcSwvhh3bQv3W1UeopzzdUQYyY9GIiQRYJZP
 qnnSLOv/fIhenS0hkTFkKKqixHGLye8nTyAds31sitcjJLli3YwmXHWIGcFTGUSBup4kS6yfYJg
 pGDl5lwVlrhu5k5zE5mBe9sq5T/YbRihb/shrhLj3Tpzf+9iT6vzupPy9U0dZQdpob335wbBpvc
 lR74u8tEuJ8sl6Q5KC06O9WblaTDXt7DKQTRa2DZfVvPqe+baUYJ4KdCxW+WRIA28NADHq4sqcu
 OByQjvdfxoRMuFec8fIr5SPzExuHk9/gMJ0qt3fEeDLwcNXZfwlc2nwxMUw/od9np9Vby1iC2mj
 hsaLpM9YsuWjuIJOrKd2ANAh7Wz+iB0ZGZicMu6CTjxQIkjfoPy5n9IJeIVTgVfX7SVSdwIXPIx
 s3CqZ4ouroS5/+WhSWWy9c8GFgiTvfvPMxO4PPTq02u45vwWn48a07u711f/C/wo0eArhEq8UR4
 eCCkZ80SWUVkZcm3IAAEJfxJQxODbt80IKCL3jCUFu5rOnHOiPIHzo=
X-Received: by 2002:a05:6830:82bd:b0:7e5:f941:61c1 with SMTP id
 46e09a7af769-7e5fef85544mr12252788a34.22.1779812292979; 
 Tue, 26 May 2026 09:18:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6064828e6sm9655186a34.7.2026.05.26.09.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:18:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Lionel Debieve <lionel.debieve@foss.st.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <8143ad09-bdf2-4023-8b63-22518acbec89@foss.st.com>
References: <8143ad09-bdf2-4023-8b63-22518acbec89@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.07 =
 u-boot-stm32_20260526
Message-Id: <177981229224.3924175.8598109786510791666.b4-ty@konsulko.com>
Date: Tue, 26 May 2026 10:18:12 -0600
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

On Tue, 26 May 2026 14:42:49 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/master, v2026.07: u-boot-stm32_20260526
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/30256
> 
> Thanks
> 
> The following changes since commit 76d62273bc8a5dc126ed79ed0fb65e5a97359577:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


