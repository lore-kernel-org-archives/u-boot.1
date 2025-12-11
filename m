Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC2DD41C1B
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFB783C94;
	Thu, 11 Dec 2025 11:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GpwEZSia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665DB83BFE; Thu, 11 Dec 2025 11:46:26 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B9D83C94
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so8313355e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 02:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765449981; x=1766054781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cjU/qtEORsATqELis3tzXQGkdA9nwv2oBCY8a8BMm44=;
 b=GpwEZSia5L+TwhKsetGwWq/eVmdnUbYOgBxgXL68wDMeZaOFECuuw0HeRAz5Dt/y1j
 ruZWwiEFRdiaxP0sOaEuPoGS53mHVWzK6ZvxxgqC0EGNGkgNYMDTRqxRScDgvAsx+sQK
 /wzt/O3QcsTBariFBW3RvZqaBYELV1JUc22z6Yt6di5dWSXiimTB9KZv45bMT+PKyjzE
 uKVPsP5KgPXKpY5XxYQSvCOfaXxIbRPAquqxAg5XQMt0IX7Wf3ycRzTXicSjnzo7q8Js
 vOM5s95YSpgYGYVrRdOObcHIm0JikKE5k/eR/BVIfeVqIDT6YW31dEJkxyN6JPTSqJFk
 XXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765449981; x=1766054781;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cjU/qtEORsATqELis3tzXQGkdA9nwv2oBCY8a8BMm44=;
 b=ZW98PM92nuVbS0THe6MnXpqb/Dn3bTo3dGrlIQWzZO0Tkew4QpLvCJVlVuwR+hFVUa
 pwMe504Fz+5dX9uyxO+ViThD30+fz+C56Iht8Fueg09Wm4Km64V5ESE8m07PSaojQNYz
 zTRJopSCGD8uvkcVAX+yBYtYtjQ2cmP+ugSKbLAX7Q8sOUY86V0IMG26Qu4Fzv2UXu9I
 AFgKPkJFSGcqHIxqNO+xzGVohPnsOqz0XOWWiJTAvOiErdiRCJjoSNPCRdnxdjhKOxz0
 1kmn7yL+QsQtcv5R8NBvZIoUD6eUsj7Zaa8Us000+ARJLCqJ1F+w+dWX+5S6UzEgDMJS
 j4rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv/VURzqLvQBfNA6wRYa8LtaDW8O3PzsOm3zHL3UwR4jCyvGo54V2JyObi4hMaPI4SaeXAMNw=@lists.denx.de
X-Gm-Message-State: AOJu0YyxzvMuUvwV5YBJ0ke2nF+J71YcJbHkYUvhBmvEakQHsd8v1+yy
 yKUpg1bxlqGUBnC90eyuQjP1gIs+THP0YBy51s9CZIKc3VYQQUjfaxro01eRbD5nKI8=
X-Gm-Gg: AY/fxX4ubZ35bZnksYaZcYDsbNQDfJ5bnAx/fyLzCCvJc4HZjFTgGvHdvQTDXIomfag
 YGoH7fKUq9ltOZ60FSICczmyLbdvgZZ7U0eDTXmr/LvA0kXJb7brdN7gvNA7+2tpvJLoMmycGx3
 9KXCVC374ViuE3XiCRPgRRFcmcMgmyUXcVOoY1ktHYoAoycJgDnOBl/Y34uc26vdHX4Y+j+mC4Q
 eMyMoObcq9cF1A7iAtrUGOWLBI9ch5nToeuOO4BmX5oVZ65oljoRE3zA5/qrcPiHDicKrLj2kyL
 iLUlvJjfiiWxgQReNdt4gy4gZbUDY49I8Tp1punUKBU3LNuFSIdJSQzfqypCCF5vLcVKVgr9pvW
 dY2B+pw629/mPx2/ikXkJo9OJRauJlS+tevnYGX8oBZ/91jcDi77mtn95CO/4Tg8q79XCAJAdzu
 X0EE4Ekp4HeHy27k5a6zP56sfy31V0k/s=
X-Google-Smtp-Source: AGHT+IEA/H1FughEtKqoDJcFk4wSBsJLyQKJTQ3KqrdtRaVvhDIBFDv6t2+uKkhLRQeJilwWVW6x4g==
X-Received: by 2002:a05:600c:8b16:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-47a8375ab5fmr57920085e9.15.1765449980721; 
 Thu, 11 Dec 2025 02:46:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89dac074sm27548245e9.8.2025.12.11.02.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 02:46:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: nick@khadas.com, peng.fan@nxp.com, jh80.chung@samsung.com, 
 trini@konsulko.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Nick Xie <xieqinick@gmail.com>
In-Reply-To: <20251209055750.43594-1-nick@khadas.com>
References: <20251209055750.43594-1-nick@khadas.com>
Subject: Re: [PATCH] mmc: meson_gx_mmc: reduce maximum frequency
Message-Id: <176544998017.2550755.9916407957719921322.b4-ty@linaro.org>
Date: Thu, 11 Dec 2025 11:46:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 09 Dec 2025 13:57:50 +0800, Nick Xie wrote:
> Reduce the maximum frequency to 40MHz to be compatible with
> more eMMC. And the Amlogic vendor U-Boot also use the maximum
> frequency of 40MHz.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] mmc: meson_gx_mmc: reduce maximum frequency
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/867750c2d9b1f42e9a6e54e4f816fae04cff0dd7

-- 
Neil

