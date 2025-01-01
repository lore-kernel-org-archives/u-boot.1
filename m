Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CF0E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 20:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA4480384;
	Wed,  1 Jan 2025 21:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pii+zioa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10888803CE; Wed,  1 Jan 2025 21:41:42 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF33380379
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 21:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8fa32d3d6so37918346d6.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 12:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735764098; x=1736368898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1fBvhtlu2aTFKXSVD17zm7OUqN09CQrz8hxNyilIRU=;
 b=pii+zioaHtPwEp5srlbzNn73J4/+Oj+u24WqGAJswUK4sgth9gYZno5ovjwAzwEr5q
 k4UgRKtrRk+abABxxhDZ7wropihKncwodrbfurNIceVsIC8M5WeYz7MgMcsXfQfSdzrY
 MERu5YlX+qLloBjHA+YhNMsjg4gr9pcEeBwQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735764098; x=1736368898;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1fBvhtlu2aTFKXSVD17zm7OUqN09CQrz8hxNyilIRU=;
 b=FRJGYrUkpTGtd2Z5k1sYuKf0vjOXEREjvj0jJ4rUW29sKCUIQPDPctwwljvBCkKmgq
 L8U9aV9yppbHYfztbrMe3f47sA9smFY7Q/x771thNpLjZRfW82chZXSnkW3JNNIpNKM3
 lGiclVzmaarnHm6NgemKWpnhN4Z+tqrJoQE/YczTlIIknHf+3eec6j1LDXYfJ69p4xYP
 bmDtaQe0q7dryKaLWwZMys/8PIEFhiytN7KFpe5LFflgLbYaQFIDmrNE7A7g5Ym6W+V3
 ieeGb9ToCCT7NAdaREZL2NxkuuMkaCEdps/YcVbSx/QHv31QJ9jP9kgB6c5O+oaQidww
 F1CQ==
X-Gm-Message-State: AOJu0YxMwSq2zSTIQhBPVvLMz5gWm8UGDEDvyrAGYqyVE6wKira9komZ
 S2Nr0ae5dN9xBrmqOAgckpHBL5aj4yHkguISvYPp7BLlxVT+A2Ka7lmxZtW+pydR3x52X4PymaD
 AqKg=
X-Gm-Gg: ASbGncu5rwPZb7ttLurw64gjlimIKZ82Bxw7aVMEApQfaAYlsA/qFWaA4equOWmk4NI
 lG3s2XG873ivmT/lXcDKE9B3Oqll2QUR/ukGFEZEZibviaRC53061DN9hjwrOpY/U/1jpnZEGOa
 HTefS/BRAbKF5PPBGIW9a5tAAlhu2/HgC9gnaYLaLuAoAfIOLAAw+WFoq6ggYFn12lIJb+Qofxw
 VLrE87z4YUMc+Bz9JSbjIxKpakpamdhp72L4plaVINO88npePy9VZUQ
X-Google-Smtp-Source: AGHT+IGpgxtYG3EPNdQZkQRhINobS22gCQtKBuaD20NVhEusnNgL4nmn3Fcn9UxP4fhQ13h7+y3vaw==
X-Received: by 2002:a05:6214:76f:b0:6d8:a486:e87e with SMTP id
 6a1803df08f44-6dd233aac5emr748796456d6.49.1735764098680; 
 Wed, 01 Jan 2025 12:41:38 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182070ecsm124054636d6.124.2025.01.01.12.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 12:41:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rufus Segar <rhs@riseup.net>
Cc: mario.six@gdsys.cc, PHIL.EDWORTHY@renesas.com, rufus.segar@carallon.com
In-Reply-To: <20241204133430.3152261-1-rhs@riseup.net>
References: <20241203220105.GB2457179@bill-the-cat>
 <20241204133430.3152261-1-rhs@riseup.net>
Subject: Re: [PATCHv2] Revert "net: phy: marvell 88e151x: Fix handling of
 bare RGMII interface type"
Message-Id: <173576409741.1694690.7040675451964570805.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 14:41:37 -0600
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

On Wed, 04 Dec 2024 13:34:30 +0000, Rufus Segar wrote:

> This reverts commit 431be621c6cbc72efd1d45fa36686a682cbb470a.
> 
> Section 3.3 of Reduced Gigabit Media Independent Interface (RGMII)
> Version 2.0 (4/1/2002) details that a PHYs using a ~2ns internal delay
> are referred to as RGMII-ID. This internal delay is optional.
> 
> Page 147-148 of the Marvell Doc. No. MV-S107146-U0 Rev. F details
> timings of the RX/TX delays. We see that with the TX/RX_CLK delay
> enabled, our RX/TX_CTL signal is shifted w.r.t CLK to reflect the delay
> added.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


