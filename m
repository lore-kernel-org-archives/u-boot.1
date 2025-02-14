Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE43C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 16:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F2C80C7E;
	Fri, 14 Feb 2025 17:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q1iEPj3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB4080C83; Fri, 14 Feb 2025 17:52:46 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C8DA80756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 17:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso1586247f8f.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739551964; x=1740156764;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FuU6GX0oZMFuOSrJXdZJgc5bs2otaLdNA0zFqDkxtPs=;
 b=Q1iEPj3fL0pZxlJ94wnaXo2IKRVvhey7K+yI8LZA6tfMN9esAdrzpii1jPj7s753k6
 xa2HTLZ4QO31wqYYqGYR9JaTh3fYiwF6O7KLyXGFltQ795L9pRaoJSDJa9p0WfFLWXyc
 P/a7fZsWulB0dI7TOdTZvC3E8Aw2aQr9FpQ7KBaXWdKlhg9sNDiQOMWsvVpYKE5Voa4p
 Q69sDNIXyUC5U//76XVrEH3nBIAql738JFY9cpo+nSt1VGQmufdfWq/pIwlIJAkTU27k
 CwEPkqqgCBmNxOJ7PMHKdT0ZKJzLqbORMGtMPTXqgMagxH0Dl/AERJJY5G898p0HfGN+
 4USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739551964; x=1740156764;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FuU6GX0oZMFuOSrJXdZJgc5bs2otaLdNA0zFqDkxtPs=;
 b=eQlt/1EB+f28IG8CiIn4bph6W74sJgyTptpiQ6LD1UipAF6pFipUn0+qNi6cwUVZuf
 Rv7qMa10t5mz4kMe/koWIa5zWGci0LyEi53O8o7Wmsg9JHj+rC2atulwXIMmki8fzvAf
 +2bhhq9JR52EVgTMv1CcXpHNpUlKmQStmtAstcvNfHlW93c2Adv4mHBSjntDwoPPtrgm
 lCBIB4n4Wg7t4RiXEoB8EdeFf6LlOTVUjRg37V1KMvDVHI+LJKFp//ifYvaavrCRhF/S
 4cVkrW+UHe6v9n6R42VTCVpys92E7ZHZGku27kFz5AzW85bAszrXe3N8LOhGimF+oPwu
 vvQw==
X-Gm-Message-State: AOJu0YyFWKb14RN2sgXAvrSzz0JGknkl8Uq/nhSj58lBV1PeaH+cSqlV
 28yCF5LLmpgnX4RqYYlCWE8u2NZuSzSIXIRsqNmnNOeUlNdbMLMywAO9CKoZuOQ=
X-Gm-Gg: ASbGncvTBAzyKN+63aU7fg2IfLSr9RiHEY0On2uME8kOW3bbklysIfF1EQYJQa1kYtB
 GkLUMSANrV4jHBV25UnLqbf1t4KfNzXWD8LT5F0tYe+X8EcNqzXcPNwbQfH434rJlRe02gVN6J+
 kbEgEosw3O6uz1FAsL3Lz80hT6ERxsHU81oPSxJ2Ax+aPJJJkkyKkMgtvZ9RCSgRtOYpnEVyHsE
 zAumIFk0xfFSKbgUBtRkiK22obAdbKRR7DTmHJFbTPLW8H5myv+lzux2QPEawZj6wkgImuhVZZ0
 Mf95awyzN8viNg8EnhQrLNBh
X-Google-Smtp-Source: AGHT+IHO4TW4GxrlZEc5LkGLTzxEYxqg1ux2T7PsqocctRbYG4FIsLjlusCTt3qAEXo8UD/uZsrhcQ==
X-Received: by 2002:a05:6000:2a5:b0:385:fa3d:1988 with SMTP id
 ffacd0b85a97d-38dea259847mr13563903f8f.8.1739551963825; 
 Fri, 14 Feb 2025 08:52:43 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd3bsm5097282f8f.22.2025.02.14.08.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:52:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymond.mao@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal
 Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Neil Armstrong <neil.armstrong@linaro.org>, Aashvij
 Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, Jonathan
 Humphreys <j-humphreys@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Wadim
 Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/3] xilinx: dfu: Fill directly update_info.dfu_string
In-Reply-To: <20250213195351.3518305-2-j-humphreys@ti.com>
References: <20250213195351.3518305-1-j-humphreys@ti.com>
 <20250213195351.3518305-2-j-humphreys@ti.com>
Date: Fri, 14 Feb 2025 17:52:42 +0100
Message-ID: <87zfioh3j9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Jon, thank you for the patch.

On jeu., f=C3=A9vr. 13, 2025 at 13:53, Jonathan Humphreys <j-humphreys@ti.c=
om> wrote:

> From: Michal Simek <michal.simek@amd.com>
>
> Directly fill update_info.dfu_string to prepare platforms to switch
> from using dfu_alt_info variable to dfu_string which contains description
> for capsule update when switch is done.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  board/xilinx/versal/board.c  | 3 +++
>  board/xilinx/zynq/board.c    | 3 +++
>  board/xilinx/zynqmp/zynqmp.c | 3 +++
>  3 files changed, 9 insertions(+)
>
