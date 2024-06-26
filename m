Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D1AC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 13:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D7187FED;
	Wed, 26 Jun 2024 15:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="REnm/p5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3575488216; Wed, 26 Jun 2024 15:37:16 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1461187FED
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 15:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-24cbb884377so3290700fac.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719409033; x=1720013833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jo0tGIeHOBFch8w61j0pfcmCsFkT1wEuDnIQN+24S90=;
 b=REnm/p5St5Z3xQQyq/B1ui0ZXS2Biinhz/5noyPYTizESZGdvCYfxxtVXwK8/VOPJi
 TOlnhTO+pHtzxSUk8ZKEQrgBtUJSBB7IGqT5iclUGEFUNwvnlNpyrIakssgROMsY6ng4
 ibxJGtxjnq1xXKXYmYNEm6wbWiYKutGpTozSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719409033; x=1720013833;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jo0tGIeHOBFch8w61j0pfcmCsFkT1wEuDnIQN+24S90=;
 b=CeO130HA/4cHkifGn4Bp22cfh40AFbCwcLDOOgyoYal9spF5twvO9vRT2fHNy3zaje
 U7jo9xKTTUlyZ5lF1P6jkGM6IgeVTMZHAK/K11RTC6QBQt4pCnfvyDtsMw1xc5f5WLhZ
 ayqpOZxafEMdH3twDVRl9/2lhxVZVi3H8HC+XwMCuxJCazQtEnKOINqGf6nKUJQ5ANw8
 qG4EeOPo/NqBeK5BVSHrNd9qvWuG3uYWcgRrPZ2ZYl5kvWSznibOCrUlZUTCxna8PUkQ
 wI/ASyezIOAk6yjHJFoFBrZBzR+XOpL/HrF/VeTpXVuTpHfw8a/MhmiqH13B7yStcbsa
 FLGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4MuRBJmJPRxNlNZsAuYO4aYKy7eh56wuZTI5OSQ456sdBfC+QKJn6Pk5YoKQaz13EQWyGvNgK90CpC4343qYp/cE/6w==
X-Gm-Message-State: AOJu0YxQvOgeTJaH5YYK51l+pq1GFwSlwS2svdaUx8/Y/9IimFwNYSLy
 1BlDoIRz5h8whL1Z8s9hzd1rwZ72Poiu0V+8PDOPIQECUxf7mODlUzPobccDSbhDLOnoU8gADEE
 RHDS6Ew==
X-Google-Smtp-Source: AGHT+IGD8cPUs9HS2a+QGfRu7JZyXts+qSeK464VWRt4FJ+elS8ETbi84+QkC5DDGPzXM8LYuNocPw==
X-Received: by 2002:a05:6870:63a4:b0:254:a217:f8b9 with SMTP id
 586e51a60fabf-25d06c7da13mr11718350fac.31.1719409032791; 
 Wed, 26 Jun 2024 06:37:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd4bfddf2sm2888451fac.49.2024.06.26.06.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 06:37:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
References: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
Subject: Re: [PATCH v3 0/3] arm64: add a software pagetable walker
Message-Id: <171940903206.3359249.11110595004657513616.b4-ty@konsulko.com>
Date: Wed, 26 Jun 2024 07:37:12 -0600
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

On Mon, 17 Jun 2024 10:03:46 +0200, Caleb Connolly wrote:

> MMU issues are some of the most frustrating to debug. To make this
> slightly less unbearable, introduce a software pagetable walker for
> ARMv8. This can be called to dump a pagetable with the default
> formatter, or a custom callback can be provided to implement more
> complicated parsing.
> 
> This can also be useful to dump the pagetable used by a previous
> bootloader stage (by reading out the ttbr register).
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


