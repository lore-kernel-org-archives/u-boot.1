Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC58CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 407D084843;
	Wed, 20 May 2026 15:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hSfIcjll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA08A84855; Wed, 20 May 2026 15:09:49 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A13847FD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3285944f8f.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282587; x=1779887387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hESSzO5BESd8ANZk6s2e12y3SbaXAoF02IYmBsut/aU=;
 b=hSfIcjllCOIGHIVZAmAaVAAymNgwLTriWU2zazDKcgY7rUz6Z6brDyiecZpr/hj6GI
 ln32+ZtdopKLZ2D/5D75iqBqYBSg6pY66/s6EaTH2yfEpJmu5/i4sscuItAogNsNC680
 YzWp7s4EucwFVS7iD6+fQsQ9JQQDSxoGW7/0fDUiaSMZBY42ePGHIsAP4QSuYrYFjKh4
 puLcgX8BqLQLVXbejEVRx+x1Gey/nTNZAGlzUX9MhAzdCuBw2pt+PEK8Ml8zqKAO1qNl
 hamd4J4fTLvlPCiWkiPTW6H9aZSaL+0xOm1Ww50zprigZwozLabKBchEp+1c0oWS+Qmi
 AhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282587; x=1779887387;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hESSzO5BESd8ANZk6s2e12y3SbaXAoF02IYmBsut/aU=;
 b=Dqy1MPfSSyTpAc7Y1RQIZJCVHwo7vTkaNPMojqZryq5GJ9WUtzDrUYjDI2O98x+g7e
 ul6pEuaabQQBTRpSTllAL/O7Ac7SVxj3neFYO8jKg9sL1m+cqfLSBXBQavr4G/fcrq8o
 qoyMHc46hVcghQ42JZu2vT4OxVuW8zePaNXwhEbr5/OyivZH/E967yrajD4U+z0hm2zu
 GoOQ/7vEX0OXrHsvkZ2CWCOURTscLuuF7Gq8GhbwBi5uw8MHymyhdZnC9yMVvX0iaijS
 O3tcpDsx1v7SxRDjKbFRLZScA56Ta4S2GnBbrPyI2RQQmkwl1PEr0ybgHAs3zKcrEwbA
 w/ZA==
X-Gm-Message-State: AOJu0Yzc8ozvxiphZzxirQ8dqtJewoMxDi2bJvIfAs8JudPVgwqij9I8
 i7UV/sSh1u6grpWyJWhfP6X+oxkQ0gsOcwGlmhC/wO5LlH7G+5ZY+sFTvLMP9NnO+cQ=
X-Gm-Gg: Acq92OHNiFfL5CTysd2dzjWSQ0peIEFox5c4vzid+OjYiNQZ7NySYRdLp0QxJODdmoE
 afdtfYDMDrqdQYG2tz0lVB/UytwoiXP8b5vZM64AkR6ohxelwOli0OY+3H7/mgwhWS6cS3ccIyV
 A9B+huu3tHpKD6KsMsXMphkYlIuhxJMM2TSz/77UwRepLXfoMtxstF5nyLNxT7NZ6rpY2M5ZuEn
 slr9ywjDKM0ASMmee2dv91FBrhBwpMAJb4gr/u7dq2lx6dBgJs7bRp8znQ/u+iuAFqekyNlTE9u
 RjCT1AQ9jmJmrB+ASH1gBJd+0hxWEkYAVyAjWSVJEl7RJrcnXkn/5G4ldsYwuXhL59qehebwK0C
 mM2OzSEQvfKp4tTmbVuTJr/lxlYK8OHA17WhkwYe8hCQY711WO1zU3wdlvbfTYap8k0QdTMJq9T
 FV+2ik90p1ELhsAphC4+HgVo9RwSHySQESZAVIlG/nj9qJ
X-Received: by 2002:a05:6000:40df:b0:45d:d092:aca4 with SMTP id
 ffacd0b85a97d-45e5c35d9fbmr38709818f8f.4.1779282586797; 
 Wed, 20 May 2026 06:09:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm53174639f8f.30.2026.05.20.06.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:09:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
References: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
Subject: Re: (subset) [PATCH 0/2] MAINTAINERS: add myself to the list of
 PCI and NVMe maintainers
Message-Id: <177928258605.3011508.3868824417994541237.b4-ty@b4>
Date: Wed, 20 May 2026 15:09:46 +0200
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

On Tue, 19 May 2026 18:08:33 +0200, Neil Armstrong wrote:
> 


Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/2] MAINTAINERS: Add myself to the list of NVMe maintainers
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/49f8b8de4e6fa0aeb6c5eabec149b2537e94618b

-- 
Neil

