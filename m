Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38225C982E6
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3E083AAE;
	Fri, 16 Jan 2026 19:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XT7P/Yhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612B383AA0; Fri, 16 Jan 2026 19:03:25 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7E182BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b874c00a3fcso376988366b.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586602; x=1769191402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLkVp1OgdEwT/stcSYVarsQQ3uhmSpG1QJtzzotJPzA=;
 b=XT7P/Yhl+tnhS2JYIyS3MenxadMh/gXFGNXOUgisb61mDrffm+dTMyjQotrHX8LO3D
 6bzZhe+bWCoK3fCqq7YT/GTz7+P5p1lOpTcfOMZGz+jJfxGRUmtpkxor4GYvahlCpIHA
 SRjOvfxKmKQy8tZyMF4KRY9G9hZHRk2/dJXKxreiUi55yN7gikSQtTwS3zF1mE3v/KtN
 rvMXmAryWrsqDMnP0vR0qeOWph6/bVjnygt9h4P5YP+IiLpN1/C9NH6cvjLY0fOBYSJq
 yKB41ZafRvyD+1b/f5n4efp8oxK301PTPcUPAyQNOloPxWcQZ6IgGx8sLs7uOoJ8hvhY
 11Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586602; x=1769191402;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pLkVp1OgdEwT/stcSYVarsQQ3uhmSpG1QJtzzotJPzA=;
 b=m/xhgofGlXl6Txa+O5aAv0PUXsL+om4YJ6vNKqwOoI2AYW5HTYqkQKXnYyt6aCR02+
 K5Qzg6lvzBFJEW+Z5PNqVzjl1UFQWGKM8BUTP0Wqon/kwKB54t4zNQ/QaVfzSnKp+6FL
 aYqZqcS8m2odPxcTCrct7ordcIYbsq6KqhPgCxyi+DswaApCrjnQudhvBSqihJuAILzs
 yb27jYQae6PRfONYs0Lz0EIKBRKJwk1HOOMtuyWdnmu76Z5kxukNT4eA7CI/t0Gi2LdE
 GEtyTa+ApqHbET7WaKBch99GZkmDe8Q6bNUDsK0aYSdJ26Hnx7Uj7nE4R1kP28gMa0Bb
 Tdyg==
X-Gm-Message-State: AOJu0Yym6vIs06MtGalqcLANgJBQp0+gfrDeQ7aEZ+06QZvyhe56V9Ga
 XVD3ywzoROUYgPo9Z3ZjrndMHUadVZckKU3aKl3MFNnJW8vSEif7ONroxnSH7PUsjz9EttdNjWP
 9c0Lc6J0=
X-Gm-Gg: AY/fxX7qzCG2aTInkb82+7z/gHu6g82Gcp5EfDiAC2i7KBo9VpDnspTJ0PV8Q7PMCVz
 q5bFRpveU9PMdiZchSx+/eqy0kOc6+yQIzI1pwQNfg5brx//EFEzkb3uFghag4QVT46LCTkt4eN
 Vn43iHG5xISCnhn8pGlvGDIHRq1i+TPLTkbfqj98WOeCsAjpDGlS7kohL+DGb+Y0KrKVuwmK6wE
 +qpQFx9skak+6+t1EBeQKKVAIYMdNhkX6U7oNfD2a3BWt8ketZhPvmcBw+xDWPuGBwUsI3jUt6/
 BBtTS0FeUgXWS031307DQn4tRnkC3s/7DHkFse64weoGx3cVjqi2VUSosblR1JTedGeG/sBHstY
 34F1f9ZLNuQMv6BeMpS4V0J5MVjNIw9tUX84jXiXkSDo7tNygQbdmT2LgY8fQsTCAMFP2ak4YdN
 kUeggDHhXlPhb+Tw33fsgi2B0FNGmf2Qjznatp25wEFnVs/UAKdAdR8+IRy+0zKCIi
X-Received: by 2002:a17:907:d0a:b0:b87:2604:972e with SMTP id
 a640c23a62f3a-b87932554c7mr370906366b.59.1768586602289; 
 Fri, 16 Jan 2026 10:03:22 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:21 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, nathbappai@gmail.com
Cc: u-boot-qcom@groups.io, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 bhupesh.linux@gmail.com
In-Reply-To: <20251207184919.12202-1-nathbappai@gmail.com>
References: <20251207184919.12202-1-nathbappai@gmail.com>
Subject: Re: [PATCH] phy: Add MSM8996 support to Qualcomm QUSB2 phy
Message-Id: <176858660092.3399278.16296336146222459276.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Sun, 07 Dec 2025 18:49:19 +0000, nathbappai@gmail.com wrote:
> This change is imported from Linux driver and tested with SM6125 SoC.
> Note, the msm8996_phy_cfg struct is same as sdm660_phy_cfg but
> qusb2_phy_cfg::se_clk_scheme_default differs only.
> 
> 

Applied, thanks!

[1/1] phy: Add MSM8996 support to Qualcomm QUSB2 phy
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/4ad3992cc357

Best regards,
-- 
// Casey (she/they)


