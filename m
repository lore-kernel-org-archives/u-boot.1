Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412D6CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A1B83E20;
	Fri,  7 Nov 2025 22:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SfJT5yjh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D5983C53; Fri,  7 Nov 2025 22:34:58 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 610AC83C53
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3c96de7fe7eso693439fac.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551295; x=1763156095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0WWYcLb1spx+kxFjbpSzP4JBsXiXhdK3BHm0tfgT9s=;
 b=SfJT5yjh4AYK03vt/JhL78YOKvD0WS6KAGrfT93Pe734KY3RZe/Y9ovu21i26c0U0a
 vXFPeWT1O+hC45c/0e0KNPVtI1Mzw6knqPCNFiXiEA8zCAPjFGovV+hwcGktAwqE8P66
 v6Fnv4BtDl9CX4aGKmZ0XLkrYK0ndWiN1pCRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551295; x=1763156095;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y0WWYcLb1spx+kxFjbpSzP4JBsXiXhdK3BHm0tfgT9s=;
 b=amyz5rf7jGXQBiFlS0O3Zy5R+Kp9Owf3Gy+lGyxWGNk58W0dJr0a6MJe/HF46W+XYz
 ytpXR+X2lBn4IgkLriJvAwPhPxRM/vGPzOdoKGxTQ03q7/MUYCaxMj4gwUgJI/OG8wHl
 kOMQ9eVYZ3HUy6nyR75b7OX/B2+5IRykeNod/kNDZ0lRYjr0H4I2Z5shU2yswjeaUxvH
 bKkDrImECongCj+eL0ZbjOOo/V7f0K+rCvTokByWUjzl4p3L6b4uQ1BCZWVE2F7Holm+
 SedBbAlgaDWVqn3VgKkmzrXJMHCxSkHu+rnWAsNjQJcJAX5L3j37oEzMOHZznG8CD7Kg
 aBiw==
X-Gm-Message-State: AOJu0Yxi202J8KbRdlSmgWp90U6nzV21Ja5zVtdzHpoPlA52jroQvldq
 2OdYNrCl+g5qVYPd3UnNsmxtZ8Ii+gqbNart+TknlBf5xH4NT5U6jYt72xpp4RspIME2Iym8Q82
 b1gPTHhKYnA==
X-Gm-Gg: ASbGnctwIUEw/Xzw0SyVPr0DwSNzdEaP0zudSo6hLHhQcKrQAkGzoEXOzAfRiqd0b8E
 txEAovoEc5b84u4+KFx0qCSh/9rpMV+82duOqptRGyV6zmJuMmc4/BC91L2vv7TudKvJjWh0O3i
 juBiz1yeB6XOC8yIk+f7kSbw06qN4VaLy6dGa31/bM7wkKPA/B8qe2UUeg/GqLyTgWpzu+4gHRn
 CiZzPXmkc3EtRIyCy14pm0bKhBpHz3R6vWAkIWYEnR+oXhhJmZPziVptWI5gdDxbTDj3UrCVuT5
 MNaMDUG5PXD3/nWxX9jJHscuwEaREF1MTja9pWgQe+m8lGToxqD1J0ecz+9P1SsRpSjd0zpqXyr
 owrlOMKEkPbIJHIh2UwvfahatTmoBQKztfDIFnTqHDlLwz4P1bPhqSOpv/JHjeK3E3KWYllVn/Y
 s6gCzHrso7Ycpp5+UnZpANByjoLXFkox1hsGzVfvc8csvQxlnM
X-Google-Smtp-Source: AGHT+IE7weoOPJXC0fipcgjSC/XIhFsRrO98FSKG4Bm/H3f89WaVysqWh92aUPLhIgSp5VgcNFrgtA==
X-Received: by 2002:a05:6870:f202:b0:3d1:ed5a:1356 with SMTP id
 586e51a60fabf-3e7c268bf60mr809715fac.15.1762551295069; 
 Fri, 07 Nov 2025 13:34:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:34:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Sukrut Bellary <sbellary@baylibre.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Cheick Traore <cheick.traore@foss.st.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251030-pwm-kconfig-v2-0-d151a42784ce@cherry.de>
References: <20251030-pwm-kconfig-v2-0-d151a42784ce@cherry.de>
Subject: Re: [PATCH v2 0/4] pwm: put symbols into a menu + use if DM_PWM
 block instead of depends on
Message-Id: <176255129421.3424353.6224125475196466706.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:34:54 -0600
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

On Thu, 30 Oct 2025 11:03:54 +0100, Quentin Schulz wrote:

> This improves readability in menuconfig by putting PWM symbols under a
> Kconfig menu.
> 
> It also groups PWM symbols that depend on DM_PWM together under an if
> DM_PWM block so that we don't need to always list the dependency in the
> depends on of the symbol.
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] pwm: move all PWM related topics inside a Kconfig menu
      commit: 3dd58620fa298915c813ac0deba3e7872c484b90
[2/4] pwm: make sandbox depend on DM_PWM
      commit: 534892522514b2e72614cd0af1d352879cf7604a
[3/4] pwm: put all PWM DM drivers under an if condition on DM_PWM
      commit: e0dae656539bd522f3c174c55c259c3d766bea91
[4/4] pwm: fix typo in PWM_MESON help text
      commit: 4287a1a246476af1b7233de56e4856c7747d7ecf
-- 
Tom


