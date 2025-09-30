Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19776CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 20:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E95A802C1;
	Tue, 30 Sep 2025 22:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8bwO65r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC0380819; Tue, 30 Sep 2025 22:22:34 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A163D800D7
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 22:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-414f48bd785so3537184f8f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759263752; x=1759868552; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gRzpgalNrmObjr7BbmAd0Q3BsYnl7E/NKGXkYdkMDlw=;
 b=m8bwO65rRR3nNBLckwdDJ0f1EqKwi2AIEr1rmQEmE3azwhnfPwWG9GwHdFGM+ayyCl
 qiK38svQTmG4hBJFSTjZL0CENnhgfcvzIEFXGiNE86+hXZ43ywp8eo73q8B9OTQftvCX
 JzSoCLZea9yrBYYFhRPfnPlKSeIqqbOvrHGS/aRlk2pubKMlMecOvD5oUA0U9dR3jF8T
 XKhwXUaUZobAro4jf0jjLt/zgMS3fhjLYpbyu3UITJgHGaT8PPBVD4VNdMpZ1l3ekbTR
 v4bHOYDOdCtGGssyakPbwrIDSSOiFBo5pR8YOAur6ikB8KjEdc0qKs1Kw+u3kH9XkYua
 4I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263752; x=1759868552;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRzpgalNrmObjr7BbmAd0Q3BsYnl7E/NKGXkYdkMDlw=;
 b=EsefBL8My9nl1yD4UDemyzyBE+gOn4Iy6jYXPGHkM7CC5GGRT0Ja2BxyifuyBmXuiu
 TqG/VU5pqFmdmUw/uD9cDAoYKNIWiHPdI9KCJNi+J2r+m8S7/GvoCQyoLNAWymdx+MuH
 yFKkJ8qO12zBatHVoeJcoOzFhiUMzhdj3bWgC2VbR2iIcwi0rtea8oK21Xq6xfpBVJVT
 Udy19I5VIniuD17ITD1yh3r7hCD38lh7mQ0WN86ac7JHi3P1lQYwYbBkarOn/q8qu0st
 q5I0yoQ18NmphXVsh2mG1WPn/UqUC6NkCbU/H+tzl53lRnSiGdMWDGJFTdnyZGVPeCGV
 g35Q==
X-Gm-Message-State: AOJu0Yx8i8hyHDeZ8kZSMtrJanamUlSujVScGMjAmg0IPHV+FgJcZEHq
 mUIZLcMlGNAb20LsWUftlAaBsS/ni4cJdgqCUttfnOzDFkCoBHss6UdoS9nS7g==
X-Gm-Gg: ASbGncu8ZTtmEU9OJyfOf3sYA7//Oc6LjyfV2buIpWnKCCZS5l/5JnPal1oTQ8iomX6
 STeaGlQcEfp3Ud3QrRWXPbshls0+RhZNOgcbswmEAvyxeB8ln8EERE7piMk7EEP8V+xldqq0BkQ
 tAkmfkA6sTBzg/1DvPuO8eC7x2pDyM58C+a9KIvlrrjREClCBfoX5fBbrDXh4FkuJ96zRWKujxo
 7QQE/9HP/3yK59+9SYgPmAczegt1U86AtOuQezPIteLVuJxnyZo7fNyE4w7ACcOYLuUbMIaA2jA
 uNpJQnHEb6gfFn3PbucO1Sx6vD45GN7FBhBIAWavDS4B6a8rM5LLe3mKV1qtTmjnAX5jYfxGVG8
 QBIo1NAxQ+i6LGp+H+biOLSE+Gle/WhdM6BXkLl8BX/WqFEE8se3jwsf6/d3MNSh5UQj3powNQp
 TBSmtDpzfpg069zz2tLA==
X-Google-Smtp-Source: AGHT+IFIGF1TkDLWDo0wRywFH1ohpiE/ZTUBqtllTGJawTpPcxmYjqW750UR0an1nmh5905HwCRw3A==
X-Received: by 2002:a05:6000:430a:b0:3d0:3eae:576d with SMTP id
 ffacd0b85a97d-425577f3306mr764830f8f.22.1759263751835; 
 Tue, 30 Sep 2025 13:22:31 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619ad9c6sm8520275e9.16.2025.09.30.13.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 13:22:31 -0700 (PDT)
Message-ID: <68dc3c07.050a0220.90794.3860@mx.google.com>
X-Google-Original-Message-ID: <aNw7_NfvfRzMZ4XM@Ansuel-XPS.>
Date: Tue, 30 Sep 2025 22:22:20 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] test: led: Add missing ';'
References: <20250925205026.3561694-1-trini@konsulko.com>
 <68da5bf4.c80a0220.2f77f4.4c19@mx.google.com>
 <20250929140341.GB6093@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929140341.GB6093@bill-the-cat>
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

On Mon, Sep 29, 2025 at 08:03:41AM -0600, Tom Rini wrote:
> On Mon, Sep 29, 2025 at 12:14:09PM +0200, Christian Marangi wrote:
> > On Thu, Sep 25, 2025 at 02:50:25PM -0600, Tom Rini wrote:
> > > Some tests here had not been compile tested before submission and were
> > > missing a ';' on the end of declaring struct udevice *dev. Add it.
> > > 
> > > Fixes: 9046279d92bb ("test: dm: Add tests for LED boot and activity")
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > 
> > Sorry Tom for not catching this, I hoped the CI enabled these config.
> > 
> > Does the CI for these test use the SANDBOX defconfig?
> > 
> > Just to prevent similar error in the future.
> 
> The issue is that the new options weren't enabled on sandbox as well.
> 

Yes sorry if I wasn't clear. I was honestly confused on where the config
were taken for CI and I assumed they were all enabled by default.

Thanks for confirming that the config for CI needs to be enabled in the
sandbox defconfig.

And again sorry for this embarassing error!

-- 
	Ansuel
