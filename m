Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FD8CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DFC58317B;
	Tue, 19 Aug 2025 21:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g4Hgqsia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025DF80FA1; Tue, 19 Aug 2025 21:43:19 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02E982F30
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-30ccea94438so3738166fac.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755632595; x=1756237395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CE64j1R+TZ2Z9JcrFUUVVF2rjQJSaoHbJ4b/yRaRyUA=;
 b=g4Hgqsia6Grgn+aFFBDMTrNuaxPyHjfNvbNk5RWTv68ymR4mwtwmpQ+gsXJTa2Q8gQ
 772DJj3DgXxSkTzBIRe6YzU6mlfkeY3k/HHhoynesVlni+mBfaTIWO0LkqpuWNyE0G1D
 vYxoiSJCazZldhtirHmgQEir/jfqdMZ0mn+oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632595; x=1756237395;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CE64j1R+TZ2Z9JcrFUUVVF2rjQJSaoHbJ4b/yRaRyUA=;
 b=BOB3d9cIz/dkMdy+T3RKoAAb58cd7JAQUVlYzu/vs1NcziHMPOEOIt4daPM/5hyqmt
 zRR7h/t4pcl4UV1mnbvPP6CZ9Rx7eX+K4A34eJ/Ra+35eSefMJhPOZwrOPtAl0oNxIlH
 wQROjwXvI2lZTEKRQFGYFvpKz8lW2+YSDSm9gaC/EHCchY2ZameqBOs6jzTRcH4PNIIG
 f6YupMzPHwpkZ7A/xegzZ5TLh+kqatmL6IF9ft8kfvfztdR3erBb7nF5rHV1Y3x6JokG
 2DI6cyoWVXPa038i+yC/OQmt9nTZGzdD+hajEKgcZF0FgxuWn9w1agRz7oMfO60MD516
 cP7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9RoUL8K2FpVw1ZaMkQKJ2VEYVOIj4NwblAqsJJpwtK7K+MXiyW1OajUFO827QKrdkciFTKF4=@lists.denx.de
X-Gm-Message-State: AOJu0YyEj0JnW7y6SnPS6ol0HD+a8e5nR7NtCUn91y0dZ1grNjNfF5Wb
 WHAHapHK5qP3r1wrtutPN3casP+/S4nb9oYNIRtygBEkqMr4i1O/Li3e97lONeSdHzw=
X-Gm-Gg: ASbGncsDgftPqyP6qHp3VnV0wdYr308URUikggdtm1BQLa1vVHOMbh9yKhyyEKjAf6b
 sBAM2/gSQ2KzIqB3pJyDxAlU8Dwt6m8dsCwW4LLYweYS2UEZsRPNWtJWS5N/qAA0y25MCGfmF3s
 uCxM2ugiXov7GOAvuIqvCifdDceEUp5qAwaXH4nn1yu0Zux8FZ+qorvdvwb60kTlpeWdayZ47We
 H0YT0zrNwU03s5lsT+d0qujiFeLeEzqpNCJu1emDA3O6hfX9CzHWHSS2GRu7UpI1uxJpLbr0mpV
 V0ZPma1y+15fTvm0GFZUtzQOYrJdXiMdu4p11DIoD1R6s+K6lFHU2Oh7FMWiysFrTJushFTpoK9
 3+g1sK5ILrloo/Uub00lpHZ6RVbqvns9kuvXVn+eDH9eu7R6+XxVSkxI=
X-Google-Smtp-Source: AGHT+IHCzctTbuOIk93w/I/4vWr6g4gZ64bOVAxdgBvyYwhZz/PcNJVjB0JaYMz6YAUPiULS+quYEg==
X-Received: by 2002:a05:6870:649f:b0:30c:99ff:730a with SMTP id
 586e51a60fabf-311229856bemr148679fac.23.1755632595596; 
 Tue, 19 Aug 2025 12:43:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204e5easm2525109a34.38.2025.08.19.12.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:43:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: bb@ti.com, w.egorov@phytec.de, s-k6@ti.com, 
 marek.vasut+renesas@mailbox.org, sabiya.d@ti.com, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250812124324.124306-1-n-francis@ti.com>
References: <20250812124324.124306-1-n-francis@ti.com>
Subject: Re: [PATCH v3 0/9] ram: k3-ddrss: Support partial inline ECC
Message-Id: <175563259451.3359676.2722856312905766361.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 13:43:14 -0600
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

On Tue, 12 Aug 2025 18:13:15 +0530, Neha Malcom Francis wrote:

> Currently, the inline ECC implementation enables inline ECC across the
> entire DDR space. However this is not always required and a more common
> ask is to have only a portion of the DDR protected as enabling ECC
> impacts read/write performance metrics.
> 
> This series aims to modify the logic to firstly support partial inline
> ECC in its' most basic form which works for single controllers. Then it
> introduces an algorithm to support multi DDR controllers where
> interleaving plays a role. Since interleaving is handled by the MSMC, it
> only makes sense to have the MSMC decide the inline ECC ranges for each
> DDR.
> 
> [...]

Applied to u-boot/next, thanks!

[1/9] ram: k3-ddrss: Use DDR address instead of system address for ecc_regions
      commit: 520d9c2521f4082209ce5121be1b3c1eae98994c
[2/9] ram: k3-ddrss: s/K3_DDRSS_MAX_ECC_REGIONS/K3_DDRSS_MAX_ECC_REG
      commit: e511c651f6dd0ec89a4b7dec25140540740cf13e
[3/9] ram: k3-ddrss: Add comment about ecc_reserved_space
      commit: 1c70e33b0aca6d5d84145636400e496feb19c8b9
[4/9] ram: k3-ddrss: Add support for a partial inline ECC region
      commit: f43f710122541f870ba164e8121445003032c71c
[5/9] ram: k3-ddrss: Add CONFIG_K3_MULTI_DDR
      commit: 3a0793fe9be3f0e6026d31dec8545a6b0e102ccd
[6/9] ram: k3-ddrss: Add support for number of controllers under MSMC
      commit: 2310aac8ae0180ad78da1d44657f846610296e4d
[7/9] ram: k3-ddrss: Add support for MSMC calculation of DDR inline ECC regions
      commit: c32ac5b3b934942fdcd97ee631ca2362032e0e53
[8/9] ram: k3-ddrss: Add support for partial inline ECC in multi-DDR systems
      commit: d1efbc8d65702f9eb7d032e904e092a2fd3075b3
[9/9] ram: k3-ddrss: Support multiple ECC regions for a single controller
      commit: 0824703fb2b49ed64edee6f8db483bedfa0189dd
-- 
Tom


