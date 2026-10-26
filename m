Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C9606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C+0kht79;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=agrcqQob
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E312B60706;
	Mon, 26 Oct 2026 23:47:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utS-GRxxdl83; Mon, 26 Oct 2026 23:47:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6ECB6061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058420;
	b=Y4xDtpMQYIrpOXVWtxXXc+JoA8FmQoz2mRF6qxkZhAj8rdKTxJIO/T4BIZnuPjQXEdfy
	 irft9pHQWp7uKdw59ygRiHkKh3/m5c5druLY/oGudkLgrc/dLoOI9haQp/D3q4wbuwEpf
	 jXbB/q85x92hG1hZmaI77JSOEVX7rPEG1JrSbBCkXDLNug8B/3mnIOJ+28WgOpgcLsA5t
	 KEGTkMj/tlHPYZL8oFB+SBKL19c6UTSInmJzNpVkAvsPWqfjQl0mB8YW6mvoOpNPsJeaj
	 47S6oymTtPoV6OWycEomKf9gbVHOP3jbJgZlxhwjYAQUhmwpmGUB/8ylMcgToHhzUaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=v842iKKBTz+xpkXAKyRP5B6tbVUkmaxttCnuZA7PR6k=;
	b=Da6+OTL489vkGovr4MbJ9usGxzqgjyD1p3qIhbCNF8pOdB8qOu74NOL/1mfo52wb4O4u
	 bu15O9fcWgyDJ2eFGhjeV+DhGOH1Pe0dU8knNWLHM/sgHj/ZsCpGOqo3fxySIb+PprA9o
	 yXJJaj4U058NYWXJjcfP1pd99/kNtz8utrm7Honly5IQqU1HYy6qeI8YNuQH3De2kzw6p
	 pLpnTAQK53TeZ9/6V+DwZn37/frZvuGCXaDeRcHanXG126AAwZ1bHKQTZN8QgTot5Opfu
	 MSpLU000tQb73dZ7cI2FUNGtGDa+mrZO/YKKhpKqnYo2U7MuLBfA5luliAHAsTDWNWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058420;
	bh=v842iKKBTz+xpkXAKyRP5B6tbVUkmaxttCnuZA7PR6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+0kht79uXHVjLCd/afmKFxipWla8Lspa9DuQm3a9M74EAKVeRtIL6PGrgjnxh9XC
	 TZ2YhLNUICu4l9HlBXtmH32ZsDad7fSlLKDbQyUaFBUlbIKN2X6JuTPmmCSfVc1Sk2
	 GtC0gEjKGSECtgiETx/3AOBboZ9+wGZcOQbJxWSkxUWwRGv246yFIz8J7uzM22Vvux
	 pnlhYXTYL52LP5ng+upzvehOfxn4Pb7sJ769YLFgzynhh1ChEv/IBEyJkmXwesCjsI
	 PByriOI8383k7wtP4SHhchBDynOTeMunYV8vn7jd75o4EJT2SuOqZTnQa3Xl0xyQoX
	 FYtT0YJ06dMjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6ECB6061D;
	Mon, 26 Oct 2026 23:46:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B323B356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4FC840205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEfyVI33Fnwh for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A96F240062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058410;
 b=iFyHEyVZ0bRa/Kv8shyOr4g/SzikcUnz+PVzOG4u9fJ5IgAuEeA+ukge8qW8rc3Ir7c+
 Ox6AdhuSc3t6sMqpe9wYhkKVD0u3b+iqilyzXI56zKuKtLNULF50WbbmyWbcvdZe7/jHh
 YP9aVabURVDFMNsP37ZzK4dJL/PNAKh2u17AXesYAjL+RELOvsrlnCFYE+0gRvlDmxug0
 +sS92TZoSBSHOWya6xwBpKiDqqya8AL9hvXfvXVmaHfvpZ+BtTzDXn7ReC+xz5k5kGUYa
 sEXA3/qSo5Lc1jpAF7JH2bWjJyQtwVymv9PiZQNpuPFdOyjfKxqiV+hWSJks0trxpyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058410;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=v842iKKBTz+xpkXAKyRP5B6tbVUkmaxttCnuZA7PR6k=;
 b=gnEKfjxzty4u77w0qevXR0HMAvqwO+xs3qiPVR1+dVF7qEBQrDLS4kZY2FaN6CTVF7bI
 K4CZHALWNws9K3ugr/C1U/78NT8gcSQlG6waizzGV1rEFs238NKbBVW8iKCgyymZq9o1V
 8IENhO+AiyZXtO1CwFP/Rs2XU9Uy2fTv+B2QIlf8BRHbYcPf8io2S8xuq3OXe6l9qNNYI
 ShqQaZUYmW5BFwwA8Oy/yx4rE/tc7/U9JUQd9zD9oVOCAder3sRHr5KATXc7k/YG0N2fI
 yOZExkpi+uR/HLzlubJTK9dpiVH55FHkWKAN++/2W4TQHwgCx6Wd+DpFBmrlUpanWZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=agrcqQob; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=agrcqQob
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A96F240062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:50 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-84e513874f8so2190776a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058409; x=1793663209;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v842iKKBTz+xpkXAKyRP5B6tbVUkmaxttCnuZA7PR6k=;
 b=agrcqQobXnCK74XHryjcVgogjsy3LXGsNcAi+LwdcS8kH+2s+I17GoXQQQoeVveU9P
 dXGsJhrdBnAEoHEBdat8TkoE/Nxm3ATbAV9JruuUAmK+BqWKIbBbQHYlheGs7L1Fpg4v
 3ZvYK1/IKlvyggLMQbmisR3rGOa+7HxiUxPCHat896RgTwieo3PR34yCUM6BdJhBAZuT
 Kz9nCJEX4NrA5TpAPZTc6RGA3EXtnhXdArsb8cPhWedG8B/MYIgBMrcStThr+WH3CxMa
 hFyBKUgEvHsTOaN0ybrqDzpbN/OFhmCFyjI2VQqf/S42GDIcb9r/g1xctx6629p4HqCZ
 z9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058409; x=1793663209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v842iKKBTz+xpkXAKyRP5B6tbVUkmaxttCnuZA7PR6k=;
 b=oe3N73kcTs2WcYHea2mTxIBcIsqKoCTOOaev58YGn6RdFSivv7wPiTDDHhm3eN56mR
 g2UKT1NgtY/zOi5rjj07C2iBchjZAZ8XRd3XY6DqTAL6LLHcXBLCBERyCQHphTHvnuKU
 Ydk5U8qrNvz+mFc9eMzOkhouTCxAgQru5Fp5VtzAoVEIXavpK3Lzl7uyDB2NfgwnuW8i
 eAGWgC/QGFw4ZPkAQSZdqru+qSj/XgURXPloL3qdFlGX9j5+fPyycWWfk/fzP2k3uicz
 sKlnuwgMR0DZqS69HIHBaPO6m3yRPEj0kpKxN8RelcFMF/CBf4FYV2HJC3oluKhUkLYL
 YpWg==
X-Gm-Message-State: AFq9FYI8MikBkwitNSa24SGc0W/+Jf0oBi2CUYGix1BClLFVLGcY4HAZ
 6XM9L6LilDQvui9vJBmjgtwpdmxhO/jKNJuesTgWJBKlVmNSZE+rIpED
X-Gm-Gg: AYBFou1wpIsADFc9AYEXupIngEZQohkP8TSNijxjMBsE7Ub2E4bKHfme1QDudusXBcA
 k1MrgIqcgCSaR+Uh+mB3mMDjzDmZC2k1D/2zxiOhWjxGYxsAXmXFxoZEUncml+8tXs93U0TRBl6
 jvPtNQ0hqsCitJgS/dyVmK26182CJZa5R4NkshPX9AI2nmRbyGQoHuZb+sTA2xLkIXYLPHXWGtI
 U3yRDVOkkWBDGfROwMGhWslX4La9DNPEIr4AF0WmJzVJ7Tu9Qf6ikCdz44jL/6fHB1za3YMAX4m
 qLMBbXE5hTEtNF9K60OAtWIPS2OHJkZ5dkiqXQZRzBqMezk8oPxobuHiXBxOaPOCGEt9ZWYzfgG
 fI6NDvT9iJ8vWM9eWk1GVhb2yTWsW+id7RS6opotzZa3pIEyWjeOWFbWUWqrTOFG5xHHXtEVams
 9CrY9aYWRcWGgLoogl4B3nlW6CEza+gIKnVMWeydpsMFt/zTdS+ddR3gPHlao/Uu9mV7Q4eiUsD
 sR0QOoAT/JaObcsId7xcPYnAI6Mmmtdjc4BJNcHW2aceP66AkJWrt1uF8w1v6S/eudr+EmHa8Nn
 GY9n7LJXMAP9QFpWt9dYYXg4/oVveXWV6OBaQjpArxc/QRN9g69ZIqb2+eNeF27FaaBm01SFGFZ
 fxvEPpmymAba3Eaj5LU4JYYE9Clum8f2xpnKRA9NB+DYM3w+WSOsp2BLFR52N6KRuCWHokzNrgq
 W3PR/5s0E3urBBR5ESsGyge4BQ
X-Received: by 2002:a05:6830:2701:b0:822:a76e:95a3 with SMTP id
 46e09a7af769-850f8c295a6mr6264687a34.0.1793058409147; 
 Mon, 26 Oct 2026 16:46:49 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:40 -0600
Subject: [PATCH 8/9] misc: add X-Powers AC200 register provider
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-8-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
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

The AC200 companion IC exposes a paged, big-endian 16-bit I2C register
interface shared by its functions. Its Ethernet PHY is described
independently on MDIO and accesses the control registers through a
phandle to this provider.

Enable the required input clock, retain the vendor startup delay, and
deassert the chip reset without resetting unrelated functions. Provide
typed register accessors and report clock and I2C failures to consumers.
Select the page on every access so direct I2C commands cannot invalidate
a software page cache.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 MAINTAINERS                  |   6 ++
 drivers/misc/Kconfig         |   9 +++
 drivers/misc/Makefile        |   1 +
 drivers/misc/xpowers-ac200.c | 148 +++++++++++++++++++++++++++++++++++++++++++
 include/xpowers-ac200.h      |  34 ++++++++++
 5 files changed, 198 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e724357419b..a3a7a121066 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1918,6 +1918,12 @@ F:	include/xen.h
 F:	lib/sscanf.c
 F:	test/lib/sscanf.c
 
+X-POWERS AC200
+M:	James Hilliard <james.hilliard1@gmail.com>
+S:	Maintained
+F:	drivers/misc/xpowers-ac200.c
+F:	include/xpowers-ac200.h
+
 XTENSA
 M:	Max Filippov <jcmvbkbc@gmail.com>
 S:	Maintained
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6f6456120d0..d3b2cc12edd 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -746,6 +746,15 @@ config SL28CPLD
 	  the base driver which provides common access methods for the
 	  sub-drivers.
 
+config XPOWERS_AC200
+	bool "X-Powers AC200 register provider"
+	depends on DM_I2C && CLK
+	depends on MISC
+	help
+	  Enable the I2C register provider for the X-Powers AC200 mixed-signal
+	  companion IC. Function drivers use the exported accessors to reach
+	  the AC200 paged register map.
+
 config SPL_SOCFPGA_DT_REG
 	bool "Enable register setting from device tree in SPL"
 	depends on SPL
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3ec2bc2b201..128159c12ee 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_$(PHASE_)TURRIS_OMNIA_MCU) += turris_omnia_mcu.o
 obj-$(CONFIG_TWL4030_LED) += twl4030_led.o
 obj-$(CONFIG_VEXPRESS_CONFIG) += vexpress_config.o
 obj-$(CONFIG_WINBOND_W83627) += winbond_w83627.o
+obj-$(CONFIG_XPOWERS_AC200) += xpowers-ac200.o
 obj-$(CONFIG_JZ4780_EFUSE) += jz4780_efuse.o
 obj-$(CONFIG_MICROCHIP_FLEXCOM) += microchip_flexcom.o
 obj-$(CONFIG_MPFS_SYSCONTROLLER) += mpfs_syscontroller.o
diff --git a/drivers/misc/xpowers-ac200.c b/drivers/misc/xpowers-ac200.c
new file mode 100644
index 00000000000..cfcc5ba4958
--- /dev/null
+++ b/drivers/misc/xpowers-ac200.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * X-Powers AC200 I2C register provider
+ *
+ * Copyright (C) 2019 Jernej Skrabec <jernej.skrabec@gmail.com>
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <asm/unaligned.h>
+#include <xpowers-ac200.h>
+
+#define AC200_SYS_CONTROL_REG			0x0002
+#define AC200_SYS_CONTROL_CHIP_RESET_DEASSERT	BIT(0)
+
+#define AC200_TWI_REG_ADDR_H			0xfe
+#define AC200_MAX_REG				0xa1f2
+
+struct ac200_priv {
+	struct clk clk;
+};
+
+static int ac200_select_page(struct udevice *dev, unsigned int page)
+{
+	u8 buf[2];
+
+	/* Select explicitly: an I2C command can also change the hardware page. */
+	put_unaligned_be16(page, buf);
+	return dm_i2c_write(dev, AC200_TWI_REG_ADDR_H, buf, sizeof(buf));
+}
+
+int ac200_read(struct udevice *dev, unsigned int reg, u16 *value)
+{
+	u8 buf[2];
+	int ret;
+
+	if (!value || reg > AC200_MAX_REG || reg & 1)
+		return -EINVAL;
+
+	ret = ac200_select_page(dev, reg >> 8);
+	if (ret)
+		return ret;
+
+	ret = dm_i2c_read(dev, reg & 0xff, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	*value = get_unaligned_be16(buf);
+
+	return 0;
+}
+
+int ac200_write(struct udevice *dev, unsigned int reg, u16 value)
+{
+	u8 buf[2];
+	int ret;
+
+	if (reg > AC200_MAX_REG || reg & 1)
+		return -EINVAL;
+
+	ret = ac200_select_page(dev, reg >> 8);
+	if (ret)
+		return ret;
+
+	put_unaligned_be16(value, buf);
+
+	return dm_i2c_write(dev, reg & 0xff, buf, sizeof(buf));
+}
+
+int ac200_update_bits(struct udevice *dev, unsigned int reg, u16 mask,
+		      u16 value)
+{
+	u16 old;
+	int ret;
+
+	ret = ac200_read(dev, reg, &old);
+	if (ret)
+		return ret;
+
+	value = (old & ~mask) | (value & mask);
+	return old == value ? 0 : ac200_write(dev, reg, value);
+}
+
+ulong ac200_get_clock_rate(struct udevice *dev)
+{
+	struct ac200_priv *priv = dev_get_priv(dev);
+
+	return clk_get_rate(&priv->clk);
+}
+
+static int ac200_probe(struct udevice *dev)
+{
+	struct ac200_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_by_index(dev, 0, &priv->clk);
+	if (ret)
+		return ret;
+	ret = clk_enable(&priv->clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * No minimum delay is documented. Match the vendor driver's delay
+	 * before its first register access after the input clock is enabled.
+	 */
+	mdelay(40);
+
+	/* Release reset without resetting other functions of the companion IC. */
+	ret = ac200_update_bits(dev, AC200_SYS_CONTROL_REG,
+				AC200_SYS_CONTROL_CHIP_RESET_DEASSERT,
+				AC200_SYS_CONTROL_CHIP_RESET_DEASSERT);
+	if (ret)
+		goto err_disable_clk;
+
+	return 0;
+
+err_disable_clk:
+	clk_disable(&priv->clk);
+
+	return ret;
+}
+
+static int ac200_remove(struct udevice *dev)
+{
+	struct ac200_priv *priv = dev_get_priv(dev);
+
+	return clk_disable(&priv->clk);
+}
+
+static const struct udevice_id ac200_ids[] = {
+	{ .compatible = "x-powers,ac200" },
+	{ }
+};
+
+U_BOOT_DRIVER(xpowers_ac200) = {
+	.name = "xpowers_ac200",
+	.id = UCLASS_MISC,
+	.of_match = ac200_ids,
+	.probe = ac200_probe,
+	.remove = ac200_remove,
+	.priv_auto = sizeof(struct ac200_priv),
+};
diff --git a/include/xpowers-ac200.h b/include/xpowers-ac200.h
new file mode 100644
index 00000000000..6aa4bde6f59
--- /dev/null
+++ b/include/xpowers-ac200.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __XPOWERS_AC200_H
+#define __XPOWERS_AC200_H
+
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/types.h>
+
+struct udevice;
+
+#if IS_ENABLED(CONFIG_XPOWERS_AC200)
+int ac200_read(struct udevice *dev, unsigned int reg, u16 *value);
+int ac200_write(struct udevice *dev, unsigned int reg, u16 value);
+int ac200_update_bits(struct udevice *dev, unsigned int reg, u16 mask,
+		      u16 value);
+ulong ac200_get_clock_rate(struct udevice *dev);
+#else
+static inline int ac200_read(struct udevice *dev, unsigned int reg, u16 *value)
+{
+	return -ENOSYS;
+}
+
+static inline int ac200_write(struct udevice *dev, unsigned int reg, u16 value)
+{
+	return -ENOSYS;
+}
+
+static inline ulong ac200_get_clock_rate(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+#endif
+
+#endif

-- 
2.53.0

