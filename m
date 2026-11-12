Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5B606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xk/BWy9u;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IRVOpJ/3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99B8640DC4;
	Thu, 12 Nov 2026 21:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XL4nqzA9Y8UF; Thu, 12 Nov 2026 21:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C189F40DBD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518199;
	b=Y+HpErs9nzos49cQN0/i3ZbIBK+Qqs51Lj4oK0h+vjEzFUQSJi1ztuhdSPX2WP1bwq9s
	 ls2PH1N82MUfd54dSWIqkCMWIRBVKQfEez8dg8tSipI15SMbXhNa92lEkXERBPD2gdEl4
	 NN18f6+2bWqMDvgQaL1FEv9hAxIqVu71Z2W6avnTGl7IScldebKWeP+juou+RyZ1d9Ytz
	 PehH/wKypA4TVAUzi294iuFYbVpO/WSE/J9YJ9ZUBGP2DMTlb4OJ4IsIDZ4JSOgOJvZo/
	 Y08uNczcc7sa/ObjKIlA6z27QMT5dcCiwbw7kX0TFx8U0PTijQkACYKxYIZuIcUrlvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zSPBZcrgHk7YYnqK1ylfAN6q5fR3S7dt+yLZq5Y9So8=;
	b=TQaQLWbGzQOd5jP4YPd46Cs/Zr8nRlNF0YQxnskNIxawszrOG6WgMVa4n9+SzLY3mY9P
	 IvwdaMj75Q+yHsupVHUasqWLvzPXejKXx05ywEim82Hepz84EOnLhrsaN/htj7+RjonUY
	 OKMrS7JCwQyaQlmA+MGmWgaTsnKUGZ0LbhvciILmbhXf++jDjz73+hS244z35+4dfa0WT
	 RH2yw8aXPoH9qI4pjCCxB9a2LNmgzyO1GGUIl98aiqQr3n1Df1XPA+tJZja3FsP38qlMk
	 HdlP+TnVyAUyMms+wR4UxYE2R/mFAN9mNmZPIiz2VE+hJOsdpcAPRmDqSuBwovStidg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518198;
	bh=zSPBZcrgHk7YYnqK1ylfAN6q5fR3S7dt+yLZq5Y9So8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xk/BWy9u2/1kOXoS4fZmnfp7bjB48yilKQKEW5SPkRagwmskdm+WA37PkUzC1wDaI
	 4U7prmUSomLfc+vPgNrsBZhJM1z4GdA8r/sYjEbGSEaYsCHa2n8Rnblz3Zep7cea3e
	 Xpn43isFu7VnjjIlBooW2HB/4ZZevhE+X+jXQ+/TqRXToSGih8gaeImONbsz5aDgbl
	 4RoJDMEaMJL7E8QvFCojeczhRMvUc4OkX0aGz+8YfUJcN2YnMaSl0BEJEnu5i+6FrX
	 MU3DgYNkugZRrZ+oQIHDZVCYBKD2Cb2+igUwQU9y9vJspYrYzXVsPkO8tB59v0cXUe
	 Z3xo9DypyG9Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C189F40DBD;
	Thu, 12 Nov 2026 21:16:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1092DF46
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAD1A606BA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbYpc6m6fzDu for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A3F66063E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IRVOpJ/3
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A3F66063E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:34 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4a451915d8aso238025b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518193; x=1795122993;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zSPBZcrgHk7YYnqK1ylfAN6q5fR3S7dt+yLZq5Y9So8=;
 b=IRVOpJ/3n9gwjKhQiGBYPq6OZGlgpvPR1/MnIfWTZaH4KNs9xq/rZXXO2I87b0ToJq
 0Sl1kPNCzg/+UDPYKeHetz0d5oounTJYypBV1vvevdZ4C/I3FbZXeX/6+ZlAnCiLnXrb
 ks8aa0yJBgoV/SFB+NgqN83DgK9eL/sSRXII9QS0z0QQeSnyAj5+AEllmPFe2GKr8PS2
 UcFF/qqDAWtF5l8koNk/oP7Du+W4xXLqSh+IGT+Omk8Y0SErxj1m3pGDpegl6xg+9vBy
 MDenqCHgObDh1RCrIfZ9+mYVydmW58iKya4D40wJDqCqg7WBEKrGDk6x93jPNz73ElcM
 rxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518193; x=1795122993;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zSPBZcrgHk7YYnqK1ylfAN6q5fR3S7dt+yLZq5Y9So8=;
 b=wLNuwoTCFYoDTKESlyQfTxiuV38B9Yml7lkak+kpPiSs6fP/LrjMVYz0Se5nNu8aSy
 +n4ana/ZQVdNeyXjNN0xDigE7AKeigRuJUKwvBPujs3agxafrdw3FAWGOKK4JEg3iJY3
 w1K0n+GT7mpeR3WrxZ2KA6ZZGH3UiO+3lloQkNM1p6Wcl5zSThQ3ZfiuiVHjPhoyFc/5
 Ybuv+j6e/CdJf2nKmXsh92aEbu9CqzxfHueCrnhBjRvoyimVsukgzfPqOb3/FiCluR2B
 l+o6LnSs05iE7yzWoBCBqaIIxYO1ymzA1gpnHLe16wGOAJ2l9voKowzfCvRsRh/XEV7m
 hO3A==
X-Gm-Message-State: APuU4Z+BDi6Mtvy8NPNc9nWoSA5UbQBAiu7vLhM2bM1ORiYAl54E8hrw
 CEQ+KQRD1BCJYnFZIvYWen5WPF7NWkQzXc6MyAXBh1COEuuxmzRTAFu4Aw0kueRF8yg=
X-Gm-Gg: AYBFou2Wtn0aSuy6Dedrckuesd9pxx2ZQXoCAfa8mSvbUOf/ICfLMHtPmcPRjgC8I9w
 bvVGzXukVayI6aQ8W6SSaIQI0lmKtrmJLTPqJ5mNO6TJGVcITdJWocoicBWsRuylDIjfck8QZvS
 zsdpaEZEbbETNwKcNijoMVrCjLdMHSEtpyedW9nV7LL/9eoEjxSi6D33DrMiopOe26cCvC3mOIG
 XPAsqNJNLlsWMZtqTcjyqkXe8x2kJ0BEknKLIjqvQmF1BpMWo6yNxthpyPFNWg0+R3lrflejhgQ
 1oUdlYWzoXMtJsFSRaxjOFST6g3oNZ4hJ7S0xZEcnKiONTetVYjfMAkgOrnrByK6fySb0P1tymA
 92xAu2ryIHsDz5qk+B+QfTrCTDC8bm/wnGPQN8X2bhDcK3pkTmmfyyAz+yH1l19K6PtJ/VHWgoz
 uKfXh2+EWd24imE638kQ6625F6PmgXZgRkfW21LG02ykApOGFAWMAnf4/9vBmTymb9jvIePiLRG
 bbh3crfMg3xd8WZbDGDnE8ur5SBCfLgZ+FPwqvERfuNusFrvcxyA6HL2gt+F2Um48+thFLGoF7k
 5yBsVIWfPwaX3EQyVdkwKAQ65EmPtds1BA==
X-Received: by 2002:a05:6808:1514:b0:54f:c850:fa53 with SMTP id
 5614622812f47-56e63897d70mr401759b6e.17.1794518193534; 
 Thu, 12 Nov 2026 13:16:33 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:14:59 -0600
Subject: [PATCH 04/10] dts: always build the binman devicetree from BINMAN_DTB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-4-65cfc9329c50@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=lYNhAujKgKnvmjWuEhTr38SZeffGvt6l3sb7n4aGRlY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9ix2lbisrm67qKhMMJszeh3c29u5B/2slt7ZF
 oIk1cjqEWSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYsdhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AIR0H/3qLQUqz+tyAxMfbmq9QMlWYsPZQsWOvltB2LoZ
 2aRmUYTzhDs6MaAgtCAb5ZaCIP/kiBfihAq5LakjW2III4fr8B8SUtdwzyTYTkETyCwxwNBivGO
 NW3bSkPeyeA1Uv1YYIQ4Un04k0lj68P5K8XH4gwTViAOeV8Ju1fWxIqQjc0lZZETCPy3Jmnhlqz
 suJQ42+uuMXhuCDXOHO2/1bzpN+xOlaf4xfnYU5zJ9dEZpQcYDWF46K1pKjUCj8sJp2qpjEsoP9
 /YHEFqKunbIXr7LQmWEpOvOnNokK74B0OElJY3dS1vwmvU0wZjim20kjpFJdfAXheBow/y97b9f
 PdYU=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the devicetree named by CONFIG_BINMAN_DTB with the dts rule for
all boards, not only with OF_UPSTREAM, so that setting the option is
enough and boards do not also have to list the file in
arch/$(ARCH)/dts/Makefile.

Boards that list it there anyway still work: the rule runs after
arch-dtbs, so it finds the file already built.

The binman devicetree does not describe hardware, so do not check it
against the devicetree schema with dtbs_check.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 dts/Makefile | 13 +++++++------
 lib/Kconfig  |  3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/dts/Makefile b/dts/Makefile
index c85a333df9c..58b2617a778 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -30,11 +30,10 @@ else
 local_dtbos :=
 endif
 
-# With OF_UPSTREAM, arch/$(ARCH)/dts is not built, so build the binman
-# devicetree from there explicitly.
-ifeq ($(CONFIG_OF_UPSTREAM),y)
+# Build the binman devicetree explicitly, so that boards do not have to list
+# it in arch/$(ARCH)/dts/Makefile. With OF_UPSTREAM, that directory is not
+# built at all.
 binman_dtb := $(patsubst ./%,%,$(subst ",,$(CONFIG_BINMAN_DTB)))
-endif
 ifneq ($(binman_dtb),)
 binman_dtb_target := binman-dtb
 else
@@ -82,8 +81,10 @@ endif
 
 ifneq ($(binman_dtb),)
 PHONY += binman-dtb
-binman-dtb:
-	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts $(binman_dtb)
+# Run after arch-dtbs, which may build the same file from its dtb-y list.
+# It does not describe hardware, so skip the schema checks.
+binman-dtb: arch-dtbs
+	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts CHECK_DTBS= $(binman_dtb)
 endif
 
 ifeq ($(CONFIG_XPL_BUILD),y)
diff --git a/lib/Kconfig b/lib/Kconfig
index edd76712c3c..d4e876fccff 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -55,7 +55,8 @@ config BINMAN_DTB
 	  with limited storage.
 
 	  u-boot-dtb entries in the images get the U-Boot control devicetree,
-	  not this one.
+	  not this one. The devicetree is built from its source in
+	  arch/<arch>/dts.
 
 config CC_OPTIMIZE_LIBS_FOR_SPEED
 	bool "Optimize libraries for speed"

-- 
2.53.0

