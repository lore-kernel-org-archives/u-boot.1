Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA18CDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04144849F3;
	Tue, 23 Jun 2026 16:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Lu42/KWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE85849EA; Tue, 23 Jun 2026 16:15:59 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CE1849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB3D73F96E
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782224157;
 bh=vJ9tu8QmH7tQlX7nNxVYGQ0DdVCVXVjZTiTsqeosNEE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Lu42/KWJLjGM6iWzdccX/kmxL5OmMJfbD6liGKntaauP6weAJFaQQ0cc7qbsfCDsj
 GW34kc9GGKC82eafbtws6azoIvS2L0PJt98QMY9sAw7bxhIoHrrXbCMBHwt9uAqElJ
 DC+kUA+BJSk5VmHaEMYLftaQC6e4Zhdc9HbByck15Ef6xsiQIfWOFfitKO/ir/50tk
 Ob8ZodC7qr4kh4jwlmWY5V+KHKEHL/aFRQPvwZPdy5dNeeQ42Po+O/qiQDyK1CWs80
 X8Tr8U03OyUkPAdcgqOmo80cst2hcc0bVHu+44R0QPtF3Ru0JHvzcIntGD+mSNiMq5
 t4NCEoZje0/eSK40SuX14QjjehygW75zwiKAB3T71AOjs0LYXsAzkcaNMTDCWrr0s2
 JoQeacL9JLyZIDFo32flCJuTfIYmLE9m7PeUg9udqtAYxDdPBShzIse+jGORow7E6o
 7oPFO71nH4ow51yAlOwhQfetZFmO22jPOKUA7llpSOUOYmmlzAlCCYb5ByA2BC57+T
 4A+jkolXaafkXWxq1V/BjAeBLfWk5mmIEyPS8txXnVt3vJl8CsMFwyf0KsD3IhUKJS
 nevXrCRuxKzok2N1kFCYVvovPs9TnWsbDXtIZJBqLX/mCYFlbjq6WzsOT3MtzRJk6k
 IlN5tpOMHt/QRCiESif4LpzU=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c6b4271491so36337645ad.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782224155; x=1782828955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vJ9tu8QmH7tQlX7nNxVYGQ0DdVCVXVjZTiTsqeosNEE=;
 b=sizTdwTz8+YpZYK5s5/AsAVkuMW7L0Bgk/eSw/KiXCAXaQCWVKxbKcr4uttQoYd+HK
 /CmlFUZPeyHaq7AouEodnSkv48DLoxoGQ8epRyKyAV+CUMFev8HGjBPpPcKnF+STEdzF
 dh1Y2ldH66+yb/iwoGEgCowum6q1OSs82+PDCOOgMUIWZKReWNpa762Msb5PcOa5B2t4
 joLSby/LXPiI+yFmt/tgIutgIz/KGlqcjvVto/x+42XpwZL/eTqPXrMw1S7VhlzpB4Pv
 5VLWpEVVSDEzE9S4LQMPY6sjpXrAzmjfuQUcTR4nd+8udDuU+d+5JMpcOKShE0ZSBPi/
 uUZg==
X-Gm-Message-State: AOJu0YzLyATQEt5Eq31VbK7G0JPZYOt76gNeyswjDDB7L3rdIImylyYm
 IgU3X/S40B/9kU2XOtST9pPRyGsLM3tyRCXGXFc9+9cEzi5SGMecVlKOopfe1O9cJXGAuVEf2q1
 xEeZX35Fi1DxuIB/QS2ViA03Qwl+H0kUs9sllt+DjV797JleV8flFsLj6avPnd5v0eJaAhBjuiK
 6r8hjIiQ==
X-Gm-Gg: AfdE7cm8eQE3RPkmT4surgldHKvc9aOosDCJzgARPo10cji8YAg/aBmnHZiDtDUstUh
 6O6a286vIbBFLR6ModTz03ypdKUw06NlirhWdPxzqkpACJxgqLA0IAxQOgEkuwxeKjJ+JM+hyAd
 RqogZW1oiwaVnuvBJIsGEuejP3osZOD9zO/l2p3gEJA6MSbe/Dv5s6UCYagF5q3RuBdg9afguZg
 hP9iJlgqPBHSRrPg5ctqxXVjlGKi4GoJGiBEDIwHHSRIVO0YabKFXlyo3w7OvKFh/nLnu+VKvhM
 P+wzD/UMmdziw12ElFbPaMBMBxPnBbDo572KLdN7ERV3DWY9Jp6bR9G/ValOgZe8GUbt6AahNAM
 PE2zxNweufmeCsXCjnuzKl6v76NsfjfIaFZuvvzQhN8stUglVpIe3NqAk6XsWhA==
X-Received: by 2002:a17:903:906:b0:2be:3434:4e28 with SMTP id
 d9443c01a7336-2c742b1ce87mr150619235ad.19.1782224154716; 
 Tue, 23 Jun 2026 07:15:54 -0700 (PDT)
X-Received: by 2002:a17:903:906:b0:2be:3434:4e28 with SMTP id
 d9443c01a7336-2c742b1ce87mr150618615ad.19.1782224154146; 
 Tue, 23 Jun 2026 07:15:54 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436d3505sm110410325ad.19.2026.06.23.07.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 07:15:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Suhaas Joshi <s-joshi@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aniket Limaye <a-limaye@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Vishal Mahaveer <vishalm@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
Date: Tue, 23 Jun 2026 14:15:15 +0000
Message-ID: <20260623141540.618272-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623141540.618272-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260623141540.618272-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 16:25:36 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

TI K3 AM62x/AM62Ax/AM62Px boards carry two or three mutually-exclusive
tifsstub variants in their tispl.bin FIT images, all at the same load
address. The existing approach loads every variant and then discards
the wrong ones at runtime via a *p_size = 0 hack in
board_fit_image_post_process(). Switch to selecting the appropriate
FIT configuration up front via board_fit_config_name_match() so only
the correct tifsstub is loaded in the first place.

board_fit_config_name_match() is invoked by the R5 SPL during FIT
config selection. get_device_type() is a simple register read that is
available at that point, so the security state can be determined
early. The matching logic is factored into
k3_fit_config_match_security_state() in arch/arm/mach-k3/common.c so
it can be shared by any K3 board that wants this scheme. It matches
configurations by a suffix appended to the description string:

  -hs-se  ->  HS-SE  (K3_DEVICE_TYPE_HS_SE)
  -hs-fs  ->  HS-FS  (K3_DEVICE_TYPE_HS_FS)
  -gp     ->  GP     (K3_DEVICE_TYPE_GP)

Configurations without a security-state suffix (e.g. u-boot.img) do
not match and fall through to the DTS-specified default config
naturally.

Each TI EVM board defines its board_fit_config_name_match() as a thin
wrapper around the shared helper:
- board/ti/am62x/evm.c   (AM625 SK: hs-se, hs-fs, gp)
- board/ti/am62ax/evm.c  (AM62A SK: hs-se, hs-fs, gp)
- board/ti/am62px/evm.c  (AM62P SK: hs-se, hs-fs, gp)

FIT configurations are split per security state in:
- arch/arm/dts/k3-am625-sk-binman.dtsi
  (ti-falcon, ti-spl, ti-spl_unsigned: conf-hs-se/conf-hs-fs/conf-gp)
- arch/arm/dts/k3-am62a-sk-binman.dtsi
  (ti-falcon, ti-spl: conf-hs-se/conf-hs-fs; no GP variant on AM62A)
- arch/arm/dts/k3-am62p-sk-binman.dtsi
  (ti-falcon, ti-spl: conf-hs-se/conf-hs-fs; no GP variant on AM62P)

The runtime filter in board_fit_image_post_process() is intentionally
left in place. It becomes redundant once every board using the AM62x
family dtsi files migrates to per-state configurations. The dtsi for
phytec phycore and toradex verdin boards is updated by separate
patches in this series, and the now-redundant runtime filter is
removed by the final patch in the series.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi     | 61 ++++++++++++++++++------
 arch/arm/dts/k3-am62a-sk-binman.dtsi     | 28 +++++++----
 arch/arm/dts/k3-am62p-sk-binman.dtsi     | 28 +++++++----
 arch/arm/mach-k3/common.c                | 27 +++++++++++
 arch/arm/mach-k3/common.h                | 10 ----
 arch/arm/mach-k3/include/mach/hardware.h | 11 +++++
 board/ti/am62ax/evm.c                    |  6 +++
 board/ti/am62px/evm.c                    |  6 +++
 board/ti/am62x/evm.c                     |  6 +++
 9 files changed, 140 insertions(+), 43 deletions(-)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index ba29a047406..1717621a850 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -263,12 +263,21 @@
 			};
 
 			configurations {
-				default = "conf-0";
-				conf-0 {
-					description = "k3-am625-sk-falcon";
+				default = "conf-hs-fs";
+				conf-hs-fs {
+					description = "k3-am625-sk-falcon-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm";
+				};
+				conf-hs-se {
+					description = "k3-am625-sk-falcon-hs-se";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "dm";
+				};
+				conf-gp {
+					description = "k3-am625-sk-falcon-gp";
 					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-					"tifsstub-gp", "dm";
+					loadables = "tee", "tifsstub-gp", "dm";
 				};
 			};
 		};
@@ -376,13 +385,24 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am625-sk";
+				conf-hs-fs {
+					description = "k3-am625-sk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am625-sk-hs-se";
 					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-					"tifsstub-gp", "dm", "spl";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-gp {
+					description = "k3-am625-sk-gp";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
@@ -497,13 +517,24 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am625-sk";
+				conf-hs-fs {
+					description = "k3-am625-sk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-fs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am625-sk-hs-se";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "dm", "spl";
+					fdt = "fdt-0";
+				};
+				conf-gp {
+					description = "k3-am625-sk-gp";
 					firmware = "atf";
-					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
-						  "tifsstub-gp", "dm", "spl";
+					loadables = "tee", "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 49c90f5855c..6e7deb218e9 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -185,11 +185,16 @@
 			};
 
 			configurations {
-				default = "conf-0";
-				conf-0 {
-					description = "k3-am62a7-sk-falcon";
+				default = "conf-hs-fs";
+				conf-hs-fs {
+					description = "k3-am62a7-sk-falcon-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-fs";
+				};
+				conf-hs-se {
+					description = "k3-am62a7-sk-falcon-hs-se";
 					firmware = "atf";
-					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs";
+					loadables = "tee", "dm", "tifsstub-hs";
 				};
 			};
 		};
@@ -284,13 +289,18 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				ti_spl_conf_0: conf-0 {
-					description = "k3-am62a7-sk";
+				ti_spl_conf_0: conf-hs-fs {
+					description = "k3-am62a7-sk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl", "tifsstub-fs";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am62a7-sk-hs-se";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl",
-					"tifsstub-hs", "tifsstub-fs";
+					loadables = "tee", "dm", "spl", "tifsstub-hs";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index cca56b76d69..c56ecad85a6 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -206,11 +206,16 @@
 			};
 
 			configurations {
-				default = "conf-0";
-				conf-0 {
-					description = "k3-am62p5-sk-falcon";
+				default = "conf-hs-fs";
+				conf-hs-fs {
+					description = "k3-am62p5-sk-falcon-hs-fs";
 					firmware = "atf";
-					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs";
+					loadables = "tee", "dm", "tifsstub-fs";
+				};
+				conf-hs-se {
+					description = "k3-am62p5-sk-falcon-hs-se";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-hs";
 				};
 			};
 		};
@@ -309,13 +314,18 @@
 			};
 
 			configurations {
-				default = "conf-0";
+				default = "conf-hs-fs";
 
-				conf-0 {
-					description = "k3-am62px-sk";
+				conf-hs-fs {
+					description = "k3-am62px-sk-hs-fs";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl", "tifsstub-fs";
+					fdt = "fdt-0";
+				};
+				conf-hs-se {
+					description = "k3-am62px-sk-hs-se";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl",
-					"tifsstub-hs", "tifsstub-fs";
+					loadables = "tee", "dm", "spl", "tifsstub-hs";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 19a6e24f38b..6e382efdb3b 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -191,6 +191,33 @@ enum k3_device_type get_device_type(void)
 	}
 }
 
+int k3_fit_config_match_security_state(const char *name)
+{
+	const char *suffix;
+	size_t name_len, suffix_len;
+
+	switch (get_device_type()) {
+	case K3_DEVICE_TYPE_HS_SE:
+		suffix = "-hs-se";
+		break;
+	case K3_DEVICE_TYPE_HS_FS:
+		suffix = "-hs-fs";
+		break;
+	case K3_DEVICE_TYPE_GP:
+		suffix = "-gp";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	name_len = strlen(name);
+	suffix_len = strlen(suffix);
+	if (name_len < suffix_len)
+		return -EINVAL;
+
+	return strncmp(name + name_len - suffix_len, suffix, suffix_len);
+}
+
 #if defined(CONFIG_DISPLAY_CPUINFO)
 static const char *get_device_type_name(void)
 {
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 466ad22f895..37ff98d8992 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -32,15 +32,6 @@ enum k3_firewall_region_type {
 	K3_FIREWALL_REGION_BACKGROUND
 };
 
-enum k3_device_type {
-	K3_DEVICE_TYPE_BAD,
-	K3_DEVICE_TYPE_GP,
-	K3_DEVICE_TYPE_TEST,
-	K3_DEVICE_TYPE_EMU,
-	K3_DEVICE_TYPE_HS_FS,
-	K3_DEVICE_TYPE_HS_SE,
-};
-
 void setup_k3_mpu_regions(void);
 int early_console_init(void);
 void disable_linefill_optimization(void);
@@ -55,7 +46,6 @@ const struct k3_speed_grade_map *k3_get_speed_grade_map(void);
 void k3_fix_rproc_clock(const char *path);
 void mmr_unlock(uintptr_t base, u32 partition);
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
-enum k3_device_type get_device_type(void);
 struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index b337a71956f..2c771a1195f 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -124,8 +124,19 @@ struct rom_extended_boot_data {
 	u32 num_components;
 };
 
+enum k3_device_type {
+	K3_DEVICE_TYPE_BAD,
+	K3_DEVICE_TYPE_GP,
+	K3_DEVICE_TYPE_TEST,
+	K3_DEVICE_TYPE_EMU,
+	K3_DEVICE_TYPE_HS_FS,
+	K3_DEVICE_TYPE_HS_SE,
+};
+
 u32 get_boot_device(void);
 const char *get_reset_reason(void);
+enum k3_device_type get_device_type(void);
+int k3_fit_config_match_security_state(const char *name);
 
 #define writel_verify(val, addr) \
 do { \
diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index 4916eec3b2b..adb784e69a8 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <image.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
@@ -17,6 +18,11 @@
 #include "../common/fdt_ops.h"
 #include "../common/k3_32k_lfosc.h"
 
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
+
 #if defined(CONFIG_XPL_BUILD)
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 8fde47fb1be..9fa0a1c9f72 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -7,6 +7,7 @@
  */
 
 #include <efi_loader.h>
+#include <image.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <cpu_func.h>
@@ -43,6 +44,11 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
+
 #if IS_ENABLED(CONFIG_SPL_BUILD)
 void spl_board_init(void)
 {
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 49e58ad6d6c..90beed341b6 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -18,6 +18,7 @@
 #include <fdt_support.h>
 #include <fdt_simplefb.h>
 #include <asm/io.h>
+#include <image.h>
 #include <asm/arch/hardware.h>
 #include <dm/uclass.h>
 #include <asm/arch/k3-ddr.h>
@@ -135,6 +136,11 @@ int board_late_init(void)
 }
 #endif
 
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
+
 #if defined(CONFIG_XPL_BUILD)
 void spl_board_init(void)
 {
-- 
2.43.0

