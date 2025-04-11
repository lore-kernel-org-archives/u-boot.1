Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5115C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 19:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854CC8424D;
	Fri, 11 Apr 2025 21:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dmO7T0Mk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D020684246; Fri, 11 Apr 2025 21:16:54 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E1C84239
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 21:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso782091b6e.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744399011; x=1745003811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5yQ7VLm9MwQW7yiNaqcGYZMlQJ52VWQ8VeOZrTlJczE=;
 b=dmO7T0MkVvYHFrUChk7srlUBiUPxMM5fOGFmwmlC9rdW4C0xmwL7DyD8UZC2R/z9hN
 mQdNk4EHsyoxtTKTXQsz7QpkuISy6g6cbl2KIAGfNy+DkXDJjoYIpHWpiqGHHlCNb3ET
 OT1K21SYQYS1vf9y1sZ+caAxjTs7ovl1P9P5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744399011; x=1745003811;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yQ7VLm9MwQW7yiNaqcGYZMlQJ52VWQ8VeOZrTlJczE=;
 b=cjPzPJUq7aKkNJ95Oj9x57uMzOqFh2fAHB/YoKMeeKaPWrBXQ4PfDGdNE/uQz42V1Q
 fOEVD4IH5fCvTadUmMDsoLJIkUZRQmGWRQq3C1FjpO38CZxH3fG6yUUK6z12shEGNOwQ
 F/CoAKDowdCpdaW20Vlp7xephfRO6oXsSsCwwLD37oPGJqEeWTjKyeqPk6ZE3CAPo7jM
 rZYG17caxMsQbo9ZJPleGspbT1PBm3CPNlSt2OlR9t12FUi3Jx0mWEv4FUSCkTLmeqVG
 rVz7qrOd+TtNk5vy1DeTY/RjBw7rgGpm+RYZ2qa+QS1FqtU34nmThobNgzCUvDoKboDh
 AwXw==
X-Gm-Message-State: AOJu0YyXUyTYdgArwLSe/8hytBPg4QTL/fJhQu0vc4P2BevOL+jJ/kw7
 mYBLHR/UY+OVRcQ2HrIh8a4nnL7VpTVpM0bPzdZ/PwwqjFskWJV1d/BEFdASr+6hc6QVI7vEgQE
 eKkk=
X-Gm-Gg: ASbGncu/HW0OCgiL/s/SsAZr94r2QLhO3MufKLgG6CoGAaaItf7RrUZY/OwgzJql2OJ
 +8In1ni8h2569GpaFm8ExM7hTTAD7LwdmaY3tuqS1FBwDVoNCqYaIV4ToAhu8CtJe3sgsiK9k5f
 WeZNB+dL/HaPGDbV6ffdRxw/T+wREkCvvkriOuf/E1aYE4D6zPuQz0dfl1irVNDvYoRdRFbHMkv
 hs9eCb5Jq2GVEDRnbLGliA7Z+EiTbuzcHqs2LuX1ufItpaKoPN661pQJAujJqebQ/pOHEPGCZKK
 7giUy/Pvd+4RmhXCyzHK8eDcTpA+mYMyNzemxOb0zs0oBfNLGHnqkAHHyG1YQnUljHHY1RDljl/
 G
X-Google-Smtp-Source: AGHT+IF4KLBvG51oRyhpoGiT/aJXJvmo/6AM1yYg/UnjgGboc20dBr1X/5oQmVgLG08oR4P1m/bI5w==
X-Received: by 2002:a05:6808:198c:b0:3fe:f4c6:a064 with SMTP id
 5614622812f47-4008503d43cmr1977047b6e.15.1744399011347; 
 Fri, 11 Apr 2025 12:16:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400762cc752sm1043970b6e.20.2025.04.11.12.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 12:16:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250401225851.1125678-1-trini@konsulko.com>
References: <20250401225851.1125678-1-trini@konsulko.com>
Subject: Re: [PATCH v3 0/0] Switch to using $(PHASE_) in Makefiles
Message-Id: <174439901055.3262324.1707913725795075509.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 13:16:50 -0600
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

On Tue, 01 Apr 2025 16:55:22 -0600, Tom Rini wrote:

> Hey all,
> 
> This series switches to always using $(PHASE_) in Makefiles when
> building rather than $(PHASE_) or $(XPL_). It also starts on documenting
> this part of the build, but as a follow-up we need to rename
> doc/develop/spl.rst and expand on explaining things a bit.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] Kbuild: Always use $(PHASE_)
      commit: 302b41d5397e9f821d360a74335e8821d4513970
[2/3] doc/develop/codingstyle.rst: Add a section on conditional compilation
      commit: 0471f8d0012ff9794014d222151acb65ce387550
[3/3] doc/develop/codingstyle.rst: Expand to include CONFIG_IS_ENABLED and PHASE_
      commit: fa72470a4ec5522fe92986bb53b22167d35d0913
-- 
Tom


