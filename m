Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF87ECA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 15:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9128783B24;
	Sun, 17 Aug 2025 17:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nTKM5ETx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8706F83B22; Sun, 17 Aug 2025 17:24:55 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C2082B07
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30ccebab736so2987637fac.3
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755444292; x=1756049092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3+SLya1/wiBq0mBhkunCsAvhENTsRV/FYuMJGnW+0c=;
 b=nTKM5ETx0TJBzNSYQuWwC+r1D+r87mq7zqxapj0x90GlBI+UhetAxfAA7OziEDQTxE
 3eZanm/tlt06KF2+Lv//15smISapNhn4M9k0VJI5U426tM8VtY78GIrlvOC087BfYA0x
 AHo26y5q5BabpMZHPlF5xEwW4yuHSYNntZXw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755444292; x=1756049092;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3+SLya1/wiBq0mBhkunCsAvhENTsRV/FYuMJGnW+0c=;
 b=Mg13OVXIUPN4DHJUokawdKah0/r6Pj9CuOdTV7BVrAyitXZ2CEPh1zTvfBmna9nS0a
 J+KcuuqrOVN14PDcCHM1AOvLKycgRMX5RPqRyMWwJ5T3dV7mMnl0XoEiH8VZ/zFtPK7P
 83gZJF3EozwtacmNEATRmoZNG5ZliUbGLiwwmlSJrQPcrrVHenYvfgogRaiRr1p18pM8
 dRYHa8U1eY6Ac/Xr6Qqcb60hlmTeKlZNYYcp6kKtOgqZ28PxQ4k51J/IQBhSnWzpWeCV
 nIs3QxvFumIm7L3qWIIIV0x7pYGU0nkYIyQfxhh86IKoMU4QWH9skBAhFNTKNiJNAAUe
 yYOg==
X-Gm-Message-State: AOJu0Yw1+flMruYDOcTo/UNgrexP+sqpx/3j3J6Unkq0LqebqaU0BZvV
 uAIa3e6GibRLtNL0nMLj2CK2UitF/R0yzj2SJUti7uXezYjIW5GRPjKE1+PfQms3dKTrzblD8wf
 IY/xf3ck=
X-Gm-Gg: ASbGncu6/GFD6H7/A8j/CdSYPXX3l6y00O+jXvsl804VTtNBThMj5n75x1Ct0ZR7rGj
 UjFWsx+7XN9A1K137AInh80P77PbfFOZkOZp9Ocols/mmNr6fD/o9FvUsSGGIrucWY+cmvgEv0W
 +3b+7OZ7YUWmCF+C5ia3hvshWUvdIjGBvWEsPSec1ezDLX5utkLJLOSS7F1pasGSPwwV6RMwKCe
 JgIOlNfKQg57E7F/BjYjHtbjH+JJWfDw7CUVpL42DcFKNrM8P8zo2v1l2iQPQOUhEgqARm3aEcM
 npdnVDH7heyd7+7GEnIYUCPKzKAE+v8RC8p7a3fZlDHSUsiKhQ2uY7vBYzKWz71XCZbdbwD1bMb
 h01yE5TURcRyXfXB4RWPNb3hG6ngozQnfYbF6O5pUaYTuYN1ZiZiBS0w=
X-Google-Smtp-Source: AGHT+IFron/YhO/DovOfleqAtIWv04j6Xev3SrD2ycKh7e+zg4ESI7GSIrEnXM66pNAwuSLBKNn1nQ==
X-Received: by 2002:a05:6870:d207:b0:30b:66b0:becd with SMTP id
 586e51a60fabf-310be68e467mr3451436fac.27.1755444292228; 
 Sun, 17 Aug 2025 08:24:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab878a4esm1998472fac.3.2025.08.17.08.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:24:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250806-phy_ti_j721e_wiz-v1-1-9b6649dda32a@linaro.org>
References: <20250806-phy_ti_j721e_wiz-v1-1-9b6649dda32a@linaro.org>
Subject: Re: [PATCH] phy: ti: j721e-wiz: Set error code before goto
Message-Id: <175544429133.372553.2707691454201890902.b4-ty@konsulko.com>
Date: Sun, 17 Aug 2025 09:24:51 -0600
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

On Wed, 06 Aug 2025 18:03:26 +0100, Andrew Goodbody wrote:

> In j721e_wiz_probe the test for too many lanes jumps to the error exit
> path without assigning an error code which could lead to calling code
> silently ignoring the failure. Set the error code.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] phy: ti: j721e-wiz: Set error code before goto
      commit: fc96c1de5b719561db15259009a9ef22e671ee3d
-- 
Tom


