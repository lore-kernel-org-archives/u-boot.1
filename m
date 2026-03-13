Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD310107BCE6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EF0843DC;
	Fri, 13 Mar 2026 21:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hrq6YhNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABA4843C3; Fri, 13 Mar 2026 21:55:12 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C567E8430A
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d748ca8708so1640988a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435309; x=1774040109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jpkoSlSw6ft4awVVNlGNzzH0qJeNfskt9CN9SHdvg1M=;
 b=hrq6YhNSy9l4yt3POzbKXmijULIH+J5VVvb306JHpryQkFVEUMPhrZdhxx+//2mycP
 EUr1q/DVJaZiG+3dS8cvGn8TKCGP2CwJF9+zO9zWmY+ObqNI9ePigaOA6fuGa1Tlu5hW
 kjjXK5c4T82dfCqgE8BQpzCLD6sEumESqFXb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435309; x=1774040109;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jpkoSlSw6ft4awVVNlGNzzH0qJeNfskt9CN9SHdvg1M=;
 b=fJuDnue2o4kwpDEQOWDNHB3BAr2LPTieWyscrq6ree6LA5Gqdxka/dvY9gC7g0hzcI
 HwD6vSvPubk/sfRIcLx9Np1swbBIc4ftwObZagSxEnobkA+7FAW4uA+JTgXRR1efwJUg
 YfZcGY1ZfGGmfH17MxmKzJw1wPqBu+N32S+5RKOkeIYjds3YAiu6Sz1XUxlKRCGqoUG4
 67ycxEbMmy83bamN220ik99WxgxMLs7fbUKzaPZJ0D4Y+GBPBeF8Xu1Yq+F0RQ/XvMWq
 gmpfHXY8z0Xkb55lbuX1j/wDmdEFvWpV7nsWNnByQDphuoxqvOH4npAOVcF0JUytUmv4
 pjNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDGYH7Im2LwIRK+jq+hwTUzA4V/CU4WnCklDSSSL9XeZZwyjw1NwXzwaIurOCDOzXsjwT0k8s=@lists.denx.de
X-Gm-Message-State: AOJu0YwTo6tjToQH23duQGNa/pLnru1qm1hz2mU311SBDAVkp+ZR98Y7
 KOwx+KGbxWk+sMXHGY1OWerSaW0rv1HZiNwA9uZ1xoyOudaMDw5BhjwpprbkKUPxqqs=
X-Gm-Gg: ATEYQzz6LbZN1Uo5K1OI5aeDOPwWCzEmOlWIlDoFrIRgn6bwVTO/5zJfdz9WUcCCTQC
 RyexyAEBvCc8oxDZUSH1ZsoXAM21YnYWpcGk6roSzVDZ0k1eG8p1OL00YuVNGWTW+0FbPuoOXNy
 rxAek7ixm0Dp5B5u344SyQ1SDErykQdlbXVpQF5NqE8W70f5A3HPvw05xbNJm6geEB9DLSdgEWL
 om5kGDvZil2Ic1I7h27xE8eAphnwpnNro1zAZud8RvpEySmyXAqBxYI4BQSQ3gh/iOm9BxczHFN
 npCTb+bybL5lmxxIu+xtzIBve46FJpI77kCxQL16QA6af7T1qi6f3hJBK6hP4LBsj6X9KoqOYcs
 SqqNGQbYnsf7YlUoiiCR3UMsM89A6FOy2Nao7PEO/rxQ/MRHhyn4FrYD4wAesVyklIqi3S2xK95
 k1OoUh9hZUg6hzn8Uo2a6kkRx+fNdFLppHut05ONt0TebkmnvO2Ibr1y5n/5jCalvHN8tPo9UtN
 ozEH4phKvOE+aiRYiCT7/099EDUHbZY/rLubKvqHS2i5kLEmf9QjYfMcQ==
X-Received: by 2002:a05:6830:7313:b0:7d7:57c4:367b with SMTP id
 46e09a7af769-7d782568d0dmr3509140a34.28.1773435309520; 
 Fri, 13 Mar 2026 13:55:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm6857942a34.18.2026.03.13.13.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:55:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: anshuld@ti.com, u-kumar1@ti.com, Anurag Dutta <a-dutta@ti.com>
Cc: gehariprasath@ti.com, u-boot@lists.denx.de
In-Reply-To: <20260226090524.2733474-1-a-dutta@ti.com>
References: <20260226090524.2733474-1-a-dutta@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j721s2*: Enable OSPI1 with 32-bit address
 mappings for R5 SPL
Message-Id: <177343530793.1131472.5835045594919925902.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 14:55:07 -0600
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

On Thu, 26 Feb 2026 14:35:24 +0530, Anurag Dutta wrote:

> The R5 SPL requires 32-bit address mappings for OSPI1(QSPI) access.
> Override the OSPI1 node with appropriate 32-bit register ranges to
> enable proper address translation on the 32-bit R5 core, while
> preserving 64-bit mappings for A72 cores. While at it, remove the
> disabled status override for ospi1 node to support booting from
> qspi.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: dts: k3-j721s2*: Enable OSPI1 with 32-bit address mappings for R5 SPL
      commit: 6a23c079b877820195ebca0b98f78abb66f47497
-- 
Tom


