Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBE3CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 17:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47BD8490E;
	Mon, 25 May 2026 19:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PIyqMsFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D82848DC; Mon, 25 May 2026 19:01:27 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BFA0848F5
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-47c918c62b4so6373735b6e.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779728484; x=1780333284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5ZFyJtJavJQ91t+o4xgM/zhxjrpjC4CkjSFwm/Ynaw=;
 b=PIyqMsFLf07Pu0mI0iAj2CNVTh3ENpm5nZVQ04tLTqBb+VzD3Dhqa3JxTEknAPt/HH
 Zg0ZqCTbp9PsdOOGvcj5stENAFJkcEkMHCiqw1mSJdGgYkoVkcsfG3FQIisd2SXiyJ/7
 I7vbR8rl1I/JdFxSInrdWGrAqFgNxbm5fxmeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779728484; x=1780333284;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L5ZFyJtJavJQ91t+o4xgM/zhxjrpjC4CkjSFwm/Ynaw=;
 b=DKxGPMv327KycGPhKLPYI+9BwRtTKwutXoXRShkpnT+Uqt3NKkUtACdblNTl28Iv2N
 EVmB7pPzCG6NKSJCFjLnRubfy4IrbSzleLZE03XJiOs0/Cj0/moM+kq5vbhsgqgltjoj
 mmz+blxgBO45Dj2/mvWpsB4sT/79ydmg/p2ywz1r/aVLUlxk4wWw+yd186bquRgpeZTA
 xR6Tb53rESM0yWTGLpucALoNPcG/nnfYyPSQEE4jC+npqH9VG1VhLy0eansBTN+v4KrL
 vKuaf006YGVPVpJy147VhDF5hn32I8JLwaOB2qO9jT+mcLiD5N4UtgxR09EfLUNkSphL
 jyrQ==
X-Gm-Message-State: AOJu0YwsPafb5aAFgTznk4875Q65AHrJmZnL1YkZDSW+kdizn39m2tYf
 xxE6boHlZZUgmr3Ac5DA4VbaQ2Kk3quzvCjdZA/DlFsNaviCtqTUvYPW1jN/62fVa72T/9HWk9S
 t5uDL1Zo=
X-Gm-Gg: Acq92OFrO2dbE9cPJkxGchNp4b07yPIjnFwu5qggas9nC7g+VeygU0wBrnkM8NqaC8D
 lsr9L5aNJrJLmvh6xGGNSGIDrrXqUAAqkNLoIsg04G7H2xpDSeXGHWw3gx70K0WADyoGJgW57SY
 +oHX/xLz4l78f7kqE6SrAoylnWVbnTPm/SZzM0W2NVUyoOeaZoiAVUx7+5gnHYFHm7ld0inFXAN
 QNOVg7uruszzcRGyjOpu16E6OD/w//vmhZv7oq7y+WwDzjbicG6USYqD3amDm1QSdF2wskfNlhV
 OPLgy2uZ/pL4Ot21hDZ39oLCR4k6bRrehdHT54YAJaSNciTQM2ztMUwKgbCtu8U7bJrKb44ntSL
 iHRLbnZpv0U+2stw/W6ZQ5d3Mhvh77cZIb+wMesKDl3L3g4X0cp9erMyz4k6jF+PuaPg6bE7PoU
 +JAn3wfYM0zzO/CIihb/92FvOlR4jRvLbfoaRXu29B68zWYdaaXSQX4D9Q+vXz00fUI+qrb65S6
 3kacBhtoZe4Ofh5rgu3t90mh7PFHwXoUy0LZV5YpCqO
X-Received: by 2002:a05:6808:c1cb:b0:467:1212:46fd with SMTP id
 5614622812f47-4854a456d93mr8887644b6e.33.1779728483623; 
 Mon, 25 May 2026 10:01:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-485546edd14sm4993136b6e.10.2026.05.25.10.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:01:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <4f24dd76-54eb-48e9-ae90-1cbfd8755caf@monstr.eu>
References: <4f24dd76-54eb-48e9-ae90-1cbfd8755caf@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx patches for v2025.07-rc3
Message-Id: <177972848281.683406.5884918249672660070.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 11:01:22 -0600
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

On Mon, 25 May 2026 17:29:18 +0200, Michal Simek wrote:

> please pull these two fixes to your branch.
> 
> Thanks,
> Michal
> 
> The following changes since commit 987c93fc68a641cc735c9828872511a947e54191:
> 
>    Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh
> (2026-05-22 13:30:42 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


