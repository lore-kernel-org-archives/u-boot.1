Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2113CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED75F84874;
	Wed, 20 May 2026 15:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gUcbNyqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2292384832; Wed, 20 May 2026 15:38:39 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADAE5847F6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso4582151f8f.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779284316; x=1779889116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aWiWOcQvgLW/tqZdahgLHopj8VqGRmEW8QuWt02VS0=;
 b=gUcbNyqfsciv0uznv6MltexJ6axrY+KBFZIQI91RqsxYtn0f3CJDeZmcj55RneBZHO
 rhJkhGA/cexlU5UA+2THm4mlf4L+GlKaLlLWP3gu+4n88OiAiLYsrEAEFijMKpEqcn6+
 wv30HJ1MnBqCdu9JY0RO1kKETTR0z/gYrX+dgWp3wr4JDBbJNzLv96IvjwkFQldT8j+5
 pXYI0tLxkGYPSHJaMv+QBsyyxjzxT8ovsvATA0SZjfUHDgvDVzKiRkUFUS9GpiG9YHnW
 66oKtLPlaqy8heaFc2Vqohf1w2I/LiZpnso5Y5kTCm0o76LL8x1loYVJFZC8wQsGjIzi
 Uhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284316; x=1779889116;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/aWiWOcQvgLW/tqZdahgLHopj8VqGRmEW8QuWt02VS0=;
 b=Z+kpzKamC4toEeMVOnN15Qg4S8HBF47V709SSWnUn5aWAucPQbuS383msv8L7JmeY1
 3mToxpmFacdu0KhMchq+wSYt0VrxQp+AOjGafkuz5VdfPh+QDQ24ANMjNtob9dCcSwxM
 MYa73vgX/pY3RnxHi3sWsA/Yytgsq0jRpsUk2smaQz4le+6o7zPTkb8AT8VKlPjeoa6g
 f+sV+GHpOERvyw2R620h9SQr0y1VX5BeLy3aoQZJ7raWkRVNGqFNd0FQ+La/0TKzk0GG
 9qginpOz0mK/mE9OgVh937ypXDYyLOv9GyJ3KfvLj50h9OG0SwlyaRcNDVBCfd2BTTRJ
 aELg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ALotWGLJ3oP8wl4A+GKCdnn42FYbCUAWEGrv17zT68GM3DGI9swdNMeTGsL+tuuEsB7bzjIk=@lists.denx.de
X-Gm-Message-State: AOJu0YzxG+N1G4X2LS+MCHY8sn0kiCNHLuCX+FTYau1sGoRUi1cyg18K
 K3gnroIR/zqw58ecrjBKVGYiBjTv1gXOKlOX7Qv4rGc+p/gCv5B20bnzTPCD0Z8pcQ0=
X-Gm-Gg: Acq92OF64OSQB9eoBzed/pq8DJST1DXKSBFuIUv1ww0+r4EDIPwOQmHy0mO48M16V8j
 4o/qkkcXSXoPgohDXRbYh4NEoJsG8yFxajznIc3mrCjmMRIZ7ioZVqb27GA1d+nyRjagsa4orxq
 IV9cAnzcy4M9HrtmwqHf53ZUQ0oNGGCjGGcd+iz0iDyjn8qSjwyGpH3KTouUsW6qO/rEw2NffEy
 u2repIrEvURJNgT2aSq89/xHa5hqx3+akA6Va+gCV3wmbZsHGzRexYpwq82JeG5nN7kfGa8EkuQ
 eFALGOdCwPn7aQZvVvfCy1DahHILLfQYkFQ2JtBVIev0xWhc/06FaYyUSbNXsZfJofaASsOwD1I
 5dQiMOCkIf3VGBcKzp1tuExEcqvCwDTfTb6ge0IWcYVlfA99C9hEOXkp/K482vPn2eHAMT0d5ke
 PLcd6fRXmhQjwvf/o0prMueDCP2Z1iA03p7LL0/RIPEUoWMExvlmfq45QbvaqgVLU5G2BfhLr84
 oAexcA=
X-Received: by 2002:a05:6000:2f8a:b0:43e:a73e:cc98 with SMTP id
 ffacd0b85a97d-45e5c58d529mr38849926f8f.23.1779284316063; 
 Wed, 20 May 2026 06:38:36 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767d0bsm52466459f8f.3.2026.05.20.06.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:38:35 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
References: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
Subject: Re: [PATCH v2 0/3] Add SM6125 UFS support, Fix QCM2290 clock, Add
 poweroff command
Message-Id: <177928431484.632715.18132246020933472015.b4-ty@b4>
Date: Wed, 20 May 2026 15:38:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Fri, 15 May 2026 18:10:01 +0000, Biswapriyo Nath wrote:
> Changes:
> - Add poweroff command in qcom-phone config
> - Fix vote_bit of gpll6 clock in qcm2290
> - Add SM6115 and SM6125 to QMP UFS PHY driver

Applied, thanks!

[1/3] phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d54d2ec651e2
[2/3] clk/qcom: qcm2290: Fix vote_bit of gpll6 clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bf6de8136737
[3/3] board/qualcomm: qcom-phone: Add poweroff command
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/0d131b3b0602

Best regards,
-- 
// Casey (she/they)


