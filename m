Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA82E9A767
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 11:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72EB180077;
	Tue, 24 Mar 2026 11:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hrRq1VLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D755838FA; Tue, 24 Mar 2026 11:59:41 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA368366F
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso4048494f8f.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774349977; x=1774954777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZZfVLFqhh02LFaRnvls9012KzUrJg9ZyKOHDrQtdn4=;
 b=hrRq1VLsfTe1/Tpuy1O/LTa9732tnCGmyqi++s1lrZs0/Fk2DKaJE9YdqHFH4fEll+
 uDSWoVwgLr/0sILcZmwDxCG/BJ/h5N4jZl9ROM3Z5+qLZW4g/P2WoIUh8SmKQF+58X27
 ozLsZ0aiO3aOR3Gdi6IznIzBeiKIMsAzlqeNcYjlD4yZfCmpw/TGAN/4KbkczPswPcOi
 4sMJ6VvECXpdLuSePapTVt3XBOtxvWUIY5vIkE+tINPgwb5xK49YjCD5cDevDPCZpvmG
 /Us37V7eeRAdGP3K1EI7DTqmL30eMU3hrd/LICHUEGXU8CFn9i2XczEnQRy/lgpAlOP5
 hCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774349977; x=1774954777;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AZZfVLFqhh02LFaRnvls9012KzUrJg9ZyKOHDrQtdn4=;
 b=EtOZyJT9iLtgJT6JjoaG2GldovytNCH7xkNaSDYVtfQazyTy3zqNayJfKb9me8ym0J
 fAeGRB7rNEXUe3dnwS04W9/ArciVqxVu4Xz6QviRJQ9vkoyxsjYFLnlpXnN26lchEQtO
 j7ZwE3NEfP9JwIC5DP35Ccu+HqORSzeX8PN9O+9199Bnfw2+D/bZDqYVnKlgbsbMe//c
 hTJCwIfhnESFsZzJnZiLkhq1XHVqCZ17DqJqZOvRqbrez6AesRELUSTbx7/4JyhLyLjB
 q+NpKLdr4TOF1poeGx0vkiFthzyIUE4i6wN7FvPygVvbUWBu8i1ygqwk+O/V9kUm0J2b
 x+4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs4meAAosdlCmMKfyU0C3K97hRiN4xB/CVTK+9WE+Duf5C3pp846SFlWRY7CVlh+zCx1us1q8=@lists.denx.de
X-Gm-Message-State: AOJu0YxS/3c6YN/f6I8h3L6+XiM0fEQKyBqC5XNrriBT9AV480C9ZN4G
 j1Lit175OD6uzePAHM5pyfYCmgOw/hw5yqRpDlC7Sx7lOmLv+B6hW3EQY45JYsJHvJ0=
X-Gm-Gg: ATEYQzx7l/g9MPoDWbQnBe+nINo099PitqqIdRbOEhTUHxrXlQWtPLOpNNC8x0iAexo
 su3mpKwwx5TQW+7Qfa0RyooPtcp+g+8jrZpWRZlHiNuUzip/mzs65nLpaZ/SIYzWhxL9vLmgfYt
 kEzMUpjtYJXzIzEQH06LOL0sZnfqH6ensRrEuneLTuoRuPV/nL9G00NlKXGD/CUqrDeCJAEuOAD
 2LkI9tCnOqriJE1q7Pt45MiUV/97RbFQccAlMBcpy0OCFaASzZdKncwUty/dD7kC1oqogEWu6MT
 rjpWo0ilXUvov4tcfmrEqR6lDccu6yjVZ/vbx4tMe1119MdM7eNEQ5Sl3U6J/jSvPYIaZJBVyfc
 Et1a7LRmzCQNYW5Wu8Uu8q2l8AeReuem2OHYMj10eM63L8lDuYSTt5dEhvNS93JeVKFUxjiEQat
 U3bQFoMgUD2aGoS7p5EvUYUyJzhacVsME3SKjZP59dNZeY3BnyOFQVKUfVkYzMHlmMHA==
X-Received: by 2002:a5d:5f87:0:b0:439:ac6b:dd56 with SMTP id
 ffacd0b85a97d-43b6427d710mr24360332f8f.53.1774349976703; 
 Tue, 24 Mar 2026 03:59:36 -0700 (PDT)
Received: from lion.localdomain (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470b243sm37810416f8f.26.2026.03.24.03.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 03:59:36 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
References: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
Subject: Re: [PATCH 0/2] qcom: gracefully handle some errors better
Message-Id: <177434997567.3720457.11847423430588003350.b4-ty@linaro.org>
Date: Tue, 24 Mar 2026 11:59:35 +0100
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


On Fri, 20 Mar 2026 16:45:39 +0100, Casey Connolly wrote:
> Adjust the serial driver to not bail out if we can't find the clock,
> this could happen pre-relocation if the clock driver isn't bound or if
> there is no clock driver yet. In most cases this isn't an issue since
> the clocks are left enabled by the previous bootloader stage.
> 
> Additionally adjust the rpmh driver to gracefully bail out for
> non-active write requests, sleep/wake votes are meaningless in U-Boot
> since we will always be in the active state. It's possible that the
> caller may send an active rpmh write after the sleep request but might
> not if we return an error, so let's play it safe.
> 
> [...]

Applied, thanks!

[1/2] serial: msm-geni: allow invalid clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7f09aff39924
[2/2] qcom: rpmh: don't error for SLEEP requests
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/4577a672ecea

Best regards,
-- 
// Casey (she/they)


