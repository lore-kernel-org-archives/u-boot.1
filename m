Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5F4CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3026640791;
	Sun, 18 Oct 2026 08:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nO7bqSSUZXmu; Sun, 18 Oct 2026 08:35:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B66F240A29
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312545;
	b=JB9DXmXuqMty5yEqt9faPBsuLgobaLJdAlXNMBjS5WL7+Y9/946xkhO83mzS10TEm8hf
	 fNBC65z/AQI1U0JFEJ5RwmpvrhduTrAEM1W16fJdPkd4jYLjH9RWuWeVFMtntrOQ4bKwj
	 +iZbLjhcURUnNvT7kvJ7BVCgaRVZAKZFu0IsebAyzDXJ0L+iPnhpcz0FSUHCYr3FnyMex
	 rN13sSIKn9SudWENRiQUyCaukI0MoOEAu5GuRL+0RxSdmsm76zpobTGlT9GowgnaXHc8P
	 YKdoeaumjhpvUDOwNoPQ1ozDmlmQDl6UEoJrO1VAXi/4/lcw2LRp2x/clc+2/mfabxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TRktQE1lJ8wFUpqmMXEVBGaUSmaDiQOaLBvFw7eaMpA=;
	b=V/Np11dscWqWuBHisCerMr7HJHioeopoft59YRZSrPoFvqECfqdehIIgORvq1FisIT8g
	 aL0l08aUvV9tZRJz1gejzo/nZ13/vncQHe0J4xXvTB4dq4rTNf3YU+lDdORpoJXd/QoIc
	 CjDZpuelfon+CUKPjLiBrK5QtAIG80s9iRerdKeCsZRInhxxEW6fqd/7HsmVpQ5XafP2S
	 ltn+ZV1aolMEUkmLIfU9Jqv7L9dZwXYgDV2DV1khpn4YxrInUjs/RKwsHImn0m3w8kaat
	 t5J8ezWOi315B9DhWu4zE6meMPw6odbuns2bgTHfWNnaEY1ggMAPYRxj3YbjBUxoviw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312545;
	bh=TRktQE1lJ8wFUpqmMXEVBGaUSmaDiQOaLBvFw7eaMpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gWZKU5q35sMZgkptCoMAxAVCWvNVVsTVr/tHWdoAI0oL3sVIzGiPSG3+8L63L/HEj
	 ZseFMT71OyKUS34f2/N2fNK45s9sRevf83EV3T+t6scFuSZ91n44HWqjQg/QGuzvIw
	 KLLybSxrmA+l2oOuiTHDeI1/0Ae/xqZ8D2k2xDFPEzfK7SzLSMxp1f7LN50Nt+3lJu
	 S6xA4Emfz7B2b1MV4bSg3DnjkYmS5SUFIj+UVYA0bc2Vi0r+p+Bf3uyGsfBmd/Wt9Z
	 Cg7BEQChkdoXTi7z49CGWhDHwdVPWo+SGJVyDzq/KiEEDt9jIqiHDj/ojpxfYhzC8o
	 GrqTKukqVMCWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B66F240A29;
	Sun, 18 Oct 2026 08:35:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A2B62A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C026812FE
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KFuIj4bDFk_n for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE3E8812EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312535;
 b=NmWLh67yAJ9Mre+/oQm6iBE5QsuUmh0Ae/t3h6iXRhJXZpek+0u6wXXaf7S2poXtusuF
 36pepMLFSyjZRn7t5DfzSyBIQYD6MwPbi+R8cCFfCoeDsWOCLlsA2JKma4J3ULfQSoF+h
 kao2aTHodaKXyDN+IXE59jmgxaGxn4OUj0idKarocxGvI1Lm9xlSK3Xj8bt54LqON8aOX
 xiT4o5Re08eY4vVCIDraYGz+z76DGbTRjK75U1N3cRfZk9b4gaQWWLJzy0VXbgA6Ua5kz
 l/AFzhU6ejfMiZ4UFX+vsJ1QNz7qPLoa34/K9l63nNgp04emB5hrOJFiSB0y37PRPMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312535;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=TRktQE1lJ8wFUpqmMXEVBGaUSmaDiQOaLBvFw7eaMpA=;
 b=eregRUNDZTaYye2Oj48m/70xPgczVQ4qP01bwjMLKFrTyIxB/lUKRszWp8XDpB2OZ3sN
 SdXus/cj9h0vq65fj3txRNAyMfKcRP6c3tJi+51wbLaFS7uhmOQap5M4X4VOVT9T3Nl3k
 pgFFO6UxO1ntS0+9ihHu8NcfIh3ZurI5UMJpnXf9bYDU3Mz44X37CxXGxgOw1/QTQsIMF
 BgyURPiLnld4VHfQvEuvNRDj4ofFMUtDSasyy0BLL3v/2spys1FNy1Dpzb60LECUrG0R5
 KW/3lorNsdq2ZHx9Owb92AcJlVSLY5ndHxYsZl+eXSAgx40WArQG0zHAQCj84mp5ePQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=tGBLwZ0m; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=tGBLwZ0m
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE3E8812EC
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:34 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so8833175e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312532; x=1792917332;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TRktQE1lJ8wFUpqmMXEVBGaUSmaDiQOaLBvFw7eaMpA=;
 b=tGBLwZ0mr/vnt5+VQRKGfYfCN6q2t1g9j3MzuvuTS7btSPVra0sS+clcNPe/T3xw1Q
 zcSLTFnsfoj6/9vnoIMMu03ORpvZki4oK+076XUv4BO8SRGaLeOwNOEu+K+rUU0IQ6By
 EAdmIQH5GW3GI+rA883aRtGLrImwmmgFtPib7lo48c0U6ch4aeBXNUF/rR8e54FQ+9ce
 Rwna2Qb6Zd9DVsISmy2v7ySN0dx3WDsj5+wvGbVARGa6gLsgFPH781pMnop5V1xQ4JBR
 ODTg5sKf1F8a8rjsCFMGBECfckarnGRfsQUElKHcbGC+SIDReURXRRkP/RZCaKixohZX
 8oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312532; x=1792917332;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TRktQE1lJ8wFUpqmMXEVBGaUSmaDiQOaLBvFw7eaMpA=;
 b=tWa6WIcUQvZHCYt8KO28NhlNT546gxJHw1x3DEEszd6XlLW7ifN9B9gqg3DOtwbgoP
 y2hGiN9dIDLqOno7XnwJ14juRtv/TnyXf237du44ZHcnqmGHcP6pqyXplxl+Qy0Xa3iW
 emdhL2/ZkvbkQVSWzLNtkxpAiJpuczvkks5TyP3HrrvJHlGa9KxjHUquNe/9ky9HXq3w
 mTwL29QS24mDf29d2/R8EiMB+gYIHwPAbmsC9fxKNgszqssfm/l/i56fW8Ke/hH1Xdkn
 P9mBrsGP47Mu/AF3rShsLQDxIABFM0sR9mDR8MDKJfGTHxUjjB9lT8WEO4aQbeSj0wnt
 tB4g==
X-Gm-Message-State: AFq9FYLMmSDwzNR39ZT449Kj5bQYSKUOUtKATX/gwULx0a+u+hPoQ431
 lYGYh7eR2P3a2MRMDi9x4yLhwKVBi7BVgP5M30d0JF0Osaqpq4LtBuMOYVHpBNXJ
X-Gm-Gg: AYBFou2Wv2FDC2ySC3AA9FOaangMIw2is1loIW4dXjaJAyC0WP+TQBCsio3q3D5X1qD
 ZG072pu+rcJoNGad7KOVyR2WcHs18MsSbQs2ak0A6ypUFYSopKJ7hNKHeyPnSZdmopM8bA3yeic
 90R1Ov35H0cQYOS4cf2fkT/ihOPhnLXB+iOrw5BzUkNLXdQqLROnXoKjkrgq9ZnIBiJDFdJq/lV
 bhmpYxTXHas8LXvOa3G1xJYU5yj4r8Bpiv/RXL+1Xl1jPBu1fU1pRcDwXyd4lkg9lj28k+x4ofc
 UbjzpdN0n4O1nDOtDOZKMWmINoBNgawWPiXuKKII6C1w8K5n9FCtZ/wtNq7nlbyP3eFxcq3vk5c
 z+ufTkePmPUO3Lj2E6HMI0HdumaOJwAiZSpMTyn/QdX+XMfswulJZXki2P5KpsiTYYaNYyn9vBh
 dc3oJpl3FdMCOasuOxsnxAflJO9ybMrhrkGMwHPtUuhlFS9d6OGfwEFgwIDxobyGDX7mxolT5D8
 GoHJ03mrvsyXAanVbAvfVcpF8fnr6bRHL4uK2P6IFVgDv3NxOzOPFj0nxrfeBJk4rAKcHSKMFtK
 adPJ7CjJkT5tKCJiSep99jK1kvCDPOYQQlVaRSD+5+Z/ObtC/ht3LDwB3cIElm75Zyf/sf0We0D
 neQayYx4zpMMXwJ4LSPzNbCk=
X-Received: by 2002:a05:600d:6444:10b0:4a1:d6db:1bdb with SMTP id
 5b1f17b1804b1-4a1d75fc402mr64686855e9.15.1792312532044; 
 Sun, 18 Oct 2026 01:35:32 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:31 -0700 (PDT)
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
Subject: [PATCH v2 08/14] powerpc: mpc85xx: Allow LTO
Date: Sun, 18 Oct 2026 10:35:10 +0200
Message-ID: <20261018083516.49229-9-pepe.schlehofer@gmail.com>
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

Select ARCH_SUPPORTS_LTO from MPC85xx, so that boards can set
CONFIG_LTO=y, and name mpc85xx next to ARM in doc/build/gcc.rst. This
does not turn LTO on for any board by itself.

Only mpc85xx is covered: it is the PowerPC family whose linker scripts
discard the LTO keep-syms sections, and the one that was built and
booted with LTO.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
---
(no changes since v1)
---
 arch/powerpc/Kconfig | 1 +
 doc/build/gcc.rst    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b4883e00458..20716135cd5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -17,6 +17,7 @@ config MPC83xx
 
 config MPC85xx
 	bool "MPC85xx"
+	select ARCH_SUPPORTS_LTO
 	select CREATE_ARCH_SYMLINK
 	select SYS_FSL_DDR
 	select SYS_FSL_DDR_BE
diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index 1fef718ceec..48d22a3c8d4 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -193,9 +193,9 @@ Link-time optimisation (LTO)
 U-Boot supports link-time optimisation which can reduce the size of the final
 U-Boot binaries, particularly with SPL.
 
-At present this can be enabled by ARM boards by adding `CONFIG_LTO=y` into the
-defconfig file. Other architectures are not supported. LTO is enabled by default
-for sandbox.
+At present this can be enabled by ARM boards and by PowerPC mpc85xx boards by
+adding `CONFIG_LTO=y` into the defconfig file. Other architectures are not
+supported. LTO is enabled by default for sandbox.
 
 This does incur a link-time penalty of several seconds. For faster incremental
 builds during development, you can disable it by setting `NO_LTO` to `1`.
-- 
2.54.0 (Apple Git-157)

