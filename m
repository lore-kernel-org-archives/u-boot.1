Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E2DCAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79E38367F;
	Wed, 17 Sep 2025 17:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JVukdBvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5833835B3; Wed, 17 Sep 2025 17:08:20 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B727683666
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-752f88e0b59so793832a34.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758121697; x=1758726497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TdgywFbtkge+E466O6VBmsfQHQqT9qiSFtgFGm1240=;
 b=JVukdBvjDg9uZ3NugwmsbMSi7jqgrpV9XrtQPGSUw26Tkby9kp4BZ6ZzfwqKrBtEQM
 5e116+3pr8JYD6F+k6omE/uJuoLP4O1Q6FKBDIMEhLO3/Nwstdy7S0h/UxGJNUK6tE5r
 0JWqNR7bnodvTYvnY3jHjc3+JEeeBpmKep/RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121697; x=1758726497;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TdgywFbtkge+E466O6VBmsfQHQqT9qiSFtgFGm1240=;
 b=jpwUe1MF81k6PMiOe+KpPK7CS6KokFAy2U5ZKOBVygBLK86/s2H+6hDZ1Ftp5hteTu
 6SS6dhCMRxXyhU6wd4NA2pg8yD62glAKB8TD+EvuCuTDWX8OeJv+wQxwIcjrzBGfgmUY
 awZ3zeUSRete/Ly137qgVTGpvCjnE5hJr4nNxrT17WjyQ2EFFoJtVV54sP1VVkTcEaAz
 3Oqua7MPufp44j75zhOVY7yHCPs//ev/fh4WUeKFaMYz2FEAKYBRuh/ZtekB92xESNwU
 bwiklsWH2lWIrHKOEM0bWqAjBbT8rnkKJk/qQXEmyE90K5wDNTgd+0eTTaXljrz+/rC2
 cSaQ==
X-Gm-Message-State: AOJu0Yygky252ZPD2/1/tnj/0unQGDVQewKoRn99HhXToDA0fiMoJgo/
 rwzRkz3YUrOdKHUc6L5Sn5COyELB5hrfqn5ti20wBelnZB9F/MynOEi+d0x35aDwxQ0oYa1wsS6
 s7qmQ42A=
X-Gm-Gg: ASbGnctXRPZBgWjsUT/+QZWfttVhVuvnId4JMNM1GDwze2SlxQkWIp6/Yj/n3/6cHvJ
 DP4m2gCfROQgR35Y1Lg6r7iPf2/VahsAEF0Rzh6elQhUzNRps4K33Ou5l5hpMVfHq/zC2mW0zMV
 LcIebAURGnykhMHSKHufAvQx9AoS2CsU2z3Eb8N2l8ys0svakHYo1kb6TPombf4IysdaVQrcdxV
 eteLFn06xO56s1G9sl5dI416qoFkBX+FV8Xi2ym/a98wKHFnmjHNM9mVveqAZZVAVUCY8mcirWo
 tn/ndr1tdYXlZUg5YDVpdMDeHxM1I4O0emYGvlMCvnIxHeZwITT12argLQzBzZo+zc2O5Yjonzt
 u9c1GLLx5Qx+Srq6GgICsMedhmspec1Kdk3Nd4HYvGwAsFCTwouZINb8=
X-Google-Smtp-Source: AGHT+IGk+9s/qenWk9Ai00TL10k3c4yX7vkP22QCskeBDesMxvfsBcyKJxAuXLtp54hUjVr6q1O+nQ==
X-Received: by 2002:a05:6830:630d:b0:750:69c2:365a with SMTP id
 46e09a7af769-7635bf72322mr1970449a34.4.1758121697411; 
 Wed, 17 Sep 2025 08:08:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-758b2883055sm2981354a34.45.2025.09.17.08.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:08:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250917133336.7975-1-festevam@gmail.com>
References: <20250917133336.7975-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250917
Message-Id: <175812169652.761188.1304187866781906713.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 09:08:16 -0600
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

On Wed, 17 Sep 2025 10:33:36 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit b82fa9d752b025d3b5305b5b07debe6808a5d027:
> 
>   board: starfive: visionfive2: deprecate mixed-case product ids VF7110a VF7110b (2025-09-16 10:16:54 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


