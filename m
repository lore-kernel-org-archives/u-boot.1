Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4C4C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 22:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DAC081F66;
	Fri, 27 Jun 2025 00:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IOroLwgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C7382B34; Fri, 27 Jun 2025 00:23:05 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9814580E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 00:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2ea83f382c3so1101089fac.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750976578; x=1751581378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pxQTM8ukjsZGvl2ary50i2MpGG1qQfG8UvzTjYgFZY=;
 b=IOroLwgqQbK4t9WauNt5q3rvONSDBu+6kk4OwBxHf/tihaoK2SHcZnbgHY625jqzLE
 TYWZJvoQoHUspB7D4AaOT+C8Y5+xCfNj1LtVoFnJ9DmJ/4hRWEYtHNL13ePGMVVO7HLb
 owEJOgePHsgRm9Tmh/qhFSzgph1Wv4WfkL3tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976578; x=1751581378;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pxQTM8ukjsZGvl2ary50i2MpGG1qQfG8UvzTjYgFZY=;
 b=KnZRrsO+6W/eYn0yVkc9N1TeBzzjIj43AI6/EwsVdc3OKm5E3b5dxvNpqFR/bAJ8rq
 z6B91R939ixSvFmHmJcWSMZQnjYFVB8NcwGYhqNDAFSWHEboMSkvjv1Qq64+e+napjP5
 i7dkOTlRUTv23RBnlifkJ1Dai1u5JrcE1cCV3ey0m7r8R7tdyBJXFOLrkvA48nsZKUC2
 ClQmJ3JvIx68NWYL06RZK9s2OrdjA9yE8iXt217x7y+hsNLOA+TwoqwGyr0AJNRlewyx
 CUiA1MEv8rrKTDoYZqYhNAVYIKFkFtG+I+RBDpinknUb5It5Lb98ZQa9Bfx9xJ0Vtd/W
 VoOw==
X-Gm-Message-State: AOJu0YxAL13W1sqWsbobK7c9bqjLqFbtckRAQrI3bDU6/g2KK3RT7D1s
 gPMJa9GKY6bXEgK8vMG5z3O66xEps8Qzh1WlrNNCUl+v4oNRO6L0e16wcUUm2ab+k5OCLcfxEqt
 +eCKwcW0=
X-Gm-Gg: ASbGncu5XCj/l1UvO/ZGyzgOm0/kfOFk7BWnN+txqK0176PJAUELYp6x2S1fJ7cG7Xd
 vldDxfMTaBTDcnBJCuxGe7om5kZgLOMuXmva/Rz7dpcXxPnYUKxiEIzPuu/HpWujS0TKSCTkKJs
 NGcDXQqzLRq/vh5m8lyS+kxIXEzuAqNh1Ml9CNGbHAAfViEJva3gzEA2DscQzkGv4SRKIIk/uJG
 h/Sm108EDITm6jYAzASTBbvtj+K2hNDVZ+s/42D7QVoe2PbW1Sa8krG66PgVsKn9Jrq4liJ9Y4F
 F3RUldmgaDmFxgXd1GVu1ZtiR342wo7SOav/cCqAVO35afhw0vrCvwLR58jt1ZefolNBW4CMUqp
 ilYGqQyWaUeMOxMcjgPLdUg==
X-Google-Smtp-Source: AGHT+IG3FAd48vn3nI3EpM44lgUERZ9rfe5SNDMClHhTn0AbmsPbk/YWUQJPE+m2VSVo7A+3QtE1tw==
X-Received: by 2002:a05:6870:a18e:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2efed759dd0mr447418fac.36.1750976578310; 
 Thu, 26 Jun 2025 15:22:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b20d4sm579723fac.30.2025.06.26.15.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:22:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250626-mailmap-v2-1-f300b8b12ae6@dujemihanovic.xyz>
References: <20250626-mailmap-v2-1-f300b8b12ae6@dujemihanovic.xyz>
Subject: =?utf-8?q?Re=3A_=5BPATCH_v2=5D_mailmap=3A_Update_email_for_Duje_?=
 =?utf-8?q?Mihanovi=C4=87?=
Message-Id: <175097657729.1910269.2498366423412141545.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 16:22:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 26 Jun 2025 22:11:31 +0200, Duje Mihanović wrote:

> I'm moving to a new address, so map my old one to it.
> 
> Also update the MAINTAINERS entries.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mailmap: Update email for Duje Mihanović
      commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
-- 
Tom


