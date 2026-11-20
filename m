Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0072606A339
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KbtW/m0g;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ajni5io9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0B088176C;
	Fri, 20 Nov 2026 22:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BrVY77xVf1Hv; Fri, 20 Nov 2026 22:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 554728176D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212320;
	b=pJGS5jnqfaO6Dj+KSicbPFu3cQtsDTUB+vh2KYNydqWBhDwefgTWsI8ZYOucvVHIA8TX
	 9uM2r+UR0TeVclqoDBw4tyY2b6kaxsLMBo7OH1vE7KCNqJh1z9Oo5rCQBH2H/31w7fbFH
	 60nb95rG/zxxdKiEhy9hWpyhF+BTpOEa82GTM2Ub7sTtFVNzR1RmuyoUQgrJ1UjLh6ub5
	 3qOKkO4SayNeihRQ35omG1QnZsDiBR6b4/hahjqeVbd1prE4b/zBEEF2d+h0f2CQcLzN/
	 v4wfbnNlyOn+rCaGur3LHGgKTlfseQ94yO4e2milZcnMBK3aPVhAFoJnQlCTgbNnfnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nGL8soRwlbSCQsWF8vVPftrQPG7ceS41Ez38Wt1bhdc=;
	b=h4OXvRrLDrrueeGnB41/aDjW09et8VBawMnfz2yemQ30f2IZSpxKuHmU3P+fERIyHUbN
	 i7n+sHvOn1AUmQAFya2ZGW93qslQxCPnMC6ZucELpxJDAqoW9T2K8oXO7JoB3Sms+zcNn
	 1SbwtS6M+M2BmjY64DU2Dfubv1dRMxSPgsdB0JKZkb1H5BCaILAFCk9x0TDryAPOwPkep
	 GeP4V4DRYMWzfIvonn+y4AR9A1DSNchnnvLYWXxCBxBTibotc34KDD7W4jhTTLrlHm64H
	 S9wCzVXcKXuvK3qzPzOdtBb4G1zEkiUn7m+abuE9xx2AN7/TAJAlAtCT4BT7JjNirPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212320;
	bh=nGL8soRwlbSCQsWF8vVPftrQPG7ceS41Ez38Wt1bhdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KbtW/m0gA7+ezxA2HvDVyZi6BzDOnnFdfESO9F/pk0uk/3MwPj5w/Ruv6RkUvo4MS
	 2gfU4iHqaZ4kkgURMQC/Jt3B4LWh2A+x1d9dd1HTKWByUH23r0j8YUMe0koc+Pr+Do
	 l3ipmubOw5RkEsNxahXC8kp32+rMHZ61Jyz7isjXg5rCa7id2sPcC1FYXTEXrWvNGs
	 u5JIKAZSWF1LQsyQc5DWaeS4+Wevh+EUToGR8fiXwUXQg3QTjkeWtNC36KcKCVJNFo
	 qWlencJqut2yy4Ddw4HE6FKvRNRuaLemV0aN/v5/RlaNd1rlgL4RgSYfU4VPFHQssE
	 4252o5xwYy6WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 554728176D;
	Fri, 20 Nov 2026 22:05:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F030B759
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E239C6069C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbnvAmjHo3vU for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27D1E605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ajni5io9
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27D1E605F7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:15 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6aa9606ddadso916159eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212314; x=1795817114;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nGL8soRwlbSCQsWF8vVPftrQPG7ceS41Ez38Wt1bhdc=;
 b=Ajni5io9IrDbfy/7Fh2FIixwwAJG95xG0TKHD64ApX2xzHUuj1jlEVFCT663p3wsRZ
 d6Jb2ArPIlhEYPyhxJpxeWffbjDOULCYYi2Kr/EuqJbPlvP0FPRfzlnl/BUPXJwILW7G
 Er2613TEjeh0hVcUGTvXI6RcsRAnJVODpqq9r+doTpJswtb0kGDdQrKI93XeXoj7pCSm
 s9LBFypl089TuUPTw3W/XVMxfgE+ZWBnjR+ZtXT7st3OfefNkuIx4EbkDJgbIX4BIU9M
 qb6TXgCdyrA3IjJE4sICRXl7BUDaElDSncuSbFy7+g4JPqwvTpp96XQUWjgs5KPqpR1b
 PVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212314; x=1795817114;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGL8soRwlbSCQsWF8vVPftrQPG7ceS41Ez38Wt1bhdc=;
 b=zzKt9yWfJek8shfQguTLgcm5aPNQQr0ckSOpuN1VHFJ4lRGoYMtOIjB4CWrLujqJ5k
 YDzQW0Z1HKDZ7S8Ugn0KkCjRex/LnXPfxWSGA1s3R5gbd4DxbZEW/5o6p6SpQTJkOZ1u
 rm2YCd8AKawWb1+XDErGdasyZir1jM+mcfv5Qju21Ff4qrQnwkNz70wQXL66qsnvPGcV
 rDy6IJCQW1a3Z8y6EaIBtv0phxEJW4thW2vu5MBalYrN1Opwm7KN+3kQGhTjEIIFg2UM
 8FO1nA496wZb26w5bEkPVqWN0ZL1TnAAm94Z8IFps7DqpfvKjOA/y84q09FzVmt6W1UM
 yUyg==
X-Gm-Message-State: APuU4Z/p4bRHYYLcsSrsorugC20e/9Phes9XTbUG8caoiSlgpqgiqIsf
 jO0LcSOY4svCwSu56EZ1E7MPSHGi6O+EF4qWRZO2CLBAQFw6SQa/OTWpvfHt2tOVmmg=
X-Gm-Gg: AYBFou1LTUPemPGgs7o9iooqimCnLF9yuHCof2eTP2rRETliBVwzeLuoaTJrRynpkJb
 q9IaPO0ueple/mZSvn1grMdF5cVbCK1MqtgZHB4TI2mtzslQvNhSNAQBq14a7JN8UVo+bM8oNlE
 VRK5SHxKP/9zy6aK8+ZS2DmM6xt7lOmCZwFeY6CJ4Bqrszkvjdnz65S9jixQ0W6wU6JfKL6J6mh
 tmUn/805/kubn8EyAphdBilS5TwCMeHWU21MwKi/Z88PzlwyRJRjWOGltqntrXLybRN1nWJUE7L
 mdr4/Jb1Q90i0Z38agUzYPgT2GQyNz4D51Pc9a5FOl1hz2vCjT7AGTspkK8TSXZQyC6Nlhzafur
 ZEXfa70uZjX3r7V29GZf6m6j7BBXp2S1sYOiSPOLsOBglTLhi3RDSyhtlhPU7ZD48Am7svWXwX5
 qiangNHTWBHYbIR8+Sq1K0FdAHZuh73Kj1eM+FIuHE8g6OWBsE49TJZ7enBOnNBY54Z6QfqjV0o
 5Aqg+bqrEjXn6RAB2oUdHHP4IU5cWEwLIMmyfeEs8qhPxRuxrxKn/UjEQqNk0Np2+KwwnCi2DjI
 m37+rpRiFVZvwyjsZdlYHsACuu2/QJJBQnCa/YOWb1xTHi4uNA+bbw==
X-Received: by 2002:a05:6820:410e:b0:71a:f0dc:ed4 with SMTP id
 006d021491bc7-71b3950ed13mr3503205eaf.55.1795212314546; 
 Fri, 20 Nov 2026 14:05:14 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:43 -0600
Subject: [PATCH v2 02/10] Makefile: give binman the control devicetree with
 BINMAN_DTB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-2-4fa1894b7e2f@baylibre.com>
References: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
In-Reply-To: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
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
 bh=ytENrGEVrKty3jMXvuI6fOlh0z2dGUFonIkccMaV3W8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMPW/VCInpqmphUI3Hs9jIO5LzFooWmhCCQUS
 GLZmC2tlq6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDD1hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArisH+QEEk9kKwbfamgJikkhUOLiLbhnen/uMW/R0lco
 HeaYj/ZXmkCXuB8YiTVYORh453zSwdzHS1l0FFq7b0S/WeaeC5fvKq9bbcxMpxQQUArsiGksVZf
 tAt4Ww2OGCXuV632Jufbam3SRssvQNzjGMDF41ajosA2mLBBhBDPTy6RaYJXE2kRpNesb0Bc3F4
 ppo5Nygf+vXUdCCvkEyBEVDLY4OShx8rZuaXPNfMb9DaJpIP//8S8TF8yC80s/5WryCyepp+uBS
 K1TSQm33c/oFQ3WIdOQMTp3exZH1o7DzQEBfoNuapb3WiJLC4ZlLKqt7KSVAA6MyvJi02uhh8Je
 ANX4=
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
index 120de108323..11569003420 100644
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
index 38e37bdc56a..cb81dda032b 100644
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

