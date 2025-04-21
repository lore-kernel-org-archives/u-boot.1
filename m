Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A7C369D2
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 07:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B9A81F69;
	Mon, 21 Apr 2025 09:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AcgM1cm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5BF81F6B; Mon, 21 Apr 2025 09:01:50 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3619281DE3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so649955766b.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 00:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745218908; x=1745823708; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQvSY/h7xxpFXeb7H+TNa4CpEj8rs/c1lZ4LoOKpQnY=;
 b=AcgM1cm8dE81ITCQFnGqJuY8fiadbVuUxZZvHZsHEAv4nQfloPtny6+yJI/hce7k6I
 qC5SlZsYjcJM9+j3qE7MApk8MC8dhcfCk8GquN894M5hnFr1OMdBGhD/FEh/ZsNGF6Ll
 UmmpIOjKGKgIYhmhgGTQRK1iMuLQ4Ehdn+m2ogjHM1epGNO7cE/zPBVHdlzJL+caIkuW
 OZQTwXW8ocxynXcao6ck1CnwLYTibYvHYwy0Dm354Paf/peXJqzji8fN6okcwBhq8DoZ
 WWnKgCcIVMvlry4LphFySyC78S9Oc6uq+m2fOVoMmeyp+6L21aoxv9lct6YnAzMiUjwR
 vUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745218908; x=1745823708;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YQvSY/h7xxpFXeb7H+TNa4CpEj8rs/c1lZ4LoOKpQnY=;
 b=kcb1AJGcCvLDkZhvuc/Xd4DTV3L89m6tWy1B3kXjdFyegz1bjnHgQIPMImPJFlG8+C
 r0PCtnWCHaAKyram9wJxctyGdPmb0NgR8tSzUsei586bvjoE67DkrEKwnTUy7cCZ07+y
 M92pCKJTXQ82TMPEaEr4858XbLwwTQ2xHS3JIlj+k8TSEXl3Pphtq0jTms+D6t7thvlG
 Lcw4IHeKh2DyUKuRaZrQcAD8tKtbfghN0K+Apotb/UORXXjD/uFiu/jf4iWOKGlJeJqd
 PqOb/yNVFsgzfj00iQV0M77D/sTpyO2BpoIx4kuvEHJFoTiKWffxD2XMMGnWVqm0mteN
 gVEQ==
X-Gm-Message-State: AOJu0YzmEt+Cu+CjZUkVkfOkevtaWTOlZYXfT6j1Wf1oVwkV4cR4Xn4y
 S9QtEqkHKUGyaYJVi0cHLuff1NQf4XWRXZXw8Gw4f2exVXYi95pjBayTBMSd8tNaGXqIHXuRcK8
 b
X-Gm-Gg: ASbGncv0rUxTBw6vxpHPW86ywpxIG8i5vS2bDPtrGpBflC9BQq9wAAepWr3xv/U9Ggb
 xvvQpl6LVV56Ny4Rsy98LyNr1Oo7PQWbAJuK0M7UimKaRsS6kOK+FRnxtCIHanP5Nw+6p5pY8zW
 NoBHdPVNQeELJri0eOFSlWBHjh7UyfNKNO9/Rtk2pBPNF5+gthIb1Z2vJAeBmeDj/JHa/PakFVm
 WhGVkFk4GzWkStIjwq5pvFEHtgHRQMmNwGUnjCFA5lyHFmHLu2lROuwd4LRW9epqQpmLU9m8usz
 zxwQ7yMl5gF+bswYIVm1/UwcGo5X+IK0c6U4SbgTQIR5Be7Rzw==
X-Google-Smtp-Source: AGHT+IFf+96iVQt33+mqVj19rKX8STt9JyFfaLTzxzQRW9HQGG1QhcLP5B8JKtLg0T2Kb18ogqVTYg==
X-Received: by 2002:a17:907:3d4c:b0:ac4:3d0:8bc6 with SMTP id
 a640c23a62f3a-acb74b2d277mr1051976866b.13.1745218907646; 
 Mon, 21 Apr 2025 00:01:47 -0700 (PDT)
Received: from [192.168.1.212] ([82.79.215.22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6efaa976sm471034066b.180.2025.04.21.00.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 00:01:47 -0700 (PDT)
Message-ID: <40af19f9-ff1b-4d33-a356-f60e3737b902@linaro.org>
Date: Mon, 21 Apr 2025 10:01:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL] u-boot-at91-2025.07-b
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

Hello Tom,

Please pull tag u-boot-at91-2025.07-b , the second set of at91 features
and fixes for the next 2025.07 cycle.

This feature set includes the addition of sam9x60 usb gadget, and a fix
for sama5d2 SPL.

Thanks,
Eugen


The following changes since commit 8a2cf6307a2ccc09c39dde486b6d9375b78c82c2:

  CI: Disable evb-ast2600 (2025-04-09 18:34:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-2025.07-b

for you to fetch changes up to 5d33a80c96d9862dd174f0f5d493cd818d985c08:

  ARM: dts: at91: sama5d2: Pass bootph-all to the PIT timer (2025-04-18
13:41:25 +0300)

----------------------------------------------------------------
Second set of u-boot-at91 features for the 2025.07 cycle

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: at91: sama5d2: Pass bootph-all to the PIT timer

Zixun LI (2):
      ARM: dts: sam9x60: Add USB gadget DT node
      ARM: dts: at91: sam9x60-curiosity: Enable USB gadget node

 arch/arm/dts/at91-sam9x60_curiosity.dts |  4 ++++
 arch/arm/dts/sam9x60.dtsi               | 13 +++++++++++++
 arch/arm/dts/sama5d2.dtsi               |  1 +
 3 files changed, 18 insertions(+)
