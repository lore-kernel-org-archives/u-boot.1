Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE4ACC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C01E140674;
	Tue, 13 Oct 2026 08:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gGzknVFKXYqb; Tue, 13 Oct 2026 08:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D265405B5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878571;
	b=iVeVGO+11xyojdSN5A4QcS52tPva0rObPwNSSujqR51u0qV/cFV5bXizOaZa/36LTbWg
	 KJWmGq6EvUP6DBCbFymznkRLc79cWsTWaECzzPTfK515JyfIWpzSSg9BZzpXJgriXlYHN
	 QtzJ0Z/1ShxxQVN7bjFM7/E+5ViDKM34KGADvaJSD20Gi/mRBKAff9DouCbleMTk7D4Xg
	 6CvUMF2YmxwjI0VOB5ue21GwIimNa/8iNQRiJNqz7+oLuvEti+tQciJ7/ty6p9/nd5Zo2
	 7+axs+hPluEmI/x3p21nHRcT1/3dgOtW4X1mHZecQ7PkkJ3meQxZcQUG1it/Meh115w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I/48tBQGGecyBnrfvXGSQriF6SeJyqh31wqOzSFfeQs=;
	b=SYD09SN3DSe33biTjk/20Q1rh5yPJzgBhOrZn4uD1ZpfVnBHgcXxPseQnaGLSaUFS6iK
	 ph+Y6ttO5tBVvK8QLc4C7+GwMBfuxh7QZ8Zz71rDjUCYz8LpEqwlmPV7R06D/3/1fEWQK
	 CueyXligfdWG+ddJZE7W/DI+jso4JfK1u6DbKLTeb1QbeMTIEpXqcsjBCqyLbgCv6tIj/
	 CrJ5lMuS8entZakBffeIQZpixITfumNhu7ETWG81KwBUXmaz8YG/+9UEwZv192XoNzs+Z
	 1aaFv1/SQuo39HTYgcFs06TZAyMnAkODu+ZEfF/cri7oKLcxYghBXZ/WoTKm7WTemlw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878571;
	bh=I/48tBQGGecyBnrfvXGSQriF6SeJyqh31wqOzSFfeQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0jd4QJEOGNBIg1HN6+dal46gXgzYwxh+RgsC7qEy1aCnxNYC8+nttNAP/JfKnyYlU
	 9VJ/93KqtMd75VhglpiD3ewTIO40PYgd5XtnbxGOT9dQJQOxDuap1u/c1rhk4s/XZg
	 LwNrJWfzmtZfA//yzhahVgvHN8J/4AMJWbdXxM/pqGtdO1HB5OZHcHZcVDD9OA7SdQ
	 a1hEp2RMylfcTybki/kafGH52Sj32U0OhPayNWde4wveDnCc6oWRmN/aB21mB3/YqJ
	 FXXirZOiC2KtVviMc0WSyMy2dyEf10bWzqebN3TgCWBMHLarb59FWTrdB4ov2sYrPR
	 2wZS8n8BtkZmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D265405B5;
	Tue, 13 Oct 2026 08:02:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 94350129B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A1D380C72
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wNE18wt6amWv for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C784580BE9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791878568;
 b=ZIHrgDj1rgnIwK4ECgxTwQy5HosQjToqjMeJ+pNU5Rp5oTKyYmJnfdE2Y1S2XJC4m9/s
 sXFXOc6kspFlWD1UxBf9gcHJ59JYGx47yKod6Qgcgax5FxIJx/PLTZSGsJE1TvyQYzwPh
 wDb4QQUkigFD4bVIJSE8QwfRiLWqkYFv94v1Jy+wecI7BaPpGTwJjtMcI3yP0jXuXNAU+
 accF66u9lOVIK0qu4Iv+q+WSdlGVICH0Bj7XV7aOPxADXOV7JPUmqbmXwuggneOhwrKfs
 FxY1xSoqH6WhQiNO8yLBLyI4C2EKFKu5XStpBvV9TQffUsblMysvAZu2VbRP51OAfEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878568;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=I/48tBQGGecyBnrfvXGSQriF6SeJyqh31wqOzSFfeQs=;
 b=dIAOB1fWyxNVp+ifQy5LPvXy/nw/ryo+KB2XIjTAGLgUZAmUQRP5cHBb5VFmJ4uJYni1
 j14WnqjpmV3OOKBgBGQS7qy1Odjeq0iWs+KZcZ191XrT11qEF9NScKe5HsKnxLzGu6Qlv
 Ma+sP7iiCr1s85HyAQoSxecHHTDlOwQCwJ3/A1FcKzPsqmt7uIHGKsoZU8+46e8ix5xyA
 DaMPUVs61J78f5wzAHOn1uxnRwohZU+Nhi2eYRWZDwItgDdmbXOSbOeQnyc1XyI3tjrrs
 kRekcdktGySy29mzvUmkrV9GNa5RuTQJd8N8wWwt3FwT5KI72Vhx+XoUfch2pLxg8+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PfWv4s7m; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PfWv4s7m
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C784580BE9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:47 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ac451e128cso184605a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791878567; x=1792483367;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I/48tBQGGecyBnrfvXGSQriF6SeJyqh31wqOzSFfeQs=;
 b=PfWv4s7m/rE79uGlmipEHHOwT1bbbWm+kN1z9zjo3FIe8Yg8vH28IrJ2WxXKRiAfuZ
 otOrxNYySY6L9qpGHhGtPIwSUlq+iM+2ANy5uO7QFfYS4ovaiYgmV4fe8ryJWf8ghqlo
 63TFAAUDgzx4x9INic8fpGObvi08ZyLkz3ZARjLSd9OKxsPS3jb40OrseUHNuacsDWFe
 AoWS2wlPyqhcxq8XjRIo1FbhGR+zse7/To9EJ6sEqAfv3f+P2GYPFypPuBzptLdDFvFo
 f5wqSda9O8/6Lu6sAJ9psm2zwldLh2YZE2jM10he27hm2wXyBIASUebJZ7kbhve5qd+m
 Cq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878567; x=1792483367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I/48tBQGGecyBnrfvXGSQriF6SeJyqh31wqOzSFfeQs=;
 b=TqyUZNhpvfU05URdwZxG69Pt5iNjGVJrOrW/YvIbXLSHiQE27g//6OIxl2fL4+iETk
 2MqBJTuM3VXGGs5ixTRXxpcnEU2QxbTSACPg38xMpCAya5jMDXVI0EaaVFqcYT8TYiIR
 g5O2tN/MORduI+Shu83YBG75RRopQu+cRpktfDXfIQK61Vjq2TkHXTrVsPkvbHxxZX8p
 dlpwgtmsWqGuu30XsZqx4YHrhNSRCSe6C87J0xj+DcWachGlyC7elbW9+/5PNUFjQAvc
 kBRzkLw31O88PjYIhQG9jjBcE1mrYzLzL1n+4aHsfcQJQCN4dImUyZMYfwdTs/rTtmXR
 yN+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBznr6tksrbNFSiRUNG32L8wWLgcsxAykU9ud+E5VXFZ0IY+757O7zO+t5MPKfLZL/iOlABj6M0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIJ820EmPk9j6gfA+eYkbkgIRvK0HjvrdvaFt7d206xS/cPqrDE
 nspbMj0jp7KEicVjt/WkiFtRKV0B7GZtbtxYh2c/w1ib7qPJ7UeJ29JkgfPIyL9j
X-Gm-Gg: AYBFou1Kcn8U8RclyeOhump+tVvlGZgwBoTROwTaHxvBEaSSyiWETMSPgVBc+vA3a0B
 RL1WA7RoO32LeaKZyILY4KIxKBE7/D5eWX1X+mby9i0Aigdk97WbKT0rK7+s0do5f2UIpdmk81a
 rPCAaY3ivFB82BbzSSd5Xyiu74ICDZIqsPQVjAQmNOSdoylLdvxxhlEl7Krf5sbhjBCrqyqqPcr
 pa6HjYt/k0qQfdGBQgo2Tn4Spugp30fwlmJpx9cKNyGPt51RaU4feXDLPzCO8a4Bs/P8uRZzmvQ
 2C5uYgPRbjEBegMy1221SPgcynRLuml9+6+3bXQInnDmOiCzuQWRfYTyVv63gaeIAZN454LGI1x
 3I9FIA040kfay//eVHz6nqs2pJqmwMliSY//bmZKvK3c6QqbzYDAmdlkatTVfooMZVWOmY5QpiA
 HCLe4pdwtTbCPfS2785L0bhwEWqUjyNShUYGjy7fSMKlrp4QGSmqTvcCv8VuLI4RMoEy5z1Ds14
 3rQdW49d3wGmfKa/wo=
X-Received: by 2002:a17:90b:4a45:b0:3aa:9a32:504f with SMTP id
 98e67ed59e1d1-3ab3a359e32mr7953841a91.7.1791878566853; 
 Tue, 13 Oct 2026 01:02:46 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:502:876d:a213:c5a0:c1ea:6547])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3962f771sm9175090a91.2.2026.10.13.01.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:02:44 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v3 4/6] configs: arbel_evb: enable additional commands and
 drivers
Date: Tue, 13 Oct 2026 16:01:52 +0800
Message-Id: <20261013080154.1942483-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
References: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
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

Enable the following options for the NPCM845 EVB:
- CONFIG_CMD_WDT: watchdog control from the console
- CONFIG_SHA512 / CONFIG_SHA512_HW_ACCEL: SHA512 via the NPCM
  hardware engine
- Enable CONFIG_BOARD_INIT for arbel_evb

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 configs/arbel_evb_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index fa73f7caf10..b8cee5fa271 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -24,7 +24,6 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run common_bootargs; run romboot"
-# CONFIG_BOARD_INIT is not set
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="U-Boot>"
 CONFIG_SYS_MAXARGS=32
@@ -38,6 +37,7 @@ CONFIG_CMD_PART=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_DHCP6=y
 CONFIG_DHCP6_PXE_DHCP_OPTION=y
 CONFIG_DHCP6_ENTERPRISE_ID=311
@@ -118,4 +118,6 @@ CONFIG_WDT=y
 CONFIG_WDT_NPCM=y
 CONFIG_LIB_HW_RAND=y
 CONFIG_TPM=y
+CONFIG_SHA512=y
 CONFIG_SHA_HW_ACCEL=y
+CONFIG_SHA512_HW_ACCEL=y
-- 
2.34.1

