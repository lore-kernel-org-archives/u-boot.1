Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396EECD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 13:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1802846AA;
	Thu, 28 May 2026 15:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n94EMa9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25718056B; Thu, 28 May 2026 15:28:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D5F80398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 15:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 18E9A3FA70
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779974901;
 bh=hh6fSoNl6TB5r0f4BO1wqh4eO5+oIWoQXQ6kF9F3M70=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=n94EMa9iwDzGde/zD4ENdnmnepqVMcfK9YaqSxHZjQ7Ung6acr6QJNVB59pkqmmVp
 X4FKtccZ2JJcs272Gdpxu+jNqebBPRjlm3Emsw6HxrG7t4jaRnZvlXKjkG5tkM06TG
 JDqFcn7OI0TVp24bpTROuczra/v/m0T1Sz/u3fHthk+xK+m090/01D591xAe52ADf7
 qExbrLMqKbsJlwk6wD0WK+YK+LcUZoOC/7jAc1Q7AFdxiRe567n9UEaUfSwBb7pYzn
 Xfp8wLo8uJS0+EELY/hEZ/myobtnr/4njJaFQlseVyXH4Dw990pSaqOd5N/7UFr01d
 jnQfr+oObl+Z5XAur3I7N5it+6lusMowCDoPG9/HcX++73jiy6GTMo8HNJAbPJT1hV
 sa1KgyhRdoqy1t1ut8GeGwWkm8+AGjHZHdpc+klGH6AcCEAb5vJd+0VWbzD05CfJEy
 pZxqssltYK2K/DLeg10P6qeiUU61YBGJ/uSA05SL3cC9kz5fZY5a9gXbPuVVN+x2A4
 JAQsLAOmOV2wJOXU6vK6EWq3Qf0jkZJa7UC833DpQktRb13/aMc9f0tH71WRKwIIvD
 yL9wxkI3I+FlM1/pDZ1nywMO0XeDeERvNZbwBCFT9/o05AdQ1QTpcXC/zBrkN6gJEX
 YS8em6aalnGSz/lP2rBNi8sM=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf0607b5f5so10442615ad.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 06:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974900; x=1780579700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hh6fSoNl6TB5r0f4BO1wqh4eO5+oIWoQXQ6kF9F3M70=;
 b=QWnUh7MO3Kp3W6AgoL3JcEA7BPv8dK1y3b652p0+LwEMElxeNuqj1HqWyYPhTRDo51
 dB+5FReYSxQ5Hjqqm4clY02aAWyBjvMTqMWq4ccD8oqeEmG3N5hY6VxrW327RNUmN/WL
 4FcpYus1wgPErOLlDKepzluPvcKhs2DhOOO1h+hsW3l3Gp3LeIekII/vByLo8TUJ+CVj
 cBQgZMxUJlb1qPBol8OPMJ7nq3gDMU07fA0xvDj7XKyT0wb/+IecjJKojQXt0l7TjDaW
 nr4XSIx3j/okt7xzM7kv7tcQ7M4T/XVpriFfaVMqbbyhTOJr578GKK/SREf8GaElxa2U
 xj6w==
X-Gm-Message-State: AOJu0Yw7+IBMDuDW4euOe6qZDmVAfwRnhDgMT2X4ljGcuYwBso7iNyUo
 6oHkHU/UWd6Bloxl6qOtFOKAiwbfJc3wRZYSf3fy6tSfpDun1TbAlJ9QObe0ZuXByneHzF6qlbV
 lPJogoxxcUJWJORAcDh/Nw/vCBMLufMv7PgBcLFQLAB8r45SmtcQZGsm6kIuwK2/g/kklcBJwjk
 KflxmKNA==
X-Gm-Gg: Acq92OFsmitb1e/cn6B6eAohSQMn70jpYhIdigBmLVvx81l6cINLb6YHEkmzhMR2JV0
 AiP1XaKOkxYUsxiCdlfjJlpyHjuuAOFAXPdhi1OArQvNcs/QkLFY9qpgBtyjwHgxgVv8nEBZtAL
 Bsfn0sb8DgfGrRBPCX12NobtEGD1+E4OedUI7fN3s/UNsEjx7GSr51L61crsEW7ZHOY162mkOss
 RQ/Cd8OhRgDEQaHAeFL6Pfp/tBzQw2QgCoojHpalBIdEPoLEBoK3t8pdCcvswRc32+lHxY8bR6r
 Hlz7BUj8ITPkJ3cD+F19yv7EdCSbwGVOvG6vo+c01jHAnBqP+F9r5si34D6y01Bc131XFoTSYRn
 bUn058R1TxpgaDgFme6e+N+DCfyCxHrACpvnWPF1zNws4b9U4lVefn2ESK9bO8+B259nUbMGGxp
 5NrIki5Jw=
X-Received: by 2002:a17:903:230a:b0:2bf:acd:3a7a with SMTP id
 d9443c01a7336-2bf0acd3bf8mr31024155ad.23.1779974899250; 
 Thu, 28 May 2026 06:28:19 -0700 (PDT)
X-Received: by 2002:a17:903:230a:b0:2bf:acd:3a7a with SMTP id
 d9443c01a7336-2bf0acd3bf8mr31023475ad.23.1779974898651; 
 Thu, 28 May 2026 06:28:18 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3058sm187006315ad.39.2026.05.28.06.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:28:18 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>,
 Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Andrew Davis <afd@ti.com>, Paresh Bhagat <p-bhagat@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Moteen Shah <m-shah@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Vishal Mahaveer <vishalm@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v1 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
Date: Thu, 28 May 2026 13:27:10 +0000
Message-ID: <20260528132746.719699-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528132746.719699-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 15:30:21 +0200
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
 board/ti/am62ax/evm.c                    |  8 ++++
 board/ti/am62px/evm.c                    |  8 ++++
 board/ti/am62x/evm.c                     |  8 ++++
 9 files changed, 146 insertions(+), 43 deletions(-)

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
index 19a6e24f38b..f4c6c4f098e 100644
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
+	return strcmp(name + name_len - suffix_len, suffix) ? -EINVAL : 0;
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
index 4916eec3b2b..6dc0e432e8f 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <image.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
@@ -17,6 +18,13 @@
 #include "../common/fdt_ops.h"
 #include "../common/k3_32k_lfosc.h"
 
+#if defined(CONFIG_SPL_LOAD_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
+#endif
+
 #if defined(CONFIG_XPL_BUILD)
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 8fde47fb1be..f8b6d1a16a0 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -7,6 +7,7 @@
  */
 
 #include <efi_loader.h>
+#include <image.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <cpu_func.h>
@@ -43,6 +44,13 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
+#if defined(CONFIG_SPL_LOAD_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
+#endif
+
 #if IS_ENABLED(CONFIG_SPL_BUILD)
 void spl_board_init(void)
 {
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 49e58ad6d6c..59201f8d2ca 100644
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
@@ -135,6 +136,13 @@ int board_late_init(void)
 }
 #endif
 
+#if defined(CONFIG_SPL_LOAD_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	return k3_fit_config_match_security_state(name);
+}
+#endif
+
 #if defined(CONFIG_XPL_BUILD)
 void spl_board_init(void)
 {
-- 
2.43.0

