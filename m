Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7282DE7BDA4
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 11:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87FF80FA1;
	Mon, 16 Feb 2026 12:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="di1qqmwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856E283AAB; Mon, 16 Feb 2026 12:51:32 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C718E8063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 12:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-59de8155501so3131719e87.3
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 03:51:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771242689; cv=none;
 d=google.com; s=arc-20240605;
 b=DJpt5EmLOebN5FV1Y3uHjbpX8JTtycZVZZseVE+ixl0uDN6CTkVzrlPP8SKbnmp8dV
 /drYSN2sVY2otjwyoNEpAOMHd1kYLgeW3YWsolmYsPGfPIcC4k/gphMtu1qwSw4bJQEV
 Vbwz49S3Eq2kMS3BqhMm9HYBwTu/itRk384T1HqSMjqwDws7RdQhCRkGuyOIUwR7AaKu
 aWvICESE3TVzMmcgbXqDjLXZ/bUhTw+RSI2XyrT4qi2sndEuXRxCaX5iPrkoHQlf5AYC
 YQcyn/mqdsnVPhOKS/Uqm3HWpTuav3tza04ZhTWz0cEa655y5qT5L2MaNmdUXR7MUm2h
 vWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KUlCy+JTljNHq00JC7wG9XqYJioqYtdA8ohl5ZMkxH8=;
 fh=CiFAJCSR0dBrrd4JbcOZP7ED6RdIlzgYToKKXEootOk=;
 b=ZzyWryhub7gBMnN81LoWrM4FC/hSojQlhJcmFitrM6wA0BBcAzPd07drtn5siQTyel
 iOblOQ0Q6ConCJQFZ8dfFRqIKMyEvAjX3YGbgjWmg5KEYBgRncxOyj1saoOgZnCZ9MNM
 ZQOZCkhKyo5Kx+vtcj45qvmjuquWwNLmV+IEg4abSRNJJJC4XRM3IDV8RGhcmguSZ2cz
 QAjzQUvlxmAFogfUm2WG/eZQaKIlq+GMdC/uwn6NsDaulGJsqtTHQ641dOR0MC0PXlYU
 bdE/L2mKRFwuaVVnAD952SolwR+2eOIwyveU7koFbDnCtAdCCx4tyX/1VOOBFwC1rNJH
 AYlg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771242689; x=1771847489; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUlCy+JTljNHq00JC7wG9XqYJioqYtdA8ohl5ZMkxH8=;
 b=di1qqmwfhWsyFUpGUk74ql4NAqix3CHJ9EuZeEmtozTXeNkvzO9y/ovy1slgd5zgbX
 PNRu4fSCxGQBG4SQdKkT3UfpXqaDQ+2gXq/3HX31/AGlshdQwHkp1lUzAvPyHfqeVk6+
 rJ54459nJhDKe9FkedxB8k2JdmDDsIM6v6ThebW2yE+GFQK069mEuUmd0KPdF0vMuxPE
 ds/wUusKY8L5UwYfefFW3WTUoMWUkXKq7BRVjG73LZvhBQu7QuXoVBETteMkIRfQu8jj
 vP4UzHfcekq9dImH60ZcUpvJkaHxW3Uvrbkw26jhDmkU73eCziArPaGDYkU+Hg8M+Zjk
 7wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771242689; x=1771847489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KUlCy+JTljNHq00JC7wG9XqYJioqYtdA8ohl5ZMkxH8=;
 b=FA77b6kr9Icmejfqt7aJ8zNuhzd1pSeFYJzDbJNFSkppJguij8bWSuHXkm2LEiayvA
 aj4zBCsZf6GCZNzMD1Lo/TlOPeHbySj628TpT0XDP6cbOiAEaPs5w/wDf+AaqTqcvd4A
 swMyh2+SmVkHFAQDUUYwz+HDi1VsChn8i9XUll8ACul9Sul2Up9c62hec6ppjNh0oJEa
 dcx3e2SsOQR7FDgAd4Tw0U7MR4gsvTy1KugXmILOSESq3sxZ+/nnzSAW+VCfqJRrblFd
 X6x3VMmPjnfLFHw7DetbIoeEJwbeEoHUMqeFa+CX7DqQ1AbaEe+0PUY/NYK9lMXCU+IW
 GNnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5/p6t/E/XPFqQds+jPkOjw6DYN3ONhxlGvw4Aj2LOTy6ITZJJLvZZhnfKS49agGTyHYkUcrk=@lists.denx.de
X-Gm-Message-State: AOJu0YxVbU5+v8MHWfgKVfeAe2PuGYhUUOsB21bf24tUTJIjuHBKV96w
 qMA5hsvF9TD8FX+Zd+G1r1C5LPqqar/GODG5C8xn+Y+xERtVM3mNlaQSrY5E4wztfv2ik/PztaY
 K8qTUOy1+9rRh6oz6c/PPvzM0D7L1Kvw=
X-Gm-Gg: AZuq6aI+UnU6QXxqxybTQ3zbILFkECZLXBqoT7N5xTFheD3tvGGLv4SpUi+B5jSq+Zo
 eWfY8TIE1l0ibY3ZbUadIcBJn2ID3TXZzA/CUKROsZpYUfbNb1uJP4wsWZ/yviIwe+meffMi6J1
 9zhXb7wa4dO2D5rVRnXFLYYegPoEdiwJJKRuFsb79ZAlFypPwFjZlmAAfGTktxFhacr62ibbrbA
 FJNjXIEuqWJHLeGPxLFCzdMi/BUL9TDThfRGtijhxWG/rSWP1tJgtykaoxWhXwCqYTXEtMs5JWM
 hXkyLSrlUrfTk/Wtq9YXh9tDeFiIaPJM4WD0YHciSkcD8afbXAJlhl1SG+M+9GCpyXBrVA==
X-Received: by 2002:a05:6512:12cd:b0:59b:6d12:6bd7 with SMTP id
 2adb3069b0e04-59f69c6f320mr2425128e87.40.1771242688758; Mon, 16 Feb 2026
 03:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20260211222550.739727-1-festevam@gmail.com>
 <e83ce331-e8ff-4b0b-b4a0-e0b292c79238@altera.com>
In-Reply-To: <e83ce331-e8ff-4b0b-b4a0-e0b292c79238@altera.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Feb 2026 08:51:17 -0300
X-Gm-Features: AaiRm52T1bRgLIRiqZDg_fO7Cd69phb4CIT-_mj8ZSTZS-nNVOc99eq7E-Nj5l0
Message-ID: <CAOMZO5C7aU3aCmzRS2QF8U+CJAvmy2LTzcN_PyvrhJ61YOOCyQ@mail.gmail.com>
Subject: Re: [PATCH] spl: Add generic SPL MTD loader support
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Cc: michael@amarulasolutions.com, jonas@kwiboo.se, trini@konsulko.com, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Dinesh,

On Thu, Feb 12, 2026 at 2:42=E2=80=AFAM Maniyam, Dinesh
<dinesh.maniyam@altera.com> wrote:

> > Sure, seems like the approach is quite robust.
> > Let me try the approach on my board and will update you

Have you had a chance to test it?

Thanks
