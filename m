Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D39DC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 20:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4051683E0F;
	Thu, 10 Apr 2025 22:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RpnGjfsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FA6A83B1E; Thu, 10 Apr 2025 22:14:26 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA8D83D18
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 22:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2d0a742df27so808323fac.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744316063; x=1744920863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HbH/WhBwPxF2uyy+3apDTm15xCiNuUP4SeiP4yYpl0=;
 b=RpnGjfsix3ruDb4qX+e4rXQMwC4umSxOPL3bVkcaB8qUTwITUMf/eO0dA1cKyR35i8
 VXvyTxpowkQhWUCujM4rCCLuhfAgKqFkpz8kN5DpPHi4A4V39fWZzwOKsnTecW88sXNs
 yvJM9InI9ehZekhz34KttfIcCL9/8Wfr1ptqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744316063; x=1744920863;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HbH/WhBwPxF2uyy+3apDTm15xCiNuUP4SeiP4yYpl0=;
 b=J31XPeY+Hy92IvKD8xCzo0KKv8YdiYes86JmuYHeaOBcgsy6a/konyVKTDaUtKATqd
 enYiP4ZuJu0fqMX1PoD5LfwHGRxqCcvJvCs/+knd1roNpBrWCTDjDGTDF72lIt6fmlTZ
 2PXGWozPD/1QDl70hsDyihC3+X118LpOv965p+opXYUw4ua9zJZJcg76Ri1XC8rXmMie
 cKWUmMRJGa4vDQ2kDAs5R4pT7K43ehfHNrbVo8MLuxzIcVxsselcPPUn6/S3tGv72SDD
 ZcVTlc7WhCvXeV0f/8L8UgyNd0g0sg7i3iSoGWQr1Bw79qoSOMyl1q8wdToI4JH2byUM
 sejg==
X-Gm-Message-State: AOJu0Yw4KqgTQX3I5ZImAijhsZp8oRPCMElaoqO96SBcAsaVRlcIb1eL
 8dwFiY5+hUvCggC6Ig9Sk3YfrhnPLui6y8H3A2Xl75310vG7fvzUP450oWJebXwF7MO+m0OoGWu
 /8cA=
X-Gm-Gg: ASbGnctOVQIVHMZiRCQ6HWOaCK1W5gTw7htefQwtwc+92rv8aPKGSr1v6JZR67sqbgk
 Rg1IJWRJMOb7Pjyh0pAwx0CQQfdVirD89zEpsk0Ys3JMMJvXrz9xf4Yvx+yaIs1TJASexivlhwD
 pu4sd7eoY/TLw1Askd91HEYNJiXEgHAlJVyzGKEgVkrsc1quaEVzJVdSylq9X2ia6GV8EQyJx+g
 zIpej1bfwHeDI2SqKY38q9eZyi4ztQkllooxXdQvN/JVu4UWIXJxWK9rI4AuxqAJkDSw1IchCuk
 bPIsHLsf75sGwEigA1NCcuG7DXtt0QT3jnwzulU+57pHtj7G4+CFETzJntQIUFGnUGIsa/a6RzE
 d5tOAbuORV4g=
X-Google-Smtp-Source: AGHT+IHHPz8nMwsExmn55DUZOFqToxI7YQNTIbZy251OhdFNv39Esct+7ogTv2ErwwXfjDXue2Yjrg==
X-Received: by 2002:a05:6870:b9c3:b0:2c1:f878:410d with SMTP id
 586e51a60fabf-2d0d39091camr179641fac.14.1744316063317; 
 Thu, 10 Apr 2025 13:14:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8fcaasm685741a34.38.2025.04.10.13.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 13:14:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250328163115.642347-1-patrice.chotard@foss.st.com>
References: <20250328163115.642347-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH] dtc: introduce label relative path references
Message-Id: <174431606229.2981499.11634647631324777304.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 14:14:22 -0600
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

On Fri, 28 Mar 2025 17:31:15 +0100, Patrice Chotard wrote:

> Since introduction of OF_UPSTREAM flag, U-Boot's dtc must be able
> to compile Kernel's device tree.
> 
> Since kernel commit 7de129f5389b ("ARM: dts: stm32: stm32mp151a-prtt1l:
> Fix QSPI configuration"), label relative path references has been
> introduced. These label relative path references is not supported
> by current U-Boot dtc version 1.5.0: (see mailing list discussion [1]).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] dtc: introduce label relative path references
      commit: 088bbc1efa8c1efe8e2714b9640055ce984aec93
-- 
Tom


