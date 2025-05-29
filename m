Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC45C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 17:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D110583010;
	Thu, 29 May 2025 19:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p0ff4Xn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46F08309C; Thu, 29 May 2025 19:55:06 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4CE82E8E
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 19:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6065251725bso796554eaf.1
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748541303; x=1749146103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ab9ghXXIRFkW2ma/wLSy56HtJ/mbSQWzweGzEEmAznc=;
 b=p0ff4Xn7MOFiITp2olKpKcS0rhEXSrHVH3AVl0TEpAKV8Qmv+mu6ygueCDcTHGmEye
 h8ikR/JpA3c/dVOYrUKX8sNjshn3eZ9HLZXai3hpq+oKBx4T2gUQlzFgfORkHUrwLHXt
 /qEja8eoNi1cYeKwL/bNb3rym43unVU+KG794=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748541303; x=1749146103;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ab9ghXXIRFkW2ma/wLSy56HtJ/mbSQWzweGzEEmAznc=;
 b=HaEHbBwT1eVRUrNhLGYZpgY4Ft3tmOqLtqAUIuyPKgDUDNVfVm7TiiqB5DeQ5HQA4r
 pCGZlIjOvxHs8qdQjrL2oxi+5K+QwSf/OnKwY0/zM4+5X3HX65Y4Hv0ApG8viqmMZxhK
 ZJvZqXkzmInOOY/ZunMb3s32tQ4uhANfhIadMVEC5rZBpHagcp6CKT0CMrdwk4vDS/r8
 7iPZbBs0aH+sXD79kqCuLhNzMrizpxTBZpRKqgCqfke3IY9FAvxSHUvA04s3LnFGD9RV
 LW+qTej8Qr4v32aHLDakd33X2MS+dzeEYOYqo+zvubp/lxOBY6hsQ/B+Ii6yOHvI1ZTW
 VE1Q==
X-Gm-Message-State: AOJu0YwRRMlF+hEl4s0QaV8GwXKRu6VQfDqvjrF9B23mA5a06/U7t/k9
 b/fXStyUqOosUJv/bmdoPFtPDiCb4x2vuujYbR8cpeJIE8hNEEMYYsjqA7VX1jt+Nw8=
X-Gm-Gg: ASbGncsOMGfbF05xWvuuznGzNDIfvVhaN84kJwA+5yC8aMGlvvsMiNyzzMqY7/aiMoI
 Bqs2vgB9QdaURzRqejyf1vlHvkbRkyz0dodD8uVGb9SQmX0LKogpGRQJepzcWIJXYk0pcuqDyw4
 76oL223cSz1NOt3xY5z1rtSM5RULYm0Ghl9sbapLPJS/mitrrlTNuH5ZKeAzIXoHsqLtVgxASCY
 dEv8FQl4sQ7hJ3dPQDwUXACvwUUAY9B7PcEJ9GKeTD7FQmudzHz+IySBpt+VHCgtpXejg0PJXXy
 Jt+14J7EEuTnixJpp++JOXbgFhI4/oKGk/kuqtaAReC2dGT2bE/Sor7iSsJQUzoqnPNvJYXPw4z
 e9v4+w+IdDahH0DModPxnPA==
X-Google-Smtp-Source: AGHT+IFYA2hDOx4Ew599tMGIC0/J58o57A2SKUkfRrgoS8ooLRy+RDCuptfckxIUaOyntiT+rSHjGA==
X-Received: by 2002:a05:6820:c89:b0:60b:a8e7:b23e with SMTP id
 006d021491bc7-60c4d7bd771mr345519eaf.8.1748541302945; 
 Thu, 29 May 2025 10:55:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c42c16sm77455eaf.7.2025.05.29.10.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 10:55:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250514225002.15361-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
Subject: Re: [PATCH 0/5] Start removing <env.h> from headers when not required
Message-Id: <174854130159.3917659.16411730283410042885.b4-ty@konsulko.com>
Date: Thu, 29 May 2025 11:55:01 -0600
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

On Wed, 14 May 2025 16:45:59 -0600, Tom Rini wrote:

> Hey all,
> 
> Given Simon's series at [1] I started looking in to what brings in
> <env.h> when not strictly required and in turn has some unintended
> implicit includes. This series takes care of the places where, commonly,
> <linux/string.h> or <env.h> itself were required along with a few other
> less common cases. This sets aside for the moment what to do about
> net-common.h and env_get_ip() as I'm not entirely sure what's best
> there.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] global: Add <linux/string.h> instead of long indirect include path
      commit: 64307118499db0be83db29cfcbd8860db1e44e37
[2/5] cmd/mem.c, test/cmd/mem_copy.c: Add <compiler.h>
      commit: 55717ca66f10bd8c1c05cd8053fee233d869e7e5
[3/5] gpio: pca953x: Add missing <asm/byteorder.h>
      commit: d0e1ee6590420ec13cfe3fa373679054ac08a184
[4/5] global: Avoid indirect inclusion of <env.h> from <command.h>
      commit: dcb7d927d181b5798c6fd4a1b1650cd821e3b6ed
[5/5] include/command.h: Drop <env.h>
      commit: 1e50f7457fcaaba2caf642132cf4f00f1eba29a9
-- 
Tom


