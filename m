Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42FCC54E41
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 19:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C1A87DEA;
	Sun, 25 Feb 2024 20:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KmvbMRys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A4887DE5; Sun, 25 Feb 2024 20:05:42 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A2E87DCD
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 20:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-787be5d999aso166393185a.1
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 11:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708887939; x=1709492739; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aWoTrcfT9KNxmYwlB6VzZUr40PoR6hKYcoPi/q/Jle4=;
 b=KmvbMRysoR79H1vcmKu4DkYvB1zX6r3WFvWQJCGm2Rw33JTzFwCBH5k4BZGPxKdyAU
 Mm2N4M9e5LH3GBdxYzGOtR8cV3AXwQ+fczM2KW9BmH7T1txbowiaD5lNb4npmd6MoU6l
 +nD+RZYnvSDUOy683MhpH60E+ex/wP4HsZiR3ipGsbejSOb0bLqXNchQ06Il0wbY1pYE
 +CgC8P4t5sUg/GTDvnXsAnZr7Yo8A2KMG4mu6tC6fAZ+n4RrT3+gQBk1+zkvyLcQzZx2
 sg47XgqQ8vSrQE5Fb7+gk4d/0JpurvdfdqzCTzzNlpROsjanXnTgxifU+radMzE4DEL2
 zfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708887939; x=1709492739;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWoTrcfT9KNxmYwlB6VzZUr40PoR6hKYcoPi/q/Jle4=;
 b=BXUuZNLsjAbkgouS3fAxJWynRoJjXz1Sh3l9twjQNRKbmtOPNspA+rEGEsqmG5afi7
 /zlWArhZVNHhCrr4/pgV2N+uP54CQtUVKfZ1WXewStABSaQ20Zrlf3MQmdFFlwOFvke1
 jtMAygJ1/mUHJYrbtWaSZk1SvzErI+OuQ/qtwPdAMKc52FpLykKYxnE1iTSDeu2mUY8z
 akoAgZWZ54CJBpGheGPqdTJQ58013IO5/blRWusfj7RyS6vfNWJuo9FnC68HPIZr9hIh
 yOyqU5faVRUNNV3W2+zOkkb5R+qXpLJfRICPHg4ATwuDN/7PqB5Y4N2x6vmvWJQmFUPU
 biiA==
X-Gm-Message-State: AOJu0Yy0qsb9WNTSVmtApFEKhLtx59wJ13eHbA6uzHQMXfYliIaSyP5F
 b2639vMfiYIIEe8VCGP6/vSoJHjrwSnpxN36M0MrYNI9g+LNSyK2
X-Google-Smtp-Source: AGHT+IEFo+RiVk2MgFSGK7l3XpZIq17dYmyYCmt88I3B1z75oNcs9FzptVzo/ptibo71fYIwcBBVqw==
X-Received: by 2002:ae9:e604:0:b0:787:199f:23b8 with SMTP id
 z4-20020ae9e604000000b00787199f23b8mr5782675qkf.64.1708887939209; 
 Sun, 25 Feb 2024 11:05:39 -0800 (PST)
Received: from Dell-Inspiron-15 ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 z8-20020ae9c108000000b00787d46d606csm94390qki.128.2024.02.25.11.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 11:05:38 -0800 (PST)
Date: Sun, 25 Feb 2024 14:05:36 -0500
From: Ben Wolsieffer <benwolsieffer@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH] rockchip: rock64: store env in SPI flash
Message-ID: <ZduPgN2IgVFSX__0@Dell-Inspiron-15>
References: <20240224235011.290117-1-benwolsieffer@gmail.com>
 <CAJs94Eb=O4AHo08tcVOKwws5twWVEzseTWLtGAz35v_Abrxi4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJs94Eb=O4AHo08tcVOKwws5twWVEzseTWLtGAz35v_Abrxi4w@mail.gmail.com>
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

On Sun, Feb 25, 2024 at 01:05:28PM +0300, Matwey V. Kornilov wrote:
> As far as I remember not all Rock64 are supplied with soldered SPI.

That's unfortunate. I see that now too in the fine print on the product
page. I think I can come up with an alternate solution using
mmc_get_env_dev() as is done for the tinker-rk3288 board.

> 
> вс, 25 февр. 2024 г. в 02:52, Ben Wolsieffer <benwolsieffer@gmail.com>:
> >
> > Currently, U-Boot attempts to store the environment in MMC 0, which
> > doesn't work when an eMMC is used without an SD card. There is an SPI
> > flash chip on the board, so use that instead which should work in all
> > cases. Additionally, this brings the Rock64 into line with the
> > RockPro64.
> 
> -- 
> With best regards,
> Matwey V. Kornilov
