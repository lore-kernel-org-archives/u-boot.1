Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F036C54ED0
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 18:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7567D82B37;
	Sun, 25 May 2025 20:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f9CKO+5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41C482B48; Sun, 25 May 2025 19:43:23 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB9782B34
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 19:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lappys41@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3292aad800aso19897871fa.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748195001; x=1748799801; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aMODe5rWhnC4XIkq9Lr0ElrGWmoI3e5DNoiLw6yKe4A=;
 b=f9CKO+5dIIwjrjwMnKjwrteq7J9CGuRRQrcSLvwu2j+5Udds538zKjmrZQPshrRCXC
 xQ7aGRd9tiPt93gg5KiV8fgS6U7E/Wn8OhvTLNMI5k3YyFAHt/K0HbZ8b1HcPsItTaXj
 21I2+alNXZy0qscw8eupX0Pytt+vB4y26laoTfQKTw9EzjQ8xvZ0pKaAlKTJLzVLVoZw
 zlF3up3VUJawafcVju/KqQT3jwlooNvsDs+HhxcyfsXS9VYYjo3AE5DYwOyjaToUj4zS
 P6OCuIyzpelE+8IwGyAlWAFX4jxEf0ftflDFRc/xta6aiGqVLQfCTmlFT+TwlIGNtc6/
 4Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748195001; x=1748799801;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aMODe5rWhnC4XIkq9Lr0ElrGWmoI3e5DNoiLw6yKe4A=;
 b=FinTp2f7aKdJZv8AvaFltf5z6UUtl9xfGNjf7ijayjavVn3mzWtcol3EP7peGIQe0s
 X7HHnQD72JQT3SuWpPvBcfTXV7BnK1IwrueMOMAzIsEKCDxBze51gh9QKTK94LDEjO44
 mjS5XS2XyWCM/c1i+puTYhEjTrq58vTit5cWUG7FF+ReyE24oTtArc21j3wGFx1g7aHF
 OxFKQmV+BF4ptkeqlU/Hu+h/BkENm/Cj9ZFkULqkJDE2/iFNS4rc7koax7K/YZHhyloi
 uDqT1r7hSjbsyMRlylBvfRQTnyJaqAYhirChJQugRL27A7BApDSB52J8q5EkePROrbg0
 0/Ww==
X-Gm-Message-State: AOJu0YyUBSaILO9gnOiuj5goDisp7uDcNVm/aZbFvVruKnMDJkO5zstO
 K2Yf/M+Pqo324aJyKmTaWAawdauaRCQoSoFuc+CRH7HULME62a6mLaBJ2vvPTztxCa8CuamjMl/
 +WMfFyGSP8ltCdYeE0noOFQDar0Xr5/LQxA==
X-Gm-Gg: ASbGncsJi3wBHmnDbFCqcGRN+l41nyxN/kA7vURYSyo4QXGZ56LWymY3+wKZGWs9jRp
 fOYEy7BI59bgtOA1iS+XfpJigGBUGDVM35ZJcMrCiXT61SXOCFgCsq9FlCAlHV+fUXgmrIY/gez
 wQMI3Bslm3CPLBbP2czs+v1dTMwqjivZAX
X-Google-Smtp-Source: AGHT+IGIOkJy7WMf2hbhkb7KAEKlowSMpnyzqbhrZzUvfejNkBuLWv3dPostzX/0znJ/KlVW2SZTGmfk6EaZ2hnyTLg=
X-Received: by 2002:a05:651c:1509:b0:329:12d4:323a with SMTP id
 38308e7fff4ca-3294f729e4dmr28500591fa.8.1748195000854; Sun, 25 May 2025
 10:43:20 -0700 (PDT)
MIME-Version: 1.0
From: lappy singh <lappys41@gmail.com>
Date: Sun, 25 May 2025 23:13:08 +0530
X-Gm-Features: AX0GCFuNa5vHCArpTze7joa0Emm7A6YjCrefoaL_rz9Hw1n4F56wqIL0Y_YGIeM
Message-ID: <CAMD6HvKDV4ZAN5N46zVdVfShVCrZ87at9MkTDRzBjMwT-XgkgQ@mail.gmail.com>
Subject: u-boot sti7xxx
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sun, 25 May 2025 20:52:32 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

hello friend,
i want help for u-boot sti7111

thanks-regards
