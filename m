Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92B5CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 130D58452D;
	Thu,  9 Oct 2025 16:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEe7x1Yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5708453A; Thu,  9 Oct 2025 16:19:04 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F838455B
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7a7b084ef77so606824a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019541; x=1760624341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I0dGSdBnnrHLXmJEKG1E53mBUNLJ5w25cdg+Z80GB1U=;
 b=eEe7x1YvzSy6uncw+uQtSOz20RtOTb8GpQO7eMJNxW/rQkyya2twRCPVADbeqRZ6rW
 bvm1IncohX69dXcAKkNeQr5RM9/yhM+Pvk6Qyehxono42YqfJOM94fCPuFD8FRFp+j4P
 N2yd69jzybl9uh0Pu5MJ/tEYY1fDblIcUFqqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019541; x=1760624341;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0dGSdBnnrHLXmJEKG1E53mBUNLJ5w25cdg+Z80GB1U=;
 b=ulXMHqLggA0i2+xw2Za8UdUV+DSltzo5VIFZ8UWC1cR+RiJg8oM7BqpsvkNQVYFd9S
 t1ITJqbR6Vjlr2bv5+Li/sZ3uqm+MXcYW7DaSf+pqlD4dxTWTAZw0yLkNZYm9LvPAAG4
 owHeDCI8rye/05CHpPMVVpJR2VjyvolA4J/ZXj22CW43GvnMUHQrFx3qioTk0Qf9YnoA
 uH0SRIvGpasPMCmKISoq8WgEBrcHBiHxUJnVa9tVKNZrOja/lQZ5JJsL3hRpwu6Pfj3E
 eGiMyNxT6M30xGfGXKbIdO05FI1pokn3wjEcE3J2hw7uX9sYtYcotq3KibBw0scMbYv2
 UDZA==
X-Gm-Message-State: AOJu0YzMJaWk4Cb39w03pHMDUIJqPt7JY1KdMGBAbC36rvNHykQuAff/
 KtKqwK44/GeQAdd1wwUSH7LZWt5oVaNk9qe7V7jN2fwxzl9h/GFIUPQ5ry1eDM2agLyxtd3H8Mr
 baN95RSs=
X-Gm-Gg: ASbGncso1Sq+iuXOOAQYVck2uv+fKbE2t9MABQuIKObNbF2j6KwOd6DDxPlRyJYs4qO
 ZCDx9XOeCh9fivZTfxhzpS+f0Aain+2XHwKyJOinYz37tA16Ipb7mWncJeN4KZx313CSPfXefpR
 Wq5PESzyq/MEjPl1lzD0rvB0FGsUBVGlj5thGHFM4c7/IQFCM9E8tZqZKKdBU5505U0/BApmxze
 ZffEEzlk8LMU0IAs2D73ikdaGdxXGfrnv/oA1w5qlNZMFrdEjOJAcjaePsYuDK51VS9DU07mpYv
 kj1sSJH4uAR3szNhhxSG1SeCZfFEdBLIrmwAWYlX64++2omIBxyT6MnRnqAOYUOoNwhsdUK+T6G
 Su2wJ+UVtSHre2gttRtO0yGPo0jJ2rEZ6FV48UTlDWOLXjxFbt09Iq5Xt9gryxrqtuf+ON928Un
 UfXPOheBSe
X-Google-Smtp-Source: AGHT+IHGe4as3bJSy2z6oR3BVtRDdIMBLo84AA+Fx+tY4Pb8C6gyTKZVrGpBn7JGQ9mObT8OTP2Tnw==
X-Received: by 2002:a05:6830:2817:b0:758:71cd:897f with SMTP id
 46e09a7af769-7c0df69f118mr3967095a34.7.1760019541417; 
 Thu, 09 Oct 2025 07:19:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:19:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250926153142.3680917-1-trini@konsulko.com>
References: <20250926153142.3680917-1-trini@konsulko.com>
Subject: Re: [PATCH] rng: Tighten some rng driver dependencies
Message-Id: <176001954067.3159859.14813335759559674726.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:19:00 -0600
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

On Fri, 26 Sep 2025 09:31:42 -0600, Tom Rini wrote:

> In this case, the NPCM RNG driver also provides some of the functions
> that are implemented in the generic LIB_RAND file, so only allow this to
> be built when that is disabled. The exynos RNG driver depends on ARM
> SMCCC calls and so cannot be built outside of that. Express these
> requirements in Kconfig as well.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] rng: Tighten some rng driver dependencies
      commit: af4acc7186fac32b69e2a0ad5e1ffb4677bfa825
-- 
Tom


