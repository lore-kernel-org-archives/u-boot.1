Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ED1CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 21:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7804083C29;
	Thu,  6 Nov 2025 22:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TW9Pj5or";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE4A83C0C; Thu,  6 Nov 2025 22:57:53 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B4E83C0C
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 22:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c28c21aba1so84216a34.0
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 13:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762466269; x=1763071069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUzusdwiOgX8OVWfAG+IwirxaIO2QjkFcWGsS/Emxgs=;
 b=TW9Pj5or6Lfa3/rsN45uzRlpge4t237DTB9rMK099feqmAb4Lf+u58hvE4BazsOFyc
 ZviEZTo1pPBwEFMXEgYm79ZJ5FNMNPqwnXUTmfGnJpyunKg5P9s9oUxRI7ZpAXfM+Vf4
 mHhRmsEagyCI4JBeaiJgQbNKHWz3tOa+IL7DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762466269; x=1763071069;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUzusdwiOgX8OVWfAG+IwirxaIO2QjkFcWGsS/Emxgs=;
 b=imev6oo1cDwBAlAvGGImfQ8KhoGB9KR3U4AGAxaIGAAujvaqo0PbMuX5bPFSSsT2o1
 FmYFQxp/GIktsvnqsSVWgKVKZFtu7vnenSCo06ErsItyQ+90MVMpBmS3MfX/QblAGXQG
 W8CmmvadTEqDgbfxBfdHROav8qecUCbXXxCTdNzNxwnq883SckzxAkB1Q14892XY3Zzd
 OyF0FmfiXyyWdo1T6yrAYE8ZMMFteXhSaeHFChBwl0jUlnwvLFReKzTMll9F66Q1rUDE
 XvQY6M//Dl7ARJYNGrOqnS3n1bdPU/dWHRTCcIRBJlRP41oQJ/Nk6zBdacOFtSojiT9D
 FKwQ==
X-Gm-Message-State: AOJu0YzMsbpAhJxaT+Ctlsj6/cGbhrSXn6+5ovHvinHhORhgyOYdVJC8
 sSt6q5CRIMFi59xhTZP2rUKYbKmHknMaCFPC7VkzKdYcuxiOPYtxoncUipaHeN4y3Ng=
X-Gm-Gg: ASbGncs2bxv3w7NSf5wnmvZBYuyG6CxzaMLXSNh7H6H1KtLq1bLRWW+4HgO1r3uzZgl
 qFjiniF6pMqNGczJurCz4PIKJtvEtXzvb/I8e21/237hd6sW7up1eQLVvyOeMqw+AGbhVs+p6jz
 StMSIgjz49uceN3Q0WgyVpGSDCIMrysxeVkCQpgNd0KybM3gNYRCbB5I2jmcaXxcREUhU8xb0Vb
 eP3zIGMhPxgAdWBhFzje49o4NbUuEC+zdaew5Rvf65skLDtNKbT0Hch7j0VuS2DQDDHA8eSdFHO
 VWPzwoUZ8+2hGBn0EDXH+IhQpBJz5WGdfeXOlqpeoNMbDNQEtnXbbW40YxYHaneD7+7148AyrYX
 9xUYZlR3yjdbfe8fZkPaTnCwokQNDxE9Zhr3aYxx2xYtvtEyLDsX10Eryyrc9F/fOlRZVjuuvuB
 V+eFYJjiqMu6rVogbbiMzFyel24eVCMtVI0yxmvg==
X-Google-Smtp-Source: AGHT+IHorJPH9nCh7bOv5LPfvz6vMAPcLjQj9rSQtlOR2tuxi9XraglctKNdZd5bdeOmkT53SV60mQ==
X-Received: by 2002:a05:6830:440f:b0:7c6:8c73:ab0c with SMTP id
 46e09a7af769-7c6efcc8cc0mr1012699a34.4.1762466269614; 
 Thu, 06 Nov 2025 13:57:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0a715sm370514a34.4.2025.11.06.13.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 13:57:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Samuel Holland <samuel@sholland.org>
In-Reply-To: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
References: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
Subject: Re: [PATCH 0/2] Fix AArch32 compilation with Clang
Message-Id: <176246626861.3129497.14948596131312532180.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 15:57:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 01 Nov 2025 10:39:57 +0100, Dmitrii Sharshakov wrote:

> I faced some minor compatibility issues when choosing Clang as the cross-compiler for my target.
> 
> Please review these two fixes, aiming at enabling Clang-based builds (still using GNU binutils)
> for 32-bit ARM targets.
> 
> Tested to fix build with (also run-tested on qemu arm and arm64 with clang):
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] arch: arm: build: only set -mgeneral-regs-only for AArch64
      commit: e8e3b38def93b5e5d53569961237ce215454e141
[2/2] build: fix building u-boot.lds with Clang as a cross-compiler
      commit: f7d177395d73f7747373dfd0ef7329834788106e
-- 
Tom


