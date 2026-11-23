Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB037606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M6jEa9ag;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=evo2icKw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9718C80DE1;
	Mon, 23 Nov 2026 14:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZk5NEVrd41X; Mon, 23 Nov 2026 14:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7DF980D83
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443785;
	b=LaEmBLRt/r+DrVIV/cJ32L/wo/eQVPV6YxFwXDB4npnHHEyA8+FA9MG11Cgum6TFo06x
	 7HwUfx1NL4HIbdK7RRgRCRYF2t1aSVjemaI09py6x4+RX/JtJD0Nx8gOxxZk5CRLNfNxY
	 J8QSbGosUZlI0qeSCqbg3RE0TMC61c4vUMrDx9/tLzbjAED0FQS+XjLWCGQo+L3asIvNJ
	 Jk3UcId0L8ZLzEL772+o6eSQECGeelTdsCdlyyJoQnpvWsglIQihJ9vnRhm/mlhajEl6b
	 VvZWcKVdSU+hie6Eqnjunv50rezHr6P8fLvZMvrvfxRbsIrP7pqDb0QyXQOAO8np/tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZV2tymiJlRNuOpKXKuSoKjAP5+cT4S6ADeenhANW0RQ=;
	b=J1TBd++4HS8Z0tbX+Y7eFv4tI2sZZsmdDi8/ymAtdkpWxjFqyMeyjerDS/qZKEMX8MRz
	 NqzFayxtcEXzZtxGJXLSt7CW4TVw34EmEO8PHuAIciMSzBW/pTDfqd35SzaPaL+FkFRu3
	 YOXdj+yVh0PHAchde1MTu99xHF29ZmX0pAb2vibQD0sSkcjR906XQ2R17ordxeE74SUmy
	 ps8H4IPzfiK3q1HUCCBS0kGLJ13n+ohIZUhcFhM5tLLxv4zvSCvZYzhtHPkCWSMdk5TnM
	 OIJBtF0nNNcJruEq6WwQMBU9x+rhsNdt4KhGTPQnYOD1OLdzQ91VE4n9pEByh7TWelg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443785;
	bh=ZV2tymiJlRNuOpKXKuSoKjAP5+cT4S6ADeenhANW0RQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M6jEa9agL3bEyJPBloUZSHqUdNGyp0AnXaqbWEUj41iQ1xky69+8fyUdnzVnDOz5L
	 BrXiCwwyr/YM9EMY6OCa0vm7madN8uO00qtxRowMeAWD5kPB8cADUwuz98TuHRheIL
	 BZnZEpF68emwuhDHQ7n5AO1aSe2UFWQJDc9i9ei7cYbaGNesSZ74PMSfWANcAOgheU
	 57063A6gz5/mkwHs6hsuaEGgz9nHX2c4M0NQxsEI5es97BE0GMKMEF2YLLYgVCGgUJ
	 T7wgBJe/niOBAH3yfcnbIxk9U7o49lOOPUtpT+c+VdMXH8IanCrLTplzpyhqmbt2yf
	 bjMUs4LhLaPXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7DF980D83;
	Mon, 23 Nov 2026 14:23:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57F90759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E6B640060
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ix631ev0pqDQ for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:23:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 68D8E400BD
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=evo2icKw
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68D8E400BD
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 195C04E41601;
 Mon, 23 Nov 2026 14:23:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DA2DF601E1;
 Mon, 23 Nov 2026 14:22:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1CE0411E6A3FC; Mon, 23 Nov 2026 15:22:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795443773; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZV2tymiJlRNuOpKXKuSoKjAP5+cT4S6ADeenhANW0RQ=;
 b=evo2icKwS3XP8ZxoKNNfHoFm7g/9gVeEG8zzpZ77zzVY28opstHKf2sghLpKC4Gbf4pszA
 30Y4gJsPnxrYpuvEbEGFcjp8MXb19wCpBOk4x4gHIFg2bRfQklt4vOBkApzcbOgwstZD8j
 jj/qCyaG4loI+/ObWJ5sKT8cBHqObq9crRd4/qfxA63O/i2Hso/glr/TkMnCBktvQQQNLF
 gBW7TXpyfkQfQx6G85f15/FZsNtuppFO0kLAMbfZoBdZdY61j9+y8T0+X5ksGqsroNRbqU
 N4EOagzy18mfcdza03eSHiVYrfYMqp2Ia50+pnoxkgUgfafv4RJSo2Er+qqk0w==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Date: Mon, 23 Nov 2026 15:22:02 +0100
Subject: [PATCH v2 3/8] Kconfig: enlarge CONFIG_SYS_MALLOC_F_LEN for
 ARCH_SYNAPTICS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sl2619_base-v2-3-9e3b28c77cda@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
In-Reply-To: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Terry Zhou <terryzhou05@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.16.1-dev-53874
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There's not enough memory available at early stage because the console
needs the clock driver which needs the system controller driver

0x3400 bytes is a bare minimum, so bump it at 0x4000

Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 8e91a3360a83..51e3052579f6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -303,7 +303,7 @@ config SYS_MALLOC_F_LEN
 	default 0x1000 if ARCH_MESON || ARCH_BMIPS || ARCH_MTMIPS || X86
 	default 0x1800 if ARCH_TEGRA
 	default 0x4000 if SANDBOX || RISCV || ARCH_APPLE || ROCKCHIP_RK3368 || \
-			  ROCKCHIP_RK3399
+			  ROCKCHIP_RK3399 || ARCH_SYNAPTICS
 	default 0x8000 if RCAR_GEN3
 	default 0x10000 if ARCH_IMX8 || ARCH_IMX8M
 	default 0x2000

-- 
2.55.0

