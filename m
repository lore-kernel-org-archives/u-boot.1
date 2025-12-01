Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B21AD116F8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 08:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C98C83A41;
	Mon,  1 Dec 2025 09:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hVLDtBnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1583E83A5B; Mon,  1 Dec 2025 09:50:21 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF3A839A5
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 09:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65745a436f7so1621272eaf.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 00:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764579017; x=1765183817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Da21vmr2MGnV99/CC1cHtlk6/6F3M0jJ7i663GPRNG4=;
 b=hVLDtBnhyO2QTruSjvobu4ezPIFsYIOuw9/weBxMAAk+qGODt8s+FfxCQ/+n2jETqi
 /saXgjGjz18bxwE5GHjG6bp8AgOT/gl4NI3deuqhAf8R9NfZvIg8/kT5qIIfekX4EP6c
 k4U09Q4imRfrJg2V5+Z/RKR25YZUGv2ySBkWaTtGBLWttNIvXJWRkZxbqO+Y8tUzbW5W
 pURWS73yjdJ8AyalAIPAL+UTAZHTO/Ez2nwiLL6fwx1K4EdKxG+gDuaUwq4djMd2dRHl
 WqabSX0yvt+2WEeXk1mUv8M5JfLUxHax9YS/DFwMlUzj0E7UPmU9xIKEP9/reIbAaq4E
 xJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764579017; x=1765183817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Da21vmr2MGnV99/CC1cHtlk6/6F3M0jJ7i663GPRNG4=;
 b=wBZCMMRArQC71fW7UfK7aSyI4p6qCwc/L+M01mnRuiYeZPqmlkSM/zIpwGdo2qXHkx
 UMwuSwuuCa5F4HiJcnxKB2iAD8j1DF62cNVdmrAG+4HrRo/ap2RJNER7M043gKrC0GPp
 UYqc5Ir2DIMQY+qihPS+0NlkVBsAXLHecigLyojEjnVaAou4HohFLYoKTseZieTRuhkq
 dxmTd83w/1urrfJsvjFGXpGtC+ZGUAwljknT1Ed2moIBCTczcBibH+EyKL9RXsJbeDF8
 8unbQGSBgCELc6YYxRbREDbVfYGGUFjtpXHsLwsCM1e2yoNiL4ghUlw1/A6kqejmf1eF
 Gqrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV770dYCw00uK0oCZ1k6ifB35mKDT41xGCK7iz63Y0gqsllJXuEc2vAhASvlODXRRwhk8p/tVE=@lists.denx.de
X-Gm-Message-State: AOJu0YwTLKt82DqF6Po+C4pHaiRptnKuub8oc7H+qBFM0m8iJH7bPueo
 X2hyhOPNSjT839Lxmwpm+RZnlSqEKv3KLbRGNyNQGh+409DAmUuqp5OtJdoPN1y4tZBqPDK3cMu
 vFDTONsicKiTpn1y7q/p5XdWnp7pFt9Q=
X-Gm-Gg: ASbGnctTxko4UlxpyrjjRQDAFlOhuHOtsuzHFWVEsqBeTtflm3u8SgsZvDJghz2e/U6
 9cGGOHTUlmQF5ryhnQZBcLGvNt1sygiJTj550NS09Z6AVzngveGuYMkS0AkP0bz0FnAm5fniZfx
 zQViil4LXT/75wsVR9aTSkf9Z25iQ4j12Av+gdwaaph/j0phBSwnhUuXtLYVDIISFmBfKTB+V8L
 0yrsvz3D69OWjz/WeopepddU5fN0cvFJqYLggH6ZLX5y4z4PVXvVx1DTHyS5YEcdbPaYh7F
X-Google-Smtp-Source: AGHT+IEkk1jm8/Vug9C48pvxxQynBpbz6QFSuEMRK9BlUCg7N4hZJQxoFyoe9FL4I9hMtk7+LG/4jVtdTEeQGpTjKRg=
X-Received: by 2002:a05:6830:71a4:b0:771:5ae2:fce0 with SMTP id
 46e09a7af769-7c798ccd7ddmr19583576a34.20.1764579017363; Mon, 01 Dec 2025
 00:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20251129064818.1587-1-briansune@gmail.com>
 <d2984f4e-0105-466a-8645-60ba30dfebba@siemens.com>
In-Reply-To: <d2984f4e-0105-466a-8645-60ba30dfebba@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 1 Dec 2025 16:50:06 +0800
X-Gm-Features: AWmQ_bkaO9yNh-CT3cUxRZHfAxLoUcPEJ81LU_yDCv0LfBJshk9vRfDFtPRHDLI
Message-ID: <CAN7C2SDZPWxKL9k43JB3rp-8tD8nwbwoe2cx70xFs5NZLCYUiQ@mail.gmail.com>
Subject: Re: [PATCH v2] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

>  - a lot if ugly board-specific ifdefs - my approach in [2] does not
>    need that
>
> Jan
>
> [1]
Complete unnecessary.

> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=483978

Are you 100% sure modifying as such can kept all u-boot supported device
untouched?
 If not there are no ugly "board specific", btw it is generation
specific on socfpga.
C5 and A5 only. You don't familiar with other brand and family.

Sorry your new patch series are still not able to confirm the compatibility.

And you patch itself also used your claimed ugly board specific method.
So if you really like to take this patch "as yours"
work then move on. I drop mine. But I don't see your original patch is
fixed as such.

+#if (defined(TARGET_SOCFPGA_ARRIA10) || defined(TARGET_SOCFPGA_GEN5)) && \
+    defined(CONFIG_XPL_BUILD)


Brian
