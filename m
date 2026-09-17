Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359B7C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE8C64081D;
	Thu, 17 Sep 2026 14:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TmqzGUzs4Jjk; Thu, 17 Sep 2026 14:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E3A7B40808
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653812;
	b=bDBEw2pHZor7s1SFfZNp8SsoM5eE25xlvtDYSjMMP25of+GV0V80iJUMHLRAwIf6DbWS
	 t5odWeQDYDkppS62F5GM39+l2V/ARDqwf75LRvzWPVaumZaPLFD+tBeOexmTcWx7iThKA
	 ALtIiO+xNwtkelZ7R95uXbcb8nsMnTHV43XxSckfwGLSmQLq8LhPAxYX7QsXwLiUn0aRR
	 jNwfslcCN/+wMkZGX8UZP71+E8ELpeCy+6bOOz7f7HfgvLpLixXHRmzu7qjgjJW/YLCOe
	 e9Fvr4s+SPdrGVbcf890jbsRE18ZRSC4hteP56PjSAYQX6HZBIa0vt2IifUVuHX17Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
	b=aGaWdi9vU/ebG//6P954WNH45ENgMfRoRYBg7pFUdebjejjObf/ZTktHD+bdPfPWQAA1
	 x/jJHUzrzBMwVfqCWTH9ikTK0E3WO5dW8ZyvG9yFyltAlpqJMpraUVUXzi9IoRApZlsPo
	 jSo7XHXGqHaJ/WPDB/rpfvUyIKw42AcaxKhR30W0FTPH5HC98N/SY62ZrordO3fKcswFO
	 ufacanQPHPISwGTanHBDnQLSuVH5D+qucn5LOHTTdysjdAyrnP+mUsxwFK1w4ak1qoXTj
	 32L+1qVMUmY+9BQIeeWJjn8xs7i9LOsN0zAwD4djM1UTclfR/h3DcBeAll84zRy9HYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653812;
	bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MhQr81VuipJgAT3qN5lC/2/yZJSDVKlnOGnzQ5y20QlJYf2qnrOEaZItGk1/0fEkg
	 TL2D+SagidsclqIjn+xN8VMmXNqtKVdyZPq/IPc4RmKMWL2oUPt7hWQX65tYvLug1Z
	 CXzipKm7l2m7djqjowZ+K1qyqo5uXWd6YObs6Ahjd8f99/MgY5D3DmKERoNtry5WYL
	 349vewrPEVHTnga/+nw4Qu6+HYh8YoIKyEbQhY+1xGc2ad4nZ31pg+vuSn/Zh3YOly
	 +QibONIpR4xQzD2x2SCDq+D8Kwas9lV96dZ7q72BvjmXHYImAYhpRmWeCM5jEUKFqr
	 bwqUEttDXgJGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3A7B40808;
	Thu, 17 Sep 2026 14:03:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 159F6362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08109608B3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5pzI3o4jYlE5 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B35F560B77
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653809;
 b=Q0LwSGC2/iVh/au9WBf1+L1fAnD48MMx7LTSKHEeE/REmcJLitE/vh31sc0jwB0ntWfI
 0VOn3S6KnU6bH3ogpHS4cQxhMuQaaXq5rccknChz3vj45JomDamNMtaS+W01IUVUE6OYn
 g9ItfaEacKcYQ8Fc1WoYqf08kCPYFqGABBau4nwlmrmlQvnCY5ozJ4hV0iqDXyqESMjky
 idX4oq0ej4LaOhyWYup+HND2MhzbzDoM/qE7i1nZD/EsUkptve2CvAsflmNEjT9U0PdD/
 EglQOKAZUKTMHBK0g3Hdbx00i6nBNfzfHydEaYL8TCbfoFa1X+hhEAumY0utqwgx0CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653809;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
 b=cQmTjAKBxlebm5K4K69iy+c2822Ta+80vQGjWKAKeZVFhS0kPkOWJm85xNloEoM9T4pg
 +Ud+du/SNyY96djzGChsW5z28pl8UUXEw/x6An82fV2LMssA4WjX8RtJ5m0f1N0HbVmbZ
 WTiU7n6WazCJC6Daa6DQTMGCdCdapphCZq2PxZ8/2od4x6nVos/fMp+7gieq8/OITXa1g
 7AvKTc4Azcyw4M5vEHutjIaVN9vJ3aWrcyNlNo/nBJlGCrLUvVXCGUXkyH3S66msSF2kN
 F5lQXoPKnL1w0LuqQ2VwoT2dSpkqVVR74ZWq30y7HZ5kErBZsuG19F4gQqoe5JNq/SA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OkEBlqwZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=OkEBlqwZ
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B35F560B77
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:28 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so5509075e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653806; x=1790258606;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
 b=OkEBlqwZQ+gzqbWqufUYdDfbOMv8ZmWgzymAPmEksCROVaLJ1GdhLGeMr09k/Rtf9H
 u6jiCMVFG9hPQ3WH6TpkquL0cbUDayley5jzSFD3N4j7WZJ9k2jI+Oz/U3Omz8uv7Qk+
 zCTDszFtc+bUTRPJUF/oSu2zffNzKB7sy++DWwr345BWWc7NaOyNgA1mfInqJt1Cebdq
 SXeYnikaGQLaxEcR35PbB0o12SFLZ7rVwErrw8BZ8JH/ZDFArHuYKm94gyyhtKU6ayr2
 k1FZrchyu85FpIvqt+C9HItzwxjHW5ix6yLsXqfVSBhk1y8MtIJXYkx/AIp5VFYg9I0k
 fYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653806; x=1790258606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
 b=OfMD6vGX+JZRb/A9lZmn79hd+W051LIUugoJcc6YJNhnoCZLHfI6Woe/+rrWkRIRhq
 cj8v0WeUZwV47kFqZQmXwv+rcYeaSDXNNKhpZDMafCJ7rRpialXt0L27hEVf0WlNPp5Y
 bMk6Yqnc2tLOHYm/TNgAFw4BuqDEfusoK+Nxfiv8fx90iapN5Yr7U3aPiAdadY6Er8i6
 gOtda9v0ppaNQMPJ+rCNGSGGTw+LodHBBGrtM0kYLsaa0PUTXK68FPawDTzZArAgXjor
 AG8OJfNfbIc/pDoL39cqByTuWlYNpoA2Icy5Z95Z0O2ReokHxieKymFnMHw3A5Q9Lazn
 7Njw==
X-Gm-Message-State: AFuF++kAuMYLI1voLWQ9M5kfQ81zKkJeuiuII5MERG0+eqi8x6hMHOTd
 mHrUDRchnaMq58NWb9jQGdsi5UOwudFhLwiELv/W3dhX2+raVy0xrLnOIJrYpZiI6dqLC377aDR
 yCCk2HT3Rvw==
X-Gm-Gg: AYBFou2rwa7xf4Y+8CUaEe9YEUCj0GFCE9Ia+PW9RzfauYQVuPNh0dXyK6WUsFz0hD7
 ojogvZY9iWthOXgLO0LM/mShsHPMaKpHfdxNzyH0LTRo6tpt7b+CWV/R84WcxUZ9+Ls6qk5rrZe
 /83zFrzzJyS9RMMnpNuFfTPSNg7CzYbSWX56niAH40y/0i3FWXZmS8ns2Wg7i8E/4Q62yd/vAtI
 J0ZR/zS2Tk79DlJmzYN+efdR4KM1lNrpcdxXMrTmjgq0w0bYlaT9t17os9BWTdvRwojnm9mdwAw
 QRABCpKD1QGhYw0zSttmF/inkezKxkur/6E2KyVye16EMG3TfJ4gGAxv1BW8r/HBFraQJktsJYQ
 NzYFNb28BWdQbAzGYnN8V0JPByV/+KV+H0+K8GmC8cX3kbzPeIyYXREXK3lh7nJijXMY2aYTKqv
 nGdzGduQKO2JuY3drwz+WszR+TRiOPRioMXXS+iMxn+5leArzahuwrjhVweyj5BsBBNlVppPdMf
 02SmyiabTDctIDCFYabLduc+iFsy/axeL3zoxn0si149B3pxhzt6dI2AwcXWZU=
X-Received: by 2002:a05:600c:470a:b0:49e:6bce:b0f9 with SMTP id
 5b1f17b1804b1-49eb732cc87mr87084215e9.16.1789653805720; 
 Thu, 17 Sep 2026 07:03:25 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:03:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:32 +0400
Subject: [PATCH 11/11] rockchip: Choose FIT payload compression via Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-11-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4829; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QWsAABfLAh8kz/zwTprM6dgu+I0p/I/j9JUkVDw91Ho=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vT7n93knXtOrVdfkncz/9z803uebl1n9/1wqXzn8
 wdK/kKbhDsmsjCIcTFYiimyzP22xHaqEd+sXR4eX2HmsDKBDJEWaWAAAhYGvtzEvFIjHSM9U21D
 PUMjHWMdIwYuTgGY6rmPGP7H3mWO92r7tHLS661LeBUNHTY357ocSPZ1PfRzp0HhbudsRoYpaZ1
 FUVdUJb7MD891Ed0o+OjdlYkOksu0Jbp/3dmk1sUMAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The dtsi infers how to compress from whichever SPL decompressor happens
to be enabled, so there is no way to ask for one in particular, turning
a decompressor on for something else silently changes the image, and the
conditional has to be updated with every new algorithm.

Move the selection to Kconfig instead, with proper help texts and support
for all available compression algorithms. Each choice enables the
decompressor that provides it, and carries the compression level.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/dts/rockchip-u-boot.dtsi | 16 +++-----
 arch/arm/mach-rockchip/Kconfig    | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4ba6a87e78ab..a72b55cec05a 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -11,14 +11,6 @@
 #define FIT_ARCH		"arm"
 #endif
 
-#if defined(CONFIG_SPL_GZIP)
-#define FIT_UBOOT_COMP		"gzip"
-#elif defined(CONFIG_SPL_LZMA)
-#define FIT_UBOOT_COMP		"lzma"
-#else
-#define FIT_UBOOT_COMP		"none"
-#endif
-
 /*
  * SHA256 should be enabled in SPL when signature validation is involved,
  * CRC32 should only be used for basic checksum validation of FIT images.
@@ -61,11 +53,15 @@
 				type = "standalone";
 				os = "u-boot";
 				arch = FIT_ARCH;
-				compression = FIT_UBOOT_COMP;
+				compression = CONFIG_ROCKCHIP_UBOOT_COMP;
 				load = <CONFIG_TEXT_BASE>;
 				entry = <CONFIG_TEXT_BASE>;
 				u-boot-nodtb {
-					compress = FIT_UBOOT_COMP;
+					compress = CONFIG_ROCKCHIP_UBOOT_COMP;
+#if CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL != 0
+					compress-level =
+						<CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL>;
+#endif
 				};
 #ifdef FIT_HASH_ALGO
 				hash {
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e7..6e98534f28d7 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -758,6 +758,84 @@ config ROCKCHIP_MASKROM_IMAGE
 	  Rockchip SoCs support maskrom mode boot over USB. Enable this
 	  option to produce maskrom mode boot images containing U-Boot.
 
+choice
+	prompt "Compression for U-Boot proper in the SPL FIT"
+	depends on SPL_FIT
+	default ROCKCHIP_UBOOT_COMP_NONE
+	help
+	  Pick how U-Boot proper is stored in the FIT which SPL loads it from.
+
+	  It is around a megabyte, so what SPL spends unpacking it is close to
+	  what it saves reading a smaller image, and leaving it alone is a
+	  reasonable answer. Compress it where the room it takes up matters
+	  more than the time.
+
+config ROCKCHIP_UBOOT_COMP_NONE
+	bool "none"
+	help
+	  Store it as it is. SPL copies it into place rather than unpacking
+	  it, and the build needs no host tool.
+
+config ROCKCHIP_UBOOT_COMP_GZIP
+	bool "gzip"
+	select SPL_GZIP
+	help
+	  Compress with gzip, run from the host 'gzip' binary. A middling
+	  ratio, quick to unpack, and it needs no SPL heap.
+
+config ROCKCHIP_UBOOT_COMP_LZMA
+	bool "lzma"
+	select SPL_LZMA
+	help
+	  Compress with LZMA, run from the host 'lzma_alone' binary. The best
+	  ratio on offer, and by far the slowest to unpack.
+
+config ROCKCHIP_UBOOT_COMP_LZO
+	bool "lzo"
+	select SPL_LZO
+	help
+	  Compress with LZO, run from the host 'lzop' binary. A poor ratio in
+	  exchange for fast decompression.
+
+config ROCKCHIP_UBOOT_COMP_LZ4
+	bool "lz4"
+	select SPL_LZ4
+	help
+	  Compress with LZ4, run from the host 'lz4' binary. The fastest to
+	  unpack and the worst ratio, so it suits a fast boot medium.
+
+config ROCKCHIP_UBOOT_COMP_ZSTD
+	bool "zstd"
+	select SPL_ZSTD
+	help
+	  Compress with Zstandard, run from the host 'zstd' binary. Close to
+	  the LZMA ratio for a fraction of the time, but its decompressor
+	  wants around 94KB of SPL heap - see SPL_ZSTD.
+
+endchoice
+
+config ROCKCHIP_UBOOT_COMP
+	string
+	default "gzip" if ROCKCHIP_UBOOT_COMP_GZIP
+	default "lzma" if ROCKCHIP_UBOOT_COMP_LZMA
+	default "lzo" if ROCKCHIP_UBOOT_COMP_LZO
+	default "lz4" if ROCKCHIP_UBOOT_COMP_LZ4
+	default "zstd" if ROCKCHIP_UBOOT_COMP_ZSTD
+	default "none"
+
+config ROCKCHIP_UBOOT_COMP_LEVEL
+	int "Compression level for U-Boot proper"
+	depends on !ROCKCHIP_UBOOT_COMP_NONE && !ROCKCHIP_UBOOT_COMP_LZMA
+	range 0 9 if ROCKCHIP_UBOOT_COMP_GZIP || ROCKCHIP_UBOOT_COMP_LZO
+	range 0 12 if ROCKCHIP_UBOOT_COMP_LZ4
+	range 0 19 if ROCKCHIP_UBOOT_COMP_ZSTD
+	default 0
+	help
+	  How hard to compress, numbered the way the algorithm's own tool
+	  numbers it. Leave it at 0 to take the tool's default.
+
+	  lzma has no such knob, so it is not offered there.
+
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default TEXT_BASE
 

-- 
2.55.0

