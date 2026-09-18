Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F81BC982D6
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BF12811A2;
	Fri, 18 Sep 2026 10:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a9_8AcATvaCz; Fri, 18 Sep 2026 10:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 57F0981298
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728818;
	b=Qs8TvtBJlt//yodl/CGlNTQNlqEGm51YP1xmDljO54eL20X8OEk0XGkM9lRCv5FX+Mn+
	 W7riNEpGqiwu7ZJh4nkMiCgDlZsuEPs6q3lEbejYSc037wNL0PL7l66pCK1eF5Rtw+C/3
	 8m3RYJm2U4L+dQyHfJYhjvd7Gv5TZJVNJU3GoWxvnpDrjMV38Y5h4f2BuNQV0uHaYPd2R
	 AZfHXoF2ZVaM5LhgfVqB0zI68SHsaT+TXcTasFsvZjowo3iVY3ElnBkVduwz6Y7+M7cWe
	 4uaUjLj0+5a09iygTB1sROrD00GW+8OJZASxYP5ikb3rNYM04lu/lAk9uEJsjk7SSWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728818;
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
	b=LYSziNZNIb+Z6lwBeA6O3ZNbXxsngoutSrZTSjtPXkyU4kWWY+c3Y792ncgWOcJKWEnL
	 9TeE8vUAXH8YadLET8TnU+0w8andUsVwyX0js1s2qyWOFg2Q/lrBT5wLCs+7rq8xcgON+
	 u+KMHhM7R+zOvFUFuNeFt5l7HsRnqIdQFgpQr9ICuYmp8qrPswVWG/TyBjzETy4e7yMdQ
	 oBx8asC3+HZWgwqbZ7t0XyYMEbwzub66BeO8Q39JjO2IjdIvdsJYyEkskLBBNE0/sWd3r
	 IdTk1kI5is8JjVu6oWAN8MSw1h2yWr3QxQaoDfTVXWP/72iowzkJzFc8d0KB2g/MmAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728818;
	bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WFcqu7c+kl8UQLwFBkPOOlR+JyOu0FjPFMke1BpUQMDQ53VLyMQd73ojMa4e9tmug
	 WUg1Iuo5UMtkn33RgBZFVxcqs8KsJY5LqKjSGNx0y2oyu4qArxSHNkZnZdkfsEHO5Q
	 1CB/q224HO0gv9v8Gbdq40c9V1mjMlojUNdmHu28wOA5g+nOt87bIQPz2vgGEFQZuy
	 n3Q8n5uUcm8kv4Hw7ZvygZRjxPy67JOpiL7bA5VdaZYyYbNIljYGwmdxJOnzWpVhaB
	 qBVps39TSJTa7T41zOJHIhuSvw/KNDJOKI7oPGV4WUD42oRzlXWNnRi7DV+UvzCB5L
	 nujuBHbO+uwDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57F0981298;
	Fri, 18 Sep 2026 10:53:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAA1823F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC92240B68
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whr-zlR3UNfZ for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C6AAF40B59
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728816;
 b=PgX8Ev3zVFEDZzGP5sfQ248Q/AoLlwVYBwNFmE4kNq6Q2WZdw9Q2mbD5WklXFlJZ/Xuq
 JLMgEAzKXnU4kLCyrQzSiM3Pbj32rnN4fyBrA//mFmCYRQpazbSkf9P60snoyYwWC21Tz
 39qc7Kiu55wpMYGLB6vSoLrrQVkr4KgQEQ6sXzRvyNJEYKSaUvXabUZofWKTcKNxSjeFt
 3ubnneKKAAM/6zACT5fhgSLu2UacSwy667iqgl12gvGzWnetXXkfq9b6zGKqsWliQ8ivx
 j0tF8OHYxPJb6pZ+AIckgz8t+4oexR9VzVVWKRGzacB1JbZ2fNCNVr04yWCDfNktXZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728816;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
 b=O8XepzrNA3y9lwIOADVkFoPIyJgB2Ah9bk9Vg1NtWW0oUbu9QOWbJDBOrKPmGoubWiZJ
 ah/jaOO+vf/5M0fJDpcKujw9dgjuYtxIWJ8k/1zz7sjY7jEucVyTiu8ZqG3I8w86sTr+m
 um+PMtvSgshnrqZFbuchVmI+X5obNyv0Xwl40C2MmBl6HhyBQvurprG5kER5mgnXG9DrF
 WDhl5dL8PrMaZoF2el90ANnBOhShkNscSq1qVpQPpQc+jkytsgXZQna/1uRi/Sg76Z8CV
 MN1j4gUKfGkWlQacD4vySo4+9A0GurxALbzET0D1EYB/pd6Tbc2u1HMuZJlj8dwGkBg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=wdg9iS76; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=wdg9iS76
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6AAF40B59
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:35 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so332041f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728814; x=1790333614;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
 b=wdg9iS76ddvdkAV5UECaa6NwVuphA+tZQaH9iTbEIx/SDIPG0jOX7EyXXDTxnP+siB
 /n149EIcEWd9DmavxtbnPnVeHn9SMvOs3w4qfL02ZAcr4pu+DqQeX/JC77QlOIMA4B5L
 +3eEc3g2So+iAHer2oY09oudR8rWipEJBz3eNxOpsTLBYGv5M91RIN6N32QTP/0cLsBD
 QoHe3dXBkESeHX+ogeP7c9LabEfRVHgkulrVArDlmjbbXmfUPInrWRFzQ3y0XacNAyIl
 PdxVOvccmOp9fWyGxWKp5KlnrNzQKNFnj3wvjSN4ytoIDZinZcYOs3xe6HWEe7SVOLTb
 QlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728814; x=1790333614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P6w2zkCA5Mw3+roJm+TAvYc2/9pnsWhaczOg99Nefw0=;
 b=WdzEycJh4T+8Oq5VlA6l8cEtSwyDNDkCJcuRFWKAzlfb8Cy5QpyIYySZTPLyKeemd2
 XgG+PtWxbCc2VhHVzlo8cNqTBsCU48GZVp8Oj3lYeKJ0X6d49CuvyIYPhsXK5zcxNZlY
 AELOADZVn0bGthpv1FiOPH/Stu+x43ECT9NQPCJn850YYoZbsQERK/oeCUBJdTfhx6GN
 I6HkbDpezESlFbiSPccLsZ/4ywFsfUFvpEEEewZEGmpN/hTPgRpabXyymZbMc/O6TldI
 3YjaDtK0qpmiQO0iPaManYWA0vo3WcmDW6Lr+okt9EHDHj51CqEMGwZdwHCqodT6JH2d
 yoVA==
X-Gm-Message-State: AFuF++lVZt7om5+O/6IniQWG0v+D78UsVAandUdmBlIF7DnZwTgBWy0d
 32GcUwMoGDwaHs6e0tDwrr4hZ4yNeRV4DXZJLrN1QSR1EfWi5eplq/MbxxAMUSEBsr8=
X-Gm-Gg: AYBFou2FpbiU/Mf6S5aVJeGYKjspnuKbskuEhuNCOowm6nd8jEhi/e2lx/VrJbrDVws
 xk/OV6+SeAFCg2KXTzjSF6Uzb5qEqMbd9K5LRqVzypsfN50Yy9h0jnBbtjMBDnvkfw5ycxsf/hK
 olPvehffg1uO/55BKUB2Sm8LbdrThlLup29AW6/7ZOw8DJ9HU4TOviNul/ZT9aZt1aeAt6eTH/i
 R8BVzwvoAxRIU0XCy/lO/L4qp9j/HyS6vCeiSRQ//BttUcO5svFr2VBPHxZvZDXaG2hM7eN5JAw
 yXlneGVzay7V9IPqIN5wH5wmA1qthJhGc5fYRpgP4CqGrbBlQ8c5lwaknjzuL0u3DUA9qkcg8ka
 AW7FFlWm1kCVpDqBEbsSgpX81xiCGMpC3cZPxlTkH4bJfSqMoMJ3Z/AIXMV5Ucc2Hq255phX0Iq
 v9uoeBKc7EynfpSrSUy4OAr706oEu1UmpXlVZE/TAjH8ncXpeDKXNeIRm41hMh129+URTo/7x+h
 +vnm1SNhYbmNCvqkJ3V5WVE4hKsFOjwqo0jxUIzkrYKnKez5AfZ
X-Received: by 2002:a05:6000:4b05:b0:487:981:4df7 with SMTP id
 ffacd0b85a97d-4871e227b08mr2551457f8f.25.1789728813728; 
 Fri, 18 Sep 2026 03:53:33 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:53:33 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:38 +0400
Subject: [PATCH v2 11/11] rockchip: Choose FIT payload compression via Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-11-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
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
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4829; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QWsAABfLAh8kz/zwTprM6dgu+I0p/I/j9JUkVDw91Ho=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf/34JmAoFWWn+zBM/GWpRPunT+02/LMqnPX7AMjj
 S4FF1193jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUTzzDyPD5xq1dB3v3Tfy3X6r4bui9UsXWB083RCYHnXqR+EOicrYtw/+i8HS
 b3tZ06709K+55FtSmN7b0SXHyLOg1jv2TKLnwNi8A
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

