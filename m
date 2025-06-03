Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859BEC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 23:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C982D8291D;
	Wed,  4 Jun 2025 01:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ucbqSTpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F3D8291D; Wed,  4 Jun 2025 01:19:16 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9786780F9C
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 01:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-400fa6eafa9so4190430b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748992753; x=1749597553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yaPYckb9WrGUbhY10spP8Sawm1SB65sLNjbh3mp352c=;
 b=ucbqSTpZF1JRt02uYNDpOzApO+KjeS/etbyQeLDyIxlJWMtbideEqPRaIDFuQzJxTa
 E35lYF/wyq+RAY29EMNVPC1C/3ToHnCihOBh/G/COaM4WuzQhkohXXnqajIkDz1GOyhd
 SzOtLIsPv8lSo2n3vZynGl/Tjq/j1p1oaiCnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748992753; x=1749597553;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaPYckb9WrGUbhY10spP8Sawm1SB65sLNjbh3mp352c=;
 b=lLBCMD0AUqO4DV187BF/Lg+MCMj73cocjoEF8U9h5HuemcznmWevn+W+W6QpS3u0O1
 F/prBpoC/Rd2Sol5VpZueh80d3TQWrDTI69OZnnqg6sXKzEkNLVakBAzVuGrIPzLbjoI
 36iDEjxOJquGvNrx1rZgiYXLKRqXbh7mHk2Hmia9lD4me0aqLwNzwN2BtcKR2gXj9EQN
 l7WjjAs+hy0thu1AgOzcDX4Hd1MtMtgittdT6g7XYJoX+yE5vw0ScyTND5EsWQN6v1Ck
 D8ITnzYqVtHFBG2btKkvX78gbpcItLVbu316RQN50hTAiDroDW4zI+MrRG3DOcRi1YLW
 hYDg==
X-Gm-Message-State: AOJu0YzVFSzj1ANaLAJxMv3wj+kOh1mr1EZjggONLDLtQGDWkz6V3TQr
 jlzMdCDdAE78RcRkGx+NlveQxjx+zAIn51MEfG2yqrDl7btXIrRvGGB+loh5+GdAUkRUvveJKBF
 UE907DrY=
X-Gm-Gg: ASbGnctjtX5/zxaBsajSruRlqDaOPrY2cu9Q9IOfx5cbXGVJAYCiYoD2MewOKS0cIe5
 TOnDEyAH0T8ovZhC+th2PCW2iwH8R89tCDgeaA5WDyqtngUJwAB06dBduqqbrDesMUk0GwKWPrM
 GDca5lAAfL1uDWkSreXbsb6EUKOzo0hk4kaDwlG7H6wIYOFMvNN94iJJQOoW202KOSyosk//z/N
 7ZBg9UZKGSdrdn6JwAvovIwz+Hzk2Z4VDm1lAa40XBwSdnDdZ+eX+MeXtqkdbVh9RzkOKvHiQye
 nCungVu+WxZVzJaTOt4rMRBx2g+tb00UjQAC3tRVteZdHk/G3Zi5cA3n4hws/eGhso+5XqDaiiv
 W/xXXLx66NHeoxoBTs3fAXw==
X-Google-Smtp-Source: AGHT+IH+qX2hTnIUB02ZkQT6sEYbCJjol/eXmIzX/NyT0VsesHHiWmq1oUaQ6JKHOXyiHI2Sf0SGPQ==
X-Received: by 2002:a05:6808:2f14:b0:403:50e7:83db with SMTP id
 5614622812f47-408f2dbe037mr219909b6e.25.1748992753286; 
 Tue, 03 Jun 2025 16:19:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1db4asm1990941b6e.12.2025.06.03.16.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 16:19:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, ant.v.moryakov@gmail.com
In-Reply-To: <20250516152538.75325-1-ant.v.moryakov@gmail.com>
References: <20250516152538.75325-1-ant.v.moryakov@gmail.com>
Subject: Re: [PATCH] tools: fix handle leak in ifdtool.c
Message-Id: <174899275201.1527530.17735821434925029660.b4-ty@konsulko.com>
Date: Tue, 03 Jun 2025 17:19:12 -0600
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

On Fri, 16 May 2025 18:25:38 +0300, ant.v.moryakov@gmail.com wrote:

> Prevent file descriptor leaks by properly closing 'fd' and 'new_fd'
> when fstat() or write() operations fail.
> 
> - Added close(fd) before return in open_for_read() if fstat() fails.
> - Added close(new_fd) before return in write_image() if write() fails.
> - No close needed if open() fails (fd == -1 is invalid).
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] tools: fix handle leak in ifdtool.c
      commit: a4fb99ce4e6ee62f3278d7472b9b9282d7b289ed
-- 
Tom


