Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32960606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fPYTamHQ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OL+dZqj5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F1924070D;
	Mon, 23 Nov 2026 18:00:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a5h31nn7ClEG; Mon, 23 Nov 2026 18:00:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B2D04077B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795456820;
	b=cwmuM1onGudkbO/X0F+uCxZgUmMrwr4kw0xkRGNz6crZ2mt5hMy+k0uXiqbggstxVdlI
	 u3i+sI/kdyuHx0qifVz1Ick3I4qDomaMS6OZA90KccQEO+CK+hXFX1y8xDr/aECwHQMg9
	 XKiNdP4F21E8j+xM+JV9bJSlgnAOVpP6gHUvgXgSaRYJPTtxdGICT1aFO4mkrPFcOCp37
	 MroIszCi6eiI8mTTsmMvWbRm/heoMxcGFzUqjsPvr0ai3c/VQVOahKcV3SfflHubwhGBv
	 TJqYVXbQ/IKUwVTOo9KhEKJJ8BaEnZd3SN/b9yW98/qCHMAuFIZg4/TGMGt18cawGjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795456820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fTt7UsKkA5oJZZu68KxOBAUGv4eXz40STX76eb0hpBg=;
	b=T1wt28zevFzr1O6HmUCBqA501EhDoW22zP5N3CJVd78tZ7jshh+L24KtYGNEYqBj8S7o
	 D0578JCFViKUZa6Q5FwJAC4144WrVOpeMzJ9c4vtm1ypiU8uigKjp8X+0mwi8HwMJvrij
	 d3s0uSMf3wB3TWCKuiKF5Z3A4vJwVBc79mUqM4IWtb3ey0oak5tV5TmvjoQj0LYojvmoP
	 3F/lvgjk3AUDAzQOFdfGrCtLrHB1ukAfGM33wHxWi5uSvPs70yx69Tek7y8EJ1BFQg8mk
	 Qas9ys7GFqFTCIFotEe7RYI2/D+J1h2RzxUVj/wHafRvagbR+Cp6tPUen1M3MHvsLNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795456820;
	bh=fTt7UsKkA5oJZZu68KxOBAUGv4eXz40STX76eb0hpBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fPYTamHQYntAh60ty5vH8fc7Zkb4JA+9GtBHYsNjaVRy3cnIBJx3mm4k0MxNyDugo
	 1RvingV5SJO+GaogZSFA0N5PW+n/GAD61H5RVxGognRpAiTbRW4hmJbQEG3LgF2dH8
	 a192gjqEB3Gx3AaN57oo+zby4fTW/my2TlG4LJVVda9nwtFOekCD/6K4hakHMK0vo6
	 jeBdsVVfZaz6+5GXjrhJKytGzS2OZKW3oCF2OmIxr8flW2pnl58jhxhzO9olhyZ9Qo
	 djsC3A5UC5o1tWAoZzPrrlnhpZO88DxN3mVOvcYKsVXFQdKSzDWh0MoD+8puXcGAfS
	 CPRvKCypDccSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B2D04077B;
	Mon, 23 Nov 2026 18:00:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49F65759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47D3A60661
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i3UftqDTrsM4 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59B2B605F0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OL+dZqj5
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59B2B605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so28035125e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795456810; x=1796061610;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fTt7UsKkA5oJZZu68KxOBAUGv4eXz40STX76eb0hpBg=;
 b=OL+dZqj5cl9F4U2enLbcV7ldaXURPL234u+Cu/TWUsSCnj5sE2lWetL5aCIG6RyS7r
 qb6opq6OBtmVO6qKA/n2FpNBy/EV/ogAPGdMQFGFfbs95GhTeBndnRkGjKqfaPHEX9lm
 zHbWE5jWVJUC97ZmIhrSKG6xQicxvXrWTcWyQTuEl2tPW8naEcAsYP5KlEY57AMPTG4a
 vWkBJM+NJi6EuL0YY8UPUwk4unZ7kFkOxZ3iN8SrEKGFGhMTAE3t+hUZgOkyB6OQU8Rr
 Nc9hKNbnaRuK61/QhpOCfRZ+LdKj/KzDY97XfUoMKsJu8l9RlCuIwmLu9LeskNmnCZLr
 9j7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456810; x=1796061610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fTt7UsKkA5oJZZu68KxOBAUGv4eXz40STX76eb0hpBg=;
 b=DpgLdakH45LYGXTK6vcO7PJLaZ7umc6TYyFdK70XERlFo/fYXGHXNCVXrZVjwd+v8Z
 zxXS41mSeA2l2rDG5ZamxFtq1vrsIpgGDS5PVXvQL7P7pNzRpUiS2j/qhEz/znoaq0fv
 O9KCwyaXkWSKMgGHn8TvBhlRrxcbTFv59GKXYlsCZBq2Zmy4y+T7HO03USEy9JMpwAHQ
 d84rUmg5QSxlhvp0kNcVu3Jsda3T3O03n3gd+YLBT7zo4sAuibP4LU5jorFUrZLKeWJv
 FVD602R+y+KUIAAxNWnraaq/YzPMNvMeghu5J2MxLE+uDkYDUqiiR6a0J6Njoh8/xQUF
 EURw==
X-Gm-Message-State: APuU4Z8Gzaq5ffBCT5pHsVn9irUuYmlUVrzlELx8GzyoOa8p5DUZOnqZ
 ZXHY41O3797KmD3OYX5ktT3ue+Og1D25NTT6BfDofd7EGsTaH6s1j848
X-Gm-Gg: AZFdTZfgWBt+TZbPmOtXMtwDp+lVvwWfgNs8FStsbecSYGeXrwJcJPNGrRqlpsnkyzI
 rIPkMMgESqmonumHFHf9B0GrORkiz/Zv1f1/5Uwp3b9WWUnRt1cApYbi4XyGThm/G3QpMNvLqQG
 fRoSImCsqPZcTP/Y7CtZ0fn0+sGK1JKyC5qf7KuoRBFfaq8f2sdiuWyB0+aeyzHXnhMfUoVUZnY
 7SvedZtSdPDH558QZtchjnj2vzN9fV0JNf+BNCtM1wiBZOvXekGX6A4Cv0zKKCo1B8eFHEnsFnW
 2yAL7dANJxpznY58f1ZeDYKBnfac5qNxNKnJxx4nuLZM2wuX9mc2xeWr6ULTVSy+WABx+QzdrMd
 Xcqro3WEMYPaZnepHhq5govCAQmn+up10/mI9DfTAyHuj2Bd3GaTbvuGvJNWa1HXGBJRhJLguzR
 YLWtCTfrpPXkESen7rYvbA8iWrsQz7OW1jjrnl7/QgvvNFlCMsL8xYGnfv2RReKDV8IIHN1swPu
 F5qr8KAJGFG7b2Iazjx3aYfJtVf4AUdsL/j6GcqtMSodKimo5XamHHOJKolS6MUjYAfRDFBrHGp
 sYdAYMmo6MPXh32mb5RVXDJCNwycGeyz1MTZ8LU=
X-Received: by 2002:a05:600c:c4a2:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4bb88807d87mr262627645e9.7.1795456810078; 
 Mon, 23 Nov 2026 10:00:10 -0800 (PST)
Received: from [127.0.1.1] ([151.51.12.187]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm543353365e9.13.2026.11.23.10.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:00:09 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 19:00:07 +0100
Subject: [PATCH v2 4/5] arm: rockchip: Avoid SPL_BSS_START_ADDR definition
 if unneeded
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-config-v2-4-be23de2a81f5@gmail.com>
References: <20261123-config-v2-0-be23de2a81f5@gmail.com>
In-Reply-To: <20261123-config-v2-0-be23de2a81f5@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the common/spl/Kconfig file, the config option SPL_BSS_START_ADDR
is defined under the SPL_HAS_BSS_LINKER_SECTION guard. Adding another
config statement for SPL_BSS_START_ADDR without 'depends on' guard here
causes this option and its value to be put in the .config file even
when the guard is not selected, which is unneeded and sounds wrong.
Moreover, the qconfig.py tool would report SPL_BSS_START_ADDR to be
used by configurations which are not really using it.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v2:
- move SPL_BSS_MAX_SIZE case in a new patch of the series
- update commit message to patch content
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 86eb5012192..11062c4c5c1 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -836,6 +836,7 @@ config SPL_HAS_BSS_LINKER_SECTION
 	default y if ARM64
 
 config SPL_BSS_START_ADDR
+	depends on SPL_HAS_BSS_LINKER_SECTION
 	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
 	default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
 	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000

-- 
2.34.1

