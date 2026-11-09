Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D37606A331
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JCgdbCat;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Y6os6sSg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62F4580F80;
	Mon,  9 Nov 2026 21:49:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2HJyXjYE-cnD; Mon,  9 Nov 2026 21:49:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7C2480FF3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260945;
	b=q8LLhKfaQ3HyhKM1rbreapzhR8Pv8ZzWLjjIugDdHrMQMCoPhMnRARQ/4KFESNWYEjIR
	 fWP1EILKGM44U1Rue76LaRSWK1WWd2Az2AA6RDbB1Asn5YmT1TfnKbZWvtj1CIsBR80XQ
	 7ONPdDcZpRBuB1+wcypFvoRTD4G0gBg9A3cIkqyKsL0ATar6sKPc4tglN3oP3kqP4q2/I
	 zrzBtz/+Sa8xkrDDH5WF+XHi4vY9GOcf7t0enf5se2uI4FrSf0/f5eWBP1tcMl8CalHp7
	 nJO5XVTGHfYgPhmV5U+IM4qJGEe9S87fZpVRy/PUR7BuK2W53fBRt2X4sEpzWDfQ8/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=S8VEWR97QBbNN+w3QqQNiZ8R0UoVVFVUZXVbsWqvwOw=;
	b=s2xDBWmw1cF8ctS/zA2+CkMKfN+y3SL2bWRV+RNb102kgjU/PHnCbxArw/QfQD+1q1uE
	 FR9lPXWMf4h3+tudtbwXahHC5XWKwQgoubZWZCd/T4M+aq9xRCaqHTIGIqXrw4LFxRTMH
	 ruAKtfy2usbfn/ApQ9J6249G2K3U5QBdJV+joRtkK11rpvjCZxZ/fs0jpcQTM9Y34mpbj
	 WoK+62NFCMmDXix/WRDUso5BdEqb6CIWcH+aUyIwOPoy3H/RH1zTGth+tWAZobF9fwQye
	 Fus1AXpD43bg9wARd516dBxmiav6R16IhAT+/c4oRpuO09XoQNvw3rM6luNHbHQuhFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260945;
	bh=S8VEWR97QBbNN+w3QqQNiZ8R0UoVVFVUZXVbsWqvwOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JCgdbCat72h9j5JCxyrFETlsNAJzmeuJTCWGr7Y7uFIXNLZTyVP/z703sFfw/JLrG
	 3Ek49iap1UIURpIyKIy9stdP2H4+0S4uf4MXXqIVOSbdZmUr3K2+xs74kgQFIB2cgV
	 WI18qHi6XCE4fRsahRGY3SQWYKaH6htFYlGLMRVItYEQbzkWJxpM7O19oT2pnbKqzl
	 lL194l4g5SKyRC9RZRdPEqUrWDThD4eeuBTCBR1ratNfkM2+aqaEpghzgmPNwNvemP
	 kOVmFC9P/E7CKANRkuUFwIcUIA/el45YKDhyrwVe3CAmbsAO5w0POJ1Ddze4ThU7bZ
	 hsO2ajnnQeC2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7C2480FF3;
	Mon,  9 Nov 2026 21:49:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFA8E731
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B36C040805
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqz--fxbpQYQ for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:49:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 277BF40764
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Y6os6sSg
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 277BF40764
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:49:01 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so878974f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260940; x=1794865740;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S8VEWR97QBbNN+w3QqQNiZ8R0UoVVFVUZXVbsWqvwOw=;
 b=Y6os6sSgaz+sKEe+m7MFhkkqJiN4JMxHPRy36USjPcYYO8DxIdmUxh6/axQ+2Idp30
 InV2LWKL5sGqEKbpmOoMV38/78AXuby4pIMejgUduk14Q7QVby8T39jbRhAH5LljOPUR
 1vcPyCk9SmUIuPWf3zGyCcSdkyupMfOGd4W2dtXK2xMkUmMVJsLwHVNLiuM87CZACmxs
 EuyRoyeyCKn6aPdwg88BSoDTOVaJKbmopK4k81BkSUF8oFcaCPZI9wKnl1jkt419paU3
 cWUl+MJB7k41Jzom/i5z/opbggI3IqRWIEBNLoXsdm/tVoQBhmI7XovG0XzRXxGtxRsZ
 VuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260940; x=1794865740;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S8VEWR97QBbNN+w3QqQNiZ8R0UoVVFVUZXVbsWqvwOw=;
 b=H9R6pGrkRGuNQ5+wQ2/sqQcH0unjusYtFVW4ODRQq3vmoHpZ1uYLsByEdw31xdqKlL
 d7c1wood0tyfLOTByuRkeDYBEHqGM+ukRzxGsBNheizCbeXPbeN1+rb0acna4O+A/hrS
 k4DKYP+hwihycWhb5YEVzZCwFREZFvQrtW/6tVyWmCdcG6+jI4OKXO3r8Cd6rFedrzYc
 /neW1hAqT9W0B2rS3eR11dsWywvX0O0DPgRUp0sVBKiYisevFNL8EK+pP/r/2qpR8KuA
 vEhxBFw6azqaRF14tKWjwCCLzW3hXpMQ0Ppiu1HR3zsG7Kqbfvryp2PJ4jpqaYmZPlxy
 6gNA==
X-Forwarded-Encrypted: i=1;
 AL+hErH33kA+f0O2Qn4Dft2o73YyGzsualRGQWW9FZwF5yAy8ZLQppK62JgbJUOIsoxVrvyaqL1ohao=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9knHQzpgLkwT9GMJ04v71it9oB++TVFbHkqDb7FQj8K05U6rpW
 tRE+QrmfsxyOWv4lQrs6IW5QB56aHfYK7wUYKobHuaQLCpjEybS2GptC/eDHnPZG9uY=
X-Gm-Gg: AYBFou0czqXkOsQU2zxGEpYI21NxQCa3HIWIlOU/2PSiRuQrMfUqQxTbT1O+Z6shE9B
 NKqr6g/ggPw0LDWym9LMzGBvB7a7yb4XHGfwrsHdkyLUIVm0+1XaMJU2pU2fFuPgA8S0JzjHgUw
 +rtsw8QhSca9EPf0MSz0A7PBHlVvmdi7GjPu0UIpS3atgoGNM621q1RGSYIom38sS9kg7x7W96u
 HyjCh9HuuiMuhgce684mUhFG0tTCKq5XxXC3aDGisoRg6oILwgTGQiyJ1nDfn5p3fQF0q5AYQEY
 e+PyhQgB3qP2bDjokah43k82w0i3zV9PoWTLN7iNch0hdnuDsDn+i4j2qxtWBMfh1mCOyoXoY2D
 DhHFbh8IhB/lt6QmK4CRKB0hOhdul0tBwgkj95fzZw5eZr/0nB1vxR9/DIhTQg7kYSVnrOvSstU
 WmS1N8qDLUvEyWzrCPXfiNg/74zJnAu1cDIATR6nNachYkWvSXZsD9zI+TRqLYTX15D/+A7XdFn
 8sV1LmfY1jz3aldSmIUM71ckSQi33vZngaJVZk3+k/kser9lzD9Uv1tQHz1ccvcty4V9nVsTj6f
 ZOS2NOrjfhgL5yHmrvL0kBI04obTaHHFwz1XqNEOW5a9di46ULZrWtv5i7izZw6cN3sbLOebl1u
 U34HZkQe99nCwSgCMmA==
X-Received: by 2002:a5d:5e02:0:b0:48e:127a:c914 with SMTP id
 ffacd0b85a97d-4982e362acfmr1274435f8f.5.1794260939807; 
 Mon, 09 Nov 2026 13:48:59 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm1169903f8f.31.2026.11.09.13.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:48:59 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 09 Nov 2026 22:48:23 +0100
Subject: [PATCH v4 6/7] cmd: fdt: add 'fdt fit' to prepare a devicetree for
 other boot commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ccaione-upstream-fdt-fit-v4-6-5323cbfcc9f3@baylibre.com>
References: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
In-Reply-To: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
To: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.16.0
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

A board may keep its devicetree and overlays in a FIT while booting
a kernel or EFI application from elsewhere. Boot scripts need a way
to verify and assemble that devicetree without asking bootm to boot
the FIT.

Add fdt fit to prepare the devicetree described by one FIT
configuration and copy it to an address chosen by the script. The
result can then be passed to bootefi, booti or another boot command.

Always check image hashes and enforce any required configuration
signatures, even when verify=no. Reject chained configurations:
signing each configuration separately does not authenticate the
combination.

Only copy the completed result after verification, overlay
application and destination checks succeed. The script remains
responsible for loading the FIT and stopping the boot on failure.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/Kconfig           |  9 ++++++
 cmd/fdt.c             | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/fdt.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7124b961dc2..c81534810c5 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -577,6 +577,15 @@ config CMD_FDT
 	help
 	  Do FDT related setup before booting into the Operating System.
 
+config CMD_FDT_FIT
+	bool "fdt fit - load the devicetree of a FIT configuration"
+	depends on CMD_FDT && FIT
+	imply OF_LIBFDT_OVERLAY
+	help
+	  Add the 'fdt fit' subcommand, which loads the devicetree of a FIT
+	  configuration, applies the overlays the configuration lists and
+	  copies the result to a given address.
+
 config CMD_EXTENSION
 	bool "Extension board management command"
 	select CMD_FDT
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 7e2abf96103..54d54eae118 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -11,6 +11,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <image.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
@@ -145,6 +146,79 @@ static int fdt_get_header_value(int argc, char *const argv[])
 	return CMD_RET_FAILURE;
 }
 
+/*
+ * fdt fit <addr>[#<conf>] <dest> [<length>]
+ *
+ * Load the devicetree of a FIT configuration, with its overlays applied, and
+ * copy it to <dest>. Images are always verified, so the configuration must
+ * also satisfy any required signature in the control devicetree. Unlike bootm,
+ * image load addresses are ignored and configurations cannot be chained.
+ */
+static int fdt_fit(int argc, char *const argv[])
+{
+	struct bootm_headers images = { .verify = 1 };
+	const char *conf = NULL;
+	ulong addr, dest, data, len;
+	bool caller_must_free_data;
+	void *fdt;
+	int ret, err;
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	if (!fit_parse_conf(argv[0], image_load_addr, &addr, &conf))
+		addr = hextoul(argv[0], NULL);
+	dest = hextoul(argv[1], NULL);
+
+	/* Only a single configuration authenticates the whole combination */
+	if (conf && strchr(conf, '#')) {
+		puts("Chained configurations are not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (boot_get_fdt_fit(&images, addr, NULL, &conf, IH_ARCH_DEFAULT,
+			     FIT_LOAD_PREPARE, &data, &len,
+			     &caller_must_free_data) < 0)
+		return CMD_RET_FAILURE;
+
+	fdt = map_sysmem(data, len);
+	ret = CMD_RET_FAILURE;
+	if (fdt_check_full(fdt, len)) {
+		puts("Invalid FDT in FIT\n");
+		goto out;
+	}
+
+	len = fdt_totalsize(fdt);
+	if (argc > 2) {
+		ulong newlen = hextoul(argv[2], NULL);
+
+		if (newlen < len) {
+			printf("New length 0x%lX < existing length 0x%lX, aborting.\n",
+			       newlen, len);
+			goto out;
+		}
+		len = newlen;
+	}
+
+	if (CONFIG_IS_ENABLED(LMB) && lmb_read_check(dest, len)) {
+		puts("ERROR: trying to overwrite reserved memory...\n");
+		goto out;
+	}
+
+	err = fdt_open_into(fdt, map_sysmem(dest, len), len);
+	if (err) {
+		printf("libfdt fdt_open_into(): %s\n", fdt_strerror(err));
+		goto out;
+	}
+	ret = CMD_RET_SUCCESS;
+
+out:
+	if (caller_must_free_data)
+		free(fdt);
+
+	return ret;
+}
+
 /*
  * Flattened Device Tree command, see the help for parameter definitions.
  */
@@ -281,6 +355,10 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_SUCCESS;
 	}
 
+	/* Load the devicetree of a FIT configuration */
+	if (IS_ENABLED(CONFIG_CMD_FDT_FIT) && strncmp(argv[1], "fi", 2) == 0)
+		return fdt_fit(argc - 2, argv + 2);
+
 	if (!working_fdt) {
 		puts("No FDT memory address configured. Please configure\n"
 		     "the FDT address via \"fdt addr <address>\" command.\n"
@@ -1124,6 +1202,11 @@ U_BOOT_LONGHELP(fdt,
 #endif
 #ifdef CONFIG_OF_SYSTEM_SETUP
 	"fdt systemsetup                     - Do system-specific set up\n"
+#endif
+#ifdef CONFIG_CMD_FDT_FIT
+	"fdt fit    <addr>[#<conf>] <dest> [<length>] - Load the fdt of a FIT\n"
+	"                                      configuration, apply its overlays and\n"
+	"                                      copy it to <dest>\n"
 #endif
 	"fdt move   <fdt> <newaddr> <length> - Copy the fdt to <addr> and make it active\n"
 	"fdt resize [<extrasize>]            - Resize fdt to size + padding to 4k addr + some optional <extrasize> if needed\n"
diff --git a/doc/usage/cmd/fdt.rst b/doc/usage/cmd/fdt.rst
index 493ed895bc7..88222a9939d 100644
--- a/doc/usage/cmd/fdt.rst
+++ b/doc/usage/cmd/fdt.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     fdt addr [-cq] [addr [len]]
+    fdt fit <addr>[#<conf>] <dest> [<len>]
 
 Description
 -----------
@@ -48,6 +49,46 @@ If the `len` argument is provided, then the device tree is expanded to that
 size. This can be used to make space for more nodes and properties. It is
 assumed that there is enough space in memory for this expansion.
 
+fdt fit
+~~~~~~~
+
+This loads the device tree of a FIT configuration and copies it to `dest`. The
+FIT must already be in memory at `addr`.
+
+The configuration `conf` is selected as for the bootm command. If it is
+omitted, the configuration matching the control FDT is used when
+CONFIG_FIT_BEST_MATCH is enabled, otherwise the default configuration of the
+FIT. The `fdt` property of the configuration lists a base device tree followed
+by any overlays: the base device tree is loaded and the overlays are applied to
+it in order.
+
+Each image is checked against its hashes, whatever the value of the `verify`
+environment variable. With CONFIG_FIT_SIGNATURE, the configuration must also
+satisfy the signature policy of the control FDT, so an unsigned configuration
+is rejected when a key has `required = "conf"`. A configuration signature
+covers the hashes of all the images listed by the configuration, so it
+authenticates the base device tree, the overlays and their order as one unit.
+
+Unlike bootm, the command does not accept further configurations appended to
+`conf` with `#`. Each of them would be verified on its own, so a chain could
+combine device trees in a way which no configuration lists and nobody signed.
+List each valid combination of a base device tree and overlays in its own
+configuration instead.
+
+The command fails if any image cannot be loaded, verified or applied, and
+nothing is written to `dest` in that case. Unlike bootm, the command ignores
+FIT image `load` addresses: only the completed device tree is copied to
+`dest`, after checking that the destination does not overlap reserved memory
+when CONFIG_LMB is enabled. Alignment and decompression of the base device
+tree are still handled as needed.
+
+If the `len` argument is provided, then the device tree is expanded to that
+size, leaving space for later changes. The command fails if `len` is smaller
+than the device tree. Without `len`, the device tree is copied at its own size.
+The working FDT is not changed; use `fdt addr` to select the result.
+
+This subcommand requires CONFIG_CMD_FDT_FIT.
+
 Example
 -------
 
@@ -66,3 +107,37 @@ address and expand it to 0xf000 in size::
     Working FDT set to 10000
     => md 10000 4
     00010000: edfe0dd0 00f00000 78000000 7c270000  ...........x..'|
+
+Load a FIT holding a device tree and its overlays, then copy the device tree of
+the `conf-a` configuration, a base device tree with one overlay, to 2000000 and
+inspect it::
+
+    => load mmc 0#firmware 1000000 fdt.itb
+    1771 bytes read in 1 ms (1.7 MiB/s)
+    => fdt fit 1000000#conf-a 2000000
+    ## Loading fdt (any) from FIT Image at 01000000 ...
+       Using 'conf-a' configuration
+       Verifying Hash Integrity ... OK
+       Trying 'base' fdt subimage
+       ...
+       Verifying Hash Integrity ... sha256+ OK
+    ## Loading fdt (any) from FIT Image at 01000000 ...
+       Trying 'ov-a' fdt subimage
+       ...
+       Verifying Hash Integrity ... sha256+ OK
+    => fdt addr 2000000
+    Working FDT set to 2000000
+    => fdt print /test-node
+    test-node {
+            ov-a-prop = "ov-a-value";
+            base-prop = "base-value";
+            order = "ov-a";
+    };
+
+A boot script can prepare a device tree kept with the firmware in this way and
+pass it to the boot command, stopping if any step fails::
+
+    if load mmc 0#firmware ${loadaddr} fdt.itb &&
+       fdt fit ${loadaddr}#conf-a ${fdt_addr_r}; then
+            bootefi bootmgr ${fdt_addr_r}
+    fi

-- 
2.56.0

