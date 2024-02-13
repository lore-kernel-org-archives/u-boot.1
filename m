Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095A0C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 15:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE6F87D84;
	Tue, 13 Feb 2024 16:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i/yBgFcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D81887D8D; Tue, 13 Feb 2024 16:18:54 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947E687D1A
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 16:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-411c93e1cd8so3357735e9.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707837525; x=1708442325;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLq7X59SL55E+utCfYJJsTUeaWFGKUeSAdMICiY191w=;
 b=i/yBgFcplt0eKlPGNePEr+Tme0oy//DHK8QhYlXZX2BOAyTPUSm5CwVm7iZ9TEfJ7Z
 tllTIdEYlrtvopodhQemsVcOrFY+LbM6sBL2UOBofQeE7AoqTAOsTh8IXpQwfmB/9J1j
 9dusXkXvP3nCstnqWOSC7eqpfzmsnfBJXsFb+1sSq4qAORakmL1OoIdGThcfyAiedxQP
 IXZPtJewWhiB5b+ZBzS7T9ZtUkQdhoj3slsmSwXfHEtGLVfxBHn+IMjQtIrcK5LlQ4Bh
 rGX8C1XVYF1worpyM6Yef3QqiT8SHeWI06lZl7jGSCIoM2vFFO3rXx+5Ygkt3zR5Wv0D
 p7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707837525; x=1708442325;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLq7X59SL55E+utCfYJJsTUeaWFGKUeSAdMICiY191w=;
 b=YpnG2SHJqXZFkIfeN0XEZ2DjyCFuEL6IvvVrp79vdmnU5u145uqwbotUp2UYQI2Cj9
 mVsDB8+ZWCebJzWN/fo+iGo6/N098ut+BULgd1i0qos4tesZ6EtNb2yt4uloLdzB2fcH
 hYlT6J2C4Cxv+qCzCobk9zE7QxCnB68LMFU822spcv+KR0qRpf5rnziEaqrkE6XQs1MB
 hBQ5DVHbBPZ1H+tDiS6HBGXaDUM2J293fv5wrtje3SMZyY9nU6/wilMmf6BxCbvsumvU
 wjW1uibTRSoYjROaVkkCIEb5tK+m+olhaqgMJTsYaiIiU7Xwl0G4Bp/d4WJ3Pv5ep9Fv
 Ie/Q==
X-Gm-Message-State: AOJu0YzqPZrcvHWoIQSFjLAGfCQ4NbsmV931c8lL6pjjpenYg7+0hf7M
 KzJfg904CEmL4eJc5Wiiu+XiIjb+sMu9dEqOH3D42aM8VAmC3okqdMMK2ZT2IaE=
X-Google-Smtp-Source: AGHT+IFgFzPC3SS0ntFv6ANqlUek959iw5aUArI7Dh5rsNu5sBfQDQym/P/nE7GOlo5KWFUEoeQZdw==
X-Received: by 2002:a05:600c:5108:b0:411:c8a7:7b6e with SMTP id
 o8-20020a05600c510800b00411c8a77b6emr1414225wms.10.1707837525036; 
 Tue, 13 Feb 2024 07:18:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ISle86exsvgsYOmo/5XVIKrwX1O3ILvuk56gPQEssH42u4I0qpBi+17M4yxFpCH/40EWdg2t7v62O+aOrqOuyZkgM88DdVjWIlNvhAnd0+L+lAUebIdvhemEVIys7GvF0eCxZ4If1POcS42e9ykJ2XuVpQZJGr9kddkACZlM+ni/w7z3P6qYNPorotCXpBrNA15LwrWkCpZWRM77GFfyV4uOn44A/yPhVj2PBTuScTsbGFhv3OyDQlPXT/ZR4CClNWtGsGbBxkx6W+zd0fdVnw9m5gFS3rGXFtSWrAM+L/hqr8mqU8Eu3kFjFcY=
Received: from [192.168.2.40] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c11cd00b00410dd253008sm5753923wmi.42.2024.02.13.07.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:18:44 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
Subject: Re: [PATCH v2 0/7] AVB: cosmetic adjustments/improvements
Message-Id: <170783752432.651311.6466036162960002340.b4-ty@baylibre.com>
Date: Tue, 13 Feb 2024 16:18:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

On Fri, 09 Feb 2024 20:20:38 +0100, Igor Opaniuk wrote:
> This is the first patch series for incoming major
> improvements for AVB implementation, that include:
> - Simplify and add more context for debug/error prints where it's needed.
> - Move SPDX license identifiers to the first line, so it conforms
>   to license placement rule.
> - Use mmc_switch_part() only for eMMC.
> - Rework do_avb_verify_part, take into account device lock state for setting correct
>   androidboot.verifiedbootstate.
> - Adjust AVB documentation, sync usage info with the one cmd/avb.c.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/7] common: avb_verify: don't call mmc_switch_part for SD
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbde93c12616bd6ba22e6bcb76363a6a3f253087
[2/7] avb: move SPDX license identifiers to the first line
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/bf7d47b4274568927adadeff8c9d1aaf2bd45ca6
[3/7] common: avb_verify: rework error/debug prints
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/bdcc8f8c8fd3dfb053cea7a0f62b34ef062411e0
[4/7] cmd: avb: rework prints
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/055462005fcc48a12a86edf2cbd3f7aa8712788b
[5/7] common: avb_verify: add str_avb_io_error/str_avb_slot_error
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/63736ddd4fc357768e31a6f10c10b1a28a10ccbc
[6/7] cmd: avb: rework do_avb_verify_part
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/07caf5febcfcfb5f2cdaade124ed8d11735a6029
[7/7] doc: android: avb: sync usage details
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/85af871dcca7e9cae074e3a635706052a57629a4

--
Mattijs
