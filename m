Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22810C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 22:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7025832AD;
	Thu, 17 Jul 2025 00:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D9E+RQeK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13EA83291; Thu, 17 Jul 2025 00:15:14 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE32283285
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 00:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-61598534619so157464eaf.2
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752704111; x=1753308911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBzHtp0NxXdm6dWlS+8OOZqLzJjTouERl+da3Vt0P6w=;
 b=D9E+RQeKl4vK+cJQXY4JNpvfqE8GtBb9+EswMbeBe9xIxH1nekNTgQx2xvQn64FyO+
 9wr3Qa/26G9/8kpz11SYfeHUBmGHKUHzW701c3Q9RuW8yusfh0rzYAN8Br03f2JDb4bg
 9G+P+URoFaIWNH7aQrT3Wi3eLhpphZppeqUaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752704111; x=1753308911;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBzHtp0NxXdm6dWlS+8OOZqLzJjTouERl+da3Vt0P6w=;
 b=L6S3KkQE8M0+MD6NvyVuqn2A/zfOFlXXEL7WcstZKsI42pxcwxVlNERaDAs9Lu8CMO
 AHOFZL0rFdbgJZEP7WlE/yDbwfrMywI/02dRx+T900og7Owxbag+4FsuaNrmzHfPDnK7
 mUjm5x2Wl86itOL2/BjEapJS4JSaRAqw9Xy0BHfxdZ/pDBqWsIF0G/tR4EltkCMtImg+
 GWgO+N1zvXiAd1XGDvRrkqMtvJJ1hdTaToxz/JW+G2dYIZR+w9/ki3dX89EYxVF3YZIt
 PyOvfPf1flQ92ImB3xFrsxajETY7BspD0/h6f3RwI1ZhhxsvrBDDku+vkj1K98OaRPnM
 Kdig==
X-Gm-Message-State: AOJu0YxvosgnrwfRwa98ohTSLeo9xzGS+ISr154PTKs+T21+dv1iw2T8
 ilFcumZBVwRt84Bn/jJJgs1fpX/RN7KG6rPvgSJokT0D1z4RLkkO3yVl3T0xkLWClu4=
X-Gm-Gg: ASbGncvKD0hizgnHHf7AghTK9kUnO60pJflX5Y1H9wrvejggl85ypI0rpMSK7oQV2dw
 OQtaZjcDLqov0yeqPusafQLsLR9eqWa9d6hJVRZzQcYx+OKYLbXdpTUvDWWDaS1JBt5vyNrGVeI
 Wv/F2jKPCk+TcevdDiXuuWVUMCr4XVzGiYC3IP62QSAZbtqW16jOpdVH6jhhIJAgfoIZtGtwYAD
 eq3sbpbIgA8Be3y11fEzvQ/yk/Jrm7DLMcrUjlq2+lDsGzWoLFU8ceJGK9a1fROZPHpRXPreQUX
 T8xAWf7HXmRYZso6Ecvlj1t3IwoYwjpS8Q9DRl2pAQ6OO5GC4pMatnJ4t3vt72ducM/VaunMvIM
 kEmEE9GCgxJYL2cb7UaNkLZBOf5cbLo315XGknvakm6mCF6Bz2jlVTkO1FoaTzHvi+A==
X-Google-Smtp-Source: AGHT+IFMiPP1B5t/E1b5CO1XNMhBlip+78LnfvFwFSUmqI+M4RA4rM1PGkENBFarg0qn9D8ayghhaA==
X-Received: by 2002:a05:6871:589e:b0:2ff:8822:29b8 with SMTP id
 586e51a60fabf-2ffb252f176mr3396038fac.36.1752704111391; 
 Wed, 16 Jul 2025 15:15:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff116d3541sm3949246fac.35.2025.07.16.15.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 15:15:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: josef.holzmayr@northern.tech, liviu.dudau@foss.arm.com
In-Reply-To: <20250712185227.17100-1-kettenis@openbsd.org>
References: <20250712185227.17100-1-kettenis@openbsd.org>
Subject: Re: [PATCH] board: vexpress_ca9x4: Enable D-cache and MMU
Message-Id: <175270411042.2648161.17574452616601901369.b4-ty@konsulko.com>
Date: Wed, 16 Jul 2025 16:15:10 -0600
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

On Sat, 12 Jul 2025 20:52:27 +0200, Mark Kettenis wrote:

> Enable the D-cache, which will also enable the MMU.  The latter
> make sure we don't do unaligned access on Strongly-ordered memory,
> which has UNPREDICTABLE behaviour according the architecture
> definition.  This fixes using U-Boot with recent versions of
> QEMU's vexpress-ca9 emulation.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: vexpress_ca9x4: Enable D-cache and MMU
      commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
-- 
Tom


