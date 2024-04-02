Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ADACD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC57287ED3;
	Tue,  2 Apr 2024 10:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H5nQurgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D51187ED3; Tue,  2 Apr 2024 10:00:54 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D6F87E15
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ed4d8e9edso3714969f8f.2
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712044850; x=1712649650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fhn7MtpEzT8Wye39fwymyb6B2TryfXy463znuDF8JmA=;
 b=H5nQurgib7lAziZRvLYFNa1iMNJ1Nzv0jn8x+9Z+jelOAuPZOa/abHpIVNHNwyDUHG
 MS1J4b332GvT3MizDxiWCjV/1DaD0NCKnZ9HiCVYL34kWd6XW3q8qSPi27EQl5ORvcYC
 p3B9VgUaEAEtpqVWBSihYe8zK9QywupBpWBLCzpaGLWRDffahnyi3JLsZ9jgUxkKIVA3
 8XrhExF6G/L2iQoEYDg+zEutTiHWb5TTpyzPbELgjPPiYmAK4lmukzspbF19ggmHeiww
 nrS1WULNF+Hhn13V+bg4/oKCtQqGOuTuoxxDw5pk4QHk3QvWf8MpF15jvP32m+/yECC1
 5OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712044850; x=1712649650;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fhn7MtpEzT8Wye39fwymyb6B2TryfXy463znuDF8JmA=;
 b=Fbvqi/mJXCvxMDT66aGx54Oo4J7xafsxGWw88epPMMJAdvaCdMwxu3iJl9mdvym3vV
 lF8oTVOXxuZkTObdOFiASz9J/mflinr9qtGyTH5BWcfWsXgqeLEcTN+98OUqb6Tc25AT
 wNe68vx2DPGXg3ktCAmo1e8fCKzdEmTQqV0Hj1FIsPUnukZ6jgRrPHmSK7JxUi10LGTk
 ASgGe5CIfRrWl3wBJvoMjllYfkhY3wHBdSwhujDxG3s9mM5GxO9HX2Nqxu0r9Xp1VvxY
 Z3aLob0/TSZgrVkhPCPXPKTZTYqxmWPK/5UiZT64F+6G0yaAf1dGBAzg+JkbnGJtAt1/
 voNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm2xTaj/287j4POUGP8XNHaC0/0eZ2sCo7MADAUYKDwqdhGcoc+7GThv2s8gj86DLwcDYafM1mjqVItmW9bte6WjZupw==
X-Gm-Message-State: AOJu0YzLLFQkJG1XoSjgbQEEy9bdaXpiYrYk71F9TMsJc2sEaj5dEgNg
 89zNMOMg0yxPsNqP0fxq4/nA5XtmY6BsattQ8ofnA7FEWf8admIHEabgI/YhdH0=
X-Google-Smtp-Source: AGHT+IF3vBjximq+7A/HpvELSB0j1XEhwPlplQkUAnGJgbxxnYbY4cOMJdmDDpbbLtQxZDzUT7mhTg==
X-Received: by 2002:adf:f88b:0:b0:341:bffe:e5b8 with SMTP id
 u11-20020adff88b000000b00341bffee5b8mr7498891wrp.27.1712044849982; 
 Tue, 02 Apr 2024 01:00:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 dn13-20020a0560000c0d00b00341b7d5054bsm13539642wrb.72.2024.04.02.01.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 01:00:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL,
 GXM, AXG, G12A, G12B & SM1 SoCs
Message-Id: <171204484927.3673856.73890042564486248.b4-ty@linaro.org>
Date: Tue, 02 Apr 2024 10:00:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Tue, 19 Mar 2024 15:42:59 +0100, Neil Armstrong wrote:
> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
> kept in arch/arm/dts directory for these boards.
> 
> Keep A1 DTs locally since the architecture is still young.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/4] dts: meson: Switch GXL, GXM & AXG to using upstream DT
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/227c586e80c77d8aaefe415c2abab11f58f41854
[2/4] dts: meson: Drop redundant GXL, GXM & AXG devicetree files
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e747bfc48cc74fd944a1e2a603cf089ec58f20cf
[3/4] dts: meson-g12a: Switch to using upstream DT
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/01f661e46bf8a6837fa1801f09f1da79abda80bb
[4/4] dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7b098c305e51086db906a07c5bdc983c8e9ae3f6

-- 
Neil

