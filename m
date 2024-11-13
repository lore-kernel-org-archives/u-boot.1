Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF32FD462D3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 16:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445808955B;
	Wed, 13 Nov 2024 17:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V936Xwbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8894689586; Wed, 13 Nov 2024 17:28:07 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253738934F
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 17:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539f76a6f0dso7826908e87.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731515284; x=1732120084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVgpKx+NgZYXAl/aW/Jl4A8qQA0ZfLwgsRKW8oitPV0=;
 b=V936XwbkhP02iBrWxgDfoJWCkwCiTU4Tx7SbiZvpEM3yx4o497mBFduaiXWJlzpmxi
 lHw0tQIieaCsyNd4QPLEdNEWGHkBZTFesSIg8TCGyPf3yWjnyEjuohQsqibaNtO/UrRs
 TmAM5KxrxBKhdHnhHZxAVBMOPceCVSaxoF/6Krwl0tbpWnmMPtATMdw0Sie9bPOHhlWV
 Bs90Q1vi2UmIW/pyeOi/OsQQ5W7DXpSE69dPQuc4OjS0ypuGEqX9KosYhzHRlNAyd2sK
 eQwTkIWtMh7SZoArSNhOYwwNXdsqA1L/LYR5U2SGI0M0Ij3IhrT52Tu9FchnaRozAPBM
 4cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731515284; x=1732120084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVgpKx+NgZYXAl/aW/Jl4A8qQA0ZfLwgsRKW8oitPV0=;
 b=UOirl9wyVgq/FXuUkMsOSkBmtZpd9e9dka+A4TEP3ZjohPVRHoj0Cm4VgFVnDA33mv
 2D71ASvEKfuc2g7yf0LIDXWTDRUkPGSRzfMS4mN9Oem0nNt3AenjdxkFoko1IiIvKEje
 arNhQ81Jt9uUvOTG0i6jGCKnE7mYjmeybkDVGMg+9HPxB/Ja9Qf6EPDH/eFM89xS/aCF
 qAfaJa8RtyX7YaayVPpl7yOK718/dWyEIkIJ2wvOHmF+4LX27eb6ht43SKBDHBSnF2rR
 nOXCgO4jQzVEkeqje9Pn8Kx0ce+lUUB03FFwX7qnaPcYpivHm8wKG36Gp4cw/D03R5KV
 njHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOrcJVF6YYeJYm3NU36gAnAtRvYQy3LzgS5pFgPoch+FnNpDKHFs11f9oD62HeJgi0TxOCSLw=@lists.denx.de
X-Gm-Message-State: AOJu0YyZNnZwpGvteYDpD8Qz5cYOvbTBFGFfwX5cVSU2EV/4kqH0TUU9
 lwxeTQklg1OzSOaUfnwHO/92Y8x6X36oeicbAJDFBriqM2rj+eebrWjB+yfQ6h1TLBoYYvjqeTl
 B
X-Google-Smtp-Source: AGHT+IGco0f7ogPci6cEJNVwPLqrxJIZZ/9aldgO7fcstWlsWUUAZSChoqf3dMduXYerNGqJZeYWqA==
X-Received: by 2002:a05:6512:33cb:b0:53d:a3bb:b509 with SMTP id
 2adb3069b0e04-53da3bbb519mr771878e87.41.1731515284220; 
 Wed, 13 Nov 2024 08:28:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d54e0fecsm31181045e9.4.2024.11.13.08.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 08:28:03 -0800 (PST)
From: neil.armstrong@linaro.org
To: trini@konsulko.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/4] Remove legacy Amlogic dtsi and bindings
Date: Wed, 13 Nov 2024 17:28:01 +0100
Message-Id: <173151524505.641625.14064529005947453709.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112125836.3239832-1-avromanov@salutedevices.com>
References: <20241112125836.3239832-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Tue, 12 Nov 2024 15:58:32 +0300, Alexey Romanov wrote:
> We should remove bindings and dtsi from include/ folder for A1
> and AXG Amlogic devices. We have exactly the same, or with minor
> differences in dts/upstream folder.
> 
> I tested this changes on devices closes to reference A1 and AXG SoCs
> devices and didn't receive any problems.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/4] arm: dts: meson: remove meson-a1.dtsi
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ea2273911d3e36cca45f73ae82f311a05df4052a
[2/4] dt-bindings: remove a1 bindings from include/
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a5ed242ba6a8dbcf543b670fd8c11f1683b4baac
[3/4] dt-bindings: remove axg bindings from include/
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/827edb6c00be861bfb84391dcd0586b1402f354f
[4/4] dt-bindings: interrupt-controller: remove arm-gic.h from include/
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1cdb4e03e684d94456dee0cc30c935d7e25b263d

-- 
Neil
