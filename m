Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0BECE7B0E
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073EE86D43;
	Thu, 28 Sep 2023 11:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ubV0SfmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F57F86D43; Thu, 28 Sep 2023 11:08:11 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F73586784
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-503065c4b25so20232998e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695892087; x=1696496887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48oe697wjuP71+52tb7vf8tr+xTvdyJJinslg3eV4H4=;
 b=ubV0SfmPv2e0ph/h/FzErwx5vYtw/zyl1+6zGtiwL1sg00zDFQACQ6QgZbA/3ZZ+z5
 wjO0UHWddiJQYWu+wfnHSJewXUvIjMO1L1xcc53Yb9/uCjt6YYBklBsJWc5JY5FOv808
 V6jtImZePNDiW01Q7VzvliJXTXwgLZebPfYMdGuKd3wEjolYnKXgY/1PZYv1MEfDvunO
 w/ynikSj6a60M4OnnWpi2v1/neJYhIcFWsy3QLW4kEmDC02Xpvh2rR1X6B31qJlw8/U0
 Qp7zmn6X2rvt4em6VURRJVNqmr0mrjenDy+p2bX8Ls/6jPA+BK4bhNpEQmOOFbtdxnVG
 QZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695892087; x=1696496887;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48oe697wjuP71+52tb7vf8tr+xTvdyJJinslg3eV4H4=;
 b=K663uqcK/HZ2foYUECVIgtS1JaXAfRuKDYOhNVWALLVl9VUShZP94SuznxYayj/9h6
 yzvImfTFUEznlfSK6jQIOOWhSRzdTOOBo+MG7RfvNMMHE+zSKW6sE3aV2mQYDOHwmDWn
 6s0E33Vzv0aXMjjsKYBnMD9NAEks+srPrMX3bKs4jpSrXGVMFsHPZKurzGVVEyowtNsF
 YZ6Sn19Zywn9m3t65tGeyWHfAimT16GmrOC8cspXaTp2DUkGHRYtC8hCtMm1+6IDVL1o
 zVI4VrdRoZZuXIDj5LAB1+dtfjSEQc+XqxQySeO8LePZHfXWfWE+LtA/2NWKjKLlCgpr
 NHLg==
X-Gm-Message-State: AOJu0Yy7sZmG9NE8Ch4DP1j3l81MdlvhlUM0ATA3gwmGSBBC0QFpPRgH
 mQXO8X+vpf3ZPIEuhStOQoUDwQ==
X-Google-Smtp-Source: AGHT+IHLsTnQ5mV+ZGzrbA1t2Cuc1Pc+IGmSPnQ6zVWBMO/ClpaeafvzQNOj/K0GfAe5kt36kpU0pA==
X-Received: by 2002:a05:6512:238f:b0:500:a002:292a with SMTP id
 c15-20020a056512238f00b00500a002292amr910116lfv.29.1695892086599; 
 Thu, 28 Sep 2023 02:08:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a1c7911000000b00406408dc788sm4394846wme.44.2023.09.28.02.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 02:08:06 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: sjg@google.com, takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, 
 post@lespocky.de, marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org,
 jh80.chung@samsung.com, paul.barker@sancloud.com, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
References: <20230921081346.22157-1-avromanov@salutedevices.com>
Subject: Re: [PATCH v3 0/8] Add SM uclass and Meson SM driver
Message-Id: <169589208560.3562382.4777414752510341666.b4-ty@linaro.org>
Date: Thu, 28 Sep 2023 11:08:05 +0200
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

On Thu, 21 Sep 2023 11:13:33 +0300, Alexey Romanov wrote:
> At the moment, there is no single general approach to using
> secure monitor in U-Boot, there is only the smc_call() function,
> over which everyone builds their own add-ons. This patchset
> is designed to solve this problem by adding a new uclass -
> SM_UCLASS. This UCLASS export following generic API:
> 
> 1. sm_call() - generic SMC call to the secure-monitor
> 2. sm_call_read() - retrieve data from secure-monitor
> 3. sm_call_write() - send data to secure-monitor
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/8] drivers: introduce Secure Monitor uclass
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/126fbbefd89e0baa7e1a8ecdc4e00b9ff9e776ea
[2/8] sandbox: add sandbox sm uclass driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ac830089c0075d1f6ee51e22d51244f7f1a2554f
[3/8] sandbox: dts: add meson secure monitor node
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/0b488d719015c3b77685dd116a0095b4677e84a3
[4/8] sandbox: add tests for UCLASS_SM
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/80da22b9e45d2cd7d1eaed4e94724def7d4c7970
[5/8] sandbox: defconfig: enable CONFIG_SM option
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b655672dabcf4f6f5ffe2fb92abd447ea0a20101
[6/8] drivers: introduce Meson Secure Monitor driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e7c31d9ee0606dc52a15eb6e8ef5e46978608681
[7/8] arch: meson: sm: set correct order of the includes
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a0fe285b1f625ff872b1cb8c79abb072cc154ece
[8/8] arch: meson: use secure monitor driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4908461153e8b194703c5ae757a5032df3af2c50

-- 
Neil

