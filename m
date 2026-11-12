Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC21606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fkVTQ98R;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kcjAs7T6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36D7C8175C;
	Thu, 12 Nov 2026 21:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IK1Bg-IkF10K; Thu, 12 Nov 2026 21:16:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 606B4816D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518194;
	b=mpuFqrLMHaNLmD+ulSImB6EBMZWLPGA/NQPaVLkCJX2xnY8HGHQ0fnJhPMx72LUXx2Od
	 bpL6D9jr+btpuFxMDBo6W/gwkFhBoxBHiqSplU4bzRHyehXHPe2ocbwOaSnZENo5PEjrX
	 /xrdu5YPLpjToUTS/bBjOb/8011QlAx/T34OrthF6r47hX2OrSH8jLj2u7dMGDbWyUNhf
	 sNJnuQo7zngv3OejlGg85X9s+AB0pk6ajk81zc3T8gm9Q1fjHknTqLs0jnJJgDsVM5mTR
	 /zcfGXUrDsEiaI1SzEHR1X0y1n0afS77MqxjY3bAMuI14arcY9r+Wdt2+8pIn+7NrOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GyLN7ODR3gr88KvVaHw1nDuw+gPbwW/jTDEEJtROePI=;
	b=YqA2vmmuHEbKobHVWN5cFbIeeigjUaMYnb2hWS1ZrSmPY0RZ1ArfdgnYm7GfCGG5aXj4
	 nNwVe2C59rr9rvV2lrlUlk63bGQqaKgTz61y+Z/yEV/iycJSuOtmHgH6CUZ0XG7bJPJLN
	 IXNTsPRNyVdHAoYXySnqgs4WvA5O8dOsuzL224Td3z+SXH5S3e9tdoY+/B+9SZ9puOvyE
	 vpBFcaTqzTeBCrAsuL/NMXa5wxRQJmpDRGliZEq4OvADawbYP9erkKkW8kl2zY5rBMnLn
	 qtFU256ISmzgb9XKy1Sgm2R1K5eB99P/ujLkW16z+9yuOnsMoVOO/MKHNr1ID4u6zMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518194;
	bh=GyLN7ODR3gr88KvVaHw1nDuw+gPbwW/jTDEEJtROePI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fkVTQ98RKBf+wRrmceRRaEO9E7mhttH5Q3GHhluSnV3JL0hEAA4GAkR/W9wgSqPYf
	 AlYL/LHg1BLHoeqGxbkDN/lq8XuDD9aP+gxXTJlMi785ou0/dd1Ujn60UGVTOzBQln
	 +WtkiU//mfRz4n5TuUFt2HlBdKd6p+wcAquzL54ywwWoaBskxvaAKH6SmJrwQAt50U
	 46aMcthl1I/2Q5e/ki2MOSgL5QFq2Onx0wU1XFRAH538OxMXULJMWAlYfp7rXeI9IY
	 l/WSmA++x0eWLUeJt/apW2ZTRPdRCsb2x0C6SypSn+20iQqX+Jk8g3/9jnnSsfjH76
	 Sm+53b+T4V4rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 606B4816D8;
	Thu, 12 Nov 2026 21:16:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A8C542E5
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A6C44095B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B7oymkPl_dhO for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A16BB40940
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kcjAs7T6
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A16BB40940
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:30 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-55650fe1f0dso197330b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518189; x=1795122989;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GyLN7ODR3gr88KvVaHw1nDuw+gPbwW/jTDEEJtROePI=;
 b=kcjAs7T6FdQpunOjnvh/awkJsk3tPe9M7t7bu+UZhGDUL+J/w9lIwrra2GAQm4cy5T
 LLnfFIl2NXMgLge77AG9IfMCRzmOzMpgYu9j5SApCWvrlWMAO2apAKeY0kcW4RDdLduq
 4LlfYfiAJ7o56RFrlmWp2D+v/DMCREftOg68rb+YldTrURB7BEjDCjOGNrauj2684Mnr
 8xG8WczaCxQzYtZFxamiwuSFDOC330Ljdcoy/qKGSW0yGIdHo/8/xmAKTSHKg1gEBING
 UdRQu54F1enl/po31dpYwfrT88sfdShihCo63Vg+z1eDa/Y4idNdnHrfooEVLkB/H9xf
 htxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518189; x=1795122989;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GyLN7ODR3gr88KvVaHw1nDuw+gPbwW/jTDEEJtROePI=;
 b=gsdQjCAigESi1+yewOnZXzYoDYZhPD4A01n4mmG2wnFbyy93SwJagw0bW8tYXmMBkJ
 ebnF7V2EzBv4pObLLHpxJC77RC95fL/nIFTAOYe3VquEO383YOxBwiuqQ9pvHKqRujFk
 zhAGzpi9I9m2xOSWOpDRWPmQtNruYC6QKVL9u4cKBxdoTkV9HAWACZrbc+ysYAYoPVq+
 OxX73M4f97lnjvUm0LAxD+o+K6Y3ANBT5hVUHdK2fg4UDerhfEhAJdInx0F5+t/Z6++5
 NedToSmPwGy1JKdYYjILZnBX2FARtZ4ZFlqY/ZSyH3PXWhJKUO3qVOc1hqia67GUW9Ud
 lVbQ==
X-Gm-Message-State: APuU4Z/Q6FQelAMdcQnY4XI2XgW2tSLHc9O1yiTDbhpwlsSw1aAYczEC
 GSuT4m4vFG9rQnQTLPnpUTJgany4NqRQy6oFm3RgkcF9oax255qNB0n/gUQzMAnNm6s=
X-Gm-Gg: AYBFou1Odh9E2vHCkXUJ3Ez3NFrY9XbrYPuR4NLPBl65vZGsXg7PHVEWfmjcVfmHOH5
 zWHDTMTIL0/5O3K7irQq65wWYEOFMRYZ1C6YhMnlgmzhGlR6TxmvtfiTm875tZJV7Xg4B3W5MDY
 hfdtTr4u2yDfF5iyB/zR6typuL+PP8JmH0g3wzWV0dKt/HIHnYJd3iKFtAqr/6DrCNF7nyWOQ3p
 vp6EmNDXgDTW2v7oAEJk4FxbkcnsjcndA4T7lR9zvtabr02qZh17KiGvalAN3u/nQjiTgL8JhLY
 x0x+l64jcMus2Q152CkZYWEN88YahxNhrcTsfDT6KzhBALjBYmu+1xaemishw+27pz6XOJiGHS+
 HpQpAoL5uRa+Ccn3dFjgfpkguQplK6PDyTlTMoq9kOzF1ZwkjeLDnM5MNPwTqtMRhfndiAddQrq
 CLglC7JfpJF9HOGR47upo+plFncIE6Szf1JUAvmpSsWwzwFg8hZu5Ru7XD1G8ofSgQ/g3By+hdS
 tK3grmDc96tTuDCcsbS5NQN/WMneBsWaLzKGKn1yaKZW8UsmlPmcngDHVDMnu5MoFxbxxrJsNzl
 UAgVk3SxFaO8RpeHlDcAD5nHdDuLUrukFw==
X-Received: by 2002:a05:6808:3012:b0:53b:87e5:8c9a with SMTP id
 5614622812f47-56e62c67730mr565044b6e.17.1794518189095; 
 Thu, 12 Nov 2026 13:16:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:14:57 -0600
Subject: [PATCH 02/10] Makefile: give binman the control devicetree with
 BINMAN_DTB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-2-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=RZ40bzmI8WpJRyOddB90R52QVOwZNBMRFYy1YUxqSOM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9ixpP51wwXbGxRXLLazX8vwOtdJFXbL1LNDeO
 IoPQpnSgbOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYsaRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AFB4H/2eG6lefLy/A98Cnb+HBQKj2hcNWvSG6l6AY+wQ
 zvjTPPRWZ4L9gZGxlpzKyHVQ6BwhLYR0VwHK8qqJQ9GAlmWtDe8hcFKE8LnQHBmuE1vZ6qlkYHC
 ih9rj2xyRNE/9RG7FqFJs6S0vQEA5jVt34hdtPBzSQAleA1g5ii9gY1ZJ4ML1iiSwxqqdP0wk1K
 o6ZYcRHpEl/LXsMKLg4ySrgTiXpA72EkZz/dbo8N4zhs1vAjJHaLUS9/g/sUyqpaViDwNzIlP/g
 tW/E+ea8Qnl4A9t+ISjhqXPR8cjM5EZYp1XrYDwvxLCotr6WVT+Je1slM1qx7RjcJ0Hi473y2QH
 wGN8=
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

Pass the U-Boot control devicetree to binman with --u-boot-dtb when
CONFIG_BINMAN_DTB puts the binman image description in a separate
devicetree. Otherwise, u-boot-dtb entries, including the ones in
expanded u-boot entries, get the binman devicetree in place of the
control devicetree.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Makefile    | 14 +++++++++-----
 lib/Kconfig |  3 +++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index e84ee904e0c..4aed514f13d 100644
--- a/Makefile
+++ b/Makefile
@@ -1669,13 +1669,17 @@ ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
 of_list_dirs += arch/$(ARCH)/dts
 endif
 
-binman_dtb := $(shell echo $(CONFIG_BINMAN_DTB))
-ifeq ($(strip $(binman_dtb)),)
 ifeq ($(CONFIG_OF_EMBED),y)
-binman_dtb = ./dts/dt.dtb
+binman_u_boot_dtb = ./dts/dt.dtb
 else
-binman_dtb = ./u-boot.dtb
+binman_u_boot_dtb = ./u-boot.dtb
 endif
+
+binman_dtb := $(strip $(shell echo $(CONFIG_BINMAN_DTB)))
+ifeq ($(binman_dtb),)
+binman_dtb = $(binman_u_boot_dtb)
+else
+binman_dtb_args = --u-boot-dtb $(binman_u_boot_dtb)
 endif
 
 quiet_cmd_binman = BINMAN  $@
@@ -1683,7 +1687,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(foreach f,$(BINMAN_TOOLPATHS),--toolpath $(f)) \
                 --toolpath $(objtree)/tools \
 		$(if $(BINMAN_VERBOSE),-v$(BINMAN_VERBOSE)) \
-		build -u -d $(binman_dtb) -O . -m \
+		build -u -d $(binman_dtb) $(binman_dtb_args) -O . -m \
 		--allow-missing --fake-ext-blobs \
 		$(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
diff --git a/lib/Kconfig b/lib/Kconfig
index e23037f1e9c..edd76712c3c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -54,6 +54,9 @@ config BINMAN_DTB
 	  about generated images shouldn't be the part of target binary. Or on system
 	  with limited storage.
 
+	  u-boot-dtb entries in the images get the U-Boot control devicetree,
+	  not this one.
+
 config CC_OPTIMIZE_LIBS_FOR_SPEED
 	bool "Optimize libraries for speed"
 	help

-- 
2.53.0

