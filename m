Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEECC606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rvFXhrPZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L3B5mY0x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CDB880966;
	Sun, 25 Oct 2026 19:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-M14T7K2ibu; Sun, 25 Oct 2026 19:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 253C08091C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792956673;
	b=aafvGbnzBNuTe+325sOYZe1rPSNcr8siiuA7oz7z1WO6yvqCSeRNOZteCck83oNhKy3A
	 qvfaMfKtvbE6M6pSfOGsK18xEqdf8spAF7ertZ1etjf2eYfI1n3aGnJggTNTHdB4XPW+b
	 Wj9KJ6hVhMumjgooLxGsYfhwgYeLELBZNwwKqPWQFFiQeFG4wnQR/d8zWH71ekXhsSfWf
	 rtDfTBnRNfnAyz+uKxaFJrkqEm6e7z359hyvjHd/Fgr7KuYuR2AHlQ4out8IlkjHgMyhl
	 jPC6YS5vTMVYAkMWtMKiKWODOobf1B2qodm0VWvMIo+V5Sx2I7G0PXcBbeYdwedChvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792956673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JmzDmvfy1eOEB5+VQliFtJHBdkeeUPN+DyKS6s91F+M=;
	b=ojo2sN/13G+L9Bfmq4nqJL1Nfyx1vC7OdU+k50R3AiREIGvD5MAFCvX0+eBoO0LAM76s
	 nzOcbpFQMMDaYkbMEOPZA8dQCrEKdzdBEPqfs/Cr+6D3ThY/EPoc6AzmbK/kroEitrZiY
	 xmlyJKx5NGQdbHxu3i8LA/V26DKpO9fVTQkGS3NlNyuQxe1KYr6lW5a3FIrLB1+W1hB9i
	 b4vAvJHgF/S2dP6xK9tcjZzSxPdXCGAocYJL8VskpAm6Ef2pk4I2hYN4A7dM2N14gBJEI
	 pUvKVbm9aGOvovSUkP0co5BW0NliF0Tu7t5VLxDM4JtvrHMs7+hsasZYRia2GHS9x0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792956673;
	bh=JmzDmvfy1eOEB5+VQliFtJHBdkeeUPN+DyKS6s91F+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rvFXhrPZxXhrv8IG7BYsjcLRtX7Iq7XSoFsk5q10J4hyirqLLQEXlis4pBNcWuEXg
	 0leb6KuoPxkRsVao+5tAG8UJIwTWYsMzkT4k5oJqqhKIqCNdMQBwvDzpRHfqA3C8iN
	 XSn6vsE4gZ8RTiEFpXOoxOsNz7ah7QiXfV0ddhcvbGEvqhhkVkcO2NJyVKheDgjb08
	 VbtloG34+K+i1DEnQXzmUqTUKsfMiASLo/SbVPjScO6w8WkktOWSFFHgurB1oGuqJ5
	 gExRPGNuAeinEeCPZ+gh5WWLhzUqTL6nFjbKLxTmoHdH2AvqYTWIYMlEV7ljlCA3m8
	 b+QX9XS7DtJkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 253C08091C;
	Sun, 25 Oct 2026 19:31:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 895F23D9
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 865B64009C
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xy1pYCUprBtF for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 19:31:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 514504008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792956669;
 b=Rd4yG05MiewVmynhsIf6hNGFFlPLfKfNm9jrajYP3wD6rBtrpgw/MR0X85Eb0wYc16qv
 pOzWUZ8axAX/r/+ez+eTh+kFYYz8XGIxs5vHIECQJbMXkqaDHPVXRgTy5cL67RvDRWmxt
 tWmOQ4/ovjQHgdFwUWnReJFHmfYxYb/+2ue3ZQ7KFYNqn4HOaVeu0Sl58Cjw+/9e153aw
 acH/fNTutDmyCz5946W3qy6j7uc+/wZF8JTVutNGlkWppvLqE4MVNhVguHJyfDHo5GKs4
 Tf7fRLfY/DviqB/DGGu46I5FsGsvriWdD9QYjQ4Hk+79ENJcy5W2j7LYRDVyK0q4nug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792956669;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=JmzDmvfy1eOEB5+VQliFtJHBdkeeUPN+DyKS6s91F+M=;
 b=EpX5/1Cw7bN11ZshVsN2OAfNpNHW8T9S6ItO5jyMKPsRv+T6vKyy6ff/i7rinFCvfQpV
 nN1LyRWCrPS+3EBP89JvgVr9jTzWOKC4RBhy7oJTLN9LFmxEesuuMFTjjEAytmBsykP+0
 772zK3ex6p3cXs/ZgCMgQnOB23AuCIg0f0rktR1IP+vfKrNka5CWFyDySOnBd/+AftRfx
 mDdkTDx7qh7lHY6xtN0dUrmh14gs1TVQODEqIcUlhyfCMT1+M/NAYTmN+nTVRsKQGeylF
 vLSBlZK2QTiwSVXMrwPTq5jS1pV0MIft0OM2YIwmOVI3H7jzGl1B3st5ZcgTnJ4KEHg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L3B5mY0x; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L3B5mY0x
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 514504008E
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 19:31:09 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso24228305e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792956667; x=1793561467;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JmzDmvfy1eOEB5+VQliFtJHBdkeeUPN+DyKS6s91F+M=;
 b=L3B5mY0xxZ2+L29iJ1jHjb3JV3gIXuby8xypF2p1SgDTnfOGAP7N1eHlDWLZohHV13
 dfcxuYwDePWKnnUGKoG7D/7F0pqM1hrlOZsz4R1DxNsAmM9TTEoVMkvP3qIMq/gIUCMU
 aMclVShbpYT0f7N17c7Q0UYHN+n8tZ488Kv6CuMC6dldIRWD5P+q2WiQQzc5VO6dGyer
 x4EkmK+5VslWKjDd3jKQyEiTHYPeJyvRdFgumElMS9k3m8MJaA6FY1EaUpy55YlldocT
 aLoP42SbIpoIVSHgkp/nJEV+DSh2JNCz1W+wPFqHyH+9ZOyn+ojyGC4tapKbXPDcogXu
 /BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956667; x=1793561467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JmzDmvfy1eOEB5+VQliFtJHBdkeeUPN+DyKS6s91F+M=;
 b=GB7ViF64azeH/izYX0Sm9U+Qt04kClB0WLj/PBWk4fGwJQm9FniNoTYh0IqHzBHrQ3
 97jrDzTYF3xS479sqMpyQd2FgHpkfbZPe0JMyMPi3KURY1XPK7yrvDEWKX0st84fi4JE
 aMANsEaZMUPgupwW2Bd88jIGvGJHsmVAkgBESHZqm3+BoC9pDCi7d+mF0Fx9k9JK8iSl
 SwSwNxgI0rUV9NrlH0dJfxWiKhBxsROP+zRnvghi9Dzl55i14HAEZh1bLrRp2a6kC6xW
 3Mr2BxvMBuc6I5F2mn8lL8BpR5kRvx2Pkh2Zh4/YGaJaUjU8FE5/jWG+OxmZ98YMQ1Fc
 ad8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjmDPGPVIwm0r5GOFF2e1TQ97SO4cKfBUTv3APV1U51MgRgMWpoYekALMuRzRxBrf4eY1IUno=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK6CWBpjYYzK+IwgbjclwR0ZNvRAEaOqjzsOm+4nfd5uBmLt5ch
 BCz7V5e8Un5uh4sXtRvAPFpD5ydgkCFK5anr8t3Kv74WrU2tbCMLRrNGQxtmyA==
X-Gm-Gg: AYBFou0lcAgYCYUwSfaTw4ys5LvheqTNZCp2jkeOQSqZ2jBnw+Us5qwplrshzZGmg8o
 pWZhC/APUZsbdkwgH8N2CdKE14lY3mFJCzC1FrbDF42KS0u5RCMdNJ1vGh7Vnu8ntBCCAhceLdp
 q5ZQiOw14/XalU+P2Snd5mMdzj3li8fAtU5rjU9R1eOHQgrWI01zNBhU9lb4TKplDWgtsOJUfwB
 SQ6y5+aKP9eDf2IG+eU+TRNPLjkseIZxjqrCqAy1u4yDy71JjkqUyXk+Hs3KoomaPIbxyNdmn8b
 CfH/kXZ9N8YQpjo4xEF/u5bo66KweuDlw3f38GMe3Kyue9VKi6ZkAj2TIlKor8I/tKvhVhloVQW
 qQgwwWCcIWwKYmHoOHtC5EdKcfYNL0yoJv5zBX2I/lhlmJiag5wdjESRrkS3d7nYYPxjQsdAnzl
 sP80cOCkRaZtA17j0vQY7JT0Vl36jUn1+C8riqOcTklRPWSYfZoKa8j/Hh4qeL97YCs3cCZjas/
 3rcYOYczZgO+6ZwbobLQ9pvrdDHOn6IQAAjvjHQqT4PpGcWTMCaXTk3xH1DMPtWsFc=
X-Received: by 2002:a05:600c:3b93:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4a35ac96004mr96483095e9.12.1792956666997; 
 Sun, 25 Oct 2026 12:31:06 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.254.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm176549365e9.4.2026.10.25.12.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:31:06 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 25 Oct 2026 20:30:48 +0100
Subject: [PATCH v2 1/4] ram: rockchip: improve sdram type configs selection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-ddr-multi-v2-1-b82ff9c860ba@gmail.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
In-Reply-To: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Not all the SDRAM types config options named in the Kconfig are
supported by each of the Rockchip SoCs: improve clarity adding SoC
dependencies to the options.

Add a new RAM_ROCKCHIP_DDR3 option and remove PX30 and RV1126 sdram
drivers fallback behaviour when no SDRAM type option is selected,
raising a compile time error in this case, instead. The new option
has a default true value if no other SDRAM option is true to avoid
impacts on defconfigs.

Moreover, these drivers support only one SDRAM type at a time: when
more options are selected, avoid debatable preemption of one over the
others, and raise a compile time error instead.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/Kconfig        | 24 +++++++++++------
 drivers/ram/rockchip/sdram_px30.c   | 17 +++++++++---
 drivers/ram/rockchip/sdram_rv1126.c | 54 +++++++++++++++++++++----------------
 3 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index d707d09c1c8..f51ae6a4542 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -24,28 +24,36 @@ config RAM_ROCKCHIP_DEBUG
 	  This is an option for developers to understand the ram drivers
 	  initialization, configurations and etc.
 
+config RAM_ROCKCHIP_DDR3
+	bool "DDR3 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
+	default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
+		!RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
+	help
+	  Enable DDR3 sdram support on Rockchip SoCs.
+
 config RAM_ROCKCHIP_DDR4
 	bool "DDR4 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
 	help
-	  This enables DDR4 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable DDR4 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR2
 	bool "LPDDR2 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30
 	help
-	  This enables LPDDR2 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable LPDDR2 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR3
 	bool "LPDDR3 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30
 	help
-	  This enables LPDDR3 sdram support instead of the default DDR3 support
-	  on Rockchip SoCs.
+	  Enable LPDDR3 sdram support on Rockchip SoCs.
 
 config RAM_ROCKCHIP_LPDDR4
+	depends on ROCKCHIP_RK3399 || ROCKCHIP_RV1126
 	bool "LPDDR4 support for Rockchip SoCs"
 	help
-	  This enables LPDDR4 sdram code support for the platforms based
-	  on Rockchip SoCs.
+	  Enable LPDDR4 sdram support on Rockchip SoCs.
 
 endif # RAM_ROCKCHIP
diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 37e62120504..c7ff924b2c5 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -123,15 +123,24 @@ u32 addrmap[][8] = {
 
 struct dram_info dram_info;
 
+#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
+	IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
+	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
+	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
+#error "This driver only supports one DRAM configuration at a time"
+#endif
+
 struct px30_sdram_params sdram_configs[] = {
-#if defined(CONFIG_RAM_ROCKCHIP_DDR4)
+#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
+#include	"sdram-px30-ddr3-detect-333.inc"
+#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
 #include	"sdram-px30-ddr4-detect-333.inc"
-#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
+#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
 #include	"sdram-px30-lpddr2-detect-333.inc"
-#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
+#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
 #include	"sdram-px30-lpddr3-detect-333.inc"
 #else
-#include	"sdram-px30-ddr3-detect-333.inc"
+#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
 #endif
 };
 
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index b371f597d23..ddafb235af2 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -66,31 +66,39 @@ struct dram_info {
 
 struct dram_info dram_info;
 
+#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
+	IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
+	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR4) > 1
+#error "This driver only supports one DRAM configuration at a time"
+#endif
+
 struct rv1126_sdram_params sdram_configs[] = {
-#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
-# include	"sdram-rv1126-lpddr4-detect-328.inc"
-# include	"sdram-rv1126-lpddr4-detect-396.inc"
-# include	"sdram-rv1126-lpddr4-detect-528.inc"
-# include	"sdram-rv1126-lpddr4-detect-664.inc"
-# include	"sdram-rv1126-lpddr4-detect-784.inc"
-# include	"sdram-rv1126-lpddr4-detect-924.inc"
-# include	"sdram-rv1126-lpddr4-detect-1056.inc"
-#elif defined(CONFIG_RAM_ROCKCHIP_DDR4)
-# include	"sdram-rv1126-ddr4-detect-328.inc"
-# include	"sdram-rv1126-ddr4-detect-396.inc"
-# include	"sdram-rv1126-ddr4-detect-528.inc"
-# include	"sdram-rv1126-ddr4-detect-664.inc"
-# include	"sdram-rv1126-ddr4-detect-784.inc"
-# include	"sdram-rv1126-ddr4-detect-924.inc"
-# include	"sdram-rv1126-ddr4-detect-1056.inc"
+#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
+#include	"sdram-rv1126-ddr3-detect-328.inc"
+#include	"sdram-rv1126-ddr3-detect-396.inc"
+#include	"sdram-rv1126-ddr3-detect-528.inc"
+#include	"sdram-rv1126-ddr3-detect-664.inc"
+#include	"sdram-rv1126-ddr3-detect-784.inc"
+#include	"sdram-rv1126-ddr3-detect-924.inc"
+#include	"sdram-rv1126-ddr3-detect-1056.inc"
+#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
+#include	"sdram-rv1126-ddr4-detect-328.inc"
+#include	"sdram-rv1126-ddr4-detect-396.inc"
+#include	"sdram-rv1126-ddr4-detect-528.inc"
+#include	"sdram-rv1126-ddr4-detect-664.inc"
+#include	"sdram-rv1126-ddr4-detect-784.inc"
+#include	"sdram-rv1126-ddr4-detect-924.inc"
+#include	"sdram-rv1126-ddr4-detect-1056.inc"
+#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR4)
+#include	"sdram-rv1126-lpddr4-detect-328.inc"
+#include	"sdram-rv1126-lpddr4-detect-396.inc"
+#include	"sdram-rv1126-lpddr4-detect-528.inc"
+#include	"sdram-rv1126-lpddr4-detect-664.inc"
+#include	"sdram-rv1126-lpddr4-detect-784.inc"
+#include	"sdram-rv1126-lpddr4-detect-924.inc"
+#include	"sdram-rv1126-lpddr4-detect-1056.inc"
 #else
-# include	"sdram-rv1126-ddr3-detect-328.inc"
-# include	"sdram-rv1126-ddr3-detect-396.inc"
-# include	"sdram-rv1126-ddr3-detect-528.inc"
-# include	"sdram-rv1126-ddr3-detect-664.inc"
-# include	"sdram-rv1126-ddr3-detect-784.inc"
-# include	"sdram-rv1126-ddr3-detect-924.inc"
-# include	"sdram-rv1126-ddr3-detect-1056.inc"
+#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
 #endif
 };
 

-- 
2.34.1

