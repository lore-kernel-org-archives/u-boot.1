Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CC8FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D87684106;
	Mon, 27 Apr 2026 17:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jWf0GttW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CA484178; Mon, 27 Apr 2026 17:42:15 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 885CB84106
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479ef2b7979so4622284b6e.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777304531; x=1777909331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7HQZ469T7LqC+XTl6rWh0Pur8uIoq3fAatfiJHVjWo=;
 b=jWf0GttWXK0BqOmKdJTIVCaRVCIBTeWcvxideyJ+M3o06+1KbLGA1zsOtKWXn9BgCa
 HfaDNoxqnajJYwhOUsuNaQm4Xq4/jIkchjvK/kp4A2j0LwwmKu16Jf+7dc+H3tN5VOlc
 rBV4qlnXb/6FK1NdnwX+NScxKZwcEgnF4ZZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304531; x=1777909331;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V7HQZ469T7LqC+XTl6rWh0Pur8uIoq3fAatfiJHVjWo=;
 b=q1nkpXZN7Xjbsni3a/4HqO3PcaqXpSIwUPtTyrILxUBdJfiS5pxWbyqN/JPq/jrIr2
 nRdRaar7mLVkpWlOcSsiJkt/N9zVs9ONNEs9g/f7HWR7NnMSUWTnGlNEEkR5LJsm+6Mh
 9qsYB3M5JKDpWb61GIkx5sjVexceY9916v678sds87MWGIe4aMlD474UGnwcVhNP7dST
 AylG6n2Fj/RKN1bDHTS3yO7Z1F75sPCNpXyMytsyGq7SubeHeuxjJq2xZ/P2CftWVrnQ
 /ETHtUo4cWreX7cI8saWxmP0cIe1eRFM3QaFkupSfmda8I+OZGyXiTIVyC+oGJDutanD
 /Ncw==
X-Gm-Message-State: AOJu0YzpsQOT5WlMF1xGo05KMKfBZUnjnMVcm57mD0LddNSSW6J/cb+L
 kdZ23VbVKG5BUbGZ6bfx47zvLjPaInd+JW6dJDC4eFFCP9ucl7bz09O49UL5uyjGMOk=
X-Gm-Gg: AeBDies6zo2L9mWPiTrnM5e/5Odc4iftSI90i8I0w+h7G9l2YF4lMOy5Wwuim4uKQcD
 SHyLx0vjHK2nuwWxcauqetTwC1PkJnaHo7EovWFiw/rZgX/hkC0RBlJaNSpmEwQTPBllmx9tI+e
 ouhDDqR7k3ptwsdTKxOncFrhvcUbG3XVohcFgTPJhzBwMlWt9jsU6sWc1wPMdfne5zv8ek+cuVs
 gOhG841IEwNBUvE7deiObpOW/DaXVVTk/ejlKAJon+DcoP/oZmnJtuffeFyT9fckDVZaSN9kNxc
 DNlXx6RIdWNxmTJBCRHvsyxW0B7UnTvWASB+eJJmdzLQk3uiZWgdNwSmlItfPi2QnvHskHgggdR
 R7+hQZqqV2BC70Jpg3kGboVcSTkoLmJtLYc+rMUIHDM+htI0xbVa31SapUplkrS9TkRTwS5zZCp
 xEQg3RX/RRLJNvYLjF2w6A8MAmVZKobdD4+IQBitE8UluTkKvOO/5gXaRom5dPr7BY+qAsis1Ka
 rY/pXRTyTyBvw594E5rBn/DDuTajeO0VnhGuRariXtI72DkHm/g8BYx9CcpD98MikK/N7w=
X-Received: by 2002:a05:6808:1442:b0:467:1f38:bc1a with SMTP id
 5614622812f47-4799c7eeffcmr22756144b6e.7.1777304531317; 
 Mon, 27 Apr 2026 08:42:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c1c8cd7c2sm824896b6e.2.2026.04.27.08.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:42:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <c5ebc13e-50f0-4341-b8e3-0e0d797a0125@linaro.org>
References: <c5ebc13e-50f0-4341-b8e3-0e0d797a0125@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-20260313
Message-Id: <177730453068.3468459.15905663547138626201.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 09:42:10 -0600
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

On Mon, 27 Apr 2026 09:56:29 +0200, Neil Armstrong wrote:

> This is small set of UFS changes for next release, Reset fixes for Renesas Gen5 & rockchip,
> and possible corruption fix.
> 
> Thanks,
> Neil
> 
> The following changes since commit 052988aa29bfd506d7ce207fbb3f5374a5dbecbb:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


