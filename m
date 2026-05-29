Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B427CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66DA68484F;
	Sat, 30 May 2026 00:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hM5NOj6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E7784693; Sat, 30 May 2026 00:46:57 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8EE80087
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-69d7aa0ac14so5200706eaf.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780094814; x=1780699614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7VqBheQT1lZ7JX+uaSOXu05ZWgmiTQhXwgGMV6SZa0=;
 b=hM5NOj6KY3eEAjS6uyjVVggSTv9YFmJiA12WCxdQ3SbYCUPtXD+9s3FAbaWA2KOvs1
 CbrH/FcMgyUgsj9yLyHxfKQZkLZ0DZcgV5rQuvTDT38s4FGc/IfckSDWrqSuwKI1zNso
 49AFLTUm02x8ZOnG6rc/EUD0D27FImH31si+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094814; x=1780699614;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S7VqBheQT1lZ7JX+uaSOXu05ZWgmiTQhXwgGMV6SZa0=;
 b=fc4QBzRqSQ/G8BFRIm0uV83tccwKazbkDnDAtjIMlDrgjiz70y/W1PjJr0bZUqDHXI
 O+8S56EimYOKPtUYjEanXz6JnVarZLMSSd1GnipLJHAeuSUpfkUzTAqQhoKcTjB0uHTZ
 oIFgqeeoPi4QdTAaMM8Fk9sR2Xg6UH0y/ZmKFqjU1l/IKGk5y71pXHTDsRjpASLaO9jO
 ARxGSqrQVqcTed9dq4AM+B95SR5JslzBfwLm9X0g+qDBjLfvJY/v2ZCVwSJ8p099/+jH
 ee+VhPR9hZ/ciX2I2LiUeVtVE6g1cGEjhbrj/solAkxgTXy+++MwNBUmtIFERNLB1wdf
 lwQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HEdAweNHVdH94jzr7j7Ei4ezwOxOGezdIxQ8ms+7APgYBHxGlk5kLvifWwt1BGi5rxFKgo5g=@lists.denx.de
X-Gm-Message-State: AOJu0YyKiq7cj33rZ1BGZjhdqFRrEFsOQfI7S3L/PXxCo/qXtPtd/aVA
 8nASjifVFzOvEdxOfimWRJci/RVpHmDiOdeJ2zggCaGNOH/dQdOT4Q56XgxMPOJAIpFldO9DO9g
 oJotlztU=
X-Gm-Gg: Acq92OG1DCySpQNQD4e+DpcLp8FR6wqwNC/XYuDOMUcUjWxcDaA0kUb39VlbU4mJCfh
 PGkkvWPzvuj6Ubbam7oo5emWq2OtAOXbPGHz/bLc/Ey+jaBWncO1X+zEFRwwTvOSj4GSmVn5Xuj
 7WMhrjKWIRmTuqMYqGdda02F3zMuVRhBy8MmrlKZ75OHUNRHkgtU0It20awinDkn4dgaP4DU6lr
 PtyW1FllQz80PtZiBaVWKt2RHl8MPeqnTq/s6ORpnWwhjEDsbKPowon0osrttZHHMeb0SuUnZkd
 QbQFWdzSGEEBexMQw2JeRoDzpQb09n0HkI/3g/YT+A9wAZECnr1axcY0n9YdZqtlJdBxpO4cm5y
 V83LZBm//++3au5sPHoitoep3aGog7zjFIY7Yp9gAblin2oQJiOOSE91O+JI/ccI8jjf/qZUwhk
 w7nzVqCx30v8ZHjXpcBD3Tmi49Xkz5wzMJqW8nkfNSNerpcc/yMV5p50VRXNvihdV7+Iyz/etIt
 OjcwXkwru9lAUTeM+y+mHOZNDmXKECSYtW7DkbroWtrjZ2muOmeXdM=
X-Received: by 2002:a05:6820:818e:b0:69d:b4d4:bdf6 with SMTP id
 006d021491bc7-69e10384313mr730318eaf.29.1780094814502; 
 Fri, 29 May 2026 15:46:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e0696923bsm2112441eaf.11.2026.05.29.15.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:46:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Abhash Kumar Jha <a-kumar2@ti.com>
Cc: u-kumar1@ti.com, n-francis@ti.com, sebin.francis@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20260515081745.1062139-1-a-kumar2@ti.com>
References: <20260515081745.1062139-1-a-kumar2@ti.com>
Subject: Re: [PATCH] board: ti: j722s: add processor ACL entry for wkup_r5
Message-Id: <178009481377.728062.17086220144407933493.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 16:46:53 -0600
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

On Fri, 15 May 2026 13:47:45 +0530, Abhash Kumar Jha wrote:

> On the j722s platform, the DM firmware resets the wkup_r5 core at boot to
> enable both of its TCM memories.
> 
> This reset sequence involves three steps:
> - Acquiring processor ownership of wkup_r5
> - Configuring the core and requesting a reset via TIFS
> - Releasing ownership.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: ti: j722s: add processor ACL entry for wkup_r5
      commit: 59d52a9975777b959e3bbb0b5e08b64dd67a705f
-- 
Tom


