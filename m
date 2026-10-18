Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E359CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B269F409E4;
	Sun, 18 Oct 2026 08:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 427C2sETubt7; Sun, 18 Oct 2026 08:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 645BC409EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312540;
	b=a9XrD5YC/hXMjZlkPUt1gebDE40Qn8OXK1TJeqFC+LhsmJS3rECwmFgCTYvXFDx84Z2Q
	 h8YsaU73X4pzaftrc19GXpWUp74EfOpgwaJnAI0MLx9ijj/pHoe+nSg2d1yJA8NNMNbeo
	 arSUGf5OH5+nGsjvs0b3dKN99PpZeZ1aJtfrTNUw+zFwVmZR/hgC1kJxmmfeSJN21CPz7
	 R05CjgNTyDZwv34d8NCU1xHmHJh+KAcXd7gSHlSvIOi8gzkIyMqL3MmGHHQdYevgWpUUq
	 b0zcm6nb0cFtBQkm86AugPbJck2+ij17Jj58vpj5nSBZXoXhJ0tdl9QjT7BS08TNkWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312540;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZQxvWzRepL2ufiCQJer2cUqRD43a7bShhtAZl2mrsqw=;
	b=ppHWyOk0rFwnxyJ4DIgKUkpWEiV6JCHnEcZsVTYsQllYg25qjCF6D70NBnnancljT3MD
	 mnvrZUtB+vnpMmDF91BQzWaiMUmzR9Aaa/k33oohHntO4i/rQZL4RTBI/APeVlFi1SfoX
	 BIT52aNUNJDFyL82exIZ/n46R3mqA34QDj8HETCgoY2RCJ0Mx1vRdjWHHjrrehBAI/n+X
	 HLfZPJLAsZlVfS8WAjaR6r3skQt1spfzCkoFTr0+u4YdlbarIfyyuKKhf3vNhtXxCQRub
	 Mnc8zMC4xt8BiXHgiC98vzIRiqPuwoBPfU89Bh+ZuNXDXzkJFvaCW9bpvaphxFUVN2w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312539;
	bh=ZQxvWzRepL2ufiCQJer2cUqRD43a7bShhtAZl2mrsqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iEkX1kyCwOcKiORJhXJCT3rLpMcM3szjTtMnTq8a1oAT4hPm4liOF3Lu40aYcOnyL
	 tZfbopAMk/KjdaDtbiAKDREW/ZBYaMo/gpTdGm7dWaC+OVzB2dL15Q/iOLH9XySPcv
	 fjG8r/S9HQTw41JVUsrWh74KEj8ddMiZIMDxIj2JLMVDVrNM5GjBJHoh1QIiZQxIuv
	 Ga2aVSAdJD3cfxLOCU7qiFjMesv85HdO8rWm9WmF/Z/lSceAE4jRlmJhifY4WcRVFS
	 QWJU5YWm0v0Ok0iAfDLBL/8mCgT6ervFohsBQHYKHaAB+A7c5CXKayom6l4dUOGfL9
	 LMP5gu2APhbWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 645BC409EE;
	Sun, 18 Oct 2026 08:35:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16793263
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F10D6400D8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k3MGh8zlxR8K for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C93A44008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312530;
 b=mTyXYla0vMV7C1ErJgZUnubcWwubMYmgmtoPZCIk+yc7ejm0QlE+HP47d8o5JqYftyxa
 s6WrLCZb4fysSAjYfc7l6a7O5KPHDq5IBYoPH+XMNk1/pc6S27TINioqrB3rFWPVA7CwA
 aPh1BTWI05GmyxkZxAPHZEogEixIP1q2EOHgmypmM4uAT4VlpLg6QQZAnKOXUmTRBb8cr
 gVC9UmYuISFHXB1tYPcK2bDOBBY1Xa8V9FVm0Om1IdHJXH4y1wXybFUIpBX1JApQ88uXy
 of4l+CgunbC1zweGPvkLBnQedjNiuzriM7fuNkpK46yjCj+74FUpUzPg8VLMqD1G5Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ZQxvWzRepL2ufiCQJer2cUqRD43a7bShhtAZl2mrsqw=;
 b=Tc1Y7mWP+LkrVHTY/kNNIsO+60X9FCHnNc17Cd37QcEwCvIG55YZeQZECXJ50bVy7fVF
 23QKh0y8gPy69mRW31RqkhD8S2r50p+VAt4RLnWlpR8+R24/ptWAZpLv4om6aleAeOohv
 oxLrl1mOzzok5hiss7J8wDcPgBhhEbNQi5g+UZyCW4JohGZolnCfpmIqiHUn771o+FcLm
 XttBmmAqHr0ApMnaWNGdYX3l/jzh5hLsYkYJwuION5pn7VlnENkxH0xFRAz3D/0/Qva2E
 R5Pm6BZ8AnSBvNKUgV6uVRGqhn3HqhBGVOzDJsvADYa6hC/pdtIs21ejU9LPRPmZCfw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NCG34ZKJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NCG34ZKJ
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C93A44008E
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:29 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso14108995e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312527; x=1792917327;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZQxvWzRepL2ufiCQJer2cUqRD43a7bShhtAZl2mrsqw=;
 b=NCG34ZKJWnt0dUeGxzsjXQlMq8aJH/7iFqLbrFIdJoC4C5lZkXS/6+XgnJ3bWAXnfv
 NkyrHTtmeYl1aH4SPTmqQ5OxYPKfwcaJWgR4XGJHQqjr7MLLMDL7Gx3kmeZgO17VWC0K
 bz37n8JS6pMT6VHOOQG9NebkemPdjXaKgryZXYf+wu46+Tw1fQbAWdRZzDXWkFpwDq5I
 anfiQE+byc+BI3p1hJ7ndr676XInzBXT+zLdi0LKmI+gExBtciE+2vfUOc9qeTQMNd1J
 od24Qn9yZ9gM5z0HJFPAcT0i2bCU/SmzByoqK8bLg0mXs/PzWBG4EYnmczYd4jhJ8X4O
 tI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312527; x=1792917327;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZQxvWzRepL2ufiCQJer2cUqRD43a7bShhtAZl2mrsqw=;
 b=BJqu3PDfnE62aH8vU0L84wNPuhgj0elp63v+EH/uVC45X5xuop2D4785LLnVsxH50A
 OefTELFwXOxvXtOIoXIEDxrVuYT7xYuq8ydUAXQ+vYuro8YbThkOUWqTvZDFN49bpOey
 yZiuqYOsxds5Ob6TD7FU50xcTklPne8jy4rGgpK3sGRlSN45zQNStKp+dqFiU9zvCcEb
 Tq/ALYDppoUY1gUyWyEd2FS2Wgw3zswkHB31Oo8IpM/2kotEqQT4WaDjSja6/tBSvbUD
 NiVFOXOGXPnWl8mV/T4SXWAPDk5PbRF7ocsRmQtpWYSfXPRMlkCa+6Df0bcdjiMYkypL
 dKmw==
X-Gm-Message-State: AFq9FYIbJ4poQsPw9XHmhSuoJrcaTBTiUBImjUHPffR0bCqn3Zul9HJI
 bZtM/k2bcIEmiBiFyaf/86l4xY1m/DAXgGZJLuYmZ9w3KvT42QXwEY35ScOLGGAU
X-Gm-Gg: AYBFou0i9FMEsX4VmwFJVEhdk5vvUH2Z1zF37tnYZV36V+cyAsWqcXMYBWEX51Xw+jp
 NiABzEcbliwg8YZIy+f1E7iCZSbGTR96e7RqEV+iMAczCMoeyDQDx0N3zeBjYs7c5BcoOAiEDgn
 r1X1/wGu4b2niv7MXUJRmG8BdpEX6djutl02rygHZofzAcNtCbjs6hzlKX6U/DpUIiSt48OnNCF
 PEyD0ZDQZBfIS/qTKnamulE64+TLtsrftXt4dLtTCUMqPX8YNyX0Nn8eY+OkEF4kXLlqzHBtZXs
 lWvvj53GgTs0n1wWTt/m5XBWjz0clpm5EV5nUhiR3mxrOSNevUPVqw1fKPDDpp0SvS+Br10uXH5
 Qw5eBvlC1nc2Za7sAWQCFNR6mQpPTUdJwc6NNMCJ90Y6vtpdzrkVEhaJgWrnc+veSlSxev3fG5j
 jO+jFTk6znjlJn2mvrmOrXlIt/SCnUgpFXRfDniGrg/A0STqOwL/ESeJ0qdfZaS3nxsxGt7L3m8
 Jyp6ex5VNeZcnI59KIe473qaFx3GlFH0SnTVGt8sfEIRpiys/5gDqCvPgTbLkcNukHsVwwdLdvZ
 GONTrjXnXhthUNMkcbI9c5kN6eQIOV4djsdwsTcnZTh/JBI0jonNUlRYp631MSijduVPmxStHU4
 rysn4a1foDeK6RIWWzmdhx3xo
X-Received: by 2002:a05:600c:468e:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4a1d7605110mr93468515e9.11.1792312527338; 
 Sun, 18 Oct 2026 01:35:27 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:26 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 05/14] powerpc: mpc85xx: Use the private libgcc with LTO
Date: Sun, 18 Oct 2026 10:35:07 +0200
Message-ID: <20261018083516.49229-6-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The LTO link rules put $(PLATFORM_LIBS) inside --whole-archive. This
works with U-Boot's private libgcc, but pulls every member of a
toolchain libgcc into the link. With Debian's GCC 14.2, turris_1x_nor
fails to link with CONFIG_LTO=y: ld rejects the hard-float members in
this soft-float build, while other members reference __morestack_fail,
__tls_get_addr or __SDATA_START__.

Select USE_PRIVATE_LIBGCC for mpc85xx LTO builds. The previous two
patches add the routines it was missing. This has no effect until a
later patch allows LTO on mpc85xx.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
---
Changes in v2:
- new patch, instead of "Makefile: Link a toolchain libgcc outside
  --whole-archive with LTO"

With the whole series, all 71 mpc85xx defconfigs link with
CONFIG_LTO=y.
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f20d58b4de6..b4883e00458 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -21,6 +21,7 @@ config MPC85xx
 	select SYS_FSL_DDR
 	select SYS_FSL_DDR_BE
 	select SYS_FSL_IFC_BE
+	select USE_PRIVATE_LIBGCC if LTO
 	select BINMAN if MPC85XX_HAVE_RESET_VECTOR && OF_SEPARATE
 	imply CMD_HASH
 	imply CMD_IRQ
-- 
2.54.0 (Apple Git-157)

