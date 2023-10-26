Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D896C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 15:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE96E87B76;
	Thu, 26 Oct 2023 17:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yw3FuNvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0D687B76; Thu, 26 Oct 2023 17:39:40 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D27875D1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507973f3b65so1597276e87.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698334777; x=1698939577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arqpWE2KMmUYEmrqoaHtRhCK6GJjAWtzZr8k9Gd3y+I=;
 b=yw3FuNvmSrgJOYcVYp5b4vjiNNDziYMKvFRd0cdgcH9zPszzgdSAGmKzkMsYGzyroD
 Dq0fQMWXzMByj+YumWQWTgpKPrQjJlUdLdDBW9q/1Q1cSbs5d/JLGN9zuNhSwQK0+qns
 YjIrDGMLidpc5wKI4U2YcWUx6Om94pU6W5RE5Ovmy3qw+ntsG3iP/8hjMopR2J9WLL3l
 Kj9CcBT2b7AgWN5zgBafPs4xig16NQ46hVXeshIY6MVc4cVbWdrJAE1NG5tpbD+iZj7r
 8binFxbpNNeiWYTMu86sc1orq6lcTVJqlltbG0Ie4uU1Gg2VPycykmit3QHuos/yC4On
 tMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698334777; x=1698939577;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arqpWE2KMmUYEmrqoaHtRhCK6GJjAWtzZr8k9Gd3y+I=;
 b=D+yabbu7R7G4q8+qO2B9F5aYbtSKmmP+crkPrZ/dW4vwHnPUfYYYJLdCCzs2rs0j5j
 8Khmul3sRlv+8qZXng6vimHZ+OC9HJMyWEIgf1mdOnMKUf+tEhYTRQDZh+6bQd5KD6GO
 FfHbT15HlOb3y7PN6tw9QgZQobtTUILwomAud1WkWON8nlEPvYma72Wve9InswFx+d3E
 n2+UVb9WBp/KWgFW7vaTyreMWcHzbyvJyN6rJfJfa2Op8yWsXfdirVOAxwKEFiEQhzCp
 3jwv7Pk10tk7dsuDKNmCYJCqdgbhoOa7lMQFmtPpnHcOKILmsC0SrBs2jOLv4CD3ivAD
 kSyA==
X-Gm-Message-State: AOJu0Yy9j8kR/+9tdNhBFUBV6vBG/Bdt31Dj23codtz1ZGeeXZhnbrwb
 yCRpG9oSNyfiy6O1mU1543Qi1w==
X-Google-Smtp-Source: AGHT+IEiMeIBInXc3gxSQtVnO6ZewFuVC0zCbQmDiesN+1di/WGnDAIGYRbP9Lxlhm5GLD54O+G4KA==
X-Received: by 2002:a2e:a4cd:0:b0:2ba:34d0:fa5f with SMTP id
 p13-20020a2ea4cd000000b002ba34d0fa5fmr12149557ljm.37.1698334777304; 
 Thu, 26 Oct 2023 08:39:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 w5-20020adfee45000000b00317a04131c5sm14495883wro.57.2023.10.26.08.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:39:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
Subject: Re: [PATCH 0/4] ARM: meson: Add boot over DFU RAM as an USB boot step
Message-Id: <169833477660.2656704.15194374053051948359.b4-ty@linaro.org>
Date: Thu, 26 Oct 2023 17:39:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

On Mon, 23 Oct 2023 14:41:33 +0200, Neil Armstrong wrote:
> Add boot over DFU RAM as an alternate to running script at
> a fixed address like done today.
> 
> The main culprit is that it's not possible to do that
> on G12A/SM1 platforms due to changes in the USB boot protocol.
> 
> With this, U-Boot will present a DFU device with a ram slot where
> the Host could write a fitImage or legacy U-Boot image, then with the
> detach command boot will continue trying to boot the uploaded image.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/4] ARM: meson: enable FIT with LEGACY_IMAGE_FORMAT on all configs
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/50ad9d01b6124b9730de957e1901d177094748f6
[2/4] configs: meson64: declare addr out of EXTRA_ENV_SETTINGS
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/72f63d85fefebed59921456bb29138fbd9f73bb7
[3/4] configs: meson64: add alternate USB DFU boot target
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4aa027b3f8c1b018ab50570ccf337587cc6178f8
[4/4] ARM: meson: enable USB DFU + RAM on Amlogic boards with USB Gadget
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/07057ad9be7d400d9d9f02f3c1507fe2d8071c19

-- 
Neil

