Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F21C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD2786689;
	Mon,  6 Nov 2023 09:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="njnbgcaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2A9842D0; Mon,  6 Nov 2023 09:47:02 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8C386C56
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so37004705e9.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 00:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699260419; x=1699865219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lSusEc+mx0fyJT4POwsV/GeE5If486jXOVrfD/bvFCk=;
 b=njnbgcafow8IJ1qEZiM4xPngvVQZrFH71xR5U+I12ITKNJcF7FSoK6WhaeeGjft8ie
 nnel/mZSln5N1pemqmQYsyiqAT2DmhZY4EnsDdQowNYd9+lbFoka6d0pbbbEU7hiTyYd
 ho8slleV4P3j6FsMqzA3QYb/UCJASEEacfzWsG/rZoW1tEbJyCqDLU2xJ0kl2ychVoFl
 Vvfcs4GESj0VqAEk2r4ajYHIT44Z+NByhX/hSf47OE0y0gM8ju6/5p6LKAJDSfM4fWhl
 ocUJUa9OO8KXniW/bmVBHw9m3bkchtLt03mFNNWUQOmoTOiIBBEA4J6XlaYZfA+O4+rd
 p6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699260419; x=1699865219;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSusEc+mx0fyJT4POwsV/GeE5If486jXOVrfD/bvFCk=;
 b=ZVP/nKsdWetE8pmnKEnr5STj4lpzFcXXK53EZEr/XEpWsaA48rBLo435652hWOGOeB
 rh0On6Dn66x2I8Nxyu9AGBFboHI4h55/ZVvRJsB6+Z21iYH5v3YWUUSfNq+cmU+bWmqs
 YuJjRQQ4RXDudkVsi+Jktkqfb/P7VKeOAgsL+fkeSJaORDt/Rd1tTnN6CNSFfzD2TY1b
 TI5EACOtmEXqh5h1uR3D2+YOJF6REZvHt04dq4hPnbBHGIxzmEfAbEmkbXC1r22666Rn
 Te40tvLkI+eK5JsByCqC2d1J+ykx7rLvAJrdsbNXT9iSlHe/Nv7XrE4232Nv2zn/Lv5q
 7rZw==
X-Gm-Message-State: AOJu0YzTsl6U9easzpSBykZb6w/d0AwqJmTLoam/2FZjVGH42qVx8OZr
 hKU3HM0AvQgEUo0iqBn7/CY+ZQ==
X-Google-Smtp-Source: AGHT+IH4oBwB2GMU2ZEWUDiwnC0sE6KNZLOy/RcR9PI2fGgqaquVMeWbV0EEJJEZnCjCQ9PALZWE+A==
X-Received: by 2002:a05:6000:18a9:b0:32f:a5af:99ca with SMTP id
 b9-20020a05600018a900b0032fa5af99camr13394643wri.69.1699260419324; 
 Mon, 06 Nov 2023 00:46:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a05600004d000b0032dbf99bf4fsm8937827wri.89.2023.11.06.00.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:46:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231102-libretech-ac-fix-dfu-v1-1-112379165028@linaro.org>
References: <20231102-libretech-ac-fix-dfu-v1-1-112379165028@linaro.org>
Subject: Re: [PATCH] ARM: configs: libretech-ac: enable USB_DFU like in
 meson64.h
Message-Id: <169926041874.983914.10761301521289002030.b4-ty@linaro.org>
Date: Mon, 06 Nov 2023 09:46:58 +0100
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

On Thu, 02 Nov 2023 14:49:58 +0100, Neil Armstrong wrote:
> USB_DFU was added in meson64.h but is missing in libretech-ac.h,
> fix this to enable DFU RAM boot for libretech-ac.
> 
> Fixes 4aa027b3f8 ("configs: meson64: add alternate USB DFU boot target")
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] ARM: configs: libretech-ac: enable USB_DFU like in meson64.h
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/c550e81171940932664a85bda315a6a073aae23c

-- 
Neil

