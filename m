Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12033D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8BA483AA0;
	Tue, 20 Jan 2026 15:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s+2KZKAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9770A83A6A; Tue, 20 Jan 2026 15:31:05 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E6A83AEE
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45c7400259bso2029711b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768919462; x=1769524262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hRSyut+X1bbFPT/7B4d87/Nt2QMtjmsJ+tf7g8dcUyw=;
 b=s+2KZKAT2JZ1cyms0ihdYYry2STzrqN8ULH+G6FpQU4DCif5uaXVeWpK5woSJ8hWwX
 7plSWyP0Sd7bmhkgN9bM5t1bWtQwi4HH1wJ5ycfpt9npIO4wWMidiZ8RYWxCg9gGV3op
 4KoyHy1szkjpMuxn2jlD0G5ltelxyWyDi0oLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919462; x=1769524262;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hRSyut+X1bbFPT/7B4d87/Nt2QMtjmsJ+tf7g8dcUyw=;
 b=qy1mPQbz7QdIQCLTQ2CvWY3zOBNUOADwlPuGS03Rpu/SatjoEO1VaXBBQvYx4Iujfg
 P4eQeO4w1LXfd33ytf9uLowMytKBcmLg2UZC33AACQavRPKNda1VIia4bi7rpmkEBsic
 zjB11JHKSEt1oNwAwjopdsNvoLQT4c9Us8tgpT9DpWlAzAP8J+Edu+Rh4O75h2yCSeGg
 GX6juV4YbWD/IcTYgrBmmy+spDl5ycfkj6TA//84LKkon+hTC2HP0b9svIcxAaTQjxiu
 dRAbgBw6gwH/efaFUbKUOa4PM+N2B4NAGwXpkCsfuy4+m8pxdmbUaykg8aU29a5mgQO2
 IsLA==
X-Gm-Message-State: AOJu0Ywc5yVarNzQl3x/yNsTTXqyKdzS1eOEl4xd5kmeEwJklgK7Z81N
 pImiR/LGs/c46na8MDlnz3Y+HIbMavjs5iymq7bz4pJgL3hkHYcKj1tV6k8eOGLA2xxorEiOLN3
 gxJuT9Ag=
X-Gm-Gg: AY/fxX51mpsACsyiIxoLzvwAcugAngA0FlMAfyXYyTLnytXqbW4XacAQJb1U72pr4zo
 9y9xBmtLrH0e0p3m3plAmeLpPJq89IHymtBVQlSOe0U0cGz7P3TY2Fbt5qf0dEKUmQ13UR+EQDX
 5rE0dy5Dt4aMQf4hjmCadH+Y4FXR5ihgiHHgkxTnA5g8tB/RKtvCXZ46UYmic+ZNAjxTEVyvy/2
 NsMIT2LS+a4pbXtwFkFXb3NRyUvEkmUz3BFutM/eXCueggZw8/bufGay2CJShB1YjlsJCgeXtUm
 iX89ksFXgxYXXWe5oXxKFe72FU+BXnG5XTbwqZODD7dIJAPH3ictFzVoAwyoCy7fuVAHNZlkkx4
 ZQ7fiuBzXTIPjfD7xvhYnZudTaAJaaT/fFL4v8v7gbT8wYJXPGT85sjDkH7+lZaDavVLjIoAm7M
 GFjQq/PMSCmSS7VQbtFOquf6M4Qy+sw/OxVi+HqIse0jBg360UBP867AGfU7Y5YYt5sa26UsfCa
 YI9AhxKc02fOm8po/GxsF36f9104jYbyxcu/Q==
X-Received: by 2002:a05:6808:2519:b0:450:3e21:f567 with SMTP id
 5614622812f47-45c9d8e970bmr7475450b6e.56.1768919462141; 
 Tue, 20 Jan 2026 06:31:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044baf38ffsm8657418fac.5.2026.01.20.06.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:31:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260115161726.3881761-1-trini@konsulko.com>
References: <20260115161726.3881761-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py, buildman: Update filelock package version
Message-Id: <176891946113.379251.4355205492001178976.b4-ty@konsulko.com>
Date: Tue, 20 Jan 2026 08:31:01 -0600
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

On Thu, 15 Jan 2026 10:17:26 -0600, Tom Rini wrote:

> The GitHub dependabot tool has reported a "medium" priority bug
> CVE-2026-22701, with this package. Update to the patched version.
> 
> 

Applied to u-boot/master, thanks!

[1/1] test/py, buildman: Update filelock package version
      commit: 8f16767dccffe504eae796ccc0ddf305dbee245e
-- 
Tom


