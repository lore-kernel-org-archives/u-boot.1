Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2B606A333
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tR9FUsdF;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iLHLsStK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3AFB812C5;
	Wed, 18 Nov 2026 23:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yl8il3eX9efN; Wed, 18 Nov 2026 23:20:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08039812D2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044029;
	b=kpxY4pxwwWAdr4jM+BeiLfgTkt1gu/1dUxcwc4c3UhJYztLSNdU3+6Nr/TPlQG54BZV0
	 kXC06CDrORG4W807RgEAzzbhjHQIGLOOTXIyWDmB6Gk+NSuW4GowTeotWfpDPU5LQSd00
	 QGUCyZekWZh5XthWYISW/Fu2rEMcyPv+N9nCvqXMBb3f5oLjv0/OwPsQEluSOwi0zqwyo
	 j8RvS9pWWRemdmzVOyMjvfD2TY6kv4Ob0gMXMUNr8Uj12M7xUUW8Elfu3910ysrSP1kUd
	 0nYd09GUdXPoOsIG08WJo8X/GuNCn1dHqUOOl+74vVJcEmAmZ+wYl2m+kwd8bNdKYoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bXoRNy5nhYR7YOfLfdeTUeKT6k+qxZVw9q5Y0iVWAvk=;
	b=CqnOqX5lOaEk4qXhzVcU2gf2Dp34Ohhq7qYd2jYcsAf1EuRxoyDW6vLiaC9CrTTfK9V7
	 NpFFFh3j3LU2Sup5RWj1BE4RcTn+K5HiiTkHNDeHiHLfoZQMEAvZ7Ys27KQrjZoCrzt6N
	 MgMtwKRCw+gbTpTLsbb4j1MQ7cEjYZx1YSTZqnlgZzSycfZWY3avuroLdck57aeARpfD1
	 u0n3oeC2wnzgki59n8rxN11SqjMiThQa6Q2FB5y36qovYLhZb0rHb3wRfYnel1GF2W6C+
	 9sg1VzGzfSg7v49T01Zxkhg92fKxMURjueq30xPIgQNTo6vDHcuq/a39dEFEC797HDA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iLHLsStK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795044029;
	bh=bXoRNy5nhYR7YOfLfdeTUeKT6k+qxZVw9q5Y0iVWAvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tR9FUsdFo8g6rM+wGFpLU7U0iKrv1UkZcWfSCEJBj4lEHE3ING3KSqHFoMgS6vmdy
	 yb42V2fgJH0ovYrMULr7tpCd1dWSS79TVX4dkQZgWIo2qLG+ocW55aE9h7/7+slANW
	 79hWnyxs8igMX36EJCI1ls1jkmP1KdtIKDAhsLSz3wLkuAig+AnO5X2VcuV8NudHYj
	 O5JJz3aVZ+3kFjnQy5OquRVxbfCfZqm3fAQ4yNt1ZZg6OBTUpaxMCO5vVIJ1kolXyI
	 Rk/x4Sycno9Jm9MqohWPjdtK6uk/hKY5hm9AFk7MGBO+7PTogHr42d0EfUZcKhY+AN
	 ar+IVdBnaSFOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08039812D2;
	Wed, 18 Nov 2026 23:20:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F3E3122B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB980812B3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dRrTULG-WEai for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 23:20:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 626078128C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iLHLsStK
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 626078128C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:25 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-84a248254f4so929271a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795044025; x=1795648825;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bXoRNy5nhYR7YOfLfdeTUeKT6k+qxZVw9q5Y0iVWAvk=;
 b=iLHLsStKjoG9PbPzL7Ee7JEAz1uS+L9SW7YGJv1lJLC+5zSHe9mKIrwvE85U/AJB6q
 b++LZ5Sqm8xTT36Yv112TR8AY4oYK66dmoAl3IreWq8oje/FUcldB07xltQHkpJgupKk
 zhxyyvgDsdwn4hZi9AUigXtasTKYKZGU44sefmYRjYY05TNEgE0bjuxN6QOdyunihN0+
 LFX+5Ob4q3qazp+0Bvf5Xla5HK6SAdvNFNEV2/YOrYPvsbbyTqQxxF5Z5jpxixOznOjp
 Tg3EVYQGkiOPO1UUvnbrOdqo50bdxyS322b2ynK1EWwllzsUoxYWbbfoVouU5Kp7TblX
 WOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795044025; x=1795648825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bXoRNy5nhYR7YOfLfdeTUeKT6k+qxZVw9q5Y0iVWAvk=;
 b=K0f8iwjRGa91IqqyZwV5j9KsOAB6lRDvSoHVh7DwVLOPVmtuTnWN/RCyC3JeboXPVq
 Gu938UO+am3uIp22twrLgLvFOV1BEwNY9i+Vm9lF/RVJssi03PnST1UBaMHYFFhuR7Hu
 poBx0QQyLjqDZiGefzFLxvWKkmaUMlnd0/bZK7ZZ89FE2dge4Vki0uE99q1QQjRs1z4g
 8vF4tw3DrdlijTZHx5Ih4waFa/E4MMZVekku5aypPt6PEcdl0XAlP8KkW2xkL3EPyNFZ
 HS6Dd63/HrsxOlXKWqybcOMJQzdtDu/ilUS6GN6wHdZwoyREIzm+vaUZs6zxxitcFvc6
 JVAQ==
X-Gm-Message-State: APuU4Z/SCddm2LDykg1c6zBnwgMFLjUNDKmr0cdZQr1W6sa4Rp/G/7cg
 KgOlGxO57eCTuLoREBpRfNEqK3cr6cBB9q8XulZstONbuubcWppvQHPb3dY4b+SlvlkbyDTdYkM
 FlpSxz+U=
X-Gm-Gg: AYBFou0/WF+euEjrsT1epmydYlSYSLOMS+pcc6rNEGB4601GWnacbY0J3CalbzNE/OD
 4uK7LBOzhNAJjGZ51DMpNSsN2uFTRQa6O/nVkHc4z+Ghh7w/ZwIWFobFAh278kxNLQ1o0mJBbUQ
 +YmVT8iuyEInl61/ohAAx/JFaors/XYCid7crlX8TxDfhUXm3batt0y9zdrAxZ2q7yRSJR8v0uy
 jm4uIGcbuICkKlMTZNoAbahrRFqTl+oV6UhcnwpdqaLVy4PwKePTOBXuU0kvpOEeWLFYGu/ckAB
 0cCcKvnpZOsx5pFDSYz4/T5wmUOPBqbMJksac95bPPGMNb8NHOoZX0IFcRUhXQtXJP/20lQjhCa
 v3D1DkChD+LHkRAZZGNLNA2pqqaJ1YFEBspVSm/5ICo4rdHnyVPUcr7JtQvgdvObhtf5GTJxP7E
 xBrJN+mL7kFfTl0yrUJb4OObSsPAZoQxAlOB2afrfJpRnXsrKAxbgoJfuai09HMt4V2XvNh7eeZ
 0rVQnA41cJ1tW3nw2fWpEKHZBO+eILd3hSkzz549AthLCwe5UwUav0XjGhj/m2B0n1LL5pQ1i1/
 pcOjlIOx2ekxZHKRudVmtWoMsufn6Yti53RicrTozsQZNIX7IwGVTg==
X-Received: by 2002:a05:6830:2b06:b0:862:cc8d:abb1 with SMTP id
 46e09a7af769-862f0916848mr4095418a34.10.1795044025133; 
 Wed, 18 Nov 2026 15:20:25 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01d4764sm3025878a34.5.2026.11.18.15.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:20:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 17:19:02 -0600
Subject: [PATCH 3/7] configs: mediatek: drop DEFAULT_FDT_FILE from Genio
 defconfigs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-mtk-genio-one-defconfig-per-soc-v1-3-1505d27fdfcb@baylibre.com>
References: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
In-Reply-To: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5EApQfRk+pD6miwxWgOHRt/79rlJSZLSg7sXctC3vZI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/jKNqH1zOlNr+b3oJafgmoA1dv8xfGO4BcZcK
 5iBRoLvoySJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav4yjRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4i8H/R7NKQq64fzXNHdX1NrCKf8xcHOXCQ2TaM3ZLgU
 W8EBzh9JhBsd4oYP7rwlYAcDcsqqg7FWnLSMnN7kOovoB5cTNtIstUGV2gR8oOo1MzdqGjpE3RQ
 SLT1Cn9FyfyerUL/I1xt6Dhc084OuxYDvbtZVmSyt3A3E2k0or1qtVVFX7iA2jCaF42UrfSpZxo
 Ub6wApfzWjsZSv/uwfvdbwdvqGfhKGT89n6GntBtlmB2h11D3uB/yzU83fySUg38eU21UPO3Qe5
 JBxp+pY+iR3LzfLwBhlQzQnkbUVuxa0THzae5uTcIcH71X6zELyPhS5PcGMWH/fBBiCH7RhtJYr
 nKng=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove CONFIG_DEFAULT_FDT_FILE from the MT8365 EVK and the Genio 360,
520 and 720 EVK defconfigs.

Nothing on these boards reads it. They have no environment that sets
fdtfile from it, so it has no effect. Which devicetree and overlays to
boot is up to the OS image, which U-Boot cannot know, and the option
names a single board, which gets in the way of sharing a defconfig
between boards. The Genio 510, 700 and 1200 EVK defconfigs never set
it, so dropping it also makes the Genio defconfigs consistent.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8365_evk_defconfig           | 1 -
 configs/mt8366_genio_360_evk_defconfig | 1 -
 configs/mt8371_genio_520_evk_defconfig | 1 -
 configs/mt8391_genio_720_evk_defconfig | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index a608cdd75a1..88c6fe55667 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -12,7 +12,6 @@ CONFIG_TARGET_MT8365=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
-CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
index 325adcc8847..c620a0b3ecf 100644
--- a/configs/mt8366_genio_360_evk_defconfig
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -11,7 +11,6 @@ CONFIG_TARGET_MT8366=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
-CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DM=y
diff --git a/configs/mt8371_genio_520_evk_defconfig b/configs/mt8371_genio_520_evk_defconfig
index 9a5e68e48ee..612cbf3783a 100644
--- a/configs/mt8371_genio_520_evk_defconfig
+++ b/configs/mt8371_genio_520_evk_defconfig
@@ -1,4 +1,3 @@
 #include <configs/mt8189.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mt8371-genio-520-evk"
-CONFIG_DEFAULT_FDT_FILE="mt8371-genio-520-evk"
diff --git a/configs/mt8391_genio_720_evk_defconfig b/configs/mt8391_genio_720_evk_defconfig
index 3fcd08be50a..d1ca4f3731a 100644
--- a/configs/mt8391_genio_720_evk_defconfig
+++ b/configs/mt8391_genio_720_evk_defconfig
@@ -1,4 +1,3 @@
 #include <configs/mt8189.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk"
-CONFIG_DEFAULT_FDT_FILE="mt8391-genio-720-evk"

-- 
2.53.0

