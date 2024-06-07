Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352ECC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F5588506;
	Sat,  8 Jun 2024 00:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uGVepYN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77AD888485; Sat,  8 Jun 2024 00:03:52 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C568850A
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-24c9f628e71so1272121fac.1
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717797829; x=1718402629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40upo58hWLMqMcWNydKuJhMETheiClG83t+si2V+aY4=;
 b=uGVepYN6aJzFI1LKaIhsY3ckRQFDzngTKpGQ2t/PUCsz6vNIiw3Ks9f8JDpeCrOv0k
 3L7sKhdBImcccpC5xmd3YgL/XZFsaw1VflraMitAlPzcQ/9EP0RdTTS2w8z83tdauuIx
 4llbU/8FEsSHXwHSZrN5+/eonovBxwP9H3SuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717797829; x=1718402629;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40upo58hWLMqMcWNydKuJhMETheiClG83t+si2V+aY4=;
 b=CxVNMVfzNdNOTRC/8M2Czrwb8rHskBMKFptsQNX36uwo7f2eewFQK3jQIXMp+Hrwmu
 uGD2gQWLi7SY2RlDhKIW8P1rkRUdOzlhLZWxjMj0EEiamPf4XzfOOaQ/0Vd8Z5cnLuxr
 q/KjrqHcXQwUSy4SLKqwcQIXqjZDaAJTLmlBvaznBDbukB12wCR+XKxf/wGxTlVuUm42
 nmlvkgtnbh+x3sayFDBBzDvp4J8WMUJKkyOLtYBI1NEBCpkQm4kZYQM1gMS2R41SwFrt
 fntmf5c/B4DiKEHbwusigdXofZlAHYV6Y13BLEd4zVHXeIetSkS9JoeZa+83bPirShX3
 0gGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjVd3C3UivL1er1zAeZznQcbHpAk88hwCmK4hDL7Oyr4RZ9hPjpkUbiMTw7PpqMW0b+E4+1q0sGivNoo/U+CV3Cx4/3A==
X-Gm-Message-State: AOJu0YxgY9L/vT7O0ynsHmrZJTZB0g8JQtF7Dq23fWSMnfycs/fiF8Vh
 AfZEPjOrNDXSkffj+70PupBVON5GJq3bnzT9Xz3n76JclArD4YeMHtkshMasAVI=
X-Google-Smtp-Source: AGHT+IGh9qmjjduXm0s4iIJfcN1uFxjYFt3QryaHxGhb26qCb7wjtMm4Zb5jbvw1LIi8Cyl+1p+aKQ==
X-Received: by 2002:a05:6870:5a86:b0:254:8712:e0f7 with SMTP id
 586e51a60fabf-2548712f687mr1269847fac.9.1717797829017; 
 Fri, 07 Jun 2024 15:03:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254951da4d4sm58415fac.47.2024.06.07.15.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 15:03:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Bajjuri Praneeth <praneeth@ti.com>, Nishanth Menon <nm@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20240515-for-2024-10-gpmc-printf-v1-1-025c78529d8c@kernel.org>
References: <20240515-for-2024-10-gpmc-printf-v1-1-025c78529d8c@kernel.org>
Subject: Re: [PATCH] memory: ti-gpmc: use printf to dump settings/timings
Message-Id: <171779782828.4156831.10623556321053027385.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 16:03:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 15 May 2024 15:20:08 +0300, Roger Quadros wrote:

> pr_info() depends on CONFIG_LOGLEVEL > 6. If user has
> enabled CONFIG_TI_GPMC_DEBUG then we should print the
> GPMC settings/timings regardless of CONFIG_LOGLEVEL.
> 
> So use printf() instead of pr_info().
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


