Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35032CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C265845E3;
	Mon, 11 May 2026 22:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NxpSe1Yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD0EE84656; Mon, 11 May 2026 22:43:43 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6706784198
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so5208643a34.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778532220; x=1779137020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuoDPlnR/hBiE6LsCgMM0CnHUw9scou7ZjrrRWVLbdk=;
 b=NxpSe1YhQaN/zQVfuqz4AUNJHg0ZWgCdGhjiZpQzTQCZj77wSrXZjbjXvzHQWgeH/l
 3DIuwbMeKsGK5YrMagTgkE6qH8+fmmWBYb/I5tMx9WJxXyMlJKWnQOA6glI2u3+2g5Yk
 jU20szmD3F21Dl+3GaJPQNRUGLbvOK+nqQ6jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778532220; x=1779137020;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RuoDPlnR/hBiE6LsCgMM0CnHUw9scou7ZjrrRWVLbdk=;
 b=VujE+ytD+GiOVc5ebg4+F4HYUT6YRMWK/AKAYm9buol4qoGxootqeiqpSeC7pYiw0w
 CMf3YNzGL/u8/OdqO4920zGNsfgPsJFcb+iAjLGPLZW7TORtinTVZi+paZOWwOPg6mzd
 fsfwr60S28ig/8wbTyeNevDcQ2WYxrp/J4iHG99XT1ZVf7cAOg/9YFjrmuyjB4ZdyV8A
 3s3mLhPDY0KSgYjeMkyByyjiclMMpsE2bffhAiS272j8UvnuZKmoEew8F575bQ/kAFAA
 +hA4mGU1x6nxIg1k+BH5bnd5wfMBndPCYcFLRmc06nSkz4G6YMdwEAn00+/tZsDJgASK
 NMJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Xq+XPf+uaK0cf/DiUfNWohCw3vFsisWhqJRyxD2sMo1PEZGfcVXr7lfnDPRB4iiiQ36Thf/0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7leEq/hYI7qSIWdrNkvauisdkEcudbv1y9oIL6flbOtUVUi9O
 eVhob80bXVCCvtgYa0bl0oJ5JyHqTo5PxGvXOn5y3rx2gEvijDDG/FOotdZl3E/qGivu1phHcQn
 t2r6Q0YusvoD5D/c=
X-Gm-Gg: Acq92OEnBhkoYJX+IKPgpnYdsR/JHfPZEX5jmo+YqBi0hEnukKpiw8qvaHd2UnVnFBH
 IcGKaHD8hehn7mwUuHNjBMZc/uK42W1Fr3kKQQ6n4GbmVEXW+g48rBiIhhtadfcVh6MlLdwX4TH
 CgLK6dbs6IAtljNl315aBsNxfW0h8ej1rPJ5iDEy0E0XviWveHB8jLXYACEMBb7a0H4mKVXTPwP
 GJ1eTATSIpOrKpGSR+S4n2SpznTtpILg2UDY1ZlDNNaP57GszTITboTrw2jq4U0H/H1JTrlcOyN
 5iJHxrKqawCSykew8BThEXp6HOHTz8XFBszsi3Re1uHi9V6OKrSb0fp9lvF8eojbhz7C+KMqNqP
 eieeSGk7c1Jsj/AKR/UIBaSdfNoJP2uvlabLMGwb/G3rYGmHPEphRyDeQqdTBJmgU7FzmQe+dkB
 onAasq0oPcqS6fLVs7u9MjyqXON17Nqzv5B7DKxpwVglkIubaGWuwSzYbH20WokGgL1ISX8fVJn
 RDRbL+aM2bLy5CHE9/51ZJwhnwW2SkmPCbWE1qwmqGTO9JYnQ==
X-Received: by 2002:a05:6830:82b5:b0:7d7:f15b:bdcf with SMTP id
 46e09a7af769-7e1df1a93a3mr15606752a34.28.1778532220185; 
 Mon, 11 May 2026 13:43:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c04e00sm7505796a34.7.2026.05.11.13.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:43:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, m-chawdhry@ti.com, Udit Kumar <u-kumar1@ti.com>
Cc: bb@ti.com, n-francis@ti.com, nm@ti.com, gehariprasath@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20260415152152.3048491-1-u-kumar1@ti.com>
References: <20260415152152.3048491-1-u-kumar1@ti.com>
Subject: Re: [PATCH v2 0/3] j721s2: j784s4: Add workaround for errata i2437
Message-Id: <177853221920.1608836.14544515588240543947.b4-ty@konsulko.com>
Date: Mon, 11 May 2026 14:43:39 -0600
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

On Wed, 15 Apr 2026 20:51:49 +0530, Udit Kumar wrote:

> Add a necessary hardware errata workaround for J721S2 and J784S4.
> 
> Bootlogs
> https://gist.github.com/uditkumarti/da2a489a78d3241ecd2791c9df1c1317
> 
> Changelog:
> Changes in v2:
> 1- Added verified macro (this is new patch)
> 2- updated macro from ERRATA2437 to ERRATA_2437
> 3- instead of using hardcoded write, used verified write macro
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] arm: mach-k3: arm: mach-k3: Add writel_verify macro for register write verification
      commit: ad681c816484c2246b4803de64553f760c0f44cd
[2/3] arch: mach-k3: j721s2_init: Add workaround for errata i2437
      commit: d99cb46a2cc4d735aea125e315d6ee257077b516
[3/3] arch: mach-k3: j784s4_init: Add workaround for errata i2437
      commit: c5c3b2787383e25b1882f7e8cf3db54eaf318b41
-- 
Tom


