Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08C31061B22
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC64883DBF;
	Tue, 31 Mar 2026 01:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VsK2dpTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B3080212; Tue, 31 Mar 2026 01:00:13 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22E580212
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-46701f2077cso4617661b6e.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911608; x=1775516408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vK/W4WZVFKzUcFwdjInpyyw7836sIKvvUp6OtNMsMtk=;
 b=VsK2dpTKC1MOw8sOJ1FpBkSf0IpntPIjGnbvOIUeqjab1H/XGeA/D5S0//hJTbPuCO
 Hv+kk/aUo+tDfRC8q8fiDTNE+ltaL8vlZFGH8ABpdaTX6JFJnIVtO90799CckSLjU+VN
 15nRxCSeBZ3g22ReDPTMyvyOVyYlhA3qT77iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911608; x=1775516408;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vK/W4WZVFKzUcFwdjInpyyw7836sIKvvUp6OtNMsMtk=;
 b=s57MoKRZVnirrXFgGrAX/b3USuRrj8Abz/1w0bZmTGDj5VFXTrhRrIPx9MdZME7/2z
 a60XHQuaC3xNEohHPx5ULzNqtEIA2FccfGwpZ3p7/PBH5RZ0AujtCBF/xzx579RS/YaS
 CYxfxRmwH2s6ngIeVT7kws/AndDyZXLl4a3Ka7lTisISWmFJUVi0gfVrV5u2Zn9V70rO
 hg+EmcgaoZW182lyT104U6J79rNFZTg/CUzYipvKpNL9vJaXWW4I54577qb+GzdpqTUP
 GOSPWLwQcf9C5aYeo948NEzcLVgFMy7efzuWsC//oQHc1Kd5dqaraVs29CQ652QAJ+7K
 AUsA==
X-Gm-Message-State: AOJu0YwFMIVP9CTm+19ySGcBCEhkBNhSJbFfUb3PHpnm7AtDSdQFzW3D
 MeL8OtnesLE9g6DyeR0ezbzWwNmw3Iho9q4Jwy91q0OpNjAiRpzweu1oXgmQpNFDqrMbOLUVJff
 Sty8QNh0=
X-Gm-Gg: ATEYQzz+cG/Hb6b1b909HRWrnHQYJMPMBsXpHpqCAgYgrfMaOwe2rMSQBD0SWUZTVgW
 ThAcHl+v0HiSygqFGXTj37v03ApjyvL5+J3eBX7GwhEpQAQ5Rk0hzqpX1eLNexvaWRJQz+b5rU4
 1/eoxkLmAx2ZWQ5nUahskX1+2MfI8Fki6KOx9mCPtJt6RYHYnQRALYbLb9bZ/zC19dK+JVoEihZ
 9XDEBzKfBiLXO5ckEnuYDy4uzXEbEF4c0oExBctJ4FPDJoZcEDPcQg3axOnvziGHsNllrkYBF0S
 dp/drkzEL1mIt3pLv05zrvrzz5iMv+xu0wmXrEkRGtrgeXmLWJGqXZRRk5614swO3WbTpEy2x9A
 OCejfAkub27Y3sBq9A7ybhrq9dNcix2Z9DlgKbmJio6tXQyOWTyrwTwoIyvUekCTtZDxMxmHSII
 xLx/66K9vXvHybH0sxNmqyKIp9EYMIXFEZ2/ASiBYdDb13MXKXG8NKqngwuUdapKLIyDSWfDrLU
 E7ft0YeNjE08vx4YTMhwBP6nSHzqwznUkwGs2zXWe8Zt/o=
X-Received: by 2002:a05:6808:23ca:b0:467:153a:2d9c with SMTP id
 5614622812f47-46acdbbd587mr887286b6e.15.1774911608542; 
 Mon, 30 Mar 2026 16:00:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260316012511.1898638-1-trini@konsulko.com>
References: <20260310162618.1163914-1-trini@konsulko.com>
 <20260316012511.1898638-1-trini@konsulko.com>
Subject: Re: [PATCH v2] FIT: Image pre-load signature support must select
 not depends on FIT_SIGNATURE
Message-Id: <177491160783.1028292.9379054713977461531.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:07 -0600
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

On Sun, 15 Mar 2026 19:25:11 -0600, Tom Rini wrote:

> The options to enable pre-load signature support (full U-Boot or in SPL)
> must depend on FIT_SIGNATURE being enabled, and not select it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] FIT: Image pre-load signature support must select not depends on FIT_SIGNATURE
      commit: d09256283f720f43a873855caeb2904eacd22273
-- 
Tom


