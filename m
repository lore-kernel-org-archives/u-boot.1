Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F80C369C2
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 02:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB161826AD;
	Sun,  4 May 2025 04:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D3fcvq8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F79782724; Sun,  4 May 2025 04:31:31 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7198210D
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 04:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30bfd4d4c63so28361311fa.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 19:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746325888; x=1746930688; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNFNEluX9fIEh7fE+Z4g9arPxy3ZNWoVN6CAYDQMetw=;
 b=D3fcvq8inlTzOv2iwQSeOXtIcWOjin5AGR6nyzvYLFGKxNBLgcRnYkOuKXkxtisGyA
 dY2KF+nXCYA+rG0kvzz8CO/+Tf1lILu2Nr5YsLr+9ul0if7ngvNzvZR9rl04V8ge32r8
 eoqqZmgL4jE1JSF/S0Y0xk0Rk+AScKnvYW3iqE2btaS71AtXOh9cNhAhDZ/9cYz3AiN5
 DLVmZwf1vHlhS5L1nqwqn86NozhYKRJTafLDjsXyUkT+oc4ZECJbh7xoflZLXmPP5g2I
 0i5WsiJzm24OPTWFtidqoZjd6wueZRJXBSAQpzdAdUlaS7lefJE9HMxNWobe41SNjOFl
 Zlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746325888; x=1746930688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNFNEluX9fIEh7fE+Z4g9arPxy3ZNWoVN6CAYDQMetw=;
 b=R0CS0bdXDdMzIFrLn5ojhNnFmWXB2pqldTv7F5xW8HX173o7l5Md6cCBXVHxBYpBH5
 UKiOM8ktt5V8Vd7Quy+xXwsdv1cG3szwKkKrvJr/ni4mM8JB1Sc0g1y/lC5O6zafqJSP
 JIPvJMzOjy8ez2Y7xg67HYoI81sxzTb6X9l56bieEBBO+JfdVVzhfJcxbSeKPVIEYYXY
 62KaPlLDxxLnCq+OYPNJ+bO6kUo0uerknm9A9T11s/i4V9AWL0fgutry+qSxK7db0pWZ
 RMkgZTX2Y+5kjfthen/xtYFKmbhe3OfWkGb/R4XagQMyN6ZLUrmXCiB2LZ7ia4kRGEbQ
 5A/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX09lr54GSW50wiXJGJTaC2S/Wqk4/Kv8Oi0Mz8yBUlTdgWHpW1ZXploI+VV7bWLcLbxE9in4E=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/XPjIgacaCUBG2lf+DNSipvdsIGxHU32XVwKP2c5vPbzeyeSz
 YxGIQ7NPaG6Q9lTlJFrbHMWdGP4Utu12kx9JB7fj+c9dFXw4tqM0orCqUN4fgzXDVtO8cgznK/O
 rkQPXszZwJ8Y97MmtF8Z0hKk48RI=
X-Gm-Gg: ASbGncsw95ce7GszuLo085DB8Z+HP/djSRfvcpDhFXhQLOc7z3myf1C6p5ZNJ+3AoPG
 xnBqZktdo0RkthQz56zmy2D8DBmvfAisAxvMiXmvourSQ2lAhfT7jX6qxuj/fRe2iciGfSpaeiO
 7S1msl+88HEaQ7cDVgZ9vhbEAhVowZzhGvsv+aUhQ2cY+Udy8fdsnC
X-Google-Smtp-Source: AGHT+IF3CV6Lo8p34iw0h9dv6u9JQPYaJEnmgmjID/+okK5hwTkH5idOUwuTinuhiwLw8ImrehT73eSG+ME8FTGNJLI=
X-Received: by 2002:a05:651c:50b:b0:30b:cd68:b69c with SMTP id
 38308e7fff4ca-320c3af154cmr23018891fa.3.1746325888453; Sat, 03 May 2025
 19:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 3 May 2025 23:31:17 -0300
X-Gm-Features: ATxdqUFpE6c4JH09p62Q4nd_Z88iD827PQolyyTOrYvEZsy01t8kqbmFz9FHO0w
Message-ID: <CAOMZO5DHOrV2+Cf=2utOFaOMJH8L43s8Bp1uFOof3fvv7iMB6w@mail.gmail.com>
Subject: Re: [PATCH v11 00/21] imx: add i.MX95 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, 
 u-boot@lists.denx.de, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
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

On Mon, Apr 28, 2025 at 7:38=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> Changes for v11:
>  - update spl_imx_container.c according to comments from Lothar Wa=C3=9Fm=
ann
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Applied all, thanks.
