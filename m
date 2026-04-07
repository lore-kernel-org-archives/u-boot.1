Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29C8FF5135
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587478404A;
	Tue,  7 Apr 2026 21:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jMvt11za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C3C84106; Tue,  7 Apr 2026 21:50:13 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C960D8405F
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so4445811fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591410; x=1776196210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NjHpNTZ42whx0b5ke1BIni4XEyIJDgEUjEBjEhft73o=;
 b=jMvt11zaa59rHIJRvvps5QUFD7VTFFyI6N7vZUvSwC5Oc3QUIDlqv3+gk+b2f6stD0
 Rm/of896rbsylTk8o/Zl8Zaz/DT5NM362es0/NL/roVdcqVXnN6dj2mX3MbqZlTqLAkx
 JSlMeQITP2IA9J2hR0wKdFT5o4dWGaZoAgMC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591410; x=1776196210;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NjHpNTZ42whx0b5ke1BIni4XEyIJDgEUjEBjEhft73o=;
 b=HhFKb5Us676GAlYijqQqdW0+11+TKLYJp98IG0kf6lGqY4n1bMab5U5qx0lRNr9KBU
 Ya4KSiYguxS69Mw/O5nFsSOVCcyBl44xFmMWIrv6pejlnHMOt/FiadJ3RLvwuXRablZ1
 Dh1Jz6rtbZk2NaNPxP55XK9ef6UW0gLSRrVzrGVAw931z8wj/KULSasb4VhvhpYihFy0
 th2oKWCeimPmfAb7hv3Ta6uVHxgeDmt73zrGkKOLAzaXoCly4B7eLSh+sPNAxnXkwoyO
 EhGWoSJIO0O0TejHBKZ7WVemu00sEP16QaIjTGKwH9ZhHDQmdXe9MmuRrd+A0A/6jbv1
 XQkQ==
X-Gm-Message-State: AOJu0YxE3+7ZbztG2DfNZ144Bwj/P/eD8kR8m7e1nD0OMtjScwq81WT2
 4sD2XiK3QEY40mbTIiIUJLEwclBHPz/ldoqmIOowTXLhEV/EvmckFHgegJJ0AVvLXO5U5IBUli0
 Xf41+8Bk=
X-Gm-Gg: AeBDieuxIJ48iEUxgnCzrgfwd7ziduds74Vf/pCptw9d4XzQUIH0lU0mzL5z+6QsXe3
 OaSEXKXB5vUWy/YUNvRSmb92jcjg3xatzsYty+RKOlgVahWrW0kqUEbxTsyK9RJ5zx0QEJffsnk
 VNr2QQlhr45Y1K6c/Z70VMUDxeHKqIze1mfFUfuE461yskce6tkjd8N3wuGYhY5F9nt5PrBghMn
 TP8R6sRH943hm3xIQJRag8QXJRyrhWojlKSHUADmjjnpRlQ6Spv/wiASjmAIVKlSjOBhrhe2f45
 Sf8XgEyrcQO5p4cxg0lz0WLNQ51OmjdPs2IVOKAf+KDmwnR5GKk5PaOxWgKeBld2LzTBTF/lTUs
 65eE49Wsa5kMidwc8K3Zis+t3ODsoFYwxLkMFrf4zWx8Stg7ZH6W1QqUJjdIufZu20fHOvPHZXO
 +++J1JppeUrRW0Tir7BTOnNimb+hK4iEFVdQ9DrCgpzSPc43bTt7kzqOO/UTPNTYBiLNGb4SLVE
 XUlPPJ1eqrQjqM2aXlY3m3zPS7Q3tK2mR/PbJRyqW2ufX8=
X-Received: by 2002:a05:6870:41c2:b0:409:5ef5:be0c with SMTP id
 586e51a60fabf-4230fd2dab2mr9842261fac.12.1775591410462; 
 Tue, 07 Apr 2026 12:50:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195106.2362981-1-trini@konsulko.com>
References: <20260320205335.3788760-1-trini@konsulko.com>
 <20260323195106.2362981-1-trini@konsulko.com>
Subject: Re: [PATCH v2 1/2] env: Make more use of the ENV_SAVE_PTR macro
Message-Id: <177559140917.2108693.7107004341058441101.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:09 -0600
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

On Mon, 23 Mar 2026 13:51:05 -0600, Tom Rini wrote:

> With commit 82b2f4135719 ("env_internal.h: add alternative ENV_SAVE_PTR
> macro") we introduced the ENV_SAVE_PTR macro but as explained in the
> commit message, left full conversion for a later time. This commit
> makes more progress on that front by doing the remaining easy
> conversions to the new macro.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] env: Make more use of the ENV_SAVE_PTR macro
      commit: 8af4e124875932567cea627e04f26cf5cc529e25
[2/2] env: remote: Disallow CMD_SAVEENV
      commit: 67e72e9686e702b85c38f62e4fc02f8efe3ffe82
-- 
Tom


