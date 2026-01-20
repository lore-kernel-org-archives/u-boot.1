Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A745FD26296
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 20:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181518313B;
	Tue, 20 Jan 2026 21:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LWFGSwJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6EA83A3B; Tue, 20 Jan 2026 21:13:33 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633758063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 21:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45ca17ef16eso1441802b6e.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 12:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768940010; x=1769544810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+CeAEztZLnrACN5UcAlwT6MyFZU3ccunI8RpSzoBKI=;
 b=LWFGSwJ1eV/74ZVAP/LzLqotBU1dZX+Zz65XTTvjbGyxy7llEt9oLXoUZbhaXeOi/D
 IqufSdYZ7IypAY8ViMiEQyuiYwBOwOe8NU7dDqJQZCeQ7xVkh9wre3VVShvJoI6UkkpI
 8/CVHsH9lSONTM7IzzpJB+2PS8J8ze3ETKPns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768940010; x=1769544810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+CeAEztZLnrACN5UcAlwT6MyFZU3ccunI8RpSzoBKI=;
 b=T3npfOmyIFDxwzaLPKGGpgakvfjto8v6Xlm4frxEQaGLV2ErEur7Y7cKUyPrcr+vTb
 WbOL2YkZzFdKWOvA22XuDXti6wMdABxmJiVPDj7IsmQdZzyAoEGteMsL6ybwSt2JI5xi
 FzOe2QaYDeTu3IbBhO7bHOR6BIzeX22LitK0ueE02/QL+8hBbFPQCK9F+jswv0rsWXBQ
 6vYMHKtJPQPf2Jd4H8L3cRIlPrfkKQ1tukzrGKBY/Fv2lST1DDd87UkJjfBA+W+nR6F3
 vpCJ1VW81rEkX315i7fGyXYgx1sZqYcIV7t9y3jBK9ig4Rz7qMoNss6TsOkaaVsvuhuT
 ztUQ==
X-Gm-Message-State: AOJu0Yz70Vq4YUMccYX+RA31kGfmA9Fg9Okgct7maWBMwjBxjAoYzKqF
 UZgyhQsrX9lfaPmtNM7NSShSNctpsKFIFhW19S1O28K6NCeLgX/p1EucShduAzxSl3X7JX8Mn7S
 cEGH+Ru8=
X-Gm-Gg: AY/fxX7dV1uGuqgMkBOBZ0ZoE1d2u3UAplKWzLIjEMqI/ALWwBkHI/LKbV7iF2eSDrO
 5T9MgOBk2I2S3qTu+YJt49gfVwzYZVZDaJecQgTzUxny0JTNgr5E6K/q7gsSqtC1cuQtSA3ZKWz
 1Pb3uI2RKmjItOOyp7HLDHbSKSunCSVkj8sCS3qkfDRf2A02GejgKl/2z+cd6Zgqhir05hzOAS3
 yqbzUOhFn12IkhmCST4Ojnd8MDDVzOEI0uZ3Eh1GwU8YQZLxrAU11+UumV9dW00z7FswNSMss86
 MkZXq4h5rFLBezCxjock/pH06ygpJOgjyxg7o3FsI2/fzwQ7bIEgpbveIBlmxLhcFWXogV1XPwk
 v9JIH28a59hRpEyCB81+fae+UQq7AFx8KPGFZXApXFINT6v+FyeTAH/YH7G3sWcliUioh4Lx3y6
 p7GF+6bSoMU+voYu2PtHBFzUCTwPCQ4OzssgIRzKrOdWysX6VhjGum4UeacTzsk2Ay1eN9bxbOu
 ddQ9AEDW/ySU/nuRuFcvBuoP2129C3AGdYCVbbcu53HJWj+7JOI
X-Received: by 2002:a05:6808:5381:b0:450:d7b1:4fb5 with SMTP id
 5614622812f47-45c9d6b7f91mr6628967b6e.12.1768940010055; 
 Tue, 20 Jan 2026 12:13:30 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dec6619sm7417337b6e.3.2026.01.20.12.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 12:13:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 0/3] doc: develop: process: Clarify some patch editing
 expectations
Date: Tue, 20 Jan 2026 14:11:42 -0600
Message-ID: <20260120201327.451872-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116182335.4081828-1-trini@konsulko.com>
References: <20260116182335.4081828-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

This is v3 of https://lore.kernel.org/u-boot/20260116182335.4081828-1-trini@konsulko.com
and there's only minor changes this time.

The goal of this series is to make it clear that custodians are only
supposed to make very limited changes to patches prior to merging. This
ends up being a small series in that with the current structure of the
document there's not a good place to do that. So this changes the
current document to have the "workflow" section refer back to the
custodian section when discussing the state of a patch itself, converts
what we have today to bullet points and then states the limited

-- 
Tom

