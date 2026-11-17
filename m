Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5D606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=09oBHrny;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XK8eMd1n
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EFA460897;
	Tue, 17 Nov 2026 12:27:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R6qP6lAwsuiS; Tue, 17 Nov 2026 12:27:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33B5D608C1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794918467;
	b=rDWMtQuoRytpVrlDDJeeAvRUgSFXJwmD3/r4v45tQ+niqQNRGMMOmjY+IcNFN3EKqxzX
	 r+l4cXSmtJqVUdm0LvIcYKWsWo4RsuJWxk1esPuHvaTDoBSBXKnKBiF+yY7ipczU/TeQ3
	 0TIbyP1zE5QGJ6ebSAqNhiHx8YTB9PZJkaM07fTXnTrXC0vr60xPyr1MqHiM8Y/ERO1H2
	 iEXWMk91iaIoyllgBh/IgOH1os28LCWzo9olCcWe8jP0BN/1QFEU9VH1EpXZGtU+d38Gt
	 OIrmC38YtzshTBWiHU2ZL9E/cKEZsnHr1wkk/+X7C1RuiLStL+xISggzogrul2WkBXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794918467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FiOFzXduM/mO0k7YkFAAf40RSiyia6nO8LJAHExShRY=;
	b=owlEL4F0Z0i+LMdlrPKqYBx6Hocyip6/MsaaEUu+Fm3AsnQr1mPgA4Rg1hgVMgdqFJF3
	 s1T9Drul202XsAnbbTXd8z3cN9ACA7VvNOor5tngdWMEki1XR0Nu3xmrCQ/Aiu5nfP5Qx
	 r/qFyC6A2iKQzgFY2+LLssutoDG3qw8AXGuro5MtKKNsVqWBQO6bYmgtvJPNOlhbBLubV
	 dx/wL5BVPdZy3Td8QX7PTwJnyVqfarmZBoy79dpFtK9ivabsVpRB0L6P6KbECMFqHaQml
	 /p+hmyuWcjlCGUT4dnLNNuXdLJexgbP088+pfdJ/FizGYD3sUJ0fNCiZmtVWiAoB64A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794918467;
	bh=FiOFzXduM/mO0k7YkFAAf40RSiyia6nO8LJAHExShRY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=09oBHrnyJjXLdba0XQE5pm4CN+YAXM6uSB81homGgRQ8VRPHsFU/bewDjWgCUU05V
	 S6IR1sG2Vds4hOeZX90AlPIAu5JoqylNy3iXAJD5Qs+qcNuoyp6aQQPt56nEOqRkgA
	 K8YlXU/jz64QZDphn4GSAyivuF2V4adIbGzhGVQ/C57Th+z3LU78T1eaQ78KrdhYd0
	 p8yQozcejMzNPt0ieKXdAAv+Hl867uGGGKvWrSwiTsGU0R9yQJrl40vCzkubrgt1Ij
	 WSegY878/1RIo70w3CrFpkN5salcs8Z7PlKY3T11sXgzMqwpDtFhdol8FXVCnZwXJi
	 0lBolpmiAzJNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33B5D608C1;
	Tue, 17 Nov 2026 12:27:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3545105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5F5F40308
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jT_UZ8YxtsHQ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:27:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 70FF74008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=XK8eMd1n
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70FF74008B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:41 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso6930295e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794918460; x=1795523260;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FiOFzXduM/mO0k7YkFAAf40RSiyia6nO8LJAHExShRY=;
 b=XK8eMd1nvyvCQMM5u6HzA0uFn3AtY0RPnNBI3wWqAOwMs47PJlfQ2JP8Y0en3bO/Yy
 gkAaddkQAOOhLP4X1dVgVqsv14n64oKwYppPFDNfyb1f0Mk0Cl3LnOz1nd8QXNva5A9S
 2LinNO1IT3yeg1jxpShYMK+wXuRJJgg+yfAPfWzsCzvLjmJxIuaOlodtM8cbXYmHVntm
 6zTtctEQm9L26N9CyOEAwykMQLeW+hEmfXAeln20nc1YtonPNyOq0BPM6uIYHhwbDOGQ
 PJ1DPE8AQlr1yAkVRpEpbE7d0jwqEAzATuDlz2rBMGQxDNxVddwMjEhVxY/SYVCpmlo4
 AmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918460; x=1795523260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FiOFzXduM/mO0k7YkFAAf40RSiyia6nO8LJAHExShRY=;
 b=Tvo0PTl5i1be3pHnYjapc706RYO9h2CMW4cDnByc5C3mZWvHvak4WS8y2M8t5nPdbq
 WmR1B4KCgyA7k9J1/x4OeYdO8AgJ49Ywl6RbcGWMToIt/I9HOMFSQ9OGTXHjKUAiOE5+
 2GA3+mF6PLkzDQckGLSoPvp51UM/23kmuxus9YgfKG8upSy+cHoKg2F/AWmUCXBRauH3
 ElSlmEmkdePtNXvssXIHR1a1+Rvu6zMVqjvkXV9hEl2uk2Yqtpd8vmp+vECq1FdEpNyt
 +t7Tdi/QrZFRJra+p/IErXtFNXnGiedN9ipq4PuF/2VNyTAc3ie975rtKnr9QVmCRvuc
 w9pw==
X-Forwarded-Encrypted: i=1;
 AL+hErHG2s66kcaMX4Fm4kdENNQfT5Xcyzw8q9E33/9pxR7gGeu/liWX48nJyIE7YEtzNNuzM1aFfHc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8SwiA1Di02VLUiT5VvSj8NfIl6uP0u5DlpSiu5V/1uYyXqIGgs
 skidBTRvPE3l4lIseKEfAo54sLVlHd5tbNN/oCh0rzm1vc8MruL1+8go
X-Gm-Gg: AYBFou2zY8JpfJCJFfAgbJ//Di0Q/7dqfrZMGDRJ5rjY3YoE3gV6KGBDMfKDutKJ7VK
 3f+EVTR/T7BU/tOK6Kn0hqMCuwTOTOsGK5A+lcyeoi99eAicDRtQigaotRpDYt+enBmD0u0Nb1c
 /yDtdNU9MMt6noeu/nBGE/sjU4e7pJDMDfVZZ/ydp1ucgJGoWC2UbFeZ+bHdnZgidcTEU2rtsWX
 FWxRm5ykNF5k8k2oRui1TCfu3ZXVHmwD6HqfmgVbxMAO/6k6+zuU013fknQ4VqgULfG+HexXNxs
 ItQuEURguNLemu/WW+spjGtabmhpAp9rYZM9CpcwOy2z0x2Um+LpUwNK+pYRBl7XeeDK8u0ei65
 O4ymGBjxlJzR+d5mxDLYEKM5fm29f8XNW5/vd+BPnA1l4NndZA2Ra3OfG9UpdPv8a+Mcsgtb7PA
 wX+lHlipZ4bJjJH04YxZgcSQnI1m/1fuuswXC9rlK/bkvfuKXMfGtSX4hS69LCr910EVz+UjlVf
 fYkPCOnvDd0msGyZ+9gkjj59H74acr2DIs3MeiXIEgI9LtcsQXseISs3DiV1xFIAtvDxdFmgAbp
 36U6SomfcvUv1+MkUZiHnPLeY4lCVKAo2H3GEG84LRFYkVd6T3gRAQh8gcXBxV6aYt5DMbuYKE/
 5mJYncFM+JfwNdI6jGjQ8JiEUPOFvSsP4kQ==
X-Received: by 2002:a05:600c:608e:b0:49e:795e:ba89 with SMTP id
 5b1f17b1804b1-4bb783aecfcmr59130285e9.6.1794918459964; 
 Tue, 17 Nov 2026 04:27:39 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-92-103.ip49.fastwebnet.it.
 [93.34.92.103]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm5243151f8f.34.2026.11.17.04.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:27:39 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>,
 Vincent Jardin <vjardin@free.fr>, Martin Schwan <m.schwan@phytec.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v12 9/9] test: dm: Add test for FW Loader feature
Date: Tue, 17 Nov 2026 13:27:14 +0100
Message-ID: <20261117122715.7983-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117122715.7983-1-ansuelsmth@gmail.com>
References: <20261117122715.7983-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add basic test for FW Loader feature for the Filesystem way and FIP.

Additional MMC testing image are added that loads a dummy firmware.bin in
a fat partition or a simple FIP blob.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts          |  38 +++++
 configs/sandbox64_defconfig        |   2 +
 configs/sandbox_defconfig          |   2 +
 configs/sandbox_flattree_defconfig |   2 +
 configs/sandbox_noinst_defconfig   |   2 +
 configs/sandbox_spl_defconfig      |   4 +
 configs/sandbox_vpl_defconfig      |   4 +
 test/dm/Makefile                   |   1 +
 test/dm/fw_loader.c                | 254 +++++++++++++++++++++++++++++
 test/py/tests/test_ut.py           |  58 +++++++
 10 files changed, 367 insertions(+)
 create mode 100644 test/dm/fw_loader.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 02a9ca29b792..bcdfeee91b9d 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -190,6 +190,18 @@
 		};
 	};
 
+	fs_loader: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		phandlepart = <&mmc13 1>;
+	};
+
+	fip_loader: fip-loader {
+		bootph-all;
+		compatible = "u-boot,fip-loader";
+		phandlepart = <&mmc14 1>;
+	};
+
 	cedit: cedit {
 	};
 
@@ -1406,6 +1418,20 @@
 		filename = "mmc12.img";
 	};
 
+	/* This is used for FS Loader tests */
+	mmc13: mmc13 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc13.img";
+	};
+
+	/* This is used for FIP Loader tests */
+	mmc14: mmc14 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc14.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
@@ -2165,6 +2191,18 @@
 		ethphy1: ethernet-phy@1 {
 			reg = <1>;
 		};
+
+		ethernet-phy@2 {
+			reg = <2>;
+
+			firmware-loader = <&fs_loader>;
+		};
+
+		ethernet-phy@3 {
+			reg = <3>;
+
+			firmware-loader = <&fip_loader>;
+		};
 	};
 
 	pm-bus-test {
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index c54e1d8141b8..820cc12c19b9 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -176,6 +176,8 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 9bc64d898fac..f61932992361 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -261,6 +261,8 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
 CONFIG_SPI_EEPROM=y
 CONFIG_MMC_PCI=y
 CONFIG_MMC_SANDBOX=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 0b048ac085b7..d1a61538317d 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -139,6 +139,8 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_BOOTDEV_SPI_FLASH=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 7d5c91cf30c1..6cb42561d8cd 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -174,7 +174,9 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_LOADER=y
+CONFIG_SPL_FIP_LOADER=y
 CONFIG_SPL_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_DM_MTD=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 83808c94283f..9b4d7245af1b 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -154,6 +154,10 @@ CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FIP_LOADER=y
+CONFIG_SPL_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 1aa4f37b8e93..a050fe83ba0b 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -161,6 +161,10 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FIP_LOADER=y
+CONFIG_SPL_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 112326c85bbb..12066af6c3e8 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
 endif
+obj-$(CONFIG_FW_LOADER_UCLASS) += fw_loader.o
 obj-$(CONFIG_FIRMWARE) += firmware.o
 obj-$(CONFIG_DM_FPGA) += fpga.o
 obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
new file mode 100644
index 000000000000..ffc0a5876f00
--- /dev/null
+++ b/test/dm/fw_loader.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/lists.h>
+#include <dm/test.h>
+#include <fw_loader.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* uuidgen -n @dns --md5 --name test = 45a113ac-c7f2-30b0-90a5-a399ab912716*/
+#define TEST_UUID	"45a113ac-c7f2-30b0-90a5-a399ab912716"
+#define TEST_INVAL_UUID	"300b74d6-cc34-4e68-ba5d-733157f633f7"
+
+static int bind_mmc(struct unit_test_state *uts, const char *mmc)
+{
+	struct udevice *dev;
+	ofnode root, node;
+
+	/* Enable the mmc node for this test */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, mmc);
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	return 0;
+}
+
+static int fw_loader_get_dev(struct unit_test_state *uts,
+			     const char *name, struct udevice **devp)
+{
+	struct udevice *mdio_dev;
+	ofnode mdio_node, phy_node;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MDIO, "mdio-test",
+					      &mdio_dev));
+
+	mdio_node = dev_ofnode(mdio_dev);
+	ut_assert(ofnode_valid(mdio_node));
+
+	phy_node = ofnode_find_subnode(mdio_node, name);
+	ut_assert(ofnode_valid(phy_node));
+
+	return get_fw_loader_from_node(phy_node, devp);
+}
+
+static int dm_test_fs_loader_get(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = fw_loader_get_dev(uts, "ethernet-phy@1", &fw_loader_dev);
+	ut_asserteq(-ENODEV, ret);
+	ut_assertnull(fw_loader_dev);
+
+	fw_loader_dev = NULL;
+	ret = fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc14"));
+
+	ret = fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get, UTF_SCAN_FDT);
+
+static int dm_test_fs_loader_get_fw_size(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(15, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get_fw_size, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get_fw_size(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc14"));
+
+	ret = fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, TEST_UUID);
+	ut_asserteq(5, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get_fw_size, UTF_SCAN_FDT);
+
+static int dm_test_fs_loader_get_fw_in_buf(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int firmware_size = 15;
+	char *buf;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(firmware_size, ret);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware2.bin");
+	ut_asserteq(-ENOENT, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	/* Normal read */
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+	ut_asserteq_mem("This is a test\n", buf, firmware_size);
+
+	/* Read up to size */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size - 5, 0);
+	ut_asserteq(firmware_size - 5, ret);
+	ut_asserteq_mem("This is a \0\0\0\0\0", buf, firmware_size);
+
+	/* Read at offset */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size - 10, 10);
+	ut_asserteq(firmware_size - 10, ret);
+	ut_asserteq_mem("test\n\0\0\0\0\0\0\0\0\0\0", buf, firmware_size);
+
+	/* Read at offset with bigger buffer but firmware ends */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, 10);
+	ut_asserteq(firmware_size - 10, ret);
+	ut_asserteq_mem("test\n\0\0\0\0\0\0\0\0\0\0", buf, firmware_size);
+
+	/* Read at offset equal to firmware size */
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	/* Read at offset beyond firmware size */
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size + 1);
+	ut_asserteq(-EINVAL, ret);
+
+	/* Non existent file */
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware2.bin",
+					buf, firmware_size, 0);
+	ut_asserteq(-ENOENT, ret);
+
+	free(buf);
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get_fw_in_buf, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get_fw_in_buf(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int firmware_size = 5;
+	char *buf;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc14"));
+
+	ret = fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, TEST_UUID);
+	ut_asserteq(firmware_size, ret);
+
+	ret = request_firmware_size(fw_loader_dev, TEST_INVAL_UUID);
+	ut_asserteq(-ENOENT, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	/* Normal read */
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+	ut_asserteq_mem("test\n", buf, firmware_size);
+
+	/* Read up to size */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size - 1, 0);
+	ut_asserteq(firmware_size - 1, ret);
+	ut_asserteq_mem("test\0", buf, firmware_size);
+
+	/* Read at offset */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size - 2, 2);
+	ut_asserteq(firmware_size - 2, ret);
+	ut_asserteq_mem("st\n\0\0", buf, firmware_size);
+
+	/* Read at offset with bigger buffer but firmware ends */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size, 2);
+	ut_asserteq(firmware_size - 2, ret);
+	ut_asserteq_mem("st\n\0\0", buf, firmware_size);
+
+	/* Read at offset equal to firmware size */
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	/* Read at offset beyond firmware size */
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size, firmware_size + 1);
+	ut_asserteq(-EINVAL, ret);
+
+	/* Non existent file */
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_INVAL_UUID,
+					buf, firmware_size, 0);
+	ut_asserteq(-ENOENT, ret);
+
+	free(buf);
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get_fw_in_buf, UTF_SCAN_FDT);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 10311e1c1829..8ed9d63e8c0c 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -14,6 +14,7 @@ import struct
 import os.path
 import re
 import pytest
+import uuid
 
 import utils
 # pylint: disable=E0611
@@ -558,6 +559,61 @@ def test_ut_dm_init(ubman):
     with open(fn, 'wb') as fh:
         fh.write(data)
 
+def setup_fw_loader_fs_image(ubman):
+    """Create a 2MB disk image with a dummy firmware on it"""
+    mmc_dev = 13
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0xc, img_size=2)
+
+    fw = os.path.join(mnt, 'firmware.bin')
+    data = b'This is a test\n'
+    with open(fw, 'wb') as fh:
+        fh.write(data)
+
+    fsfile = 'vfat1M.img'
+    utils.run_and_log(ubman, f'fallocate -l 1M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+    copy_partition(ubman, fsfile, fname)
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
+
+
+def setup_fw_loader_fip_image(ubman):
+    """Create a 2MB disk image with a FIP blob on it"""
+    mmc_dev = 14
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0x83, img_size=2)
+
+    fw_name = 'test'
+    data = b'test\n'
+
+    fip_toc_header_size = struct.calcsize('<IIQ')
+    fip_toc_entry_uuid = uuid.uuid3(uuid.NAMESPACE_DNS, fw_name)
+    fip_toc_entry_size = len(fip_toc_entry_uuid.bytes) + struct.calcsize('<QQQ')
+
+    fipfile = 'test.fip'
+    with open(fipfile, 'wb') as fh:
+        # TOC Header: name, serial, flags
+        fh.write(struct.pack('<IIQ', 0xaa640001, 0x12345678, 0))
+
+        # TOC Entry: UUID, offset, size, flags
+        fh.write(fip_toc_entry_uuid.bytes +
+            struct.pack('<QQQ',
+                fip_toc_header_size + 2 * fip_toc_entry_size,
+                len(data), 0))
+
+        # TOC Entry End Marker: Zero UUID + offset set to size of entire FIP
+        # Assume alignment as 1
+        fh.write(uuid.UUID(int=0).bytes +
+            struct.pack('<QQQ',
+                fip_toc_header_size + 2 * fip_toc_entry_size + len(data),
+                0, 0))
+
+        # Append data
+        fh.write(data)
+
+    copy_partition(ubman, fipfile, fname)
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fipfile}')
 
 def setup_efi_image(ubman):
     """Create a 20MB disk image with an EFI app on it"""
@@ -625,6 +681,8 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
     setup_android_image(ubman)
+    setup_fw_loader_fs_image(ubman)
+    setup_fw_loader_fip_image(ubman)
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
     setup_bls_prefix_image(ubman)
-- 
2.55.0

