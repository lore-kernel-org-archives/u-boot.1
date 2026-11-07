Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54954606A333
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=svLK9O4v;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=enj7ydRY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 328378193E;
	Sat,  7 Nov 2026 14:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F25pdtxSO89B; Sat,  7 Nov 2026 14:34:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3D40819FC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062047;
	b=ji4uSLXvI4wTGsj5LTwL26e8iEo80gKKErhCDdyCqlRqKPNp+okii2O/zJy317rNqAGU
	 QrdFlMp2Fgkw7j/W2w7BmmJurC5gCNrwaDueGvuQh722E3d5YnMEdQ/UTNO/pC2ek5tBm
	 A8pcNXKwrZi49p4dOxdYJWwAJbl4+RcbVfJZOg4IozkBafMEbezDeWIW+H+cK2GCk9XD4
	 h4LKBNhQd8w9FGGfkPAhCwtejtulgX5pmbU2YKVldyFmvcKLSPAGsnJCycZ6KPNB5uk+G
	 y+4klGFz7jQci6XzQ4FKlddRbxARR2rNQX2hCMdwzTj35uQWfHqswe2yUKUO9t2XqsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7+PVAuuMVre5+F+/xgZWFdQssChRfGIIR60te3IYvUs=;
	b=LKmSH4kWjR9I86OqG7QdmUX5Qk8o8gTLXIsKaPdHO2VCfw9qRiCdppXwUwL0xejStxkx
	 +LIt0wm1T/SEGT+ySnoYlh5NALWd3CVFVOH93VasVZlxpdNK31TGYI5uZQYiZr1Vj4b8v
	 yW68i6EdrLRmnN4bQBujSYDAzHvMygSJCv2oWvqjSBPBhgH884LvMt0Dcy31O40iTR5g/
	 5LaDMhZs2teRT/9/5YhP7FkYf5bSqlbWfhoZuP3T9SwPzK2aJAibbm1tfO4bL1eG8ESO+
	 UzvJ+XT+MubVlwEoETHD7R/If2ULKJXYK6heYK1x6F9xRYVrwe+4tOHHIuSV4Hj52CA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062047;
	bh=7+PVAuuMVre5+F+/xgZWFdQssChRfGIIR60te3IYvUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=svLK9O4viFpKnJkqsu9eSRj+mA9gUv4CjTakh/N1A5fQkEttRbLA21eMS7AXUtu3G
	 0cAChywtaDeStNIaHexrgXKDrU4hw2f2hSG3vAl5NSGzSi90LzZ9R6KNbCiDLUGz43
	 HIHdJnLJdZEgwsKj+Db8XHkwBBXEugl5UjqfGW1SsRqa63wkHhv+SS2WMrJGL0x/6S
	 TEXMixahN72S11Xy+yqdTtB2zAJzd3PgI+G2lsDS/V5g3AVBUV1k4+dKph2f1es7pQ
	 n7P3JoC9uuhta7fGsKQbwpMXdFSMYNsMGaU6Ic4c94SbyO1h956TmO47VQ3lv8YC+E
	 oAGI1C4wA1zzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3D40819FC;
	Sat,  7 Nov 2026 14:34:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 392DC211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B20260A57
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wXD7ugWJP5c9 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A4C8608CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=enj7ydRY
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A4C8608CE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:40 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so240089f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062019; x=1794666819;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7+PVAuuMVre5+F+/xgZWFdQssChRfGIIR60te3IYvUs=;
 b=enj7ydRYhHnTk5cjW6jTFtaG4zglwnZcps0YV4d5CQVyuHxB2ciJvHsMk0VWlMcuSq
 /cpBR3IpdroZrvUiiRVDu3paMXFH5Df6izoeKmkBhuSqEkv+Uu+02goeTniG16e8Dsgw
 jTo7PGaSC8tiD8ijVnJ16MgBaEqK4//GtfGiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062019; x=1794666819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7+PVAuuMVre5+F+/xgZWFdQssChRfGIIR60te3IYvUs=;
 b=WuwCdP8Eq+31bEsEBsX/1tiY2ZgrVy/tbIFvA7Q9WmcuYj7pT+ZnuMRSVGK1d9clf+
 bKk3s6gknJK/slxoqOGDvDX+MOKVMCG3PezGKn4nnpgIvNH6b9CJ0uq4IUWJp4DIsMjA
 7jy+/1O6iHJXy2ao2APVKkLxW+ZnPZ3iUTwiTnQt+qEmx9g+tde8IKtIiMJaQWYcKGMq
 takC/8YNDmU31CqjqpQHaXb8tk5Qg/EFtq6+N5MouDkgjoaOf1DeK54P/EIZvZhs9HcM
 b/2RyqwgSkJ3qe+OZUmxCfUlPM/faspqwr1ieWCJk8LzLtA9SMesoBT3GlmKq9/Nrif9
 bYFA==
X-Forwarded-Encrypted: i=1;
 AL+hErEJPECIKpqYYFg4QPwLXLKcdTyR5Ue4i/xD17xP75tCHHZT8Xl2ZBZVSso3Sg932ntdLsusRCk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/caOEPwazs5/BWA4DL/eAd9nZDpqSCKI4BAyqqBMjTau/3QEf2
 GvQUqEJKWceu1FI7vYE6SV8/qy5J7RClmLrdY2GdkLYM91SW6POSEKUtNGnNvP8W8aA=
X-Gm-Gg: AYBFou1ln+vSD3uZWIFvsLra78oFqWMyogd/JVT0RcuR+S1NPAUkaxCtTCAllpF+DWR
 rJxbhdQhGvYpinOI4QlA+vP5kAf2gol2zXthafN0jOGbiweS+uas7jthFEbKaFC8/+DmZ+xS7f/
 7ihLhe3W3Ef5AQ3qlUJ5insak6PV7EKDVYldaB7Lvbeh9zqi7Ue77EF0x1zFj3N8bmuyVNvpHvk
 p0KwP0xuPtfCPcgHzh5Mbska31Q8WSpyjq5fgT71IJJVgQFsbSPE0u9GXGcnp+MIPvjYVn0izo9
 sdmd385uH14KiEKgOD97zteYC04BZEs73XYaH0VfXehQ+yrnfZPD/zjPjrE1nZ55oMkwDWxbAGe
 w6KEa+VoqStm97kDPzPoflT2nqK20JCamaZnJuXF9qQDp2OYGG6ZMDzsHriRJ8VIXGYS5XVeM2c
 vezq0CSbp18DmjG9Ay/m/FX4ZDaWDtB7FUaXs1vJWXSGBuScVPY135LRp3bkFJdFEhMW///Acs/
 pnN8LjrGOM9W808mddWpT6TPF85ppZ4gKs/TcveJY/aYDsLsQcahHQdFKmCKJE9MC25i28BP3oV
 PX2Y7TGblYY2Wn62UttYyqlK/EfJwDlLcUO7y1qEh2cXEoJUaW0Ag4+tqgox55au78vqbDNXPHn
 o7f2x3CMrBS7TE/sm2/flAlGHpRxnNRMdpz2MGh8r/S1Z1e82hk8jbAoVwLaklb5rDDMb/M8gXv
 ig5QL8TBcjhxkJ7y5UJMunEJMlfA==
X-Received: by 2002:a05:6000:386:b0:490:411a:1eed with SMTP id
 ffacd0b85a97d-492778d0cadmr10145724f8f.39.1794062018947; 
 Sat, 07 Nov 2026 06:33:38 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:38 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 27/35] configs: stm32mp25: move FWU A/B boot environment to
 common settings
Date: Sat,  7 Nov 2026 15:32:17 +0100
Message-ID: <20261107143241.2236511-28-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The distro boot environment booting from the bootfs partition of the
bank selected by the TF-A only depends on the FWU multi-bank support, so
it is not specific to the STMicroelectronics boards.

Move it to the STM32MP25 common settings, so that other vendor boards
can use it too.

No functional change intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 include/configs/stm32mp25_common.h    | 20 ++++++++++++++++++++
 include/configs/stm32mp25_st_common.h | 15 ---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/configs/stm32mp25_common.h b/include/configs/stm32mp25_common.h
index a334b47b555b..7eb5c4ffc00f 100644
--- a/include/configs/stm32mp25_common.h
+++ b/include/configs/stm32mp25_common.h
@@ -86,6 +86,25 @@
 #define STM32MP_BOARD_EXTRA_ENV
 #endif
 
+/*
+ * With FWU multi-bank update, boot from the bootfs partition of the bank
+ * selected by the TF-A ("boot_partuuid" set from the FWU metadata),
+ * falling back to the bootable partitions if it is not available.
+ */
+#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
+#define SCAN_DEV_FOR_BOOT_PARTS \
+	"setenv devplist; " \
+	"env exists boot_partuuid && " \
+		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
+	"env exists devplist || " \
+		"part list ${devtype} ${devnum} -bootable devplist; "
+
+#define STM32MP_FWU_ENV \
+	"altbootcmd=${bootcmd}\0"
+#else
+#define STM32MP_FWU_ENV
+#endif
+
 #define STM32MP_EXTRA \
 	"env_check=if env info -p -d -q; then env save; fi\0" \
 	"boot_net_usb_start=true\0"
@@ -119,6 +138,7 @@
 	STM32MP_BOOTCMD \
 	BOOTENV \
 	STM32MP_EXTRA \
+	STM32MP_FWU_ENV \
 	STM32MP_BOARD_EXTRA_ENV
 
 #endif
diff --git a/include/configs/stm32mp25_st_common.h b/include/configs/stm32mp25_st_common.h
index 0b0267ae99b0..cb679eb1be22 100644
--- a/include/configs/stm32mp25_st_common.h
+++ b/include/configs/stm32mp25_st_common.h
@@ -8,22 +8,7 @@
 #ifndef __CONFIG_STM32MP25_ST_COMMON_H__
 #define __CONFIG_STM32MP25_ST_COMMON_H__
 
-#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
-#define SCAN_DEV_FOR_BOOT_PARTS \
-	"setenv devplist; " \
-	"env exists boot_partuuid && " \
-		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
-	"env exists devplist || " \
-		"part list ${devtype} ${devnum} -bootable devplist; "
-
-#define ST_STM32MP25_FWU_ENV \
-	"altbootcmd=${bootcmd}\0"
-#else
-#define ST_STM32MP25_FWU_ENV
-#endif
-
 #define STM32MP_BOARD_EXTRA_ENV \
-	ST_STM32MP25_FWU_ENV \
 	"usb_pgood_delay=2000\0" \
 	"console=ttySTM0\0"
 
-- 
2.43.0

