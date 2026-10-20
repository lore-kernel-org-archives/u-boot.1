Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A2606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j8Ar11KI;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=DdXdg7vC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0E0760763;
	Tue, 20 Oct 2026 19:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CCXLidW-gehH; Tue, 20 Oct 2026 19:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 09EB06074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792525961;
	b=hfAjNyB1hlVpChlFWflXIRQGY/IbKZchnNiWooysLrAvzQQYwFGIlcYmseN/S2+ycd//
	 dLjHSjqTEgP803R7qlBCfMizyfijDqaQcrNT96VA+8C5zlDhJwRS4uBR/i2QyH0uV1IA+
	 izrwFqScdCcLAYlRe7KcrOQYYeQko5qovRiHRUYtwDdDNfotL7n4DjZwjgNNfXAHlS+dS
	 tRdza498afj9jVvOJYmvkWbs2S7YJ1LHAVtb9NkU3mqqH2NCFTiLz4BXuCR2zNTHdIfvw
	 SLS10g+uMFlUGXxd66NA3jKb7xk5rapLosoPpD6dI0y+Aoux+PlrTAvF/5QFzs0lQIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792525961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qZfm550VSQNrXJ459InkQT7Rg/szOanSnT1i90Qpm7s=;
	b=K/7PKpIDj0pMO50HiTaYjq9OPmTVZDp54SBCpOuUMozTbwp79XP45wH7IJubHWM9M5Up
	 ItZzRQKCef94+7I+qXz2OhrKDAbZBKWGqKQsNSYSylp4o92+fOoUgfanWsFbfbA8pqWCO
	 lV0sxiP40KEyvOFzAxaZJEsYKVpqjSHdm4ew1rOTWjtOZdODmV4xS+yMrqbACogOAWjd1
	 9/tSWUkGT7blT7MycipouyeoiLTpzK6TK5teZIW/HNSiaBjJLrtlkhYdCLCpggVC+HQiY
	 FMSnhB57fQWpvt4GJFhhgsEah8N5bnZpl0xXRXcmV3htzsTuaUA73cD7j3gHFz8ZmYw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792525961;
	bh=qZfm550VSQNrXJ459InkQT7Rg/szOanSnT1i90Qpm7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j8Ar11KIz1NT3ZV9eJxXAcwsiaHiBjOAy+JTlbzTerXiZca78m6w8fpQ2YHWWAJve
	 XAYnDRGj9DvDhk2ID1JgBm3380vdJaLRSSU1NALwoYFDGpkOX6uv5f8U4zZkyOLe7W
	 KvO8EUzPq1YcKIJVOez9a7lHN995zDU4+sg/nIW3GGVgtFBo93R/XJIiy6xTY+UYBE
	 Y8APwoQFu0ssVdf/Jgey6cVSNlZ/Oai9X/q7tULFOmtk1YTUDYLrXYfDtfkjVjcWiT
	 +lRpiZpRnZAxQC1KzQBp9aTwBMYFOKxuX2UIgr65HOWeRwR3oCDsL9khGvle5tg2ts
	 U5Z5k1eSV3/2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09EB06074D;
	Tue, 20 Oct 2026 19:52:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C69B255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 527BE407C4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5psyZrs5Fb_M for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 19:52:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8416E407BC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792525959;
 b=tCSqv8ncObDOtlQD5ZqF3RBYq2aXJnPqLzI4SNbx71M5r9wt1YNArukgvdlfikJYNfsj
 X0QOC2tpfkihcIw2LPnasPmot0lHaroLxivohaY8qwg79u+Ebuc5IwwbJeF199eSvSAQi
 XBV0kgVVfNM5hQQ0Wd5VhE11Gs26FrrLJVktwcdkuymCEQyXdAaXc2erERizsYyXK2wWR
 HnaGBJsTbawaDjZFwnX/Q2Px799U45i23TAWL9mgiMByLReyTfpKBeP4Pamp4ub1dsdqF
 hD3iMdLmTzlS1+EYQ2a7cXvjV8B3dsF8MtYcX1Pfqtuj2KISTjmTl4ExYo9QENAWeTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792525959;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qZfm550VSQNrXJ459InkQT7Rg/szOanSnT1i90Qpm7s=;
 b=ku6puAn83Q8CLQqynOQAPqgYkykt3SA5U0KlxkdO6ebqB7XvoOUG8nZw2hF8mljygKRZ
 qWJahSe8g4rA+mnvEC6hP0li+By+VBLEWWFNfXTLwjhO10j3nMMOkleyBBfXe3OY03+nU
 fZSET/+F4Q7+qWiEyKWfHvdK69DmTfJUoh0PuahdirMx4oyWYDD0/oN+kwSly059GT+uT
 r9u7Ve3/NU9KeOB34zztoyXWe0NItiGn5m0Cck6PtVugyWazkJA48dMEeBOjr2pf+PIUo
 GtI/N+uvut/nt4y6I7xtOvKGmy8xH4SPyvY2S4u4uox+dsnEkhGOqxJ44VunZ2oIBVg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=DdXdg7vC; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=DdXdg7vC
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8416E407BC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792525923;
 bh=qZfm550VSQNrXJ459InkQT7Rg/szOanSnT1i90Qpm7s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DdXdg7vCrND9HICSdrPRhMzm9vRKbgiJDBXtW2q4g6xwT+t0jrr3tb3nfw012m2yK
 w13bRl+AHkCWYAQOk667+M2G/HBEeJDpXqLiK8NDXnlGWPtmoSMMqWXwx0zzEvT4A8
 raSca/b/g7G0XzRHUHRg6m0UcvH5v2XqaH8wCqR7FLNUevpGOq26Ke+kXP2EOQtPy9
 Y0pJbou+Xo+rAjy7+QsoHcGi/RSfmTM71KfzaUef+aS+Waq++2xQ4V/RnY1MsGBQEx
 DSFOE31QW1wi4LoUu5aEwhySjONUT87XyWjfBvyJoLC+xi6EYtBX5Lavyd2kZQTZO3
 Z8bl9Ffdy1Enw==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BD23FB2205DC;
 Tue, 20 Oct 2026 21:52:02 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH 2/2] configs: spacemit: k3: enable mtdparts on Pico-ITX in
 main app
Date: Tue, 20 Oct 2026 12:51:11 -0700
Message-ID: <20261020195126.1325187-3-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020195126.1325187-1-e@freeshell.de>
References: <20261020195126.1325187-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

add default mtdparts and mtdids consistent with k3-pico-itx.dts

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/spacemit_k3_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index b333e708d01b..2ca912556a88 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
@@ -36,6 +37,9 @@ CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
+CONFIG_MTDPARTS_DEFAULT="spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"
 CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -49,6 +53,7 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_GIGE=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_SPACEMIT=y
-- 
2.53.0

