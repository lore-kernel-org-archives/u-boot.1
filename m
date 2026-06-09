Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC87CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 20:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E735D848DF;
	Tue,  9 Jun 2026 22:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S2hduD4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5442684942; Tue,  9 Jun 2026 22:21:42 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ABD48486D
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 22:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-beb2063b149so89948066b.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781036500; x=1781641300; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9Yd5GSEP3oiLmi/10O3h60/gl6yr1/y1VasfRN3ZPQ=;
 b=S2hduD4Ah+MzgefG5tc0qQXEoi54/8WIdgOjjcDWa9R6T3nvh5gXAM3z9i/wbLNFgp
 IjSWSic2KLQXHnBABgZkksc6AxTpIFje1wNvaK2d/uvGFcHxwbwHvZwgooQSN+jTBulu
 viGQPlEbfdWEweYNT6MEARnVP6a1rGQcuWDfVElg/7qgYE3oDKGbOaulEu+j3VoPM893
 fekA6Dx0GBae4pEWBTBTLGE4FODCMzLgM93OMxdljNE3Jg2o2Wjrtb5yd4AJtQhjtXu/
 bmYva9x86h7I+2oBE41P3/hvVXPYDnATy4ox6HH4MydoN7B1TvxmTiWx8jLy8TSS6Ua3
 DcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781036500; x=1781641300;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L9Yd5GSEP3oiLmi/10O3h60/gl6yr1/y1VasfRN3ZPQ=;
 b=Pn8Osj4sxIXSCkaXpKx2N0bTS5sPsznNf5188FSvtnot4lQWfwIWUu47a7sBlTuzo3
 t4m+zqvJd754KR5bhTN8xhd0KpSJb/MbX+/tzIJ1VSDhjvkJd90su6QAQIxaGoQSvA8o
 h3o9Tb9NHDrCZ2OZczA9tFLDmI0xqG9FZtKgNx55SBa44N3dew7j2BMu/LAfXNebIhmL
 OEOQepR3PhnXfraG8oETu9MSHfiar+PzGoyeCC7/HLL+bOcZhRtad79zH1B97L1lJezZ
 3PmLKT2MR2OyMg2o1IczGoeSrR45Er+eWwMGI/GZtJwfJX/g4ecsh6wZ4MtcAdkmaeX0
 C+fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8puHBTJV3fBktucBeLcNwgQKi9hfy8huo1THPhHLqq4wCiVwykb4tyAuNo/D3OaGgqCGaMtOg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4nUNv3cQ0MzAgr5I1T4pkG05i6oqgC8uF9yYxh9eqTMjzOq+0
 vlb5VFaeQjQqf37f2GNRQPhIK02980Za7nN4JWmaP1JAWva83ewqSNbz
X-Gm-Gg: Acq92OGrEue8l6HQYaSHNPkbQFAg5tq4y+SzdqHMTjmvf5zeX9m0jJaPwD8o9e1TB9g
 B+KvEjG69BeAxufjPzT4CbiHlgTjijkfBsmeqCRkVe3kf1Z7t6o6qLlobkH4A8mJzNjgzQJ31hB
 mvClz/SZ0k1A2CVn7rhOCwEpm8nlAudrj/P17JojFbiKOmkK2FW/UyHen7gAplMtnwePWHkVSJj
 UIVXOIRJZ8c0WJSebPstsfg6HpUN0Cg52tpAhx54DUUdK568OlCkcm+E9ZV3a7aZm1tGLi4QRoL
 rYu7Q6k0OJqee5zI0fE7QmV4K5+f7MCUtkmi830IZ8imBkCoJoTdFHdzPUPFtJfW8GZKD5umlsj
 z44vqBQEV+1Tf9Lyy4vAtsDmPbigGgc/ZSyt84+6i4H1NVTZVyZTOMi8gmJdlLdAZj0vVKnCoZh
 K/ORRBP6F1x1g+IMYa8qPRwhWk5+LFmVtvVe64kQZA4LHZ7+NT9W+hpuMMRPvF1ikamCAUsLCX4
 jCXyZAs8C0=
X-Received: by 2002:a17:907:75e3:b0:beb:c327:8e7b with SMTP id
 a640c23a62f3a-bf93a1f9f14mr75903666b.3.1781036499674; 
 Tue, 09 Jun 2026 13:21:39 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf3e39647c4sm706377866b.63.2026.06.09.13.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 13:21:39 -0700 (PDT)
Message-ID: <d5752c9d-eca6-4ee4-a0bd-52ffc8103976@gmail.com>
Date: Tue, 9 Jun 2026 22:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/3] rockchip: pinctrl: use include from dts/upstream
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Before we can use the Rockchip pinctrl include from dts/upstream
replace some deprecated defines.

Johan Jonker (3):
  rockchip: pinctrl: replace RK_FUNC_n defines
  rockchip: pinctrl: replace RK_GPIOn defines
  rockchip: pinctrl: use include from dts/upstream

 arch/arm/dts/rk3368-sheep.dts             |   2 +-
 doc/develop/driver-model/serial-howto.rst |   4 +-
 drivers/pinctrl/rockchip/pinctrl-rk3568.c | 186 +++++++++++-----------
 drivers/pinctrl/rockchip/pinctrl-rv1126.c | 134 ++++++++--------
 include/dt-bindings/pinctrl/rockchip.h    |  60 -------
 5 files changed, 163 insertions(+), 223 deletions(-)
 delete mode 100644 include/dt-bindings/pinctrl/rockchip.h

--
2.39.5

