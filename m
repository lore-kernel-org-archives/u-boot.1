Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857F4CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06ECB848B4;
	Tue, 19 May 2026 17:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JnQFqw5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F244848B6; Tue, 19 May 2026 17:51:11 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35DE384870
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490229aa522so5578595e9.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779205868; x=1779810668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xijefixtYEwcn+CWHMzl6tPXz3ATzDULGBHIK8/XlNw=;
 b=JnQFqw5O2cDBWegmnOOwYfk/fXpptGl3eHc0sBuWE1BLYMaoi13XmiHRH56GCcYI25
 CIydEGJgWgU2oPaOFZO9LkCpi+A1VQsNzli2Rn227o0Cbiwt1ypbEKCCNQMc5HjAxhul
 W1zpEIgfObzzi+XVihS6yGfJrIQHEDJNfCOGjChviqhcBdRfLDuIApFpPesuG1qW+M+r
 gda4IE2nqLu1C2Hjhn3ETBfoN/K/dTLpXr9kXUR7qskyixLaO6OUvI5ZkTU0Ak9U2sdS
 yExESzeCgXY1TW0GVFiHiq6/WVSpQleFrZ4CU+D3UmKuzlFaxwPAeaOtXSZW61gSq1af
 q+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779205868; x=1779810668;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xijefixtYEwcn+CWHMzl6tPXz3ATzDULGBHIK8/XlNw=;
 b=hx4fXfFGWsUR0WmpjI4xvVHCJktSJFlq1/0xkOvxaGFJWytQyO1YumkumGnNuDbK4s
 Y4RrqHHx3YdUw/l2dsjmn2URmaImpaq6WivtWXgr44lH93QDNSyPbn3cHYm50XN/Wums
 fr35NcOLLoVUwZ3mD+XlUuH1Dedp/oVwepzwyN2w4dIAtAWhi4dPKb7zkwVifp1hRVXu
 Si71gr4nnyM836izkh0QSCH72Z9RLJ41Kp06K2cKC/vJm7fk5ubGTAURPN6KxGo38QER
 8Xm9x9GUgDOdMwq48E3f6gcC5YlRcYb8MkllnbkutjZi/uro8Tz9upTdNSoBh2cvBqvQ
 QuTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NfpjwwTIUuntG8NEFQwi4mAyDZHWcoQbGbIvEs29gnzpMqCnsBrCYxamjVJYEKRzf2OzC+8w=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3xvV3IRPM9Gf0wLkSkgItbaj8fcmOXfLGT/JHCsD1OM6X3d+E
 PIFG+cPkoXcTF6LVHIjZI+vO0KUxS++5HwHFDztAbKGZWsaO4myKZiDdu2vJCzYbIzY=
X-Gm-Gg: Acq92OGmktS7WOHH/kjWi5CZM5FlAWg+0W6VclQ5mIVn2001im3Kq5/vUq2muTnZUXt
 8DlUeWj0qqy9WYR4VRSrGFVSi8SjpTLqQPmmj0a+ZJYYuOG0itU3OXmYwkCliyHeJ+Io9pMODW4
 GHj/m5ZbjQQ6W3FkN/4KOKa+Xpsf8Y6z2EsvuSk170UOKcT1y9LAZ4r75Ttb/eQxyInOnnFdGiO
 ePwT/nowi6VWww6vm7heo8ajGECSFcWXlbJjVdLyKvScu4Aak5JnnIUwnq2SstwxR08fc4vcgFd
 uSWSGCB111rSQGsHbFddg0XIc8VhTSv5zdu3NpU/M6RHCP5ggMl2uA1nPMBEygwCLakjixkDqEN
 BRhvf9Kc4BlWxGu4diRkR/JMSc5dwb8ntlddJnufFqqiENSUzo10KIX2rqu+aRfbugy0z23EiMU
 UE7k7OGAETsZ9JU9m3VZcEC5XlPAJloMRHKPWmeGZPkkcy
X-Received: by 2002:a05:600c:1d0d:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48fe5fcdf50mr298254945e9.1.1779205868558; 
 Tue, 19 May 2026 08:51:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694f2csm336348285e9.4.2026.05.19.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:51:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
References: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
Subject: Re: [PATCH] ufs: Kconfig: use bool instead of tristate
Message-Id: <177920586799.676779.1465505418575074681.b4-ty@b4>
Date: Tue, 19 May 2026 17:51:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Wed, 13 May 2026 09:09:23 -0500, David Lechner wrote:
> Change the lone use of tristate in the UFS Kconfig to bool. U-Boot does
> not support modules, so tristate does not make sense here.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[1/1] ufs: Kconfig: use bool instead of tristate
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/3067fe5bd423d62bd3627f45fdcef96252bd20f1

-- 
Neil

